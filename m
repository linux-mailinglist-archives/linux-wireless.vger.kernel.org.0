Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C6548AD30
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 12:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbiAKL7l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 06:59:41 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:50482 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239380AbiAKL7c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 06:59:32 -0500
X-UUID: 9325d816c7164047851d52c5d389f385-20220111
X-UUID: 9325d816c7164047851d52c5d389f385-20220111
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1732169445; Tue, 11 Jan 2022 19:59:29 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 11 Jan 2022 19:59:28 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 11 Jan
 2022 19:59:27 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 11 Jan 2022 19:59:27 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH v2 5/5] mt76: mt7915: introduce band_idx in mt7915_phy
Date:   Tue, 11 Jan 2022 19:59:21 +0800
Message-ID: <7d2d437d0799273704a8269ab5fae849591d5619.1641901681.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1641901681.git.Bo.Jiao@mediatek.com>
References: <cover.1641901681.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

The wfsys of MT7986 has only single adie chip for non-dbdc devices,
and it binds to band1 by default. Hence this patch adds band_idx to
explicitly configure phy accordingly.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |   6 +-
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |   8 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  28 +--
 .../wireless/mediatek/mt76/mt7915/eeprom.c    |  18 +-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  34 +++-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 161 +++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  12 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  28 ++-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   1 +
 .../wireless/mediatek/mt76/mt7915/testmode.c  |  33 ++--
 10 files changed, 171 insertions(+), 158 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index cdd82a6..4363115 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1501,7 +1501,6 @@ int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	int ext_channels_num = max_t(int, sreq->n_channels - 32, 0);
 	struct ieee80211_channel **scan_list = sreq->channels;
 	struct mt76_dev *mdev = phy->dev;
-	bool ext_phy = phy == mdev->phy2;
 	struct mt76_connac_mcu_scan_channel *chan;
 	struct mt76_connac_hw_scan_req *req;
 	struct sk_buff *skb;
@@ -1515,7 +1514,7 @@ int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 
 	req = (struct mt76_connac_hw_scan_req *)skb_put(skb, sizeof(*req));
 
-	req->seq_num = mvif->scan_seq_num | ext_phy << 7;
+	req->seq_num = mvif->scan_seq_num | mvif->band_idx << 7;
 	req->bss_idx = mvif->idx;
 	req->scan_type = sreq->n_ssids ? 1 : 0;
 	req->probe_req_num = sreq->n_ssids ? 2 : 0;
