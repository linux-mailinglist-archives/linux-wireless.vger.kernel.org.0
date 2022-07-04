Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A962564E24
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 09:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiGDHC5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 03:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiGDHC4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 03:02:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAADE5F51
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 00:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36CDC60B29
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 07:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DA4C3411E;
        Mon,  4 Jul 2022 07:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656918173;
        bh=F4eOqDXvQCJBbYW9BOBg0M6QjppTvKtEBVfTF1AkB8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hgyZXo48ch36IhIqfWB6qUYHN8k9sHBQdZhfip0GjUo1Cgc1D5+7y2LcRDVqFhfjS
         iMBwXNWMV2ZfKMdbQwi/HFL3GszzzOBuS2NqIuN6YWIZoOxAhqv6TQS2x9duVhlZtL
         SLhEPmHlCsvSzUw8j1PTL7NC4PVmxvz2gmJJv86a4B8Oazfx7Mr0XXLBJGMSpym27D
         YHkTMeYBa0svc0iYK47i1NHflinuayVz/uP6ba+nR1C9brifM+5m3eAMFUXLPjJTth
         x0YrFDtb7ntD12N4xBU1MMgr7/lKjRp/Gi6JYjSVvsHrlqMAlq/uY3KdpzNxeNE7VP
         WxBhn6+lhMI5Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        bo.jiao@mediatek.com
Subject: [PATCH v3 2/5] mt76: introduce phys array in mt76_dev structure
Date:   Mon,  4 Jul 2022 09:02:20 +0200
Message-Id: <9c3f0ebbfec8ceb5020d6e06fd796b99e80a3e49.1656917976.git.lorenzo@kernel.org>
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

Introduce phys array in mt76_dev structure to reference mt76_phy
supported by the chipset. This is a preliminary patch to introduce
mt7990 chipset support.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c      | 13 ++++--
 drivers/net/wireless/mediatek/mt76/mac80211.c |  9 ++--
 drivers/net/wireless/mediatek/mt76/mt76.h     | 43 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 36 +++++++++-------
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 26 +++++------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   | 14 +++---
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  8 ++--
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 20 +++++----
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 16 +++----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
 drivers/net/wireless/mediatek/mt76/tx.c       | 42 ++++++++++++------
 14 files changed, 142 insertions(+), 97 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index f22273cde1a8..40cb91097b2e 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -791,10 +791,15 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 	mt76_worker_disable(&dev->tx_worker);
 	netif_napi_del(&dev->tx_napi);
 
-	for (i = 0; i < ARRAY_SIZE(dev->phy.q_tx); i++) {
-		mt76_dma_tx_cleanup(dev, dev->phy.q_tx[i], true);
-		if (dev->phy2)
-			mt76_dma_tx_cleanup(dev, dev->phy2->q_tx[i], true);
+	for (i = 0; i < ARRAY_SIZE(dev->phys); i++) {
+		struct mt76_phy *phy = dev->phys[i];
+		int j;
+
+		if (!phy)
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(phy->q_tx); j++)
+			mt76_dma_tx_cleanup(dev, phy->q_tx[j], true);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(dev->q_mcu); i++)
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 331e92e72672..4d97fa48996b 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -452,7 +452,7 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 
 struct mt76_phy *
 mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
-	       const struct ieee80211_ops *ops)
+	       const struct ieee80211_ops *ops, u8 band_idx)
 {
 	struct ieee80211_hw *hw;
 	unsigned int phy_size;
@@ -467,6 +467,7 @@ mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
 	phy->dev = dev;
 	phy->hw = hw;
 	phy->priv = hw->priv + phy_size;
+	phy->band_idx = band_idx;
 
 	hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
 	hw->wiphy->interface_modes =
@@ -519,7 +520,7 @@ int mt76_register_phy(struct mt76_phy *phy, bool vht,
 	if (ret)
 		return ret;
 
-	phy->dev->phy2 = phy;
+	phy->dev->phys[phy->band_idx] = phy;
 
 	return 0;
 }
@@ -531,7 +532,7 @@ void mt76_unregister_phy(struct mt76_phy *phy)
 
 	mt76_tx_status_check(dev, true);
 	ieee80211_unregister_hw(phy->hw);
-	dev->phy2 = NULL;
+	dev->phys[phy->band_idx] = NULL;
 }
 EXPORT_SYMBOL_GPL(mt76_unregister_phy);
 
