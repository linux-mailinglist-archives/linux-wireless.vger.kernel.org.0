Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B42E614DD19
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 15:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgA3Orc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 09:47:32 -0500
Received: from nbd.name ([46.4.11.11]:57432 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgA3OrV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 09:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UIDh2EmmPmcE8+8YJVeVox3FcGUP2G4ICyDlt2cvFmA=; b=YeAHJswk2PnQEBRVlRTsnDN8Ct
        md7YWP/s6MfHTKN2WDbZLo2t6d3n8eK2+KZrIpMOXEcxrjaGxkUIFYeOtoO+Ad+7+eUWHJPOWOk5D
        UlISHY1vjZ/GOOejUeKRH3suYEcEdvlwfBZCAKkSbIayp78T8OKsvqFRUt+yV8lX1Ho0=;
Received: from [178.162.209.135] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ixB6F-0001VN-Kd
        for linux-wireless@vger.kernel.org; Thu, 30 Jan 2020 15:47:19 +0100
Received: by maeck.local (Postfix, from userid 501)
        id EC4997AE468D; Thu, 30 Jan 2020 15:47:18 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 12/15] mt76: mt7615: implement DMA support for MT7622
Date:   Thu, 30 Jan 2020 15:47:15 +0100
Message-Id: <20200130144718.14298-12-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130144718.14298-1-nbd@nbd.name>
References: <20200130144718.14298-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MT7622 does not have the CR4 microcontroller sitting in the data path.
Because of that, it uses the chip's native tx descriptor format instead of
something parsed and converted by the firmware.

Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   5 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 221 +++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |  32 ++-
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |   2 +-
 4 files changed, 200 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index df6ef323f7a2..79b177ac4261 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -346,7 +346,10 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
 
-	hw->max_tx_fragments = MT_TXP_MAX_BUF_NUM;
+	if (is_mt7615(&phy->dev->mt76))
+		hw->max_tx_fragments = MT_TXP_MAX_BUF_NUM;
+	else
+		hw->max_tx_fragments = MT_HW_TXP_MAX_BUF_NUM;
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 49924d502daa..c4fea7227cee 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -396,13 +396,20 @@ void mt7615_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
 	if (e->skb == DMA_DUMMY_DATA) {
 		struct mt76_txwi_cache *t;
 		struct mt7615_dev *dev;
-		struct mt7615_txp *txp;
+		struct mt7615_txp_common *txp;
+		u16 token;
 
 		dev = container_of(mdev, struct mt7615_dev, mt76);
 		txp = mt7615_txwi_to_txp(mdev, e->txwi);
 
+		if (is_mt7615(&dev->mt76))
+			token = le16_to_cpu(txp->fw.token);
+		else
+			token = le16_to_cpu(txp->hw.msdu_id[0]) &
+				~MT_MSDU_ID_VALID;
+
 		spin_lock_bh(&dev->token_lock);
-		t = idr_remove(&dev->token, le16_to_cpu(txp->token));
+		t = idr_remove(&dev->token, token);
 		spin_unlock_bh(&dev->token_lock);
 		e->skb = t ? t->skb : NULL;
 	}
@@ -621,18 +628,56 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	return 0;
 }
 
-void mt7615_txp_skb_unmap(struct mt76_dev *dev,
-			  struct mt76_txwi_cache *t)
+static void
+mt7615_txp_skb_unmap_fw(struct mt76_dev *dev, struct mt7615_fw_txp *txp)
 {
-	struct mt7615_txp *txp;
 	int i;
 
-	txp = mt7615_txwi_to_txp(dev, t);
 	for (i = 1; i < txp->nbuf; i++)
 		dma_unmap_single(dev->dev, le32_to_cpu(txp->buf[i]),
 				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
 }
 
+static void
+mt7615_txp_skb_unmap_hw(struct mt76_dev *dev, struct mt7615_hw_txp *txp)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(txp->ptr); i++) {
+		struct mt7615_txp_ptr *ptr = &txp->ptr[i];
+		bool last;
+		u16 len;
+
+		len = le16_to_cpu(ptr->len0);
+		last = len & MT_TXD_LEN_MSDU_LAST;
+		len &= ~MT_TXD_LEN_MSDU_LAST;
+		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf0), len,
+				 DMA_TO_DEVICE);
+		if (last)
+			break;
+
+		len = le16_to_cpu(ptr->len1);
+		last = len & MT_TXD_LEN_MSDU_LAST;
+		len &= ~MT_TXD_LEN_MSDU_LAST;
+		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf1), len,
+				 DMA_TO_DEVICE);
+		if (last)
+			break;
+	}
+}
+
+void mt7615_txp_skb_unmap(struct mt76_dev *dev,
+			  struct mt76_txwi_cache *t)
+{
+	struct mt7615_txp_common *txp;
+
+	txp = mt7615_txwi_to_txp(dev, t);
+	if (is_mt7615(dev))
+		mt7615_txp_skb_unmap_fw(dev, &txp->fw);
+	else
+		mt7615_txp_skb_unmap_hw(dev, &txp->hw);
+}
+
 static u32 mt7615_mac_wtbl_addr(int wcid)
 {
 	return MT_WTBL_BASE + wcid * MT_WTBL_ENTRY_SIZE;
@@ -1022,44 +1067,51 @@ int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
 	return err;
 }
 
