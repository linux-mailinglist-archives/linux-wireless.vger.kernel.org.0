Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDFC47930F
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 18:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbhLQRtG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 12:49:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38452 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239171AbhLQRtG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 12:49:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A3F8622F8
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 17:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD76C36AE8;
        Fri, 17 Dec 2021 17:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639763345;
        bh=QZieOEem/oK6gUG6mviang4MlAUJx6P9lFOGjo9nrwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rkmuwVHQXiY+9aX6cSYdiAL3LipYhSPLQcnJ6YunoRs/dCPA1odDBOhp5GC7MSSy4
         f+9zotEYu2Nlkhd5lNWXgR/28GSyNyUnx7YyLfyS09Ynzk7YHYfL8LA07loKanVeVJ
         d8dAsbO1pc4PpIWnC35+IWushxEC6PM/nnIIfE4eZVLc0A/3A462vlN9uSnDPxY9HP
         hYjDIYEGU5TBPMwlyMFhjLujBQzZxe4MnEeCHit9WoyyjAh5JO91UEw7o00K7buacc
         eKL3z7HylCuLGehxpCMpnFKS70WxiO6GomsEf82gNgMQpEb1SYiAtPP4tddM9UzN1+
         VmRcVtriF0vAg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 3/7] mt76: mt7915: rely on mt76_connac_mcu_add_tlv routine
Date:   Fri, 17 Dec 2021 18:48:47 +0100
Message-Id: <2e84fa2254b952031a646f7e7ca99e9e97757326.1639763123.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639763123.git.lorenzo@kernel.org>
References: <cover.1639763123.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on common code available in mt76-connac module and remove
mt7915_mcu_add_tlv/mt7915_mcu_add_nested_tlv in mt7915 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 122 +++++++-----------
 1 file changed, 45 insertions(+), 77 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 840df0498676..771dae905864 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -574,39 +574,6 @@ void mt7915_mcu_rx_event(struct mt7915_dev *dev, struct sk_buff *skb)
 		mt76_mcu_rx_event(&dev->mt76, skb);
 }
 
-static struct tlv *
-mt7915_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
-			  void *sta_ntlv, void *sta_wtbl)
-{
-	struct sta_ntlv_hdr *ntlv_hdr = sta_ntlv;
-	struct tlv *sta_hdr = sta_wtbl;
-	struct tlv *ptlv, tlv = {
-		.tag = cpu_to_le16(tag),
-		.len = cpu_to_le16(len),
-	};
-	u16 ntlv;
-
-	ptlv = skb_put(skb, len);
-	memcpy(ptlv, &tlv, sizeof(tlv));
-
-	ntlv = le16_to_cpu(ntlv_hdr->tlv_num);
-	ntlv_hdr->tlv_num = cpu_to_le16(ntlv + 1);
-
-	if (sta_hdr) {
-		u16 size = le16_to_cpu(sta_hdr->len);
-
-		sta_hdr->len = cpu_to_le16(size + len);
-	}
-
-	return ptlv;
-}
-
-static struct tlv *
-mt7915_mcu_add_tlv(struct sk_buff *skb, int tag, int len)
-{
-	return mt7915_mcu_add_nested_tlv(skb, tag, len, skb->data, NULL);
-}
-
 static struct tlv *
 mt7915_mcu_add_nested_subtlv(struct sk_buff *skb, int sub_tag, int sub_len,
 			     __le16 *sub_ntlv, __le16 *len)
@@ -636,7 +603,7 @@ mt7915_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	u32 type = NETWORK_INFRA;
 	struct tlv *tlv;
 
-	tlv = mt7915_mcu_add_tlv(skb, BSS_INFO_BASIC, sizeof(*bss));
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_BASIC, sizeof(*bss));
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
@@ -697,7 +664,7 @@ mt7915_mcu_bss_omac_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 	u32 type = 0;
 	u8 idx;
 
-	tlv = mt7915_mcu_add_tlv(skb, BSS_INFO_OMAC, sizeof(*omac));
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_OMAC, sizeof(*omac));
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_MONITOR:
@@ -777,7 +744,7 @@ mt7915_mcu_bss_rfch_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct tlv *tlv;
 	int freq1 = chandef->center_freq1;
 
-	tlv = mt7915_mcu_add_tlv(skb, BSS_INFO_RF_CH, sizeof(*ch));
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_RF_CH, sizeof(*ch));
 
 	ch = (struct bss_info_rf_ch *)tlv;
 	ch->pri_ch = chandef->chan->hw_value;
