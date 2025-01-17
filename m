Return-Path: <linux-wireless+bounces-17626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27602A14A22
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 08:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CAA0161886
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 07:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8771F8670;
	Fri, 17 Jan 2025 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="DMIWeIyH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892771F791B
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098958; cv=none; b=OSkqWD+gCdF+mAqy/5FsxlOplRhr0s3QaqCT4N4i4PTgbZgE52rhLSufUewW3dlpBozuRR2xSlX1+FyARUAZQEwHCYLje3AmJroYLzt6+cvB0R57SWpHSB8PfWKpinhKMOSfMlTXTXkTIRBhMKp1FDqsb1T+EfElW43Ek/ZR8Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098958; c=relaxed/simple;
	bh=AcDMsPznwwoUehRX7l2SUUZKCr6bf6AnH+mExKwElJY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGiWJ/sANKy8K/iq5PaMVa3MJiuDm1f0i4deoroUVgUeShfmfMeI1VrltxbUpx/RQ0cEppBrIgMOUzmwo5i6vlUgJ+EClhac+2SeC/xkG5z9gzc7vYK1EKWwrBX0CfENlUXCn+/xNwAqY7Pd8Xy6wBGBBEhYuB6kPJoxy8J5xHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=DMIWeIyH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50H7T8XW02337812, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737098948; bh=AcDMsPznwwoUehRX7l2SUUZKCr6bf6AnH+mExKwElJY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=DMIWeIyHTVqWXZBzpE2GApMj0IsMCwazz6a2582cYnRnw5xVMPCrqBzU+zRZc/Z1T
	 rl7fSJNeP/8qpB9yBMcFtqe7/5sNnFH6XE4W2/11MUZydajQLapovaWKeuP3grJdK7
	 mD6Splsds7Hgz5yaBVKL6ZyZUagK9JWa5EK4SUvrlu8y+7iimv7GQzZkrwhmesr0MP
	 CVcp2WxS+fNmuH0uZbjnZdOcm1lTmQ/uLAGTCeXkWzgsEUOc+5kvywgU0PlCTLqffc
	 8rbvDIrIRX9eznFWFb07s45quUg/LD+bXmClCiiS4MNipRXSvDIDlpmA4oEn+akmHW
	 kTgkM6AUi0UlQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50H7T8XW02337812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 15:29:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 Jan 2025 15:29:08 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 17 Jan
 2025 15:29:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/8] wifi: rtw89: phy: support env_monitor per PHY
Date: Fri, 17 Jan 2025 15:28:23 +0800
Message-ID: <20250117072828.16728-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117072828.16728-1-pkshih@realtek.com>
References: <20250117072828.16728-1-pkshih@realtek.com>
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

The env_monitor is to collect information of current operating channel as
helper to make decision with better hardware parameters to adopt current
environment.

