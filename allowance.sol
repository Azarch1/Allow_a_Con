pragma solidity ^0.7.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";

contract AllowanceContract is Ownable {
    
    mapping(address => uint) public allowance;
    
    address ownerallow;
    
    constructor() {
        ownerallow = msg.sender;
    }
    
     modifier ownerOrAllowed(uint _amount) {
        require(allowance[msg.sender] >= _amount,"You are not authorized");
        _;
    }
    
    function getBalance() public view returns(uint) {
      return address(this).balance;
    }
    
     function giveAllowance(address _who, uint _amount) public onlyOwner {
        allowance[_who] = _amount;
        
    }
    
   function reduceAllowance(address _who, uint _amount) internal {
       allowance[_who] -= _amount;
   }
}

contract AllowaDraw is AllowanceContract {
    
    
    function depositMoney() public payable {
        allowance[ownerallow] += msg.value;
    }
    
   
    
    function witdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount){
        require(_amount <= address(this).balance , "There are not enough funds on the smart contract");
        if(msg.sender != ownerallow) {
            reduceAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
    }
    
    fallback() external {
        depositMoney();
    }
    
}