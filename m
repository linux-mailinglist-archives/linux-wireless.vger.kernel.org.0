Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEC3377F51
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 11:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhEJJ2N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 05:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhEJJ2M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 05:28:12 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3075EC061574
        for <linux-wireless@vger.kernel.org>; Mon, 10 May 2021 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mQp3Q+cejrpms2RC/7lEzjD1kZveUduFUbL8tZ9jlng=; b=kO+FUI6/2R+gGvvd2Yi8tw4qTw
        Tt0hSV+0qNKTW/OuVkLkuq+ib/uSjmxXy2CRvpFnf62XvJAo/OSblInBcTpAcMav3Aa/+apyB3zpR
        ICI0uj6127ecizt/W10QYQvENJd3E3rqdC9ewsu4e0vP7yyNNY8PiH8Ngl9PjA40gZZo=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lg2Bt-000572-9Q
        for linux-wireless@vger.kernel.org; Mon, 10 May 2021 11:27:05 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/9] mt76: mt7915: move mt7915_queue_rx_skb to mac.c
Date:   Mon, 10 May 2021 11:26:55 +0200
Message-Id: <20210510092703.90500-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is not really DMA specific, and moving it makes it possible to make some
functions in mac.c static

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 33 --------------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 44 ++++++++++++++++---
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  3 --
 3 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 11d0b760abd7..69a7e3dce113 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -19,39 +19,6 @@ int mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc)
 	return 0;
 }
 
-void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			 struct sk_buff *skb)
-{
-	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-	__le32 *rxd = (__le32 *)skb->data;
-	enum rx_pkt_type type;
-
-	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
-
-	switch (type) {
-	case PKT_TYPE_TXRX_NOTIFY:
-		mt7915_mac_tx_free(dev, skb);
-		break;
-	case PKT_TYPE_RX_EVENT:
-		mt7915_mcu_rx_event(dev, skb);
-		break;
-#ifdef CONFIG_NL80211_TESTMODE
-	case PKT_TYPE_TXRXV:
-		mt7915_mac_fill_rx_vector(dev, skb);
-		break;
-#endif
-	case PKT_TYPE_NORMAL:
-		if (!mt7915_mac_fill_rx(dev, skb)) {
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
 static void
 mt7915_tx_cleanup(struct mt7915_dev *dev)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 7a9759fb79d8..2c4516f8dbf1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -307,7 +307,8 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
 	}
 }
 
-int mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
+static int
+mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct mt76_phy *mphy = &dev->mt76.phy;
@@ -610,9 +611,10 @@ int mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	return 0;
 }
 
-#ifdef CONFIG_NL80211_TESTMODE
-void mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb)
+static void
+mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb)
 {
+#ifdef CONFIG_NL80211_TESTMODE
 	struct mt7915_phy *phy = &dev->phy;
 	__le32 *rxd = (__le32 *)skb->data;
 	__le32 *rxv_hdr = rxd + 2;
@@ -650,10 +652,10 @@ void mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	phy->test.last_freq_offset = foe;
 	phy->test.last_snr = snr;
+#endif
 
 	dev_kfree_skb(skb);
 }
-#endif
 
 static void
 mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
@@ -1129,7 +1131,8 @@ void mt7915_txp_skb_unmap(struct mt76_dev *dev,
 				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
 }
 
-void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
+static void
+mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 {
 	struct mt7915_tx_free *free = (struct mt7915_tx_free *)skb->data;
 	struct mt76_dev *mdev = &dev->mt76;
@@ -1233,6 +1236,37 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	}
 }
 
+void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			 struct sk_buff *skb)
+{
+	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
+	__le32 *rxd = (__le32 *)skb->data;
+	enum rx_pkt_type type;
+
+	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
+
+	switch (type) {
+	case PKT_TYPE_TXRX_NOTIFY:
+		mt7915_mac_tx_free(dev, skb);
+		break;
+	case PKT_TYPE_RX_EVENT:
+		mt7915_mcu_rx_event(dev, skb);
+		break;
+	case PKT_TYPE_TXRXV:
+		mt7915_mac_fill_rx_vector(dev, skb);
+		break;
+	case PKT_TYPE_NORMAL:
+		if (!mt7915_mac_fill_rx(dev, skb)) {
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
 void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 {
 	struct mt7915_dev *dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 7a3c172afc98..279332b557a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -398,9 +398,6 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key, bool beacon);
 void mt7915_mac_set_timing(struct mt7915_phy *phy);
-int mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb);
-void mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb);
-void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb);
 int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-- 
2.30.1

