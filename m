Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA3550D07
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jun 2022 22:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbiFSUnb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Jun 2022 16:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiFSUnS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Jun 2022 16:43:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0C62DC9
        for <linux-wireless@vger.kernel.org>; Sun, 19 Jun 2022 13:43:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFB2D6129A
        for <linux-wireless@vger.kernel.org>; Sun, 19 Jun 2022 20:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C781BC341C6;
        Sun, 19 Jun 2022 20:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655671396;
        bh=TiYgCLlBkK4Ph1wg9XyrvNC77mIaQxr//adOu4WquxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=opoAKsx9ll3Yv7hjJ2oFKblfAq3kVnw2KhJ3D/q0W5I+3dcXAGm6R00J7qo7gvrRA
         GxQX0dALurCil6xfFGI85JJstK+KQTwDSm63MJEL+MDfESl7Y5Kx8eanufgqyP/iF7
         urlwShGfAithksjUllgRSbrwsjhPdhW6nbD8My+6VHR9kkQBVeRH0JBl6piKQGr/Ms
         PBnwXFib5ybKAU1cEHIKpZ6PXNziLz6gMO5swDsWqrMC0lXrKMPQkr6NyyMDj3VvMw
         QhPQi7eOiIgkpvQFwmDL6/HffdAQxb9XITKLIjN4swNjR22AnH8t3eG2/QYxdnlChm
         xstXC+RmdlhFw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com
Subject: [PATCH 6/6] mt76: connac: move mt7615_txp_skb_unmap in common code
Date:   Sun, 19 Jun 2022 22:42:41 +0200
Message-Id: <62b26e7a543116b01538f489571cfd91f1b87d0c.1655649422.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655649421.git.lorenzo@kernel.org>
References: <cover.1655649421.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt7615_txp_skb_unmap in shared code and reuse it in mt7915e and
mt7921e driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 56 +----------------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 -
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  2 +
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 60 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 14 +----
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   | 33 +---------
 6 files changed, 65 insertions(+), 102 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 06d17e07034d..d9dd3d404986 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -876,60 +876,6 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 }
 EXPORT_SYMBOL_GPL(mt7615_mac_write_txwi);
 
