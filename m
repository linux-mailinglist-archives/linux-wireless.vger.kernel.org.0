Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2B113BDDC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 11:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgAOK7f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 05:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgAOK7f (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 05:59:35 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7EA624671;
        Wed, 15 Jan 2020 10:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579085974;
        bh=eTP0cNTlgghXQYtziJHC9oVPWWCpODGFhG/XClkdOWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4xmbLbu7RdOl7b983wMlCaR+9wCm1ad9sXF/TL2TLVxfUvfFjYEVaWednlBPh4iL
         q04MnNSxWkbNBOQisxcNY7e9i/yw+6vjFNyu1lUhAyt9RopR/1tOTZf8m+dDoT+osD
         hUk8aWBub4izuB0e/zkGAqEYAsdHiKUmIkxyPE1A=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v3 02/18] mt76: mt76u: add mt76u_process_rx_queue utility routine
Date:   Wed, 15 Jan 2020 11:58:42 +0100
Message-Id: <aaba46a7277cb271f7bad365abaddc5a31a08ca0.1579085367.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1579085367.git.lorenzo@kernel.org>
References: <cover.1579085367.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76u_process_rx_queue routine to process rx hw queue.
This is a preliminary patch to support new devices (e.g. mt7663u) that
rely on a hw queue for mcu messages

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 30 +++++++++++++++---------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index fbc4c0bb0102..9b0a4104ec0e 100644
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
2.21.1

