Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E47647047
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 16:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfFOODm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jun 2019 10:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfFOODm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jun 2019 10:03:42 -0400
Received: from localhost.localdomain (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 558B921473;
        Sat, 15 Jun 2019 14:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560607420;
        bh=+o2JCYWCPKeptBk5RD6WN4/eRjLbYjoPthZU7Ycf3eg=;
        h=From:To:Cc:Subject:Date:From;
        b=znjpRaJLI5D8xHafWAgjVBAQ8yvoieUh686284J1Jv1cKw/o7uc5imCcQurUtFtYs
         l4vr8I2uYdI6FtQoGlv1Qi2kQnN6JX409yimnn4siHYlpdZb01rJUyMtYu3ggfBjfM
         KcWYfZ3ISmz4vc0Tnt3HCNdPsJMiAZsjkElriT9k=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, sgruszka@redhat.com
Subject: [PATCH v4 wireless-drivers] mt76: usb: fix rx A-MSDU support
Date:   Sat, 15 Jun 2019 16:03:32 +0200
Message-Id: <7d93cba766b5a0220c86fa900f9d29048d67e02c.1560607085.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
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
the remaining part

Fixes: f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer sizes for rx")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v3:
- drop patch 2/3 and 3/3

Changes since v2:
- simplify mt76u_build_rx_skb
- add patch 2/3: mt76u: introduce mt76u_ep data structure
- align usb buffer size to usb max endpoint length
- set buf_size to PAGE_SIZE even for sg case

Changes since v1:
- do not allocate multiple page buffers but rely on fragmented skbs
  if there is no enough space to manage the AMSDU rx packets
---
 drivers/net/wireless/mediatek/mt76/mt76.h |  1 +
 drivers/net/wireless/mediatek/mt76/usb.c  | 46 ++++++++++++++++++-----
 2 files changed, 38 insertions(+), 9 deletions(-)

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
index bbaa1365bbda..dd90427b2d67 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -429,6 +429,42 @@ static int mt76u_get_rx_entry_len(u8 *data, u32 data_len)
 	return dma_len;
 }
 
+static struct sk_buff *
+mt76u_build_rx_skb(void *data, int len, int buf_size)
+{
+	struct sk_buff *skb;
+
+	if (SKB_WITH_OVERHEAD(buf_size) < MT_DMA_HDR_LEN + len) {
+		struct page *page;
+
+		/* slow path, not enough space for data and
+		 * skb_shared_info
+		 */
+		skb = alloc_skb(MT_SKB_HEAD_LEN, GFP_ATOMIC);
+		if (!skb)
+			return NULL;
+
+		skb_put_data(skb, data + MT_DMA_HDR_LEN, MT_SKB_HEAD_LEN);
+		data += (MT_DMA_HDR_LEN + MT_SKB_HEAD_LEN);
+		page = virt_to_head_page(data);
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+				page, data - page_address(page),
+				len - MT_SKB_HEAD_LEN, buf_size);
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
@@ -446,19 +482,11 @@ mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb)
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

