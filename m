Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491EE688FDD
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Feb 2023 07:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjBCGxV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Feb 2023 01:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjBCGwe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Feb 2023 01:52:34 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3158EB4D
        for <linux-wireless@vger.kernel.org>; Thu,  2 Feb 2023 22:52:29 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3136qGRA1019339, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3136qGRA1019339
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 3 Feb 2023 14:52:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 3 Feb 2023 14:52:22 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 3 Feb 2023
 14:52:22 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: phy: set TX power according to RF path number by chip
Date:   Fri, 3 Feb 2023 14:51:57 +0800
Message-ID: <20230203065157.8227-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMjQgpFekyCAwNjoxNDowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Previously, all supported chips had two RF paths. Therefore, these
codes used static number for TX power setting. Now, we are planning
to support a new chip which has only one RF path. So, we refine the
setting codes to refer to chip's RF path number at runtime.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index ca2b5c17d6da0..d9f61ba3d1765 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2042,6 +2042,7 @@ void rtw89_phy_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 				const struct rtw89_chan *chan,
 				enum rtw89_phy_idx phy_idx)
 {
+	u8 max_nss_num = rtwdev->chip->rf_path_num;
 	static const u8 rs[] = {
 		RTW89_RS_CCK,
 		RTW89_RS_OFDM,
@@ -2064,7 +2065,7 @@ void rtw89_phy_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 	BUILD_BUG_ON(rtw89_rs_idx_max[RTW89_RS_HEDCM] % 4);
 
 	addr = R_AX_PWR_BY_RATE;
-	for (cur.nss = 0; cur.nss <= RTW89_NSS_2; cur.nss++) {
+	for (cur.nss = 0; cur.nss < max_nss_num; cur.nss++) {
 		for (i = 0; i < ARRAY_SIZE(rs); i++) {
 			if (cur.nss >= rtw89_rs_nss_max[rs[i]])
 				continue;
@@ -2127,6 +2128,7 @@ void rtw89_phy_set_txpwr_limit(struct rtw89_dev *rtwdev,
 			       const struct rtw89_chan *chan,
 			       enum rtw89_phy_idx phy_idx)
 {
+	u8 max_ntx_num = rtwdev->chip->rf_path_num;
 	struct rtw89_txpwr_limit lmt;
 	u8 ch = chan->channel;
 	u8 bw = chan->band_width;
@@ -2141,7 +2143,7 @@ void rtw89_phy_set_txpwr_limit(struct rtw89_dev *rtwdev,
 		     RTW89_TXPWR_LMT_PAGE_SIZE);
 
 	addr = R_AX_PWR_LMT;
-	for (i = 0; i < RTW89_NTX_NUM; i++) {
+	for (i = 0; i < max_ntx_num; i++) {
 		rtw89_phy_fill_txpwr_limit(rtwdev, chan, &lmt, i);
 
 		ptr = (s8 *)&lmt;
@@ -2162,6 +2164,7 @@ void rtw89_phy_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 				  const struct rtw89_chan *chan,
 				  enum rtw89_phy_idx phy_idx)
 {
+	u8 max_ntx_num = rtwdev->chip->rf_path_num;
 	struct rtw89_txpwr_limit_ru lmt_ru;
 	u8 ch = chan->channel;
 	u8 bw = chan->band_width;
@@ -2176,7 +2179,7 @@ void rtw89_phy_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 		     RTW89_TXPWR_LMT_RU_PAGE_SIZE);
 
 	addr = R_AX_PWR_RU_LMT;
-	for (i = 0; i < RTW89_NTX_NUM; i++) {
+	for (i = 0; i < max_ntx_num; i++) {
 		rtw89_phy_fill_txpwr_limit_ru(rtwdev, chan, &lmt_ru, i);
 
 		ptr = (s8 *)&lmt_ru;
-- 
2.25.1

