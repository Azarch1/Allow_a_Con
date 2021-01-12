pragma solidity ^0.7.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

contract AllowaDraw is Ownable {
    
    using SafeMath for uint;
    
    event AllowanceChanged(address indexed _forWho, address indexed _fromwhom, uint _oldAmount, uint _newAmount);
    
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
         emit AllowanceChanged(_who,msg.sender,allowance[_who], _amount);
        allowance[_who] = _amount;
        
    }
    
   function reduceAllowance(address _who, uint _amount) internal {
       emit AllowanceChanged(_who,msg.sender,allowance[_who], allowance[_who] - allowance[_who].sub(_amount));
       allowance[_who] = allowance[_who].sub(_amount);
   }
}