Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4EE368F56
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 11:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbhDWJ2H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 05:28:07 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45143 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhDWJ2G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 05:28:06 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13N9ROrW4002951, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13N9ROrW4002951
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Apr 2021 17:27:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 23 Apr 2021 17:27:23 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 23 Apr
 2021 17:27:22 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH v3 3/3] rtw88: 8822c: fix lc calibration timing
Date:   Fri, 23 Apr 2021 17:26:56 +0800
Message-ID: <20210423092656.20603-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210423092656.20603-1-pkshih@realtek.com>
References: <20210423092656.20603-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMjMgpFekyCAwNjoxOTowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/23/2021 09:13:16
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163299 [Apr 22 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 443 443 d64ad0ad6f66abd85f8fb55fe5d831fdcc4c44a0
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/23/2021 09:16:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/23/2021 09:13:16
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163299 [Apr 22 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 443 443 d64ad0ad6f66abd85f8fb55fe5d831fdcc4c44a0
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/23/2021 09:16:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Before this patch, we use value from 2 seconds ago to decide
whether we should do lc calibration.
Although this don't happen frequently, fix flow to the way it should be.

Fixes: 7ae7784ec2a8 ("rtw88: 8822c: add LC calibration for RTL8822C")
Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3: no change
v2: no change
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index b6b43654e5c6..436347f3b60f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4395,26 +4395,28 @@ static void rtw8822c_pwrtrack_set(struct rtw_dev *rtwdev, u8 rf_path)
 	}
 }
 
-static void rtw8822c_pwr_track_path(struct rtw_dev *rtwdev,
-				    struct rtw_swing_table *swing_table,
-				    u8 path)
+static void rtw8822c_pwr_track_stats(struct rtw_dev *rtwdev, u8 path)
 {
-	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
-	u8 thermal_value, delta;
+	u8 thermal_value;
 
 	if (rtwdev->efuse.thermal_meter[path] == 0xff)
 		return;
 
 	thermal_value = rtw_read_rf(rtwdev, path, RF_T_METER, 0x7e);
-
 	rtw_phy_pwrtrack_avg(rtwdev, thermal_value, path);
+}
 
-	delta = rtw_phy_pwrtrack_get_delta(rtwdev, path);
+static void rtw8822c_pwr_track_path(struct rtw_dev *rtwdev,
+				    struct rtw_swing_table *swing_table,
+				    u8 path)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 delta;
 
+	delta = rtw_phy_pwrtrack_get_delta(rtwdev, path);
 	dm_info->delta_power_index[path] =
 		rtw_phy_pwrtrack_get_pwridx(rtwdev, swing_table, path, path,
 					    delta);
-
 	rtw8822c_pwrtrack_set(rtwdev, path);
 }
 
@@ -4425,12 +4427,12 @@ static void __rtw8822c_pwr_track(struct rtw_dev *rtwdev)
 
 	rtw_phy_config_swing_table(rtwdev, &swing_table);
 
+	for (i = 0; i < rtwdev->hal.rf_path_num; i++)
+		rtw8822c_pwr_track_stats(rtwdev, i);
 	if (rtw_phy_pwrtrack_need_lck(rtwdev))
 		rtw8822c_do_lck(rtwdev);
-
 	for (i = 0; i < rtwdev->hal.rf_path_num; i++)
 		rtw8822c_pwr_track_path(rtwdev, &swing_table, i);
-
 }
 
 static void rtw8822c_pwr_track(struct rtw_dev *rtwdev)
-- 
2.21.0

