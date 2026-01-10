Return-Path: <linux-wireless+bounces-30621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8059DD0CD1C
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 03:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7705630139BC
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 02:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3858719F40B;
	Sat, 10 Jan 2026 02:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Pqe/kvy3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84BF2A1CF
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011661; cv=none; b=r0GbHkSZc3c7ndDk+4oMs4oTGYoSGc5K+vmEtom6J9VLO20D4K082J4yrfyKNiGPpE4jxacxjuX/QUIOeKmBLS53ZjoXSHpqcBL/UNJHWkSK9fYyiBjkawTfpgirrXkrXPxTfyaRJxjYhv17EF5OwanImQcZ7LIWZOj5kG2VgaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011661; c=relaxed/simple;
	bh=I9P7H6DSCXaNAytzMEcEr1MDnjuGdjTVlcv1IC418vQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZdggdmD48ghAmk8n9HrmRtNgpDzOyC1x3y6uHnleE06DUGoDS4+sQgPAlp97MnApLgqZciP44c2wMhHHc6E1SjPXcac/g68pnMIySeMw9U6/+8gXmgG+ltgtIZV7ThZ60eQ0uu42qDH1wchuzXgJ0/f5kZpb9wu6T2Dhv+0z6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Pqe/kvy3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60A2Ku9bA241749, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768011656; bh=iKBwRuvUV7T+891H8aTG5ZJ8mAEjP6PIjInUFSbS7FU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Pqe/kvy3ZKxcgQkPg+t8D9RI06TebPlLzWVA4he2uSd0l4bEoyGQND8f/ChEMcEWc
	 /cD47/O9ZENC++HxkxD/hYDpLshHZ/ALvQ4N+SN9dtXnBcM7IxpIqKt7YHTACbXnAv
	 vbiI7m86QduvOTogSJSD9Ju6QWnFQOYYTb1tw3q0sTUA8OySnQI4XyFHwe2WX3duLH
	 344AzmyOadKFCaJFI8dobIb5nxOkJRg5D8R003s81jXOl7gBjGW9PEvplSm6yf5Xpy
	 y3nawMWEqnAN2zb99PxUR2bOVPGvVBGT0Rph4mMlUiBVb36Ce8cKvvZsnlCvA4C/8g
	 evXtZyxKX74Ug==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60A2Ku9bA241749
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 10:20:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 10 Jan 2026 10:20:56 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 10 Jan 2026 10:20:56 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 10 Jan 2026 10:20:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 7/8] wifi: rtw89: mac: consider RTL8922D in MAC common flow
Date: Sat, 10 Jan 2026 10:20:18 +0800
Message-ID: <20260110022019.2254969-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260110022019.2254969-1-pkshih@realtek.com>
References: <20260110022019.2254969-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The MAC settings are different from RTL8922A to RTL8922D, including
scheduler, DLE, DCPU, MLO, NAV, TMAC, TX/RX protocol, RMAC, IMR, host RPT,
AMSDU. Update them accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 180 ++++++++++++++--
 drivers/net/wireless/realtek/rtw89/reg.h    | 217 ++++++++++++++++++++
 2 files changed, 376 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index aaa7a7f5354d..fbd2eed54939 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -200,6 +200,9 @@ static void dle_func_en_be(struct rtw89_dev *rtwdev, bool enable)
 
 static void dle_clk_en_be(struct rtw89_dev *rtwdev, bool enable)
 {
+	if (rtwdev->chip->chip_id != RTL8922A)
+		return;
+
 	if (enable)
 		rtw89_write32_set(rtwdev, R_BE_DMAC_CLK_EN,
 				  B_BE_DLE_WDE_CLK_EN | B_BE_DLE_PLE_CLK_EN);
@@ -579,7 +582,8 @@ static void rtw89_mac_disable_cpu_be(struct rtw89_dev *rtwdev)
 	val32 &= B_BE_RUN_ENV_MASK;
 	rtw89_write32(rtwdev, R_BE_WCPU_FW_CTRL, val32);
 
-	rtw89_write32_set(rtwdev, R_BE_DCPU_PLATFORM_ENABLE, B_BE_DCPU_PLATFORM_EN);
+	if (rtwdev->chip->chip_id == RTL8922A)
+		rtw89_write32_set(rtwdev, R_BE_DCPU_PLATFORM_ENABLE, B_BE_DCPU_PLATFORM_EN);
 
 	rtw89_write32(rtwdev, R_BE_UDM0, 0);
 	rtw89_write32(rtwdev, R_BE_HALT_C2H, 0);
@@ -796,6 +800,11 @@ static int sta_sch_init_be(struct rtw89_dev *rtwdev)
 	u32 p_val;
 	int ret;
 
+	if (rtwdev->chip->chip_id == RTL8922D) {
+		rtw89_write32_set(rtwdev, R_BE_SS_LITE_TXL_MACID, B_BE_RPT_OTHER_BAND_EN);
+		return 0;
+	}
+
 	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
 	if (ret)
 		return ret;
@@ -825,14 +834,16 @@ static int mpdu_proc_init_be(struct rtw89_dev *rtwdev)
 		return ret;
 
 	rtw89_write32_set(rtwdev, R_BE_MPDU_PROC, B_BE_APPEND_FCS);
-	rtw89_write32(rtwdev, R_BE_CUT_AMSDU_CTRL, TRXCFG_MPDU_PROC_CUT_CTRL);
+	rtw89_write32(rtwdev, R_BE_CUT_AMSDU_CTRL, TRXCFG_MPDU_PROC_CUT_CTRL |
+						   B_BE_CA_CHK_ADDRCAM_EN);
 
 	val32 = rtw89_read32(rtwdev, R_BE_HDR_SHCUT_SETTING);
 	val32 |= (B_BE_TX_HW_SEQ_EN | B_BE_TX_HW_ACK_POLICY_EN | B_BE_TX_MAC_MPDU_PROC_EN);
 	val32 &= ~B_BE_TX_ADDR_MLD_TO_LIK;
 	rtw89_write32_set(rtwdev, R_BE_HDR_SHCUT_SETTING, val32);
 
-	rtw89_write32(rtwdev, R_BE_RX_HDRTRNS, TRXCFG_MPDU_PROC_RX_HDR_CONV);
+	rtw89_write32(rtwdev, R_BE_RX_HDRTRNS, TRXCFG_MPDU_PROC_RX_HDR_CONV |
+					       B_BE_HC_ADDR_HIT_EN);
 
 	val32 = rtw89_read32(rtwdev, R_BE_DISP_FWD_WLAN_0);
 	val32 = u32_replace_bits(val32, 1, B_BE_FWD_WLAN_CPU_TYPE_0_DATA_MASK);
@@ -890,7 +901,9 @@ static int txpktctrl_init_be(struct rtw89_dev *rtwdev)
 
 static int mlo_init_be(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 val32;
+	u32 reg;
 	int ret;
 
 	val32 = rtw89_read32(rtwdev, R_BE_MLO_INIT_CTL);
@@ -906,7 +919,12 @@ static int mlo_init_be(struct rtw89_dev *rtwdev)
 	if (ret)
 		rtw89_err(rtwdev, "[MLO]%s: MLO init polling timeout\n", __func__);
 
-	rtw89_write32_set(rtwdev, R_BE_SS_CTRL, B_BE_MLO_HW_CHGLINK_EN);
+	if (chip->chip_id == RTL8922A)
+		reg = R_BE_SS_CTRL;
+	else
+		reg = R_BE_SS_CTRL_V1;
+
+	rtw89_write32_set(rtwdev, reg, B_BE_MLO_HW_CHGLINK_EN);
 	rtw89_write32_set(rtwdev, R_BE_CMAC_SHARE_ACQCHK_CFG_0, B_BE_R_MACID_ACQ_CHK_EN);
 
 	return ret;
@@ -969,6 +987,7 @@ static int dmac_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 
 static int scheduler_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 val32;
 	u32 reg;
 	int ret;
@@ -977,6 +996,11 @@ static int scheduler_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
+	if (chip->chip_id == RTL8922D) {
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_SCH_EXT_CTRL, mac_idx);
+		rtw89_write32_set(rtwdev, reg, B_BE_CWCNT_PLUS_MODE);
+	}
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_HE_CTN_CHK_CCA_NAV, mac_idx);
 	val32 = B_BE_HE_CTN_CHK_CCA_P20 | B_BE_HE_CTN_CHK_EDCCA_P20 |
 		B_BE_HE_CTN_CHK_CCA_BITMAP | B_BE_HE_CTN_CHK_EDCCA_BITMAP |
