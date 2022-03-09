Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8894D28F7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Mar 2022 07:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiCIGah (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Mar 2022 01:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCIGah (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Mar 2022 01:30:37 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2891136861
        for <linux-wireless@vger.kernel.org>; Tue,  8 Mar 2022 22:29:33 -0800 (PST)
X-UUID: f15d181ab9cc4a3097e46eea3120ef9e-20220309
X-UUID: f15d181ab9cc4a3097e46eea3120ef9e-20220309
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2015355683; Wed, 09 Mar 2022 14:29:27 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 9 Mar 2022 14:29:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Mar 2022 14:29:25 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: use le32/16_get_bits() whenever possible
Date:   Wed, 9 Mar 2022 14:29:24 +0800
Message-ID: <e6365d47178fe3f62186fbd94ce8294493254331.1646806346.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Switch to use le32/16_get_bits() to simplfy codes and specify
the size explicitly to avoid potential issues.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
This caught my eye https://lore.kernel.org/netdev/87pmsf60h0.fsf@codeaurora.org/
---
 .../net/wireless/mediatek/mt76/mt7603/dma.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  9 ++---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 20 +++++------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 35 +++++++------------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 31 +++++++---------
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   | 13 +++----
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  |  2 +-
 .../net/wireless/mediatek/mt76/sdio_txrx.c    |  2 +-
 8 files changed, 46 insertions(+), 68 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 415ea17b9be6..37b092e3ea51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -76,7 +76,7 @@ void mt7603_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	__le32 *end = (__le32 *)&skb->data[skb->len];
 	enum rx_pkt_type type;
 
-	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
+	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
 
 	if (q == MT_RXQ_MCU) {
 		if (type == PKT_TYPE_RX_EVENT)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 2e5d26616bc2..17713c821d80 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1130,7 +1130,7 @@ mt7603_fill_txs(struct mt7603_dev *dev, struct mt7603_sta *sta,
 	}
 
 	rate_set_tsf = READ_ONCE(sta->rate_set_tsf);
-	rs_idx = !((u32)(FIELD_GET(MT_TXS1_F0_TIMESTAMP, le32_to_cpu(txs_data[1])) -
+	rs_idx = !((u32)(le32_get_bits(txs_data[1], MT_TXS1_F0_TIMESTAMP) -
 			 rate_set_tsf) < 1000000);
 	rs_idx ^= rate_set_tsf & BIT(0);
 	rs = &sta->rateset[rs_idx];
@@ -1244,14 +1244,11 @@ void mt7603_mac_add_txs(struct mt7603_dev *dev, void *data)
 	struct mt7603_sta *msta = NULL;
 	struct mt76_wcid *wcid;
 	__le32 *txs_data = data;
-	u32 txs;
 	u8 wcidx;
 	u8 pid;
 
-	txs = le32_to_cpu(txs_data[4]);
-	pid = FIELD_GET(MT_TXS4_PID, txs);
-	txs = le32_to_cpu(txs_data[3]);
-	wcidx = FIELD_GET(MT_TXS3_WCID, txs);
+	pid = le32_get_bits(txs_data[4], MT_TXS4_PID);
+	wcidx = le32_get_bits(txs_data[3], MT_TXS3_WCID);
 
 	if (pid == MT_PACKET_ID_NO_ACK)
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index d1d87240f24f..bd687f7de628 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -261,7 +261,7 @@ static int mt7615_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	struct ieee80211_hdr hdr;
 	u16 frame_control;
 
-	if (FIELD_GET(MT_RXD1_NORMAL_ADDR_TYPE, le32_to_cpu(rxd[1])) !=
+	if (le32_get_bits(rxd[1], MT_RXD1_NORMAL_ADDR_TYPE) !=
 	    MT_RXD1_NORMAL_U2M)
 		return -EINVAL;
 
@@ -1427,7 +1427,7 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 	}
 
 	rate_set_tsf = READ_ONCE(sta->rate_set_tsf);
-	rs_idx = !((u32)(FIELD_GET(MT_TXS4_F0_TIMESTAMP, le32_to_cpu(txs_data[4])) -
+	rs_idx = !((u32)(le32_get_bits(txs_data[4], MT_TXS4_F0_TIMESTAMP) -
 			 rate_set_tsf) < 1000000);
 	rs_idx ^= rate_set_tsf & BIT(0);
 	rs = &sta->rateset[rs_idx];
@@ -1558,14 +1558,11 @@ static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 	struct mt76_wcid *wcid;
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	__le32 *txs_data = data;
-	u32 txs;
 	u8 wcidx;
 	u8 pid;
 
-	txs = le32_to_cpu(txs_data[0]);
-	pid = FIELD_GET(MT_TXS0_PID, txs);
-	txs = le32_to_cpu(txs_data[2]);
-	wcidx = FIELD_GET(MT_TXS2_WCID, txs);
+	pid = le32_get_bits(txs_data[0], MT_TXS0_PID);
+	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
 
 	if (pid == MT_PACKET_ID_NO_ACK)
 		return;
@@ -1653,7 +1650,7 @@ static void mt7615_mac_tx_free(struct mt7615_dev *dev, void *data, int len)
 			mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], false);
 	}
 
-	count = FIELD_GET(MT_TX_FREE_MSDU_ID_CNT, le16_to_cpu(free->ctrl));
+	count = le16_get_bits(free->ctrl, MT_TX_FREE_MSDU_ID_CNT);
 	if (is_mt7615(&dev->mt76)) {
 		__le16 *token = &free->token[0];
 
@@ -1686,7 +1683,8 @@ bool mt7615_rx_check(struct mt76_dev *mdev, void *data, int len)
 	__le32 *end = (__le32 *)&rxd[len / 4];
 	enum rx_pkt_type type;
 
-	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
+	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
+
 	switch (type) {
 	case PKT_TYPE_TXRX_NOTIFY:
 		mt7615_mac_tx_free(dev, data, len);
@@ -1710,8 +1708,8 @@ void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	enum rx_pkt_type type;
 	u16 flag;
 
-	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
-	flag = FIELD_GET(MT_RXD0_PKT_FLAG, le32_to_cpu(rxd[0]));
+	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
+	flag = le32_get_bits(rxd[0], MT_RXD0_PKT_FLAG);
 	if (type == PKT_TYPE_RX_EVENT && flag == 0x1)
 		type = PKT_TYPE_NORMAL_MCU;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 71e889b56581..0beac3049a2e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -226,8 +226,8 @@ mt7915_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
 	u32 ru_h, ru_l;
 	u8 ru, offs = 0;
 
-	ru_l = FIELD_GET(MT_PRXV_HE_RU_ALLOC_L, le32_to_cpu(rxv[0]));
-	ru_h = FIELD_GET(MT_PRXV_HE_RU_ALLOC_H, le32_to_cpu(rxv[1]));
+	ru_l = le32_get_bits(rxv[0], MT_PRXV_HE_RU_ALLOC_L);
+	ru_h = le32_get_bits(rxv[1], MT_PRXV_HE_RU_ALLOC_H);
 	ru = (u8)(ru_l | ru_h << 4);
 
 	status->bw = RATE_INFO_BW_HE_RU;
@@ -400,7 +400,7 @@ static int mt7915_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	struct ieee80211_hdr hdr;
 	u16 frame_control;
 
-	if (FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, le32_to_cpu(rxd[3])) !=
+	if (le32_get_bits(rxd[3], MT_RXD3_NORMAL_ADDR_TYPE) !=
 	    MT_RXD3_NORMAL_U2M)
 		return -EINVAL;
 
@@ -859,7 +859,7 @@ mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb)
 	u8 snr;
 	int i;
 
-	band_idx = FIELD_GET(MT_RXV_HDR_BAND_IDX, le32_to_cpu(rxv_hdr[1]));
+	band_idx = le32_get_bits(rxv_hdr[1], MT_RXV_HDR_BAND_IDX);
 	if (band_idx && !phy->band_idx)
 		phy = mt7915_ext_phy(dev);
 
@@ -1354,7 +1354,7 @@ mt7915_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 	if (!sta || !sta->ht_cap.ht_supported)
 		return;
 
-	tid = FIELD_GET(MT_TXD1_TID, le32_to_cpu(txwi[1]));
+	tid = le32_get_bits(txwi[1], MT_TXD1_TID);
 	if (tid >= 6) /* skip VO queue */
 		return;
 
@@ -1402,7 +1402,7 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
 			mt7915_tx_check_aggr(sta, txwi);
 	} else {
-		wcid_idx = FIELD_GET(MT_TXD1_WLAN_IDX, le32_to_cpu(txwi[1]));
+		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
 	}
 
 	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
@@ -1436,12 +1436,7 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 		mt76_queue_tx_cleanup(dev, mphy_ext->q_tx[MT_TXQ_BE], false);
 	}
 
-	/*
-	 * TODO: MT_TX_FREE_LATENCY is msdu time from the TXD is queued into PLE,
-	 * to the time ack is received or dropped by hw (air + hw queue time).
-	 * Should avoid accessing WTBL to get Tx airtime, and use it instead.
-	 */
-	total = FIELD_GET(MT_TX_FREE_MSDU_CNT, le16_to_cpu(free->ctrl));
+	total = le16_get_bits(free->ctrl, MT_TX_FREE_MSDU_CNT);
 	v3 = (FIELD_GET(MT_TX_FREE_VER, txd) == 0x4);
 	if (WARN_ON_ONCE((void *)&free->info[total >> v3] > end))
 		return;
@@ -1632,18 +1627,13 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	struct mt76_wcid *wcid;
 	__le32 *txs_data = data;
 	u16 wcidx;
-	u32 txs;
 	u8 pid;
 
-	txs = le32_to_cpu(txs_data[0]);
-	if (FIELD_GET(MT_TXS0_TXS_FORMAT, txs) > 1)
+	if (le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT) > 1)
 		return;
 
-	txs = le32_to_cpu(txs_data[2]);
-	wcidx = FIELD_GET(MT_TXS2_WCID, txs);
-
-	txs = le32_to_cpu(txs_data[3]);
-	pid = FIELD_GET(MT_TXS3_PID, txs);
+	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
+	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
 
 	if (pid < MT_PACKET_ID_FIRST)
 		return;
@@ -1680,7 +1670,8 @@ bool mt7915_rx_check(struct mt76_dev *mdev, void *data, int len)
 	__le32 *end = (__le32 *)&rxd[len / 4];
 	enum rx_pkt_type type;
 
-	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
+	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
+
 	switch (type) {
 	case PKT_TYPE_TXRX_NOTIFY:
 		mt7915_mac_tx_free(dev, data, len);
@@ -1705,7 +1696,7 @@ void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	__le32 *end = (__le32 *)&skb->data[skb->len];
 	enum rx_pkt_type type;
 
-	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
+	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
 
 	switch (type) {
 	case PKT_TYPE_TXRX_NOTIFY:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index ea2a655acc6a..8bd8b4fe1047 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -176,8 +176,8 @@ mt7921_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
 	u32 ru_h, ru_l;
 	u8 ru, offs = 0;
 
-	ru_l = FIELD_GET(MT_PRXV_HE_RU_ALLOC_L, le32_to_cpu(rxv[0]));
-	ru_h = FIELD_GET(MT_PRXV_HE_RU_ALLOC_H, le32_to_cpu(rxv[1]));
+	ru_l = le32_get_bits(rxv[0], MT_PRXV_HE_RU_ALLOC_L);
+	ru_h = le32_get_bits(rxv[1], MT_PRXV_HE_RU_ALLOC_H);
 	ru = (u8)(ru_l | ru_h << 4);
 
 	status->bw = RATE_INFO_BW_HE_RU;
@@ -247,19 +247,19 @@ mt7921_mac_decode_he_mu_radiotap(struct sk_buff *skb, __le32 *rxv)
 			 MU_PREP(FLAGS2_SIG_B_SYMS_USERS,
 				 le32_get_bits(rxv[2], MT_CRXV_HE_NUM_USER));
 
-	he_mu->ru_ch1[0] = FIELD_GET(MT_CRXV_HE_RU0, le32_to_cpu(rxv[3]));
+	he_mu->ru_ch1[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU0);
 
 	if (status->bw >= RATE_INFO_BW_40) {
 		he_mu->flags1 |= HE_BITS(MU_FLAGS1_CH2_RU_KNOWN);
 		he_mu->ru_ch2[0] =
-			FIELD_GET(MT_CRXV_HE_RU1, le32_to_cpu(rxv[3]));
+			le32_get_bits(rxv[3], MT_CRXV_HE_RU1);
 	}
 
 	if (status->bw >= RATE_INFO_BW_80) {
 		he_mu->ru_ch1[1] =
-			FIELD_GET(MT_CRXV_HE_RU2, le32_to_cpu(rxv[3]));
+			le32_get_bits(rxv[3], MT_CRXV_HE_RU2);
 		he_mu->ru_ch2[1] =
-			FIELD_GET(MT_CRXV_HE_RU3, le32_to_cpu(rxv[3]));
+			le32_get_bits(rxv[3], MT_CRXV_HE_RU3);
 	}
 }
 
@@ -409,7 +409,7 @@ static int mt7921_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	struct ieee80211_hdr hdr;
 	u16 frame_control;
 
-	if (FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, le32_to_cpu(rxd[3])) !=
+	if (le32_get_bits(rxd[3], MT_RXD3_NORMAL_ADDR_TYPE) !=
 	    MT_RXD3_NORMAL_U2M)
 		return -EINVAL;
 
@@ -1024,7 +1024,7 @@ void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 	if (!sta || !(sta->ht_cap.ht_supported || sta->he_cap.has_he))
 		return;
 
-	tid = FIELD_GET(MT_TXD1_TID, le32_to_cpu(txwi[1]));
+	tid = le32_get_bits(txwi[1], MT_TXD1_TID);
 	if (tid >= 6) /* skip VO queue */
 		return;
 
@@ -1163,18 +1163,13 @@ void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
 	struct mt76_wcid *wcid;
 	__le32 *txs_data = data;
 	u16 wcidx;
-	u32 txs;
 	u8 pid;
 
-	txs = le32_to_cpu(txs_data[0]);
-	if (FIELD_GET(MT_TXS0_TXS_FORMAT, txs) > 1)
+	if (le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT) > 1)
 		return;
 
-	txs = le32_to_cpu(txs_data[2]);
-	wcidx = FIELD_GET(MT_TXS2_WCID, txs);
-
-	txs = le32_to_cpu(txs_data[3]);
-	pid = FIELD_GET(MT_TXS3_PID, txs);
+	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
+	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
 
 	if (pid < MT_PACKET_ID_FIRST)
 		return;
@@ -1213,8 +1208,8 @@ void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	enum rx_pkt_type type;
 	u16 flag;
 
-	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
-	flag = FIELD_GET(MT_RXD0_PKT_FLAG, le32_to_cpu(rxd[0]));
+	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
+	flag = le32_get_bits(rxd[0], MT_RXD0_PKT_FLAG);
 
 	if (type == PKT_TYPE_RX_EVENT && flag == 0x1)
 		type = PKT_TYPE_NORMAL_MCU;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 8ca58293ddf1..5ca14dbbdd26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -137,7 +137,7 @@ mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
 
 		wcid_idx = wcid->idx;
 	} else {
-		wcid_idx = FIELD_GET(MT_TXD1_WLAN_IDX, le32_to_cpu(txwi[1]));
+		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
 	}
 
 	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
@@ -164,11 +164,7 @@ mt7921e_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
 	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
 	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
 
-	/* TODO: MT_TX_FREE_LATENCY is msdu time from the TXD is queued into PLE,
-	 * to the time ack is received or dropped by hw (air + hw queue time).
-	 * Should avoid accessing WTBL to get Tx airtime, and use it instead.
-	 */
-	count = FIELD_GET(MT_TX_FREE_MSDU_CNT, le16_to_cpu(free->ctrl));
+	count = le16_get_bits(free->ctrl, MT_TX_FREE_MSDU_CNT);
 	if (WARN_ON_ONCE((void *)&free->info[count] > end))
 		return;
 
@@ -231,7 +227,8 @@ bool mt7921e_rx_check(struct mt76_dev *mdev, void *data, int len)
 	__le32 *end = (__le32 *)&rxd[len / 4];
 	enum rx_pkt_type type;
 
-	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
+	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
+
 	switch (type) {
 	case PKT_TYPE_TXRX_NOTIFY:
 		mt7921e_mac_tx_free(dev, data, len);
@@ -252,7 +249,7 @@ void mt7921e_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	__le32 *rxd = (__le32 *)skb->data;
 	enum rx_pkt_type type;
 
-	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
+	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
 
 	switch (type) {
 	case PKT_TYPE_TXRX_NOTIFY:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index 4fd1d4765b04..09bcabd6cb8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -202,7 +202,7 @@ void mt7921s_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 	struct mt76_wcid *wcid;
 	u16 idx;
 
-	idx = FIELD_GET(MT_TXD1_WLAN_IDX, le32_to_cpu(txwi[1]));
+	idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
 	wcid = rcu_dereference(mdev->wcid[idx]);
 	sta = wcid_to_sta(wcid);
 
diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index 9fcf507e09bd..a2601aa9e7b1 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -118,7 +118,7 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 		__le32 *rxd = (__le32 *)buf;
 
 		/* parse rxd to get the actual packet length */
-		len = FIELD_GET(GENMASK(15, 0), le32_to_cpu(rxd[0]));
+		len = le32_get_bits(rxd[0], GENMASK(15, 0));
 		e->skb = mt76s_build_rx_skb(buf, len, round_up(len + 4, 4));
 		if (!e->skb)
 			break;
-- 
2.29.2

