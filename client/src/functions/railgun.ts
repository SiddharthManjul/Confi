import { JsonRpcProvider, Wallet } from "ethers";
import { TEST_MNEMONIC, TEST_RPC_URL } from "../utils/constants";

/**
 * Creates and returns a provider and wallet for JSON-RPC interactions.
 *
 * This utility function initializes a JSON-RPC provider with a test URL
 * and creates a wallet from a test mnemonic phrase. Both the provider
 * and wallet are returned as an object.
 *
 * @returns An object containing the initialized provider and wallet
 * @property {JsonRpcProvider} provider - The JSON-RPC provider instance
 * @property {Wallet} wallet - The wallet instance created from the test mnemonic
 *
 * @example
 * const { provider, wallet } = getProviderWallet();
 * // Now use provider for RPC calls and wallet for signing transactions
 */
export const getProviderWallet = () => {
  const provider = new JsonRpcProvider(TEST_RPC_URL);
  const wallet = Wallet.fromPhrase(TEST_MNEMONIC, provider);

  return {
    provider,
    wallet,
  };
};