@@ -1010,6 +1034,11 @@ static int scheduler_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	rtw89_write32_mask(rtwdev, reg, B_BE_BCNQ_CW_MASK, 0x32);
 	rtw89_write32_mask(rtwdev, reg, B_BE_BCNQ_AIFS_MASK, BCN_IFS_25US);
 
+	if (chip->chip_id == RTL8922D) {
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_SCH_EDCA_RST_CFG, mac_idx);
+		rtw89_write32_set(rtwdev, reg, B_BE_TX_NAV_RST_EDCA_EN);
+	}
+
 	return 0;
 }
 
@@ -1125,6 +1154,9 @@ static int nav_ctrl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 
 	rtw89_write32(rtwdev, reg, val32);
 
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_SPECIAL_TX_SETTING, mac_idx);
+	rtw89_write32_clr(rtwdev, reg, B_BE_BMC_NAV_PROTECT);
+
 	return 0;
 }
 
@@ -1148,14 +1180,22 @@ static int spatial_reuse_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 
 static int tmac_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 reg;
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TB_PPDU_CTRL, mac_idx);
 	rtw89_write32_clr(rtwdev, reg, B_BE_QOSNULL_UPD_MUEDCA_EN);
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_WMTX_TCR_BE_4, mac_idx);
-	rtw89_write32_mask(rtwdev, reg, B_BE_EHT_HE_PPDU_4XLTF_ZLD_USTIMER_MASK, 0x12);
-	rtw89_write32_mask(rtwdev, reg, B_BE_EHT_HE_PPDU_2XLTF_ZLD_USTIMER_MASK, 0xe);
+	if (chip->chip_id == RTL8922A) {
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_WMTX_TCR_BE_4, mac_idx);
+		rtw89_write32_mask(rtwdev, reg, B_BE_EHT_HE_PPDU_4XLTF_ZLD_USTIMER_MASK, 0x12);
+		rtw89_write32_mask(rtwdev, reg, B_BE_EHT_HE_PPDU_2XLTF_ZLD_USTIMER_MASK, 0xe);
+	}
+
+	if (chip->chip_id == RTL8922D) {
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_COMMON_PHYINTF_CTRL_0, mac_idx);
+		rtw89_write32_clr(rtwdev, reg, CLEAR_DTOP_DIS);
+	}
 
 	return 0;
 }
@@ -1180,6 +1220,15 @@ static int trxptcl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	val32 &= ~B_BE_MACLBK_EN;
 	rtw89_write32(rtwdev, reg, val32);
 
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_CMAC_FUNC_EN, mac_idx);
+	rtw89_write32_set(rtwdev, reg, B_BE_PHYINTF_EN);
+
+	if (chip->chip_id == RTL8922D) {
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RX_PLCP_EXT_OPTION_2, mac_idx);
+		rtw89_write32_set(rtwdev, reg, B_BE_PLCP_PHASE_B_CRC_CHK_EN |
+					       B_BE_PLCP_PHASE_A_CRC_CHK_EN);
+	}
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TRXPTCL_RESP_0, mac_idx);
 	val32 = rtw89_read32(rtwdev, reg);
 	val32 = u32_replace_bits(val32, WMAC_SPEC_SIFS_CCK,
@@ -1249,6 +1298,7 @@ static int rst_bacam_be(struct rtw89_dev *rtwdev)
 
 static int rmac_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 rx_min_qta, rx_max_len, rx_max_pg;
 	u16 val16;
 	u32 reg;
@@ -1292,6 +1342,17 @@ static int rmac_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RX_PLCP_EXT_OPTION_1, mac_idx);
 	rtw89_write16_set(rtwdev, reg, B_BE_PLCP_SU_PSDU_LEN_SRC);
 
+	if (chip->chip_id == RTL8922D) {
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_BSR_UPD_CTRL, mac_idx);
+		rtw89_write32_set(rtwdev, reg, B_BE_QSIZE_RULE);
+
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RXGCK_CTRL, mac_idx);
+		rtw89_write16_mask(rtwdev, reg, B_BE_RXGCK_GCK_RATE_LIMIT_MASK, RX_GCK_LEGACY);
+
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_PLCP_HDR_FLTR, mac_idx);
+		rtw89_write32_set(rtwdev, reg, B_BE_DIS_CHK_MIN_LEN);
+	}
+
 	return 0;
 }
 
