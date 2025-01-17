Return-Path: <linux-wireless+bounces-17630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A54A14A26
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 08:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DCB188A739
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 07:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25FC1F78FD;
	Fri, 17 Jan 2025 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="A9e0k6Rg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C90C1F7907
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098969; cv=none; b=eh+Cymw8s+GXies0TNiG9kOJ7pqcLyup+E8M7HHFpMaia2NKksbBP5jqp3QT9qT2L7lvxdY/gmCbLc6RPWR2zs1rQuz9KzPdoklU2bt5YnytLbyHR7feYta+7ybIBKUi8kCwu4FGEMG0kAw2JFsDMDhZ5PWelUN3g9WVMI+HYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098969; c=relaxed/simple;
	bh=//WbCKdbzmXh3sgaOcJ6nJgvUMJWUeSRakxAGYNvrUQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdLYgnahndLTjIOKRii9hRl4xqyurAMXErbGqOYkSn55HrD85KODUF94kTh3fB57tyn9ijVM8VFDBZRwDObNJCMfTpJyqzpp5bNR7w+imnfM7ZyoxCFwTLvFWIu2nBH30W0FdbAG7NLZGTqFhDoxIDvSHQZFtFSdvW3yf3UvzPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=A9e0k6Rg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50H7TPXm82337847, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737098965; bh=//WbCKdbzmXh3sgaOcJ6nJgvUMJWUeSRakxAGYNvrUQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=A9e0k6Rg/skj0fJb6SmDgfMHsGiSlWpPcHIhQkUyOFNUuLcNK6Ljymb80T41jwjA+
	 6p+/4s6ZCKVxaZnRlkyqj/yN0624IJf2hSs6DQk/og1nQLhXs43o//8iWjFONxI+sK
	 6wKlji/KopeGpwb82PNgKKVhNK36w7+VJEWR6BqnvMLi19+dY9qEnkYcZpnMZ8ely4
	 exBdknNd5bWrd7HbCX3N1jbRKJKlb/LDV7njv44PSBtK0GM7hMu06apYaXiH4fXbtP
	 gRaokNxP3humoYr7pYOuEzPjobgGyKcLsWQg6ys6JbBAeblduMVcQVj6gpw6ICTn3/
	 IR996qN9UqMAg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50H7TPXm82337847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 15:29:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 Jan 2025 15:29:25 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 17 Jan
 2025 15:29:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/8] wifi: rtw89: phy: support EDCCA log per PHY
Date: Fri, 17 Jan 2025 15:28:27 +0800
Message-ID: <20250117072828.16728-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117072828.16728-1-pkshih@realtek.com>
References: <20250117072828.16728-1-pkshih@realtek.com>
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

