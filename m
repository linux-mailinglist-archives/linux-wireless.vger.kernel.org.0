Return-Path: <linux-wireless+bounces-12878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D15ED979ACC
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 07:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85DC1C22651
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 05:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E7A27452;
	Mon, 16 Sep 2024 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="oyLphKqy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270C22D032
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 05:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464783; cv=none; b=udcnx8iTAf4aHtZZ45DjS/60sj2r4iTyE7PxeIo88b+8rIjIxAar9jecdKlOgGeteASlNG5rJEsXDK6NCg7a5n6UwQ92AelQjVT8Yevgg/cf0O0rJH0C61lTj5fYfSmvn8VkyYeDIoBqAsQAjWd6RfHdnfZbHw8URaBIP1Cqh04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464783; c=relaxed/simple;
	bh=hs8AmgnYnJoRe1LtyidfFALbN4HvTtriZSNnm+Yxhpw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWNMxged/GLGXuFD1T6IG6TVtGKQ3TQRMIj5nfzGnJ9nknZwQ8uSVHJ+BInzAPOmdI9mIeMLiYwr3f3mj21gbICiIFQupnfwSIfRm83YHLO7bTBZCFD58paZlITk6Kies6wsfdCREQu8Fhz273xJew/EJhlMHtiwLSGbTZv918c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=oyLphKqy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48G5WvRQ22631700, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726464777; bh=hs8AmgnYnJoRe1LtyidfFALbN4HvTtriZSNnm+Yxhpw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=oyLphKqyXych2yAkScLvrp/9JXPg/tTN5Yr8oBW7HKC0r5xZBpClKTfywSlkKp1XJ
	 MWSmwdOsgCdbF2dVL9I7y1zWZdfQlxWybXmQQSRMW49Y6IYJRULy9Y9pYr6jFXUejE
	 EPwPNki8cpiyaqCTzXRg9L77N1Qxomf+YZ6xuNhAzcdPVmrBuNWON9xpx8udEYl4dZ
	 IFcx4Y/RRXeRVJLr+uctgmNvxClGzCH0IFoqzHF3WLUnTZ2+5aNHBl0trqxhVly8x1
	 M5OLO4njzyHOhT6XwQw6Fs6j9YrtGoNTGuUR0rFvrtZmjvV69KXPT3n0WpGMMYL9lf
	 jWAdB4237bCBQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48G5WvRQ22631700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 13:32:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 13:32:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Sep
 2024 13:32:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 3/7] wifi: rtw89: read bss_conf corresponding to the link
Date: Mon, 16 Sep 2024 13:31:54 +0800
Message-ID: <20240916053158.47350-4-pkshih@realtek.com>
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

Tweak code to not always access vif->bss_conf directly. Instead,
according to link_id, read target bss_conf from vif->link_conf[].

For now, rtwvif_link->link_id keeps 0. When driver starts to
support MLO, the link_id will be assigned.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c      | 13 ++-
 drivers/net/wireless/realtek/rtw89/chan.c     | 22 ++++-
 drivers/net/wireless/realtek/rtw89/coex.c     | 17 +++-
 drivers/net/wireless/realtek/rtw89/core.c     | 98 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/core.h     | 52 +++++++---
 drivers/net/wireless/realtek/rtw89/fw.c       | 96 ++++++++++++------
 drivers/net/wireless/realtek/rtw89/fw.h       |  4 +-
 drivers/net/wireless/realtek/rtw89/mac.c      | 66 ++++++++++---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 24 ++++-
 drivers/net/wireless/realtek/rtw89/phy.c      | 13 ++-
 drivers/net/wireless/realtek/rtw89/ps.c       | 24 +++--
 drivers/net/wireless/realtek/rtw89/ps.h       |  4 +-
 drivers/net/wireless/realtek/rtw89/regd.c     | 19 +++-
 drivers/net/wireless/realtek/rtw89/wow.c      | 12 ++-
 14 files changed, 355 insertions(+), 109 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 80deb0712b83..757f7633b079 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -655,17 +655,24 @@ int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
 				  struct rtw89_sta_link *rtwsta_link, u8 *cmd)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct rtw89_bssid_cam_entry *bssid_cam = rtw89_get_bssid_cam_of(rtwvif_link,
 									 rtwsta_link);
-	u8 bss_color = vif->bss_conf.he_bss_color.color;
+	struct ieee80211_bss_conf *bss_conf;
+	u8 bss_color;
 	u8 bss_mask;
 
-	if (vif->bss_conf.nontransmitted)
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, false);
+	bss_color = bss_conf->he_bss_color.color;
+
+	if (bss_conf->nontransmitted)
 		bss_mask = RTW89_BSSID_MATCH_5_BYTES;
 	else
 		bss_mask = RTW89_BSSID_MATCH_ALL;
 
+	rcu_read_unlock();
+
 	FWCMD_SET_ADDR_BSSID_IDX(cmd, bssid_cam->bssid_cam_idx);
 	FWCMD_SET_ADDR_BSSID_OFFSET(cmd, bssid_cam->offset);
 	FWCMD_SET_ADDR_BSSID_LEN(cmd, bssid_cam->len);
diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 2f14ac668716..2968c299203b 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -564,8 +564,9 @@ static void rtw89_mcc_fill_role_policy(struct rtw89_dev *rtwdev,
 static void rtw89_mcc_fill_role_limit(struct rtw89_dev *rtwdev,
 				      struct rtw89_mcc_role *mcc_role)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(mcc_role->rtwvif_link);
+	struct rtw89_vif_link *rtwvif_link = mcc_role->rtwvif_link;
 	struct ieee80211_p2p_noa_desc *noa_desc;
+	struct ieee80211_bss_conf *bss_conf;
 	u32 bcn_intvl_us = ieee80211_tu_to_usec(mcc_role->beacon_interval);
 	u32 max_toa_us, max_tob_us, max_dur_us;
 	u32 start_time, interval, duration;
@@ -576,13 +577,18 @@ static void rtw89_mcc_fill_role_limit(struct rtw89_dev *rtwdev,
 	if (!mcc_role->is_go && !mcc_role->is_gc)
 		return;
 
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+
 	/* find the first periodic NoA */
 	for (i = 0; i < RTW89_P2P_MAX_NOA_NUM; i++) {
-		noa_desc = &vif->bss_conf.p2p_noa_attr.desc[i];
+		noa_desc = &bss_conf->p2p_noa_attr.desc[i];
 		if (noa_desc->count == 255)
 			goto fill;
 	}
 
+	rcu_read_unlock();
 	return;
 
 fill:
@@ -590,6 +596,8 @@ static void rtw89_mcc_fill_role_limit(struct rtw89_dev *rtwdev,
 	interval = le32_to_cpu(noa_desc->interval);
 	duration = le32_to_cpu(noa_desc->duration);
 
+	rcu_read_unlock();
+
 	if (interval != bcn_intvl_us) {
 		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 			    "MCC role limit: mismatch interval: %d vs. %d\n",
@@ -635,12 +643,18 @@ static int rtw89_mcc_fill_role(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif_link *rtwvif_link,
 			       struct rtw89_mcc_role *role)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_bss_conf *bss_conf;
 	const struct rtw89_chan *chan;
 
 	memset(role, 0, sizeof(*role));
 	role->rtwvif_link = rtwvif_link;
-	role->beacon_interval = vif->bss_conf.beacon_int;
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	role->beacon_interval = bss_conf->beacon_int;
+
+	rcu_read_unlock();
 
 	if (!role->beacon_interval) {
 		rtw89_warn(rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 174e79b73352..591c24df1825 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -7488,6 +7488,7 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 						       rtwvif_link->chanctx_idx);
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
+	struct ieee80211_bss_conf *bss_conf;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
@@ -7495,6 +7496,10 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 	struct rtw89_btc_wl_link_info *wlinfo = NULL;
 	u8 mode = 0, rlink_id, link_mode_ori, pta_req_mac_ori, wa_type;
 
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, false);
+
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], state=%d\n", state);
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], role is STA=%d\n",
@@ -7506,7 +7511,7 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 		    state == BTC_ROLE_MSTS_STA_CONN_END);
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], bcn_period=%d dtim_period=%d\n",
-		    vif->bss_conf.beacon_int, vif->bss_conf.dtim_period);
+		    bss_conf->beacon_int, bss_conf->dtim_period);
 
 	if (rtwsta_link) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], STA mac_id=%d\n",
@@ -7527,8 +7532,10 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 		r.mode = mode;
 	}
 
-	if (rtwvif_link->wifi_role >= RTW89_WIFI_ROLE_MLME_MAX)
+	if (rtwvif_link->wifi_role >= RTW89_WIFI_ROLE_MLME_MAX) {
+		rcu_read_unlock();
 		return;
+	}
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], wifi_role=%d\n", rtwvif_link->wifi_role);
@@ -7538,8 +7545,8 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 	r.pid = rtwvif_link->port;
 	r.active = true;
 	r.connected = MLME_LINKED;
-	r.bcn_period = vif->bss_conf.beacon_int;
-	r.dtim_period = vif->bss_conf.dtim_period;
+	r.bcn_period = bss_conf->beacon_int;
+	r.dtim_period = bss_conf->dtim_period;
 	r.band = chan->band_type;
 	r.ch = chan->channel;
 	r.bw = chan->band_width;
@@ -7549,6 +7556,8 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 	r.chdef.chan = chan->primary_channel;
 	ether_addr_copy(r.mac_addr, rtwvif_link->mac_addr);
 
