Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A2F128D6D
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 11:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfLVKeD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 05:34:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLVKeD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 05:34:03 -0500
Received: from lore-desk-wlan.lan (unknown [151.66.53.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD5BC2070A;
        Sun, 22 Dec 2019 10:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577010842;
        bh=HnOVPrS7FSZ8zNs616qFsfKjgjsvga8DjMmWLakwjNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4uKh5NEtcgecIXBY+FVG6lcM3koe/lCHwACsORmvunvNiMJnyMpzqIi7dvLnus7B
         w5Nn4tuKZMx8cg1t529rZwvpDz3nhhFAw8B1/ECcEK173yj9mMpiDqjkNJTVByx2W8
         JBpaVyyDf7BAc++vSv+B694iAw6f96GbmxvMvRfc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH 16/18] mt76: mt76u: introduce mt76u_skb_dma_info routine
Date:   Sun, 22 Dec 2019 11:33:18 +0100
Message-Id: <f920a2ce880fb9a57a06b09020e4df8b6a3ad55b.1577010183.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577010183.git.lorenzo@kernel.org>
References: <cover.1577010183.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76u_skb_dma_info utility routine in mt76-usb module in order
to be reused adding mt7663u support

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../wireless/mediatek/mt76/mt76x02_usb_core.c | 25 ++--------------
 drivers/net/wireless/mediatek/mt76/usb.c      | 29 +++++++++++++++++++
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 975a8937f9e0..b47cc3c2fa0a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -884,6 +884,7 @@ mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
 	return usb_bulk_msg(udev, pipe, data, len, actual_len, timeout);
 }
 
+int mt76u_skb_dma_info(struct sk_buff *skb, u32 info);
 int mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 			 u8 req_type, u16 val, u16 offset,
 			 void *buf, size_t len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 5cf015c1ef5d..3ed5e16e788c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -46,8 +46,7 @@ EXPORT_SYMBOL_GPL(mt76x02u_mac_start);
 
 int mt76x02u_skb_dma_info(struct sk_buff *skb, int port, u32 flags)
 {
-	struct sk_buff *iter, *last = skb;
-	u32 info, pad;
+	u32 info;
 
 	/* Buffer layout:
 	 *	|   4B   | xfer len |      pad       |  4B  |
@@ -57,28 +56,8 @@ int mt76x02u_skb_dma_info(struct sk_buff *skb, int port, u32 flags)
 	 */
 	info = FIELD_PREP(MT_TXD_INFO_LEN, round_up(skb->len, 4)) |
 	       FIELD_PREP(MT_TXD_INFO_DPORT, port) | flags;
-	put_unaligned_le32(info, skb_push(skb, sizeof(info)));
 
-	/* Add zero pad of 4 - 7 bytes */
-	pad = round_up(skb->len, 4) + 4 - skb->len;
-
-	/* First packet of a A-MSDU burst keeps track of the whole burst
-	 * length, need to update length of it and the last packet.
-	 */
-	skb_walk_frags(skb, iter) {
-		last = iter;
-		if (!iter->next) {
-			skb->data_len += pad;
-			skb->len += pad;
-			break;
-		}
-	}
-
-	if (skb_pad(last, pad))
-		return -ENOMEM;
-	__skb_put(last, pad);
-
-	return 0;
+	return mt76u_skb_dma_info(skb, info);
 }
 
 int mt76x02u_tx_prepare_skb(struct mt76_dev *mdev, void *data,
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index d1fe0351c24e..aef88f473660 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -907,6 +907,35 @@ mt76u_tx_setup_buffers(struct mt76_dev *dev, struct sk_buff *skb,
 	return urb->num_sgs;
 }
 
+int mt76u_skb_dma_info(struct sk_buff *skb, u32 info)
+{
+	struct sk_buff *iter, *last = skb;
+	u32 pad;
+
+	put_unaligned_le32(info, skb_push(skb, sizeof(info)));
+	/* Add zero pad of 4 - 7 bytes */
+	pad = round_up(skb->len, 4) + 4 - skb->len;
+
+	/* First packet of a A-MSDU burst keeps track of the whole burst
+	 * length, need to update length of it and the last packet.
+	 */
+	skb_walk_frags(skb, iter) {
+		last = iter;
+		if (!iter->next) {
+			skb->data_len += pad;
+			skb->len += pad;
+			break;
+		}
+	}
+
+	if (skb_pad(last, pad))
+		return -ENOMEM;
+	__skb_put(last, pad);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76u_skb_dma_info);
+
 static int
 mt76u_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 		   struct sk_buff *skb, struct mt76_wcid *wcid,
-- 
2.24.1