The registers of EDCCA log for PHY 1 isn't a simple offset, so define
them accordingly. Then the function use register set to access reports
according to phy_idx.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 10 ++--
 drivers/net/wireless/realtek/rtw89/phy.c      | 48 +++++++++++--------
 drivers/net/wireless/realtek/rtw89/reg.h      |  5 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 15 ++++--
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 15 ++++--
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 15 ++++--
 .../net/wireless/realtek/rtw89/rtw8852bt.c    | 15 ++++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 15 ++++--
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 15 ++++--
 9 files changed, 104 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e4e9ae6e609b..afa792d4a815 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4189,10 +4189,12 @@ struct rtw89_edcca_regs {
 	u32 edcca_p_mask;
 	u32 ppdu_level;
 	u32 ppdu_mask;
-	u32 rpt_a;
-	u32 rpt_b;
-	u32 rpt_sel;
-	u32 rpt_sel_mask;
+	struct rtw89_edcca_p_regs {
+		u32 rpt_a;
+		u32 rpt_b;
+		u32 rpt_sel;
+		u32 rpt_sel_mask;
+	} p[RTW89_PHY_NUM];
 	u32 rpt_sel_be;
 	u32 rpt_sel_be_mask;
 	u32 tx_collision_t2r_st;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index f1029da4a78e..a5299295b777 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -7017,6 +7017,7 @@ void rtw89_phy_config_edcca(struct rtw89_dev *rtwdev,
 static void rtw89_phy_edcca_log(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
 {
 	const struct rtw89_edcca_regs *edcca_regs = rtwdev->chip->edcca_regs;
+	const struct rtw89_edcca_p_regs *edcca_p_regs;
 	bool flag_fb, flag_p20, flag_s20, flag_s40, flag_s80;
 	s8 pwdb_fb, pwdb_p20, pwdb_s20, pwdb_s40, pwdb_s80;
 	u8 path, per20_bitmap;
@@ -7026,13 +7027,18 @@ static void rtw89_phy_edcca_log(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *b
 	if (!rtw89_debug_is_enabled(rtwdev, RTW89_DBG_EDCCA))
 		return;
 
+	if (bb->phy_idx == RTW89_PHY_1)
+		edcca_p_regs = &edcca_regs->p[RTW89_PHY_1];
+	else
+		edcca_p_regs = &edcca_regs->p[RTW89_PHY_0];
+
 	if (rtwdev->chip->chip_id == RTL8922A)
 		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel_be,
 				       edcca_regs->rpt_sel_be_mask, 0);
 
-	rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel,
-			       edcca_regs->rpt_sel_mask, 0);
-	tmp = rtw89_phy_read32(rtwdev, edcca_regs->rpt_b);
+	rtw89_phy_write32_mask(rtwdev, edcca_p_regs->rpt_sel,
+			       edcca_p_regs->rpt_sel_mask, 0);
+	tmp = rtw89_phy_read32(rtwdev, edcca_p_regs->rpt_b);
 	path = u32_get_bits(tmp, B_EDCCA_RPT_B_PATH_MASK);
 	flag_s80 = u32_get_bits(tmp, B_EDCCA_RPT_B_S80);
 	flag_s40 = u32_get_bits(tmp, B_EDCCA_RPT_B_S40);
@@ -7043,19 +7049,19 @@ static void rtw89_phy_edcca_log(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *b
 	pwdb_p20 = u32_get_bits(tmp, MASKBYTE2);
 	pwdb_fb = u32_get_bits(tmp, MASKBYTE3);
 
-	rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel,
-			       edcca_regs->rpt_sel_mask, 4);
-	tmp = rtw89_phy_read32(rtwdev, edcca_regs->rpt_b);
+	rtw89_phy_write32_mask(rtwdev, edcca_p_regs->rpt_sel,
+			       edcca_p_regs->rpt_sel_mask, 4);
+	tmp = rtw89_phy_read32(rtwdev, edcca_p_regs->rpt_b);
 	pwdb_s80 = u32_get_bits(tmp, MASKBYTE1);
 	pwdb_s40 = u32_get_bits(tmp, MASKBYTE2);
 
-	per20_bitmap = rtw89_phy_read32_mask(rtwdev, edcca_regs->rpt_a,
+	per20_bitmap = rtw89_phy_read32_mask(rtwdev, edcca_p_regs->rpt_a,
 					     MASKBYTE0);
 
 	if (rtwdev->chip->chip_id == RTL8922A) {
 		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel_be,
 				       edcca_regs->rpt_sel_be_mask, 4);
-		tmp = rtw89_phy_read32(rtwdev, edcca_regs->rpt_b);
+		tmp = rtw89_phy_read32(rtwdev, edcca_p_regs->rpt_b);
 		pwdb[0] = u32_get_bits(tmp, MASKBYTE3);
 		pwdb[1] = u32_get_bits(tmp, MASKBYTE2);
 		pwdb[2] = u32_get_bits(tmp, MASKBYTE1);
@@ -7063,33 +7069,33 @@ static void rtw89_phy_edcca_log(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *b
 
 		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel_be,
 				       edcca_regs->rpt_sel_be_mask, 5);
-		tmp = rtw89_phy_read32(rtwdev, edcca_regs->rpt_b);
+		tmp = rtw89_phy_read32(rtwdev, edcca_p_regs->rpt_b);
 		pwdb[4] = u32_get_bits(tmp, MASKBYTE3);
 		pwdb[5] = u32_get_bits(tmp, MASKBYTE2);
 		pwdb[6] = u32_get_bits(tmp, MASKBYTE1);
 		pwdb[7] = u32_get_bits(tmp, MASKBYTE0);
 	} else {
-		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel,
-				       edcca_regs->rpt_sel_mask, 0);
-		tmp = rtw89_phy_read32(rtwdev, edcca_regs->rpt_a);
+		rtw89_phy_write32_mask(rtwdev, edcca_p_regs->rpt_sel,
+				       edcca_p_regs->rpt_sel_mask, 0);
+		tmp = rtw89_phy_read32(rtwdev, edcca_p_regs->rpt_a);
 		pwdb[0] = u32_get_bits(tmp, MASKBYTE3);
 		pwdb[1] = u32_get_bits(tmp, MASKBYTE2);
 
-		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel,
-				       edcca_regs->rpt_sel_mask, 1);
-		tmp = rtw89_phy_read32(rtwdev, edcca_regs->rpt_a);
+		rtw89_phy_write32_mask(rtwdev, edcca_p_regs->rpt_sel,
+				       edcca_p_regs->rpt_sel_mask, 1);
+		tmp = rtw89_phy_read32(rtwdev, edcca_p_regs->rpt_a);
 		pwdb[2] = u32_get_bits(tmp, MASKBYTE3);
 		pwdb[3] = u32_get_bits(tmp, MASKBYTE2);
 
-		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel,
-				       edcca_regs->rpt_sel_mask, 2);
-		tmp = rtw89_phy_read32(rtwdev, edcca_regs->rpt_a);
+		rtw89_phy_write32_mask(rtwdev, edcca_p_regs->rpt_sel,
+				       edcca_p_regs->rpt_sel_mask, 2);
+		tmp = rtw89_phy_read32(rtwdev, edcca_p_regs->rpt_a);
 		pwdb[4] = u32_get_bits(tmp, MASKBYTE3);
 		pwdb[5] = u32_get_bits(tmp, MASKBYTE2);
 
-		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel,
-				       edcca_regs->rpt_sel_mask, 3);
-		tmp = rtw89_phy_read32(rtwdev, edcca_regs->rpt_a);
+		rtw89_phy_write32_mask(rtwdev, edcca_p_regs->rpt_sel,
+				       edcca_p_regs->rpt_sel_mask, 3);
+		tmp = rtw89_phy_read32(rtwdev, edcca_p_regs->rpt_a);
 		pwdb[6] = u32_get_bits(tmp, MASKBYTE3);
 		pwdb[7] = u32_get_bits(tmp, MASKBYTE2);
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 10d0efa7a58e..c992835d4b63 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8157,6 +8157,8 @@
 #define B_EDCCA_RPT_B_S40 BIT(4)
 #define B_EDCCA_RPT_B_S80 BIT(3)
 #define B_EDCCA_RPT_B_PATH_MASK GENMASK(2, 1)
