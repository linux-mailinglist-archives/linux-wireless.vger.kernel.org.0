Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8520A78416C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 14:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbjHVM7g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbjHVM7g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 08:59:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11F21CE3
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 05:59:28 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37MCwwGN3022610, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37MCwwGN3022610
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 20:58:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 22 Aug 2023 20:59:20 +0800
Received: from [127.0.1.1] (172.16.23.216) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 22 Aug
 2023 20:59:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <cj.hsieh@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/6] wifi: rtw89: phy: modify register setting of ENV_MNTR, PHYSTS and DIG
Date:   Tue, 22 Aug 2023 20:58:22 +0800
Message-ID: <20230822125822.23817-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822125822.23817-1-pkshih@realtek.com>
References: <20230822125822.23817-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.23.216]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Cheng-Chieh Hsieh <cj.hsieh@realtek.com>

The ENV_MNTR(environment monitor) is the dynamic mechanism which based on
the HW of CCX(Cisco Compatible Extensions) which provide the channel
loading and noisy level indicator to debug or support the 802.11k. The
PHYSTS provide the detail PHY information per packet we received for
debugging. The DIG(dynamic initial gain) is the dynamic mechanism to
adjust the packet detect power level by received signal strength to avoid
false detection of the WiFi packet.

The address of registers used for ENV_MNTR, PHYSTS and DIG of WiFi 7 IC
are different with WiFi 6 series, so we modify the method to access the
register address in order to compatible with all WiFi 7 and 6 ICs.

