Return-Path: <linux-wireless+bounces-2430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FED83A029
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 04:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADDC61C232C2
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 03:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C4D63AA;
	Wed, 24 Jan 2024 03:37:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D90BE59
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 03:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706067443; cv=none; b=tp4bCV8kK8obJpsVRWs9OUVzXnZwPOwQfRBtn5n7qb/SPXeqs+yFmOKBVcBJefolzlired52TKcGHGo2lCsfNV18r8haLHYjeRDedx6iDoVVVobOry1SBXMFexERpt8ve9ReveBm2ipcBaqd0CswsH4koToNaVXKq7Wyhj3v7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706067443; c=relaxed/simple;
	bh=ChQN2PuePjCmxCx5opnJvc7zP/UOKzPMGFn/sMEtr2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HS6rcmIgjyiPhOMhBrpJXpw/pj7Wm/sbO/o5PuN1wfXIWyynMuDc3L0VqZURVFcNGCNfrLK61liMiVdcpcMxNFZLe2hB4dEp+ob+FblllizD819hIOvq9uuJAH+Ug/w4I1Kjce+icp4L/Cud5NKgfjEEBx3kOHIBi6h+gqtmF3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40O3bDGt9723718, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40O3bDGt9723718
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:37:13 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 24 Jan 2024 11:37:14 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 24 Jan
 2024 11:37:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/6] wifi: rtw89: 8922a: add chip_ops::cfg_txrx_path
Date: Wed, 24 Jan 2024 11:36:34 +0800
Message-ID: <20240124033637.12330-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124033637.12330-1-pkshih@realtek.com>
References: <20240124033637.12330-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

This function is to set TX/RX path. Especially for 1SS rate, it can select
to TX on one or two antenna. Before this operation, stop hardware to
prevent transmitting/receiving unexpected packets. After that, restore
settings and reset hardware to prevent it stays on abnormal state.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  24 ++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 279 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c |  33 +++
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.h |  12 +
 4 files changed, 348 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index bafad1d3e9a1..da7a668c9c16 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7683,9 +7683,23 @@
 #define B_SWSI_READ_ADDR_ADDR_V1 GENMASK(7, 0)
 #define B_SWSI_READ_ADDR_PATH_V1 GENMASK(10, 8)
 #define B_SWSI_READ_ADDR_V1 GENMASK(10, 0)
+#define R_BRK_R 0x0418
+#define B_VHTMCS_LMT GENMASK(22, 21)
+#define B_HTMCS_LMT GENMASK(9, 8)
+#define R_BRK_EHT 0x0474
+#define B_RXEHT_NSS_MAX GENMASK(4, 2)
+#define R_BRK_RXEHT 0x0478
+#define B_RXEHT_N_USER_MAX GENMASK(31, 24)
+#define B_RXEHTTB_NSS_MAX GENMASK(16, 14)
 #define R_EN_SND_WO_NDP 0x047c
 #define R_EN_SND_WO_NDP_C1 0x147c
 #define B_EN_SND_WO_NDP BIT(1)
+#define R_BRK_HE 0x0480
+#define B_TB_NSS_MAX GENMASK(25, 23)
+#define B_NSS_MAX GENMASK(16, 14)
+#define B_N_USR_MAX GENMASK(13, 6)
+#define R_RXCCA_BE1 0x0520
+#define B_RXCCA_BE1_DIS BIT(0)
 #define R_UPD_CLK_ADC 0x0700
 #define B_UPD_CLK_ADC_VAL GENMASK(26, 25)
 #define B_UPD_CLK_ADC_ON BIT(24)
@@ -7732,6 +7746,7 @@
 #define B_PMAC_RXMOD_MSK GENMASK(7, 4)
 #define R_MAC_SEL 0x09A4
 #define B_MAC_SEL_OFDM_TRI_FILTER BIT(31)
+#define B_MAC_SEL GENMASK(19, 17)
 #define B_MAC_SEL_PWR_EN BIT(16)
 #define B_MAC_SEL_DPD_EN BIT(10)
 #define B_MAC_SEL_MOD GENMASK(4, 2)
@@ -7825,6 +7840,8 @@
 #define R_CLK_GCK 0x1008
 #define B_CLK_GCK GENMASK(24, 0)
 #define R_EDCCA_RPT_SEL_BE 0x10CC
+#define R_ADC_FIFO_V1 0x10FC
+#define B_ADC_FIFO_EN_V1 GENMASK(31, 24)
 #define R_S0_HW_SI_DIS 0x1200
 #define B_S0_HW_SI_DIS_W_R_TRIG GENMASK(30, 28)
 #define R_P0_RXCK 0x12A0
