Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB176EC692
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 08:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjDXGx0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 02:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjDXGxZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 02:53:25 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C379712D
        for <linux-wireless@vger.kernel.org>; Sun, 23 Apr 2023 23:53:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33O6rBPC1029996, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33O6rBPC1029996
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 24 Apr 2023 14:53:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 24 Apr 2023 14:53:12 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 24 Apr
 2023 14:53:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/5] wifi: rtw89: 8851b: rfk: add IQK
Date:   Mon, 24 Apr 2023 14:52:42 +0800
Message-ID: <20230424065242.17477-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230424065242.17477-1-pkshih@realtek.com>
References: <20230424065242.17477-1-pkshih@realtek.com>
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

IQ signal calibration is a very important calibration to yield good RF
performance. We do this calibration only if we are going to run on AP
channel. During scanning phase, without this calibration RF performance
is still acceptable because it transmits with low data rate at this phase.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |    5 +
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 1111 +++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.h |    1 +
 3 files changed, 1117 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c967bf75a0f6d..c25e464ff06a4 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3574,6 +3574,7 @@
 #define RR_MOD_MASK GENMASK(19, 16)
 #define RR_MOD_DCK GENMASK(14, 10)
 #define RR_MOD_RGM GENMASK(13, 4)
+#define RR_MOD_RXB GENMASK(9, 5)
 #define RR_MOD_V_DOWN 0x0
 #define RR_MOD_V_STANDBY 0x1
 #define RR_TXAGC 0x10001
@@ -3713,6 +3714,7 @@
 #define RR_RXBB 0x83
 #define RR_RXBB_VOBUF GENMASK(15, 12)
 #define RR_RXBB_C2G GENMASK(16, 10)
+#define RR_RXBB_C2 GENMASK(11, 8)
 #define RR_RXBB_C1G GENMASK(9, 8)
 #define RR_RXBB_FATT GENMASK(7, 0)
 #define RR_RXBB_ATTR GENMASK(7, 4)
@@ -4578,6 +4580,8 @@
 #define IQK_DF4_TXT_8_25MHZ 0x021
 #define R_IQK_CFG 0x8034
 #define B_IQK_CFG_SET GENMASK(5, 4)
+#define R_IQK_RXA 0x8044
+#define B_IQK_RXAGC GENMASK(15, 13)
 #define R_TPG_SEL 0x8068
 #define R_TPG_MOD 0x806C
 #define B_TPG_MOD_F GENMASK(2, 1)
@@ -4625,6 +4629,7 @@
 #define B_PRT_COM_SYNERR BIT(30)
 #define B_PRT_COM_DCI GENMASK(27, 16)
 #define B_PRT_COM_CORV GENMASK(15, 8)
+#define B_RPT_COM_RDY GENMASK(15, 0)
 #define B_PRT_COM_DCQ GENMASK(11, 0)
 #define B_PRT_COM_RXOV BIT(8)
 #define B_PRT_COM_GL GENMASK(7, 4)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index 816f365ae822b..6eb47ed820102 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -12,11 +12,83 @@
 #include "rtw8851b_rfk_table.h"
 #include "rtw8851b_table.h"
 
+#define RTW8851B_RXK_GROUP_NR 4
+#define RTW8851B_TXK_GROUP_NR 1
+#define RTW8851B_IQK_VER 0x2a
+#define RTW8851B_IQK_SS 1
+#define RTW8851B_LOK_GRAM 10
+
+enum rtw8851b_iqk_type {
+	ID_TXAGC = 0x0,
+	ID_FLOK_COARSE = 0x1,
+	ID_FLOK_FINE = 0x2,
+	ID_TXK = 0x3,
+	ID_RXAGC = 0x4,
+	ID_RXK = 0x5,
+	ID_NBTXK = 0x6,
+	ID_NBRXK = 0x7,
+	ID_FLOK_VBUFFER = 0x8,
+	ID_A_FLOK_COARSE = 0x9,
+	ID_G_FLOK_COARSE = 0xa,
+	ID_A_FLOK_FINE = 0xb,
+	ID_G_FLOK_FINE = 0xc,
+	ID_IQK_RESTORE = 0x10,
+};
+
+static const u32 g_idxrxgain[RTW8851B_RXK_GROUP_NR] = {0x10e, 0x116, 0x28e, 0x296};
+static const u32 g_idxattc2[RTW8851B_RXK_GROUP_NR] = {0x0, 0xf, 0x0, 0xf};
+static const u32 g_idxrxagc[RTW8851B_RXK_GROUP_NR] = {0x0, 0x1, 0x2, 0x3};
+static const u32 a_idxrxgain[RTW8851B_RXK_GROUP_NR] = {0x10C, 0x112, 0x28c, 0x292};
+static const u32 a_idxattc2[RTW8851B_RXK_GROUP_NR] = {0xf, 0xf, 0xf, 0xf};
+static const u32 a_idxrxagc[RTW8851B_RXK_GROUP_NR] = {0x4, 0x5, 0x6, 0x7};
+static const u32 a_power_range[RTW8851B_TXK_GROUP_NR] = {0x0};
+static const u32 a_track_range[RTW8851B_TXK_GROUP_NR] = {0x6};
+static const u32 a_gain_bb[RTW8851B_TXK_GROUP_NR] = {0x0a};
+static const u32 a_itqt[RTW8851B_TXK_GROUP_NR] = {0x12};
+static const u32 g_power_range[RTW8851B_TXK_GROUP_NR] = {0x0};
+static const u32 g_track_range[RTW8851B_TXK_GROUP_NR] = {0x6};
+static const u32 g_gain_bb[RTW8851B_TXK_GROUP_NR] = {0x10};
+static const u32 g_itqt[RTW8851B_TXK_GROUP_NR] = {0x12};
+
+static const u32 rtw8851b_backup_bb_regs[] = {0xc0ec, 0xc0e8};
+static const u32 rtw8851b_backup_rf_regs[] = {
+	0xef, 0xde, 0x0, 0x1e, 0x2, 0x85, 0x90, 0x5};
+
+#define BACKUP_BB_REGS_NR ARRAY_SIZE(rtw8851b_backup_bb_regs)
+#define BACKUP_RF_REGS_NR ARRAY_SIZE(rtw8851b_backup_rf_regs)
+
 static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	return RF_A;
 }
 
