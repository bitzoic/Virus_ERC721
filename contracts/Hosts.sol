pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeCast.sol";

contract Hosts is Ownable {

    using SafeCast for uint32;

    uint mRNA_digits = 16;
    uint mRNA_modulus = 10 ** mRNA_digits;
    uint infectionTime = 1 days;

    event NewHost(uint id);

    struct Host {
        uint32 infectedTime;
        uint16 vaxRNA;
        uint16 variantId;
        bool infected;
        bool vaccinated;
        bool masked;
    }

    Host[] public hosts;

    mapping (uint => address) hostToOwner;
    mapping (address => uint) ownerHostCount;

    function _createHost() internal {
        hosts.push(Host(0, 0, 0, false, false, false));
        uint host_length = hosts.length;
        host_length -= 1;
        hostToOwner[host_length] = msg.sender;
        ownerHostCount[msg.sender] = ownerHostCount[msg.sender] + 1;
        emit NewHost(host_length);
    } 

    function createRandomHost() public {
        require(ownerHostCount[msg.sender] == 0);
        _createHost();
    }

    function setInfectionTime(uint _time) external onlyOwner {
        infectionTime = _time;
    }
}