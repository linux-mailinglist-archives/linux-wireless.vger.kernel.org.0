Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AB5708E2E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 May 2023 05:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjESDPX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 23:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjESDPV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 23:15:21 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70B8E66
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 20:15:19 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34J3F3n14004252, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34J3F3n14004252
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 19 May 2023 11:15:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 19 May 2023 11:15:12 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 19 May
 2023 11:15:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] wifi: rtw89: 8851b: fill BB related capabilities to chip_info
Date:   Fri, 19 May 2023 11:14:55 +0800
Message-ID: <20230519031500.21087-3-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These capabilities include helpers of BT coexistence, RX PPDU status
parser, DIG (dynamic initial gain) and CFO (center frequency offset)
settings.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 199 ++++++++++++++++++
 2 files changed, 201 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index bb609f222019c..7c2807345f60d 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4398,6 +4398,8 @@
 #define B_PATH0_BT_BACKOFF_V1 GENMASK(23, 0)
 #define R_PATH1_BT_BACKOFF_V1 0x4AEC
 #define B_PATH1_BT_BACKOFF_V1 GENMASK(23, 0)
+#define R_DCFO_COMP_S0_V2 0x4B20
+#define B_DCFO_COMP_S0_MSK_V2 GENMASK(13, 0)
 #define R_PATH0_TX_CFR 0x4B30
 #define B_PATH0_TX_CFR_LGC1 GENMASK(19, 10)
 #define B_PATH0_TX_CFR_LGC0 GENMASK(9, 0)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index cead009b270d9..11282f604f714 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -68,12 +68,63 @@ static const struct rtw89_dle_mem rtw8851b_dle_mem_pcie[] = {
 			       NULL},
 };
 
+static const struct rtw89_reg3_def rtw8851b_btc_preagc_en_defs[] = {
+	{0x46D0, GENMASK(1, 0), 0x3},
+	{0x4AD4, GENMASK(31, 0), 0xf},
+	{0x4688, GENMASK(23, 16), 0x80},
+	{0x4688, GENMASK(31, 24), 0x80},
+	{0x4694, GENMASK(7, 0), 0x80},
+	{0x4694, GENMASK(15, 8), 0x80},
+	{0x4AE4, GENMASK(11, 6), 0x34},
+	{0x4AE4, GENMASK(17, 12), 0x0},
+	{0x469C, GENMASK(31, 26), 0x34},
+};
+
+static DECLARE_PHY_REG3_TBL(rtw8851b_btc_preagc_en_defs);
+
+static const struct rtw89_reg3_def rtw8851b_btc_preagc_dis_defs[] = {
+	{0x46D0, GENMASK(1, 0), 0x0},
+	{0x4AD4, GENMASK(31, 0), 0x60},
+	{0x4688, GENMASK(23, 16), 0x10},
+	{0x4690, GENMASK(31, 24), 0x2a},
+	{0x4694, GENMASK(15, 8), 0x2a},
+	{0x4AE4, GENMASK(11, 6), 0x26},
+	{0x4AE4, GENMASK(17, 12), 0x1e},
+	{0x469C, GENMASK(31, 26), 0x26},
+};
+
+static DECLARE_PHY_REG3_TBL(rtw8851b_btc_preagc_dis_defs);
+
+static const struct rtw89_reg_def rtw8851b_dcfo_comp = {
+	R_DCFO_COMP_S0_V2, B_DCFO_COMP_S0_MSK_V2
+};
+
 static const struct rtw89_xtal_info rtw8851b_xtal_info = {
 	.xcap_reg		= R_AX_XTAL_ON_CTRL3,
 	.sc_xo_mask		= B_AX_XTAL_SC_XO_A_BLOCK_MASK,
 	.sc_xi_mask		= B_AX_XTAL_SC_XI_A_BLOCK_MASK,
 };
 
