Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E556731EB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 07:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjASGq5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 01:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjASGqx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 01:46:53 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7D5F1B1
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 22:46:51 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30J6khkxF027805, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30J6khkxF027805
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 19 Jan 2023 14:46:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 19 Jan 2023 14:46:44 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 19 Jan
 2023 14:46:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <damon.chen@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: disallow enter PS mode after create TDLS link
Date:   Thu, 19 Jan 2023 14:46:31 +0800
Message-ID: <20230119064631.66971-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 01/19/2023 06:25:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTkgpFekyCAwMzozNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kuan-Chung Chen <damon.chen@realtek.com>

Buffer STA on TDLS links are not currently supported. Therefore, it
is not allowed to enter the PS mode after TDLS link is established.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 10 ++++++++--
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 4cf4a81ed4f79..23550e193976d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2206,8 +2206,9 @@ static bool rtw89_traffic_stats_track(struct rtw89_dev *rtwdev)
 
 static void rtw89_vif_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
-	if (rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION &&
-	    rtwvif->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT)
+	if ((rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION &&
+	     rtwvif->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT) ||
+	    rtwvif->tdls_peer)
 		return;
 
 	if (rtwvif->stats.tx_tfc_lv == RTW89_TFC_IDLE &&
@@ -2466,9 +2467,12 @@ int rtw89_core_sta_disassoc(struct rtw89_dev *rtwdev,
 			    struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta)
 {
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 
 	rtwdev->total_sta_assoc--;
+	if (sta->tdls)
+		rtwvif->tdls_peer--;
 	rtwsta->disassoc = true;
 
 	return 0;
@@ -2587,6 +2591,8 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 	}
 
 	rtwdev->total_sta_assoc++;
+	if (sta->tdls)
+		rtwvif->tdls_peer++;
 	rtw89_phy_ra_assoc(rtwdev, sta);
 	rtw89_mac_bf_assoc(rtwdev, vif, sta);
 	rtw89_mac_bf_monitor_calc(rtwdev, sta, false);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 39c5a003e36cc..a762eef699fa0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2452,6 +2452,7 @@ struct rtw89_vif {
 	bool last_a_ctrl;
 	bool dyn_tb_bedge_en;
 	u8 def_tri_idx;
+	u32 tdls_peer;
 	struct work_struct update_beacon_work;
 	struct rtw89_addr_cam_entry addr_cam;
 	struct rtw89_bssid_cam_entry bssid_cam;
-- 
2.25.1

