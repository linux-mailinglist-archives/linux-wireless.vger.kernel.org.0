Return-Path: <linux-wireless+bounces-18987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2A0A37383
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B3F16CF75
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC14E1917E7;
	Sun, 16 Feb 2025 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxW7nBKn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46618DB19
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699040; cv=none; b=CaUxgCURM2i/+NXdHYbgp0C5Jxw9zdZ7DpXbXSaekna0H7H6ZDDniem8wb33LiZBpRcIYr3+i9J3O9Bo3DAbpwE2IbXfhDLACog7Yle4szUgP6Z5vD+sVkRAm0bArR1j9GqQX0XeIe4hqHFz/pe1Pb5pOuI4O4NRXJLCJ07e8EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699040; c=relaxed/simple;
	bh=UaSdZXMg17ItZuUQyYc4aIZmUYWNFvTYy24HSeVDnAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RhhSWYr5QVpvBeI4rBl68VX2/e0TVzGbhvLqRozpdEbwH+yFH2c9eBcGsIJnzRcoDGsAz9ZTBdjaaUAFZCx4c/oQavSNUqFvSmwwlUqn9dMWGv9wFHbPc3qcCRCNh2Cp7/yCql1DZ/d9EtYRnSsNOQuurn+ASZm5WplfGahg0I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxW7nBKn; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699038; x=1771235038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UaSdZXMg17ItZuUQyYc4aIZmUYWNFvTYy24HSeVDnAM=;
  b=UxW7nBKnhN4rU0PW1LytW+FNwn3Ul0cdNjqe8xqsSruoyVhqiBotTd3G
   727WOm4XbarKxvS/1enw9daMZosqkSVLF6WaXzKcQXrJYnACjyhJGx8dn
   E4wDeGsZA6fJo1qnSau+t/EywtzXDX54opn32F31EJt02PPvORHXAdKox
   f4PPZ8zg7asfTqSA8KyEPBL57WiCGP3Ugeqv7+0tgXrY7E6s8HvswrpMx
   0X5e0GBjJi3dvpDNIGSro6DNmEiET7YaQxcdIsYPmkm5NWS07RxckhINe
   hO6flhEfi2L2o+azmwIwWkl7AjTUNY3iNILhwnCA3Ks0q7a0hDfHL8J77
   Q==;
X-CSE-ConnectionGUID: YGzzYJjvT1KOAR2lvrUphQ==
X-CSE-MsgGUID: fzFjmZfZSi2kUBCoWBBpYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323390"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323390"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:58 -0800
X-CSE-ConnectionGUID: Zv3IVwRPTHOyxi55fGqX4A==
X-CSE-MsgGUID: gIe4Dc4lReyCc/L31r3I2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785244"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:56 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 17/42] wifi: iwlwifi: mld: add file mld.h/c
Date: Sun, 16 Feb 2025 11:42:56 +0200
Message-Id: <20250216111648.9245e56fded3.Ib878ab1aaf497469bc95819f0c536ff531e77cee@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
References: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

these files contain the opmode management.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 707 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/mld.h | 586 +++++++++++++++
 2 files changed, 1293 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mld.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mld.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
