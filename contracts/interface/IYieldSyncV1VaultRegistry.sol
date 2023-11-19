// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


interface IYieldSyncV1VaultRegistry
{
	/**
	* @notice Getter for `_admin_yieldSyncV1Vaults`
	* @dev [view]
	* @param admin {address}
	* @return yieldSyncV1Vaults_ {address[]}
	*/
	function admin_yieldSyncV1Vaults(address admin)
		external
		view
		returns (address[] memory yieldSyncV1Vaults_)
	;

	/**
	* @notice Getter for `_member_yieldSyncV1Vaults`
	* @dev [view]
	* @param member {address}
	* @return yieldSyncV1Vaults_ {address[]}
	*/
	function member_yieldSyncV1Vaults(address member)
		external
		view
		returns (address[] memory yieldSyncV1Vaults_)
	;

	/**
	* @notice Getter for `_yieldSyncV1Vault_admins`
	* @dev [view]
	* @param yieldSyncV1Vault {address}
	* @return admins_ {address[]}
	*/
	function yieldSyncV1Vault_admins(address yieldSyncV1Vault)
		external
		view
		returns (address[] memory admins_)
	;

	/**
	* @notice Getter for `_yieldSyncV1Vault_members`
	* @dev [view]
	* @param yieldSyncV1Vault {address}
	* @return members_ {address[]}
	*/
	function yieldSyncV1Vault_members(address yieldSyncV1Vault)
		external
		view
		returns (address[] memory members_)
	;

	/**
	* @notice Getter for `_yieldSyncV1Vault_participant_access`
	* @dev [view]
	* @param participant {address}
	* @param yieldSyncV1Vault {address}
	* @return admin_ {bool}
	* @return member_ {bool}
	*/
	function yieldSyncV1Vault_participant_access(address yieldSyncV1Vault, address participant)
		external
		view
		returns (bool admin_, bool member_)
	;


	/**
	* @notice Add Admin
	* @dev [update] `_admin_yieldSyncV1Vaults`
	*      [update] `_yieldSyncV1Vault_admins`
	*      [update] `yieldSyncV1Vault_participant_access`
	* @param yieldSyncV1Vault {address}
	* @param admin {address}
	*/
	function adminAdd(address yieldSyncV1Vault, address admin)
		external
	;

	/**
	* @notice Remove Admin
	* @dev [update] `_admin_yieldSyncV1Vaults`
	*      [update] `_yieldSyncV1Vault_admins`
	*      [update] `yieldSyncV1Vault_participant_access`
	* @param yieldSyncV1Vault {address}
	* @param admin {address}
	*/
	function adminRemove(address yieldSyncV1Vault, address admin)
		external
	;

	/**
	* @notice Add Member
	* @dev [update] `_member_yieldSyncV1Vaults`
	*      [update] `_yieldSyncV1Vault_members`
	*      [update] `yieldSyncV1Vault_participant_access`
	* @param yieldSyncV1Vault {address}
	* @param member {address}
	*/
	function memberAdd(address yieldSyncV1Vault, address member)
		external
	;

	/**
	* @notice Remove Member
	* @dev [update] `_member_yieldSyncV1Vaults`
	*      [update] `_yieldSyncV1Vault_members`
	*      [update] `yieldSyncV1Vault_participant_access`
	* @param yieldSyncV1Vault {address}
	* @param member {address}
	*/
	function memberRemove(address yieldSyncV1Vault, address member)
		external
	;
}
