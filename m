Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3066E3D68
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 04:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDQCTl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 22:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjDQCTh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 22:19:37 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181383AA1
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 19:19:07 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33H2IbV32031166, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33H2IbV32031166
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 17 Apr 2023 10:18:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 17 Apr 2023 10:19:00 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 17 Apr
 2023 10:19:00 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/7] wifi: rtw89: add RSSI based antenna diversity
Date:   Mon, 17 Apr 2023 10:17:06 +0800
Message-ID: <20230417021707.16369-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417021707.16369-1-pkshih@realtek.com>
References: <20230417021707.16369-1-pkshih@realtek.com>
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

From: Eric Huang <echuang@realtek.com>

RSSI statistics are grouped by CCK, OFDM or non-legacy rate. These
statistics will be collected in training state for both (main/aux)
antenna. There is a time period (ANTDIV_DELAY) for rate adaptive
settle down before start collect statistics when switch antenna.

Antenna diversity checks packet count from training state for each
group and use the most one as the final RSSI for comparison, and
then choose the better one as target antenna.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |   5 +
 drivers/net/wireless/realtek/rtw89/core.h |  20 +++
 drivers/net/wireless/realtek/rtw89/phy.c  | 177 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h  |  12 ++
 4 files changed, 214 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d2bd3dfa31078..7911685a22ffc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1360,6 +1360,8 @@ static int rtw89_core_rx_parse_phy_sts(struct rtw89_dev *rtwdev,
 		}
 	}
 
+	rtw89_phy_antdiv_parse(rtwdev, phy_ppdu);
+
 	return 0;
 }
 
@@ -2592,6 +2594,7 @@ static void rtw89_track_work(struct work_struct *work)
 	rtw89_phy_ra_update(rtwdev);
 	rtw89_phy_cfo_track(rtwdev);
 	rtw89_phy_tx_path_div_track(rtwdev);
+	rtw89_phy_antdiv_track(rtwdev);
 	rtw89_phy_ul_tb_ctrl_track(rtwdev);
 
 	if (rtwdev->lps_enabled && !rtwdev->btc.lps)
@@ -3446,6 +3449,7 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 	cancel_delayed_work_sync(&rtwdev->coex_rfk_chk_work);
 	cancel_delayed_work_sync(&rtwdev->cfo_track_work);
 	cancel_delayed_work_sync(&rtwdev->forbid_ba_work);
+	cancel_delayed_work_sync(&rtwdev->antdiv_work);
 
 	mutex_lock(&rtwdev->mutex);
 
@@ -3481,6 +3485,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	INIT_DELAYED_WORK(&rtwdev->coex_rfk_chk_work, rtw89_coex_rfk_chk_work);
 	INIT_DELAYED_WORK(&rtwdev->cfo_track_work, rtw89_phy_cfo_track_work);
 	INIT_DELAYED_WORK(&rtwdev->forbid_ba_work, rtw89_forbid_ba_work);