@@ -8934,6 +8951,11 @@
 #define R_IQK_DPK_PRST 0xE4AC
 #define R_IQK_DPK_PRST_C1 0xE5AC
 #define B_IQK_DPK_PRST BIT(27)
+#define R_TXPWR_RSTA 0xE60C
+#define B_TXPWR_RSTA BIT(16)
+#define R_TSSI_PWR_P0 0xE610
+#define R_TSSI_PWR_P1 0xE710
+#define B_TSSI_CONT_EN BIT(3)
 #define R_TSSI_MAP_OFST_P0 0xE620
 #define R_TSSI_MAP_OFST_P1 0xE720
 #define B_TSSI_MAP_OFST_OFDM GENMASK(17, 9)
@@ -8946,6 +8968,8 @@
 #define R_TXAGC_REF1_P0 0xE62C
 #define R_TXAGC_REF1_P1 0xE72C
 #define B_TXAGC_REF1_CCK_CW GENMASK(8, 0)
+#define R_TXPWR_RSTB 0xE70C
+#define B_TXPWR_RSTB BIT(16)
 
 /* WiFi CPU local domain */
 #define R_AX_WDT_CTRL 0x0040
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index beac7bf0faff..2481f983b426 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -9,12 +9,15 @@
 #include "phy.h"
 #include "reg.h"
 #include "rtw8922a.h"
+#include "rtw8922a_rfk.h"
 
 #define RTW8922A_FW_FORMAT_MAX 0
 #define RTW8922A_FW_BASENAME "rtw89/rtw8922a_fw"
 #define RTW8922A_MODULE_FIRMWARE \
 	RTW8922A_FW_BASENAME ".bin"
 
+#define HE_N_USER_MAX_8922A 4
+
 static const struct rtw89_hfc_ch_cfg rtw8922a_hfc_chcfg_pcie[] = {
 	{2, 1641, grp_0}, /* ACH 0 */
 	{2, 1641, grp_0}, /* ACH 1 */
@@ -1049,10 +1052,167 @@ static void rtw8922a_bb_postinit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	rtw89_phy_write32_idx(rtwdev, R_UDP_COEEF, B_UDP_COEEF, 0x1, phy_idx);
 }
 
+static void rtw8922a_bb_reset_en(struct rtw89_dev *rtwdev, enum rtw89_band band,
+				 bool en, enum rtw89_phy_idx phy_idx)
+{
+	if (en) {
+		rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1, phy_idx);
+		if (band == RTW89_BAND_2G)
+			rtw89_phy_write32_idx(rtwdev, R_RXCCA_BE1,
+					      B_RXCCA_BE1_DIS, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0x0, phy_idx);
+	} else {
+		rtw89_phy_write32_idx(rtwdev, R_RXCCA_BE1, B_RXCCA_BE1_DIS, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0x1, phy_idx);
+		fsleep(1);
+		rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 0, phy_idx);
+	}
+}
+
+static int rtw8922a_ctrl_tx_path_tmac(struct rtw89_dev *rtwdev,
+				      enum rtw89_rf_path tx_path,
+				      enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_reg2_def path_com_cr[] = {
+		{0x11A00, 0x21C86900},
+		{0x11A04, 0x00E4E433},
+		{0x11A08, 0x39390CC9},
+		{0x11A0C, 0x4E433240},
+		{0x11A10, 0x90CC900E},
+		{0x11A14, 0x00240393},
+		{0x11A18, 0x201C8600},
+	};
+	int ret = 0;
+	u32 reg;
+	int i;
+
+	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL, 0x0, phy_idx);
+
+	if (phy_idx == RTW89_PHY_1 && !rtwdev->dbcc_en)
+		return 0;
+
+	if (tx_path == RF_PATH_A) {
+		path_com_cr[0].data = 0x21C82900;
+		path_com_cr[1].data = 0x00E4E431;
+		path_com_cr[2].data = 0x39390C49;
+		path_com_cr[3].data = 0x4E431240;
+		path_com_cr[4].data = 0x90C4900E;
+		path_com_cr[6].data = 0x201C8200;
+	} else if (tx_path == RF_PATH_B) {
+		path_com_cr[0].data = 0x21C04900;
+		path_com_cr[1].data = 0x00E4E032;
+		path_com_cr[2].data = 0x39380C89;
+		path_com_cr[3].data = 0x4E032240;
+		path_com_cr[4].data = 0x80C8900E;
+		path_com_cr[6].data = 0x201C0400;
+	} else if (tx_path == RF_PATH_AB) {
+		path_com_cr[0].data = 0x21C86900;
+		path_com_cr[1].data = 0x00E4E433;
+		path_com_cr[2].data = 0x39390CC9;
+		path_com_cr[3].data = 0x4E433240;
+		path_com_cr[4].data = 0x90CC900E;
+		path_com_cr[6].data = 0x201C8600;
+	} else {
+		ret = -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(path_com_cr); i++) {
+		reg = rtw89_mac_reg_by_idx(rtwdev, path_com_cr[i].addr, phy_idx);
+		rtw89_write32(rtwdev, reg, path_com_cr[i].data);
+	}
+
+	return ret;
+}
+
 static void rtw8922a_bb_reset(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 }
 
