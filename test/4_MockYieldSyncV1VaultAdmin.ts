import { expect } from "chai";
import { Contract, ContractFactory } from "ethers";

const { ethers } = require("hardhat");


const stageContracts = async () => {
	const [owner, addr1, addr2] = await ethers.getSigners();

	const YieldSyncV1Vault: ContractFactory = await ethers.getContractFactory("YieldSyncV1Vault");
	const YieldSyncV1VaultFactory: ContractFactory = await ethers.getContractFactory("YieldSyncV1VaultFactory");
	const YieldSyncV1VaultRecord: ContractFactory = await ethers.getContractFactory("YieldSyncV1VaultRecord");
	const MockYieldSyncGovernance: ContractFactory = await ethers.getContractFactory("MockYieldSyncGovernance");
	const MockAdmin: ContractFactory = await ethers.getContractFactory("MockAdmin");
	const SignatureManager: ContractFactory = await ethers.getContractFactory("SignatureManager");

	// Deploy
	const mockYieldSyncGovernance: Contract = await (await MockYieldSyncGovernance.deploy()).deployed();
	const yieldSyncV1VaultRecord: Contract = await (await YieldSyncV1VaultRecord.deploy()).deployed();
	const yieldSyncV1VaultFactory: Contract = await (
		await YieldSyncV1VaultFactory.deploy(mockYieldSyncGovernance.address, yieldSyncV1VaultRecord.address)
	).deployed();

	// Deploy a vault
	await yieldSyncV1VaultFactory.deployYieldSyncV1Vault(
		owner.address,
		[addr1.address, addr2.address],
		ethers.constants.AddressZero,
		true,
		2,
		2,
		5,
		{ value: 1 }
	);

	// Attach the deployed vault's address
	const yieldSyncV1Vault: Contract = await YieldSyncV1Vault.attach(yieldSyncV1VaultFactory.yieldSyncV1VaultId_yieldSyncV1VaultAddress(0));

	const mockAdmin: Contract = await (await MockAdmin.deploy()).deployed();
	const signatureManager: Contract = await (
		await SignatureManager.deploy(mockYieldSyncGovernance.address, yieldSyncV1VaultRecord.address)
	).deployed();

	return {
		yieldSyncV1Vault,
		yieldSyncV1VaultFactory,
		yieldSyncV1VaultRecord,
		mockYieldSyncGovernance,
		mockAdmin,
		signatureManager
	};
};


describe("[4] MockAdmin.sol - Mock Admin Contract", async () => {
	let yieldSyncV1Vault: Contract;
	let yieldSyncV1VaultFactory: Contract;
	let yieldSyncV1VaultRecord: Contract;
	let mockYieldSyncGovernance: Contract;
	let mockAdmin: Contract;
	let signatureManager: Contract;


	before("[before] Set up contracts..", async () => {
		const [, addr1, addr2] = await ethers.getSigners();

		const stagedContracts = await stageContracts();

		yieldSyncV1Vault = stagedContracts.yieldSyncV1Vault;
		yieldSyncV1VaultFactory = stagedContracts.yieldSyncV1VaultFactory;
		yieldSyncV1VaultRecord = stagedContracts.yieldSyncV1VaultRecord;
		mockYieldSyncGovernance = stagedContracts.mockYieldSyncGovernance;
		mockAdmin = stagedContracts.mockAdmin;
		signatureManager = stagedContracts.signatureManager;

		await yieldSyncV1Vault.updateSignatureManager(signatureManager.address);

		// Send ether to YieldSyncV1Vault contract
		await addr1.sendTransaction({
			to: yieldSyncV1Vault.address,
			value: ethers.utils.parseEther("1")
		});

		await yieldSyncV1Vault.connect(addr1).createWithdrawalRequest(
			true,
			false,
			false,
			addr2.address,
			ethers.constants.AddressZero,
			ethers.utils.parseEther(".5"),
			0
		);
	});

	/**
	 * @dev Restriction: DEFAULT_ADMIN_ROLE
	*/
	describe("Restriction: DEFAULT_ADMIN_ROLE", async () => {
		describe("addAdmin()", async () => {
			it("Should allow admin to add a contract-based admin..", async () => {
				await yieldSyncV1Vault.addAdmin(mockAdmin.address);
			});
		});

		/**
		 * @dev deleteWithdrawalRequest
		*/
		describe("updateWithdrawalRequestLatestRelevantApproveVoteTime()", async () => {
			it(
				"Should update the latestRelevantApproveVoteTime to ADD seconds..",
				async () => {
					const beforeBlockTimestamp = BigInt((await yieldSyncV1Vault.withdrawalRequest(0))[10]);

					await mockAdmin.updateWithdrawalRequestLatestRelevantApproveVoteTime(
						yieldSyncV1Vault.address,
						0,
						true,
						4000
					);

					const afterBlockTimestamp = BigInt((await yieldSyncV1Vault.withdrawalRequest(0))[10]);

					expect(BigInt(beforeBlockTimestamp + BigInt(4000))).to.be.equal(afterBlockTimestamp);
				}
			);
		});
	});
});