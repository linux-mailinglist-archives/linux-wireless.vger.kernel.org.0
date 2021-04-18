Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE353636C2
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhDRQqf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232095AbhDRQqe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EFF76101E;
        Sun, 18 Apr 2021 16:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764366;
        bh=+nlxpZTvYyG9QYGOyai7tZy+TZ7WYjEbAS1b1F1OKXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AjHu0FCSE70eUSN7TPF06XNJDgTEDTcj2cqXS9883og53P/IDL2A2QpGopHD5h39H
         VJmNifRjJ2vo36WXRsr8LA7jHFKp6jQigXYAzjdXe+DXJTe0cJSnJbDSq3/dyjWPtR
         rpD8WNy+ST6qkeiv+qeetXcXyVcCUhAgK1brOCd6IN+kkZomVU1uQ4Zsr6XC/u8/5B
         TEoeVQCDTA6uJ5ftwPlpwdEV3c/1RxLrNOItUwyeroArEFa7ouLTxDMgu+1H6h42Jx
         WbJac21qzVl5gCAkis9oNu1Y64lHKAJ+6GDKp668KIUVGuDUa0lhbNp0ByjJgpMkHE
         /dHDgjPmIP0bA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 08/19] mt76: mt7663: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx/rx napi
Date:   Sun, 18 Apr 2021 18:45:34 +0200
Message-Id: <3bc75d18c09275187c2595da9f033efd7abca019.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_poll_rx rx napi callback for mt7663.
Do not access device registers in tx/rx napi if the device is not awake.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   | 30 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 10 +++++--
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index d658555f5965..8004ae5c16a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -71,15 +71,39 @@ static int mt7615_poll_tx(struct napi_struct *napi, int budget)
 	struct mt7615_dev *dev;
 
 	dev = container_of(napi, struct mt7615_dev, mt76.tx_napi);
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
+		napi_complete(napi);
+		queue_work(dev->mt76.wq, &dev->pm.wake_work);
+		return 0;
+	}
 
 	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], false);
-
-	if (napi_complete_done(napi, 0))
+	if (napi_complete(napi))
 		mt7615_irq_enable(dev, mt7615_tx_mcu_int_mask(dev));
 
+	mt76_connac_pm_unref(&dev->pm);
+
 	return 0;
 }
 
+static int mt7615_poll_rx(struct napi_struct *napi, int budget)
+{
+	struct mt7615_dev *dev;
+	int done;
+
+	dev = container_of(napi->dev, struct mt7615_dev, mt76.napi_dev);
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
 int mt7615_wait_pdma_busy(struct mt7615_dev *dev)
 {
 	struct mt76_dev *mdev = &dev->mt76;
@@ -261,7 +285,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 
 	mt76_wr(dev, MT_DELAY_INT_CFG, 0);
 
-	ret = mt76_init_queues(dev, mt76_dma_rx_poll);
+	ret = mt76_init_queues(dev, mt7615_poll_rx);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 0b386030dbd8..e81c7d322811 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1913,10 +1913,14 @@ void mt7615_pm_wake_work(struct work_struct *work)
 						pm.wake_work);
 	mphy = dev->phy.mt76;
 
-	if (!mt7615_mcu_set_drv_ctrl(dev))
+	if (!mt7615_mcu_set_drv_ctrl(dev)) {
+		int i;
+
+		mt76_for_each_q_rx(&dev->mt76, i)
+			napi_schedule(&dev->mt76.napi[i]);
 		mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
-	else
-		dev_err(mphy->dev->dev, "failed to wake device\n");
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], false);
+	}
 
 	ieee80211_wake_queues(mphy->hw);
 	complete_all(&dev->pm.wake_cmpl);
-- 
2.30.2

