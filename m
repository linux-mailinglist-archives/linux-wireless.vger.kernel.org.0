Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01957664B1
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 09:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjG1HDh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 03:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjG1HDe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 03:03:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 814842118
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 00:03:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36S73E5E0031365, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36S73E5E0031365
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 28 Jul 2023 15:03:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 28 Jul 2023 15:03:26 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 28 Jul
 2023 15:03:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 03/10] wifi: rtw89: phy: rate pattern handles HW rate by chip gen
Date:   Fri, 28 Jul 2023 15:02:45 +0800
Message-ID: <20230728070252.66525-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728070252.66525-1-pkshih@realtek.com>
References: <20230728070252.66525-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Rate pattern is controlled by 'iw bitrates' to fix rate as desired, and
we extend to support v1 rate.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 43 +++++++++++++++---------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index fb15c852fdd48..e0d4b97a372d6 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -444,6 +444,12 @@ static bool __check_rate_pattern(struct rtw89_phy_rate_pattern *next,
 	return true;
 }
 
+#define RTW89_HW_RATE_BY_CHIP_GEN(rate) \
+	{ \
+		[RTW89_CHIP_AX] = RTW89_HW_RATE_ ## rate, \
+		[RTW89_CHIP_BE] = RTW89_HW_RATE_V1_ ## rate, \
+	}
+
 void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 				struct ieee80211_vif *vif,
 				const struct cfg80211_bitrate_mask *mask)
@@ -452,39 +458,46 @@ void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_phy_rate_pattern next_pattern = {0};
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
-	static const u16 hw_rate_he[] = {RTW89_HW_RATE_HE_NSS1_MCS0,
-					 RTW89_HW_RATE_HE_NSS2_MCS0,
-					 RTW89_HW_RATE_HE_NSS3_MCS0,
-					 RTW89_HW_RATE_HE_NSS4_MCS0};
-	static const u16 hw_rate_vht[] = {RTW89_HW_RATE_VHT_NSS1_MCS0,
-					  RTW89_HW_RATE_VHT_NSS2_MCS0,
-					  RTW89_HW_RATE_VHT_NSS3_MCS0,
-					  RTW89_HW_RATE_VHT_NSS4_MCS0};
-	static const u16 hw_rate_ht[] = {RTW89_HW_RATE_MCS0,
-					 RTW89_HW_RATE_MCS8,
-					 RTW89_HW_RATE_MCS16,
-					 RTW89_HW_RATE_MCS24};
+	static const u16 hw_rate_he[][RTW89_CHIP_GEN_NUM] = {
+		RTW89_HW_RATE_BY_CHIP_GEN(HE_NSS1_MCS0),
+		RTW89_HW_RATE_BY_CHIP_GEN(HE_NSS2_MCS0),
+		RTW89_HW_RATE_BY_CHIP_GEN(HE_NSS3_MCS0),
+		RTW89_HW_RATE_BY_CHIP_GEN(HE_NSS4_MCS0),
+	};
+	static const u16 hw_rate_vht[][RTW89_CHIP_GEN_NUM] = {
+		RTW89_HW_RATE_BY_CHIP_GEN(VHT_NSS1_MCS0),
+		RTW89_HW_RATE_BY_CHIP_GEN(VHT_NSS2_MCS0),
+		RTW89_HW_RATE_BY_CHIP_GEN(VHT_NSS3_MCS0),
+		RTW89_HW_RATE_BY_CHIP_GEN(VHT_NSS4_MCS0),
+	};
+	static const u16 hw_rate_ht[][RTW89_CHIP_GEN_NUM] = {
+		RTW89_HW_RATE_BY_CHIP_GEN(MCS0),
+		RTW89_HW_RATE_BY_CHIP_GEN(MCS8),
+		RTW89_HW_RATE_BY_CHIP_GEN(MCS16),
+		RTW89_HW_RATE_BY_CHIP_GEN(MCS24),
+	};
 	u8 band = chan->band_type;
 	enum nl80211_band nl_band = rtw89_hw_to_nl80211_band(band);
+	enum rtw89_chip_gen chip_gen = rtwdev->chip->chip_gen;
 	u8 tx_nss = rtwdev->hal.tx_nss;
 	u8 i;
 
 	for (i = 0; i < tx_nss; i++)
-		if (!__check_rate_pattern(&next_pattern, hw_rate_he[i],
+		if (!__check_rate_pattern(&next_pattern, hw_rate_he[i][chip_gen],
 					  RA_MASK_HE_RATES, RTW89_RA_MODE_HE,
 					  mask->control[nl_band].he_mcs[i],
 					  0, true))
 			goto out;
 
 	for (i = 0; i < tx_nss; i++)
-		if (!__check_rate_pattern(&next_pattern, hw_rate_vht[i],
+		if (!__check_rate_pattern(&next_pattern, hw_rate_vht[i][chip_gen],
 					  RA_MASK_VHT_RATES, RTW89_RA_MODE_VHT,
 					  mask->control[nl_band].vht_mcs[i],
 					  0, true))
 			goto out;
 
 	for (i = 0; i < tx_nss; i++)
-		if (!__check_rate_pattern(&next_pattern, hw_rate_ht[i],
+		if (!__check_rate_pattern(&next_pattern, hw_rate_ht[i][chip_gen],
 					  RA_MASK_HT_RATES, RTW89_RA_MODE_HT,
 					  mask->control[nl_band].ht_mcs[i],
 					  0, true))
-- 
2.25.1