Use PHY context as argument to control PHY accordingly, and use
rtw89_phy_{write32,read32}_idx with phy_idx to access registers.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |   2 +-
 drivers/net/wireless/realtek/rtw89/phy.c  | 306 +++++++++++++---------
 drivers/net/wireless/realtek/rtw89/sar.c  |   3 +-
 3 files changed, 180 insertions(+), 131 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4e9700ebd7e5..99bb32f4fd8d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5682,7 +5682,6 @@ struct rtw89_dev {
 	struct rtw89_power_trim_info pwr_trim;
 
 	struct rtw89_cfo_tracking_info cfo_tracking;
-	struct rtw89_env_monitor_info env_monitor;
 	struct rtw89_dig_info dig;
 	struct rtw89_phy_ch_info ch_info;
 	union {
@@ -5695,6 +5694,7 @@ struct rtw89_dev {
 
 	struct rtw89_bb_ctx {
 		enum rtw89_phy_idx phy_idx;
+		struct rtw89_env_monitor_info env_monitor;
 	} bbs[RTW89_PHY_NUM];
 
 	struct delayed_work track_work;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c7c05f7fda1d..e266ddae0c31 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -5199,24 +5199,27 @@ void rtw89_phy_stat_track(struct rtw89_dev *rtwdev)
 	memset(&phystat->cur_pkt_stat, 0, sizeof(phystat->cur_pkt_stat));
 }
 
-static u16 rtw89_phy_ccx_us_to_idx(struct rtw89_dev *rtwdev, u32 time_us)
+static u16 rtw89_phy_ccx_us_to_idx(struct rtw89_dev *rtwdev,
+				   struct rtw89_bb_ctx *bb, u32 time_us)
 {
-	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
 
 	return time_us >> (ilog2(CCX_US_BASE_RATIO) + env->ccx_unit_idx);
 }
 
-static u32 rtw89_phy_ccx_idx_to_us(struct rtw89_dev *rtwdev, u16 idx)
+static u32 rtw89_phy_ccx_idx_to_us(struct rtw89_dev *rtwdev,
+				   struct rtw89_bb_ctx *bb, u16 idx)
 {
-	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
 
 	return idx << (ilog2(CCX_US_BASE_RATIO) + env->ccx_unit_idx);
 }
 
-static void rtw89_phy_ccx_top_setting_init(struct rtw89_dev *rtwdev)
+static void rtw89_phy_ccx_top_setting_init(struct rtw89_dev *rtwdev,
+					   struct rtw89_bb_ctx *bb)
 {
 	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
-	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
 	const struct rtw89_ccx_regs *ccx = phy->ccx;
 
 	env->ccx_manual_ctrl = false;
@@ -5225,17 +5228,20 @@ static void rtw89_phy_ccx_top_setting_init(struct rtw89_dev *rtwdev)
 	env->ccx_period = 0;
 	env->ccx_unit_idx = RTW89_CCX_32_US;
 
-	rtw89_phy_set_phy_regs(rtwdev, ccx->setting_addr, ccx->en_mask, 1);
-	rtw89_phy_set_phy_regs(rtwdev, ccx->setting_addr, ccx->trig_opt_mask, 1);
-	rtw89_phy_set_phy_regs(rtwdev, ccx->setting_addr, ccx->measurement_trig_mask, 1);
-	rtw89_phy_set_phy_regs(rtwdev, ccx->setting_addr, ccx->edcca_opt_mask,
-			       RTW89_CCX_EDCCA_BW20_0);
+	rtw89_phy_write32_idx(rtwdev, ccx->setting_addr, ccx->en_mask, 1, bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, ccx->setting_addr, ccx->trig_opt_mask, 1,
+			      bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, ccx->setting_addr, ccx->measurement_trig_mask, 1,
+			      bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, ccx->setting_addr, ccx->edcca_opt_mask,
+			      RTW89_CCX_EDCCA_BW20_0, bb->phy_idx);
 }
 
-static u16 rtw89_phy_ccx_get_report(struct rtw89_dev *rtwdev, u16 report,
-				    u16 score)
+static u16 rtw89_phy_ccx_get_report(struct rtw89_dev *rtwdev,
+				    struct rtw89_bb_ctx *bb,
+				    u16 report, u16 score)
 {
-	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
 	u32 numer = 0;
 	u16 ret = 0;
 
@@ -5275,9 +5281,10 @@ static void rtw89_phy_ccx_ms_to_period_unit(struct rtw89_dev *rtwdev,
 		    *period, *unit_idx);
 }
 
-static void rtw89_phy_ccx_racing_release(struct rtw89_dev *rtwdev)
+static void rtw89_phy_ccx_racing_release(struct rtw89_dev *rtwdev,
+					 struct rtw89_bb_ctx *bb)
 {
-	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
 
 	rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK,
 		    "lv:(%d)->(0)\n", env->ccx_rac_lv);
@@ -5288,9 +5295,10 @@ static void rtw89_phy_ccx_racing_release(struct rtw89_dev *rtwdev)
 }
 
 static bool rtw89_phy_ifs_clm_th_update_check(struct rtw89_dev *rtwdev,
+					      struct rtw89_bb_ctx *bb,
 					      struct rtw89_ccx_para_info *para)
 {
-	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
 	bool is_update = env->ifs_clm_app != para->ifs_clm_app;
 	u8 i = 0;
 	u16 *ifs_th_l = env->ifs_clm_th_l;
@@ -5325,12 +5333,12 @@ static bool rtw89_phy_ifs_clm_th_update_check(struct rtw89_dev *rtwdev,
 	 */
 	ifs_th_l[IFS_CLM_TH_START_IDX] = 0;
 	ifs_th_h_us[IFS_CLM_TH_START_IDX] = ifs_th0_us;
-	ifs_th_h[IFS_CLM_TH_START_IDX] = rtw89_phy_ccx_us_to_idx(rtwdev,
+	ifs_th_h[IFS_CLM_TH_START_IDX] = rtw89_phy_ccx_us_to_idx(rtwdev, bb,
 								 ifs_th0_us);
 	for (i = 1; i < RTW89_IFS_CLM_NUM; i++) {
 		ifs_th_l[i] = ifs_th_h[i - 1] + 1;
 		ifs_th_h_us[i] = ifs_th_h_us[i - 1] * ifs_th_times;
-		ifs_th_h[i] = rtw89_phy_ccx_us_to_idx(rtwdev, ifs_th_h_us[i]);
+		ifs_th_h[i] = rtw89_phy_ccx_us_to_idx(rtwdev, bb, ifs_th_h_us[i]);
 	}
 
 ifs_update_finished:
@@ -5341,30 +5349,31 @@ static bool rtw89_phy_ifs_clm_th_update_check(struct rtw89_dev *rtwdev,
 	return is_update;
 }
 
-static void rtw89_phy_ifs_clm_set_th_reg(struct rtw89_dev *rtwdev)
+static void rtw89_phy_ifs_clm_set_th_reg(struct rtw89_dev *rtwdev,
+					 struct rtw89_bb_ctx *bb)
 {
 	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
-	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
 	const struct rtw89_ccx_regs *ccx = phy->ccx;
 	u8 i = 0;
 
-	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t1_addr, ccx->ifs_t1_th_l_mask,
-			       env->ifs_clm_th_l[0]);
-	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t2_addr, ccx->ifs_t2_th_l_mask,
-			       env->ifs_clm_th_l[1]);
-	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t3_addr, ccx->ifs_t3_th_l_mask,
-			       env->ifs_clm_th_l[2]);
-	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t4_addr, ccx->ifs_t4_th_l_mask,
-			       env->ifs_clm_th_l[3]);
-
-	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t1_addr, ccx->ifs_t1_th_h_mask,
-			       env->ifs_clm_th_h[0]);
-	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t2_addr, ccx->ifs_t2_th_h_mask,
-			       env->ifs_clm_th_h[1]);
-	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t3_addr, ccx->ifs_t3_th_h_mask,
-			       env->ifs_clm_th_h[2]);
-	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t4_addr, ccx->ifs_t4_th_h_mask,
-			       env->ifs_clm_th_h[3]);
+	rtw89_phy_write32_idx(rtwdev, ccx->ifs_t1_addr, ccx->ifs_t1_th_l_mask,
+			      env->ifs_clm_th_l[0], bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, ccx->ifs_t2_addr, ccx->ifs_t2_th_l_mask,
+			      env->ifs_clm_th_l[1], bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, ccx->ifs_t3_addr, ccx->ifs_t3_th_l_mask,
+			      env->ifs_clm_th_l[2], bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, ccx->ifs_t4_addr, ccx->ifs_t4_th_l_mask,
+			      env->ifs_clm_th_l[3], bb->phy_idx);
+
+	rtw89_phy_write32_idx(rtwdev, ccx->ifs_t1_addr, ccx->ifs_t1_th_h_mask,
+			      env->ifs_clm_th_h[0], bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, ccx->ifs_t2_addr, ccx->ifs_t2_th_h_mask,
+			      env->ifs_clm_th_h[1], bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, ccx->ifs_t3_addr, ccx->ifs_t3_th_h_mask,
+			      env->ifs_clm_th_h[2], bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, ccx->ifs_t4_addr, ccx->ifs_t4_th_h_mask,
+			      env->ifs_clm_th_h[3], bb->phy_idx);
 
 	for (i = 0; i < RTW89_IFS_CLM_NUM; i++)
 		rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK,
