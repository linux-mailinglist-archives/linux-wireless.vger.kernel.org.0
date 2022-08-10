Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C6658F08F
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Aug 2022 18:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiHJQlD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Aug 2022 12:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiHJQlB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Aug 2022 12:41:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34266CC6
        for <linux-wireless@vger.kernel.org>; Wed, 10 Aug 2022 09:40:54 -0700 (PDT)
X-UUID: aca97940c8ed422a9a431165fb786603-20220811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ddul03CNSFdwG10oEIvInCTND+aMqKYr8aKYBC14Gc8=;
        b=Z4k+47+ArDKxILSsFwhawlQfOipXWH4Mkf0EMgt9Mu6B8X7oEl5T9rGxV7zpaRezEI81LqyFObd/sU9xd1rbnjqIRG28MGJ7FNcB7wUnxNkYrXCJWCs2WW88FLnBt4KwMG9pIVGXQX0yTZvLbWF8yunTPxbdeAbSyAxqm6SIE2g=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:22a80a1e-c132-49a0-a3ef-9538fdb7d071,OB:10,L
        OB:10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Relea
        se_Ham,ACTION:release,TS:105
X-CID-INFO: VERSION:1.1.9,REQID:22a80a1e-c132-49a0-a3ef-9538fdb7d071,OB:10,LOB
        :10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS
        981B3D,ACTION:quarantine,TS:105
X-CID-META: VersionHash:3d8acc9,CLOUDID:530c73ae-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:d3cd4ef857b6,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: aca97940c8ed422a9a431165fb786603-20220811
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 282987944; Thu, 11 Aug 2022 00:40:47 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 11 Aug 2022 00:40:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 11 Aug 2022 00:40:46 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
Subject: [PATCH 2/2] mt76: add PPDU based TxS support for WED device
Date:   Thu, 11 Aug 2022 00:40:44 +0800
Message-ID: <dcd41df64a71d1a93fffe7c1d14dbcc7567b1482.1660092593.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <a9ded159fd293b25c745dea966e5b00a2601e56d.1660092593.git.ryder.lee@mediatek.com>
References: <a9ded159fd293b25c745dea966e5b00a2601e56d.1660092593.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_CSS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Given that there's no data coming from network stack for binding flows,
hence driver counts and reports station's statistics directly through
NL80211_STA_INFO_* based on active PPDU based TxS for offloading data.

Apart from that, WA firmware and its offloading engine (SDO) have hardcoded
"2" as PID, so we introduce MT_PACKET_ID_WED to differentiate WED reporting.

Note that PPDU format TxS is mutually exclusive with MT_TXD5_TX_STATUS_HOST.

Co-developed-by: Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
Signed-off-by: Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  7 +-
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  2 +
 .../wireless/mediatek/mt76/mt76_connac2_mac.h |  8 ++
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 74 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 14 ++--
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 17 +++++
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  2 +
 .../net/wireless/mediatek/mt76/mt7915/pci.c   | 23 +++++-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  4 +
 9 files changed, 118 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index a45dd038b967..2a86fc591e12 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -270,6 +270,10 @@ struct mt76_sta_stats {
 	u64 tx_bw[4];		/* 20, 40, 80, 160 */
 	u64 tx_nss[4];		/* 1, 2, 3, 4 */
 	u64 tx_mcs[16];		/* mcs idx */
+	u64 tx_bytes;
+	u32 tx_packets;
+	u32 tx_retries;
+	u32 tx_failed;
 };
 
 enum mt76_wcid_flags {
@@ -364,7 +368,8 @@ struct mt76_rx_tid {
 #define MT_PACKET_ID_MASK		GENMASK(6, 0)
 #define MT_PACKET_ID_NO_ACK		0
 #define MT_PACKET_ID_NO_SKB		1
-#define MT_PACKET_ID_FIRST		2
+#define MT_PACKET_ID_WED		2
+#define MT_PACKET_ID_FIRST		3
 #define MT_PACKET_ID_HAS_RATE		BIT(7)
 /* This is timer for when to give up when waiting for TXS callback,
  * with starting time being the time at which the DMA_DONE callback
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 851874f782c5..635192c878cb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -354,6 +354,8 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 				 struct sk_buff *skb, struct mt76_wcid *wcid,
 				 struct ieee80211_key_conf *key, int pid,
 				 enum mt76_txq_id qid, u32 changed);
+bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
+			       __le32 *txs_data);
 bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
 				  int pid, __le32 *txs_data);
 void mt76_connac2_mac_decode_he_radiotap(struct mt76_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
index 67ce216fb564..f33171bcd343 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
@@ -158,6 +158,14 @@ enum {
 
 #define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
 
+/* PPDU based TXS */
+#define MT_TXS5_MPDU_TX_BYTE		GENMASK(22, 0)
+#define MT_TXS5_MPDU_TX_CNT		GENMASK(31, 23)
+
+#define MT_TXS6_MPDU_FAIL_CNT		GENMASK(31, 23)
+
+#define MT_TXS7_MPDU_RETRY_CNT		GENMASK(31, 23)
+
 /* RXD DW1 */
 #define MT_RXD1_NORMAL_WLAN_IDX		GENMASK(9, 0)
 #define MT_RXD1_NORMAL_GROUP_1		BIT(11)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index d0a94cb6d08b..34ac3d81a510 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -490,6 +490,10 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 		p_fmt = mt76_is_mmio(dev) ? MT_TX_TYPE_CT : MT_TX_TYPE_SF;
 		q_idx = wmm_idx * MT76_CONNAC_MAX_WMM_SETS +
 			mt76_connac_lmac_mapping(skb_get_queue_mapping(skb));
+
+		/* counting non-offloading skbs */
+		wcid->stats.tx_bytes += skb->len;
+		wcid->stats.tx_packets++;
 	}
 
 	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + sz_txd) |
