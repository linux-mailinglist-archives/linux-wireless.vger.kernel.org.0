Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E605E57B9
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 03:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiIVBFh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Sep 2022 21:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiIVBFd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Sep 2022 21:05:33 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68FF27CB5D
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 18:05:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28M14uryE019406, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28M14uryE019406
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 22 Sep 2022 09:04:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 09:05:19 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 22 Sep
 2022 09:05:18 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/5] wifi: rtw89: set wifi_role of P2P
Date:   Thu, 22 Sep 2022 09:04:33 +0800
Message-ID: <20220922010435.12167-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922010435.12167-1-pkshih@realtek.com>
References: <20220922010435.12167-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/22/2022 00:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjEgpFWkyCAxMDo1MjowMA==?=
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

Consider vif->p2p to set wifi_role to let firmware know current vif is
running as GC or GO. And, allow GC to enter PS mode, but disallow to enter
deep PS for now.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 19 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/ps.c   | 14 +++++++++-----
 drivers/net/wireless/realtek/rtw89/ps.h   |  2 +-
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index ee8cb7ab7e827..87938c9e24e17 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2167,12 +2167,13 @@ static bool rtw89_traffic_stats_track(struct rtw89_dev *rtwdev)
 
 static void rtw89_vif_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
-	if (rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION)
+	if (rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION &&
+	    rtwvif->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT)
 		return;
 
 	if (rtwvif->stats.tx_tfc_lv == RTW89_TFC_IDLE &&
 	    rtwvif->stats.rx_tfc_lv == RTW89_TFC_IDLE)
-		rtw89_enter_lps(rtwdev, rtwvif->mac_id);
+		rtw89_enter_lps(rtwdev, rtwvif);
 }
 
 static void rtw89_enter_lps_track(struct rtw89_dev *rtwdev)
@@ -2333,9 +2334,19 @@ void rtw89_vif_type_mapping(struct ieee80211_vif *vif, bool assoc)
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 
 	switch (vif->type) {
+	case NL80211_IFTYPE_STATION:
+		if (vif->p2p)
+			rtwvif->wifi_role = RTW89_WIFI_ROLE_P2P_CLIENT;
+		else
+			rtwvif->wifi_role = RTW89_WIFI_ROLE_STATION;
+		break;
+	case NL80211_IFTYPE_AP:
+		if (vif->p2p)
+			rtwvif->wifi_role = RTW89_WIFI_ROLE_P2P_GO;
+		else
+			rtwvif->wifi_role = RTW89_WIFI_ROLE_AP;
+		break;
 	RTW89_TYPE_MAPPING(ADHOC);
-	RTW89_TYPE_MAPPING(STATION);
-	RTW89_TYPE_MAPPING(AP);
 	RTW89_TYPE_MAPPING(MONITOR);
 	RTW89_TYPE_MAPPING(MESH_POINT);
 	default:
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index ea3260178e666..3c56a5ef40f84 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -59,8 +59,11 @@ static void rtw89_ps_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
 		rtw89_mac_power_mode_change(rtwdev, enter);
 }
 
-static void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev)
+static void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
+	if (rtwvif->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT)
+		return;
+
 	if (!rtwdev->ps_mode)
 		return;
 
@@ -111,20 +114,21 @@ void rtw89_leave_ps_mode(struct rtw89_dev *rtwdev)
 	__rtw89_leave_ps_mode(rtwdev);
 }
 
-void rtw89_enter_lps(struct rtw89_dev *rtwdev, u8 mac_id)
+void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	lockdep_assert_held(&rtwdev->mutex);
 
 	if (test_and_set_bit(RTW89_FLAG_LEISURE_PS, rtwdev->flags))
 		return;
 
-	__rtw89_enter_lps(rtwdev, mac_id);
-	__rtw89_enter_ps_mode(rtwdev);
+	__rtw89_enter_lps(rtwdev, rtwvif->mac_id);
+	__rtw89_enter_ps_mode(rtwdev, rtwvif);
 }
 
 static void rtw89_leave_lps_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
-	if (rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION)
+	if (rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION &&
+	    rtwvif->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT)
 		return;
 
 	__rtw89_leave_lps(rtwdev, rtwvif->mac_id);
diff --git a/drivers/net/wireless/realtek/rtw89/ps.h b/drivers/net/wireless/realtek/rtw89/ps.h
index a184b68994aa4..7d371293d6bc9 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.h
+++ b/drivers/net/wireless/realtek/rtw89/ps.h
@@ -5,7 +5,7 @@
 #ifndef __RTW89_PS_H_
 #define __RTW89_PS_H_
 
-void rtw89_enter_lps(struct rtw89_dev *rtwdev, u8 mac_id);
+void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 void rtw89_leave_lps(struct rtw89_dev *rtwdev);
 void __rtw89_leave_ps_mode(struct rtw89_dev *rtwdev);
 void rtw89_leave_ps_mode(struct rtw89_dev *rtwdev);
-- 
2.25.1

