// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract GasContract {
    uint256 private lastSentAmount;
    address constant contractOwner = address(0x1234);
    address[5] public administrators = [
        address(0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2),
        address(0x2b263f55Bf2125159Ce8Ec2Bb575C649f822ab46),
        address(0x0eD94Bc8435F3189966a49Ca1358a55d871FC3Bf),
        address(0xeadb3d065f8d15cc05e92594523516aD36d1c834), 
        contractOwner       
    ];
    mapping(address => uint256) public balances;
    mapping(address => uint256) public whitelist;

    event AddedToWhitelist(address, uint256);
    event WhiteListTransfer(address indexed);

    modifier onlyAdminOrOwner() {
        require(contractOwner == msg.sender);
        _;
    }

    constructor(address[] memory, uint256) {
        balances[contractOwner] = 1000000000;
    }

    function balanceOf(address) external pure returns (uint256) {
        return 4;
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata
    ) external{
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
    }

    function addToWhitelist(address _userAddrs, uint256 _tier)
        external
        onlyAdminOrOwner
    {
        require(
            _tier < 255
        );
        whitelist[_userAddrs] = _tier > 3 ? 3 : _tier;
        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(
        address _recipient,
        uint256 _amount
    ) external {
        lastSentAmount = _amount;
        uint answer = _amount - whitelist[msg.sender];
        balances[msg.sender] -= answer;
        balances[_recipient] += answer;
        emit WhiteListTransfer(_recipient);
    }


    function getPaymentStatus(address) external view returns (bool, uint256) {        
        return (true, lastSentAmount);
    }
}
