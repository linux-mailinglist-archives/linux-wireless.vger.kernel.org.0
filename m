Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BB02F601B
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 12:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbhANLbH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 06:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbhANLbG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 06:31:06 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3434BC06179E
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jan 2021 03:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YqZaCa4JtBqfsXlzEE7I4bK1FnmxU9ccUxoq0fJ9iIM=; b=AjIQs16BXTDDC+ud4kcm1LcPhW
        LpFpiBprLHcQftlcB8TnuLWoPYIG8z3FgDf9pVWhQjoFtFPynejJFr0f3jPNtut5YGNvtC8fMdetl
        BqHqed5rKPkP6C+4a+ta+Tzo37cGriUxJ8v7uu3RmQ4FlylKRfN3Ze21Nk2YdrQX7y/0=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l00oh-0001PU-Qd
        for linux-wireless@vger.kernel.org; Thu, 14 Jan 2021 12:29:27 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 6/7] mt76: mt7915: fix eeprom parsing for DBDC
Date:   Thu, 14 Jan 2021 12:29:24 +0100
Message-Id: <20210114112925.87646-6-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210114112925.87646-1-nbd@nbd.name>
References: <20210114112925.87646-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Annotate WIFI_CONF eeprom mask values with the byte number
Fix parsing per-band number of chains

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7915/eeprom.c    | 26 +++++++++----------
 .../wireless/mediatek/mt76/mt7915/eeprom.h    | 17 +++++++-----
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 7807b9165e01..8f12a1bef3fc 100644
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
@@ -70,25 +70,25 @@ void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 
 static void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev)
 {
-	u8 nss, tx_mask[2] = {}, *eeprom = dev->mt76.eeprom.data;
+	u8 nss, *eeprom = dev->mt76.eeprom.data;
 
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
-	}
 
 	dev->chainmask = BIT(nss) - 1;
-	dev->mphy.antenna_mask = BIT(tx_mask[0]) - 1;
+
+	if (dev->dbdc_support) {
+		nss = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B0,
+				eeprom[MT_EE_WIFI_CONF + 3]);
+		if (!nss || nss > 2)
+			nss = 2;
+	}
+
+	dev->mphy.antenna_mask = BIT(nss) - 1;
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

