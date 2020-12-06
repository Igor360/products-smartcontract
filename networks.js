require('dotenv').config();
const PrivateKeyProvider = require("truffle-privatekey-provider");
const HDWalletProvider = require('truffle-hdwallet-provider');
const {infuraMainAddress, infuraRopstenAddress} = require('./configs/api.config');
const wallet = require('./configs/wallet.config');


module.exports = {
    networks: {
        development: {
            protocol: 'http',
            host: 'localhost',
            port: 8545,
            gas: 5000000,
            gasPrice: 5e9,
            networkId: '*',
        },
        private: {
            provider: () => new PrivateKeyProvider(wallet.secret, "http://localhost:8545"),
            gas: 6700000,
            gasPrice: 10e9,
            networkId: '*',
            from: wallet.from
        },
        ropsten: {
            provider: () => new HDWalletProvider(wallet.mnemonic, infuraRopstenAddress),
            networkId: 3,       // Ropsten's id
        },
        main: {
            provider: () => new PrivateKeyProvider(wallet.secret, infuraMainAddress),
            networkId: 1,
        },
        zeroether: {
            protocol: 'http',
            host: '0.0.0.0',
            port: 8545,
            networkId: '*',
        }
    },
};
