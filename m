Return-Path: <linux-wireless+bounces-18817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D0CA31E23
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB8E163D7F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D771F866A;
	Wed, 12 Feb 2025 05:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDZw3EF/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9361FBC9C
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 05:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339046; cv=none; b=IO9+Xj0eV+Yab/vibGomfHfPZr5GvV3zaZLUuP3nm04s/pnGEgkKEZboePG8RQmzSbDap5iKX/VKHafkTw0G3dKt+GiXd1DCaj1G4G5sG0zCVHpnKjKAgDzTi/+0/4jBAsbGfygy6Z6a/vxSz1GHIXaEC6UTKti2yckrbv4wklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339046; c=relaxed/simple;
	bh=NiZnGucTUVR56+3ZpAxOgwcfvtdDGeDIa0WfQ22xNN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r05oYAfUqVPa74/cPkW7QE2FJumbCxrOZqUsGjcBrYBBYDQNvsZHGnHWZ7fWVUtGV0zU3nW7tW9A29RNumi2GsVTJlgdtHN9yFkrZBh5nzpRb7zx4VE+l1j5rFynSaqnnbLByUe0e3nkgUX8xLBmoeCQl7qL53CWREDCAC7mqMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDZw3EF/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739339044; x=1770875044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NiZnGucTUVR56+3ZpAxOgwcfvtdDGeDIa0WfQ22xNN8=;
  b=kDZw3EF/KsopwFISvTuaqm9JBTM6S/fOynGmwbwowQQHlddHPTFAKcyY
   U8AsCbvNmR5Nm9R11hx6Js2ituh1zUA8UQ8AoO9NkpUKra2AGmKIbyPJA
   AFjg5QtAeHm+QoLoCkmdmwBNX4VGyblTx2R/rjfnvWcK3vBGr6rhhcewk
   NbnlRJ6xoBKONWUV+sJTtq5PELQPPYEbudqFfl8QJ108pumHEQYunxS7w
   +t4ojH8gWr0mY1dYN6mgHCKbsW7rOId5VVlEoo4SwGyzonb8KMF9D0pW6
   i4o2H6WeNzEWZ3wY6PTYslqqrDZHYJ54A99Z4c2ff1YQKaf1UCWgrLCJs
   A==;
