Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CCF2B0260
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 10:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgKLJ5h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 04:57:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbgKLJ5c (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Nov 2020 04:57:32 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E89922201;
        Thu, 12 Nov 2020 09:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605175049;
        bh=2HQh0pOjKxW+OsZCo9Emvf2/2eo4uSXytUlHKTyub6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTPDg8I4frVFh0j9QJFJtlje6nqdaf306nXaz7LaNy+D/U2K3magkuIVlKSS4RHlT
         KIveSPbX1EBSJ8uU5XL6I4gFZfjmmiTz4IEFFuPsJPJvRATfvyNgfp2urra7Nairub
         ku/Ysh7gXkDJPE4dE4aNGhF1I0St3PLHquin51ow=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com
Subject: [PATCH 5/6] mt76: mt7915: introduce dbdc support
Date:   Thu, 12 Nov 2020 10:57:00 +0100
Message-Id: <fe922eaff7cd4c836c9b9967fdd9fa580a79e6eb.1605173301.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605173301.git.lorenzo@kernel.org>
References: <cover.1605173301.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7915 dbdc support. If dbdc is available, mt7915 primary phy
will work on 2.4GHz band, while secondary one on 5GHz band.

Tested-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  13 ++-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  19 ++--
 .../wireless/mediatek/mt76/mt7915/eeprom.c    |  47 +++++---
 .../wireless/mediatek/mt76/mt7915/eeprom.h    |   1 +
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 102 +++++++-----------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  19 ++--
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   3 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   4 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   3 +
 .../net/wireless/mediatek/mt76/mt7915/pci.c   |  19 +++-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  13 ++-
 12 files changed, 136 insertions(+), 108 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ed988d27f736..15d52af24d12 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -80,6 +80,7 @@ enum mt76_rxq_id {
 	MT_RXQ_MAIN,
 	MT_RXQ_MCU,
 	MT_RXQ_MCU_WA,
+	MT_RXQ_EXT,
 	__MT_RXQ_MAX
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 551246ac931f..39fa0745b852 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -280,13 +280,17 @@ static int
 mt7915_queues_read(struct seq_file *s, void *data)
 {
 	struct mt7915_dev *dev = dev_get_drvdata(s->private);
+	struct mt76_phy *mphy_ext = dev->mt76.phy2;
+	struct mt76_queue *ext_q = mphy_ext ? mphy_ext->q_tx[MT_TXQ_BE] : NULL;
 	struct {
 		struct mt76_queue *q;
 		char *queue;
 	} queue_map[] = {
-		{ dev->mphy.q_tx[MT_TXQ_BE], "WFDMA0" },
-		{ dev->mt76.q_mcu[MT_MCUQ_WM], "MCUWM" },
-		{ dev->mt76.q_mcu[MT_MCUQ_WA], "MCUWA" },
+		{ dev->mphy.q_tx[MT_TXQ_BE],	 "WFDMA0" },
+		{ ext_q,			 "WFDMA1" },
+		{ dev->mphy.q_tx[MT_TXQ_BE],	 "WFDMA0" },
+		{ dev->mt76.q_mcu[MT_MCUQ_WM],	 "MCUWM"  },
+		{ dev->mt76.q_mcu[MT_MCUQ_WA],	 "MCUWA"  },
 		{ dev->mt76.q_mcu[MT_MCUQ_FWDL], "MCUFWQ" },
 	};
 	int i;
@@ -294,6 +298,9 @@ mt7915_queues_read(struct seq_file *s, void *data)
 	for (i = 0; i < ARRAY_SIZE(queue_map); i++) {
 		struct mt76_queue *q = queue_map[i].q;
 
+		if (!q)
+			continue;
+
 		seq_printf(s,
 			   "%s:	queued=%d head=%d tail=%d\n",
 			   queue_map[i].queue, q->queued, q->head,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 3f1e45ee5755..8c1f9c77b14f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -5,8 +5,7 @@
 #include "../dma.h"
 #include "mac.h"
 
-static int
-mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc)
+int mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc)
 {
 	int i, err;
 
@@ -274,13 +273,21 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	/* rx data */
-	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN], 0,
-			       MT7915_RX_RING_SIZE, rx_buf_size,
-			       MT_RX_DATA_RING_BASE);
+	/* rx data queue */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
+			       MT7915_RXQ_BAND0, MT7915_RX_RING_SIZE,
+			       rx_buf_size, MT_RX_DATA_RING_BASE);
 	if (ret)
 		return ret;
 
+	if (dev->dbdc_support) {
+		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_EXT],
+				       MT7915_RXQ_BAND1, MT7915_RX_RING_SIZE,
+				       rx_buf_size, MT_RX_DATA_RING_BASE);
+		if (ret)
+			return ret;
+	}
+
 	ret = mt76_init_queues(dev);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 6f0f1d4c702a..7a2be3f61398 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -43,35 +43,50 @@ static int mt7915_check_eeprom(struct mt7915_dev *dev)
 	}
 }
 
