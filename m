Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585E11307E5
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2020 13:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgAEMWp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Jan 2020 07:22:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgAEMWp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Jan 2020 07:22:45 -0500
Received: from new-host-5.station (net-2-42-61-77.cust.vodafonedsl.it [2.42.61.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 783E0218AC;
        Sun,  5 Jan 2020 12:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578226964;
        bh=+FBV4HEUZM/1ZGa5lT6XtNRXJQzsqSZOUUgQR6z0o9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v1qNjwGgPYsgKnHrOYcD9ypXDXN5No7Y3L2B14Y4fEVwDRfj8Ia7wKbPcTMDIarXs
         IX2p1oHnj35ki983+uiGjwvjtUWK60S+WqXSqltl00myT9MHVarmVMYkb92ndfXX/L
         1MrGkK3UZNKmyrHvbGAvM8z+5i3ndjfsEq5QLIPo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v2 05/18] mt76: mt76u: use mt76_queue as mt76u_complete_rx context
Date:   Sun,  5 Jan 2020 13:21:43 +0100
Message-Id: <d500654e15cc6acdce9b24282700be13220e0769.1578226544.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1578226544.git.lorenzo@kernel.org>
References: <cover.1578226544.git.lorenzo@kernel.org>
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

