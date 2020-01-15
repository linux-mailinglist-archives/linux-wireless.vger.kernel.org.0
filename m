Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2D3B13BDE0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 11:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgAOK7j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 05:59:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:59172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbgAOK7j (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 05:59:39 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F7A424671;
        Wed, 15 Jan 2020 10:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579085979;
        bh=BN7jzF1k0pH3tGkAu8nmP/XtxYstR4CcSZiH0BLPXd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wvUrckF7j+a9Y8jxSi6CQngVmC9mA8zPvOI0Okf64lQwlficZoLlkexQdyLvb6cWt
         hRiro6Nbo1+YiR1b225EAh2R/ggXw0LrJ4h1MRvpbGwonS3LIjhwgur9+aA6KkW/Jm
         wzJeEWU9sZiON8I0RGADqWtCkI8FtGHXmH5ZH/H4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v3 05/18] mt76: mt76u: use mt76_queue as mt76u_complete_rx context
Date:   Wed, 15 Jan 2020 11:58:45 +0100
Message-Id: <f9d400d91baa3672a7d6652bf793cb76093cb294.1579085367.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1579085367.git.lorenzo@kernel.org>
References: <cover.1579085367.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to reuse mt76u_complete_rx for both data and mcu rx queue, rely
on mt76_queue as urb context in mt76u_complete_rx. Moreover set usb rx
endoint according to rx queue in mt76u_submit_rx_buf. This is a
preliminary patch to add mt7663u support

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 65b819f0d18a..88be4d553b70 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -506,8 +506,8 @@ mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb,
 
 static void mt76u_complete_rx(struct urb *urb)
 {
-	struct mt76_dev *dev = urb->context;
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
+	struct mt76_dev *dev = dev_get_drvdata(&urb->dev->dev);
+	struct mt76_queue *q = urb->context;
 	unsigned long flags;
 
 	trace_rx_urb(dev, urb);
@@ -537,10 +537,13 @@ static void mt76u_complete_rx(struct urb *urb)
 }
 
 static int
-mt76u_submit_rx_buf(struct mt76_dev *dev, struct urb *urb)
+mt76u_submit_rx_buf(struct mt76_dev *dev, enum mt76_rxq_id qid,
+		    struct urb *urb)
 {
-	mt76u_fill_bulk_urb(dev, USB_DIR_IN, MT_EP_IN_PKT_RX, urb,
-			    mt76u_complete_rx, dev);
+	int ep = qid == MT_RXQ_MAIN ? MT_EP_IN_PKT_RX : MT_EP_IN_CMD_RESP;
+
+	mt76u_fill_bulk_urb(dev, USB_DIR_IN, ep, urb,
+			    mt76u_complete_rx, &dev->q_rx[qid]);
 	trace_submit_urb(dev, urb);
 
 	return usb_submit_urb(urb, GFP_ATOMIC);
@@ -564,7 +567,7 @@ mt76u_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 			if (err < 0)
 				break;
 		}
-		mt76u_submit_rx_buf(dev, urb);
+		mt76u_submit_rx_buf(dev, qid, urb);
 	}
 	if (qid == MT_RXQ_MAIN)
 		mt76_rx_poll_complete(dev, MT_RXQ_MAIN, NULL);
@@ -588,7 +591,7 @@ static int mt76u_submit_rx_buffers(struct mt76_dev *dev)
 
 	spin_lock_irqsave(&q->lock, flags);
 	for (i = 0; i < q->ndesc; i++) {
-		err = mt76u_submit_rx_buf(dev, q->entry[i].urb);
+		err = mt76u_submit_rx_buf(dev, MT_RXQ_MAIN, q->entry[i].urb);
 		if (err < 0)
 			break;
 	}
-- 
2.21.1

