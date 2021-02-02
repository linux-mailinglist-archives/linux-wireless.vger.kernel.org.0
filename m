Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A0E30B771
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Feb 2021 06:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhBBFwQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Feb 2021 00:52:16 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:34018 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhBBFwL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Feb 2021 00:52:11 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1125pIkmD018657, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 1125pIkmD018657
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 2 Feb 2021 13:51:19 +0800
Received: from localhost (172.21.236.51) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 2 Feb 2021
 13:51:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] rtw88: 8821c: support RFE type2 wifi NIC
Date:   Tue, 2 Feb 2021 13:50:12 +0800
Message-ID: <20210202055012.8296-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210202055012.8296-1-pkshih@realtek.com>
References: <20210202055012.8296-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.236.51]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Guo-Feng Fan <vincent_fann@realtek.com>

RFE type2 is a new NIC which has one RF antenna shares with BT.
Update phy parameter to verstion V57 to allow initial procedure
to load extra AGC table for sharing antenna NIC.

Signed-off-by: Guo-Feng Fan <vincent_fann@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c     |   2 +
 drivers/net/wireless/realtek/rtw88/main.h     |   7 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  47 +++
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |  14 +
 .../wireless/realtek/rtw88/rtw8821c_table.c   | 397 ++++++++++++++++++
 .../wireless/realtek/rtw88/rtw8821c_table.h   |   1 +
 6 files changed, 468 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 16bacfadeb58..757aaf45f65e 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1590,6 +1590,8 @@ static int rtw_chip_board_info_setup(struct rtw_dev *rtwdev)
 	rtw_phy_setup_phy_cond(rtwdev, 0);
 
 	rtw_phy_init_tx_power(rtwdev);
+	if (rfe_def->agc_btg_tbl)
+		rtw_load_table(rtwdev, rfe_def->agc_btg_tbl);
 	rtw_load_table(rtwdev, rfe_def->phy_pg_tbl);
 	rtw_load_table(rtwdev, rfe_def->txpwr_lmt_tbl);
 	rtw_phy_tx_power_by_rate_config(hal);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 9a318dfd04f9..87524199d0d6 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1042,6 +1042,7 @@ enum rtw_rfe_fem {
 struct rtw_rfe_def {
 	const struct rtw_table *phy_pg_tbl;
 	const struct rtw_table *txpwr_lmt_tbl;
+	const struct rtw_table *agc_btg_tbl;
 };
 
 #define RTW_DEF_RFE(chip, bb_pg, pwrlmt) {				  \
@@ -1049,6 +1050,12 @@ struct rtw_rfe_def {
 	.txpwr_lmt_tbl = &rtw ## chip ## _txpwr_lmt_type ## pwrlmt ## _tbl, \
 	}
 
+#define RTW_DEF_RFE_EXT(chip, bb_pg, pwrlmt, btg) {			  \
+	.phy_pg_tbl = &rtw ## chip ## _bb_pg_type ## bb_pg ## _tbl,	  \
+	.txpwr_lmt_tbl = &rtw ## chip ## _txpwr_lmt_type ## pwrlmt ## _tbl, \
+	.agc_btg_tbl = &rtw ## chip ## _agc_btg_type ## btg ## _tbl, \
+	}
+
 #define RTW_PWR_TRK_5G_1		0
 #define RTW_PWR_TRK_5G_2		1
 #define RTW_PWR_TRK_5G_3		2
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index f0a56f56f0d5..33c6cf1206c8 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -25,6 +25,13 @@ static void rtw8821ce_efuse_parsing(struct rtw_efuse *efuse,
 	ether_addr_copy(efuse->addr, map->e.mac_addr);
 }
 
+enum rtw8821ce_rf_set {
+	SWITCH_TO_BTG,
+	SWITCH_TO_WLG,
+	SWITCH_TO_WLA,
+	SWITCH_TO_BT,
+};
+
 static int rtw8821c_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
@@ -228,6 +235,40 @@ static void rtw8821c_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 	rtw_write8(rtwdev, REG_LDO_EFUSE_CTRL + 3, ldo_pwr);
 }
 