+static int rtw8922a_cfg_rx_nss_limit(struct rtw89_dev *rtwdev, u8 rx_nss,
+				     enum rtw89_phy_idx phy_idx)
+{
+	if (rx_nss == 1) {
+		rtw89_phy_write32_idx(rtwdev, R_BRK_R, B_HTMCS_LMT, 0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BRK_R, B_VHTMCS_LMT, 0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BRK_HE, B_N_USR_MAX,
+				      HE_N_USER_MAX_8922A, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BRK_HE, B_NSS_MAX, 0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BRK_HE, B_TB_NSS_MAX, 0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BRK_EHT, B_RXEHT_NSS_MAX, 0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BRK_RXEHT, B_RXEHTTB_NSS_MAX, 0,
+				      phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BRK_RXEHT, B_RXEHT_N_USER_MAX,
+				      HE_N_USER_MAX_8922A, phy_idx);
+	} else if (rx_nss == 2) {
+		rtw89_phy_write32_idx(rtwdev, R_BRK_R, B_HTMCS_LMT, 1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BRK_R, B_VHTMCS_LMT, 1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BRK_HE, B_N_USR_MAX,
+				      HE_N_USER_MAX_8922A, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BRK_HE, B_NSS_MAX, 1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BRK_HE, B_TB_NSS_MAX, 1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BRK_EHT, B_RXEHT_NSS_MAX, 1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BRK_RXEHT, B_RXEHTTB_NSS_MAX, 1,
+				      phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BRK_RXEHT, B_RXEHT_N_USER_MAX,
+				      HE_N_USER_MAX_8922A, phy_idx);
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void rtw8922a_tssi_reset(struct rtw89_dev *rtwdev,
+				enum rtw89_rf_path path,
+				enum rtw89_phy_idx phy_idx)
+{
+	if (rtwdev->mlo_dbcc_mode == MLO_1_PLUS_1_1RF) {
+		if (phy_idx == RTW89_PHY_0) {
+			rtw89_phy_write32_mask(rtwdev, R_TXPWR_RSTA, B_TXPWR_RSTA, 0x0);
+			rtw89_phy_write32_mask(rtwdev, R_TXPWR_RSTA, B_TXPWR_RSTA, 0x1);
+		} else {
+			rtw89_phy_write32_mask(rtwdev, R_TXPWR_RSTB, B_TXPWR_RSTB, 0x0);
+			rtw89_phy_write32_mask(rtwdev, R_TXPWR_RSTB, B_TXPWR_RSTB, 0x1);
+		}
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_TXPWR_RSTA, B_TXPWR_RSTA, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_TXPWR_RSTA, B_TXPWR_RSTA, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_TXPWR_RSTB, B_TXPWR_RSTB, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_TXPWR_RSTB, B_TXPWR_RSTB, 0x1);
+	}
+}
+
+static int rtw8922a_ctrl_rx_path_tmac(struct rtw89_dev *rtwdev,
+				      enum rtw89_rf_path rx_path,
+				      enum rtw89_phy_idx phy_idx)
+{
+	u8 rx_nss = (rx_path == RF_PATH_AB) ? 2 : 1;
+
+	/* Set to 0 first to avoid abnormal EDCCA report */
+	rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_ANT_RX_SG0, 0x0, phy_idx);
+
+	if (rx_path == RF_PATH_A) {
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_ANT_RX_SG0, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_FC0INV_SBW, B_RX_1RCCA, 1, phy_idx);
+		rtw8922a_cfg_rx_nss_limit(rtwdev, rx_nss, phy_idx);
+		rtw8922a_tssi_reset(rtwdev, rx_path, phy_idx);
+	} else if (rx_path == RF_PATH_B) {
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_ANT_RX_SG0, 0x2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_FC0INV_SBW, B_RX_1RCCA, 2, phy_idx);
+		rtw8922a_cfg_rx_nss_limit(rtwdev, rx_nss, phy_idx);
+		rtw8922a_tssi_reset(rtwdev, rx_path, phy_idx);
+	} else if (rx_path == RF_PATH_AB) {
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_ANT_RX_SG0, 0x3, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_FC0INV_SBW, B_RX_1RCCA, 3, phy_idx);
+		rtw8922a_cfg_rx_nss_limit(rtwdev, rx_nss, phy_idx);
+		rtw8922a_tssi_reset(rtwdev, rx_path, phy_idx);
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int rtw8922a_ctrl_mlo(struct rtw89_dev *rtwdev, enum rtw89_mlo_dbcc_mode mode)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
@@ -1130,6 +1290,85 @@ static void rtw8922a_set_channel(struct rtw89_dev *rtwdev,
 	rtw8922a_set_channel_bb(rtwdev, chan, phy_idx);
 }
 
