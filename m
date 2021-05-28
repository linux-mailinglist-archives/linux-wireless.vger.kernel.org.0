Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA41393BED
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 05:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbhE1Daz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 May 2021 23:30:55 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39342 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbhE1Dax (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 May 2021 23:30:53 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 14S3TDyhC003337, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 14S3TDyhC003337
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 28 May 2021 11:29:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 28 May 2021 11:29:13 +0800
Received: from localhost (172.16.16.242) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 28 May
 2021 11:29:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 2/2] rtw88: refine unwanted h2c command
Date:   Fri, 28 May 2021 11:29:01 +0800
Message-ID: <20210528032901.12927-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528032901.12927-1-pkshih@realtek.com>
References: <20210528032901.12927-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.242]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/28/2021 03:11:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzUvMjggpFekyCAwMjoxOTowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Antivirus-Attachment-Filter-Interceptor-Info: license violation
X-KSE-AntiSpam-Interceptor-Info: bases corrupted
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Don't send beacon filter h2c when there is no valid context.
Return early instead of printing out warning messages, so others
won't get confused.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 58f4e47aa96a..176e8b67530e 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -601,7 +601,7 @@ void rtw_fw_beacon_filter_config(struct rtw_dev *rtwdev, bool connect,
 	s32 threshold = bss_conf->cqm_rssi_thold + rssi_offset;
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
 
-	if (!rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_BCN_FILTER))
+	if (!rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_BCN_FILTER) || !si)
 		return;
 
 	if (!connect) {
@@ -623,10 +623,7 @@ void rtw_fw_beacon_filter_config(struct rtw_dev *rtwdev, bool connect,
 					       BCN_FILTER_OFFLOAD_MODE_DEFAULT);
 	SET_BCN_FILTER_OFFLOAD_P1_THRESHOLD(h2c_pkt, (u8)threshold);
 	SET_BCN_FILTER_OFFLOAD_P1_BCN_LOSS_CNT(h2c_pkt, BCN_LOSS_CNT);
-	if (si)
-		SET_BCN_FILTER_OFFLOAD_P1_MACID(h2c_pkt, si->mac_id);
-	else
-		rtw_warn(rtwdev, "CQM config with station not found\n");
+	SET_BCN_FILTER_OFFLOAD_P1_MACID(h2c_pkt, si->mac_id);
 	SET_BCN_FILTER_OFFLOAD_P1_HYST(h2c_pkt, bss_conf->cqm_rssi_hyst);
 	SET_BCN_FILTER_OFFLOAD_P1_BCN_INTERVAL(h2c_pkt, bss_conf->beacon_int);
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
-- 
2.25.1

