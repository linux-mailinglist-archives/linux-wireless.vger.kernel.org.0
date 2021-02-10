Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2B3169DD
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhBJPQH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:16:07 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45232 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230294AbhBJPQE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:16:04 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rD2-0049kS-72; Wed, 10 Feb 2021 17:15:16 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:15:03 +0200
Message-Id: <iwlwifi.20210210171218.2cea55a09bc7.I634b79795abad499ce442631d6672ffef8fc6d41@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210151514.416221-1-luca@coelho.fi>
References: <20210210151514.416221-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/12] iwlwifi: mvm: add RFI-M support
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

RF Interference Mitigation is a new feature targeted to handle the
problem of interference between DDR memory and WiFi. The role of
the driver is to configure FW with the table holding a mapping
between problematic channels/bands and the corresponding frequencies.

This patch adds RFI infrastructure and adds two debugfs hooks:
- send RFI configuration command (currently with a default table) which
  will reset feature in the FW
- read the table, used by the FW (which can be a subset of the table
  that driver sent).

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  10 ++
 .../net/wireless/intel/iwlwifi/fw/api/rfi.h   |  60 +++++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   1 +
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   1 +
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  65 ++++++++++
 .../net/wireless/intel/iwlwifi/mvm/fw-api.h   |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c  | 118 ++++++++++++++++++
 8 files changed, 261 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 8142dcfd8b40..c625d319142e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -606,6 +606,16 @@ enum iwl_system_subcmd_ids {
 	 * @FW_ERROR_RECOVERY_CMD: &struct iwl_fw_error_recovery_cmd
 	 */
 	FW_ERROR_RECOVERY_CMD = 0x7,
+
+	/**
+	 * @RFI_CONFIG_CMD: &struct iwl_rfi_config_cmd
+	 */
+	RFI_CONFIG_CMD = 0xb,
+
+	/**
+	 * @RFI_GET_FREQ_TABLE_CMD: &struct iwl_rfi_config_cmd
+	 */
+	RFI_GET_FREQ_TABLE_CMD = 0xc,
 };
 
 #endif /* __iwl_fw_api_commands_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h
new file mode 100644
index 000000000000..c678b9aa9b55
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2020 Intel Corporation
+ */
+#ifndef __iwl_fw_api_rfi_h__
+#define __iwl_fw_api_rfi_h__
+
+#define IWL_RFI_LUT_ENTRY_CHANNELS_NUM 15
+#define IWL_RFI_LUT_SIZE 24
+#define IWL_RFI_LUT_INSTALLED_SIZE 4
+
+/**
+ * struct iwl_rfi_lut_entry - an entry in the RFI frequency LUT.
+ *
+ * @freq: frequency
+ * @channels: channels that can be interfered at frequency freq (at most 15)
+ * @bands: the corresponding bands
+ */
+struct iwl_rfi_lut_entry {
+	__le16 freq;
+	u8 channels[IWL_RFI_LUT_ENTRY_CHANNELS_NUM];
+	u8 bands[IWL_RFI_LUT_ENTRY_CHANNELS_NUM];
+} __packed;
+
+/**
+ * struct iwl_rfi_config_cmd - RFI configuration table
+ *
+ * @entry: a table can have 24 frequency/channel mappings
+ * @oem: specifies if this is the default table or set by OEM
+ */
+struct iwl_rfi_config_cmd {
+	struct iwl_rfi_lut_entry table[IWL_RFI_LUT_SIZE];
+	u8 oem;
+	u8 reserved[3];
+} __packed; /* RFI_CONFIG_CMD_API_S_VER_1 */
+
+/**
+ * iwl_rfi_freq_table_status - status of the frequency table query
+ * @RFI_FREQ_TABLE_OK: can be used
+ * @RFI_FREQ_TABLE_DVFS_NOT_READY: DVFS is not ready yet, should try later
+ * @RFI_FREQ_TABLE_DISABLED: the feature is disabled in FW
+ */
+enum iwl_rfi_freq_table_status {
+	RFI_FREQ_TABLE_OK,
+	RFI_FREQ_TABLE_DVFS_NOT_READY,
+	RFI_FREQ_TABLE_DISABLED,
+};
+
+/**
+ * struct iwl_rfi_freq_table_resp_cmd - get the rfi freq table used by FW
+ *
+ * @table: table used by FW
+ * @status: see &iwl_rfi_freq_table_status
+ */
+struct iwl_rfi_freq_table_resp_cmd {
+	struct iwl_rfi_lut_entry table[IWL_RFI_LUT_INSTALLED_SIZE];
+	__le32 status;
+} __packed; /* RFI_CONFIG_CMD_API_S_VER_1 */
+
+#endif /* __iwl_fw_api_rfi_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index e7068811590b..f2e7b735d211 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -441,6 +441,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_PSC_CHAN_SUPPORT		= (__force iwl_ucode_tlv_capa_t)98,
 
 	IWL_UCODE_TLV_CAPA_BIGTK_SUPPORT		= (__force iwl_ucode_tlv_capa_t)100,
