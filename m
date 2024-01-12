Return-Path: <linux-wireless+bounces-1769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A58082B95A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 03:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7BB1C22E79
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 02:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B9F4A14;
	Fri, 12 Jan 2024 02:11:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCF64A13
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 02:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40C2BGIK02061539, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40C2BGIK02061539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 10:11:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 12 Jan 2024 10:11:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Jan
 2024 10:11:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <hsuan8331@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] wifi: rtw89: 8922a: add TX power related ops
Date: Fri, 12 Jan 2024 10:10:32 +0800
Message-ID: <20240112021033.20104-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112021033.20104-1-pkshih@realtek.com>
References: <20240112021033.20104-1-pkshih@realtek.com>
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

The ::power_trim is to write bias value programmed in efuse to normalize
TX power, and then using ::set_txpwr_ctrl to set reference TX power value.
The ::set_txpwr is to set final TX power according to regulation of current
country.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  18 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 187 ++++++++++++++++++
 2 files changed, 204 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index b9e191d1c122..0a07731abb39 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7454,8 +7454,12 @@
 #define RR_TXAC 0x5f
 #define RR_TXAC_IQG GENMASK(3, 0)
 #define RR_BIASA 0x60
-#define RR_BIASA_TXG GENMASK(15, 12)
 #define RR_BIASA_TXA GENMASK(19, 16)
+#define RR_BIASA_TXG GENMASK(15, 12)
+#define RR_BIASD_TXA_V1 GENMASK(15, 12)
+#define RR_BIASA_TXA_V1 GENMASK(11, 8)
+#define RR_BIASD_TXG_V1 GENMASK(7, 4)
+#define RR_BIASA_TXG_V1 GENMASK(3, 0)
 #define RR_BIASA_A GENMASK(2, 0)
 #define RR_BIASA2 0x63
 #define RR_BIASA2_LB GENMASK(4, 2)
@@ -8832,6 +8836,18 @@
 #define R_IQK_DPK_PRST 0xE4AC
 #define R_IQK_DPK_PRST_C1 0xE5AC
 #define B_IQK_DPK_PRST BIT(27)
+#define R_TSSI_MAP_OFST_P0 0xE620
+#define R_TSSI_MAP_OFST_P1 0xE720
+#define B_TSSI_MAP_OFST_OFDM GENMASK(17, 9)
+#define B_TSSI_MAP_OFST_CCK GENMASK(26, 18)
+#define R_TXAGC_REF0_P0 0xE628
+#define R_TXAGC_REF0_P1 0xE728
+#define B_TXAGC_REF0_OFDM_DBM GENMASK(8, 0)
+#define B_TXAGC_REF0_CCK_DBM GENMASK(17, 9)
+#define B_TXAGC_REF0_OFDM_CW GENMASK(26, 18)
+#define R_TXAGC_REF1_P0 0xE62C
+#define R_TXAGC_REF1_P1 0xE72C
+#define B_TXAGC_REF1_CCK_CW GENMASK(8, 0)
 
 /* WiFi CPU local domain */
 #define R_AX_WDT_CTRL 0x0040
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 39b60eaec945..c098395dba11 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -644,6 +644,32 @@ static void rtw8922a_phycap_parsing_pa_bias_trim(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw8922a_pa_bias_trim(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u8 pabias_2g, pabias_5g;
+	u8 i;
+
+	if (!info->pg_pa_bias_trim) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PA_BIAS][TRIM] no PG, do nothing\n");
+
+		return;
+	}
+
+	for (i = 0; i < RF_PATH_NUM_8922A; i++) {
+		pabias_2g = FIELD_GET(GENMASK(3, 0), info->pa_bias_trim[i]);
+		pabias_5g = FIELD_GET(GENMASK(7, 4), info->pa_bias_trim[i]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PA_BIAS][TRIM] path=%d 2G=0x%x 5G=0x%x\n",
+			    i, pabias_2g, pabias_5g);
+
+		rtw89_write_rf(rtwdev, i, RR_BIASA, RR_BIASA_TXG_V1, pabias_2g);
+		rtw89_write_rf(rtwdev, i, RR_BIASA, RR_BIASA_TXA_V1, pabias_5g);
+	}
+}
+
 static void rtw8922a_phycap_parsing_pad_bias_trim(struct rtw89_dev *rtwdev,
 						  u8 *phycap_map)
 {
@@ -661,6 +687,31 @@ static void rtw8922a_phycap_parsing_pad_bias_trim(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw8922a_pad_bias_trim(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u8 pad_bias_2g, pad_bias_5g;
+	u8 i;
+
+	if (!info->pg_pa_bias_trim) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PAD_BIAS][TRIM] no PG, do nothing\n");
+		return;
+	}
+
+	for (i = 0; i < RF_PATH_NUM_8922A; i++) {
+		pad_bias_2g = u8_get_bits(info->pad_bias_trim[i], GENMASK(3, 0));
+		pad_bias_5g = u8_get_bits(info->pad_bias_trim[i], GENMASK(7, 4));
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PAD_BIAS][TRIM] path=%d 2G=0x%x 5G=0x%x\n",
+			    i, pad_bias_2g, pad_bias_5g);
+
+		rtw89_write_rf(rtwdev, i, RR_BIASA, RR_BIASD_TXG_V1, pad_bias_2g);
+		rtw89_write_rf(rtwdev, i, RR_BIASA, RR_BIASD_TXA_V1, pad_bias_5g);
+	}
+}
+
 static int rtw8922a_read_phycap(struct rtw89_dev *rtwdev, u8 *phycap_map)
 {
 	rtw8922a_phycap_parsing_thermal_trim(rtwdev, phycap_map);
@@ -670,6 +721,12 @@ static int rtw8922a_read_phycap(struct rtw89_dev *rtwdev, u8 *phycap_map)
 	return 0;
 }
 
