Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E012CEB0F
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 10:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgLDJiK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 04:38:10 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:54965 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729564AbgLDJiK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 04:38:10 -0500
X-UUID: 5574281843a74a3ea37df9cff6462299-20201204
X-UUID: 5574281843a74a3ea37df9cff6462299-20201204
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1218555554; Fri, 04 Dec 2020 17:37:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Dec 2020 17:37:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Dec 2020 17:37:18 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 4/5] mt76: mt7915: move testmode data from dev to phy
Date:   Fri, 4 Dec 2020 17:36:58 +0800
Message-ID: <20201204093659.20384-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201204093659.20384-1-shayne.chen@mediatek.com>
References: <20201204093659.20384-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move per-chip testmode data to mt7915_phy, to properly support
reg_backup and rx status of each band in testmode.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 20 ++++++++-----
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |  2 ++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 28 +++++++++----------
 .../wireless/mediatek/mt76/mt7915/testmode.c  | 25 ++++++++---------
 4 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index ddaaad22b308..241d89a99caf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -565,13 +565,20 @@ int mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 #ifdef CONFIG_NL80211_TESTMODE
 void mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb)
 {
+	struct mt7915_phy *phy = &dev->phy;
 	__le32 *rxd = (__le32 *)skb->data;
+	__le32 *rxv_hdr = rxd + 2;
 	__le32 *rxv = rxd + 4;
 	u32 rcpi, ib_rssi, wb_rssi, v20, v21;
+	bool ext_phy;
 	s32 foe;
 	u8 snr;
 	int i;
 
+	ext_phy = FIELD_GET(MT_RXV_HDR_BAND_IDX, le32_to_cpu(rxv_hdr[1]));
+	if (ext_phy)
+		phy = mt7915_ext_phy(dev);
+
 	rcpi = le32_to_cpu(rxv[6]);
 	ib_rssi = le32_to_cpu(rxv[7]);
 	wb_rssi = le32_to_cpu(rxv[8]) >> 5;
@@ -580,9 +587,9 @@ void mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb)
 		if (i == 3)
 			wb_rssi = le32_to_cpu(rxv[9]);
 
-		dev->test.last_rcpi[i] = rcpi & 0xff;
-		dev->test.last_ib_rssi[i] = ib_rssi & 0xff;
-		dev->test.last_wb_rssi[i] = wb_rssi & 0xff;
+		phy->test.last_rcpi[i] = rcpi & 0xff;
+		phy->test.last_ib_rssi[i] = ib_rssi & 0xff;
+		phy->test.last_wb_rssi[i] = wb_rssi & 0xff;
 	}
 
 	v20 = le32_to_cpu(rxv[20]);
@@ -593,8 +600,8 @@ void mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	snr = FIELD_GET(MT_CRXV_SNR, v20) - 16;
 
-	dev->test.last_freq_offset = foe;
-	dev->test.last_snr = snr;
+	phy->test.last_freq_offset = foe;
+	phy->test.last_snr = snr;
 
 	dev_kfree_skb(skb);
 }