Signed-off-by: Cheng-Chieh Hsieh <cj.hsieh@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |   4 +
 drivers/net/wireless/realtek/rtw89/phy.c      | 223 +++++++++++++-----
 drivers/net/wireless/realtek/rtw89/phy.h      |  66 ++++++
 drivers/net/wireless/realtek/rtw89/phy_be.c   |  67 ++++++
 drivers/net/wireless/realtek/rtw89/reg.h      |  13 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   4 +
 9 files changed, 325 insertions(+), 64 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c49a1ab53f09..b49a7005f872 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3341,6 +3341,10 @@ struct rtw89_dig_regs {
 	u32 seg0_pd_reg;
 	u32 pd_lower_bound_mask;
 	u32 pd_spatial_reuse_en;
+	u32 bmode_pd_reg;
+	u32 bmode_cca_rssi_limit_en;
+	u32 bmode_pd_lower_bound_reg;
+	u32 bmode_rssi_nocca_low_th_mask;
 	struct rtw89_reg_def p0_lna_init;
 	struct rtw89_reg_def p1_lna_init;
 	struct rtw89_reg_def p0_tia_init;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 9dc444934125..93446819d93f 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3230,7 +3230,9 @@ static u32 rtw89_phy_ccx_idx_to_us(struct rtw89_dev *rtwdev, u16 idx)
 
 static void rtw89_phy_ccx_top_setting_init(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	const struct rtw89_ccx_regs *ccx = phy->ccx;
 
 	env->ccx_manual_ctrl = false;
 	env->ccx_ongoing = false;
@@ -3238,10 +3240,10 @@ static void rtw89_phy_ccx_top_setting_init(struct rtw89_dev *rtwdev)
 	env->ccx_period = 0;
 	env->ccx_unit_idx = RTW89_CCX_32_US;
 
-	rtw89_phy_set_phy_regs(rtwdev, R_CCX, B_CCX_EN_MSK, 1);
-	rtw89_phy_set_phy_regs(rtwdev, R_CCX, B_CCX_TRIG_OPT_MSK, 1);
-	rtw89_phy_set_phy_regs(rtwdev, R_CCX, B_MEASUREMENT_TRIG_MSK, 1);
-	rtw89_phy_set_phy_regs(rtwdev, R_CCX, B_CCX_EDCCA_OPT_MSK,
+	rtw89_phy_set_phy_regs(rtwdev, ccx->setting_addr, ccx->en_mask, 1);
+	rtw89_phy_set_phy_regs(rtwdev, ccx->setting_addr, ccx->trig_opt_mask, 1);
+	rtw89_phy_set_phy_regs(rtwdev, ccx->setting_addr, ccx->measurement_trig_mask, 1);
+	rtw89_phy_set_phy_regs(rtwdev, ccx->setting_addr, ccx->edcca_opt_mask,
 			       RTW89_CCX_EDCCA_BW20_0);
 }
 
@@ -3356,25 +3358,27 @@ static bool rtw89_phy_ifs_clm_th_update_check(struct rtw89_dev *rtwdev,
 
 static void rtw89_phy_ifs_clm_set_th_reg(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	const struct rtw89_ccx_regs *ccx = phy->ccx;
 	u8 i = 0;
 
-	rtw89_phy_set_phy_regs(rtwdev, R_IFS_T1, B_IFS_T1_TH_LOW_MSK,
+	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t1_addr, ccx->ifs_t1_th_l_mask,
 			       env->ifs_clm_th_l[0]);
-	rtw89_phy_set_phy_regs(rtwdev, R_IFS_T2, B_IFS_T2_TH_LOW_MSK,
+	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t2_addr, ccx->ifs_t2_th_l_mask,
 			       env->ifs_clm_th_l[1]);
-	rtw89_phy_set_phy_regs(rtwdev, R_IFS_T3, B_IFS_T3_TH_LOW_MSK,
+	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t3_addr, ccx->ifs_t3_th_l_mask,
 			       env->ifs_clm_th_l[2]);
-	rtw89_phy_set_phy_regs(rtwdev, R_IFS_T4, B_IFS_T4_TH_LOW_MSK,
+	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t4_addr, ccx->ifs_t4_th_l_mask,
 			       env->ifs_clm_th_l[3]);
 
-	rtw89_phy_set_phy_regs(rtwdev, R_IFS_T1, B_IFS_T1_TH_HIGH_MSK,
+	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t1_addr, ccx->ifs_t1_th_h_mask,
 			       env->ifs_clm_th_h[0]);
-	rtw89_phy_set_phy_regs(rtwdev, R_IFS_T2, B_IFS_T2_TH_HIGH_MSK,
+	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t2_addr, ccx->ifs_t2_th_h_mask,
 			       env->ifs_clm_th_h[1]);
-	rtw89_phy_set_phy_regs(rtwdev, R_IFS_T3, B_IFS_T3_TH_HIGH_MSK,
+	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t3_addr, ccx->ifs_t3_th_h_mask,
 			       env->ifs_clm_th_h[2]);
-	rtw89_phy_set_phy_regs(rtwdev, R_IFS_T4, B_IFS_T4_TH_HIGH_MSK,
+	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t4_addr, ccx->ifs_t4_th_h_mask,
 			       env->ifs_clm_th_h[3]);
 
 	for (i = 0; i < RTW89_IFS_CLM_NUM; i++)
@@ -3385,7 +3389,9 @@ static void rtw89_phy_ifs_clm_set_th_reg(struct rtw89_dev *rtwdev)
 
 static void rtw89_phy_ifs_clm_setting_init(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	const struct rtw89_ccx_regs *ccx = phy->ccx;
 	struct rtw89_ccx_para_info para = {0};
 
 	env->ifs_clm_app = RTW89_IFS_CLM_BACKGROUND;
@@ -3395,12 +3401,11 @@ static void rtw89_phy_ifs_clm_setting_init(struct rtw89_dev *rtwdev)
 	if (rtw89_phy_ifs_clm_th_update_check(rtwdev, &para))
 		rtw89_phy_ifs_clm_set_th_reg(rtwdev);
 
-	rtw89_phy_set_phy_regs(rtwdev, R_IFS_COUNTER, B_IFS_COLLECT_EN,
-			       true);
-	rtw89_phy_set_phy_regs(rtwdev, R_IFS_T1, B_IFS_T1_EN_MSK, true);
-	rtw89_phy_set_phy_regs(rtwdev, R_IFS_T2, B_IFS_T2_EN_MSK, true);
-	rtw89_phy_set_phy_regs(rtwdev, R_IFS_T3, B_IFS_T3_EN_MSK, true);
-	rtw89_phy_set_phy_regs(rtwdev, R_IFS_T4, B_IFS_T4_EN_MSK, true);
+	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_cnt_addr, ccx->ifs_collect_en_mask, true);
+	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t1_addr, ccx->ifs_t1_en_mask, true);
+	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t2_addr, ccx->ifs_t2_en_mask, true);
+	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t3_addr, ccx->ifs_t3_en_mask, true);
+	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_t4_addr, ccx->ifs_t4_en_mask, true);
 }
 
 static int rtw89_phy_ccx_racing_ctrl(struct rtw89_dev *rtwdev,
@@ -3437,12 +3442,14 @@ static int rtw89_phy_ccx_racing_ctrl(struct rtw89_dev *rtwdev,
 
 static void rtw89_phy_ccx_trigger(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	const struct rtw89_ccx_regs *ccx = phy->ccx;
 
-	rtw89_phy_set_phy_regs(rtwdev, R_IFS_COUNTER, B_IFS_COUNTER_CLR_MSK, 0);
-	rtw89_phy_set_phy_regs(rtwdev, R_CCX, B_MEASUREMENT_TRIG_MSK, 0);
-	rtw89_phy_set_phy_regs(rtwdev, R_IFS_COUNTER, B_IFS_COUNTER_CLR_MSK, 1);
-	rtw89_phy_set_phy_regs(rtwdev, R_CCX, B_MEASUREMENT_TRIG_MSK, 1);
+	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_cnt_addr, ccx->ifs_clm_cnt_clear_mask, 0);
+	rtw89_phy_set_phy_regs(rtwdev, ccx->setting_addr, ccx->measurement_trig_mask, 0);
+	rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_cnt_addr, ccx->ifs_clm_cnt_clear_mask, 1);
+	rtw89_phy_set_phy_regs(rtwdev, ccx->setting_addr, ccx->measurement_trig_mask, 1);
 
 	env->ccx_ongoing = true;
 }
@@ -3514,63 +3521,79 @@ static void rtw89_phy_ifs_clm_get_utility(struct rtw89_dev *rtwdev)
 
 static bool rtw89_phy_ifs_clm_get_result(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	const struct rtw89_ccx_regs *ccx = phy->ccx;
 	u8 i = 0;
 
-	if (rtw89_phy_read32_mask(rtwdev, R_IFSCNT, B_IFSCNT_DONE_MSK) == 0) {
+	if (rtw89_phy_read32_mask(rtwdev, ccx->ifs_total_addr,
+				  ccx->ifs_cnt_done_mask) == 0) {
 		rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK,
 			    "Get IFS_CLM report Fail\n");
 		return false;
 	}
 
 	env->ifs_clm_tx =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_CLM_TX_CNT,
-				      B_IFS_CLM_TX_CNT_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_clm_tx_cnt_addr,
+				      ccx->ifs_clm_tx_cnt_msk);
 	env->ifs_clm_edcca_excl_cca =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_CLM_TX_CNT,
