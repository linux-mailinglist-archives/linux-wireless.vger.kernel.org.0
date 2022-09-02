Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D255AB436
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiIBOvw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbiIBOvI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1E6C6FD7
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5sk+Itf1fnEMKszgG7vP2dkjPuQYah+bA9RumNHZLzI=;
        t=1662127993; x=1663337593; b=h1JvJD49ejdAyzlNVZe4Fch2wORnL/rZ1DoLETmCd9nrCle
        rKvihSb+yPiVJ0W+U3sj+kM/1nLtV8sPXgJg1UeR1X59POFpcfD299aHJgXzFlp2ktny3CNPNsRGd
        59Y+GNgq0m6weyvnJ06BUfiROaNcTHEelTKrCaopEtRhLbHwocBsR52bIdV2K0fDbq7CqLmRL42lv
        vBPfSw9wVS4Qh8fqs22romPOHmP1CDtkqtRFNbGNm5Jx/3rZAO5WaAK+nAbJgo8yWvbNOhOcCD/bM
        2mT6GnzDHP7Zs6z357aoVwq6pIofbMmIqZwo4/2f33wt/IOIQnnMLODrz060lFbw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Pz-006Ch3-0R;
        Fri, 02 Sep 2022 16:13:11 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 22/27] wifi: mac80211: keep A-MSDU data in sta and per-link
Date:   Fri,  2 Sep 2022 16:12:54 +0200
Message-Id: <20220902161143.37f209bdbe55.I997eff261b7279f54c9e39b848160aa59c0fccd2@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

The A-MSDU data needs to be stored per-link and aggregated into a single
value for the station. Add a new struct ieee_80211_sta_aggregates in
order to store this data and a new function
ieee80211_sta_recalc_aggregates to update the current data for the STA.

Note that in the non MLO case the pointer in ieee80211_sta will directly
reference the data in deflink.agg, which means that recalculation may be
skipped in that case.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 14 ++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 12 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   | 15 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  2 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  4 +-
 drivers/net/wireless/realtek/rtw88/fw.c       |  2 +-
 drivers/net/wireless/realtek/rtw89/debug.c    |  2 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  4 +-
 include/net/mac80211.h                        | 68 +++++++++++++------
 net/mac80211/he.c                             |  8 ++-
 net/mac80211/ht.c                             |  6 +-
 net/mac80211/rc80211_minstrel_ht.c            |  3 +-
 net/mac80211/sta_info.c                       | 50 +++++++++++++-
 net/mac80211/sta_info.h                       |  3 +
 net/mac80211/tx.c                             | 10 +--
 net/mac80211/vht.c                            |  8 ++-
 18 files changed, 152 insertions(+), 65 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index c0bd697b080a..1e8123140973 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -430,14 +430,16 @@ static ssize_t iwl_dbgfs_amsdu_len_write(struct ieee80211_sta *sta,
 		return -EBUSY;
 
 	if (amsdu_len) {
-		mvmsta->orig_amsdu_len = sta->max_amsdu_len;
-		sta->max_amsdu_len = amsdu_len;
-		for (i = 0; i < ARRAY_SIZE(sta->max_tid_amsdu_len); i++)
-			sta->max_tid_amsdu_len[i] = amsdu_len;
+		mvmsta->orig_amsdu_len = sta->cur->max_amsdu_len;
+		sta->deflink.agg.max_amsdu_len = amsdu_len;
+		sta->deflink.agg.max_amsdu_len = amsdu_len;
+		for (i = 0; i < ARRAY_SIZE(sta->deflink.agg.max_tid_amsdu_len); i++)
+			sta->deflink.agg.max_tid_amsdu_len[i] = amsdu_len;
 	} else {
-		sta->max_amsdu_len = mvmsta->orig_amsdu_len;
+		sta->deflink.agg.max_amsdu_len = mvmsta->orig_amsdu_len;
 		mvmsta->orig_amsdu_len = 0;
 	}
+
 	return count;
 }
 