+	rcu_read_unlock();
+
 	if (rtwsta_link && vif->type == NL80211_IFTYPE_STATION)
 		r.mac_id = rtwsta_link->mac_id;
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 2b6a8fe0e53b..f1db598c6004 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -571,7 +571,10 @@ static u16 rtw89_core_get_mgmt_rate(struct rtw89_dev *rtwdev,
 	struct sk_buff *skb = tx_req->skb;
 	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = tx_info->control.vif;
+	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
+	struct ieee80211_bss_conf *bss_conf;
 	u16 lowest_rate;
+	u16 rate;
 
 	if (tx_info->flags & IEEE80211_TX_CTL_NO_CCK_RATE ||
 	    (vif && vif->p2p))
@@ -581,10 +584,23 @@ static u16 rtw89_core_get_mgmt_rate(struct rtw89_dev *rtwdev,
 	else
 		lowest_rate = RTW89_HW_RATE_OFDM6;
 
-	if (!vif || !vif->bss_conf.basic_rates || !tx_req->sta)
+	if (!rtwvif_link)
 		return lowest_rate;
 
-	return __ffs(vif->bss_conf.basic_rates) + lowest_rate;
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, false);
+	if (!bss_conf->basic_rates || !tx_req->sta) {
+		rate = lowest_rate;
+		goto out;
+	}
+
+	rate = __ffs(bss_conf->basic_rates) + lowest_rate;
+
+out:
+	rcu_read_unlock();
+
+	return rate;
 }
 
 static u8 rtw89_core_tx_get_mac_id(struct rtw89_dev *rtwdev,
@@ -1879,6 +1895,7 @@ struct rtw89_vif_rx_stats_iter_data {
 
 static void rtw89_stats_trigger_frame(struct rtw89_dev *rtwdev,
 				      struct ieee80211_vif *vif,
+				      struct ieee80211_bss_conf *bss_conf,
 				      struct sk_buff *skb)
 {
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
@@ -1886,7 +1903,7 @@ static void rtw89_stats_trigger_frame(struct rtw89_dev *rtwdev,
 	u8 *pos, *end, type, tf_bw;
 	u16 aid, tf_rua;
 
-	if (!ether_addr_equal(vif->bss_conf.bssid, tf->ta) ||
+	if (!ether_addr_equal(bss_conf->bssid, tf->ta) ||
 	    rtwvif_link->wifi_role != RTW89_WIFI_ROLE_STATION ||
 	    rtwvif_link->net_type == RTW89_NET_TYPE_NO_LINK)
 		return;
@@ -2010,6 +2027,7 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	struct sk_buff *skb = iter_data->skb;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct rtw89_rx_phy_ppdu *phy_ppdu = iter_data->phy_ppdu;
+	struct ieee80211_bss_conf *bss_conf;
 	const u8 *bssid = iter_data->bssid;
 
 	if (rtwdev->scanning &&
@@ -2017,16 +2035,19 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	     ieee80211_is_probe_resp(hdr->frame_control)))
 		rtw89_core_cancel_6ghz_probe_tx(rtwdev, skb);
 
-	if (!vif->bss_conf.bssid)
-		return;
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, false);
+	if (!bss_conf->bssid)
+		goto out;
 
 	if (ieee80211_is_trigger(hdr->frame_control)) {
-		rtw89_stats_trigger_frame(rtwdev, vif, skb);
-		return;
+		rtw89_stats_trigger_frame(rtwdev, vif, bss_conf, skb);
+		goto out;
 	}
 
-	if (!ether_addr_equal(vif->bss_conf.bssid, bssid))
-		return;
+	if (!ether_addr_equal(bss_conf->bssid, bssid))
+		goto out;
 
 	if (ieee80211_is_beacon(hdr->frame_control)) {
 		if (vif->type == NL80211_IFTYPE_STATION &&
@@ -2037,13 +2058,16 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 		pkt_stat->beacon_nr++;
 	}
 
-	if (!ether_addr_equal(vif->addr, hdr->addr1))
-		return;
+	if (!ether_addr_equal(bss_conf->addr, hdr->addr1))
+		goto out;
 
 	if (desc_info->data_rate < RTW89_HW_RATE_NR)
 		pkt_stat->rx_rate_cnt[desc_info->data_rate]++;
 
 	rtw89_traffic_stats_accu(rtwdev, &rtwvif_link->stats, skb, false);
+
+out:
+	rcu_read_unlock();
 }
 
 static void rtw89_core_rx_stats(struct rtw89_dev *rtwdev,
@@ -3008,7 +3032,7 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 		return 0;
 
 	rcu_read_lock();
-	sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
+	sta = ieee80211_find_sta(vif, vif->cfg.ap_addr);
 	if (!sta) {
 		ret = -EINVAL;
 		goto out;
@@ -3241,14 +3265,16 @@ static void rtw89_core_rfk_track(struct rtw89_dev *rtwdev)
 	rtw89_chip_rfk_track(rtwdev);
 }
 
-void rtw89_core_update_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
+void rtw89_core_update_p2p_ps(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link,
+			      struct ieee80211_bss_conf *bss_conf)
 {
 	enum rtw89_entity_mode mode = rtw89_get_entity_mode(rtwdev);
 
 	if (mode == RTW89_ENTITY_MODE_MCC)
 		rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_P2P_PS_CHANGE);
 	else
-		rtw89_process_p2p_ps(rtwdev, vif);
+		rtw89_process_p2p_ps(rtwdev, rtwvif_link, bss_conf);
 }
 
 void rtw89_traffic_stats_init(struct rtw89_dev *rtwdev,
@@ -3410,6 +3436,7 @@ int rtw89_core_release_sta_ba_entry(struct rtw89_dev *rtwdev,
 void rtw89_vif_type_mapping(struct ieee80211_vif *vif, bool assoc)
 {
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	const struct ieee80211_bss_conf *bss_conf;
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_STATION:
@@ -3445,7 +3472,11 @@ void rtw89_vif_type_mapping(struct ieee80211_vif *vif, bool assoc)
 	case NL80211_IFTYPE_STATION:
 		if (assoc) {
 			rtwvif_link->net_type = RTW89_NET_TYPE_INFRA;
-			rtwvif_link->trigger = vif->bss_conf.he_support;
+
+			rcu_read_lock();
+			bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, false);
+			rtwvif_link->trigger = bss_conf->he_support;
+			rcu_read_unlock();
 		} else {
 			rtwvif_link->net_type = RTW89_NET_TYPE_NO_LINK;
 			rtwvif_link->trigger = false;
@@ -3656,12 +3687,17 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 	rtw89_mac_bf_monitor_calc(rtwdev, sta, false);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
-		struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+		struct ieee80211_bss_conf *bss_conf;
+
+		rcu_read_lock();
 
+		bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
 		if (bss_conf->he_support &&
 		    !(bss_conf->he_oper.params & IEEE80211_HE_OPERATION_ER_SU_DISABLE))
 			rtwsta_link->er_cap = true;
 
+		rcu_read_unlock();
+
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, rtwsta_link,
 					 BTC_ROLE_MSTS_STA_CONN_END);
 		rtw89_core_get_no_ul_ofdma_htc(rtwdev, &rtwsta_link->htc_template, chan);
@@ -4480,11 +4516,18 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_vif_link *rtwvif_link =
 		vif ? (struct rtw89_vif_link *)vif->drv_priv : NULL;
+	struct ieee80211_bss_conf *bss_conf;
 
 	if (!rtwvif_link)
 		return;
 
-	ether_addr_copy(rtwvif_link->mac_addr, vif->addr);
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	ether_addr_copy(rtwvif_link->mac_addr, bss_conf->addr);
+
+	rcu_read_unlock();
+
 	rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL);
 
 	rtw89_chip_rfk_scan(rtwdev, rtwvif_link, false);
@@ -4700,6 +4743,27 @@ int rtw89_chip_info_setup(struct rtw89_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw89_chip_info_setup);
 
+void rtw89_chip_cfg_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
+				       struct ieee80211_vif *vif)
+{
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct ieee80211_bss_conf *bss_conf;
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, false);
+	if (!bss_conf->he_support || !vif->cfg.assoc) {
+		rcu_read_unlock();
+		return;
+	}
+
+	rcu_read_unlock();
+
+	if (chip->ops->set_txpwr_ul_tb_offset)
+		chip->ops->set_txpwr_ul_tb_offset(rtwdev, 0, rtwvif_link->mac_idx);
+}
+
 static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5e22da91213b..8f66d4fac9aa 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3461,6 +3461,8 @@ struct rtw89_p2p_noa_setter {
 };
 
 struct rtw89_vif_link {
+	unsigned int link_id;
+
 	struct list_head list;
 	struct rtw89_dev *rtwdev;
 	struct rtw89_roc roc;
@@ -5994,6 +5996,36 @@ static inline struct rtw89_sta_link *sta_to_rtwsta_safe(struct ieee80211_sta *st
 	return sta ? (struct rtw89_sta_link *)sta->drv_priv : NULL;
 }
 
+static inline struct ieee80211_bss_conf *
+__rtw89_vif_rcu_dereference_link(struct rtw89_vif_link *rtwvif_link, bool *nolink)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_bss_conf *bss_conf;
+
+	bss_conf = rcu_dereference(vif->link_conf[rtwvif_link->link_id]);
+	if (unlikely(!bss_conf)) {
+		*nolink = true;
+		return &vif->bss_conf;
+	}
+
+	*nolink = false;
+	return bss_conf;
+}
+
+#define rtw89_vif_rcu_dereference_link(rtwvif_link, assert)		\
+({									\
+	typeof(rtwvif_link) p = rtwvif_link;				\
+	struct ieee80211_bss_conf *bss_conf;				\
+	bool nolink;							\
+									\
+	bss_conf = __rtw89_vif_rcu_dereference_link(p, &nolink);	\
+	if (unlikely(nolink) && (assert))				\
+		rtw89_err(p->rtwdev,					\
+			  "%s: cannot find exact bss_conf for link_id %u\n",\
+			  __func__, p->link_id);			\
+	bss_conf;							\
+})
+
 static inline u8 rtw89_hw_to_rate_info_bw(enum rtw89_bandwidth hw_bw)
 {
 	if (hw_bw == RTW89_CHANNEL_WIDTH_160)
@@ -6347,20 +6379,6 @@ static inline void rtw89_chip_cfg_txrx_path(struct rtw89_dev *rtwdev)
 		chip->ops->cfg_txrx_path(rtwdev);
 }
 
-static inline
-void rtw89_chip_cfg_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
-				       struct ieee80211_vif *vif)
-{
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	const struct rtw89_chip_info *chip = rtwdev->chip;
-
-	if (!vif->bss_conf.he_support || !vif->cfg.assoc)
-		return;
-
-	if (chip->ops->set_txpwr_ul_tb_offset)
-		chip->ops->set_txpwr_ul_tb_offset(rtwdev, 0, rtwvif_link->mac_idx);
-}
-
 static inline void rtw89_chip_digital_pwr_comp(struct rtw89_dev *rtwdev,
 					       enum rtw89_phy_idx phy_idx)
 {
@@ -6653,6 +6671,8 @@ int rtw89_core_release_sta_ba_entry(struct rtw89_dev *rtwdev,
 				    u8 *cam_idx);
 void rtw89_vif_type_mapping(struct ieee80211_vif *vif, bool assoc);
 int rtw89_chip_info_setup(struct rtw89_dev *rtwdev);
+void rtw89_chip_cfg_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
+				       struct ieee80211_vif *vif);
 bool rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate, u16 *bitrate);
 int rtw89_regd_setup(struct rtw89_dev *rtwdev);
 int rtw89_regd_init(struct rtw89_dev *rtwdev,
@@ -6675,7 +6695,9 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 			      struct ieee80211_vif *vif, bool hw_scan);
 int rtw89_reg_6ghz_recalc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			  bool active);
