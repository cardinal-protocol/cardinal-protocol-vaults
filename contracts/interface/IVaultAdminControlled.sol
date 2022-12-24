// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;


/* [import-internal] */
import "./IVault.sol";


/**
* @title IVIVaultAdminControlledult
*/
interface IVaultAdminControlled is
	IVault
{
	/**
	* @dev Emits when `requiredSignatures` are updated
	*/
	event UpdatedRequiredSignatures (
		uint256 requiredSignatures
	);

	/**
	* @dev Emits when a voter is added
	*/
	event VoterAdded (
		address addedVoter
	);

	/**
	* @dev Emits when a voter is removed
	*/
	event VoterRemoved (
		address addedVoter
	);

	/**
	* @dev Emits when `withdrawalDelayMinutes` is updated
	*/
	event UpdatedWithdrawalDelayMinutes (
		uint256 withdrawalDelayMinutes
	);

	/**
	* @dev Emits when a `WithdrawalRequest.paused` is toggled
	*/
	event ToggledWithdrawalRequestPause (
		bool withdrawalRequestPaused
	);


	/**
	* @notice Update amount of required signatures
	*
	* @dev [restriction][AccessControlEnumerable] DEFAULT_ADMIN_ROLE
	*
	* @dev [update] `requiredSignatures`
	*
	* @param newRequiredSignatures {uint256}
	* @return {bool} Status
	* @return {uint256} New `requiredSignatures`
	*
	* Emits: `UpdatedRequiredSignatures`
	*/
	function updateRequiredSignatures(uint256 newRequiredSignatures)
		external
		returns (bool, uint256)
	;

	/**
	* @notice Add a voter
	*
	* @dev [restriction][AccessControlEnumerable] DEFAULT_ADMIN_ROLE
	*
	* @dev [add] Voter to `AccessControl._roles` VOTER_ROLE
	*
	* @param voter {address} Address of the voter to add
	* @return {bool} Status
	* @return {address} Voter added
	*
	* Emits: `VoterAdded`
	*/
	function addVoter(address voter)
		external
		returns (bool, address)
	;

	/**
	* @notice Remove a voter
	*
	* @dev [restriction][AccessControlEnumerable] DEFAULT_ADMIN_ROLE
	*
	* @dev [remove] Voter with VOTER_ROLE from `AccessControl._roles`
	*
	* @param voter {address} Address of the voter to remove
	* @return {bool} Status
	* @return {address} Removed voter
	*
	* Emits: `VoterRemoved`
	*/	
	function removeVoter(address voter)
		external
		returns (bool, address)
	;

	/**
	* @notice Update `withdrawalDelayMinutes`
	*
	* @dev [restriction][AccessControlEnumerable] DEFAULT_ADMIN_ROLE
	*
	* @dev [update] `withdrawalDelayMinutes` to new value
	*
	* @param newWithdrawalDelayMinutes {uint256}
	* @return {bool} Status
	* @return {uint256} New `withdrawalDelayMinutes`
	*
	* Emits: `UpdatedWithdrawalDelayMinutes`
	*/
	function updateWithdrawalDelayMinutes(uint256 newWithdrawalDelayMinutes)
		external
		returns (bool, uint256)
	;

	/**
	* @notice Toggle pause on a WithdrawalRequest
	*
	* @dev [restriction][AccessControlEnumerable] DEFAULT_ADMIN_ROLE
	*
	* @dev [update] `_withdrawalRequest`
	*
	* @param withdrawalRequestId {uint256}
	* @return {bool} Status
	* @return {WithdrawalRequest} Updated WithdrawalRequest
	*
	* Emit: `ToggledWithdrawalRequestPause`
	*/
	function toggleWithdrawalRequestPause(uint256 withdrawalRequestId)
		external
		returns (bool, uint256)
	;

	/**
	* @notice Toggle pause on a WithdrawalRequest
	*
	* @dev [restriction][AccessControlEnumerable] DEFAULT_ADMIN_ROLE
	*
	* @dev [call][internal] {_deleteWithdrawalRequest}
	*
	* @param withdrawalRequestId {uint256}
	* @return {bool} Status
	*
	* Emits: `DeletedWithdrawalRequest`
	*/
	function deleteWithdrawalRequest(uint256 withdrawalRequestId)
		external
		returns (bool)
	;
}