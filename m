Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEF51B35BC
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 05:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgDVDqZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 23:46:25 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37001 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgDVDqS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 23:46:18 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03M3kBPA1004597, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03M3kBPA1004597
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Apr 2020 11:46:11 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Apr 2020 11:46:11 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Apr 2020 11:46:10 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>
Subject: [PATCH v2 8/8] rtw88: 8723d: initialize mac/bb/rf basic functions
Date:   Wed, 22 Apr 2020 11:46:07 +0800
Message-ID: <20200422034607.28747-9-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422034607.28747-1-yhchuang@realtek.com>
References: <20200422034607.28747-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

Implement rtw_chip_ops::phy_set_param and ::mac_init to initialize
mac/bb/rf, and they are used during interface up. The procedure contains
power on sequence registers, download firmware, load predefined parameters,
mac/bb/rf specific register and etc.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     |   1 +
 drivers/net/wireless/realtek/rtw88/reg.h      |  34 +++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 124 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |   3 +
 4 files changed, 162 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 380a670eeeee..157aca641f6d 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1475,6 +1475,7 @@ struct rtw_efuse {
 	u8 ant_div_cfg;
 	u8 ant_div_type;
 	u8 regd;
+	u8 afe;
 
 	u8 lna_type_2g;
 	u8 lna_type_5g;
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 00eb6b6a1f5b..9fdfcdc5c5cf 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -6,6 +6,7 @@
 #define __RTW_REG_DEF_H__
 
 #define REG_SYS_FUNC_EN		0x0002
+#define BIT_FEN_EN_25_1		BIT(13)
 #define BIT_FEN_ELDR		BIT(12)
 #define BIT_FEN_CPUEN		BIT(2)
 #define BIT_FEN_BB_GLB_RST	BIT(1)
@@ -40,6 +41,11 @@
 #define BIT_MASK_EF_ADDR	0x3ff
 #define BIT_MASK_EF_DATA	0xff
 #define BITS_EF_ADDR		(BIT_MASK_EF_ADDR << BIT_SHIFT_EF_ADDR)
+#define BITS_PLL		0xf0
+
+#define REG_AFE_CTRL3		0x2c
+#define BIT_MASK_XTAL		0x00FFF000
+#define BIT_XTAL_GMP_BIT4	BIT(28)
 
 #define REG_LDO_EFUSE_CTRL	0x0034
 #define BIT_MASK_EFUSE_BANK_SEL	(BIT(8) | BIT(9))
@@ -61,6 +67,7 @@
 #define BIT_PAPE_SEL_EN		BIT(25)
 #define BIT_DPDT_WL_SEL		BIT(24)
 #define BIT_DPDT_SEL_EN		BIT(23)
+#define REG_LEDCFG2		0x004E
 #define REG_PAD_CTRL1		0x0064
 #define BIT_PAPE_WLBT_SEL	BIT(29)
 #define BIT_LNAON_WLBT_SEL	BIT(28)
@@ -76,9 +83,15 @@
 #define BIT_LTE_MUX_CTRL_PATH	BIT(26)
 #define REG_HCI_OPT_CTRL	0x0074
 
+#define REG_AFE_CTRL_4		0x0078
+#define BIT_CK320M_AFE_EN	BIT(4)
+#define BIT_EN_SYN		BIT(15)
+
 #define REG_LDO_SWR_CTRL	0x007C
 #define LDO_SEL			0xC3
 #define SPS_SEL			0x83
+#define BIT_XTA1		BIT(29)
+#define BIT_XTA0		BIT(28)
 
 #define REG_MCUFW_CTRL		0x0080
 #define BIT_ANA_PORT_EN		BIT(22)
@@ -197,6 +210,7 @@
 #define BIT_FS_RXDONE		BIT(16)
 #define REG_PKTBUF_DBG_CTRL	0x0140
 #define REG_C2HEVT		0x01A0
+#define REG_MCUTST_1		0x01C0
 #define REG_MCUTST_II		0x01C4
 #define REG_WOWLAN_WAKE_REASON	0x01C7
 #define REG_HMETFR		0x01CC
@@ -230,6 +244,7 @@
 #define REG_DWBCN0_CTRL		0x0208
 #define BIT_BCN_VALID		BIT(16)
 #define REG_TXDMA_OFFSET_CHK	0x020C
+#define BIT_DROP_DATA_EN	BIT(9)
 #define REG_TXDMA_STATUS	0x0210
 #define BTI_PAGE_OVF		BIT(2)
 
@@ -291,6 +306,7 @@
 #define BIT_CHECK_CCK_EN	BIT(7)
 #define REG_AMPDU_MAX_TIME_V1	0x0455
 #define REG_BCNQ1_BDNY_V1	0x0456
+#define REG_AMPDU_MAX_TIME	0x0456
 #define REG_WMAC_LBK_BF_HD	0x045D
 #define REG_TX_HANG_CTRL	0x045E
 #define BIT_EN_GNT_BT_AWAKE	BIT(3)
@@ -306,7 +322,10 @@
 #define REG_QUEUE_CTRL		0x04C6
 #define BIT_PTA_WL_TX_EN	BIT(4)
 #define BIT_PTA_EDCCA_EN	BIT(5)
+#define REG_SINGLE_AMPDU_CTRL	0x04C7
+#define BIT_EN_SINGLE_APMDU	BIT(7)
 #define REG_PROT_MODE_CTRL	0x04C8
+#define REG_MAX_AGGR_NUM	0x04CA
 #define REG_BAR_MODE_CTRL	0x04CC
 #define REG_PRECNT_CTRL		0x04E5
 #define BIT_BTCCA_CTRL		(BIT(0) | BIT(1))
@@ -326,6 +345,7 @@
 #define BIT_SHIFT_SIFS_OFDM_CTX	8
 #define BIT_SHIFT_SIFS_CCK_TRX	16
 #define BIT_SHIFT_SIFS_OFDM_TRX	24
+#define REG_AGGR_BREAK_TIME	0x051A
 #define REG_SLOT		0x051B
 #define REG_TX_PTCL_CTRL	0x0520
 #define BIT_SIFS_BK_EN		BIT(12)
@@ -337,18 +357,23 @@
 #define REG_TBTT_PROHIBIT	0x0540
 #define BIT_SHIFT_TBTT_HOLD_TIME_AP 8
 #define REG_RD_NAV_NXT		0x0544
+#define REG_NAV_PROT_LEN	0x0546
 #define REG_BCN_CTRL		0x0550
 #define BIT_DIS_TSF_UDT		BIT(4)
 #define BIT_EN_BCN_FUNCTION	BIT(3)
+#define BIT_EN_TXBCN_RPT	BIT(2)
 #define REG_BCN_CTRL_CLINT0	0x0551
 #define REG_DRVERLYINT		0x0558
 #define REG_BCNDMATIM		0x0559
+#define REG_ATIMWND		0x055A
 #define REG_USTIME_TSF		0x055C
 #define REG_BCN_MAX_ERR		0x055D
 #define REG_RXTSF_OFFSET_CCK	0x055E
 #define REG_MISC_CTRL		0x0577
 #define BIT_EN_FREE_CNT		BIT(3)
 #define BIT_DIS_SECOND_CCA	(BIT(0) | BIT(1))
+#define REG_HIQ_NO_LMT_EN	0x5A7
+#define BIT_HIQ_NO_LMT_EN_ROOT	BIT(0)
 #define REG_TIMER0_SRC_SEL	0x05B4
 #define BIT_TSFT_SEL_TIMER0	(BIT(4) | BIT(5) | BIT(6))
 
@@ -374,6 +399,7 @@
 #define BIT_HTC_LOC_CTRL	BIT(14)
 #define BIT_RPFM_CAM_ENABLE	BIT(12)
 #define BIT_TA_BCN		BIT(11)
+#define BIT_RCR_ADF		BIT(11)
 #define BIT_DISDECMYPKT		BIT(10)
 #define BIT_AICV		BIT(9)
 #define BIT_ACRC32		BIT(8)
@@ -391,6 +417,7 @@
 #define REG_MAR			0x0620
 #define REG_USTIME_EDCA		0x0638
 #define REG_ACKTO_CCK		0x0639
+#define REG_MAC_SPEC_SIFS	0x063A
 #define REG_RESP_SIFS_CCK	0x063C
 #define REG_RESP_SIFS_OFDM	0x063E
 #define REG_ACKTO		0x0640
@@ -433,12 +460,19 @@
 #define BIT_LTE_COEX_EN		BIT(7)
 #define REG_BT_STAT_CTRL	0x0778
 #define REG_BT_TDMA_TIME	0x0790
+#define REG_LTR_IDLE_LATENCY	0x0798
+#define REG_LTR_ACTIVE_LATENCY	0x079C
+#define REG_LTR_CTRL_BASIC	0x07A4
 #define REG_WMAC_OPTION_FUNCTION 0x07D0
 #define REG_WMAC_OPTION_FUNCTION_1 0x07D4
 
+#define REG_FPGA0_RFMOD		0x0800
+#define BIT_CCKEN		BIT(24)
+#define BIT_OFDMEN		BIT(25)
 #define REG_RX_GAIN_EN		0x081c
 
 #define REG_RFE_CTRL_E		0x0974
+#define REG_2ND_CCA_CTRL	0x0976
 
 #define REG_DIS_DPD		0x0a70
 #define DIS_DPD_MASK		GENMASK(9, 0)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index c03ed91349e5..8ca4d5794434 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -37,6 +37,98 @@ static const struct rtw_hw_reg rtw8723d_txagc[] = {
 	[DESC_RATEMCS7]	= { .addr = 0xe14, .mask = 0xff000000 },
 };
 