-void rtw89_core_update_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
+void rtw89_core_update_p2p_ps(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link,
+			      struct ieee80211_bss_conf *bss_conf);
 void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev, enum rtw89_btc_hmsg event);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 03775064ee0c..10069f0ce6a3 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2208,11 +2208,10 @@ static struct sk_buff *rtw89_eapol_get(struct rtw89_dev *rtwdev,
 {
 	static const u8 gtkbody[] = {0xAA, 0xAA, 0x03, 0x00, 0x00, 0x00, 0x88,
 				     0x8E, 0x01, 0x03, 0x00, 0x5F, 0x02, 0x03};
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
-	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
 	u8 sec_hdr_len = rtw89_wow_get_sec_hdr_len(rtwdev);
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_eapol_2_of_2 *eapol_pkt;
+	struct ieee80211_bss_conf *bss_conf;
 	struct ieee80211_hdr_3addr *hdr;
 	struct sk_buff *skb;
 	u8 key_des_ver;
@@ -2234,10 +2233,17 @@ static struct sk_buff *rtw89_eapol_get(struct rtw89_dev *rtwdev,
 	hdr->frame_control = cpu_to_le16(IEEE80211_FTYPE_DATA |
 					 IEEE80211_FCTL_TODS |
 					 IEEE80211_FCTL_PROTECTED);
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+
 	ether_addr_copy(hdr->addr1, bss_conf->bssid);
-	ether_addr_copy(hdr->addr2, vif->addr);
+	ether_addr_copy(hdr->addr2, bss_conf->addr);
 	ether_addr_copy(hdr->addr3, bss_conf->bssid);
 
+	rcu_read_unlock();
+
 	skb_put_zero(skb, sec_hdr_len);
 
 	eapol_pkt = skb_put_zero(skb, sizeof(*eapol_pkt));
@@ -2250,9 +2256,8 @@ static struct sk_buff *rtw89_eapol_get(struct rtw89_dev *rtwdev,
 static struct sk_buff *rtw89_sa_query_get(struct rtw89_dev *rtwdev,
 					  struct rtw89_vif_link *rtwvif_link)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
-	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
 	u8 sec_hdr_len = rtw89_wow_get_sec_hdr_len(rtwdev);
+	struct ieee80211_bss_conf *bss_conf;
 	struct ieee80211_hdr_3addr *hdr;
 	struct rtw89_sa_query *sa_query;
 	struct sk_buff *skb;
@@ -2265,10 +2270,17 @@ static struct sk_buff *rtw89_sa_query_get(struct rtw89_dev *rtwdev,
 	hdr->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 					 IEEE80211_STYPE_ACTION |
 					 IEEE80211_FCTL_PROTECTED);
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+
 	ether_addr_copy(hdr->addr1, bss_conf->bssid);
-	ether_addr_copy(hdr->addr2, vif->addr);
+	ether_addr_copy(hdr->addr2, bss_conf->addr);
 	ether_addr_copy(hdr->addr3, bss_conf->bssid);
 
+	rcu_read_unlock();
+
 	skb_put_zero(skb, sec_hdr_len);
 
 	sa_query = skb_put_zero(skb, sizeof(*sa_query));
@@ -2554,13 +2566,14 @@ int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 }
 
 #define H2C_P2P_ACT_LEN 20
-int rtw89_fw_h2c_p2p_act(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+int rtw89_fw_h2c_p2p_act(struct rtw89_dev *rtwdev,
+			 struct rtw89_vif_link *rtwvif_link,
+			 struct ieee80211_bss_conf *bss_conf,
 			 struct ieee80211_p2p_noa_desc *desc,
 			 u8 act, u8 noa_id)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	bool p2p_type_gc = rtwvif_link->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT;
-	u8 ctwindow_oppps = vif->bss_conf.p2p_noa_attr.oppps_ctwindow;
+	u8 ctwindow_oppps = bss_conf->p2p_noa_attr.oppps_ctwindow;
 	struct sk_buff *skb;
 	u8 *cmd;
 	int ret;
@@ -2962,6 +2975,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
 	u8 mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
 	struct rtw89_h2c_cctlinfo_ud_g7 *h2c;
+	struct ieee80211_bss_conf *bss_conf;
 	u8 pads[RTW89_PPE_BW_NUM];
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
@@ -2976,6 +2990,16 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 			__get_sta_he_pkt_padding(rtwdev, sta, pads);
 	}
 
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for cmac g7\n");
+		return -ENOMEM;
+	}
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+
 	if (vif->p2p)
 		lowest_rate = RTW89_HW_RATE_OFDM6;
 	else if (chan->band_type == RTW89_BAND_2G)
@@ -2983,11 +3007,6 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 	else
 		lowest_rate = RTW89_HW_RATE_OFDM6;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
-	if (!skb) {
-		rtw89_err(rtwdev, "failed to alloc skb for cmac g7\n");
-		return -ENOMEM;
-	}
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_cctlinfo_ud_g7 *)skb->data;
 
@@ -3016,8 +3035,8 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 		h2c->m4 |= cpu_to_le32(CCTLINFO_G7_W4_DATA_DCM);
 	}
 
