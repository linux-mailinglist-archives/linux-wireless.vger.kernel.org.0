Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA609430954
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 15:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343706AbhJQN2X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 09:28:23 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53864 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343695AbhJQN2V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 09:28:21 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6Az-000YdS-MZ; Sun, 17 Oct 2021 16:26:10 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:25:57 +0300
Message-Id: <iwlwifi.20211017162352.a28e7a92f558.I19f72735c674f815c6e7c11cecfad6230b4510ef@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017132604.480251-1-luca@coelho.fi>
References: <20211017132604.480251-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/12] iwlwifi: mvm: Support new TX_RSP and COMPRESSED_BA_RES versions
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

As part of the new rate_n_flags, a new version of this
structures was added in the FW. Add support for this new
version and for the new rate_n_flags in this API.
Both these APIs were updated in one patch since they are
using the same functions.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  5 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 89 +++++++++++++++----
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 15 ++++
 5 files changed, 99 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index fd7f577c525b..b7090ae95cfb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -593,7 +593,8 @@ struct iwl_mvm_tx_resp {
 	__le16 tx_queue;
 	__le16 reserved2;
 	struct agg_tx_status status;
-} __packed; /* TX_RSP_API_S_VER_6 */
+} __packed; /* TX_RSP_API_S_VER_6,
+	       TX_RSP_API_S_VER_7 */
 
 /**
  * struct iwl_mvm_ba_notif - notifies about reception of BA
@@ -717,7 +718,8 @@ struct iwl_mvm_compressed_ba_notif {
 	__le16 ra_tid_cnt;
 	struct iwl_mvm_compressed_ba_ratid ra_tid[0];
 	struct iwl_mvm_compressed_ba_tfd tfd[];
-} __packed; /* COMPRESSED_BA_RES_API_S_VER_4 */
+} __packed; /* COMPRESSED_BA_RES_API_S_VER_4,
+	       COMPRESSED_BA_RES_API_S_VER_5 */
 
 /**
  * struct iwl_mac_beacon_cmd_v6 - beacon template command
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index eea6de5f56c8..cc11961b0d83 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1443,11 +1443,16 @@ int __iwl_mvm_mac_start(struct iwl_mvm *mvm);
 int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm);
 
 /* Utils */
+int iwl_mvm_legacy_hw_idx_to_mac80211_idx(u32 rate_n_flags,
+					  enum nl80211_band band);
 int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 					enum nl80211_band band);
 void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 			       enum nl80211_band band,
 			       struct ieee80211_tx_rate *r);
+void iwl_mvm_hwrate_to_tx_rate_v1(u32 rate_n_flags,
+				  enum nl80211_band band,
+				  struct ieee80211_tx_rate *r);
 u8 iwl_mvm_mac80211_idx_to_hwrate(const struct iwl_fw *fw, int rate_idx);
 u8 iwl_mvm_mac80211_ac_to_ucode_ac(enum ieee80211_ac_numbers ac);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 88b5969d7b51..f4d02f9fe16d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -2692,8 +2692,8 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 		return;
 
 	lq_sta = mvm_sta;
-	iwl_mvm_hwrate_to_tx_rate(lq_sta->last_rate_n_flags,
-				  info->band, &info->control.rates[0]);
+	iwl_mvm_hwrate_to_tx_rate_v1(lq_sta->last_rate_n_flags,
+				     info->band, &info->control.rates[0]);
 	info->control.rates[0].count = 1;
 
 	/* Report the optimal rate based on rssi and STA caps if we haven't
@@ -2703,8 +2703,8 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 		optimal_rate = rs_get_optimal_rate(mvm, lq_sta);
 		last_ucode_rate = ucode_rate_from_rs_rate(mvm,
 							  optimal_rate);
-		iwl_mvm_hwrate_to_tx_rate(last_ucode_rate, info->band,
-					  &txrc->reported_rate);
+		iwl_mvm_hwrate_to_tx_rate_v1(last_ucode_rate, info->band,
+					     &txrc->reported_rate);
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index aa1797139f7c..4cc543fb9596 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1292,25 +1292,66 @@ const char *iwl_mvm_get_tx_fail_reason(u32 status)
 }
 #endif /* CONFIG_IWLWIFI_DEBUG */
 
