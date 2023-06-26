// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {SafeMath} from "@oz/utils/math/SafeMath.sol";

/// @title Ethernaut Challenge 02
/// @author https://ethernaut.openzeppelin.com/level/0x676e57FdBbd8e5fE1A7A3f4Bb1296dAC880aa639
contract Fallout {
    using SafeMath for uint256;

    /*//////////////////////////////////////////////////////////////
                                 STORAGE
    //////////////////////////////////////////////////////////////*/
    mapping(address => uint256) private s_allocations;
    address payable private s_owner;

    /*//////////////////////////////////////////////////////////////
                                MODIFIERS
    //////////////////////////////////////////////////////////////*/

    modifier onlyOwner() {
        require(msg.sender == s_owner, "caller is not the owner");
        _;
    }

    /*//////////////////////////////////////////////////////////////
                               CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    function Fal1out() public payable {
        s_owner = payable(msg.sender); // Type issues must be payable address
        s_allocations[s_owner] = msg.value;
    }

    /*//////////////////////////////////////////////////////////////
                                PUBLIC
    //////////////////////////////////////////////////////////////*/

    function allocate() public payable {
        s_allocations[msg.sender] = s_allocations[msg.sender].add(msg.value);
    }

    function sendAllocation(address payable allocator) public {
        require(s_allocations[allocator] > 0);
        allocator.transfer(s_allocations[allocator]);
    }

    function collectAllocations() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }

    function allocatorBalance(address allocator) public view returns (uint256) {
        return s_allocations[allocator];
    }

    function getOwner() public view returns (address) {
        return s_owner;
    }
}
