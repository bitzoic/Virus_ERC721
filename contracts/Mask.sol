pragma solidity ^0.8.0;

import "./Hosts.sol";

contract Mask is Hosts {

    uint256 maskInfectChance;

    event HostPutOnMask(uint256 hostId);
    event HostRemovedMask(uint256 hostId);

    function putOnMask(uint256 _hostId) public onlyOwnerOfHost(_hostId)
    {
        Host storage host = hosts[_hostId];
        host.masked = true;
        emit HostPutOnMask(_hostId);
    }

    function removeMask(uint256 _hostId) public onlyOwnerOfHost(_hostId)
    {
        Host storage host = hosts[_hostId];
        host.masked = true;
        emit HostRemovedMask(_hostId);
    }

    function setMaskInfectChance(uint256 chance) public onlyOwner 
    {
        maskInfectChance = chance;
    }
}