-	if (vif->bss_conf.eht_support) {
-		u16 punct = vif->bss_conf.chanreq.oper.punctured;
+	if (bss_conf->eht_support) {
+		u16 punct = bss_conf->chanreq.oper.punctured;
 
 		h2c->w4 |= le32_encode_bits(~punct,
 					    CCTLINFO_G7_W4_ACT_SUBCH_CBW);
@@ -3050,6 +3069,8 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 		h2c->m8 = cpu_to_le32(CCTLINFO_G7_W8_BSR_QUEUE_SIZE_FORMAT);
 	}
 
+	rcu_read_unlock();
+
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
 			      H2C_FUNC_MAC_CCTLINFO_UD_G7, 0, 1,
@@ -3433,7 +3454,8 @@ rtw89_fw_get_sta_type(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_li
 		      struct rtw89_sta_link *rtwsta_link)
 {
 	struct ieee80211_sta *sta = rtwsta_to_sta_safe(rtwsta_link);
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_bss_conf *bss_conf;
+	enum rtw89_fw_sta_type type;
 
 	if (!sta)
 		goto by_vif;
@@ -3446,12 +3468,20 @@ rtw89_fw_get_sta_type(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_li
 		return RTW89_FW_N_AC_STA;
 
 by_vif:
-	if (vif->bss_conf.eht_support)
-		return RTW89_FW_BE_STA;
-	else if (vif->bss_conf.he_support)
-		return RTW89_FW_AX_STA;
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+
+	if (bss_conf->eht_support)
+		type = RTW89_FW_BE_STA;
+	else if (bss_conf->he_support)
+		type = RTW89_FW_AX_STA;
 	else
-		return RTW89_FW_N_AC_STA;
+		type = RTW89_FW_N_AC_STA;
+
+	rcu_read_unlock();
+
+	return type;
 }
 
 int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
@@ -3741,7 +3771,7 @@ int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
 				  bool connect)
 {
 	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
-	struct ieee80211_bss_conf *bss_conf = vif ? &vif->bss_conf : NULL;
+	struct ieee80211_bss_conf *bss_conf;
 	s32 thold = RTW89_DEFAULT_CQM_THOLD;
 	u32 hyst = RTW89_DEFAULT_CQM_HYST;
 	struct rtw89_h2c_bcnfltr *h2c;
@@ -3752,9 +3782,20 @@ int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
 	if (!RTW89_CHK_FW_FEATURE(BEACON_FILTER, &rtwdev->fw))
 		return -EINVAL;
 
-	if (!rtwvif_link || !bss_conf || rtwvif_link->net_type != RTW89_NET_TYPE_INFRA)
+	if (!rtwvif_link || rtwvif_link->net_type != RTW89_NET_TYPE_INFRA)
 		return -EINVAL;
 
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, false);
+
+	if (bss_conf->cqm_rssi_hyst)
+		hyst = bss_conf->cqm_rssi_hyst;
+	if (bss_conf->cqm_rssi_thold)
+		thold = bss_conf->cqm_rssi_thold;
+
+	rcu_read_unlock();
+
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c bcn filter\n");
@@ -3764,11 +3805,6 @@ int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_bcnfltr *)skb->data;
 
