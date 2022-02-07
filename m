Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AE34AB57D
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 08:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbiBGHDi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 02:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357059AbiBGGnM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 01:43:12 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C52C043184
        for <linux-wireless@vger.kernel.org>; Sun,  6 Feb 2022 22:43:10 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2176e5TC1024675, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2176e5TC1024675
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Feb 2022 14:40:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 7 Feb 2022 14:40:05 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 7 Feb
 2022 14:40:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/7] rtw89: maintain assoc/disassoc STA states of firmware and hardware
Date:   Mon, 7 Feb 2022 14:38:57 +0800
Message-ID: <20220207063900.43643-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207063900.43643-1-pkshih@realtek.com>
References: <20220207063900.43643-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/07/2022 06:18:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvNyCkV6TIIDAzOjUyOjAw?=
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

In AP mode, when a STA associate to us, we need to create an entry in
firmware and hardware, and then they can transmit data properly.

The entry index called mac_id which is assigned when sta_add, and we ask
firmware to create an entry for an associated station. Also, the address
CAM should be filled so hardware can know which packet is ours, and lookup
the mac_id for further use.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 31 ++++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c  |  4 +--
 drivers/net/wireless/realtek/rtw89/mac.h  |  1 +
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 8849f3172a341..413bb391c21e3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2046,6 +2046,8 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 	rtw89_mac_bf_monitor_calc(rtwdev, sta, true);
 	rtw89_mac_bf_disassoc(rtwdev, vif, sta);
 	rtw89_core_free_sta_pending_ba(rtwdev, sta);
+	if (vif->type == NL80211_IFTYPE_AP)
+		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta->addr_cam);
 
 	if (vif->type == NL80211_IFTYPE_STATION)
 		rtw89_vif_type_mapping(vif, false);
@@ -2062,8 +2064,16 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
+	if (vif->type == NL80211_IFTYPE_AP) {
+		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, rtwsta, RTW89_ROLE_REMOVE);
+		if (ret) {
+			rtw89_warn(rtwdev, "failed to send h2c role info\n");
+			return ret;
+		}
+	}
+
 	/* update cam aid mac_id net_type */
-	rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
@@ -2080,6 +2090,25 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	int ret;
 
+	if (vif->type == NL80211_IFTYPE_AP) {
+		ret = rtw89_mac_set_macid_pause(rtwdev, rtwsta->mac_id, false);
+		if (ret) {
+			rtw89_warn(rtwdev, "failed to send h2c macid pause\n");
+			return ret;
+		}
+
+		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, rtwsta, RTW89_ROLE_CREATE);
+		if (ret) {
+			rtw89_warn(rtwdev, "failed to send h2c role info\n");
+			return ret;
+		}
+
+		ret = rtw89_cam_init_addr_cam(rtwdev, &rtwsta->addr_cam, &rtwvif->bssid_cam);
+		if (ret) {
+			rtw89_warn(rtwdev, "failed to send h2c init addr cam\n");
+			return ret;
+		}
+	}
 
 	ret = rtw89_fw_h2c_assoc_cmac_tbl(rtwdev, vif, sta);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 2ced6a8b36c2d..3cd208d05c7c0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2718,7 +2718,7 @@ static void rtw89_mac_cmac_tbl_init(struct rtw89_dev *rtwdev, u8 macid)
 	rtw89_write32(rtwdev, R_AX_INDIR_ACCESS_ENTRY + 28, 0xB8109);
 }
 
-static int rtw89_set_macid_pause(struct rtw89_dev *rtwdev, u8 macid, bool pause)
+int rtw89_mac_set_macid_pause(struct rtw89_dev *rtwdev, u8 macid, bool pause)
 {
 	u8 sh =  FIELD_GET(GENMASK(4, 0), macid);
 	u8 grp = macid >> 5;
@@ -3021,7 +3021,7 @@ int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_mac_dmac_tbl_init(rtwdev, rtwvif->mac_id);
 	rtw89_mac_cmac_tbl_init(rtwdev, rtwvif->mac_id);
 
-	ret = rtw89_set_macid_pause(rtwdev, rtwvif->mac_id, false);
+	ret = rtw89_mac_set_macid_pause(rtwdev, rtwvif->mac_id, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 9fe7629f1da16..e5db0a2eb9c29 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -811,6 +811,7 @@ int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_mac_vif_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_mac_set_hw_muedca_ctrl(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif, bool en);
+int rtw89_mac_set_macid_pause(struct rtw89_dev *rtwdev, u8 macid, bool pause);
 
 static inline void rtw89_mac_bf_monitor_track(struct rtw89_dev *rtwdev)
 {
-- 
2.25.1