@@ -5372,31 +5381,38 @@ static void rtw89_phy_ifs_clm_set_th_reg(struct rtw89_dev *rtwdev)
 			    i + 1, env->ifs_clm_th_l[i], env->ifs_clm_th_h[i]);
 }
 
-static void rtw89_phy_ifs_clm_setting_init(struct rtw89_dev *rtwdev)
+static void rtw89_phy_ifs_clm_setting_init(struct rtw89_dev *rtwdev,
+					   struct rtw89_bb_ctx *bb)
 {
 	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
-	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
 	const struct rtw89_ccx_regs *ccx = phy->ccx;
-	struct rtw89_ccx_para_info para = {0};
+	struct rtw89_ccx_para_info para = {};
 
 	env->ifs_clm_app = RTW89_IFS_CLM_BACKGROUND;
 	env->ifs_clm_mntr_time = 0;
 
 	para.ifs_clm_app = RTW89_IFS_CLM_INIT;
-	if (rtw89_phy_ifs_clm_th_update_check(rtwdev, &para))
-		rtw89_phy_ifs_clm_set_th_reg(rtwdev);
+	if (rtw89_phy_ifs_clm_th_update_check(rtwdev, bb, &para))
+		rtw89_phy_ifs_clm_set_th_reg(rtwdev, bb);
 
-	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_cnt_addr, ccx->ifs_collect_en_mask, true);
-	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t1_addr, ccx->ifs_t1_en_mask, true);
-	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t2_addr, ccx->ifs_t2_en_mask, true);
-	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t3_addr, ccx->ifs_t3_en_mask, true);
-	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t4_addr, ccx->ifs_t4_en_mask, true);
+	rtw89_phy_write32_idx(rtwdev, ccx->ifs_cnt_addr, ccx->ifs_collect_en_mask, true,
+			      bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, ccx->ifs_t1_addr, ccx->ifs_t1_en_mask, true,
+			      bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, ccx->ifs_t2_addr, ccx->ifs_t2_en_mask, true,
+			      bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, ccx->ifs_t3_addr, ccx->ifs_t3_en_mask, true,
+			      bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, ccx->ifs_t4_addr, ccx->ifs_t4_en_mask, true,
+			      bb->phy_idx);
 }
 
 static int rtw89_phy_ccx_racing_ctrl(struct rtw89_dev *rtwdev,
+				     struct rtw89_bb_ctx *bb,
 				     enum rtw89_env_racing_lv level)
 {
-	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
 	int ret = 0;
 
 	if (level >= RTW89_RAC_MAX_NUM) {
@@ -5425,56 +5441,62 @@ static int rtw89_phy_ccx_racing_ctrl(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-static void rtw89_phy_ccx_trigger(struct rtw89_dev *rtwdev)
+static void rtw89_phy_ccx_trigger(struct rtw89_dev *rtwdev,
+				  struct rtw89_bb_ctx *bb)
 {
 	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
-	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
 	const struct rtw89_ccx_regs *ccx = phy->ccx;
 
-	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_cnt_addr, ccx->ifs_clm_cnt_clear_mask, 0);
-	rtw89_phy_set_phy_regs(rtwdev, ccx->setting_addr, ccx->measurement_trig_mask, 0);
-	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_cnt_addr, ccx->ifs_clm_cnt_clear_mask, 1);
-	rtw89_phy_set_phy_regs(rtwdev, ccx->setting_addr, ccx->measurement_trig_mask, 1);
+	rtw89_phy_write32_idx(rtwdev, ccx->ifs_cnt_addr, ccx->ifs_clm_cnt_clear_mask, 0,
+			      bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, ccx->setting_addr, ccx->measurement_trig_mask, 0,
+			      bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, ccx->ifs_cnt_addr, ccx->ifs_clm_cnt_clear_mask, 1,
+			      bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, ccx->setting_addr, ccx->measurement_trig_mask, 1,
+			      bb->phy_idx);
 
 	env->ccx_ongoing = true;
 }
 
-static void rtw89_phy_ifs_clm_get_utility(struct rtw89_dev *rtwdev)
+static void rtw89_phy_ifs_clm_get_utility(struct rtw89_dev *rtwdev,
+					  struct rtw89_bb_ctx *bb)
 {
-	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
 	u8 i = 0;
 	u32 res = 0;
 
 	env->ifs_clm_tx_ratio =
-		rtw89_phy_ccx_get_report(rtwdev, env->ifs_clm_tx, PERCENT);
+		rtw89_phy_ccx_get_report(rtwdev, bb, env->ifs_clm_tx, PERCENT);
 	env->ifs_clm_edcca_excl_cca_ratio =
-		rtw89_phy_ccx_get_report(rtwdev, env->ifs_clm_edcca_excl_cca,
+		rtw89_phy_ccx_get_report(rtwdev, bb, env->ifs_clm_edcca_excl_cca,
 					 PERCENT);
 	env->ifs_clm_cck_fa_ratio =
-		rtw89_phy_ccx_get_report(rtwdev, env->ifs_clm_cckfa, PERCENT);
+		rtw89_phy_ccx_get_report(rtwdev, bb, env->ifs_clm_cckfa, PERCENT);
 	env->ifs_clm_ofdm_fa_ratio =
-		rtw89_phy_ccx_get_report(rtwdev, env->ifs_clm_ofdmfa, PERCENT);
+		rtw89_phy_ccx_get_report(rtwdev, bb, env->ifs_clm_ofdmfa, PERCENT);
 	env->ifs_clm_cck_cca_excl_fa_ratio =
-		rtw89_phy_ccx_get_report(rtwdev, env->ifs_clm_cckcca_excl_fa,
+		rtw89_phy_ccx_get_report(rtwdev, bb, env->ifs_clm_cckcca_excl_fa,
 					 PERCENT);
 	env->ifs_clm_ofdm_cca_excl_fa_ratio =
-		rtw89_phy_ccx_get_report(rtwdev, env->ifs_clm_ofdmcca_excl_fa,
+		rtw89_phy_ccx_get_report(rtwdev, bb, env->ifs_clm_ofdmcca_excl_fa,
 					 PERCENT);
 	env->ifs_clm_cck_fa_permil =
-		rtw89_phy_ccx_get_report(rtwdev, env->ifs_clm_cckfa, PERMIL);
+		rtw89_phy_ccx_get_report(rtwdev, bb, env->ifs_clm_cckfa, PERMIL);
 	env->ifs_clm_ofdm_fa_permil =
-		rtw89_phy_ccx_get_report(rtwdev, env->ifs_clm_ofdmfa, PERMIL);
+		rtw89_phy_ccx_get_report(rtwdev, bb, env->ifs_clm_ofdmfa, PERMIL);
 
 	for (i = 0; i < RTW89_IFS_CLM_NUM; i++) {
 		if (env->ifs_clm_his[i] > ENV_MNTR_IFSCLM_HIS_MAX) {
 			env->ifs_clm_ifs_avg[i] = ENV_MNTR_FAIL_DWORD;
 		} else {
 			env->ifs_clm_ifs_avg[i] =
-				rtw89_phy_ccx_idx_to_us(rtwdev,
+				rtw89_phy_ccx_idx_to_us(rtwdev, bb,
 							env->ifs_clm_avg[i]);
 		}
 
-		res = rtw89_phy_ccx_idx_to_us(rtwdev, env->ifs_clm_cca[i]);
+		res = rtw89_phy_ccx_idx_to_us(rtwdev, bb, env->ifs_clm_cca[i]);
 		res += env->ifs_clm_his[i] >> 1;
 		if (env->ifs_clm_his[i])
 			res /= env->ifs_clm_his[i];
@@ -5504,81 +5526,82 @@ static void rtw89_phy_ifs_clm_get_utility(struct rtw89_dev *rtwdev)
 			    env->ifs_clm_cca_avg[i]);
 }
 
-static bool rtw89_phy_ifs_clm_get_result(struct rtw89_dev *rtwdev)
+static bool rtw89_phy_ifs_clm_get_result(struct rtw89_dev *rtwdev,
+					 struct rtw89_bb_ctx *bb)
 {
 	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
-	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
 	const struct rtw89_ccx_regs *ccx = phy->ccx;
 	u8 i = 0;
 
-	if (rtw89_phy_read32_mask(rtwdev, ccx->ifs_total_addr,
-				  ccx->ifs_cnt_done_mask) == 0) {
+	if (rtw89_phy_read32_idx(rtwdev, ccx->ifs_total_addr,
+				 ccx->ifs_cnt_done_mask, bb->phy_idx) == 0) {
 		rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK,
 			    "Get IFS_CLM report Fail\n");
 		return false;
 	}
 
 	env->ifs_clm_tx =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_clm_tx_cnt_addr,
-				      ccx->ifs_clm_tx_cnt_msk);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_clm_tx_cnt_addr,
+				     ccx->ifs_clm_tx_cnt_msk, bb->phy_idx);
 	env->ifs_clm_edcca_excl_cca =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_clm_tx_cnt_addr,
-				      ccx->ifs_clm_edcca_excl_cca_fa_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_clm_tx_cnt_addr,
+				     ccx->ifs_clm_edcca_excl_cca_fa_mask, bb->phy_idx);
 	env->ifs_clm_cckcca_excl_fa =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_clm_cca_addr,
-				      ccx->ifs_clm_cckcca_excl_fa_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_clm_cca_addr,
+				     ccx->ifs_clm_cckcca_excl_fa_mask, bb->phy_idx);
 	env->ifs_clm_ofdmcca_excl_fa =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_clm_cca_addr,
-				      ccx->ifs_clm_ofdmcca_excl_fa_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_clm_cca_addr,
+				     ccx->ifs_clm_ofdmcca_excl_fa_mask, bb->phy_idx);
 	env->ifs_clm_cckfa =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_clm_fa_addr,
-				      ccx->ifs_clm_cck_fa_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_clm_fa_addr,
+				     ccx->ifs_clm_cck_fa_mask, bb->phy_idx);
 	env->ifs_clm_ofdmfa =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_clm_fa_addr,
