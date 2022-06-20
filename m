Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98AE551916
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jun 2022 14:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242765AbiFTMh7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jun 2022 08:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242763AbiFTMhz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jun 2022 08:37:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB93F05
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 05:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60D15B81148
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 12:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C51C3411C;
        Mon, 20 Jun 2022 12:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655728668;
        bh=WFQm2GDq1ez5G3gthhhMcc3FDFkHEWGCzYkwvQFsKVs=;
        h=From:To:Cc:Subject:Date:From;
        b=jWiEhElZRJCEXHt/ULI4LgAYE02Yjb5ghaVeijSvxIEhm6yp+/cQutPy5C48ZvGFw
         7tAcJ5ThGnW344cQ0BCsqN9os+6qMQHfOjrH19lBua7rBakWa9GmeaWsFwhRXaytIa
         kVl6w+KIWfHyRJgWy01M0SO391eZTnoA0crh8Lm5kRN1Q5aMZzJNw0kBiXZF5TV9o8
         bCk+ji8cfsRmPPBCnarRBmERwCTLNkYLcsTMh5mHi/hm8tV2q8IKSB3sZWTu4TyI1h
         NCHfYDDrmQxKRKYp5X2MpUVRFthjlLdd7gHhWEHTIUqJYPa3GQrFIRUGmEkWn9cbEC
         NQBHsDiwIBlcg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7915: rely on mt76_connac_tx_free
Date:   Mon, 20 Jun 2022 14:37:34 +0200
Message-Id: <a3d2b7d7d4cd4b056868cafd6bfe0ebfb3e5afdc.1655728498.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
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

As for mt7921 and mt7615 drivers, rely on mt76_connac_tx_free data
structure in mt7915e driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch is based on the series below:
https://patchwork.kernel.org/project/linux-wireless/cover/cover.1655649421.git.lorenzo@kernel.org/
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h |  3 +--
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c  | 11 ++++++-----
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h  |  8 --------
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 9f4323de3a8b..c974abfccfba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -146,8 +146,7 @@ struct mt76_connac_txp_common {
 struct mt76_connac_tx_free {
 	__le16 rx_byte_cnt;
 	__le16 ctrl;
-	u8 txd_cnt;
-	u8 rsv[3];
+	__le32 txd;
 } __packed __aligned(4);
 
 extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 719b11e2e57c..552be0e5a309 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -896,7 +896,8 @@ mt7915_mac_tx_free_done(struct mt7915_dev *dev,
 static void
 mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 {
-	struct mt7915_tx_free *free = (struct mt7915_tx_free *)data;
+	struct mt76_connac_tx_free *free = data;
+	__le32 *tx_info = (__le32 *)(data + sizeof(*free));
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_txwi_cache *txwi;
 	struct ieee80211_sta *sta = NULL;
@@ -911,10 +912,10 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 
 	total = le16_get_bits(free->ctrl, MT_TX_FREE_MSDU_CNT);
 	v3 = (FIELD_GET(MT_TX_FREE_VER, txd) == 0x4);
-	if (WARN_ON_ONCE((void *)&free->info[total >> v3] > end))
+	if (WARN_ON_ONCE((void *)&tx_info[total >> v3] > end))
 		return;
 
-	for (cur_info = &free->info[0]; count < total; cur_info++) {
+	for (cur_info = tx_info; count < total; cur_info++) {
 		u32 msdu, info = le32_to_cpu(*cur_info);
 		u8 i;
 
@@ -967,9 +968,9 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 static void
 mt7915_mac_tx_free_v0(struct mt7915_dev *dev, void *data, int len)
 {
-	struct mt7915_tx_free *free = (struct mt7915_tx_free *)data;
+	struct mt76_connac_tx_free *free = data;
+	__le16 *info = (__le16 *)(data + sizeof(*free));
 	struct mt76_dev *mdev = &dev->mt76;
-	__le16 *info = (__le16 *)free->info;
 	void *end = data + len;
 	LIST_HEAD(free_list);
 	bool wake = false;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index ed71a7bc25eb..3876a7457cde 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -41,14 +41,6 @@ enum tx_mcu_port_q_idx {
 	MT_TX_MCU_PORT_RX_Q3,
 	MT_TX_MCU_PORT_RX_FWDL = 0x3e
 };
-
-struct mt7915_tx_free {
-	__le16 rx_byte_cnt;
-	__le16 ctrl;
-	__le32 txd;
-	__le32 info[];
-} __packed __aligned(4);
-
 #define MT_TX_FREE_VER			GENMASK(18, 16)
 #define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
 #define MT_TX_FREE_MSDU_CNT_V0	GENMASK(6, 0)
-- 
2.36.1

