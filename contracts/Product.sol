pragma solidity ^0.6.0;

/**
* Product library
*/
library Product {

    struct Package {
        uint256 id;
        string name;
        string _type;
        uint256 length;
        uint256 weight;
        uint256 height;
        bool exist;
    }
}