-				      B_IFS_CLM_EDCCA_EXCLUDE_CCA_FA_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_clm_tx_cnt_addr,
+				      ccx->ifs_clm_edcca_excl_cca_fa_mask);
 	env->ifs_clm_cckcca_excl_fa =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_CLM_CCA,
-				      B_IFS_CLM_CCKCCA_EXCLUDE_FA_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_clm_cca_addr,
+				      ccx->ifs_clm_cckcca_excl_fa_mask);
 	env->ifs_clm_ofdmcca_excl_fa =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_CLM_CCA,
-				      B_IFS_CLM_OFDMCCA_EXCLUDE_FA_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_clm_cca_addr,
+				      ccx->ifs_clm_ofdmcca_excl_fa_mask);
 	env->ifs_clm_cckfa =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_CLM_FA,
-				      B_IFS_CLM_CCK_FA_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_clm_fa_addr,
+				      ccx->ifs_clm_cck_fa_mask);
 	env->ifs_clm_ofdmfa =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_CLM_FA,
-				      B_IFS_CLM_OFDM_FA_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_clm_fa_addr,
+				      ccx->ifs_clm_ofdm_fa_mask);
 
 	env->ifs_clm_his[0] =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_HIS, B_IFS_T1_HIS_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_his_addr,
+				      ccx->ifs_t1_his_mask);
 	env->ifs_clm_his[1] =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_HIS, B_IFS_T2_HIS_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_his_addr,
+				      ccx->ifs_t2_his_mask);
 	env->ifs_clm_his[2] =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_HIS, B_IFS_T3_HIS_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_his_addr,
+				      ccx->ifs_t3_his_mask);
 	env->ifs_clm_his[3] =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_HIS, B_IFS_T4_HIS_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_his_addr,
+				      ccx->ifs_t4_his_mask);
 
 	env->ifs_clm_avg[0] =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_AVG_L, B_IFS_T1_AVG_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_avg_l_addr,
+				      ccx->ifs_t1_avg_mask);
 	env->ifs_clm_avg[1] =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_AVG_L, B_IFS_T2_AVG_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_avg_l_addr,
+				      ccx->ifs_t2_avg_mask);
 	env->ifs_clm_avg[2] =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_AVG_H, B_IFS_T3_AVG_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_avg_h_addr,
+				      ccx->ifs_t3_avg_mask);
 	env->ifs_clm_avg[3] =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_AVG_H, B_IFS_T4_AVG_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_avg_h_addr,
+				      ccx->ifs_t4_avg_mask);
 
 	env->ifs_clm_cca[0] =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_CCA_L, B_IFS_T1_CCA_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_cca_l_addr,
+				      ccx->ifs_t1_cca_mask);
 	env->ifs_clm_cca[1] =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_CCA_L, B_IFS_T2_CCA_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_cca_l_addr,
+				      ccx->ifs_t2_cca_mask);
 	env->ifs_clm_cca[2] =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_CCA_H, B_IFS_T3_CCA_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_cca_h_addr,
+				      ccx->ifs_t3_cca_mask);
 	env->ifs_clm_cca[3] =
-		rtw89_phy_read32_mask(rtwdev, R_IFS_CCA_H, B_IFS_T4_CCA_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_cca_h_addr,
+				      ccx->ifs_t4_cca_mask);
 
 	env->ifs_clm_total_ifs =
-		rtw89_phy_read32_mask(rtwdev, R_IFSCNT, B_IFSCNT_TOTAL_CNT_MSK);
+		rtw89_phy_read32_mask(rtwdev, ccx->ifs_total_addr,
+				      ccx->ifs_total_mask);
 
 	rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK, "IFS-CLM total_ifs = %d\n",
 		    env->ifs_clm_total_ifs);
