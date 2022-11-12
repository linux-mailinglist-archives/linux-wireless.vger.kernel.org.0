Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A675626A51
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Nov 2022 16:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiKLPl3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Nov 2022 10:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiKLPl1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Nov 2022 10:41:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2311D1AF27
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 07:41:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A35ADB802C3
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 15:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B84C433D6;
        Sat, 12 Nov 2022 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668267683;
        bh=NHLPE6tkV9tKS65A/2eqSTGqvJwQK50acSHsge6ASDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tlPGh4glzcxlQ2r8jLy3S6VCOdTWwGj863Row3Df+T2bWBRDN+LWE4+0X7XC14y64
         vMMP4869ZS+0+0vZNmfIInDXwgJyWC0pluan0jS7W9oTd+HM180JVkOFwWddc0pdrk
         d9/lj6SabJ6Da2W+TPrOb2mvhuxBfKvufIHdibmtE43PwIHDwBBYydg8UvvDEhJzfX
         AxmOP2SvLDVUWbqenpcgcuw+xwYKozq/GaGLmiSC/iy8IsSAcuO71wqQ4SL0u+bV2k
         4owSnlasfqYWaskEgJ68qY1GExt6Q0/y6eHDywNoenvfGZwoDAveQ56EocYXhbo7K3
         fkkCytL4vEoGA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Bo.Jiao@mediatek.com, sujuan.chen@mediatek.com,
        ryder.Lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 5/8] wifi: mt76: add info parameter to rx_skb signature
Date:   Sat, 12 Nov 2022 16:40:38 +0100
Message-Id: <4a065f10ded793890ad1c44f64da346b49477f8f.1668267241.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668267241.git.lorenzo@kernel.org>
References: <cover.1668267241.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sujuan Chen <sujuan.chen@mediatek.com>

This is a preliminary patch to introduce WED RX support for mt7915.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c      |  8 ++--
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/dma.c   |  2 +-
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  2 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_txrx.c |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 44 ++++++++++++++++---
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  2 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +-
 drivers/net/wireless/mediatek/mt76/sdio.c     |  2 +-
 drivers/net/wireless/mediatek/mt76/usb.c      |  2 +-
 14 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 58b41bda5eac..8dca8d2447b7 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -750,7 +750,7 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 
 static void
 mt76_add_fragment(struct mt76_dev *dev, struct mt76_queue *q, void *data,
-		  int len, bool more)
+		  int len, bool more, u32 info)
 {
 	struct sk_buff *skb = q->rx_head;
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
@@ -770,7 +770,7 @@ mt76_add_fragment(struct mt76_dev *dev, struct mt76_queue *q, void *data,
 
 	q->rx_head = NULL;
 	if (nr_frags < ARRAY_SIZE(shinfo->frags))
-		dev->drv->rx_skb(dev, q - dev->q_rx, skb);
+		dev->drv->rx_skb(dev, q - dev->q_rx, skb, &info);
 	else
 		dev_kfree_skb(skb);
 }
@@ -822,7 +822,7 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 		}
 
 		if (q->rx_head) {
-			mt76_add_fragment(dev, q, data, len, more);
+			mt76_add_fragment(dev, q, data, len, more, info);
 			continue;
 		}
 
@@ -846,7 +846,7 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 			continue;
 		}
 
-		dev->drv->rx_skb(dev, q - dev->q_rx, skb);
+		dev->drv->rx_skb(dev, q - dev->q_rx, skb, &info);
 		continue;
 
 free_frag:
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 738fb22d9198..bf4ad629df3f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -444,7 +444,7 @@ struct mt76_driver_ops {
 	bool (*rx_check)(struct mt76_dev *dev, void *data, int len);
 
 	void (*rx_skb)(struct mt76_dev *dev, enum mt76_rxq_id q,
-		       struct sk_buff *skb);
+		       struct sk_buff *skb, u32 *info);
 
 	void (*rx_poll_complete)(struct mt76_dev *dev, enum mt76_rxq_id q);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index f9e5857850e7..03ba11a61c90 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -69,7 +69,7 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 }
 
 void mt7603_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			 struct sk_buff *skb)
+			 struct sk_buff *skb, u32 *info)
 {
 	struct mt7603_dev *dev = container_of(mdev, struct mt7603_dev, mt76);
 	__le32 *rxd = (__le32 *)skb->data;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 0fd46d907638..7c3be596da09 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -244,7 +244,7 @@ int mt7603_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 void mt7603_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 
 void mt7603_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			 struct sk_buff *skb);
+			 struct sk_buff *skb, u32 *info);
 void mt7603_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q);
 void mt7603_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 int mt7603_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 305bf1826a02..a95602473359 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1666,7 +1666,7 @@ bool mt7615_rx_check(struct mt76_dev *mdev, void *data, int len)
 EXPORT_SYMBOL_GPL(mt7615_rx_check);
 
 void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			 struct sk_buff *skb)
+			 struct sk_buff *skb, u32 *info)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	__le32 *rxd = (__le32 *)skb->data;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 8b37f8259f52..087d4886162e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -513,7 +513,7 @@ void mt7615_tx_worker(struct mt76_worker *w);
 void mt7615_tx_token_put(struct mt7615_dev *dev);
 bool mt7615_rx_check(struct mt76_dev *mdev, void *data, int len);
 void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			 struct sk_buff *skb);
+			 struct sk_buff *skb, u32 *info);
 void mt7615_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index a19176bb2433..4cd63bacd742 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -188,7 +188,7 @@ int mt76x02_set_rts_threshold(struct ieee80211_hw *hw, u32 val);
 void mt76x02_remove_hdr_pad(struct sk_buff *skb, int len);
 bool mt76x02_tx_status_data(struct mt76_dev *mdev, u8 *update);
 void mt76x02_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			  struct sk_buff *skb);
