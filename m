Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6781555500
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 21:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359181AbiFVTrp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jun 2022 15:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376536AbiFVTre (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 15:47:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF2F403C8
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 12:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C4C3B820D4
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 19:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9117DC3411D;
        Wed, 22 Jun 2022 19:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655927251;
        bh=nGfN/y+iHmfIQp1OlaAr5tmzctgVygT+iz7CQihDpHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWBgtI2IPcC1KcT3BlqfWZCoY5mc3qRP/HREYYIo3hdOUOr9Mt58LtS5Eo01ySQPt
         vWZah2FNcrTKQwBL2XOkvQwAaFOfxAeyO9jXCrvtPIiWshQ/HFE7ZByxP8Ul4wdhal
         YlIZf+cBdKNHgPcCMNeDy1Q72Wi0U/ynx3tuUuynFKIX9ff6NoVhG5v6WdA6kxPJf0
         t1xgxo6Ejin4/PvzN+A5YlvHUFCLwoGxbmGxgxtivv0zanlGVUm2IEmUuhmBc3B1MK
         enMyFvYm04kA7KAe2+Qj12+hy7D7AbJIY/Dv10owCq7YDQegAbE4ih2yS+Zhle4+1G
         9hWCP6KHtNntg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com
Subject: [PATCH v2 4/6] mt76: connac: move mt76_connac_tx_complete_skb in shared code
Date:   Wed, 22 Jun 2022 21:46:54 +0200
Message-Id: <b28ad492454581bee9dadbed1aeae0cb1b4ecd75.1655926989.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655926989.git.lorenzo@kernel.org>
References: <cover.1655926989.git.lorenzo@kernel.org>
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

Since now txp structures are in common code we can reuse
mt76_connac_tx_complete_skb routine in mt7921e, mt7915e and mt7615e
drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |  2 --
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |  2 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 -
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   | 31 -------------------
 .../net/wireless/mediatek/mt76/mt76_connac.h  | 17 ++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 31 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 21 -------------
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  2 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 -
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |  2 --
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 -
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  2 +-
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   | 23 --------------
 13 files changed, 51 insertions(+), 85 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index 6af15f2e0f5a..4cc805f0fea9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -244,8 +244,6 @@ enum tx_phy_bandwidth {
 #define MT_TX_RATE_MODE			GENMASK(8, 6)
 #define MT_TX_RATE_IDX			GENMASK(5, 0)
 
-#define MT_MSDU_ID_VALID		BIT(15)
-
 #define MT_TXD_LEN_MASK			GENMASK(11, 0)
 #define MT_TXD_LEN_MSDU_LAST		BIT(14)
 #define MT_TXD_LEN_AMSDU_LAST		BIT(15)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index 3320a80b4171..a784f9d9e935 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -193,7 +193,7 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 				SURVEY_INFO_TIME_BSS_RX,
 		.token_size = MT7615_TOKEN_SIZE,
 		.tx_prepare_skb = mt7615_tx_prepare_skb,
-		.tx_complete_skb = mt7615_tx_complete_skb,
+		.tx_complete_skb = mt76_connac_tx_complete_skb,
 		.rx_check = mt7615_rx_check,
 		.rx_skb = mt7615_queue_rx_skb,
 		.rx_poll_complete = mt7615_rx_poll_complete,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 2e91f6a27d0f..288cc391b61e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -507,7 +507,6 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  struct mt76_tx_info *tx_info);
 
 void mt7615_tx_worker(struct mt76_worker *w);
-void mt7615_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 void mt7615_tx_token_put(struct mt7615_dev *dev);
 bool mt7615_rx_check(struct mt76_dev *mdev, void *data, int len);
 void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 4dd0f0803fda..9117012b9b1a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -14,37 +14,6 @@
 #include "../dma.h"
 #include "mac.h"
 
-void mt7615_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
-{
-	if (!e->txwi) {
-		dev_kfree_skb_any(e->skb);
-		return;
-	}
-
-	/* error path */
-	if (e->skb == DMA_DUMMY_DATA) {
-		struct mt76_connac_txp_common *txp;
-		struct mt76_txwi_cache *t;
-		struct mt7615_dev *dev;
-		u16 token;
-
-		dev = container_of(mdev, struct mt7615_dev, mt76);
-		txp = mt76_connac_txwi_to_txp(mdev, e->txwi);
-
-		if (is_mt7615(&dev->mt76))
-			token = le16_to_cpu(txp->fw.token);
-		else
-			token = le16_to_cpu(txp->hw.msdu_id[0]) &
-				~MT_MSDU_ID_VALID;
-
-		t = mt76_token_put(mdev, token);
-		e->skb = t ? t->skb : NULL;
-	}
-
-	if (e->skb)
-		mt76_tx_complete_skb(mdev, e->wcid, e->skb);
-}
-
 static void
 mt7615_write_hw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
 		    void *txp_ptr, u32 id)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 0ef10895fbf8..da41ad6c87fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -27,6 +27,8 @@
 #define MT_SDIO_TAIL_SIZE			8
 #define MT_SDIO_HDR_SIZE			4
 
