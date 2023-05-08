Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40C16FA1F3
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjEHIMs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjEHIMq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:12:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9B01A12C
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:12:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3488CPg24006080, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3488CPg24006080
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 8 May 2023 16:12:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 8 May 2023 16:12:31 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 May 2023
 16:12:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] wifi: rtw89: regd: judge UNII-4 according to BIOS and chip
Date:   Mon, 8 May 2023 16:12:10 +0800
Message-ID: <20230508081211.38760-3-pkshih@realtek.com>
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

For realtek regulatory, there are following two kinds of configurations
to determine whether to allow UNII-4 band, i.e. 5.9GHz channels.

1. default setting according to whether chip support it or not
2. evaluate realtek ACPI DSM with RTW89_ACPI_DSM_FUNC_59G_EN (func. 6)

If (1) is false, we won't try (2) and just disallow UNII-4. Otherwise,
if (2) is not supported or returns a non-specific value, we follow the
default setting either. Besides, this commit aims to add decision logic
in rtw89 regulatory. Actually, driver doesn't register UNII-4 yet. That
will be handled by another commit.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  7 ++-
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +
 drivers/net/wireless/realtek/rtw89/regd.c     | 51 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 7 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 630124f9e0254..09296e79f07b4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3850,7 +3850,12 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
-	hw->wiphy->reg_notifier = rtw89_regd_notifier;
+	ret = rtw89_regd_setup(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to set up regd\n");
+		goto err_free_supported_band;
+	}
+
 	hw->wiphy->sar_capa = &rtw89_sar_capa;
 
 	ret = ieee80211_register_hw(hw);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f697902706acc..cdd8e312cef76 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3179,6 +3179,7 @@ struct rtw89_chip_info {
 	u8 support_chanctx_num;
 	u8 support_bands;
 	bool support_bw160;
+	bool support_unii4;
 	bool support_ul_tb_ctrl;
 	bool hw_sec_hdr;
 	u8 rf_path_num;
@@ -5044,6 +5045,7 @@ int rtw89_core_release_sta_ba_entry(struct rtw89_dev *rtwdev,
 void rtw89_vif_type_mapping(struct ieee80211_vif *vif, bool assoc);
 int rtw89_chip_info_setup(struct rtw89_dev *rtwdev);
 bool rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate, u16 *bitrate);
+int rtw89_regd_setup(struct rtw89_dev *rtwdev);
 int rtw89_regd_init(struct rtw89_dev *rtwdev,
 		    void (*reg_notifier)(struct wiphy *wiphy, struct regulatory_request *request));
 void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request);
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 6e5a740b128f0..7800ca36bc133 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2020  Realtek Corporation
  */
 
+#include "acpi.h"
 #include "debug.h"
 #include "ps.h"
 
@@ -282,6 +283,56 @@ do { \
 		    __r->txpwr_regd[RTW89_BAND_6G]); \
 } while (0)
 
+static void rtw89_regd_setup_unii4(struct rtw89_dev *rtwdev,
+				   struct wiphy *wiphy)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	bool regd_allow_unii_4 = chip->support_unii4;
+	int ret;
+	u8 val;
+
+	if (!chip->support_unii4)
+		goto bottom;
+
+	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_59G_EN, &val);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_REGD,
+			    "acpi: cannot eval unii 4: %d\n", ret);
+		goto bottom;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_REGD,
+		    "acpi: eval if allow unii 4: %d\n", val);
+
+	switch (val) {
+	case 0:
+		regd_allow_unii_4 = false;
+		break;
+	case 1:
+		regd_allow_unii_4 = true;
+		break;
+	default:
+		break;
+	}
+
+bottom:
+	rtw89_debug(rtwdev, RTW89_DBG_REGD, "regd: allow unii 4: %d\n",
+		    regd_allow_unii_4);
+}
+
+int rtw89_regd_setup(struct rtw89_dev *rtwdev)
+{
+	struct wiphy *wiphy = rtwdev->hw->wiphy;
+
+	if (!wiphy)
+		return -EINVAL;
+
+	rtw89_regd_setup_unii4(rtwdev, wiphy);
+
+	wiphy->reg_notifier = rtw89_regd_notifier;
+	return 0;
+}
+
 int rtw89_regd_init(struct rtw89_dev *rtwdev,
 		    void (*reg_notifier)(struct wiphy *wiphy,
 					 struct regulatory_request *request))
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index b68ebe950c4ef..00cabf92c5a99 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -123,6 +123,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
 	.support_bw160		= false,
+	.support_unii4		= true,
 	.support_ul_tb_ctrl	= true,
 	.hw_sec_hdr		= false,
 	.rf_path_num		= 1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index a8a58ff36e95f..4e6f3bbdc2d8f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2105,6 +2105,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
 	.support_bw160		= false,
+	.support_unii4		= false,
 	.support_ul_tb_ctrl     = false,
 	.hw_sec_hdr		= false,
 	.rf_path_num		= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index fa12d4a7f79f9..b1a6b985842be 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2536,6 +2536,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
 	.support_bw160		= false,
+	.support_unii4		= true,
 	.support_ul_tb_ctrl	= true,
 	.hw_sec_hdr		= false,
 	.rf_path_num		= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index d9272bce03256..f2e70bda8e480 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2836,6 +2836,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 				  BIT(NL80211_BAND_5GHZ) |
 				  BIT(NL80211_BAND_6GHZ),
 	.support_bw160		= true,
+	.support_unii4		= true,
 	.support_ul_tb_ctrl     = false,
 	.hw_sec_hdr		= true,
 	.rf_path_num		= 2,
-- 
2.25.1

