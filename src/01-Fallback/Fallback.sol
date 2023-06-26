// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/// @title Ethernaut Challenge 01
/// @author https://ethernaut.openzeppelin.com/level/0x3c34A342b2aF5e885FcaA3800dB5B205fEfa3ffB
contract Fallback {
    /*//////////////////////////////////////////////////////////////
                                 STORAGE
    //////////////////////////////////////////////////////////////*/
    mapping(address => uint256) private s_contributions;
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

    constructor() {
        s_owner = payable(msg.sender); // Type issues must be payable address
        s_contributions[msg.sender] = 1000 * (1 ether);
    }

    /*//////////////////////////////////////////////////////////////
                                EXTERNAL
    //////////////////////////////////////////////////////////////*/

    fallback() external payable {
        // naming has switched to fallback
        require(
            msg.value > 0 && s_contributions[msg.sender] > 0,
            "tx must have value and msg.send must have made a contribution"
        ); // Add message with require
        s_owner = payable(msg.sender); // Type issues must be payable address
    }

    /*//////////////////////////////////////////////////////////////
                                PUBLIC
    //////////////////////////////////////////////////////////////*/

    function contribute() public payable {
        require(msg.value < 0.001 ether, "msg.value must be < 0.001"); // Add message with require
        s_contributions[msg.sender] += msg.value;
        if (s_contributions[msg.sender] > s_contributions[s_owner]) {
            s_owner = payable(msg.sender); // Type issues must be payable address
        }
    }

    function getContribution(address contributor) public view returns (uint256) {
        return s_contributions[contributor];
    }

    function getOwner() public view returns (address) {
        return s_owner;
    }

    function withdraw() public onlyOwner {
        s_owner.transfer(address(this).balance);
    }
}