+	IWL_UCODE_TLV_CAPA_RFIM_SUPPORT			= (__force iwl_ucode_tlv_capa_t)102,
 
 	NUM_IWL_UCODE_TLV_CAPA
 #ifdef __CHECKER__
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
index dd268c4bd371..75fc2d935e5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
@@ -6,6 +6,7 @@ iwlmvm-y += scan.o time-event.o rs.o rs-fw.o
 iwlmvm-y += power.o coex.o
 iwlmvm-y += tt.o offloading.o tdls.o
 iwlmvm-y += ftm-responder.o ftm-initiator.o
+iwlmvm-y += rfi.o
 iwlmvm-$(CONFIG_IWLWIFI_DEBUGFS) += debugfs.o debugfs-vif.o
 iwlmvm-$(CONFIG_IWLWIFI_LEDS) += led.o
 iwlmvm-$(CONFIG_PM) += d3.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index efc908231d74..90143b16e665 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1776,6 +1776,69 @@ iwl_dbgfs_ltr_config_write(struct iwl_mvm *mvm,
 	return ret ?: count;
 }
 
+static ssize_t iwl_dbgfs_rfi_freq_table_write(struct iwl_mvm *mvm, char *buf,
+					      size_t count, loff_t *ppos)
+{
+	int ret = 0;
+	u16 op_id;
+
+	if (kstrtou16(buf, 10, &op_id))
+		return -EINVAL;
+
+	/* value zero triggers re-sending the default table to the device */
+	if (!op_id)
+		ret = iwl_rfi_send_config_cmd(mvm, NULL);
+	else
+		ret = -EOPNOTSUPP; /* in the future a new table will be added */
+
+	return ret ?: count;
+}
+
+/* The size computation is as follows:
+ * each number needs at most 3 characters, number of rows is the size of
+ * the table; So, need 5 chars for the "freq: " part and each tuple afterwards
+ * needs 6 characters for numbers and 5 for the punctuation around.
+ */
+#define IWL_RFI_BUF_SIZE (IWL_RFI_LUT_INSTALLED_SIZE *\
+				(5 + IWL_RFI_LUT_ENTRY_CHANNELS_NUM * (6 + 5)))
+
+static ssize_t iwl_dbgfs_rfi_freq_table_read(struct file *file,
+					     char __user *user_buf,
+					     size_t count, loff_t *ppos)
+{
+	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_rfi_freq_table_resp_cmd *resp;
+	u32 status;
+	char buf[IWL_RFI_BUF_SIZE];
+	int i, j, pos = 0;
+
+	resp = iwl_rfi_get_freq_table(mvm);
+	if (IS_ERR(resp))
+		return PTR_ERR(resp);
+
+	status = le32_to_cpu(resp->status);
+	if (status != RFI_FREQ_TABLE_OK) {
+		scnprintf(buf, IWL_RFI_BUF_SIZE, "status = %d\n", status);
+		goto out;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(resp->table); i++) {
+		pos += scnprintf(buf + pos, IWL_RFI_BUF_SIZE - pos, "%d: ",
+				 resp->table[i].freq);
+
+		for (j = 0; j < ARRAY_SIZE(resp->table[i].channels); j++)
+			pos += scnprintf(buf + pos, IWL_RFI_BUF_SIZE - pos,
+					 "(%d, %d) ",
+					 resp->table[i].channels[j],
+					 resp->table[i].bands[j]);
+		pos += scnprintf(buf + pos, IWL_RFI_BUF_SIZE - pos, "\n");
+	}
+
+out:
+	kfree(resp);
+	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+}
+
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(prph_reg, 64);
 
 /* Device wide debugfs entries */
@@ -1827,6 +1890,7 @@ MVM_DEBUGFS_READ_WRITE_STA_FILE_OPS(amsdu_len, 16);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(he_sniffer_params, 32);
 
 MVM_DEBUGFS_WRITE_FILE_OPS(ltr_config, 512);
+MVM_DEBUGFS_READ_WRITE_FILE_OPS(rfi_freq_table, 16);
 
 static ssize_t iwl_dbgfs_mem_read(struct file *file, char __user *user_buf,
 				  size_t count, loff_t *ppos)
