Return-Path: <linux-wireless+bounces-30552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB3DD046EA
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 17:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B038E326D6ED
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3292F483E7D;
	Thu,  8 Jan 2026 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YaN1f8kN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3D5481670
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873848; cv=none; b=KkGnpMIExFNouf46wt6MTxuIV9hQIhU4uPR3aPRb8Fvc20SZEJti4+dk+xG+rDlV0YnfGW1Ke6Or1P1X/RojGaAbsyqvTX8FlfdNuV4o/1jhcFi/bXfWLFHLKMMfzkGQ5LrIa/W6CXuqUiokASf5JnYNSAlnT0Tlxp0DTD1fZqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873848; c=relaxed/simple;
	bh=liA2TGh7yu4q7SRpQ4UPXmWOV0FQpFoclE9v/S4svW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhU5Pdzed/gFX7EmKjTQpKvUFvApxBpukOoelU7W3Y/LqfUjQ02MqN72pLS3W+sWZYBvWplOJYnDlASYPRpzGWgTIvkw2bv9gYa49kFxZhHZmOqiUZ2EVLQL47bUUbnBeTn42fLIVMP35CR9LS1URH/l3rSofWaciyajOkkG56U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YaN1f8kN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 608C41toC970651, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767873841; bh=GpTaaRjqZEozvHiAHEyG+8vvKYnMaoBZhleHE47ZpWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=YaN1f8kN2u2ycws/786h6XwZ5TN9ciWEdyNh6MbbmuKQE9kuoR3k7Mfdr+pHQQX0J
	 T61SkSvnSw2PeHvbNQC2Y/yI1IKa0TUOTYPvA8dqklfAAeqMbPUqURgZWu/2T/ZOvR
	 LQgL1y374V70v/PLXH9DNeu3ufXGA+yXG79JivaFCWPRbfJe5YB2jtS/cHuo2suUOA
	 uv0XJ1V1oFRFcv9snkabvbk918txmwjdWQwU419Re71XUWVbuzVC6IC54XkvwsQ1yT
	 /ugSpYqZP8SjkSEcFdkAGicI+x3fY+4Pdb7jTDz2QC0cXF2hDzWHhS0F8vo25M4fSg
	 sHOmXnmq4WWcA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 608C41toC970651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 20:04:01 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:04:02 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 8 Jan 2026 20:04:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: [PATCH rtw-next 08/13] wifi: rtw89: mac: update WP quota for RTL8922D
Date: Thu, 8 Jan 2026 20:03:15 +0800
Message-ID: <20260108120320.2217402-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260108120320.2217402-1-pkshih@realtek.com>
References: <20260108120320.2217402-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