-	if (bss_conf->cqm_rssi_hyst)
-		hyst = bss_conf->cqm_rssi_hyst;
-	if (bss_conf->cqm_rssi_thold)
-		thold = bss_conf->cqm_rssi_thold;
-
 	h2c->w0 = le32_encode_bits(connect, RTW89_H2C_BCNFLTR_W0_MON_RSSI) |
 		  le32_encode_bits(connect, RTW89_H2C_BCNFLTR_W0_MON_BCN) |
 		  le32_encode_bits(connect, RTW89_H2C_BCNFLTR_W0_MON_EN) |
@@ -6550,7 +6586,7 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 		get_random_mask_addr(mac_addr, req->mac_addr,
 				     req->mac_addr_mask);
 	else
-		ether_addr_copy(mac_addr, vif->addr);
+		ether_addr_copy(mac_addr, rtwvif_link->mac_addr);
 	rtw89_core_scan_start(rtwdev, rtwvif_link, mac_addr, true);
 
 	rx_fltr &= ~B_AX_A_BCN_CHK_EN;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 00e52a33516b..b13512c3feb2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4553,7 +4553,9 @@ int rtw89_pno_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_pkt_drop(struct rtw89_dev *rtwdev,
 			  const struct rtw89_pkt_drop_params *params);
