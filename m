Return-Path: <linux-wireless+bounces-24881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBABAFB7D6
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 17:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1031884518
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 15:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54001D5CC7;
	Mon,  7 Jul 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="k+ouPxT+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA241CD1E4
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903233; cv=none; b=Q9cr42pNvtUP/ZRVSe5O6qDyt/J+7I1ejFH5/eMyichuuze3+MLotR9oveu+35urZ3weXhc6Foa0v8M0t0iYS+tp8tFSe69gi9yv8YNsSNNXrbPnaNGZXwwk5x8OvWE6qSFivrIBJ9o94ifjV697tV68KV0TkmoqgRZbhSBcvfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903233; c=relaxed/simple;
	bh=VaXgvxjkE02l26p4pxNKRByCaKeVC3mmc/m2zV3ifuw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kg5AjV0/hXmb/3VxxObw4YQau6xQMhvEZ5L3gZ9StNrgRlgVHKekVBaQ8/qufSB60nuZTmGQoACly6ZQNLXDbKgk9ZPgsjAb1M2LeZzpsY61KzWNrjtsDgTJSM3815G8DVPwUzHyFSESOtGQihOnrOhoKjxHPhptJRJuZz/1uo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=k+ouPxT+; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XEGgfAPzrtjCEPBdAUboxczCfvwSPVPCH74bqEOVnQg=; b=k+ouPxT+Lw9JEay6Xc3/bOyyG0
	z4zCILfBmgXJ5ochFGUJKx5bQv5yF4QF2btXSkeqYSPpkGSHq7FDnzMqLGvyFtrOOmdPVsDZuyRLQ
	y1MdXseBcw3Hsvsfo29TYxpYaVGaqt66OmsXALSAvZiAGpCEmwZLTcv3EAt/EUYdwBT8=;
Received: from p5b2062ed.dip0.t-ipconnect.de ([91.32.98.237] helo=MacBookPro.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uYo3b-0081cC-0E
	for linux-wireless@vger.kernel.org;
	Mon, 07 Jul 2025 17:47:03 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 1/2] wifi: mt76: add a wrapper for wcid access with validation
