Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E919724553
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 16:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbjFFOJH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 10:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjFFOI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 10:08:56 -0400
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19545E73
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 07:08:55 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:552a:0:640:dccd:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id 96D2260068;
        Tue,  6 Jun 2023 17:08:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id c8UeC5oWna60-9CBrtfZk;
        Tue, 06 Jun 2023 17:08:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686060533;
        bh=8FP3CMUMRvCi3HAPVPQfUzTrdcITsQWnPdkGDhSbOdg=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=JgNsBd9Eq2eZHwBS5ROYXk6RdPKcSLYYYijbqKwpYLMOo0TuXlHJQeKCnsW1sbJeW
         L/dXY0wiyoPcy8HCy2ThaAeY5fY0q3vbr7mDIIfS9+N9Bj6AY0Ym/S1wTF2ytpS3YC
         tDhUQ7NtaKpLu/WB4LoLpDO3jEfQWfS4SYgl402I=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: rtw89: cleanup private data structures
Date:   Tue,  6 Jun 2023 17:08:05 +0300
Message-Id: <20230606140806.606352-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606083354.375287-1-dmantipov@yandex.ru>
References: <20230606083354.375287-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove a bunch of unused (and set but unused) fields
from 'struct rtw89_btc_wl_nhm', 'struct rtw89_dle_info',
'struct rtw89_hal' and 'struct rtw89_env_monitor_info'
driver-specific data structures, adjust related bits.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtw89/core.h | 39 -----------------------
 drivers/net/wireless/realtek/rtw89/mac.c  |  6 +---
 drivers/net/wireless/realtek/rtw89/phy.c  |  4 ---
 3 files changed, 1 insertion(+), 48 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6df386a38fb4..bea2e7210b70 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1382,7 +1382,6 @@ struct rtw89_btc_wl_nhm {
 	u8 current_status;
 	u8 refresh;
 	bool start_flag;
-	u8 last_ccx_rpt_stamp;
 	s8 pwr_max;
 	s8 pwr_min;
 };
