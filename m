Return-Path: <linux-wireless+bounces-30798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE29AD1BF76
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 02:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E65C73010D67
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 01:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A0E17A303;
	Wed, 14 Jan 2026 01:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RgkrozQ0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E81B6527
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354855; cv=none; b=X2WZbi3sgKJxeLXfwF1Ne2yoPpGQmUuqDlh0mzSOfH7iksiNcMCsP6c2V2QuBXhu8o1zXnGHsuqn/u4EfEGQ89MqFTc5BaJdQkCNjb76EMP+Yht2mrVIAbXHepkOFT0wASa7spkghFr/fJhc/LMtX6L6WALlNouz5GXNGRfARbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354855; c=relaxed/simple;
	bh=Q1iL2Dlr9GvGSZ5vCe5KW8mcTU0pm1WpxQYIJa1yh0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8TpUQi/7R5MfgMZ6PWxb7u5MmfUE6Cm25+3UvgSpFQv7dM+g0nOVGnw+b93wdHCUJ3Zhv6ymPPE+Kdw1A+7tW49GidH/THtlII4vb9/QZfyMnNpMJi1KeT/urcZnedwnFCyZk6ICPVuZopr549EqA/HLqm0J4Ldg2Hsw/qPdhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RgkrozQ0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60E1epWE34168588, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768354851; bh=k/tqdiNb+jWZ17Ie5Qv2fdY+LWve+KUh+LRz6Y6Nnh4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=RgkrozQ0zpQcD4syLitVXUAesONcsefVm47yZbEooavz1F2Cf7GkaewuPVqscSF3h
	 WLZS3d+ZS2iHbj/y1Nkm9EPyQoNyS2NEneVB5KyWRWNFhRd4ZKDmle+cRHG3ilAWsn
	 PWQQFP2BiIVf8aTZpvYtC+aolZrl8pdE13npLKioWovDzkzMJHoXZq2pAcF9QGmjTM
	 7rdTsBfx1Qw7z3ejXunK9/i5TtMdGtxVDygoooLITpq8odNoEFivS6zgalUUikWfW6
	 5/oY1m60f4yeNs/unGI8hgyaPKQGwhzNvs3gzBmjsMwzcg+b8GIfdJFyRUYU/No+OR
	 /JE22I2u1v+hg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60E1epWE34168588
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:40:51 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:40:51 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 14 Jan 2026 09:40:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 06/12] wifi: rtw89: phy: abstract BB wrap registers to share initial flow
Date: Wed, 14 Jan 2026 09:39:44 +0800
Message-ID: <20260114013950.19704-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260114013950.19704-1-pkshih@realtek.com>
References: <20260114013950.19704-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

