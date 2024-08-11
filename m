Return-Path: <linux-wireless+bounces-11281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA92B94E330
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 23:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A101F21D79
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 21:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3D72595;
	Sun, 11 Aug 2024 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QA2QGcJy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C2518E20
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723410088; cv=none; b=E5dxnHTMiCPa1G4eHKK1zoMsWGj6v2/+3RzeR7B6qe/fneVzBb+pFgakZfYfJUt0pDlMPgzJ9tZd5jEMdUKShMb6PC+6r2xeQ8cZOH3mfNJICv6uOChgAr3GDB9Qw/zJ1M8+7IVOi6/o3kmyN3xqXxap5G5O5L7TWZPSX8MQD7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723410088; c=relaxed/simple;
	bh=Z09+xYgshojPjKYACciW2m4OvPF7XFAiDq7fHGOhBj4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=s0amnkWIcFrXiiU9foS8kIpvf+t02Mh6Ts5B22weePvrIoTgmXq72o6mzPOIPzXDkh4fch/x6ocfb/kYbZ21Qs7Q13+VW5EEV51ZKibHnK+XfQ+8xZzw046/pgPGmffr8Q/GrE9y3tJ+EBmTX2aHschAa2hRFusPTxewW13yR7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QA2QGcJy; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f189a2a7f8so38274751fa.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 14:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723410085; x=1724014885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ooSeT5lW+bYxBamOonH8tR7BOgoObJz7RcdPUaKFMwk=;
        b=QA2QGcJy/gUHEJxAijL3wolgH8nDAjGF/eStXnjFoQ4Qt8w5ojJTXUSQ2tY93Nb66l
         LrUprUxPEh0zV0zJAyOg22wPbfOOoM1M0cpkTwgsiTYbbCjypswU4IuUem8Zel3CRd4T
         Og/YZUYWBDtiE7SpsiSc9ONQHD+ZC9uOJpq4I6MxQAGjPihc3CAVQxQsxZSB0bV0KjPK
         HRDcDS/yVF9/lkcHWKGf3pzZF8BRMQZgAFDU4vfPjUel8UxxB5Pzr7VsQakimLzMd8Ti
         yN+mtdUbGuL06kBCmN0o0j2wTik6rYwEMgBPaotGF30Z1tyJtAxn6KWw+FB8HBFvItTV
         j0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723410085; x=1724014885;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooSeT5lW+bYxBamOonH8tR7BOgoObJz7RcdPUaKFMwk=;
        b=vVbXQivS2v7y316cQd8WHzEtBHGyNkZ3xlIqHei8FMxST1g26BizbbNoxiIieR77do
         2e4JmTldukjSnz6TLH87pjFvhRZedOw/zcJd1YA4f7+rdxbxxSck5zjV4oHcvYmhitnY
         A1QkN5CcxHREP4kXs6EmGlbEqbTW61iWhoaWIbuHB0sMUTeAIbQnmg7ueWirag58rCNt
         ANfRCqdB3XeOvQbQTale7beFdXSyFG+pBJnc+psozKF2Hj6SFRoAIli08oRLaD21FuTQ
         DoHtbf6ph6YbiDgeqJMYjQYsrcsLuStkWdB5dcn0eLhUOykmGsiwb80S9oeYMylF6HOK
         X0LQ==
X-Gm-Message-State: AOJu0Yx2QF+jTg1eMSHHWx1fayI3ALjIVKEy9knREx/tBxzEwv0fUh9c
	jk++fwigGoaI63DbRT4TqcgV8K7P6epuSCNmcYF5RV9jSGuYQlDdkERJug==
X-Google-Smtp-Source: AGHT+IE+V3pD+ZcQfAogk1g/+/YIHa6zuQTRpnr/7USKhw7nr5GqATCSwoAZ13WcYLPIPTX+8hxpzQ==
X-Received: by 2002:a05:6512:3083:b0:52e:9c0a:3522 with SMTP id 2adb3069b0e04-530eea22ae8mr5760278e87.44.1723410084367;
        Sun, 11 Aug 2024 14:01:24 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb2136dcsm170215866b.165.2024.08.11.14.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 14:01:24 -0700 (PDT)
