Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F426D5C3B
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 09:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfJNHUq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 03:20:46 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:49242 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730276AbfJNHUq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 03:20:46 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJuel-0007ae-M0; Mon, 14 Oct 2019 10:20:40 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 14 Oct 2019 10:20:18 +0300
Message-Id: <20191014101813.77d7043d178c.I2edbd5a6dc7a7a724c66c97e1ed6517496ee947c@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014072019.1254-1-luca@coelho.fi>
References: <20191014072019.1254-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 15/16] iwlwifi: dbg_ini: remove old API and some related code
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Remove unused code of the old debug ini API.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 228 +-----------------
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  12 -
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  12 -
 3 files changed, 2 insertions(+), 250 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 4d1b084da4b1..b9d7ed93311c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -60,6 +60,8 @@
 
 #include <linux/bitops.h>
 
+#define IWL_FW_INI_MAX_REGION_ID		64
+#define IWL_FW_INI_MAX_NAME			32
 #define IWL_FW_INI_MAX_CFG_NAME			64
 #define IWL_FW_INI_DOMAIN_ALWAYS_ON		0
 
@@ -91,84 +93,6 @@ struct iwl_fw_ini_header {
 	u8 data[];
 } __packed; /* FW_TLV_DEBUG_HEADER_S_VER_1 */
 
-#define IWL_FW_INI_MAX_REGION_ID	64
-#define IWL_FW_INI_MAX_NAME		32
-
-/**
- * struct iwl_fw_ini_region_cfg_dhc - defines dhc response to dump.
- *
- * @id_and_grp: id and group of dhc response.
- * @desc: dhc response descriptor.
- */
-struct iwl_fw_ini_region_cfg_dhc {
-	__le32 id_and_grp;
-	__le32 desc;
-} __packed; /* FW_DEBUG_TLV_REGION_DHC_API_S_VER_1 */
-
-/**
- * struct iwl_fw_ini_region_cfg_internal - meta data of internal memory region
- *
- * @num_of_range: the amount of ranges in the region
- * @range_data_size: size of the data to read per range, in bytes.
- */
-struct iwl_fw_ini_region_cfg_internal {
-	__le32 num_of_ranges;
-	__le32 range_data_size;
-} __packed; /* FW_DEBUG_TLV_REGION_NIC_INTERNAL_RANGES_S */
-
-/**
- * struct iwl_fw_ini_region_cfg_fifos - meta data of fifos region
- *
- * @fid1: fifo id 1 - bitmap of lmac tx/rx fifos to include in the region
- * @fid2: fifo id 2 - bitmap of umac rx fifos to include in the region.
- *	It is unused for tx.
- * @num_of_registers: number of prph registers in the region, each register is
- *	4 bytes size.
- * @header_only: none zero value indicates that this region does not include
- *	fifo data and includes only the given registers.
- */
-struct iwl_fw_ini_region_cfg_fifos {
-	__le32 fid1;
-	__le32 fid2;
-	__le32 num_of_registers;
-	__le32 header_only;
-} __packed; /* FW_DEBUG_TLV_REGION_FIFOS_S */
-
-/**
- * struct iwl_fw_ini_region_cfg
- *
- * @region_id: ID of this dump configuration
- * @region_type: &enum iwl_fw_ini_region_type
- * @domain: dump this region only if the specific domain is enabled
- *	&enum iwl_fw_ini_dbg_domain
- * @name_len: name length
- * @name: file name to use for this region
- * @internal: used in case the region uses internal memory.
- * @allocation_id: For DRAM type field substitutes for allocation_id
- * @fifos: used in case of fifos region.
- * @dhc_desc: dhc response descriptor.
- * @notif_id_and_grp: dump this region only if the specific notification
- *	occurred.
- * @offset: offset to use for each memory base address
- * @start_addr: array of addresses.
- */
-struct iwl_fw_ini_region_cfg {
-	__le32 region_id;
-	__le32 region_type;
-	__le32 domain;
-	__le32 name_len;
-	u8 name[IWL_FW_INI_MAX_NAME];
-	union {
-		struct iwl_fw_ini_region_cfg_internal internal;
-		__le32 allocation_id;
-		struct iwl_fw_ini_region_cfg_fifos fifos;
-		struct iwl_fw_ini_region_cfg_dhc dhc_desc;
-		__le32 notif_id_and_grp;
-	}; /* FW_DEBUG_TLV_REGION_EXT_INT_PARAMS_API_U_VER_1 */
-	__le32 offset;
-	__le32 start_addr[];
-} __packed; /* FW_DEBUG_TLV_REGION_CONFIG_API_S_VER_1 */
-
 /**
  * struct iwl_fw_ini_region_dev_addr - Configuration to read device addresses
  *
@@ -282,40 +206,6 @@ struct iwl_fw_ini_debug_info_tlv {
 	u8 debug_cfg_name[IWL_FW_INI_MAX_CFG_NAME];
 } __packed; /* FW_TLV_DEBUG_INFO_API_S_VER_1 */
 
