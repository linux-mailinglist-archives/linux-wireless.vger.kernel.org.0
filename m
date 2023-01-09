Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9686B662C2D
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 18:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbjAIRGb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 12:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbjAIQ6R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 11:58:17 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE0614F
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 08:58:14 -0800 (PST)
X-UUID: 1a26b75fcb1e44948294235735ea811b-20230110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eM0NwOGFlLu9vFSEUrdZRsSrF/f4poIqUeaQPkLxJi8=;
        b=PJBZ8okeiXrOD6YX040Hb+T2Xg0ipE0ozKgU56Rlz5XwBHn6+jguWn1rCdVxdVU+3Dx2lROnDvyqQkFDRzd7qgvSonOxtOLIF6CzH4Le2CTgg7gGEctnouzxyqO7LcEbOs6ukpKuEAslbfE75x978BTxnLGEz1Jfggcr48aRhYo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:29c2c8af-5ee9-4d26-ba70-b3081657357f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.17,REQID:29c2c8af-5ee9-4d26-ba70-b3081657357f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:543e81c,CLOUDID:35edbb8b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230110005809TECWI5M9,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0
X-CID-BVR: 0
X-UUID: 1a26b75fcb1e44948294235735ea811b-20230110
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 92812605; Tue, 10 Jan 2023 00:58:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 10 Jan 2023 00:58:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 10 Jan 2023 00:58:04 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 03/13] wifi: mt76: connac: add helpers for EHT capability
Date:   Tue, 10 Jan 2023 00:57:21 +0800
Message-ID: <20230109165731.682-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230109165731.682-1-shayne.chen@mediatek.com>
References: <20230109165731.682-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add helpers to get eht cap and phymode on different bands and vifs.
This is the preliminary patch to add EHT support for mt7996.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 46 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  4 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 5a047e630860..efb9bfaa187f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1329,6 +1329,40 @@ u8 mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_get_phy_mode);
 
+u8 mt76_connac_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_vif *vif,
+				enum nl80211_band band)
+{
+	const struct ieee80211_sta_eht_cap *eht_cap;
+	struct ieee80211_supported_band *sband;
+	u8 mode = 0;
+
+	if (band == NL80211_BAND_6GHZ)
+		mode |= PHY_MODE_AX_6G;
+
+	sband = phy->hw->wiphy->bands[band];
+	eht_cap = ieee80211_get_eht_iftype_cap(sband, vif->type);
+
+	if (!eht_cap || !eht_cap->has_eht)
+		return mode;
+
+	switch (band) {
+	case NL80211_BAND_6GHZ:
+		mode |= PHY_MODE_BE_6G;
+		break;
+	case NL80211_BAND_5GHZ:
+		mode |= PHY_MODE_BE_5G;
+		break;
+	case NL80211_BAND_2GHZ:
+		mode |= PHY_MODE_BE_24G;
+		break;
+	default:
+		break;
+	}
+
+	return mode;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_get_phy_mode_ext);
+
 const struct ieee80211_sta_he_cap *
 mt76_connac_get_he_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif)
 {
@@ -1341,6 +1375,18 @@ mt76_connac_get_he_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif)
 }
 EXPORT_SYMBOL_GPL(mt76_connac_get_he_phy_cap);
 
+const struct ieee80211_sta_eht_cap *
+mt76_connac_get_eht_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif)
+{
+	enum nl80211_band band = phy->chandef.chan->band;
+	struct ieee80211_supported_band *sband;
+
+	sband = phy->hw->wiphy->bands[band];
+
+	return ieee80211_get_eht_iftype_cap(sband, vif->type);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_get_eht_phy_cap);
+
 #define DEFAULT_HE_PE_DURATION		4
 #define DEFAULT_HE_DURATION_RTS_THRES	1023
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 947b0900daec..efba24bd3c6b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1870,8 +1870,12 @@ void mt76_connac_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val);
 
 const struct ieee80211_sta_he_cap *
 mt76_connac_get_he_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif);
+const struct ieee80211_sta_eht_cap *
+mt76_connac_get_eht_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif);
 u8 mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 			    enum nl80211_band band, struct ieee80211_sta *sta);
+u8 mt76_connac_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_vif *vif,
+				enum nl80211_band band);
 
 int mt76_connac_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 			    struct mt76_connac_sta_key_conf *sta_key_conf,
-- 
2.25.1

