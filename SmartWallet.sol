//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

error NotSufficientBalance(uint256 requestAmount, uint256 balance);
error TransactionFailed();
error BadRequest();

contract SmartWallet {
    mapping(address => Account) Accounts;

    struct Account {
        uint256 balance;
    }

    event UserDepositedToAccount(address indexed account, uint256 amount);
    event UserWithdrawedFromAccount(address indexed account, uint256 amount);
    event UserTransferedFunds(
        address indexed sender,
        address indexed recipient,
        uint256 amount
    );

    modifier checkSufficientBalance(uint256 _amount) {
        uint256 accountBalance = Accounts[msg.sender].balance;
        if (_amount > accountBalance)
            revert NotSufficientBalance(_amount, accountBalance);
        _;
    }

    fallback() external payable {
        revert BadRequest();
    }

    function depositToAccount() public payable {
        uint256 startingBalance = Accounts[msg.sender].balance;

        Accounts[msg.sender].balance += msg.value;
        emit UserDepositedToAccount({amount: msg.value, account: msg.sender});

        assert(startingBalance + msg.value == Accounts[msg.sender].balance);
    }

    function withdrawFromAccount(
        uint256 _amount
    ) public checkSufficientBalance(_amount) {
        uint256 startingBalance = Accounts[msg.sender].balance;

        Accounts[msg.sender].balance -= _amount;
        if (!payable(msg.sender).send(_amount)) revert TransactionFailed();
        emit UserWithdrawedFromAccount({amount: _amount, account: msg.sender});

        assert(startingBalance - _amount == Accounts[msg.sender].balance);
    }

    function transferFunds(
        uint256 _amount,
        address _recipient
    ) public checkSufficientBalance(_amount) {
        uint256 senderStartingBalance = Accounts[msg.sender].balance;
        uint256 recipientStartingBalance = Accounts[_recipient].balance;

        Accounts[msg.sender].balance -= _amount;
        Accounts[_recipient].balance += _amount;
        emit UserTransferedFunds({
            amount: _amount,
            sender: msg.sender,
            recipient: _recipient
        });

        assert(senderStartingBalance - _amount == Accounts[msg.sender].balance);
        assert(
            recipientStartingBalance + _amount == Accounts[_recipient].balance
        );
    }

    function getBalance() public view returns (uint256) {
        return Accounts[msg.sender].balance;
    }
}
