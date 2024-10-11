Return-Path: <linux-wireless+bounces-13910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 667D299ADBC
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 22:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9651C224C9
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FF41CFECE;
	Fri, 11 Oct 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAz9AClH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA5E199231
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679871; cv=none; b=cQGQVk4WfW3ClK1F9cUy2WTJTr4otM/5+9m+gTG7Ng19OJwA2hh41DtW9JPNQpJbOh4Dfu/MIuwUJqca2+N/LVGfj0ezt38iCIBrSW0B77HjI3mEnbm8262edh0F3ax+CTXKyGf8iSItDqtsGnfydNJozMONnWH6R9QlfBlttOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679871; c=relaxed/simple;
	bh=jyZY1332C7rqu8g5dA8yVuV9oeXi2TpxlFsMphF1Fw8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FtChlw68ce0EokVa4VBo/tWiGDSjoifb/ZT37DU+GO6E7Xy7XVwcwp1SVcoI0fon0D5MhIiQ55Vd/UtOGJF+jwzXU1ML6/3kSi3sEhoGlobARkeUoG4TxxBInHp583aPasS8PvyVrqLDFE8neWbzgYPL2ia7lZxqrgxEl2K+Y3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAz9AClH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43117917eb9so19051835e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728679868; x=1729284668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4kWRdu/STBd0MrSxEe3PtZg2A5l7/bKnXWiH9jWHZfw=;
        b=FAz9AClHM6HmYVR+1nfplUcHp1ykZyevxWGKxSxAu/JgsLRux3h0hGT3RYILMRQlpr
         1EjXWrDv7UFyiZg82ntpTZZuzpX5EEInpq4gFe+srmbuOWT1oJk1hF32rCIDh8oqI8fO
         d4QMfmzmqJN1OQ0gHTX3MCWGH17EoeqA3Tb0K1Ls8hKx4CEizGtIl9h+6Qr0Xxknotov
         IdCdXT5neX6wsft5uJL0IB171b2JPBc2nofr9gG7fj4Y67rvpDiz+xOuqhwL/IQuB9Hm
         cHFlSq5r1JXX5SsqeNgkKVBvF8eSmXEOl628guWqLDvIk17shHBfj7hq7z/UTgQLlg1p
         1EjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728679868; x=1729284668;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kWRdu/STBd0MrSxEe3PtZg2A5l7/bKnXWiH9jWHZfw=;
        b=hMKCpGrCb31PTlvqJ7WiATkDgoXYjvejSr441rlizFsve+eUmaC55TcK3uNs7mam30
         /0Lw9sEsx4NeVfHoUvHuW7SFu1P4B9s0zkfCBC4mGKJTUC19PwImFBgp4D8RhbNA3J/+
         lScm4y7+ptdfl9ZUIB8JMjSStAYEeZ/1UAg0eS8wa/x+wh9bE+DtBTT6QhcCkCY8QnJk
         CgYiT4claZGHDuHrOdhu2maGPWkJh6M+QTiwNYk/12QxR9lpnxc2dfJ6XkAv2K113fCI
         DckRXPEwS1grmxZStja/pnBZRAPLw71/xsjNbgj+BueH6um/5ktwtEPWuzbW4EGdTmku
         PpLQ==
X-Gm-Message-State: AOJu0YzZ07yfhOl7mWeepbyQGGk0xUz9Mh+jsIUJtzcgm+ZVg//uriMi
	fT32EcssjHYHdWfboXHCtRiYdTj89aL9uvGOjFK/lQEdJ9wCfE6vWHqr2w==
X-Google-Smtp-Source: AGHT+IFLllswb6flrogZ7gZ4Z8AonRh9g3MegD/UvA3dGs9z8x6YkxlVj39vBJ3ney98KFHmurM+RA==
X-Received: by 2002:a05:600c:470e:b0:430:5356:ac8e with SMTP id 5b1f17b1804b1-4311dea3938mr36507805e9.5.1728679867906;
        Fri, 11 Oct 2024 13:51:07 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf1f797sm83758535e9.4.2024.10.11.13.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:51:07 -0700 (PDT)
Message-ID: <46e4f978-7dc3-447b-a744-a4ea7654ab5b@gmail.com>
Date: Fri, 11 Oct 2024 23:51:06 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 10/22] wifi: rtw88: Move pwr_track_tbl to struct
 rtw_rfe_def
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Language: en-US
In-Reply-To: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8812AU uses one set of TX power tracking tables for RFE 3, and
another set for everything else.

