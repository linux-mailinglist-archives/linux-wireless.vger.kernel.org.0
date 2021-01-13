Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE4E2F4B07
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jan 2021 13:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbhAMMKT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jan 2021 07:10:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50904 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726426AbhAMMKT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jan 2021 07:10:19 -0500
X-UUID: 5eb41e0cb22f45fda80acd8b2e0e7348-20210113
X-UUID: 5eb41e0cb22f45fda80acd8b2e0e7348-20210113
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 332216038; Wed, 13 Jan 2021 20:09:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 13 Jan 2021 20:09:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Jan 2021 20:09:35 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] mt76: mt7915: simplify peer's TxBF capability check
Date:   Wed, 13 Jan 2021 20:09:32 +0800
Message-ID: <287bbdb0193bd74069219b97199ba4ec72127bd8.1610539467.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch for implicit beamforming support.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 50 +++++++------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 0baef70fc522..f38bc421ea8e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -66,9 +66,6 @@ struct mt7915_fw_region {
 
 #define MCU_PATCH_ADDRESS		0x200000
 
-#define MT_STA_BFER			BIT(0)
-#define MT_STA_BFEE			BIT(1)
-
 #define FW_FEATURE_SET_ENCRYPT		BIT(0)
 #define FW_FEATURE_SET_KEY_IDX		GENMASK(2, 1)
 #define FW_FEATURE_OVERRIDE_ADDR	BIT(5)
@@ -1948,16 +1945,23 @@ mt7915_mcu_sta_bfee_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 		bfee->fb_identity_matrix = true;
 }
 
-static u8
-mt7915_mcu_sta_txbf_type(struct mt7915_phy *phy, struct ieee80211_vif *vif,
-			 struct ieee80211_sta *sta)
+static int
+mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+		    struct ieee80211_sta *sta, bool enable)
 {
-	u8 type = 0;
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct mt7915_phy *phy;
+	struct sk_buff *skb;
+	int r, len;
+	bool ebfee = 0, ebf = 0;
 
 	if (vif->type != NL80211_IFTYPE_STATION &&
 	    vif->type != NL80211_IFTYPE_AP)
 		return 0;
 
+	phy = mvif->band_idx ? mt7915_ext_phy(dev) : &dev->phy;
+
 	if (sta->he_cap.has_he) {
 		struct ieee80211_he_cap_elem *pe;
 		const struct ieee80211_he_cap_elem *ve;
@@ -1970,12 +1974,12 @@ mt7915_mcu_sta_txbf_type(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 		if ((HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]) ||
 		     HE_PHY(CAP4_MU_BEAMFORMER, pe->phy_cap_info[4])) &&
 		    HE_PHY(CAP4_SU_BEAMFORMEE, ve->phy_cap_info[4]))
-			type |= MT_STA_BFEE;
+			ebfee = true;
 
 		if ((HE_PHY(CAP3_SU_BEAMFORMER, ve->phy_cap_info[3]) ||
 		     HE_PHY(CAP4_MU_BEAMFORMER, ve->phy_cap_info[4])) &&
 		    HE_PHY(CAP4_SU_BEAMFORMEE, pe->phy_cap_info[4]))
-			type |= MT_STA_BFER;
+			ebf = true;
 	} else if (sta->vht_cap.vht_supported) {
 		struct ieee80211_sta_vht_cap *pc;
 		struct ieee80211_sta_vht_cap *vc;
@@ -1989,36 +1993,16 @@ mt7915_mcu_sta_txbf_type(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 		     IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
 
 		if ((pc->cap & cr) && (vc->cap & ce))
-			type |= MT_STA_BFEE;
+			ebfee = true;
 
 		if ((vc->cap & cr) && (pc->cap & ce))
-			type |= MT_STA_BFER;
-	} else if (sta->ht_cap.ht_supported) {
-		/* TODO: iBF */
+			ebf = true;
 	}
 
-	return type;
-}
-
-static int
-mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-		    struct ieee80211_sta *sta, bool enable)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct mt7915_phy *phy;
-	struct sk_buff *skb;
-	int r, len;
-	u8 type;
-
-	phy = mvif->band_idx ? mt7915_ext_phy(dev) : &dev->phy;
-
-	type = mt7915_mcu_sta_txbf_type(phy, vif, sta);
-
 	/* must keep each tag independent */
 
 	/* starec bf */
-	if (type & MT_STA_BFER) {
+	if (ebf) {
 		len = sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_bf);
 
 		skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
@@ -2034,7 +2018,7 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	}
 
 	/* starec bfee */
-	if (type & MT_STA_BFEE) {
+	if (ebfee) {
 		len = sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_bfee);
 
 		skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
-- 
2.18.0

