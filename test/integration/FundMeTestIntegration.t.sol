// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";


contract FundMeTestIntegration is Test {
     FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;



    function setUp() external {
    DeployFundMe deploy = new DeployFundMe();
    fundMe = deploy.run();
    vm.deal(USER, BALANCE);
    }


    function testUserCanFundInteractions() public{
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));
    
        assert(address(fundMe).balance == 0);
    }

}