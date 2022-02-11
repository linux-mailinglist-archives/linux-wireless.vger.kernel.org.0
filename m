Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56F64B1FC6
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 09:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347877AbiBKIAe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 03:00:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347871AbiBKIAb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 03:00:31 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDCCBD2
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 00:00:29 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21B80NNG0023919, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21B80NNG0023919
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 16:00:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 16:00:22 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 11 Feb
 2022 16:00:22 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 4/6] rtw89: add 6G support to rate adaptive mechanism
Date:   Fri, 11 Feb 2022 15:59:51 +0800
Message-ID: <20220211075953.40421-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211075953.40421-1-pkshih@realtek.com>
References: <20220211075953.40421-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/11/2022 07:45:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMTEgpFekyCAwNjowMDowMA==?=
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

Construct rate mask of 6G band, and rate adaptive mechanism can work well
on this band.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c491a11536815..69668108e19f3 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -161,6 +161,11 @@ static u64 rtw89_phy_ra_mask_cfg(struct rtw89_dev *rtwdev, struct rtw89_sta *rtw
 		cfg_mask = u64_encode_bits(mask->control[NL80211_BAND_5GHZ].legacy,
 					   RA_MASK_OFDM_RATES);
 		break;
+	case RTW89_BAND_6G:
+		band = NL80211_BAND_6GHZ;
+		cfg_mask = u64_encode_bits(mask->control[NL80211_BAND_6GHZ].legacy,
+					   RA_MASK_OFDM_RATES);
+		break;
 	default:
 		rtw89_warn(rtwdev, "unhandled band type %d\n", hal->current_band_type);
 		return -1;
@@ -254,15 +259,25 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 			ldpc_en = 1;
 	}
 
-	if (rtwdev->hal.current_band_type == RTW89_BAND_2G) {
+	switch (rtwdev->hal.current_band_type) {
+	case RTW89_BAND_2G:
 		ra_mask |= sta->supp_rates[NL80211_BAND_2GHZ];
 		if (sta->supp_rates[NL80211_BAND_2GHZ] <= 0xf)
 			mode |= RTW89_RA_MODE_CCK;
 		else
 			mode |= RTW89_RA_MODE_CCK | RTW89_RA_MODE_OFDM;
-	} else {
+		break;
+	case RTW89_BAND_5G:
 		ra_mask |= (u64)sta->supp_rates[NL80211_BAND_5GHZ] << 4;
 		mode |= RTW89_RA_MODE_OFDM;
+		break;
+	case RTW89_BAND_6G:
+		ra_mask |= (u64)sta->supp_rates[NL80211_BAND_6GHZ] << 4;
+		mode |= RTW89_RA_MODE_OFDM;
+		break;
+	default:
+		rtw89_err(rtwdev, "Unknown band type\n");
+		break;
 	}
 
 	ra_mask_bak = ra_mask;
-- 
2.25.1

