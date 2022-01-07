Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7520487163
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 04:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbiAGDnd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 22:43:33 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51119 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345910AbiAGDn3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 22:43:29 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2073hO791023024, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2073hO791023024
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Jan 2022 11:43:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 7 Jan 2022 11:43:24 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 11:43:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 16/19] rtw89: maintain assoc/disassoc STA states of firmware and hardware
Date:   Fri, 7 Jan 2022 11:42:36 +0800
Message-ID: <20220107034239.22002-17-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107034239.22002-1-pkshih@realtek.com>
References: <20220107034239.22002-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/07/2022 03:26:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvNyCkV6TIIDAxOjMzOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
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
index 4756a2e7a2389..d23bd87661d7a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1943,6 +1943,8 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 	rtw89_mac_bf_monitor_calc(rtwdev, sta, true);
 	rtw89_mac_bf_disassoc(rtwdev, vif, sta);
 	rtw89_core_free_sta_pending_ba(rtwdev, sta);
+	if (vif->type == NL80211_IFTYPE_AP)
+		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta->addr_cam);
 
 	if (vif->type == NL80211_IFTYPE_STATION)
 		rtw89_vif_type_mapping(vif, false);
@@ -1959,8 +1961,16 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
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
@@ -1977,6 +1987,25 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
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
index 19eb8ea1ba915..17a41fddc62e4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2705,7 +2705,7 @@ static void rtw89_mac_cmac_tbl_init(struct rtw89_dev *rtwdev, u8 macid)
 	rtw89_write32(rtwdev, R_AX_INDIR_ACCESS_ENTRY + 28, 0xB8109);
 }
 
-static int rtw89_set_macid_pause(struct rtw89_dev *rtwdev, u8 macid, bool pause)
+int rtw89_mac_set_macid_pause(struct rtw89_dev *rtwdev, u8 macid, bool pause)
 {
 	u8 sh =  FIELD_GET(GENMASK(4, 0), macid);
 	u8 grp = macid >> 5;
@@ -3008,7 +3008,7 @@ int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_mac_dmac_tbl_init(rtwdev, rtwvif->mac_id);
 	rtw89_mac_cmac_tbl_init(rtwdev, rtwvif->mac_id);
 
-	ret = rtw89_set_macid_pause(rtwdev, rtwvif->mac_id, false);
+	ret = rtw89_mac_set_macid_pause(rtwdev, rtwvif->mac_id, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 65e4ebe05f6ad..ead385c53331b 100644
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