-static void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev)
+void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 {
-	u8 *eeprom = dev->mt76.eeprom.data;
-	u8 tx_mask, max_nss = 4;
-	u32 val = mt7915_eeprom_read(dev, MT_EE_WIFI_CONF);
+	struct mt7915_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+	u32 val;
 
+	val = mt7915_eeprom_read(dev, MT_EE_WIFI_CONF + ext_phy);
 	val = FIELD_GET(MT_EE_WIFI_CONF_BAND_SEL, val);
 	switch (val) {
 	case MT_EE_5GHZ:
-		dev->mphy.cap.has_5ghz = true;
+		phy->mt76->cap.has_5ghz = true;
 		break;
 	case MT_EE_2GHZ:
-		dev->mphy.cap.has_2ghz = true;
+		phy->mt76->cap.has_2ghz = true;
 		break;
 	default:
-		dev->mphy.cap.has_2ghz = true;
-		dev->mphy.cap.has_5ghz = true;
+		phy->mt76->cap.has_2ghz = true;
+		phy->mt76->cap.has_5ghz = true;
 		break;
 	}
+}
+
+static void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev)
+{
+	u8 nss, tx_mask[2] = {}, *eeprom = dev->mt76.eeprom.data;
+
+	mt7915_eeprom_parse_band_config(&dev->phy);
 
 	/* read tx mask from eeprom */
-	tx_mask =  FIELD_GET(MT_EE_WIFI_CONF_TX_MASK,
-			     eeprom[MT_EE_WIFI_CONF]);
-	if (!tx_mask || tx_mask > max_nss)
-		tx_mask = max_nss;
-
-	dev->chainmask = BIT(tx_mask) - 1;
-	dev->mphy.antenna_mask = dev->chainmask;
-	dev->phy.chainmask = dev->chainmask;
+	tx_mask[0] = FIELD_GET(MT_EE_WIFI_CONF_TX_MASK,
+			       eeprom[MT_EE_WIFI_CONF]);
+	if (dev->dbdc_support)
+		tx_mask[1] = FIELD_GET(MT_EE_WIFI_CONF_TX_MASK,
+				       eeprom[MT_EE_WIFI_CONF + 1]);
+
+	nss = tx_mask[0] + tx_mask[1];
+	if (!nss || nss > 4) {
+		tx_mask[0] = 4;
+		nss = 4;
+	}
+
+	dev->chainmask = BIT(nss) - 1;
+	dev->mphy.antenna_mask = BIT(tx_mask[0]) - 1;
+	dev->phy.chainmask = dev->mphy.antenna_mask;
 }
 
 int mt7915_eeprom_init(struct mt7915_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index 4e31d6ab4fa6..6712032b40df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -15,6 +15,7 @@ enum mt7915_eeprom_field {
 	MT_EE_CHIP_ID =		0x000,
 	MT_EE_VERSION =		0x002,
 	MT_EE_MAC_ADDR =	0x004,
+	MT_EE_MAC_ADDR2 =	0x00a,
 	MT_EE_DDIE_FT_VERSION =	0x050,
 	MT_EE_WIFI_CONF =	0x190,
 	MT_EE_TX0_POWER_2G =	0x2fc,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 10d263f6ce3e..95183dcd405a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -35,25 +35,26 @@ mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
 
 	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
 	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
+
+	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 1536);
+	/* disable rx rate report by default due to hw issues */
+	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
 }
 
 static void mt7915_mac_init(struct mt7915_dev *dev)
 {
 	int i;
 
-	mt76_rmw_field(dev, MT_DMA_DCR0, MT_DMA_DCR0_MAX_RX_LEN, 1536);
 	mt76_rmw_field(dev, MT_MDP_DCR1, MT_MDP_DCR1_MAX_RX_LEN, 1536);
-	/* disable rx rate report by default due to hw issues */
-	mt76_clear(dev, MT_DMA_DCR0, MT_DMA_DCR0_RXD_G5_EN);
 	/* disable hardware de-agg */
 	mt76_clear(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
 
 	for (i = 0; i < MT7915_WTBL_SIZE; i++)
 		mt7915_mac_wtbl_update(dev, i,
 				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+	for (i = 0; i < 2; i++)
+		mt7915_mac_init_band(dev, i);
 
-	mt7915_mac_init_band(dev, 0);
-	mt7915_mac_init_band(dev, 1);
 	mt7915_mcu_set_rts_thresh(&dev->phy, 0x92b);
 }
 
@@ -117,6 +118,7 @@ static void mt7915_init_work(struct work_struct *work)
 	mt7915_mac_init(dev);
 	mt7915_init_txpower(dev);
 	mt7915_txbf_init(dev);
+	mt7915_register_ext_phy(dev);
 }
 
 static int mt7915_init_hardware(struct mt7915_dev *dev)
@@ -129,6 +131,8 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 	spin_lock_init(&dev->token_lock);
 	idr_init(&dev->token);
 
+	dev->dbdc_support = !!(mt7915_l1_rr(dev, MT_HW_BOUND) & BIT(5));
+
 	ret = mt7915_dma_init(dev);
 	if (ret)
 		return ret;
@@ -542,63 +546,18 @@ void mt7915_set_stream_he_caps(struct mt7915_phy *phy)
 	}
 }
 
