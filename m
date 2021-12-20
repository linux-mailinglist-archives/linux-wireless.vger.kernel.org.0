Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD94D47A387
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 03:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbhLTCSS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 21:18:18 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:51012 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233055AbhLTCSR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 21:18:17 -0500
X-UUID: c6244f10b21f4d718a67c5ccbec60114-20211220
X-UUID: c6244f10b21f4d718a67c5ccbec60114-20211220
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 559846977; Mon, 20 Dec 2021 10:18:13 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 20 Dec 2021 10:18:13 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 20 Dec
 2021 10:18:11 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 20 Dec 2021 10:18:10 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH v4 03/12] mt76: add MT_RXQ_MAIN_WA for mt7916
Date:   Mon, 20 Dec 2021 10:17:55 +0800
Message-ID: <3803cda3a2f56ca97aeba78e957184b8a5f7c047.1639965732.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1639965732.git.Bo.Jiao@mediatek.com>
References: <cover.1639965732.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

mt7916 add MT_RXQ_MAIN_WA to receive tx free event separately
This is an intermediate patch to add mt7916 support.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
v2:
- revert the modify to mt76_for_each_q_rx() which may cause
  not work for sdo/usb chip.
v4:
- use separate patch for the mt76 core changes.
---
 drivers/net/wireless/mediatek/mt76/dma.c  | 13 +++++++++++--
 drivers/net/wireless/mediatek/mt76/mt76.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 3a9af89..fd4c51b 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -93,7 +93,7 @@ mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	int i;
 
-	if (!q)
+	if (!q || !q->ndesc)
 		return;
 
 	/* clear descriptors */
@@ -233,7 +233,7 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 	struct mt76_queue_entry entry;
 	int last;
 
-	if (!q)
+	if (!q || !q->ndesc)
 		return;
 
 	spin_lock_bh(&q->cleanup_lock);
@@ -448,6 +448,9 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 	int len = SKB_WITH_OVERHEAD(q->buf_size);
 	int offset = q->buf_offset;
 
+	if (!q->ndesc)
+		return 0;
+
 	spin_lock_bh(&q->lock);
 
 	while (q->queued < q->ndesc - 1) {
@@ -484,6 +487,9 @@ mt76_dma_rx_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
 	void *buf;
 	bool more;
 
+	if (!q->ndesc)
+		return;
+
 	spin_lock_bh(&q->lock);
 	do {
 		buf = mt76_dma_dequeue(dev, q, true, NULL, NULL, &more);
@@ -508,6 +514,9 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 	struct mt76_queue *q = &dev->q_rx[qid];
 	int i;
 
+	if (!q->ndesc)
+		return;
+
 	for (i = 0; i < q->ndesc; i++)
 		q->desc[i].ctrl = cpu_to_le32(MT_DMA_CTL_DMA_DONE);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 404c3d1..29bc381 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -85,6 +85,7 @@ enum mt76_rxq_id {
 	MT_RXQ_MCU_WA,
 	MT_RXQ_EXT,
 	MT_RXQ_EXT_WA,
+	MT_RXQ_MAIN_WA,
 	__MT_RXQ_MAX
 };
 
-- 
2.18.0

