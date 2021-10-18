Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267464311E0
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 10:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhJRIKh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 04:10:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49422 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231233AbhJRIKg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 04:10:36 -0400
X-UUID: df025568a3a14ee88e3c9f6b85f4548f-20211018
X-UUID: df025568a3a14ee88e3c9f6b85f4548f-20211018
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1467810160; Mon, 18 Oct 2021 16:08:20 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 18 Oct 2021 16:08:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Oct 2021 16:08:19 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v7 5/8] mt76: mt7915: rework starec TLV tags
Date:   Mon, 18 Oct 2021 16:07:03 +0800
Message-ID: <20211018080706.11401-5-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211018080706.11401-1-shayne.chen@mediatek.com>
References: <20211018080706.11401-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rework starec tags to the order which firmware expected. This also fixes
some weird behaviors during generating SPL of HE-MU.

Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   3 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 229 +++++++-----------
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |   1 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   2 -
 4 files changed, 94 insertions(+), 141 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index a98fb4327a78..2c6266a41172 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -663,7 +663,7 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
-	return mt7915_mcu_add_sta_adv(dev, vif, sta, true);
+	return mt7915_mcu_add_rate_ctrl(dev, vif, sta);
 }
 
 void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
@@ -673,7 +673,6 @@ void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	int i;
 
-	mt7915_mcu_add_sta_adv(dev, vif, sta, false);
 	mt7915_mcu_add_sta(dev, vif, sta, false);
 
 	mt7915_mac_wtbl_update(dev, msta->wcid.idx,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 4e4906d9d374..4e48c06bd467 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1342,14 +1342,16 @@ mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 {
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
-	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
+	struct ieee80211_he_cap_elem *elem = &sta->he_cap.he_cap_elem;
 	enum nl80211_band band = msta->vif->phy->mt76->chandef.chan->band;
 	const u16 *mcs_mask = msta->vif->bitrate_mask.control[band].he_mcs;
 	struct sta_rec_he *he;
 	struct tlv *tlv;
 	u32 cap = 0;
 
+	if (!sta->he_cap.has_he)
+		return;
+
 	tlv = mt7915_mcu_add_tlv(skb, STA_REC_HE, sizeof(*he));
 
 	he = (struct sta_rec_he *)tlv;
@@ -1514,11 +1516,13 @@ mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 			struct ieee80211_vif *vif)
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
-	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
+	struct ieee80211_he_cap_elem *elem = &sta->he_cap.he_cap_elem;
 	struct sta_rec_muru *muru;
 	struct tlv *tlv;
 
+	if (!sta->vht_cap.vht_supported && !sta->he_cap.has_he)
+		return;
+
 	tlv = mt7915_mcu_add_tlv(skb, STA_REC_MURU, sizeof(*muru));
 
 	muru = (struct sta_rec_muru *)tlv;
@@ -1563,12 +1567,27 @@ mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 		HE_PHY(CAP2_UL_MU_PARTIAL_MU_MIMO, elem->phy_cap_info[2]);
 }
 
+static void
+mt7915_mcu_sta_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct sta_rec_ht *ht;
+	struct tlv *tlv;
+
+	tlv = mt7915_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
+
+	ht = (struct sta_rec_ht *)tlv;
+	ht->ht_cap = cpu_to_le16(sta->ht_cap.cap);
+}
+
 static void
 mt7915_mcu_sta_vht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 {
 	struct sta_rec_vht *vht;
 	struct tlv *tlv;
 
+	if (!sta->vht_cap.vht_supported)
+		return;
+
 	tlv = mt7915_mcu_add_tlv(skb, STA_REC_VHT, sizeof(*vht));
 
 	vht = (struct sta_rec_vht *)tlv;
@@ -1578,12 +1597,17 @@ mt7915_mcu_sta_vht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 }
 
 static void
-mt7915_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+mt7915_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta)
 {
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct sta_rec_amsdu *amsdu;
 	struct tlv *tlv;
 
+	if (vif->type != NL80211_IFTYPE_STATION &&
+	    vif->type != NL80211_IFTYPE_AP)
+		return;
+
 	if (!sta->max_amsdu_len)
 	    return;
 
@@ -1596,44 +1620,6 @@ mt7915_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 	msta->wcid.amsdu = true;
 }
 
