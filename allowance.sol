pragma solidity ^0.7.4;

import "./AllowaDraw.sol";

contract AllowaContract is AllowaDraw {
    
    using SafeMath for uint;
    
    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    
    function depositMoney() public payable {
        allowance[ownerallow].add(msg.value);
    }
    
    // overriding the renounceOwnership function that can be found in the openzeppelin Owner.sol smart contract.
    function renounceOwnership() public override {
        revert("Can't renounce ownership here!");
    }
    
    // ensures that the owner's actuall allowance value does not decrease
    function witdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount){
        require(_amount <= address(this).balance , "There are not enough funds on the smart contract");
        if(msg.sender != ownerallow) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to,_amount);
        _to.transfer(_amount);
    }
    
    // fallback function that accepts deposits if a function name is not specified
    fallback() payable external {
        depositMoney();
        emit MoneyReceived(msg.sender,msg.value);
    }
    
}