// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract SoulboundNFT is ERC721URIStorage, Ownable {
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

    ///@dev Override all transfer-related functions to prevent transfers
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override {
        require(
            from == address(0) || to == address(0),
            "Soulbound:Tokens are non-transferable"
        );
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function approve(address to, uint256 tokenId) public virtual override {
        revert("Soulbound:Approval not allowed");
    }

    function setApprovalForAll(
        address operator,
        bool approved
    ) public virtual override {
        revert("Soulbound:Approval not allowed");
    }
}
