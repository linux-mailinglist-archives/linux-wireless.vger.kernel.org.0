Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D76725E6B3
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Sep 2020 11:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgIEJ0X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Sep 2020 05:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgIEJ0W (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Sep 2020 05:26:22 -0400
Received: from localhost.localdomain (unknown [151.66.86.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF0420760;
        Sat,  5 Sep 2020 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599297981;
        bh=tkdB3rrrY+6IKipm4t/4Mq4ihhIER5TZ3Rb9fF1Vyr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ttvsc0KyexDroZtVBFnVzxxEIogZHQ7wycglrmVrg1rBwtQgkEbx+pTKqBC5CmUWE
         ltU/czell3lgcE+6VPJxZo72cBCkEMtNtIoW9rxBUmm299RTNOXkRS+bn2kBSvGlpZ
         JOgyQVAH0haQYogD4bviTCkxz6i3w5jQcEPWAvYQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 4/7] mt76: move pad estimation out of mt76_skb_adjust_pad
Date:   Sat,  5 Sep 2020 11:26:04 +0200
Message-Id: <b2d286e6e9decd8c79bf44d19290a667bc2cc4d8.1599297449.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599297449.git.lorenzo@kernel.org>
References: <cover.1599297449.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move frame pad computation out of mt76_skb_adjust_pad routine.
This is a preliminary patch to introduce sdio tx aggregation.

Tested-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h             | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c   | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c  | 6 +++++-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c | 5 +++--
 drivers/net/wireless/mediatek/mt76/sdio.c             | 5 +++--
 drivers/net/wireless/mediatek/mt76/tx.c               | 6 +-----
 7 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 59eed5374b38..209d23846d4c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1048,7 +1048,7 @@ mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
 	return usb_bulk_msg(udev, pipe, data, len, actual_len, timeout);
 }
 
-int mt76_skb_adjust_pad(struct sk_buff *skb);
+int mt76_skb_adjust_pad(struct sk_buff *skb, int pad);
 int mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 			 u8 req_type, u16 val, u16 offset,
 			 void *buf, size_t len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index ebae2a24c45b..4754b3abd0a2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -190,6 +190,8 @@ static int mt7663s_tx_run_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 					  &ple_sz))
 			break;
 
+		__skb_put_zero(e->skb, 4);
+
 		err = __mt7663s_xmit_queue(dev, e->skb->data, e->skb->len);
 		if (err)
 			return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
index adbed373798e..4d8be366af31 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
@@ -18,8 +18,7 @@ mt7663u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			 int cmd, bool wait_resp)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	int ret, seq, ep;
-	u32 len;
+	int ret, seq, ep, len, pad;
 
 	mutex_lock(&mdev->mcu.mutex);
 
@@ -31,7 +30,8 @@ mt7663u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 
 	len = skb->len;
 	put_unaligned_le32(len, skb_push(skb, sizeof(len)));
-	ret = mt76_skb_adjust_pad(skb);
+	pad = round_up(skb->len, 4) + 4 - skb->len;
+	ret = mt76_skb_adjust_pad(skb, pad);
 	if (ret < 0)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index 56d82bd3a615..c24f26499537 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -247,6 +247,7 @@ int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	struct sk_buff *skb = tx_info->skb;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	int pad;
 
 	if ((info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) &&
 	    !msta->rate_probe) {
@@ -262,9 +263,12 @@ int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		u32 len = skb->len;
 
 		put_unaligned_le32(len, skb_push(skb, sizeof(len)));
+		pad = round_up(skb->len, 4) + 4 - skb->len;
+	} else {
+		pad = round_up(skb->len, 4) - skb->len;
 	}
 
-	return mt76_skb_adjust_pad(skb);
+	return mt76_skb_adjust_pad(skb, pad);
 }
 EXPORT_SYMBOL_GPL(mt7663_usb_sdio_tx_prepare_skb);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 5d0a2857f193..2c2f56112b57 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -45,7 +45,7 @@ EXPORT_SYMBOL_GPL(mt76x02u_mac_start);
 
 int mt76x02u_skb_dma_info(struct sk_buff *skb, int port, u32 flags)
 {
-	u32 info;
+	u32 info, pad;
 
 	/* Buffer layout:
 	 *	|   4B   | xfer len |      pad       |  4B  |
@@ -57,7 +57,8 @@ int mt76x02u_skb_dma_info(struct sk_buff *skb, int port, u32 flags)
 	       FIELD_PREP(MT_TXD_INFO_DPORT, port) | flags;
 	put_unaligned_le32(info, skb_push(skb, sizeof(info)));
 
-	return mt76_skb_adjust_pad(skb);
+	pad = round_up(skb->len, 4) + 4 - skb->len;
+	return mt76_skb_adjust_pad(skb, pad);
 }
 
 int mt76x02u_tx_prepare_skb(struct mt76_dev *mdev, void *data,
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 7777d4944081..9a4d95a2a707 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -226,12 +226,13 @@ mt76s_tx_queue_skb_raw(struct mt76_dev *dev, enum mt76_txq_id qid,
 		       struct sk_buff *skb, u32 tx_info)
 {
 	struct mt76_queue *q = dev->q_tx[qid];
-	int ret = -ENOSPC, len = skb->len;
+	int ret = -ENOSPC, len = skb->len, pad;
 
 	if (q->queued == q->ndesc)
 		goto error;
 
-	ret = mt76_skb_adjust_pad(skb);
+	pad = round_up(skb->len, 4) - skb->len;
+	ret = mt76_skb_adjust_pad(skb, pad);
 	if (ret)
 		goto error;
 
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index b6e52a324e28..ce15efcf7e3a 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -694,13 +694,9 @@ u8 mt76_ac_to_hwq(u8 ac)
 }
 EXPORT_SYMBOL_GPL(mt76_ac_to_hwq);
 
-int mt76_skb_adjust_pad(struct sk_buff *skb)
+int mt76_skb_adjust_pad(struct sk_buff *skb, int pad)
 {
 	struct sk_buff *iter, *last = skb;
-	u32 pad;
-
-	/* Add zero pad of 4 - 7 bytes */
-	pad = round_up(skb->len, 4) + 4 - skb->len;
 
 	/* First packet of a A-MSDU burst keeps track of the whole burst
 	 * length, need to update length of it and the last packet.
-- 
2.26.2

