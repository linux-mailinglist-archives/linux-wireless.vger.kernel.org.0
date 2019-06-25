Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B928952871
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 11:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfFYJpF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 05:45:05 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54640 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728150AbfFYJpD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 05:45:03 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hfi0c-0007Nv-51; Tue, 25 Jun 2019 12:45:02 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 09/12] iwlwifi: mvm: add a debugfs entry to set a fixed size AMSDU for all TX packets
Date:   Tue, 25 Jun 2019 12:44:49 +0300
Message-Id: <20190625094452.19034-10-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625094452.19034-1-luca@coelho.fi>
References: <20190625094452.19034-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The current debugfs entry only limits the max AMSDU for TCP.  Add a new
debugfs entry to allow setting a fixed AMSDU size for all TX packets,
including UDP and ICMP

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 46 ++++++++++++++++++-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  4 ++
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index d4ff6b44de2c..fb2fd89270ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -467,6 +467,46 @@ static ssize_t iwl_dbgfs_rs_data_read(struct file *file, char __user *user_buf,
 	return ret;
 }
 
+static ssize_t iwl_dbgfs_amsdu_len_write(struct ieee80211_sta *sta,
+					 char *buf, size_t count,
+					 loff_t *ppos)
+{
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	int i;
+	u16 amsdu_len;
+
+	if (kstrtou16(buf, 0, &amsdu_len))
+		return -EINVAL;
+
+	if (amsdu_len) {
+		mvmsta->orig_amsdu_len = sta->max_amsdu_len;
+		sta->max_amsdu_len = amsdu_len;
+		for (i = 0; i < ARRAY_SIZE(sta->max_tid_amsdu_len); i++)
+			sta->max_tid_amsdu_len[i] = amsdu_len;
+	} else {
+		sta->max_amsdu_len = mvmsta->orig_amsdu_len;
+		mvmsta->orig_amsdu_len = 0;
+	}
+	return count;
+}
+
+static ssize_t iwl_dbgfs_amsdu_len_read(struct file *file,
+					char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	struct ieee80211_sta *sta = file->private_data;
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+
+	char buf[32];
+	int pos;
+
+	pos = scnprintf(buf, sizeof(buf), "current %d ", sta->max_amsdu_len);
+	pos += scnprintf(buf + pos, sizeof(buf) - pos, "stored %d\n",
+			 mvmsta->orig_amsdu_len);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+}
+
 static ssize_t iwl_dbgfs_disable_power_off_read(struct file *file,
 						char __user *user_buf,
 						size_t count, loff_t *ppos)
@@ -1947,6 +1987,8 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(d3_sram, 8);
 MVM_DEBUGFS_READ_FILE_OPS(sar_geo_profile);
 #endif
 
+MVM_DEBUGFS_READ_WRITE_STA_FILE_OPS(amsdu_len, 16);
+
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(he_sniffer_params, 32);
 
 static ssize_t iwl_dbgfs_mem_read(struct file *file, char __user *user_buf,
@@ -2088,8 +2130,10 @@ void iwl_mvm_sta_add_debugfs(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	if (iwl_mvm_has_tlc_offload(mvm))
+	if (iwl_mvm_has_tlc_offload(mvm)) {
 		MVM_DEBUGFS_ADD_STA_FILE(rs_data, dir, 0400);
+	}
+	MVM_DEBUGFS_ADD_STA_FILE(amsdu_len, dir, 0600);
 }
 
 void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm, struct dentry *dbgfs_dir)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 659e21b2d4e7..1cfd550c1ecb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -344,7 +344,7 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 			       lq_sta->last_rate_n_flags);
 	}
 
-	if (flags & IWL_TLC_NOTIF_FLAG_AMSDU) {
+	if (flags & IWL_TLC_NOTIF_FLAG_AMSDU && !mvmsta->orig_amsdu_len) {
 		u16 size = le32_to_cpu(notif->amsdu_size);
 		int i;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index b4d4071b865d..4487cc3e07c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -386,6 +386,9 @@ struct iwl_mvm_rxq_dup_data {
  * @amsdu_enabled: bitmap of TX AMSDU allowed TIDs.
  *	In case TLC offload is not active it is either 0xFFFF or 0.
  * @max_amsdu_len: max AMSDU length
+ * @orig_amsdu_len: used to save the original amsdu_len when it is changed via
+ *      debugfs.  If it's set to 0, it means that it is it's not set via
+ *      debugfs.
  * @agg_tids: bitmap of tids whose status is operational aggregated (IWL_AGG_ON)
  * @sleep_tx_count: the number of frames that we told the firmware to let out
  *	even when that station is asleep. This is useful in case the queue
@@ -434,6 +437,7 @@ struct iwl_mvm_sta {
 	bool disable_tx;
 	u16 amsdu_enabled;
 	u16 max_amsdu_len;
+	u16 orig_amsdu_len;
 	bool sleeping;
 	u8 agg_tids;
 	u8 sleep_tx_count;
-- 
2.20.1

