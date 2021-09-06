Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11957401AB5
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Sep 2021 13:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241442AbhIFLqS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Sep 2021 07:46:18 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:39170 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241358AbhIFLqQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Sep 2021 07:46:16 -0400
X-UUID: 38d9b6e997c948c8b64425d507bbd6b0-20210906
X-UUID: 38d9b6e997c948c8b64425d507bbd6b0-20210906
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 174075233; Mon, 06 Sep 2021 19:45:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 6 Sep 2021 19:45:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Sep 2021 19:45:05 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 2/8] mt76: mt7915: fix txbf starec TLV issues
Date:   Mon, 6 Sep 2021 19:44:17 +0800
Message-ID: <20210906114423.13646-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210906114423.13646-1-shayne.chen@mediatek.com>
References: <20210906114423.13646-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

With this patch we can append txbf starec TLVs. This is an intermediate
patch for reworking starec TLV tags.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 139 +++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |   4 +-
 2 files changed, 71 insertions(+), 72 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 955afe9f2958..89df9bcd14e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1749,6 +1749,45 @@ int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
 
+static inline bool
+mt7915_is_ebf_supported(struct mt7915_phy *phy, struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta, bool bfee)
+{
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
+
+	if (vif->type != NL80211_IFTYPE_STATION &&
+	    vif->type != NL80211_IFTYPE_AP)
+		return false;
+
+	if (!bfee && tx_ant < 2)
+		return false;
+
+	if (sta->he_cap.has_he) {
+		struct ieee80211_he_cap_elem *pe = &sta->he_cap.he_cap_elem;
+
+		if (bfee)
+			return mvif->cap.he_su_ebfee &&
+			       HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]);
+		else
+			return mvif->cap.he_su_ebfer &&
+			       HE_PHY(CAP4_SU_BEAMFORMEE, pe->phy_cap_info[4]);
+	}
+
+	if (sta->vht_cap.vht_supported) {
+		u32 cap = sta->vht_cap.cap;
+
+		if (bfee)
+			return mvif->cap.vht_su_ebfee &&
+			       (cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
+		else
+			return mvif->cap.vht_su_ebfer &&
+			       (cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
+	}
+
+	return false;
+}
+
 static void
 mt7915_mcu_sta_sounding_rate(struct sta_rec_bf *bf)
 {
@@ -1880,10 +1919,12 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 }
 
 static void
-mt7915_mcu_sta_bfer_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
-			struct ieee80211_vif *vif, struct mt7915_phy *phy,
-			bool enable, bool explicit)
+mt7915_mcu_sta_bfer_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
+			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_phy *phy =
+		mvif->band_idx ? mt7915_ext_phy(dev) : &dev->phy;
 	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
 	struct sta_rec_bf *bf;
 	struct tlv *tlv;
@@ -1893,25 +1934,23 @@ mt7915_mcu_sta_bfer_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 		{2, 4, 4, 0},	/* 3x1, 3x2, 3x3, 3x4 */
 		{3, 5, 6, 0}	/* 4x1, 4x2, 4x3, 4x4 */
 	};
+	bool ebf;
 
-#define MT_BFER_FREE		cpu_to_le16(GENMASK(15, 0))
+	ebf = mt7915_is_ebf_supported(phy, vif, sta, false);
+	if (!ebf && !dev->ibf)
+		return;
 
 	tlv = mt7915_mcu_add_tlv(skb, STA_REC_BF, sizeof(*bf));
 	bf = (struct sta_rec_bf *)tlv;
 
-	if (!enable) {
-		bf->pfmu = MT_BFER_FREE;
-		return;
-	}
-
 	/* he: eBF only, in accordance with spec
 	 * vht: support eBF and iBF
 	 * ht: iBF only, since mac80211 lacks of eBF support
 	 */
-	if (sta->he_cap.has_he && explicit)
+	if (sta->he_cap.has_he && ebf)
 		mt7915_mcu_sta_bfer_he(sta, vif, phy, bf);
 	else if (sta->vht_cap.vht_supported)
-		mt7915_mcu_sta_bfer_vht(sta, phy, bf, explicit);
+		mt7915_mcu_sta_bfer_vht(sta, phy, bf, ebf);
 	else if (sta->ht_cap.ht_supported)
 		mt7915_mcu_sta_bfer_ht(sta, phy, bf);
 	else
@@ -1921,12 +1960,12 @@ mt7915_mcu_sta_bfer_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	bf->ibf_dbw = sta->bandwidth;
 	bf->ibf_nrow = tx_ant;
 
