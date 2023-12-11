Return-Path: <linux-wireless+bounces-639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B10980C35A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 09:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330E7280D15
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 08:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E3A210F4;
	Mon, 11 Dec 2023 08:35:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CFA8E
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 00:35:05 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BB8YwQR22598461, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BB8YwQR22598461
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 16:34:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 11 Dec 2023 16:34:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 11 Dec
 2023 16:34:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/6] wifi: rtw89: mac: add suffix _ax to MAC functions
Date: Mon, 11 Dec 2023 16:33:39 +0800
Message-ID: <20231211083341.118047-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211083341.118047-1-pkshih@realtek.com>
References: <20231211083341.118047-1-pkshih@realtek.com>
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

Many existing MAC access functions are used by WiFi 6 chips only, so add
suffix _ax to be clearer. Some are common and can be used by WiFi 7, so
export this kind of functions. This patch doesn't change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 163 ++++++++++++-----------
 drivers/net/wireless/realtek/rtw89/mac.h |  17 ++-
 drivers/net/wireless/realtek/rtw89/wow.c |   7 +-
 3 files changed, 102 insertions(+), 85 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 62c4f407f76d..80ab5fdfdaa0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1172,7 +1172,7 @@ static void hfc_func_en_ax(struct rtw89_dev *rtwdev, bool en, bool h2c_en)
 	rtw89_write32(rtwdev, regs->hci_fc_ctrl, val);
 }
 
-static int hfc_init(struct rtw89_dev *rtwdev, bool reset, bool en, bool h2c_en)
+int rtw89_mac_hfc_init(struct rtw89_dev *rtwdev, bool reset, bool en, bool h2c_en)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -1495,7 +1495,7 @@ void rtw89_mac_pwr_off(struct rtw89_dev *rtwdev)
 	rtw89_mac_power_switch(rtwdev, false);
 }
 
-static int cmac_func_en(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
+static int cmac_func_en_ax(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
 {
 	u32 func_en = 0;
 	u32 ck_en = 0;
@@ -1541,7 +1541,7 @@ static int cmac_func_en(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
 	return 0;
 }
 
-static int dmac_func_en(struct rtw89_dev *rtwdev)
+static int dmac_func_en_ax(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 val32;
@@ -1573,7 +1573,7 @@ static int dmac_func_en(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int chip_func_en(struct rtw89_dev *rtwdev)
+static int chip_func_en_ax(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 
@@ -1584,19 +1584,19 @@ static int chip_func_en(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int rtw89_mac_sys_init(struct rtw89_dev *rtwdev)
+static int sys_init_ax(struct rtw89_dev *rtwdev)
 {
 	int ret;
 
-	ret = dmac_func_en(rtwdev);
+	ret = dmac_func_en_ax(rtwdev);
 	if (ret)
 		return ret;
 
-	ret = cmac_func_en(rtwdev, 0, true);
+	ret = cmac_func_en_ax(rtwdev, 0, true);
 	if (ret)
 		return ret;
 
-	ret = chip_func_en(rtwdev);
+	ret = chip_func_en_ax(rtwdev);
 	if (ret)
 		return ret;
 
@@ -2041,8 +2041,8 @@ static void dle_quota_cfg(struct rtw89_dev *rtwdev,
 	mac->ple_quota_cfg(rtwdev, cfg->ple_min_qt, cfg->ple_max_qt);
 }
 
-static int dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
-		    enum rtw89_qta_mode ext_mode)
+int rtw89_mac_dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
+		       enum rtw89_qta_mode ext_mode)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_dle_mem *cfg, *ext_cfg;
@@ -2138,8 +2138,8 @@ static bool is_qta_poh(struct rtw89_dev *rtwdev)
 	return rtwdev->hci.type == RTW89_HCI_TYPE_PCIE;
 }
 
-static int preload_init(struct rtw89_dev *rtwdev, enum rtw89_mac_idx mac_idx,
-			enum rtw89_qta_mode mode)
+int rtw89_mac_preload_init(struct rtw89_dev *rtwdev, enum rtw89_mac_idx mac_idx,
+			   enum rtw89_qta_mode mode)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
@@ -2188,7 +2188,7 @@ static void _patch_ss2f_path(struct rtw89_dev *rtwdev)
 			   SS2F_PATH_WLCPU);
 }
 
-static int sta_sch_init(struct rtw89_dev *rtwdev)
+static int sta_sch_init_ax(struct rtw89_dev *rtwdev)
 {
 	u32 p_val;
 	u8 val;
@@ -2217,7 +2217,7 @@ static int sta_sch_init(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int mpdu_proc_init(struct rtw89_dev *rtwdev)
+static int mpdu_proc_init_ax(struct rtw89_dev *rtwdev)
 {
 	int ret;
 
@@ -2234,7 +2234,7 @@ static int mpdu_proc_init(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int sec_eng_init(struct rtw89_dev *rtwdev)
+static int sec_eng_init_ax(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 val = 0;
@@ -2269,41 +2269,41 @@ static int sec_eng_init(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int dmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
+static int dmac_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	int ret;
 
-	ret = dle_init(rtwdev, rtwdev->mac.qta_mode, RTW89_QTA_INVALID);
+	ret = rtw89_mac_dle_init(rtwdev, rtwdev->mac.qta_mode, RTW89_QTA_INVALID);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]DLE init %d\n", ret);
 		return ret;
 	}
 
-	ret = preload_init(rtwdev, RTW89_MAC_0, rtwdev->mac.qta_mode);
+	ret = rtw89_mac_preload_init(rtwdev, RTW89_MAC_0, rtwdev->mac.qta_mode);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]preload init %d\n", ret);
 		return ret;
 	}
 
-	ret = hfc_init(rtwdev, true, true, true);
+	ret = rtw89_mac_hfc_init(rtwdev, true, true, true);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]HCI FC init %d\n", ret);
 		return ret;
 	}
 
-	ret = sta_sch_init(rtwdev);
+	ret = sta_sch_init_ax(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]STA SCH init %d\n", ret);
 		return ret;
 	}
 
-	ret = mpdu_proc_init(rtwdev);
+	ret = mpdu_proc_init_ax(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]MPDU Proc init %d\n", ret);
 		return ret;
 	}
 
-	ret = sec_eng_init(rtwdev);
+	ret = sec_eng_init_ax(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]Security Engine init %d\n", ret);
 		return ret;
@@ -2312,7 +2312,7 @@ static int dmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	return ret;
 }
 
