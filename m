Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6A73AC5C1
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 10:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhFRIKt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 04:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232415AbhFRIKs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 04:10:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB8ED61220;
        Fri, 18 Jun 2021 08:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624003719;
        bh=9WCO6/MR1Ez57HmPy07vbtOld8l0CPLCT/ty0hfzClc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9QS4BCe18lKZW5+rMdMaqYYl8zy+nMRcAOuGA2zlb5+wFpScL5Frawr0YV1ckU7a
         IP+xR3eYvzkxJyjBzn7achj/1YzQludzn4F+v/zwBLbNhpJh6wqYXiRyxdKUY3ZUzX
         Bwn8qh7VEQxbgCY6zBgWfI+rITz+NvHaYzVEmBzI/sEssWnBJGxtneYIYxAPQEOylJ
         mfWQUk/Cti1mLJ/nHyuoXX9b7KkqRl1O0dGUlfflO+z7wkyTvMsh3VHHtbW3QepI6A
         0qcqNQEv9OERldZLcv3BDjYqwtRddMQE2/Zm6ElpD/RszjBsTWE6GKxJ1Qh4TLQz26
         pNnnBXnsFq5MQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH v2 3/5] mt76: mt7663s: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx path
Date:   Fri, 18 Jun 2021 10:08:22 +0200
Message-Id: <b65e861da1a54871c6358766edc81e2f3d9d8233.1624003282.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624003282.git.lorenzo@kernel.org>
References: <cover.1624003282.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7663e, rely on mt76_connac_pm_ref/mt76_connac_pm_unref to
check PM state and increment/decrement wake counter

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  | 14 ++++++++++----
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c    | 16 ++++++++++++----
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index f540b6188ba1..c7d0b2e52d60 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1904,12 +1904,18 @@ void mt7615_pm_wake_work(struct work_struct *work)
 	mphy = dev->phy.mt76;
 
 	if (!mt7615_mcu_set_drv_ctrl(dev)) {
+		struct mt76_dev *mdev = &dev->mt76;
 		int i;
 
-		mt76_for_each_q_rx(&dev->mt76, i)
-			napi_schedule(&dev->mt76.napi[i]);
-		mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
-		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], false);
+		if (mt76_is_sdio(mdev)) {
+			mt76_worker_schedule(&mdev->sdio.txrx_worker);
+		} else {
+			mt76_for_each_q_rx(mdev, i)
+				napi_schedule(&mdev->napi[i]);
+			mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
+			mt76_queue_tx_cleanup(dev, mdev->q_mcu[MT_MCUQ_WM],
+					      false);
+		}
 		if (test_bit(MT76_STATE_RUNNING, &mphy->state))
 			ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
 						     MT7615_WATCHDOG_TIME);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index 4393dd21ebbb..04f4c89b7499 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -283,9 +283,15 @@ void mt7663s_txrx_worker(struct mt76_worker *w)
 {
 	struct mt76_sdio *sdio = container_of(w, struct mt76_sdio,
 					      txrx_worker);
-	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
+	struct mt76_dev *mdev = container_of(sdio, struct mt76_dev, sdio);
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	int i, nframes, ret;
 
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
+		queue_work(mdev->wq, &dev->pm.wake_work);
+		return;
+	}
+
 	/* disable interrupt */
 	sdio_claim_host(sdio->func);
 	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
@@ -295,16 +301,16 @@ void mt7663s_txrx_worker(struct mt76_worker *w)
 
 		/* tx */
 		for (i = 0; i <= MT_TXQ_PSD; i++) {
-			ret = mt7663s_tx_run_queue(dev, dev->phy.q_tx[i]);
+			ret = mt7663s_tx_run_queue(mdev, mdev->phy.q_tx[i]);
 			if (ret > 0)
 				nframes += ret;
 		}
-		ret = mt7663s_tx_run_queue(dev, dev->q_mcu[MT_MCUQ_WM]);
+		ret = mt7663s_tx_run_queue(mdev, mdev->q_mcu[MT_MCUQ_WM]);
 		if (ret > 0)
 			nframes += ret;
 
 		/* rx */
-		ret = mt7663s_rx_handler(dev);
+		ret = mt7663s_rx_handler(mdev);
 		if (ret > 0)
 			nframes += ret;
 	} while (nframes > 0);
@@ -312,6 +318,8 @@ void mt7663s_txrx_worker(struct mt76_worker *w)
 	/* enable interrupt */
 	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
 	sdio_release_host(sdio->func);
+
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
 }
 
 void mt7663s_sdio_irq(struct sdio_func *func)
-- 
2.31.1

