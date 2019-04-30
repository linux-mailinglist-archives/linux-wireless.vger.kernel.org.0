Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 683F0F1D5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 10:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfD3IK4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 04:10:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfD3IK4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 04:10:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60585308622F;
        Tue, 30 Apr 2019 08:10:56 +0000 (UTC)
Received: from localhost (unknown [10.43.2.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B90717A5FF;
        Tue, 30 Apr 2019 08:10:51 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: [PATCH v2] mt76: usb: use EP max packet aligned buffer sizes for rx
Date:   Tue, 30 Apr 2019 10:10:49 +0200
Message-Id: <20190430081049.9977-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 30 Apr 2019 08:10:56 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If buffer size is not usb_endpoint_maxp (512 or 1024 bytes) multiple,
usb host driver has to use bounce buffer and copy data. For RX we can
avoid that since we alreay allocate q->buf_size (2kB) buffers and
mt76usb hardware will not fill more data as rx packet size is limited
by network protocol. However add error message if this assumption
somehow will be not true.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
v2: use dev_err_ratelimited

 drivers/net/wireless/mediatek/mt76/usb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index c299c6591072..bbaa1365bbda 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -286,7 +286,6 @@ static int
 mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
 		 int nsgs, gfp_t gfp)
 {
-	int sglen = SKB_WITH_OVERHEAD(q->buf_size);
 	int i;
 
 	for (i = 0; i < nsgs; i++) {
@@ -300,7 +299,7 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
 
 		page = virt_to_head_page(data);
 		offset = data - page_address(page);
-		sg_set_page(&urb->sg[i], page, sglen, offset);
+		sg_set_page(&urb->sg[i], page, q->buf_size, offset);
 	}
 
 	if (i < nsgs) {
@@ -312,7 +311,7 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
 	}
 
 	urb->num_sgs = max_t(int, i, urb->num_sgs);
-	urb->transfer_buffer_length = urb->num_sgs * sglen,
+	urb->transfer_buffer_length = urb->num_sgs * q->buf_size,
 	sg_init_marker(urb->sg, urb->num_sgs);
 
 	return i ? : -ENOMEM;
@@ -326,7 +325,7 @@ mt76u_refill_rx(struct mt76_dev *dev, struct urb *urb, int nsgs, gfp_t gfp)
 	if (dev->usb.sg_en) {
 		return mt76u_fill_rx_sg(dev, q, urb, nsgs, gfp);
 	} else {
-		urb->transfer_buffer_length = SKB_WITH_OVERHEAD(q->buf_size);
+		urb->transfer_buffer_length = q->buf_size;
 		urb->transfer_buffer = page_frag_alloc(&q->rx_page,
 						       q->buf_size, gfp);
 		return urb->transfer_buffer ? 0 : -ENOMEM;
@@ -447,8 +446,10 @@ mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb)
 		return 0;
 
 	data_len = min_t(int, len, data_len - MT_DMA_HDR_LEN);
-	if (MT_DMA_HDR_LEN + data_len > SKB_WITH_OVERHEAD(q->buf_size))
+	if (MT_DMA_HDR_LEN + data_len > SKB_WITH_OVERHEAD(q->buf_size)) {
+		dev_err_ratelimited(dev->dev, "rx data too big %d\n", data_len);
 		return 0;
+	}
 
 	skb = build_skb(data, q->buf_size);
 	if (!skb)
-- 
2.20.1

