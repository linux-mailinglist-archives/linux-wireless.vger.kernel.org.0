Return-Path: <linux-wireless+bounces-18976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B87AA37377
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA2A3AB65F
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2902A18DB34;
	Sun, 16 Feb 2025 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIeoNxwr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B90E18DB32
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699026; cv=none; b=LggZbv4ZPQl5JyNake4oGs9RDudK43t6piI05uZTZwmZbEf2O+g5tdJrT5z4GXTuoTdu0t8bixFUsqSZKVEKxfvO/+h9wNJYb/OXgOA8PgjmAqBcnIjKjGAo3IK45bxzJXq2PZ6V9CWPrtW4mIxUtaxasSaW0oBHT+S6WJOf2bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699026; c=relaxed/simple;
	bh=AYQ+zzrVGucofk4cdqrD6e4Yt8ZE6YuE/VbPBK3YnqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oMBqzsKTrsTRauFa+cWJHc133UUY1wv/nXevuYR6Ni+4JaTBz03uKodaAKPnDwrC7tIy0LQc1o+STHxf2T3oLyiwTv6NAS3RaK2g5EOb2cVP6Mn+d6rAqqE3L6u3xsISWsl5N9HICLM/MZg3Qbgan81+MD0ET++BlKmT+a9loCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIeoNxwr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699024; x=1771235024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AYQ+zzrVGucofk4cdqrD6e4Yt8ZE6YuE/VbPBK3YnqI=;
  b=JIeoNxwrTBBn6sMrieiqDw/UYC1tScsIyf8+b2+J1OWyi4MJkzU4gqSf
   qzP1dWygET4G92suz1pRciblpDZtVvh/y+T+5ZXYQs4K3RCh5zsp4jQyc
   aJyzhJdMzis0KxFgIFisZ/Oc9EUsIhe33wAXPEAWr8kVSuLq5I4DR9i64
   69gvCiWpJHkhXcBpvj8DLwCZjIUBC+71GBLlScZZWAFc1k3ergO9Br6Pw
   cvxt8NX2MDWtwVBhYSWcr5yS2f/sM/2gIvVqHB8vMy7+I71uldLtVUQA7
   xVaktraadJt1Kg8mC6Gs+n2AjOyYEPq1dvDMRyXijboJDxHuf3Id5uWeN
   Q==;
X-CSE-ConnectionGUID: HQfCSA8wQ+iXgjedtJl81w==
X-CSE-MsgGUID: Aea5oo/tTiCX1Ld9mLopDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323366"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323366"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:43 -0800
X-CSE-ConnectionGUID: CZO7O202Ry6FLs5F+RQIUg==
X-CSE-MsgGUID: i9xwSUDAS3mz6GzGLlJUKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785220"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 06/42] wifi: iwlwifi: mld: add file debugfs.h/c
Date: Sun, 16 Feb 2025 11:42:45 +0200
Message-Id: <20250216111648.483434e60617.I0b7cf709fb85564fd7b29765e980f71f10136e40@changeid>
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

this file is handling debugfs

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  | 826 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mld/debugfs.h  | 200 +++++
 2 files changed, 1026 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/debugfs.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
