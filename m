Return-Path: <linux-wireless+bounces-26257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C710B208FC
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 14:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525F23B2635
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 12:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9052D9ED6;
	Mon, 11 Aug 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wWmcQwro"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD052D9784
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915938; cv=none; b=Q6xmEVvj+IbJVV1Kpw6qkLWnffv5X4aQsnMYjT3Mf88O3Pgp4iIfGOUhvtqJ5bGU2lBCV1KHpZrFtl/UQp4RX5m1d7QR48RDnQ5U7gmpITBuOnTAJs4GeYFMevbnzvoq+gtpulpu0c/X/3Zi1WlzEGqRmPavl0bkoC4Y/T2/yIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915938; c=relaxed/simple;
	bh=7RS15YKsbCaThAxqjTlx8lY8GAA1tA/ExuvO/LwYsh4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AW4D7HcYtaTWppC+UnMYh3Iv9sRlawQ8FirvpnEHEe366rmc/VhY//9ENGfY2VzA7sBqHy9fMZZSEqUF1Q/dTbJ30KPUMPJNFxY7CpvMk0DTl/ksXOzLW0483+KjVj9RPZp5EHhnXoo29o3aeCfqsEG1rf9e/T+mQ9a/NasI7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wWmcQwro; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57BCcrnW7073207, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754915933; bh=Iqs4H3MZaJ6m2BNl1gZxHnv/w31ibtAH76JAJJtiluM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wWmcQwro8EAQTp4p/5rJQDihPWEtY63qyc3UCw9fR+IxsqhY1c0tBOBUokTOZ970P
	 /WO8gMiqKYjtul8gesjbFZlsEDyNGigBcDuD7blYJyB5jAqVEd4+4sxcEcvUpEfBue
	 N57a49r40Vb18SQ94tByzd+iusJK6k9TT4RpbkMKBA4B1YbmpuEQdQT4BG8x12R/dU
	 UwKPfIosDw44xzhro891qSODPbbigGxiBUtqFttkDX6rcvIWUCzRBY0da2D97hgy8W
	 EIFSW1XbVf3puAGmBqZp1j/yIJVuCsmVyqh0FWjKS783Aq11NldhKvR1kBuG9xG49I
	 xnZARkzxhyzZw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57BCcrnW7073207
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 20:38:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 20:38:54 +0800
Received: from [127.0.1.1] (10.22.225.179) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 11 Aug
 2025 20:38:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 4/8] wifi: rtw89: 8851b: rfk: update IQK TIA setting
Date: Mon, 11 Aug 2025 20:37:40 +0800
Message-ID: <20250811123744.15361-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811123744.15361-1-pkshih@realtek.com>
References: <20250811123744.15361-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

From: Kuan-Chung Chen <damon.chen@realtek.com>

With the new TIA setting of RX IQK, unstable RX throughput can
be avoided, especially in medium-high attenuation environments.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 85 ++++++++++++-------
 1 file changed, 54 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index 7a319a6c838a..a7867b0e083a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -17,7 +17,7 @@
 #define DPK_RF_REG_NUM_8851B 4
 #define DPK_KSET_NUM 4
 #define RTW8851B_RXK_GROUP_NR 4
-#define RTW8851B_RXK_GROUP_IDX_NR 2
+#define RTW8851B_RXK_GROUP_IDX_NR 4
 #define RTW8851B_TXK_GROUP_NR 1
 #define RTW8851B_IQK_VER 0x14
 #define RTW8851B_IQK_SS 1
@@ -114,9 +114,9 @@ static const u32 _tssi_de_mcs_10m[RF_PATH_NUM_8851B] = {0x5830};
 static const u32 g_idxrxgain[RTW8851B_RXK_GROUP_NR] = {0x10e, 0x116, 0x28e, 0x296};
 static const u32 g_idxattc2[RTW8851B_RXK_GROUP_NR] = {0x0, 0xf, 0x0, 0xf};
 static const u32 g_idxrxagc[RTW8851B_RXK_GROUP_NR] = {0x0, 0x1, 0x2, 0x3};
-static const u32 a_idxrxgain[RTW8851B_RXK_GROUP_IDX_NR] = {0x10C, 0x28c};
-static const u32 a_idxattc2[RTW8851B_RXK_GROUP_IDX_NR] = {0xf, 0xf};
-static const u32 a_idxrxagc[RTW8851B_RXK_GROUP_IDX_NR] = {0x4, 0x6};
+static const u32 a_idxrxgain[RTW8851B_RXK_GROUP_IDX_NR] = {0x10C, 0x112, 0x28c, 0x292};
+static const u32 a_idxattc2[RTW8851B_RXK_GROUP_IDX_NR] = {0xf, 0xf, 0xf, 0xf};
+static const u32 a_idxrxagc[RTW8851B_RXK_GROUP_IDX_NR] = {0x4, 0x5, 0x6, 0x7};
 static const u32 a_power_range[RTW8851B_TXK_GROUP_NR] = {0x0};
 static const u32 a_track_range[RTW8851B_TXK_GROUP_NR] = {0x6};
 static const u32 a_gain_bb[RTW8851B_TXK_GROUP_NR] = {0x0a};
@@ -139,17 +139,6 @@ static const u32 dpk_rf_reg[DPK_RF_REG_NUM_8851B] = {0xde, 0x8f, 0x5, 0x10005};
 
 static void _set_ch(struct rtw89_dev *rtwdev, u32 val);
 
