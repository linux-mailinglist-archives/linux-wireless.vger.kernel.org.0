Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E955576F996
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 07:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjHDFfs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Aug 2023 01:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHDFfr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Aug 2023 01:35:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9862B119
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 22:35:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3745ZK0T0006149, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3745ZK0T0006149
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 4 Aug 2023 13:35:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 4 Aug 2023 13:35:25 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 4 Aug 2023
 13:35:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <damon.chen@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: Introduce Time Averaged SAR (TAS) feature
Date:   Fri, 4 Aug 2023 13:34:58 +0800
Message-ID: <20230804053458.31492-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kuan-Chung Chen <damon.chen@realtek.com>

Time Averaged SAR (TAS) tracks the amount of transmit power over a
period of time and adjusts the power accordingly. Two thresholds are
used to determine when to increase or reduce transmit power: Dynamic
Power Reduction (DPR) on/off. Compared to Static SAR, which has a
constant transmit power, TAS can improve the user experience or
range extension.

TAS can be enabled through BIOS, and the driver will evaluate
Realtek ACPI DSM with RTW89_ACPI_DSM_FUNC_TAS_EN to determine
whether TAS should be enabled.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  |   4 +
 drivers/net/wireless/realtek/rtw89/core.h  |  18 ++
 drivers/net/wireless/realtek/rtw89/debug.c |   3 +
 drivers/net/wireless/realtek/rtw89/reg.h   |   4 +
 drivers/net/wireless/realtek/rtw89/sar.c   | 197 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/sar.h   |   4 +
 6 files changed, 230 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 62c21c09cf92..71eb9cfd4896 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2682,6 +2682,7 @@ static void rtw89_track_work(struct work_struct *work)
 	rtw89_phy_tx_path_div_track(rtwdev);
 	rtw89_phy_antdiv_track(rtwdev);
 	rtw89_phy_ul_tb_ctrl_track(rtwdev);
+	rtw89_tas_track(rtwdev);
 
 	if (rtwdev->lps_enabled && !rtwdev->btc.lps)
 		rtw89_enter_lps_track(rtwdev);
@@ -3496,6 +3497,8 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 	rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
 	rtw89_mac_update_rts_threshold(rtwdev, RTW89_MAC_0);
 
+	rtw89_tas_reset(rtwdev);
+
 	ret = rtw89_hci_start(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to start hci\n");
@@ -3612,6 +3615,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 
 	rtw89_ser_init(rtwdev);
 	rtw89_entity_init(rtwdev);
+	rtw89_tas_init(rtwdev);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index fa4bbc4095ab..b5a08f90f5bd 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3690,6 +3690,23 @@ struct rtw89_sar_info {
 	};
 };
 
+enum rtw89_tas_state {
+	RTW89_TAS_STATE_DPR_OFF,
+	RTW89_TAS_STATE_DPR_ON,
+	RTW89_TAS_STATE_DPR_FORBID,
+};
+
+#define RTW89_TAS_MAX_WINDOW 50
+struct rtw89_tas_info {
+	s16 txpwr_history[RTW89_TAS_MAX_WINDOW];
+	s32 total_txpwr;
+	u8 cur_idx;
+	s8 dpr_gap;
+	s8 delta;
+	enum rtw89_tas_state state;
+	bool enable;
+};
+
 struct rtw89_chanctx_cfg {
 	enum rtw89_sub_entity_idx idx;
 };
