Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB9E13BDEE
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 12:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgAOK7z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 05:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729940AbgAOK7z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 05:59:55 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BED4324679;
        Wed, 15 Jan 2020 10:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579085994;
        bh=Qnr1GUcUMjGQtb8CAGoyajjc04bzj7QM+CMOx6lyRFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9FzaxZH3JH0Uchf0Ia9UUhenb/P2n+7EwDRhKK+1cPBdtCdcgCAI/bg4cXo7Gyzc
         3NrM4Yi1m/8jgLwMOnfQeJNn1tMXBdfc99abSL2zGm0BqCmbWOc9tr7sjn0yu1wAjf
         K6VZ+PcyC7izC1JqnUtX3qCVeuiEDCaKvk8juyJE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v3 16/18] mt76: mt76u: introduce mt76u_skb_dma_info routine
Date:   Wed, 15 Jan 2020 11:58:56 +0100
Message-Id: <112f4dc4a940ea5bd2c7af1e9e0ac78c083f648b.1579085367.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1579085367.git.lorenzo@kernel.org>
References: <cover.1579085367.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76u_skb_dma_info utility routine in mt76-usb module in order
to be reused adding mt7663u support

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../wireless/mediatek/mt76/mt76x02_usb_core.c | 25 ++--------------
 drivers/net/wireless/mediatek/mt76/usb.c      | 29 +++++++++++++++++++
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index a30b994e98de..69211472d8fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -885,6 +885,7 @@ mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
 	return usb_bulk_msg(udev, pipe, data, len, actual_len, timeout);
 }
 
+int mt76u_skb_dma_info(struct sk_buff *skb, u32 info);
 int mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 			 u8 req_type, u16 val, u16 offset,
 			 void *buf, size_t len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index bf3198ec193b..0180b6200b17 100644
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
index 1f29cd905fdd..57d2590165e3 100644
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
2.21.1

