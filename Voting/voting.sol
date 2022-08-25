// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

contract voting{


//replace candidate with aspirant
struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    uint public candidateCount;

    mapping(address => bool) public voterLookup;
    mapping(uint => Candidate) public candidateLookup;

    event candidateAdded(string indexed name, uint id);

    function addCandidate(string memory name) public {
        candidateLookup[candidateCount] = Candidate(candidateCount, name, 0);
        candidateCount++; 
        emit candidateAdded(name, candidateCount - 1);
    }

    function getCandidates() external view returns (string[] memory, uint[] memory) {
        string[] memory names = new string[](candidateCount);
        uint[] memory voteCounts = new uint[](candidateCount);
        for (uint i = 0; i < candidateCount; i++) {
            names[i] = candidateLookup[i].name;
            voteCounts[i] = candidateLookup[i].voteCount;
        }
        return (names, voteCounts);
    }

    function vote(uint id) external {
        require (!voterLookup[msg.sender]);
        require (id >= 0 && id <= candidateCount-1);
        candidateLookup[id].voteCount++;
        emit votedEvent(id);
    }

    event votedEvent(uint indexed id);

    function getWinner() public view returns(string memory){
        uint winningCount = 0;
        string memory winningName;

        for(uint i = 0; i < candidateCount; i++){

            if(candidateLookup[i].voteCount > winningCount ){
                winningCount = candidateLookup[i].voteCount;
                winningName = candidateLookup[i].name;
            }
        }
        return winningName;
    }
} 