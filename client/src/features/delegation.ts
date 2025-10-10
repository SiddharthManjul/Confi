import { Implementation, toMetaMaskSmartAccount } from "@metamask/delegation-toolkit"
import { createPublicClient, http } from "viem"
import { sepolia as chain } from "viem/chains"
import { privateKeyToAccount } from "viem/accounts"

const publicClient = createPublicClient({
  chain,
  transport: http(),
})

const delegatorAccount = privateKeyToAccount("0x...")

const delegatorSmartAccount = await toMetaMaskSmartAccount({
  client: publicClient,
  implementation: Implementation.Hybrid,
  deployParams: [delegatorAccount.address, [], [], []],
  deploySalt: "0x",
  signer: { account: delegatorAccount },
})

const delegateAccount = privateKeyToAccount("0x...")

const delegateSmartAccount = await toMetaMaskSmartAccount({
  client: publicClient,
  implementation: Implementation.Hybrid, // Hybrid smart account
  deployParams: [delegateAccount.address, [], [], []],
  deploySalt: "0x",
  signer: { account: delegateAccount },
})