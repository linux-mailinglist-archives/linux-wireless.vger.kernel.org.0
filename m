Return-Path: <linux-wireless+bounces-1770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD9482B95B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 03:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E606BB239DA
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 02:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7580B4A14;
	Fri, 12 Jan 2024 02:11:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF8A4A13
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 02:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40C2BMmpC2061599, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40C2BMmpC2061599
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 10:11:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 12 Jan 2024 10:11:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Jan
 2024 10:11:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <hsuan8331@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/6] wifi: rtw89: 8922a: add BTG functions to assist BT coexistence to control TX/RX
Date: Fri, 12 Jan 2024 10:10:33 +0800
Message-ID: <20240112021033.20104-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112021033.20104-1-pkshih@realtek.com>
References: <20240112021033.20104-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Chung-Hsuan Hung <hsuan8331@realtek.com>

These functions are to control baseband AGC while BT coexists with WiFi.
Among these functions, ctrl_btg_bt_rx is used to control AGC related
settings, which is affected by BT RX, while BT shares the same path with
WiFi; ctrl_nbtg_bt_tx is used to control AGC settings under non-shared
path condition, which is affected by BT TX.

Signed-off-by: Chung-Hsuan Hung <hsuan8331@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      | 50 ++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 94 +++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 0a07731abb39..0d1216b6a538 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7964,8 +7964,28 @@
 #define R_S1_ADDCK 0x3E00
 #define B_S1_ADDCK_I GENMASK(9, 0)
 #define B_S1_ADDCK_Q GENMASK(19, 10)
+#define R_OP1DB_A 0x406B
+#define B_OP1DB_A GENMASK(31, 24)
+#define R_OP1DB1_A 0x40BC
+#define B_TIA1_A GENMASK(15, 8)
+#define B_TIA0_A GENMASK(7, 0)
+#define R_BKOFF_A 0x40E0
+#define B_BKOFF_IBADC_A GENMASK(23, 18)
+#define R_BACKOFF_A 0x40E4
+#define B_BACKOFF_LNA_A GENMASK(29, 24)
+#define B_BACKOFF_IBADC_A GENMASK(23, 18)
+#define R_RXBY_WBADC_A 0x40F4
+#define B_RXBY_WBADC_A GENMASK(14, 10)
 #define R_MUIC 0x40F8
 #define B_MUIC_EN BIT(0)
+#define R_BT_RXBY_WBADC_A 0x4160
+#define B_BT_RXBY_WBADC_A BIT(31)
+#define R_BT_SHARE_A 0x4164
+#define B_BT_SHARE_A BIT(0)
+#define B_BT_TRK_OFF_A BIT(1)
+#define B_BTG_PATH_A BIT(4)
+#define R_FORCE_FIR_A 0x418C
+#define B_FORCE_FIR_A GENMASK(1, 0)
 #define R_DCFO 0x4264
 #define B_DCFO GENMASK(7, 0)
 #define R_SEG0CSI 0x42AC
@@ -8004,8 +8024,28 @@
 #define R_DPD_BF 0x44a0
 #define B_DPD_BF_OFDM GENMASK(16, 12)
 #define B_DPD_BF_SCA GENMASK(6, 0)
+#define R_LNA_OP 0x44B0
+#define B_LNA6 GENMASK(31, 24)
+#define R_LNA_TIA 0x44BC
+#define B_TIA1_B GENMASK(15, 8)
+#define B_TIA0_B GENMASK(7, 0)
+#define R_BKOFF_B 0x44E0
+#define B_BKOFF_IBADC_B GENMASK(23, 18)
+#define R_BACKOFF_B 0x44E4
+#define B_BACKOFF_LNA_B GENMASK(29, 24)
+#define B_BACKOFF_IBADC_B GENMASK(23, 18)
+#define R_RXBY_WBADC_B 0x44F4
+#define B_RXBY_WBADC_B GENMASK(14, 10)
+#define R_BT_RXBY_WBADC_B 0x4560
+#define B_BT_RXBY_WBADC_B BIT(31)
+#define R_BT_SHARE_B 0x4564
+#define B_BT_SHARE_B BIT(0)
+#define B_BT_TRK_OFF_B BIT(1)
+#define B_BTG_PATH_B BIT(4)
 #define R_TXPATH_SEL 0x458C
 #define B_TXPATH_SEL_MSK GENMASK(31, 28)
+#define R_FORCE_FIR_B 0x458C
+#define B_FORCE_FIR_B GENMASK(1, 0)
 #define R_TXPWR 0x4594
 #define B_TXPWR_MSK GENMASK(30, 22)
 #define R_TXNSS_MAP 0x45B4
@@ -8419,6 +8459,16 @@
 #define B_SEGSND_EN BIT(31)
 #define R_DBCC 0x6B48
 #define B_DBCC_EN BIT(0)
+#define R_FC0INV_SBW 0x6B50
+#define B_SMALLBW GENMASK(31, 30)
+#define B_RX_BT_SG0 GENMASK(25, 22)
+#define B_RX_1RCCA GENMASK(17, 14)
+#define B_FC0_INV GENMASK(6, 0)
+#define R_ANT_CHBW 0x6B54
+#define B_ANT_BT_SHARE BIT(16)
+#define B_CHBW_BW GENMASK(14, 12)
+#define B_CHBW_PRICH GENMASK(11, 8)
+#define B_ANT_RX_SG0 GENMASK(3, 0)
 #define R_SLOPE 0x6B6C
 #define B_EHT_RATE_TH GENMASK(31, 28)
 #define B_SLOPE_B GENMASK(27, 14)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index c098395dba11..7e57e7e54a7d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -200,6 +200,36 @@ static const struct rtw89_efuse_block_cfg rtw8922a_efuse_blocks[] = {
 	[RTW89_EFUSE_BLOCK_ADIE]		= {.offset = 0x70000, .size = 0x10},
 };
 
