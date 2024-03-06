Return-Path: <linux-wireless+bounces-4411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED54F872DA8
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 04:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C9D283195
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 03:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B666114A98;
	Wed,  6 Mar 2024 03:47:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1415AC4
	for <linux-wireless@vger.kernel.org>; Wed,  6 Mar 2024 03:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696847; cv=none; b=Q98LuzvwMJKkaD/mtxaZHj6qMgxatXep4/Fxwmjui38e065tg1By80YWaEVMTZdh9uQKF1jOs0NBNaOt6e5aMef+A0bIVda6DovcNaxnv2WxUKJrHAFzKi6CVtRI5Jd5EnOeAoylNyfgNic6QiuSIm1dH1Zbi7/8Ud0Vkm6L+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696847; c=relaxed/simple;
	bh=hc4Wz+5Pu9xB+cGIkFoYsSAlTkOkaIZbDfNCvPIq8Ho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKSj17Evobh4q/JlPK0KxXOT4SXS9uMc0dr6dVL2SLhX9BKuRXmwcqL/qSBam+OEno9sO2vnWfTscYkYHhy+NDyaSExl2TlfngnCRGv0qSUDx0FiJeA7DWo+6jD/8uSV4rPT6Hw9g2ERaAQlhwERyLVBMXyk/8dPoVDWFja3X2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4263lI151482473, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4263lI151482473
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 11:47:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 11:47:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 11:47:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] wifi: rtw89: 8922a: update chip parameter for coex
Date: Wed, 6 Mar 2024 11:45:57 +0800
Message-ID: <20240306034558.19648-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240306034558.19648-1-pkshih@realtek.com>
References: <20240306034558.19648-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Ching-Te Ku <ku920601@realtek.com>

Implement the chip operation function for 8922a, it related to TX power,
RX gain, antenna position, packet priority and so on. Also assign
coexistence priority table for hardware PTA using. Add settings to avoid
uncertainties propagation when Wi-Fi Rx due to RF gain mismatch.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 948eeb6755fd..0a5dc429b46d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2257,6 +2257,138 @@ static void rtw8922a_btc_init_cfg(struct rtw89_dev *rtwdev)
 	btc->cx.wl.status.map.init_ok = true;
 }
 
