Return-Path: <linux-wireless+bounces-17018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EF49FFBE5
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E771883D81
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B111B6CF5;
	Thu,  2 Jan 2025 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="T2wgckJI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C11B153BF0
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835729; cv=none; b=Iw2baDDnb7/dDkQGg/9Oo/1RttiKwgpvmBmkpX4DqkkQTNAwFytdqiL8I1w4ltFL2DiJ3bnjECqgzXHc9zN3gI/VzbzdZjjMt2Ur476C+nhjdvGb2swYOQhBbySNKXR4cxc5Ev2q+oMLxDHgoBmHt+3bcHf2Tsjet4Liy9BgSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835729; c=relaxed/simple;
	bh=el5eekgQm4XlmzTcdC2uxn7sfEEk6ANSfPqOwMgayJA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIAzFAlAG2jH4iiI4s3CMX7DowmQTlF52HBcTYVRDmWrwRxu6ed0BreiLLcT/R+6SeCICD21OqUMGHRhHvueVF71pNBVtpTY5MoI1eh45QEtDvt2pHTfNdjwMxjtw0IEUBlR6ere4rSsz8r3/U/mDFhy3QTaZb8xdSy4XhW9a28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=T2wgckJI; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OH+HEmI9kJmd5/NeF8P0eQOSXwC6DmAmmDv1Z5Zwoi8=; b=T2wgckJItza+MuQQV+GiOHsqUe
	foA6EQgWDqwI4c+GWSGdaGOJ4zbCzx1SJ7NAwIhLJbb73Dw5EdPojBpiB8jj90r1ZB4yGzbP8ny7/
	DvJAP66C+cKaUQ6Nu5qbgLEXtT02LzRhFa/Of/1Mpp0+Vx0dXZJsS3U1lDlShuH72mA4=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAD-0008GS-2T
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:13 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 15/24] wifi: mt76: mt7996: prepare mt7996_mcu_add_dev/bss_info for MLO support
Date: Thu,  2 Jan 2025 17:34:59 +0100
Message-ID: <20250102163508.52945-15-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102163508.52945-1-nbd@nbd.name>
References: <20250102163508.52945-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add extra arguments for struct ieee80211_bss_conf and mt76_vif_link.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  38 +++--
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 146 ++++++++----------
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  11 +-
 3 files changed, 99 insertions(+), 96 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index d7e33e3b04ac..6e90ecfecd8f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -204,7 +204,7 @@ mt7996_vif_link_add(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 	mlink->mt76.wmm_idx = vif->type == NL80211_IFTYPE_AP ? 0 : 3;
 	mlink->mt76.wcid = &mlink->sta.wcid;
 
-	ret = mt7996_mcu_add_dev_info(phy, vif, true);
+	ret = mt7996_mcu_add_dev_info(phy, vif, link_conf, &mlink->mt76, true);
 	if (ret)
 		return ret;
 
@@ -237,12 +237,13 @@ mt7996_vif_link_add(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 
 	mt7996_init_bitrate_mask(vif, mlink);
 
-	mt7996_mcu_add_bss_info(phy, vif, true);
+	mt7996_mcu_add_bss_info(phy, vif, link_conf, &mlink->mt76, true);
 	/* defer the first STA_REC of BMC entry to BSS_CHANGED_BSSID for STA
 	 * interface, since firmware only records BSSID when the entry is new
 	 */
 	if (vif->type != NL80211_IFTYPE_STATION)
-		mt7996_mcu_add_sta(dev, vif, NULL, CONN_STATE_PORT_SECURE, true);
+		mt7996_mcu_add_sta(dev, vif, &mlink->mt76, NULL,
+				   CONN_STATE_PORT_SECURE, true);
 	rcu_assign_pointer(dev->mt76.wcid[idx], &mlink->sta.wcid);
 
 	return 0;
@@ -264,10 +265,11 @@ mt7996_vif_link_remove(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 	mlink->phy = NULL;
 	msta = &mlink->sta;
 	idx = msta->wcid.idx;
-	mt7996_mcu_add_sta(dev, vif, NULL, CONN_STATE_DISCONNECT, false);
-	mt7996_mcu_add_bss_info(phy, vif, false);
+	mt7996_mcu_add_sta(dev, vif, &mlink->mt76, NULL, CONN_STATE_DISCONNECT,
+			   false);
+	mt7996_mcu_add_bss_info(phy, vif, link_conf, &mlink->mt76, false);
 
-	mt7996_mcu_add_dev_info(phy, vif, false);
+	mt7996_mcu_add_dev_info(phy, vif, link_conf, &mlink->mt76, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
@@ -397,7 +399,8 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	if (cmd == SET_KEY && !sta && !mlink->mt76.cipher) {
 		mlink->mt76.cipher = mt76_connac_mcu_get_cipher(key->cipher);
-		mt7996_mcu_add_bss_info(phy, vif, true);
+		mt7996_mcu_add_bss_info(phy, vif, &vif->bss_conf, &mlink->mt76,
+					true);
 	}
 
 	if (cmd == SET_KEY) {
@@ -626,8 +629,8 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 	if ((changed & BSS_CHANGED_BSSID && !is_zero_ether_addr(info->bssid)) ||
 	    (changed & BSS_CHANGED_ASSOC && vif->cfg.assoc) ||
 	    (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon)) {
-		mt7996_mcu_add_bss_info(phy, vif, true);
-		mt7996_mcu_add_sta(dev, vif, NULL, CONN_STATE_PORT_SECURE,
+		mt7996_mcu_add_bss_info(phy, vif, info, mvif, true);
+		mt7996_mcu_add_sta(dev, vif, mvif, NULL, CONN_STATE_PORT_SECURE,
 				   !!(changed & BSS_CHANGED_BSSID));
 	}
 
@@ -697,7 +700,8 @@ int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	u8 band_idx = mvif->deflink.phy->mt76->band_idx;
+	struct mt7996_vif_link *link = &mvif->deflink;
+	u8 band_idx = link->phy->mt76->band_idx;
 	int idx;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA);
@@ -715,7 +719,8 @@ int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	mt7996_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-	mt7996_mcu_add_sta(dev, vif, sta, CONN_STATE_DISCONNECT, true);
+	mt7996_mcu_add_sta(dev, vif, &link->mt76, sta, CONN_STATE_DISCONNECT,
+			   true);
 
 	return 0;
 }
@@ -725,11 +730,14 @@ int mt7996_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_vif_link *link = &mvif->deflink;
 	int i, ret;
 
 	switch (ev) {
 	case MT76_STA_EVENT_ASSOC:
-		ret = mt7996_mcu_add_sta(dev, vif, sta, CONN_STATE_CONNECT, true);
+		ret = mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
+					 CONN_STATE_CONNECT, true);
 		if (ret)
 			return ret;
 
@@ -743,13 +751,15 @@ int mt7996_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		return 0;
 
 	case MT76_STA_EVENT_AUTHORIZE:
-		return mt7996_mcu_add_sta(dev, vif, sta, CONN_STATE_PORT_SECURE, false);
+		return mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
+					  CONN_STATE_PORT_SECURE, false);
 
 	case MT76_STA_EVENT_DISASSOC:
 		for (i = 0; i < ARRAY_SIZE(msta->twt.flow); i++)
 			mt7996_mac_twt_teardown_flow(dev, msta, i);
 
-		mt7996_mcu_add_sta(dev, vif, sta, CONN_STATE_DISCONNECT, false);
+		mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
+				   CONN_STATE_DISCONNECT, false);
 		msta->wcid.sta_disabled = 1;
 		msta->wcid.sta = 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index ebb2ff15a8d8..43c728d39077 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -756,8 +756,7 @@ mt7996_mcu_add_uni_tlv(struct sk_buff *skb, u16 tag, u16 len)
 }
 
 static void
-mt7996_mcu_bss_rfch_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
-			struct mt7996_phy *phy)
+mt7996_mcu_bss_rfch_tlv(struct sk_buff *skb, struct mt7996_phy *phy)
 {
 	static const u8 rlm_ch_band[] = {
 		[NL80211_BAND_2GHZ] = 1,
@@ -787,8 +786,7 @@ mt7996_mcu_bss_rfch_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 }
 
 static void
-mt7996_mcu_bss_ra_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
-		      struct mt7996_phy *phy)
+mt7996_mcu_bss_ra_tlv(struct sk_buff *skb, struct mt7996_phy *phy)
 {
 	struct bss_ra_tlv *ra;
 	struct tlv *tlv;
@@ -801,6 +799,7 @@ mt7996_mcu_bss_ra_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 
 static void
 mt7996_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+		      struct ieee80211_bss_conf *link_conf,
 		      struct mt7996_phy *phy)
 {
 #define DEFAULT_HE_PE_DURATION		4
@@ -814,11 +813,11 @@ mt7996_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
 
 	he = (struct bss_info_uni_he *)tlv;
-	he->he_pe_duration = vif->bss_conf.htc_trig_based_pkt_ext;
+	he->he_pe_duration = link_conf->htc_trig_based_pkt_ext;
 	if (!he->he_pe_duration)
 		he->he_pe_duration = DEFAULT_HE_PE_DURATION;
 
-	he->he_rts_thres = cpu_to_le16(vif->bss_conf.frame_time_rts_th);
+	he->he_rts_thres = cpu_to_le16(link_conf->frame_time_rts_th);
 	if (!he->he_rts_thres)
 		he->he_rts_thres = cpu_to_le16(DEFAULT_HE_DURATION_RTS_THRES);
 
@@ -828,13 +827,13 @@ mt7996_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 }
 
 static void
