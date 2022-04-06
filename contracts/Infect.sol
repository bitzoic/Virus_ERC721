pragma solidity ^0.8.0;

import "./Hosts.sol";
import "./Virus.sol";
import "./Mask.sol";
import "./Vaccine.sol";
import "@openzeppelin/contracts/utils/math/SafeCast.sol";

contract Infect is Hosts, Virus, Mask, Vaccine {

    using SafeCast for uint256;

    uint baseInfectChance;

    event HostInfected(uint256 hostId, uint256 variantId);

    function infectHost(uint256 _hostA, uint256 _hostB) public onlyOwnerOfHost(_hostA) {
        Host storage hostA = hosts[_hostA];
        Host storage hostB = hosts[_hostB];

        // If no one is infected then they can't infect one another
        require(hostA.infected == true || hostB.infected == true);

        // Determine to infect
        uint256 randChance = _randombaseInfectChance();
        uint256 infectChance = getInfectChance(hostA, hostB);

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

    function _infectBoth(Host storage _hostA, Host storage _hostB) internal {
        Variant storage variantA = variants[_hostA.variantId];
        Variant storage variantB = variants[_hostB.variantId];
        
        // Mutate new virus
        uint256 newRna256 = (variantA.rna + variantB.rna) % rna_digits;
        uint16 newRna = newRna256.toUint16();
        variants.push(Variant(newRna));
        
        uint256 varId = variants.length - 1;
        _hostA.variantId = varId;
        _hostB.variantId = varId;
    }

    function _infectOne(Host storage _hostA, Host storage _hostB, uint256 hostId) internal {
        // Infect hostA
        _hostA.infected = true;
        _hostA.variantId = _hostB.variantId;
        emit HostInfected(hostId, _hostA.variantId);
    }

    function _randombaseInfectChance() internal returns (uint256) {
        // TODO: random chance function
    }

    function setBasebaseInfectChance(uint256 _chance) public onlyOwner {
        baseInfectChance = _chance;
    }

    function getInfectChance(Host storage _hostA, Host storage _hostB) private view returns (uint256) {
        uint256 infectChance = baseInfectChance;
        
        // Masks
        if (_hostA.masked)
        {
            infectChance -= maskInfectChance;
        }
        if (_hostB.masked)
        {
            infectChance -= maskInfectChance;
        }

        // Vaxinated
        if (_hostA.vaccinated)
        {
            // TODO: Remove vax infect chance for hostA
        }
        if (_hostB.vaccinated)
        {
            // TODO: Remove vax infect chance for hostB
        }

        return infectChance;
    }
}