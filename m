Return-Path: <linux-wireless+bounces-22386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC228AA85EF
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0891F178A83
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 10:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628391A4E70;
	Sun,  4 May 2025 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PMFJLZlG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497E1A23AD
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354412; cv=none; b=uoYj6exHCIaFgQjjcQIZmshroSx43J9Tzt2jxJSUQNUpZxPizu6hEIxke4V1AuWjs8etHQEkwY5UuzyvmaoefJY7UC8y5WS5UqsI2TvLfuMyuj1PduKDHArtkYF0RibbrQsMUhuGe7/bAHlMCCKnJzBgyiJOlJLcfWt8zVPdMjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354412; c=relaxed/simple;
	bh=rIgwwjJpXA3KZciTPMQHjnmo5EtN8+D9kz4k29HxumY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lqvXAX5gkrF3iec+61QGo709P1hcIeH3tt4aepNE4zdh0Vr8Unjiyruujs0zVmrLubytfVB9wOQdisoeEwbYYFLFHn3xVKWgqWqQDY73qAgr2M/YXBwpKm3Ja9DAt1CpWPWHKcyXvNfaHMgk8bVnlMyCJ2ippZO0QbLd/mze098=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PMFJLZlG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746354409; x=1777890409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rIgwwjJpXA3KZciTPMQHjnmo5EtN8+D9kz4k29HxumY=;
  b=PMFJLZlG3sjZOn2yOE5nr+cLRoSMNKS7MTJYUyPGxrz8zmEghPBQJis6
   z20/uYm5P3FgKydgtoGesK3E0oTFd14/LqdKJ3SdE7JzhhCghGNi+0nF2
   11zDeQjjol+7QE21HJHxUP9leFBRwGTHRcMzalT9rkpXc0L0Q79SqBkOz
   bMqZd44KJZE3DM/DYkNQQdlBqwYmXSyTAMPvzb8ZZgOk9hSf20NzSMfkN
   0UO02uUa3L2mlgPerzUpY1j+4x4j2kHgzSmHdB7gN9mNeKv8XBXgw9+yY
   KCOWf5P7FYi3JqlwSEjaOQm2mKEh0s1nxljgmSQLDMu0lWfmxR4WeaXDY
   w==;
X-CSE-ConnectionGUID: wC7CDGI6ToKAciBiUISgJw==
X-CSE-MsgGUID: gZ4hXMvcR8WnCEb3X5k8/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="65511477"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="65511477"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:26:48 -0700
X-CSE-ConnectionGUID: 79Aq/grdRlKoOWQJgtnSWw==
X-CSE-MsgGUID: 7AWWjElwSO6aLyJKiE91ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="139778856"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:26:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: rework transport configuration
Date: Sun,  4 May 2025 13:26:16 +0300
Message-Id: <20250504132447.e2a2535ecfd0.I21653103ff02afc5a4d97a41b68021f053985e37@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
References: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Instead of having a trans_configure method that copies all
the data, just have the users set up the configuration in
the transport directly. This simplifies the code on both
sides. While doing so also move some value from the trans
struct into the conf struct because they are configuration.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c | 42 ++++++-------
 .../net/wireless/intel/iwlwifi/iwl-devtrace.h |  9 +--
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 28 +++++----
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 36 +++++------
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  | 43 +++++++------
 .../wireless/intel/iwlwifi/mld/tests/hcmd.c   |  6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 45 +++++++-------
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  5 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  4 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    | 30 +--------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 13 ++--
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 43 +++----------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 22 +++----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 62 +++++++++----------
 15 files changed, 169 insertions(+), 223 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index f26f8202a7a3..1d811b60162b 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1233,7 +1233,6 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	struct iwl_op_mode *op_mode;
 	u16 num_mac;
 	u32 ucode_flags;
-	struct iwl_trans_config trans_cfg = {};
 	static const u8 no_reclaim_cmds[] = {
 		REPLY_RX_PHY_CMD,
 		REPLY_RX_MPDU_CMD,
@@ -1310,31 +1309,32 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	 * Populate the state variables that the transport layer needs
 	 * to know about.
 	 */
-	trans_cfg.op_mode = op_mode;
-	trans_cfg.no_reclaim_cmds = no_reclaim_cmds;
-	trans_cfg.n_no_reclaim_cmds = ARRAY_SIZE(no_reclaim_cmds);
+	BUILD_BUG_ON(sizeof(no_reclaim_cmds) >
+		     sizeof(trans->conf.no_reclaim_cmds));
+	memcpy(trans->conf.no_reclaim_cmds, no_reclaim_cmds,
+	       sizeof(no_reclaim_cmds));
 
 	switch (iwlwifi_mod_params.amsdu_size) {
 	case IWL_AMSDU_DEF:
 	case IWL_AMSDU_4K:
-		trans_cfg.rx_buf_size = IWL_AMSDU_4K;
+		trans->conf.rx_buf_size = IWL_AMSDU_4K;
 		break;
 	case IWL_AMSDU_8K:
-		trans_cfg.rx_buf_size = IWL_AMSDU_8K;
+		trans->conf.rx_buf_size = IWL_AMSDU_8K;
 		break;
 	case IWL_AMSDU_12K:
 	default:
-		trans_cfg.rx_buf_size = IWL_AMSDU_4K;
+		trans->conf.rx_buf_size = IWL_AMSDU_4K;
 		pr_err("Unsupported amsdu_size: %d\n",
 		       iwlwifi_mod_params.amsdu_size);
 	}
 
-	trans_cfg.command_groups = iwl_dvm_groups;
-	trans_cfg.command_groups_size = ARRAY_SIZE(iwl_dvm_groups);
+	trans->conf.command_groups = iwl_dvm_groups;
+	trans->conf.command_groups_size = ARRAY_SIZE(iwl_dvm_groups);
 
-	trans_cfg.cmd_fifo = IWLAGN_CMD_FIFO_NUM;
-	trans_cfg.cb_data_offs = offsetof(struct ieee80211_tx_info,
-					  driver_data[2]);
+	trans->conf.cmd_fifo = IWLAGN_CMD_FIFO_NUM;
+	trans->conf.cb_data_offs = offsetof(struct ieee80211_tx_info,
+					    driver_data[2]);
 
 	WARN_ON(sizeof(priv->transport_queue_stop) * BITS_PER_BYTE <
 		priv->trans->trans_cfg->base_params->num_of_queues);
@@ -1343,19 +1343,16 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 
 	if (ucode_flags & IWL_UCODE_TLV_FLAGS_PAN) {
 		priv->sta_key_max_num = STA_KEY_MAX_NUM_PAN;
-		trans_cfg.cmd_queue = IWL_IPAN_CMD_QUEUE_NUM;
+		trans->conf.cmd_queue = IWL_IPAN_CMD_QUEUE_NUM;
 	} else {
 		priv->sta_key_max_num = STA_KEY_MAX_NUM;
-		trans_cfg.cmd_queue = IWL_DEFAULT_CMD_QUEUE_NUM;
+		trans->conf.cmd_queue = IWL_DEFAULT_CMD_QUEUE_NUM;
 	}
 
-	/* Configure transport layer */
-	iwl_trans_configure(priv->trans, &trans_cfg);
+	trans->conf.rx_mpdu_cmd = REPLY_RX_MPDU_CMD;
+	trans->conf.rx_mpdu_cmd_hdr_size = sizeof(struct iwl_rx_mpdu_res_start);
 
-	trans->rx_mpdu_cmd = REPLY_RX_MPDU_CMD;
-	trans->rx_mpdu_cmd_hdr_size = sizeof(struct iwl_rx_mpdu_res_start);
-	trans->command_groups = trans_cfg.command_groups;
-	trans->command_groups_size = trans_cfg.command_groups_size;
+	iwl_trans_op_mode_enter(priv->trans, op_mode);
 
 	/* At this point both hw and priv are allocated. */
 
@@ -1438,10 +1435,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 		 * packaging bug or due to the eeprom check above
 		 */
 		priv->sta_key_max_num = STA_KEY_MAX_NUM;
-		trans_cfg.cmd_queue = IWL_DEFAULT_CMD_QUEUE_NUM;
-
-		/* Configure transport layer again*/
-		iwl_trans_configure(priv->trans, &trans_cfg);
+		trans->conf.cmd_queue = IWL_DEFAULT_CMD_QUEUE_NUM;
 	}
 
 	/*******************
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h
index 76166e1b10e5..99789c7cef3b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h
@@ -3,7 +3,7 @@
  *
  * Copyright(c) 2009 - 2014 Intel Corporation. All rights reserved.
  * Copyright(C) 2016        Intel Deutschland GmbH
- * Copyright(c) 2018, 2023  Intel Corporation
+ * Copyright(c) 2018, 2023, 2025 Intel Corporation
  *****************************************************************************/
 
 #ifndef __IWLWIFI_DEVICE_TRACE
