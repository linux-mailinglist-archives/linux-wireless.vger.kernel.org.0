Return-Path: <linux-wireless+bounces-20599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAC1A69EC3
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 04:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A754460AFD
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 03:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA8D1E98FB;
	Thu, 20 Mar 2025 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dteZCC+w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F361EDA15
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 03:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441274; cv=none; b=qxJaoMG45uBvWQYKoXTxtpZ338699DxUkWnBq2P3XutEqDD2Bv2PO5WWNyMmo82dZN9MBGX/IHXqaxldpYfrGh00LlLM+eBWWt655suDa7hOjyLlmMdehFuEln+jtVvUFFdJh5Zk4ROQCFhfYbDfon3Pbf/K+lit7fLPEbTVlCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441274; c=relaxed/simple;
	bh=GuXPZTKuv/aAkyFaXEAX5OeaqRKI0aTG1PItEPEuLxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFZtSa+z32qBf84JyThW+8h5H42PBenkV6SJ19NFO1Jue0O8G9ARXBxfs0A07M8ou48PKi/LpRZmMjxdexU72izWR4UGYnUX+Ms4sGXKPj6UPAGEnfKWtYruETm6SU0dCm+eEzGh+IYGl/xAzuShsFjEoBpNXz5xE7vR5D1hPM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dteZCC+w; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52K3RmqnE1750920, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742441269; bh=GuXPZTKuv/aAkyFaXEAX5OeaqRKI0aTG1PItEPEuLxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dteZCC+w89MBA/u5xTo75lRKT6g3TOXXJcbegKaB3r/11e8BXSNwkdxJTJ0/h/z3+
	 v/EJMqh5iX5zWSM1+dv3n+yZjO6wdQKJSX+HND0vwXqYLvkCnVKKWmaS3/bxkzf0Ir
	 tFRtPPorU4UGoI5j2M+dTrG+ZCEqJuYmb7yrE3xh9RBYQI4ZkuV5TKzubGpGlqejj2
	 J83pLQvvzveFzGi6VZ1tx3Iaj6Jkje2TweSXOTgYMULvCYum9wVnQOVPtz0oBdcuEl
	 4HW+I2E0qAoElPzXULUit4dTKUtP60JMkgSr0lh9TaAu9TMqRuAF2nhxMTj78GCoiv
	 YOYzTENWZ4aDA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52K3RmqnE1750920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 11:27:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 11:27:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Mar
 2025 11:27:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 04/12] wifi: rtw89: sar: add skeleton for SAR configuration via ACPI
Date: Thu, 20 Mar 2025 11:27:04 +0800
Message-ID: <20250320032712.20284-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320032712.20284-1-pkshih@realtek.com>
References: <20250320032712.20284-1-pkshih@realtek.com>
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

To support SAR configuration in BIOS via ACPI, add related subbnad/band
converting/handling function and define SW format to store result after
parsing. Then, register a new SAR source, i.e. ACPI, into SAR flow and
implement its query function.

Besides, tweak priority of common SAR to be the highest. And, ACPI SAR
can just be configured once when no other sources is already working.
For now, evaluating SAR via ACPI returns -ENOENT, i.e. ACPI SAR doesn't
really work yet. The evaluating flow will be implemented in the following.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/acpi.c |  79 ++++++++++++
 drivers/net/wireless/realtek/rtw89/acpi.h |   7 ++
 drivers/net/wireless/realtek/rtw89/core.c |   4 +-
 drivers/net/wireless/realtek/rtw89/core.h |  44 +++++++
 drivers/net/wireless/realtek/rtw89/phy.c  |   2 +
 drivers/net/wireless/realtek/rtw89/sar.c  | 143 ++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/sar.h  |   3 +-
 7 files changed, 269 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/acpi.c b/drivers/net/wireless/realtek/rtw89/acpi.c
index f5dedb12c129..b870a3df4072 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.c
+++ b/drivers/net/wireless/realtek/rtw89/acpi.c
@@ -195,3 +195,82 @@ int rtw89_acpi_evaluate_rtag(struct rtw89_dev *rtwdev,
 	ACPI_FREE(obj);
 	return ret;
 }
