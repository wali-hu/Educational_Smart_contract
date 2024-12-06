// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EducationalNFT is ERC721, Ownable {
    uint256 private _tokenIds;
    mapping(uint256 => uint256) public tokenValue; // Store token amount locked in NFT
    IERC20 public educationalToken;

    constructor(address _educationalToken, address initialOwner) 
        ERC721("Educational Game NFT", "EDNFT") 
        Ownable(initialOwner) 
    {
        educationalToken = IERC20(_educationalToken);
    }

    // Convert tokens to NFT
    function createNFT(uint256 amount) public returns (uint256) {
        require(educationalToken.balanceOf(msg.sender) >= amount, "Insufficient tokens");
        
        uint256 newItemId = ++_tokenIds;
        _mint(msg.sender, newItemId);
        tokenValue[newItemId] = amount;
        
        // Transfer tokens to this contract
        educationalToken.transferFrom(msg.sender, address(this), amount);
        
        return newItemId;
    }

    // Convert NFT back to tokens
    function redeemNFT(uint256 tokenId) public {
        require(ownerOf(tokenId) == msg.sender, "Not the NFT owner");
        uint256 amount = tokenValue[tokenId];
        
        // Burn the NFT
        _burn(tokenId);

        tokenValue[tokenId] = 0;
        
        // Return tokens to user
        educationalToken.transfer(msg.sender, amount);
    }
}