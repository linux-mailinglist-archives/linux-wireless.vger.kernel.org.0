Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F518564E21
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 09:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiGDHDG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 03:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiGDHDF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 03:03:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127BB5F8D
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 00:03:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC765B80CC0
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 07:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B41FC3411E;
        Mon,  4 Jul 2022 07:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656918181;
        bh=PiPd/Y+25ESIwK06SUWjxQUuwp0x0Iu5NuL9GIGlla8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z2mjiB6ytFqngm3qwjU5zJ8QiOyqh93Pf78Ue2tmdeI3l46OEWFwk8qbazffxVWhE
         61hIxm6FpHxxw/0y43TO4cUK+y8fZ98L3XZ6GG1YGlpGibQ8k9UIKJKdHwC9gPNQFm
         R+fJBemxQbQgWcW+pbQQ51baYdNVH++L5EeuZh2HOueG+1RviHErpb0vXRG7Hwn4JN
         HoIqRybzQo/MT02g6WMjQIp2Q7OyitZ2CprDNkWCzJycbg26JDiMniXgggO9/Nn2uH
         6NcJYUFHRPpEfzS98qRrPBcrbpW+S78d2uQDvHQDhv9wgsNXGit76hdqc/F7RZ0rkV
         k5yawz7x5oXaQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        bo.jiao@mediatek.com
Subject: [PATCH v3 4/5] mt76: convert MT_TX_HW_QUEUE_EXT_PHY to MT_TX_HW_QUEUE_PHY
Date:   Mon,  4 Jul 2022 09:02:22 +0200
Message-Id: <e8fbaded199f3db6f5ec40b7f5411f71dab62ceb.1656917976.git.lorenzo@kernel.org>
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

Report phy_indx in tx_info->hw_queue. This is a preliminary patch to add
mt7990 chipset support

Co-developed-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h            | 10 ++++------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c      |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      |  6 ++----
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c  |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c      |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |  9 +++------
 drivers/net/wireless/mediatek/mt76/testmode.c        |  5 +----
 drivers/net/wireless/mediatek/mt76/tx.c              |  9 ++-------
 9 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index a329dccef954..11ce4617ba11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -263,7 +263,7 @@ enum mt76_wcid_flags {
 #define MT76_N_WCIDS 544
 
 /* stored in ieee80211_tx_info::hw_queue */
-#define MT_TX_HW_QUEUE_EXT_PHY		BIT(3)
+#define MT_TX_HW_QUEUE_PHY		GENMASK(3, 2)
 
 DECLARE_EWMA(signal, 10, 8);
 
@@ -1258,12 +1258,10 @@ static inline struct ieee80211_hw *
 mt76_tx_status_get_hw(struct mt76_dev *dev, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_hw *hw = dev->phy.hw;
+	u8 phy_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
+	struct ieee80211_hw *hw = mt76_phy_hw(dev, phy_idx);
 
-	if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && dev->phys[MT_BAND1])
-		hw = dev->phys[MT_BAND1]->hw;
-
-	info->hw_queue &= ~MT_TX_HW_QUEUE_EXT_PHY;
+	info->hw_queue &= ~MT_TX_HW_QUEUE_PHY;
 
 	return hw;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 36b42dcac102..ad6c7d632eed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -727,7 +727,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_tx_rate *rate = &info->control.rates[0];
-	bool ext_phy = info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY;
+	u8 phy_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
 	bool multicast = is_multicast_ether_addr(hdr->addr1);
 	struct ieee80211_vif *vif = info->control.vif;
 	bool is_mmio = mt76_is_mmio(&dev->mt76);
@@ -750,7 +750,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 		tx_count = msta->rate_count;
 	}
 
-	if (ext_phy && dev->mt76.phys[MT_BAND1])
+	if (phy_idx && dev->mt76.phys[MT_BAND1])
 		mphy = dev->mt76.phys[MT_BAND1];
 
 	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
@@ -758,10 +758,10 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 
 	if (beacon) {
 		p_fmt = MT_TX_TYPE_FW;
-		q_idx = ext_phy ? MT_LMAC_BCN1 : MT_LMAC_BCN0;
+		q_idx = phy_idx ? MT_LMAC_BCN1 : MT_LMAC_BCN0;
 	} else if (qid >= MT_TXQ_PSD) {
 		p_fmt = is_mmio ? MT_TX_TYPE_CT : MT_TX_TYPE_SF;
-		q_idx = ext_phy ? MT_LMAC_ALTX1 : MT_LMAC_ALTX0;
+		q_idx = phy_idx ? MT_LMAC_ALTX1 : MT_LMAC_ALTX0;
 	} else {
 		p_fmt = is_mmio ? MT_TX_TYPE_CT : MT_TX_TYPE_SF;
 		q_idx = wmm_idx * MT7615_MAX_WMM_SETS +
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 9a1696da0cc9..3dac76e6df4d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -708,10 +708,8 @@ mt7615_mcu_add_beacon_offload(struct mt7615_dev *dev,
 		return -EINVAL;
 	}
 
-	if (mvif->mt76.band_idx) {
-		info = IEEE80211_SKB_CB(skb);
-		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
-	}
+	info = IEEE80211_SKB_CB(skb);
+	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, mvif->mt76.band_idx);
 
 	mt7615_mac_write_txwi(dev, (__le32 *)(req.pkt), skb, wcid, NULL,
 			      0, NULL, 0, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 2ec8f2beb373..0019890fdb78 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -77,8 +77,9 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 	if ((info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) && msta) {
 		struct mt7615_phy *phy = &dev->phy;
+		u8 phy_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
 
-		if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && mdev->phys[MT_BAND1])
+		if (phy_idx && mdev->phys[MT_BAND1])
 			phy = mdev->phys[MT_BAND1]->priv;
 
 		spin_lock_bh(&dev->mt76.lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index f1d51b572da4..18dea8e1fb20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -455,7 +455,7 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 				 enum mt76_txq_id qid, u32 changed)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	bool ext_phy = info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY;
+	u8 phy_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
 	struct ieee80211_vif *vif = info->control.vif;
 	struct mt76_phy *mphy = &dev->phy;
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0, band_idx = 0;
@@ -474,7 +474,7 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 		band_idx = mvif->band_idx;
 	}
 