-				      ccx->ifs_clm_ofdm_fa_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_clm_fa_addr,
+				     ccx->ifs_clm_ofdm_fa_mask, bb->phy_idx);
 
 	env->ifs_clm_his[0] =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_his_addr,
-				      ccx->ifs_t1_his_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_his_addr,
+				     ccx->ifs_t1_his_mask, bb->phy_idx);
 	env->ifs_clm_his[1] =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_his_addr,
-				      ccx->ifs_t2_his_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_his_addr,
+				     ccx->ifs_t2_his_mask, bb->phy_idx);
 	env->ifs_clm_his[2] =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_his_addr,
-				      ccx->ifs_t3_his_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_his_addr,
+				     ccx->ifs_t3_his_mask, bb->phy_idx);
 	env->ifs_clm_his[3] =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_his_addr,
-				      ccx->ifs_t4_his_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_his_addr,
+				     ccx->ifs_t4_his_mask, bb->phy_idx);
 
 	env->ifs_clm_avg[0] =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_avg_l_addr,
-				      ccx->ifs_t1_avg_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_avg_l_addr,
+				     ccx->ifs_t1_avg_mask, bb->phy_idx);
 	env->ifs_clm_avg[1] =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_avg_l_addr,
-				      ccx->ifs_t2_avg_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_avg_l_addr,
+				     ccx->ifs_t2_avg_mask, bb->phy_idx);
 	env->ifs_clm_avg[2] =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_avg_h_addr,