-static int addr_cam_init(struct rtw89_dev *rtwdev, u8 mac_idx)
+static int addr_cam_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	u32 val, reg;
 	u16 p_val;
@@ -2339,7 +2339,7 @@ static int addr_cam_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	return 0;
 }
 
-static int scheduler_init(struct rtw89_dev *rtwdev, u8 mac_idx)
+static int scheduler_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	u32 ret;
 	u32 reg;
@@ -2380,10 +2380,10 @@ static int scheduler_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	return 0;
 }
 
-int rtw89_mac_typ_fltr_opt(struct rtw89_dev *rtwdev,
-			   enum rtw89_machdr_frame_type type,
-			   enum rtw89_mac_fwd_target fwd_target,
-			   u8 mac_idx)
+static int rtw89_mac_typ_fltr_opt_ax(struct rtw89_dev *rtwdev,
+				     enum rtw89_machdr_frame_type type,
+				     enum rtw89_mac_fwd_target fwd_target,
+				     u8 mac_idx)
 {
 	u32 reg;
 	u32 val;
@@ -2422,7 +2422,7 @@ int rtw89_mac_typ_fltr_opt(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-static int rx_fltr_init(struct rtw89_dev *rtwdev, u8 mac_idx)
+static int rx_fltr_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	int ret, i;
 	u32 mac_ftlr, plcp_ftlr;
@@ -2432,8 +2432,8 @@ static int rx_fltr_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 		return ret;
 
 	for (i = RTW89_MGNT; i <= RTW89_DATA; i++) {
-		ret = rtw89_mac_typ_fltr_opt(rtwdev, i, RTW89_FWD_TO_HOST,
-					     mac_idx);
+		ret = rtw89_mac_typ_fltr_opt_ax(rtwdev, i, RTW89_FWD_TO_HOST,
+						mac_idx);
 		if (ret)
 			return ret;
 	}
@@ -2484,7 +2484,7 @@ static void _patch_dis_resp_chk(struct rtw89_dev *rtwdev, u8 mac_idx)
 	}
 }
 
-static int cca_ctrl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
+static int cca_ctrl_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	u32 val, reg;
 	int ret;
@@ -2516,7 +2516,7 @@ static int cca_ctrl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	return 0;
 }
 