-	if (ext_phy && dev->phys[MT_BAND1])
+	if (phy_idx && dev->phys[MT_BAND1])
 		mphy = dev->phys[MT_BAND1];
 
 	if (inband_disc) {
@@ -502,7 +502,7 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 	      FIELD_PREP(MT_TXD1_OWN_MAC, omac_idx);
 	if (!is_mt7921(dev))
 		val |= MT_TXD1_VTA;
-	if (ext_phy || band_idx)
+	if (phy_idx || band_idx)
 		val |= MT_TXD1_TGID;
 
 	txwi[1] = cpu_to_le32(val);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index a66236ba60fd..60ae834d95a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -666,9 +666,10 @@ void mt7915_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 			   enum mt76_txq_id qid, u32 changed)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	u8 phy_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
 	struct mt76_phy *mphy = &dev->phy;
 
-	if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && dev->phys[MT_BAND1])
+	if (phy_idx && dev->phys[MT_BAND1])
 		mphy = dev->phys[MT_BAND1];
 
 	mt76_connac2_mac_write_txwi(dev, txwi, skb, wcid, key, pid, qid, changed);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 601b1a3709db..f83067961945 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1932,8 +1932,7 @@ mt7915_mcu_beacon_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vi
 	info->control.vif = vif;
 	info->band = band;
 
-	if (ext_phy)
-		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
+	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, ext_phy);
 
 	len = sizeof(*discov) + MT_TXD_SIZE + skb->len;
 	len = (len & 0x3) ? ((len | 0x3) + 1) : len;
@@ -2002,10 +2001,8 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		return -EINVAL;
 	}
 
-	if (ext_phy) {
-		info = IEEE80211_SKB_CB(skb);
-		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
-	}
+	info = IEEE80211_SKB_CB(skb);
+	info->hw_queue = FIELD_PREP(MT_TX_HW_QUEUE_PHY, ext_phy);
 
 	mt7915_mcu_beacon_check_caps(phy, vif, skb);
 
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 47ac0ca1af32..71fd3fbfa7d2 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -101,7 +101,6 @@ int mt76_testmode_alloc_skb(struct mt76_phy *phy, u32 len)
 	u16 fc = IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA |
 		 IEEE80211_FCTL_FROMDS;
 	struct mt76_testmode_data *td = &phy->test;
-	bool ext_phy = phy != &phy->dev->phy;
 	struct sk_buff **frag_tail, *head;
 	struct ieee80211_tx_info *info;
 	struct ieee80211_hdr *hdr;
@@ -136,9 +135,7 @@ int mt76_testmode_alloc_skb(struct mt76_phy *phy, u32 len)
 		      IEEE80211_TX_CTL_NO_ACK |
 		      IEEE80211_TX_CTL_NO_PS_BUFFER;
 
-	if (ext_phy)
-		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
-
+	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->band_idx);
 	frag_tail = &skb_shinfo(head)->frag_list;
 
 	for (i = 0; i < nfrags; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 6d26e872d4ba..e67cc7909bce 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -310,7 +310,6 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct mt76_queue *q;
 	int qid = skb_get_queue_mapping(skb);
-	bool ext_phy = phy != &dev->phy;
 
 	if (mt76_testmode_enabled(phy)) {
 		ieee80211_free_txskb(phy->hw, skb);
@@ -333,9 +332,7 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 		ieee80211_get_tx_rates(info->control.vif, sta, skb,
 				       info->control.rates, 1);
 
-	if (ext_phy)
-		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
-
+	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->band_idx);
 	q = phy->q_tx[qid];
 
 	spin_lock_bh(&q->lock);
@@ -350,7 +347,6 @@ mt76_txq_dequeue(struct mt76_phy *phy, struct mt76_txq *mtxq)
 {
 	struct ieee80211_txq *txq = mtxq_to_txq(mtxq);
 	struct ieee80211_tx_info *info;
-	bool ext_phy = phy != &phy->dev->phy;
 	struct sk_buff *skb;
 
 	skb = ieee80211_tx_dequeue(phy->hw, txq);
@@ -358,8 +354,7 @@ mt76_txq_dequeue(struct mt76_phy *phy, struct mt76_txq *mtxq)
 		return NULL;
 
 	info = IEEE80211_SKB_CB(skb);
-	if (ext_phy)
-		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
+	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->band_idx);
 
 	return skb;
 }
-- 
2.36.1

