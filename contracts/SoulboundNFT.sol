// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract SoulboundNFT is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;

    mapping(address => bytes32) identityRoots;

    constructor(
        string memory name,
        string memory symbol
    ) ERC721(name, symbol) Ownable(msg.sender) {}

    ///@notice Mint a soulbound token to a user with Metadata (IPFS URI or Identity hash)
    function mintSoulbound(
        address user,
        string memory metadataHash,
        bytes32 merkleRoot
    ) external onlyOwner {
        uint256 tokenId = nextTokenId++;
        _safeMint(user, tokenId);
        _setTokenURI(tokenId, metadataHash); //Can be IPFS URI or identity hash

        identityRoots[user] = merkleRoot;
    }

    ///@dev Override transfer hook introduced in OZ v5
    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal override returns (address) {
        address from = _ownerOf(tokenId);
        require(
            from == address(0) || to == address(0),
            "Soulbound:tokens are non-transferable"
        );
        return super._update(to, tokenId, auth);
    }

    function approve(
        address to,
        uint256 tokenId
    ) public pure override(ERC721, IERC721) {
        revert("Soulbound:Approval not allowed");
    }

    function setApprovalForAll(
        address operator,
        bool approved
    ) public pure override(ERC721, IERC721) {
        revert("Soulbound:Approval not allowed");
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public pure override(ERC721, IERC721) {
        revert("Soulbound:Transfer not allowed");
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) public override(ERC721, IERC721) {
        revert("Soulbound: Transfer not allowed");
    }
}
