Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F197AD2BB
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 10:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjIYIJv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 04:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjIYIJu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 04:09:50 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FE0DA
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 01:09:42 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38P89K7W03456792, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38P89K7W03456792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 16:09:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 25 Sep 2023 16:09:20 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 25 Sep
 2023 16:09:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <johannes@sipsolutions.net>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: rtw89: refine bandwidth 160MHz uplink OFDMA performance
Date:   Mon, 25 Sep 2023 16:09:02 +0800
Message-ID: <20230925080902.51449-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925080902.51449-1-pkshih@realtek.com>
References: <20230925080902.51449-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
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

From: Po-Hao Huang <phhuang@realtek.com>

This improves 160MHz performance degradation with certain APs.
Some ICs transmit preamble that are hard to decode by others, continuous
retries then yield low throughput. Fix it with pre-calculated antenna
matrices.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 17 ++++--
 drivers/net/wireless/realtek/rtw89/core.h     | 27 +++++++++
 drivers/net/wireless/realtek/rtw89/phy.c      | 59 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/reg.h      | 12 ++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 8 files changed, 113 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 03704c4752a5..8ffeedeec5ce 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1671,8 +1671,8 @@ static void rtw89_stats_trigger_frame(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct ieee80211_trigger *tf = (struct ieee80211_trigger *)skb->data;
-	u8 *pos, *end, type;
-	u16 aid;
+	u8 *pos, *end, type, tf_bw;
+	u16 aid, tf_rua;
 
 	if (!ether_addr_equal(vif->bss_conf.bssid, tf->ta) ||
 	    rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION ||
@@ -1680,7 +1680,7 @@ static void rtw89_stats_trigger_frame(struct rtw89_dev *rtwdev,
 		return;
 
 	type = le64_get_bits(tf->common_info, IEEE80211_TRIGGER_TYPE_MASK);
-	if (type != IEEE80211_TRIGGER_TYPE_BASIC)
+	if (type != IEEE80211_TRIGGER_TYPE_BASIC && type != IEEE80211_TRIGGER_TYPE_MU_BAR)
 		return;
 
 	end = (u8 *)tf + skb->len;
@@ -1688,17 +1688,24 @@ static void rtw89_stats_trigger_frame(struct rtw89_dev *rtwdev,
 
 	while (end - pos >= RTW89_TF_BASIC_USER_INFO_SZ) {
 		aid = RTW89_GET_TF_USER_INFO_AID12(pos);
+		tf_rua = RTW89_GET_TF_USER_INFO_RUA(pos);
+		tf_bw = le64_get_bits(tf->common_info, IEEE80211_TRIGGER_ULBW_MASK);
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
-			    "[TF] aid: %d, ul_mcs: %d, rua: %d\n",
+			    "[TF] aid: %d, ul_mcs: %d, rua: %d, bw: %d\n",
 			    aid, RTW89_GET_TF_USER_INFO_UL_MCS(pos),
-			    RTW89_GET_TF_USER_INFO_RUA(pos));
+			    tf_rua, tf_bw);
 
 		if (aid == RTW89_TF_PAD)
 			break;
 
 		if (aid == vif->cfg.aid) {
+			enum nl80211_he_ru_alloc rua = rtw89_he_rua_to_ru_alloc(tf_rua >> 1);
+
 			rtwvif->stats.rx_tf_acc++;
 			rtwdev->stats.rx_tf_acc++;
+			if (tf_bw == IEEE80211_TRIGGER_ULBW_160_80P80MHZ &&
+			    rua <= NL80211_RATE_INFO_HE_RU_ALLOC_106)
+				rtwvif->pwr_diff_en = true;
 			break;
 		}
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f1dd1a452988..079f06cc9c28 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3044,6 +3044,8 @@ struct rtw89_vif {
 	bool is_hesta;
 	bool last_a_ctrl;
 	bool dyn_tb_bedge_en;
+	bool pre_pwr_diff_en;
+	bool pwr_diff_en;
 	u8 def_tri_idx;
 	u32 tdls_peer;
 	struct work_struct update_beacon_work;
@@ -3649,6 +3651,7 @@ struct rtw89_chip_info {
 	bool support_bw160;
 	bool support_unii4;
 	bool ul_tb_waveform_ctrl;
+	bool ul_tb_pwr_diff;
 	bool hw_sec_hdr;
 	u8 rf_path_num;
 	u8 tx_nss;
@@ -5204,6 +5207,30 @@ enum rtw89_bandwidth nl_to_rtw89_bandwidth(enum nl80211_chan_width width)
 	}
 }
 
+static inline
+enum nl80211_he_ru_alloc rtw89_he_rua_to_ru_alloc(u16 rua)
+{
+	switch (rua) {
+	default:
+		WARN(1, "Invalid RU allocation: %d\n", rua);
+		fallthrough;
+	case 0 ... 36:
+		return NL80211_RATE_INFO_HE_RU_ALLOC_26;
+	case 37 ... 52:
+		return NL80211_RATE_INFO_HE_RU_ALLOC_52;
+	case 53 ... 60:
+		return NL80211_RATE_INFO_HE_RU_ALLOC_106;
+	case 61 ... 64:
+		return NL80211_RATE_INFO_HE_RU_ALLOC_242;
+	case 65 ... 66:
+		return NL80211_RATE_INFO_HE_RU_ALLOC_484;
+	case 67:
+		return NL80211_RATE_INFO_HE_RU_ALLOC_996;
+	case 68:
+		return NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
+	}
+}
+
 static inline
 struct rtw89_addr_cam_entry *rtw89_get_addr_cam_of(struct rtw89_vif *rtwvif,
 						   struct rtw89_sta *rtwsta)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 1232ca48deee..05b0ca3d75fe 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2934,6 +2934,61 @@ struct rtw89_phy_ul_tb_check_data {
 	u8 def_tri_idx;
 };
 
+struct rtw89_phy_power_diff {
+	u32 q_00;
+	u32 q_11;
+	u32 q_matrix_en;
+	u32 ultb_1t_norm_160;
+	u32 ultb_2t_norm_160;
+	u32 com1_norm_1sts;
+	u32 com2_resp_1sts_path;
+};
+
+static void rtw89_phy_ofdma_power_diff(struct rtw89_dev *rtwdev,
+				       struct rtw89_vif *rtwvif)
+{
+	static const struct rtw89_phy_power_diff table[2] = {
+		{0x0, 0x0, 0x0, 0x0, 0xf4, 0x3, 0x3},
+		{0xb50, 0xb50, 0x1, 0xc, 0x0, 0x1, 0x1},
+	};
+	const struct rtw89_phy_power_diff *param;
+	u32 reg;
+
+	if (!rtwdev->chip->ul_tb_pwr_diff)
+		return;
+
+	if (rtwvif->pwr_diff_en == rtwvif->pre_pwr_diff_en) {
+		rtwvif->pwr_diff_en = false;
+		return;
+	}
+
+	rtwvif->pre_pwr_diff_en = rtwvif->pwr_diff_en;
+	param = &table[rtwvif->pwr_diff_en];
+
+	rtw89_phy_write32_mask(rtwdev, R_Q_MATRIX_00, B_Q_MATRIX_00_REAL,
+			       param->q_00);
+	rtw89_phy_write32_mask(rtwdev, R_Q_MATRIX_11, B_Q_MATRIX_11_REAL,
+			       param->q_11);
+	rtw89_phy_write32_mask(rtwdev, R_CUSTOMIZE_Q_MATRIX,
+			       B_CUSTOMIZE_Q_MATRIX_EN, param->q_matrix_en);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_1T, rtwvif->mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_1T_NORM_BW160,
+			   param->ultb_1t_norm_160);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_2T, rtwvif->mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_2T_NORM_BW160,
+			   param->ultb_2t_norm_160);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PATH_COM1, rtwvif->mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_PATH_COM1_NORM_1STS,
+			   param->com1_norm_1sts);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PATH_COM2, rtwvif->mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_PATH_COM2_RESP_1STS_PATH,
+			   param->com2_resp_1sts_path);
+}
+
 static
 void rtw89_phy_ul_tb_ctrl_check(struct rtw89_dev *rtwdev,
 				struct rtw89_vif *rtwvif,
@@ -2958,6 +3013,8 @@ void rtw89_phy_ul_tb_ctrl_check(struct rtw89_dev *rtwdev,
 		ul_tb_data->def_tri_idx = rtwvif->def_tri_idx;
 		ul_tb_data->dyn_tb_bedge_en = rtwvif->dyn_tb_bedge_en;
 	}
+
+	rtw89_phy_ofdma_power_diff(rtwdev, rtwvif);
 }
 
 static void rtw89_phy_ul_tb_waveform_ctrl(struct rtw89_dev *rtwdev,
@@ -3005,7 +3062,7 @@ void rtw89_phy_ul_tb_ctrl_track(struct rtw89_dev *rtwdev)
 	struct rtw89_phy_ul_tb_check_data ul_tb_data = {};
 	struct rtw89_vif *rtwvif;
 
-	if (!chip->ul_tb_waveform_ctrl)
+	if (!chip->ul_tb_waveform_ctrl && !chip->ul_tb_pwr_diff)
 		return;
 
 	if (rtwdev->total_sta_assoc != 1)
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index edaf2a13ef98..4b9a090642cc 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3360,9 +3360,11 @@
 #define R_AX_PWR_UL_TB_1T 0xD28C
 #define B_AX_PWR_UL_TB_1T_MASK GENMASK(4, 0)
 #define B_AX_PWR_UL_TB_1T_V1_MASK GENMASK(7, 0)
+#define B_AX_PWR_UL_TB_1T_NORM_BW160 GENMASK(31, 24)
 #define R_AX_PWR_UL_TB_2T 0xD290
 #define B_AX_PWR_UL_TB_2T_MASK GENMASK(4, 0)
 #define B_AX_PWR_UL_TB_2T_V1_MASK GENMASK(7, 0)
+#define B_AX_PWR_UL_TB_2T_NORM_BW160 GENMASK(31, 24)
 #define R_AX_PWR_BY_RATE_TABLE0 0xD2C0
 #define R_AX_PWR_BY_RATE_TABLE6 0xD2D8
 #define R_AX_PWR_BY_RATE_TABLE10 0xD2E8
@@ -3390,11 +3392,13 @@
 #define AX_PATH_COM0_PATHB 0x11111900
 #define AX_PATH_COM0_PATHAB 0x19999980
 #define R_AX_PATH_COM1 0xD804
+#define B_AX_PATH_COM1_NORM_1STS GENMASK(31, 28)
 #define AX_PATH_COM1_DFVAL 0x00000000
 #define AX_PATH_COM1_PATHA 0x13111111
 #define AX_PATH_COM1_PATHB 0x23222222
 #define AX_PATH_COM1_PATHAB 0x33333333
 #define R_AX_PATH_COM2 0xD808
+#define B_AX_PATH_COM2_RESP_1STS_PATH GENMASK(7, 4)
 #define AX_PATH_COM2_DFVAL 0x00000000
 #define AX_PATH_COM2_PATHA 0x01209313
 #define AX_PATH_COM2_PATHB 0x01209323
@@ -4669,12 +4673,20 @@
 #define B_ANT_RX_1RCCA_SEG1 GENMASK(21, 18)
 #define B_ANT_RX_1RCCA_SEG0 GENMASK(17, 14)
 #define B_FC0_BW_INV GENMASK(6, 0)
+#define R_Q_MATRIX_00 0x497C
+#define B_Q_MATRIX_00_IMAGINARY GENMASK(15, 0)
+#define B_Q_MATRIX_00_REAL GENMASK(31, 16)
 #define R_CHBW_MOD 0x4978
 #define R_CHBW_MOD_V1 0x49C4
 #define B_BT_SHARE BIT(14)
 #define B_CHBW_MOD_SBW GENMASK(13, 12)
 #define B_CHBW_MOD_PRICH GENMASK(11, 8)
 #define B_ANT_RX_SEG0 GENMASK(3, 0)
+#define R_Q_MATRIX_11 0x4988
+#define B_Q_MATRIX_11_IMAGINARY GENMASK(15, 0)
+#define B_Q_MATRIX_11_REAL GENMASK(31, 16)
+#define R_CUSTOMIZE_Q_MATRIX 0x498C
+#define B_CUSTOMIZE_Q_MATRIX_EN BIT(0)
 #define R_P0_RPL1 0x49B0
 #define B_P0_RPL1_41_MASK GENMASK(31, 24)
 #define B_P0_RPL1_40_MASK GENMASK(23, 16)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index b276816f1ce6..ecaa86ccd49e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2380,6 +2380,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.support_bw160		= false,
 	.support_unii4		= true,
 	.ul_tb_waveform_ctrl	= true,
+	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= false,
 	.rf_path_num		= 1,
 	.tx_nss			= 1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 12b591d06000..ec6ec3868d52 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2116,6 +2116,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.support_bw160		= false,
 	.support_unii4		= false,
 	.ul_tb_waveform_ctrl	= false,
+	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 1591ae82fac5..e5bc459dbe79 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2550,6 +2550,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.support_bw160		= false,
 	.support_unii4		= true,
 	.ul_tb_waveform_ctrl	= true,
+	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 5641c6c49acf..818764efea9e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2860,6 +2860,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.support_bw160		= true,
 	.support_unii4		= true,
 	.ul_tb_waveform_ctrl	= false,
+	.ul_tb_pwr_diff		= true,
 	.hw_sec_hdr		= true,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
-- 
2.25.1

