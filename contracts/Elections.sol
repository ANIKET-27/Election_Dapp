// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Election{

struct Candidate{

string cadidateName;
string candidateImage;
string partyName;
string partyImage;
uint totalVotes;

}

struct Voter{

  address addr;
  string voterName;
  string url;
  bool voted;
  uint votedTo;

}

address public commissioner;
string public electionName;
bool public elctionStarted= false;
bool public lock=false;


Candidate[] public stoodUp;
Voter[] public voters;
 


modifier authority() {
  require(msg.sender == commissioner);
  _;
}

function startElection(string memory name) public {
  if(!elctionStarted){
  commissioner = msg.sender;
  electionName = name;
  elctionStarted=true;
  }

}

    function lockOut() authority public{
        lock=true;
    }

function addCandidate(string memory cn,string memory ci,string memory pn,string memory pi) authority public  {
    if(!lock)
    stoodUp.push(Candidate(cn,ci,pn,pi,0));

}  

function addVoter(address addr,string memory name,string memory url) authority public {
        if(!lock)
        voters.push(Voter(addr,name,url,false,0));

}

function eligible(address addr) public view returns(bool){

 for(uint i=0;i<voters.length;i++){
   if(voters[i].addr == addr && !voters[i].voted) return true;
    
 } 
  
  return false;

}

function vote(address addr,uint val) authority public {

  stoodUp[val-1].totalVotes+=1;
  for(uint i=0;i<voters.length;i++){
   if(voters[i].addr == addr){
       voters[i].voted=true;
       voters[i].votedTo=val;
       break;

   }
  } 
 
}

function getCandidateAt(uint idx) public view  returns(string memory ,string memory ,string memory ,string memory ,uint ) {

   return (stoodUp[idx].cadidateName,stoodUp[idx].candidateImage,stoodUp[idx].partyName,stoodUp[idx].partyImage,stoodUp[idx].totalVotes);
}

function VotersAt(uint idx) public view returns (string memory,string memory ,bool ,uint) {
  return (voters[idx].voterName,voters[idx].url,voters[idx].voted,voters[idx].votedTo);
}

function numberOfVoters() public view returns(uint){
    return voters.length;
}

function numberOfCandidate() public view returns(uint){
  return stoodUp.length;
}

function getElectionSatus() public view returns(bool){
  return elctionStarted;
}

    function getLockSatus() public view returns(bool){
        return lock;
    }


function getElectionName() public view returns(string memory) {
  return electionName;
}

}

