// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Tournament} from "../../src/Tournament.sol";
import {CompetitorProvider} from "../../src/CompetitorProvider.sol";
import {ResultProvider} from "../../src/ResultProvider.sol";
import {StaticCompetitorProvider} from "../../src/competitors/StaticCompetitorProvider.sol";
import {OracleResultProvider} from "../../src/results/OracleResultProvider.sol";
import {RandomResultProvider} from "../../src/results/RandomResultProvider.sol";
import {Tournament} from "../../src/Tournament.sol";
import {StaticOracleTournament} from "../../src/tournaments/StaticOracleTournament.sol";
import {Test} from "../../lib/forge-std/src/Test.sol";
import {console2} from "../../lib/forge-std/src/Console2.sol";

// Unit tests for a StaticOracleTournament with FriendTech data.
contract StaticFriendTechTournamentTest is Test {
  Tournament _t;
  StaticCompetitorProvider _s;
  OracleResultProvider _o;

  function setUp() public {
    string memory root = vm.projectRoot();
    string memory path = string.concat(root, "/data/friendtech_08222023_parsed.json");
    string memory json = vm.readFile(path);

    bytes memory abiData = vm.parseJson(json);
    Tournament.Competitor[] memory competitors = abi.decode(abiData, (Tournament.Competitor[]));

    for (uint256 i = 0; i < competitors.length; i++) {
      console2.log(competitors[i].id);
      console2.log(competitors[i].uri);
    } 
  }

  function testNull() public {}
}
