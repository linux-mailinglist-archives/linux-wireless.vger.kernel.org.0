Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3497547A19A
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 18:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhLSRlM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 12:41:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51380 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbhLSRlL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 12:41:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71E21B80D42
        for <linux-wireless@vger.kernel.org>; Sun, 19 Dec 2021 17:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB908C36AE9;
        Sun, 19 Dec 2021 17:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639935669;
        bh=189jLP0Dh8/AYAp2Y5iQTwgF9o/U0U32qDTclbf4Qnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Br28gD0fgiZoSVbmT/qSn6tHQIrMUGQDWQEyBeu++Y3ykZb1UkyLFWLTXXBnTFYmM
         Mo60EB5cqGhis8pNQYo454P2SXg6ErVmuwhMiwzg9+bNd2dUuw4U20CCJXApG/Mb0G
         Ixvj2rJ3MCAXONS04PWJUfZY9RauA4aw6xNYqXyEIAX2/iAYlEMqXVAzgXSnQnvhOd
         Nd2/075FmWBlWBU/w+JVjbsJJgmOrkB9s8LLPROG3mgGdulljveIkP9wSJ+6tA2H1a
         SCYxexzfR01fwY+N2aRNFZxj/7g0VQYhxARBMSDUc2IeVt0zsXxlDvTCAMjrWjKiZA
         wdD4pS2HjRq7g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH v2 8/9] mt76: mt7915: rely on mt76_connac_get_phy utilities
Date:   Sun, 19 Dec 2021 18:40:13 +0100
Message-Id: <33c42e27143076fbbc16c28662893d3a00cf9cc3.1639935477.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639935477.git.lorenzo@kernel.org>
References: <cover.1639935477.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_get_phy_mode and mt76_connac_get_he_phy_cap utility
routines in mt7915 driver and remove duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 12 +--
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  5 ++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 77 +++----------------
 3 files changed, 22 insertions(+), 72 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 56b9cda95cb0..356fc14b888b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1145,10 +1145,8 @@ int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_ba);
 
-static u8
-mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
-			 enum nl80211_band band,
-			 struct ieee80211_sta *sta)
+u8 mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			    enum nl80211_band band, struct ieee80211_sta *sta)
 {
 	struct mt76_dev *dev = phy->dev;
 	const struct ieee80211_sta_he_cap *he_cap;
@@ -1156,7 +1154,7 @@ mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	struct ieee80211_sta_ht_cap *ht_cap;
 	u8 mode = 0;
 
-	if (!is_mt7921(dev))
+	if (!is_mt7921(dev) && !is_mt7915(dev))
 		return 0x38;
 
 	if (sta) {
@@ -1195,8 +1193,9 @@ mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 
 	return mode;
 }
+EXPORT_SYMBOL_GPL(mt76_connac_get_phy_mode);
 
-static const struct ieee80211_sta_he_cap *
+const struct ieee80211_sta_he_cap *
 mt76_connac_get_he_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif)
 {
 	enum nl80211_band band = phy->chandef.chan->band;
@@ -1206,6 +1205,7 @@ mt76_connac_get_he_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif)
 
 	return ieee80211_get_he_iftype_cap(sband, vif->type);
 }
+EXPORT_SYMBOL_GPL(mt76_connac_get_he_phy_cap);
 
 #define DEFAULT_HE_PE_DURATION		4
 #define DEFAULT_HE_DURATION_RTS_THRES	1023
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 756daf1ce6b8..d2981402630c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1582,4 +1582,9 @@ int mt76_connac_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif);
 u32 mt76_connac_mcu_reg_rr(struct mt76_dev *dev, u32 offset);
 void mt76_connac_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val);
