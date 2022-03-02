Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE904C9DAE
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Mar 2022 07:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbiCBGPE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Mar 2022 01:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbiCBGPD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Mar 2022 01:15:03 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543E2A1453
        for <linux-wireless@vger.kernel.org>; Tue,  1 Mar 2022 22:14:20 -0800 (PST)
X-UUID: 567784e87b7e44dbaa61023fe398af59-20220302
X-UUID: 567784e87b7e44dbaa61023fe398af59-20220302
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <meichia.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 37052973; Wed, 02 Mar 2022 14:14:13 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Mar 2022 14:14:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Mar
 2022 14:14:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Mar 2022 14:14:11 +0800
From:   MeiChia Chiu <MeiChia.Chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Money Wang <Money.Wang@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Subject: [PATCH v2] mt76: split single ldpc cap bit into bits
Date:   Wed, 2 Mar 2022 14:14:06 +0800
Message-ID: <20220302061406.24797-1-MeiChia.Chiu@mediatek.com>
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

The original single LDPC cap bit cannot be used to
differentiate LDPC cap in each PHY mode.
This modification split the single bit into 3 bits,
ht_ldpc, vht_ldpc, and he_ldpc.

Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Suggested-by: Money Wang <Money.Wang@mediatek.com>
Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
---
v2:
fix indention
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  9 +++++----
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 20 +++++++++++--------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +++-
 5 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index e98c6076a633..390add3144c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -880,7 +880,7 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 						 NULL, wtbl_hdr);
 		if (sta)
 			mt76_connac_mcu_wtbl_ht_tlv(&dev->mt76, wskb, sta,
-						    NULL, wtbl_hdr, true);
+						    NULL, wtbl_hdr, true, true);
 		mt76_connac_mcu_wtbl_hdr_trans_tlv(wskb, vif, &msta->wcid,
 						   NULL, wtbl_hdr);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 0a646ae51c8d..6c762fbf9aaa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -899,7 +899,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_smps_tlv);
 
 void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				 struct ieee80211_sta *sta, void *sta_wtbl,
-				 void *wtbl_tlv, bool ldpc)
+				 void *wtbl_tlv, bool ht_ldpc, bool vht_ldpc)
 {
 	struct wtbl_ht *ht = NULL;
 	struct tlv *tlv;
@@ -909,7 +909,7 @@ void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 		tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_HT, sizeof(*ht),
 						     wtbl_tlv, sta_wtbl);
 		ht = (struct wtbl_ht *)tlv;
-		ht->ldpc = ldpc &&
+		ht->ldpc = ht_ldpc &&
 			   !!(sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
 		ht->af = sta->ht_cap.ampdu_factor;
 		ht->mm = sta->ht_cap.ampdu_density;
@@ -924,7 +924,7 @@ void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 						     sizeof(*vht), wtbl_tlv,
 						     sta_wtbl);
 		vht = (struct wtbl_vht *)tlv;
-		vht->ldpc = ldpc &&
+		vht->ldpc = vht_ldpc &&
 			    !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
 		vht->vht = true;
 
@@ -1004,7 +1004,8 @@ int mt76_connac_mcu_sta_cmd(struct mt76_phy *phy,
 						   sta_wtbl, wtbl_hdr);
 		if (info->sta)
 			mt76_connac_mcu_wtbl_ht_tlv(dev, skb, info->sta,
-						    sta_wtbl, wtbl_hdr, true);
+						    sta_wtbl, wtbl_hdr,
+						    true, true);
 	}
 
 	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 384c3eab1c8a..146186f5109b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1561,7 +1561,7 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 			     u8 rcpi, u8 state);
 void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				 struct ieee80211_sta *sta, void *sta_wtbl,
