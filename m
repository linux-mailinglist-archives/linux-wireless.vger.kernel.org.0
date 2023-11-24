Return-Path: <linux-wireless+bounces-32-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1827F6CC9
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 08:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBC128150A
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 07:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F7D63C4;
	Fri, 24 Nov 2023 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5075FD71
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 23:18:21 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AO7IDW303551168, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AO7IDW303551168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 15:18:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Nov 2023 15:18:14 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 24 Nov
 2023 15:18:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/8] wifi: rtw89: mac: use pointer to access functions of hardware engine and quota
Date: Fri, 24 Nov 2023 15:17:02 +0800
Message-ID: <20231124071703.132549-8-pkshih@realtek.com>
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

To share flow with WiFi 7 chips, abstract functions related hardware
engines and their quota, so use pointer to access them. This doesn't change
logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c |   5 +-
 drivers/net/wireless/realtek/rtw89/mac.c   | 104 +++++++++++++--------
 drivers/net/wireless/realtek/rtw89/mac.h   |  24 ++++-
 3 files changed, 87 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index a3f795d240ea..a2237aa95ccf 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3330,13 +3330,14 @@ rtw89_debug_priv_early_h2c_set(struct file *filp, const char __user *user_buf,
 
 static int rtw89_dbg_trigger_ctrl_error(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_cpuio_ctrl ctrl_para = {0};
 	u16 pkt_id;
 	int ret;
 
 	rtw89_leave_ps_mode(rtwdev);
 
-	ret = rtw89_mac_dle_buf_req(rtwdev, 0x20, true, &pkt_id);
+	ret = mac->dle_buf_req(rtwdev, 0x20, true, &pkt_id);
 	if (ret)
 		return ret;
 
@@ -3348,7 +3349,7 @@ static int rtw89_dbg_trigger_ctrl_error(struct rtw89_dev *rtwdev)
 	ctrl_para.dst_pid = WDE_DLE_PORT_ID_WDRLS;
 	ctrl_para.dst_qid = WDE_DLE_QUEID_NO_REPORT;
 
-	if (rtw89_mac_set_cpuio(rtwdev, &ctrl_para, true))
+	if (mac->set_cpuio(rtwdev, &ctrl_para, true))
 		return -EFAULT;
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index be063f73573b..c3dac7a6c377 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -901,7 +901,7 @@ static int hfc_pub_ctrl(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static void hfc_get_mix_info(struct rtw89_dev *rtwdev)
+static void hfc_get_mix_info_ax(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_page_regs *regs = chip->page_regs;
@@ -958,6 +958,7 @@ static void hfc_get_mix_info(struct rtw89_dev *rtwdev)
 
 static int hfc_upd_mix_info(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
 	int ret;
 
@@ -965,7 +966,7 @@ static int hfc_upd_mix_info(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	hfc_get_mix_info(rtwdev);
+	mac->hfc_get_mix_info(rtwdev);
 
 	ret = hfc_pub_info_chk(rtwdev);
 	if (param->en && ret)
@@ -974,7 +975,7 @@ static int hfc_upd_mix_info(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static void hfc_h2c_cfg(struct rtw89_dev *rtwdev)
+static void hfc_h2c_cfg_ax(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_page_regs *regs = chip->page_regs;
@@ -990,7 +991,7 @@ static void hfc_h2c_cfg(struct rtw89_dev *rtwdev)
 			   prec_cfg->h2c_full_cond);
 }
 
-static void hfc_mix_cfg(struct rtw89_dev *rtwdev)
+static void hfc_mix_cfg_ax(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_page_regs *regs = chip->page_regs;
@@ -1025,7 +1026,7 @@ static void hfc_mix_cfg(struct rtw89_dev *rtwdev)
 	rtw89_write32(rtwdev, regs->hci_fc_ctrl, val);
 }
 
-static void hfc_func_en(struct rtw89_dev *rtwdev, bool en, bool h2c_en)
+static void hfc_func_en_ax(struct rtw89_dev *rtwdev, bool en, bool h2c_en)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_page_regs *regs = chip->page_regs;
@@ -1043,6 +1044,7 @@ static void hfc_func_en(struct rtw89_dev *rtwdev, bool en, bool h2c_en)
 
 static int hfc_init(struct rtw89_dev *rtwdev, bool reset, bool en, bool h2c_en)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 dma_ch_mask = chip->dma_ch_mask;
 	u8 ch;
@@ -1057,11 +1059,11 @@ static int hfc_init(struct rtw89_dev *rtwdev, bool reset, bool en, bool h2c_en)
 	if (ret)
 		return ret;
 
-	hfc_func_en(rtwdev, false, false);
+	mac->hfc_func_en(rtwdev, false, false);
 
 	if (!en && h2c_en) {
-		hfc_h2c_cfg(rtwdev);
-		hfc_func_en(rtwdev, en, h2c_en);
+		mac->hfc_h2c_cfg(rtwdev);
+		mac->hfc_func_en(rtwdev, en, h2c_en);
 		return ret;
 	}
 
@@ -1077,9 +1079,9 @@ static int hfc_init(struct rtw89_dev *rtwdev, bool reset, bool en, bool h2c_en)
 	if (ret)
 		return ret;
 
-	hfc_mix_cfg(rtwdev);
+	mac->hfc_mix_cfg(rtwdev);
 	if (en || h2c_en) {
-		hfc_func_en(rtwdev, en, h2c_en);
+		mac->hfc_func_en(rtwdev, en, h2c_en);
 		udelay(10);
 	}
 	for (ch = RTW89_DMA_ACH0; ch < RTW89_DMA_H2C; ch++) {
@@ -1707,7 +1709,7 @@ static u32 dle_expected_used_size(struct rtw89_dev *rtwdev,
 	return size;
 }
 
-static void dle_func_en(struct rtw89_dev *rtwdev, bool enable)
+static void dle_func_en_ax(struct rtw89_dev *rtwdev, bool enable)
 {
 	if (enable)
 		rtw89_write32_set(rtwdev, R_AX_DMAC_FUNC_EN,
@@ -1717,7 +1719,7 @@ static void dle_func_en(struct rtw89_dev *rtwdev, bool enable)
 				  B_AX_DLE_WDE_EN | B_AX_DLE_PLE_EN);
 }
 
-static void dle_clk_en(struct rtw89_dev *rtwdev, bool enable)
+static void dle_clk_en_ax(struct rtw89_dev *rtwdev, bool enable)
 {
 	u32 val = B_AX_DLE_WDE_CLK_EN | B_AX_DLE_PLE_CLK_EN;
 
@@ -1730,7 +1732,7 @@ static void dle_clk_en(struct rtw89_dev *rtwdev, bool enable)
 	}
 }
 
-static int dle_mix_cfg(struct rtw89_dev *rtwdev, const struct rtw89_dle_mem *cfg)
+static int dle_mix_cfg_ax(struct rtw89_dev *rtwdev, const struct rtw89_dle_mem *cfg)
 {
 	const struct rtw89_dle_size *size_cfg;
 	u32 val;
@@ -1787,7 +1789,7 @@ static int dle_mix_cfg(struct rtw89_dev *rtwdev, const struct rtw89_dle_mem *cfg
 	return 0;
 }
 
-static int chk_dle_rdy(struct rtw89_dev *rtwdev, bool wde_or_ple)
+static int chk_dle_rdy_ax(struct rtw89_dev *rtwdev, bool wde_or_ple)
 {
 	u32 reg, mask;
 	u32 ini;
@@ -1816,10 +1818,10 @@ static int chk_dle_rdy(struct rtw89_dev *rtwdev, bool wde_or_ple)
 #define SET_QUOTA(_x, _module, _idx)					\
 	SET_QUOTA_VAL(min_cfg->_x, max_cfg->_x, _module, _idx)
 
-static void wde_quota_cfg(struct rtw89_dev *rtwdev,
-			  const struct rtw89_wde_quota *min_cfg,
-			  const struct rtw89_wde_quota *max_cfg,
-			  u16 ext_wde_min_qt_wcpu)
+static void wde_quota_cfg_ax(struct rtw89_dev *rtwdev,
+			     const struct rtw89_wde_quota *min_cfg,
+			     const struct rtw89_wde_quota *max_cfg,
+			     u16 ext_wde_min_qt_wcpu)
 {
 	u16 min_qt_wcpu = ext_wde_min_qt_wcpu != INVALID_QT_WCPU ?
 			  ext_wde_min_qt_wcpu : min_cfg->wcpu;
@@ -1831,9 +1833,9 @@ static void wde_quota_cfg(struct rtw89_dev *rtwdev,
 	SET_QUOTA(cpu_io, WDE, 4);
 }
 
-static void ple_quota_cfg(struct rtw89_dev *rtwdev,
-			  const struct rtw89_ple_quota *min_cfg,
-			  const struct rtw89_ple_quota *max_cfg)
+static void ple_quota_cfg_ax(struct rtw89_dev *rtwdev,
+			     const struct rtw89_ple_quota *min_cfg,
+			     const struct rtw89_ple_quota *max_cfg)
 {
 	u32 val;
 
@@ -1898,16 +1900,19 @@ static void dle_quota_cfg(struct rtw89_dev *rtwdev,
 			  const struct rtw89_dle_mem *cfg,
 			  u16 ext_wde_min_qt_wcpu)
 {
-	wde_quota_cfg(rtwdev, cfg->wde_min_qt, cfg->wde_max_qt, ext_wde_min_qt_wcpu);
-	ple_quota_cfg(rtwdev, cfg->ple_min_qt, cfg->ple_max_qt);
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	mac->wde_quota_cfg(rtwdev, cfg->wde_min_qt, cfg->wde_max_qt, ext_wde_min_qt_wcpu);
+	mac->ple_quota_cfg(rtwdev, cfg->ple_min_qt, cfg->ple_max_qt);
 }
 
 static int dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
 		    enum rtw89_qta_mode ext_mode)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_dle_mem *cfg, *ext_cfg;
 	u16 ext_wde_min_qt_wcpu = INVALID_QT_WCPU;
-	int ret = 0;
+	int ret;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
 	if (ret)
@@ -1937,25 +1942,25 @@ static int dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
 		goto error;
 	}
 
-	dle_func_en(rtwdev, false);
-	dle_clk_en(rtwdev, true);
+	mac->dle_func_en(rtwdev, false);
+	mac->dle_clk_en(rtwdev, true);
 
-	ret = dle_mix_cfg(rtwdev, cfg);
+	ret = mac->dle_mix_cfg(rtwdev, cfg);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR] dle mix cfg\n");
 		goto error;
 	}
 	dle_quota_cfg(rtwdev, cfg, ext_wde_min_qt_wcpu);
 
-	dle_func_en(rtwdev, true);
+	mac->dle_func_en(rtwdev, true);
 
-	ret = chk_dle_rdy(rtwdev, true);
+	ret = mac->chk_dle_rdy(rtwdev, true);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]WDE cfg ready\n");
 		return ret;
 	}
 
-	ret = chk_dle_rdy(rtwdev, false);
+	ret = mac->chk_dle_rdy(rtwdev, false);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]PLE cfg ready\n");
 		return ret;
@@ -1963,7 +1968,7 @@ static int dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
 
 	return 0;
 error:
-	dle_func_en(rtwdev, false);
+	mac->dle_func_en(rtwdev, false);
 	rtw89_err(rtwdev, "[ERR]trxcfg wde 0x8900 = %x\n",
 		  rtw89_read32(rtwdev, R_AX_WDE_INI_STATUS));
 	rtw89_err(rtwdev, "[ERR]trxcfg ple 0x8D00 = %x\n",
@@ -2975,7 +2980,7 @@ int rtw89_mac_resume_sch_tx_v1(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en)
 }
 EXPORT_SYMBOL(rtw89_mac_resume_sch_tx_v1);
 
-int rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len, bool wd, u16 *pkt_id)
+static int dle_buf_req_ax(struct rtw89_dev *rtwdev, u16 buf_len, bool wd, u16 *pkt_id)
 {
 	u32 val, reg;
 	int ret;
@@ -2999,7 +3004,7 @@ int rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len, bool wd, u16 *p
 	return 0;
 }
 
-int rtw89_mac_set_cpuio(struct rtw89_dev *rtwdev,
+static int set_cpuio_ax(struct rtw89_dev *rtwdev,
 			struct rtw89_cpuio_ctrl *ctrl_para, bool wd)
 {
 	u32 val, cmd_type, reg;
@@ -3054,6 +3059,7 @@ int rtw89_mac_set_cpuio(struct rtw89_dev *rtwdev,
 
 static int dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_dle_mem *cfg;
 	struct rtw89_cpuio_ctrl ctrl_para = {0};
 	u16 pkt_id;
@@ -3072,7 +3078,7 @@ static int dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
 
 	dle_quota_cfg(rtwdev, cfg, INVALID_QT_WCPU);
 
-	ret = rtw89_mac_dle_buf_req(rtwdev, 0x20, true, &pkt_id);
+	ret = mac->dle_buf_req(rtwdev, 0x20, true, &pkt_id);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]WDE DLE buf req\n");
 		return ret;
@@ -3084,13 +3090,13 @@ static int dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
 	ctrl_para.pkt_num = 0;
 	ctrl_para.dst_pid = WDE_DLE_PORT_ID_WDRLS;
 	ctrl_para.dst_qid = WDE_DLE_QUEID_NO_REPORT;
-	ret = rtw89_mac_set_cpuio(rtwdev, &ctrl_para, true);
+	ret = mac->set_cpuio(rtwdev, &ctrl_para, true);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]WDE DLE enqueue to head\n");
 		return -EFAULT;
 	}
 
-	ret = rtw89_mac_dle_buf_req(rtwdev, 0x20, false, &pkt_id);
+	ret = mac->dle_buf_req(rtwdev, 0x20, false, &pkt_id);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]PLE DLE buf req\n");
 		return ret;
@@ -3102,7 +3108,7 @@ static int dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
 	ctrl_para.pkt_num = 0;
 	ctrl_para.dst_pid = PLE_DLE_PORT_ID_PLRLS;
 	ctrl_para.dst_qid = PLE_DLE_QUEID_NO_REPORT;
-	ret = rtw89_mac_set_cpuio(rtwdev, &ctrl_para, false);
+	ret = mac->set_cpuio(rtwdev, &ctrl_para, false);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]PLE DLE enqueue to head\n");
 		return -EFAULT;