@@ -1350,6 +1411,7 @@ static int cmac_com_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 
 static int ptcl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 val32;
 	u8 val8;
 	u32 reg;
@@ -1364,8 +1426,9 @@ static int ptcl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 		val32 = rtw89_read32(rtwdev, reg);
 		val32 = u32_replace_bits(val32, S_AX_CTS2S_TH_1K,
 					 B_BE_HW_CTS2SELF_PKT_LEN_TH_MASK);
-		val32 = u32_replace_bits(val32, S_AX_CTS2S_TH_SEC_256B,
-					 B_BE_HW_CTS2SELF_PKT_LEN_TH_TWW_MASK);
+		if (chip->chip_id == RTL8922A)
+			val32 = u32_replace_bits(val32, S_AX_CTS2S_TH_SEC_256B,
+						 B_BE_HW_CTS2SELF_PKT_LEN_TH_TWW_MASK);
 		val32 |= B_BE_HW_CTS2SELF_EN;
 		rtw89_write32(rtwdev, reg, val32);
 
@@ -1386,7 +1449,46 @@ static int ptcl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	rtw89_write8(rtwdev, reg, val8);
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_AMPDU_AGG_LIMIT, mac_idx);
-	rtw89_write32_mask(rtwdev, reg, B_BE_AMPDU_MAX_TIME_MASK, AMPDU_MAX_TIME);
+	if (chip->chip_id == RTL8922A)
+		val32 = AMPDU_MAX_TIME;
+	else
+		val32 = AMPDU_MAX_TIME_V1;
+	rtw89_write32_mask(rtwdev, reg, B_BE_AMPDU_MAX_TIME_MASK, val32);
+
+	if (chip->chip_id == RTL8922D) {
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_AGG_BK_0, mac_idx);
+		rtw89_write32_clr(rtwdev, reg, B_BE_WDBK_CFG | B_BE_EN_RTY_BK |
+					       B_BE_EN_RTY_BK_COD);
+
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_AMPDU_AGG_LIMIT, mac_idx);
+		rtw89_write32_mask(rtwdev, reg, B_BE_MAX_AGG_NUM_MASK,
+				   MAX_TX_AMPDU_NUM_V1 - 1);
+	}
+
+	if (rtw89_mac_chk_preload_allow(rtwdev)) {
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_AGG_BK_0, mac_idx);
+		rtw89_write32_set(rtwdev, reg, B_BE_PRELD_MGQ0_EN |
+					       B_BE_PRELD_HIQ_P4_EN |
+					       B_BE_PRELD_HIQ_P3_EN |
+					       B_BE_PRELD_HIQ_P2_EN |
+					       B_BE_PRELD_HIQ_P1_EN |
+					       B_BE_PRELD_HIQ_P0MB15_EN |
+					       B_BE_PRELD_HIQ_P0MB14_EN |
+					       B_BE_PRELD_HIQ_P0MB13_EN |
+					       B_BE_PRELD_HIQ_P0MB12_EN |
+					       B_BE_PRELD_HIQ_P0MB11_EN |
+					       B_BE_PRELD_HIQ_P0MB10_EN |
+					       B_BE_PRELD_HIQ_P0MB9_EN |
+					       B_BE_PRELD_HIQ_P0MB8_EN |
+					       B_BE_PRELD_HIQ_P0MB7_EN |
+					       B_BE_PRELD_HIQ_P0MB6_EN |
+					       B_BE_PRELD_HIQ_P0MB5_EN |
+					       B_BE_PRELD_HIQ_P0MB4_EN |
+					       B_BE_PRELD_HIQ_P0MB3_EN |
+					       B_BE_PRELD_HIQ_P0MB2_EN |
+					       B_BE_PRELD_HIQ_P0MB1_EN |
+					       B_BE_PRELD_HIQ_P0_EN);
+	}
 
 	return 0;
 }
@@ -1673,22 +1775,22 @@ static int dle_quota_change_be(struct rtw89_dev *rtwdev, bool band1_en)
 static int preload_init_be(struct rtw89_dev *rtwdev, u8 mac_idx,
 			   enum rtw89_qta_mode mode)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 max_preld_size, min_rsvd_size;
+	u8 preld_acq, preld_miscq;
 	u32 val32;
 	u32 reg;
 
+	if (!(chip->chip_id == RTL8922A || rtw89_mac_chk_preload_allow(rtwdev)))
+		return 0;
+
 	max_preld_size = mac_idx == RTW89_MAC_0 ?
 			 PRELD_B0_ENT_NUM : PRELD_B1_ENT_NUM;
+	if (chip->chip_id == RTL8922D)
+		max_preld_size = PRELD_B01_ENT_NUM_8922D;
 	max_preld_size *= PRELD_AMSDU_SIZE;
+	min_rsvd_size = PRELD_NEXT_MIN_SIZE;
 
-	reg = mac_idx == RTW89_MAC_0 ? R_BE_TXPKTCTL_B0_PRELD_CFG0 :
-				       R_BE_TXPKTCTL_B1_PRELD_CFG0;
-	val32 = rtw89_read32(rtwdev, reg);
-	val32 = u32_replace_bits(val32, max_preld_size, B_BE_B0_PRELD_USEMAXSZ_MASK);
-	val32 |= B_BE_B0_PRELD_FEN;
-	rtw89_write32(rtwdev, reg, val32);
-
-	min_rsvd_size = PRELD_AMSDU_SIZE;
 	reg = mac_idx == RTW89_MAC_0 ? R_BE_TXPKTCTL_B0_PRELD_CFG1 :
 				       R_BE_TXPKTCTL_B1_PRELD_CFG1;
 	val32 = rtw89_read32(rtwdev, reg);