@@ -3598,7 +3621,9 @@ static bool rtw89_phy_ifs_clm_get_result(struct rtw89_dev *rtwdev)
 static int rtw89_phy_ifs_clm_set(struct rtw89_dev *rtwdev,
 				 struct rtw89_ccx_para_info *para)
 {
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 	struct rtw89_env_monitor_info *env = &rtwdev->env_monitor;
+	const struct rtw89_ccx_regs *ccx = phy->ccx;
 	u32 period = 0;
 	u32 unit_idx = 0;
 
@@ -3614,10 +3639,11 @@ static int rtw89_phy_ifs_clm_set(struct rtw89_dev *rtwdev,
 	if (para->mntr_time != env->ifs_clm_mntr_time) {
 		rtw89_phy_ccx_ms_to_period_unit(rtwdev, para->mntr_time,
 						&period, &unit_idx);
-		rtw89_phy_set_phy_regs(rtwdev, R_IFS_COUNTER,
-				       B_IFS_CLM_PERIOD_MSK, period);
-		rtw89_phy_set_phy_regs(rtwdev, R_IFS_COUNTER,
-				       B_IFS_CLM_COUNTER_UNIT_MSK, unit_idx);
+		rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_cnt_addr,
+				       ccx->ifs_clm_period_mask, period);
+		rtw89_phy_set_phy_regs(rtwdev, ccx->ifs_cnt_addr,
+				       ccx->ifs_clm_cnt_unit_mask,
+				       unit_idx);
 
 		rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK,
 			    "Update IFS-CLM time ((%d)) -> ((%d))\n",
@@ -3735,16 +3761,19 @@ static void rtw89_physts_enable_fail_report(struct rtw89_dev *rtwdev,
 					    bool enable,
 					    enum rtw89_phy_idx phy_idx)
 {
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+	const struct rtw89_physts_regs *physts = phy->physts;
+
 	if (enable) {
-		rtw89_phy_write32_clr(rtwdev, R_PLCP_HISTOGRAM,
-				      B_STS_DIS_TRIG_BY_FAIL);
-		rtw89_phy_write32_clr(rtwdev, R_PLCP_HISTOGRAM,
-				      B_STS_DIS_TRIG_BY_BRK);
+		rtw89_phy_write32_clr(rtwdev, physts->setting_addr,
+				      physts->dis_trigger_fail_mask);
+		rtw89_phy_write32_clr(rtwdev, physts->setting_addr,
+				      physts->dis_trigger_brk_mask);
 	} else {
-		rtw89_phy_write32_set(rtwdev, R_PLCP_HISTOGRAM,
-				      B_STS_DIS_TRIG_BY_FAIL);
-		rtw89_phy_write32_set(rtwdev, R_PLCP_HISTOGRAM,
-				      B_STS_DIS_TRIG_BY_BRK);
+		rtw89_phy_write32_set(rtwdev, physts->setting_addr,
+				      physts->dis_trigger_fail_mask);
+		rtw89_phy_write32_set(rtwdev, physts->setting_addr,
+				      physts->dis_trigger_brk_mask);
 	}
 }
 
@@ -4172,10 +4201,10 @@ static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev, u8 rssi,
 		    "igi=%d, cck_ccaTH=%d, backoff=%d, cck_PD_low=((%d))dB\n",
 		    final_rssi, cck_cca_th, under_region, pd_val);
 
-	rtw89_phy_write32_mask(rtwdev, R_BMODE_PDTH_EN_V1,
-			       B_BMODE_PDTH_LIMIT_EN_MSK_V1, enable);
-	rtw89_phy_write32_mask(rtwdev, R_BMODE_PDTH_V1,
-			       B_BMODE_PDTH_LOWER_BOUND_MSK_V1, pd_val);
+	rtw89_phy_write32_mask(rtwdev, dig_regs->bmode_pd_reg,
+			       dig_regs->bmode_cca_rssi_limit_en, enable);
+	rtw89_phy_write32_mask(rtwdev, dig_regs->bmode_pd_lower_bound_reg,
+			       dig_regs->bmode_rssi_nocca_low_th_mask, pd_val);
 }
 
 void rtw89_phy_dig_reset(struct rtw89_dev *rtwdev)
@@ -4729,7 +4758,73 @@ void rtw89_phy_config_edcca(struct rtw89_dev *rtwdev, bool scan)
 	}
 }
 
