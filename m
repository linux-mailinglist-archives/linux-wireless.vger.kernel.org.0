Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9672CEEB4
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 14:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgLDNSW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 08:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgLDNSW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 08:18:22 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AF4C061A52
        for <linux-wireless@vger.kernel.org>; Fri,  4 Dec 2020 05:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nxdHDwvnog+6liZ8DSPVmI11iuBYNOqeQIAYQIcuZ3A=; b=SQTenh+NH/H0bk9G3+tZ+PxSaN
        FCYRi2bjuMzJTeIHavDvMLUPzo+MZS9gnxaqU3ZWAZt3EuATIX8sJ3hd71rc1QVERY3/x6qM/cVue
        5rJy62AAzhsVbQk8hApzsCn6JrBwjPsuzqocPRLOVJBRy+0UGvw1DbD+wpTjOuZj6wZ8=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1klAxu-00033k-M0
        for linux-wireless@vger.kernel.org; Fri, 04 Dec 2020 14:17:38 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 3/3] mt76: attempt to free up more room when filling the tx queue
Date:   Fri,  4 Dec 2020 14:17:37 +0100
Message-Id: <20201204131737.41086-3-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201204131737.41086-1-nbd@nbd.name>
References: <20201204131737.41086-1-nbd@nbd.name>
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
index 4026e5f4f3f3..1e20afb70fc1 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -448,6 +448,7 @@ static int
 mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 {
 	struct mt76_queue *q = phy->q_tx[qid];
+	struct mt76_dev *dev = phy->dev;
 	struct ieee80211_txq *txq;
 	struct mt76_txq *mtxq;
 	struct mt76_wcid *wcid;
@@ -461,6 +462,13 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 			break;
 		}
 
+		if (dev->queue_ops->tx_cleanup &&
+		    q->queued + 2 * MT_TXQ_FREE_THR >= q->ndesc) {
+			spin_unlock_bh(&q->lock);
+			dev->queue_ops->tx_cleanup(dev, q, false);
+			spin_lock_bh(&q->lock);
+		}
+
 		if (mt76_txq_stopped(q))
 			break;
 
-- 
2.28.0

