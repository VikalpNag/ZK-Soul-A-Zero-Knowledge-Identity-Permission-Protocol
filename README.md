# 🧠 ZK-Soul: Zero-Knowledge Identity & Permission Protocol

ZK-Soul is a smart contract protocol built on top of **Soulbound NFTs** that represent non-transferable, on-chain identities. The project aims to provide decentralized identity primitives with zero-knowledge compatibility, useful for DAO governance, permissioned access, and secure identity verification.

---

## 🔗 Live Modules (So Far)

| Contract       | Description                                                         |
| -------------- | ------------------------------------------------------------------- |
| `SoulboundNFT` | ERC-721-based Soulbound NFT (ERC-5484-style) to represent identity. |

---

---

## 🔧 Tech Stack

- **Solidity (0.8.x)**
- **Hardhat**
- **Ethers.js**
- **Chai + Mocha for Testing**
- **IPFS (metadata hash / URI support)**
- **OpenZeppelin Contracts**

---

## ⚙️ Features

- ✅ ERC721-compatible Soulbound NFT
- ✅ Metadata hash or IPFS URI for identity
- ✅ Non-transferable (`transferFrom`, `approve`, etc. overridden)
- ✅ Owner-only `mintSoulbound()` function
- ✅ Fully tested with Hardhat

---

## 🚀 Getting Started

### 1. Install Dependencies

```bash
npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox @openzeppelin/contracts
```

## Compile contracts

```bash
npx hardhat compile
```

## Test contracts

```bash
npx hardhat test
```

## Sample Usage

```bash
const nft = await ethers.deployContract("SoulboundNFT", ["ZK-SoulID", "ZKSID"]);
await nft.mintSoulbound(user.address, "ipfs://QmYourMetadataHash");

```
