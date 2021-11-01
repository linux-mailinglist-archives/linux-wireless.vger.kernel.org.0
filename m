Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3639344176E
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Nov 2021 10:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhKAJgT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Nov 2021 05:36:19 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:58720 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhKAJeO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Nov 2021 05:34:14 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1A19VawR6011855, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1A19VawR6011855
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 1 Nov 2021 17:31:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 1 Nov 2021 17:31:35 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 17:31:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH v2 2/4] rtw89: update rtw89 regulation definition to R58-R31
Date:   Mon, 1 Nov 2021 17:31:04 +0800
Message-ID: <20211101093106.28848-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211101093106.28848-1-pkshih@realtek.com>
References: <20211101093106.28848-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 11/01/2021 09:11:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzEgpFekyCAwODoxOTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/01/2021 09:07:58
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167015 [Nov 01 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/01/2021 09:11:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Support QATAR in rtw89_regulation_type and reorder the enum to align
realtek R58-R31 regulation definition. Besides, if an unassigned entry
of limit/limit_ru tables is read, return the corresponding WW value for
the unconfigured case.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  9 +++++----
 drivers/net/wireless/realtek/rtw89/phy.c  | 12 ++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c2885e4dd882..3729abda04f9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -411,12 +411,13 @@ enum rtw89_regulation_type {
 	RTW89_NA	= 4,
 	RTW89_IC	= 5,
 	RTW89_KCC	= 6,
-	RTW89_NCC	= 7,
-	RTW89_CHILE	= 8,
-	RTW89_ACMA	= 9,
-	RTW89_MEXICO	= 10,
+	RTW89_ACMA	= 7,
+	RTW89_NCC	= 8,
+	RTW89_MEXICO	= 9,
+	RTW89_CHILE	= 10,
 	RTW89_UKRAINE	= 11,
 	RTW89_CN	= 12,
+	RTW89_QATAR	= 13,
 	RTW89_REGD_NUM,
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index ab134856baac..0620ef02e275 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1099,9 +1099,15 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev,
 	switch (band) {
 	case RTW89_BAND_2G:
 		lmt = (*chip->txpwr_lmt_2g)[bw][ntx][rs][bf][regd][ch_idx];
+		if (!lmt)
+			lmt = (*chip->txpwr_lmt_2g)[bw][ntx][rs][bf]
+						   [RTW89_WW][ch_idx];
 		break;
 	case RTW89_BAND_5G:
 		lmt = (*chip->txpwr_lmt_5g)[bw][ntx][rs][bf][regd][ch_idx];
+		if (!lmt)
+			lmt = (*chip->txpwr_lmt_5g)[bw][ntx][rs][bf]
+						   [RTW89_WW][ch_idx];
 		break;
 	default:
 		rtw89_warn(rtwdev, "unknown band type: %d\n", band);
@@ -1224,9 +1230,15 @@ static s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 	switch (band) {
 	case RTW89_BAND_2G:
 		lmt_ru = (*chip->txpwr_lmt_ru_2g)[ru][ntx][regd][ch_idx];
+		if (!lmt_ru)
+			lmt_ru = (*chip->txpwr_lmt_ru_2g)[ru][ntx]
+							 [RTW89_WW][ch_idx];
 		break;
 	case RTW89_BAND_5G:
 		lmt_ru = (*chip->txpwr_lmt_ru_5g)[ru][ntx][regd][ch_idx];
+		if (!lmt_ru)
+			lmt_ru = (*chip->txpwr_lmt_ru_5g)[ru][ntx]
+							 [RTW89_WW][ch_idx];
 		break;
 	default:
 		rtw89_warn(rtwdev, "unknown band type: %d\n", band);
-- 
2.25.1