-void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
-			       enum nl80211_band band,
-			       struct ieee80211_tx_rate *r)
+static int iwl_mvm_get_hwrate_chan_width(u32 chan_width)
 {
-	if (rate_n_flags & RATE_HT_MCS_GF_MSK)
-		r->flags |= IEEE80211_TX_RC_GREEN_FIELD;
-	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK_V1) {
+	switch (chan_width) {
 	case RATE_MCS_CHAN_WIDTH_20:
-		break;
+		return 0;
 	case RATE_MCS_CHAN_WIDTH_40:
-		r->flags |= IEEE80211_TX_RC_40_MHZ_WIDTH;
-		break;
+		return IEEE80211_TX_RC_40_MHZ_WIDTH;
 	case RATE_MCS_CHAN_WIDTH_80:
-		r->flags |= IEEE80211_TX_RC_80_MHZ_WIDTH;
-		break;
+		return IEEE80211_TX_RC_80_MHZ_WIDTH;
 	case RATE_MCS_CHAN_WIDTH_160:
-		r->flags |= IEEE80211_TX_RC_160_MHZ_WIDTH;
-		break;
+		return IEEE80211_TX_RC_160_MHZ_WIDTH;
+	default:
+		return 0;
+	}
+}
+
+void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
+			       enum nl80211_band band,
+			       struct ieee80211_tx_rate *r)
+{
+	u32 format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
+	u32 rate = format == RATE_MCS_HT_MSK ?
+		RATE_HT_MCS_INDEX(rate_n_flags) :
+		rate_n_flags & RATE_MCS_CODE_MSK;
+
+	r->flags |=
+		iwl_mvm_get_hwrate_chan_width(rate_n_flags &
+					      RATE_MCS_CHAN_WIDTH_MSK);
+
+	if (rate_n_flags & RATE_MCS_SGI_MSK)
+		r->flags |= IEEE80211_TX_RC_SHORT_GI;
+	if (format ==  RATE_MCS_HT_MSK) {
+		r->flags |= IEEE80211_TX_RC_MCS;
+		r->idx = rate;
+	} else if (format ==  RATE_MCS_VHT_MSK) {
+		ieee80211_rate_set_vht(r, rate,
+				       ((rate_n_flags & RATE_MCS_NSS_MSK) >>
+					RATE_MCS_NSS_POS) + 1);
+		r->flags |= IEEE80211_TX_RC_VHT_MCS;
+	} else if (format == RATE_MCS_HE_MSK) {
+		/* mac80211 cannot do this without ieee80211_tx_status_ext()
+		 * but it only matters for radiotap */
+		r->idx = 0;
+	} else {
+		r->idx = iwl_mvm_legacy_hw_idx_to_mac80211_idx(rate_n_flags,
+							       band);
 	}
+}
+
+void iwl_mvm_hwrate_to_tx_rate_v1(u32 rate_n_flags,
+				  enum nl80211_band band,
+				  struct ieee80211_tx_rate *r)
+{
+	if (rate_n_flags & RATE_HT_MCS_GF_MSK)
+		r->flags |= IEEE80211_TX_RC_GREEN_FIELD;
+
+	r->flags |=
+		iwl_mvm_get_hwrate_chan_width(rate_n_flags &
+					      RATE_MCS_CHAN_WIDTH_MSK_V1);
+
 	if (rate_n_flags & RATE_MCS_SGI_MSK_V1)
 		r->flags |= IEEE80211_TX_RC_SHORT_GI;
 	if (rate_n_flags & RATE_MCS_HT_MSK_V1) {
@@ -1331,14 +1372,20 @@ void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 /*
  * translate ucode response to mac80211 tx status control values
  */
-static void iwl_mvm_hwrate_to_tx_status(u32 rate_n_flags,
+static void iwl_mvm_hwrate_to_tx_status(const struct iwl_fw *fw,
+					u32 rate_n_flags,
 					struct ieee80211_tx_info *info)
 {
 	struct ieee80211_tx_rate *r = &info->status.rates[0];
 
+	if (iwl_fw_lookup_notif_ver(fw, LONG_GROUP,
+				    TX_CMD, 0) > 6)
+		rate_n_flags = iwl_new_rate_from_v1(rate_n_flags);
+
 	info->status.antenna =
 		((rate_n_flags & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS);
-	iwl_mvm_hwrate_to_tx_rate(rate_n_flags, info->band, r);
+	iwl_mvm_hwrate_to_tx_rate(rate_n_flags,
+				  info->band, r);
 }
 
 static void iwl_mvm_tx_status_check_trigger(struct iwl_mvm *mvm,
@@ -1480,8 +1527,14 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 		iwl_mvm_tx_status_check_trigger(mvm, status, hdr->frame_control);
 
 		info->status.rates[0].count = tx_resp->failure_frame + 1;
-		iwl_mvm_hwrate_to_tx_status(le32_to_cpu(tx_resp->initial_rate),
+
+		iwl_mvm_hwrate_to_tx_status(mvm->fw,
+					    le32_to_cpu(tx_resp->initial_rate),
 					    info);
+
+		/* Don't assign the converted initial_rate, because driver
+		 * TLC uses this and doesn't support the new FW rate
+		 */
 		info->status.status_driver_data[1] =
 			(void *)(uintptr_t)le32_to_cpu(tx_resp->initial_rate);
 
@@ -1843,7 +1896,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			info->flags |= IEEE80211_TX_STAT_AMPDU;
 			memcpy(&info->status, &tx_info->status,
 			       sizeof(tx_info->status));
-			iwl_mvm_hwrate_to_tx_status(rate, info);
+			iwl_mvm_hwrate_to_tx_status(mvm->fw, rate, info);
 		}
 	}
 
@@ -1864,7 +1917,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			goto out;
 
 		tx_info->band = chanctx_conf->def.chan->band;
-		iwl_mvm_hwrate_to_tx_status(rate, tx_info);
+		iwl_mvm_hwrate_to_tx_status(mvm->fw, rate, tx_info);
 
 		if (!iwl_mvm_has_tlc_offload(mvm)) {
 			IWL_DEBUG_TX_REPLY(mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 11f51a421a3d..caf1dcf48888 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -135,6 +135,21 @@ int iwl_mvm_send_cmd_pdu_status(struct iwl_mvm *mvm, u32 id, u16 len,
 	return iwl_mvm_send_cmd_status(mvm, &cmd, status);
 }
 
+int iwl_mvm_legacy_hw_idx_to_mac80211_idx(u32 rate_n_flags,
+					  enum nl80211_band band)
+{
+	int format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
+	int rate = rate_n_flags & RATE_LEGACY_RATE_MSK;
+	bool is_LB = band == NL80211_BAND_2GHZ;
+
+	if (format == RATE_MCS_LEGACY_OFDM_MSK)
+		return is_LB ? rate + IWL_FIRST_OFDM_RATE :
+			rate;
+
+	/* CCK is not allowed in HB */
+	return is_LB ? rate : -1;
+}
+
 int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 					enum nl80211_band band)
 {
-- 
2.33.0