@@ -1623,7 +1622,6 @@ int mt76_connac_mcu_sched_scan_req(struct mt76_phy *phy,
 	struct mt76_connac_mcu_scan_channel *chan;
 	struct mt76_connac_sched_scan_req *req;
 	struct mt76_dev *mdev = phy->dev;
-	bool ext_phy = phy == mdev->phy2;
 	struct cfg80211_match_set *match;
 	struct cfg80211_ssid *ssid;
 	struct sk_buff *skb;
@@ -1637,7 +1635,7 @@ int mt76_connac_mcu_sched_scan_req(struct mt76_phy *phy,
 
 	req = (struct mt76_connac_sched_scan_req *)skb_put(skb, sizeof(*req));
 	req->version = 1;
-	req->seq_num = mvif->scan_seq_num | ext_phy << 7;
+	req->seq_num = mvif->scan_seq_num | mvif->band_idx << 7;
 
 	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
 		u8 *addr = is_mt7663(phy->dev) ? req->mt7663.random_mac
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 464d2b4..74d7044 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -497,12 +497,12 @@ mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 
 	/* Tx ampdu stat */
 	for (i = 0; i < ARRAY_SIZE(range); i++)
-		range[i] = mt76_rr(dev, MT_MIB_ARNG(ext_phy, i));
+		range[i] = mt76_rr(dev, MT_MIB_ARNG(phy->band_idx, i));
 
 	for (i = 0; i < ARRAY_SIZE(bound); i++)
 		bound[i] = MT_MIB_ARNCR_RANGE(range[i / 4], i % 4) + 1;
 
-	seq_printf(file, "\nPhy %d\n", ext_phy);
+	seq_printf(file, "\nPhy %d, Phy band %d\n", ext_phy, phy->band_idx);
 
 	seq_printf(file, "Length: %8d | ", bound[0]);
 	for (i = 0; i < ARRAY_SIZE(bound) - 1; i++)
@@ -510,7 +510,7 @@ mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 			   bound[i] + 1, bound[i + 1]);
 
 	seq_puts(file, "\nCount:  ");
-	n = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
+	n = phy->band_idx ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	for (i = 0; i < ARRAY_SIZE(bound); i++)
 		seq_printf(file, "%8d | ", dev->mt76.aggr_stats[i + n]);
 	seq_puts(file, "\n");
@@ -847,7 +847,7 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 	debugfs_create_devm_seqfile(dev->mt76.dev, "twt_stats", dir,
 				    mt7915_twt_stats);
 	debugfs_create_file("ser_trigger", 0200, dir, dev, &fops_ser_trigger);
-	if (!dev->dbdc_support || ext_phy) {
+	if (!dev->dbdc_support || phy->band_idx) {
 		debugfs_create_u32("dfs_hw_pattern", 0400, dir,
 				   &dev->hw_pattern);
 		debugfs_create_file("radar_trigger", 0200, dir, dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 2dc2d6b..49b4d8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -310,10 +310,12 @@ static int mt7915_dma_enable(struct mt7915_dev *dev)
 	/* enable interrupts for TX/RX rings */
 	irq_mask = MT_INT_RX_DONE_MCU |
 		   MT_INT_TX_DONE_MCU |
-		   MT_INT_MCU_CMD |
-		   MT_INT_BAND0_RX_DONE;
+		   MT_INT_MCU_CMD;
 
-	if (dev->dbdc_support)
+	if (!dev->phy.band_idx)
+		irq_mask |= MT_INT_BAND0_RX_DONE;
+
+	if (dev->dbdc_support || dev->phy.band_idx)
 		irq_mask |= MT_INT_BAND1_RX_DONE;
 
 	mt7915_irq_enable(dev, irq_mask);
@@ -338,7 +340,7 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 
 	/* init tx queue */
 	ret = mt7915_init_tx_queues(&dev->phy,
-				    MT_TXQ_ID(0),
+				    MT_TXQ_ID(dev->phy.band_idx),
 				    MT7915_TX_RING_SIZE,
 				    MT_TXQ_RING_BASE(0));
 	if (ret)
@@ -387,13 +389,15 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 		return ret;
 
 	/* rx data queue for band0 */
-	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
-			       MT_RXQ_ID(MT_RXQ_MAIN),
-			       MT7915_RX_RING_SIZE,
-			       MT_RX_BUF_SIZE,
-			       MT_RXQ_RING_BASE(MT_RXQ_MAIN));
-	if (ret)
-		return ret;
+	if (!dev->phy.band_idx) {
+		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
+				       MT_RXQ_ID(MT_RXQ_MAIN),
+				       MT7915_RX_RING_SIZE,
+				       MT_RX_BUF_SIZE,
+				       MT_RXQ_RING_BASE(MT_RXQ_MAIN));
+		if (ret)
+			return ret;
+	}
 
 	/* tx free notify event from WA for band0 */
 	if (!is_mt7915(mdev)) {
@@ -406,7 +410,7 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 			return ret;
 	}
 
-	if (dev->dbdc_support) {
+	if (dev->dbdc_support || dev->phy.band_idx) {
 		/* rx data queue for band1 */
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_EXT],
 				       MT_RXQ_ID(MT_RXQ_EXT),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 0147c93..0908ae1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -141,14 +141,14 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 static void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
-	bool ext_phy = phy != &dev->phy;
 	u8 *eeprom = dev->mt76.eeprom.data;
 	u32 val;
 
-	val = eeprom[MT_EE_WIFI_CONF + ext_phy];
+	val = eeprom[MT_EE_WIFI_CONF + phy->band_idx];
 	val = FIELD_GET(MT_EE_WIFI_CONF0_BAND_SEL, val);
-	if (val == MT_EE_BAND_SEL_DEFAULT && dev->dbdc_support)
-		val = ext_phy ? MT_EE_BAND_SEL_5GHZ : MT_EE_BAND_SEL_2GHZ;
+	if (val == MT_EE_BAND_SEL_DEFAULT &&
+	    (!is_mt7915(&dev->mt76) || dev->dbdc_support))
+		val = phy->band_idx ? MT_EE_BAND_SEL_5GHZ : MT_EE_BAND_SEL_2GHZ;
 
 	switch (val) {
 	case MT_EE_BAND_SEL_5GHZ:
@@ -179,7 +179,7 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
 				eeprom[MT_EE_WIFI_CONF]);
 	} else {
 		nss = FIELD_GET(MT_EE_WIFI_CONF0_TX_PATH,
-				eeprom[MT_EE_WIFI_CONF + ext_phy]);
+				eeprom[MT_EE_WIFI_CONF + phy->band_idx]);
 	}
 
 	if (!nss || nss > 4)
@@ -192,12 +192,12 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
 		if (is_mt7915(&dev->mt76)) {
 			nss_band = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B0,
 					     eeprom[MT_EE_WIFI_CONF + 3]);
-			if (ext_phy)
+			if (phy->band_idx)
 				nss_band = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B1,
 						     eeprom[MT_EE_WIFI_CONF + 3]);
 		} else {
 			nss_band = FIELD_GET(MT_EE_WIFI_CONF_STREAM_NUM,
-					     eeprom[MT_EE_WIFI_CONF + 2 + ext_phy]);
+					     eeprom[MT_EE_WIFI_CONF + 2 + phy->band_idx]);
 		}
 
 		nss_band_max = is_mt7986(&dev->mt76) ?
@@ -212,8 +212,8 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
 
 	if (nss_band > nss) {
 		dev_warn(dev->mt76.dev,
-			 "nss mismatch, nss(%d) nss_band(%d) ext_phy(%d)\n",
-			 nss, nss_band, ext_phy);
+			 "nss mismatch, nss(%d) nss_band(%d) band(%d) ext_phy(%d)\n",
+			 nss, nss_band, phy->band_idx, ext_phy);
 		nss = nss_band;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 561bb9e..4d732a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -482,6 +482,9 @@ static int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	phy->dev = dev;
 	phy->mt76 = mphy;
 
+	/* Bind main phy to band0 and ext_phy to band1 for dbdc case */
+	phy->band_idx = 1;
+
 	INIT_DELAYED_WORK(&mphy->mac_work, mt7915_mac_work);
 
 	mt7915_eeprom_parse_hw_cap(dev, phy);
@@ -501,7 +504,7 @@ static int mt7915_register_ext_phy(struct mt7915_dev *dev)
 
 	/* init wiphy according to mphy and phy */
 	mt7915_init_wiphy(mphy->hw);
-	ret = mt7915_init_tx_queues(phy, MT_TXQ_ID(1),
+	ret = mt7915_init_tx_queues(phy, MT_TXQ_ID(phy->band_idx),
 				    MT7915_TX_RING_SIZE,
 				    MT_TXQ_RING_BASE(1));
 	if (ret)
@@ -593,6 +596,32 @@ static void mt7915_wfsys_reset(struct mt7915_dev *dev)
 	}
 }
 