@@ -550,35 +554,29 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_mac_write_txwi);
 
-bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
-				  int pid, __le32 *txs_data)
+bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
+			       __le32 *txs_data)
 {
 	struct mt76_sta_stats *stats = &wcid->stats;
 	struct ieee80211_supported_band *sband;
 	struct mt76_phy *mphy;
-	struct ieee80211_tx_info *info;
-	struct sk_buff_head list;
 	struct rate_info rate = {};
-	struct sk_buff *skb;
 	bool cck = false;
 	u32 txrate, txs, mode;
 
-	mt76_tx_status_lock(dev, &list);
-	skb = mt76_tx_status_skb_get(dev, wcid, pid, &list);
-	if (!skb)
-		goto out;
-
 	txs = le32_to_cpu(txs_data[0]);
 
-	info = IEEE80211_SKB_CB(skb);
-	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
-		info->flags |= IEEE80211_TX_STAT_ACK;
-
-	info->status.ampdu_len = 1;
-	info->status.ampdu_ack_len = !!(info->flags &
-					IEEE80211_TX_STAT_ACK);
-
-	info->status.rates[0].idx = -1;
+	/* PPDU based reporting */
+	if (FIELD_GET(MT_TXS0_TXS_FORMAT, txs) > 1) {
+		stats->tx_bytes +=
+			le32_get_bits(txs_data[5], MT_TXS5_MPDU_TX_BYTE);
+		stats->tx_packets +=
+			le32_get_bits(txs_data[5], MT_TXS5_MPDU_TX_CNT);
+		stats->tx_failed +=
+			le32_get_bits(txs_data[6], MT_TXS6_MPDU_FAIL_CNT);
+		stats->tx_retries +=
+			le32_get_bits(txs_data[7], MT_TXS7_MPDU_RETRY_CNT);
+	}
 
 	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
 
@@ -613,7 +611,7 @@ bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	case MT_PHY_TYPE_HT:
 	case MT_PHY_TYPE_HT_GF:
 		if (rate.mcs > 31)
-			goto out;
+			return false;
 
 		rate.flags = RATE_INFO_FLAGS_MCS;
 		if (wcid->rate.flags & RATE_INFO_FLAGS_SHORT_GI)
@@ -621,7 +619,7 @@ bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
 		break;
 	case MT_PHY_TYPE_VHT:
 		if (rate.mcs > 9)
-			goto out;
+			return false;
 
 		rate.flags = RATE_INFO_FLAGS_VHT_MCS;
 		break;
@@ -630,14 +628,14 @@ bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	case MT_PHY_TYPE_HE_TB:
 	case MT_PHY_TYPE_HE_MU:
 		if (rate.mcs > 11)
-			goto out;
+			return false;
 
 		rate.he_gi = wcid->rate.he_gi;
 		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
 		rate.flags = RATE_INFO_FLAGS_HE_MCS;
 		break;
 	default:
-		goto out;
+		return false;
 	}
 
 	stats->tx_mode[mode]++;
