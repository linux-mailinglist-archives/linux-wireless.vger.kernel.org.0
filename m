Return-Path: <linux-wireless+bounces-1516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E268824EBD
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 07:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B321C21E2F
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 06:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A354A20B09;
	Fri,  5 Jan 2024 06:44:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F020C20B0E
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4056iPBe92204230, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4056iPBe92204230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 14:44:25 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 5 Jan 2024 14:44:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 5 Jan 2024
 14:44:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <cj.hsieh@realtek.com>, <hsuan8331@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/8] wifi: rtw89: 8922a: add NCTL pre-settings for WiFi 7 chips
Date: Fri, 5 Jan 2024 14:44:22 +0800
Message-ID: <20240105064422.36812-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105064228.36580-1-pkshih@realtek.com>
References: <20240105064228.36580-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

NCTL standing for nano-controller is used to assist RF calibration.
Basically, we write settings from a table, but format of the table can't
describe register mask and additional conditions, so add a function to
set this kind of settings.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c    | 14 +++++++++++---
 drivers/net/wireless/realtek/rtw89/phy.h    |  8 ++++++++
 drivers/net/wireless/realtek/rtw89/phy_be.c | 19 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 17 +++++++++++++++++
 4 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 3efc6bbdf624..e9baa939d987 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1469,11 +1469,9 @@ void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev, bool noio)
 	kfree(rf_reg_info);
 }
 
-static void rtw89_phy_init_rf_nctl(struct rtw89_dev *rtwdev)
+static void rtw89_phy_preinit_rf_nctl_ax(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	const struct rtw89_phy_table *nctl_table;
 	u32 val;
 	int ret;
 
@@ -1493,6 +1491,15 @@ static void rtw89_phy_init_rf_nctl(struct rtw89_dev *rtwdev)
 				1000, false, rtwdev);
 	if (ret)
 		rtw89_err(rtwdev, "failed to poll nctl block\n");
