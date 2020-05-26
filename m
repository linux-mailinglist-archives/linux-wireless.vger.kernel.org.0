Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598551E029A
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2020 21:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbgEXTfm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 May 2020 15:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387744AbgEXTfl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 May 2020 15:35:41 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809F9C061A0E
        for <linux-wireless@vger.kernel.org>; Sun, 24 May 2020 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dFXu1FcRaq6PLUgBvghNrSxwtqxMr7QiIweSpT1KIyo=; b=Fu+GQYZvsD19huGZkX8XsJUSMJ
        EqS5vzdRUA8/1+eNq0dypBuH7kddVmCpSFUAJBT1ZX4HzTcyVfvBqFvswqVbXkzMTDSUJbx2Jkpr1
        9E677q2wsll7Pwy8qxZEX3cOPvyenToWZe2aSmMRbjlxpE6q8WOcIy4P0IDuSE8dKrVM=;
Received: from p5b206c3b.dip0.t-ipconnect.de ([91.32.108.59] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jcwPH-0001yq-RM; Sun, 24 May 2020 21:35:37 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id B83A387D6389; Sun, 24 May 2020 21:35:32 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2] mt76: only iterate over initialized rx queues
Date:   Sun, 24 May 2020 21:35:32 +0200
Message-Id: <20200524193532.60124-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following reported crash:

[    2.361127] BUG: spinlock bad magic on CPU#0, modprobe/456
[    2.361583]  lock: 0xffffa1287525b3b8, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
[    2.362250] CPU: 0 PID: 456 Comm: modprobe Not tainted 4.14.177 #5
[    2.362751] Hardware name: HP Meep/Meep, BIOS Google_Meep.11297.75.0 06/17/2019
[    2.363343] Call Trace:
[    2.363552]  dump_stack+0x97/0xdb
[    2.363826]  ? spin_bug+0xa6/0xb3
[    2.364096]  do_raw_spin_lock+0x6a/0x9a
[    2.364417]  mt76_dma_rx_fill+0x44/0x1de [mt76]
[    2.364787]  ? mt76_dma_kick_queue+0x18/0x18 [mt76]
[    2.365184]  mt76_dma_init+0x53/0x85 [mt76]
[    2.365532]  mt7615_dma_init+0x3d7/0x546 [mt7615e]
[    2.365928]  mt7615_register_device+0xe6/0x1a0 [mt7615e]
[    2.366364]  mt7615_mmio_probe+0x14b/0x171 [mt7615e]
[    2.366771]  mt7615_pci_probe+0x118/0x13b [mt7615e]
[    2.367169]  pci_device_probe+0xaf/0x13d
[    2.367491]  driver_probe_device+0x284/0x2ca
[    2.367840]  __driver_attach+0x7a/0x9e
[    2.368146]  ? driver_attach+0x1f/0x1f
[    2.368451]  bus_for_each_dev+0xa0/0xdb
[    2.368765]  bus_add_driver+0x132/0x204
[    2.369078]  driver_register+0x8e/0xcd
[    2.369384]  do_one_initcall+0x160/0x257
[    2.369706]  ? 0xffffffffc0240000
[    2.369980]  do_init_module+0x60/0x1bb
[    2.370286]  load_module+0x18c2/0x1a2b
[    2.370596]  ? kernel_read_file+0x141/0x1b9
[    2.370937]  ? kernel_read_file_from_fd+0x46/0x71
[    2.371320]  SyS_finit_module+0xcc/0xf0
[    2.371636]  do_syscall_64+0x6b/0xf7
[    2.371930]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[    2.372344] RIP: 0033:0x7da218ae4199
[    2.372637] RSP: 002b:00007fffd0608398 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    2.373252] RAX: ffffffffffffffda RBX: 00005a705449df90 RCX: 00007da218ae4199
[    2.373833] RDX: 0000000000000000 RSI: 00005a7052e73bd8 RDI: 0000000000000006
[    2.374411] RBP: 00007fffd06083e0 R08: 0000000000000000 R09: 00005a705449d540
[    2.374989] R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000000
[    2.375569] R13: 00005a705449def0 R14: 00005a7052e73bd8 R15: 0000000000000000

Reported-by: Sean Wang <sean.wang@mediatek.com>
Fixes: d3377b78cec6 ("mt76: add HE phy modes and hardware queue")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/dma.c          | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76.h         | 4 ++++
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c   | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c   | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c   | 8 +++++---
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c   | 3 ++-
 8 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index 0278e1b44576..3a5de1d1b121 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -51,7 +51,7 @@ static int mt76_rx_queues_read(struct seq_file *s, void *data)
 	struct mt76_dev *dev = dev_get_drvdata(s->private);
 	int i, queued;
 
