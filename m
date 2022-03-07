Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12294CF00A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 04:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiCGDMp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Mar 2022 22:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiCGDMo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Mar 2022 22:12:44 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F7D37BE6
        for <linux-wireless@vger.kernel.org>; Sun,  6 Mar 2022 19:11:46 -0800 (PST)
X-UUID: 651fb86d9f8a46299403a60719a218ee-20220307
X-UUID: 651fb86d9f8a46299403a60719a218ee-20220307
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <meichia.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1559602429; Mon, 07 Mar 2022 11:11:39 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 7 Mar 2022 11:11:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Mar 2022 11:11:38 +0800
From:   MeiChia Chiu <MeiChia.Chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>
Subject: [PATCH v2 1/4] mt76: connac: add 6 GHz support for wtbl and starec configuration
Date:   Mon, 7 Mar 2022 11:11:22 +0800
Message-ID: <20220307031125.2585-1-MeiChia.Chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since there are no HT & VHT IEs being sent in 6ghz,
some capabilities judgement and parsing for wtbl &
starec configuration should be modified to reflect such changes.

Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Money Wang <Money.Wang@mediatek.com>
Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
---
The series is based on https://patchwork.kernel.org/project/linux-wireless/patch/20220302061406.24797-1-MeiChia.Chiu@mediatek.com/
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 6c762fbf9aaa..9f83fa379396 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -905,18 +905,27 @@ void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 	struct tlv *tlv;
 	u32 flags = 0;
 
-	if (sta->ht_cap.ht_supported) {
+	if (sta->ht_cap.ht_supported || sta->he_6ghz_capa.capa) {
 		tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_HT, sizeof(*ht),
 						     wtbl_tlv, sta_wtbl);
 		ht = (struct wtbl_ht *)tlv;
 		ht->ldpc = ht_ldpc &&
 			   !!(sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
-		ht->af = sta->ht_cap.ampdu_factor;
-		ht->mm = sta->ht_cap.ampdu_density;
+
+		if (sta->ht_cap.ht_supported) {
+			ht->af = sta->ht_cap.ampdu_factor;
+			ht->mm = sta->ht_cap.ampdu_density;
+		} else {
+			ht->af = FIELD_GET(IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP,
+					   sta->he_6ghz_capa.capa);
+			ht->mm = FIELD_GET(IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START,
+					   sta->he_6ghz_capa.capa);
+		}
+
 		ht->ht = true;
 	}
 
-	if (sta->vht_cap.vht_supported) {
+	if (sta->vht_cap.vht_supported || sta->he_6ghz_capa.capa) {
 		struct wtbl_vht *vht;
 		u8 af;
 
@@ -1242,7 +1251,7 @@ u8 mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 
 		if (he_cap && he_cap->has_he)
 			mode |= PHY_MODE_AX_24G;
-	} else if (band == NL80211_BAND_5GHZ || band == NL80211_BAND_6GHZ) {
+	} else if (band == NL80211_BAND_5GHZ) {
 		mode |= PHY_MODE_A;
 
 		if (ht_cap->ht_supported)
@@ -1251,8 +1260,11 @@ u8 mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		if (vht_cap->vht_supported)
 			mode |= PHY_MODE_AC;
 
-		if (he_cap && he_cap->has_he && band == NL80211_BAND_5GHZ)
+		if (he_cap && he_cap->has_he)
 			mode |= PHY_MODE_AX_5G;
+	} else if (band == NL80211_BAND_6GHZ) {
+		mode |= PHY_MODE_A | PHY_MODE_AN |
+			PHY_MODE_AC | PHY_MODE_AX_5G;
 	}
 
 	return mode;
-- 
2.18.0

