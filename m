Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B0B555504
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 21:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376754AbiFVTrd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jun 2022 15:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376739AbiFVTr3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 15:47:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57196403E3
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 12:47:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5E1C61736
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 19:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC21DC3411D;
        Wed, 22 Jun 2022 19:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655927247;
        bh=oUt4rVVnxejlXhAjwADoC066MC/bPY6BXTABx8O5k4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TqGGVFNaSJMBgCZK1nBOoQWXfQtj9l+z10UyxWMITEw+aa5c6CHr+yk+jL3G4z008
         ff/nCqHUGF3ou1qBZ2l54WCy2YVeE8rejriCMfJQIUdnH+oYlpUvc8NBJfLFAZBrqU
         EYXWXdGmdBgWI33OKaRU4vAlEWhvEEPqm2nxfN3VB/YaHZMWb0iTwq6EanA9pBIM2r
         9EWhxOSNs/0a/tSFN5PkJOnFd7C+oQiK2aJDFbUmGng+Eb+JqA9dKn9lCHjvvP1pt7
         m3B6fwgFGLby/Lg2IpTtcZFCyC/IGJ+rDLTAf7vRuhm5wLS/Wf8MBQr8b8WM0Xb7xv
         AQ/g+dtTV6MfQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com
Subject: [PATCH v2 2/6] mt76: move mt7615_txp_ptr in mt76_connac module
Date:   Wed, 22 Jun 2022 21:46:52 +0200
Message-Id: <d001b02ecd06d527a1851c2f174ea47cccd0f718.1655926989.git.lorenzo@kernel.org>
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

Since mt7615_txp_ptr is shared between mt7615 and mt7921 move it in
mt76_connac module.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  6 ++---
 .../net/wireless/mediatek/mt76/mt7615/mac.h   | 22 -------------------
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |  2 +-
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |  8 +++----
 .../net/wireless/mediatek/mt76/mt76_connac.h  | 22 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mac.h   | 21 ------------------
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  3 +--
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   | 16 +++++++-------
 8 files changed, 39 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 4beb7b1f7c7b..de809cbf0733 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -887,7 +887,7 @@ mt7615_txp_skb_unmap_fw(struct mt76_dev *dev, struct mt76_connac_fw_txp *txp)
 }
 
 static void