-static bool
-mt7915_hw_amsdu_supported(struct ieee80211_vif *vif)
-{
-	switch (vif->type) {
-	case NL80211_IFTYPE_AP:
-	case NL80211_IFTYPE_STATION:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static void
-mt7915_mcu_sta_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
-		   struct ieee80211_sta *sta, struct ieee80211_vif *vif)
-{
-	struct tlv *tlv;
-
-	/* starec ht */
-	if (sta->ht_cap.ht_supported) {
-		struct sta_rec_ht *ht;
-
-		tlv = mt7915_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
-		ht = (struct sta_rec_ht *)tlv;
-		ht->ht_cap = cpu_to_le16(sta->ht_cap.cap);
-
-		if (mt7915_hw_amsdu_supported(vif))
-			mt7915_mcu_sta_amsdu_tlv(skb, sta);
-	}
-
-	/* starec he */
-	if (sta->he_cap.has_he)
-		mt7915_mcu_sta_he_tlv(skb, sta, vif);
-
-	/* starec uapsd */
-	mt7915_mcu_sta_uapsd_tlv(skb, sta, vif);
-}
-
 static void
 mt7915_mcu_wtbl_smps_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 			 void *sta_wtbl, void *wtbl_tlv)
@@ -1644,9 +1630,7 @@ mt7915_mcu_wtbl_smps_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	tlv = mt7915_mcu_add_nested_tlv(skb, WTBL_SMPS, sizeof(*smps),
 					wtbl_tlv, sta_wtbl);
 	smps = (struct wtbl_smps *)tlv;
-
-	if (sta->smps_mode == IEEE80211_SMPS_DYNAMIC)
-		smps->smps = true;
+	smps->smps = (sta->smps_mode == IEEE80211_SMPS_DYNAMIC);
 }
 
 static void
@@ -1720,6 +1704,32 @@ mt7915_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	}
 }
 
+static int
+mt7915_mcu_sta_wtbl_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
+			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+{
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_sta *msta;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct tlv *tlv;
+
+	msta = sta ? (struct mt7915_sta *)sta->drv_priv : &mvif->sta;
+
+	tlv = mt7915_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
+	wtbl_hdr = mt7915_mcu_alloc_wtbl_req(dev, msta, WTBL_RESET_AND_SET,
+					     tlv, &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
+	mt7915_mcu_wtbl_generic_tlv(skb, vif, sta, tlv, wtbl_hdr);
+	mt7915_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, tlv, wtbl_hdr);
+
+	if (sta)
+		mt7915_mcu_wtbl_ht_tlv(skb, vif, sta, tlv, wtbl_hdr);
+
+	return 0;
+}
+
 int mt7915_mcu_sta_update_hdr_trans(struct mt7915_dev *dev,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_sta *sta)
@@ -2039,28 +2049,6 @@ mt7915_mcu_sta_bfee_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	bfee->fb_identity_matrix = (nrow == 1 && tx_ant == 2);
 }
 
-static int
-mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-		    struct ieee80211_sta *sta, bool enable)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct sk_buff *skb;
-
-	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
-				       MT7915_STA_UPDATE_MAX_SIZE);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	/* starec bf */
-	mt7915_mcu_sta_bfer_tlv(dev, skb, vif, sta);
-	/* starec bfee */
-	mt7915_mcu_sta_bfee_tlv(dev, skb, vif, sta);
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD(STA_REC_UPDATE), true);
-}
-
 static void
 mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 			     struct ieee80211_vif *vif, struct ieee80211_sta *sta)
@@ -2206,7 +2194,7 @@ mt7915_mcu_add_group(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 {
 #define MT_STA_BSS_GROUP		1
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct mt7915_sta *msta;
 	struct {
 		__le32 action;
 		u8 wlan_idx_lo;
@@ -2217,75 +2205,24 @@ mt7915_mcu_add_group(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		u8 rsv1[8];
 	} __packed req = {
 		.action = cpu_to_le32(MT_STA_BSS_GROUP),
-		.wlan_idx_lo = to_wcid_lo(msta->wcid.idx),
-		.wlan_idx_hi = to_wcid_hi(msta->wcid.idx),
 		.val = cpu_to_le32(mvif->idx % 16),
 	};
 
+	msta = sta ? (struct mt7915_sta *)sta->drv_priv : &mvif->sta;
+	req.wlan_idx_lo = to_wcid_lo(msta->wcid.idx);
+	req.wlan_idx_hi = to_wcid_hi(msta->wcid.idx);
+
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_DRR_CTRL), &req,
 				 sizeof(req), true);
 }
 