WP (WiFi payload) quota is to point to payload being transmitting in
memory. Assign quota to indicate WP page full.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h   |  5 ++++
 drivers/net/wireless/realtek/rtw89/mac.c    |  4 +--
 drivers/net/wireless/realtek/rtw89/mac_be.c | 27 ++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/reg.h    |  5 ++++
 4 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 82d295fdd55d..f8d36343d68e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3978,6 +3978,11 @@ struct rtw89_hfc_prec_cfg {
 	u8 h2c_full_cond;
 	u8 wp_ch07_full_cond;
 	u8 wp_ch811_full_cond;
+	/* for WiFi 7 chips after 8922D */
+	u16 ch011_full_page;
+	u16 h2c_full_page;
+	u16 wp_ch07_full_page;
+	u16 wp_ch811_full_page;
 };
 
 struct rtw89_hfc_param {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 35794488a02f..a008a1a02fe9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1701,8 +1701,8 @@ static int sys_init_ax(struct rtw89_dev *rtwdev)
 
 const struct rtw89_mac_size_set rtw89_mac_size = {
 	.hfc_preccfg_pcie = {2, 40, 0, 0, 1, 0, 0, 0},
-	.hfc_prec_cfg_c0 = {2, 32, 0, 0, 0, 0, 0, 0},
-	.hfc_prec_cfg_c2 = {0, 256, 0, 0, 0, 0, 0, 0},
+	.hfc_prec_cfg_c0 = {2, 32, 0, 0, 0, 0, 0, 0, 2, 32, 0, 0},
+	.hfc_prec_cfg_c2 = {0, 256, 0, 0, 0, 0, 0, 0, 0, 256, 0, 0},
 	/* PCIE 64 */
 	.wde_size0 = {RTW89_WDE_PG_64, 4095, 1,},
 	.wde_size0_v1 = {RTW89_WDE_PG_64, 3328, 0, 0,},
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 0327629d2a5d..5df243cf448e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -89,6 +89,7 @@ static void hfc_get_mix_info_be(struct rtw89_dev *rtwdev)
 	struct rtw89_hfc_prec_cfg *prec_cfg = &param->prec_cfg;
 	struct rtw89_hfc_pub_cfg *pub_cfg = &param->pub_cfg;
 	struct rtw89_hfc_pub_info *info = &param->pub_info;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 val;
 
 	val = rtw89_read32(rtwdev, R_BE_PUB_PAGE_INFO1);
@@ -116,14 +117,23 @@ static void hfc_get_mix_info_be(struct rtw89_dev *rtwdev)
 
 	val = rtw89_read32(rtwdev, R_BE_CH_PAGE_CTRL);
 	prec_cfg->ch011_prec = u32_get_bits(val, B_BE_PREC_PAGE_CH011_V1_MASK);
+	if (chip->chip_id == RTL8922D)
+		prec_cfg->ch011_full_page = u32_get_bits(val, B_BE_FULL_WD_PG_MASK);
 	prec_cfg->h2c_prec = u32_get_bits(val, B_BE_PREC_PAGE_CH12_V1_MASK);
 
 	val = rtw89_read32(rtwdev, R_BE_PUB_PAGE_CTRL2);
 	pub_cfg->pub_max = u32_get_bits(val, B_BE_PUBPG_ALL_MASK);
 
 	val = rtw89_read32(rtwdev, R_BE_WP_PAGE_CTRL1);
-	prec_cfg->wp_ch07_prec = u32_get_bits(val, B_BE_PREC_PAGE_WP_CH07_MASK);
-	prec_cfg->wp_ch811_prec = u32_get_bits(val, B_BE_PREC_PAGE_WP_CH811_MASK);
+	if (chip->chip_id == RTL8922D) {
+		prec_cfg->wp_ch07_prec = u32_get_bits(val, B_BE_PREC_PAGE_WP_CH07_V1_MASK);
+		prec_cfg->wp_ch07_full_page = u32_get_bits(val, B_BE_FULL_PAGE_WP_CH07_MASK);
+		prec_cfg->wp_ch811_prec = u32_get_bits(val, B_BE_PREC_PAGE_WP_CH811_V1_MASK);
+		prec_cfg->wp_ch811_full_page = u32_get_bits(val, B_BE_FULL_PAGE_WP_CH811_MASK);
+	} else {
+		prec_cfg->wp_ch07_prec = u32_get_bits(val, B_BE_PREC_PAGE_WP_CH07_MASK);
+		prec_cfg->wp_ch811_prec = u32_get_bits(val, B_BE_PREC_PAGE_WP_CH811_MASK);
+	}
 
 	val = rtw89_read32(rtwdev, R_BE_WP_PAGE_CTRL2);
 	pub_cfg->wp_thrd = u32_get_bits(val, B_BE_WP_THRD_MASK);
@@ -148,17 +158,26 @@ static void hfc_mix_cfg_be(struct rtw89_dev *rtwdev)
 	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
 	const struct rtw89_hfc_prec_cfg *prec_cfg = &param->prec_cfg;
 	const struct rtw89_hfc_pub_cfg *pub_cfg = &param->pub_cfg;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 val;
 
 	val = u32_encode_bits(prec_cfg->ch011_prec, B_BE_PREC_PAGE_CH011_V1_MASK) |
 	      u32_encode_bits(prec_cfg->h2c_prec, B_BE_PREC_PAGE_CH12_V1_MASK);
+	if (chip->chip_id == RTL8922D)
+		val = u32_replace_bits(val, prec_cfg->ch011_full_page, B_BE_FULL_WD_PG_MASK);
 	rtw89_write32(rtwdev, R_BE_CH_PAGE_CTRL, val);
 
 	val = u32_encode_bits(pub_cfg->pub_max, B_BE_PUBPG_ALL_MASK);
 	rtw89_write32(rtwdev, R_BE_PUB_PAGE_CTRL2, val);
 
-	val = u32_encode_bits(prec_cfg->wp_ch07_prec, B_BE_PREC_PAGE_WP_CH07_MASK) |
-	      u32_encode_bits(prec_cfg->wp_ch811_prec, B_BE_PREC_PAGE_WP_CH811_MASK);
+	if (chip->chip_id == RTL8922D)
+		val = u32_encode_bits(prec_cfg->wp_ch07_prec, B_BE_PREC_PAGE_WP_CH07_V1_MASK) |
+		      u32_encode_bits(prec_cfg->wp_ch07_full_page, B_BE_FULL_PAGE_WP_CH07_MASK) |
+		      u32_encode_bits(prec_cfg->wp_ch811_prec, B_BE_PREC_PAGE_WP_CH811_V1_MASK) |
+		      u32_encode_bits(prec_cfg->wp_ch811_full_page, B_BE_FULL_PAGE_WP_CH811_MASK);
+	else
+		val = u32_encode_bits(prec_cfg->wp_ch07_prec, B_BE_PREC_PAGE_WP_CH07_MASK) |
+		      u32_encode_bits(prec_cfg->wp_ch811_prec, B_BE_PREC_PAGE_WP_CH811_MASK);
 	rtw89_write32(rtwdev, R_BE_WP_PAGE_CTRL1, val);
 
 	val = u32_replace_bits(rtw89_read32(rtwdev, R_BE_HCI_FC_CTRL),
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index e41a6c679d59..79c976c25de5 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6117,6 +6117,7 @@
 
 #define R_BE_CH_PAGE_CTRL 0xB704
 #define B_BE_PREC_PAGE_CH12_V1_MASK GENMASK(21, 16)
+#define B_BE_FULL_WD_PG_MASK GENMASK(15, 8)
 #define B_BE_PREC_PAGE_CH011_V1_MASK GENMASK(5, 0)
 
 #define R_BE_CH0_PAGE_CTRL 0xB718
@@ -6149,6 +6150,10 @@
 #define R_BE_WP_PAGE_CTRL1 0xB7A4
 #define B_BE_PREC_PAGE_WP_CH811_MASK GENMASK(24, 16)
 #define B_BE_PREC_PAGE_WP_CH07_MASK GENMASK(8, 0)
+#define B_BE_FULL_PAGE_WP_CH811_MASK GENMASK(31, 24)
+#define B_BE_PREC_PAGE_WP_CH811_V1_MASK GENMASK(23, 16)
+#define B_BE_FULL_PAGE_WP_CH07_MASK GENMASK(15, 8)
+#define B_BE_PREC_PAGE_WP_CH07_V1_MASK GENMASK(7, 0)
 
 #define R_BE_WP_PAGE_CTRL2 0xB7A8
 #define B_BE_WP_THRD_MASK GENMASK(12, 0)
-- 
2.25.1


