Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE0856491B
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Jul 2022 20:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiGCS3J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Jul 2022 14:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiGCS3J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Jul 2022 14:29:09 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8942BDE
        for <linux-wireless@vger.kernel.org>; Sun,  3 Jul 2022 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GDGjoO63dyrs9bZ3AbS+pbxtBNUEDyHexjjavFKuuYc=; b=eRI+53YxJa73RYkcV4oL80hjrJ
        +mg9JOm52mT+kUPcjLAA0hR/zuqUbl/tyF+a3XOrkqNnII7ScXDd1KF0nGOmPB71gK4Yp7vmIHOcU
        zxRkdMHnj9bn20aL1ohoVWyfKTVQ09m5By1Js9c56T7dHN07cd6cxYBCnC0vLSmnRzJI=;
Received: from p200300daa726cc00a936c3912bbcbc03.dip0.t-ipconnect.de ([2003:da:a726:cc00:a936:c391:2bbc:bc03] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o84LC-0000v9-1j
        for linux-wireless@vger.kernel.org; Sun, 03 Jul 2022 20:29:06 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: pass original queue id from __mt76_tx_queue_skb to the driver
Date:   Sun,  3 Jul 2022 20:29:04 +0200
Message-Id: <20220703182905.51694-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MT7615 and newer map multiple software tx queues to the hardware id

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c           | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt76.h          | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  | 3 ++-
 drivers/net/wireless/mediatek/mt76/sdio.c          | 6 +++---
 drivers/net/wireless/mediatek/mt76/testmode.c      | 4 ++--
 drivers/net/wireless/mediatek/mt76/tx.c            | 2 +-
 drivers/net/wireless/mediatek/mt76/usb.c           | 6 +++---
 8 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 30de8be4aac1..f22273cde1a8 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -349,8 +349,8 @@ mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, struct mt76_queue *q,
 
 static int
 mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
-		      struct sk_buff *skb, struct mt76_wcid *wcid,
-		      struct ieee80211_sta *sta)
+		      enum mt76_txq_id qid, struct sk_buff *skb,
+		      struct mt76_wcid *wcid, struct ieee80211_sta *sta)
 {
 	struct ieee80211_tx_status status = {
 		.sta = sta,
@@ -406,7 +406,7 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 
 	dma_sync_single_for_cpu(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
 				DMA_TO_DEVICE);
-	ret = dev->drv->tx_prepare_skb(dev, txwi, q->qid, wcid, sta, &tx_info);
+	ret = dev->drv->tx_prepare_skb(dev, txwi, qid, wcid, sta, &tx_info);
 	dma_sync_single_for_device(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
 				   DMA_TO_DEVICE);
 	if (ret < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4e8997c45c1b..cb712c0438c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -223,8 +223,8 @@ struct mt76_queue_ops {
 		     u32 ring_base);
 
 	int (*tx_queue_skb)(struct mt76_dev *dev, struct mt76_queue *q,
-			    struct sk_buff *skb, struct mt76_wcid *wcid,
-			    struct ieee80211_sta *sta);
+			    enum mt76_txq_id qid, struct sk_buff *skb,
+			    struct mt76_wcid *wcid, struct ieee80211_sta *sta);
 
 	int (*tx_queue_skb_raw)(struct mt76_dev *dev, struct mt76_queue *q,
 				struct sk_buff *skb, u32 tx_info);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
index c67fc29bb7c3..b65b0a88c1de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
@@ -24,8 +24,8 @@ mt7603_update_beacon_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (!skb)
 		return;
 
-	mt76_tx_queue_skb(dev, dev->mphy.q_tx[MT_TXQ_BEACON], skb,
-			  &mvif->sta.wcid, NULL);
+	mt76_tx_queue_skb(dev, dev->mphy.q_tx[MT_TXQ_BEACON],
+			  MT_TXQ_BEACON, skb, &mvif->sta.wcid, NULL);
 
 	spin_lock_bh(&dev->ps_lock);
 	mt76_wr(dev, MT_DMA_FQCR0, MT_DMA_FQCR0_BUSY |
@@ -123,7 +123,7 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 		struct ieee80211_vif *vif = info->control.vif;
 		struct mt7603_vif *mvif = (struct mt7603_vif *)vif->drv_priv;
 
-		mt76_tx_queue_skb(dev, q, skb, &mvif->sta.wcid, NULL);
+		mt76_tx_queue_skb(dev, q, MT_TXQ_CAB, skb, &mvif->sta.wcid, NULL);
 	}
 	mt76_queue_kick(dev, q);
 	spin_unlock(&q->lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 96ec96df6a3c..e9c5e85ec07c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -59,7 +59,8 @@ static void mt76x02_pre_tbtt_tasklet(struct tasklet_struct *t)
 		struct ieee80211_vif *vif = info->control.vif;
 		struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
 
-		mt76_tx_queue_skb(dev, q, skb, &mvif->group_wcid, NULL);
+		mt76_tx_queue_skb(dev, q, MT_TXQ_PSD, skb, &mvif->group_wcid,
+				  NULL);
 	}
 	spin_unlock(&q->lock);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index def7f325f5c5..974fdbf0ffab 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -517,8 +517,8 @@ static void mt76s_tx_status_data(struct work_struct *work)
 
 static int
 mt76s_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
-		   struct sk_buff *skb, struct mt76_wcid *wcid,
-		   struct ieee80211_sta *sta)
+		   enum mt76_txq_id qid, struct sk_buff *skb,
+		   struct mt76_wcid *wcid, struct ieee80211_sta *sta)
 {
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
@@ -530,7 +530,7 @@ mt76s_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 		return -ENOSPC;
 
 	skb->prev = skb->next = NULL;
-	err = dev->drv->tx_prepare_skb(dev, NULL, q->qid, wcid, sta, &tx_info);
+	err = dev->drv->tx_prepare_skb(dev, NULL, qid, wcid, sta, &tx_info);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 382b45639f26..47ac0ca1af32 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -50,8 +50,8 @@ void mt76_testmode_tx_pending(struct mt76_phy *phy)
 	       q->queued < q->ndesc / 2) {
 		int ret;
 
-		ret = dev->queue_ops->tx_queue_skb(dev, q, skb_get(skb), wcid,
-						   NULL);
+		ret = dev->queue_ops->tx_queue_skb(dev, q, qid, skb_get(skb),
+						   wcid, NULL);
 		if (ret < 0)
 			break;
 
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 1d08d99e298c..e1d5996c4675 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -284,7 +284,7 @@ __mt76_tx_queue_skb(struct mt76_phy *phy, int qid, struct sk_buff *skb,
 	int idx;
 
 	non_aql = !info->tx_time_est;
-	idx = dev->queue_ops->tx_queue_skb(dev, q, skb, wcid, sta);
+	idx = dev->queue_ops->tx_queue_skb(dev, q, qid, skb, wcid, sta);
 	if (idx < 0 || !sta)
 		return idx;
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 1bb92ca7451b..b030b567989b 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -845,8 +845,8 @@ mt76u_tx_setup_buffers(struct mt76_dev *dev, struct sk_buff *skb,
 
 static int
 mt76u_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
-		   struct sk_buff *skb, struct mt76_wcid *wcid,
-		   struct ieee80211_sta *sta)
+		   enum mt76_txq_id qid, struct sk_buff *skb,
+		   struct mt76_wcid *wcid, struct ieee80211_sta *sta)
 {
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
@@ -858,7 +858,7 @@ mt76u_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 		return -ENOSPC;
 
 	skb->prev = skb->next = NULL;
-	err = dev->drv->tx_prepare_skb(dev, NULL, q->qid, wcid, sta, &tx_info);
+	err = dev->drv->tx_prepare_skb(dev, NULL, qid, wcid, sta, &tx_info);
 	if (err < 0)
 		return err;
 
-- 
2.36.1