@@ -662,10 +660,34 @@ bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	}
 	wcid->rate = rate;
 
-out:
-	if (skb)
-		mt76_tx_status_skb_done(dev, skb, &list);
+	return true;
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mac_fill_txs);
+
+bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
+				  int pid, __le32 *txs_data)
+{
+	struct sk_buff_head list;
+	struct sk_buff *skb;
 
+	mt76_tx_status_lock(dev, &list);
+	skb = mt76_tx_status_skb_get(dev, wcid, pid, &list);
+	if (skb) {
+		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+		bool noacked = !(info->flags & IEEE80211_TX_STAT_ACK);
+
+		if (!(le32_to_cpu(txs_data[0]) & MT_TXS0_ACK_ERROR_MASK))
+			info->flags |= IEEE80211_TX_STAT_ACK;
+
+		info->status.ampdu_len = 1;
+		info->status.ampdu_ack_len = !noacked;
+		info->status.rates[0].idx = -1;
+
+		wcid->stats.tx_failed += noacked;
+
+		mt76_connac2_mac_fill_txs(dev, wcid, txs_data);
+		mt76_tx_status_skb_done(dev, skb, &list);
+	}
 	mt76_tx_status_unlock(dev, &list);
 
 	return !!skb;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 3ae5f1359483..aec6c00f35e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -176,7 +176,7 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		/*
 		 * We don't support reading GI info from txs packets.
 		 * For accurate tx status reporting and AQL improvement,
-		  we need to make sure that flags match so polling GI
+		 * we need to make sure that flags match so polling GI
 		 * from per-sta counters directly.
 		 */
 		rate = &msta->wcid.rate;
@@ -1001,7 +1001,7 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
 	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
 
-	if (pid < MT_PACKET_ID_FIRST)
+	if (pid < MT_PACKET_ID_WED)
 		return;
 
 	if (wcidx >= mt7915_wtbl_size(dev))
@@ -1015,7 +1015,11 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 
 	msta = container_of(wcid, struct mt7915_sta, wcid);
 
-	mt76_connac2_mac_add_txs_skb(&dev->mt76, wcid, pid, txs_data);
+	if (pid == MT_PACKET_ID_WED)
+		mt76_connac2_mac_fill_txs(&dev->mt76, wcid, txs_data);
+	else
+		mt76_connac2_mac_add_txs_skb(&dev->mt76, wcid, pid, txs_data);
+
 	if (!wcid->sta)
 		goto out;
 
@@ -1046,7 +1050,7 @@ bool mt7915_rx_check(struct mt76_dev *mdev, void *data, int len)
 		return false;
 	case PKT_TYPE_TXS:
 		for (rxd += 2; rxd + 8 <= end; rxd += 8)
-		    mt7915_mac_add_txs(dev, rxd);
+			mt7915_mac_add_txs(dev, rxd);
 		return false;
 	case PKT_TYPE_RX_FW_MONITOR:
 		mt7915_debugfs_rx_fw_monitor(dev, data, len);
@@ -1083,7 +1087,7 @@ void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		break;
 	case PKT_TYPE_TXS:
 		for (rxd += 2; rxd + 8 <= end; rxd += 8)
-		    mt7915_mac_add_txs(dev, rxd);
+			mt7915_mac_add_txs(dev, rxd);
 		dev_kfree_skb(skb);
 		break;
 	case PKT_TYPE_RX_FW_MONITOR:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 090c52803052..89b519cfd14c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1010,6 +1010,23 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 	}
 	sinfo->txrate.flags = txrate->flags;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+