+static void rtw8821c_switch_rf_set(struct rtw_dev *rtwdev, u8 rf_set)
+{
+	u32 reg;
+
+	rtw_write32_set(rtwdev, REG_DMEM_CTRL, BIT_WL_RST);
+	rtw_write32_set(rtwdev, REG_SYS_CTRL, BIT_FEN_EN);
+
+	reg = rtw_read32(rtwdev, REG_RFECTL);
+	switch (rf_set) {
+	case SWITCH_TO_BTG:
+		reg |= B_BTG_SWITCH;
+		reg &= ~(B_CTRL_SWITCH | B_WL_SWITCH | B_WLG_SWITCH |
+			 B_WLA_SWITCH);
+		rtw_write32_mask(rtwdev, REG_ENRXCCA, MASKBYTE2, BTG_CCA);
+		rtw_write32_mask(rtwdev, REG_ENTXCCK, MASKLWORD, BTG_LNA);
+		break;
+	case SWITCH_TO_WLG:
+		reg |= B_WL_SWITCH | B_WLG_SWITCH;
+		reg &= ~(B_BTG_SWITCH | B_CTRL_SWITCH | B_WLA_SWITCH);
+		rtw_write32_mask(rtwdev, REG_ENRXCCA, MASKBYTE2, WLG_CCA);
+		rtw_write32_mask(rtwdev, REG_ENTXCCK, MASKLWORD, WLG_LNA);
+		break;
+	case SWITCH_TO_WLA:
+		reg |= B_WL_SWITCH | B_WLA_SWITCH;
+		reg &= ~(B_BTG_SWITCH | B_CTRL_SWITCH | B_WLG_SWITCH);
+		break;
+	case SWITCH_TO_BT:
+	default:
+		break;
+	}
+
+	rtw_write32(rtwdev, REG_RFECTL, reg);
+}
+
 static void rtw8821c_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
 {
 	u32 rf_reg18;
@@ -261,9 +302,14 @@ static void rtw8821c_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
 	}
 
 	if (channel <= 14) {
+		if (rtwdev->efuse.rfe_option == 0)
+			rtw8821c_switch_rf_set(rtwdev, SWITCH_TO_WLG);
+		else if (rtwdev->efuse.rfe_option == 2)
+			rtw8821c_switch_rf_set(rtwdev, SWITCH_TO_BTG);
 		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTDBG, BIT(6), 0x1);
 		rtw_write_rf(rtwdev, RF_PATH_A, 0x64, 0xf, 0xf);
 	} else {
+		rtw8821c_switch_rf_set(rtwdev, SWITCH_TO_WLA);
 		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTDBG, BIT(6), 0x0);
 	}
 