+static void _adc_fifo_rst(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			  u8 path)
+{
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x0101);
+	fsleep(10);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RXK, 0x1111);
+}
+
+static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
+{
+	u32 rf_mode;
+	u8 path;
+	int ret;
+
+	for (path = 0; path < RF_PATH_MAX; path++) {
+		if (!(kpath & BIT(path)))
+			continue;
+
+		ret = read_poll_timeout_atomic(rtw89_read_rf, rf_mode,
+					       rf_mode != 2, 2, 5000, false,
+					       rtwdev, path, 0x00, RR_MOD_MASK);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK] Wait S%d to Rx mode!! (ret = %d)\n",
+			    path, ret);
+	}
+}
+
 static void _dack_reset(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
 {
 	rtw89_phy_write32_mask(rtwdev, R_DCOF0, B_DCOF0_RST, 0x0);
@@ -355,6 +427,1029 @@ static void _dac_cal(struct rtw89_dev *rtwdev, bool force)
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK finish!!!\n");
 }
 
+static void _iqk_sram(struct rtw89_dev *rtwdev, u8 path)
+{
+	u32 i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, MASKDWORD, 0x00020000);
+	rtw89_phy_write32_mask(rtwdev, R_MDPK_RX_DCK, MASKDWORD, 0x80000000);
+	rtw89_phy_write32_mask(rtwdev, R_SRAM_IQRX2, MASKDWORD, 0x00000080);
+	rtw89_phy_write32_mask(rtwdev, R_SRAM_IQRX, MASKDWORD, 0x00010000);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT, 0x009);
+
+	for (i = 0; i <= 0x9f; i++) {
+		rtw89_phy_write32_mask(rtwdev, R_SRAM_IQRX, MASKDWORD,
+				       0x00010000 + i);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]0x%x\n",
+			    rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_DCI));
+	}
+
+	for (i = 0; i <= 0x9f; i++) {
+		rtw89_phy_write32_mask(rtwdev, R_SRAM_IQRX, MASKDWORD,
+				       0x00010000 + i);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]0x%x\n",
+			    rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_DCQ));
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_SRAM_IQRX2, MASKDWORD, 0x00000000);
+	rtw89_phy_write32_mask(rtwdev, R_SRAM_IQRX, MASKDWORD, 0x00000000);
+}
+
+static void _iqk_rxk_setting(struct rtw89_dev *rtwdev, u8 path)
+{
+	rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, 0xc);
+	rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_POW, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_POW, 0x1);
+}
+
+static bool _iqk_check_cal(struct rtw89_dev *rtwdev, u8 path)
+{
+	bool fail1 = false, fail2 = false;
+	u32 val;
+	int ret;
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val == 0x55,
+				       10, 8200, false,
+				       rtwdev, 0xbff8, MASKBYTE0);
+	if (ret) {
+		fail1 = true;
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]NCTL1 IQK timeout!!!\n");
+	}
+
+	fsleep(10);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val == 0x8000,
+				       10, 200, false,
+				       rtwdev, R_RPT_COM, B_RPT_COM_RDY);
+	if (ret) {
+		fail2 = true;
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]NCTL2 IQK timeout!!!\n");
+	}
+
+	fsleep(10);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, MASKBYTE0, 0x0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, ret = %d, notready = %x fail=%d,%d\n",
+		    path, ret, fail1 || fail2, fail1, fail2);
+
+	return fail1 || fail2;
+}
+
+static bool _iqk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			  u8 path, u8 ktype)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool notready;
+	u32 iqk_cmd;
+
+	switch (ktype) {
+	case ID_A_FLOK_COARSE:
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]============ S%d ID_A_FLOK_COARSE ============\n", path);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_IQK_RFC_ON, 0x1);
+		iqk_cmd = 0x108 | (1 << (4 + path));
+		break;
+	case ID_G_FLOK_COARSE:
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]============ S%d ID_G_FLOK_COARSE ============\n", path);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_IQK_RFC_ON, 0x1);
+		iqk_cmd = 0x108 | (1 << (4 + path));
+		break;
+	case ID_A_FLOK_FINE:
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]============ S%d ID_A_FLOK_FINE ============\n", path);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_IQK_RFC_ON, 0x1);
+		iqk_cmd = 0x308 | (1 << (4 + path));
+		break;
+	case ID_G_FLOK_FINE:
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]============ S%d ID_G_FLOK_FINE ============\n", path);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_IQK_RFC_ON, 0x1);
+		iqk_cmd = 0x308 | (1 << (4 + path));
+		break;
+	case ID_TXK:
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]============ S%d ID_TXK ============\n", path);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_IQK_RFC_ON, 0x0);
+		iqk_cmd = 0x008 | (1 << (path + 4)) |
+			  (((0x8 + iqk_info->iqk_bw[path]) & 0xf) << 8);
+		break;
+	case ID_RXAGC:
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]============ S%d ID_RXAGC ============\n", path);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_IQK_RFC_ON, 0x1);
+		iqk_cmd = 0x708 | (1 << (4 + path)) | (path << 1);
+		break;
+	case ID_RXK:
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]============ S%d ID_RXK ============\n", path);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_IQK_RFC_ON, 0x1);
+		iqk_cmd = 0x008 | (1 << (path + 4)) |
+			  (((0xc + iqk_info->iqk_bw[path]) & 0xf) << 8);
+		break;
+	case ID_NBTXK:
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]============ S%d ID_NBTXK ============\n", path);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_IQK_RFC_ON, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT,
+				       0x00b);
+		iqk_cmd = 0x408 | (1 << (4 + path));
+		break;
+	case ID_NBRXK:
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]============ S%d ID_NBRXK ============\n", path);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_IQK_RFC_ON, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT,
+				       0x011);
+		iqk_cmd = 0x608 | (1 << (4 + path));
+		break;
+	default:
+		return false;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, iqk_cmd + 1);
+	notready = _iqk_check_cal(rtwdev, path);
+	if (iqk_info->iqk_sram_en &&
+	    (ktype == ID_NBRXK || ktype == ID_RXK))
+		_iqk_sram(rtwdev, path);
+
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_IQK_RFC_ON, 0x0);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, ktype= %x, id = %x, notready = %x\n",
+		    path, ktype, iqk_cmd + 1, notready);
+
+	return notready;
+}
+
+static bool _rxk_2g_group_sel(struct rtw89_dev *rtwdev,
+			      enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool kfail = false;
+	bool notready;
+	u32 rf_0;
+	u8 gp;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	for (gp = 0; gp < RTW8851B_RXK_GROUP_NR; gp++) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, gp = %x\n", path, gp);
+
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_RGM, g_idxrxgain[gp]);
+		rtw89_write_rf(rtwdev, path, RR_RXBB, RR_RXBB_C2, g_idxattc2[gp]);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_GP_V1, gp);
+
+		rtw89_write_rf(rtwdev, path, RR_RXKPLL, RFREG_MASK, 0x80013);
+		fsleep(10);
+		rf_0 = rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF2, B_IQK_DIF2_RXPI, rf_0);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, g_idxrxagc[gp]);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x11);
+
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXAGC);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S%x, RXAGC 0x8008 = 0x%x, rxbb = %x\n", path,
+			    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD),
+			    rtw89_read_rf(rtwdev, path, RR_MOD, 0x003e0));
+
+		if (gp == 0x3) {
+			rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_OFF, 0x13);
+			rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x011);
+			notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK);
+			iqk_info->nb_rxcfir[path] =
+				rtw89_phy_read32_mask(rtwdev, R_RXIQC, MASKDWORD) | 0x2;
+
+			rtw89_debug(rtwdev, RTW89_DBG_RFK,
+				    "[IQK]S%x, NBRXK 0x8008 = 0x%x\n", path,
+				    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
+		}
+
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXK);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S%x, WBRXK 0x8008 = 0x%x\n", path,
+			    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
+	}
+
+	if (!notready)
+		kfail = !!rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, B_NCTL_RPT_FLG);
+
+	if (kfail)
+		_iqk_sram(rtwdev, path);
+
+	if (kfail) {
+		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8),
+				       MASKDWORD, iqk_info->nb_rxcfir[path] | 0x2);
+		iqk_info->is_wb_txiqk[path] = false;
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8),
+				       MASKDWORD, 0x40000000);
+		iqk_info->is_wb_txiqk[path] = true;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, kfail = 0x%x, 0x8%x3c = 0x%x\n", path, kfail,
+		    1 << path, iqk_info->nb_rxcfir[path]);
+	return kfail;
+}
+
+static bool _rxk_5g_group_sel(struct rtw89_dev *rtwdev,
+			      enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool kfail = false;
+	bool notready;
+	u32 rf_0;
+	u8 gp;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	for (gp = 0; gp < RTW8851B_RXK_GROUP_NR; gp++) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, gp = %x\n", path, gp);
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, 0x03ff0, a_idxrxgain[gp]);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, RR_RXA2_ATT, a_idxattc2[gp]);
+
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_GP_V1, gp);
+
+		rtw89_write_rf(rtwdev, path, RR_RXKPLL, RFREG_MASK, 0x80013);
+		fsleep(100);
+		rf_0 = rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF2, B_IQK_DIF2_RXPI, rf_0);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, a_idxrxagc[gp]);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x11);
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXAGC);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S%x, RXAGC 0x8008 = 0x%x, rxbb = %x\n", path,
+			    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD),
+			    rtw89_read_rf(rtwdev, path, RR_MOD, RR_MOD_RXB));
+
+		if (gp == 0x3) {
+			rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_OFF, 0x13);
+			rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x011);
+			notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK);
+			iqk_info->nb_rxcfir[path] =
+				rtw89_phy_read32_mask(rtwdev, R_RXIQC, MASKDWORD) | 0x2;
+
+			rtw89_debug(rtwdev, RTW89_DBG_RFK,
+				    "[IQK]S%x, NBRXK 0x8008 = 0x%x\n", path,
+				    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
+		}
+
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXK);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S%x, WBRXK 0x8008 = 0x%x\n", path,
+			    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
+	}
+
+	if (!notready)
+		kfail = !!rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, B_NCTL_RPT_FLG);
+
+	if (kfail)
+		_iqk_sram(rtwdev, path);
+
+	if (kfail) {
+		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8), MASKDWORD,
+				       iqk_info->nb_rxcfir[path] | 0x2);
+		iqk_info->is_wb_txiqk[path] = false;
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8), MASKDWORD,
+				       0x40000000);
+		iqk_info->is_wb_txiqk[path] = true;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, kfail = 0x%x, 0x8%x3c = 0x%x\n", path, kfail,
+		    1 << path, iqk_info->nb_rxcfir[path]);
+	return kfail;
+}
+
+static bool _iqk_5g_nbrxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			  u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool kfail = false;
+	bool notready;
+	u8 gp = 0x3;
+	u32 rf_0;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, gp = %x\n", path, gp);
+
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_RGM, a_idxrxgain[gp]);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, RR_RXA2_ATT, a_idxattc2[gp]);
+
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_GP_V1, gp);
+
+	rtw89_write_rf(rtwdev, path, RR_RXKPLL, RFREG_MASK, 0x80013);
+	fsleep(100);
+	rf_0 = rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF2, B_IQK_DIF2_RXPI, rf_0);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, a_idxrxagc[gp]);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x11);
+	notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXAGC);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, RXAGC 0x8008 = 0x%x, rxbb = %x\n", path,
+		    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD),
+		    rtw89_read_rf(rtwdev, path, RR_MOD, 0x003e0));
+
+	if (gp == 0x3) {
+		rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_OFF, 0x13);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x011);
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK);
+		iqk_info->nb_rxcfir[path] =
+			rtw89_phy_read32_mask(rtwdev, R_RXIQC, MASKDWORD) | 0x2;
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S%x, NBRXK 0x8008 = 0x%x\n", path,
+			    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, WBRXK 0x8008 = 0x%x\n",
+		    path, rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
+
+	if (!notready)
+		kfail = !!rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, B_NCTL_RPT_FLG);
+
+	if (kfail) {
+		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8),
+				       MASKDWORD, 0x40000002);
+		iqk_info->is_wb_rxiqk[path] = false;
+	} else {
+		iqk_info->is_wb_rxiqk[path] = false;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, kfail = 0x%x, 0x8%x3c = 0x%x\n", path, kfail,
+		    1 << path, iqk_info->nb_rxcfir[path]);
+
+	return kfail;
+}
+
+static bool _iqk_2g_nbrxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			  u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool kfail = false;
+	bool notready;
+	u8 gp = 0x3;
+	u32 rf_0;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, gp = %x\n", path, gp);
+
+	rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_RGM, g_idxrxgain[gp]);
+	rtw89_write_rf(rtwdev, path, RR_RXBB, RR_RXBB_C2, g_idxattc2[gp]);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_GP_V1, gp);
+
+	rtw89_write_rf(rtwdev, path, RR_RXKPLL, RFREG_MASK, 0x80013);
+	fsleep(10);
+	rf_0 = rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF2, B_IQK_DIF2_RXPI, rf_0);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, g_idxrxagc[gp]);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x11);
+	notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXAGC);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, RXAGC 0x8008 = 0x%x, rxbb = %x\n",
+		    path, rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD),
+		    rtw89_read_rf(rtwdev, path, RR_MOD, 0x003e0));
+
+	if (gp == 0x3) {
+		rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_OFF, 0x13);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x011);
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK);
+		iqk_info->nb_rxcfir[path] =
+			rtw89_phy_read32_mask(rtwdev, R_RXIQC, MASKDWORD) | 0x2;
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S%x, NBRXK 0x8008 = 0x%x\n", path,
+			    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, WBRXK 0x8008 = 0x%x\n",
+		    path, rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
+
+	if (!notready)
+		kfail = !!rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, B_NCTL_RPT_FLG);
+
+	if (kfail) {
+		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8),
+				       MASKDWORD, 0x40000002);
+		iqk_info->is_wb_rxiqk[path] = false;
+	} else {
+		iqk_info->is_wb_rxiqk[path] = false;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, kfail = 0x%x, 0x8%x3c = 0x%x\n", path, kfail,
+		    1 << path, iqk_info->nb_rxcfir[path]);
+	return kfail;
+}
+
+static void _iqk_rxclk_setting(struct rtw89_dev *rtwdev, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+
+	rtw89_write_rf(rtwdev, path, RR_RXBB2, RR_RXBB2_CKT, 0x1);
+
+	if (iqk_info->iqk_bw[path] == RTW89_CHANNEL_WIDTH_80)
+		rtw89_rfk_parser(rtwdev, &rtw8851b_iqk_rxclk_80_defs_tbl);
+	else
+		rtw89_rfk_parser(rtwdev, &rtw8851b_iqk_rxclk_others_defs_tbl);
+}
+
+static bool _txk_5g_group_sel(struct rtw89_dev *rtwdev,
+			      enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool kfail = false;
+	bool notready;
+	u8 gp;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	for (gp = 0x0; gp < RTW8851B_TXK_GROUP_NR; gp++) {
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, a_power_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, a_track_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, a_gain_bb[gp]);
+
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G2, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_GP, gp);
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP, MASKDWORD, a_itqt[gp]);
+
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBTXK);
+		iqk_info->nb_txcfir[path] =
+			rtw89_phy_read32_mask(rtwdev, R_TXIQC, MASKDWORD)  | 0x2;
+
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       MASKDWORD, a_itqt[gp]);
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_TXK);
+	}
+
+	if (!notready)
+		kfail = !!rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, B_NCTL_RPT_FLG);
+
+	if (kfail) {
+		rtw89_phy_write32_mask(rtwdev, R_TXIQC + (path << 8),
+				       MASKDWORD, iqk_info->nb_txcfir[path] | 0x2);
+		iqk_info->is_wb_txiqk[path] = false;
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_TXIQC + (path << 8),
+				       MASKDWORD, 0x40000000);
+		iqk_info->is_wb_txiqk[path] = true;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, kfail = 0x%x, 0x8%x38 = 0x%x\n", path, kfail,
+		    1 << path, iqk_info->nb_txcfir[path]);
+	return kfail;
+}
+
+static bool _txk_2g_group_sel(struct rtw89_dev *rtwdev,
+			      enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool kfail = false;
+	bool notready;
+	u8 gp;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	for (gp = 0x0; gp < RTW8851B_TXK_GROUP_NR; gp++) {
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, g_power_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, g_track_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, g_gain_bb[gp]);
+
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP, MASKDWORD, g_itqt[gp]);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G2, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_GP, gp);
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBTXK);
+		iqk_info->nb_txcfir[path] =
+			rtw89_phy_read32_mask(rtwdev, R_TXIQC, MASKDWORD)  | 0x2;
+
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       MASKDWORD, g_itqt[gp]);
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_TXK);
+	}
+
+	if (!notready)
+		kfail = !!rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, B_NCTL_RPT_FLG);
+
+	if (kfail) {
+		rtw89_phy_write32_mask(rtwdev, R_TXIQC + (path << 8),
+				       MASKDWORD, iqk_info->nb_txcfir[path] | 0x2);
+		iqk_info->is_wb_txiqk[path] = false;
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_TXIQC + (path << 8),
+				       MASKDWORD, 0x40000000);
+		iqk_info->is_wb_txiqk[path] = true;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, kfail = 0x%x, 0x8%x38 = 0x%x\n", path, kfail,
+		    1 << path, iqk_info->nb_txcfir[path]);
+	return kfail;
+}
+
+static bool _iqk_5g_nbtxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			  u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool kfail = false;
+	bool notready;
+	u8 gp;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	for (gp = 0x0; gp < RTW8851B_TXK_GROUP_NR; gp++) {
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, a_power_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, a_track_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, a_gain_bb[gp]);
+
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G2, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_GP, gp);
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP, MASKDWORD, a_itqt[gp]);
+
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBTXK);
+		iqk_info->nb_txcfir[path] =
+			rtw89_phy_read32_mask(rtwdev, R_TXIQC, MASKDWORD)  | 0x2;
+	}
+
+	if (!notready)
+		kfail = !!rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, B_NCTL_RPT_FLG);
+
+	if (kfail) {
+		rtw89_phy_write32_mask(rtwdev, R_TXIQC + (path << 8),
+				       MASKDWORD, 0x40000002);
+		iqk_info->is_wb_rxiqk[path] = false;
+	} else {
+		iqk_info->is_wb_rxiqk[path] = false;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, kfail = 0x%x, 0x8%x38 = 0x%x\n", path, kfail,
+		    1 << path, iqk_info->nb_txcfir[path]);
+	return kfail;
+}
+
+static bool _iqk_2g_nbtxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			  u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool kfail = false;
+	bool notready;
+	u8 gp;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	for (gp = 0x0; gp < RTW8851B_TXK_GROUP_NR; gp++) {
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, g_power_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, g_track_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, g_gain_bb[gp]);
+
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP, MASKDWORD, g_itqt[gp]);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G2, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_GP, gp);
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBTXK);
+		iqk_info->nb_txcfir[path] =
+			rtw89_phy_read32_mask(rtwdev, R_TXIQC + (path << 8),
+					      MASKDWORD)  | 0x2;
+	}
+
+	if (!notready)
+		kfail = !!rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, B_NCTL_RPT_FLG);
+
+	if (kfail) {
+		rtw89_phy_write32_mask(rtwdev, R_TXIQC + (path << 8),
+				       MASKDWORD, 0x40000002);
+		iqk_info->is_wb_rxiqk[path] = false;
+	} else {
+		iqk_info->is_wb_rxiqk[path] = false;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, kfail = 0x%x, 0x8%x38 = 0x%x\n", path, kfail,
+		    1 << path, iqk_info->nb_txcfir[path]);
+	return kfail;
+}
+
+static bool _iqk_2g_lok(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			u8 path)
+{
+	static const u32 g_txbb[RTW8851B_LOK_GRAM] = {
+		0x02, 0x06, 0x0a, 0x0c, 0x0e, 0x10, 0x12, 0x14, 0x16, 0x17};
+	static const u32 g_itqt[RTW8851B_LOK_GRAM] = {
+		0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x12, 0x12, 0x12, 0x1b};
+	static const u32 g_wa[RTW8851B_LOK_GRAM] = {
+		0x00, 0x04, 0x08, 0x0c, 0x0e, 0x10, 0x12, 0x14, 0x16, 0x17};
+	bool fail = false;
+	u8 i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTDBG, RR_LUTDBG_LOK, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_TXIG, RR_TXIG_GR0, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_TXIG, RR_TXIG_GR1, 0x6);
+
+	for (i = 0; i < RTW8851B_LOK_GRAM; i++) {
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_TXIG, RR_TXIG_TG, g_txbb[i]);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RR_LUTWA_M1, g_wa[i]);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_IQK_RFC_ON, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP, B_KIP_IQP_IQSW, g_itqt[i]);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT, 0x021);
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD,
+				       0x00000109 | (1 << (4 + path)));
+		fail |= _iqk_check_cal(rtwdev, path);
+
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP, B_KIP_IQP_IQSW, g_itqt[i]);
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD,
+				       0x00000309 | (1 << (4 + path)));
+		fail |= _iqk_check_cal(rtwdev, path);
+
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_IQK_RFC_ON, 0x0);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S0, i = %x, 0x8[19:15] = 0x%x,0x8[09:05] = 0x%x\n", i,
+			    rtw89_read_rf(rtwdev, RF_PATH_A, RR_DTXLOK, 0xf8000),
+			    rtw89_read_rf(rtwdev, RF_PATH_A, RR_DTXLOK, 0x003e0));
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S0, i = %x, 0x9[19:16] = 0x%x,0x9[09:06] = 0x%x\n", i,
+			    rtw89_read_rf(rtwdev, RF_PATH_A, RR_RSV2, 0xf0000),
+			    rtw89_read_rf(rtwdev, RF_PATH_A, RR_RSV2, 0x003c0));
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S0, i = %x, 0x58 = %x\n", i,
+			    rtw89_read_rf(rtwdev, RF_PATH_A, RR_TXMO, RFREG_MASK));
+	}
+
+	return fail;
+}
+
+static bool _iqk_5g_lok(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			u8 path)
+{
+	static const u32 a_txbb[RTW8851B_LOK_GRAM] = {
+		0x02, 0x06, 0x0a, 0x0c, 0x0e, 0x10, 0x12, 0x14, 0x16, 0x17};
+	static const u32 a_itqt[RTW8851B_LOK_GRAM] = {
+		0x09, 0x09, 0x09, 0x12, 0x12, 0x12, 0x1b, 0x1b, 0x1b, 0x1b};
+	static const u32 a_wa[RTW8851B_LOK_GRAM] = {
+		0x80, 0x84, 0x88, 0x8c, 0x8e, 0x90, 0x92, 0x94, 0x96, 0x97};
+	bool fail = false;
+	u8 i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTDBG, RR_LUTDBG_LOK, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_TXIG, RR_TXIG_GR0, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_TXIG, RR_TXIG_GR1, 0x7);
+
+	for (i = 0; i < RTW8851B_LOK_GRAM; i++) {
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_TXIG, RR_TXIG_TG, a_txbb[i]);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RR_LUTWA_M1, a_wa[i]);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_IQK_RFC_ON, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP, B_KIP_IQP_IQSW, a_itqt[i]);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT, 0x021);
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD,
+				       0x00000109 | (1 << (4 + path)));
+		fail |= _iqk_check_cal(rtwdev, path);
+
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP, B_KIP_IQP_IQSW, a_itqt[i]);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT, 0x021);
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD,
+				       0x00000309 | (1 << (4 + path)));
+		fail |= _iqk_check_cal(rtwdev, path);
+
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK, B_IQK_RFC_ON, 0x0);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S0, i = %x, 0x8[19:15] = 0x%x,0x8[09:05] = 0x%x\n", i,
+			    rtw89_read_rf(rtwdev, RF_PATH_A, RR_DTXLOK, 0xf8000),
+			    rtw89_read_rf(rtwdev, RF_PATH_A, RR_DTXLOK, 0x003e0));
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S0, i = %x, 0x9[19:16] = 0x%x,0x9[09:06] = 0x%x\n", i,
+			    rtw89_read_rf(rtwdev, RF_PATH_A, RR_RSV2, 0xf0000),
+			    rtw89_read_rf(rtwdev, RF_PATH_A, RR_RSV2, 0x003c0));
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S0, i = %x, 0x58 = %x\n", i,
+			    rtw89_read_rf(rtwdev, RF_PATH_A, RR_TXMO, RFREG_MASK));
+	}
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
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]RTW89_BAND_2G\n");
+		rtw89_rfk_parser(rtwdev, &rtw8851b_iqk_txk_2ghz_defs_tbl);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]RTW89_BAND_5G\n");
+		rtw89_rfk_parser(rtwdev, &rtw8851b_iqk_txk_5ghz_defs_tbl);
+		break;
+	default:
+		break;
+	}
+}
+
+#define IQK_LOK_RETRY 1
+
+static void _iqk_by_path(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			 u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool lok_is_fail;
+	u8 i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	for (i = 0; i < IQK_LOK_RETRY; i++) {
+		_iqk_txk_setting(rtwdev, path);
+		if (iqk_info->iqk_band[path] == RTW89_BAND_2G)
+			lok_is_fail = _iqk_2g_lok(rtwdev, phy_idx, path);
+		else
+			lok_is_fail = _iqk_5g_lok(rtwdev, phy_idx, path);
+
+		if (!lok_is_fail)
+			break;
+	}
+
+	if (iqk_info->is_nbiqk) {
+		if (iqk_info->iqk_band[path] == RTW89_BAND_2G)
+			iqk_info->iqk_tx_fail[0][path] =
+				_iqk_2g_nbtxk(rtwdev, phy_idx, path);
+		else
+			iqk_info->iqk_tx_fail[0][path] =
+				_iqk_5g_nbtxk(rtwdev, phy_idx, path);
+	} else {
+		if (iqk_info->iqk_band[path] == RTW89_BAND_2G)
+			iqk_info->iqk_tx_fail[0][path] =
+				_txk_2g_group_sel(rtwdev, phy_idx, path);
+		else
+			iqk_info->iqk_tx_fail[0][path] =
+				_txk_5g_group_sel(rtwdev, phy_idx, path);
+	}
+
+	_iqk_rxclk_setting(rtwdev, path);
+	_iqk_rxk_setting(rtwdev, path);
+	_adc_fifo_rst(rtwdev, phy_idx, path);
+
+	if (iqk_info->is_nbiqk) {
+		if (iqk_info->iqk_band[path] == RTW89_BAND_2G)
+			iqk_info->iqk_rx_fail[0][path] =
+				_iqk_2g_nbrxk(rtwdev, phy_idx, path);
+		else
+			iqk_info->iqk_rx_fail[0][path] =
+				_iqk_5g_nbrxk(rtwdev, phy_idx, path);
+	} else {
+		if (iqk_info->iqk_band[path] == RTW89_BAND_2G)
+			iqk_info->iqk_rx_fail[0][path] =
+				_rxk_2g_group_sel(rtwdev, phy_idx, path);
+		else
+			iqk_info->iqk_rx_fail[0][path] =
+				_rxk_5g_group_sel(rtwdev, phy_idx, path);
+	}
+}
+
+static void _rfk_backup_bb_reg(struct rtw89_dev *rtwdev,
+			       u32 backup_bb_reg_val[])
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_BB_REGS_NR; i++) {
+		backup_bb_reg_val[i] =
+			rtw89_phy_read32_mask(rtwdev, rtw8851b_backup_bb_regs[i],
+					      MASKDWORD);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK]backup bb reg : %x, value =%x\n",
+			    rtw8851b_backup_bb_regs[i], backup_bb_reg_val[i]);
+	}
+}
+
+static void _rfk_backup_rf_reg(struct rtw89_dev *rtwdev,
+			       u32 backup_rf_reg_val[], u8 rf_path)
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_RF_REGS_NR; i++) {
+		backup_rf_reg_val[i] =
+			rtw89_read_rf(rtwdev, rf_path,
+				      rtw8851b_backup_rf_regs[i], RFREG_MASK);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK]backup rf S%d reg : %x, value =%x\n", rf_path,
+			    rtw8851b_backup_rf_regs[i], backup_rf_reg_val[i]);
+	}
+}
+
+static void _rfk_restore_bb_reg(struct rtw89_dev *rtwdev,
+				const u32 backup_bb_reg_val[])
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_BB_REGS_NR; i++) {
+		rtw89_phy_write32_mask(rtwdev, rtw8851b_backup_bb_regs[i],
+				       MASKDWORD, backup_bb_reg_val[i]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK]restore bb reg : %x, value =%x\n",
+			    rtw8851b_backup_bb_regs[i], backup_bb_reg_val[i]);
+	}
+}
+
+static void _rfk_restore_rf_reg(struct rtw89_dev *rtwdev,
+				const u32 backup_rf_reg_val[], u8 rf_path)
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_RF_REGS_NR; i++) {
+		rtw89_write_rf(rtwdev, rf_path, rtw8851b_backup_rf_regs[i],
+			       RFREG_MASK, backup_rf_reg_val[i]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK]restore rf S%d reg: %x, value =%x\n", rf_path,
+			    rtw8851b_backup_rf_regs[i], backup_rf_reg_val[i]);
+	}
+}
+
+static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			     u8 path)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u8 idx = 0;
+
+	iqk_info->iqk_band[path] = chan->band_type;
+	iqk_info->iqk_bw[path] = chan->band_width;
+	iqk_info->iqk_ch[path] = chan->channel;
+	iqk_info->iqk_table_idx[path] = idx;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d (PHY%d): / DBCC %s/ %s/ CH%d/ %s\n",
+		    path, phy, rtwdev->dbcc_en ? "on" : "off",
+		    iqk_info->iqk_band[path] == 0 ? "2G" :
+		    iqk_info->iqk_band[path] == 1 ? "5G" : "6G",
+		    iqk_info->iqk_ch[path],
+		    iqk_info->iqk_bw[path] == 0 ? "20M" :
+		    iqk_info->iqk_bw[path] == 1 ? "40M" : "80M");
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]times = 0x%x, ch =%x\n",
+		    iqk_info->iqk_times, idx);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, iqk_info->syn1to2= 0x%x\n",
+		    path, iqk_info->syn1to2);
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
+	bool fail;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, 0x00001219);
+	fsleep(10);
+	fail = _iqk_check_cal(rtwdev, path);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] restore fail=%d\n", fail);
+
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_RPT, MASKDWORD, 0x00000000);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_SYSCFG, MASKDWORD, 0x80000000);
+}
+
+static void _iqk_afebb_restore(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy_idx, u8 path)
+{
+	rtw89_rfk_parser(rtwdev, &rtw8851b_iqk_afebb_restore_defs_tbl);
+}
+
+static void _iqk_preset(struct rtw89_dev *rtwdev, u8 path)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_RPT, MASKDWORD, 0x00000080);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_SYSCFG, MASKDWORD, 0x81ff010a);
+}
+
+static void _iqk_macbb_setting(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy_idx, u8 path)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	rtw89_rfk_parser(rtwdev, &rtw8851b_iqk_macbb_defs_tbl);
+}
+
+static void _iqk_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u8 idx, path;
+
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF, MASKDWORD, 0x0);
+
+	if (iqk_info->is_iqk_init)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+
+	iqk_info->is_iqk_init = true;
+	iqk_info->is_nbiqk = false;
+	iqk_info->iqk_fft_en = false;
+	iqk_info->iqk_sram_en = false;
+	iqk_info->iqk_cfir_en = false;
+	iqk_info->iqk_xym_en = false;
+	iqk_info->thermal_rek_en = false;
+	iqk_info->iqk_times = 0x0;
+
+	for (idx = 0; idx < RTW89_IQK_CHS_NR; idx++) {
+		iqk_info->iqk_channel[idx] = 0x0;
+		for (path = 0; path < RF_PATH_NUM_8851B; path++) {
+			iqk_info->lok_cor_fail[idx][path] = false;
+			iqk_info->lok_fin_fail[idx][path] = false;
+			iqk_info->iqk_tx_fail[idx][path] = false;
+			iqk_info->iqk_rx_fail[idx][path] = false;
+			iqk_info->iqk_table_idx[path] = 0x0;
+		}
+	}
+}
+
+static void _doiqk(struct rtw89_dev *rtwdev, bool force,
+		   enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB);
+	u32 backup_rf_val[RTW8851B_IQK_SS][BACKUP_RF_REGS_NR];
+	u32 backup_bb_val[BACKUP_BB_REGS_NR];
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK,
+			      BTC_WRFK_ONESHOT_START);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]==========IQK strat!!!!!==========\n");
+	iqk_info->iqk_times++;
+	iqk_info->kcount = 0;
+	iqk_info->version = RTW8851B_IQK_VER;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]Test Ver 0x%x\n", iqk_info->version);
+	_iqk_get_ch_info(rtwdev, phy_idx, path);
+
+	_rfk_backup_bb_reg(rtwdev, &backup_bb_val[0]);
+	_rfk_backup_rf_reg(rtwdev, &backup_rf_val[path][0], path);
+	_iqk_macbb_setting(rtwdev, phy_idx, path);
+	_iqk_preset(rtwdev, path);
+	_iqk_start_iqk(rtwdev, phy_idx, path);
+	_iqk_restore(rtwdev, path);
+	_iqk_afebb_restore(rtwdev, phy_idx, path);
+	_rfk_restore_bb_reg(rtwdev, &backup_bb_val[0]);
+	_rfk_restore_rf_reg(rtwdev, &backup_rf_val[path][0], path);
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK,
+			      BTC_WRFK_ONESHOT_STOP);
+}
+
+static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool force)
+{
+	_doiqk(rtwdev, force, phy_idx, RF_PATH_A);
+}
+
 static void _rck(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
 {
 	u32 rf_reg5;
@@ -442,6 +1537,22 @@ void rtw8851b_dack(struct rtw89_dev *rtwdev)
 	_dac_cal(rtwdev, false);
 }
 
+void rtw8851b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u32 tx_en;
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
 static void _bw_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
 			enum rtw89_bandwidth bw, bool dav)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
index a6ebe4d29573f..d86c630ff47ec 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
@@ -10,6 +10,7 @@
 void rtw8851b_aack(struct rtw89_dev *rtwdev);
 void rtw8851b_rck(struct rtw89_dev *rtwdev);
 void rtw8851b_dack(struct rtw89_dev *rtwdev);
+void rtw8851b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8851b_set_channel_rf(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx);
-- 
2.25.1

