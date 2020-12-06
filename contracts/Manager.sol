pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/access/AccessControl.sol";
import "./Material.sol";
import "./Product.sol";
import "./Transaction.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "./libs/StringsBaseOperations.sol";

contract Manager is OwnableUpgradeSafe, AccessControlUpgradeSafe, StringsBaseOperations {

    using SafeMath for uint256;
    using Address for address;
    using Material for Material.Info;
    using Product for Product.Package;
    using Transaction for Transaction.Block;

    uint256 totalProducts;
    uint256 totalMaterials;
    uint256 totalTransactions;

    mapping(uint256 => Material.Info) materials;
    mapping(uint256 => Product.Package) products;
    mapping(uint256 => Transaction.Block) transactions;

    event CreatedTransaction(uint256 id);
    event CreatedProduct(uint256 id);
    event CreatedMaterial(uint256 id);
    event UpdatedTransactionStatus(uint256 id, string status);
    event UpdatedMaterialDescription(uint256 id, string description);

    function initialize() public initializer {
        __Ownable_init_unchained();
        __AccessControl_init_unchained();
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function initVariables() internal {
        totalMaterials = 0;
        totalMaterials = 0;
        totalTransactions = 0;
    }

    function createProduct(uint256 tokenId, string memory name, string memory _type, uint256 length, uint256 weight, uint256 height) external onlyOwner {
        uint256 id = totalProducts.add(1);
        products[tokenId] = Product.Package(id, name, _type, length, weight, height, true);

        emit CreatedProduct(tokenId);
    }

    function getProduct(uint256 tokenId) external view returns (Product.Package memory) {
        require(products[tokenId].exist, 'Manager: Product does not exist');
        return products[tokenId];
    }

    function createMaterial(uint256 tokenId, string memory name, string memory description, string memory _type, uint256 created_at) external onlyOwner {
        uint256 id = totalMaterials.add(1);
        materials[tokenId] = Material.Info(id, name, description, _type, created_at, true);

        emit CreatedMaterial(tokenId);
    }

    function getMaterial(uint256 tokenId) public view returns (Material.Info memory){
        require(materials[tokenId].exist, 'Manager: Material does not exist');
        return materials[tokenId];
    }

    function updateMaterialDescription(uint256 tokenId, string memory description) public onlyOwner {
        require(materials[tokenId].exist, 'Manager: Material does not exist');
        Material.Info storage material = materials[tokenId];
        material.description = description;

        emit UpdatedMaterialDescription(tokenId, description);
    }

    function createTransaction(uint256 txId, string memory from, string memory to, string memory status, string memory _type, string memory created_for, uint256 created_at, uint256 amount) onlyOwner public {
        uint256 id = totalTransactions.add(1);
        transactions[txId] = Transaction.Block(id, from, to, status, _type, created_for, created_at, amount, true);

        emit CreatedTransaction(txId);
    }

    function getTransaction(uint256 txId) public view returns (Transaction.Block memory) {
        require(transactions[txId].exist, 'Manager: Transaction does not exist');
        return transactions[txId];
    }

    function changeTransactionStatus(uint256 txId, string memory status) public onlyOwner {
        require(transactions[txId].exist, 'Manager: Transaction does not exist');
        Transaction.Block storage tx = transactions[txId];
        tx.status = status;

        emit UpdatedTransactionStatus(txId, status);
    }
}