-static void
-mt7615_txp_skb_unmap_fw(struct mt76_dev *dev, struct mt76_connac_fw_txp *txp)
-{
-	int i;
-
-	for (i = 0; i < txp->nbuf; i++)
-		dma_unmap_single(dev->dev, le32_to_cpu(txp->buf[i]),
-				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
-}
-
-static void
-mt7615_txp_skb_unmap_hw(struct mt76_dev *dev, struct mt76_connac_hw_txp *txp)
-{
-	u32 last_mask;
-	int i;
-
-	last_mask = is_mt7663(dev) ? MT_TXD_LEN_LAST : MT_TXD_LEN_MSDU_LAST;
-
-	for (i = 0; i < ARRAY_SIZE(txp->ptr); i++) {
-		struct mt76_connac_txp_ptr *ptr = &txp->ptr[i];
-		bool last;
-		u16 len;
-
-		len = le16_to_cpu(ptr->len0);
-		last = len & last_mask;
-		len &= MT_TXD_LEN_MASK;
-		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf0), len,
-				 DMA_TO_DEVICE);
-		if (last)
-			break;
-
-		len = le16_to_cpu(ptr->len1);
-		last = len & last_mask;
-		len &= MT_TXD_LEN_MASK;
-		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf1), len,
-				 DMA_TO_DEVICE);
-		if (last)
-			break;
-	}
-}
-
-void mt7615_txp_skb_unmap(struct mt76_dev *dev,
-			  struct mt76_txwi_cache *t)
-{
-	struct mt76_connac_txp_common *txp;
-
-	txp = mt76_connac_txwi_to_txp(dev, t);
-	if (is_mt7615(dev))
-		mt7615_txp_skb_unmap_fw(dev, &txp->fw);
-	else
-		mt7615_txp_skb_unmap_hw(dev, &txp->hw);
-}
-EXPORT_SYMBOL_GPL(mt7615_txp_skb_unmap);
-
 bool mt7615_mac_wtbl_update(struct mt7615_dev *dev, int idx, u32 mask)
 {
 	mt76_rmw(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
@@ -1608,7 +1554,7 @@ mt7615_txwi_free(struct mt7615_dev *dev, struct mt76_txwi_cache *txwi)
 	u32 val;
 	u8 wcid;
 
-	mt7615_txp_skb_unmap(mdev, txwi);
+	mt76_connac_txp_skb_unmap(mdev, txwi);
 	if (!txwi->skb)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 288cc391b61e..653181905d09 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -517,8 +517,6 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 void mt7615_mac_work(struct work_struct *work);
-void mt7615_txp_skb_unmap(struct mt76_dev *dev,
-			  struct mt76_txwi_cache *txwi);
 int mt7615_mcu_set_rx_hdr_trans_blacklist(struct mt7615_dev *dev);
 int mt7615_mcu_set_fcc5_lpn(struct mt7615_dev *dev, int val);
 int mt7615_mcu_set_pulse_th(struct mt7615_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 9f4323de3a8b..077239b0820a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -327,6 +327,8 @@ mt76_connac_mutex_release(struct mt76_dev *dev, struct mt76_connac_pm *pm)
 void mt76_connac_write_hw_txp(struct mt76_dev *dev,
 			      struct mt76_tx_info *tx_info,
 			      void *txp_ptr, u32 id);
+void mt76_connac_txp_skb_unmap(struct mt76_dev *dev,
+			       struct mt76_txwi_cache *txwi);
 void mt76_connac_tx_complete_skb(struct mt76_dev *mdev,
 				 struct mt76_queue_entry *e);
 void mt76_connac_pm_queue_skb(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 9bba5dcbe0c6..af2b33d738ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -191,6 +191,66 @@ void mt76_connac_write_hw_txp(struct mt76_dev *dev,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_write_hw_txp);
 
+static void
+mt76_connac_txp_skb_unmap_fw(struct mt76_dev *mdev,
+			     struct mt76_connac_fw_txp *txp)
+{
+	struct device *dev = is_connac_v1(mdev) ? mdev->dev : mdev->dma_dev;
+	int i;
+
+	for (i = 0; i < txp->nbuf; i++)
+		dma_unmap_single(dev, le32_to_cpu(txp->buf[i]),
+				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
+}
+
+static void
+mt76_connac_txp_skb_unmap_hw(struct mt76_dev *dev,
+			     struct mt76_connac_hw_txp *txp)
+{
+	u32 last_mask;
+	int i;
+
+	if (is_mt7663(dev) || is_mt7921(dev))
+		last_mask = MT_TXD_LEN_LAST;
+	else
+		last_mask = MT_TXD_LEN_MSDU_LAST;
+
+	for (i = 0; i < ARRAY_SIZE(txp->ptr); i++) {
+		struct mt76_connac_txp_ptr *ptr = &txp->ptr[i];
+		bool last;
+		u16 len;
+
+		len = le16_to_cpu(ptr->len0);
+		last = len & last_mask;
+		len &= MT_TXD_LEN_MASK;
+		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf0), len,
+				 DMA_TO_DEVICE);
+		if (last)
+			break;
+
+		len = le16_to_cpu(ptr->len1);
+		last = len & last_mask;
+		len &= MT_TXD_LEN_MASK;
+		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf1), len,
+				 DMA_TO_DEVICE);
+		if (last)
+			break;
+	}
+}
+
+void mt76_connac_txp_skb_unmap(struct mt76_dev *dev,
+			       struct mt76_txwi_cache *t)
+{
+	struct mt76_connac_txp_common *txp;
+
+	txp = mt76_connac_txwi_to_txp(dev, t);
+	if (is_mt76_fw_txp(dev))
+		mt76_connac_txp_skb_unmap_fw(dev, &txp->fw);
+	else
+		mt76_connac_txp_skb_unmap_hw(dev, &txp->hw);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_txp_skb_unmap);
+
 static u16
 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 			     bool beacon, bool mcast)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 719b11e2e57c..dabcd425cd34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -804,18 +804,6 @@ mt7915_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 		ieee80211_start_tx_ba_session(sta, tid, 0);
 }
 
-static void
-mt7915_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
-{
-	struct mt76_connac_fw_txp *txp;
-	int i;
-
-	txp = mt76_connac_txwi_to_txp(dev, t);
-	for (i = 0; i < txp->nbuf; i++)
-		dma_unmap_single(dev->dma_dev, le32_to_cpu(txp->buf[i]),
-				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
-}
-
 static void
 mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 		 struct ieee80211_sta *sta, struct list_head *free_list)
@@ -826,7 +814,7 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 	__le32 *txwi;
 	u16 wcid_idx;
 
-	mt7915_txp_skb_unmap(mdev, t);
+	mt76_connac_txp_skb_unmap(mdev, t);
 	if (!t->skb)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 524f00aa9d27..c4095c0966d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -53,37 +53,6 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	return 0;
 }
 
-static void
-mt7921_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
-{
-	struct mt76_connac_txp_common *txp;
-	int i;
-
-	txp = mt76_connac_txwi_to_txp(dev, t);
-
-	for (i = 0; i < ARRAY_SIZE(txp->hw.ptr); i++) {
-		struct mt76_connac_txp_ptr *ptr = &txp->hw.ptr[i];
-		bool last;
-		u16 len;
-
-		len = le16_to_cpu(ptr->len0);
-		last = len & MT_TXD_LEN_LAST;
-		len &= MT_TXD_LEN_MASK;
-		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf0), len,
-				 DMA_TO_DEVICE);
-		if (last)
-			break;
-
-		len = le16_to_cpu(ptr->len1);
-		last = len & MT_TXD_LEN_LAST;
-		len &= MT_TXD_LEN_MASK;
-		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf1), len,
-				 DMA_TO_DEVICE);
-		if (last)
-			break;
-	}
-}
-
 static void
 mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
 		 struct ieee80211_sta *sta, bool clear_status,
@@ -93,7 +62,7 @@ mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
 	__le32 *txwi;
 	u16 wcid_idx;
 
-	mt7921_txp_skb_unmap(mdev, t);
+	mt76_connac_txp_skb_unmap(mdev, t);
 	if (!t->skb)
 		goto out;
 
-- 
2.36.1