-/**
- * struct iwl_fw_ini_trigger
- *
- * @trigger_id: &enum iwl_fw_ini_trigger_id
- * @override_trig: determines how apply trigger in case a trigger with the
- *	same id is already in use. Using the first 2 bytes:
- *	Byte 0: if 0, override trigger configuration, otherwise use the
- *	existing configuration.
- *	Byte 1: if 0, override trigger regions, otherwise append regions to
- *	existing trigger.
- * @dump_delay: delay from trigger fire to dump, in usec
- * @occurrences: max amount of times to be fired
- * @reserved: to align to FW struct
- * @ignore_consec: ignore consecutive triggers, in usec
- * @force_restart: force FW restart
- * @multi_dut: initiate debug dump data on several DUTs
- * @trigger_data: generic data to be utilized per trigger
- * @num_regions: number of dump regions defined for this trigger
- * @data: region IDs
- */
-struct iwl_fw_ini_trigger {
-	__le32 trigger_id;
-	__le32 override_trig;
-	__le32 dump_delay;
-	__le32 occurrences;
-	__le32 reserved;
-	__le32 ignore_consec;
-	__le32 force_restart;
-	__le32 multi_dut;
-	__le32 trigger_data;
-	__le32 num_regions;
-	__le32 data[];
-} __packed; /* FW_TLV_DEBUG_TRIGGER_CONFIG_API_S_VER_1 */
-
 /**
  * struct iwl_fw_ini_allocation_tlv - Allocates DRAM buffers
  *
@@ -384,101 +274,6 @@ struct iwl_fw_ini_hcmd_tlv {
 	struct iwl_fw_ini_hcmd hcmd;
 } __packed; /* FW_TLV_DEBUG_HCMD_API_S_VER_1 */
 