@@ -558,6 +559,8 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	phy = &dev->phy;
 	phy->dev = dev;
 	phy->hw = hw;
+	phy->band_idx = MT_BAND0;
+	dev->phys[phy->band_idx] = phy;
 
 	spin_lock_init(&dev->rx_lock);
 	spin_lock_init(&dev->lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b6716b16dd87..1db4c70df93f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -107,6 +107,13 @@ enum mt76_rxq_id {
 	__MT_RXQ_MAX
 };
 
+enum mt76_band_id {
+	MT_BAND0,
+	MT_BAND1,
+	MT_BAND2,
+	__MT_MAX_BAND
+};
+
 enum mt76_cipher_type {
 	MT_CIPHER_NONE,
 	MT_CIPHER_WEP40,
@@ -662,6 +669,7 @@ struct mt76_phy {
 	void *priv;
 
 	unsigned long state;
+	u8 band_idx;
 
 	struct mt76_queue *q_tx[__MT_TXQ_MAX];
 
@@ -701,8 +709,7 @@ struct mt76_phy {
 
 struct mt76_dev {
 	struct mt76_phy phy; /* must be first */
-
-	struct mt76_phy *phy2;
+	struct mt76_phy *phys[__MT_MAX_BAND];
 
 	struct ieee80211_hw *hw;
 
@@ -892,7 +899,7 @@ mt76_wcid_hw(struct mt76_dev *dev, u16 wcid)
 {
 	if (wcid <= MT76_N_WCIDS &&
 	    mt76_wcid_mask_test(dev->wcid_phy_mask, wcid))
-		return dev->phy2->hw;
+		return dev->phys[MT_BAND1]->hw;
 
 	return dev->phy.hw;
 }
@@ -947,7 +954,8 @@ void mt76_free_device(struct mt76_dev *dev);
 void mt76_unregister_phy(struct mt76_phy *phy);
 
 struct mt76_phy *mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
-				const struct ieee80211_ops *ops);
+				const struct ieee80211_ops *ops,
+				u8 band_idx);
 int mt76_register_phy(struct mt76_phy *phy, bool vht,
 		      struct ieee80211_rate *rates, int n_rates);
 
@@ -1003,8 +1011,9 @@ static inline int mt76_init_mcu_queue(struct mt76_dev *dev, int qid, int idx,
 static inline struct mt76_phy *
 mt76_dev_phy(struct mt76_dev *dev, u8 phy_idx)
 {
-	if (phy_idx && dev->phy2)
-		return dev->phy2;
+	if ((phy_idx == MT_BAND1 && dev->phys[phy_idx]) ||
+	    (phy_idx == MT_BAND2 && dev->phys[phy_idx]))
+		return dev->phys[phy_idx];
 
 	return &dev->phy;
 }
@@ -1123,13 +1132,17 @@ static inline bool mt76_is_testmode_skb(struct mt76_dev *dev,
 					struct ieee80211_hw **hw)
 {
 #ifdef CONFIG_NL80211_TESTMODE
-	if (skb == dev->phy.test.tx_skb)
-		*hw = dev->phy.hw;
-	else if (dev->phy2 && skb == dev->phy2->test.tx_skb)
-		*hw = dev->phy2->hw;
-	else
-		return false;
-	return true;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev->phys); i++) {
+		struct mt76_phy *phy = dev->phys[i];
+
+		if (phy && skb == phy->test.tx_skb) {
+			*hw = dev->phys[i]->hw;
+			return true;
+		}
+	}
+	return false;
 #else
 	return false;
 #endif
@@ -1247,8 +1260,8 @@ mt76_tx_status_get_hw(struct mt76_dev *dev, struct sk_buff *skb)
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hw *hw = dev->phy.hw;
 
-	if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && dev->phy2)
-		hw = dev->phy2->hw;
+	if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && dev->phys[MT_BAND1])
+		hw = dev->phys[MT_BAND1]->hw;
 
 	info->hw_queue &= ~MT_TX_HW_QUEUE_EXT_PHY;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 3e076092714e..07a1fea94f66 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -459,7 +459,7 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 		return 0;
 
 	mt7615_cap_dbdc_enable(dev);
-	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7615_ops);
+	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7615_ops, MT_BAND1);
 	if (!mphy)
 		return -ENOMEM;
 
