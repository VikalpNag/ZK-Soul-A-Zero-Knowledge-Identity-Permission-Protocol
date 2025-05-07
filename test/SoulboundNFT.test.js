const { expect } = require("chai");
const { ethers } = require("hardhat");
const {
  root: merkleRoot,
  proof,
  tree,
  credentials,
  leaves,
  root,
} = require("../scripts/generateMerkleTree.js");
const keccak256 = require("keccak256");

describe("SoulboundNFT contract", function () {
  let owner, user1, user2, soulboundNFT;

  beforeEach(async () => {
    [owner, user1, user2] = await ethers.getSigners();

    const SoulboundNFT = await ethers.getContractFactory("SoulboundNFT");
    soulboundNFT = await SoulboundNFT.deploy("ZK-SoulID", "ZKSID");
    await soulboundNFT.waitForDeployment();
  });

  it("Should mint a soulbound token to user", async () => {
    const uri = "ipfs://QmTestMetadataHash";
    await soulboundNFT
      .connect(owner)
      .mintSoulbound(user1.address, uri, merkleRoot);

    expect(await soulboundNFT.ownerOf(0)).to.equal(user1.address);
    expect(await soulboundNFT.tokenURI(0)).to.equal(uri);
  });

  it("Should not allow transferFrom", async () => {
    await soulboundNFT
      .connect(owner)
      .mintSoulbound(user1.address, "ipfs://hash", merkleRoot);

    await expect(
      soulboundNFT.connect(user1).transferFrom(user1.address, user2.address, 0)
    ).to.be.revertedWith("Soulbound:Transfer not allowed");
  });

  it("Should not allow approve", async () => {
    await soulboundNFT
      .connect(owner)
      .mintSoulbound(user1.address, "ipfs://hash", merkleRoot);
    await expect(
      soulboundNFT.connect(user1).approve(user2.address, 0)
    ).to.be.revertedWith("Soulbound:Approval not allowed");
  });

  it("Should not allow setApprovalForAll", async () => {
    await expect(
      soulboundNFT.connect(user1).setApprovalForAll(user2.address, true)
    ).to.be.revertedWith("Soulbound:Approval not allowed");
  });

  it("Should not allow safeTransferFrom", async () => {
    await soulboundNFT
      .connect(owner)
      .mintSoulbound(user1.address, "ipfs://hash", merkleRoot);
    await expect(
      soulboundNFT
        .connect(user1)
        .safeTransferFrom(user1.address, user2.address, 0)
    ).to.be.revertedWith("Soulbound: Transfer not allowed");
  });

  it("Only owner can mint", async () => {
    await expect(
      soulboundNFT
        .connect(user1)
        .mintSoulbound(user2.address, "ipfs://hash", merkleRoot)
    ).to.be.revertedWithCustomError(soulboundNFT, "OwnableUnauthorizedAccount");
  });
});

//MERKLE TREE SYSTEM
describe("Merkle Tree Credential System", function () {
  let owner, user1, user2, soulboundNFT;

  beforeEach(async () => {
    [owner, user1, user2] = await ethers.getSigners();

    const SoulboundNFT = await ethers.getContractFactory("SoulboundNFT");
    soulboundNFT = await SoulboundNFT.deploy("ZK-SoulID", "ZKSID");
    await soulboundNFT.waitForDeployment();
  });

  it("Should store correct root on mint", async () => {
    await soulboundNFT.mintSoulbound(user1.address, "ipfs://hash", merkleRoot);
    const onChainRoot = await soulboundNFT.identityRoots(user1.address);
    expect(onChainRoot).to.be.equal(merkleRoot);
  });

  it("Should validate proof off-chain", async () => {
    const leaf = keccak256("age:23");
    const verified = tree.verify(proof, leaf, root);
    expect(verified).to.be.true;
  });
});