-				      ccx->ifs_t3_avg_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_avg_h_addr,
+				     ccx->ifs_t3_avg_mask, bb->phy_idx);
 	env->ifs_clm_avg[3] =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_avg_h_addr,
-				      ccx->ifs_t4_avg_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_avg_h_addr,
+				     ccx->ifs_t4_avg_mask, bb->phy_idx);
 
 	env->ifs_clm_cca[0] =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_cca_l_addr,
-				      ccx->ifs_t1_cca_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_cca_l_addr,
+				     ccx->ifs_t1_cca_mask, bb->phy_idx);
 	env->ifs_clm_cca[1] =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_cca_l_addr,
-				      ccx->ifs_t2_cca_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_cca_l_addr,
+				     ccx->ifs_t2_cca_mask, bb->phy_idx);
 	env->ifs_clm_cca[2] =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_cca_h_addr,
-				      ccx->ifs_t3_cca_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_cca_h_addr,
+				     ccx->ifs_t3_cca_mask, bb->phy_idx);
 	env->ifs_clm_cca[3] =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_cca_h_addr,
-				      ccx->ifs_t4_cca_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_cca_h_addr,
+				     ccx->ifs_t4_cca_mask, bb->phy_idx);
 
 	env->ifs_clm_total_ifs =
-		rtw89_phy_read32_mask(rtwdev, ccx->ifs_total_addr,
-				      ccx->ifs_total_mask);
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_total_addr,
+				     ccx->ifs_total_mask, bb->phy_idx);
 
 	rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK, "IFS-CLM total_ifs = %d\n",
 		    env->ifs_clm_total_ifs);
