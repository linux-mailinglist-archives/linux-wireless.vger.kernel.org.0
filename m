Return-Path: <linux-wireless+bounces-12879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E27979ACD
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 07:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B93D1F232A3
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 05:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1726F2D032;
	Mon, 16 Sep 2024 05:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SX8/27s6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B03EA71
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464788; cv=none; b=Sunf17tqyW+1jB8b/qFiqvJs3l+2m36XW97fhrPKMheG6HgQdmOIiUYODwVw6bwpnGuDRctPPbdAgoKF6PpHVC0PF3hzejnZx7MK63+LinBtAuB1h8e5n7dDO+vM6E4ED/u0OKmGCUL4fMCcxlm5nuZ7Oxlb4n5Y/6Q41eT7tKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464788; c=relaxed/simple;
	bh=t3tKiBBWStNScHO8eEurVeL5PGAP2u+Q75uDHXd+SAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQv78XkXOVQb8GGChuvoKq/QAIafKxl0sbOY3Yr4kssGFhVjnHuuBSmVfxlEjQr2LZS0siBnUDDoM6a8Lt3KoXZAR19a4JQn0typf0VvEcPVAfWb6p8oMRHCpomOg4KnX2/yPgM//ilwsTK/z6huP/z6W4UC7e6mxEN00iK3784=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SX8/27s6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48G5X2c842631720, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726464782; bh=t3tKiBBWStNScHO8eEurVeL5PGAP2u+Q75uDHXd+SAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=SX8/27s6MaalYiy2jCQBVJqZ4zZUKyBQ35myNXq8maBejHl6EDwncKmMu98HdFvD9
	 2mL7QM8+ciCDEqNwPFf0M7osiL/jSjKi8f5XTZGWUF2Ki9Qq4hAON9eu1ZTU4LBKYD
	 tCE33Rs+FGnikpqxzTDR7ePpPd33EnFlEl/SEhArP8lvjdWELvDb7Iuy6S5qUkQ/cM
	 l69UsLVR8zG2erWsPjJIBQnFgovzVL9g0HZTpdpQkw3U9afq1oCmapFU+RUwr4QHYM
	 CZwIphifeN8j9J6kG50UGsJ8X0G09fpMiIvXzbPYjsW6WA+VZSiF6rTohX16ntmd9h
	 WQ7bGSugqEw0w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48G5X2c842631720
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 13:33:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 13:33:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Sep
 2024 13:33:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 4/7] wifi: rtw89: read link_sta corresponding to the link
Date: Mon, 16 Sep 2024 13:31:55 +0800
Message-ID: <20240916053158.47350-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240916053158.47350-1-pkshih@realtek.com>
References: <20240916053158.47350-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Tweak code to not always access sta->deflink directly. Instead,
according to link_id, read target link_sta from sta->link[].

For now, rtwsta_link->link_id keeps 0. When driver starts to
support MLO, the link_id will be assigned.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c    |  14 +-
 drivers/net/wireless/realtek/rtw89/coex.c   |  16 +-
 drivers/net/wireless/realtek/rtw89/core.c   |  53 ++++++-
 drivers/net/wireless/realtek/rtw89/core.h   |  43 +++++-
 drivers/net/wireless/realtek/rtw89/debug.c  |  21 ++-
 drivers/net/wireless/realtek/rtw89/fw.c     |  97 +++++++-----
 drivers/net/wireless/realtek/rtw89/mac.c    |  61 ++++++--
 drivers/net/wireless/realtek/rtw89/mac_be.c |  45 ++++--
 drivers/net/wireless/realtek/rtw89/phy.c    | 154 ++++++++++++--------
 9 files changed, 362 insertions(+), 142 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 757f7633b079..7efc6280feaf 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -712,11 +712,21 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 	struct rtw89_addr_cam_entry *addr_cam =
 		rtw89_get_addr_cam_of(rtwvif_link, rtwsta_link);
 	struct ieee80211_sta *sta = rtwsta_to_sta_safe(rtwsta_link);
+	struct ieee80211_link_sta *link_sta;
 	const u8 *sma = scan_mac_addr ? scan_mac_addr : rtwvif_link->mac_addr;
 	u8 sma_hash, tma_hash, addr_msk_start;
 	u8 sma_start = 0;
 	u8 tma_start = 0;
-	u8 *tma = sta ? sta->addr : rtwvif_link->bssid;
+	const u8 *tma;
+
+	rcu_read_lock();
+
+	if (sta) {
+		link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
+		tma = link_sta->addr;
+	} else {
+		tma = rtwvif_link->bssid;
+	}
 
 	if (addr_cam->addr_mask != 0) {
 		addr_msk_start = __ffs(addr_cam->addr_mask);
@@ -791,6 +801,8 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 	FWCMD_SET_ADDR_SEC_ENT4(cmd, addr_cam->sec_ent[4]);
 	FWCMD_SET_ADDR_SEC_ENT5(cmd, addr_cam->sec_ent[5]);
 	FWCMD_SET_ADDR_SEC_ENT6(cmd, addr_cam->sec_ent[6]);
+
+	rcu_read_unlock();
 }
 
 void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 591c24df1825..e4ae80742ba3 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -7487,8 +7487,8 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
-	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
 	struct ieee80211_bss_conf *bss_conf;
+	struct ieee80211_link_sta *link_sta;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
@@ -7514,19 +7514,21 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 		    bss_conf->beacon_int, bss_conf->dtim_period);
 
 	if (rtwsta_link) {
+		link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, false);
+
 		rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], STA mac_id=%d\n",
 			    rtwsta_link->mac_id);
 
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], STA support HE=%d VHT=%d HT=%d\n",
-			    sta->deflink.he_cap.has_he,
-			    sta->deflink.vht_cap.vht_supported,
-			    sta->deflink.ht_cap.ht_supported);
-		if (sta->deflink.he_cap.has_he)
+			    link_sta->he_cap.has_he,
+			    link_sta->vht_cap.vht_supported,
+			    link_sta->ht_cap.ht_supported);
+		if (link_sta->he_cap.has_he)
 			mode |= BIT(BTC_WL_MODE_HE);
-		if (sta->deflink.vht_cap.vht_supported)
+		if (link_sta->vht_cap.vht_supported)
 			mode |= BIT(BTC_WL_MODE_VHT);