-static int nav_ctrl_init(struct rtw89_dev *rtwdev)
+static int nav_ctrl_init_ax(struct rtw89_dev *rtwdev)
 {
 	rtw89_write32_set(rtwdev, R_AX_WMAC_NAV_CTL, B_AX_WMAC_PLCP_UP_NAV_EN |
 						     B_AX_WMAC_TF_UP_NAV_EN |
@@ -2526,7 +2526,7 @@ static int nav_ctrl_init(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int spatial_reuse_init(struct rtw89_dev *rtwdev, u8 mac_idx)
+static int spatial_reuse_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	u32 reg;
 	int ret;
@@ -2540,7 +2540,7 @@ static int spatial_reuse_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	return 0;
 }
 
-static int tmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
+static int tmac_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	u32 reg;
 	int ret;
@@ -2562,7 +2562,7 @@ static int tmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	return 0;
 }
 
-static int trxptcl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
+static int trxptcl_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_rrsr_cfgs *rrsr = chip->rrsr_cfgs;
@@ -2619,7 +2619,7 @@ static void rst_bacam(struct rtw89_dev *rtwdev)
 		rtw89_warn(rtwdev, "failed to reset BA CAM\n");
 }
 
-static int rmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
+static int rmac_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 #define TRXCFG_RMAC_CCA_TO	32
 #define TRXCFG_RMAC_DATA_TO	15
@@ -2677,7 +2677,7 @@ static int rmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	return ret;
 }
 
-static int cmac_com_init(struct rtw89_dev *rtwdev, u8 mac_idx)
+static int cmac_com_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 val, reg;
@@ -2702,7 +2702,7 @@ static int cmac_com_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	return 0;
 }
 
-static bool is_qta_dbcc(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
+bool rtw89_mac_is_qta_dbcc(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
 {
 	const struct rtw89_dle_mem *cfg;
 
@@ -2715,7 +2715,7 @@ static bool is_qta_dbcc(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
 	return (cfg->ple_min_qt->cma1_dma && cfg->ple_max_qt->cma1_dma);
 }
 
-static int ptcl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
+static int ptcl_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	u32 val, reg;
 	int ret;
@@ -2758,7 +2758,7 @@ static int ptcl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	return 0;
 }
 
-static int cmac_dma_init(struct rtw89_dev *rtwdev, u8 mac_idx)
+static int cmac_dma_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 reg;
@@ -2777,82 +2777,82 @@ static int cmac_dma_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	return 0;
 }
 
-static int cmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
+static int cmac_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	int ret;
 
-	ret = scheduler_init(rtwdev, mac_idx);
+	ret = scheduler_init_ax(rtwdev, mac_idx);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC%d SCH init %d\n", mac_idx, ret);
 		return ret;
 	}
 
-	ret = addr_cam_init(rtwdev, mac_idx);
+	ret = addr_cam_init_ax(rtwdev, mac_idx);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC%d ADDR_CAM reset %d\n", mac_idx,
 			  ret);
 		return ret;
 	}
 
-	ret = rx_fltr_init(rtwdev, mac_idx);
+	ret = rx_fltr_init_ax(rtwdev, mac_idx);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC%d RX filter init %d\n", mac_idx,
 			  ret);
 		return ret;
 	}
 
-	ret = cca_ctrl_init(rtwdev, mac_idx);
+	ret = cca_ctrl_init_ax(rtwdev, mac_idx);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC%d CCA CTRL init %d\n", mac_idx,
 			  ret);
 		return ret;
 	}
 
-	ret = nav_ctrl_init(rtwdev);
+	ret = nav_ctrl_init_ax(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC%d NAV CTRL init %d\n", mac_idx,
 			  ret);
 		return ret;
 	}
 
-	ret = spatial_reuse_init(rtwdev, mac_idx);
+	ret = spatial_reuse_init_ax(rtwdev, mac_idx);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC%d Spatial Reuse init %d\n",
 			  mac_idx, ret);
 		return ret;
 	}
 
-	ret = tmac_init(rtwdev, mac_idx);
+	ret = tmac_init_ax(rtwdev, mac_idx);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC%d TMAC init %d\n", mac_idx, ret);
 		return ret;
 	}
 
-	ret = trxptcl_init(rtwdev, mac_idx);
+	ret = trxptcl_init_ax(rtwdev, mac_idx);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC%d TRXPTCL init %d\n", mac_idx, ret);
 		return ret;
 	}
 
-	ret = rmac_init(rtwdev, mac_idx);
+	ret = rmac_init_ax(rtwdev, mac_idx);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC%d RMAC init %d\n", mac_idx, ret);
 		return ret;
 	}
 