@@ -3617,7 +3623,7 @@ static int rtw89_mac_enable_cpu_ax(struct rtw89_dev *rtwdev, u8 boot_reason,
 	return 0;
 }
 
-static void rtw89_mac_hci_func_en(struct rtw89_dev *rtwdev)
+static void rtw89_mac_hci_func_en_ax(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 val;
@@ -3631,7 +3637,7 @@ static void rtw89_mac_hci_func_en(struct rtw89_dev *rtwdev)
 	rtw89_write32(rtwdev, R_AX_DMAC_FUNC_EN, val);
 }
 
-static void rtw89_mac_dmac_func_pre_en(struct rtw89_dev *rtwdev)
+static void rtw89_mac_dmac_func_pre_en_ax(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 val;
@@ -3662,10 +3668,11 @@ static void rtw89_mac_dmac_func_pre_en(struct rtw89_dev *rtwdev)
 
 static int rtw89_mac_dmac_pre_init(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	int ret;
 
-	rtw89_mac_hci_func_en(rtwdev);
-	rtw89_mac_dmac_func_pre_en(rtwdev);
+	mac->hci_func_en(rtwdev);
+	mac->dmac_func_pre_en(rtwdev);
 
 	ret = dle_init(rtwdev, RTW89_QTA_DLFW, rtwdev->mac.qta_mode);
 	if (ret) {
@@ -5885,8 +5892,23 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 			B_AX_BFMEE_HE_NDPA_EN,
 	},
 
+	.hci_func_en = rtw89_mac_hci_func_en_ax,
+	.dmac_func_pre_en = rtw89_mac_dmac_func_pre_en_ax,
+	.dle_func_en = dle_func_en_ax,
+	.dle_clk_en = dle_clk_en_ax,
 	.bf_assoc = rtw89_mac_bf_assoc_ax,
 
+	.dle_mix_cfg = dle_mix_cfg_ax,
+	.chk_dle_rdy = chk_dle_rdy_ax,
+	.dle_buf_req = dle_buf_req_ax,
+	.hfc_func_en = hfc_func_en_ax,
+	.hfc_h2c_cfg = hfc_h2c_cfg_ax,
+	.hfc_mix_cfg = hfc_mix_cfg_ax,
+	.hfc_get_mix_info = hfc_get_mix_info_ax,
+	.wde_quota_cfg = wde_quota_cfg_ax,
+	.ple_quota_cfg = ple_quota_cfg_ax,
+	.set_cpuio = set_cpuio_ax,
+
 	.disable_cpu = rtw89_mac_disable_cpu_ax,
 	.fwdl_enable_wcpu = rtw89_mac_enable_cpu_ax,
 	.fwdl_get_status = rtw89_fw_get_rdy_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 8beb278934bf..c6b2072f94c3 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -898,9 +898,30 @@ struct rtw89_mac_gen_def {
 	struct rtw89_reg_def muedca_ctrl;
 	struct rtw89_reg_def bfee_ctrl;
 
+	void (*hci_func_en)(struct rtw89_dev *rtwdev);
+	void (*dmac_func_pre_en)(struct rtw89_dev *rtwdev);
+	void (*dle_func_en)(struct rtw89_dev *rtwdev, bool enable);
+	void (*dle_clk_en)(struct rtw89_dev *rtwdev, bool enable);
 	void (*bf_assoc)(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			 struct ieee80211_sta *sta);
 
+	int (*dle_mix_cfg)(struct rtw89_dev *rtwdev, const struct rtw89_dle_mem *cfg);
+	int (*chk_dle_rdy)(struct rtw89_dev *rtwdev, bool wde_or_ple);
+	int (*dle_buf_req)(struct rtw89_dev *rtwdev, u16 buf_len, bool wd, u16 *pkt_id);
+	void (*hfc_func_en)(struct rtw89_dev *rtwdev, bool en, bool h2c_en);
+	void (*hfc_h2c_cfg)(struct rtw89_dev *rtwdev);
+	void (*hfc_mix_cfg)(struct rtw89_dev *rtwdev);
+	void (*hfc_get_mix_info)(struct rtw89_dev *rtwdev);
+	void (*wde_quota_cfg)(struct rtw89_dev *rtwdev,
+			      const struct rtw89_wde_quota *min_cfg,
+			      const struct rtw89_wde_quota *max_cfg,
+			      u16 ext_wde_min_qt_wcpu);
+	void (*ple_quota_cfg)(struct rtw89_dev *rtwdev,
+			      const struct rtw89_ple_quota *min_cfg,
+			      const struct rtw89_ple_quota *max_cfg);
+	int (*set_cpuio)(struct rtw89_dev *rtwdev,
+			 struct rtw89_cpuio_ctrl *ctrl_para, bool wd);
+
 	void (*disable_cpu)(struct rtw89_dev *rtwdev);
 	int (*fwdl_enable_wcpu)(struct rtw89_dev *rtwdev, u8 boot_reason,
 				bool dlfw, bool include_bb);
@@ -1267,9 +1288,6 @@ enum rtw89_mac_xtal_si_offset {
 int rtw89_mac_write_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 mask);
 int rtw89_mac_read_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 *val);
 void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
-int rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len, bool wd, u16 *pkt_id);
-int rtw89_mac_set_cpuio(struct rtw89_dev *rtwdev,
-			struct rtw89_cpuio_ctrl *ctrl_para, bool wd);
 int rtw89_mac_typ_fltr_opt(struct rtw89_dev *rtwdev,
 			   enum rtw89_machdr_frame_type type,
 			   enum rtw89_mac_fwd_target fwd_target, u8 mac_idx);
-- 
2.25.1