@@ -54,11 +54,11 @@ static inline size_t iwl_rx_trace_len(const struct iwl_trans *trans,
 	struct ieee80211_hdr *hdr = NULL;
 	size_t hdr_offset;
 
-	if (cmd->cmd != trans->rx_mpdu_cmd)
+	if (cmd->cmd != trans->conf.rx_mpdu_cmd)
 		return len;
 
 	hdr_offset = sizeof(struct iwl_cmd_header) +
-		     trans->rx_mpdu_cmd_hdr_size;
+		     trans->conf.rx_mpdu_cmd_hdr_size;
 
 	if (out_hdr_offset)
 		*out_hdr_offset = hdr_offset;
@@ -67,7 +67,8 @@ static inline size_t iwl_rx_trace_len(const struct iwl_trans *trans,
 	if (!ieee80211_is_data(hdr->frame_control))
 		return len;
 	/* maybe try to identify EAPOL frames? */
-	return sizeof(__le32) + sizeof(*cmd) + trans->rx_mpdu_cmd_hdr_size +
+	return sizeof(__le32) + sizeof(*cmd) +
+		trans->conf.rx_mpdu_cmd_hdr_size +
 		ieee80211_hdrlen(hdr->frame_control);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 7f05444c32ad..879436ac3c03 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -358,7 +358,7 @@ int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
 	if (!(cmd->flags & CMD_ASYNC))
 		lock_map_acquire_read(&trans->sync_cmd_lockdep_map);
 
-	if (trans->wide_cmd_header && !iwl_cmd_groupid(cmd->id)) {
+	if (trans->conf.wide_cmd_header && !iwl_cmd_groupid(cmd->id)) {
 		if (cmd->id != REPLY_ERROR)
 			cmd->id = DEF_ID(cmd->id);
 	}
@@ -402,11 +402,12 @@ const char *iwl_get_cmd_string(struct iwl_trans *trans, u32 id)
 	grp = iwl_cmd_groupid(id);
 	cmd = iwl_cmd_opcode(id);
 
-	if (!trans->command_groups || grp >= trans->command_groups_size ||
-	    !trans->command_groups[grp].arr)
+	if (!trans->conf.command_groups ||
+	    grp >= trans->conf.command_groups_size ||
+	    !trans->conf.command_groups[grp].arr)
 		return "UNKNOWN";
 
-	arr = &trans->command_groups[grp];
+	arr = &trans->conf.command_groups[grp];
 	ret = bsearch(&cmd, arr->arr, arr->size, size, iwl_hcmd_names_cmp);
 	if (!ret)
 		return "UNKNOWN";
@@ -414,14 +415,20 @@ const char *iwl_get_cmd_string(struct iwl_trans *trans, u32 id)
 }
 IWL_EXPORT_SYMBOL(iwl_get_cmd_string);
 
-void iwl_trans_configure(struct iwl_trans *trans,
-			 const struct iwl_trans_config *trans_cfg)
+void iwl_trans_op_mode_enter(struct iwl_trans *trans,
+			     struct iwl_op_mode *op_mode)
 {
-	trans->op_mode = trans_cfg->op_mode;
+	trans->op_mode = op_mode;
 
-	iwl_trans_pcie_configure(trans, trans_cfg);
+	if (WARN_ON(trans->conf.n_no_reclaim_cmds > MAX_NO_RECLAIM_CMDS))
+		trans->conf.n_no_reclaim_cmds =
+			ARRAY_SIZE(trans->conf.no_reclaim_cmds);
+
+	WARN_ON_ONCE(!trans->conf.rx_mpdu_cmd);
+
+	iwl_trans_pcie_op_mode_enter(trans);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_configure);
+IWL_EXPORT_SYMBOL(iwl_trans_op_mode_enter);
 
 int iwl_trans_start_hw(struct iwl_trans *trans)
 {
@@ -444,6 +451,7 @@ void iwl_trans_op_mode_leave(struct iwl_trans *trans)
 	cancel_delayed_work_sync(&trans->restart.wk);
 
 	trans->op_mode = NULL;
+	memset(&trans->conf, 0, sizeof(trans->conf));
 
 	trans->state = IWL_TRANS_NO_FW;
 }
@@ -616,8 +624,6 @@ int iwl_trans_start_fw(struct iwl_trans *trans, const struct iwl_fw *fw,
 
 	might_sleep();
 
-	WARN_ON_ONCE(!trans->rx_mpdu_cmd);
-
 	img = iwl_get_ucode_image(fw, ucode_type);
 	if (!img)
 		return -EINVAL;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 43894aa72673..3faf07dfd5e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -390,7 +390,8 @@ struct iwl_dump_sanitize_ops {
 /**
  * struct iwl_trans_config - transport configuration
  *
- * @op_mode: pointer to the upper layer.
+ * These values should be set before iwl_trans_op_mode_enter().
+ *
  * @cmd_queue: the index of the command queue.
  *	Must be set before start_fw.
  * @cmd_fifo: the fifo for host commands
@@ -411,14 +412,17 @@ struct iwl_dump_sanitize_ops {
  * @queue_alloc_cmd_ver: queue allocation command version, set to 0
  *	for using the older SCD_QUEUE_CFG, set to the version of
  *	SCD_QUEUE_CONFIG_CMD otherwise.
+ * @wide_cmd_header: true when ucode supports wide command header format
+ * @rx_mpdu_cmd: MPDU RX command ID, must be assigned by opmode before
+ *	starting the firmware, used for tracing
+ * @rx_mpdu_cmd_hdr_size: used for tracing, amount of data before the
+ *	start of the 802.11 header in the @rx_mpdu_cmd
  */
 struct iwl_trans_config {
-	struct iwl_op_mode *op_mode;
-
 	u8 cmd_queue;
 	u8 cmd_fifo;
-	const u8 *no_reclaim_cmds;
-	unsigned int n_no_reclaim_cmds;
+	u8 n_no_reclaim_cmds;
+	u8 no_reclaim_cmds[MAX_NO_RECLAIM_CMDS];
 
 	enum iwl_amsdu_size rx_buf_size;
 	bool scd_set_active;
@@ -428,6 +432,9 @@ struct iwl_trans_config {
 	u8 cb_data_offs;
 	bool fw_reset_handshake;
 	u8 queue_alloc_cmd_ver;
+
+	bool wide_cmd_header;
+	u8 rx_mpdu_cmd, rx_mpdu_cmd_hdr_size;
 };
 
 struct iwl_trans_dump_data {
@@ -839,6 +846,7 @@ struct iwl_trans_info {
  * @trans_cfg: the trans-specific configuration part
  * @cfg: pointer to the configuration
  * @drv: pointer to iwl_drv
+ * @conf: configuration set by the opmode before enter
  * @state: current device state
  * @status: a bit-mask of transport status flags
  * @dev: pointer to struct device * that represents the device
@@ -850,18 +858,11 @@ struct iwl_trans_info {
  * @fail_to_parse_pnvm_image: set to true if pnvm parsing failed
  * @reduce_power_loaded: indicates reduced power section was loaded
  * @failed_to_load_reduce_power_image: set to true if pnvm loading failed
- * @command_groups: pointer to command group name list array
- * @command_groups_size: array size of @command_groups
- * @wide_cmd_header: true when ucode supports wide command header format
  * @dev_cmd_pool: pool for Tx cmd allocation - for internal use only.
  *	The user should use iwl_trans_{alloc,free}_tx_cmd.
  * @dev_cmd_pool_name: name for the TX command allocation pool
  * @dbgfs_dir: iwlwifi debugfs base dir for this device
  * @sync_cmd_lockdep_map: lockdep map for checking sync commands
- * @rx_mpdu_cmd: MPDU RX command ID, must be assigned by opmode before
- *	starting the firmware, used for tracing
- * @rx_mpdu_cmd_hdr_size: used for tracing, amount of data before the
- *	start of the 802.11 header in the @rx_mpdu_cmd
  * @dbg: additional debug data, see &struct iwl_trans_debug
  * @init_dram: FW initialization DMA data
  * @mbx_addr_0_step: step address data 0
@@ -887,6 +888,7 @@ struct iwl_trans {
 	const struct iwl_cfg_trans_params *trans_cfg;
 	const struct iwl_cfg *cfg;
 	struct iwl_drv *drv;
+	struct iwl_trans_config conf;
 	enum iwl_trans_state state;
 	unsigned long status;
 
@@ -902,8 +904,6 @@ struct iwl_trans {
 
 	bool ext_32khz_clock_valid;
 
-	u8 rx_mpdu_cmd, rx_mpdu_cmd_hdr_size;
-
 	bool pm_support;
 	bool ltr_enabled;
 	u8 pnvm_loaded:1;
@@ -911,10 +911,6 @@ struct iwl_trans {
 	u8 reduce_power_loaded:1;
 	u8 failed_to_load_reduce_power_image:1;
 
-	const struct iwl_hcmd_arr *command_groups;
-	int command_groups_size;
-	bool wide_cmd_header;
-
 	/* The following fields are internal only */
 	struct kmem_cache *dev_cmd_pool;
 	char dev_cmd_pool_name[50];
@@ -947,8 +943,8 @@ struct iwl_trans {
 
 const char *iwl_get_cmd_string(struct iwl_trans *trans, u32 id);
 
-void iwl_trans_configure(struct iwl_trans *trans,
-			 const struct iwl_trans_config *trans_cfg);
+void iwl_trans_op_mode_enter(struct iwl_trans *trans,
+			     struct iwl_op_mode *op_mode);
 
 int iwl_trans_start_hw(struct iwl_trans *trans);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 8fb33b4459d7..da1079639b2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -327,30 +327,29 @@ iwl_mld_configure_trans(struct iwl_op_mode *op_mode)
 {
 	const struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
 	static const u8 no_reclaim_cmds[] = {TX_CMD};
-	struct iwl_trans_config trans_cfg = {
-		.op_mode = op_mode,
-		/* Rx is not supported yet, but add it to avoid warnings */
-		.rx_buf_size = iwl_amsdu_size_to_rxb_size(),
-		.command_groups = iwl_mld_groups,
-		.command_groups_size = ARRAY_SIZE(iwl_mld_groups),
-		.fw_reset_handshake = true,
-		.queue_alloc_cmd_ver =
-			iwl_fw_lookup_cmd_ver(mld->fw,
-					      WIDE_ID(DATA_PATH_GROUP,
-						      SCD_QUEUE_CONFIG_CMD),
-					      0),
-		.no_reclaim_cmds = no_reclaim_cmds,
-		.n_no_reclaim_cmds = ARRAY_SIZE(no_reclaim_cmds),
-		.cb_data_offs = offsetof(struct ieee80211_tx_info,
-					 driver_data[2]),
-	};
 	struct iwl_trans *trans = mld->trans;
 
-	trans->rx_mpdu_cmd = REPLY_RX_MPDU_CMD;
-	trans->rx_mpdu_cmd_hdr_size = sizeof(struct iwl_rx_mpdu_res_start);
-	trans->wide_cmd_header = true;
-
-	iwl_trans_configure(trans, &trans_cfg);
+	trans->conf.rx_buf_size = iwl_amsdu_size_to_rxb_size();
+	trans->conf.command_groups = iwl_mld_groups;
+	trans->conf.command_groups_size = ARRAY_SIZE(iwl_mld_groups);
+	trans->conf.fw_reset_handshake = true;
+	trans->conf.queue_alloc_cmd_ver =
+		iwl_fw_lookup_cmd_ver(mld->fw, WIDE_ID(DATA_PATH_GROUP,
+						       SCD_QUEUE_CONFIG_CMD),
+				      0);
+	trans->conf.cb_data_offs = offsetof(struct ieee80211_tx_info,
+					    driver_data[2]);
+	BUILD_BUG_ON(sizeof(no_reclaim_cmds) >
+		     sizeof(trans->conf.no_reclaim_cmds));
+	memcpy(trans->conf.no_reclaim_cmds, no_reclaim_cmds,
+	       sizeof(no_reclaim_cmds));
+	trans->conf.n_no_reclaim_cmds = ARRAY_SIZE(no_reclaim_cmds);
+
+	trans->conf.rx_mpdu_cmd = REPLY_RX_MPDU_CMD;
+	trans->conf.rx_mpdu_cmd_hdr_size = sizeof(struct iwl_rx_mpdu_res_start);
+	trans->conf.wide_cmd_header = true;
+
+	iwl_trans_op_mode_enter(trans, op_mode);
 }
 
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/hcmd.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/hcmd.c
index 4e189bf8b3fb..0e3b9417dd63 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/hcmd.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/hcmd.c
@@ -2,7 +2,7 @@
 /*
  * KUnit tests for channel helper functions
  *
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024-2025 Intel Corporation
  */
 #include <kunit/test.h>
 
@@ -30,10 +30,10 @@ static void test_hcmd_names_sorted(struct kunit *test)
 static void test_hcmd_names_for_rx(struct kunit *test)
 {
 	static struct iwl_trans t = {
-		.command_groups = iwl_mld_groups,
+		.conf.command_groups = iwl_mld_groups,
 	};
 
-	t.command_groups_size = global_iwl_mld_goups_size;
+	t.conf.command_groups_size = global_iwl_mld_goups_size;
 
 	for (unsigned int i = 0; i < iwl_mld_rx_handlers_num; i++) {
 		const struct iwl_rx_handler *rxh;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 74732602acb2..7701fbc5f906 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1284,7 +1284,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	struct ieee80211_hw *hw;
 	struct iwl_op_mode *op_mode;
 	struct iwl_mvm *mvm;
-	struct iwl_trans_config trans_cfg = {};
 	static const u8 no_reclaim_cmds[] = {
 		TX_CMD,
 	};
@@ -1338,16 +1337,18 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	mvm->init_status = 0;
 
+	trans->conf.rx_mpdu_cmd = REPLY_RX_MPDU_CMD;
+
 	if (iwl_mvm_has_new_rx_api(mvm)) {
 		op_mode->ops = &iwl_mvm_ops_mq;
-		trans->rx_mpdu_cmd_hdr_size =
+		trans->conf.rx_mpdu_cmd_hdr_size =
 			(trans->trans_cfg->device_family >=
 			 IWL_DEVICE_FAMILY_AX210) ?
 			sizeof(struct iwl_rx_mpdu_desc) :
 			IWL_RX_DESC_SIZE_V1;
 	} else {
 		op_mode->ops = &iwl_mvm_ops;
-		trans->rx_mpdu_cmd_hdr_size =
+		trans->conf.rx_mpdu_cmd_hdr_size =
 			sizeof(struct iwl_rx_mpdu_res_start);
 
 		if (WARN_ON(trans->info.num_rxqs > 1)) {
@@ -1438,45 +1439,47 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	 * Populate the state variables that the transport layer needs
 	 * to know about.
 	 */
-	trans_cfg.op_mode = op_mode;
-	trans_cfg.no_reclaim_cmds = no_reclaim_cmds;
-	trans_cfg.n_no_reclaim_cmds = ARRAY_SIZE(no_reclaim_cmds);
+	BUILD_BUG_ON(sizeof(no_reclaim_cmds) >
+		     sizeof(trans->conf.no_reclaim_cmds));
+	memcpy(trans->conf.no_reclaim_cmds, no_reclaim_cmds,
+	       sizeof(no_reclaim_cmds));
+	trans->conf.n_no_reclaim_cmds = ARRAY_SIZE(no_reclaim_cmds);
 
-	trans_cfg.rx_buf_size = iwl_amsdu_size_to_rxb_size();
+	trans->conf.rx_buf_size = iwl_amsdu_size_to_rxb_size();
 
-	trans->wide_cmd_header = true;
+	trans->conf.wide_cmd_header = true;
 
-	trans_cfg.command_groups = iwl_mvm_groups;
-	trans_cfg.command_groups_size = ARRAY_SIZE(iwl_mvm_groups);
+	trans->conf.command_groups = iwl_mvm_groups;
+	trans->conf.command_groups_size = ARRAY_SIZE(iwl_mvm_groups);
 
-	trans_cfg.cmd_queue = IWL_MVM_DQA_CMD_QUEUE;
-	trans_cfg.cmd_fifo = IWL_MVM_TX_FIFO_CMD;
-	trans_cfg.scd_set_active = true;
+	trans->conf.cmd_queue = IWL_MVM_DQA_CMD_QUEUE;
+	trans->conf.cmd_fifo = IWL_MVM_TX_FIFO_CMD;
+	trans->conf.scd_set_active = true;
 
-	trans_cfg.cb_data_offs = offsetof(struct ieee80211_tx_info,
-					  driver_data[2]);
+	trans->conf.cb_data_offs = offsetof(struct ieee80211_tx_info,
+					    driver_data[2]);
 
 	snprintf(mvm->hw->wiphy->fw_version,
 		 sizeof(mvm->hw->wiphy->fw_version),
 		 "%.31s", fw->fw_version);
 
-	trans_cfg.fw_reset_handshake = fw_has_capa(&mvm->fw->ucode_capa,
-						   IWL_UCODE_TLV_CAPA_FW_RESET_HANDSHAKE);
+	trans->conf.fw_reset_handshake =
+		fw_has_capa(&mvm->fw->ucode_capa,
+			    IWL_UCODE_TLV_CAPA_FW_RESET_HANDSHAKE);
 
-	trans_cfg.queue_alloc_cmd_ver =
+	trans->conf.queue_alloc_cmd_ver =
 		iwl_fw_lookup_cmd_ver(mvm->fw,
 				      WIDE_ID(DATA_PATH_GROUP,
 					      SCD_QUEUE_CONFIG_CMD),
 				      0);
 	mvm->sta_remove_requires_queue_remove =
-		trans_cfg.queue_alloc_cmd_ver > 0;
+		trans->conf.queue_alloc_cmd_ver > 0;
 
 	mvm->mld_api_is_used = iwl_mvm_has_mld_api(mvm->fw);
 
 	/* Configure transport layer */
-	iwl_trans_configure(mvm->trans, &trans_cfg);
+	iwl_trans_op_mode_enter(mvm->trans, op_mode);
 
-	trans->rx_mpdu_cmd = REPLY_RX_MPDU_CMD;
 	trans->dbg.dest_tlv = mvm->fw->dbg.dest_tlv;
 	trans->dbg.n_dest_reg = mvm->fw->dbg.n_dest_reg;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index b3a04af7faad..195f3ea9d381 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -112,7 +112,7 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 	int cmdq_size = max_t(u32, IWL_CMD_QUEUE_SIZE,
 			      trans->cfg->min_txq_size);
 
-	switch (trans_pcie->rx_buf_size) {
+	switch (trans->conf.rx_buf_size) {
 	case IWL_AMSDU_DEF:
 		return -EINVAL;
 	case IWL_AMSDU_2K:
@@ -192,7 +192,6 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 	if (ret)
 		goto err_free_prph_scratch;
 
-
 	/* Allocate prph information
 	 * currently we don't assign to the prph info anything, but it would get
 	 * assigned later
@@ -249,7 +248,7 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 	ctxt_info_gen3->cr_tail_idx_arr_base_addr =
 		cpu_to_le64(trans_pcie->prph_info_dma_addr + 3 * PAGE_SIZE / 4);
 	ctxt_info_gen3->mtr_base_addr =
-		cpu_to_le64(trans_pcie->txqs.txq[trans_pcie->txqs.cmd.q_id]->dma_addr);
+		cpu_to_le64(trans_pcie->txqs.txq[trans->conf.cmd_queue]->dma_addr);
 	ctxt_info_gen3->mcr_base_addr =
 		cpu_to_le64(trans_pcie->rxq->used_bd_dma);
 	ctxt_info_gen3->mtr_size =
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index 4fd3855e6a34..cc3e3d91b27f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -184,7 +184,7 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 	/* size is in DWs */
 	ctxt_info->version.size = cpu_to_le16(sizeof(*ctxt_info) / 4);
 
-	switch (trans_pcie->rx_buf_size) {
+	switch (trans->conf.rx_buf_size) {
 	case IWL_AMSDU_2K:
 		rb_size = IWL_CTXT_INFO_RB_SIZE_2K;
 		break;
@@ -218,7 +218,7 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 
 	/* initialize TX command queue */
 	ctxt_info->hcmd_cfg.cmd_queue_addr =
-		cpu_to_le64(trans_pcie->txqs.txq[trans_pcie->txqs.cmd.q_id]->dma_addr);
+		cpu_to_le64(trans_pcie->txqs.txq[trans->conf.cmd_queue]->dma_addr);
 	ctxt_info->hcmd_cfg.cmd_queue_size =
 		TFD_QUEUE_CB_SIZE(IWL_CMD_QUEUE_SIZE);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index f532a5d6576e..d580e2ad7520 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -289,20 +289,14 @@ enum iwl_pcie_imr_status {
 /**
  * struct iwl_pcie_txqs - TX queues data
  *
- * @page_offs: offset from skb->cb to mac header page pointer
- * @dev_cmd_offs: offset from skb->cb to iwl_device_tx_cmd pointer
  * @queue_used: bit mask of used queues
  * @queue_stopped: bit mask of stopped queues
  * @txq: array of TXQ data structures representing the TXQs
  * @scd_bc_tbls: gen1 pointer to the byte count table of the scheduler
- * @queue_alloc_cmd_ver: queue allocation command version
  * @bc_pool: bytecount DMA allocations pool
  * @bc_tbl_size: bytecount table size
  * @tso_hdr_page: page allocated (per CPU) for A-MSDU headers when doing TSO
  *	(and similar usage)
- * @cmd: command queue data
- * @cmd.fifo: FIFO number
- * @cmd.q_id: queue ID
  * @tfd: TFD data
  * @tfd.max_tbs: max number of buffers per TFD
  * @tfd.size: TFD size
@@ -314,15 +308,8 @@ struct iwl_pcie_txqs {
 	struct iwl_txq *txq[IWL_MAX_TVQM_QUEUES];
 	struct dma_pool *bc_pool;
 	size_t bc_tbl_size;
-	u8 page_offs;
-	u8 dev_cmd_offs;
 	struct iwl_tso_hdr_page __percpu *tso_hdr_page;
 
-	struct {
-		u8 fifo;
-		u8 q_id;
-	} cmd;
-
 	struct {
 		u8 max_tbs;
 		u16 size;
@@ -330,8 +317,6 @@ struct iwl_pcie_txqs {
 	} tfd;
 
 	struct iwl_dma_ptr scd_bc_tbls;
-
-	u8 queue_alloc_cmd_ver;
 };
 
 /**
@@ -361,9 +346,6 @@ struct iwl_pcie_txqs {
  * @hw_base: pci hardware address support
  * @ucode_write_complete: indicates that the ucode has been copied.
  * @ucode_write_waitq: wait queue for uCode load
- * @cmd_queue - command queue number
- * @rx_buf_size: Rx buffer size
- * @scd_set_active: should the transport configure the SCD for HCMD queue
  * @rx_page_order: page order for receive buffer size
  * @rx_buf_bytes: RX buffer (RB) size in bytes
  * @reg_lock: protect hw register access
@@ -404,13 +386,9 @@ struct iwl_pcie_txqs {
  * @pcie_dbg_dumped_once: indicates PCIe regs were dumped already
  * @opmode_down: indicates opmode went away
  * @num_rx_bufs: number of RX buffers to allocate/use
- * @no_reclaim_cmds: special commands not using reclaim flow
- *	(firmware workaround)
- * @n_no_reclaim_cmds: number of special commands not using reclaim flow
  * @affinity_mask: IRQ affinity mask for each RX queue
  * @debug_rfkill: RF-kill debugging state, -1 for unset, 0/1 for radio
  *	enable/disable
- * @fw_reset_handshake: indicates FW reset handshake is needed
  * @fw_reset_state: state of FW reset handshake
  * @fw_reset_waitq: waitqueue for FW reset handshake
  * @is_down: indicates the NIC is down
@@ -474,12 +452,8 @@ struct iwl_trans_pcie {
 	wait_queue_head_t ucode_write_waitq;
 	wait_queue_head_t sx_waitq;
 
-	u8 n_no_reclaim_cmds;
-	u8 no_reclaim_cmds[MAX_NO_RECLAIM_CMDS];
 	u16 num_rx_bufs;
 
-	enum iwl_amsdu_size rx_buf_size;
-	bool scd_set_active;
 	bool pcie_dbg_dumped_once;
 	u32 rx_page_order;
 	u32 rx_buf_bytes;
@@ -514,7 +488,6 @@ struct iwl_trans_pcie {
 	void *base_rb_stts;
 	dma_addr_t base_rb_stts_dma;
 
-	bool fw_reset_handshake;
 	enum iwl_pcie_fw_reset_state fw_reset_state;
 	wait_queue_head_t fw_reset_waitq;
 	enum iwl_pcie_imr_status imr_status;
@@ -1100,8 +1073,7 @@ static inline void iwl_trans_pcie_dbgfs_register(struct iwl_trans *trans) { }
 void iwl_pcie_rx_allocator_work(struct work_struct *data);
 
 /* common trans ops for all generations transports */
-void iwl_trans_pcie_configure(struct iwl_trans *trans,
-			      const struct iwl_trans_config *trans_cfg);
+void iwl_trans_pcie_op_mode_enter(struct iwl_trans *trans);
 int iwl_trans_pcie_start_hw(struct iwl_trans *trans);
 void iwl_trans_pcie_op_mode_leave(struct iwl_trans *trans);
 void iwl_trans_pcie_write8(struct iwl_trans *trans, u32 ofs, u8 val);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index cb8c8973cb18..712b8ded9f4b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -363,8 +363,8 @@ static struct page *iwl_pcie_rx_alloc_page(struct iwl_trans *trans,
 					   u32 *offset, gfp_t priority)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	unsigned int rbsize = iwl_trans_get_rb_size(trans_pcie->rx_buf_size);
 	unsigned int allocsize = PAGE_SIZE << trans_pcie->rx_page_order;
+	unsigned int rbsize = trans_pcie->rx_buf_bytes;
 	struct page *page;
 	gfp_t gfp_mask = priority;
 
@@ -835,11 +835,10 @@ static int iwl_pcie_rx_alloc(struct iwl_trans *trans)
 
 static void iwl_pcie_rx_hw_init(struct iwl_trans *trans, struct iwl_rxq *rxq)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	u32 rb_size;
 	const u32 rfdnlog = RX_QUEUE_SIZE_LOG; /* 256 RBDs */
 
-	switch (trans_pcie->rx_buf_size) {
+	switch (trans->conf.rx_buf_size) {
 	case IWL_AMSDU_4K:
 		rb_size = FH_RCSR_RX_CONFIG_REG_VAL_RB_SIZE_4K;
 		break;
@@ -907,7 +906,7 @@ static void iwl_pcie_rx_mq_hw_init(struct iwl_trans *trans)
 	u32 rb_size, enabled = 0;
 	int i;
 
-	switch (trans_pcie->rx_buf_size) {
+	switch (trans->conf.rx_buf_size) {
 	case IWL_AMSDU_2K:
 		rb_size = RFH_RXF_DMA_RB_SIZE_2K;
 		break;
@@ -1302,7 +1301,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 				int i)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txqs.txq[trans_pcie->txqs.cmd.q_id];
+	struct iwl_txq *txq = trans_pcie->txqs.txq[trans->conf.cmd_queue];
 	bool page_stolen = false;
 	int max_len = trans_pcie->rx_buf_bytes;
 	u32 offset = 0;
@@ -1369,8 +1368,8 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 		if (reclaim && !pkt->hdr.group_id) {
 			int i;
 
-			for (i = 0; i < trans_pcie->n_no_reclaim_cmds; i++) {
-				if (trans_pcie->no_reclaim_cmds[i] ==
+			for (i = 0; i < trans->conf.n_no_reclaim_cmds; i++) {
+				if (trans->conf.no_reclaim_cmds[i] ==
 							pkt->hdr.cmd) {
 					reclaim = false;
 					break;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index f9a9fece9b6d..a47a5922ff24 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -157,7 +157,7 @@ static void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 		return;
 
 	if (trans->state >= IWL_TRANS_FW_STARTED &&
-	    trans_pcie->fw_reset_handshake) {
+	    trans->conf.fw_reset_handshake) {
 		/*
 		 * Reset handshake can dump firmware on timeout, but that
 		 * should assume that the firmware is already dead.
@@ -270,7 +270,7 @@ static int iwl_pcie_gen2_nic_init(struct iwl_trans *trans)
 		return -ENOMEM;
 
 	/* Allocate or reset and init all Tx and Command queues */
-	if (iwl_txq_gen2_init(trans, trans_pcie->txqs.cmd.q_id, queue_size))
+	if (iwl_txq_gen2_init(trans, trans->conf.cmd_queue, queue_size))
 		return -ENOMEM;
 
 	/* enable shadow regs in HW */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 1f99f5dd00af..3259a42c3a7f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1966,44 +1966,17 @@ void iwl_trans_pcie_write_prph(struct iwl_trans *trans, u32 addr, u32 val)
 	iwl_trans_pcie_write32(trans, HBUS_TARG_PRPH_WDAT, val);
 }
 
-void iwl_trans_pcie_configure(struct iwl_trans *trans,
-			      const struct iwl_trans_config *trans_cfg)
+void iwl_trans_pcie_op_mode_enter(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
 	/* free all first - we might be reconfigured for a different size */
 	iwl_pcie_free_rbs_pool(trans);
 
-	trans_pcie->txqs.cmd.q_id = trans_cfg->cmd_queue;
-	trans_pcie->txqs.cmd.fifo = trans_cfg->cmd_fifo;
-	trans_pcie->txqs.page_offs = trans_cfg->cb_data_offs;
-	trans_pcie->txqs.dev_cmd_offs = trans_cfg->cb_data_offs + sizeof(void *);
-	trans_pcie->txqs.queue_alloc_cmd_ver = trans_cfg->queue_alloc_cmd_ver;
-
-	if (WARN_ON(trans_cfg->n_no_reclaim_cmds > MAX_NO_RECLAIM_CMDS))
-		trans_pcie->n_no_reclaim_cmds = 0;
-	else
-		trans_pcie->n_no_reclaim_cmds = trans_cfg->n_no_reclaim_cmds;
-	if (trans_pcie->n_no_reclaim_cmds)
-		memcpy(trans_pcie->no_reclaim_cmds, trans_cfg->no_reclaim_cmds,
-		       trans_pcie->n_no_reclaim_cmds * sizeof(u8));
-
-	trans_pcie->rx_buf_size = trans_cfg->rx_buf_size;
 	trans_pcie->rx_page_order =
-		iwl_trans_get_rb_size_order(trans_pcie->rx_buf_size);
+		iwl_trans_get_rb_size_order(trans->conf.rx_buf_size);
 	trans_pcie->rx_buf_bytes =
-		iwl_trans_get_rb_size(trans_pcie->rx_buf_size);
-	trans_pcie->supported_dma_mask = DMA_BIT_MASK(12);
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
-		trans_pcie->supported_dma_mask = DMA_BIT_MASK(11);
-
-	trans_pcie->scd_set_active = trans_cfg->scd_set_active;
-
-	trans->command_groups = trans_cfg->command_groups;
-	trans->command_groups_size = trans_cfg->command_groups_size;
-
-
-	trans_pcie->fw_reset_handshake = trans_cfg->fw_reset_handshake;
+		iwl_trans_get_rb_size(trans->conf.rx_buf_size);
 }
 
 void iwl_trans_pcie_free_pnvm_dram_regions(struct iwl_dram_regions *dram_regions,
@@ -2703,7 +2676,7 @@ int iwl_trans_pcie_wait_txqs_empty(struct iwl_trans *trans, u32 txq_bm)
 	     cnt < trans->trans_cfg->base_params->num_of_queues;
 	     cnt++) {
 
-		if (cnt == trans_pcie->txqs.cmd.q_id)
+		if (cnt == trans->conf.cmd_queue)
 			continue;
 		if (!test_bit(cnt, trans_pcie->txqs.queue_used))
 			continue;
@@ -2894,7 +2867,7 @@ static int iwl_dbgfs_tx_queue_seq_show(struct seq_file *seq, void *v)
 	else
 		seq_puts(seq, "(unallocated)");
 
-	if (state->pos == trans_pcie->txqs.cmd.q_id)
+	if (state->pos == trans->conf.cmd_queue)
 		seq_puts(seq, " (HCMD)");
 	seq_puts(seq, "\n");
 
@@ -3633,7 +3606,7 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_fw_error_dump_data *data;
-	struct iwl_txq *cmdq = trans_pcie->txqs.txq[trans_pcie->txqs.cmd.q_id];
+	struct iwl_txq *cmdq = trans_pcie->txqs.txq[trans->conf.cmd_queue];
 	struct iwl_fw_error_dump_txcmd *txcmd;
 	struct iwl_trans_dump_data *dump_data;
 	u32 len, num_rbs = 0, monitor_len = 0;
@@ -3848,6 +3821,10 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		trans_pcie->txqs.tfd.size = sizeof(struct iwl_tfd);
 	}
 
+	trans_pcie->supported_dma_mask = (u32)DMA_BIT_MASK(12);
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		trans_pcie->supported_dma_mask = (u32)DMA_BIT_MASK(11);
+
 	info->max_skb_frags = IWL_TRANS_PCIE_MAX_FRAGS(trans_pcie);
 
 	trans_pcie->txqs.tso_hdr_page = alloc_percpu(struct iwl_tso_hdr_page);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 665c359e8479..b567ff3f9052 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -18,13 +18,12 @@
 static struct page *get_workaround_page(struct iwl_trans *trans,
 					struct sk_buff *skb)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_tso_page_info *info;
 	struct page **page_ptr;
 	struct page *ret;
 	dma_addr_t phys;
 
-	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->txqs.page_offs);
+	page_ptr = (void *)((u8 *)skb->cb + trans->conf.cb_data_offs);
 
 	ret = alloc_page(GFP_ATOMIC);
 	if (!ret)
@@ -751,7 +750,8 @@ int iwl_txq_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 			struct iwl_device_tx_cmd **dev_cmd_ptr;
 
 			dev_cmd_ptr = (void *)((u8 *)skb->cb +
-					       trans_pcie->txqs.dev_cmd_offs);
+					       trans->conf.cb_data_offs +
+					       sizeof(void *));
 
 			*dev_cmd_ptr = dev_cmd;
 			__skb_queue_tail(&txq->overflow_q, skb);
@@ -827,7 +827,7 @@ static void iwl_txq_gen2_unmap(struct iwl_trans *trans, int txq_id)
 		IWL_DEBUG_TX_REPLY(trans, "Q %d Free %d\n",
 				   txq_id, txq->read_ptr);
 
-		if (txq_id != trans_pcie->txqs.cmd.q_id) {
+		if (txq_id != trans->conf.cmd_queue) {
 			int idx = iwl_txq_get_cmd_index(txq, txq->read_ptr);
 			struct iwl_cmd_meta *cmd_meta = &txq->entries[idx].meta;
 			struct sk_buff *skb = txq->entries[idx].skb;
@@ -901,7 +901,7 @@ static void iwl_txq_gen2_free(struct iwl_trans *trans, int txq_id)
 	iwl_txq_gen2_unmap(trans, txq_id);
 
 	/* De-alloc array of command/tx buffers */
-	if (txq_id == trans_pcie->txqs.cmd.q_id)
+	if (txq_id == trans->conf.cmd_queue)
 		for (i = 0; i < txq->n_window; i++) {
 			kfree_sensitive(txq->entries[i].cmd);
 			kfree_sensitive(txq->entries[i].free_buf);
@@ -1059,7 +1059,7 @@ int iwl_txq_dyn_alloc(struct iwl_trans *trans, u32 flags, u32 sta_mask,
 	if (IS_ERR(txq))
 		return PTR_ERR(txq);
 
-	if (trans_pcie->txqs.queue_alloc_cmd_ver == 0) {
+	if (trans->conf.queue_alloc_cmd_ver == 0) {
 		memset(&cmd.old, 0, sizeof(cmd.old));
 		cmd.old.tfdq_addr = cpu_to_le64(txq->dma_addr);
 		cmd.old.byte_cnt_addr = cpu_to_le64(txq->bc_tbl.dma);
@@ -1076,7 +1076,7 @@ int iwl_txq_dyn_alloc(struct iwl_trans *trans, u32 flags, u32 sta_mask,
 		hcmd.id = SCD_QUEUE_CFG;
 		hcmd.len[0] = sizeof(cmd.old);
 		hcmd.data[0] = &cmd.old;
-	} else if (trans_pcie->txqs.queue_alloc_cmd_ver == 3) {
+	} else if (trans->conf.queue_alloc_cmd_ver == 3) {
 		memset(&cmd.new, 0, sizeof(cmd.new));
 		cmd.new.operation = cpu_to_le32(IWL_SCD_QUEUE_ADD);
 		cmd.new.u.add.tfdq_dram_addr = cpu_to_le64(txq->dma_addr);
@@ -1171,7 +1171,7 @@ int iwl_txq_gen2_init(struct iwl_trans *trans, int txq_id, int queue_size)
 	}
 
 	ret = iwl_txq_init(trans, queue, queue_size,
-			   (txq_id == trans_pcie->txqs.cmd.q_id));
+			   (txq_id == trans->conf.cmd_queue));
 	if (ret) {
 		IWL_ERR(trans, "Tx %d queue alloc failed\n", txq_id);
 		goto error;
@@ -1201,7 +1201,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 			       struct iwl_host_cmd *cmd)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txqs.txq[trans_pcie->txqs.cmd.q_id];
+	struct iwl_txq *txq = trans_pcie->txqs.txq[trans->conf.cmd_queue];
 	struct iwl_device_cmd *out_cmd;
 	struct iwl_cmd_meta *out_meta;
 	void *dup_buf = NULL;
@@ -1318,7 +1318,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 		cpu_to_le16(cmd_size - sizeof(struct iwl_cmd_header_wide));
 	out_cmd->hdr_wide.reserved = 0;
 	out_cmd->hdr_wide.sequence =
-		cpu_to_le16(QUEUE_TO_SEQ(trans_pcie->txqs.cmd.q_id) |
+		cpu_to_le16(QUEUE_TO_SEQ(trans->conf.cmd_queue) |
 					 INDEX_TO_SEQ(txq->write_ptr));
 
 	cmd_pos = sizeof(struct iwl_cmd_header_wide);
@@ -1366,7 +1366,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 		     "Sending command %s (%.2x.%.2x), seq: 0x%04X, %d bytes at %d[%d]:%d\n",
 		     iwl_get_cmd_string(trans, cmd->id), group_id,
 		     out_cmd->hdr.cmd, le16_to_cpu(out_cmd->hdr.sequence),
-		     cmd_size, txq->write_ptr, idx, trans_pcie->txqs.cmd.q_id);
+		     cmd_size, txq->write_ptr, idx, trans->conf.cmd_queue);
 
 	/* start the TFD with the minimum copy bytes */
 	tb0_size = min_t(int, copy_size, IWL_FIRST_TB_SIZE);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index fcddf32196e1..632d147f7921 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -78,7 +78,6 @@ void iwl_pcie_free_dma_ptr(struct iwl_trans *trans, struct iwl_dma_ptr *ptr)
 static void iwl_pcie_txq_inc_wr_ptr(struct iwl_trans *trans,
 				    struct iwl_txq *txq)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	u32 reg = 0;
 	int txq_id = txq->id;
 
@@ -91,7 +90,7 @@ static void iwl_pcie_txq_inc_wr_ptr(struct iwl_trans *trans,
 	 * 3. there is a chance that the NIC is asleep
 	 */
 	if (!trans->trans_cfg->base_params->shadow_reg_enable &&
-	    txq_id != trans_pcie->txqs.cmd.q_id &&
+	    txq_id != trans->conf.cmd_queue &&
 	    test_bit(STATUS_TPOWER_PMI, &trans->status)) {
 		/*
 		 * wake up nic if it's powered down ...
@@ -226,11 +225,10 @@ static void iwl_pcie_free_and_unmap_tso_page(struct iwl_trans *trans,
 void iwl_pcie_free_tso_pages(struct iwl_trans *trans, struct sk_buff *skb,
 			     struct iwl_cmd_meta *cmd_meta)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct page **page_ptr;
 	struct page *next;
 
-	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->txqs.page_offs);
+	page_ptr = (void *)((u8 *)skb->cb + trans->conf.cb_data_offs);
 	next = *page_ptr;
 	*page_ptr = NULL;
 
@@ -396,7 +394,7 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 		IWL_DEBUG_TX_REPLY(trans, "Q %d Free %d\n",
 				   txq_id, txq->read_ptr);
 
-		if (txq_id != trans_pcie->txqs.cmd.q_id) {
+		if (txq_id != trans->conf.cmd_queue) {
 			struct sk_buff *skb = txq->entries[txq->read_ptr].skb;
 			struct iwl_cmd_meta *cmd_meta =
 				&txq->entries[txq->read_ptr].meta;
@@ -410,7 +408,7 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 		txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr);
 
 		if (txq->read_ptr == txq->write_ptr &&
-		    txq_id == trans_pcie->txqs.cmd.q_id)
+		    txq_id == trans->conf.cmd_queue)
 			iwl_pcie_clear_cmd_in_flight(trans);
 	}
 
@@ -448,7 +446,7 @@ static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 	iwl_pcie_txq_unmap(trans, txq_id);
 
 	/* De-alloc array of command/tx buffers */
-	if (txq_id == trans_pcie->txqs.cmd.q_id)
+	if (txq_id == trans->conf.cmd_queue)
 		for (i = 0; i < txq->n_window; i++) {
 			kfree_sensitive(txq->entries[i].cmd);
 			kfree_sensitive(txq->entries[i].free_buf);
@@ -509,8 +507,8 @@ void iwl_pcie_tx_start(struct iwl_trans *trans)
 	if (trans->trans_cfg->base_params->scd_chain_ext_wa)
 		iwl_write_prph(trans, SCD_CHAINEXT_EN, 0);
 
-	iwl_trans_ac_txq_enable(trans, trans_pcie->txqs.cmd.q_id,
-				trans_pcie->txqs.cmd.fifo,
+	iwl_trans_ac_txq_enable(trans, trans->conf.cmd_queue,
+				trans->conf.cmd_fifo,
 				IWL_DEF_WD_TIMEOUT);
 
 	/* Activate all Tx DMA/FIFO channels */
@@ -847,7 +845,7 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	/* Alloc and init all Tx queues, including the command queue (#4/#9) */
 	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
 	     txq_id++) {
-		bool cmd_queue = (txq_id == trans_pcie->txqs.cmd.q_id);
+		bool cmd_queue = (txq_id == trans->conf.cmd_queue);
 
 		if (cmd_queue)
 			slots_num = max_t(u32, IWL_CMD_QUEUE_SIZE,
@@ -964,7 +962,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 	/* Alloc and init all Tx queues, including the command queue (#4/#9) */
 	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
 	     txq_id++) {
-		bool cmd_queue = (txq_id == trans_pcie->txqs.cmd.q_id);
+		bool cmd_queue = (txq_id == trans->conf.cmd_queue);
 
 		if (cmd_queue)
 			slots_num = max_t(u32, IWL_CMD_QUEUE_SIZE,
@@ -1163,15 +1161,15 @@ bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int txq_id, u16 ssn,
 		fifo = cfg->fifo;
 
 		/* Disable the scheduler prior configuring the cmd queue */
-		if (txq_id == trans_pcie->txqs.cmd.q_id &&
-		    trans_pcie->scd_set_active)
+		if (txq_id == trans->conf.cmd_queue &&
+		    trans->conf.scd_set_active)
 			iwl_scd_enable_set_active(trans, 0);
 
 		/* Stop this Tx queue before configuring it */
 		iwl_scd_txq_set_inactive(trans, txq_id);
 
 		/* Set this queue as a chain-building queue unless it is CMD */
-		if (txq_id != trans_pcie->txqs.cmd.q_id)
+		if (txq_id != trans->conf.cmd_queue)
 			iwl_scd_txq_set_chain(trans, txq_id);
 
 		if (cfg->aggregate) {
@@ -1241,8 +1239,8 @@ bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int txq_id, u16 ssn,
 			       SCD_QUEUE_STTS_REG_MSK);
 
 		/* enable the scheduler for this queue (only) */
-		if (txq_id == trans_pcie->txqs.cmd.q_id &&
-		    trans_pcie->scd_set_active)
+		if (txq_id == trans->conf.cmd_queue &&
+		    trans->conf.scd_set_active)
 			iwl_scd_enable_set_active(trans, BIT(txq_id));
 
 		IWL_DEBUG_TX_QUEUES(trans,
@@ -1313,7 +1311,7 @@ static void iwl_trans_pcie_block_txq_ptrs(struct iwl_trans *trans, bool block)
 	for (i = 0; i < trans->trans_cfg->base_params->num_of_queues; i++) {
 		struct iwl_txq *txq = trans_pcie->txqs.txq[i];
 
-		if (i == trans_pcie->txqs.cmd.q_id)
+		if (i == trans->conf.cmd_queue)
 			continue;
 
 		/* we skip the command queue (obviously) so it's OK to nest */
@@ -1346,7 +1344,7 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 			  struct iwl_host_cmd *cmd)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txqs.txq[trans_pcie->txqs.cmd.q_id];
+	struct iwl_txq *txq = trans_pcie->txqs.txq[trans->conf.cmd_queue];
 	struct iwl_device_cmd *out_cmd;
 	struct iwl_cmd_meta *out_meta;
 	void *dup_buf = NULL;
@@ -1361,7 +1359,7 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 	u16 cmdlen[IWL_MAX_CMD_TBS_PER_TFD];
 	unsigned long flags;
 
-	if (WARN(!trans->wide_cmd_header &&
+	if (WARN(!trans->conf.wide_cmd_header &&
 		 group_id > IWL_ALWAYS_LONG_GROUP,
 		 "unsupported wide command %#x\n", cmd->id))
 		return -EINVAL;
@@ -1475,7 +1473,7 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 				    sizeof(struct iwl_cmd_header_wide));
 		out_cmd->hdr_wide.reserved = 0;
 		out_cmd->hdr_wide.sequence =
-			cpu_to_le16(QUEUE_TO_SEQ(trans_pcie->txqs.cmd.q_id) |
+			cpu_to_le16(QUEUE_TO_SEQ(trans->conf.cmd_queue) |
 						 INDEX_TO_SEQ(txq->write_ptr));
 
 		cmd_pos = sizeof(struct iwl_cmd_header_wide);
@@ -1483,7 +1481,7 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 	} else {
 		out_cmd->hdr.cmd = iwl_cmd_opcode(cmd->id);
 		out_cmd->hdr.sequence =
-			cpu_to_le16(QUEUE_TO_SEQ(trans_pcie->txqs.cmd.q_id) |
+			cpu_to_le16(QUEUE_TO_SEQ(trans->conf.cmd_queue) |
 						 INDEX_TO_SEQ(txq->write_ptr));
 		out_cmd->hdr.group_id = 0;
 
@@ -1534,7 +1532,7 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 		     iwl_get_cmd_string(trans, cmd->id),
 		     group_id, out_cmd->hdr.cmd,
 		     le16_to_cpu(out_cmd->hdr.sequence),
-		     cmd_size, txq->write_ptr, idx, trans_pcie->txqs.cmd.q_id);
+		     cmd_size, txq->write_ptr, idx, trans->conf.cmd_queue);
 
 	/* start the TFD with the minimum copy bytes */
 	tb0_size = min_t(int, copy_size, IWL_FIRST_TB_SIZE);
@@ -1633,14 +1631,14 @@ void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 	struct iwl_device_cmd *cmd;
 	struct iwl_cmd_meta *meta;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txqs.txq[trans_pcie->txqs.cmd.q_id];
+	struct iwl_txq *txq = trans_pcie->txqs.txq[trans->conf.cmd_queue];
 
 	/* If a Tx command is being handled and it isn't in the actual
 	 * command queue then there a command routing bug has been introduced
 	 * in the queue management code. */
-	if (WARN(txq_id != trans_pcie->txqs.cmd.q_id,
+	if (WARN(txq_id != trans->conf.cmd_queue,
 		 "wrong command queue %d (should be %d), sequence 0x%X readp=%d writep=%d\n",
-		 txq_id, trans_pcie->txqs.cmd.q_id, sequence, txq->read_ptr,
+		 txq_id, trans->conf.cmd_queue, sequence, txq->read_ptr,
 		 txq->write_ptr)) {
 		iwl_print_hex_error(trans, pkt, 32);
 		return;
@@ -1753,7 +1751,7 @@ static void *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
 	dma_addr_t phys;
 	void *ret;
 
-	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->txqs.page_offs);
+	page_ptr = (void *)((u8 *)skb->cb + trans->conf.cb_data_offs);
 
 	if (WARN_ON(*page_ptr))
 		return NULL;
@@ -2154,7 +2152,8 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 			struct iwl_device_tx_cmd **dev_cmd_ptr;
 
 			dev_cmd_ptr = (void *)((u8 *)skb->cb +
-					       trans_pcie->txqs.dev_cmd_offs);
+					       trans->conf.cb_data_offs +
+					       sizeof(void *));
 
 			*dev_cmd_ptr = dev_cmd;
 			__skb_queue_tail(&txq->overflow_q, skb);
@@ -2322,7 +2321,7 @@ static void iwl_txq_gen1_inval_byte_cnt_tbl(struct iwl_trans *trans,
 
 	WARN_ON(read_ptr >= TFD_QUEUE_SIZE_MAX);
 
-	if (txq_id != trans_pcie->txqs.cmd.q_id)
+	if (txq_id != trans->conf.cmd_queue)
 		sta_id = tx_cmd->sta_id;
 
 	bc_ent = cpu_to_le16(1 | (sta_id << 12));
@@ -2344,7 +2343,7 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 	int txq_read_ptr, txq_write_ptr;
 
 	/* This function is not meant to release cmd queue*/
-	if (WARN_ON(txq_id == trans_pcie->txqs.cmd.q_id))
+	if (WARN_ON(txq_id == trans->conf.cmd_queue))
 		return;
 
 	if (WARN_ON(!txq))
@@ -2457,7 +2456,8 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 			struct iwl_device_tx_cmd *dev_cmd_ptr;
 
 			dev_cmd_ptr = *(void **)((u8 *)skb->cb +
-						 trans_pcie->txqs.dev_cmd_offs);
+						 trans->conf.cb_data_offs +
+						 sizeof(void *));
 
 			/*
 			 * Note that we can very well be overflowing again.
@@ -2553,7 +2553,7 @@ static int iwl_trans_pcie_send_hcmd_sync(struct iwl_trans *trans,
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	const char *cmd_str = iwl_get_cmd_string(trans, cmd->id);
-	struct iwl_txq *txq = trans_pcie->txqs.txq[trans_pcie->txqs.cmd.q_id];
+	struct iwl_txq *txq = trans_pcie->txqs.txq[trans->conf.cmd_queue];
 	int cmd_idx;
 	int ret;
 
-- 
2.34.1