@@ -1696,6 +1798,24 @@ static int preload_init_be(struct rtw89_dev *rtwdev, u8 mac_idx,
 	val32 = u32_replace_bits(val32, min_rsvd_size, B_BE_B0_PRELD_NXT_RSVMINSZ_MASK);
 	rtw89_write32(rtwdev, reg, val32);
 
+	reg = mac_idx == RTW89_MAC_0 ? R_BE_TXPKTCTL_B0_PRELD_CFG0 :
+				       R_BE_TXPKTCTL_B1_PRELD_CFG0;
+	if (chip->chip_id == RTL8922D) {
+		preld_acq = PRELD_ACQ_ENT_NUM_8922D;
+		preld_miscq = PRELD_MISCQ_ENT_NUM_8922D;
+	} else {
+		preld_acq = mac_idx == RTW89_MAC_0 ? PRELD_B0_ACQ_ENT_NUM_8922A :
+						     PRELD_B1_ACQ_ENT_NUM_8922A;
+		preld_miscq = PRELD_MISCQ_ENT_NUM_8922A;
+	}
+
+	val32 = rtw89_read32(rtwdev, reg);
+	val32 = u32_replace_bits(val32, preld_acq, B_BE_B0_PRELD_CAM_G0ENTNUM_MASK);
+	val32 = u32_replace_bits(val32, preld_miscq, B_BE_B0_PRELD_CAM_G1ENTNUM_MASK);
+	val32 = u32_replace_bits(val32, max_preld_size, B_BE_B0_PRELD_USEMAXSZ_MASK);
+	val32 |= B_BE_B0_PRELD_FEN;
+	rtw89_write32(rtwdev, reg, val32);
+
 	return 0;
 }
 
@@ -1728,6 +1848,10 @@ static int enable_imr_be(struct rtw89_dev *rtwdev, u8 mac_idx,
 	else
 		return -EINVAL;
 
+	if (chip->chip_id == RTL8922D)
+		rtw89_write32_mask(rtwdev, R_BE_NO_RX_ERR_CFG,
+				   B_BE_NO_RX_ERR_TO_MASK, 0);
+
 	for (i = 0; i < table->n_regs; i++) {
 		reg = &table->regs[i];
 		addr = rtw89_mac_reg_by_idx(rtwdev, reg->addr, mac_idx);
@@ -1871,26 +1995,40 @@ static int dbcc_enable_be(struct rtw89_dev *rtwdev, bool enable)
 
 static int set_host_rpr_be(struct rtw89_dev *rtwdev)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 val32;
 	u32 mode;
 	u32 fltr;
+	u32 qid;
 	bool poh;
 
 	poh = is_qta_poh(rtwdev);
 
 	if (poh) {
 		mode = RTW89_RPR_MODE_POH;
-		fltr = S_BE_WDRLS_FLTR_TXOK | S_BE_WDRLS_FLTR_RTYLMT |
-		       S_BE_WDRLS_FLTR_LIFTIM | S_BE_WDRLS_FLTR_MACID;
+		qid = WDRLS_DEST_QID_POH;
 	} else {
 		mode = RTW89_RPR_MODE_STF;
 		fltr = 0;
+		qid = WDRLS_DEST_QID_STF;
+	}
+
+	if (chip_id == RTL8922A) {
+		fltr = S_BE_WDRLS_FLTR_TXOK | S_BE_WDRLS_FLTR_RTYLMT |
+		       S_BE_WDRLS_FLTR_LIFTIM | S_BE_WDRLS_FLTR_MACID;
+	} else {
+		fltr = S_BE_WDRLS_FLTR_TXOK_V1 | S_BE_WDRLS_FLTR_RTYLMT_V1 |
+		       S_BE_WDRLS_FLTR_LIFTIM_V1 | S_BE_WDRLS_FLTR_MACID_V1;
 	}
 
 	rtw89_write32_mask(rtwdev, R_BE_WDRLS_CFG, B_BE_WDRLS_MODE_MASK, mode);
+	rtw89_write32_mask(rtwdev, R_BE_RLSRPT0_CFG0, B_BE_RLSRPT0_QID_MASK, qid);
 
 	val32 = rtw89_read32(rtwdev, R_BE_RLSRPT0_CFG1);
-	val32 = u32_replace_bits(val32, fltr, B_BE_RLSRPT0_FLTR_MAP_MASK);
+	if (chip_id == RTL8922A)
+		val32 = u32_replace_bits(val32, fltr, B_BE_RLSRPT0_FLTR_MAP_MASK);
+	else
+		val32 = u32_replace_bits(val32, fltr, B_BE_RLSRPT0_FLTR_MAP_V1_MASK);
 	val32 = u32_replace_bits(val32, 30, B_BE_RLSRPT0_AGGNUM_MASK);
 	val32 = u32_replace_bits(val32, 255, B_BE_RLSRPT0_TO_MASK);
 	rtw89_write32(rtwdev, R_BE_RLSRPT0_CFG1, val32);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 9f963bd85f02..2fe44fb86ad6 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -1967,7 +1967,9 @@
 #define B_AX_B0_PRELD_FEN BIT(31)
 #define B_AX_B0_PRELD_USEMAXSZ_MASK GENMASK(25, 16)
 #define PRELD_B0_ENT_NUM 10
+#define PRELD_B01_ENT_NUM_8922D 2
 #define PRELD_AMSDU_SIZE 52
+#define PRELD_NEXT_MIN_SIZE 255
 #define B_AX_B0_PRELD_CAM_G1ENTNUM_MASK GENMASK(12, 8)
 #define B_AX_B0_PRELD_CAM_G0ENTNUM_MASK GENMASK(4, 0)
 
@@ -4638,6 +4640,10 @@
 #define R_BE_LTR_LATENCY_IDX2_V1 0x361C
 #define R_BE_LTR_LATENCY_IDX3_V1 0x3620
 
+#define R_BE_HCI_BUF_IMR 0x6018
+#define B_BE_HCI_BUF_IMR_CLR 0xC0000303
+#define B_BE_HCI_BUF_IMR_SET 0xC0000301
+
 #define R_BE_H2CREG_DATA0 0x7140
 #define R_BE_H2CREG_DATA1 0x7144
 #define R_BE_H2CREG_DATA2 0x7148
@@ -4732,6 +4738,9 @@
 #define B_BE_LTR_CMAC1_RX_USE_PG_TH_MASK GENMASK(27, 16)
 #define B_BE_LTR_CMAC0_RX_USE_PG_TH_MASK GENMASK(11, 0)
 
+#define R_BE_NO_RX_ERR_CFG 0x841C
+#define B_BE_NO_RX_ERR_TO_MASK GENMASK(31, 29)
+
 #define R_BE_DMAC_TABLE_CTRL 0x8420
 #define B_BE_HWAMSDU_PADDING_MODE BIT(31)
 #define B_BE_MACID_MPDU_PROCESSOR_OFFSET_MASK GENMASK(26, 16)
@@ -5065,6 +5074,8 @@
 				 B_BE_STF_WRFF_UNDERFLOW_ERR_INT_EN | \
 				 B_BE_STF_OQT_OVERFLOW_ERR_INT_EN | \
 				 B_BE_STF_OQT_UNDERFLOW_ERR_INT_EN)
+#define B_BE_DISP_OTHER_IMR_CLR_V1 0xFFFFFFFF
+#define B_BE_DISP_OTHER_IMR_SET_V1 0x3F002000
 
 #define R_BE_DISP_HOST_IMR 0x8874
 #define B_BE_HR_WRFF_UNDERFLOW_ERR_INT_EN BIT(31)
@@ -5142,6 +5153,8 @@
 				B_BE_HR_DMA_PROCESS_ERR_INT_EN | \
 				B_BE_HR_WRFF_OVERFLOW_ERR_INT_EN | \
 				B_BE_HR_WRFF_UNDERFLOW_ERR_INT_EN)