+	/* offloading flows bypass networking stack, so driver counts and
+	 * reports sta statistics via NL80211_STA_INFO when WED is active.
+	 */
+	if (mtk_wed_device_active(&phy->dev->mt76.mmio.wed)) {
+		sinfo->tx_bytes = msta->wcid.stats.tx_bytes;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
+
+		sinfo->tx_packets = msta->wcid.stats.tx_packets;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
+
+		sinfo->tx_failed = msta->wcid.stats.tx_failed;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+
+		sinfo->tx_retries = msta->wcid.stats.tx_retries;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+	}
 }
 
 static void mt7915_sta_rc_work(void *data, struct ieee80211_sta *sta)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index c1256defbea3..7bd5f6725d7b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -75,6 +75,7 @@ static const u32 mt7915_offs[] = {
 	[AGG_AWSCR0]		= 0x05c,
 	[AGG_PCR0]		= 0x06c,
 	[AGG_ACR0]		= 0x084,
+	[AGG_ACR4]		= 0x08c,
 	[AGG_MRCR]		= 0x098,
 	[AGG_ATCR1]		= 0x0f0,
 	[AGG_ATCR3]		= 0x0f4,
@@ -148,6 +149,7 @@ static const u32 mt7916_offs[] = {
 	[AGG_AWSCR0]		= 0x030,
 	[AGG_PCR0]		= 0x040,
 	[AGG_ACR0]		= 0x054,
+	[AGG_ACR4]		= 0x05c,
 	[AGG_MRCR]		= 0x068,
 	[AGG_ATCR1]		= 0x1a8,
 	[AGG_ATCR3]		= 0x080,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index d74f609775d3..16a5ce352e5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -12,7 +12,7 @@
 #include "mac.h"
 #include "../trace.h"
 
-static bool wed_enable = false;
+static bool wed_enable;
 module_param(wed_enable, bool, 0644);
 
 static LIST_HEAD(hif_list);
@@ -99,6 +99,7 @@ static int mt7915_pci_hif2_probe(struct pci_dev *pdev)
 static int mt7915_wed_offload_enable(struct mtk_wed_device *wed)
 {
 	struct mt7915_dev *dev;
+	struct mt7915_phy *phy;
 	int ret;
 
 	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
@@ -112,18 +113,38 @@ static int mt7915_wed_offload_enable(struct mtk_wed_device *wed)
 	if (!ret)
 		return -EAGAIN;
 
+	phy = &dev->phy;
+	mt76_set(dev, MT_AGG_ACR4(phy->band_idx), MT_AGG_ACR_PPDU_TXS2H);
+
+	phy = dev->mt76.phys[MT_BAND1] ? dev->mt76.phys[MT_BAND1]->priv : NULL;
+	if (phy)
+		mt76_set(dev, MT_AGG_ACR4(phy->band_idx),
+			 MT_AGG_ACR_PPDU_TXS2H);
+
 	return 0;
 }
 
 static void mt7915_wed_offload_disable(struct mtk_wed_device *wed)
 {
 	struct mt7915_dev *dev;
+	struct mt7915_phy *phy;
 
 	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
 
 	spin_lock_bh(&dev->mt76.token_lock);
 	dev->mt76.token_size = MT7915_TOKEN_SIZE;
 	spin_unlock_bh(&dev->mt76.token_lock);
+
+	/* MT_TXD5_TX_STATUS_HOST (MPDU format) has higher priority than
+	 * MT_AGG_ACR_PPDU_TXS2H (PPDU format) even though ACR bit is set.
+	 */
+	phy = &dev->phy;
+	mt76_clear(dev, MT_AGG_ACR4(phy->band_idx), MT_AGG_ACR_PPDU_TXS2H);
+
+	phy = dev->mt76.phys[MT_BAND1] ? dev->mt76.phys[MT_BAND1]->priv : NULL;
+	if (phy)
+		mt76_clear(dev, MT_AGG_ACR4(phy->band_idx),
+			   MT_AGG_ACR_PPDU_TXS2H);
 }
 #endif
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 53061aa727e9..5920e705835a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -46,6 +46,7 @@ enum offs_rev {
 	AGG_AWSCR0,
 	AGG_PCR0,
 	AGG_ACR0,
+	AGG_ACR4,
 	AGG_MRCR,
 	AGG_ATCR1,
 	AGG_ATCR3,
@@ -465,6 +466,9 @@ enum offs_rev {
 #define MT_AGG_ACR_CFEND_RATE		GENMASK(13, 0)
 #define MT_AGG_ACR_BAR_RATE		GENMASK(29, 16)
 
+#define MT_AGG_ACR4(_band)		MT_WF_AGG(_band, __OFFS(AGG_ACR4))
+#define MT_AGG_ACR_PPDU_TXS2H		BIT(1)
+
 #define MT_AGG_MRCR(_band)		MT_WF_AGG(_band, __OFFS(AGG_MRCR))
 #define MT_AGG_MRCR_BAR_CNT_LIMIT		GENMASK(15, 12)
 #define MT_AGG_MRCR_LAST_RTS_CTS_RN		BIT(6)
-- 
2.36.1