-				 void *wtbl_tlv, bool ldpc);
+				 void *wtbl_tlv, bool ht_ldpc, bool vht_ldpc);
 void mt76_connac_mcu_wtbl_ba_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				 struct ieee80211_ampdu_params *params,
 				 bool enable, bool tx, void *sta_wtbl,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 119f9358162f..cc7d8e7e8d8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -821,8 +821,9 @@ mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G))
 		cap |= STA_REC_HE_CAP_BW20_RU242_SUPPORT;
 
-	if (mvif->cap.ldpc && (elem->phy_cap_info[1] &
-			       IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
+	if (mvif->cap.he_ldpc &&
+	    (elem->phy_cap_info[1] &
+	     IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
 		cap |= STA_REC_HE_CAP_LDPC;
 
 	if (elem->phy_cap_info[1] &
@@ -1073,7 +1074,8 @@ mt7915_mcu_sta_wtbl_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, wcid, tlv, wtbl_hdr);
 	if (sta)
 		mt76_connac_mcu_wtbl_ht_tlv(&dev->mt76, skb, sta, tlv,
-					    wtbl_hdr, mvif->cap.ldpc);
+					    wtbl_hdr, mvif->cap.ht_ldpc,
+					    mvif->cap.vht_ldpc);
 
 	return 0;
 }
@@ -1582,7 +1584,7 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 			cap |= STA_CAP_TX_STBC;
 		if (sta->ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
 			cap |= STA_CAP_RX_STBC;
-		if (mvif->cap.ldpc &&
+		if (mvif->cap.ht_ldpc &&
 		    (sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING))
 			cap |= STA_CAP_LDPC;
 
@@ -1608,7 +1610,7 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 			cap |= STA_CAP_VHT_TX_STBC;
 		if (sta->vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_1)
 			cap |= STA_CAP_VHT_RX_STBC;
-		if (mvif->cap.ldpc &&
+		if (mvif->cap.vht_ldpc &&
 		    (sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC))
 			cap |= STA_CAP_VHT_LDPC;
 
@@ -1872,8 +1874,8 @@ mt7915_mcu_beacon_check_caps(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			      len);
 	if (ie && ie[1] >= sizeof(*ht)) {
 		ht = (void *)(ie + 2);
-		vc->ldpc |= !!(le16_to_cpu(ht->cap_info) &
-			       IEEE80211_HT_CAP_LDPC_CODING);
+		vc->ht_ldpc = !!(le16_to_cpu(ht->cap_info) &
+				 IEEE80211_HT_CAP_LDPC_CODING);
 	}
 
 	ie = cfg80211_find_ie(WLAN_EID_VHT_CAPABILITY, mgmt->u.beacon.variable,
@@ -1884,7 +1886,7 @@ mt7915_mcu_beacon_check_caps(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 		vht = (void *)(ie + 2);
 		bc = le32_to_cpu(vht->vht_cap_info);
 
-		vc->ldpc |= !!(bc & IEEE80211_VHT_CAP_RXLDPC);
+		vc->vht_ldpc = !!(bc & IEEE80211_VHT_CAP_RXLDPC);
 		vc->vht_su_ebfer =
 			(bc & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE) &&
 			(pc & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
@@ -1908,6 +1910,8 @@ mt7915_mcu_beacon_check_caps(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 
 		he = (void *)(ie + 3);
 
+		vc->he_ldpc =
+			HE_PHY(CAP1_LDPC_CODING_IN_PAYLOAD, pe->phy_cap_info[1]);
 		vc->he_su_ebfer =
 			HE_PHY(CAP3_SU_BEAMFORMER, he->phy_cap_info[3]) &&
 			HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 52b848dd4b66..2fe737f2f844 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -138,7 +138,9 @@ struct mt7915_sta {
 };
 
 struct mt7915_vif_cap {
-	bool ldpc:1;
+	bool ht_ldpc:1;
+	bool vht_ldpc:1;
+	bool he_ldpc:1;
 	bool vht_su_ebfer:1;
 	bool vht_su_ebfee:1;
 	bool vht_mu_ebfer:1;
-- 
2.29.2

