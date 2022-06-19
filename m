Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA65550D06
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jun 2022 22:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbiFSUnQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Jun 2022 16:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiFSUnO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Jun 2022 16:43:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398042DC9
        for <linux-wireless@vger.kernel.org>; Sun, 19 Jun 2022 13:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4FD8B80DF9
        for <linux-wireless@vger.kernel.org>; Sun, 19 Jun 2022 20:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424EEC3411D;
        Sun, 19 Jun 2022 20:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655671390;
        bh=aRs6ELVmHaJZ8kqofDWjCK20rfR+adUVZSQVYfAK0SE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJTnfqiApy2/1fXO2hWVYrdT0tnCCZrSTjBQKqQSAKNUmux6Dgsib+RNipvVcMJhY
         bqxrxAICtPC38Wib9rdlTaUgZKmCzFw+F0kJPxZlrb7KO0w7NSuWrNIMTcnK38SG40
         h0I9kuxs1WF/3idmPoq1z9EESj41KD5GEjFEpFTAVk1N11jXQ1cb9fyc7YYomUZ710
         BjVb8OY9Pns3YPH5OSA3/jrk2asFtJtRlmjB2ylP++xdDfFN/GFswjxA0yASyu/LV0
         /688sm7OyIXRuczfQRBIetPdlfAQCMB47D0W770BdcKjmHamjSqzAAYd4iWBQqDKwe
         4khjjVDf97m3g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com
Subject: [PATCH 3/6] mt76: connac: move mt76_connac_tx_free in shared code
Date:   Sun, 19 Jun 2022 22:42:38 +0200
Message-Id: <19c93ff6ad78397478f453bf8b9b065de28405ad.1655649422.git.lorenzo@kernel.org>
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
index 8e051bdae673..dc6b045a5998 100644
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

