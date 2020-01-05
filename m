Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58F7D1307E1
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2020 13:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgAEMWl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Jan 2020 07:22:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgAEMWl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Jan 2020 07:22:41 -0500
Received: from new-host-5.station (net-2-42-61-77.cust.vodafonedsl.it [2.42.61.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65453215A4;
        Sun,  5 Jan 2020 12:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578226959;
        bh=aelira7b9zEQiju9PVPk3DnHxbR1mw+Sj96KyayHPNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HpglUg/yA5KbzmP6MiQoy1gpPiTKkEuDapraVZSehoJgHuKJglNgSedd7YXH9XatG
         yYW50Xy4EE5dgDQME/QWZZHlMfBWSBeP8o1mN0nC/JZ2QtXlAdsOTfU2KNUJVngb4X
         8Ur7CrtlIDaf5yf5xUJzyIFveu2pqqlvfFjLSRFQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v2 02/18] mt76: mt76u: add mt76u_process_rx_queue utility routine
Date:   Sun,  5 Jan 2020 13:21:40 +0100
Message-Id: <c92912e76ffb5f16a809ebb6703e4aec57c4adf8.1578226544.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1578226544.git.lorenzo@kernel.org>
References: <cover.1578226544.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76u_process_rx_queue routine to process rx hw queue.
This is a preliminary patch to support new devices (e.g. mt7663u) that
rely on a hw queue for mcu messages

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

