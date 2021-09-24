Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDC4417812
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 17:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347197AbhIXQAY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 12:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbhIXQAY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 12:00:24 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA325C061571
        for <linux-wireless@vger.kernel.org>; Fri, 24 Sep 2021 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9ZasSQR5Ou2STFhbEEWYw6pvjHilbA/no9Asm6mn4ic=; b=D2dELNwPLFtFUSwnluFY6kNRQY
        La1XmXcoU/marh6MtnyQYzLZkoM+k5x8nhgVW9r3IjWXJFCpxkyq0LjOAJ2uvSYxLwP3mKXqEMXkm
        ypnPMEIivSSFe1Qv9BzAtwKiq4MAk079ZRD6/u4ydf5IkTz1LA2nzBUCjCsOTkYKgthY=;
Received: from p57a6fa93.dip0.t-ipconnect.de ([87.166.250.147] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mTnb6-0008K6-N7
        for linux-wireless@vger.kernel.org; Fri, 24 Sep 2021 17:58:48 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: disable BH around napi_schedule() calls
Date:   Fri, 24 Sep 2021 17:58:46 +0200
Message-Id: <20210924155846.93063-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

napi_schedule() can call __raise_softirq_irqoff(), which can perform softirq
handling, so it must not be called in a pure process context with BH enabled.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c     | 7 +++++--
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c     | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c | 3 +++
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c     | 2 ++
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c   | 6 ++++--
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c     | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c     | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c     | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c     | 3 +++
 9 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 3972c56136a2..d1cbe06ee8da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1471,17 +1471,20 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 	mutex_unlock(&dev->mt76.mutex);
 
 	mt76_worker_enable(&dev->mt76.tx_worker);
-	napi_enable(&dev->mt76.tx_napi);
-	napi_schedule(&dev->mt76.tx_napi);
 
 	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 	mt7603_beacon_set_timer(dev, -1, beacon_int);
 
+	local_bh_disable();
+	napi_enable(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.tx_napi);
+
 	napi_enable(&dev->mt76.napi[0]);
 	napi_schedule(&dev->mt76.napi[0]);
 
 	napi_enable(&dev->mt76.napi[1]);
 	napi_schedule(&dev->mt76.napi[1]);
+	local_bh_enable();
 
 	ieee80211_wake_queues(dev->mt76.hw);
 	mt76_txq_schedule_all(&dev->mphy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 7a54ea6a86d0..b808248943ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -164,12 +164,14 @@ static int mt7615_pci_resume(struct pci_dev *pdev)
 		dev_err(mdev->dev, "PDMA engine must be reinitialized\n");
 
 	mt76_worker_enable(&mdev->tx_worker);
+	local_bh_disable();
 	mt76_for_each_q_rx(mdev, i) {
 		napi_enable(&mdev->napi[i]);
 		napi_schedule(&mdev->napi[i]);
 	}
 	napi_enable(&mdev->tx_napi);
 	napi_schedule(&mdev->tx_napi);
+	local_bh_enable();
 
 	if (!test_bit(MT76_STATE_SUSPEND, &dev->mphy.state) &&
 	    mt7615_firmware_offload(dev))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index da87c02a73eb..0a4caddeb75d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -326,6 +326,8 @@ void mt7615_mac_reset_work(struct work_struct *work)
 		clear_bit(MT76_RESET, &phy2->mt76->state);
 
 	mt76_worker_enable(&dev->mt76.tx_worker);
+
+	local_bh_disable();
 	napi_enable(&dev->mt76.tx_napi);
 	napi_schedule(&dev->mt76.tx_napi);
 
@@ -334,6 +336,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
 
 	napi_enable(&dev->mt76.napi[1]);
 	napi_schedule(&dev->mt76.napi[1]);
+	local_bh_enable();
 
 	ieee80211_wake_queues(mt76_hw(dev));
 	if (ext_phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index 92ddb8c68938..f19228fc5a70 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -276,6 +276,7 @@ static int mt76x0e_resume(struct pci_dev *pdev)
 
 	mt76_worker_enable(&mdev->tx_worker);
 
+	local_bh_disable();
 	mt76_for_each_q_rx(mdev, i) {
 		mt76_queue_rx_reset(dev, i);
 		napi_enable(&mdev->napi[i]);
@@ -284,6 +285,7 @@ static int mt76x0e_resume(struct pci_dev *pdev)
 
 	napi_enable(&mdev->tx_napi);
 	napi_schedule(&mdev->tx_napi);
+	local_bh_enable();
 
 	return mt76x0e_init_hardware(dev, true);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index b50084bbe83d..f4451fbec958 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -491,15 +491,17 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	clear_bit(MT76_RESET, &dev->mphy.state);
 
 	mt76_worker_enable(&dev->mt76.tx_worker);
+	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
+
+	local_bh_disable();
 	napi_enable(&dev->mt76.tx_napi);
 	napi_schedule(&dev->mt76.tx_napi);
 
-	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
-
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		napi_enable(&dev->mt76.napi[i]);
 		napi_schedule(&dev->mt76.napi[i]);
 	}
+	local_bh_enable();
 
 	if (restart) {
 		set_bit(MT76_RESTART, &dev->mphy.state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
index fb8de1833937..8a22ee581674 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
@@ -149,12 +149,15 @@ mt76x2e_resume(struct pci_dev *pdev)
 	pci_restore_state(pdev);
 
 	mt76_worker_enable(&mdev->tx_worker);
+
+	local_bh_disable();
 	mt76_for_each_q_rx(mdev, i) {
 		napi_enable(&mdev->napi[i]);
 		napi_schedule(&mdev->napi[i]);
 	}
 	napi_enable(&mdev->tx_napi);
 	napi_schedule(&mdev->tx_napi);
+	local_bh_enable();
 
 	return mt76x2_resume_device(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 02e2b8f80720..81cde3c1d915 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1837,6 +1837,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	if (phy2)
 		clear_bit(MT76_RESET, &phy2->mt76->state);
 
+	local_bh_disable();
 	napi_enable(&dev->mt76.napi[0]);
 	napi_schedule(&dev->mt76.napi[0]);
 
@@ -1845,6 +1846,8 @@ void mt7915_mac_reset_work(struct work_struct *work)
 
 	napi_enable(&dev->mt76.napi[2]);
 	napi_schedule(&dev->mt76.napi[2]);
+	local_bh_enable();
+
 	tasklet_schedule(&dev->irq_tasklet);
 
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 87f73acd181c..3e87380ebe0c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1394,10 +1394,12 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 
 	mt7921_wpdma_reset(dev, true);
 
+	local_bh_disable();
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		napi_enable(&dev->mt76.napi[i]);
 		napi_schedule(&dev->mt76.napi[i]);
 	}
+	local_bh_enable();
 
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
 
@@ -1422,8 +1424,11 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 out:
 	clear_bit(MT76_RESET, &dev->mphy.state);
 
+	local_bh_disable();
 	napi_enable(&dev->mt76.tx_napi);
 	napi_schedule(&dev->mt76.tx_napi);
+	local_bh_enable();
+
 	mt76_worker_enable(&dev->mt76.tx_worker);
 
 	return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 44075f8f6e79..b5622b612613 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -302,12 +302,15 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
 		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
 
 	mt76_worker_enable(&mdev->tx_worker);
+
+	local_bh_disable();
 	mt76_for_each_q_rx(mdev, i) {
 		napi_enable(&mdev->napi[i]);
 		napi_schedule(&mdev->napi[i]);
 	}
 	napi_enable(&mdev->tx_napi);
 	napi_schedule(&mdev->tx_napi);
+	local_bh_enable();
 
 	/* restore previous ds setting */
 	if (!pm->ds_enable)
-- 
2.30.1

