Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951B431AD73
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Feb 2021 18:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhBMRw2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Feb 2021 12:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhBMRwZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Feb 2021 12:52:25 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DD8C06178A
        for <linux-wireless@vger.kernel.org>; Sat, 13 Feb 2021 09:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=burwEjrWgJo73Hax90G74MjYVMA383T9waRkcD0Dcr4=; b=Gc8Oafl6i9TxfvVjWau/03qLeB
        kge4YtnM5GEHhixD6aOKSa2vZySg+2MiqQZI+XCFY9qiR06X/MpsvrNBzOKAM+kwVot7tERI7oaZf
        h6CVnRJIeqE8e9P3PvLLssRFtqRHSYSp0PJPxs7jKZdS6MUhXeI/hCK9C0BOZpA8CzBM=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lAz4Q-0007si-6q
        for linux-wireless@vger.kernel.org; Sat, 13 Feb 2021 18:51:02 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/7] mt76: mt7915: enable hw rx-amsdu de-aggregation
Date:   Sat, 13 Feb 2021 18:50:55 +0100
Message-Id: <20210213175100.22608-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210213175100.22608-1-nbd@nbd.name>
References: <20210213175100.22608-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Enable hw rx-amsdu de-aggregation support available in 7915 devices.
This is a preliminary patch to enable rx checksum offload

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 55 ++++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  6 ++
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 16 +++++-
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |  4 ++
 5 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index f9381bd96244..a41e8cc3a8b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -508,6 +508,45 @@ void mt76_free_device(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_free_device);
 
+static void mt76_rx_release_burst(struct mt76_dev *dev, enum mt76_rxq_id q,
+				  struct sk_buff *skb)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct sk_buff *nskb = dev->rx_amsdu[q].head;
+
+	/* first amsdu subframe */
+	if (status->first_amsdu) {
+		dev->rx_amsdu[q].tail = &skb_shinfo(skb)->frag_list;
+		dev->rx_amsdu[q].seqno = status->seqno;
+		dev->rx_amsdu[q].head = skb;
+		goto enqueue;
+	}
+
+	/* ampdu or out-of-order amsdu subframes */
+	if (!status->amsdu || status->seqno != dev->rx_amsdu[q].seqno) {
+		/* release pending frames */
+		if (dev->rx_amsdu[q].head)
+			__skb_queue_tail(&dev->rx_skb[q],
+					 dev->rx_amsdu[q].head);
+		nskb = skb;
+		goto reset_burst;
+	}
+
+	/* trailing amsdu subframes */
+	*dev->rx_amsdu[q].tail = skb;
+	if (!status->last_amsdu) {
+		dev->rx_amsdu[q].tail = &skb->next;
+		return;
+	}
+
+reset_burst:
+	dev->rx_amsdu[q].head = NULL;
+	dev->rx_amsdu[q].tail = NULL;
+enqueue:
+	if (nskb)
+		__skb_queue_tail(&dev->rx_skb[q], nskb);
+}
+
 void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
@@ -525,7 +564,8 @@ void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb)
 			phy->test.rx_stats.fcs_error[q]++;
 	}
 #endif
-	__skb_queue_tail(&dev->rx_skb[q], skb);
+
+	mt76_rx_release_burst(dev, q, skb);
 }
 EXPORT_SYMBOL_GPL(mt76_rx);
 
