Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB8C5005E1
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Apr 2022 08:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbiDNGXl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Apr 2022 02:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240028AbiDNGXg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Apr 2022 02:23:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B072B4A3D7
        for <linux-wireless@vger.kernel.org>; Wed, 13 Apr 2022 23:21:11 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23E6L4ixC001365, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23E6L4ixC001365
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Apr 2022 14:21:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 14:21:04 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 14 Apr
 2022 14:21:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 07/12] rtw89: 8852c: add efuse gain offset parser
Date:   Thu, 14 Apr 2022 14:20:21 +0800
Message-ID: <20220414062027.62638-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414062027.62638-1-pkshih@realtek.com>
References: <20220414062027.62638-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/14/2022 06:05:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMTQgpFekyCAwMzo1OTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Define efuse struct to access gain offset, and store them for further use
by setting channel.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  17 +++
 drivers/net/wireless/realtek/rtw89/reg.h      |  19 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 101 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |  18 +++-
 4 files changed, 151 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8ceee254d6274..f34aca70908e0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -74,6 +74,16 @@ enum rtw89_subband {
 	RTW89_SUBBAND_NR,
 };
 
+enum rtw89_gain_offset {
+	RTW89_GAIN_OFFSET_2G_CCK,
+	RTW89_GAIN_OFFSET_2G_OFDM,
+	RTW89_GAIN_OFFSET_5G_LOW,
+	RTW89_GAIN_OFFSET_5G_MID,
+	RTW89_GAIN_OFFSET_5G_HIGH,
+
+	RTW89_GAIN_OFFSET_NR,
+};
+
 enum rtw89_hci_type {
 	RTW89_HCI_TYPE_PCIE,
 	RTW89_HCI_TYPE_USB,
@@ -3035,6 +3045,12 @@ struct rtw89_phy_bb_gain_info {
 		       [RTW89_BB_RXSC_NUM_160];
 };
 
+struct rtw89_phy_efuse_gain {
+	bool offset_valid;
+	s8 offset[RF_PATH_MAX][RTW89_GAIN_OFFSET_NR]; /* S(8, 0) */
+	s8 offset_base[RTW89_PHY_MAX]; /* S(8, 4) */
+};
+
 struct rtw89_dev {
 	struct ieee80211_hw *hw;
 	struct device *dev;
@@ -3098,6 +3114,7 @@ struct rtw89_dev {
 	struct rtw89_dig_info dig;
 	struct rtw89_phy_ch_info ch_info;
 	struct rtw89_phy_bb_gain_info bb_gain;
+	struct rtw89_phy_efuse_gain efuse_gain;
 
 	struct delayed_work track_work;
 	struct delayed_work coex_act1_work;
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index a7daca1d462c0..bd5526ffb8dbd 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3470,6 +3470,8 @@
 #define B_TXFIR_CEF GENMASK(23, 0)
 #define R_11B_RX_V1 0x2320
 #define B_11B_RXCCA_DIS_V1 BIT(0)
+#define R_RPL_OFST 0x2340
+#define B_RPL_OFST_MASK GENMASK(14, 8)
 #define R_RXCCA 0x2344
 #define B_RXCCA_DIS BIT(31)
 #define R_RXCCA_V1 0x2320
@@ -3570,6 +3572,11 @@
 #define B_PATH0_P20_FOLLOW_BY_PAGCUGC_EN_MSK BIT(5)
 #define R_PATH0_S20_FOLLOW_BY_PAGCUGC 0x46A4
 #define B_PATH0_S20_FOLLOW_BY_PAGCUGC_EN_MSK BIT(5)
+#define R_PATH0_G_TIA0_LNA6_OP1DB_V1 0x4694
+#define B_PATH0_G_TIA0_LNA6_OP1DB_V1 GENMASK(7, 0)
+#define R_PATH0_G_TIA1_LNA6_OP1DB_V1 0x4694
+#define B_PATH0_R_G_OFST_MASK GENMASK(23, 16)
+#define B_PATH0_G_TIA1_LNA6_OP1DB_V1 GENMASK(15, 8)
 #define R_P0_NBIIDX 0x469C
 #define B_P0_NBIIDX_VAL GENMASK(11, 0)
 #define B_P0_NBIIDX_NOTCH_EN BIT(12)
@@ -3587,6 +3594,8 @@
 #define B_PATH1_P20_FOLLOW_BY_PAGCUGC_EN_MSK BIT(5)
 #define R_PATH1_S20_FOLLOW_BY_PAGCUGC 0x4778
 #define B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK BIT(5)
+#define R_PATH1_G_TIA0_LNA6_OP1DB_V1 0x4778
+#define B_PATH1_G_TIA0_LNA6_OP1DB_V1 GENMASK(7, 0)
 #define R_P1_NBIIDX 0x4770
 #define B_P1_NBIIDX_VAL GENMASK(11, 0)
 #define B_P1_NBIIDX_NOTCH_EN BIT(12)
@@ -3601,6 +3610,14 @@
 #define R_CHBW_MOD 0x4978
 #define B_CHBW_MOD_PRICH GENMASK(11, 8)
 #define B_CHBW_MOD_SBW GENMASK(13, 12)
+#define R_RPL_BIAS_COMP 0x4DF0
+#define B_RPL_BIAS_COMP_MASK GENMASK(7, 0)
+#define R_RPL_PATHAB 0x4E0C
+#define B_RPL_PATHB_MASK GENMASK(23, 16)
+#define B_RPL_PATHA_MASK GENMASK(15, 8)
+#define R_RSSI_M_PATHAB 0x4E2C
+#define B_RSSI_M_PATHB_MASK GENMASK(15, 8)
+#define B_RSSI_M_PATHA_MASK GENMASK(7, 0)
 #define R_DCFO_COMP_S0_V1 0x4A40
 #define B_DCFO_COMP_S0_V1_MSK GENMASK(13, 0)
 #define R_BMODE_PDTH_V1 0x4B64
@@ -3669,6 +3686,8 @@
 #define B_S0_DACKQ7_K GENMASK(15, 8)
 #define R_S0_DACKQ8 0x5E98
 #define B_S0_DACKQ8_K GENMASK(15, 8)
+#define R_RPL_BIAS_COMP1 0x6DF0
+#define B_RPL_BIAS_COMP1_MASK GENMASK(7, 0)
 #define R_P1_TMETER 0x7810
 #define B_P1_TMETER GENMASK(15, 10)
 #define B_P1_TMETER_DIS BIT(16)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index dba2799383472..bb935632ce40d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -317,6 +317,41 @@ static void rtw8852c_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
 	}
 }
 
+static bool _decode_efuse_gain(u8 data, s8 *high, s8 *low)
+{
+	if (high)
+		*high = sign_extend32(FIELD_GET(GENMASK(7,  4), data), 3);
+	if (low)
+		*low = sign_extend32(FIELD_GET(GENMASK(3,  0), data), 3);
+
+	return data != 0xff;
+}
+
+static void rtw8852c_efuse_parsing_gain_offset(struct rtw89_dev *rtwdev,
+					       struct rtw8852c_efuse *map)
+{
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+	bool valid = false;
+
+	valid |= _decode_efuse_gain(map->rx_gain_2g_cck,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_2G_CCK],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_2G_CCK]);
+	valid |= _decode_efuse_gain(map->rx_gain_2g_ofdm,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_2G_OFDM],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_2G_OFDM]);
+	valid |= _decode_efuse_gain(map->rx_gain_5g_low,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_LOW],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_5G_LOW]);
+	valid |= _decode_efuse_gain(map->rx_gain_5g_mid,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_MID],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_5G_MID]);
+	valid |= _decode_efuse_gain(map->rx_gain_5g_high,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_HIGH],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_5G_HIGH]);
+
+	gain->offset_valid = valid;
+}
+
 static int rtw8852c_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map)
 {
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
@@ -327,6 +362,7 @@ static int rtw8852c_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map)
 	efuse->country_code[0] = map->country_code[0];
 	efuse->country_code[1] = map->country_code[1];
 	rtw8852c_efuse_parsing_tssi(rtwdev, map);
