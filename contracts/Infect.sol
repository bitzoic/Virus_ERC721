pragma solidity ^0.8.0;

import "./Hosts.sol";
import "./Virus.sol";
import "./Mask.sol";
import "@openzeppelin/contracts/utils/math/SafeCast.sol";

contract Infect is Hosts, Virus, Mask {

    using SafeCast for uint256;

    uint infectChance = 80;

    event HostInfected(uint256 hostId, uint256 variantId);

    function infectHost(uint _hostA, uint _hostB) public onlyOwnerOfHost(_hostA) {
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

    function _randomInfectChance() internal returns (uint) {
        // TODO: random chance function
    }
}