+#define B_BE_DISP_HOST_IMR_CLR_V1 0xFBFFFFFF
+#define B_BE_DISP_HOST_IMR_SET_V1 0xC8B3E579
 
 #define R_BE_DISP_CPU_IMR 0x8878
 #define B_BE_CR_PLD_LEN_ERR_INT_EN BIT(30)
@@ -5216,6 +5229,8 @@
 			       B_BE_CR_DMA_PROCESS_ERR_INT_EN | \
 			       B_BE_CR_WRFF_OVERFLOW_ERR_INT_EN | \
 			       B_BE_CR_WRFF_UNDERFLOW_ERR_INT_EN)
+#define B_BE_DISP_CPU_IMR_CLR_V1 0x7DFFFFFD
+#define B_BE_DISP_CPU_IMR_SET_V1 0x34F938FD
 
 #define R_BE_RX_STOP 0x8914
 #define B_BE_CPU_RX_STOP BIT(17)
@@ -5567,7 +5582,21 @@
 				B_BE_WDRLS_RPT1_AGGNUM0_ERR_INT_EN | \
 				B_BE_WDRLS_RPT1_FRZTO_ERR_INT_EN)
 
+#define R_BE_RLSRPT0_CFG0 0x9440
+#define B_BE_RLSRPT0_FWRLS BIT(31)
+#define B_BE_RLSRPT0_FWD_TRGT_MASK GENMASK(23, 16)
+#define B_BE_RLSRPT0_PID_MASK GENMASK(10, 8)
+#define B_BE_RLSRPT0_QID_MASK GENMASK(5, 0)
+#define WDRLS_DEST_QID_POH 1
+#define WDRLS_DEST_QID_STF 0
+
 #define R_BE_RLSRPT0_CFG1 0x9444
+#define B_BE_RLSRPT0_FLTR_MAP_V1_MASK GENMASK(28, 24)
+#define S_BE_WDRLS_FLTR_TXOK_V1 BIT(0)
+#define S_BE_WDRLS_FLTR_RTYLMT_V1 BIT(1)
+#define S_BE_WDRLS_FLTR_LIFTIM_V1 BIT(2)
+#define S_BE_WDRLS_FLTR_MACID_V1 BIT(3)
+#define S_BE_WDRLS_FLTR_RELINK_V1 BIT(4)
 #define B_BE_RLSRPT0_FLTR_MAP_MASK GENMASK(27, 24)
 #define S_BE_WDRLS_FLTR_TXOK 1
 #define S_BE_WDRLS_FLTR_RTYLMT 2
@@ -5866,7 +5895,12 @@
 #define B_BE_B0_PRELD_FEN BIT(31)
 #define B_BE_B0_PRELD_USEMAXSZ_MASK GENMASK(25, 16)
 #define B_BE_B0_PRELD_CAM_G1ENTNUM_MASK GENMASK(12, 8)
+#define PRELD_MISCQ_ENT_NUM_8922A 2
+#define PRELD_MISCQ_ENT_NUM_8922D 1
 #define B_BE_B0_PRELD_CAM_G0ENTNUM_MASK GENMASK(4, 0)
+#define PRELD_B0_ACQ_ENT_NUM_8922A 8
+#define PRELD_B1_ACQ_ENT_NUM_8922A 2
+#define PRELD_ACQ_ENT_NUM_8922D 1
 
 #define R_BE_TXPKTCTL_B0_PRELD_CFG1 0x9F4C
 #define B_BE_B0_PRELD_NXT_TXENDWIN_MASK GENMASK(11, 8)
@@ -5978,6 +6012,7 @@
 #define B_BE_PLRLS_CTL_FRZTO_ISR BIT(0)
 
 #define R_BE_SS_CTRL 0xA310
+#define R_BE_SS_CTRL_V1 0xA610
 #define B_BE_SS_INIT_DONE BIT(31)
 #define B_BE_WDE_STA_DIS BIT(30)
 #define B_BE_WARM_INIT BIT(29)
@@ -6017,6 +6052,24 @@
 #define B_BE_RPT_TIMEOUT_ISR BIT(1)
 #define B_BE_SEARCH_TIMEOUT_ISR BIT(0)
 
+#define R_BE_PLRLS_ERR_IMR_V1 0xA518
+#define B_BE_PLRLS_DUMMY_ISR6 BIT(7)
+#define B_BE_PLRLS_DUMMY_ISR5 BIT(6)
+#define B_BE_PLRLS_DUMMY_ISR4 BIT(5)
+#define B_BE_PLRLS_DUMMY_ISR3 BIT(4)
+#define B_BE_PLRLS_DUMMY_ISR2 BIT(3)
+#define B_BE_PLRLS_DUMMY_ISR1 BIT(2)
+#define B_BE_PLRLS_DUMMY_ISR0 BIT(1)
+#define B_BE_PLRLS_ERR_IMR_V1_CLR 0x1
+#define B_BE_PLRLS_ERR_IMR_V1_SET 0x1
+
+#define R_BE_SS_LITE_TXL_MACID 0xA790
+#define B_BE_RPT_OTHER_BAND_EN BIT(31)
+#define B_BE_TXL_CMD_EN BIT(30)
+#define B_BE_TXL_READ_MACID_MASK GENMASK(29, 20)
+#define B_BE_TXL_MACID_1_MASK GENMASK(19, 10)
+#define B_BE_TXL_MACID_0_MASK GENMASK(9, 0)
+
 #define R_BE_HAXI_INIT_CFG1 0xB000
 #define B_BE_CFG_WD_PERIOD_IDLE_MASK GENMASK(31, 28)
 #define B_BE_CFG_WD_PERIOD_ACTIVE_MASK GENMASK(27, 24)