+#define WLAN_TXQ_RPT_EN		0x1F
+#define WLAN_SLOT_TIME		0x09
+#define WLAN_RL_VAL		0x3030
+#define WLAN_BAR_VAL		0x0201ffff
+#define BIT_MASK_TBTT_HOLD	0x00000fff
+#define BIT_SHIFT_TBTT_HOLD	8
+#define BIT_MASK_TBTT_SETUP	0x000000ff
+#define BIT_SHIFT_TBTT_SETUP	0
+#define BIT_MASK_TBTT_MASK	((BIT_MASK_TBTT_HOLD << BIT_SHIFT_TBTT_HOLD) | \
+				 (BIT_MASK_TBTT_SETUP << BIT_SHIFT_TBTT_SETUP))
+#define TBTT_TIME(s, h)((((s) & BIT_MASK_TBTT_SETUP) << BIT_SHIFT_TBTT_SETUP) |\
+			(((h) & BIT_MASK_TBTT_HOLD) << BIT_SHIFT_TBTT_HOLD))
+#define WLAN_TBTT_TIME_NORMAL	TBTT_TIME(0x04, 0x80)
+#define WLAN_TBTT_TIME_STOP_BCN	TBTT_TIME(0x04, 0x64)
+#define WLAN_PIFS_VAL		0
+#define WLAN_AGG_BRK_TIME	0x16
+#define WLAN_NAV_PROT_LEN	0x0040
+#define WLAN_SPEC_SIFS		0x100a
+#define WLAN_RX_PKT_LIMIT	0x17
+#define WLAN_MAX_AGG_NR		0x0A
+#define WLAN_AMPDU_MAX_TIME	0x1C
+#define WLAN_ANT_SEL		0x82
+#define WLAN_LTR_IDLE_LAT	0x883C883C
+#define WLAN_LTR_ACT_LAT	0x880B880B
+#define WLAN_LTR_CTRL1		0xCB004010
+#define WLAN_LTR_CTRL2		0x01233425
+
+static void rtw8723d_phy_set_param(struct rtw_dev *rtwdev)
+{
+	u8 xtal_cap;
+	u32 val32;
+
+	/* power on BB/RF domain */
+	rtw_write16_set(rtwdev, REG_SYS_FUNC_EN,
+			BIT_FEN_EN_25_1 | BIT_FEN_BB_GLB_RST | BIT_FEN_BB_RSTB);
+	rtw_write8_set(rtwdev, REG_RF_CTRL,
+		       BIT_RF_EN | BIT_RF_RSTB | BIT_RF_SDM_RSTB);
+	rtw_write8(rtwdev, REG_AFE_CTRL1 + 1, 0x80);
+
+	rtw_phy_load_tables(rtwdev);
+
+	/* post init after header files config */
+	rtw_write32_clr(rtwdev, REG_RCR, BIT_RCR_ADF);
+	rtw_write8_set(rtwdev, REG_HIQ_NO_LMT_EN, BIT_HIQ_NO_LMT_EN_ROOT);
+	rtw_write16_set(rtwdev, REG_AFE_CTRL_4, BIT_CK320M_AFE_EN | BIT_EN_SYN);
+
+	xtal_cap = rtwdev->efuse.crystal_cap & 0x3F;
+	rtw_write32_mask(rtwdev, REG_AFE_CTRL3, BIT_MASK_XTAL,
+			 xtal_cap | (xtal_cap << 6));
+	rtw_write32_set(rtwdev, REG_FPGA0_RFMOD, BIT_CCKEN | BIT_OFDMEN);
+	if ((rtwdev->efuse.afe >> 4) == 14) {
+		rtw_write32_set(rtwdev, REG_AFE_CTRL3, BIT_XTAL_GMP_BIT4);
+		rtw_write32_clr(rtwdev, REG_AFE_CTRL1, BITS_PLL);
+		rtw_write32_set(rtwdev, REG_LDO_SWR_CTRL, BIT_XTA1);
+		rtw_write32_clr(rtwdev, REG_LDO_SWR_CTRL, BIT_XTA0);
+	}
+
+	rtw_write8(rtwdev, REG_SLOT, WLAN_SLOT_TIME);
+	rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 1, WLAN_TXQ_RPT_EN);
+	rtw_write16(rtwdev, REG_RETRY_LIMIT, WLAN_RL_VAL);
+	rtw_write32(rtwdev, REG_BAR_MODE_CTRL, WLAN_BAR_VAL);
+	rtw_write8(rtwdev, REG_ATIMWND, 0x2);
+	rtw_write8(rtwdev, REG_BCN_CTRL,
+		   BIT_DIS_TSF_UDT | BIT_EN_BCN_FUNCTION | BIT_EN_TXBCN_RPT);
+	val32 = rtw_read32(rtwdev, REG_TBTT_PROHIBIT);
+	val32 &= ~BIT_MASK_TBTT_MASK;
+	val32 |= WLAN_TBTT_TIME_STOP_BCN;
+	rtw_write8(rtwdev, REG_TBTT_PROHIBIT, val32);
+	rtw_write8(rtwdev, REG_PIFS, WLAN_PIFS_VAL);
+	rtw_write8(rtwdev, REG_AGGR_BREAK_TIME, WLAN_AGG_BRK_TIME);
+	rtw_write16(rtwdev, REG_NAV_PROT_LEN, WLAN_NAV_PROT_LEN);
+	rtw_write16(rtwdev, REG_MAC_SPEC_SIFS, WLAN_SPEC_SIFS);
+	rtw_write16(rtwdev, REG_SIFS, WLAN_SPEC_SIFS);
+	rtw_write16(rtwdev, REG_SIFS + 2, WLAN_SPEC_SIFS);
+	rtw_write8(rtwdev, REG_SINGLE_AMPDU_CTRL, BIT_EN_SINGLE_APMDU);
+	rtw_write8(rtwdev, REG_RX_PKT_LIMIT, WLAN_RX_PKT_LIMIT);
+	rtw_write8(rtwdev, REG_MAX_AGGR_NUM, WLAN_MAX_AGG_NR);
+	rtw_write8(rtwdev, REG_AMPDU_MAX_TIME, WLAN_AMPDU_MAX_TIME);
+	rtw_write8(rtwdev, REG_LEDCFG2, WLAN_ANT_SEL);
+
+	rtw_write32(rtwdev, REG_LTR_IDLE_LATENCY, WLAN_LTR_IDLE_LAT);
+	rtw_write32(rtwdev, REG_LTR_ACTIVE_LATENCY, WLAN_LTR_ACT_LAT);
+	rtw_write32(rtwdev, REG_LTR_CTRL_BASIC, WLAN_LTR_CTRL1);
+	rtw_write32(rtwdev, REG_LTR_CTRL_BASIC + 4, WLAN_LTR_CTRL2);
+
+	rtw_phy_init(rtwdev);
+
+	rtw_write16_set(rtwdev, REG_TXDMA_OFFSET_CHK, BIT_DROP_DATA_EN);
+	rtw_write32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0, 0x50);
+	rtw_write32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0, 0x20);
+}
+
 static void rtw8723de_efuse_parsing(struct rtw_efuse *efuse,
 				    struct rtw8723d_efuse *map)
 {
@@ -63,6 +155,7 @@ static int rtw8723d_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 	efuse->regd = map->rf_board_option & 0x7;
 	efuse->thermal_meter[0] = map->thermal_meter;
 	efuse->thermal_meter_k = map->thermal_meter;
+	efuse->afe = map->afe;
 
 	for (i = 0; i < 4; i++)
 		efuse->txpwr_idx_table[i] = map->txpwr_idx_table[i];
@@ -79,6 +172,35 @@ static int rtw8723d_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 	return 0;
 }
 
