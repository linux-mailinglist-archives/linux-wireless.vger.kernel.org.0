Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 406A9AA3F0
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388083AbfIENMt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:12:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40900 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731633AbfIENMt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:12:49 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5rZ9-0005yI-CZ; Thu, 05 Sep 2019 16:12:47 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:12:24 +0300
Message-Id: <20190905131241.23487-2-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905131241.23487-1-luca@coelho.fi>
References: <20190905131241.23487-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 01/18] iwlwifi: LTR updates
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alex Malamud <alex.malamud@intel.com>

New FW versions introduces LTR feature enablement by default.
For such FW versions, driver (mvm/xvt) should not send
host command to enable LTR feature, also it should be possible to
override LTR configuration through the debugfs.

1. Send LTR feature enablement command only for FW versions
which does not advertises SET_LTR_GEN2 capability.
2. Implement ltr_config file in debugfs for LTR configuration override.

Signed-off-by: Alex Malamud <alex.malamud@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  3 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 37 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  3 +-
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index ea2b3d77f848..418064ced337 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -441,9 +441,10 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_DYNAMIC_QUOTA                = (__force iwl_ucode_tlv_capa_t)44,
 	IWL_UCODE_TLV_CAPA_COEX_SCHEMA_2		= (__force iwl_ucode_tlv_capa_t)45,
 	IWL_UCODE_TLV_CAPA_CHANNEL_SWITCH_CMD		= (__force iwl_ucode_tlv_capa_t)46,
-	IWL_UCODE_TLV_CAPA_ULTRA_HB_CHANNELS		= (__force iwl_ucode_tlv_capa_t)48,
 	IWL_UCODE_TLV_CAPA_FTM_CALIBRATED		= (__force iwl_ucode_tlv_capa_t)47,
+	IWL_UCODE_TLV_CAPA_ULTRA_HB_CHANNELS		= (__force iwl_ucode_tlv_capa_t)48,
 	IWL_UCODE_TLV_CAPA_CS_MODIFY			= (__force iwl_ucode_tlv_capa_t)49,
+	IWL_UCODE_TLV_CAPA_SET_LTR_GEN2			= (__force iwl_ucode_tlv_capa_t)50,
 
 	/* set 2 */
 	IWL_UCODE_TLV_CAPA_EXTENDED_DTS_MEASURE		= (__force iwl_ucode_tlv_capa_t)64,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 6d67d3da31e0..994a4ba07204 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1758,6 +1758,38 @@ iwl_dbgfs_uapsd_noagg_bssids_read(struct file *file, char __user *user_buf,
 	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
 }
 
+static ssize_t
+iwl_dbgfs_ltr_config_write(struct iwl_mvm *mvm,
+			   char *buf, size_t count, loff_t *ppos)
+{
+	int ret;
+	struct iwl_ltr_config_cmd ltr_config = {0};
+
+	if (!iwl_mvm_firmware_running(mvm))
+		return -EIO;
+
+	if (sscanf(buf, "%x,%x,%x,%x,%x,%x,%x",
+		   &ltr_config.flags,
+		   &ltr_config.static_long,
+		   &ltr_config.static_short,
+		   &ltr_config.ltr_cfg_values[0],
+		   &ltr_config.ltr_cfg_values[1],
+		   &ltr_config.ltr_cfg_values[2],
+		   &ltr_config.ltr_cfg_values[3]) != 7) {
+		return -EINVAL;
+	}
+
+	mutex_lock(&mvm->mutex);
+	ret = iwl_mvm_send_cmd_pdu(mvm, LTR_CONFIG, 0, sizeof(ltr_config),
+				   &ltr_config);
+	mutex_unlock(&mvm->mutex);
+
+	if (ret)
+		IWL_ERR(mvm, "failed to send ltr configuration cmd\n");
+
+	return ret ?: count;
+}
+
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(prph_reg, 64);
 
 /* Device wide debugfs entries */
@@ -1806,6 +1838,8 @@ MVM_DEBUGFS_READ_WRITE_STA_FILE_OPS(amsdu_len, 16);
 
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(he_sniffer_params, 32);
 
+MVM_DEBUGFS_WRITE_FILE_OPS(ltr_config, 512);
+
 static ssize_t iwl_dbgfs_mem_read(struct file *file, char __user *user_buf,
 				  size_t count, loff_t *ppos)
 {
@@ -1993,6 +2027,9 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm, struct dentry *dbgfs_dir)
 #endif
 	MVM_DEBUGFS_ADD_FILE(he_sniffer_params, mvm->debugfs_dir, 0600);
 
+	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_LTR_GEN2))
+		MVM_DEBUGFS_ADD_FILE(ltr_config, mvm->debugfs_dir, 0200);
+
 	debugfs_create_bool("enable_scan_iteration_notif", 0600,
 			    mvm->debugfs_dir, &mvm->scan_iter_notif_enabled);
 	debugfs_create_bool("drop_bcn_ap_mode", 0600, mvm->debugfs_dir,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 251e7c235aaa..bb2aec9c6738 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1302,7 +1302,8 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	iwl_mvm_tt_tx_backoff(mvm, 0);
 #endif
 
-	WARN_ON(iwl_mvm_config_ltr(mvm));
+	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_LTR_GEN2))
+		WARN_ON(iwl_mvm_config_ltr(mvm));
 
 	ret = iwl_mvm_power_update_device(mvm);
 	if (ret)
-- 
2.23.0.rc1

