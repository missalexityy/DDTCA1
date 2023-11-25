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
        require(!isVoting, "Voting is already in progress");
        isVoting = true;
        emit StartVoting(msg.sender);
        return true;
    }

    function stopVoting() external returns (bool) {
        require(isVoting, "Voting is not in progress");
        isVoting = false;
        emit StopVoting(msg.sender);
        return true;
    }

    function addVote(address receiver) external returns (bool) {
        require(isVoting, "Voting is not in progress");
        require(receiver != address(0), "Invalid receiver address");
        require(votes[msg.sender].timestamp == 0, "You have already voted");

        votes[msg.sender].receiver = receiver;
        votes[msg.sender].timestamp = block.timestamp;

        emit AddVote(msg.sender, votes[msg.sender].receiver, votes[msg.sender].timestamp);
        return true;
    }

    function removeVote() external returns (bool) {
        require(isVoting, "Voting is not in progress");
        require(votes[msg.sender].timestamp != 0, "You have not voted yet");

        delete votes[msg.sender];

        emit RemoveVote(msg.sender);
        return true;
    }

    function getVote(address voterAddress) external view returns (address candidateAddress) {
        return votes[voterAddress].receiver;
    }
}
