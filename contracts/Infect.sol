pragma solidity ^0.8.0;

import "./Hosts.sol";
import "./Virus.sol";

contract Infect is Hosts, Virus {

    uint infectChance = 80;

    event HostInfected(uint256 hostId, uint16 variantId);

    modifier onlyOwnerOfHost(uint _hostId) {
        require(msg.sender == hostToOwner[_hostId]);
        _;
    }

    function infectHost(uint _hostA, uint _hostB) private onlyOwnerOfHost(_hostA) {
        Host storage hostA = hosts[_hostA];
        Host storage hostB = hosts[_hostB];

        // If no one is infected then they can't infect one another
        require(hostA.infected == true || hostB.infected == true);

        // Determine to infect
        uint randChance = _randomInfectChance();

        if (randChance <= infectChance)
        {
            // Both hosts are infected
            if (hostA.infected == true && hostB.infected == true)
            {
                _infectBoth(hostA, hostB);
            }
            else if (hostA.infected == true)
            {
                _infectOne(hostA, hostB, _hostA);
            }
            else if (hostB.infected == true)
            {
                _infectOne(hostB, hostA, _hostB);
            }
        }
    }

    function _infectBoth(
        Host storage _hostA, 
        Host storage _hostB) 
        internal {
        // TODO: Mutate the virus
    }

    function _infectOne(
        Host storage _hostA, 
        Host storage _hostB,
        uint256 hostId) 
        internal {
        // Infect hostA
        _hostA.infected = true;
        _hostA.variantId = _hostB.variantId;
        emit HostInfected(hostId, _hostA.variantId);
    }

    function _randomInfectChance() internal returns (uint) {
        // TODO: random chance function
    }
}