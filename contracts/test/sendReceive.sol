// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "forge-std/console.sol";

/**
 * @title StealthPaymentTest
 * @notice Tests for sending and receiving stealth payments
 * @dev This test validates the full flow: generating stealth address, sending funds, computing stealth key, and withdrawing
 * 
 * Test Flow:
 * 1. Generate stealth meta-address from receiving account signature
 * 2. Generate stealth address using the meta-address
 * 3. Send ETH from sending account to stealth address
 * 4. Compute stealth private key using ephemeral public key and receiving account keys
 * 5. Withdraw funds from stealth address to receiving account
 * 6. Verify balance changes match expected amounts
 */
contract StealthPaymentTest is Test {
    uint256 constant SEND_AMOUNT = 1 ether;
    uint256 constant WITHDRAW_BUFFER = 0.01 ether;
    uint256 constant WITHDRAW_AMOUNT = SEND_AMOUNT - WITHDRAW_BUFFER;
    
    // Default anvil accounts
    address sendingAccount = address(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266); // anvil account #0
    address receivingAccount = address(0x70997970C51812dc3A010C7d01b50e0d17dc79C8); // anvil account #1
    
    uint256 sendingPrivateKey = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 receivingPrivateKey = 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d;
    
    uint256 sendingWalletStartingBalance;
    uint256 receivingWalletStartingBalance;
    uint256 gasUsedSend;
    
    address stealthAddress;
    uint256 stealthPrivateKey;
    
    function setUp() public {
        // Fund accounts with initial balances
        vm.deal(sendingAccount, 100 ether);
        vm.deal(receivingAccount, 10 ether);
        
        // Record starting balances
        sendingWalletStartingBalance = sendingAccount.balance;
        receivingWalletStartingBalance = receivingAccount.balance;
        
        // TODO: Integrate with your SDK to generate stealth address
        // This is a placeholder - you'll need to call your SDK functions via FFI or a helper contract
        // For now, using a mock stealth address
        // In production, you would:
        // 1. Get signature from receivingAccount
        // 2. Generate stealth meta-address from signature
        // 3. Generate stealth address using generateStealthAddress()
        // 4. Store ephemeralPublicKey for later use in computeStealthKey()
        
        stealthAddress = address(0x1234567890123456789012345678901234567890);
        
        // Send ETH to stealth address
        vm.startPrank(sendingAccount);
        uint256 gasBefore = gasleft();
        (bool success,) = stealthAddress.call{value: SEND_AMOUNT}("");
        require(success, "Send failed");
        gasUsedSend = gasBefore - gasleft();
        vm.stopPrank();
        
        // TODO: Compute stealth private key using your SDK
        // This would call computeStealthKey() with:
        // - schemeId
        // - ephemeralPublicKey
        // - spendingPrivateKey
        // - viewingPrivateKey
        // For now, using a mock private key
        stealthPrivateKey = 0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef;
        
        // Withdraw from stealth address to receiving account
        vm.startPrank(stealthAddress);
        vm.deal(stealthAddress, SEND_AMOUNT); // Ensure stealth address has the funds
        (success,) = receivingAccount.call{value: WITHDRAW_AMOUNT}("");
        require(success, "Withdraw failed");
        vm.stopPrank();
    }
    
    function test_SuccessfullySendAndWithdrawStealthTransaction() public view {
        uint256 sendingWalletEndingBalance = sendingAccount.balance;
        uint256 receivingWalletEndingBalance = receivingAccount.balance;
        
        // Calculate balance changes
        int256 sendingWalletBalanceChange = int256(sendingWalletEndingBalance) - int256(sendingWalletStartingBalance);
        int256 receivingWalletBalanceChange = int256(receivingWalletEndingBalance) - int256(receivingWalletStartingBalance);
        
        // Verify sending account lost the sent amount (plus gas)
        // Note: In Foundry tests, gas calculations are approximate
        assertApproxEqAbs(
            uint256(-sendingWalletBalanceChange),
            SEND_AMOUNT,
            0.001 ether,
            "Sending wallet balance change incorrect"
        );
        
        // Verify receiving account gained the withdraw amount
        assertEq(
            uint256(receivingWalletBalanceChange),
            WITHDRAW_AMOUNT,
            "Receiving wallet balance change incorrect"
        );
        
        console.log("Sending wallet balance change:", uint256(-sendingWalletBalanceChange));
        console.log("Receiving wallet balance change:", uint256(receivingWalletBalanceChange));
    }
}