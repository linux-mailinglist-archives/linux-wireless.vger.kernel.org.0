Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB27B4CF26A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 08:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiCGHLa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 02:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbiCGHL2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 02:11:28 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D585DE6F
        for <linux-wireless@vger.kernel.org>; Sun,  6 Mar 2022 23:10:35 -0800 (PST)
X-UUID: 4cac3f0f763e424eacbd2ae57a0354a1-20220307
X-UUID: 4cac3f0f763e424eacbd2ae57a0354a1-20220307
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <meichia.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 342730796; Mon, 07 Mar 2022 15:10:31 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Mar 2022 15:10:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Mar
 2022 15:10:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Mar 2022 15:10:30 +0800
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
Subject: [PATCH v3 1/4] mt76: connac: add 6 GHz support for wtbl and starec configuration
Date:   Mon, 7 Mar 2022 15:10:25 +0800
Message-ID: <20220307071028.5711-1-MeiChia.Chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
v3: use le16_get_bits instead of FIELD_GET
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 6c762fbf9aaa..5e65fa3f3cba 100644
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
+			ht->af = le16_get_bits(sta->he_6ghz_capa.capa,
+					       IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
+			ht->mm = le16_get_bits(sta->he_6ghz_capa.capa,
+					       IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
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