-/**
- * enum iwl_fw_ini_trigger_id
- *
- * @IWL_FW_TRIGGER_ID_FW_ASSERT: FW assert
- * @IWL_FW_TRIGGER_ID_FW_HW_ERROR: HW assert
- * @IWL_FW_TRIGGER_ID_FW_TFD_Q_HANG: TFD queue hang
- * @IWL_FW_TRIGGER_ID_FW_DEBUG_HOST_TRIGGER: FW debug notification
- * @IWL_FW_TRIGGER_ID_FW_GENERIC_NOTIFICATION: FW generic notification
- * @IWL_FW_TRIGGER_ID_USER_TRIGGER: User trigger
- * @IWL_FW_TRIGGER_ID_PERIODIC_TRIGGER: triggers periodically
- * @IWL_FW_TRIGGER_ID_HOST_PEER_CLIENT_INACTIVITY: peer inactivity
- * @IWL_FW_TRIGGER_ID_HOST_TX_LATENCY_THRESHOLD_CROSSED: TX latency
- *	threshold was crossed
- * @IWL_FW_TRIGGER_ID_HOST_TX_RESPONSE_STATUS_FAILED: TX failed
- * @IWL_FW_TRIGGER_ID_HOST_OS_REQ_DEAUTH_PEER: Deauth initiated by host
- * @IWL_FW_TRIGGER_ID_HOST_STOP_GO_REQUEST: stop GO request
- * @IWL_FW_TRIGGER_ID_HOST_START_GO_REQUEST: start GO request
- * @IWL_FW_TRIGGER_ID_HOST_JOIN_GROUP_REQUEST: join P2P group request
- * @IWL_FW_TRIGGER_ID_HOST_SCAN_START: scan started event
- * @IWL_FW_TRIGGER_ID_HOST_SCAN_SUBMITTED: undefined
- * @IWL_FW_TRIGGER_ID_HOST_SCAN_PARAMS: undefined
- * @IWL_FW_TRIGGER_ID_HOST_CHECK_FOR_HANG: undefined
- * @IWL_FW_TRIGGER_ID_HOST_BAR_RECEIVED: BAR frame was received
- * @IWL_FW_TRIGGER_ID_HOST_AGG_TX_RESPONSE_STATUS_FAILED: agg TX failed
- * @IWL_FW_TRIGGER_ID_HOST_EAPOL_TX_RESPONSE_FAILED: EAPOL TX failed
- * @IWL_FW_TRIGGER_ID_HOST_FAKE_TX_RESPONSE_SUSPECTED: suspicious TX response
- * @IWL_FW_TRIGGER_ID_HOST_AUTH_REQ_FROM_ASSOC_CLIENT: received suspicious auth
- * @IWL_FW_TRIGGER_ID_HOST_ROAM_COMPLETE: roaming was completed
- * @IWL_FW_TRIGGER_ID_HOST_AUTH_ASSOC_FAST_FAILED: fast assoc failed
- * @IWL_FW_TRIGGER_ID_HOST_D3_START: D3 start
- * @IWL_FW_TRIGGER_ID_HOST_D3_END: D3 end
- * @IWL_FW_TRIGGER_ID_HOST_BSS_MISSED_BEACONS: missed beacon events
- * @IWL_FW_TRIGGER_ID_HOST_P2P_CLIENT_MISSED_BEACONS: P2P missed beacon events
- * @IWL_FW_TRIGGER_ID_HOST_PEER_CLIENT_TX_FAILURES:  undefined
- * @IWL_FW_TRIGGER_ID_HOST_TX_WFD_ACTION_FRAME_FAILED: undefined
- * @IWL_FW_TRIGGER_ID_HOST_AUTH_ASSOC_FAILED: authentication / association
- *	failed
- * @IWL_FW_TRIGGER_ID_HOST_SCAN_COMPLETE: scan complete event
- * @IWL_FW_TRIGGER_ID_HOST_SCAN_ABORT: scan abort complete
- * @IWL_FW_TRIGGER_ID_HOST_NIC_ALIVE: nic alive message was received
- * @IWL_FW_TRIGGER_ID_HOST_CHANNEL_SWITCH_COMPLETE: CSA was completed
- * @IWL_FW_TRIGGER_ID_NUM: number of trigger IDs
- */
-enum iwl_fw_ini_trigger_id {
-	IWL_FW_TRIGGER_ID_INVALID				= 0,
-
-	/* Errors triggers */
-	IWL_FW_TRIGGER_ID_FW_ASSERT				= 1,
-	IWL_FW_TRIGGER_ID_FW_HW_ERROR				= 2,
-	IWL_FW_TRIGGER_ID_FW_TFD_Q_HANG				= 3,
-
-	/* FW triggers */
-	IWL_FW_TRIGGER_ID_FW_DEBUG_HOST_TRIGGER			= 4,
-	IWL_FW_TRIGGER_ID_FW_GENERIC_NOTIFICATION		= 5,
-
-	/* User trigger */
-	IWL_FW_TRIGGER_ID_USER_TRIGGER				= 6,
-
-	/* periodic uses the data field for the interval time */
-	IWL_FW_TRIGGER_ID_PERIODIC_TRIGGER			= 7,
-
-	/* Host triggers */
-	IWL_FW_TRIGGER_ID_HOST_PEER_CLIENT_INACTIVITY		= 8,
-	IWL_FW_TRIGGER_ID_HOST_TX_LATENCY_THRESHOLD_CROSSED	= 9,
-	IWL_FW_TRIGGER_ID_HOST_TX_RESPONSE_STATUS_FAILED	= 10,
-	IWL_FW_TRIGGER_ID_HOST_OS_REQ_DEAUTH_PEER		= 11,
-	IWL_FW_TRIGGER_ID_HOST_STOP_GO_REQUEST			= 12,
-	IWL_FW_TRIGGER_ID_HOST_START_GO_REQUEST			= 13,
-	IWL_FW_TRIGGER_ID_HOST_JOIN_GROUP_REQUEST		= 14,
-	IWL_FW_TRIGGER_ID_HOST_SCAN_START			= 15,
-	IWL_FW_TRIGGER_ID_HOST_SCAN_SUBMITTED			= 16,
-	IWL_FW_TRIGGER_ID_HOST_SCAN_PARAMS			= 17,
-	IWL_FW_TRIGGER_ID_HOST_CHECK_FOR_HANG			= 18,
-	IWL_FW_TRIGGER_ID_HOST_BAR_RECEIVED			= 19,
-	IWL_FW_TRIGGER_ID_HOST_AGG_TX_RESPONSE_STATUS_FAILED	= 20,
-	IWL_FW_TRIGGER_ID_HOST_EAPOL_TX_RESPONSE_FAILED		= 21,
-	IWL_FW_TRIGGER_ID_HOST_FAKE_TX_RESPONSE_SUSPECTED	= 22,
-	IWL_FW_TRIGGER_ID_HOST_AUTH_REQ_FROM_ASSOC_CLIENT	= 23,
-	IWL_FW_TRIGGER_ID_HOST_ROAM_COMPLETE			= 24,
-	IWL_FW_TRIGGER_ID_HOST_AUTH_ASSOC_FAST_FAILED		= 25,
-	IWL_FW_TRIGGER_ID_HOST_D3_START				= 26,
-	IWL_FW_TRIGGER_ID_HOST_D3_END				= 27,
-	IWL_FW_TRIGGER_ID_HOST_BSS_MISSED_BEACONS		= 28,
-	IWL_FW_TRIGGER_ID_HOST_P2P_CLIENT_MISSED_BEACONS	= 29,
-	IWL_FW_TRIGGER_ID_HOST_PEER_CLIENT_TX_FAILURES		= 30,
-	IWL_FW_TRIGGER_ID_HOST_TX_WFD_ACTION_FRAME_FAILED	= 31,
-	IWL_FW_TRIGGER_ID_HOST_AUTH_ASSOC_FAILED		= 32,
-	IWL_FW_TRIGGER_ID_HOST_SCAN_COMPLETE			= 33,
-	IWL_FW_TRIGGER_ID_HOST_SCAN_ABORT			= 34,
-	IWL_FW_TRIGGER_ID_HOST_NIC_ALIVE			= 35,
-	IWL_FW_TRIGGER_ID_HOST_CHANNEL_SWITCH_COMPLETE		= 36,
-
-	IWL_FW_TRIGGER_ID_NUM,
-}; /* FW_DEBUG_TLV_TRIGGER_ID_E_VER_1 */
-
 /**
  * enum iwl_fw_ini_allocation_id
  *
@@ -486,9 +281,6 @@ enum iwl_fw_ini_trigger_id {
  * @IWL_FW_INI_ALLOCATION_ID_DBGC1: allocation meant for DBGC1 configuration
  * @IWL_FW_INI_ALLOCATION_ID_DBGC2: allocation meant for DBGC2 configuration
  * @IWL_FW_INI_ALLOCATION_ID_DBGC3: allocation meant for DBGC3 configuration
- * @IWL_FW_INI_ALLOCATION_ID_SDFX: for SDFX module
- * @IWL_FW_INI_ALLOCATION_ID_FW_DUMP: used for crash and runtime dumps
- * @IWL_FW_INI_ALLOCATION_ID_USER_DEFINED: for future user scenarios
  * @IWL_FW_INI_ALLOCATION_NUM: number of allocation ids
 */
 enum iwl_fw_ini_allocation_id {
@@ -496,9 +288,6 @@ enum iwl_fw_ini_allocation_id {
 	IWL_FW_INI_ALLOCATION_ID_DBGC1,
 	IWL_FW_INI_ALLOCATION_ID_DBGC2,
 	IWL_FW_INI_ALLOCATION_ID_DBGC3,
-	IWL_FW_INI_ALLOCATION_ID_SDFX,
-	IWL_FW_INI_ALLOCATION_ID_FW_DUMP,
-	IWL_FW_INI_ALLOCATION_ID_USER_DEFINED,
 	IWL_FW_INI_ALLOCATION_NUM,
 }; /* FW_DEBUG_TLV_ALLOCATION_ID_E_VER_1 */
 
@@ -517,19 +306,6 @@ enum iwl_fw_ini_buffer_location {
 	IWL_FW_INI_LOCATION_NPK_PATH,
 }; /* FW_DEBUG_TLV_BUFFER_LOCATION_E_VER_1 */
 
-/**
- * enum iwl_fw_ini_debug_flow
- *
- * @IWL_FW_INI_DEBUG_INVALID: invalid
- * @IWL_FW_INI_DEBUG_DBTR_FLOW: undefined
- * @IWL_FW_INI_DEBUG_TB2DTF_FLOW: undefined
- */
-enum iwl_fw_ini_debug_flow {
-	IWL_FW_INI_DEBUG_INVALID,
-	IWL_FW_INI_DEBUG_DBTR_FLOW,
-	IWL_FW_INI_DEBUG_TB2DTF_FLOW,
-}; /* FW_DEBUG_TLV_FLOW_E_VER_1 */
-
 /**
  * enum iwl_fw_ini_region_type
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 039576d71276..dbeab093171e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -227,18 +227,6 @@ struct iwl_fw_dbg {
 	u32 dump_mask;
 };
 
-/**
- * struct iwl_fw_ini_active_triggers
- * @active: is this trigger active
- * @size: allocated memory size of the trigger
- * @trig: trigger
- */
-struct iwl_fw_ini_active_triggers {
-	bool active;
-	size_t size;
-	struct iwl_fw_ini_trigger *trig;
-};
-
 /**
  * struct iwl_fw - variables associated with the firmware
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 87adbd3dd764..ec2ab0281f18 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -183,8 +183,6 @@ struct iwl_fw_runtime {
 		/* ts of the beginning of a non-collect fw dbg data period */
 		unsigned long non_collect_ts_start[IWL_FW_INI_TIME_POINT_NUM];
 		u32 *d3_debug_data;
-		struct iwl_fw_ini_region_cfg *active_regs[IWL_FW_INI_MAX_REGION_ID];
-		struct iwl_fw_ini_active_triggers active_trigs[IWL_FW_TRIGGER_ID_NUM];
 		u32 lmac_err_id[MAX_NUM_LMAC];
 		u32 umac_err_id;
 
@@ -220,16 +218,6 @@ static inline void iwl_fw_runtime_free(struct iwl_fw_runtime *fwrt)
 	kfree(fwrt->dump.d3_debug_data);
 	fwrt->dump.d3_debug_data = NULL;
 
-	for (i = 0; i < IWL_FW_TRIGGER_ID_NUM; i++) {
-		struct iwl_fw_ini_active_triggers *active =
-			&fwrt->dump.active_trigs[i];
-
-		active->active = false;
-		active->size = 0;
-		kfree(active->trig);
-		active->trig = NULL;
-	}
-
 	iwl_dbg_tlv_del_timers(fwrt->trans);
 	for (i = 0; i < IWL_FW_RUNTIME_DUMP_WK_NUM; i++)
 		cancel_delayed_work_sync(&fwrt->dump.wks[i].wk);
-- 
2.23.0