+static void rtw8922a_dfs_en_idx(struct rtw89_dev *rtwdev,
+				enum rtw89_phy_idx phy_idx, enum rtw89_rf_path path,
+				bool en)
+{
+	u32 path_ofst = (path == RF_PATH_B) ? 0x100 : 0x0;
+
+	if (en)
+		rtw89_phy_write32_idx(rtwdev, 0x2800 + path_ofst, BIT(1), 1,
+				      phy_idx);
+	else
+		rtw89_phy_write32_idx(rtwdev, 0x2800 + path_ofst, BIT(1), 0,
+				      phy_idx);
+}
+
+static void rtw8922a_dfs_en(struct rtw89_dev *rtwdev, bool en,
+			    enum rtw89_phy_idx phy_idx)
+{
+	rtw8922a_dfs_en_idx(rtwdev, phy_idx, RF_PATH_A, en);
+	rtw8922a_dfs_en_idx(rtwdev, phy_idx, RF_PATH_B, en);
+}
+
+static void rtw8922a_adc_en_path(struct rtw89_dev *rtwdev,
+				 enum rtw89_rf_path path, bool en)
+{
+	u32 val;
+
+	val = rtw89_phy_read32_mask(rtwdev, R_ADC_FIFO_V1, B_ADC_FIFO_EN_V1);
+
+	if (en) {
+		if (path == RF_PATH_A)
+			val &= ~0x1;
+		else
+			val &= ~0x2;
+	} else {
+		if (path == RF_PATH_A)
+			val |= 0x1;
+		else
+			val |= 0x2;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO_V1, B_ADC_FIFO_EN_V1, val);
+}
+
+static void rtw8922a_adc_en(struct rtw89_dev *rtwdev, bool en, u8 phy_idx)
+{
+	if (rtwdev->mlo_dbcc_mode == MLO_1_PLUS_1_1RF) {
+		if (phy_idx == RTW89_PHY_0)
+			rtw8922a_adc_en_path(rtwdev, RF_PATH_A, en);
+		else
+			rtw8922a_adc_en_path(rtwdev, RF_PATH_B, en);
+	} else {
+		rtw8922a_adc_en_path(rtwdev, RF_PATH_A, en);
+		rtw8922a_adc_en_path(rtwdev, RF_PATH_B, en);
+	}
+}
+
+static
+void rtw8922a_hal_reset(struct rtw89_dev *rtwdev,
+			enum rtw89_phy_idx phy_idx, enum rtw89_mac_idx mac_idx,
+			enum rtw89_band band, u32 *tx_en, bool enter)
+{
+	if (enter) {
+		rtw89_chip_stop_sch_tx(rtwdev, mac_idx, tx_en, RTW89_SCH_TX_SEL_ALL);
+		rtw89_mac_cfg_ppdu_status(rtwdev, mac_idx, false);
+		rtw8922a_dfs_en(rtwdev, false, phy_idx);
+		rtw8922a_tssi_cont_en_phyidx(rtwdev, false, phy_idx);
+		rtw8922a_adc_en(rtwdev, false, phy_idx);
+		fsleep(40);
+		rtw8922a_bb_reset_en(rtwdev, band, false, phy_idx);
+	} else {
+		rtw89_mac_cfg_ppdu_status(rtwdev, mac_idx, true);
+		rtw8922a_adc_en(rtwdev, true, phy_idx);
+		rtw8922a_dfs_en(rtwdev, true, phy_idx);
+		rtw8922a_tssi_cont_en_phyidx(rtwdev, true, phy_idx);
+		rtw8922a_bb_reset_en(rtwdev, band, true, phy_idx);
+		rtw89_chip_resume_sch_tx(rtwdev, mac_idx, *tx_en);
+	}
+}
+
 static void rtw8922a_set_txpwr_ref(struct rtw89_dev *rtwdev,
 				   enum rtw89_phy_idx phy_idx)
 {
@@ -1188,6 +1427,19 @@ static void rtw8922a_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
 	rtw8922a_set_txpwr_ref(rtwdev, phy_idx);
 }
 
