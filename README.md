# Penny_Auction
基于区块链智能合约开发的竞拍系统

Webpack Truffle Box
This box it our most bare official implementation with Webpack. Includes contracts, migrations, tests, user interface and webpack build pipeline.

Installation
Install Truffle globally.

npm install -g truffle
Download the box. This also takes care of installing the necessary dependencies.

truffle unbox webpack
Run the development console.

truffle develop
Compile and migrate the smart contracts. Note inside the development console we don't preface commands with truffle.

compile
migrate
Run the webpack server for front-end hot reloading (outside the development console). Smart contract changes must be manually recompiled and migrated.

// Serves the front-end on http://localhost:8080
npm run dev
Truffle can run tests written in Solidity or JavaScript against your smart contracts. Note the command varies slightly if you're in or outside of the development console.

// If inside the development console.
test

// If outside the development console..
truffle test
FAQ
How do I use this with the EthereumJS TestRPC?

It's as easy as modifying the config file! Check out our documentation on adding network configurations. Depending on the port you're using, you'll also need to update lines 96 and 98 of app/javascripts/app.js.

I'm encountering this error: Error: Can't resolve '../build/contracts/MetaCoin.json'

This means you haven't compiled or migrated your contracts yet. Run truffle develop, compile and migrate first.

Full error:

ERROR in ./app/main.js
Module not found: Error: Can't resolve '../build/contracts/MetaCoin.json' in '/Users/tim/Documents/workspace/Consensys/test3/app'
 @ ./app/main.js 11:16-59