new file mode 100644
index 000000000000..e21fe9ff48b3
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -0,0 +1,826 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+
+#include "mld.h"
+#include "debugfs.h"
+#include "iwl-io.h"
+#include "hcmd.h"
+#include "iface.h"
+#include "sta.h"
+#include "tlc.h"
+#include "power.h"
+#include "notif.h"
+#include "ap.h"
+#include "iwl-utils.h"
+#ifdef CONFIG_THERMAL
+#include "thermal.h"
+#endif
+
+#include "fw/api/rs.h"
+#include "fw/api/dhc.h"
+#include "fw/api/rfi.h"
+
+#define MLD_DEBUGFS_READ_FILE_OPS(name, bufsz)				\
+	_MLD_DEBUGFS_READ_FILE_OPS(name, bufsz, struct iwl_mld)
+
+#define MLD_DEBUGFS_ADD_FILE_ALIAS(alias, name, parent, mode) do {	\
+	debugfs_create_file(alias, mode, parent, mld,			\
+			    &iwl_dbgfs_##name##_ops);			\
+	} while (0)
+#define MLD_DEBUGFS_ADD_FILE(name, parent, mode)			\
+	MLD_DEBUGFS_ADD_FILE_ALIAS(#name, name, parent, mode)
+
+static bool iwl_mld_dbgfs_fw_cmd_disabled(struct iwl_mld *mld)
+{
+#ifdef CONFIG_PM_SLEEP
+	return !mld->fw_status.running || mld->fw_status.in_d3;
+#else
+	return !mld->fw_status.running;
+#endif /* CONFIG_PM_SLEEP */
+}
+
+static ssize_t iwl_dbgfs_fw_dbg_clear_write(struct iwl_mld *mld,
+					    char *buf, size_t count)
+{
+	/* If the firmware is not running, silently succeed since there is
+	 * no data to clear.
+	 */
+	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
+		return 0;
+
+	iwl_fw_dbg_clear_monitor_buf(&mld->fwrt);
+
+	return count;
+}
+
+static ssize_t iwl_dbgfs_fw_nmi_write(struct iwl_mld *mld, char *buf,
+				      size_t count)
+{
+	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
+		return -EIO;
+
+	IWL_ERR(mld, "Triggering an NMI from debugfs\n");
+
+	if (count == 6 && !strcmp(buf, "nolog\n"))
+		mld->fw_status.do_not_dump_once = true;
+
+	iwl_force_nmi(mld->trans);
+
+	return count;
+}
+
+static ssize_t iwl_dbgfs_fw_restart_write(struct iwl_mld *mld, char *buf,
+					  size_t count)
+{
+	int __maybe_unused ret;
+
+	if (!iwlwifi_mod_params.fw_restart)
+		return -EPERM;
+
+	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
+		return -EIO;
+
+	if (count == 6 && !strcmp(buf, "nolog\n")) {
+		mld->fw_status.do_not_dump_once = true;
+		set_bit(STATUS_SUPPRESS_CMD_ERROR_ONCE, &mld->trans->status);
+	}
+
+	/* take the return value to make compiler happy - it will
+	 * fail anyway
+	 */
+	ret = iwl_mld_send_cmd_empty(mld, WIDE_ID(LONG_GROUP, REPLY_ERROR));
+
+	return count;
+}
+
+static ssize_t iwl_dbgfs_send_echo_cmd_write(struct iwl_mld *mld, char *buf,
+					     size_t count)
+{
+	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
+		return -EIO;
+
+	return iwl_mld_send_cmd_empty(mld, ECHO_CMD) ?: count;
+}
+
+struct iwl_mld_sniffer_apply {
+	struct iwl_mld *mld;
+	const u8 *bssid;
+	u16 aid;
+};
+
+static bool iwl_mld_sniffer_apply(struct iwl_notif_wait_data *notif_data,
+				  struct iwl_rx_packet *pkt, void *data)
+{
+	struct iwl_mld_sniffer_apply *apply = data;
+
+	apply->mld->monitor.cur_aid = cpu_to_le16(apply->aid);
+	memcpy(apply->mld->monitor.cur_bssid, apply->bssid,
+	       sizeof(apply->mld->monitor.cur_bssid));
+
+	return true;
+}
+
+static ssize_t
+iwl_dbgfs_he_sniffer_params_write(struct iwl_mld *mld, char *buf,
+				  size_t count)
+{
+	struct iwl_notification_wait wait;
+	struct iwl_he_monitor_cmd he_mon_cmd = {};
+	struct iwl_mld_sniffer_apply apply = {
+		.mld = mld,
+	};
+	u16 wait_cmds[] = {
+		WIDE_ID(DATA_PATH_GROUP, HE_AIR_SNIFFER_CONFIG_CMD),
+	};
+	u32 aid;
+	int ret;
+
+	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
+		return -EIO;
+
+	if (!mld->monitor.on)
+		return -ENODEV;
+
+	ret = sscanf(buf, "%x %2hhx:%2hhx:%2hhx:%2hhx:%2hhx:%2hhx", &aid,
+		     &he_mon_cmd.bssid[0], &he_mon_cmd.bssid[1],
+		     &he_mon_cmd.bssid[2], &he_mon_cmd.bssid[3],
+		     &he_mon_cmd.bssid[4], &he_mon_cmd.bssid[5]);
+	if (ret != 7)
+		return -EINVAL;
+
+	he_mon_cmd.aid = cpu_to_le16(aid);
+
+	apply.aid = aid;
+	apply.bssid = (void *)he_mon_cmd.bssid;
+
+	/* Use the notification waiter to get our function triggered
+	 * in sequence with other RX. This ensures that frames we get
+	 * on the RX queue _before_ the new configuration is applied
+	 * still have mld->cur_aid pointing to the old AID, and that
+	 * frames on the RX queue _after_ the firmware processed the
+	 * new configuration (and sent the response, synchronously)
+	 * get mld->cur_aid correctly set to the new AID.
+	 */
+	iwl_init_notification_wait(&mld->notif_wait, &wait,
+				   wait_cmds, ARRAY_SIZE(wait_cmds),
+				   iwl_mld_sniffer_apply, &apply);
+
+	ret = iwl_mld_send_cmd_pdu(mld,
+				   WIDE_ID(DATA_PATH_GROUP,
+					   HE_AIR_SNIFFER_CONFIG_CMD),
+				   &he_mon_cmd);
+
+	/* no need to really wait, we already did anyway */
+	iwl_remove_notification(&mld->notif_wait, &wait);
+
+	return ret ?: count;
+}
+
+static ssize_t
+iwl_dbgfs_he_sniffer_params_read(struct iwl_mld *mld, size_t count,
+				 char *buf)
+{
+	return scnprintf(buf, count,
+			 "%d %02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx\n",
+			 le16_to_cpu(mld->monitor.cur_aid),
+			 mld->monitor.cur_bssid[0], mld->monitor.cur_bssid[1],
+			 mld->monitor.cur_bssid[2], mld->monitor.cur_bssid[3],
+			 mld->monitor.cur_bssid[4], mld->monitor.cur_bssid[5]);
+}
+
+/* The size computation is as follows:
+ * each number needs at most 3 characters, number of rows is the size of
+ * the table; So, need 5 chars for the "freq: " part and each tuple afterwards
+ * needs 6 characters for numbers and 5 for the punctuation around. 32 bytes
+ * for feature support message.
+ */
+#define IWL_RFI_DDR_BUF_SIZE (IWL_RFI_DDR_LUT_INSTALLED_SIZE *\
+				(5 + IWL_RFI_DDR_LUT_ENTRY_CHANNELS_NUM *\
+					(6 + 5)) + 32)
+#define IWL_RFI_DLVR_BUF_SIZE (IWL_RFI_DLVR_LUT_INSTALLED_SIZE *\
+				(5 + IWL_RFI_DLVR_LUT_ENTRY_CHANNELS_NUM *\
+					(6 + 5)) + 32)
+#define IWL_RFI_DESENSE_BUF_SIZE IWL_RFI_DDR_BUF_SIZE
+
+/* Extra 32 for "DDR and DLVR table" message */
+#define IWL_RFI_BUF_SIZE (IWL_RFI_DDR_BUF_SIZE + IWL_RFI_DLVR_BUF_SIZE +\
+				IWL_RFI_DESENSE_BUF_SIZE + 32)
+
+WIPHY_DEBUGFS_WRITE_FILE_OPS_MLD(fw_nmi, 10);
+WIPHY_DEBUGFS_WRITE_FILE_OPS_MLD(fw_restart, 10);
+WIPHY_DEBUGFS_READ_WRITE_FILE_OPS_MLD(he_sniffer_params, 32);
+WIPHY_DEBUGFS_WRITE_FILE_OPS_MLD(fw_dbg_clear, 10);
+WIPHY_DEBUGFS_WRITE_FILE_OPS_MLD(send_echo_cmd, 8);
+
+static ssize_t iwl_dbgfs_wifi_6e_enable_read(struct iwl_mld *mld,
+					     size_t count, u8 *buf)
+{
+	int err;
+	u32 value;
+
+	err = iwl_bios_get_dsm(&mld->fwrt, DSM_FUNC_ENABLE_6E, &value);
+	if (err)
+		return err;
+
+	return scnprintf(buf, count, "0x%08x\n", value);
+}
+
+MLD_DEBUGFS_READ_FILE_OPS(wifi_6e_enable, 64);
+
+static ssize_t iwl_dbgfs_inject_packet_write(struct iwl_mld *mld,
+					     char *buf, size_t count)
+{
+	struct iwl_op_mode *opmode = container_of((void *)mld,
+						  struct iwl_op_mode,
+						  op_mode_specific);
+	struct iwl_rx_cmd_buffer rxb = {};
+	struct iwl_rx_packet *pkt;
+	int n_bytes = count / 2;
+	int ret = -EINVAL;
+
+	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
+		return -EIO;
+
+	rxb._page = alloc_pages(GFP_KERNEL, 0);
+	if (!rxb._page)
+		return -ENOMEM;
+	pkt = rxb_addr(&rxb);
+
+	ret = hex2bin(page_address(rxb._page), buf, n_bytes);
+	if (ret)
+		goto out;
+
+	/* avoid invalid memory access and malformed packet */
+	if (n_bytes < sizeof(*pkt) ||
+	    n_bytes != sizeof(*pkt) + iwl_rx_packet_payload_len(pkt))
+		goto out;
+
+	local_bh_disable();
+	iwl_mld_rx(opmode, NULL, &rxb);
+	local_bh_enable();
+	ret = 0;
+
+out:
+	iwl_free_rxb(&rxb);
+
+	return ret ?: count;
+}
+
+WIPHY_DEBUGFS_WRITE_FILE_OPS_MLD(inject_packet, 512);
+
+#ifdef CONFIG_THERMAL
+
+static ssize_t iwl_dbgfs_stop_ctdp_write(struct iwl_mld *mld,
+					 char *buf, size_t count)
+{
+	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
+		return -EIO;
+
+	return iwl_mld_config_ctdp(mld, mld->cooling_dev.cur_state,
+				   CTDP_CMD_OPERATION_STOP) ? : count;
+}
+
+WIPHY_DEBUGFS_WRITE_FILE_OPS_MLD(stop_ctdp, 8);
+
+static ssize_t iwl_dbgfs_start_ctdp_write(struct iwl_mld *mld,
+					  char *buf, size_t count)
+{
+	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
+		return -EIO;
+
+	return iwl_mld_config_ctdp(mld, mld->cooling_dev.cur_state,
+				   CTDP_CMD_OPERATION_START) ? : count;
+}
+
+WIPHY_DEBUGFS_WRITE_FILE_OPS_MLD(start_ctdp, 8);
+
+#endif /* CONFIG_THERMAL */
+
+void
+iwl_mld_add_debugfs_files(struct iwl_mld *mld, struct dentry *debugfs_dir)
+{
+	/* Add debugfs files here */
+
+	MLD_DEBUGFS_ADD_FILE(fw_nmi, debugfs_dir, 0200);
+	MLD_DEBUGFS_ADD_FILE(fw_restart, debugfs_dir, 0200);
+	MLD_DEBUGFS_ADD_FILE(wifi_6e_enable, debugfs_dir, 0400);
+	MLD_DEBUGFS_ADD_FILE(he_sniffer_params, debugfs_dir, 0600);
+	MLD_DEBUGFS_ADD_FILE(fw_dbg_clear, debugfs_dir, 0200);
+	MLD_DEBUGFS_ADD_FILE(send_echo_cmd, debugfs_dir, 0200);
+#ifdef CONFIG_THERMAL
+	MLD_DEBUGFS_ADD_FILE(start_ctdp, debugfs_dir, 0200);
+	MLD_DEBUGFS_ADD_FILE(stop_ctdp, debugfs_dir, 0200);
+#endif
+	MLD_DEBUGFS_ADD_FILE(inject_packet, debugfs_dir, 0200);
+
+	/* Create a symlink with mac80211. It will be removed when mac80211
+	 * exits (before the opmode exits which removes the target.)
+	 */
+	if (!IS_ERR(debugfs_dir)) {
+		char buf[100];
+
+		snprintf(buf, 100, "../../%pd2", debugfs_dir->d_parent);
+		debugfs_create_symlink("iwlwifi", mld->wiphy->debugfsdir,
+				       buf);
+	}
+}
+
+#define VIF_DEBUGFS_WRITE_FILE_OPS(name, bufsz)			\
+	WIPHY_DEBUGFS_WRITE_FILE_OPS(vif_##name, bufsz, vif)
+
+#define VIF_DEBUGFS_READ_WRITE_FILE_OPS(name, bufsz)			    \
+	IEEE80211_WIPHY_DEBUGFS_READ_WRITE_FILE_OPS(vif_##name, bufsz, vif) \
+
+#define VIF_DEBUGFS_ADD_FILE_ALIAS(alias, name, parent, mode) do {	\
+	debugfs_create_file(alias, mode, parent, vif,			\
+			    &iwl_dbgfs_vif_##name##_ops);		\
+	} while (0)
+#define VIF_DEBUGFS_ADD_FILE(name, parent, mode)			\
+	VIF_DEBUGFS_ADD_FILE_ALIAS(#name, name, parent, mode)
+
+static ssize_t iwl_dbgfs_vif_bf_params_write(struct iwl_mld *mld, char *buf,
+					     size_t count, void *data)
+{
+	struct ieee80211_vif *vif = data;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	int link_id = vif->active_links ? __ffs(vif->active_links) : 0;
+	struct ieee80211_bss_conf *link_conf;
+	int val;
+
+	if (!strncmp("bf_enable_beacon_filter=", buf, 24)) {
+		if (sscanf(buf + 24, "%d", &val) != 1)
+			return -EINVAL;
+	} else {
+		return -EINVAL;
+	}
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	link_conf = link_conf_dereference_protected(vif, link_id);
+	if (WARN_ON(!link_conf))
+		return -ENODEV;
+
+	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
+		return -EIO;
+
+	mld_vif->disable_bf = !val;
+
+	if (val)
+		return iwl_mld_enable_beacon_filter(mld, link_conf,
+						    false) ?: count;
+	else
+		return iwl_mld_disable_beacon_filter(mld, vif) ?: count;
+}
+
+static ssize_t iwl_dbgfs_vif_pm_params_write(struct iwl_mld *mld,
+					     char *buf,
+					     size_t count, void *data)
+{
+	struct ieee80211_vif *vif = data;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	int val;
+
+	if (!strncmp("use_ps_poll=", buf, 12)) {
+		if (sscanf(buf + 12, "%d", &val) != 1)
+			return -EINVAL;
+	} else {
+		return -EINVAL;
+	}
+
+	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
+		return -EIO;
+
+	mld_vif->use_ps_poll = val;
+
+	return iwl_mld_update_mac_power(mld, vif, false) ?: count;
+}
+
+static ssize_t iwl_dbgfs_vif_low_latency_write(struct iwl_mld *mld,
+					       char *buf, size_t count,
+					       void *data)
+{
+	struct ieee80211_vif *vif = data;
+	u8 value;
+	int ret;
+
+	ret = kstrtou8(buf, 0, &value);
+	if (ret)
+		return ret;
+
+	if (value > 1)
+		return -EINVAL;
+
+	iwl_mld_vif_update_low_latency(mld, vif, value, LOW_LATENCY_DEBUGFS);
+
+	return count;
+}
+
+static ssize_t iwl_dbgfs_vif_low_latency_read(struct ieee80211_vif *vif,
+					      size_t count, char *buf)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	char format[] = "traffic=%d\ndbgfs=%d\nvif_type=%d\nactual=%d\n";
+	u8 ll_causes;
+
+	if (WARN_ON(count < sizeof(format)))
+		return -EINVAL;
+
+	ll_causes = READ_ONCE(mld_vif->low_latency_causes);
+
+	/* all values in format are boolean so the size of format is enough
+	 * for holding the result string
+	 */
+	return scnprintf(buf, count, format,
+			 !!(ll_causes & LOW_LATENCY_TRAFFIC),
+			 !!(ll_causes & LOW_LATENCY_DEBUGFS),
+			 !!(ll_causes & LOW_LATENCY_VIF_TYPE),
+			 !!(ll_causes));
+}
+
+VIF_DEBUGFS_WRITE_FILE_OPS(pm_params, 32);
+VIF_DEBUGFS_WRITE_FILE_OPS(bf_params, 32);
+VIF_DEBUGFS_READ_WRITE_FILE_OPS(low_latency, 45);
+
+static int
+_iwl_dbgfs_inject_beacon_ie(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			    char *bin, ssize_t len,
+			    bool restore)
+{
+	struct iwl_mld_vif *mld_vif;
+	struct iwl_mld_link *mld_link;
+	struct iwl_mac_beacon_cmd beacon_cmd = {};
+	int n_bytes = len / 2;
+
+	/* Element len should be represented by u8 */
+	if (n_bytes >= U8_MAX)
+		return -EINVAL;
+
+	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
+		return -EIO;
+
+	if (!vif)
+		return -EINVAL;
+
+	mld_vif = iwl_mld_vif_from_mac80211(vif);
+	mld_vif->beacon_inject_active = true;
+	mld->hw->extra_beacon_tailroom = n_bytes;
+
+	for_each_mld_vif_valid_link(mld_vif, mld_link) {
+		u32 offset;
+		struct ieee80211_tx_info *info;
+		struct ieee80211_bss_conf *link_conf =
+			link_conf_dereference_protected(vif, link_id);
+		struct ieee80211_chanctx_conf *ctx =
+			wiphy_dereference(mld->wiphy, link_conf->chanctx_conf);
+		struct sk_buff *beacon =
+			ieee80211_beacon_get_template(mld->hw, vif,
+						      NULL, link_id);
+
+		if (!beacon)
+			return -EINVAL;
+
+		if (!restore && (WARN_ON(!n_bytes || !bin) ||
+				 hex2bin(skb_put_zero(beacon, n_bytes),
+					 bin, n_bytes))) {
+			dev_kfree_skb(beacon);
+			return -EINVAL;
+		}
+
+		info = IEEE80211_SKB_CB(beacon);
+
+		beacon_cmd.flags =
+			cpu_to_le16(iwl_mld_get_rate_flags(mld, info, vif,
+							   link_conf,
+							   ctx->def.chan->band));
+		beacon_cmd.byte_cnt = cpu_to_le16((u16)beacon->len);
+		beacon_cmd.link_id =
+			cpu_to_le32(mld_link->fw_id);
+
+		iwl_mld_set_tim_idx(mld, &beacon_cmd.tim_idx,
+				    beacon->data, beacon->len);
+
+		offset = iwl_find_ie_offset(beacon->data,
+					    WLAN_EID_S1G_TWT,
+					    beacon->len);
+
+		beacon_cmd.btwt_offset = cpu_to_le32(offset);
+
+		iwl_mld_send_beacon_template_cmd(mld, beacon, &beacon_cmd);
+		dev_kfree_skb(beacon);
+	}
+
+	if (restore)
+		mld_vif->beacon_inject_active = false;
+
+	return 0;
+}
+
+static ssize_t
+iwl_dbgfs_vif_inject_beacon_ie_write(struct iwl_mld *mld,
+				     char *buf, size_t count,
+				     void *data)
+{
+	struct ieee80211_vif *vif = data;
+	int ret = _iwl_dbgfs_inject_beacon_ie(mld, vif, buf,
+					      count, false);
+
+	mld->hw->extra_beacon_tailroom = 0;
+	return ret ?: count;
+}
+
+VIF_DEBUGFS_WRITE_FILE_OPS(inject_beacon_ie, 512);
+
+static ssize_t
+iwl_dbgfs_vif_inject_beacon_ie_restore_write(struct iwl_mld *mld,
+					     char *buf,
+					     size_t count,
+					     void *data)
+{
+	struct ieee80211_vif *vif = data;
+	int ret = _iwl_dbgfs_inject_beacon_ie(mld, vif, NULL,
+					      0, true);
+
+	mld->hw->extra_beacon_tailroom = 0;
+	return ret ?: count;
+}
+
+VIF_DEBUGFS_WRITE_FILE_OPS(inject_beacon_ie_restore, 512);
+
+static ssize_t
+iwl_dbgfs_vif_twt_setup_write(struct iwl_mld *mld, char *buf, size_t count,
+			      void *data)
+{
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(IWL_ALWAYS_LONG_GROUP, DEBUG_HOST_COMMAND),
+	};
+	struct ieee80211_vif *vif = data;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_dhc_twt_operation *dhc_twt_cmd;
+	struct iwl_dhc_cmd *cmd __free(kfree);
+	u64 target_wake_time;
+	u32 twt_operation, interval_exp, interval_mantissa, min_wake_duration;
+	u8 trigger, flow_type, flow_id, protection, tenth_param;
+	u8 twt_request = 1, broadcast = 0;
+	int ret;
+
+	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
+		return -EIO;
+
+	ret = sscanf(buf, "%u %llu %u %u %u %hhu %hhu %hhu %hhu %hhu",
+		     &twt_operation, &target_wake_time, &interval_exp,
+		     &interval_mantissa, &min_wake_duration, &trigger,
+		     &flow_type, &flow_id, &protection, &tenth_param);
+
+	/* the new twt_request parameter is optional for station */
+	if ((ret != 9 && ret != 10) ||
+	    (ret == 10 && vif->type != NL80211_IFTYPE_STATION &&
+	     tenth_param == 1))
+		return -EINVAL;
+
+	/* The 10th parameter:
+	 * In STA mode - the TWT type (broadcast or individual)
+	 * In AP mode - the role (0 responder, 2 unsolicited)
+	 */
+	if (ret == 10) {
+		if (vif->type == NL80211_IFTYPE_STATION)
+			broadcast = tenth_param;
+		else
+			twt_request = tenth_param;
+	}
+
+	cmd = kzalloc(sizeof(*cmd) + sizeof(*dhc_twt_cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	dhc_twt_cmd = (void *)cmd->data;
+	dhc_twt_cmd->mac_id = cpu_to_le32(mld_vif->fw_id);
+	dhc_twt_cmd->twt_operation = cpu_to_le32(twt_operation);
+	dhc_twt_cmd->target_wake_time = cpu_to_le64(target_wake_time);
+	dhc_twt_cmd->interval_exp = cpu_to_le32(interval_exp);
+	dhc_twt_cmd->interval_mantissa = cpu_to_le32(interval_mantissa);
+	dhc_twt_cmd->min_wake_duration = cpu_to_le32(min_wake_duration);
+	dhc_twt_cmd->trigger = trigger;
+	dhc_twt_cmd->flow_type = flow_type;
+	dhc_twt_cmd->flow_id = flow_id;
+	dhc_twt_cmd->protection = protection;
+	dhc_twt_cmd->twt_request = twt_request;
+	dhc_twt_cmd->negotiation_type = broadcast ? 3 : 0;
+
+	cmd->length = cpu_to_le32(sizeof(*dhc_twt_cmd) >> 2);
+	cmd->index_and_mask =
+		cpu_to_le32(DHC_TABLE_INTEGRATION | DHC_TARGET_UMAC |
+			    DHC_INT_UMAC_TWT_OPERATION);
+
+	hcmd.len[0] = sizeof(*cmd) + sizeof(*dhc_twt_cmd);
+	hcmd.data[0] = cmd;
+
+	ret = iwl_mld_send_cmd(mld, &hcmd);
+
+	return ret ?: count;
+}
+
+VIF_DEBUGFS_WRITE_FILE_OPS(twt_setup, 256);
+
+static ssize_t
+iwl_dbgfs_vif_twt_operation_write(struct iwl_mld *mld, char *buf, size_t count,
+				  void *data)
+{
+	struct ieee80211_vif *vif = data;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_twt_operation_cmd twt_cmd = {};
+	int link_id = vif->active_links ? __ffs(vif->active_links) : 0;
+	struct iwl_mld_link *mld_link = iwl_mld_link_dereference_check(mld_vif,
+								       link_id);
+	int ret;
+
+	if (WARN_ON(!mld_link))
+		return -ENODEV;
+
+	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
+		return -EIO;
+
+	if (hweight16(vif->active_links) > 1)
+		return -EOPNOTSUPP;
+
+	ret = sscanf(buf, "%u %llu %u %u %u %hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu",
+		     &twt_cmd.twt_operation, &twt_cmd.target_wake_time,
+		     &twt_cmd.interval_exponent, &twt_cmd.interval_mantissa,
+		     &twt_cmd.minimum_wake_duration, &twt_cmd.trigger,
+		     &twt_cmd.flow_type, &twt_cmd.flow_id,
+		     &twt_cmd.twt_protection, &twt_cmd.ndp_paging_indicator,
+		     &twt_cmd.responder_pm_mode, &twt_cmd.negotiation_type,
+		     &twt_cmd.twt_request, &twt_cmd.implicit,
+		     &twt_cmd.twt_group_assignment, &twt_cmd.twt_channel,
+		     &twt_cmd.restricted_info_present, &twt_cmd.dl_bitmap_valid,
+		     &twt_cmd.ul_bitmap_valid, &twt_cmd.dl_tid_bitmap,
+		     &twt_cmd.ul_tid_bitmap);
+
+	if (ret != 21)
+		return -EINVAL;
+
+	twt_cmd.link_id = cpu_to_le32(mld_link->fw_id);
+
+	ret = iwl_mld_send_cmd_pdu(mld,
+				   WIDE_ID(MAC_CONF_GROUP, TWT_OPERATION_CMD),
+				   &twt_cmd);
+	return ret ?: count;
+}
+
+VIF_DEBUGFS_WRITE_FILE_OPS(twt_operation, 256);
+
+void iwl_mld_add_vif_debugfs(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif)
+{
+	struct dentry *mld_vif_dbgfs =
+		debugfs_create_dir("iwlmld", vif->debugfs_dir);
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+	char target[3 * 3 + 11 + (NL80211_WIPHY_NAME_MAXLEN + 1) +
+		    (7 + IFNAMSIZ + 1) + 6 + 1];
+	char name[7 + IFNAMSIZ + 1];
+
+	/* Create symlink for convenience pointing to interface specific
+	 * debugfs entries for the driver. For example, under
+	 * /sys/kernel/debug/iwlwifi/0000\:02\:00.0/iwlmld/
+	 * find
+	 * netdev:wlan0 -> ../../../ieee80211/phy0/netdev:wlan0/iwlmld/
+	 */
+	snprintf(name, sizeof(name), "%pd", vif->debugfs_dir);
+	snprintf(target, sizeof(target), "../../../%pd3/iwlmld",
+		 vif->debugfs_dir);
+	mld_vif->dbgfs_slink =
+		debugfs_create_symlink(name, mld->debugfs_dir, target);
+
+	if (iwlmld_mod_params.power_scheme != IWL_POWER_SCHEME_CAM &&
+	    vif->type == NL80211_IFTYPE_STATION) {
+		VIF_DEBUGFS_ADD_FILE(pm_params, mld_vif_dbgfs, 0200);
+		VIF_DEBUGFS_ADD_FILE(bf_params, mld_vif_dbgfs, 0200);
+	}
+
+	if (vif->type == NL80211_IFTYPE_AP) {
+		VIF_DEBUGFS_ADD_FILE(inject_beacon_ie, mld_vif_dbgfs, 0200);
+		VIF_DEBUGFS_ADD_FILE(inject_beacon_ie_restore,
+				     mld_vif_dbgfs, 0200);
+	}
+
+	VIF_DEBUGFS_ADD_FILE(low_latency, mld_vif_dbgfs, 0600);
+	VIF_DEBUGFS_ADD_FILE(twt_setup, mld_vif_dbgfs, 0200);
+	VIF_DEBUGFS_ADD_FILE(twt_operation, mld_vif_dbgfs, 0200);
+}
+
+#define LINK_DEBUGFS_WRITE_FILE_OPS(name, bufsz)			\
+	WIPHY_DEBUGFS_WRITE_FILE_OPS(link_##name, bufsz, bss_conf)
+
+#define LINK_DEBUGFS_ADD_FILE_ALIAS(alias, name, parent, mode) do {	\
+	debugfs_create_file(alias, mode, parent, link_conf,		\
+			    &iwl_dbgfs_link_##name##_ops);		\
+	} while (0)
+#define LINK_DEBUGFS_ADD_FILE(name, parent, mode)			\
+	LINK_DEBUGFS_ADD_FILE_ALIAS(#name, name, parent, mode)
+
+void iwl_mld_add_link_debugfs(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link_conf,
+			      struct dentry *dir)
+{
+	struct dentry *mld_link_dir;
+
+	mld_link_dir = debugfs_lookup("iwlmld", dir);
+
+	/* For non-MLO vifs, the dir of deflink is the same as the vif's one.
+	 * so if iwlmld dir already exists, this means that this is deflink.
+	 * If not, this is a per-link dir of a MLO vif, add in it the iwlmld
+	 * dir.
+	 */
+	if (!mld_link_dir)
+		mld_link_dir = debugfs_create_dir("iwlmld", dir);
+}
+
+static ssize_t iwl_dbgfs_fixed_rate_write(struct iwl_mld *mld, char *buf,
+					  size_t count, void *data)
+{
+	struct ieee80211_link_sta *link_sta = data;
+	struct iwl_mld_link_sta *mld_link_sta;
+	u32 rate;
+	u32 partial = false;
+	char pretty_rate[100];
+	int ret;
+	u8 fw_sta_id;
+
+	mld_link_sta = iwl_mld_link_sta_from_mac80211(link_sta);
+	if (WARN_ON(!mld_link_sta))
+		return -EINVAL;
+
+	fw_sta_id = mld_link_sta->fw_id;
+
+	if (sscanf(buf, "%i %i", &rate, &partial) == 0)
+		return -EINVAL;
+
+	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
+		return -EIO;
+
+	ret = iwl_mld_send_tlc_dhc(mld, fw_sta_id,
+				   partial ? IWL_TLC_DEBUG_PARTIAL_FIXED_RATE :
+					     IWL_TLC_DEBUG_FIXED_RATE,
+				   rate);
+
+	rs_pretty_print_rate(pretty_rate, sizeof(pretty_rate), rate);
+
+	IWL_DEBUG_RATE(mld, "sta_id %d rate %s partial: %d, ret:%d\n",
+		       fw_sta_id, pretty_rate, partial, ret);
+
+	return ret ? : count;
+}
+
+static ssize_t iwl_dbgfs_tlc_dhc_write(struct iwl_mld *mld, char *buf,
+				       size_t count, void *data)
+{
+	struct ieee80211_link_sta *link_sta = data;
+	struct iwl_mld_link_sta *mld_link_sta;
+	u32 type, value;
+	int ret;
+	u8 fw_sta_id;
+
+	mld_link_sta = iwl_mld_link_sta_from_mac80211(link_sta);
+	if (WARN_ON(!mld_link_sta))
+		return -EINVAL;
+
+	fw_sta_id = mld_link_sta->fw_id;
+
+	if (sscanf(buf, "%i %i", &type, &value) != 2) {
+		IWL_DEBUG_RATE(mld, "usage <type> <value>\n");
+		return -EINVAL;
+	}
+
+	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
+		return -EIO;
+
+	ret = iwl_mld_send_tlc_dhc(mld, fw_sta_id, type, value);
+
+	return ret ? : count;
+}
+
+#define LINK_STA_DEBUGFS_ADD_FILE_ALIAS(alias, name, parent, mode) do {	\
+	debugfs_create_file(alias, mode, parent, link_sta,		\
+			    &iwl_dbgfs_##name##_ops);			\
+	} while (0)
+#define LINK_STA_DEBUGFS_ADD_FILE(name, parent, mode)			\
+	LINK_STA_DEBUGFS_ADD_FILE_ALIAS(#name, name, parent, mode)
+
+#define LINK_STA_WIPHY_DEBUGFS_WRITE_OPS(name, bufsz)			\
+	WIPHY_DEBUGFS_WRITE_FILE_OPS(name, bufsz, link_sta)
+
+LINK_STA_WIPHY_DEBUGFS_WRITE_OPS(tlc_dhc, 64);
+LINK_STA_WIPHY_DEBUGFS_WRITE_OPS(fixed_rate, 64);
+
+void iwl_mld_add_link_sta_debugfs(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_link_sta *link_sta,
+				  struct dentry *dir)
+{
+	LINK_STA_DEBUGFS_ADD_FILE(fixed_rate, dir, 0200);
+	LINK_STA_DEBUGFS_ADD_FILE(tlc_dhc, dir, 0200);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.h b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.h
new file mode 100644
index 000000000000..04c536db8b16
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.h
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#include "iface.h"
+#include "sta.h"
+
+#define MLD_DEBUGFS_OPEN_WRAPPER(name, buflen, argtype)			\
+struct dbgfs_##name##_data {						\
+	argtype *arg;							\
+	bool read_done;							\
+	ssize_t rlen;							\
+	char buf[buflen];						\
+};									\
+static int _iwl_dbgfs_##name##_open(struct inode *inode,		\
+				    struct file *file)			\
+{									\
+	struct dbgfs_##name##_data *data;				\
+									\
+	if ((file->f_flags & O_ACCMODE) == O_RDWR)			\
+		return -EOPNOTSUPP;					\
+									\
+	data = kzalloc(sizeof(*data), GFP_KERNEL);			\
+	if (!data)							\
+		return -ENOMEM;						\
+									\
+	data->read_done = false;					\
+	data->arg = inode->i_private;					\
+	file->private_data = data;					\
+									\
+	return 0;							\
+}
+
+#define MLD_DEBUGFS_READ_WRAPPER(name)					\
+static ssize_t _iwl_dbgfs_##name##_read(struct file *file,		\
+					char __user *user_buf,		\
+					size_t count, loff_t *ppos)	\
+{									\
+	struct dbgfs_##name##_data *data = file->private_data;		\
+									\
+	if (!data->read_done) {						\
+		data->read_done = true;					\
+		data->rlen = iwl_dbgfs_##name##_read(data->arg,		\
+						     sizeof(data->buf),\
+						     data->buf);	\
+	}								\
+									\
+	if (data->rlen < 0)						\
+		return data->rlen;					\
+	return simple_read_from_buffer(user_buf, count, ppos,		\
+				       data->buf, data->rlen);		\
+}
+
+static int _iwl_dbgfs_release(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
+#define _MLD_DEBUGFS_READ_FILE_OPS(name, buflen, argtype)		\
+MLD_DEBUGFS_OPEN_WRAPPER(name, buflen, argtype)				\
+MLD_DEBUGFS_READ_WRAPPER(name)						\
+static const struct file_operations iwl_dbgfs_##name##_ops = {		\
+	.read = _iwl_dbgfs_##name##_read,				\
+	.open = _iwl_dbgfs_##name##_open,				\
+	.llseek = generic_file_llseek,					\
+	.release = _iwl_dbgfs_release,					\
+}
+
+#define WIPHY_DEBUGFS_HANDLER_WRAPPER(name)				\
+static ssize_t iwl_dbgfs_##name##_write_handler(struct wiphy *wiphy,	\
+				       struct file *file, char *buf,	\
+				       size_t count, void *data)	\
+{									\
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);		\
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);			\
+	return iwl_dbgfs_##name##_write(mld, buf, count, data);		\
+}
+
+static inline struct iwl_mld *
+iwl_mld_from_link_sta(struct ieee80211_link_sta *link_sta)
+{
+	struct ieee80211_vif *vif =
+		iwl_mld_sta_from_mac80211(link_sta->sta)->vif;
+	return iwl_mld_vif_from_mac80211(vif)->mld;
+}
+
+static inline struct iwl_mld *
+iwl_mld_from_bss_conf(struct ieee80211_bss_conf *link)
+{
+	return iwl_mld_vif_from_mac80211(link->vif)->mld;
+}
+
+static inline struct iwl_mld *iwl_mld_from_vif(struct ieee80211_vif *vif)
+{
+	return iwl_mld_vif_from_mac80211(vif)->mld;
+}
+
+#define WIPHY_DEBUGFS_WRITE_WRAPPER(name, bufsz, objtype)		\
+WIPHY_DEBUGFS_HANDLER_WRAPPER(name)					\
+static ssize_t __iwl_dbgfs_##name##_write(struct file *file,		\
+					  const char __user *user_buf,	\
+					  size_t count, loff_t *ppos)	\
+{									\
+	struct ieee80211_##objtype *arg = file->private_data;		\
+	struct iwl_mld *mld = iwl_mld_from_##objtype(arg);		\
+	char buf[bufsz] = {};						\
+									\
+	return wiphy_locked_debugfs_write(mld->wiphy, file,		\
+				buf, sizeof(buf),			\
+				user_buf, count,			\
+				iwl_dbgfs_##name##_write_handler,	\
+				arg);					\
+}
+
+#define WIPHY_DEBUGFS_WRITE_FILE_OPS(name, bufsz, objtype)		\
+	WIPHY_DEBUGFS_WRITE_WRAPPER(name, bufsz, objtype)		\
+	static const struct file_operations iwl_dbgfs_##name##_ops = {	\
+		.write = __iwl_dbgfs_##name##_write,			\
+		.open = simple_open,					\
+		.llseek = generic_file_llseek,				\
+	}
+
+#define WIPHY_DEBUGFS_HANDLER_WRAPPER_MLD(name)				\
+static ssize_t iwl_dbgfs_##name##_write_handler(struct wiphy *wiphy,	\
+				       struct file *file, char *buf,	\
+				       size_t count, void *data)	\
+{									\
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);		\
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);			\
+	return iwl_dbgfs_##name##_write(mld, buf, count);		\
+}
+
+#define WIPHY_DEBUGFS_WRITE_WRAPPER_MLD(name)				\
+WIPHY_DEBUGFS_HANDLER_WRAPPER_MLD(name)					\
+static ssize_t __iwl_dbgfs_##name##_write(struct file *file,		\
+					  const char __user *user_buf,	\
+					  size_t count, loff_t *ppos)	\
+{									\
+	struct dbgfs_##name##_data *data = file->private_data;		\
+	struct iwl_mld *mld = data->arg;				\
+									\
+	return wiphy_locked_debugfs_write(mld->wiphy, file,		\
+				data->buf, sizeof(data->buf),		\
+				user_buf, count,			\
+				iwl_dbgfs_##name##_write_handler,	\
+				NULL);					\
+}
+
+#define WIPHY_DEBUGFS_WRITE_FILE_OPS_MLD(name, bufsz)			\
+	MLD_DEBUGFS_OPEN_WRAPPER(name, bufsz, struct iwl_mld)		\
+	WIPHY_DEBUGFS_WRITE_WRAPPER_MLD(name)				\
+	static const struct file_operations iwl_dbgfs_##name##_ops = {	\
+		.write = __iwl_dbgfs_##name##_write,			\
+		.open = _iwl_dbgfs_##name##_open,			\
+		.llseek = generic_file_llseek,				\
+		.release = _iwl_dbgfs_release,				\
+	}
+
+#define WIPHY_DEBUGFS_READ_WRITE_FILE_OPS_MLD(name, bufsz)		\
+	MLD_DEBUGFS_OPEN_WRAPPER(name, bufsz, struct iwl_mld)		\
+	WIPHY_DEBUGFS_WRITE_WRAPPER_MLD(name)				\
+	MLD_DEBUGFS_READ_WRAPPER(name)					\
+	static const struct file_operations iwl_dbgfs_##name##_ops = {	\
+		.write = __iwl_dbgfs_##name##_write,			\
+		.read = _iwl_dbgfs_##name##_read,			\
+		.open = _iwl_dbgfs_##name##_open,			\
+		.llseek = generic_file_llseek,				\
+		.release = _iwl_dbgfs_release,				\
+	}
+
+#define WIPHY_DEBUGFS_WRITE_WRAPPER_IEEE80211(name, bufsz, objtype)	\
+WIPHY_DEBUGFS_HANDLER_WRAPPER(name)					\
+static ssize_t _iwl_dbgfs_##name##_write(struct file *file,		\
+					  const char __user *user_buf,	\
+					  size_t count, loff_t *ppos)	\
+{									\
+	struct dbgfs_##name##_data *data = file->private_data;		\
+	struct ieee80211_##objtype *arg = data->arg;			\
+	struct iwl_mld *mld = iwl_mld_from_##objtype(arg);		\
+	char buf[bufsz] = {};						\
+									\
+	return wiphy_locked_debugfs_write(mld->wiphy, file,		\
+				buf, sizeof(buf),			\
+				user_buf, count,			\
+				iwl_dbgfs_##name##_write_handler,	\
+				arg);					\
+}
+
+#define IEEE80211_WIPHY_DEBUGFS_READ_WRITE_FILE_OPS(name, bufsz, objtype) \
+	MLD_DEBUGFS_OPEN_WRAPPER(name, bufsz, struct ieee80211_##objtype) \
+	WIPHY_DEBUGFS_WRITE_WRAPPER_IEEE80211(name, bufsz, objtype)	  \
+	MLD_DEBUGFS_READ_WRAPPER(name)					  \
+	static const struct file_operations iwl_dbgfs_##name##_ops = {	  \
+		.write = _iwl_dbgfs_##name##_write,			  \
+		.read = _iwl_dbgfs_##name##_read,			  \
+		.open = _iwl_dbgfs_##name##_open,			  \
+		.llseek = generic_file_llseek,				  \
+		.release = _iwl_dbgfs_release,				  \
+	}
-- 
2.34.1