@@ -937,13 +977,26 @@ void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 
 	spin_lock(&dev->rx_lock);
 	while ((skb = __skb_dequeue(frames)) != NULL) {
+		struct sk_buff *nskb = skb_shinfo(skb)->frag_list;
+
 		if (mt76_check_ccmp_pn(skb)) {
 			dev_kfree_skb(skb);
 			continue;
 		}
 
+		skb_shinfo(skb)->frag_list = NULL;
 		mt76_rx_convert(dev, skb, &hw, &sta);
 		ieee80211_rx_list(hw, sta, skb, &list);
+
+		/* subsequent amsdu frames */
+		while (nskb) {
+			skb = nskb;
+			nskb = nskb->next;
+			skb->next = NULL;
+
+			mt76_rx_convert(dev, skb, &hw, &sta);
+			ieee80211_rx_list(hw, sta, skb, &list);
+		}
 	}
 	spin_unlock(&dev->rx_lock);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index a3455e2e1545..3911d333bb41 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -507,6 +507,7 @@ struct mt76_rx_status {
 	u8 enc_flags;
 	u8 encoding:2, bw:3, he_ru:3;
 	u8 he_gi:2, he_dcm:1;
+	u8 amsdu:1, first_amsdu:1, last_amsdu:1;
 	u8 rate_idx;
 	u8 nss;
 	u8 band;
@@ -631,6 +632,11 @@ struct mt76_dev {
 	spinlock_t rx_lock;
 	struct napi_struct napi[__MT_RXQ_MAX];
 	struct sk_buff_head rx_skb[__MT_RXQ_MAX];
+	struct {
+		struct sk_buff *head;
+		struct sk_buff **tail;
+		u16 seqno;
+	} rx_amsdu[__MT_RXQ_MAX];
 
 	struct list_head txwi_cache;
 	struct mt76_queue *q_mcu[__MT_MCUQ_MAX];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ad4e5b95158b..76dfcb76fb03 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -153,8 +153,8 @@ static void mt7915_mac_init(struct mt7915_dev *dev)
 	int i;
 
 	mt76_rmw_field(dev, MT_MDP_DCR1, MT_MDP_DCR1_MAX_RX_LEN, 1536);
-	/* disable hardware de-agg */
-	mt76_clear(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
+	/* enable hardware de-agg */
+	mt76_set(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
 
 	for (i = 0; i < MT7915_WTBL_SIZE; i++)
 		mt7915_mac_wtbl_update(dev, i,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 2f2023ded8cd..2f96f31e33c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -320,8 +320,9 @@ int mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	u32 rxd1 = le32_to_cpu(rxd[1]);
 	u32 rxd2 = le32_to_cpu(rxd[2]);
 	u32 rxd3 = le32_to_cpu(rxd[3]);
+	u32 rxd4 = le32_to_cpu(rxd[4]);
 	bool unicast, insert_ccmp_hdr = false;
-	u8 remove_pad;
+	u8 remove_pad, amsdu_info;
 	int i, idx;
 
 	memset(status, 0, sizeof(*status));
@@ -338,6 +339,9 @@ int mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
 		return -EINVAL;
 
+	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR)
+		return -EINVAL;
+
 	unicast = FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) == MT_RXD3_NORMAL_U2M;
 	idx = FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
 	status->wcid = mt7915_rx_get_wcid(dev, idx, unicast);
@@ -541,6 +545,16 @@ int mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	skb_pull(skb, (u8 *)rxd - skb->data + 2 * remove_pad);
 
+	amsdu_info = FIELD_GET(MT_RXD4_NORMAL_PAYLOAD_FORMAT, rxd4);
+	status->amsdu = !!amsdu_info;
+	if (status->amsdu) {
+		status->first_amsdu = amsdu_info == MT_RXD4_FIRST_AMSDU_FRAME;
+		status->last_amsdu = amsdu_info == MT_RXD4_LAST_AMSDU_FRAME;
+		memmove(skb->data + 2, skb->data,
+			ieee80211_get_hdrlen_from_skb(skb));
+		skb_pull(skb, 2);
+	}
+
 	if (insert_ccmp_hdr) {
 		u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 96ff3fb0d1f3..6ad8af835fd4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -86,6 +86,10 @@ enum rx_pkt_type {
 
 /* RXD DW4 */
 #define MT_RXD4_NORMAL_PAYLOAD_FORMAT	GENMASK(1, 0)
+#define MT_RXD4_FIRST_AMSDU_FRAME	GENMASK(1, 0)
+#define MT_RXD4_MID_AMSDU_FRAME		BIT(1)
+#define MT_RXD4_LAST_AMSDU_FRAME	BIT(0)
+
 #define MT_RXD4_NORMAL_PATTERN_DROP	BIT(9)
 #define MT_RXD4_NORMAL_CLS		BIT(10)
 #define MT_RXD4_NORMAL_OFLD		GENMASK(12, 11)
-- 
2.28.0