+static const struct rtw89_ccx_regs rtw89_ccx_regs_ax = {
+	.setting_addr = R_CCX,
+	.edcca_opt_mask = B_CCX_EDCCA_OPT_MSK,
+	.measurement_trig_mask = B_MEASUREMENT_TRIG_MSK,
+	.trig_opt_mask = B_CCX_TRIG_OPT_MSK,
+	.en_mask = B_CCX_EN_MSK,
+	.ifs_cnt_addr = R_IFS_COUNTER,
+	.ifs_clm_period_mask = B_IFS_CLM_PERIOD_MSK,
+	.ifs_clm_cnt_unit_mask = B_IFS_CLM_COUNTER_UNIT_MSK,
+	.ifs_clm_cnt_clear_mask = B_IFS_COUNTER_CLR_MSK,
+	.ifs_collect_en_mask = B_IFS_COLLECT_EN,
+	.ifs_t1_addr = R_IFS_T1,
+	.ifs_t1_th_h_mask = B_IFS_T1_TH_HIGH_MSK,
+	.ifs_t1_en_mask = B_IFS_T1_EN_MSK,
+	.ifs_t1_th_l_mask = B_IFS_T1_TH_LOW_MSK,
+	.ifs_t2_addr = R_IFS_T2,
+	.ifs_t2_th_h_mask = B_IFS_T2_TH_HIGH_MSK,
+	.ifs_t2_en_mask = B_IFS_T2_EN_MSK,
+	.ifs_t2_th_l_mask = B_IFS_T2_TH_LOW_MSK,
+	.ifs_t3_addr = R_IFS_T3,
+	.ifs_t3_th_h_mask = B_IFS_T3_TH_HIGH_MSK,
+	.ifs_t3_en_mask = B_IFS_T3_EN_MSK,
+	.ifs_t3_th_l_mask = B_IFS_T3_TH_LOW_MSK,
+	.ifs_t4_addr = R_IFS_T4,
+	.ifs_t4_th_h_mask = B_IFS_T4_TH_HIGH_MSK,
+	.ifs_t4_en_mask = B_IFS_T4_EN_MSK,
+	.ifs_t4_th_l_mask = B_IFS_T4_TH_LOW_MSK,
+	.ifs_clm_tx_cnt_addr = R_IFS_CLM_TX_CNT,
+	.ifs_clm_edcca_excl_cca_fa_mask = B_IFS_CLM_EDCCA_EXCLUDE_CCA_FA_MSK,
+	.ifs_clm_tx_cnt_msk = B_IFS_CLM_TX_CNT_MSK,
+	.ifs_clm_cca_addr = R_IFS_CLM_CCA,
+	.ifs_clm_ofdmcca_excl_fa_mask = B_IFS_CLM_OFDMCCA_EXCLUDE_FA_MSK,
+	.ifs_clm_cckcca_excl_fa_mask = B_IFS_CLM_CCKCCA_EXCLUDE_FA_MSK,
+	.ifs_clm_fa_addr = R_IFS_CLM_FA,
+	.ifs_clm_ofdm_fa_mask = B_IFS_CLM_OFDM_FA_MSK,
+	.ifs_clm_cck_fa_mask = B_IFS_CLM_CCK_FA_MSK,
+	.ifs_his_addr = R_IFS_HIS,
+	.ifs_t4_his_mask = B_IFS_T4_HIS_MSK,
+	.ifs_t3_his_mask = B_IFS_T3_HIS_MSK,
+	.ifs_t2_his_mask = B_IFS_T2_HIS_MSK,
+	.ifs_t1_his_mask = B_IFS_T1_HIS_MSK,
+	.ifs_avg_l_addr = R_IFS_AVG_L,
+	.ifs_t2_avg_mask = B_IFS_T2_AVG_MSK,
+	.ifs_t1_avg_mask = B_IFS_T1_AVG_MSK,
+	.ifs_avg_h_addr = R_IFS_AVG_H,
+	.ifs_t4_avg_mask = B_IFS_T4_AVG_MSK,
+	.ifs_t3_avg_mask = B_IFS_T3_AVG_MSK,
+	.ifs_cca_l_addr = R_IFS_CCA_L,
+	.ifs_t2_cca_mask = B_IFS_T2_CCA_MSK,
+	.ifs_t1_cca_mask = B_IFS_T1_CCA_MSK,
+	.ifs_cca_h_addr = R_IFS_CCA_H,
+	.ifs_t4_cca_mask = B_IFS_T4_CCA_MSK,
+	.ifs_t3_cca_mask = B_IFS_T3_CCA_MSK,
+	.ifs_total_addr = R_IFSCNT,
+	.ifs_cnt_done_mask = B_IFSCNT_DONE_MSK,
+	.ifs_total_mask = B_IFSCNT_TOTAL_CNT_MSK,
+};
+
+static const struct rtw89_physts_regs rtw89_physts_regs_ax = {
+	.setting_addr = R_PLCP_HISTOGRAM,
+	.dis_trigger_fail_mask = B_STS_DIS_TRIG_BY_FAIL,
+	.dis_trigger_brk_mask = B_STS_DIS_TRIG_BY_BRK,
+};
+
 const struct rtw89_phy_gen_def rtw89_phy_gen_ax = {
 	.cr_base = 0x10000,
+	.ccx = &rtw89_ccx_regs_ax,
+	.physts = &rtw89_physts_regs_ax,
 };
 EXPORT_SYMBOL(rtw89_phy_gen_ax);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 36a24676b2fe..d6dc0cbbae43 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -336,8 +336,74 @@ struct rtw89_nbi_reg_def {
 	struct rtw89_reg_def notch2_en;
 };
 
+struct rtw89_ccx_regs {
+	u32 setting_addr;
+	u32 edcca_opt_mask;
+	u32 measurement_trig_mask;
+	u32 trig_opt_mask;
+	u32 en_mask;
+	u32 ifs_cnt_addr;
+	u32 ifs_clm_period_mask;
+	u32 ifs_clm_cnt_unit_mask;
+	u32 ifs_clm_cnt_clear_mask;
+	u32 ifs_collect_en_mask;
+	u32 ifs_t1_addr;
+	u32 ifs_t1_th_h_mask;
+	u32 ifs_t1_en_mask;
+	u32 ifs_t1_th_l_mask;
+	u32 ifs_t2_addr;
+	u32 ifs_t2_th_h_mask;
+	u32 ifs_t2_en_mask;
+	u32 ifs_t2_th_l_mask;
+	u32 ifs_t3_addr;
+	u32 ifs_t3_th_h_mask;
+	u32 ifs_t3_en_mask;
+	u32 ifs_t3_th_l_mask;
+	u32 ifs_t4_addr;
+	u32 ifs_t4_th_h_mask;
+	u32 ifs_t4_en_mask;
+	u32 ifs_t4_th_l_mask;
+	u32 ifs_clm_tx_cnt_addr;
+	u32 ifs_clm_edcca_excl_cca_fa_mask;
+	u32 ifs_clm_tx_cnt_msk;
+	u32 ifs_clm_cca_addr;
+	u32 ifs_clm_ofdmcca_excl_fa_mask;
+	u32 ifs_clm_cckcca_excl_fa_mask;
+	u32 ifs_clm_fa_addr;
+	u32 ifs_clm_ofdm_fa_mask;
+	u32 ifs_clm_cck_fa_mask;
+	u32 ifs_his_addr;
+	u32 ifs_t4_his_mask;
+	u32 ifs_t3_his_mask;
+	u32 ifs_t2_his_mask;
+	u32 ifs_t1_his_mask;
+	u32 ifs_avg_l_addr;
+	u32 ifs_t2_avg_mask;
+	u32 ifs_t1_avg_mask;
+	u32 ifs_avg_h_addr;
+	u32 ifs_t4_avg_mask;
+	u32 ifs_t3_avg_mask;
+	u32 ifs_cca_l_addr;
+	u32 ifs_t2_cca_mask;
+	u32 ifs_t1_cca_mask;
+	u32 ifs_cca_h_addr;
+	u32 ifs_t4_cca_mask;
+	u32 ifs_t3_cca_mask;
+	u32 ifs_total_addr;
+	u32 ifs_cnt_done_mask;
+	u32 ifs_total_mask;
+};
+
+struct rtw89_physts_regs {
+	u32 setting_addr;
+	u32 dis_trigger_fail_mask;
+	u32 dis_trigger_brk_mask;
+};
+
 struct rtw89_phy_gen_def {
 	u32 cr_base;
+	const struct rtw89_ccx_regs *ccx;
+	const struct rtw89_physts_regs *physts;
 };
 
 extern const struct rtw89_phy_gen_def rtw89_phy_gen_ax;
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 143f900d29a6..778e4b0c8e87 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -3,8 +3,75 @@
  */
 
 #include "phy.h"
