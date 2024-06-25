Return-Path: <linux-wireless+bounces-9547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7F1916E84
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC4D1F217C0
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669F8176232;
	Tue, 25 Jun 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Li8yMW1V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512FD175573
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334315; cv=none; b=jJzetBBga90x7NE3ciraDS0PFcXHoiz61mJtuJClUP4C7NRT8FM20WyIamO6u1q8iho2Ewa0J36UFfGd3bU7xsVM8BZ22+f8kFyCcncu+HzkoXq9F/R18tS8Z3Qhc6RKeW/SM69RZHidMR435SpKhWfwqVnzjlN4lQfa0gNgE/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334315; c=relaxed/simple;
	bh=I2PqoRU+TXVvZBLTvRxIdmEOSeEPpdNdrIWTFb5/jDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BVVRWQ7LpxF1TG0NtHqGrA8noMwJHALFwbiOquiNuve1O4bpSD8oDBsT9oMdmGhwSGX0nW5gtLnv7xsejcaQkU43/XTDADkFvPpzUPSj06GBlybHCZqDxhqNu84rEVtyCGYmqF5fUEFGRq/TLNU3arJexlJh+rRezeFg4tZ9j04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Li8yMW1V; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334314; x=1750870314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I2PqoRU+TXVvZBLTvRxIdmEOSeEPpdNdrIWTFb5/jDw=;
  b=Li8yMW1V5HOm3AT58fr0QSffwr1r9vTd+Mo21k3TeYfdR4y3XM8T9wob
   UWyBUG2E0XJJ2uwpwGBZJ7GC/S1HW5QG6LfvWtBjmUqk4WGmwwb311//2
   lu+VAxJVbSurpXyAhk43VTho0n83ayPhkfTKzQKS4n1hP1w8bPaqFO+fQ
   s9Ysk7mDIqRmwvxW3uKthfx2si0uj5c4BB7sPCosMZD1TS3FrppquBHD5
   WLu70CGVVxt9F4GKzzcFFljQL5u1L2sJp/TR/E7fK73GOqQCcFJiZ0szo
   20xxrTtk2bUa4sGv6sl2fziU4Tw01PFIK2kwECeVSViIOrj9mkxsYw1nG
   Q==;
X-CSE-ConnectionGUID: s/1qUmVaQlOo6GimLl9JQw==
X-CSE-MsgGUID: Y06mOco7TaGi8Z1WxD7pVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594788"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594788"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:53 -0700
X-CSE-ConnectionGUID: I6N8d2jYSYCvsxM2a5oYVQ==
X-CSE-MsgGUID: 68PjgLdZT0CZ3ubjg7pMEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632830"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/17] wifi: iwlwifi: fix prototype mismatch kernel-doc warnings
Date: Tue, 25 Jun 2024 19:51:20 +0300
Message-Id: <20240625194805.6ec65cf9b88c.I7804114d7369f352e80a0e8430f7119af8e210de@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
References: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Fix all the prototype mismatch and "wrong kernel-doc identifier"
warnings, due to typos in or misformatting of the kernel-doc.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h    | 6 +++---
 drivers/net/wireless/intel/iwlwifi/fw/api/binding.h  | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h       | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h  | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h  | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h  | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/offload.h  | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h      | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h       | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h       | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h     | 8 ++++----
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h       | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h   | 4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-config.h      | 3 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h   | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h         | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h          | 6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h         | 2 +-
 19 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
