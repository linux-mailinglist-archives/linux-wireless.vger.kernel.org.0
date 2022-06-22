Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F352555501
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 21:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376780AbiFVTrl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jun 2022 15:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359113AbiFVTra (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 15:47:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FFD3FDB2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 12:47:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0F5FB81E82
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 19:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D012BC34114;
        Wed, 22 Jun 2022 19:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655927245;
        bh=fwr0rSiamUq0Gyrye+qzJ4q0yjWHxNQ6zhmyxVwoPb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Li/MU6WUGjAM2o5ff4xkFIt4msaKEe8JMXPdyRKfiCmjMMReRBeVQrzdNwWm1MuAt
         hSz3vC/wdCpfkMigEShy7OpQJPh8kCd02ks4jKk55v6PIPXvhp7ZiVOM0K0bT0cmgN
         JLtLbN45uOm4iKH7M8+J84ij9UPhKGAqlTJlsZoFZjFQXKHya07okBAnE1dkQ30pAL
         4U/K+br+ZRnX8Uh8vay/F04XABQjTNBa1ZXnSSNg5XKRvO2MLOdmZi5IMhvyx07zBQ
         5u38CD4Q0ykGgHgOQ0cVnvFb39XCF6GIwZn3xXHb4e1aztW7TTw2IV8/vJjEQtS96S
         wjISMkL7rm1cw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com
Subject: [PATCH v2 1/6] mt76: connac: move mt76_connac_fw_txp in common module
Date:   Wed, 22 Jun 2022 21:46:51 +0200
Message-Id: <23a420d53726e2212a706d1bd43c82f14326cb57.1655926989.git.lorenzo@kernel.org>
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

Since mt76_connac_fw_txp struct is shared between mt7615e, mt7915e and
mt7921e, move it in mt76_connac module.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  4 +--
 .../net/wireless/mediatek/mt76/mt7615/mac.h   | 33 +----------------
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |  7 ++--
 .../net/wireless/mediatek/mt76/mt76_connac.h  | 35 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac2_mac.h | 13 +++----
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 14 ++++----
 .../net/wireless/mediatek/mt76/mt7915/mac.h   | 32 -----------------
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.h   | 32 -----------------
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  4 +--
 10 files changed, 59 insertions(+), 117 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index f26213c4e64c..4beb7b1f7c7b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -877,7 +877,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 EXPORT_SYMBOL_GPL(mt7615_mac_write_txwi);
 
 static void
-mt7615_txp_skb_unmap_fw(struct mt76_dev *dev, struct mt7615_fw_txp *txp)
+mt7615_txp_skb_unmap_fw(struct mt76_dev *dev, struct mt76_connac_fw_txp *txp)
 {
 	int i;
 
@@ -922,7 +922,7 @@ void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 {
 	struct mt7615_txp_common *txp;
 
-	txp = mt7615_txwi_to_txp(dev, t);
+	txp = mt76_connac_txwi_to_txp(dev, t);
 	if (is_mt7615(dev))
 		mt7615_txp_skb_unmap_fw(dev, &txp->fw);
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index e241c613091c..fefbc7153937 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -165,12 +165,6 @@ enum tx_phy_bandwidth {
 #define MT_CT_INFO_NONE_CIPHER_FRAME	BIT(3)
 #define MT_CT_INFO_HSR2_TX		BIT(4)
 
-#define MT_TXD_SIZE			(8 * 4)
-
-#define MT_USB_TXD_SIZE			(MT_TXD_SIZE + 8 * 4)
-#define MT_USB_HDR_SIZE			4
-#define MT_USB_TAIL_SIZE		4
-
 #define MT_TXD0_P_IDX			BIT(31)
 #define MT_TXD0_Q_IDX			GENMASK(30, 26)
 #define MT_TXD0_UDP_TCP_SUM		BIT(24)
@@ -250,7 +244,6 @@ enum tx_phy_bandwidth {
 #define MT_TX_RATE_MODE			GENMASK(8, 6)
 #define MT_TX_RATE_IDX			GENMASK(5, 0)
 
-#define MT_TXP_MAX_BUF_NUM		6
 #define MT_HW_TXP_MAX_MSDU_NUM		4
 #define MT_HW_TXP_MAX_BUF_NUM		4
 
@@ -274,20 +267,9 @@ struct mt7615_hw_txp {
 	struct mt7615_txp_ptr ptr[MT_HW_TXP_MAX_BUF_NUM / 2];
 } __packed __aligned(4);
 
-struct mt7615_fw_txp {
-	__le16 flags;
-	__le16 token;
-	u8 bss_idx;
-	u8 rept_wds_wcid;
-	u8 rsv;
-	u8 nbuf;
-	__le32 buf[MT_TXP_MAX_BUF_NUM];
-	__le16 len[MT_TXP_MAX_BUF_NUM];
-} __packed __aligned(4);
-
 struct mt7615_txp_common {
 	union {
-		struct mt7615_fw_txp fw;
+		struct mt76_connac_fw_txp fw;
 		struct mt7615_hw_txp hw;
 	};
 };
@@ -385,19 +367,6 @@ struct mt7615_dfs_radar_spec {
 	struct mt7615_dfs_pattern radar_pattern[16];
 };
 
-static inline struct mt7615_txp_common *
-mt7615_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
-{
-	u8 *txwi;
-
-	if (!t)
-		return NULL;
-
-	txwi = mt76_get_txwi_ptr(dev, t);
-
-	return (struct mt7615_txp_common *)(txwi + MT_TXD_SIZE);
-}
-
 static inline u32 mt7615_mac_wtbl_addr(struct mt7615_dev *dev, int wcid)
 {
 	return MT_WTBL_BASE(dev) + wcid * MT_WTBL_ENTRY_SIZE;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 73298dce35b7..2b8b70106a9e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -29,7 +29,7 @@ void mt7615_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 		u16 token;
 
 		dev = container_of(mdev, struct mt7615_dev, mt76);
-		txp = mt7615_txwi_to_txp(mdev, e->txwi);
+		txp = mt76_connac_txwi_to_txp(mdev, e->txwi);
 
 		if (is_mt7615(&dev->mt76))
 			token = le16_to_cpu(txp->fw.token);
@@ -91,7 +91,8 @@ mt7615_write_fw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	struct ieee80211_vif *vif = info->control.vif;
-	struct mt7615_fw_txp *txp = txp_ptr;
+	struct mt76_connac_fw_txp *txp = txp_ptr;
+	u8 *rept_wds_wcid = (u8 *)&txp->rept_wds_wcid;
 	int nbuf = tx_info->nbuf - 1;
 	int i;
 
@@ -122,7 +123,7 @@ mt7615_write_fw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
 	}
 
 	txp->token = cpu_to_le16(id);
-	txp->rept_wds_wcid = 0xff;
+	*rept_wds_wcid = 0xff;
 }
 
 int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index a9927dcf3d6c..9981ceef7987 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -17,6 +17,16 @@
 #define MT76_CONNAC_COREDUMP_TIMEOUT		(HZ / 20)
 #define MT76_CONNAC_COREDUMP_SZ			(1300 * 1024)
 
+#define MT_TXD_SIZE				(8 * 4)
+
+#define MT_USB_TXD_SIZE				(MT_TXD_SIZE + 8 * 4)
+#define MT_USB_HDR_SIZE				4
+#define MT_USB_TAIL_SIZE			4
+
+#define MT_SDIO_TXD_SIZE			(MT_TXD_SIZE + 8 * 4)
+#define MT_SDIO_TAIL_SIZE			8
+#define MT_SDIO_HDR_SIZE			4
+
 enum {
 	CMD_CBW_20MHZ = IEEE80211_STA_RX_BW_20,
 	CMD_CBW_40MHZ = IEEE80211_STA_RX_BW_40,
@@ -92,6 +102,18 @@ struct mt76_connac_sta_key_conf {
 	u8 key[16];
 };
 
+#define MT_TXP_MAX_BUF_NUM		6
+
+struct mt76_connac_fw_txp {
+	__le16 flags;
+	__le16 token;
+	u8 bss_idx;
+	__le16 rept_wds_wcid;
+	u8 nbuf;
+	__le32 buf[MT_TXP_MAX_BUF_NUM];
+	__le16 len[MT_TXP_MAX_BUF_NUM];
+} __packed __aligned(4);
+
 extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
 static inline bool is_mt7922(struct mt76_dev *dev)
@@ -172,6 +194,19 @@ static inline u8 mt76_connac_lmac_mapping(u8 ac)
 	return 3 - ac;
 }
 
+static inline void *
+mt76_connac_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
+{
+	u8 *txwi;
+
+	if (!t)
+		return NULL;
+
+	txwi = mt76_get_txwi_ptr(dev, t);
+
+	return (void *)(txwi + MT_TXD_SIZE);
+}
+
 int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm);
 void mt76_connac_power_save_sched(struct mt76_phy *phy,
 				  struct mt76_connac_pm *pm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
index 0d04207b4292..a72ae9af9b38 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
@@ -32,12 +32,6 @@ enum {
 	MT_LMAC_PSMP0,
 };
 
-#define MT_TXD_SIZE			(8 * 4)
-#define MT_SDIO_TXD_SIZE		(MT_TXD_SIZE + 8 * 4)
-#define MT_SDIO_TAIL_SIZE		8
-#define MT_SDIO_HDR_SIZE		4
-#define MT_USB_TAIL_SIZE		4
-
 #define MT_TXD0_Q_IDX			GENMASK(31, 25)
 #define MT_TXD0_PKT_FMT			GENMASK(24, 23)
 #define MT_TXD0_ETH_TYPE_OFFSET		GENMASK(22, 16)
@@ -306,4 +300,11 @@ enum {
 #define MT_CRXV_FOE_HI		GENMASK(6, 0)
 #define MT_CRXV_FOE_SHIFT	13
 
+#define MT_CT_INFO_APPLY_TXD		BIT(0)
+#define MT_CT_INFO_COPY_HOST_TXD_ALL	BIT(1)
+#define MT_CT_INFO_MGMT_FRAME		BIT(2)
+#define MT_CT_INFO_NONE_CIPHER_FRAME	BIT(3)
+#define MT_CT_INFO_HSR2_TX		BIT(4)
+#define MT_CT_INFO_FROM_HOST		BIT(7)
+
 #endif /* __MT76_CONNAC2_MAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 3af4a6afb55b..6e97c443f1c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -686,8 +686,8 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	struct ieee80211_vif *vif = info->control.vif;
+	struct mt76_connac_fw_txp *txp;
 	struct mt76_txwi_cache *t;
-	struct mt7915_txp *txp;
 	int id, i, nbuf = tx_info->nbuf - 1;
 	u8 *txwi = (u8 *)txwi_ptr;
 	int pid;
@@ -719,7 +719,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
 	mt7915_mac_write_txwi(mdev, txwi_ptr, tx_info->skb, wcid, pid, key, 0);
 
-	txp = (struct mt7915_txp *)(txwi + MT_TXD_SIZE);
+	txp = (struct mt76_connac_fw_txp *)(txwi + MT_TXD_SIZE);
 	for (i = 0; i < nbuf; i++) {
 		txp->buf[i] = cpu_to_le32(tx_info->buf[i + 1].addr);
 		txp->len[i] = cpu_to_le16(tx_info->buf[i + 1].len);
@@ -758,7 +758,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 u32 mt7915_wed_init_buf(void *ptr, dma_addr_t phys, int token_id)
 {
-	struct mt7915_txp *txp = ptr + MT_TXD_SIZE;
+	struct mt76_connac_fw_txp *txp = ptr + MT_TXD_SIZE;
 	__le32 *txwi = ptr;
 	u32 val;
 
@@ -807,10 +807,10 @@ mt7915_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 static void
 mt7915_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 {
-	struct mt7915_txp *txp;
+	struct mt76_connac_fw_txp *txp;
 	int i;
 
-	txp = mt7915_txwi_to_txp(dev, t);
+	txp = mt76_connac_txwi_to_txp(dev, t);
 	for (i = 0; i < txp->nbuf; i++)
 		dma_unmap_single(dev->dma_dev, le32_to_cpu(txp->buf[i]),
 				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
@@ -1120,10 +1120,10 @@ void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 
 	/* error path */
 	if (e->skb == DMA_DUMMY_DATA) {
+		struct mt76_connac_fw_txp *txp;
 		struct mt76_txwi_cache *t;
-		struct mt7915_txp *txp;
 
-		txp = mt7915_txwi_to_txp(mdev, e->txwi);
+		txp = mt76_connac_txwi_to_txp(mdev, e->txwi);
 		t = mt76_token_put(mdev, le16_to_cpu(txp->token));
 		e->skb = t ? t->skb : NULL;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 724feb2df4a0..ed71a7bc25eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -42,25 +42,6 @@ enum tx_mcu_port_q_idx {
 	MT_TX_MCU_PORT_RX_FWDL = 0x3e
 };
 
-#define MT_CT_INFO_APPLY_TXD		BIT(0)
-#define MT_CT_INFO_COPY_HOST_TXD_ALL	BIT(1)
-#define MT_CT_INFO_MGMT_FRAME		BIT(2)
-#define MT_CT_INFO_NONE_CIPHER_FRAME	BIT(3)
-#define MT_CT_INFO_HSR2_TX		BIT(4)
-#define MT_CT_INFO_FROM_HOST		BIT(7)
-
-#define MT_TXP_MAX_BUF_NUM		6
-
-struct mt7915_txp {
-	__le16 flags;
-	__le16 token;
-	u8 bss_idx;
-	__le16 rept_wds_wcid;
-	u8 nbuf;
-	__le32 buf[MT_TXP_MAX_BUF_NUM];
-	__le16 len[MT_TXP_MAX_BUF_NUM];
-} __packed __aligned(4);
-
 struct mt7915_tx_free {
 	__le16 rx_byte_cnt;
 	__le16 ctrl;
@@ -137,17 +118,4 @@ struct mt7915_dfs_radar_spec {
 	struct mt7915_dfs_pattern radar_pattern[16];
 };
 
-static inline struct mt7915_txp *
-mt7915_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
-{
-	u8 *txwi;
-
-	if (!t)
-		return NULL;
-
-	txwi = mt76_get_txwi_ptr(dev, t);
-
-	return (struct mt7915_txp *)(txwi + MT_TXD_SIZE);
-}
-
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 46ee8a7db7bc..6b889f454d1a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -645,7 +645,7 @@ struct mt7915_dev *mt7915_mmio_probe(struct device *pdev,
 {
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
-		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7915_txp),
+		.txwi_size = MT_TXD_SIZE + sizeof(struct mt76_connac_fw_txp),
 		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index ca2ec83bc831..ecb73e30ff08 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -42,25 +42,6 @@ enum tx_mcu_port_q_idx {
 	MT_TX_MCU_PORT_RX_FWDL = 0x3e
 };
 
-#define MT_CT_INFO_APPLY_TXD		BIT(0)
-#define MT_CT_INFO_COPY_HOST_TXD_ALL	BIT(1)
-#define MT_CT_INFO_MGMT_FRAME		BIT(2)
-#define MT_CT_INFO_NONE_CIPHER_FRAME	BIT(3)
-#define MT_CT_INFO_HSR2_TX		BIT(4)
-#define MT_CT_INFO_FROM_HOST		BIT(7)
-
-#define MT_TXP_MAX_BUF_NUM		6
-
-struct mt7921_txp {
-	__le16 flags;
-	__le16 token;
-	u8 bss_idx;
-	__le16 rept_wds_wcid;
-	u8 nbuf;
-	__le32 buf[MT_TXP_MAX_BUF_NUM];
-	__le16 len[MT_TXP_MAX_BUF_NUM];
-} __packed __aligned(4);
-
 struct mt7921_tx_free {
 	__le16 rx_byte_cnt;
 	__le16 ctrl;
@@ -79,19 +60,6 @@ struct mt7921_tx_free {
 /* will support this field in further revision */
 #define MT_TX_FREE_RATE			GENMASK(13, 0)
 
-static inline struct mt7921_txp_common *
-mt7921_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
-{
-	u8 *txwi;
-
-	if (!t)
-		return NULL;
-
-	txwi = mt76_get_txwi_ptr(dev, t);
-
-	return (struct mt7921_txp_common *)(txwi + MT_TXD_SIZE);
-}
-
 #define MT_HW_TXP_MAX_MSDU_NUM		4
 #define MT_HW_TXP_MAX_BUF_NUM		4
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index b0f58bcf70cb..9608b5ae8820 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -90,7 +90,7 @@ mt7921_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 	struct mt7921_txp_common *txp;
 	int i;
 
-	txp = mt7921_txwi_to_txp(dev, t);
+	txp = mt76_connac_txwi_to_txp(dev, t);
 
 	for (i = 0; i < ARRAY_SIZE(txp->hw.ptr); i++) {
 		struct mt7921_txp_ptr *ptr = &txp->hw.ptr[i];
@@ -275,7 +275,7 @@ void mt7921e_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 		struct mt7921_txp_common *txp;
 		u16 token;
 
-		txp = mt7921_txwi_to_txp(mdev, e->txwi);
+		txp = mt76_connac_txwi_to_txp(mdev, e->txwi);
 		token = le16_to_cpu(txp->hw.msdu_id[0]) & ~MT_MSDU_ID_VALID;
 		t = mt76_token_put(mdev, token);
 		e->skb = t ? t->skb : NULL;
-- 
2.36.1

