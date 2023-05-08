Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2856FA1F0
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjEHIMr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjEHIMp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:12:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5238D19D5C
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:12:40 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3488CRj84006094, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3488CRj84006094
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 8 May 2023 16:12:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 8 May 2023 16:12:33 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 May 2023
 16:12:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: rtw89: support U-NII-4 channels on 5GHz band
Date:   Mon, 8 May 2023 16:12:11 +0800
Message-ID: <20230508081211.38760-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508081211.38760-1-pkshih@realtek.com>
References: <20230508081211.38760-1-pkshih@realtek.com>
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

U-NII-4 band, i.e 5.9GHz channels, can be supported by chip 8852C, 8852B
and 8851B. But, it is not supported by chip 8852A. Flag support_unii4 is
added in chip info and defined by chip accordingly to indicate that.
We reference this flag of runtime chip to decide whether to register
5.9GHz channels.

After that, we consider if U-NII-4 band is allowed by our regulatory
rule of U-NII-4. If chip::support_unii4 but not regd::allow_unii4,
we stll do not register 5.9GHz channels.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  3 +++
 drivers/net/wireless/realtek/rtw89/regd.c | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 09296e79f07b4..fbcb9b6e6f754 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -77,6 +77,9 @@ static struct ieee80211_channel rtw89_channels_5ghz[] = {
 	RTW89_DEF_CHAN_5G(5785, 157),
 	RTW89_DEF_CHAN_5G(5805, 161),
 	RTW89_DEF_CHAN_5G_NO_HT40MINUS(5825, 165),
+	RTW89_DEF_CHAN_5G(5845, 169),
+	RTW89_DEF_CHAN_5G(5865, 173),
+	RTW89_DEF_CHAN_5G(5885, 177),
 };
 
 static struct ieee80211_channel rtw89_channels_6ghz[] = {
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 7800ca36bc133..377a7a1c560b7 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -288,6 +288,7 @@ static void rtw89_regd_setup_unii4(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	bool regd_allow_unii_4 = chip->support_unii4;
+	struct ieee80211_supported_band *sband;
 	int ret;
 	u8 val;
 
@@ -318,6 +319,15 @@ static void rtw89_regd_setup_unii4(struct rtw89_dev *rtwdev,
 bottom:
 	rtw89_debug(rtwdev, RTW89_DBG_REGD, "regd: allow unii 4: %d\n",
 		    regd_allow_unii_4);
+
+	if (regd_allow_unii_4)
+		return;
+
+	sband = wiphy->bands[NL80211_BAND_5GHZ];
+	if (!sband)
+		return;
+
+	sband->n_channels -= 3;
 }
 
 int rtw89_regd_setup(struct rtw89_dev *rtwdev)
-- 
2.25.1

