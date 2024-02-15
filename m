Return-Path: <linux-wireless+bounces-3607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E420B855A3E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 06:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB601C2472E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 05:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD814A12;
	Thu, 15 Feb 2024 05:58:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F424C142
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 05:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707976726; cv=none; b=TasTiCr6VanKv4XnDz1m/bFcUkaUnSXR7dOl9xuQ72vOtp9MzI2oQ5v5FlNvLyxz7LhOxXjgzj3hzOREfUoUEWduyai2vxsT4U3RNwbJyCY9SpvZpOa+RX9rTrbFnONhTE/UG7e19JuRW7BVViu+8dOAHo/QfzhbHLD0CiGzsvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707976726; c=relaxed/simple;
	bh=RaHtmaQV1avjShkK1p/BpXNzR305KAm5G+NIq5eINwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqkJMdq5J5pyFDe6w/cI6nIG9rlFchm020hQ8dBQxLDP+xSMBQMt8pte0BTpWhr5E9AaK1NuN8kQ4QpiojeBbI/cMK6gpODDEl3TjNJTntnp/l9Ij5Tl3YWrjAilVxx2HWdbB0uEDy23oFgcJu6qotOOhuCyy2aFoyG752t7a+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41F5wbDO32372775, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41F5wbDO32372775
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 13:58:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 15 Feb 2024 13:58:37 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 15 Feb
 2024 13:58:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/4] wifi: rtw89: 8922a: add set_channel BB part
Date: Thu, 15 Feb 2024 13:57:39 +0800
Message-ID: <20240215055741.14148-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215055741.14148-1-pkshih@realtek.com>
References: <20240215055741.14148-1-pkshih@realtek.com>
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

In additional to configure band, channel and bandwidth registers, it also
configure CCK support on 2GHZ band, spur elimination, and RX gain.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  37 ++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 390 ++++++++++++++++++
 2 files changed, 427 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index ae637203ee8a..9f3d10766b04 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8448,6 +8448,9 @@
 #define B_PATH1_5MDET_SB2 BIT(8)
 #define B_PATH1_5MDET_SB0 BIT(6)
 #define B_PATH1_5MDET_TH GENMASK(5, 0)
+#define R_S0S1_CSI_WGT 0x4D34
+#define B_S0S1_CSI_WGT_EN BIT(0)
+#define B_S0S1_CSI_WGT_TONE_IDX GENMASK(31, 20)
 #define R_CHINFO_ELM_SRC 0x4D84
 #define B_CHINFO_ELM_BITMAP GENMASK(22, 0)
 #define B_CHINFO_SRC GENMASK(31, 30)
@@ -8601,18 +8604,48 @@
 #define B_S0_DACKQ8_K GENMASK(15, 8)
 #define R_DCFO_WEIGHT_V1 0x6244
 #define B_DCFO_WEIGHT_MSK_V1 GENMASK(31, 28)
+#define R_DAC_CLK 0x625C
+#define B_DAC_CLK GENMASK(31, 30)
 #define R_DCFO_OPT_V1 0x6260
 #define B_DCFO_OPT_EN_V1 BIT(17)
 #define R_TXFCTR 0x627C
 #define B_TXFCTR_THD GENMASK(19, 10)
 #define R_TXSCALE 0x6284
 #define B_TXFCTR_EN BIT(19)
