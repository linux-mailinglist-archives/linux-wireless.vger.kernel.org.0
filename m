Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02624461AEC
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 16:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343788AbhK2PdX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 10:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242857AbhK2PbU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 10:31:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9519AC052922
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 05:41:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E2AEB8117B
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 13:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C9AC004E1;
        Mon, 29 Nov 2021 13:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638193314;
        bh=NU7svsJpEkEXNAbQ15qkOfhvMdL0zfBt54PNvUg1SZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=pN+2sjTT08gEQj2CpGVUpQqiIbXOFBPsB9dKg/a1xsgBL+3XzAnm6jI73ScFeWStZ
         0t2UMxcv0roemdowl6SDv8SwOf75WZItVugUOvWk9Mag9dfkNgZVWRMy4NZL0EDxgp
         aU/jzw3gP75POWqCi9pu3/pIaDCBt5iapDi9gpVRIPZjYRkLAt/1KGPds89YFqF+r9
         Vn1grDSOv2jMbCJv705rdJoNuPRko5b8T8sjTYeXoDrakWr2na8dHh8EWXgnoitDse
         kHNu1wxX+V3GF4X4l14qjt9sdJZlliKeqC6lD2GaJg5MgflT+nIBFrLsXEK3NEuqOm
         85Djevhq2TDcg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        deren.wu@mediatek.com
Subject: [PATCH wireless-drivers] mt76: fix key pointer overwrite in mt7921s_write_txwi/mt7663_usb_sdio_write_txwi
Date:   Mon, 29 Nov 2021 14:41:48 +0100
Message-Id: <eba40c84b6d114f618e2ae486cc6d0f2e9272cf9.1638193069.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix pointer overwrite in mt7921s_tx_prepare_skb and
mt7663_usb_sdio_tx_prepare_skb routines since in
commit '2a9e9857473b ("mt76: fix possible pktid leak")
mt76_tx_status_skb_add() has been moved out of
mt7921s_write_txwi()/mt7663_usb_sdio_write_txwi() overwriting
hw key pointer in ieee80211_tx_info structure. Fix the issue saving
key pointer before running mt76_tx_status_skb_add().

Fixes: 2a9e9857473b ("mt76: fix possible pktid leak")
Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c | 11 +++++------
 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c | 11 +++++------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index bfe6c1579dc1..5a6d7829c6e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -43,13 +43,11 @@ EXPORT_SYMBOL_GPL(mt7663_usb_sdio_reg_map);
 static void
 mt7663_usb_sdio_write_txwi(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			   enum mt76_txq_id qid, struct ieee80211_sta *sta,
-			   int pid, struct sk_buff *skb)
+			   struct ieee80211_key_conf *key, int pid,
+			   struct sk_buff *skb)
 {
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_key_conf *key = info->control.hw_key;
-	__le32 *txwi;
+	__le32 *txwi = (__le32 *)(skb->data - MT_USB_TXD_SIZE);
 
-	txwi = (__le32 *)(skb->data - MT_USB_TXD_SIZE);
 	memset(txwi, 0, MT_USB_TXD_SIZE);
 	mt7615_mac_write_txwi(dev, txwi, skb, wcid, sta, pid, key, false);
 	skb_push(skb, MT_USB_TXD_SIZE);
@@ -188,6 +186,7 @@ int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	struct sk_buff *skb = tx_info->skb;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
 	struct mt7615_sta *msta;
 	int pad, err, pktid;
 
@@ -205,7 +204,7 @@ int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	}
 
 	pktid = mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
-	mt7663_usb_sdio_write_txwi(dev, wcid, qid, sta, pktid, skb);
+	mt7663_usb_sdio_write_txwi(dev, wcid, qid, sta, key, pktid, skb);
 	if (mt76_is_usb(mdev)) {
 		u32 len = skb->len;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index 85b3d88f8ecc..bdec508b6b9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -142,13 +142,11 @@ int mt7921s_mac_reset(struct mt7921_dev *dev)
 static void
 mt7921s_write_txwi(struct mt7921_dev *dev, struct mt76_wcid *wcid,
 		   enum mt76_txq_id qid, struct ieee80211_sta *sta,
-		   int pid, struct sk_buff *skb)
+		   struct ieee80211_key_conf *key, int pid,
+		   struct sk_buff *skb)
 {
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_key_conf *key = info->control.hw_key;
-	__le32 *txwi;
+	__le32 *txwi = (__le32 *)(skb->data - MT_SDIO_TXD_SIZE);
 
-	txwi = (__le32 *)(skb->data - MT_SDIO_TXD_SIZE);
 	memset(txwi, 0, MT_SDIO_TXD_SIZE);
 	mt7921_mac_write_txwi(dev, txwi, skb, wcid, key, pid, false);
 	skb_push(skb, MT_SDIO_TXD_SIZE);
@@ -161,6 +159,7 @@ int mt7921s_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
 	struct sk_buff *skb = tx_info->skb;
 	int err, pad, pktid;
 
@@ -180,7 +179,7 @@ int mt7921s_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	}
 
 	pktid = mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
-	mt7921s_write_txwi(dev, wcid, qid, sta, pktid, skb);
+	mt7921s_write_txwi(dev, wcid, qid, sta, key, pktid, skb);
 
 	mt7921_skb_add_sdio_hdr(skb, MT7921_SDIO_DATA);
 	pad = round_up(skb->len, 4) - skb->len;
-- 
2.31.1

