// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// The interface for Base64.
interface IBase64 {
    ////////// STRUCTS AND ENUMS //////////

    // A struct representing a single competitor in the Tournament.
    struct Competitor {
        // The ID of the competitor.
        uint256 id;
        // The name of the competitor.
        string name;
    }

    // A struct representing a participant in the Tournament prediction market.
    struct Participant {
        // The address of the participant.
        address addr;
        // The points the participant has earned.
        uint256 points;
        // The payout the participant has earned at the end of the Tournament, in Wei.
        uint256 payout;
    }

    // An enum representing the state of the Tournament prediction market.
    enum State
    {
        // The Tournament prediction market is accepting entries.
        AcceptingEntries,
        // The Tournament is in progress and the prediction market is no longer accepting entries.
        InProgress,
        // The Tournament has concluded.
        Finished
    }

    ////////// PUBLIC APIS //////////

    // Returns the current state of the Tournament bracket. The first array index corresponds to
    // the round number of the tournament. The second array index corresponds to the competitor number,
    // from top to bottom on the left, and then top to bottom on the right. The array contains the
    // competitor ID.
    function getBracket() external view returns (uint256[][] memory);

    // Returns the competitor for the given competitor ID.
    function getCompetitor(uint256 competitorId) external view returns (Competitor memory);

    // Submits an entry to the Tournament prediction market. The entry must consist of N-1 rounds, where N
    // is the number of rounds in the Tournament. The entry must also pay the entry fee.
    // An address may submit at most one entry.
    function submitEntry(uint256[][] memory entry) external payable;

    // Returns an entry for a given address.
    function getEntry(address addr) external view returns (uint256[][] memory);

    // Returns the state of the Tournament prediction market.
    function getState() external view returns (State);

    // Returns the addresses of the participants in the tournament prediction market.
    function listParticipants() external view returns (address[] memory);

    // Returns the participant for the given address.
    function getParticipant(address addr) external view returns (Participant memory);

    // Collects the payout to a winner. Only callable when the Tournament is in the
    // Finished state and if the caller is a winner.
    function collectPayout() external;
}
