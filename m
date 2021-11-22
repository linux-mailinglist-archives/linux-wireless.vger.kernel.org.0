Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA78459406
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 18:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbhKVRhd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 12:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234686AbhKVRhd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 12:37:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E293604DA;
        Mon, 22 Nov 2021 17:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637602466;
        bh=pDhmRkU7n7+ALIgLyQU02+A2DAhwpAnAXLYl/Pvok3k=;
        h=From:To:Cc:Subject:Date:From;
        b=mILXfwydiqVYhA76xBDiZP7/aeTsSwJ5LpbiRITUtKp7a/UANgoTdam0J+3yJvrVU
         sOK3M5V6LLkcZL3VARjYFi9MyGc9iCzcXiPFiDdASSvww2TUGjL0zGBK+Ran7KK/Oq
         Q4YND/qQlczqc7mgYm0/E85dMhrQEsIA34SxfK14yQ7a6FRgB0Q9LbQ4LzmJN9PAjy
         YC1tk71M2YKji3M0uZRxVKHZwcjxncmNZPK10wyw/N6WcFS19tYlXC6Qwgbe/dkcDo
         ictHsnAmHe1vRrAum4pTQw/N5etQb3/awp4petjpVLli+kSpVpJn/sXxqzzLetoMDu
         YVGus2fTi/jJg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com
Subject: [PATCH wireless-drivers] mt76: fix possible pktid leak
Date:   Mon, 22 Nov 2021 18:34:03 +0100
Message-Id: <a560caffcc24452fb48af53904bbe5c45ea5db93.1637602268.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix a possible idr pkt-id leak if the packet is dropped on tx side

Fixes: bd1e3e7b693c ("mt76: introduce packet_id idr")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |  3 +--
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  | 23 +++++++++++--------
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |  8 ++++++-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 15 ++++++------
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  | 16 ++++++++-----
 5 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 5ee52cd70a4b..d1806f198aed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -143,8 +143,6 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (!wcid)
 		wcid = &dev->mt76.global_wcid;
 
-	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
-
 	if ((info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) && msta) {
 		struct mt7615_phy *phy = &dev->phy;
 
@@ -164,6 +162,7 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (id < 0)
 		return id;
 
+	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
 	mt7615_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, sta,
 			      pid, key, false);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index bd2939ebcbf4..bfe6c1579dc1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -43,17 +43,11 @@ EXPORT_SYMBOL_GPL(mt7663_usb_sdio_reg_map);
 static void
 mt7663_usb_sdio_write_txwi(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			   enum mt76_txq_id qid, struct ieee80211_sta *sta,
-			   struct sk_buff *skb)
+			   int pid, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	__le32 *txwi;
-	int pid;
-
-	if (!wcid)
-		wcid = &dev->mt76.global_wcid;
-
-	pid = mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
 
 	txwi = (__le32 *)(skb->data - MT_USB_TXD_SIZE);
 	memset(txwi, 0, MT_USB_TXD_SIZE);
@@ -195,9 +189,12 @@ int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	struct sk_buff *skb = tx_info->skb;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct mt7615_sta *msta;
-	int pad;
+	int pad, err, pktid;
 
 	msta = wcid ? container_of(wcid, struct mt7615_sta, wcid) : NULL;
+	if (!wcid)
+		wcid = &dev->mt76.global_wcid;
+
 	if ((info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) &&
 	    msta && !msta->rate_probe) {
 		/* request to configure sampling rate */
@@ -207,7 +204,8 @@ int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		spin_unlock_bh(&dev->mt76.lock);
 	}
 
-	mt7663_usb_sdio_write_txwi(dev, wcid, qid, sta, skb);
+	pktid = mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
+	mt7663_usb_sdio_write_txwi(dev, wcid, qid, sta, pktid, skb);
 	if (mt76_is_usb(mdev)) {
 		u32 len = skb->len;
 
@@ -217,7 +215,12 @@ int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		pad = round_up(skb->len, 4) - skb->len;
 	}
 
