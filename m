Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784102BC117
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Nov 2020 18:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgKURdd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Nov 2020 12:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbgKURdb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Nov 2020 12:33:31 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE046C061A4B
        for <linux-wireless@vger.kernel.org>; Sat, 21 Nov 2020 09:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fJhDLdqLm1n4t7rok/Khs6ntKvgqO4L3plpHlizfpn0=; b=hSIl+neWdjNe/XmRdQO+GzYUIi
        kQOR1Q8V9owg+WFkA2DGyIJF/GHbvgwp/iaCyfa75c7JgQmlAcPxQIMuLVRbOLa+ekWoNeV9pmPXt
        Vv2r3Jmi/SwL8V4nm50FYvv+jYuqrNN0safbFo22x6uoJav/HL0KAEIphQDBEXs74wsA=;
Received: from p5b206c33.dip0.t-ipconnect.de ([91.32.108.51] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kgWlM-0004bc-EU
        for linux-wireless@vger.kernel.org; Sat, 21 Nov 2020 18:33:28 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] mt76: attempt to free up more room when filling the tx queue
Date:   Sat, 21 Nov 2020 18:33:26 +0100
Message-Id: <20201121173326.88208-3-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201121173326.88208-1-nbd@nbd.name>
References: <20201121173326.88208-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Run dma cleanup immediately if the queue is almost full, instead of waiting
for the tx interrupt

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c  | 3 +++
 drivers/net/wireless/mediatek/mt76/mt76.h | 1 +
 drivers/net/wireless/mediatek/mt76/tx.c   | 8 ++++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 6255f4f0a455..73eeb00d5aa6 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -88,6 +88,7 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	int i;
 
 	spin_lock_init(&q->lock);
+	spin_lock_init(&q->cleanup_lock);
 
 	q->regs = dev->mmio.regs + ring_base + idx * MT_RING_SIZE;
 	q->ndesc = n_desc;
@@ -225,6 +226,7 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 	if (!q)
 		return;
 
+	spin_lock_bh(&q->cleanup_lock);
 	if (flush)
 		last = -1;
 	else
@@ -243,6 +245,7 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 			last = readl(&q->regs->dma_idx);
 
 	}
+	spin_unlock_bh(&q->cleanup_lock);
 
 	if (flush) {
 		spin_lock_bh(&q->lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ea80ae188dd6..3e496a188bf0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -126,6 +126,7 @@ struct mt76_queue {
 	struct mt76_queue_regs __iomem *regs;
 
 	spinlock_t lock;
+	spinlock_t cleanup_lock;
 	struct mt76_queue_entry *entry;
 	struct mt76_desc *desc;
 
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 41dd0a8064cf..234c82023b0c 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -444,6 +444,7 @@ static int
 mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 {
 	struct mt76_queue *q = phy->q_tx[qid];
+	struct mt76_dev *dev = phy->dev;
 	struct ieee80211_txq *txq;
 	struct mt76_txq *mtxq;
 	struct mt76_wcid *wcid;
@@ -460,6 +461,13 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 		if (q->stopped || q->blocked)
 			break;
 
+		if (dev->queue_ops->tx_cleanup &&
+		    q->queued + 2 * MT_TXQ_FREE_THR >= q->ndesc) {
+			spin_unlock_bh(&q->lock);
+			dev->queue_ops->tx_cleanup(dev, q, false);
+			spin_lock_bh(&q->lock);
+		}
+
 		if (q->queued + MT_TXQ_FREE_THR >= q->ndesc)
 			break;
 
-- 
2.28.0

