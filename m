Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015C61CF24F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 12:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgELK1N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 06:27:13 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36519 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgELK0i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 06:26:38 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04CAQOYe8009505, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04CAQOYe8009505
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 May 2020 18:26:24 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 12 May 2020 18:26:24 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 12 May 2020 18:26:23 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v3 2/9] rtw88: 8723d: add IQ calibration
Date:   Tue, 12 May 2020 18:26:14 +0800
Message-ID: <20200512102621.5148-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512102621.5148-1-yhchuang@realtek.com>
References: <20200512102621.5148-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

IQ calibration is used to calibrate RF characteristic to yield expected
performance. Basically, we do calibration twice and compare the similarity
to determine calibration is good or not, if not we do the third
calibration, and then compare with the results of first and second
calibration. If it still not similar, IQK is failed.

Before doing calibration, we need to backup registers that will be
modified in calibration procedure, and restore these registers after
calibration is done.

A calibration procedure can divided into four sub-procedures that are
S1-TX, S1-RX, S0-TX and S0-RX. Where, S1 and S0 represent to path A and B
respectively. Each sub-procedure configure proper registers, and then
rigger one-shot calibration and poll until completion. For RX calibration,
it needs to do twice one-shot calibration, first one is to yield parameter
used by second one.

The result of TX part is stored for TX power tracking that adjusts TX AGC
to output expected power.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     |  12 +
 drivers/net/wireless/realtek/rtw88/phy.c      |   2 +
 drivers/net/wireless/realtek/rtw88/reg.h      |  10 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 817 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h | 122 +++
 5 files changed, 963 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index c5046986f9af..af8c50e3687d 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1400,6 +1400,16 @@ struct rtw_pkt_count {
 DECLARE_EWMA(evm, 10, 4);
 DECLARE_EWMA(snr, 10, 4);
 
+struct rtw_iqk_info {
+	bool done;
+	struct {
+		u32 s1_x;
+		u32 s1_y;
+		u32 s0_x;
+		u32 s0_y;
+	} result;
+};
+
 struct rtw_dm_info {
 	u32 cck_fa_cnt;
 	u32 ofdm_fa_cnt;
@@ -1459,6 +1469,8 @@ struct rtw_dm_info {
 	struct rtw_pkt_count last_pkt_count;
 	struct ewma_evm ewma_evm[RTW_EVM_NUM];
 	struct ewma_snr ewma_snr[RTW_SNR_NUM];
+
+	struct rtw_iqk_info iqk;
 };
 
 struct rtw_efuse {
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 72a16eff9db3..837b7bd04126 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -134,6 +134,8 @@ void rtw_phy_init(struct rtw_dev *rtwdev)
 	mask = chip->dig[0].mask;
 	dm_info->igi_history[0] = rtw_read32_mask(rtwdev, addr, mask);
 	rtw_phy_cck_pd_init(rtwdev);
+
+	dm_info->iqk.done = false;
 }
 
 void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi)
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 9fdfcdc5c5cf..d57de1a6cdcc 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -69,6 +69,7 @@
 #define BIT_DPDT_SEL_EN		BIT(23)
 #define REG_LEDCFG2		0x004E
 #define REG_PAD_CTRL1		0x0064
+#define BIT_BT_BTG_SEL		BIT(31)
 #define BIT_PAPE_WLBT_SEL	BIT(29)
 #define BIT_LNAON_WLBT_SEL	BIT(28)
 #define BIT_BTGP_JTAG_EN	BIT(24)
@@ -611,7 +612,10 @@
 
 #define REG_IGN_GNTBT4	0x4160
 
+#define RF_MODE		0x00
 #define RF_MODOPT	0x01
+#define RF_WLINT	0x01
+#define RF_WLSEL	0x02
 #define RF_DTXLOK	0x08
 #define RF_CFGCH	0x18
 #define RF_RCK		0x1d
@@ -619,9 +623,15 @@
 #define RF_LUTWD1	0x3e
 #define RF_LUTWD0	0x3f
 #define RF_T_METER	0x42
+#define RF_BSPAD	0x54
+#define RF_GAINTX	0x56
+#define RF_TXATANK	0x64
+#define RF_TRXIQ	0x66
+#define RF_RXIQGEN	0x8d
 #define RF_XTALX2	0xb8
 #define RF_MALSEL	0xbe
 #define RF_RCKD		0xde
+#define RF_TXADBG	0xde
 #define RF_LUTDBG	0xdf
 #define RF_LUTWE2	0xee
 #define RF_LUTWE	0xef
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 0f5ddd41b019..0cfa493e7742 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -634,6 +634,822 @@ static void rtw8723d_false_alarm_statistics(struct rtw_dev *rtwdev)
 	rtw_write32_mask(rtwdev, REG_PAGE_F_RST_11N, BIT_MASK_F_RST_ALL, 0);
 }
 
