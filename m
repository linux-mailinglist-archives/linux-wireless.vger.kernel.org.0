Return-Path: <linux-wireless+bounces-30796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E36DED1BF70
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 02:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69F7F3008DE0
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 01:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB5F1B6527;
	Wed, 14 Jan 2026 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="S6q3y9i4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB6F2EA72A
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354845; cv=none; b=O2CgHvhK3pJdJGROGu+yG5sKCZtcpnoOcSCsbEUymzpmZK4sJyYRNb0BucRD3wg0YaNLaDAURwqkSgbFhGVCNA4FQivs9EsMV0lkFRE3T3EwT4ROenTezUxhsQGb1kXnx6UOF+Fv2jSLo38mFXyePp7MYGkD1HhOeLwCHeVoUWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354845; c=relaxed/simple;
	bh=5fTl5AjZjWYy5OVLY5lWCEhsAzusEtnwUCSdI4nR+h8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYOp/jXT27I5xpH2dPD1BtcKQmSkNF+15X8EpwfxOq4VyGvLFNY/geFoLDMFwaLHG3BW83KEaVfLnhgcFu/+08MK4dPFZvimC9GBVLRgMKlMoIigN9wVvR4zvPav3rutYDq660JoX9IxYZ3emSlgEBWFCJfD6aP1rvVbPFQ5d4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=S6q3y9i4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60E1eeFuB4168567, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768354840; bh=zHJfIz/4BQhxWyYMQf7saUgWVh/yvrTVCV0Jq9SFzv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=S6q3y9i4xOqiv8KOh4hekCWd0VGzQoFWxvbiWHvVRUxq8xi1Lv/ltHSExt1U12SdZ
	 0e7qunaNXayA/NiAj2c1wqFOO5do3HzGdi8kaIFCPigEuEA2T11bPD74evaCjdfL7p
	 hAVafcirac1KZlfz0hmN1MySVwrN9a9H+mjSDHrWfENXFZTORgiHHYJ29OuEUOi0hQ
	 ZTkhZkRTKno/oPxlXCo7DEJxPH49jHod+CbUMzA5ksWRAIdmE4AudRSk/JGprWWG4t
	 mD5h8n9qyx00KYXeg7RdDaOx56J8wTN/CFb92e5+ViEv/MvxNGVv24sRXzR2vbFj9I
	 N2rb3UgyozyAQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60E1eeFuB4168567
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:40:40 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:40:41 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:40:41 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 14 Jan 2026 09:40:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 04/12] wifi: rtw89: phy: abstract start address and EHT of PHY status bitmap
Date: Wed, 14 Jan 2026 09:39:42 +0800
Message-ID: <20260114013950.19704-5-pkshih@realtek.com>
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

Select PHY status being reported by a set of addresses. Abstract the
address and EHT bitmap to share common flow.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c    | 31 +++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/phy.h    |  2 ++
 drivers/net/wireless/realtek/rtw89/phy_be.c |  4 +++
 drivers/net/wireless/realtek/rtw89/reg.h    |  5 +++-
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index a7ae8b277dd5..882a8a26e434 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -6399,14 +6399,16 @@ static bool rtw89_physts_ie_page_valid(struct rtw89_dev *rtwdev,
 	return true;
 }
 
