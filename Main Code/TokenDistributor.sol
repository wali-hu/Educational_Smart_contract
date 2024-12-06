// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenDistributor is Ownable {
    using Math for uint256;
    
    IERC20 public educationalToken;
    // mapping(address => uint256) public playerTokens;
    
    event RewardsDistributed(address[] players, uint256[] rewards);
    
    constructor(address _educationalToken, address initialOwner) Ownable(initialOwner) {
        educationalToken = IERC20(_educationalToken);
    }
    
    function distributeTokens(address student1, address student2, address student3, address[] memory remainingStudents) public onlyOwner {
        educationalToken.transferFrom(msg.sender, student1, 10 * 1e18);
        educationalToken.transferFrom(msg.sender, student2, 8 * 1e18);
        educationalToken.transferFrom(msg.sender, student3, 6 * 1e18);

        for (uint i = 0; i < remainingStudents.length; i++){
            educationalToken.transferFrom(msg.sender, remainingStudents[i], 1 * 1e18);
        }
    }


    // Distribute rewards based on race placement
    // function distributeRaceRewards(address[] memory players) public onlyOwner {
    //     require(players.length > 0, "No players provided");
    //     uint256[] memory rewards = new uint256[](players.length);

    //     // Calculate rewards based on placement
    //     for (uint256 i = 0; i < players.length; i++) {
    //         uint256 reward;
    //         if (i == 0) reward = 10; // First place
    //         else if (i == 1) reward = 8; // Second place
    //         else if (i == 2) reward = 6; // Third place
    //         else {
    //             // For positions beyond 3rd place, calculate decreasing rewards
    //             // Use a simple subtraction with a minimum of 1 token
    //             uint256 calculatedReward = 5 - i;
    //             reward = calculatedReward > 0 ? calculatedReward : 1;
    //         }
            
    //         rewards[i] = reward;
    //         educationalToken.mint(players[i], reward);
    //         playerTokens[players[i]] += reward;
    //     }
        
    //     emit RewardsDistributed(players, rewards);
    // }
    
    // Get player's token balance
    function getStudentBalance(address student) public view returns (uint256) {
        return educationalToken.balanceOf(student);
    }
}