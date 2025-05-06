// const { expect } = require("chai");
// const { ethers } = require("hardhat");

// describe("SoulboundNFT contract", function () {
//   let owner, user1, user2, soulboundNFT;

//   beforeEach(async () => {
//     [owner, user1, user2] = await ethers.getSigners();

//     const SoulboundNFT = await ethers.getContractFactory("SoulboundNFT");
//     soulboundNFT = await SoulboundNFT.deploy("ZK-SoulID", "ZKSID");
//     await soulboundNFT.waitForDeployment();
//   });

//   it("Should mint a soulbound token to user", async () => {
//     const uri = "ipfs://QmTestMetadataHash";
//     await soulboundNFT.connect(owner).mintSoulbound(user1.address, uri);

//     expect(await soulboundNFT.ownerOf(0)).to.equal(user1.address);
//     expect(await soulboundNFT.tokenURI(0)).to.equal(uri);
//   });

//   it("Should not allow transferFrom", async () => {
//     await soulboundNFT
//       .connect(owner)
//       .mintSoulbound(user1.address, "ipfs://hash");

//     await expect(
//       soulboundNFT.connect(user1).transferFrom(user1.address, user2.address, 0)
//     ).to.be.revertedWith("Soulbound:Transfer not allowed");
//   });
// });