-	if (!explicit && sta->bandwidth <= IEEE80211_STA_RX_BW_40 && !bf->nc)
+	if (!ebf && sta->bandwidth <= IEEE80211_STA_RX_BW_40 && !bf->nc)
 		bf->ibf_timeout = 0x48;
 	else
 		bf->ibf_timeout = 0x18;
 
-	if (explicit && bf->nr != tx_ant)
+	if (ebf && bf->nr != tx_ant)
 		bf->mem_20m = matrix[tx_ant][bf->nc];
 	else
 		bf->mem_20m = matrix[bf->nr][bf->nc];
@@ -1946,14 +1985,20 @@ mt7915_mcu_sta_bfer_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 }
 
 static void
-mt7915_mcu_sta_bfee_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
-			struct mt7915_phy *phy)
+mt7915_mcu_sta_bfee_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
+			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_phy *phy =
+		mvif->band_idx ? mt7915_ext_phy(dev) : &dev->phy;
 	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
 	struct sta_rec_bfee *bfee;
 	struct tlv *tlv;
 	u8 nr = 0;
 
+	if (!mt7915_is_ebf_supported(phy, vif, sta, true))
+		return;
+
 	tlv = mt7915_mcu_add_tlv(skb, STA_REC_BFEE, sizeof(*bfee));
 	bfee = (struct sta_rec_bfee *)tlv;
 
@@ -1979,68 +2024,20 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct mt7915_phy *phy;
 	struct sk_buff *skb;
-	int r, len;
-	bool ebfee = false, ebfer = false;
-
-	if (vif->type != NL80211_IFTYPE_STATION &&
-	    vif->type != NL80211_IFTYPE_AP)
-		return 0;
-
-	phy = mvif->band_idx ? mt7915_ext_phy(dev) : &dev->phy;
-
-	if (sta->he_cap.has_he) {
-		struct ieee80211_he_cap_elem *pe = &sta->he_cap.he_cap_elem;
-
-		ebfee = mvif->cap.he_su_ebfee &&
-			HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]);
-		ebfer = mvif->cap.he_su_ebfer &&
-			HE_PHY(CAP4_SU_BEAMFORMEE, pe->phy_cap_info[4]);
-	} else if (sta->vht_cap.vht_supported) {
-		u32 cap = sta->vht_cap.cap;
-
-		ebfee = mvif->cap.vht_su_ebfee &&
-			(cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
-		ebfer = mvif->cap.vht_su_ebfer &&
-			(cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
-	}
 
-	/* must keep each tag independent */
+	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
+				       MT7915_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
 
 	/* starec bf */
-	if (ebfer || dev->ibf) {
-		len = sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_bf);
-
-		skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
-		if (IS_ERR(skb))
-			return PTR_ERR(skb);
-
-		mt7915_mcu_sta_bfer_tlv(skb, sta, vif, phy, enable, ebfer);
-
-		r = mt76_mcu_skb_send_msg(&dev->mt76, skb,
-					  MCU_EXT_CMD(STA_REC_UPDATE), true);
-		if (r)
-			return r;
-	}
-
+	mt7915_mcu_sta_bfer_tlv(dev, skb, vif, sta);
 	/* starec bfee */
-	if (ebfee) {
-		len = sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_bfee);
-
-		skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
-		if (IS_ERR(skb))
-			return PTR_ERR(skb);
-
-		mt7915_mcu_sta_bfee_tlv(skb, sta, phy);
-
-		r = mt76_mcu_skb_send_msg(&dev->mt76, skb,
-					  MCU_EXT_CMD(STA_REC_UPDATE), true);
-		if (r)
-			return r;
-	}
+	mt7915_mcu_sta_bfee_tlv(dev, skb, vif, sta);
 
-	return 0;
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
 
 int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 9e966cfcf5a2..158c8e68c59e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -1001,7 +1001,7 @@ struct sta_rec_bf {
 	bool codebook75_mu;
 
 	u8 he_ltf;
-	u8 rsv[2];
+	u8 rsv[3];
 } __packed;
 
 struct sta_rec_bfee {
@@ -1102,12 +1102,14 @@ enum {
 
 #define MT7915_STA_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +	\
 					 sizeof(struct sta_rec_basic) +	\
+					 sizeof(struct sta_rec_bf) +	\
 					 sizeof(struct sta_rec_ht) +	\
 					 sizeof(struct sta_rec_he) +	\
 					 sizeof(struct sta_rec_ba) +	\
 					 sizeof(struct sta_rec_vht) +	\
 					 sizeof(struct sta_rec_uapsd) + \
 					 sizeof(struct sta_rec_amsdu) +	\
+					 sizeof(struct sta_rec_bfee) +	\
 					 sizeof(struct tlv) +		\
 					 MT7915_WTBL_UPDATE_MAX_SIZE)
 
-- 
2.25.1