@@ -6296,6 +6349,21 @@
 #define B_BE_RSC_MASK GENMASK(7, 6)
 #define B_BE_RRSR_CCK_MASK GENMASK(3, 0)
 
+#define R_BE_COMMON_PHYINTF_CTRL_0 0x100B8
+#define R_BE_COMMON_PHYINTF_CTRL_0_C1 0x140B8
+#define B_BE_SEQ_EN_GUARD_CYE_MASK GENMASK(23, 20)
+#define B_BE_PARA_FIFO_CRC_EN BIT(18)
+#define B_BE_SEQ_FIFO_TO_EN BIT(17)
+#define B_BE_PARA_FIFO_TO_EN BIT(16)
+#define B_BE_SEQ_FIFO_CLR_EN BIT(6)
+#define B_BE_PARA_FIFO_CLR_EN_V1 BIT(5)
+#define B_BE_CSI_FIFO_CLR_EN_V1 BIT(4)
+#define B_BE_FTM_FIFO_CLR_EN_V1 BIT(3)
+#define B_BE_RXD_FIFO_CLR_EN_V1 BIT(2)
+#define B_BE_TXD_FIFO_CLR_EN_V1 BIT(1)
+#define B_BE_TXUID_FIFO_CLR_EN_V1 BIT(0)
+#define CLEAR_DTOP_DIS	(BIT(1) | BIT(5) | BIT(6))
+
 #define R_BE_CMAC_ERR_IMR 0x10160
 #define R_BE_CMAC_ERR_IMR_C1 0x14160
 #define B_BE_CMAC_FW_ERR_IDCT_EN BIT(16)
@@ -6388,6 +6456,25 @@
 #define B_BE_P0_SYNC_PORT_SRC_SEL_MASK GENMASK(26, 24)
 #define B_BE_P0_TSFTR_SYNC_OFFSET_MASK GENMASK(18, 0)
 
+#define R_BE_SCH_EDCA_RST_CFG 0x102E4
+#define R_BE_SCH_EDCA_RST_CFG_C1 0x142E4
+#define B_BE_EDCCA_S160_RST_EDCA_EN BIT(23)
+#define B_BE_EDCCA_S80_RST_EDCA_EN BIT(22)
+#define B_BE_EDCCA_S40_RST_EDCA_EN BIT(21)
+#define B_BE_EDCCA_S20_RST_EDCA_EN BIT(20)
+#define B_BE_OFDM_CCA_S160_RST_EDCA_EN BIT(19)
+#define B_BE_CCA_PEB_BE_BITMAP_RST_EDCA_EN BIT(18)
+#define B_BE_RX_INTRA_NAV_RST_EDCA_EN BIT(15)
+#define B_BE_RX_BASIC_NAV_RST_EDCA_EN BIT(14)
+#define B_BE_EDCCA_PER20_BITMAP_SIFS_RST_EDCA_EN BIT(10)
+#define B_BE_TX_NAV_RST_EDCA_EN BIT(7)
+#define B_BE_NO_GNT_WL_RST_EDCA_EN BIT(5)
+#define B_BE_EDCCA_P20_RST_EDCA_EN BIT(4)
+#define B_BE_OFDM_CCA_S80_RST_EDCA_EN BIT(3)
+#define B_BE_OFDM_CCA_S40_RST_EDCA_EN BIT(2)
+#define B_BE_OFDM_CCA_S20_RST_EDCA_EN BIT(1)
+#define B_BE_CCA_P20_RST_EDCA_EN BIT(0)
+
 #define R_BE_EDCA_BCNQ_PARAM 0x10324
 #define R_BE_EDCA_BCNQ_PARAM_C1 0x14324
 #define B_BE_BCNQ_CW_MASK GENMASK(31, 24)
@@ -6678,6 +6765,34 @@
 #define B_BE_CMAC_TX_MODE_1 BIT(1)
 #define B_BE_CMAC_TX_MODE_0 BIT(0)
 
+#define R_BE_AGG_BK_0 0x10804
+#define R_BE_AGG_BK_0_C1 0x14804
+#define B_BE_DIS_SAMPDU_TXIME_SR_CHECK BIT(24)
+#define B_BE_TX_PAIR_MACID_LEN_EN BIT(23)
+#define B_BE_DIS_SND_STS_CHECK_SU BIT(22)
+#define B_BE_MAX_AGG_NUM_FIX_MODE_EN_V1 BIT(21)
+#define B_BE_DIS_SIFS_BK_AGG_AMPDU BIT(20)
+#define B_BE_EN_MU2SU_CHK_PROTECT_PPDU BIT(19)
+#define B_BE_RPT_TXOP_START_PROTECT BIT(18)
+#define B_BE_RANDOM_GEN_CMD_ABORT_EN BIT(17)
+#define B_BE_PHYTXON_ENDPS_RESP_CHK BIT(16)
+#define B_BE_CTN_CHK_SEQ_REQ_EN BIT(15)
+#define B_BE_PTCL_RLS_ALLFAIL_EN BIT(14)
+#define B_BE_DIS_MURU_PRI_Q_EMPTY_CHK BIT(13)
+#define B_BE_DIS_MURU_SEC_Q_EMPTY_CHK BIT(12)
+#define B_BE_EN_SAMPDU_TXIME_TWT_CHECK BIT(11)
+#define B_BE_DIS_SAMPDU_TXIME_P2P_CHECK BIT(10)
+#define B_BE_DIS_SAMPDU_TXIME_BCN_CHECK BIT(9)
+#define B_BE_DIS_UL_SEQ_ABORT_CHECK BIT(8)
+#define B_BE_DIS_SND_STS_CHECK BIT(7)
+#define B_BE_NAV_PAUS_PHB_EN BIT(6)
+#define B_BE_TXOP_SHT_PHB_EN BIT(5)
+#define B_BE_AGG_BRK_PHB_EN BIT(4)
+#define B_BE_DIS_SSN_CHK BIT(3)
+#define B_BE_WDBK_CFG BIT(2)
+#define B_BE_EN_RTY_BK BIT(1)
+#define B_BE_EN_RTY_BK_COD BIT(0)
+
 #define R_BE_TB_PPDU_CTRL 0x1080C
 #define R_BE_TB_PPDU_CTRL_C1 0x1480C
 #define B_BE_TB_PPDU_BK_DIS BIT(15)
