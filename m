Return-Path: <linux-wireless+bounces-20834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A434A70EC5
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 03:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 206827A57A5
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 02:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FB720328;
	Wed, 26 Mar 2025 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="UsxZRrjS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0BF13633F
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742954850; cv=none; b=J6L7L9DPa5wRhenpiXGqrSgUQEJtJEPjmD6B/JyJuVMlII+ol9WsXQHvKJc+phhky6hrsrMqS/oXl9Mu+HCwam+b+zc5QfFRu7gIfyRhd/96y5qsvDXrvxP3ZVKVPeiS2zeBqWhMI2VeUXN3R7ZFxlQgJhZwphhwmEG8tRZyeM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742954850; c=relaxed/simple;
	bh=tTb1sjkBH6q/orjEkD86sAYjSFb6+te9Ff8+A5zq494=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yr5skwaaVtCTliq1FCnEciLWCrGfQKnHx1j/NxqNAjhuCTKEix5gDD8TGZBki00CUQU5Om39PxZ+202r3N3eCV7Z9lL+deLMjW4bKkWL4lmY6fdB4L5dMRrSv41o8k5dcwxTR/6u4kY9SZgkXCql05cDT5oE8o9uP56lGlfNi50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=UsxZRrjS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52Q27QkR41407296, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742954846; bh=tTb1sjkBH6q/orjEkD86sAYjSFb6+te9Ff8+A5zq494=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=UsxZRrjSUAPUrox9kbcdZ98XZBUwIuOyPEn0KwFyfFdZ3bNCcMJ/AO5fVPlF6qI2S
	 ycUbpKkDsUqmu2eDvqVXmvrdVbzFh1w+ATmalGNA3uGvvgtQK/sdHeGAPJmMLwhy6T
	 mBd7eKCjPAnJSViBQN/VYO0IcFmRPFnIsjgGxz4KxVaKXJ1qj2aBpxc8BteNLYp9/0
	 OQ95wgZj3mRb2yIHTWz/2HUK8S/JCY+/kJ1x0cQ67lfWYuVMQ6v/23M629ZN8UcIWx
	 DAqU9k+0ql8HqASzWahgAfWTYznuAtFQ25Kz+rybiG+oWCUAo9bVNHzrSqv2Otj+f3
	 bsU8YkqwcuyGg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52Q27QkR41407296
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 10:07:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Mar 2025 10:07:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 26 Mar
 2025 10:07:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 09/12] wifi: rtw89: sar: add skeleton for different configs by antenna
Date: Wed, 26 Mar 2025 10:06:40 +0800
Message-ID: <20250326020643.14487-10-pkshih@realtek.com>
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

Some SAR sources, e.g. ACPI, may allow different SAR configs by antenna.
Previously, the minimum config between antennas was taken. Because there
are differences between HW design, different chips might have different
solutions to achieve this. So, it cannot be done through a single common
handling. Now, add the relevant skeleton for this purpose ahead.

First, add a flag into chip info to describe whether it has implemented
this function or not. Second, support to query SAR config for a given RF
path. With it, each chip can implement its own handling. Then, if a chip
declares to support this function, when it queries SAR config without a
given RF path, it gets a maximum config between antennas.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/phy.h      | 14 +++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 drivers/net/wireless/realtek/rtw89/sar.c      | 29 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/sar.h      |  3 ++
 10 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0789a943074f..d49e06f81ba4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4284,6 +4284,7 @@ struct rtw89_chip_info {
 	bool support_rnr;
 	bool support_ant_gain;
 	bool support_tas;
+	bool support_sar_by_ant;
 	bool ul_tb_waveform_ctrl;
 	bool ul_tb_pwr_diff;
 	bool rx_freq_frome_ie;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 518a100375fb..cafb1a06d7b8 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -935,6 +935,20 @@ static inline s8 rtw89_phy_txpwr_dbm_to_mac(struct rtw89_dev *rtwdev, s8 dbm)
 	return clamp_t(s16, dbm << chip->txpwr_factor_mac, -64, 63);
 }
 
+static inline s16 rtw89_phy_txpwr_mac_to_rf(struct rtw89_dev *rtwdev, s8 txpwr_mac)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return txpwr_mac << (chip->txpwr_factor_rf - chip->txpwr_factor_mac);
+}
+
+static inline s16 rtw89_phy_txpwr_mac_to_bb(struct rtw89_dev *rtwdev, s8 txpwr_mac)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return txpwr_mac << (chip->txpwr_factor_bb - chip->txpwr_factor_mac);
+}
+
 void rtw89_phy_ra_assoc(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link);
 void rtw89_phy_ra_update(struct rtw89_dev *rtwdev);
 void rtw89_phy_ra_update_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 0d482cd57f6e..174b90661037 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2499,6 +2499,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.support_unii4		= true,
 	.support_ant_gain	= false,
 	.support_tas		= false,