-static void
-mt7915_cap_dbdc_enable(struct mt7915_dev *dev)
-{
-	dev->mphy.sband_5g.sband.vht_cap.cap &=
-			~(IEEE80211_VHT_CAP_SHORT_GI_160 |
-			  IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ);
-
-	if (dev->chainmask == 0xf)
-		dev->mphy.antenna_mask = dev->chainmask >> 2;
-	else
-		dev->mphy.antenna_mask = dev->chainmask >> 1;
-
-	dev->phy.chainmask = dev->mphy.antenna_mask;
-	dev->mphy.hw->wiphy->available_antennas_rx = dev->phy.chainmask;
-	dev->mphy.hw->wiphy->available_antennas_tx = dev->phy.chainmask;
-
-	mt76_set_stream_caps(&dev->mphy, true);
-	mt7915_set_stream_vht_txbf_caps(&dev->phy);
-	mt7915_set_stream_he_caps(&dev->phy);
-}
-
-static void
-mt7915_cap_dbdc_disable(struct mt7915_dev *dev)
-{
-	dev->mphy.sband_5g.sband.vht_cap.cap |=
-			IEEE80211_VHT_CAP_SHORT_GI_160 |
-			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
-
-	dev->mphy.antenna_mask = dev->chainmask;
-	dev->phy.chainmask = dev->chainmask;
-	dev->mphy.hw->wiphy->available_antennas_rx = dev->chainmask;
-	dev->mphy.hw->wiphy->available_antennas_tx = dev->chainmask;
-
-	mt76_set_stream_caps(&dev->mphy, true);
-	mt7915_set_stream_vht_txbf_caps(&dev->phy);
-	mt7915_set_stream_he_caps(&dev->phy);
-}
-
 int mt7915_register_ext_phy(struct mt7915_dev *dev)
 {
 	struct mt7915_phy *phy = mt7915_ext_phy(dev);
 	struct mt76_phy *mphy;
 	int ret;
-	bool bound;
-
-	/* TODO: enble DBDC */
-	bound = mt7915_l1_rr(dev, MT_HW_BOUND) & BIT(5);
-	if (!bound)
-		return -EINVAL;
 
-	if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
-		return -EINVAL;
+	if (!dev->dbdc_support)
+		return 0;
 
 	if (phy)
 		return 0;
 
-	mt7915_cap_dbdc_enable(dev);
 	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7915_ops);
 	if (!mphy)
 		return -ENOMEM;