@@ -4365,6 +4382,7 @@ struct rtw89_dev {
 
 	struct rtw89_regulatory_info regulatory;
 	struct rtw89_sar_info sar;
+	struct rtw89_tas_info tas;
 
 	struct rtw89_btc btc;
 	enum rtw89_ps_mode ps_mode;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index f1e5ac4186c2..f6f1e90c3934 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -615,6 +615,9 @@ static int rtw89_debug_priv_txpwr_table_get(struct seq_file *m, void *v)
 	seq_puts(m, "[SAR]\n");
 	rtw89_print_sar(m, rtwdev);
 
+	seq_puts(m, "[TAS]\n");
+	rtw89_print_tas(m, rtwdev);
+
 	seq_puts(m, "\n[TX power byrate]\n");
 	ret = __print_txpwr_map(m, rtwdev, &__txpwr_map_byr);
 	if (ret)
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 55595fde7494..2d34b43cda3a 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4109,6 +4109,8 @@
 #define B_TXAGC_BB_OFT GENMASK(31, 16)
 #define B_TXAGC_BB GENMASK(31, 24)
 #define B_TXAGC_RF GENMASK(5, 0)
+#define R_PATH0_TXPWR 0x1C78
+#define B_PATH0_TXPWR GENMASK(8, 0)
 #define R_S0_ADDCK 0x1E00
 #define B_S0_ADDCK_I GENMASK(9, 0)
 #define B_S0_ADDCK_Q GENMASK(19, 10)
@@ -4184,6 +4186,8 @@
 #define R_TXAGC_BB_S1 0x3C60
 #define B_TXAGC_BB_S1_OFT GENMASK(31, 16)
 #define B_TXAGC_BB_S1 GENMASK(31, 24)
+#define R_PATH1_TXPWR 0x3C78
+#define B_PATH1_TXPWR GENMASK(8, 0)
 #define R_S1_ADDCK 0x3E00
 #define B_S1_ADDCK_I GENMASK(9, 0)
 #define B_S1_ADDCK_Q GENMASK(19, 10)
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index dfccae81c380..fafc7a0cfe97 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -2,9 +2,16 @@
 /* Copyright(c) 2019-2020  Realtek Corporation
  */
 
+#include "acpi.h"
 #include "debug.h"
+#include "phy.h"
+#include "reg.h"
 #include "sar.h"
 
+#define RTW89_TAS_FACTOR 2 /* unit: 0.25 dBm */
+#define RTW89_TAS_DPR_GAP (1 << RTW89_TAS_FACTOR)
+#define RTW89_TAS_DELTA (2 << RTW89_TAS_FACTOR)
+
 static enum rtw89_sar_subband rtw89_sar_get_subband(struct rtw89_dev *rtwdev,
 						    u32 center_freq)
 {
@@ -157,11 +164,35 @@ static s8 rtw89_txpwr_sar_to_mac(struct rtw89_dev *rtwdev, u8 fct, s32 cfg)
 			   RTW89_SAR_TXPWR_MAC_MAX);
 }
 
+static s8 rtw89_txpwr_tas_to_sar(const struct rtw89_sar_handler *sar_hdl,
+				 s8 cfg)
+{
+	const u8 fct = sar_hdl->txpwr_factor_sar;
+
+	if (fct > RTW89_TAS_FACTOR)
+		return cfg << (fct - RTW89_TAS_FACTOR);
+	else
+		return cfg >> (RTW89_TAS_FACTOR - fct);
+}
+
+static s8 rtw89_txpwr_sar_to_tas(const struct rtw89_sar_handler *sar_hdl,
+				 s8 cfg)
+{
+	const u8 fct = sar_hdl->txpwr_factor_sar;
+
+	if (fct > RTW89_TAS_FACTOR)
+		return cfg >> (fct - RTW89_TAS_FACTOR);
+	else
+		return cfg << (RTW89_TAS_FACTOR - fct);
+}
+
 s8 rtw89_query_sar(struct rtw89_dev *rtwdev)
 {
 	const enum rtw89_sar_sources src = rtwdev->sar.src;
 	/* its members are protected by rtw89_sar_set_src() */
 	const struct rtw89_sar_handler *sar_hdl = &rtw89_sar_handlers[src];
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+	s8 delta;
 	int ret;
 	s32 cfg;
 	u8 fct;
@@ -175,6 +206,19 @@ s8 rtw89_query_sar(struct rtw89_dev *rtwdev)
 	if (ret)
 		return RTW89_SAR_TXPWR_MAC_MAX;
 
+	if (tas->enable) {
+		switch (tas->state) {
+		case RTW89_TAS_STATE_DPR_OFF:
+			return RTW89_SAR_TXPWR_MAC_MAX;
+		case RTW89_TAS_STATE_DPR_ON:
+			delta = rtw89_txpwr_tas_to_sar(sar_hdl, tas->delta);
+			cfg -= delta;
+		case RTW89_TAS_STATE_DPR_FORBID:
+		default:
+			break;
+		}
+	}
+
 	fct = sar_hdl->txpwr_factor_sar;
 
 	return rtw89_txpwr_sar_to_mac(rtwdev, fct, cfg);
@@ -212,6 +256,19 @@ void rtw89_print_sar(struct seq_file *m, struct rtw89_dev *rtwdev)
 	seq_printf(m, "config: %d (unit: 1/%lu dBm)\n", cfg, BIT(fct));
 }
 
