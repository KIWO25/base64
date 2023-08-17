// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Base64} from "../src/Base64.sol";
import {Test} from "../lib/forge-std/src/Test.sol";

// Unit tests for Base64.
contract Base64Test is Test {
  Base64 b;

  function setUp() public {
    uint32[] memory teamIDs = new uint32[](8);
    for (uint8 i = 0; i < teamIDs.length; i++) {
      teamIDs[i] = i + 1;
    }

    string[] memory teamNames = new string[](8);
    teamNames[0] = "Brian";
    teamNames[1] = "Greg";
    teamNames[2] = "Alesia";
    teamNames[3] = "Manish";
    teamNames[4] = "LJ";
    teamNames[5] = "Paul";
    teamNames[6] = "Emilie";
    teamNames[7] = "Will";

    b = new Base64(teamIDs, teamNames);
  }

  function testConstructor_tooShort() public {
    uint32[] memory invalidTeamIDs = new uint32[](3);
    for (uint8 i = 0; i < invalidTeamIDs.length; i++) {
      invalidTeamIDs[i] = i + 1;
    }

    string[] memory invalidTeamNames = new string[](3);
    invalidTeamNames[0] = "Brian";
    invalidTeamNames[1] = "Greg";
    invalidTeamNames[2] = "Alesia";

    vm.expectRevert("INVALID_BRACKET_SIZE");

    new Base64(invalidTeamIDs, invalidTeamNames);
  }

  function testConstructor_notPowerOfTwo() public {
    uint32[] memory invalidTeamIDs = new uint32[](5);
    for (uint8 i = 0; i < invalidTeamIDs.length; i++) {
      invalidTeamIDs[i] = i + 1;
    }

    string[] memory invalidTeamNames = new string[](5);
    invalidTeamNames[0] = "Brian";
    invalidTeamNames[1] = "Greg";
    invalidTeamNames[2] = "Alesia";
    invalidTeamNames[3] = "Manish";
    invalidTeamNames[4] = "LJ";

    vm.expectRevert("INVALID_BRACKET_SIZE");

    new Base64(invalidTeamIDs, invalidTeamNames);
  }

  function testConstructor_notEnoughNames() public {
    uint32[] memory invalidTeamIDs = new uint32[](8);
    for (uint8 i = 0; i < invalidTeamIDs.length; i++) {
      invalidTeamIDs[i] = i + 1;
    }

    string[] memory invalidTeamNames = new string[](4);
    invalidTeamNames[0] = "Brian";
    invalidTeamNames[1] = "Greg";
    invalidTeamNames[2] = "Alesia";
    invalidTeamNames[3] = "Manish";

    vm.expectRevert("INVALID_TEAM_DATA");

    new Base64(invalidTeamIDs, invalidTeamNames);
  }

  function testConstructor_duplicateTeamIDs() public {
    uint32[] memory invalidTeamIDs = new uint32[](4);
    for (uint8 i = 0; i < invalidTeamIDs.length; i++) {
      invalidTeamIDs[i] = i + 1;
    }

    invalidTeamIDs[1] = 0;

    string[] memory invalidTeamNames = new string[](4);
    invalidTeamNames[0] = "Brian";
    invalidTeamNames[1] = "Greg";
    invalidTeamNames[2] = "Alesia";
    invalidTeamNames[3] = "Manish";

    vm.expectRevert("INVALID_TEAM_IDS");

    new Base64(invalidTeamIDs, invalidTeamNames);
  }

  function testConstructor_zeroValueID() public {
    uint32[] memory invalidTeamIDs = new uint32[](4);
    for (uint8 i = 0; i < invalidTeamIDs.length; i++) {
      invalidTeamIDs[i] = i;
    }

    invalidTeamIDs[1] = 0;

    string[] memory invalidTeamNames = new string[](4);
    invalidTeamNames[0] = "Brian";
    invalidTeamNames[1] = "Greg";
    invalidTeamNames[2] = "Alesia";
    invalidTeamNames[3] = "Manish";

    vm.expectRevert("INVALID_TEAM_IDS");

    new Base64(invalidTeamIDs, invalidTeamNames);
  }

  function testGetBracket_initial() public {
    uint256[][] memory bracket = b.getBracket();

    assertEq(bracket.length, 4);

    assertEq(bracket[0].length, 8);
    assertEq(bracket[0][0], 1);
    assertEq(bracket[0][1], 2);
    assertEq(bracket[0][2], 3);
    assertEq(bracket[0][3], 4);
    assertEq(bracket[0][4], 5);
    assertEq(bracket[0][5], 6);
    assertEq(bracket[0][6], 7);
    assertEq(bracket[0][7], 8);

    assertEq(bracket[1].length, 0);
    assertEq(bracket[2].length, 0);
    assertEq(bracket[3].length, 0);
  }

  function testGetTeam() public {
    Base64.Team memory team = b.getTeam(1);

    assertEq(team.id, 1);
    assertEq(team.name, "Brian");
  }

  function testGetTeam_notFound() public {
    vm.expectRevert("TEAM_NOT_FOUND");

    b.getTeam(9);
  }
}
