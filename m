Return-Path: <linux-wireless+bounces-1518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494FD824EBF
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 07:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FE22824F8
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 06:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3E27E;
	Fri,  5 Jan 2024 06:44:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E920B37
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4056ihA632211810, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4056ihA632211810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 14:44:43 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 5 Jan 2024 14:44:44 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 5 Jan 2024
 14:44:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <cj.hsieh@realtek.com>, <hsuan8331@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/8] wifi: rtw89: phy: set channel_info for WiFi 7 chips
Date: Fri, 5 Jan 2024 14:44:40 +0800
Message-ID: <20240105064440.36926-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

The channel_info is hardware settings to reflect operational status, such
as scale factor, report unit, buffer matrix size, RU size and so on. Then,
we can get desired reports to do further tuning.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c    |  2 ++
 drivers/net/wireless/realtek/rtw89/phy.h    |  9 +++++++++
 drivers/net/wireless/realtek/rtw89/phy_be.c | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 11 +++++++++++
 4 files changed, 34 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 69debc156edb..926a4459ea4f 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4968,6 +4968,7 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 	rtw89_phy_cfo_init(rtwdev);
 	rtw89_phy_bb_wrap_init(rtwdev);
 	rtw89_phy_edcca_init(rtwdev);
+	rtw89_phy_ch_info_init(rtwdev);
 	rtw89_phy_ul_tb_info_init(rtwdev);
 	rtw89_phy_antdiv_init(rtwdev);
 	rtw89_chip_rfe_gpio(rtwdev);
@@ -5493,6 +5494,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_ax = {
 	.config_bb_gain = rtw89_phy_config_bb_gain_ax,
 	.preinit_rf_nctl = rtw89_phy_preinit_rf_nctl_ax,
 	.bb_wrap_init = NULL,
+	.ch_info_init = NULL,
 
 	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_ax,
 	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 2ffd33b078b2..a16bff77661f 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -515,6 +515,7 @@ struct rtw89_phy_gen_def {
 			       void *extra_data);
 	void (*preinit_rf_nctl)(struct rtw89_dev *rtwdev);
 	void (*bb_wrap_init)(struct rtw89_dev *rtwdev);
+	void (*ch_info_init)(struct rtw89_dev *rtwdev);
 
 	void (*set_txpwr_byrate)(struct rtw89_dev *rtwdev,
 				 const struct rtw89_chan *chan,
@@ -812,6 +813,14 @@ static inline void rtw89_phy_bb_wrap_init(struct rtw89_dev *rtwdev)
 		phy->bb_wrap_init(rtwdev);
 }
 
+static inline void rtw89_phy_ch_info_init(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	if (phy->ch_info_init)
+		phy->ch_info_init(rtwdev);
+}
+
 static inline
 void rtw89_phy_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 				const struct rtw89_chan *chan,
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index e8ce29de1c52..6849438a5f3c 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -375,6 +375,17 @@ static void rtw89_phy_bb_wrap_init_be(struct rtw89_dev *rtwdev)
 	rtw89_phy_bb_wrap_tpu_set_all(rtwdev, mac_idx);
 }
 
+static void rtw89_phy_ch_info_init_be(struct rtw89_dev *rtwdev)
+{
+	rtw89_phy_write32_mask(rtwdev, R_CHINFO_SEG, B_CHINFO_SEG_LEN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_CHINFO_SEG, B_CHINFO_SEG, 0xf);
+	rtw89_phy_write32_mask(rtwdev, R_CHINFO_DATA, B_CHINFO_DATA_BITMAP, 0x1);
+	rtw89_phy_set_phy_regs(rtwdev, R_CHINFO_ELM_SRC, B_CHINFO_ELM_BITMAP, 0x40303);
+	rtw89_phy_set_phy_regs(rtwdev, R_CHINFO_ELM_SRC, B_CHINFO_SRC, 0x0);
+	rtw89_phy_set_phy_regs(rtwdev, R_CHINFO_TYPE_SCAL, B_CHINFO_TYPE, 0x3);
+	rtw89_phy_set_phy_regs(rtwdev, R_CHINFO_TYPE_SCAL, B_CHINFO_SCAL, 0x0);
+}
+
 struct rtw89_byr_spec_ent_be {
 	struct rtw89_rate_desc init;
 	u8 num_of_idx;
@@ -944,6 +955,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 	.config_bb_gain = rtw89_phy_config_bb_gain_be,
 	.preinit_rf_nctl = rtw89_phy_preinit_rf_nctl_be,
 	.bb_wrap_init = rtw89_phy_bb_wrap_init_be,
+	.ch_info_init = rtw89_phy_ch_info_init_be,
 
 	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_be,
 	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index a03fb3784d1c..b411bf726849 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7512,9 +7512,14 @@
 #define B_UPD_P0_EN BIT(31)
 #define R_SPOOF_CG 0x00B4
 #define B_SPOOF_CG_EN BIT(17)
+#define R_CHINFO_SEG 0x00B4
+#define B_CHINFO_SEG_LEN GENMASK(2, 0)
+#define B_CHINFO_SEG GENMASK(16, 7)
 #define R_DFS_FFT_CG 0x00B8
 #define B_DFS_CG_EN BIT(1)
 #define B_DFS_FFT_EN BIT(0)
+#define R_CHINFO_DATA 0x00C0
+#define B_CHINFO_DATA_BITMAP GENMASK(22, 0)
 #define R_ANAPAR_PW15 0x030C
 #define B_ANAPAR_PW15 GENMASK(31, 24)
 #define B_ANAPAR_PW15_H GENMASK(27, 24)
@@ -8154,6 +8159,12 @@
 #define B_PATH1_5MDET_SB2 BIT(8)
 #define B_PATH1_5MDET_SB0 BIT(6)
 #define B_PATH1_5MDET_TH GENMASK(5, 0)
+#define R_CHINFO_ELM_SRC 0x4D84
+#define B_CHINFO_ELM_BITMAP GENMASK(22, 0)
+#define B_CHINFO_SRC GENMASK(31, 30)
+#define R_CHINFO_TYPE_SCAL 0x4D88
+#define B_CHINFO_TYPE GENMASK(2, 1)
+#define B_CHINFO_SCAL BIT(8)
 #define R_RPL_BIAS_COMP 0x4DF0
 #define B_RPL_BIAS_COMP_MASK GENMASK(7, 0)
 #define R_RPL_PATHAB 0x4E0C
-- 
2.25.1