+static const u32 iqk_adda_regs[] = {
+	0x85c, 0xe6c, 0xe70, 0xe74, 0xe78, 0xe7c, 0xe80, 0xe84, 0xe88, 0xe8c,
+	0xed0, 0xed4, 0xed8, 0xedc, 0xee0, 0xeec
+};
+
+static const u32 iqk_mac8_regs[] = {0x522, 0x550, 0x551};
+static const u32 iqk_mac32_regs[] = {0x40};
+
+static const u32 iqk_bb_regs[] = {
+	0xc04, 0xc08, 0x874, 0xb68, 0xb6c, 0x870, 0x860, 0x864, 0xa04
+};
+
+#define IQK_ADDA_REG_NUM	ARRAY_SIZE(iqk_adda_regs)
+#define IQK_MAC8_REG_NUM	ARRAY_SIZE(iqk_mac8_regs)
+#define IQK_MAC32_REG_NUM	ARRAY_SIZE(iqk_mac32_regs)
+#define IQK_BB_REG_NUM		ARRAY_SIZE(iqk_bb_regs)
+
+struct iqk_backup_regs {
+	u32 adda[IQK_ADDA_REG_NUM];
+	u8 mac8[IQK_MAC8_REG_NUM];
+	u32 mac32[IQK_MAC32_REG_NUM];
+	u32 bb[IQK_BB_REG_NUM];
+
+	u32 lte_path;
+	u32 lte_gnt;
+
+	u32 bb_sel_btg;
+	u8 btg_sel;
+
+	u8 igia;
+	u8 igib;
+};
+
+static void rtw8723d_iqk_backup_regs(struct rtw_dev *rtwdev,
+				     struct iqk_backup_regs *backup)
+{
+	int i;
+
+	for (i = 0; i < IQK_ADDA_REG_NUM; i++)
+		backup->adda[i] = rtw_read32(rtwdev, iqk_adda_regs[i]);
+
+	for (i = 0; i < IQK_MAC8_REG_NUM; i++)
+		backup->mac8[i] = rtw_read8(rtwdev, iqk_mac8_regs[i]);
+	for (i = 0; i < IQK_MAC32_REG_NUM; i++)
+		backup->mac32[i] = rtw_read32(rtwdev, iqk_mac32_regs[i]);
+
+	for (i = 0; i < IQK_BB_REG_NUM; i++)
+		backup->bb[i] = rtw_read32(rtwdev, iqk_bb_regs[i]);
+
+	backup->igia = rtw_read32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0);
+	backup->igib = rtw_read32_mask(rtwdev, REG_OFDM0_XBAGC1, MASKBYTE0);
+
+	backup->bb_sel_btg = rtw_read32(rtwdev, REG_BB_SEL_BTG);
+}
+
+static void rtw8723d_iqk_restore_regs(struct rtw_dev *rtwdev,
+				      const struct iqk_backup_regs *backup)
+{
+	int i;
+
+	for (i = 0; i < IQK_ADDA_REG_NUM; i++)
+		rtw_write32(rtwdev, iqk_adda_regs[i], backup->adda[i]);
+
+	for (i = 0; i < IQK_MAC8_REG_NUM; i++)
+		rtw_write8(rtwdev, iqk_mac8_regs[i], backup->mac8[i]);
+	for (i = 0; i < IQK_MAC32_REG_NUM; i++)
+		rtw_write32(rtwdev, iqk_mac32_regs[i], backup->mac32[i]);
+
+	for (i = 0; i < IQK_BB_REG_NUM; i++)
+		rtw_write32(rtwdev, iqk_bb_regs[i], backup->bb[i]);
+
+	rtw_write32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0, 0x50);
+	rtw_write32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0, backup->igia);
+
+	rtw_write32_mask(rtwdev, REG_OFDM0_XBAGC1, MASKBYTE0, 0x50);
+	rtw_write32_mask(rtwdev, REG_OFDM0_XBAGC1, MASKBYTE0, backup->igib);
+
+	rtw_write32(rtwdev, REG_TXIQK_TONE_A_11N, 0x01008c00);
+	rtw_write32(rtwdev, REG_RXIQK_TONE_A_11N, 0x01008c00);
+}
+
+static void rtw8723d_iqk_backup_path_ctrl(struct rtw_dev *rtwdev,
+					  struct iqk_backup_regs *backup)
+{
+	backup->btg_sel = rtw_read8(rtwdev, REG_BTG_SEL);
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] original 0x67 = 0x%x\n",
+		backup->btg_sel);
+}
+
+static void rtw8723d_iqk_config_path_ctrl(struct rtw_dev *rtwdev)
+{
+	rtw_write32_mask(rtwdev, REG_PAD_CTRL1, BIT_BT_BTG_SEL, 0x1);
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] set 0x67 = 0x%x\n",
+		rtw_read32_mask(rtwdev, REG_PAD_CTRL1, MASKBYTE3));
+}
+
+static void rtw8723d_iqk_restore_path_ctrl(struct rtw_dev *rtwdev,
+					   const struct iqk_backup_regs *backup)
+{
+	rtw_write8(rtwdev, REG_BTG_SEL, backup->btg_sel);
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] restore 0x67 = 0x%x\n",
+		rtw_read32_mask(rtwdev, REG_PAD_CTRL1, MASKBYTE3));
+}
+
+static void rtw8723d_iqk_backup_lte_path_gnt(struct rtw_dev *rtwdev,
+					     struct iqk_backup_regs *backup)
+{
+	backup->lte_path = rtw_read32(rtwdev, REG_LTECOEX_PATH_CONTROL);
+	rtw_write32(rtwdev, REG_LTECOEX_CTRL, 0x800f0038);
+	mdelay(1);
+	backup->lte_gnt = rtw_read32(rtwdev, REG_LTECOEX_READ_DATA);
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] OriginalGNT = 0x%x\n",
+		backup->lte_gnt);
+}
+
+static void rtw8723d_iqk_config_lte_path_gnt(struct rtw_dev *rtwdev)
+{
+	rtw_write32(rtwdev, REG_LTECOEX_WRITE_DATA, 0x0000ff00);
+	rtw_write32(rtwdev, REG_LTECOEX_CTRL, 0xc0020038);
+	rtw_write32_mask(rtwdev, REG_LTECOEX_PATH_CONTROL, BIT_LTE_MUX_CTRL_PATH, 0x1);
+}
+
+static void rtw8723d_iqk_restore_lte_path_gnt(struct rtw_dev *rtwdev,
+					      const struct iqk_backup_regs *bak)
+{
+	rtw_write32(rtwdev, REG_LTECOEX_WRITE_DATA, bak->lte_gnt);
+	rtw_write32(rtwdev, REG_LTECOEX_CTRL, 0xc00f0038);
+	rtw_write32(rtwdev, REG_LTECOEX_PATH_CONTROL, bak->lte_path);
+}
+
+struct rtw_8723d_iqk_cfg {
+	const char *name;
+	u32 val_bb_sel_btg;
+	u32 reg_lutwe;
+	u32 val_txiqk_pi;
+	u32 reg_padlut;
+	u32 reg_gaintx;
+	u32 reg_bspad;
+	u32 val_wlint;
+	u32 val_wlsel;
+	u32 val_iqkpts;
+};
+
+static const struct rtw_8723d_iqk_cfg iqk_tx_cfg[PATH_NR] = {
+	[PATH_S1] = {
+		.name = "S1",
+		.val_bb_sel_btg = 0x99000000,
+		.reg_lutwe = RF_LUTWE,
+		.val_txiqk_pi = 0x8214019f,
+		.reg_padlut = RF_LUTDBG,
+		.reg_gaintx = RF_GAINTX,
+		.reg_bspad = RF_BSPAD,
+		.val_wlint = 0xe0d,
+		.val_wlsel = 0x60d,
+		.val_iqkpts = 0xfa000000,
+	},
+	[PATH_S0] = {
+		.name = "S0",
+		.val_bb_sel_btg = 0x99000280,
+		.reg_lutwe = RF_LUTWE2,
+		.val_txiqk_pi = 0x8214018a,
+		.reg_padlut = RF_TXADBG,
+		.reg_gaintx = RF_TRXIQ,
+		.reg_bspad = RF_TXATANK,
+		.val_wlint = 0xe6d,
+		.val_wlsel = 0x66d,
+		.val_iqkpts = 0xf9000000,
+	},
+};
+
+static u8 rtw8723d_iqk_check_tx_failed(struct rtw_dev *rtwdev,
+				       const struct rtw_8723d_iqk_cfg *iqk_cfg)
+{
+	s32 tx_x, tx_y;
+	u32 tx_fail;
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] 0xeac = 0x%x\n",
+		rtw_read32(rtwdev, REG_IQK_RES_RY));
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] 0xe94 = 0x%x, 0xe9c = 0x%x\n",
+		rtw_read32(rtwdev, REG_IQK_RES_TX),
+		rtw_read32(rtwdev, REG_IQK_RES_TY));
+	rtw_dbg(rtwdev, RTW_DBG_RFK,
+		"[IQK] 0xe90(before IQK)= 0x%x, 0xe98(afer IQK) = 0x%x\n",
+		rtw_read32(rtwdev, 0xe90),
+		rtw_read32(rtwdev, 0xe98));
+
+	tx_fail = rtw_read32_mask(rtwdev, REG_IQK_RES_RY, BIT_IQK_TX_FAIL);
+	tx_x = rtw_read32_mask(rtwdev, REG_IQK_RES_TX, BIT_MASK_RES_TX);
+	tx_y = rtw_read32_mask(rtwdev, REG_IQK_RES_TY, BIT_MASK_RES_TY);
+
+	if (!tx_fail && tx_x != IQK_TX_X_ERR && tx_y != IQK_TX_Y_ERR)
+		return IQK_TX_OK;
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] %s TXIQK is failed\n",
+		iqk_cfg->name);
+
+	return 0;
+}
+
+static u8 rtw8723d_iqk_check_rx_failed(struct rtw_dev *rtwdev,
+				       const struct rtw_8723d_iqk_cfg *iqk_cfg)
+{
+	s32 rx_x, rx_y;
+	u32 rx_fail;
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] 0xea4 = 0x%x, 0xeac = 0x%x\n",
+		rtw_read32(rtwdev, REG_IQK_RES_RX),
+		rtw_read32(rtwdev, REG_IQK_RES_RY));
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK,
+		"[IQK] 0xea0(before IQK)= 0x%x, 0xea8(afer IQK) = 0x%x\n",
+		rtw_read32(rtwdev, 0xea0),
+		rtw_read32(rtwdev, 0xea8));
+
+	rx_fail = rtw_read32_mask(rtwdev, REG_IQK_RES_RY, BIT_IQK_RX_FAIL);
+	rx_x = rtw_read32_mask(rtwdev, REG_IQK_RES_RX, BIT_MASK_RES_RX);
+	rx_y = rtw_read32_mask(rtwdev, REG_IQK_RES_RY, BIT_MASK_RES_RY);
+	rx_y = abs(iqkxy_to_s32(rx_y));
+
+	if (!rx_fail && rx_x < IQK_RX_X_UPPER && rx_x > IQK_RX_X_LOWER &&
+	    rx_y < IQK_RX_Y_LMT)
+		return IQK_RX_OK;
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] %s RXIQK STEP2 is failed\n",
+		iqk_cfg->name);
+
+	return 0;
+}
+
+static void rtw8723d_iqk_one_shot(struct rtw_dev *rtwdev, bool tx,
+				  const struct rtw_8723d_iqk_cfg *iqk_cfg)
+{
+	u32 pts = (tx ? iqk_cfg->val_iqkpts : 0xf9000000);
+
+	/* enter IQK mode */
+	rtw_write32_mask(rtwdev, REG_FPGA0_IQK_11N, BIT_MASK_IQK_MOD, EN_IQK);
+	rtw8723d_iqk_config_lte_path_gnt(rtwdev);
+
+	rtw_write32(rtwdev, REG_LTECOEX_CTRL, 0x800f0054);
+	mdelay(1);
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] GNT_BT @%s %sIQK1 = 0x%x\n",
+		iqk_cfg->name, tx ? "TX" : "RX",
+		rtw_read32(rtwdev, REG_LTECOEX_READ_DATA));
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] 0x948 @%s %sIQK1 = 0x%x\n",
+		iqk_cfg->name, tx ? "TX" : "RX",
+		rtw_read32(rtwdev, REG_BB_SEL_BTG));
+
+	/* One shot, LOK & IQK */
+	rtw_write32(rtwdev, REG_IQK_AGC_PTS_11N, pts);
+	rtw_write32(rtwdev, REG_IQK_AGC_PTS_11N, 0xf8000000);
+
+	if (!check_hw_ready(rtwdev, REG_IQK_RES_RY, BIT_IQK_DONE, 1))
+		rtw_warn(rtwdev, "%s %s IQK isn't done\n", iqk_cfg->name,
+			 tx ? "TX" : "RX");
+}
+
+static void rtw8723d_iqk_txrx_path_post(struct rtw_dev *rtwdev,
+					const struct rtw_8723d_iqk_cfg *iqk_cfg,
+					const struct iqk_backup_regs *backup)
+{
+	rtw8723d_iqk_restore_lte_path_gnt(rtwdev, backup);
+	rtw_write32(rtwdev, REG_BB_SEL_BTG, backup->bb_sel_btg);
+
+	/* leave IQK mode */
+	rtw_write32_mask(rtwdev, REG_FPGA0_IQK_11N, BIT_MASK_IQK_MOD, RST_IQK);
+	mdelay(1);
+	rtw_write_rf(rtwdev, RF_PATH_A, iqk_cfg->reg_padlut, 0x800, 0x0);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_WLINT, BIT(0), 0x0);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_WLSEL, BIT(0), 0x0);
+}
+
+static u8 rtw8723d_iqk_tx_path(struct rtw_dev *rtwdev,
+			       const struct rtw_8723d_iqk_cfg *iqk_cfg,
+			       const struct iqk_backup_regs *backup)
+{
+	u8 status;
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] path %s TXIQK!!\n", iqk_cfg->name);
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] 0x67 @%s TXIQK = 0x%x\n",
+		iqk_cfg->name,
+		rtw_read32_mask(rtwdev, REG_PAD_CTRL1, MASKBYTE3));
+
+	rtw_write32(rtwdev, REG_BB_SEL_BTG, iqk_cfg->val_bb_sel_btg);
+	rtw_write32_mask(rtwdev, REG_FPGA0_IQK_11N, BIT_MASK_IQK_MOD, RST_IQK);
+	mdelay(1);
+	rtw_write_rf(rtwdev, RF_PATH_A, iqk_cfg->reg_lutwe, RFREG_MASK, 0x80000);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, RFREG_MASK, 0x00004);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD1, RFREG_MASK, 0x0005d);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, RFREG_MASK, 0xBFFE0);
+	rtw_write_rf(rtwdev, RF_PATH_A, iqk_cfg->reg_lutwe, RFREG_MASK, 0x00000);
+
+	/* IQK setting */
+	rtw_write32(rtwdev, REG_TXIQK_TONE_A_11N, 0x08008c0c);
+	rtw_write32(rtwdev, REG_RXIQK_TONE_A_11N, 0x38008c1c);
+	rtw_write32(rtwdev, REG_TXIQK_PI_A_11N, iqk_cfg->val_txiqk_pi);
+	rtw_write32(rtwdev, REG_RXIQK_PI_A_11N, 0x28160200);
+	rtw_write32(rtwdev, REG_TXIQK_11N, 0x01007c00);
+	rtw_write32(rtwdev, REG_RXIQK_11N, 0x01004800);
+
+	/* LOK setting */
+	rtw_write32(rtwdev, REG_IQK_AGC_RSP_11N, 0x00462911);
+
+	/* PA, PAD setting */
+	rtw_write_rf(rtwdev, RF_PATH_A, iqk_cfg->reg_padlut, 0x800, 0x1);
+	rtw_write_rf(rtwdev, RF_PATH_A, iqk_cfg->reg_gaintx, 0x600, 0x0);
+	rtw_write_rf(rtwdev, RF_PATH_A, iqk_cfg->reg_gaintx, 0x1E0, 0x3);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_RXIQGEN, 0x1F, 0xf);
+
+	/* LOK setting for 8723D */
+	rtw_write_rf(rtwdev, RF_PATH_A, iqk_cfg->reg_lutwe, 0x10, 0x1);
+	rtw_write_rf(rtwdev, RF_PATH_A, iqk_cfg->reg_bspad, 0x1, 0x1);
+
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_WLINT, RFREG_MASK, iqk_cfg->val_wlint);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_WLSEL, RFREG_MASK, iqk_cfg->val_wlsel);
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] RF0x1 @%s TXIQK = 0x%x\n",
+		iqk_cfg->name,
+		rtw_read_rf(rtwdev, RF_PATH_A, RF_WLINT, RFREG_MASK));
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] RF0x2 @%s TXIQK = 0x%x\n",
+		iqk_cfg->name,
+		rtw_read_rf(rtwdev, RF_PATH_A, RF_WLSEL, RFREG_MASK));
+
+	rtw8723d_iqk_one_shot(rtwdev, true, iqk_cfg);
+	status = rtw8723d_iqk_check_tx_failed(rtwdev, iqk_cfg);
+
+	rtw8723d_iqk_txrx_path_post(rtwdev, iqk_cfg, backup);
+
+	return status;
+}
+
+static u8 rtw8723d_iqk_rx_path(struct rtw_dev *rtwdev,
+			       const struct rtw_8723d_iqk_cfg *iqk_cfg,
+			       const struct iqk_backup_regs *backup)
+{
+	u32 tx_x, tx_y;
+	u8 status;
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] path %s RXIQK Step1!!\n",
+		iqk_cfg->name);
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] 0x67 @%s RXIQK1 = 0x%x\n",
+		iqk_cfg->name,
+		rtw_read32_mask(rtwdev, REG_PAD_CTRL1, MASKBYTE3));
+	rtw_write32(rtwdev, REG_BB_SEL_BTG, iqk_cfg->val_bb_sel_btg);
+
+	rtw_write32_mask(rtwdev, REG_FPGA0_IQK_11N, BIT_MASK_IQK_MOD, RST_IQK);
+
+	/* IQK setting */
+	rtw_write32(rtwdev, REG_TXIQK_11N, 0x01007c00);
+	rtw_write32(rtwdev, REG_RXIQK_11N, 0x01004800);
+
+	/* path IQK setting */
+	rtw_write32(rtwdev, REG_TXIQK_TONE_A_11N, 0x18008c1c);
+	rtw_write32(rtwdev, REG_RXIQK_TONE_A_11N, 0x38008c1c);
+	rtw_write32(rtwdev, REG_TX_IQK_TONE_B, 0x38008c1c);
+	rtw_write32(rtwdev, REG_RX_IQK_TONE_B, 0x38008c1c);
+	rtw_write32(rtwdev, REG_TXIQK_PI_A_11N, 0x82160000);
+	rtw_write32(rtwdev, REG_RXIQK_PI_A_11N, 0x28160000);
+
+	/* LOK setting */
+	rtw_write32(rtwdev, REG_IQK_AGC_RSP_11N, 0x0046a911);
+
+	/* RXIQK mode */
+	rtw_write_rf(rtwdev, RF_PATH_A, iqk_cfg->reg_lutwe, RFREG_MASK, 0x80000);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, RFREG_MASK, 0x00006);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD1, RFREG_MASK, 0x0005f);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, RFREG_MASK, 0xa7ffb);
+	rtw_write_rf(rtwdev, RF_PATH_A, iqk_cfg->reg_lutwe, RFREG_MASK, 0x00000);
+
+	/* PA/PAD=0 */
+	rtw_write_rf(rtwdev, RF_PATH_A, iqk_cfg->reg_padlut, 0x800, 0x1);
+	rtw_write_rf(rtwdev, RF_PATH_A, iqk_cfg->reg_gaintx, 0x600, 0x0);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_WLINT, RFREG_MASK, iqk_cfg->val_wlint);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_WLSEL, RFREG_MASK, iqk_cfg->val_wlsel);
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] RF0x1@ path %s RXIQK1 = 0x%x\n",
+		iqk_cfg->name,
+		rtw_read_rf(rtwdev, RF_PATH_A, RF_WLINT, RFREG_MASK));
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] RF0x2@ path %s RXIQK1 = 0x%x\n",
+		iqk_cfg->name,
+		rtw_read_rf(rtwdev, RF_PATH_A, RF_WLSEL, RFREG_MASK));
+
+	rtw8723d_iqk_one_shot(rtwdev, false, iqk_cfg);
+	status = rtw8723d_iqk_check_tx_failed(rtwdev, iqk_cfg);
+
+	if (!status)
+		goto restore;
+
+	/* second round */
+	tx_x = rtw_read32_mask(rtwdev, REG_IQK_RES_TX, BIT_MASK_RES_TX);
+	tx_y = rtw_read32_mask(rtwdev, REG_IQK_RES_TY, BIT_MASK_RES_TY);
+
+	rtw_write32(rtwdev, REG_TXIQK_11N, BIT_SET_TXIQK_11N(tx_x, tx_y));
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] 0xe40 = 0x%x u4tmp = 0x%x\n",
+		rtw_read32(rtwdev, REG_TXIQK_11N),
+		BIT_SET_TXIQK_11N(tx_x, tx_y));
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] path %s RXIQK STEP2!!\n",
+		iqk_cfg->name);
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] 0x67 @%s RXIQK2 = 0x%x\n",
+		iqk_cfg->name,
+		rtw_read32_mask(rtwdev, REG_PAD_CTRL1, MASKBYTE3));
+
+	rtw_write32(rtwdev, REG_RXIQK_11N, 0x01004800);
+	rtw_write32(rtwdev, REG_TXIQK_TONE_A_11N, 0x38008c1c);
+	rtw_write32(rtwdev, REG_RXIQK_TONE_A_11N, 0x18008c1c);
+	rtw_write32(rtwdev, REG_TX_IQK_TONE_B, 0x38008c1c);
+	rtw_write32(rtwdev, REG_RX_IQK_TONE_B, 0x38008c1c);
+	rtw_write32(rtwdev, REG_TXIQK_PI_A_11N, 0x82170000);
+	rtw_write32(rtwdev, REG_RXIQK_PI_A_11N, 0x28171400);
+
+	/* LOK setting */
+	rtw_write32(rtwdev, REG_IQK_AGC_RSP_11N, 0x0046a8d1);
+
+	/* RXIQK mode */
+	rtw_write32_mask(rtwdev, REG_FPGA0_IQK_11N, BIT_MASK_IQK_MOD, RST_IQK);
+	mdelay(1);
+	rtw_write_rf(rtwdev, RF_PATH_A, iqk_cfg->reg_lutwe, 0x80000, 0x1);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, RFREG_MASK, 0x00007);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD1, RFREG_MASK, 0x0005f);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, RFREG_MASK, 0xb3fdb);
+	rtw_write_rf(rtwdev, RF_PATH_A, iqk_cfg->reg_lutwe, RFREG_MASK, 0x00000);
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] RF0x1 @%s RXIQK2 = 0x%x\n",
+		iqk_cfg->name,
+		rtw_read_rf(rtwdev, RF_PATH_A, RF_WLINT, RFREG_MASK));
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] RF0x2 @%s RXIQK2 = 0x%x\n",
+		iqk_cfg->name,
+		rtw_read_rf(rtwdev, RF_PATH_A, RF_WLSEL, RFREG_MASK));
+
+	rtw8723d_iqk_one_shot(rtwdev, false, iqk_cfg);
+	status |= rtw8723d_iqk_check_rx_failed(rtwdev, iqk_cfg);
+
+restore:
+	rtw8723d_iqk_txrx_path_post(rtwdev, iqk_cfg, backup);
+
+	return status;
+}
+
+static
+void rtw8723d_iqk_fill_s1_matrix(struct rtw_dev *rtwdev, const s32 result[])
+{
+	s32 oldval_1;
+	s32 x, y;
+	s32 tx1_a, tx1_a_ext;
+	s32 tx1_c, tx1_c_ext;
+
+	if (result[IQK_S1_TX_X] == 0)
+		return;
+
+	oldval_1 = rtw_read32_mask(rtwdev, REG_OFDM_0_XA_TX_IQ_IMBALANCE,
+				   BIT_MASK_TXIQ_ELM_D);
+
+	x = iqkxy_to_s32(result[IQK_S1_TX_X]);
+	tx1_a = iqk_mult(x, oldval_1, &tx1_a_ext);
+	rtw_write32_mask(rtwdev, REG_OFDM_0_XA_TX_IQ_IMBALANCE,
+			 BIT_MASK_TXIQ_ELM_A, tx1_a);
+	rtw_write32_mask(rtwdev, REG_OFDM_0_ECCA_THRESHOLD,
+			 BIT_MASK_OFDM0_EXT_A, tx1_a_ext);
+
+	y = iqkxy_to_s32(result[IQK_S1_TX_Y]);
+	tx1_c = iqk_mult(y, oldval_1, &tx1_c_ext);
+	rtw_write32_mask(rtwdev, REG_TXIQK_MATRIXA_LSB2_11N, MASKH4BITS,
+			 BIT_SET_TXIQ_ELM_C1(tx1_c));
+	rtw_write32_mask(rtwdev, REG_OFDM_0_XA_TX_IQ_IMBALANCE,
+			 BIT_MASK_TXIQ_ELM_C, BIT_SET_TXIQ_ELM_C2(tx1_c));
+	rtw_write32_mask(rtwdev, REG_OFDM_0_ECCA_THRESHOLD,
+			 BIT_MASK_OFDM0_EXT_C, tx1_c_ext);
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK,
+		"[IQK] X = 0x%x, TX1_A = 0x%x, oldval_1 0x%x\n",
+		x, tx1_a, oldval_1);
+	rtw_dbg(rtwdev, RTW_DBG_RFK,
+		"[IQK] Y = 0x%x, TX1_C = 0x%x\n", y, tx1_c);
+
+	if (result[IQK_S1_RX_X] == 0)
+		return;
+
+	rtw_write32_mask(rtwdev, REG_A_RXIQI, BIT_MASK_RXIQ_S1_X,
+			 result[IQK_S1_RX_X]);
+	rtw_write32_mask(rtwdev, REG_A_RXIQI, BIT_MASK_RXIQ_S1_Y1,
+			 BIT_SET_RXIQ_S1_Y1(result[IQK_S1_RX_Y]));
+	rtw_write32_mask(rtwdev, REG_RXIQK_MATRIX_LSB_11N, BIT_MASK_RXIQ_S1_Y2,
+			 BIT_SET_RXIQ_S1_Y2(result[IQK_S1_RX_Y]));
+}
+
+static
+void rtw8723d_iqk_fill_s0_matrix(struct rtw_dev *rtwdev, const s32 result[])
+{
+	s32 oldval_0;
+	s32 x, y;
+	s32 tx0_a, tx0_a_ext;
+	s32 tx0_c, tx0_c_ext;
+
+	if (result[IQK_S0_TX_X] == 0)
+		return;
+
+	oldval_0 = rtw_read32_mask(rtwdev, REG_TXIQ_CD_S0, BIT_MASK_TXIQ_D_S0);
+
+	x = iqkxy_to_s32(result[IQK_S0_TX_X]);
+	tx0_a = iqk_mult(x, oldval_0, &tx0_a_ext);
+
+	rtw_write32_mask(rtwdev, REG_TXIQ_AB_S0, BIT_MASK_TXIQ_A_S0, tx0_a);
+	rtw_write32_mask(rtwdev, REG_TXIQ_AB_S0, BIT_MASK_TXIQ_A_EXT_S0, tx0_a_ext);
+
+	y = iqkxy_to_s32(result[IQK_S0_TX_Y]);
+	tx0_c = iqk_mult(y, oldval_0, &tx0_c_ext);
+
+	rtw_write32_mask(rtwdev, REG_TXIQ_CD_S0, BIT_MASK_TXIQ_C_S0, tx0_c);
+	rtw_write32_mask(rtwdev, REG_TXIQ_CD_S0, BIT_MASK_TXIQ_C_EXT_S0, tx0_c_ext);
+
+	if (result[IQK_S0_RX_X] == 0)
+		return;
+
+	rtw_write32_mask(rtwdev, REG_RXIQ_AB_S0, BIT_MASK_RXIQ_X_S0,
+			 result[IQK_S0_RX_X]);
+	rtw_write32_mask(rtwdev, REG_RXIQ_AB_S0, BIT_MASK_RXIQ_Y_S0,
+			 result[IQK_S0_RX_Y]);
+}
+
+static void rtw8723d_iqk_path_adda_on(struct rtw_dev *rtwdev)
+{
+	int i;
+
+	for (i = 0; i < IQK_ADDA_REG_NUM; i++)
+		rtw_write32(rtwdev, iqk_adda_regs[i], 0x03c00016);
+}
+
+static void rtw8723d_iqk_config_mac(struct rtw_dev *rtwdev)
+{
+	rtw_write8(rtwdev, REG_TXPAUSE, 0xff);
+}
+
+static
+void rtw8723d_iqk_rf_standby(struct rtw_dev *rtwdev, enum rtw_rf_path path)
+{
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] path-%s standby mode!\n",
+		path == RF_PATH_A ? "S1" : "S0");
+
+	rtw_write32_mask(rtwdev, REG_FPGA0_IQK_11N, BIT_MASK_IQK_MOD, RST_IQK);
+	mdelay(1);
+	rtw_write_rf(rtwdev, path, RF_MODE, RFREG_MASK, 0x10000);
+	rtw_write32_mask(rtwdev, REG_FPGA0_IQK_11N, BIT_MASK_IQK_MOD, EN_IQK);
+}
+
+static
+bool rtw8723d_iqk_similarity_cmp(struct rtw_dev *rtwdev, s32 result[][IQK_NR],
+				 u8 c1, u8 c2)
+{
+	u32 i, j, diff;
+	u32 bitmap = 0;
+	u8 candidate[PATH_NR] = {IQK_ROUND_INVALID, IQK_ROUND_INVALID};
+	bool ret = true;
+
+	s32 tmp1, tmp2;
+
+	for (i = 0; i < IQK_NR; i++) {
+		tmp1 = iqkxy_to_s32(result[c1][i]);
+		tmp2 = iqkxy_to_s32(result[c2][i]);
+
+		diff = abs(tmp1 - tmp2);
+
+		if (diff <= MAX_TOLERANCE)
+			continue;
+
+		if ((i == IQK_S1_RX_X || i == IQK_S0_RX_X) && !bitmap) {
+			if (result[c1][i] + result[c1][i + 1] == 0)
+				candidate[i / IQK_SX_NR] = c2;
+			else if (result[c2][i] + result[c2][i + 1] == 0)
+				candidate[i / IQK_SX_NR] = c1;
+			else
+				bitmap |= BIT(i);
+		} else {
+			bitmap |= BIT(i);
+		}
+	}
+
+	if (bitmap != 0)
+		goto check_sim;
+
+	for (i = 0; i < PATH_NR; i++) {
+		if (candidate[i] == IQK_ROUND_INVALID)
+			continue;
+
+		for (j = i * IQK_SX_NR; j < i * IQK_SX_NR + 2; j++)
+			result[IQK_ROUND_HYBRID][j] = result[candidate[i]][j];
+		ret = false;
+	}
+
+	return ret;
+
+check_sim:
+	for (i = 0; i < IQK_NR; i++) {
+		j = i & ~1;	/* 2 bits are a pair for IQ[X, Y] */
+		if (bitmap & GENMASK(j + 1, j))
+			continue;
+
+		result[IQK_ROUND_HYBRID][i] = result[c1][i];
+	}
+
+	return false;
+}
+
+static
+void rtw8723d_iqk_precfg_path(struct rtw_dev *rtwdev, enum rtw8723d_path path)
+{
+	if (path == PATH_S0) {
+		rtw8723d_iqk_rf_standby(rtwdev, RF_PATH_A);
+		rtw8723d_iqk_path_adda_on(rtwdev);
+	}
+
+	rtw_write32_mask(rtwdev, REG_FPGA0_IQK_11N, BIT_MASK_IQK_MOD, EN_IQK);
+	rtw_write32(rtwdev, REG_TXIQK_11N, 0x01007c00);
+	rtw_write32(rtwdev, REG_RXIQK_11N, 0x01004800);
+
+	if (path == PATH_S1) {
+		rtw8723d_iqk_rf_standby(rtwdev, RF_PATH_B);
+		rtw8723d_iqk_path_adda_on(rtwdev);
+	}
+}
+
+static
+void rtw8723d_iqk_one_round(struct rtw_dev *rtwdev, s32 result[][IQK_NR], u8 t,
+			    const struct iqk_backup_regs *backup)
+{
+	u32 i;
+	u8 s1_ok, s0_ok;
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK,
+		"[IQK] IQ Calibration for 1T1R_S0/S1 for %d times\n", t);
+
+	rtw8723d_iqk_path_adda_on(rtwdev);
+	rtw8723d_iqk_config_mac(rtwdev);
+	rtw_write32_mask(rtwdev, REG_CCK_ANT_SEL_11N, 0x0f000000, 0xf);
+	rtw_write32(rtwdev, REG_BB_RX_PATH_11N, 0x03a05611);
+	rtw_write32(rtwdev, REG_TRMUX_11N, 0x000800e4);
+	rtw_write32(rtwdev, REG_BB_PWR_SAV1_11N, 0x25204200);
+	rtw8723d_iqk_precfg_path(rtwdev, PATH_S1);
+
+	for (i = 0; i < PATH_IQK_RETRY; i++) {
+		s1_ok = rtw8723d_iqk_tx_path(rtwdev, &iqk_tx_cfg[PATH_S1], backup);
+		if (s1_ok == IQK_TX_OK) {
+			rtw_dbg(rtwdev, RTW_DBG_RFK,
+				"[IQK] path S1 Tx IQK Success!!\n");
+			result[t][IQK_S1_TX_X] =
+			  rtw_read32_mask(rtwdev, REG_IQK_RES_TX, BIT_MASK_RES_TX);
+			result[t][IQK_S1_TX_Y] =
+			  rtw_read32_mask(rtwdev, REG_IQK_RES_TY, BIT_MASK_RES_TY);
+			break;
+		}
+
+		rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] path S1 Tx IQK Fail!!\n");
+		result[t][IQK_S1_TX_X] = 0x100;
+		result[t][IQK_S1_TX_Y] = 0x0;
+	}
+
+	for (i = 0; i < PATH_IQK_RETRY; i++) {
+		s1_ok = rtw8723d_iqk_rx_path(rtwdev, &iqk_tx_cfg[PATH_S1], backup);
+		if (s1_ok == (IQK_TX_OK | IQK_RX_OK)) {
+			rtw_dbg(rtwdev, RTW_DBG_RFK,
+				"[IQK] path S1 Rx IQK Success!!\n");
+			result[t][IQK_S1_RX_X] =
+			  rtw_read32_mask(rtwdev, REG_IQK_RES_RX, BIT_MASK_RES_RX);
+			result[t][IQK_S1_RX_Y] =
+			  rtw_read32_mask(rtwdev, REG_IQK_RES_RY, BIT_MASK_RES_RY);
+			break;
+		}
+
+		rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] path S1 Rx IQK Fail!!\n");
+		result[t][IQK_S1_RX_X] = 0x100;
+		result[t][IQK_S1_RX_Y] = 0x0;
+	}
+
+	if (s1_ok == 0x0)
+		rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] path S1 IQK is failed!!\n");
+
+	rtw8723d_iqk_precfg_path(rtwdev, PATH_S0);
+
+	for (i = 0; i < PATH_IQK_RETRY; i++) {
+		s0_ok = rtw8723d_iqk_tx_path(rtwdev, &iqk_tx_cfg[PATH_S0], backup);
+		if (s0_ok == IQK_TX_OK) {
+			rtw_dbg(rtwdev, RTW_DBG_RFK,
+				"[IQK] path S0 Tx IQK Success!!\n");
+			result[t][IQK_S0_TX_X] =
+			  rtw_read32_mask(rtwdev, REG_IQK_RES_TX, BIT_MASK_RES_TX);
+			result[t][IQK_S0_TX_Y] =
+			  rtw_read32_mask(rtwdev, REG_IQK_RES_TY, BIT_MASK_RES_TY);
+			break;
+		}
+
+		rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] path S0 Tx IQK Fail!!\n");
+		result[t][IQK_S0_TX_X] = 0x100;
+		result[t][IQK_S0_TX_Y] = 0x0;
+	}
+
+	for (i = 0; i < PATH_IQK_RETRY; i++) {
+		s0_ok = rtw8723d_iqk_rx_path(rtwdev, &iqk_tx_cfg[PATH_S0], backup);
+		if (s0_ok == (IQK_TX_OK | IQK_RX_OK)) {
+			rtw_dbg(rtwdev, RTW_DBG_RFK,
+				"[IQK] path S0 Rx IQK Success!!\n");
+
+			result[t][IQK_S0_RX_X] =
+			  rtw_read32_mask(rtwdev, REG_IQK_RES_RX, BIT_MASK_RES_RX);
+			result[t][IQK_S0_RX_Y] =
+			  rtw_read32_mask(rtwdev, REG_IQK_RES_RY, BIT_MASK_RES_RY);
+			break;
+		}
+
+		rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] path S0 Rx IQK Fail!!\n");
+		result[t][IQK_S0_RX_X] = 0x100;
+		result[t][IQK_S0_RX_Y] = 0x0;
+	}
+
+	if (s0_ok == 0x0)
+		rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] path S0 IQK is failed!!\n");
+
+	rtw_write32_mask(rtwdev, REG_FPGA0_IQK_11N, BIT_MASK_IQK_MOD, RST_IQK);
+	mdelay(1);
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK,
+		"[IQK] back to BB mode, load original value!\n");
+}
+
+static void rtw8723d_phy_calibration(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	s32 result[IQK_ROUND_SIZE][IQK_NR];
+	struct iqk_backup_regs backup;
+	u8 i, j;
+	u8 final_candidate = IQK_ROUND_INVALID;
+	bool good;
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] Start!!!\n");
+
+	memset(result, 0, sizeof(result));
+
+	rtw8723d_iqk_backup_path_ctrl(rtwdev, &backup);
+	rtw8723d_iqk_backup_lte_path_gnt(rtwdev, &backup);
+	rtw8723d_iqk_backup_regs(rtwdev, &backup);
+
+	for (i = IQK_ROUND_0; i <= IQK_ROUND_2; i++) {
+		rtw8723d_iqk_config_path_ctrl(rtwdev);
+		rtw8723d_iqk_config_lte_path_gnt(rtwdev);
+
+		rtw8723d_iqk_one_round(rtwdev, result, i, &backup);
+
+		if (i > IQK_ROUND_0)
+			rtw8723d_iqk_restore_regs(rtwdev, &backup);
+		rtw8723d_iqk_restore_lte_path_gnt(rtwdev, &backup);
+		rtw8723d_iqk_restore_path_ctrl(rtwdev, &backup);
+
+		for (j = IQK_ROUND_0; j < i; j++) {
+			good = rtw8723d_iqk_similarity_cmp(rtwdev, result, j, i);
+
+			if (good) {
+				final_candidate = j;
+				rtw_dbg(rtwdev, RTW_DBG_RFK,
+					"[IQK] cmp %d:%d final_candidate is %x\n",
+					j, i, final_candidate);
+				goto iqk_done;
+			}
+		}
+	}
+
+	if (final_candidate == IQK_ROUND_INVALID) {
+		s32 reg_tmp = 0;
+
+		for (i = 0; i < IQK_NR; i++)
+			reg_tmp += result[IQK_ROUND_HYBRID][i];
+
+		if (reg_tmp != 0) {
+			final_candidate = IQK_ROUND_HYBRID;
+		} else {
+			WARN(1, "IQK is failed\n");
+			goto out;
+		}
+	}
+
+iqk_done:
+	rtw8723d_iqk_fill_s1_matrix(rtwdev, result[final_candidate]);
+	rtw8723d_iqk_fill_s0_matrix(rtwdev, result[final_candidate]);
+
+	dm_info->iqk.result.s1_x = result[final_candidate][IQK_S1_TX_X];
+	dm_info->iqk.result.s1_y = result[final_candidate][IQK_S1_TX_Y];
+	dm_info->iqk.result.s0_x = result[final_candidate][IQK_S0_TX_X];
+	dm_info->iqk.result.s0_y = result[final_candidate][IQK_S0_TX_Y];
+	dm_info->iqk.done = true;
+
+out:
+	rtw_write32(rtwdev, REG_BB_SEL_BTG, backup.bb_sel_btg);
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] final_candidate is %x\n",
+		final_candidate);
+
+	for (i = IQK_ROUND_0; i < IQK_ROUND_SIZE; i++)
+		rtw_dbg(rtwdev, RTW_DBG_RFK,
+			"[IQK] Result %u: rege94_s1=%x rege9c_s1=%x regea4_s1=%x regeac_s1=%x rege94_s0=%x rege9c_s0=%x regea4_s0=%x regeac_s0=%x %s\n",
+			i,
+			result[i][0], result[i][1], result[i][2], result[i][3],
+			result[i][4], result[i][5], result[i][6], result[i][7],
+			final_candidate == i ? "(final candidate)" : "");
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK,
+		"[IQK]0xc80 = 0x%x 0xc94 = 0x%x 0xc14 = 0x%x 0xca0 = 0x%x\n",
+		rtw_read32(rtwdev, REG_OFDM_0_XA_TX_IQ_IMBALANCE),
+		rtw_read32(rtwdev, REG_TXIQK_MATRIXA_LSB2_11N),
+		rtw_read32(rtwdev, REG_A_RXIQI),
+		rtw_read32(rtwdev, REG_RXIQK_MATRIX_LSB_11N));
+	rtw_dbg(rtwdev, RTW_DBG_RFK,
+		"[IQK]0xcd0 = 0x%x 0xcd4 = 0x%x 0xcd8 = 0x%x\n",
+		rtw_read32(rtwdev, REG_TXIQ_AB_S0),
+		rtw_read32(rtwdev, REG_TXIQ_CD_S0),
+		rtw_read32(rtwdev, REG_RXIQ_AB_S0));
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] finished\n");
+}
+
 static struct rtw_chip_ops rtw8723d_ops = {
 	.phy_set_param		= rtw8723d_phy_set_param,
 	.read_efuse		= rtw8723d_read_efuse,
@@ -647,6 +1463,7 @@ static struct rtw_chip_ops rtw8723d_ops = {
 	.cfg_ldo25		= rtw8723d_cfg_ldo25,
 	.efuse_grant		= rtw8723d_efuse_grant,
 	.false_alarm_statistics	= rtw8723d_false_alarm_statistics,
+	.phy_calibration	= rtw8723d_phy_calibration,
 	.config_bfee		= NULL,
 	.set_gid_table		= NULL,
 	.cfg_csi_rate		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index 6a7d58992df5..549dfcf7f5da 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -5,6 +5,34 @@
 #ifndef __RTW8723D_H__
 #define __RTW8723D_H__
 
+enum rtw8723d_path {
+	PATH_S1,
+	PATH_S0,
+	PATH_NR,
+};
+
+enum rtw8723d_iqk_round {
+	IQK_ROUND_0,
+	IQK_ROUND_1,
+	IQK_ROUND_2,
+	IQK_ROUND_HYBRID,
+	IQK_ROUND_SIZE,
+	IQK_ROUND_INVALID = 0xff,
+};
+
+enum rtw8723d_iqk_result {
+	IQK_S1_TX_X,
+	IQK_S1_TX_Y,
+	IQK_S1_RX_X,
+	IQK_S1_RX_Y,
+	IQK_S0_TX_X,
+	IQK_S0_TX_Y,
+	IQK_S0_RX_X,
+	IQK_S0_RX_Y,
+	IQK_NR,
+	IQK_SX_NR = IQK_NR / PATH_NR,
+};
+
 struct rtw8723de_efuse {
 	u8 mac_addr[ETH_ALEN];		/* 0xd0 */
 	u8 vender_id[2];
@@ -66,6 +94,34 @@ struct rtw8723d_efuse {
 #define GET_PHY_STAT_P1_RXSNR_A(phy_stat)                                      \
 	le32_get_bits(*((__le32 *)(phy_stat) + 0x06), GENMASK(7, 0))
 
+static inline s32 iqkxy_to_s32(s32 val)
+{
+	/* val is Q10.8 */
+	return sign_extend32(val, 9);
+}
+
+static inline s32 iqk_mult(s32 x, s32 y, s32 *ext)
+{
+	/* x, y and return value are Q10.8 */
+	s32 t;
+
+	t = x * y;
+	if (ext)
+		*ext = (t >> 7) & 0x1;	/* Q.16 --> Q.9; get LSB of Q.9 */
+
+	return (t >> 8);	/* Q.16 --> Q.8 */
+}
+
+#define MAX_TOLERANCE	5
+#define IQK_TX_X_ERR	0x142
+#define IQK_TX_Y_ERR	0x42
+#define IQK_RX_X_UPPER	0x11a
+#define IQK_RX_X_LOWER	0xe6
+#define IQK_RX_Y_LMT	0x1a
+#define IQK_TX_OK	BIT(0)
+#define IQK_RX_OK	BIT(1)
+#define PATH_IQK_RETRY	2
+
 #define SPUR_THRES		0x16
 #define CCK_DFIR_NR		3
 #define DIS_3WIRE		0xccf000c0
@@ -80,15 +136,20 @@ struct rtw8723d_efuse {
 #define BIT_MASK_RFMOD		BIT(0)
 #define BIT_LCK			BIT(15)
 
+#define REG_BTG_SEL		0x0067
+#define REG_LTECOEX_PATH_CONTROL	0x0070
 #define REG_PSDFN		0x0808
+#define REG_BB_PWR_SAV1_11N	0x0874
 #define REG_ANALOG_P4		0x088c
 #define REG_PSDRPT		0x08b4
 #define REG_FPGA1_RFMOD		0x0900
+#define REG_BB_SEL_BTG		0x0948
 #define REG_BBRX_DFIR		0x0954
 #define BIT_MASK_RXBB_DFIR	GENMASK(27, 24)
 #define BIT_RXBB_DFIR_EN	BIT(19)
 #define REG_CCK0_SYS		0x0a00
 #define BIT_CCK_SIDE_BAND	BIT(4)
+#define REG_CCK_ANT_SEL_11N	0x0a04
 #define REG_CCK_FA_RST_11N	0x0a2c
 #define BIT_MASK_CCK_CNT_KEEP	BIT(12)
 #define BIT_MASK_CCK_CNT_EN	BIT(13)
@@ -103,13 +164,48 @@ struct rtw8723d_efuse {
 #define BIT_MASK_CCK_FA_LSB	GENMASK(15, 8)
 #define REG_OFDM_FA_HOLDC_11N	0x0c00
 #define BIT_MASK_OFDM_FA_KEEP	BIT(31)
+#define REG_BB_RX_PATH_11N	0x0c04
+#define REG_TRMUX_11N		0x0c08
 #define REG_OFDM_FA_RSTC_11N	0x0c0c
 #define BIT_MASK_OFDM_FA_RST	BIT(31)
+#define REG_A_RXIQI		0x0c14
+#define BIT_MASK_RXIQ_S1_X	0x000003FF
+#define BIT_MASK_RXIQ_S1_Y1	0x0000FC00
+#define BIT_SET_RXIQ_S1_Y1(y)	((y) & 0x3F)
 #define REG_OFDM0_RXDSP		0x0c40
 #define BIT_MASK_RXDSP		GENMASK(28, 24)
 #define BIT_EN_RXDSP		BIT(9)
+#define REG_OFDM_0_ECCA_THRESHOLD	0x0c4c
+#define BIT_MASK_OFDM0_EXT_A	BIT(31)
+#define BIT_MASK_OFDM0_EXT_C	BIT(29)
+#define BIT_MASK_OFDM0_EXTS	(BIT(31) | BIT(29) | BIT(28))
+#define BIT_SET_OFDM0_EXTS(a, c, d) (((a) << 31) | ((c) << 29) | ((d) << 28))
 #define REG_OFDM0_XAAGC1	0x0c50
 #define REG_OFDM0_XBAGC1	0x0c58
+#define REG_OFDM_0_XA_TX_IQ_IMBALANCE	0x0c80
+#define BIT_MASK_TXIQ_ELM_A	0x03ff
+#define BIT_SET_TXIQ_ELM_ACD(a, c, d) (((d) << 22) | (((c) & 0x3F) << 16) |    \
+				       ((a) & 0x03ff))
+#define BIT_MASK_TXIQ_ELM_C	GENMASK(21, 16)
+#define BIT_SET_TXIQ_ELM_C2(c)	((c) & 0x3F)
+#define BIT_MASK_TXIQ_ELM_D	GENMASK(31, 22)
+#define REG_TXIQK_MATRIXA_LSB2_11N	0x0c94
+#define BIT_SET_TXIQ_ELM_C1(c)	(((c) & 0x000003C0) >> 6)
+#define REG_RXIQK_MATRIX_LSB_11N	0x0ca0
+#define BIT_MASK_RXIQ_S1_Y2	0xF0000000
+#define BIT_SET_RXIQ_S1_Y2(y)	(((y) >> 6) & 0xF)
+#define REG_TXIQ_AB_S0		0x0cd0
+#define BIT_MASK_TXIQ_A_S0	0x000007FE
+#define BIT_MASK_TXIQ_A_EXT_S0	BIT(0)
+#define BIT_MASK_TXIQ_B_S0	0x0007E000
+#define REG_TXIQ_CD_S0		0x0cd4
+#define BIT_MASK_TXIQ_C_S0	0x000007FE
+#define BIT_MASK_TXIQ_C_EXT_S0	BIT(0)
+#define BIT_MASK_TXIQ_D_S0	GENMASK(22, 13)
+#define BIT_MASK_TXIQ_D_EXT_S0	BIT(12)
+#define REG_RXIQ_AB_S0		0x0cd8
+#define BIT_MASK_RXIQ_X_S0	0x000003FF
+#define BIT_MASK_RXIQ_Y_S0	0x003FF000
 #define REG_OFDM_FA_TYPE1_11N	0x0cf0
 #define BIT_MASK_OFDM_FF_CNT	GENMASK(15, 0)
 #define BIT_MASK_OFDM_SF_CNT	GENMASK(31, 16)
@@ -132,6 +228,32 @@ struct rtw8723d_efuse {
 #define BIT_MASK_OFDM_CRC_CNT	GENMASK(31, 16)
 #define REG_OFDM_FA_TYPE4_11N	0x0da8
 #define BIT_MASK_OFDM_MNS_CNT	GENMASK(15, 0)
+#define REG_FPGA0_IQK_11N	0x0e28
+#define BIT_MASK_IQK_MOD	0xffffff00
+#define EN_IQK			0x808000
+#define RST_IQK			0x000000
+#define REG_TXIQK_TONE_A_11N	0x0e30
+#define REG_RXIQK_TONE_A_11N	0x0e34
+#define REG_TXIQK_PI_A_11N	0x0e38
+#define REG_RXIQK_PI_A_11N	0x0e3c
+#define REG_TXIQK_11N		0x0e40
+#define BIT_SET_TXIQK_11N(x, y)	(0x80007C00 | ((x) << 16) | (y))
+#define REG_RXIQK_11N		0x0e44
+#define REG_IQK_AGC_PTS_11N	0x0e48
+#define REG_IQK_AGC_RSP_11N	0x0e4c
+#define REG_TX_IQK_TONE_B	0x0e50
+#define REG_RX_IQK_TONE_B	0x0e54
+#define REG_IQK_RES_TX		0x0e94
+#define BIT_MASK_RES_TX		GENMASK(25, 16)
+#define REG_IQK_RES_TY		0x0e9c
+#define BIT_MASK_RES_TY		GENMASK(25, 16)
+#define REG_IQK_RES_RX		0x0ea4
+#define BIT_MASK_RES_RX		GENMASK(25, 16)
+#define REG_IQK_RES_RY		0x0eac
+#define BIT_IQK_TX_FAIL		BIT(28)
+#define BIT_IQK_RX_FAIL		BIT(27)
+#define BIT_IQK_DONE		BIT(26)
+#define BIT_MASK_RES_RY		GENMASK(25, 16)
 #define REG_PAGE_F_RST_11N		0x0f14
 #define BIT_MASK_F_RST_ALL		BIT(16)
 #define REG_IGI_C_11N			0x0f84
-- 
2.17.1