@@ -6692,9 +6807,11 @@
 #define R_BE_AMPDU_AGG_LIMIT_C1 0x14810
 #define B_BE_AMPDU_MAX_TIME_MASK GENMASK(31, 24)
 #define AMPDU_MAX_TIME 0x9E
+#define AMPDU_MAX_TIME_V1 0xA4
 #define B_BE_RA_TRY_RATE_AGG_LMT_MASK GENMASK(23, 16)
 #define B_BE_RTS_MAX_AGG_NUM_MASK GENMASK(15, 8)
 #define B_BE_MAX_AGG_NUM_MASK GENMASK(7, 0)
+#define MAX_TX_AMPDU_NUM_V1 128
 
 #define R_BE_AGG_LEN_HT_0 0x10814
 #define R_BE_AGG_LEN_HT_0_C1 0x14814
@@ -6702,6 +6819,20 @@
 #define B_BE_RTS_TXTIME_TH_MASK GENMASK(15, 8)
 #define B_BE_RTS_LEN_TH_MASK GENMASK(7, 0)
 
+#define R_BE_SPECIAL_TX_SETTING 0x10820
+#define R_BE_SPECIAL_TX_SETTING_C1 0x14820
+#define B_BE_TRI_PADDING_EXTEND BIT(31)
+#define B_BE_TX_SN_BYPASS_EN BIT(30)
+#define B_BE_USE_DATA_BW BIT(29)
+#define B_BE_BW_SIGTA_MASK GENMASK(28, 27)
+#define B_BE_BMC_NAV_PROTECT BIT(26)
+#define B_BE_F2P_KEEP_NON_SR_CMD BIT(25)
+#define B_BE_F2P_SU_FIXRATE_OVER_WD BIT(24)
+#define B_BE_BAR_TXRATE_FOR_NULL_WD_MASK GENMASK(23, 20)
+#define B_BE_STBC_CFEND_MASK GENMASK(19, 18)
+#define B_BE_STBC_CFEND_RATE_MASK GENMASK(17, 9)
+#define B_BE_BASIC_CFEND_RATE_MASK GENMASK(8, 0)
+
 #define R_BE_SIFS_SETTING 0x10824
 #define R_BE_SIFS_SETTING_C1 0x14824
 #define B_BE_HW_CTS2SELF_PKT_LEN_TH_MASK GENMASK(31, 24)
@@ -6735,6 +6866,44 @@
 #define B_BE_PORT_DROP_4_0_MASK GENMASK(20, 16)
 #define B_BE_MBSSID_DROP_15_0_MASK GENMASK(15, 0)
 
+#define R_BE_PTCL_PRELD_CTRL 0x10868
+#define R_BE_PTCL_PRELD_CTRL_C1 0x14868
+#define B_BE_PRELD_MGQ2_EN BIT(22)
+#define B_BE_PRELD_MGQ1_EN BIT(21)
+#define B_BE_PRELD_MGQ0_EN BIT(20)
+#define B_BE_PRELD_HIQ_P4_EN BIT(19)
+#define B_BE_PRELD_HIQ_P3_EN BIT(18)
+#define B_BE_PRELD_HIQ_P2_EN BIT(17)
+#define B_BE_PRELD_HIQ_P1_EN BIT(16)
+#define B_BE_PRELD_HIQ_P0MB15_EN BIT(15)
+#define B_BE_PRELD_HIQ_P0MB14_EN BIT(14)
+#define B_BE_PRELD_HIQ_P0MB13_EN BIT(13)
+#define B_BE_PRELD_HIQ_P0MB12_EN BIT(12)
+#define B_BE_PRELD_HIQ_P0MB11_EN BIT(11)
+#define B_BE_PRELD_HIQ_P0MB10_EN BIT(10)
+#define B_BE_PRELD_HIQ_P0MB9_EN BIT(9)
+#define B_BE_PRELD_HIQ_P0MB8_EN BIT(8)
+#define B_BE_PRELD_HIQ_P0MB7_EN BIT(7)
+#define B_BE_PRELD_HIQ_P0MB6_EN BIT(6)
+#define B_BE_PRELD_HIQ_P0MB5_EN BIT(5)
+#define B_BE_PRELD_HIQ_P0MB4_EN BIT(4)
+#define B_BE_PRELD_HIQ_P0MB3_EN BIT(3)
+#define B_BE_PRELD_HIQ_P0MB2_EN BIT(2)
+#define B_BE_PRELD_HIQ_P0MB1_EN BIT(1)
+#define B_BE_PRELD_HIQ_P0_EN BIT(0)
+#define B_BE_PRELD_HIQ_ALL_EN (B_BE_PRELD_HIQ_P0_EN | B_BE_PRELD_HIQ_P1_EN | \
+			       B_BE_PRELD_HIQ_P2_EN | B_BE_PRELD_HIQ_P3_EN | \
+			       B_BE_PRELD_HIQ_P4_EN)
+#define B_BE_PRELD_HIQ_P0MB_ALL_EN \
+	(B_BE_PRELD_HIQ_P0_EN | B_BE_PRELD_HIQ_P0MB1_EN | \
+	 B_BE_PRELD_HIQ_P0MB2_EN | B_BE_PRELD_HIQ_P0MB3_EN | \
+	 B_BE_PRELD_HIQ_P0MB4_EN | B_BE_PRELD_HIQ_P0MB5_EN | \
+	 B_BE_PRELD_HIQ_P0MB6_EN | B_BE_PRELD_HIQ_P0MB7_EN | \
+	 B_BE_PRELD_HIQ_P0MB8_EN | B_BE_PRELD_HIQ_P0MB9_EN | \
+	 B_BE_PRELD_HIQ_P0MB10_EN | B_BE_PRELD_HIQ_P0MB11_EN | \
+	 B_BE_PRELD_HIQ_P0MB12_EN | B_BE_PRELD_HIQ_P0MB13_EN | \
+	 B_BE_PRELD_HIQ_P0MB14_EN | B_BE_PRELD_HIQ_P0MB15_EN)
+
 #define R_BE_BT_PLT 0x1087C
 #define R_BE_BT_PLT_C1 0x1487C
 #define B_BE_BT_PLT_PKT_CNT_MASK GENMASK(31, 16)
