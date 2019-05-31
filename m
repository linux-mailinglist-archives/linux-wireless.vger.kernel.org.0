Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6E3830BC9
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2019 11:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEaJj0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 May 2019 05:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfEaJjZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 May 2019 05:39:25 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDC3E266FD;
        Fri, 31 May 2019 09:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559295565;
        bh=nuYyx7BnilCyWILdkj0IGIG3O3W8VBq8qW3kbUvyHtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZI0geNaWdvZi3Eq+rG92kpRxC+ymhcKA4L0HDNNM4HomWQOnx7bHsi7TAhjTwvgW
         km/DgXnf/ykJ6QfH9bymO57JsQ7joTYC2YkxOsYyS2QAfihpTHUajNXrDnW0oCG+s+
         +57s4yHdmQQrqH9knJsY7hNxyC+2iD6sqXbw2TU8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sgruszka@redhat.com
Subject: [PATCH v2 2/2] mt76: usb: do not always copy the first part of received frames
Date:   Fri, 31 May 2019 11:38:23 +0200
Message-Id: <2ed0b595a12944a8cfea14e066bcc4fa24f0ba44.1559293385.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559293385.git.lorenzo@kernel.org>
References: <cover.1559293385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set usb buffer size taking into account skb_shared_info in order to
not always copy the first part of received frames if A-MSDU is enabled
for SG capable devices

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h |  3 +++
 drivers/net/wireless/mediatek/mt76/usb.c  | 12 ++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 74d4edf941d6..7899e9b88b54 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -32,6 +32,9 @@
 #define MT_RX_BUF_SIZE      2048
 #define MT_SKB_HEAD_LEN     128
 
+#define MT_BUF_WITH_OVERHEAD(x) \
+	((x) + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+
 struct mt76_dev;
 struct mt76_wcid;
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 2bfc8214c0d8..5081643ce701 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -286,7 +286,7 @@ static int
 mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
 		 int nsgs, gfp_t gfp)
 {
-	int i;
+	int i, data_size = SKB_WITH_OVERHEAD(q->buf_size);
 
 	for (i = 0; i < nsgs; i++) {
 		struct page *page;
@@ -299,7 +299,7 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
 
 		page = virt_to_head_page(data);
 		offset = data - page_address(page);
-		sg_set_page(&urb->sg[i], page, q->buf_size, offset);
+		sg_set_page(&urb->sg[i], page, data_size, offset);
 	}
 
 	if (i < nsgs) {
@@ -311,7 +311,7 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
 	}
 
 	urb->num_sgs = max_t(int, i, urb->num_sgs);
-	urb->transfer_buffer_length = urb->num_sgs * q->buf_size,
+	urb->transfer_buffer_length = urb->num_sgs * data_size;
 	sg_init_marker(urb->sg, urb->num_sgs);
 
 	return i ? : -ENOMEM;
@@ -611,8 +611,12 @@ static int mt76u_alloc_rx(struct mt76_dev *dev)
 	if (!q->entry)
 		return -ENOMEM;
 
-	q->buf_size = dev->usb.sg_en ? MT_RX_BUF_SIZE : PAGE_SIZE;
+	if (dev->usb.sg_en)
+		q->buf_size = MT_BUF_WITH_OVERHEAD(MT_RX_BUF_SIZE);
+	else
+		q->buf_size = PAGE_SIZE;
 	q->ndesc = MT_NUM_RX_ENTRIES;
+
 	for (i = 0; i < q->ndesc; i++) {
 		err = mt76u_rx_urb_alloc(dev, &q->entry[i]);
 		if (err < 0)
-- 
2.21.0