@@ -814,7 +781,7 @@ mt7915_mcu_bss_ra_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct bss_info_ra *ra;
 	struct tlv *tlv;
 
-	tlv = mt7915_mcu_add_tlv(skb, BSS_INFO_RA, sizeof(*ra));
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_RA, sizeof(*ra));
 
 	ra = (struct bss_info_ra *)tlv;
 	ra->op_mode = vif->type == NL80211_IFTYPE_AP;
@@ -844,7 +811,7 @@ mt7915_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 
 	cap = mt7915_get_he_phy_cap(phy, vif);
 
-	tlv = mt7915_mcu_add_tlv(skb, BSS_INFO_HE_BASIC, sizeof(*he));
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_HE_BASIC, sizeof(*he));
 
 	he = (struct bss_info_he *)tlv;
 	he->he_pe_duration = vif->bss_conf.htc_trig_based_pkt_ext;
@@ -868,7 +835,7 @@ mt7915_mcu_bss_hw_amsdu_tlv(struct sk_buff *skb)
 	struct bss_info_hw_amsdu *amsdu;
 	struct tlv *tlv;
 
-	tlv = mt7915_mcu_add_tlv(skb, BSS_INFO_HW_AMSDU, sizeof(*amsdu));
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_HW_AMSDU, sizeof(*amsdu));
 
 	amsdu = (struct bss_info_hw_amsdu *)tlv;
 	amsdu->cmp_bitmap_0 = cpu_to_le32(TXD_CMP_MAP1);
@@ -890,7 +857,7 @@ mt7915_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt7915_vif *mvif)
 	if (ext_bss_idx < 0)
 		return;
 
-	tlv = mt7915_mcu_add_tlv(skb, BSS_INFO_EXT_BSS, sizeof(*ext));
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_EXT_BSS, sizeof(*ext));
 
 	ext = (struct bss_info_ext_bss *)tlv;
 	tsf_offset = ext_bss_idx * BCN_TX_ESTIMATE_TIME;
@@ -905,7 +872,7 @@ mt7915_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt7915_phy *phy)
 	enum nl80211_band band = chandef->chan->band;
 	struct tlv *tlv;
 
-	tlv = mt7915_mcu_add_tlv(skb, BSS_INFO_BMC_RATE, sizeof(*bmc));
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_BMC_RATE, sizeof(*bmc));
 
 	bmc = (struct bss_info_bmc_rate *)tlv;
 	if (band == NL80211_BAND_2GHZ) {
@@ -1008,7 +975,7 @@ mt7915_mcu_sta_key_tlv(struct mt7915_sta *msta, struct sk_buff *skb,
 	struct tlv *tlv;
 	u32 len = sizeof(*sec);
 
-	tlv = mt7915_mcu_add_tlv(skb, STA_REC_KEY_V2, sizeof(*sec));
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V2, sizeof(*sec));
 
 	sec = (struct sta_rec_sec *)tlv;
 	sec->add = cmd;
@@ -1096,7 +1063,7 @@ mt7915_mcu_sta_ba_tlv(struct sk_buff *skb,
 	struct sta_rec_ba *ba;
 	struct tlv *tlv;
 
-	tlv = mt7915_mcu_add_tlv(skb, STA_REC_BA, sizeof(*ba));
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BA, sizeof(*ba));
 
 	ba = (struct sta_rec_ba *)tlv;
 	ba->ba_type = tx ? MT_BA_TYPE_ORIGINATOR : MT_BA_TYPE_RECIPIENT;
@@ -1116,8 +1083,8 @@ mt7915_mcu_wtbl_ba_tlv(struct sk_buff *skb,
 	struct wtbl_ba *ba;
 	struct tlv *tlv;
 
-	tlv = mt7915_mcu_add_nested_tlv(skb, WTBL_BA, sizeof(*ba),
-					wtbl_tlv, sta_wtbl);
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_BA, sizeof(*ba),
+					     wtbl_tlv, sta_wtbl);
 
 	ba = (struct wtbl_ba *)tlv;
 	ba->tid = params->tid;
@@ -1158,8 +1125,8 @@ mt7915_mcu_sta_ba(struct mt7915_dev *dev,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	sta_wtbl = mt7915_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
-
+	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
+					   sizeof(struct tlv));
 	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
 						  WTBL_SET, sta_wtbl, &skb);
 	if (IS_ERR(wtbl_hdr))
@@ -1207,9 +1174,9 @@ mt7915_mcu_wtbl_generic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct wtbl_rx *rx;
 	struct tlv *tlv;
 