@@ -509,7 +509,7 @@ EXPORT_SYMBOL_GPL(mt7615_register_ext_phy);
 void mt7615_unregister_ext_phy(struct mt7615_dev *dev)
 {
 	struct mt7615_phy *phy = mt7615_ext_phy(dev);
-	struct mt76_phy *mphy = dev->mt76.phy2;
+	struct mt76_phy *mphy = dev->mt76.phys[MT_BAND1];
 
 	if (!phy)
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 1eb9d286091d..d0a13e78d7f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -109,6 +109,7 @@ static struct mt76_wcid *mt7615_rx_get_wcid(struct mt7615_dev *dev,
 
 void mt7615_mac_reset_counters(struct mt7615_dev *dev)
 {
+	struct mt76_phy *mphy_ext = dev->mt76.phys[MT_BAND1];
 	int i;
 
 	for (i = 0; i < 4; i++) {
@@ -118,8 +119,8 @@ void mt7615_mac_reset_counters(struct mt7615_dev *dev)
 
 	memset(dev->mt76.aggr_stats, 0, sizeof(dev->mt76.aggr_stats));
 	dev->mt76.phy.survey_time = ktime_get_boottime();
-	if (dev->mt76.phy2)
-		dev->mt76.phy2->survey_time = ktime_get_boottime();
+	if (mphy_ext)
+		mphy_ext->survey_time = ktime_get_boottime();
 
 	/* reset airtime counters */
 	mt76_rr(dev, MT_MIB_SDR9(0));
@@ -336,9 +337,9 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt7615_phy *phy = &dev->phy;
-	struct mt7615_phy *phy2 = dev->mt76.phy2 ? dev->mt76.phy2->priv : NULL;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_hdr *hdr;
+	struct mt7615_phy *phy2;
 	__le32 *rxd = (__le32 *)skb->data;
 	u32 rxd0 = le32_to_cpu(rxd[0]);
 	u32 rxd1 = le32_to_cpu(rxd[1]);
@@ -355,6 +356,8 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	memset(status, 0, sizeof(*status));
 
 	chfreq = FIELD_GET(MT_RXD1_NORMAL_CH_FREQ, rxd1);
+
+	phy2 = dev->mt76.phys[MT_BAND1] ? dev->mt76.phys[MT_BAND1]->priv : NULL;
 	if (!phy2)
 		phy_idx = 0;
 	else if (phy2->chfreq == phy->chfreq)
@@ -498,7 +501,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	}
 
 	if (phy_idx == 1 && phy2) {
-		mphy = dev->mt76.phy2;
+		mphy = dev->mt76.phys[MT_BAND1];
 		phy = phy2;
 		status->phy_idx = phy_idx;
 	}
@@ -747,8 +750,8 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 		tx_count = msta->rate_count;
 	}
 
-	if (ext_phy && dev->mt76.phy2)
-		mphy = dev->mt76.phy2;
+	if (ext_phy && dev->mt76.phys[MT_BAND1])
+		mphy = dev->mt76.phys[MT_BAND1];
 
 	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
 	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
@@ -1386,8 +1389,8 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 		if (sta->rate_probe) {
 			struct mt7615_phy *phy = &dev->phy;
 
-			if (sta->wcid.ext_phy && dev->mt76.phy2)
-				phy = dev->mt76.phy2->priv;
+			if (sta->wcid.ext_phy && dev->mt76.phys[MT_BAND1])
+				phy = dev->mt76.phys[MT_BAND1]->priv;
 
 			mt7615_mac_set_rates(phy, sta, NULL, sta->rates);
 		}
@@ -1429,8 +1432,8 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 		fallthrough;
 	case MT_PHY_TYPE_OFDM:
 		mphy = &dev->mphy;
-		if (sta->wcid.ext_phy && dev->mt76.phy2)
-			mphy = dev->mt76.phy2;
+		if (sta->wcid.ext_phy && dev->mt76.phys[MT_BAND1])
+			mphy = dev->mt76.phys[MT_BAND1];
 
 		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
 			sband = &mphy->sband_5g.sband;
@@ -1537,8 +1540,8 @@ static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 	if (wcidx >= MT7615_WTBL_STA || !sta)
 		goto out;
 
-	if (wcid->ext_phy && dev->mt76.phy2)
-		mphy = dev->mt76.phy2;
+	if (wcid->ext_phy && dev->mt76.phys[MT_BAND1])
+		mphy = dev->mt76.phys[MT_BAND1];
 
 	if (mt7615_fill_txs(dev, msta, &info, txs_data))
 		ieee80211_tx_status_noskb(mphy->hw, sta, &info);
@@ -1955,6 +1958,7 @@ mt7615_phy_update_channel(struct mt76_phy *mphy, int idx)
 static void mt7615_update_survey(struct mt7615_dev *dev)
 {
 	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_phy *mphy_ext = mdev->phys[MT_BAND1];
 	ktime_t cur_time;
 
 	/* MT7615 can only update both phys simultaneously
@@ -1962,14 +1966,14 @@ static void mt7615_update_survey(struct mt7615_dev *dev)
 	 */
 
 	mt7615_phy_update_channel(&mdev->phy, 0);
-	if (mdev->phy2)
-		mt7615_phy_update_channel(mdev->phy2, 1);
+	if (mphy_ext)
+		mt7615_phy_update_channel(mphy_ext, 1);
 
 	cur_time = ktime_get_boottime();
 
 	mt76_update_survey_active_time(&mdev->phy, cur_time);
-	if (mdev->phy2)
-		mt76_update_survey_active_time(mdev->phy2, cur_time);
+	if (mphy_ext)
+		mt76_update_survey_active_time(mphy_ext, cur_time);
 
 	/* reset obss airtime */
 	mt76_set(dev, MT_WF_RMAC_MIB_TIME0, MT_WF_RMAC_MIB_RXTIME_CLR);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index e8b1be818c30..9a1696da0cc9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -369,7 +369,7 @@ mt7615_mcu_rx_csa_notify(struct mt7615_dev *dev, struct sk_buff *skb)
 		return;
 
 	if (ext_phy && ext_phy->omac_mask & BIT_ULL(c->omac_idx))
-		mphy = dev->mt76.phy2;
+		mphy = dev->mt76.phys[MT_BAND1];
 
 	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
 			IEEE80211_IFACE_ITER_RESUME_ALL,
@@ -388,8 +388,8 @@ mt7615_mcu_rx_radar_detected(struct mt7615_dev *dev, struct sk_buff *skb)
 	    !r->constant_prf_detected && !r->staggered_prf_detected)
 		return;
 
-	if (r->band_idx && dev->mt76.phy2)
-		mphy = dev->mt76.phy2;
+	if (r->band_idx && dev->mt76.phys[MT_BAND1])
+		mphy = dev->mt76.phys[MT_BAND1];
 
 	if (mt76_phy_dfs_state(mphy) < MT_DFS_STATE_CAC)
 		return;
@@ -448,8 +448,8 @@ mt7615_mcu_scan_event(struct mt7615_dev *dev, struct sk_buff *skb)
 	struct mt7615_phy *phy;
 	struct mt76_phy *mphy;
 
-	if (*seq_num & BIT(7) && dev->mt76.phy2)
-		mphy = dev->mt76.phy2;
+	if (*seq_num & BIT(7) && dev->mt76.phys[MT_BAND1])
+		mphy = dev->mt76.phys[MT_BAND1];
 	else
 		mphy = &dev->mt76.phy;
 
@@ -474,8 +474,8 @@ mt7615_mcu_roc_event(struct mt7615_dev *dev, struct sk_buff *skb)
 	skb_pull(skb, sizeof(struct mt7615_mcu_rxd));
 	event = (struct mt7615_roc_tlv *)skb->data;
 
-	if (event->dbdc_band && dev->mt76.phy2)
-		mphy = dev->mt76.phy2;
+	if (event->dbdc_band && dev->mt76.phys[MT_BAND1])
+		mphy = dev->mt76.phys[MT_BAND1];
 	else
 		mphy = &dev->mt76.phy;
 
@@ -499,8 +499,8 @@ mt7615_mcu_beacon_loss_event(struct mt7615_dev *dev, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(struct mt7615_mcu_rxd));
 	event = (struct mt76_connac_beacon_loss_event *)skb->data;
-	if (band_idx && dev->mt76.phy2)
-		mphy = dev->mt76.phy2;
+	if (band_idx && dev->mt76.phys[MT_BAND1])
+		mphy = dev->mt76.phys[MT_BAND1];
 	else
 		mphy = &dev->mt76.phy;
 
@@ -520,8 +520,8 @@ mt7615_mcu_bss_event(struct mt7615_dev *dev, struct sk_buff *skb)
 	skb_pull(skb, sizeof(struct mt7615_mcu_rxd));
 	event = (struct mt76_connac_mcu_bss_event *)skb->data;
 
-	if (band_idx && dev->mt76.phy2)
-		mphy = dev->mt76.phy2;
+	if (band_idx && dev->mt76.phys[MT_BAND1])
+		mphy = dev->mt76.phys[MT_BAND1];
 	else
 		mphy = &dev->mt76.phy;
 
@@ -2330,7 +2330,7 @@ int mt7615_mcu_apply_rx_dcoc(struct mt7615_phy *phy)
 
 		.bw = mt7615_mcu_chan_bw(chandef),
 		.band = chandef->center_freq1 > 4000,
-		.dbdc_en = !!dev->mt76.phy2,
+		.dbdc_en = !!dev->mt76.phys[MT_BAND1],
 	};
 	u16 center_freq = chandef->center_freq1;
 	int freq_idx;
@@ -2451,7 +2451,7 @@ int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy)
 
 		.bw = mt7615_mcu_chan_bw(chandef),
 		.band = chandef->center_freq1 > 4000,
