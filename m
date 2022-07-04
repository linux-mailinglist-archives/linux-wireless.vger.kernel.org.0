Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEA8564E23
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 09:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiGDHDD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 03:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiGDHDB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 03:03:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3DD5F8D
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 00:03:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACB3CB80CC0
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 07:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2137FC3411E;
        Mon,  4 Jul 2022 07:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656918177;
        bh=qi8X8q0X9HWyNleMetP0VwUU1UceVzS3RlRulXH6dW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LM72m7Wa1Z0Uwc9SDPYSbqaRUdaHTb2bTVDPcH23m6ZzY/wc8XnW0h3QDQus+aVCl
         EFi3ZoSaRthTZOXddQs38MWhyqzyehUD2Q+dia/zTs8cJiX3PElwghXj3aAyXo5St+
         eWsV4N2vBh+VnNdkA0pCkXZ8wXUEG+9oTwuH/Zq5k9Tic9GXFc6qeVAK4Xhf42AY0s
         unxGiLs3gBIhcrCIOiHUHeN3eT1VE9JN9E+aCdPy3iO8QIXpf6IGLzNp8jGMt3uIVj
         MEEpH6d4d/ayHNPH+E6Jca4R4v2w+P3Z5Vh3ls4PV9BDnTtvWNxCb1GPXgWBdHcZSv
         VblvM0DC1QsVA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        bo.jiao@mediatek.com
Subject: [PATCH v3 3/5] mt76: add phy_idx to mt76_wcid
Date:   Mon,  4 Jul 2022 09:02:21 +0200
Message-Id: <06c03a159ce3d3c79ab4951284287e3ed4015860.1656917976.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656917976.git.lorenzo@kernel.org>
References: <cover.1656917976.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Co-developed-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
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
index 4d97fa48996b..0e7bd4a67ad4 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1295,10 +1295,11 @@ void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
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
 
@@ -1319,9 +1320,9 @@ mt76_sta_add(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	}
 
 	ewma_signal_init(&wcid->rssi);
-	if (ext_phy)
+	if (phy->band_idx == MT_BAND1)
 		mt76_wcid_mask_set(dev->wcid_phy_mask, wcid->idx);
-	wcid->ext_phy = ext_phy;
+	wcid->phy_idx = phy->band_idx;
 	rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
 
 	mt76_packet_id_init(wcid);
@@ -1366,11 +1367,10 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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
index 1db4c70df93f..a329dccef954 100644
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
index d0a13e78d7f4..36b42dcac102 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1389,7 +1389,7 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 		if (sta->rate_probe) {
 			struct mt7615_phy *phy = &dev->phy;
 
-			if (sta->wcid.ext_phy && dev->mt76.phys[MT_BAND1])
+			if (sta->wcid.phy_idx && dev->mt76.phys[MT_BAND1])
 				phy = dev->mt76.phys[MT_BAND1]->priv;
 
 			mt7615_mac_set_rates(phy, sta, NULL, sta->rates);
@@ -1432,7 +1432,7 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 		fallthrough;
 	case MT_PHY_TYPE_OFDM:
 		mphy = &dev->mphy;
-		if (sta->wcid.ext_phy && dev->mt76.phys[MT_BAND1])
+		if (sta->wcid.phy_idx && dev->mt76.phys[MT_BAND1])
 			mphy = dev->mt76.phys[MT_BAND1];
 
 		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
@@ -1540,7 +1540,7 @@ static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 	if (wcidx >= MT7615_WTBL_STA || !sta)
 		goto out;
 
-	if (wcid->ext_phy && dev->mt76.phys[MT_BAND1])
+	if (wcid->phy_idx && dev->mt76.phys[MT_BAND1])
 		mphy = dev->mt76.phys[MT_BAND1];
 
 	if (mt7615_fill_txs(dev, msta, &info, txs_data))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 28bc76c8e8e7..789271a8d65f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -224,7 +224,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 
 	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
-	mvif->sta.wcid.ext_phy = mvif->mt76.band_idx;
+	mvif->sta.wcid.phy_idx = mvif->mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mt76_packet_id_init(&mvif->sta.wcid);
 
@@ -629,7 +629,7 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
-	msta->wcid.ext_phy = mvif->mt76.band_idx;
+	msta->wcid.phy_idx = mvif->mt76.band_idx;
 
 	phy = mvif->mt76.band_idx ? mt7615_ext_phy(dev) : &dev->phy;
 	err = mt76_connac_pm_wake(phy->mt76, &dev->pm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index fb22fffd721a..f1d51b572da4 100644
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

