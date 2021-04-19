Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822D13638D4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 02:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhDSAim (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 20:38:42 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:54334 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhDSAim (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 20:38:42 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13J0c7Wu9013530, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13J0c7Wu9013530
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Apr 2021 08:38:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Apr 2021 08:38:06 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 19 Apr
 2021 08:38:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <vincent_fann@realtek.com>
Subject: [PATCH v2 1/3] rtw88: 8822c: reorder macro position according to the register number
Date:   Mon, 19 Apr 2021 08:37:46 +0800
Message-ID: <20210419003748.3224-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210419003748.3224-1-pkshih@realtek.com>
References: <20210419003748.3224-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS03.realtek.com.tw (172.21.6.96) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMTggpFWkyCAwNDowNDowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/19/2021 00:21:51
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163189 [Apr 18 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/19/2021 00:25:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/19/2021 00:21:51
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163189 [Apr 18 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/19/2021 00:25:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Guo-Feng Fan <vincent_fann@realtek.com>

This patch doesn't change logic at all, just a refactor patch.

1. Move BIT MASK and BIT definition along with the register definition
2. Remove redundant definition
3. Align macros with Tab key

Signed-off-by: Guo-Feng Fan <vincent_fann@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  16 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.h | 275 +++++++++---------
 2 files changed, 148 insertions(+), 143 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 9f05c60c8a03..39232a4aa65f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1095,13 +1095,13 @@ static void rtw8822c_pa_bias(struct rtw_dev *rtwdev)
 		if (pg_pa_bias == EFUSE_READ_FAIL)
 			return;
 		pg_pa_bias = FIELD_GET(PPG_PABIAS_MASK, pg_pa_bias);
-		rtw_write_rf(rtwdev, path, 0x60, RF_PABIAS_2G_MASK, pg_pa_bias);
+		rtw_write_rf(rtwdev, path, RF_PA, RF_PABIAS_2G_MASK, pg_pa_bias);
 	}
 	for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
 		rtw_read8_physical_efuse(rtwdev, rf_efuse_5g[path],
 					 &pg_pa_bias);
 		pg_pa_bias = FIELD_GET(PPG_PABIAS_MASK, pg_pa_bias);
-		rtw_write_rf(rtwdev, path, 0x60, RF_PABIAS_5G_MASK, pg_pa_bias);
+		rtw_write_rf(rtwdev, path, RF_PA, RF_PABIAS_5G_MASK, pg_pa_bias);
 	}
 }
 
@@ -2546,9 +2546,9 @@ static void rtw8822c_dpk_pre_setting(struct rtw_dev *rtwdev)
 		rtw_write_rf(rtwdev, path, RF_RXAGC_OFFSET, RFREG_MASK, 0x0);
 		rtw_write32(rtwdev, REG_NCTL0, 0x8 | (path << 1));
 		if (rtwdev->dm_info.dpk_info.dpk_band == RTW_BAND_2G)
-			rtw_write32(rtwdev, REG_DPD_LUT3, 0x1f100000);
+			rtw_write32(rtwdev, REG_DPD_CTL1_S1, 0x1f100000);
 		else
-			rtw_write32(rtwdev, REG_DPD_LUT3, 0x1f0d0000);
+			rtw_write32(rtwdev, REG_DPD_CTL1_S1, 0x1f0d0000);
 		rtw_write32_mask(rtwdev, REG_DPD_LUT0, BIT_GLOSS_DB, 0x4);
 		rtw_write32_mask(rtwdev, REG_IQK_CTL1, BIT_TX_CFIR, 0x3);
 	}
@@ -2566,11 +2566,11 @@ static u32 rtw8822c_dpk_rf_setting(struct rtw_dev *rtwdev, u8 path)
 
 	rtw_write_rf(rtwdev, path, RF_DEBUG, BIT_DE_TX_GAIN, 0x1);
 	rtw_write_rf(rtwdev, path, RF_DEBUG, BIT_DE_PWR_TRIM, 0x1);
