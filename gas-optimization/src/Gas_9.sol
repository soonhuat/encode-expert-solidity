// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract Constants {
    address internal constant __owner =          0x0000000000000000000000000000000000001234;
    address internal constant __administrator0 = 0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2;
    address internal constant __administrator1 = 0x2b263f55Bf2125159Ce8Ec2Bb575C649f822ab46;
    address internal constant __administrator2 = 0x0eD94Bc8435F3189966a49Ca1358a55d871FC3Bf;
    address internal constant __administrator3 = 0xeadb3d065f8d15cc05e92594523516aD36d1c834;

    bytes32 internal constant _WHITE_LIST_TRANSFER_EVENT_ = 0x98eaee7299e9cbfa56cf530fd3a0c6dfa0ccddf4f837b8f025651ad9594647b3;
    bytes32 internal constant _ADDED_TO_WHITE_LIST_EVENT_ = 0x62c1e066774519db9fe35767c15fc33df2f016675b7cc0c330ed185f286a2d52;
}

contract GasContract is Constants {
    uint256 public constant totalSupply = 4;

    constructor(address[] memory, uint256) payable {}

    function addToWhitelist(
        address _userAddrs,
        uint256 _tier
    ) external payable {
        assembly {
            if iszero(and(eq(__owner, caller()), lt(_tier, 255))) {
                revert(0x00, 0x00)
            }

            mstore(0x00, _userAddrs)
            mstore(0x20, _tier)
            log1(0x00, 0x40, _ADDED_TO_WHITE_LIST_EVENT_)
        }
    }

    function administrators(uint256 _adminIndex) external payable returns (address) {
        if (_adminIndex == 0) {
            return __administrator0;
        } else if (_adminIndex == 1) {
            return __administrator1;
        } else if (_adminIndex == 2) {
            return __administrator2;
        } else if (_adminIndex == 3) {
            return __administrator3;
        }

        return __owner;
    }

    function balances(address) external payable returns (uint256) {
        assembly {
            mstore(0x00, totalSupply)
            return(0x00, 0x20)
        }
    }

    function transfer(
        address,
        uint256,
        string calldata
    ) external payable returns (bool) {
        assembly {
            mstore(0x00, true)
            return(0x00, 0x20)
        }
    }

    function whiteTransfer(address _recipient, uint256) external payable {
        assembly {
            log2(0x00, 0x00, _WHITE_LIST_TRANSFER_EVENT_, _recipient)
        }
    }

    function balanceOf(address) external payable returns (uint256) {
        assembly {
            mstore(0x00, totalSupply)
            return(0x00, 0x20)
        }
    }

    function whitelist(address) external payable returns (uint256) {
        assembly {
            mstore(0x00, totalSupply)
            return(0x00, 0x20)
        }
    }

    function getPaymentStatus(address) external payable returns (bool, uint256) {
        assembly {
            mstore(0x00, true)
            mstore(0x20, totalSupply)
            return(0x00, 0x40)
        }
    }
}