-	ret = cmac_com_init(rtwdev, mac_idx);
+	ret = cmac_com_init_ax(rtwdev, mac_idx);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC%d Com init %d\n", mac_idx, ret);
 		return ret;
 	}
 
-	ret = ptcl_init(rtwdev, mac_idx);
+	ret = ptcl_init_ax(rtwdev, mac_idx);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC%d PTCL init %d\n", mac_idx, ret);
 		return ret;
 	}
 
-	ret = cmac_dma_init(rtwdev, mac_idx);
+	ret = cmac_dma_init_ax(rtwdev, mac_idx);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC%d DMA init %d\n", mac_idx, ret);
 		return ret;
@@ -3192,7 +3192,7 @@ static int set_cpuio_ax(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-static int dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
+int rtw89_mac_dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_dle_mem *cfg;
@@ -3275,7 +3275,7 @@ static int band_idle_ck_b(struct rtw89_dev *rtwdev, u8 mac_idx)
 	return 0;
 }
 
-static int band1_enable(struct rtw89_dev *rtwdev)
+static int band1_enable_ax(struct rtw89_dev *rtwdev)
 {
 	int ret, i;
 	u32 sleep_bak[4] = {0};
@@ -3301,7 +3301,7 @@ static int band1_enable(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
-	ret = dle_quota_change(rtwdev, rtwdev->mac.qta_mode);
+	ret = rtw89_mac_dle_quota_change(rtwdev, rtwdev->mac.qta_mode);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]DLE quota change %d\n", ret);
 		return ret;
@@ -3318,13 +3318,13 @@ static int band1_enable(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
-	ret = cmac_func_en(rtwdev, 1, true);
+	ret = cmac_func_en_ax(rtwdev, 1, true);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC1 func en %d\n", ret);
 		return ret;
 	}
 
-	ret = cmac_init(rtwdev, 1);
+	ret = cmac_init_ax(rtwdev, 1);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC1 init %d\n", ret);
 		return ret;
@@ -3533,8 +3533,8 @@ static void rtw89_tmac_imr_enable(struct rtw89_dev *rtwdev, u8 mac_idx)
 	rtw89_write32_set(rtwdev, reg, imr->tmac_imr_set);
 }
 
-static int rtw89_mac_enable_imr(struct rtw89_dev *rtwdev, u8 mac_idx,
-				enum rtw89_mac_hwmod_sel sel)
+static int enable_imr_ax(struct rtw89_dev *rtwdev, u8 mac_idx,
+			 enum rtw89_mac_hwmod_sel sel)
 {
 	int ret;
 
@@ -3571,7 +3571,7 @@ static int rtw89_mac_enable_imr(struct rtw89_dev *rtwdev, u8 mac_idx,
 	return 0;
 }
 
-static void rtw89_mac_err_imr_ctrl(struct rtw89_dev *rtwdev, bool en)
+static void err_imr_ctrl_ax(struct rtw89_dev *rtwdev, bool en)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 
@@ -3584,18 +3584,18 @@ static void rtw89_mac_err_imr_ctrl(struct rtw89_dev *rtwdev, bool en)
 			      en ? CMAC1_ERR_IMR_EN : CMAC1_ERR_IMR_DIS);
 }
 
