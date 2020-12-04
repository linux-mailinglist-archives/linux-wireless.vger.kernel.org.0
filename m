Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DD02CEB10
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 10:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgLDJiL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 04:38:11 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52962 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729445AbgLDJiL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 04:38:11 -0500
X-UUID: 67c47fcf2447410b93508b3ddfc15371-20201204
X-UUID: 67c47fcf2447410b93508b3ddfc15371-20201204
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1858085027; Fri, 04 Dec 2020 17:37:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Dec 2020 17:37:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Dec 2020 17:37:19 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 5/5] mt76: mt7615: move testmode data from dev to phy
Date:   Fri, 4 Dec 2020 17:36:59 +0800
Message-ID: <20201204093659.20384-5-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201204093659.20384-1-shayne.chen@mediatek.com>
References: <20201204093659.20384-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 97721689F1F41A496701328FEA42E56069F4E91844D857AC66F55DAFAEC4AE8F2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move per-chip testmode data to mt7615_phy, to properly support
reg_backup and rx status of each band in testmode.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 18 +++++++--------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    | 22 +++++++++----------
 .../wireless/mediatek/mt76/mt7615/testmode.c  | 21 +++++++++---------
 3 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 0f360be0b885..9d8c6f34b3ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -186,7 +186,7 @@ mt7615_get_status_freq_info(struct mt7615_dev *dev, struct mt76_phy *mphy,
 	status->freq = ieee80211_channel_to_frequency(chfreq, status->band);
 }
 
-static void mt7615_mac_fill_tm_rx(struct mt7615_dev *dev, __le32 *rxv)
+static void mt7615_mac_fill_tm_rx(struct mt7615_phy *phy, __le32 *rxv)
 {
 #ifdef CONFIG_NL80211_TESTMODE
 	u32 rxv1 = le32_to_cpu(rxv[0]);
@@ -210,13 +210,13 @@ static void mt7615_mac_fill_tm_rx(struct mt7615_dev *dev, __le32 *rxv)
 		foe = (foe * foe_const) >> 15;
 	}
 
-	dev->test.last_freq_offset = foe;
-	dev->test.last_rcpi[0] = FIELD_GET(MT_RXV4_RCPI0, rxv4);
-	dev->test.last_rcpi[1] = FIELD_GET(MT_RXV4_RCPI1, rxv4);
-	dev->test.last_rcpi[2] = FIELD_GET(MT_RXV4_RCPI2, rxv4);
-	dev->test.last_rcpi[3] = FIELD_GET(MT_RXV4_RCPI3, rxv4);
-	dev->test.last_ib_rssi[0] = FIELD_GET(MT_RXV3_IB_RSSI, rxv3);
-	dev->test.last_wb_rssi[0] = FIELD_GET(MT_RXV3_WB_RSSI, rxv3);
+	phy->test.last_freq_offset = foe;
+	phy->test.last_rcpi[0] = FIELD_GET(MT_RXV4_RCPI0, rxv4);
+	phy->test.last_rcpi[1] = FIELD_GET(MT_RXV4_RCPI1, rxv4);
+	phy->test.last_rcpi[2] = FIELD_GET(MT_RXV4_RCPI2, rxv4);
+	phy->test.last_rcpi[3] = FIELD_GET(MT_RXV4_RCPI3, rxv4);
+	phy->test.last_ib_rssi[0] = FIELD_GET(MT_RXV3_IB_RSSI, rxv3);
+	phy->test.last_wb_rssi[0] = FIELD_GET(MT_RXV3_WB_RSSI, rxv3);
 #endif
 }
 
@@ -435,7 +435,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 					     status->chain_signal[i]);
 		}
 
-		mt7615_mac_fill_tm_rx(dev, rxd);
+		mt7615_mac_fill_tm_rx(mphy->priv, rxd);
 
 		rxd += 6;
 		if ((u8 *)rxd - skb->data >= skb->len)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 99b8abdbb08f..50e732bcb0d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -195,6 +195,17 @@ struct mt7615_phy {
 	struct timer_list roc_timer;
 	wait_queue_head_t roc_wait;
 	bool roc_grant;
+
+#ifdef CONFIG_NL80211_TESTMODE
+	struct {
+		u32 *reg_backup;
+
+		s16 last_freq_offset;
+		u8 last_rcpi[4];
+		s8 last_ib_rssi[4];
+		s8 last_wb_rssi[4];
+	} test;
+#endif
 };
 
 #define mt7615_mcu_add_tx_ba(dev, ...)	(dev)->mcu_ops->add_tx_ba((dev), __VA_ARGS__)
@@ -281,17 +292,6 @@ struct mt7615_dev {
 
 	u32 muar_mask;
 
-#ifdef CONFIG_NL80211_TESTMODE
-	struct {
-		u32 *reg_backup;
-
-		s16 last_freq_offset;
-		u8 last_rcpi[4];
-		s8 last_ib_rssi[4];
-		s8 last_wb_rssi[4];
-	} test;
-#endif
-
 	struct {
 		bool enable;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
index f70367d2d317..b82915445d0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
@@ -98,12 +98,12 @@ static void
 mt7615_tm_reg_backup_restore(struct mt7615_phy *phy)
 {
 	struct mt7615_dev *dev = phy->dev;
-	u32 *b = dev->test.reg_backup;
+	u32 *b = phy->test.reg_backup;
 	int n_regs = ARRAY_SIZE(reg_backup_list);
 	int n_rf_regs = ARRAY_SIZE(rf_backup_list);
 	int i;
 
-	if (dev->mphy.test.state == MT76_TM_STATE_OFF) {
+	if (phy->mt76->test.state == MT76_TM_STATE_OFF) {
 		for (i = 0; i < n_regs; i++)
 			mt76_wr(dev, reg_backup_list[i], b[i]);
 
@@ -121,7 +121,7 @@ mt7615_tm_reg_backup_restore(struct mt7615_phy *phy)
 	if (!b)
 		return;
 
-	dev->test.reg_backup = b;
+	phy->test.reg_backup = b;
 	for (i = 0; i < n_regs; i++)
 		b[i] = mt76_rr(dev, reg_backup_list[i]);
 	for (i = 0; i < n_rf_regs; i++)
@@ -323,7 +323,6 @@ static int
 mt7615_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 {
 	struct mt7615_phy *phy = mphy->priv;
-	struct mt7615_dev *dev = phy->dev;
 	void *rx, *rssi;
 	int i;
 
@@ -331,15 +330,15 @@ mt7615_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
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
@@ -348,8 +347,8 @@ mt7615_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 	if (!rssi)
 		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(dev->test.last_ib_rssi); i++)
-		if (nla_put_s8(msg, i, dev->test.last_ib_rssi[i]))
+	for (i = 0; i < ARRAY_SIZE(phy->test.last_ib_rssi); i++)
+		if (nla_put_s8(msg, i, phy->test.last_ib_rssi[i]))
 			return -ENOMEM;
 
 	nla_nest_end(msg, rssi);
@@ -358,8 +357,8 @@ mt7615_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 	if (!rssi)
 		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(dev->test.last_wb_rssi); i++)
-		if (nla_put_s8(msg, i, dev->test.last_wb_rssi[i]))
+	for (i = 0; i < ARRAY_SIZE(phy->test.last_wb_rssi); i++)
+		if (nla_put_s8(msg, i, phy->test.last_wb_rssi[i]))
 			return -ENOMEM;
 
 	nla_nest_end(msg, rssi);
-- 
2.17.1