+static void rtw8922a_power_trim(struct rtw89_dev *rtwdev)
+{
+	rtw8922a_pa_bias_trim(rtwdev);
+	rtw8922a_pad_bias_trim(rtwdev);
+}
+
 struct rtw8922a_bb_gain {
 	u32 gain_g[BB_PATH_NUM_8922A];
 	u32 gain_a[BB_PATH_NUM_8922A];
@@ -1008,6 +1065,131 @@ static void rtw8922a_set_channel(struct rtw89_dev *rtwdev,
 	rtw8922a_set_channel_bb(rtwdev, chan, phy_idx);
 }
 
+struct rtw8922a_bb_txpwr_ref_parm {
+	u16 ofst;
+	u16 dbm;
+	u16 cw;
+};
+
+static void rtw8922a_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_idx phy_idx,
+				      struct rtw8922a_bb_txpwr_ref_parm *parm,
+				      s16 ref_s9_2)
+{
+	const s16 tssi_16dbm_cw = 0x140;
+	const u8 base_cw_0db = 0x27;
+	u32 tssi_ofst_cw;
+	s16 pwr_s10_3;
+	s16 rf_pwr_cw;
+	u32 pwr_cw;
+
+	pwr_s10_3 = (ref_s9_2 << 1) + (s16)(base_cw_0db << 3);
+	rf_pwr_cw = clamp_t(s16, pwr_s10_3 >> 3, 15, 63);
+	pwr_cw = (rf_pwr_cw << 3) | u16_get_bits(pwr_s10_3, GENMASK(2, 0));
+	tssi_ofst_cw = tssi_16dbm_cw + (ref_s9_2 << 1) - (16 << 3);
+
+	parm->dbm = ref_s9_2;
+	parm->cw = pwr_cw;
+	parm->ofst = tssi_ofst_cw;
+}
+
+static void rtw8922a_set_txpwr_ref(struct rtw89_dev *rtwdev,
+				   enum rtw89_phy_idx phy_idx)
+{
+	struct rtw8922a_bb_txpwr_ref_parm ofdm, cck;
+	s16 ref_ofdm = 0;
+	s16 ref_cck = 0;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set txpwr reference\n");
+
+	rtw89_mac_txpwr_write32_mask(rtwdev, phy_idx, R_BE_PWR_REF_CTRL,
+				     B_BE_PWR_REF_CTRL_OFDM, ref_ofdm);
+	rtw89_mac_txpwr_write32_mask(rtwdev, phy_idx, R_BE_PWR_REF_CTRL,
+				     B_BE_PWR_REF_CTRL_CCK, ref_cck);
+
+	rtw8922a_bb_cal_txpwr_ref(rtwdev, phy_idx, &ofdm, ref_ofdm);
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+		    "[TXPWR] bb cal ofdm: ref 0x%x cw 0x%x ofst 0x%x\n",
+		    ofdm.dbm, ofdm.cw, ofdm.ofst);
+
+	rtw8922a_bb_cal_txpwr_ref(rtwdev, phy_idx, &cck, ref_cck);
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+		    "[TXPWR] bb cal cck: ref 0x%x cw 0x%x ofst 0x%x\n",
+		    cck.dbm, cck.cw, cck.ofst);
+
+	/* path 0 */
+	rtw89_phy_write32_mask(rtwdev, R_TXAGC_REF0_P0, B_TXAGC_REF0_OFDM_DBM,
+			       ofdm.dbm);
+	rtw89_phy_write32_mask(rtwdev, R_TXAGC_REF0_P0, B_TXAGC_REF0_CCK_DBM,
+			       cck.dbm);
+	rtw89_phy_write32_mask(rtwdev, R_TXAGC_REF0_P0, B_TXAGC_REF0_OFDM_CW,
+			       ofdm.cw);
+	rtw89_phy_write32_mask(rtwdev, R_TXAGC_REF1_P0, B_TXAGC_REF1_CCK_CW,
+			       cck.cw);
+	rtw89_phy_write32_mask(rtwdev, R_TSSI_MAP_OFST_P0, B_TSSI_MAP_OFST_OFDM,
+			       ofdm.ofst);
+	rtw89_phy_write32_mask(rtwdev, R_TSSI_MAP_OFST_P0, B_TSSI_MAP_OFST_CCK,
+			       cck.ofst);
+
+	/* path 1 */
+	rtw89_phy_write32_mask(rtwdev, R_TXAGC_REF0_P1, B_TXAGC_REF0_OFDM_DBM,
+			       ofdm.dbm);
+	rtw89_phy_write32_mask(rtwdev, R_TXAGC_REF0_P1, B_TXAGC_REF0_CCK_DBM,
+			       cck.dbm);
+	rtw89_phy_write32_mask(rtwdev, R_TXAGC_REF0_P1, B_TXAGC_REF0_OFDM_CW,
+			       ofdm.cw);
+	rtw89_phy_write32_mask(rtwdev, R_TXAGC_REF1_P1, B_TXAGC_REF1_CCK_CW,
+			       cck.cw);
+	rtw89_phy_write32_mask(rtwdev, R_TSSI_MAP_OFST_P1, B_TSSI_MAP_OFST_OFDM,
+			       ofdm.ofst);
+	rtw89_phy_write32_mask(rtwdev, R_TSSI_MAP_OFST_P1, B_TSSI_MAP_OFST_CCK,
+			       cck.ofst);
+}
+
+static void rtw8922a_bb_tx_triangular(struct rtw89_dev *rtwdev, bool en,
+				      enum rtw89_phy_idx phy_idx)
+{
+	u8 ctrl = en ? 0x1 : 0x0;
+
+	rtw89_phy_write32_idx(rtwdev, R_BEDGE3, B_BEDGE_CFG, ctrl, phy_idx);
+}
+
+static void rtw8922a_set_tx_shape(struct rtw89_dev *rtwdev,
+				  const struct rtw89_chan *chan,
+				  enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
+	const struct rtw89_tx_shape *tx_shape = &rfe_parms->tx_shape;
+	u8 tx_shape_idx;
+	u8 band, regd;
+
+	band = chan->band_type;
+	regd = rtw89_regd_get(rtwdev, band);
+	tx_shape_idx = (*tx_shape->lmt)[band][RTW89_RS_OFDM][regd];
+
+	if (tx_shape_idx == 0)
+		rtw8922a_bb_tx_triangular(rtwdev, false, phy_idx);
+	else
+		rtw8922a_bb_tx_triangular(rtwdev, true, phy_idx);
+}
+
+static void rtw8922a_set_txpwr(struct rtw89_dev *rtwdev,
+			       const struct rtw89_chan *chan,
+			       enum rtw89_phy_idx phy_idx)
+{
+	rtw89_phy_set_txpwr_byrate(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_offset(rtwdev, chan, phy_idx);
+	rtw8922a_set_tx_shape(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_limit(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
+}
+
+static void rtw8922a_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
+				    enum rtw89_phy_idx phy_idx)
+{
+	rtw8922a_set_txpwr_ref(rtwdev, phy_idx);
+}
+
 static int rtw8922a_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	rtw89_write8_set(rtwdev, R_BE_FEN_RST_ENABLE,
@@ -1044,6 +1226,11 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.set_channel		= rtw8922a_set_channel,
 	.read_efuse		= rtw8922a_read_efuse,
 	.read_phycap		= rtw8922a_read_phycap,
+	.power_trim		= rtw8922a_power_trim,
+	.set_txpwr		= rtw8922a_set_txpwr,
+	.set_txpwr_ctrl		= rtw8922a_set_txpwr_ctrl,
+	.init_txpwr_unit	= NULL,
+	.set_txpwr_ul_tb_offset	= NULL,
 	.pwr_on_func		= rtw8922a_pwr_on_func,
 	.pwr_off_func		= rtw8922a_pwr_off_func,
 };
-- 
2.25.1


