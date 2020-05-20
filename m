Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2631DA9CD
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 07:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgETFXq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 01:23:46 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:38473 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgETFXq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 01:23:46 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04K5NdSC2011954, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04K5NdSC2011954
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 20 May 2020 13:23:39 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 20 May 2020 13:23:39 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 20 May 2020 13:23:39 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>
Subject: [PATCH 4/7] rtw88: 8821c: add set channel support
Date:   Wed, 20 May 2020 13:23:32 +0800
Message-ID: <20200520052335.22466-5-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520052335.22466-1-yhchuang@realtek.com>
References: <20200520052335.22466-1-yhchuang@realtek.com>
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

To let 8821c connect to change to different 2.4G and 5G channels,
this commit implements the callback function for set channel.
Set the required chip setting for 8821c, which includes mac, bb and
rf related settings.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c     |   4 +
 drivers/net/wireless/realtek/rtw88/main.h     |   5 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 205 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |  14 ++
 4 files changed, 228 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index f88a7d2370aa..f8345c45ed8e 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1309,6 +1309,10 @@ static int rtw_chip_efuse_info_setup(struct rtw_dev *rtwdev)
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
index 32c616c301f4..7b6488406836 100644
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
@@ -1526,6 +1529,8 @@ struct rtw_efuse {
 	u8 apa_type;
 	bool ext_pa_2g;
 	bool ext_pa_5g;
+	u8 tx_bb_swing_setting_2g;
+	u8 tx_bb_swing_setting_5g;
 
 	bool btcoex;
 	/* bt share antenna with wifi */
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index df95a095df73..e3b52caf9ab3 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -94,6 +94,9 @@ static void rtw8821c_phy_set_param(struct rtw_dev *rtwdev)
 
 	/* post init after header files config */
 	rtw_write32_set(rtwdev, REG_RXPSEL, BIT_RX_PSEL_RST);
+	rtwdev->chip->ch_param[0] = rtw_read32_mask(rtwdev, REG_TXSF2, MASKDWORD);
+	rtwdev->chip->ch_param[1] = rtw_read32_mask(rtwdev, REG_TXSF6, MASKDWORD);
+	rtwdev->chip->ch_param[2] = rtw_read32_mask(rtwdev, 0xaac, MASKDWORD);
 
 	rtw_phy_init(rtwdev);
 }
@@ -162,6 +165,207 @@ static void rtw8821c_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
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
+			rtw_write32_mask(rtwdev, 0xaac, MASKDWORD, 0x00003667);
+		} else {
+			rtw_write32_mask(rtwdev, REG_TXSF2, MASKDWORD,
+					 rtwdev->chip->ch_param[0]);
+			rtw_write32_mask(rtwdev, REG_TXSF6, MASKLWORD,
+					 rtwdev->chip->ch_param[1] & MASKLWORD);
+			rtw_write32_mask(rtwdev, 0xaac, MASKDWORD,
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
@@ -629,6 +833,7 @@ static struct rtw_prioq_addrs prioq_addrs_8821c = {
 static struct rtw_chip_ops rtw8821c_ops = {
 	.phy_set_param		= rtw8821c_phy_set_param,
 	.read_efuse		= rtw8821c_read_efuse,
+	.set_channel		= rtw8821c_set_channel,
 	.mac_init		= rtw8821c_mac_init,
 	.read_rf		= rtw_phy_read_rf,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.h b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
index 1c357e2b099b..b30487640828 100644
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
@@ -173,6 +174,7 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define REG_RXDESC	0xa2c
 #define REG_ENTXCCK	0xa80
 #define REG_AGCTR_A	0xc08
+#define REG_TXSCALE_A	0xc1c
 #define REG_TXDFIR	0xc20
 #define REG_RXIGI_A	0xc50
 #define REG_TRSW	0xca0
@@ -185,4 +187,16 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
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

