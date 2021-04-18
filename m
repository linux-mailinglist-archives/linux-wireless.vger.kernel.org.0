Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5063636C1
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhDRQqd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhDRQqd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E9916135B;
        Sun, 18 Apr 2021 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764365;
        bh=qJjqRhn/U9SoUfH9yvWHrxZIm7V85aUSE62hRxj3KkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b8KzOpKSZwPCt1EVYe3x131nKoelWODVS/8mcuBPLFeutqBw4cojv32V3QijjyBAG
         4j46HiiD/5yCOxlgpmgl1mixkYKQE5LPLGeg2fdFe+kETziTqQFSoiDVKjbmvLflJR
         blhuiuygMfWQaB3BOuRTeE0T6o7Oe1201cwP0HzLmID60YClEJ2rm1KQn33fNnrFdi
         zO+5S2507snAAF8yx3Q30XVUIIvk8QuXMn2jiJ0E34axUV1dDsH723yI5UIZw6Kg9Y
         BQtL9Y+ht0DODRkrXeNK8vRqkPMQJlVTUOk4NhaSGYeBvXiWnR57XuDqj3FrUU3r+x
         4jF0ScFj5WsQg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 07/19] mt76: mt7921: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx/rx napi
Date:   Sun, 18 Apr 2021 18:45:33 +0200
Message-Id: <7d092c9f3d17fc6426f2f093ea1a8f3abd968a4e.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7921_poll_rx rx napi callback for mt7921.
Do not access device registers in tx/rx napi if the device is not awake.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 33 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 11 +++++--
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index b056ac15f09a..c26979614113 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -53,8 +53,7 @@ void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	}
 }
 
-static void
-mt7921_tx_cleanup(struct mt7921_dev *dev)
+void mt7921_tx_cleanup(struct mt7921_dev *dev)
 {
 	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], false);
 	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WA], false);
@@ -66,14 +65,38 @@ static int mt7921_poll_tx(struct napi_struct *napi, int budget)
 
 	dev = container_of(napi, struct mt7921_dev, mt76.tx_napi);
 
-	mt7921_tx_cleanup(dev);
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
+		napi_complete(napi);
+		queue_work(dev->mt76.wq, &dev->pm.wake_work);
+		return 0;
+	}
 
-	if (napi_complete_done(napi, 0))
+	mt7921_tx_cleanup(dev);
+	if (napi_complete(napi))
 		mt7921_irq_enable(dev, MT_INT_TX_DONE_ALL);
+	mt76_connac_pm_unref(&dev->pm);
 
 	return 0;
 }
 
+static int mt7921_poll_rx(struct napi_struct *napi, int budget)
+{
+	struct mt7921_dev *dev;
+	int done;
+
+	dev = container_of(napi->dev, struct mt7921_dev, mt76.napi_dev);
+
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
+		napi_complete(napi);
+		queue_work(dev->mt76.wq, &dev->pm.wake_work);
+		return 0;
+	}
+	done = mt76_dma_rx_poll(napi, budget);
+	mt76_connac_pm_unref(&dev->pm);
+
+	return done;
+}
+
 void mt7921_dma_prefetch(struct mt7921_dev *dev)
 {
 #define PREFETCH(base, depth)	((base) << 16 | (depth))
@@ -295,7 +318,7 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = mt76_init_queues(dev, mt76_dma_rx_poll);
+	ret = mt76_init_queues(dev, mt7921_poll_rx);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index c8819e78cea3..def00b255495 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1367,6 +1367,7 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 	mt76_worker_enable(&dev->mt76.tx_worker);
 
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	clear_bit(MT76_STATE_PM, &dev->mphy.state);
 
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
@@ -1530,10 +1531,14 @@ void mt7921_pm_wake_work(struct work_struct *work)
 						pm.wake_work);
 	mphy = dev->phy.mt76;
 
-	if (!mt7921_mcu_drv_pmctrl(dev))
+	if (!mt7921_mcu_drv_pmctrl(dev)) {
+		int i;
+
+		mt76_for_each_q_rx(&dev->mt76, i)
+			napi_schedule(&dev->mt76.napi[i]);
 		mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
-	else
-		dev_err(mphy->dev->dev, "failed to wake device\n");
+		mt7921_tx_cleanup(dev);
+	}
 
 	ieee80211_wake_queues(mphy->hw);
 	complete_all(&dev->pm.wake_cmpl);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index a794c074867e..c9687c57cbe7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -332,6 +332,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 void mt7921_mac_work(struct work_struct *work);
 void mt7921_mac_reset_work(struct work_struct *work);
 void mt7921_reset(struct mt76_dev *mdev);
+void mt7921_tx_cleanup(struct mt7921_dev *dev);
 int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
-- 
2.30.2