+static const struct rtw89_dig_regs rtw8851b_dig_regs = {
+	.seg0_pd_reg = R_SEG0R_PD_V1,
+	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
+	.pd_spatial_reuse_en = B_SEG0R_PD_SPATIAL_REUSE_EN_MSK_V1,
+	.p0_lna_init = {R_PATH0_LNA_INIT_V1, B_PATH0_LNA_INIT_IDX_MSK},
+	.p1_lna_init = {R_PATH1_LNA_INIT_V1, B_PATH1_LNA_INIT_IDX_MSK},
+	.p0_tia_init = {R_PATH0_TIA_INIT_V1, B_PATH0_TIA_INIT_IDX_MSK_V1},
+	.p1_tia_init = {R_PATH1_TIA_INIT_V1, B_PATH1_TIA_INIT_IDX_MSK_V1},
+	.p0_rxb_init = {R_PATH0_RXB_INIT_V1, B_PATH0_RXB_INIT_IDX_MSK_V1},
+	.p1_rxb_init = {R_PATH1_RXB_INIT_V1, B_PATH1_RXB_INIT_IDX_MSK_V1},
+	.p0_p20_pagcugc_en = {R_PATH0_P20_FOLLOW_BY_PAGCUGC_V2,
+			      B_PATH0_P20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p0_s20_pagcugc_en = {R_PATH0_S20_FOLLOW_BY_PAGCUGC_V2,
+			      B_PATH0_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p1_p20_pagcugc_en = {R_PATH1_P20_FOLLOW_BY_PAGCUGC_V2,
+			      B_PATH1_P20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p1_s20_pagcugc_en = {R_PATH1_S20_FOLLOW_BY_PAGCUGC_V2,
+			      B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
+};
+
 static const struct rtw89_btc_rf_trx_para rtw89_btc_8851b_rf_ul[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
@@ -1604,6 +1655,112 @@ rtw8851b_init_txpwr_unit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	return 0;
 }
 
+static void rtw8851b_bb_ctrl_btc_preagc(struct rtw89_dev *rtwdev, bool bt_en)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+
+	rtw89_phy_write_reg3_tbl(rtwdev, bt_en ? &rtw8851b_btc_preagc_en_defs_tbl :
+						 &rtw8851b_btc_preagc_dis_defs_tbl);
+
+	if (!bt_en) {
+		if (chan->band_type == RTW89_BAND_2G) {
+			rtw89_phy_write32_mask(rtwdev, R_PATH0_G_LNA6_OP1DB_V1,
+					       B_PATH0_G_LNA6_OP1DB_V1, 0x20);
+			rtw89_phy_write32_mask(rtwdev, R_PATH0_G_TIA0_LNA6_OP1DB_V1,
+					       B_PATH0_G_TIA0_LNA6_OP1DB_V1, 0x30);
+		} else {
+			rtw89_phy_write32_mask(rtwdev, R_PATH0_G_LNA6_OP1DB_V1,
+					       B_PATH0_G_LNA6_OP1DB_V1, 0x1a);
+			rtw89_phy_write32_mask(rtwdev, R_PATH0_G_TIA0_LNA6_OP1DB_V1,
+					       B_PATH0_G_TIA0_LNA6_OP1DB_V1, 0x2a);
+		}
+	}
+}
+
+static void rtw8851b_ctrl_btg(struct rtw89_dev *rtwdev, bool btg)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+
+	if (btg) {
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_SHARE_V1,
+				       B_PATH0_BT_SHARE_V1, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BTG_PATH_V1,
+				       B_PATH0_BTG_PATH_V1, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_G_LNA6_OP1DB_V1,
+				       B_PATH0_G_LNA6_OP1DB_V1, 0x20);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_G_TIA0_LNA6_OP1DB_V1,
+				       B_PATH0_G_TIA0_LNA6_OP1DB_V1, 0x30);
+		rtw89_phy_write32_mask(rtwdev, R_PMAC_GNT, B_PMAC_GNT_P1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_BT_SHARE, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_BT_SEG0, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_BT_DYN_DC_EST_EN_V1,
+				       B_BT_DYN_DC_EST_EN_MSK, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_GNT_BT_WGT_EN, B_GNT_BT_WGT_EN, 0x1);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_SHARE_V1,
+				       B_PATH0_BT_SHARE_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BTG_PATH_V1,
+				       B_PATH0_BTG_PATH_V1, 0x0);
+		if (chan->band_type == RTW89_BAND_2G) {
+			rtw89_phy_write32_mask(rtwdev, R_PATH0_G_LNA6_OP1DB_V1,
+					       B_PATH0_G_LNA6_OP1DB_V1, 0x80);
+			rtw89_phy_write32_mask(rtwdev, R_PATH0_G_TIA0_LNA6_OP1DB_V1,
+					       B_PATH0_G_TIA0_LNA6_OP1DB_V1, 0x80);
+		} else {
+			rtw89_phy_write32_mask(rtwdev, R_PATH0_G_LNA6_OP1DB_V1,
+					       B_PATH0_G_LNA6_OP1DB_V1, 0x1a);
+			rtw89_phy_write32_mask(rtwdev, R_PATH0_G_TIA0_LNA6_OP1DB_V1,
+					       B_PATH0_G_TIA0_LNA6_OP1DB_V1, 0x2a);
+		}
+		rtw89_phy_write32_mask(rtwdev, R_PMAC_GNT, B_PMAC_GNT_P1, 0xc);
+		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_BT_SHARE, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_BT_SEG0, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_BT_DYN_DC_EST_EN_V1,
+				       B_BT_DYN_DC_EST_EN_MSK, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_GNT_BT_WGT_EN, B_GNT_BT_WGT_EN, 0x0);
+	}
+}
+
+static void rtw8851b_bb_ctrl_rx_path(struct rtw89_dev *rtwdev,
+				     enum rtw89_rf_path_bit rx_path)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u32 rst_mask0;
+
+	if (rx_path == RF_A) {
+		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, 1);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG0, 1);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG1, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_USER_MAX, 4);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 0);
+	}
+
+	rtw8851b_set_gain_offset(rtwdev, chan->subband_type, RTW89_PHY_0);
+
+	rst_mask0 = B_P0_TXPW_RSTB_MANON | B_P0_TXPW_RSTB_TSSI;
+	if (rx_path == RF_A) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_TXPW_RSTB, rst_mask0, 1);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TXPW_RSTB, rst_mask0, 3);
+	}
+}
+
+static void rtw8851b_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
+{
+	rtw8851b_bb_ctrl_rx_path(rtwdev, RF_A);
+
+	if (rtwdev->hal.rx_nss == 1) {
+		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 0);
+	}
+
+	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_MOD, 0x0, RTW89_PHY_0);
+}
+
 static void rtw8851b_btc_set_rfe(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -1895,6 +2052,39 @@ static void rtw8851b_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
 	}
 }
 