@@ -613,18 +572,31 @@ int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	INIT_LIST_HEAD(&phy->stats_list);
 	INIT_DELAYED_WORK(&phy->mac_work, mt7915_mac_work);
 
-	/*
-	 * Make the secondary PHY MAC address local without overlapping with
-	 * the usual MAC address allocation scheme on multiple virtual interfaces
-	 */
-	mphy->hw->wiphy->perm_addr[0] |= 2;
-	mphy->hw->wiphy->perm_addr[0] ^= BIT(7);
+	mt7915_eeprom_parse_band_config(phy);
+	mt7915_set_stream_vht_txbf_caps(phy);
+	mt7915_set_stream_he_caps(phy);
+
+	memcpy(mphy->macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR2,
+	       ETH_ALEN);
+	mt76_eeprom_override(mphy);
+
+	/* The second interface does not get any packets unless it has a vif */
+	ieee80211_hw_set(mphy->hw, WANT_MONITOR_VIF);
+
+	ret = mt7915_init_tx_queues(phy, MT7915_TXQ_BAND1,
+				    MT7915_TX_RING_SIZE);
+	if (ret)
+		goto error;
 
 	ret = mt76_register_phy(mphy, true, mt7915_rates,
 				ARRAY_SIZE(mt7915_rates));
 	if (ret)
-		ieee80211_free_hw(mphy->hw);
+		goto error;
 
+	return 0;
+
+error:
+	ieee80211_free_hw(mphy->hw);
 	return ret;
 }
 
@@ -636,7 +608,6 @@ void mt7915_unregister_ext_phy(struct mt7915_dev *dev)
 	if (!phy)
 		return;
 
-	mt7915_cap_dbdc_disable(dev);
 	mt76_unregister_phy(mphy);
 	ieee80211_free_hw(mphy->hw);
 }
@@ -673,7 +644,16 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	dev->mphy.sband_5g.sband.vht_cap.cap |=
 			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991 |
 			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
-	mt7915_cap_dbdc_disable(dev);
+	if (!dev->dbdc_support)
+		dev->mphy.sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_SHORT_GI_160 |
+			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
+	dev->mphy.hw->wiphy->available_antennas_rx = dev->phy.chainmask;
+	dev->mphy.hw->wiphy->available_antennas_tx = dev->phy.chainmask;
+
+	mt76_set_stream_caps(&dev->mphy, true);
+	mt7915_set_stream_vht_txbf_caps(&dev->phy);
+	mt7915_set_stream_he_caps(&dev->phy);
 	dev->phy.dfs_state = -1;
 
 #ifdef CONFIG_NL80211_TESTMODE
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 5cc1fc9b4b95..c2dc5aaa2d74 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1077,6 +1077,7 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 {
 	struct mt7915_tx_free *free = (struct mt7915_tx_free *)skb->data;
 	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_phy *mphy_ext = mdev->phy2;
 	struct mt76_txwi_cache *txwi;
 	struct ieee80211_sta *sta = NULL;
 	LIST_HEAD(free_list);
@@ -1086,6 +1087,10 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	/* clean DMA queues and unmap buffers first */
 	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
 	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
+	if (mphy_ext) {
+		mt76_queue_tx_cleanup(dev, mphy_ext->q_tx[MT_TXQ_PSD], false);
+		mt76_queue_tx_cleanup(dev, mphy_ext->q_tx[MT_TXQ_BE], false);
+	}
 
 	/*
 	 * TODO: MT_TX_FREE_LATENCY is msdu time from the TXD is queued into PLE,
@@ -1321,9 +1326,8 @@ mt7915_phy_get_nf(struct mt7915_phy *phy, int idx)
 	u32 val, sum = 0, n = 0;
 	int nss, i;
 
-	/* TODO: DBDC: 0,1 for 2.4G, 2,3 for 5G */
 	for (nss = 0; nss < hweight8(phy->chainmask); nss++) {
-		u32 reg = MT_WF_IRPI(nss);
+		u32 reg = MT_WF_IRPI(nss + (idx << dev->dbdc_support));
 
 		for (i = 0; i < ARRAY_SIZE(nf_power); i++, reg += 4) {
 			val = mt7915_l2_rr(dev, reg);
@@ -1332,10 +1336,7 @@ mt7915_phy_get_nf(struct mt7915_phy *phy, int idx)
 		}
 	}
 
-	if (!n)
-		return 0;
-
-	return sum / n;
+	return n ? sum / n : 0;
 }
 
 static void
