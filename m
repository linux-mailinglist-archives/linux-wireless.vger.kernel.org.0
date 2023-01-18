Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E8E672367
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 17:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjARQdq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 11:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjARQdD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 11:33:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A2C402C3
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 08:31:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26DC3B81DA5
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 16:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C039C433EF;
        Wed, 18 Jan 2023 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674059460;
        bh=J/cAza+SQGR663qE8LOSK3YFjrQu4yBzWxUcefdGPO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWvlK8q9ckXOmjKbmRm+lJp/3UWvXxirj+ANxTxnkFDzBnOM/xI/17RQwoCVWBHev
         2M70UGm7Wyj2wNQoBJPtSo95ECF+lY6xlHBN1qIjtfkcS24/1l3Y+dcMsZkyflsLGo
         H9WVBLge5l3xPKUqUfQhgnoyycD/fH/hhHvlE+h4XW4jpvii/RkOQlDhzQH74tEzT6
         c2mirMIXtKhDFFKKGXynYs4tCD0ujiGlEJDjTyWFRRYxXSQJpxIdJiYVdOyHcNAaZT
         Xdc9CtSIlchSwzNStd/GJsyOCXxrVIL/2gvMMsG84aOEjWErtGE7UIAt1aKpim+bx+
         C4klUY2e1f7Jg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 1/4] wifi: mt76: mt7996: rely on mt76_connac_txp_common structure
Date:   Wed, 18 Jan 2023 17:30:38 +0100
Message-Id: <4b7bad8cbc4a7f4d52151d420fe1c2e903fb369c.1674059222.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1674059222.git.lorenzo@kernel.org>
References: <cover.1674059222.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7996_txp structure is equal to mt76_connac_fw_txp one. Drop mt7996_txp
and rely on mt76_connac_txp_common.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 38 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7996/mac.h   | 15 +-------
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  2 +-
 3 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 797dd920c0dd..4e4b596ea37d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1069,8 +1069,8 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	struct ieee80211_vif *vif = info->control.vif;
+	struct mt76_connac_txp_common *txp;
 	struct mt76_txwi_cache *t;
-	struct mt7996_txp *txp;
 	int id, i, pid, nbuf = tx_info->nbuf - 1;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
 	u8 *txwi = (u8 *)txwi_ptr;
@@ -1104,35 +1104,35 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, pid,
 				      key, 0);
 
-	txp = (struct mt7996_txp *)(txwi + MT_TXD_SIZE);
+	txp = (struct mt76_connac_txp_common *)(txwi + MT_TXD_SIZE);
 	for (i = 0; i < nbuf; i++) {
-		txp->buf[i] = cpu_to_le32(tx_info->buf[i + 1].addr);
-		txp->len[i] = cpu_to_le16(tx_info->buf[i + 1].len);
+		txp->fw.buf[i] = cpu_to_le32(tx_info->buf[i + 1].addr);
+		txp->fw.len[i] = cpu_to_le16(tx_info->buf[i + 1].len);
 	}
-	txp->nbuf = nbuf;
+	txp->fw.nbuf = nbuf;
 
-	txp->flags = cpu_to_le16(MT_CT_INFO_FROM_HOST);
+	txp->fw.flags = cpu_to_le16(MT_CT_INFO_FROM_HOST);
 
 	if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
-		txp->flags |= cpu_to_le16(MT_CT_INFO_APPLY_TXD);
+		txp->fw.flags |= cpu_to_le16(MT_CT_INFO_APPLY_TXD);
 
 	if (!key)
-		txp->flags |= cpu_to_le16(MT_CT_INFO_NONE_CIPHER_FRAME);
+		txp->fw.flags |= cpu_to_le16(MT_CT_INFO_NONE_CIPHER_FRAME);
 
 	if (!is_8023 && ieee80211_is_mgmt(hdr->frame_control))
-		txp->flags |= cpu_to_le16(MT_CT_INFO_MGMT_FRAME);
+		txp->fw.flags |= cpu_to_le16(MT_CT_INFO_MGMT_FRAME);
 
 	if (vif) {
 		struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 
-		txp->bss_idx = mvif->mt76.idx;
+		txp->fw.bss_idx = mvif->mt76.idx;
 	}
 
