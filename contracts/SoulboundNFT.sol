// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SoulboundNFT is ERC721, Ownable {
    uint256 public nextTokenId;

    constructor(
        string memory name,
        string memory symbol
    ) ERC721(name, symbol) Ownable(msg.sender) {}

    ///@notice Mint a soulbound token to a user with Metadata (IPFS URI or Identity hash)
    function mintSoulbound(
        address user,
        string memory metadataHash
    ) external onlyOwner {
        uint256 tokenId = nextTokenId++;
        _safeMint(user, tokenId);
        _setTokenURI(tokenId, metadataHash); //Can be IPFS URI or identity hash
    }
}
