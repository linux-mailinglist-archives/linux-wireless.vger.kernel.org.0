Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C95562578
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jun 2022 23:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbiF3Vlr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jun 2022 17:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiF3Vlq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jun 2022 17:41:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F224F184
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jun 2022 14:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E1F3623D3
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jun 2022 21:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125BAC34115;
        Thu, 30 Jun 2022 21:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656625304;
        bh=hia9bk9sCNglR1kJXv5yBIdqnfPMCPir3CZuQXEf5WQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uNmXxOwLldIELQdAW5uxf3xd5nRZcAqivSQw+Ok2sgYhzcBS3rSw0ZQrbPuodfIXN
         UjqjGaFrkbhEk8S4C25rfLVM6RXKXJ07sme1rfq3IVT1C9bqMfnUg7tJuXBiDgLjRo
         r9egkT4PY5Ldo9/OlWgAVzPY/1z8IWMp0C7GWKRPURfKRu+dG+rhDA8TzvJlTg1LX9
         s9yv55KUzL4FJwc4oxcme55oM4Ez3Cl32Gk2WeZjHsvN03o5BabbllYcgmClL6TESk
         en2FOXkpdMpYvin15Micc8HLJYT8zCgUZv039UreyjN6v5Dyspd8w3dcJuBaChc7ln
         hfWaw3rPii8Lw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        sean.wang@mediatek.com
Subject: [PATCH 3/5] mt76: add phy_idx to mt76_wcid
Date:   Thu, 30 Jun 2022 23:41:14 +0200
Message-Id: <f3a8a659033fa017b1c02e0323ece946629cf796.1656624320.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656624320.git.lorenzo@kernel.org>
References: <cover.1656624320.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce phy_idx to mt76_wcid structure instead of ext_phy.
This is a preliminary patch to add mt7990 chipset support.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c        | 12 ++++++------
 drivers/net/wireless/mediatek/mt76/mt76.h            |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c      |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c     |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c     |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/main.c     |  4 ++--
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 4e5a67f70343..69a563c58f0b 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1299,10 +1299,11 @@ void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
 EXPORT_SYMBOL_GPL(mt76_rx_poll_complete);
 
 static int
-mt76_sta_add(struct mt76_dev *dev, struct ieee80211_vif *vif,
-	     struct ieee80211_sta *sta, bool ext_phy)
+mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
+	     struct ieee80211_sta *sta)
 {
 	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+	struct mt76_dev *dev = phy->dev;
 	int ret;
 	int i;
 
@@ -1323,9 +1324,9 @@ mt76_sta_add(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	}
 
 	ewma_signal_init(&wcid->rssi);
-	if (ext_phy)
+	if (phy->band_idx == MT_BAND1)
 		mt76_wcid_mask_set(dev->wcid_phy_mask, wcid->idx);
-	wcid->ext_phy = ext_phy;
+	wcid->phy_idx = phy->band_idx;
 	rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
 
 	mt76_packet_id_init(wcid);
@@ -1370,11 +1371,10 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt76_phy *phy = hw->priv;
 	struct mt76_dev *dev = phy->dev;
-	bool ext_phy = phy != &dev->phy;
 
 	if (old_state == IEEE80211_STA_NOTEXIST &&
 	    new_state == IEEE80211_STA_NONE)
-		return mt76_sta_add(dev, vif, sta, ext_phy);
+		return mt76_sta_add(phy, vif, sta);
 
 	if (old_state == IEEE80211_STA_AUTH &&
 	    new_state == IEEE80211_STA_ASSOC &&
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e57c1f61f5a0..1b8d26afc6f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -288,8 +288,8 @@ struct mt76_wcid {
 	u8 hw_key_idx2;
 
 	u8 sta:1;
-	u8 ext_phy:1;
 	u8 amsdu:1;
+	u8 phy_idx:2;
 
 	u8 rx_check_pn;
 	u8 rx_key_pn[IEEE80211_NUM_TIDS + 1][6];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index e553fb678489..6f9fcbc4b565 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1388,7 +1388,7 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 		if (sta->rate_probe) {
 			struct mt7615_phy *phy = &dev->phy;
 
-			if (sta->wcid.ext_phy && dev->mt76.phys[MT_BAND1])
+			if (sta->wcid.phy_idx && dev->mt76.phys[MT_BAND1])
 				phy = dev->mt76.phys[MT_BAND1]->priv;
 
 			mt7615_mac_set_rates(phy, sta, NULL, sta->rates);
@@ -1431,7 +1431,7 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 		fallthrough;
 	case MT_PHY_TYPE_OFDM:
 		mphy = &dev->mphy;
-		if (sta->wcid.ext_phy && dev->mt76.phys[MT_BAND1])
+		if (sta->wcid.phy_idx && dev->mt76.phys[MT_BAND1])
 			mphy = dev->mt76.phys[MT_BAND1];
 
 		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
@@ -1539,7 +1539,7 @@ static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 	if (wcidx >= MT7615_WTBL_STA || !sta)
 		goto out;
 
-	if (wcid->ext_phy && dev->mt76.phys[MT_BAND1])
+	if (wcid->phy_idx && dev->mt76.phys[MT_BAND1])
 		mphy = dev->mt76.phys[MT_BAND1];
 
 	if (mt7615_fill_txs(dev, msta, &info, txs_data))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 277c22a4d049..9de01d061673 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -224,7 +224,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 
 	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
-	mvif->sta.wcid.ext_phy = mvif->mt76.band_idx;
+	mvif->sta.wcid.phy_idx = mvif->mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mt76_packet_id_init(&mvif->sta.wcid);
 
@@ -650,7 +650,7 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
-	msta->wcid.ext_phy = mvif->mt76.band_idx;
+	msta->wcid.phy_idx = mvif->mt76.band_idx;
 
 	phy = mvif->mt76.band_idx ? mt7615_ext_phy(dev) : &dev->phy;
 	err = mt76_connac_pm_wake(phy->mt76, &dev->pm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index e2ca1766d028..f2172a06efbb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -597,7 +597,7 @@ bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
 		fallthrough;
 	case MT_PHY_TYPE_OFDM:
 		mphy = &dev->phy;
-		if (wcid->ext_phy && dev->phys[MT_BAND1])
+		if (wcid->phy_idx == MT_BAND1 && dev->phys[MT_BAND1])
 			mphy = dev->phys[MT_BAND1];
 
 		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index b1a5aab7a984..dbd5b29309d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -227,7 +227,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	INIT_LIST_HEAD(&mvif->sta.rc_list);
 	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
-	mvif->sta.wcid.ext_phy = ext_phy;
+	mvif->sta.wcid.phy_idx = ext_phy;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mt76_packet_id_init(&mvif->sta.wcid);
@@ -660,7 +660,7 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
-	msta->wcid.ext_phy = ext_phy;
+	msta->wcid.phy_idx = ext_phy;
 	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	msta->jiffies = jiffies;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 9bd0b4d56de1..80ca4e76ee56 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -336,7 +336,7 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 
 	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
-	mvif->sta.wcid.ext_phy = mvif->mt76.band_idx;
+	mvif->sta.wcid.phy_idx = mvif->mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mt76_packet_id_init(&mvif->sta.wcid);
@@ -698,7 +698,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
-	msta->wcid.ext_phy = mvif->mt76.band_idx;
+	msta->wcid.phy_idx = mvif->mt76.band_idx;
 	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	msta->last_txs = jiffies;
 
-- 
2.36.1

