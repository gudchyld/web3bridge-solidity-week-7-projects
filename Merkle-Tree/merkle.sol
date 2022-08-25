// SPDX-License-Identifier: GPL-3.0;
pragma solidity ^ 0.8.7;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract WhitelistSale is ERC721 {
  bytes32 public merkleRoot;
  uint256 public nextTokenId;
  mapping(address => bool) public claimed;

  constructor(bytes32 _merkleRoot) ERC721("ExampleNFT", "NFT") {
    merkleRoot = _merkleRoot;
  }

  function mint(bytes32[] calldata merkleProof) public payable {
    require(claimed[msg.sender] == false, "already claimed");
    claimed[msg.sender] = true;
    require(MerkleProof.verify(merkleProof, merkleRoot, keccak256(abi.encodePacked(msg.sender))), "invalid merkle proof");
    nextTokenId++;
    _mint(msg.sender, nextTokenId);
  }
}


//Note!! Note!!!
/* This is a copied work as i'm still finding it difficult to understand the verification process*/
//felt i needed to submit something