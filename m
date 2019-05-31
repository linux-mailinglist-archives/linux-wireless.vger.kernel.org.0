Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAEF30BC8
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2019 11:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfEaJjP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 May 2019 05:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfEaJjP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 May 2019 05:39:15 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F014266FF;
        Fri, 31 May 2019 09:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559295554;
        bh=bAbzMFZ0AUjdEkjq7Nay/dtboD7/WSZO3GN3rXEPqoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTrE/MOoOBEzm7mGxME3qSj7iWaDGOBgtRxyayMKkreKnLEJDHFJSJAaBlCxc9c2E
         7kvl13H6Lu/bb5QUCk/IDN+dqgG2t7F+DBeDMjNH0Aqphqj9TaI/l35Pb4rp6ub2Ca
         76T3Rml18Xq+hlQiHph7rHcYfWWIep8WNgL6AEps=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sgruszka@redhat.com
Subject: [PATCH v2 1/2] mt76: usb: fix rx A-MSDU support
Date:   Fri, 31 May 2019 11:38:22 +0200
Message-Id: <52ea155d9889aa15df44b4910806b74fa2fd9056.1559293385.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559293385.git.lorenzo@kernel.org>
References: <cover.1559293385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer sizes
for rx") breaks A-MSDU support. When A-MSDU is enable the device can
receive frames up to q->buf_size but they will be discarded in
mt76u_process_rx_entry since there is no enough room for
skb_shared_info. Fix the issue reallocating the skb and copying in the
linear area the first 128B of the received frames and in the frag_list
the remaining part.

Fixes: f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer sizes for rx")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h |  1 +
 drivers/net/wireless/mediatek/mt76/usb.c  | 52 +++++++++++++++++++----
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 97a1296562d0..74d4edf941d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -30,6 +30,7 @@
 #define MT_TX_RING_SIZE     256
 #define MT_MCU_RING_SIZE    32
 #define MT_RX_BUF_SIZE      2048
+#define MT_SKB_HEAD_LEN     128
 
 struct mt76_dev;
 struct mt76_wcid;
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index bbaa1365bbda..2bfc8214c0d8 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -429,6 +429,48 @@ static int mt76u_get_rx_entry_len(u8 *data, u32 data_len)
 	return dma_len;
 }
 
+static struct sk_buff *
+mt76u_build_rx_skb(u8 *data, int len, int buf_size,
+		   int *nsgs)
+{
+	int data_len = min(len, MT_SKB_HEAD_LEN);
+	struct sk_buff *skb;
+
+	if (SKB_WITH_OVERHEAD(buf_size) >= MT_DMA_HDR_LEN + len) {
+		/* fast path */
+		skb = build_skb(data, buf_size);
+		if (!skb)
+			return NULL;
+
+		skb_reserve(skb, MT_DMA_HDR_LEN);
+		__skb_put(skb, len);
+
+		return skb;
+	}
+
+	/* slow path, not enough space for data and
+	 * skb_shared_info
+	 */
+	skb = alloc_skb(data_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	skb_put_data(skb, data + MT_DMA_HDR_LEN, data_len);
+	data += (data_len + MT_DMA_HDR_LEN);
+	len -= data_len;
+	if (len > 0) {
+		struct page *page = virt_to_head_page(data);
+		int offset = data - (u8 *)page_address(page);
+
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+				page, offset, len, buf_size);
+	} else {
+		*nsgs = 0;
+	}
+
+	return skb;
+}
+
 static int
 mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb)
 {
@@ -446,19 +488,11 @@ mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb)
 		return 0;
 
 	data_len = min_t(int, len, data_len - MT_DMA_HDR_LEN);
-	if (MT_DMA_HDR_LEN + data_len > SKB_WITH_OVERHEAD(q->buf_size)) {
-		dev_err_ratelimited(dev->dev, "rx data too big %d\n", data_len);
-		return 0;
-	}
-
-	skb = build_skb(data, q->buf_size);
+	skb = mt76u_build_rx_skb(data, data_len, q->buf_size, &nsgs);
 	if (!skb)
 		return 0;
 
-	skb_reserve(skb, MT_DMA_HDR_LEN);
-	__skb_put(skb, data_len);
 	len -= data_len;
-
 	while (len > 0 && nsgs < urb->num_sgs) {
 		data_len = min_t(int, len, urb->sg[nsgs].length);
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-- 
2.21.0