-int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
-			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
-			  struct ieee80211_sta *sta,
-			  struct mt76_tx_info *tx_info)
+static void
+mt7615_write_hw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
+		    void *txp_ptr, u32 id)
 {
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx_info->skb->data;
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	struct mt7615_sta *msta = container_of(wcid, struct mt7615_sta, wcid);
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
-	struct ieee80211_key_conf *key = info->control.hw_key;
-	struct ieee80211_vif *vif = info->control.vif;
-	int i, pid, id, nbuf = tx_info->nbuf - 1;
-	u8 *txwi = (u8 *)txwi_ptr;
-	struct mt76_txwi_cache *t;
-	struct mt7615_txp *txp;
+	struct mt7615_hw_txp *txp = txp_ptr;
+	struct mt7615_txp_ptr *ptr = &txp->ptr[0];
+	int nbuf = tx_info->nbuf - 1;
+	int i;
 
-	if (!wcid)
-		wcid = &dev->mt76.global_wcid;
+	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
+	tx_info->nbuf = 1;
 
-	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
+	txp->msdu_id[0] = id | MT_MSDU_ID_VALID;
 
-	if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) {
-		struct mt7615_phy *phy = &dev->phy;
+	for (i = 0; i < nbuf; i++) {
+		u32 addr = tx_info->buf[i + 1].addr;
+		u16 len = tx_info->buf[i + 1].len;
 
-		if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && mdev->phy2)
-			phy = mdev->phy2->priv;
+		if (i == nbuf - 1)
+			len |= MT_TXD_LEN_MSDU_LAST |
+			       MT_TXD_LEN_AMSDU_LAST;
 
-		spin_lock_bh(&dev->mt76.lock);
-		mt7615_mac_set_rates(phy, msta, &info->control.rates[0],
-				     msta->rates);
-		msta->rate_probe = true;
-		spin_unlock_bh(&dev->mt76.lock);
+		if (i & 1) {
+			ptr->buf1 = cpu_to_le32(addr);
+			ptr->len1 = cpu_to_le16(len);
+			ptr++;
+		} else {
+			ptr->buf0 = cpu_to_le32(addr);
+			ptr->len0 = cpu_to_le16(len);
+		}
 	}
+}
 
-	mt7615_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, sta,
-			      pid, key);
+static void
+mt7615_write_fw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
+		    void *txp_ptr, u32 id)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx_info->skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	struct ieee80211_vif *vif = info->control.vif;
+	struct mt7615_fw_txp *txp = txp_ptr;
+	int nbuf = tx_info->nbuf - 1;
+	int i;
 
-	txp = (struct mt7615_txp *)(txwi + MT_TXD_SIZE);
 	for (i = 0; i < nbuf; i++) {
 		txp->buf[i] = cpu_to_le32(tx_info->buf[i + 1].addr);
 		txp->len[i] = cpu_to_le16(tx_info->buf[i + 1].len);
@@ -1067,6 +1119,7 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	txp->nbuf = nbuf;
 
 	/* pass partial skb header to fw */
+	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
 	tx_info->buf[1].len = MT_CT_PARSE_LEN;
 	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
 
@@ -1084,6 +1137,42 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		txp->bss_idx = mvif->idx;
 	}
 
+	txp->token = cpu_to_le16(id);
+	txp->rept_wds_wcid = 0xff;
+}
+
+int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			  struct ieee80211_sta *sta,
+			  struct mt76_tx_info *tx_info)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	struct mt7615_sta *msta = container_of(wcid, struct mt7615_sta, wcid);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	int pid, id;
+	u8 *txwi = (u8 *)txwi_ptr;
+	struct mt76_txwi_cache *t;
+	void *txp;
+
+	if (!wcid)
+		wcid = &dev->mt76.global_wcid;
+
+	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
+
+	if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) {
+		struct mt7615_phy *phy = &dev->phy;
+
+		if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && mdev->phy2)
+			phy = mdev->phy2->priv;
+
+		spin_lock_bh(&dev->mt76.lock);
+		mt7615_mac_set_rates(phy, msta, &info->control.rates[0],
+				     msta->rates);
+		msta->rate_probe = true;
+		spin_unlock_bh(&dev->mt76.lock);
+	}
+
 	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
 	t->skb = tx_info->skb;
 
@@ -1093,8 +1182,16 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (id < 0)
 		return id;
 
-	txp->token = cpu_to_le16(id);
-	txp->rept_wds_wcid = 0xff;
+	mt7615_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, sta,
+			      pid, key);
+
+	txp = txwi + MT_TXD_SIZE;
+	memset(txp, 0, sizeof(struct mt7615_txp_common));
+	if (is_mt7615(&dev->mt76))
+		mt7615_write_fw_txp(dev, tx_info, txp, id);
+	else
+		mt7615_write_hw_txp(dev, tx_info, txp, id);
+
 	tx_info->skb = DMA_DUMMY_DATA;
 
 	return 0;