+#define R_EDCCA_RPT_P1_A 0x1740
+#define R_EDCCA_RPT_P1_B 0x1744
 #define R_SWSI_V1 0x174C
 #define B_SWSI_W_BUSY_V1 BIT(24)
 #define B_SWSI_R_BUSY_V1 BIT(25)
@@ -8222,6 +8224,7 @@
 #define B_TXCKEN_FORCE_ALL GENMASK(24, 0)
 #define R_EDCCA_RPT_SEL 0x20CC
 #define B_EDCCA_RPT_SEL_MSK GENMASK(2, 0)
+#define B_EDCCA_RPT_SEL_P1_MSK GENMASK(5, 3)
 #define R_ADC_FIFO 0x20fc
 #define B_ADC_FIFO_RST GENMASK(31, 24)
 #define B_ADC_FIFO_RXK GENMASK(31, 16)
@@ -8291,6 +8294,8 @@
 #define B_P1_EN_SOUND_WO_NDP BIT(1)
 #define R_EDCCA_RPT_A_BE 0x2E38
 #define R_EDCCA_RPT_B_BE 0x2E3C
+#define R_EDCCA_RPT_P1_A_BE 0x2E40
+#define R_EDCCA_RPT_P1_B_BE 0x2E44
 #define R_S1_HW_SI_DIS 0x3200
 #define B_S1_HW_SI_DIS_W_R_TRIG GENMASK(30, 28)
 #define R_P1_RXCK 0x32A0
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index c56f70267882..d23896de6812 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -224,10 +224,17 @@ static const struct rtw89_edcca_regs rtw8851b_edcca_regs = {
 	.edcca_p_mask			= B_EDCCA_LVL_MSK1,
 	.ppdu_level			= R_SEG0R_EDCCA_LVL_V1,
 	.ppdu_mask			= B_EDCCA_LVL_MSK3,
-	.rpt_a				= R_EDCCA_RPT_A,
-	.rpt_b				= R_EDCCA_RPT_B,
-	.rpt_sel			= R_EDCCA_RPT_SEL,
-	.rpt_sel_mask			= B_EDCCA_RPT_SEL_MSK,
+	.p = {{
+		.rpt_a			= R_EDCCA_RPT_A,
+		.rpt_b			= R_EDCCA_RPT_B,
+		.rpt_sel		= R_EDCCA_RPT_SEL,
+		.rpt_sel_mask		= B_EDCCA_RPT_SEL_MSK,
+	}, {
+		.rpt_a			= R_EDCCA_RPT_P1_A,
+		.rpt_b			= R_EDCCA_RPT_P1_B,
+		.rpt_sel		= R_EDCCA_RPT_SEL,
+		.rpt_sel_mask		= B_EDCCA_RPT_SEL_P1_MSK,
+	}},
 	.tx_collision_t2r_st		= R_TX_COLLISION_T2R_ST,
 	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_M,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 9bd2842c27d5..27ffbb3b26fc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -522,10 +522,17 @@ static const struct rtw89_edcca_regs rtw8852a_edcca_regs = {
 	.edcca_p_mask			= B_EDCCA_LVL_MSK1,
 	.ppdu_level			= R_SEG0R_EDCCA_LVL,
 	.ppdu_mask			= B_EDCCA_LVL_MSK3,
-	.rpt_a				= R_EDCCA_RPT_A,
-	.rpt_b				= R_EDCCA_RPT_B,
-	.rpt_sel			= R_EDCCA_RPT_SEL,
-	.rpt_sel_mask			= B_EDCCA_RPT_SEL_MSK,
+	.p = {{
+		.rpt_a			= R_EDCCA_RPT_A,
+		.rpt_b			= R_EDCCA_RPT_B,
+		.rpt_sel		= R_EDCCA_RPT_SEL,
+		.rpt_sel_mask		= B_EDCCA_RPT_SEL_MSK,
+	}, {
+		.rpt_a			= R_EDCCA_RPT_P1_A,
+		.rpt_b			= R_EDCCA_RPT_P1_B,
+		.rpt_sel		= R_EDCCA_RPT_SEL,
+		.rpt_sel_mask		= B_EDCCA_RPT_SEL_P1_MSK,
+	}},
 	.tx_collision_t2r_st		= R_TX_COLLISION_T2R_ST,
 	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_M,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index dfb2bf61b0b8..8b92f2219fb9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -189,10 +189,17 @@ static const struct rtw89_edcca_regs rtw8852b_edcca_regs = {
 	.edcca_p_mask			= B_EDCCA_LVL_MSK1,
 	.ppdu_level			= R_SEG0R_EDCCA_LVL_V1,
 	.ppdu_mask			= B_EDCCA_LVL_MSK3,
-	.rpt_a				= R_EDCCA_RPT_A,
-	.rpt_b				= R_EDCCA_RPT_B,
-	.rpt_sel			= R_EDCCA_RPT_SEL,
-	.rpt_sel_mask			= B_EDCCA_RPT_SEL_MSK,
+	.p = {{
+		.rpt_a			= R_EDCCA_RPT_A,
+		.rpt_b			= R_EDCCA_RPT_B,
+		.rpt_sel		= R_EDCCA_RPT_SEL,
+		.rpt_sel_mask		= B_EDCCA_RPT_SEL_MSK,
+	}, {
+		.rpt_a			= R_EDCCA_RPT_P1_A,
+		.rpt_b			= R_EDCCA_RPT_P1_B,
+		.rpt_sel		= R_EDCCA_RPT_SEL,
+		.rpt_sel_mask		= B_EDCCA_RPT_SEL_P1_MSK,
+	}},
 	.tx_collision_t2r_st		= R_TX_COLLISION_T2R_ST,
 	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_M,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index bde3e1fb7ca6..6b43f5806ea4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -187,10 +187,17 @@ static const struct rtw89_edcca_regs rtw8852bt_edcca_regs = {
 	.edcca_p_mask			= B_EDCCA_LVL_MSK1,
 	.ppdu_level			= R_SEG0R_EDCCA_LVL_V1,
 	.ppdu_mask			= B_EDCCA_LVL_MSK3,
-	.rpt_a				= R_EDCCA_RPT_A,
-	.rpt_b				= R_EDCCA_RPT_B,
-	.rpt_sel			= R_EDCCA_RPT_SEL,
-	.rpt_sel_mask			= B_EDCCA_RPT_SEL_MSK,
+	.p = {{
+		.rpt_a			= R_EDCCA_RPT_A,
+		.rpt_b			= R_EDCCA_RPT_B,
+		.rpt_sel		= R_EDCCA_RPT_SEL,
+		.rpt_sel_mask		= B_EDCCA_RPT_SEL_MSK,
+	}, {
+		.rpt_a			= R_EDCCA_RPT_P1_A,
+		.rpt_b			= R_EDCCA_RPT_P1_B,
+		.rpt_sel		= R_EDCCA_RPT_SEL,
+		.rpt_sel_mask		= B_EDCCA_RPT_SEL_P1_MSK,
+	}},
 	.tx_collision_t2r_st		= R_TX_COLLISION_T2R_ST,
 	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_M,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index bc84b15e7826..4ff45af704ab 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -186,10 +186,17 @@ static const struct rtw89_edcca_regs rtw8852c_edcca_regs = {
 	.edcca_p_mask			= B_EDCCA_LVL_MSK1,
 	.ppdu_level			= R_SEG0R_EDCCA_LVL,
 	.ppdu_mask			= B_EDCCA_LVL_MSK3,
-	.rpt_a				= R_EDCCA_RPT_A,
-	.rpt_b				= R_EDCCA_RPT_B,
-	.rpt_sel			= R_EDCCA_RPT_SEL,
-	.rpt_sel_mask			= B_EDCCA_RPT_SEL_MSK,
+	.p = {{
+		.rpt_a			= R_EDCCA_RPT_A,
+		.rpt_b			= R_EDCCA_RPT_B,
+		.rpt_sel		= R_EDCCA_RPT_SEL,
+		.rpt_sel_mask		= B_EDCCA_RPT_SEL_MSK,
+	}, {
+		.rpt_a			= R_EDCCA_RPT_P1_A,
+		.rpt_b			= R_EDCCA_RPT_P1_B,
+		.rpt_sel		= R_EDCCA_RPT_SEL,
+		.rpt_sel_mask		= B_EDCCA_RPT_SEL_P1_MSK,
+	}},
 	.tx_collision_t2r_st		= R_TX_COLLISION_T2R_ST,
 	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_M,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 11d66bfceb15..898a65a721dc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -205,10 +205,17 @@ static const struct rtw89_edcca_regs rtw8922a_edcca_regs = {
 	.edcca_p_mask			= B_EDCCA_LVL_MSK1,
 	.ppdu_level			= R_SEG0R_PPDU_LVL_BE,
 	.ppdu_mask			= B_EDCCA_LVL_MSK1,
-	.rpt_a				= R_EDCCA_RPT_A_BE,
-	.rpt_b				= R_EDCCA_RPT_B_BE,
-	.rpt_sel			= R_EDCCA_RPT_SEL_BE,
-	.rpt_sel_mask			= B_EDCCA_RPT_SEL_MSK,
+	.p = {{
+		.rpt_a			= R_EDCCA_RPT_A_BE,
+		.rpt_b			= R_EDCCA_RPT_B_BE,
+		.rpt_sel		= R_EDCCA_RPT_SEL_BE,
+		.rpt_sel_mask		= B_EDCCA_RPT_SEL_MSK,
+	}, {
+		.rpt_a			= R_EDCCA_RPT_P1_A_BE,
+		.rpt_b			= R_EDCCA_RPT_P1_B_BE,
+		.rpt_sel		= R_EDCCA_RPT_SEL_BE,
+		.rpt_sel_mask		= B_EDCCA_RPT_SEL_P1_MSK,
+	}},
 	.rpt_sel_be			= R_EDCCA_RPTREG_SEL_BE,
 	.rpt_sel_be_mask		= B_EDCCA_RPTREG_SEL_BE_MSK,
 	.tx_collision_t2r_st		= R_TX_COLLISION_T2R_ST_BE,
-- 
2.25.1