@@ -5598,16 +5621,17 @@ static bool rtw89_phy_ifs_clm_get_result(struct rtw89_dev *rtwdev)
 			    "T%d:[%d, %d, %d]\n", i + 1, env->ifs_clm_his[i],
 			    env->ifs_clm_avg[i], env->ifs_clm_cca[i]);
 
-	rtw89_phy_ifs_clm_get_utility(rtwdev);
+	rtw89_phy_ifs_clm_get_utility(rtwdev, bb);
 
 	return true;
 }
 
 static int rtw89_phy_ifs_clm_set(struct rtw89_dev *rtwdev,
+				 struct rtw89_bb_ctx *bb,
 				 struct rtw89_ccx_para_info *para)
 {
 	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
-	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
 	const struct rtw89_ccx_regs *ccx = phy->ccx;
 	u32 period = 0;
 	u32 unit_idx = 0;
@@ -5618,17 +5642,17 @@ static int rtw89_phy_ifs_clm_set(struct rtw89_dev *rtwdev,
 		return -EINVAL;
 	}
 
-	if (rtw89_phy_ccx_racing_ctrl(rtwdev, para->rac_lv))
+	if (rtw89_phy_ccx_racing_ctrl(rtwdev, bb, para->rac_lv))
 		return -EINVAL;
 
 	if (para->mntr_time != env->ifs_clm_mntr_time) {
 		rtw89_phy_ccx_ms_to_period_unit(rtwdev, para->mntr_time,
 						&period, &unit_idx);
-		rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_cnt_addr,
-				       ccx->ifs_clm_period_mask, period);
-		rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_cnt_addr,
-				       ccx->ifs_clm_cnt_unit_mask,
-				       unit_idx);
+		rtw89_phy_write32_idx(rtwdev, ccx->ifs_cnt_addr,
+				      ccx->ifs_clm_period_mask, period, bb->phy_idx);
+		rtw89_phy_write32_idx(rtwdev, ccx->ifs_cnt_addr,
+				      ccx->ifs_clm_cnt_unit_mask,
+				      unit_idx, bb->phy_idx);
 
 		rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK,
 			    "Update IFS-CLM time ((%d)) -> ((%d))\n",