-static int rtw89_mac_dbcc_enable(struct rtw89_dev *rtwdev, bool enable)
+static int dbcc_enable_ax(struct rtw89_dev *rtwdev, bool enable)
 {
 	int ret = 0;
 
 	if (enable) {
-		ret = band1_enable(rtwdev);
+		ret = band1_enable_ax(rtwdev);
 		if (ret) {
 			rtw89_err(rtwdev, "[ERR] band1_enable %d\n", ret);
 			return ret;
 		}
 
-		ret = rtw89_mac_enable_imr(rtwdev, RTW89_MAC_1, RTW89_CMAC_SEL);
+		ret = enable_imr_ax(rtwdev, RTW89_MAC_1, RTW89_CMAC_SEL);
 		if (ret) {
 			rtw89_err(rtwdev, "[ERR] enable CMAC1 IMR %d\n", ret);
 			return ret;
@@ -3608,7 +3608,7 @@ static int rtw89_mac_dbcc_enable(struct rtw89_dev *rtwdev, bool enable)
 	return 0;
 }
 
-static int set_host_rpr(struct rtw89_dev *rtwdev)
+static int set_host_rpr_ax(struct rtw89_dev *rtwdev)
 {
 	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE) {
 		rtw89_write32_mask(rtwdev, R_AX_WDRLS_CFG,
@@ -3628,46 +3628,46 @@ static int set_host_rpr(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int rtw89_mac_trx_init(struct rtw89_dev *rtwdev)
+static int trx_init_ax(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_qta_mode qta_mode = rtwdev->mac.qta_mode;
 	int ret;
 
-	ret = dmac_init(rtwdev, 0);
+	ret = dmac_init_ax(rtwdev, 0);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]DMAC init %d\n", ret);
 		return ret;
 	}
 
-	ret = cmac_init(rtwdev, 0);
+	ret = cmac_init_ax(rtwdev, 0);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC%d init %d\n", 0, ret);
 		return ret;
 	}
 
-	if (is_qta_dbcc(rtwdev, qta_mode)) {
-		ret = rtw89_mac_dbcc_enable(rtwdev, true);
+	if (rtw89_mac_is_qta_dbcc(rtwdev, qta_mode)) {
+		ret = dbcc_enable_ax(rtwdev, true);
 		if (ret) {
 			rtw89_err(rtwdev, "[ERR]dbcc_enable init %d\n", ret);
 			return ret;
 		}
 	}
 
-	ret = rtw89_mac_enable_imr(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
+	ret = enable_imr_ax(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR] enable DMAC IMR %d\n", ret);
 		return ret;
 	}
 
-	ret = rtw89_mac_enable_imr(rtwdev, RTW89_MAC_0, RTW89_CMAC_SEL);
+	ret = enable_imr_ax(rtwdev, RTW89_MAC_0, RTW89_CMAC_SEL);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR] to enable CMAC0 IMR %d\n", ret);
 		return ret;
 	}
 
-	rtw89_mac_err_imr_ctrl(rtwdev, true);
+	err_imr_ctrl_ax(rtwdev, true);
 
-	ret = set_host_rpr(rtwdev);
+	ret = set_host_rpr_ax(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR] set host rpr %d\n", ret);
 		return ret;
@@ -3809,13 +3809,13 @@ static int rtw89_mac_dmac_pre_init(struct rtw89_dev *rtwdev)
 	mac->hci_func_en(rtwdev);
 	mac->dmac_func_pre_en(rtwdev);
 
-	ret = dle_init(rtwdev, RTW89_QTA_DLFW, rtwdev->mac.qta_mode);
+	ret = rtw89_mac_dle_init(rtwdev, RTW89_QTA_DLFW, rtwdev->mac.qta_mode);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]DLE pre init %d\n", ret);
 		return ret;
 	}
 
-	ret = hfc_init(rtwdev, true, false, true);
+	ret = rtw89_mac_hfc_init(rtwdev, true, false, true);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]HCI FC pre init %d\n", ret);
 		return ret;
@@ -3889,6 +3889,7 @@ int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb)
 
 int rtw89_mac_init(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	bool include_bb = !!chip->bbmcu_nr;
 	int ret;
@@ -3901,11 +3902,11 @@ int rtw89_mac_init(struct rtw89_dev *rtwdev)
 	if (ret)
 		goto fail;
 
-	ret = rtw89_mac_sys_init(rtwdev);
+	ret = mac->sys_init(rtwdev);
 	if (ret)
 		goto fail;
 
-	ret = rtw89_mac_trx_init(rtwdev);
+	ret = mac->trx_init(rtwdev);
 	if (ret)
 		goto fail;
 
@@ -6106,12 +6107,16 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	},
 
 	.check_mac_en = rtw89_mac_check_mac_en_ax,
+	.sys_init = sys_init_ax,
+	.trx_init = trx_init_ax,
 	.hci_func_en = rtw89_mac_hci_func_en_ax,
 	.dmac_func_pre_en = rtw89_mac_dmac_func_pre_en_ax,
 	.dle_func_en = dle_func_en_ax,
 	.dle_clk_en = dle_clk_en_ax,
 	.bf_assoc = rtw89_mac_bf_assoc_ax,
 