+static void rtw8922a_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
+				    enum rtw89_phy_idx phy_idx)
+{
+	if (en) {
+		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_A, B_BT_SHARE_A, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_A, B_BTG_PATH_A, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_B, B_BT_SHARE_B, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_B, B_BTG_PATH_B, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_LNA_OP, B_LNA6, 0x20, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_LNA_TIA, B_TIA0_B, 0x30, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PMAC_GNT, B_PMAC_GNT_P1, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_ANT_BT_SHARE, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_FC0INV_SBW, B_RX_BT_SG0, 0x2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_GNT_BT_WGT_EN, B_GNT_BT_WGT_EN,
+				      0x1, phy_idx);
+	} else {
+		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_A, B_BT_SHARE_A, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_A, B_BTG_PATH_A, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_B, B_BT_SHARE_B, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_B, B_BTG_PATH_B, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_LNA_OP, B_LNA6, 0x1a, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_LNA_TIA, B_TIA0_B, 0x2a, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PMAC_GNT, B_PMAC_GNT_P1, 0xc, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_ANT_CHBW, B_ANT_BT_SHARE, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_FC0INV_SBW, B_RX_BT_SG0, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_GNT_BT_WGT_EN, B_GNT_BT_WGT_EN,
+				      0x0, phy_idx);
+	}
+}
+
 static int rtw8922a_pwr_on_func(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
@@ -1190,6 +1220,68 @@ static void rtw8922a_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
 	rtw8922a_set_txpwr_ref(rtwdev, phy_idx);
 }
 
+static void rtw8922a_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
+				     enum rtw89_phy_idx phy_idx)
+{
+	if (en) {
+		rtw89_phy_write32_idx(rtwdev, R_FORCE_FIR_A, B_FORCE_FIR_A, 0x3, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBY_WBADC_A, B_RXBY_WBADC_A,
+				      0xf, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_RXBY_WBADC_A, B_BT_RXBY_WBADC_A,
+				      0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_A, B_BT_TRK_OFF_A, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_OP1DB_A, B_OP1DB_A, 0x80, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_OP1DB1_A, B_TIA0_A, 0x80, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_OP1DB1_A, B_TIA1_A, 0x80, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_A, B_BACKOFF_IBADC_A,
+				      0x34, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_A, B_BACKOFF_LNA_A, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BKOFF_A, B_BKOFF_IBADC_A, 0x34, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_FORCE_FIR_B, B_FORCE_FIR_B, 0x3, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBY_WBADC_B, B_RXBY_WBADC_B,
+				      0xf, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_RXBY_WBADC_B, B_BT_RXBY_WBADC_B,
+				      0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_B, B_BT_TRK_OFF_B, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_LNA_OP, B_LNA6, 0x80, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_LNA_TIA, B_TIA0_B, 0x80, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_LNA_TIA, B_TIA1_B, 0x80, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_B, B_BACKOFF_IBADC_B,
+				      0x34, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_B, B_BACKOFF_LNA_B, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BKOFF_B, B_BKOFF_IBADC_B, 0x34, phy_idx);
+	} else {
+		rtw89_phy_write32_idx(rtwdev, R_FORCE_FIR_A, B_FORCE_FIR_A, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBY_WBADC_A, B_RXBY_WBADC_A,
+				      0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_RXBY_WBADC_A, B_BT_RXBY_WBADC_A,
+				      0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_A, B_BT_TRK_OFF_A, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_OP1DB_A, B_OP1DB_A, 0x1a, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_OP1DB1_A, B_TIA0_A, 0x2a, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_OP1DB1_A, B_TIA1_A, 0x2a, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_A, B_BACKOFF_IBADC_A,
+				      0x26, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_A, B_BACKOFF_LNA_A,
+				      0x1e, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BKOFF_A, B_BKOFF_IBADC_A, 0x26, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_FORCE_FIR_B, B_FORCE_FIR_B, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBY_WBADC_B, B_RXBY_WBADC_B,
+				      0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_RXBY_WBADC_B, B_BT_RXBY_WBADC_B,
+				      0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_B, B_BT_TRK_OFF_B, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_LNA_OP, B_LNA6, 0x20, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_LNA_TIA, B_TIA0_B, 0x30, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_LNA_TIA, B_TIA1_B, 0x2a, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_B, B_BACKOFF_IBADC_B,
+				      0x26, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_B, B_BACKOFF_LNA_B,
+				      0x1e, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BKOFF_B, B_BKOFF_IBADC_B, 0x26, phy_idx);
+	}
+}
+
 static int rtw8922a_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	rtw89_write8_set(rtwdev, R_BE_FEN_RST_ENABLE,
@@ -1230,6 +1322,8 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.set_txpwr		= rtw8922a_set_txpwr,
 	.set_txpwr_ctrl		= rtw8922a_set_txpwr_ctrl,
 	.init_txpwr_unit	= NULL,
+	.ctrl_btg_bt_rx		= rtw8922a_ctrl_btg_bt_rx,
+	.ctrl_nbtg_bt_tx	= rtw8922a_ctrl_nbtg_bt_tx,
 	.set_txpwr_ul_tb_offset	= NULL,
 	.pwr_on_func		= rtw8922a_pwr_on_func,
 	.pwr_off_func		= rtw8922a_pwr_off_func,
-- 
2.25.1


