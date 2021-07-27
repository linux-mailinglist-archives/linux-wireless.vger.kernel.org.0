Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279BA3D727C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 12:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhG0KB1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 06:01:27 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37425 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbhG0KBX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 06:01:23 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16RA1H1c8008692, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16RA1H1c8008692
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Jul 2021 18:01:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 27 Jul 2021 18:01:17 +0800
Received: from localhost (172.16.21.11) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 27 Jul
 2021 18:01:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>
Subject: [PATCH 2/4] rtw88: refine the setting of rsvd pages for different firmware
Date:   Tue, 27 Jul 2021 18:00:44 +0800
Message-ID: <20210727100046.30116-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727100046.30116-1-pkshih@realtek.com>
References: <20210727100046.30116-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 07/27/2021 09:43:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMjcgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/27/2021 09:41:26
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165266 [Jul 27 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 449 449 5db59deca4a4f5e6ea34a93b13bc730e229092f4
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/27/2021 09:43:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

The original setting of rsvd pages is compilcated and lead to
error for connecting to AP after resuming from pno mode.
We refine the setting based on different firmware and the link state
to avoid it.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/wow.c | 40 ++++++++++--------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/wow.c b/drivers/net/wireless/realtek/rtw88/wow.c
index bdccfa70dddc..23ae7dcd92f7 100644
--- a/drivers/net/wireless/realtek/rtw88/wow.c
+++ b/drivers/net/wireless/realtek/rtw88/wow.c
@@ -443,37 +443,31 @@ static void rtw_wow_fw_media_status(struct rtw_dev *rtwdev, bool connect)
 	rtw_iterate_stas_atomic(rtwdev, rtw_wow_fw_media_status_iter, &data);
 }
 
-static void rtw_wow_config_pno_rsvd_page(struct rtw_dev *rtwdev,
-					 struct rtw_vif *rtwvif)
+static int rtw_wow_config_wow_fw_rsvd_page(struct rtw_dev *rtwdev)
 {
-	rtw_add_rsvd_page_pno(rtwdev, rtwvif);
-}
-
-static void rtw_wow_config_linked_rsvd_page(struct rtw_dev *rtwdev,
-					   struct rtw_vif *rtwvif)
-{
-	rtw_add_rsvd_page_sta(rtwdev, rtwvif);
-}
+	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+	struct rtw_vif *rtwvif = (struct rtw_vif *)wow_vif->drv_priv;
 
-static void rtw_wow_config_rsvd_page(struct rtw_dev *rtwdev,
-				     struct rtw_vif *rtwvif)
-{
 	rtw_remove_rsvd_page(rtwdev, rtwvif);
 
-	if (rtw_wow_mgd_linked(rtwdev)) {
-		rtw_wow_config_linked_rsvd_page(rtwdev, rtwvif);
-	} else if (test_bit(RTW_FLAG_WOWLAN, rtwdev->flags) &&
-		   rtw_wow_no_link(rtwdev)) {
-		rtw_wow_config_pno_rsvd_page(rtwdev, rtwvif);
-	}
+	if (rtw_wow_no_link(rtwdev))
+		rtw_add_rsvd_page_pno(rtwdev, rtwvif);
+	else
+		rtw_add_rsvd_page_sta(rtwdev, rtwvif);
+
+	return rtw_fw_download_rsvd_page(rtwdev);
 }
 
-static int rtw_wow_dl_fw_rsvd_page(struct rtw_dev *rtwdev)
+static int rtw_wow_config_normal_fw_rsvd_page(struct rtw_dev *rtwdev)
 {
 	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
 	struct rtw_vif *rtwvif = (struct rtw_vif *)wow_vif->drv_priv;
 
-	rtw_wow_config_rsvd_page(rtwdev, rtwvif);
+	rtw_remove_rsvd_page(rtwdev, rtwvif);
+	rtw_add_rsvd_page_sta(rtwdev, rtwvif);
+
+	if (rtw_wow_no_link(rtwdev))
+		return 0;
 
 	return rtw_fw_download_rsvd_page(rtwdev);
 }
@@ -671,7 +665,7 @@ static int rtw_wow_enable(struct rtw_dev *rtwdev)
 
 	set_bit(RTW_FLAG_WOWLAN, rtwdev->flags);
 
-	ret = rtw_wow_dl_fw_rsvd_page(rtwdev);
+	ret = rtw_wow_config_wow_fw_rsvd_page(rtwdev);
 	if (ret) {
 		rtw_err(rtwdev, "failed to download wowlan rsvd page\n");
 		goto error;
@@ -744,7 +738,7 @@ static int rtw_wow_disable(struct rtw_dev *rtwdev)
 		goto out;
 	}
 
-	ret = rtw_wow_dl_fw_rsvd_page(rtwdev);
+	ret = rtw_wow_config_normal_fw_rsvd_page(rtwdev);
 	if (ret)
 		rtw_err(rtwdev, "failed to download normal rsvd page\n");
 
-- 
2.25.1

