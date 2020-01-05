Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC6DB1307E3
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2020 13:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgAEMWo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Jan 2020 07:22:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:46944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgAEMWn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Jan 2020 07:22:43 -0500
Received: from new-host-5.station (net-2-42-61-77.cust.vodafonedsl.it [2.42.61.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4AA8215A4;
        Sun,  5 Jan 2020 12:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578226963;
        bh=D1vmSmOvBpph5gWc+Ol2X4qyXZ/bV3ON/REHNMqow58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ujaVqXmM3E+5XJ82HD+o0GDBhSAu1lSMaylWliSH9pRUrx+i9xMx3Ss0aWHVarcF9
         pxIV6l1kSq/TsgjqZT2tuvEunw8Jh/uYEMtxO4h8CUKPo0A1MzMM7i+XubyCbdHhZA
         r2uQ4z/oFPgRPfGUO5LfO81WF0KYirE5Xil4YH48=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v2 04/18] mt76: mt76u: add mt76_queue to mt76u_refill_rx signature
Date:   Sun,  5 Jan 2020 13:21:42 +0100
Message-Id: <98472266869681f6d9cef56a1814a4350d1d25d9.1578226544.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1578226544.git.lorenzo@kernel.org>
References: <cover.1578226544.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76_queue parameter to mt76u_refill_rx signature in order to
reuse it for mcu hw rx queue

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 23973ec6c92c..65b819f0d18a 100644
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
2.21.1