new file mode 100644
index 000000000000..adc3d23aa019
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -0,0 +1,707 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+
+#include <net/mac80211.h>
+
+#include "fw/api/rx.h"
+#include "fw/api/datapath.h"
+#include "fw/api/commands.h"
+#include "fw/api/offload.h"
+#include "fw/api/coex.h"
+#include "fw/dbg.h"
+#include "fw/uefi.h"
+
+#include "mld.h"
+#include "mlo.h"
+#include "mac80211.h"
+#include "led.h"
+#include "scan.h"
+#include "tx.h"
+#include "sta.h"
+#include "regulatory.h"
+#include "thermal.h"
+#include "low_latency.h"
+#include "hcmd.h"
+#include "fw/api/location.h"
+
+#define DRV_DESCRIPTION "Intel(R) MLD wireless driver for Linux"
+MODULE_DESCRIPTION(DRV_DESCRIPTION);
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IWLWIFI");
+
+static const struct iwl_op_mode_ops iwl_mld_ops;
+
+static int __init iwl_mld_init(void)
+{
+	int ret = iwl_opmode_register("iwlmld", &iwl_mld_ops);
+
+	if (ret)
+		pr_err("Unable to register MLD op_mode: %d\n", ret);
+
+	return ret;
+}
+module_init(iwl_mld_init);
+
+static void __exit iwl_mld_exit(void)
+{
+	iwl_opmode_deregister("iwlmld");
+}
+module_exit(iwl_mld_exit);
+
+VISIBLE_IF_IWLWIFI_KUNIT
+void iwl_construct_mld(struct iwl_mld *mld, struct iwl_trans *trans,
+		       const struct iwl_cfg *cfg, const struct iwl_fw *fw,
+		       struct ieee80211_hw *hw, struct dentry *dbgfs_dir)
+{
+	mld->dev = trans->dev;
+	mld->trans = trans;
+	mld->cfg = cfg;
+	mld->fw = fw;
+	mld->hw = hw;
+	mld->wiphy = hw->wiphy;
+	mld->debugfs_dir = dbgfs_dir;
+
+	iwl_notification_wait_init(&mld->notif_wait);
+
+	/* Setup async RX handling */
+	spin_lock_init(&mld->async_handlers_lock);
+	INIT_LIST_HEAD(&mld->async_handlers_list);
+	wiphy_work_init(&mld->async_handlers_wk,
+			iwl_mld_async_handlers_wk);
+
+	/* Dynamic Queue Allocation */
+	spin_lock_init(&mld->add_txqs_lock);
+	INIT_LIST_HEAD(&mld->txqs_to_add);
+	wiphy_work_init(&mld->add_txqs_wk, iwl_mld_add_txqs_wk);
+
+	/* Setup RX queues sync wait queue */
+	init_waitqueue_head(&mld->rxq_sync.waitq);
+}
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_construct_mld);
+
+static void __acquires(&mld->wiphy->mtx)
+iwl_mld_fwrt_dump_start(void *ctx)
+{
+	struct iwl_mld *mld = ctx;
+
+	wiphy_lock(mld->wiphy);
+}
+
+static void __releases(&mld->wiphy->mtx)
+iwl_mld_fwrt_dump_end(void *ctx)
+{
+	struct iwl_mld *mld = ctx;
+
+	wiphy_unlock(mld->wiphy);
+}
+
+static bool iwl_mld_d3_debug_enable(void *ctx)
+{
+	return IWL_MLD_D3_DEBUG;
+}
+
+static int iwl_mld_fwrt_send_hcmd(void *ctx, struct iwl_host_cmd *host_cmd)
+{
+	struct iwl_mld *mld = (struct iwl_mld *)ctx;
+	int ret;
+
+	wiphy_lock(mld->wiphy);
+	ret = iwl_mld_send_cmd(mld, host_cmd);
+	wiphy_unlock(mld->wiphy);
+
+	return ret;
+}
+
+static const struct iwl_fw_runtime_ops iwl_mld_fwrt_ops = {
+	.dump_start = iwl_mld_fwrt_dump_start,
+	.dump_end = iwl_mld_fwrt_dump_end,
+	.send_hcmd = iwl_mld_fwrt_send_hcmd,
+	.d3_debug_enable = iwl_mld_d3_debug_enable,
+};
+
+static void
+iwl_mld_construct_fw_runtime(struct iwl_mld *mld, struct iwl_trans *trans,
+			     const struct iwl_fw *fw,
+			     struct dentry *debugfs_dir)
+{
+	iwl_fw_runtime_init(&mld->fwrt, trans, fw, &iwl_mld_fwrt_ops, mld,
+			    NULL, NULL, debugfs_dir);
+
+	iwl_fw_set_current_image(&mld->fwrt, IWL_UCODE_REGULAR);
+}
+
+/* Please keep this array *SORTED* by hex value.
+ * Access is done through binary search
+ */
+static const struct iwl_hcmd_names iwl_mld_legacy_names[] = {
+	HCMD_NAME(UCODE_ALIVE_NTFY),
+	HCMD_NAME(INIT_COMPLETE_NOTIF),
+	HCMD_NAME(PHY_CONTEXT_CMD),
+	HCMD_NAME(SCAN_CFG_CMD),
+	HCMD_NAME(SCAN_REQ_UMAC),
+	HCMD_NAME(SCAN_ABORT_UMAC),
+	HCMD_NAME(SCAN_COMPLETE_UMAC),
+	HCMD_NAME(TX_CMD),
+	HCMD_NAME(TXPATH_FLUSH),
+	HCMD_NAME(LEDS_CMD),
+	HCMD_NAME(WNM_80211V_TIMING_MEASUREMENT_NOTIFICATION),
+	HCMD_NAME(WNM_80211V_TIMING_MEASUREMENT_CONFIRM_NOTIFICATION),
+	HCMD_NAME(SCAN_OFFLOAD_UPDATE_PROFILES_CMD),
+	HCMD_NAME(POWER_TABLE_CMD),
+	HCMD_NAME(PSM_UAPSD_AP_MISBEHAVING_NOTIFICATION),
+	HCMD_NAME(BEACON_NOTIFICATION),
+	HCMD_NAME(BEACON_TEMPLATE_CMD),
+	HCMD_NAME(TX_ANT_CONFIGURATION_CMD),
+	HCMD_NAME(REDUCE_TX_POWER_CMD),
+	HCMD_NAME(MISSED_BEACONS_NOTIFICATION),
+	HCMD_NAME(MAC_PM_POWER_TABLE),
+	HCMD_NAME(MFUART_LOAD_NOTIFICATION),
+	HCMD_NAME(RSS_CONFIG_CMD),
+	HCMD_NAME(SCAN_ITERATION_COMPLETE_UMAC),
+	HCMD_NAME(REPLY_RX_MPDU_CMD),
+	HCMD_NAME(BA_NOTIF),
+	HCMD_NAME(MCC_UPDATE_CMD),
+	HCMD_NAME(MCC_CHUB_UPDATE_CMD),
+	HCMD_NAME(MCAST_FILTER_CMD),
+	HCMD_NAME(REPLY_BEACON_FILTERING_CMD),
+	HCMD_NAME(PROT_OFFLOAD_CONFIG_CMD),
+	HCMD_NAME(MATCH_FOUND_NOTIFICATION),
+	HCMD_NAME(WOWLAN_PATTERNS),
+	HCMD_NAME(WOWLAN_CONFIGURATION),
+	HCMD_NAME(WOWLAN_TSC_RSC_PARAM),
+	HCMD_NAME(WOWLAN_KEK_KCK_MATERIAL),
+	HCMD_NAME(DEBUG_HOST_COMMAND),
+	HCMD_NAME(LDBG_CONFIG_CMD),
+};
+
+/* Please keep this array *SORTED* by hex value.
+ * Access is done through binary search
+ */
+static const struct iwl_hcmd_names iwl_mld_system_names[] = {
+	HCMD_NAME(SHARED_MEM_CFG_CMD),
+	HCMD_NAME(SOC_CONFIGURATION_CMD),
+	HCMD_NAME(INIT_EXTENDED_CFG_CMD),
+	HCMD_NAME(FW_ERROR_RECOVERY_CMD),
+	HCMD_NAME(RFI_GET_FREQ_TABLE_CMD),
+	HCMD_NAME(SYSTEM_STATISTICS_CMD),
+	HCMD_NAME(SYSTEM_STATISTICS_END_NOTIF),
+};
+
+/* Please keep this array *SORTED* by hex value.
+ * Access is done through binary search
+ */
+static const struct iwl_hcmd_names iwl_mld_reg_and_nvm_names[] = {
+	HCMD_NAME(LARI_CONFIG_CHANGE),
+	HCMD_NAME(NVM_GET_INFO),
+	HCMD_NAME(TAS_CONFIG),
+	HCMD_NAME(SAR_OFFSET_MAPPING_TABLE_CMD),
+	HCMD_NAME(MCC_ALLOWED_AP_TYPE_CMD),
+};
+
+/* Please keep this array *SORTED* by hex value.
+ * Access is done through binary search
+ */
+static const struct iwl_hcmd_names iwl_mld_debug_names[] = {
+	HCMD_NAME(HOST_EVENT_CFG),
+	HCMD_NAME(DBGC_SUSPEND_RESUME),
+};
+
+/* Please keep this array *SORTED* by hex value.
+ * Access is done through binary search
+ */
+static const struct iwl_hcmd_names iwl_mld_mac_conf_names[] = {
+	HCMD_NAME(LOW_LATENCY_CMD),
+	HCMD_NAME(SESSION_PROTECTION_CMD),
+	HCMD_NAME(MAC_CONFIG_CMD),
+	HCMD_NAME(LINK_CONFIG_CMD),
+	HCMD_NAME(STA_CONFIG_CMD),
+	HCMD_NAME(AUX_STA_CMD),
+	HCMD_NAME(STA_REMOVE_CMD),
+	HCMD_NAME(ROC_CMD),
+	HCMD_NAME(MISSED_BEACONS_NOTIF),
+	HCMD_NAME(EMLSR_TRANS_FAIL_NOTIF),
+	HCMD_NAME(ROC_NOTIF),
+	HCMD_NAME(CHANNEL_SWITCH_ERROR_NOTIF),
+	HCMD_NAME(SESSION_PROTECTION_NOTIF),
+	HCMD_NAME(PROBE_RESPONSE_DATA_NOTIF),
+	HCMD_NAME(CHANNEL_SWITCH_START_NOTIF),
+};
+
+/* Please keep this array *SORTED* by hex value.
+ * Access is done through binary search
+ */
+static const struct iwl_hcmd_names iwl_mld_data_path_names[] = {
+	HCMD_NAME(TRIGGER_RX_QUEUES_NOTIF_CMD),
+	HCMD_NAME(WNM_PLATFORM_PTM_REQUEST_CMD),
+	HCMD_NAME(WNM_80211V_TIMING_MEASUREMENT_CONFIG_CMD),
+	HCMD_NAME(RFH_QUEUE_CONFIG_CMD),
+	HCMD_NAME(TLC_MNG_CONFIG_CMD),
+	HCMD_NAME(RX_BAID_ALLOCATION_CONFIG_CMD),
+	HCMD_NAME(SCD_QUEUE_CONFIG_CMD),
+	HCMD_NAME(OMI_SEND_STATUS_NOTIF),
+	HCMD_NAME(ESR_MODE_NOTIF),
+	HCMD_NAME(MONITOR_NOTIF),
+	HCMD_NAME(TLC_MNG_UPDATE_NOTIF),
+	HCMD_NAME(MU_GROUP_MGMT_NOTIF),
+};
+
+/* Please keep this array *SORTED* by hex value.
+ * Access is done through binary search
+ */
+static const struct iwl_hcmd_names iwl_mld_location_names[] = {
+	HCMD_NAME(TOF_RANGE_REQ_CMD),
+	HCMD_NAME(TOF_RANGE_RESPONSE_NOTIF),
+};
+
+/* Please keep this array *SORTED* by hex value.
+ * Access is done through binary search
+ */
+static const struct iwl_hcmd_names iwl_mld_phy_names[] = {
+	HCMD_NAME(CMD_DTS_MEASUREMENT_TRIGGER_WIDE),
+	HCMD_NAME(CTDP_CONFIG_CMD),
+	HCMD_NAME(TEMP_REPORTING_THRESHOLDS_CMD),
+	HCMD_NAME(PER_CHAIN_LIMIT_OFFSET_CMD),
+	HCMD_NAME(CT_KILL_NOTIFICATION),
+	HCMD_NAME(DTS_MEASUREMENT_NOTIF_WIDE),
+};
+
+/* Please keep this array *SORTED* by hex value.
+ * Access is done through binary search
+ */
+static const struct iwl_hcmd_names iwl_mld_statistics_names[] = {
+	HCMD_NAME(STATISTICS_OPER_NOTIF),
+	HCMD_NAME(STATISTICS_OPER_PART1_NOTIF),
+};
+
+/* Please keep this array *SORTED* by hex value.
+ * Access is done through binary search
+ */
+static const struct iwl_hcmd_names iwl_mld_prot_offload_names[] = {
+	HCMD_NAME(STORED_BEACON_NTF),
+};
+
+/* Please keep this array *SORTED* by hex value.
+ * Access is done through binary search
+ */
+static const struct iwl_hcmd_names iwl_mld_coex_names[] = {
+	HCMD_NAME(PROFILE_NOTIF),
+};
+
+VISIBLE_IF_IWLWIFI_KUNIT
+const struct iwl_hcmd_arr iwl_mld_groups[] = {
+	[LEGACY_GROUP] = HCMD_ARR(iwl_mld_legacy_names),
+	[LONG_GROUP] = HCMD_ARR(iwl_mld_legacy_names),
+	[SYSTEM_GROUP] = HCMD_ARR(iwl_mld_system_names),
+	[MAC_CONF_GROUP] = HCMD_ARR(iwl_mld_mac_conf_names),
+	[DATA_PATH_GROUP] = HCMD_ARR(iwl_mld_data_path_names),
+	[LOCATION_GROUP] = HCMD_ARR(iwl_mld_location_names),
+	[REGULATORY_AND_NVM_GROUP] = HCMD_ARR(iwl_mld_reg_and_nvm_names),
+	[DEBUG_GROUP] = HCMD_ARR(iwl_mld_debug_names),
+	[PHY_OPS_GROUP] = HCMD_ARR(iwl_mld_phy_names),
+	[STATISTICS_GROUP] = HCMD_ARR(iwl_mld_statistics_names),
+	[PROT_OFFLOAD_GROUP] = HCMD_ARR(iwl_mld_prot_offload_names),
+	[BT_COEX_GROUP] = HCMD_ARR(iwl_mld_coex_names),
+};
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_groups);
+
+#if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
+const unsigned int global_iwl_mld_goups_size = ARRAY_SIZE(iwl_mld_groups);
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(global_iwl_mld_goups_size);
+#endif
+
+static void
+iwl_mld_configure_trans(struct iwl_op_mode *op_mode)
+{
+	const struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
+	static const u8 no_reclaim_cmds[] = {TX_CMD};
+	struct iwl_trans_config trans_cfg = {
+		.op_mode = op_mode,
+		/* Rx is not supported yet, but add it to avoid warnings */
+		.rx_buf_size = iwl_amsdu_size_to_rxb_size(),
+		.command_groups = iwl_mld_groups,
+		.command_groups_size = ARRAY_SIZE(iwl_mld_groups),
+		.fw_reset_handshake = true,
+		.queue_alloc_cmd_ver =
+			iwl_fw_lookup_cmd_ver(mld->fw,
+					      WIDE_ID(DATA_PATH_GROUP,
+						      SCD_QUEUE_CONFIG_CMD),
+					      0),
+		.no_reclaim_cmds = no_reclaim_cmds,
+		.n_no_reclaim_cmds = ARRAY_SIZE(no_reclaim_cmds),
+		.cb_data_offs = offsetof(struct ieee80211_tx_info,
+					 driver_data[2]),
+	};
+	struct iwl_trans *trans = mld->trans;
+
+	trans->rx_mpdu_cmd = REPLY_RX_MPDU_CMD;
+	trans->iml = mld->fw->iml;
+	trans->iml_len = mld->fw->iml_len;
+	trans->wide_cmd_header = true;
+
+	iwl_trans_configure(trans, &trans_cfg);
+}
+
+/*
+ *****************************************************
+ * op mode ops functions
+ *****************************************************
+ */
+
+#define NUM_FW_LOAD_RETRIES	3
+static struct iwl_op_mode *
+iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+		      const struct iwl_fw *fw, struct dentry *dbgfs_dir)
+{
+	struct ieee80211_hw *hw;
+	struct iwl_op_mode *op_mode;
+	struct iwl_mld *mld;
+	u32 eckv_value;
+	int ret;
+
+	/* Allocate and initialize a new hardware device */
+	hw = ieee80211_alloc_hw(sizeof(struct iwl_op_mode) +
+				sizeof(struct iwl_mld),
+				&iwl_mld_hw_ops);
+	if (!hw)
+		return ERR_PTR(-ENOMEM);
+
+	op_mode = hw->priv;
+
+	op_mode->ops = &iwl_mld_ops;
+
+	mld = IWL_OP_MODE_GET_MLD(op_mode);
+
+	iwl_construct_mld(mld, trans, cfg, fw, hw, dbgfs_dir);
+
+	iwl_mld_construct_fw_runtime(mld, trans, fw, dbgfs_dir);
+
+	iwl_mld_get_bios_tables(mld);
+	iwl_uefi_get_sgom_table(trans, &mld->fwrt);
+	iwl_uefi_get_step_table(trans);
+	if (iwl_bios_get_eckv(&mld->fwrt, &eckv_value))
+		IWL_DEBUG_RADIO(mld, "ECKV table doesn't exist in BIOS\n");
+	else
+		trans->ext_32khz_clock_valid = !!eckv_value;
+	iwl_bios_setup_step(trans, &mld->fwrt);
+	mld->bios_enable_puncturing = iwl_uefi_get_puncturing(&mld->fwrt);
+
+	/* Configure transport layer with the opmode specific params */
+	iwl_mld_configure_trans(op_mode);
+
+	/* Needed for sending commands */
+	wiphy_lock(mld->wiphy);
+
+	for (int i = 0; i < NUM_FW_LOAD_RETRIES; i++) {
+		ret = iwl_mld_load_fw(mld);
+		if (!ret)
+			break;
+	}
+
+	if (ret) {
+		wiphy_unlock(mld->wiphy);
+		iwl_fw_flush_dumps(&mld->fwrt);
+		goto free_hw;
+	}
+
+	iwl_mld_stop_fw(mld);
+
+	wiphy_unlock(mld->wiphy);
+
+	ret = iwl_mld_leds_init(mld);
+	if (ret)
+		goto free_nvm;
+
+	ret = iwl_mld_alloc_scan_cmd(mld);
+	if (ret)
+		goto leds_exit;
+
+	ret = iwl_mld_low_latency_init(mld);
+	if (ret)
+		goto free_scan_cmd;
+
+	ret = iwl_mld_register_hw(mld);
+	if (ret)
+		goto low_latency_free;
+
+	iwl_mld_toggle_tx_ant(mld, &mld->mgmt_tx_ant);
+
+	iwl_mld_add_debugfs_files(mld, dbgfs_dir);
+	iwl_mld_thermal_initialize(mld);
+
+	iwl_mld_ptp_init(mld);
+
+	return op_mode;
+
+low_latency_free:
+	iwl_mld_low_latency_free(mld);
+free_scan_cmd:
+	kfree(mld->scan.cmd);
+leds_exit:
+	iwl_mld_leds_exit(mld);
+free_nvm:
+	kfree(mld->nvm_data);
+free_hw:
+	ieee80211_free_hw(mld->hw);
+	return ERR_PTR(ret);
+}
+
+static void
+iwl_op_mode_mld_stop(struct iwl_op_mode *op_mode)
+{
+	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
+
+	iwl_mld_ptp_remove(mld);
+	iwl_mld_leds_exit(mld);
+
+	wiphy_lock(mld->wiphy);
+	iwl_mld_thermal_exit(mld);
+	iwl_mld_low_latency_stop(mld);
+	iwl_mld_deinit_time_sync(mld);
+	wiphy_unlock(mld->wiphy);
+
+	ieee80211_unregister_hw(mld->hw);
+
+	iwl_fw_runtime_free(&mld->fwrt);
+	iwl_mld_low_latency_free(mld);
+
+	iwl_trans_op_mode_leave(mld->trans);
+
+	kfree(mld->nvm_data);
+	kfree(mld->scan.cmd);
+	kfree(mld->error_recovery_buf);
+	kfree(mld->mcast_filter_cmd);
+
+	ieee80211_free_hw(mld->hw);
+}
+
+static void iwl_mld_queue_state_change(struct iwl_op_mode *op_mode,
+				       int hw_queue, bool queue_full)
+{
+	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
+	struct ieee80211_txq *txq;
+	struct iwl_mld_sta *mld_sta;
+	struct iwl_mld_txq *mld_txq;
+
+	rcu_read_lock();
+
+	txq = rcu_dereference(mld->fw_id_to_txq[hw_queue]);
+	if (!txq) {
+		rcu_read_unlock();
+
+		if (queue_full) {
+			/* An internal queue is not expected to become full */
+			IWL_WARN(mld,
+				 "Internal hw_queue %d is full! stopping all queues\n",
+				 hw_queue);
+			/* Stop all queues, as an internal queue is not
+			 * mapped to a mac80211 one
+			 */
+			ieee80211_stop_queues(mld->hw);
+		} else {
+			ieee80211_wake_queues(mld->hw);
+		}
+
+		return;
+	}
+
+	mld_txq = iwl_mld_txq_from_mac80211(txq);
+	mld_sta = txq->sta ? iwl_mld_sta_from_mac80211(txq->sta) : NULL;
+
+	mld_txq->status.stop_full = queue_full;
+
+	if (!queue_full && mld_sta &&
+	    mld_sta->sta_state != IEEE80211_STA_NOTEXIST) {
+		local_bh_disable();
+		iwl_mld_tx_from_txq(mld, txq);
+		local_bh_enable();
+	}
+
+	rcu_read_unlock();
+}
+
+static void
+iwl_mld_queue_full(struct iwl_op_mode *op_mode, int hw_queue)
+{
+	iwl_mld_queue_state_change(op_mode, hw_queue, true);
+}
+
+static void
+iwl_mld_queue_not_full(struct iwl_op_mode *op_mode, int hw_queue)
+{
+	iwl_mld_queue_state_change(op_mode, hw_queue, false);
+}
+
+static bool
+iwl_mld_set_hw_rfkill_state(struct iwl_op_mode *op_mode, bool state)
+{
+	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
+
+	iwl_mld_set_hwkill(mld, state);
+
+	return false;
+}
+
+static void
+iwl_mld_free_skb(struct iwl_op_mode *op_mode, struct sk_buff *skb)
+{
+	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+
+	iwl_trans_free_tx_cmd(mld->trans, info->driver_data[1]);
+	ieee80211_free_txskb(mld->hw, skb);
+}
+
+static void iwl_mld_read_error_recovery_buffer(struct iwl_mld *mld)
+{
+	u32 src_size = mld->fw->ucode_capa.error_log_size;
+	u32 src_addr = mld->fw->ucode_capa.error_log_addr;
+	u8 *recovery_buf;
+	int ret;
+
+	/* no recovery buffer size defined in a TLV */
+	if (!src_size)
+		return;
+
+	recovery_buf = kzalloc(src_size, GFP_ATOMIC);
+	if (!recovery_buf)
+		return;
+
+	ret = iwl_trans_read_mem_bytes(mld->trans, src_addr,
+				       recovery_buf, src_size);
+	if (ret) {
+		IWL_ERR(mld, "Failed to read error recovery buffer (%d)\n",
+			ret);
+		kfree(recovery_buf);
+		return;
+	}
+
+	mld->error_recovery_buf = recovery_buf;
+}
+
+static void iwl_mld_restart_nic(struct iwl_mld *mld)
+{
+	iwl_mld_read_error_recovery_buffer(mld);
+
+	mld->fwrt.trans->dbg.restart_required = false;
+
+	ieee80211_restart_hw(mld->hw);
+}
+
+static void
+iwl_mld_nic_error(struct iwl_op_mode *op_mode,
+		  enum iwl_fw_error_type type)
+{
+	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
+	bool trans_dead = test_bit(STATUS_TRANS_DEAD, &mld->trans->status);
+
+	if (type == IWL_ERR_TYPE_CMD_QUEUE_FULL)
+		IWL_ERR(mld, "Command queue full!\n");
+	else if (!trans_dead && !mld->fw_status.do_not_dump_once)
+		iwl_fwrt_dump_error_logs(&mld->fwrt);
+
+	mld->fw_status.do_not_dump_once = false;
+
+	/* It is necessary to abort any os scan here because mac80211 requires
+	 * having the scan cleared before restarting.
+	 * We'll reset the scan_status to NONE in restart cleanup in
+	 * the next drv_start() call from mac80211. If ieee80211_hw_restart
+	 * isn't called scan status will stay busy.
+	 */
+	iwl_mld_report_scan_aborted(mld);
+
+	/*
+	 * This should be first thing before trying to collect any
+	 * data to avoid endless loops if any HW error happens while
+	 * collecting debug data.
+	 * It might not actually be true that we'll restart, but the
+	 * setting doesn't matter if we're going to be unbound either.
+	 */
+	if (type != IWL_ERR_TYPE_RESET_HS_TIMEOUT)
+		mld->fw_status.in_hw_restart = true;
+}
+
+static void iwl_mld_dump_error(struct iwl_op_mode *op_mode,
+			       struct iwl_fw_error_dump_mode *mode)
+{
+	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
+
+	/* if we come in from opmode we have the mutex held */
+	if (mode->context == IWL_ERR_CONTEXT_FROM_OPMODE) {
+		lockdep_assert_wiphy(mld->wiphy);
+		iwl_fw_error_collect(&mld->fwrt);
+	} else {
+		wiphy_lock(mld->wiphy);
+		if (mode->context != IWL_ERR_CONTEXT_ABORT)
+			iwl_fw_error_collect(&mld->fwrt);
+		wiphy_unlock(mld->wiphy);
+	}
+}
+
+static bool iwl_mld_sw_reset(struct iwl_op_mode *op_mode,
+			     enum iwl_fw_error_type type)
+{
+	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
+
+	/* Do restart only in the following conditions are met:
+	 * - we consider the FW as running
+	 * - The trigger that brought us here is defined as one that requires
+	 *   a restart (in the debug TLVs)
+	 */
+	if (!mld->fw_status.running || !mld->fwrt.trans->dbg.restart_required)
+		return false;
+
+	iwl_mld_restart_nic(mld);
+	return true;
+}
+
+static void
+iwl_mld_time_point(struct iwl_op_mode *op_mode,
+		   enum iwl_fw_ini_time_point tp_id,
+		   union iwl_dbg_tlv_tp_data *tp_data)
+{
+	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
+
+	iwl_dbg_tlv_time_point(&mld->fwrt, tp_id, tp_data);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static void iwl_mld_device_powered_off(struct iwl_op_mode *op_mode)
+{
+	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
+
+	wiphy_lock(mld->wiphy);
+	mld->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
+	iwl_mld_stop_fw(mld);
+	mld->fw_status.in_d3 = false;
+	wiphy_unlock(mld->wiphy);
+}
+#else
+static void iwl_mld_device_powered_off(struct iwl_op_mode *op_mode)
+{}
+#endif
+
+static const struct iwl_op_mode_ops iwl_mld_ops = {
+	.start = iwl_op_mode_mld_start,
+	.stop = iwl_op_mode_mld_stop,
+	.rx = iwl_mld_rx,
+	.rx_rss = iwl_mld_rx_rss,
+	.queue_full = iwl_mld_queue_full,
+	.queue_not_full = iwl_mld_queue_not_full,
+	.hw_rf_kill = iwl_mld_set_hw_rfkill_state,
+	.free_skb = iwl_mld_free_skb,
+	.nic_error = iwl_mld_nic_error,
+	.dump_error = iwl_mld_dump_error,
+	.sw_reset = iwl_mld_sw_reset,
+	.time_point = iwl_mld_time_point,
+	.device_powered_off = pm_sleep_ptr(iwl_mld_device_powered_off),
+};
+
+struct iwl_mld_mod_params iwlmld_mod_params = {
+	.power_scheme = IWL_POWER_SCHEME_BPS,
+};
+
+module_param_named(power_scheme, iwlmld_mod_params.power_scheme, int, 0444);
+MODULE_PARM_DESC(power_scheme,
+		 "power management scheme: 1-active, 2-balanced, default: 2");
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
new file mode 100644
index 000000000000..9467eecb2a49
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -0,0 +1,586 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+#ifndef __iwl_mld_h__
+#define __iwl_mld_h__
+
+#include <linux/leds.h>
+#include <net/mac80211.h>
+
+#include <net/mac80211.h>
+
+#include "iwl-trans.h"
+#include "iwl-op-mode.h"
+#include "fw/runtime.h"
+#include "fw/notif-wait.h"
+#include "fw/api/commands.h"
+#include "fw/api/scan.h"
+#include "fw/api/mac-cfg.h"
+#include "fw/api/mac.h"
+#include "fw/api/phy-ctxt.h"
+#include "fw/api/datapath.h"
+#include "fw/api/rx.h"
+#include "fw/api/rs.h"
+#include "fw/api/context.h"
+#include "fw/api/coex.h"
+#include "fw/api/location.h"
+
+#include "fw/dbg.h"
+
+#include "notif.h"
+#include "scan.h"
+#include "rx.h"
+#include "thermal.h"
+#include "low_latency.h"
+#include "constants.h"
+#include "ptp.h"
+#include "time_sync.h"
+
+/**
+ * DOC: Introduction
+ *
+ * iwlmld is an operation mode (a.k.a. op_mode) for Intel wireless devices.
+ * It is used for devices that ship after 2024 which typically support
+ * the WiFi-7 features. MLD stands for multi-link device. Note that there are
+ * devices that do not support WiFi-7 or even WiFi 6E and yet use iwlmld, but
+ * the firmware APIs used in this driver are WiFi-7 compatible.
+ *
+ * In the architecture of iwlwifi, an op_mode is a layer that translates
+ * mac80211's APIs into commands for the firmware and, of course, notifications
+ * from the firmware to mac80211's APIs. An op_mode must implement the
+ * interface defined in iwl-op-mode.h to interact with the transport layer
+ * which allows to send and receive data to the device, start the hardware,
+ * etc...
+ */
+
+/**
+ * DOC: Locking policy
+ *
+ * iwlmld has a very simple locking policy: it doesn't have any mutexes. It
+ * relies on cfg80211's wiphy->mtx and takes the lock when needed. All the
+ * control flows originating from mac80211 already acquired the lock, so that
+ * part is trivial, but also notifications that are received from the firmware
+ * and handled asynchronously are handled only after having taken the lock.
+ * This is described in notif.c.
+ * There are spin_locks needed to synchronize with the data path, around the
+ * allocation of the queues, for example.
+ */
+
+/**
+ * DOC: Debugfs
+ *
+ * iwlmld adds its share of debugfs hooks and its handlers are synchronized
+ * with the wiphy_lock using wiphy_locked_debugfs. This avoids races against
+ * resources deletion while the debugfs hook is being used.
+ */
+
+/**
+ * DOC: Main resources
+ *
+ * iwlmld is designed with the life cycle of the resource in mind. The
+ * resources are:
+ *
+ *  - struct iwl_mld (matches mac80211's struct ieee80211_hw)
+ *
+ *  - struct iwl_mld_vif (matches macu80211's struct ieee80211_vif)
+ *    iwl_mld_vif contains an array of pointers to struct iwl_mld_link
+ *    which describe the links for this vif.
+ *
+ *  - struct iwl_mld_sta (matches mac80211's struct ieee80211_sta)
+ *    iwl_mld_sta contains an array of points to struct iwl_mld_link_sta
+ *    which describes the link stations for this station
+ *
+ * Each object has properties that can survive a firmware reset or not.
+ * Asynchronous firmware notifications can declare themselves as dependent on a
+ * certain instance of those resources and that means that the notifications
+ * will be cancelled once the instance is destroyed.
+ */
+
+#define IWL_MLD_MAX_ADDRESSES		5
+
+/**
+ * struct iwl_mld - MLD op mode
+ *
+ * @fw_id_to_bss_conf: maps a fw id of a link to the corresponding
+ *	ieee80211_bss_conf.
+ * @fw_id_to_vif: maps a fw id of a MAC context to the corresponding
+ *	ieee80211_vif. Mapping is valid only when the MAC exists in the fw.
+ * @fw_id_to_txq: maps a fw id of a txq to the corresponding
+ *	ieee80211_txq.
+ * @used_phy_ids: a bitmap of the phy IDs used. If a bit is set, it means
+ *	that the index of this bit is already used as a PHY id.
+ * @num_igtks: the number if iGTKs that were sent to the FW.
+ * @monitor: monitor related data
+ * @monitor.on: does a monitor vif exist (singleton hence bool)
+ * @monitor.ampdu_ref: the id of the A-MPDU for sniffer
+ * @monitor.ampdu_toggle: the state of the previous packet to track A-MPDU
+ * @monitor.cur_aid: current association id tracked by the sniffer
+ * @monitor.cur_bssid: current bssid tracked by the sniffer
+ * @monitor.p80: primary channel position relative to he whole bandwidth, in
+ * steps of 80 MHz
+ * @fw_id_to_link_sta: maps a fw id of a sta to the corresponding
+ *	ieee80211_link_sta. This is not cleaned up on restart since we want to
+ *	preserve the fw sta ids during a restart (for SN/PN restoring).
+ *	FW ids of internal stations will be mapped to ERR_PTR, and will be
+ *	re-allocated during a restart, so make sure to free it in restart
+ *	cleanup using iwl_mld_free_internal_sta
+ * @netdetect: indicates the FW is in suspend mode with netdetect configured
+ * @p2p_device_vif: points to the p2p device vif if exists
+ * @bt_is_active: indicates that BT is active
+ * @dev: pointer to device struct. For printing purposes
+ * @trans: pointer to the transport layer
+ * @cfg: pointer to the device configuration
+ * @fw: a pointer to the fw object
+ * @hw: pointer to the hw object.
+ * @wiphy: a pointer to the wiphy struct, for easier access to it.
+ * @nvm_data: pointer to the nvm_data that includes all our capabilities
+ * @fwrt: fw runtime data
+ * @debugfs_dir: debugfs directory
+ * @notif_wait: notification wait related data.
+ * @async_handlers_list: a list of all async RX handlers. When a notifciation
+ *	with an async handler is received, it is added to this list.
+ *	When &async_handlers_wk runs - it runs these handlers one by one.
+ * @async_handlers_lock: a lock for &async_handlers_list. Sync
+ *	&async_handlers_wk and RX notifcation path.
+ * @async_handlers_wk: A work to run all async RX handlers from
+ *	&async_handlers_list.
+ * @ct_kill_exit_wk: worker to exit thermal kill
+ * @fw_status: bitmap of fw status bits
+ * @running: true if the firmware is running
+ * @do_not_dump_once: true if firmware dump must be prevented once
+ * @in_d3: indicates FW is in suspend mode and should be resumed
+ * @in_hw_restart: indicates that we are currently in restart flow.
+ *	rather than restarted. Should be unset upon restart.
+ * @radio_kill: bitmap of radio kill status
+ * @radio_kill.hw: radio is killed by hw switch
+ * @radio_kill.ct: radio is killed because the device it too hot
+ * @addresses: device MAC addresses.
+ * @scan: instance of the scan object
+ * @wowlan: WoWLAN support data.
+ * @led: the led device
+ * @mcc_src: the source id of the MCC, comes from the firmware
+ * @bios_enable_puncturing: is puncturing enabled by bios
+ * @fw_id_to_ba: maps a fw (BA) id to a corresponding Block Ack session data.
+ * @num_rx_ba_sessions: tracks the number of active Rx Block Ack (BA) sessions.
+ *	the driver ensures that new BA sessions are blocked once the maximum
+ *	supported by the firmware is reached, preventing firmware asserts.
+ * @rxq_sync: manages RX queue sync state
+ * @txqs_to_add: a list of &ieee80211_txq's to allocate in &add_txqs_wk
+ * @add_txqs_wk: a worker to allocate txqs.
+ * @add_txqs_lock: to lock the &txqs_to_add list.
+ * @error_recovery_buf: pointer to the recovery buffer that will be read
+ *	from firmware upon fw/hw error and sent back to the firmware in
+ *	reconfig flow (after NIC reset).
+ * @mcast_filter_cmd: pointer to the multicast filter command.
+ * @mgmt_tx_ant: stores the last TX antenna index; used for setting
+ *	TX rate_n_flags for non-STA mgmt frames (toggles on every TX failure).
+ * @low_latency: low-latency manager.
+ * @tzone: thermal zone device's data
+ * @cooling_dev: cooling device's related data
+ * @ibss_manager: in IBSS mode (only one vif can be active), indicates what
+ *	firmware indicated about having transmitted the last beacon, i.e.
+ *	being IBSS manager for that time and needing to respond to probe
+ *	requests
+ * @ptp_data: data of the PTP clock
+ * @time_sync: time sync data.
+ * @ftm_initiator: FTM initiator data
+ */
+struct iwl_mld {
+	/* Add here fields that need clean up on restart */
+	struct_group(zeroed_on_hw_restart,
+		struct ieee80211_bss_conf __rcu *fw_id_to_bss_conf[IWL_FW_MAX_LINK_ID + 1];
+		struct ieee80211_vif __rcu *fw_id_to_vif[NUM_MAC_INDEX_DRIVER];
+		struct ieee80211_txq __rcu *fw_id_to_txq[IWL_MAX_TVQM_QUEUES];
+		u8 used_phy_ids: NUM_PHY_CTX;
+		u8 num_igtks;
+		struct {
+			bool on;
+			u32 ampdu_ref;
+			bool ampdu_toggle;
+			u8 p80;
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+			__le16 cur_aid;
+			u8 cur_bssid[ETH_ALEN];
+#endif
+		} monitor;
+#ifdef CONFIG_PM_SLEEP
+		bool netdetect;
+#endif /* CONFIG_PM_SLEEP */
+		struct ieee80211_vif *p2p_device_vif;
+		bool bt_is_active;
+	);
+	struct ieee80211_link_sta __rcu *fw_id_to_link_sta[IWL_STATION_COUNT_MAX];
+	/* And here fields that survive a fw restart */
+	struct device *dev;
+	struct iwl_trans *trans;
+	const struct iwl_cfg *cfg;
+	const struct iwl_fw *fw;
+	struct ieee80211_hw *hw;
+	struct wiphy *wiphy;
+	struct iwl_nvm_data *nvm_data;
+	struct iwl_fw_runtime fwrt;
+	struct dentry *debugfs_dir;
+	struct iwl_notif_wait_data notif_wait;
+	struct list_head async_handlers_list;
+	spinlock_t async_handlers_lock;
+	struct wiphy_work async_handlers_wk;
+	struct wiphy_delayed_work ct_kill_exit_wk;
+
+	struct {
+		u32 running:1,
+		    do_not_dump_once:1,
+#ifdef CONFIG_PM_SLEEP
+		    in_d3:1,
+#endif
+		    in_hw_restart:1;
+
+	} fw_status;
+
+	struct {
+		u32 hw:1,
+		    ct:1;
+	} radio_kill;
+
+	struct mac_address addresses[IWL_MLD_MAX_ADDRESSES];
+	struct iwl_mld_scan scan;
+#ifdef CONFIG_PM_SLEEP
+	struct wiphy_wowlan_support wowlan;
+#endif /* CONFIG_PM_SLEEP */
+#ifdef CONFIG_IWLWIFI_LEDS
+	struct led_classdev led;
+#endif
+	enum iwl_mcc_source mcc_src;
+	bool bios_enable_puncturing;
+
+	struct iwl_mld_baid_data __rcu *fw_id_to_ba[IWL_MAX_BAID];
+	u8 num_rx_ba_sessions;
+
+	struct iwl_mld_rx_queues_sync rxq_sync;
+
+	struct list_head txqs_to_add;
+	struct wiphy_work add_txqs_wk;
+	spinlock_t add_txqs_lock;
+
+	u8 *error_recovery_buf;
+	struct iwl_mcast_filter_cmd *mcast_filter_cmd;
+
+	u8 mgmt_tx_ant;
+
+	struct iwl_mld_low_latency low_latency;
+
+	bool ibss_manager;
+#ifdef CONFIG_THERMAL
+	struct thermal_zone_device *tzone;
+	struct iwl_mld_cooling_device cooling_dev;
+#endif
+
+	struct ptp_data ptp_data;
+
+	struct iwl_mld_time_sync_data __rcu *time_sync;
+
+	struct {
+		struct cfg80211_pmsr_request *req;
+		struct wireless_dev *req_wdev;
+		int responses[IWL_TOF_MAX_APS];
+	} ftm_initiator;
+};
+
+/* memset the part of the struct that requires cleanup on restart */
+#define CLEANUP_STRUCT(_ptr)                             \
+	memset((void *)&(_ptr)->zeroed_on_hw_restart, 0, \
+	       sizeof((_ptr)->zeroed_on_hw_restart))
+
+/* Cleanup function for struct iwl_mld_vif, will be called in restart */
+static inline void
+iwl_cleanup_mld(struct iwl_mld *mld)
+{
+	CLEANUP_STRUCT(mld);
+	CLEANUP_STRUCT(&mld->scan);
+
+	mld->fw_status.in_d3 = false;
+
+	iwl_mld_low_latency_restart_cleanup(mld);
+
+	/* Empty the list of async notification handlers so we won't process
+	 * notifications from the dead fw after the reconfig flow.
+	 */
+	iwl_mld_purge_async_handlers_list(mld);
+}
+
+enum iwl_power_scheme {
+	IWL_POWER_SCHEME_CAM = 1,
+	IWL_POWER_SCHEME_BPS,
+};
+
+/**
+ * struct iwl_mld_mod_params - module parameters for iwlmld
+ * @power_scheme: one of enum iwl_power_scheme
+ */
+struct iwl_mld_mod_params {
+	int power_scheme;
+};
+
+extern struct iwl_mld_mod_params iwlmld_mod_params;
+
+/* Extract MLD priv from op_mode */
+#define IWL_OP_MODE_GET_MLD(_iwl_op_mode)		\
+	((struct iwl_mld *)(_iwl_op_mode)->op_mode_specific)
+
+#define IWL_MAC80211_GET_MLD(_hw)			\
+	IWL_OP_MODE_GET_MLD((struct iwl_op_mode *)((_hw)->priv))
+
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+void
+iwl_mld_add_debugfs_files(struct iwl_mld *mld, struct dentry *debugfs_dir);
+#else
+static inline void
+iwl_mld_add_debugfs_files(struct iwl_mld *mld, struct dentry *debugfs_dir)
+{}
+#endif
+
+int iwl_mld_run_fw_init_sequence(struct iwl_mld *mld);
+int iwl_mld_load_fw(struct iwl_mld *mld);
+void iwl_mld_stop_fw(struct iwl_mld *mld);
+int iwl_mld_start_fw(struct iwl_mld *mld);
+void iwl_mld_send_recovery_cmd(struct iwl_mld *mld, u32 flags);
+
+static inline void iwl_mld_set_ctkill(struct iwl_mld *mld, bool state)
+{
+	mld->radio_kill.ct = state;
+
+	wiphy_rfkill_set_hw_state(mld->wiphy,
+				  mld->radio_kill.hw || mld->radio_kill.ct);
+}
+
+static inline void iwl_mld_set_hwkill(struct iwl_mld *mld, bool state)
+{
+	mld->radio_kill.hw = state;
+
+	wiphy_rfkill_set_hw_state(mld->wiphy,
+				  mld->radio_kill.hw || mld->radio_kill.ct);
+}
+
+static inline u8 iwl_mld_get_valid_tx_ant(const struct iwl_mld *mld)
+{
+	u8 tx_ant = mld->fw->valid_tx_ant;
+
+	if (mld->nvm_data && mld->nvm_data->valid_tx_ant)
+		tx_ant &= mld->nvm_data->valid_tx_ant;
+
+	return tx_ant;
+}
+
+static inline u8 iwl_mld_get_valid_rx_ant(const struct iwl_mld *mld)
+{
+	u8 rx_ant = mld->fw->valid_rx_ant;
+
+	if (mld->nvm_data && mld->nvm_data->valid_rx_ant)
+		rx_ant &= mld->nvm_data->valid_rx_ant;
+
+	return rx_ant;
+}
+
+static inline u8 iwl_mld_nl80211_band_to_fw(enum nl80211_band band)
+{
+	switch (band) {
+	case NL80211_BAND_2GHZ:
+		return PHY_BAND_24;
+	case NL80211_BAND_5GHZ:
+		return PHY_BAND_5;
+	case NL80211_BAND_6GHZ:
+		return PHY_BAND_6;
+	default:
+		WARN_ONCE(1, "Unsupported band (%u)\n", band);
+		return PHY_BAND_5;
+	}
+}
+
+static inline u8 iwl_mld_phy_band_to_nl80211(u8 phy_band)
+{
+	switch (phy_band) {
+	case PHY_BAND_24:
+		return NL80211_BAND_2GHZ;
+	case PHY_BAND_5:
+		return NL80211_BAND_5GHZ;
+	case PHY_BAND_6:
+		return NL80211_BAND_6GHZ;
+	default:
+		WARN_ONCE(1, "Unsupported phy band (%u)\n", phy_band);
+		return NL80211_BAND_5GHZ;
+	}
+}
+
+static inline int
+iwl_mld_legacy_hw_idx_to_mac80211_idx(u32 rate_n_flags,
+				      enum nl80211_band band)
+{
+	int format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
+	int rate = rate_n_flags & RATE_LEGACY_RATE_MSK;
+	bool is_lb = band == NL80211_BAND_2GHZ;
+
+	if (format == RATE_MCS_LEGACY_OFDM_MSK)
+		return is_lb ? rate + IWL_FIRST_OFDM_RATE : rate;
+
+	/* CCK is not allowed in 5 GHz */
+	return is_lb ? rate : -1;
+}
+
+extern const struct ieee80211_ops iwl_mld_hw_ops;
+
+/**
+ * enum iwl_rx_handler_context: context for Rx handler
+ * @RX_HANDLER_SYNC: this means that it will be called in the Rx path
+ *	which can't acquire the wiphy->mutex.
+ * @RX_HANDLER_ASYNC: If the handler needs to hold wiphy->mutex
+ *	(and only in this case!), it should be set as ASYNC. In that case,
+ *	it will be called from a worker with wiphy->mutex held.
+ */
+enum iwl_rx_handler_context {
+	RX_HANDLER_SYNC,
+	RX_HANDLER_ASYNC,
+};
+
+/**
+ * struct iwl_rx_handler: handler for FW notification
+ * @val_fn: input validation function.
+ * @sizes: an array that mapps a version to the expected size.
+ * @fn: the function is called when notification is handled
+ * @cmd_id: command id
+ * @n_sizes: number of elements in &sizes.
+ * @context: see &iwl_rx_handler_context
+ * @obj_type: the type of the object that this handler is related to.
+ *	See &iwl_mld_object_type. Use IWL_MLD_OBJECT_TYPE_NONE if not related.
+ * @cancel: function to cancel the notification. valid only if obj_type is not
+ *	IWL_MLD_OBJECT_TYPE_NONE.
+ */
+struct iwl_rx_handler {
+	union {
+		bool (*val_fn)(struct iwl_mld *mld, struct iwl_rx_packet *pkt);
+		const struct iwl_notif_struct_size *sizes;
+	};
+	void (*fn)(struct iwl_mld *mld, struct iwl_rx_packet *pkt);
+	u16 cmd_id;
+	u8 n_sizes;
+	u8 context;
+	enum iwl_mld_object_type obj_type;
+	bool (*cancel)(struct iwl_mld *mld, struct iwl_rx_packet *pkt,
+		       u32 obj_id);
+};
+
+/**
+ * struct iwl_notif_struct_size: map a notif ver to the expected size
+ *
+ * @size: the size to expect
+ * @ver: the version of the notification
+ */
+struct iwl_notif_struct_size {
+	u32 size:24, ver:8;
+};
+
+#if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
+extern const struct iwl_hcmd_arr iwl_mld_groups[];
+extern const unsigned int global_iwl_mld_goups_size;
+extern const struct iwl_rx_handler iwl_mld_rx_handlers[];
+extern const unsigned int iwl_mld_rx_handlers_num;
+
+bool
+iwl_mld_is_dup(struct iwl_mld *mld, struct ieee80211_sta *sta,
+	       struct ieee80211_hdr *hdr,
+	       const struct iwl_rx_mpdu_desc *mpdu_desc,
+	       struct ieee80211_rx_status *rx_status, int queue);
+
+void iwl_construct_mld(struct iwl_mld *mld, struct iwl_trans *trans,
+		       const struct iwl_cfg *cfg, const struct iwl_fw *fw,
+		       struct ieee80211_hw *hw, struct dentry *dbgfs_dir);
+#endif
+
+#define IWL_MLD_INVALID_FW_ID 0xff
+
+#define IWL_MLD_ALLOC_FN(_type, _mac80211_type)						\
+static int										\
+iwl_mld_allocate_##_type##_fw_id(struct iwl_mld *mld,					\
+				 u8 *fw_id,				\
+				 struct ieee80211_##_mac80211_type *mac80211_ptr)	\
+{											\
+	u8 rand = IWL_MLD_DIS_RANDOM_FW_ID ? 0 : get_random_u8();			\
+	u8 arr_sz = ARRAY_SIZE(mld->fw_id_to_##_mac80211_type);				\
+	if (__builtin_types_compatible_p(typeof(*mac80211_ptr),				\
+					 struct ieee80211_link_sta))			\
+		arr_sz = mld->fw->ucode_capa.num_stations;				\
+	if (__builtin_types_compatible_p(typeof(*mac80211_ptr),				\
+					 struct ieee80211_bss_conf))			\
+		arr_sz = mld->fw->ucode_capa.num_links;					\
+	for (int i = 0; i < arr_sz; i++) {						\
+		u8 idx = (i + rand) % arr_sz;						\
+		if (rcu_access_pointer(mld->fw_id_to_##_mac80211_type[idx]))		\
+			continue;							\
+		IWL_DEBUG_INFO(mld, "Allocated at index %d / %d\n", idx, arr_sz);	\
+		*fw_id = idx;								\
+		rcu_assign_pointer(mld->fw_id_to_##_mac80211_type[idx], mac80211_ptr);	\
+		return 0;								\
+	}										\
+	return -ENOSPC;									\
+}
+
+static inline struct ieee80211_bss_conf *
+iwl_mld_fw_id_to_link_conf(struct iwl_mld *mld, u8 fw_link_id)
+{
+	if (IWL_FW_CHECK(mld, fw_link_id >= mld->fw->ucode_capa.num_links,
+			 "Invalid fw_link_id: %d\n", fw_link_id))
+		return NULL;
+
+	return wiphy_dereference(mld->wiphy,
+				 mld->fw_id_to_bss_conf[fw_link_id]);
+}
+
+#define MSEC_TO_TU(_msec)	((_msec) * 1000 / 1024)
+
+void iwl_mld_add_vif_debugfs(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif);
+void iwl_mld_add_link_debugfs(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link_conf,
+			      struct dentry *dir);
+void iwl_mld_add_link_sta_debugfs(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_link_sta *link_sta,
+				  struct dentry *dir);
+
+/* Utilities */
+
+static inline u8 iwl_mld_mac80211_ac_to_fw_tx_fifo(enum ieee80211_ac_numbers ac)
+{
+	static const u8 mac80211_ac_to_fw_tx_fifo[] = {
+		IWL_BZ_EDCA_TX_FIFO_VO,
+		IWL_BZ_EDCA_TX_FIFO_VI,
+		IWL_BZ_EDCA_TX_FIFO_BE,
+		IWL_BZ_EDCA_TX_FIFO_BK,
+		IWL_BZ_TRIG_TX_FIFO_VO,
+		IWL_BZ_TRIG_TX_FIFO_VI,
+		IWL_BZ_TRIG_TX_FIFO_BE,
+		IWL_BZ_TRIG_TX_FIFO_BK,
+	};
+	return mac80211_ac_to_fw_tx_fifo[ac];
+}
+
+static inline u32
+iwl_mld_get_lmac_id(struct iwl_mld *mld, enum nl80211_band band)
+{
+	if (!fw_has_capa(&mld->fw->ucode_capa,
+			 IWL_UCODE_TLV_CAPA_CDB_SUPPORT) ||
+	    band == NL80211_BAND_2GHZ)
+		return IWL_LMAC_24G_INDEX;
+	return IWL_LMAC_5G_INDEX;
+}
+
+/* Check if we had an error, but reconfig flow didn't start yet */
+static inline bool iwl_mld_error_before_recovery(struct iwl_mld *mld)
+{
+	return mld->fw_status.in_hw_restart &&
+		!iwl_trans_fw_running(mld->trans);
+}
+
+int iwl_mld_tdls_sta_count(struct iwl_mld *mld);
+
+#endif /* __iwl_mld_h__ */
-- 
2.34.1


