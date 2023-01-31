Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6716828FC
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 10:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjAaJgu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Jan 2023 04:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjAaJgp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Jan 2023 04:36:45 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39D029173
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 01:36:41 -0800 (PST)
X-UUID: bea6cf36a14a11eda06fc9ecc4dadd91-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wNfx7FGvG7X4Z4ndngPdSIl2aXRGHMpHbS/YBVbiKHg=;
        b=mgHbx+M3/VXEH8h1rp3WUZ94YTy/7DyXQhtLXDIwjZ6IU13ka3fEbHcHcauXeUS61Mhgkj+QQPzElar/U5TnQxVy9DaSh2Ci4Gn2aBOxpn7+ZsjVJlFrNpb/npUerpqHd12/qGJ4QiiurHEW4pH3uHYB65YGJjOVLKa43tLZ1Aw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:6f75879d-d530-445c-95b0-2ebc582e5640,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.18,REQID:6f75879d-d530-445c-95b0-2ebc582e5640,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:3ca2d6b,CLOUDID:b732758d-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230131173634WB0XZU6S,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-BVR: 0
X-UUID: bea6cf36a14a11eda06fc9ecc4dadd91-20230131
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 634403781; Tue, 31 Jan 2023 17:36:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 31 Jan 2023 17:36:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 31 Jan 2023 17:36:30 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 13/13] wifi: mt76: mt7996: add EHT beamforming support
Date:   Tue, 31 Jan 2023 17:36:11 +0800
Message-ID: <20230131093611.30914-14-shayne.chen@mediatek.com>
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

From: MeiChia Chiu <meichia.chiu@mediatek.com>

