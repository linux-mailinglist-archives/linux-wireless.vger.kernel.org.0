Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F07E7EACBF
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 10:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjKNJPG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Nov 2023 04:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjKNJPE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Nov 2023 04:15:04 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B38FF5
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 01:15:00 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AE9EqH82814936, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AE9EqH82814936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 17:14:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Nov 2023 17:14:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 14 Nov
 2023 17:14:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: rtw89: acpi: process 6 GHz band policy from DSM
Date:   Tue, 14 Nov 2023 17:13:57 +0800
Message-ID: <20231114091359.50664-2-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Realtek ACPI DSM func 4, RTW89_ACPI_DSM_FUNC_6G_BP,
accepts a configuration via ACPI buffer as below.

| index | description   |
-------------------------
| [0-2] | signature     |
| [3]   | reserved      |
| [4]   | policy mode   |
| [5]   | country count |
| [6-]  | country list  |

Through this function, BIOS can indicate to allow/block
6 GHz on some specific countries. Still, driver should
follow regd first before taking this configuration into
account.

Besides, add a bit in debug mask for ACPI.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/acpi.c  | 81 ++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/acpi.h  | 32 ++++++++-
 drivers/net/wireless/realtek/rtw89/debug.h |  1 +
 drivers/net/wireless/realtek/rtw89/regd.c  | 10 ++-
 drivers/net/wireless/realtek/rtw89/sar.c   |  4 +-
 5 files changed, 109 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/acpi.c b/drivers/net/wireless/realtek/rtw89/acpi.c
index 8aaf83a2a6b4..2e7326a8e3e4 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.c
+++ b/drivers/net/wireless/realtek/rtw89/acpi.c
@@ -12,27 +12,74 @@ static const guid_t rtw89_guid = GUID_INIT(0xD2A8C3E8, 0x4B69, 0x4F00,
 					   0x82, 0xBD, 0xFE, 0x86,
 					   0x07, 0x80, 0x3A, 0xA7);
 
-static int rtw89_acpi_dsm_get(struct rtw89_dev *rtwdev, union acpi_object *obj,
-			      u8 *value)
+static
+int rtw89_acpi_dsm_get_value(struct rtw89_dev *rtwdev, union acpi_object *obj,
+			     u8 *value)
 {
-	switch (obj->type) {
-	case ACPI_TYPE_INTEGER:
-		*value = (u8)obj->integer.value;
-		break;
-	case ACPI_TYPE_BUFFER:
-		*value = obj->buffer.pointer[0];
-		break;
-	default:
-		rtw89_debug(rtwdev, RTW89_DBG_UNEXP,
-			    "acpi dsm return unhandled type: %d\n", obj->type);
+	if (obj->type != ACPI_TYPE_INTEGER) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI,
+			    "acpi: expect integer but type: %d\n", obj->type);
 		return -EINVAL;
 	}
 
