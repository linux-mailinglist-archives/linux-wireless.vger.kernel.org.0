Return-Path: <linux-wireless+bounces-20833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0394DA70EC9
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 03:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FAC3A9E04
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 02:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA80141C85;
	Wed, 26 Mar 2025 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q/pSIxa9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D26113633F
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742954846; cv=none; b=eTXy2WCEgPIgHQhn1P5XMt63NZFIGtJwKPjd+qzqrjCsDQwdb3D6CI2Hp/LBQmKJSxE1iaBSUywgA/PCc6Th5AdeaYlwudIlNAuWrFkL+ath3RUMADg3QpLJ5QFqBuLjQP3IpnuKa3YOdZhxJhhEB4Adq/Pfa7M/+l+taDUCvDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742954846; c=relaxed/simple;
	bh=MHjIaEg5/GmqB/oXY6iYg02uJ7wC20PlygzpYCACZL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2iEGVY+Kz7RZzViPetx5uSnUYEO/0Y9bTd0IXgsEleg/z5ovT+GtPPvhh7SziEv0WBct2xoMWNcrWrmCX4Z52srO1zNGMm+Smij4T0W5kWwWUCTacdee2W/BBZSZR+Sja0pEE1t27CR0/MI2e0PPpLB2TLJV23fyRt4EBNYhpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q/pSIxa9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52Q27MzpC1407284, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742954842; bh=MHjIaEg5/GmqB/oXY6iYg02uJ7wC20PlygzpYCACZL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Q/pSIxa9OOELQ5w1WCaBYMMAxFsL/mwf5fYC8iHXI8ZNPmnVvE8NQbZYxMZAzL4HK
	 UYyejJzkgoba53bWNrXLPo7SXk7Q9ypIBx9gyKCiyl+KB/5yFcEjj2O6E8Utvs0uWC
	 a8sSitgq4lqWvx7N/CHNqnDxRBwikGX4xvQtyvyDO4w9RYlDUbDs3/hJL6cGpQHRGl
	 Wz1TCFWHSZLy7qH0h5D2YcN3b4GWNbybwfcxGiuOxi65icGuSzbadPSkUp4C+ajH9E
	 n9CxSsD47UQXOtrIscTRuqrzeShX+xjQy1C273t9EbAbDZZB3+xqG1KmBgt7YL//b7
	 Bg3GJdVPBvXCA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52Q27MzpC1407284
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 10:07:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Mar 2025 10:07:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 26 Mar
 2025 10:07:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 08/12] wifi: rtw89: acpi: support loading GEO SAR tables
Date: Wed, 26 Mar 2025 10:06:39 +0800
Message-ID: <20250326020643.14487-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250326020643.14487-1-pkshih@realtek.com>
References: <20250326020643.14487-1-pkshih@realtek.com>
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

Support to load GEO (geography) SAR tables with ACPI RWGS method. When
SAR values could be different by regulatory, GEO SAR can be used. The
format of GEO SAR is like the following, where regulatory number, band
number, and delta number are determined by header of either static SAR
or dynamic SAR. (It also means that no GEO SAR will be considered when
neither static SAR nor dynamic SAR is configured.)

                               delta number
                             /               \
                    + +-----+-----------------+
                  / | | max | delta...        | \
                 /  | +-----+-----------------+  band
                /   | | max | delta...        |  number
               /    | +-----+-----------------+
              /     | |...                    | /
                    + +-----+-----------------+
                    | | max | delta...        | \
       regulatory   | +-----+-----------------+  band
       number       | | max | delta...        |  number
                    | +-----+-----------------+
                    | |...                    | /
                    + +-----+-----------------+
              \     | |...                    |
               \    | |...                    |
                \   | |...                    |
                 \  | |                       |
                  \ | |                       |
                    + +-----+-----------------+

