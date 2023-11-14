Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F057EACC2
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 10:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjKNJPJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Nov 2023 04:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjKNJPF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Nov 2023 04:15:05 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4816198
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 01:15:01 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AE9Erh76814939, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AE9Erh76814939
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 17:14:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 14 Nov 2023 17:14:54 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 14 Nov
 2023 17:14:53 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] wifi: rtw89: regd: handle policy of 6 GHz according to BIOS
Date:   Tue, 14 Nov 2023 17:13:58 +0800
Message-ID: <20231114091359.50664-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114091359.50664-1-pkshih@realtek.com>
References: <20231114091359.50664-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
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

According to BIOS configuration of Realtek ACPI DSM function 4,
RTW89_ACPI_DSM_FUNC_6G_BP, we handle the regd policy of 6 GHz.

Policy defines two modes as below.
1. `BLOCK` mode:
    The countries in configured list are blocked.
2. `ALLOW` mode:
    _Only_ the countries in configured list are allowed.
    (i.e. others are all blocked.)

Then, when receiving regulatory notification at runtime, if 6 GHz
is blocked on the country, 6 GHz channels will be disabled.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |   3 +
 drivers/net/wireless/realtek/rtw89/regd.c | 159 +++++++++++++++++++++-
 2 files changed, 160 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index da8181539d1a..472db8876bd4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4326,9 +4326,12 @@ struct rtw89_regd {
 	u8 txpwr_regd[RTW89_BAND_NUM];
 };
 
+#define RTW89_REGD_MAX_COUNTRY_NUM U8_MAX
+
 struct rtw89_regulatory_info {
 	const struct rtw89_regd *regd;
 	enum rtw89_reg_6ghz_power reg_6ghz_power;
+	DECLARE_BITMAP(block_6ghz, RTW89_REGD_MAX_COUNTRY_NUM);
 };
 
 enum rtw89_ifs_clm_application {
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index e86480c625c5..d9d13887604b 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -257,7 +257,42 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("PS", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 };
 
-static const struct rtw89_regd *rtw89_regd_find_reg_by_name(char *alpha2)
+static const char rtw89_alpha2_list_eu[][3] = {
+	"AT",
+	"BE",
+	"CY",
+	"CZ",
+	"DK",
+	"EE",
+	"FI",
+	"FR",
+	"DE",
+	"GR",
+	"HU",
+	"IS",
+	"IE",
+	"IT",
+	"LV",
+	"LI",
+	"LT",
+	"LU",
+	"MT",
+	"MC",
+	"NL",
+	"NO",
+	"PL",
+	"PT",
+	"SK",
+	"SI",
+	"ES",
+	"SE",
+	"CH",
+	"BG",
+	"HR",
+	"RO",
+};
+
+static const struct rtw89_regd *rtw89_regd_find_reg_by_name(const char *alpha2)
 {
 	u32 i;
 
@@ -274,6 +309,24 @@ static bool rtw89_regd_is_ww(const struct rtw89_regd *regd)
 	return regd == &rtw89_ww_regd;
 }
 
+static u8 rtw89_regd_get_index(const struct rtw89_regd *regd)
+{
+	BUILD_BUG_ON(ARRAY_SIZE(rtw89_regd_map) > RTW89_REGD_MAX_COUNTRY_NUM);
+
+	if (rtw89_regd_is_ww(regd))
+		return RTW89_REGD_MAX_COUNTRY_NUM;
+
+	return regd - rtw89_regd_map;
+}
+
+static u8 rtw89_regd_get_index_by_name(const char *alpha2)
+{
+	const struct rtw89_regd *regd;
+
+	regd = rtw89_regd_find_reg_by_name(alpha2);
+	return rtw89_regd_get_index(regd);
+}
+
 #define rtw89_debug_regd(_dev, _regd, _desc, _argv...) \
 do { \
 	typeof(_regd) __r = _regd; \
@@ -335,6 +388,77 @@ static void rtw89_regd_setup_unii4(struct rtw89_dev *rtwdev,
 	sband->n_channels -= 3;
 }
 
+static void __rtw89_regd_setup_policy_6ghz(struct rtw89_dev *rtwdev, bool block,
+					   const char *alpha2)
+{
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	u8 index;
+
+	index = rtw89_regd_get_index_by_name(alpha2);
+	if (index == RTW89_REGD_MAX_COUNTRY_NUM) {
+		rtw89_debug(rtwdev, RTW89_DBG_REGD, "%s: unknown alpha2 %c%c\n",
+			    __func__, alpha2[0], alpha2[1]);
+		return;
+	}
+
+	if (block)
+		set_bit(index, regulatory->block_6ghz);
+	else
+		clear_bit(index, regulatory->block_6ghz);
+}
+
+static void rtw89_regd_setup_policy_6ghz(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_acpi_country_code *country;
+	const struct rtw89_acpi_policy_6ghz *ptr;
+	struct rtw89_acpi_dsm_result res = {};
+	bool to_block;
+	int i, j;
+	int ret;
+
+	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_6G_BP, &res);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_REGD,
+			    "acpi: cannot eval policy 6ghz: %d\n", ret);
+		return;
+	}
+
+	ptr = res.u.policy_6ghz;
+
+	switch (ptr->policy_mode) {
+	case RTW89_ACPI_POLICY_BLOCK:
+		to_block = true;
+		break;
+	case RTW89_ACPI_POLICY_ALLOW:
+		to_block = false;
+		/* only below list is allowed; block all first */
+		bitmap_fill(regulatory->block_6ghz, RTW89_REGD_MAX_COUNTRY_NUM);
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_REGD,
+			    "%s: unknown policy mode: %d\n", __func__,
+			    ptr->policy_mode);
+		goto out;
+	}
+
+	for (i = 0; i < ptr->country_count; i++) {
+		country = &ptr->country_list[i];
+		if (memcmp("EU", country->alpha2, 2) != 0) {
+			__rtw89_regd_setup_policy_6ghz(rtwdev, to_block,
+						       country->alpha2);
+			continue;
+		}
+
+		for (j = 0; j < ARRAY_SIZE(rtw89_alpha2_list_eu); j++)
+			__rtw89_regd_setup_policy_6ghz(rtwdev, to_block,
+						       rtw89_alpha2_list_eu[j]);
+	}
+
+out:
+	kfree(ptr);
+}
+
 static void rtw89_regd_setup_6ghz(struct rtw89_dev *rtwdev, struct wiphy *wiphy)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -375,8 +499,10 @@ static void rtw89_regd_setup_6ghz(struct rtw89_dev *rtwdev, struct wiphy *wiphy)
 	rtw89_debug(rtwdev, RTW89_DBG_REGD, "regd: allow 6ghz: %d\n",
 		    regd_allow_6ghz);
 