-int rtw89_fw_h2c_p2p_act(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+int rtw89_fw_h2c_p2p_act(struct rtw89_dev *rtwdev,
+			 struct rtw89_vif_link *rtwvif_link,
+			 struct ieee80211_bss_conf *bss_conf,
 			 struct ieee80211_p2p_noa_desc *desc,
 			 u8 act, u8 noa_id);
 int rtw89_fw_h2c_tsf32_toggle(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index d6cd3ed1e7fc..d5097d3a3385 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4141,10 +4141,11 @@ static void rtw89_mac_port_cfg_func_sw(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct ieee80211_bss_conf *bss_conf;
 	bool need_backup = false;
 	u32 backup_val;
+	u16 beacon_int;
 
 	if (!rtw89_read32_port_mask(rtwdev, rtwvif_link, p->port_cfg, B_AX_PORT_FUNC_EN))
 		return;
@@ -4168,7 +4169,14 @@ static void rtw89_mac_port_cfg_func_sw(struct rtw89_dev *rtwdev,
 				       B_AX_BCNERLY_MASK);
 	}
 
-	msleep(vif->bss_conf.beacon_int + 1);
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	beacon_int = bss_conf->beacon_int;
+
+	rcu_read_unlock();
+
+	msleep(beacon_int + 1);
 	rtw89_write32_port_clr(rtwdev, rtwvif_link, p->port_cfg, B_AX_PORT_FUNC_EN |
 							    B_AX_BRK_SETUP);
 	rtw89_write32_port_set(rtwdev, rtwvif_link, p->port_cfg, B_AX_TSFTR_RST);
@@ -4301,8 +4309,18 @@ static void rtw89_mac_port_cfg_bcn_intv(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
-	u16 bcn_int = vif->bss_conf.beacon_int ? vif->bss_conf.beacon_int : BCN_INTERVAL;
+	struct ieee80211_bss_conf *bss_conf;
+	u16 bcn_int;
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	if (bss_conf->beacon_int)
+		bcn_int = bss_conf->beacon_int;
+	else
+		bcn_int = BCN_INTERVAL;
+
+	rcu_read_unlock();
 
 	rtw89_write32_port_mask(rtwdev, rtwvif_link, p->bcn_space, B_AX_BCN_SPACE_MASK,
 				bcn_int);
@@ -4326,14 +4344,22 @@ static void rtw89_mac_port_cfg_hiq_dtim(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_bss_conf *bss_conf;
+	u8 dtim_period;
 	u32 addr;
 
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	dtim_period = bss_conf->dtim_period;
+
+	rcu_read_unlock();
+
 	addr = rtw89_mac_reg_by_idx(rtwdev, p->md_tsft, rtwvif_link->mac_idx);
 	rtw89_write8_set(rtwdev, addr, B_AX_UPD_HGQMD | B_AX_UPD_TIMIE);
 
 	rtw89_write16_port_mask(rtwdev, rtwvif_link, p->dtim_ctrl, B_AX_DTIM_NUM_MASK,
-				vif->bss_conf.dtim_period);
+				dtim_period);
 }
 
 static void rtw89_mac_port_cfg_bcn_setup_time(struct rtw89_dev *rtwdev,
@@ -4381,18 +4407,24 @@ static void rtw89_mac_port_cfg_bss_color(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	static const u32 masks[RTW89_PORT_NUM] = {
 		B_AX_BSS_COLOB_AX_PORT_0_MASK, B_AX_BSS_COLOB_AX_PORT_1_MASK,
 		B_AX_BSS_COLOB_AX_PORT_2_MASK, B_AX_BSS_COLOB_AX_PORT_3_MASK,
 		B_AX_BSS_COLOB_AX_PORT_4_MASK,
 	};
+	struct ieee80211_bss_conf *bss_conf;
 	u8 port = rtwvif_link->port;
 	u32 reg_base;
 	u32 reg;
 	u8 bss_color;
 
-	bss_color = vif->bss_conf.he_bss_color.color;
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	bss_color = bss_conf->he_bss_color.color;
+
+	rcu_read_unlock();
+
 	reg_base = port >= 4 ? p->bss_color + 4 : p->bss_color;
 	reg = rtw89_mac_reg_by_idx(rtwdev, reg_base, rtwvif_link->mac_idx);
 	rtw89_write32_mask(rtwdev, reg, masks[port], bss_color);
@@ -4670,16 +4702,28 @@ void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct ieee80211_hw *hw = rtwdev->hw;
+	struct ieee80211_bss_conf *bss_conf;
+	struct cfg80211_chan_def oper;
 	bool tolerated = true;
 	u32 reg;
 
-	if (!vif->bss_conf.he_support || vif->type != NL80211_IFTYPE_STATION)
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	if (!bss_conf->he_support || vif->type != NL80211_IFTYPE_STATION) {
+		rcu_read_unlock();
 		return;
+	}
 
-	if (!(vif->bss_conf.chanreq.oper.chan->flags & IEEE80211_CHAN_RADAR))
+	oper = bss_conf->chanreq.oper;
+	if (!(oper.chan->flags & IEEE80211_CHAN_RADAR)) {
+		rcu_read_unlock();
 		return;
+	}
+
+	rcu_read_unlock();
 
-	cfg80211_bss_iter(hw->wiphy, &vif->bss_conf.chanreq.oper,
+	cfg80211_bss_iter(hw->wiphy, &oper,
 			  rtw89_mac_check_he_obss_narrow_bw_ru_iter,
 			  &tolerated);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 392a38fcf461..f04032a8a8ec 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -111,6 +111,7 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct ieee80211_bss_conf *bss_conf;
 	int ret = 0;
 
 	rtw89_debug(rtwdev, RTW89_DBG_STATE, "add vif %pM type %d, p2p %d\n",
@@ -151,7 +152,14 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	rtwvif_link->chanctx_assigned = false;
 	rtwvif_link->hit_rule = 0;
 	rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
-	ether_addr_copy(rtwvif_link->mac_addr, vif->addr);
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	ether_addr_copy(rtwvif_link->mac_addr, bss_conf->addr);
+
+	rcu_read_unlock();
+
 	INIT_LIST_HEAD(&rtwvif_link->general_pkt_list);
 
 	ret = rtw89_mac_add_vif(rtwdev, rtwvif_link);
@@ -314,13 +322,19 @@ static const u8 ac_to_fw_idx[IEEE80211_NUM_ACS] = {
 static u8 rtw89_aifsn_to_aifs(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif_link *rtwvif_link, u8 aifsn)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
+	struct ieee80211_bss_conf *bss_conf;
 	u8 slot_time;
 	u8 sifs;
 
-	slot_time = vif->bss_conf.use_short_slot ? 9 : 20;
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	slot_time = bss_conf->use_short_slot ? 9 : 20;
+
+	rcu_read_unlock();
+
 	sifs = chan->band_type == RTW89_BAND_2G ? 10 : 16;
 
 	return aifsn * slot_time + sifs;
@@ -486,7 +500,7 @@ static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
 		rtw89_mac_bf_set_gid_table(rtwdev, vif, conf);
 
 	if (changed & BSS_CHANGED_P2P_PS)
-		rtw89_core_update_p2p_ps(rtwdev, vif);
+		rtw89_core_update_p2p_ps(rtwdev, rtwvif_link, conf);
 
 	if (changed & BSS_CHANGED_CQM)
 		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
@@ -516,7 +530,7 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 	if (rtwdev->scanning)
 		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
 
-	ether_addr_copy(rtwvif_link->bssid, vif->bss_conf.bssid);
+	ether_addr_copy(rtwvif_link->bssid, link_conf->bssid);
 	rtw89_cam_bssid_changed(rtwdev, rtwvif_link);
 	rtw89_mac_port_update(rtwdev, rtwvif_link);
 	rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, vif, NULL);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index e632e74601cb..dd24d253947e 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -6006,15 +6006,24 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 
 void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
 {
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_reg_def *bss_clr_vld = &chip->bss_clr_vld;
 	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
+	struct ieee80211_bss_conf *bss_conf;
 	u8 bss_color;
 
-	if (!vif->bss_conf.he_support || !vif->cfg.assoc)
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	if (!bss_conf->he_support || !vif->cfg.assoc) {
+		rcu_read_unlock();
 		return;
+	}
+
+	bss_color = bss_conf->he_bss_color.color;
 
-	bss_color = vif->bss_conf.he_bss_color.color;
+	rcu_read_unlock();
 
 	rtw89_phy_write32_idx(rtwdev, bss_clr_vld->addr, bss_clr_vld->mask, 0x1,
 			      phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 42a73bba7f5c..ded0b73bd678 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -214,9 +214,9 @@ static void rtw89_tsf32_toggle(struct rtw89_dev *rtwdev,
 }
 
 static void rtw89_p2p_disable_all_noa(struct rtw89_dev *rtwdev,
-				      struct ieee80211_vif *vif)
+				      struct rtw89_vif_link *rtwvif_link,
+				      struct ieee80211_bss_conf *bss_conf)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	enum rtw89_p2pps_action act;
 	u8 noa_id;
 
@@ -229,20 +229,21 @@ static void rtw89_p2p_disable_all_noa(struct rtw89_dev *rtwdev,
 		else
 			act = RTW89_P2P_ACT_REMOVE;
 		rtw89_tsf32_toggle(rtwdev, rtwvif_link, act);
-		rtw89_fw_h2c_p2p_act(rtwdev, vif, NULL, act, noa_id);
+		rtw89_fw_h2c_p2p_act(rtwdev, rtwvif_link, bss_conf,
+				     NULL, act, noa_id);
 	}
 }
 
 static void rtw89_p2p_update_noa(struct rtw89_dev *rtwdev,
-				 struct ieee80211_vif *vif)
+				 struct rtw89_vif_link *rtwvif_link,
+				 struct ieee80211_bss_conf *bss_conf)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct ieee80211_p2p_noa_desc *desc;
 	enum rtw89_p2pps_action act;
 	u8 noa_id;
 
 	for (noa_id = 0; noa_id < RTW89_P2P_MAX_NOA_NUM; noa_id++) {
-		desc = &vif->bss_conf.p2p_noa_attr.desc[noa_id];
+		desc = &bss_conf->p2p_noa_attr.desc[noa_id];
 		if (!desc->count || !desc->duration)
 			break;
 
@@ -251,15 +252,18 @@ static void rtw89_p2p_update_noa(struct rtw89_dev *rtwdev,
 		else
 			act = RTW89_P2P_ACT_UPDATE;
 		rtw89_tsf32_toggle(rtwdev, rtwvif_link, act);
-		rtw89_fw_h2c_p2p_act(rtwdev, vif, desc, act, noa_id);
+		rtw89_fw_h2c_p2p_act(rtwdev, rtwvif_link, bss_conf,
+				     desc, act, noa_id);
 	}
 	rtwvif_link->last_noa_nr = noa_id;
 }
 
-void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
+void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev,
+			  struct rtw89_vif_link *rtwvif_link,
+			  struct ieee80211_bss_conf *bss_conf)
 {
-	rtw89_p2p_disable_all_noa(rtwdev, vif);
-	rtw89_p2p_update_noa(rtwdev, vif);
+	rtw89_p2p_disable_all_noa(rtwdev, rtwvif_link, bss_conf);
+	rtw89_p2p_update_noa(rtwdev, rtwvif_link, bss_conf);
 }
 
 void rtw89_recalc_lps(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/ps.h b/drivers/net/wireless/realtek/rtw89/ps.h
index d0be56ee16a2..cdd712966b09 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.h
+++ b/drivers/net/wireless/realtek/rtw89/ps.h
@@ -14,7 +14,9 @@ void rtw89_leave_ps_mode(struct rtw89_dev *rtwdev);
 void rtw89_enter_ips(struct rtw89_dev *rtwdev);
 void rtw89_leave_ips(struct rtw89_dev *rtwdev);
 void rtw89_set_coex_ctrl_lps(struct rtw89_dev *rtwdev, bool btc_ctrl);
-void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
+void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev,
+			  struct rtw89_vif_link *rtwvif_link,
+			  struct ieee80211_bss_conf *bss_conf);
 void rtw89_recalc_lps(struct rtw89_dev *rtwdev);
 void rtw89_p2p_noa_renew(struct rtw89_vif_link *rtwvif_link);
 void rtw89_p2p_noa_append(struct rtw89_vif_link *rtwvif_link,
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 0fd8e132fdf0..aa5ae0244372 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -834,16 +834,21 @@ static int rtw89_reg_6ghz_tpe_recalc(struct rtw89_dev *rtwdev,
 				     struct rtw89_vif_link *rtwvif_link, bool active,
 				     unsigned int *changed)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
-	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
 	struct rtw89_reg_6ghz_tpe *tpe = &rtwvif_link->reg_6ghz_tpe;
+	struct ieee80211_bss_conf *bss_conf;
 
 	memset(tpe, 0, sizeof(*tpe));
 
 	if (!active || rtwvif_link->reg_6ghz_power != RTW89_REG_6GHZ_POWER_STD)
 		goto bottom;
 
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
 	rtw89_calculate_tpe(rtwdev, tpe, &bss_conf->tpe);
+
+	rcu_read_unlock();
+
 	if (!tpe->valid)
 		goto bottom;
 
@@ -911,10 +916,14 @@ static int rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
 				       struct rtw89_vif_link *rtwvif_link, bool active,
 				       unsigned int *changed)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_bss_conf *bss_conf;
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
 
 	if (active) {
-		switch (vif->bss_conf.power_type) {
+		switch (bss_conf->power_type) {
 		case IEEE80211_REG_VLP_AP:
 			rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_VLP;
 			break;
@@ -932,6 +941,8 @@ static int rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
 		rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
 	}
 
+	rcu_read_unlock();
+
 	*changed += __rtw89_reg_6ghz_power_recalc(rtwdev);
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 5046fef55222..17e2d5cbb1e6 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -633,10 +633,12 @@ static struct ieee80211_key_conf *rtw89_wow_gtk_rekey(struct rtw89_dev *rtwdev,
 static void rtw89_wow_update_key_info(struct rtw89_dev *rtwdev, bool rx_ready)
 {
 	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_wow_aoac_report *aoac_rpt = &rtw_wow->aoac_rpt;
 	struct rtw89_set_key_info_iter_data data = {.error = false,
 						    .rx_ready = rx_ready};
+	struct ieee80211_bss_conf *bss_conf;
 	struct ieee80211_key_conf *key;
 
 	rcu_read_lock();
@@ -669,9 +671,15 @@ static void rtw89_wow_update_key_info(struct rtw89_dev *rtwdev, bool rx_ready)
 		return;
 
 	rtw89_rx_pn_set_pmf(rtwdev, key, aoac_rpt->igtk_ipn);
-	ieee80211_gtk_rekey_notify(wow_vif, wow_vif->bss_conf.bssid,
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	ieee80211_gtk_rekey_notify(wow_vif, bss_conf->bssid,
 				   aoac_rpt->eapol_key_replay_count,
-				   GFP_KERNEL);
+				   GFP_ATOMIC);
+
+	rcu_read_unlock();
 }
 
 static void rtw89_wow_leave_deep_ps(struct rtw89_dev *rtwdev)
-- 
2.25.1


