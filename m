Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB62430953
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 15:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343708AbhJQN2X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 09:28:23 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53858 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343691AbhJQN2U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 09:28:20 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6Ay-000YdS-Ou; Sun, 17 Oct 2021 16:26:09 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:25:56 +0300
Message-Id: <iwlwifi.20211017162352.b42e67f14293.Ic3f1ed8cb3a31cfaa51174497dd993936b00d398@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017132604.480251-1-luca@coelho.fi>
References: <20211017132604.480251-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/12] iwlwifi: mvm: Support new version of BEACON_TEMPLATE_CMD.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

As part of the new rate_n_flags, a new version of
BEACON_TEMPLATE_CMD was added in FW in order to support
the new rate_n_flags.
Add support for the new version.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 21 +++++++++++----
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  8 ++----
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 27 ++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
 4 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 25af74d13d4b..fd7f577c525b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -757,11 +757,20 @@ struct iwl_mac_beacon_cmd_v7 {
 	struct ieee80211_hdr frame[];
 } __packed; /* BEACON_TEMPLATE_CMD_API_S_VER_7 */
 
+/* Bit flags for BEACON_TEMPLATE_CMD_API until version 10 */
+enum iwl_mac_beacon_flags_v1 {
+	IWL_MAC_BEACON_CCK_V1	= BIT(8),
+	IWL_MAC_BEACON_ANT_A_V1 = BIT(9),
+	IWL_MAC_BEACON_ANT_B_V1 = BIT(10),
+	IWL_MAC_BEACON_FILS_V1	= BIT(12),
+};
+
+/* Bit flags for BEACON_TEMPLATE_CMD_API version 11 and above */
 enum iwl_mac_beacon_flags {
-	IWL_MAC_BEACON_CCK	= BIT(8),
-	IWL_MAC_BEACON_ANT_A	= BIT(9),
-	IWL_MAC_BEACON_ANT_B	= BIT(10),
-	IWL_MAC_BEACON_FILS	= BIT(12),
+	IWL_MAC_BEACON_CCK	= BIT(5),
+	IWL_MAC_BEACON_ANT_A	= BIT(6),
+	IWL_MAC_BEACON_ANT_B	= BIT(7),
+	IWL_MAC_BEACON_FILS	= BIT(8),
 };
 
 /**
@@ -789,7 +798,9 @@ struct iwl_mac_beacon_cmd {
 	__le32 ecsa_offset;
 	__le32 csa_offset;
 	struct ieee80211_hdr frame[];
-} __packed; /* BEACON_TEMPLATE_CMD_API_S_VER_10 */
+} __packed; /* BEACON_TEMPLATE_CMD_API_S_VER_10,
+	       BEACON_TEMPLATE_CMD_API_S_VER_11,
+	       BEACON_TEMPLATE_CMD_API_S_VER_12 */
 
 struct iwl_beacon_notif {
 	struct iwl_mvm_tx_resp beacon_notify_hdr;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 307d57ec7f7c..ff66001d507e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1193,7 +1193,6 @@ static int _iwl_dbgfs_inject_beacon_ie(struct iwl_mvm *mvm, char *bin, int len)
 	struct ieee80211_tx_info *info;
 	struct iwl_mac_beacon_cmd beacon_cmd = {};
 	u8 rate;
-	u16 flags;
 	int i;
 
 	len /= 2;
@@ -1240,12 +1239,9 @@ static int _iwl_dbgfs_inject_beacon_ie(struct iwl_mvm *mvm, char *bin, int len)
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	info = IEEE80211_SKB_CB(beacon);
 	rate = iwl_mvm_mac_ctxt_get_lowest_rate(info, vif);
-	flags = iwl_mvm_mac80211_idx_to_hwrate(mvm->fw, rate);
 
-	if (rate == IWL_FIRST_CCK_RATE)
-		flags |= IWL_MAC_BEACON_CCK;
-
-	beacon_cmd.flags = cpu_to_le16(flags);
+	beacon_cmd.flags =
+		cpu_to_le16(iwl_mvm_mac_ctxt_get_beacon_flags(mvm->fw, rate));
 	beacon_cmd.byte_cnt = cpu_to_le16((u16)beacon->len);
 	beacon_cmd.template_id = cpu_to_le32((u32)mvmvif->id);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 89c260e1c3f4..e31d81a40339 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -812,6 +812,21 @@ u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct ieee80211_tx_info *info,
 	return rate;
 }
 
+u16 iwl_mvm_mac_ctxt_get_beacon_flags(const struct iwl_fw *fw, u8 rate_idx)
+{
+	u16 flags = iwl_mvm_mac80211_idx_to_hwrate(fw, rate_idx);
+	bool is_new_rate = iwl_fw_lookup_cmd_ver(fw,
+						 LONG_GROUP,
+						 BEACON_TEMPLATE_CMD,
+						 0) > 10;
+
+	if (rate_idx <= IWL_FIRST_CCK_RATE)
+		flags |= is_new_rate ? IWL_MAC_BEACON_CCK
+			  : IWL_MAC_BEACON_CCK_V1;
+
+	return flags;
+}
+
 static void iwl_mvm_mac_ctxt_set_tx(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif,
 				    struct sk_buff *beacon,
@@ -930,11 +945,7 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 	u16 flags;
 	struct ieee80211_chanctx_conf *ctx;
 	int channel;
-
-	flags = iwl_mvm_mac80211_idx_to_hwrate(mvm->fw, rate);
-
-	if (rate == IWL_FIRST_CCK_RATE)
-		flags |= IWL_MAC_BEACON_CCK;
+	flags = iwl_mvm_mac_ctxt_get_beacon_flags(mvm->fw, rate);
 
 	/* Enable FILS on PSC channels only */
 	rcu_read_lock();
@@ -943,7 +954,11 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 	WARN_ON(channel == 0);
 	if (cfg80211_channel_is_psc(ctx->def.chan) &&
 	    !IWL_MVM_DISABLE_AP_FILS) {
-		flags |= IWL_MAC_BEACON_FILS;
+		flags |= iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+					       BEACON_TEMPLATE_CMD,
+					       0) > 10 ?
+			IWL_MAC_BEACON_FILS :
+			IWL_MAC_BEACON_FILS_V1;
 		beacon_cmd.short_ssid =
 			cpu_to_le32(~crc32_le(~0, vif->bss_conf.ssid,
 					      vif->bss_conf.ssid_len));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 12b22545e9d0..eea6de5f56c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1629,6 +1629,8 @@ int iwl_mvm_mac_ctxt_send_beacon_cmd(struct iwl_mvm *mvm,
 				     void *data, int len);
 u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct ieee80211_tx_info *info,
 				    struct ieee80211_vif *vif);
+u16 iwl_mvm_mac_ctxt_get_beacon_flags(const struct iwl_fw *fw,
+				      u8 rate_idx);
 void iwl_mvm_mac_ctxt_set_tim(struct iwl_mvm *mvm,
 			      __le32 *tim_index, __le32 *tim_size,
 			      u8 *beacon, u32 frame_size);
-- 
2.33.0

