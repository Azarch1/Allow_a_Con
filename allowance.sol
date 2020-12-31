pragma solidity ^0.7.4;

contract AllowaDraw {
    
    address payable owner;
    
    mapping(address => uint) public Allowance;
    
    constructor() {
        owner = msg.sender;
    }
    
    function getBalance() public view returns(uint) {
      return address(this).balance;
    }
    
    function depositMoney() public payable {
        
    }
    
    function giveAllowance(address payable _to, uint _amount) public {
        require(msg.sender == owner, "You are not the owner");
        assert((address(this).balance - _amount) <= address(this).balance);
        assert((Allowance[_to] + _amount) >= Allowance[_to]);
        address(this).balance - _amount;
        Allowance[_to] + _amount;
    }
    
    function witdrawMoney(address payable _to, uint _amount) public {
        
    }
    
}