@@ -1425,6 +1426,7 @@ static void
 mt7915_dma_reset(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
+	struct mt76_phy *mphy_ext = dev->mt76.phy2;
 	int i;
 
 	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
@@ -1434,8 +1436,11 @@ mt7915_dma_reset(struct mt7915_phy *phy)
 	usleep_range(1000, 2000);
 
 	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WA], true);
-	for (i = 0; i < __MT_TXQ_MAX; i++)
+	for (i = 0; i < __MT_TXQ_MAX; i++) {
 		mt76_queue_tx_cleanup(dev, phy->mt76->q_tx[i], true);
+		if (mphy_ext)
+			mt76_queue_tx_cleanup(dev, mphy_ext->q_tx[i], true);
+	}
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		mt76_queue_rx_reset(dev, i);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index c0361c2d73b5..0c82aa2ef219 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -394,7 +394,8 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 		else
 			phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
 
-		mt76_rmw_field(dev, MT_DMA_DCR0, MT_DMA_DCR0_RXD_G5_EN, enabled);
+		mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
+			       enabled);
 		mt76_testmode_reset(&dev->mt76, true);
 		mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 12d683a873a0..eeb9bd4c3bea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -962,7 +962,7 @@ mt7915_mcu_muar_config(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 		.mode = !!mask || enable,
 		.entry_count = 1,
 		.write = 1,
-
+		.band = phy != &dev->phy,
 		.index = idx * 2 + bssid,
 	};
 
@@ -3146,7 +3146,7 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 		.center_ch = ieee80211_frequency_to_channel(freq1),
 		.bw = mt7915_mcu_chan_bw(chandef),
 		.tx_streams_num = hweight8(phy->mt76->antenna_mask),
-		.rx_streams = phy->chainmask,
+		.rx_streams = phy->mt76->antenna_mask,
 		.band_idx = phy != &dev->phy,
 		.channel_band = chandef->chan->band,
 	};
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index b4ca22ce435c..f29b9c029328 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -165,6 +165,7 @@ struct mt7915_dev {
 
 	s8 **rate_power; /* TODO: use mt76_rate_power */
 
+	bool dbdc_support;
 	bool fw_debug;
 
 #ifdef CONFIG_NL80211_TESTMODE
@@ -278,6 +279,7 @@ void mt7915_unregister_device(struct mt7915_dev *dev);
 int mt7915_register_ext_phy(struct mt7915_dev *dev);
 void mt7915_unregister_ext_phy(struct mt7915_dev *dev);
 int mt7915_eeprom_init(struct mt7915_dev *dev);
+void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy);
 int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 				   struct ieee80211_channel *chan,
 				   u8 chain_idx);
@@ -461,6 +463,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  struct ieee80211_sta *sta,
 			  struct mt76_tx_info *tx_info);
 void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
