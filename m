Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4306751431B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355055AbiD2HWN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 03:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355060AbiD2HWK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 03:22:10 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32601BE9F2
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 00:18:50 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23T7Ig6H2001400, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23T7Ig6H2001400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Apr 2022 15:18:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 29 Apr 2022 15:18:42 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 29 Apr
 2022 15:18:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 07/16] rtw89: 8852c: rfk: add IQK
Date:   Fri, 29 Apr 2022 15:18:00 +0800
Message-ID: <20220429071809.32104-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429071809.32104-1-pkshih@realtek.com>
References: <20220429071809.32104-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/29/2022 06:59:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjkgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IQ signal calibration is a very important calibration to yield good RF
performance. We do this calibration only if we are going to run on AP
channel. During scanning phase, without this calibration RF performance
is still acceptable because it transmits with low data rate at this phase.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |    3 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   55 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |    1 +
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 1038 +++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |    1 +
 5 files changed, 1094 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 41d23711dc354..8fd719f93d6c7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2649,6 +2649,7 @@ struct rtw89_lck_info {
 struct rtw89_iqk_info {
 	bool lok_cor_fail[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
 	bool lok_fin_fail[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
+	bool lok_fail[RTW89_IQK_PATH_NR];
 	bool iqk_tx_fail[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
 	bool iqk_rx_fail[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
 	u32 iqk_fail_cnt;
@@ -2677,6 +2678,8 @@ struct rtw89_iqk_info {
 	u32 syn1to2;
 	u8 iqk_mcc_ch[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
 	u8 iqk_table_idx[RTW89_IQK_PATH_NR];
+	u32 lok_idac[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
+	u32 lok_vbuf[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
 };
 
 #define RTW89_DPK_RF_PATH 2
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c65598a7af268..120fc13520fcc 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3202,6 +3202,7 @@
 #define RR_MOD_V_DPK 0x5
 #define RR_MOD_V_RXK1 0x6
 #define RR_MOD_V_RXK2 0x7
+#define RR_MOD_NBW GENMASK(15, 14)
 #define RR_MOD_M_RXG GENMASK(13, 4)
 #define RR_MOD_M_RXBB GENMASK(9, 5)
 #define RR_MODOPT 0x01
@@ -3210,8 +3211,20 @@
 #define RR_WLSEL_AG GENMASK(18, 16)
 #define RR_RSV1 0x05
 #define RR_RSV1_RST BIT(0)
+#define RR_BBDC 0x10005
+#define RR_BBDC_SEL BIT(0)
 #define RR_DTXLOK 0x08
 #define RR_RSV2 0x09
+#define RR_LOKVB 0x0a
+#define RR_LOKVB_COI GENMASK(19, 14)
+#define RR_LOKVB_COQ GENMASK(9, 4)
+#define RR_TXIG 0x11
+#define RR_TXIG_TG GENMASK(16, 12)
+#define RR_TXIG_GR1 GENMASK(6, 4)
+#define RR_TXIG_GR0 GENMASK(1, 0)
+#define RR_CHTR 0x17
+#define RR_CHTR_MOD GENMASK(11, 10)
+#define RR_CHTR_TXRX GENMASK(9, 0)
 #define RR_CFGCH 0x18
 #define RR_CFGCH_V1 0x10018
 #define RR_CFGCH_BAND1 GENMASK(17, 16)
@@ -3242,6 +3255,8 @@
 #define RR_RXKPLL_OFF GENMASK(5, 0)
 #define RR_RXKPLL_POW BIT(19)
 #define RR_RSV4 0x1f
+#define RR_RSV4_AGH GENMASK(17, 16)
+#define RR_RSV4_PLLCH GENMASK(9, 0)
 #define RR_RXK 0x20
 #define RR_RXK_SEL2G BIT(8)
 #define RR_RXK_SEL5G BIT(7)
@@ -3264,8 +3279,9 @@
 #define RR_TXG2_ATT0 BIT(11)
 #define RR_BSPAD 0x54
 #define RR_TXGA 0x55
-#define RR_TXGA_LOK_EN BIT(0)
 #define RR_TXGA_TRK_EN BIT(7)
+#define RR_TXGA_LOK_EXT GENMASK(4, 0)
+#define RR_TXGA_LOK_EN BIT(0)
 #define RR_GAINTX 0x56
 #define RR_GAINTX_ALL GENMASK(15, 0)
 #define RR_GAINTX_PAD GENMASK(9, 5)
@@ -3288,26 +3304,37 @@
 #define RR_BIASA2 0x63
 #define RR_BIASA2_LB GENMASK(4, 2)
 #define RR_TXATANK 0x64
+#define RR_TXATANK_LBSW2 GENMASK(17, 15)
 #define RR_TXATANK_LBSW GENMASK(16, 15)
+#define RR_TXA2 0x65
+#define RR_TXA2_LDO GENMASK(19, 16)
 #define RR_TRXIQ 0x66
 #define RR_RSV6 0x6d
 #define RR_TXPOW 0x7f
-#define RR_TXPOW_TXG BIT(1)
 #define RR_TXPOW_TXA BIT(8)
+#define RR_TXPOW_TXAS BIT(7)
+#define RR_TXPOW_TXG BIT(1)
 #define RR_RXPOW 0x80
 #define RR_RXPOW_IQK GENMASK(17, 16)
 #define RR_RXBB 0x83
+#define RR_RXBB_VOBUF GENMASK(15, 12)
 #define RR_RXBB_C2G GENMASK(16, 10)
 #define RR_RXBB_C1G GENMASK(9, 8)
 #define RR_RXBB_ATTR GENMASK(7, 4)
 #define RR_RXBB_ATTC GENMASK(2, 0)
+#define RR_RXG 0x84
+#define RR_RXG_IQKMOD GENMASK(19, 16)
 #define RR_XGLNA2 0x85
 #define RR_XGLNA2_SW GENMASK(1, 0)
+#define RR_RXAE 0x89
+#define RR_RXAE_IQKMOD GENMASK(3, 0)
 #define RR_RXA 0x8a
 #define RR_RXA_DPK GENMASK(9, 8)
 #define RR_RXA2 0x8c
-#define RR_RXA2_C2 GENMASK(9, 3)
 #define RR_RXA2_C1 GENMASK(12, 10)
+#define RR_RXA2_C2 GENMASK(9, 3)
+#define RR_RXA2_IATT GENMASK(7, 4)
+#define RR_RXA2_ATT GENMASK(3, 0)
 #define RR_RXIQGEN 0x8d
 #define RR_RXIQGEN_ATTL GENMASK(12, 8)
 #define RR_RXIQGEN_ATTH GENMASK(14, 13)
@@ -3336,6 +3363,8 @@
 #define RR_MALSEL 0xbe
 #define RR_LCK_TRG 0xd3
 #define RR_LCK_TRGSEL BIT(8)
+#define RR_IQKPLL 0xdc
+#define RR_IQKPLL_MOD GENMASK(9, 8)
 #define RR_RCKD 0xde
 #define RR_RCKD_POW GENMASK(19, 13)
 #define RR_RCKD_BW BIT(2)
@@ -3559,6 +3588,11 @@
 #define B_S0_ADDCK_Q GENMASK(19, 10)
 #define R_ADC_FIFO 0x20fc
 #define B_ADC_FIFO_RST GENMASK(31, 24)
+#define B_ADC_FIFO_RXK GENMASK(31, 16)
+#define B_ADC_FIFO_A3 BIT(28)
+#define B_ADC_FIFO_A2 BIT(24)
+#define B_ADC_FIFO_A1 BIT(20)
+#define B_ADC_FIFO_A0 BIT(16)
 #define R_TXFIR0 0x2300
 #define B_TXFIR_C01 GENMASK(23, 0)
 #define R_TXFIR2 0x2304
@@ -3727,6 +3761,8 @@
 #define B_P0_NBIIDX_NOTCH_EN_V1 BIT(12)
 #define R_P1_MODE 0x4718
 #define B_P1_MODE_SEL GENMASK(31, 30)
+#define R_P0_AGC_CTL 0x4730
+#define B_P0_AGC_EN BIT(31)
 #define R_PATH1_LNA_INIT 0x473C
 #define B_PATH1_LNA_INIT_IDX_MSK GENMASK(26, 24)
 #define R_PATH1_TIA_INIT 0x4748
@@ -3776,6 +3812,8 @@
 #define B_BK_FC0_INV_MSK_V1 GENMASK(18, 0)
 #define R_CCK_FC0_INV_V1 0x4A20
 #define B_CCK_FC0_INV_MSK_V1 GENMASK(18, 0)
+#define R_P1_AGC_CTL 0x4A9C
+#define B_P1_AGC_EN BIT(31)
 #define R_PATH0_RXBB_V1 0x4AD4
 #define B_PATH0_RXBB_MSK_V1 GENMASK(31, 0)
 #define R_PATH1_RXBB_V1 0x4AE0
@@ -3822,6 +3860,12 @@
 #define B_CFO_COMP_VALID_BIT BIT(29)
 #define B_CFO_COMP_WEIGHT_MSK GENMASK(27, 24)
 #define B_CFO_COMP_VAL_MSK GENMASK(11, 0)
+#define R_UPD_CLK 0x5670
+#define B_DAC_VAL BIT(31)
+#define B_ACK_VAL GENMASK(30, 29)
+#define B_DPD_DIS BIT(14)
+#define B_DPD_GDIS BIT(13)
+#define B_IQK_RFC_ON BIT(1)
 #define R_DPD_OFT_EN 0x5800
 #define B_DPD_OFT_EN BIT(28)
 #define R_DPD_OFT_ADDR 0x5804
@@ -3932,8 +3976,9 @@
 #define R_IQK_DIF2 0x8024
 #define B_IQK_DIF2_RXPI GENMASK(19, 0)
 #define R_IQK_DIF4 0x802C
-#define B_IQK_DIF4_TXT GENMASK(11, 0)
 #define B_IQK_DIF4_RXT GENMASK(27, 16)
+#define B_IQK_DIF4_TXT GENMASK(11, 0)
+#define IQK_DF4_TXT_8_25MHZ 0x021
 #define R_IQK_CFG 0x8034
 #define B_IQK_CFG_SET GENMASK(5, 4)
 #define R_TPG_MOD 0x806C
@@ -3995,8 +4040,10 @@
 #define R_CFIR_MAP 0x8150
 #define R_CFIR_LUT 0x8154
 #define B_CFIR_LUT_SEL BIT(8)
+#define B_CFIR_LUT_SET BIT(4)
 #define B_CFIR_LUT_G3 BIT(3)
 #define B_CFIR_LUT_G2 BIT(2)
+#define B_CFIR_LUT_GP_V1 GENMASK(2, 0)
 #define B_CFIR_LUT_GP GENMASK(1, 0)
 #define R_DPD_V1 0x81a0
 #define R_DPD_CH0 0x81AC
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index cbf69670eafe0..0b722675aad42 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1787,6 +1787,7 @@ static void rtw8852c_rfk_channel(struct rtw89_dev *rtwdev)
 	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
 
 	rtw8852c_rx_dck(rtwdev, phy_idx, false);
+	rtw8852c_iqk(rtwdev, phy_idx);
 	rtw8852c_tssi(rtwdev, phy_idx);
 	rtw89_fw_h2c_rf_ntfy_mcc(rtwdev);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 229bb68278ef5..99258c6e5a811 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -25,6 +25,94 @@ static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 		return RF_B;
 }
 
+static const u32 rtw8852c_backup_bb_regs[] = {
+	0x813c, 0x8124, 0x8120, 0xc0d4, 0xc0d8, 0xc0e8, 0x823c, 0x8224, 0x8220,
+	0xc1d4, 0xc1d8, 0xc1e8
+};
+
+static const u32 rtw8852c_backup_rf_regs[] = {
+	0xdf, 0x8f, 0x97, 0xa3, 0x5, 0x10005
+};
+
+#define BACKUP_BB_REGS_NR ARRAY_SIZE(rtw8852c_backup_bb_regs)
+#define BACKUP_RF_REGS_NR ARRAY_SIZE(rtw8852c_backup_rf_regs)
+
+static void _rfk_backup_bb_reg(struct rtw89_dev *rtwdev, u32 backup_bb_reg_val[])
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_BB_REGS_NR; i++) {
+		backup_bb_reg_val[i] =
+			rtw89_phy_read32_mask(rtwdev, rtw8852c_backup_bb_regs[i],
+					      MASKDWORD);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]backup bb reg : %x, value =%x\n",
+			    rtw8852c_backup_bb_regs[i], backup_bb_reg_val[i]);
+	}
+}
+
+static void _rfk_backup_rf_reg(struct rtw89_dev *rtwdev, u32 backup_rf_reg_val[],
+			       u8 rf_path)
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_RF_REGS_NR; i++) {
+		backup_rf_reg_val[i] =
+			rtw89_read_rf(rtwdev, rf_path,
+				      rtw8852c_backup_rf_regs[i], RFREG_MASK);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]backup rf S%d reg : %x, value =%x\n", rf_path,
+			    rtw8852c_backup_rf_regs[i], backup_rf_reg_val[i]);
+	}
+}
+
+static void _rfk_restore_bb_reg(struct rtw89_dev *rtwdev, u32 backup_bb_reg_val[])
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_BB_REGS_NR; i++) {
+		rtw89_phy_write32_mask(rtwdev, rtw8852c_backup_bb_regs[i],
+				       MASKDWORD, backup_bb_reg_val[i]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]restore bb reg : %x, value =%x\n",
+			    rtw8852c_backup_bb_regs[i], backup_bb_reg_val[i]);
+	}
+}
+
+static void _rfk_restore_rf_reg(struct rtw89_dev *rtwdev, u32 backup_rf_reg_val[],
+				u8 rf_path)
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_RF_REGS_NR; i++) {
+		rtw89_write_rf(rtwdev, rf_path, rtw8852c_backup_rf_regs[i],
+			       RFREG_MASK, backup_rf_reg_val[i]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]restore rf S%d reg: %x, value =%x\n", rf_path,
+			    rtw8852c_backup_rf_regs[i], backup_rf_reg_val[i]);
+	}
+}
+
+static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
+{
+	u8 path;
+	u32 rf_mode;
+	int ret;
+
+	for (path = 0; path < RF_PATH_MAX; path++) {
+		if (!(kpath & BIT(path)))
+			continue;
+
+		ret = read_poll_timeout_atomic(rtw89_read_rf, rf_mode, rf_mode != 2,
+					       2, 5000, false, rtwdev, path, 0x00,
+					       RR_MOD_MASK);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK] Wait S%d to Rx mode!! (ret = %d)\n",
+			    path, ret);
+	}
+}
+
 static void _dack_dump(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_dack_info *dack = &rtwdev->dack;
@@ -456,6 +544,860 @@ static void _dac_cal(struct rtw89_dev *rtwdev, bool force)
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK finish!!!\n");
 }
 
