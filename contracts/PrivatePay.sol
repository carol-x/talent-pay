IERC20 bob = IERC20(0xB0B195aEFA3650A6908f15CdaC7D92F8a5791B0B);
IZkBobDirectDeposits queue = IZkBobDirectDeposits(0x668c5286eAD26fAC5fa944887F9D2F20f7DDF289);

bytes memory zkAddress = bytes("QsnTijXekjRm9hKcq5kLNPsa6P4HtMRrc3RxVx3jsLHeo2AiysYxVJP86mriHfN");

address fallbackReceiver = msg.sender;

// Option A, through pool contract
// Note that ether is an alias for 10**18 multiplier, as BOB token has 18 decimals
bob.approve(address(queue), 100 ether);
uint256 depositId = queue.directDeposit(fallbackReceiver, 100 ether, zkAddress);

// Option B, through ERC677 token interface
bob.transferAndCall(address(queue), 100 ether, abi.encode(fallbackReceiver, zkAddress));