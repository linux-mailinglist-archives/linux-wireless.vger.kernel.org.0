Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DD7708E2F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 May 2023 05:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjESDPY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 23:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjESDPV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 23:15:21 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF73A110
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 20:15:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34J3F2wJ4004218, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34J3F2wJ4004218
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 19 May 2023 11:15:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 19 May 2023 11:15:11 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 19 May
 2023 11:15:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/7] wifi: rtw89: 8851b: add TX power related functions
Date:   Fri, 19 May 2023 11:14:54 +0800
Message-ID: <20230519031500.21087-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519031500.21087-1-pkshih@realtek.com>
References: <20230519031500.21087-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get TX power value from tables according to selected country and channel,
and set proper power to registers.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 254 ++++++++++++++++++
 1 file changed, 254 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 6ecdd3d3f776f..cead009b270d9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -448,6 +448,34 @@ static void rtw8851b_phycap_parsing_thermal_trim(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw8851b_thermal_trim(struct rtw89_dev *rtwdev)
+{
+#define __thm_setting(raw)				\
+({							\
+	u8 __v = (raw);					\
+	((__v & 0x1) << 3) | ((__v & 0x1f) >> 1);	\
+})
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u8 i, val;
+
+	if (!info->pg_thermal_trim) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[THERMAL][TRIM] no PG, do nothing\n");
+
+		return;
+	}
+
+	for (i = 0; i < RF_PATH_NUM_8851B; i++) {
+		val = __thm_setting(info->thermal_trim[i]);
+		rtw89_write_rf(rtwdev, i, RR_TM2, RR_TM2_OFF, val);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[THERMAL][TRIM] path=%d thermal_setting=0x%x\n",
+			    i, val);
+	}
+#undef __thm_setting
+}
+
 static void rtw8851b_phycap_parsing_pa_bias_trim(struct rtw89_dev *rtwdev,
 						 u8 *phycap_map)
 {
@@ -468,6 +496,32 @@ static void rtw8851b_phycap_parsing_pa_bias_trim(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw8851b_pa_bias_trim(struct rtw89_dev *rtwdev)
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
+	for (i = 0; i < RF_PATH_NUM_8851B; i++) {
+		pabias_2g = u8_get_bits(info->pa_bias_trim[i], GENMASK(3, 0));
+		pabias_5g = u8_get_bits(info->pa_bias_trim[i], GENMASK(7, 4));
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PA_BIAS][TRIM] path=%d 2G=0x%x 5G=0x%x\n",
+			    i, pabias_2g, pabias_5g);
+
+		rtw89_write_rf(rtwdev, i, RR_BIASA, RR_BIASA_TXG, pabias_2g);
+		rtw89_write_rf(rtwdev, i, RR_BIASA, RR_BIASA_TXA, pabias_5g);
+	}
+}
+
 static void rtw8851b_phycap_parsing_gain_comp(struct rtw89_dev *rtwdev, u8 *phycap_map)
 {
 	static const u32 comp_addrs[][RTW89_SUBBAND_2GHZ_5GHZ_NR] = {
@@ -565,6 +619,12 @@ static void rtw8851b_rfe_gpio(struct rtw89_dev *rtwdev)
 	}
 }
 
+static void rtw8851b_power_trim(struct rtw89_dev *rtwdev)
+{
+	rtw8851b_thermal_trim(rtwdev);
+	rtw8851b_pa_bias_trim(rtwdev);
+}
+
 static void rtw8851b_set_channel_mac(struct rtw89_dev *rtwdev,
 				     const struct rtw89_chan *chan,
 				     u8 mac_idx)
@@ -1355,6 +1415,195 @@ static void rtw8851b_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 	}
 }
 
