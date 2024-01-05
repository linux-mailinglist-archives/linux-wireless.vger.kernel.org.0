Return-Path: <linux-wireless+bounces-1513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED062824EBA
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 07:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DA41C226A6
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 06:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E282031B;
	Fri,  5 Jan 2024 06:43:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825491F610
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4056gjeI72200583, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4056gjeI72200583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 14:42:45 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 5 Jan 2024 14:42:46 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 5 Jan 2024
 14:42:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <cj.hsieh@realtek.com>, <hsuan8331@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/8] wifi: rtw89: 8922a: set RX gain along with set_channel operation
Date: Fri, 5 Jan 2024 14:42:23 +0800
Message-ID: <20240105064228.36580-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105064228.36580-1-pkshih@realtek.com>
References: <20240105064228.36580-1-pkshih@realtek.com>
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

From: Chung-Hsuan Hung <hsuan8331@realtek.com>

Set values of LNA, TIA and RPL gain compensation read from firmware file
when channel is changed.

Signed-off-by: Chung-Hsuan Hung <hsuan8331@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 184 ++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 0e7300cc6d9e..717e42be6793 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -600,6 +600,189 @@ static int rtw8922a_read_phycap(struct rtw89_dev *rtwdev, u8 *phycap_map)
 	return 0;
 }
 
