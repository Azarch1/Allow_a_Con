pragma solidity ^0.7.4;


contract AllowaDraw  {
    
    address payable owner;
    
    mapping(address => uint) public Allowance;
    
    constructor() {
        owner = msg.sender;
        // Allowance[owner] = 100 ether;
    }
    
    modifier onlyOwner() {
        require(owner == msg.sender, "You are not allowed!");
        _;
    }
    
    function getBalance() public view returns(uint) {
      return address(this).balance;
    }
    
    function depositMoney() public payable {
        
    }
    
    // function giveAllowance(address payable _to, uint _amount) public {
        
        // assert((Allowance[msg.sender] - _amount) <= Allowance[msg.sender]);
        // assert((Allowance[_to] + _amount) >= Allowance[_to]);
        // address(this).getBalance() -= _amount;
        // Allowance[_to] += _amount;
        
    // }
    
    function witdrawMoney(address payable _to, uint _amount) public onlyOwner{
        _to.transfer(_amount);
    }
    
    fallback() external payable {
        depositMoney();
    }
    
}