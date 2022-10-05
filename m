Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6185F50E4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 10:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJEIdW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 04:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJEIdJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 04:33:09 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19AEB74B8F
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 01:32:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2958W98B0010386, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2958W98B0010386
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 5 Oct 2022 16:32:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 5 Oct 2022 16:32:36 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 5 Oct 2022
 16:32:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <echuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/6] wifi: rtw89: 8852b: add chip_ops::set_channel
Date:   Wed, 5 Oct 2022 16:32:12 +0800
Message-ID: <20221005083212.45683-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005083212.45683-1-pkshih@realtek.com>
References: <20221005083212.45683-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/05/2022 03:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzUgpFekyCAwMjo1OTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

set_channel is main function to configure channel and bandwidth for all
layers, namely MAC, BB and RF. Additionally, MAC layer enables CCK rate
checking to avoid wrong rate from driver. BB layer configures SCO
(Sample Clock Offset) for CCK, TX gain error/offset, and reset baseband
hardware circuit after all configurations done.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |   1 +
 drivers/net/wireless/realtek/rtw89/phy.c      |   9 +
 drivers/net/wireless/realtek/rtw89/phy.h      |   2 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  58 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 564 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c | 256 ++++++++
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.h |  14 +
 7 files changed, 903 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b04e7a54b1e0a..0a0343608ba63 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3429,6 +3429,7 @@ struct rtw89_phy_efuse_gain {
 	bool comp_valid;
 	s8 offset[RF_PATH_MAX][RTW89_GAIN_OFFSET_NR]; /* S(8, 0) */
 	s8 offset_base[RTW89_PHY_MAX]; /* S(8, 4) */
+	s8 rssi_base[RTW89_PHY_MAX]; /* S(8, 4) */
 	s8 comp[RF_PATH_MAX][RTW89_SUBBAND_NR]; /* S(8, 0) */
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index fb7872225ee3d..d3f47379e4432 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1427,6 +1427,15 @@ void rtw89_phy_write32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 }
 EXPORT_SYMBOL(rtw89_phy_write32_idx);
 
+u32 rtw89_phy_read32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
+			 enum rtw89_phy_idx phy_idx)
+{
+	if (rtwdev->dbcc_en && phy_idx == RTW89_PHY_1)
+		addr += rtw89_phy0_phy1_offset(rtwdev, addr);
+	return rtw89_phy_read32_mask(rtwdev, addr, mask);
+}
+EXPORT_SYMBOL(rtw89_phy_read32_idx);
+
 void rtw89_phy_set_phy_regs(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 			    u32 val)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 1129d462bfbdb..1e122b1498ba1 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -499,6 +499,8 @@ void rtw89_phy_config_rf_reg_v1(struct rtw89_dev *rtwdev,
 void rtw89_phy_dm_init(struct rtw89_dev *rtwdev);
 void rtw89_phy_write32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 			   u32 data, enum rtw89_phy_idx phy_idx);
+u32 rtw89_phy_read32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
+			 enum rtw89_phy_idx phy_idx);
 void rtw89_phy_load_txpwr_byrate(struct rtw89_dev *rtwdev,
 				 const struct rtw89_txpwr_table *tbl);
 s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 82af17d7d8d31..1539973296cd1 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3313,6 +3313,10 @@
 #define CFGCH_BAND1_2G 0
 #define CFGCH_BAND1_5G 1
 #define CFGCH_BAND1_6G 3
+#define RR_CFGCH_POW_LCK BIT(15)
+#define RR_CFGCH_TRX_AH BIT(14)
+#define RR_CFGCH_BCN BIT(13)
+#define RR_CFGCH_BW2 BIT(12)
 #define RR_CFGCH_BAND0 GENMASK(9, 8)
 #define CFGCH_BAND0_2G 0
 #define CFGCH_BAND0_5G 1
@@ -3448,14 +3452,31 @@
 #define RR_TIA_N6 BIT(8)
 #define RR_MIXER 0x9f
 #define RR_MIXER_GN GENMASK(4, 3)
+#define RR_POW 0xa0
+#define RR_POW_SYN GENMASK(3, 2)
 #define RR_LOGEN 0xa3
 #define RR_LOGEN_RPT GENMASK(19, 16)
+#define RR_SX 0xaf
+#define RR_LDO 0xb1
+#define RR_LDO_SEL GENMASK(8, 6)
+#define RR_VCO 0xb2
+#define RR_LPF 0xb7
+#define RR_LPF_BUSY BIT(8)
 #define RR_XTALX2 0xb8
 #define RR_MALSEL 0xbe
+#define RR_SYNFB 0xc5
+#define RR_SYNFB_LK BIT(15)
+#define RR_LCKST 0xcf
+#define RR_LCKST_BIN BIT(0)
 #define RR_LCK_TRG 0xd3
 #define RR_LCK_TRGSEL BIT(8)
+#define RR_MMD 0xd5
+#define RR_MMD_RST_EN BIT(8)
+#define RR_MMD_RST_SYN BIT(6)
 #define RR_IQKPLL 0xdc
 #define RR_IQKPLL_MOD GENMASK(9, 8)
+#define RR_SYNLUT 0xdd
+#define RR_SYNLUT_MOD BIT(4)
 #define RR_RCKD 0xde
 #define RR_RCKD_POW GENMASK(19, 13)
 #define RR_RCKD_BW BIT(2)
@@ -3624,6 +3645,8 @@
 #define R_P0_RFMODE 0x12AC
 #define B_P0_RFMODE_ORI_TXRX_FTM_TX GENMASK(31, 4)
 #define B_P0_RFMODE_MUX GENMASK(11, 4)
+#define R_P0_RFMODE_ORI_RX 0x12AC
+#define B_P0_RFMODE_ORI_RX_ALL GENMASK(23, 12)
 #define R_P0_NRBW 0x12B8
 #define B_P0_NRBW_DBG BIT(30)
 #define R_S0_RXDC 0x12D4
@@ -3717,6 +3740,8 @@
 #define B_RXCCA_DIS_V1 BIT(0)
 #define R_RXSC 0x237C
 #define B_RXSC_EN BIT(0)
+#define R_RX_RPL_OFST 0x23AC
+#define B_RX_RPL_OFST_CCK_MASK GENMASK(6, 0)
 #define R_RXSCOBC 0x23B0
 #define B_RXSCOBC_TH GENMASK(18, 0)
 #define R_RXSCOCCK 0x23B4