-		if (sta->deflink.ht_cap.ht_supported)
+		if (link_sta->ht_cap.ht_supported)
 			mode |= BIT(BTC_WL_MODE_HT);
 
 		r.mode = mode;
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index f1db598c6004..84c1952fbea8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -465,6 +465,7 @@ rtw89_core_tx_update_ampdu_info(struct rtw89_dev *rtwdev,
 {
 	struct ieee80211_sta *sta = tx_req->sta;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
+	struct ieee80211_link_sta *link_sta;
 	struct sk_buff *skb = tx_req->skb;
 	struct rtw89_sta_link *rtwsta_link;
 	u8 ampdu_num;
@@ -486,13 +487,18 @@ rtw89_core_tx_update_ampdu_info(struct rtw89_dev *rtwdev,
 	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
 	rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 
+	rcu_read_lock();
+
+	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, false);
 	ampdu_num = (u8)((rtwsta_link->ampdu_params[tid].agg_num ?
 			  rtwsta_link->ampdu_params[tid].agg_num :
-			  4 << sta->deflink.ht_cap.ampdu_factor) - 1);
+			  4 << link_sta->ht_cap.ampdu_factor) - 1);
 
 	desc_info->agg_en = true;
-	desc_info->ampdu_density = sta->deflink.ht_cap.ampdu_density;
+	desc_info->ampdu_density = link_sta->ht_cap.ampdu_density;
 	desc_info->ampdu_num = ampdu_num;
+
+	rcu_read_unlock();
 }
 
 static void
@@ -721,15 +727,26 @@ __rtw89_core_tx_check_he_qos_htc(struct rtw89_dev *rtwdev,
 	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
 	struct sk_buff *skb = tx_req->skb;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
+	struct ieee80211_link_sta *link_sta;
 	__le16 fc = hdr->frame_control;
 
 	/* AP IOT issue with EAPoL, ARP and DHCP */
 	if (pkt_type < PACKET_MAX)
 		return false;
 
-	if (!sta || !sta->deflink.he_cap.has_he)
+	if (!rtwsta_link)
 		return false;
 
+	rcu_read_lock();
+
+	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, false);
+	if (!link_sta->he_cap.has_he) {
+		rcu_read_unlock();
+		return false;
+	}
+
+	rcu_read_unlock();
+
 	if (!ieee80211_is_data_qos(fc))
 		return false;
 
@@ -802,10 +819,13 @@ static u16 rtw89_core_get_data_rate(struct rtw89_dev *rtwdev,
 	struct ieee80211_vif *vif = tx_req->vif;
 	struct ieee80211_sta *sta = tx_req->sta;
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
 	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif_link->rate_pattern;
 	enum rtw89_chanctx_idx idx = rtwvif_link->chanctx_idx;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, idx);
+	struct ieee80211_link_sta *link_sta;
 	u16 lowest_rate;
+	u16 rate;
 
 	if (rate_pattern->enable)
 		return rate_pattern->rate;
@@ -817,10 +837,23 @@ static u16 rtw89_core_get_data_rate(struct rtw89_dev *rtwdev,
 	else
 		lowest_rate = RTW89_HW_RATE_OFDM6;
 
-	if (!sta || !sta->deflink.supp_rates[chan->band_type])
+	if (!rtwsta_link)
 		return lowest_rate;
 
-	return __ffs(sta->deflink.supp_rates[chan->band_type]) + lowest_rate;
+	rcu_read_lock();
+
+	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, false);
+	if (!link_sta->supp_rates[chan->band_type]) {
+		rate = lowest_rate;
+		goto out;
+	}
+
+	rate = __ffs(link_sta->supp_rates[chan->band_type]) + lowest_rate;
+
+out:
+	rcu_read_unlock();
+
+	return rate;
 }
 
 static void
@@ -3645,12 +3678,20 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 
 	if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
 		if (sta->tdls) {
+			struct ieee80211_link_sta *link_sta;
+
+			rcu_read_lock();
+
+			link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
 			ret = rtw89_cam_init_bssid_cam(rtwdev, rtwvif_link, bssid_cam,
-						       sta->addr);
+						       link_sta->addr);
 			if (ret) {
 				rtw89_warn(rtwdev, "failed to send h2c init bssid cam for TDLS\n");
+				rcu_read_unlock();
 				return ret;
 			}
+
+			rcu_read_unlock();
 		}
 
 		ret = rtw89_cam_init_addr_cam(rtwdev, &rtwsta_link->addr_cam, bssid_cam);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8f66d4fac9aa..274051e53f19 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3355,6 +3355,8 @@ struct rtw89_sec_cam_entry {
 };
 
 struct rtw89_sta_link {
+	unsigned int link_id;
+
 	u8 mac_id;
 	bool disassoc;
 	bool er_cap;
@@ -6026,6 +6028,36 @@ __rtw89_vif_rcu_dereference_link(struct rtw89_vif_link *rtwvif_link, bool *nolin
 	bss_conf;							\
 })
 
+static inline struct ieee80211_link_sta *
+__rtw89_sta_rcu_dereference_link(struct rtw89_sta_link *rtwsta_link, bool *nolink)
+{
+	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
+	struct ieee80211_link_sta *link_sta;
+
+	link_sta = rcu_dereference(sta->link[rtwsta_link->link_id]);
+	if (unlikely(!link_sta)) {
+		*nolink = true;
+		return &sta->deflink;
+	}
+
+	*nolink = false;
+	return link_sta;
+}
+
+#define rtw89_sta_rcu_dereference_link(rtwsta_link, assert)		\
+({									\
+	typeof(rtwsta_link) p = rtwsta_link;				\
+	struct ieee80211_link_sta *link_sta;				\
+	bool nolink;							\
+									\
+	link_sta = __rtw89_sta_rcu_dereference_link(p, &nolink);	\
+	if (unlikely(nolink) && (assert))				\
+		rtw89_err(p->rtwdev,					\
+			  "%s: cannot find exact link_sta for link_id %u\n",\
+			  __func__, p->link_id);			\
+	link_sta;							\
+})
+
 static inline u8 rtw89_hw_to_rate_info_bw(enum rtw89_bandwidth hw_bw)
 {
 	if (hw_bw == RTW89_CHANNEL_WIDTH_160)
@@ -6497,13 +6529,14 @@ static inline u8 *get_hdr_bssid(struct ieee80211_hdr *hdr)
 		return hdr->addr3;
 }
 
