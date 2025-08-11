Return-Path: <linux-wireless+bounces-26258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ED2B20905
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 14:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465BD3A9E97
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 12:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39E32D5A16;
	Mon, 11 Aug 2025 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ad+iHxBU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99872D3ECA
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916007; cv=none; b=EG6YZgnPHJb0dud5dwyspaPNMEUINRy5AiQ2817k86b/7FqMN36Qq1pYYJhBSEN9ky2rJNWbsiwIfcZo9ZUSXhezUzMl+s6ZR+C2rZRyR3/69znHylU7VvljKUbLHqI5jNGwdDxDRXDWaSfoKG+4T2qvhAJMbBVBnRVEZIeAtTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916007; c=relaxed/simple;
	bh=wP4kDDxQt44Ev4UIoGmUH5J6q5NvDXh8cPHysHoNPSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKhTnJnqkFSi2wLP20W0mEqVXrBl5Ir45nXSil2BlKGI848ThKVotV2ccCKbflxutEbIvSjwTWXCwQQDL/zTWoPOMj+o/M7x+zT4oc7lmWvYfB3UyL82HM6xZ67Koqq3v1w7Yre98EPrylClvSK1iMZFB/sMUCTZJso7ACvRWFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ad+iHxBU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57BCe3AK1074060, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754916003; bh=rk9DUbCvoc1h3FZVKlY55eyLKjU1AHYa3jac4zIVS+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Ad+iHxBUVFF63hI5ykF7IzA6+4cl5zoahHG8fEItZzqrqjbK957eZFfCgj51yIKMX
	 QL8yASV4EdbeLd7Itcq/qAlSoEeomWukjagW9wjeFLSukZ92HdNY1HwFaKzjgIJjlX
	 xNClBbxPvfMdBbKvEmfRpaV1KTX2z7nw++F8xPNjJj7v3x7Z7UJzIotPIalH9HhkFy
	 PH1obEYuYOkYoxth5nkmnxe/BfRclK8ApH7O51PhP1uqgslQ8aNE37W12Q5Fm5BkUA
	 D2JxlGh/6t9ZmC9e4C4ietlrchrTvdwYNxpvWr8WGxalG53SSxrO0/2wJAp2Kww/7L
	 rM3xJILIyLJCg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57BCe3AK1074060
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 20:40:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 20:40:02 +0800
Received: from [127.0.1.1] (10.22.225.179) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 11 Aug
 2025 20:40:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 5/8] wifi: rtw89: 8851b: rfk: update TX wideband IQK
Date: Mon, 11 Aug 2025 20:39:13 +0800
Message-ID: <20250811123913.15524-1-pkshih@realtek.com>
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

Adjust TX wideband calibration from 1 to 2 loop gain settings.
This can reflect in better performance in 5 GHz medium-high
attenuation environments.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  1 +
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 74 +++++++++++--------
 2 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index de81103a072f..0aad9dc91736 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -9126,6 +9126,7 @@
 #define B_COEF_SEL_MDPD BIT(8)
 #define B_COEF_SEL_MDPD_V1 GENMASK(9, 8)
 #define B_COEF_SEL_EN BIT(31)
+#define R_CFIR_COEF 0x810c
 #define R_CFIR_SYS 0x8120
 #define R_IQK_RES 0x8124
 #define B_IQK_RES_K BIT(28)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index a7867b0e083a..84c46d2f4d85 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -18,7 +18,8 @@
 #define DPK_KSET_NUM 4
 #define RTW8851B_RXK_GROUP_NR 4
 #define RTW8851B_RXK_GROUP_IDX_NR 4
-#define RTW8851B_TXK_GROUP_NR 1
+#define RTW8851B_A_TXK_GROUP_NR 2
+#define RTW8851B_G_TXK_GROUP_NR 1
 #define RTW8851B_IQK_VER 0x14
 #define RTW8851B_IQK_SS 1
 #define RTW8851B_LOK_GRAM 10
@@ -117,16 +118,18 @@ static const u32 g_idxrxagc[RTW8851B_RXK_GROUP_NR] = {0x0, 0x1, 0x2, 0x3};
 static const u32 a_idxrxgain[RTW8851B_RXK_GROUP_IDX_NR] = {0x10C, 0x112, 0x28c, 0x292};
 static const u32 a_idxattc2[RTW8851B_RXK_GROUP_IDX_NR] = {0xf, 0xf, 0xf, 0xf};
 static const u32 a_idxrxagc[RTW8851B_RXK_GROUP_IDX_NR] = {0x4, 0x5, 0x6, 0x7};
-static const u32 a_power_range[RTW8851B_TXK_GROUP_NR] = {0x0};
-static const u32 a_track_range[RTW8851B_TXK_GROUP_NR] = {0x6};
-static const u32 a_gain_bb[RTW8851B_TXK_GROUP_NR] = {0x0a};
-static const u32 a_itqt[RTW8851B_TXK_GROUP_NR] = {0x12};
-static const u32 g_power_range[RTW8851B_TXK_GROUP_NR] = {0x0};
-static const u32 g_track_range[RTW8851B_TXK_GROUP_NR] = {0x6};
-static const u32 g_gain_bb[RTW8851B_TXK_GROUP_NR] = {0x10};
-static const u32 g_itqt[RTW8851B_TXK_GROUP_NR] = {0x12};
-
-static const u32 rtw8851b_backup_bb_regs[] = {0xc0d4, 0xc0d8, 0xc0c4, 0xc0ec, 0xc0e8};
+static const u32 a_power_range[RTW8851B_A_TXK_GROUP_NR] = {0x0, 0x0};
+static const u32 a_track_range[RTW8851B_A_TXK_GROUP_NR] = {0x7, 0x7};
+static const u32 a_gain_bb[RTW8851B_A_TXK_GROUP_NR] = {0x08, 0x0d};
+static const u32 a_itqt[RTW8851B_A_TXK_GROUP_NR] = {0x12, 0x12};
+static const u32 a_att_smxr[RTW8851B_A_TXK_GROUP_NR] = {0x0, 0x2};
+static const u32 g_power_range[RTW8851B_G_TXK_GROUP_NR] = {0x0};
+static const u32 g_track_range[RTW8851B_G_TXK_GROUP_NR] = {0x6};
+static const u32 g_gain_bb[RTW8851B_G_TXK_GROUP_NR] = {0x10};
+static const u32 g_itqt[RTW8851B_G_TXK_GROUP_NR] = {0x12};
+
+static const u32 rtw8851b_backup_bb_regs[] = {
+	0xc0d4, 0xc0d8, 0xc0c4, 0xc0ec, 0xc0e8, 0x12a0, 0xc0f0};
 static const u32 rtw8851b_backup_rf_regs[] = {
 	0xef, 0xde, 0x0, 0x1e, 0x2, 0x85, 0x90, 0x5};
 