-	if (regd_allow_6ghz)
+	if (regd_allow_6ghz) {
+		rtw89_regd_setup_policy_6ghz(rtwdev);
 		return;
+	}
 
 	sband = wiphy->bands[NL80211_BAND_6GHZ];
 	if (!sband)
@@ -436,6 +562,33 @@ int rtw89_regd_init(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static void rtw89_regd_apply_policy_6ghz(struct rtw89_dev *rtwdev,
+					 struct wiphy *wiphy)
+{
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_regd *regd = regulatory->regd;
+	struct ieee80211_supported_band *sband;
+	u8 index;
+	int i;
+
+	index = rtw89_regd_get_index(regd);
+	if (index == RTW89_REGD_MAX_COUNTRY_NUM)
+		return;
+
+	if (!test_bit(index, regulatory->block_6ghz))
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_REGD, "%c%c 6 GHz is blocked by policy\n",
+		    regd->alpha2[0], regd->alpha2[1]);
+
+	sband = wiphy->bands[NL80211_BAND_6GHZ];
+	if (!sband)
+		return;
+
+	for (i = 0; i < sband->n_channels; i++)
+		sband->channels[i].flags |= IEEE80211_CHAN_DISABLED;
+}
+
 static void rtw89_regd_notifier_apply(struct rtw89_dev *rtwdev,
 				      struct wiphy *wiphy,
 				      struct regulatory_request *request)
@@ -450,6 +603,8 @@ static void rtw89_regd_notifier_apply(struct rtw89_dev *rtwdev,
 		wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
 	else
 		wiphy->regulatory_flags &= ~REGULATORY_COUNTRY_IE_IGNORE;
+
+	rtw89_regd_apply_policy_6ghz(rtwdev, wiphy);
 }
 
 void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request)
-- 
2.25.1

