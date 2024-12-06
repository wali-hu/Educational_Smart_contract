
---

# Educational Platform Smart Contracts

This project contains smart contracts for an educational platform. It includes:
- **EducationalToken (EDUT)**: An ERC20 token for rewards and transactions.
- **EducationalNFT (EDNFT)**: An ERC721 token that can be created by locking EDUT and redeemed to retrieve the locked tokens.
- **TokenDistributor**: A utility to distribute EDUT tokens as rewards.

## Features

1. **EducationalToken**:
   - Mintable ERC20 token named `Educational Token` with the symbol `EDUT`.
   - Only the contract owner can mint new tokens.

2. **EducationalNFT**:
   - ERC721 NFT with a value in EDUT tokens locked within it.
   - Users can create an NFT by locking EDUT and redeem it later to recover the tokens.

3. **TokenDistributor**:
   - Allows the owner to distribute EDUT tokens as rewards to students.
   - Includes a balance query feature.

---

## Deployment and Interaction in Remix IDE

### Prerequisites
1. Install **MetaMask** and connect to a test network (e.g., Goerli or local Ganache).
2. Obtain test ETH for deploying contracts.
3. Open [Remix IDE](https://remix.ethereum.org/) in your browser.

---

### Step 1: Deploy the Contracts

1. **Upload the Code**
   - Open Remix IDE.
   - Create a new file (e.g., `EducationalPlatform.sol`) and paste the smart contract code.

2. **Compile**
   - Select the `Solidity Compiler` tab in Remix.
   - Choose `0.8.0` or a compatible version and click **Compile**.

3. **Deploy EducationalToken**
   - Switch to the **Deploy & Run Transactions** tab.
   - Select the `EducationalToken` contract.
   - Deploy the contract by providing the initial owner's address (your wallet address) as a parameter.

4. **Deploy EducationalNFT**
   - Deploy `EducationalNFT` by providing:
     - The address of the `EducationalToken` contract.
     - The initial owner's address.

5. **Deploy TokenDistributor**
   - Deploy `TokenDistributor` by providing:
     - The address of the `EducationalToken` contract.
     - The initial owner's address.

---

### Step 2: Interact with the Contracts

1. **EducationalToken (EDUT)**
   - **Mint Tokens**:
     - Call `mint(amount)` to mint new tokens (e.g., `1000 * 10^18` for 1000 tokens).
   - **Check Balances**:
     - Use `balanceOf(address)` to check token balances.

2. **EducationalNFT (EDNFT)**
   - **Create NFT**:
     - Ensure the user has enough EDUT tokens.
     - Call `createNFT(amount)` to create an NFT by locking tokens.
   - **Redeem NFT**:
     - Call `redeemNFT(tokenId)` to burn the NFT and retrieve the locked tokens.

3. **TokenDistributor**
   - **Distribute Tokens**:
     - Call `distributeTokens(address student1, address student2, address student3, address[] remainingStudents)` to send tokens to specified addresses.
   - **Get Balance**:
     - Use `getStudentBalance(address)` to check a student’s EDUT balance.

---

## Example Interaction in Remix

1. **Mint Tokens**:
   - Owner calls `EducationalToken.mint(1000 * 10^18)` to mint 1000 EDUT tokens.

2. **Create NFT**:
   - Approve the contract to spend tokens:
     - Call `EducationalToken.approve(NFTContractAddress, 100 * 10^18)`.
   - Call `EducationalNFT.createNFT(100 * 10^18)` to create an NFT locking 100 EDUT.

3. **Redeem NFT**:
   - Call `EducationalNFT.redeemNFT(tokenId)` to redeem the NFT and retrieve the 100 EDUT.

4. **Distribute Rewards**:
   - Owner calls `TokenDistributor.distributeTokens(student1, student2, student3, [remainingStudents])` to distribute rewards.

---

## Testing Tips
1. Use MetaMask or a test wallet with enough ETH for transaction fees.
2. Verify token approvals before calling NFT creation or distribution functions.
3. Always test on a testnet or local blockchain (e.g., Ganache) before deploying to a live network.

---