Each entry of GEO SAR contains delta field(s), which are offset(s) used
to tweak the loaded static/dynamic SAR table(s) by antenna, and one max
field, which describes the maximum of the final SAR values after tweaked.
Different entries should be configured based on both regulatory and band.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/acpi.c | 296 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/acpi.h |  89 +++++++
 2 files changed, 385 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/acpi.c b/drivers/net/wireless/realtek/rtw89/acpi.c
index d66515def211..c97cc29cc663 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.c
+++ b/drivers/net/wireless/realtek/rtw89/acpi.c
@@ -501,6 +501,265 @@ void rtw89_acpi_sar_load_sml_has_6ghz(struct rtw89_dev *rtwdev,
 	}
 }
 
+static s16 rtw89_acpi_geo_sar_normalize_delta(s8 delta)
+{
+	static const u8 fct = 1;
+
+	BUILD_BUG_ON(fct > TXPWR_FACTOR_OF_RTW89_ACPI_SAR);
+
+	return delta << (TXPWR_FACTOR_OF_RTW89_ACPI_SAR - fct);
+}
+
+static enum rtw89_acpi_geo_sar_regd_hp
+rtw89_acpi_geo_sar_regd_convert_hp_idx(enum rtw89_regulation_type regd)
+{
+	switch (regd) {
+	case RTW89_FCC:
+	case RTW89_IC:
+	case RTW89_NCC:
+	case RTW89_CHILE:
+	case RTW89_MEXICO:
+		return RTW89_ACPI_GEO_SAR_REGD_HP_FCC;
+	case RTW89_ETSI:
+	case RTW89_MKK:
+	case RTW89_ACMA:
+		return RTW89_ACPI_GEO_SAR_REGD_HP_ETSI;
+	default:
+	case RTW89_WW:
+	case RTW89_NA:
+	case RTW89_KCC:
+		return RTW89_ACPI_GEO_SAR_REGD_HP_WW;
+	}
+}
+
+static enum rtw89_acpi_geo_sar_regd_rt
+rtw89_acpi_geo_sar_regd_convert_rt_idx(enum rtw89_regulation_type regd)
+{
+	switch (regd) {
+	case RTW89_FCC:
+	case RTW89_NCC:
+	case RTW89_CHILE:
+	case RTW89_MEXICO:
+		return RTW89_ACPI_GEO_SAR_REGD_RT_FCC;
+	case RTW89_ETSI:
+	case RTW89_ACMA:
+		return RTW89_ACPI_GEO_SAR_REGD_RT_ETSI;
+	case RTW89_MKK:
+		return RTW89_ACPI_GEO_SAR_REGD_RT_MKK;
+	case RTW89_IC:
+		return RTW89_ACPI_GEO_SAR_REGD_RT_IC;
+	case RTW89_KCC:
+		return RTW89_ACPI_GEO_SAR_REGD_RT_KCC;
+	default:
+	case RTW89_WW:
+	case RTW89_NA:
+		return RTW89_ACPI_GEO_SAR_REGD_RT_WW;
+	}
+}
+
+static
+void rtw89_acpi_geo_sar_load_by_hp(struct rtw89_dev *rtwdev,
+				   const struct rtw89_acpi_geo_sar_hp_val *ptr,
+				   enum rtw89_rf_path path, s16 *val)
+{
+	u8 antidx = rtw89_acpi_sar_rfpath_to_hp_antidx(path);
+	s16 delta = rtw89_acpi_geo_sar_normalize_delta(ptr->delta[antidx]);
+	s16 max = rtw89_acpi_sar_normalize_hp_val(ptr->max);
+
+	*val = clamp_t(s32, (*val) + delta, MIN_VAL_OF_RTW89_ACPI_SAR, max);
+}
+
+static
+void rtw89_acpi_geo_sar_load_by_rt(struct rtw89_dev *rtwdev,
+				   const struct rtw89_acpi_geo_sar_rt_val *ptr,
+				   s16 *val)
+{
+	s16 delta = rtw89_acpi_geo_sar_normalize_delta(ptr->delta);
+	s16 max = rtw89_acpi_sar_normalize_rt_val(ptr->max);
+
+	*val = clamp_t(s32, (*val) + delta, MIN_VAL_OF_RTW89_ACPI_SAR, max);
+}
+
+static
+void rtw89_acpi_geo_sar_load_hp_legacy(struct rtw89_dev *rtwdev,
+				       const void *content,
+				       enum rtw89_regulation_type regd,
+				       struct rtw89_sar_entry_from_acpi *ent)
+{
+	const struct rtw89_acpi_geo_sar_hp_legacy *ptr = content;
+	const struct rtw89_acpi_geo_sar_hp_legacy_entry *ptr_ent;
+	const struct rtw89_acpi_geo_sar_hp_val *ptr_ent_val;
+	enum rtw89_acpi_geo_sar_regd_hp geo_idx =
+		rtw89_acpi_geo_sar_regd_convert_hp_idx(regd);
+	enum rtw89_acpi_sar_subband subband;
+	enum rtw89_rf_path path;
+	enum rtw89_band band;
+
+	ptr_ent = &ptr->entries[geo_idx];
+
+	for (subband = 0; subband < NUM_OF_RTW89_ACPI_SAR_SUBBAND; subband++) {
+		band = rtw89_acpi_sar_subband_to_band(rtwdev, subband);
+		switch (band) {
+		case RTW89_BAND_2G:
+			ptr_ent_val = &ptr_ent->val_2ghz;
+			break;
+		case RTW89_BAND_5G:
+			ptr_ent_val = &ptr_ent->val_5ghz;
+			break;
+		default:
+		case RTW89_BAND_6G:
+			ptr_ent_val = NULL;
+			break;
+		}
+
+		if (!ptr_ent_val)
+			continue;
+
+		for (path = 0; path < NUM_OF_RTW89_ACPI_SAR_RF_PATH; path++)
+			rtw89_acpi_geo_sar_load_by_hp(rtwdev, ptr_ent_val, path,
+						      &ent->v[subband][path]);
+	}
+}
+
+static
+void rtw89_acpi_geo_sar_load_hp_has_6ghz(struct rtw89_dev *rtwdev,
+					 const void *content,
+					 enum rtw89_regulation_type regd,
+					 struct rtw89_sar_entry_from_acpi *ent)
+{
+	const struct rtw89_acpi_geo_sar_hp_has_6ghz *ptr = content;
+	const struct rtw89_acpi_geo_sar_hp_has_6ghz_entry *ptr_ent;
+	const struct rtw89_acpi_geo_sar_hp_val *ptr_ent_val;
+	enum rtw89_acpi_geo_sar_regd_hp geo_idx =
+		rtw89_acpi_geo_sar_regd_convert_hp_idx(regd);
+	enum rtw89_acpi_sar_subband subband;
+	enum rtw89_rf_path path;
+	enum rtw89_band band;
+
+	ptr_ent = &ptr->entries[geo_idx];
+
+	for (subband = 0; subband < NUM_OF_RTW89_ACPI_SAR_SUBBAND; subband++) {
+		band = rtw89_acpi_sar_subband_to_band(rtwdev, subband);
+		switch (band) {
+		case RTW89_BAND_2G:
+			ptr_ent_val = &ptr_ent->val_2ghz;
+			break;
+		case RTW89_BAND_5G:
+			ptr_ent_val = &ptr_ent->val_5ghz;
+			break;
+		case RTW89_BAND_6G:
+			ptr_ent_val = &ptr_ent->val_6ghz;
+			break;
+		default:
+			ptr_ent_val = NULL;
+			break;
+		}
+
+		if (!ptr_ent_val)
+			continue;
+
+		for (path = 0; path < NUM_OF_RTW89_ACPI_SAR_RF_PATH; path++)
+			rtw89_acpi_geo_sar_load_by_hp(rtwdev, ptr_ent_val, path,
+						      &ent->v[subband][path]);
+	}
+}
+
+static
+void rtw89_acpi_geo_sar_load_rt_legacy(struct rtw89_dev *rtwdev,
+				       const void *content,
+				       enum rtw89_regulation_type regd,
+				       struct rtw89_sar_entry_from_acpi *ent)
+{
+	const struct rtw89_acpi_geo_sar_rt_legacy *ptr = content;
+	const struct rtw89_acpi_geo_sar_rt_legacy_entry *ptr_ent;
+	const struct rtw89_acpi_geo_sar_rt_val *ptr_ent_val;
+	enum rtw89_acpi_geo_sar_regd_rt geo_idx =
+		rtw89_acpi_geo_sar_regd_convert_rt_idx(regd);
+	enum rtw89_acpi_sar_subband subband;
+	enum rtw89_rf_path path;
+	enum rtw89_band band;
+
+	ptr_ent = &ptr->entries[geo_idx];
+
+	for (subband = 0; subband < NUM_OF_RTW89_ACPI_SAR_SUBBAND; subband++) {
+		band = rtw89_acpi_sar_subband_to_band(rtwdev, subband);
+		switch (band) {
+		case RTW89_BAND_2G:
+			ptr_ent_val = &ptr_ent->val_2ghz;
+			break;
+		case RTW89_BAND_5G:
+			ptr_ent_val = &ptr_ent->val_5ghz;
+			break;
+		default:
+		case RTW89_BAND_6G:
+			ptr_ent_val = NULL;
+			break;
+		}
+
+		if (!ptr_ent_val)
+			continue;
+
+		for (path = 0; path < NUM_OF_RTW89_ACPI_SAR_RF_PATH; path++)
+			rtw89_acpi_geo_sar_load_by_rt(rtwdev, ptr_ent_val,
+						      &ent->v[subband][path]);
+	}
+}
+
+static
+void rtw89_acpi_geo_sar_load_rt_has_6ghz(struct rtw89_dev *rtwdev,
+					 const void *content,
+					 enum rtw89_regulation_type regd,
+					 struct rtw89_sar_entry_from_acpi *ent)
+{
+	const struct rtw89_acpi_geo_sar_rt_has_6ghz *ptr = content;
+	const struct rtw89_acpi_geo_sar_rt_has_6ghz_entry *ptr_ent;
+	const struct rtw89_acpi_geo_sar_rt_val *ptr_ent_val;
+	enum rtw89_acpi_geo_sar_regd_rt geo_idx =
+		rtw89_acpi_geo_sar_regd_convert_rt_idx(regd);
+	enum rtw89_acpi_sar_subband subband;
+	enum rtw89_rf_path path;
+	enum rtw89_band band;
+
+	ptr_ent = &ptr->entries[geo_idx];
+
+	for (subband = 0; subband < NUM_OF_RTW89_ACPI_SAR_SUBBAND; subband++) {
+		band = rtw89_acpi_sar_subband_to_band(rtwdev, subband);
+		switch (band) {
+		case RTW89_BAND_2G:
+			ptr_ent_val = &ptr_ent->val_2ghz;
+			break;
+		case RTW89_BAND_5G:
+			ptr_ent_val = &ptr_ent->val_5ghz;
+			break;
+		case RTW89_BAND_6G:
+			ptr_ent_val = &ptr_ent->val_6ghz;
+			break;
+		default:
+			ptr_ent_val = NULL;
+			break;
+		}
+
+		if (!ptr_ent_val)
+			continue;
+
+		for (path = 0; path < NUM_OF_RTW89_ACPI_SAR_RF_PATH; path++)
+			rtw89_acpi_geo_sar_load_by_rt(rtwdev, ptr_ent_val,
+						      &ent->v[subband][path]);
+	}
+}
+
+#define RTW89_ACPI_GEO_SAR_DECL_HANDLER(type) \
+static const struct rtw89_acpi_geo_sar_handler \
+rtw89_acpi_geo_sar_handler_ ## type = { \
+	.data_size = RTW89_ACPI_GEO_SAR_SIZE_OF(type), \
+	.load = rtw89_acpi_geo_sar_load_ ## type, \
+}
+
+RTW89_ACPI_GEO_SAR_DECL_HANDLER(hp_legacy);
+RTW89_ACPI_GEO_SAR_DECL_HANDLER(hp_has_6ghz);
+RTW89_ACPI_GEO_SAR_DECL_HANDLER(rt_legacy);
+RTW89_ACPI_GEO_SAR_DECL_HANDLER(rt_has_6ghz);
+
 static const struct rtw89_acpi_sar_recognition rtw89_acpi_sar_recs[] = {
 	{
 		.id = {
@@ -508,6 +767,7 @@ static const struct rtw89_acpi_sar_recognition rtw89_acpi_sar_recs[] = {
 			.rev = RTW89_ACPI_SAR_REV_LEGACY,
 			.size = RTW89_ACPI_SAR_SIZE_OF(std_legacy),
 		},
+		.geo = &rtw89_acpi_geo_sar_handler_hp_legacy,
 
 		.rfpath_to_antidx = rtw89_acpi_sar_rfpath_to_hp_antidx,
 		.normalize = rtw89_acpi_sar_normalize_hp_val,
@@ -519,6 +779,7 @@ static const struct rtw89_acpi_sar_recognition rtw89_acpi_sar_recs[] = {
 			.rev = RTW89_ACPI_SAR_REV_HAS_6GHZ,
 			.size = RTW89_ACPI_SAR_SIZE_OF(std_has_6ghz),
 		},
+		.geo = &rtw89_acpi_geo_sar_handler_hp_has_6ghz,
 
 		.rfpath_to_antidx = rtw89_acpi_sar_rfpath_to_hp_antidx,
 		.normalize = rtw89_acpi_sar_normalize_hp_val,
@@ -530,6 +791,7 @@ static const struct rtw89_acpi_sar_recognition rtw89_acpi_sar_recs[] = {
 			.rev = RTW89_ACPI_SAR_REV_LEGACY,
 			.size = RTW89_ACPI_SAR_SIZE_OF(std_legacy),
 		},
+		.geo = &rtw89_acpi_geo_sar_handler_rt_legacy,
 
 		.rfpath_to_antidx = rtw89_acpi_sar_rfpath_to_rt_antidx,
 		.normalize = rtw89_acpi_sar_normalize_rt_val,
@@ -541,6 +803,7 @@ static const struct rtw89_acpi_sar_recognition rtw89_acpi_sar_recs[] = {
 			.rev = RTW89_ACPI_SAR_REV_HAS_6GHZ,
 			.size = RTW89_ACPI_SAR_SIZE_OF(std_has_6ghz),
 		},
+		.geo = &rtw89_acpi_geo_sar_handler_rt_has_6ghz,
 
 		.rfpath_to_antidx = rtw89_acpi_sar_rfpath_to_rt_antidx,
 		.normalize = rtw89_acpi_sar_normalize_rt_val,
@@ -552,6 +815,7 @@ static const struct rtw89_acpi_sar_recognition rtw89_acpi_sar_recs[] = {
 			.rev = RTW89_ACPI_SAR_REV_LEGACY,
 			.size = RTW89_ACPI_SAR_SIZE_OF(sml_legacy),
 		},
+		.geo = &rtw89_acpi_geo_sar_handler_rt_legacy,
 
 		.rfpath_to_antidx = rtw89_acpi_sar_rfpath_to_rt_antidx,
 		.normalize = rtw89_acpi_sar_normalize_rt_val,
@@ -563,6 +827,7 @@ static const struct rtw89_acpi_sar_recognition rtw89_acpi_sar_recs[] = {
 			.rev = RTW89_ACPI_SAR_REV_HAS_6GHZ,
 			.size = RTW89_ACPI_SAR_SIZE_OF(sml_has_6ghz),
 		},
+		.geo = &rtw89_acpi_geo_sar_handler_rt_has_6ghz,
 
 		.rfpath_to_antidx = rtw89_acpi_sar_rfpath_to_rt_antidx,
 		.normalize = rtw89_acpi_sar_normalize_rt_val,
@@ -798,6 +1063,35 @@ int rtw89_acpi_evaluate_dynamic_sar_indicator(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+static
+void rtw89_acpi_evaluate_geo_sar(struct rtw89_dev *rtwdev,
+				 const struct rtw89_acpi_geo_sar_handler *hdl,
+				 struct rtw89_sar_cfg_acpi *cfg)
+{
+	const struct rtw89_acpi_data *data;
+	u32 len;
+
+	data = rtw89_acpi_evaluate_method(rtwdev, RTW89_ACPI_METHOD_GEO_SAR);
+	if (!data)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_ACPI, "acpi load geo sar\n");
+
+	len = data->len;
+	if (len != hdl->data_size) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "invalid buf len %u (expected %u)\n",
+			    len, hdl->data_size);
+		goto out;
+	}
+
+	for (unsigned int i = 0; i < cfg->valid_num; i++)
+		for (u8 regd = 0; regd < RTW89_REGD_NUM; regd++)
+			hdl->load(rtwdev, data->buf, regd, &cfg->tables[i].entries[regd]);
+
+out:
+	kfree(data);
+}
+
 int rtw89_acpi_evaluate_sar(struct rtw89_dev *rtwdev,
 			    struct rtw89_sar_cfg_acpi *cfg)
 {
@@ -817,6 +1111,8 @@ int rtw89_acpi_evaluate_sar(struct rtw89_dev *rtwdev,
 	fetch_indicator = true;
 
 recognized:
+	rtw89_acpi_evaluate_geo_sar(rtwdev, rec->geo, cfg);
+
 	switch (rec->id.cid) {
 	case RTW89_ACPI_SAR_CID_HP:
 		cfg->downgrade_2tx = 3 << TXPWR_FACTOR_OF_RTW89_ACPI_SAR;
diff --git a/drivers/net/wireless/realtek/rtw89/acpi.h b/drivers/net/wireless/realtek/rtw89/acpi.h
index b03e4af6555e..8ec9011bfefb 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.h
+++ b/drivers/net/wireless/realtek/rtw89/acpi.h
@@ -91,6 +91,7 @@ enum rtw89_acpi_sar_rev {
 #define RTW89_ACPI_METHOD_STATIC_SAR "WRDS"
 #define RTW89_ACPI_METHOD_DYNAMIC_SAR "RWRD"
 #define RTW89_ACPI_METHOD_DYNAMIC_SAR_INDICATOR "RWSI"
+#define RTW89_ACPI_METHOD_GEO_SAR "RWGS"
 
 struct rtw89_acpi_sar_std_legacy {
 	u8 v[RTW89_ACPI_SAR_ANT_NR_STD][RTW89_ACPI_SAR_SUBBAND_NR_LEGACY];
@@ -136,6 +137,7 @@ struct rtw89_acpi_sar_identifier {
 
 struct rtw89_acpi_sar_recognition {
 	struct rtw89_acpi_sar_identifier id;
+	const struct rtw89_acpi_geo_sar_handler *geo;
 
 	u8 (*rfpath_to_antidx)(enum rtw89_rf_path rfpath);
 	s16 (*normalize)(u8 v);
@@ -145,6 +147,93 @@ struct rtw89_acpi_sar_recognition {
 		     struct rtw89_sar_entry_from_acpi *ent);
 };
 
+struct rtw89_acpi_geo_sar_hp_val {
+	u8 max;
+	s8 delta[RTW89_ACPI_SAR_ANT_NR_STD];
+} __packed;
+
+struct rtw89_acpi_geo_sar_hp_legacy_entry {
+	struct rtw89_acpi_geo_sar_hp_val val_2ghz;
+	struct rtw89_acpi_geo_sar_hp_val val_5ghz;
+} __packed;
+
+struct rtw89_acpi_geo_sar_hp_has_6ghz_entry {
+	struct rtw89_acpi_geo_sar_hp_val val_2ghz;
+	struct rtw89_acpi_geo_sar_hp_val val_5ghz;
+	struct rtw89_acpi_geo_sar_hp_val val_6ghz;
+} __packed;
+
+enum rtw89_acpi_geo_sar_regd_hp {
+	RTW89_ACPI_GEO_SAR_REGD_HP_FCC = 0,
+	RTW89_ACPI_GEO_SAR_REGD_HP_ETSI = 1,
+	RTW89_ACPI_GEO_SAR_REGD_HP_WW = 2,
+
+	RTW89_ACPI_GEO_SAR_REGD_NR_HP,
+};
+
+struct rtw89_acpi_geo_sar_hp_legacy {
+	struct rtw89_acpi_geo_sar_hp_legacy_entry
+		entries[RTW89_ACPI_GEO_SAR_REGD_NR_HP];
+} __packed;
+
+struct rtw89_acpi_geo_sar_hp_has_6ghz {
+	struct rtw89_acpi_geo_sar_hp_has_6ghz_entry
+		entries[RTW89_ACPI_GEO_SAR_REGD_NR_HP];
+} __packed;
+
+struct rtw89_acpi_geo_sar_rt_val {
+	u8 max;
+	s8 delta;
+} __packed;
+
+struct rtw89_acpi_geo_sar_rt_legacy_entry {
+	struct rtw89_acpi_geo_sar_rt_val val_2ghz;
+	struct rtw89_acpi_geo_sar_rt_val val_5ghz;
+} __packed;
+
+struct rtw89_acpi_geo_sar_rt_has_6ghz_entry {
+	struct rtw89_acpi_geo_sar_rt_val val_2ghz;
+	struct rtw89_acpi_geo_sar_rt_val val_5ghz;
+	struct rtw89_acpi_geo_sar_rt_val val_6ghz;
+} __packed;
+
+enum rtw89_acpi_geo_sar_regd_rt {
+	RTW89_ACPI_GEO_SAR_REGD_RT_FCC = 0,
+	RTW89_ACPI_GEO_SAR_REGD_RT_ETSI = 1,
+	RTW89_ACPI_GEO_SAR_REGD_RT_MKK = 2,
+	RTW89_ACPI_GEO_SAR_REGD_RT_IC = 3,
+	RTW89_ACPI_GEO_SAR_REGD_RT_KCC = 4,
+	RTW89_ACPI_GEO_SAR_REGD_RT_WW = 5,
+
+	RTW89_ACPI_GEO_SAR_REGD_NR_RT,
+};
+
+struct rtw89_acpi_geo_sar_rt_legacy {
+	struct rtw89_acpi_geo_sar_rt_legacy_entry
+		entries[RTW89_ACPI_GEO_SAR_REGD_NR_RT];
+} __packed;
+
+struct rtw89_acpi_geo_sar_rt_has_6ghz {
+	struct rtw89_acpi_geo_sar_rt_has_6ghz_entry
+		entries[RTW89_ACPI_GEO_SAR_REGD_NR_RT];
+} __packed;
+
+struct rtw89_acpi_geo_sar_handler {
+	u8 data_size;
+
+	void (*load)(struct rtw89_dev *rtwdev,
+		     const void *content,
+		     enum rtw89_regulation_type regd,
+		     struct rtw89_sar_entry_from_acpi *ent);
+};
+
+/* for rtw89_acpi_geo_sar_handler::data_size */
+#define RTW89_ACPI_GEO_SAR_SIZE_MAX U8_MAX
+#define RTW89_ACPI_GEO_SAR_SIZE_OF(type) \
+	(BUILD_BUG_ON_ZERO(sizeof(struct rtw89_acpi_geo_sar_ ## type) > \
+			   RTW89_ACPI_GEO_SAR_SIZE_MAX) + \
+	 sizeof(struct rtw89_acpi_geo_sar_ ## type))
+
 enum rtw89_acpi_sar_subband rtw89_acpi_sar_get_subband(struct rtw89_dev *rtwdev,
 						       u32 center_freq);
 enum rtw89_band rtw89_acpi_sar_subband_to_band(struct rtw89_dev *rtwdev,
-- 
2.25.1