-		.dbdc_en = !!dev->mt76.phy2,
+		.dbdc_en = !!dev->mt76.phys[MT_BAND1],
 	};
 	u16 center_freq = chandef->center_freq1;
 	int freq_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 25880d1a50da..060d52c81d9e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -345,7 +345,7 @@ mt7615_hw_dev(struct ieee80211_hw *hw)
 static inline struct mt7615_phy *
 mt7615_ext_phy(struct mt7615_dev *dev)
 {
-	struct mt76_phy *phy = dev->mt76.phy2;
+	struct mt76_phy *phy = dev->mt76.phys[MT_BAND1];
 
 	if (!phy)
 		return NULL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 26211c63dac4..2ec8f2beb373 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -78,8 +78,8 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if ((info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) && msta) {
 		struct mt7615_phy *phy = &dev->phy;
 
-		if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && mdev->phy2)
-			phy = mdev->phy2->priv;
+		if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && mdev->phys[MT_BAND1])
+			phy = mdev->phys[MT_BAND1]->priv;
 
 		spin_lock_bh(&dev->mt76.lock);
 		mt7615_mac_set_rates(phy, msta, &info->control.rates[0],
@@ -182,16 +182,18 @@ mt7615_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
 static void
 mt7615_update_beacons(struct mt7615_dev *dev)
 {
+	struct mt76_phy *mphy_ext = dev->mt76.phys[MT_BAND1];
+
 	ieee80211_iterate_active_interfaces(dev->mt76.hw,
 		IEEE80211_IFACE_ITER_RESUME_ALL,
 		mt7615_update_vif_beacon, dev->mt76.hw);
 
-	if (!dev->mt76.phy2)
+	if (!mphy_ext)
 		return;
 
-	ieee80211_iterate_active_interfaces(dev->mt76.phy2->hw,
+	ieee80211_iterate_active_interfaces(mphy_ext->hw,
 		IEEE80211_IFACE_ITER_RESUME_ALL,
-		mt7615_update_vif_beacon, dev->mt76.phy2->hw);
+		mt7615_update_vif_beacon, mphy_ext->hw);
 }
 
 void mt7615_mac_reset_work(struct work_struct *work)
@@ -203,7 +205,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
 	int i;
 
 	dev = container_of(work, struct mt7615_dev, reset_work);
-	ext_phy = dev->mt76.phy2;
+	ext_phy = dev->mt76.phys[MT_BAND1];
 	phy2 = ext_phy ? ext_phy->priv : NULL;
 
 	if (!(READ_ONCE(dev->reset_state) & MT_MCU_CMD_STOP_PDMA))
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 8695956c57e4..fb22fffd721a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -474,8 +474,8 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 		band_idx = mvif->band_idx;
 	}
 
