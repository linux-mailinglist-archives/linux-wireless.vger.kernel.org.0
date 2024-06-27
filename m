Return-Path: <linux-wireless+bounces-9631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F188D919DA0
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 04:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217531C217E8
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 02:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B821171C;
	Thu, 27 Jun 2024 02:59:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D98013FF6
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457167; cv=none; b=kA+XnQ2R9A/2HjCDHfCmfqxlo5q9TuOeMM5jU8bLIVaaYiYAB4KH3oJFqbDm+eLSFLaKnhn+cqTR+rIaY/Jw3mi6lOMahoXSV/19kJSwY6BmPtIlfqcUyRsJa5RPqQOVr8ry2dhH6/mhTDSI855hjrtFY/PWcBE2o2bM+iCPqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457167; c=relaxed/simple;
	bh=XdfmBk3T2oVtMy3s3QuKVH+UpK0aXwNd6/uaL1jntHc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWw7/DDOOntMNLgoH2ZUBIiUF18RVSyXyFvROiSzdIRe27RifygSQszQtbcJl6ksn/wz2VkVf1tO2SfUe4XEiwkBzGrU31h9Bx5eTkcUUUhAR/NjKed/+CwZzu6Jd0eD+qRUSDsUJI4/1oC2T9KTRRoJRQTLpAvlhjrOfqz8wjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45R2xLyG52591116, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 45R2xLyG52591116
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 10:59:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 10:59:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Jun
 2024 10:59:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] wifi: rtw89: 8852bt: rfk: add IQK
Date: Thu, 27 Jun 2024 10:58:46 +0800
Message-ID: <20240627025849.25198-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627025849.25198-1-pkshih@realtek.com>
References: <20240627025849.25198-1-pkshih@realtek.com>
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

IQ signal calibration is a very important calibration to yield good RF
performance. We do this calibration once we are going to an AP. During
scanning phase, without this calibration RF performance is still
acceptable because it transmits and receives with low data rate at
this phase.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |   1 +
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    | 892 ++++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852bt_rfk.h    |   1 +
 3 files changed, 894 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 177981a108e0..24e8d244534e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8659,6 +8659,7 @@
 #define R_P0_RFCTM 0x5864
 #define B_P0_CLKG_FORCE GENMASK(31, 30)
 #define B_P0_RFCTM_EN BIT(29)
+#define B_P0_GOT_TXRX GENMASK(28, 27)
 #define B_P0_RFCTM_VAL GENMASK(25, 20)
 #define R_P0_RFCTM_RDY BIT(26)
 #define R_P0_TRSW 0x5868
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index d0a40eabfe2d..4a638e2444db 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -13,6 +13,7 @@
 #include "rtw8852bt_rfk_table.h"
 #include "rtw8852b_common.h"
 
+#define RTW8852BT_IQK_VER 0x2a
 #define RTW8852BT_SS 2
 #define RTW8852BT_TSSI_PATH_NR 2
 #define RTW8852BT_DPK_VER 0x06
@@ -67,6 +68,23 @@ enum dpk_agc_step {
 	DPK_AGC_STEP_SET_TX_GAIN,
 };
 
+enum rtw8852bt_iqk_type {
+	ID_TXAGC = 0x0,
+	ID_FLOK_COARSE = 0x1,
+	ID_FLOK_FINE = 0x2,
+	ID_TXK = 0x3,
+	ID_RXAGC = 0x4,
+	ID_RXK = 0x5,
+	ID_NBTXK = 0x6,
+	ID_NBRXK = 0x7,
+	ID_FLOK_VBUFFER = 0x8,
+	ID_A_FLOK_COARSE = 0x9,
+	ID_G_FLOK_COARSE = 0xa,
+	ID_A_FLOK_FINE = 0xb,
+	ID_G_FLOK_FINE = 0xc,
+	ID_IQK_RESTORE = 0x10,
+};
+
 enum adc_ck {
 	ADC_NA = 0,
 	ADC_480M = 1,
@@ -347,6 +365,813 @@ static void _rfk_bb_afe_restore(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_MV_AVG, B_P1_TXPW_RSTB, 0x2);
 }
 
