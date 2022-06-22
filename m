Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626145554FF
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 21:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376794AbiFVTro (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jun 2022 15:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357349AbiFVTre (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 15:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F152403E3
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 12:47:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 853D961756
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 19:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB03C34114;
        Wed, 22 Jun 2022 19:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655927252;
        bh=e3+xy0eM+FxbViBfuoQSh0QLB2bDBgPLckC53MobN7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=biGjt2yApGwdOkaw1NPSIDD3qT0E6xvpRPsZfl9aKV32m1jppYerzx9LBz9zvGOoB
         bZh+FUx5+T3F/sIGLQ5hO+u8HMrj+HtsMslBvPXeaQQQt9VpKVN2jqKYiIoGnoR6In
         hEtOPYxU9u3jlegN79g/IAaCY/KG6SY+wnrxS2htwAwIiHTNPwYN243Wo+y5nJx9yl
         jYJjvOiaKe/wdz8IQuZLsBTMTNUQa2p3QDViB6nRodko0u7VUiOeRkj4S/Kc3H4Ih/
         fH0T2sRNmFHridYx1WwA5uFDpOtjD4ItMkwauRmO7hRkX4QotIQ7nq9Kg/aydS4SQ7
         xDUKcihnw40AA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com
Subject: [PATCH v2 5/6] mt76: connac: move mt76_connac_write_hw_txp in shared code
Date:   Wed, 22 Jun 2022 21:46:55 +0200
Message-Id: <74bed626f480df40f90758f83ba8130721a975a7.1655926989.git.lorenzo@kernel.org>
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

Now we can move mt76_connac_write_hw_txp routine in mt76-connac module
and reuse it in mt7921e and mt7615e driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |  6 ---
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   | 40 +------------------
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  8 ++++
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 39 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |  5 ---
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   | 33 +--------------
 6 files changed, 49 insertions(+), 82 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index 4cc805f0fea9..880c9f74a7f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -244,12 +244,6 @@ enum tx_phy_bandwidth {
 #define MT_TX_RATE_MODE			GENMASK(8, 6)
 #define MT_TX_RATE_IDX			GENMASK(5, 0)
 
-#define MT_TXD_LEN_MASK			GENMASK(11, 0)
-#define MT_TXD_LEN_MSDU_LAST		BIT(14)
-#define MT_TXD_LEN_AMSDU_LAST		BIT(15)
-/* mt7663 */
-#define MT_TXD_LEN_LAST			BIT(15)
-
 #define MT_TX_FREE_MSDU_ID_CNT		GENMASK(6, 0)
 
 #define MT_TXS0_PID			GENMASK(31, 24)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 9117012b9b1a..05b6669466ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -14,44 +14,6 @@
 #include "../dma.h"
 #include "mac.h"
 
-static void
-mt7615_write_hw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
-		    void *txp_ptr, u32 id)
-{
-	struct mt76_connac_hw_txp *txp = txp_ptr;
-	struct mt76_connac_txp_ptr *ptr = &txp->ptr[0];
-	int i, nbuf = tx_info->nbuf - 1;
-	u32 last_mask;
-
-	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
-	tx_info->nbuf = 1;
-
-	txp->msdu_id[0] = cpu_to_le16(id | MT_MSDU_ID_VALID);
-
-	if (is_mt7663(&dev->mt76))
-		last_mask = MT_TXD_LEN_LAST;
-	else
-		last_mask = MT_TXD_LEN_AMSDU_LAST |
-			    MT_TXD_LEN_MSDU_LAST;
-
-	for (i = 0; i < nbuf; i++) {
-		u16 len = tx_info->buf[i + 1].len & MT_TXD_LEN_MASK;
-		u32 addr = tx_info->buf[i + 1].addr;
-
-		if (i == nbuf - 1)
-			len |= last_mask;
-
-		if (i & 1) {
-			ptr->buf1 = cpu_to_le32(addr);
-			ptr->len1 = cpu_to_le16(len);
-			ptr++;
-		} else {
-			ptr->buf0 = cpu_to_le32(addr);
-			ptr->len0 = cpu_to_le16(len);
-		}
-	}
-}
-
 static void
 mt7615_write_fw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
 		    void *txp_ptr, u32 id)
@@ -141,7 +103,7 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (is_mt7615(&dev->mt76))
 		mt7615_write_fw_txp(dev, tx_info, txp, id);
 	else
-		mt7615_write_hw_txp(dev, tx_info, txp, id);
+		mt76_connac_write_hw_txp(mdev, tx_info, txp, id);
 
 	tx_info->skb = DMA_DUMMY_DATA;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index da41ad6c87fe..9f4323de3a8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -29,6 +29,11 @@
 
 #define MT_MSDU_ID_VALID		BIT(15)
 
+#define MT_TXD_LEN_LAST			BIT(15)
+#define MT_TXD_LEN_MASK			GENMASK(11, 0)
+#define MT_TXD_LEN_MSDU_LAST		BIT(14)
+#define MT_TXD_LEN_AMSDU_LAST		BIT(15)
+
 enum {
 	CMD_CBW_20MHZ = IEEE80211_STA_RX_BW_20,
 	CMD_CBW_40MHZ = IEEE80211_STA_RX_BW_40,
@@ -319,6 +324,9 @@ mt76_connac_mutex_release(struct mt76_dev *dev, struct mt76_connac_pm *pm)
 	mutex_unlock(&dev->mutex);
 }
 
+void mt76_connac_write_hw_txp(struct mt76_dev *dev,
+			      struct mt76_tx_info *tx_info,
+			      void *txp_ptr, u32 id);
 void mt76_connac_tx_complete_skb(struct mt76_dev *mdev,
 				 struct mt76_queue_entry *e);
 void mt76_connac_pm_queue_skb(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 134daa9103a2..9bba5dcbe0c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -152,6 +152,45 @@ void mt76_connac_tx_complete_skb(struct mt76_dev *mdev,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_tx_complete_skb);
 
+void mt76_connac_write_hw_txp(struct mt76_dev *dev,
+			      struct mt76_tx_info *tx_info,
+			      void *txp_ptr, u32 id)
+{
+	struct mt76_connac_hw_txp *txp = txp_ptr;
+	struct mt76_connac_txp_ptr *ptr = &txp->ptr[0];
+	int i, nbuf = tx_info->nbuf - 1;
+	u32 last_mask;
+
+	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
+	tx_info->nbuf = 1;
+
+	txp->msdu_id[0] = cpu_to_le16(id | MT_MSDU_ID_VALID);
+
+	if (is_mt7663(dev) || is_mt7921(dev))
+		last_mask = MT_TXD_LEN_LAST;
+	else
+		last_mask = MT_TXD_LEN_AMSDU_LAST |
+			    MT_TXD_LEN_MSDU_LAST;
+
+	for (i = 0; i < nbuf; i++) {
+		u16 len = tx_info->buf[i + 1].len & MT_TXD_LEN_MASK;
+		u32 addr = tx_info->buf[i + 1].addr;
+
+		if (i == nbuf - 1)
+			len |= last_mask;
+
+		if (i & 1) {
+			ptr->buf1 = cpu_to_le32(addr);
+			ptr->len1 = cpu_to_le16(len);
+			ptr++;
+		} else {
+			ptr->buf0 = cpu_to_le32(addr);
+			ptr->len0 = cpu_to_le16(len);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_connac_write_hw_txp);
+
 static u16
 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 			     bool beacon, bool mcast)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index a2e9e1bae859..b8cabeb796b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -52,11 +52,6 @@ enum tx_mcu_port_q_idx {
 /* will support this field in further revision */
 #define MT_TX_FREE_RATE			GENMASK(13, 0)
 
-#define MT_TXD_LEN_MASK			GENMASK(11, 0)
-#define MT_TXD_LEN_MSDU_LAST		BIT(14)
-#define MT_TXD_LEN_AMSDU_LAST		BIT(15)
-#define MT_TXD_LEN_LAST			BIT(15)
-
 #define MT_WTBL_TXRX_CAP_RATE_OFFSET	7
 #define MT_WTBL_TXRX_RATE_G2_HE		24
 #define MT_WTBL_TXRX_RATE_G2		12
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 75e5dc4e6f84..368f114dc60c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -5,37 +5,6 @@
 #include "../dma.h"
 #include "mac.h"
 
-static void
-mt7921_write_hw_txp(struct mt7921_dev *dev, struct mt76_tx_info *tx_info,
-		    void *txp_ptr, u32 id)
-{
-	struct mt76_connac_hw_txp *txp = txp_ptr;
-	struct mt76_connac_txp_ptr *ptr = &txp->ptr[0];
-	int i, nbuf = tx_info->nbuf - 1;
-
-	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
-	tx_info->nbuf = 1;
-
-	txp->msdu_id[0] = cpu_to_le16(id | MT_MSDU_ID_VALID);
-
-	for (i = 0; i < nbuf; i++) {
-		u16 len = tx_info->buf[i + 1].len & MT_TXD_LEN_MASK;
-		u32 addr = tx_info->buf[i + 1].addr;
-
-		if (i == nbuf - 1)
-			len |= MT_TXD_LEN_LAST;
-
-		if (i & 1) {
-			ptr->buf1 = cpu_to_le32(addr);
-			ptr->len1 = cpu_to_le16(len);
-			ptr++;
-		} else {
-			ptr->buf0 = cpu_to_le32(addr);
-			ptr->len0 = cpu_to_le16(len);
-		}
-	}
-}
-
 int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			   struct ieee80211_sta *sta,
@@ -77,7 +46,7 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 	txp = (struct mt76_connac_hw_txp *)(txwi + MT_TXD_SIZE);
 	memset(txp, 0, sizeof(struct mt76_connac_hw_txp));
-	mt7921_write_hw_txp(dev, tx_info, txp, id);
+	mt76_connac_write_hw_txp(mdev, tx_info, txp, id);
 
 	tx_info->skb = DMA_DUMMY_DATA;
 
-- 
2.36.1

