// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { IAccessControlEnumerable } from "@openzeppelin/contracts/access/IAccessControlEnumerable.sol";

import { IIglooFiV1Vault, WithdrawalRequest } from "../interface/IIglooFiV1Vault.sol";


contract MockIglooFiV1VaultAdmin is Ownable {
	modifier isAdminOverIglooFiV1Vault(address iglooFiV1VaultAddress) {
		require(
			IAccessControlEnumerable(payable(iglooFiV1VaultAddress)).hasRole(
				IIglooFiV1Vault(payable(iglooFiV1VaultAddress)).VOTER(),
				address(this)
			), 
			"Not admin over"
		);

		_;
	}
	
	modifier validWithdrawalRequest(address iglooFiV1VaultAddress, uint256 withdrawalRequestId) {
		// [require] WithdrawalRequest exists
		require(
			IIglooFiV1Vault(payable(iglooFiV1VaultAddress)).withdrawalRequest(
				withdrawalRequestId
			).creator != address(0),
			"No WithdrawalRequest found"
		);
		
		_;
	}


	function updateWithdrawalRequestLatestRelevantApproveVoteTime(
		address iglooFiV1VaultAddress,
		uint256 withdrawalRequestId,
		bool arithmaticSign,
		uint256 timeInSeconds
	)
		public
		isAdminOverIglooFiV1Vault(iglooFiV1VaultAddress)
		validWithdrawalRequest(iglooFiV1VaultAddress, withdrawalRequestId)
	{
		WithdrawalRequest memory wR = IIglooFiV1Vault(payable(iglooFiV1VaultAddress)).withdrawalRequest(
			withdrawalRequestId
		);

		if (arithmaticSign)
		{
			// [update] WithdrawalRequest within `_withdrawalRequest`
			wR.latestRelevantApproveVoteTime += (timeInSeconds * 1 seconds);
		}
		else
		{
			// [update] WithdrawalRequest within `_withdrawalRequest`
			wR.latestRelevantApproveVoteTime -= (timeInSeconds * 1 seconds);
		}

		IIglooFiV1Vault(payable(iglooFiV1VaultAddress)).updateWithdrawalRequest(withdrawalRequestId, wR);
	}
}