+#define R_PCOEFF01 0x6684
+#define B_PCOEFF01 GENMASK(23, 0)
+#define R_PCOEFF23 0x6688
+#define B_PCOEFF23 GENMASK(23, 0)
+#define R_PCOEFF45 0x668c
+#define B_PCOEFF45 GENMASK(23, 0)
+#define R_PCOEFF67 0x6690
+#define B_PCOEFF67 GENMASK(23, 0)
+#define R_PCOEFF89 0x6694
+#define B_PCOEFF89 GENMASK(23, 0)
+#define R_PCOEFFAB 0x6698
+#define B_PCOEFFAB GENMASK(23, 0)
+#define R_PCOEFFCD 0x669c
+#define B_PCOEFFCD GENMASK(23, 0)
+#define R_PCOEFFEF 0x66a0
+#define B_PCOEFFEF GENMASK(23, 0)
+#define R_MGAIN_BIAS 0x672c
+#define B_MGAIN_BIAS_BW20 GENMASK(3, 0)
+#define B_MGAIN_BIAS_BW40 GENMASK(7, 4)
+#define R_CCK_RPL_OFST 0x6750
+#define B_CCK_RPL_OFST GENMASK(7, 0)
+#define R_BK_FC0INV 0x6758
+#define B_BK_FC0INV GENMASK(18, 0)
+#define R_CCK_FC0INV 0x675c
+#define B_CCK_FC0INV GENMASK(18, 0)
 #define R_SEG0R_EDCCA_LVL_BE 0x69EC
 #define R_SEG0R_PPDU_LVL_BE 0x69F0
 #define R_SEGSND 0x6A14
 #define B_SEGSND_EN BIT(31)
 #define R_DBCC 0x6B48
 #define B_DBCC_EN BIT(0)
+#define R_FC0 0x6B4C
+#define B_BW40_2XFFT BIT(31)
+#define B_FC0 GENMASK(12, 0)
 #define R_FC0INV_SBW 0x6B50
 #define B_SMALLBW GENMASK(31, 30)
 #define B_RX_BT_SG0 GENMASK(25, 22)
@@ -9040,6 +9073,10 @@
 #define B_DACKN0_V GENMASK(21, 14)
 #define R_DACKN1_CTL 0xC224
 #define B_DACKN1_V GENMASK(21, 14)
+#define R_GAIN_MAP0 0xE44C
+#define B_GAIN_MAP0_EN BIT(0)
+#define R_GAIN_MAP1 0xE54C
+#define B_GAIN_MAP1_EN BIT(0)
 #define R_GOTX_IQKDPK_C0 0xE464
 #define R_GOTX_IQKDPK_C1 0xE564
 #define B_GOTX_IQKDPK GENMASK(28, 27)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 982e0ba13b9c..361e66954924 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -11,6 +11,7 @@
 #include "reg.h"
 #include "rtw8922a.h"
 #include "rtw8922a_rfk.h"
+#include "util.h"
 
 #define RTW8922A_FW_FORMAT_MAX 0
 #define RTW8922A_FW_BASENAME "rtw89/rtw8922a_fw"
@@ -862,6 +863,37 @@ static void rtw8922a_set_channel_mac(struct rtw89_dev *rtwdev,
 	}
 }
 