+static void
+rtw8922a_btc_set_wl_txpwr_ctrl(struct rtw89_dev *rtwdev, u32 txpwr_val)
+{
+	u16 ctrl_all_time = u32_get_bits(txpwr_val, GENMASK(15, 0));
+	u16 ctrl_gnt_bt = u32_get_bits(txpwr_val, GENMASK(31, 16));
+
+	switch (ctrl_all_time) {
+	case 0xffff:
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_BE_PWR_RATE_CTRL,
+					     B_BE_FORCE_PWR_BY_RATE_EN, 0x0);
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_BE_PWR_RATE_CTRL,
+					     B_BE_FORCE_PWR_BY_RATE_VAL, 0x0);
+		break;
+	default:
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_BE_PWR_RATE_CTRL,
+					     B_BE_FORCE_PWR_BY_RATE_VAL, ctrl_all_time);
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_BE_PWR_RATE_CTRL,
+					     B_BE_FORCE_PWR_BY_RATE_EN, 0x1);
+		break;
+	}
+
+	switch (ctrl_gnt_bt) {
+	case 0xffff:
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_BE_PWR_REG_CTRL,
+					     B_BE_PWR_BT_EN, 0x0);
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_BE_PWR_COEX_CTRL,
+					     B_BE_PWR_BT_VAL, 0x0);
+		break;
+	default:
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_BE_PWR_COEX_CTRL,
+					     B_BE_PWR_BT_VAL, ctrl_gnt_bt);
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_BE_PWR_REG_CTRL,
+					     B_BE_PWR_BT_EN, 0x1);
+		break;
+	}
+}
+
+static
+s8 rtw8922a_btc_get_bt_rssi(struct rtw89_dev *rtwdev, s8 val)
+{
+	return clamp_t(s8, val, -100, 0) + 100;
+}
+
+static const struct rtw89_btc_rf_trx_para rtw89_btc_8922a_rf_ul[] = {
+	{255, 0, 0, 7}, /* 0 -> original */
+	{255, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
+	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 3- >reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 4 ->reserved for shared-antenna */
+	{255, 1, 0, 7}, /* the below id is for non-shared-antenna free-run */
+	{6, 1, 0, 7},
+	{13, 1, 0, 7},
+	{13, 1, 0, 7}
+};
+
+static const struct rtw89_btc_rf_trx_para rtw89_btc_8922a_rf_dl[] = {
+	{255, 0, 0, 7}, /* 0 -> original */
+	{255, 2, 0, 7}, /* 1 -> reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 3- >reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 4 ->reserved for shared-antenna */
+	{255, 1, 0, 7}, /* the below id is for non-shared-antenna free-run */
+	{255, 1, 0, 7},
+	{255, 1, 0, 7},
+	{255, 1, 0, 7}
+};
+
+static const u8 rtw89_btc_8922a_wl_rssi_thres[BTC_WL_RSSI_THMAX] = {60, 50, 40, 30};
+static const u8 rtw89_btc_8922a_bt_rssi_thres[BTC_BT_RSSI_THMAX] = {50, 40, 30, 20};
+
+static const struct rtw89_btc_fbtc_mreg rtw89_btc_8922a_mon_reg[] = {
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe300),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe320),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe324),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe328),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe32c),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe330),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe334),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe338),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe344),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe348),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe34c),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe350),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0x11a2c),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0x11a50),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x980),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x660),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x1660),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x418c),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x518c),
+};
+
+static
+void rtw8922a_btc_update_bt_cnt(struct rtw89_dev *rtwdev)
+{
+	/* Feature move to firmware */
+}
+
+static
+void rtw8922a_btc_wl_s1_standby(struct rtw89_dev *rtwdev, bool state)
+{
+	if (!state) {
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x80000);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD1, RFREG_MASK, 0x0c110);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x01018);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x00000);
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x80000);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD1, RFREG_MASK, 0x0c110);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x01018);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x00000);
+	} else {
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x80000);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD1, RFREG_MASK, 0x0c110);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x09018);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x00000);
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x80000);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD1, RFREG_MASK, 0x0c110);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0x09018);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x00000);
+	}
+}
+
+static void rtw8922a_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
+{
+}
+
 static void rtw8922a_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
 					 struct rtw89_rx_phy_ppdu *phy_ppdu,
 					 struct ieee80211_rx_status *status)
@@ -2367,6 +2499,13 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 
 	.btc_set_rfe		= rtw8922a_btc_set_rfe,
 	.btc_init_cfg		= rtw8922a_btc_init_cfg,
+	.btc_set_wl_pri		= NULL,
+	.btc_set_wl_txpwr_ctrl	= rtw8922a_btc_set_wl_txpwr_ctrl,
+	.btc_get_bt_rssi	= rtw8922a_btc_get_bt_rssi,
+	.btc_update_bt_cnt	= rtw8922a_btc_update_bt_cnt,
+	.btc_wl_s1_standby	= rtw8922a_btc_wl_s1_standby,
+	.btc_set_wl_rx_gain	= rtw8922a_btc_set_wl_rx_gain,
+	.btc_set_policy		= rtw89_btc_set_policy_v1,
 };
 
 const struct rtw89_chip_info rtw8922a_chip_info = {
@@ -2442,6 +2581,16 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.scbd			= 0x1,
 	.mailbox		= 0x1,
 
+	.afh_guard_ch		= 6,
+	.wl_rssi_thres		= rtw89_btc_8922a_wl_rssi_thres,
+	.bt_rssi_thres		= rtw89_btc_8922a_bt_rssi_thres,
+	.rssi_tol		= 2,
+	.mon_reg_num		= ARRAY_SIZE(rtw89_btc_8922a_mon_reg),
+	.mon_reg		= rtw89_btc_8922a_mon_reg,
+	.rf_para_ulink_num	= ARRAY_SIZE(rtw89_btc_8922a_rf_ul),
+	.rf_para_ulink		= rtw89_btc_8922a_rf_ul,
+	.rf_para_dlink_num	= ARRAY_SIZE(rtw89_btc_8922a_rf_dl),
+	.rf_para_dlink		= rtw89_btc_8922a_rf_dl,
 	.ps_mode_supported	= BIT(RTW89_PS_MODE_RFOFF) |
 				  BIT(RTW89_PS_MODE_CLK_GATED) |
 				  BIT(RTW89_PS_MODE_PWR_GATED),
-- 
2.25.1


