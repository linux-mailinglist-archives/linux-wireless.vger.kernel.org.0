Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0299306114
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 17:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343995AbhA0QdH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jan 2021 11:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343556AbhA0QdD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jan 2021 11:33:03 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3B3C06174A
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jan 2021 08:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4BI2w2u7FTlvE8MpAESrQZEF5eb3f5AeuOs1JiirDiY=; b=mWfrP5gKfJQCtU4TxJ7PXfgwCW
        7QTLsjnAOdIhk6CbGYL8KVD17/i5T2lSS6Q1TADtfiUkYO9c1xRoDPYAJWAZ10biUAW3+WOU6txXX
        nJaFaok0f2vHIWSYNOvaLaoTDXUIUM9fZil1+xONOZ5BvZ87ADZRkT2itPa3CAJpPzQg=;
Received: from p54ae9023.dip0.t-ipconnect.de ([84.174.144.35] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l4njx-0004dB-0i
        for linux-wireless@vger.kernel.org; Wed, 27 Jan 2021 17:32:21 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 6/7] mt76: mt7915: fix eeprom parsing for DBDC
Date:   Wed, 27 Jan 2021 17:32:19 +0100
Message-Id: <20210127163219.90806-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210114112925.87646-6-nbd@nbd.name>
References: <20210114112925.87646-6-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Annotate WIFI_CONF eeprom mask values with the byte number
Fix parsing per-band number of chains

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: detect faulty eeprom path settings that worked before this patch

 .../wireless/mediatek/mt76/mt7915/eeprom.c    | 28 +++++++++++--------
 .../wireless/mediatek/mt76/mt7915/eeprom.h    | 17 ++++++-----
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 7807b9165e01..291a781dada2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -53,7 +53,7 @@ void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 	u32 val;
 
 	val = mt7915_eeprom_read(dev, MT_EE_WIFI_CONF + ext_phy);
-	val = FIELD_GET(MT_EE_WIFI_CONF_BAND_SEL, val);
+	val = FIELD_GET(MT_EE_WIFI_CONF0_BAND_SEL, val);
 	switch (val) {
 	case MT_EE_5GHZ:
 		phy->mt76->cap.has_5ghz = true;
@@ -70,25 +70,29 @@ void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 
 static void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev)
 {
-	u8 nss, tx_mask[2] = {}, *eeprom = dev->mt76.eeprom.data;
+	u8 nss, nss_band, *eeprom = dev->mt76.eeprom.data;
 
 	mt7915_eeprom_parse_band_config(&dev->phy);
 
 	/* read tx mask from eeprom */
-	tx_mask[0] = FIELD_GET(MT_EE_WIFI_CONF_TX_MASK,
-			       eeprom[MT_EE_WIFI_CONF]);
-	if (dev->dbdc_support)
-		tx_mask[1] = FIELD_GET(MT_EE_WIFI_CONF_TX_MASK,
-				       eeprom[MT_EE_WIFI_CONF + 1]);
-
-	nss = tx_mask[0] + tx_mask[1];
-	if (!nss || nss > 4) {
-		tx_mask[0] = 4;
+	nss = FIELD_GET(MT_EE_WIFI_CONF0_TX_PATH, eeprom[MT_EE_WIFI_CONF]);
+	if (!nss || nss > 4)
 		nss = 4;
+
+	nss_band = nss;
+
+	if (dev->dbdc_support) {
+		nss_band = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B0,
+				     eeprom[MT_EE_WIFI_CONF + 3]);
+		if (!nss_band || nss_band > 2)
+			nss_band = 2;
+
+		if (nss_band >= nss)
+			nss = 4;
 	}
 
 	dev->chainmask = BIT(nss) - 1;
-	dev->mphy.antenna_mask = BIT(tx_mask[0]) - 1;
+	dev->mphy.antenna_mask = BIT(nss_band) - 1;
 	dev->mphy.chainmask = dev->mphy.antenna_mask;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index 6712032b40df..7999e95560a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -25,11 +25,14 @@ enum mt7915_eeprom_field {
 	__MT_EE_MAX =		0xe00
 };
 
-#define MT_EE_WIFI_CONF_TX_MASK			GENMASK(2, 0)
-#define MT_EE_WIFI_CONF_BAND_SEL		GENMASK(7, 6)
-#define MT_EE_WIFI_CONF_TSSI0_2G		BIT(0)
-#define MT_EE_WIFI_CONF_TSSI0_5G		BIT(2)
-#define MT_EE_WIFI_CONF_TSSI1_5G		BIT(4)
+#define MT_EE_WIFI_CONF0_TX_PATH		GENMASK(2, 0)
+#define MT_EE_WIFI_CONF0_BAND_SEL		GENMASK(7, 6)
+#define MT_EE_WIFI_CONF1_BAND_SEL		GENMASK(7, 6)
+#define MT_EE_WIFI_CONF3_TX_PATH_B0		GENMASK(1, 0)
+#define MT_EE_WIFI_CONF3_TX_PATH_B1		GENMASK(5, 4)
+#define MT_EE_WIFI_CONF7_TSSI0_2G		BIT(0)
+#define MT_EE_WIFI_CONF7_TSSI0_5G		BIT(2)
+#define MT_EE_WIFI_CONF7_TSSI1_5G		BIT(4)
 
 enum mt7915_eeprom_band {
 	MT_EE_DUAL_BAND,
@@ -116,9 +119,9 @@ mt7915_tssi_enabled(struct mt7915_dev *dev, enum nl80211_band band)
 
 	/* TODO: DBDC */
 	if (band == NL80211_BAND_5GHZ)
-		return eep[MT_EE_WIFI_CONF + 7] & MT_EE_WIFI_CONF_TSSI0_5G;
+		return eep[MT_EE_WIFI_CONF + 7] & MT_EE_WIFI_CONF7_TSSI0_5G;
 	else
-		return eep[MT_EE_WIFI_CONF + 7] & MT_EE_WIFI_CONF_TSSI0_2G;
+		return eep[MT_EE_WIFI_CONF + 7] & MT_EE_WIFI_CONF7_TSSI0_2G;
 }
 
 extern const struct sku_group mt7915_sku_groups[];
-- 
2.28.0