+static const u32 rtw8922a_sco_barker_threshold[14] = {
+	0x1fe4f, 0x1ff5e, 0x2006c, 0x2017b, 0x2028a, 0x20399, 0x204a8, 0x205b6,
+	0x206c5, 0x207d4, 0x208e3, 0x209f2, 0x20b00, 0x20d8a
+};
+
+static const u32 rtw8922a_sco_cck_threshold[14] = {
+	0x2bdac, 0x2bf21, 0x2c095, 0x2c209, 0x2c37e, 0x2c4f2, 0x2c666, 0x2c7db,
+	0x2c94f, 0x2cac3, 0x2cc38, 0x2cdac, 0x2cf21, 0x2d29e
+};
+
+static int rtw8922a_ctrl_sco_cck(struct rtw89_dev *rtwdev,
+				 u8 primary_ch, enum rtw89_bandwidth bw,
+				 enum rtw89_phy_idx phy_idx)
+{
+	u8 ch_element;
+
+	if (primary_ch >= 14)
+		return -EINVAL;
+
+	ch_element = primary_ch - 1;
+
+	rtw89_phy_write32_idx(rtwdev, R_BK_FC0INV, B_BK_FC0INV,
+			      rtw8922a_sco_barker_threshold[ch_element],
+			      phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_CCK_FC0INV, B_CCK_FC0INV,
+			      rtw8922a_sco_cck_threshold[ch_element],
+			      phy_idx);
+
+	return 0;
+}
+
 struct rtw8922a_bb_gain {
 	u32 gain_g[BB_PATH_NUM_8922A];
 	u32 gain_a[BB_PATH_NUM_8922A];
@@ -1022,12 +1054,341 @@ static void rtw8922a_set_gain(struct rtw89_dev *rtwdev,
 	rtw8922a_set_rpl_gain(rtwdev, chan, path, phy_idx);
 }
 
+static void rtw8922a_set_rx_gain_normal_cck(struct rtw89_dev *rtwdev,
+					    const struct rtw89_chan *chan,
+					    enum rtw89_rf_path path)
+{
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+	s8 value = -gain->offset[path][RTW89_GAIN_OFFSET_2G_CCK]; /* S(8,2) */
+	u8 fraction = value & 0x3;
+
+	if (fraction) {
+		rtw89_phy_write32_mask(rtwdev, R_MGAIN_BIAS, B_MGAIN_BIAS_BW20,
+				       (0x4 - fraction) << 1);
+		rtw89_phy_write32_mask(rtwdev, R_MGAIN_BIAS, B_MGAIN_BIAS_BW40,
+				       (0x4 - fraction) << 1);
+
+		value >>= 2;
+		rtw89_phy_write32_mask(rtwdev, R_CCK_RPL_OFST, B_CCK_RPL_OFST,
+				       value + 1 + 0xdc);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_MGAIN_BIAS, B_MGAIN_BIAS_BW20, 0);
+		rtw89_phy_write32_mask(rtwdev, R_MGAIN_BIAS, B_MGAIN_BIAS_BW40, 0);
+
+		value >>= 2;
+		rtw89_phy_write32_mask(rtwdev, R_CCK_RPL_OFST, B_CCK_RPL_OFST,
+				       value + 0xdc);
+	}
+}
+
+static void rtw8922a_set_rx_gain_normal_ofdm(struct rtw89_dev *rtwdev,
+					     const struct rtw89_chan *chan,
+					     enum rtw89_rf_path path)
+{
+	static const u32 rssi_tb_bias_comp[2] = {0x41f8, 0x45f8};
+	static const u32 rssi_tb_ext_comp[2] = {0x4208, 0x4608};
+	static const u32 rssi_ofst_addr[2] = {0x40c8, 0x44c8};
+	static const u32 rpl_bias_comp[2] = {0x41e8, 0x45e8};
+	static const u32 rpl_ext_comp[2] = {0x41f8, 0x45f8};
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+	enum rtw89_gain_offset gain_band;
+	s8 v1, v2, v3;
+	s32 value;
+
+	gain_band = rtw89_subband_to_gain_offset_band_of_ofdm(chan->subband_type);
+	value = gain->offset[path][gain_band];
+	rtw89_phy_write32_mask(rtwdev, rssi_ofst_addr[path], 0xff000000, value + 0xF8);
+
+	value *= -4;
+	v1 = clamp_t(s32, value, S8_MIN, S8_MAX);
+	value -= v1;
+	v2 = clamp_t(s32, value, S8_MIN, S8_MAX);
+	value -= v2;
+	v3 = clamp_t(s32, value, S8_MIN, S8_MAX);
+
+	rtw89_phy_write32_mask(rtwdev, rpl_bias_comp[path], 0xff, v1);
+	rtw89_phy_write32_mask(rtwdev, rpl_ext_comp[path], 0xff, v2);
+	rtw89_phy_write32_mask(rtwdev, rpl_ext_comp[path], 0xff00, v3);
+
+	rtw89_phy_write32_mask(rtwdev, rssi_tb_bias_comp[path], 0xff0000, v1);
+	rtw89_phy_write32_mask(rtwdev, rssi_tb_ext_comp[path], 0xff0000, v2);
+	rtw89_phy_write32_mask(rtwdev, rssi_tb_ext_comp[path], 0xff000000, v3);
+}
+
+static void rtw8922a_set_rx_gain_normal(struct rtw89_dev *rtwdev,
+					const struct rtw89_chan *chan,
+					enum rtw89_rf_path path)
+{
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+
+	if (!gain->offset_valid)
+		return;
+
+	if (chan->band_type == RTW89_BAND_2G)
+		rtw8922a_set_rx_gain_normal_cck(rtwdev, chan, path);
+
+	rtw8922a_set_rx_gain_normal_ofdm(rtwdev, chan, path);
+}
+
+static void rtw8922a_set_cck_parameters(struct rtw89_dev *rtwdev, u8 central_ch,
+					enum rtw89_phy_idx phy_idx)
+{
+	if (central_ch == 14) {
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF01, B_PCOEFF01, 0x3b13ff, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF23, B_PCOEFF23, 0x1c42de, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF45, B_PCOEFF45, 0xfdb0ad, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF67, B_PCOEFF67, 0xf60f6e, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF89, B_PCOEFF89, 0xfd8f92, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFFAB, B_PCOEFFAB, 0x02d011, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFFCD, B_PCOEFFCD, 0x01c02c, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFFEF, B_PCOEFFEF, 0xfff00a, phy_idx);
+	} else {
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF01, B_PCOEFF01, 0x3a63ca, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF23, B_PCOEFF23, 0x2a833f, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF45, B_PCOEFF45, 0x1491f8, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF67, B_PCOEFF67, 0x03c0b0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF89, B_PCOEFF89, 0xfccff1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFFAB, B_PCOEFFAB, 0xfccfc3, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFFCD, B_PCOEFFCD, 0xfebfdc, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFFEF, B_PCOEFFEF, 0xffdff7, phy_idx);
+	}
+}
+
 static void rtw8922a_ctrl_ch(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx)
 {
+	static const u32 band_sel[2] = {0x4160, 0x4560};
+	u16 central_freq = chan->freq;
+	u8 central_ch = chan->channel;
+	u8 band = chan->band_type;
+	bool is_2g = band == RTW89_BAND_2G;
+	u8 chan_idx;
+	u8 path;
+	u8 sco;
+
+	if (!central_freq) {
+		rtw89_warn(rtwdev, "Invalid central_freq\n");
+		return;
+	}
+
 	rtw8922a_set_gain(rtwdev, chan, RF_PATH_A, phy_idx);
 	rtw8922a_set_gain(rtwdev, chan, RF_PATH_B, phy_idx);
+
+	for (path = RF_PATH_A; path < BB_PATH_NUM_8922A; path++)
+		rtw89_phy_write32_idx(rtwdev, band_sel[path], BIT((26)), is_2g, phy_idx);
+
+	rtw8922a_set_rx_gain_normal(rtwdev, chan, RF_PATH_A);
+	rtw8922a_set_rx_gain_normal(rtwdev, chan, RF_PATH_B);
+
+	rtw89_phy_write32_idx(rtwdev, R_FC0, B_FC0, central_freq, phy_idx);
+	sco = DIV_ROUND_CLOSEST(1 << 18, central_freq);
+	rtw89_phy_write32_idx(rtwdev, R_FC0INV_SBW, B_FC0_INV, sco, phy_idx);
+
+	if (band == RTW89_BAND_2G)
+		rtw8922a_set_cck_parameters(rtwdev, central_ch, phy_idx);
+
+	chan_idx = rtw89_encode_chan_idx(rtwdev, chan->primary_channel, band);
+	rtw89_phy_write32_idx(rtwdev, R_MAC_PIN_SEL, B_CH_IDX_SEG0, chan_idx, phy_idx);
+}
+
+static void
+rtw8922a_ctrl_bw(struct rtw89_dev *rtwdev, u8 pri_sb, u8 bw,
+		 enum rtw89_phy_idx phy_idx)
+{
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_5:
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_CHBW_BW, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_FC0INV_SBW, B_SMALLBW, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_CHBW_PRICH, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_DAC_CLK, B_DAC_CLK, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_GAIN_MAP0, B_GAIN_MAP0_EN, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_GAIN_MAP1, B_GAIN_MAP1_EN, 0x0, phy_idx);
+		break;
+	case RTW89_CHANNEL_WIDTH_10:
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_CHBW_BW, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_FC0INV_SBW, B_SMALLBW, 0x2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_CHBW_PRICH, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_DAC_CLK, B_DAC_CLK, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_GAIN_MAP0, B_GAIN_MAP0_EN, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_GAIN_MAP1, B_GAIN_MAP1_EN, 0x0, phy_idx);
+		break;
+	case RTW89_CHANNEL_WIDTH_20:
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_CHBW_BW, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_FC0INV_SBW, B_SMALLBW, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_CHBW_PRICH, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_DAC_CLK, B_DAC_CLK, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_GAIN_MAP0, B_GAIN_MAP0_EN, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_GAIN_MAP1, B_GAIN_MAP1_EN, 0x0, phy_idx);
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_CHBW_BW, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_FC0INV_SBW, B_SMALLBW, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_CHBW_PRICH, pri_sb, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_DAC_CLK, B_DAC_CLK, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_GAIN_MAP0, B_GAIN_MAP0_EN, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_GAIN_MAP1, B_GAIN_MAP1_EN, 0x0, phy_idx);
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_CHBW_BW, 0x2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_FC0INV_SBW, B_SMALLBW, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_CHBW_PRICH, pri_sb, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_DAC_CLK, B_DAC_CLK, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_GAIN_MAP0, B_GAIN_MAP0_EN, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_GAIN_MAP1, B_GAIN_MAP1_EN, 0x1, phy_idx);
+		break;
+	case RTW89_CHANNEL_WIDTH_160:
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_CHBW_BW, 0x3, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_FC0INV_SBW, B_SMALLBW, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_CHBW_PRICH, pri_sb, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_DAC_CLK, B_DAC_CLK, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_GAIN_MAP0, B_GAIN_MAP0_EN, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_GAIN_MAP1, B_GAIN_MAP1_EN, 0x1, phy_idx);
+		break;
+	default:
+		rtw89_warn(rtwdev, "Fail to switch bw (bw:%d, pri_sb:%d)\n", bw,
+			   pri_sb);
+		break;
+	}
+
+	if (bw == RTW89_CHANNEL_WIDTH_40)
+		rtw89_phy_write32_idx(rtwdev, R_FC0, B_BW40_2XFFT, 1, phy_idx);
+	else
+		rtw89_phy_write32_idx(rtwdev, R_FC0, B_BW40_2XFFT, 0, phy_idx);
+}
+
+static u32 rtw8922a_spur_freq(struct rtw89_dev *rtwdev,
+			      const struct rtw89_chan *chan)
+{
+	return 0;
+}
+
+#define CARRIER_SPACING_312_5 312500 /* 312.5 kHz */
+#define CARRIER_SPACING_78_125 78125 /* 78.125 kHz */
+#define MAX_TONE_NUM 2048
+
+static void rtw8922a_set_csi_tone_idx(struct rtw89_dev *rtwdev,
+				      const struct rtw89_chan *chan,
+				      enum rtw89_phy_idx phy_idx)
+{
+	s32 freq_diff, csi_idx, csi_tone_idx;
+	u32 spur_freq;
+
+	spur_freq = rtw8922a_spur_freq(rtwdev, chan);
+	if (spur_freq == 0) {
+		rtw89_phy_write32_idx(rtwdev, R_S0S1_CSI_WGT, B_S0S1_CSI_WGT_EN,
+				      0, phy_idx);
+		return;
+	}
+
+	freq_diff = (spur_freq - chan->freq) * 1000000;
+	csi_idx = s32_div_u32_round_closest(freq_diff, CARRIER_SPACING_78_125);
+	s32_div_u32_round_down(csi_idx, MAX_TONE_NUM, &csi_tone_idx);
+
+	rtw89_phy_write32_idx(rtwdev, R_S0S1_CSI_WGT, B_S0S1_CSI_WGT_TONE_IDX,
+			      csi_tone_idx, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_S0S1_CSI_WGT, B_S0S1_CSI_WGT_EN, 1, phy_idx);
+}
+
+static const struct rtw89_nbi_reg_def rtw8922a_nbi_reg_def[] = {
+	[RF_PATH_A] = {
+		.notch1_idx = {0x41a0, 0xFF},
+		.notch1_frac_idx = {0x41a0, 0xC00},
+		.notch1_en = {0x41a0, 0x1000},
+		.notch2_idx = {0x41ac, 0xFF},
+		.notch2_frac_idx = {0x41ac, 0xC00},
+		.notch2_en = {0x41ac, 0x1000},
+	},
+	[RF_PATH_B] = {
+		.notch1_idx = {0x45a0, 0xFF},
+		.notch1_frac_idx = {0x45a0, 0xC00},
+		.notch1_en = {0x45a0, 0x1000},
+		.notch2_idx = {0x45ac, 0xFF},
+		.notch2_frac_idx = {0x45ac, 0xC00},
+		.notch2_en = {0x45ac, 0x1000},
+	},
+};
+
+static void rtw8922a_set_nbi_tone_idx(struct rtw89_dev *rtwdev,
+				      const struct rtw89_chan *chan,
+				      enum rtw89_rf_path path,
+				      enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_nbi_reg_def *nbi = &rtw8922a_nbi_reg_def[path];
+	s32 nbi_frac_idx, nbi_frac_tone_idx;
+	s32 nbi_idx, nbi_tone_idx;
+	bool notch2_chk = false;
+	u32 spur_freq, fc;
+	s32 freq_diff;
+
+	spur_freq = rtw8922a_spur_freq(rtwdev, chan);
+	if (spur_freq == 0) {
+		rtw89_phy_write32_idx(rtwdev, nbi->notch1_en.addr,
+				      nbi->notch1_en.mask, 0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch2_en.addr,
+				      nbi->notch2_en.mask, 0, phy_idx);
+		return;
+	}
+
+	fc = chan->freq;
+	if (chan->band_width == RTW89_CHANNEL_WIDTH_160) {
+		fc = (spur_freq > fc) ? fc + 40 : fc - 40;
+		if ((fc > spur_freq &&
+		     chan->channel < chan->primary_channel) ||
+		    (fc < spur_freq &&
+		     chan->channel > chan->primary_channel))
+			notch2_chk = true;
+	}
+
+	freq_diff = (spur_freq - fc) * 1000000;
+	nbi_idx = s32_div_u32_round_down(freq_diff, CARRIER_SPACING_312_5,
+					 &nbi_frac_idx);
+
+	if (chan->band_width == RTW89_CHANNEL_WIDTH_20) {
+		s32_div_u32_round_down(nbi_idx + 32, 64, &nbi_tone_idx);
+	} else {
+		u16 tone_para = (chan->band_width == RTW89_CHANNEL_WIDTH_40) ?
+				128 : 256;
+
+		s32_div_u32_round_down(nbi_idx, tone_para, &nbi_tone_idx);
+	}
+	nbi_frac_tone_idx =
+		s32_div_u32_round_closest(nbi_frac_idx, CARRIER_SPACING_78_125);
+
+	if (chan->band_width == RTW89_CHANNEL_WIDTH_160 && notch2_chk) {
+		rtw89_phy_write32_idx(rtwdev, nbi->notch2_idx.addr,
+				      nbi->notch2_idx.mask, nbi_tone_idx, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch2_frac_idx.addr,
+				      nbi->notch2_frac_idx.mask, nbi_frac_tone_idx,
+				      phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch2_en.addr,
+				      nbi->notch2_en.mask, 0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch2_en.addr,
+				      nbi->notch2_en.mask, 1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch1_en.addr,
+				      nbi->notch1_en.mask, 0, phy_idx);
+	} else {
+		rtw89_phy_write32_idx(rtwdev, nbi->notch1_idx.addr,
+				      nbi->notch1_idx.mask, nbi_tone_idx, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch1_frac_idx.addr,
+				      nbi->notch1_frac_idx.mask, nbi_frac_tone_idx,
+				      phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch1_en.addr,
+				      nbi->notch1_en.mask, 0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch1_en.addr,
+				      nbi->notch1_en.mask, 1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch2_en.addr,
+				      nbi->notch2_en.mask, 0, phy_idx);
+	}
+}
+
+static void rtw8922a_spur_elimination(struct rtw89_dev *rtwdev,
+				      const struct rtw89_chan *chan,
+				      enum rtw89_phy_idx phy_idx)
+{
+	rtw8922a_set_csi_tone_idx(rtwdev, chan, phy_idx);
+	rtw8922a_set_nbi_tone_idx(rtwdev, chan, RF_PATH_A, phy_idx);
+	rtw8922a_set_nbi_tone_idx(rtwdev, chan, RF_PATH_B, phy_idx);
 }
 
 static void rtw8922a_ctrl_afe_dac(struct rtw89_dev *rtwdev, enum rtw89_bandwidth bw,
@@ -1377,11 +1738,40 @@ static void rtw8922a_bb_sethw(struct rtw89_dev *rtwdev)
 	rtw8922a_ctrl_mlo(rtwdev, rtwdev->mlo_dbcc_mode);
 }
 