Add mt7996_mcu_sta_bfer_eht() and related capability checks.

Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 99 ++++++++++++++++++-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  2 +
 2 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index e985b767a6c0..7aa290774570 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -70,6 +70,7 @@ struct mt7996_fw_region {
 
 #define HE_PHY(p, c)			u8_get_bits(c, IEEE80211_HE_PHY_##p)
 #define HE_MAC(m, c)			u8_get_bits(c, IEEE80211_HE_MAC_##m)
+#define EHT_PHY(p, c)			u8_get_bits(c, IEEE80211_EHT_PHY_##p)
 
 static bool sr_scene_detect = true;
 module_param(sr_scene_detect, bool, 0644);
@@ -1053,15 +1054,27 @@ mt7996_is_ebf_supported(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta, bool bfee)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	int tx_ant = hweight8(phy->mt76->antenna_mask) - 1;
+	int sts = hweight16(phy->mt76->chainmask);
 
 	if (vif->type != NL80211_IFTYPE_STATION &&
 	    vif->type != NL80211_IFTYPE_AP)
 		return false;
 
-	if (!bfee && tx_ant < 2)
+	if (!bfee && sts < 2)
 		return false;
 
+	if (sta->deflink.eht_cap.has_eht) {
+		struct ieee80211_sta_eht_cap *pc = &sta->deflink.eht_cap;
+		struct ieee80211_eht_cap_elem_fixed *pe = &pc->eht_cap_elem;
+
+		if (bfee)
+			return mvif->cap.eht_su_ebfee &&
+			       EHT_PHY(CAP0_SU_BEAMFORMEE, pe->phy_cap_info[0]);
+		else
+			return mvif->cap.eht_su_ebfer &&
+			       EHT_PHY(CAP0_SU_BEAMFORMER, pe->phy_cap_info[0]);
+	}
+
 	if (sta->deflink.he_cap.has_he) {
 		struct ieee80211_he_cap_elem *pe = &sta->deflink.he_cap.he_cap_elem;
 
@@ -1218,13 +1231,69 @@ mt7996_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 	bf->nrow_gt_bw80 = min_t(int, snd_dim, sts);
 }
 
+static void
+mt7996_mcu_sta_bfer_eht(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
+			struct mt7996_phy *phy, struct sta_rec_bf *bf)
+{
+	struct ieee80211_sta_eht_cap *pc = &sta->deflink.eht_cap;
+	struct ieee80211_eht_cap_elem_fixed *pe = &pc->eht_cap_elem;
+	struct ieee80211_eht_mcs_nss_supp *eht_nss = &pc->eht_mcs_nss_supp;
+	const struct ieee80211_sta_eht_cap *vc =
+		mt76_connac_get_eht_phy_cap(phy->mt76, vif);
+	const struct ieee80211_eht_cap_elem_fixed *ve = &vc->eht_cap_elem;
+	u8 nss_mcs = u8_get_bits(eht_nss->bw._80.rx_tx_mcs9_max_nss,
+				 IEEE80211_EHT_MCS_NSS_RX) - 1;
+	u8 snd_dim, sts;
+
+	bf->tx_mode = MT_PHY_TYPE_EHT_MU;
+
+	mt7996_mcu_sta_sounding_rate(bf);
+
+	bf->trigger_su = EHT_PHY(CAP3_TRIG_SU_BF_FDBK, pe->phy_cap_info[3]);
+	bf->trigger_mu = EHT_PHY(CAP3_TRIG_MU_BF_PART_BW_FDBK, pe->phy_cap_info[3]);
+	snd_dim = EHT_PHY(CAP2_SOUNDING_DIM_80MHZ_MASK, ve->phy_cap_info[2]);
+	sts = EHT_PHY(CAP0_BEAMFORMEE_SS_80MHZ_MASK, pe->phy_cap_info[0]) +
+	      (EHT_PHY(CAP1_BEAMFORMEE_SS_80MHZ_MASK, pe->phy_cap_info[1]) << 1);
+	bf->nrow = min_t(u8, snd_dim, sts);
+	bf->ncol = min_t(u8, nss_mcs, bf->nrow);
+	bf->ibf_ncol = bf->ncol;
+
+	if (sta->deflink.bandwidth < IEEE80211_STA_RX_BW_160)
+		return;
+
+	switch (sta->deflink.bandwidth) {
+	case IEEE80211_STA_RX_BW_160:
+		snd_dim = EHT_PHY(CAP2_SOUNDING_DIM_160MHZ_MASK, ve->phy_cap_info[2]);
+		sts = EHT_PHY(CAP1_BEAMFORMEE_SS_160MHZ_MASK, pe->phy_cap_info[1]);
+		nss_mcs = u8_get_bits(eht_nss->bw._160.rx_tx_mcs9_max_nss,
+				      IEEE80211_EHT_MCS_NSS_RX) - 1;
+
+		bf->nrow_gt_bw80 = min_t(u8, snd_dim, sts);
+		bf->ncol_gt_bw80 = nss_mcs;
+		break;
+	case IEEE80211_STA_RX_BW_320:
+		snd_dim = EHT_PHY(CAP2_SOUNDING_DIM_320MHZ_MASK, ve->phy_cap_info[2]) +
+			  (EHT_PHY(CAP3_SOUNDING_DIM_320MHZ_MASK,
+				   ve->phy_cap_info[3]) << 1);
+		sts = EHT_PHY(CAP1_BEAMFORMEE_SS_320MHZ_MASK, pe->phy_cap_info[1]);
+		nss_mcs = u8_get_bits(eht_nss->bw._320.rx_tx_mcs9_max_nss,
+				      IEEE80211_EHT_MCS_NSS_RX) - 1;
+
+		bf->nrow_gt_bw80 = min_t(u8, snd_dim, sts) << 4;
+		bf->ncol_gt_bw80 = nss_mcs << 4;
+		break;
+	default:
+		break;
+	}
+}
+
 static void
 mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_phy *phy = mvif->phy;
-	int tx_ant = hweight8(phy->mt76->antenna_mask) - 1;
+	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
 	struct sta_rec_bf *bf;
 	struct tlv *tlv;
 	const u8 matrix[4][4] = {
@@ -1245,11 +1314,13 @@ mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BF, sizeof(*bf));
 	bf = (struct sta_rec_bf *)tlv;
 
-	/* he: eBF only, in accordance with spec
+	/* he/eht: eBF only, in accordance with spec
 	 * vht: support eBF and iBF
 	 * ht: iBF only, since mac80211 lacks of eBF support
 	 */
-	if (sta->deflink.he_cap.has_he && ebf)
+	if (sta->deflink.eht_cap.has_eht && ebf)
+		mt7996_mcu_sta_bfer_eht(sta, vif, phy, bf);
+	else if (sta->deflink.he_cap.has_he && ebf)
 		mt7996_mcu_sta_bfer_he(sta, vif, phy, bf);
 	else if (sta->deflink.vht_cap.vht_supported)
 		mt7996_mcu_sta_bfer_vht(sta, phy, bf, ebf);
@@ -1846,6 +1917,7 @@ mt7996_mcu_beacon_check_caps(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_vif_cap *vc = &mvif->cap;
+	const struct ieee80211_eht_cap_elem_fixed *eht;
 	const struct ieee80211_he_cap_elem *he;
 	const struct ieee80211_vht_cap *vht;
 	const struct ieee80211_ht_cap *ht;
@@ -1916,6 +1988,23 @@ mt7996_mcu_beacon_check_caps(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 			HE_PHY(CAP4_MU_BEAMFORMER, he->phy_cap_info[4]) &&
 			HE_PHY(CAP4_MU_BEAMFORMER, pe->phy_cap_info[4]);
 	}
+
+	ie = cfg80211_find_ext_ie(WLAN_EID_EXT_EHT_CAPABILITY,
+				  mgmt->u.beacon.variable, len);
+	if (ie && ie[1] >= sizeof(*eht) + 1) {
+		const struct ieee80211_sta_eht_cap *pc =
+			mt76_connac_get_eht_phy_cap(phy->mt76, vif);
+		const struct ieee80211_eht_cap_elem_fixed *pe = &pc->eht_cap_elem;
+
+		eht = (void *)(ie + 3);
+
+		vc->eht_su_ebfer =
+			EHT_PHY(CAP0_SU_BEAMFORMER, eht->phy_cap_info[0]) &&
+			EHT_PHY(CAP0_SU_BEAMFORMER, pe->phy_cap_info[0]);
+		vc->eht_su_ebfee =
+			EHT_PHY(CAP0_SU_BEAMFORMEE, eht->phy_cap_info[0]) &&
+			EHT_PHY(CAP0_SU_BEAMFORMEE, pe->phy_cap_info[0]);
+	}
 }
 
 int mt7996_mcu_add_beacon(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 179d753d7a56..13f22432197e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -123,6 +123,8 @@ struct mt7996_vif_cap {
 	bool he_su_ebfer:1;
 	bool he_su_ebfee:1;
 	bool he_mu_ebfer:1;
+	bool eht_su_ebfer:1;
+	bool eht_su_ebfee:1;
 };
 
 struct mt7996_vif {
-- 
2.25.1

