Return-Path: <linux-wireless+bounces-27321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A213BB5730F
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 10:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A6E189E5AD
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344F0212548;
	Mon, 15 Sep 2025 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TTgxcB6c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01612F0663
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925315; cv=none; b=Fm22KyVufKn/TmKdU4fUoWHfd5KUvYGGp8sODIbx5tN/PeNA/g6Rv/ntOFybimin12ZaOnhyj2yB15DivIcP8Md3eHh8tILKTaDLKSDATCqwHhQuwtPOxl/iezFLcCR1xLbX+cpa7eYUTo10r//eHztbSLWwgF+G2UWCB6Dui5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925315; c=relaxed/simple;
	bh=+uq+4+fJrCu/SdZasVezw9P3CA9Z+YedAc4oWSr9pmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ctmCsfxJu+DtJyaeSdQ5z6PL65KOfSHSjYiOup7D7pmjlBvqWKnZ/MBcn3Ce1ABFIH0eUloL6LQzHukOXxD2yLcRRomwCUJZrHi5+r6SB5szCZf/HHSvrpmzeCCSmzqALgwiLQlNhmVh6U3oI3rpA77niczS5J8TSMZKxtGtGqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TTgxcB6c; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757925312; x=1789461312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+uq+4+fJrCu/SdZasVezw9P3CA9Z+YedAc4oWSr9pmw=;
  b=TTgxcB6c8HFqWZQcjSq8UgzY7BwEU7MiVaP0i8yMK5zEwyEbxizgdOoW
   5Pw6sA3Q/DcWQdQkj5eJ/6HNDSYgZ1jobdgo/wZ4ICri9R4+eyTbPR8x1
   /Q9BcVA1297n5OFo9/75DgNoDYLwg4ZJ+jHi01i8P028iB5RAXaw3CXK+
   yWbnuPixysMrIZAUJsROQmvieqxAluL7uGpwLuy8OLGCySG7QOv1y92Uu
   7QHwVng7wWkggbo07xnQEVYHHOQ8C1S3IJ1yQtLyZFYOHi8q93iabpa77
   z7kJ+zqcUDmapXzUjdrdVfBec9DqKO9fE30qCLpIdlm5uuCQO3K4AwhhK
   w==;