-	txp->token = cpu_to_le16(id);
+	txp->fw.token = cpu_to_le16(id);
 	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags))
-		txp->rept_wds_wcid = cpu_to_le16(wcid->idx);
+		txp->fw.rept_wds_wcid = cpu_to_le16(wcid->idx);
 	else
-		txp->rept_wds_wcid = cpu_to_le16(0xfff);
+		txp->fw.rept_wds_wcid = cpu_to_le16(0xfff);
 	tx_info->skb = DMA_DUMMY_DATA;
 
 	/* pass partial skb header to fw */
@@ -1171,13 +1171,13 @@ mt7996_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 static void
 mt7996_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 {
-	struct mt7996_txp *txp;
+	struct mt76_connac_txp_common *txp;
 	int i;
 
 	txp = mt7996_txwi_to_txp(dev, t);
-	for (i = 0; i < txp->nbuf; i++)
-		dma_unmap_single(dev->dev, le32_to_cpu(txp->buf[i]),
-				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
+	for (i = 0; i < txp->fw.nbuf; i++)
+		dma_unmap_single(dev->dev, le32_to_cpu(txp->fw.buf[i]),
+				 le16_to_cpu(txp->fw.len[i]), DMA_TO_DEVICE);
 }
 
 static void
@@ -1554,11 +1554,11 @@ void mt7996_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 
 	/* error path */
 	if (e->skb == DMA_DUMMY_DATA) {
+		struct mt76_connac_txp_common *txp;
 		struct mt76_txwi_cache *t;
-		struct mt7996_txp *txp;
 
 		txp = mt7996_txwi_to_txp(mdev, e->txwi);
-		t = mt76_token_put(mdev, le16_to_cpu(txp->token));
+		t = mt76_token_put(mdev, le16_to_cpu(txp->fw.token));
 		e->skb = t ? t->skb : NULL;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
index 9f68852012b9..10e08d66d474 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
@@ -268,17 +268,6 @@ enum tx_mgnt_type {
 /* VHT/HE only use bits 0-3 */
 #define MT_TX_RATE_IDX			GENMASK(5, 0)
 
-struct mt7996_txp {
-	__le16 flags;
-	__le16 token;
-	u8 bss_idx;
-	__le16 rept_wds_wcid;
-	u8 nbuf;
-#define MT_TXP_MAX_BUF_NUM	6
-	__le32 buf[MT_TXP_MAX_BUF_NUM];
-	__le16 len[MT_TXP_MAX_BUF_NUM];
-} __packed __aligned(4);
-
 #define MT_TXFREE0_PKT_TYPE		GENMASK(31, 27)
 #define MT_TXFREE0_MSDU_CNT		GENMASK(25, 16)
 #define MT_TXFREE0_RX_BYTE		GENMASK(15, 0)
@@ -382,7 +371,7 @@ struct mt7996_dfs_radar_spec {
 	struct mt7996_dfs_pattern radar_pattern[16];
 };
 
-static inline struct mt7996_txp *
+static inline struct mt76_connac_txp_common *
 mt7996_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 {
 	u8 *txwi;
@@ -392,7 +381,7 @@ mt7996_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 
 	txwi = mt76_get_txwi_ptr(dev, t);
 
-	return (struct mt7996_txp *)(txwi + MT_TXD_SIZE);
+	return (struct mt76_connac_txp_common *)(txwi + MT_TXD_SIZE);
 }
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 60781d046216..011a55622770 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -317,7 +317,7 @@ struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
 {
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
-		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7996_txp),
+		.txwi_size = MT_TXD_SIZE + sizeof(struct mt76_connac_fw_txp),
 		.drv_flags = MT_DRV_TXWI_NO_FREE |
 			     MT_DRV_HW_MGMT_TXQ,
 		.survey_flags = SURVEY_INFO_TIME_TX |
-- 
2.39.0

