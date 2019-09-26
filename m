Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D5CBF7DA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 19:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfIZRri (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 13:47:38 -0400
Received: from nbd.name ([46.4.11.11]:55258 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbfIZRrg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Y//Qehg6tabJKw1viHh72vqTTZssnjWRqNxT3cFfin8=; b=IHPRCKDAwyLs8mBYsQ0v37arve
        hkppeUMoDuYj2CQlDHyF6ZdIZ0/qOjVy8SS5MbuIip6MJRskvMHsyX9qRxfCzMB8wjQAhjPjnTgIB
        Igyh6Imr54nJh5LqblB6YDCWCvoDqdf76r3DkDog5Jn0B5f+qlWdFeeG98OYgzEBTz3w=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDXra-0000yv-Hm
        for linux-wireless@vger.kernel.org; Thu, 26 Sep 2019 19:47:34 +0200
Received: by maeck.local (Postfix, from userid 501)
        id B770069B6A8B; Thu, 26 Sep 2019 19:47:32 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 03/15] mt76: rename mt76_driver_ops txwi_flags to drv_flags and include tx aligned4
Date:   Thu, 26 Sep 2019 19:47:20 +0200
Message-Id: <20190926174732.42375-3-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190926174732.42375-1-nbd@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reduces the struct size and is useful for adding more flags later

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c        | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76.h       | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index c747eb24581c..e2ce59b260c1 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -164,7 +164,7 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, enum mt76_txq_id qid, bool flush)
 			dev->drv->tx_complete_skb(dev, qid, &entry);
 
 		if (entry.txwi) {
-			if (!(dev->drv->txwi_flags & MT_TXWI_NO_FREE))
+			if (!(dev->drv->drv_flags & MT_DRV_TXWI_NO_FREE))
 				mt76_put_txwi(dev, entry.txwi);
 			wake = !flush;
 		}
@@ -299,7 +299,7 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 	txwi = mt76_get_txwi_ptr(dev, t);
 
 	skb->prev = skb->next = NULL;
-	if (dev->drv->tx_aligned4_skbs)
+	if (dev->drv->drv_flags & MT_DRV_TX_ALIGNED4_SKBS)
 		mt76_insert_hdr_pad(skb);
 
 	len = skb_headlen(skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 173d158d7018..af71773c2d55 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -279,11 +279,11 @@ struct mt76_hw_cap {
 	bool has_5ghz;
 };
 
-#define MT_TXWI_NO_FREE			BIT(0)
+#define MT_DRV_TXWI_NO_FREE		BIT(0)
+#define MT_DRV_TX_ALIGNED4_SKBS		BIT(1)
 
 struct mt76_driver_ops {
-	bool tx_aligned4_skbs;
-	u32 txwi_flags;
+	u32 drv_flags;
 	u16 txwi_size;
 
 	void (*update_survey)(struct mt76_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index e250607e0a80..73744563a573 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -72,7 +72,7 @@ static int mt7615_pci_probe(struct pci_dev *pdev,
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
 		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7615_txp),
-		.txwi_flags = MT_TXWI_NO_FREE,
+		.drv_flags = MT_DRV_TXWI_NO_FREE,
 		.tx_prepare_skb = mt7615_tx_prepare_skb,
 		.tx_complete_skb = mt7615_tx_complete_skb,
 		.rx_skb = mt7615_queue_rx_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index 7705e55aa3d1..d20fd40418a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -155,7 +155,7 @@ mt76x0e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static const struct mt76_driver_ops drv_ops = {
 		.txwi_size = sizeof(struct mt76x02_txwi),
-		.tx_aligned4_skbs = true,
+		.drv_flags = MT_DRV_TX_ALIGNED4_SKBS,
 		.update_survey = mt76x02_update_channel,
 		.tx_prepare_skb = mt76x02_tx_prepare_skb,
 		.tx_complete_skb = mt76x02_tx_complete_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
index 73c3104f8858..f7a1f82d8320 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
@@ -21,7 +21,7 @@ mt76pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static const struct mt76_driver_ops drv_ops = {
 		.txwi_size = sizeof(struct mt76x02_txwi),
-		.tx_aligned4_skbs = true,
+		.drv_flags = MT_DRV_TX_ALIGNED4_SKBS,
 		.update_survey = mt76x02_update_channel,
 		.tx_prepare_skb = mt76x02_tx_prepare_skb,
 		.tx_complete_skb = mt76x02_tx_complete_skb,
-- 
2.17.0

