// Voting System
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {

    bool public isVoting;

    struct Vote {
        address receiver;
        uint256 timestamp;
    }

    mapping(address => Vote) public votes;

    // Defining events
    event AddVote(address indexed voter, address receiver, uint256 timestamp);
    event RemoveVote(address voter);
    event StartVoting(address startedBy);
    event StopVoting(address stoppedBy);

    constructor() {
        isVoting = false;
    }

    function startVoting() external returns (bool) {
        isVoting = true;
        emit StartVoting(msg.sender);
        return true;
    }

    function stopVoting() external returns (bool) {
        isVoting = false;
        emit StopVoting(msg.sender);
        return true;
    }

    function addVote(address receiver) external returns (bool) {
        votes[msg.sender].receiver = receiver;
        votes[msg.sender].timestamp = block.timestamp;

        emit AddVote(msg.sender, votes[msg.sender].receiver, votes[msg.sender].timestamp);
        return true;
    }

    function removeVote() external returns (bool) {
        delete votes[msg.sender];

        emit RemoveVote(msg.sender);
        return true;
    }

    function getVote(address voterAddress) external view returns (address candidateAddress) {
        return votes[voterAddress].receiver;
    }
}
