Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87912AE3D0
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 00:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbgKJXDQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 18:03:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730254AbgKJXDQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 18:03:16 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D353020781;
        Tue, 10 Nov 2020 23:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605049396;
        bh=pcgvpl/fYziMjSJsSzAEy+KqImxcD5yVRG1orWVhrXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnyVIWeVtZVakC/5SU/gIlfaLJPpiQ9CPFDRKiOp9WAJH9HISpRu8Wgr85RrDewtE
         wGIL7rsIYI3cGZ4ehz+JR5MMgJIE+NEiYG25VJP7Cxg45Ny2WGWiCUBam43rdeYZ/I
         uwXx6fOL7r60eLzo8/Io+XlCQDr9NZHG3WIcmWvw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 02/10] mt76: sdio: introduce mt76s_alloc_tx_queue
Date:   Wed, 11 Nov 2020 00:02:52 +0100
Message-Id: <fc15ab80ed66bbec9c79602654b93e3ddbc8d441.1605048763.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605048763.git.lorenzo@kernel.org>
References: <cover.1605048763.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to move hw data queues in mt76_phy for
mt7915 dbdc support

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/sdio.c | 44 ++++++++++++++++-------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index b4def262e1a0..4c6a65cec318 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -36,28 +36,46 @@ mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
 	return 0;
 }
 
+static struct mt76_queue *mt76s_alloc_tx_queue(struct mt76_dev *dev)
+{
+	struct mt76_queue *q;
+
+	q = devm_kzalloc(dev->dev, sizeof(*q), GFP_KERNEL);
+	if (!q)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&q->lock);
+	q->entry = devm_kcalloc(dev->dev,
+				MT_NUM_TX_ENTRIES, sizeof(*q->entry),
+				GFP_KERNEL);
+	if (!q->entry)
+		return ERR_PTR(-ENOMEM);
+
+	q->ndesc = MT_NUM_TX_ENTRIES;
+
+	return q;
+}
+
 static int mt76s_alloc_tx(struct mt76_dev *dev)
 {
 	struct mt76_queue *q;
 	int i;
 
-	for (i = 0; i < MT_TXQ_MCU_WA; i++) {
-		q = devm_kzalloc(dev->dev, sizeof(*q), GFP_KERNEL);
-		if (!q)
-			return -ENOMEM;
+	for (i = 0; i <= MT_TXQ_PSD; i++) {
+		q = mt76s_alloc_tx_queue(dev);
+		if (IS_ERR(q))
+			return PTR_ERR(q);
 
-		spin_lock_init(&q->lock);
-		q->hw_idx = i;
+		q->qid = i;
 		dev->q_tx[i] = q;
+	}
 
-		q->entry = devm_kcalloc(dev->dev,
-					MT_NUM_TX_ENTRIES, sizeof(*q->entry),
-					GFP_KERNEL);
-		if (!q->entry)
-			return -ENOMEM;
+	q = mt76s_alloc_tx_queue(dev);
+	if (IS_ERR(q))
+		return PTR_ERR(q);
 
-		q->ndesc = MT_NUM_TX_ENTRIES;
-	}
+	q->qid = MT_TXQ_MCU;
+	dev->q_tx[MT_TXQ_MCU] = q;
 
 	return 0;
 }
-- 
2.26.2