-	return mt76_skb_adjust_pad(skb, pad);
+	err = mt76_skb_adjust_pad(skb, pad);
+	if (err)
+		/* Release pktid in case of error. */
+		idr_remove(&wcid->pktid, pktid);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(mt7663_usb_sdio_tx_prepare_skb);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index efd70ddc2fd1..2c6c03809b20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -72,6 +72,7 @@ int mt76x02u_tx_prepare_skb(struct mt76_dev *mdev, void *data,
 	bool ampdu = IEEE80211_SKB_CB(tx_info->skb)->flags & IEEE80211_TX_CTL_AMPDU;
 	enum mt76_qsel qsel;
 	u32 flags;
+	int err;
 
 	mt76_insert_hdr_pad(tx_info->skb);
 
@@ -106,7 +107,12 @@ int mt76x02u_tx_prepare_skb(struct mt76_dev *mdev, void *data,
 		ewma_pktlen_add(&msta->pktlen, tx_info->skb->len);
 	}
 
-	return mt76x02u_skb_dma_info(tx_info->skb, WLAN_PORT, flags);
+	err = mt76x02u_skb_dma_info(tx_info->skb, WLAN_PORT, flags);
+	if (err && wcid)
+		/* Release pktid in case of error. */
+		idr_remove(&wcid->pktid, pid);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(mt76x02u_tx_prepare_skb);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 5fcf35f2d9fb..809dc18e5083 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1151,8 +1151,14 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		}
 	}
 
-	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
+	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
+	t->skb = tx_info->skb;
+
+	id = mt76_token_consume(mdev, &t);
+	if (id < 0)
+		return id;
 
+	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
 	mt7915_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, pid, key,
 			      false);
 
@@ -1178,13 +1184,6 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		txp->bss_idx = mvif->idx;
 	}
 
-	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
-	t->skb = tx_info->skb;
-
-	id = mt76_token_consume(mdev, &t);
-	if (id < 0)
-		return id;
-
 	txp->token = cpu_to_le16(id);
 	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags))
 		txp->rept_wds_wcid = cpu_to_le16(wcid->idx);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index 137f86a6dbf8..85b3d88f8ecc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -142,14 +142,12 @@ int mt7921s_mac_reset(struct mt7921_dev *dev)
 static void
 mt7921s_write_txwi(struct mt7921_dev *dev, struct mt76_wcid *wcid,
 		   enum mt76_txq_id qid, struct ieee80211_sta *sta,
-		   struct sk_buff *skb)
+		   int pid, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	__le32 *txwi;
-	int pid;
 
-	pid = mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
 	txwi = (__le32 *)(skb->data - MT_SDIO_TXD_SIZE);
 	memset(txwi, 0, MT_SDIO_TXD_SIZE);
 	mt7921_mac_write_txwi(dev, txwi, skb, wcid, key, pid, false);
@@ -164,7 +162,7 @@ int mt7921s_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
 	struct sk_buff *skb = tx_info->skb;
-	int pad;
+	int err, pad, pktid;
 
 	if (unlikely(tx_info->skb->len <= ETH_HLEN))
 		return -EINVAL;
@@ -181,12 +179,18 @@ int mt7921s_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		}
 	}
 
-	mt7921s_write_txwi(dev, wcid, qid, sta, skb);
+	pktid = mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
+	mt7921s_write_txwi(dev, wcid, qid, sta, pktid, skb);
 
 	mt7921_skb_add_sdio_hdr(skb, MT7921_SDIO_DATA);
 	pad = round_up(skb->len, 4) - skb->len;
 
-	return mt76_skb_adjust_pad(skb, pad);
+	err = mt76_skb_adjust_pad(skb, pad);
+	if (err)
+		/* Release pktid in case of error. */
+		idr_remove(&wcid->pktid, pktid);
+
+	return err;
 }
 
 void mt7921s_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
-- 
2.31.1