-mt7615_txp_skb_unmap_hw(struct mt76_dev *dev, struct mt7615_hw_txp *txp)
+mt7615_txp_skb_unmap_hw(struct mt76_dev *dev, struct mt76_connac_hw_txp *txp)
 {
 	u32 last_mask;
 	int i;
@@ -895,7 +895,7 @@ mt7615_txp_skb_unmap_hw(struct mt76_dev *dev, struct mt7615_hw_txp *txp)
 	last_mask = is_mt7663(dev) ? MT_TXD_LEN_LAST : MT_TXD_LEN_MSDU_LAST;
 
 	for (i = 0; i < ARRAY_SIZE(txp->ptr); i++) {
-		struct mt7615_txp_ptr *ptr = &txp->ptr[i];
+		struct mt76_connac_txp_ptr *ptr = &txp->ptr[i];
 		bool last;
 		u16 len;
 
@@ -920,7 +920,7 @@ mt7615_txp_skb_unmap_hw(struct mt76_dev *dev, struct mt7615_hw_txp *txp)
 void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 			  struct mt76_txwi_cache *t)
 {
-	struct mt7615_txp_common *txp;
+	struct mt76_connac_txp_common *txp;
 
 	txp = mt76_connac_txwi_to_txp(dev, t);
 	if (is_mt7615(dev))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index fefbc7153937..310c187a1a29 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -244,9 +244,6 @@ enum tx_phy_bandwidth {
 #define MT_TX_RATE_MODE			GENMASK(8, 6)
 #define MT_TX_RATE_IDX			GENMASK(5, 0)
 
-#define MT_HW_TXP_MAX_MSDU_NUM		4
-#define MT_HW_TXP_MAX_BUF_NUM		4
-
 #define MT_MSDU_ID_VALID		BIT(15)
 
 #define MT_TXD_LEN_MASK			GENMASK(11, 0)
@@ -255,25 +252,6 @@ enum tx_phy_bandwidth {
 /* mt7663 */
 #define MT_TXD_LEN_LAST			BIT(15)
 
-struct mt7615_txp_ptr {
-	__le32 buf0;
-	__le16 len0;
-	__le16 len1;
-	__le32 buf1;
-} __packed __aligned(4);
-
-struct mt7615_hw_txp {
-	__le16 msdu_id[MT_HW_TXP_MAX_MSDU_NUM];
-	struct mt7615_txp_ptr ptr[MT_HW_TXP_MAX_BUF_NUM / 2];
-} __packed __aligned(4);
-
-struct mt7615_txp_common {
-	union {
-		struct mt76_connac_fw_txp fw;
-		struct mt7615_hw_txp hw;
-	};
-};
-
 struct mt7615_tx_free {
 	__le16 rx_byte_cnt;
 	__le16 ctrl;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index a208035e197a..3320a80b4171 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -186,7 +186,7 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 {
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
-		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7615_txp_common),
+		.txwi_size = MT_TXD_SIZE + sizeof(struct mt76_connac_txp_common),
 		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 2b8b70106a9e..4dd0f0803fda 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -23,9 +23,9 @@ void mt7615_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 
 	/* error path */
 	if (e->skb == DMA_DUMMY_DATA) {
+		struct mt76_connac_txp_common *txp;
 		struct mt76_txwi_cache *t;
 		struct mt7615_dev *dev;
-		struct mt7615_txp_common *txp;
 		u16 token;
 
 		dev = container_of(mdev, struct mt7615_dev, mt76);
@@ -49,8 +49,8 @@ static void
 mt7615_write_hw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
 		    void *txp_ptr, u32 id)
 {
-	struct mt7615_hw_txp *txp = txp_ptr;
-	struct mt7615_txp_ptr *ptr = &txp->ptr[0];
+	struct mt76_connac_hw_txp *txp = txp_ptr;
+	struct mt76_connac_txp_ptr *ptr = &txp->ptr[0];
 	int i, nbuf = tx_info->nbuf - 1;
 	u32 last_mask;
 
@@ -168,7 +168,7 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			      pid, key, false);
 
 	txp = txwi + MT_TXD_SIZE;
-	memset(txp, 0, sizeof(struct mt7615_txp_common));
+	memset(txp, 0, sizeof(struct mt76_connac_txp_common));
 	if (is_mt7615(&dev->mt76))
 		mt7615_write_fw_txp(dev, tx_info, txp, id);
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 9981ceef7987..4357fea1d79b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -114,6 +114,28 @@ struct mt76_connac_fw_txp {
 	__le16 len[MT_TXP_MAX_BUF_NUM];
 } __packed __aligned(4);
 
+#define MT_HW_TXP_MAX_MSDU_NUM		4
+#define MT_HW_TXP_MAX_BUF_NUM		4
+
+struct mt76_connac_txp_ptr {
+	__le32 buf0;
+	__le16 len0;
+	__le16 len1;
+	__le32 buf1;
+} __packed __aligned(4);
+
+struct mt76_connac_hw_txp {
+	__le16 msdu_id[MT_HW_TXP_MAX_MSDU_NUM];
+	struct mt76_connac_txp_ptr ptr[MT_HW_TXP_MAX_BUF_NUM / 2];
+} __packed __aligned(4);
+
+struct mt76_connac_txp_common {
+	union {
+		struct mt76_connac_fw_txp fw;
+		struct mt76_connac_hw_txp hw;
+	};
+};
+
 extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
 static inline bool is_mt7922(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index ecb73e30ff08..dc98d2c82988 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -60,9 +60,6 @@ struct mt7921_tx_free {
 /* will support this field in further revision */
 #define MT_TX_FREE_RATE			GENMASK(13, 0)
 
-#define MT_HW_TXP_MAX_MSDU_NUM		4
-#define MT_HW_TXP_MAX_BUF_NUM		4
-
 #define MT_MSDU_ID_VALID		BIT(15)
 
 #define MT_TXD_LEN_MASK			GENMASK(11, 0)
@@ -70,24 +67,6 @@ struct mt7921_tx_free {
 #define MT_TXD_LEN_AMSDU_LAST		BIT(15)
 #define MT_TXD_LEN_LAST			BIT(15)
 
-struct mt7921_txp_ptr {
-	__le32 buf0;
-	__le16 len0;
-	__le16 len1;
-	__le32 buf1;
-} __packed __aligned(4);
-
-struct mt7921_hw_txp {
-	__le16 msdu_id[MT_HW_TXP_MAX_MSDU_NUM];
-	struct mt7921_txp_ptr ptr[MT_HW_TXP_MAX_BUF_NUM / 2];
-} __packed __aligned(4);
-
-struct mt7921_txp_common {
-	union {
-		struct mt7921_hw_txp hw;
-	};
-};
-
 #define MT_WTBL_TXRX_CAP_RATE_OFFSET	7
 #define MT_WTBL_TXRX_RATE_G2_HE		24
 #define MT_WTBL_TXRX_RATE_G2		12
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 624eb75c15cd..c61e646a1a94 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -230,7 +230,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 {
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
-		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7921_txp_common),
+		.txwi_size = MT_TXD_SIZE + sizeof(struct mt76_connac_hw_txp),
 		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
@@ -247,7 +247,6 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		.sta_remove = mt7921_mac_sta_remove,
 		.update_survey = mt7921_update_channel,
 	};
-
 	static const struct mt7921_hif_ops mt7921_pcie_ops = {
 		.init_reset = mt7921e_init_reset,
 		.reset = mt7921e_mac_reset,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 9608b5ae8820..bf58dcf1b980 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -9,8 +9,8 @@ static void
 mt7921_write_hw_txp(struct mt7921_dev *dev, struct mt76_tx_info *tx_info,
 		    void *txp_ptr, u32 id)
 {
-	struct mt7921_hw_txp *txp = txp_ptr;
-	struct mt7921_txp_ptr *ptr = &txp->ptr[0];
+	struct mt76_connac_hw_txp *txp = txp_ptr;
+	struct mt76_connac_txp_ptr *ptr = &txp->ptr[0];
 	int i, nbuf = tx_info->nbuf - 1;
 
 	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
@@ -44,8 +44,8 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
 	struct ieee80211_key_conf *key = info->control.hw_key;
+	struct mt76_connac_hw_txp *txp;
 	struct mt76_txwi_cache *t;
-	struct mt7921_txp_common *txp;
 	int id, pid;
 	u8 *txwi = (u8 *)txwi_ptr;
 
@@ -75,8 +75,8 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	mt76_connac2_mac_write_txwi(mdev, txwi_ptr, tx_info->skb, wcid, key,
 				    pid, 0);
 
-	txp = (struct mt7921_txp_common *)(txwi + MT_TXD_SIZE);
-	memset(txp, 0, sizeof(struct mt7921_txp_common));
+	txp = (struct mt76_connac_hw_txp *)(txwi + MT_TXD_SIZE);
+	memset(txp, 0, sizeof(struct mt76_connac_hw_txp));
 	mt7921_write_hw_txp(dev, tx_info, txp, id);
 
 	tx_info->skb = DMA_DUMMY_DATA;
@@ -87,13 +87,13 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 static void
 mt7921_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 {
-	struct mt7921_txp_common *txp;
+	struct mt76_connac_txp_common *txp;
 	int i;
 
 	txp = mt76_connac_txwi_to_txp(dev, t);
 
 	for (i = 0; i < ARRAY_SIZE(txp->hw.ptr); i++) {
-		struct mt7921_txp_ptr *ptr = &txp->hw.ptr[i];
+		struct mt76_connac_txp_ptr *ptr = &txp->hw.ptr[i];
 		bool last;
 		u16 len;
 
@@ -271,8 +271,8 @@ void mt7921e_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 
 	/* error path */
 	if (e->skb == DMA_DUMMY_DATA) {
+		struct mt76_connac_txp_common *txp;
 		struct mt76_txwi_cache *t;
-		struct mt7921_txp_common *txp;
 		u16 token;
 
 		txp = mt76_connac_txwi_to_txp(mdev, e->txwi);
-- 
2.36.1

