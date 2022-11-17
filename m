Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D12F62D37D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 07:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbiKQGbJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 01:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbiKQGbB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 01:31:01 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1199C6869C
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 22:30:59 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AH6UCccC014868, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AH6UCccC014868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 17 Nov 2022 14:30:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 17 Nov 2022 14:30:53 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 17 Nov
 2022 14:30:52 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: switch BANDEDGE and TX_SHAPE based on OFDMA trigger frame
Date:   Thu, 17 Nov 2022 14:30:01 +0800
Message-ID: <20221117063001.42967-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117063001.42967-1-pkshih@realtek.com>
References: <20221117063001.42967-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/17/2022 06:09:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzE3IKRXpMggMDM6MzM6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Eric Huang <echuang@realtek.com>

There are some registers for transmit waveform control, two of them used
in this change are for BANDEDGE and TX_SHAPE control. BANDEDGE controls
whether to apply band edge filter to transmit waveform. TX_SHAPE controls
whether to apply triangular mask to transmit waveform. It is found for
some chip, these two should be turned off during OFDMA UL traffic for
better performance.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |   2 +
 drivers/net/wireless/realtek/rtw89/core.h     |   9 ++
 drivers/net/wireless/realtek/rtw89/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw89/phy.c      | 127 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h      |   5 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 8 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c0a4667fd7e2d..a5fe45d79f189 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2237,6 +2237,7 @@ static void rtw89_track_work(struct work_struct *work)
 	rtw89_phy_ra_update(rtwdev);
 	rtw89_phy_cfo_track(rtwdev);
 	rtw89_phy_tx_path_div_track(rtwdev);
+	rtw89_phy_ul_tb_ctrl_track(rtwdev);
 
 	if (rtwdev->lps_enabled && !rtwdev->btc.lps)
 		rtw89_enter_lps_track(rtwdev);
@@ -2560,6 +2561,7 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
 					 BTC_ROLE_MSTS_STA_CONN_END);
 		rtw89_core_get_no_ul_ofdma_htc(rtwdev, &rtwsta->htc_template);
