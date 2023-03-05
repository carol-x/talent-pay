// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.9;

interface IERC20 {

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

interface IZkBobDirectDeposits {
    enum DirectDepositStatus {
        Missing, // requested deposit does not exist
        Pending, // requested deposit was submitted and is pending in the queue
        Completed, // requested deposit was successfully processed
        Refunded // requested deposit was refunded to the fallback receiver
    }

    struct DirectDeposit {
        address fallbackReceiver; // refund receiver for deposits that cannot be processed
        uint96 sent; // sent amount in BOB tokens (18 decimals)
        uint64 deposit; // deposit amount, after subtracting all fees (9 decimals)
        uint64 fee; // deposit fee (9 decimals)
        uint40 timestamp; // deposit submission timestamp
        DirectDepositStatus status; // deposit status
        bytes10 diversifier; // receiver zk address, part 1/2
        bytes32 pk; // receiver zk address, part 2/2
    }

    function getDirectDeposit(uint256 depositId) external view returns (DirectDeposit memory deposit);

    function directDeposit(
        address fallbackReceiver,
        uint256 amount,
        bytes memory zkAddress
    )
        external
        returns (uint256 depositId);

    function directDeposit(
        address fallbackReceiver,
        uint256 amount,
        string memory zkAddress
    )
        external
        returns (uint256 depositId);

    function onTokenTransfer(address from, uint256 amount, bytes memory data) external returns (bool ok);

    function directDepositFee() external view returns (uint64 fee);

    function directDepositTimeout() external view returns (uint40 timeout);

    function directDepositNonce() external view returns (uint32 nonce);

    function refundDirectDeposit(uint256 index) external;

    function refundDirectDeposit(uint256[] memory indices) external;
}


contract PrivatePay {

    IERC20 bob = IERC20(0xB0B195aEFA3650A6908f15CdaC7D92F8a5791B0B);
    IZkBobDirectDeposits queue = IZkBobDirectDeposits(0x668c5286eAD26fAC5fa944887F9D2F20f7DDF289);

    bytes zkAddress;
    address fallbackReceiver;
    event payDeposited(uint amount, uint when, uint depositId);

    function toBytes(address x) public returns (bytes memory b) {
        b = new bytes(32);
        assembly { mstore(add(b, 32), x) }
    }

    constructor() {
        fallbackReceiver = msg.sender; 
        bytes10 diversifier = 0xc2767ac851b6b1e19eda; 
        bytes memory source_b = toBytes(msg.sender);
        zkAddress = bytes("QsnTijXekjRm9hKcq5kLNPsa6P4HtMRrc3RxVx3jsLHeo2AiysYxVJP86mriHfN"); // keccak256(source_b) + diversifier; 
    }


    
    function privateDeposit(uint _amount) public {
    // through ERC677 token interface
        bob.approve(address(queue), _amount);
        uint256 depositId = queue.directDeposit(fallbackReceiver, _amount, zkAddress);
        emit payDeposited(_amount, block.timestamp, depositId);
    }

}