Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8C51B5B71
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 14:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgDWMae (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 08:30:34 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43529 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgDWMae (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 08:30:34 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03NCUQGV0023101, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03NCUQGV0023101
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Apr 2020 20:30:26 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Apr 2020 20:30:25 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Apr 2020 20:30:25 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>
Subject: [PATCH v2 3/8] rtw88: 8723d: Add set_channel
Date:   Thu, 23 Apr 2020 20:30:17 +0800
Message-ID: <20200423123022.10176-4-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423123022.10176-1-yhchuang@realtek.com>
References: <20200423123022.10176-1-yhchuang@realtek.com>
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

Set MAC/BB/RF register according to specified channel. The function
rtw_set_channel_mac() is used to set MAC registers, but 8723D only need
some of them.

For channel 14, we need to set different CCK DFIR values, so restore the
values when channel 1 to 13 is selected.

Spur calibration is needed in channel 13 and 14, and we do notch if spur
is over threshold.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c      |   3 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 185 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  12 ++
 3 files changed, 200 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 645207a01525..c42d0f681dda 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -40,6 +40,9 @@ void rtw_set_channel_mac(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 	}
 	rtw_write32(rtwdev, REG_WMAC_TRXPTCL_CTL, value32);
 
+	if (rtw_chip_wcpu_11n(rtwdev))
+		return;
+
 	value32 = rtw_read32(rtwdev, REG_AFE_CTRL1) & ~(BIT_MAC_CLK_SEL);
 	value32 |= (MAC_CLK_HW_DEF_80M << BIT_SHIFT_MAC_CLK_SEL);
 	rtw_write32(rtwdev, REG_AFE_CTRL1, value32);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 653cfa9445fc..c619ee289561 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -287,6 +287,190 @@ static void rtw8723d_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
 	rtw_rx_fill_rx_status(rtwdev, pkt_stat, hdr, rx_status, phy_status);
 }
 
+static
+bool rtw8723d_check_spur_ov_thres(struct rtw_dev *rtwdev, u8 channel, u32 thres)
+{
+#define DIS_3WIRE	0xccf000c0
+#define EN_3WIRE	0xccc000c0
+#define START_PSD	0x400000
+#define FREQ_CH13	0xFCCD
+#define FREQ_CH14	0xFF9A
+
+	u32 freq;
+	bool ret = false;
+
+	if (channel == 13)
+		freq = FREQ_CH13;
+	else if (channel == 14)
+		freq = FREQ_CH14;
+	else
+		return false;
+
+	rtw_write32(rtwdev, REG_ANALOG_P4, DIS_3WIRE);
+	rtw_write32(rtwdev, REG_PSDFN, freq);
+	rtw_write32(rtwdev, REG_PSDFN, START_PSD | freq);
+
+	msleep(30);
+	if (rtw_read32(rtwdev, REG_PSDRPT) >= thres)
+		ret = true;
+
+	rtw_write32(rtwdev, REG_PSDFN, freq);
+	rtw_write32(rtwdev, REG_ANALOG_P4, EN_3WIRE);
+
+	return ret;
+}
+
+static void rtw8723d_cfg_notch(struct rtw_dev *rtwdev, u8 channel, bool notch)
+{
+#define BIT_MASK_RXDSP	(BIT(28) | BIT(27) | BIT(26) | BIT(25) | BIT(24))
+#define BIT_EN_RXDSP	BIT(9)
+#define BIT_EN_CFOTRK	BIT(28)
+
+	if (!notch)
+		goto no_notch;
+
+	switch (channel) {
+	case 13:
+		rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_MASK_RXDSP, 0xB);
+		rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_EN_RXDSP, 0x1);
+		rtw_write32(rtwdev, REG_OFDM1_CSI1, 0x04000000);
+		rtw_write32(rtwdev, REG_OFDM1_CSI2, 0x00000000);
+		rtw_write32(rtwdev, REG_OFDM1_CSI3, 0x00000000);
+		rtw_write32(rtwdev, REG_OFDM1_CSI4, 0x00000000);
+		rtw_write32_mask(rtwdev, REG_OFDM1_CFOTRK, BIT_EN_CFOTRK, 0x1);
+		break;
+	case 14:
+		rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_MASK_RXDSP, 0x5);
+		rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_EN_RXDSP, 0x1);
+		rtw_write32(rtwdev, REG_OFDM1_CSI1, 0x00000000);
+		rtw_write32(rtwdev, REG_OFDM1_CSI2, 0x00000000);
+		rtw_write32(rtwdev, REG_OFDM1_CSI3, 0x00000000);
+		rtw_write32(rtwdev, REG_OFDM1_CSI4, 0x00080000);
+		rtw_write32_mask(rtwdev, REG_OFDM1_CFOTRK, BIT_EN_CFOTRK, 0x1);
+		break;
+	default:
+		rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_EN_RXDSP, 0x0);
+		rtw_write32_mask(rtwdev, REG_OFDM1_CFOTRK, BIT_EN_CFOTRK, 0x0);
+		break;
+	}
+
+	return;
+
+no_notch:
+	rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_MASK_RXDSP, 0x1f);
+	rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_EN_RXDSP, 0x0);
+	rtw_write32(rtwdev, REG_OFDM1_CSI1, 0x00000000);
+	rtw_write32(rtwdev, REG_OFDM1_CSI2, 0x00000000);
+	rtw_write32(rtwdev, REG_OFDM1_CSI3, 0x00000000);
+	rtw_write32(rtwdev, REG_OFDM1_CSI4, 0x00000000);
+	rtw_write32_mask(rtwdev, REG_OFDM1_CFOTRK, BIT_EN_CFOTRK, 0x0);
+}
+
+static void rtw8723d_spur_cal(struct rtw_dev *rtwdev, u8 channel)
+{
+#define SPUR_THRES	0x16
+	bool notch = false;
+
+	if (channel < 13)
+		goto do_notch;
+
+	notch = rtw8723d_check_spur_ov_thres(rtwdev, channel, SPUR_THRES);
+
+do_notch:
+	rtw8723d_cfg_notch(rtwdev, channel, notch);
+}
+
+static void rtw8723d_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
+{
+#define RFCFGCH_CHANNEL_MASK	GENMASK(7, 0)
+#define RFCFGCH_BW_MASK		(BIT(11) | BIT(10))
+#define RFCFGCH_BW_20M		(BIT(11) | BIT(10))
+#define RFCFGCH_BW_40M		(BIT(10))
+
+	u32 rf_cfgch[2];
+
+	rf_cfgch[0] = rtw_read_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK);
+	rf_cfgch[1] = rtw_read_rf(rtwdev, RF_PATH_B, RF_CFGCH, RFREG_MASK);
+
+	rf_cfgch[0] &= ~RFCFGCH_CHANNEL_MASK;
+	rf_cfgch[1] &= ~RFCFGCH_CHANNEL_MASK;
+	rf_cfgch[0] |= (channel & RFCFGCH_CHANNEL_MASK);
+	rf_cfgch[1] |= (channel & RFCFGCH_CHANNEL_MASK);
+
+	rf_cfgch[0] &= ~RFCFGCH_BW_MASK;
+	switch (bw) {
+	case RTW_CHANNEL_WIDTH_20:
+		rf_cfgch[0] |= RFCFGCH_BW_20M;
+		break;
+	case RTW_CHANNEL_WIDTH_40:
+		rf_cfgch[0] |= RFCFGCH_BW_40M;
+		break;
+	default:
+		break;
+	}
+
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK, rf_cfgch[0]);
+	rtw_write_rf(rtwdev, RF_PATH_B, RF_CFGCH, RFREG_MASK, rf_cfgch[1]);
+
+	rtw8723d_spur_cal(rtwdev, channel);
+}
+
+#define CCK_DFIR_NR	3
+static const struct rtw_backup_info cck_dfir_cfg[][CCK_DFIR_NR] = {
+	[0] = {
+		{ .len = 4, .reg = 0xA24, .val = 0x64B80C1C },
+		{ .len = 4, .reg = 0xA28, .val = 0x00008810 },
+		{ .len = 4, .reg = 0xAAC, .val = 0x01235667 },
+	},
+	[1] = {
+		{ .len = 4, .reg = 0xA24, .val = 0x0000B81C },
+		{ .len = 4, .reg = 0xA28, .val = 0x00000000 },
+		{ .len = 4, .reg = 0xAAC, .val = 0x00003667 },
+	},
+};
+
+static void rtw8723d_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
+				    u8 primary_ch_idx)
+{
+#define BIT_CCK_SIDE_BAND	BIT(4)
+#define BIT_MASK_RFMOD		BIT(0)
+#define BIT_RXBB_DFIR_EN	BIT(19)
+#define BIT_MASK_RXBB_DFIR	(BIT(27) | BIT(26) | BIT(25) | BIT(24))
+
+	const struct rtw_backup_info *cck_dfir =
+			channel <= 13 ? cck_dfir_cfg[0] : cck_dfir_cfg[1];
+	int i;
+
+	for (i = 0; i < CCK_DFIR_NR; i++, cck_dfir++)
+		rtw_write32(rtwdev, cck_dfir->reg, cck_dfir->val);
+
+	switch (bw) {
+	case RTW_CHANNEL_WIDTH_20:
+		rtw_write32_mask(rtwdev, REG_FPGA0_RFMOD, BIT_MASK_RFMOD, 0x0);
+		rtw_write32_mask(rtwdev, REG_FPGA1_RFMOD, BIT_MASK_RFMOD, 0x0);
+		rtw_write32_mask(rtwdev, REG_BBRX_DFIR, BIT_RXBB_DFIR_EN, 1);
+		rtw_write32_mask(rtwdev, REG_BBRX_DFIR, BIT_MASK_RXBB_DFIR, 0xa);
+		break;
+	case RTW_CHANNEL_WIDTH_40:
+		rtw_write32_mask(rtwdev, REG_FPGA0_RFMOD, BIT_MASK_RFMOD, 0x1);
+		rtw_write32_mask(rtwdev, REG_FPGA1_RFMOD, BIT_MASK_RFMOD, 0x1);
+		rtw_write32_mask(rtwdev, REG_BBRX_DFIR, BIT_RXBB_DFIR_EN, 0);
+		rtw_write32_mask(rtwdev, REG_CCK0_SYS, BIT_CCK_SIDE_BAND,
+				 (primary_ch_idx == RTW_SC_20_UPPER ? 1 : 0));
+		break;
+	default:
+		break;
+	}
+}
+
+static void rtw8723d_set_channel(struct rtw_dev *rtwdev, u8 channel, u8 bw,
+				 u8 primary_chan_idx)
+{
+	rtw8723d_set_channel_rf(rtwdev, channel, bw);
+	rtw_set_channel_mac(rtwdev, channel, bw, primary_chan_idx);
+	rtw8723d_set_channel_bb(rtwdev, channel, bw, primary_chan_idx);
+}
+
 #define BIT_CFENDFORM		BIT(9)
 #define BIT_WMAC_TCR_ERR0	BIT(12)
 #define BIT_WMAC_TCR_ERR1	BIT(13)
