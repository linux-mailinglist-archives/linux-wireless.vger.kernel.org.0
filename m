Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779AF6828F5
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 10:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjAaJgp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Jan 2023 04:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjAaJgo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Jan 2023 04:36:44 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FDD2CC61
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 01:36:37 -0800 (PST)
X-UUID: bdc4ec74a14a11ed945fc101203acc17-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vkO5aTZN1uf1h2I1D8925XdCyN6nmzdlQkdnQhsjLpU=;
        b=Z5DUmPcbvmcVSL3GUf6w+YjtjYI16lz1sNE5z9lJ0FoAOECFkafa9JFpgibCTA6XQdMaXD4HfCtiACiIZuQHeemMk42f0EPeQ5sD0sEjBYB9+pZggEWNd18EvDAMBBpdw6ic5ARIEBi1boViGzlhP/yCl/+8XQYKyt0We3FtSK0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:c1bacb21-0488-4048-ab64-2f1c5bfe881a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.18,REQID:c1bacb21-0488-4048-ab64-2f1c5bfe881a,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:3ca2d6b,CLOUDID:fa2b04f7-ff42-4fb0-b929-626456a83c14,B
        ulkID:230131173630XBELAVW8,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-BVR: 0
X-UUID: bdc4ec74a14a11ed945fc101203acc17-20230131
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1595093901; Tue, 31 Jan 2023 17:36:30 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 31 Jan 2023 17:36:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 31 Jan 2023 17:36:29 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 03/13] wifi: mt76: connac: add helpers for EHT capability
Date:   Tue, 31 Jan 2023 17:36:01 +0800
Message-ID: <20230131093611.30914-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230131093611.30914-1-shayne.chen@mediatek.com>
References: <20230131093611.30914-1-shayne.chen@mediatek.com>
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
index ebd64bec9f68..2c22f60cc56d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1872,8 +1872,12 @@ void mt76_connac_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val);
 
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

