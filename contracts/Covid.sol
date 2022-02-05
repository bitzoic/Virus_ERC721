pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeCast.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Covid {
    
    using SafeCast for uint256;
    using SafeMath for uint256;

    event NewCovidVariant(uint16 rna);

    uint rna_digits = 16;
    uint max_variants = SafeMath.mod(2, rna_digits);

    struct Variant {
        uint16 rna;
    }

    Variant[] public variants;

    function createVariant() private returns (uint16 id) {
        require(variants.length < max_variants);
        uint16 rna = _randomVariantRNA();
        variants.push(Variant(rna));
        uint varId = variants.length;
        varId = varId.sub(1); 
        return varId.toUint16();
    }

    function _randomVariantRNA() internal returns (uint16 rna) {
        // Todo: Returns random uint16 value
    }

    function covidVariantExists() private view returns (bool) {
        return variants.length > 0;
    }
}