-static u32 rtw89_phy_get_ie_bitmap_addr(enum rtw89_phy_status_bitmap ie_page)
+static u32 rtw89_phy_get_ie_bitmap_addr(struct rtw89_dev *rtwdev,
+					enum rtw89_phy_status_bitmap ie_page)
 {
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 	static const u8 ie_page_shift = 2;
 
 	if (ie_page == RTW89_EHT_PKT)
-		return R_PHY_STS_BITMAP_EHT;
+		return phy->physt_bmp_eht;
 
-	return R_PHY_STS_BITMAP_ADDR_START + (ie_page << ie_page_shift);
+	return phy->physt_bmp_start + (ie_page << ie_page_shift);
 }
 
 static u32 rtw89_physts_get_ie_bitmap(struct rtw89_dev *rtwdev,
@@ -6418,7 +6420,7 @@ static u32 rtw89_physts_get_ie_bitmap(struct rtw89_dev *rtwdev,
 	if (!rtw89_physts_ie_page_valid(rtwdev, &ie_page))
 		return 0;
 
-	addr = rtw89_phy_get_ie_bitmap_addr(ie_page);
+	addr = rtw89_phy_get_ie_bitmap_addr(rtwdev, ie_page);
 
 	return rtw89_phy_read32_idx(rtwdev, addr, MASKDWORD, phy_idx);
 }
@@ -6436,7 +6438,7 @@ static void rtw89_physts_set_ie_bitmap(struct rtw89_dev *rtwdev,
 	if (chip->chip_id == RTL8852A)
 		val &= B_PHY_STS_BITMAP_MSK_52A;
 
-	addr = rtw89_phy_get_ie_bitmap_addr(ie_page);
+	addr = rtw89_phy_get_ie_bitmap_addr(rtwdev, ie_page);
 	rtw89_phy_write32_idx(rtwdev, addr, MASKDWORD, val, phy_idx);
 }
 
@@ -6460,6 +6462,17 @@ static void rtw89_physts_enable_fail_report(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw89_physts_enable_hdr_2(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->chip_gen == RTW89_CHIP_AX || chip->chip_id == RTL8922A)
+		return;
+
+	rtw89_phy_write32_idx_set(rtwdev, R_STS_HDR2_PARSING_BE4,
+				  B_STS_HDR2_PARSING_BE4, phy_idx);
+}
+
 static void __rtw89_physts_parsing_init(struct rtw89_dev *rtwdev,
 					enum rtw89_phy_idx phy_idx)
 {
@@ -6469,6 +6482,9 @@ static void __rtw89_physts_parsing_init(struct rtw89_dev *rtwdev,
 
 	rtw89_physts_enable_fail_report(rtwdev, false, phy_idx);
 
+	/* enable hdr_2 for 8922D (PHYSTS_BE_GEN2 above) */
+	rtw89_physts_enable_hdr_2(rtwdev, phy_idx);
+
 	for (i = 0; i < RTW89_PHYSTS_BITMAP_NUM; i++) {
 		if (i == RTW89_RSVD_9 ||
 		    (i == RTW89_EHT_PKT && chip->chip_gen == RTW89_CHIP_AX))
@@ -6834,6 +6850,9 @@ static void rtw89_phy_dig_sdagc_follow_pagc_config(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
 
+	if (rtwdev->chip->chip_gen != RTW89_CHIP_AX)
+		return;
+
 	rtw89_phy_write32_idx(rtwdev, dig_regs->p0_p20_pagcugc_en.addr,
 			      dig_regs->p0_p20_pagcugc_en.mask, enable, bb->phy_idx);
 	rtw89_phy_write32_idx(rtwdev, dig_regs->p0_s20_pagcugc_en.addr,
@@ -8203,6 +8222,8 @@ static const struct rtw89_cfo_regs rtw89_cfo_regs_ax = {
 
 const struct rtw89_phy_gen_def rtw89_phy_gen_ax = {
 	.cr_base = 0x10000,
+	.physt_bmp_start = R_PHY_STS_BITMAP_ADDR_START,
+	.physt_bmp_eht = 0xfc,
 	.ccx = &rtw89_ccx_regs_ax,
 	.physts = &rtw89_physts_regs_ax,
 	.cfo = &rtw89_cfo_regs_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 02bbb975ce65..8506c607de4d 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -531,6 +531,8 @@ struct rtw89_phy_rfk_log_fmt {
 
 struct rtw89_phy_gen_def {
 	u32 cr_base;
+	u32 physt_bmp_start;
+	u32 physt_bmp_eht;
 	const struct rtw89_ccx_regs *ccx;
 	const struct rtw89_physts_regs *physts;
 	const struct rtw89_cfo_regs *cfo;
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 895615df5d7e..a609cd0c5268 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -1112,6 +1112,8 @@ static void rtw89_phy_set_txpwr_limit_ru_be(struct rtw89_dev *rtwdev,
 
 const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 	.cr_base = 0x20000,
+	.physt_bmp_start = R_PHY_STS_BITMAP_ADDR_START,
+	.physt_bmp_eht = R_PHY_STS_BITMAP_EHT,
 	.ccx = &rtw89_ccx_regs_be,
 	.physts = &rtw89_physts_regs_be,
 	.cfo = &rtw89_cfo_regs_be,
@@ -1130,6 +1132,8 @@ EXPORT_SYMBOL(rtw89_phy_gen_be);
 
 const struct rtw89_phy_gen_def rtw89_phy_gen_be_v1 = {
 	.cr_base = 0x0,
+	.physt_bmp_start = R_PHY_STS_BITMAP_ADDR_START_BE4,
+	.physt_bmp_eht = R_PHY_STS_BITMAP_EHT_BE4,
 	.ccx = &rtw89_ccx_regs_be_v1,
 	.physts = &rtw89_physts_regs_be_v1,
 	.cfo = &rtw89_cfo_regs_be_v1,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 928b8cb644b8..fe51af1ecb4a 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8464,6 +8464,7 @@
 #define B_STS_DIS_TRIG_BY_FAIL BIT(3)
 #define B_STS_DIS_TRIG_BY_BRK BIT(2)
 #define R_PHY_STS_BITMAP_ADDR_START R_PHY_STS_BITMAP_SEARCH_FAIL
+#define R_PHY_STS_BITMAP_ADDR_START_BE4 0x2073C
 #define B_PHY_STS_BITMAP_ADDR_MASK GENMASK(6, 2)
 #define R_PHY_STS_BITMAP_SEARCH_FAIL 0x073C
 #define B_PHY_STS_BITMAP_MSK_52A 0x337cff3f
@@ -8482,6 +8483,7 @@
 #define R_PHY_STS_BITMAP_VHT 0x0770
 #define R_PHY_STS_BITMAP_HE 0x0774
 #define R_PHY_STS_BITMAP_EHT 0x0788
+#define R_PHY_STS_BITMAP_EHT_BE4 0x20788
 #define R_EDCCA_RPTREG_SEL_BE 0x078C
 #define B_EDCCA_RPTREG_SEL_BE_MSK GENMASK(22, 20)
 #define R_PMAC_GNT 0x0980
@@ -9914,7 +9916,8 @@
 
 #define R_CHINFO_SEG_BE4 0x200B4
 #define B_CHINFO_SEG_LEN_BE4 GENMASK(12, 10)
-
+#define R_STS_HDR2_PARSING_BE4 0x2070C
+#define B_STS_HDR2_PARSING_BE4 BIT(10)
 #define R_SW_SI_WDATA_BE4 0x20370
 #define B_SW_SI_DATA_PATH_BE4 GENMASK(31, 28)
 #define B_SW_SI_DATA_ADR_BE4 GENMASK(27, 20)
-- 
2.25.1