@@ -451,7 +453,7 @@ static ssize_t iwl_dbgfs_amsdu_len_read(struct file *file,
 	char buf[32];
 	int pos;
 
-	pos = scnprintf(buf, sizeof(buf), "current %d ", sta->max_amsdu_len);
+	pos = scnprintf(buf, sizeof(buf), "current %d ", sta->cur->max_amsdu_len);
 	pos += scnprintf(buf + pos, sizeof(buf) - pos, "stored %d\n",
 			 mvmsta->orig_amsdu_len);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5eb28f8ee87e..df0793882f1d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3193,7 +3193,7 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 						   NL80211_TDLS_SETUP);
 		}
 
-		sta->max_rc_amsdu_len = 1;
+		sta->deflink.agg.max_rc_amsdu_len = 1;
 	} else if (old_state == IEEE80211_STA_NONE &&
 		   new_state == IEEE80211_STA_AUTH) {
 		/*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 752d44d96163..2e9081cb6627 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -340,9 +340,9 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 		u16 size = le32_to_cpu(notif->amsdu_size);
 		int i;
 
-		if (sta->max_amsdu_len < size) {
+		if (sta->deflink.agg.max_amsdu_len < size) {
 			/*
-			 * In debug sta->max_amsdu_len < size
+			 * In debug sta->deflink.agg.max_amsdu_len < size
 			 * so also check with orig_amsdu_len which holds the
 			 * original data before debugfs changed the value
 			 */
@@ -352,18 +352,18 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 
 		mvmsta->amsdu_enabled = le32_to_cpu(notif->amsdu_enabled);
 		mvmsta->max_amsdu_len = size;
-		sta->max_rc_amsdu_len = mvmsta->max_amsdu_len;
+		sta->deflink.agg.max_rc_amsdu_len = mvmsta->max_amsdu_len;
 
 		for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
 			if (mvmsta->amsdu_enabled & BIT(i))
-				sta->max_tid_amsdu_len[i] =
+				sta->deflink.agg.max_tid_amsdu_len[i] =
 					iwl_mvm_max_amsdu_size(mvm, sta, i);
 			else
 				/*
 				 * Not so elegant, but this will effectively
 				 * prevent AMSDU on this TID
 				 */
-				sta->max_tid_amsdu_len[i] = 1;
+				sta->deflink.agg.max_tid_amsdu_len[i] = 1;
 		}
 
 		IWL_DEBUG_RATE(mvm,
@@ -450,7 +450,7 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	 * since TLC offload works with one mode we can assume
 	 * that only vht/ht is used and also set it as station max amsdu
 	 */
-	sta->max_amsdu_len = max_amsdu_len;
+	sta->deflink.agg.max_amsdu_len = max_amsdu_len;
 
 	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
 					WIDE_ID(DATA_PATH_GROUP,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 814a5e8f3666..0b50b816684a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1491,7 +1491,7 @@ static void rs_set_amsdu_len(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	int i;
 
-	sta->max_amsdu_len = rs_fw_get_max_amsdu_len(sta);
+	sta->deflink.agg.max_amsdu_len = rs_fw_get_max_amsdu_len(sta);
 
 	/*
 	 * In case TLC offload is not active amsdu_enabled is either 0xFFFF
@@ -1506,22 +1506,23 @@ static void rs_set_amsdu_len(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 
 	if (mvmsta->vif->bss_conf.he_support &&
 	    !iwlwifi_mod_params.disable_11ax)
-		mvmsta->max_amsdu_len = sta->max_amsdu_len;
+		mvmsta->max_amsdu_len = sta->deflink.agg.max_amsdu_len;
 	else
-		mvmsta->max_amsdu_len = min_t(int, sta->max_amsdu_len, 8500);
+		mvmsta->max_amsdu_len =
+			min_t(int, sta->deflink.agg.max_amsdu_len, 8500);
 
-	sta->max_rc_amsdu_len = mvmsta->max_amsdu_len;
+	sta->deflink.agg.max_rc_amsdu_len = mvmsta->max_amsdu_len;
 
 	for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
 		if (mvmsta->amsdu_enabled)
-			sta->max_tid_amsdu_len[i] =
+			sta->deflink.agg.max_tid_amsdu_len[i] =
 				iwl_mvm_max_amsdu_size(mvm, sta, i);
 		else
 			/*
 			 * Not so elegant, but this will effectively
 			 * prevent AMSDU on this TID
 			 */
-			sta->max_tid_amsdu_len[i] = 1;
+			sta->deflink.agg.max_tid_amsdu_len[i] = 1;
 	}
 }
 
@@ -2933,7 +2934,7 @@ static void rs_drv_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 
 	lq_sta->lq.sta_id = mvmsta->sta_id;
 	mvmsta->amsdu_enabled = 0;
-	mvmsta->max_amsdu_len = sta->max_amsdu_len;
+	mvmsta->max_amsdu_len = sta->cur->max_amsdu_len;
 
 	for (j = 0; j < LQ_SIZE; j++)
 		rs_rate_scale_clear_tbl_windows(mvm, &lq_sta->lq_info[j]);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index f9e08b339e0c..86d20e13bf47 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -926,7 +926,7 @@ static int iwl_mvm_tx_tso(struct iwl_mvm *mvm, struct sk_buff *skb,
 	 * Take the min of ieee80211 station and mvm station
 	 */
 	max_amsdu_len =
-		min_t(unsigned int, sta->max_amsdu_len,
+		min_t(unsigned int, sta->cur->max_amsdu_len,
 		      iwl_mvm_max_amsdu_size(mvm, sta, tid));
 
 	/*
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 5c4ca93bcf91..a54af6bc3251 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -594,14 +594,14 @@ mt76_connac_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	    vif->type != NL80211_IFTYPE_STATION)
 		return;
 
-	if (!sta->max_amsdu_len)
+	if (!sta->deflink.agg.max_amsdu_len)
 		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HW_AMSDU, sizeof(*amsdu));
 	amsdu = (struct sta_rec_amsdu *)tlv;
 	amsdu->max_amsdu_num = 8;
 	amsdu->amsdu_en = true;
-	amsdu->max_mpdu_size = sta->max_amsdu_len >=
+	amsdu->max_mpdu_size = sta->deflink.agg.max_amsdu_len >=
 			       IEEE80211_MAX_MPDU_LEN_VHT_7991;
 
 	wcid->amsdu = true;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 1081b893f319..d1dc6efba457 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -925,7 +925,7 @@ mt7915_mcu_sta_amsdu_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	    vif->type != NL80211_IFTYPE_AP)
 		return;
 
-	if (!sta->max_amsdu_len)
+	if (!sta->deflink.agg.max_amsdu_len)
 	    return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HW_AMSDU, sizeof(*amsdu));
@@ -934,7 +934,7 @@ mt7915_mcu_sta_amsdu_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	amsdu->amsdu_en = true;
 	msta->wcid.amsdu = true;
 
-	switch (sta->max_amsdu_len) {
+	switch (sta->deflink.agg.max_amsdu_len) {
 	case IEEE80211_MAX_MPDU_LEN_VHT_11454:
 		if (!is_mt7915(&dev->mt76)) {
 			amsdu->max_mpdu_size =
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 7f6fdebae203..0b5f903c0f36 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -118,7 +118,7 @@ static void rtw_fw_ra_report_iter(void *data, struct ieee80211_sta *sta)
 	si->ra_report.desc_rate = rate;
 	si->ra_report.bit_rate = bit_rate;
 
-	sta->max_rc_amsdu_len = get_max_amsdu_len(bit_rate);
+	sta->deflink.agg.max_rc_amsdu_len = get_max_amsdu_len(bit_rate);
 }
 
 static void rtw_fw_ra_report_handle(struct rtw_dev *rtwdev, u8 *payload,
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 738cfcd6fd32..9117b6168e32 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2309,7 +2309,7 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	seq_printf(m, "%s", rtwsta->ra_report.might_fallback_legacy ? " FB_G" : "");
 	seq_printf(m, "\t(hw_rate=0x%x)", rtwsta->ra_report.hw_rate);
 	seq_printf(m, "\t==> agg_wait=%d (%d)\n", rtwsta->max_agg_wait,
-		   sta->max_rc_amsdu_len);
+		   sta->deflink.agg.max_rc_amsdu_len);
 
 	seq_printf(m, "RX rate [%d]: ", rtwsta->mac_id);
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 4dfeedeb0d90..a2ebef0051b8 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2031,8 +2031,8 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 	ra_report->hw_rate = FIELD_PREP(RTW89_HW_RATE_MASK_MOD, mode) |
 			     FIELD_PREP(RTW89_HW_RATE_MASK_VAL, rate);
 	ra_report->might_fallback_legacy = mcs <= 2;
-	sta->max_rc_amsdu_len = get_max_amsdu_len(rtwdev, ra_report);
-	rtwsta->max_agg_wait = sta->max_rc_amsdu_len / 1500 - 1;
+	sta->deflink.agg.max_rc_amsdu_len = get_max_amsdu_len(rtwdev, ra_report);
+	rtwsta->max_agg_wait = sta->deflink.agg.max_rc_amsdu_len / 1500 - 1;
 }
 
 static void
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d9e7f62cc972..873e81a45a97 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2143,6 +2143,34 @@ struct ieee80211_sta_txpwr {
 	enum nl80211_tx_power_setting type;
 };
 
+/**
+ * struct ieee80211_sta_aggregates - info that is aggregated from active links
+ *
+ * Used for any per-link data that needs to be aggregated and updated in the
+ * main &struct ieee80211_sta when updated or the active links change.
+ *
+ * @max_amsdu_len: indicates the maximal length of an A-MSDU in bytes.
+ *	This field is always valid for packets with a VHT preamble.
+ *	For packets with a HT preamble, additional limits apply:
+ *
+ *	* If the skb is transmitted as part of a BA agreement, the
+ *	  A-MSDU maximal size is min(max_amsdu_len, 4065) bytes.
+ *	* If the skb is not part of a BA agreement, the A-MSDU maximal
+ *	  size is min(max_amsdu_len, 7935) bytes.
+ *
+ * Both additional HT limits must be enforced by the low level
+ * driver. This is defined by the spec (IEEE 802.11-2012 section
+ * 8.3.2.2 NOTE 2).
+ * @max_rc_amsdu_len: Maximum A-MSDU size in bytes recommended by rate control.
+ * @max_tid_amsdu_len: Maximum A-MSDU size in bytes for this TID
+ */
+struct ieee80211_sta_aggregates {
+	u16 max_amsdu_len;
+
+	u16 max_rc_amsdu_len;
+	u16 max_tid_amsdu_len[IEEE80211_NUM_TIDS];
+};
+
 /**
  * struct ieee80211_link_sta - station Link specific info
  * All link specific info for a STA link for a non MLD STA(single)
@@ -2179,6 +2207,8 @@ struct ieee80211_link_sta {
 	struct ieee80211_he_6ghz_capa he_6ghz_capa;
 	struct ieee80211_sta_eht_cap eht_cap;
 
+	struct ieee80211_sta_aggregates agg;
+
 	u8 rx_nss;
 	enum ieee80211_sta_rx_bandwidth bandwidth;
 	struct ieee80211_sta_txpwr txpwr;
@@ -2218,9 +2248,10 @@ struct ieee80211_link_sta {
  * @max_amsdu_subframes: indicates the maximal number of MSDUs in a single
  *	A-MSDU. Taken from the Extended Capabilities element. 0 means
  *	unlimited.
+ * @cur: currently valid data as aggregated from the active links
+ *	For non MLO STA it will point to the deflink data. For MLO STA
+ *	ieee80211_sta_recalc_aggregates() must be called to update it.
  * @support_p2p_ps: indicates whether the STA supports P2P PS mechanism or not.
- * @max_rc_amsdu_len: Maximum A-MSDU size in bytes recommended by rate control.
- * @max_tid_amsdu_len: Maximum A-MSDU size in bytes for this TID
  * @txq: per-TID data TX queues (if driver uses the TXQ abstraction); note that
  *	the last entry (%IEEE80211_NUM_TIDS) is used for non-data frames
  * @deflink: This holds the default link STA information, for non MLO STA all link
@@ -2250,25 +2281,9 @@ struct ieee80211_sta {
 	bool mlo;
 	u8 max_amsdu_subframes;
 
-	/**
-	 * @max_amsdu_len:
-	 * indicates the maximal length of an A-MSDU in bytes.
-	 * This field is always valid for packets with a VHT preamble.
-	 * For packets with a HT preamble, additional limits apply:
-	 *
-	 * * If the skb is transmitted as part of a BA agreement, the
-	 *   A-MSDU maximal size is min(max_amsdu_len, 4065) bytes.
-	 * * If the skb is not part of a BA agreement, the A-MSDU maximal
-	 *   size is min(max_amsdu_len, 7935) bytes.
-	 *
-	 * Both additional HT limits must be enforced by the low level
-	 * driver. This is defined by the spec (IEEE 802.11-2012 section
-	 * 8.3.2.2 NOTE 2).
-	 */
-	u16 max_amsdu_len;
+	struct ieee80211_sta_aggregates *cur;
+
 	bool support_p2p_ps;
-	u16 max_rc_amsdu_len;
-	u16 max_tid_amsdu_len[IEEE80211_NUM_TIDS];
 
 	struct ieee80211_txq *txq[IEEE80211_NUM_TIDS + 1];
 
@@ -6105,6 +6120,19 @@ void ieee80211_sta_eosp(struct ieee80211_sta *pubsta);
  */
 void ieee80211_send_eosp_nullfunc(struct ieee80211_sta *pubsta, int tid);
 
+/**
+ * ieee80211_sta_recalc_aggregates - recalculate aggregate data after a change
+ * @pubsta: the station
+ *
+ * Call this function after changing a per-link aggregate data as referenced in
+ * &struct ieee80211_sta_aggregates by accessing the agg field of
+ * &struct ieee80211_link_sta.
+ *
+ * With non MLO the data in deflink will be referenced directly. In that case
+ * there is no need to call this function.
+ */
+void ieee80211_sta_recalc_aggregates(struct ieee80211_sta *pubsta);
+
 /**
  * ieee80211_sta_register_airtime - register airtime usage for a sta/tid
  *
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index e73899fd4bbb..729f261520c7 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -39,17 +39,19 @@ ieee80211_update_from_he_6ghz_capa(const struct ieee80211_he_6ghz_capa *he_6ghz_
 	switch (le16_get_bits(he_6ghz_capa->capa,
 			      IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN)) {
 	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
-		sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_11454;
+		link_sta->pub->agg.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_11454;
 		break;
 	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991:
-		sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_7991;
+		link_sta->pub->agg.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_7991;
 		break;
 	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895:
 	default:
-		sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_3895;
+		link_sta->pub->agg.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_3895;
 		break;
 	}
 
+	ieee80211_sta_recalc_aggregates(&sta->sta);
+
 	link_sta->pub->he_6ghz_capa = *he_6ghz_capa;
 }
 
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 12a233ba5031..83bc41346ae7 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -241,9 +241,11 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 	ht_cap.mcs.rx_highest = ht_cap_ie->mcs.rx_highest;
 
 	if (ht_cap.cap & IEEE80211_HT_CAP_MAX_AMSDU)
-		sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_HT_7935;
+		link_sta->pub->agg.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_HT_7935;
 	else
-		sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_HT_3839;
+		link_sta->pub->agg.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_HT_3839;
+
+	ieee80211_sta_recalc_aggregates(&sta->sta);
 
  apply:
 	changed = memcmp(&link_sta->pub->ht_cap, &ht_cap, sizeof(ht_cap));
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 8c41a545a8b7..24c3c055db6d 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1568,7 +1568,8 @@ minstrel_ht_update_rates(struct minstrel_priv *mp, struct minstrel_ht_sta *mi)
 	if (i < IEEE80211_TX_RATE_TABLE_SIZE)
 		rates->rate[i].idx = -1;
 
-	mi->sta->max_rc_amsdu_len = minstrel_ht_get_max_amsdu_len(mi);
+	mi->sta->deflink.agg.max_rc_amsdu_len = minstrel_ht_get_max_amsdu_len(mi);
+	ieee80211_sta_recalc_aggregates(mi->sta);
 	rate_control_set_rates(mp->hw, mi->sta, rates);
 }
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index baa55fbab0a2..4b702235b18d 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -376,6 +376,8 @@ static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 		sta_info_free_link(&alloc->info);
 		kfree_rcu(alloc, rcu_head);
 	}
+
+	ieee80211_sta_recalc_aggregates(&sta->sta);
 }
 
 /**
@@ -514,6 +516,7 @@ static void sta_info_add_link(struct sta_info *sta,
 	rcu_assign_pointer(sta->sta.link[link_id], link_sta);
 
 	link_sta->smps_mode = IEEE80211_SMPS_OFF;
+	link_sta->agg.max_rc_amsdu_len = IEEE80211_MAX_MPDU_LEN_HT_BA;
 }
 
 static struct sta_info *
@@ -544,6 +547,8 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 		sta_info_add_link(sta, 0, &sta->deflink, &sta->sta.deflink);
 	}
 
+	sta->sta.cur = &sta->sta.deflink.agg;
+
 	spin_lock_init(&sta->lock);
 	spin_lock_init(&sta->ps_lock);
 	INIT_WORK(&sta->drv_deliver_wk, sta_deliver_ps_frames);
@@ -667,8 +672,6 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	sta->sta.max_rc_amsdu_len = IEEE80211_MAX_MPDU_LEN_HT_BA;
-
 	sta->cparams.ce_threshold = CODEL_DISABLED_THRESHOLD;
 	sta->cparams.target = MS2TIME(20);
 	sta->cparams.interval = MS2TIME(100);
@@ -2124,6 +2127,44 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 }
 EXPORT_SYMBOL(ieee80211_sta_register_airtime);
 
+void ieee80211_sta_recalc_aggregates(struct ieee80211_sta *pubsta)
+{
+	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
+	struct ieee80211_link_sta *link_sta;
+	int link_id, i;
+	bool first = true;
+
+	if (!pubsta->valid_links || !pubsta->mlo) {
+		pubsta->cur = &pubsta->deflink.agg;
+		return;
+	}
+
+	rcu_read_lock();
+	for_each_sta_active_link(&sta->sdata->vif, pubsta, link_sta, link_id) {
+		if (first) {
+			sta->cur = pubsta->deflink.agg;
+			first = false;
+			continue;
+		}
+
+		sta->cur.max_amsdu_len =
+			min(sta->cur.max_amsdu_len,
+			    link_sta->agg.max_amsdu_len);
+		sta->cur.max_rc_amsdu_len =
+			min(sta->cur.max_rc_amsdu_len,
+			    link_sta->agg.max_rc_amsdu_len);
+
+		for (i = 0; i < ARRAY_SIZE(sta->cur.max_tid_amsdu_len); i++)
+			sta->cur.max_tid_amsdu_len[i] =
+				min(sta->cur.max_tid_amsdu_len[i],
+				    link_sta->agg.max_tid_amsdu_len[i]);
+	}
+	rcu_read_unlock();
+
+	pubsta->cur = &sta->cur;
+}
+EXPORT_SYMBOL(ieee80211_sta_recalc_aggregates);
+
 void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
 					  struct sta_info *sta, u8 ac,
 					  u16 tx_airtime, bool tx_completed)
@@ -2819,6 +2860,11 @@ int ieee80211_sta_activate_link(struct sta_info *sta, unsigned int link_id)
 	if (!test_sta_flag(sta, WLAN_STA_INSERTED))
 		goto hash;
 
+	/* Ensure the values are updated for the driver,
+	 * redone by sta_remove_link on failure.
+	 */
+	ieee80211_sta_recalc_aggregates(&sta->sta);
+
 	ret = drv_change_sta_links(sdata->local, sdata, &sta->sta,
 				   old_links, new_links);
 	if (ret) {
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 2eb3a9452e07..2517ea714dc4 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -622,6 +622,8 @@ struct link_sta_info {
  * @tdls_chandef: a TDLS peer can have a wider chandef that is compatible to
  *	the BSS one.
  * @frags: fragment cache
+ * @cur: storage for aggregation data
+ *	&struct ieee80211_sta points either here or to deflink.agg.
  * @deflink: This is the default link STA information, for non MLO STA all link
  *	specific STA information is accessed through @deflink or through
  *	link[0] which points to address of @deflink. For MLO Link STA
@@ -705,6 +707,7 @@ struct sta_info {
 
 	struct ieee80211_fragment_cache frags;
 
+	struct ieee80211_sta_aggregates cur;
 	struct link_sta_info deflink;
 	struct link_sta_info __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 30293e49e444..5d1c6853c008 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3387,7 +3387,7 @@ static bool ieee80211_amsdu_aggregate(struct ieee80211_sub_if_data *sdata,
 	int subframe_len = skb->len - ETH_ALEN;
 	u8 max_subframes = sta->sta.max_amsdu_subframes;
 	int max_frags = local->hw.max_tx_fragments;
-	int max_amsdu_len = sta->sta.max_amsdu_len;
+	int max_amsdu_len = sta->sta.cur->max_amsdu_len;
 	int orig_truesize;
 	u32 flow_idx;
 	__be16 len;
@@ -3413,13 +3413,13 @@ static bool ieee80211_amsdu_aggregate(struct ieee80211_sub_if_data *sdata,
 	if (test_bit(IEEE80211_TXQ_NO_AMSDU, &txqi->flags))
 		return false;
 
-	if (sta->sta.max_rc_amsdu_len)
+	if (sta->sta.cur->max_rc_amsdu_len)
 		max_amsdu_len = min_t(int, max_amsdu_len,
-				      sta->sta.max_rc_amsdu_len);
+				      sta->sta.cur->max_rc_amsdu_len);
 
-	if (sta->sta.max_tid_amsdu_len[tid])
+	if (sta->sta.cur->max_tid_amsdu_len[tid])
 		max_amsdu_len = min_t(int, max_amsdu_len,
-				      sta->sta.max_tid_amsdu_len[tid]);
+				      sta->sta.cur->max_tid_amsdu_len[tid]);
 
 	flow_idx = fq_flow_idx(fq, skb);
 
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index b2b09d421e8b..803de5881485 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -323,16 +323,18 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 	 */
 	switch (vht_cap->cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK) {
 	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
-		link_sta->sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_11454;
+		link_sta->pub->agg.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_11454;
 		break;
 	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991:
-		link_sta->sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_7991;
+		link_sta->pub->agg.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_7991;
 		break;
 	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895:
 	default:
-		link_sta->sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_3895;
+		link_sta->pub->agg.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_3895;
 		break;
 	}
+
+	ieee80211_sta_recalc_aggregates(&link_sta->sta->sta);
 }
 
 /* FIXME: move this to some better location - parses HE/EHT now */
-- 
2.37.2

