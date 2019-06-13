Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3FBE44EAA
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 23:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfFMVnc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 17:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfFMVnb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 17:43:31 -0400
Received: from localhost.localdomain (unknown [151.66.40.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D7721721;
        Thu, 13 Jun 2019 21:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560462211;
        bh=ptcpDMugFcdloUA9Yi3MZDY0TbSw8V3JklI4gCChYXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpuhdgEuppez/INRCQMFEZpAzeZ+3NJoNafH6tCn543uuYV/aPVYxe9wrK6bRoF2L
         2jolsnDfVV8Fvv9kcSAzf5jXKMqEcdtiuzZRJSTtSzBBMN0aLzU7T1uUzo6/czo8qW
         Y3Wb8at10nOBd5jNCQ/hFyYdBh8q1dNvOO+fRfqI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, sgruszka@redhat.com
Subject: [PATCH v3 wireless-drivers 3/3] mt76: usb: do not always copy the first part of received frames
Date:   Thu, 13 Jun 2019 23:43:13 +0200
Message-Id: <1a9566c0a41ad0d940487a9d3f0008993c075ef2.1560461404.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560461404.git.lorenzo@kernel.org>
References: <cover.1560461404.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set usb buffer size taking into account skb_shared_info in order to
not always copy the first part of received frames if A-MSDU is enabled
for SG capable devices. Moreover align usb buffer size to max_ep
boundaries and set buf_size to PAGE_SIZE even for sg case

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 1ee54a9b302e..2ee3f8fa1483 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -289,8 +289,10 @@ static int
 mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
 		 int nsgs, gfp_t gfp)
 {
-	int i;
+	int i, data_size;
 
+	data_size = rounddown(SKB_WITH_OVERHEAD(q->buf_size),
+			      dev->usb.in_ep[MT_EP_IN_PKT_RX].max_packet);
 	for (i = 0; i < nsgs; i++) {
 		struct page *page;
 		void *data;
@@ -302,7 +304,7 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
 
 		page = virt_to_head_page(data);
 		offset = data - page_address(page);
-		sg_set_page(&urb->sg[i], page, q->buf_size, offset);
+		sg_set_page(&urb->sg[i], page, data_size, offset);
 	}
 
 	if (i < nsgs) {
@@ -314,7 +316,7 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
 	}
 
 	urb->num_sgs = max_t(int, i, urb->num_sgs);
-	urb->transfer_buffer_length = urb->num_sgs * q->buf_size,
+	urb->transfer_buffer_length = urb->num_sgs * data_size;
 	sg_init_marker(urb->sg, urb->num_sgs);
 
 	return i ? : -ENOMEM;
@@ -611,8 +613,9 @@ static int mt76u_alloc_rx(struct mt76_dev *dev)
 	if (!q->entry)
 		return -ENOMEM;
 
-	q->buf_size = dev->usb.sg_en ? MT_RX_BUF_SIZE : PAGE_SIZE;
 	q->ndesc = MT_NUM_RX_ENTRIES;
+	q->buf_size = PAGE_SIZE;
+
 	for (i = 0; i < q->ndesc; i++) {
 		err = mt76u_rx_urb_alloc(dev, &q->entry[i]);
 		if (err < 0)
-- 
2.21.0

