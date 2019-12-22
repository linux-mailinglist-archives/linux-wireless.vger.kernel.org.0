Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D53F128D5F
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 11:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfLVKdm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 05:33:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLVKdl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 05:33:41 -0500
Received: from lore-desk-wlan.lan (unknown [151.66.53.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC1B720733;
        Sun, 22 Dec 2019 10:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577010821;
        bh=ioy6uSes9LU2GeKdSF1qGMnNNor5pPoyv/GX4bupgi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qEgKV3e7tpHHpwnqpE5kA7iSU/GAUO5vy8BCggFWNsjwYXk5+zVNPEb3d+MCdEaP6
         2qI/yI28JGf/fF2Dc3+vBJg3RROZkFnFoUGThR5Pw1Q4AXVvx9EwhJ1Et9qhcubOEC
         6uDcaavl3Nmq2Of5EANi2n8ChZbdriPNIfP5GroU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH 02/18] mt76: mt76u: add mt76u_process_rx_queue utility routine
Date:   Sun, 22 Dec 2019 11:33:04 +0100
Message-Id: <fa3ed629cc09999628cf53cf92477590a6dd0f46.1577010183.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577010183.git.lorenzo@kernel.org>
References: <cover.1577010183.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76u_process_rx_queue routine to process rx hw queue.
This is a preliminary patch to support new devices (e.g. mt7663u) that
rely on a hw queue for mcu messages

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 30 +++++++++++++++---------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 5d71a4b2728d..24f8178c9386 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -468,9 +468,9 @@ mt76u_build_rx_skb(void *data, int len, int buf_size)
 }
 
 static int
-mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb)
+mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb,
+		       int buf_size)
 {
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
 	u8 *data = urb->num_sgs ? sg_virt(&urb->sg[0]) : urb->transfer_buffer;
 	int data_len = urb->num_sgs ? urb->sg[0].length : urb->actual_length;
 	int len, nsgs = 1;
@@ -484,7 +484,7 @@ mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb)
 		return 0;
 
 	data_len = min_t(int, len, data_len - MT_DMA_HDR_LEN);
-	skb = mt76u_build_rx_skb(data, data_len, q->buf_size);
+	skb = mt76u_build_rx_skb(data, data_len, buf_size);
 	if (!skb)
 		return 0;
 
@@ -493,8 +493,8 @@ mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb)
 		data_len = min_t(int, len, urb->sg[nsgs].length);
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 				sg_page(&urb->sg[nsgs]),
-				urb->sg[nsgs].offset,
-				data_len, q->buf_size);
+				urb->sg[nsgs].offset, data_len,
+				buf_size);
 		len -= data_len;
 		nsgs++;
 	}
@@ -545,20 +545,19 @@ mt76u_submit_rx_buf(struct mt76_dev *dev, struct urb *urb)
 	return usb_submit_urb(urb, GFP_ATOMIC);
 }
 
-static void mt76u_rx_tasklet(unsigned long data)
+static void
+mt76u_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	struct mt76_dev *dev = (struct mt76_dev *)data;
+	int qid = q - &dev->q_rx[MT_RXQ_MAIN];
 	struct urb *urb;
 	int err, count;
 
-	rcu_read_lock();
-
 	while (true) {
 		urb = mt76u_get_next_rx_entry(dev);
 		if (!urb)
 			break;
 
-		count = mt76u_process_rx_entry(dev, urb);
+		count = mt76u_process_rx_entry(dev, urb, q->buf_size);
 		if (count > 0) {
 			err = mt76u_refill_rx(dev, urb, count, GFP_ATOMIC);
 			if (err < 0)
@@ -566,8 +565,17 @@ static void mt76u_rx_tasklet(unsigned long data)
 		}
 		mt76u_submit_rx_buf(dev, urb);
 	}
-	mt76_rx_poll_complete(dev, MT_RXQ_MAIN, NULL);
+	if (qid == MT_RXQ_MAIN)
+		mt76_rx_poll_complete(dev, MT_RXQ_MAIN, NULL);
+}
 
+static void mt76u_rx_tasklet(unsigned long data)
+{
+	struct mt76_dev *dev = (struct mt76_dev *)data;
+	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
+
+	rcu_read_lock();
+	mt76u_process_rx_queue(dev, q);
 	rcu_read_unlock();
 }
 
-- 
2.24.1