+int mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc);
 void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
 void mt7915_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 3ac5bbb94d29..aeb86fbea41c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -21,8 +21,14 @@ static void
 mt7915_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
 {
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
+	static const u32 rx_irq_mask[] = {
+		[MT_RXQ_MAIN] = MT_INT_RX_DONE_DATA0,
+		[MT_RXQ_EXT] = MT_INT_RX_DONE_DATA1,
+		[MT_RXQ_MCU] = MT_INT_RX_DONE_WM,
+		[MT_RXQ_MCU_WA] = MT_INT_RX_DONE_WA,
+	};
 
-	mt7915_irq_enable(dev, MT_INT_RX_DONE(q));
+	mt7915_irq_enable(dev, rx_irq_mask[q]);
 }
 
 /* TODO: support 2/4/6/8 MSI-X vectors */
@@ -49,14 +55,17 @@ static irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
 	if (intr & MT_INT_TX_DONE_MCU)
 		napi_schedule(&dev->mt76.tx_napi);
 
-	if (intr & MT_INT_RX_DONE_DATA)
-		napi_schedule(&dev->mt76.napi[0]);
+	if (intr & MT_INT_RX_DONE_DATA0)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MAIN]);
+
+	if (intr & MT_INT_RX_DONE_DATA1)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_EXT]);
 
 	if (intr & MT_INT_RX_DONE_WM)
-		napi_schedule(&dev->mt76.napi[1]);
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU]);
 
 	if (intr & MT_INT_RX_DONE_WA)
-		napi_schedule(&dev->mt76.napi[2]);
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU_WA]);
 
 	if (intr & MT_INT_MCU_CMD) {
 		u32 val = mt76_rr(dev, MT_MCU_CMD);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index fded019fc897..848703e6eb7c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -73,11 +73,10 @@
 #define MT_TMAC_TRCR0(_band)		MT_WF_TMAC(_band, 0x09c)
 #define MT_TMAC_TFCR0(_band)		MT_WF_TMAC(_band, 0x1e0)
 
-/* DMA Band 0 */
-#define MT_WF_DMA_BASE			0x21e00
-#define MT_WF_DMA(ofs)			(MT_WF_DMA_BASE + (ofs))
+#define MT_WF_DMA_BASE(_band)		((_band) ? 0xa1e00 : 0x21e00)
+#define MT_WF_DMA(_band, ofs)		(MT_WF_DMA_BASE(_band) + (ofs))
 
-#define MT_DMA_DCR0			MT_WF_DMA(0x000)
+#define MT_DMA_DCR0(_band)		MT_WF_DMA(_band, 0x000)
 #define MT_DMA_DCR0_MAX_RX_LEN		GENMASK(15, 3)
 #define MT_DMA_DCR0_RXD_G5_EN		BIT(23)
 
@@ -339,11 +338,11 @@
 
 #define MT_INT_SOURCE_CSR		MT_WFDMA_EXT_CSR(0x10)
 #define MT_INT_MASK_CSR			MT_WFDMA_EXT_CSR(0x14)
-#define MT_INT_RX_DONE_DATA		BIT(16)
+#define MT_INT_RX_DONE_DATA0		BIT(16)
+#define MT_INT_RX_DONE_DATA1		BIT(17)
 #define MT_INT_RX_DONE_WM		BIT(0)
 #define MT_INT_RX_DONE_WA		BIT(1)
-#define MT_INT_RX_DONE(_n)		((_n) ? BIT((_n) - 1) : BIT(16))
-#define MT_INT_RX_DONE_ALL		(BIT(0) | BIT(1) | BIT(16))
+#define MT_INT_RX_DONE_ALL		(BIT(0) | BIT(1) | GENMASK(17, 16))
 #define MT_INT_TX_DONE_MCU_WA		BIT(15)
 #define MT_INT_TX_DONE_FWDL		BIT(26)
 #define MT_INT_TX_DONE_MCU_WM		BIT(27)
-- 
2.26.2

