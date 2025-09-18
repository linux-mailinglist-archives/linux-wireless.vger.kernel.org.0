Return-Path: <linux-wireless+bounces-26444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DCEB2B7E8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 05:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B631B64033
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 03:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBAFBA4A;
	Tue, 19 Aug 2025 03:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wfG1XTl4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9A1D5CDE
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 03:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575137; cv=none; b=S861zFswGtSaMdLjR8dHEU5IVb/CQCU6IhzOKiQZGsp9Qw2UWot6q7fReKWgCu/WpZ57GPOmj/A8l+KKYTglowOSGmmOSK1hG5GVTNERLgCNo8LJ1Gr2p5ufxMo1dFGFzuqBNm7IkKZRVq4flOUV309npxXxR2NOIk47vsna7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575137; c=relaxed/simple;
	bh=96OSO6Xn6ec8IXeLtIkaEDwu6zn/rU47eYFKjn9AbAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAJ1CZ2DDr+ukk/fx+fe0njtfrtBRbu8PutvS1v7N1pIfOSG7+WY2DNITPVMJM0xftHDlf5PrihoCRPn1HEmDDOt85+D5HlcfHEUQOD7BBqE2lq9SSON+77xty3MZVItqKI17hQ7ZAUWEdSOlYQvpiGXQQpi5BNn/i9Fdvea4Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wfG1XTl4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57J3jU2J12064810, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1755575130; bh=DjEnQE+Dxd1l2dIZPPijmsNh29w96CoiGCv61rVDThU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wfG1XTl4mUMGJzn0yv5kCNH3YekPBnNnweJmnig2sQwnf2YRujAbGJBywWRR93JD3
	 EJfI8oWM0ufd0rZdkKXFhXqFnINge4kwiF3QmOdvURycXr2avi5pGOI9MT6tld9Wkj
	 fCBTeZ3GWd1RZfrAU2N1IpUnpgMm7YokedW4cOjFQT5D9Vp6KhW1ZncgvzQ4u8pjPf
	 ypYnd5zsp4hmT4LeEkI3petcBkx2tfehvm3mkxtk38BFusYKiE+VUBzcswOtmvJvfz
	 6yQkdU2FfMcKS9uWE7Hp7oS/i3BN49EdQZI4g8OjciWfK7DT+mI2yf7wIh24Jd/0Yc
	 NeMNIu0y3vefg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57J3jU2J12064810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 11:45:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 11:45:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 11:45:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 1/4] wifi: rtw89: 8852a: report per-channel noise level by get_survey ops
Date: Tue, 19 Aug 2025 11:44:25 +0800
Message-ID: <20250819034428.26307-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250819034428.26307-1-pkshih@realtek.com>
References: <20250819034428.26307-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

From: Po-Hao Huang <phhuang@realtek.com>

To optimize roaming decisions, report per-channel noise levels
during scans so supplicant can have a better view of the current
channel condition. This allows it to prefer the APs operating on
channels with lower noise levels.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |   4 +
 drivers/net/wireless/realtek/rtw89/core.h     |  22 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   4 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  35 ++
 drivers/net/wireless/realtek/rtw89/phy.c      | 306 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h      |  20 ++
 drivers/net/wireless/realtek/rtw89/phy_be.c   |   9 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  42 +++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  32 ++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   3 +
 13 files changed, 482 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0ad7562632a5..2b658ee89bb6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -6258,6 +6258,7 @@ int rtw89_core_register(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
+	rtw89_phy_dm_init_data(rtwdev);
 	rtw89_debugfs_init(rtwdev);
 
 	return 0;
@@ -6308,6 +6309,9 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 		ops->cancel_remain_on_channel = NULL;
 	}
 
+	if (!chip->support_noise)
+		ops->get_survey = NULL;
+
 	driver_data_size = sizeof(struct rtw89_dev) + bus_data_size;
 	hw = ieee80211_alloc_hw(driver_data_size, ops);
 	if (!hw)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d8c40ce3ec61..a5fef3c84b20 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4364,6 +4364,9 @@ struct rtw89_chanctx_listener {
 		(struct rtw89_dev *rtwdev, enum rtw89_chanctx_state state);
 };
 
