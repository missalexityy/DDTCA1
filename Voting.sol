

 pragma solidity ^0.8.0;

// making a voting cantract

// 1. We want the ability to accept proposals and store them
// proposal: their name, number

// 2. voters & voting ability
// keep track of voting 
// check voters are authenticated to vote

// 3. chairman 
// authenticate anbd deploy contract

contract Ballot{

    // all the code goes here

    // struct is a method to create your own data type

    // voters: voted = bool, access to vote = uint, vote index = unit

    struct Voter{
        uint vote;
        bool voted;
        uint weight;
    } 

    struct Proposal{
        // bytes are a basic unit measurement of information in computer processing
    bytes32 name; //the name of each proposal
    uint voteCount; // number of accumulated votes
    }

    Proposal[] public proposals;

    // mapping allows for us to create a store value with keys and indexes
    
    mapping(address => Voter) public voters; // voters get address as a key and VOter for value

    address public chairperson;

    constructor(bytes32[] memory proposalNames)  {
        // memory difines a temprary data location in Solidity during runtime only
        // we guatante space for if

        //msg.sender = is a gloabal variable that states  the person 
        // who is currently connecting to the constract
        chairperson =msg.sender;

        voters[chairperson].weight = 1;


        // will add the proposal names to the smart contract upon deployment
        for(uint i=0; i < proposalNames.length; i++){
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));

        }

    }

    // function authenticate voter

    function giveRightToVote(address voter) public {
        require(msg.sender == chairperson,
        'Only the Chairperson can give access to vote');
                // require that the voter has not voted yet
        require(!voters[voter].voted,
                'The voter has already voted');
        require(voters[voter].weight == 0);

        voters[voter].weight =1;
        
    }

    // function for voting

    function vote(uint proposal) public {
        Voter storage sender = voters[msg.sender];
        require(sender.weight !=0, 'Has no right to vote');
        require(!sender.voted, 'Already voted');
        sender.voted = true;
        sender.vote = proposal;

        proposals[proposal].voteCount += sender.weight;
    }

    // functions for showing the results



    //1.function taht shows the winning proposal by integer
    
    function winningProposol() public view returns (uint winningProposal_){

        uint winningVoteCount = 0;
        for(uint i=0; i < proposals.length; i++){
            if(proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningProposal_ = i;

            }
        }

    }


    //2. function that shows the winner by name     
    function winningName() public view returns ( bytes32 winningName_) {

        winningName_ = proposals[winningProposal()].name;



    }
}