+#define MT_MSDU_ID_VALID		BIT(15)
+
 enum {
 	CMD_CBW_20MHZ = IEEE80211_STA_RX_BW_20,
 	CMD_CBW_40MHZ = IEEE80211_STA_RX_BW_40,
@@ -198,6 +200,19 @@ static inline bool is_connac_v1(struct mt76_dev *dev)
 	return is_mt7615(dev) || is_mt7663(dev) || is_mt7622(dev);
 }
 
+static inline bool is_mt76_fw_txp(struct mt76_dev *dev)
+{
+	switch (mt76_chip(dev)) {
+	case 0x7961:
+	case 0x7922:
+	case 0x7663:
+	case 0x7622:
+		return false;
+	default:
+		return true;
+	}
+}
+
 static inline u8 mt76_connac_chan_bw(struct cfg80211_chan_def *chandef)
 {
 	static const u8 width_to_bw[] = {
@@ -304,6 +319,8 @@ mt76_connac_mutex_release(struct mt76_dev *dev, struct mt76_connac_pm *pm)
 	mutex_unlock(&dev->mutex);
 }
 
+void mt76_connac_tx_complete_skb(struct mt76_dev *mdev,
+				 struct mt76_queue_entry *e);
 void mt76_connac_pm_queue_skb(struct ieee80211_hw *hw,
 			      struct mt76_connac_pm *pm,
 			      struct mt76_wcid *wcid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 6aa02ace365b..134daa9103a2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -3,6 +3,7 @@
 
 #include "mt76_connac.h"
 #include "mt76_connac2_mac.h"
+#include "dma.h"
 
 #define HE_BITS(f)		cpu_to_le16(IEEE80211_RADIOTAP_HE_##f)
 #define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
@@ -121,6 +122,36 @@ void mt76_connac_pm_dequeue_skbs(struct mt76_phy *phy,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_pm_dequeue_skbs);
 
+void mt76_connac_tx_complete_skb(struct mt76_dev *mdev,
+				 struct mt76_queue_entry *e)
+{
+	if (!e->txwi) {
+		dev_kfree_skb_any(e->skb);
+		return;
+	}
+
+	/* error path */
+	if (e->skb == DMA_DUMMY_DATA) {
+		struct mt76_connac_txp_common *txp;
+		struct mt76_txwi_cache *t;
+		u16 token;
+
+		txp = mt76_connac_txwi_to_txp(mdev, e->txwi);
+		if (is_mt76_fw_txp(mdev))
+			token = le16_to_cpu(txp->fw.token);
+		else
+			token = le16_to_cpu(txp->hw.msdu_id[0]) &
+				~MT_MSDU_ID_VALID;
+
+		t = mt76_token_put(mdev, token);
+		e->skb = t ? t->skb : NULL;
+	}
+
+	if (e->skb)
+		mt76_tx_complete_skb(mdev, e->wcid, e->skb);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_tx_complete_skb);
+
 static u16
 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 			     bool beacon, bool mcast)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 6e97c443f1c2..719b11e2e57c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1111,27 +1111,6 @@ void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	}
 }
 