+struct rtw8922a_bb_gain {
+	u32 gain_g[BB_PATH_NUM_8922A];
+	u32 gain_a[BB_PATH_NUM_8922A];
+	u32 gain_g_mask;
+	u32 gain_a_mask;
+};
+
+static const struct rtw89_reg_def rpl_comp_bw160[RTW89_BW20_SC_160M] = {
+	{ .addr = 0x41E8, .mask = 0xFF00},
+	{ .addr = 0x41E8, .mask = 0xFF0000},
+	{ .addr = 0x41E8, .mask = 0xFF000000},
+	{ .addr = 0x41EC, .mask = 0xFF},
+	{ .addr = 0x41EC, .mask = 0xFF00},
+	{ .addr = 0x41EC, .mask = 0xFF0000},
+	{ .addr = 0x41EC, .mask = 0xFF000000},
+	{ .addr = 0x41F0, .mask = 0xFF}
+};
+
+static const struct rtw89_reg_def rpl_comp_bw80[RTW89_BW20_SC_80M] = {
+	{ .addr = 0x41F4, .mask = 0xFF},
+	{ .addr = 0x41F4, .mask = 0xFF00},
+	{ .addr = 0x41F4, .mask = 0xFF0000},
+	{ .addr = 0x41F4, .mask = 0xFF000000}
+};
+
+static const struct rtw89_reg_def rpl_comp_bw40[RTW89_BW20_SC_40M] = {
+	{ .addr = 0x41F0, .mask = 0xFF0000},
+	{ .addr = 0x41F0, .mask = 0xFF000000}
+};
+
+static const struct rtw89_reg_def rpl_comp_bw20[RTW89_BW20_SC_20M] = {
+	{ .addr = 0x41F0, .mask = 0xFF00}
+};
+
+static const struct rtw8922a_bb_gain bb_gain_lna[LNA_GAIN_NUM] = {
+	{ .gain_g = {0x409c, 0x449c}, .gain_a = {0x406C, 0x446C},
+	  .gain_g_mask = 0xFF00, .gain_a_mask = 0xFF},
+	{ .gain_g = {0x409c, 0x449c}, .gain_a = {0x406C, 0x446C},
+	  .gain_g_mask = 0xFF000000, .gain_a_mask = 0xFF0000},
+	{ .gain_g = {0x40a0, 0x44a0}, .gain_a = {0x4070, 0x4470},
+	  .gain_g_mask = 0xFF00, .gain_a_mask = 0xFF},
+	{ .gain_g = {0x40a0, 0x44a0}, .gain_a = {0x4070, 0x4470},
+	  .gain_g_mask = 0xFF000000, .gain_a_mask = 0xFF0000},
+	{ .gain_g = {0x40a4, 0x44a4}, .gain_a = {0x4074, 0x4474},
+	  .gain_g_mask = 0xFF00, .gain_a_mask = 0xFF},
+	{ .gain_g = {0x40a4, 0x44a4}, .gain_a = {0x4074, 0x4474},
+	  .gain_g_mask = 0xFF000000, .gain_a_mask = 0xFF0000},
+	{ .gain_g = {0x40a8, 0x44a8}, .gain_a = {0x4078, 0x4478},
+	  .gain_g_mask = 0xFF00, .gain_a_mask = 0xFF},
+};
+
+static const struct rtw8922a_bb_gain bb_gain_tia[TIA_GAIN_NUM] = {
+	{ .gain_g = {0x4054, 0x4454}, .gain_a = {0x4054, 0x4454},
+	  .gain_g_mask = 0x7FC0000, .gain_a_mask = 0x1FF},
+	{ .gain_g = {0x4058, 0x4458}, .gain_a = {0x4054, 0x4454},
+	  .gain_g_mask = 0x1FF, .gain_a_mask = 0x3FE00 },
+};
+
+struct rtw8922a_bb_gain_bypass {
+	u32 gain_g[BB_PATH_NUM_8922A];
+	u32 gain_a[BB_PATH_NUM_8922A];
+	u32 gain_mask_g;
+	u32 gain_mask_a;
+};
+
+static void rtw8922a_set_rpl_gain(struct rtw89_dev *rtwdev,
+				  const struct rtw89_chan *chan,
+				  enum rtw89_rf_path path,
+				  enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_phy_bb_gain_info_be *gain = &rtwdev->bb_gain.be;
+	u8 gain_band = rtw89_subband_to_gain_band_be(chan->subband_type);
+	u32 reg_path_ofst = 0;
+	u32 mask;
+	s32 val;
+	u32 reg;
+	int i;
+
+	if (path == RF_PATH_B)
+		reg_path_ofst = 0x400;
+
+	for (i = 0; i < RTW89_BW20_SC_160M; i++) {
+		reg = rpl_comp_bw160[i].addr | reg_path_ofst;
+		mask = rpl_comp_bw160[i].mask;
+		val = gain->rpl_ofst_160[gain_band][path][i];
+		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
+	}
+
+	for (i = 0; i < RTW89_BW20_SC_80M; i++) {
+		reg = rpl_comp_bw80[i].addr | reg_path_ofst;
+		mask = rpl_comp_bw80[i].mask;
+		val = gain->rpl_ofst_80[gain_band][path][i];
+		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
+	}
+
+	for (i = 0; i < RTW89_BW20_SC_40M; i++) {
+		reg = rpl_comp_bw40[i].addr | reg_path_ofst;
+		mask = rpl_comp_bw40[i].mask;
+		val = gain->rpl_ofst_40[gain_band][path][i];
+		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
+	}
+
+	for (i = 0; i < RTW89_BW20_SC_20M; i++) {
+		reg = rpl_comp_bw20[i].addr | reg_path_ofst;
+		mask = rpl_comp_bw20[i].mask;
+		val = gain->rpl_ofst_20[gain_band][path][i];
+		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
+	}
+}
+
+static void rtw8922a_set_lna_tia_gain(struct rtw89_dev *rtwdev,
+				      const struct rtw89_chan *chan,
+				      enum rtw89_rf_path path,
+				      enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_phy_bb_gain_info_be *gain = &rtwdev->bb_gain.be;
+	u8 gain_band = rtw89_subband_to_gain_band_be(chan->subband_type);
+	enum rtw89_phy_bb_bw_be bw_type;
+	s32 val;
+	u32 reg;
+	u32 mask;
+	int i;
+
+	bw_type = chan->band_width <= RTW89_CHANNEL_WIDTH_40 ?
+		  RTW89_BB_BW_20_40 : RTW89_BB_BW_80_160_320;
+
+	for (i = 0; i < LNA_GAIN_NUM; i++) {
+		if (chan->band_type == RTW89_BAND_2G) {
+			reg = bb_gain_lna[i].gain_g[path];
+			mask = bb_gain_lna[i].gain_g_mask;
+		} else {
+			reg = bb_gain_lna[i].gain_a[path];
+			mask = bb_gain_lna[i].gain_a_mask;
+		}
+		val = gain->lna_gain[gain_band][bw_type][path][i];
+		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
+	}
+
+	for (i = 0; i < TIA_GAIN_NUM; i++) {
+		if (chan->band_type == RTW89_BAND_2G) {
+			reg = bb_gain_tia[i].gain_g[path];
+			mask = bb_gain_tia[i].gain_g_mask;
+		} else {
+			reg = bb_gain_tia[i].gain_a[path];
+			mask = bb_gain_tia[i].gain_a_mask;
+		}
+		val = gain->tia_gain[gain_band][bw_type][path][i];
+		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
+	}
+}
+
+static void rtw8922a_set_gain(struct rtw89_dev *rtwdev,
+			      const struct rtw89_chan *chan,
+			      enum rtw89_rf_path path,
+			      enum rtw89_phy_idx phy_idx)
+{
+	rtw8922a_set_lna_tia_gain(rtwdev, chan, path, phy_idx);
+	rtw8922a_set_rpl_gain(rtwdev, chan, path, phy_idx);
+}
+
+static void rtw8922a_ctrl_ch(struct rtw89_dev *rtwdev,
+			     const struct rtw89_chan *chan,
+			     enum rtw89_phy_idx phy_idx)
+{
+	rtw8922a_set_gain(rtwdev, chan, RF_PATH_A, phy_idx);
+	rtw8922a_set_gain(rtwdev, chan, RF_PATH_B, phy_idx);
+}
+
+static void rtw8922a_set_channel_bb(struct rtw89_dev *rtwdev,
+				    const struct rtw89_chan *chan,
+				    enum rtw89_phy_idx phy_idx)
+{
+	rtw8922a_ctrl_ch(rtwdev, chan, phy_idx);
+}
+
+static void rtw8922a_set_channel(struct rtw89_dev *rtwdev,
+				 const struct rtw89_chan *chan,
+				 enum rtw89_mac_idx mac_idx,
+				 enum rtw89_phy_idx phy_idx)
+{
+	rtw8922a_set_channel_bb(rtwdev, chan, phy_idx);
+}
+
 #ifdef CONFIG_PM
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8922a = {
 	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
@@ -610,6 +793,7 @@ static const struct wiphy_wowlan_support rtw_wowlan_stub_8922a = {
 #endif
 
 static const struct rtw89_chip_ops rtw8922a_chip_ops = {
+	.set_channel		= rtw8922a_set_channel,
 	.read_efuse		= rtw8922a_read_efuse,
 	.read_phycap		= rtw8922a_read_phycap,
 	.pwr_on_func		= rtw8922a_pwr_on_func,
-- 
2.25.1


