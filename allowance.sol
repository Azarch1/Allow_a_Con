pragma solidity ^0.7.4;

contract allowance {
    
 address owner;

constructor() {
    owner = msg.sender;
}

function getOwner() public view returns(address) {
    return owner;
}

}