// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IBase64} from "./IBase64.sol";

// An abstract contract that provides the list of competitors, their IDs, and their URIs.
abstract contract CompetitorProvider {
  ////////// MEMBER VARIABLES //////////
  
  // The IDs of the competitors.
  uint256[] ids;

  ////////// PUBLIC APIS //////////

  // Lists the IDs of the competitors. This must return an array that is of a power of 2,
  // between 4 and 256 inclusive. Team IDs should be returned in match order of the 
  // first round - from top to bottom on the left, then top to bottom on the right.
  function listCompetitorIDs() external virtual view returns (uint256[] memory);

  // Returns the competitor for the given competitor ID.
  function getCompetitor(uint256) external virtual view returns (IBase64.Competitor memory);

  ////////// INTERNAL APIS //////////

  // Returns the power of 2 that is greater than or equal to the given number.
  function getPowerOfTwo(uint256 n) internal pure returns (uint256) {
    require(n >= 4 && n <= 256, "INVALID_NUM_IDS");
    
    if (n < 8) {
      return 4;
    } else if (n < 16 && n >= 8) {
      return 8;
    } else if (n < 32) {
      return 16;
    } else if (n < 64) {
      return 32;
    } else if (n < 128) {
      return 64;
    } else if (n < 256) {
      return 128;
    } else {
      return 256;
    }
  }
}
