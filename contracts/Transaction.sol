pragma solidity ^0.6.0;

/**
* Transaction library
*/
library Transaction {

    struct Block {
        uint256 id;
        string from;
        string to;
        string status;
        string _type;
        string created_for;
        uint256 created_at;
        uint256 amount;
        bool exist;
    }
}