@@ -789,7 +792,7 @@ static bool _iqk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 			    "[IQK]============ S%d ID_NBTXK ============\n", path);
 		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_IQK_RFC_ON, 0x0);
 		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT,
-				       0x00b);
+				       0x11);
 		iqk_cmd = 0x408 | (1 << (4 + path));
 		break;
 	case ID_NBRXK:
@@ -807,7 +810,7 @@ static bool _iqk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, iqk_cmd + 1);
 	notready = _iqk_check_cal(rtwdev, path);
 	if (iqk_info->iqk_sram_en &&
-	    (ktype == ID_NBRXK || ktype == ID_RXK))
+	    (ktype == ID_NBRXK || ktype == ID_RXK || ktype == ID_NBTXK))
 		_iqk_sram(rtwdev, path);
 
 	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_IQK_RFC_ON, 0x0);
@@ -1174,6 +1177,7 @@ static void _iqk_rxclk_setting(struct rtw89_dev *rtwdev, u8 path)
 static bool _txk_5g_group_sel(struct rtw89_dev *rtwdev,
 			      enum rtw89_phy_idx phy_idx, u8 path)
 {
+	static const u8 a_idx[RTW8851B_A_TXK_GROUP_NR] = {2, 3};
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	bool kfail = false;
 	bool notready;
@@ -1181,16 +1185,20 @@ static bool _txk_5g_group_sel(struct rtw89_dev *rtwdev,
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
 
-	for (gp = 0x0; gp < RTW8851B_TXK_GROUP_NR; gp++) {
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_COEF, MASKDWORD, 0x33332222);
+
+	for (gp = 0x0; gp < RTW8851B_A_TXK_GROUP_NR; gp++) {
 		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, a_power_range[gp]);
 		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, a_track_range[gp]);
 		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, a_gain_bb[gp]);
+		rtw89_write_rf(rtwdev, path, RR_BIASA, RR_BIASA_A, a_att_smxr[gp]);
 
 		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G2, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_GP, gp);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_GP, a_idx[gp]);
 		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT, 0x11);
 		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP, MASKDWORD, a_itqt[gp]);
 
 		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBTXK);
@@ -1231,7 +1239,9 @@ static bool _txk_2g_group_sel(struct rtw89_dev *rtwdev,
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
 
-	for (gp = 0x0; gp < RTW8851B_TXK_GROUP_NR; gp++) {
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_COEF, MASKDWORD, 0x0);
+
+	for (gp = 0x0; gp < RTW8851B_G_TXK_GROUP_NR; gp++) {
 		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, g_power_range[gp]);
 		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, g_track_range[gp]);
 		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, g_gain_bb[gp]);
@@ -1274,29 +1284,29 @@ static bool _txk_2g_group_sel(struct rtw89_dev *rtwdev,
 static bool _iqk_5g_nbtxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 			  u8 path)
 {
+	static const u8 a_idx[RTW8851B_A_TXK_GROUP_NR] = {2, 3};
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	bool kfail = false;
 	bool notready;
-	u8 gp;
+	u8 gp = 0;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
 
-	for (gp = 0x0; gp < RTW8851B_TXK_GROUP_NR; gp++) {
-		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, a_power_range[gp]);
-		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, a_track_range[gp]);
-		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, a_gain_bb[gp]);
+	rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, a_power_range[gp]);
+	rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, a_track_range[gp]);
+	rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, a_gain_bb[gp]);
+	rtw89_write_rf(rtwdev, path, RR_BIASA, RR_BIASA_A, a_att_smxr[gp]);
 
-		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G2, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_GP, gp);
-		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
-		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP, MASKDWORD, a_itqt[gp]);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G2, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_GP, a_idx[gp]);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP, MASKDWORD, a_itqt[gp]);
 
-		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBTXK);
-		iqk_info->nb_txcfir[path] =
-			rtw89_phy_read32_mask(rtwdev, R_TXIQC, MASKDWORD)  | 0x2;
-	}
+	notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBTXK);
+	iqk_info->nb_txcfir[path] =
+		rtw89_phy_read32_mask(rtwdev, R_TXIQC, MASKDWORD)  | 0x2;
 
 	if (!notready)
 		kfail = !!rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, B_NCTL_RPT_FLG);
@@ -1325,7 +1335,7 @@ static bool _iqk_2g_nbtxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
 
-	for (gp = 0x0; gp < RTW8851B_TXK_GROUP_NR; gp++) {
+	for (gp = 0x0; gp < RTW8851B_G_TXK_GROUP_NR; gp++) {
 		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, g_power_range[gp]);
 		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, g_track_range[gp]);
 		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, g_gain_bb[gp]);
-- 
2.25.1


