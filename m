Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E817A902F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 02:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjIUAga (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 20:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjIUAg2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 20:36:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8F7B7
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 17:36:21 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38L0aDpxD1967005, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38L0aDpxD1967005
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 08:36:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 21 Sep 2023 08:36:14 +0800
Received: from [127.0.1.1] (172.16.16.112) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 21 Sep
 2023 08:36:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/4] wifi: rtw89: declare MCC in interface combination
Date:   Thu, 21 Sep 2023 08:35:59 +0800
Message-ID: <20230921003559.11588-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921003559.11588-1-pkshih@realtek.com>
References: <20230921003559.11588-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.112]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

MCC (multi-channel concurrency) supports two combinations as below.
* P2P-GO + STA
* P2P-GC + STA
We add the corresponding ieee80211_iface_limit for it into
ieee80211_iface_combination.

Besides, for multiple channels, it must run with mac80211 chanctx.
So, only with it, ieee80211_iface_combination can allow MCC case.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 26 +++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index ac5a4b0d8282..27770064f1b0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -172,13 +172,31 @@ static const struct ieee80211_iface_limit rtw89_iface_limits[] = {
 	},
 };
 
+static const struct ieee80211_iface_limit rtw89_iface_limits_mcc[] = {
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_STATION),
+	},
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_P2P_CLIENT) |
+			 BIT(NL80211_IFTYPE_P2P_GO),
+	},
+};
+
 static const struct ieee80211_iface_combination rtw89_iface_combs[] = {
 	{
 		.limits = rtw89_iface_limits,
 		.n_limits = ARRAY_SIZE(rtw89_iface_limits),
 		.max_interfaces = 2,
 		.num_different_channels = 1,
-	}
+	},
+	{
+		.limits = rtw89_iface_limits_mcc,
+		.n_limits = ARRAY_SIZE(rtw89_iface_limits_mcc),
+		.max_interfaces = 2,
+		.num_different_channels = 2,
+	},
 };
 
 bool rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate, u16 *bitrate)
@@ -4279,7 +4297,11 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 		goto err;
 
 	hw->wiphy->iface_combinations = rtw89_iface_combs;
-	hw->wiphy->n_iface_combinations = ARRAY_SIZE(rtw89_iface_combs);
+
+	if (no_chanctx || chip->support_chanctx_num == 1)
+		hw->wiphy->n_iface_combinations = 1;
+	else
+		hw->wiphy->n_iface_combinations = ARRAY_SIZE(rtw89_iface_combs);
 
 	rtwdev = hw->priv;
 	rtwdev->hw = hw;
-- 
2.25.1