+	.typ_fltr_opt = rtw89_mac_typ_fltr_opt_ax,
+
 	.dle_mix_cfg = dle_mix_cfg_ax,
 	.chk_dle_rdy = chk_dle_rdy_ax,
 	.dle_buf_req = dle_buf_req_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 2b5deb6ce9de..56cd81347784 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -900,6 +900,8 @@ struct rtw89_mac_gen_def {
 
 	int (*check_mac_en)(struct rtw89_dev *rtwdev, u8 band,
 			    enum rtw89_mac_hwmod_sel sel);
+	int (*sys_init)(struct rtw89_dev *rtwdev);
+	int (*trx_init)(struct rtw89_dev *rtwdev);
 	void (*hci_func_en)(struct rtw89_dev *rtwdev);
 	void (*dmac_func_pre_en)(struct rtw89_dev *rtwdev);
 	void (*dle_func_en)(struct rtw89_dev *rtwdev, bool enable);
@@ -907,6 +909,11 @@ struct rtw89_mac_gen_def {
 	void (*bf_assoc)(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			 struct ieee80211_sta *sta);
 
+	int (*typ_fltr_opt)(struct rtw89_dev *rtwdev,
+			    enum rtw89_machdr_frame_type type,
+			    enum rtw89_mac_fwd_target fwd_target,
+			    u8 mac_idx);
+
 	int (*dle_mix_cfg)(struct rtw89_dev *rtwdev, const struct rtw89_dle_mem *cfg);
 	int (*chk_dle_rdy)(struct rtw89_dev *rtwdev, bool wde_or_ple);
 	int (*dle_buf_req)(struct rtw89_dev *rtwdev, u16 buf_len, bool wd, u16 *pkt_id);
@@ -1046,6 +1053,12 @@ rtw89_write32_port_set(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 void rtw89_mac_pwr_off(struct rtw89_dev *rtwdev);
 int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb);
 int rtw89_mac_init(struct rtw89_dev *rtwdev);
+int rtw89_mac_dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
+		       enum rtw89_qta_mode ext_mode);
+int rtw89_mac_hfc_init(struct rtw89_dev *rtwdev, bool reset, bool en, bool h2c_en);
+int rtw89_mac_preload_init(struct rtw89_dev *rtwdev, enum rtw89_mac_idx mac_idx,
+			   enum rtw89_qta_mode mode);
+bool rtw89_mac_is_qta_dbcc(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode);
 static inline
 int rtw89_mac_check_mac_en(struct rtw89_dev *rtwdev, u8 band,
 			   enum rtw89_mac_hwmod_sel sel)
@@ -1330,13 +1343,11 @@ int rtw89_mac_read_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
 }
 
 void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
-int rtw89_mac_typ_fltr_opt(struct rtw89_dev *rtwdev,
-			   enum rtw89_machdr_frame_type type,
-			   enum rtw89_mac_fwd_target fwd_target, u8 mac_idx);
 int rtw89_mac_resize_ple_rx_quota(struct rtw89_dev *rtwdev, bool wow);
 int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 					enum rtw89_mac_idx band);
 void rtw89_mac_hw_mgnt_sec(struct rtw89_dev *rtwdev, bool wow);
+int rtw89_mac_dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode);
 int rtw89_mac_get_dle_rsvd_qt_cfg(struct rtw89_dev *rtwdev,
 				  enum rtw89_mac_dle_rsvd_qt_type type,
 				  struct rtw89_mac_dle_rsvd_qt_cfg *cfg);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 660bf2ece927..5c7ca36c09b6 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -73,13 +73,14 @@ static int rtw89_wow_config_mac(struct rtw89_dev *rtwdev, bool enable_wow)
 
 static void rtw89_wow_set_rx_filter(struct rtw89_dev *rtwdev, bool enable)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	enum rtw89_mac_fwd_target fwd_target = enable ?
 					       RTW89_FWD_DONT_CARE :
 					       RTW89_FWD_TO_HOST;
 
-	rtw89_mac_typ_fltr_opt(rtwdev, RTW89_MGNT, fwd_target, RTW89_MAC_0);
-	rtw89_mac_typ_fltr_opt(rtwdev, RTW89_CTRL, fwd_target, RTW89_MAC_0);
-	rtw89_mac_typ_fltr_opt(rtwdev, RTW89_DATA, fwd_target, RTW89_MAC_0);
+	mac->typ_fltr_opt(rtwdev, RTW89_MGNT, fwd_target, RTW89_MAC_0);
+	mac->typ_fltr_opt(rtwdev, RTW89_CTRL, fwd_target, RTW89_MAC_0);
+	mac->typ_fltr_opt(rtwdev, RTW89_DATA, fwd_target, RTW89_MAC_0);
 }
 
 static void rtw89_wow_show_wakeup_reason(struct rtw89_dev *rtwdev)
-- 
2.25.1


