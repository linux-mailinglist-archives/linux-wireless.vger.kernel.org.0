Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF63E2E6F4
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 23:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfE2VCS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 17:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfE2VCS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 17:02:18 -0400
Received: from lore-desk.lan (unknown [151.66.7.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F04EA241C8;
        Wed, 29 May 2019 21:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559163737;
        bh=gmqkPtICtyUU7QKcNr6dY2pR4PCmYI/iQLKU6Y/Tr/s=;
        h=From:To:Cc:Subject:Date:From;
        b=eSr+7YuqeqcOcuZ+2RrDREUxlPD+qeNDhN3ZVPFgloYmea+rla+oOQ7On5TfgnFMw
         VRZa2o9GUZWaUwKWka9jtgJF5uDOKaqFzeioCVDgtz3V28Eocv/o2z9CtTMwtlrQLy
         K+qgMJCZPlr+PDtIukJq2vwTskQxMOwMUEbDQpDA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, sgruszka@redhat.com
Subject: [PATCH wireless-drivers] mt76: usb: fix buffer allocation for scatter-gather capable devices
Date:   Wed, 29 May 2019 23:01:49 +0200
Message-Id: <f1f5b9f564e374174a9a2bbae29f4b72fd4c6ddd.1559163190.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Partially revert commit f8f527b16db5 ("mt76: usb: use EP max packet
aligned buffer sizes for rx") since it breaks A-MSDU support.
When A-MSDU is enable the device can receive frames up to
q->buf_size but they will be discarded in mt76u_process_rx_entry
since there is no enough room for skb_shared_info.
Fix it by introducing q->data_size and take info account
skb_shared_info size in q->buf_size
Moreover increase buffer size even for legacy mode (scatter-gather not
available)

Fixes: f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer sizes for rx")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h |  4 ++++
 drivers/net/wireless/mediatek/mt76/usb.c  | 26 ++++++++++++-----------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8ecbf81a906f..f118919ca5ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -31,6 +31,9 @@
 #define MT_MCU_RING_SIZE    32
 #define MT_RX_BUF_SIZE      2048
 
+#define MT_BUF_WITH_OVERHEAD(x) \
+	((x) + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+
 struct mt76_dev;
 struct mt76_wcid;
 
@@ -124,6 +127,7 @@ struct mt76_queue {
 	u16 tail;
 	int ndesc;
 	int queued;
+	int data_size;
 	int buf_size;
 	bool stopped;
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index bbaa1365bbda..9e328e4532b3 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -299,7 +299,7 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
 
 		page = virt_to_head_page(data);
 		offset = data - page_address(page);
-		sg_set_page(&urb->sg[i], page, q->buf_size, offset);
+		sg_set_page(&urb->sg[i], page, q->data_size, offset);
 	}
 
 	if (i < nsgs) {
@@ -311,7 +311,7 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
 	}
 
 	urb->num_sgs = max_t(int, i, urb->num_sgs);
-	urb->transfer_buffer_length = urb->num_sgs * q->buf_size,
+	urb->transfer_buffer_length = urb->num_sgs * q->data_size;
 	sg_init_marker(urb->sg, urb->num_sgs);
 
 	return i ? : -ENOMEM;
@@ -322,14 +322,13 @@ mt76u_refill_rx(struct mt76_dev *dev, struct urb *urb, int nsgs, gfp_t gfp)
 {
 	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
 
-	if (dev->usb.sg_en) {
+	if (dev->usb.sg_en)
 		return mt76u_fill_rx_sg(dev, q, urb, nsgs, gfp);
-	} else {
-		urb->transfer_buffer_length = q->buf_size;
-		urb->transfer_buffer = page_frag_alloc(&q->rx_page,
-						       q->buf_size, gfp);
-		return urb->transfer_buffer ? 0 : -ENOMEM;
-	}
+
+	urb->transfer_buffer_length = q->data_size;
+	urb->transfer_buffer = page_frag_alloc(&q->rx_page, q->buf_size, gfp);
+
+	return urb->transfer_buffer ? 0 : -ENOMEM;
 }
 
 static int
@@ -446,8 +445,9 @@ mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb)
 		return 0;
 
 	data_len = min_t(int, len, data_len - MT_DMA_HDR_LEN);
-	if (MT_DMA_HDR_LEN + data_len > SKB_WITH_OVERHEAD(q->buf_size)) {
-		dev_err_ratelimited(dev->dev, "rx data too big %d\n", data_len);
+	if (MT_DMA_HDR_LEN + data_len > q->data_size) {
+		dev_err_ratelimited(dev->dev, "rx data too big %d\n",
+				    data_len);
 		return 0;
 	}
 
@@ -577,8 +577,10 @@ static int mt76u_alloc_rx(struct mt76_dev *dev)
 	if (!q->entry)
 		return -ENOMEM;
 
-	q->buf_size = dev->usb.sg_en ? MT_RX_BUF_SIZE : PAGE_SIZE;
+	q->data_size = dev->usb.sg_en ? MT_RX_BUF_SIZE : PAGE_SIZE;
+	q->buf_size = MT_BUF_WITH_OVERHEAD(q->data_size);
 	q->ndesc = MT_NUM_RX_ENTRIES;
+
 	for (i = 0; i < q->ndesc; i++) {
 		err = mt76u_rx_urb_alloc(dev, &q->entry[i]);
 		if (err < 0)
-- 
2.21.0