+
+enum rtw89_acpi_sar_subband rtw89_acpi_sar_get_subband(struct rtw89_dev *rtwdev,
+						       u32 center_freq)
+{
+	switch (center_freq) {
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI,
+			    "center freq %u to ACPI SAR subband is unhandled\n",
+			    center_freq);
+		fallthrough;
+	case 2412 ... 2484:
+		return RTW89_ACPI_SAR_2GHZ_SUBBAND;
+	case 5180 ... 5240:
+		return RTW89_ACPI_SAR_5GHZ_SUBBAND_1;
+	case 5250 ... 5320:
+		return RTW89_ACPI_SAR_5GHZ_SUBBAND_2;
+	case 5500 ... 5720:
+		return RTW89_ACPI_SAR_5GHZ_SUBBAND_2E;
+	case 5745 ... 5885:
+		return RTW89_ACPI_SAR_5GHZ_SUBBAND_3_4;
+	case 5955 ... 6155:
+		return RTW89_ACPI_SAR_6GHZ_SUBBAND_5_L;
+	case 6175 ... 6415:
+		return RTW89_ACPI_SAR_6GHZ_SUBBAND_5_H;
+	case 6435 ... 6515:
+		return RTW89_ACPI_SAR_6GHZ_SUBBAND_6;
+	case 6535 ... 6695:
+		return RTW89_ACPI_SAR_6GHZ_SUBBAND_7_L;
+	case 6715 ... 6855:
+		return RTW89_ACPI_SAR_6GHZ_SUBBAND_7_H;
+
+	/* freq 6875 (ch 185, 20MHz) spans RTW89_ACPI_SAR_6GHZ_SUBBAND_7_H
+	 * and RTW89_ACPI_SAR_6GHZ_SUBBAND_8, so directly describe it with
+	 * struct rtw89_6ghz_span.
+	 */
+
+	case 6895 ... 7115:
+		return RTW89_ACPI_SAR_6GHZ_SUBBAND_8;
+	}
+}
+
+enum rtw89_band rtw89_acpi_sar_subband_to_band(struct rtw89_dev *rtwdev,
+					       enum rtw89_acpi_sar_subband subband)
+{
+	switch (subband) {
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI,
+			    "ACPI SAR subband %u to band is unhandled\n", subband);
+		fallthrough;
+	case RTW89_ACPI_SAR_2GHZ_SUBBAND:
+		return RTW89_BAND_2G;
+	case RTW89_ACPI_SAR_5GHZ_SUBBAND_1:
+		return RTW89_BAND_5G;
+	case RTW89_ACPI_SAR_5GHZ_SUBBAND_2:
+		return RTW89_BAND_5G;
+	case RTW89_ACPI_SAR_5GHZ_SUBBAND_2E:
+		return RTW89_BAND_5G;
+	case RTW89_ACPI_SAR_5GHZ_SUBBAND_3_4:
+		return RTW89_BAND_5G;
+	case RTW89_ACPI_SAR_6GHZ_SUBBAND_5_L:
+		return RTW89_BAND_6G;
+	case RTW89_ACPI_SAR_6GHZ_SUBBAND_5_H:
+		return RTW89_BAND_6G;
+	case RTW89_ACPI_SAR_6GHZ_SUBBAND_6:
+		return RTW89_BAND_6G;
+	case RTW89_ACPI_SAR_6GHZ_SUBBAND_7_L:
+		return RTW89_BAND_6G;
+	case RTW89_ACPI_SAR_6GHZ_SUBBAND_7_H:
+		return RTW89_BAND_6G;
+	case RTW89_ACPI_SAR_6GHZ_SUBBAND_8:
+		return RTW89_BAND_6G;
+	}
+}
+
+int rtw89_acpi_evaluate_sar(struct rtw89_dev *rtwdev,
+			    struct rtw89_sar_cfg_acpi *cfg)
+{
+	return -ENOENT;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/acpi.h b/drivers/net/wireless/realtek/rtw89/acpi.h
index b43ab106e44d..a7f583a2164f 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.h
+++ b/drivers/net/wireless/realtek/rtw89/acpi.h
@@ -70,10 +70,17 @@ struct rtw89_acpi_rtag_result {
 	u8 ant_gain_table[RTW89_ANT_GAIN_CHAIN_NUM][RTW89_ANT_GAIN_SUBBAND_NR];
 } __packed;
 
+enum rtw89_acpi_sar_subband rtw89_acpi_sar_get_subband(struct rtw89_dev *rtwdev,
+						       u32 center_freq);
+enum rtw89_band rtw89_acpi_sar_subband_to_band(struct rtw89_dev *rtwdev,
+					       enum rtw89_acpi_sar_subband subband);
+
 int rtw89_acpi_evaluate_dsm(struct rtw89_dev *rtwdev,
 			    enum rtw89_acpi_dsm_func func,
 			    struct rtw89_acpi_dsm_result *res);
 int rtw89_acpi_evaluate_rtag(struct rtw89_dev *rtwdev,
 			     struct rtw89_acpi_rtag_result *res);
+int rtw89_acpi_evaluate_sar(struct rtw89_dev *rtwdev,
+			    struct rtw89_sar_cfg_acpi *cfg);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index cc9b014457ac..2088c6f4a98e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -211,6 +211,8 @@ static const struct ieee80211_iface_combination rtw89_iface_combs[] = {
 	[RTW89_6GHZ_SPAN_IDX(center_freq)] = { \
 		.sar_subband_low = RTW89_SAR_6GHZ_ ## subband_l, \
 		.sar_subband_high = RTW89_SAR_6GHZ_ ## subband_h, \
+		.acpi_sar_subband_low = RTW89_ACPI_SAR_6GHZ_ ## subband_l, \
+		.acpi_sar_subband_high = RTW89_ACPI_SAR_6GHZ_ ## subband_h, \
 		.ant_gain_subband_low = RTW89_ANT_GAIN_6GHZ_ ## subband_l, \
 		.ant_gain_subband_high = RTW89_ANT_GAIN_6GHZ_ ## subband_h, \
 	}
@@ -4919,7 +4921,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 
 	rtw89_ser_init(rtwdev);
 	rtw89_entity_init(rtwdev);
-	rtw89_tas_init(rtwdev);
+	rtw89_sar_init(rtwdev);
 	rtw89_phy_ant_gain_init(rtwdev);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 18340a9cd72b..de0734c44985 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4606,6 +4606,7 @@ struct rtw89_cam_info {
 enum rtw89_sar_sources {
 	RTW89_SAR_SOURCE_NONE,
 	RTW89_SAR_SOURCE_COMMON,
+	RTW89_SAR_SOURCE_ACPI,
 
 	RTW89_SAR_SOURCE_NR,
 };
@@ -4630,6 +4631,45 @@ struct rtw89_sar_cfg_common {
 	s32 cfg[RTW89_SAR_SUBBAND_NR];
 };
 
+enum rtw89_acpi_sar_subband {
+	RTW89_ACPI_SAR_2GHZ_SUBBAND,
+	RTW89_ACPI_SAR_5GHZ_SUBBAND_1,   /* U-NII-1 */
+	RTW89_ACPI_SAR_5GHZ_SUBBAND_2,   /* U-NII-2 */
+	RTW89_ACPI_SAR_5GHZ_SUBBAND_2E,  /* U-NII-2-Extended */
+	RTW89_ACPI_SAR_5GHZ_SUBBAND_3_4, /* U-NII-3 and U-NII-4 */
+	RTW89_ACPI_SAR_6GHZ_SUBBAND_5_L, /* U-NII-5 lower part */
+	RTW89_ACPI_SAR_6GHZ_SUBBAND_5_H, /* U-NII-5 higher part */
+	RTW89_ACPI_SAR_6GHZ_SUBBAND_6,   /* U-NII-6 */
+	RTW89_ACPI_SAR_6GHZ_SUBBAND_7_L, /* U-NII-7 lower part */
+	RTW89_ACPI_SAR_6GHZ_SUBBAND_7_H, /* U-NII-7 higher part */
+	RTW89_ACPI_SAR_6GHZ_SUBBAND_8,   /* U-NII-8 */
+
+	NUM_OF_RTW89_ACPI_SAR_SUBBAND,
+};
+
+#define TXPWR_FACTOR_OF_RTW89_ACPI_SAR 3 /* unit: 0.125 dBm */
+#define MAX_VAL_OF_RTW89_ACPI_SAR S16_MAX
+#define MIN_VAL_OF_RTW89_ACPI_SAR S16_MIN
+#define MAX_NUM_OF_RTW89_ACPI_SAR_TBL 6
+#define NUM_OF_RTW89_ACPI_SAR_RF_PATH (RF_PATH_B + 1)
+
+struct rtw89_sar_entry_from_acpi {
+	s16 v[NUM_OF_RTW89_ACPI_SAR_SUBBAND][NUM_OF_RTW89_ACPI_SAR_RF_PATH];
+};
+
+struct rtw89_sar_table_from_acpi {
+	/* If this table is active, must fill all fields according to either
+	 * configuration in BIOS or some default values for SAR to work well.
+	 */
+	struct rtw89_sar_entry_from_acpi entries[RTW89_REGD_NUM];
+};
+
+struct rtw89_sar_cfg_acpi {
+	u8 downgrade_2tx;
+	unsigned int valid_num;
+	struct rtw89_sar_table_from_acpi tables[MAX_NUM_OF_RTW89_ACPI_SAR_TBL];
+};
+
 struct rtw89_sar_info {
 	/* used to decide how to access SAR cfg union */
 	enum rtw89_sar_sources src;
@@ -4639,6 +4679,7 @@ struct rtw89_sar_info {
 	 */
 	union {
 		struct rtw89_sar_cfg_common cfg_common;
+		struct rtw89_sar_cfg_acpi cfg_acpi;
 	};
 };
 
@@ -4674,11 +4715,14 @@ struct rtw89_ant_gain_info {
 struct rtw89_6ghz_span {
 	enum rtw89_sar_subband sar_subband_low;
 	enum rtw89_sar_subband sar_subband_high;
+	enum rtw89_acpi_sar_subband acpi_sar_subband_low;
+	enum rtw89_acpi_sar_subband acpi_sar_subband_high;
 	enum rtw89_ant_gain_subband ant_gain_subband_low;
 	enum rtw89_ant_gain_subband ant_gain_subband_high;
 };
 
 #define RTW89_SAR_SPAN_VALID(span) ((span)->sar_subband_high)
+#define RTW89_ACPI_SAR_SPAN_VALID(span) ((span)->acpi_sar_subband_high)
 #define RTW89_ANT_GAIN_SPAN_VALID(span) ((span)->ant_gain_subband_high)
 
 enum rtw89_tas_state {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 64eb4154a696..270f40e44c0b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2266,6 +2266,7 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 	u8 reg6 = regulatory->reg_6ghz_power;
 	struct rtw89_sar_parm sar_parm = {
 		.center_freq = freq,
+		.ntx = ntx,
 	};
 	s8 lmt = 0, sar, offset;
 	s8 cstr;
@@ -2529,6 +2530,7 @@ s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 	u8 reg6 = regulatory->reg_6ghz_power;
 	struct rtw89_sar_parm sar_parm = {
 		.center_freq = freq,
+		.ntx = ntx,
 	};
 	s8 lmt_ru = 0, sar, offset;
 	s8 cstr;
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 95255e02f1bb..8bf5b5d9ef37 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -92,6 +92,53 @@ static int rtw89_query_sar_config_common(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static
+s32 rtw89_sar_cfg_acpi_get_min(const struct rtw89_sar_entry_from_acpi *ent,
+			       enum rtw89_rf_path path,
+			       enum rtw89_acpi_sar_subband subband_low,
+			       enum rtw89_acpi_sar_subband subband_high)
+{
+	return min(ent->v[subband_low][path], ent->v[subband_high][path]);
+}
+
+static int rtw89_query_sar_config_acpi(struct rtw89_dev *rtwdev,
+				       const struct rtw89_sar_parm *sar_parm,
+				       s32 *cfg)
+{
+	const struct rtw89_sar_cfg_acpi *rtwsar = &rtwdev->sar.cfg_acpi;
+	const struct rtw89_sar_table_from_acpi *tbl = rtwsar->tables;
+	enum rtw89_acpi_sar_subband subband_l, subband_h;
+	const struct rtw89_sar_entry_from_acpi *ent;
+	u32 center_freq = sar_parm->center_freq;
+	const struct rtw89_6ghz_span *span;
+	enum rtw89_regulation_type regd;
+	enum rtw89_band band;
+	s32 cfg_a, cfg_b;
+
+	span = rtw89_get_6ghz_span(rtwdev, center_freq);
+
+	if (span && RTW89_ACPI_SAR_SPAN_VALID(span)) {
+		subband_l = span->acpi_sar_subband_low;
+		subband_h = span->acpi_sar_subband_high;
+	} else {
+		subband_l = rtw89_acpi_sar_get_subband(rtwdev, center_freq);
+		subband_h = subband_l;
+	}
+
+	band = rtw89_acpi_sar_subband_to_band(rtwdev, subband_l);
+	regd = rtw89_regd_get(rtwdev, band);
+	ent = &tbl->entries[regd];
+
+	cfg_a = rtw89_sar_cfg_acpi_get_min(ent, RF_PATH_A, subband_l, subband_h);
+	cfg_b = rtw89_sar_cfg_acpi_get_min(ent, RF_PATH_B, subband_l, subband_h);
+	*cfg = min(cfg_a, cfg_b);
+
+	if (sar_parm->ntx == RTW89_2TX)
+		*cfg -= rtwsar->downgrade_2tx;
+
+	return 0;
+}
+
 static const
 struct rtw89_sar_handler rtw89_sar_handlers[RTW89_SAR_SOURCE_NR] = {
 	[RTW89_SAR_SOURCE_COMMON] = {
@@ -99,6 +146,11 @@ struct rtw89_sar_handler rtw89_sar_handlers[RTW89_SAR_SOURCE_NR] = {
 		.txpwr_factor_sar = 2,
 		.query_sar_config = rtw89_query_sar_config_common,
 	},
+	[RTW89_SAR_SOURCE_ACPI] = {
+		.descr_sar_source = "RTW89_SAR_SOURCE_ACPI",
+		.txpwr_factor_sar = TXPWR_FACTOR_OF_RTW89_ACPI_SAR,
+		.query_sar_config = rtw89_query_sar_config_acpi,
+	},
 };
 
 #define rtw89_sar_set_src(_dev, _src, _cfg_name, _cfg_data)		\
@@ -288,16 +340,7 @@ int rtw89_print_tas(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 static int rtw89_apply_sar_common(struct rtw89_dev *rtwdev,
 				  const struct rtw89_sar_cfg_common *sar)
 {
-	enum rtw89_sar_sources src;
-
-	lockdep_assert_wiphy(rtwdev->hw->wiphy);
-
-	src = rtwdev->sar.src;
-	if (src != RTW89_SAR_SOURCE_NONE && src != RTW89_SAR_SOURCE_COMMON) {
-		rtw89_warn(rtwdev, "SAR source: %d is in use", src);
-		return -EBUSY;
-	}
-
+	/* let common SAR have the highest priority; always apply it */
 	rtw89_sar_set_src(rtwdev, RTW89_SAR_SOURCE_COMMON, cfg_common, sar);
 	rtw89_core_set_chip_txpwr(rtwdev);
 	rtw89_tas_reset(rtwdev, false);
@@ -365,6 +408,78 @@ int rtw89_ops_set_sar_specs(struct ieee80211_hw *hw,
 	return rtw89_apply_sar_common(rtwdev, &sar_common);
 }
 
+static void rtw89_apply_sar_acpi(struct rtw89_dev *rtwdev,
+				 const struct rtw89_sar_cfg_acpi *sar)
+{
+	const struct rtw89_sar_table_from_acpi *tbl;
+	const struct rtw89_sar_entry_from_acpi *ent;
+	enum rtw89_sar_sources src;
+	unsigned int i, j, k;
+
+	src = rtwdev->sar.src;
+	if (src != RTW89_SAR_SOURCE_NONE) {
+		rtw89_warn(rtwdev, "SAR source: %d is in use", src);
+		return;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_SAR,
+		    "SAR-ACPI downgrade 2TX: %u (unit: 1/%lu dBm)\n",
+		    sar->downgrade_2tx, BIT(TXPWR_FACTOR_OF_RTW89_ACPI_SAR));
+
+	for (i = 0; i < sar->valid_num; i++) {
+		tbl = &sar->tables[i];
+
+		for (j = 0; j < RTW89_REGD_NUM; j++) {
+			ent = &tbl->entries[j];
+
+			rtw89_debug(rtwdev, RTW89_DBG_SAR,
+				    "SAR-ACPI-[%u] REGD-%s (unit: 1/%lu dBm)\n",
+				    i, rtw89_regd_get_string(j),
+				    BIT(TXPWR_FACTOR_OF_RTW89_ACPI_SAR));
+
+			for (k = 0; k < NUM_OF_RTW89_ACPI_SAR_SUBBAND; k++)
+				rtw89_debug(rtwdev, RTW89_DBG_SAR,
+					    "On subband %u, { %d, %d }\n", k,
+					    ent->v[k][RF_PATH_A], ent->v[k][RF_PATH_B]);
+		}
+	}
+
+	rtw89_sar_set_src(rtwdev, RTW89_SAR_SOURCE_ACPI, cfg_acpi, sar);
+
+	/* SAR via ACPI is only configured in the early initial phase, so
+	 * it does not seem necessary to reset txpwr related things here.
+	 */
+}
+
+static void rtw89_set_sar_from_acpi(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_sar_cfg_acpi *cfg;
+	int ret;
+
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return;
+
+	ret = rtw89_acpi_evaluate_sar(rtwdev, cfg);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_SAR,
+			    "evaluating ACPI SAR returns %d\n", ret);
+		goto out;
+	}
+
+	if (unlikely(!cfg->valid_num)) {
+		rtw89_debug(rtwdev, RTW89_DBG_SAR, "no valid SAR table from ACPI\n");
+		goto out;
+	}
+
+	rtw89_apply_sar_acpi(rtwdev, cfg);
+
+out:
+	kfree(cfg);
+}
+
 static bool rtw89_tas_query_sar_config(struct rtw89_dev *rtwdev, s32 *cfg)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
@@ -524,7 +639,7 @@ static void rtw89_tas_rolling_average(struct rtw89_dev *rtwdev)
 	rtw89_tas_state_update(rtwdev, state);
 }
 
-void rtw89_tas_init(struct rtw89_dev *rtwdev)
+static void rtw89_tas_init(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_tas_info *tas = &rtwdev->tas;
@@ -671,3 +786,9 @@ void rtw89_tas_chanctx_cb(struct rtw89_dev *rtwdev,
 	}
 }
 EXPORT_SYMBOL(rtw89_tas_chanctx_cb);
+
+void rtw89_sar_init(struct rtw89_dev *rtwdev)
+{
+	rtw89_set_sar_from_acpi(rtwdev);
+	rtw89_tas_init(rtwdev);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/sar.h b/drivers/net/wireless/realtek/rtw89/sar.h
index 3e4159c08409..2d30e0d8be1f 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.h
+++ b/drivers/net/wireless/realtek/rtw89/sar.h
@@ -12,6 +12,7 @@
 
 struct rtw89_sar_parm {
 	u32 center_freq;
+	enum rtw89_ntx ntx;
 };
 
 struct rtw89_sar_handler {
@@ -29,11 +30,11 @@ int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
 int rtw89_print_tas(struct rtw89_dev *rtwdev, char *buf, size_t bufsz);
 int rtw89_ops_set_sar_specs(struct ieee80211_hw *hw,
 			    const struct cfg80211_sar_specs *sar);
-void rtw89_tas_init(struct rtw89_dev *rtwdev);
 void rtw89_tas_reset(struct rtw89_dev *rtwdev, bool force);
 void rtw89_tas_track(struct rtw89_dev *rtwdev);
 void rtw89_tas_scan(struct rtw89_dev *rtwdev, bool start);
 void rtw89_tas_chanctx_cb(struct rtw89_dev *rtwdev,
 			  enum rtw89_chanctx_state state);
+void rtw89_sar_init(struct rtw89_dev *rtwdev);
 
 #endif
-- 
2.25.1