Move pwr_track_tbl from struct rtw_chip_info to struct rtw_rfe_def in
order to load the right set of tables for each RFE (RF front end) type.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/main.h     |  8 ++++---
 drivers/net/wireless/realtek/rtw88/phy.c      |  3 ++-
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 12 +++++-----
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 12 +++++-----
 drivers/net/wireless/realtek/rtw88/rtw8723x.c |  3 ++-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 17 +++++++-------
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 15 ++++++------
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 23 +++++++++----------
 8 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index ef82e60d5c19..072d09a7d313 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1100,16 +1100,19 @@ struct rtw_rfe_def {
 	const struct rtw_table *phy_pg_tbl;
 	const struct rtw_table *txpwr_lmt_tbl;
 	const struct rtw_table *agc_btg_tbl;
+	const struct rtw_pwr_track_tbl *pwr_track_tbl;
 };
 
-#define RTW_DEF_RFE(chip, bb_pg, pwrlmt) {				  \
+#define RTW_DEF_RFE(chip, bb_pg, pwrlmt, track) {				  \
 	.phy_pg_tbl = &rtw ## chip ## _bb_pg_type ## bb_pg ## _tbl,	  \
 	.txpwr_lmt_tbl = &rtw ## chip ## _txpwr_lmt_type ## pwrlmt ## _tbl, \
+	.pwr_track_tbl = &rtw ## chip ## _pwr_track_type ## track ## _tbl, \
 	}
 
-#define RTW_DEF_RFE_EXT(chip, bb_pg, pwrlmt, btg) {			  \
+#define RTW_DEF_RFE_EXT(chip, bb_pg, pwrlmt, track, btg) {			  \
 	.phy_pg_tbl = &rtw ## chip ## _bb_pg_type ## bb_pg ## _tbl,	  \
 	.txpwr_lmt_tbl = &rtw ## chip ## _txpwr_lmt_type ## pwrlmt ## _tbl, \
+	.pwr_track_tbl = &rtw ## chip ## _pwr_track_type ## track ## _tbl, \
 	.agc_btg_tbl = &rtw ## chip ## _agc_btg_type ## btg ## _tbl, \
 	}
 
