// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNFT} from "../../script/DeployBasicNFT.s.sol";
import {BasicNFT} from "../../src/BasicNFT.sol";

contract BasicNFTTests is Test {
    BasicNFT public basicNFT;
    DeployBasicNFT public deployBasicNFT;

    address public USER = makeAddr("USER");

    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployBasicNFT = new DeployBasicNFT();
        basicNFT = deployBasicNFT.run();
    }

    function testNameIsCorrect() public view {
        bytes32 expextedName = keccak256(abi.encodePacked("BasicNFT"));
        bytes32 realName = keccak256(abi.encodePacked(basicNFT.name()));
        assert(expextedName == realName);
    }

    function testCantMintAndHaveBalance() public {
        vm.prank(USER);
        basicNFT.mintNFT(PUG_URI);

        assert(basicNFT.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG_URI)) ==
                keccak256(abi.encodePacked(basicNFT.tokenURI(0)))
        );
    }
}