@@ -1450,6 +1496,7 @@ static const struct rtw_intf_phy_para_table phy_para_table_8821c = {
 
 static const struct rtw_rfe_def rtw8821c_rfe_defs[] = {
 	[0] = RTW_DEF_RFE(8821c, 0, 0),
+	[2] = RTW_DEF_RFE_EXT(8821c, 0, 0, 2),
 };
 
 static struct rtw_hw_reg rtw8821c_dig[] = {
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.h b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
index 4d197541430d..112faa60f653 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
@@ -181,6 +181,8 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define GET_PHY_STAT_P1_RXSNR_B(phy_stat)                                      \
 	le32_get_bits(*((__le32 *)(phy_stat) + 0x06), GENMASK(15, 8))
 
+#define REG_SYS_CTRL	0x000
+#define BIT_FEN_EN	BIT(26)
 #define REG_INIRTS_RATE_SEL 0x0480
 #define REG_HTSTFWT	0x800
 #define REG_RXPSEL	0x808
@@ -212,6 +214,11 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define REG_FA_CCK	0xa5c
 #define REG_RXDESC	0xa2c
 #define REG_ENTXCCK	0xa80
+#define BTG_LNA		0xfc84
+#define WLG_LNA		0x7532
+#define REG_ENRXCCA	0xa84
+#define BTG_CCA		0x0e
+#define WLG_CCA		0x12
 #define REG_PWRTH2	0xaa8
 #define REG_CSRATIO	0xaaa
 #define REG_TXFILTER	0xaac
@@ -225,6 +232,11 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define REG_RFESEL0	0xcb0
 #define REG_RFESEL8	0xcb4
 #define REG_RFECTL	0xcb8
+#define B_BTG_SWITCH	BIT(16)
+#define B_CTRL_SWITCH	BIT(18)
+#define B_WL_SWITCH	(BIT(20) | BIT(22))
+#define B_WLG_SWITCH	BIT(21)
+#define B_WLA_SWITCH	BIT(23)
 #define REG_RFEINV	0xcbc
 #define REG_AGCTR_B	0xe08
 #define REG_RXIGI_B	0xe50
@@ -235,6 +247,8 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define REG_CCA_OFDM	0xf08
 #define REG_FA_OFDM	0xf48
 #define REG_CCA_CCK	0xfcc
+#define REG_DMEM_CTRL	0x1080
+#define BIT_WL_RST	BIT(16)
 #define REG_ANTWT	0x1904
 #define REG_IQKFAILMSK	0x1bf0
 #define BIT_MASK_R_RFE_SEL_15	GENMASK(31, 28)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c_table.c b/drivers/net/wireless/realtek/rtw88/rtw8821c_table.c
index 970f903f7dc7..8e8915c5c498 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c_table.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c_table.c
@@ -1342,6 +1342,399 @@ static const u32 rtw8821c_agc[] = {
 
 RTW_DECL_TABLE_PHY_COND(rtw8821c_agc, rtw_phy_cfg_agc);
 
+static const u32 rtw8821c_agc_btg_type2[] = {
+	0x80001004,	0x00000000,	0x40000000,	0x00000000,
+	0x81C, 0xFF000013,
+	0x81C, 0xFE020013,
+	0x81C, 0xFD040013,
+	0x81C, 0xFC060013,
+	0x81C, 0xFB080013,
+	0x81C, 0xFA0A0013,
+	0x81C, 0xF90C0013,
+	0x81C, 0xF80E0013,
+	0x81C, 0xF7100013,
+	0x81C, 0xF6120013,
+	0x81C, 0xF5140013,
+	0x81C, 0xF4160013,
+	0x81C, 0xF3180013,
+	0x81C, 0xF21A0013,
+	0x81C, 0xF11C0013,
+	0x81C, 0xF01E0013,
+	0x81C, 0xEF200013,
+	0x81C, 0xEE220013,
+	0x81C, 0xED240013,
+	0x81C, 0xEC260013,
+	0x81C, 0xEB280013,
+	0x81C, 0xEA2A0013,
+	0x81C, 0xE92C0013,
+	0x81C, 0xE82E0013,
+	0x81C, 0xE7300013,
+	0x81C, 0x8B320013,
+	0x81C, 0x8A340013,
+	0x81C, 0x89360013,
+	0x81C, 0x88380013,
+	0x81C, 0x873A0013,
+	0x81C, 0x863C0013,
+	0x81C, 0x853E0013,
+	0x81C, 0x84400013,
+	0x81C, 0x83420013,
+	0x81C, 0x82440013,
+	0x81C, 0x81460013,
+	0x81C, 0x08480013,
+	0x81C, 0x074A0013,
+	0x81C, 0x064C0013,
+	0x81C, 0x054E0013,
+	0x81C, 0x04500013,
+	0x81C, 0x03520013,
+	0x81C, 0x88540003,
+	0x81C, 0x87560003,
+	0x81C, 0x86580003,
+	0x81C, 0x855A0003,
+	0x81C, 0x845C0003,
+	0x81C, 0x835E0003,
+	0x81C, 0x82600003,
+	0x81C, 0x81620003,
+	0x81C, 0x07640003,
+	0x81C, 0x06660003,
+	0x81C, 0x05680003,
+	0x81C, 0x046A0003,
+	0x81C, 0x036C0003,
+	0x81C, 0x026E0003,
+	0x81C, 0x01700003,
+	0x81C, 0x01720003,
+	0x81C, 0x01740003,
+	0x81C, 0x01760003,
+	0x81C, 0x01780003,
+	0x81C, 0x017A0003,
+	0x81C, 0x017C0003,
+	0x81C, 0x017E0003,
+	0x81C, 0xFF000813,
+	0x81C, 0xFE020813,
+	0x81C, 0xFD040813,
+	0x81C, 0xFC060813,
+	0x81C, 0xFB080813,
+	0x81C, 0xFA0A0813,
+	0x81C, 0xF90C0813,
+	0x81C, 0xF80E0813,
+	0x81C, 0xF7100813,
+	0x81C, 0xF6120813,
+	0x81C, 0xF5140813,
+	0x81C, 0xF4160813,
+	0x81C, 0xF3180813,
+	0x81C, 0xF21A0813,
+	0x81C, 0xF11C0813,
+	0x81C, 0x941E0813,
+	0x81C, 0x93200813,
+	0x81C, 0x92220813,
+	0x81C, 0x91240813,
+	0x81C, 0x90260813,
+	0x81C, 0x8F280813,
+	0x81C, 0x8E2A0813,
+	0x81C, 0x8D2C0813,
+	0x81C, 0x8C2E0813,
+	0x81C, 0x8B300813,
+	0x81C, 0x8A320813,
+	0x81C, 0x89340813,
+	0x81C, 0x88360813,
+	0x81C, 0x87380813,
+	0x81C, 0x863A0813,
+	0x81C, 0x853C0813,
+	0x81C, 0x843E0813,
+	0x81C, 0x83400813,
+	0x81C, 0x82420813,
+	0x81C, 0x81440813,
+	0x81C, 0x07460813,
+	0x81C, 0x06480813,
+	0x81C, 0x054A0813,
+	0x81C, 0x044C0813,
+	0x81C, 0x034E0813,
+	0x81C, 0x02500813,
+	0x81C, 0x01520813,
+	0x81C, 0x88540803,
+	0x81C, 0x87560803,
+	0x81C, 0x86580803,
+	0x81C, 0x855A0803,
+	0x81C, 0x845C0803,
+	0x81C, 0x835E0803,
+	0x81C, 0x82600803,
+	0x81C, 0x81620803,
+	0x81C, 0x07640803,
+	0x81C, 0x06660803,
+	0x81C, 0x05680803,
+	0x81C, 0x046A0803,
+	0x81C, 0x036C0803,
+	0x81C, 0x026E0803,
+	0x81C, 0x01700803,
+	0x81C, 0x01720803,
+	0x81C, 0x01740803,
+	0x81C, 0x01760803,
+	0x81C, 0x01780803,
+	0x81C, 0x017A0803,
+	0x81C, 0x017C0803,
+	0x81C, 0x017E0803,
+	0x90001005,	0x00000000,	0x40000000,	0x00000000,
+	0x81C, 0xFF000013,
+	0x81C, 0xFE020013,
+	0x81C, 0xFD040013,
+	0x81C, 0xFC060013,
+	0x81C, 0xFB080013,
+	0x81C, 0xFA0A0013,
+	0x81C, 0xF90C0013,
+	0x81C, 0xF80E0013,
+	0x81C, 0xF7100013,
+	0x81C, 0xF6120013,
+	0x81C, 0xF5140013,
+	0x81C, 0xF4160013,
+	0x81C, 0xF3180013,
+	0x81C, 0xF21A0013,
+	0x81C, 0xF11C0013,
+	0x81C, 0xF01E0013,
+	0x81C, 0xEF200013,
+	0x81C, 0xEE220013,
+	0x81C, 0xED240013,
+	0x81C, 0xEC260013,
+	0x81C, 0xEB280013,
+	0x81C, 0xEA2A0013,
+	0x81C, 0xE92C0013,
+	0x81C, 0xE82E0013,
+	0x81C, 0xE7300013,
+	0x81C, 0x8B320013,
+	0x81C, 0x8A340013,
+	0x81C, 0x89360013,
+	0x81C, 0x88380013,
+	0x81C, 0x873A0013,
+	0x81C, 0x863C0013,
+	0x81C, 0x853E0013,
+	0x81C, 0x84400013,
+	0x81C, 0x83420013,
+	0x81C, 0x82440013,
+	0x81C, 0x81460013,
+	0x81C, 0x08480013,
+	0x81C, 0x074A0013,
+	0x81C, 0x064C0013,
+	0x81C, 0x054E0013,
+	0x81C, 0x04500013,
+	0x81C, 0x03520013,
+	0x81C, 0x88540003,
+	0x81C, 0x87560003,
+	0x81C, 0x86580003,
+	0x81C, 0x855A0003,
+	0x81C, 0x845C0003,
+	0x81C, 0x835E0003,
+	0x81C, 0x82600003,
+	0x81C, 0x81620003,
+	0x81C, 0x07640003,
+	0x81C, 0x06660003,
+	0x81C, 0x05680003,
+	0x81C, 0x046A0003,
+	0x81C, 0x036C0003,
+	0x81C, 0x026E0003,
+	0x81C, 0x01700003,
+	0x81C, 0x01720003,
+	0x81C, 0x01740003,
+	0x81C, 0x01760003,
+	0x81C, 0x01780003,
+	0x81C, 0x017A0003,
+	0x81C, 0x017C0003,
+	0x81C, 0x017E0003,
+	0x81C, 0xFF000813,
+	0x81C, 0xFE020813,
+	0x81C, 0xFD040813,
+	0x81C, 0xFC060813,
+	0x81C, 0xFB080813,
+	0x81C, 0xFA0A0813,
+	0x81C, 0xF90C0813,
+	0x81C, 0xF80E0813,
+	0x81C, 0xF7100813,
+	0x81C, 0xF6120813,
+	0x81C, 0xF5140813,
+	0x81C, 0xF4160813,
+	0x81C, 0xF3180813,
+	0x81C, 0xF21A0813,
+	0x81C, 0xF11C0813,
+	0x81C, 0x941E0813,
+	0x81C, 0x93200813,
+	0x81C, 0x92220813,
+	0x81C, 0x91240813,
+	0x81C, 0x90260813,
+	0x81C, 0x8F280813,
+	0x81C, 0x8E2A0813,
+	0x81C, 0x8D2C0813,
+	0x81C, 0x8C2E0813,
+	0x81C, 0x8B300813,
+	0x81C, 0x8A320813,
+	0x81C, 0x89340813,
+	0x81C, 0x88360813,
+	0x81C, 0x87380813,
+	0x81C, 0x863A0813,
+	0x81C, 0x853C0813,
+	0x81C, 0x843E0813,
+	0x81C, 0x83400813,
+	0x81C, 0x82420813,
+	0x81C, 0x81440813,
+	0x81C, 0x07460813,
+	0x81C, 0x06480813,
+	0x81C, 0x054A0813,
+	0x81C, 0x044C0813,
+	0x81C, 0x034E0813,
+	0x81C, 0x02500813,
+	0x81C, 0x01520813,
+	0x81C, 0x88540803,
+	0x81C, 0x87560803,
+	0x81C, 0x86580803,
+	0x81C, 0x855A0803,
+	0x81C, 0x845C0803,
+	0x81C, 0x835E0803,
+	0x81C, 0x82600803,
+	0x81C, 0x81620803,
+	0x81C, 0x07640803,
+	0x81C, 0x06660803,
+	0x81C, 0x05680803,
+	0x81C, 0x046A0803,
+	0x81C, 0x036C0803,
+	0x81C, 0x026E0803,
+	0x81C, 0x01700803,
+	0x81C, 0x01720803,
+	0x81C, 0x01740803,
+	0x81C, 0x01760803,
+	0x81C, 0x01780803,
+	0x81C, 0x017A0803,
+	0x81C, 0x017C0803,
+	0x81C, 0x017E0803,
+	0xA0000000,	0x00000000,
+	0x81C, 0xFF000013,
+	0x81C, 0xFE020013,
+	0x81C, 0xFD040013,
+	0x81C, 0xFC060013,
+	0x81C, 0xFB080013,
+	0x81C, 0xFA0A0013,
+	0x81C, 0xF90C0013,
+	0x81C, 0xF80E0013,
+	0x81C, 0xF7100013,
+	0x81C, 0xF6120013,
+	0x81C, 0xF5140013,
+	0x81C, 0xF4160013,
+	0x81C, 0xF3180013,
+	0x81C, 0xF21A0013,
+	0x81C, 0xF11C0013,
+	0x81C, 0xF01E0013,
+	0x81C, 0xEF200013,
+	0x81C, 0xEE220013,
+	0x81C, 0xED240013,
+	0x81C, 0xEC260013,
+	0x81C, 0xEB280013,
+	0x81C, 0xEA2A0013,
+	0x81C, 0xE92C0013,
+	0x81C, 0xE82E0013,
+	0x81C, 0xE7300013,
+	0x81C, 0x8A320013,
+	0x81C, 0x89340013,
+	0x81C, 0x88360013,
+	0x81C, 0x87380013,
+	0x81C, 0x863A0013,
+	0x81C, 0x853C0013,
+	0x81C, 0x843E0013,
+	0x81C, 0x83400013,
+	0x81C, 0x82420013,
+	0x81C, 0x81440013,
+	0x81C, 0x07460013,
+	0x81C, 0x06480013,
+	0x81C, 0x054A0013,
+	0x81C, 0x044C0013,
+	0x81C, 0x034E0013,
+	0x81C, 0x02500013,
+	0x81C, 0x01520013,
+	0x81C, 0x88540003,
+	0x81C, 0x87560003,
+	0x81C, 0x86580003,
+	0x81C, 0x855A0003,
+	0x81C, 0x845C0003,
+	0x81C, 0x835E0003,
+	0x81C, 0x82600003,
+	0x81C, 0x81620003,
+	0x81C, 0x07640003,
+	0x81C, 0x06660003,
+	0x81C, 0x05680003,
+	0x81C, 0x046A0003,
+	0x81C, 0x036C0003,
+	0x81C, 0x026E0003,
+	0x81C, 0x01700003,
+	0x81C, 0x01720003,
+	0x81C, 0x01740003,
+	0x81C, 0x01760003,
+	0x81C, 0x01780003,
+	0x81C, 0x017A0003,
+	0x81C, 0x017C0003,
+	0x81C, 0x017E0003,
+	0x81C, 0xFF000813,
+	0x81C, 0xFE020813,
+	0x81C, 0xFD040813,
+	0x81C, 0xFC060813,
+	0x81C, 0xFB080813,
+	0x81C, 0xFA0A0813,
+	0x81C, 0xF90C0813,
+	0x81C, 0xF80E0813,
+	0x81C, 0xF7100813,
+	0x81C, 0xF6120813,
+	0x81C, 0xF5140813,
+	0x81C, 0xF4160813,
+	0x81C, 0xF3180813,
+	0x81C, 0xF21A0813,
+	0x81C, 0xF11C0813,
+	0x81C, 0x961E0813,
+	0x81C, 0x95200813,
+	0x81C, 0x94220813,
+	0x81C, 0x93240813,
+	0x81C, 0x92260813,
+	0x81C, 0x91280813,
+	0x81C, 0x8F2A0813,
+	0x81C, 0x8E2C0813,
+	0x81C, 0x8D2E0813,
+	0x81C, 0x8C300813,
+	0x81C, 0x8B320813,
+	0x81C, 0x8A340813,
+	0x81C, 0x89360813,
+	0x81C, 0x88380813,
+	0x81C, 0x873A0813,
+	0x81C, 0x863C0813,
+	0x81C, 0x853E0813,
+	0x81C, 0x84400813,
+	0x81C, 0x83420813,
+	0x81C, 0x82440813,
+	0x81C, 0x08460813,
+	0x81C, 0x07480813,
+	0x81C, 0x064A0813,
+	0x81C, 0x054C0813,
+	0x81C, 0x044E0813,
+	0x81C, 0x03500813,
+	0x81C, 0x02520813,
+	0x81C, 0x89540803,
+	0x81C, 0x88560803,
+	0x81C, 0x87580803,
+	0x81C, 0x865A0803,
+	0x81C, 0x855C0803,
+	0x81C, 0x845E0803,
+	0x81C, 0x83600803,
+	0x81C, 0x82620803,
+	0x81C, 0x07640803,
+	0x81C, 0x06660803,
+	0x81C, 0x05680803,
+	0x81C, 0x046A0803,
+	0x81C, 0x036C0803,
+	0x81C, 0x026E0803,
+	0x81C, 0x01700803,
+	0x81C, 0x01720803,
+	0x81C, 0x01740803,
+	0x81C, 0x01760803,
+	0x81C, 0x01780803,
+	0x81C, 0x017A0803,
+	0x81C, 0x017C0803,
+	0x81C, 0x017E0803,
+	0xB0000000,	0x00000000,
+};
+
+RTW_DECL_TABLE_PHY_COND(rtw8821c_agc_btg_type2, rtw_phy_cfg_agc);
+
 static const u32 rtw8821c_bb[] = {
 	0x800, 0x9020D010,
 	0x804, 0x80018180,
@@ -1394,7 +1787,11 @@ static const u32 rtw8821c_bb[] = {
 	0x8C0, 0xFFE04020,
 	0x8C4, 0x47C00000,
 	0x8C8, 0x00025165,
+	0x82000400,	0x00000000,	0x40000000,	0x00000000,
+	0x8CC, 0x08190492,
+	0xA0000000,	0x00000000,
 	0x8CC, 0x08188492,
+	0xB0000000,	0x00000000,
 	0x8D0, 0x0000B800,
 	0x8D4, 0x860308A0,
 	0x8D8, 0x290B5612,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c_table.h b/drivers/net/wireless/realtek/rtw88/rtw8821c_table.h
index 5ea8b4fc7fba..cda98f5c4a01 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c_table.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c_table.h
@@ -7,6 +7,7 @@
 
 extern const struct rtw_table rtw8821c_mac_tbl;
 extern const struct rtw_table rtw8821c_agc_tbl;
+extern const struct rtw_table rtw8821c_agc_btg_type2_tbl;
 extern const struct rtw_table rtw8821c_bb_tbl;
 extern const struct rtw_table rtw8821c_bb_pg_type0_tbl;
 extern const struct rtw_table rtw8821c_rf_a_tbl;
-- 
2.21.0