-static u8 _rxk_5ghz_group_from_idx(u8 idx)
-{
-	/* There are four RXK groups (RTW8851B_RXK_GROUP_NR), but only group 0
-	 * and 2 are used in 5 GHz band, so reduce elements to 2.
-	 */
-	if (idx < RTW8851B_RXK_GROUP_IDX_NR)
-		return idx * 2;
-
-	return 0;
-}
-
 static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	return RF_A;
@@ -196,7 +185,7 @@ static void _txck_force(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
 static void _rxck_force(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
 			bool force, enum adc_ck ck)
 {
-	static const u32 ck960_8851b[] = {0x8, 0x2, 0x2, 0x4, 0xf, 0xa, 0x93};
+	static const u32 ck960_8851b[] = {0x8, 0x2, 0x2, 0x4, 0xf, 0xa, 0x92};
 	static const u32 ck1920_8851b[] = {0x9, 0x0, 0x0, 0x3, 0xf, 0xa, 0x49};
 	const u32 *data;
 
@@ -905,18 +894,27 @@ static bool _rxk_5g_group_sel(struct rtw89_dev *rtwdev,
 	bool kfail = false;
 	bool notready;
 	u32 rf_0;
-	u8 idx;
+	u32 val;
 	u8 gp;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
 
-	for (idx = 0; idx < RTW8851B_RXK_GROUP_IDX_NR; idx++) {
-		gp = _rxk_5ghz_group_from_idx(idx);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x1000);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x4);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x17);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x5);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x27);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x0);
 
+	val = rtw89_read_rf(rtwdev, RF_PATH_A, RR_RXA2, 0x20);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_MASK, 0xc);
+
+	for (gp = 0; gp < RTW8851B_RXK_GROUP_IDX_NR; gp++) {
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, gp = %x\n", path, gp);
 
-		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_RGM, a_idxrxgain[idx]);
-		rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, RR_RXA2_ATT, a_idxattc2[idx]);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_RGM, a_idxrxgain[gp]);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, RR_RXA2_ATT, a_idxattc2[gp]);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, 0x20, 0x1);
 
 		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x0);
@@ -926,7 +924,7 @@ static bool _rxk_5g_group_sel(struct rtw89_dev *rtwdev,
 		fsleep(100);
 		rf_0 = rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK);
 		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF2, B_IQK_DIF2_RXPI, rf_0);
-		rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, a_idxrxagc[idx]);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, a_idxrxagc[gp]);
 		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x11);
 		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXAGC);
 
@@ -959,6 +957,7 @@ static bool _rxk_5g_group_sel(struct rtw89_dev *rtwdev,
 		_iqk_sram(rtwdev, path);
 
 	if (kfail) {
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RES, B_IQK_RES_RXCFIR, 0x0);
 		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8), MASKDWORD,
 				       iqk_info->nb_rxcfir[path] | 0x2);
 		iqk_info->is_wb_txiqk[path] = false;
@@ -968,6 +967,14 @@ static bool _rxk_5g_group_sel(struct rtw89_dev *rtwdev,
 		iqk_info->is_wb_txiqk[path] = true;
 	}
 
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, 0x20, val);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x1000);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x4);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x37);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x5);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x27);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x0);
+
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[IQK]S%x, kfail = 0x%x, 0x8%x3c = 0x%x\n", path, kfail,
 		    1 << path, iqk_info->nb_rxcfir[path]);
@@ -980,17 +987,26 @@ static bool _iqk_5g_nbrxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	bool kfail = false;
 	bool notready;
-	u8 idx = 0x1;
+	u8 gp = 2;
 	u32 rf_0;
-	u8 gp;
-
-	gp = _rxk_5ghz_group_from_idx(idx);
+	u32 val;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, gp = %x\n", path, gp);
 
-	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_RGM, a_idxrxgain[idx]);
-	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, RR_RXA2_ATT, a_idxattc2[idx]);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x1000);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x4);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x17);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x5);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x27);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x0);
+
+	val = rtw89_read_rf(rtwdev, RF_PATH_A, RR_RXA2, 0x20);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_MASK, 0xc);
+
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_RGM, a_idxrxgain[gp]);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, RR_RXA2_ATT, a_idxattc2[gp]);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, 0x20, 0x1);
 
 	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
 	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x0);
@@ -1000,7 +1016,7 @@ static bool _iqk_5g_nbrxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	fsleep(100);
 	rf_0 = rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK);
 	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF2, B_IQK_DIF2_RXPI, rf_0);
-	rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, a_idxrxagc[idx]);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, a_idxrxagc[gp]);
 	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x11);
 	notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXAGC);
 
@@ -1026,6 +1042,7 @@ static bool _iqk_5g_nbrxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 		kfail = !!rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, B_NCTL_RPT_FLG);
 
 	if (kfail) {
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RES + (path << 8), 0xf, 0x0);
 		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8),
 				       MASKDWORD, 0x40000002);
 		iqk_info->is_wb_rxiqk[path] = false;
@@ -1033,6 +1050,14 @@ static bool _iqk_5g_nbrxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 		iqk_info->is_wb_rxiqk[path] = false;
 	}
 
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, 0x20, val);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x1000);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x4);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x37);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x5);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x27);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x0);
+
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[IQK]S%x, kfail = 0x%x, 0x8%x3c = 0x%x\n", path, kfail,
 		    1 << path, iqk_info->nb_rxcfir[path]);
@@ -1664,8 +1689,6 @@ static void _iqk_init(struct rtw89_dev *rtwdev)
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u8 idx, path;
 
-	rtw89_phy_write32_mask(rtwdev, R_IQKINF, MASKDWORD, 0x0);
-
 	if (iqk_info->is_iqk_init)
 		return;
 
-- 
2.25.1


