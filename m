Return-Path: <linux-wireless+bounces-17725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349EFA165A5
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 04:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5158C3A4B15
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 03:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359F213D51E;
	Mon, 20 Jan 2025 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="S1rmBjnM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DCE13AA5D
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 03:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737343682; cv=none; b=tkleISdNPzn/3Vqi9Olt1+uk7dM9IkCOyPKoULQzG/orpUgAXWMZ4tna0aeu+UhNsNiTeMTLLjtrrhZpzBRXaax0dvbtAhYJCJFS1bXKYERnznxBk53OyZ4WqaTRbQvZkR166f87b/l0FEdPenJabvjHhF/Fxc9L3bVCS9sPJPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737343682; c=relaxed/simple;
	bh=UAye97b195teafTJzXxxNJp4TN90q53vDsoog9sh5ME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c37+/yT8YeIh5Lui3GrK0TaJPQ1yCZHguUYkzSt5DH0ofwswu5l5+zp3ACoSZ2HKw6B8M7pCAMnFUf4KaLuNtVXR3NSOCB3XsFpBbJroX/V25ika0CC84cuOw7BeYBfX9Q3/5DmzLbRm7nXRQSkCK7I+zmxVZOCKZSSTKG775do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=S1rmBjnM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50K3RuOcA2654408, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737343676; bh=UAye97b195teafTJzXxxNJp4TN90q53vDsoog9sh5ME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=S1rmBjnMjClr9SJ1bIccqf6DYaWdaK6ngehtWFixeeNZ7RD3yEWaw/Iw1ZUGNt59T
	 G7/9TaPh3gC+vkqVkthQ1E1mxVE82uIaPP2UashF1XvkH/mGPTl6yw3EWw0dU39N/A
	 A8A+glZIszSjnJO8wHdK17/p5JFVGDpZ55Tiuv0Y2S5OoH4e0gNfmKYWHLtykb3faD
	 o/wAh4wAEAivcHKvIqrBA9J1FronDJXtyFq3uXKP1YgxNMXk62kRA3GPj3gU6YhA9D
	 areSyAVPPbrG8wFdLdFEqyYBdmdSYiuwrDBX5DBKTOvZ7PO0gyUeT4E4bWsUiW3x60
	 lH6HOuI8cIX0A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50K3RuOcA2654408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 11:27:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 Jan 2025 11:27:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 20 Jan
 2025 11:27:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 1/3] wifi: rtw89: regd: support loading regd table from fw element
Date: Mon, 20 Jan 2025 11:27:21 +0800
Message-ID: <20250120032723.19042-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250120032723.19042-1-pkshih@realtek.com>
References: <20250120032723.19042-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Regd table is a table that we use to describe how to map Realtek RF TX
power settings on different countries. Originally, a common regd table
for all chips is implemented in driver. However, in order to work on all
chips, the common regd table might have some trade-off. So now, there are
also an individual regd table for some chips. And, we support loading it
from FW element.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 14 ++++
 drivers/net/wireless/realtek/rtw89/fw.c   | 86 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   | 22 ++++++
 drivers/net/wireless/realtek/rtw89/regd.c | 66 +++++++++++------
 4 files changed, 166 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0f2a46e36b04..7257b5dc1cbc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -22,6 +22,7 @@ struct rtw89_h2c_rf_tssi;
 struct rtw89_fw_txpwr_track_cfg;
 struct rtw89_phy_rfk_log_fmt;
 struct rtw89_debugfs;
+struct rtw89_regd_data;
 
 extern const struct ieee80211_ops rtw89_ops;
 
@@ -718,6 +719,7 @@ enum rtw89_ofdma_type {
 	RTW89_OFDMA_NUM,
 };
 
