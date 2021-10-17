Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDC4430952
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 15:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343689AbhJQN2W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 09:28:22 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53852 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343690AbhJQN2T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 09:28:19 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6Ax-000YdS-RG; Sun, 17 Oct 2021 16:26:08 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:25:55 +0300
Message-Id: <iwlwifi.20211017162352.26efa51624b1.Ic96ae4d81b3ff07fb514df2b5f6a8e470e4d3778@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017132604.480251-1-luca@coelho.fi>
References: <20211017132604.480251-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 03/12] iwlwifi: mvm: Add support for new rate_n_flags in tx_cmd.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

As part of the new rate_n_flags, tx_cmd API has changed.
Add support for these changes.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h    |  6 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  5 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c       | 14 +++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c    | 12 ++++++++++--
 6 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index c0caf9dca545..25af74d13d4b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -267,7 +267,8 @@ struct iwl_tx_cmd_gen2 {
 	struct iwl_dram_sec_info dram_info;
 	__le32 rate_n_flags;
 	struct ieee80211_hdr hdr[];
-} __packed; /* TX_CMD_API_S_VER_7 */
+} __packed; /* TX_CMD_API_S_VER_7,
+	       TX_CMD_API_S_VER_9 */
 
 /**
  * struct iwl_tx_cmd_gen3 - TX command struct to FW for AX210+ devices
@@ -290,7 +291,8 @@ struct iwl_tx_cmd_gen3 {
 	__le32 rate_n_flags;
 	__le64 ttl;
 	struct ieee80211_hdr hdr[];
-} __packed; /* TX_CMD_API_S_VER_8 */
+} __packed; /* TX_CMD_API_S_VER_8,
+	       TX_CMD_API_S_VER_10 */
 
 /*
  * TX response related data
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 1fba6b421d31..307d57ec7f7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1240,7 +1240,7 @@ static int _iwl_dbgfs_inject_beacon_ie(struct iwl_mvm *mvm, char *bin, int len)
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	info = IEEE80211_SKB_CB(beacon);
 	rate = iwl_mvm_mac_ctxt_get_lowest_rate(info, vif);
-	flags = iwl_mvm_mac80211_idx_to_hwrate(rate);
+	flags = iwl_mvm_mac80211_idx_to_hwrate(mvm->fw, rate);
 
 	if (rate == IWL_FIRST_CCK_RATE)
 		flags |= IWL_MAC_BEACON_CCK;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 0065cc76a2a0..89c260e1c3f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -844,7 +844,8 @@ static void iwl_mvm_mac_ctxt_set_tx(struct iwl_mvm *mvm,
 
 	rate = iwl_mvm_mac_ctxt_get_lowest_rate(info, vif);
 
-	tx->rate_n_flags |= cpu_to_le32(iwl_mvm_mac80211_idx_to_hwrate(rate));
+	tx->rate_n_flags |=
+		cpu_to_le32(iwl_mvm_mac80211_idx_to_hwrate(mvm->fw, rate));
 	if (rate == IWL_FIRST_CCK_RATE)
 		tx->rate_n_flags |= cpu_to_le32(RATE_MCS_CCK_MSK_V1);
 
@@ -930,7 +931,7 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 	struct ieee80211_chanctx_conf *ctx;
 	int channel;
 
-	flags = iwl_mvm_mac80211_idx_to_hwrate(rate);
+	flags = iwl_mvm_mac80211_idx_to_hwrate(mvm->fw, rate);
 
 	if (rate == IWL_FIRST_CCK_RATE)
 		flags |= IWL_MAC_BEACON_CCK;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 50a11a595db1..12b22545e9d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1448,7 +1448,7 @@ int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 			       enum nl80211_band band,
 			       struct ieee80211_tx_rate *r);
-u8 iwl_mvm_mac80211_idx_to_hwrate(int rate_idx);
+u8 iwl_mvm_mac80211_idx_to_hwrate(const struct iwl_fw *fw, int rate_idx);
 u8 iwl_mvm_mac80211_ac_to_ucode_ac(enum ieee80211_ac_numbers ac);
 
 static inline void iwl_mvm_dump_nic_error_log(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index ff29c4b140dc..aa1797139f7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -268,6 +268,7 @@ static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 	int rate_idx = -1;
 	u8 rate_plcp;
 	u32 rate_flags = 0;
+	bool is_cck;
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
 	/* info->control is only relevant for non HW rate control */
@@ -299,11 +300,18 @@ static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 	BUILD_BUG_ON(IWL_FIRST_CCK_RATE != 0);
 
 	/* Get PLCP rate for tx_cmd->rate_n_flags */
-	rate_plcp = iwl_mvm_mac80211_idx_to_hwrate(rate_idx);
+	rate_plcp = iwl_mvm_mac80211_idx_to_hwrate(mvm->fw, rate_idx);
+	is_cck = (rate_idx >= IWL_FIRST_CCK_RATE) && (rate_idx <= IWL_LAST_CCK_RATE);
 
-	/* Set CCK flag as needed */
-	if ((rate_idx >= IWL_FIRST_CCK_RATE) && (rate_idx <= IWL_LAST_CCK_RATE))
+	/* Set CCK or OFDM flag */
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP, TX_CMD, 0) > 8) {
+		if (!is_cck)
+			rate_flags |= RATE_MCS_LEGACY_OFDM_MSK;
+		else
+			rate_flags |= RATE_MCS_CCK_MSK;
+	} else if (is_cck) {
 		rate_flags |= RATE_MCS_CCK_MSK_V1;
+	}
 
 	return (u32)rate_plcp | rate_flags;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index dc1727280248..11f51a421a3d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -152,9 +152,17 @@ int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 	return -1;
 }
 
-u8 iwl_mvm_mac80211_idx_to_hwrate(int rate_idx)
+u8 iwl_mvm_mac80211_idx_to_hwrate(const struct iwl_fw *fw, int rate_idx)
 {
-	/* Get PLCP rate for tx_cmd->rate_n_flags */
+	if (iwl_fw_lookup_cmd_ver(fw, LONG_GROUP,
+				  TX_CMD, 0) > 8)
+		/* In the new rate legacy rates are indexed:
+		 * 0 - 3 for CCK and 0 - 7 for OFDM.
+		 */
+		return (rate_idx >= IWL_FIRST_OFDM_RATE ?
+			rate_idx - IWL_FIRST_OFDM_RATE :
+			rate_idx);
+
 	return iwl_fw_rate_idx_to_plcp(rate_idx);
 }
 
-- 
2.33.0