+#define RTW8852C_NCTL_VER 0xd
+#define RTW8852C_IQK_VER 0x2a
+#define RTW8852C_IQK_SS 2
+#define RTW8852C_IQK_THR_REK 8
+#define RTW8852C_IQK_CFIR_GROUP_NR 4
+
+enum rtw8852c_iqk_type {
+	ID_TXAGC,
+	ID_G_FLOK_COARSE,
+	ID_A_FLOK_COARSE,
+	ID_G_FLOK_FINE,
+	ID_A_FLOK_FINE,
+	ID_FLOK_VBUFFER,
+	ID_TXK,
+	ID_RXAGC,
+	ID_RXK,
+	ID_NBTXK,
+	ID_NBRXK,
+};
+
+static void rtw8852c_disable_rxagc(struct rtw89_dev *rtwdev, u8 path, u8 en_rxgac)
+{
+	if (path == RF_PATH_A)
+		rtw89_phy_write32_mask(rtwdev, R_P0_AGC_CTL, B_P0_AGC_EN, en_rxgac);
+	else
+		rtw89_phy_write32_mask(rtwdev, R_P1_AGC_CTL, B_P1_AGC_EN, en_rxgac);
+}
+
+static void _iqk_rxk_setting(struct rtw89_dev *rtwdev, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+
+	if (path == RF_PATH_A)
+		rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x0101);
+	else
+		rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x0202);
+
+	switch (iqk_info->iqk_bw[path]) {
+	case RTW89_CHANNEL_WIDTH_20:
+	case RTW89_CHANNEL_WIDTH_40:
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13), B_DPD_GDIS, 0x1);
+		rtw8852c_rxck_force(rtwdev, path, true, ADC_480M);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13), B_ACK_VAL, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 + (path << 8), B_P0_CFCH_BW0, 0x3);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1 + (path << 8), B_P0_CFCH_BW1, 0xf);
+		rtw89_write_rf(rtwdev, path, RR_RXBB2, RR_RXBB2_CKT, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P0_NRBW + (path << 13), B_P0_NRBW_DBG, 0x1);
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13), B_DPD_GDIS, 0x1);
+		rtw8852c_rxck_force(rtwdev, path, true, ADC_960M);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13), B_ACK_VAL, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 + (path << 8), B_P0_CFCH_BW0, 0x2);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1 + (path << 8), B_P0_CFCH_BW1, 0xd);
+		rtw89_write_rf(rtwdev, path, RR_RXBB2, RR_RXBB2_CKT, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P0_NRBW + (path << 13), B_P0_NRBW_DBG, 0x1);
+	break;
+	case RTW89_CHANNEL_WIDTH_160:
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13), B_DPD_GDIS, 0x1);
+		rtw8852c_rxck_force(rtwdev, path, true, ADC_1920M);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13), B_ACK_VAL, 0x2);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 + (path << 8), B_P0_CFCH_BW0, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1 + (path << 8), B_P0_CFCH_BW1, 0xb);
+		rtw89_write_rf(rtwdev, path, RR_RXBB2, RR_RXBB2_CKT, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P0_NRBW + (path << 13), B_P0_NRBW_DBG, 0x1);
+		break;
+	default:
+		break;
+	}
+
+	rtw89_rfk_parser(rtwdev, &rtw8852c_iqk_rxk_cfg_defs_tbl);
+
+	if (path == RF_PATH_A)
+		rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x1101);
+	else
+		rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x2202);
+}
+
+static bool _iqk_check_cal(struct rtw89_dev *rtwdev, u8 path, u8 ktype)
+{
+	u32 tmp;
+	u32 val;
+	int ret;
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val == 0x55,
+				       1, 8200, false, rtwdev, 0xbff8, MASKBYTE0);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]IQK timeout!!!\n");
+
+	rtw89_phy_write32_clr(rtwdev, R_NCTL_N1, MASKBYTE0);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, ret=%d\n", path, ret);
+	tmp = rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, type= %x, 0x8008 = 0x%x\n", path, ktype, tmp);
+
+	return false;
+}
+
+static bool _iqk_one_shot(struct rtw89_dev *rtwdev,
+			  enum rtw89_phy_idx phy_idx, u8 path, u8 ktype)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u32 addr_rfc_ctl = R_UPD_CLK + (path << 13);
+	u32 iqk_cmd;
+	bool fail;
+
+	switch (ktype) {
+	case ID_TXAGC:
+		iqk_cmd = 0x008 | (1 << (4 + path)) | (path << 1);
+		break;
+	case ID_A_FLOK_COARSE:
+		rtw89_phy_write32_mask(rtwdev, addr_rfc_ctl, 0x00000002, 0x1);
+		iqk_cmd = 0x008 | (1 << (4 + path));
+		break;
+	case ID_G_FLOK_COARSE:
+		rtw89_phy_write32_mask(rtwdev, addr_rfc_ctl, 0x00000002, 0x1);
+		iqk_cmd = 0x108 | (1 << (4 + path));
+		break;
+	case ID_A_FLOK_FINE:
+		rtw89_phy_write32_mask(rtwdev, addr_rfc_ctl, 0x00000002, 0x1);
+		iqk_cmd = 0x508 | (1 << (4 + path));
+		break;
+	case ID_G_FLOK_FINE:
+		rtw89_phy_write32_mask(rtwdev, addr_rfc_ctl, 0x00000002, 0x1);
+		iqk_cmd = 0x208 | (1 << (4 + path));
+		break;
+	case ID_FLOK_VBUFFER:
+		rtw89_phy_write32_mask(rtwdev, addr_rfc_ctl, 0x00000002, 0x1);
+		iqk_cmd = 0x308 | (1 << (4 + path));
+		break;
+	case ID_TXK:
+		rtw89_phy_write32_mask(rtwdev, addr_rfc_ctl, 0x00000002, 0x0);
+		iqk_cmd = 0x008 | (1 << (4 + path)) | ((0x8 + iqk_info->iqk_bw[path]) << 8);
+		break;
+	case ID_RXAGC:
+		iqk_cmd = 0x508 | (1 << (4 + path)) | (path << 1);
+		break;
+	case ID_RXK:
+		rtw89_phy_write32_mask(rtwdev, addr_rfc_ctl, 0x00000002, 0x1);
+		iqk_cmd = 0x008 | (1 << (4 + path)) | ((0xc + iqk_info->iqk_bw[path]) << 8);
+		break;
+	case ID_NBTXK:
+		rtw89_phy_write32_mask(rtwdev, addr_rfc_ctl, 0x00000002, 0x0);
+		iqk_cmd = 0x408 | (1 << (4 + path));
+		break;
+	case ID_NBRXK:
+		rtw89_phy_write32_mask(rtwdev, addr_rfc_ctl, 0x00000002, 0x1);
+		iqk_cmd = 0x608 | (1 << (4 + path));
+		break;
+	default:
+		return false;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, iqk_cmd + 1);
+	fsleep(15);
+	fail = _iqk_check_cal(rtwdev, path, ktype);
+	rtw89_phy_write32_mask(rtwdev, addr_rfc_ctl, 0x00000002, 0x0);
+
+	return fail;
+}
+
+#define RXK_GROUP_NR 4
+static const u32 a6_idxrxgain[RXK_GROUP_NR] = {0x190, 0x196, 0x290, 0x316};
+static const u32 a6_idxattc2[RXK_GROUP_NR] = {0x00, 0x0, 0x00, 0x00};
+static const u32 a_idxrxgain[RXK_GROUP_NR] = {0x190, 0x198, 0x310, 0x318};
+static const u32 a_idxattc2[RXK_GROUP_NR] = {0x00, 0x00, 0x00, 0x00};
+static const u32 g_idxrxgain[RXK_GROUP_NR] = {0x252, 0x26c, 0x350, 0x360};
+static const u32 g_idxattc2[RXK_GROUP_NR] = {0x00, 0x07, 0x00, 0x3};
+
+static bool _rxk_group_sel(struct rtw89_dev *rtwdev,
+			   enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool fail;
+	u32 tmp;
+	u32 bkrf0;
+	u8 gp;
+
+	bkrf0 = rtw89_read_rf(rtwdev, path, RR_MOD, RR_MOD_NBW);
+	if (path == RF_PATH_B) {
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_IQKPLL, RR_IQKPLL_MOD, 0x3);
+		tmp = rtw89_read_rf(rtwdev, RF_PATH_B, RR_CHTR, RR_CHTR_MOD);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_RSV4, RR_RSV4_AGH, tmp);
+		tmp = rtw89_read_rf(rtwdev, RF_PATH_B, RR_CHTR, RR_CHTR_TXRX);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_RSV4, RR_RSV4_PLLCH, tmp);
+	}
+
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+	default:
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, 0xc);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_NBW, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_RXG, RR_RXG_IQKMOD, 0x9);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, 0xc);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_NBW, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_RXAE, RR_RXAE_IQKMOD, 0x8);
+		break;
+	case RTW89_BAND_6G:
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, 0xc);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_NBW, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_RXAE, RR_RXAE_IQKMOD, 0x9);
+		break;
+	}
+
+	fsleep(10);
+
+	for (gp = 0; gp < RXK_GROUP_NR; gp++) {
+		switch (iqk_info->iqk_band[path]) {
+		case RTW89_BAND_2G:
+		default:
+			rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_M_RXG,
+				       g_idxrxgain[gp]);
+			rtw89_write_rf(rtwdev, path, RR_RXBB, RR_RXBB_VOBUF,
+				       g_idxattc2[gp]);
+			break;
+		case RTW89_BAND_5G:
+			rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_M_RXG,
+				       a_idxrxgain[gp]);
+			rtw89_write_rf(rtwdev, path, RR_RXA2, RR_RXA2_IATT,
+				       a_idxattc2[gp]);
+			break;
+		case RTW89_BAND_6G:
+			rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_M_RXG,
+				       a6_idxrxgain[gp]);
+			rtw89_write_rf(rtwdev, path, RR_RXA2, RR_RXA2_IATT,
+				       a6_idxattc2[gp]);
+			break;
+		}
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       B_CFIR_LUT_SEL, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       B_CFIR_LUT_SET, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       B_CFIR_LUT_GP_V1, gp);
+		fail = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXK);
+	}
+
+	if (path == RF_PATH_B)
+		rtw89_write_rf(rtwdev, path, RR_IQKPLL, RR_IQKPLL_MOD, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_NBW, bkrf0);
+
+	if (fail) {
+		iqk_info->nb_rxcfir[path] = 0x40000002;
+		iqk_info->is_wb_rxiqk[path] = false;
+	} else {
+		iqk_info->nb_rxcfir[path] = 0x40000000;
+		iqk_info->is_wb_rxiqk[path] = true;
+	}
+
+	return false;
+}
+
+static bool _iqk_nbrxk(struct rtw89_dev *rtwdev,
+		       enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool fail;
+	u32 tmp;
+	u32 bkrf0;
+	u8 gp = 0x2;
+
+	bkrf0 = rtw89_read_rf(rtwdev, path, RR_MOD, RR_MOD_NBW);
+	if (path == RF_PATH_B) {
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_IQKPLL, RR_IQKPLL_MOD, 0x3);
+		tmp = rtw89_read_rf(rtwdev, RF_PATH_B, RR_CHTR, RR_CHTR_MOD);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_RSV4, RR_RSV4_AGH, tmp);
+		tmp = rtw89_read_rf(rtwdev, RF_PATH_B, RR_CHTR, RR_CHTR_TXRX);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_RSV4, RR_RSV4_PLLCH, tmp);
+	}
+
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+	default:
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, 0xc);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_NBW, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_RXG, RR_RXG_IQKMOD, 0x9);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, 0xc);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_NBW, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_RXAE, RR_RXAE_IQKMOD, 0x8);
+		break;
+	case RTW89_BAND_6G:
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, 0xc);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_NBW, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_RXAE, RR_RXAE_IQKMOD, 0x9);
+		break;
+	}
+
+	fsleep(10);
+
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+	default:
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_M_RXG, g_idxrxgain[gp]);
+		rtw89_write_rf(rtwdev, path, RR_RXBB, RR_RXBB_VOBUF, g_idxattc2[gp]);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_M_RXG, a_idxrxgain[gp]);
+		rtw89_write_rf(rtwdev, path, RR_RXA2, RR_RXA2_IATT, a_idxattc2[gp]);
+		break;
+	case RTW89_BAND_6G:
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_M_RXG, a6_idxrxgain[gp]);
+		rtw89_write_rf(rtwdev, path, RR_RXA2, RR_RXA2_IATT, a6_idxattc2[gp]);
+		break;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_SEL, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_SET, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_GP_V1, gp);
+	fail = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXK);
+
+	if (path == RF_PATH_B)
+		rtw89_write_rf(rtwdev, path, RR_IQKPLL, RR_IQKPLL_MOD, 0x0);
+
+	rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_NBW, bkrf0);
+
+	if (fail)
+		iqk_info->nb_rxcfir[path] =
+			rtw89_phy_read32_mask(rtwdev, R_RXIQC + (path << 8),
+					      MASKDWORD) | 0x2;
+	else
+		iqk_info->nb_rxcfir[path] = 0x40000002;
+
+	iqk_info->is_wb_rxiqk[path] = false;
+	return fail;
+}
+
+#define TXK_GROUP_NR 3
+static const u32 a6_power_range[TXK_GROUP_NR] = {0x0, 0x0, 0x0};
+static const u32 a6_track_range[TXK_GROUP_NR] = {0x6, 0x7, 0x7};
+static const u32 a6_gain_bb[TXK_GROUP_NR] = {0x12, 0x09, 0x0e};
+static const u32 a6_itqt[TXK_GROUP_NR] = {0x12, 0x12, 0x12};
+static const u32 a_power_range[TXK_GROUP_NR] = {0x0, 0x0, 0x0};
+static const u32 a_track_range[TXK_GROUP_NR] = {0x5, 0x6, 0x7};
+static const u32 a_gain_bb[TXK_GROUP_NR] = {0x12, 0x09, 0x0e};
+static const u32 a_itqt[TXK_GROUP_NR] = {0x12, 0x12, 0x12};
+static const u32 g_power_range[TXK_GROUP_NR] = {0x0, 0x0, 0x0};
+static const u32 g_track_range[TXK_GROUP_NR] = {0x5, 0x6, 0x6};
+static const u32 g_gain_bb[TXK_GROUP_NR] = {0x0e, 0x0a, 0x0e};
+static const u32 g_itqt[TXK_GROUP_NR] = { 0x12, 0x12, 0x12};
+
+static bool _txk_group_sel(struct rtw89_dev *rtwdev,
+			   enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool fail;
+	u8 gp;
+
+	for (gp = 0; gp < TXK_GROUP_NR; gp++) {
+		switch (iqk_info->iqk_band[path]) {
+		case RTW89_BAND_2G:
+			rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0,
+				       g_power_range[gp]);
+			rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1,
+				       g_track_range[gp]);
+			rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG,
+				       g_gain_bb[gp]);
+			rtw89_phy_write32_mask(rtwdev,
+					       R_KIP_IQP + (path << 8),
+					       MASKDWORD, g_itqt[gp]);
+			break;
+		case RTW89_BAND_5G:
+			rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0,
+				       a_power_range[gp]);
+			rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1,
+				       a_track_range[gp]);
+			rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG,
+				       a_gain_bb[gp]);
+			rtw89_phy_write32_mask(rtwdev,
+					       R_KIP_IQP + (path << 8),
+					       MASKDWORD, a_itqt[gp]);
+			break;
+		case RTW89_BAND_6G:
+			rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0,
+				       a6_power_range[gp]);
+			rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1,
+				       a6_track_range[gp]);
+			rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG,
+				       a6_gain_bb[gp]);
+			rtw89_phy_write32_mask(rtwdev,
+					       R_KIP_IQP + (path << 8),
+					       MASKDWORD, a6_itqt[gp]);
+			break;
+		default:
+			break;
+		}
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       B_CFIR_LUT_SEL, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       B_CFIR_LUT_SET, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       B_CFIR_LUT_G2, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       B_CFIR_LUT_GP, gp + 1);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT, 0x00b);
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+		fail = _iqk_one_shot(rtwdev, phy_idx, path, ID_TXK);
+	}
+
+	if (fail) {
+		iqk_info->nb_txcfir[path] = 0x40000002;
+		iqk_info->is_wb_txiqk[path] = false;
+	} else {
+		iqk_info->nb_txcfir[path] = 0x40000000;
+		iqk_info->is_wb_txiqk[path] = true;
+	}
+
+	return fail;
+}
+
+static bool _iqk_nbtxk(struct rtw89_dev *rtwdev,
+		       enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool fail;
+	u8 gp = 0x2;
+
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, g_power_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, g_track_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, g_gain_bb[gp]);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       MASKDWORD, g_itqt[gp]);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, a_power_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, a_track_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, a_gain_bb[gp]);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       MASKDWORD, a_itqt[gp]);
+		break;
+	case RTW89_BAND_6G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, a6_power_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, a6_track_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, a6_gain_bb[gp]);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       MASKDWORD, a6_itqt[gp]);
+	break;
+	default:
+		break;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_SEL, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_SET, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_G2, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_GP, gp + 1);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT, 0x00b);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+	fail = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBTXK);
+
+	if (!fail)
+		iqk_info->nb_txcfir[path] =
+			rtw89_phy_read32_mask(rtwdev, R_TXIQC + (path << 8),
+					      MASKDWORD) | 0x2;
+	else
+		iqk_info->nb_txcfir[path] = 0x40000002;
+
+	iqk_info->is_wb_txiqk[path] = false;
+
+	return fail;
+}
+
+static bool _lok_finetune_check(struct rtw89_dev *rtwdev, u8 path)
+{
+	struct rtw89_mcc_info *mcc_info = &rtwdev->mcc;
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u8 idx = mcc_info->table_idx;
+	bool is_fail1,  is_fail2;
+	u32 val;
+	u32 core_i;
+	u32 core_q;
+	u32 vbuff_i;
+	u32 vbuff_q;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+	val = rtw89_read_rf(rtwdev,  path, RR_TXMO, RFREG_MASK);
+	core_i = FIELD_GET(RR_TXMO_COI, val);
+	core_q = FIELD_GET(RR_TXMO_COQ, val);
+
+	if (core_i < 0x2 || core_i > 0x1d || core_q < 0x2 || core_q > 0x1d)
+		is_fail1 = true;
+	else
+		is_fail1 = false;
+
+	iqk_info->lok_idac[idx][path] = val;
+
+	val = rtw89_read_rf(rtwdev, path, RR_LOKVB, RFREG_MASK);
+	vbuff_i = FIELD_GET(RR_LOKVB_COI, val);
+	vbuff_q = FIELD_GET(RR_LOKVB_COQ, val);
+
+	if (vbuff_i < 0x2 || vbuff_i > 0x3d || vbuff_q < 0x2 || vbuff_q > 0x3d)
+		is_fail2 = true;
+	else
+		is_fail2 = false;
+
+	iqk_info->lok_vbuf[idx][path] = val;
+
+	return is_fail1 || is_fail2;
+}
+
+static bool _iqk_lok(struct rtw89_dev *rtwdev,
+		     enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u8 tmp_id = 0x0;
+	bool fail = false;
+	bool tmp = false;
+
+	/* Step 0: Init RF gain & tone idx= 8.25Mhz */
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT, IQK_DF4_TXT_8_25MHZ);
+
+	/* Step 1  START: _lok_coarse_fine_wi_swap */
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x6);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       B_KIP_IQP_IQSW, 0x9);
+		tmp_id = ID_G_FLOK_COARSE;
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x6);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       B_KIP_IQP_IQSW, 0x9);
+		tmp_id = ID_A_FLOK_COARSE;
+		break;
+	case RTW89_BAND_6G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x6);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       B_KIP_IQP_IQSW, 0x9);
+		tmp_id = ID_A_FLOK_COARSE;
+		break;
+	default:
+		break;
+	}
+	tmp = _iqk_one_shot(rtwdev, phy_idx, path, tmp_id);
+	iqk_info->lok_cor_fail[0][path] = tmp;
+
+	/* Step 2 */
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x12);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       B_KIP_IQP_IQSW, 0x1b);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x12);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       B_KIP_IQP_IQSW, 0x1b);
+		break;
+	case RTW89_BAND_6G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x12);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       B_KIP_IQP_IQSW, 0x1b);
+		break;
+	default:
+		break;
+	}
+	tmp = _iqk_one_shot(rtwdev, phy_idx, path, ID_FLOK_VBUFFER);
+
+	/* Step 3 */
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x6);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       B_KIP_IQP_IQSW, 0x9);
+		tmp_id = ID_G_FLOK_FINE;
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x6);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       B_KIP_IQP_IQSW, 0x9);
+		tmp_id = ID_A_FLOK_FINE;
+		break;
+	case RTW89_BAND_6G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x6);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       B_KIP_IQP_IQSW, 0x9);
+		tmp_id = ID_A_FLOK_FINE;
+		break;
+	default:
+		break;
+	}
+	tmp = _iqk_one_shot(rtwdev, phy_idx, path, tmp_id);
+	iqk_info->lok_fin_fail[0][path] = tmp;
+
+	/* Step 4 large rf gain */
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+	default:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x12);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       B_KIP_IQP_IQSW, 0x1b);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x12);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       B_KIP_IQP_IQSW, 0x1b);
+		break;
+	case RTW89_BAND_6G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x12);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       B_KIP_IQP_IQSW, 0x1b);
+		break;
+	}
+	tmp = _iqk_one_shot(rtwdev, phy_idx, path, ID_FLOK_VBUFFER);
+	fail = _lok_finetune_check(rtwdev, path);
+
+	return fail;
+}
+
+static void _iqk_txk_setting(struct rtw89_dev *rtwdev, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+	default:
+		rtw89_write_rf(rtwdev, path, RR_TXG1, RR_TXG1_ATT2, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_TXG1, RR_TXG1_ATT1, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_TXG2, RR_TXG2_ATT0, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_TXA2, RR_TXA2_LDO, 0xf);
+		rtw89_write_rf(rtwdev, path, RR_TXGA, RR_TXGA_LOK_EXT, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_LUTWE, RR_LUTWE_LOK, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RFREG_MASK,
+			       0x403e0 | iqk_info->syn1to2);
+		fsleep(10);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, 0x6);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_TXATANK, RR_TXATANK_LBSW2, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_TXPOW, RR_TXPOW_TXAS, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_TXA2, RR_TXA2_LDO, 0xf);
+		rtw89_write_rf(rtwdev, path, RR_TXGA, RR_TXGA_LOK_EXT, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_LUTWE, RR_LUTWE_LOK, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RFREG_MASK,
+			       0x403e0 | iqk_info->syn1to2);
+		fsleep(10);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, 0x6);
+		break;
+	case RTW89_BAND_6G:
+		rtw89_write_rf(rtwdev, path, RR_TXATANK, RR_TXATANK_LBSW2, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_TXPOW, RR_TXPOW_TXAS, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_TXA2, RR_TXA2_LDO, 0xf);
+		rtw89_write_rf(rtwdev, path, RR_TXGA, RR_TXGA_LOK_EXT, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_LUTWE, RR_LUTWE_LOK, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RFREG_MASK,
+			       0x403e0  | iqk_info->syn1to2);
+		fsleep(10);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, 0x6);
+		break;
+	}
+}
+
+static void _iqk_info_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			  u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u32 tmp;
+	bool flag;
+
+	iqk_info->thermal[path] =
+		ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
+	iqk_info->thermal_rek_en = false;
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_thermal = %d\n", path,
+		    iqk_info->thermal[path]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_LOK_COR_fail= %d\n", path,
+		    iqk_info->lok_cor_fail[0][path]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_LOK_FIN_fail= %d\n", path,
+		    iqk_info->lok_fin_fail[0][path]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_TXIQK_fail = %d\n", path,
+		    iqk_info->iqk_tx_fail[0][path]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_RXIQK_fail= %d,\n", path,
+		    iqk_info->iqk_rx_fail[0][path]);
+
+	flag = iqk_info->lok_cor_fail[0][path];
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF, B_IQKINF_FCOR << (path * 4), flag);
+	flag = iqk_info->lok_fin_fail[0][path];
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF, B_IQKINF_FFIN << (path * 4), flag);
+	flag = iqk_info->iqk_tx_fail[0][path];
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF, B_IQKINF_FTX << (path * 4), flag);
+	flag = iqk_info->iqk_rx_fail[0][path];
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF, B_IQKINF_F_RX << (path * 4), flag);
+
+	tmp = rtw89_phy_read32_mask(rtwdev, R_IQK_RES + (path << 8), MASKDWORD);
+	iqk_info->bp_iqkenable[path] = tmp;
+	tmp = rtw89_phy_read32_mask(rtwdev, R_TXIQC + (path << 8), MASKDWORD);
+	iqk_info->bp_txkresult[path] = tmp;
+	tmp = rtw89_phy_read32_mask(rtwdev, R_RXIQC + (path << 8), MASKDWORD);
+	iqk_info->bp_rxkresult[path] = tmp;
+
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF2, B_IQKINF2_KCNT,
+			       iqk_info->iqk_times);
+
+	tmp = rtw89_phy_read32_mask(rtwdev, R_IQKINF, B_IQKINF_FAIL << (path * 4));
+	if (tmp != 0x0)
+		iqk_info->iqk_fail_cnt++;
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF2, B_IQKINF2_FCNT << (path * 4),
+			       iqk_info->iqk_fail_cnt);
+}
+
+static void _iqk_by_path(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+
+	_iqk_txk_setting(rtwdev, path);
+	iqk_info->lok_fail[path] = _iqk_lok(rtwdev, phy_idx, path);
+
+	if (iqk_info->is_nbiqk)
+		iqk_info->iqk_tx_fail[0][path] = _iqk_nbtxk(rtwdev, phy_idx, path);
+	else
+		iqk_info->iqk_tx_fail[0][path] = _txk_group_sel(rtwdev, phy_idx, path);
+
+	_iqk_rxk_setting(rtwdev, path);
+	if (iqk_info->is_nbiqk)
+		iqk_info->iqk_rx_fail[0][path] = _iqk_nbrxk(rtwdev, phy_idx, path);
+	else
+		iqk_info->iqk_rx_fail[0][path] = _rxk_group_sel(rtwdev, phy_idx, path);
+
+	_iqk_info_iqk(rtwdev, phy_idx, path);
+}
+
+static void _iqk_get_ch_info(struct rtw89_dev *rtwdev,
+			     enum rtw89_phy_idx phy, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	iqk_info->iqk_band[path] = hal->current_band_type;
+	iqk_info->iqk_bw[path] = hal->current_band_width;
+	iqk_info->iqk_ch[path] = hal->current_channel;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]iqk_info->iqk_band[%x] = 0x%x\n", path,
+		    iqk_info->iqk_band[path]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]iqk_info->iqk_bw[%x] = 0x%x\n",
+		    path, iqk_info->iqk_bw[path]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]iqk_info->iqk_ch[%x] = 0x%x\n",
+		    path, iqk_info->iqk_ch[path]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%d (PHY%d): / DBCC %s/ %s/ CH%d/ %s\n", path, phy,
+		    rtwdev->dbcc_en ? "on" : "off",
+		    iqk_info->iqk_band[path] == 0 ? "2G" :
+		    iqk_info->iqk_band[path] == 1 ? "5G" : "6G",
+		    iqk_info->iqk_ch[path],
+		    iqk_info->iqk_bw[path] == 0 ? "20M" :
+		    iqk_info->iqk_bw[path] == 1 ? "40M" : "80M");
+	if (!rtwdev->dbcc_en)
+		iqk_info->syn1to2 = 0x1;
+	else
+		iqk_info->syn1to2 = 0x3;
+
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF, B_IQKINF_VER, RTW8852C_IQK_VER);
+	rtw89_phy_write32_mask(rtwdev, R_IQKCH, B_IQKCH_BAND << (path * 16),
+			       iqk_info->iqk_band[path]);
+	rtw89_phy_write32_mask(rtwdev, R_IQKCH, B_IQKCH_BW << (path * 16),
+			       iqk_info->iqk_bw[path]);
+	rtw89_phy_write32_mask(rtwdev, R_IQKCH, B_IQKCH_CH << (path * 16),
+			       iqk_info->iqk_ch[path]);
+
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF2, B_IQKINF2_NCTLV, RTW8852C_NCTL_VER);
+}
+
+static void _iqk_start_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			   u8 path)
+{
+	_iqk_by_path(rtwdev, phy_idx, path);
+}
+
+static void _iqk_restore(struct rtw89_dev *rtwdev, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool fail;
+
+	rtw89_phy_write32_mask(rtwdev, R_TXIQC + (path << 8), MASKDWORD,
+			       iqk_info->nb_txcfir[path]);
+	rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8), MASKDWORD,
+			       iqk_info->nb_rxcfir[path]);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD,
+			       0x00001219 + (path << 4));
+	fsleep(200);
+	fail = _iqk_check_cal(rtwdev, path, 0x12);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] restore fail  = %x\n", fail);
+
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_RPT, MASKDWORD, 0x00000000);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_SYSCFG, MASKDWORD, 0x80000000);
+
+	rtw89_write_rf(rtwdev, path, RR_LUTWE, RR_LUTWE_LOK, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, RR_MOD_V_RX);
+	rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x1);
+}
+
+static void _iqk_afebb_restore(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy_idx, u8 path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852c_iqk_afebb_restore_defs_a_tbl,
+				 &rtw8852c_iqk_afebb_restore_defs_b_tbl);
+
+	rtw8852c_disable_rxagc(rtwdev, path, 0x1);
+}
+
+static void _iqk_preset(struct rtw89_dev *rtwdev, u8 path)
+{
+	struct rtw89_mcc_info *mcc_info = &rtwdev->mcc;
+	u8 idx = 0;
+
+	idx = mcc_info->table_idx;
+	rtw89_phy_write32_mask(rtwdev, R_COEF_SEL + (path << 8), B_COEF_SEL_IQC, idx);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_G3, idx);
+	rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_RPT, MASKDWORD, 0x00000080);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_SYSCFG, MASKDWORD, 0x81ff010a);
+}
+
+static void _iqk_macbb_setting(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy_idx, u8 path)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===> %s\n", __func__);
+	/* 01_BB_AFE_for DPK_S0_20210820 */
+	rtw89_write_rf(rtwdev,  path, RR_BBDC, RR_BBDC_SEL, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A0 << path, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A1 << path, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A2 << path, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A3 << path, 0x0);
+	/* disable rxgac */
+	rtw8852c_disable_rxagc(rtwdev, path, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK | (path << 13), MASKDWORD, 0xf801fffd);
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK | (path << 13), B_DPD_DIS, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK | (path << 13), B_DAC_VAL, 0x1);
+	rtw8852c_txck_force(rtwdev, path, true, DAC_960M);
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK | (path << 13), B_DPD_GDIS, 0x1);
+	rtw8852c_rxck_force(rtwdev, path, true, ADC_1920M);
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK | (path << 13), B_ACK_VAL, 0x2);
+	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 | (path << 8), B_P0_CFCH_BW0, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1 | (path << 8), B_P0_CFCH_BW1, 0xb);
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW | (path << 13), B_P0_NRBW_DBG, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15, 0x1f);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15, 0x13);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_15, 0x0001);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_15, 0x0041);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A1 << path, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A3 << path, 0x1);
+}
+
 static void _rck(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
 {
 	u32 rf_reg5, rck_val = 0;
@@ -491,6 +1433,86 @@ static void _rck(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
 		    rtw89_read_rf(rtwdev, path, RR_RCKS, RFREG_MASK));
 }
 
+static void _iqk_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u8 ch, path;
+
+	rtw89_phy_write32_clr(rtwdev, R_IQKINF, MASKDWORD);
+	if (iqk_info->is_iqk_init)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+	iqk_info->is_iqk_init = true;
+	iqk_info->is_nbiqk = false;
+	iqk_info->iqk_fft_en = false;
+	iqk_info->iqk_sram_en = false;
+	iqk_info->iqk_cfir_en = false;
+	iqk_info->iqk_xym_en = false;
+	iqk_info->thermal_rek_en = false;
+	iqk_info->iqk_times = 0x0;
+
+	for (ch = 0; ch < RTW89_IQK_CHS_NR; ch++) {
+		iqk_info->iqk_channel[ch] = 0x0;
+		for (path = 0; path < RTW8852C_IQK_SS; path++) {
+			iqk_info->lok_cor_fail[ch][path] = false;
+			iqk_info->lok_fin_fail[ch][path] = false;
+			iqk_info->iqk_tx_fail[ch][path] = false;
+			iqk_info->iqk_rx_fail[ch][path] = false;
+			iqk_info->iqk_mcc_ch[ch][path] = 0x0;
+			iqk_info->iqk_table_idx[path] = 0x0;
+		}
+	}
+}
+
+static void _doiqk(struct rtw89_dev *rtwdev, bool force,
+		   enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u32 backup_bb_val[BACKUP_BB_REGS_NR];
+	u32 backup_rf_val[RTW8852C_IQK_SS][BACKUP_RF_REGS_NR];
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB);
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]==========IQK strat!!!!!==========\n");
+	iqk_info->iqk_times++;
+	iqk_info->kcount = 0;
+	iqk_info->version = RTW8852C_IQK_VER;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]Test Ver 0x%x\n", iqk_info->version);
+	_iqk_get_ch_info(rtwdev, phy_idx, path);
+	_rfk_backup_bb_reg(rtwdev, backup_bb_val);
+	_rfk_backup_rf_reg(rtwdev, backup_rf_val[path], path);
+	_iqk_macbb_setting(rtwdev, phy_idx, path);
+	_iqk_preset(rtwdev, path);
+	_iqk_start_iqk(rtwdev, phy_idx, path);
+	_iqk_restore(rtwdev, path);
+	_iqk_afebb_restore(rtwdev, phy_idx, path);
+	_rfk_restore_bb_reg(rtwdev, backup_bb_val);
+	_rfk_restore_rf_reg(rtwdev, backup_rf_val[path], path);
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_STOP);
+}
+
+static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool force)
+{
+	switch (_kpath(rtwdev, phy_idx)) {
+	case RF_A:
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_A);
+		break;
+	case RF_B:
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_B);
+		break;
+	case RF_AB:
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_A);
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_B);
+		break;
+	default:
+		break;
+	}
+}
+
 static void _rx_dck_toggle(struct rtw89_dev *rtwdev, u8 path)
 {
 	int ret;
@@ -1703,6 +2725,22 @@ void rtw8852c_dack(struct rtw89_dev *rtwdev)
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_STOP);
 }
 
+void rtw8852c_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	u32 tx_en;
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_START);
+	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
+	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
+
+	_iqk_init(rtwdev);
+	_iqk(rtwdev, phy_idx, false);
+
+	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_STOP);
+}
+
 #define RXDCK_VER_8852C 0xe
 
 void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool is_afe)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
index fd07028a49640..5c0623f6af208 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
@@ -9,6 +9,7 @@
 
 void rtw8852c_rck(struct rtw89_dev *rtwdev);
 void rtw8852c_dack(struct rtw89_dev *rtwdev);
+void rtw8852c_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool is_afe);
 void rtw8852c_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
 void rtw8852c_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
-- 
2.25.1

