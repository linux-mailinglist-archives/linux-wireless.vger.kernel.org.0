Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC81128D61
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 11:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfLVKdo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 05:33:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLVKdo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 05:33:44 -0500
Received: from lore-desk-wlan.lan (unknown [151.66.53.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC1012070A;
        Sun, 22 Dec 2019 10:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577010823;
        bh=hmcpKmPntYS8kNgFQL7WdXyKWC+OuqasaL3mWtugnOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wtdg0BKqAU+68IshHr6VLS4YdOB9XHx3BexJN96GyWRAOhPg6xbCHrg6sMWSqo0Hc
         usL5EyfhPeP32J36b8wQNLKRSWVn1qsbUDqILhvq3MGa2y5CVXcTYTW6wxgJM4M5Ud
         qBmkbG3hc8RkQzJFZlAJJc/5oo3dmiERaxvGHlcM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH 04/18] mt76: mt76u: add mt76_queue to mt76u_refill_rx signature
Date:   Sun, 22 Dec 2019 11:33:06 +0100
Message-Id: <0a09659dc6876c09e986d26cd78c94b9d9500aad.1577010183.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577010183.git.lorenzo@kernel.org>
References: <cover.1577010183.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76_queue parameter to mt76u_refill_rx signature in order to
reuse it for mcu hw rx queue

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 705a25c10845..ab99d498b8f8 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -318,11 +318,12 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
 }
 
 static int
-mt76u_refill_rx(struct mt76_dev *dev, struct urb *urb, int nsgs, gfp_t gfp)
+mt76u_refill_rx(struct mt76_dev *dev, struct mt76_queue *q,
+		struct urb *urb, int nsgs, gfp_t gfp)
 {
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
+	enum mt76_rxq_id qid = q - &dev->q_rx[MT_RXQ_MAIN];
 
-	if (dev->usb.sg_en)
+	if (qid == MT_RXQ_MAIN && dev->usb.sg_en)
 		return mt76u_fill_rx_sg(dev, q, urb, nsgs, gfp);
 
 	urb->transfer_buffer_length = q->buf_size;
@@ -355,13 +356,14 @@ mt76u_urb_alloc(struct mt76_dev *dev, struct mt76_queue_entry *e,
 static int
 mt76u_rx_urb_alloc(struct mt76_dev *dev, struct mt76_queue_entry *e)
 {
+	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
 	int err;
 
 	err = mt76u_urb_alloc(dev, e, MT_RX_SG_MAX_SIZE);
 	if (err)
 		return err;
 
-	return mt76u_refill_rx(dev, e->urb, MT_RX_SG_MAX_SIZE,
+	return mt76u_refill_rx(dev, q, e->urb, MT_RX_SG_MAX_SIZE,
 			       GFP_KERNEL);
 }
 
@@ -558,7 +560,7 @@ mt76u_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 
 		count = mt76u_process_rx_entry(dev, urb, q->buf_size);
 		if (count > 0) {
-			err = mt76u_refill_rx(dev, urb, count, GFP_ATOMIC);
+			err = mt76u_refill_rx(dev, q, urb, count, GFP_ATOMIC);
 			if (err < 0)
 				break;
 		}
-- 
2.24.1