Date: Mon,  7 Jul 2025 17:47:01 +0200
Message-ID: <20250707154702.1726-1-nbd@nbd.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several places use rcu_dereference to get a wcid entry without validating
if the index exceeds the array boundary. Fix this by using a helper function,
which handles validation.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h            | 10 ++++++++++
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c      | 10 ++--------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c      |  7 ++-----
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h         |  5 +----
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c     |  4 +---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c      | 12 +++---------
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c     |  5 +----
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c      |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c      |  5 +----
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c      | 12 +++---------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c      | 11 ++++-------
 drivers/net/wireless/mediatek/mt76/tx.c              |  8 +++-----
 drivers/net/wireless/mediatek/mt76/util.c            |  2 +-
 17 files changed, 41 insertions(+), 68 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index f1d1b0ebd074..3d3e38c365eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1228,6 +1228,16 @@ static inline int mt76_wed_dma_setup(struct mt76_dev *dev, struct mt76_queue *q,
 #define mt76_dereference(p, dev) \
 	rcu_dereference_protected(p, lockdep_is_held(&(dev)->mutex))
 
+static inline struct mt76_wcid *
+__mt76_wcid_ptr(struct mt76_dev *dev, u16 idx)
+{
+	if (idx >= ARRAY_SIZE(dev->wcid))
+		return NULL;
+	return rcu_dereference(dev->wcid[idx]);
+}
+
+#define mt76_wcid_ptr(dev, idx) __mt76_wcid_ptr(&(dev)->mt76, idx)
+
 struct mt76_dev *mt76_alloc_device(struct device *pdev, unsigned int size,
 				   const struct ieee80211_ops *ops,
 				   const struct mt76_driver_ops *drv_ops);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 863e5770df51..e26cc78fff94 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -44,7 +44,7 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 	if (idx >= MT7603_WTBL_STA - 1)
 		goto free;
 
-	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	wcid = mt76_wcid_ptr(dev, idx);
 	if (!wcid)
 		goto free;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 413973d05b43..6387f9e61060 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -487,10 +487,7 @@ mt7603_rx_get_wcid(struct mt7603_dev *dev, u8 idx, bool unicast)
 	struct mt7603_sta *sta;
 	struct mt76_wcid *wcid;
 
-	if (idx >= MT7603_WTBL_SIZE)
-		return NULL;
-
-	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	wcid = mt76_wcid_ptr(dev, idx);
 	if (unicast || !wcid)
 		return wcid;
 
@@ -1266,12 +1263,9 @@ void mt7603_mac_add_txs(struct mt7603_dev *dev, void *data)
 	if (pid == MT_PACKET_ID_NO_ACK)
 		return;
 
-	if (wcidx >= MT7603_WTBL_SIZE)
-		return;
-
 	rcu_read_lock();
 
-	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	wcid = mt76_wcid_ptr(dev, wcidx);
 	if (!wcid)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 3ca4fae7c4b0..f8d2cc94b742 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -90,10 +90,7 @@ static struct mt76_wcid *mt7615_rx_get_wcid(struct mt7615_dev *dev,
 	struct mt7615_sta *sta;
 	struct mt76_wcid *wcid;
 
-	if (idx >= MT7615_WTBL_SIZE)
-		return NULL;
-
-	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	wcid = mt76_wcid_ptr(dev, idx);
 	if (unicast || !wcid)
 		return wcid;
 
@@ -1504,7 +1501,7 @@ static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 
 	rcu_read_lock();
 
-	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	wcid = mt76_wcid_ptr(dev, wcidx);
 	if (!wcid)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index e9ac8a7317a1..0db00efe88b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -1172,7 +1172,7 @@ void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
 		wcid_idx = wcid->idx;
 	} else {
 		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
-		wcid = rcu_dereference(dev->wcid[wcid_idx]);
+		wcid = __mt76_wcid_ptr(dev, wcid_idx);
 
 		if (wcid && wcid->sta) {
 			sta = container_of((void *)wcid, struct ieee80211_sta,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 2094c7d2af81..8d06ef8c7c62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -262,10 +262,7 @@ mt76x02_rx_get_sta(struct mt76_dev *dev, u8 idx)
 {
 	struct mt76_wcid *wcid;
 
-	if (idx >= MT76x02_N_WCIDS)
-		return NULL;
-
-	wcid = rcu_dereference(dev->wcid[idx]);
+	wcid = __mt76_wcid_ptr(dev, idx);
 	if (!wcid)
 		return NULL;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index d5db6ffd6d36..83488b2d6efb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -564,9 +564,7 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 
 	rcu_read_lock();
 
-	if (stat->wcid < MT76x02_N_WCIDS)
-		wcid = rcu_dereference(dev->mt76.wcid[stat->wcid]);
-
+	wcid = mt76_wcid_ptr(dev, stat->wcid);
 	if (wcid && wcid->sta) {
 		void *priv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index e3e65848a17f..09c92e4ae129 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -56,10 +56,7 @@ static struct mt76_wcid *mt7915_rx_get_wcid(struct mt7915_dev *dev,
 	struct mt7915_sta *sta;
 	struct mt76_wcid *wcid;
 
-	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
-		return NULL;
-
-	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	wcid = mt76_wcid_ptr(dev, idx);
 	if (unicast || !wcid)
 		return wcid;
 
@@ -917,7 +914,7 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 			u16 idx;
 
 			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
-			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			wcid = mt76_wcid_ptr(dev, idx);
 			sta = wcid_to_sta(wcid);
 			if (!sta)
 				continue;
@@ -1013,12 +1010,9 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	if (pid < MT_PACKET_ID_WED)
 		return;
 
-	if (wcidx >= mt7915_wtbl_size(dev))
-		return;
-
 	rcu_read_lock();
 
-	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	wcid = mt76_wcid_ptr(dev, wcidx);
 	if (!wcid)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 26497b580eb6..64cf726529b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -4010,7 +4010,7 @@ int mt7915_mcu_wed_wa_tx_stats(struct mt7915_dev *dev, u16 wlan_idx)
 
 	rcu_read_lock();
 
-	wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
+	wcid = mt76_wcid_ptr(dev, wlan_idx);
 	if (wcid)
 		wcid->stats.tx_packets += le32_to_cpu(res->tx_packets);
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 9c4d5cea0c42..4a82f8e4c118 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -587,12 +587,9 @@ static void mt7915_mmio_wed_update_rx_stats(struct mtk_wed_device *wed,
 
 	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
 
-	if (idx >= mt7915_wtbl_size(dev))
-		return;
-
 	rcu_read_lock();
 
-	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	wcid = mt76_wcid_ptr(dev, idx);
 	if (wcid) {
 		wcid->stats.rx_bytes += le32_to_cpu(stats->rx_byte_cnt);
 		wcid->stats.rx_packets += le32_to_cpu(stats->rx_pkt_cnt);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 5dd57de59f27..f1f76506b0a5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -465,7 +465,7 @@ void mt7921_mac_add_txs(struct mt792x_dev *dev, void *data)
 
 	rcu_read_lock();
 
-	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	wcid = mt76_wcid_ptr(dev, wcidx);
 	if (!wcid)
 		goto out;
 
@@ -516,7 +516,7 @@ static void mt7921_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 
 			count++;
 			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
-			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			wcid = mt76_wcid_ptr(dev, idx);
 			sta = wcid_to_sta(wcid);
 			if (!sta)
 				continue;
@@ -816,7 +816,7 @@ void mt7921_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 	u16 idx;
 
 	idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
-	wcid = rcu_dereference(mdev->wcid[idx]);
+	wcid = __mt76_wcid_ptr(mdev, idx);
 	sta = wcid_to_sta(wcid);
 
 	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index c871d2f9688b..75823c9fd3a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1040,7 +1040,7 @@ void mt7925_mac_add_txs(struct mt792x_dev *dev, void *data)
 
 	rcu_read_lock();
 
-	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	wcid = mt76_wcid_ptr(dev, wcidx);
 	if (!wcid)
 		goto out;
 
@@ -1122,7 +1122,7 @@ mt7925_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 			u16 idx;
 
 			idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
-			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			wcid = mt76_wcid_ptr(dev, idx);
 			sta = wcid_to_sta(wcid);
 			if (!sta)
 				continue;
@@ -1445,7 +1445,7 @@ void mt7925_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 	u16 idx;
 
 	idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
-	wcid = rcu_dereference(mdev->wcid[idx]);
+	wcid = __mt76_wcid_ptr(mdev, idx);
 	sta = wcid_to_sta(wcid);
 
 	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
index 05978d9c7b91..3f1d9ba49076 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
@@ -142,10 +142,7 @@ struct mt76_wcid *mt792x_rx_get_wcid(struct mt792x_dev *dev, u16 idx,
 	struct mt792x_sta *sta;
 	struct mt76_wcid *wcid;
 
-	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
-		return NULL;
-
-	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	wcid = mt76_wcid_ptr(dev, idx);
 	if (unicast || !wcid)
 		return wcid;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 0dbd4662bc84..5095304c0de1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -61,10 +61,7 @@ static struct mt76_wcid *mt7996_rx_get_wcid(struct mt7996_dev *dev,
 	struct mt76_wcid *wcid;
 	int i;
 
-	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
-		return NULL;
-
-	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	wcid = mt76_wcid_ptr(dev, idx);
 	if (!wcid)
 		return NULL;
 
@@ -1249,7 +1246,7 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 			u16 idx;
 
 			idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
-			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			wcid = mt76_wcid_ptr(dev, idx);
 			sta = wcid_to_sta(wcid);
 			if (!sta)
 				goto next;
@@ -1471,12 +1468,9 @@ static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
 	if (pid < MT_PACKET_ID_NO_SKB)
 		return;
 
-	if (wcidx >= mt7996_wtbl_size(dev))
-		return;
-
 	rcu_read_lock();
 
-	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	wcid = mt76_wcid_ptr(dev, wcidx);
 	if (!wcid)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index f0adc0b4b8b6..026622a29372 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -555,7 +555,7 @@ mt7996_mcu_rx_all_sta_info_event(struct mt7996_dev *dev, struct sk_buff *skb)
 		switch (le16_to_cpu(res->tag)) {
 		case UNI_ALL_STA_TXRX_RATE:
 			wlan_idx = le16_to_cpu(res->rate[i].wlan_idx);
-			wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
+			wcid = mt76_wcid_ptr(dev, wlan_idx);
 
 			if (!wcid)
 				break;
@@ -565,7 +565,7 @@ mt7996_mcu_rx_all_sta_info_event(struct mt7996_dev *dev, struct sk_buff *skb)
 			break;
 		case UNI_ALL_STA_TXRX_ADM_STAT:
 			wlan_idx = le16_to_cpu(res->adm_stat[i].wlan_idx);
-			wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
+			wcid = mt76_wcid_ptr(dev, wlan_idx);
 
 			if (!wcid)
 				break;
@@ -579,7 +579,7 @@ mt7996_mcu_rx_all_sta_info_event(struct mt7996_dev *dev, struct sk_buff *skb)
 			break;
 		case UNI_ALL_STA_TXRX_MSDU_COUNT:
 			wlan_idx = le16_to_cpu(res->msdu_cnt[i].wlan_idx);
-			wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
+			wcid = mt76_wcid_ptr(dev, wlan_idx);
 
 			if (!wcid)
 				break;
@@ -676,10 +676,7 @@ mt7996_mcu_wed_rro_event(struct mt7996_dev *dev, struct sk_buff *skb)
 
 			e = (void *)skb->data;
 			idx = le16_to_cpu(e->wlan_id);
-			if (idx >= ARRAY_SIZE(dev->mt76.wcid))
-				break;
-
-			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			wcid = mt76_wcid_ptr(dev, idx);
 			if (!wcid || !wcid->sta)
 				break;
 
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 513916469ca2..251ee3ce5e4d 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -64,7 +64,7 @@ mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
 		struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
 		struct mt76_wcid *wcid;
 
-		wcid = rcu_dereference(dev->wcid[cb->wcid]);
+		wcid = __mt76_wcid_ptr(dev, cb->wcid);
 		if (wcid) {
 			status.sta = wcid_to_sta(wcid);
 			if (status.sta && (wcid->rate.flags || wcid->rate.legacy)) {
@@ -251,9 +251,7 @@ void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *
 
 	rcu_read_lock();
 
-	if (wcid_idx < ARRAY_SIZE(dev->wcid))
-		wcid = rcu_dereference(dev->wcid[wcid_idx]);
-
+	wcid = __mt76_wcid_ptr(dev, wcid_idx);
 	mt76_tx_check_non_aql(dev, wcid, skb);
 
 #ifdef CONFIG_NL80211_TESTMODE
@@ -538,7 +536,7 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 			break;
 
 		mtxq = (struct mt76_txq *)txq->drv_priv;
-		wcid = rcu_dereference(dev->wcid[mtxq->wcid]);
+		wcid = __mt76_wcid_ptr(dev, mtxq->wcid);
 		if (!wcid || test_bit(MT_WCID_FLAG_PS, &wcid->flags))
 			continue;
 
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index 9fa60d380ede..6ac7cfdd8786 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -90,7 +90,7 @@ int mt76_get_min_avg_rssi(struct mt76_dev *dev, u8 phy_idx)
 			if (!(mask & 1))
 				continue;
 
-			wcid = rcu_dereference(dev->wcid[j]);
+			wcid = __mt76_wcid_ptr(dev, j);
 			if (!wcid || wcid->phy_idx != phy_idx)
 				continue;
 
-- 
2.49.0