X-CSE-ConnectionGUID: XkvdS5ThSjWIPQi4qoA2iQ==
X-CSE-MsgGUID: I7KoW7w9TxePuQP3wC4lGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39172230"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39172230"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:44:04 -0800
X-CSE-ConnectionGUID: s0OOdu9hS9a75XMUKPfnXg==
X-CSE-MsgGUID: QpzTX3/nTo2IKD8E+lSWqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117893931"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:44:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 12/12] wifi: iwlwifi: add Debug Host Command APIs
Date: Wed, 12 Feb 2025 07:43:33 +0200
Message-Id: <20250212073923.d842253ee55d.I2e8d65f22d5acde70ed6be16f913160a93d06852@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
References: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Add the defintition of those APIs, those will be used in a later patch.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   5 +
 .../net/wireless/intel/iwlwifi/fw/api/dhc.h   | 129 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  52 +++++++
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 4b450c722a9c..d43adb6f9220 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -506,6 +506,11 @@ enum iwl_legacy_cmds {
 	 */
 	DTS_MEASUREMENT_NOTIFICATION = 0xdd,
 
+	/**
+	 * @DEBUG_HOST_COMMAND: &struct iwl_dhc_cmd
+	 */
+	DEBUG_HOST_COMMAND = 0xf1,
+
 	/**
 	 * @LDBG_CONFIG_CMD: configure continuous trace recording
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h
new file mode 100644
index 000000000000..dbe06f3fc662
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+#ifndef __iwl_fw_api_dhc_h__
+#define __iwl_fw_api_dhc_h__
+
+#define DHC_TABLE_MASK_POS (28)
+
+/**
+ * enum iwl_dhc_table_id - DHC table operations index
+ */
+enum iwl_dhc_table_id {
+	/**
+	 * @DHC_TABLE_INTEGRATION: select the integration table
+	 */
+	DHC_TABLE_INTEGRATION	= 2 << DHC_TABLE_MASK_POS,
+};
+
+/**
+ * enum iwl_dhc_umac_integration_table - integration operations
+ */
+enum iwl_dhc_umac_integration_table {
+	/**
+	 * @DHC_INT_UMAC_TWT_OPERATION: trigger a TWT operation
+	 */
+	DHC_INT_UMAC_TWT_OPERATION = 4,
+	/**
+	 * @DHC_INTEGRATION_TLC_DEBUG_CONFIG: TLC debug
+	 */
+	DHC_INTEGRATION_TLC_DEBUG_CONFIG = 1,
+	/**
+	 * @DHC_INTEGRATION_MAX: Maximum UMAC integration table entries
+	 */
+	DHC_INTEGRATION_MAX
+};
+
+#define DHC_TARGET_UMAC BIT(27)
+
+/**
+ * struct iwl_dhc_cmd - debug host command
+ * @length: length in DWs of the data structure that is concatenated to the end
+ *	of this struct
+ * @index_and_mask: bit 31 is 1 for data set operation else it's 0
+ *	bits 28-30 is the index of the table of the operation -
+ *	&enum iwl_dhc_table_id *
+ *	bit 27 is 0 if the cmd targeted to LMAC and 1 if targeted to UMAC,
+ *	(LMAC is 0 for backward compatibility)
+ *	bit 26 is 0 if the cmd targeted to LMAC0 and 1 if targeted to LMAC1,
+ *	relevant only if bit 27 set to 0
+ *	bits 0-25 is a specific entry index in the table specified in bits 28-30
+ *
+ * @data: the concatenated data.
+ */
+struct iwl_dhc_cmd {
+	__le32 length;
+	__le32 index_and_mask;
+	__le32 data[];
+} __packed; /* DHC_CMD_API_S */
+
+/**
+ * enum iwl_dhc_twt_operation_type - describes the TWT operation type
+ *
+ * @DHC_TWT_REQUEST: Send a Request TWT command
+ * @DHC_TWT_SUGGEST: Send a Suggest TWT command
+ * @DHC_TWT_DEMAND: Send a Demand TWT command
+ * @DHC_TWT_GROUPING: Send a Grouping TWT command
+ * @DHC_TWT_ACCEPT: Send a Accept TWT command
+ * @DHC_TWT_ALTERNATE: Send a Alternate TWT command
+ * @DHC_TWT_DICTATE: Send a Dictate TWT command
+ * @DHC_TWT_REJECT: Send a Reject TWT command
+ * @DHC_TWT_TEARDOWN: Send a TearDown TWT command
+ */
+enum iwl_dhc_twt_operation_type {
+	DHC_TWT_REQUEST,
+	DHC_TWT_SUGGEST,
+	DHC_TWT_DEMAND,
+	DHC_TWT_GROUPING,
+	DHC_TWT_ACCEPT,
+	DHC_TWT_ALTERNATE,
+	DHC_TWT_DICTATE,
+	DHC_TWT_REJECT,
+	DHC_TWT_TEARDOWN,
+}; /* DHC_TWT_OPERATION_TYPE_E */
+
+/**
+ * struct iwl_dhc_twt_operation - trigger a TWT operation
+ *
+ * @mac_id: the mac Id on which to trigger TWT operation
+ * @twt_operation: see &enum iwl_dhc_twt_operation_type
+ * @target_wake_time: when should we be on channel
+ * @interval_exp: the exponent for the interval
+ * @interval_mantissa: the mantissa for the interval
+ * @min_wake_duration: the minimum duration for the wake period
+ * @trigger: is the TWT triggered or not
+ * @flow_type: is the TWT announced or not
+ * @flow_id: the TWT flow identifier from 0 to 7
+ * @protection: is the TWT protected
+ * @ndo_paging_indicator: is ndo_paging_indicator set
+ * @responder_pm_mode: is responder_pm_mode set
+ * @negotiation_type: if the responder wants to doze outside the TWT SP
+ * @twt_request: 1 for TWT request, 0 otherwise
+ * @implicit: is TWT implicit
+ * @twt_group_assignment: the TWT group assignment
+ * @twt_channel: the TWT channel
+ * @reserved: reserved
+ */
+struct iwl_dhc_twt_operation {
+	__le32 mac_id;
+	__le32 twt_operation;
+	__le64 target_wake_time;
+	__le32 interval_exp;
+	__le32 interval_mantissa;
+	__le32 min_wake_duration;
+	u8 trigger;
+	u8 flow_type;
+	u8 flow_id;
+	u8 protection;
+	u8 ndo_paging_indicator;
+	u8 responder_pm_mode;
+	u8 negotiation_type;
+	u8 twt_request;
+	u8 implicit;
+	u8 twt_group_assignment;
+	u8 twt_channel;
+	u8 reserved;
+}; /* DHC_TWT_OPERATION_API_S */
+
+#endif /* __iwl_fw_api_dhc_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index 1a60f0cdf972..c2f806cbab59 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -226,6 +226,58 @@ struct iwl_tlc_update_notif {
 	__le32 amsdu_enabled;
 } __packed; /* TLC_MNG_UPDATE_NTFY_API_S_VER_2 */
 
