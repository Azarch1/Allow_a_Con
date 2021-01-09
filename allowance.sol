pragma solidity ^0.7.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract AllowaDraw is Ownable {
    
    address payable owner;
    
    constructor() {
        owner = msg.sender;
         allowance[owner] = 1000;
    }
    
    mapping(address => uint) public allowance;
    
     modifier ownerOrAllowed(uint _amount) {
        require(allowance[msg.sender] >= _amount,"You are not authorized");
        _;
    }
    

    function getBalance() public view returns(uint) {
      return address(this).balance;
    }
    
    function depositMoney() public payable {
        
    }
    
    function giveAllowance(address _who, uint _amount) public onlyOwner {
        allowance[_who] = _amount;
        
        // assert((Allowance[msg.sender] - _amount) <= Allowance[msg.sender]);
        // assert((Allowance[_to] + _amount) >= Allowance[_to]);
        // address(this).getBalance() -= _amount;
        // Allowance[_to] += _amount;
        
    }
    
   
    
    function witdrawMoney(address payable _to, uint _amount) public onlyOwner{
        _to.transfer(_amount);
    }
    
    fallback() external payable {
        depositMoney();
    }
    
}