-	tlv = mt7915_mcu_add_nested_tlv(skb, WTBL_GENERIC, sizeof(*generic),
-					wtbl_tlv, sta_wtbl);
-
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_GENERIC,
+					     sizeof(*generic),
+					     wtbl_tlv, sta_wtbl);
 	generic = (struct wtbl_generic *)tlv;
 
 	if (sta) {
@@ -1228,9 +1195,8 @@ mt7915_mcu_wtbl_generic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		generic->muar_idx = 0xe;
 	}
 
-	tlv = mt7915_mcu_add_nested_tlv(skb, WTBL_RX, sizeof(*rx),
-					wtbl_tlv, sta_wtbl);
-
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_RX, sizeof(*rx),
+					     wtbl_tlv, sta_wtbl);
 	rx = (struct wtbl_rx *)tlv;
 	rx->rca1 = sta ? vif->type != NL80211_IFTYPE_AP : 1;
 	rx->rca2 = 1;
@@ -1246,7 +1212,7 @@ mt7915_mcu_sta_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct sta_rec_basic *basic;
 	struct tlv *tlv;
 
-	tlv = mt7915_mcu_add_tlv(skb, STA_REC_BASIC, sizeof(*basic));
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BASIC, sizeof(*basic));
 
 	basic = (struct sta_rec_basic *)tlv;
 	basic->extra_info = cpu_to_le16(EXTRA_INFO_VER);
@@ -1301,7 +1267,7 @@ mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	if (!sta->he_cap.has_he)
 		return;
 
-	tlv = mt7915_mcu_add_tlv(skb, STA_REC_HE, sizeof(*he));
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HE, sizeof(*he));
 
 	he = (struct sta_rec_he *)tlv;
 
@@ -1438,7 +1404,7 @@ mt7915_mcu_sta_uapsd_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	if (vif->type != NL80211_IFTYPE_AP || !sta->wme)
 		return;
 
-	tlv = mt7915_mcu_add_tlv(skb, STA_REC_APPS, sizeof(*uapsd));
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_APPS, sizeof(*uapsd));
 	uapsd = (struct sta_rec_uapsd *)tlv;
 
 	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VO) {
@@ -1476,7 +1442,7 @@ mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	if (!sta->vht_cap.vht_supported)
 		return;
 
-	tlv = mt7915_mcu_add_tlv(skb, STA_REC_MURU, sizeof(*muru));
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_MURU, sizeof(*muru));
 
 	muru = (struct sta_rec_muru *)tlv;
 
@@ -1523,7 +1489,7 @@ mt7915_mcu_sta_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 	struct sta_rec_ht *ht;
 	struct tlv *tlv;
 
-	tlv = mt7915_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
 
 	ht = (struct sta_rec_ht *)tlv;
 	ht->ht_cap = cpu_to_le16(sta->ht_cap.cap);
@@ -1538,7 +1504,7 @@ mt7915_mcu_sta_vht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 	if (!sta->vht_cap.vht_supported)
 		return;
 
-	tlv = mt7915_mcu_add_tlv(skb, STA_REC_VHT, sizeof(*vht));
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_VHT, sizeof(*vht));
 
 	vht = (struct sta_rec_vht *)tlv;
 	vht->vht_cap = cpu_to_le32(sta->vht_cap.cap);
@@ -1561,7 +1527,7 @@ mt7915_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	if (!sta->max_amsdu_len)
 	    return;
 
-	tlv = mt7915_mcu_add_tlv(skb, STA_REC_HW_AMSDU, sizeof(*amsdu));
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HW_AMSDU, sizeof(*amsdu));
 	amsdu = (struct sta_rec_amsdu *)tlv;
 	amsdu->max_amsdu_num = 8;
 	amsdu->amsdu_en = true;
@@ -1577,8 +1543,8 @@ mt7915_mcu_wtbl_smps_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	struct wtbl_smps *smps;
 	struct tlv *tlv;
 
-	tlv = mt7915_mcu_add_nested_tlv(skb, WTBL_SMPS, sizeof(*smps),
-					wtbl_tlv, sta_wtbl);
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_SMPS, sizeof(*smps),
+					     wtbl_tlv, sta_wtbl);
 	smps = (struct wtbl_smps *)tlv;
 	smps->smps = (sta->smps_mode == IEEE80211_SMPS_DYNAMIC);
 }
