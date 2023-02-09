Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9C668FD0F
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Feb 2023 03:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjBICXN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Feb 2023 21:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjBICXM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Feb 2023 21:23:12 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E637928232
        for <linux-wireless@vger.kernel.org>; Wed,  8 Feb 2023 18:23:06 -0800 (PST)
X-UUID: ad50ba9ea82011eda06fc9ecc4dadd91-20230209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yrnF3sAxbRRNDa3kxp+/8GBxkm0uAx3CdNs5GG5aWfA=;
        b=LX0EZWoJYF6u8lfCissCrV1lVo+X4NiAxUuGs1okbzPX+SNq+EnBpx5JoWcGn7sTMdtV5DdRwc8V4SGot+p4sKGLJqBk8T9npHgNEezEJLe2NaIXuwST1JuiiZu9a0VAcJroSSszS8aHezIUnBSu2ip5G2u2PJwTG9j4Bi7CjBQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:d0a15484-5053-4423-bafc-92cf36ca933e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:8b65e5f7-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: ad50ba9ea82011eda06fc9ecc4dadd91-20230209
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1676181559; Thu, 09 Feb 2023 10:23:01 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 9 Feb 2023 10:23:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 9 Feb 2023 10:23:01 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] wifi: mt76: mt7915: remove mt7915_mcu_beacon_check_caps()
Date:   Thu, 9 Feb 2023 10:22:59 +0800
Message-ID: <067c3aef3c73e35ec9d633387e856db3ae66a81b.1675909168.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Those capabilities have been added into ieee80211_bss_conf.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
This series depends on https://patchwork.kernel.org/project/linux-wireless/list/?series=720095
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   1 -
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 107 ++----------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  14 ---
 3 files changed, 12 insertions(+), 110 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3bbccbdfc5eb..2ada2806de66 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -269,7 +269,6 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
 
 	mt7915_init_bitrate_mask(vif);
-	memset(&mvif->cap, -1, sizeof(mvif->cap));
 
 	mt7915_mcu_add_bss_info(phy, vif, true);
 	mt7915_mcu_add_sta(dev, vif, NULL, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 5545a8bdf1d0..dfcb13c9c7ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -706,7 +706,6 @@ static void
 mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 		      struct ieee80211_vif *vif)
 {
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct ieee80211_he_cap_elem *elem = &sta->deflink.he_cap.he_cap_elem;
 	struct ieee80211_he_mcs_nss_supp mcs_map;
 	struct sta_rec_he *he;
@@ -740,7 +739,7 @@ mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G))
 		cap |= STA_REC_HE_CAP_BW20_RU242_SUPPORT;
 
-	if (mvif->cap.he_ldpc &&
+	if (vif->bss_conf.he_ldpc &&
 	    (elem->phy_cap_info[1] &
 	     IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
 		cap |= STA_REC_HE_CAP_LDPC;
@@ -849,7 +848,6 @@ static void
 mt7915_mcu_sta_muru_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 			struct ieee80211_sta *sta, struct ieee80211_vif *vif)
 {
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct ieee80211_he_cap_elem *elem = &sta->deflink.he_cap.he_cap_elem;
 	struct sta_rec_muru *muru;
 	struct tlv *tlv;
@@ -862,9 +860,9 @@ mt7915_mcu_sta_muru_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 
 	muru = (struct sta_rec_muru *)tlv;
 
-	muru->cfg.mimo_dl_en = mvif->cap.he_mu_ebfer ||
-			       mvif->cap.vht_mu_ebfer ||
-			       mvif->cap.vht_mu_ebfee;
+	muru->cfg.mimo_dl_en = vif->bss_conf.he_mu_beamformer ||
+			       vif->bss_conf.vht_mu_beamformer ||
+			       vif->bss_conf.vht_mu_beamformee;
 	if (!is_mt7915(&dev->mt76))
 		muru->cfg.mimo_ul_en = true;
 	muru->cfg.ofdma_dl_en = true;
@@ -997,8 +995,8 @@ mt7915_mcu_sta_wtbl_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, wcid, tlv, wtbl_hdr);
 	if (sta)
 		mt76_connac_mcu_wtbl_ht_tlv(&dev->mt76, skb, sta, tlv,
-					    wtbl_hdr, mvif->cap.ht_ldpc,
-					    mvif->cap.vht_ldpc);
+					    wtbl_hdr, vif->bss_conf.ht_ldpc,
+					    vif->bss_conf.vht_ldpc);
 
 	return 0;
 }
@@ -1007,7 +1005,6 @@ static inline bool
 mt7915_is_ebf_supported(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta, bool bfee)
 {
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
 
 	if (vif->type != NL80211_IFTYPE_STATION &&
@@ -1021,10 +1018,10 @@ mt7915_is_ebf_supported(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 		struct ieee80211_he_cap_elem *pe = &sta->deflink.he_cap.he_cap_elem;
 
 		if (bfee)
-			return mvif->cap.he_su_ebfee &&
+			return vif->bss_conf.he_su_beamformee &&
 			       HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]);
 		else
-			return mvif->cap.he_su_ebfer &&
+			return vif->bss_conf.he_su_beamformer &&
 			       HE_PHY(CAP4_SU_BEAMFORMEE, pe->phy_cap_info[4]);
 	}
 
