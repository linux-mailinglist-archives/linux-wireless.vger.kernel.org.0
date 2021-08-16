Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC3A3ED5D8
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 15:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbhHPNP3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 09:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239786AbhHPNOh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 09:14:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C652632C8;
        Mon, 16 Aug 2021 13:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629119492;
        bh=p8XwtdHfehPG44LjAlVYseU8ZzCrZggkpFI/G1KXj3A=;
        h=From:To:Cc:Subject:Date:From;
        b=qfAHMGnqKtHDu5vXyd+ZOyPyCK0MZlfDLnvdm0tFP8OGBNQSgmTAl/A1ekOQGqtVF
         n+jWAfDjO6xcra5JGw9UTZMi3vsj2uQUtmGOmJCxLF2wfIVRRnPrA/K0D5laCymN7t
         vIIiHpdvL9JMmEgSWi5vl8Q+KKMCmXD93r/gWLL5mwEsj7V1dqNDLfpmybdTG/tigj
         QY+h+VoQAWvm7Ftt++PbAmc5A4ktEprt/C+gNXceF/ymzIs/5t5Q0zkf8RYuyO//hf
         j+/RA5qvFs3pA2RrWIKBRm0RYu8odD5KiyeJzZllcd7030TU3NACPpoXmiEb2Tdtzg
         Fz/rAJvXe2dKQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: move mt7921_queue_rx_skb to mac.c
Date:   Mon, 16 Aug 2021 15:11:24 +0200
Message-Id: <b9dda77ca23a3e05bea1f3c77b4a8f351793bdd1.1629119453.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As for 7915 moving mt7921_queue_rx_skb makes it possible to make
some functions in mac.c static

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 34 ----------------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 40 ++++++++++++++++++-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  3 --
 3 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 7d7d43a5422f..62cee662ba28 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -19,40 +19,6 @@ int mt7921_init_tx_queues(struct mt7921_phy *phy, int idx, int n_desc)
 	return 0;
 }
 
-void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			 struct sk_buff *skb)
-{
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
-	__le32 *rxd = (__le32 *)skb->data;
-	enum rx_pkt_type type;
-	u16 flag;
-
-	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
-	flag = FIELD_GET(MT_RXD0_PKT_FLAG, le32_to_cpu(rxd[0]));
-
-	if (type == PKT_TYPE_RX_EVENT && flag == 0x1)
-		type = PKT_TYPE_NORMAL_MCU;
-
-	switch (type) {
-	case PKT_TYPE_TXRX_NOTIFY:
-		mt7921_mac_tx_free(dev, skb);
-		break;
-	case PKT_TYPE_RX_EVENT:
-		mt7921_mcu_rx_event(dev, skb);
-		break;
-	case PKT_TYPE_NORMAL_MCU:
-	case PKT_TYPE_NORMAL:
-		if (!mt7921_mac_fill_rx(dev, skb)) {
-			mt76_rx(&dev->mt76, q, skb);
-			return;
-		}
-		fallthrough;
-	default:
-		dev_kfree_skb(skb);
-		break;
-	}
-}
-
 void mt7921_tx_cleanup(struct mt7921_dev *dev)
 {
 	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], false);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index aac3da4ef41b..cc2531f982ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -351,7 +351,8 @@ mt7921_mac_assoc_rssi(struct mt7921_dev *dev, struct sk_buff *skb)
 		mt7921_mac_rssi_iter, skb);
 }
 
-int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
+static int
+mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 {
 	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
@@ -1045,7 +1046,8 @@ void mt7921_txp_skb_unmap(struct mt76_dev *dev,
 	}
 }
 
-void mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
+static void
+mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 {
 	struct mt7921_tx_free *free = (struct mt7921_tx_free *)skb->data;
 	struct mt76_dev *mdev = &dev->mt76;
@@ -1141,6 +1143,40 @@ void mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 	mt76_worker_schedule(&dev->mt76.tx_worker);
 }
 
+void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			 struct sk_buff *skb)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	__le32 *rxd = (__le32 *)skb->data;
+	enum rx_pkt_type type;
+	u16 flag;
+
+	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
+	flag = FIELD_GET(MT_RXD0_PKT_FLAG, le32_to_cpu(rxd[0]));
+
+	if (type == PKT_TYPE_RX_EVENT && flag == 0x1)
+		type = PKT_TYPE_NORMAL_MCU;
+
+	switch (type) {
+	case PKT_TYPE_TXRX_NOTIFY:
+		mt7921_mac_tx_free(dev, skb);
+		break;
+	case PKT_TYPE_RX_EVENT:
+		mt7921_mcu_rx_event(dev, skb);
+		break;
+	case PKT_TYPE_NORMAL_MCU:
+	case PKT_TYPE_NORMAL:
+		if (!mt7921_mac_fill_rx(dev, skb)) {
+			mt76_rx(&dev->mt76, q, skb);
+			return;
+		}
+		fallthrough;
+	default:
+		dev_kfree_skb(skb);
+		break;
+	}
+}
+
 void mt7921_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 {
 	struct mt7921_dev *dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 6a47ba65b96e..547f777beb15 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -330,9 +330,6 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key, bool beacon);
 void mt7921_mac_set_timing(struct mt7921_phy *phy);
-int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb);
-void mt7921_mac_fill_rx_vector(struct mt7921_dev *dev, struct sk_buff *skb);
-void mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb);
 int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-- 
2.31.1

