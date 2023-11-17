// Allows us to use ES6 in our migrations and tests.
require('babel-register')

module.exports = {
  networks: {
    development: {
      host: 'localhost',
      port: 7545,
      network_id: '*' // Match any network id
    }
  },
  compilers: {
    solc: {
      version: "./solc/soljson-v0.8.0+commit.c7dfd78e.js"
    }
  }
}
