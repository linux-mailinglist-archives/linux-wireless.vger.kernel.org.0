Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7DE698EAB
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Feb 2023 09:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBPI3R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Feb 2023 03:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPI3Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Feb 2023 03:29:16 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C622CC45
        for <linux-wireless@vger.kernel.org>; Thu, 16 Feb 2023 00:29:12 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31G8T2SD0022574, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31G8T2SD0022574
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 16 Feb 2023 16:29:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Feb 2023 16:28:42 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 16 Feb
 2023 16:28:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: fix AP mode authentication transmission failed
Date:   Thu, 16 Feb 2023 16:28:07 +0800
Message-ID: <20230216082807.22285-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

For some ICs, packets can't be sent correctly without initializing
CMAC table first. Previous flow do this initialization after
associated, results in authentication response fails to transmit.
Move the initialization up front to a proper place to solve this.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 47 +++++++++++++----------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 3ed2f3a966353..f09361bc4a4d1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2435,6 +2435,7 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	int i;
+	int ret;
 
 	rtwsta->rtwdev = rtwdev;
 	rtwsta->rtwvif = rtwvif;
@@ -2459,6 +2460,21 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 							    RTW89_MAX_MAC_ID_NUM);
 		if (rtwsta->mac_id == RTW89_MAX_MAC_ID_NUM)
 			return -ENOSPC;
+
+		ret = rtw89_mac_set_macid_pause(rtwdev, rtwsta->mac_id, false);
+		if (ret) {
+			rtw89_core_release_bit_map(rtwdev->mac_id_map, rtwsta->mac_id);
+			rtw89_warn(rtwdev, "failed to send h2c macid pause\n");
+			return ret;
+		}
+
+		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, rtwsta,
+						 RTW89_ROLE_CREATE);
+		if (ret) {
+			rtw89_core_release_bit_map(rtwdev->mac_id_map, rtwsta->mac_id);
+			rtw89_warn(rtwdev, "failed to send h2c role info\n");
+			return ret;
+		}
 	}
 
 	return 0;
@@ -2513,14 +2529,6 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
-	if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
-		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, rtwsta, RTW89_ROLE_REMOVE);
-		if (ret) {
-			rtw89_warn(rtwdev, "failed to send h2c role info\n");
-			return ret;
-		}
-	}
-
 	/* update cam aid mac_id net_type */
 	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
 	if (ret) {
@@ -2541,18 +2549,6 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 	int ret;
 
 	if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
-		ret = rtw89_mac_set_macid_pause(rtwdev, rtwsta->mac_id, false);
-		if (ret) {
-			rtw89_warn(rtwdev, "failed to send h2c macid pause\n");
-			return ret;
-		}
-
-		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, rtwsta, RTW89_ROLE_CREATE);
-		if (ret) {
-			rtw89_warn(rtwdev, "failed to send h2c role info\n");
-			return ret;
-		}
-
 		if (sta->tdls) {
 			ret = rtw89_cam_init_bssid_cam(rtwdev, rtwvif, bssid_cam, sta->addr);
 			if (ret) {
@@ -2622,13 +2618,22 @@ int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	int ret;
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
 					 BTC_ROLE_MSTS_STA_DIS_CONN);
-	else if (vif->type == NL80211_IFTYPE_AP || sta->tdls)
+	else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
 		rtw89_core_release_bit_map(rtwdev->mac_id_map, rtwsta->mac_id);
 
+		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, rtwsta,
+						 RTW89_ROLE_REMOVE);
+		if (ret) {
+			rtw89_warn(rtwdev, "failed to send h2c role info\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.25.1

