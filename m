Return-Path: <linux-wireless+bounces-27-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4675B7F6CBC
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 08:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721211C20A77
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 07:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637698C01;
	Fri, 24 Nov 2023 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E963D6F
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 23:18:12 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AO7I4kpC3551115, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AO7I4kpC3551115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 15:18:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 24 Nov 2023 15:18:05 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 24 Nov
 2023 15:18:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/8] wifi: rtw89: 8922a: extend and add quota number
Date: Fri, 24 Nov 2023 15:16:56 +0800
Message-ID: <20231124071703.132549-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124071703.132549-1-pkshih@realtek.com>
References: <20231124071703.132549-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Define 8922A buffer quota that are used by HCI control flow, payload
engine, descriptor engine and etc for operation modes, such as SCC (single
channel concurrence) and download firmware. Since WiFi 7 chips has more
buffer classifications, add fields and struct according to design.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 26 ++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      | 14 ++++++
 drivers/net/wireless/realtek/rtw89/mac.h      | 14 ++++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 50 +++++++++++++++++++
 4 files changed, 104 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6948ffe0f206..4a8331cf2c2d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3292,6 +3292,8 @@ struct rtw89_dle_size {
 	u16 pge_size;
 	u16 lnk_pge_num;
 	u16 unlnk_pge_num;
+	/* for WiFi 7 chips below */
+	u32 srt_ofst;
 };
 
 struct rtw89_wde_quota {
@@ -3314,6 +3316,26 @@ struct rtw89_ple_quota {
 	u16 wd_rel;
 	u16 cpu_io;
 	u16 tx_rpt;
+	/* for WiFi 7 chips below */
+	u16 h2d;
+};
+
+struct rtw89_rsvd_quota {
+	u16 mpdu_info_tbl;
+	u16 b0_csi;
+	u16 b1_csi;
+	u16 b0_lmr;
+	u16 b1_lmr;
+	u16 b0_ftm;
+	u16 b1_ftm;
+	u16 b0_smr;
+	u16 b1_smr;
+	u16 others;
+};
+
+struct rtw89_dle_rsvd_size {
+	u32 srt_ofst;
+	u32 size;
 };
 
 struct rtw89_dle_mem {
@@ -3324,6 +3346,10 @@ struct rtw89_dle_mem {
 	const struct rtw89_wde_quota *wde_max_qt;
 	const struct rtw89_ple_quota *ple_min_qt;
 	const struct rtw89_ple_quota *ple_max_qt;
+	/* for WiFi 7 chips below */
+	const struct rtw89_rsvd_quota *rsvd_qt;
+	const struct rtw89_dle_rsvd_size *rsvd0_size;
+	const struct rtw89_dle_rsvd_size *rsvd1_size;
 };
 
 struct rtw89_reg_def {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 9ec307051611..b93a00f56cb9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1461,10 +1461,14 @@ static int rtw89_mac_sys_init(struct rtw89_dev *rtwdev)
 
 const struct rtw89_mac_size_set rtw89_mac_size = {
 	.hfc_preccfg_pcie = {2, 40, 0, 0, 1, 0, 0, 0},
+	.hfc_prec_cfg_c0 = {2, 32, 0, 0, 0, 0, 0, 0},
+	.hfc_prec_cfg_c2 = {0, 256, 0, 0, 0, 0, 0, 0},
 	/* PCIE 64 */
 	.wde_size0 = {RTW89_WDE_PG_64, 4095, 1,},
+	.wde_size0_v1 = {RTW89_WDE_PG_64, 3328, 0, 0,},
 	/* DLFW */
 	.wde_size4 = {RTW89_WDE_PG_64, 0, 4096,},
+	.wde_size4_v1 = {RTW89_WDE_PG_64, 0, 3328, 0,},
 	/* PCIE 64 */
 	.wde_size6 = {RTW89_WDE_PG_64, 512, 0,},
 	/* 8852B PCIE SCC */
@@ -1477,6 +1481,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_size19 = {RTW89_WDE_PG_64, 3328, 0,},
 	/* PCIE */
 	.ple_size0 = {RTW89_PLE_PG_128, 1520, 16,},
+	.ple_size0_v1 = {RTW89_PLE_PG_128, 2672, 256, 212992,},
+	.ple_size3_v1 = {RTW89_PLE_PG_128, 2928, 0, 212992,},
 	/* DLFW */
 	.ple_size4 = {RTW89_PLE_PG_128, 64, 1472,},
 	/* PCIE 64 */
@@ -1489,6 +1495,7 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_size19 = {RTW89_PLE_PG_128, 1904, 16,},
 	/* PCIE 64 */
 	.wde_qt0 = {3792, 196, 0, 107,},
+	.wde_qt0_v1 = {3302, 6, 0, 20,},
 	/* DLFW */
 	.wde_qt4 = {0, 0, 0, 0,},
 	/* PCIE 64 */
@@ -1499,10 +1506,13 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt17 = {0, 0, 0,  0,},
 	/* 8852C PCIE SCC */
 	.wde_qt18 = {3228, 60, 0, 40,},
+	.ple_qt0 = {320, 0, 32, 16, 13, 13, 292, 0, 32, 18, 1, 4, 0,},
+	.ple_qt1 = {320, 0, 32, 16, 1944, 1944, 2223, 0, 1963, 1949, 1, 1935, 0,},
 	/* PCIE SCC */
 	.ple_qt4 = {264, 0, 16, 20, 26, 13, 356, 0, 32, 40, 8,},
 	/* PCIE SCC */
 	.ple_qt5 = {264, 0, 32, 20, 64, 13, 1101, 0, 64, 128, 120,},
+	.ple_qt9 = {0, 0, 32, 256, 0, 0, 0, 0, 0, 0, 1, 0, 0,},
 	/* DLFW */
 	.ple_qt13 = {0, 0, 16, 48, 0, 0, 0, 0, 0, 0, 0,},
 	/* PCIE 64 */
@@ -1523,6 +1533,10 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_qt_52b_wow = {147, 0, 16, 20, 157, 13, 133, 0, 172, 14, 24, 0,},
 	/* 8851B PCIE WOW */
 	.ple_qt_51b_wow = {147, 0, 16, 20, 157, 13, 133, 0, 172, 14, 24, 0,},
+	.ple_rsvd_qt0 = {2, 112, 56, 6, 6, 6, 6, 0, 0, 62,},
+	.ple_rsvd_qt1 = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+	.rsvd0_size0 = {212992, 0,},
+	.rsvd1_size0 = {587776, 2048,},
 };
 EXPORT_SYMBOL(rtw89_mac_size);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index f47a42387a6a..511ee5dc4240 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -818,27 +818,37 @@ enum mac_ax_err_info {
 
 struct rtw89_mac_size_set {
 	const struct rtw89_hfc_prec_cfg hfc_preccfg_pcie;
+	const struct rtw89_hfc_prec_cfg hfc_prec_cfg_c0;
+	const struct rtw89_hfc_prec_cfg hfc_prec_cfg_c2;
 	const struct rtw89_dle_size wde_size0;
+	const struct rtw89_dle_size wde_size0_v1;
 	const struct rtw89_dle_size wde_size4;
+	const struct rtw89_dle_size wde_size4_v1;
 	const struct rtw89_dle_size wde_size6;
 	const struct rtw89_dle_size wde_size7;
 	const struct rtw89_dle_size wde_size9;
 	const struct rtw89_dle_size wde_size18;
 	const struct rtw89_dle_size wde_size19;
 	const struct rtw89_dle_size ple_size0;
+	const struct rtw89_dle_size ple_size0_v1;
+	const struct rtw89_dle_size ple_size3_v1;
 	const struct rtw89_dle_size ple_size4;
 	const struct rtw89_dle_size ple_size6;
 	const struct rtw89_dle_size ple_size8;
 	const struct rtw89_dle_size ple_size18;
 	const struct rtw89_dle_size ple_size19;
 	const struct rtw89_wde_quota wde_qt0;
+	const struct rtw89_wde_quota wde_qt0_v1;
 	const struct rtw89_wde_quota wde_qt4;
 	const struct rtw89_wde_quota wde_qt6;
 	const struct rtw89_wde_quota wde_qt7;
 	const struct rtw89_wde_quota wde_qt17;
 	const struct rtw89_wde_quota wde_qt18;
+	const struct rtw89_ple_quota ple_qt0;
+	const struct rtw89_ple_quota ple_qt1;
 	const struct rtw89_ple_quota ple_qt4;
 	const struct rtw89_ple_quota ple_qt5;
+	const struct rtw89_ple_quota ple_qt9;
 	const struct rtw89_ple_quota ple_qt13;
 	const struct rtw89_ple_quota ple_qt18;
 	const struct rtw89_ple_quota ple_qt44;
@@ -849,6 +859,10 @@ struct rtw89_mac_size_set {
 	const struct rtw89_ple_quota ple_qt_52a_wow;
 	const struct rtw89_ple_quota ple_qt_52b_wow;
 	const struct rtw89_ple_quota ple_qt_51b_wow;
+	const struct rtw89_rsvd_quota ple_rsvd_qt0;
+	const struct rtw89_rsvd_quota ple_rsvd_qt1;
+	const struct rtw89_dle_rsvd_size rsvd0_size0;
+	const struct rtw89_dle_rsvd_size rsvd1_size0;
 };
 
 extern const struct rtw89_mac_size_set rtw89_mac_size;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index d190f095a5a8..b75d555d0cc3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -15,6 +15,54 @@
 #define RTW8922A_MODULE_FIRMWARE \
 	RTW8922A_FW_BASENAME ".bin"
 
+static const struct rtw89_hfc_ch_cfg rtw8922a_hfc_chcfg_pcie[] = {
+	{2, 1641, grp_0}, /* ACH 0 */
+	{2, 1641, grp_0}, /* ACH 1 */
+	{2, 1641, grp_0}, /* ACH 2 */
+	{2, 1641, grp_0}, /* ACH 3 */
+	{2, 1641, grp_1}, /* ACH 4 */
+	{2, 1641, grp_1}, /* ACH 5 */
+	{2, 1641, grp_1}, /* ACH 6 */
+	{2, 1641, grp_1}, /* ACH 7 */
+	{2, 1641, grp_0}, /* B0MGQ */
+	{2, 1641, grp_0}, /* B0HIQ */
+	{2, 1641, grp_1}, /* B1MGQ */
+	{2, 1641, grp_1}, /* B1HIQ */
+	{0, 0, 0}, /* FWCMDQ */
+	{0, 0, 0}, /* BMC */
+	{0, 0, 0}, /* H2D */
+};
+
+static const struct rtw89_hfc_pub_cfg rtw8922a_hfc_pubcfg_pcie = {
+	1651, /* Group 0 */
+	1651, /* Group 1 */
+	3302, /* Public Max */
+	0, /* WP threshold */
+};
+
+static const struct rtw89_hfc_param_ini rtw8922a_hfc_param_ini_pcie[] = {
+	[RTW89_QTA_SCC] = {rtw8922a_hfc_chcfg_pcie, &rtw8922a_hfc_pubcfg_pcie,
+			   &rtw89_mac_size.hfc_prec_cfg_c0, RTW89_HCIFC_POH},
+	[RTW89_QTA_DLFW] = {NULL, NULL, &rtw89_mac_size.hfc_prec_cfg_c2,
+			    RTW89_HCIFC_POH},
+	[RTW89_QTA_INVALID] = {NULL},
+};
+
+static const struct rtw89_dle_mem rtw8922a_dle_mem_pcie[] = {
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size0_v1,
+			   &rtw89_mac_size.ple_size0_v1, &rtw89_mac_size.wde_qt0_v1,
+			   &rtw89_mac_size.wde_qt0_v1, &rtw89_mac_size.ple_qt0,
+			   &rtw89_mac_size.ple_qt1, &rtw89_mac_size.ple_rsvd_qt0,
+			   &rtw89_mac_size.rsvd0_size0, &rtw89_mac_size.rsvd1_size0},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size4_v1,
+			    &rtw89_mac_size.ple_size3_v1, &rtw89_mac_size.wde_qt4,
+			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt9,
+			    &rtw89_mac_size.ple_qt9, &rtw89_mac_size.ple_rsvd_qt1,
+			    &rtw89_mac_size.rsvd0_size0, &rtw89_mac_size.rsvd1_size0},
+	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
+			       NULL},
+};
+
 static const struct rtw89_efuse_block_cfg rtw8922a_efuse_blocks[] = {
 	[RTW89_EFUSE_BLOCK_SYS]			= {.offset = 0x00000, .size = 0x310},
 	[RTW89_EFUSE_BLOCK_RF]			= {.offset = 0x10000, .size = 0x240},
@@ -292,6 +340,8 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.max_amsdu_limit	= 8000,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x8f800,
+	.hfc_param_ini		= rtw8922a_hfc_param_ini_pcie,
+	.dle_mem		= rtw8922a_dle_mem_pcie,
 	.rf_base_addr		= {0xe000, 0xf000},
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
-- 
2.25.1


