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
    mapping(address => bool) public hasVoted;

    // Defining events
    event AddVote(address indexed voter, address receiver, uint256 timestamp);
    event RemoveVote(address voter);
    event StartVoting(address startedBy);
    event StopVoting(address stoppedBy); 

    modifier onlyDuringVoting {
        require(isVoting, "Voting is not in progress");
        _;
    }

    modifier onlyNotVoted {
        require(!hasVoted[msg.sender], "You have already voted");
        _;
    }

    modifier onlyVoted {
        require(hasVoted[msg.sender], "You have not voted yet");
        _;
    }

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

    function addVote(address receiver) external onlyDuringVoting onlyNotVoted returns (bool) {
        require(receiver != address(0), "Invalid receiver address");

        votes[msg.sender].receiver = receiver;
        votes[msg.sender].timestamp = block.timestamp;
        hasVoted[msg.sender] = true;

        emit AddVote(msg.sender, votes[msg.sender].receiver, votes[msg.sender].timestamp);
        return true;
    }

    function removeVote() external onlyDuringVoting onlyVoted returns (bool) {
        delete votes[msg.sender];
        hasVoted[msg.sender] = false;

        emit RemoveVote(msg.sender);
        return true;
    }

    function getVote(address voterAddress) external view returns (address candidateAddress) {
        return votes[voterAddress].receiver;
    }
}
