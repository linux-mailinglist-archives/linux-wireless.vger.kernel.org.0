Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC115296C3D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Oct 2020 11:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461618AbgJWJin (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Oct 2020 05:38:43 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45976 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461555AbgJWJih (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Oct 2020 05:38:37 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 09N9cUHU1024657, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 09N9cUHU1024657
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Oct 2020 17:38:30 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 23 Oct 2020 17:38:30 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 03/11] rtw88: coex: reduce magic number
Date:   Fri, 23 Oct 2020 17:37:34 +0800
Message-ID: <20201023093742.29908-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201023093742.29908-1-pkshih@realtek.com>
References: <20201023093742.29908-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB06.realtek.com.tw (172.21.6.99) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Use macro definition to replace magic number.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c     | 30 +++++-----
 drivers/net/wireless/realtek/rtw88/reg.h      |  8 +++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 60 +++++++++++--------
 3 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 6fb916dae40f..c0ea60303cd5 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -145,13 +145,13 @@ static void rtw_coex_wl_ccklock_action(struct rtw_dev *rtwdev)
 			coex_stat->cnt_wl[COEX_CNT_WL_5MS_NOEXTEND] = 0;
 
 		if (coex_stat->cnt_wl[COEX_CNT_WL_5MS_NOEXTEND] == 7) {
-			para[1] = 0x1; /* disable 5ms extend */
+			para[1] = PARA1_H2C69_DIS_5MS;
 			rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
 			coex_stat->wl_slot_extend = false;
 			coex_stat->cnt_wl[COEX_CNT_WL_5MS_NOEXTEND] = 0;
 		}
 	} else if (!coex_stat->wl_slot_extend && coex_stat->wl_cck_lock) {
-		para[1] = 0x0; /* enable 5ms extend */
+		para[1] = PARA1_H2C69_EN_5MS;
 		rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
 		coex_stat->wl_slot_extend = true;
 	}
@@ -777,14 +777,14 @@ static void rtw_coex_coex_ctrl_owner(struct rtw_dev *rtwdev, bool wifi_control)
 
 static void rtw_coex_set_gnt_bt(struct rtw_dev *rtwdev, u8 state)
 {
-	rtw_coex_write_indirect_reg(rtwdev, 0x38, 0xc000, state);
-	rtw_coex_write_indirect_reg(rtwdev, 0x38, 0x0c00, state);
+	rtw_coex_write_indirect_reg(rtwdev, LTE_COEX_CTRL, 0xc000, state);
+	rtw_coex_write_indirect_reg(rtwdev, LTE_COEX_CTRL, 0x0c00, state);
 }
 
 static void rtw_coex_set_gnt_wl(struct rtw_dev *rtwdev, u8 state)
 {
-	rtw_coex_write_indirect_reg(rtwdev, 0x38, 0x3000, state);
-	rtw_coex_write_indirect_reg(rtwdev, 0x38, 0x0300, state);
+	rtw_coex_write_indirect_reg(rtwdev, LTE_COEX_CTRL, 0x3000, state);
+	rtw_coex_write_indirect_reg(rtwdev, LTE_COEX_CTRL, 0x0300, state);
 }
 
 static void rtw_coex_set_table(struct rtw_dev *rtwdev, u32 table0, u32 table1)
@@ -2894,14 +2894,16 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 
 	score_board_BW = rtw_coex_read_scbd(rtwdev);
 	score_board_WB = coex_stat->score_board;
-	wl_reg_6c0 = rtw_read32(rtwdev, 0x6c0);
-	wl_reg_6c4 = rtw_read32(rtwdev, 0x6c4);
-	wl_reg_6c8 = rtw_read32(rtwdev, 0x6c8);
-	wl_reg_6cc = rtw_read32(rtwdev, 0x6cc);
-	wl_reg_778 = rtw_read32(rtwdev, 0x778);
-	bt_hi_pri = rtw_read32(rtwdev, 0x770);
-	bt_lo_pri = rtw_read32(rtwdev, 0x774);
-	rtw_write8(rtwdev, 0x76e, 0xc);
+	wl_reg_6c0 = rtw_read32(rtwdev, REG_BT_COEX_TABLE0);
+	wl_reg_6c4 = rtw_read32(rtwdev, REG_BT_COEX_TABLE1);
+	wl_reg_6c8 = rtw_read32(rtwdev, REG_BT_COEX_BRK_TABLE);
+	wl_reg_6cc = rtw_read32(rtwdev, REG_BT_COEX_TABLE_H);
+	wl_reg_778 = rtw_read8(rtwdev, REG_BT_STAT_CTRL);
+
+	bt_hi_pri = rtw_read32(rtwdev, REG_BT_ACT_STATISTICS);
+	bt_lo_pri = rtw_read32(rtwdev, REG_BT_ACT_STATISTICS_1);
+	rtw_write8(rtwdev, REG_BT_COEX_ENH_INTR_CTRL,
+		   BIT_R_GRANTALL_WLMASK | BIT_STATIS_BT_EN);
 	sys_lte = rtw_read8(rtwdev, 0x73);
 	lte_coex = rtw_coex_read_indirect_reg(rtwdev, 0x38);
 	bt_coex = rtw_coex_read_indirect_reg(rtwdev, 0x54);
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index b3df09ff01b3..2a4275f3d851 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -466,6 +466,11 @@
 #define REG_BT_COEX_V2		0x0762
 #define BIT_GNT_BT_POLARITY	BIT(12)
 #define BIT_LTE_COEX_EN		BIT(7)