+static bool _iqk_check_cal(struct rtw89_dev *rtwdev, u8 path, u8 ktype)
+{
+	bool notready = false;
+	u32 val;
+	int ret;
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val == 0x55,
+				       10, 8200, false,
+				       rtwdev, R_RFK_ST, MASKBYTE0);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]NCTL1 IQK timeout!!!\n");
+
+	udelay(10);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val == 0x8000,
+				       10, 400, false,
+				       rtwdev, R_RPT_COM, B_RPT_COM_RDY);
+	if (ret) {
+		notready = true;
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]NCTL2 IQK timeout!!!\n");
+	}
+
+	udelay(10);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, MASKBYTE0, 0x0);
+
+	return notready;
+}
+
+static bool _iqk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			  u8 path, u8 ktype)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u32 iqk_cmd;
+	bool fail;
+
+	switch (ktype) {
+	case ID_TXAGC:
+		iqk_cmd = 0x008 | (1 << (4 + path)) | (path << 1);
+		break;
+	case ID_FLOK_COARSE:
+		iqk_cmd = 0x108 | (1 << (4 + path));
+		break;
+	case ID_FLOK_FINE:
+		iqk_cmd = 0x208 | (1 << (4 + path));
+		break;
+	case ID_FLOK_VBUFFER:
+		iqk_cmd = 0x308 | (1 << (4 + path));
+		break;
+	case ID_TXK:
+		iqk_cmd = 0x008 | (1 << (path + 4)) |
+			  (((0x8 + iqk_info->iqk_bw[path]) & 0xf) << 8);
+		break;
+	case ID_RXAGC:
+		iqk_cmd = 0x508 | (1 << (4 + path)) | (path << 1);
+		break;
+	case ID_RXK:
+		iqk_cmd = 0x008 | (1 << (path + 4)) |
+			  (((0xb + iqk_info->iqk_bw[path]) & 0xf) << 8);
+		break;
+	case ID_NBTXK:
+		iqk_cmd = 0x408 | (1 << (4 + path));
+		break;
+	case ID_NBRXK:
+		iqk_cmd = 0x608 | (1 << (4 + path));
+		break;
+	default:
+		return false;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s, iqk_cmd = %x\n",
+		    __func__, iqk_cmd + 1);
+
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, iqk_cmd + 1);
+	fail = _iqk_check_cal(rtwdev, path, ktype);
+
+	return fail;
+}
+
+static void _iqk_txk_setting(struct rtw89_dev *rtwdev, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+		rtw89_write_rf(rtwdev, path, RR_TXG1, RR_TXG1_ATT2, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_TXG1, RR_TXG1_ATT1, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_TXG2, RR_TXG2_ATT0, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_TXGA, RR_TXGA_LOK_EXT, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_LUTWE, RR_LUTWE_LOK, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_LUTWA, RR_LUTWA_M1, 0x00);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_IQK, 0x403e);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, 0x5);
+		udelay(1);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_BIASA, RR_BIASA_A, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_TXGA, RR_TXGA_LOK_EXT, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_LUTWE, RR_LUTWE_LOK, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_LUTWA, RR_LUTWA_M1, 0x80);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_IQK, 0x403e);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, 0x4);
+		udelay(1);
+		break;
+	default:
+		break;
+	}
+}
+
+static bool _iqk_2g_lok(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), B_KIP_IQP_IQSW, 0x09);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT, 0x021);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, 0x00000119 + (path << 4));
+
+	_iqk_check_cal(rtwdev, path, ID_FLOK_COARSE);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+
+	rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x12);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), B_KIP_IQP_IQSW, 0x24);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, 0x00000319 + (path << 4));
+
+	_iqk_check_cal(rtwdev, path, ID_FLOK_VBUFFER);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+
+	rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), B_KIP_IQP_IQSW, 0x09);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, 0x00000219 + (path << 4));
+
+	_iqk_check_cal(rtwdev, path, ID_FLOK_COARSE);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+
+	rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x12);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), B_KIP_IQP_IQSW, 0x24);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, 0x00000319 + (path << 4));
+
+	_iqk_check_cal(rtwdev, path, ID_FLOK_VBUFFER);
+
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+
+	return false;
+}
+
+static bool _iqk_5g_lok(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), B_KIP_IQP_IQSW, 0x09);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT, 0x021);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, 0x00000119 + (path << 4));
+
+	_iqk_check_cal(rtwdev, path, ID_FLOK_COARSE);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+
+	rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x12);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), B_KIP_IQP_IQSW, 0x24);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, 0x00000319 + (path << 4));
+
+	_iqk_check_cal(rtwdev, path, ID_FLOK_VBUFFER);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+
+	rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), B_KIP_IQP_IQSW, 0x09);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, 0x00000219 + (path << 4));
+
+	_iqk_check_cal(rtwdev, path, ID_FLOK_COARSE);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+
+	rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x12);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), B_KIP_IQP_IQSW, 0x24);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, 0x00000319 + (path << 4));
+
+	_iqk_check_cal(rtwdev, path, ID_FLOK_VBUFFER);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+
+	return false;
+}
+
+static bool _iqk_2g_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
+{
+	static const u32 g_power_range[4] = {0x0, 0x0, 0x0, 0x0};
+	static const u32 g_track_range[4] = {0x4, 0x4, 0x6, 0x6};
+	static const u32 g_gain_bb[4] = {0x08, 0x0e, 0x08, 0x0e};
+	static const u32 g_itqt[4] = {0x09, 0x12, 0x1b, 0x24};
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool notready = false;
+	bool kfail = false;
+	u8 gp;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	for (gp = 0x0; gp < 0x4; gp++) {
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0,
+			       g_power_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1,
+			       g_track_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG,
+			       g_gain_bb[gp]);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       0x00000100, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       0x00000010, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       0x00000004, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       0x00000003, gp);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT,
+				       0x009);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       B_KIP_IQP_IQSW, g_itqt[gp]);
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBTXK);
+		iqk_info->nb_txcfir[path] =
+			rtw89_phy_read32_mask(rtwdev, R_TXIQC + (path << 8), MASKDWORD);
+
+		if (iqk_info->is_nbiqk)
+			break;
+
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       B_KIP_IQP_IQSW, g_itqt[gp]);
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_TXK);
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S%x, gp = 0x%x, 0x8%x38 = 0x%x\n",
+			    path, gp, 1 << path, iqk_info->nb_txcfir[path]);
+	}
+
+	if (!notready)
+		kfail = !!rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, B_NCTL_RPT_FLG);
+
+	if (kfail) {
+		iqk_info->nb_txcfir[path] = 0x40000002;
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RES + (path << 8),
+				       B_IQK_RES_TXCFIR, 0x0);
+	}
+
+	return kfail;
+}
+
+static bool _iqk_5g_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
+{
+	static const u32 a_power_range[4] = {0x0, 0x0, 0x0, 0x0};
+	static const u32 a_track_range[4] = {0x3, 0x3, 0x6, 0x6};
+	static const u32 a_gain_bb[4] = {0x08, 0x10, 0x08, 0x0e};
+	static const u32 a_itqt[4] = {0x09, 0x12, 0x1b, 0x24};
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool notready = false;
+	bool kfail = false;
+	u8 gp;
+
+	for (gp = 0x0; gp < 0x4; gp++) {
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, a_power_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, a_track_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, a_gain_bb[gp]);
+
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       MASKDWORD, a_itqt[gp]);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       0x00000100, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       0x00000010, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       0x00000004, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       0x00000003, gp);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT,
+				       0x009);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       B_KIP_IQP_IQSW, a_itqt[gp]);
+
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBTXK);
+		iqk_info->nb_txcfir[path] =
+			rtw89_phy_read32_mask(rtwdev, R_TXIQC + (path << 8), MASKDWORD);
+
+		if (iqk_info->is_nbiqk)
+			break;
+
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       B_KIP_IQP_IQSW, a_itqt[gp]);
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_TXK);
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S%x, gp = 0x%x, 0x8%x38 = 0x%x\n",
+			    path, gp, 1 << path, iqk_info->nb_txcfir[path]);
+	}
+
+	if (!notready)
+		kfail = !!rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, B_NCTL_RPT_FLG);
+
+	if (kfail) {
+		iqk_info->nb_txcfir[path] = 0x40000002;
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RES + (path << 8),
+				       B_IQK_RES_TXCFIR, 0x0);
+	}
+
+	return kfail;
+}
+
+static void _iqk_adc_fifo_rst(struct rtw89_dev *rtwdev,
+			      enum rtw89_phy_idx phy_idx, u8 path)
+{
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x0303);
+	udelay(10);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x3333);
+}
+
+static void _iqk_rxclk_setting(struct rtw89_dev *rtwdev, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x0303);
+
+	if (iqk_info->iqk_bw[path] == RTW89_CHANNEL_WIDTH_80) {
+		_rxck_force(rtwdev, RF_PATH_A, true, ADC_960M);
+		_rxck_force(rtwdev, RF_PATH_B, true, ADC_960M);
+		udelay(1);
+
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC,
+				       B_UPD_CLK_ADC_ON, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC,
+				       B_UPD_CLK_ADC_VAL, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_SAMPL_DLY_T_V1,
+				       B_PATH0_SAMPL_DLY_T_MSK_V1, 0x2);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_SAMPL_DLY_T_V1,
+				       B_PATH1_SAMPL_DLY_T_MSK_V1, 0x2);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1, B_P0_CFCH_BW1, 0x8);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BW_SEL_V1,
+				       B_PATH1_BW_SEL_MSK_V1, 0x8);
+	} else {
+		_rxck_force(rtwdev, RF_PATH_A, true, ADC_480M);
+		_rxck_force(rtwdev, RF_PATH_B, true, ADC_480M);
+		udelay(1);
+
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC,
+				       B_UPD_CLK_ADC_ON, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC,
+				       B_UPD_CLK_ADC_VAL, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_SAMPL_DLY_T_V1,
+				       B_PATH0_SAMPL_DLY_T_MSK_V1, 0x3);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_SAMPL_DLY_T_V1,
+				       B_PATH1_SAMPL_DLY_T_MSK_V1, 0x3);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1, B_P0_CFCH_BW1, 0xf);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BW_SEL_V1,
+				       B_PATH1_BW_SEL_MSK_V1, 0xf);
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_PATH0_SAMPL_DLY_T_V1, 0x00000780, 0x8);
+	rtw89_phy_write32_mask(rtwdev, R_PATH1_SAMPL_DLY_T_V1, 0x00000780, 0x8);
+	rtw89_phy_write32_mask(rtwdev, R_PATH0_SAMPL_DLY_T_V1, 0x00007800, 0x2);
+	rtw89_phy_write32_mask(rtwdev, R_PATH1_SAMPL_DLY_T_V1, 0x00007800, 0x2);
+	rtw89_phy_write32_mask(rtwdev, R_DRCK, B_DRCK_MUL, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x1);
+	udelay(1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15, 0x0f);
+	udelay(1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15, 0x03);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_15, 0xa001);
+	udelay(1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_15, 0xa041);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x3333);
+}
+
+static bool _iqk_2g_rx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
+{
+	static const u32 g_idxrxgain[2] = {0x212, 0x310};
+	static const u32 g_idxattc2[2] = {0x00, 0x20};
+	static const u32 g_idxattc1[2] = {0x3, 0x2};
+	static const u32 g_idxrxagc[2] = {0x0, 0x2};
+	static const u32 g_idx[2] = {0x0, 0x2};
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool notready = false;
+	bool kfail = false;
+	u32 rf_18, tmp;
+	u8 gp;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, 0xc);
+	rtw89_write_rf(rtwdev, path, RR_RXK, RR_RXK_SEL2G, 0x1);
+	rf_18 = rtw89_read_rf(rtwdev, path, RR_CFGCH, RFREG_MASK);
+	rtw89_write_rf(rtwdev, path, RR_RSV4, RFREG_MASK, rf_18);
+
+	for (gp = 0x0; gp < 0x2; gp++) {
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_RGM, g_idxrxgain[gp]);
+		rtw89_write_rf(rtwdev, path, RR_RXBB, RR_RXBB_C2G, g_idxattc2[gp]);
+		rtw89_write_rf(rtwdev, path, RR_RXBB, RR_RXBB_C1G, g_idxattc1[gp]);
+
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       0x00000100, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       0x00000010, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       0x00000007, g_idx[gp]);
+		rtw89_write_rf(rtwdev, path, RR_RXKPLL, RFREG_MASK, 0x80013);
+		udelay(100);
+		udelay(100);
+
+		tmp = rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF2, B_IQK_DIF2_RXPI, tmp);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, g_idxrxagc[gp]);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x11);
+
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXAGC);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, rf rxbb  = %x\n", path,
+			    rtw89_read_rf(rtwdev, path, RR_MOD, 0x003c0));
+
+		rtw89_write_rf(rtwdev, path, RR_RXKPLL, RFREG_MASK, 0x80013);
+		udelay(100);
+		udelay(100);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x011);
+
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK);
+		iqk_info->nb_rxcfir[path] =
+			rtw89_phy_read32_mask(rtwdev, R_RXIQC + (path << 8),
+					      MASKDWORD) | 0x2;
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S%x, gp = 0x%x, 0x8%x3c = 0x%x\n", path,
+			    g_idx[gp], 1 << path, iqk_info->nb_rxcfir[path]);
+
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+
+		if (iqk_info->is_nbiqk)
+			break;
+
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXK);
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1,  B_NCTL_N1_CIP, 0x00);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+	}
+
+	if (!notready)
+		kfail = !!rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, B_NCTL_RPT_FLG);
+
+	if (kfail) {
+		iqk_info->nb_txcfir[path] = 0x40000002;
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RES + (path << 8),
+				       B_IQK_RES_RXCFIR, 0x0);
+	}
+	rtw89_write_rf(rtwdev, path, RR_RXK, RR_RXK_SEL2G, 0x0);
+
+	return kfail;
+}
+
+static bool _iqk_5g_rx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
+{
+	static const u32 a_idxrxgain[2] = {0x110, 0x290};
+	static const u32 a_idxattc2[2] = {0x0f, 0x0f};
+	static const u32 a_idxattc1[2] = {0x2, 0x2};
+	static const u32 a_idxrxagc[2] = {0x4, 0x6};
+	static const u32 a_idx[2] = {0x0, 0x2};
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool notready = false;
+	bool kfail = false;
+	u32 rf_18, tmp;
+	u8 gp;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, 0xc);
+	rtw89_write_rf(rtwdev, path, RR_RXK, RR_RXK_SEL5G, 0x1);
+	rf_18 = rtw89_read_rf(rtwdev, path, RR_CFGCH, RFREG_MASK);
+	rtw89_write_rf(rtwdev, path, RR_RSV4, RFREG_MASK, rf_18);
+
+	for (gp = 0x0; gp < 0x2; gp++) {
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_RGM, a_idxrxgain[gp]);
+		rtw89_write_rf(rtwdev, path, RR_RXA2, RR_RXA2_HATT, a_idxattc2[gp]);
+		rtw89_write_rf(rtwdev, path, RR_RXA2, RR_RXA2_CC2, a_idxattc1[gp]);
+
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       0x00000100, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       0x00000010, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       0x00000007, a_idx[gp]);
+		rtw89_write_rf(rtwdev, path, RR_RXKPLL, RFREG_MASK, 0x80013);
+		udelay(100);
+		udelay(100);
+
+		tmp = rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF2, B_IQK_DIF2_RXPI, tmp);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, a_idxrxagc[gp]);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x11);
+
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXAGC);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, rf rxbb  = %x\n", path,
+			    rtw89_read_rf(rtwdev, path, RR_MOD, 0x003c0));
+
+		rtw89_write_rf(rtwdev, path, RR_RXKPLL, RFREG_MASK, 0x80013);
+		udelay(200);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x011);
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK);
+		iqk_info->nb_rxcfir[path] =
+			rtw89_phy_read32_mask(rtwdev, R_RXIQC + (path << 8),
+					      MASKDWORD) | 0x2;
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S%x, gp = 0x%x, 0x8%x3c = 0x%x\n",
+			    path, a_idx[gp], 1 << path, iqk_info->nb_rxcfir[path]);
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+
+		if (iqk_info->is_nbiqk)
+			break;
+
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXK);
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+	}
+
+	if (!notready)
+		kfail = !!rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, B_NCTL_RPT_FLG);
+
+	if (kfail) {
+		iqk_info->nb_txcfir[path] = 0x40000002;
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RES + (path << 8),
+				       B_IQK_RES_RXCFIR, 0x0);
+	}
+	rtw89_write_rf(rtwdev, path, RR_RXK, RR_RXK_SEL2G, 0x0);
+
+	return kfail;
+}
+
+static void _iqk_by_path(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool lok_result = false;
+	bool txk_result = false;
+	bool rxk_result = false;
+	u8 i;
+
+	for (i = 0; i < 3; i++) {
+		_iqk_txk_setting(rtwdev, path);
+		if (iqk_info->iqk_band[path] == RTW89_BAND_2G)
+			lok_result = _iqk_2g_lok(rtwdev, phy_idx, path);
+		else
+			lok_result = _iqk_5g_lok(rtwdev, phy_idx, path);
+
+		if (!lok_result)
+			break;
+	}
+
+	if (lok_result) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]!!!!!!!!!!LOK by Pass !!!!!!!!!!!\n");
+		rtw89_write_rf(rtwdev, path, RR_DTXLOK, RFREG_MASK, 0x80200);
+		rtw89_write_rf(rtwdev, path, RR_RSV2, RFREG_MASK, 0x80200);
+		rtw89_write_rf(rtwdev, path, RR_LOKVB, RFREG_MASK, 0x80200);
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]RF_0x08[00:19] = 0x%x\n",
+		    rtw89_read_rf(rtwdev, path, RR_DTXLOK, RFREG_MASK));
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]RF_0x09[00:19] = 0x%x\n",
+		    rtw89_read_rf(rtwdev, path, RR_RSV2, RFREG_MASK));
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]RF_0x0a[00:19] = 0x%x\n",
+		    rtw89_read_rf(rtwdev, path, RR_LOKVB, RFREG_MASK));
+
+	if (iqk_info->iqk_band[path] == RTW89_BAND_2G)
+		txk_result = _iqk_2g_tx(rtwdev, phy_idx, path);
+	else
+		txk_result = _iqk_5g_tx(rtwdev, phy_idx, path);
+
+	_iqk_rxclk_setting(rtwdev, path);
+	_iqk_adc_fifo_rst(rtwdev, phy_idx, path);
+
+	if (iqk_info->iqk_band[path] == RTW89_BAND_2G)
+		rxk_result = _iqk_2g_rx(rtwdev, phy_idx, path);
+	else
+		rxk_result = _iqk_5g_rx(rtwdev, phy_idx, path);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]result  : lok_= %x, txk_= %x, rxk_= %x\n",
+		    lok_result, txk_result, rxk_result);
+}
+
+static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, u8 path)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u8 get_empty_table = false;
+	u32 reg_rf18;
+	u32 reg_35c;
+	u8 idx;
+
+	for (idx = 0; idx < RTW89_IQK_CHS_NR; idx++) {
+		if (iqk_info->iqk_mcc_ch[idx][path] == 0) {
+			get_empty_table = true;
+			break;
+		}
+	}
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] (1)idx = %x\n", idx);
+
+	if (!get_empty_table) {
+		idx = iqk_info->iqk_table_idx[path] + 1;
+		if (idx > 1)
+			idx = 0;
+	}
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] (2)idx = %x\n", idx);
+
+	reg_rf18 = rtw89_read_rf(rtwdev, path, RR_CFGCH, RFREG_MASK);
+	reg_35c = rtw89_phy_read32_mask(rtwdev, R_CIRST, B_CIRST_SYN);
+
+	iqk_info->iqk_band[path] = chan->band_type;
+	iqk_info->iqk_bw[path] = chan->band_width;
+	iqk_info->iqk_ch[path] = chan->channel;
+	iqk_info->iqk_mcc_ch[idx][path] = chan->channel;
+	iqk_info->iqk_table_idx[path] = idx;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x18= 0x%x, idx = %x\n",
+		    path, reg_rf18, idx);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x18= 0x%x\n",
+		    path, reg_rf18);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x35c= 0x%x\n",
+		    path, reg_35c);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]times = 0x%x, ch =%x\n",
+		    iqk_info->iqk_times, idx);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]iqk_mcc_ch[%x][%x] = 0x%x\n",
+		    idx, path, iqk_info->iqk_mcc_ch[idx][path]);
+}
+
+static void _iqk_start_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
+{
+	_iqk_by_path(rtwdev, phy_idx, path);
+}
+
+static void _iqk_restore(struct rtw89_dev *rtwdev, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "===> %s\n", __func__);
+
+	if (iqk_info->is_nbiqk) {
+		rtw89_phy_write32_mask(rtwdev, R_TXIQC + (path << 8),
+				       MASKDWORD, iqk_info->nb_txcfir[path]);
+		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8),
+				       MASKDWORD, iqk_info->nb_rxcfir[path]);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_TXIQC + (path << 8),
+				       MASKDWORD, 0x40000000);
+		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8),
+				       MASKDWORD, 0x40000000);
+	}
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD,
+			       0x00000e19 + (path << 4));
+
+	_iqk_check_cal(rtwdev, path, 0x0);
+
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_RPT, MASKDWORD, 0x00000000);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_SYSCFG, MASKDWORD, 0x80000000);
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_CLK, MASKDWORD, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_IQRSN, B_IQRSN_K2, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_SYS + (path << 8), BIT(28), 0x0);
+
+	rtw89_write_rf(rtwdev, path, RR_LUTWE, RR_LUTWE_LOK, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_LUTWE, RR_LUTWE_LOK, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, 0x3);
+	rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_BBDC, RR_BBDC_SEL, 0x1);
+}
+
+static void _iqk_afebb_restore(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy_idx, u8 path)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "===> %s\n", __func__);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x0303);
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_CLKG_FORCE, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P1_RFCTM, B_P1_CLKG_FORCE, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_TXCKEN_FORCE, B_TXCKEN_FORCE_ALL, 0x0000000);
+	rtw89_phy_write32_mask(rtwdev, R_FAHM, B_RXTD_CKEN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC, B_UPD_GEN_ON, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_TX_COLLISION_T2R_ST, 0x0000001f, 0x03);
+	rtw89_phy_write32_mask(rtwdev, R_TX_COLLISION_T2R_ST, 0x000003e0, 0x03);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK, B_P0_TXCK_ALL, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_P1_RXCK, B_P1_TXCK_ALL, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC,
+			       B_UPD_CLK_ADC_VAL | B_UPD_CLK_ADC_ON, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_RXCCA, B_RXCCA_DIS, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x0000);
+	rtw89_phy_write32_mask(rtwdev, R_P0_ADCFF_EN, B_P0_ADCFF_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P1_ADCFF_EN, B_P1_ADCFF_EN, 0x0);
+}
+
+static void _iqk_preset(struct rtw89_dev *rtwdev, u8 path)
+{
+	u8 idx = 0;
+
+	rtw89_phy_write32_mask(rtwdev, R_COEF_SEL + (path << 8), 0x00000001, idx);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), 0x00000008, idx);
+	rtw89_phy_write32_mask(rtwdev, R_TXIQC + (path << 8), MASKDWORD, 0x40000000);
+	rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8), MASKDWORD, 0x40000000);
+
+	rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_BBDC, RR_BBDC_SEL, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_RPT, MASKDWORD, 0x00000080);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_SYSCFG, MASKDWORD, 0x81ff010a);
+}
+
+static void _iqk_macbb_setting(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy_idx, u8 path)
+{
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x0303);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_GOT_TXRX, 0x3);
+	rtw89_phy_write32_mask(rtwdev, R_P1_RFCTM, B_P1_GOT_TXRX, 0x3);
+	rtw89_phy_write32_mask(rtwdev, R_P0_ADCFF_EN, B_P0_ADCFF_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_ADCFF_EN, B_P1_ADCFF_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_CLKG_FORCE, 0x3);
+	rtw89_phy_write32_mask(rtwdev, R_P1_RFCTM, B_P0_CLKG_FORCE, 0x3);
+	rtw89_phy_write32_mask(rtwdev, R_TXCKEN_FORCE, B_TXCKEN_FORCE_ALL, 0x1ffffff);
+	rtw89_phy_write32_mask(rtwdev, R_FAHM, B_RXTD_CKEN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC, B_UPD_GEN_ON, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_TX_COLLISION_T2R_ST, B_TXRX_FORCE_VAL, 0x3ff);
+	rtw89_phy_write32_mask(rtwdev, R_IOQ_IQK_DPK, B_IOQ_IQK_DPK_CLKEN,  0x3);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DPK_RST, B_IQK_DPK_RST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P0_PATH_RST, B_P0_PATH_RST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_PATH_RST, B_P1_PATH_RST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_RXCCA, B_RXCCA_DIS, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_DCFO_WEIGHT, B_DAC_CLK_IDX, 0x1);
+
+	_txck_force(rtwdev, RF_PATH_A, true, DAC_960M);
+	_txck_force(rtwdev, RF_PATH_B, true, DAC_960M);
+	_rxck_force(rtwdev, RF_PATH_A, true, ADC_1920M);
+	_rxck_force(rtwdev, RF_PATH_B, true, ADC_1920M);
+
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC, B_UPD_CLK_ADC_ON, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC, B_UPD_CLK_ADC_VAL, 0x2);
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x1);
+	udelay(10);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15, 0x1f);
+	udelay(10);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15, 0x13);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_15, 0x0001);
+	udelay(10);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_15, 0x0041);
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_RSTB, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x3333);
+}
+
+static void _iqk_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u8 idx, path;
+
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF, MASKDWORD, 0x0);
+
+	if (iqk_info->is_iqk_init)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+	iqk_info->is_iqk_init = true;
+	iqk_info->is_nbiqk = false;
+	iqk_info->iqk_fft_en = false;
+	iqk_info->iqk_sram_en = false;
+	iqk_info->iqk_cfir_en = false;
+	iqk_info->iqk_xym_en = false;
+	iqk_info->iqk_times = 0x0;
+
+	for (idx = 0; idx < RTW89_IQK_CHS_NR; idx++) {
+		iqk_info->iqk_channel[idx] = 0x0;
+		for (path = 0; path < RTW8852BT_SS; path++) {
+			iqk_info->lok_cor_fail[idx][path] = false;
+			iqk_info->lok_fin_fail[idx][path] = false;
+			iqk_info->iqk_tx_fail[idx][path] = false;
+			iqk_info->iqk_rx_fail[idx][path] = false;
+			iqk_info->iqk_mcc_ch[idx][path] = 0x0;
+			iqk_info->iqk_table_idx[path] = 0x0;
+		}
+	}
+}
+
 static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
 {
 	u32 rf_mode;
@@ -374,6 +1199,57 @@ static void _tmac_tx_pause(struct rtw89_dev *rtwdev, enum rtw89_phy_idx band_idx
 	_wait_rx_mode(rtwdev, _kpath(rtwdev, band_idx));
 }
 
+static void _doiqk(struct rtw89_dev *rtwdev, bool force,
+		   enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u32 backup_bb_val[BACKUP_BB_REGS_NR];
+	u32 backup_rf_val[RTW8852BT_SS][BACKUP_RF_REGS_NR];
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB);
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]==========IQK start!!!!!==========\n");
+	iqk_info->iqk_times++;
+	iqk_info->version = RTW8852BT_IQK_VER;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]Test Ver 0x%x\n", iqk_info->version);
+	_iqk_get_ch_info(rtwdev, phy_idx, path);
+
+	_rfk_backup_bb_reg(rtwdev, backup_bb_val);
+	_rfk_backup_rf_reg(rtwdev, backup_rf_val[path], path);
+	_iqk_macbb_setting(rtwdev, phy_idx, path);
+	_iqk_preset(rtwdev, path);
+	_iqk_start_iqk(rtwdev, phy_idx, path);
+	_iqk_restore(rtwdev, path);
+	_iqk_afebb_restore(rtwdev, phy_idx, path);
+	_rfk_reload_bb_reg(rtwdev, backup_bb_val);
+	_rfk_reload_rf_reg(rtwdev, backup_rf_val[path], path);
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_STOP);
+}
+
+static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool force)
+{
+	u8 kpath = _kpath(rtwdev, phy_idx);
+
+	switch (kpath) {
+	case RF_A:
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_A);
+		break;
+	case RF_B:
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_B);
+		break;
+	case RF_AB:
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_A);
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_B);
+		break;
+	default:
+		break;
+	}
+}
+
 static void _dpk_onoff(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, bool off)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
@@ -2394,6 +3270,22 @@ void rtw8852bt_dpk_init(struct rtw89_dev *rtwdev)
 	_set_dpd_backoff(rtwdev, RTW89_PHY_0);
 }
 
+void rtw8852bt_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u32 tx_en;
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_START);
+	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
+	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
+
+	_iqk_init(rtwdev);
+	_iqk(rtwdev, phy_idx, false);
+
+	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_STOP);
+}
+
 void rtw8852bt_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
index 89640b42d4d0..22c0c9c3d173 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
@@ -7,6 +7,7 @@
 
 #include "core.h"
 
+void rtw8852bt_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8852bt_dpk_init(struct rtw89_dev *rtwdev);
 void rtw8852bt_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
 void rtw8852bt_dpk_track(struct rtw89_dev *rtwdev);
-- 
2.25.1


