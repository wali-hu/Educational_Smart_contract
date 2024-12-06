// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EducationalToken is ERC20, Ownable {
    constructor(address initialOwner) ERC20("Educational Token", "EDUT") Ownable(initialOwner) {}
    
    // Mint new tokens (only owner/game contract can call this)
    function mint(uint256 amount) public onlyOwner {
        _mint(msg.sender, amount);
    }
}