-static inline bool rtw89_sta_has_beamformer_cap(struct ieee80211_sta *sta)
+static inline
+bool rtw89_sta_has_beamformer_cap(struct ieee80211_link_sta *link_sta)
 {
-	if ((sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE) ||
-	    (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE) ||
-	    (sta->deflink.he_cap.he_cap_elem.phy_cap_info[3] &
+	if ((link_sta->vht_cap.cap & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE) ||
+	    (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE) ||
+	    (link_sta->he_cap.he_cap_elem.phy_cap_info[3] &
 			IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER) ||
-	    (sta->deflink.he_cap.he_cap_elem.phy_cap_info[4] &
+	    (link_sta->he_cap.he_cap_elem.phy_cap_info[4] &
 			IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER))
 		return true;
 	return false;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index f09f1a251b16..cc7aaf6fa31f 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3526,11 +3526,20 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 ant_num = hal->ant_diversity ? 2 : rtwdev->chip->rf_path_num;
 	bool ant_asterisk = hal->tx_path_diversity || hal->ant_diversity;
+	struct ieee80211_link_sta *link_sta;
 	u8 evm_min, evm_max, evm_1ss;
+	u16 max_rc_amsdu_len;
 	u8 rssi;
 	u8 snr;
 	int i;
 
+	rcu_read_lock();
+
+	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
+	max_rc_amsdu_len = link_sta->agg.max_rc_amsdu_len;
+
+	rcu_read_unlock();
+
 	seq_printf(m, "TX rate [%d]: ", rtwsta_link->mac_id);
 
 	if (rate->flags & RATE_INFO_FLAGS_MCS)
@@ -3553,7 +3562,7 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	seq_printf(m, " BW:%u", rtw89_rate_info_bw_to_mhz(rate->bw));
 	seq_printf(m, "\t(hw_rate=0x%x)", rtwsta_link->ra_report.hw_rate);
 	seq_printf(m, "\t==> agg_wait=%d (%d)\n", rtwsta_link->max_agg_wait,
-		   sta->deflink.agg.max_rc_amsdu_len);
+		   max_rc_amsdu_len);
 
 	seq_printf(m, "RX rate [%d]: ", rtwsta_link->mac_id);
 
@@ -3777,9 +3786,17 @@ static void rtw89_sta_ids_get_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_dev *rtwdev = rtwsta_link->rtwdev;
 	struct seq_file *m = (struct seq_file *)data;
+	struct ieee80211_link_sta *link_sta;
+
+	rcu_read_lock();
 
-	seq_printf(m, "STA [%d] %pM %s\n", rtwsta_link->mac_id, sta->addr,
+	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
+
+	seq_printf(m, "STA [%d] %pM %s\n", rtwsta_link->mac_id, link_sta->addr,
 		   sta->tdls ? "(TDLS)" : "");
+
+	rcu_read_unlock();
+
 	rtw89_dump_addr_cam(m, rtwdev, &rtwsta_link->addr_cam);
 	rtw89_dump_ba_cam(m, rtwsta_link);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 10069f0ce6a3..52e5dbe7e59d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2776,24 +2776,25 @@ int rtw89_fw_h2c_default_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 EXPORT_SYMBOL(rtw89_fw_h2c_default_cmac_tbl_g7);
 
 static void __get_sta_he_pkt_padding(struct rtw89_dev *rtwdev,
-				     struct ieee80211_sta *sta, u8 *pads)
+				     struct ieee80211_link_sta *link_sta,
+				     u8 *pads)
 {
 	bool ppe_th;
 	u8 ppe16, ppe8;
-	u8 nss = min(sta->deflink.rx_nss, rtwdev->hal.tx_nss) - 1;
-	u8 ppe_thres_hdr = sta->deflink.he_cap.ppe_thres[0];
+	u8 nss = min(link_sta->rx_nss, rtwdev->hal.tx_nss) - 1;
+	u8 ppe_thres_hdr = link_sta->he_cap.ppe_thres[0];
 	u8 ru_bitmap;
 	u8 n, idx, sh;
 	u16 ppe;
 	int i;
 
 	ppe_th = FIELD_GET(IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT,
-			   sta->deflink.he_cap.he_cap_elem.phy_cap_info[6]);
+			   link_sta->he_cap.he_cap_elem.phy_cap_info[6]);
 	if (!ppe_th) {
 		u8 pad;
 
 		pad = FIELD_GET(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK,
-				sta->deflink.he_cap.he_cap_elem.phy_cap_info[9]);
+				link_sta->he_cap.he_cap_elem.phy_cap_info[9]);
 
 		for (i = 0; i < RTW89_PPE_BW_NUM; i++)
 			pads[i] = pad;
@@ -2815,7 +2816,7 @@ static void __get_sta_he_pkt_padding(struct rtw89_dev *rtwdev,
 		sh = n & 7;
 		n += IEEE80211_PPE_THRES_INFO_PPET_SIZE * 2;
 
-		ppe = le16_to_cpu(*((__le16 *)&sta->deflink.he_cap.ppe_thres[idx]));
+		ppe = le16_to_cpu(*((__le16 *)&link_sta->he_cap.ppe_thres[idx]));
 		ppe16 = (ppe >> sh) & IEEE80211_PPE_THRES_NSS_MASK;
 		sh += IEEE80211_PPE_THRES_INFO_PPET_SIZE;
 		ppe8 = (ppe >> sh) & IEEE80211_PPE_THRES_NSS_MASK;
@@ -2838,6 +2839,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
+	struct ieee80211_link_sta *link_sta;
 	struct sk_buff *skb;
 	u8 pads[RTW89_PPE_BW_NUM];
 	u8 mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
@@ -2845,8 +2847,20 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 	int ret;
 
 	memset(pads, 0, sizeof(pads));
-	if (sta && sta->deflink.he_cap.has_he)
-		__get_sta_he_pkt_padding(rtwdev, sta, pads);
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_CMC_TBL_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
+		return -ENOMEM;
+	}
+
+	rcu_read_lock();
+
+	if (rtwsta_link)
+		link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
+
+	if (rtwsta_link && link_sta->he_cap.has_he)
+		__get_sta_he_pkt_padding(rtwdev, link_sta, pads);
 
 	if (vif->p2p)
 		lowest_rate = RTW89_HW_RATE_OFDM6;
@@ -2855,11 +2869,6 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 	else
 		lowest_rate = RTW89_HW_RATE_OFDM6;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_CMC_TBL_LEN);
-	if (!skb) {
-		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
-		return -ENOMEM;
-	}
 	skb_put(skb, H2C_CMC_TBL_LEN);
 	SET_CTRL_INFO_MACID(skb->data, mac_id);
 	SET_CTRL_INFO_OPERATION(skb->data, 1);
@@ -2884,12 +2893,14 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 		SET_CMC_TBL_NOMINAL_PKT_PADDING80(skb->data, pads[RTW89_CHANNEL_WIDTH_80]);
 		SET_CMC_TBL_NOMINAL_PKT_PADDING160(skb->data, pads[RTW89_CHANNEL_WIDTH_160]);
 	}
-	if (sta)
+	if (rtwsta_link)
 		SET_CMC_TBL_BSR_QUEUE_SIZE_FORMAT(skb->data,
-						  sta->deflink.he_cap.has_he);
+						  link_sta->he_cap.has_he);
 	if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE)
 		SET_CMC_TBL_DATA_DCM(skb->data, 0);
 
