Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72F6E1307F3
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2020 13:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgAEMXI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Jan 2020 07:23:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgAEMXI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Jan 2020 07:23:08 -0500
Received: from new-host-5.station (net-2-42-61-77.cust.vodafonedsl.it [2.42.61.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86797217F4;
        Sun,  5 Jan 2020 12:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578226987;
        bh=2wkttU5VvjZfagmMP91pcWkNKGIZo3GmhxT0z318yTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtAYLhJCIY/Gn5yDiwr8ZSeu0YHMK4SZ2LNJ5qgtc0D/uTbjL73qJckDB8l1LZI6G
         s5XP1niVPZkhHuQCh9GbW9V4pUIFeElj1lOdKLOqb3j7Gjl8FVzWtr4N4dnUUAhHTg
         d4kB7zmOAxoUTFKO3b5hA8jnN9DD5+rkYOT4r30A=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v2 18/18] mt76: mt76u: introduce MT_DRV_RX_DMA_HDR flag
Date:   Sun,  5 Jan 2020 13:21:56 +0100
Message-Id: <df482f4b2b50263b6243a78758546e628a4b0ff1.1578226544.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1578226544.git.lorenzo@kernel.org>
References: <cover.1578226544.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Define MT_DRV_RX_DMA_HDR flag in drv_flag in order to not skip rx frame
dma header since new devices (e.g. mt7663u) reports rx frame info in the
usb dma header

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h |  1 +
 drivers/net/wireless/mediatek/mt76/usb.c  | 31 ++++++++++++++---------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e7b86712f574..aa153c7a28e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -286,6 +286,7 @@ struct mt76_hw_cap {
 #define MT_DRV_TXWI_NO_FREE		BIT(0)
 #define MT_DRV_TX_ALIGNED4_SKBS		BIT(1)
 #define MT_DRV_SW_RX_AIRTIME		BIT(2)
+#define MT_DRV_RX_DMA_HDR		BIT(3)
 
 struct mt76_driver_ops {
 	u32 drv_flags;
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 57d2590165e3..981d8a985557 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -506,14 +506,17 @@ mt76u_get_next_rx_entry(struct mt76_queue *q)
 	return urb;
 }
 
-static int mt76u_get_rx_entry_len(u8 *data, u32 data_len)
+static int
+mt76u_get_rx_entry_len(struct mt76_dev *dev, u8 *data,
+		       u32 data_len)
 {
 	u16 dma_len, min_len;
 
 	dma_len = get_unaligned_le16(data);
-	min_len = MT_DMA_HDR_LEN + MT_RX_RXWI_LEN +
-		  MT_FCE_INFO_LEN;
+	if (dev->drv->drv_flags & MT_DRV_RX_DMA_HDR)
+		return dma_len;
 
+	min_len = MT_DMA_HDR_LEN + MT_RX_RXWI_LEN + MT_FCE_INFO_LEN;
 	if (data_len < min_len || !dma_len ||
 	    dma_len + MT_DMA_HDR_LEN > data_len ||
 	    (dma_len & 0x3))
@@ -522,11 +525,14 @@ static int mt76u_get_rx_entry_len(u8 *data, u32 data_len)
 }
 
 static struct sk_buff *
-mt76u_build_rx_skb(void *data, int len, int buf_size)
+mt76u_build_rx_skb(struct mt76_dev *dev, void *data,
+		   int len, int buf_size)
 {
+	int head_room, drv_flags = dev->drv->drv_flags;
 	struct sk_buff *skb;
 
-	if (SKB_WITH_OVERHEAD(buf_size) < MT_DMA_HDR_LEN + len) {
+	head_room = drv_flags & MT_DRV_RX_DMA_HDR ? 0 : MT_DMA_HDR_LEN;
+	if (SKB_WITH_OVERHEAD(buf_size) < head_room + len) {
 		struct page *page;
 
 		/* slow path, not enough space for data and
@@ -536,8 +542,8 @@ mt76u_build_rx_skb(void *data, int len, int buf_size)
 		if (!skb)
 			return NULL;
 
-		skb_put_data(skb, data + MT_DMA_HDR_LEN, MT_SKB_HEAD_LEN);
-		data += (MT_DMA_HDR_LEN + MT_SKB_HEAD_LEN);
+		skb_put_data(skb, data + head_room, MT_SKB_HEAD_LEN);
+		data += head_room + MT_SKB_HEAD_LEN;
 		page = virt_to_head_page(data);
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 				page, data - page_address(page),
@@ -551,7 +557,7 @@ mt76u_build_rx_skb(void *data, int len, int buf_size)
 	if (!skb)
 		return NULL;
 
-	skb_reserve(skb, MT_DMA_HDR_LEN);
+	skb_reserve(skb, head_room);
 	__skb_put(skb, len);
 
 	return skb;
@@ -563,18 +569,19 @@ mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb,
 {
 	u8 *data = urb->num_sgs ? sg_virt(&urb->sg[0]) : urb->transfer_buffer;
 	int data_len = urb->num_sgs ? urb->sg[0].length : urb->actual_length;
-	int len, nsgs = 1;
+	int len, nsgs = 1, head_room, drv_flags = dev->drv->drv_flags;
 	struct sk_buff *skb;
 
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->phy.state))
 		return 0;
 
-	len = mt76u_get_rx_entry_len(data, urb->actual_length);
+	len = mt76u_get_rx_entry_len(dev, data, urb->actual_length);
 	if (len < 0)
 		return 0;
 
-	data_len = min_t(int, len, data_len - MT_DMA_HDR_LEN);
-	skb = mt76u_build_rx_skb(data, data_len, buf_size);
+	head_room = drv_flags & MT_DRV_RX_DMA_HDR ? 0 : MT_DMA_HDR_LEN;
+	data_len = min_t(int, len, data_len - head_room);
+	skb = mt76u_build_rx_skb(dev, data, data_len, buf_size);
 	if (!skb)
 		return 0;
 
-- 
2.21.1

