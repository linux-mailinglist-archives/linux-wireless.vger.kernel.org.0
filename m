Return-Path: <linux-wireless+bounces-9360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D085911CEC
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE93282143
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE15716B736;
	Fri, 21 Jun 2024 07:35:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BE616B723
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955322; cv=none; b=VqFr/hiTSOo3i+7xRdhRQ64iuih311QMCRVR7WA7YvDy8CJhNnlRwjyyuqiARX9KZE2w5j2SQUZoiPEBQVsgaDw7tzc1KsgxI+7xKHi/u/6T6aPqVX8JuOzVOyLaU6tR77TKb1T56RmPe/Vp12d04pynbuKXbXKtJWYwJJSWU30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955322; c=relaxed/simple;
	bh=W6D3Oa6wCYtzk58Zy8Ggz0VeDI77PPA34LtPoRsxi8w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUI40q4I1rEXifuwpNg76Pww0PmYEISgzu3m21Ake643ae5VuTMo0EyX/628OCKir3VVMmj/Xu/LHguCZ7wJUqnGoMiMdtYsCPEylmOHcfVB3IUS2LTn+5McTJ6FxVeYEGsVoswfYCTyuOWFVGAasD2dl2OcE7PrKArdEhBoS58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45L7ZFUL03868853, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45L7ZFUL03868853
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 15:35:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 15:35:15 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Jun
 2024 15:35:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: 8852bt: rfk: add TSSI
Date: Fri, 21 Jun 2024 15:34:57 +0800
Message-ID: <20240621073458.55187-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621073458.55187-1-pkshih@realtek.com>
References: <20240621073458.55187-1-pkshih@realtek.com>
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

TSSI is transmitter signal strength indication, which is a close-loop
hardware circuit to feedback actual transmitting power as a reference for
next transmission.

It does full calibration when we are going to connect an AP. When switching
bands or channels for scanning or some reasons, reset hardware status to
prevent use wrong power value feedback from previous transmission.

It also loads tables of compensation values reflecting current temperature
into registers according to channel and band group to transmit packets
with expected power.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |    1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.h    |   13 +
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    | 1207 +++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852bt_rfk.h    |   15 +
 .../realtek/rtw89/rtw8852bt_rfk_table.c       |  490 +++++++
 .../realtek/rtw89/rtw8852bt_rfk_table.h       |   38 +
 6 files changed, 1764 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk_table.h

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 5a59234301ca..68236fbc2f9a 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -9010,6 +9010,7 @@
 #define R_IQRSN 0x8220
 #define B_IQRSN_K1 BIT(28)
 #define B_IQRSN_K2 BIT(16)
