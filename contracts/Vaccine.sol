pragma solidity ^0.8.0;

import "./Hosts.sol";

contract Vaccine is Hosts {

    event HostGotVaccine(uint256 hostId);

    uint256 vaccineInfectChance;

    function getVaccine(uint256 _hostId) public onlyOwnerOfHost(_hostId)
    {
        Host storage host = hosts[_hostId];
        host.vaxRNA = _randomRNA();
        host.vaccinated = true;
    }

    function _randomRNA() internal returns (uint16) 
    {
        // TODO: random function
    }

    function setVaccineInfectChance(uint256 chance) external onlyOwner 
    {
        vaccineInfectChance = chance;
    }
}