-	if (ext_phy && dev->phy2)
-		mphy = dev->phy2;
+	if (ext_phy && dev->phys[MT_BAND1])
+		mphy = dev->phys[MT_BAND1];
 
 	if (inband_disc) {
 		p_fmt = MT_TX_TYPE_FW;
@@ -597,8 +597,8 @@ bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
 		fallthrough;
 	case MT_PHY_TYPE_OFDM:
 		mphy = &dev->phy;
-		if (wcid->ext_phy && dev->phy2)
-			mphy = dev->phy2;
+		if (wcid->ext_phy && dev->phys[MT_BAND1])
+			mphy = dev->phys[MT_BAND1];
 
 		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
 			sband = &mphy->sband_5g.sband;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index c0f4f2053738..5e6b4da2455c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -499,7 +499,7 @@ mt7915_alloc_ext_phy(struct mt7915_dev *dev)
 	if (!dev->dbdc_support)
 		return NULL;
 
-	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7915_ops);
+	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7915_ops, MT_BAND1);
 	if (!mphy)
 		return ERR_PTR(-ENOMEM);
 
@@ -1033,7 +1033,7 @@ void mt7915_set_stream_he_caps(struct mt7915_phy *phy)
 static void mt7915_unregister_ext_phy(struct mt7915_dev *dev)
 {
 	struct mt7915_phy *phy = mt7915_ext_phy(dev);
-	struct mt76_phy *mphy = dev->mt76.phy2;
+	struct mt76_phy *mphy = dev->mt76.phys[MT_BAND1];
 
 	if (!phy)
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 718025518bab..a66236ba60fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -242,7 +242,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	memset(status, 0, sizeof(*status));
 
 	if ((rxd1 & MT_RXD1_NORMAL_BAND_IDX) && !phy->band_idx) {
-		mphy = dev->mt76.phy2;
+		mphy = dev->mt76.phys[MT_BAND1];
 		if (!mphy)
 			return -EINVAL;
 
@@ -668,8 +668,8 @@ void mt7915_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct mt76_phy *mphy = &dev->phy;
 
-	if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && dev->phy2)
-		mphy = dev->phy2;
+	if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && dev->phys[MT_BAND1])
+		mphy = dev->phys[MT_BAND1];
 
 	mt76_connac2_mac_write_txwi(dev, txwi, skb, wcid, key, pid, qid, changed);
 
