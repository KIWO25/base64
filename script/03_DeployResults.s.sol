// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {OracleResultProvider} from "../src/results/OracleResultProvider.sol";
import {Script} from "../lib/forge-std/src/Script.sol";
import {console2} from "../lib/forge-std/src/console2.sol";

// A script to deploy the results oracle of a Base64 Tournament.
// Usage: forge script ./script/03_DeployResults.s.sol:DeployResults \
// --broadcast --verify --rpc-url "https://goerli.base.org/" \
// --private-key <private-key> \
// --verifier etherscan \
// --verifier-url "https://api-goerli.basescan.org/api" \
// --etherscan-api-key <etherscan-api-key>
contract DeployResults is Script {
    function run() public {
        // TODO: This should be the address that corresponds to your private key.
        address owner = address(0x0);

        vm.startBroadcast();

        OracleResultProvider orp = new OracleResultProvider(owner);

        console2.log("Results", address(orp));

        vm.stopBroadcast();
    }
}
