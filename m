Return-Path: <linux-wireless+bounces-1514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFE4824EBB
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 07:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E5A8B23DF6
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 06:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5679E2030C;
	Fri,  5 Jan 2024 06:43:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825191F19A
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4056gi9C32200578, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4056gi9C32200578
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 14:42:44 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 5 Jan 2024 14:42:44 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 5 Jan 2024
 14:42:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <cj.hsieh@realtek.com>, <hsuan8331@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/8] wifi: rtw89: phy: add parser to support RX gain dynamic setting flow
Date: Fri, 5 Jan 2024 14:42:22 +0800
Message-ID: <20240105064228.36580-3-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Chung-Hsuan Hung <hsuan8331@realtek.com>

Add RX gain offset dynamic setting flow according to different bands
and bandwidths. RX gain offset values will be different according to
different channel bands, therefore, this dynamic mechanism is needed
while channel is changed. Add this to parse data from the element of
firmware file, and then we can use them easier at runtime.

Signed-off-by: Chung-Hsuan Hung <hsuan8331@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h   |  64 +++++++
 drivers/net/wireless/realtek/rtw89/phy.c    |  11 +-
 drivers/net/wireless/realtek/rtw89/phy.h    |  36 ++++
 drivers/net/wireless/realtek/rtw89/phy_be.c | 175 ++++++++++++++++++++
 4 files changed, 281 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8c5b831c3a37..1b74ba9e1a8b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4605,6 +4605,48 @@ enum rtw89_phy_bb_gain_band {
 	RTW89_BB_GAIN_BAND_NR,
 };
 
+enum rtw89_phy_gain_band_be {
+	RTW89_BB_GAIN_BAND_2G_BE = 0,
+	RTW89_BB_GAIN_BAND_5G_L_BE = 1,
+	RTW89_BB_GAIN_BAND_5G_M_BE = 2,
+	RTW89_BB_GAIN_BAND_5G_H_BE = 3,
+	RTW89_BB_GAIN_BAND_6G_L0_BE = 4,
+	RTW89_BB_GAIN_BAND_6G_L1_BE = 5,
+	RTW89_BB_GAIN_BAND_6G_M0_BE = 6,
+	RTW89_BB_GAIN_BAND_6G_M1_BE = 7,
+	RTW89_BB_GAIN_BAND_6G_H0_BE = 8,
+	RTW89_BB_GAIN_BAND_6G_H1_BE = 9,
+	RTW89_BB_GAIN_BAND_6G_UH0_BE = 10,
+	RTW89_BB_GAIN_BAND_6G_UH1_BE = 11,
+
+	RTW89_BB_GAIN_BAND_NR_BE,
+};
+
+enum rtw89_phy_bb_bw_be {
+	RTW89_BB_BW_20_40 = 0,
+	RTW89_BB_BW_80_160_320 = 1,
+
+	RTW89_BB_BW_NR_BE,
+};
+
+enum rtw89_bw20_sc {
+	RTW89_BW20_SC_20M = 1,
+	RTW89_BW20_SC_40M = 2,
+	RTW89_BW20_SC_80M = 4,
+	RTW89_BW20_SC_160M = 8,
+	RTW89_BW20_SC_320M = 16,
+};
+
+enum rtw89_cmac_table_bw {
+	RTW89_CMAC_BW_20M = 0,
+	RTW89_CMAC_BW_40M = 1,
+	RTW89_CMAC_BW_80M = 2,
+	RTW89_CMAC_BW_160M = 3,
+	RTW89_CMAC_BW_320M = 4,
+
+	RTW89_CMAC_BW_NR,
+};
+
 enum rtw89_phy_bb_rxsc_num {
 	RTW89_BB_RXSC_NUM_40 = 9, /* SC: 0, 1~8 */
 	RTW89_BB_RXSC_NUM_80 = 13, /* SC: 0, 1~8, 9~12 */
@@ -4627,6 +4669,27 @@ struct rtw89_phy_bb_gain_info {
 		       [RTW89_BB_RXSC_NUM_160];
 };
 
+struct rtw89_phy_bb_gain_info_be {
+	s8 lna_gain[RTW89_BB_GAIN_BAND_NR_BE][RTW89_BB_BW_NR_BE][RF_PATH_MAX]
+		   [LNA_GAIN_NUM];
+	s8 tia_gain[RTW89_BB_GAIN_BAND_NR_BE][RTW89_BB_BW_NR_BE][RF_PATH_MAX]
+		   [TIA_GAIN_NUM];
+	s8 lna_gain_bypass[RTW89_BB_GAIN_BAND_NR_BE][RTW89_BB_BW_NR_BE]
+			  [RF_PATH_MAX][LNA_GAIN_NUM];
+	s8 lna_op1db[RTW89_BB_GAIN_BAND_NR_BE][RTW89_BB_BW_NR_BE]
+		    [RF_PATH_MAX][LNA_GAIN_NUM];
+	s8 tia_lna_op1db[RTW89_BB_GAIN_BAND_NR_BE][RTW89_BB_BW_NR_BE]
+			[RF_PATH_MAX][LNA_GAIN_NUM + 1];
+	s8 rpl_ofst_20[RTW89_BB_GAIN_BAND_NR_BE][RF_PATH_MAX]
+		      [RTW89_BW20_SC_20M];
+	s8 rpl_ofst_40[RTW89_BB_GAIN_BAND_NR_BE][RF_PATH_MAX]
+		      [RTW89_BW20_SC_40M];
+	s8 rpl_ofst_80[RTW89_BB_GAIN_BAND_NR_BE][RF_PATH_MAX]
+		      [RTW89_BW20_SC_80M];
+	s8 rpl_ofst_160[RTW89_BB_GAIN_BAND_NR_BE][RF_PATH_MAX]
+		       [RTW89_BW20_SC_160M];
+};
+
 struct rtw89_phy_efuse_gain {
 	bool offset_valid;
 	bool comp_valid;
@@ -4826,6 +4889,7 @@ struct rtw89_dev {
 	struct rtw89_phy_ch_info ch_info;
 	union {
 		struct rtw89_phy_bb_gain_info ax;
+		struct rtw89_phy_bb_gain_info_be be;
 	} bb_gain;
 	struct rtw89_phy_efuse_gain efuse_gain;
 	struct rtw89_phy_ul_tb_info ul_tb_info;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index b2729c2550db..5e65d1e9a2c8 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1108,10 +1108,10 @@ rtw89_phy_cfg_bb_gain_op1db(struct rtw89_dev *rtwdev,
 	}
 }
 
-static void rtw89_phy_config_bb_gain(struct rtw89_dev *rtwdev,
-				     const struct rtw89_reg2_def *reg,
-				     enum rtw89_rf_path rf_path,
-				     void *extra_data)
+static void rtw89_phy_config_bb_gain_ax(struct rtw89_dev *rtwdev,
+					const struct rtw89_reg2_def *reg,
+					enum rtw89_rf_path rf_path,
+					void *extra_data)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	union rtw89_phy_bb_gain_arg arg = { .addr = reg->addr };
@@ -1425,7 +1425,7 @@ void rtw89_phy_init_bb_reg(struct rtw89_dev *rtwdev)
 	bb_gain_table = elm_info->bb_gain ? elm_info->bb_gain : chip->bb_gain_table;
 	if (bb_gain_table)
 		rtw89_phy_init_reg(rtwdev, bb_gain_table,
-				   rtw89_phy_config_bb_gain, NULL);
+				   chip->phy_def->config_bb_gain, NULL);
 	rtw89_phy_bb_reset(rtwdev, RTW89_PHY_0);
 }
 
