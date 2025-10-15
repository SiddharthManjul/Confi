import { NETWORK_CONFIG, NetworkName } from "@railgun-community/shared-models";
import dotenv from "dotenv";
dotenv.config();

if (process.env.RAILGUN_TEST_RPC == null) {
  throw new Error("No TEST RPC URL configured.");
}

/**
 * The network used for testing purposes.
 * Currently set to the Polygon network.
 * @constant {NetworkName}
 */
export const TEST_NETWORK = NetworkName.Polygon;

/**
 * The RPC URL for RAILGUN test environment.
 * This constant retrieves the URL from the RAILGUN_TEST_RPC environment variable.
 * Used for connecting to the test blockchain network for RAILGUN operations.
 */
export const TEST_RPC_URL = `${process.env.RAILGUN_TEST_RPC}`;

/**
 * The address of the wrapped base token for the test network.
 * This constant is derived from the network configuration for the test network.
 * @type {string}
 */
export const TEST_TOKEN = NETWORK_CONFIG[TEST_NETWORK].baseToken.wrappedAddress;

/**
 * The Ethereum address of a test NFT (Non-Fungible Token) contract.
 * This constant is used for testing purposes related to NFT functionality.
 * The actual address is abbreviated as "0x....".
 */
export const TEST_NFT_ADDRESS = "0x....";

/**
 * The sub-identifier for the test NFT.
 * This value is used to uniquely identify a specific NFT within a collection for testing purposes.
 * @constant {string}
 */
export const TEST_NFT_SUBID = "1";

/**
 * Test mnemonic phrase for RAILGUN.
 * Uses the environment variable RAILGUN_TEST_MNEMONIC if available,
 * otherwise falls back to a default test mnemonic.
 * @remarks This should only be used for testing purposes.
 */
export const TEST_MNEMONIC =
  process.env.RAILGUN_TEST_MNEMONIC ??
  "test test test test test test test test test test test junk";

/**
 * A constant representing a test encryption key for development purposes.
 * This is a 64-character hexadecimal string (32 bytes) that can be used as a placeholder
 * or default encryption key in test environments.
 *
 * @remarks
 * Do not use this key in production environments as it is a publicly known value.
 */
export const TEST_ENCRYPTION_KEY =
  "0101010101010101010101010101010101010101010101010101010101010101";