+#include "reg.h"
+
+static const struct rtw89_ccx_regs rtw89_ccx_regs_be = {
+	.setting_addr = R_CCX,
+	.edcca_opt_mask = B_CCX_EDCCA_OPT_MSK_V1,
+	.measurement_trig_mask = B_MEASUREMENT_TRIG_MSK,
+	.trig_opt_mask = B_CCX_TRIG_OPT_MSK,
+	.en_mask = B_CCX_EN_MSK,
+	.ifs_cnt_addr = R_IFS_COUNTER,
+	.ifs_clm_period_mask = B_IFS_CLM_PERIOD_MSK,
+	.ifs_clm_cnt_unit_mask = B_IFS_CLM_COUNTER_UNIT_MSK,
+	.ifs_clm_cnt_clear_mask = B_IFS_COUNTER_CLR_MSK,
+	.ifs_collect_en_mask = B_IFS_COLLECT_EN,
+	.ifs_t1_addr = R_IFS_T1,
+	.ifs_t1_th_h_mask = B_IFS_T1_TH_HIGH_MSK,
+	.ifs_t1_en_mask = B_IFS_T1_EN_MSK,
+	.ifs_t1_th_l_mask = B_IFS_T1_TH_LOW_MSK,
+	.ifs_t2_addr = R_IFS_T2,
+	.ifs_t2_th_h_mask = B_IFS_T2_TH_HIGH_MSK,
+	.ifs_t2_en_mask = B_IFS_T2_EN_MSK,
+	.ifs_t2_th_l_mask = B_IFS_T2_TH_LOW_MSK,
+	.ifs_t3_addr = R_IFS_T3,
+	.ifs_t3_th_h_mask = B_IFS_T3_TH_HIGH_MSK,
+	.ifs_t3_en_mask = B_IFS_T3_EN_MSK,
+	.ifs_t3_th_l_mask = B_IFS_T3_TH_LOW_MSK,
+	.ifs_t4_addr = R_IFS_T4,
+	.ifs_t4_th_h_mask = B_IFS_T4_TH_HIGH_MSK,
+	.ifs_t4_en_mask = B_IFS_T4_EN_MSK,
+	.ifs_t4_th_l_mask = B_IFS_T4_TH_LOW_MSK,
+	.ifs_clm_tx_cnt_addr = R_IFS_CLM_TX_CNT_V1,
+	.ifs_clm_edcca_excl_cca_fa_mask = B_IFS_CLM_EDCCA_EXCLUDE_CCA_FA_MSK,
+	.ifs_clm_tx_cnt_msk = B_IFS_CLM_TX_CNT_MSK,
+	.ifs_clm_cca_addr = R_IFS_CLM_CCA_V1,
+	.ifs_clm_ofdmcca_excl_fa_mask = B_IFS_CLM_OFDMCCA_EXCLUDE_FA_MSK,
+	.ifs_clm_cckcca_excl_fa_mask = B_IFS_CLM_CCKCCA_EXCLUDE_FA_MSK,
+	.ifs_clm_fa_addr = R_IFS_CLM_FA_V1,
+	.ifs_clm_ofdm_fa_mask = B_IFS_CLM_OFDM_FA_MSK,
+	.ifs_clm_cck_fa_mask = B_IFS_CLM_CCK_FA_MSK,
+	.ifs_his_addr = R_IFS_HIS_V1,
+	.ifs_t4_his_mask = B_IFS_T4_HIS_MSK,
+	.ifs_t3_his_mask = B_IFS_T3_HIS_MSK,
+	.ifs_t2_his_mask = B_IFS_T2_HIS_MSK,
+	.ifs_t1_his_mask = B_IFS_T1_HIS_MSK,
+	.ifs_avg_l_addr = R_IFS_AVG_L_V1,
+	.ifs_t2_avg_mask = B_IFS_T2_AVG_MSK,
+	.ifs_t1_avg_mask = B_IFS_T1_AVG_MSK,
+	.ifs_avg_h_addr = R_IFS_AVG_H_V1,
+	.ifs_t4_avg_mask = B_IFS_T4_AVG_MSK,
+	.ifs_t3_avg_mask = B_IFS_T3_AVG_MSK,
+	.ifs_cca_l_addr = R_IFS_CCA_L_V1,
+	.ifs_t2_cca_mask = B_IFS_T2_CCA_MSK,
+	.ifs_t1_cca_mask = B_IFS_T1_CCA_MSK,
+	.ifs_cca_h_addr = R_IFS_CCA_H_V1,
+	.ifs_t4_cca_mask = B_IFS_T4_CCA_MSK,
+	.ifs_t3_cca_mask = B_IFS_T3_CCA_MSK,
+	.ifs_total_addr = R_IFSCNT_V1,
+	.ifs_cnt_done_mask = B_IFSCNT_DONE_MSK,
+	.ifs_total_mask = B_IFSCNT_TOTAL_CNT_MSK,
+};
+
+static const struct rtw89_physts_regs rtw89_physts_regs_be = {
+	.setting_addr = R_PLCP_HISTOGRAM,
+	.dis_trigger_fail_mask = B_STS_DIS_TRIG_BY_FAIL,
+	.dis_trigger_brk_mask = B_STS_DIS_TRIG_BY_BRK,
+};
 
 const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 	.cr_base = 0x20000,