+#define REG_BT_COEX_ENH_INTR_CTRL	0x76E
+#define BIT_R_GRANTALL_WLMASK	BIT(3)
+#define BIT_STATIS_BT_EN	BIT(2)
+#define REG_BT_ACT_STATISTICS	0x0770
+#define REG_BT_ACT_STATISTICS_1	0x0774
 #define REG_BT_STAT_CTRL	0x0778
 #define REG_BT_TDMA_TIME	0x0790
 #define BIT_MASK_SAMPLE_RATE	GENMASK(5, 0)
@@ -619,6 +624,9 @@
 #define REG_ANAPAR	0x1c30
 #define BIT_ANAPAR_BTPS	BIT(22)
 #define REG_RSTB_SEL	0x1c38
+#define BIT_DAC_OFF_ENABLE	BIT(4)
+#define BIT_PI_IGNORE_GNT_BT	BIT(3)
+#define BIT_NOMASK_TXBT_ENABLE	BIT(3)
 
 #define REG_HRCV_MSG	0x1cf
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index fe8a94abc76d..280a3ef98026 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2153,7 +2153,7 @@ static void rtw8822c_coex_cfg_init(struct rtw_dev *rtwdev)
 	rtw_write8_clr(rtwdev, REG_DUMMY_PAGE4_V1, BIT_BTCCA_CTRL);
 
 	/* to avoid RF parameter error */
-	rtw_write_rf(rtwdev, RF_PATH_B, 0x1, 0xfffff, 0x40000);
+	rtw_write_rf(rtwdev, RF_PATH_B, RF_MODOPT, 0xfffff, 0x40000);
 }
 
 static void rtw8822c_coex_cfg_gnt_fix(struct rtw_dev *rtwdev)
@@ -2190,10 +2190,10 @@ static void rtw8822c_coex_cfg_gnt_fix(struct rtw_dev *rtwdev)
 	 * disable WL-S1 BB chage RF mode if GNT_BT
 	 * since RF TRx mask can do it
 	 */
-	rtw_write8_mask(rtwdev, 0x1c32, BIT(6), 1);
-	rtw_write8_mask(rtwdev, 0x1c39, BIT(4), 0);
-	rtw_write8_mask(rtwdev, 0x1c3b, BIT(4), 1);
-	rtw_write8_mask(rtwdev, 0x4160, BIT(3), 1);
+	rtw_write8_mask(rtwdev, REG_ANAPAR + 2, BIT_ANAPAR_BTPS >> 16, 1);
+	rtw_write8_mask(rtwdev, REG_RSTB_SEL + 1, BIT_DAC_OFF_ENABLE, 0);
+	rtw_write8_mask(rtwdev, REG_RSTB_SEL + 3, BIT_DAC_OFF_ENABLE, 1);
+	rtw_write8_mask(rtwdev, REG_IGN_GNTBT4, BIT_PI_IGNORE_GNT_BT, 1);
 
 	/* disable WL-S0 BB chage RF mode if wifi is at 5G,
 	 * or antenna path is separated
@@ -2201,26 +2201,32 @@ static void rtw8822c_coex_cfg_gnt_fix(struct rtw_dev *rtwdev)
 	if (coex_stat->wl_coex_mode == COEX_WLINK_5G ||
 	    coex->under_5g || !efuse->share_ant) {
 		if (coex_stat->kt_ver >= 3) {
-			rtw_write8_mask(rtwdev, 0x1860, BIT(3), 0);
-			rtw_write8_mask(rtwdev, 0x1ca7, BIT(3), 1);
+			rtw_write8_mask(rtwdev, REG_IGN_GNT_BT1,
+					BIT_PI_IGNORE_GNT_BT, 0);
+			rtw_write8_mask(rtwdev, REG_NOMASK_TXBT,
+					BIT_NOMASK_TXBT_ENABLE, 1);
 		} else {
-			rtw_write8_mask(rtwdev, 0x1860, BIT(3), 1);
+			rtw_write8_mask(rtwdev, REG_IGN_GNT_BT1,
+					BIT_PI_IGNORE_GNT_BT, 1);
 		}
 	} else {
 		/* shared-antenna */