@@ -5639,18 +5663,19 @@ static int rtw89_phy_ifs_clm_set(struct rtw89_dev *rtwdev,
 		env->ccx_unit_idx = (u8)unit_idx;
 	}
 
-	if (rtw89_phy_ifs_clm_th_update_check(rtwdev, para)) {
+	if (rtw89_phy_ifs_clm_th_update_check(rtwdev, bb, para)) {
 		env->ifs_clm_app = para->ifs_clm_app;
-		rtw89_phy_ifs_clm_set_th_reg(rtwdev);
+		rtw89_phy_ifs_clm_set_th_reg(rtwdev, bb);
 	}
 
 	return 0;
 }
 
-void rtw89_phy_env_monitor_track(struct rtw89_dev *rtwdev)
+static void __rtw89_phy_env_monitor_track(struct rtw89_dev *rtwdev,
+					  struct rtw89_bb_ctx *bb)
 {
-	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
-	struct rtw89_ccx_para_info para = {0};
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
+	struct rtw89_ccx_para_info para = {};
 	u8 chk_result = RTW89_PHY_ENV_MON_CCX_FAIL;
 
 	env->ccx_watchdog_result = RTW89_PHY_ENV_MON_CCX_FAIL;
@@ -5660,25 +5685,36 @@ void rtw89_phy_env_monitor_track(struct rtw89_dev *rtwdev)
 		return;
 	}
 