+#define R_DPD_CH0B 0x82BC
 #define R_RXCFIR_P0C0 0x8D40
 #define R_RXCFIR_P0C1 0x8D84
 #define R_RXCFIR_P0C2 0x8DC8
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.h b/drivers/net/wireless/realtek/rtw89/rtw8852bt.h
new file mode 100644
index 000000000000..6177f36ad667
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2024 Realtek Corporation
+ */
+
+#ifndef __RTW89_8852BT_H__
+#define __RTW89_8852BT_H__
+
+#include "core.h"
+
+#define RF_PATH_NUM_8852BT 2
+#define BB_PATH_NUM_8852BT 2
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
new file mode 100644
index 000000000000..dcc15797f5db
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -0,0 +1,1207 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2024 Realtek Corporation
+ */
+
+#include "coex.h"
+#include "debug.h"
+#include "fw.h"
+#include "mac.h"
+#include "phy.h"
+#include "reg.h"
+#include "rtw8852bt.h"
+#include "rtw8852bt_rfk.h"
+#include "rtw8852bt_rfk_table.h"
+#include "rtw8852b_common.h"
+
+#define RTW8852BT_TSSI_PATH_NR 2
+
+#define _TSSI_DE_MASK GENMASK(21, 12)
+
+static const u32 _tssi_trigger[RTW8852BT_TSSI_PATH_NR] = {0x5820, 0x7820};
+static const u32 _tssi_cw_rpt_addr[RTW8852BT_TSSI_PATH_NR] = {0x1c18, 0x3c18};
+static const u32 _tssi_cw_default_addr[RTW8852BT_TSSI_PATH_NR][4] = {
+	{0x5634, 0x5630, 0x5630, 0x5630},
+	{0x7634, 0x7630, 0x7630, 0x7630} };
+static const u32 _tssi_cw_default_mask[4] = {
+	0x000003ff, 0x3ff00000, 0x000ffc00, 0x000003ff};
+static const u32 _tssi_de_cck_long[RF_PATH_NUM_8852BT] = {0x5858, 0x7858};
+static const u32 _tssi_de_cck_short[RF_PATH_NUM_8852BT] = {0x5860, 0x7860};
+static const u32 _tssi_de_mcs_20m[RF_PATH_NUM_8852BT] = {0x5838, 0x7838};
+static const u32 _tssi_de_mcs_40m[RF_PATH_NUM_8852BT] = {0x5840, 0x7840};
+static const u32 _tssi_de_mcs_80m[RF_PATH_NUM_8852BT] = {0x5848, 0x7848};
+static const u32 _tssi_de_mcs_80m_80m[RF_PATH_NUM_8852BT] = {0x5850, 0x7850};
+static const u32 _tssi_de_mcs_5m[RF_PATH_NUM_8852BT] = {0x5828, 0x7828};
+static const u32 _tssi_de_mcs_10m[RF_PATH_NUM_8852BT] = {0x5830, 0x7830};
+
+static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	u8 val;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]dbcc_en: %x,PHY%d\n",
+		    rtwdev->dbcc_en, phy_idx);
+
+	if (!rtwdev->dbcc_en) {
+		val = RF_AB;
+	} else {
+		if (phy_idx == RTW89_PHY_0)
+			val = RF_A;
+		else
+			val = RF_B;
+	}
+	return val;
+}
+
+static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
+{
+	u32 rf_mode;
+	u8 path;
+	int ret;
+
+	for (path = 0; path < RF_PATH_MAX; path++) {
+		if (!(kpath & BIT(path)))
+			continue;
+
+		ret = read_poll_timeout_atomic(rtw89_read_rf, rf_mode,
+					       rf_mode != 2, 2, 5000, false,
+					       rtwdev, path, RR_MOD, RR_MOD_MASK);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK] Wait S%d to Rx mode!! (ret = %d)\n", path, ret);
+	}
+}
+
+static void _tmac_tx_pause(struct rtw89_dev *rtwdev, enum rtw89_phy_idx band_idx,
+			   bool is_pause)
+{
+	if (!is_pause)
+		return;
+
+	_wait_rx_mode(rtwdev, _kpath(rtwdev, band_idx));
+}
+
+static void _tssi_dpk_off(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A, BIT(24), 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_DPD_CH0B, BIT(24), 0x0);
+}
+
+static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			     enum rtw89_rf_path path)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
+
+	if (band == RTW89_BAND_2G)
+		rtw89_write_rf(rtwdev, path, RR_TXPOW, RR_TXPOW_TXG, 0x1);
+	else
+		rtw89_write_rf(rtwdev, path, RR_TXPOW, RR_TXPOW_TXA, 0x1);
+}
+
+static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			  enum rtw89_rf_path path)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
+
+	rtw89_rfk_parser(rtwdev, &rtw8852bt_tssi_sys_defs_tbl);
+
+	if (chan->band_width == RTW89_CHANNEL_WIDTH_80)
+		rtw89_phy_write32_mask(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_BW80, 0x1);
+	else
+		rtw89_phy_write32_mask(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_BW80, 0x0);
+
+	if (path == RF_PATH_A)
+		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
+					 &rtw8852bt_tssi_sys_a_defs_2g_tbl,
+					 &rtw8852bt_tssi_sys_a_defs_5g_tbl);
+	else
+		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
+					 &rtw8852bt_tssi_sys_b_defs_2g_tbl,
+					 &rtw8852bt_tssi_sys_b_defs_5g_tbl);
+}
+
+static void _tssi_ini_txpwr_ctrl_bb(struct rtw89_dev *rtwdev,
+				    enum rtw89_phy_idx phy,
+				    enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852bt_tssi_init_txpwr_defs_a_tbl,
+				 &rtw8852bt_tssi_init_txpwr_defs_b_tbl);
+}
+
+static void _tssi_ini_txpwr_ctrl_bb_he_tb(struct rtw89_dev *rtwdev,
+					  enum rtw89_phy_idx phy,
+					  enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852bt_tssi_init_txpwr_he_tb_defs_a_tbl,
+				 &rtw8852bt_tssi_init_txpwr_he_tb_defs_b_tbl);
+}
+
+static void _tssi_set_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			  enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852bt_tssi_dck_defs_a_tbl,
+				 &rtw8852bt_tssi_dck_defs_b_tbl);
+}
+
+static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				 enum rtw89_rf_path path)
+{
+#define RTW8852BT_TSSI_GET_VAL(ptr, idx)			\
+({							\
+	s8 *__ptr = (ptr);				\
+	u8 __idx = (idx), __i, __v;			\
+	u32 __val = 0;					\
+	for (__i = 0; __i < 4; __i++) {			\
+		__v = (__ptr[__idx + __i]);		\
+		__val |= (__v << (8 * __i));		\
+	}						\
+	__val;						\
+})
+	struct rtw89_fw_txpwr_track_cfg *trk = rtwdev->fw.elm_info.txpwr_trk;
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
+	u8 subband = chan->subband_type;
+	const s8 *thm_up_a = NULL;
+	const s8 *thm_down_a = NULL;
+	const s8 *thm_up_b = NULL;
+	const s8 *thm_down_b = NULL;
+	u8 thermal = 0xff;
+	s8 thm_ofst[64] = {0};
+	u32 tmp = 0;
+	u8 i, j;
+
+	switch (subband) {
+	default:
+	case RTW89_CH_2G:
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_P][0];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_N][0];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_P][0];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_N][0];
+		break;
+	case RTW89_CH_5G_BAND_1:
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][0];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][0];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][0];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][0];
+		break;
+	case RTW89_CH_5G_BAND_3:
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][1];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][1];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][1];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][1];
+		break;
+	case RTW89_CH_5G_BAND_4:
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][2];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][2];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][2];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][2];
+		break;
+	}
+
+	if (path == RF_PATH_A) {
+		thermal = tssi_info->thermal[RF_PATH_A];
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI] ch=%d thermal_pathA=0x%x\n", ch, thermal);
+
+		rtw89_phy_write32_mask(rtwdev, R_P0_TMETER, B_P0_TMETER_DIS, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TMETER, B_P0_TMETER_TRK, 0x1);
+
+		if (thermal == 0xff) {
+			rtw89_phy_write32_mask(rtwdev, R_P0_TMETER, B_P0_TMETER, 32);
+			rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_VAL, 32);
+
+			for (i = 0; i < 64; i += 4) {
+				rtw89_phy_write32(rtwdev, R_P0_TSSI_BASE + i, 0x0);
+
+				rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+					    "[TSSI] write 0x%x val=0x%08x\n",
+					    R_P0_TSSI_BASE + i, 0x0);
+			}
+
+		} else {
+			rtw89_phy_write32_mask(rtwdev, R_P0_TMETER, B_P0_TMETER,
+					       thermal);
+			rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_VAL,
+					       thermal);
+
+			i = 0;
+			for (j = 0; j < 32; j++)
+				thm_ofst[j] = i < DELTA_SWINGIDX_SIZE ?
+					      -thm_down_a[i++] :
+					      -thm_down_a[DELTA_SWINGIDX_SIZE - 1];
+
+			i = 1;
+			for (j = 63; j >= 32; j--)
+				thm_ofst[j] = i < DELTA_SWINGIDX_SIZE ?
+					      thm_up_a[i++] :
+					      thm_up_a[DELTA_SWINGIDX_SIZE - 1];
+
+			for (i = 0; i < 64; i += 4) {
+				tmp = RTW8852BT_TSSI_GET_VAL(thm_ofst, i);
+				rtw89_phy_write32(rtwdev, R_P0_TSSI_BASE + i, tmp);
+
+				rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+					    "[TSSI] write 0x%x val=0x%08x\n",
+					    0x5c00 + i, tmp);
+			}
+		}
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, R_P0_RFCTM_RDY, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, R_P0_RFCTM_RDY, 0x0);
+
+	} else {
+		thermal = tssi_info->thermal[RF_PATH_B];
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI] ch=%d thermal_pathB=0x%x\n", ch, thermal);
+
+		rtw89_phy_write32_mask(rtwdev, R_P1_TMETER, B_P1_TMETER_DIS, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_P1_TMETER, B_P1_TMETER_TRK, 0x1);
+
+		if (thermal == 0xff) {
+			rtw89_phy_write32_mask(rtwdev, R_P1_TMETER, B_P1_TMETER, 32);
+			rtw89_phy_write32_mask(rtwdev, R_P1_RFCTM, B_P1_RFCTM_VAL, 32);
+
+			for (i = 0; i < 64; i += 4) {
+				rtw89_phy_write32(rtwdev, R_TSSI_THOF + i, 0x0);
+
+				rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+					    "[TSSI] write 0x%x val=0x%08x\n",
+					    0x7c00 + i, 0x0);
+			}
+
+		} else {
+			rtw89_phy_write32_mask(rtwdev, R_P1_TMETER, B_P1_TMETER,
+					       thermal);
+			rtw89_phy_write32_mask(rtwdev, R_P1_RFCTM, B_P1_RFCTM_VAL,
+					       thermal);
+
+			i = 0;
+			for (j = 0; j < 32; j++)
+				thm_ofst[j] = i < DELTA_SWINGIDX_SIZE ?
+					      -thm_down_b[i++] :
+					      -thm_down_b[DELTA_SWINGIDX_SIZE - 1];
+
+			i = 1;
+			for (j = 63; j >= 32; j--)
+				thm_ofst[j] = i < DELTA_SWINGIDX_SIZE ?
+					      thm_up_b[i++] :
+					      thm_up_b[DELTA_SWINGIDX_SIZE - 1];
+
+			for (i = 0; i < 64; i += 4) {
+				tmp = RTW8852BT_TSSI_GET_VAL(thm_ofst, i);
+				rtw89_phy_write32(rtwdev, R_TSSI_THOF + i, tmp);
+
+				rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+					    "[TSSI] write 0x%x val=0x%08x\n",
+					    0x7c00 + i, tmp);
+			}
+		}
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFCTM, R_P1_RFCTM_RDY, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFCTM, R_P1_RFCTM_RDY, 0x0);
+	}
+#undef RTW8852BT_TSSI_GET_VAL
+}
+
+static void _tssi_set_dac_gain_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				   enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852bt_tssi_dac_gain_defs_a_tbl,
+				 &rtw8852bt_tssi_dac_gain_defs_b_tbl);
+}
+
+static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				enum rtw89_rf_path path)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
+
+	if (path == RF_PATH_A)
+		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
+					 &rtw8852bt_tssi_slope_a_defs_2g_tbl,
+					 &rtw8852bt_tssi_slope_a_defs_5g_tbl);
+	else
+		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
+					 &rtw8852bt_tssi_slope_b_defs_2g_tbl,
+					 &rtw8852bt_tssi_slope_b_defs_5g_tbl);
+}
+
+static void _tssi_alignment_default(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				    enum rtw89_rf_path path, bool all)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
+	const struct rtw89_rfk_tbl *tbl = NULL;
+	u8 ch = chan->channel;
+
+	if (path == RF_PATH_A) {
+		if (band == RTW89_BAND_2G)
+			tbl = &rtw8852bt_tssi_align_a_2g_all_defs_tbl;
+		else if (ch >= 36 && ch <= 64)
+			tbl = &rtw8852bt_tssi_align_a_5g1_all_defs_tbl;
+		else if (ch >= 100 && ch <= 144)
+			tbl = &rtw8852bt_tssi_align_a_5g2_all_defs_tbl;
+		else if (ch >= 149 && ch <= 177)
+			tbl = &rtw8852bt_tssi_align_a_5g3_all_defs_tbl;
+	} else {
+		if (ch >= 1 && ch <= 14)
+			tbl = &rtw8852bt_tssi_align_b_2g_all_defs_tbl;
+		else if (ch >= 36 && ch <= 64)
+			tbl = &rtw8852bt_tssi_align_b_5g1_all_defs_tbl;
+		else if (ch >= 100 && ch <= 144)
+			tbl = &rtw8852bt_tssi_align_b_5g2_all_defs_tbl;
+		else if (ch >= 149 && ch <= 177)
+			tbl = &rtw8852bt_tssi_align_b_5g3_all_defs_tbl;
+	}
+
+	if (tbl)
+		rtw89_rfk_parser(rtwdev, tbl);
+}
+
+static void _tssi_set_tssi_slope(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				 enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852bt_tssi_slope_defs_a_tbl,
+				 &rtw8852bt_tssi_slope_defs_b_tbl);
+}
+
+static void _tssi_set_tssi_track(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				 enum rtw89_rf_path path)
+{
+	if (path == RF_PATH_A)
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSIC, B_P0_TSSIC_BYPASS, 0x0);
+	else
+		rtw89_phy_write32_mask(rtwdev, R_P1_TSSIC, B_P1_TSSIC_BYPASS, 0x0);
+}
+
+static void _tssi_set_txagc_offset_mv_avg(struct rtw89_dev *rtwdev,
+					  enum rtw89_phy_idx phy,
+					  enum rtw89_rf_path path)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "======>%s   path=%d\n", __func__,
+		    path);
+
+	if (path == RF_PATH_A)
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_MV_AVG,
+				       B_P0_TSSI_MV_MIX, 0x010);
+	else
+		rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_MV_AVG,
+				       B_P1_RFCTM_DEL, 0x010);
+}
+
+static void _tssi_enable(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	u8 i;
+
+	for (i = 0; i < RF_PATH_NUM_8852BT; i++) {
+		_tssi_set_tssi_track(rtwdev, phy, i);
+		_tssi_set_txagc_offset_mv_avg(rtwdev, phy, i);
+
+		if (i == RF_PATH_A) {
+			rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_MV_AVG,
+					       B_P0_TSSI_MV_CLR, 0x0);
+			rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_AVG,
+					       B_P0_TSSI_EN, 0x0);
+			rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_AVG,
+					       B_P0_TSSI_EN, 0x1);
+			rtw89_write_rf(rtwdev, i, RR_TXGA_V1,
+				       RR_TXGA_V1_TRK_EN, 0x1);
+			rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK,
+					       B_P0_TSSI_RFC, 0x3);
+
+			rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK,
+					       B_P0_TSSI_OFT, 0xc0);
+			rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK,
+					       B_P0_TSSI_OFT_EN, 0x0);
+			rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK,
+					       B_P0_TSSI_OFT_EN, 0x1);
+
+			rtwdev->is_tssi_mode[RF_PATH_A] = true;
+		} else {
+			rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_MV_AVG,
+					       B_P1_TSSI_MV_CLR, 0x0);
+			rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_AVG,
+					       B_P1_TSSI_EN, 0x0);
+			rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_AVG,
+					       B_P1_TSSI_EN, 0x1);
+			rtw89_write_rf(rtwdev, i, RR_TXGA_V1,
+				       RR_TXGA_V1_TRK_EN, 0x1);
+			rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK,
+					       B_P1_TSSI_RFC, 0x3);
+
+			rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK,
+					       B_P1_TSSI_OFT, 0xc0);
+			rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK,
+					       B_P1_TSSI_OFT_EN, 0x0);
+			rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK,
+					       B_P1_TSSI_OFT_EN, 0x1);
+
+			rtwdev->is_tssi_mode[RF_PATH_B] = true;
+		}
+	}
+}
+
+static void _tssi_disable(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_AVG, B_P0_TSSI_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_RFC, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_MV_AVG, B_P0_TSSI_MV_CLR, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_AVG, B_P1_TSSI_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_RFC, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_MV_AVG, B_P1_TSSI_MV_CLR, 0x1);
+
+	rtwdev->is_tssi_mode[RF_PATH_A] = false;
+	rtwdev->is_tssi_mode[RF_PATH_B] = false;
+}
+
+static u32 _tssi_get_cck_group(struct rtw89_dev *rtwdev, u8 ch)
+{
+	switch (ch) {
+	case 1 ... 2:
+		return 0;
+	case 3 ... 5:
+		return 1;
+	case 6 ... 8:
+		return 2;
+	case 9 ... 11:
+		return 3;
+	case 12 ... 13:
+		return 4;
+	case 14:
+		return 5;
+	}
+
+	return 0;
+}
+
+#define TSSI_EXTRA_GROUP_BIT (BIT(31))
+#define TSSI_EXTRA_GROUP(idx) (TSSI_EXTRA_GROUP_BIT | (idx))
+#define IS_TSSI_EXTRA_GROUP(group) ((group) & TSSI_EXTRA_GROUP_BIT)
+#define TSSI_EXTRA_GET_GROUP_IDX1(group) ((group) & ~TSSI_EXTRA_GROUP_BIT)
+#define TSSI_EXTRA_GET_GROUP_IDX2(group) (TSSI_EXTRA_GET_GROUP_IDX1(group) + 1)
+
+static u32 _tssi_get_ofdm_group(struct rtw89_dev *rtwdev, u8 ch)
+{
+	switch (ch) {
+	case 1 ... 2:
+		return 0;
+	case 3 ... 5:
+		return 1;
+	case 6 ... 8:
+		return 2;
+	case 9 ... 11:
+		return 3;
+	case 12 ... 14:
+		return 4;
+	case 36 ... 40:
+		return 5;
+	case 41 ... 43:
+		return TSSI_EXTRA_GROUP(5);
+	case 44 ... 48:
+		return 6;
+	case 49 ... 51:
+		return TSSI_EXTRA_GROUP(6);
+	case 52 ... 56:
+		return 7;
+	case 57 ... 59:
+		return TSSI_EXTRA_GROUP(7);
+	case 60 ... 64:
+		return 8;
+	case 100 ... 104:
+		return 9;
+	case 105 ... 107:
+		return TSSI_EXTRA_GROUP(9);
+	case 108 ... 112:
+		return 10;
+	case 113 ... 115:
+		return TSSI_EXTRA_GROUP(10);
+	case 116 ... 120:
+		return 11;
+	case 121 ... 123:
+		return TSSI_EXTRA_GROUP(11);
+	case 124 ... 128:
+		return 12;
+	case 129 ... 131:
+		return TSSI_EXTRA_GROUP(12);
+	case 132 ... 136:
+		return 13;
+	case 137 ... 139:
+		return TSSI_EXTRA_GROUP(13);
+	case 140 ... 144:
+		return 14;
+	case 149 ... 153:
+		return 15;
+	case 154 ... 156:
+		return TSSI_EXTRA_GROUP(15);
+	case 157 ... 161:
+		return 16;
+	case 162 ... 164:
+		return TSSI_EXTRA_GROUP(16);
+	case 165 ... 169:
+		return 17;
+	case 170 ... 172:
+		return TSSI_EXTRA_GROUP(17);
+	case 173 ... 177:
+		return 18;
+	}
+
+	return 0;
+}
+
+static u32 _tssi_get_trim_group(struct rtw89_dev *rtwdev, u8 ch)
+{
+	switch (ch) {
+	case 1 ... 8:
+		return 0;
+	case 9 ... 14:
+		return 1;
+	case 36 ... 48:
+		return 2;
+	case 52 ... 64:
+		return 3;
+	case 100 ... 112:
+		return 4;
+	case 116 ... 128:
+		return 5;
+	case 132 ... 144:
+		return 6;
+	case 149 ... 177:
+		return 7;
+	}
+
+	return 0;
+}
+
+static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			    enum rtw89_rf_path path)
+{
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
+	u32 gidx, gidx_1st, gidx_2nd;
+	s8 de_1st;
+	s8 de_2nd;
+	s8 val;
+
+	gidx = _tssi_get_ofdm_group(rtwdev, ch);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+		    "[TSSI][TRIM]: path=%d mcs group_idx=0x%x\n", path, gidx);
+
+	if (IS_TSSI_EXTRA_GROUP(gidx)) {
+		gidx_1st = TSSI_EXTRA_GET_GROUP_IDX1(gidx);
+		gidx_2nd = TSSI_EXTRA_GET_GROUP_IDX2(gidx);
+		de_1st = tssi_info->tssi_mcs[path][gidx_1st];
+		de_2nd = tssi_info->tssi_mcs[path][gidx_2nd];
+		val = (de_1st + de_2nd) / 2;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs de=%d 1st=%d 2nd=%d\n",
+			    path, val, de_1st, de_2nd);
+	} else {
+		val = tssi_info->tssi_mcs[path][gidx];
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs de=%d\n", path, val);
+	}
+
+	return val;
+}
+
+static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				 enum rtw89_rf_path path)
+{
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
+	u32 tgidx, tgidx_1st, tgidx_2nd;
+	s8 tde_1st;
+	s8 tde_2nd;
+	s8 val;
+
+	tgidx = _tssi_get_trim_group(rtwdev, ch);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+		    "[TSSI][TRIM]: path=%d mcs trim_group_idx=0x%x\n",
+		    path, tgidx);
+
+	if (IS_TSSI_EXTRA_GROUP(tgidx)) {
+		tgidx_1st = TSSI_EXTRA_GET_GROUP_IDX1(tgidx);
+		tgidx_2nd = TSSI_EXTRA_GET_GROUP_IDX2(tgidx);
+		tde_1st = tssi_info->tssi_trim[path][tgidx_1st];
+		tde_2nd = tssi_info->tssi_trim[path][tgidx_2nd];
+		val = (tde_1st + tde_2nd) / 2;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs trim_de=%d 1st=%d 2nd=%d\n",
+			    path, val, tde_1st, tde_2nd);
+	} else {
+		val = tssi_info->tssi_trim[path][tgidx];
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs trim_de=%d\n",
+			    path, val);
+	}
+
+	return val;
+}
+
+static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
+	u8 gidx;
+	s8 ofdm_de;
+	s8 trim_de;
+	s32 val;
+	u32 i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "[TSSI][TRIM]: phy=%d ch=%d\n",
+		    phy, ch);
+
+	for (i = RF_PATH_A; i < RF_PATH_NUM_8852BT; i++) {
+		gidx = _tssi_get_cck_group(rtwdev, ch);
+		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
+		val = tssi_info->tssi_cck[i][gidx] + trim_de;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d cck[%d]=0x%x trim=0x%x\n",
+			    i, gidx, tssi_info->tssi_cck[i][gidx], trim_de);
+
+		rtw89_phy_write32_mask(rtwdev, _tssi_de_cck_long[i], _TSSI_DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, _tssi_de_cck_short[i], _TSSI_DE_MASK, val);
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI] Set TSSI CCK DE 0x%x[21:12]=0x%x\n",
+			    _tssi_de_cck_long[i],
+			    rtw89_phy_read32_mask(rtwdev, _tssi_de_cck_long[i],
+						  _TSSI_DE_MASK));
+
+		ofdm_de = _tssi_get_ofdm_de(rtwdev, phy, i);
+		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
+		val = ofdm_de + trim_de;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs=0x%x trim=0x%x\n",
+			    i, ofdm_de, trim_de);
+
+		rtw89_phy_write32_mask(rtwdev, _tssi_de_mcs_20m[i], _TSSI_DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, _tssi_de_mcs_40m[i], _TSSI_DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, _tssi_de_mcs_80m[i], _TSSI_DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, _tssi_de_mcs_80m_80m[i],
+				       _TSSI_DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, _tssi_de_mcs_5m[i], _TSSI_DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, _tssi_de_mcs_10m[i], _TSSI_DE_MASK, val);
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI] Set TSSI MCS DE 0x%x[21:12]=0x%x\n",
+			    _tssi_de_mcs_20m[i],
+			    rtw89_phy_read32_mask(rtwdev, _tssi_de_mcs_20m[i],
+						  _TSSI_DE_MASK));
+	}
+}
+
+static void _tssi_alimentk_dump_result(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[TSSI PA K]\n0x%x = 0x%08x\n0x%x = 0x%08x\n0x%x = 0x%08x\n0x%x = 0x%08x\n"
+		    "0x%x = 0x%08x\n0x%x = 0x%08x\n0x%x = 0x%08x\n0x%x = 0x%08x\n",
+		    R_TSSI_PA_K1 + (path << 13),
+		    rtw89_phy_read32(rtwdev, R_TSSI_PA_K1 + (path << 13)),
+		    R_TSSI_PA_K2 + (path << 13),
+		    rtw89_phy_read32(rtwdev, R_TSSI_PA_K2 + (path << 13)),
+		    R_P0_TSSI_ALIM1 + (path << 13),
+		    rtw89_phy_read32(rtwdev, R_P0_TSSI_ALIM1 + (path << 13)),
+		    R_P0_TSSI_ALIM3 + (path << 13),
+		    rtw89_phy_read32(rtwdev, R_P0_TSSI_ALIM3 + (path << 13)),
+		    R_TSSI_PA_K5 + (path << 13),
+		    rtw89_phy_read32(rtwdev, R_TSSI_PA_K5 + (path << 13)),
+		    R_P0_TSSI_ALIM2 + (path << 13),
+		    rtw89_phy_read32(rtwdev, R_P0_TSSI_ALIM2 + (path << 13)),
+		    R_P0_TSSI_ALIM4 + (path << 13),
+		    rtw89_phy_read32(rtwdev, R_P0_TSSI_ALIM4 + (path << 13)),
+		    R_TSSI_PA_K8 + (path << 13),
+		    rtw89_phy_read32(rtwdev, R_TSSI_PA_K8 + (path << 13)));
+}
+
+static void _tssi_alimentk_done(struct rtw89_dev *rtwdev,
+				enum rtw89_phy_idx phy, enum rtw89_rf_path path)
+{
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 channel = chan->channel;
+	u8 band;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "======>%s   phy=%d   path=%d\n", __func__, phy, path);
+
+	if (channel >= 1 && channel <= 14)
+		band = TSSI_ALIMK_2G;
+	else if (channel >= 36 && channel <= 64)
+		band = TSSI_ALIMK_5GL;
+	else if (channel >= 100 && channel <= 144)
+		band = TSSI_ALIMK_5GM;
+	else if (channel >= 149 && channel <= 177)
+		band = TSSI_ALIMK_5GH;
+	else
+		band = TSSI_ALIMK_2G;
+
+	if (tssi_info->alignment_done[path][band]) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ALIM1 + (path << 13), MASKDWORD,
+				       tssi_info->alignment_value[path][band][0]);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ALIM3 + (path << 13), MASKDWORD,
+				       tssi_info->alignment_value[path][band][1]);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ALIM2 + (path << 13), MASKDWORD,
+				       tssi_info->alignment_value[path][band][2]);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ALIM4 + (path << 13), MASKDWORD,
+				       tssi_info->alignment_value[path][band][3]);
+	}
+
+	_tssi_alimentk_dump_result(rtwdev, path);
+}
+
+static void _tssi_hw_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			enum rtw89_rf_path path, u16 cnt, u16 period, s16 pwr_dbm,
+			u8 enable)
+{
+	enum rtw89_rf_path_bit rx_path;
+
+	if (path == RF_PATH_A)
+		rx_path = RF_A;
+	else if (path == RF_PATH_B)
+		rx_path = RF_B;
+	else if (path == RF_PATH_AB)
+		rx_path = RF_AB;
+	else
+		rx_path = RF_ABCD; /* don't change path, but still set others */
+
+	if (enable) {
+		rtw8852bx_bb_set_plcp_tx(rtwdev);
+		rtw8852bx_bb_cfg_tx_path(rtwdev, path);
+		rtw8852bx_bb_ctrl_rx_path(rtwdev, rx_path);
+		rtw8852bx_bb_set_power(rtwdev, pwr_dbm, phy);
+	}
+
+	rtw8852bx_bb_set_pmac_pkt_tx(rtwdev, enable, cnt, period, 20, phy);
+}
+
+static void _tssi_backup_bb_registers(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_idx phy, const u32 reg[],
+				      u32 reg_backup[], u32 reg_num)
+{
+	u32 i;
+
+	for (i = 0; i < reg_num; i++) {
+		reg_backup[i] = rtw89_phy_read32_mask(rtwdev, reg[i], MASKDWORD);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TSSI] Backup BB 0x%x = 0x%x\n", reg[i],
+			    reg_backup[i]);
+	}
+}
+
+static void _tssi_reload_bb_registers(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_idx phy, const u32 reg[],
+				      u32 reg_backup[], u32 reg_num)
+
+{
+	u32 i;
+
+	for (i = 0; i < reg_num; i++) {
+		rtw89_phy_write32_mask(rtwdev, reg[i], MASKDWORD, reg_backup[i]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TSSI] Reload BB 0x%x = 0x%x\n", reg[i],
+			    reg_backup[i]);
+	}
+}
+
+static u8 _tssi_ch_to_idx(struct rtw89_dev *rtwdev, u8 channel)
+{
+	u8 channel_index;
+
+	if (channel >= 1 && channel <= 14)
+		channel_index = channel - 1;
+	else if (channel >= 36 && channel <= 64)
+		channel_index = (channel - 36) / 2 + 14;
+	else if (channel >= 100 && channel <= 144)
+		channel_index = ((channel - 100) / 2) + 15 + 14;
+	else if (channel >= 149 && channel <= 177)
+		channel_index = ((channel - 149) / 2) + 38 + 14;
+	else
+		channel_index = 0;
+
+	return channel_index;
+}
+
+static bool _tssi_get_cw_report(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				enum rtw89_rf_path path, const s16 *power,
+				u32 *tssi_cw_rpt)
+{
+	u32 tx_counter, tx_counter_tmp;
+	const int retry = 100;
+	u32 tmp;
+	int j, k;
+
+	for (j = 0; j < RTW8852BT_TSSI_PATH_NR; j++) {
+		rtw89_phy_write32_mask(rtwdev, _tssi_trigger[path], B_P0_TSSI_EN, 0x0);
+		rtw89_phy_write32_mask(rtwdev, _tssi_trigger[path], B_P0_TSSI_EN, 0x1);
+
+		tx_counter = rtw89_phy_read32_mask(rtwdev, R_TX_COUNTER, MASKLWORD);
+
+		tmp = rtw89_phy_read32_mask(rtwdev, _tssi_trigger[path], MASKDWORD);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TSSI PA K] 0x%x = 0x%08x   path=%d\n",
+			    _tssi_trigger[path], tmp, path);
+
+		if (j == 0)
+			_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], true);
+		else
+			_tssi_hw_tx(rtwdev, phy, RF_PATH_ABCD, 100, 5000, power[j], true);
+
+		tx_counter_tmp = rtw89_phy_read32_mask(rtwdev, R_TX_COUNTER, MASKLWORD);
+		tx_counter_tmp -= tx_counter;
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TSSI PA K] First HWTXcounter=%d path=%d\n",
+			    tx_counter_tmp, path);
+
+		for (k = 0; k < retry; k++) {
+			tmp = rtw89_phy_read32_mask(rtwdev, _tssi_cw_rpt_addr[path],
+						    B_TSSI_CWRPT_RDY);
+			if (tmp)
+				break;
+
+			udelay(30);
+
+			tx_counter_tmp =
+				rtw89_phy_read32_mask(rtwdev, R_TX_COUNTER, MASKLWORD);
+			tx_counter_tmp -= tx_counter;
+
+			rtw89_debug(rtwdev, RTW89_DBG_RFK,
+				    "[TSSI PA K] Flow k = %d HWTXcounter=%d path=%d\n",
+				    k, tx_counter_tmp, path);
+		}
+
+		if (k >= retry) {
+			rtw89_debug(rtwdev, RTW89_DBG_RFK,
+				    "[TSSI PA K] TSSI finish bit k > %d mp:100ms normal:30us path=%d\n",
+				    k, path);
+
+			_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], false);
+			return false;
+		}
+
+		tssi_cw_rpt[j] =
+			rtw89_phy_read32_mask(rtwdev, _tssi_cw_rpt_addr[path],
+					      B_TSSI_CWRPT);
+
+		_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], false);
+
+		tx_counter_tmp = rtw89_phy_read32_mask(rtwdev, R_TX_COUNTER, MASKLWORD);
+		tx_counter_tmp -= tx_counter;
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TSSI PA K] Final HWTXcounter=%d path=%d\n",
+			    tx_counter_tmp, path);
+	}
+
+	return true;
+}
+
+static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			   enum rtw89_rf_path path)
+{
+	static const u32 bb_reg[8] = {0x5820, 0x7820, 0x4978, 0x58e4,
+				      0x78e4, 0x49c0, 0x0d18, 0x0d80};
+	static const s16 power_2g[4] = {48, 20, 4, -8};
+	static const s16 power_5g[4] = {48, 20, 4, 4};
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	s32 tssi_alim_offset_1, tssi_alim_offset_2, tssi_alim_offset_3;
+	u32 tssi_cw_rpt[RTW8852BT_TSSI_PATH_NR] = {};
+	u8 channel = chan->channel;
+	u8 ch_idx = _tssi_ch_to_idx(rtwdev, channel);
+	struct rtw8852bx_bb_tssi_bak tssi_bak;
+	s32 aliment_diff, tssi_cw_default;
+	u32 start_time, finish_time;
+	u32 bb_reg_backup[8] = {};
+	const s16 *power;
+	u8 band;
+	bool ok;
+	u32 tmp;
+	u8 j;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "======> %s   channel=%d   path=%d\n", __func__, channel,
+		    path);
+
+	start_time = ktime_get_ns();
+
+	if (chan->band_type == RTW89_BAND_2G)
+		power = power_2g;
+	else
+		power = power_5g;
+
+	if (channel >= 1 && channel <= 14)
+		band = TSSI_ALIMK_2G;
+	else if (channel >= 36 && channel <= 64)
+		band = TSSI_ALIMK_5GL;
+	else if (channel >= 100 && channel <= 144)
+		band = TSSI_ALIMK_5GM;
+	else if (channel >= 149 && channel <= 177)
+		band = TSSI_ALIMK_5GH;
+	else
+		band = TSSI_ALIMK_2G;
+
+	rtw8852bx_bb_backup_tssi(rtwdev, phy, &tssi_bak);
+	_tssi_backup_bb_registers(rtwdev, phy, bb_reg, bb_reg_backup,
+				  ARRAY_SIZE(bb_reg_backup));
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_AVG, B_P0_TSSI_AVG, 0x8);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_AVG, B_P1_TSSI_AVG, 0x8);
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_MV_AVG, B_P0_TSSI_MV_AVG, 0x2);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_MV_AVG, B_P1_TSSI_MV_AVG, 0x2);
+
+	ok = _tssi_get_cw_report(rtwdev, phy, path, power, tssi_cw_rpt);
+	if (!ok)
+		goto out;
+
+	for (j = 0; j < RTW8852BT_TSSI_PATH_NR; j++) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TSSI PA K] power[%d]=%d  tssi_cw_rpt[%d]=%d\n", j,
+			    power[j], j, tssi_cw_rpt[j]);
+	}
+
+	tmp = rtw89_phy_read32_mask(rtwdev, _tssi_cw_default_addr[path][1],
+				    _tssi_cw_default_mask[1]);
+	tssi_cw_default = sign_extend32(tmp, 8);
+	tssi_alim_offset_1 = tssi_cw_rpt[0] - ((power[0] - power[1]) * 2) -
+			     tssi_cw_rpt[1] + tssi_cw_default;
+	aliment_diff = tssi_alim_offset_1 - tssi_cw_default;
+
+	tmp = rtw89_phy_read32_mask(rtwdev, _tssi_cw_default_addr[path][2],
+				    _tssi_cw_default_mask[2]);
+	tssi_cw_default = sign_extend32(tmp, 8);
+	tssi_alim_offset_2 = tssi_cw_default + aliment_diff;
+
+	tmp = rtw89_phy_read32_mask(rtwdev, _tssi_cw_default_addr[path][3],
+				    _tssi_cw_default_mask[3]);
+	tssi_cw_default = sign_extend32(tmp, 8);
+	tssi_alim_offset_3 = tssi_cw_default + aliment_diff;
+
+	if (path == RF_PATH_A) {
+		tmp = FIELD_PREP(B_P1_TSSI_ALIM11, tssi_alim_offset_1) |
+		      FIELD_PREP(B_P1_TSSI_ALIM12, tssi_alim_offset_2) |
+		      FIELD_PREP(B_P1_TSSI_ALIM13, tssi_alim_offset_3);
+
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ALIM1, B_P0_TSSI_ALIM1, tmp);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ALIM2, B_P0_TSSI_ALIM2, tmp);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TSSI PA K] tssi_alim_offset = 0x%x   0x%x   0x%x   0x%x\n",
+			    rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM3, B_P0_TSSI_ALIM31),
+			    rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM1, B_P0_TSSI_ALIM11),
+			    rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM1, B_P0_TSSI_ALIM12),
+			    rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM1, B_P0_TSSI_ALIM13));
+	} else {
+		tmp = FIELD_PREP(B_P1_TSSI_ALIM11, tssi_alim_offset_1) |
+		      FIELD_PREP(B_P1_TSSI_ALIM12, tssi_alim_offset_2) |
+		      FIELD_PREP(B_P1_TSSI_ALIM13, tssi_alim_offset_3);
+
+		rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_ALIM1, B_P1_TSSI_ALIM1, tmp);
+		rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_ALIM2, B_P1_TSSI_ALIM2, tmp);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TSSI PA K] tssi_alim_offset = 0x%x   0x%x   0x%x   0x%x\n",
+			    rtw89_phy_read32_mask(rtwdev, R_P1_TSSI_ALIM3, B_P1_TSSI_ALIM31),
+			    rtw89_phy_read32_mask(rtwdev, R_P1_TSSI_ALIM1, B_P1_TSSI_ALIM11),
+			    rtw89_phy_read32_mask(rtwdev, R_P1_TSSI_ALIM1, B_P1_TSSI_ALIM12),
+			    rtw89_phy_read32_mask(rtwdev, R_P1_TSSI_ALIM1, B_P1_TSSI_ALIM13));
+	}
+
+	tssi_info->alignment_done[path][band] = true;
+	tssi_info->alignment_value[path][band][0] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM1 + (path << 13), MASKDWORD);
+	tssi_info->alignment_value[path][band][1] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM3 + (path << 13), MASKDWORD);
+	tssi_info->alignment_value[path][band][2] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM2 + (path << 13), MASKDWORD);
+	tssi_info->alignment_value[path][band][3] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM4 + (path << 13), MASKDWORD);
+
+	tssi_info->check_backup_aligmk[path][ch_idx] = true;
+	tssi_info->alignment_backup_by_ch[path][ch_idx][0] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM1 + (path << 13), MASKDWORD);
+	tssi_info->alignment_backup_by_ch[path][ch_idx][1] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM3 + (path << 13), MASKDWORD);
+	tssi_info->alignment_backup_by_ch[path][ch_idx][2] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM2 + (path << 13), MASKDWORD);
+	tssi_info->alignment_backup_by_ch[path][ch_idx][3] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM4 + (path << 13), MASKDWORD);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[TSSI PA K] tssi_info->alignment_value[path=%d][band=%d][0], 0x%x = 0x%08x\n",
+		    path, band, R_P0_TSSI_ALIM1 + (path << 13),
+		    tssi_info->alignment_value[path][band][0]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[TSSI PA K] tssi_info->alignment_value[path=%d][band=%d][1], 0x%x = 0x%08x\n",
+		    path, band, R_P0_TSSI_ALIM3 + (path << 13),
+		    tssi_info->alignment_value[path][band][1]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[TSSI PA K] tssi_info->alignment_value[path=%d][band=%d][2], 0x%x = 0x%08x\n",
+		    path, band, R_P0_TSSI_ALIM2 + (path << 13),
+		    tssi_info->alignment_value[path][band][2]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[TSSI PA K] tssi_info->alignment_value[path=%d][band=%d][3], 0x%x = 0x%08x\n",
+		    path, band, R_P0_TSSI_ALIM4 + (path << 13),
+		    tssi_info->alignment_value[path][band][3]);
+
+out:
+	_tssi_reload_bb_registers(rtwdev, phy, bb_reg, bb_reg_backup,
+				  ARRAY_SIZE(bb_reg_backup));
+	rtw8852bx_bb_restore_tssi(rtwdev, phy, &tssi_bak);
+	rtw8852bx_bb_tx_mode_switch(rtwdev, phy, 0);
+
+	finish_time = ktime_get_ns();
+	tssi_info->tssi_alimk_time += finish_time - start_time;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[TSSI PA K] %s processing time = %d ms\n", __func__,
+		    tssi_info->tssi_alimk_time);
+}
+
+void rtw8852bt_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en)
+{
+	static const u32 reg[2] = {R_DPD_CH0A, R_DPD_CH0B};
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, RF_AB);
+	u32 reg_backup[2] = {};
+	u32 tx_en;
+	u8 i;
+
+	_tssi_backup_bb_registers(rtwdev, phy, reg, reg_backup, 2);
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "[TSSI] %s: phy=%d\n", __func__, phy);
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
+
+	_tssi_dpk_off(rtwdev, phy);
+	_tssi_disable(rtwdev, phy);
+
+	for (i = RF_PATH_A; i < RF_PATH_NUM_8852BT; i++) {
+		_tssi_rf_setting(rtwdev, phy, i);
+		_tssi_set_sys(rtwdev, phy, i);
+		_tssi_ini_txpwr_ctrl_bb(rtwdev, phy, i);
+		_tssi_ini_txpwr_ctrl_bb_he_tb(rtwdev, phy, i);
+		_tssi_set_dck(rtwdev, phy, i);
+		_tssi_set_tmeter_tbl(rtwdev, phy, i);
+		_tssi_set_dac_gain_tbl(rtwdev, phy, i);
+		_tssi_slope_cal_org(rtwdev, phy, i);
+		_tssi_alignment_default(rtwdev, phy, i, true);
+		_tssi_set_tssi_slope(rtwdev, phy, i);
+
+		rtw89_chip_stop_sch_tx(rtwdev, phy, &tx_en, RTW89_SCH_TX_SEL_ALL);
+		_tmac_tx_pause(rtwdev, phy, true);
+		if (hwtx_en)
+			_tssi_alimentk(rtwdev, phy, i);
+		_tmac_tx_pause(rtwdev, phy, false);
+		rtw89_chip_resume_sch_tx(rtwdev, phy, tx_en);
+	}
+
+	_tssi_enable(rtwdev, phy);
+	_tssi_set_efuse_to_de(rtwdev, phy);
+
+	_tssi_reload_bb_registers(rtwdev, phy, reg, reg_backup, 2);
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_STOP);
+}
+
+void rtw8852bt_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	u8 channel = chan->channel;
+	u8 band;
+	u32 i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "======>%s   phy=%d  channel=%d\n", __func__, phy, channel);
+
+	if (channel >= 1 && channel <= 14)
+		band = TSSI_ALIMK_2G;
+	else if (channel >= 36 && channel <= 64)
+		band = TSSI_ALIMK_5GL;
+	else if (channel >= 100 && channel <= 144)
+		band = TSSI_ALIMK_5GM;
+	else if (channel >= 149 && channel <= 177)
+		band = TSSI_ALIMK_5GH;
+	else
+		band = TSSI_ALIMK_2G;
+
+	_tssi_disable(rtwdev, phy);
+
+	for (i = RF_PATH_A; i < RTW8852BT_TSSI_PATH_NR; i++) {
+		_tssi_rf_setting(rtwdev, phy, i);
+		_tssi_set_sys(rtwdev, phy, i);
+		_tssi_set_tmeter_tbl(rtwdev, phy, i);
+
+		if (tssi_info->alignment_done[i][band])
+			_tssi_alimentk_done(rtwdev, phy, i);
+		else
+			_tssi_alignment_default(rtwdev, phy, i, true);
+	}
+
+	_tssi_enable(rtwdev, phy);
+	_tssi_set_efuse_to_de(rtwdev, phy);
+}
+
+static void rtw8852bt_tssi_default_txagc(struct rtw89_dev *rtwdev,
+					 enum rtw89_phy_idx phy, bool enable)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 channel = chan->channel;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "======> %s   ch=%d\n",
+		    __func__, channel);
+
+	if (enable)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "======>%s 1 SCAN_END Set 0x5818[7:0]=0x%x 0x7818[7:0]=0x%x\n",
+		    __func__,
+		    rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_OFT),
+		    rtw89_phy_read32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT));
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_OFT, 0xc0);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT,  0xc0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_OFT_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_OFT_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT_EN, 0x1);
+
+	_tssi_alimentk_done(rtwdev, phy, RF_PATH_A);
+	_tssi_alimentk_done(rtwdev, phy, RF_PATH_B);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "======>%s 2 SCAN_END Set 0x5818[7:0]=0x%x 0x7818[7:0]=0x%x\n",
+		    __func__,
+		    rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_OFT),
+		    rtw89_phy_read32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT));
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "======> %s   SCAN_END\n", __func__);
+}
+
+void rtw8852bt_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
+				enum rtw89_phy_idx phy_idx)
+{
+	if (scan_start)
+		rtw8852bt_tssi_default_txagc(rtwdev, phy_idx, true);
+	else
+		rtw8852bt_tssi_default_txagc(rtwdev, phy_idx, false);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
new file mode 100644
index 000000000000..03fad3abe554
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2024 Realtek Corporation
+ */
+
+#ifndef __RTW89_8852BT_RFK_H__
+#define __RTW89_8852BT_RFK_H__
+
+#include "core.h"
+
+void rtw8852bt_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en);
+void rtw8852bt_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
+void rtw8852bt_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
+				enum rtw89_phy_idx phy_idx);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk_table.c
new file mode 100644
index 000000000000..782144bb7f49
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk_table.c
@@ -0,0 +1,490 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2024 Realtek Corporation
+ */
+
+#include "rtw8852bt_rfk_table.h"
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_sys_defs[] = {
+	RTW89_DECL_RFK_WM(0x12a8, 0x0000000f, 0x4),
+	RTW89_DECL_RFK_WM(0x32a8, 0x0000000f, 0x4),
+	RTW89_DECL_RFK_WM(0x12bc, 0x000ffff0, 0x5555),
+	RTW89_DECL_RFK_WM(0x32bc, 0x000ffff0, 0x5555),
+	RTW89_DECL_RFK_WM(0x0300, 0xff000000, 0x16),
+	RTW89_DECL_RFK_WM(0x0304, 0x000000ff, 0x19),
+	RTW89_DECL_RFK_WM(0x0314, 0xffff0000, 0x2041),
+	RTW89_DECL_RFK_WM(0x0318, 0xffffffff, 0x2041),
+	RTW89_DECL_RFK_WM(0x0318, 0xffffffff, 0x20012041),
+	RTW89_DECL_RFK_WM(0x0020, 0x00006000, 0x3),
+	RTW89_DECL_RFK_WM(0x0024, 0x00006000, 0x3),
+	RTW89_DECL_RFK_WM(0x0704, 0xffff0000, 0x601e),
+	RTW89_DECL_RFK_WM(0x2704, 0xffff0000, 0x601e),
+	RTW89_DECL_RFK_WM(0x0700, 0xf0000000, 0x4),
+	RTW89_DECL_RFK_WM(0x2700, 0xf0000000, 0x4),
+	RTW89_DECL_RFK_WM(0x0650, 0x3c000000, 0x0),
+	RTW89_DECL_RFK_WM(0x2650, 0x3c000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_sys_defs);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_sys_a_defs_2g[] = {
+	RTW89_DECL_RFK_WM(0x120c, 0x000000ff, 0x33),
+	RTW89_DECL_RFK_WM(0x12c0, 0x0ff00000, 0x33),
+	RTW89_DECL_RFK_WM(0x58f8, 0x40000000, 0x1),
+	RTW89_DECL_RFK_WM(0x0304, 0x0000ff00, 0x1e),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_sys_a_defs_2g);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_sys_a_defs_5g[] = {
+	RTW89_DECL_RFK_WM(0x120c, 0x000000ff, 0x44),
+	RTW89_DECL_RFK_WM(0x12c0, 0x0ff00000, 0x44),
+	RTW89_DECL_RFK_WM(0x58f8, 0x40000000, 0x0),
+	RTW89_DECL_RFK_WM(0x0304, 0x0000ff00, 0x1d),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_sys_a_defs_5g);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_sys_b_defs_2g[] = {
+	RTW89_DECL_RFK_WM(0x32c0, 0x0ff00000, 0x33),
+	RTW89_DECL_RFK_WM(0x320c, 0x000000ff, 0x33),
+	RTW89_DECL_RFK_WM(0x78f8, 0x40000000, 0x1),
+	RTW89_DECL_RFK_WM(0x0304, 0x0000ff00, 0x1e),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_sys_b_defs_2g);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_sys_b_defs_5g[] = {
+	RTW89_DECL_RFK_WM(0x32c0, 0x0ff00000, 0x44),
+	RTW89_DECL_RFK_WM(0x320c, 0x000000ff, 0x44),
+	RTW89_DECL_RFK_WM(0x78f8, 0x40000000, 0x0),
+	RTW89_DECL_RFK_WM(0x0304, 0x0000ff00, 0x1d),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_sys_b_defs_5g);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_init_txpwr_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x566c, 0x00001000, 0x0),
+	RTW89_DECL_RFK_WM(0x5800, 0xffffffff, 0x003f807f),
+	RTW89_DECL_RFK_WM(0x580c, 0x0000007f, 0x40),
+	RTW89_DECL_RFK_WM(0x580c, 0x0fffff00, 0x00040),
+	RTW89_DECL_RFK_WM(0x5810, 0xffffffff, 0x59010000),
+	RTW89_DECL_RFK_WM(0x5814, 0x01ffffff, 0x002d000),
+	RTW89_DECL_RFK_WM(0x5814, 0xf8000000, 0x00),
+	RTW89_DECL_RFK_WM(0x5818, 0xffffffff, 0x002c1800),
+	RTW89_DECL_RFK_WM(0x581c, 0x3fffffff, 0x1dc80280),
+	RTW89_DECL_RFK_WM(0x5820, 0xffffffff, 0x00002080),
+	RTW89_DECL_RFK_WM(0x580c, 0x10000000, 0x1),
+	RTW89_DECL_RFK_WM(0x580c, 0x40000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5834, 0x3fffffff, 0x000115f2),
+	RTW89_DECL_RFK_WM(0x5838, 0x7fffffff, 0x0000121),
+	RTW89_DECL_RFK_WM(0x5854, 0x3fffffff, 0x000115f2),
+	RTW89_DECL_RFK_WM(0x5858, 0x7fffffff, 0x0000121),
+	RTW89_DECL_RFK_WM(0x5860, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5864, 0x07ffffff, 0x00801ff),
+	RTW89_DECL_RFK_WM(0x5898, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x589c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x58a4, 0x000000ff, 0x16),
+	RTW89_DECL_RFK_WM(0x58b0, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x58b4, 0x7fffffff, 0x0a002000),
+	RTW89_DECL_RFK_WM(0x58b8, 0x7fffffff, 0x00007628),
+	RTW89_DECL_RFK_WM(0x58bc, 0x07ffffff, 0x7a7807f),
+	RTW89_DECL_RFK_WM(0x58c0, 0xfffe0000, 0x003f),
+	RTW89_DECL_RFK_WM(0x58c4, 0xffffffff, 0x0003ffff),
+	RTW89_DECL_RFK_WM(0x58c8, 0x00ffffff, 0x000000),
+	RTW89_DECL_RFK_WM(0x58c8, 0xf0000000, 0x0),
+	RTW89_DECL_RFK_WM(0x58cc, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x58d0, 0x07ffffff, 0x2008101),
+	RTW89_DECL_RFK_WM(0x58d4, 0x000000ff, 0x00),
+	RTW89_DECL_RFK_WM(0x58d4, 0x0003fe00, 0x0ff),
+	RTW89_DECL_RFK_WM(0x58d4, 0x07fc0000, 0x100),
+	RTW89_DECL_RFK_WM(0x58d8, 0xffffffff, 0x8008016c),
+	RTW89_DECL_RFK_WM(0x58dc, 0x0001ffff, 0x0807f),
+	RTW89_DECL_RFK_WM(0x58dc, 0xfff00000, 0xc00),
+	RTW89_DECL_RFK_WM(0x58f0, 0x0003ffff, 0x001ff),
+	RTW89_DECL_RFK_WM(0x58f4, 0x000fffff, 0x000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_init_txpwr_defs_a);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_init_txpwr_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x566c, 0x00001000, 0x0),
+	RTW89_DECL_RFK_WM(0x7800, 0xffffffff, 0x003f807f),
+	RTW89_DECL_RFK_WM(0x780c, 0x0000007f, 0x40),
+	RTW89_DECL_RFK_WM(0x780c, 0x0fffff00, 0x00040),
+	RTW89_DECL_RFK_WM(0x7810, 0xffffffff, 0x59010000),
+	RTW89_DECL_RFK_WM(0x7814, 0x01ffffff, 0x002d000),
+	RTW89_DECL_RFK_WM(0x7814, 0xf8000000, 0x00),
+	RTW89_DECL_RFK_WM(0x7818, 0xffffffff, 0x002c1800),
+	RTW89_DECL_RFK_WM(0x781c, 0x3fffffff, 0x1dc80280),
+	RTW89_DECL_RFK_WM(0x7820, 0xffffffff, 0x00002080),
+	RTW89_DECL_RFK_WM(0x780c, 0x10000000, 0x1),
+	RTW89_DECL_RFK_WM(0x780c, 0x40000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7834, 0x3fffffff, 0x000115f2),
+	RTW89_DECL_RFK_WM(0x7838, 0x7fffffff, 0x0000121),
+	RTW89_DECL_RFK_WM(0x7854, 0x3fffffff, 0x000115f2),
+	RTW89_DECL_RFK_WM(0x7858, 0x7fffffff, 0x0000121),
+	RTW89_DECL_RFK_WM(0x7860, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0x7864, 0x07ffffff, 0x00801ff),
+	RTW89_DECL_RFK_WM(0x7898, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x789c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x78a4, 0x000000ff, 0x16),
+	RTW89_DECL_RFK_WM(0x78b0, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x78b4, 0x7fffffff, 0x0a002000),
+	RTW89_DECL_RFK_WM(0x78b8, 0x7fffffff, 0x00007628),
+	RTW89_DECL_RFK_WM(0x78bc, 0x07ffffff, 0x7a7807f),
+	RTW89_DECL_RFK_WM(0x78c0, 0xfffe0000, 0x003f),
+	RTW89_DECL_RFK_WM(0x78c4, 0xffffffff, 0x0003ffff),
+	RTW89_DECL_RFK_WM(0x78c8, 0x00ffffff, 0x000000),
+	RTW89_DECL_RFK_WM(0x78c8, 0xf0000000, 0x0),
+	RTW89_DECL_RFK_WM(0x78cc, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x78d0, 0x07ffffff, 0x2008101),
+	RTW89_DECL_RFK_WM(0x78d4, 0x000000ff, 0x00),
+	RTW89_DECL_RFK_WM(0x78d4, 0x0003fe00, 0x0ff),
+	RTW89_DECL_RFK_WM(0x78d4, 0x07fc0000, 0x100),
+	RTW89_DECL_RFK_WM(0x78d8, 0xffffffff, 0x8008016c),
+	RTW89_DECL_RFK_WM(0x78dc, 0x0001ffff, 0x0807f),
+	RTW89_DECL_RFK_WM(0x78dc, 0xfff00000, 0xc00),
+	RTW89_DECL_RFK_WM(0x78f0, 0x0003ffff, 0x001ff),
+	RTW89_DECL_RFK_WM(0x78f4, 0x000fffff, 0x000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_init_txpwr_defs_b);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_init_txpwr_he_tb_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x58a0, 0xffffffff, 0x000000fe),
+	RTW89_DECL_RFK_WM(0x58e4, 0x0000007f, 0x1f),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_init_txpwr_he_tb_defs_a);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_init_txpwr_he_tb_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x78a0, 0xffffffff, 0x000000fe),
+	RTW89_DECL_RFK_WM(0x78e4, 0x0000007f, 0x1f),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_init_txpwr_he_tb_defs_b);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_dck_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x580c, 0x0fff0000, 0x000),
+	RTW89_DECL_RFK_WM(0x5814, 0x003ff000, 0x0ef),
+	RTW89_DECL_RFK_WM(0x5814, 0x18000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_dck_defs_a);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_dck_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x780c, 0x0fff0000, 0x000),
+	RTW89_DECL_RFK_WM(0x7814, 0x003ff000, 0x0ef),
+	RTW89_DECL_RFK_WM(0x7814, 0x18000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_dck_defs_b);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_dac_gain_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x58b0, 0x00000400, 0x1),
+	RTW89_DECL_RFK_WM(0x58b0, 0x00000fff, 0x000),
+	RTW89_DECL_RFK_WM(0x58b0, 0x00000800, 0x1),
+	RTW89_DECL_RFK_WM(0x5a00, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a04, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a08, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a0c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a10, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a14, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a18, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a1c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a20, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a24, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a28, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a2c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a30, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a34, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a38, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a3c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a40, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a44, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a48, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a4c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a50, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a54, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a58, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a5c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a60, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a64, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a68, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a6c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a70, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a74, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a78, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a7c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a80, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a84, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a88, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a8c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a90, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a94, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a98, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a9c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5aa0, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5aa4, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5aa8, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5aac, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5ab0, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5ab4, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5ab8, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5abc, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5ac0, 0xffffffff, 0x00000000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_dac_gain_defs_a);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_dac_gain_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x78b0, 0x00000fff, 0x000),
+	RTW89_DECL_RFK_WM(0x78b0, 0x00000800, 0x1),
+	RTW89_DECL_RFK_WM(0x7a00, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a04, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a08, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a0c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a10, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a14, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a18, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a1c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a20, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a24, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a28, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a2c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a30, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a34, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a38, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a3c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a40, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a44, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a48, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a4c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a50, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a54, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a58, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a5c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a60, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a64, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a68, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a6c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a70, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a74, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a78, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a7c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a80, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a84, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a88, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a8c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a90, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a94, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a98, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a9c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7aa0, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7aa4, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7aa8, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7aac, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7ab0, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7ab4, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7ab8, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7abc, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7ac0, 0xffffffff, 0x00000000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_dac_gain_defs_b);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_slope_a_defs_2g[] = {
+	RTW89_DECL_RFK_WM(0x5608, 0x07ffffff, 0x0801008),
+	RTW89_DECL_RFK_WM(0x560c, 0x07ffffff, 0x0201020),
+	RTW89_DECL_RFK_WM(0x5610, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x5614, 0x07ffffff, 0x0804008),
+	RTW89_DECL_RFK_WM(0x5618, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x561c, 0x000001ff, 0x008),
+	RTW89_DECL_RFK_WM(0x561c, 0xffff0000, 0x0808),
+	RTW89_DECL_RFK_WM(0x5620, 0xffffffff, 0x08081e28),
+	RTW89_DECL_RFK_WM(0x5624, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x5628, 0xffffffff, 0x08081e28),
+	RTW89_DECL_RFK_WM(0x562c, 0x0000ffff, 0x0808),
+	RTW89_DECL_RFK_WM(0x581c, 0x00100000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_slope_a_defs_2g);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_slope_a_defs_5g[] = {
+	RTW89_DECL_RFK_WM(0x5608, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x560c, 0x07ffffff, 0x0201019),
+	RTW89_DECL_RFK_WM(0x5610, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x5614, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x5618, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x561c, 0x000001ff, 0x008),
+	RTW89_DECL_RFK_WM(0x561c, 0xffff0000, 0x0808),
+	RTW89_DECL_RFK_WM(0x5620, 0xffffffff, 0x08081808),
+	RTW89_DECL_RFK_WM(0x5624, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x5628, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x562c, 0x0000ffff, 0x0808),
+	RTW89_DECL_RFK_WM(0x581c, 0x00100000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_slope_a_defs_5g);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_slope_b_defs_2g[] = {
+	RTW89_DECL_RFK_WM(0x7608, 0x07ffffff, 0x0801008),
+	RTW89_DECL_RFK_WM(0x760c, 0x07ffffff, 0x0201020),
+	RTW89_DECL_RFK_WM(0x7610, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x7614, 0x07ffffff, 0x0804008),
+	RTW89_DECL_RFK_WM(0x7618, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x761c, 0x000001ff, 0x008),
+	RTW89_DECL_RFK_WM(0x761c, 0xffff0000, 0x0808),
+	RTW89_DECL_RFK_WM(0x7620, 0xffffffff, 0x08081e28),
+	RTW89_DECL_RFK_WM(0x7624, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x7628, 0xffffffff, 0x08081e28),
+	RTW89_DECL_RFK_WM(0x762c, 0x0000ffff, 0x0808),
+	RTW89_DECL_RFK_WM(0x781c, 0x00100000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_slope_b_defs_2g);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_slope_b_defs_5g[] = {
+	RTW89_DECL_RFK_WM(0x7608, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x760c, 0x07ffffff, 0x0201019),
+	RTW89_DECL_RFK_WM(0x7610, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x7614, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x7618, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x761c, 0x000001ff, 0x008),
+	RTW89_DECL_RFK_WM(0x761c, 0xffff0000, 0x0808),
+	RTW89_DECL_RFK_WM(0x7620, 0xffffffff, 0x08081808),
+	RTW89_DECL_RFK_WM(0x7624, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x7628, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x762c, 0x0000ffff, 0x0808),
+	RTW89_DECL_RFK_WM(0x781c, 0x00100000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_slope_b_defs_5g);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_align_a_2g_all_defs[] = {
+	RTW89_DECL_RFK_WM(0x5604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5600, 0x3fffffff, 0x3f2d2721),
+	RTW89_DECL_RFK_WM(0x5604, 0x003fffff, 0x010101),
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x029f57c0),
+	RTW89_DECL_RFK_WM(0x5634, 0x3fffffff, 0x00000077),
+	RTW89_DECL_RFK_WM(0x5638, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x029f5bc0),
+	RTW89_DECL_RFK_WM(0x5640, 0x3fffffff, 0x00000076),
+	RTW89_DECL_RFK_WM(0x5644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_align_a_2g_all_defs);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_align_a_5g1_all_defs[] = {
+	RTW89_DECL_RFK_WM(0x5604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5600, 0x3fffffff, 0x3f2d2721),
+	RTW89_DECL_RFK_WM(0x5604, 0x003fffff, 0x010101),
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x007ff3d7),
+	RTW89_DECL_RFK_WM(0x5634, 0x3fffffff, 0x00000068),
+	RTW89_DECL_RFK_WM(0x5638, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5640, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_align_a_5g1_all_defs);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_align_a_5g2_all_defs[] = {
+	RTW89_DECL_RFK_WM(0x5604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5600, 0x3fffffff, 0x3f2d2721),
+	RTW89_DECL_RFK_WM(0x5604, 0x003fffff, 0x010101),
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x00a003db),
+	RTW89_DECL_RFK_WM(0x5634, 0x3fffffff, 0x00000065),
+	RTW89_DECL_RFK_WM(0x5638, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5640, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_align_a_5g2_all_defs);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_align_a_5g3_all_defs[] = {
+	RTW89_DECL_RFK_WM(0x5604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5600, 0x3fffffff, 0x3f2d2721),
+	RTW89_DECL_RFK_WM(0x5604, 0x003fffff, 0x010101),
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x01101be2),
+	RTW89_DECL_RFK_WM(0x5634, 0x3fffffff, 0x00000065),
+	RTW89_DECL_RFK_WM(0x5638, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5640, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_align_a_5g3_all_defs);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_align_b_2g_all_defs[] = {
+	RTW89_DECL_RFK_WM(0x7604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7600, 0x3fffffff, 0x3f2d2721),
+	RTW89_DECL_RFK_WM(0x7604, 0x003fffff, 0x010101),
+	RTW89_DECL_RFK_WM(0x7630, 0x3fffffff, 0x023f3fb9),
+	RTW89_DECL_RFK_WM(0x7634, 0x3fffffff, 0x00000075),
+	RTW89_DECL_RFK_WM(0x7638, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x01df3fb8),
+	RTW89_DECL_RFK_WM(0x7640, 0x3fffffff, 0x00000074),
+	RTW89_DECL_RFK_WM(0x7644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_align_b_2g_all_defs);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_align_b_5g1_all_defs[] = {
+	RTW89_DECL_RFK_WM(0x7604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7600, 0x3fffffff, 0x3f2d2721),
+	RTW89_DECL_RFK_WM(0x7604, 0x003fffff, 0x010101),
+	RTW89_DECL_RFK_WM(0x7630, 0x3fffffff, 0x010017e0),
+	RTW89_DECL_RFK_WM(0x7634, 0x3fffffff, 0x00000069),
+	RTW89_DECL_RFK_WM(0x7638, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7640, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_align_b_5g1_all_defs);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_align_b_5g2_all_defs[] = {
+	RTW89_DECL_RFK_WM(0x7604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7600, 0x3fffffff, 0x3f2d2721),
+	RTW89_DECL_RFK_WM(0x7604, 0x003fffff, 0x010101),
+	RTW89_DECL_RFK_WM(0x7630, 0x3fffffff, 0x01201fe2),
+	RTW89_DECL_RFK_WM(0x7634, 0x3fffffff, 0x00000066),
+	RTW89_DECL_RFK_WM(0x7638, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7640, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_align_b_5g2_all_defs);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_align_b_5g3_all_defs[] = {
+	RTW89_DECL_RFK_WM(0x7604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7600, 0x3fffffff, 0x3f2d2721),
+	RTW89_DECL_RFK_WM(0x7604, 0x003fffff, 0x010101),
+	RTW89_DECL_RFK_WM(0x7630, 0x3fffffff, 0x01602fe5),
+	RTW89_DECL_RFK_WM(0x7634, 0x3fffffff, 0x00000068),
+	RTW89_DECL_RFK_WM(0x7638, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7640, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_align_b_5g3_all_defs);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_slope_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x5814, 0x00000800, 0x1),
+	RTW89_DECL_RFK_WM(0x581c, 0x20000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5814, 0x20000000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_slope_defs_a);
+
+static const struct rtw89_reg5_def rtw8852bt_tssi_slope_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x7814, 0x00000800, 0x1),
+	RTW89_DECL_RFK_WM(0x781c, 0x20000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7814, 0x20000000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852bt_tssi_slope_defs_b);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk_table.h
new file mode 100644
index 000000000000..beb246237d17
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk_table.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2024 Realtek Corporation
+ */
+
+#ifndef __RTW89_8852BT_RFK_TABLE_H__
+#define __RTW89_8852BT_RFK_TABLE_H__
+
+#include "phy.h"
+
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_sys_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_sys_a_defs_2g_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_sys_a_defs_5g_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_sys_b_defs_2g_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_sys_b_defs_5g_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_init_txpwr_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_init_txpwr_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_init_txpwr_he_tb_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_init_txpwr_he_tb_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_dck_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_dck_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_dac_gain_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_dac_gain_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_slope_a_defs_2g_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_slope_a_defs_5g_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_slope_b_defs_2g_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_slope_b_defs_5g_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_align_a_2g_all_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_align_a_5g1_all_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_align_a_5g2_all_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_align_a_5g3_all_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_align_b_2g_all_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_align_b_5g1_all_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_align_b_5g2_all_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_align_b_5g3_all_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_slope_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852bt_tssi_slope_defs_b_tbl;
+
+#endif
-- 
2.25.1


