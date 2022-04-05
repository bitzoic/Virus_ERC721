pragma solidity ^0.8.0;

import "./Hosts.sol";
import "./Virus.sol";

contract Infect is Hosts, Virus {

    uint infectChance = 80;

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
            if (hostA.vaccinated) 
            { 
                _vaxInfectChance(hostA, hostB);
            }
            else
            {
                _noVaxInfectChance(hostA, hostB);
            }
        }
    }

    function _noVaxInfectChance(
        Host storage _hostA, 
        Host storage _hostB) 
        internal {
            
    }

    function _vaxInfectChance(
        Host storage _hostA, 
        Host storage _hostB) 
        internal {
            
    }

    function _randomInfectChance() internal returns (uint) {
        // TODO: random chance function
    }
}