-	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++) {
+	mt76_for_each_q_rx(dev, i) {
 		struct mt76_queue *q = &dev->q_rx[i];
 
 		if (!q->ndesc)
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 75e659774e07..f4d6074fe32a 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -576,7 +576,7 @@ mt76_dma_init(struct mt76_dev *dev)
 
 	init_dummy_netdev(&dev->napi_dev);
 
-	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++) {
+	mt76_for_each_q_rx(dev, i) {
 		netif_napi_add(&dev->napi_dev, &dev->napi[i], mt76_dma_rx_poll,
 			       64);
 		mt76_dma_rx_fill(dev, &dev->q_rx[i]);
@@ -610,7 +610,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 	for (i = 0; i < ARRAY_SIZE(dev->q_tx); i++)
 		mt76_dma_tx_cleanup(dev, i, true);
 
-	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++) {
+	mt76_for_each_q_rx(dev, i) {
 		netif_napi_del(&dev->napi[i]);
 		mt76_dma_rx_cleanup(dev, &dev->q_rx[i]);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index afb1ccf61b74..dfe625a53c63 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -671,6 +671,10 @@ static inline u16 mt76_rev(struct mt76_dev *dev)
 #define mt76_queue_tx_cleanup(dev, ...)	(dev)->mt76.queue_ops->tx_cleanup(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_kick(dev, ...)	(dev)->mt76.queue_ops->kick(&((dev)->mt76), __VA_ARGS__)
 
+#define mt76_for_each_q_rx(dev, i)	\
+	for (i = 0; i < ARRAY_SIZE((dev)->q_rx) && \
+		    (dev)->q_rx[i].ndesc; i++)
+
 struct mt76_dev *mt76_alloc_device(struct device *pdev, unsigned int size,
 				   const struct ieee80211_ops *ops,
 				   const struct mt76_driver_ops *drv_ops);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 0f205ffe4905..8060c1514396 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1438,8 +1438,9 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 	for (i = 0; i < __MT_TXQ_MAX; i++)
 		mt76_queue_tx_cleanup(dev, i, true);
 
-	for (i = 0; i < ARRAY_SIZE(dev->mt76.q_rx); i++)
+	mt76_for_each_q_rx(&dev->mt76, i) {
 		mt76_queue_rx_reset(dev, i);
+	}
 
 	mt7603_dma_sched_reset(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index f1009c92ec1b..9f1c6ca7a665 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1820,8 +1820,9 @@ void mt7615_dma_reset(struct mt7615_dev *dev)
 	for (i = 0; i < __MT_TXQ_MAX; i++)
 		mt76_queue_tx_cleanup(dev, i, true);
 
-	for (i = 0; i < ARRAY_SIZE(dev->mt76.q_rx); i++)
+	mt76_for_each_q_rx(&dev->mt76, i) {
 		mt76_queue_rx_reset(dev, i);
+	}
 
 	mt76_set(dev, MT_WPDMA_GLO_CFG,
 		 MT_WPDMA_GLO_CFG_RX_DMA_EN | MT_WPDMA_GLO_CFG_TX_DMA_EN |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index b09d08d0dac9..ba12f199bce0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -86,8 +86,9 @@ static int mt7615_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	napi_disable(&mdev->tx_napi);
 	tasklet_kill(&mdev->tx_tasklet);
 
-	for (i = 0; i < ARRAY_SIZE(mdev->q_rx); i++)
+	mt76_for_each_q_rx(mdev, i) {
 		napi_disable(&mdev->napi[i]);
+	}
 	tasklet_kill(&dev->irq_tasklet);
 
 	mt7615_dma_reset(dev);
@@ -120,8 +121,9 @@ static int mt7615_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	return 0;
 
 restore:
-	for (i = 0; i < ARRAY_SIZE(mdev->q_rx); i++)
+	mt76_for_each_q_rx(mdev, i) {
 		napi_enable(&mdev->napi[i]);
+	}
 	napi_enable(&mdev->tx_napi);
 	if (hif_suspend)
 		mt7615_mcu_set_hif_suspend(dev, false);
@@ -156,7 +158,7 @@ static int mt7615_pci_resume(struct pci_dev *pdev)
 	if (pdma_reset)
 		dev_err(mdev->dev, "PDMA engine must be reinitialized\n");
 
-	for (i = 0; i < ARRAY_SIZE(mdev->q_rx); i++) {
+	mt76_for_each_q_rx(mdev, i) {
 		napi_enable(&mdev->napi[i]);
 		napi_schedule(&mdev->napi[i]);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 18adedfbbb8e..cbbe986655fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -489,8 +489,9 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	for (i = 0; i < __MT_TXQ_MAX; i++)
 		mt76_queue_tx_cleanup(dev, i, true);
 
-	for (i = 0; i < ARRAY_SIZE(dev->mt76.q_rx); i++)
+	mt76_for_each_q_rx(&dev->mt76, i) {
 		mt76_queue_rx_reset(dev, i);
+	}
 
 	mt76x02_mac_start(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index ab20dfde94af..a264e304a3df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1146,8 +1146,9 @@ mt7915_dma_reset(struct mt7915_dev *dev)
 	for (i = 0; i < __MT_TXQ_MAX; i++)
 		mt76_queue_tx_cleanup(dev, i, true);
 
-	for (i = 0; i < ARRAY_SIZE(dev->mt76.q_rx); i++)
+	mt76_for_each_q_rx(&dev->mt76, i) {
 		mt76_queue_rx_reset(dev, i);
+	}
 
 	/* re-init prefetch settings after reset */
 	mt7915_dma_prefetch(dev);
-- 
2.24.0