+#define RTW89_NHM_TH_NUM 11
+#define RTW89_NHM_RPT_NUM 12
+
 struct rtw89_chip_info {
 	enum rtw89_core_chip_id chip_id;
 	enum rtw89_chip_gen chip_gen;
@@ -4398,6 +4401,7 @@ struct rtw89_chip_info {
 	bool support_ant_gain;
 	bool support_tas;
 	bool support_sar_by_ant;
+	bool support_noise;
 	bool ul_tb_waveform_ctrl;
 	bool ul_tb_pwr_diff;
 	bool rx_freq_frome_ie;
@@ -4482,6 +4486,8 @@ struct rtw89_chip_info {
 	bool cfo_hw_comp;
 	const struct rtw89_reg_def *dcfo_comp;
 	u8 dcfo_comp_sft;
+	const struct rtw89_reg_def (*nhm_report)[RTW89_NHM_RPT_NUM];
+	const struct rtw89_reg_def (*nhm_th)[RTW89_NHM_TH_NUM];
 	const struct rtw89_imr_info *imr_info;
 	const struct rtw89_imr_table *imr_dmac_table;
 	const struct rtw89_imr_table *imr_cmac_table;
@@ -5464,6 +5470,7 @@ enum rtw89_env_racing_lv {
 struct rtw89_ccx_para_info {
 	enum rtw89_env_racing_lv rac_lv;
 	u16 mntr_time;
+	bool nhm_incld_cca;
 	u8 nhm_manual_th_ofst;
 	u8 nhm_manual_th0;
 	enum rtw89_ifs_clm_application ifs_clm_app;
@@ -5497,9 +5504,13 @@ enum rtw89_ccx_edcca_opt_bw_idx {
 	RTW89_CCX_EDCCA_BW20_7 = 7
 };
 
-#define RTW89_NHM_TH_NUM 11
+struct rtw89_nhm_report {
+	struct list_head list;
+	struct ieee80211_channel *channel;
+	u8 noise;
+};
+
 #define RTW89_FAHM_TH_NUM 11
-#define RTW89_NHM_RPT_NUM 12
 #define RTW89_FAHM_RPT_NUM 12
 #define RTW89_IFS_CLM_NUM 4
 struct rtw89_env_monitor_info {
@@ -5533,6 +5544,13 @@ struct rtw89_env_monitor_info {
 	u16 ifs_clm_ofdm_fa_permil;
 	u32 ifs_clm_ifs_avg[RTW89_IFS_CLM_NUM];
 	u32 ifs_clm_cca_avg[RTW89_IFS_CLM_NUM];
+	bool nhm_include_cca;
+	u32 nhm_sum;
+	u32 nhm_mntr_time;
+	u16 nhm_result[RTW89_NHM_RPT_NUM];
+	u8 nhm_th[RTW89_NHM_RPT_NUM];
+	struct rtw89_nhm_report *nhm_his[RTW89_BAND_NUM];
+	struct list_head nhm_rpt_list;
 };
 
 enum rtw89_ser_rcvy_step {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 48712a2994b6..06fc113ffaf0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -9,6 +9,7 @@
 #include "fw.h"
 #include "mac.h"
 #include "pci.h"
+#include "phy.h"
 #include "ps.h"
 #include "reg.h"
 #include "util.h"
@@ -5045,6 +5046,8 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		if (op_chan) {
 			rtw89_mac_enable_aps_bcn_by_chan(rtwdev, op_chan, false);
 			ieee80211_stop_queues(rtwdev->hw);
+		} else {
+			rtw89_phy_nhm_get_result(rtwdev, band, chan);
 		}
 		return;
 	case RTW89_SCAN_END_SCAN_NOTIFY:
@@ -5075,6 +5078,7 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 					  RTW89_CHANNEL_WIDTH_20);
 			rtw89_assign_entity_chan(rtwdev, rtwvif_link->chanctx_idx,
 						 &new);
+			rtw89_phy_nhm_trigger(rtwdev);
 		}
 		break;
 	default:
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index c1ca6d741b32..7b04183a3a5d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1837,6 +1837,40 @@ static void rtw89_set_rekey_data(struct ieee80211_hw *hw,
 }
 #endif
 
+static int rtw89_ops_get_survey(struct ieee80211_hw *hw, int idx,
+				struct survey_info *survey)
+{
+	struct ieee80211_conf *conf = &hw->conf;
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_bb_ctx *bb;
+
+	if (idx == 0) {
+		survey->channel = conf->chandef.chan;
+		survey->filled = SURVEY_INFO_NOISE_DBM;
+		survey->noise = RTW89_NOISE_DEFAULT;
+
+		return 0;
+	}
+
+	rtw89_for_each_active_bb(rtwdev, bb) {
+		struct rtw89_env_monitor_info *env = &bb->env_monitor;
+		struct rtw89_nhm_report *rpt;
+
+		rpt = list_first_entry_or_null(&env->nhm_rpt_list, typeof(*rpt), list);
+		if (!rpt)
+			continue;
+
+		survey->filled = SURVEY_INFO_NOISE_DBM;
+		survey->noise = rpt->noise - MAX_RSSI;
+		survey->channel = rpt->channel;
+		list_del_init(&rpt->list);
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static void rtw89_ops_rfkill_poll(struct ieee80211_hw *hw)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
@@ -1869,6 +1903,7 @@ const struct ieee80211_ops rtw89_ops = {
 	.sta_state		= rtw89_ops_sta_state,
 	.set_key		= rtw89_ops_set_key,
 	.ampdu_action		= rtw89_ops_ampdu_action,
+	.get_survey		= rtw89_ops_get_survey,
 	.set_rts_threshold	= rtw89_ops_set_rts_threshold,
 	.sta_statistics		= rtw89_ops_sta_statistics,
 	.flush			= rtw89_ops_flush,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 06598723074e..c3181a301f7c 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -5496,6 +5496,34 @@ static void rtw89_phy_ifs_clm_set_th_reg(struct rtw89_dev *rtwdev,
 			    i + 1, env->ifs_clm_th_l[i], env->ifs_clm_th_h[i]);
 }
 
+static void __rtw89_phy_nhm_setting_init(struct rtw89_dev *rtwdev,
+					 struct rtw89_bb_ctx *bb)
+{
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
+	const struct rtw89_ccx_regs *ccx = phy->ccx;
+
+	env->nhm_include_cca = false;
+	env->nhm_mntr_time = 0;
+	env->nhm_sum = 0;
+
+	rtw89_phy_write32_idx_set(rtwdev, ccx->nhm_config, ccx->nhm_en_mask, bb->phy_idx);
+	rtw89_phy_write32_idx_set(rtwdev, ccx->nhm_method, ccx->nhm_pwr_method_msk,
+				  bb->phy_idx);
+}
+
+void rtw89_phy_nhm_setting_init(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_bb_ctx *bb;
+
+	if (!chip->support_noise)
+		return;
+
+	rtw89_for_each_active_bb(rtwdev, bb)
+		__rtw89_phy_nhm_setting_init(rtwdev, bb);
+}
+
 static void rtw89_phy_ifs_clm_setting_init(struct rtw89_dev *rtwdev,
 					   struct rtw89_bb_ctx *bb)
 {
@@ -5557,7 +5585,7 @@ static int rtw89_phy_ccx_racing_ctrl(struct rtw89_dev *rtwdev,
 }
 
 static void rtw89_phy_ccx_trigger(struct rtw89_dev *rtwdev,
-				  struct rtw89_bb_ctx *bb)
+				  struct rtw89_bb_ctx *bb, u8 sel)
 {
 	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 	struct rtw89_env_monitor_info *env = &bb->env_monitor;
@@ -5567,10 +5595,17 @@ static void rtw89_phy_ccx_trigger(struct rtw89_dev *rtwdev,
 			      bb->phy_idx);
 	rtw89_phy_write32_idx(rtwdev, ccx->setting_addr, ccx->measurement_trig_mask, 0,
 			      bb->phy_idx);
+	if (sel & RTW89_PHY_ENV_MON_NHM)
+		rtw89_phy_write32_idx_clr(rtwdev, ccx->nhm_config,
+					  ccx->nhm_en_mask, bb->phy_idx);
+
 	rtw89_phy_write32_idx(rtwdev, ccx->ifs_cnt_addr, ccx->ifs_clm_cnt_clear_mask, 1,
 			      bb->phy_idx);
 	rtw89_phy_write32_idx(rtwdev, ccx->setting_addr, ccx->measurement_trig_mask, 1,
 			      bb->phy_idx);
+	if (sel & RTW89_PHY_ENV_MON_NHM)
+		rtw89_phy_write32_idx_set(rtwdev, ccx->nhm_config,
+					  ccx->nhm_en_mask, bb->phy_idx);
 
 	env->ccx_ongoing = true;
 }
@@ -5641,6 +5676,125 @@ static void rtw89_phy_ifs_clm_get_utility(struct rtw89_dev *rtwdev,
 			    env->ifs_clm_cca_avg[i]);
 }
 
+static u8 rtw89_nhm_weighted_avg(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
+{
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
+	u8 nhm_weight[RTW89_NHM_RPT_NUM];
+	u32 nhm_weighted_sum = 0;
+	u8 weight_zero;
+	u8 i;
+
+	if (env->nhm_sum == 0)
+		return 0;
+
+	weight_zero = clamp_t(u16, env->nhm_th[0] - RTW89_NHM_WEIGHT_OFFSET, 0, U8_MAX);
+
+	for (i = 0; i < RTW89_NHM_RPT_NUM; i++) {
+		if (i == 0)
+			nhm_weight[i] = weight_zero;
+		else if (i == (RTW89_NHM_RPT_NUM - 1))
+			nhm_weight[i] = env->nhm_th[i - 1] + RTW89_NHM_WEIGHT_OFFSET;
+		else
+			nhm_weight[i] = (env->nhm_th[i - 1] + env->nhm_th[i]) / 2;
+	}
+
+	if (rtwdev->chip->chip_id == RTL8852A || rtwdev->chip->chip_id == RTL8852B ||
+	    rtwdev->chip->chip_id == RTL8852C) {
+		if (env->nhm_th[RTW89_NHM_TH_NUM - 1] == RTW89_NHM_WA_TH) {
+			nhm_weight[RTW89_NHM_RPT_NUM - 1] =
+				env->nhm_th[RTW89_NHM_TH_NUM - 2] +
+				RTW89_NHM_WEIGHT_OFFSET;
+			nhm_weight[RTW89_NHM_RPT_NUM - 2] =
+				nhm_weight[RTW89_NHM_RPT_NUM - 1];
+		}
+
+		env->nhm_result[0] += env->nhm_result[RTW89_NHM_RPT_NUM - 1];
+		env->nhm_result[RTW89_NHM_RPT_NUM - 1] = 0;
+	}
+
+	for (i = 0; i < RTW89_NHM_RPT_NUM; i++)
+		nhm_weighted_sum += env->nhm_result[i] * nhm_weight[i];
+
+	return (nhm_weighted_sum / env->nhm_sum) >> RTW89_NHM_TH_FACTOR;
+}
+
+static void __rtw89_phy_nhm_get_result(struct rtw89_dev *rtwdev,
+				       struct rtw89_bb_ctx *bb, enum rtw89_band hw_band,
+				       u16 ch_hw_value)
+{
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_ccx_regs *ccx = phy->ccx;
+	struct ieee80211_supported_band *sband;
+	const struct rtw89_reg_def *nhm_rpt;
+	enum nl80211_band band;
+	u32 sum = 0;
+	u8 chan_idx;
+	u8 nhm_pwr;
+	u8 i;
+
+	if (!rtw89_phy_read32_idx(rtwdev, ccx->nhm, ccx->nhm_ready, bb->phy_idx)) {
+		rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK,  "[NHM] Get NHM report Fail\n");
+		return;
+	}
+
+	for (i = 0; i < RTW89_NHM_RPT_NUM; i++) {
+		nhm_rpt = &(*chip->nhm_report)[i];
+
+		env->nhm_result[i] =
+			rtw89_phy_read32_idx(rtwdev, nhm_rpt->addr,
+					     nhm_rpt->mask, bb->phy_idx);
+		sum += env->nhm_result[i];
+	}
+	env->nhm_sum = sum;
+	nhm_pwr = rtw89_nhm_weighted_avg(rtwdev, bb);
+
+	if (!ch_hw_value)
+		return;
+
+	band = rtw89_hw_to_nl80211_band(hw_band);
+	sband = rtwdev->hw->wiphy->bands[band];
+	if (!sband)
+		return;
+
+	for (chan_idx = 0; chan_idx < sband->n_channels; chan_idx++) {
+		struct ieee80211_channel *channel;
+		struct rtw89_nhm_report *rpt;
+		struct list_head *nhm_list;
+
+		channel = &sband->channels[chan_idx];
+		if (channel->hw_value != ch_hw_value)
+			continue;
+
+		rpt = &env->nhm_his[hw_band][chan_idx];
+		nhm_list = &env->nhm_rpt_list;
+
+		rpt->channel = channel;
+		rpt->noise = nhm_pwr;
+
+		if (list_empty(&rpt->list))
+			list_add_tail(&rpt->list, nhm_list);
+
+		return;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK, "[NHM] channel not found\n");
+}
+
+void rtw89_phy_nhm_get_result(struct rtw89_dev *rtwdev, enum rtw89_band hw_band,
+			      u16 ch_hw_value)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_bb_ctx *bb;
+
+	if (!chip->support_noise)
+		return;
+
+	rtw89_for_each_active_bb(rtwdev, bb)
+		__rtw89_phy_nhm_get_result(rtwdev, bb, hw_band, ch_hw_value);
+}
+
 static bool rtw89_phy_ifs_clm_get_result(struct rtw89_dev *rtwdev,
 					 struct rtw89_bb_ctx *bb)
 {
@@ -5741,6 +5895,107 @@ static bool rtw89_phy_ifs_clm_get_result(struct rtw89_dev *rtwdev,
 	return true;
 }
 
+static void rtw89_phy_nhm_th_update(struct rtw89_dev *rtwdev,
+				    struct rtw89_bb_ctx *bb)
+{
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
+	static const u8 nhm_th_11k[RTW89_NHM_RPT_NUM] = {
+		18, 21, 24, 27, 30, 35, 40, 45, 50, 55, 60, 0
+	};
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_reg_def *nhm_th;
+	u8 i;
+
+	for (i = 0; i < RTW89_NHM_RPT_NUM; i++)
+		env->nhm_th[i] = nhm_th_11k[i] << RTW89_NHM_TH_FACTOR;
+
+	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B ||
+	    chip->chip_id == RTL8852C)
+		env->nhm_th[RTW89_NHM_TH_NUM - 1] = RTW89_NHM_WA_TH;
+
+	for (i = 0; i < RTW89_NHM_TH_NUM; i++) {
+		nhm_th = &(*chip->nhm_th)[i];
+
+		rtw89_phy_write32_idx(rtwdev, nhm_th->addr, nhm_th->mask,
+				      env->nhm_th[i], bb->phy_idx);
+	}
+}
+
+static int rtw89_phy_nhm_set(struct rtw89_dev *rtwdev,
+			     struct rtw89_bb_ctx *bb,
+			     struct rtw89_ccx_para_info *para)
+{
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
+	const struct rtw89_ccx_regs *ccx = phy->ccx;
+	u32 unit_idx = 0;
+	u32 period = 0;
+
+	if (para->mntr_time == 0) {
+		rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK,
+			    "[NHM] MNTR_TIME is 0\n");
+		return -EINVAL;
+	}
+
+	if (rtw89_phy_ccx_racing_ctrl(rtwdev, bb, para->rac_lv))
+		return -EINVAL;
+
+	rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK,
+		    "[NHM]nhm_incld_cca=%d, mntr_time=%d ms\n",
+		    para->nhm_incld_cca, para->mntr_time);
+
+	if (para->mntr_time != env->nhm_mntr_time) {
+		rtw89_phy_ccx_ms_to_period_unit(rtwdev, para->mntr_time,
+						&period, &unit_idx);
+		rtw89_phy_write32_idx(rtwdev, ccx->nhm_config,
+				      ccx->nhm_period_mask, period, bb->phy_idx);
+		rtw89_phy_write32_idx(rtwdev, ccx->nhm_config,
+				      ccx->nhm_unit_mask, period, bb->phy_idx);
+
+		env->nhm_mntr_time = para->mntr_time;
+		env->ccx_period = period;
+		env->ccx_unit_idx = unit_idx;
+	}
+
+	if (para->nhm_incld_cca != env->nhm_include_cca) {
+		rtw89_phy_write32_idx(rtwdev, ccx->nhm_config,
+				      ccx->nhm_include_cca_mask, para->nhm_incld_cca,
+				      bb->phy_idx);
+
+		env->nhm_include_cca = para->nhm_incld_cca;
+	}
+
+	rtw89_phy_nhm_th_update(rtwdev, bb);
+
+	return 0;
+}
+
+static void __rtw89_phy_nhm_trigger(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
+{
+	struct rtw89_ccx_para_info para = {
+		.mntr_time = RTW89_NHM_MNTR_TIME,
+		.rac_lv = RTW89_RAC_LV_1,
+		.nhm_incld_cca = true,
+	};
+
+	rtw89_phy_ccx_racing_release(rtwdev, bb);
+
+	rtw89_phy_nhm_set(rtwdev, bb, &para);
+	rtw89_phy_ccx_trigger(rtwdev, bb, RTW89_PHY_ENV_MON_NHM);
+}
+
+void rtw89_phy_nhm_trigger(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_bb_ctx *bb;
+
+	if (!chip->support_noise)
+		return;
+
+	rtw89_for_each_active_bb(rtwdev, bb)
+		__rtw89_phy_nhm_trigger(rtwdev, bb);
+}
+
 static int rtw89_phy_ifs_clm_set(struct rtw89_dev *rtwdev,
 				 struct rtw89_bb_ctx *bb,
 				 struct rtw89_ccx_para_info *para)
@@ -5815,7 +6070,7 @@ static void __rtw89_phy_env_monitor_track(struct rtw89_dev *rtwdev,
 	if (rtw89_phy_ifs_clm_set(rtwdev, bb, &para) == 0)
 		chk_result |= RTW89_PHY_ENV_MON_IFS_CLM;
 	if (chk_result)
-		rtw89_phy_ccx_trigger(rtwdev, bb);
+		rtw89_phy_ccx_trigger(rtwdev, bb, chk_result);
 
 	rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK,
 		    "get_result=0x%x, chk_result:0x%x\n",
@@ -6909,6 +7164,7 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 	rtw89_chip_bb_sethw(rtwdev);
 
 	rtw89_phy_env_monitor_init(rtwdev);
+	rtw89_phy_nhm_setting_init(rtwdev);
 	rtw89_physts_parsing_init(rtwdev);
 	rtw89_phy_dig_init(rtwdev);
 	rtw89_phy_cfo_init(rtwdev);
@@ -6934,6 +7190,43 @@ void rtw89_phy_dm_reinit(struct rtw89_dev *rtwdev)
 	rtw89_physts_parsing_init(rtwdev);
 }
 
+static void __rtw89_phy_dm_init_data(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
+{
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct ieee80211_supported_band *sband;
+	enum rtw89_band hw_band;
+	enum nl80211_band band;
+	u8 idx;
+
+	if (!chip->support_noise)
+		return;
+
+	for (band = 0; band < NUM_NL80211_BANDS; band++) {
+		sband = rtwdev->hw->wiphy->bands[band];
+		if (!sband)
+			continue;
+
+		hw_band = rtw89_nl80211_to_hw_band(band);
+		env->nhm_his[hw_band] =
+			devm_kcalloc(rtwdev->dev, sband->n_channels,
+				     sizeof(*env->nhm_his[0]), GFP_KERNEL);
+
+		for (idx = 0; idx < sband->n_channels; idx++)
+			INIT_LIST_HEAD(&env->nhm_his[hw_band][idx].list);
+
+		INIT_LIST_HEAD(&env->nhm_rpt_list);
+	}
+}
+
+void rtw89_phy_dm_init_data(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_bb_ctx *bb;
+
+	rtw89_for_each_capab_bb(rtwdev, bb)
+		__rtw89_phy_dm_init_data(rtwdev, bb);
+}
+
 void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev,
 			     struct rtw89_vif_link *rtwvif_link)
 {
@@ -7589,6 +7882,15 @@ static const struct rtw89_ccx_regs rtw89_ccx_regs_ax = {
 	.ifs_total_addr = R_IFSCNT,
 	.ifs_cnt_done_mask = B_IFSCNT_DONE_MSK,
 	.ifs_total_mask = B_IFSCNT_TOTAL_CNT_MSK,
+	.nhm = R_NHM_AX,
+	.nhm_ready = B_NHM_READY_MSK,
+	.nhm_config = R_NHM_CFG,
+	.nhm_period_mask = B_NHM_PERIOD_MSK,
+	.nhm_unit_mask = B_NHM_COUNTER_MSK,
+	.nhm_include_cca_mask = B_NHM_INCLUDE_CCA_MSK,
+	.nhm_en_mask = B_NHM_EN_MSK,
+	.nhm_method = R_NHM_TH9,
+	.nhm_pwr_method_msk = B_NHM_PWDB_METHOD_MSK,
 };
 
 static const struct rtw89_physts_regs rtw89_physts_regs_ax = {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index dc156376d951..1184b3c16d6f 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -188,6 +188,12 @@ enum rtw89_env_monitor_result_level {
 	RTW89_PHY_ENV_MON_EDCCA_CLM = BIT(4),
 };
 
+#define RTW89_NHM_WEIGHT_OFFSET 2
+#define RTW89_NHM_WA_TH (109 << 1)
+#define RTW89_NOISE_DEFAULT -96
+#define RTW89_NHM_MNTR_TIME 40
+#define RTW89_NHM_TH_FACTOR 1
+
 #define CCX_US_BASE_RATIO 4
 enum rtw89_ccx_unit {
 	RTW89_CCX_4_US = 0,
@@ -428,6 +434,15 @@ struct rtw89_ccx_regs {
 	u32 ifs_total_addr;
 	u32 ifs_cnt_done_mask;
 	u32 ifs_total_mask;
+	u32 nhm;
+	u32 nhm_ready;
+	u32 nhm_config;
+	u32 nhm_period_mask;
+	u32 nhm_unit_mask;
+	u32 nhm_include_cca_mask;
+	u32 nhm_en_mask;
+	u32 nhm_method;
+	u32 nhm_pwr_method_msk;
 };
 
 struct rtw89_physts_regs {
@@ -821,6 +836,7 @@ void rtw89_phy_config_rf_reg_v1(struct rtw89_dev *rtwdev,
 				void *extra_data);
 void rtw89_phy_dm_init(struct rtw89_dev *rtwdev);
 void rtw89_phy_dm_reinit(struct rtw89_dev *rtwdev);
+void rtw89_phy_dm_init_data(struct rtw89_dev *rtwdev);
 void rtw89_phy_write32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 			   u32 data, enum rtw89_phy_idx phy_idx);
 void rtw89_phy_write32_idx_set(struct rtw89_dev *rtwdev, u32 addr, u32 bits,
@@ -1038,5 +1054,9 @@ enum rtw89_rf_path rtw89_phy_get_syn_sel(struct rtw89_dev *rtwdev,
 u8 rtw89_rfk_chan_lookup(struct rtw89_dev *rtwdev,
 			 const struct rtw89_rfk_chan_desc *desc, u8 desc_nr,
 			 const struct rtw89_chan *target_chan);
+void rtw89_phy_nhm_setting_init(struct rtw89_dev *rtwdev);
+void rtw89_phy_nhm_get_result(struct rtw89_dev *rtwdev, enum rtw89_band hw_band,
+			      u16 ch_hw_value);
+void rtw89_phy_nhm_trigger(struct rtw89_dev *rtwdev);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index d321cf1fc485..3316a38a62d0 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -63,6 +63,15 @@ static const struct rtw89_ccx_regs rtw89_ccx_regs_be = {
 	.ifs_total_addr = R_IFSCNT_V1,
 	.ifs_cnt_done_mask = B_IFSCNT_DONE_MSK,
 	.ifs_total_mask = B_IFSCNT_TOTAL_CNT_MSK,
+	.nhm = R_NHM_BE,
+	.nhm_ready = B_NHM_READY_BE_MSK,
+	.nhm_config = R_NHM_CFG,
+	.nhm_period_mask = B_NHM_PERIOD_MSK,
+	.nhm_unit_mask = B_NHM_COUNTER_MSK,
+	.nhm_include_cca_mask = B_NHM_INCLUDE_CCA_MSK,
+	.nhm_en_mask = B_NHM_EN_MSK,
+	.nhm_method = R_NHM_TH9,
+	.nhm_pwr_method_msk = B_NHM_PWDB_METHOD_MSK,
 };
 
 static const struct rtw89_physts_regs rtw89_physts_regs_be = {
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index bfed0bbcfb7e..d94d73e50e93 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8100,6 +8100,26 @@
 #define B_MEASUREMENT_TRIG_MSK BIT(2)
 #define B_CCX_TRIG_OPT_MSK BIT(1)
 #define B_CCX_EN_MSK BIT(0)
+#define R_NHM_CFG 0x0C08
+#define B_NHM_PERIOD_MSK GENMASK(15, 0)
+#define B_NHM_COUNTER_MSK GENMASK(17, 16)
+#define B_NHM_EN_MSK BIT(18)
+#define B_NHM_INCLUDE_CCA_MSK BIT(19)
+#define B_NHM_TH0_MSK GENMASK(31, 24)
+#define R_NHM_TH1 0x0C0C
+#define B_NHM_TH1_MSK GENMASK(7, 0)
+#define B_NHM_TH2_MSK GENMASK(15, 8)
+#define B_NHM_TH3_MSK GENMASK(23, 16)
+#define B_NHM_TH4_MSK GENMASK(31, 24)
+#define R_NHM_TH5 0x0C10
+#define B_NHM_TH5_MSK GENMASK(7, 0)
+#define B_NHM_TH6_MSK GENMASK(15, 8)
+#define B_NHM_TH7_MSK GENMASK(23, 16)
+#define B_NHM_TH8_MSK GENMASK(31, 24)
+#define R_NHM_TH9 0x0C14
+#define B_NHM_TH9_MSK GENMASK(7, 0)
+#define B_NHM_TH10_MSK GENMASK(15, 8)
+#define B_NHM_PWDB_METHOD_MSK GENMASK(17, 16)
 #define R_FAHM 0x0C1C
 #define B_RXTD_CKEN BIT(2)
 #define R_IFS_COUNTER 0x0C28
@@ -8169,6 +8189,8 @@
 #define R_BRK_ASYNC_RST_EN_1 0x0DC0
 #define R_BRK_ASYNC_RST_EN_2 0x0DC4
 #define R_BRK_ASYNC_RST_EN_3 0x0DC8
+#define R_NHM_BE 0x0EA4
+#define B_NHM_READY_BE_MSK BIT(16)
 #define R_CTLTOP 0x1008
 #define B_CTLTOP_ON BIT(23)
 #define B_CTLTOP_VAL GENMASK(15, 12)
@@ -8224,6 +8246,26 @@
 #define B_SWSI_R_BUSY_V1 BIT(25)
 #define B_SWSI_R_DATA_DONE_V1 BIT(26)
 #define R_TX_COUNTER 0x1A40
+#define R_NHM_CNT0 0x1A88
+#define B_NHM_CNT0_MSK GENMASK(15, 0)
+#define B_NHM_CNT1_MSK GENMASK(31, 16)
+#define R_NHM_CNT2 0x1A8C
+#define B_NHM_CNT2_MSK GENMASK(15, 0)
+#define B_NHM_CNT3_MSK GENMASK(31, 16)
+#define R_NHM_CNT4 0x1A90
+#define B_NHM_CNT4_MSK GENMASK(15, 0)
+#define B_NHM_CNT5_MSK GENMASK(31, 16)
+#define R_NHM_CNT6 0x1A94
+#define B_NHM_CNT6_MSK GENMASK(15, 0)
+#define B_NHM_CNT7_MSK GENMASK(31, 16)
+#define R_NHM_CNT8 0x1A98
+#define B_NHM_CNT8_MSK GENMASK(15, 0)
+#define B_NHM_CNT9_MSK GENMASK(31, 16)
+#define R_NHM_CNT10 0x1A9C
+#define B_NHM_CNT10_MSK GENMASK(15, 0)
+#define B_NHM_CNT11_MSK GENMASK(31, 16)
+#define R_NHM_AX 0x1AA4
+#define B_NHM_READY_MSK BIT(16)
 #define R_IFS_CLM_TX_CNT 0x1ACC
 #define R_IFS_CLM_TX_CNT_V1 0x0ECC
 #define B_IFS_CLM_EDCCA_EXCLUDE_CCA_FA_MSK GENMASK(31, 16)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 393df2b0dcae..084bbf9ecf0b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2628,6 +2628,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.support_ant_gain	= false,
 	.support_tas		= false,
 	.support_sar_by_ant	= false,
+	.support_noise		= false,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= true,
@@ -2689,6 +2690,8 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.cfo_hw_comp		= true,
 	.dcfo_comp		= &rtw8851b_dcfo_comp,
 	.dcfo_comp_sft		= 12,
+	.nhm_report		= NULL,
+	.nhm_th			= NULL,
 	.imr_info		= &rtw8851b_imr_info,
 	.imr_dmac_table		= NULL,
 	.imr_cmac_table		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 3bbe2a808844..1d85607e9424 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -426,6 +426,35 @@ static const struct rtw89_reg_def rtw8852a_dcfo_comp = {
 	R_DCFO_COMP_S0, B_DCFO_COMP_S0_MSK
 };
 
+static const struct rtw89_reg_def rtw8852a_nhm_th[RTW89_NHM_TH_NUM] = {
+	{R_NHM_CFG, B_NHM_TH0_MSK},
+	{R_NHM_TH1, B_NHM_TH1_MSK},
+	{R_NHM_TH1, B_NHM_TH2_MSK},
+	{R_NHM_TH1, B_NHM_TH3_MSK},
+	{R_NHM_TH1, B_NHM_TH4_MSK},
+	{R_NHM_TH5, B_NHM_TH5_MSK},
+	{R_NHM_TH5, B_NHM_TH6_MSK},
+	{R_NHM_TH5, B_NHM_TH7_MSK},
+	{R_NHM_TH5, B_NHM_TH8_MSK},
+	{R_NHM_TH9, B_NHM_TH9_MSK},
+	{R_NHM_TH9, B_NHM_TH10_MSK},
+};
+
+static const struct rtw89_reg_def rtw8852a_nhm_rpt[RTW89_NHM_RPT_NUM] = {
+	{R_NHM_CNT0, B_NHM_CNT0_MSK},
+	{R_NHM_CNT0, B_NHM_CNT1_MSK},
+	{R_NHM_CNT2, B_NHM_CNT2_MSK},
+	{R_NHM_CNT2, B_NHM_CNT3_MSK},
+	{R_NHM_CNT4, B_NHM_CNT4_MSK},
+	{R_NHM_CNT4, B_NHM_CNT5_MSK},
+	{R_NHM_CNT6, B_NHM_CNT6_MSK},
+	{R_NHM_CNT6, B_NHM_CNT7_MSK},
+	{R_NHM_CNT8, B_NHM_CNT8_MSK},
+	{R_NHM_CNT8, B_NHM_CNT9_MSK},
+	{R_NHM_CNT10, B_NHM_CNT10_MSK},
+	{R_NHM_CNT10, B_NHM_CNT11_MSK},
+};
+
 static const struct rtw89_imr_info rtw8852a_imr_info = {
 	.wdrls_imr_set		= B_AX_WDRLS_IMR_SET,
 	.wsec_imr_reg		= R_AX_SEC_DEBUG,
@@ -2220,6 +2249,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.support_ant_gain	= false,
 	.support_tas		= false,
 	.support_sar_by_ant	= false,
+	.support_noise		= true,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= true,
@@ -2282,6 +2312,8 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.cfo_hw_comp            = false,
 	.dcfo_comp		= &rtw8852a_dcfo_comp,
 	.dcfo_comp_sft		= 10,
+	.nhm_report		= &rtw8852a_nhm_rpt,
+	.nhm_th			= &rtw8852a_nhm_th,
 	.imr_info		= &rtw8852a_imr_info,
 	.imr_dmac_table		= NULL,
 	.imr_cmac_table		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 7ede07f7b1eb..6f33f6db2763 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -939,6 +939,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.support_ant_gain	= true,
 	.support_tas		= false,
 	.support_sar_by_ant	= true,
+	.support_noise		= false,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= true,
@@ -1001,6 +1002,8 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.cfo_hw_comp		= true,
 	.dcfo_comp		= &rtw8852b_dcfo_comp,
 	.dcfo_comp_sft		= 10,
+	.nhm_report		= NULL,
+	.nhm_th			= NULL,
 	.imr_info		= &rtw8852b_imr_info,
 	.imr_dmac_table		= NULL,
 	.imr_cmac_table		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 88cf8ea13e7c..b0418e89802f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3043,6 +3043,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.support_ant_gain	= true,
 	.support_tas		= true,
 	.support_sar_by_ant	= true,
+	.support_noise		= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= true,
 	.rx_freq_frome_ie	= false,
@@ -3106,6 +3107,8 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.cfo_hw_comp            = false,
 	.dcfo_comp		= &rtw8852c_dcfo_comp,
 	.dcfo_comp_sft		= 12,
+	.nhm_report		= NULL,
+	.nhm_th			= NULL,
 	.imr_info		= &rtw8852c_imr_info,
 	.imr_dmac_table		= NULL,
 	.imr_cmac_table		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 36c641e3bc13..d7d09d832252 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2896,6 +2896,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.support_ant_gain	= true,
 	.support_tas		= false,
 	.support_sar_by_ant	= true,
+	.support_noise		= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= false,
@@ -2958,6 +2959,8 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.cfo_hw_comp            = true,
 	.dcfo_comp		= NULL,
 	.dcfo_comp_sft		= 0,
+	.nhm_report		= NULL,
+	.nhm_th			= NULL,
 	.imr_info		= NULL,
 	.imr_dmac_table		= &rtw8922a_imr_dmac_table,
 	.imr_cmac_table		= &rtw8922a_imr_cmac_table,
-- 
2.25.1