@@ -1594,8 +1560,8 @@ mt7915_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 
 	/* wtbl ht */
 	if (sta->ht_cap.ht_supported) {
-		tlv = mt7915_mcu_add_nested_tlv(skb, WTBL_HT, sizeof(*ht),
-						wtbl_tlv, sta_wtbl);
+		tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_HT, sizeof(*ht),
+						     wtbl_tlv, sta_wtbl);
 		ht = (struct wtbl_ht *)tlv;
 		ht->ldpc = mvif->cap.ldpc &&
 			   (sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
@@ -1609,8 +1575,9 @@ mt7915_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		struct wtbl_vht *vht;
 		u8 af;
 
-		tlv = mt7915_mcu_add_nested_tlv(skb, WTBL_VHT, sizeof(*vht),
-						wtbl_tlv, sta_wtbl);
+		tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_VHT,
+						     sizeof(*vht), wtbl_tlv,
+						     sta_wtbl);
 		vht = (struct wtbl_vht *)tlv;
 		vht->ldpc = mvif->cap.ldpc &&
 			    (sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
@@ -1634,8 +1601,8 @@ mt7915_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct wtbl_hdr_trans *htr = NULL;
 	struct tlv *tlv;
 
-	tlv = mt7915_mcu_add_nested_tlv(skb, WTBL_HDR_TRANS, sizeof(*htr),
-					wtbl_tlv, sta_wtbl);
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_HDR_TRANS, sizeof(*htr),
+					     wtbl_tlv, sta_wtbl);
 	htr = (struct wtbl_hdr_trans *)tlv;
 	htr->no_rx_trans = true;
 	if (vif->type == NL80211_IFTYPE_STATION)
@@ -1665,7 +1632,7 @@ mt7915_mcu_sta_wtbl_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 
 	msta = sta ? (struct mt7915_sta *)sta->drv_priv : &mvif->sta;
 
-	tlv = mt7915_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
 						  WTBL_RESET_AND_SET, tlv,
 						  &skb);
@@ -1896,7 +1863,7 @@ mt7915_mcu_sta_bfer_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	if (!ebf && !dev->ibf)
 		return;
 
-	tlv = mt7915_mcu_add_tlv(skb, STA_REC_BF, sizeof(*bf));
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BF, sizeof(*bf));
 	bf = (struct sta_rec_bf *)tlv;
 
 	/* he: eBF only, in accordance with spec
@@ -1956,7 +1923,7 @@ mt7915_mcu_sta_bfee_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	if (!mt7915_is_ebf_supported(phy, vif, sta, true))
 		return;
 
-	tlv = mt7915_mcu_add_tlv(skb, STA_REC_BFEE, sizeof(*bfee));
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BFEE, sizeof(*bfee));
 	bfee = (struct sta_rec_bfee *)tlv;
 
 	if (sta->he_cap.has_he) {
@@ -2007,7 +1974,7 @@ int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	tlv = mt7915_mcu_add_tlv(skb, STA_REC_RA_UPDATE, sizeof(*ra));
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA_UPDATE, sizeof(*ra));
 	ra = (struct sta_rec_ra_fixed *)tlv;
 
 	switch (field) {
@@ -2047,8 +2014,8 @@ int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	sta_wtbl = mt7915_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
-
+	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
+					   sizeof(struct tlv));
 	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
 						  WTBL_SET, sta_wtbl, &skb);
 	if (IS_ERR(wtbl_hdr))
@@ -2163,7 +2130,7 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 	u32 supp_rate = sta->supp_rates[band];
 	u32 cap = sta->wme ? STA_CAP_WMM : 0;
 
-	tlv = mt7915_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra));
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra));
 	ra = (struct sta_rec_ra *)tlv;
 
 	ra->valid = true;
@@ -2558,7 +2525,7 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 	if (IS_ERR(rskb))
 		return PTR_ERR(rskb);
 
-	tlv = mt7915_mcu_add_tlv(rskb, BSS_INFO_OFFLOAD, sizeof(*bcn));
+	tlv = mt76_connac_mcu_add_tlv(rskb, BSS_INFO_OFFLOAD, sizeof(*bcn));
 	bcn = (struct bss_info_bcn *)tlv;
 	bcn->enable = en;
 
@@ -4167,7 +4134,8 @@ int mt7915_mcu_update_bss_color(struct mt7915_dev *dev, struct ieee80211_vif *vi
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	tlv = mt7915_mcu_add_tlv(skb, BSS_INFO_BSS_COLOR, sizeof(*bss_color));
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_BSS_COLOR,
+				      sizeof(*bss_color));
 	bss_color = (struct bss_info_color *)tlv;
 	bss_color->disable = !he_bss_color->enabled;
 	bss_color->color = he_bss_color->color;
-- 
2.33.1