+/**
+ * enum iwl_tlc_debug_types - debug options
+ */
+enum iwl_tlc_debug_types {
+	/**
+	 *  @IWL_TLC_DEBUG_FIXED_RATE: set fixed rate for rate scaling
+	 */
+	IWL_TLC_DEBUG_FIXED_RATE,
+	/**
+	 * @IWL_TLC_DEBUG_AGG_DURATION_LIM: time limit for a BA
+	 * session, in usec
+	 */
+	IWL_TLC_DEBUG_AGG_DURATION_LIM,
+	/**
+	 * @IWL_TLC_DEBUG_AGG_FRAME_CNT_LIM: set max number of frames
+	 * in an aggregation
+	 */
+	IWL_TLC_DEBUG_AGG_FRAME_CNT_LIM,
+	/**
+	 * @IWL_TLC_DEBUG_TPC_ENABLED: enable or disable tpc
+	 */
+	IWL_TLC_DEBUG_TPC_ENABLED,
+	/**
+	 * @IWL_TLC_DEBUG_TPC_STATS: get number of frames Tx'ed in each
+	 * tpc step
+	 */
+	IWL_TLC_DEBUG_TPC_STATS,
+	/**
+	 * @IWL_TLC_DEBUG_RTS_DISABLE: disable RTS (bool true/false).
+	 */
+	IWL_TLC_DEBUG_RTS_DISABLE,
+	/**
+	 * @IWL_TLC_DEBUG_PARTIAL_FIXED_RATE: set partial fixed rate to fw
+	 */
+	IWL_TLC_DEBUG_PARTIAL_FIXED_RATE,
+}; /* TLC_MNG_DEBUG_TYPES_API_E */
+
+#define MAX_DATA_IN_DHC_TLC_CMD 10
+
+/**
+ * struct iwl_dhc_tlc_cmd - fixed debug config
+ * @sta_id: bit 0 - enable/disable, bits 1 - 7 hold station id
+ * @reserved1: reserved
+ * @type: type id of %enum iwl_tlc_debug_types
+ * @data: data to send
+ */
+struct iwl_dhc_tlc_cmd {
+	u8 sta_id;
+	u8 reserved1[3];
+	__le32 type;
+	__le32 data[MAX_DATA_IN_DHC_TLC_CMD];
+} __packed; /* TLC_MNG_DEBUG_CMD_S */
 
 #define IWL_MAX_MCS_DISPLAY_SIZE        12
 
-- 
2.34.1