-static int
-mt7915_mcu_add_mu(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-		  struct ieee80211_sta *sta)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct sk_buff *skb;
-	int ret;
-
-	if (!sta->vht_cap.vht_supported && !sta->he_cap.has_he)
-		return 0;
-
-	ret = mt7915_mcu_add_group(dev, vif, sta);
-	if (ret)
-		return ret;
-
-	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
-				       MT7915_STA_UPDATE_MAX_SIZE);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	/* wait until TxBF and MU ready to update stare vht */
-
-	/* starec muru */
-	mt7915_mcu_sta_muru_tlv(skb, sta, vif);
-	/* starec vht */
-	mt7915_mcu_sta_vht_tlv(skb, sta);
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD(STA_REC_UPDATE), true);
-}
-
-int mt7915_mcu_add_sta_adv(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-			   struct ieee80211_sta *sta, bool enable)
-{
-	int ret;
-
-	if (!sta)
-		return 0;
-
-	/* must keep the order */
-	ret = mt7915_mcu_add_txbf(dev, vif, sta, enable);
-	if (ret || !enable)
-		return ret;
-
-	ret = mt7915_mcu_add_mu(dev, vif, sta);
-	if (ret)
-		return ret;
-
-	return mt7915_mcu_add_rate_ctrl(dev, vif, sta);
-}
-
 int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta, bool enable)
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct wtbl_req_hdr *wtbl_hdr;
 	struct mt7915_sta *msta;
-	struct tlv *sta_wtbl;
 	struct sk_buff *skb;
+	int ret;
 
 	msta = sta ? (struct mt7915_sta *)sta->drv_priv : &mvif->sta;
 
@@ -2294,24 +2231,42 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
+	/* starec basic */
 	mt7915_mcu_sta_basic_tlv(skb, vif, sta, enable);
-	if (enable && sta)
-		mt7915_mcu_sta_tlv(dev, skb, sta, vif);
+	if (!enable)
+		goto out;
 
-	sta_wtbl = mt7915_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
+	/* tag order is in accordance with firmware dependency. */
+	if (sta && sta->ht_cap.ht_supported) {
+		/* starec bfer */
+		mt7915_mcu_sta_bfer_tlv(dev, skb, vif, sta);
+		/* starec ht */
+		mt7915_mcu_sta_ht_tlv(skb, sta);
+		/* starec vht */
+		mt7915_mcu_sta_vht_tlv(skb, sta);
+		/* starec uapsd */
+		mt7915_mcu_sta_uapsd_tlv(skb, sta, vif);
+	}
 
-	wtbl_hdr = mt7915_mcu_alloc_wtbl_req(dev, msta, WTBL_RESET_AND_SET,
-					     sta_wtbl, &skb);
-	if (IS_ERR(wtbl_hdr))
-		return PTR_ERR(wtbl_hdr);
+	ret = mt7915_mcu_sta_wtbl_tlv(dev, skb, vif, sta);
+	if (ret)
+		return ret;
 
-	if (enable) {
-		mt7915_mcu_wtbl_generic_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
-		mt7915_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
-		if (sta)
-			mt7915_mcu_wtbl_ht_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
+	if (sta && sta->ht_cap.ht_supported) {
+		/* starec amsdu */
+		mt7915_mcu_sta_amsdu_tlv(skb, vif, sta);
+		/* starec he */
+		mt7915_mcu_sta_he_tlv(skb, sta, vif);
+		/* starec muru */
+		mt7915_mcu_sta_muru_tlv(skb, sta, vif);
+		/* starec bfee */
+		mt7915_mcu_sta_bfee_tlv(dev, skb, vif, sta);
 	}
 
+	ret = mt7915_mcu_add_group(dev, vif, sta);
+	if (ret)
+		return ret;
+out:
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 40b61caee901..a1a6cc064573 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -1110,6 +1110,7 @@ enum {
 					 sizeof(struct sta_rec_vht) +	\
 					 sizeof(struct sta_rec_uapsd) + \
 					 sizeof(struct sta_rec_amsdu) +	\
+					 sizeof(struct sta_rec_muru) +	\
 					 sizeof(struct sta_rec_bfee) +	\
 					 sizeof(struct tlv) +		\
 					 MT7915_WTBL_UPDATE_MAX_SIZE)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 267fd18b859e..78c0896f97b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -394,8 +394,6 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 			    struct ieee80211_vif *vif, int enable);
 int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta, bool enable);
-int mt7915_mcu_add_sta_adv(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-			   struct ieee80211_sta *sta, bool enable);
 int mt7915_mcu_sta_update_hdr_trans(struct mt7915_dev *dev,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_sta *sta);
-- 
2.29.2