+void rtw89_print_tas(struct seq_file *m, struct rtw89_dev *rtwdev)
+{
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+
+	if (!tas->enable) {
+		seq_puts(m, "no TAS is applied\n");
+		return;
+	}
+
+	seq_printf(m, "DPR gap: %d\n", tas->dpr_gap);
+	seq_printf(m, "TAS delta: %d\n", tas->delta);
+}
+
 static int rtw89_apply_sar_common(struct rtw89_dev *rtwdev,
 				  const struct rtw89_sar_cfg_common *sar)
 {
@@ -292,3 +349,143 @@ int rtw89_ops_set_sar_specs(struct ieee80211_hw *hw,
 
 	return rtw89_apply_sar_common(rtwdev, &sar_common);
 }
+
+static void rtw89_tas_state_update(struct rtw89_dev *rtwdev)
+{
+	const enum rtw89_sar_sources src = rtwdev->sar.src;
+	/* its members are protected by rtw89_sar_set_src() */
+	const struct rtw89_sar_handler *sar_hdl = &rtw89_sar_handlers[src];
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+	s32 txpwr_avg = tas->total_txpwr / RTW89_TAS_MAX_WINDOW / PERCENT;
+	s32 dpr_on_threshold, dpr_off_threshold, cfg;
+	enum rtw89_tas_state state = tas->state;
+	int ret;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	if (src == RTW89_SAR_SOURCE_NONE)
+		return;
+
+	ret = sar_hdl->query_sar_config(rtwdev, &cfg);
+	if (ret)
+		return;
+
+	cfg = rtw89_txpwr_sar_to_tas(sar_hdl, cfg);
+
+	if (tas->delta >= cfg) {
+		rtw89_debug(rtwdev, RTW89_DBG_SAR,
+			    "TAS delta exceed SAR limit\n");
+		state = RTW89_TAS_STATE_DPR_FORBID;
+		goto out;
+	}
+
+	dpr_on_threshold = cfg;
+	dpr_off_threshold = cfg - tas->dpr_gap;
+	rtw89_debug(rtwdev, RTW89_DBG_SAR,
+		    "DPR_ON thold: %d, DPR_OFF thold: %d, txpwr_avg: %d\n",
+		    dpr_on_threshold, dpr_off_threshold, txpwr_avg);
+
+	if (txpwr_avg >= dpr_on_threshold)
+		state = RTW89_TAS_STATE_DPR_ON;
+	else if (txpwr_avg < dpr_off_threshold)
+		state = RTW89_TAS_STATE_DPR_OFF;
+
+out:
+	if (tas->state == state)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_SAR,
+		    "TAS old state: %d, new state: %d\n", tas->state, state);
+	tas->state = state;
+	rtw89_core_set_chip_txpwr(rtwdev);
+}
+
+void rtw89_tas_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+	int ret;
+	u8 val;
+
+	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_TAS_EN, &val);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_SAR,
+			    "acpi: cannot get TAS: %d\n", ret);
+		return;
+	}
+
+	switch (val) {
+	case 0:
+		tas->enable = false;
+		break;
+	case 1:
+		tas->enable = true;
+		break;
+	default:
+		break;
+	}
+
+	if (!tas->enable) {
+		rtw89_debug(rtwdev, RTW89_DBG_SAR, "TAS not enable\n");
+		return;
+	}
+
+	tas->dpr_gap = RTW89_TAS_DPR_GAP;
+	tas->delta = RTW89_TAS_DELTA;
+}
+
+void rtw89_tas_reset(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+
+	if (!tas->enable)
+		return;
+
+	memset(&tas->txpwr_history, 0, sizeof(tas->txpwr_history));
+	tas->total_txpwr = 0;
+	tas->cur_idx = 0;
+	tas->state = RTW89_TAS_STATE_DPR_OFF;
+}
+
+static const struct rtw89_reg_def txpwr_regs[] = {
+	{R_PATH0_TXPWR, B_PATH0_TXPWR},
+	{R_PATH1_TXPWR, B_PATH1_TXPWR},
+};
+
+void rtw89_tas_track(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	const enum rtw89_sar_sources src = rtwdev->sar.src;
+	u8 max_nss_num = rtwdev->chip->rf_path_num;
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+	s16 tmp, txpwr, instant_txpwr = 0;
+	u32 val;
+	int i;
+
+	if (!tas->enable || src == RTW89_SAR_SOURCE_NONE)
+		return;
+
+	if (env->ccx_watchdog_result != RTW89_PHY_ENV_MON_IFS_CLM)
+		return;
+
+	for (i = 0; i < max_nss_num; i++) {
+		val = rtw89_phy_read32_mask(rtwdev, txpwr_regs[i].addr,
+					    txpwr_regs[i].mask);
+		tmp = sign_extend32(val, 8);
+		if (tmp <= 0)
+			return;
+		instant_txpwr += tmp;
+	}
+
+	instant_txpwr /= max_nss_num;
+	/* in unit of 0.25 dBm multiply by percentage */
+	txpwr = instant_txpwr * env->ifs_clm_tx_ratio;
+	tas->total_txpwr += txpwr - tas->txpwr_history[tas->cur_idx];
+	tas->txpwr_history[tas->cur_idx] = txpwr;
+	rtw89_debug(rtwdev, RTW89_DBG_SAR,
+		    "instant_txpwr: %d, tx_ratio: %d, txpwr: %d\n",
+		    instant_txpwr, env->ifs_clm_tx_ratio, txpwr);
+
+	tas->cur_idx = (tas->cur_idx + 1) % RTW89_TAS_MAX_WINDOW;
+
+	rtw89_tas_state_update(rtwdev);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/sar.h b/drivers/net/wireless/realtek/rtw89/sar.h
index 7b5484c84eb1..40ce5990ceaf 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.h
+++ b/drivers/net/wireless/realtek/rtw89/sar.h
@@ -20,7 +20,11 @@ extern const struct cfg80211_sar_capa rtw89_sar_capa;
 
 s8 rtw89_query_sar(struct rtw89_dev *rtwdev);
 void rtw89_print_sar(struct seq_file *m, struct rtw89_dev *rtwdev);
+void rtw89_print_tas(struct seq_file *m, struct rtw89_dev *rtwdev);
 int rtw89_ops_set_sar_specs(struct ieee80211_hw *hw,
 			    const struct cfg80211_sar_specs *sar);
+void rtw89_tas_init(struct rtw89_dev *rtwdev);
+void rtw89_tas_reset(struct rtw89_dev *rtwdev);
+void rtw89_tas_track(struct rtw89_dev *rtwdev);
 
 #endif
-- 
2.25.1

