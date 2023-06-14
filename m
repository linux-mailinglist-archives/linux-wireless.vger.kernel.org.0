Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA672720552
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 17:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbjFBPGg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 11:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbjFBPGf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 11:06:35 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4699134
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 08:06:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 352F6BKs8004583, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 352F6BKs8004583
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 2 Jun 2023 23:06:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 2 Jun 2023 23:06:25 +0800
Received: from [127.0.1.1] (172.16.22.87) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 2 Jun 2023
 23:06:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/8] wifi: rtw89: regd: judge 6 GHz according to chip and BIOS
Date:   Fri, 2 Jun 2023 23:05:50 +0800
Message-ID: <20230602150556.36777-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602150556.36777-1-pkshih@realtek.com>
References: <20230602150556.36777-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.22.87]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

We allow platform to disable 6 GHz on chips, which supports 6 GHz, through
BIOS. Driver will evaluate Realtek acpi DSM with RTW89_ACPI_DSM_FUNC_6G_DIS
(function 3) to get whether 6 GHz should be disabled.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/regd.c | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 377a7a1c560b7..43e589c023af8 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -330,6 +330,55 @@ static void rtw89_regd_setup_unii4(struct rtw89_dev *rtwdev,
 	sband->n_channels -= 3;
 }
 
+static void rtw89_regd_setup_6ghz(struct rtw89_dev *rtwdev, struct wiphy *wiphy)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	bool chip_support_6ghz = chip->support_bands & BIT(NL80211_BAND_6GHZ);
+	bool regd_allow_6ghz = chip_support_6ghz;
+	struct ieee80211_supported_band *sband;
+	int ret;
+	u8 val;
+
+	if (!chip_support_6ghz)
+		goto bottom;
+
+	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_6G_DIS, &val);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_REGD,
+			    "acpi: cannot eval 6ghz: %d\n", ret);
+		goto bottom;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_REGD,
+		    "acpi: eval if disallow 6ghz: %d\n", val);
+
+	switch (val) {
+	case 0:
+		regd_allow_6ghz = true;
+		break;
+	case 1:
+		regd_allow_6ghz = false;
+		break;
+	default:
+		break;
+	}
+
+bottom:
+	rtw89_debug(rtwdev, RTW89_DBG_REGD, "regd: allow 6ghz: %d\n",
+		    regd_allow_6ghz);
+
+	if (regd_allow_6ghz)
+		return;
+
+	sband = wiphy->bands[NL80211_BAND_6GHZ];
+	if (!sband)
+		return;
+
+	wiphy->bands[NL80211_BAND_6GHZ] = NULL;
+	kfree(sband->iftype_data);
+	kfree(sband);
+}
+
 int rtw89_regd_setup(struct rtw89_dev *rtwdev)
 {
 	struct wiphy *wiphy = rtwdev->hw->wiphy;
@@ -338,6 +387,7 @@ int rtw89_regd_setup(struct rtw89_dev *rtwdev)
 		return -EINVAL;
 
 	rtw89_regd_setup_unii4(rtwdev, wiphy);
+	rtw89_regd_setup_6ghz(rtwdev, wiphy);
 
 	wiphy->reg_notifier = rtw89_regd_notifier;
 	return 0;
-- 
2.25.1

