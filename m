Return-Path: <linux-wireless+bounces-20227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B92AA5DB24
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB7217777F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAC523ED71;
	Wed, 12 Mar 2025 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyReiGmw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FFE23ED58
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778043; cv=none; b=RRCthGOY8WCwDandweMEiLLCWI36DKX+mVY600Oc1djx1N33StRdJQogkniy6s6Z66xmdDnLsvV9mX6N2vsufIdvuHJcv3nOYiQbof+c4TdHVFSOgPJlGj3IkzDer0Vr1F6z0bAo2GwWI4d/34zL/q0AXNdkGlLsRJjVItHhHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778043; c=relaxed/simple;
	bh=vhPXtIUZRFcGp+b4ZKfFHWKUZ9tJ3s7owB+KA96SA8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u8hu1cRfFC+5uE66RdJkYAmmbbyQgArFAW282mUjrbDGIPzGtkKYzA8/wwQk6wdzMpaDEXnbK/TYUbuuqFs6CFFAngRYLBJGkBu2vilqFw7ExQlyUHq6f6b307mhT8g48GTn2dNL0118m6kCFQ1lzG3B3lHcrBi8OjdEqmUwCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyReiGmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A538C4CEE3;
	Wed, 12 Mar 2025 11:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778042;
	bh=vhPXtIUZRFcGp+b4ZKfFHWKUZ9tJ3s7owB+KA96SA8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SyReiGmwSNg17HUB5BL1psTRKmxgjyZPS0MWj4Jy/tkrwsxRYZM6gVDZonQlH00Gt
	 cxtCaf3LiVWKY4qWi6UrvV5f2FkG4PsuPYo0DWeK/HOm08R2BCkKhe650teE6Y20Xx
	 D6KqSbJKoI01kQpq1ERG5KyNNcQQxB3tNLOKRUmp5zSJBhq01Ce6wbmauxkZPnJ5sD
	 JIMufjMtuw4pYRUaEQ384i6DQUZ6Hp7tSN9VUPvx+Kw8JXXTkFCmY6OluIyoLIV9wO
	 ggmvXST/DMRL3+lmAqaUSMdKqP5a6kZNrbeACozXzQynEeLoPSpy4nKZFVDlfcc6Nh
	 R+UIeirE5keIA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:13:45 +0100
Subject: [PATCH 01/21] wifi: mt76: mt7996: Update mt7996_mcu_add_rate_ctrl
 to MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-1-015b3d6fd928@kernel.org>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
In-Reply-To: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

From: Shayne Chen <shayne.chen@mediatek.com>

Update mt7996_mcu_add_rate_ctrl routine and all the called subroutines
to support MLO.
This is a preliminary patch to enable MLO for MT7996 driver

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   9 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 144 +++++++++++----------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  15 ++-
 4 files changed, 96 insertions(+), 76 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 7ddd4b0cadf5d1983379a93ba56da461748ca60e..48ba975f069c5062f450326a359ff3442ac96f30 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2294,10 +2294,15 @@ void mt7996_mac_sta_rc_work(struct work_struct *work)
 		if (changed & (IEEE80211_RC_SUPP_RATES_CHANGED |
 			       IEEE80211_RC_NSS_CHANGED |
 			       IEEE80211_RC_BW_CHANGED))
-			mt7996_mcu_add_rate_ctrl(dev, vif, sta, true);
+			mt7996_mcu_add_rate_ctrl(dev, vif, &vif->bss_conf,
+						 &sta->deflink,
+						 &msta->vif->deflink,
+						 msta_link, true);
 
 		if (changed & IEEE80211_RC_SMPS_CHANGED)
