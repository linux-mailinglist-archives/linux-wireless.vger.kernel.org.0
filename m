Return-Path: <linux-wireless+bounces-20191-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B8BA5CC98
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 18:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 774F27A6D11
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 17:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388BB263880;
	Tue, 11 Mar 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP9IFEXi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1408C262D21
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715146; cv=none; b=EumXuR7bI8Y37JSuNuSxRk5wKfjRg+sUbXuwYXePRveyGtLVn9zP973Xu+fM68y3+wNrIhd5YvYAsKHhK3Vt5807WSAzrP1oYXq2NuIgBEmu5VRxlwplT4BsjajG8ewqPPH1MsVzo/YRVCD/ZPop6RxTO/aj6+2kLnLBzmm/XZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715146; c=relaxed/simple;
	bh=qv13+ZY2axgdcgBj5VVQvrZErwdM/s1uSjnNxo6Ap6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j8oMX65vcA0p2F2ivuyhiG8FU8YFlAz4/jWEY/FKXGCqPqrkMa6I5TCx17Bt+zm+isXahLZvBTNoN3je9/I0AtFd7ZKKV3CiMuqMRxUhVXjxEpkN0IzJ9wzJzx3t0zVUNuIE2vAvlowe/G6Cjjq0x/NhmmQBssH/cuWJIYh/vjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP9IFEXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008EEC4CEE9;
	Tue, 11 Mar 2025 17:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715145;
	bh=qv13+ZY2axgdcgBj5VVQvrZErwdM/s1uSjnNxo6Ap6Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OP9IFEXiJKGO6Nb0AzXseBe2lI5+eEzGQdA0ekgYTs+6KOg9bCFsa1pUbUsYfsOOR
	 uZKZDfyXaapMNwCfyxMj8Xu2bqMYme3xBsdyLvz+9OVMNU517MzsCeB8oV0bD5Tapf
	 uENw8VBC8sJJZ9U57+CfOFxxttI3IjlIzdR8IWGXDrqr95FYI3GmkLbxqythfqwFB1
	 9p46PKb8+h9cV0gRgaObnnw4rdBQQ3wP4UtJldqG1V2CpuF7lkB7xpb7jdB3/Kd+U1
	 9piaW/BqqU6hLJ7Jnh+3Gfa6TL1VFM8lFqOpJ3dNpPCBWR7pVZkCko5ZksDzEQPr5v
	 cIwJwMmZJPIKw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 18:45:10 +0100
Subject: [PATCH v2 11/13] wifi: mt76: mt7996: Update mt7996_mcu_add_sta to
 MLO support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mt7996-mlo-v2-11-31df6972519b@kernel.org>
References: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
In-Reply-To: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>
X-Mailer: b4 0.14.2

From: Shayne Chen <shayne.chen@mediatek.com>

Update mt7996_mcu_add_sta routine and all the called subroutines to
support MLO. This is a preliminary patch to enable MLO for MT7996
driver.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  72 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 296 +++++++++++----------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   9 +-
 3 files changed, 208 insertions(+), 169 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 6d323b5e4e8076ca963e585c12dc656dc5ec3fdb..5ab4f08dba06fdf95ee4e6bc0261749016f07e6a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -293,7 +293,8 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	 * interface, since firmware only records BSSID when the entry is new
 	 */
 	if (vif->type != NL80211_IFTYPE_STATION)
-		mt7996_mcu_add_sta(dev, vif, mlink, NULL, CONN_STATE_PORT_SECURE, true);
+		mt7996_mcu_add_sta(dev, link_conf, NULL, link, NULL,
+				   CONN_STATE_PORT_SECURE, true);
 	rcu_assign_pointer(dev->mt76.wcid[idx], &msta_link->wcid);
 
 	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, link);
@@ -311,7 +312,8 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	struct mt7996_dev *dev = phy->dev;
 	int idx = msta_link->wcid.idx;
 
-	mt7996_mcu_add_sta(dev, vif, mlink, NULL, CONN_STATE_DISCONNECT, false);
+	mt7996_mcu_add_sta(dev, link_conf, NULL, link, NULL,
+			   CONN_STATE_DISCONNECT, false);
 	mt7996_mcu_add_bss_info(phy, vif, link_conf, mlink, false);
 
 	mt7996_mcu_add_dev_info(phy, vif, link_conf, mlink, false);
@@ -703,7 +705,7 @@ mt7996_vif_cfg_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 			mt7996_mcu_add_bss_info(link->phy, vif, link_conf,
 						&link->mt76, true);
-			mt7996_mcu_add_sta(dev, vif, &link->mt76, NULL,
+			mt7996_mcu_add_sta(dev, link_conf, NULL, link, NULL,
 					   CONN_STATE_PORT_SECURE,
 					   !!(changed & BSS_CHANGED_BSSID));
 		}
@@ -717,17 +719,17 @@ mt7996_link_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			 struct ieee80211_bss_conf *info, u64 changed)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt76_vif_link *mvif;
+	struct mt7996_vif_link *link;
 	struct mt7996_phy *phy;
 	struct mt76_phy *mphy;
 
 	mutex_lock(&dev->mt76.mutex);
 
-	mvif = mt76_vif_conf_link(&dev->mt76, vif, info);
-	if (!mvif)
+	link = mt7996_vif_conf_link(dev, vif, info);
+	if (!link)
 		goto out;
 
-	mphy = mt76_vif_link_phy(mvif);
+	mphy = mt76_vif_link_phy(&link->mt76);
 	if (!mphy)
 		goto out;
 
