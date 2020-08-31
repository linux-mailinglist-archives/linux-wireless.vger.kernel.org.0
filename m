Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D106257931
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 14:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHaM0k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 08:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgHaM0L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 08:26:11 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD27C061239
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=af77drqHF/Lf6fbXmFP+rG/i621fUpofm4yIk2ErKS4=; b=O/kl2JGL2QALYUX9p/Bk+oLBu9
        pz1kYP7xMwbqh8SuRPwnP7lzw5Ye5xeDm6B26I0sA0KNtmqPqaxHHlxgmSHAvu/Flh1x4n3VDIJYM
        eJ9oelbwFVCJMkyXr5Li/nk55N346YwuTHxzW2gK0hvAB/gwb9wo8QzG9lrdjXie6xdM=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kCiss-0000Ok-3u
        for linux-wireless@vger.kernel.org; Mon, 31 Aug 2020 14:26:02 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/9] mt76: remove qid argument to drv->tx_complete_skb
Date:   Mon, 31 Aug 2020 14:25:53 +0200
Message-Id: <20200831122558.1388-4-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831122558.1388-1-nbd@nbd.name>
References: <20200831122558.1388-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is not needed

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c              | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76.h             | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c       | 7 ++-----
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h    | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h    | 4 +---
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c   | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c  | 1 -
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c      | 3 +--
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.h      | 3 +--
 drivers/net/wireless/mediatek/mt76/mt76x02_usb.h      | 3 +--
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c       | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    | 3 +--
 drivers/net/wireless/mediatek/mt76/tx.c               | 2 +-
 14 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index cab8422d8a83..0d47d29e5003 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -359,7 +359,7 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 
 	e.skb = tx_info.skb;
 	e.txwi = t;
-	dev->drv->tx_complete_skb(dev, qid, &e);
+	dev->drv->tx_complete_skb(dev, &e);
 	mt76_put_txwi(dev, t);
 	return ret;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 23e8d63677da..6f4ced53284c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -326,7 +326,7 @@ struct mt76_driver_ops {
 			      struct ieee80211_sta *sta,
 			      struct mt76_tx_info *tx_info);
 
-	void (*tx_complete_skb)(struct mt76_dev *dev, enum mt76_txq_id qid,
+	void (*tx_complete_skb)(struct mt76_dev *dev,
 				struct mt76_queue_entry *e);
 
 	bool (*tx_status_data)(struct mt76_dev *dev, u8 *update);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 625dc6d581f2..cb99b7c39f51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1271,8 +1271,7 @@ void mt7603_mac_add_txs(struct mt7603_dev *dev, void *data)
 	rcu_read_unlock();
 }
 
-void mt7603_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
-			    struct mt76_queue_entry *e)
+void mt7603_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 {
 	struct mt7603_dev *dev = container_of(mdev, struct mt7603_dev, mt76);
 	struct sk_buff *skb = e->skb;
@@ -1282,9 +1281,7 @@ void mt7603_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
 		return;
 	}
 
-	if (qid < 4)
-		dev->tx_hang_check = 0;
-
+	dev->tx_hang_check = 0;
 	mt76_tx_complete_skb(mdev, skb);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index c86305241e66..f40dbfa7d2da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -241,8 +241,7 @@ int mt7603_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  struct ieee80211_sta *sta,
 			  struct mt76_tx_info *tx_info);
 
-void mt7603_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
-			    struct mt76_queue_entry *e);
+void mt7603_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 
 void mt7603_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index bcd09cc52ce8..9e048ff85d0c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -618,8 +618,7 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  struct ieee80211_sta *sta,
 			  struct mt76_tx_info *tx_info);
 
-void mt7615_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
-			    struct mt76_queue_entry *e);
+void mt7615_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 
 void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
@@ -674,7 +673,6 @@ int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 				   struct mt76_tx_info *tx_info);
 bool mt7663_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update);
 void mt7663_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