+	INIT_DELAYED_WORK(&rtwdev->antdiv_work, rtw89_phy_antdiv_work);
 	rtwdev->txq_wq = alloc_workqueue("rtw89_tx_wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
 	if (!rtwdev->txq_wq)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 217355d2ee50f..cc84b5512e28e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3124,6 +3124,24 @@ struct rtw89_phy_ul_tb_info {
 	u8 def_if_bandedge;
 };
 
+struct rtw89_antdiv_stats {
+	struct ewma_rssi cck_rssi_avg;
+	struct ewma_rssi ofdm_rssi_avg;
+	struct ewma_rssi non_legacy_rssi_avg;
+	u16 pkt_cnt_cck;
+	u16 pkt_cnt_ofdm;
+	u16 pkt_cnt_non_legacy;
+};
+
+struct rtw89_antdiv_info {
+	struct rtw89_antdiv_stats target_stats;
+	struct rtw89_antdiv_stats main_stats;
+	struct rtw89_antdiv_stats aux_stats;
+	u8 training_count;
+	u8 rssi_pre;
+	bool get_stats;
+};
+
 struct rtw89_chip_info {
 	enum rtw89_core_chip_id chip_id;
 	const struct rtw89_chip_ops *ops;
@@ -4099,6 +4117,7 @@ struct rtw89_dev {
 	struct rtw89_phy_bb_gain_info bb_gain;
 	struct rtw89_phy_efuse_gain efuse_gain;
 	struct rtw89_phy_ul_tb_info ul_tb_info;
+	struct rtw89_antdiv_info antdiv;
 
 	struct delayed_work track_work;
 	struct delayed_work coex_act1_work;
@@ -4107,6 +4126,7 @@ struct rtw89_dev {
 	struct delayed_work cfo_track_work;
 	struct delayed_work forbid_ba_work;
 	struct delayed_work roc_work;
+	struct delayed_work antdiv_work;
 	struct rtw89_ppdu_sts_info ppdu_sts;
 	u8 total_sta_assoc;
 	bool scanning;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 3f9755c58e6c3..b9a3ebc2e7901 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -10,6 +10,7 @@
 #include "ps.h"
 #include "reg.h"
 #include "sar.h"
+#include "txrx.h"
 #include "util.h"
 
 static u16 get_max_amsdu_len(struct rtw89_dev *rtwdev,
@@ -2946,6 +2947,67 @@ static void rtw89_phy_ul_tb_info_init(struct rtw89_dev *rtwdev)
 		rtw89_phy_read32_mask(rtwdev, R_BANDEDGE, B_BANDEDGE_EN);
 }
 
+static
+void rtw89_phy_antdiv_sts_instance_reset(struct rtw89_antdiv_stats *antdiv_sts)
+{
+	ewma_rssi_init(&antdiv_sts->cck_rssi_avg);
+	ewma_rssi_init(&antdiv_sts->ofdm_rssi_avg);
+	ewma_rssi_init(&antdiv_sts->non_legacy_rssi_avg);
+	antdiv_sts->pkt_cnt_cck = 0;
+	antdiv_sts->pkt_cnt_ofdm = 0;
+	antdiv_sts->pkt_cnt_non_legacy = 0;
+}
+
+static void rtw89_phy_antdiv_sts_instance_add(struct rtw89_dev *rtwdev,
+					      struct rtw89_rx_phy_ppdu *phy_ppdu,
+					      struct rtw89_antdiv_stats *stats)
+{
+	if (GET_DATA_RATE_MODE(phy_ppdu->rate) == DATA_RATE_MODE_NON_HT) {
+		if (phy_ppdu->rate < RTW89_HW_RATE_OFDM6) {
+			ewma_rssi_add(&stats->cck_rssi_avg, phy_ppdu->rssi_avg);
+			stats->pkt_cnt_cck++;
+		} else {
+			ewma_rssi_add(&stats->ofdm_rssi_avg, phy_ppdu->rssi_avg);
+			stats->pkt_cnt_ofdm++;
+		}
+	} else {
+		ewma_rssi_add(&stats->non_legacy_rssi_avg, phy_ppdu->rssi_avg);
+		stats->pkt_cnt_non_legacy++;
+	}
+}
+
+static u8 rtw89_phy_antdiv_sts_instance_get_rssi(struct rtw89_antdiv_stats *stats)
+{
+	if (stats->pkt_cnt_non_legacy >= stats->pkt_cnt_cck &&
+	    stats->pkt_cnt_non_legacy >= stats->pkt_cnt_ofdm)
+		return ewma_rssi_read(&stats->non_legacy_rssi_avg);
+	else if (stats->pkt_cnt_ofdm >= stats->pkt_cnt_cck &&
+		 stats->pkt_cnt_ofdm >= stats->pkt_cnt_non_legacy)
+		return ewma_rssi_read(&stats->ofdm_rssi_avg);
+	else
+		return ewma_rssi_read(&stats->cck_rssi_avg);
+}
+
+void rtw89_phy_antdiv_parse(struct rtw89_dev *rtwdev,
+			    struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	struct rtw89_antdiv_info *antdiv = &rtwdev->antdiv;
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	if (!hal->ant_diversity || hal->ant_diversity_fixed)
+		return;
+
+	rtw89_phy_antdiv_sts_instance_add(rtwdev, phy_ppdu, &antdiv->target_stats);
+
+	if (!antdiv->get_stats)
+		return;
+
+	if (hal->antenna_rx == RF_A)
+		rtw89_phy_antdiv_sts_instance_add(rtwdev, phy_ppdu, &antdiv->main_stats);
+	else if (hal->antenna_rx == RF_B)
+		rtw89_phy_antdiv_sts_instance_add(rtwdev, phy_ppdu, &antdiv->aux_stats);
+}
+
 static void rtw89_phy_antdiv_reg_init(struct rtw89_dev *rtwdev)
 {
 	rtw89_phy_write32_idx(rtwdev, R_P0_TRSW, B_P0_ANT_TRAIN_EN,
@@ -2974,13 +3036,26 @@ static void rtw89_phy_antdiv_reg_init(struct rtw89_dev *rtwdev)
 			      0x0, RTW89_PHY_0);
 }
 
+static void rtw89_phy_antdiv_sts_reset(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_antdiv_info *antdiv = &rtwdev->antdiv;
+
+	rtw89_phy_antdiv_sts_instance_reset(&antdiv->target_stats);
+	rtw89_phy_antdiv_sts_instance_reset(&antdiv->main_stats);
+	rtw89_phy_antdiv_sts_instance_reset(&antdiv->aux_stats);
+}
+
 static void rtw89_phy_antdiv_init(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_antdiv_info *antdiv = &rtwdev->antdiv;
 	struct rtw89_hal *hal = &rtwdev->hal;
 
 	if (!hal->ant_diversity)
 		return;
 
+	antdiv->get_stats = false;
+	antdiv->rssi_pre = 0;
+	rtw89_phy_antdiv_sts_reset(rtwdev);
 	rtw89_phy_antdiv_reg_init(rtwdev);
 }
 
@@ -4181,6 +4256,108 @@ static void rtw89_phy_antdiv_set_ant(struct rtw89_dev *rtwdev)
 			      default_ant, RTW89_PHY_0);
 }
 
+static void rtw89_phy_swap_hal_antenna(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	hal->antenna_rx = hal->antenna_rx == RF_A ? RF_B : RF_A;
+	hal->antenna_tx = hal->antenna_rx;
+}
+
+static void rtw89_phy_antdiv_decision_state(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_antdiv_info *antdiv = &rtwdev->antdiv;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	bool no_change = false;
+	u8 main_rssi, aux_rssi;
+	u32 candidate;
+
+	antdiv->get_stats = false;
+	antdiv->training_count = 0;
+
+	main_rssi = rtw89_phy_antdiv_sts_instance_get_rssi(&antdiv->main_stats);
+	aux_rssi = rtw89_phy_antdiv_sts_instance_get_rssi(&antdiv->aux_stats);
+
+	if (main_rssi > aux_rssi + RTW89_TX_DIV_RSSI_RAW_TH)
+		candidate = RF_A;
+	else if (aux_rssi > main_rssi + RTW89_TX_DIV_RSSI_RAW_TH)
+		candidate = RF_B;
+	else
+		no_change = true;
+
+	if (no_change) {
+		/* swap back from training antenna to original */
+		rtw89_phy_swap_hal_antenna(rtwdev);
+		return;
+	}
+
+	hal->antenna_tx = candidate;
+	hal->antenna_rx = candidate;
+}
+
+static void rtw89_phy_antdiv_training_state(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_antdiv_info *antdiv = &rtwdev->antdiv;
+	u64 state_period;
+
+	if (antdiv->training_count % 2 == 0) {
+		if (antdiv->training_count == 0)
+			rtw89_phy_antdiv_sts_reset(rtwdev);
+
+		antdiv->get_stats = true;
+		state_period = msecs_to_jiffies(ANTDIV_TRAINNING_INTVL);
+	} else {
+		antdiv->get_stats = false;
+		state_period = msecs_to_jiffies(ANTDIV_DELAY);
+
+		rtw89_phy_swap_hal_antenna(rtwdev);
+		rtw89_phy_antdiv_set_ant(rtwdev);
+	}
+
+	antdiv->training_count++;
+	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->antdiv_work,
+				     state_period);
+}
+
+void rtw89_phy_antdiv_work(struct work_struct *work)
+{
+	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
+						antdiv_work.work);
+	struct rtw89_antdiv_info *antdiv = &rtwdev->antdiv;
+
+	mutex_lock(&rtwdev->mutex);
+
+	if (antdiv->training_count <= ANTDIV_TRAINNING_CNT) {
+		rtw89_phy_antdiv_training_state(rtwdev);
+	} else {
+		rtw89_phy_antdiv_decision_state(rtwdev);
+		rtw89_phy_antdiv_set_ant(rtwdev);
+	}
+
+	mutex_unlock(&rtwdev->mutex);
+}
+
+void rtw89_phy_antdiv_track(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_antdiv_info *antdiv = &rtwdev->antdiv;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 rssi, rssi_pre;
+
+	if (!hal->ant_diversity || hal->ant_diversity_fixed)
+		return;
+
+	rssi = rtw89_phy_antdiv_sts_instance_get_rssi(&antdiv->target_stats);
+	rssi_pre = antdiv->rssi_pre;
+	antdiv->rssi_pre = rssi;
+	rtw89_phy_antdiv_sts_instance_reset(&antdiv->target_stats);
+
+	if (abs((int)rssi - (int)rssi_pre) < ANTDIV_RSSI_DIFF_TH)
+		return;
+
+	antdiv->training_count = 0;
+	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->antdiv_work, 0);
+}
+
 static void rtw89_phy_env_monitor_init(struct rtw89_dev *rtwdev)
 {
 	rtw89_phy_ccx_top_setting_init(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 7535867d0f484..ab174a0ba4888 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -67,6 +67,14 @@
 #define UL_TB_TF_CNT_L2H_TH 100
 #define UL_TB_TF_CNT_H2L_TH 70
 
+#define ANTDIV_TRAINNING_CNT 2
+#define ANTDIV_TRAINNING_INTVL 30
+#define ANTDIV_DELAY 110
+#define ANTDIV_TP_DIFF_TH_HIGH 100
+#define ANTDIV_TP_DIFF_TH_LOW 5
+#define ANTDIV_EVM_DIFF_TH 8
+#define ANTDIV_RSSI_DIFF_TH 3
+
 #define CCX_MAX_PERIOD 2097
 #define CCX_MAX_PERIOD_UNIT 32
 #define MS_TO_4US_RATIO 250
@@ -549,6 +557,10 @@ void rtw89_phy_set_phy_regs(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 void rtw89_phy_dig_reset(struct rtw89_dev *rtwdev);
 void rtw89_phy_dig(struct rtw89_dev *rtwdev);
 void rtw89_phy_tx_path_div_track(struct rtw89_dev *rtwdev);
+void rtw89_phy_antdiv_parse(struct rtw89_dev *rtwdev,
+			    struct rtw89_rx_phy_ppdu *phy_ppdu);
+void rtw89_phy_antdiv_track(struct rtw89_dev *rtwdev);
+void rtw89_phy_antdiv_work(struct work_struct *work);
 void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
 void rtw89_phy_tssi_ctrl_set_bandedge_cfg(struct rtw89_dev *rtwdev,
 					  enum rtw89_mac_idx mac_idx,
-- 
2.25.1