@@ -1243,7 +1246,6 @@ struct rtw_chip_info {
 	u16 dpd_ratemask;
 	u8 iqk_threshold;
 	u8 lck_threshold;
-	const struct rtw_pwr_track_tbl *pwr_track_tbl;
 
 	u8 bfer_su_max_num;
 	u8 bfer_mu_max_num;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 5fbacb7ce499..db2aa0b8c327 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -2385,7 +2385,8 @@ void rtw_phy_init_tx_power(struct rtw_dev *rtwdev)
 void rtw_phy_config_swing_table(struct rtw_dev *rtwdev,
 				struct rtw_swing_table *swing_table)
 {
-	const struct rtw_pwr_track_tbl *tbl = rtwdev->chip->pwr_track_tbl;
+	const struct rtw_rfe_def *rfe_def = rtw_get_rfe_def(rtwdev);
+	const struct rtw_pwr_track_tbl *tbl = rfe_def->pwr_track_tbl;
 	u8 channel = rtwdev->hal.current_channel;
 
 	if (IS_CH_2G_BAND(channel)) {
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index dec0cec4ca22..a19b94d022ee 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -493,11 +493,6 @@ static const struct rtw_pwr_seq_cmd * const card_disable_flow_8703b[] = {
 	NULL
 };
 
-static const struct rtw_rfe_def rtw8703b_rfe_defs[] = {
-	[0] = { .phy_pg_tbl	= &rtw8703b_bb_pg_tbl,
-		.txpwr_lmt_tbl	= &rtw8703b_txpwr_lmt_tbl,},
-};
-
 static const struct rtw_page_table page_table_8703b[] = {
 	{12, 2, 2, 0, 1},
 	{12, 2, 2, 0, 1},
@@ -1818,6 +1813,12 @@ static const struct rtw_pwr_track_tbl rtw8703b_rtw_pwr_track_tbl = {
 	.pwrtrk_xtal_p = rtw8703b_pwrtrk_xtal_p,
 };
 
+static const struct rtw_rfe_def rtw8703b_rfe_defs[] = {
+	[0] = { .phy_pg_tbl	= &rtw8703b_bb_pg_tbl,
+		.txpwr_lmt_tbl	= &rtw8703b_txpwr_lmt_tbl,
+		.pwr_track_tbl	= &rtw8703b_rtw_pwr_track_tbl, },
+};
+
 /* Shared-Antenna Coex Table */
 static const struct coex_table_para table_sant_8703b[] = {
 	{0xffffffff, 0xffffffff}, /* case-0 */
@@ -1997,7 +1998,6 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
 	.rfe_defs_size = ARRAY_SIZE(rtw8703b_rfe_defs),
 
 	.iqk_threshold = 8,
-	.pwr_track_tbl = &rtw8703b_rtw_pwr_track_tbl,
 
 	/* WOWLAN firmware exists, but not implemented yet */
 	.wow_fw_name = "rtw88/rtw8703b_wow_fw.bin",
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 1d99bb89ef1d..eeca31bf71f1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2020,11 +2020,6 @@ static const struct rtw_intf_phy_para_table phy_para_table_8723d = {
 	.n_gen1_para	= ARRAY_SIZE(pcie_gen1_param_8723d),
 };
 
-static const struct rtw_rfe_def rtw8723d_rfe_defs[] = {
-	[0] = { .phy_pg_tbl	= &rtw8723d_bb_pg_tbl,
-		.txpwr_lmt_tbl	= &rtw8723d_txpwr_lmt_tbl,},
-};
-
 static const u8 rtw8723d_pwrtrk_2gb_n[] = {
 	0, 0, 1, 1, 1, 2, 2, 3, 4, 4, 4, 4, 5, 5, 5,
 	6, 6, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10, 10, 10
@@ -2088,6 +2083,12 @@ static const struct rtw_pwr_track_tbl rtw8723d_rtw_pwr_track_tbl = {
 	.pwrtrk_xtal_n = rtw8723d_pwrtrk_xtal_n,
 };
 
+static const struct rtw_rfe_def rtw8723d_rfe_defs[] = {
+	[0] = { .phy_pg_tbl	= &rtw8723d_bb_pg_tbl,
+		.txpwr_lmt_tbl	= &rtw8723d_txpwr_lmt_tbl,
+		.pwr_track_tbl	= &rtw8723d_rtw_pwr_track_tbl, },
+};
+
 static const struct rtw_reg_domain coex_info_hw_regs_8723d[] = {
 	{0x948, MASKDWORD, RTW_REG_DOMAIN_MAC32},
 	{0x67, BIT(7), RTW_REG_DOMAIN_MAC8},
@@ -2159,7 +2160,6 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
 	.rfe_defs = rtw8723d_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8723d_rfe_defs),
 	.rx_ldpc = false,
-	.pwr_track_tbl = &rtw8723d_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
 	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
 	.max_scan_ie_len = IEEE80211_MAX_DATA_LEN,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.c b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
index 0d0b6c2cb9aa..69f73cb5b4cd 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723x.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
@@ -595,7 +595,8 @@ void __rtw8723x_pwrtrack_set_xtal(struct rtw_dev *rtwdev, u8 therm_path,
 				  u8 delta)
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
-	const struct rtw_pwr_track_tbl *tbl = rtwdev->chip->pwr_track_tbl;
+	const struct rtw_rfe_def *rfe_def = rtw_get_rfe_def(rtwdev);
+	const struct rtw_pwr_track_tbl *tbl = rfe_def->pwr_track_tbl;
 	const s8 *pwrtrk_xtal;
 	s8 xtal_cap;
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 39dc8244f744..0270225b9c20 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1581,13 +1581,6 @@ static const struct rtw_intf_phy_para_table phy_para_table_8821c = {
 	.n_gen2_para	= ARRAY_SIZE(pcie_gen2_param_8821c),
 };
 
-static const struct rtw_rfe_def rtw8821c_rfe_defs[] = {
-	[0] = RTW_DEF_RFE(8821c, 0, 0),
-	[2] = RTW_DEF_RFE_EXT(8821c, 0, 0, 2),
-	[4] = RTW_DEF_RFE_EXT(8821c, 0, 0, 2),
-	[6] = RTW_DEF_RFE(8821c, 0, 0),
-};
-
 static const struct rtw_hw_reg rtw8821c_dig[] = {
 	[0] = { .addr = 0xc50, .mask = 0x7f },
 };
@@ -1899,7 +1892,7 @@ static const u8 rtw8821c_pwrtrk_2g_cck_a_p[] = {
 	5, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 9, 9, 9
 };
 
-static const struct rtw_pwr_track_tbl rtw8821c_rtw_pwr_track_tbl = {
+static const struct rtw_pwr_track_tbl rtw8821c_pwr_track_type0_tbl = {
 	.pwrtrk_5gb_n[0] = rtw8821c_pwrtrk_5gb_n[0],
 	.pwrtrk_5gb_n[1] = rtw8821c_pwrtrk_5gb_n[1],
 	.pwrtrk_5gb_n[2] = rtw8821c_pwrtrk_5gb_n[2],
@@ -1922,6 +1915,13 @@ static const struct rtw_pwr_track_tbl rtw8821c_rtw_pwr_track_tbl = {
 	.pwrtrk_2g_ccka_p = rtw8821c_pwrtrk_2g_cck_a_p,
 };
 
+static const struct rtw_rfe_def rtw8821c_rfe_defs[] = {
+	[0] = RTW_DEF_RFE(8821c, 0, 0, 0),
+	[2] = RTW_DEF_RFE_EXT(8821c, 0, 0, 0, 2),
+	[4] = RTW_DEF_RFE_EXT(8821c, 0, 0, 0, 2),
+	[6] = RTW_DEF_RFE(8821c, 0, 0, 0),
+};
+
 static const struct rtw_reg_domain coex_info_hw_regs_8821c[] = {
 	{0xCB0, MASKDWORD, RTW_REG_DOMAIN_MAC32},
 	{0xCB4, MASKDWORD, RTW_REG_DOMAIN_MAC32},
@@ -1994,7 +1994,6 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.rfe_defs = rtw8821c_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8821c_rfe_defs),
 	.rx_ldpc = false,
-	.pwr_track_tbl = &rtw8821c_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 419eb14c5467..739809f4cab5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2072,12 +2072,6 @@ static const struct rtw_intf_phy_para_table phy_para_table_8822b = {
 	.n_gen2_para	= ARRAY_SIZE(pcie_gen2_param_8822b),
 };
 
-static const struct rtw_rfe_def rtw8822b_rfe_defs[] = {
-	[2] = RTW_DEF_RFE(8822b, 2, 2),
-	[3] = RTW_DEF_RFE(8822b, 3, 0),
-	[5] = RTW_DEF_RFE(8822b, 5, 5),
-};
-
 static const struct rtw_hw_reg rtw8822b_dig[] = {
 	[0] = { .addr = 0xc50, .mask = 0x7f },
 	[1] = { .addr = 0xe50, .mask = 0x7f },
@@ -2432,7 +2426,7 @@ static const u8 rtw8822b_pwrtrk_2g_cck_a_p[RTW_PWR_TRK_TBL_SZ] = {
 	10, 11, 11, 12, 12, 13, 13, 14, 14, 15
 };
 
-static const struct rtw_pwr_track_tbl rtw8822b_rtw_pwr_track_tbl = {
+static const struct rtw_pwr_track_tbl rtw8822b_pwr_track_type0_tbl = {
 	.pwrtrk_5gb_n[RTW_PWR_TRK_5G_1] = rtw8822b_pwrtrk_5gb_n[RTW_PWR_TRK_5G_1],
 	.pwrtrk_5gb_n[RTW_PWR_TRK_5G_2] = rtw8822b_pwrtrk_5gb_n[RTW_PWR_TRK_5G_2],
 	.pwrtrk_5gb_n[RTW_PWR_TRK_5G_3] = rtw8822b_pwrtrk_5gb_n[RTW_PWR_TRK_5G_3],
@@ -2455,6 +2449,12 @@ static const struct rtw_pwr_track_tbl rtw8822b_rtw_pwr_track_tbl = {
 	.pwrtrk_2g_ccka_p = rtw8822b_pwrtrk_2g_cck_a_p,
 };
 
+static const struct rtw_rfe_def rtw8822b_rfe_defs[] = {
+	[2] = RTW_DEF_RFE(8822b, 2, 2, 0),
+	[3] = RTW_DEF_RFE(8822b, 3, 0, 0),
+	[5] = RTW_DEF_RFE(8822b, 5, 5, 0),
+};
+
 static const struct rtw_reg_domain coex_info_hw_regs_8822b[] = {
 	{0xcb0, MASKDWORD, RTW_REG_DOMAIN_MAC32},
 	{0xcb4, MASKDWORD, RTW_REG_DOMAIN_MAC32},
@@ -2535,7 +2535,6 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.rf_tbl = {&rtw8822b_rf_a_tbl, &rtw8822b_rf_b_tbl},
 	.rfe_defs = rtw8822b_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8822b_rfe_defs),
-	.pwr_track_tbl = &rtw8822b_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 56085f220fcd..af6b76937f1d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4883,16 +4883,6 @@ static const struct rtw_intf_phy_para_table phy_para_table_8822c = {
 	.n_gen2_para	= ARRAY_SIZE(pcie_gen2_param_8822c),
 };
 
-static const struct rtw_rfe_def rtw8822c_rfe_defs[] = {
-	[0] = RTW_DEF_RFE(8822c, 0, 0),
-	[1] = RTW_DEF_RFE(8822c, 0, 0),
-	[2] = RTW_DEF_RFE(8822c, 0, 0),
-	[3] = RTW_DEF_RFE(8822c, 0, 0),
-	[4] = RTW_DEF_RFE(8822c, 0, 0),
-	[5] = RTW_DEF_RFE(8822c, 0, 5),
-	[6] = RTW_DEF_RFE(8822c, 0, 0),
-};
-
 static const struct rtw_hw_reg rtw8822c_dig[] = {
 	[0] = { .addr = 0x1d70, .mask = 0x7f },
 	[1] = { .addr = 0x1d70, .mask = 0x7f00 },
@@ -5238,7 +5228,7 @@ static const u8 rtw8822c_pwrtrk_2g_cck_a_p[RTW_PWR_TRK_TBL_SZ] = {
 	18, 18, 19, 20, 21, 22, 23, 24, 24, 25
 };
 
-static const struct rtw_pwr_track_tbl rtw8822c_rtw_pwr_track_tbl = {
+static const struct rtw_pwr_track_tbl rtw8822c_pwr_track_type0_tbl = {
 	.pwrtrk_5gb_n[RTW_PWR_TRK_5G_1] = rtw8822c_pwrtrk_5gb_n[RTW_PWR_TRK_5G_1],
 	.pwrtrk_5gb_n[RTW_PWR_TRK_5G_2] = rtw8822c_pwrtrk_5gb_n[RTW_PWR_TRK_5G_2],
 	.pwrtrk_5gb_n[RTW_PWR_TRK_5G_3] = rtw8822c_pwrtrk_5gb_n[RTW_PWR_TRK_5G_3],
@@ -5261,6 +5251,16 @@ static const struct rtw_pwr_track_tbl rtw8822c_rtw_pwr_track_tbl = {
 	.pwrtrk_2g_ccka_p = rtw8822c_pwrtrk_2g_cck_a_p,
 };
 
+static const struct rtw_rfe_def rtw8822c_rfe_defs[] = {
+	[0] = RTW_DEF_RFE(8822c, 0, 0, 0),
+	[1] = RTW_DEF_RFE(8822c, 0, 0, 0),
+	[2] = RTW_DEF_RFE(8822c, 0, 0, 0),
+	[3] = RTW_DEF_RFE(8822c, 0, 0, 0),
+	[4] = RTW_DEF_RFE(8822c, 0, 0, 0),
+	[5] = RTW_DEF_RFE(8822c, 0, 5, 0),
+	[6] = RTW_DEF_RFE(8822c, 0, 0, 0),
+};
+
 static const struct rtw_hw_reg_offset rtw8822c_edcca_th[] = {
 	[EDCCA_TH_L2H_IDX] = {
 		{.addr = 0x84c, .mask = MASKBYTE2}, .offset = 0x80
@@ -5360,7 +5360,6 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.rfe_defs_size = ARRAY_SIZE(rtw8822c_rfe_defs),
 	.en_dis_dpd = true,
 	.dpd_ratemask = DIS_DPD_RATEALL,
-	.pwr_track_tbl = &rtw8822c_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
 	.lck_threshold = 8,
 	.bfer_su_max_num = 2,
-- 
2.46.0