-mt7996_mcu_bss_mbssid_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
-			  struct mt7996_phy *phy, int enable)
+mt7996_mcu_bss_mbssid_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf,
+			  bool enable)
 {
 	struct bss_info_uni_mbssid *mbssid;
 	struct tlv *tlv;
 
-	if (!vif->bss_conf.bssid_indicator && enable)
+	if (!link_conf->bssid_indicator && enable)
 		return;
 
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_11V_MBSSID, sizeof(*mbssid));
@@ -842,23 +841,22 @@ mt7996_mcu_bss_mbssid_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	mbssid = (struct bss_info_uni_mbssid *)tlv;
 
 	if (enable) {
-		mbssid->max_indicator = vif->bss_conf.bssid_indicator;
-		mbssid->mbss_idx = vif->bss_conf.bssid_index;
+		mbssid->max_indicator = link_conf->bssid_indicator;
+		mbssid->mbss_idx = link_conf->bssid_index;
 		mbssid->tx_bss_omac_idx = 0;
 	}
 }
 
 static void
-mt7996_mcu_bss_bmc_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+mt7996_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt76_vif_link *mlink,
 		       struct mt7996_phy *phy)
 {
-	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct bss_rate_tlv *bmc;
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	enum nl80211_band band = chandef->chan->band;
 	struct tlv *tlv;
-	u8 idx = mvif->mcast_rates_idx ?
-		 mvif->mcast_rates_idx : mvif->basic_rates_idx;
+	u8 idx = mlink->mcast_rates_idx ?
+		 mlink->mcast_rates_idx : mlink->basic_rates_idx;
 
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_RATE, sizeof(*bmc));
 