index e00ab21e7358..ebe85fdf08d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018, 2020-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2020-2021, 2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -113,7 +113,7 @@ struct iwl_alive_ntf_v6 {
 } __packed; /* UCODE_ALIVE_NTFY_API_S_VER_6 */
 
 /**
- * enum iwl_extended_cfg_flag - commands driver may send before
+ * enum iwl_extended_cfg_flags - commands driver may send before
  *	finishing init flow
  * @IWL_INIT_DEBUG_CFG: driver is going to send debug config command
  * @IWL_INIT_NVM: driver is going to send NVM_ACCESS commands
@@ -126,7 +126,7 @@ enum iwl_extended_cfg_flags {
 };
 
 /**
- * struct iwl_extended_cfg_cmd - mark what commands ucode should wait for
+ * struct iwl_init_extended_cfg_cmd - mark what commands ucode should wait for
  * before finishing init flows
  * @init_flags: values from iwl_extended_cfg_flags
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h b/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h
index d9044ada6a43..2397fdc37fc5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2020, 2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2020, 2022, 2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -77,7 +77,7 @@ struct iwl_time_quota_data_v1 {
 } __packed; /* TIME_QUOTA_DATA_API_S_VER_1 */
 
 /**
- * struct iwl_time_quota_cmd - configuration of time quota between bindings
+ * struct iwl_time_quota_cmd_v1 - configuration of time quota between bindings
  * ( TIME_QUOTA_CMD = 0x2c )
  * @quotas: allocations per binding
  * Note: on non-CDB the fourth one is the auxilary mac and is
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index bbaaf3c73115..ffee7927cf26 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -42,7 +42,7 @@ struct iwl_d3_manager_config {
 /* TODO: OFFLOADS_QUERY_API_S_VER_1 */
 
 /**
- * enum iwl_d3_proto_offloads - enabled protocol offloads
+ * enum iwl_proto_offloads - enabled protocol offloads
  * @IWL_D3_PROTO_OFFLOAD_ARP: ARP data is enabled
  * @IWL_D3_PROTO_OFFLOAD_NS: NS (Neighbor Solicitation) is enabled
  * @IWL_D3_PROTO_IPV4_VALID: IPv4 data is valid
@@ -195,7 +195,7 @@ struct iwl_wowlan_pattern_v1 {
 #define IWL_WOWLAN_MAX_PATTERNS	20
 
 /**
- * struct iwl_wowlan_patterns_cmd - WoWLAN wakeup patterns
+ * struct iwl_wowlan_patterns_cmd_v1 - WoWLAN wakeup patterns
  */
 struct iwl_wowlan_patterns_cmd_v1 {
 	/**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 6cfe8a779cc7..e71b3bc20253 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -291,7 +291,7 @@ struct iwl_fw_ini_addr_val {
 } __packed; /* FW_TLV_DEBUG_ADDR_VALUE_VER_1 */
 
 /**
- * struct iwl_fw_ini_conf_tlv - configuration TLV to set register/memory.
+ * struct iwl_fw_ini_conf_set_tlv - configuration TLV to set register/memory.
  *
  * @hdr: debug header
  * @time_point: time point to apply config. One of &enum iwl_fw_ini_time_point
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 7c158a8dfed0..30a54c7fa001 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -446,7 +446,7 @@ struct iwl_tof_responder_config_cmd {
 #define IWL_LCI_CIVIC_IE_MAX_SIZE	400
 
 /**
- * struct iwl_tof_responder_dyn_config_cmd - Dynamic responder settings
+ * struct iwl_tof_responder_dyn_config_cmd_v2 - Dynamic responder settings
  * @lci_len: The length of the 1st (LCI) part in the @lci_civic buffer
  * @civic_len: The length of the 2nd (CIVIC) part in the @lci_civic buffer
  * @lci_civic: The LCI/CIVIC buffer. LCI data (if exists) comes first, then, if
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 754c5d655ad0..ca6fa66d1917 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -144,7 +144,7 @@ struct iwl_missed_vap_notif {
 } __packed; /* MISSED_VAP_NTFY_API_S_VER_1 */
 
 /**
- * struct iwl_channel_switch_start_notif - Channel switch start notification
+ * struct iwl_channel_switch_start_notif_v1 - Channel switch start notification
  *
  * @id_and_color: ID and color of the MAC
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 644c8df780bc..9ff5d7e538fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -120,7 +120,7 @@ struct iwl_nvm_access_cmd {
 } __packed; /* NVM_ACCESS_CMD_API_S_VER_2 */
 
 /**
- * struct iwl_nvm_access_resp_ver2 - response to NVM_ACCESS_CMD
+ * struct iwl_nvm_access_resp - response to NVM_ACCESS_CMD
  * @offset: offset in bytes into the section
  * @length: in bytes, either how much was written or read
  * @type: NVM_SECTION_TYPE_*
@@ -212,7 +212,7 @@ struct iwl_nvm_get_info_phy {
 #define IWL_NUM_CHANNELS	110
 
 /**
- * struct iwl_nvm_get_info_regulatory - regulatory information
+ * struct iwl_nvm_get_info_regulatory_v1 - regulatory information
  * @lar_enabled: is LAR enabled
  * @channel_profile: regulatory data of this channel
  * @reserved: reserved
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
index 2ed7acc09e5a..6a7bbfd6b2b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
@@ -60,7 +60,7 @@ struct iwl_stored_beacon_notif_common {
 } __packed;
 
 /**
- * struct iwl_stored_beacon_notif - Stored beacon notification
+ * struct iwl_stored_beacon_notif_v2 - Stored beacon notification
  *
  * @common: fields common for all versions
  * @data: beacon data, length in @byte_count
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
index 92e4b62c119f..c73d4d597857 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
@@ -195,7 +195,7 @@ struct ct_kill_notif {
 } __packed; /* CT_KILL_NOTIFICATION_API_S_VER_1, CT_KILL_NOTIFICATION_API_S_VER_2 */
 
 /**
-* enum ctdp_cmd_operation - CTDP command operations
+* enum iwl_mvm_ctdp_cmd_operation - CTDP command operations
 * @CTDP_CMD_OPERATION_START: update the current budget
 * @CTDP_CMD_OPERATION_STOP: stop ctdp
 * @CTDP_CMD_OPERATION_REPORT: get the average budget
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index a1a272433b09..1a60f0cdf972 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022, 2024 Intel Corporation
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fw_api_rs_h__
@@ -9,7 +9,7 @@
 #include "mac.h"
 
 /**
- * enum iwl_tlc_mng_cfg_flags_enum - options for TLC config flags
+ * enum iwl_tlc_mng_cfg_flags - options for TLC config flags
  * @IWL_TLC_MNG_CFG_FLAGS_STBC_MSK: enable STBC. For HE this enables STBC for
  *				    bandwidths <= 80MHz
  * @IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK: enable LDPC
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index e71f29d0c694..8bd85ef90052 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -976,7 +976,7 @@ struct iwl_ba_window_status_notif {
 } __packed; /* BA_WINDOW_STATUS_NTFY_API_S_VER_1 */
 
 /**
- * struct iwl_rfh_queue_config - RX queue configuration
+ * struct iwl_rfh_queue_data - RX queue configuration
  * @q_num: Q num
  * @enable: enable queue
  * @reserved: alignment
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 69a204c7f14a..8598031567bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -149,7 +149,7 @@ struct iwl_scan_offload_profile_cfg_data {
 } __packed;
 
 /**
- * struct iwl_scan_offload_profile_cfg
+ * struct iwl_scan_offload_profile_cfg_v1 - scan offload profile config
  * @profiles:	profiles to search for match
  * @data:	the rest of the data for profile_cfg
  */
@@ -789,7 +789,7 @@ struct iwl_scan_req_umac_tail_v1 {
 } __packed;
 
 /**
- * struct iwl_scan_req_umac_tail - the rest of the UMAC scan request command
+ * struct iwl_scan_req_umac_tail_v2 - the rest of the UMAC scan request command
  *      parameters following channels configuration array.
  * @schedule: two scheduling plans.
  * @delay: delay in TUs before starting the first scan iteration
@@ -1085,7 +1085,7 @@ struct iwl_scan_req_params_v12 {
 } __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_12 */
 
 /**
- * struct iwl_scan_req_params_v16
+ * struct iwl_scan_req_params_v17 - scan request parameters (v17)
  * @general_params: &struct iwl_scan_general_params_v11
  * @channel_params: &struct iwl_scan_channel_params_v7
  * @periodic_params: &struct iwl_scan_periodic_parms_v1
@@ -1111,7 +1111,7 @@ struct iwl_scan_req_umac_v12 {
 } __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_12 */
 
 /**
- * struct iwl_scan_req_umac_v16
+ * struct iwl_scan_req_umac_v17 - scan request command (v17)
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
  * @ooc_priority: out of channel priority - &enum iwl_scan_priority
  * @scan_params: scan parameters
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 71669f81d93b..c5277e2f8cd4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -866,7 +866,7 @@ enum iwl_dump_control {
 };
 
 /**
- * struct iwl_tx_path_flush_cmd -- queue/FIFO flush command
+ * struct iwl_tx_path_flush_cmd_v1 -- queue/FIFO flush command
  * @queues_ctl: bitmap of queues to flush
  * @flush_ctl: control flags
  * @reserved: reserved
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 5c76e3b94968..e63b08b7d336 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -248,7 +248,7 @@ struct iwl_fw_error_dump_mem {
 #define IWL_INI_DUMP_NAME_TYPE (BIT(31) | BIT(24))
 
 /**
- * struct iwl_fw_error_dump_data - data for one type
+ * struct iwl_fw_ini_error_dump_data - data for one type
  * @type: &enum iwl_fw_ini_region_type
  * @sub_type: sub type id
  * @sub_type_ver: sub type version
@@ -278,7 +278,7 @@ struct iwl_fw_ini_dump_entry {
 } __packed;
 
 /**
- * struct iwl_fw_error_dump_file - header of dump file
+ * struct iwl_fw_ini_dump_file_hdr - header of dump file
  * @barker: must be %IWL_FW_INI_ERROR_DUMP_BARKER
  * @file_len: the length of all the file including the header
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 732889f96ca2..b2abd4fd1944 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -241,7 +241,7 @@ enum iwl_cfg_trans_ltr_delay {
 };
 
 /**
- * struct iwl_cfg_trans - information needed to start the trans
+ * struct iwl_cfg_trans_params - information needed to start the trans
  *
  * These values are specific to the device ID and do not change when
  * multiple configs are used for a single device ID.  They values are
@@ -258,6 +258,7 @@ enum iwl_cfg_trans_ltr_delay {
  * @mq_rx_supported: multi-queue rx support
  * @integrated: discrete or integrated
  * @low_latency_xtal: use the low latency xtal if supported
+ * @bisr_workaround: BISR hardware workaround (for 22260 series devices)
  * @ltr_delay: LTR delay parameter, &enum iwl_cfg_trans_ltr_delay.
  * @imr_enabled: use the IMR if supported.
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index fd82feb24b2d..0c6c3fb8c6dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -38,7 +38,7 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		   u8 tx_chains, u8 rx_chains);
 
 /**
- * iwl_parse_mcc_info - parse MCC (mobile country code) info coming from FW
+ * iwl_parse_nvm_mcc_info - parse MCC (mobile country code) info coming from FW
  *
  * This function parses the regulatory channel data received as a
  * MCC_UPDATE_CMD command. It returns a newly allocation regulatory domain,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f2d0c6fbcee5..362973fdeac0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -612,7 +612,7 @@ enum iwl_mvm_sched_scan_pass_all_states {
 };
 
 /**
- * struct iwl_mvm_tt_mgnt - Thermal Throttling Management structure
+ * struct iwl_mvm_tt_mgmt - Thermal Throttling Management structure
  * @ct_kill_exit: worker to exit thermal kill
  * @dynamic_smps: Is thermal throttling enabled dynamic_smps?
  * @tx_backoff: The current thremal throttling tx backoff in uSec.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index 6cd4ec4d8f34..20b9fa7deeda 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -3,7 +3,7 @@
  *
  * Copyright(c) 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright (C) 2003 - 2014, 2018 - 2023 Intel Corporation
+ * Copyright (C) 2003 - 2014, 2018 - 2024 Intel Corporation
  *****************************************************************************/
 
 #ifndef __rs_h__
@@ -402,7 +402,7 @@ void iwl_mvm_rs_tx_status(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			  int tid, struct ieee80211_tx_info *info, bool ndp);
 
 /**
- * iwl_rate_control_register - Register the rate control algorithm callbacks
+ * iwl_mvm_rate_control_register - Register the rate control algorithm callbacks
  *
  * Since the rate control algorithm is hardware specific, there is no need
  * or reason to place it as a stand alone module.  The driver can call
@@ -414,7 +414,7 @@ void iwl_mvm_rs_tx_status(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 int iwl_mvm_rate_control_register(void);
 
 /**
- * iwl_rate_control_unregister - Unregister the rate control callbacks
+ * iwl_mvm_rate_control_unregister - Unregister the rate control callbacks
  *
  * This should be called after calling ieee80211_unregister_hw, but before
  * the driver is unloaded.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 754a05a8c189..0dc83d6afb3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -478,7 +478,7 @@ struct iwl_mvm_int_sta {
 };
 
 /**
- * Send the STA info to the FW.
+ * iwl_mvm_sta_send_to_fw - Send the STA info to the FW.
  *
  * @mvm: the iwl_mvm* to use
  * @sta: the STA
-- 
2.34.1


