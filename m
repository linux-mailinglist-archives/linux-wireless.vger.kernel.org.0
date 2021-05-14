Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571A43804BB
	for <lists+linux-wireless@lfdr.de>; Fri, 14 May 2021 09:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhENH4v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 May 2021 03:56:51 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42831 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhENH4u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 May 2021 03:56:50 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 14E7tYPf9027710, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 14E7tYPf9027710
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 May 2021 15:55:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 14 May 2021 15:55:33 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 14 May
 2021 15:55:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>
Subject: [PATCH 1/2] rtw88: add rtw_fw_feature_check api
Date:   Fri, 14 May 2021 15:55:16 +0800
Message-ID: <20210514075517.14216-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210514075517.14216-1-pkshih@realtek.com>
References: <20210514075517.14216-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXH36501.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzUvMTQgpFekyCAwNjowMDowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/14/2021 07:33:30
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163650 [May 14 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/14/2021 07:36:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/14/2021 07:43:34
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163650 [May 14 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/14/2021 07:46:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

add api to check if a certain feature is supported.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 3 +--
 drivers/net/wireless/realtek/rtw88/fw.h       | 6 ++++++
 drivers/net/wireless/realtek/rtw88/mac80211.c | 3 +--
 drivers/net/wireless/realtek/rtw88/main.c     | 4 ++--
 drivers/net/wireless/realtek/rtw88/ps.c       | 4 ++--
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 797b08b2a494..00c56ab6306b 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -584,10 +584,9 @@ void rtw_fw_beacon_filter_config(struct rtw_dev *rtwdev, bool connect,
 	struct rtw_sta_info *si =
 		sta ? (struct rtw_sta_info *)sta->drv_priv : NULL;
 	s32 threshold = bss_conf->cqm_rssi_thold + rssi_offset;
-	struct rtw_fw_state *fw = &rtwdev->fw;
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
 
-	if (!(fw->feature & FW_FEATURE_BCN_FILTER))
+	if (!rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_BCN_FILTER))
 		return;
 
 	if (!connect) {
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 3bfee27b1e1a..832ef2bfe5f9 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -591,6 +591,12 @@ static inline struct rtw_c2h_cmd *get_c2h_from_skb(struct sk_buff *skb)
 	return (struct rtw_c2h_cmd *)(skb->data + pkt_offset);
 }
 
+static inline bool rtw_fw_feature_check(struct rtw_fw_state *fw,
+					enum rtw_fw_feature feature)
+{
+	return !!(fw->feature & feature);
+}
+
 void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
 			       struct sk_buff *skb);
 void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb);
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 9087c5b1ea80..8f46b16c8d5d 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -148,13 +148,12 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 {
 	struct rtw_dev *rtwdev = hw->priv;
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
-	struct rtw_fw_state *fw = &rtwdev->fw;
 	enum rtw_net_type net_type;
 	u32 config = 0;
 	u8 port = 0;
 	u8 bcn_ctrl = 0;
 
-	if (fw->feature & FW_FEATURE_BCN_FILTER)
+	if (rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_BCN_FILTER))
 		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER |
 				     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 	rtwvif->port = port;
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 94fadef5c131..df115bb7fdf7 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1111,11 +1111,11 @@ static enum rtw_lps_deep_mode rtw_update_lps_deep_mode(struct rtw_dev *rtwdev,
 		return LPS_DEEP_MODE_NONE;
 
 	if ((chip->lps_deep_mode_supported & BIT(LPS_DEEP_MODE_PG)) &&
-	    (fw->feature & FW_FEATURE_PG))
+	    rtw_fw_feature_check(fw, FW_FEATURE_PG))
 		return LPS_DEEP_MODE_PG;
 
 	if ((chip->lps_deep_mode_supported & BIT(LPS_DEEP_MODE_LCLK)) &&
-	    (fw->feature & FW_FEATURE_LCLK))
+	    rtw_fw_feature_check(fw, FW_FEATURE_LCLK))
 		return LPS_DEEP_MODE_LCLK;
 
 	return LPS_DEEP_MODE_NONE;
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 3bead34c3d10..3f0ac33156d6 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -152,7 +152,7 @@ static void rtw_fw_leave_lps_check(struct rtw_dev *rtwdev)
 	else
 		fw = &rtwdev->fw;
 
-	if (fw->feature & FW_FEATURE_LPS_C2H)
+	if (rtw_fw_feature_check(fw, FW_FEATURE_LPS_C2H))
 		ret = __rtw_fw_leave_lps_check_c2h(rtwdev);
 	else
 		ret = __rtw_fw_leave_lps_check_reg(rtwdev);
@@ -172,7 +172,7 @@ static void rtw_fw_leave_lps_check_prepare(struct rtw_dev *rtwdev)
 	else
 		fw = &rtwdev->fw;
 
-	if (fw->feature & FW_FEATURE_LPS_C2H)
+	if (rtw_fw_feature_check(fw, FW_FEATURE_LPS_C2H))
 		reinit_completion(&rtwdev->lps_leave_check);
 }
 
-- 
2.21.0