@@ -6975,6 +7144,8 @@
 				    B_BE_RX_RU1_FSM_HANG_ERROR_IMR | \
 				    B_BE_RX_RU0_FSM_HANG_ERROR_IMR | \
 				    B_BE_RX_GET_NULL_PKT_ERROR_IMR)
+#define B_BE_RX_ERROR_FLAG_IMR_CLR_V1 0x7FFFFFF8
+#define B_BE_RX_ERROR_FLAG_IMR_SET_V1 0x7FFFFF38
 
 #define R_BE_RX_CTRL_1 0x10C0C
 #define R_BE_RX_CTRL_1_C1 0x14C0C
@@ -7466,6 +7637,17 @@
 #define B_BE_CCK_SIG_CHK BIT(1)
 #define B_BE_CCK_CRC_CHK BIT(0)
 
+#define R_BE_RXGCK_CTRL 0x11406
+#define R_BE_RXGCK_CTRL_C1 0x15406
+#define B_BE_RXGCK_BCNPRS_DISGCLK BIT(12)
+#define B_BE_RXGCK_GCK_RATE_LIMIT_MASK GENMASK(9, 8)
+#define RX_GCK_LEGACY 2
+#define B_BE_RXGCK_DISREG_GCLK BIT(7)
+#define B_BE_RXGCK_ENTRY_DELAY_MASK GENMASK(6, 4)
+#define B_BE_RXGCK_GCK_CYCLE_MASK GENMASK(3, 2)
+#define B_BE_RXGCK_CCA_EN BIT(1)
+#define B_BE_DISGCLK BIT(0)
+
 #define R_BE_RX_FLTR_OPT 0x11420
 #define R_BE_RX_FLTR_OPT_C1 0x15420
 #define B_BE_UID_FILTER_MASK GENMASK(31, 24)
@@ -7560,6 +7742,11 @@
 #define B_BE_CSIPRT_HESU_AID_EN BIT(25)
 #define B_BE_CSIPRT_VHTSU_AID_EN BIT(24)
 
+#define R_BE_BSR_UPD_CTRL 0x11468
+#define R_BE_BSR_UPD_CTRL_C1 0x15468
+#define B_BE_QSIZE_RULE BIT(1)
+#define B_BE_QSIZE_UPD BIT(0)
+
 #define R_BE_DRV_INFO_OPTION 0x11470
 #define R_BE_DRV_INFO_OPTION_C1 0x15470
 #define B_BE_DRV_INFO_PHYRPT_EN BIT(0)
@@ -7625,11 +7812,35 @@
 #define B_BE_PLCP_CH20_WIDATA_SRC BIT(1)
 #define B_BE_PLCP_PPDU_TYPE_SRC BIT(0)
 
+#define R_BE_RX_PLCP_EXT_OPTION_2 0x11518
+#define R_BE_RX_PLCP_EXT_OPTION_2_C1 0x15518
+#define B_BE_PLCP_PHASE_B_CRC_CHK_EN BIT(17)
+#define B_BE_PLCP_PHASE_A_CRC_CHK_EN BIT(16)
+#define B_BE_EHTTB_EHTSIG_CRC_CHK_EN BIT(3)
+#define B_BE_EHTTB_USIG_CRC_CHK_EN BIT(2)
+#define B_BE_EHTMU_EHTSIG_CRC_CHK_EN BIT(1)
+#define B_BE_EHTMU_USIG_CRC_CHK_EN BIT(0)
+
 #define R_BE_RESP_CSI_RESERVED_PAGE 0x11810
 #define R_BE_RESP_CSI_RESERVED_PAGE_C1 0x15810
 #define B_BE_CSI_RESERVED_PAGE_NUM_MASK GENMASK(27, 16)
 #define B_BE_CSI_RESERVED_START_PAGE_MASK GENMASK(11, 0)
 
+#define R_BE_RESP_IMR1 0x11878
+#define R_BE_RESP_IMR1_C1 0x15878
+#define B_BE_RESP_IMR_1_MASK GENMASK(31, 9)
+#define B_BE_FSM_TIMEOUT_ERR_IMR BIT(8)
+#define B_BE_SEC_DOUBLE_HIT_ERR_IMR BIT(7)
+#define B_BE_WRPTR_ERR_IMR BIT(6)
+#define B_BE_SMR_TOO_MANY_PLD_ERR_IMR BIT(5)
+#define B_BE_LMR_TOO_MANY_PLD_ERR_IMR BIT(4)
+#define B_BE_CSI_TOO_MANY_PLD_ERR_IMR BIT(3)
+#define B_BE_FTM_LMR_PLDID_READY_ERR_IMR BIT(2)
+#define B_BE_SMR_PLDID_READY_ERR_IMR BIT(1)
+#define B_BE_CSI_PLDID_READY_ERR_IMR BIT(0)
+#define B_BE_RESP_IMR1_CLR 0x1FF
+#define B_BE_RESP_IMR1_SET 0xFF
+
 #define R_BE_RESP_IMR 0x11884
 #define R_BE_RESP_IMR_C1 0x15884
 #define B_BE_RESP_TBL_FLAG_ERR_ISR_EN BIT(17)
@@ -7674,6 +7885,8 @@
 			   B_BE_RESP_PLDID_RDY_ERR_ISR_EN | \
 			   B_BE_RESP_WRPTR_CROSS_ERR_ISR_EN | \
 			   B_BE_RESP_SEC_DOUBLE_HIT_ERR_ISR_EN)
+#define B_BE_RESP_IMR_CLR_V1 0xFFFFFFFF
+#define B_BE_RESP_IMR_SET_V1 0xFFFFFFFF
 
 #define R_BE_PWR_MODULE 0x11900
 #define R_BE_PWR_MODULE_C1 0x15900
@@ -7752,6 +7965,10 @@
 #define R_BE_TXPWR_ERR_FLAG_C1 0x158E4
 #define R_BE_TXPWR_ERR_IMR_C1 0x158E0
 
+#define R_BE_SCH_EXT_CTRL 0x103FC
+#define R_BE_SCH_EXT_CTRL_C1 0x143FC
+#define B_BE_CWCNT_PLUS_MODE BIT(31)
+
 #define CMAC1_START_ADDR_BE 0x14000
 #define CMAC1_END_ADDR_BE 0x17FFF
 
-- 
2.25.1