-		rtw_write8_mask(rtwdev, 0x1860, BIT(3), 0);
-		if (coex_stat->kt_ver >= 3)
-			rtw_write8_mask(rtwdev, 0x1ca7, BIT(3), 0);
+		rtw_write8_mask(rtwdev, REG_IGN_GNT_BT1,
+				BIT_PI_IGNORE_GNT_BT, 0);
+		if (coex_stat->kt_ver >= 3) {
+			rtw_write8_mask(rtwdev, REG_NOMASK_TXBT,
+					BIT_NOMASK_TXBT_ENABLE, 0);
+		}
 	}
 }
 
 static void rtw8822c_coex_cfg_gnt_debug(struct rtw_dev *rtwdev)
 {
-	rtw_write8_mask(rtwdev, 0x66, BIT(4), 0);
-	rtw_write8_mask(rtwdev, 0x67, BIT(0), 0);
-	rtw_write8_mask(rtwdev, 0x42, BIT(3), 0);
-	rtw_write8_mask(rtwdev, 0x65, BIT(7), 0);
-	rtw_write8_mask(rtwdev, 0x73, BIT(3), 0);
+	rtw_write8_mask(rtwdev, REG_PAD_CTRL1 + 2, BIT_BTGP_SPI_EN >> 16, 0);
+	rtw_write8_mask(rtwdev, REG_PAD_CTRL1 + 3, BIT_BTGP_JTAG_EN >> 24, 0);
+	rtw_write8_mask(rtwdev, REG_GPIO_MUXCFG + 2, BIT_FSPI_EN >> 16, 0);
+	rtw_write8_mask(rtwdev, REG_PAD_CTRL1 + 1, BIT_LED1DIS >> 8, 0);
+	rtw_write8_mask(rtwdev, REG_SYS_SDIO_CTRL + 3, BIT_DBG_GNT_WL_BT >> 24, 0);
 }
 
 static void rtw8822c_coex_cfg_rfe_type(struct rtw_dev *rtwdev)
@@ -2241,9 +2247,9 @@ static void rtw8822c_coex_cfg_rfe_type(struct rtw_dev *rtwdev)
 		coex_rfe->wlg_at_btg = false;
 
 	/* disable LTE coex in wifi side */
-	rtw_coex_write_indirect_reg(rtwdev, 0x38, BIT_LTE_COEX_EN, 0x0);
-	rtw_coex_write_indirect_reg(rtwdev, 0xa0, MASKLWORD, 0xffff);
-	rtw_coex_write_indirect_reg(rtwdev, 0xa4, MASKLWORD, 0xffff);
+	rtw_coex_write_indirect_reg(rtwdev, LTE_COEX_CTRL, BIT_LTE_COEX_EN, 0x0);
+	rtw_coex_write_indirect_reg(rtwdev, LTE_WL_TRX_CTRL, MASKLWORD, 0xffff);
+	rtw_coex_write_indirect_reg(rtwdev, LTE_BT_TRX_CTRL, MASKLWORD, 0xffff);
 }
 
 static void rtw8822c_coex_cfg_wl_tx_power(struct rtw_dev *rtwdev, u8 wl_pwr)
@@ -2269,15 +2275,17 @@ static void rtw8822c_coex_cfg_wl_rx_gain(struct rtw_dev *rtwdev, bool low_gain)
 
 	if (coex_dm->cur_wl_rx_low_gain_en) {
 		/* set Rx filter corner RCK offset */
-		rtw_write_rf(rtwdev, RF_PATH_A, 0xde, 0xfffff, 0x22);
-		rtw_write_rf(rtwdev, RF_PATH_A, 0x1d, 0xfffff, 0x36);
-		rtw_write_rf(rtwdev, RF_PATH_B, 0xde, 0xfffff, 0x22);
-		rtw_write_rf(rtwdev, RF_PATH_B, 0x1d, 0xfffff, 0x36);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_RCKD, RFREG_MASK, 0x22);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_RCK, RFREG_MASK, 0x36);
+		rtw_write_rf(rtwdev, RF_PATH_B, RF_RCKD, RFREG_MASK, 0x22);
+		rtw_write_rf(rtwdev, RF_PATH_B, RF_RCK, RFREG_MASK, 0x36);
+
 	} else {
 		/* set Rx filter corner RCK offset */
-		rtw_write_rf(rtwdev, RF_PATH_A, 0xde, 0xfffff, 0x20);
-		rtw_write_rf(rtwdev, RF_PATH_A, 0x1d, 0xfffff, 0x0);
-		rtw_write_rf(rtwdev, RF_PATH_B, 0x1d, 0xfffff, 0x0);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_RCKD, RFREG_MASK, 0x20);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_RCK, RFREG_MASK, 0x0);
+		rtw_write_rf(rtwdev, RF_PATH_B, RF_RCKD, RFREG_MASK, 0x20);
+		rtw_write_rf(rtwdev, RF_PATH_B, RF_RCK, RFREG_MASK, 0x0);
 	}
 }
 
-- 
2.21.0

