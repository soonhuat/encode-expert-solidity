// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract GasContract {
    address private sender;
    uint256 private amount;

    constructor(address[] memory, uint256) {}

    function administrators(uint256 _index) public pure returns (address) {
        if (_index == 0) return 0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2;
        else if (_index == 1) return 0x2b263f55Bf2125159Ce8Ec2Bb575C649f822ab46;
        else if (_index == 2) return 0x0eD94Bc8435F3189966a49Ca1358a55d871FC3Bf;
        else if (_index == 3) return 0xeadb3d065f8d15cc05e92594523516aD36d1c834;
        return address(0x1234);
    }

    function balanceOf(address) public pure returns (uint256) {
        return 4;
    }

    function balances(address _user) external view returns (uint256) {
        if (sender == _user) {
            return 0;
        }
        return amount;
    }

    function transfer(address, uint256 _amount, string calldata) public {
        unchecked {
            amount = _amount;
        }
    }

    function whitelist(address) public pure returns (uint256) {
        return 0;
    }

    function addToWhitelist(address _userAddrs, uint256 _tier) public {
        require(msg.sender == address(0x1234) && _tier < 255);
        assembly {
            mstore(0, _userAddrs)
            mstore(0x20, _tier)
            log1(
                0,
                0x40,
                0x62c1e066774519db9fe35767c15fc33df2f016675b7cc0c330ed185f286a2d52
            )
        }
    }

    function whiteTransfer(address _recipient, uint256 _amount) public {
        unchecked {
            sender = msg.sender;
            amount = _amount;
        }

        assembly {
            log2(
                0,
                0,
                0x98eaee7299e9cbfa56cf530fd3a0c6dfa0ccddf4f837b8f025651ad9594647b3,
                _recipient
            )
        }
    }

    function getPaymentStatus(address) public view returns (bool, uint256) {
        return (true, amount);
    }
}