X-CSE-ConnectionGUID: kGeTnepbTTunq2Ig2hh/GQ==
X-CSE-MsgGUID: wNozBXpjTYehsZ9QL3y7OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59213084"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="59213084"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:12 -0700
X-CSE-ConnectionGUID: SOAUHWlGTeao3dC5MDJE4w==
X-CSE-MsgGUID: qu45C+k+R8y2AiZ1TCvyKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="178569902"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/11] wifi: iwlwifi: fix remaining kernel-doc warnings
Date: Mon, 15 Sep 2025 11:34:29 +0300
Message-Id: <20250915113137.f94b6d4ef142.I91007eed4cf37125ca7a012f2021615b4fa9eb66@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
References: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Fix the remaining kernel-doc warnings across the driver.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  1 +
 .../wireless/intel/iwlwifi/fw/api/cmdhdr.h    |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/coex.h  |  4 +-
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 14 ++--
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |  2 +-
 .../wireless/intel/iwlwifi/fw/api/location.h  |  8 +-
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  5 +-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 78 ++++++++++---------
 .../net/wireless/intel/iwlwifi/fw/api/sta.h   |  6 +-
 .../net/wireless/intel/iwlwifi/fw/api/stats.h | 39 +++++-----
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  2 +-
 .../wireless/intel/iwlwifi/fw/error-dump.h    |  4 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  | 74 +++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/img.h   | 12 ++-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   | 22 +++++-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  |  3 +-
 .../wireless/intel/iwlwifi/iwl-modparams.h    |  4 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    | 17 ++--
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |  1 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  6 +-
 22 files changed, 194 insertions(+), 118 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 20bc6671f4eb..06cece4ea6d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -151,6 +151,7 @@ union acpi_object *iwl_acpi_get_dsm_object(struct device *dev, int rev,
  * @mcc: output buffer (3 bytes) that will get the MCC
  *
  * This function tries to read the current MCC from ACPI if available.
+ * Return: 0 on success, or a negative error code
  */
 int iwl_acpi_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/cmdhdr.h b/drivers/net/wireless/intel/iwlwifi/fw/api/cmdhdr.h
index d130d4f85444..073f003bdc5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/cmdhdr.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/cmdhdr.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014 Intel Corporation
+ * Copyright (C) 2005-2014, 2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -98,7 +98,7 @@ struct iwl_cmd_header {
 } __packed;
 
 /**
- * struct iwl_cmd_header_wide
+ * struct iwl_cmd_header_wide - wide command header
  *
  * This header format appears in the beginning of each command sent from the
  * driver, and each response/notification received from uCode.
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
index ddc84430d895..616f00a8b603 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2023-2024 Intel Corporation
+ * Copyright (C) 2023-2025 Intel Corporation
  * Copyright (C) 2013-2014, 2018-2019 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2017 Intel Deutschland GmbH
@@ -52,7 +52,7 @@ struct iwl_bt_coex_cmd {
 } __packed; /* BT_COEX_CMD_API_S_VER_6 */
 
 /**
- * struct iwl_bt_coex_reduced_txp_update_cmd
+ * struct iwl_bt_coex_reduced_txp_update_cmd - reduced TX power command
  * @reduced_txp: bit BT_REDUCED_TX_POWER_BIT to enable / disable, rest of the
  *	bits are the sta_id (value)
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 3173fa96cb48..b62f0687327a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -16,7 +16,7 @@
 #define IWL_FW_INI_PRESET_DISABLE		0xff
 
 /**
- * struct iwl_fw_ini_hcmd
+ * struct iwl_fw_ini_hcmd - debug configuration host command
  *
  * @id: the debug configuration command type for instance: 0xf6 / 0xf5 / DHC
  * @group: the desired cmd group
@@ -199,7 +199,7 @@ struct iwl_fw_ini_region_tlv {
 } __packed; /* FW_TLV_DEBUG_REGION_API_S_VER_1 */
 
 /**
- * struct iwl_fw_ini_debug_info_tlv
+ * struct iwl_fw_ini_debug_info_tlv - debug info TLV
  *
  * debug configuration name for a specific image
  *
@@ -311,7 +311,7 @@ struct iwl_fw_ini_conf_set_tlv {
 } __packed; /* FW_TLV_DEBUG_CONFIG_SET_API_S_VER_1 */
 
 /**
- * enum iwl_fw_ini_config_set_type
+ * enum iwl_fw_ini_config_set_type - configuration set type
  *
  * @IWL_FW_INI_CONFIG_SET_TYPE_INVALID: invalid config set
  * @IWL_FW_INI_CONFIG_SET_TYPE_DEVICE_PERIPHERY_MAC: for PERIPHERY MAC configuration
@@ -337,7 +337,7 @@ enum iwl_fw_ini_config_set_type {
 } __packed;
 
 /**
- * enum iwl_fw_ini_allocation_id
+ * enum iwl_fw_ini_allocation_id - allocation ID
  *
  * @IWL_FW_INI_ALLOCATION_INVALID: invalid
  * @IWL_FW_INI_ALLOCATION_ID_DBGC1: allocation meant for DBGC1 configuration
@@ -356,7 +356,7 @@ enum iwl_fw_ini_allocation_id {
 }; /* FW_DEBUG_TLV_ALLOCATION_ID_E_VER_1 */
 
 /**
- * enum iwl_fw_ini_buffer_location
+ * enum iwl_fw_ini_buffer_location - buffer location
  *
  * @IWL_FW_INI_LOCATION_INVALID: invalid
  * @IWL_FW_INI_LOCATION_SRAM_PATH: SRAM location
@@ -373,7 +373,7 @@ enum iwl_fw_ini_buffer_location {
 }; /* FW_DEBUG_TLV_BUFFER_LOCATION_E_VER_1 */
 
 /**
- * enum iwl_fw_ini_region_type
+ * enum iwl_fw_ini_region_type - region type
  *
  * @IWL_FW_INI_REGION_INVALID: invalid
  * @IWL_FW_INI_REGION_TLV: uCode and debug TLVs
@@ -437,7 +437,7 @@ enum iwl_fw_ini_region_device_memory_subtype {
 }; /* FW_TLV_DEBUG_REGION_DEVICE_MEMORY_SUBTYPE_API_E */
 
 /**
- * enum iwl_fw_ini_time_point
+ * enum iwl_fw_ini_time_point - time point type
  *
  * Hard coded time points in which the driver can send hcmd or perform dump
  * collection
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index 0cf1e5124fba..61a850de26fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -421,7 +421,7 @@ struct iwl_dbgc1_info {
 } __packed; /* INIT_DRAM_FRAGS_ALLOCATIONS_S_VER_1 */
 
 /**
- * struct iwl_dbg_host_event_cfg_cmd
+ * struct iwl_dbg_host_event_cfg_cmd - host event config command
  * @enabled_severities: enabled severities
  */
 struct iwl_dbg_host_event_cfg_cmd {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 33541f92c7c7..2ee3a48aa5df 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -1092,7 +1092,7 @@ struct iwl_tof_range_req_ap_entry {
 } __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_9 */
 
 /**
- * enum iwl_tof_response_mode
+ * enum iwl_tof_response_mode - TOF response mode
  * @IWL_MVM_TOF_RESPONSE_ASAP: report each AP measurement separately as soon as
  *			       possible (not supported for this release)
  * @IWL_MVM_TOF_RESPONSE_TIMEOUT: report all AP measurements as a batch upon
@@ -1108,7 +1108,7 @@ enum iwl_tof_response_mode {
 };
 
 /**
- * enum iwl_tof_initiator_flags
+ * enum iwl_tof_initiator_flags - TOF initiator flags
  *
  * @IWL_TOF_INITIATOR_FLAGS_FAST_ALGO_DISABLED: disable fast algo, meaning run
  *	the algo on ant A+B, instead of only one of them.
@@ -1409,7 +1409,7 @@ enum iwl_tof_range_request_status {
 };
 
 /**
- * enum iwl_tof_entry_status
+ * enum iwl_tof_entry_status - TOF entry status
  *
  * @IWL_TOF_ENTRY_SUCCESS: successful measurement.
  * @IWL_TOF_ENTRY_GENERAL_FAILURE: General failure.
@@ -1856,7 +1856,7 @@ struct iwl_tof_mcsi_notif {
 } __packed;
 
 /**
- * struct iwl_tof_range_abort_cmd
+ * struct iwl_tof_range_abort_cmd - TOF range abort command
  * @request_id: corresponds to a range request
  * @reserved: reserved
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 5eb8d10678fd..535864e22626 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -620,7 +620,7 @@ struct iwl_sar_offset_mapping_cmd {
 } __packed; /*SAR_OFFSET_MAPPING_TABLE_CMD_API_S*/
 
 /**
- * struct iwl_beacon_filter_cmd
+ * struct iwl_beacon_filter_cmd - beacon filter command
  * REPLY_BEACON_FILTERING_CMD = 0xd2 (command)
  * @bf_energy_delta: Used for RSSI filtering, if in 'normal' state. Send beacon
  *      to driver if delta in Energy values calculated for this and last
@@ -762,7 +762,7 @@ enum iwl_6ghz_ap_type {
 }; /* PHY_AP_TYPE_API_E_VER_1 */
 
 /**
- * struct iwl_txpower_constraints_cmd
+ * struct iwl_txpower_constraints_cmd - TX power constraints command
  * AP_TX_POWER_CONSTRAINTS_CMD
  * Used for VLP/LPI/AFC Access Point power constraints for 6GHz channels
  * @link_id: linkId
@@ -786,4 +786,5 @@ struct iwl_txpower_constraints_cmd {
 	__s8 psd_pwr[IWL_MAX_TX_EIRP_PSD_PWR_MAX_SIZE];
 	u8 reserved[3];
 } __packed; /* PHY_AP_TX_POWER_CONSTRAINTS_CMD_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_power_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index f486d624500b..60f0a4924ddf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -129,7 +129,7 @@ struct iwl_scan_offload_profile {
 } __packed;
 
 /**
- * struct iwl_scan_offload_profile_cfg_data
+ * struct iwl_scan_offload_profile_cfg_data - scan offload profile configs
  * @blocklist_len:	length of blocklist
  * @num_profiles:	num of profiles in the list
  * @match_notify:	clients waiting for match found notification
@@ -159,7 +159,7 @@ struct iwl_scan_offload_profile_cfg_v1 {
 } __packed; /* SCAN_OFFLOAD_PROFILES_CFG_API_S_VER_1-2*/
 
 /**
- * struct iwl_scan_offload_profile_cfg
+ * struct iwl_scan_offload_profile_cfg - scan offload profile config
  * @profiles:	profiles to search for match
  * @data:	the rest of the data for profile_cfg
  */
@@ -507,7 +507,7 @@ enum iwl_uhb_chan_cfg_flags {
 	IWL_UHB_CHAN_CFG_FLAG_FORCE_PASSIVE         = BIT(26),
 };
 /**
- * struct iwl_scan_dwell
+ * struct iwl_scan_dwell - scan dwell configuration
  * @active:		default dwell time for active scan
  * @passive:		default dwell time for passive scan
  * @fragmented:		default dwell time for fragmented scan
@@ -728,7 +728,7 @@ enum iwl_umac_scan_general_params_flags2 {
 };
 
 /**
- * struct iwl_scan_channel_cfg_umac
+ * struct iwl_scan_channel_cfg_umac - scan channel config
  * @flags:		bitmap - 0-19:	directed scan to i'th ssid.
  * @channel_num:	channel number 1-13 etc.
  * @v1:			command version 1
@@ -774,7 +774,7 @@ struct  iwl_scan_channel_cfg_umac {
 } __packed;
 
 /**
- * struct iwl_scan_umac_schedule
+ * struct iwl_scan_umac_schedule - scan schedule parameters
  * @interval: interval in seconds between scan iterations
  * @iter_count: num of scan iterations for schedule plan, 0xff for infinite loop
  * @reserved: for alignment and future use
@@ -815,7 +815,7 @@ struct iwl_scan_req_umac_tail_v2 {
 } __packed;
 
 /**
- * struct iwl_scan_umac_chan_param
+ * struct iwl_scan_umac_chan_param - scan channel parameters
  * @flags: channel flags &enum iwl_scan_channel_flags
  * @count: num of channels in scan request
  * @reserved: for future use and alignment
@@ -827,33 +827,37 @@ struct iwl_scan_umac_chan_param {
 } __packed; /*SCAN_CHANNEL_PARAMS_API_S_VER_1 */
 
 /**
- * struct iwl_scan_req_umac
+ * struct iwl_scan_req_umac - scan request command
  * @flags: &enum iwl_umac_scan_flags
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
  * @ooc_priority: out of channel priority - &enum iwl_scan_priority
  * @general_flags: &enum iwl_umac_scan_general_flags
+ * @reserved: reserved
  * @scan_start_mac_id: report the scan start TSF time according to this mac TSF
- * @extended_dwell: dwell time for channels 1, 6 and 11
- * @active_dwell: dwell time for active scan per LMAC
- * @passive_dwell: dwell time for passive scan per LMAC
- * @fragmented_dwell: dwell time for fragmented passive scan
- * @adwell_default_n_aps: for adaptive dwell the default number of APs
+ * @v1: version 1 command data
+ * @v6: version 6 command data
+ * @v7: version 7 command data
+ * @v8: version 8 command data
+ * @v9: version 9 command data
+ * @v1.extended_dwell: dwell time for channels 1, 6 and 11
+ * @v1.active_dwell: dwell time for active scan per LMAC
+ * @v1.passive_dwell: dwell time for passive scan per LMAC
+ * @v1.fragmented_dwell: dwell time for fragmented passive scan
+ * @v7.adwell_default_n_aps: for adaptive dwell the default number of APs
  *	per channel
- * @adwell_default_n_aps_social: for adaptive dwell the default
+ * @v7.adwell_default_n_aps_social: for adaptive dwell the default
  *	number of APs per social (1,6,11) channel
- * @general_flags2: &enum iwl_umac_scan_general_flags2
- * @adwell_max_budget: for adaptive dwell the maximal budget of TU to be added
- *	to total scan time
- * @max_out_time: max out of serving channel time, per LMAC - for CDB there
- *	are 2 LMACs
- * @suspend_time: max suspend time, per LMAC - for CDB there are 2 LMACs
- * @scan_priority: scan internal prioritization &enum iwl_scan_priority
- * @num_of_fragments: Number of fragments needed for full coverage per band.
+ * @v8.general_flags2: &enum iwl_umac_scan_general_flags2
+ * @v7.adwell_max_budget: for adaptive dwell the maximal budget of TU to be
+ *	added to total scan time
+ * @v1.max_out_time: max out of serving channel time, per LMAC - for CDB
+ *	there are 2 LMACs
+ * @v1.suspend_time: max suspend time, per LMAC - for CDB there are 2 LMACs
+ * @v1.scan_priority: scan internal prioritization &enum iwl_scan_priority
+ * @v8.num_of_fragments: Number of fragments needed for full coverage per band.
  *	Relevant only for fragmented scan.
- * @channel: &struct iwl_scan_umac_chan_param
- * @reserved: for future use and alignment
- * @reserved3: for future use and alignment
- * @data: &struct iwl_scan_channel_cfg_umac and
+ * @v1.channel: &struct iwl_scan_umac_chan_param
+ * @v1.data: &struct iwl_scan_channel_cfg_umac and
  *	&struct iwl_scan_req_umac_tail
  */
 struct iwl_scan_req_umac {
@@ -939,7 +943,7 @@ struct iwl_scan_req_umac {
 #define IWL_SCAN_REQ_UMAC_SIZE_V1 36
 
 /**
- * struct iwl_scan_probe_params_v3
+ * struct iwl_scan_probe_params_v3 - scan probe parameters
  * @preq: scan probe request params
  * @ssid_num: number of valid SSIDs in direct scan array
  * @short_ssid_num: number of valid short SSIDs in short ssid array
@@ -961,7 +965,7 @@ struct iwl_scan_probe_params_v3 {
 } __packed; /* SCAN_PROBE_PARAMS_API_S_VER_3 */
 
 /**
- * struct iwl_scan_probe_params_v4
+ * struct iwl_scan_probe_params_v4 - scan probe parameters
  * @preq: scan probe request params
  * @short_ssid_num: number of valid short SSIDs in short ssid array
  * @bssid_num: number of valid bssid in bssids array
@@ -983,7 +987,7 @@ struct iwl_scan_probe_params_v4 {
 #define SCAN_MAX_NUM_CHANS_V3 67
 
 /**
- * struct iwl_scan_channel_params_v4
+ * struct iwl_scan_channel_params_v4 - channel params
  * @flags: channel flags &enum iwl_scan_channel_flags
  * @count: num of channels in scan request
  * @num_of_aps_override: override the number of APs the FW uses to calculate
@@ -1006,7 +1010,7 @@ struct iwl_scan_channel_params_v4 {
 	       SCAN_CHANNEL_PARAMS_API_S_VER_5 */
 
 /**
- * struct iwl_scan_channel_params_v7
+ * struct iwl_scan_channel_params_v7 - channel params
  * @flags: channel flags &enum iwl_scan_channel_flags
  * @count: num of channels in scan request
  * @n_aps_override: override the number of APs the FW uses to calculate dwell
@@ -1024,7 +1028,7 @@ struct iwl_scan_channel_params_v7 {
 } __packed; /* SCAN_CHANNEL_PARAMS_API_S_VER_6 */
 
 /**
- * struct iwl_scan_general_params_v11
+ * struct iwl_scan_general_params_v11 - channel params
  * @flags: &enum iwl_umac_scan_general_flags_v2
  * @reserved: reserved for future
  * @scan_start_mac_or_link_id: report the scan start TSF time according to this
@@ -1066,7 +1070,7 @@ struct iwl_scan_general_params_v11 {
 } __packed; /* SCAN_GENERAL_PARAMS_API_S_VER_12, *_VER_11  and *_VER_10 */
 
 /**
- * struct iwl_scan_periodic_parms_v1
+ * struct iwl_scan_periodic_parms_v1 - periodicity parameters
  * @schedule: can scheduling parameter
  * @delay: initial delay of the periodic scan in seconds
  * @reserved: reserved for future
@@ -1078,7 +1082,7 @@ struct iwl_scan_periodic_parms_v1 {
 } __packed; /* SCAN_PERIODIC_PARAMS_API_S_VER_1 */
 
 /**
- * struct iwl_scan_req_params_v12
+ * struct iwl_scan_req_params_v12 - scan request parameters (v12)
  * @general_params: &struct iwl_scan_general_params_v11
  * @channel_params: &struct iwl_scan_channel_params_v4
  * @periodic_params: &struct iwl_scan_periodic_parms_v1
@@ -1106,7 +1110,7 @@ struct iwl_scan_req_params_v17 {
 } __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_17 - 14 */
 
 /**
- * struct iwl_scan_req_umac_v12
+ * struct iwl_scan_req_umac_v12 - scan request command (v12)
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
  * @ooc_priority: out of channel priority - &enum iwl_scan_priority
  * @scan_params: scan parameters
@@ -1130,7 +1134,7 @@ struct iwl_scan_req_umac_v17 {
 } __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_17 - 14 */
 
 /**
- * struct iwl_umac_scan_abort
+ * struct iwl_umac_scan_abort - scan abort command
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
  * @flags: reserved
  */
@@ -1140,7 +1144,7 @@ struct iwl_umac_scan_abort {
 } __packed; /* SCAN_ABORT_CMD_UMAC_API_S_VER_1 */
 
 /**
- * enum iwl_umac_scan_abort_status
+ * enum iwl_umac_scan_abort_status - scan abort status
  *
  * @IWL_UMAC_SCAN_ABORT_STATUS_SUCCESS: scan was successfully aborted
  * @IWL_UMAC_SCAN_ABORT_STATUS_IN_PROGRESS: scan abort is in progress
@@ -1153,7 +1157,7 @@ enum iwl_umac_scan_abort_status {
 };
 
 /**
- * struct iwl_umac_scan_complete
+ * struct iwl_umac_scan_complete - scan complete notification
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
  * @last_schedule: last scheduling line
  * @last_iter: last scan iteration number
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
index ecbcd5084cd8..e6f9abdfa546 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2021, 2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021, 2023, 2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -428,7 +428,7 @@ struct iwl_mvm_rm_sta_cmd {
 } __packed; /* REMOVE_STA_CMD_API_S_VER_2 */
 
 /**
- * struct iwl_mvm_mgmt_mcast_key_cmd_v1
+ * struct iwl_mvm_mgmt_mcast_key_cmd_v1 - IGTK command
  * ( MGMT_MCAST_KEY = 0x1f )
  * @ctrl_flags: &enum iwl_sta_key_flag
  * @igtk: IGTK key material
@@ -449,7 +449,7 @@ struct iwl_mvm_mgmt_mcast_key_cmd_v1 {
 } __packed; /* SEC_MGMT_MULTICAST_KEY_CMD_API_S_VER_1 */
 
 /**
- * struct iwl_mvm_mgmt_mcast_key_cmd
+ * struct iwl_mvm_mgmt_mcast_key_cmd - IGTK command
  * ( MGMT_MCAST_KEY = 0x1f )
  * @ctrl_flags: &enum iwl_sta_key_flag
  * @igtk: IGTK master key
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
index 00713a991879..8d9a5058d5a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
@@ -26,7 +26,7 @@ struct mvm_statistics_div {
 } __packed; /* STATISTICS_SLOW_DIV_API_S_VER_2 */
 
 /**
- * struct mvm_statistics_rx_non_phy
+ * struct mvm_statistics_rx_non_phy - non-PHY RX statistics
  * @bogus_cts: CTS received when not expecting CTS
  * @bogus_ack: ACK received when not expecting ACK
  * @non_channel_beacons: beacons with our bss id but not on our serving channel
@@ -456,7 +456,7 @@ struct iwl_system_statistics_cmd {
 } __packed; /* STATISTICS_FW_CMD_API_S_VER_1 */
 
 /**
- * enum iwl_fw_statistics_type
+ * enum iwl_fw_statistics_type - statistics type
  *
  * @FW_STATISTICS_OPERATIONAL: operational statistics
  * @FW_STATISTICS_PHY: phy statistics
@@ -478,7 +478,7 @@ enum iwl_fw_statistics_type {
 
 #define IWL_STATISTICS_TYPE_MSK 0x7f
 /**
- * struct iwl_statistics_ntfy_hdr
+ * struct iwl_statistics_ntfy_hdr - statistics notification header
  *
  * @type: struct type
  * @version: version of the struct
@@ -491,7 +491,7 @@ struct iwl_statistics_ntfy_hdr {
 }; /* STATISTICS_NTFY_HDR_API_S_VER_1 */
 
 /**
- * struct iwl_stats_ntfy_per_link
+ * struct iwl_stats_ntfy_per_link - per-link statistics
  *
  * @beacon_filter_average_energy: Average energy [-dBm] of the 2
  *	 antennas.
@@ -514,7 +514,7 @@ struct iwl_stats_ntfy_per_link {
 } __packed; /* STATISTICS_NTFY_PER_LINK_API_S_VER_1 */
 
 /**
- * struct iwl_stats_ntfy_part1_per_link
+ * struct iwl_stats_ntfy_part1_per_link - part1 per link statistics
  *
  * @rx_time: rx time
  * @tx_time: tx time
@@ -533,7 +533,7 @@ struct iwl_stats_ntfy_part1_per_link {
 } __packed; /* STATISTICS_FW_NTFY_OPERATIONAL_PART1_PER_LINK_API_S_VER_1 */
 
 /**
- * struct iwl_stats_ntfy_per_mac
+ * struct iwl_stats_ntfy_per_mac - per MAC statistics
  *
  * @beacon_filter_average_energy: Average energy [-dBm] of the 2
  *	 antennas.
@@ -556,7 +556,8 @@ struct iwl_stats_ntfy_per_mac {
 } __packed; /* STATISTICS_NTFY_PER_MAC_API_S_VER_1 */
 
 #define IWL_STATS_MAX_BW_INDEX 5
-/** struct iwl_stats_ntfy_per_phy
+/**
+ * struct iwl_stats_ntfy_per_phy - per PHY statistics
  * @channel_load: channel load
  * @channel_load_by_us: device contribution to MCLM
  * @channel_load_not_by_us: other devices' contribution to MCLM
@@ -588,7 +589,7 @@ struct iwl_stats_ntfy_per_phy {
 #define IWL_STATS_UNKNOWN_CHANNEL_LOAD	0xffffffff
 
 /**
- * struct iwl_stats_ntfy_per_sta
+ * struct iwl_stats_ntfy_per_sta - per STA statistics
  *
  * @average_energy: in fact it is minus the energy..
  */
@@ -600,7 +601,7 @@ struct iwl_stats_ntfy_per_sta {
 #define IWL_STATS_MAX_FW_LINKS	(IWL_FW_MAX_LINK_ID + 1)
 
 /**
- * struct iwl_system_statistics_notif_oper
+ * struct iwl_system_statistics_notif_oper - statistics notification
  *
  * @time_stamp: time when the notification is sent from firmware
  * @per_link: per link statistics, &struct iwl_stats_ntfy_per_link
@@ -615,7 +616,7 @@ struct iwl_system_statistics_notif_oper {
 } __packed; /* STATISTICS_FW_NTFY_OPERATIONAL_API_S_VER_3 */
 
 /**
- * struct iwl_system_statistics_part1_notif_oper
+ * struct iwl_system_statistics_part1_notif_oper - part1 stats notification
  *
  * @time_stamp: time when the notification is sent from firmware
  * @per_link: per link statistics &struct iwl_stats_ntfy_part1_per_link
@@ -628,7 +629,7 @@ struct iwl_system_statistics_part1_notif_oper {
 } __packed; /* STATISTICS_FW_NTFY_OPERATIONAL_PART1_API_S_VER_4 */
 
 /**
- * struct iwl_system_statistics_end_notif
+ * struct iwl_system_statistics_end_notif - statistics end notification
  *
  * @time_stamp: time when the notification is sent from firmware
  */
@@ -637,7 +638,7 @@ struct iwl_system_statistics_end_notif {
 } __packed; /* STATISTICS_FW_NTFY_END_API_S_VER_1 */
 
 /**
- * struct iwl_statistics_operational_ntfy
+ * struct iwl_statistics_operational_ntfy - operational stats notification
  *
  * @hdr: general statistics header
  * @flags: bitmap of possible notification structures
@@ -662,7 +663,7 @@ struct iwl_statistics_operational_ntfy {
 } __packed; /* STATISTICS_OPERATIONAL_NTFY_API_S_VER_15 */
 
 /**
- * struct iwl_statistics_operational_ntfy_ver_14
+ * struct iwl_statistics_operational_ntfy_ver_14 - operational stats notification
  *
  * @hdr: general statistics header
  * @flags: bitmap of possible notification structures
@@ -707,7 +708,7 @@ struct iwl_statistics_operational_ntfy_ver_14 {
 } __packed; /* STATISTICS_OPERATIONAL_NTFY_API_S_VER_14 */
 
 /**
- * struct iwl_statistics_phy_ntfy
+ * struct iwl_statistics_phy_ntfy - PHY statistics notification
  *
  * @hdr: general statistics header
  * RX PHY related statistics
@@ -808,7 +809,7 @@ struct iwl_statistics_phy_ntfy {
 } __packed; /* STATISTICS_PHY_NTFY_API_S_VER_1 */
 
 /**
- * struct iwl_statistics_mac_ntfy
+ * struct iwl_statistics_mac_ntfy - MAC statistics notification
  *
  * @hdr: general statistics header
  * @bcast_filter_passed_per_mac: bcast filter passed per mac
@@ -827,7 +828,7 @@ struct iwl_statistics_mac_ntfy {
 } __packed; /* STATISTICS_MAC_NTFY_API_S_VER_1 */
 
 /**
- * struct iwl_statistics_rx_ntfy
+ * struct iwl_statistics_rx_ntfy - RX statistics notification
  *
  * @hdr: general statistics header
  * @rx_agg_mpdu_cnt: aggregation frame count (number of
@@ -867,7 +868,7 @@ struct iwl_statistics_rx_ntfy {
 } __packed; /* STATISTICS_RX_NTFY_API_S_VER_1 */
 
 /**
- * struct iwl_statistics_tx_ntfy
+ * struct iwl_statistics_tx_ntfy - TX statistics notification
  *
  * @hdr: general statistics header
  * @cts_timeout: timeout when waiting for CTS
@@ -976,7 +977,7 @@ struct iwl_statistics_tx_ntfy {
 } __packed; /* STATISTICS_TX_NTFY_API_S_VER_1 */
 
 /**
- * struct iwl_statistics_duration_ntfy
+ * struct iwl_statistics_duration_ntfy - burst/duration statistics
  *
  * @hdr: general statistics header
  * @cont_burst_chk_cnt: number of times continuation or
@@ -995,7 +996,7 @@ struct iwl_statistics_duration_ntfy {
 } __packed; /* STATISTICS_DURATION_NTFY_API_S_VER_1 */
 
 /**
- * struct iwl_statistics_he_ntfy
+ * struct iwl_statistics_he_ntfy - HE statistics
  *
  * @hdr: general statistics header
  * received HE frames
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 26d2013905ed..31d3336726b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -963,7 +963,7 @@ struct iwl_scd_txq_cfg_cmd {
 } __packed; /* SCD_QUEUE_CFG_CMD_API_S_VER_1 */
 
 /**
- * struct iwl_scd_txq_cfg_rsp
+ * struct iwl_scd_txq_cfg_rsp - scheduler TXQ configuration response
  * @token: taken from the command
  * @sta_id: station id from the command
  * @tid: tid from the command
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index c2a73cc85eff..525a82030daa 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -266,7 +266,7 @@ struct iwl_fw_ini_error_dump_data {
 } __packed;
 
 /**
- * struct iwl_fw_ini_dump_entry
+ * struct iwl_fw_ini_dump_entry - dump entry descriptor
  * @list: list of dump entries
  * @size: size of the data
  * @data: entry data
@@ -305,7 +305,7 @@ struct iwl_fw_ini_fifo_hdr {
  * @dram_base_addr: base address of dram monitor range
  * @page_num: page number of memory range
  * @fifo_hdr: fifo header of memory range
- * @fw_pkt: FW packet header of memory range
+ * @fw_pkt_hdr: FW packet header of memory range
  * @data: the actual memory
  */
 struct iwl_fw_ini_error_dump_range {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index b7c1ab7a3006..b9e0b69c6680 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -222,7 +222,10 @@ typedef unsigned int __bitwise iwl_ucode_tlv_api_t;
  * @IWL_UCODE_TLV_API_STA_TYPE: This ucode supports station type assignement.
  * @IWL_UCODE_TLV_API_NAN2_VER2: This ucode supports NAN API version 2
  * @IWL_UCODE_TLV_API_ADAPTIVE_DWELL: support for adaptive dwell in scanning
+ * @IWL_UCODE_TLV_API_OCE: support for OCE
+ * @IWL_UCODE_TLV_API_NEW_BEACON_TEMPLATE: new beacon template
  * @IWL_UCODE_TLV_API_NEW_RX_STATS: should new RX STATISTICS API be used
+ * @IWL_UCODE_TLV_API_WOWLAN_KEY_MATERIAL: WoWLAN key material support
  * @IWL_UCODE_TLV_API_QUOTA_LOW_LATENCY: Quota command includes a field
  *	indicating low latency direction.
  * @IWL_UCODE_TLV_API_DEPRECATE_TTAK: RX status flag TTAK ok (bit 7) is
@@ -245,6 +248,7 @@ typedef unsigned int __bitwise iwl_ucode_tlv_api_t;
  *	SCAN_OFFLOAD_PROFILES_QUERY_RSP_S.
  * @IWL_UCODE_TLV_API_MBSSID_HE: This ucode supports v2 of
  *	STA_CONTEXT_DOT11AX_API_S
+ * @IWL_UCODE_TLV_API_WOWLAN_TCP_SYN_WAKE: WoWLAN TCP-SYN wake support
  * @IWL_UCODE_TLV_API_FTM_RTT_ACCURACY: version 7 of the range response API
  *	is supported by FW, this indicates the RTT confidence value
  * @IWL_UCODE_TLV_API_SAR_TABLE_VER: This ucode supports different sar
@@ -253,6 +257,7 @@ typedef unsigned int __bitwise iwl_ucode_tlv_api_t;
  *	SCAN_CONFIG_DB_CMD_API_S.
  * @IWL_UCODE_TLV_API_ADWELL_HB_DEF_N_AP: support for setting adaptive dwell
  *	number of APs in the 5 GHz band
+ * @IWL_UCODE_TLV_API_SCAN_EXT_CHAN_VER: extended channel config in scan
  * @IWL_UCODE_TLV_API_BAND_IN_RX_DATA: FW reports band number in RX notification
  * @IWL_UCODE_TLV_API_NO_HOST_DISABLE_TX: Firmware offloaded the station disable tx
  *	logic.
@@ -352,16 +357,24 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  * @IWL_UCODE_TLV_CAPA_SOC_LATENCY_SUPPORT: the firmware supports setting
  *	stabilization latency for SoCs.
  * @IWL_UCODE_TLV_CAPA_STA_PM_NOTIF: firmware will send STA PM notification
+ * @IWL_UCODE_TLV_CAPA_BINDING_CDB_SUPPORT: binding CDB support
+ * @IWL_UCODE_TLV_CAPA_CDB_SUPPORT: CDB support
+ * @IWL_UCODE_TLV_CAPA_D0I3_END_FIRST: D0I3 end command comes first
  * @IWL_UCODE_TLV_CAPA_TLC_OFFLOAD: firmware implements rate scaling algorithm
  * @IWL_UCODE_TLV_CAPA_DYNAMIC_QUOTA: firmware implements quota related
  * @IWL_UCODE_TLV_CAPA_COEX_SCHEMA_2: firmware implements Coex Schema 2
- * IWL_UCODE_TLV_CAPA_CHANNEL_SWITCH_CMD: firmware supports CSA command
+ * @IWL_UCODE_TLV_CAPA_CHANNEL_SWITCH_CMD: firmware supports CSA command
  * @IWL_UCODE_TLV_CAPA_ULTRA_HB_CHANNELS: firmware supports ultra high band
  *	(6 GHz).
  * @IWL_UCODE_TLV_CAPA_CS_MODIFY: firmware supports modify action CSA command
+ * @IWL_UCODE_TLV_CAPA_SET_LTR_GEN2: LTR gen2 support
+ * @IWL_UCODE_TLV_CAPA_TAS_CFG: TAS configuration support
+ * @IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD: session protection command
+ * @IWL_UCODE_TLV_CAPA_SET_PPAG: PPAG support
  * @IWL_UCODE_TLV_CAPA_EXTENDED_DTS_MEASURE: extended DTS measurement
  * @IWL_UCODE_TLV_CAPA_SHORT_PM_TIMEOUTS: supports short PM timeouts
  * @IWL_UCODE_TLV_CAPA_BT_MPLUT_SUPPORT: supports bt-coex Multi-priority LUT
+ * @IWL_UCODE_TLV_CAPA_MULTI_QUEUE_RX_SUPPORT: MQ RX support
  * @IWL_UCODE_TLV_CAPA_CSA_AND_TBTT_OFFLOAD: the firmware supports CSA
  *	countdown offloading. Beacon notifications are not sent to the host.
  *	The fw also offloads TBTT alignment.
@@ -383,23 +396,46 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  *	command size (command version 4) that supports toggling ACK TX
  *	power reduction.
  * @IWL_UCODE_TLV_CAPA_D3_DEBUG: supports debug recording during D3
+ * @IWL_UCODE_TLV_CAPA_LED_CMD_SUPPORT: LED command support
  * @IWL_UCODE_TLV_CAPA_MCC_UPDATE_11AX_SUPPORT: MCC response support 11ax
  *	capability.
  * @IWL_UCODE_TLV_CAPA_CSI_REPORTING: firmware is capable of being configured
  *	to report the CSI information with (certain) RX frames
+ * @IWL_UCODE_TLV_CAPA_DBG_SUSPEND_RESUME_CMD_SUPP: suspend/resume command
+ * @IWL_UCODE_TLV_CAPA_DBG_BUF_ALLOC_CMD_SUPP: support for DBGC
+ *	buffer allocation command
  * @IWL_UCODE_TLV_CAPA_FTM_CALIBRATED: has FTM calibrated and thus supports both
  *	initiator and responder
  * @IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_UNII4_US_CA: supports (de)activating UNII-4
  *	for US/CA/WW from BIOS
+ * @IWL_UCODE_TLV_CAPA_PSC_CHAN_SUPPORT: supports PSC channels
+ * @IWL_UCODE_TLV_CAPA_BIGTK_SUPPORT: BIGTK support
  * @IWL_UCODE_TLV_CAPA_PROTECTED_TWT: Supports protection of TWT action frames
  * @IWL_UCODE_TLV_CAPA_FW_RESET_HANDSHAKE: Supports the firmware handshake in
  *	reset flow
  * @IWL_UCODE_TLV_CAPA_PASSIVE_6GHZ_SCAN: Support for passive scan on 6GHz PSC
  *      channels even when these are not enabled.
+ * @IWL_UCODE_TLV_CAPA_HIDDEN_6GHZ_SCAN: hidden SSID 6 GHz scan support
+ * @IWL_UCODE_TLV_CAPA_BROADCAST_TWT: broadcast TWT support
+ * @IWL_UCODE_TLV_CAPA_COEX_HIGH_PRIO: support for BT-coex high
+ *	priority for 802.1X/4-way-HS
+ * @IWL_UCODE_TLV_CAPA_BAID_ML_SUPPORT: multi-link BAID support
+ * @IWL_UCODE_TLV_CAPA_SYNCED_TIME: synced time command support
+ * @IWL_UCODE_TLV_CAPA_TIME_SYNC_BOTH_FTM_TM: time sync support
+ * @IWL_UCODE_TLV_CAPA_BIGTK_TX_SUPPORT: BIGTK TX support
+ * @IWL_UCODE_TLV_CAPA_MLD_API_SUPPORT: MLD API support
+ * @IWL_UCODE_TLV_CAPA_SCAN_DONT_TOGGLE_ANT: fixed antenna scan support
+ * @IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT: PPAG China BIOS support
+ * @IWL_UCODE_TLV_CAPA_OFFLOAD_BTM_SUPPORT: BTM protocol offload support
+ * @IWL_UCODE_TLV_CAPA_STA_EXP_MFP_SUPPORT: STA command MFP support
+ * @IWL_UCODE_TLV_CAPA_SNIFF_VALIDATE_SUPPORT: sniffer validate bits support
+ * @IWL_UCODE_TLV_CAPA_CHINA_22_REG_SUPPORT: China 2022 regulator support
  * @IWL_UCODE_TLV_CAPA_DUMP_COMPLETE_SUPPORT: Support for indicating dump collection
  *	complete to FW.
  * @IWL_UCODE_TLV_CAPA_SPP_AMSDU_SUPPORT: Support SPP (signaling and payload
  *	protected) A-MSDU.
+ * @IWL_UCODE_TLV_CAPA_DRAM_FRAG_SUPPORT: support for DBGC fragmented
+ *	DRAM buffers
  * @IWL_UCODE_TLV_CAPA_SECURE_LTF_SUPPORT: Support secure LTF measurement.
  * @IWL_UCODE_TLV_CAPA_MONITOR_PASSIVE_CHANS: Support monitor mode on otherwise
  *	passive channels
@@ -407,6 +443,8 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  *	for CA from BIOS.
  * @IWL_UCODE_TLV_CAPA_UHB_CANADA_TAS_SUPPORT: supports %TAS_UHB_ALLOWED_CANADA
  * @IWL_UCODE_TLV_CAPA_EXT_FSEQ_IMAGE_SUPPORT: external FSEQ image support
+ * @IWL_UCODE_TLV_CAPA_RESET_DURING_ASSERT: FW reset handshake is needed
+ *	during assert handling even if the dump isn't split
  * @IWL_UCODE_TLV_CAPA_FW_ACCEPTS_RAW_DSM_TABLE: Firmware has capability of
  *	handling raw DSM table data.
  *
@@ -487,12 +525,7 @@ enum iwl_ucode_tlv_capa {
 
 	/* set 3 */
 	IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_UNII4_US_CA	= (__force iwl_ucode_tlv_capa_t)96,
-
-	/*
-	 * @IWL_UCODE_TLV_CAPA_PSC_CHAN_SUPPORT: supports PSC channels
-	 */
 	IWL_UCODE_TLV_CAPA_PSC_CHAN_SUPPORT		= (__force iwl_ucode_tlv_capa_t)98,
-
 	IWL_UCODE_TLV_CAPA_BIGTK_SUPPORT		= (__force iwl_ucode_tlv_capa_t)100,
 	IWL_UCODE_TLV_CAPA_SPP_AMSDU_SUPPORT		= (__force iwl_ucode_tlv_capa_t)103,
 	IWL_UCODE_TLV_CAPA_DRAM_FRAG_SUPPORT		= (__force iwl_ucode_tlv_capa_t)104,
@@ -514,11 +547,8 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_EXT_FSEQ_IMAGE_SUPPORT	= (__force iwl_ucode_tlv_capa_t)125,
 
 	/* set 4 */
-	/**
-	 * @IWL_UCODE_TLV_CAPA_RESET_DURING_ASSERT: FW reset handshake is needed
-	 *	during assert handling even if the dump isn't split
-	 */
-	IWL_UCODE_TLV_CAPA_RESET_DURING_ASSERT		= (__force iwl_ucode_tlv_capa_t)(4 * 32 +  0),
+
+	IWL_UCODE_TLV_CAPA_RESET_DURING_ASSERT		= (__force iwl_ucode_tlv_capa_t)(4 * 32 + 0),
 	IWL_UCODE_TLV_CAPA_FW_ACCEPTS_RAW_DSM_TABLE 	= (__force iwl_ucode_tlv_capa_t)(4 * 32 + 1),
 	NUM_IWL_UCODE_TLV_CAPA
 /*
@@ -852,6 +882,8 @@ struct iwl_fw_dbg_trigger_low_rssi {
  * @start_assoc_denied: number of denied association to start recording
  * @start_assoc_timeout: number of association timeout to start recording
  * @start_connection_loss: number of connection loss to start recording
+ * @reserved: reserved
+ * @reserved2: reserved
  */
 struct iwl_fw_dbg_trigger_mlme {
 	u8 stop_auth_denied;
@@ -885,6 +917,7 @@ struct iwl_fw_dbg_trigger_mlme {
  * @p2p_device: timeout for the queues of a P2P device in ms
  * @ibss: timeout for the queues of an IBSS in ms
  * @tdls: timeout for the queues of a TDLS station in ms
+ * @reserved: reserved
  */
 struct iwl_fw_dbg_trigger_txq_timer {
 	__le32 command_queue;
@@ -900,7 +933,7 @@ struct iwl_fw_dbg_trigger_txq_timer {
 
 /**
  * struct iwl_fw_dbg_trigger_time_event - configures a time event trigger
- * time_Events: a list of tuples <id, action_bitmap>. The driver will issue a
+ * @time_events: a list of tuples <id, action_bitmap>. The driver will issue a
  *	trigger each time a time event notification that relates to time event
  *	id with one of the actions in the bitmap is received and
  *	BIT(notif->status) is set in status_bitmap.
@@ -916,19 +949,19 @@ struct iwl_fw_dbg_trigger_time_event {
 
 /**
  * struct iwl_fw_dbg_trigger_ba - configures BlockAck related trigger
- * rx_ba_start: tid bitmap to configure on what tid the trigger should occur
+ * @rx_ba_start: tid bitmap to configure on what tid the trigger should occur
  *	when an Rx BlockAck session is started.
- * rx_ba_stop: tid bitmap to configure on what tid the trigger should occur
+ * @rx_ba_stop: tid bitmap to configure on what tid the trigger should occur
  *	when an Rx BlockAck session is stopped.
- * tx_ba_start: tid bitmap to configure on what tid the trigger should occur
+ * @tx_ba_start: tid bitmap to configure on what tid the trigger should occur
  *	when a Tx BlockAck session is started.
- * tx_ba_stop: tid bitmap to configure on what tid the trigger should occur
+ * @tx_ba_stop: tid bitmap to configure on what tid the trigger should occur
  *	when a Tx BlockAck session is stopped.
- * rx_bar: tid bitmap to configure on what tid the trigger should occur
+ * @rx_bar: tid bitmap to configure on what tid the trigger should occur
  *	when a BAR is received (for a Tx BlockAck session).
- * tx_bar: tid bitmap to configure on what tid the trigger should occur
+ * @tx_bar: tid bitmap to configure on what tid the trigger should occur
  *	when a BAR is send (for an Rx BlocAck session).
- * frame_timeout: tid bitmap to configure on what tid the trigger should occur
+ * @frame_timeout: tid bitmap to configure on what tid the trigger should occur
  *	when a frame times out in the reordering buffer.
  */
 struct iwl_fw_dbg_trigger_ba {
@@ -946,6 +979,7 @@ struct iwl_fw_dbg_trigger_ba {
  * @action_bitmap: the TDLS action to trigger the collection upon
  * @peer_mode: trigger on specific peer or all
  * @peer: the TDLS peer to trigger the collection on
+ * @reserved: reserved
  */
 struct iwl_fw_dbg_trigger_tdls {
 	u8 action_bitmap;
@@ -958,6 +992,7 @@ struct iwl_fw_dbg_trigger_tdls {
  * struct iwl_fw_dbg_trigger_tx_status - configures trigger for tx response
  *  status.
  * @statuses: the list of statuses to trigger the collection on
+ * @reserved: reserved
  */
 struct iwl_fw_dbg_trigger_tx_status {
 	struct tx_status {
@@ -971,6 +1006,7 @@ struct iwl_fw_dbg_trigger_tx_status {
  * struct iwl_fw_dbg_conf_tlv - a TLV that describes a debug configuration.
  * @id: conf id
  * @usniffer: should the uSniffer image be used
+ * @reserved: reserved
  * @num_of_hcmds: how many HCMDs to send are present here
  * @hcmd: a variable length host command to be sent to apply the configuration.
  *	If there is more than one HCMD to send, they will appear one after the
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 5256f20623e9..045a3e009429 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -14,14 +14,13 @@
 #include "error-dump.h"
 
 /**
- * enum iwl_ucode_type
- *
- * The type of ucode.
+ * enum iwl_ucode_type - type of ucode
  *
  * @IWL_UCODE_REGULAR: Normal runtime ucode
  * @IWL_UCODE_INIT: Initial ucode
  * @IWL_UCODE_WOWLAN: Wake on Wireless enabled ucode
  * @IWL_UCODE_REGULAR_USNIFFER: Normal runtime ucode when using usniffer image
+ * @IWL_UCODE_TYPE_MAX: (internal value)
  */
 enum iwl_ucode_type {
 	IWL_UCODE_REGULAR,
@@ -122,7 +121,7 @@ struct fw_img {
 #define FW_ADDR_CACHE_CONTROL 0xC0000000UL
 
 /**
- * struct iwl_fw_paging
+ * struct iwl_fw_paging - FW paging descriptor
  * @fw_paging_phys: page phy pointer
  * @fw_paging_block: pointer to the allocated block
  * @fw_paging_size: page size
@@ -197,6 +196,11 @@ struct iwl_dump_exclude {
  * @dump_excl_wowlan: image dump exclusion areas for WoWLAN image
  * @pnvm_data: PNVM data embedded in the .ucode file, if any
  * @pnvm_size: size of the embedded PNVM data
+ * @dbg: debug data, see &struct iwl_fw_dbg
+ * @default_calib: default calibration data
+ * @phy_config: PHY configuration flags
+ * @valid_rx_ant: valid RX antenna bitmap
+ * @valid_tx_ant: valid TX antenna bitmap
  */
 struct iwl_fw {
 	u32 ucode_ver;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 9b116fa1d5d1..8e858e6b3ce3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -45,6 +45,8 @@ struct iwl_fwrt_shared_mem_cfg {
  * struct iwl_fwrt_dump_data - dump data
  * @trig: trigger the worker was scheduled upon
  * @fw_pkt: packet received from FW
+ * @desc: dump descriptor
+ * @monitor_only: only dump for monitor
  *
  * Note that the decision which part of the union is used
  * is based on iwl_trans_dbg_ini_valid(): the 'trig' part
@@ -68,6 +70,7 @@ struct iwl_fwrt_dump_data {
  * struct iwl_fwrt_wk_data - dump worker data struct
  * @idx: index of the worker
  * @wk: worker
+ * @dump_data: dump data
  */
 struct iwl_fwrt_wk_data  {
 	u8 idx;
@@ -91,8 +94,8 @@ struct iwl_txf_iter_data {
 
 /**
  * struct iwl_fw_runtime - runtime data for firmware
+ * @trans: transport pointer
  * @fw: firmware image
- * @cfg: NIC configuration
  * @dev: device pointer
  * @ops: user ops
  * @ops_ctx: user ops context
@@ -113,6 +116,23 @@ struct iwl_txf_iter_data {
  * @phy_filters: specific phy filters as read from WPFC BIOS table
  * @ppag_bios_rev: PPAG BIOS revision
  * @ppag_bios_source: see &enum bios_source
+ * @geo_enabled: WGDS table is present
+ * @geo_num_profiles: number of geo profiles
+ * @geo_rev: geo profiles table revision
+ * @ppag_chains: PPAG table data
+ * @ppag_flags: PPAG flags
+ * @reduced_power_flags: reduced power flags
+ * @sanitize_ctx: context for dump sanitizer
+ * @sanitize_ops: dump sanitizer ops
+ * @sar_chain_a_profile: SAR chain A profile
+ * @sar_chain_b_profile: SAR chain B profile
+ * @sgom_enabled: SGOM enabled
+ * @sgom_table: SGOM table
+ * @timestamp: timestamp marker data
+ * @timestamp.wk: timestamp marking worker
+ * @timestamp.seq: timestamp marking sequence
+ * @timestamp.delay: timestamp marking worker delay
+ * @tpc_enabled: TPC enabled
  */
 struct iwl_fw_runtime {
 	struct iwl_trans *trans;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index cfd1629f0016..0b34c9f90b3f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -385,7 +385,7 @@ struct iwl_mac_cfg {
 #define IWL_NUM_RBDS_EHT		(512 * 8)
 
 /**
- * struct iwl_rf_cfg
+ * struct iwl_rf_cfg - RF/CRF configuration data
  * @fw_name_pre: Firmware filename prefix. The api version and extension
  *	(.ucode) will be added to filename before loading from disk. The
  *	filename is constructed as <fw_name_pre>-<api>.ucode.
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index 7ed6329fd8ca..fe4e46a0edbd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2023, 2025 Intel Corporation
  */
 #ifndef __iwl_dbg_tlv_h__
 #define __iwl_dbg_tlv_h__
@@ -32,7 +32,7 @@ union iwl_dbg_tlv_tp_data {
 };
 
 /**
- * struct iwl_dbg_tlv_time_point_data
+ * struct iwl_dbg_tlv_time_point_data - debug time point data
  * @trig_list: list of triggers
  * @active_trig_list: list of active triggers
  * @hcmd_list: list of host commands
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
index 595300a14639..a0b67e8aba8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
@@ -62,7 +62,8 @@ struct iwl_rf_cfg;
  * starts the driver: fetches the firmware. This should be called by bus
  * specific system flows implementations. For example, the bus specific probe
  * function should do bus related operations only, and then call to this
- * function. It returns the driver object or %NULL if an error occurred.
+ * function.
+ * Return: the driver object or %NULL if an error occurred.
  */
 struct iwl_drv *iwl_drv_start(struct iwl_trans *trans);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
index 21eabfc3ffc8..0476df7b7f17 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2022, 2024 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2022, 2024-2025 Intel Corporation
  */
 #ifndef __iwl_modparams_h__
 #define __iwl_modparams_h__
@@ -42,7 +42,7 @@ enum iwl_uapsd_disable {
 };
 
 /**
- * struct iwl_mod_params
+ * struct iwl_mod_params - module parameters for iwlwifi
  *
  * Holds the module parameters
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index cbc92abf9f87..12f28bb0e859 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -115,11 +115,12 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
  * iwl_parse_nvm_mcc_info - parse MCC (mobile country code) info coming from FW
  *
  * This function parses the regulatory channel data received as a
- * MCC_UPDATE_CMD command. It returns a newly allocation regulatory domain,
- * to be fed into the regulatory core. In case the geo_info is set handle
- * accordingly. An ERR_PTR is returned on error.
- * If not given to the regulatory core, the user is responsible for freeing
- * the regdomain returned here with kfree.
+ * MCC_UPDATE_CMD command.
+ *
+ * Return: a newly allocation regulatory domain, to be given to the regulatory
+ *	core. In case the geo_info is set handle accordingly. An ERR_PTR is
+ *	returned on error. If not given to the regulatory core, the user is
+ *	responsible for freeing the regdomain returned here with kfree().
  *
  * @trans: the transport
  * @num_of_ch: the number of channels
@@ -140,6 +141,8 @@ iwl_parse_nvm_mcc_info(struct iwl_trans *trans,
  * This struct holds an NVM section read from the NIC using NVM_ACCESS_CMD,
  * and saved for later use by the driver. Not all NVM sections are saved
  * this way, only the needed ones.
+ * @length: length of the section
+ * @data: section data
  */
 struct iwl_nvm_section {
 	u16 length;
@@ -148,6 +151,10 @@ struct iwl_nvm_section {
 
 /**
  * iwl_read_external_nvm - Reads external NVM from a file into nvm_sections
+ * @trans: the transport
+ * @nvm_file_name: the filename to request
+ * @nvm_sections: sections data to fill
+ * Return: 0 on success or an error code
  */
 int iwl_read_external_nvm(struct iwl_trans *trans,
 			  const char *nvm_file_name,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index a146d0e399f2..df6341dfc4a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -185,6 +185,7 @@ void iwl_opmode_deregister(const char *name);
 /**
  * struct iwl_op_mode - operational mode
  * @ops: pointer to its own ops
+ * @op_mode_specific: per-opmode data
  *
  * This holds an implementation of the mac80211 / fw API.
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index a0cc5d7745e8..a552669db6e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -121,7 +121,7 @@ enum CMD_MODE {
 #define DEF_CMD_PAYLOAD_SIZE 320
 
 /**
- * struct iwl_device_cmd
+ * struct iwl_device_cmd - device command structure
  *
  * For allocation of the command and tx queues, this establishes the overall
  * size of the largest command we send to uCode, except for commands that
@@ -516,7 +516,7 @@ enum iwl_trans_state {
  */
 
 /**
- * enum iwl_ini_cfg_state
+ * enum iwl_ini_cfg_state - debug config state
  * @IWL_INI_CFG_STATE_NOT_LOADED: no debug cfg was given
  * @IWL_INI_CFG_STATE_LOADED: debug cfg was found and loaded
  * @IWL_INI_CFG_STATE_CORRUPTED: debug cfg was found and some of the TLVs
@@ -532,7 +532,7 @@ enum iwl_ini_cfg_state {
 #define IWL_TRANS_NMI_TIMEOUT (HZ / 4)
 
 /**
- * struct iwl_dram_data
+ * struct iwl_dram_data - DRAM data descriptor
  * @physical: page phy pointer
  * @block: pointer to the allocated block/page
  * @size: size of the block/page
-- 
2.34.1


