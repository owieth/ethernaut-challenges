# Foundry Setup Template Repo

## How to structure a Solidity Contract?

Layout of Contract (\*\*.sol):

- version
- imports
- interfaces, libraries, contracts
- usings (using ... for ...)
- errors
- Type declarations
- State variables
- Events
- Modifiers
- Functions

Layout of Functions (inside \*\*.sol after modifiers):

- constructor
- receive function (if exists)
- fallback function (if exists)
- external
- public
- internal
- private
- view & pure functions (last per group -> external, public, ...)

More --> [STYLE.md](./STYLE.md)

## Local Setup

Consolidate `.env.local` fill out `.env`

### Deploy contracts

```shell
# To give our shell access to our environment variables
source .env
# To deploy and verify our contract
forge script script/<scriptname>.s.sol:<contractname> --rpc-url <chain> --broadcast --verify -vvvvv

# concatenate the following if you want to verify the contract
# --verify -vvvvv

```

### Test contracts

Using foundry

```shell
forge test
# for more details, logging with emit, add verbosity 1 up to 5 v's
forge test -vvvv
```

### Local Blockchain with Anvil (Foundry)

Set up a local blockchain like this

```shell
# set up fresh local blockchain
anvil

# if you want to fork an existing blockchain, because you need to interact with existing contracts, e.g on goerli testnet
anvil -f https://eth-goerli.g.alchemy.com/v2/<your_api_keys>
```