+static void rtw8922a_ctrl_cck_en(struct rtw89_dev *rtwdev, bool cck_en,
+				 enum rtw89_phy_idx phy_idx)
+{
+	if (cck_en) {
+		rtw89_phy_write32_idx(rtwdev, R_RXCCA_BE1, B_RXCCA_BE1_DIS, 0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_UPD_CLK_ADC, B_ENABLE_CCK, 1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PD_ARBITER_OFF, B_PD_ARBITER_OFF,
+				      0, phy_idx);
+	} else {
+		rtw89_phy_write32_idx(rtwdev, R_RXCCA_BE1, B_RXCCA_BE1_DIS, 1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_UPD_CLK_ADC, B_ENABLE_CCK, 0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PD_ARBITER_OFF, B_PD_ARBITER_OFF,
+				      1, phy_idx);
+	}
+}
+
 static void rtw8922a_set_channel_bb(struct rtw89_dev *rtwdev,
 				    const struct rtw89_chan *chan,
 				    enum rtw89_phy_idx phy_idx)
 {
+	bool cck_en = chan->band_type == RTW89_BAND_2G;
+	u8 pri_sb = chan->pri_sb_idx;
+
+	if (cck_en)
+		rtw8922a_ctrl_sco_cck(rtwdev, chan->primary_channel,
+				      chan->band_width, phy_idx);
+
 	rtw8922a_ctrl_ch(rtwdev, chan, phy_idx);
+	rtw8922a_ctrl_bw(rtwdev, pri_sb, chan->band_width, phy_idx);
+	rtw8922a_ctrl_cck_en(rtwdev, cck_en, phy_idx);
+	rtw8922a_spur_elimination(rtwdev, chan, phy_idx);
+
+	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1, phy_idx);
+	rtw8922a_tssi_reset(rtwdev, RF_PATH_AB, phy_idx);
 }
 
 static void rtw8922a_set_channel(struct rtw89_dev *rtwdev,
-- 
2.25.1