-void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
-{
-	if (!e->txwi) {
-		dev_kfree_skb_any(e->skb);
-		return;
-	}
-
-	/* error path */
-	if (e->skb == DMA_DUMMY_DATA) {
-		struct mt76_connac_fw_txp *txp;
-		struct mt76_txwi_cache *t;
-
-		txp = mt76_connac_txwi_to_txp(mdev, e->txwi);
-		t = mt76_token_put(mdev, le16_to_cpu(txp->token));
-		e->skb = t ? t->skb : NULL;
-	}
-
-	if (e->skb)
-		mt76_tx_complete_skb(mdev, e->wcid, e->skb);
-}
-
 void mt7915_mac_cca_stats_reset(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 6b889f454d1a..c2646d24b574 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -652,7 +652,7 @@ struct mt7915_dev *mt7915_mmio_probe(struct device *pdev,
 				SURVEY_INFO_TIME_BSS_RX,
 		.token_size = MT7915_TOKEN_SIZE,
 		.tx_prepare_skb = mt7915_tx_prepare_skb,
-		.tx_complete_skb = mt7915_tx_complete_skb,
+		.tx_complete_skb = mt76_connac_tx_complete_skb,
 		.rx_skb = mt7915_queue_rx_skb,
 		.rx_check = mt7915_rx_check,
 		.rx_poll_complete = mt7915_rx_poll_complete,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 3db0758b75e3..b6a6aa7fcf43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -571,7 +571,6 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
 			  struct mt76_tx_info *tx_info);
-void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 void mt7915_tx_token_put(struct mt7915_dev *dev);
 void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index 26b1ec35cc2b..a2e9e1bae859 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -52,8 +52,6 @@ enum tx_mcu_port_q_idx {
 /* will support this field in further revision */
 #define MT_TX_FREE_RATE			GENMASK(13, 0)
 
-#define MT_MSDU_ID_VALID		BIT(15)
-
 #define MT_TXD_LEN_MASK			GENMASK(11, 0)
 #define MT_TXD_LEN_MSDU_LAST		BIT(14)
 #define MT_TXD_LEN_AMSDU_LAST		BIT(15)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index f7609c8ac549..48fd14c67e44 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -386,7 +386,6 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			   struct mt76_tx_info *tx_info);
 
 void mt7921_tx_worker(struct mt76_worker *w);
-void mt7921e_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 void mt7921_tx_token_put(struct mt7921_dev *dev);
 void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index c61e646a1a94..23361a505daf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -237,7 +237,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 				SURVEY_INFO_TIME_BSS_RX,
 		.token_size = MT7921_TOKEN_SIZE,
 		.tx_prepare_skb = mt7921e_tx_prepare_skb,
-		.tx_complete_skb = mt7921e_tx_complete_skb,
+		.tx_complete_skb = mt76_connac_tx_complete_skb,
 		.rx_check = mt7921e_rx_check,
 		.rx_skb = mt7921e_queue_rx_skb,
 		.rx_poll_complete = mt7921_rx_poll_complete,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 333390cb791b..75e5dc4e6f84 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -263,29 +263,6 @@ void mt7921e_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	}
 }
 
-void mt7921e_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
-{
-	if (!e->txwi) {
-		dev_kfree_skb_any(e->skb);
-		return;
-	}
-
-	/* error path */
-	if (e->skb == DMA_DUMMY_DATA) {
-		struct mt76_connac_txp_common *txp;
-		struct mt76_txwi_cache *t;
-		u16 token;
-
-		txp = mt76_connac_txwi_to_txp(mdev, e->txwi);
-		token = le16_to_cpu(txp->hw.msdu_id[0]) & ~MT_MSDU_ID_VALID;
-		t = mt76_token_put(mdev, token);
-		e->skb = t ? t->skb : NULL;
-	}
-
-	if (e->skb)
-		mt76_tx_complete_skb(mdev, e->wcid, e->skb);
-}
-
 void mt7921_tx_token_put(struct mt7921_dev *dev)
 {
 	struct mt76_txwi_cache *txwi;
-- 
2.36.1