@@ -1330,34 +1427,48 @@ void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 	rcu_read_unlock();
 }
 
-void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
+static void
+mt7615_mac_tx_free_token(struct mt7615_dev *dev, u16 token)
 {
-	struct mt7615_tx_free *free = (struct mt7615_tx_free *)skb->data;
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_txwi_cache *txwi;
-	u8 i, count;
 
-	count = FIELD_GET(MT_TX_FREE_MSDU_ID_CNT, le16_to_cpu(free->ctrl));
-	for (i = 0; i < count; i++) {
-		u16 token = le16_to_cpu(free->token[i]);
+	trace_mac_tx_free(dev, token);
 
-		spin_lock_bh(&dev->token_lock);
-		txwi = idr_remove(&dev->token, token);
-		spin_unlock_bh(&dev->token_lock);
+	spin_lock_bh(&dev->token_lock);
+	txwi = idr_remove(&dev->token, token);
+	spin_unlock_bh(&dev->token_lock);
 
-		if (!txwi)
-			continue;
+	if (!txwi)
+		return;
+
+	mt7615_txp_skb_unmap(mdev, txwi);
+	if (txwi->skb) {
+		mt76_tx_complete_skb(mdev, txwi->skb);
+		txwi->skb = NULL;
+	}
 
-		trace_mac_tx_free(dev, token);
+	mt76_put_txwi(mdev, txwi);
+}
 
-		mt7615_txp_skb_unmap(mdev, txwi);
-		if (txwi->skb) {
-			mt76_tx_complete_skb(mdev, txwi->skb);
-			txwi->skb = NULL;
-		}
+void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
+{
+	struct mt7615_tx_free *free = (struct mt7615_tx_free *)skb->data;
+	u8 i, count;
+
+	count = FIELD_GET(MT_TX_FREE_MSDU_ID_CNT, le16_to_cpu(free->ctrl));
+	if (is_mt7615(&dev->mt76)) {
+		__le16 *token = &free->token[0];
+
+		for (i = 0; i < count; i++)
+			mt7615_mac_tx_free_token(dev, le16_to_cpu(token[i]));
+	} else {
+		__le32 *token = (__le32 *)&free->token[0];
 
-		mt76_put_txwi(mdev, txwi);
+		for (i = 0; i < count; i++)
+			mt7615_mac_tx_free_token(dev, le32_to_cpu(token[i]));
 	}
+
 	dev_kfree_skb(skb);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index 9b7c45bf1ec5..bf12eba549f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -233,8 +233,27 @@ enum tx_phy_bandwidth {
 #define MT_TX_RATE_IDX			GENMASK(5, 0)
 
 #define MT_TXP_MAX_BUF_NUM		6
+#define MT_HW_TXP_MAX_MSDU_NUM		4
+#define MT_HW_TXP_MAX_BUF_NUM		4
 
-struct mt7615_txp {
+#define MT_MSDU_ID_VALID		BIT(15)
+
+#define MT_TXD_LEN_MSDU_LAST		BIT(14)
+#define MT_TXD_LEN_AMSDU_LAST		BIT(15)
+
+struct mt7615_txp_ptr {
+	__le32 buf0;
+	__le16 len0;
+	__le16 len1;
+	__le32 buf1;
+} __packed __aligned(4);
+
+struct mt7615_hw_txp {
+	__le16 msdu_id[MT_HW_TXP_MAX_MSDU_NUM];
+	struct mt7615_txp_ptr ptr[MT_HW_TXP_MAX_BUF_NUM / 2];
+} __packed __aligned(4);
+
+struct mt7615_fw_txp {
 	__le16 flags;
 	__le16 token;
 	u8 bss_idx;
@@ -245,6 +264,13 @@ struct mt7615_txp {
 	__le16 len[MT_TXP_MAX_BUF_NUM];
 } __packed __aligned(4);
 
+struct mt7615_txp_common {
+	union {
+		struct mt7615_fw_txp fw;
+		struct mt7615_hw_txp hw;
+	};
+};
+
 struct mt7615_tx_free {
 	__le16 rx_byte_cnt;
 	__le16 ctrl;
@@ -353,7 +379,7 @@ enum mt7615_cipher_type {
 	MT_CIPHER_GCMP_256,
 };
 
-static inline struct mt7615_txp *
+static inline struct mt7615_txp_common *
 mt7615_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 {
 	u8 *txwi;
@@ -363,7 +389,7 @@ mt7615_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 
 	txwi = mt76_get_txwi_ptr(dev, t);
 
-	return (struct mt7615_txp *)(txwi + MT_TXD_SIZE);
+	return (struct mt7615_txp_common *)(txwi + MT_TXD_SIZE);
 }
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index 4575bfda81c0..fcd8a8b4e816 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -60,7 +60,7 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base, int irq)
 {
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
-		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7615_txp),
+		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7615_txp_common),
 		.drv_flags = MT_DRV_TXWI_NO_FREE,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
-- 
2.24.0

