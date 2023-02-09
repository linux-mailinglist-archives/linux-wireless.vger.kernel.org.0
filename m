Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AF368FD10
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Feb 2023 03:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjBICXR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Feb 2023 21:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBICXQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Feb 2023 21:23:16 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB4128239
        for <linux-wireless@vger.kernel.org>; Wed,  8 Feb 2023 18:23:09 -0800 (PST)
X-UUID: ae2cf5b8a82011ed945fc101203acc17-20230209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FsLrxYbj4krUiykEoQl14R+px2DW7Svt2kq3hcFg6VM=;
        b=Fn2t2wBY1T5/3M47Z/eG9Xgm0kLm5cFyZ3gCV5QNJYJBz0ryfOZFMz4BcvIdiirmmGVxWVPwhkjLZlsmdq5SKMkYw2NpA5UzKkXukSZm11P2ZB5MnNzyX4g27K3/BKdlIVzgfzTpCCprMvGALAQOV0ICFko+ARDyjcLuwFwr5hg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:1b9b5617-98f0-4714-a181-caf6efbccb55,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:885ddb2,CLOUDID:f19cbb56-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: ae2cf5b8a82011ed945fc101203acc17-20230209
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1304624804; Thu, 09 Feb 2023 10:23:03 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 9 Feb 2023 10:23:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 9 Feb 2023 10:23:02 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] wifi: mt76: mt7996: remove mt7996_mcu_beacon_check_caps()
Date:   Thu, 9 Feb 2023 10:23:00 +0800
Message-ID: <b80c39ffbe4f866fc1afed1e05aedf6f2f709234.1675909168.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <067c3aef3c73e35ec9d633387e856db3ae66a81b.1675909168.git.ryder.lee@mediatek.com>
References: <067c3aef3c73e35ec9d633387e856db3ae66a81b.1675909168.git.ryder.lee@mediatek.com>
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
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   1 -
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 115 ++----------------
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  16 ---
 3 files changed, 8 insertions(+), 124 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 3e4da0350d96..9d67fcaf2428 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -220,7 +220,6 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
 
 	mt7996_init_bitrate_mask(vif);
-	memset(&mvif->cap, -1, sizeof(mvif->cap));
 
 	mt7996_mcu_add_bss_info(phy, vif, true);
 	mt7996_mcu_add_sta(dev, vif, NULL, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index dbe30832fd88..73395b8dfade 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1053,7 +1053,6 @@ static inline bool
 mt7996_is_ebf_supported(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta, bool bfee)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	int sts = hweight16(phy->mt76->chainmask);
 
 	if (vif->type != NL80211_IFTYPE_STATION &&
@@ -1068,10 +1067,10 @@ mt7996_is_ebf_supported(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 		struct ieee80211_eht_cap_elem_fixed *pe = &pc->eht_cap_elem;
 
 		if (bfee)
-			return mvif->cap.eht_su_ebfee &&
+			return vif->bss_conf.eht_su_beamformee &&
 			       EHT_PHY(CAP0_SU_BEAMFORMEE, pe->phy_cap_info[0]);
 		else
-			return mvif->cap.eht_su_ebfer &&
+			return vif->bss_conf.eht_su_beamformer &&
 			       EHT_PHY(CAP0_SU_BEAMFORMER, pe->phy_cap_info[0]);
 	}
 
@@ -1079,10 +1078,10 @@ mt7996_is_ebf_supported(struct mt7996_phy *phy, struct ieee80211_vif *vif,
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
 
@@ -1090,10 +1089,10 @@ mt7996_is_ebf_supported(struct mt7996_phy *phy, struct ieee80211_vif *vif,
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
 
@@ -1572,7 +1571,7 @@ mt7996_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7996_dev *dev,
 			cap |= STA_CAP_TX_STBC;
 		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
 			cap |= STA_CAP_RX_STBC;
-		if (mvif->cap.ht_ldpc &&
+		if (vif->bss_conf.ht_ldpc &&
 		    (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING))
 			cap |= STA_CAP_LDPC;
 
@@ -1598,7 +1597,7 @@ mt7996_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7996_dev *dev,
 			cap |= STA_CAP_VHT_TX_STBC;
 		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_1)
 			cap |= STA_CAP_VHT_RX_STBC;
-		if (mvif->cap.vht_ldpc &&
+		if (vif->bss_conf.vht_ldpc &&
 		    (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC))
 			cap |= STA_CAP_VHT_LDPC;
 
@@ -1911,102 +1910,6 @@ mt7996_mcu_beacon_cont(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 }
 
-static void
-mt7996_mcu_beacon_check_caps(struct mt7996_phy *phy, struct ieee80211_vif *vif,
-			     struct sk_buff *skb)
-{
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_vif_cap *vc = &mvif->cap;
-	const struct ieee80211_eht_cap_elem_fixed *eht;
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
-		vc->ht_ldpc |= !!(le16_to_cpu(ht->cap_info) &
-				  IEEE80211_HT_CAP_LDPC_CODING);
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
-		vc->vht_ldpc |= !!(bc & IEEE80211_VHT_CAP_RXLDPC);
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
-
-	ie = cfg80211_find_ext_ie(WLAN_EID_EXT_EHT_CAPABILITY,
-				  mgmt->u.beacon.variable, len);
-	if (ie && ie[1] >= sizeof(*eht) + 1) {
-		const struct ieee80211_sta_eht_cap *pc =
-			mt76_connac_get_eht_phy_cap(phy->mt76, vif);
-		const struct ieee80211_eht_cap_elem_fixed *pe = &pc->eht_cap_elem;
-
-		eht = (void *)(ie + 3);
-
-		vc->eht_su_ebfer =
-			EHT_PHY(CAP0_SU_BEAMFORMER, eht->phy_cap_info[0]) &&
-			EHT_PHY(CAP0_SU_BEAMFORMER, pe->phy_cap_info[0]);
-		vc->eht_su_ebfee =
-			EHT_PHY(CAP0_SU_BEAMFORMEE, eht->phy_cap_info[0]) &&
-			EHT_PHY(CAP0_SU_BEAMFORMEE, pe->phy_cap_info[0]);
-	}
-}
-
 int mt7996_mcu_add_beacon(struct ieee80211_hw *hw,
 			  struct ieee80211_vif *vif, int en)
 {
@@ -2045,8 +1948,6 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw,
 	info = IEEE80211_SKB_CB(skb);
 	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->mt76->band_idx);
 
-	mt7996_mcu_beacon_check_caps(phy, vif, skb);
-
 	mt7996_mcu_beacon_cont(dev, vif, rskb, skb, bcn, &offs);
 	/* TODO: subtag - 11v MBSSID */
 	mt7996_mcu_beacon_cntdwn(vif, rskb, skb, &offs);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 018dfd2b36b0..24572dd55fe0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -112,25 +112,9 @@ struct mt7996_sta {
 	} twt;
 };
 
-struct mt7996_vif_cap {
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
-	bool eht_su_ebfer:1;
-	bool eht_su_ebfee:1;
-};
-
 struct mt7996_vif {
 	struct mt76_vif mt76; /* must be first */
 
-	struct mt7996_vif_cap cap;
 	struct mt7996_sta sta;
 	struct mt7996_phy *phy;
 
-- 
2.18.0