+	rcu_read_unlock();
+
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
 			      chip->h2c_cctl_func_id, 0, 1,
@@ -2910,9 +2921,10 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 EXPORT_SYMBOL(rtw89_fw_h2c_assoc_cmac_tbl);
 
 static void __get_sta_eht_pkt_padding(struct rtw89_dev *rtwdev,
-				      struct ieee80211_sta *sta, u8 *pads)
+				      struct ieee80211_link_sta *link_sta,
+				      u8 *pads)
 {
-	u8 nss = min(sta->deflink.rx_nss, rtwdev->hal.tx_nss) - 1;
+	u8 nss = min(link_sta->rx_nss, rtwdev->hal.tx_nss) - 1;
 	u16 ppe_thres_hdr;
 	u8 ppe16, ppe8;
 	u8 n, idx, sh;
@@ -2921,12 +2933,12 @@ static void __get_sta_eht_pkt_padding(struct rtw89_dev *rtwdev,
 	u16 ppe;
 	int i;
 
-	ppe_th = !!u8_get_bits(sta->deflink.eht_cap.eht_cap_elem.phy_cap_info[5],
+	ppe_th = !!u8_get_bits(link_sta->eht_cap.eht_cap_elem.phy_cap_info[5],
 			       IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT);
 	if (!ppe_th) {
 		u8 pad;
 
-		pad = u8_get_bits(sta->deflink.eht_cap.eht_cap_elem.phy_cap_info[5],
+		pad = u8_get_bits(link_sta->eht_cap.eht_cap_elem.phy_cap_info[5],
 				  IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK);
 
 		for (i = 0; i < RTW89_PPE_BW_NUM; i++)
@@ -2935,7 +2947,7 @@ static void __get_sta_eht_pkt_padding(struct rtw89_dev *rtwdev,
 		return;
 	}
 
-	ppe_thres_hdr = get_unaligned_le16(sta->deflink.eht_cap.eht_ppe_thres);
+	ppe_thres_hdr = get_unaligned_le16(link_sta->eht_cap.eht_ppe_thres);
 	ru_bitmap = u16_get_bits(ppe_thres_hdr,
 				 IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK);
 	n = hweight8(ru_bitmap);
@@ -2952,7 +2964,7 @@ static void __get_sta_eht_pkt_padding(struct rtw89_dev *rtwdev,
 		sh = n & 7;
 		n += IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE * 2;
 
-		ppe = get_unaligned_le16(sta->deflink.eht_cap.eht_ppe_thres + idx);
+		ppe = get_unaligned_le16(link_sta->eht_cap.eht_ppe_thres + idx);
 		ppe16 = (ppe >> sh) & IEEE80211_PPE_THRES_NSS_MASK;
 		sh += IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE;
 		ppe8 = (ppe >> sh) & IEEE80211_PPE_THRES_NSS_MASK;
@@ -2976,6 +2988,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 	u8 mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
 	struct rtw89_h2c_cctlinfo_ud_g7 *h2c;
 	struct ieee80211_bss_conf *bss_conf;
+	struct ieee80211_link_sta *link_sta;
 	u8 pads[RTW89_PPE_BW_NUM];
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
@@ -2983,12 +2996,6 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 	int ret;
 
 	memset(pads, 0, sizeof(pads));
-	if (sta) {
-		if (sta->deflink.eht_cap.has_eht)
-			__get_sta_eht_pkt_padding(rtwdev, sta, pads);
-		else if (sta->deflink.he_cap.has_he)
-			__get_sta_he_pkt_padding(rtwdev, sta, pads);
-	}
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
@@ -3000,6 +3007,15 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 
 	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
 
+	if (rtwsta_link) {
+		link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
+
+		if (link_sta->eht_cap.has_eht)
+			__get_sta_eht_pkt_padding(rtwdev, link_sta, pads);
+		else if (link_sta->he_cap.has_he)
+			__get_sta_he_pkt_padding(rtwdev, link_sta, pads);
+	}
+
 	if (vif->p2p)
 		lowest_rate = RTW89_HW_RATE_OFDM6;
 	else if (chan->band_type == RTW89_BAND_2G)
@@ -3063,8 +3079,8 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				   CCTLINFO_G7_W6_ULDL);
 	h2c->m6 = cpu_to_le32(CCTLINFO_G7_W6_ULDL);
 
-	if (sta) {
-		h2c->w8 = le32_encode_bits(sta->deflink.he_cap.has_he,
+	if (rtwsta_link) {
+		h2c->w8 = le32_encode_bits(link_sta->he_cap.has_he,
 					   CCTLINFO_G7_W8_BSR_QUEUE_SIZE_FORMAT);
 		h2c->m8 = cpu_to_le32(CCTLINFO_G7_W8_BSR_QUEUE_SIZE_FORMAT);
 	}
@@ -3453,23 +3469,27 @@ static enum rtw89_fw_sta_type
 rtw89_fw_get_sta_type(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		      struct rtw89_sta_link *rtwsta_link)
 {
-	struct ieee80211_sta *sta = rtwsta_to_sta_safe(rtwsta_link);
 	struct ieee80211_bss_conf *bss_conf;
+	struct ieee80211_link_sta *link_sta;
 	enum rtw89_fw_sta_type type;
 
-	if (!sta)
+	rcu_read_lock();
+
+	if (!rtwsta_link)
 		goto by_vif;
 
-	if (sta->deflink.eht_cap.has_eht)
-		return RTW89_FW_BE_STA;
-	else if (sta->deflink.he_cap.has_he)
-		return RTW89_FW_AX_STA;
+	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
+
+	if (link_sta->eht_cap.has_eht)
+		type = RTW89_FW_BE_STA;
+	else if (link_sta->he_cap.has_he)
+		type = RTW89_FW_AX_STA;
 	else
-		return RTW89_FW_N_AC_STA;
+		type = RTW89_FW_N_AC_STA;
 
-by_vif:
-	rcu_read_lock();
+	goto out;
 
+by_vif:
 	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
 
 	if (bss_conf->eht_support)
@@ -3479,6 +3499,7 @@ rtw89_fw_get_sta_type(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_li
 	else
 		type = RTW89_FW_N_AC_STA;
 
+out:
 	rcu_read_unlock();
 
 	return type;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index d5097d3a3385..7ab2aac3c3d2 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5993,11 +5993,13 @@ static int rtw89_mac_set_csi_para_reg_ax(struct rtw89_dev *rtwdev,
 					 struct ieee80211_sta *sta)
 {
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	u8 mac_idx = rtwvif_link->mac_idx;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	u8 nc = 1, nr = 3, ng = 0, cb = 1, cs = 1, ldpc_en = 1, stbc_en = 1;
+	struct ieee80211_link_sta *link_sta;
+	u8 mac_idx = rtwvif_link->mac_idx;
 	u8 port_sel = rtwvif_link->port;
 	u8 sound_dim = 3, t;
-	u8 *phy_cap = sta->deflink.he_cap.he_cap_elem.phy_cap_info;
+	u8 *phy_cap;
 	u32 reg;
 	u16 val;
 	int ret;
@@ -6006,6 +6008,11 @@ static int rtw89_mac_set_csi_para_reg_ax(struct rtw89_dev *rtwdev,
 	if (ret)
 		return ret;
 
+	rcu_read_lock();
+
+	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
+	phy_cap = link_sta->he_cap.he_cap_elem.phy_cap_info;
+
 	if ((phy_cap[3] & IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER) ||
 	    (phy_cap[4] & IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER)) {
 		ldpc_en &= !!(phy_cap[1] & IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD);
@@ -6014,17 +6021,19 @@ static int rtw89_mac_set_csi_para_reg_ax(struct rtw89_dev *rtwdev,
 			      phy_cap[5]);
 		sound_dim = min(sound_dim, t);
 	}
-	if ((sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE) ||
-	    (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE)) {
-		ldpc_en &= !!(sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
-		stbc_en &= !!(sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_MASK);
+	if ((link_sta->vht_cap.cap & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE) ||
+	    (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE)) {
+		ldpc_en &= !!(link_sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
+		stbc_en &= !!(link_sta->vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_MASK);
 		t = FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
-			      sta->deflink.vht_cap.cap);
+			      link_sta->vht_cap.cap);
 		sound_dim = min(sound_dim, t);
 	}
 	nc = min(nc, sound_dim);
 	nr = min(nr, sound_dim);
 
+	rcu_read_unlock();
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
 	rtw89_write32_set(rtwdev, reg, B_AX_BFMEE_BFPARAM_SEL);
 
@@ -6051,30 +6060,39 @@ static int rtw89_mac_csi_rrsc_ax(struct rtw89_dev *rtwdev,
 				 struct ieee80211_sta *sta)
 {
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	u32 rrsc = BIT(RTW89_MAC_BF_RRSC_6M) | BIT(RTW89_MAC_BF_RRSC_24M);
-	u32 reg;
+	struct ieee80211_link_sta *link_sta;
 	u8 mac_idx = rtwvif_link->mac_idx;
+	u32 reg;
 	int ret;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
 	if (ret)
 		return ret;
 
-	if (sta->deflink.he_cap.has_he) {
+	rcu_read_lock();
+
+	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
+
+	if (link_sta->he_cap.has_he) {
 		rrsc |= (BIT(RTW89_MAC_BF_RRSC_HE_MSC0) |
 			 BIT(RTW89_MAC_BF_RRSC_HE_MSC3) |
 			 BIT(RTW89_MAC_BF_RRSC_HE_MSC5));
 	}
-	if (sta->deflink.vht_cap.vht_supported) {
+	if (link_sta->vht_cap.vht_supported) {
 		rrsc |= (BIT(RTW89_MAC_BF_RRSC_VHT_MSC0) |
 			 BIT(RTW89_MAC_BF_RRSC_VHT_MSC3) |
 			 BIT(RTW89_MAC_BF_RRSC_VHT_MSC5));
 	}
-	if (sta->deflink.ht_cap.ht_supported) {
+	if (link_sta->ht_cap.ht_supported) {
 		rrsc |= (BIT(RTW89_MAC_BF_RRSC_HT_MSC0) |
 			 BIT(RTW89_MAC_BF_RRSC_HT_MSC3) |
 			 BIT(RTW89_MAC_BF_RRSC_HT_MSC5));
 	}
+
+	rcu_read_unlock();
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
 	rtw89_write32_set(rtwdev, reg, B_AX_BFMEE_BFPARAM_SEL);
 	rtw89_write32_clr(rtwdev, reg, B_AX_BFMEE_CSI_FORCE_RETE_EN);
@@ -6090,8 +6108,18 @@ static void rtw89_mac_bf_assoc_ax(struct rtw89_dev *rtwdev,
 				  struct ieee80211_sta *sta)
 {
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct ieee80211_link_sta *link_sta;
+	bool has_beamformer_cap;
+
+	rcu_read_lock();
+
+	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
+	has_beamformer_cap = rtw89_sta_has_beamformer_cap(link_sta);
 
-	if (rtw89_sta_has_beamformer_cap(sta)) {
+	rcu_read_unlock();
+
+	if (has_beamformer_cap) {
 		rtw89_debug(rtwdev, RTW89_DBG_BF,
 			    "initialize bfee for new association\n");
 		rtw89_mac_init_bfee_ax(rtwdev, rtwvif_link->mac_idx);
@@ -6145,16 +6173,23 @@ struct rtw89_mac_bf_monitor_iter_data {
 static
 void rtw89_mac_bf_monitor_calc_iter(void *data, struct ieee80211_sta *sta)
 {
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_mac_bf_monitor_iter_data *iter_data =
 				(struct rtw89_mac_bf_monitor_iter_data *)data;
 	struct ieee80211_sta *down_sta = iter_data->down_sta;
+	struct ieee80211_link_sta *link_sta;
 	int *count = &iter_data->count;
 
 	if (down_sta == sta)
 		return;
 
-	if (rtw89_sta_has_beamformer_cap(sta))
+	rcu_read_lock();
+
+	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, false);
+	if (rtw89_sta_has_beamformer_cap(link_sta))
 		(*count)++;
+
+	rcu_read_unlock();
 }
 
 void rtw89_mac_bf_monitor_calc(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index bc3215939f37..184a014a56bf 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2095,7 +2095,9 @@ static int rtw89_mac_set_csi_para_reg_be(struct rtw89_dev *rtwdev,
 					 struct ieee80211_sta *sta)
 {
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	u8 nc = 1, nr = 3, ng = 0, cb = 1, cs = 1, ldpc_en = 1, stbc_en = 1;
+	struct ieee80211_link_sta *link_sta;
 	u8 mac_idx = rtwvif_link->mac_idx;
 	u8 port_sel = rtwvif_link->port;
 	u8 sound_dim = 3, t;
@@ -2108,7 +2110,10 @@ static int rtw89_mac_set_csi_para_reg_be(struct rtw89_dev *rtwdev,
 	if (ret)
 		return ret;
 
-	phy_cap = sta->deflink.he_cap.he_cap_elem.phy_cap_info;
+	rcu_read_lock();
+
+	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
+	phy_cap = link_sta->he_cap.he_cap_elem.phy_cap_info;
 
 	if ((phy_cap[3] & IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER) ||
 	    (phy_cap[4] & IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER)) {
@@ -2119,11 +2124,11 @@ static int rtw89_mac_set_csi_para_reg_be(struct rtw89_dev *rtwdev,
 		sound_dim = min(sound_dim, t);
 	}
 
-	if ((sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE) ||
-	    (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE)) {
-		ldpc_en &= !!(sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
-		stbc_en &= !!(sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_MASK);
-		t = u32_get_bits(sta->deflink.vht_cap.cap,
+	if ((link_sta->vht_cap.cap & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE) ||
+	    (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE)) {
+		ldpc_en &= !!(link_sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
+		stbc_en &= !!(link_sta->vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_MASK);
+		t = u32_get_bits(link_sta->vht_cap.cap,
 				 IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK);
 		sound_dim = min(sound_dim, t);
 	}
@@ -2131,6 +2136,8 @@ static int rtw89_mac_set_csi_para_reg_be(struct rtw89_dev *rtwdev,
 	nc = min(nc, sound_dim);
 	nr = min(nr, sound_dim);
 
+	rcu_read_unlock();
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
 	rtw89_write32_set(rtwdev, reg, B_BE_BFMEE_BFPARAM_SEL);
 
@@ -2159,7 +2166,9 @@ static int rtw89_mac_csi_rrsc_be(struct rtw89_dev *rtwdev,
 				 struct ieee80211_sta *sta)
 {
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	u32 rrsc = BIT(RTW89_MAC_BF_RRSC_6M) | BIT(RTW89_MAC_BF_RRSC_24M);
+	struct ieee80211_link_sta *link_sta;
 	u8 mac_idx = rtwvif_link->mac_idx;
 	int ret;
 	u32 reg;
@@ -2168,22 +2177,28 @@ static int rtw89_mac_csi_rrsc_be(struct rtw89_dev *rtwdev,
 	if (ret)
 		return ret;
 
-	if (sta->deflink.he_cap.has_he) {
+	rcu_read_lock();
+
+	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
+
+	if (link_sta->he_cap.has_he) {
 		rrsc |= (BIT(RTW89_MAC_BF_RRSC_HE_MSC0) |
 			 BIT(RTW89_MAC_BF_RRSC_HE_MSC3) |
 			 BIT(RTW89_MAC_BF_RRSC_HE_MSC5));
 	}
-	if (sta->deflink.vht_cap.vht_supported) {
+	if (link_sta->vht_cap.vht_supported) {
 		rrsc |= (BIT(RTW89_MAC_BF_RRSC_VHT_MSC0) |
 			 BIT(RTW89_MAC_BF_RRSC_VHT_MSC3) |
 			 BIT(RTW89_MAC_BF_RRSC_VHT_MSC5));
 	}
-	if (sta->deflink.ht_cap.ht_supported) {
+	if (link_sta->ht_cap.ht_supported) {
 		rrsc |= (BIT(RTW89_MAC_BF_RRSC_HT_MSC0) |
 			 BIT(RTW89_MAC_BF_RRSC_HT_MSC3) |
 			 BIT(RTW89_MAC_BF_RRSC_HT_MSC5));
 	}
 
+	rcu_read_unlock();
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
 	rtw89_write32_set(rtwdev, reg, B_BE_BFMEE_BFPARAM_SEL);
 	rtw89_write32_clr(rtwdev, reg, B_BE_BFMEE_CSI_FORCE_RETE_EN);
@@ -2199,8 +2214,18 @@ static void rtw89_mac_bf_assoc_be(struct rtw89_dev *rtwdev,
 				  struct ieee80211_sta *sta)
 {
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct ieee80211_link_sta *link_sta;
+	bool has_beamformer_cap;
+
+	rcu_read_lock();
+
+	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
+	has_beamformer_cap = rtw89_sta_has_beamformer_cap(link_sta);
+
+	rcu_read_unlock();
 
-	if (rtw89_sta_has_beamformer_cap(sta)) {
+	if (has_beamformer_cap) {
 		rtw89_debug(rtwdev, RTW89_DBG_BF,
 			    "initialize bfee for new association\n");
 		rtw89_mac_init_bfee_be(rtwdev, rtwvif_link->mac_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index dd24d253947e..a46f182633e9 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -75,12 +75,12 @@ static u64 get_mcs_ra_mask(u16 mcs_map, u8 highest_mcs, u8 gap)
 	return ra_mask;
 }
 
-static u64 get_he_ra_mask(struct ieee80211_sta *sta)
+static u64 get_he_ra_mask(struct ieee80211_link_sta *link_sta)
 {
-	struct ieee80211_sta_he_cap cap = sta->deflink.he_cap;
+	struct ieee80211_sta_he_cap cap = link_sta->he_cap;
 	u16 mcs_map;
 
-	switch (sta->deflink.bandwidth) {
+	switch (link_sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
 		if (cap.he_cap_elem.phy_cap_info[0] &
 		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
@@ -118,14 +118,14 @@ static u64 get_eht_mcs_ra_mask(u8 *max_nss, u8 start_mcs, u8 n_nss)
 	return mask;
 }
 
-static u64 get_eht_ra_mask(struct ieee80211_sta *sta)
+static u64 get_eht_ra_mask(struct ieee80211_link_sta *link_sta)
 {
-	struct ieee80211_sta_eht_cap *eht_cap = &sta->deflink.eht_cap;
+	struct ieee80211_sta_eht_cap *eht_cap = &link_sta->eht_cap;
 	struct ieee80211_eht_mcs_nss_supp_20mhz_only *mcs_nss_20mhz;
 	struct ieee80211_eht_mcs_nss_supp_bw *mcs_nss;
-	u8 *he_phy_cap = sta->deflink.he_cap.he_cap_elem.phy_cap_info;
+	u8 *he_phy_cap = link_sta->he_cap.he_cap_elem.phy_cap_info;
 
-	switch (sta->deflink.bandwidth) {
+	switch (link_sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_320:
 		mcs_nss = &eht_cap->eht_mcs_nss_supp.bw._320;
 		/* MCS 9, 11, 13 */
@@ -197,9 +197,9 @@ static u64 rtw89_phy_ra_mask_recover(u64 ra_mask, u64 ra_mask_bak)
 
 static u64 rtw89_phy_ra_mask_cfg(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta_link *rtwsta_link,
+				 struct ieee80211_link_sta *link_sta,
 				 const struct rtw89_chan *chan)
 {
-	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
 	struct cfg80211_bitrate_mask *mask = &rtwsta_link->mask;
 	enum nl80211_band band;
 	u64 cfg_mask;
@@ -228,17 +228,17 @@ static u64 rtw89_phy_ra_mask_cfg(struct rtw89_dev *rtwdev,
 		return -1;
 	}
 
-	if (sta->deflink.he_cap.has_he) {
+	if (link_sta->he_cap.has_he) {
 		cfg_mask |= u64_encode_bits(mask->control[band].he_mcs[0],
 					    RA_MASK_HE_1SS_RATES);
 		cfg_mask |= u64_encode_bits(mask->control[band].he_mcs[1],
 					    RA_MASK_HE_2SS_RATES);
-	} else if (sta->deflink.vht_cap.vht_supported) {
+	} else if (link_sta->vht_cap.vht_supported) {
 		cfg_mask |= u64_encode_bits(mask->control[band].vht_mcs[0],
 					    RA_MASK_VHT_1SS_RATES);
 		cfg_mask |= u64_encode_bits(mask->control[band].vht_mcs[1],
 					    RA_MASK_VHT_2SS_RATES);
-	} else if (sta->deflink.ht_cap.ht_supported) {
+	} else if (link_sta->ht_cap.ht_supported) {
 		cfg_mask |= u64_encode_bits(mask->control[band].ht_mcs[0],
 					    RA_MASK_HT_1SS_RATES);
 		cfg_mask |= u64_encode_bits(mask->control[band].ht_mcs[1],
@@ -296,15 +296,15 @@ static void rtw89_phy_ra_gi_ltf(struct rtw89_dev *rtwdev,
 }
 
 static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
-				    struct ieee80211_sta *sta, bool csi)
+				    struct rtw89_vif_link *rtwvif_link,
+				    struct rtw89_sta_link *rtwsta_link,
+				    struct ieee80211_link_sta *link_sta,
+				    bool p2p, bool csi)
 {
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
-	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif_link->rate_pattern;
 	struct rtw89_ra_info *ra = &rtwsta_link->ra;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwsta_link->rtwvif_link);
 	const u64 *high_rate_masks = rtw89_ra_mask_ht_rates;
 	u8 rssi = ewma_rssi_read(&rtwsta_link->avg_rssi);
 	u64 ra_mask = 0;
@@ -321,65 +321,65 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 
 	memset(ra, 0, sizeof(*ra));
 	/* Set the ra mask from sta's capability */
-	if (sta->deflink.eht_cap.has_eht) {
+	if (link_sta->eht_cap.has_eht) {
 		mode |= RTW89_RA_MODE_EHT;
-		ra_mask |= get_eht_ra_mask(sta);
+		ra_mask |= get_eht_ra_mask(link_sta);
 		high_rate_masks = rtw89_ra_mask_eht_rates;
-	} else if (sta->deflink.he_cap.has_he) {
+	} else if (link_sta->he_cap.has_he) {
 		mode |= RTW89_RA_MODE_HE;
 		csi_mode = RTW89_RA_RPT_MODE_HE;
-		ra_mask |= get_he_ra_mask(sta);
+		ra_mask |= get_he_ra_mask(link_sta);
 		high_rate_masks = rtw89_ra_mask_he_rates;
-		if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[2] &
+		if (link_sta->he_cap.he_cap_elem.phy_cap_info[2] &
 		    IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ)
 			stbc_en = 1;
-		if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[1] &
+		if (link_sta->he_cap.he_cap_elem.phy_cap_info[1] &
 		    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD)
 			ldpc_en = 1;
 		rtw89_phy_ra_gi_ltf(rtwdev, rtwsta_link, chan, &fix_giltf_en, &fix_giltf);
-	} else if (sta->deflink.vht_cap.vht_supported) {
-		u16 mcs_map = le16_to_cpu(sta->deflink.vht_cap.vht_mcs.rx_mcs_map);
+	} else if (link_sta->vht_cap.vht_supported) {
+		u16 mcs_map = le16_to_cpu(link_sta->vht_cap.vht_mcs.rx_mcs_map);
 
 		mode |= RTW89_RA_MODE_VHT;
 		csi_mode = RTW89_RA_RPT_MODE_VHT;
 		/* MCS9 (non-20MHz), MCS8, MCS7 */
-		if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_20)
+		if (link_sta->bandwidth == IEEE80211_STA_RX_BW_20)
 			ra_mask |= get_mcs_ra_mask(mcs_map, 8, 1);
 		else
 			ra_mask |= get_mcs_ra_mask(mcs_map, 9, 1);
 		high_rate_masks = rtw89_ra_mask_vht_rates;
-		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_MASK)
+		if (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_MASK)
 			stbc_en = 1;
-		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC)
+		if (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC)
 			ldpc_en = 1;
-	} else if (sta->deflink.ht_cap.ht_supported) {
+	} else if (link_sta->ht_cap.ht_supported) {
 		mode |= RTW89_RA_MODE_HT;
 		csi_mode = RTW89_RA_RPT_MODE_HT;
-		ra_mask |= ((u64)sta->deflink.ht_cap.mcs.rx_mask[3] << 48) |
-			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[2] << 36) |
-			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[1] << 24) |
-			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[0] << 12);
+		ra_mask |= ((u64)link_sta->ht_cap.mcs.rx_mask[3] << 48) |
+			   ((u64)link_sta->ht_cap.mcs.rx_mask[2] << 36) |
+			   ((u64)link_sta->ht_cap.mcs.rx_mask[1] << 24) |
+			   ((u64)link_sta->ht_cap.mcs.rx_mask[0] << 12);
 		high_rate_masks = rtw89_ra_mask_ht_rates;
-		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
+		if (link_sta->ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
 			stbc_en = 1;
-		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING)
+		if (link_sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING)
 			ldpc_en = 1;
 	}
 
 	switch (chan->band_type) {
 	case RTW89_BAND_2G:
-		ra_mask |= sta->deflink.supp_rates[NL80211_BAND_2GHZ];
-		if (sta->deflink.supp_rates[NL80211_BAND_2GHZ] & 0xf)
+		ra_mask |= link_sta->supp_rates[NL80211_BAND_2GHZ];
+		if (link_sta->supp_rates[NL80211_BAND_2GHZ] & 0xf)
 			mode |= RTW89_RA_MODE_CCK;
-		if (sta->deflink.supp_rates[NL80211_BAND_2GHZ] & 0xff0)
+		if (link_sta->supp_rates[NL80211_BAND_2GHZ] & 0xff0)
 			mode |= RTW89_RA_MODE_OFDM;
 		break;
 	case RTW89_BAND_5G:
-		ra_mask |= (u64)sta->deflink.supp_rates[NL80211_BAND_5GHZ] << 4;
+		ra_mask |= (u64)link_sta->supp_rates[NL80211_BAND_5GHZ] << 4;
 		mode |= RTW89_RA_MODE_OFDM;
 		break;
 	case RTW89_BAND_6G:
-		ra_mask |= (u64)sta->deflink.supp_rates[NL80211_BAND_6GHZ] << 4;
+		ra_mask |= (u64)link_sta->supp_rates[NL80211_BAND_6GHZ] << 4;
 		mode |= RTW89_RA_MODE_OFDM;
 		break;
 	default:
@@ -406,37 +406,37 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 		ra_mask &= rtw89_phy_ra_mask_rssi(rtwdev, rssi, 0);
 
 	ra_mask = rtw89_phy_ra_mask_recover(ra_mask, ra_mask_bak);
-	ra_mask &= rtw89_phy_ra_mask_cfg(rtwdev, rtwsta_link, chan);
+	ra_mask &= rtw89_phy_ra_mask_cfg(rtwdev, rtwsta_link, link_sta, chan);
 
-	switch (sta->deflink.bandwidth) {
+	switch (link_sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
 		bw_mode = RTW89_CHANNEL_WIDTH_160;
-		sgi = sta->deflink.vht_cap.vht_supported &&
-		      (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_160);
+		sgi = link_sta->vht_cap.vht_supported &&
+		      (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_160);
 		break;
 	case IEEE80211_STA_RX_BW_80:
 		bw_mode = RTW89_CHANNEL_WIDTH_80;
-		sgi = sta->deflink.vht_cap.vht_supported &&
-		      (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80);
+		sgi = link_sta->vht_cap.vht_supported &&
+		      (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80);
 		break;
 	case IEEE80211_STA_RX_BW_40:
 		bw_mode = RTW89_CHANNEL_WIDTH_40;
-		sgi = sta->deflink.ht_cap.ht_supported &&
-		      (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_40);
+		sgi = link_sta->ht_cap.ht_supported &&
+		      (link_sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_40);
 		break;
 	default:
 		bw_mode = RTW89_CHANNEL_WIDTH_20;
-		sgi = sta->deflink.ht_cap.ht_supported &&
-		      (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_20);
+		sgi = link_sta->ht_cap.ht_supported &&
+		      (link_sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_20);
 		break;
 	}
 
-	if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[3] &
+	if (link_sta->he_cap.he_cap_elem.phy_cap_info[3] &
 	    IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_16_QAM)
 		ra->dcm_cap = 1;
 
-	if (rate_pattern->enable && !vif->p2p) {
-		ra_mask = rtw89_phy_ra_mask_cfg(rtwdev, rtwsta_link, chan);
+	if (rate_pattern->enable && !p2p) {
+		ra_mask = rtw89_phy_ra_mask_cfg(rtwdev, rtwsta_link, link_sta, chan);
 		ra_mask &= rate_pattern->ra_mask;
 		mode = rate_pattern->ra_mode;
 	}
@@ -447,7 +447,7 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	ra->macid = rtwsta_link->mac_id;
 	ra->stbc_cap = stbc_en;
 	ra->ldpc_cap = ldpc_en;
-	ra->ss_num = min(sta->deflink.rx_nss, rtwdev->hal.tx_nss) - 1;
+	ra->ss_num = min(link_sta->rx_nss, rtwdev->hal.tx_nss) - 1;
 	ra->en_sgi = sgi;
 	ra->ra_mask = ra_mask;
 	ra->fix_giltf_en = fix_giltf_en;
@@ -470,9 +470,18 @@ void rtw89_phy_ra_update_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta
 			     u32 changed)
 {
 	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct rtw89_ra_info *ra = &rtwsta_link->ra;
+	struct ieee80211_link_sta *link_sta;
 
-	rtw89_phy_ra_sta_update(rtwdev, sta, false);
+	rcu_read_lock();
+
+	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, false);
+	rtw89_phy_ra_sta_update(rtwdev, rtwvif_link, rtwsta_link,
+				link_sta, vif->p2p, false);
+
+	rcu_read_unlock();
 
 	if (changed & IEEE80211_RC_SUPP_RATES_CHANGED)
 		ra->upd_mask = 1;
@@ -631,11 +640,22 @@ void rtw89_phy_ra_update(struct rtw89_dev *rtwdev)
 void rtw89_phy_ra_assoc(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta)
 {
 	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct rtw89_ra_info *ra = &rtwsta_link->ra;
 	u8 rssi = ewma_rssi_read(&rtwsta_link->avg_rssi) >> RSSI_FACTOR;
-	bool csi = rtw89_sta_has_beamformer_cap(sta);
+	struct ieee80211_link_sta *link_sta;
+	bool csi;
+
+	rcu_read_lock();
 
-	rtw89_phy_ra_sta_update(rtwdev, sta, csi);
+	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
+	csi = rtw89_sta_has_beamformer_cap(link_sta);
+
+	rtw89_phy_ra_sta_update(rtwdev, rtwvif_link, rtwsta_link,
+				link_sta, vif->p2p, csi);
+
+	rcu_read_unlock();
 
 	if (rssi > 40)
 		ra->init_rate_lv = 1;
@@ -2554,11 +2574,11 @@ struct rtw89_phy_iter_ra_data {
 	struct sk_buff *c2h;
 };
 
-static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
+static void __rtw89_phy_c2h_ra_rpt_iter(struct rtw89_sta_link *rtwsta_link,
+					struct ieee80211_link_sta *link_sta,
+					struct rtw89_phy_iter_ra_data *ra_data)
 {
-	struct rtw89_phy_iter_ra_data *ra_data = (struct rtw89_phy_iter_ra_data *)data;
 	struct rtw89_dev *rtwdev = ra_data->rtwdev;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	const struct rtw89_c2h_ra_rpt *c2h =
 		(const struct rtw89_c2h_ra_rpt *)ra_data->c2h->data;
 	struct rtw89_ra_report *ra_report = &rtwsta_link->ra_report;
@@ -2662,8 +2682,22 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 			     u16_encode_bits(mode, RTW89_HW_RATE_MASK_MOD) |
 			     u16_encode_bits(rate, RTW89_HW_RATE_MASK_VAL);
 	ra_report->might_fallback_legacy = mcs <= 2;
-	sta->deflink.agg.max_rc_amsdu_len = get_max_amsdu_len(rtwdev, ra_report);
-	rtwsta_link->max_agg_wait = sta->deflink.agg.max_rc_amsdu_len / 1500 - 1;
+	link_sta->agg.max_rc_amsdu_len = get_max_amsdu_len(rtwdev, ra_report);
+	rtwsta_link->max_agg_wait = link_sta->agg.max_rc_amsdu_len / 1500 - 1;
+}
+
+static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw89_phy_iter_ra_data *ra_data = (struct rtw89_phy_iter_ra_data *)data;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct ieee80211_link_sta *link_sta;
+
+	rcu_read_lock();
+
+	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, false);
+	__rtw89_phy_c2h_ra_rpt_iter(rtwsta_link, link_sta, ra_data);
+
+	rcu_read_unlock();
 }
 
 static void
-- 
2.25.1


