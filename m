Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF2B5005E2
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Apr 2022 08:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbiDNGXh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Apr 2022 02:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240014AbiDNGXc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Apr 2022 02:23:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFB537028
        for <linux-wireless@vger.kernel.org>; Wed, 13 Apr 2022 23:21:06 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23E6KwMP2001338, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23E6KwMP2001338
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Apr 2022 14:20:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 14:20:58 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 14 Apr
 2022 14:20:57 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 03/12] rtw89: 8852c: add TX power track tables
Date:   Thu, 14 Apr 2022 14:20:17 +0800
Message-ID: <20220414062027.62638-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414062027.62638-1-pkshih@realtek.com>
References: <20220414062027.62638-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/14/2022 06:05:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMTQgpFekyCAwMzo1OTowMA==?=
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

TX power track tables are used to do TX power compensation according to
thermal value. In order to work in existing and new chip, add new 6G
entries, and change type from u8 to s8.

Internal version table is HALRF_027_00_031.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.h      |  28 ++--
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |   8 +-
 .../wireless/realtek/rtw89/rtw8852a_table.c   |  24 +--
 .../wireless/realtek/rtw89/rtw8852c_table.c   | 139 ++++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852c_table.h   |   1 +
 5 files changed, 172 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index adcfcb4c24296..9c97e77d97072 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -233,18 +233,22 @@ struct rtw89_txpwr_byrate_cfg {
 #define DELTA_SWINGIDX_SIZE 30
 
 struct rtw89_txpwr_track_cfg {
-	const u8 (*delta_swingidx_5gb_n)[DELTA_SWINGIDX_SIZE];
-	const u8 (*delta_swingidx_5gb_p)[DELTA_SWINGIDX_SIZE];
-	const u8 (*delta_swingidx_5ga_n)[DELTA_SWINGIDX_SIZE];
-	const u8 (*delta_swingidx_5ga_p)[DELTA_SWINGIDX_SIZE];
-	const u8 *delta_swingidx_2gb_n;
-	const u8 *delta_swingidx_2gb_p;
-	const u8 *delta_swingidx_2ga_n;
-	const u8 *delta_swingidx_2ga_p;
-	const u8 *delta_swingidx_2g_cck_b_n;
-	const u8 *delta_swingidx_2g_cck_b_p;
-	const u8 *delta_swingidx_2g_cck_a_n;
-	const u8 *delta_swingidx_2g_cck_a_p;
+	const s8 (*delta_swingidx_6gb_n)[DELTA_SWINGIDX_SIZE];
+	const s8 (*delta_swingidx_6gb_p)[DELTA_SWINGIDX_SIZE];
+	const s8 (*delta_swingidx_6ga_n)[DELTA_SWINGIDX_SIZE];
+	const s8 (*delta_swingidx_6ga_p)[DELTA_SWINGIDX_SIZE];
+	const s8 (*delta_swingidx_5gb_n)[DELTA_SWINGIDX_SIZE];
+	const s8 (*delta_swingidx_5gb_p)[DELTA_SWINGIDX_SIZE];
+	const s8 (*delta_swingidx_5ga_n)[DELTA_SWINGIDX_SIZE];
+	const s8 (*delta_swingidx_5ga_p)[DELTA_SWINGIDX_SIZE];
+	const s8 *delta_swingidx_2gb_n;
+	const s8 *delta_swingidx_2gb_p;
+	const s8 *delta_swingidx_2ga_n;
+	const s8 *delta_swingidx_2ga_p;
+	const s8 *delta_swingidx_2g_cck_b_n;
+	const s8 *delta_swingidx_2g_cck_b_p;
+	const s8 *delta_swingidx_2g_cck_a_n;
+	const s8 *delta_swingidx_2g_cck_a_p;
 };
 
 struct rtw89_phy_dig_gain_cfg {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index ad272854c442f..aa782534e76be 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -2907,10 +2907,10 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
 	u8 ch = rtwdev->hal.current_channel;
 	u8 subband = rtwdev->hal.current_subband;
-	const u8 *thm_up_a = NULL;
-	const u8 *thm_down_a = NULL;
-	const u8 *thm_up_b = NULL;
-	const u8 *thm_down_b = NULL;
+	const s8 *thm_up_a = NULL;
+	const s8 *thm_down_a = NULL;
+	const s8 *thm_up_b = NULL;
+	const s8 *thm_down_b = NULL;
 	u8 thermal = 0xff;
 	s8 thm_ofst[64] = {0};
 	u32 tmp = 0;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
index 8c4749f106411..99479bbb09399 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
@@ -43313,7 +43313,7 @@ static const struct rtw89_txpwr_byrate_cfg rtw89_8852a_txpwr_byrate[] = {
 	{ 1, 0, 4, 0, 4, 0x00000000, },
 };
 
-static const u8 _txpwr_track_delta_swingidx_5gb_n[][DELTA_SWINGIDX_SIZE] = {
+static const s8 _txpwr_track_delta_swingidx_5gb_n[][DELTA_SWINGIDX_SIZE] = {
 	{0, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 5, 6, 6, 7,
 	 7, 7, 8, 8, 9, 9, 9, 10, 10, 10, 11, 11, 11},
 	{0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4,
@@ -43322,7 +43322,7 @@ static const u8 _txpwr_track_delta_swingidx_5gb_n[][DELTA_SWINGIDX_SIZE] = {
 	 5, 6, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9},
 };
 
-static const u8 _txpwr_track_delta_swingidx_5gb_p[][DELTA_SWINGIDX_SIZE] = {
+static const s8 _txpwr_track_delta_swingidx_5gb_p[][DELTA_SWINGIDX_SIZE] = {
 	{0, 1, 1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6,
 	 6, 7, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 11, 11},
 	{0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4,
@@ -43331,7 +43331,7 @@ static const u8 _txpwr_track_delta_swingidx_5gb_p[][DELTA_SWINGIDX_SIZE] = {
 	 5, 6, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9},
 };
 
-static const u8 _txpwr_track_delta_swingidx_5ga_n[][DELTA_SWINGIDX_SIZE] = {
+static const s8 _txpwr_track_delta_swingidx_5ga_n[][DELTA_SWINGIDX_SIZE] = {
 	{0, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 5, 6, 6, 7,
 	 7, 7, 8, 8, 9, 9, 9, 10, 10, 10, 11, 11, 11},
 	{0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4,
@@ -43340,7 +43340,7 @@ static const u8 _txpwr_track_delta_swingidx_5ga_n[][DELTA_SWINGIDX_SIZE] = {
 	 5, 6, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9},
 };
 
-static const u8 _txpwr_track_delta_swingidx_5ga_p[][DELTA_SWINGIDX_SIZE] = {
+static const s8 _txpwr_track_delta_swingidx_5ga_p[][DELTA_SWINGIDX_SIZE] = {
 	{0, 1, 1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6,
 	 6, 7, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 11, 11},
 	{0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4,
@@ -43349,35 +43349,35 @@ static const u8 _txpwr_track_delta_swingidx_5ga_p[][DELTA_SWINGIDX_SIZE] = {
 	 5, 6, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9},
 };
 
-static const u8 _txpwr_track_delta_swingidx_2gb_n[] = {
+static const s8 _txpwr_track_delta_swingidx_2gb_n[] = {
 	0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4,
 	 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7};
 
-static const u8 _txpwr_track_delta_swingidx_2gb_p[] = {
+static const s8 _txpwr_track_delta_swingidx_2gb_p[] = {
 	0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2,
 	 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3};
 
-static const u8 _txpwr_track_delta_swingidx_2ga_n[] = {
+static const s8 _txpwr_track_delta_swingidx_2ga_n[] = {
 	0, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3,
 	 3, 3, 3, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5};
 
-static const u8 _txpwr_track_delta_swingidx_2ga_p[] = {
+static const s8 _txpwr_track_delta_swingidx_2ga_p[] = {
 	0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5,
 	 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10};
 
-static const u8 _txpwr_track_delta_swingidx_2g_cck_b_n[] = {
+static const s8 _txpwr_track_delta_swingidx_2g_cck_b_n[] = {
 	0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4,
 	 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7};
 
-static const u8 _txpwr_track_delta_swingidx_2g_cck_b_p[] = {
+static const s8 _txpwr_track_delta_swingidx_2g_cck_b_p[] = {
 	0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2,
 	 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3};
 
-static const u8 _txpwr_track_delta_swingidx_2g_cck_a_n[] = {
+static const s8 _txpwr_track_delta_swingidx_2g_cck_a_n[] = {
 	0, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3,
 	 3, 3, 3, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5};
 
-static const u8 _txpwr_track_delta_swingidx_2g_cck_a_p[] = {
+static const s8 _txpwr_track_delta_swingidx_2g_cck_a_p[] = {
 	0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5,
 	 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10};
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
index bd0c4ff5ca4dd..e7852d2861379 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
@@ -13702,6 +13702,126 @@ static const struct rtw89_txpwr_byrate_cfg rtw89_8852c_txpwr_byrate[] = {
 	{ 2, 0, 4, 0, 4, 0x00000000, },
 };
 
+static const s8 _txpwr_track_delta_swingidx_6gb_n[][DELTA_SWINGIDX_SIZE] = {
+	{0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5,
+	 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10},
+	{0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5,
+	 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10},
+	{0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5,
+	 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10},
+	{0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5,
+	 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10},
+};
+
+static const s8 _txpwr_track_delta_swingidx_6gb_p[][DELTA_SWINGIDX_SIZE] = {
+	{0, 1, 2, 2, 3, 3, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 11,
+	 11, 12, 12, 13, 14, 14, 15, 15, 16, 17, 17, 18},
+	{0, 1, 1, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 9, 9, 10,
+	 10, 11, 11, 12, 12, 13, 13, 14, 15, 15, 16, 16},
+	{0, 1, 1, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 9, 9, 10,
+	 10, 11, 11, 12, 12, 13, 13, 14, 15, 15, 16, 16},
+	{0, 1, 1, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 9, 9, 10,
+	 10, 11, 11, 12, 12, 13, 13, 14, 15, 15, 16, 16},
+};
+
+static const s8 _txpwr_track_delta_swingidx_6ga_n[][DELTA_SWINGIDX_SIZE] = {
+	{0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3,
+	 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6},
+	{0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3,
+	 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6},
+	{0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3,
+	 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6},
+	{0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3,
+	 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6},
+};
+
+static const s8 _txpwr_track_delta_swingidx_6ga_p[][DELTA_SWINGIDX_SIZE] = {
+	{0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8,
+	 9, 9, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15},
+	{0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8,
+	 9, 9, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15},
+	{0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8,
+	 9, 9, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15},
+	{0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8,
+	 9, 9, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15},
+};
+
+static const s8 _txpwr_track_delta_swingidx_5gb_n[][DELTA_SWINGIDX_SIZE] = {
+	{0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5,
+	 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10},
+	{0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4,
+	 5, 5, 5, 5, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8},
+	{0, 1, 1, 2, 2, 2, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7,
+	 7, 8, 8, 8, 9, 9, 10, 10, 10, 11, 11, 12, 12},
+};
+
+static const s8 _txpwr_track_delta_swingidx_5gb_p[][DELTA_SWINGIDX_SIZE] = {
+	{0, 1, 1, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10,
+	 10, 11, 11, 12, 13, 13, 14, 14, 15, 15, 16, 16},
+	{0, 1, 1, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10,
+	 10, 11, 11, 12, 13, 13, 14, 14, 15, 15, 16, 16},
+	{0, 1, 1, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10,
+	 10, 11, 11, 12, 13, 13, 14, 14, 15, 15, 16, 16},
+};
+
+static const s8 _txpwr_track_delta_swingidx_5ga_n[][DELTA_SWINGIDX_SIZE] = {
+	{0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3,
+	 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6},
+	{0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2,
+	 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3},
+	{0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4,
+	 5, 5, 5, 5, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8},
+};
+
+static const s8 _txpwr_track_delta_swingidx_5ga_p[][DELTA_SWINGIDX_SIZE] = {
+	{0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 6, 6, 7, 7, 8,
+	 8, 9, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14},
+	{0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 6, 6, 7, 7, 8,
+	 8, 9, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14},
+	{0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 6, 6, 7, 7, 8,
+	 8, 9, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14},
+};
+
+static const s8 _txpwr_track_delta_swingidx_2gb_n[] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1,
+	 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
+};
+
+static const s8 _txpwr_track_delta_swingidx_2gb_p[] = {
+	0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+	 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2
+};
+
+static const s8 _txpwr_track_delta_swingidx_2ga_n[] = {
+	0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1, -1, -1, -1, -1, -2, -2,
+	 -2, -2, -2, -2, -2, -2, -3, -3, -3, -3, -3, -3, -3
+};
+
+static const s8 _txpwr_track_delta_swingidx_2ga_p[] = {
+	0, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3,
+	 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 5, 5, 5
+};
+
+static const s8 _txpwr_track_delta_swingidx_2g_cck_b_n[] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1,
+	 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
+};
+
+static const s8 _txpwr_track_delta_swingidx_2g_cck_b_p[] = {
+	0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+	 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2
+};
+
+static const s8 _txpwr_track_delta_swingidx_2g_cck_a_n[] = {
+	0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1, -1, -1, -1, -1, -2, -2,
+	 -2, -2, -2, -2, -2, -2, -3, -3, -3, -3, -3, -3, -3
+};
+
+static const s8 _txpwr_track_delta_swingidx_2g_cck_a_p[] = {
+	0, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3,
+	 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 5, 5, 5
+};
+
 const u8 rtw89_8852c_tx_shape[RTW89_BAND_MAX][RTW89_RS_TX_SHAPE_NUM]
 			     [RTW89_REGD_NUM] = {
 	[0][0][RTW89_ACMA] = 0,
@@ -19322,3 +19442,22 @@ const struct rtw89_txpwr_table rtw89_8852c_byr_table = {
 	.size = ARRAY_SIZE(rtw89_8852c_txpwr_byrate),
 	.load = rtw89_phy_load_txpwr_byrate,
 };
+
+const struct rtw89_txpwr_track_cfg rtw89_8852c_trk_cfg = {
+	.delta_swingidx_6gb_n = _txpwr_track_delta_swingidx_6gb_n,
+	.delta_swingidx_6gb_p = _txpwr_track_delta_swingidx_6gb_p,
+	.delta_swingidx_6ga_n = _txpwr_track_delta_swingidx_6ga_n,
+	.delta_swingidx_6ga_p = _txpwr_track_delta_swingidx_6ga_p,
+	.delta_swingidx_5gb_n = _txpwr_track_delta_swingidx_5gb_n,
+	.delta_swingidx_5gb_p = _txpwr_track_delta_swingidx_5gb_p,
+	.delta_swingidx_5ga_n = _txpwr_track_delta_swingidx_5ga_n,
+	.delta_swingidx_5ga_p = _txpwr_track_delta_swingidx_5ga_p,
+	.delta_swingidx_2gb_n = _txpwr_track_delta_swingidx_2gb_n,
+	.delta_swingidx_2gb_p = _txpwr_track_delta_swingidx_2gb_p,
+	.delta_swingidx_2ga_n = _txpwr_track_delta_swingidx_2ga_n,
+	.delta_swingidx_2ga_p = _txpwr_track_delta_swingidx_2ga_p,
+	.delta_swingidx_2g_cck_b_n = _txpwr_track_delta_swingidx_2g_cck_b_n,
+	.delta_swingidx_2g_cck_b_p = _txpwr_track_delta_swingidx_2g_cck_b_p,
+	.delta_swingidx_2g_cck_a_n = _txpwr_track_delta_swingidx_2g_cck_a_n,
+	.delta_swingidx_2g_cck_a_p = _txpwr_track_delta_swingidx_2g_cck_a_p,
+};
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
index 0c0df2ac8cff7..616282c9bb986 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
@@ -13,6 +13,7 @@ extern const struct rtw89_phy_table rtw89_8852c_phy_radioa_table;
 extern const struct rtw89_phy_table rtw89_8852c_phy_radiob_table;
 extern const struct rtw89_phy_table rtw89_8852c_phy_nctl_table;
 extern const struct rtw89_txpwr_table rtw89_8852c_byr_table;
+extern const struct rtw89_txpwr_track_cfg rtw89_8852c_trk_cfg;
 extern const u8 rtw89_8852c_tx_shape[RTW89_BAND_MAX][RTW89_RS_TX_SHAPE_NUM]
 				    [RTW89_REGD_NUM];
 extern const s8 rtw89_8852c_txpwr_lmt_2g[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
-- 
2.25.1