-				     enum mt76_txq_id qid,
 				     struct mt76_queue_entry *e);
 void mt7663_usb_sdio_wtbl_work(struct work_struct *work);
 int mt7663_usb_sdio_register_device(struct mt7615_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 51b2e0467592..ba53606c4586 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -14,8 +14,7 @@
 #include "../dma.h"
 #include "mac.h"
 
-void mt7615_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
-			    struct mt76_queue_entry *e)
+void mt7615_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 {
 	if (!e->txwi) {
 		dev_kfree_skb_any(e->skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index 294276e2280d..30065b015776 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -226,7 +226,6 @@ bool mt7663_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update)
 EXPORT_SYMBOL_GPL(mt7663_usb_sdio_tx_status_data);
 
 void mt7663_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
-				     enum mt76_txq_id qid,
 				     struct mt76_queue_entry *e)
 {
 	unsigned int headroom = MT_USB_TXD_SIZE;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index af2e6ffce001..4c7a0482b344 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -900,8 +900,7 @@ void mt76x02_mac_poll_tx_status(struct mt76x02_dev *dev, bool irq)
 	}
 }
 
-void mt76x02_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
-			     struct mt76_queue_entry *e)
+void mt76x02_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 {
 	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
 	struct mt76x02_txwi *txwi;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
index c70d17b2290c..0cfbaca50210 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
@@ -194,8 +194,7 @@ void mt76x02_mac_write_txwi(struct mt76x02_dev *dev, struct mt76x02_txwi *txwi,
 			    struct sk_buff *skb, struct mt76_wcid *wcid,
 			    struct ieee80211_sta *sta, int len);
 void mt76x02_mac_poll_tx_status(struct mt76x02_dev *dev, bool irq);
-void mt76x02_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
-			     struct mt76_queue_entry *e);
+void mt76x02_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 void mt76x02_update_channel(struct mt76_dev *mdev);
 void mt76x02_mac_work(struct work_struct *work);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb.h b/drivers/net/wireless/mediatek/mt76/mt76x02_usb.h
index a57dcc8820aa..b5be884b3549 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb.h
@@ -19,8 +19,7 @@ int mt76x02u_tx_prepare_skb(struct mt76_dev *mdev, void *data,
 			    enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			    struct ieee80211_sta *sta,
 			    struct mt76_tx_info *tx_info);
-void mt76x02u_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
-			      struct mt76_queue_entry *e);
+void mt76x02u_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 void mt76x02u_init_beacon_config(struct mt76x02_dev *dev);
 void mt76x02u_exit_beacon_config(struct mt76x02_dev *dev);
 #endif /* __MT76x02_USB_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 37321e656776..cc28583226ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -15,8 +15,7 @@ static void mt76x02u_remove_dma_hdr(struct sk_buff *skb)
 		mt76x02_remove_hdr_pad(skb, 2);
 }
 
-void mt76x02u_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
-			      struct mt76_queue_entry *e)
+void mt76x02u_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 {
 	mt76x02u_remove_dma_hdr(e->skb);
 	mt76_tx_complete_skb(mdev, e->skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 22d12dd3a608..cbcdd30a24d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -943,8 +943,7 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	tasklet_schedule(&dev->mt76.tx_tasklet);
 }
 
-void mt7915_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
-			    struct mt76_queue_entry *e)
+void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 {
 	struct mt7915_dev *dev;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 83685a974224..ab3f209ff6cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -454,8 +454,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
 			  struct mt76_tx_info *tx_info);
-void mt7915_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
-			    struct mt76_queue_entry *e);
+void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
 void mt7915_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 1a2f2163c6c3..3dac8f7dbff6 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -704,7 +704,7 @@ void mt76_queue_tx_complete(struct mt76_dev *dev, struct mt76_queue *q,
 	bool ext_phy = e->qid >= 4;
 
 	if (e->skb)
-		dev->drv->tx_complete_skb(dev, qid, e);
+		dev->drv->tx_complete_skb(dev, e);
 
 	spin_lock_bh(&q->lock);
 	q->tail = (q->tail + 1) % q->ndesc;
-- 
2.28.0