@@ -2010,6 +2074,7 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm, struct dentry *dbgfs_dir)
 	MVM_DEBUGFS_ADD_FILE(inject_packet, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(inject_beacon_ie, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(inject_beacon_ie_restore, mvm->debugfs_dir, 0200);
+	MVM_DEBUGFS_ADD_FILE(rfi_freq_table, mvm->debugfs_dir, 0600);
 
 	if (mvm->fw->phy_integration_ver)
 		MVM_DEBUGFS_ADD_FILE(phy_integration_ver, mvm->debugfs_dir, 0400);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h b/drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h
index d7ca1f98883b..73a82f07dc59 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2020 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -36,5 +36,6 @@
 #include "fw/api/stats.h"
 #include "fw/api/location.h"
 #include "fw/api/tx.h"
+#include "fw/api/rfi.h"
 
 #endif /* __fw_api_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 308ba2e961e7..8bc1d8dea432 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2037,6 +2037,10 @@ void iwl_mvm_sta_add_debugfs(struct ieee80211_hw *hw,
 			     struct dentry *dir);
 #endif
 
+int iwl_rfi_send_config_cmd(struct iwl_mvm *mvm,
+			    struct iwl_rfi_lut_entry *rfi_table);
+struct iwl_rfi_freq_table_resp_cmd *iwl_rfi_get_freq_table(struct iwl_mvm *mvm);
+
 static inline u8 iwl_mvm_phy_band_from_nl80211(enum nl80211_band band)
 {
 	switch (band) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
new file mode 100644
index 000000000000..873919048143
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2020 Intel Corporation
+ */
+
+#include "mvm.h"
+#include "fw/api/commands.h"
+#include "fw/api/phy-ctxt.h"
+
+/**
+ * DDR needs frequency in units of 16.666MHz, so provide FW with the
+ * frequency values in the adjusted format.
+ */
+const static struct iwl_rfi_lut_entry iwl_rfi_table[IWL_RFI_LUT_SIZE] = {
+	/* LPDDR4 */
+
+	/* frequency 3733MHz */
+	{cpu_to_le16(223), {114, 116, 118, 120, 122,},
+	      {PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5,}},
+
+	/* frequency 4267MHz */
+	{cpu_to_le16(256), {79, 83, 85, 87, 89, 91, 93,},
+	       {PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6,
+		PHY_BAND_6, PHY_BAND_6,}},
+
+	/* DDR5ePOR */
+
+	/* frequency 4000MHz */
+	{cpu_to_le16(240), {3, 5, 7, 9, 11, 13, 15,},
+	      {PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6,
+	       PHY_BAND_6, PHY_BAND_6,}},
+
+	/* frequency 4400MHz */
+	{cpu_to_le16(264), {111, 119, 123, 125, 129, 131, 133, 135, 143,},
+	      {PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6,
+	       PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6,}},
+
+	/* LPDDR5iPOR */
+
+	/* frequency 5200MHz */
+	{cpu_to_le16(312), {36, 38, 40, 42, 50,},
+	       {PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5,}},
+
+	/* frequency 6000MHz */
+	{cpu_to_le16(360), {3, 5, 7, 9, 11, 13, 15,},
+	       {PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6,
+		PHY_BAND_6, PHY_BAND_6,}},
+
+	/* frequency 6400MHz */
+	{cpu_to_le16(384), {79, 83, 85, 87, 89, 91, 93,},
+	       {PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6,
+		PHY_BAND_6, PHY_BAND_6,}},
+};
+
+int iwl_rfi_send_config_cmd(struct iwl_mvm *mvm, struct iwl_rfi_lut_entry *rfi_table)
+{
+	int ret;
+	struct iwl_rfi_config_cmd cmd;
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(SYSTEM_GROUP, RFI_CONFIG_CMD),
+		.dataflags[0] = IWL_HCMD_DFL_DUP,
+		.data[0] = &cmd,
+		.len[0] = sizeof(cmd),
+	};
+
+	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_RFIM_SUPPORT))
+		return -EOPNOTSUPP;
+
+	/* in case no table is passed, use the default one */
+	if (!rfi_table) {
+		memcpy(cmd.table, iwl_rfi_table, sizeof(cmd.table));
+	} else {
+		memcpy(cmd.table, rfi_table, sizeof(cmd.table));
+		/* notify FW the table is not the default one */
+		cmd.oem = 1;
+	}
+
+	mutex_lock(&mvm->mutex);
+	ret = iwl_mvm_send_cmd(mvm, &hcmd);
+	mutex_unlock(&mvm->mutex);
+
+	if (ret)
+		IWL_ERR(mvm, "Failed to send RFI config cmd %d\n", ret);
+
+	return ret;
+}
+
+struct iwl_rfi_freq_table_resp_cmd *iwl_rfi_get_freq_table(struct iwl_mvm *mvm)
+{
+	struct iwl_rfi_freq_table_resp_cmd *resp;
+	int resp_size = sizeof(*resp);
+	int ret;
+	struct iwl_host_cmd cmd = {
+		.id = WIDE_ID(SYSTEM_GROUP, RFI_GET_FREQ_TABLE_CMD),
+		.flags = CMD_WANT_SKB,
+	};
+
+	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_RFIM_SUPPORT))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	mutex_lock(&mvm->mutex);
+	ret = iwl_mvm_send_cmd(mvm, &cmd);
+	mutex_unlock(&mvm->mutex);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (WARN_ON_ONCE(iwl_rx_packet_payload_len(cmd.resp_pkt) != resp_size))
+		return ERR_PTR(-EIO);
+
+	resp = kzalloc(resp_size, GFP_KERNEL);
+	if (!resp)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(resp, cmd.resp_pkt->data, resp_size);
+
+	iwl_free_resp(&cmd);
+	return resp;
+}
-- 
2.30.0

