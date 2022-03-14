Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0795E4D7B5F
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 08:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiCNHO4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 03:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiCNHOz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 03:14:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A68E092
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 00:13:45 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22E7Dcj06003281, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22E7Dcj06003281
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Mar 2022 15:13:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 14 Mar 2022 15:13:38 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Mar
 2022 15:13:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 1/8] rtw89: ser: fix CAM leaks occurring in L2 reset
Date:   Mon, 14 Mar 2022 15:12:43 +0800
Message-ID: <20220314071250.40292-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220314071250.40292-1-pkshih@realtek.com>
References: <20220314071250.40292-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/14/2022 06:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTQgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The CAM, meaning address CAM and bssid CAM here, will get leaks during
SER (system error recover) L2 reset process and ieee80211_restart_hw()
which is called by L2 reset process eventually.

The normal flow would be like
-> add interface (acquire 1)
-> enter ips (release 1)
-> leave ips (acquire 1)
-> connection (occupy 1) <(A) 1 leak after L2 reset if non-sec connection>

The ieee80211_restart_hw() flow (under connection)
-> ieee80211 reconfig
-> add interface (acquire 1)
-> leave ips (acquire 1)
-> connection (occupy (A) + 2) <(B) 1 more leak>

Originally, CAM is released before HW restart only if connection is under
security. Now, release CAM whatever connection it is to fix leak in (A).
OTOH, check if CAM is already valid to avoid acquiring multiple times to
fix (B).

Besides, if AP mode, release address CAM of all stations before HW restart.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c | 14 ++++++++++++--
 drivers/net/wireless/realtek/rtw89/ser.c | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 305dbbebff6bb..26bef9fdd2053 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -421,10 +421,8 @@ static void rtw89_cam_reset_key_iter(struct ieee80211_hw *hw,
 				     void *data)
 {
 	struct rtw89_dev *rtwdev = (struct rtw89_dev *)data;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 
 	rtw89_cam_sec_key_del(rtwdev, vif, sta, key, false);
-	rtw89_cam_deinit(rtwdev, rtwvif);
 }
 
 void rtw89_cam_deinit_addr_cam(struct rtw89_dev *rtwdev,
@@ -480,6 +478,12 @@ int rtw89_cam_init_addr_cam(struct rtw89_dev *rtwdev,
 	int i;
 	int ret;
 
+	if (unlikely(addr_cam->valid)) {
+		rtw89_debug(rtwdev, RTW89_DBG_FW,
+			    "addr cam is already valid; skip init\n");
+		return 0;
+	}
+
 	ret = rtw89_cam_get_avail_addr_cam(rtwdev, &addr_cam_idx);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to get available addr cam\n");
@@ -531,6 +535,12 @@ static int rtw89_cam_init_bssid_cam(struct rtw89_dev *rtwdev,
 	u8 bssid_cam_idx;
 	int ret;
 
+	if (unlikely(bssid_cam->valid)) {
+		rtw89_debug(rtwdev, RTW89_DBG_FW,
+			    "bssid cam is already valid; skip init\n");
+		return 0;
+	}
+
 	ret = rtw89_cam_get_avail_bssid_cam(rtwdev, &bssid_cam_idx);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to get available bssid cam\n");
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 837cdc366a61a..e86f3d89ef1bf 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -220,11 +220,32 @@ static void ser_reset_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtwvif->trigger = false;
 }
 
+static void ser_sta_deinit_addr_cam_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw89_dev *rtwdev = (struct rtw89_dev *)data;
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+
+	rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta->addr_cam);
+}
+
+static void ser_deinit_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
+		ieee80211_iterate_stations_atomic(rtwdev->hw,
+						  ser_sta_deinit_addr_cam_iter,
+						  rtwdev);
+
+	rtw89_cam_deinit(rtwdev, rtwvif);
+}
+
 static void ser_reset_mac_binding(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_vif *rtwvif;
 
 	rtw89_cam_reset_keys(rtwdev);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		ser_deinit_cam(rtwdev, rtwvif);
+
 	rtw89_core_release_all_bits_map(rtwdev->mac_id_map, RTW89_MAX_MAC_ID_NUM);
 	rtw89_for_each_rtwvif(rtwdev, rtwvif)
 		ser_reset_vif(rtwdev, rtwvif);
-- 
2.25.1

