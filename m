Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 007A144EA8
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 23:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfFMVn0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 17:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfFMVn0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 17:43:26 -0400
Received: from localhost.localdomain (unknown [151.66.40.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 235CA21537;
        Thu, 13 Jun 2019 21:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560462205;
        bh=J4V24hOcPkKoGrEdL7kzFBoG1+wxVVHumrN5Kr4ZqwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CGKIdB2gTX1ALF//jrasHiw1D6X5aaGzX8rcoFvi1pWloM7BdpXBpyn9AJFh6ZizA
         ikUjoaeiT7I/7BvYNrn7HsbSj2ktQKgLH6UH1vEqFiWy4gIvM670N2ygEARWk+g6Ld
         XummwUi/i6j+8MfdYKHSVKTlLTa+GzMPMPp6nOd8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, sgruszka@redhat.com
Subject: [PATCH v3 wireless-drivers 1/3] mt76: usb: fix rx A-MSDU support
Date:   Thu, 13 Jun 2019 23:43:11 +0200
Message-Id: <66fc02e45fb5ce0d6176395b5ac43acbd53b3e66.1560461404.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560461404.git.lorenzo@kernel.org>
References: <cover.1560461404.git.lorenzo@kernel.org>
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
 drivers/net/wireless/mediatek/mt76/usb.c  | 49 ++++++++++++++++++-----
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8ecbf81a906f..889b76deb703 100644
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
index bbaa1365bbda..12d60d31cb51 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -429,6 +429,45 @@ static int mt76u_get_rx_entry_len(u8 *data, u32 data_len)
 	return dma_len;
 }
 
+static struct sk_buff *
+mt76u_build_rx_skb(u8 *data, int len, int buf_size)
+{
+	struct sk_buff *skb;
+
+	if (SKB_WITH_OVERHEAD(buf_size) < MT_DMA_HDR_LEN + len) {
+		struct page *page;
+		int offset;
+
+		/* slow path, not enough space for data and
+		 * skb_shared_info
+		 */
+		skb = alloc_skb(MT_SKB_HEAD_LEN, GFP_ATOMIC);
+		if (!skb)
+			return NULL;
+
+		skb_put_data(skb, data + MT_DMA_HDR_LEN, MT_SKB_HEAD_LEN);
+		data += (MT_SKB_HEAD_LEN + MT_DMA_HDR_LEN);
+		page = virt_to_head_page(data);
+		offset = data - (u8 *)page_address(page);
+
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+				page, offset, len - MT_SKB_HEAD_LEN,
+				buf_size);
+
+		return skb;
+	}
+
+	/* fast path */
+	skb = build_skb(data, buf_size);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, MT_DMA_HDR_LEN);
+	__skb_put(skb, len);
+
+	return skb;
+}
+
 static int
 mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb)
 {
@@ -446,19 +485,11 @@ mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb)
 		return 0;
 
 	data_len = min_t(int, len, data_len - MT_DMA_HDR_LEN);
-	if (MT_DMA_HDR_LEN + data_len > SKB_WITH_OVERHEAD(q->buf_size)) {
-		dev_err_ratelimited(dev->dev, "rx data too big %d\n", data_len);
-		return 0;
-	}
-
-	skb = build_skb(data, q->buf_size);
+	skb = mt76u_build_rx_skb(data, data_len, q->buf_size);
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

