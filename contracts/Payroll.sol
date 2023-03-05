// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.9;

contract Payroll {
    uint public payPeriod;
    address payable public owner;
    mapping(address => uint) public latestTime; 
    mapping(address => uint) public eachPayAmount;
    mapping(address => uint) public paymentCount;
    address[] public commissioners; 

    event DepositPay(uint amount, address commissioner, uint when);
    event GetPaid(uint amount, address commissioner, uint when);

    constructor(uint _payPeriod) payable {
        require(
            _payPeriod > 0,
            "Pay period cannot be less than a day!"
        );
        payPeriod = _payPeriod * 1 days;
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function depositPay(uint _interval) public payable {
        require(msg.value > 0, "Payment has to be greater than 0!"); 
        require(msg.sender.balance > msg.value, "You don't have enough ETH to pay");

        payable(this).transfer(msg.value); 
        emit DepositPay(msg.value, msg.sender, block.timestamp);

        latestTime[msg.sender] = block.timestamp;
        eachPayAmount[msg.sender] = msg.value / _interval; 
        paymentCount[msg.sender] = _interval; 
    }

    function getPaid(address commissioner) public {
        require(msg.sender == owner, "You are not the owner of the smart contract!");
        if (paymentCount[commissioner] > 0) {
            
            latestTime[commissioner] = block.timestamp; // update last payment time
            paymentCount[msg.sender] -= 1; 
            owner.transfer(eachPayAmount[commissioner]); 
            emit GetPaid(address(this).balance, commissioner, block.timestamp);
            
        }
    }

    // debug purpose ONLY  
    function _withdraw() public { // debugging purpose only 
        require(msg.sender == owner, "You are not the owner of the smart contract!");
        owner.transfer(address(this).balance);
    }
}
