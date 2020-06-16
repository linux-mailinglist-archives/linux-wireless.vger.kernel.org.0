Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398D41FAC20
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgFPJQy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 05:16:54 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46542 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbgFPJQs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 05:16:48 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 05G9GW6f8021732, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 05G9GW6f8021732
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Jun 2020 17:16:32 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 16 Jun 2020 17:16:32 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 16 Jun 2020 17:16:32 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v4 4/7] rtw88: 8821c: add set channel support
Date:   Tue, 16 Jun 2020 17:16:22 +0800
Message-ID: <20200616091625.26489-5-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616091625.26489-1-yhchuang@realtek.com>
References: <20200616091625.26489-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

8821c is capable of 2.4G and 5G.

Implement rtw_chip_ops::set_channel() to set 2G and 5G channels.
This includes MAC, BB and RF related settings.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c     |   4 +
 drivers/net/wireless/realtek/rtw88/main.h     |   5 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 205 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |  15 ++
 4 files changed, 229 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 0eefafc51c62..d5677f94170f 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1326,6 +1326,10 @@ static int rtw_chip_efuse_info_setup(struct rtw_dev *rtwdev)
 		efuse->share_ant = true;
 	if (efuse->regd == 0xff)
 		efuse->regd = 0;
+	if (efuse->tx_bb_swing_setting_2g == 0xff)
+		efuse->tx_bb_swing_setting_2g = 0;
+	if (efuse->tx_bb_swing_setting_5g == 0xff)
+		efuse->tx_bb_swing_setting_5g = 0;
 
 	efuse->btcoex = (efuse->rf_board_option & 0xe0) == 0x20;
 	efuse->ext_pa_2g = efuse->pa_type_2g & BIT(4) ? 1 : 0;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 8f6e10acd65f..82b6accf4744 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1148,6 +1148,9 @@ struct rtw_chip_info {
 	const struct wiphy_wowlan_support *wowlan_stub;
 	const u8 max_sched_scan_ssids;
 
+	/* for 8821c set channel */
+	u32 ch_param[3];
+
 	/* coex paras */
 	u32 coex_para_ver;
 	u8 bt_desired_ver;
@@ -1527,6 +1530,8 @@ struct rtw_efuse {
 	u8 apa_type;
 	bool ext_pa_2g;
 	bool ext_pa_5g;
+	u8 tx_bb_swing_setting_2g;
+	u8 tx_bb_swing_setting_5g;
 
 	bool btcoex;
 	/* bt share antenna with wifi */
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index dfce8f6cb5fc..4c27d28a9f9d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -97,6 +97,9 @@ static void rtw8821c_phy_set_param(struct rtw_dev *rtwdev)
 
 	/* post init after header files config */
 	rtw_write32_set(rtwdev, REG_RXPSEL, BIT_RX_PSEL_RST);
+	rtwdev->chip->ch_param[0] = rtw_read32_mask(rtwdev, REG_TXSF2, MASKDWORD);
+	rtwdev->chip->ch_param[1] = rtw_read32_mask(rtwdev, REG_TXSF6, MASKDWORD);
+	rtwdev->chip->ch_param[2] = rtw_read32_mask(rtwdev, REG_TXFILTER, MASKDWORD);
 
 	rtw_phy_init(rtwdev);
 }
@@ -169,6 +172,207 @@ static void rtw8821c_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 	rtw_write8(rtwdev, REG_LDO_EFUSE_CTRL + 3, ldo_pwr);
 }
 
