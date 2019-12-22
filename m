Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E766E128D68
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 11:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfLVKdz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 05:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:45356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLVKdz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 05:33:55 -0500
Received: from lore-desk-wlan.lan (unknown [151.66.53.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA43E2070A;
        Sun, 22 Dec 2019 10:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577010834;
        bh=M/K5HRa87jNLxi4w7X9C/96dCkrODMBsROCYJNcCt5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsxcJe1BNRY+MOs1g2tV5S86Xlh8UtqL98AGcUCeTzASCheWOnO7hKbg0iT4DQcdS
         2XSGswUHr85FRDws5oZkJ1K1inGakUz1LMPfv8NdH8FkzEyhym8TB0z1igt5sBWDl6
         146vp/5zH4mHcr7xM9mSg6rz8EbezoKjQmEL0CqM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH 11/18] mt76: mt76u: add queue parameter to mt76u_rx_urb_alloc
Date:   Sun, 22 Dec 2019 11:33:13 +0100
Message-Id: <ed325f2b07adc8e479eae545cbaf6adf52f2b586.1577010183.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577010183.git.lorenzo@kernel.org>
References: <cover.1577010183.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add mt76_queue parameter to mt76u_rx_urb_alloc signature since this
routine will be used to allocate urbs for mcu hw queue used by new
chipset generation (e.g. mt7663u). Check sg_max_size in in
mt76u_urb_alloc in order to use linear urb for mcu queue

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 2e6041d5257a..51707f134c6a 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -347,24 +347,25 @@ mt76u_urb_alloc(struct mt76_dev *dev, struct mt76_queue_entry *e,
 
 	usb_init_urb(e->urb);
 
-	if (dev->usb.sg_en)
+	if (dev->usb.sg_en && sg_max_size > 0)
 		e->urb->sg = (struct scatterlist *)(e->urb + 1);
 
 	return 0;
 }
 
 static int
-mt76u_rx_urb_alloc(struct mt76_dev *dev, struct mt76_queue_entry *e)
+mt76u_rx_urb_alloc(struct mt76_dev *dev, struct mt76_queue *q,
+		   struct mt76_queue_entry *e)
 {
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
-	int err;
+	enum mt76_rxq_id qid = q - &dev->q_rx[MT_RXQ_MAIN];
+	int err, sg_size;
 
-	err = mt76u_urb_alloc(dev, e, MT_RX_SG_MAX_SIZE);
+	sg_size = qid == MT_RXQ_MAIN ? MT_RX_SG_MAX_SIZE : 0;
+	err = mt76u_urb_alloc(dev, e, sg_size);
 	if (err)
 		return err;
 
-	return mt76u_refill_rx(dev, q, e->urb, MT_RX_SG_MAX_SIZE,
-			       GFP_KERNEL);
+	return mt76u_refill_rx(dev, q, e->urb, sg_size, GFP_KERNEL);
 }
 
 static void mt76u_urb_free(struct urb *urb)
@@ -620,7 +621,7 @@ mt76u_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
 	q->buf_size = PAGE_SIZE;
 
 	for (i = 0; i < q->ndesc; i++) {
-		err = mt76u_rx_urb_alloc(dev, &q->entry[i]);
+		err = mt76u_rx_urb_alloc(dev, q, &q->entry[i]);
 		if (err < 0)
 			return err;
 	}
-- 
2.24.1

