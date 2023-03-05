// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/erc20/ierc20.sol";

contract PrivatePay {

    IERC20 bob = IERC20(0xB0B195aEFA3650A6908f15CdaC7D92F8a5791B0B);
    IZkBobDirectDeposits queue = IZkBobDirectDeposits(0x668c5286eAD26fAC5fa944887F9D2F20f7DDF289);

    bytes zkAddress = bytes("QsnTijXekjRm9hKcq5kLNPsa6P4HtMRrc3RxVx3jsLHeo2AiysYxVJP86mriHfN");

    address fallbackReceiver = msg.sender;

    event payDeposited(uint amount, uint when);
    
    function privateDeposit() public {
    // through ERC677 token interface
    bob.transferAndCall(address(queue), msg.value, abi.encode(fallbackReceiver, zkAddress));
    emit payDeposited(msg.value, block.timestamp);
    }

}