-			mt7996_mcu_set_fixed_field(dev, vif, sta, NULL,
+			mt7996_mcu_set_fixed_field(dev, &sta->deflink,
+						   &msta->vif->deflink,
+						   msta_link, NULL,
 						   RATE_PARAM_MMPS_UPDATE);
 
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 11ad95e05b94857c95375cdf877518e7ee89f08e..25dbf086c8ef02307ef2510b21853b1eee28f922 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1046,7 +1046,9 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 			if (err)
 				return err;
 
-			err = mt7996_mcu_add_rate_ctrl(dev, vif, sta, false);
+			err = mt7996_mcu_add_rate_ctrl(dev, vif, link_conf,
+						       link_sta, link,
+						       msta_link, false);
 			if (err)
 				return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index e6ebb309a8257637c122702df2f2924649b7fabe..0cc822a8a6799a4552fa537cab2f13d6537bb1a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -167,11 +167,11 @@ mt7996_mcu_set_sta_he_mcs(struct ieee80211_link_sta *link_sta,
 }
 
 static void
-mt7996_mcu_set_sta_vht_mcs(struct ieee80211_sta *sta, __le16 *vht_mcs,
-			   const u16 *mask)
+mt7996_mcu_set_sta_vht_mcs(struct ieee80211_link_sta *link_sta,
+			   __le16 *vht_mcs, const u16 *mask)
 {
-	u16 mcs, mcs_map = le16_to_cpu(sta->deflink.vht_cap.vht_mcs.rx_mcs_map);
-	int nss, max_nss = sta->deflink.rx_nss > 3 ? 4 : sta->deflink.rx_nss;
+	u16 mcs, mcs_map = le16_to_cpu(link_sta->vht_cap.vht_mcs.rx_mcs_map);
+	int nss, max_nss = link_sta->rx_nss > 3 ? 4 : link_sta->rx_nss;
 
 	for (nss = 0; nss < max_nss; nss++, mcs_map >>= 2) {
 		switch (mcs_map & 0x3) {
@@ -193,13 +193,13 @@ mt7996_mcu_set_sta_vht_mcs(struct ieee80211_sta *sta, __le16 *vht_mcs,
 }
 
 static void
-mt7996_mcu_set_sta_ht_mcs(struct ieee80211_sta *sta, u8 *ht_mcs,
-			  const u8 *mask)
+mt7996_mcu_set_sta_ht_mcs(struct ieee80211_link_sta *link_sta,
+			  u8 *ht_mcs, const u8 *mask)
 {
-	int nss, max_nss = sta->deflink.rx_nss > 3 ? 4 : sta->deflink.rx_nss;
+	int nss, max_nss = link_sta->rx_nss > 3 ? 4 : link_sta->rx_nss;
 
 	for (nss = 0; nss < max_nss; nss++)
-		ht_mcs[nss] = sta->deflink.ht_cap.mcs.rx_mask[nss] & mask[nss];
+		ht_mcs[nss] = link_sta->ht_cap.mcs.rx_mask[nss] & mask[nss];
 }
 
 static int
@@ -1888,18 +1888,18 @@ int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
 				     MCU_WM_UNI_CMD(RA), true);
 }
 
-int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-			       struct ieee80211_sta *sta, void *data, u32 field)
+int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev,
+			       struct ieee80211_link_sta *link_sta,
+			       struct mt7996_vif_link *link,
+			       struct mt7996_sta_link *msta_link,
+			       void *data, u32 field)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct sta_phy_uni *phy = data;
 	struct sta_rec_ra_fixed_uni *ra;
 	struct sk_buff *skb;
 	struct tlv *tlv;
 
-	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->deflink.mt76,
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &link->mt76,
 					      &msta_link->wcid,
 					      MT7996_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
@@ -1919,7 +1919,7 @@ int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct ieee80211_vif *vif
 			ra->phy = *phy;
 		break;
 	case RATE_PARAM_MMPS_UPDATE:
-		ra->mmps_mode = mt7996_mcu_get_mmps_mode(sta->deflink.smps_mode);
+		ra->mmps_mode = mt7996_mcu_get_mmps_mode(link_sta->smps_mode);
 		break;
 	default:
 		break;
@@ -1931,12 +1931,13 @@ int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct ieee80211_vif *vif
 }
 
 static int
-mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-			       struct ieee80211_sta *sta)
+mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev,
+			       struct ieee80211_link_sta *link_sta,
+			       struct mt7996_vif_link *link,
+			       struct mt7996_sta_link *msta_link)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &mvif->deflink.phy->mt76->chandef;
-	struct cfg80211_bitrate_mask *mask = &mvif->deflink.bitrate_mask;
+	struct cfg80211_chan_def *chandef = &link->phy->mt76->chandef;
+	struct cfg80211_bitrate_mask *mask = &link->bitrate_mask;
 	enum nl80211_band band = chandef->chan->band;
 	struct sta_phy_uni phy = {};
 	int ret, nrates = 0;
@@ -1957,11 +1958,11 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev, struct ieee80211_vif *vif
 		}								\
 	} while (0)
 
-	if (sta->deflink.he_cap.has_he) {
+	if (link_sta->he_cap.has_he) {
 		__sta_phy_bitrate_mask_check(he_mcs, he_gi, 0, 1);
-	} else if (sta->deflink.vht_cap.vht_supported) {
+	} else if (link_sta->vht_cap.vht_supported) {
 		__sta_phy_bitrate_mask_check(vht_mcs, gi, 0, 0);
-	} else if (sta->deflink.ht_cap.ht_supported) {
+	} else if (link_sta->ht_cap.ht_supported) {
 		__sta_phy_bitrate_mask_check(ht_mcs, gi, 1, 0);
 	} else {
 		nrates = hweight32(mask->control[band].legacy);
@@ -1978,7 +1979,8 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev, struct ieee80211_vif *vif
 
 	/* fixed single rate */
 	if (nrates == 1) {
-		ret = mt7996_mcu_set_fixed_field(dev, vif, sta, &phy,
+		ret = mt7996_mcu_set_fixed_field(dev, link_sta, link,
+						 msta_link, &phy,
 						 RATE_PARAM_FIXED_MCS);
 		if (ret)
 			return ret;
@@ -1987,7 +1989,6 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev, struct ieee80211_vif *vif
 	/* fixed GI */
 	if (mask->control[band].gi != NL80211_TXRATE_DEFAULT_GI ||
 	    mask->control[band].he_gi != GENMASK(7, 0)) {
-		struct mt7996_sta_link *msta_link = (void *)sta->drv_priv;
 		u32 addr;
 
 		/* firmware updates only TXCMD but doesn't take WTBL into
@@ -1995,12 +1996,13 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev, struct ieee80211_vif *vif
 		 * actual txrate hardware sends out.
 		 */
 		addr = mt7996_mac_wtbl_lmac_addr(dev, msta_link->wcid.idx, 7);
-		if (sta->deflink.he_cap.has_he)
+		if (link_sta->he_cap.has_he)
 			mt76_rmw_field(dev, addr, GENMASK(31, 24), phy.sgi);
 		else
 			mt76_rmw_field(dev, addr, GENMASK(15, 12), phy.sgi);
 
-		ret = mt7996_mcu_set_fixed_field(dev, vif, sta, &phy,
+		ret = mt7996_mcu_set_fixed_field(dev, link_sta, link,
+						 msta_link, &phy,
 						 RATE_PARAM_FIXED_GI);
 		if (ret)
 			return ret;
@@ -2008,7 +2010,8 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev, struct ieee80211_vif *vif
 
 	/* fixed HE_LTF */
 	if (mask->control[band].he_ltf != GENMASK(7, 0)) {
-		ret = mt7996_mcu_set_fixed_field(dev, vif, sta, &phy,
+		ret = mt7996_mcu_set_fixed_field(dev, link_sta, link,
+						 msta_link, &phy,
 						 RATE_PARAM_FIXED_HE_LTF);
 		if (ret)
 			return ret;
@@ -2019,30 +2022,32 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev, struct ieee80211_vif *vif
 
 static void
 mt7996_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7996_dev *dev,
-			     struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *link_conf,
+			     struct ieee80211_link_sta *link_sta,
+			     struct mt7996_vif_link *link)
 {
 #define INIT_RCPI 180
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt76_phy *mphy = mvif->deflink.phy->mt76;
+	struct mt76_phy *mphy = link->phy->mt76;
 	struct cfg80211_chan_def *chandef = &mphy->chandef;
-	struct cfg80211_bitrate_mask *mask = &mvif->deflink.bitrate_mask;
+	struct cfg80211_bitrate_mask *mask = &link->bitrate_mask;
+	u32 cap = link_sta->sta->wme ? STA_CAP_WMM : 0;
 	enum nl80211_band band = chandef->chan->band;
 	struct sta_rec_ra_uni *ra;
 	struct tlv *tlv;
-	u32 supp_rate = sta->deflink.supp_rates[band];
-	u32 cap = sta->wme ? STA_CAP_WMM : 0;
+	u32 supp_rate = link_sta->supp_rates[band];
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra));
 	ra = (struct sta_rec_ra_uni *)tlv;
 
 	ra->valid = true;
 	ra->auto_rate = true;
-	ra->phy_mode = mt76_connac_get_phy_mode(mphy, vif, band, &sta->deflink);
+	ra->phy_mode = mt76_connac_get_phy_mode(mphy, vif, band, link_sta);
 	ra->channel = chandef->chan->hw_value;
-	ra->bw = (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_320) ?
-		 CMD_CBW_320MHZ : sta->deflink.bandwidth;
+	ra->bw = (link_sta->bandwidth == IEEE80211_STA_RX_BW_320) ?
+		 CMD_CBW_320MHZ : link_sta->bandwidth;
 	ra->phy.bw = ra->bw;
-	ra->mmps_mode = mt7996_mcu_get_mmps_mode(sta->deflink.smps_mode);
+	ra->mmps_mode = mt7996_mcu_get_mmps_mode(link_sta->smps_mode);
 
 	if (supp_rate) {
 		supp_rate &= mask->control[band].legacy;
@@ -2062,60 +2067,60 @@ mt7996_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7996_dev *dev,
 		}
 	}
 
-	if (sta->deflink.ht_cap.ht_supported) {
+	if (link_sta->ht_cap.ht_supported) {
 		ra->supp_mode |= MODE_HT;
-		ra->af = sta->deflink.ht_cap.ampdu_factor;
-		ra->ht_gf = !!(sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_GRN_FLD);
+		ra->af = link_sta->ht_cap.ampdu_factor;
+		ra->ht_gf = !!(link_sta->ht_cap.cap & IEEE80211_HT_CAP_GRN_FLD);
 
 		cap |= STA_CAP_HT;
-		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_20)
+		if (link_sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_20)
 			cap |= STA_CAP_SGI_20;
-		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_40)
+		if (link_sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_40)
 			cap |= STA_CAP_SGI_40;
-		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_TX_STBC)
+		if (link_sta->ht_cap.cap & IEEE80211_HT_CAP_TX_STBC)
 			cap |= STA_CAP_TX_STBC;
-		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
+		if (link_sta->ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
 			cap |= STA_CAP_RX_STBC;
-		if (vif->bss_conf.ht_ldpc &&
-		    (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING))
+		if (link_conf->ht_ldpc &&
+		    (link_sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING))
 			cap |= STA_CAP_LDPC;
 
-		mt7996_mcu_set_sta_ht_mcs(sta, ra->ht_mcs,
+		mt7996_mcu_set_sta_ht_mcs(link_sta, ra->ht_mcs,
 					  mask->control[band].ht_mcs);
 		ra->supp_ht_mcs = *(__le32 *)ra->ht_mcs;
 	}
 
-	if (sta->deflink.vht_cap.vht_supported) {
+	if (link_sta->vht_cap.vht_supported) {
 		u8 af;
 
 		ra->supp_mode |= MODE_VHT;
 		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
-			       sta->deflink.vht_cap.cap);
+			       link_sta->vht_cap.cap);
 		ra->af = max_t(u8, ra->af, af);
 
 		cap |= STA_CAP_VHT;
-		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80)
+		if (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80)
 			cap |= STA_CAP_VHT_SGI_80;
-		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_160)
+		if (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_160)
 			cap |= STA_CAP_VHT_SGI_160;
-		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_TXSTBC)
+		if (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_TXSTBC)
 			cap |= STA_CAP_VHT_TX_STBC;
-		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_1)
+		if (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_1)
 			cap |= STA_CAP_VHT_RX_STBC;
-		if ((vif->type != NL80211_IFTYPE_AP || vif->bss_conf.vht_ldpc) &&
-		    (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC))
+		if ((vif->type != NL80211_IFTYPE_AP || link_conf->vht_ldpc) &&
+		    (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC))
 			cap |= STA_CAP_VHT_LDPC;
 
-		mt7996_mcu_set_sta_vht_mcs(sta, ra->supp_vht_mcs,
+		mt7996_mcu_set_sta_vht_mcs(link_sta, ra->supp_vht_mcs,
 					   mask->control[band].vht_mcs);
 	}
 
-	if (sta->deflink.he_cap.has_he) {
+	if (link_sta->he_cap.has_he) {
 		ra->supp_mode |= MODE_HE;
 		cap |= STA_CAP_HE;
 
-		if (sta->deflink.he_6ghz_capa.capa)
-			ra->af = le16_get_bits(sta->deflink.he_6ghz_capa.capa,
+		if (link_sta->he_6ghz_capa.capa)
+			ra->af = le16_get_bits(link_sta->he_6ghz_capa.capa,
 					       IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
 	}
 	ra->sta_cap = cpu_to_le32(cap);
@@ -2123,16 +2128,17 @@ mt7996_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7996_dev *dev,
 	memset(ra->rx_rcpi, INIT_RCPI, sizeof(ra->rx_rcpi));
 }
 
-int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-			     struct ieee80211_sta *sta, bool changed)
+int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *link_conf,
+			     struct ieee80211_link_sta *link_sta,
+			     struct mt7996_vif_link *link,
+			     struct mt7996_sta_link *msta_link, bool changed)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct sk_buff *skb;
 	int ret;
 
-	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->deflink.mt76,
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &link->mt76,
 					      &msta_link->wcid,
 					      MT7996_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
@@ -2143,19 +2149,19 @@ int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	 * update sta_rec_he here.
 	 */
 	if (changed)
-		mt7996_mcu_sta_he_tlv(skb, &sta->deflink, &mvif->deflink);
+		mt7996_mcu_sta_he_tlv(skb, link_sta, link);
 
 	/* sta_rec_ra accommodates BW, NSS and only MCS range format
 	 * i.e 0-{7,8,9} for VHT.
 	 */
-	mt7996_mcu_sta_rate_ctrl_tlv(skb, dev, vif, sta);
+	mt7996_mcu_sta_rate_ctrl_tlv(skb, dev, vif, link_conf, link_sta, link);
 
 	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				    MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
 	if (ret)
 		return ret;
 
-	return mt7996_mcu_add_rate_ctrl_fixed(dev, vif, sta);
+	return mt7996_mcu_add_rate_ctrl_fixed(dev, link_sta, link, msta_link);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 84b9ff707d56501d212932a9fa6a3037259a1077..a91a50b72218c6a2d0dd32968681325ea7e6a042 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -593,16 +593,23 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 				    struct ieee80211_vif *vif, u32 changed);
 int mt7996_mcu_add_obss_spr(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 			    struct ieee80211_he_obss_pd *he_obss_pd);
-int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-			     struct ieee80211_sta *sta, bool changed);
+int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *link_conf,
+			     struct ieee80211_link_sta *link_sta,
+			     struct mt7996_vif_link *link,
+			     struct mt7996_sta_link *msta_link, bool changed);
 int mt7996_set_channel(struct mt76_phy *mphy);
 int mt7996_mcu_set_chan_info(struct mt7996_phy *phy, u16 tag);
 int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		      struct ieee80211_bss_conf *link_conf);
 int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
 				   void *data, u16 version);
-int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-			       struct ieee80211_sta *sta, void *data, u32 field);
+int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev,
+			       struct ieee80211_link_sta *link_sta,
+			       struct mt7996_vif_link *link,
+			       struct mt7996_sta_link *msta_link,
+			       void *data, u32 field);
 int mt7996_mcu_set_eeprom(struct mt7996_dev *dev);
 int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset, u8 *buf, u32 buf_len);
 int mt7996_mcu_get_eeprom_free_block(struct mt7996_dev *dev, u8 *block_num);

-- 
2.48.1