+		rtw89_phy_ul_tb_assoc(rtwdev, rtwvif);
 	}
 
 	return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ba4ccbde5ecf9..62d834dbff67b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2261,6 +2261,8 @@ struct rtw89_vif {
 	bool wowlan_magic;
 	bool is_hesta;
 	bool last_a_ctrl;
+	bool dyn_tb_bedge_en;
+	u8 def_tri_idx;
 	struct work_struct update_beacon_work;
 	struct rtw89_addr_cam_entry addr_cam;
 	struct rtw89_bssid_cam_entry bssid_cam;
@@ -2646,6 +2648,11 @@ struct rtw89_dig_regs {
 	struct rtw89_reg_def p1_s20_pagcugc_en;
 };
 
+struct rtw89_phy_ul_tb_info {
+	bool dyn_tb_tri_en;
+	u8 def_if_bandedge;
+};
+
 struct rtw89_chip_info {
 	enum rtw89_core_chip_id chip_id;
 	const struct rtw89_chip_ops *ops;
@@ -2663,6 +2670,7 @@ struct rtw89_chip_info {
 	u8 support_chanctx_num;
 	u8 support_bands;
 	bool support_bw160;
+	bool support_ul_tb_ctrl;
 	bool hw_sec_hdr;
 	u8 rf_path_num;
 	u8 tx_nss;
@@ -3585,6 +3593,7 @@ struct rtw89_dev {
 	struct rtw89_phy_ch_info ch_info;
 	struct rtw89_phy_bb_gain_info bb_gain;
 	struct rtw89_phy_efuse_gain efuse_gain;
+	struct rtw89_phy_ul_tb_info ul_tb_info;
 
 	struct delayed_work track_work;
 	struct delayed_work coex_act1_work;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.h b/drivers/net/wireless/realtek/rtw89/debug.h
index e7971583acbc9..d1de5e600836c 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.h
+++ b/drivers/net/wireless/realtek/rtw89/debug.h
@@ -27,6 +27,7 @@ enum rtw89_debug_mask {
 	RTW89_DBG_SAR = BIT(16),
 	RTW89_DBG_STATE = BIT(17),
 	RTW89_DBG_WOW = BIT(18),
+	RTW89_DBG_UL_TB = BIT(19),
 
 	RTW89_DBG_UNEXP = BIT(31),
 };
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index dd46856989830..baa48b1058c58 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2020  Realtek Corporation
  */
 
+#include "coex.h"
 #include "debug.h"
 #include "fw.h"
 #include "mac.h"
@@ -9,7 +10,7 @@
 #include "ps.h"
 #include "reg.h"
 #include "sar.h"
-#include "coex.h"
+#include "util.h"
 
 static u16 get_max_amsdu_len(struct rtw89_dev *rtwdev,
 			     const struct rtw89_ra_report *report)
@@ -2794,6 +2795,129 @@ void rtw89_phy_cfo_parse(struct rtw89_dev *rtwdev, s16 cfo_val,
 	cfo->packet_count++;
 }
 
+void rtw89_phy_ul_tb_assoc(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct rtw89_phy_ul_tb_info *ul_tb_info = &rtwdev->ul_tb_info;
+
+	if (!chip->support_ul_tb_ctrl)
+		return;
+
+	rtwvif->def_tri_idx =
+		rtw89_phy_read32_mask(rtwdev, R_DCFO_OPT, B_TXSHAPE_TRIANGULAR_CFG);
+
+	if (chip->chip_id == RTL8852B && rtwdev->hal.cv > CHIP_CBV)
+		rtwvif->dyn_tb_bedge_en = false;
+	else if (chan->band_type >= RTW89_BAND_5G &&
+		 chan->band_width >= RTW89_CHANNEL_WIDTH_40)
+		rtwvif->dyn_tb_bedge_en = true;
+	else
+		rtwvif->dyn_tb_bedge_en = false;
+
+	rtw89_debug(rtwdev, RTW89_DBG_UL_TB,
+		    "[ULTB] def_if_bandedge=%d, def_tri_idx=%d\n",
+		    ul_tb_info->def_if_bandedge, rtwvif->def_tri_idx);
+	rtw89_debug(rtwdev, RTW89_DBG_UL_TB,
+		    "[ULTB] dyn_tb_begde_en=%d, dyn_tb_tri_en=%d\n",
+		    rtwvif->dyn_tb_bedge_en, ul_tb_info->dyn_tb_tri_en);
+}
+
+struct rtw89_phy_ul_tb_check_data {
+	bool valid;
+	bool high_tf_client;
+	bool low_tf_client;
+	bool dyn_tb_bedge_en;
+	u8 def_tri_idx;
+};
+
+static
+void rtw89_phy_ul_tb_ctrl_check(struct rtw89_dev *rtwdev,
+				struct rtw89_vif *rtwvif,
+				struct rtw89_phy_ul_tb_check_data *ul_tb_data)
+{
+	struct rtw89_traffic_stats *stats = &rtwdev->stats;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+
+	if (rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION)
+		return;
+
+	if (!vif->cfg.assoc)
+		return;
+
+	if (stats->rx_tf_periodic > UL_TB_TF_CNT_L2H_TH)
+		ul_tb_data->high_tf_client = true;
+	else if (stats->rx_tf_periodic < UL_TB_TF_CNT_H2L_TH)
+		ul_tb_data->low_tf_client = true;
+
+	ul_tb_data->valid = true;
+	ul_tb_data->def_tri_idx = rtwvif->def_tri_idx;
+	ul_tb_data->dyn_tb_bedge_en = rtwvif->dyn_tb_bedge_en;
+}
+
+void rtw89_phy_ul_tb_ctrl_track(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_phy_ul_tb_info *ul_tb_info = &rtwdev->ul_tb_info;
+	struct rtw89_phy_ul_tb_check_data ul_tb_data = {};
+	struct rtw89_vif *rtwvif;
+
+	if (!chip->support_ul_tb_ctrl)
+		return;
+
+	if (rtwdev->total_sta_assoc != 1)
+		return;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_phy_ul_tb_ctrl_check(rtwdev, rtwvif, &ul_tb_data);
+
+	if (!ul_tb_data.valid)
+		return;
+
+	if (ul_tb_data.dyn_tb_bedge_en) {
+		if (ul_tb_data.high_tf_client) {
+			rtw89_phy_write32_mask(rtwdev, R_BANDEDGE, B_BANDEDGE_EN, 0);
+			rtw89_debug(rtwdev, RTW89_DBG_UL_TB,
+				    "[ULTB] Turn off if_bandedge\n");
+		} else if (ul_tb_data.low_tf_client) {
+			rtw89_phy_write32_mask(rtwdev, R_BANDEDGE, B_BANDEDGE_EN,
+					       ul_tb_info->def_if_bandedge);
+			rtw89_debug(rtwdev, RTW89_DBG_UL_TB,
+				    "[ULTB] Set to default if_bandedge = %d\n",
+				    ul_tb_info->def_if_bandedge);
+		}
+	}
+
+	if (ul_tb_info->dyn_tb_tri_en) {
+		if (ul_tb_data.high_tf_client) {
+			rtw89_phy_write32_mask(rtwdev, R_DCFO_OPT,
+					       B_TXSHAPE_TRIANGULAR_CFG, 0);
+			rtw89_debug(rtwdev, RTW89_DBG_UL_TB,
+				    "[ULTB] Turn off Tx triangle\n");
+		} else if (ul_tb_data.low_tf_client) {
+			rtw89_phy_write32_mask(rtwdev, R_DCFO_OPT,
+					       B_TXSHAPE_TRIANGULAR_CFG,
+					       ul_tb_data.def_tri_idx);
+			rtw89_debug(rtwdev, RTW89_DBG_UL_TB,
+				    "[ULTB] Set to default tx_shap_idx = %d\n",
+				    ul_tb_data.def_tri_idx);
+		}
+	}
+}
+
+static void rtw89_phy_ul_tb_info_init(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_phy_ul_tb_info *ul_tb_info = &rtwdev->ul_tb_info;
+
+	if (!chip->support_ul_tb_ctrl)
+		return;
+
+	ul_tb_info->dyn_tb_tri_en = true;
+	ul_tb_info->def_if_bandedge =
+		rtw89_phy_read32_mask(rtwdev, R_BANDEDGE, B_BANDEDGE_EN);
+}
+
 static void rtw89_phy_stat_thermal_update(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_phy_stat *phystat = &rtwdev->phystat;
@@ -3980,6 +4104,7 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 	rtw89_physts_parsing_init(rtwdev);
 	rtw89_phy_dig_init(rtwdev);
 	rtw89_phy_cfo_init(rtwdev);
+	rtw89_phy_ul_tb_info_init(rtwdev);
 
 	rtw89_phy_init_rf_nctl(rtwdev);
 	rtw89_chip_rfk_init(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index dac69a02e8687..21233f094644b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -64,6 +64,9 @@
 #define MAX_CFO_TOLERANCE 30
 #define CFO_TF_CNT_TH 300
 
+#define UL_TB_TF_CNT_L2H_TH 100
+#define UL_TB_TF_CNT_H2L_TH 70
+
 #define CCX_MAX_PERIOD 2097
 #define CCX_MAX_PERIOD_UNIT 32
 #define MS_TO_4US_RATIO 250
@@ -550,5 +553,7 @@ void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif
 void rtw89_phy_tssi_ctrl_set_bandedge_cfg(struct rtw89_dev *rtwdev,
 					  enum rtw89_mac_idx mac_idx,
 					  enum rtw89_tssi_bandedge_cfg bandedge_cfg);
+void rtw89_phy_ul_tb_assoc(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+void rtw89_phy_ul_tb_ctrl_track(struct rtw89_dev *rtwdev);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index f38a330698e9a..eff6519cf0191 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2082,6 +2082,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
 	.support_bw160		= false,
+	.support_ul_tb_ctrl     = false,
 	.hw_sec_hdr		= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 22b3c86ee7d86..2d4d572dc601f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2452,6 +2452,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
 	.support_bw160		= false,
+	.support_ul_tb_ctrl	= true,
 	.hw_sec_hdr		= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 01e6358fa1a29..9bc98fd5d4ac2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2891,6 +2891,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 				  BIT(NL80211_BAND_5GHZ) |
 				  BIT(NL80211_BAND_6GHZ),
 	.support_bw160		= true,
+	.support_ul_tb_ctrl     = false,
 	.hw_sec_hdr		= true,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
-- 
2.25.1

