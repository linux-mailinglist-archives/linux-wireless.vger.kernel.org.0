Return-Path: <linux-wireless+bounces-6250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5468A2DE3
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 13:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5533928351D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 11:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694AD55E4F;
	Fri, 12 Apr 2024 11:59:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA155E51
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923184; cv=none; b=WjuwSQwzwDewnq4N4SVermezi8WLI/ziSEnGc59UdPx/WScAz65mBxERMme8kRDGqm6H67pgWCCFZEq3M8yoIsnWIpO5A/lwZkfL7C7xxEXq8LREv9PS3JvzHLVbpikaLYDisNBKGB5ErnzZ+t8qW2lbiH9iEpk2Rn8WHsici7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923184; c=relaxed/simple;
	bh=RAbZz17RXetLFjGBiG2aEQC/u7J2VTLzIk/g7jNNacE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd2i0x4SHSVf7lAeA/rIjK7E/ZrFZVwEFz2n+crwXzaXeLgR9MLpoovHJIwAzJ2976hnmY73dJtgY4ys0W0NtUKiBGS3LhsgT+NloHfV7iwUhLqf3oKSV8XgUHV4c60Q+3QyMTv1gfmdroo9ozdAyiTGZUh0kgDj+kEZHle2osI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43CBxdJU32094298, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43CBxdJU32094298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 19:59:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 19:59:40 +0800
Received: from [127.0.1.1] (172.16.17.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Apr
 2024 19:59:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 6/8] wifi: rtw89: regd: extend policy of UNII-4 for IC regulatory
Date: Fri, 12 Apr 2024 19:57:27 +0800
Message-ID: <20240412115729.8316-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412115729.8316-1-pkshih@realtek.com>
References: <20240412115729.8316-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Originally, we have an ACPI function to determine whether to enable UNII-4.
Since IC (Industry Canada) has allowed UNII-4, the ACPI result is extended
to be two bits as below.
  * BIT(0): determine if rtw89_regd::FCC enable UNII-4
  * BIT(1): determine if rtw89_regd::IC enable UNII-4

Besides, to take old platforms into account, we enable UNII-4 on IC if and
only if BIOS configuration enable it.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/acpi.h |  7 +-
 drivers/net/wireless/realtek/rtw89/core.c |  3 +
 drivers/net/wireless/realtek/rtw89/core.h |  3 +
 drivers/net/wireless/realtek/rtw89/regd.c | 91 ++++++++++++++++-------
 4 files changed, 77 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/acpi.h b/drivers/net/wireless/realtek/rtw89/acpi.h