+static bool mt7915_band_config(struct mt7915_dev *dev)
+{
+	bool ret = true;
+
+	dev->phy.band_idx = 0;
+
+	if (is_mt7986(&dev->mt76)) {
+		u32 sku = mt7915_check_adie(dev, true);
+
+		/*
+		 * for mt7986, dbdc support is determined by the number
+		 * of adie chips and the main phy is bound to band1 when
+		 * dbdc is disabled.
+		 */
+		if (sku == MT7975_ONE_ADIE || sku == MT7976_ONE_ADIE) {
+			dev->phy.band_idx = 1;
+			ret = false;
+		}
+	} else {
+		ret = is_mt7915(&dev->mt76) ?
+		      !!(mt76_rr(dev, MT_HW_BOUND) & BIT(5)) : true;
+	}
+
+	return ret;
+}
+
 static int mt7915_init_hardware(struct mt7915_dev *dev)
 {
 	int ret, idx;
@@ -601,8 +630,7 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 
 	INIT_WORK(&dev->init_work, mt7915_init_work);
 
-	dev->dbdc_support = is_mt7915(&dev->mt76) ?
-			    !!(mt76_rr(dev, MT_HW_BOUND) & BIT(5)) : true;
+	dev->dbdc_support = mt7915_band_config(dev);
 
 	/* If MCU was already running, it is likely in a bad state */
 	if (mt76_get_field(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE) >
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 6fcc0e7..94bde9e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -591,7 +591,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	memset(status, 0, sizeof(*status));
 
-	if (rxd1 & MT_RXD1_NORMAL_BAND_IDX) {
+	if ((rxd1 & MT_RXD1_NORMAL_BAND_IDX) && !phy->band_idx) {
 		mphy = dev->mt76.phy2;
 		if (!mphy)
 			return -EINVAL;
@@ -859,13 +859,13 @@ mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb)
 	__le32 *rxv_hdr = rxd + 2;
 	__le32 *rxv = rxd + 4;
 	u32 rcpi, ib_rssi, wb_rssi, v20, v21;
-	bool ext_phy;
+	u8 band_idx;
 	s32 foe;
 	u8 snr;
 	int i;
 
-	ext_phy = FIELD_GET(MT_RXV_HDR_BAND_IDX, le32_to_cpu(rxv_hdr[1]));
-	if (ext_phy)
+	band_idx = FIELD_GET(MT_RXV_HDR_BAND_IDX, le32_to_cpu(rxv_hdr[1]));
+	if (band_idx && !phy->band_idx)
 		phy = mt7915_ext_phy(dev);
 
 	rcpi = le32_to_cpu(rxv[6]);
@@ -1181,7 +1181,7 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	struct ieee80211_vif *vif = info->control.vif;
 	struct mt76_phy *mphy = &dev->mphy;
 	bool ext_phy = info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY;
-	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
+	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0, band_idx = 0;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
 	bool mcast = false;
 	u16 tx_count = 15;
@@ -1192,6 +1192,7 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 
 		omac_idx = mvif->mt76.omac_idx;
 		wmm_idx = mvif->mt76.wmm_idx;
+		band_idx = mvif->mt76.band_idx;
 	}
 
 	if (ext_phy && dev->mt76.phy2)
@@ -1218,7 +1219,8 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	      FIELD_PREP(MT_TXD1_WLAN_IDX, wcid->idx) |
 	      FIELD_PREP(MT_TXD1_OWN_MAC, omac_idx);
 
-	if (ext_phy && q_idx >= MT_LMAC_ALTX0 && q_idx <= MT_LMAC_BCN0)
+	if ((ext_phy || band_idx) &&
+	    q_idx >= MT_LMAC_ALTX0 && q_idx <= MT_LMAC_BCN0)
 		val |= MT_TXD1_TGID;
 
 	txwi[1] = cpu_to_le32(val);
@@ -1764,8 +1766,7 @@ void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 void mt7915_mac_cca_stats_reset(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
-	bool ext_phy = phy != &dev->phy;
-	u32 reg = MT_WF_PHY_RX_CTRL1(ext_phy);
+	u32 reg = MT_WF_PHY_RX_CTRL1(phy->band_idx);
 
 	mt76_clear(dev, reg, MT_WF_PHY_RX_CTRL1_STSCNT_EN);
 	mt76_set(dev, reg, BIT(11) | BIT(9));
@@ -1774,25 +1775,22 @@ void mt7915_mac_cca_stats_reset(struct mt7915_phy *phy)
 void mt7915_mac_reset_counters(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
-	bool ext_phy = phy != &dev->phy;
 	int i;
 
 	for (i = 0; i < 4; i++) {
-		mt76_rr(dev, MT_TX_AGG_CNT(ext_phy, i));
-		mt76_rr(dev, MT_TX_AGG_CNT2(ext_phy, i));
+		mt76_rr(dev, MT_TX_AGG_CNT(phy->band_idx, i));
+		mt76_rr(dev, MT_TX_AGG_CNT2(phy->band_idx, i));
 	}
 
-	if (ext_phy) {
-		dev->mt76.phy2->survey_time = ktime_get_boottime();
+	i = 0;
+	phy->mt76->survey_time = ktime_get_boottime();
+	if (phy->band_idx)
 		i = ARRAY_SIZE(dev->mt76.aggr_stats) / 2;
-	} else {
-		dev->mt76.phy.survey_time = ktime_get_boottime();
-		i = 0;
-	}
+
 	memset(&dev->mt76.aggr_stats[i], 0, sizeof(dev->mt76.aggr_stats) / 2);
 
 	/* reset airtime counters */
-	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(ext_phy),
+	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(phy->band_idx),
 		 MT_WF_RMAC_MIB_RXTIME_CLR);
 
 	mt7915_mcu_get_chan_mib_info(phy, true);
@@ -1802,7 +1800,7 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 {
 	s16 coverage_class = phy->coverage_class;
 	struct mt7915_dev *dev = phy->dev;
-	bool ext_phy = phy != &dev->phy;
+	struct mt7915_phy *ext_phy = mt7915_ext_phy(dev);
 	u32 val, reg_offset;
 	u32 cck = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 231) |
 		  FIELD_PREP(MT_TIMEOUT_VAL_CCA, 48);
@@ -1814,17 +1812,11 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
 		return;
 
-	if (ext_phy) {
+	if (ext_phy)
 		coverage_class = max_t(s16, dev->phy.coverage_class,
-				       coverage_class);
-	} else {
-		struct mt7915_phy *phy_ext = mt7915_ext_phy(dev);
+				       ext_phy->coverage_class);
 
-		if (phy_ext)
-			coverage_class = max_t(s16, phy_ext->coverage_class,
-					       coverage_class);
-	}
-	mt76_set(dev, MT_ARB_SCR(ext_phy),
+	mt76_set(dev, MT_ARB_SCR(phy->band_idx),
 		 MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
 	udelay(1);
 
@@ -1832,15 +1824,15 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 	reg_offset = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, offset) |
 		     FIELD_PREP(MT_TIMEOUT_VAL_CCA, offset);
 
-	mt76_wr(dev, MT_TMAC_CDTR(ext_phy), cck + reg_offset);
-	mt76_wr(dev, MT_TMAC_ODTR(ext_phy), ofdm + reg_offset);
-	mt76_wr(dev, MT_TMAC_ICR0(ext_phy),
+	mt76_wr(dev, MT_TMAC_CDTR(phy->band_idx), cck + reg_offset);
+	mt76_wr(dev, MT_TMAC_ODTR(phy->band_idx), ofdm + reg_offset);
+	mt76_wr(dev, MT_TMAC_ICR0(phy->band_idx),
 		FIELD_PREP(MT_IFS_EIFS_OFDM, is_5ghz ? 84 : 78) |
 		FIELD_PREP(MT_IFS_RIFS, 2) |
 		FIELD_PREP(MT_IFS_SIFS, 10) |
 		FIELD_PREP(MT_IFS_SLOT, phy->slottime));
 
-	mt76_wr(dev, MT_TMAC_ICR1(ext_phy),
+	mt76_wr(dev, MT_TMAC_ICR1(phy->band_idx),
 		FIELD_PREP(MT_IFS_EIFS_CCK, 314));
 
 	if (phy->slottime < 20 || is_5ghz)
@@ -1848,8 +1840,8 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 	else
 		val = MT7915_CFEND_RATE_11B;
 
-	mt76_rmw_field(dev, MT_AGG_ACR0(ext_phy), MT_AGG_ACR_CFEND_RATE, val);
-	mt76_clear(dev, MT_ARB_SCR(ext_phy),
+	mt76_rmw_field(dev, MT_AGG_ACR0(phy->band_idx), MT_AGG_ACR_CFEND_RATE, val);
+	mt76_clear(dev, MT_ARB_SCR(phy->band_idx),
 		   MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
 }
 
@@ -1891,12 +1883,11 @@ void mt7915_update_channel(struct mt76_phy *mphy)
 {
 	struct mt7915_phy *phy = (struct mt7915_phy *)mphy->priv;
 	struct mt76_channel_state *state = mphy->chan_state;
-	bool ext_phy = phy != &phy->dev->phy;
 	int nf;
 
 	mt7915_mcu_get_chan_mib_info(phy, false);
 
-	nf = mt7915_phy_get_nf(phy, ext_phy);
+	nf = mt7915_phy_get_nf(phy, phy->band_idx);
 	if (!phy->noise)
 		phy->noise = nf << 4;
 	else if (nf)
@@ -2122,118 +2113,117 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
 	struct mib_stats *mib = &phy->mib;
-	bool ext_phy = phy != &dev->phy;
 	int i, aggr0, aggr1, cnt;
 	u32 val;
 
-	cnt = mt76_rr(dev, MT_MIB_SDR3(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR3(phy->band_idx));
 	mib->fcs_err_cnt += is_mt7915(&dev->mt76) ? FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK_MT7916, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR4(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR4(phy->band_idx));
 	mib->rx_fifo_full_cnt += FIELD_GET(MT_MIB_SDR4_RX_FIFO_FULL_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR5(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR5(phy->band_idx));
 	mib->rx_mpdu_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_SDR6(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR6(phy->band_idx));
 	mib->channel_idle_cnt += FIELD_GET(MT_MIB_SDR6_CHANNEL_IDL_CNT_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR7(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR7(phy->band_idx));
 	mib->rx_vector_mismatch_cnt += FIELD_GET(MT_MIB_SDR7_RX_VECTOR_MISMATCH_CNT_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR8(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR8(phy->band_idx));
 	mib->rx_delimiter_fail_cnt += FIELD_GET(MT_MIB_SDR8_RX_DELIMITER_FAIL_CNT_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR11(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR11(phy->band_idx));
 	mib->rx_len_mismatch_cnt += FIELD_GET(MT_MIB_SDR11_RX_LEN_MISMATCH_CNT_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR12(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR12(phy->band_idx));
 	mib->tx_ampdu_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_SDR13(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR13(phy->band_idx));
 	mib->tx_stop_q_empty_cnt += FIELD_GET(MT_MIB_SDR13_TX_STOP_Q_EMPTY_CNT_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR14(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR14(phy->band_idx));
 	mib->tx_mpdu_attempts_cnt += is_mt7915(&dev->mt76) ?
 		FIELD_GET(MT_MIB_SDR14_TX_MPDU_ATTEMPTS_CNT_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR14_TX_MPDU_ATTEMPTS_CNT_MASK_MT7916, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR15(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR15(phy->band_idx));
 	mib->tx_mpdu_success_cnt += is_mt7915(&dev->mt76) ?
 		FIELD_GET(MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK_MT7916, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR22(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR22(phy->band_idx));
 	mib->rx_ampdu_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_SDR23(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR23(phy->band_idx));
 	mib->rx_ampdu_bytes_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_SDR24(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR24(phy->band_idx));
 	mib->rx_ampdu_valid_subframe_cnt += is_mt7915(&dev->mt76) ?
 		FIELD_GET(MT_MIB_SDR24_RX_AMPDU_SF_CNT_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR24_RX_AMPDU_SF_CNT_MASK_MT7916, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR25(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR25(phy->band_idx));
 	mib->rx_ampdu_valid_subframe_bytes_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_SDR27(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR27(phy->band_idx));
 	mib->tx_rwp_fail_cnt += FIELD_GET(MT_MIB_SDR27_TX_RWP_FAIL_CNT_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR28(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR28(phy->band_idx));
 	mib->tx_rwp_need_cnt += FIELD_GET(MT_MIB_SDR28_TX_RWP_NEED_CNT_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR29(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR29(phy->band_idx));
 	mib->rx_pfdrop_cnt += is_mt7915(&dev->mt76) ?
 		FIELD_GET(MT_MIB_SDR29_RX_PFDROP_CNT_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR29_RX_PFDROP_CNT_MASK_MT7916, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDRVEC(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDRVEC(phy->band_idx));
 	mib->rx_vec_queue_overflow_drop_cnt += is_mt7915(&dev->mt76) ?
 		FIELD_GET(MT_MIB_SDR30_RX_VEC_QUEUE_OVERFLOW_DROP_CNT_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR30_RX_VEC_QUEUE_OVERFLOW_DROP_CNT_MASK_MT7916, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR31(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR31(phy->band_idx));
 	mib->rx_ba_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_SDR32(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR32(phy->band_idx));
 	mib->tx_pkt_ebf_cnt += FIELD_GET(MT_MIB_SDR32_TX_PKT_EBF_CNT_MASK, cnt);
 
 	if (is_mt7915(&dev->mt76))
-		cnt = mt76_rr(dev, MT_MIB_SDR33(ext_phy));
+		cnt = mt76_rr(dev, MT_MIB_SDR33(phy->band_idx));
 	mib->tx_pkt_ibf_cnt += is_mt7915(&dev->mt76) ?
 		       FIELD_GET(MT_MIB_SDR32_TX_PKT_IBF_CNT_MASK, cnt) :
 		       FIELD_GET(MT_MIB_SDR32_TX_PKT_IBF_CNT_MASK_MT7916, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDRMUBF(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDRMUBF(phy->band_idx));
 	mib->tx_bf_cnt += FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_DR8(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_DR8(phy->band_idx));
 	mib->tx_mu_mpdu_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_DR9(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_DR9(phy->band_idx));
 	mib->tx_mu_acked_mpdu_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_DR11(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_DR11(phy->band_idx));
 	mib->tx_su_acked_mpdu_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_ETBF_TX_APP_CNT(ext_phy));
+	cnt = mt76_rr(dev, MT_ETBF_TX_APP_CNT(phy->band_idx));
 	mib->tx_bf_ibf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_IBF_CNT, cnt);
 	mib->tx_bf_ebf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_EBF_CNT, cnt);
 
-	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CNT(ext_phy));
+	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CNT(phy->band_idx));
 	mib->tx_bf_rx_fb_all_cnt += FIELD_GET(MT_ETBF_RX_FB_ALL, cnt);
 	mib->tx_bf_rx_fb_he_cnt += FIELD_GET(MT_ETBF_RX_FB_HE, cnt);
 	mib->tx_bf_rx_fb_vht_cnt += FIELD_GET(MT_ETBF_RX_FB_VHT, cnt);
 	mib->tx_bf_rx_fb_ht_cnt += FIELD_GET(MT_ETBF_RX_FB_HT, cnt);
 
-	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CONT(ext_phy));
+	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CONT(phy->band_idx));
 	mib->tx_bf_rx_fb_bw = FIELD_GET(MT_ETBF_RX_FB_BW, cnt);
 	mib->tx_bf_rx_fb_nc_cnt += FIELD_GET(MT_ETBF_RX_FB_NC, cnt);
 	mib->tx_bf_rx_fb_nr_cnt += FIELD_GET(MT_ETBF_RX_FB_NR, cnt);
 
-	cnt = mt76_rr(dev, MT_ETBF_TX_NDP_BFRP(ext_phy));
+	cnt = mt76_rr(dev, MT_ETBF_TX_NDP_BFRP(phy->band_idx));
 	mib->tx_bf_fb_cpl_cnt += FIELD_GET(MT_ETBF_TX_FB_CPL, cnt);
 	mib->tx_bf_fb_trig_cnt += FIELD_GET(MT_ETBF_TX_FB_TRI, cnt);
 
@@ -2243,52 +2233,52 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 		mib->tx_amsdu_cnt += cnt;
 	}
 
-	aggr0 = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
+	aggr0 = phy->band_idx ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	if (is_mt7915(&dev->mt76)) {
 		for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
-			val = mt76_rr(dev, MT_MIB_MB_SDR1(ext_phy, (i << 4)));
+			val = mt76_rr(dev, MT_MIB_MB_SDR1(phy->band_idx, (i << 4)));
 			mib->ba_miss_cnt += FIELD_GET(MT_MIB_BA_MISS_COUNT_MASK, val);
 			mib->ack_fail_cnt +=
 				FIELD_GET(MT_MIB_ACK_FAIL_COUNT_MASK, val);
 
-			val = mt76_rr(dev, MT_MIB_MB_SDR0(ext_phy, (i << 4)));
+			val = mt76_rr(dev, MT_MIB_MB_SDR0(phy->band_idx, (i << 4)));
 			mib->rts_cnt += FIELD_GET(MT_MIB_RTS_COUNT_MASK, val);
 			mib->rts_retries_cnt +=
 				FIELD_GET(MT_MIB_RTS_RETRIES_COUNT_MASK, val);
 
-			val = mt76_rr(dev, MT_TX_AGG_CNT(ext_phy, i));
+			val = mt76_rr(dev, MT_TX_AGG_CNT(phy->band_idx, i));
 			dev->mt76.aggr_stats[aggr0++] += val & 0xffff;
 			dev->mt76.aggr_stats[aggr0++] += val >> 16;
 
-			val = mt76_rr(dev, MT_TX_AGG_CNT2(ext_phy, i));
+			val = mt76_rr(dev, MT_TX_AGG_CNT2(phy->band_idx, i));
 			dev->mt76.aggr_stats[aggr1++] += val & 0xffff;
 			dev->mt76.aggr_stats[aggr1++] += val >> 16;
 		}
 	} else {
 		for (i = 0; i < 2; i++) {
 			/* rts count */
-			val = mt76_rr(dev, MT_MIB_MB_SDR0(ext_phy, (i << 2)));
+			val = mt76_rr(dev, MT_MIB_MB_SDR0(phy->band_idx, (i << 2)));
 			mib->rts_cnt += FIELD_GET(GENMASK(15, 0), val);
 			mib->rts_cnt += FIELD_GET(GENMASK(31, 16), val);
 
 			/* rts retry count */
-			val = mt76_rr(dev, MT_MIB_MB_SDR1(ext_phy, (i << 2)));
+			val = mt76_rr(dev, MT_MIB_MB_SDR1(phy->band_idx, (i << 2)));
 			mib->rts_retries_cnt += FIELD_GET(GENMASK(15, 0), val);
 			mib->rts_retries_cnt += FIELD_GET(GENMASK(31, 16), val);
 
 			/* ba miss count */
-			val = mt76_rr(dev, MT_MIB_MB_SDR2(ext_phy, (i << 2)));
+			val = mt76_rr(dev, MT_MIB_MB_SDR2(phy->band_idx, (i << 2)));
 			mib->ba_miss_cnt += FIELD_GET(GENMASK(15, 0), val);
 			mib->ba_miss_cnt += FIELD_GET(GENMASK(31, 16), val);
 
 			/* ack fail count */
-			val = mt76_rr(dev, MT_MIB_MB_BFTF(ext_phy, (i << 2)));
+			val = mt76_rr(dev, MT_MIB_MB_BFTF(phy->band_idx, (i << 2)));
 			mib->ack_fail_cnt += FIELD_GET(GENMASK(15, 0), val);
 			mib->ack_fail_cnt += FIELD_GET(GENMASK(31, 16), val);
 		}
 
 		for (i = 0; i < 8; i++) {
-			val = mt76_rr(dev, MT_TX_AGG_CNT(ext_phy, i));
+			val = mt76_rr(dev, MT_TX_AGG_CNT(phy->band_idx, i));
 			dev->mt76.aggr_stats[aggr0++] += FIELD_GET(GENMASK(15, 0), val);
 			dev->mt76.aggr_stats[aggr0++] += FIELD_GET(GENMASK(31, 16), val);
 		}
@@ -2386,20 +2376,22 @@ static int mt7915_dfs_start_radar_detector(struct mt7915_phy *phy)
 {
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	struct mt7915_dev *dev = phy->dev;
-	bool ext_phy = phy != &dev->phy;
 	int err;
 
 	/* start CAC */
-	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_START, ext_phy,
+	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_START, phy->band_idx,
 				      MT_RX_SEL0, 0);
 	if (err < 0)
 		return err;
 
-	err = mt7915_dfs_start_rdd(dev, ext_phy);
+	err = mt7915_dfs_start_rdd(dev, phy->band_idx);
 	if (err < 0)
 		return err;
 
-	phy->rdd_state |= BIT(ext_phy);
+	phy->rdd_state |= BIT(phy->band_idx);
+
+	if (!is_mt7915(&dev->mt76))
+		return 0;
 
 	if (chandef->width == NL80211_CHAN_WIDTH_160 ||
 	    chandef->width == NL80211_CHAN_WIDTH_80P80) {
@@ -2451,7 +2443,6 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
 {
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	struct mt7915_dev *dev = phy->dev;
-	bool ext_phy = phy != &dev->phy;
 	int err;
 
 	if (dev->mt76.region == NL80211_DFS_UNSET) {
@@ -2481,12 +2472,12 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
 			return mt7915_dfs_start_radar_detector(phy);
 
 		return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_END,
-					       ext_phy, MT_RX_SEL0, 0);
+					       phy->band_idx, MT_RX_SEL0, 0);
 	}
 
 stop:
-	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_NORMAL_START, ext_phy,
-				      MT_RX_SEL0, 0);
+	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_NORMAL_START,
+				      phy->band_idx, MT_RX_SEL0, 0);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 4cb436e..8cb47af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -49,7 +49,7 @@ static int mt7915_start(struct ieee80211_hw *hw)
 		mt7915_mac_enable_nf(dev, 0);
 	}
 
-	if (phy != &dev->phy) {
+	if (phy != &dev->phy || phy->band_idx) {
 		ret = mt76_connac_mcu_set_pm(&dev->mt76, 1, 0);
 		if (ret)
 			goto out;
@@ -217,7 +217,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	}
 	mvif->mt76.omac_idx = idx;
 	mvif->phy = phy;
-	mvif->mt76.band_idx = ext_phy;
+	mvif->mt76.band_idx = phy->band_idx;
 
 	mvif->mt76.wmm_idx = vif->type != NL80211_IFTYPE_AP;
 	if (ext_phy)
@@ -235,7 +235,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	INIT_LIST_HEAD(&mvif->sta.rc_list);
 	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
-	mvif->sta.wcid.ext_phy = mvif->mt76.band_idx;
+	mvif->sta.wcid.ext_phy = ext_phy;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mt76_packet_id_init(&mvif->sta.wcid);
@@ -672,6 +672,7 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	bool ext_phy = mvif->phy != &dev->phy;
 	int ret, idx;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
@@ -683,7 +684,7 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
-	msta->wcid.ext_phy = mvif->mt76.band_idx;
+	msta->wcid.ext_phy = ext_phy;
 	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	msta->jiffies = jiffies;
 
@@ -1256,7 +1257,6 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	};
 	struct mib_stats *mib = &phy->mib;
 	/* See mt7915_ampdu_stat_read_phy, etc */
-	bool ext_phy = phy != &dev->phy;
 	int i, n, ei = 0;
 
 	mutex_lock(&dev->mt76.mutex);
@@ -1273,7 +1273,7 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	data[ei++] = mib->tx_pkt_ibf_cnt;
 
 	/* Tx ampdu stat */
-	n = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
+	n = phy->band_idx ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	for (i = 0; i < 15 /*ARRAY_SIZE(bound)*/; i++)
 		data[ei++] = dev->mt76.aggr_stats[i + n];
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index f89779f..8d5e336 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -346,7 +346,7 @@ mt7915_mcu_rx_csa_notify(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	c = (struct mt7915_mcu_csa_notify *)skb->data;
 
-	if (c->band_idx && dev->mt76.phy2)
+	if ((c->band_idx && !dev->phy.band_idx) && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 
 	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
@@ -365,7 +365,7 @@ mt7915_mcu_rx_thermal_notify(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (t->ctrl.ctrl_id != THERMAL_PROTECT_ENABLE)
 		return;
 
-	if (t->ctrl.band_idx && dev->mt76.phy2)
+	if ((t->ctrl.band_idx && !dev->phy.band_idx) && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 
 	phy = (struct mt7915_phy *)mphy->priv;
@@ -380,7 +380,7 @@ mt7915_mcu_rx_radar_detected(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	r = (struct mt7915_mcu_rdd_report *)skb->data;
 
-	if (r->band_idx && dev->mt76.phy2)
+	if ((r->band_idx && !dev->phy.band_idx) && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 
 	ieee80211_radar_detected(mphy->hw);
@@ -565,12 +565,7 @@ mt7915_mcu_bss_rfch_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	}
 
 	if (vif->bss_conf.he_support && vif->type == NL80211_IFTYPE_STATION) {
-		struct mt7915_dev *dev = phy->dev;
-		struct mt76_phy *mphy = &dev->mt76.phy;
-		bool ext_phy = phy != &dev->phy;
-
-		if (ext_phy && dev->mt76.phy2)
-			mphy = dev->mt76.phy2;
+		struct mt76_phy *mphy = phy->mt76;
 
 		ch->he_ru26_block =
 			mt7915_check_he_obss_narrow_bw_ru(mphy->hw, vif);
@@ -1239,8 +1234,7 @@ mt7915_mcu_sta_bfer_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_phy *phy =
-		mvif->mt76.band_idx ? mt7915_ext_phy(dev) : &dev->phy;
+	struct mt7915_phy *phy = mvif->phy;
 	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
 	struct sta_rec_bf *bf;
 	struct tlv *tlv;
@@ -1306,8 +1300,7 @@ mt7915_mcu_sta_bfee_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_phy *phy =
-		mvif->mt76.band_idx ? mt7915_ext_phy(dev) : &dev->phy;
+	struct mt7915_phy *phy = mvif->phy;
 	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
 	struct sta_rec_bfee *bfee;
 	struct tlv *tlv;
@@ -1913,6 +1906,7 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 	struct tlv *tlv;
 	struct bss_info_bcn *bcn;
 	int len = MT7915_BEACON_UPDATE_SIZE + MAX_BEACON_SIZE;
+	bool ext_phy = phy != &dev->phy;
 
 	rskb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
 					       NULL, len);
@@ -1936,7 +1930,7 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 		return -EINVAL;
 	}
 
-	if (mvif->mt76.band_idx) {
+	if (ext_phy) {
 		info = IEEE80211_SKB_CB(skb);
 		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
 	}
@@ -2277,7 +2271,7 @@ int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy, void *ms)
 		u8 band_idx;
 	} req = {
 		.cmd = cpu_to_le32(MURU_GET_TXC_TX_STATS),
-		.band_idx = phy != &dev->phy,
+		.band_idx = phy->band_idx,
 	};
 
 	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD(MURU_CTRL),
@@ -2681,7 +2675,7 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 		.bw = mt76_connac_chan_bw(chandef),
 		.tx_streams_num = hweight8(phy->mt76->antenna_mask),
 		.rx_streams = phy->mt76->antenna_mask,
-		.band_idx = ext_phy,
+		.band_idx = phy->band_idx,
 		.channel_band = chandef->chan->band,
 	};
 
@@ -3045,7 +3039,7 @@ int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state)
 		u8 rsv[2];
 	} __packed req = {
 		.ctrl = {
-			.band_idx = phy != &dev->phy,
+			.band_idx = phy->band_idx,
 		},
 	};
 	int level;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 3081c6b..7ec52e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -236,6 +236,7 @@ struct mt7915_phy {
 
 	u32 rxfilter;
 	u64 omac_mask;
+	u8 band_idx;
 
 	u16 noise;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 8a00cac..7ad5857 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -198,7 +198,6 @@ mt7915_tm_set_ipg_params(struct mt7915_phy *phy, u32 ipg, u8 mode)
 	u8 slot_time = 9, sifs = TM_DEFAULT_SIFS;
 	u8 aifsn = TM_MIN_AIFSN;
 	u32 i2t_time, tr2t_time, txv_time;
-	bool ext_phy = phy != &dev->phy;
 	u16 cw = 0;
 
 	if (ipg < sig_ext + slot_time + sifs)
@@ -236,14 +235,14 @@ mt7915_tm_set_ipg_params(struct mt7915_phy *phy, u32 ipg, u8 mode)
 		}
 	}
 done:
-	txv_time = mt76_get_field(dev, MT_TMAC_ATCR(ext_phy),
+	txv_time = mt76_get_field(dev, MT_TMAC_ATCR(phy->band_idx),
 				  MT_TMAC_ATCR_TXV_TOUT);
 	txv_time *= 50;	/* normal clock time */
 
 	i2t_time = (slot_time * 1000 - txv_time - BBP_PROC_TIME) / 50;
 	tr2t_time = (sifs * 1000 - txv_time - BBP_PROC_TIME) / 50;
 
-	mt76_set(dev, MT_TMAC_TRCR0(ext_phy),
+	mt76_set(dev, MT_TMAC_TRCR0(phy->band_idx),
 		 FIELD_PREP(MT_TMAC_TRCR0_TR2T_CHK, tr2t_time) |
 		 FIELD_PREP(MT_TMAC_TRCR0_I2T_CHK, i2t_time));
 
@@ -337,7 +336,6 @@ mt7915_tm_reg_backup_restore(struct mt7915_phy *phy)
 {
 	int n_regs = ARRAY_SIZE(reg_backup_list);
 	struct mt7915_dev *dev = phy->dev;
-	bool ext_phy = phy != &dev->phy;
 	u32 *b = phy->test.reg_backup;
 	int i;
 
@@ -361,7 +359,7 @@ mt7915_tm_reg_backup_restore(struct mt7915_phy *phy)
 
 	if (phy->mt76->test.state == MT76_TM_STATE_OFF) {
 		for (i = 0; i < n_regs; i++)
-			mt76_wr(dev, reg_backup_list[i].band[ext_phy], b[i]);
+			mt76_wr(dev, reg_backup_list[i].band[phy->band_idx], b[i]);
 		return;
 	}
 
@@ -372,33 +370,33 @@ mt7915_tm_reg_backup_restore(struct mt7915_phy *phy)
 
 		phy->test.reg_backup = b;
 		for (i = 0; i < n_regs; i++)
-			b[i] = mt76_rr(dev, reg_backup_list[i].band[ext_phy]);
+			b[i] = mt76_rr(dev, reg_backup_list[i].band[phy->band_idx]);
 	}
 
-	mt76_clear(dev, MT_AGG_PCR0(ext_phy, 0), MT_AGG_PCR0_MM_PROT |
+	mt76_clear(dev, MT_AGG_PCR0(phy->band_idx, 0), MT_AGG_PCR0_MM_PROT |
 		   MT_AGG_PCR0_GF_PROT | MT_AGG_PCR0_ERP_PROT |
 		   MT_AGG_PCR0_VHT_PROT | MT_AGG_PCR0_BW20_PROT |
 		   MT_AGG_PCR0_BW40_PROT | MT_AGG_PCR0_BW80_PROT);
-	mt76_set(dev, MT_AGG_PCR0(ext_phy, 0), MT_AGG_PCR0_PTA_WIN_DIS);
+	mt76_set(dev, MT_AGG_PCR0(phy->band_idx, 0), MT_AGG_PCR0_PTA_WIN_DIS);
 
-	mt76_wr(dev, MT_AGG_PCR0(ext_phy, 1), MT_AGG_PCR1_RTS0_NUM_THRES |
+	mt76_wr(dev, MT_AGG_PCR0(phy->band_idx, 1), MT_AGG_PCR1_RTS0_NUM_THRES |
 		MT_AGG_PCR1_RTS0_LEN_THRES);
 
-	mt76_clear(dev, MT_AGG_MRCR(ext_phy), MT_AGG_MRCR_BAR_CNT_LIMIT |
+	mt76_clear(dev, MT_AGG_MRCR(phy->band_idx), MT_AGG_MRCR_BAR_CNT_LIMIT |
 		   MT_AGG_MRCR_LAST_RTS_CTS_RN | MT_AGG_MRCR_RTS_FAIL_LIMIT |
 		   MT_AGG_MRCR_TXCMD_RTS_FAIL_LIMIT);
 
-	mt76_rmw(dev, MT_AGG_MRCR(ext_phy), MT_AGG_MRCR_RTS_FAIL_LIMIT |
+	mt76_rmw(dev, MT_AGG_MRCR(phy->band_idx), MT_AGG_MRCR_RTS_FAIL_LIMIT |
 		 MT_AGG_MRCR_TXCMD_RTS_FAIL_LIMIT,
 		 FIELD_PREP(MT_AGG_MRCR_RTS_FAIL_LIMIT, 1) |
 		 FIELD_PREP(MT_AGG_MRCR_TXCMD_RTS_FAIL_LIMIT, 1));
 
-	mt76_wr(dev, MT_TMAC_TFCR0(ext_phy), 0);
-	mt76_clear(dev, MT_TMAC_TCR0(ext_phy), MT_TMAC_TCR0_TBTT_STOP_CTRL);
+	mt76_wr(dev, MT_TMAC_TFCR0(phy->band_idx), 0);
+	mt76_clear(dev, MT_TMAC_TCR0(phy->band_idx), MT_TMAC_TCR0_TBTT_STOP_CTRL);
 
 	/* config rx filter for testmode rx */
-	mt76_wr(dev, MT_WF_RFCR(ext_phy), 0xcf70a);
-	mt76_wr(dev, MT_WF_RFCR1(ext_phy), 0);
+	mt76_wr(dev, MT_WF_RFCR(phy->band_idx), 0xcf70a);
+	mt76_wr(dev, MT_WF_RFCR1(phy->band_idx), 0);
 }
 
 static void
@@ -724,7 +722,6 @@ mt7915_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 {
 	struct mt7915_phy *phy = mphy->priv;
 	struct mt7915_dev *dev = phy->dev;
-	bool ext_phy = phy != &dev->phy;
 	enum mt76_rxq_id q;
 	void *rx, *rssi;
 	u16 fcs_err;
@@ -773,11 +770,11 @@ mt7915_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 
 	nla_nest_end(msg, rx);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR3(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDR3(phy->band_idx));
 	fcs_err = is_mt7915(&dev->mt76) ? FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK_MT7916, cnt);
 
-	q = ext_phy ? MT_RXQ_EXT : MT_RXQ_MAIN;
+	q = phy->band_idx ? MT_RXQ_EXT : MT_RXQ_MAIN;
 	mphy->test.rx_stats.packets[q] += fcs_err;
 	mphy->test.rx_stats.fcs_error[q] += fcs_err;
 
-- 
2.18.0