@@ -3733,6 +3758,8 @@
 #define R_P1_RFMODE 0x32AC
 #define B_P1_RFMODE_ORI_TXRX_FTM_TX GENMASK(31, 4)
 #define B_P1_RFMODE_MUX GENMASK(11, 4)
+#define R_P1_RFMODE_ORI_RX 0x32AC
+#define B_P1_RFMODE_ORI_RX_ALL GENMASK(23, 12)
 #define R_P1_DBGMOD 0x32B8
 #define B_P1_DBGMOD_ON BIT(30)
 #define R_S1_RXDC 0x32D4
@@ -3766,7 +3793,10 @@
 #define R_T2F_GI_COMB 0x4424
 #define B_T2F_GI_COMB_EN BIT(2)
 #define R_BT_DYN_DC_EST_EN 0x441C
+#define R_BT_DYN_DC_EST_EN_V1 0x4420
 #define B_BT_DYN_DC_EST_EN_MSK BIT(31)
+#define R_ASSIGN_SBD_OPT_V1 0x4440
+#define B_ASSIGN_SBD_OPT_EN_V1 BIT(31)
 #define R_ASSIGN_SBD_OPT 0x4450
 #define B_ASSIGN_SBD_OPT_EN BIT(24)
 #define R_DCFO_COMP_S0 0x448C
@@ -3916,20 +3946,42 @@
 #define R_2P4G_BAND 0x4970
 #define B_2P4G_BAND_SEL BIT(1)
 #define R_FC0_BW 0x4974
-#define B_FC0_BW_INV GENMASK(6, 0)
+#define R_FC0_BW_V1 0x49C0
 #define B_FC0_BW_SET GENMASK(31, 30)
 #define B_ANT_RX_BT_SEG0 GENMASK(25, 22)
 #define B_ANT_RX_1RCCA_SEG1 GENMASK(21, 18)
 #define B_ANT_RX_1RCCA_SEG0 GENMASK(17, 14)
+#define B_FC0_BW_INV GENMASK(6, 0)
 #define R_CHBW_MOD 0x4978
+#define R_CHBW_MOD_V1 0x49C4
 #define B_BT_SHARE BIT(14)
 #define B_CHBW_MOD_SBW GENMASK(13, 12)
 #define B_CHBW_MOD_PRICH GENMASK(11, 8)
 #define B_ANT_RX_SEG0 GENMASK(3, 0)
+#define R_P0_RPL1 0x49B0
+#define B_P0_RPL1_41_MASK GENMASK(31, 24)
+#define B_P0_RPL1_40_MASK GENMASK(23, 16)
+#define B_P0_RPL1_20_MASK GENMASK(15, 8)
+#define B_P0_RPL1_MASK (B_P0_RPL1_41_MASK | B_P0_RPL1_40_MASK | B_P0_RPL1_20_MASK)
+#define B_P0_RPL1_SHIFT 8
+#define B_P0_RPL1_BIAS_MASK GENMASK(7, 0)
+#define R_P0_RPL2 0x49B4
+#define B_P0_RTL2_8A_MASK GENMASK(31, 24)
+#define B_P0_RTL2_81_MASK GENMASK(23, 16)
+#define B_P0_RTL2_80_MASK GENMASK(15, 8)
+#define B_P0_RTL2_42_MASK GENMASK(7, 0)
+#define R_P0_RPL3 0x49B8
+#define B_P0_RTL3_89_MASK GENMASK(31, 24)
+#define B_P0_RTL3_84_MASK GENMASK(23, 16)
+#define B_P0_RTL3_83_MASK GENMASK(15, 8)
+#define B_P0_RTL3_82_MASK GENMASK(7, 0)
 #define R_PD_BOOST_EN 0x49E8
 #define B_PD_BOOST_EN BIT(7)
 #define R_P1_BACKOFF_IBADC_V1 0x49F0
 #define B_P1_BACKOFF_IBADC_V1 GENMASK(31, 26)
+#define R_P1_RPL1 0x4A00
+#define R_P1_RPL2 0x4A04
+#define R_P1_RPL3 0x4A08
 #define R_BK_FC0_INV_V1 0x4A1C
 #define B_BK_FC0_INV_MSK_V1 GENMASK(18, 0)
 #define R_CCK_FC0_INV_V1 0x4A20
@@ -3940,8 +3992,10 @@
 #define B_P1_AGC_EN BIT(31)
 #define R_PATH1_TIA_INIT_V1 0x4AA8
 #define B_PATH1_TIA_INIT_IDX_MSK_V1 BIT(9)
+#define R_P0_AGC_RSVD 0x4ACC
 #define R_PATH0_RXBB_V1 0x4AD4
 #define B_PATH0_RXBB_MSK_V1 GENMASK(31, 0)
+#define R_P1_AGC_RSVD 0x4AD8
 #define R_PATH1_RXBB_V1 0x4AE0
 #define B_PATH1_RXBB_MSK_V1 GENMASK(31, 0)
 #define R_PATH0_BT_BACKOFF_V1 0x4AE4
@@ -3957,6 +4011,7 @@
 #define B_PATH0_NOTCH2_EN BIT(12)
 #define B_PATH0_NOTCH2_VAL GENMASK(11, 0)
 #define R_PATH0_5MDET 0x4C4C
+#define R_PATH0_5MDET_V1 0x46F8
 #define B_PATH0_5MDET_EN BIT(12)
 #define B_PATH0_5MDET_SB2 BIT(8)
 #define B_PATH0_5MDET_SB0 BIT(6)
@@ -3970,6 +4025,7 @@
 #define B_PATH1_NOTCH2_EN BIT(12)
 #define B_PATH1_NOTCH2_VAL GENMASK(11, 0)
 #define R_PATH1_5MDET 0x4D10
+#define R_PATH1_5MDET_V1 0x47B8
 #define B_PATH1_5MDET_EN BIT(12)
 #define B_PATH1_5MDET_SB2 BIT(8)
 #define B_PATH1_5MDET_SB0 BIT(6)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 8424038d5338b..b50fff00b1393 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -8,6 +8,7 @@
 #include "phy.h"
 #include "reg.h"
 #include "rtw8852b.h"
+#include "rtw8852b_rfk.h"
 #include "rtw8852b_table.h"
 #include "txrx.h"
 