+/* neither insert new in the middle, nor change any given definition */
 enum rtw89_regulation_type {
 	RTW89_WW	= 0,
 	RTW89_ETSI	= 1,
@@ -4537,6 +4539,7 @@ struct rtw89_fw_elm_info {
 	struct rtw89_phy_table *rf_nctl;
 	struct rtw89_fw_txpwr_track_cfg *txpwr_trk;
 	struct rtw89_phy_rfk_log_fmt *rfk_log_fmt;
+	const struct rtw89_regd_data *regd;
 };
 
 enum rtw89_fw_mss_dev_type {
@@ -5152,11 +5155,22 @@ struct rtw89_regd {
 	u8 txpwr_regd[RTW89_BAND_NUM];
 };
 
+struct rtw89_regd_data {
+	unsigned int nr;
+	struct rtw89_regd map[] __counted_by(nr);
+};
+
+struct rtw89_regd_ctrl {
+	unsigned int nr;
+	const struct rtw89_regd *map;
+};
+
 #define RTW89_REGD_MAX_COUNTRY_NUM U8_MAX
 #define RTW89_5GHZ_UNII4_CHANNEL_NUM 3
 #define RTW89_5GHZ_UNII4_START_INDEX 25
 
 struct rtw89_regulatory_info {
+	struct rtw89_regd_ctrl ctrl;
 	const struct rtw89_regd *regd;
 	enum rtw89_reg_6ghz_power reg_6ghz_power;
 	struct rtw89_reg_6ghz_tpe reg_6ghz_tpe;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 5cc9ab78c09f..7b7994b8e1aa 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1056,6 +1056,89 @@ int rtw89_build_rfk_log_fmt_from_elm(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static bool rtw89_regd_entcpy(struct rtw89_regd *regd, const void *cursor,
+			      u8 cursor_size)
+{
+	/* fill default values if needed for backward compatibility */
+	struct rtw89_fw_regd_entry entry = {
+		.rule_2ghz = RTW89_NA,
+		.rule_5ghz = RTW89_NA,
+		.rule_6ghz = RTW89_NA,
+	};
+	u8 valid_size = min_t(u8, sizeof(entry), cursor_size);
+
+	memcpy(&entry, cursor, valid_size);
+	memset(regd, 0, sizeof(*regd));
+
+	regd->alpha2[0] = entry.alpha2_0;
+	regd->alpha2[1] = entry.alpha2_1;
+	regd->alpha2[2] = '\0';
+
+	/* also need to consider forward compatibility */
+	regd->txpwr_regd[RTW89_BAND_2G] = entry.rule_2ghz < RTW89_REGD_NUM ?
+					  entry.rule_2ghz : RTW89_NA;
+	regd->txpwr_regd[RTW89_BAND_5G] = entry.rule_5ghz < RTW89_REGD_NUM ?
+					  entry.rule_5ghz : RTW89_NA;
+	regd->txpwr_regd[RTW89_BAND_6G] = entry.rule_6ghz < RTW89_REGD_NUM ?
+					  entry.rule_6ghz : RTW89_NA;
+
+	return true;
+}
+
+#define rtw89_for_each_in_regd_element(regd, element) \
+	for (const void *cursor = (element)->content, \
+	     *end = (element)->content + \
+		    le32_to_cpu((element)->num_ents) * (element)->ent_sz; \
+	     cursor < end; cursor += (element)->ent_sz) \
+		if (rtw89_regd_entcpy(regd, cursor, (element)->ent_sz))
+
+static
+int rtw89_recognize_regd_from_elm(struct rtw89_dev *rtwdev,
+				  const struct rtw89_fw_element_hdr *elm,
+				  const union rtw89_fw_element_arg arg)
+{
+	const struct __rtw89_fw_regd_element *regd_elm = &elm->u.regd;
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
+	u32 num_ents = le32_to_cpu(regd_elm->num_ents);
+	struct rtw89_regd_data *p;
+	struct rtw89_regd regd;
+	u32 i = 0;
+
+	if (num_ents > RTW89_REGD_MAX_COUNTRY_NUM) {
+		rtw89_warn(rtwdev,
+			   "regd element ents (%d) are over max num (%d)\n",
+			   num_ents, RTW89_REGD_MAX_COUNTRY_NUM);
+		rtw89_warn(rtwdev,
+			   "regd element ignore and take another/common\n");
+		return 1;
+	}
+
+	if (elm_info->regd) {
+		rtw89_debug(rtwdev, RTW89_DBG_REGD,
+			    "regd element take the latter\n");
+		devm_kfree(rtwdev->dev, elm_info->regd);
+		elm_info->regd = NULL;
+	}
+
+	p = devm_kzalloc(rtwdev->dev, struct_size(p, map, num_ents), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	p->nr = num_ents;
+	rtw89_for_each_in_regd_element(&regd, regd_elm)
+		p->map[i++] = regd;
+
+	if (i != num_ents) {
+		rtw89_err(rtwdev, "regd element has %d invalid ents\n",
+			  num_ents - i);
+		devm_kfree(rtwdev->dev, p);
+		return -EINVAL;
+	}
+
+	elm_info->regd = p;
+	return 0;
+}
+
 static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 	[RTW89_FW_ELEMENT_ID_BBMCU0] = {__rtw89_fw_recognize_from_elm,
 					{ .fw_type = RTW89_FW_BBMCU0 }, NULL},
@@ -1114,6 +1197,9 @@ static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 	[RTW89_FW_ELEMENT_ID_RFKLOG_FMT] = {
 		rtw89_build_rfk_log_fmt_from_elm, {}, NULL,
 	},
+	[RTW89_FW_ELEMENT_ID_REGD] = {
+		rtw89_recognize_regd_from_elm, {}, "REGD",
+	},
 };
 
 int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 2026bc2fd2ac..c55eabe0138d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3882,6 +3882,7 @@ enum rtw89_fw_element_id {
 	RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT_RU = 17,
 	RTW89_FW_ELEMENT_ID_TXPWR_TRK = 18,
 	RTW89_FW_ELEMENT_ID_RFKLOG_FMT = 19,
+	RTW89_FW_ELEMENT_ID_REGD = 20,
 
 	RTW89_FW_ELEMENT_ID_NUM,
 };
@@ -3925,6 +3926,15 @@ struct __rtw89_fw_txpwr_element {
 	u8 content[];
 } __packed;
 
+struct __rtw89_fw_regd_element {
+	u8 rsvd0;
+	u8 rsvd1;
+	u8 rsvd2;
+	u8 ent_sz;
+	__le32 num_ents;
+	u8 content[];
+} __packed;
+
 enum rtw89_fw_txpwr_trk_type {
 	__RTW89_FW_TXPWR_TRK_TYPE_6GHZ_START = 0,
 	RTW89_FW_TXPWR_TRK_TYPE_6GB_N = 0,
@@ -4016,6 +4026,7 @@ struct rtw89_fw_element_hdr {
 			__le16 offset[];
 		} __packed rfk_log_fmt;
 		struct __rtw89_fw_txpwr_element txpwr;
+		struct __rtw89_fw_regd_element regd;
 	} __packed u;
 } __packed;
 
@@ -4874,6 +4885,17 @@ int rtw89_chip_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 	return 0;
 }
 
+/* Must consider compatibility; don't insert new in the mid.
+ * Fill each field's default value in rtw89_regd_entcpy().
+ */
+struct rtw89_fw_regd_entry {
+	u8 alpha2_0;
+	u8 alpha2_1;
+	u8 rule_2ghz;
+	u8 rule_5ghz;
+	u8 rule_6ghz;
+} __packed;
+
 /* must consider compatibility; don't insert new in the mid */
 struct rtw89_fw_txpwr_byrate_entry {
 	u8 band;
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 80b2f74589eb..aea37dae8ef9 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -7,9 +7,12 @@
 #include "ps.h"
 #include "util.h"
 
-#define COUNTRY_REGD(_alpha2, _txpwr_regd...) \
-	{.alpha2 = (_alpha2), \
-	 .txpwr_regd = {_txpwr_regd}, \
+#define COUNTRY_REGD(_alpha2, _rule_2ghz, _rule_5ghz, _rule_6ghz) \
+	{							\
+		.alpha2 = _alpha2,				\
+		.txpwr_regd[RTW89_BAND_2G] = _rule_2ghz,	\
+		.txpwr_regd[RTW89_BAND_5G] = _rule_5ghz,	\
+		.txpwr_regd[RTW89_BAND_6G] = _rule_6ghz,	\
 	}
 
 static const struct rtw89_regd rtw89_ww_regd =
@@ -295,13 +298,16 @@ static const char rtw89_alpha2_list_eu[][3] = {
 	"RO",
 };
 
-static const struct rtw89_regd *rtw89_regd_find_reg_by_name(const char *alpha2)
+static const struct rtw89_regd *rtw89_regd_find_reg_by_name(struct rtw89_dev *rtwdev,
+							    const char *alpha2)
 {
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_regd_ctrl *regd_ctrl = &regulatory->ctrl;
 	u32 i;
 
-	for (i = 0; i < ARRAY_SIZE(rtw89_regd_map); i++) {
-		if (!memcmp(rtw89_regd_map[i].alpha2, alpha2, 2))
-			return &rtw89_regd_map[i];
+	for (i = 0; i < regd_ctrl->nr; i++) {
+		if (!memcmp(regd_ctrl->map[i].alpha2, alpha2, 2))
+			return &regd_ctrl->map[i];
 	}
 
 	return &rtw89_ww_regd;
@@ -312,22 +318,25 @@ static bool rtw89_regd_is_ww(const struct rtw89_regd *regd)
 	return regd == &rtw89_ww_regd;
 }
 
-static u8 rtw89_regd_get_index(const struct rtw89_regd *regd)
+static u8 rtw89_regd_get_index(struct rtw89_dev *rtwdev, const struct rtw89_regd *regd)
 {
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_regd_ctrl *regd_ctrl = &regulatory->ctrl;
+
 	BUILD_BUG_ON(ARRAY_SIZE(rtw89_regd_map) > RTW89_REGD_MAX_COUNTRY_NUM);
 
 	if (rtw89_regd_is_ww(regd))
 		return RTW89_REGD_MAX_COUNTRY_NUM;
 
-	return regd - rtw89_regd_map;
+	return regd - regd_ctrl->map;
 }
 
-static u8 rtw89_regd_get_index_by_name(const char *alpha2)
+static u8 rtw89_regd_get_index_by_name(struct rtw89_dev *rtwdev, const char *alpha2)
 {
 	const struct rtw89_regd *regd;
 
-	regd = rtw89_regd_find_reg_by_name(alpha2);
-	return rtw89_regd_get_index(regd);
+	regd = rtw89_regd_find_reg_by_name(rtwdev, alpha2);
+	return rtw89_regd_get_index(rtwdev, regd);
 }
 
 #define rtw89_debug_regd(_dev, _regd, _desc, _argv...) \
@@ -345,6 +354,7 @@ static void rtw89_regd_setup_unii4(struct rtw89_dev *rtwdev,
 				   struct wiphy *wiphy)
 {
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_regd_ctrl *regd_ctrl = &regulatory->ctrl;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct ieee80211_supported_band *sband;
 	struct rtw89_acpi_dsm_result res = {};
@@ -382,8 +392,8 @@ static void rtw89_regd_setup_unii4(struct rtw89_dev *rtwdev,
 		    "acpi: eval if allow unii-4: 0x%x\n", val);
 
 bottom:
-	for (i = 0; i < ARRAY_SIZE(rtw89_regd_map); i++) {
-		const struct rtw89_regd *regd = &rtw89_regd_map[i];
+	for (i = 0; i < regd_ctrl->nr; i++) {
+		const struct rtw89_regd *regd = &regd_ctrl->map[i];
 
 		switch (regd->txpwr_regd[RTW89_BAND_5G]) {
 		case RTW89_FCC:
@@ -406,7 +416,7 @@ static void __rtw89_regd_setup_policy_6ghz(struct rtw89_dev *rtwdev, bool block,
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
 	u8 index;
 
-	index = rtw89_regd_get_index_by_name(alpha2);
+	index = rtw89_regd_get_index_by_name(rtwdev, alpha2);
 	if (index == RTW89_REGD_MAX_COUNTRY_NUM) {
 		rtw89_debug(rtwdev, RTW89_DBG_REGD, "%s: unknown alpha2 %c%c\n",
 			    __func__, alpha2[0], alpha2[1]);
@@ -474,6 +484,7 @@ static void rtw89_regd_setup_policy_6ghz(struct rtw89_dev *rtwdev)
 static void rtw89_regd_setup_policy_6ghz_sp(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_regd_ctrl *regd_ctrl = &regulatory->ctrl;
 	const struct rtw89_acpi_policy_6ghz_sp *ptr;
 	struct rtw89_acpi_dsm_result res = {};
 	bool enable_by_us;
@@ -505,8 +516,8 @@ static void rtw89_regd_setup_policy_6ghz_sp(struct rtw89_dev *rtwdev)
 
 	enable_by_us = u8_get_bits(ptr->conf, RTW89_ACPI_CONF_6GHZ_SP_US);
 
-	for (i = 0; i < ARRAY_SIZE(rtw89_regd_map); i++) {
-		const struct rtw89_regd *tmp = &rtw89_regd_map[i];
+	for (i = 0; i < regd_ctrl->nr; i++) {
+		const struct rtw89_regd *tmp = &regd_ctrl->map[i];
 
 		if (enable_by_us && memcmp(tmp->alpha2, "US", 2) == 0)
 			clear_bit(i, regulatory->block_6ghz_sp);
@@ -573,8 +584,19 @@ static void rtw89_regd_setup_6ghz(struct rtw89_dev *rtwdev, struct wiphy *wiphy)
 
 int rtw89_regd_setup(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
+	const struct rtw89_regd_data *regd_data = elm_info->regd;
 	struct wiphy *wiphy = rtwdev->hw->wiphy;
 
+	if (regd_data) {
+		regulatory->ctrl.nr = regd_data->nr;
+		regulatory->ctrl.map = regd_data->map;
+	} else {
+		regulatory->ctrl.nr = ARRAY_SIZE(rtw89_regd_map);
+		regulatory->ctrl.map = rtw89_regd_map;
+	}
+
 	if (!wiphy)
 		return -EINVAL;
 
@@ -599,7 +621,7 @@ int rtw89_regd_init(struct rtw89_dev *rtwdev,
 	if (!wiphy)
 		return -EINVAL;
 
-	chip_regd = rtw89_regd_find_reg_by_name(rtwdev->efuse.country_code);
+	chip_regd = rtw89_regd_find_reg_by_name(rtwdev, rtwdev->efuse.country_code);
 	if (!rtw89_regd_is_ww(chip_regd)) {
 		rtwdev->regulatory.regd = chip_regd;
 		/* Ignore country ie if there is a country domain programmed in chip */
@@ -637,7 +659,7 @@ static void rtw89_regd_apply_policy_unii4(struct rtw89_dev *rtwdev,
 	if (!chip->support_unii4)
 		return;
 
-	index = rtw89_regd_get_index(regd);
+	index = rtw89_regd_get_index(rtwdev, regd);
 	if (index != RTW89_REGD_MAX_COUNTRY_NUM &&
 	    !test_bit(index, regulatory->block_unii4))
 		return;
@@ -655,7 +677,7 @@ static bool regd_is_6ghz_blocked(struct rtw89_dev *rtwdev)
 	const struct rtw89_regd *regd = regulatory->regd;
 	u8 index;
 
-	index = rtw89_regd_get_index(regd);
+	index = rtw89_regd_get_index(rtwdev, regd);
 	if (index != RTW89_REGD_MAX_COUNTRY_NUM &&
 	    !test_bit(index, regulatory->block_6ghz))
 		return false;
@@ -700,7 +722,7 @@ static void rtw89_regd_notifier_apply(struct rtw89_dev *rtwdev,
 				      struct wiphy *wiphy,
 				      struct regulatory_request *request)
 {
-	rtwdev->regulatory.regd = rtw89_regd_find_reg_by_name(request->alpha2);
+	rtwdev->regulatory.regd = rtw89_regd_find_reg_by_name(rtwdev, request->alpha2);
 	/* This notification might be set from the system of distros,
 	 * and it does not expect the regulatory will be modified by
 	 * connecting to an AP (i.e. country ie).
@@ -925,7 +947,7 @@ static bool __rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev)
 		sel = RTW89_REG_6GHZ_POWER_DFLT;
 
 	if (sel == RTW89_REG_6GHZ_POWER_STD) {
-		index = rtw89_regd_get_index(regd);
+		index = rtw89_regd_get_index(rtwdev, regd);
 		if (index == RTW89_REGD_MAX_COUNTRY_NUM ||
 		    test_bit(index, regulatory->block_6ghz_sp)) {
 			rtw89_debug(rtwdev, RTW89_DBG_REGD,
-- 
2.25.1