BB wrap registers are to configure TX power in MAC register domain, but
they are controlled and designed by BB layer. Since coming chips use
different register address, add a struct to define them.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c    |  1 +
 drivers/net/wireless/realtek/rtw89/phy.h    |  6 ++++++
 drivers/net/wireless/realtek/rtw89/phy_be.c | 20 ++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/reg.h    |  2 ++
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 099c0e0ae7b6..dbbbac1d9e3e 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -8229,6 +8229,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_ax = {
 	.ccx = &rtw89_ccx_regs_ax,
 	.physts = &rtw89_physts_regs_ax,
 	.cfo = &rtw89_cfo_regs_ax,
+	.bb_wrap = NULL,
 	.phy0_phy1_offset = rtw89_phy0_phy1_offset_ax,
 	.config_bb_gain = rtw89_phy_config_bb_gain_ax,
 	.preinit_rf_nctl = rtw89_phy_preinit_rf_nctl_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index f28580689626..0834569278cd 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -460,6 +460,11 @@ struct rtw89_cfo_regs {
 	u32 valid_0_mask;
 };
 
+struct rtw89_bb_wrap_regs {
+	u32 pwr_macid_lmt;
+	u32 pwr_macid_path;
+};
+
 enum rtw89_bandwidth_section_num_ax {
 	RTW89_BW20_SEC_NUM_AX = 8,
 	RTW89_BW40_SEC_NUM_AX = 4,
@@ -537,6 +542,7 @@ struct rtw89_phy_gen_def {
 	const struct rtw89_ccx_regs *ccx;
 	const struct rtw89_physts_regs *physts;
 	const struct rtw89_cfo_regs *cfo;
+	const struct rtw89_bb_wrap_regs *bb_wrap;
 	u32 (*phy0_phy1_offset)(struct rtw89_dev *rtwdev, u32 addr);
 	void (*config_bb_gain)(struct rtw89_dev *rtwdev,
 			       const struct rtw89_reg2_def *reg,
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 33c28a1666d4..e333c3eb1e9b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -160,6 +160,16 @@ static const struct rtw89_cfo_regs rtw89_cfo_regs_be_v1 = {
 	.valid_0_mask = B_DCFO_OPT_EN_BE,
 };
 
+static const struct rtw89_bb_wrap_regs rtw89_bb_wrap_regs_be = {
+	.pwr_macid_lmt = R_BE_PWR_MACID_LMT_BASE,
+	.pwr_macid_path = R_BE_PWR_MACID_PATH_BASE,
+};
+
+static const struct rtw89_bb_wrap_regs rtw89_bb_wrap_regs_be_v1 = {
+	.pwr_macid_lmt = R_BE_PWR_MACID_LMT_BASE_V1,
+	.pwr_macid_path = R_BE_PWR_MACID_PATH_BASE_V1,
+};
+
 static u32 rtw89_phy0_phy1_offset_be(struct rtw89_dev *rtwdev, u32 addr)
 {
 	u32 phy_page = addr >> 8;
@@ -406,9 +416,11 @@ static void rtw89_phy_preinit_rf_nctl_be_v1(struct rtw89_dev *rtwdev)
 static
 void rtw89_phy_bb_wrap_pwr_by_macid_init(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+	const struct rtw89_bb_wrap_regs *bb_wrap = phy->bb_wrap;
 	u32 macid_idx, cr, base_macid_lmt, max_macid = 32;
 
-	base_macid_lmt = R_BE_PWR_MACID_LMT_BASE;
+	base_macid_lmt = bb_wrap->pwr_macid_lmt;
 
 	for (macid_idx = 0; macid_idx < 4 * max_macid; macid_idx += 4) {
 		cr = base_macid_lmt + macid_idx;
@@ -419,8 +431,10 @@ void rtw89_phy_bb_wrap_pwr_by_macid_init(struct rtw89_dev *rtwdev)
 static
 void rtw89_phy_bb_wrap_tx_path_by_macid_init(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+	const struct rtw89_bb_wrap_regs *bb_wrap = phy->bb_wrap;
+	u32 cr = bb_wrap->pwr_macid_path;
 	int i, max_macid = 32;
-	u32 cr = R_BE_PWR_MACID_PATH_BASE;
 
 	for (i = 0; i < max_macid; i++, cr += 4)
 		rtw89_write32(rtwdev, cr, 0x03C86000);
@@ -1119,6 +1133,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 	.ccx = &rtw89_ccx_regs_be,
 	.physts = &rtw89_physts_regs_be,
 	.cfo = &rtw89_cfo_regs_be,
+	.bb_wrap = &rtw89_bb_wrap_regs_be,
 	.phy0_phy1_offset = rtw89_phy0_phy1_offset_be,
 	.config_bb_gain = rtw89_phy_config_bb_gain_be,
 	.preinit_rf_nctl = rtw89_phy_preinit_rf_nctl_be,
@@ -1139,6 +1154,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_be_v1 = {
 	.ccx = &rtw89_ccx_regs_be_v1,
 	.physts = &rtw89_physts_regs_be_v1,
 	.cfo = &rtw89_cfo_regs_be_v1,
+	.bb_wrap = &rtw89_bb_wrap_regs_be_v1,
 	.phy0_phy1_offset = rtw89_phy0_phy1_offset_be_v1,
 	.config_bb_gain = rtw89_phy_config_bb_gain_be,
 	.preinit_rf_nctl = rtw89_phy_preinit_rf_nctl_be_v1,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index fe51af1ecb4a..815b7d08663e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6365,7 +6365,9 @@
 #define B_BE_PTA_GNT_BT1_BB_SWCTRL BIT(0)
 
 #define R_BE_PWR_MACID_PATH_BASE 0x0E500
+#define R_BE_PWR_MACID_PATH_BASE_V1 0x1C000
 #define R_BE_PWR_MACID_LMT_BASE 0x0ED00
+#define R_BE_PWR_MACID_LMT_BASE_V1 0x1C800
 
 #define R_BE_CMAC_FUNC_EN 0x10000
 #define R_BE_CMAC_FUNC_EN_C1 0x14000
-- 
2.25.1