+static void rtw8821c_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
+{
+	u32 rf_reg18;
+
+	rf_reg18 = rtw_read_rf(rtwdev, RF_PATH_A, 0x18, RFREG_MASK);
+
+	rf_reg18 &= ~(RF18_BAND_MASK | RF18_CHANNEL_MASK | RF18_RFSI_MASK |
+		      RF18_BW_MASK);
+
+	rf_reg18 |= (channel <= 14 ? RF18_BAND_2G : RF18_BAND_5G);
+	rf_reg18 |= (channel & RF18_CHANNEL_MASK);
+
+	if (channel >= 100 && channel <= 140)
+		rf_reg18 |= RF18_RFSI_GE;
+	else if (channel > 140)
+		rf_reg18 |= RF18_RFSI_GT;
+
+	switch (bw) {
+	case RTW_CHANNEL_WIDTH_5:
+	case RTW_CHANNEL_WIDTH_10:
+	case RTW_CHANNEL_WIDTH_20:
+	default:
+		rf_reg18 |= RF18_BW_20M;
+		break;
+	case RTW_CHANNEL_WIDTH_40:
+		rf_reg18 |= RF18_BW_40M;
+		break;
+	case RTW_CHANNEL_WIDTH_80:
+		rf_reg18 |= RF18_BW_80M;
+		break;
+	}
+
+	if (channel <= 14) {
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTDBG, BIT(6), 0x1);
+		rtw_write_rf(rtwdev, RF_PATH_A, 0x64, 0xf, 0xf);
+	} else {
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTDBG, BIT(6), 0x0);
+	}
+
+	rtw_write_rf(rtwdev, RF_PATH_A, 0x18, RFREG_MASK, rf_reg18);
+
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_XTALX2, BIT(19), 0);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_XTALX2, BIT(19), 1);
+}
+
+static void rtw8821c_set_channel_rxdfir(struct rtw_dev *rtwdev, u8 bw)
+{
+	if (bw == RTW_CHANNEL_WIDTH_40) {
+		/* RX DFIR for BW40 */
+		rtw_write32_mask(rtwdev, REG_ACBB0, BIT(29) | BIT(28), 0x2);
+		rtw_write32_mask(rtwdev, REG_ACBBRXFIR, BIT(29) | BIT(28), 0x2);
+		rtw_write32_mask(rtwdev, REG_TXDFIR, BIT(31), 0x0);
+		rtw_write32_mask(rtwdev, REG_CHFIR, BIT(31), 0x0);
+	} else if (bw == RTW_CHANNEL_WIDTH_80) {
+		/* RX DFIR for BW80 */
+		rtw_write32_mask(rtwdev, REG_ACBB0, BIT(29) | BIT(28), 0x2);
+		rtw_write32_mask(rtwdev, REG_ACBBRXFIR, BIT(29) | BIT(28), 0x1);
+		rtw_write32_mask(rtwdev, REG_TXDFIR, BIT(31), 0x0);
+		rtw_write32_mask(rtwdev, REG_CHFIR, BIT(31), 0x1);
+	} else {
+		/* RX DFIR for BW20, BW10 and BW5 */
+		rtw_write32_mask(rtwdev, REG_ACBB0, BIT(29) | BIT(28), 0x2);
+		rtw_write32_mask(rtwdev, REG_ACBBRXFIR, BIT(29) | BIT(28), 0x2);
+		rtw_write32_mask(rtwdev, REG_TXDFIR, BIT(31), 0x1);
+		rtw_write32_mask(rtwdev, REG_CHFIR, BIT(31), 0x0);
+	}
+}
+
+static void rtw8821c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
+				    u8 primary_ch_idx)
+{
+	u32 val32;
+
+	if (channel <= 14) {
+		rtw_write32_mask(rtwdev, REG_RXPSEL, BIT(28), 0x1);
+		rtw_write32_mask(rtwdev, REG_CCK_CHECK, BIT(7), 0x0);
+		rtw_write32_mask(rtwdev, REG_ENTXCCK, BIT(18), 0x0);
+		rtw_write32_mask(rtwdev, REG_RXCCAMSK, 0x0000FC00, 15);
+
+		rtw_write32_mask(rtwdev, REG_TXSCALE_A, 0xf00, 0x0);
+		rtw_write32_mask(rtwdev, REG_CLKTRK, 0x1ffe0000, 0x96a);
+		if (channel == 14) {
+			rtw_write32_mask(rtwdev, REG_TXSF2, MASKDWORD, 0x0000b81c);
+			rtw_write32_mask(rtwdev, REG_TXSF6, MASKLWORD, 0x0000);
+			rtw_write32_mask(rtwdev, REG_TXFILTER, MASKDWORD, 0x00003667);
+		} else {
+			rtw_write32_mask(rtwdev, REG_TXSF2, MASKDWORD,
+					 rtwdev->chip->ch_param[0]);
+			rtw_write32_mask(rtwdev, REG_TXSF6, MASKLWORD,
+					 rtwdev->chip->ch_param[1] & MASKLWORD);
+			rtw_write32_mask(rtwdev, REG_TXFILTER, MASKDWORD,
+					 rtwdev->chip->ch_param[2]);
+		}
+	} else if (channel > 35) {
+		rtw_write32_mask(rtwdev, REG_ENTXCCK, BIT(18), 0x1);
+		rtw_write32_mask(rtwdev, REG_CCK_CHECK, BIT(7), 0x1);
+		rtw_write32_mask(rtwdev, REG_RXPSEL, BIT(28), 0x0);
+		rtw_write32_mask(rtwdev, REG_RXCCAMSK, 0x0000FC00, 15);
+
+		if (channel >= 36 && channel <= 64)
+			rtw_write32_mask(rtwdev, REG_TXSCALE_A, 0xf00, 0x1);
+		else if (channel >= 100 && channel <= 144)
+			rtw_write32_mask(rtwdev, REG_TXSCALE_A, 0xf00, 0x2);
+		else if (channel >= 149)
+			rtw_write32_mask(rtwdev, REG_TXSCALE_A, 0xf00, 0x3);
+
+		if (channel >= 36 && channel <= 48)
+			rtw_write32_mask(rtwdev, REG_CLKTRK, 0x1ffe0000, 0x494);
+		else if (channel >= 52 && channel <= 64)
+			rtw_write32_mask(rtwdev, REG_CLKTRK, 0x1ffe0000, 0x453);
+		else if (channel >= 100 && channel <= 116)
+			rtw_write32_mask(rtwdev, REG_CLKTRK, 0x1ffe0000, 0x452);
+		else if (channel >= 118 && channel <= 177)
+			rtw_write32_mask(rtwdev, REG_CLKTRK, 0x1ffe0000, 0x412);
+	}
+
+	switch (bw) {
+	case RTW_CHANNEL_WIDTH_20:
+	default:
+		val32 = rtw_read32_mask(rtwdev, REG_ADCCLK, MASKDWORD);
+		val32 &= 0xffcffc00;
+		val32 |= 0x10010000;
+		rtw_write32_mask(rtwdev, REG_ADCCLK, MASKDWORD, val32);
+
+		rtw_write32_mask(rtwdev, REG_ADC160, BIT(30), 0x1);
+		break;
+	case RTW_CHANNEL_WIDTH_40:
+		if (primary_ch_idx == 1)
+			rtw_write32_set(rtwdev, REG_RXSB, BIT(4));
+		else
+			rtw_write32_clr(rtwdev, REG_RXSB, BIT(4));
+
+		val32 = rtw_read32_mask(rtwdev, REG_ADCCLK, MASKDWORD);
+		val32 &= 0xff3ff300;
+		val32 |= 0x20020000 | ((primary_ch_idx & 0xf) << 2) |
+			 RTW_CHANNEL_WIDTH_40;
+		rtw_write32_mask(rtwdev, REG_ADCCLK, MASKDWORD, val32);
+
+		rtw_write32_mask(rtwdev, REG_ADC160, BIT(30), 0x1);
+		break;
+	case RTW_CHANNEL_WIDTH_80:
+		val32 = rtw_read32_mask(rtwdev, REG_ADCCLK, MASKDWORD);
+		val32 &= 0xfcffcf00;
+		val32 |= 0x40040000 | ((primary_ch_idx & 0xf) << 2) |
+			 RTW_CHANNEL_WIDTH_80;
+		rtw_write32_mask(rtwdev, REG_ADCCLK, MASKDWORD, val32);
+
+		rtw_write32_mask(rtwdev, REG_ADC160, BIT(30), 0x1);
+		break;
+	case RTW_CHANNEL_WIDTH_5:
+		val32 = rtw_read32_mask(rtwdev, REG_ADCCLK, MASKDWORD);
+		val32 &= 0xefcefc00;
+		val32 |= 0x200240;
+		rtw_write32_mask(rtwdev, REG_ADCCLK, MASKDWORD, val32);
+
+		rtw_write32_mask(rtwdev, REG_ADC160, BIT(30), 0x0);
+		rtw_write32_mask(rtwdev, REG_ADC40, BIT(31), 0x1);
+		break;
+	case RTW_CHANNEL_WIDTH_10:
+		val32 = rtw_read32_mask(rtwdev, REG_ADCCLK, MASKDWORD);
+		val32 &= 0xefcefc00;
+		val32 |= 0x300380;
+		rtw_write32_mask(rtwdev, REG_ADCCLK, MASKDWORD, val32);
+
+		rtw_write32_mask(rtwdev, REG_ADC160, BIT(30), 0x0);
+		rtw_write32_mask(rtwdev, REG_ADC40, BIT(31), 0x1);
+		break;
+	}
+}
+
+static u32 rtw8821c_get_bb_swing(struct rtw_dev *rtwdev, u8 channel)
+{
+	struct rtw_efuse efuse = rtwdev->efuse;
+	u8 tx_bb_swing;
+	u32 swing2setting[4] = {0x200, 0x16a, 0x101, 0x0b6};
+
+	tx_bb_swing = channel <= 14 ? efuse.tx_bb_swing_setting_2g :
+				      efuse.tx_bb_swing_setting_5g;
+	if (tx_bb_swing > 9)
+		tx_bb_swing = 0;
+
+	return swing2setting[(tx_bb_swing / 3)];
+}
+
+static void rtw8821c_set_channel_bb_swing(struct rtw_dev *rtwdev, u8 channel,
+					  u8 bw, u8 primary_ch_idx)
+{
+	rtw_write32_mask(rtwdev, REG_TXSCALE_A, GENMASK(31, 21),
+			 rtw8821c_get_bb_swing(rtwdev, channel));
+}
+
+static void rtw8821c_set_channel(struct rtw_dev *rtwdev, u8 channel, u8 bw,
+				 u8 primary_chan_idx)
+{
+	rtw8821c_set_channel_bb(rtwdev, channel, bw, primary_chan_idx);
+	rtw8821c_set_channel_bb_swing(rtwdev, channel, bw, primary_chan_idx);
+	rtw_set_channel_mac(rtwdev, channel, bw, primary_chan_idx);
+	rtw8821c_set_channel_rf(rtwdev, channel, bw);
+	rtw8821c_set_channel_rxdfir(rtwdev, bw);
+}
+
 static void
 rtw8821c_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
 {
@@ -636,6 +840,7 @@ static struct rtw_prioq_addrs prioq_addrs_8821c = {
 static struct rtw_chip_ops rtw8821c_ops = {
 	.phy_set_param		= rtw8821c_phy_set_param,
 	.read_efuse		= rtw8821c_read_efuse,
+	.set_channel		= rtw8821c_set_channel,
 	.mac_init		= rtw8821c_mac_init,
 	.read_rf		= rtw_phy_read_rf,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.h b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
index 1c357e2b099b..2d33f6e50cea 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
@@ -161,6 +161,7 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define REG_ADCCLK	0x8ac
 #define REG_ADC160	0x8c4
 #define REG_ADC40	0x8c8
+#define REG_CHFIR	0x8f0
 #define REG_CDDTXP	0x93c
 #define REG_TXPSEL1	0x940
 #define REG_ACBB0	0x948
@@ -172,7 +173,9 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define REG_TXSF6	0xa28
 #define REG_RXDESC	0xa2c
 #define REG_ENTXCCK	0xa80
+#define REG_TXFILTER	0xaac
 #define REG_AGCTR_A	0xc08
+#define REG_TXSCALE_A	0xc1c
 #define REG_TXDFIR	0xc20
 #define REG_RXIGI_A	0xc50
 #define REG_TRSW	0xca0
@@ -185,4 +188,16 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define REG_ANTWT	0x1904
 #define REG_IQKFAILMSK	0x1bf0
 
+#define RF18_BAND_MASK		(BIT(16) | BIT(9) | BIT(8))
+#define RF18_BAND_2G		(0)
+#define RF18_BAND_5G		(BIT(16) | BIT(8))
+#define RF18_CHANNEL_MASK	(MASKBYTE0)
+#define RF18_RFSI_MASK		(BIT(18) | BIT(17))
+#define RF18_RFSI_GE		(BIT(17))
+#define RF18_RFSI_GT		(BIT(18))
+#define RF18_BW_MASK		(BIT(11) | BIT(10))
+#define RF18_BW_20M		(BIT(11) | BIT(10))
+#define RF18_BW_40M		(BIT(11))
+#define RF18_BW_80M		(BIT(10))
+
 #endif
-- 
2.17.1