+	.support_sar_by_ant	= false,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 286334e26c84..408c2f7b3eec 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2217,6 +2217,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.support_unii4		= false,
 	.support_ant_gain	= false,
 	.support_tas		= false,
+	.support_sar_by_ant	= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index eceb4fb9880d..47233f0c6ea0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -853,6 +853,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.support_unii4		= true,
 	.support_ant_gain	= true,
 	.support_tas		= false,
+	.support_sar_by_ant	= false,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index bbf37442c492..0903e902d8f4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -786,6 +786,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.support_unii4		= true,
 	.support_ant_gain	= true,
 	.support_tas		= false,
+	.support_sar_by_ant	= false,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 08bcdf246382..cbbb6a9169d1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3014,6 +3014,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.support_unii4		= true,
 	.support_ant_gain	= true,
 	.support_tas		= true,
+	.support_sar_by_ant	= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= true,
 	.rx_freq_frome_ie	= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 8082592db84a..5b45c18fbbf6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2823,6 +2823,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.support_unii4		= true,
 	.support_ant_gain	= true,
 	.support_tas		= false,
+	.support_sar_by_ant	= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= false,
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 120cf2088c9e..d15dafcae39b 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -120,6 +120,7 @@ static int rtw89_query_sar_config_acpi(struct rtw89_dev *rtwdev,
 				       const struct rtw89_sar_parm *sar_parm,
 				       s32 *cfg)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_sar_cfg_acpi *rtwsar = &rtwdev->sar.cfg_acpi;
 	const struct rtw89_sar_entry_from_acpi *ent_a, *ent_b;
 	enum rtw89_acpi_sar_subband subband_l, subband_h;
@@ -147,7 +148,30 @@ static int rtw89_query_sar_config_acpi(struct rtw89_dev *rtwdev,
 
 	cfg_a = rtw89_sar_cfg_acpi_get_min(ent_a, RF_PATH_A, subband_l, subband_h);
 	cfg_b = rtw89_sar_cfg_acpi_get_min(ent_b, RF_PATH_B, subband_l, subband_h);
-	*cfg = min(cfg_a, cfg_b);
+
+	if (chip->support_sar_by_ant) {
+		/* With declaration of support_sar_by_ant, relax the general
+		 * SAR querying to return the maximum between paths. However,
+		 * expect chip has dealt with the corresponding SAR settings
+		 * by path. (To get SAR for a given path, chip can then query
+		 * with force_path.)
+		 */
+		if (sar_parm->force_path) {
+			switch (sar_parm->path) {
+			default:
+			case RF_PATH_A:
+				*cfg = cfg_a;
+				break;
+			case RF_PATH_B:
+				*cfg = cfg_b;
+				break;
+			}
+		} else {
+			*cfg = max(cfg_a, cfg_b);
+		}
+	} else {
+		*cfg = min(cfg_a, cfg_b);
+	}
 
 	if (sar_parm->ntx == RTW89_2TX)
 		*cfg -= rtwsar->downgrade_2tx;
@@ -285,6 +309,7 @@ s8 rtw89_query_sar(struct rtw89_dev *rtwdev, const struct rtw89_sar_parm *sar_pa
 
 	return rtw89_txpwr_sar_to_mac(rtwdev, fct, cfg);
 }
+EXPORT_SYMBOL(rtw89_query_sar);
 
 int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
 		    const struct rtw89_sar_parm *sar_parm)
@@ -322,6 +347,8 @@ int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
 	p += scnprintf(p, end - p, "config: %d (unit: 1/%lu dBm)\n", cfg,
 		       BIT(fct));
 
+	p += scnprintf(p, end - p, "support different configs by antenna: %s\n",
+		       str_yes_no(rtwdev->chip->support_sar_by_ant));
 out:
 	return p - buf;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/sar.h b/drivers/net/wireless/realtek/rtw89/sar.h
index 038a5c0d1e09..4b7f3d44f57b 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.h
+++ b/drivers/net/wireless/realtek/rtw89/sar.h
@@ -13,6 +13,9 @@
 struct rtw89_sar_parm {
 	u32 center_freq;
 	enum rtw89_ntx ntx;
+
+	bool force_path;
+	enum rtw89_rf_path path;
 };
 
 struct rtw89_sar_handler {
-- 
2.25.1