+}
+
+static void rtw89_phy_init_rf_nctl(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_phy_table *nctl_table;
+
+	rtw89_phy_preinit_rf_nctl(rtwdev);
 
 	nctl_table = elm_info->rf_nctl ? elm_info->rf_nctl : chip->nctl_table;
 	rtw89_phy_init_reg(rtwdev, nctl_table, rtw89_phy_config_bb_reg, NULL);
@@ -5483,6 +5490,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_ax = {
 	.physts = &rtw89_physts_regs_ax,
 	.cfo = &rtw89_cfo_regs_ax,
 	.config_bb_gain = rtw89_phy_config_bb_gain_ax,
+	.preinit_rf_nctl = rtw89_phy_preinit_rf_nctl_ax,
 
 	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_ax,
 	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 70943117242e..5347aba994df 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -513,6 +513,7 @@ struct rtw89_phy_gen_def {
 			       const struct rtw89_reg2_def *reg,
 			       enum rtw89_rf_path rf_path,
 			       void *extra_data);
+	void (*preinit_rf_nctl)(struct rtw89_dev *rtwdev);
 
 	void (*set_txpwr_byrate)(struct rtw89_dev *rtwdev,
 				 const struct rtw89_chan *chan,
@@ -795,6 +796,13 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 				 u8 ru, u8 ntx, u8 ch);
 
+static inline void rtw89_phy_preinit_rf_nctl(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	phy->preinit_rf_nctl(rtwdev);
+}
+
 static inline
 void rtw89_phy_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 				const struct rtw89_chan *chan,
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index b65de183156b..0f61d86c5e8f 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -252,6 +252,24 @@ static void rtw89_phy_config_bb_gain_be(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw89_phy_preinit_rf_nctl_be(struct rtw89_dev *rtwdev)
+{
+	rtw89_phy_write32_mask(rtwdev, R_GOTX_IQKDPK_C0, B_GOTX_IQKDPK, 0x3);
+	rtw89_phy_write32_mask(rtwdev, R_GOTX_IQKDPK_C1, B_GOTX_IQKDPK, 0x3);
+	rtw89_phy_write32_mask(rtwdev, R_IQKDPK_HC, B_IQKDPK_HC, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_CLK_GCK, B_CLK_GCK, 0x00fffff);
+	rtw89_phy_write32_mask(rtwdev, R_IOQ_IQK_DPK, B_IOQ_IQK_DPK_CLKEN, 0x3);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DPK_RST, B_IQK_DPK_RST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DPK_PRST, B_IQK_DPK_PRST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DPK_PRST_C1, B_IQK_DPK_PRST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_TXRFC, B_TXRFC_RST, 0x1);
+
+	if (rtwdev->dbcc_en) {
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DPK_RST_C1, B_IQK_DPK_RST, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_TXRFC_C1, B_TXRFC_RST, 0x1);
+	}
+}
+
 struct rtw89_byr_spec_ent_be {
 	struct rtw89_rate_desc init;
 	u8 num_of_idx;
@@ -819,6 +837,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 	.physts = &rtw89_physts_regs_be,
 	.cfo = &rtw89_cfo_regs_be,
 	.config_bb_gain = rtw89_phy_config_bb_gain_be,
+	.preinit_rf_nctl = rtw89_phy_preinit_rf_nctl_be,
 
 	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_be,
 	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 61ba52d5990e..dc237f12dc5e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7588,13 +7588,20 @@
 #define R_PD_CTRL 0x0C3C
 #define B_PD_HIT_DIS BIT(9)
 #define R_IOQ_IQK_DPK 0x0C60
+#define B_IOQ_IQK_DPK_CLKEN GENMASK(1, 0)
 #define B_IOQ_IQK_DPK_EN BIT(1)
 #define R_GNT_BT_WGT_EN 0x0C6C
 #define B_GNT_BT_WGT_EN BIT(21)
+#define R_IQK_DPK_RST 0x0C6C
+#define R_IQK_DPK_RST_C1 0x1C6C
+#define B_IQK_DPK_RST BIT(0)
 #define R_TX_COLLISION_T2R_ST 0x0C70
 #define B_TX_COLLISION_T2R_ST_M GENMASK(25, 20)
 #define R_TXGATING 0x0C74
 #define B_TXGATING_EN BIT(4)
+#define R_TXRFC 0x0C7C
+#define R_TXRFC_C1 0x1C7C
+#define B_TXRFC_RST GENMASK(23, 21)
 #define R_PD_ARBITER_OFF 0x0C80
 #define B_PD_ARBITER_OFF BIT(31)
 #define R_SNDCCA_A1 0x0C9C
@@ -7624,6 +7631,8 @@
 #define R_CTLTOP 0x1008
 #define B_CTLTOP_ON BIT(23)
 #define B_CTLTOP_VAL GENMASK(15, 12)
+#define R_CLK_GCK 0x1008
+#define B_CLK_GCK GENMASK(24, 0)
 #define R_EDCCA_RPT_SEL_BE 0x10CC
 #define R_S0_HW_SI_DIS 0x1200
 #define B_S0_HW_SI_DIS_W_R_TRIG GENMASK(30, 28)
@@ -7771,6 +7780,8 @@
 #define B_P80_AT_HIGH_FREQ_RU_ALLOC_PHY0 BIT(13)
 #define R_DBCC_80P80_SEL_EVM_RPT2 0x2A10
 #define B_DBCC_80P80_SEL_EVM_RPT2_EN BIT(0)
+#define R_IQKDPK_HC 0x2AB8
+#define B_IQKDPK_HC BIT(28)
 #define R_P1_EN_SOUND_WO_NDP 0x2D7C
 #define B_P1_EN_SOUND_WO_NDP BIT(1)
 #define R_EDCCA_RPT_A_BE 0x2E38
@@ -8630,6 +8641,12 @@
 #define B_DACKN0_V GENMASK(21, 14)
 #define R_DACKN1_CTL 0xC224
 #define B_DACKN1_V GENMASK(21, 14)
+#define R_GOTX_IQKDPK_C0 0xE464
+#define R_GOTX_IQKDPK_C1 0xE564
+#define B_GOTX_IQKDPK GENMASK(28, 27)
+#define R_IQK_DPK_PRST 0xE4AC
+#define R_IQK_DPK_PRST_C1 0xE5AC
+#define B_IQK_DPK_PRST BIT(27)
 
 /* WiFi CPU local domain */
 #define R_AX_WDT_CTRL 0x0040
-- 
2.25.1