+	rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK,
+		    "BB-%d env_monitor track\n", bb->phy_idx);
+
 	/* only ifs_clm for now */
-	if (rtw89_phy_ifs_clm_get_result(rtwdev))
+	if (rtw89_phy_ifs_clm_get_result(rtwdev, bb))
 		env->ccx_watchdog_result |= RTW89_PHY_ENV_MON_IFS_CLM;
 
-	rtw89_phy_ccx_racing_release(rtwdev);
+	rtw89_phy_ccx_racing_release(rtwdev, bb);
 	para.mntr_time = 1900;
 	para.rac_lv = RTW89_RAC_LV_1;
 	para.ifs_clm_app = RTW89_IFS_CLM_BACKGROUND;
 
-	if (rtw89_phy_ifs_clm_set(rtwdev, &para) == 0)
+	if (rtw89_phy_ifs_clm_set(rtwdev, bb, &para) == 0)
 		chk_result |= RTW89_PHY_ENV_MON_IFS_CLM;
 	if (chk_result)
-		rtw89_phy_ccx_trigger(rtwdev);
+		rtw89_phy_ccx_trigger(rtwdev, bb);
 
 	rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK,
 		    "get_result=0x%x, chk_result:0x%x\n",
 		    env->ccx_watchdog_result, chk_result);
 }
 
+void rtw89_phy_env_monitor_track(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_bb_ctx *bb;
+
+	rtw89_for_each_active_bb(rtwdev, bb)
+		__rtw89_phy_env_monitor_track(rtwdev, bb);
+}
+
 static bool rtw89_physts_ie_page_valid(enum rtw89_phy_status_bitmap *ie_page)
 {
 	if (*ie_page >= RTW89_PHYSTS_BITMAP_NUM ||
@@ -6020,7 +6056,7 @@ static void rtw89_phy_dig_gaincode_by_rssi(struct rtw89_dev *rtwdev, u8 rssi,
 static void rtw89_phy_dig_igi_offset_by_env(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_dig_info *dig = &rtwdev->dig;
-	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	struct rtw89_env_monitor_info *env = &rtwdev->bbs[0].env_monitor;
 	enum rtw89_dig_noisy_level noisy_lv;
 	u8 igi_offset = dig->fa_rssi_ofst;
 	u16 fa_ratio = 0;
@@ -6486,10 +6522,22 @@ void rtw89_phy_antdiv_track(struct rtw89_dev *rtwdev)
 	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->antdiv_work, 0);
 }
 
+static void __rtw89_phy_env_monitor_init(struct rtw89_dev *rtwdev,
+					 struct rtw89_bb_ctx *bb)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK,
+		    "BB-%d env_monitor init\n", bb->phy_idx);
+
+	rtw89_phy_ccx_top_setting_init(rtwdev, bb);
+	rtw89_phy_ifs_clm_setting_init(rtwdev, bb);
+}
+
 static void rtw89_phy_env_monitor_init(struct rtw89_dev *rtwdev)
 {
-	rtw89_phy_ccx_top_setting_init(rtwdev);
-	rtw89_phy_ifs_clm_setting_init(rtwdev);
+	struct rtw89_bb_ctx *bb;
+
+	rtw89_for_each_capab_bb(rtwdev, bb)
+		__rtw89_phy_env_monitor_init(rtwdev, bb);
 }
 
 static void rtw89_phy_edcca_init(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 871f45a6508c..94db695e78e6 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -411,7 +411,8 @@ static const struct rtw89_reg_def txpwr_regs[] = {
 
 void rtw89_tas_track(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	struct rtw89_bb_ctx *bb = rtw89_get_bb_ctx(rtwdev, RTW89_PHY_0);
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
 	const enum rtw89_sar_sources src = rtwdev->sar.src;
 	u8 max_nss_num = rtwdev->chip->rf_path_num;
 	struct rtw89_tas_info *tas = &rtwdev->tas;
-- 
2.25.1


