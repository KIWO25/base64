// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IBase64} from "./IBase64.sol";

// An interface that provides the result of a match between two competitors.
interface ResultProvider {

  ////////// PUBLIC APIS //////////

  // Returns the result of a match between two competitors.
  // It is the job of the caller to ensure that the two competitors are valid.
  function getResult(uint256 competitor1, uint256 competitor2) external view returns (IBase64.Result memory);
}