+
+const struct ieee80211_sta_he_cap *
+mt76_connac_get_he_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif);
+u8 mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			    enum nl80211_band band, struct ieee80211_sta *sta);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index ab1a286ba94d..6a414015c9c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -85,66 +85,6 @@ struct mt7915_fw_region {
 #define HE_PHY(p, c)			u8_get_bits(c, IEEE80211_HE_PHY_##p)
 #define HE_MAC(m, c)			u8_get_bits(c, IEEE80211_HE_MAC_##m)
 
-static const struct ieee80211_sta_he_cap *
-mt7915_get_he_phy_cap(struct mt7915_phy *phy, struct ieee80211_vif *vif)
-{
-	struct ieee80211_supported_band *sband;
-	enum nl80211_band band;
-
-	band = phy->mt76->chandef.chan->band;
-	sband = phy->mt76->hw->wiphy->bands[band];
-
-	return ieee80211_get_he_iftype_cap(sband, vif->type);
-}
-
-static u8
-mt7915_get_phy_mode(struct ieee80211_vif *vif, struct ieee80211_sta *sta)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	enum nl80211_band band = mvif->phy->mt76->chandef.chan->band;
-	struct ieee80211_sta_ht_cap *ht_cap;
-	struct ieee80211_sta_vht_cap *vht_cap;
-	const struct ieee80211_sta_he_cap *he_cap;
-	u8 mode = 0;
-
-	if (sta) {
-		ht_cap = &sta->ht_cap;
-		vht_cap = &sta->vht_cap;
-		he_cap = &sta->he_cap;
-	} else {
-		struct ieee80211_supported_band *sband;
-
-		sband = mvif->phy->mt76->hw->wiphy->bands[band];
-
-		ht_cap = &sband->ht_cap;
-		vht_cap = &sband->vht_cap;
-		he_cap = ieee80211_get_he_iftype_cap(sband, vif->type);
-	}
-
-	if (band == NL80211_BAND_2GHZ) {
-		mode |= PHY_MODE_B | PHY_MODE_G;
-
-		if (ht_cap->ht_supported)
-			mode |= PHY_MODE_GN;
-
-		if (he_cap && he_cap->has_he)
-			mode |= PHY_MODE_AX_24G;
-	} else if (band == NL80211_BAND_5GHZ) {
-		mode |= PHY_MODE_A;
-
-		if (ht_cap->ht_supported)
-			mode |= PHY_MODE_AN;
-
-		if (vht_cap->vht_supported)
-			mode |= PHY_MODE_AC;
-
-		if (he_cap && he_cap->has_he)
-			mode |= PHY_MODE_AX_5G;
-	}
-
-	return mode;
-}
-
 static u8
 mt7915_mcu_get_sta_nss(u16 mcs_map)
 {
@@ -598,10 +538,13 @@ mt7915_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	bss->active = enable;
 
 	if (vif->type != NL80211_IFTYPE_MONITOR) {
+		struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+
 		memcpy(bss->bssid, vif->bss_conf.bssid, ETH_ALEN);
 		bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
 		bss->dtim_period = vif->bss_conf.dtim_period;
-		bss->phy_mode = mt7915_get_phy_mode(vif, NULL);
+		bss->phy_mode = mt76_connac_get_phy_mode(phy->mt76, vif,
+							 chandef->chan->band, NULL);
 	} else {
 		memcpy(bss->bssid, phy->mt76->macaddr, ETH_ALEN);
 	}
@@ -763,7 +706,7 @@ mt7915_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct bss_info_he *he;
 	struct tlv *tlv;
 
-	cap = mt7915_get_he_phy_cap(phy, vif);
+	cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
 
 	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_HE_BASIC, sizeof(*he));
 
@@ -1742,7 +1685,8 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 {
 	struct ieee80211_sta_he_cap *pc = &sta->he_cap;
 	struct ieee80211_he_cap_elem *pe = &pc->he_cap_elem;
-	const struct ieee80211_sta_he_cap *vc = mt7915_get_he_phy_cap(phy, vif);
+	const struct ieee80211_sta_he_cap *vc =
+		mt76_connac_get_he_phy_cap(phy->mt76, vif);
 	const struct ieee80211_he_cap_elem *ve = &vc->he_cap_elem;
 	u16 mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_80);
 	u8 nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
@@ -2076,7 +2020,8 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 			     struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &mvif->phy->mt76->chandef;
+	struct mt76_phy *mphy = mvif->phy->mt76;
+	struct cfg80211_chan_def *chandef = &mphy->chandef;
 	struct cfg80211_bitrate_mask *mask = &mvif->bitrate_mask;
 	enum nl80211_band band = chandef->chan->band;
 	struct sta_rec_ra *ra;
@@ -2089,7 +2034,7 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 
 	ra->valid = true;
 	ra->auto_rate = true;
-	ra->phy_mode = mt7915_get_phy_mode(vif, sta);
+	ra->phy_mode = mt76_connac_get_phy_mode(mphy, vif, band, sta);
 	ra->channel = chandef->chan->hw_value;
 	ra->bw = sta->bandwidth;
 	ra->phy.bw = sta->bandwidth;
@@ -2443,7 +2388,7 @@ mt7915_mcu_beacon_check_caps(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 				  mgmt->u.beacon.variable, len);
 	if (ie && ie[1] >= sizeof(*he) + 1) {
 		const struct ieee80211_sta_he_cap *pc =
-			mt7915_get_he_phy_cap(phy, vif);
+			mt76_connac_get_he_phy_cap(phy->mt76, vif);
 		const struct ieee80211_he_cap_elem *pe = &pc->he_cap_elem;
 
 		he = (void *)(ie + 3);
-- 
2.33.1

