Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D77220D45
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 14:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbgGOMqu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 08:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgGOMqu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 08:46:50 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E9A420658;
        Wed, 15 Jul 2020 12:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594817209;
        bh=INrxJce8wnjRmOKZo8VgPo9cOequhPcM5DfO4gr3Y+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bG/Ljhskdf6ZRpTD4kcFJu8v6H+VJsIAsiLPtFPJLPdNX9z+NBd0gD0//xtrFM52b
         4i/IiLIDxA9QdX4asp/bL0AOL/8csahXIG8HTdhrt2+HAvHWCbONU9V2oFMd8Hu9VN
         iaLnVsjfwrOt7z9ZCa99J3bGx+bCkLsbx8HBe/KQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/6] mt76: mt76u: add mt76_skb_adjust_pad utility routine
Date:   Wed, 15 Jul 2020 14:46:27 +0200
Message-Id: <fe2b721fe1fcf475ca47121f373448b436b8140e.1594815602.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1594815602.git.lorenzo@kernel.org>
References: <cover.1594815602.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76_skb_adjust_pad to reuse the code adding sdio support to
mt7615 driver and remove code duplication. Move 4B header configuration
for usb devices out of mt76_skb_adjust_pad

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  8 +++--
 .../wireless/mediatek/mt76/mt7615/usb_mcu.c   |  3 +-
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |  3 +-
 drivers/net/wireless/mediatek/mt76/tx.c       | 29 +++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/usb.c      | 29 -------------------
 6 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index c6e44283bd5f..e6a402c0f5eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1024,7 +1024,7 @@ mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
 	return usb_bulk_msg(udev, pipe, data, len, actual_len, timeout);
 }
 
-int mt76u_skb_dma_info(struct sk_buff *skb, u32 info);
+int mt76_skb_adjust_pad(struct sk_buff *skb);
 int mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 			 u8 req_type, u16 val, u16 offset,
 			 void *buf, size_t len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index 1f1578895ed5..aba926f1eeb5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -252,7 +252,8 @@ mt7663u_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 {
 	struct mt7615_sta *msta = container_of(wcid, struct mt7615_sta, wcid);
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct sk_buff *skb = tx_info->skb;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 
 	if ((info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) &&
 	    !msta->rate_probe) {
@@ -262,9 +263,10 @@ mt7663u_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 				     msta->rates);
 		spin_unlock_bh(&dev->mt76.lock);
 	}
-	mt7663u_mac_write_txwi(dev, wcid, qid, sta, tx_info->skb);
+	mt7663u_mac_write_txwi(dev, wcid, qid, sta, skb);
 
-	return mt76u_skb_dma_info(tx_info->skb, tx_info->skb->len);
+	put_unaligned_le32(skb->len, skb_push(skb, sizeof(skb->len)));
+	return mt76_skb_adjust_pad(skb);
 }
 
 static bool mt7663u_tx_status_data(struct mt76_dev *mdev, u8 *update)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
index 39cd7dd95c9c..0b33df3e3bfe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
@@ -28,7 +28,8 @@ mt7663u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	else
 		ep = MT_EP_OUT_AC_BE;
 
-	ret = mt76u_skb_dma_info(skb, skb->len);
+	put_unaligned_le32(skb->len, skb_push(skb, sizeof(skb->len)));
+	ret = mt76_skb_adjust_pad(skb);
 	if (ret < 0)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 0180b6200b17..37321e656776 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -56,8 +56,9 @@ int mt76x02u_skb_dma_info(struct sk_buff *skb, int port, u32 flags)
 	 */
 	info = FIELD_PREP(MT_TXD_INFO_LEN, round_up(skb->len, 4)) |
 	       FIELD_PREP(MT_TXD_INFO_DPORT, port) | flags;
+	put_unaligned_le32(info, skb_push(skb, sizeof(info)));
 
-	return mt76u_skb_dma_info(skb, info);
+	return mt76_skb_adjust_pad(skb);
 }
 
 int mt76x02u_tx_prepare_skb(struct mt76_dev *mdev, void *data,
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 5adf92d7a9f3..3afd89ecd6c9 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -677,3 +677,32 @@ u8 mt76_ac_to_hwq(u8 ac)
 	return wmm_queue_map[ac];
 }
 EXPORT_SYMBOL_GPL(mt76_ac_to_hwq);
+
+int mt76_skb_adjust_pad(struct sk_buff *skb)
+{
+	struct sk_buff *iter, *last = skb;
+	u32 pad;
+
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
+
+	__skb_put(last, pad);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_skb_adjust_pad);
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 84e2fd0a4fc1..5f19f9e51d9c 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -904,35 +904,6 @@ mt76u_tx_setup_buffers(struct mt76_dev *dev, struct sk_buff *skb,
 	return urb->num_sgs;
 }
 
-int mt76u_skb_dma_info(struct sk_buff *skb, u32 info)
-{
-	struct sk_buff *iter, *last = skb;
-	u32 pad;
-
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
-}
-EXPORT_SYMBOL_GPL(mt76u_skb_dma_info);
-
 static int
 mt76u_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 		   struct sk_buff *skb, struct mt76_wcid *wcid,
-- 
2.26.2

