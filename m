Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9C94AD33F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Feb 2022 09:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349339AbiBHIZB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Feb 2022 03:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349332AbiBHIY7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Feb 2022 03:24:59 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46AEC03FEC1
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 00:24:57 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2188OpVhA020542, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2188OpVhA020542
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 8 Feb 2022 16:24:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Feb 2022 16:24:51 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 8 Feb
 2022 16:24:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <ben.liao@realtek.com>,
        <damon.chen@realtek.com>
Subject: [PATCH 2/2] rtw89: recover rates of rate adaptive mechanism
Date:   Tue, 8 Feb 2022 16:24:27 +0800
Message-ID: <20220208082427.42433-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208082427.42433-1-pkshih@realtek.com>
References: <20220208082427.42433-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/08/2022 08:04:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvOCCkV6TIIDA2OjAwOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

From: Chien-Hsun Liao <ben.liao@realtek.com>

Some APs like CMW270 only support one phyrate and the function
rtw89_phy_ra_mask_rssi could disable that rate. To fix such problem, we
restore the rate mask if we find that the rate_mask is empty.
Also, apply missed legacy rates from sta->supp_rates[].

Signed-off-by: Chien-Hsun Liao <ben.liao@realtek.com>
Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 47 +++++++++++++++---------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 18581261af447..130db2f46f49e 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -117,17 +117,28 @@ static u64 rtw89_phy_ra_mask_rssi(struct rtw89_dev *rtwdev, u8 rssi,
 	else if (rssi_lv == 1)
 		return 0xfffffffffffffff0ULL;
 	else if (rssi_lv == 2)
-		return 0xffffffffffffffe0ULL;
+		return 0xffffffffffffefe0ULL;
 	else if (rssi_lv == 3)
-		return 0xffffffffffffffc0ULL;
+		return 0xffffffffffffcfc0ULL;
 	else if (rssi_lv == 4)
-		return 0xffffffffffffff80ULL;
+		return 0xffffffffffff8f80ULL;
 	else if (rssi_lv >= 5)
-		return 0xffffffffffffff00ULL;
+		return 0xffffffffffff0f00ULL;
 
 	return 0xffffffffffffffffULL;
 }
 
+static u64 rtw89_phy_ra_mask_recover(u64 ra_mask, u64 ra_mask_bak)
+{
+	if ((ra_mask & ~(RA_MASK_CCK_RATES | RA_MASK_OFDM_RATES)) == 0)
+		ra_mask |= (ra_mask_bak & ~(RA_MASK_CCK_RATES | RA_MASK_OFDM_RATES));
+
+	if (ra_mask == 0)
+		ra_mask |= (ra_mask_bak & (RA_MASK_CCK_RATES | RA_MASK_OFDM_RATES));
+
+	return ra_mask;
+}
+
 static u64 rtw89_phy_ra_mask_cfg(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
@@ -194,8 +205,8 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	struct rtw89_ra_info *ra = &rtwsta->ra;
 	const u64 *high_rate_masks = rtw89_ra_mask_ht_rates;
 	u8 rssi = ewma_rssi_read(&rtwsta->avg_rssi);
-	u64 high_rate_mask = 0;
 	u64 ra_mask = 0;
+	u64 ra_mask_bak;
 	u8 mode = 0;
 	u8 csi_mode = RTW89_RA_RPT_MODE_LEGACY;
 	u8 bw_mode = 0;
@@ -244,34 +255,36 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	}
 
 	if (rtwdev->hal.current_band_type == RTW89_BAND_2G) {
+		ra_mask |= sta->supp_rates[NL80211_BAND_2GHZ];
 		if (sta->supp_rates[NL80211_BAND_2GHZ] <= 0xf)
 			mode |= RTW89_RA_MODE_CCK;
 		else
 			mode |= RTW89_RA_MODE_CCK | RTW89_RA_MODE_OFDM;
 	} else {
+		ra_mask |= (u64)sta->supp_rates[NL80211_BAND_5GHZ] << 4;
 		mode |= RTW89_RA_MODE_OFDM;
 	}
 
+	ra_mask_bak = ra_mask;
+
 	if (mode >= RTW89_RA_MODE_HT) {
+		u64 mask = 0;
 		for (i = 0; i < rtwdev->hal.tx_nss; i++)
-			high_rate_mask |= high_rate_masks[i];
-		ra_mask &= high_rate_mask;
+			mask |= high_rate_masks[i];
 		if (mode & RTW89_RA_MODE_OFDM)
-			ra_mask |= RA_MASK_SUBOFDM_RATES;
+			mask |= RA_MASK_SUBOFDM_RATES;
 		if (mode & RTW89_RA_MODE_CCK)
-			ra_mask |= RA_MASK_SUBCCK_RATES;
+			mask |= RA_MASK_SUBCCK_RATES;
+		ra_mask &= mask;
 	} else if (mode & RTW89_RA_MODE_OFDM) {
-		if (mode & RTW89_RA_MODE_CCK)
-			ra_mask |= RA_MASK_SUBCCK_RATES;
-		ra_mask |= RA_MASK_OFDM_RATES;
-	} else {
-		ra_mask = RA_MASK_CCK_RATES;
+		ra_mask &= (RA_MASK_OFDM_RATES | RA_MASK_SUBCCK_RATES);
 	}
 
-	if (mode != RTW89_RA_MODE_CCK) {
+	if (mode != RTW89_RA_MODE_CCK)
 		ra_mask &= rtw89_phy_ra_mask_rssi(rtwdev, rssi, 0);
-		ra_mask &= rtw89_phy_ra_mask_cfg(rtwdev, rtwsta);
-	}
+
+	ra_mask = rtw89_phy_ra_mask_recover(ra_mask, ra_mask_bak);
+	ra_mask &= rtw89_phy_ra_mask_cfg(rtwdev, rtwsta);
 
 	switch (sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_80:
-- 
2.25.1

