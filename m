Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375804D76C1
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Mar 2022 17:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbiCMQYg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Mar 2022 12:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbiCMQYc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Mar 2022 12:24:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7904BB89
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 09:23:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBB12611F1
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 16:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4274C340EE;
        Sun, 13 Mar 2022 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647188599;
        bh=GGylIeuNzaaH6zKb6fOu/cdrLidG16ul2VGW43tRogE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B6cyE++hp2Cf9a/S2EcvdauCp8nB1t+HP3kNU6+poP/gaW0ST8WX2//x4oxLgtdLc
         m9o3yp0Iw1GjZdbw9PyjZHPA09KHSQrVFYYzoBDQZnCCxqmukqjVM9Fz3vhxMCPWjK
         OLApUkCSC2YItqyA6O7uzBP2LqhIOlsEbqGXpDpWj9mKRaUNZirYjTtjItCRtC6xNd
         hGjTg13lrTCA+0b1QXOGL7pKf/FXWBo9ZgwWTtL74pN35CklqqsDE1Zxa9L1tyxAsf
         cqy+9cmNacAPoVn5biS2KUl4S7u8I8HG97ayMT0mLPKDueu3s9Z3mxOL9vpgY+ZQ3B
         Dja/E5PSmqfXw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 6/9] mt76: mt7921: move mt7921_usb_sdio_tx_prepare_skb in common mac code
Date:   Sun, 13 Mar 2022 17:22:38 +0100
Message-Id: <e50c88855bcdf5e485e62610c87515c1a4197d3b.1647188302.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647188301.git.lorenzo@kernel.org>
References: <cover.1647188301.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to add mt7921u driver support.

Tested-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 58 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  9 +--
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  2 +-
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  | 53 -----------------
 4 files changed, 64 insertions(+), 58 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index ea2a655acc6a..cceb0338528c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1627,3 +1627,61 @@ void mt7921_coredump_work(struct work_struct *work)
 
 	mt7921_reset(&dev->mt76);
 }
+
+/* usb_sdio */
+static void
+mt7921_usb_sdio_write_txwi(struct mt7921_dev *dev, struct mt76_wcid *wcid,
+			   enum mt76_txq_id qid, struct ieee80211_sta *sta,
+			   struct ieee80211_key_conf *key, int pid,
+			   struct sk_buff *skb)
+{
+	__le32 *txwi = (__le32 *)(skb->data - MT_SDIO_TXD_SIZE);
+
+	memset(txwi, 0, MT_SDIO_TXD_SIZE);
+	mt7921_mac_write_txwi(dev, txwi, skb, wcid, key, pid, false);
+	skb_push(skb, MT_SDIO_TXD_SIZE);
+}
+
+int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+				   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+				   struct ieee80211_sta *sta,
+				   struct mt76_tx_info *tx_info)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	struct sk_buff *skb = tx_info->skb;
+	int err, pad, pktid, type;
+
+	if (unlikely(tx_info->skb->len <= ETH_HLEN))
+		return -EINVAL;
+
+	if (!wcid)
+		wcid = &dev->mt76.global_wcid;
+
+	if (sta) {
+		struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+
+		if (time_after(jiffies, msta->last_txs + HZ / 4)) {
+			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+			msta->last_txs = jiffies;
+		}
+	}
+
+	pktid = mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
+	mt7921_usb_sdio_write_txwi(dev, wcid, qid, sta, key, pktid, skb);
+
+	type = mt76_is_sdio(mdev) ? MT7921_SDIO_DATA : 0;
+	mt7921_skb_add_usb_sdio_hdr(dev, skb, type);
+	pad = round_up(skb->len, 4) - skb->len;
+	if (mt76_is_usb(mdev))
+		pad += 4;
+
+	err = mt76_skb_adjust_pad(skb, pad);
+	if (err)
+		/* Release pktid in case of error. */
+		idr_remove(&wcid->pktid, pktid);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt7921_usb_sdio_tx_prepare_skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 66b331d003b4..14378e149149 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -444,12 +444,13 @@ int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
 int mt7921s_mcu_init(struct mt7921_dev *dev);
 int mt7921s_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921s_mcu_fw_pmctrl(struct mt7921_dev *dev);
-int mt7921s_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
-			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
-			   struct ieee80211_sta *sta,
-			   struct mt76_tx_info *tx_info);
 void mt7921s_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 bool mt7921s_tx_status_data(struct mt76_dev *mdev, u8 *update);
 void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data);
 void mt7921_set_runtime_pm(struct mt7921_dev *dev);
+
+int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+				   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+				   struct ieee80211_sta *sta,
+				   struct mt76_tx_info *tx_info);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index a6ae29c97e0e..fc6499640a1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -91,7 +91,7 @@ static int mt7921s_probe(struct sdio_func *func,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
 				SURVEY_INFO_TIME_BSS_RX,
-		.tx_prepare_skb = mt7921s_tx_prepare_skb,
+		.tx_prepare_skb = mt7921_usb_sdio_tx_prepare_skb,
 		.tx_complete_skb = mt7921s_tx_complete_skb,
 		.tx_status_data = mt7921s_tx_status_data,
 		.rx_skb = mt7921_queue_rx_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index 5462ab05fb13..e039b1bd16a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -141,59 +141,6 @@ int mt7921s_mac_reset(struct mt7921_dev *dev)
 	return err;
 }
 
-static void
-mt7921s_write_txwi(struct mt7921_dev *dev, struct mt76_wcid *wcid,
-		   enum mt76_txq_id qid, struct ieee80211_sta *sta,
-		   struct ieee80211_key_conf *key, int pid,
-		   struct sk_buff *skb)
-{
-	__le32 *txwi = (__le32 *)(skb->data - MT_SDIO_TXD_SIZE);
-
-	memset(txwi, 0, MT_SDIO_TXD_SIZE);
-	mt7921_mac_write_txwi(dev, txwi, skb, wcid, key, pid, false);
-	skb_push(skb, MT_SDIO_TXD_SIZE);
-}
-
-int mt7921s_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
-			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
-			   struct ieee80211_sta *sta,
-			   struct mt76_tx_info *tx_info)
-{
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
-	struct ieee80211_key_conf *key = info->control.hw_key;
-	struct sk_buff *skb = tx_info->skb;
-	int err, pad, pktid;
-
-	if (unlikely(tx_info->skb->len <= ETH_HLEN))
-		return -EINVAL;
-
-	if (!wcid)
-		wcid = &dev->mt76.global_wcid;
-
-	if (sta) {
-		struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
-
-		if (time_after(jiffies, msta->last_txs + HZ / 4)) {
-			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
-			msta->last_txs = jiffies;
-		}
-	}
-
-	pktid = mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
-	mt7921s_write_txwi(dev, wcid, qid, sta, key, pktid, skb);
-
-	mt7921_skb_add_usb_sdio_hdr(dev, skb, MT7921_SDIO_DATA);
-	pad = round_up(skb->len, 4) - skb->len;
-
-	err = mt76_skb_adjust_pad(skb, pad);
-	if (err)
-		/* Release pktid in case of error. */
-		idr_remove(&wcid->pktid, pktid);
-
-	return err;
-}
-
 void mt7921s_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 {
 	__le32 *txwi = (__le32 *)(e->skb->data + MT_SDIO_HDR_SIZE);
-- 
2.35.1

