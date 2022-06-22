Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CDB5554FE
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 21:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376786AbiFVTrn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jun 2022 15:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376741AbiFVTrb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 15:47:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211F93FD96
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 12:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD00F612E6
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 19:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A81C34114;
        Wed, 22 Jun 2022 19:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655927249;
        bh=ppVPYEWkycQxWB7pQSUyIzkCV+7utOIuXEiEZODCMuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDl1FJYH5W7aB0+gnSr0LTEYevhygANNqCmZ49La18oK+gdtMnEUDKULSHpPIdH6U
         LgNE1DO5+RSOFFdMyDYEnZ1sOlnuJT6NRDwMKvk9dHE2GeA72OO9KJkpBpqKb2hFS8
         lq1UxiJnSmEyT+teb3w6VSFkZoWd8ADj2myNpJrdh9DZ2LtNjnOmAnlxrs8kbiw3jC
         zTEj6Z/abeOU5UHgmIKCnBvocBY/LPDshouRdxX2Nvk0E6qQOnom9zprbmeBouR6D2
         2E9A5ZBiDYqIyaDDjhT8FthUxeCHV2lWwBAJCZdepSUpnox1X1bSLh5KwJ2PQCkhNA
         v5toKioKuSIYA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com
Subject: [PATCH v2 3/6] mt76: connac: move mt76_connac_tx_free in shared code
Date:   Wed, 22 Jun 2022 21:46:53 +0200
Message-Id: <57ce64c0fe5c006d8bcc84a6078cc14780aa7078.1655926989.git.lorenzo@kernel.org>
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

Move mt76_connac_tx_free structure in mt76_connac module since it is
shared by mt7615 and mt7921 drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c     | 7 ++++---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h     | 8 --------
 drivers/net/wireless/mediatek/mt76/mt76_connac.h    | 7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mac.h     | 8 --------
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c | 7 ++++---
 5 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index de809cbf0733..06d17e07034d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1638,7 +1638,8 @@ mt7615_mac_tx_free_token(struct mt7615_dev *dev, u16 token)
 
 static void mt7615_mac_tx_free(struct mt7615_dev *dev, void *data, int len)
 {
-	struct mt7615_tx_free *free = (struct mt7615_tx_free *)data;
+	struct mt76_connac_tx_free *free = data;
+	void *tx_token = data + sizeof(*free);
 	void *end = data + len;
 	u8 i, count;
 
@@ -1652,7 +1653,7 @@ static void mt7615_mac_tx_free(struct mt7615_dev *dev, void *data, int len)
 
 	count = le16_get_bits(free->ctrl, MT_TX_FREE_MSDU_ID_CNT);
 	if (is_mt7615(&dev->mt76)) {
-		__le16 *token = &free->token[0];
+		__le16 *token = tx_token;
 
 		if (WARN_ON_ONCE((void *)&token[count] > end))
 			return;
@@ -1660,7 +1661,7 @@ static void mt7615_mac_tx_free(struct mt7615_dev *dev, void *data, int len)
 		for (i = 0; i < count; i++)
 			mt7615_mac_tx_free_token(dev, le16_to_cpu(token[i]));
 	} else {
-		__le32 *token = (__le32 *)&free->token[0];
+		__le32 *token = tx_token;
 
 		if (WARN_ON_ONCE((void *)&token[count] > end))
 			return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index 310c187a1a29..6af15f2e0f5a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -252,14 +252,6 @@ enum tx_phy_bandwidth {
 /* mt7663 */
 #define MT_TXD_LEN_LAST			BIT(15)
 
-struct mt7615_tx_free {
-	__le16 rx_byte_cnt;
-	__le16 ctrl;
-	u8 txd_cnt;
-	u8 rsv[3];
-	__le16 token[];
-} __packed __aligned(4);
-
 #define MT_TX_FREE_MSDU_ID_CNT		GENMASK(6, 0)
 
 #define MT_TXS0_PID			GENMASK(31, 24)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 4357fea1d79b..0ef10895fbf8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -136,6 +136,13 @@ struct mt76_connac_txp_common {
 	};
 };
 
+struct mt76_connac_tx_free {
+	__le16 rx_byte_cnt;
+	__le16 ctrl;
+	u8 txd_cnt;
+	u8 rsv[3];
+} __packed __aligned(4);
+
 extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
 static inline bool is_mt7922(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index dc98d2c82988..26b1ec35cc2b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -42,14 +42,6 @@ enum tx_mcu_port_q_idx {
 	MT_TX_MCU_PORT_RX_FWDL = 0x3e
 };
 
-struct mt7921_tx_free {
-	__le16 rx_byte_cnt;
-	__le16 ctrl;
-	u8 txd_cnt;
-	u8 rsv[3];
-	__le32 info[];
-} __packed __aligned(4);
-
 #define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
 #define MT_TX_FREE_WLAN_ID		GENMASK(23, 14)
 #define MT_TX_FREE_LATENCY		GENMASK(12, 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index bf58dcf1b980..333390cb791b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -150,7 +150,8 @@ mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
 static void
 mt7921e_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
 {
-	struct mt7921_tx_free *free = (struct mt7921_tx_free *)data;
+	struct mt76_connac_tx_free *free = data;
+	__le32 *tx_info = (__le32 *)(data + sizeof(*free));
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_txwi_cache *txwi;
 	struct ieee80211_sta *sta = NULL;
@@ -165,11 +166,11 @@ mt7921e_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
 	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
 
 	count = le16_get_bits(free->ctrl, MT_TX_FREE_MSDU_CNT);
-	if (WARN_ON_ONCE((void *)&free->info[count] > end))
+	if (WARN_ON_ONCE((void *)&tx_info[count] > end))
 		return;
 
 	for (i = 0; i < count; i++) {
-		u32 msdu, info = le32_to_cpu(free->info[i]);
+		u32 msdu, info = le32_to_cpu(tx_info[i]);
 		u8 stat;
 
 		/* 1'b1: new wcid pair.
-- 
2.36.1