+static void rtw8922a_ctrl_trx_path(struct rtw89_dev *rtwdev,
+				   enum rtw89_rf_path tx_path, u8 tx_nss,
+				   enum rtw89_rf_path rx_path, u8 rx_nss)
+{
+	enum rtw89_phy_idx phy_idx;
+
+	for (phy_idx = RTW89_PHY_0; phy_idx <= RTW89_PHY_1; phy_idx++) {
+		rtw8922a_ctrl_tx_path_tmac(rtwdev, tx_path, phy_idx);
+		rtw8922a_ctrl_rx_path_tmac(rtwdev, rx_path, phy_idx);
+		rtw8922a_cfg_rx_nss_limit(rtwdev, rx_nss, phy_idx);
+	}
+}
+
 static void rtw8922a_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
 				     enum rtw89_phy_idx phy_idx)
 {
@@ -1250,6 +1502,32 @@ static void rtw8922a_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
 	}
 }
 
+static void rtw8922a_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 ntx_path = RF_PATH_AB;
+	u32 tx_en0, tx_en1;
+
+	if (hal->antenna_tx == RF_A)
+		ntx_path = RF_PATH_A;
+	else if (hal->antenna_tx == RF_B)
+		ntx_path = RF_PATH_B;
+
+	rtw8922a_hal_reset(rtwdev, RTW89_PHY_0, RTW89_MAC_0, band, &tx_en0, true);
+	if (rtwdev->dbcc_en)
+		rtw8922a_hal_reset(rtwdev, RTW89_PHY_1, RTW89_MAC_1, band,
+				   &tx_en1, true);
+
+	rtw8922a_ctrl_trx_path(rtwdev, ntx_path, 2, RF_PATH_AB, 2);
+
+	rtw8922a_hal_reset(rtwdev, RTW89_PHY_0, RTW89_MAC_0, band, &tx_en0, false);
+	if (rtwdev->dbcc_en)
+		rtw8922a_hal_reset(rtwdev, RTW89_PHY_1, RTW89_MAC_1, band,
+				   &tx_en0, false);
+}
+
 static void rtw8922a_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
 					 struct rtw89_rx_phy_ppdu *phy_ppdu,
 					 struct ieee80211_rx_status *status)
@@ -1326,6 +1604,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.ctrl_btg_bt_rx		= rtw8922a_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8922a_query_ppdu,
 	.ctrl_nbtg_bt_tx	= rtw8922a_ctrl_nbtg_bt_tx,
+	.cfg_txrx_path		= rtw8922a_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= NULL,
 	.pwr_on_func		= rtw8922a_pwr_on_func,
 	.pwr_off_func		= rtw8922a_pwr_off_func,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
new file mode 100644
index 000000000000..e0e8048db739
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2023  Realtek Corporation
+ */
+
+#include "debug.h"
+#include "phy.h"
+#include "reg.h"
+#include "rtw8922a.h"
+#include "rtw8922a_rfk.h"
+
+static void rtw8922a_tssi_cont_en(struct rtw89_dev *rtwdev, bool en,
+				  enum rtw89_rf_path path)
+{
+	static const u32 tssi_trk_man[2] = {R_TSSI_PWR_P0, R_TSSI_PWR_P1};
+
+	if (en)
+		rtw89_phy_write32_mask(rtwdev, tssi_trk_man[path], B_TSSI_CONT_EN, 0);
+	else
+		rtw89_phy_write32_mask(rtwdev, tssi_trk_man[path], B_TSSI_CONT_EN, 1);
+}
+
+void rtw8922a_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx)
+{
+	if (rtwdev->mlo_dbcc_mode == MLO_1_PLUS_1_1RF) {
+		if (phy_idx == RTW89_PHY_0)
+			rtw8922a_tssi_cont_en(rtwdev, en, RF_PATH_A);
+		else
+			rtw8922a_tssi_cont_en(rtwdev, en, RF_PATH_B);
+	} else {
+		rtw8922a_tssi_cont_en(rtwdev, en, RF_PATH_A);
+		rtw8922a_tssi_cont_en(rtwdev, en, RF_PATH_B);
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h
new file mode 100644
index 000000000000..fbd22de269e2
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2023  Realtek Corporation
+ */
+
+#ifndef __RTW89_8922A_RFK_H__
+#define __RTW89_8922A_RFK_H__
+
+#include "core.h"
+
+void rtw8922a_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx);
+
+#endif
-- 
2.25.1


