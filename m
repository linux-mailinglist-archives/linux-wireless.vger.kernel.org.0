Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213D34B563B
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356384AbiBNQaU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:30:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356374AbiBNQaT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:30:19 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD8260ABD
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6itVcV3zIC27rLMqrnzCRFsAyHKbGNABhcoUdUzjgIc=;
        t=1644856211; x=1646065811; b=VFi1gp9/afv2B++BL+CKtCEd+yfUUV3jmntZnxQTPwAPgnN
        1gypPdOs5j2aXMKh0CAfjaJyjXgsZFC0eNS34Z6SpKsWXekfvsc/+sFpA1GWh70AQlOUH+YxNGY63
        6QuyZ1xPakQy6VcgQG+Jt2Cbf+RLr5PzN1JANeA4Cda9LLcBGVq1RUaN4h3mKBouR/NU6VRhMNXI9
        pHMN8U5nA+Ag85DxLs8BZITQlG6v8lWyEFUmns3ToY+1zSKACI1ROVykajp9ENdiaK4wJh9gjHHOl
        7JIUG4uVA4Ad11WW7f46VOXPl30GPQZ9PRjWp+1L7BH6oWfMv4igBW2uKbW+Qb0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEr-0011mw-IB;
        Mon, 14 Feb 2022 17:30:09 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Mordechay Goodstein <mordechay.goodstein@intel.com>
Subject: [PATCH v3 05/19] ieee80211: add EHT 1K aggregation definitions
Date:   Mon, 14 Feb 2022 17:29:52 +0100
Message-Id: <20220214173004.b8b447ce95b7.I0ee2554c94e89abc7a752b0f7cc7fd79c273efea@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
References: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
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

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

We add the fields for parsing extended ADDBA request/respond,
and new max 1K aggregation for limit ADDBA request/respond.

Adjust drivers to use the proper macro, IEEE80211_MAX_AMPDU_BUF ->
IEEE80211_MAX_AMPDU_BUF_HE.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath11k/mac.c            | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c     | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 4 ++--
 include/linux/ieee80211.h                        | 6 +++++-
 net/mac80211/agg-rx.c                            | 2 +-
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 90fcd6adf2d5..bd40f4c1183a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8448,7 +8448,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ar->hw->queues = ATH11K_HW_MAX_QUEUES;
 	ar->hw->wiphy->tx_queue_len = ATH11K_QUEUE_LEN;
 	ar->hw->offchannel_tx_hw_queue = ATH11K_HW_MAX_QUEUES - 1;
-	ar->hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
+	ar->hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 
 	ar->hw->vif_data_size = sizeof(struct ath11k_vif);
 	ar->hw->sta_data_size = sizeof(struct ath11k_sta);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 87630d38dc52..5da9d98043fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1077,12 +1077,12 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	if (!hw)
 		return NULL;
 
-	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
+	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 
 	if (cfg->max_tx_agg_size)
 		hw->max_tx_aggregation_subframes = cfg->max_tx_agg_size;
 	else
-		hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
+		hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 
 	op_mode = hw->priv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 705f362b8f7b..4cf299ea11f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -311,8 +311,8 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	struct mt7915_dev *dev = phy->dev;
 
 	hw->queues = 4;
-	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
-	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
+	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
+	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 	hw->netdev_features = NETIF_F_RXCSUM;
 
 	hw->radiotap_timestamp.units_pos =
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 7204bc28ca31..a4143466cb32 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1024,6 +1024,8 @@ struct ieee80211_tpc_report_ie {
 #define IEEE80211_ADDBA_EXT_FRAG_LEVEL_MASK	GENMASK(2, 1)
 #define IEEE80211_ADDBA_EXT_FRAG_LEVEL_SHIFT	1
 #define IEEE80211_ADDBA_EXT_NO_FRAG		BIT(0)
+#define IEEE80211_ADDBA_EXT_BUF_SIZE_MASK	GENMASK(7, 5)
+#define IEEE80211_ADDBA_EXT_BUF_SIZE_SHIFT	10
 
 struct ieee80211_addba_ext_ie {
 	u8 data;
@@ -1698,10 +1700,12 @@ struct ieee80211_ht_operation {
  * A-MPDU buffer sizes
  * According to HT size varies from 8 to 64 frames
  * HE adds the ability to have up to 256 frames.
+ * EHT adds the ability to have up to 1K frames.
  */
 #define IEEE80211_MIN_AMPDU_BUF		0x8
 #define IEEE80211_MAX_AMPDU_BUF_HT	0x40
-#define IEEE80211_MAX_AMPDU_BUF		0x100
+#define IEEE80211_MAX_AMPDU_BUF_HE	0x100
+#define IEEE80211_MAX_AMPDU_BUF_EHT	0x400
 
 
 /* Spatial Multiplexing Power Save Modes (for capability) */
diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 7d2925bb966e..0d2bab9d351c 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -310,7 +310,7 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 	}
 
 	if (sta->sta.he_cap.has_he)
-		max_buf_size = IEEE80211_MAX_AMPDU_BUF;
+		max_buf_size = IEEE80211_MAX_AMPDU_BUF_HE;
 	else
 		max_buf_size = IEEE80211_MAX_AMPDU_BUF_HT;
 
-- 
2.34.1