-	rtw_write_rf(rtwdev, path, RF_TX_GAIN_OFFSET, BIT_TX_OFFSET_VAL, 0x0);
+	rtw_write_rf(rtwdev, path, RF_TX_GAIN_OFFSET, BIT_BB_GAIN, 0x0);
 	rtw_write_rf(rtwdev, path, RF_TX_GAIN, RFREG_MASK, ori_txbb);
 
 	if (rtwdev->dm_info.dpk_info.dpk_band == RTW_BAND_2G) {
-		rtw_write_rf(rtwdev, path, RF_TX_GAIN_OFFSET, BIT_LB_ATT, 0x1);
+		rtw_write_rf(rtwdev, path, RF_TX_GAIN_OFFSET, BIT_RF_GAIN, 0x1);
 		rtw_write_rf(rtwdev, path, RF_RXG_GAIN, BIT_RXG_GAIN, 0x0);
 	} else {
 		rtw_write_rf(rtwdev, path, RF_TXA_LB_SW, BIT_TXA_LB_ATT, 0x0);
@@ -3317,9 +3317,9 @@ static void rtw8822c_dpk_reload_data(struct rtw_dev *rtwdev)
 		rtw_write32_mask(rtwdev, REG_NCTL0, BIT_SUBPAGE,
 				 0x8 | (path << 1));
 		if (dpk_info->dpk_band == RTW_BAND_2G)
-			rtw_write32(rtwdev, REG_DPD_LUT3, 0x1f100000);
+			rtw_write32(rtwdev, REG_DPD_CTL1_S1, 0x1f100000);
 		else
-			rtw_write32(rtwdev, REG_DPD_LUT3, 0x1f0d0000);
+			rtw_write32(rtwdev, REG_DPD_CTL1_S1, 0x1f0d0000);
 
 		rtw_write8(rtwdev, REG_DPD_AGC, dpk_info->dpk_txagc[path]);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index e2b134ce0b3f..04ec1d7ab8f6 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -164,180 +164,185 @@ const struct rtw_table name ## _tbl = {			\
 
 #define REG_ANAPARLDO_POW_MAC	0x0029
 #define BIT_LDOE25_PON		BIT(0)
-
 #define XCAP_MASK		GENMASK(6, 0)
 #define CFO_TRK_ENABLE_TH	20
 #define CFO_TRK_STOP_TH		10
 #define CFO_TRK_ADJ_TH		10
 
-#define REG_TXDFIR0	0x808
-#define REG_DFIRBW	0x810
-#define REG_ANTMAP0	0x820
-#define REG_ANTMAP	0x824
-#define REG_DYMPRITH	0x86c
-#define REG_DYMENTH0	0x870
-#define REG_DYMENTH	0x874
-#define REG_SBD		0x88c
+#define REG_TXDFIR0		0x808
+#define REG_DFIRBW		0x810
+#define REG_ANTMAP0		0x820
+#define REG_ANTMAP		0x824
+#define REG_DYMPRITH		0x86c
+#define REG_DYMENTH0		0x870
+#define REG_DYMENTH		0x874
+#define REG_SBD			0x88c
 #define BITS_SUBTUNE		GENMASK(15, 12)
-#define REG_DYMTHMIN	0x8a4
-#define REG_TXBWCTL	0x9b0
-#define REG_TXCLK	0x9b4
-#define REG_SCOTRK	0xc30
-#define REG_MRCM	0xc38
-#define REG_AGCSWSH	0xc44
-#define REG_ANTWTPD	0xc54
-#define REG_PT_CHSMO	0xcbc
+#define REG_DYMTHMIN		0x8a4
+
+#define REG_TXBWCTL		0x9b0
+#define REG_TXCLK		0x9b4
+
+#define REG_SCOTRK		0xc30
+#define REG_MRCM		0xc38
+#define REG_AGCSWSH		0xc44
+#define REG_ANTWTPD		0xc54
+#define REG_PT_CHSMO		0xcbc
 #define BIT_PT_OPT		BIT(21)
-#define REG_ORITXCODE	0x1800
-#define REG_3WIRE	0x180c
+
+#define REG_ORITXCODE		0x1800
+#define REG_3WIRE		0x180c
 #define BIT_3WIRE_TX_EN		BIT(0)
 #define BIT_3WIRE_RX_EN		BIT(1)
 #define BIT_3WIRE_PI_ON		BIT(28)
-#define REG_ANAPAR_A	0x1830
+#define REG_ANAPAR_A		0x1830
 #define BIT_ANAPAR_UPDATE	BIT(29)
-#define REG_RXAGCCTL0	0x18ac
+#define REG_RXAGCCTL0		0x18ac
 #define BITS_RXAGC_CCK		GENMASK(15, 12)
 #define BITS_RXAGC_OFDM		GENMASK(8, 4)
-#define REG_DCKA_I_0	0x18bc
-#define REG_DCKA_I_1	0x18c0
-#define REG_DCKA_Q_0	0x18d8
-#define REG_DCKA_Q_1	0x18dc
-#define REG_CCKSB	0x1a00
-#define REG_RXCCKSEL	0x1a04
-#define REG_BGCTRL	0x1a14
+#define REG_DCKA_I_0		0x18bc
+#define REG_DCKA_I_1		0x18c0
+#define REG_DCKA_Q_0		0x18d8
+#define REG_DCKA_Q_1		0x18dc
+
+#define REG_CCKSB		0x1a00
+#define REG_RXCCKSEL		0x1a04
+#define REG_BGCTRL		0x1a14
 #define BITS_RX_IQ_WEIGHT	(BIT(8) | BIT(9))
-#define REG_TXF0	0x1a20
-#define REG_TXF1	0x1a24
-#define REG_TXF2	0x1a28
-#define REG_CCANRX	0x1a2c
+#define REG_TXF0		0x1a20
+#define REG_TXF1		0x1a24
+#define REG_TXF2		0x1a28
+#define REG_CCANRX		0x1a2c
 #define BIT_CCK_FA_RST		(BIT(14) | BIT(15))
 #define BIT_OFDM_FA_RST		(BIT(12) | BIT(13))
-#define REG_CCK_FACNT	0x1a5c
-#define REG_CCKTXONLY	0x1a80
+#define REG_CCK_FACNT		0x1a5c
+#define REG_CCKTXONLY		0x1a80
 #define BIT_BB_CCK_CHECK_EN	BIT(18)
-#define REG_TXF3	0x1a98
-#define REG_TXF4	0x1a9c
-#define REG_TXF5	0x1aa0
-#define REG_TXF6	0x1aac
-#define REG_TXF7	0x1ab0
-#define REG_CCK_SOURCE	0x1abc
+#define REG_TXF3		0x1a98
+#define REG_TXF4		0x1a9c
+#define REG_TXF5		0x1aa0
+#define REG_TXF6		0x1aac
+#define REG_TXF7		0x1ab0
+#define REG_CCK_SOURCE		0x1abc
 #define BIT_NBI_EN		BIT(30)
-#define REG_IQKSTAT	0x1b10
-#define REG_TXANT	0x1c28
-#define REG_ENCCK	0x1c3c
-#define BIT_CCK_BLK_EN		BIT(1)
-#define BIT_CCK_OFDM_BLK_EN	(BIT(0) | BIT(1))
-#define REG_CCAMSK	0x1c80
-#define REG_RSTB	0x1c90
-#define BIT_RSTB_3WIRE		BIT(8)
-#define REG_RX_BREAK	0x1d2c
-#define BIT_COM_RX_GCK_EN	BIT(31)
-#define REG_RXFNCTL	0x1d30
-#define REG_RXIGI	0x1d70
-#define REG_ENFN	0x1e24
-#define REG_TXANTSEG	0x1e28
-#define REG_TXLGMAP	0x1e2c
-#define REG_CCKPATH	0x1e5c
-#define REG_CNT_CTRL	0x1eb4
-#define BIT_ALL_CNT_RST		BIT(25)
-#define REG_OFDM_FACNT	0x2d00
-#define REG_OFDM_FACNT1	0x2d04
-#define REG_OFDM_FACNT2	0x2d08
-#define REG_OFDM_FACNT3	0x2d0c
-#define REG_OFDM_FACNT4	0x2d10
-#define REG_OFDM_FACNT5	0x2d20
-#define REG_RPT_CIP	0x2d9c
-#define REG_OFDM_TXCNT	0x2de0
-#define REG_ORITXCODE2	0x4100
-#define REG_3WIRE2	0x410c
-#define REG_ANAPAR_B	0x4130
-#define REG_RXAGCCTL	0x41ac
-#define REG_DCKB_I_0	0x41bc
-#define REG_DCKB_I_1	0x41c0
-#define REG_DCKB_Q_0	0x41d8
-#define REG_DCKB_Q_1	0x41dc
-
-#define RF_MODE_TRXAGC		0x00
-#define RF_RXAGC_OFFSET		0x19
-#define RF_BW_TRXBB		0x1a
-#define RF_TX_GAIN_OFFSET	0x55
-#define RF_TX_GAIN		0x56
-#define RF_TXA_LB_SW		0x63
-#define RF_RXG_GAIN		0x87
-#define RF_RXA_MIX_GAIN		0x8a
-#define RF_EXT_TIA_BW		0x8f
-#define RF_DEBUG		0xde
 
 #define REG_NCTL0		0x1b00
+#define BIT_SUBPAGE		GENMASK(3, 0)
 #define REG_DPD_CTL0_S0		0x1b04
+#define BIT_GS_PWSF		GENMASK(27, 0)
 #define REG_DPD_CTL1_S0		0x1b08
+#define BIT_DPD_EN		BIT(31)
+#define REG_IQKSTAT		0x1b10
 #define REG_IQK_CTL1		0x1b20
+#define BIT_BYPASS_DPD		BIT(25)
+#define BIT_TX_CFIR		GENMASK(31, 30)
 #define REG_DPD_LUT0		0x1b44
+#define BIT_GLOSS_DB		GENMASK(14, 12)
 #define REG_DPD_CTL0_S1		0x1b5c
-#define REG_DPD_LUT3		0x1b60
 #define REG_DPD_CTL1_S1		0x1b60
 #define REG_DPD_AGC		0x1b67
 #define REG_DPD_CTL0		0x1bb4
 #define REG_R_CONFIG		0x1bcc
+#define BIT_INNER_LB		BIT(21)
+#define BIT_IQ_SWITCH		GENMASK(5, 0)
 #define REG_RXSRAM_CTL		0x1bd4
+#define BIT_RPT_SEL		GENMASK(20, 16)
+#define BIT_DPD_CLK		GENMASK(7, 4)
 #define REG_DPD_CTL11		0x1be4
 #define REG_DPD_CTL12		0x1be8
 #define REG_DPD_CTL15		0x1bf4
 #define REG_DPD_CTL16		0x1bf8
 #define REG_STAT_RPT		0x1bfc
+#define BIT_RPT_DGAIN		GENMASK(27, 16)
 
-#define BIT_EXT_TIA_BW		BIT(1)
-#define BIT_DE_TRXBW		BIT(2)
-#define BIT_DE_TX_GAIN		BIT(16)
-#define BIT_RXG_GAIN		BIT(18)
-#define BIT_DE_PWR_TRIM		BIT(19)
-#define BIT_INNER_LB		BIT(21)
-#define BIT_BYPASS_DPD		BIT(25)
-#define BIT_DPD_EN		BIT(31)
-#define BIT_SUBPAGE		GENMASK(3, 0)
+#define REG_TXANT		0x1c28
+#define REG_ENCCK		0x1c3c
+#define BIT_CCK_BLK_EN		BIT(1)
+#define BIT_CCK_OFDM_BLK_EN	(BIT(0) | BIT(1))
+#define REG_CCAMSK		0x1c80
+#define REG_RSTB		0x1c90
+#define BIT_RSTB_3WIRE		BIT(8)
+
+#define REG_RX_BREAK		0x1d2c
+#define BIT_COM_RX_GCK_EN	BIT(31)
+#define REG_RXFNCTL		0x1d30
+#define REG_RXIGI		0x1d70
+#define REG_ENFN		0x1e24
+#define REG_TXANTSEG		0x1e28
+#define REG_TXLGMAP		0x1e2c
+#define REG_CCKPATH		0x1e5c
+#define REG_CNT_CTRL		0x1eb4
+#define BIT_ALL_CNT_RST		BIT(25)
+
+#define REG_OFDM_FACNT		0x2d00
+#define REG_OFDM_FACNT1		0x2d04
+#define REG_OFDM_FACNT2		0x2d08
+#define REG_OFDM_FACNT3		0x2d0c
+#define REG_OFDM_FACNT4		0x2d10
+#define REG_OFDM_FACNT5		0x2d20
+#define REG_RPT_CIP		0x2d9c
+#define REG_OFDM_TXCNT		0x2de0
+
+#define REG_ORITXCODE2		0x4100
+#define REG_3WIRE2		0x410c
+#define REG_ANAPAR_B		0x4130
+#define REG_RXAGCCTL		0x41ac
+#define REG_DCKB_I_0		0x41bc
+#define REG_DCKB_I_1		0x41c0
+#define REG_DCKB_Q_0		0x41d8
+#define REG_DCKB_Q_1		0x41dc
+
+#define RF_MODE_TRXAGC		0x00
+#define BIT_RXAGC		GENMASK(9, 5)
 #define BIT_TXAGC		GENMASK(4, 0)
+#define RF_RXAGC_OFFSET		0x19
+#define RF_BW_TRXBB		0x1a
+#define BIT_BW_TXBB		GENMASK(14, 12)
+#define BIT_BW_RXBB		GENMASK(11, 10)
+#define RF_TX_GAIN_OFFSET	0x55
+#define BIT_BB_GAIN		GENMASK(18, 14)
+#define BIT_RF_GAIN		GENMASK(4, 2)
+#define RF_TX_GAIN		0x56
 #define BIT_GAIN_TXBB		GENMASK(4, 0)
+#define RF_PA			0x60
+#define RF_PABIAS_2G_MASK	GENMASK(15, 12)
+#define RF_PABIAS_5G_MASK	GENMASK(19, 16)
+#define RF_TXA_LB_SW		0x63
+#define BIT_TXA_LB_ATT		GENMASK(15, 14)
+#define BIT_LB_SW		GENMASK(13, 12)
 #define BIT_LB_ATT		GENMASK(4, 2)
+#define RF_RXG_GAIN		0x87
+#define BIT_RXG_GAIN		BIT(18)
+#define RF_RXA_MIX_GAIN		0x8a
 #define BIT_RXA_MIX_GAIN	GENMASK(4, 3)
-#define BIT_IQ_SWITCH		GENMASK(5, 0)
-#define BIT_DPD_CLK		GENMASK(7, 4)
-#define BIT_RXAGC		GENMASK(9, 5)
-#define BIT_BW_RXBB		GENMASK(11, 10)
-#define BIT_LB_SW		GENMASK(13, 12)
-#define BIT_BW_TXBB		GENMASK(14, 12)
-#define BIT_GLOSS_DB		GENMASK(14, 12)
-#define BIT_TXA_LB_ATT		GENMASK(15, 14)
-#define BIT_TX_OFFSET_VAL	GENMASK(18, 14)
-#define BIT_RPT_SEL		GENMASK(20, 16)
-#define BIT_GS_PWSF		GENMASK(27, 0)
-#define BIT_RPT_DGAIN		GENMASK(27, 16)
-#define BIT_TX_CFIR		GENMASK(31, 30)
-
-#define PPG_THERMAL_A 0x1ef
-#define PPG_THERMAL_B 0x1b0
-#define RF_THEMAL_MASK GENMASK(19, 16)
-#define PPG_2GL_TXAB 0x1d4
-#define PPG_2GM_TXAB 0x1ee
-#define PPG_2GH_TXAB 0x1d2
-#define PPG_2G_A_MASK GENMASK(3, 0)
-#define PPG_2G_B_MASK GENMASK(7, 4)
-#define PPG_5GL1_TXA 0x1ec
-#define PPG_5GL2_TXA 0x1e8
-#define PPG_5GM1_TXA 0x1e4
-#define PPG_5GM2_TXA 0x1e0
-#define PPG_5GH1_TXA 0x1dc
-#define PPG_5GL1_TXB 0x1eb
-#define PPG_5GL2_TXB 0x1e7
-#define PPG_5GM1_TXB 0x1e3
-#define PPG_5GM2_TXB 0x1df
-#define PPG_5GH1_TXB 0x1db
-#define PPG_5G_MASK GENMASK(4, 0)
-#define PPG_PABIAS_2GA 0x1d6
-#define PPG_PABIAS_2GB 0x1d5
-#define PPG_PABIAS_5GA 0x1d8
-#define PPG_PABIAS_5GB 0x1d7
-#define PPG_PABIAS_MASK GENMASK(3, 0)
-#define RF_PABIAS_2G_MASK GENMASK(15, 12)
-#define RF_PABIAS_5G_MASK GENMASK(19, 16)
+#define RF_EXT_TIA_BW		0x8f
+#define RF_DEBUG		0xde
+#define BIT_DE_PWR_TRIM		BIT(19)
+#define BIT_DE_TX_GAIN		BIT(16)
+#define BIT_DE_TRXBW		BIT(2)
 
+#define PPG_THERMAL_B		0x1b0
+#define RF_THEMAL_MASK		GENMASK(19, 16)
+#define PPG_2GH_TXAB		0x1d2
+#define PPG_2G_A_MASK		GENMASK(3, 0)
+#define PPG_2G_B_MASK		GENMASK(7, 4)
+#define PPG_2GL_TXAB		0x1d4
+#define PPG_PABIAS_2GB		0x1d5
+#define PPG_PABIAS_2GA		0x1d6
+#define PPG_PABIAS_MASK		GENMASK(3, 0)
+#define PPG_PABIAS_5GB		0x1d7
+#define PPG_PABIAS_5GA		0x1d8
+#define PPG_5G_MASK		GENMASK(4, 0)
+#define PPG_5GH1_TXB		0x1db
+#define PPG_5GH1_TXA		0x1dc
+#define PPG_5GM2_TXB		0x1df
+#define PPG_5GM2_TXA		0x1e0
+#define PPG_5GM1_TXB		0x1e3
+#define PPG_5GM1_TXA		0x1e4
+#define PPG_5GL2_TXB		0x1e7
+#define PPG_5GL2_TXA		0x1e8
+#define PPG_5GL1_TXB		0x1eb
+#define PPG_5GL1_TXA		0x1ec
+#define PPG_2GM_TXAB		0x1ee
+#define PPG_THERMAL_A		0x1ef
 #endif
-- 
2.21.0