+static void rtw8851b_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
+					 struct rtw89_rx_phy_ppdu *phy_ppdu,
+					 struct ieee80211_rx_status *status)
+{
+	u16 chan = phy_ppdu->chan_idx;
+	enum nl80211_band band;
+	u8 ch;
+
+	if (chan == 0)
+		return;
+
+	rtw89_decode_chan_idx(rtwdev, chan, &ch, &band);
+	status->freq = ieee80211_channel_to_frequency(ch, band);
+	status->band = band;
+}
+
+static void rtw8851b_query_ppdu(struct rtw89_dev *rtwdev,
+				struct rtw89_rx_phy_ppdu *phy_ppdu,
+				struct ieee80211_rx_status *status)
+{
+	u8 path;
+	u8 *rx_power = phy_ppdu->rssi;
+
+	status->signal = RTW89_RSSI_RAW_TO_DBM(rx_power[RF_PATH_A]);
+
+	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
+		status->chains |= BIT(path);
+		status->chain_signal[path] = RTW89_RSSI_RAW_TO_DBM(rx_power[path]);
+	}
+	if (phy_ppdu->valid)
+		rtw8851b_fill_freq_with_ppdu(rtwdev, phy_ppdu, status);
+}
+
 static int rtw8851b_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	int ret;
@@ -1964,6 +2154,10 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.set_txpwr		= rtw8851b_set_txpwr,
 	.set_txpwr_ctrl		= rtw8851b_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8851b_init_txpwr_unit,
+	.ctrl_btg		= rtw8851b_ctrl_btg,
+	.query_ppdu		= rtw8851b_query_ppdu,
+	.bb_ctrl_btc_preagc	= rtw8851b_bb_ctrl_btc_preagc,
+	.cfg_txrx_path		= rtw8851b_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8851b_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= rtw8851b_pwr_on_func,
 	.pwr_off_func		= rtw8851b_pwr_off_func,
@@ -2021,6 +2215,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= NULL,
+	.dig_regs		= &rtw8851b_dig_regs,
 	.tssi_dbw_table		= NULL,
 	.support_chanctx_num	= 0,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
@@ -2069,6 +2264,10 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN,
 	.h2c_desc_size		= sizeof(struct rtw89_txwd_body),
 	.txwd_body_size		= sizeof(struct rtw89_txwd_body),
+	.cfo_src_fd		= true,
+	.cfo_hw_comp		= true,
+	.dcfo_comp		= &rtw8851b_dcfo_comp,
+	.dcfo_comp_sft		= 12,
 	.bss_clr_map_reg	= R_BSS_CLR_MAP_V1,
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
-- 
2.25.1

