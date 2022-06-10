Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF89E545D52
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 09:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244755AbiFJH1O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 03:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346803AbiFJH0x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 03:26:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917E6131284
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 00:26:50 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25A7Qi1Q2010119, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25A7Qi1Q2010119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jun 2022 15:26:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 15:26:44 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 10 Jun
 2022 15:26:43 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <damon.chen@realtek.com>,
        <phhuang@realtek.com>
Subject: [PATCH 01/11] rtw89: allocate address CAM and MAC ID to TDLS peer
Date:   Fri, 10 Jun 2022 15:26:00 +0800
Message-ID: <20220610072610.27095-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610072610.27095-1-pkshih@realtek.com>
References: <20220610072610.27095-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/10/2022 07:06:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMTAgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Normally, we only allocate an address CAM and single one MAC ID to AP in
STA mode. To support TDLS, we handle TDLS peers like AP handles stations.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 18 +++++++++---------
 drivers/net/wireless/realtek/rtw89/core.h     | 10 +++++++---
 drivers/net/wireless/realtek/rtw89/mac80211.c |  2 +-
 drivers/net/wireless/realtek/rtw89/ser.c      | 13 +++++++------
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 4df81f00c2211..5c4805fd5aa3a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2238,13 +2238,13 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 
 	ewma_rssi_init(&rtwsta->avg_rssi);
 
-	if (vif->type == NL80211_IFTYPE_STATION) {
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		/* for station mode, assign the mac_id from itself */
 		rtwsta->mac_id = rtwvif->mac_id;
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
 					 BTC_ROLE_MSTS_STA_CONN_START);
 		rtw89_chip_rfk_channel(rtwdev);
-	} else if (vif->type == NL80211_IFTYPE_AP) {
+	} else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
 		rtwsta->mac_id = rtw89_core_acquire_bit_map(rtwdev->mac_id_map,
 							    RTW89_MAX_MAC_ID_NUM);
 	}
@@ -2275,10 +2275,10 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 	rtw89_mac_bf_monitor_calc(rtwdev, sta, true);
 	rtw89_mac_bf_disassoc(rtwdev, vif, sta);
 	rtw89_core_free_sta_pending_ba(rtwdev, sta);
-	if (vif->type == NL80211_IFTYPE_AP)
+	if (vif->type == NL80211_IFTYPE_AP || sta->tdls)
 		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta->addr_cam);
 
-	if (vif->type == NL80211_IFTYPE_STATION)
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		rtw89_vif_type_mapping(vif, false);
 
 	ret = rtw89_fw_h2c_assoc_cmac_tbl(rtwdev, vif, sta);
@@ -2293,7 +2293,7 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
-	if (vif->type == NL80211_IFTYPE_AP) {
+	if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
 		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, rtwsta, RTW89_ROLE_REMOVE);
 		if (ret) {
 			rtw89_warn(rtwdev, "failed to send h2c role info\n");
@@ -2319,7 +2319,7 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	int ret;
 
-	if (vif->type == NL80211_IFTYPE_AP) {
+	if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
 		ret = rtw89_mac_set_macid_pause(rtwdev, rtwsta->mac_id, false);
 		if (ret) {
 			rtw89_warn(rtwdev, "failed to send h2c macid pause\n");
@@ -2369,7 +2369,7 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 	rtw89_mac_bf_assoc(rtwdev, vif, sta);
 	rtw89_mac_bf_monitor_calc(rtwdev, sta, false);
 
-	if (vif->type == NL80211_IFTYPE_STATION) {
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
 					 BTC_ROLE_MSTS_STA_CONN_END);
 		rtw89_core_get_no_ul_ofdma_htc(rtwdev, &rtwsta->htc_template);
@@ -2385,10 +2385,10 @@ int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 
-	if (vif->type == NL80211_IFTYPE_STATION)
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
 					 BTC_ROLE_MSTS_STA_DIS_CONN);
-	else if (vif->type == NL80211_IFTYPE_AP)
+	else if (vif->type == NL80211_IFTYPE_AP || sta->tdls)
 		rtw89_core_release_bit_map(rtwdev->mac_id_map, rtwsta->mac_id);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6dd341f3fd33e..b8bd8b8f1bb74 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1961,7 +1961,7 @@ struct rtw89_sta {
 	struct ieee80211_rx_status rx_status;
 	u16 rx_hw_rate;
 	__le32 htc_template;
-	struct rtw89_addr_cam_entry addr_cam; /* AP mode only */
+	struct rtw89_addr_cam_entry addr_cam; /* AP mode or TDLS peer only */
 
 	bool use_cfg_mask;
 	struct cfg80211_bitrate_mask mask;
@@ -3537,8 +3537,12 @@ static inline
 struct rtw89_addr_cam_entry *rtw89_get_addr_cam_of(struct rtw89_vif *rtwvif,
 						   struct rtw89_sta *rtwsta)
 {
-	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE && rtwsta)
-		return &rtwsta->addr_cam;
+	if (rtwsta) {
+		struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta);
+
+		if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE || sta->tdls)
+			return &rtwsta->addr_cam;
+	}
 	return &rtwvif->addr_cam;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 6d0c62c545a78..768b1bfca3821 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -454,7 +454,7 @@ static int __rtw89_ops_sta_state(struct ieee80211_hw *hw,
 
 	if (old_state == IEEE80211_STA_AUTH &&
 	    new_state == IEEE80211_STA_ASSOC) {
-		if (vif->type == NL80211_IFTYPE_STATION)
+		if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 			return 0; /* defer to bss_info_changed to have vif info */
 		return rtw89_core_sta_assoc(rtwdev, vif, sta);
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 9e95ed9727108..a5d530b042226 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -300,18 +300,19 @@ static void ser_reset_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 static void ser_sta_deinit_addr_cam_iter(void *data, struct ieee80211_sta *sta)
 {
-	struct rtw89_dev *rtwdev = (struct rtw89_dev *)data;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)data;
+	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 
-	rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta->addr_cam);
+	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE || sta->tdls)
+		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta->addr_cam);
 }
 
 static void ser_deinit_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
-	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
-		ieee80211_iterate_stations_atomic(rtwdev->hw,
-						  ser_sta_deinit_addr_cam_iter,
-						  rtwdev);
+	ieee80211_iterate_stations_atomic(rtwdev->hw,
+					  ser_sta_deinit_addr_cam_iter,
+					  rtwvif);
 
 	rtw89_cam_deinit(rtwdev, rtwvif);
 }
-- 
2.25.1