+#define BIT_CFENDFORM		BIT(9)
+#define BIT_WMAC_TCR_ERR0	BIT(12)
+#define BIT_WMAC_TCR_ERR1	BIT(13)
+#define BIT_TCR_CFG		(BIT_CFENDFORM | BIT_WMAC_TCR_ERR0 |	       \
+				 BIT_WMAC_TCR_ERR1)
+#define WLAN_RX_FILTER0		0xFFFF
+#define WLAN_RX_FILTER1		0x400
+#define WLAN_RX_FILTER2		0xFFFF
+#define WLAN_RCR_CFG		0x700060CE
+
+static int rtw8723d_mac_init(struct rtw_dev *rtwdev)
+{
+	rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 1, WLAN_TXQ_RPT_EN);
+	rtw_write32(rtwdev, REG_TCR, BIT_TCR_CFG);
+
+	rtw_write16(rtwdev, REG_RXFLTMAP0, WLAN_RX_FILTER0);
+	rtw_write16(rtwdev, REG_RXFLTMAP1, WLAN_RX_FILTER1);
+	rtw_write16(rtwdev, REG_RXFLTMAP2, WLAN_RX_FILTER2);
+	rtw_write32(rtwdev, REG_RCR, WLAN_RCR_CFG);
+
+	rtw_write32(rtwdev, REG_INT_MIG, 0);
+	rtw_write32(rtwdev, REG_MCUTST_1, 0x0);
+
+	rtw_write8(rtwdev, REG_MISC_CTRL, BIT_DIS_SECOND_CCA);
+	rtw_write8(rtwdev, REG_2ND_CCA_CTRL, 0);
+
+	return 0;
+}
+
 static void rtw8723d_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 {
 	u8 ldo_pwr;
@@ -143,7 +265,9 @@ static void rtw8723d_efuse_grant(struct rtw_dev *rtwdev, bool on)
 }
 
 static struct rtw_chip_ops rtw8723d_ops = {
+	.phy_set_param		= rtw8723d_phy_set_param,
 	.read_efuse		= rtw8723d_read_efuse,
+	.mac_init		= rtw8723d_mac_init,
 	.read_rf		= rtw_phy_read_rf_sipi,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
 	.set_tx_power_index	= rtw8723d_set_tx_power_index,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index 1939d9897a26..6321dea83519 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -44,4 +44,7 @@ struct rtw8723d_efuse {
 	struct rtw8723de_efuse e;
 };
 
+#define REG_OFDM0_XAAGC1	0x0c50
+#define REG_OFDM0_XBAGC1	0x0c58
+
 #endif
-- 
2.17.1