@@ -5476,6 +5476,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_ax = {
 	.ccx = &rtw89_ccx_regs_ax,
 	.physts = &rtw89_physts_regs_ax,
 	.cfo = &rtw89_cfo_regs_ax,
+	.config_bb_gain = rtw89_phy_config_bb_gain_ax,
 
 	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_ax,
 	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 3e379077c6ca..70943117242e 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -509,6 +509,10 @@ struct rtw89_phy_gen_def {
 	const struct rtw89_ccx_regs *ccx;
 	const struct rtw89_physts_regs *physts;
 	const struct rtw89_cfo_regs *cfo;
+	void (*config_bb_gain)(struct rtw89_dev *rtwdev,
+			       const struct rtw89_reg2_def *reg,
+			       enum rtw89_rf_path rf_path,
+			       void *extra_data);
 
 	void (*set_txpwr_byrate)(struct rtw89_dev *rtwdev,
 				 const struct rtw89_chan *chan,
@@ -664,6 +668,38 @@ enum rtw89_phy_bb_gain_band rtw89_subband_to_bb_gain_band(enum rtw89_subband sub
 	}
 }
 
+static inline
+enum rtw89_phy_gain_band_be rtw89_subband_to_gain_band_be(enum rtw89_subband subband)
+{
+	switch (subband) {
+	default:
+	case RTW89_CH_2G:
+		return RTW89_BB_GAIN_BAND_2G_BE;
+	case RTW89_CH_5G_BAND_1:
+		return RTW89_BB_GAIN_BAND_5G_L_BE;
+	case RTW89_CH_5G_BAND_3:
+		return RTW89_BB_GAIN_BAND_5G_M_BE;
+	case RTW89_CH_5G_BAND_4:
+		return RTW89_BB_GAIN_BAND_5G_H_BE;
+	case RTW89_CH_6G_BAND_IDX0:
+		return RTW89_BB_GAIN_BAND_6G_L0_BE;
+	case RTW89_CH_6G_BAND_IDX1:
+		return RTW89_BB_GAIN_BAND_6G_L1_BE;
+	case RTW89_CH_6G_BAND_IDX2:
+		return RTW89_BB_GAIN_BAND_6G_M0_BE;
+	case RTW89_CH_6G_BAND_IDX3:
+		return RTW89_BB_GAIN_BAND_6G_M1_BE;
+	case RTW89_CH_6G_BAND_IDX4:
+		return RTW89_BB_GAIN_BAND_6G_H0_BE;
+	case RTW89_CH_6G_BAND_IDX5:
+		return RTW89_BB_GAIN_BAND_6G_H1_BE;
+	case RTW89_CH_6G_BAND_IDX6:
+		return RTW89_BB_GAIN_BAND_6G_UH0_BE;
+	case RTW89_CH_6G_BAND_IDX7:
+		return RTW89_BB_GAIN_BAND_6G_UH1_BE;
+	}
+}
+
 enum rtw89_rfk_flag {
 	RTW89_RFK_F_WRF = 0,
 	RTW89_RFK_F_WM = 1,
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 63eeeea72b68..b65de183156b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -78,6 +78,180 @@ static const struct rtw89_cfo_regs rtw89_cfo_regs_be = {
 	.valid_0_mask = B_DCFO_OPT_EN_V1,
 };
 
+union rtw89_phy_bb_gain_arg_be {
+	u32 addr;
+	struct {
+		u8 type;
+#define BB_GAIN_TYPE_SUB0_BE GENMASK(3, 0)
+#define BB_GAIN_TYPE_SUB1_BE GENMASK(7, 4)
+		u8 path_bw;
+#define BB_GAIN_PATH_BE GENMASK(3, 0)
+#define BB_GAIN_BW_BE GENMASK(7, 4)
+		u8 gain_band;
+		u8 cfg_type;
+	} __packed;
+} __packed;
+
+static void
+rtw89_phy_cfg_bb_gain_error_be(struct rtw89_dev *rtwdev,
+			       union rtw89_phy_bb_gain_arg_be arg, u32 data)
+{
+	struct rtw89_phy_bb_gain_info_be *gain = &rtwdev->bb_gain.be;
+	u8 bw_type = u8_get_bits(arg.path_bw, BB_GAIN_BW_BE);
+	u8 path = u8_get_bits(arg.path_bw, BB_GAIN_PATH_BE);
+	u8 gband = arg.gain_band;
+	u8 type = arg.type;
+	int i;
+
+	switch (type) {
+	case 0:
+		for (i = 0; i < 4; i++, data >>= 8)
+			gain->lna_gain[gband][bw_type][path][i] = data & 0xff;
+		break;
+	case 1:
+		for (i = 4; i < 7; i++, data >>= 8)
+			gain->lna_gain[gband][bw_type][path][i] = data & 0xff;
+		break;
+	case 2:
+		for (i = 0; i < 2; i++, data >>= 8)
+			gain->tia_gain[gband][bw_type][path][i] = data & 0xff;
+		break;
+	default:
+		rtw89_warn(rtwdev,
+			   "bb gain error {0x%x:0x%x} with unknown type: %d\n",
+			   arg.addr, data, type);
+		break;
+	}
+}
+
+static void
+rtw89_phy_cfg_bb_rpl_ofst_be(struct rtw89_dev *rtwdev,
+			     union rtw89_phy_bb_gain_arg_be arg, u32 data)
+{
+	struct rtw89_phy_bb_gain_info_be *gain = &rtwdev->bb_gain.be;
+	u8 type_sub0 = u8_get_bits(arg.type, BB_GAIN_TYPE_SUB0_BE);
+	u8 type_sub1 = u8_get_bits(arg.type, BB_GAIN_TYPE_SUB1_BE);
+	u8 path = u8_get_bits(arg.path_bw, BB_GAIN_PATH_BE);
+	u8 gband = arg.gain_band;
+	u8 ofst = 0;
+	int i;
+
+	switch (type_sub1) {
+	case RTW89_CMAC_BW_20M:
+		gain->rpl_ofst_20[gband][path][0] = (s8)data;
+		break;
+	case RTW89_CMAC_BW_40M:
+		for (i = 0; i < RTW89_BW20_SC_40M; i++, data >>= 8)
+			gain->rpl_ofst_40[gband][path][i] = data & 0xff;
+		break;
+	case RTW89_CMAC_BW_80M:
+		for (i = 0; i < RTW89_BW20_SC_80M; i++, data >>= 8)
+			gain->rpl_ofst_80[gband][path][i] = data & 0xff;
+		break;
+	case RTW89_CMAC_BW_160M:
+		if (type_sub0 == 0)
+			ofst = 0;
+		else
+			ofst = RTW89_BW20_SC_80M;
+
+		for (i = 0; i < RTW89_BW20_SC_80M; i++, data >>= 8)
+			gain->rpl_ofst_160[gband][path][i + ofst] = data & 0xff;
+		break;
+	default:
+		rtw89_warn(rtwdev,
+			   "bb rpl ofst {0x%x:0x%x} with unknown type_sub1: %d\n",
+			   arg.addr, data, type_sub1);
+		break;
+	}
+}
+
+static void
+rtw89_phy_cfg_bb_gain_op1db_be(struct rtw89_dev *rtwdev,
+			       union rtw89_phy_bb_gain_arg_be arg, u32 data)
+{
+	struct rtw89_phy_bb_gain_info_be *gain = &rtwdev->bb_gain.be;
+	u8 bw_type = u8_get_bits(arg.path_bw, BB_GAIN_BW_BE);
+	u8 path = u8_get_bits(arg.path_bw, BB_GAIN_PATH_BE);
+	u8 gband = arg.gain_band;
+	u8 type = arg.type;
+	int i;
+
+	switch (type) {
+	case 0:
+		for (i = 0; i < 4; i++, data >>= 8)
+			gain->lna_op1db[gband][bw_type][path][i] = data & 0xff;
+		break;
+	case 1:
+		for (i = 4; i < 7; i++, data >>= 8)
+			gain->lna_op1db[gband][bw_type][path][i] = data & 0xff;
+		break;
+	case 2:
+		for (i = 0; i < 4; i++, data >>= 8)
+			gain->tia_lna_op1db[gband][bw_type][path][i] = data & 0xff;
+		break;
+	case 3:
+		for (i = 4; i < 8; i++, data >>= 8)
+			gain->tia_lna_op1db[gband][bw_type][path][i] = data & 0xff;
+		break;
+	default:
+		rtw89_warn(rtwdev,
+			   "bb gain op1db {0x%x:0x%x} with unknown type: %d\n",
+			   arg.addr, data, type);
+		break;
+	}
+}
+
+static void rtw89_phy_config_bb_gain_be(struct rtw89_dev *rtwdev,
+					const struct rtw89_reg2_def *reg,
+					enum rtw89_rf_path rf_path,
+					void *extra_data)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	union rtw89_phy_bb_gain_arg_be arg = { .addr = reg->addr };
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	u8 bw_type = u8_get_bits(arg.path_bw, BB_GAIN_BW_BE);
+	u8 path = u8_get_bits(arg.path_bw, BB_GAIN_PATH_BE);
+
+	if (bw_type >= RTW89_BB_BW_NR_BE)
+		return;
+
+	if (arg.gain_band >= RTW89_BB_GAIN_BAND_NR_BE)
+		return;
+
+	if (path >= chip->rf_path_num)
+		return;
+
+	if (arg.addr >= 0xf9 && arg.addr <= 0xfe) {
+		rtw89_warn(rtwdev, "bb gain table with flow ctrl\n");
+		return;
+	}
+
+	switch (arg.cfg_type) {
+	case 0:
+		rtw89_phy_cfg_bb_gain_error_be(rtwdev, arg, reg->data);
+		break;
+	case 1:
+		rtw89_phy_cfg_bb_rpl_ofst_be(rtwdev, arg, reg->data);
+		break;
+	case 2:
+		/* ignore BB gain bypass */
+		break;
+	case 3:
+		rtw89_phy_cfg_bb_gain_op1db_be(rtwdev, arg, reg->data);
+		break;
+	case 4:
+		/* This cfg_type is only used by rfe_type >= 50 with eFEM */
+		if (efuse->rfe_type < 50)
+			break;
+		fallthrough;
+	default:
+		rtw89_warn(rtwdev,
+			   "bb gain {0x%x:0x%x} with unknown cfg type: %d\n",
+			   arg.addr, reg->data, arg.cfg_type);
+		break;
+	}
+}
+
 struct rtw89_byr_spec_ent_be {
 	struct rtw89_rate_desc init;
 	u8 num_of_idx;
@@ -644,6 +818,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 	.ccx = &rtw89_ccx_regs_be,
 	.physts = &rtw89_physts_regs_be,
 	.cfo = &rtw89_cfo_regs_be,
+	.config_bb_gain = rtw89_phy_config_bb_gain_be,
 
 	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_be,
 	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_be,
-- 
2.25.1