@@ -3237,7 +3236,6 @@ enum rtw89_hcifc_mode {
 
 struct rtw89_dle_info {
 	enum rtw89_qta_mode qta_mode;
-	u16 wde_pg_size;
 	u16 ple_pg_size;
 	u16 c0_rx_qta;
 	u16 c1_rx_qta;
@@ -3417,7 +3415,6 @@ struct rtw89_hal {
 	u32 rx_fltr;
 	u8 cv;
 	u8 acv;
-	u32 sw_amsdu_max_size;
 	u32 antenna_tx;
 	u32 antenna_rx;
 	u8 tx_nss;
@@ -3815,35 +3812,16 @@ enum rtw89_ccx_edcca_opt_bw_idx {
 #define RTW89_FAHM_RPT_NUM 12
 #define RTW89_IFS_CLM_NUM 4
 struct rtw89_env_monitor_info {
-	u32 ccx_trigger_time;
-	u64 start_time;
-	u8 ccx_rpt_stamp;
 	u8 ccx_watchdog_result;
 	bool ccx_ongoing;
 	u8 ccx_rac_lv;
 	bool ccx_manual_ctrl;
-	u8 ccx_pre_rssi;
-	u16 clm_mntr_time;
-	u16 nhm_mntr_time;
 	u16 ifs_clm_mntr_time;
 	enum rtw89_ifs_clm_application ifs_clm_app;
-	u16 fahm_mntr_time;
-	u16 edcca_clm_mntr_time;
 	u16 ccx_period;
 	u8 ccx_unit_idx;
-	enum rtw89_ccx_edcca_opt_bw_idx ccx_edcca_opt_bw_idx;
-	u8 nhm_th[RTW89_NHM_TH_NUM];
 	u16 ifs_clm_th_l[RTW89_IFS_CLM_NUM];
 	u16 ifs_clm_th_h[RTW89_IFS_CLM_NUM];
-	u8 fahm_numer_opt;
-	u8 fahm_denom_opt;
-	u8 fahm_th[RTW89_FAHM_TH_NUM];
-	u16 clm_result;
-	u16 nhm_result[RTW89_NHM_RPT_NUM];
-	u8 nhm_wgt[RTW89_NHM_RPT_NUM];
-	u16 nhm_tx_cnt;
-	u16 nhm_cca_cnt;
-	u16 nhm_idle_cnt;
 	u16 ifs_clm_tx;
 	u16 ifs_clm_edcca_excl_cca;
 	u16 ifs_clm_ofdmfa;
@@ -3854,17 +3832,6 @@ struct rtw89_env_monitor_info {
 	u8 ifs_clm_his[RTW89_IFS_CLM_NUM];
 	u16 ifs_clm_avg[RTW89_IFS_CLM_NUM];
 	u16 ifs_clm_cca[RTW89_IFS_CLM_NUM];
-	u16 fahm_result[RTW89_FAHM_RPT_NUM];
-	u16 fahm_denom_result;
-	u16 edcca_clm_result;
-	u8 clm_ratio;
-	u8 nhm_rpt[RTW89_NHM_RPT_NUM];
-	u8 nhm_tx_ratio;
-	u8 nhm_cca_ratio;
-	u8 nhm_idle_ratio;
-	u8 nhm_ratio;
-	u16 nhm_result_sum;
-	u8 nhm_pwr;
 	u8 ifs_clm_tx_ratio;
 	u8 ifs_clm_edcca_excl_cca_ratio;
 	u8 ifs_clm_cck_fa_ratio;
@@ -3875,12 +3842,6 @@ struct rtw89_env_monitor_info {
 	u16 ifs_clm_ofdm_fa_permil;
 	u32 ifs_clm_ifs_avg[RTW89_IFS_CLM_NUM];
 	u32 ifs_clm_cca_avg[RTW89_IFS_CLM_NUM];
-	u8 fahm_rpt[RTW89_FAHM_RPT_NUM];
-	u16 fahm_result_sum;
-	u8 fahm_ratio;
-	u8 fahm_denom_ratio;
-	u8 fahm_pwr;
-	u8 edcca_clm_ratio;
 };
 
 enum rtw89_ser_rcvy_step {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 512de491a064..8c9471ece05a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -716,11 +716,8 @@ static int hfc_reset_param(struct rtw89_dev *rtwdev)
 	if (param_ini.pub_cfg)
 		param->pub_cfg = *param_ini.pub_cfg;
 
-	if (param_ini.prec_cfg) {
+	if (param_ini.prec_cfg)
 		param->prec_cfg = *param_ini.prec_cfg;
-		rtwdev->hal.sw_amsdu_max_size =
-				param->prec_cfg.wp_ch07_prec * HFC_PAGE_UNIT;
-	}
 
 	if (param_ini.ch_cfg)
 		param->ch_cfg = param_ini.ch_cfg;
@@ -1497,7 +1494,6 @@ static const struct rtw89_dle_mem *get_dle_mem_cfg(struct rtw89_dev *rtwdev,
 		return NULL;
 	}
 
-	mac->dle_info.wde_pg_size = cfg->wde_size->pge_size;
 	mac->dle_info.ple_pg_size = cfg->ple_size->pge_size;
 	mac->dle_info.qta_mode = mode;
 	mac->dle_info.c0_rx_qta = cfg->ple_min_qt->cma0_dma;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c7e906123416..9ebc6e2a467f 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3053,11 +3053,8 @@ static void rtw89_phy_ccx_top_setting_init(struct rtw89_dev *rtwdev)
 	env->ccx_manual_ctrl = false;
 	env->ccx_ongoing = false;
 	env->ccx_rac_lv = RTW89_RAC_RELEASE;
-	env->ccx_rpt_stamp = 0;
 	env->ccx_period = 0;
 	env->ccx_unit_idx = RTW89_CCX_32_US;
-	env->ccx_trigger_time = 0;
-	env->ccx_edcca_opt_bw_idx = RTW89_CCX_EDCCA_BW20_0;
 
 	rtw89_phy_set_phy_regs(rtwdev, R_CCX, B_CCX_EN_MSK, 1);
 	rtw89_phy_set_phy_regs(rtwdev, R_CCX, B_CCX_TRIG_OPT_MSK, 1);
@@ -3265,7 +3262,6 @@ static void rtw89_phy_ccx_trigger(struct rtw89_dev *rtwdev)
 	rtw89_phy_set_phy_regs(rtwdev, R_IFS_COUNTER, B_IFS_COUNTER_CLR_MSK, 1);
 	rtw89_phy_set_phy_regs(rtwdev, R_CCX, B_MEASUREMENT_TRIG_MSK, 1);
 
-	env->ccx_rpt_stamp++;
 	env->ccx_ongoing = true;
 }
 
-- 
2.40.1