+			  struct sk_buff *skb, u32 *info);
 void mt76x02_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q);
 irqreturn_t mt76x02_irq_handler(int irq, void *dev_instance);
 void mt76x02_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
index 3a313075a9e3..d8bc4ae185f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
@@ -33,7 +33,7 @@ void mt76x02_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 EXPORT_SYMBOL_GPL(mt76x02_tx);
 
 void mt76x02_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			  struct sk_buff *skb)
+			  struct sk_buff *skb, u32 *info)
 {
 	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
 	void *rxwi = skb->data;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index e7b1618cd3a6..c76c5cc398e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -165,9 +165,9 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		sta = container_of((void *)msta, struct ieee80211_sta,
 				   drv_priv);
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-			u8 q = mt76_connac_lmac_mapping(i);
-			u32 tx_cur = tx_time[q];
-			u32 rx_cur = rx_time[q];
+			u8 queue = mt76_connac_lmac_mapping(i);
+			u32 tx_cur = tx_time[queue];
+			u32 rx_cur = rx_time[queue];
 			u8 tid = ac_to_tid[i];
 
 			if (!tx_cur && !rx_cur)
@@ -245,8 +245,38 @@ void mt7915_mac_enable_rtscts(struct mt7915_dev *dev,
 		mt76_clear(dev, addr, BIT(5));
 }
 
+static void
+mt7915_wed_check_ppe(struct mt7915_dev *dev, struct mt76_queue *q,
+		     struct mt7915_sta *msta, struct sk_buff *skb,
+		     u32 info)
+{
+	struct ieee80211_vif *vif;
+	struct wireless_dev *wdev;
+	u32 hash, reason;
+
+	if (!msta || !msta->vif)
+		return;
+
+	if (!(q->flags & MT_QFLAG_WED) ||
+	    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) != MT76_WED_Q_RX)
+		return;
+
+	if (!(info & MT_DMA_INFO_PPE_VLD))
+		return;
+
+	vif = container_of((void *)msta->vif, struct ieee80211_vif,
+			   drv_priv);
+	wdev = ieee80211_vif_to_wdev(vif);
+	skb->dev = wdev->netdev;
+
+	reason = FIELD_GET(MT_DMA_PPE_CPU_REASON, info);
+	hash = FIELD_GET(MT_DMA_PPE_ENTRY, info);
+	mtk_wed_device_ppe_check(&dev->mt76.mmio.wed, skb, reason, hash);
+}
+
 static int
-mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
+mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
+		   enum mt76_rxq_id q, u32 *info)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct mt76_phy *mphy = &dev->mt76.phy;
@@ -513,6 +543,8 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		}
 	} else {
 		status->flag |= RX_FLAG_8023;
+		mt7915_wed_check_ppe(dev, &dev->mt76.q_rx[q], msta, skb,
+				     *info);
 	}
 
 	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
@@ -1096,7 +1128,7 @@ bool mt7915_rx_check(struct mt76_dev *mdev, void *data, int len)
 }
 
 void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			 struct sk_buff *skb)
+			 struct sk_buff *skb, u32 *info)
 {
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	__le32 *rxd = (__le32 *)skb->data;
@@ -1130,7 +1162,7 @@ void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		dev_kfree_skb(skb);
 		break;
 	case PKT_TYPE_NORMAL:
-		if (!mt7915_mac_fill_rx(dev, skb)) {
+		if (!mt7915_mac_fill_rx(dev, skb, q, info)) {
 			mt76_rx(&dev->mt76, q, skb);
 			return;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 9cb680e7f223..460be184e617 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -617,7 +617,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  struct mt76_tx_info *tx_info);
 void mt7915_tx_token_put(struct mt7915_dev *dev);
 void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			 struct sk_buff *skb);
+			 struct sk_buff *skb, u32 *info);
 bool mt7915_rx_check(struct mt76_dev *mdev, void *data, int len);
 void mt7915_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 void mt7915_stats_work(struct work_struct *work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index eeab756240a2..2d2b53d6cd47 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -692,7 +692,7 @@ bool mt7921_rx_check(struct mt76_dev *mdev, void *data, int len)
 EXPORT_SYMBOL_GPL(mt7921_rx_check);
 
 void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			 struct sk_buff *skb)
+			 struct sk_buff *skb, u32 *info)
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	__le32 *rxd = (__le32 *)skb->data;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index d9d78f6b088e..282c17424bcc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -422,7 +422,7 @@ void mt7921_tx_worker(struct mt76_worker *w);
 void mt7921_tx_token_put(struct mt7921_dev *dev);
 bool mt7921_rx_check(struct mt76_dev *mdev, void *data, int len);
 void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			 struct sk_buff *skb);
+			 struct sk_buff *skb, u32 *info);
 void mt7921_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 void mt7921_stats_work(struct work_struct *work);
 void mt7921_set_stream_he_caps(struct mt7921_phy *phy);
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 0ec308f99af5..228bc7d45011 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -395,7 +395,7 @@ mt76s_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 		if (!e || !e->skb)
 			break;
 
-		dev->drv->rx_skb(dev, MT_RXQ_MAIN, e->skb);
+		dev->drv->rx_skb(dev, MT_RXQ_MAIN, e->skb, NULL);
 		e->skb = NULL;
 		nframes++;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 0597df2729a6..3e281715fcd4 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -547,7 +547,7 @@ mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb,
 		len -= data_len;
 		nsgs++;
 	}
-	dev->drv->rx_skb(dev, MT_RXQ_MAIN, skb);
+	dev->drv->rx_skb(dev, MT_RXQ_MAIN, skb, NULL);
 
 	return nsgs;
 }
-- 
2.38.1

