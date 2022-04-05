pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeCast.sol";

contract Virus {
    
    using SafeCast for uint256;

    event NewVirusVariant(uint16 rna);

    uint rna_digits = 16;
    uint max_variants = rna_digits % 2;

    struct Variant {
        uint16 rna;
    }

    Variant[] public variants;

    function createVariant() private returns (uint16 id) {
        require(variants.length < max_variants);
        uint16 rna = _randomVariantRNA();
        variants.push(Variant(rna));
        uint varId = variants.length;
        varId -= 1; 
        return varId.toUint16();
    }

    function _randomVariantRNA() internal returns (uint16 rna) {
        // Todo: Returns random uint16 value
    }

    function virusVariantExists() private view returns (bool) {
        return variants.length > 0;
    }
}