Message-ID: <571ace0f-0455-46ec-bcd5-49a87b31f3e2@gmail.com>
Date: Mon, 12 Aug 2024 00:01:23 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 10/20] wifi: rtw88: Move pwr_track_tbl to struct rtw_rfe_def
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8812AU uses one set of TX power tracking tables for RFE 3, and
another set for everything else.

Move pwr_track_tbl from struct rtw_chip_info to struct rtw_rfe_def in
order to load the right set of tables for each RFE (RF front end) type.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
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
index c78f9138d1bc..bc444c4cfade 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1102,16 +1102,19 @@ struct rtw_rfe_def {
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
 
@@ -1245,7 +1248,6 @@ struct rtw_chip_info {
 	u16 dpd_ratemask;
 	u8 iqk_threshold;
 	u8 lck_threshold;
-	const struct rtw_pwr_track_tbl *pwr_track_tbl;
 
 	u8 bfer_su_max_num;
 	u8 bfer_mu_max_num;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index a72aeafe5865..cfe12a75ff84 100644
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
index 52e1d3a43868..71b015580408 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -496,11 +496,6 @@ static const struct rtw_pwr_seq_cmd *card_disable_flow_8703b[] = {
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
@@ -1872,6 +1867,12 @@ static const struct rtw_pwr_track_tbl rtw8703b_rtw_pwr_track_tbl = {
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
@@ -2051,7 +2052,6 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
 	.rfe_defs_size = ARRAY_SIZE(rtw8703b_rfe_defs),
 
 	.iqk_threshold = 8,
-	.pwr_track_tbl = &rtw8703b_rtw_pwr_track_tbl,
 
 	/* WOWLAN firmware exists, but not implemented yet */
 	.wow_fw_name = "rtw88/rtw8703b_wow_fw.bin",
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index f0f4423810da..b602ddc69415 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2061,11 +2061,6 @@ static const struct rtw_intf_phy_para_table phy_para_table_8723d = {
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
@@ -2129,6 +2124,12 @@ static const struct rtw_pwr_track_tbl rtw8723d_rtw_pwr_track_tbl = {
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
@@ -2200,7 +2201,6 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
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
index 851bf018c911..bdbb16c51181 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1622,13 +1622,6 @@ static const struct rtw_intf_phy_para_table phy_para_table_8821c = {
 	.n_gen2_para	= ARRAY_SIZE(pcie_gen2_param_8821c),
 };
 
-static const struct rtw_rfe_def rtw8821c_rfe_defs[] = {
-	[0] = RTW_DEF_RFE(8821c, 0, 0),
-	[2] = RTW_DEF_RFE_EXT(8821c, 0, 0, 2),
-	[4] = RTW_DEF_RFE_EXT(8821c, 0, 0, 2),
-	[6] = RTW_DEF_RFE(8821c, 0, 0),
-};
-
 static struct rtw_hw_reg rtw8821c_dig[] = {
 	[0] = { .addr = 0xc50, .mask = 0x7f },
 };
@@ -1940,7 +1933,7 @@ static const u8 rtw8821c_pwrtrk_2g_cck_a_p[] = {
 	5, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 9, 9, 9
 };
 
-static const struct rtw_pwr_track_tbl rtw8821c_rtw_pwr_track_tbl = {
+static const struct rtw_pwr_track_tbl rtw8821c_pwr_track_type0_tbl = {
 	.pwrtrk_5gb_n[0] = rtw8821c_pwrtrk_5gb_n[0],
 	.pwrtrk_5gb_n[1] = rtw8821c_pwrtrk_5gb_n[1],
 	.pwrtrk_5gb_n[2] = rtw8821c_pwrtrk_5gb_n[2],
@@ -1963,6 +1956,13 @@ static const struct rtw_pwr_track_tbl rtw8821c_rtw_pwr_track_tbl = {
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
@@ -2034,7 +2034,6 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.rfe_defs = rtw8821c_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8821c_rfe_defs),
 	.rx_ldpc = false,
-	.pwr_track_tbl = &rtw8821c_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index fea7de9d6603..fa508a8c785c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2113,12 +2113,6 @@ static const struct rtw_intf_phy_para_table phy_para_table_8822b = {
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
@@ -2473,7 +2467,7 @@ static const u8 rtw8822b_pwrtrk_2g_cck_a_p[RTW_PWR_TRK_TBL_SZ] = {
 	10, 11, 11, 12, 12, 13, 13, 14, 14, 15
 };
 
-static const struct rtw_pwr_track_tbl rtw8822b_rtw_pwr_track_tbl = {
+static const struct rtw_pwr_track_tbl rtw8822b_pwr_track_type0_tbl = {
 	.pwrtrk_5gb_n[RTW_PWR_TRK_5G_1] = rtw8822b_pwrtrk_5gb_n[RTW_PWR_TRK_5G_1],
 	.pwrtrk_5gb_n[RTW_PWR_TRK_5G_2] = rtw8822b_pwrtrk_5gb_n[RTW_PWR_TRK_5G_2],
 	.pwrtrk_5gb_n[RTW_PWR_TRK_5G_3] = rtw8822b_pwrtrk_5gb_n[RTW_PWR_TRK_5G_3],
@@ -2496,6 +2490,12 @@ static const struct rtw_pwr_track_tbl rtw8822b_rtw_pwr_track_tbl = {
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
@@ -2575,7 +2575,6 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.rf_tbl = {&rtw8822b_rf_a_tbl, &rtw8822b_rf_b_tbl},
 	.rfe_defs = rtw8822b_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8822b_rfe_defs),
-	.pwr_track_tbl = &rtw8822b_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index d9bf992493fb..8cfca006f38d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4925,16 +4925,6 @@ static const struct rtw_intf_phy_para_table phy_para_table_8822c = {
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
@@ -5280,7 +5270,7 @@ static const u8 rtw8822c_pwrtrk_2g_cck_a_p[RTW_PWR_TRK_TBL_SZ] = {
 	18, 18, 19, 20, 21, 22, 23, 24, 24, 25
 };
 
-static const struct rtw_pwr_track_tbl rtw8822c_rtw_pwr_track_tbl = {
+static const struct rtw_pwr_track_tbl rtw8822c_pwr_track_type0_tbl = {
 	.pwrtrk_5gb_n[RTW_PWR_TRK_5G_1] = rtw8822c_pwrtrk_5gb_n[RTW_PWR_TRK_5G_1],
 	.pwrtrk_5gb_n[RTW_PWR_TRK_5G_2] = rtw8822c_pwrtrk_5gb_n[RTW_PWR_TRK_5G_2],
 	.pwrtrk_5gb_n[RTW_PWR_TRK_5G_3] = rtw8822c_pwrtrk_5gb_n[RTW_PWR_TRK_5G_3],
@@ -5303,6 +5293,16 @@ static const struct rtw_pwr_track_tbl rtw8822c_rtw_pwr_track_tbl = {
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
 static struct rtw_hw_reg_offset rtw8822c_edcca_th[] = {
 	[EDCCA_TH_L2H_IDX] = {
 		{.addr = 0x84c, .mask = MASKBYTE2}, .offset = 0x80
@@ -5401,7 +5401,6 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.rfe_defs_size = ARRAY_SIZE(rtw8822c_rfe_defs),
 	.en_dis_dpd = true,
 	.dpd_ratemask = DIS_DPD_RATEALL,
-	.pwr_track_tbl = &rtw8822c_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
 	.lck_threshold = 8,
 	.bfer_su_max_num = 2,
-- 
2.46.0