+	rtw8852c_efuse_parsing_gain_offset(rtwdev, map);
 
 	switch (rtwdev->hci.type) {
 	case RTW89_HCI_TYPE_PCIE:
@@ -673,6 +709,63 @@ static void rtw8852c_set_gain_error(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw8852c_set_gain_offset(struct rtw89_dev *rtwdev,
+				     const struct rtw89_channel_params *param,
+				     enum rtw89_phy_idx phy_idx,
+				     enum rtw89_rf_path path)
+{
+	static const u32 rssi_ofst_addr[2] = {R_PATH0_G_TIA0_LNA6_OP1DB_V1,
+					      R_PATH1_G_TIA0_LNA6_OP1DB_V1};
+	static const u32 rpl_mask[2] = {B_RPL_PATHA_MASK, B_RPL_PATHB_MASK};
+	static const u32 rpl_tb_mask[2] = {B_RSSI_M_PATHA_MASK, B_RSSI_M_PATHB_MASK};
+	struct rtw89_phy_efuse_gain *efuse_gain = &rtwdev->efuse_gain;
+	enum rtw89_gain_offset gain_band;
+	s32 offset_q0, offset_base_q4;
+	s32 tmp = 0;
+
+	if (!efuse_gain->offset_valid)
+		return;
+
+	if (rtwdev->dbcc_en && path == RF_PATH_B)
+		phy_idx = RTW89_PHY_1;
+
+	if (param->band_type == RTW89_BAND_2G) {
+		offset_q0 = efuse_gain->offset[path][RTW89_GAIN_OFFSET_2G_CCK];
+		offset_base_q4 = efuse_gain->offset_base[phy_idx];
+
+		tmp = clamp_t(s32, (-offset_q0 << 3) + (offset_base_q4 >> 1),
+			      S8_MIN >> 1, S8_MAX >> 1);
+		rtw89_phy_write32_mask(rtwdev, R_RPL_OFST, B_RPL_OFST_MASK, tmp & 0x7f);
+	}
+
+	switch (param->subband_type) {
+	default:
+	case RTW89_CH_2G:
+		gain_band = RTW89_GAIN_OFFSET_2G_OFDM;
+		break;
+	case RTW89_CH_5G_BAND_1:
+		gain_band = RTW89_GAIN_OFFSET_5G_LOW;
+		break;
+	case RTW89_CH_5G_BAND_3:
+		gain_band = RTW89_GAIN_OFFSET_5G_MID;
+		break;
+	case RTW89_CH_5G_BAND_4:
+		gain_band = RTW89_GAIN_OFFSET_5G_HIGH;
+		break;
+	}
+
+	offset_q0 = -efuse_gain->offset[path][gain_band];
+	offset_base_q4 = efuse_gain->offset_base[phy_idx];
+
+	tmp = (offset_q0 << 2) + (offset_base_q4 >> 2);
+	tmp = clamp_t(s32, -tmp, S8_MIN, S8_MAX);
+	rtw89_phy_write32_mask(rtwdev, rssi_ofst_addr[path], B_PATH0_R_G_OFST_MASK, tmp & 0xff);
+
+	tmp = clamp_t(s32, offset_q0 << 4, S8_MIN, S8_MAX);
+	rtw89_phy_write32_idx(rtwdev, R_RPL_PATHAB, rpl_mask[path], tmp & 0xff, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_RSSI_M_PATHAB, rpl_tb_mask[path], tmp & 0xff, phy_idx);
+}
+
 static void rtw8852c_bb_reset_all(struct rtw89_dev *rtwdev,
 				  enum rtw89_phy_idx phy_idx)
 {
@@ -844,6 +937,8 @@ static void rtw8852c_bb_macid_ctrl_init(struct rtw89_dev *rtwdev,
 
 static void rtw8852c_bb_sethw(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+
 	rtw89_phy_write32_set(rtwdev, R_DBCC_80P80_SEL_EVM_RPT,
 			      B_DBCC_80P80_SEL_EVM_RPT_EN);
 	rtw89_phy_write32_set(rtwdev, R_DBCC_80P80_SEL_EVM_RPT2,
@@ -851,6 +946,12 @@ static void rtw8852c_bb_sethw(struct rtw89_dev *rtwdev)
 
 	rtw8852c_bb_macid_ctrl_init(rtwdev, RTW89_PHY_0);
 	rtw8852c_bb_gpio_init(rtwdev);
+
+	/* read these registers after loading BB parameters */
+	gain->offset_base[RTW89_PHY_0] =
+		rtw89_phy_read32_mask(rtwdev, R_RPL_BIAS_COMP, B_RPL_BIAS_COMP_MASK);
+	gain->offset_base[RTW89_PHY_1] =
+		rtw89_phy_read32_mask(rtwdev, R_RPL_BIAS_COMP1, B_RPL_BIAS_COMP1_MASK);
 }
 
 static
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.h b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
index d1c5b4367a9d2..ac642808a81ff 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
@@ -59,13 +59,23 @@ struct rtw8852c_efuse {
 	u8 rsvd7[3];
 	u8 path_a_therm;
 	u8 path_b_therm;
-	u8 rsvd8[46];
+	u8 rsvd8[2];
+	u8 rx_gain_2g_ofdm;
+	u8 rsvd9;
+	u8 rx_gain_2g_cck;
+	u8 rsvd10;
+	u8 rx_gain_5g_low;
+	u8 rsvd11;
+	u8 rx_gain_5g_mid;
+	u8 rsvd12;
+	u8 rx_gain_5g_high;
+	u8 rsvd13[35];
 	u8 bw40_1s_tssi_6g_a[TSSI_MCS_6G_CH_GROUP_NUM];
-	u8 rsvd9[10];
+	u8 rsvd14[10];
 	u8 bw40_1s_tssi_6g_b[TSSI_MCS_6G_CH_GROUP_NUM];
-	u8 rsvd10[110];
+	u8 rsvd15[110];
 	u8 channel_plan_6g;
-	u8 rsvd11[71];
+	u8 rsvd16[71];
 	union {
 		struct rtw8852c_u_efuse u;
 		struct rtw8852c_e_efuse e;
-- 
2.25.1