@@ -383,6 +567,7 @@ static struct rtw_chip_ops rtw8723d_ops = {
 	.phy_set_param		= rtw8723d_phy_set_param,
 	.read_efuse		= rtw8723d_read_efuse,
 	.query_rx_desc		= rtw8723d_query_rx_desc,
+	.set_channel		= rtw8723d_set_channel,
 	.mac_init		= rtw8723d_mac_init,
 	.read_rf		= rtw_phy_read_rf_sipi,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index 035049a29e7c..c08c351ba657 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -66,7 +66,19 @@ struct rtw8723d_efuse {
 #define GET_PHY_STAT_P1_RXSNR_A(phy_stat)                                      \
 	le32_get_bits(*((__le32 *)(phy_stat) + 0x06), GENMASK(7, 0))
 
+#define REG_PSDFN		0x0808
+#define REG_ANALOG_P4		0x088c
+#define REG_PSDRPT		0x08b4
+#define REG_FPGA1_RFMOD		0x0900
+#define REG_BBRX_DFIR		0x0954
+#define REG_CCK0_SYS		0x0a00
+#define REG_OFDM0_RXDSP		0x0c40
 #define REG_OFDM0_XAAGC1	0x0c50
 #define REG_OFDM0_XBAGC1	0x0c58
+#define REG_OFDM1_CFOTRK	0x0d2c
+#define REG_OFDM1_CSI1		0x0d40
+#define REG_OFDM1_CSI2		0x0d44
+#define REG_OFDM1_CSI3		0x0d48
+#define REG_OFDM1_CSI4		0x0d4c
 
 #endif
-- 
2.17.1

