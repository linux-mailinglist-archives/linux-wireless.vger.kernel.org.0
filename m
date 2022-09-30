Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EC25F0E80
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 17:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiI3PNq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 11:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiI3PNj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 11:13:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE7B12C69F
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 08:13:37 -0700 (PDT)
X-UUID: 463705ebde654d1ba54063f16fb7978c-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Fir2BhM41H223iYDuYp4wdkC6rgz1IKz8jiDYFGDqjw=;
        b=isCfbG/fGbKG2TK7Yzrz7urysIPzyulz1NVMU4Dijg3aBVr9llb8J/eJtGeou0W9xiyMuEaKAAJO6ySyIq7BM8hMuWUy4phYHubG3kBvPZia92A9VxTYgxTmM/N2yVveGOaJ+8kQiXnZ+K7JKMNBVXb3lcEoG1oJX0L650uO6bw=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:e3f130b6-3619-405e-86c0-3d417a9b4d7e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.11,REQID:e3f130b6-3619-405e-86c0-3d417a9b4d7e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:39a5ff1,CLOUDID:5fc29807-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:220930231334FJWYHKBX,BulkQuantity:0,Recheck:0,SF:28|16|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: 463705ebde654d1ba54063f16fb7978c-20220930
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1875206049; Fri, 30 Sep 2022 23:13:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 30 Sep 2022 23:13:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 30 Sep 2022 23:13:32 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 1/6] wifi: mt76: mt7915: rework eeprom tx paths and streams init
Date:   Fri, 30 Sep 2022 23:13:10 +0800
Message-ID: <20220930151315.19012-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rework tx paths and streams init part to improve readability, and make
sure that the available tx streams should be smaller than or equal to
the available tx paths.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/eeprom.c    | 55 +++++++------------
 .../wireless/mediatek/mt76/mt7915/eeprom.h    |  5 --
 2 files changed, 21 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 4b1a9811646f..e2482c65d639 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -173,60 +173,47 @@ static void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
 				struct mt7915_phy *phy)
 {
-	u8 nss, nss_band, nss_band_max, *eeprom = dev->mt76.eeprom.data;
+	u8 path, nss, nss_max = 4, *eeprom = dev->mt76.eeprom.data;
 	struct mt76_phy *mphy = phy->mt76;
-	bool ext_phy = phy != &dev->phy;
 
 	mt7915_eeprom_parse_band_config(phy);
 
-	/* read tx/rx mask from eeprom */
+	/* read tx/rx path from eeprom */
 	if (is_mt7915(&dev->mt76)) {
-		nss = FIELD_GET(MT_EE_WIFI_CONF0_TX_PATH,
-				eeprom[MT_EE_WIFI_CONF]);
+		path = FIELD_GET(MT_EE_WIFI_CONF0_TX_PATH,
+				 eeprom[MT_EE_WIFI_CONF]);
 	} else {
-		nss = FIELD_GET(MT_EE_WIFI_CONF0_TX_PATH,
-				eeprom[MT_EE_WIFI_CONF + phy->band_idx]);
+		path = FIELD_GET(MT_EE_WIFI_CONF0_TX_PATH,
+				 eeprom[MT_EE_WIFI_CONF + phy->band_idx]);
 	}
 
-	if (!nss || nss > 4)
-		nss = 4;
+	if (!path || path > 4)
+		path = 4;
 
 	/* read tx/rx stream */
-	nss_band = nss;
-
+	nss = path;
 	if (dev->dbdc_support) {
 		if (is_mt7915(&dev->mt76)) {
-			nss_band = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B0,
-					     eeprom[MT_EE_WIFI_CONF + 3]);
+			nss = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B0,
+					eeprom[MT_EE_WIFI_CONF + 3]);
 			if (phy->band_idx)
-				nss_band = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B1,
-						     eeprom[MT_EE_WIFI_CONF + 3]);
+				nss = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B1,
+						eeprom[MT_EE_WIFI_CONF + 3]);
 		} else {
-			nss_band = FIELD_GET(MT_EE_WIFI_CONF_STREAM_NUM,
-					     eeprom[MT_EE_WIFI_CONF + 2 + phy->band_idx]);
+			nss = FIELD_GET(MT_EE_WIFI_CONF_STREAM_NUM,
+					eeprom[MT_EE_WIFI_CONF + 2 + phy->band_idx]);
 		}
 
-		nss_band_max = is_mt7986(&dev->mt76) ?
-			       MT_EE_NSS_MAX_DBDC_MA7986 : MT_EE_NSS_MAX_DBDC_MA7915;
-	} else {
-		nss_band_max = is_mt7986(&dev->mt76) ?
-			       MT_EE_NSS_MAX_MA7986 : MT_EE_NSS_MAX_MA7915;
+		if (!is_mt7986(&dev->mt76))
+			nss_max = 2;
 	}
 
-	if (!nss_band || nss_band > nss_band_max)
-		nss_band = nss_band_max;
-
-	if (nss_band > nss) {
-		dev_warn(dev->mt76.dev,
-			 "nss mismatch, nss(%d) nss_band(%d) band(%d) ext_phy(%d)\n",
-			 nss, nss_band, phy->band_idx, ext_phy);
-		nss = nss_band;
-	}
+	nss = min_t(u8, min_t(u8, nss_max, nss), path);
 
-	mphy->chainmask = BIT(nss) - 1;
-	if (ext_phy)
+	mphy->chainmask = BIT(path) - 1;
+	if (phy->band_idx)
 		mphy->chainmask <<= dev->chainshift;
-	mphy->antenna_mask = BIT(nss_band) - 1;
+	mphy->antenna_mask = BIT(nss) - 1;
 	dev->chainmask |= mphy->chainmask;
 	dev->chainshift = hweight8(dev->mphy.chainmask);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index 7578ac6d0be6..f3e56817d36e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -58,11 +58,6 @@ enum mt7915_eeprom_field {
 #define MT_EE_RATE_DELTA_SIGN			BIT(6)
 #define MT_EE_RATE_DELTA_EN			BIT(7)
 
-#define MT_EE_NSS_MAX_MA7915			4
-#define MT_EE_NSS_MAX_DBDC_MA7915		2
-#define MT_EE_NSS_MAX_MA7986			4
-#define MT_EE_NSS_MAX_DBDC_MA7986		4
-
 enum mt7915_adie_sku {
 	MT7976_ONE_ADIE_DBDC = 0x7,
 	MT7975_ONE_ADIE	= 0x8,
-- 
2.25.1

