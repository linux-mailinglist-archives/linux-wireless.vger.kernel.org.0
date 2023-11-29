Return-Path: <linux-wireless+bounces-192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D967FCFA7
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 08:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44ED3B21424
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 07:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5989410944;
	Wed, 29 Nov 2023 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA59119A6
	for <linux-wireless@vger.kernel.org>; Tue, 28 Nov 2023 23:02:08 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AT721b842598113, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AT721b842598113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 15:02:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 29 Nov 2023 15:02:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 29 Nov
 2023 15:02:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/4] wifi: rtw89: fix misbehavior of TX beacon in concurrent mode
Date: Wed, 29 Nov 2023 15:00:46 +0800
Message-ID: <20231129070046.18443-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129070046.18443-1-pkshih@realtek.com>
References: <20231129070046.18443-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Chih-Kang Chang <gary.chang@realtek.com>

In concurrent mode, when STA interface is scanning, it causes
AP interface TX beacon on wrong channel. We modified it to scan
with the operating channel when one of the interfaces is already
connected. Additionally, STA interface need to stop scan when AP
interface is starting to avoid TX beacon on wrong channel. Finally,
AP interface need to stop TX beacon when STA interface is scanning
and switching to non-OP channel,This prevent other device to get
beacons on wrong channel.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c       | 17 +++++++++--
 drivers/net/wireless/realtek/rtw89/mac.c      | 29 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  3 ++
 4 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 898b3f432d1c..b11ed35e265d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4045,6 +4045,7 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	rtw89_core_scan_complete(rtwdev, vif, true);
 	ieee80211_scan_completed(rtwdev->hw, &info);
 	ieee80211_wake_queues(rtwdev->hw);
+	rtw89_mac_enable_beacon_for_ap_vifs(rtwdev, true);
 
 	rtw89_release_pkt_list(rtwdev);
 	rtwvif = (struct rtw89_vif *)vif->drv_priv;
@@ -4062,6 +4063,19 @@ void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
 	rtw89_hw_scan_complete(rtwdev, vif, true);
 }
 
+static bool rtw89_is_any_vif_connected_or_connecting(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_vif *rtwvif;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		/* This variable implies connected or during attempt to connect */
+		if (!is_zero_ether_addr(rtwvif->bssid))
+			return true;
+	}
+
+	return false;
+}
+
 int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			  bool enable)
 {
@@ -4074,8 +4088,7 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	if (!rtwvif)
 		return -EINVAL;
 
-	/* This variable implies connected or during attempt to connect */
-	connected = !is_zero_ether_addr(rtwvif->bssid);
+	connected = rtw89_is_any_vif_connected_or_connecting(rtwdev);
 	opt.enable = enable;
 	opt.target_ch_mode = connected;
 	if (enable) {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 23d41398be87..fd29df8ad403 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3923,12 +3923,10 @@ static void rtw89_mac_port_cfg_rx_sync(struct rtw89_dev *rtwdev,
 }
 
 static void rtw89_mac_port_cfg_tx_sw(struct rtw89_dev *rtwdev,
-				     struct rtw89_vif *rtwvif)
+				     struct rtw89_vif *rtwvif, bool en)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
-	bool en = rtwvif->net_type == RTW89_NET_TYPE_AP_MODE ||
-		  rtwvif->net_type == RTW89_NET_TYPE_AD_HOC;
 
 	if (en)
 		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_BCNTX_EN);
@@ -3936,6 +3934,24 @@ static void rtw89_mac_port_cfg_tx_sw(struct rtw89_dev *rtwdev,
 		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_BCNTX_EN);
 }
 
+static void rtw89_mac_port_cfg_tx_sw_by_nettype(struct rtw89_dev *rtwdev,
+						struct rtw89_vif *rtwvif)
+{
+	bool en = rtwvif->net_type == RTW89_NET_TYPE_AP_MODE ||
+		  rtwvif->net_type == RTW89_NET_TYPE_AD_HOC;
+
+	rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif, en);
+}
+
+void rtw89_mac_enable_beacon_for_ap_vifs(struct rtw89_dev *rtwdev, bool en)
+{
+	struct rtw89_vif *rtwvif;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
+			rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif, en);
+}
+
 static void rtw89_mac_port_cfg_bcn_intv(struct rtw89_dev *rtwdev,
 					struct rtw89_vif *rtwvif)
 {
@@ -4242,7 +4258,7 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_mac_port_cfg_bcn_prct(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_rx_sw(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif);
+	rtw89_mac_port_cfg_tx_sw_by_nettype(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_bcn_intv(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_hiq_win(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_hiq_dtim(rtwdev, rtwvif);
@@ -4404,8 +4420,10 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 
 	switch (reason) {
 	case RTW89_SCAN_LEAVE_CH_NOTIFY:
-		if (rtw89_is_op_chan(rtwdev, band, chan))
+		if (rtw89_is_op_chan(rtwdev, band, chan)) {
+			rtw89_mac_enable_beacon_for_ap_vifs(rtwdev, false);
 			ieee80211_stop_queues(rtwdev->hw);
+		}
 		return;
 	case RTW89_SCAN_END_SCAN_NOTIFY:
 		if (rtwvif && rtwvif->scan_req &&
@@ -4423,6 +4441,7 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 		if (rtw89_is_op_chan(rtwdev, band, chan)) {
 			rtw89_assign_entity_chan(rtwdev, rtwvif->sub_entity_idx,
 						 &rtwdev->scan_info.op_chan);
+			rtw89_mac_enable_beacon_for_ap_vifs(rtwdev, true);
 			ieee80211_wake_queues(rtwdev->hw);
 		} else {
 			rtw89_chan_create(&new, chan, chan, band,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index f47a42387a6a..0b70a1c37b2c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -996,6 +996,7 @@ int rtw89_mac_port_get_tsf(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 					struct ieee80211_vif *vif);
 void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+void rtw89_mac_enable_beacon_for_ap_vifs(struct rtw89_dev *rtwdev, bool en);
 int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 int rtw89_mac_enable_bb_rf(struct rtw89_dev *rtwdev);
 int rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 5c3a3d9c272a..93889d2fface 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -491,6 +491,9 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 		return -EOPNOTSUPP;
 	}
 
+	if (rtwdev->scanning)
+		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
+
 	ether_addr_copy(rtwvif->bssid, vif->bss_conf.bssid);
 	rtw89_cam_bssid_changed(rtwdev, rtwvif);
 	rtw89_mac_port_update(rtwdev, rtwvif);
-- 
2.25.1