@@ -1032,10 +1029,10 @@ mt7915_is_ebf_supported(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 		u32 cap = sta->deflink.vht_cap.cap;
 
 		if (bfee)
-			return mvif->cap.vht_su_ebfee &&
+			return vif->bss_conf.vht_su_beamformee &&
 			       (cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
 		else
-			return mvif->cap.vht_su_ebfer &&
+			return vif->bss_conf.vht_su_beamformer &&
 			       (cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
 	}
 
@@ -1530,7 +1527,7 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 			cap |= STA_CAP_TX_STBC;
 		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
 			cap |= STA_CAP_RX_STBC;
-		if (mvif->cap.ht_ldpc &&
+		if (vif->bss_conf.ht_ldpc &&
 		    (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING))
 			cap |= STA_CAP_LDPC;
 
@@ -1556,7 +1553,7 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 			cap |= STA_CAP_VHT_TX_STBC;
 		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_1)
 			cap |= STA_CAP_VHT_RX_STBC;
-		if (mvif->cap.vht_ldpc &&
+		if (vif->bss_conf.vht_ldpc &&
 		    (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC))
 			cap |= STA_CAP_VHT_LDPC;
 
@@ -1875,84 +1872,6 @@ mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 }
 
-static void
-mt7915_mcu_beacon_check_caps(struct mt7915_phy *phy, struct ieee80211_vif *vif,
-			     struct sk_buff *skb)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_vif_cap *vc = &mvif->cap;
-	const struct ieee80211_he_cap_elem *he;
-	const struct ieee80211_vht_cap *vht;
-	const struct ieee80211_ht_cap *ht;
-	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
-	const u8 *ie;
-	u32 len, bc;
-
-	/* Check missing configuration options to allow AP mode in mac80211
-	 * to remain in sync with hostapd settings, and get a subset of
-	 * beacon and hardware capabilities.
-	 */
-	if (WARN_ON_ONCE(skb->len <= (mgmt->u.beacon.variable - skb->data)))
-		return;
-
-	memset(vc, 0, sizeof(*vc));
-
-	len = skb->len - (mgmt->u.beacon.variable - skb->data);
-
-	ie = cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, mgmt->u.beacon.variable,
-			      len);
-	if (ie && ie[1] >= sizeof(*ht)) {
-		ht = (void *)(ie + 2);
-		vc->ht_ldpc = !!(le16_to_cpu(ht->cap_info) &
-				 IEEE80211_HT_CAP_LDPC_CODING);
-	}
-
-	ie = cfg80211_find_ie(WLAN_EID_VHT_CAPABILITY, mgmt->u.beacon.variable,
-			      len);
-	if (ie && ie[1] >= sizeof(*vht)) {
-		u32 pc = phy->mt76->sband_5g.sband.vht_cap.cap;
-
-		vht = (void *)(ie + 2);
-		bc = le32_to_cpu(vht->vht_cap_info);
-
-		vc->vht_ldpc = !!(bc & IEEE80211_VHT_CAP_RXLDPC);
-		vc->vht_su_ebfer =
-			(bc & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE) &&
-			(pc & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
-		vc->vht_su_ebfee =
-			(bc & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE) &&
-			(pc & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
-		vc->vht_mu_ebfer =
-			(bc & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE) &&
-			(pc & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE);
-		vc->vht_mu_ebfee =
-			(bc & IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE) &&
-			(pc & IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
-	}
-
-	ie = cfg80211_find_ext_ie(WLAN_EID_EXT_HE_CAPABILITY,
-				  mgmt->u.beacon.variable, len);
-	if (ie && ie[1] >= sizeof(*he) + 1) {
-		const struct ieee80211_sta_he_cap *pc =
-			mt76_connac_get_he_phy_cap(phy->mt76, vif);
-		const struct ieee80211_he_cap_elem *pe = &pc->he_cap_elem;
-
-		he = (void *)(ie + 3);
-
-		vc->he_ldpc =
-			HE_PHY(CAP1_LDPC_CODING_IN_PAYLOAD, pe->phy_cap_info[1]);
-		vc->he_su_ebfer =
-			HE_PHY(CAP3_SU_BEAMFORMER, he->phy_cap_info[3]) &&
-			HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]);
-		vc->he_su_ebfee =
-			HE_PHY(CAP4_SU_BEAMFORMEE, he->phy_cap_info[4]) &&
-			HE_PHY(CAP4_SU_BEAMFORMEE, pe->phy_cap_info[4]);
-		vc->he_mu_ebfer =
-			HE_PHY(CAP4_MU_BEAMFORMER, he->phy_cap_info[4]) &&
-			HE_PHY(CAP4_MU_BEAMFORMER, pe->phy_cap_info[4]);
-	}
-}
-
 static void
 mt7915_mcu_beacon_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 				struct sk_buff *rskb, struct bss_info_bcn *bcn,
@@ -2063,8 +1982,6 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	info = IEEE80211_SKB_CB(skb);
 	info->hw_queue = FIELD_PREP(MT_TX_HW_QUEUE_PHY, ext_phy);
 
-	mt7915_mcu_beacon_check_caps(phy, vif, skb);
-
 	mt7915_mcu_beacon_cntdwn(vif, rskb, skb, bcn, &offs);
 	mt7915_mcu_beacon_mbss(rskb, skb, vif, bcn, &offs);
 	mt7915_mcu_beacon_cont(dev, vif, rskb, skb, bcn, &offs);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 3cbfb9b6a305..e4016cef9447 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -147,23 +147,9 @@ struct mt7915_sta {
 	} twt;
 };
 
-struct mt7915_vif_cap {
-	bool ht_ldpc:1;
-	bool vht_ldpc:1;
-	bool he_ldpc:1;
-	bool vht_su_ebfer:1;
-	bool vht_su_ebfee:1;
-	bool vht_mu_ebfer:1;
-	bool vht_mu_ebfee:1;
-	bool he_su_ebfer:1;
-	bool he_su_ebfee:1;
-	bool he_mu_ebfer:1;
-};
-
 struct mt7915_vif {
 	struct mt76_vif mt76; /* must be first */
 
-	struct mt7915_vif_cap cap;
 	struct mt7915_sta sta;
 	struct mt7915_phy *phy;
 
-- 
2.18.0

