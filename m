Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC8372E5D7
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbjFMOek (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 10:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242930AbjFMOeL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 10:34:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10012E54
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 07:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C4E16372C
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 14:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF85C433D9;
        Tue, 13 Jun 2023 14:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686666849;
        bh=TKLRay97wwCmfkhvGA9DMawDL764bJZWMZ2Z6M9KKXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qId/BWXG6xCM+TYvjp2eRkvOV7U53oRQzmNE99w2TIm4zkaiHmFiNe269C/9DJENv
         Ed93zxGr356xeSO8k5kdgwzCaPjFG2i6Jw+mU8Ty+c/d1QmjkiMqURmUeJaxG52d+t
         w0ThrQgWpq1sfxy+x39CzbnCy4Fz1Lnt7BYWil62nevpwdlfpXVUIKDW4FChscoB4q
         R3yvYEi3zC0n+PjSSvJcqg9rf5bSDxjwVdl18/ZvJI5OAUXn9HVEo2jRwrWGh6OGH2
         ZusWTT+Gg0EsLZwo5DCc/Q8+DJNimzJWRLNOeU20Z+CcO9+OQHPO8pebKmoVwWSFfv
         ETWEcYp6e5BAg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        shayne.chen@mediatek.com, ryder.lee@mediatek.com,
        deren.wu@mediatek.com
Subject: [PATCH v3 13/15] wifi: mt76: move rate info in mt76_vif
Date:   Tue, 13 Jun 2023 16:32:41 +0200
Message-Id: <7d23272a4d2d85e36525d6c3451b97598ffa148a.1686664917.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686664917.git.lorenzo@kernel.org>
References: <cover.1686664917.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to introduce mt76_connac3 mac library used
by WiFi7 chipsets (e.g. mt7996).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h          |  3 +++
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 10 +++++-----
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 10 +++++-----
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  4 ----
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 878cebb8a4e9..d14844d7c5bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -705,6 +705,9 @@ struct mt76_vif {
 	u8 wmm_idx;
 	u8 scan_seq_num;
 	u8 cipher;
+	u8 basic_rates_idx;
+	u8 mcast_rates_idx;
+	u8 beacon_rates_idx;
 };
 
 struct mt76_phy {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 753e9c7b1199..e407fc547e42 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1008,7 +1008,7 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	u8 band_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
-	struct mt7996_vif *mvif;
+	struct mt76_vif *mvif;
 	u16 tx_count = 15;
 	u32 val;
 	bool beacon = !!(changed & (BSS_CHANGED_BEACON |
@@ -1016,11 +1016,11 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
 					 BSS_CHANGED_FILS_DISCOVERY));
 
-	mvif = vif ? (struct mt7996_vif *)vif->drv_priv : NULL;
+	mvif = vif ? (struct mt76_vif *)vif->drv_priv : NULL;
 	if (mvif) {
-		omac_idx = mvif->mt76.omac_idx;
-		wmm_idx = mvif->mt76.wmm_idx;
-		band_idx = mvif->mt76.band_idx;
+		omac_idx = mvif->omac_idx;
+		wmm_idx = mvif->wmm_idx;
+		band_idx = mvif->band_idx;
 	}
 
 	if (inband_disc) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 2d20de7c8916..ee9e409b8eb9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -221,9 +221,9 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
 
 	if (phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
-		mvif->basic_rates_idx = MT7996_BASIC_RATES_TBL + 4;
+		mvif->mt76.basic_rates_idx = MT7996_BASIC_RATES_TBL + 4;
 	else
-		mvif->basic_rates_idx = MT7996_BASIC_RATES_TBL;
+		mvif->mt76.basic_rates_idx = MT7996_BASIC_RATES_TBL;
 
 	mt7996_init_bitrate_mask(vif);
 
@@ -506,7 +506,7 @@ static u8
 mt7996_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       bool beacon, bool mcast)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 	struct mt76_phy *mphy = hw->priv;
 	u16 rate;
 	u8 i, idx, ht;
@@ -518,7 +518,7 @@ mt7996_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		struct mt7996_dev *dev = mt7996_hw_dev(hw);
 
 		/* must odd index */
-		idx = MT7996_BEACON_RATES_TBL + 2 * (mvif->mt76.idx % 20);
+		idx = MT7996_BEACON_RATES_TBL + 2 * (mvif->idx % 20);
 		mt7996_mac_set_fixed_rate_table(dev, idx, rate);
 		return idx;
 	}
@@ -536,7 +536,7 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_bss_conf *info,
 				    u64 changed)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 88e2f9d0e513..6cc87835263a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -600,7 +600,7 @@ static void
 mt7996_mcu_bss_bmc_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		       struct mt7996_phy *phy)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 	struct bss_rate_tlv *bmc;
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	enum nl80211_band band = chandef->chan->band;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 829973abc28d..c8e8a04a561e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -120,10 +120,6 @@ struct mt7996_vif {
 
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
 	struct cfg80211_bitrate_mask bitrate_mask;
-
-	u8 basic_rates_idx;
-	u8 mcast_rates_idx;
-	u8 beacon_rates_idx;
 };
 
 /* per-phy stats.  */
-- 
2.40.1

