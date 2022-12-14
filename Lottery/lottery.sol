// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/*Implementation of a lottery system where users pick 6 random numbers for a chance to win the mega prize*/

contract lottery {

    address[] public players;
    mapping(address => uint[]) playerNumbers;
    mapping(address => bool) havePlayed;
    uint[6] public winningArr;
    //mapping(uint => mapping(address => uint[])) playerIdentifier; 
    address organizer;
    uint constant TICKETFEE = 1 ether;

    constructor () payable {
        organizer = msg.sender;
    }

    //for this lottery pick 6 numbers that falls within and inclusive of 1 - 50;
    function enter(uint[6] memory _arr) public payable{
        require(msg.value == TICKETFEE, "invalid ticket fee");
        playerNumbers[msg.sender] = _arr;
        havePlayed[msg.sender] = true;
        players.push(msg.sender);
    }

    //function to generate random number
    function randomOfFifty(uint _num) internal view returns(uint){
        uint betweenFifty = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
        return betweenFifty % _num;
    }

    //populate the winninng array
    function populateWinningArr() public {
        require(msg.sender == organizer, "You can't do this");
        for(uint i = 0; i < winningArr.length; i++){
            winningArr[i] = randomOfFifty(i + 44);
        }
    }

    //function compares players lucky numbers to the numbers generated by the lottery
    function areNumbersInWinningArr(uint[] memory _input) private view returns(bool){
        for(uint i = 0; i < _input.length; i++){
            for (uint j = 0; j < winningArr.length; j++){

                if(_input[i] == winningArr[j]){
                    break;
                }else{

                    if (j == winningArr.length - 1) return false;
                    continue;
                }
            }
        }
        return true;
    }

    //Users can come and check their winning status
    function checkWinning() public returns(string memory) {
        require(havePlayed[msg.sender]);
        if(areNumbersInWinningArr(playerNumbers[msg.sender])){
            payable(msg.sender).transfer(address(this).balance);
            return "You have Won";
        }
        else{
            return "Try again next time";
        }
    }  

    function showIndex()public view returns (uint[6] memory){
        return winningArr;
    }
}
