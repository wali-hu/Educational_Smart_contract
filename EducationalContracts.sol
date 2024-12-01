// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Importing OpenZeppelin libraries for ERC20, ERC721, and utility functions
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";

// ERC20 Token Contract for an educational platform
contract EducationalToken is ERC20, Ownable {
    // Constructor initializes the ERC20 token with a name and symbol
    constructor(address initialOwner) ERC20("Educational Token", "EDUT") Ownable(initialOwner) {}

    // Function to mint new tokens; only the contract owner can mint tokens
    function mint(uint256 amount) public onlyOwner {
        _mint(msg.sender, amount); // Mint tokens to the owner's address
    }
}

// ERC721 NFT Contract for educational game items
contract EducationalNFT is ERC721, Ownable {
    uint256 private _tokenIds; // Counter for tracking NFT IDs
    mapping(uint256 => uint256) public tokenValue; // Maps NFT IDs to their associated token value
    IERC20 public educationalToken; // Reference to the EducationalToken contract

    // Constructor initializes the NFT with a name, symbol, and the associated ERC20 token
    constructor(address _educationalToken, address initialOwner) 
        ERC721("Educational Game NFT", "EDNFT") 
        Ownable(initialOwner) 
    {
        educationalToken = IERC20(_educationalToken); // Set the associated ERC20 token
    }

    // Function to create an NFT by locking a specific amount of tokens
    function createNFT(uint256 amount) public returns (uint256) {
        require(educationalToken.balanceOf(msg.sender) >= amount, "Insufficient tokens"); // Ensure the user has enough tokens

        uint256 newItemId = ++_tokenIds; // Increment token ID
        _mint(msg.sender, newItemId); // Mint the NFT to the user
        tokenValue[newItemId] = amount; // Associate token value with the NFT

        // Transfer tokens from the user to the contract as collateral
        educationalToken.transferFrom(msg.sender, address(this), amount);

        return newItemId; // Return the newly created NFT ID
    }

    // Function to redeem an NFT and retrieve the locked tokens
    function redeemNFT(uint256 tokenId) public {
        require(ownerOf(tokenId) == msg.sender, "Not the NFT owner"); // Ensure the caller owns the NFT
        uint256 amount = tokenValue[tokenId]; // Get the token value associated with the NFT

        _burn(tokenId); // Burn the NFT
        tokenValue[tokenId] = 0; // Reset the token value

        // Transfer the locked tokens back to the user
        educationalToken.transfer(msg.sender, amount);
    }
}

// Token Distributor Contract for distributing rewards in the educational platform
contract TokenDistributor is Ownable {
    using Math for uint256;

    IERC20 public educationalToken; // Reference to the EducationalToken contract

    // Event emitted when rewards are distributed
    event RewardsDistributed(address[] players, uint256[] rewards);

    // Constructor initializes the distributor with the associated ERC20 token
    constructor(address _educationalToken, address initialOwner) Ownable(initialOwner) {
        educationalToken = IERC20(_educationalToken);
    }

    // Function to distribute tokens to a group of students
    function distributeTokens(address student1, address student2, address student3, address[] memory remainingStudents) public onlyOwner {
        // Distribute tokens to top 3 students
        educationalToken.transferFrom(msg.sender, student1, 10 * 1e18);
        educationalToken.transferFrom(msg.sender, student2, 8 * 1e18);
        educationalToken.transferFrom(msg.sender, student3, 6 * 1e18);

        // Distribute smaller rewards to the remaining students
        for (uint i = 0; i < remainingStudents.length; i++) {
            educationalToken.transferFrom(msg.sender, remainingStudents[i], 1 * 1e18);
        }
    }

    // Function to get the token balance of a student
    function getStudentBalance(address student) public view returns (uint256) {
        return educationalToken.balanceOf(student); // Return the balance of the specified student
    }
}
