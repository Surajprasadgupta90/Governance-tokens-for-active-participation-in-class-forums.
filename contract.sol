// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ClassForumGovernanceToken is ERC20, Ownable {
    uint256 public rewardAmount;
    mapping(address => uint256) public lastParticipation;

    event ParticipationRewarded(address indexed participant, uint256 amount);

    constructor(uint256 initialReward, address initialOwner) 
        ERC20("Class Forum Governance Token", "CFGT") 
        Ownable(initialOwner) 
    {
        rewardAmount = initialReward;
    }

    // Function to reward participation
    function rewardParticipation(address participant) external onlyOwner {
        require(
            block.timestamp >= lastParticipation[participant] + 1 days,
            "Reward already claimed within the last 24 hours"
        );

        _mint(participant, rewardAmount);
        lastParticipation[participant] = block.timestamp;

        emit ParticipationRewarded(participant, rewardAmount);
    }

    // Update the reward amount (onlyOwner)
    function updateRewardAmount(uint256 newReward) external onlyOwner {
        rewardAmount = newReward;
    }
}
