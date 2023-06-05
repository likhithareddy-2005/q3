// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract q3{
address payable public admin;
uint public goal;
uint public totalraised;
uint totalamountraised;
mapping(address => uint) public contributions;
constructor(address payable _admin,uint _goal){
admin=_admin;
goal=_goal;
}
 modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can perform this action.");
        _;
    }
    function contribute() external payable  {
        require(msg.value > 0, "Contribution amount must be greater than zero.");
        totalamountraised += msg.value;
        contributions[msg.sender] += msg.value;
       
    }

    function collectFunds() external onlyAdmin {
        require(totalamountraised >= goal, "The funding goal has not been reached yet.");
        

        admin.transfer(address(this).balance);}

}
