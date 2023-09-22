# SmartWallet Contract

This is a Solidity smart contract for a simple wallet that allows users to deposit and withdraw funds, as well as transfer funds to other users.

## Getting Started

To use this contract, you will need to have a Solidity development environment set up that. This can be easily done in two ways:

1. You can use this Remix link:
   https://remix.ethereum.org/#version=soljson-v0.8.18+commit.87f61d96.js&optimize=false&runs=200&gist=

2. You can install the Solidity compiler and other necessary tools by following the instructions on the [Solidity website](https://solidity.readthedocs.io/en/v0.8.9/installing-solidity.html).

## Usage

The SmartWallet contract provides the following functions:

- `depositToAccount()`: This function allows users to deposit funds into their account. The amount to be deposited should be sent with the function call as ether.
- `withdrawFromAccount(uint256 _amount)`: This function allows users to withdraw funds from their account. The amount to be withdrawn should be specified as a parameter to the function call.
- `transferFunds(address _recipient, uint256 _amount)`: This function allows users to transfer funds to another user's account. The recipient's address and the amount to be transferred should be specified as parameters to the function call.

## Events

The SmartWallet contract emits the following events:

- `UserDepositedToAccount(address indexed account, uint256 amount)`: This event is emitted when a user deposits funds into their account.
- `UserWithdrawedFromAccount(address indexed account, uint256 amount)`: This event is emitted when a user withdraws funds from their account.
- `UserTransferedFunds(address indexed sender, address indexed recipient, uint256 amount)`: This event is emitted when a user transfers funds to another user's account.

## Error Handling

The SmartWallet contract throws the following errors:

- `NotSufficientBalance(uint256 requestAmount, uint256 balance)`: This error is thrown when a user attempts to withdraw more funds than they have in their account.
- `TransactionFailed()`: This error is thrown when a transaction fails for an unknown reason.
- `BadRequest()`: This error is thrown when a user sends a bad request to the contract.

## License

This contract is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