@@ -853,7 +853,7 @@ static void
 mt7915_mac_tx_free_prepare(struct mt7915_dev *dev)
 {
 	struct mt76_dev *mdev = &dev->mt76;
-	struct mt76_phy *mphy_ext = mdev->phy2;
+	struct mt76_phy *mphy_ext = mdev->phys[MT_BAND1];
 
 	/* clean DMA queues and unmap buffers first */
 	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
@@ -1275,22 +1275,24 @@ mt7915_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
 static void
 mt7915_update_beacons(struct mt7915_dev *dev)
 {
+	struct mt76_phy *mphy_ext = dev->mt76.phys[MT_BAND1];
+
 	ieee80211_iterate_active_interfaces(dev->mt76.hw,
 		IEEE80211_IFACE_ITER_RESUME_ALL,
 		mt7915_update_vif_beacon, dev->mt76.hw);
 
-	if (!dev->mt76.phy2)
+	if (!mphy_ext)
 		return;
 
-	ieee80211_iterate_active_interfaces(dev->mt76.phy2->hw,
+	ieee80211_iterate_active_interfaces(mphy_ext->hw,
 		IEEE80211_IFACE_ITER_RESUME_ALL,
-		mt7915_update_vif_beacon, dev->mt76.phy2->hw);
+		mt7915_update_vif_beacon, mphy_ext->hw);
 }
 
 static void
 mt7915_dma_reset(struct mt7915_dev *dev)
 {
-	struct mt76_phy *mphy_ext = dev->mt76.phy2;
+	struct mt76_phy *mphy_ext = dev->mt76.phys[MT_BAND1];
 	u32 hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
 	int i;
 
@@ -1377,7 +1379,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	int i;
 
 	dev = container_of(work, struct mt7915_dev, reset_work);
-	ext_phy = dev->mt76.phy2;
+	ext_phy = dev->mt76.phys[MT_BAND1];
 	phy2 = ext_phy ? ext_phy->priv : NULL;
 
 	if (!(READ_ONCE(dev->reset_state) & MT_MCU_CMD_STOP_DMA))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 4a841bcead0e..601b1a3709db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -228,8 +228,8 @@ mt7915_mcu_rx_csa_notify(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	c = (struct mt7915_mcu_csa_notify *)skb->data;
 
-	if ((c->band_idx && !dev->phy.band_idx) && dev->mt76.phy2)
-		mphy = dev->mt76.phy2;
+	if ((c->band_idx && !dev->phy.band_idx) && dev->mt76.phys[MT_BAND1])
+		mphy = dev->mt76.phys[MT_BAND1];
 
 	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
 			IEEE80211_IFACE_ITER_RESUME_ALL,
@@ -247,8 +247,8 @@ mt7915_mcu_rx_thermal_notify(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (t->ctrl.ctrl_id != THERMAL_PROTECT_ENABLE)
 		return;
 
-	if ((t->ctrl.band_idx && !dev->phy.band_idx) && dev->mt76.phy2)
-		mphy = dev->mt76.phy2;
+	if ((t->ctrl.band_idx && !dev->phy.band_idx) && dev->mt76.phys[MT_BAND1])
+		mphy = dev->mt76.phys[MT_BAND1];
 
 	phy = (struct mt7915_phy *)mphy->priv;
 	phy->throttle_state = t->ctrl.duty.duty_cycle;
@@ -262,8 +262,8 @@ mt7915_mcu_rx_radar_detected(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	r = (struct mt7915_mcu_rdd_report *)skb->data;
 
-	if ((r->band_idx && !dev->phy.band_idx) && dev->mt76.phy2)
-		mphy = dev->mt76.phy2;
+	if ((r->band_idx && !dev->phy.band_idx) && dev->mt76.phys[MT_BAND1])
+		mphy = dev->mt76.phys[MT_BAND1];
 
 	if (r->band_idx == MT_RX_SEL2)
 		cfg80211_background_radar_event(mphy->hw->wiphy,
@@ -319,8 +319,8 @@ mt7915_mcu_rx_bcc_notify(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	b = (struct mt7915_mcu_bcc_notify *)skb->data;
 
-	if ((b->band_idx && !dev->phy.band_idx) && dev->mt76.phy2)
-		mphy = dev->mt76.phy2;
+	if ((b->band_idx && !dev->phy.band_idx) && dev->mt76.phys[MT_BAND1])
+		mphy = dev->mt76.phys[MT_BAND1];
 
 	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
 			IEEE80211_IFACE_ITER_RESUME_ALL,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index b51571dbad52..54ef2a12a443 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -388,7 +388,7 @@ mt7915_hw_dev(struct ieee80211_hw *hw)
 static inline struct mt7915_phy *
 mt7915_ext_phy(struct mt7915_dev *dev)
 {
-	struct mt76_phy *phy = dev->mt76.phy2;
+	struct mt76_phy *phy = dev->mt76.phys[MT_BAND1];
 
 	if (!phy)
 		return NULL;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 13c5e78dd39d..6d26e872d4ba 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -585,15 +585,25 @@ EXPORT_SYMBOL_GPL(mt76_txq_schedule_all);
 
 void mt76_tx_worker_run(struct mt76_dev *dev)
 {
-	mt76_txq_schedule_all(&dev->phy);
-	if (dev->phy2)
-		mt76_txq_schedule_all(dev->phy2);
+	struct mt76_phy *phy;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev->phys); i++) {
+		phy = dev->phys[i];
+		if (!phy)
+			continue;
+
+		mt76_txq_schedule_all(phy);
+	}
 
 #ifdef CONFIG_NL80211_TESTMODE
-	if (dev->phy.test.tx_pending)
-		mt76_testmode_tx_pending(&dev->phy);
-	if (dev->phy2 && dev->phy2->test.tx_pending)
-		mt76_testmode_tx_pending(dev->phy2);
+	for (i = 0; i < ARRAY_SIZE(dev->phys); i++) {
+		phy = dev->phys[i];
+		if (!phy || !phy->test.tx_pending)
+			continue;
+
+		mt76_testmode_tx_pending(phy);
+	}
 #endif
 }
 EXPORT_SYMBOL_GPL(mt76_tx_worker_run);
@@ -696,17 +706,23 @@ EXPORT_SYMBOL_GPL(mt76_queue_tx_complete);
 
 void __mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked)
 {
-	struct mt76_phy *phy = &dev->phy, *phy2 = dev->phy2;
-	struct mt76_queue *q, *q2 = NULL;
+	struct mt76_phy *phy = &dev->phy;
+	struct mt76_queue *q = phy->q_tx[0];
 
-	q = phy->q_tx[0];
 	if (blocked == q->blocked)
 		return;
 
 	q->blocked = blocked;
-	if (phy2) {
-		q2 = phy2->q_tx[0];
-		q2->blocked = blocked;
+
+	phy = dev->phys[MT_BAND1];
+	if (phy) {
+		q = phy->q_tx[0];
+		q->blocked = blocked;
+	}
+	phy = dev->phys[MT_BAND2];
+	if (phy) {
+		q = phy->q_tx[0];
+		q->blocked = blocked;
 	}
 
 	if (!blocked)
-- 
2.36.1