@@ -606,7 +613,6 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
 {
 #ifdef CONFIG_NL80211_TESTMODE
 	struct mt76_testmode_data *td = &phy->mt76->test;
-	struct mt7915_dev *dev = phy->dev;
 	u8 rate_idx = td->tx_rate_idx;
 	u8 nss = td->tx_rate_nss;
 	u8 bw, mode;
@@ -699,7 +705,7 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
 
 	txwi[6] |= cpu_to_le32(val);
 	txwi[7] |= cpu_to_le32(FIELD_PREP(MT_TXD7_SPE_IDX,
-					  dev->test.spe_idx));
+					  phy->test.spe_idx));
 #endif
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index d420392b952d..96ff3fb0d1f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -95,6 +95,8 @@ enum rx_pkt_type {
 #define MT_RXD3_NORMAL_PF_MODE		BIT(29)
 #define MT_RXD3_NORMAL_PF_STS		GENMASK(31, 30)
 
+#define MT_RXV_HDR_BAND_IDX		BIT(24)
+
 /* P-RXV */
 #define MT_PRXV_TX_RATE			GENMASK(6, 0)
 #define MT_PRXV_TX_DCM			BIT(4)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 30e53a0f01fb..b9279fd17b3f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -135,6 +135,20 @@ struct mt7915_phy {
 	struct delayed_work mac_work;
 	u8 mac_work_count;
 	u8 sta_work_count;
+
+#ifdef CONFIG_NL80211_TESTMODE
+	struct {
+		u32 *reg_backup;
+
+		s32 last_freq_offset;
+		u8 last_rcpi[4];
+		s8 last_ib_rssi[4];
+		s8 last_wb_rssi[4];
+		u8 last_snr;
+
+		u8 spe_idx;
+	} test;
+#endif
 };
 
 struct mt7915_dev {
@@ -167,20 +181,6 @@ struct mt7915_dev {
 
 	bool dbdc_support;
 	bool fw_debug;
-
-#ifdef CONFIG_NL80211_TESTMODE
-	struct {
-		u32 *reg_backup;
-
-		s32 last_freq_offset;
-		u8 last_rcpi[4];
-		s8 last_ib_rssi[4];
-		s8 last_wb_rssi[4];
-		u8 last_snr;
-
-		u8 spe_idx;
-	} test;
-#endif
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index e648f718adb8..b58c91ea3fa5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -138,10 +138,10 @@ mt7915_tm_reg_backup_restore(struct mt7915_phy *phy)
 	int n_regs = ARRAY_SIZE(reg_backup_list);
 	struct mt7915_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
-	u32 *b = dev->test.reg_backup;
+	u32 *b = phy->test.reg_backup;
 	int i;
 
-	if (dev->mphy.test.state == MT76_TM_STATE_OFF) {
+	if (phy->mt76->test.state == MT76_TM_STATE_OFF) {
 		for (i = 0; i < n_regs; i++)
 			mt76_wr(dev, reg_backup_list[i].band[ext_phy], b[i]);
 		return;
@@ -154,7 +154,7 @@ mt7915_tm_reg_backup_restore(struct mt7915_phy *phy)
 	if (!b)
 		return;
 
-	dev->test.reg_backup = b;
+	phy->test.reg_backup = b;
 	for (i = 0; i < n_regs; i++)
 		b[i] = mt76_rr(dev, reg_backup_list[i].band[ext_phy]);
 
@@ -222,7 +222,7 @@ mt7915_tm_set_tx_frames(struct mt7915_phy *phy, bool en)
 
 		if (phy != &dev->phy)
 			tx_ant >>= 2;
-		dev->test.spe_idx = spe_idx_map[tx_ant];
+		phy->test.spe_idx = spe_idx_map[tx_ant];
 	}
 
 	mt7915_tm_set_trx(phy, TM_MAC_TX, en);
@@ -333,7 +333,6 @@ static int
 mt7915_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 {
 	struct mt7915_phy *phy = mphy->priv;
-	struct mt7915_dev *dev = phy->dev;
 	void *rx, *rssi;
 	int i;
 
@@ -341,15 +340,15 @@ mt7915_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 	if (!rx)
 		return -ENOMEM;
 
-	if (nla_put_s32(msg, MT76_TM_RX_ATTR_FREQ_OFFSET, dev->test.last_freq_offset))
+	if (nla_put_s32(msg, MT76_TM_RX_ATTR_FREQ_OFFSET, phy->test.last_freq_offset))
 		return -ENOMEM;
 
 	rssi = nla_nest_start(msg, MT76_TM_RX_ATTR_RCPI);
 	if (!rssi)
 		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(dev->test.last_rcpi); i++)
-		if (nla_put_u8(msg, i, dev->test.last_rcpi[i]))
+	for (i = 0; i < ARRAY_SIZE(phy->test.last_rcpi); i++)
+		if (nla_put_u8(msg, i, phy->test.last_rcpi[i]))
 			return -ENOMEM;
 
 	nla_nest_end(msg, rssi);
@@ -358,8 +357,8 @@ mt7915_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 	if (!rssi)
 		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(dev->test.last_ib_rssi); i++)
-		if (nla_put_s8(msg, i, dev->test.last_ib_rssi[i]))
+	for (i = 0; i < ARRAY_SIZE(phy->test.last_ib_rssi); i++)
+		if (nla_put_s8(msg, i, phy->test.last_ib_rssi[i]))
 			return -ENOMEM;
 
 	nla_nest_end(msg, rssi);
@@ -368,13 +367,13 @@ mt7915_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 	if (!rssi)
 		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(dev->test.last_wb_rssi); i++)
-		if (nla_put_s8(msg, i, dev->test.last_wb_rssi[i]))
+	for (i = 0; i < ARRAY_SIZE(phy->test.last_wb_rssi); i++)
+		if (nla_put_s8(msg, i, phy->test.last_wb_rssi[i]))
 			return -ENOMEM;
 
 	nla_nest_end(msg, rssi);
 
-	if (nla_put_u8(msg, MT76_TM_RX_ATTR_SNR, dev->test.last_snr))
+	if (nla_put_u8(msg, MT76_TM_RX_ATTR_SNR, phy->test.last_snr))
 		return -ENOMEM;
 
 	nla_nest_end(msg, rx);
-- 
2.17.1

