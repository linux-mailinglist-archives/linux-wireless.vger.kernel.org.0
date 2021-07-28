Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D6D3D8595
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jul 2021 03:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhG1BoT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 21:44:19 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55224 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbhG1BoP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 21:44:15 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16S1i9jpD031138, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16S1i9jpD031138
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Jul 2021 09:44:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 28 Jul 2021 09:44:08 +0800
Received: from localhost (172.16.21.11) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 28 Jul
 2021 09:44:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>
Subject: [PATCH v2 4/5] rtw88: wow: report wow reason through mac80211 api
Date:   Wed, 28 Jul 2021 09:43:34 +0800
Message-ID: <20210728014335.8785-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728014335.8785-1-pkshih@realtek.com>
References: <20210728014335.8785-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.21.11]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/28/2021 01:31:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMjcgpFWkyCAwNzo0MjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/28/2021 01:28:11
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165288 [Jul 28 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 449 449 5db59deca4a4f5e6ea34a93b13bc730e229092f4
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/28/2021 01:31:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

After waking up from WoWLAN, call ieee80211_report_wowlan_wakeup
function call to report wakeup reason to userspace via nl80211.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/wow.c | 46 +++++++++++++++++++-----
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/wow.c b/drivers/net/wireless/realtek/rtw88/wow.c
index 23ae7dcd92f7..89dc595094d5 100644
--- a/drivers/net/wireless/realtek/rtw88/wow.c
+++ b/drivers/net/wireless/realtek/rtw88/wow.c
@@ -12,26 +12,54 @@
 
 static void rtw_wow_show_wakeup_reason(struct rtw_dev *rtwdev)
 {
+	struct cfg80211_wowlan_nd_info nd_info;
+	struct cfg80211_wowlan_wakeup wakeup = {
+		.pattern_idx = -1,
+	};
 	u8 reason;
 
 	reason = rtw_read8(rtwdev, REG_WOWLAN_WAKE_REASON);
 
-	if (reason == RTW_WOW_RSN_RX_DEAUTH)
+	switch (reason) {
+	case RTW_WOW_RSN_RX_DEAUTH:
+		wakeup.disconnect = true;
 		rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx deauth\n");
-	else if (reason == RTW_WOW_RSN_DISCONNECT)
+		break;
+	case RTW_WOW_RSN_DISCONNECT:
+		wakeup.disconnect = true;
 		rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: AP is off\n");
-	else if (reason == RTW_WOW_RSN_RX_MAGIC_PKT)
+		break;
+	case RTW_WOW_RSN_RX_MAGIC_PKT:
+		wakeup.magic_pkt = true;
 		rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx magic packet\n");
-	else if (reason == RTW_WOW_RSN_RX_GTK_REKEY)
+		break;
+	case RTW_WOW_RSN_RX_GTK_REKEY:
+		wakeup.gtk_rekey_failure = true;
 		rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx gtk rekey\n");
-	else if (reason == RTW_WOW_RSN_RX_PTK_REKEY)
-		rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx ptk rekey\n");
-	else if (reason == RTW_WOW_RSN_RX_PATTERN_MATCH)
+		break;
+	case RTW_WOW_RSN_RX_PATTERN_MATCH:
+		/* Current firmware and driver don't report pattern index
+		 * Use pattern_idx to 0 defaultly.
+		 */
+		wakeup.pattern_idx = 0;
 		rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx pattern match packet\n");
-	else if (reason == RTW_WOW_RSN_RX_NLO)
+		break;
+	case RTW_WOW_RSN_RX_NLO:
+		/* Current firmware and driver don't report ssid index.
+		 * Use 0 for n_matches based on its comment.
+		 */
+		nd_info.n_matches = 0;
+		wakeup.net_detect = &nd_info;
 		rtw_dbg(rtwdev, RTW_DBG_WOW, "Rx NLO\n");
-	else
+		break;
+	default:
 		rtw_warn(rtwdev, "Unknown wakeup reason %x\n", reason);
+		ieee80211_report_wowlan_wakeup(rtwdev->wow.wow_vif, NULL,
+					       GFP_KERNEL);
+		return;
+	}
+	ieee80211_report_wowlan_wakeup(rtwdev->wow.wow_vif, &wakeup,
+				       GFP_KERNEL);
 }
 
 static void rtw_wow_pattern_write_cam(struct rtw_dev *rtwdev, u8 addr,
-- 
2.25.1