@@ -882,9 +880,8 @@ mt7996_mcu_bss_txcmd_tlv(struct sk_buff *skb, bool en)
 }
 
 static void
-mt7996_mcu_bss_mld_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
+mt7996_mcu_bss_mld_tlv(struct sk_buff *skb, struct mt76_vif_link *mlink)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct bss_mld_tlv *mld;
 	struct tlv *tlv;
 
@@ -892,33 +889,28 @@ mt7996_mcu_bss_mld_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 
 	mld = (struct bss_mld_tlv *)tlv;
 	mld->group_mld_id = 0xff;
-	mld->own_mld_id = mvif->deflink.mt76.idx;
+	mld->own_mld_id = mlink->idx;
 	mld->remap_idx = 0xff;
 }
 
 static void
-mt7996_mcu_bss_sec_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
+mt7996_mcu_bss_sec_tlv(struct sk_buff *skb, struct mt76_vif_link *mlink)
 {
-	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct bss_sec_tlv *sec;
 	struct tlv *tlv;
 
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_SEC, sizeof(*sec));
 
 	sec = (struct bss_sec_tlv *)tlv;
-	sec->cipher = mvif->cipher;
+	sec->cipher = mlink->cipher;
 }
 
 static int
-mt7996_mcu_muar_config(struct mt7996_phy *phy, struct ieee80211_vif *vif,
-		       bool bssid, bool enable)
+mt7996_mcu_muar_config(struct mt7996_dev *dev, struct mt76_vif_link *mlink,
+		       const u8 *addr, bool bssid, bool enable)
 {
 #define UNI_MUAR_ENTRY 2
-	struct mt7996_dev *dev = phy->dev;
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	u32 idx = mvif->deflink.mt76.omac_idx - REPEATER_BSSID_START;
-	const u8 *addr = vif->addr;
-
+	u32 idx = mlink->omac_idx - REPEATER_BSSID_START;
 	struct {
 		struct {
 			u8 band;
@@ -935,7 +927,7 @@ mt7996_mcu_muar_config(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 		u8 addr[ETH_ALEN];
 		u8 __rsv[2];
 	} __packed req = {
-		.hdr.band = phy->mt76->band_idx,
+		.hdr.band = mlink->band_idx,
 		.tag = cpu_to_le16(UNI_MUAR_ENTRY),
 		.len = cpu_to_le16(sizeof(req) - sizeof(req.hdr)),
 		.smesh = false,
@@ -943,9 +935,6 @@ mt7996_mcu_muar_config(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 		.entry_add = true,
 	};
 
-	if (bssid)
-		addr = vif->bss_conf.bssid;
-
 	if (enable)
 		memcpy(req.addr, addr, ETH_ALEN);
 
@@ -954,10 +943,8 @@ mt7996_mcu_muar_config(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 }
 
 static void
-mt7996_mcu_bss_ifs_timing_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
+mt7996_mcu_bss_ifs_timing_tlv(struct sk_buff *skb, struct mt7996_phy *phy)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_phy *phy = mvif->deflink.phy;
 	struct bss_ifs_time_tlv *ifs_time;
 	struct tlv *tlv;
 	bool is_2ghz = phy->mt76->chandef.chan->band == NL80211_BAND_2GHZ;
@@ -984,15 +971,16 @@ mt7996_mcu_bss_ifs_timing_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 static int
 mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 			 struct ieee80211_vif *vif,
-			 struct ieee80211_sta *sta,
+			 struct ieee80211_bss_conf *link_conf,
+			 struct mt76_vif_link *mvif,
 			 struct mt76_phy *phy, u16 wlan_idx,
 			 bool enable)
 {
-	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct cfg80211_chan_def *chandef = &phy->chandef;
 	struct mt76_connac_bss_basic_tlv *bss;
 	u32 type = CONNECTION_INFRA_AP;
 	u16 sta_wlan_idx = wlan_idx;
+	struct ieee80211_sta *sta;
 	struct tlv *tlv;
 	int idx;
 
@@ -1004,9 +992,7 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 	case NL80211_IFTYPE_STATION:
 		if (enable) {
 			rcu_read_lock();
-			if (!sta)
-				sta = ieee80211_find_sta(vif,
-							 vif->bss_conf.bssid);
+			sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
 			/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
 			if (sta) {
 				struct mt76_wcid *wcid;
@@ -1029,8 +1015,8 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_BASIC, sizeof(*bss));
 
 	bss = (struct mt76_connac_bss_basic_tlv *)tlv;
-	bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
-	bss->dtim_period = vif->bss_conf.dtim_period;
+	bss->bcn_interval = cpu_to_le16(link_conf->beacon_int);
+	bss->dtim_period = link_conf->dtim_period;
 	bss->bmc_tx_wlan_idx = cpu_to_le16(wlan_idx);
 	bss->sta_idx = cpu_to_le16(sta_wlan_idx);
 	bss->conn_type = cpu_to_le32(type);
@@ -1048,8 +1034,8 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 		return 0;
 	}
 
-	memcpy(bss->bssid, vif->bss_conf.bssid, ETH_ALEN);
-	bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
+	memcpy(bss->bssid, link_conf->bssid, ETH_ALEN);
+	bss->bcn_interval = cpu_to_le16(link_conf->beacon_int);
 	bss->dtim_period = vif->bss_conf.dtim_period;
 	bss->phymode = mt76_connac_get_phy_mode(phy, vif,
 						chandef->chan->band, NULL);
@@ -1076,46 +1062,46 @@ __mt7996_mcu_alloc_bss_req(struct mt76_dev *dev, struct mt76_vif_link *mvif, int
 	return skb;
 }
 
-int mt7996_mcu_add_bss_info(struct mt7996_phy *phy,
-			    struct ieee80211_vif *vif, int enable)
+int mt7996_mcu_add_bss_info(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct mt76_vif_link *mlink, int enable)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_dev *dev = phy->dev;
 	struct sk_buff *skb;
 
-	if (mvif->deflink.mt76.omac_idx >= REPEATER_BSSID_START) {
-		mt7996_mcu_muar_config(phy, vif, false, enable);
-		mt7996_mcu_muar_config(phy, vif, true, enable);
+	if (mlink->omac_idx >= REPEATER_BSSID_START) {
+		mt7996_mcu_muar_config(dev, mlink, link_conf->addr, false, enable);
+		mt7996_mcu_muar_config(dev, mlink, link_conf->bssid, true, enable);
 	}
 
-	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->deflink.mt76,
+	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, mlink,
 					 MT7996_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
 	/* bss_basic must be first */
-	mt7996_mcu_bss_basic_tlv(skb, vif, NULL, phy->mt76,
-				 mvif->deflink.sta.wcid.idx, enable);
-	mt7996_mcu_bss_sec_tlv(skb, vif);
+	mt7996_mcu_bss_basic_tlv(skb, vif, link_conf, mlink, phy->mt76,
+				 mlink->wcid->idx, enable);
+	mt7996_mcu_bss_sec_tlv(skb, mlink);
 
 	if (vif->type == NL80211_IFTYPE_MONITOR)
 		goto out;
 
 	if (enable) {
-		mt7996_mcu_bss_rfch_tlv(skb, vif, phy);
-		mt7996_mcu_bss_bmc_tlv(skb, vif, phy);
-		mt7996_mcu_bss_ra_tlv(skb, vif, phy);
+		mt7996_mcu_bss_rfch_tlv(skb, phy);
+		mt7996_mcu_bss_bmc_tlv(skb, mlink, phy);
+		mt7996_mcu_bss_ra_tlv(skb, phy);
 		mt7996_mcu_bss_txcmd_tlv(skb, true);
-		mt7996_mcu_bss_ifs_timing_tlv(skb, vif);
+		mt7996_mcu_bss_ifs_timing_tlv(skb, phy);
 
 		if (vif->bss_conf.he_support)
-			mt7996_mcu_bss_he_tlv(skb, vif, phy);
+			mt7996_mcu_bss_he_tlv(skb, vif, link_conf, phy);
 
 		/* this tag is necessary no matter if the vif is MLD */
-		mt7996_mcu_bss_mld_tlv(skb, vif);
+		mt7996_mcu_bss_mld_tlv(skb, mlink);
 	}
 
-	mt7996_mcu_bss_mbssid_tlv(skb, vif, phy, enable);
+	mt7996_mcu_bss_mbssid_tlv(skb, link_conf, enable);
 
 out:
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
@@ -1133,7 +1119,7 @@ int mt7996_mcu_set_timing(struct mt7996_phy *phy, struct ieee80211_vif *vif)
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	mt7996_mcu_bss_ifs_timing_tlv(skb, vif);
+	mt7996_mcu_bss_ifs_timing_tlv(skb, phy);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
@@ -2166,19 +2152,22 @@ mt7996_mcu_add_group(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 }
 
 int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+		       struct mt76_vif_link *mlink,
 		       struct ieee80211_sta *sta, int conn_state, bool newly)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct ieee80211_link_sta *link_sta;
-	struct mt7996_sta *msta;
+	struct ieee80211_link_sta *link_sta = NULL;
+	struct mt76_wcid *wcid = mlink->wcid;
 	struct sk_buff *skb;
 	int ret;
 
-	msta = sta ? (struct mt7996_sta *)sta->drv_priv : &mvif->deflink.sta;
-	link_sta = sta ? &sta->deflink : NULL;
+	if (sta) {
+		struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 
-	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->deflink.mt76,
-					      &msta->wcid,
+		wcid = &msta->wcid;
+		link_sta = &sta->deflink;
+	}
+
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, mlink, wcid,
 					      MT7996_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -2191,7 +2180,7 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		goto out;
 
 	/* starec hdr trans */
-	mt7996_mcu_sta_hdr_trans_tlv(dev, skb, vif, &msta->wcid);
+	mt7996_mcu_sta_hdr_trans_tlv(dev, skb, vif, wcid);
 	/* starec tx proc */
 	mt7996_mcu_sta_tx_proc_tlv(skb);
 
@@ -2382,11 +2371,12 @@ int mt7996_mcu_bcn_prot_enable(struct mt7996_dev *dev, struct ieee80211_vif *vif
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
 }
-int mt7996_mcu_add_dev_info(struct mt7996_phy *phy,
-			    struct ieee80211_vif *vif, bool enable)
+
+int mt7996_mcu_add_dev_info(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct mt76_vif_link *mlink, bool enable)
 {
 	struct mt7996_dev *dev = phy->dev;
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct {
 		struct req_hdr {
 			u8 omac_idx;
@@ -2402,8 +2392,8 @@ int mt7996_mcu_add_dev_info(struct mt7996_phy *phy,
 		} __packed tlv;
 	} data = {
 		.hdr = {
-			.omac_idx = mvif->deflink.mt76.omac_idx,
-			.band_idx = mvif->deflink.mt76.band_idx,
+			.omac_idx = mlink->omac_idx,
+			.band_idx = mlink->band_idx,
 		},
 		.tlv = {
 			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
@@ -2412,10 +2402,10 @@ int mt7996_mcu_add_dev_info(struct mt7996_phy *phy,
 		},
 	};
 
-	if (mvif->deflink.mt76.omac_idx >= REPEATER_BSSID_START)
-		return mt7996_mcu_muar_config(phy, vif, false, enable);
+	if (mlink->omac_idx >= REPEATER_BSSID_START)
+		return mt7996_mcu_muar_config(dev, mlink, link_conf->addr, false, enable);
 
-	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
+	memcpy(data.tlv.omac_addr, link_conf->addr, ETH_ALEN);
 	return mt76_mcu_send_msg(&dev->mt76, MCU_WMWA_UNI_CMD(DEV_INFO_UPDATE),
 				 &data, sizeof(data), true);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 31d1fdd61de6..006269d75e5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -516,11 +516,14 @@ int mt7996_mcu_twt_agrt_update(struct mt7996_dev *dev,
 			       struct mt7996_vif *mvif,
 			       struct mt7996_twt_flow *flow,
 			       int cmd);
-int mt7996_mcu_add_dev_info(struct mt7996_phy *phy,
-			    struct ieee80211_vif *vif, bool enable);
-int mt7996_mcu_add_bss_info(struct mt7996_phy *phy,
-			    struct ieee80211_vif *vif, int enable);
+int mt7996_mcu_add_dev_info(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct mt76_vif_link *mlink, bool enable);
+int mt7996_mcu_add_bss_info(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct mt76_vif_link *mlink, int enable);
 int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+		       struct mt76_vif_link *mlink,
 		       struct ieee80211_sta *sta, int conn_state, bool newly);
 int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
 			 struct ieee80211_ampdu_params *params,
-- 
2.47.1