index fe85b40cf076..5182797e68b6 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.h
+++ b/drivers/net/wireless/realtek/rtw89/acpi.h
@@ -12,7 +12,12 @@ enum rtw89_acpi_dsm_func {
 	RTW89_ACPI_DSM_FUNC_6G_DIS = 3,
 	RTW89_ACPI_DSM_FUNC_6G_BP = 4,
 	RTW89_ACPI_DSM_FUNC_TAS_EN = 5,
-	RTW89_ACPI_DSM_FUNC_59G_EN = 6,
+	RTW89_ACPI_DSM_FUNC_UNII4_SUP = 6,
+};
+
+enum rtw89_acpi_conf_unii4 {
+	RTW89_ACPI_CONF_UNII4_FCC = BIT(0),
+	RTW89_ACPI_CONF_UNII4_IC = BIT(1),
 };
 
 enum rtw89_acpi_policy_mode {
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 52588f04155a..a02c26b51fa6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -82,6 +82,9 @@ static struct ieee80211_channel rtw89_channels_5ghz[] = {
 	RTW89_DEF_CHAN_5G(5885, 177),
 };
 
+static_assert(RTW89_5GHZ_UNII4_START_INDEX + RTW89_5GHZ_UNII4_CHANNEL_NUM ==
+	      ARRAY_SIZE(rtw89_channels_5ghz));
+
 static struct ieee80211_channel rtw89_channels_6ghz[] = {
 	RTW89_DEF_CHAN_6G(5955, 1),
 	RTW89_DEF_CHAN_6G(5975, 5),
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2cc8785f3205..7cd6b3179713 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4752,10 +4752,13 @@ struct rtw89_regd {
 };
 
 #define RTW89_REGD_MAX_COUNTRY_NUM U8_MAX
+#define RTW89_5GHZ_UNII4_CHANNEL_NUM 3
+#define RTW89_5GHZ_UNII4_START_INDEX 25
 
 struct rtw89_regulatory_info {
 	const struct rtw89_regd *regd;
 	enum rtw89_reg_6ghz_power reg_6ghz_power;
+	DECLARE_BITMAP(block_unii4, RTW89_REGD_MAX_COUNTRY_NUM);
 	DECLARE_BITMAP(block_6ghz, RTW89_REGD_MAX_COUNTRY_NUM);
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 85a7f902ccf9..47384615e18c 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -341,51 +341,60 @@ do { \
 static void rtw89_regd_setup_unii4(struct rtw89_dev *rtwdev,
 				   struct wiphy *wiphy)
 {
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	bool regd_allow_unii_4 = chip->support_unii4;
 	struct ieee80211_supported_band *sband;
 	struct rtw89_acpi_dsm_result res = {};
+	bool enable_by_fcc;
+	bool enable_by_ic;
 	int ret;
 	u8 val;
+	int i;
 
-	if (!chip->support_unii4)
-		goto bottom;
+	sband = wiphy->bands[NL80211_BAND_5GHZ];
+	if (!sband)
+		return;
 
-	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_59G_EN, &res);
+	if (!chip->support_unii4) {
+		sband->n_channels -= RTW89_5GHZ_UNII4_CHANNEL_NUM;
+		return;
+	}
+
+	bitmap_fill(regulatory->block_unii4, RTW89_REGD_MAX_COUNTRY_NUM);
+
+	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_UNII4_SUP, &res);
 	if (ret) {
 		rtw89_debug(rtwdev, RTW89_DBG_REGD,
 			    "acpi: cannot eval unii 4: %d\n", ret);
+		enable_by_fcc = true;
+		enable_by_ic = false;
 		goto bottom;
 	}
 
 	val = res.u.value;
+	enable_by_fcc = u8_get_bits(val, RTW89_ACPI_CONF_UNII4_FCC);
+	enable_by_ic = u8_get_bits(val, RTW89_ACPI_CONF_UNII4_IC);
 
 	rtw89_debug(rtwdev, RTW89_DBG_REGD,
-		    "acpi: eval if allow unii 4: %d\n", val);
-
-	switch (val) {
-	case 0:
-		regd_allow_unii_4 = false;
-		break;
-	case 1:
-		regd_allow_unii_4 = true;
-		break;
-	default:
-		break;
-	}
+		    "acpi: eval if allow unii-4: 0x%x\n", val);
 
 bottom:
-	rtw89_debug(rtwdev, RTW89_DBG_REGD, "regd: allow unii 4: %d\n",
-		    regd_allow_unii_4);
-
-	if (regd_allow_unii_4)
-		return;
-
-	sband = wiphy->bands[NL80211_BAND_5GHZ];
-	if (!sband)
-		return;
+	for (i = 0; i < ARRAY_SIZE(rtw89_regd_map); i++) {
+		const struct rtw89_regd *regd = &rtw89_regd_map[i];
 
-	sband->n_channels -= 3;
+		switch (regd->txpwr_regd[RTW89_BAND_5G]) {
+		case RTW89_FCC:
+			if (enable_by_fcc)
+				clear_bit(i, regulatory->block_unii4);
+			break;
+		case RTW89_IC:
+			if (enable_by_ic)
+				clear_bit(i, regulatory->block_unii4);
+			break;
+		default:
+			break;
+		}
+	}
 }
 
 static void __rtw89_regd_setup_policy_6ghz(struct rtw89_dev *rtwdev, bool block,
@@ -562,6 +571,35 @@ int rtw89_regd_init(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static void rtw89_regd_apply_policy_unii4(struct rtw89_dev *rtwdev,
+					  struct wiphy *wiphy)
+{
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_regd *regd = regulatory->regd;
+	struct ieee80211_supported_band *sband;
+	u8 index;
+	int i;
+
+	sband = wiphy->bands[NL80211_BAND_5GHZ];
+	if (!sband)
+		return;
+
+	if (!chip->support_unii4)
+		return;
+
+	index = rtw89_regd_get_index(regd);
+	if (index != RTW89_REGD_MAX_COUNTRY_NUM &&
+	    !test_bit(index, regulatory->block_unii4))
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_REGD, "%c%c unii-4 is blocked by policy\n",
+		    regd->alpha2[0], regd->alpha2[1]);
+
+	for (i = RTW89_5GHZ_UNII4_START_INDEX; i < sband->n_channels; i++)
+		sband->channels[i].flags |= IEEE80211_CHAN_DISABLED;
+}
+
 static void rtw89_regd_apply_policy_6ghz(struct rtw89_dev *rtwdev,
 					 struct wiphy *wiphy)
 {
@@ -602,6 +640,7 @@ static void rtw89_regd_notifier_apply(struct rtw89_dev *rtwdev,
 	else
 		wiphy->regulatory_flags &= ~REGULATORY_COUNTRY_IE_IGNORE;
 
+	rtw89_regd_apply_policy_unii4(rtwdev, wiphy);
 	rtw89_regd_apply_policy_6ghz(rtwdev, wiphy);
 }
 
-- 
2.25.1