+	*value = (u8)obj->integer.value;
+	return 0;
+}
+
+static bool chk_acpi_policy_6ghz_sig(const struct rtw89_acpi_policy_6ghz *p)
+{
+	return p->signature[0] == 0x00 &&
+	       p->signature[1] == 0xE0 &&
+	       p->signature[2] == 0x4C;
+}
+
+static
+int rtw89_acpi_dsm_get_policy_6ghz(struct rtw89_dev *rtwdev,
+				   union acpi_object *obj,
+				   struct rtw89_acpi_policy_6ghz **policy_6ghz)
+{
+	const struct rtw89_acpi_policy_6ghz *ptr;
+	u32 expect_len;
+	u32 len;
+
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI,
+			    "acpi: expect buffer but type: %d\n", obj->type);
+		return -EINVAL;
+	}
+
+	len = obj->buffer.length;
+	if (len < sizeof(*ptr)) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "%s: invalid buffer length: %u\n",
+			    __func__, len);
+		return -EINVAL;
+	}
+
+	ptr = (typeof(ptr))obj->buffer.pointer;
+	if (!chk_acpi_policy_6ghz_sig(ptr)) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "%s: bad signature\n", __func__);
+		return -EINVAL;
+	}
+
+	expect_len = struct_size(ptr, country_list, ptr->country_count);
+	if (len < expect_len) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "%s: expect %u but length: %u\n",
+			    __func__, expect_len, len);
+		return -EINVAL;
+	}
+
+	*policy_6ghz = kmemdup(ptr, expect_len, GFP_KERNEL);
+	if (!*policy_6ghz)
+		return -ENOMEM;
+
+	rtw89_hex_dump(rtwdev, RTW89_DBG_ACPI, "policy_6ghz: ", *policy_6ghz,
+		       expect_len);
 	return 0;
 }
 
 int rtw89_acpi_evaluate_dsm(struct rtw89_dev *rtwdev,
-			    enum rtw89_acpi_dsm_func func, u8 *value)
+			    enum rtw89_acpi_dsm_func func,
+			    struct rtw89_acpi_dsm_result *res)
 {
 	union acpi_object *obj;
 	int ret;
@@ -40,12 +87,16 @@ int rtw89_acpi_evaluate_dsm(struct rtw89_dev *rtwdev,
 	obj = acpi_evaluate_dsm(ACPI_HANDLE(rtwdev->dev), &rtw89_guid,
 				0, func, NULL);
 	if (!obj) {
-		rtw89_debug(rtwdev, RTW89_DBG_UNEXP,
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI,
 			    "acpi dsm fail to evaluate func: %d\n", func);
 		return -ENOENT;
 	}
 
-	ret = rtw89_acpi_dsm_get(rtwdev, obj, value);
+	if (func == RTW89_ACPI_DSM_FUNC_6G_BP)
+		ret = rtw89_acpi_dsm_get_policy_6ghz(rtwdev, obj,
+						     &res->u.policy_6ghz);
+	else
+		ret = rtw89_acpi_dsm_get_value(rtwdev, obj, &res->u.value);
 
 	ACPI_FREE(obj);
 	return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/acpi.h b/drivers/net/wireless/realtek/rtw89/acpi.h
index ed74d8ceb733..fe85b40cf076 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.h
+++ b/drivers/net/wireless/realtek/rtw89/acpi.h
@@ -15,7 +15,37 @@ enum rtw89_acpi_dsm_func {
 	RTW89_ACPI_DSM_FUNC_59G_EN = 6,
 };
 
+enum rtw89_acpi_policy_mode {
+	RTW89_ACPI_POLICY_BLOCK = 0,
+	RTW89_ACPI_POLICY_ALLOW = 1,
+};
+
+struct rtw89_acpi_country_code {
+	/* below are allowed:
+	 * * ISO alpha2 country code
+	 * * EU for countries in Europe
+	 */
+	char alpha2[2];
+} __packed;
+
+struct rtw89_acpi_policy_6ghz {
+	u8 signature[3];
+	u8 rsvd;
+	u8 policy_mode;
+	u8 country_count;
+	struct rtw89_acpi_country_code country_list[] __counted_by(country_count);
+} __packed;
+
+struct rtw89_acpi_dsm_result {
+	union {
+		u8 value;
+		/* caller needs to free it after using */
+		struct rtw89_acpi_policy_6ghz *policy_6ghz;
+	} u;
+};
+
 int rtw89_acpi_evaluate_dsm(struct rtw89_dev *rtwdev,
-			    enum rtw89_acpi_dsm_func func, u8 *value);
+			    enum rtw89_acpi_dsm_func func,
+			    struct rtw89_acpi_dsm_result *res);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/debug.h b/drivers/net/wireless/realtek/rtw89/debug.h
index 079269bb5251..b663ee24555a 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.h
+++ b/drivers/net/wireless/realtek/rtw89/debug.h
@@ -29,6 +29,7 @@ enum rtw89_debug_mask {
 	RTW89_DBG_WOW = BIT(18),
 	RTW89_DBG_UL_TB = BIT(19),
 	RTW89_DBG_CHAN = BIT(20),
+	RTW89_DBG_ACPI = BIT(21),
 
 	RTW89_DBG_UNEXP = BIT(31),
 };
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index ca99422e600f..e86480c625c5 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -291,19 +291,22 @@ static void rtw89_regd_setup_unii4(struct rtw89_dev *rtwdev,
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	bool regd_allow_unii_4 = chip->support_unii4;
 	struct ieee80211_supported_band *sband;
+	struct rtw89_acpi_dsm_result res = {};
 	int ret;
 	u8 val;
 
 	if (!chip->support_unii4)
 		goto bottom;
 
-	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_59G_EN, &val);
+	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_59G_EN, &res);
 	if (ret) {
 		rtw89_debug(rtwdev, RTW89_DBG_REGD,
 			    "acpi: cannot eval unii 4: %d\n", ret);
 		goto bottom;
 	}
 
+	val = res.u.value;
+
 	rtw89_debug(rtwdev, RTW89_DBG_REGD,
 		    "acpi: eval if allow unii 4: %d\n", val);
 
@@ -338,19 +341,22 @@ static void rtw89_regd_setup_6ghz(struct rtw89_dev *rtwdev, struct wiphy *wiphy)
 	bool chip_support_6ghz = chip->support_bands & BIT(NL80211_BAND_6GHZ);
 	bool regd_allow_6ghz = chip_support_6ghz;
 	struct ieee80211_supported_band *sband;
+	struct rtw89_acpi_dsm_result res = {};
 	int ret;
 	u8 val;
 
 	if (!chip_support_6ghz)
 		goto bottom;
 
-	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_6G_DIS, &val);
+	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_6G_DIS, &res);
 	if (ret) {
 		rtw89_debug(rtwdev, RTW89_DBG_REGD,
 			    "acpi: cannot eval 6ghz: %d\n", ret);
 		goto bottom;
 	}
 
+	val = res.u.value;
+
 	rtw89_debug(rtwdev, RTW89_DBG_REGD,
 		    "acpi: eval if disallow 6ghz: %d\n", val);
 
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index aed05b026c6c..1b2a400406ae 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -404,16 +404,18 @@ static void rtw89_tas_state_update(struct rtw89_dev *rtwdev)
 void rtw89_tas_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_tas_info *tas = &rtwdev->tas;
+	struct rtw89_acpi_dsm_result res = {};
 	int ret;
 	u8 val;
 
-	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_TAS_EN, &val);
+	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_TAS_EN, &res);
 	if (ret) {
 		rtw89_debug(rtwdev, RTW89_DBG_SAR,
 			    "acpi: cannot get TAS: %d\n", ret);
 		return;
 	}
 
+	val = res.u.value;
 	switch (val) {
 	case 0:
 		tas->enable = false;
-- 
2.25.1

