// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {console} from "forge-std/Test.sol";
import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";


contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;
    function fundFundMe(address mostRecentlyDeployed) public{
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();

    }


    function run() external{
        vm.startBroadcast();
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        fundFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();

        
    }
}

contract WithdrawFundMe is Script{
    uint256 constant SEND_VALUE = 0.01 ether;
    function withdrawFundMe(address mostRecentlyDeployed) public{
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();

    }


    function run() external{
        vm.startBroadcast();
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        WithdrawFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();

        
    }
}