@@ -334,6 +335,568 @@ static void rtw8852b_power_trim(struct rtw89_dev *rtwdev)
 	rtw8852b_pa_bias_trim(rtwdev);
 }
 
+static void rtw8852b_set_channel_mac(struct rtw89_dev *rtwdev,
+				     const struct rtw89_chan *chan,
+				     u8 mac_idx)
+{
+	u32 rf_mod = rtw89_mac_reg_by_idx(R_AX_WMAC_RFMOD, mac_idx);
+	u32 sub_carr = rtw89_mac_reg_by_idx(R_AX_TX_SUB_CARRIER_VALUE, mac_idx);
+	u32 chk_rate = rtw89_mac_reg_by_idx(R_AX_TXRATE_CHK, mac_idx);
+	u8 txsc20 = 0, txsc40 = 0;
+
+	switch (chan->band_width) {
+	case RTW89_CHANNEL_WIDTH_80:
+		txsc40 = rtw89_phy_get_txsc(rtwdev, chan, RTW89_CHANNEL_WIDTH_40);
+		fallthrough;
+	case RTW89_CHANNEL_WIDTH_40:
+		txsc20 = rtw89_phy_get_txsc(rtwdev, chan, RTW89_CHANNEL_WIDTH_20);
+		break;
+	default:
+		break;
+	}
+
+	switch (chan->band_width) {
+	case RTW89_CHANNEL_WIDTH_80:
+		rtw89_write8_mask(rtwdev, rf_mod, B_AX_WMAC_RFMOD_MASK, BIT(1));
+		rtw89_write32(rtwdev, sub_carr, txsc20 | (txsc40 << 4));
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		rtw89_write8_mask(rtwdev, rf_mod, B_AX_WMAC_RFMOD_MASK, BIT(0));
+		rtw89_write32(rtwdev, sub_carr, txsc20);
+		break;
+	case RTW89_CHANNEL_WIDTH_20:
+		rtw89_write8_clr(rtwdev, rf_mod, B_AX_WMAC_RFMOD_MASK);
+		rtw89_write32(rtwdev, sub_carr, 0);
+		break;
+	default:
+		break;
+	}
+
+	if (chan->channel > 14) {
+		rtw89_write8_clr(rtwdev, chk_rate, B_AX_BAND_MODE);
+		rtw89_write8_set(rtwdev, chk_rate,
+				 B_AX_CHECK_CCK_EN | B_AX_RTS_LIMIT_IN_OFDM6);
+	} else {
+		rtw89_write8_set(rtwdev, chk_rate, B_AX_BAND_MODE);
+		rtw89_write8_clr(rtwdev, chk_rate,
+				 B_AX_CHECK_CCK_EN | B_AX_RTS_LIMIT_IN_OFDM6);
+	}
+}
+
+static const u32 rtw8852b_sco_barker_threshold[14] = {
+	0x1cfea, 0x1d0e1, 0x1d1d7, 0x1d2cd, 0x1d3c3, 0x1d4b9, 0x1d5b0, 0x1d6a6,
+	0x1d79c, 0x1d892, 0x1d988, 0x1da7f, 0x1db75, 0x1ddc4
+};
+
+static const u32 rtw8852b_sco_cck_threshold[14] = {
+	0x27de3, 0x27f35, 0x28088, 0x281da, 0x2832d, 0x2847f, 0x285d2, 0x28724,
+	0x28877, 0x289c9, 0x28b1c, 0x28c6e, 0x28dc1, 0x290ed
+};
+
+static void rtw8852b_ctrl_sco_cck(struct rtw89_dev *rtwdev, u8 primary_ch)
+{
+	u8 ch_element = primary_ch - 1;
+
+	rtw89_phy_write32_mask(rtwdev, R_RXSCOBC, B_RXSCOBC_TH,
+			       rtw8852b_sco_barker_threshold[ch_element]);
+	rtw89_phy_write32_mask(rtwdev, R_RXSCOCCK, B_RXSCOCCK_TH,
+			       rtw8852b_sco_cck_threshold[ch_element]);
+}
+
+static u8 rtw8852b_sco_mapping(u8 central_ch)
+{
+	if (central_ch == 1)
+		return 109;
+	else if (central_ch >= 2 && central_ch <= 6)
+		return 108;
+	else if (central_ch >= 7 && central_ch <= 10)
+		return 107;
+	else if (central_ch >= 11 && central_ch <= 14)
+		return 106;
+	else if (central_ch == 36 || central_ch == 38)
+		return 51;
+	else if (central_ch >= 40 && central_ch <= 58)
+		return 50;
+	else if (central_ch >= 60 && central_ch <= 64)
+		return 49;
+	else if (central_ch == 100 || central_ch == 102)
+		return 48;
+	else if (central_ch >= 104 && central_ch <= 126)
+		return 47;
+	else if (central_ch >= 128 && central_ch <= 151)
+		return 46;
+	else if (central_ch >= 153 && central_ch <= 177)
+		return 45;
+	else
+		return 0;
+}
+
+struct rtw8852b_bb_gain {
+	u32 gain_g[BB_PATH_NUM_8852B];
+	u32 gain_a[BB_PATH_NUM_8852B];
+	u32 gain_mask;
+};
+
+static const struct rtw8852b_bb_gain bb_gain_lna[LNA_GAIN_NUM] = {
+	{ .gain_g = {0x4678, 0x475C}, .gain_a = {0x45DC, 0x4740},
+	  .gain_mask = 0x00ff0000 },
+	{ .gain_g = {0x4678, 0x475C}, .gain_a = {0x45DC, 0x4740},
+	  .gain_mask = 0xff000000 },
+	{ .gain_g = {0x467C, 0x4760}, .gain_a = {0x4660, 0x4744},
+	  .gain_mask = 0x000000ff },
+	{ .gain_g = {0x467C, 0x4760}, .gain_a = {0x4660, 0x4744},
+	  .gain_mask = 0x0000ff00 },
+	{ .gain_g = {0x467C, 0x4760}, .gain_a = {0x4660, 0x4744},
+	  .gain_mask = 0x00ff0000 },
+	{ .gain_g = {0x467C, 0x4760}, .gain_a = {0x4660, 0x4744},
+	  .gain_mask = 0xff000000 },
+	{ .gain_g = {0x4680, 0x4764}, .gain_a = {0x4664, 0x4748},
+	  .gain_mask = 0x000000ff },
+};
+
+static const struct rtw8852b_bb_gain bb_gain_tia[TIA_GAIN_NUM] = {
+	{ .gain_g = {0x4680, 0x4764}, .gain_a = {0x4664, 0x4748},
+	  .gain_mask = 0x00ff0000 },
+	{ .gain_g = {0x4680, 0x4764}, .gain_a = {0x4664, 0x4748},
+	  .gain_mask = 0xff000000 },
+};
+
+static void rtw8852b_set_gain_error(struct rtw89_dev *rtwdev,
+				    enum rtw89_subband subband,
+				    enum rtw89_rf_path path)
+{
+	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
+	u8 gain_band = rtw89_subband_to_bb_gain_band(subband);
+	s32 val;
+	u32 reg;
+	u32 mask;
+	int i;
+
+	for (i = 0; i < LNA_GAIN_NUM; i++) {
+		if (subband == RTW89_CH_2G)
+			reg = bb_gain_lna[i].gain_g[path];
+		else
+			reg = bb_gain_lna[i].gain_a[path];
+
+		mask = bb_gain_lna[i].gain_mask;
+		val = gain->lna_gain[gain_band][path][i];
+		rtw89_phy_write32_mask(rtwdev, reg, mask, val);
+	}
+
+	for (i = 0; i < TIA_GAIN_NUM; i++) {
+		if (subband == RTW89_CH_2G)
+			reg = bb_gain_tia[i].gain_g[path];
+		else
+			reg = bb_gain_tia[i].gain_a[path];
+
+		mask = bb_gain_tia[i].gain_mask;
+		val = gain->tia_gain[gain_band][path][i];
+		rtw89_phy_write32_mask(rtwdev, reg, mask, val);
+	}
+}
+
+static void rtw8852b_set_gain_offset(struct rtw89_dev *rtwdev,
+				     enum rtw89_subband subband,
+				     enum rtw89_phy_idx phy_idx)
+{
+	static const u32 gain_err_addr[2] = {R_P0_AGC_RSVD, R_P1_AGC_RSVD};
+	static const u32 rssi_ofst_addr[2] = {R_PATH0_G_TIA1_LNA6_OP1DB_V1,
+					      R_PATH1_G_TIA1_LNA6_OP1DB_V1};
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_phy_efuse_gain *efuse_gain = &rtwdev->efuse_gain;
+	enum rtw89_gain_offset gain_ofdm_band;
+	s32 offset_a, offset_b;
+	s32 offset_ofdm, offset_cck;
+	s32 tmp;
+	u8 path;
+
+	if (!efuse_gain->comp_valid)
+		goto next;
+
+	for (path = RF_PATH_A; path < BB_PATH_NUM_8852B; path++) {
+		tmp = efuse_gain->comp[path][subband];
+		tmp = clamp_t(s32, tmp << 2, S8_MIN, S8_MAX);
+		rtw89_phy_write32_mask(rtwdev, gain_err_addr[path], MASKBYTE0, tmp);
+	}
+
+next:
+	if (!efuse_gain->offset_valid)
+		return;
+
+	gain_ofdm_band = rtw89_subband_to_gain_offset_band_of_ofdm(subband);
+
+	offset_a = -efuse_gain->offset[RF_PATH_A][gain_ofdm_band];
+	offset_b = -efuse_gain->offset[RF_PATH_B][gain_ofdm_band];
+
+	tmp = -((offset_a << 2) + (efuse_gain->offset_base[RTW89_PHY_0] >> 2));
+	tmp = clamp_t(s32, tmp, S8_MIN, S8_MAX);
+	rtw89_phy_write32_mask(rtwdev, rssi_ofst_addr[RF_PATH_A], B_PATH0_R_G_OFST_MASK, tmp);
+
+	tmp = -((offset_b << 2) + (efuse_gain->offset_base[RTW89_PHY_0] >> 2));
+	tmp = clamp_t(s32, tmp, S8_MIN, S8_MAX);
+	rtw89_phy_write32_mask(rtwdev, rssi_ofst_addr[RF_PATH_B], B_PATH0_R_G_OFST_MASK, tmp);
+
+	if (hal->antenna_rx == RF_B) {
+		offset_ofdm = -efuse_gain->offset[RF_PATH_B][gain_ofdm_band];
+		offset_cck = -efuse_gain->offset[RF_PATH_B][0];
+	} else {
+		offset_ofdm = -efuse_gain->offset[RF_PATH_A][gain_ofdm_band];
+		offset_cck = -efuse_gain->offset[RF_PATH_A][0];
+	}
+
+	tmp = (offset_ofdm << 4) + efuse_gain->offset_base[RTW89_PHY_0];
+	tmp = clamp_t(s32, tmp, S8_MIN, S8_MAX);
+	rtw89_phy_write32_idx(rtwdev, R_P0_RPL1, B_P0_RPL1_BIAS_MASK, tmp, phy_idx);
+
+	tmp = (offset_ofdm << 4) + efuse_gain->rssi_base[RTW89_PHY_0];
+	tmp = clamp_t(s32, tmp, S8_MIN, S8_MAX);
+	rtw89_phy_write32_idx(rtwdev, R_P1_RPL1, B_P0_RPL1_BIAS_MASK, tmp, phy_idx);
+
+	if (subband == RTW89_CH_2G) {
+		tmp = (offset_cck << 3) + (efuse_gain->offset_base[RTW89_PHY_0] >> 1);
+		tmp = clamp_t(s32, tmp, S8_MIN >> 1, S8_MAX >> 1);
+		rtw89_phy_write32_mask(rtwdev, R_RX_RPL_OFST,
+				       B_RX_RPL_OFST_CCK_MASK, tmp);
+	}
+}
+
+static
+void rtw8852b_set_rxsc_rpl_comp(struct rtw89_dev *rtwdev, enum rtw89_subband subband)
+{
+	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
+	u8 band = rtw89_subband_to_bb_gain_band(subband);
+	u32 val;
+
+	val = FIELD_PREP(B_P0_RPL1_20_MASK, (gain->rpl_ofst_20[band][RF_PATH_A] +
+					     gain->rpl_ofst_20[band][RF_PATH_B]) / 2) |
+	      FIELD_PREP(B_P0_RPL1_40_MASK, (gain->rpl_ofst_40[band][RF_PATH_A][0] +
+					     gain->rpl_ofst_40[band][RF_PATH_B][0]) / 2) |
+	      FIELD_PREP(B_P0_RPL1_41_MASK, (gain->rpl_ofst_40[band][RF_PATH_A][1] +
+					     gain->rpl_ofst_40[band][RF_PATH_B][1]) / 2);
+	val >>= B_P0_RPL1_SHIFT;
+	rtw89_phy_write32_mask(rtwdev, R_P0_RPL1, B_P0_RPL1_MASK, val);
+	rtw89_phy_write32_mask(rtwdev, R_P1_RPL1, B_P0_RPL1_MASK, val);
+
+	val = FIELD_PREP(B_P0_RTL2_42_MASK, (gain->rpl_ofst_40[band][RF_PATH_A][2] +
+					     gain->rpl_ofst_40[band][RF_PATH_B][2]) / 2) |
+	      FIELD_PREP(B_P0_RTL2_80_MASK, (gain->rpl_ofst_80[band][RF_PATH_A][0] +
+					     gain->rpl_ofst_80[band][RF_PATH_B][0]) / 2) |
+	      FIELD_PREP(B_P0_RTL2_81_MASK, (gain->rpl_ofst_80[band][RF_PATH_A][1] +
+					     gain->rpl_ofst_80[band][RF_PATH_B][1]) / 2) |
+	      FIELD_PREP(B_P0_RTL2_8A_MASK, (gain->rpl_ofst_80[band][RF_PATH_A][10] +
+					     gain->rpl_ofst_80[band][RF_PATH_B][10]) / 2);
+	rtw89_phy_write32(rtwdev, R_P0_RPL2, val);
+	rtw89_phy_write32(rtwdev, R_P1_RPL2, val);
+
+	val = FIELD_PREP(B_P0_RTL3_82_MASK, (gain->rpl_ofst_80[band][RF_PATH_A][2] +
+					     gain->rpl_ofst_80[band][RF_PATH_B][2]) / 2) |
+	      FIELD_PREP(B_P0_RTL3_83_MASK, (gain->rpl_ofst_80[band][RF_PATH_A][3] +
+					     gain->rpl_ofst_80[band][RF_PATH_B][3]) / 2) |
+	      FIELD_PREP(B_P0_RTL3_84_MASK, (gain->rpl_ofst_80[band][RF_PATH_A][4] +
+					     gain->rpl_ofst_80[band][RF_PATH_B][4]) / 2) |
+	      FIELD_PREP(B_P0_RTL3_89_MASK, (gain->rpl_ofst_80[band][RF_PATH_A][9] +
+					     gain->rpl_ofst_80[band][RF_PATH_B][9]) / 2);
+	rtw89_phy_write32(rtwdev, R_P0_RPL3, val);
+	rtw89_phy_write32(rtwdev, R_P1_RPL3, val);
+}
+
+static void rtw8852b_ctrl_ch(struct rtw89_dev *rtwdev,
+			     const struct rtw89_chan *chan,
+			     enum rtw89_phy_idx phy_idx)
+{
+	u8 central_ch = chan->channel;
+	u8 subband = chan->subband_type;
+	u8 sco_comp;
+	bool is_2g = central_ch <= 14;
+
+	/* Path A */
+	if (is_2g)
+		rtw89_phy_write32_idx(rtwdev, R_PATH0_BAND_SEL_V1,
+				      B_PATH0_BAND_SEL_MSK_V1, 1, phy_idx);
+	else
+		rtw89_phy_write32_idx(rtwdev, R_PATH0_BAND_SEL_V1,
+				      B_PATH0_BAND_SEL_MSK_V1, 0, phy_idx);
+
+	/* Path B */
+	if (is_2g)
+		rtw89_phy_write32_idx(rtwdev, R_PATH1_BAND_SEL_V1,
+				      B_PATH1_BAND_SEL_MSK_V1, 1, phy_idx);
+	else
+		rtw89_phy_write32_idx(rtwdev, R_PATH1_BAND_SEL_V1,
+				      B_PATH1_BAND_SEL_MSK_V1, 0, phy_idx);
+
+	/* SCO compensate FC setting */
+	sco_comp = rtw8852b_sco_mapping(central_ch);
+	rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_INV, sco_comp, phy_idx);
+
+	if (chan->band_type == RTW89_BAND_6G)
+		return;
+
+	/* CCK parameters */
+	if (central_ch == 14) {
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR0, B_TXFIR_C01, 0x3b13ff);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR2, B_TXFIR_C23, 0x1c42de);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR4, B_TXFIR_C45, 0xfdb0ad);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR6, B_TXFIR_C67, 0xf60f6e);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR8, B_TXFIR_C89, 0xfd8f92);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIRA, B_TXFIR_CAB, 0x2d011);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIRC, B_TXFIR_CCD, 0x1c02c);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIRE, B_TXFIR_CEF, 0xfff00a);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR0, B_TXFIR_C01, 0x3d23ff);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR2, B_TXFIR_C23, 0x29b354);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR4, B_TXFIR_C45, 0xfc1c8);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR6, B_TXFIR_C67, 0xfdb053);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR8, B_TXFIR_C89, 0xf86f9a);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIRA, B_TXFIR_CAB, 0xfaef92);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIRC, B_TXFIR_CCD, 0xfe5fcc);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIRE, B_TXFIR_CEF, 0xffdff5);
+	}
+
+	rtw8852b_set_gain_error(rtwdev, subband, RF_PATH_A);
+	rtw8852b_set_gain_error(rtwdev, subband, RF_PATH_B);
+	rtw8852b_set_gain_offset(rtwdev, subband, phy_idx);
+	rtw8852b_set_rxsc_rpl_comp(rtwdev, subband);
+}
+
+static void rtw8852b_bw_setting(struct rtw89_dev *rtwdev, u8 bw, u8 path)
+{
+	static const u32 adc_sel[2] = {0xC0EC, 0xC1EC};
+	static const u32 wbadc_sel[2] = {0xC0E4, 0xC1E4};
+
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_5:
+		rtw89_phy_write32_mask(rtwdev, adc_sel[path], 0x6000, 0x1);
+		rtw89_phy_write32_mask(rtwdev, wbadc_sel[path], 0x30, 0x0);
+		break;
+	case RTW89_CHANNEL_WIDTH_10:
+		rtw89_phy_write32_mask(rtwdev, adc_sel[path], 0x6000, 0x2);
+		rtw89_phy_write32_mask(rtwdev, wbadc_sel[path], 0x30, 0x1);
+		break;
+	case RTW89_CHANNEL_WIDTH_20:
+		rtw89_phy_write32_mask(rtwdev, adc_sel[path], 0x6000, 0x0);
+		rtw89_phy_write32_mask(rtwdev, wbadc_sel[path], 0x30, 0x2);
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		rtw89_phy_write32_mask(rtwdev, adc_sel[path], 0x6000, 0x0);
+		rtw89_phy_write32_mask(rtwdev, wbadc_sel[path], 0x30, 0x2);
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		rtw89_phy_write32_mask(rtwdev, adc_sel[path], 0x6000, 0x0);
+		rtw89_phy_write32_mask(rtwdev, wbadc_sel[path], 0x30, 0x2);
+		break;
+	default:
+		rtw89_warn(rtwdev, "Fail to set ADC\n");
+	}
+}
+
+static void rtw8852b_ctrl_bw(struct rtw89_dev *rtwdev, u8 pri_ch, u8 bw,
+			     enum rtw89_phy_idx phy_idx)
+{
+	u32 rx_path_0;
+
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_5:
+		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_SBW, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_PRICH, 0x0, phy_idx);
+
+		/*Set RF mode at 3 */
+		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
+				      B_P0_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
+				      B_P1_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		break;
+	case RTW89_CHANNEL_WIDTH_10:
+		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_SBW, 0x2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_PRICH, 0x0, phy_idx);
+
+		/*Set RF mode at 3 */
+		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
+				      B_P0_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
+				      B_P1_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		break;
+	case RTW89_CHANNEL_WIDTH_20:
+		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_SBW, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_PRICH, 0x0, phy_idx);
+
+		/*Set RF mode at 3 */
+		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
+				      B_P0_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
+				      B_P1_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_SBW, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_PRICH,
+				      pri_ch, phy_idx);
+
+		/*Set RF mode at 3 */
+		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
+				      B_P0_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
+				      B_P1_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		/*CCK primary channel */
+		if (pri_ch == RTW89_SC_20_UPPER)
+			rtw89_phy_write32_mask(rtwdev, R_RXSC, B_RXSC_EN, 1);
+		else
+			rtw89_phy_write32_mask(rtwdev, R_RXSC, B_RXSC_EN, 0);
+
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_SBW, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_PRICH,
+				      pri_ch, phy_idx);
+
+		/*Set RF mode at A */
+		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
+				      B_P0_RFMODE_ORI_RX_ALL, 0xaaa, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
+				      B_P1_RFMODE_ORI_RX_ALL, 0xaaa, phy_idx);
+		break;
+	default:
+		rtw89_warn(rtwdev, "Fail to switch bw (bw:%d, pri ch:%d)\n", bw,
+			   pri_ch);
+	}
+
+	rtw8852b_bw_setting(rtwdev, bw, RF_PATH_A);
+	rtw8852b_bw_setting(rtwdev, bw, RF_PATH_B);
+
+	rx_path_0 = rtw89_phy_read32_idx(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0,
+					 phy_idx);
+	if (rx_path_0 == 0x1)
+		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
+				      B_P1_RFMODE_ORI_RX_ALL, 0x111, phy_idx);
+	else if (rx_path_0 == 0x2)
+		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
+				      B_P0_RFMODE_ORI_RX_ALL, 0x111, phy_idx);
+}
+
+static void rtw8852b_ctrl_cck_en(struct rtw89_dev *rtwdev, bool cck_en)
+{
+	if (cck_en) {
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC, B_ENABLE_CCK, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXCCA, B_RXCCA_DIS, 0);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC, B_ENABLE_CCK, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXCCA, B_RXCCA_DIS, 1);
+	}
+}
+
+static void rtw8852b_5m_mask(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan,
+			     enum rtw89_phy_idx phy_idx)
+{
+	u8 pri_ch = chan->primary_channel;
+	bool mask_5m_low;
+	bool mask_5m_en;
+
+	switch (chan->band_width) {
+	case RTW89_CHANNEL_WIDTH_40:
+		/* Prich=1: Mask 5M High, Prich=2: Mask 5M Low */
+		mask_5m_en = true;
+		mask_5m_low = pri_ch == 2;
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		/* Prich=3: Mask 5M High, Prich=4: Mask 5M Low, Else: Disable */
+		mask_5m_en = pri_ch == 3 || pri_ch == 4;
+		mask_5m_low = pri_ch == 4;
+		break;
+	default:
+		mask_5m_en = false;
+		break;
+	}
+
+	if (!mask_5m_en) {
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_EN, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_EN, 0x0);
+		rtw89_phy_write32_idx(rtwdev, R_ASSIGN_SBD_OPT_V1,
+				      B_ASSIGN_SBD_OPT_EN_V1, 0x0, phy_idx);
+		return;
+	}
+
+	if (mask_5m_low) {
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_TH, 0x4);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_EN, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_SB2, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_SB0, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_TH, 0x4);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_EN, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_SB2, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_SB0, 0x1);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_TH, 0x4);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_EN, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_SB2, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_SB0, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_TH, 0x4);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_EN, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_SB2, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_SB0, 0x0);
+	}
+	rtw89_phy_write32_idx(rtwdev, R_ASSIGN_SBD_OPT_V1,
+			      B_ASSIGN_SBD_OPT_EN_V1, 0x1, phy_idx);
+}
+
+static void rtw8852b_bb_reset_all(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	rtw89_phy_write32_idx(rtwdev, R_S0_HW_SI_DIS, B_S0_HW_SI_DIS_W_R_TRIG, 0x7, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_S1_HW_SI_DIS, B_S1_HW_SI_DIS_W_R_TRIG, 0x7, phy_idx);
+	fsleep(1);
+	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 0, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_S0_HW_SI_DIS, B_S0_HW_SI_DIS_W_R_TRIG, 0x0, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_S1_HW_SI_DIS, B_S1_HW_SI_DIS_W_R_TRIG, 0x0, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1, phy_idx);
+}
+
+static void rtw8852b_set_channel_bb(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan,
+				    enum rtw89_phy_idx phy_idx)
+{
+	bool cck_en = chan->channel <= 14;
+	u8 pri_ch_idx = chan->pri_ch_idx;
+
+	if (cck_en)
+		rtw8852b_ctrl_sco_cck(rtwdev,  chan->primary_channel);
+
+	rtw8852b_ctrl_ch(rtwdev, chan, phy_idx);
+	rtw8852b_ctrl_bw(rtwdev, pri_ch_idx, chan->band_width, phy_idx);
+	rtw8852b_ctrl_cck_en(rtwdev, cck_en);
+	if (chan->band_type == RTW89_BAND_5G) {
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_SHARE_V1,
+				       B_PATH0_BT_SHARE_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BTG_PATH_V1,
+				       B_PATH0_BTG_PATH_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BT_SHARE_V1,
+				       B_PATH1_BT_SHARE_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BTG_PATH_V1,
+				       B_PATH1_BTG_PATH_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_BT_SHARE, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_BT_SEG0, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_BT_DYN_DC_EST_EN_V1,
+				       B_BT_DYN_DC_EST_EN_MSK, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_GNT_BT_WGT_EN, B_GNT_BT_WGT_EN, 0x0);
+	}
+	rtw89_phy_write32_mask(rtwdev, R_MAC_PIN_SEL, B_CH_IDX_SEG0,
+			       chan->primary_channel);
+	rtw8852b_5m_mask(rtwdev, chan, phy_idx);
+	rtw8852b_bb_reset_all(rtwdev, phy_idx);
+}
+
+static void rtw8852b_set_channel(struct rtw89_dev *rtwdev,
+				 const struct rtw89_chan *chan,
+				 enum rtw89_mac_idx mac_idx,
+				 enum rtw89_phy_idx phy_idx)
+{
+	rtw8852b_set_channel_mac(rtwdev, chan, mac_idx);
+	rtw8852b_set_channel_bb(rtwdev, chan, phy_idx);
+	rtw8852b_set_channel_rf(rtwdev, chan, phy_idx);
+}
+
 static u32 rtw8852b_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
 				     enum rtw89_phy_idx phy_idx, s16 ref)
 {
@@ -579,6 +1142,7 @@ static int rtw8852b_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.enable_bb_rf		= rtw8852b_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw8852b_mac_disable_bb_rf,
+	.set_channel		= rtw8852b_set_channel,
 	.read_efuse		= rtw8852b_read_efuse,
 	.read_phycap		= rtw8852b_read_phycap,
 	.power_trim		= rtw8852b_power_trim,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
new file mode 100644
index 0000000000000..761544b0dcca1
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2022  Realtek Corporation
+ */
+
+#include "coex.h"
+#include "debug.h"
+#include "mac.h"
+#include "phy.h"
+#include "reg.h"
+#include "rtw8852b.h"
+#include "rtw8852b_rfk.h"
+#include "rtw8852b_rfk_table.h"
+#include "rtw8852b_table.h"
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
+static void _bw_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
+			enum rtw89_bandwidth bw, bool dav)
+{
+	u32 rf_reg18;
+	u32 reg18_addr = dav ? RR_CFGCH : RR_CFGCH_V1;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]===> %s\n", __func__);
+
+	rf_reg18 = rtw89_read_rf(rtwdev, path, reg18_addr, RFREG_MASK);
+	if (rf_reg18 == INV_RF_DATA) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK]Invalid RF_0x18 for Path-%d\n", path);
+		return;
+	}
+	rf_reg18 &= ~RR_CFGCH_BW;
+
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_5:
+	case RTW89_CHANNEL_WIDTH_10:
+	case RTW89_CHANNEL_WIDTH_20:
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BW, CFGCH_BW_20M);
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BW, CFGCH_BW_40M);
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BW, CFGCH_BW_80M);
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]Fail to set CH\n");
+	}
+
+	rf_reg18 &= ~(RR_CFGCH_POW_LCK | RR_CFGCH_TRX_AH | RR_CFGCH_BCN |
+		      RR_CFGCH_BW2) & RFREG_MASK;
+	rf_reg18 |= RR_CFGCH_BW2;
+	rtw89_write_rf(rtwdev, path, reg18_addr, RFREG_MASK, rf_reg18);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK] set %x at path%d, %x =0x%x\n",
+		    bw, path, reg18_addr,
+		    rtw89_read_rf(rtwdev, path, reg18_addr, RFREG_MASK));
+}
+
+static void _ctrl_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		     enum rtw89_bandwidth bw)
+{
+	_bw_setting(rtwdev, RF_PATH_A, bw, true);
+	_bw_setting(rtwdev, RF_PATH_B, bw, true);
+	_bw_setting(rtwdev, RF_PATH_A, bw, false);
+	_bw_setting(rtwdev, RF_PATH_B, bw, false);
+}
+
+static bool _set_s0_arfc18(struct rtw89_dev *rtwdev, u32 val)
+{
+	u32 bak;
+	u32 tmp;
+	int ret;
+
+	bak = rtw89_read_rf(rtwdev, RF_PATH_A, RR_LDO, RFREG_MASK);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LDO, RR_LDO_SEL, 0x1);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_CFGCH, RFREG_MASK, val);
+
+	ret = read_poll_timeout_atomic(rtw89_read_rf, tmp, tmp == 0, 1, 1000,
+				       false, rtwdev, RF_PATH_A, RR_LPF, RR_LPF_BUSY);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]LCK timeout\n");
+
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LDO, RFREG_MASK, bak);
+
+	return !!ret;
+}
+
+static void _lck_check(struct rtw89_dev *rtwdev)
+{
+	u32 tmp;
+
+	if (rtw89_read_rf(rtwdev, RF_PATH_A, RR_SYNFB, RR_SYNFB_LK) == 0) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]SYN MMD reset\n");
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MMD, RR_MMD_RST_EN, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MMD, RR_MMD_RST_SYN, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MMD, RR_MMD_RST_SYN, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MMD, RR_MMD_RST_EN, 0x0);
+	}
+
+	udelay(10);
+
+	if (rtw89_read_rf(rtwdev, RF_PATH_A, RR_SYNFB, RR_SYNFB_LK) == 0) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]re-set RF 0x18\n");
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RR_LCK_TRGSEL, 0x1);
+		tmp = rtw89_read_rf(rtwdev, RF_PATH_A, RR_CFGCH, RFREG_MASK);
+		_set_s0_arfc18(rtwdev, tmp);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RR_LCK_TRGSEL, 0x0);
+	}
+
+	if (rtw89_read_rf(rtwdev, RF_PATH_A, RR_SYNFB, RR_SYNFB_LK) == 0) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]SYN off/on\n");
+
+		tmp = rtw89_read_rf(rtwdev, RF_PATH_A, RR_POW, RFREG_MASK);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RFREG_MASK, tmp);
+		tmp = rtw89_read_rf(rtwdev, RF_PATH_A, RR_SX, RFREG_MASK);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_SX, RFREG_MASK, tmp);
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_SYNLUT, RR_SYNLUT_MOD, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN, 0x3);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_SYNLUT, RR_SYNLUT_MOD, 0x0);
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RR_LCK_TRGSEL, 0x1);
+		tmp = rtw89_read_rf(rtwdev, RF_PATH_A, RR_CFGCH, RFREG_MASK);
+		_set_s0_arfc18(rtwdev, tmp);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RR_LCK_TRGSEL, 0x0);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]0xb2=%x, 0xc5=%x\n",
+			    rtw89_read_rf(rtwdev, RF_PATH_A, RR_VCO, RFREG_MASK),
+			    rtw89_read_rf(rtwdev, RF_PATH_A, RR_SYNFB, RFREG_MASK));
+	}
+}
+
+static void _set_ch(struct rtw89_dev *rtwdev, u32 val)
+{
+	bool timeout;
+
+	timeout = _set_s0_arfc18(rtwdev, val);
+	if (!timeout)
+		_lck_check(rtwdev);
+}
+
+static void _ch_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
+			u8 central_ch, bool dav)
+{
+	u32 reg18_addr = dav ? RR_CFGCH : RR_CFGCH_V1;
+	bool is_2g_ch = central_ch <= 14;
+	u32 rf_reg18;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]===> %s\n", __func__);
+
+	rf_reg18 = rtw89_read_rf(rtwdev, path, reg18_addr, RFREG_MASK);
+	rf_reg18 &= ~(RR_CFGCH_BAND1 | RR_CFGCH_POW_LCK | RR_CFGCH_TRX_AH |
+		      RR_CFGCH_BCN | RR_CFGCH_BAND0 | RR_CFGCH_CH);
+	rf_reg18 |= FIELD_PREP(RR_CFGCH_CH, central_ch);
+
+	if (!is_2g_ch)
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BAND1, CFGCH_BAND1_5G) |
+			    FIELD_PREP(RR_CFGCH_BAND0, CFGCH_BAND0_5G);
+
+	rf_reg18 &= ~(RR_CFGCH_POW_LCK | RR_CFGCH_TRX_AH | RR_CFGCH_BCN |
+		      RR_CFGCH_BW2) & RFREG_MASK;
+	rf_reg18 |= RR_CFGCH_BW2;
+
+	if (path == RF_PATH_A && dav)
+		_set_ch(rtwdev, rf_reg18);
+	else
+		rtw89_write_rf(rtwdev, path, reg18_addr, RFREG_MASK, rf_reg18);
+
+	rtw89_write_rf(rtwdev, path, RR_LCKST, RR_LCKST_BIN, 0);
+	rtw89_write_rf(rtwdev, path, RR_LCKST, RR_LCKST_BIN, 1);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[RFK]CH: %d for Path-%d, reg0x%x = 0x%x\n",
+		    central_ch, path, reg18_addr,
+		    rtw89_read_rf(rtwdev, path, reg18_addr, RFREG_MASK));
+}
+
+static void _ctrl_ch(struct rtw89_dev *rtwdev, u8 central_ch)
+{
+	_ch_setting(rtwdev, RF_PATH_A, central_ch, true);
+	_ch_setting(rtwdev, RF_PATH_B, central_ch, true);
+	_ch_setting(rtwdev, RF_PATH_A, central_ch, false);
+	_ch_setting(rtwdev, RF_PATH_B, central_ch, false);
+}
+
+static void _set_rxbb_bw(struct rtw89_dev *rtwdev, enum rtw89_bandwidth bw,
+			 enum rtw89_rf_path path)
+{
+	rtw89_write_rf(rtwdev, path, RR_LUTWE2, RR_LUTWE2_RTXBW, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_LUTWA, RR_LUTWA_M2, 0x12);
+
+	if (bw == RTW89_CHANNEL_WIDTH_20)
+		rtw89_write_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB, 0x1b);
+	else if (bw == RTW89_CHANNEL_WIDTH_40)
+		rtw89_write_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB, 0x13);
+	else if (bw == RTW89_CHANNEL_WIDTH_80)
+		rtw89_write_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB, 0xb);
+	else
+		rtw89_write_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB, 0x3);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK] set S%d RXBB BW 0x3F = 0x%x\n", path,
+		    rtw89_read_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB));
+
+	rtw89_write_rf(rtwdev, path, RR_LUTWE2, RR_LUTWE2_RTXBW, 0x0);
+}
+
+static void _rxbb_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		     enum rtw89_bandwidth bw)
+{
+	u8 kpath, path;
+
+	kpath = _kpath(rtwdev, phy);
+
+	for (path = 0; path < RF_PATH_NUM_8852B; path++) {
+		if (!(kpath & BIT(path)))
+			continue;
+
+		_set_rxbb_bw(rtwdev, bw, path);
+	}
+}
+
+static void rtw8852b_ctrl_bw_ch(struct rtw89_dev *rtwdev,
+				enum rtw89_phy_idx phy, u8 central_ch,
+				enum rtw89_band band, enum rtw89_bandwidth bw)
+{
+	_ctrl_ch(rtwdev, central_ch);
+	_ctrl_bw(rtwdev, phy, bw);
+	_rxbb_bw(rtwdev, phy, bw);
+}
+
+void rtw8852b_set_channel_rf(struct rtw89_dev *rtwdev,
+			     const struct rtw89_chan *chan,
+			     enum rtw89_phy_idx phy_idx)
+{
+	rtw8852b_ctrl_bw_ch(rtwdev, phy_idx, chan->channel, chan->band_type,
+			    chan->band_width);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
new file mode 100644
index 0000000000000..d54256bbc9a0a
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2019-2022  Realtek Corporation
+ */
+
+#ifndef __RTW89_8852B_RFK_H__
+#define __RTW89_8852B_RFK_H__
+
+#include "core.h"
+
+void rtw8852b_set_channel_rf(struct rtw89_dev *rtwdev,
+			     const struct rtw89_chan *chan,
+			     enum rtw89_phy_idx phy_idx);
+
+#endif
-- 
2.25.1