+	.ccx = &rtw89_ccx_regs_be,
+	.physts = &rtw89_physts_regs_be,
 };
 EXPORT_SYMBOL(rtw89_phy_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index eab26039242a..c0aac4d3678a 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3998,6 +3998,7 @@
 #define B_DBCC_80P80_SEL_EVM_RPT_EN BIT(0)
 #define R_CCX 0x0C00
 #define B_CCX_EDCCA_OPT_MSK GENMASK(6, 4)
+#define B_CCX_EDCCA_OPT_MSK_V1 GENMASK(7, 4)
 #define B_MEASUREMENT_TRIG_MSK BIT(2)
 #define B_CCX_TRIG_OPT_MSK BIT(1)
 #define B_CCX_EN_MSK BIT(0)
@@ -4089,32 +4090,41 @@
 #define B_SWSI_R_DATA_DONE_V1 BIT(26)
 #define R_TX_COUNTER 0x1A40
 #define R_IFS_CLM_TX_CNT 0x1ACC
+#define R_IFS_CLM_TX_CNT_V1 0x0ECC
 #define B_IFS_CLM_EDCCA_EXCLUDE_CCA_FA_MSK GENMASK(31, 16)
 #define B_IFS_CLM_TX_CNT_MSK GENMASK(15, 0)
 #define R_IFS_CLM_CCA 0x1AD0
+#define R_IFS_CLM_CCA_V1 0x0ED0
 #define B_IFS_CLM_OFDMCCA_EXCLUDE_FA_MSK GENMASK(31, 16)
 #define B_IFS_CLM_CCKCCA_EXCLUDE_FA_MSK GENMASK(15, 0)
 #define R_IFS_CLM_FA 0x1AD4
+#define R_IFS_CLM_FA_V1 0x0ED4
 #define B_IFS_CLM_OFDM_FA_MSK GENMASK(31, 16)
 #define B_IFS_CLM_CCK_FA_MSK GENMASK(15, 0)
 #define R_IFS_HIS 0x1AD8
+#define R_IFS_HIS_V1 0x0ED8
 #define B_IFS_T4_HIS_MSK GENMASK(31, 24)
 #define B_IFS_T3_HIS_MSK GENMASK(23, 16)
 #define B_IFS_T2_HIS_MSK GENMASK(15, 8)
 #define B_IFS_T1_HIS_MSK GENMASK(7, 0)
 #define R_IFS_AVG_L 0x1ADC
+#define R_IFS_AVG_L_V1 0x0EDC
 #define B_IFS_T2_AVG_MSK GENMASK(31, 16)
 #define B_IFS_T1_AVG_MSK GENMASK(15, 0)
 #define R_IFS_AVG_H 0x1AE0
+#define R_IFS_AVG_H_V1 0x0EE0
 #define B_IFS_T4_AVG_MSK GENMASK(31, 16)
 #define B_IFS_T3_AVG_MSK GENMASK(15, 0)
 #define R_IFS_CCA_L 0x1AE4
+#define R_IFS_CCA_L_V1 0x0EE4
 #define B_IFS_T2_CCA_MSK GENMASK(31, 16)
 #define B_IFS_T1_CCA_MSK GENMASK(15, 0)
 #define R_IFS_CCA_H 0x1AE8
+#define R_IFS_CCA_H_V1 0x0EE8
 #define B_IFS_T4_CCA_MSK GENMASK(31, 16)
 #define B_IFS_T3_CCA_MSK GENMASK(15, 0)
 #define R_IFSCNT 0x1AEC
+#define R_IFSCNT_V1 0x0EEC
 #define B_IFSCNT_DONE_MSK BIT(16)
 #define B_IFSCNT_TOTAL_CNT_MSK GENMASK(15, 0)
 #define R_TXAGC_TP 0x1C04
@@ -4385,6 +4395,7 @@
 #define B_PKT_POP_EN BIT(8)
 #define R_SEG0R_PD 0x481C
 #define R_SEG0R_PD_V1 0x4860
+#define R_SEG0R_PD_V2 0x6A74
 #define R_SEG0R_EDCCA_LVL 0x4840
 #define R_SEG0R_EDCCA_LVL_V1 0x4884
 #define B_SEG0R_PPDU_LVL_MSK GENMASK(31, 24)
@@ -4503,8 +4514,10 @@
 #define R_DCFO_COMP_S0_V1 0x4A40
 #define B_DCFO_COMP_S0_V1_MSK GENMASK(13, 0)
 #define R_BMODE_PDTH_V1 0x4B64
+#define R_BMODE_PDTH_V2 0x6708
 #define B_BMODE_PDTH_LOWER_BOUND_MSK_V1 GENMASK(31, 24)
 #define R_BMODE_PDTH_EN_V1 0x4B74
+#define R_BMODE_PDTH_EN_V2 0x6718
 #define B_BMODE_PDTH_LIMIT_EN_MSK_V1 BIT(30)
 #define R_CFO_COMP_SEG1_L 0x5384
 #define R_CFO_COMP_SEG1_H 0x5388
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 52eb7030fd0b..103893f28b51 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -185,6 +185,10 @@ static const struct rtw89_dig_regs rtw8851b_dig_regs = {
 	.seg0_pd_reg = R_SEG0R_PD_V1,
 	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
 	.pd_spatial_reuse_en = B_SEG0R_PD_SPATIAL_REUSE_EN_MSK_V1,
+	.bmode_pd_reg = R_BMODE_PDTH_EN_V1,
+	.bmode_cca_rssi_limit_en = B_BMODE_PDTH_LIMIT_EN_MSK_V1,
+	.bmode_pd_lower_bound_reg = R_BMODE_PDTH_V1,
+	.bmode_rssi_nocca_low_th_mask = B_BMODE_PDTH_LOWER_BOUND_MSK_V1,
 	.p0_lna_init = {R_PATH0_LNA_INIT_V1, B_PATH0_LNA_INIT_IDX_MSK},
 	.p1_lna_init = {R_PATH1_LNA_INIT_V1, B_PATH1_LNA_INIT_IDX_MSK},
 	.p0_tia_init = {R_PATH0_TIA_INIT_V1, B_PATH0_TIA_INIT_IDX_MSK_V1},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index eb6aad3bbb85..d068eae6a2f0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -478,6 +478,10 @@ static const struct rtw89_dig_regs rtw8852a_dig_regs = {
 	.seg0_pd_reg = R_SEG0R_PD,
 	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
 	.pd_spatial_reuse_en = B_SEG0R_PD_SPATIAL_REUSE_EN_MSK,
+	.bmode_pd_reg = R_BMODE_PDTH_EN_V1,
+	.bmode_cca_rssi_limit_en = B_BMODE_PDTH_LIMIT_EN_MSK_V1,
+	.bmode_pd_lower_bound_reg = R_BMODE_PDTH_V1,
+	.bmode_rssi_nocca_low_th_mask = B_BMODE_PDTH_LOWER_BOUND_MSK_V1,
 	.p0_lna_init = {R_PATH0_LNA_INIT, B_PATH0_LNA_INIT_IDX_MSK},
 	.p1_lna_init = {R_PATH1_LNA_INIT, B_PATH1_LNA_INIT_IDX_MSK},
 	.p0_tia_init = {R_PATH0_TIA_INIT, B_PATH0_TIA_INIT_IDX_MSK},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 49664cc44f36..0063301952b3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -310,6 +310,10 @@ static const struct rtw89_dig_regs rtw8852b_dig_regs = {
 	.seg0_pd_reg = R_SEG0R_PD_V1,
 	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
 	.pd_spatial_reuse_en = B_SEG0R_PD_SPATIAL_REUSE_EN_MSK_V1,
+	.bmode_pd_reg = R_BMODE_PDTH_EN_V1,
+	.bmode_cca_rssi_limit_en = B_BMODE_PDTH_LIMIT_EN_MSK_V1,
+	.bmode_pd_lower_bound_reg = R_BMODE_PDTH_V1,
+	.bmode_rssi_nocca_low_th_mask = B_BMODE_PDTH_LOWER_BOUND_MSK_V1,
 	.p0_lna_init = {R_PATH0_LNA_INIT_V1, B_PATH0_LNA_INIT_IDX_MSK},
 	.p1_lna_init = {R_PATH1_LNA_INIT_V1, B_PATH1_LNA_INIT_IDX_MSK},
 	.p0_tia_init = {R_PATH0_TIA_INIT_V1, B_PATH0_TIA_INIT_IDX_MSK_V1},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index abd01e808d83..1e16cc0a05dc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -146,6 +146,10 @@ static const struct rtw89_dig_regs rtw8852c_dig_regs = {
 	.seg0_pd_reg = R_SEG0R_PD,
 	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
 	.pd_spatial_reuse_en = B_SEG0R_PD_SPATIAL_REUSE_EN_MSK,
+	.bmode_pd_reg = R_BMODE_PDTH_EN_V1,
+	.bmode_cca_rssi_limit_en = B_BMODE_PDTH_LIMIT_EN_MSK_V1,
+	.bmode_pd_lower_bound_reg = R_BMODE_PDTH_V1,
+	.bmode_rssi_nocca_low_th_mask = B_BMODE_PDTH_LOWER_BOUND_MSK_V1,
 	.p0_lna_init = {R_PATH0_LNA_INIT_V1, B_PATH0_LNA_INIT_IDX_MSK},
 	.p1_lna_init = {R_PATH1_LNA_INIT_V1, B_PATH1_LNA_INIT_IDX_MSK},
 	.p0_tia_init = {R_PATH0_TIA_INIT_V1, B_PATH0_TIA_INIT_IDX_MSK_V1},
-- 
2.25.1

