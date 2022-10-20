Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDC06056C4
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Oct 2022 07:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJTF1f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Oct 2022 01:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJTF1e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Oct 2022 01:27:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 296BC191D71
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 22:27:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29K5QrV02031917, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29K5QrV02031917
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 20 Oct 2022 13:26:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 20 Oct 2022 13:27:25 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 20 Oct
 2022 13:27:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: declare support bands with const
Date:   Thu, 20 Oct 2022 13:27:01 +0800
Message-ID: <20221020052702.33988-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 10/20/2022 04:59:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzIwIKRXpMggMDM6Mzg6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

They are just default declarations and we won't modify them directly.
Instead, we actually do moification on their memdup now. So, they
should be declared with const.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a0fa9639b5097..6d8243ee184c3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -171,7 +171,7 @@ bool rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate, u16 *bitr
 	return true;
 }
 
-static struct ieee80211_supported_band rtw89_sband_2ghz = {
+static const struct ieee80211_supported_band rtw89_sband_2ghz = {
 	.band		= NL80211_BAND_2GHZ,
 	.channels	= rtw89_channels_2ghz,
 	.n_channels	= ARRAY_SIZE(rtw89_channels_2ghz),
@@ -181,7 +181,7 @@ static struct ieee80211_supported_band rtw89_sband_2ghz = {
 	.vht_cap	= {0},
 };
 
-static struct ieee80211_supported_band rtw89_sband_5ghz = {
+static const struct ieee80211_supported_band rtw89_sband_5ghz = {
 	.band		= NL80211_BAND_5GHZ,
 	.channels	= rtw89_channels_5ghz,
 	.n_channels	= ARRAY_SIZE(rtw89_channels_5ghz),
@@ -193,7 +193,7 @@ static struct ieee80211_supported_band rtw89_sband_5ghz = {
 	.vht_cap	= {0},
 };
 
-static struct ieee80211_supported_band rtw89_sband_6ghz = {
+static const struct ieee80211_supported_band rtw89_sband_6ghz = {
 	.band		= NL80211_BAND_6GHZ,
 	.channels	= rtw89_channels_6ghz,
 	.n_channels	= ARRAY_SIZE(rtw89_channels_6ghz),
-- 
2.25.1