@@ -738,8 +740,9 @@ mt7996_link_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	 */
 	if ((changed & BSS_CHANGED_BSSID && !is_zero_ether_addr(info->bssid)) ||
 	    (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon)) {
-		mt7996_mcu_add_bss_info(phy, vif, info, mvif, true);
-		mt7996_mcu_add_sta(dev, vif, mvif, NULL, CONN_STATE_PORT_SECURE,
+		mt7996_mcu_add_bss_info(phy, vif, info, &link->mt76, true);
+		mt7996_mcu_add_sta(dev, info, NULL, link, NULL,
+				   CONN_STATE_PORT_SECURE,
 				   !!(changed & BSS_CHANGED_BSSID));
 	}
 
@@ -756,11 +759,11 @@ mt7996_link_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 
 	if (changed & BSS_CHANGED_MCAST_RATE)
-		mvif->mcast_rates_idx =
+		link->mt76.mcast_rates_idx =
 			mt7996_get_rates_table(phy, info, false, true);
 
 	if (changed & BSS_CHANGED_BASIC_RATES)
-		mvif->basic_rates_idx =
+		link->mt76.basic_rates_idx =
 			mt7996_get_rates_table(phy, info, false, false);
 
 	/* ensure that enable txcmd_mode after bss_info */
@@ -772,15 +775,15 @@ mt7996_link_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	if (changed & BSS_CHANGED_HE_BSS_COLOR) {
 		if ((vif->type == NL80211_IFTYPE_AP &&
-		    mvif->omac_idx <= HW_BSSID_MAX) ||
+		    link->mt76.omac_idx <= HW_BSSID_MAX) ||
 		   vif->type == NL80211_IFTYPE_STATION)
-			mt7996_mcu_update_bss_color(dev, mvif,
+			mt7996_mcu_update_bss_color(dev, &link->mt76,
 						    &info->he_bss_color);
 	}
 
 	if (changed & (BSS_CHANGED_BEACON |
 		       BSS_CHANGED_BEACON_ENABLED)) {
-		mvif->beacon_rates_idx =
+		link->mt76.beacon_rates_idx =
 			mt7996_get_rates_table(phy, info, true, false);
 
 		mt7996_mcu_add_beacon(hw, vif, info);
@@ -816,10 +819,12 @@ mt7996_channel_switch_beacon(struct ieee80211_hw *hw,
 }
 
 static int
-mt7996_mac_sta_init_link(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-			 struct mt7996_vif_link *link,
-			 struct ieee80211_sta *sta, unsigned int link_id)
+mt7996_mac_sta_init_link(struct mt7996_dev *dev,
+			 struct ieee80211_bss_conf *link_conf,
+			 struct ieee80211_link_sta *link_sta,
+			 struct mt7996_vif_link *link, unsigned int link_id)
 {
+	struct ieee80211_sta *sta = link_sta->sta;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_phy *phy = link->phy;
 	struct mt7996_sta_link *msta_link;
@@ -863,8 +868,8 @@ mt7996_mac_sta_init_link(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	rcu_assign_pointer(msta->link[link_id], msta_link);
 
 	mt7996_mac_wtbl_update(dev, idx, MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-	mt7996_mcu_add_sta(dev, vif, &link->mt76, sta, CONN_STATE_DISCONNECT,
-			   true);
+	mt7996_mcu_add_sta(dev, link_conf, link_sta, link, msta_link,
+			   CONN_STATE_DISCONNECT, true);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], &msta_link->wcid);
 	mt76_wcid_init(&msta_link->wcid, phy->mt76->band_idx);
@@ -930,16 +935,27 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	int err;
 
 	for_each_set_bit(link_id, &new_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf;
+		struct ieee80211_link_sta *link_sta;
 		struct mt7996_vif_link *link;
 
 		if (rcu_access_pointer(msta->link[link_id]))
 			continue;
 
+		link_conf = link_conf_dereference_protected(vif, link_id);
+		if (!link_conf)
+			goto error_unlink;
+
 		link = mt7996_vif_link(dev, vif, link_id);
 		if (!link)
 			goto error_unlink;
 
-		err = mt7996_mac_sta_init_link(dev, vif, link, sta, link_id);
+		link_sta = link_sta_dereference_protected(sta, link_id);
+		if (!link_sta)
+			goto error_unlink;
+
+		err = mt7996_mac_sta_init_link(dev, link_conf, link_sta, link,
+					       link_id);
 		if (err)
 			goto error_unlink;
 	}
@@ -1005,10 +1021,15 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	unsigned int link_id;
 
 	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		struct ieee80211_bss_conf *link_conf;
 		struct mt7996_sta_link *msta_link;
 		struct mt7996_vif_link *link;
 		int i, err;
 
+		link_conf = link_conf_dereference_protected(vif, link_id);
+		if (!link_conf)
+			continue;
+
 		link = mt7996_vif_link(dev, vif, link_id);
 		if (!link)
 			continue;
@@ -1019,7 +1040,8 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 
 		switch (ev) {
 		case MT76_STA_EVENT_ASSOC:
-			err = mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
+			err = mt7996_mcu_add_sta(dev, link_conf, link_sta,
+						 link, msta_link,
 						 CONN_STATE_CONNECT, true);
 			if (err)
 				return err;
@@ -1032,7 +1054,8 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 			msta_link->wcid.sta = 1;
 			break;
 		case MT76_STA_EVENT_AUTHORIZE:
-			err = mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
+			err = mt7996_mcu_add_sta(dev, link_conf, link_sta,
+						 link, msta_link,
 						 CONN_STATE_PORT_SECURE, false);
 			if (err)
 				return err;
@@ -1041,8 +1064,9 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 			for (i = 0; i < ARRAY_SIZE(msta_link->twt.flow); i++)
 				mt7996_mac_twt_teardown_flow(dev, msta, i);
 
-			mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
-					   CONN_STATE_DISCONNECT, false);
+			mt7996_mcu_add_sta(dev, link_conf, link_sta, link,
+					   msta_link, CONN_STATE_DISCONNECT,
+					   false);
 			msta_link->wcid.sta_disabled = 1;
 			msta_link->wcid.sta = 0;
 			break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 9018ede6efed49241205ddc042f3df149cd58530..43e85308132e5ed80d8199858014b31a29b2e3b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -118,13 +118,13 @@ mt7996_mcu_get_sta_nss(u16 mcs_map)
 }
 
 static void
-mt7996_mcu_set_sta_he_mcs(struct ieee80211_sta *sta, __le16 *he_mcs,
-			  u16 mcs_map)
+mt7996_mcu_set_sta_he_mcs(struct ieee80211_link_sta *link_sta,
+			  struct mt7996_vif_link *link,
+			  __le16 *he_mcs, u16 mcs_map)
 {
-	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	enum nl80211_band band = msta->vif->deflink.phy->mt76->chandef.chan->band;
-	const u16 *mask = msta->vif->deflink.bitrate_mask.control[band].he_mcs;
-	int nss, max_nss = sta->deflink.rx_nss > 3 ? 4 : sta->deflink.rx_nss;
+	int nss, max_nss = link_sta->rx_nss > 3 ? 4 : link_sta->rx_nss;
+	enum nl80211_band band = link->phy->mt76->chandef.chan->band;
+	const u16 *mask = link->bitrate_mask.control[band].he_mcs;
 
 	for (nss = 0; nss < max_nss; nss++) {
 		int mcs;
@@ -1182,15 +1182,17 @@ int mt7996_mcu_add_rx_ba(struct mt7996_dev *dev,
 }
 
 static void
-mt7996_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+mt7996_mcu_sta_he_tlv(struct sk_buff *skb,
+		      struct ieee80211_link_sta *link_sta,
+		      struct mt7996_vif_link *link)
 {
-	struct ieee80211_he_cap_elem *elem = &sta->deflink.he_cap.he_cap_elem;
+	struct ieee80211_he_cap_elem *elem = &link_sta->he_cap.he_cap_elem;
 	struct ieee80211_he_mcs_nss_supp mcs_map;
 	struct sta_rec_he_v2 *he;
 	struct tlv *tlv;
 	int i = 0;
 
-	if (!sta->deflink.he_cap.has_he)
+	if (!link_sta->he_cap.has_he)
 		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HE_V2, sizeof(*he));
@@ -1202,21 +1204,21 @@ mt7996_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 		he->he_phy_cap[i] = elem->phy_cap_info[i];
 	}
 
-	mcs_map = sta->deflink.he_cap.he_mcs_nss_supp;
-	switch (sta->deflink.bandwidth) {
+	mcs_map = link_sta->he_cap.he_mcs_nss_supp;
+	switch (link_sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
 		if (elem->phy_cap_info[0] &
 		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
-			mt7996_mcu_set_sta_he_mcs(sta,
+			mt7996_mcu_set_sta_he_mcs(link_sta, link,
 						  &he->max_nss_mcs[CMD_HE_MCS_BW8080],
 						  le16_to_cpu(mcs_map.rx_mcs_80p80));
 
-		mt7996_mcu_set_sta_he_mcs(sta,
+		mt7996_mcu_set_sta_he_mcs(link_sta, link,
 					  &he->max_nss_mcs[CMD_HE_MCS_BW160],
 					  le16_to_cpu(mcs_map.rx_mcs_160));
 		fallthrough;
 	default:
-		mt7996_mcu_set_sta_he_mcs(sta,
+		mt7996_mcu_set_sta_he_mcs(link_sta, link,
 					  &he->max_nss_mcs[CMD_HE_MCS_BW80],
 					  le16_to_cpu(mcs_map.rx_mcs_80));
 		break;
@@ -1226,24 +1228,26 @@ mt7996_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 }
 
 static void
-mt7996_mcu_sta_he_6g_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+mt7996_mcu_sta_he_6g_tlv(struct sk_buff *skb,
+			 struct ieee80211_link_sta *link_sta)
 {
 	struct sta_rec_he_6g_capa *he_6g;
 	struct tlv *tlv;
 
-	if (!sta->deflink.he_6ghz_capa.capa)
+	if (!link_sta->he_6ghz_capa.capa)
 		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HE_6G, sizeof(*he_6g));
 
 	he_6g = (struct sta_rec_he_6g_capa *)tlv;
-	he_6g->capa = sta->deflink.he_6ghz_capa.capa;
+	he_6g->capa = link_sta->he_6ghz_capa.capa;
 }
 
 static void
-mt7996_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+mt7996_mcu_sta_eht_tlv(struct sk_buff *skb,
+		       struct ieee80211_link_sta *link_sta)
 {
-	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta *msta = (struct mt7996_sta *)link_sta->sta->drv_priv;
 	struct ieee80211_vif *vif = container_of((void *)msta->vif,
 						 struct ieee80211_vif, drv_priv);
 	struct ieee80211_eht_mcs_nss_supp *mcs_map;
@@ -1251,11 +1255,11 @@ mt7996_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 	struct sta_rec_eht *eht;
 	struct tlv *tlv;
 
-	if (!sta->deflink.eht_cap.has_eht)
+	if (!link_sta->eht_cap.has_eht)
 		return;
 
-	mcs_map = &sta->deflink.eht_cap.eht_mcs_nss_supp;
-	elem = &sta->deflink.eht_cap.eht_cap_elem;
+	mcs_map = &link_sta->eht_cap.eht_mcs_nss_supp;
+	elem = &link_sta->eht_cap.eht_cap_elem;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_EHT, sizeof(*eht));
 
@@ -1266,7 +1270,7 @@ mt7996_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 	eht->phy_cap_ext = cpu_to_le64(elem->phy_cap_info[8]);
 
 	if (vif->type != NL80211_IFTYPE_STATION &&
-	    (sta->deflink.he_cap.he_cap_elem.phy_cap_info[0] &
+	    (link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
 	     (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
 	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
 	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
@@ -1282,48 +1286,48 @@ mt7996_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 }
 
 static void
-mt7996_mcu_sta_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+mt7996_mcu_sta_ht_tlv(struct sk_buff *skb, struct ieee80211_link_sta *link_sta)
 {
 	struct sta_rec_ht_uni *ht;
 	struct tlv *tlv;
 
-	if (!sta->deflink.ht_cap.ht_supported)
+	if (!link_sta->ht_cap.ht_supported)
 		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
 
 	ht = (struct sta_rec_ht_uni *)tlv;
-	ht->ht_cap = cpu_to_le16(sta->deflink.ht_cap.cap);
-	ht->ampdu_param = u8_encode_bits(sta->deflink.ht_cap.ampdu_factor,
+	ht->ht_cap = cpu_to_le16(link_sta->ht_cap.cap);
+	ht->ampdu_param = u8_encode_bits(link_sta->ht_cap.ampdu_factor,
 					 IEEE80211_HT_AMPDU_PARM_FACTOR) |
-			  u8_encode_bits(sta->deflink.ht_cap.ampdu_density,
+			  u8_encode_bits(link_sta->ht_cap.ampdu_density,
 					 IEEE80211_HT_AMPDU_PARM_DENSITY);
 }
 
 static void
-mt7996_mcu_sta_vht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+mt7996_mcu_sta_vht_tlv(struct sk_buff *skb, struct ieee80211_link_sta *link_sta)
 {
 	struct sta_rec_vht *vht;
 	struct tlv *tlv;
 
 	/* For 6G band, this tlv is necessary to let hw work normally */
-	if (!sta->deflink.he_6ghz_capa.capa && !sta->deflink.vht_cap.vht_supported)
+	if (!link_sta->he_6ghz_capa.capa && !link_sta->vht_cap.vht_supported)
 		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_VHT, sizeof(*vht));
 
 	vht = (struct sta_rec_vht *)tlv;
-	vht->vht_cap = cpu_to_le32(sta->deflink.vht_cap.cap);
-	vht->vht_rx_mcs_map = sta->deflink.vht_cap.vht_mcs.rx_mcs_map;
-	vht->vht_tx_mcs_map = sta->deflink.vht_cap.vht_mcs.tx_mcs_map;
+	vht->vht_cap = cpu_to_le32(link_sta->vht_cap.cap);
+	vht->vht_rx_mcs_map = link_sta->vht_cap.vht_mcs.rx_mcs_map;
+	vht->vht_tx_mcs_map = link_sta->vht_cap.vht_mcs.tx_mcs_map;
 }
 
 static void
 mt7996_mcu_sta_amsdu_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
-			 struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+			 struct ieee80211_vif *vif,
+			 struct ieee80211_link_sta *link_sta,
+			 struct mt7996_sta_link *msta_link)
 {
-	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct sta_rec_amsdu *amsdu;
 	struct tlv *tlv;
 
@@ -1332,7 +1336,7 @@ mt7996_mcu_sta_amsdu_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	    vif->type != NL80211_IFTYPE_AP)
 		return;
 
-	if (!sta->deflink.agg.max_amsdu_len)
+	if (!link_sta->agg.max_amsdu_len)
 		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HW_AMSDU, sizeof(*amsdu));
@@ -1341,7 +1345,7 @@ mt7996_mcu_sta_amsdu_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	amsdu->amsdu_en = true;
 	msta_link->wcid.amsdu = true;
 
-	switch (sta->deflink.agg.max_amsdu_len) {
+	switch (link_sta->agg.max_amsdu_len) {
 	case IEEE80211_MAX_MPDU_LEN_VHT_11454:
 		amsdu->max_mpdu_size =
 			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454;
@@ -1358,30 +1362,31 @@ mt7996_mcu_sta_amsdu_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 
 static void
 mt7996_mcu_sta_muru_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
-			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+			struct ieee80211_bss_conf *link_conf,
+			struct ieee80211_link_sta *link_sta)
 {
-	struct ieee80211_he_cap_elem *elem = &sta->deflink.he_cap.he_cap_elem;
+	struct ieee80211_he_cap_elem *elem = &link_sta->he_cap.he_cap_elem;
 	struct sta_rec_muru *muru;
 	struct tlv *tlv;
 
-	if (vif->type != NL80211_IFTYPE_STATION &&
-	    vif->type != NL80211_IFTYPE_AP)
+	if (link_conf->vif->type != NL80211_IFTYPE_STATION &&
+	    link_conf->vif->type != NL80211_IFTYPE_AP)
 		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_MURU, sizeof(*muru));
 
 	muru = (struct sta_rec_muru *)tlv;
-	muru->cfg.mimo_dl_en = vif->bss_conf.eht_mu_beamformer ||
-			       vif->bss_conf.he_mu_beamformer ||
-			       vif->bss_conf.vht_mu_beamformer ||
-			       vif->bss_conf.vht_mu_beamformee;
+	muru->cfg.mimo_dl_en = link_conf->eht_mu_beamformer ||
+			       link_conf->he_mu_beamformer ||
+			       link_conf->vht_mu_beamformer ||
+			       link_conf->vht_mu_beamformee;
 	muru->cfg.ofdma_dl_en = true;
 
-	if (sta->deflink.vht_cap.vht_supported)
+	if (link_sta->vht_cap.vht_supported)
 		muru->mimo_dl.vht_mu_bfee =
-			!!(sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
+			!!(link_sta->vht_cap.cap & IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
 
-	if (!sta->deflink.he_cap.has_he)
+	if (!link_sta->he_cap.has_he)
 		return;
 
 	muru->mimo_dl.partial_bw_dl_mimo =
@@ -1412,49 +1417,50 @@ mt7996_mcu_sta_muru_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 }
 
 static inline bool
-mt7996_is_ebf_supported(struct mt7996_phy *phy, struct ieee80211_vif *vif,
-			struct ieee80211_sta *sta, bool bfee)
+mt7996_is_ebf_supported(struct mt7996_phy *phy,
+			struct ieee80211_bss_conf *link_conf,
+			struct ieee80211_link_sta *link_sta, bool bfee)
 {
 	int sts = hweight16(phy->mt76->chainmask);
 
-	if (vif->type != NL80211_IFTYPE_STATION &&
-	    vif->type != NL80211_IFTYPE_AP)
+	if (link_conf->vif->type != NL80211_IFTYPE_STATION &&
+	    link_conf->vif->type != NL80211_IFTYPE_AP)
 		return false;
 
 	if (!bfee && sts < 2)
 		return false;
 
-	if (sta->deflink.eht_cap.has_eht) {
-		struct ieee80211_sta_eht_cap *pc = &sta->deflink.eht_cap;
+	if (link_sta->eht_cap.has_eht) {
+		struct ieee80211_sta_eht_cap *pc = &link_sta->eht_cap;
 		struct ieee80211_eht_cap_elem_fixed *pe = &pc->eht_cap_elem;
 
 		if (bfee)
-			return vif->bss_conf.eht_su_beamformee &&
+			return link_conf->eht_su_beamformee &&
 			       EHT_PHY(CAP0_SU_BEAMFORMER, pe->phy_cap_info[0]);
 		else
-			return vif->bss_conf.eht_su_beamformer &&
+			return link_conf->eht_su_beamformer &&
 			       EHT_PHY(CAP0_SU_BEAMFORMEE, pe->phy_cap_info[0]);
 	}
 
-	if (sta->deflink.he_cap.has_he) {
-		struct ieee80211_he_cap_elem *pe = &sta->deflink.he_cap.he_cap_elem;
+	if (link_sta->he_cap.has_he) {
+		struct ieee80211_he_cap_elem *pe = &link_sta->he_cap.he_cap_elem;
 
 		if (bfee)
-			return vif->bss_conf.he_su_beamformee &&
+			return link_conf->he_su_beamformee &&
 			       HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]);
 		else
-			return vif->bss_conf.he_su_beamformer &&
+			return link_conf->he_su_beamformer &&
 			       HE_PHY(CAP4_SU_BEAMFORMEE, pe->phy_cap_info[4]);
 	}
 
-	if (sta->deflink.vht_cap.vht_supported) {
-		u32 cap = sta->deflink.vht_cap.cap;
+	if (link_sta->vht_cap.vht_supported) {
+		u32 cap = link_sta->vht_cap.cap;
 
 		if (bfee)
-			return vif->bss_conf.vht_su_beamformee &&
+			return link_conf->vht_su_beamformee &&
 			       (cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
 		else
-			return vif->bss_conf.vht_su_beamformer &&
+			return link_conf->vht_su_beamformer &&
 			       (cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
 	}
 
@@ -1475,10 +1481,11 @@ mt7996_mcu_sta_sounding_rate(struct sta_rec_bf *bf, struct mt7996_phy *phy)
 }
 
 static void
-mt7996_mcu_sta_bfer_ht(struct ieee80211_sta *sta, struct mt7996_phy *phy,
-		       struct sta_rec_bf *bf, bool explicit)
+mt7996_mcu_sta_bfer_ht(struct ieee80211_link_sta *link_sta,
+		       struct mt7996_phy *phy, struct sta_rec_bf *bf,
+		       bool explicit)
 {
-	struct ieee80211_mcs_info *mcs = &sta->deflink.ht_cap.mcs;
+	struct ieee80211_mcs_info *mcs = &link_sta->ht_cap.mcs;
 	u8 n = 0;
 
 	bf->tx_mode = MT_PHY_TYPE_HT;
@@ -1501,10 +1508,11 @@ mt7996_mcu_sta_bfer_ht(struct ieee80211_sta *sta, struct mt7996_phy *phy,
 }
 
 static void
-mt7996_mcu_sta_bfer_vht(struct ieee80211_sta *sta, struct mt7996_phy *phy,
-			struct sta_rec_bf *bf, bool explicit)
+mt7996_mcu_sta_bfer_vht(struct ieee80211_link_sta *link_sta,
+			struct mt7996_phy *phy, struct sta_rec_bf *bf,
+			bool explicit)
 {
-	struct ieee80211_sta_vht_cap *pc = &sta->deflink.vht_cap;
+	struct ieee80211_sta_vht_cap *pc = &link_sta->vht_cap;
 	struct ieee80211_sta_vht_cap *vc = &phy->mt76->sband_5g.sband.vht_cap;
 	u16 mcs_map = le16_to_cpu(pc->vht_mcs.rx_mcs_map);
 	u8 nss_mcs = mt7996_mcu_get_sta_nss(mcs_map);
@@ -1525,24 +1533,24 @@ mt7996_mcu_sta_bfer_vht(struct ieee80211_sta *sta, struct mt7996_phy *phy,
 		bf->ncol = min_t(u8, nss_mcs, bf->nrow);
 		bf->ibf_ncol = min_t(u8, MT7996_IBF_MAX_NC, bf->ncol);
 
-		if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
+		if (link_sta->bandwidth == IEEE80211_STA_RX_BW_160)
 			bf->nrow = 1;
 	} else {
 		bf->nrow = tx_ant;
 		bf->ncol = min_t(u8, nss_mcs, bf->nrow);
 		bf->ibf_ncol = min_t(u8, MT7996_IBF_MAX_NC, nss_mcs);
 
-		if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
+		if (link_sta->bandwidth == IEEE80211_STA_RX_BW_160)
 			bf->ibf_nrow = 1;
 	}
 }
 
 static void
-mt7996_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
-		       struct mt7996_phy *phy, struct sta_rec_bf *bf,
-		       bool explicit)
+mt7996_mcu_sta_bfer_he(struct ieee80211_link_sta *link_sta,
+		       struct ieee80211_vif *vif, struct mt7996_phy *phy,
+		       struct sta_rec_bf *bf, bool explicit)
 {
-	struct ieee80211_sta_he_cap *pc = &sta->deflink.he_cap;
+	struct ieee80211_sta_he_cap *pc = &link_sta->he_cap;
 	struct ieee80211_he_cap_elem *pe = &pc->he_cap_elem;
 	const struct ieee80211_sta_he_cap *vc =
 		mt76_connac_get_he_phy_cap(phy->mt76, vif);
@@ -1571,7 +1579,7 @@ mt7996_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 	bf->ibf_ncol = explicit ? min_t(u8, MT7996_IBF_MAX_NC, bf->ncol) :
 				  min_t(u8, MT7996_IBF_MAX_NC, nss_mcs);
 
-	if (sta->deflink.bandwidth != IEEE80211_STA_RX_BW_160)
+	if (link_sta->bandwidth != IEEE80211_STA_RX_BW_160)
 		return;
 
 	/* go over for 160MHz and 80p80 */
@@ -1603,11 +1611,11 @@ mt7996_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 }
 
 static void
-mt7996_mcu_sta_bfer_eht(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
-			struct mt7996_phy *phy, struct sta_rec_bf *bf,
-			bool explicit)
+mt7996_mcu_sta_bfer_eht(struct ieee80211_link_sta *link_sta,
+			struct ieee80211_vif *vif, struct mt7996_phy *phy,
+			struct sta_rec_bf *bf, bool explicit)
 {
-	struct ieee80211_sta_eht_cap *pc = &sta->deflink.eht_cap;
+	struct ieee80211_sta_eht_cap *pc = &link_sta->eht_cap;
 	struct ieee80211_eht_cap_elem_fixed *pe = &pc->eht_cap_elem;
 	struct ieee80211_eht_mcs_nss_supp *eht_nss = &pc->eht_mcs_nss_supp;
 	const struct ieee80211_sta_eht_cap *vc =
@@ -1631,10 +1639,10 @@ mt7996_mcu_sta_bfer_eht(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 	bf->ibf_ncol = explicit ? min_t(u8, MT7996_IBF_MAX_NC, bf->ncol) :
 				  min_t(u8, MT7996_IBF_MAX_NC, nss_mcs);
 
-	if (sta->deflink.bandwidth < IEEE80211_STA_RX_BW_160)
+	if (link_sta->bandwidth < IEEE80211_STA_RX_BW_160)
 		return;
 
-	switch (sta->deflink.bandwidth) {
+	switch (link_sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
 		snd_dim = EHT_PHY(CAP2_SOUNDING_DIM_160MHZ_MASK, ve->phy_cap_info[2]);
 		sts = EHT_PHY(CAP1_BEAMFORMEE_SS_160MHZ_MASK, pe->phy_cap_info[1]);
@@ -1662,13 +1670,15 @@ mt7996_mcu_sta_bfer_eht(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 
 static void
 mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
-			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+			struct ieee80211_bss_conf *link_conf,
+			struct ieee80211_link_sta *link_sta,
+			struct mt7996_vif_link *link)
 {
 #define EBF_MODE	BIT(0)
 #define IBF_MODE	BIT(1)
 #define BF_MAT_ORDER	4
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_phy *phy = mvif->deflink.phy;
+	struct ieee80211_vif *vif = link_conf->vif;
+	struct mt7996_phy *phy = link->phy;
 	int tx_ant = hweight16(phy->mt76->chainmask) - 1;
 	struct sta_rec_bf *bf;
 	struct tlv *tlv;
@@ -1680,10 +1690,10 @@ mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	};
 	bool ebf;
 
-	if (!(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
+	if (!(link_sta->ht_cap.ht_supported || link_sta->he_cap.has_he))
 		return;
 
-	ebf = mt7996_is_ebf_supported(phy, vif, sta, false);
+	ebf = mt7996_is_ebf_supported(phy, link_conf, link_sta, false);
 	if (!ebf && !dev->ibf)
 		return;
 
@@ -1694,28 +1704,29 @@ mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	 * vht: support eBF and iBF
 	 * ht: iBF only, since mac80211 lacks of eBF support
 	 */
-	if (sta->deflink.eht_cap.has_eht)
-		mt7996_mcu_sta_bfer_eht(sta, vif, phy, bf, ebf);
-	else if (sta->deflink.he_cap.has_he)
-		mt7996_mcu_sta_bfer_he(sta, vif, phy, bf, ebf);
-	else if (sta->deflink.vht_cap.vht_supported)
-		mt7996_mcu_sta_bfer_vht(sta, phy, bf, ebf);
-	else if (sta->deflink.ht_cap.ht_supported)
-		mt7996_mcu_sta_bfer_ht(sta, phy, bf, ebf);
+	if (link_sta->eht_cap.has_eht)
+		mt7996_mcu_sta_bfer_eht(link_sta, vif, link->phy, bf, ebf);
+	else if (link_sta->he_cap.has_he)
+		mt7996_mcu_sta_bfer_he(link_sta, vif, link->phy, bf, ebf);
+	else if (link_sta->vht_cap.vht_supported)
+		mt7996_mcu_sta_bfer_vht(link_sta, link->phy, bf, ebf);
+	else if (link_sta->ht_cap.ht_supported)
+		mt7996_mcu_sta_bfer_ht(link_sta, link->phy, bf, ebf);
 	else
 		return;
 
 	bf->bf_cap = ebf ? EBF_MODE : (dev->ibf ? IBF_MODE : 0);
 	if (is_mt7992(&dev->mt76) && tx_ant == 4)
 		bf->bf_cap |= IBF_MODE;
-	bf->bw = sta->deflink.bandwidth;
-	bf->ibf_dbw = sta->deflink.bandwidth;
+
+	bf->bw = link_sta->bandwidth;
+	bf->ibf_dbw = link_sta->bandwidth;
 	bf->ibf_nrow = tx_ant;
 
-	if (sta->deflink.eht_cap.has_eht || sta->deflink.he_cap.has_he)
+	if (link_sta->eht_cap.has_eht || link_sta->he_cap.has_he)
 		bf->ibf_timeout = is_mt7996(&dev->mt76) ? MT7996_IBF_TIMEOUT :
 							  MT7992_IBF_TIMEOUT;
-	else if (!ebf && sta->deflink.bandwidth <= IEEE80211_STA_RX_BW_40 && !bf->ncol)
+	else if (!ebf && link_sta->bandwidth <= IEEE80211_STA_RX_BW_40 && !bf->ncol)
 		bf->ibf_timeout = MT7996_IBF_TIMEOUT_LEGACY;
 	else
 		bf->ibf_timeout = MT7996_IBF_TIMEOUT;
@@ -1729,7 +1740,7 @@ mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 				      matrix[bf->nrow][bf->ncol] : 0;
 	}
 
-	switch (sta->deflink.bandwidth) {
+	switch (link_sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
 	case IEEE80211_STA_RX_BW_80:
 		bf->mem_total = bf->mem_20m * 2;
@@ -1745,31 +1756,32 @@ mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 
 static void
 mt7996_mcu_sta_bfee_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
-			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+			struct ieee80211_bss_conf *link_conf,
+			struct ieee80211_link_sta *link_sta,
+			struct mt7996_vif_link *link)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_phy *phy = mvif->deflink.phy;
+	struct mt7996_phy *phy = link->phy;
 	int tx_ant = hweight8(phy->mt76->antenna_mask) - 1;
 	struct sta_rec_bfee *bfee;
 	struct tlv *tlv;
 	u8 nrow = 0;
 
-	if (!(sta->deflink.vht_cap.vht_supported || sta->deflink.he_cap.has_he))
+	if (!(link_sta->vht_cap.vht_supported || link_sta->he_cap.has_he))
 		return;
 
-	if (!mt7996_is_ebf_supported(phy, vif, sta, true))
+	if (!mt7996_is_ebf_supported(phy, link_conf, link_sta, true))
 		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BFEE, sizeof(*bfee));
 	bfee = (struct sta_rec_bfee *)tlv;
 
-	if (sta->deflink.he_cap.has_he) {
-		struct ieee80211_he_cap_elem *pe = &sta->deflink.he_cap.he_cap_elem;
+	if (link_sta->he_cap.has_he) {
+		struct ieee80211_he_cap_elem *pe = &link_sta->he_cap.he_cap_elem;
 
 		nrow = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
 			      pe->phy_cap_info[5]);
-	} else if (sta->deflink.vht_cap.vht_supported) {
-		struct ieee80211_sta_vht_cap *pc = &sta->deflink.vht_cap;
+	} else if (link_sta->vht_cap.vht_supported) {
+		struct ieee80211_sta_vht_cap *pc = &link_sta->vht_cap;
 
 		nrow = FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
 				 pc->cap);
@@ -2131,7 +2143,7 @@ int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	 * update sta_rec_he here.
 	 */
 	if (changed)
-		mt7996_mcu_sta_he_tlv(skb, sta);
+		mt7996_mcu_sta_he_tlv(skb, &sta->deflink, &mvif->deflink);
 
 	/* sta_rec_ra accommodates BW, NSS and only MCS range format
 	 * i.e 0-{7,8,9} for VHT.
@@ -2179,67 +2191,67 @@ mt7996_mcu_add_group(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 				 sizeof(req), true);
 }
 
-int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-		       struct mt76_vif_link *mlink,
-		       struct ieee80211_sta *sta, int conn_state, bool newly)
+int mt7996_mcu_add_sta(struct mt7996_dev *dev,
+		       struct ieee80211_bss_conf *link_conf,
+		       struct ieee80211_link_sta *link_sta,
+		       struct mt7996_vif_link *link,
+		       struct mt7996_sta_link *msta_link,
+		       int conn_state, bool newly)
 {
-	struct ieee80211_link_sta *link_sta = NULL;
-	struct mt76_wcid *wcid = mlink->wcid;
+	struct mt76_wcid *wcid = msta_link ? &msta_link->wcid : link->mt76.wcid;
+	struct ieee80211_sta *sta = link_sta ? link_sta->sta : NULL;
 	struct sk_buff *skb;
 	int ret;
 
-	if (sta) {
-		struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-		struct mt7996_sta_link *msta_link = &msta->deflink;
-
-		wcid = &msta_link->wcid;
-		link_sta = &sta->deflink;
-	}
-
-	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, mlink, wcid,
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &link->mt76, wcid,
 					      MT7996_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
 	/* starec basic */
-	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, &vif->bss_conf, link_sta,
+	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, link_conf, link_sta,
 				      conn_state, newly);
 
 	if (conn_state == CONN_STATE_DISCONNECT)
 		goto out;
 
 	/* starec hdr trans */
-	mt7996_mcu_sta_hdr_trans_tlv(dev, skb, vif, wcid);
+	mt7996_mcu_sta_hdr_trans_tlv(dev, skb, link_conf->vif, wcid);
 	/* starec tx proc */
 	mt7996_mcu_sta_tx_proc_tlv(skb);
 
 	/* tag order is in accordance with firmware dependency. */
-	if (sta) {
+	if (link_sta) {
 		/* starec hdrt mode */
 		mt7996_mcu_sta_hdrt_tlv(dev, skb);
-		/* starec bfer */
-		mt7996_mcu_sta_bfer_tlv(dev, skb, vif, sta);
+		if (conn_state == CONN_STATE_CONNECT) {
+			/* starec bfer */
+			mt7996_mcu_sta_bfer_tlv(dev, skb, link_conf, link_sta,
+						link);
+			/* starec bfee */
+			mt7996_mcu_sta_bfee_tlv(dev, skb, link_conf, link_sta,
+						link);
+		}
 		/* starec ht */
-		mt7996_mcu_sta_ht_tlv(skb, sta);
+		mt7996_mcu_sta_ht_tlv(skb, link_sta);
 		/* starec vht */
-		mt7996_mcu_sta_vht_tlv(skb, sta);
+		mt7996_mcu_sta_vht_tlv(skb, link_sta);
 		/* starec uapsd */
-		mt76_connac_mcu_sta_uapsd(skb, vif, sta);
+		mt76_connac_mcu_sta_uapsd(skb, link_conf->vif, sta);
 		/* starec amsdu */
-		mt7996_mcu_sta_amsdu_tlv(dev, skb, vif, sta);
+		mt7996_mcu_sta_amsdu_tlv(dev, skb, link_conf->vif, link_sta,
+					 msta_link);
 		/* starec he */
-		mt7996_mcu_sta_he_tlv(skb, sta);
+		mt7996_mcu_sta_he_tlv(skb, link_sta, link);
 		/* starec he 6g*/
-		mt7996_mcu_sta_he_6g_tlv(skb, sta);
+		mt7996_mcu_sta_he_6g_tlv(skb, link_sta);
 		/* starec eht */
-		mt7996_mcu_sta_eht_tlv(skb, sta);
+		mt7996_mcu_sta_eht_tlv(skb, link_sta);
 		/* starec muru */
-		mt7996_mcu_sta_muru_tlv(dev, skb, vif, sta);
-		/* starec bfee */
-		mt7996_mcu_sta_bfee_tlv(dev, skb, vif, sta);
+		mt7996_mcu_sta_muru_tlv(dev, skb, link_conf, link_sta);
 	}
 
-	ret = mt7996_mcu_add_group(dev, vif, sta);
+	ret = mt7996_mcu_add_group(dev, link_conf->vif, sta);
 	if (ret) {
 		dev_kfree_skb(skb);
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index cf37baa91a8ba1cfafb07a4166aed0a0e84968fa..0dd9d798541f95f82bf8606512052eca79115f5c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -572,9 +572,12 @@ int mt7996_mcu_add_dev_info(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 int mt7996_mcu_add_bss_info(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 			    struct ieee80211_bss_conf *link_conf,
 			    struct mt76_vif_link *mlink, int enable);
-int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-		       struct mt76_vif_link *mlink,
-		       struct ieee80211_sta *sta, int conn_state, bool newly);
+int mt7996_mcu_add_sta(struct mt7996_dev *dev,
+		       struct ieee80211_bss_conf *link_conf,
+		       struct ieee80211_link_sta *link_sta,
+		       struct mt7996_vif_link *link,
+		       struct mt7996_sta_link *msta_link,
+		       int conn_state, bool newly);
 int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool add);

-- 
2.48.1