+static u32 rtw8851b_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
+				     enum rtw89_phy_idx phy_idx, s16 ref)
+{
+	const u16 tssi_16dbm_cw = 0x12c;
+	const u8 base_cw_0db = 0x27;
+	const s8 ofst_int = 0;
+	s16 pwr_s10_3;
+	s16 rf_pwr_cw;
+	u16 bb_pwr_cw;
+	u32 pwr_cw;
+	u32 tssi_ofst_cw;
+
+	pwr_s10_3 = (ref << 1) + (s16)(ofst_int) + (s16)(base_cw_0db << 3);
+	bb_pwr_cw = u16_get_bits(pwr_s10_3, GENMASK(2, 0));
+	rf_pwr_cw = u16_get_bits(pwr_s10_3, GENMASK(8, 3));
+	rf_pwr_cw = clamp_t(s16, rf_pwr_cw, 15, 63);
+	pwr_cw = (rf_pwr_cw << 3) | bb_pwr_cw;
+
+	tssi_ofst_cw = (u32)((s16)tssi_16dbm_cw + (ref << 1) - (16 << 3));
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+		    "[TXPWR] tssi_ofst_cw=%d rf_cw=0x%x bb_cw=0x%x\n",
+		    tssi_ofst_cw, rf_pwr_cw, bb_pwr_cw);
+
+	return u32_encode_bits(tssi_ofst_cw, B_DPD_TSSI_CW) |
+	       u32_encode_bits(pwr_cw, B_DPD_PWR_CW) |
+	       u32_encode_bits(ref, B_DPD_REF);
+}
+
+static void rtw8851b_set_txpwr_ref(struct rtw89_dev *rtwdev,
+				   enum rtw89_phy_idx phy_idx)
+{
+	static const u32 addr[RF_PATH_NUM_8851B] = {0x5800};
+	const u32 mask = B_DPD_TSSI_CW | B_DPD_PWR_CW | B_DPD_REF;
+	const u8 ofst_ofdm = 0x4;
+	const u8 ofst_cck = 0x8;
+	const s16 ref_ofdm = 0;
+	const s16 ref_cck = 0;
+	u32 val;
+	u8 i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set txpwr reference\n");
+
+	rtw89_mac_txpwr_write32_mask(rtwdev, phy_idx, R_AX_PWR_RATE_CTRL,
+				     B_AX_PWR_REF, 0x0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set bb ofdm txpwr ref\n");
+	val = rtw8851b_bb_cal_txpwr_ref(rtwdev, phy_idx, ref_ofdm);
+
+	for (i = 0; i < RF_PATH_NUM_8851B; i++)
+		rtw89_phy_write32_idx(rtwdev, addr[i] + ofst_ofdm, mask, val,
+				      phy_idx);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set bb cck txpwr ref\n");
+	val = rtw8851b_bb_cal_txpwr_ref(rtwdev, phy_idx, ref_cck);
+
+	for (i = 0; i < RF_PATH_NUM_8851B; i++)
+		rtw89_phy_write32_idx(rtwdev, addr[i] + ofst_cck, mask, val,
+				      phy_idx);
+}
+
+static void rtw8851b_bb_set_tx_shape_dfir(struct rtw89_dev *rtwdev,
+					  const struct rtw89_chan *chan,
+					  u8 tx_shape_idx,
+					  enum rtw89_phy_idx phy_idx)
+{
+#define __DFIR_CFG_ADDR(i) (R_TXFIR0 + ((i) << 2))
+#define __DFIR_CFG_MASK 0xffffffff
+#define __DFIR_CFG_NR 8
+#define __DECL_DFIR_PARAM(_name, _val...) \
+	static const u32 param_ ## _name[] = {_val}; \
+	static_assert(ARRAY_SIZE(param_ ## _name) == __DFIR_CFG_NR)
+
+	__DECL_DFIR_PARAM(flat,
+			  0x023D23FF, 0x0029B354, 0x000FC1C8, 0x00FDB053,
+			  0x00F86F9A, 0x06FAEF92, 0x00FE5FCC, 0x00FFDFF5);
+	__DECL_DFIR_PARAM(sharp,
+			  0x023D83FF, 0x002C636A, 0x0013F204, 0x00008090,
+			  0x00F87FB0, 0x06F99F83, 0x00FDBFBA, 0x00003FF5);
+	__DECL_DFIR_PARAM(sharp_14,
+			  0x023B13FF, 0x001C42DE, 0x00FDB0AD, 0x00F60F6E,
+			  0x00FD8F92, 0x0602D011, 0x0001C02C, 0x00FFF00A);
+	u8 ch = chan->channel;
+	const u32 *param;
+	u32 addr;
+	int i;
+
+	if (ch > 14) {
+		rtw89_warn(rtwdev,
+			   "set tx shape dfir by unknown ch: %d on 2G\n", ch);
+		return;
+	}
+
+	if (ch == 14)
+		param = param_sharp_14;
+	else
+		param = tx_shape_idx == 0 ? param_flat : param_sharp;
+
+	for (i = 0; i < __DFIR_CFG_NR; i++) {
+		addr = __DFIR_CFG_ADDR(i);
+		rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+			    "set tx shape dfir: 0x%x: 0x%x\n", addr, param[i]);
+		rtw89_phy_write32_idx(rtwdev, addr, __DFIR_CFG_MASK, param[i],
+				      phy_idx);
+	}
+
+#undef __DECL_DFIR_PARAM
+#undef __DFIR_CFG_NR
+#undef __DFIR_CFG_MASK
+#undef __DECL_CFG_ADDR
+}
+
+static void rtw8851b_set_tx_shape(struct rtw89_dev *rtwdev,
+				  const struct rtw89_chan *chan,
+				  enum rtw89_phy_idx phy_idx)
+{
+	u8 band = chan->band_type;
+	u8 regd = rtw89_regd_get(rtwdev, band);
+	u8 tx_shape_cck = rtw89_8851b_tx_shape[band][RTW89_RS_CCK][regd];
+	u8 tx_shape_ofdm = rtw89_8851b_tx_shape[band][RTW89_RS_OFDM][regd];
+
+	if (band == RTW89_BAND_2G)
+		rtw8851b_bb_set_tx_shape_dfir(rtwdev, chan, tx_shape_cck, phy_idx);
+
+	rtw89_phy_write32_mask(rtwdev, R_DCFO_OPT, B_TXSHAPE_TRIANGULAR_CFG,
+			       tx_shape_ofdm);
+}
+
+static void rtw8851b_set_txpwr(struct rtw89_dev *rtwdev,
+			       const struct rtw89_chan *chan,
+			       enum rtw89_phy_idx phy_idx)
+{
+	rtw89_phy_set_txpwr_byrate(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_offset(rtwdev, chan, phy_idx);
+	rtw8851b_set_tx_shape(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_limit(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
+}
+
+static void rtw8851b_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
+				    enum rtw89_phy_idx phy_idx)
+{
+	rtw8851b_set_txpwr_ref(rtwdev, phy_idx);
+}
+
+static
+void rtw8851b_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
+				     s8 pw_ofst, enum rtw89_mac_idx mac_idx)
+{
+	u32 reg;
+
+	if (pw_ofst < -16 || pw_ofst > 15) {
+		rtw89_warn(rtwdev, "[ULTB] Err pwr_offset=%d\n", pw_ofst);
+		return;
+	}
+
+	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_CTRL, mac_idx);
+	rtw89_write32_set(rtwdev, reg, B_AX_PWR_UL_TB_CTRL_EN);
+
+	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_1T, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_1T_MASK, pw_ofst);
+
+	pw_ofst = max_t(s8, pw_ofst - 3, -16);
+	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_2T, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_2T_MASK, pw_ofst);
+}
+
+static int
+rtw8851b_init_txpwr_unit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	int ret;
+
+	ret = rtw89_mac_txpwr_write32(rtwdev, phy_idx, R_AX_PWR_UL_CTRL2, 0x07763333);
+	if (ret)
+		return ret;
+
+	ret = rtw89_mac_txpwr_write32(rtwdev, phy_idx, R_AX_PWR_COEXT_CTRL, 0x01ebf000);
+	if (ret)
+		return ret;
+
+	ret = rtw89_mac_txpwr_write32(rtwdev, phy_idx, R_AX_PWR_UL_CTRL0, 0x0002f8ff);
+	if (ret)
+		return ret;
+
+	rtw8851b_set_txpwr_ul_tb_offset(rtwdev, 0, phy_idx == RTW89_PHY_1 ?
+						   RTW89_MAC_1 : RTW89_MAC_0);
+
+	return 0;
+}
+
 static void rtw8851b_btc_set_rfe(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -1711,6 +1960,11 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.read_phycap		= rtw8851b_read_phycap,
 	.fem_setup		= NULL,
 	.rfe_gpio		= rtw8851b_rfe_gpio,
+	.power_trim		= rtw8851b_power_trim,
+	.set_txpwr		= rtw8851b_set_txpwr,
+	.set_txpwr_ctrl		= rtw8851b_set_txpwr_ctrl,
+	.init_txpwr_unit	= rtw8851b_init_txpwr_unit,
+	.set_txpwr_ul_tb_offset	= rtw8851b_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= rtw8851b_pwr_on_func,
 	.pwr_off_func		= rtw8851b_pwr_off_func,
 	.fill_txdesc		= rtw89_core_fill_txdesc,
-- 
2.25.1

