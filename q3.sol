// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrowdfundingContract {
 address payable public admin;
uint public goal;
uint public deadline;
 uint public totalAmountRaised;
mapping(address => uint) public contributions;
constructor(address payable _admin, uint _goal, uint _days) {
 admin = _admin;
 goal = _goal;
 deadline = block.timestamp + (_days * 1 days);
}
modifier onlyAdmin() {
 require(msg.sender == admin, "Only the admin can perform this action.");
  _;
    }

 modifier beforeDeadline() {
 require(block.timestamp < deadline, "The deadline has passed.");
 _;
 }

 function contribute() external payable beforeDeadline {
require(msg.value > 0, "Contribution amount must be greater than zero.");
totalAmountRaised += msg.value;
 contributions[msg.sender] += msg.value;
    }

function collectFunds() external onlyAdmin {
 require(totalAmountRaised >= goal, "The funding goal has not been reached yet.");
 require(block.timestamp >= deadline, "The deadline has not passed yet.");
 admin.transfer(address(this).balance);
   }
 function refund() external beforeDeadline {
require(address(this).balance > 0, "There are no funds to refund.");
uint amountToRefund = contributions[msg.sender];
contributions[msg.sender] = 0;
 payable(msg.sender).transfer(amountToRefund);
    }
 
}
