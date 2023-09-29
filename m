Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA767B29DB
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 02:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjI2Ale (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 20:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjI2Ald (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 20:41:33 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F175611F
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 17:41:30 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38T0fL5j9260777, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38T0fL5j9260777
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 08:41:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 29 Sep 2023 08:41:22 +0800
Received: from [127.0.1.1] (172.16.16.144) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 29 Sep
 2023 08:41:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/2] wifi: rtw89: refine uplink trigger based control mechanism
Date:   Fri, 29 Sep 2023 08:40:23 +0800
Message-ID: <20230929004024.7504-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230929004024.7504-1-pkshih@realtek.com>
References: <20230929004024.7504-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.144]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Rename support_ul_tb_ctrl to waveform_ctrl since we need to do more
trigger based control and the naming could be confusing. Move related
code to leaf function so we make each functions separate and can be
easier to maintain.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 72 +++++++++++--------
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  2 +-
 6 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 56cf47f2ae2b..7a926303e249 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3648,7 +3648,7 @@ struct rtw89_chip_info {
 	u8 support_bands;
 	bool support_bw160;
 	bool support_unii4;
-	bool support_ul_tb_ctrl;
+	bool ul_tb_waveform_ctrl;
 	bool hw_sec_hdr;
 	u8 rf_path_num;
 	u8 tx_nss;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 6e1f4d6c345c..1232ca48deee 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2904,7 +2904,7 @@ void rtw89_phy_ul_tb_assoc(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 						       rtwvif->sub_entity_idx);
 	struct rtw89_phy_ul_tb_info *ul_tb_info = &rtwdev->ul_tb_info;
 
-	if (!chip->support_ul_tb_ctrl)
+	if (!chip->ul_tb_waveform_ctrl)
 		return;
 
 	rtwvif->def_tri_idx =
@@ -2948,41 +2948,32 @@ void rtw89_phy_ul_tb_ctrl_check(struct rtw89_dev *rtwdev,
 	if (!vif->cfg.assoc)
 		return;
 
-	if (stats->rx_tf_periodic > UL_TB_TF_CNT_L2H_TH)
-		ul_tb_data->high_tf_client = true;
-	else if (stats->rx_tf_periodic < UL_TB_TF_CNT_H2L_TH)
-		ul_tb_data->low_tf_client = true;
+	if (rtwdev->chip->ul_tb_waveform_ctrl) {
+		if (stats->rx_tf_periodic > UL_TB_TF_CNT_L2H_TH)
+			ul_tb_data->high_tf_client = true;
+		else if (stats->rx_tf_periodic < UL_TB_TF_CNT_H2L_TH)
+			ul_tb_data->low_tf_client = true;
 
-	ul_tb_data->valid = true;
-	ul_tb_data->def_tri_idx = rtwvif->def_tri_idx;
-	ul_tb_data->dyn_tb_bedge_en = rtwvif->dyn_tb_bedge_en;
+		ul_tb_data->valid = true;
+		ul_tb_data->def_tri_idx = rtwvif->def_tri_idx;
+		ul_tb_data->dyn_tb_bedge_en = rtwvif->dyn_tb_bedge_en;
+	}
 }
 
-void rtw89_phy_ul_tb_ctrl_track(struct rtw89_dev *rtwdev)
+static void rtw89_phy_ul_tb_waveform_ctrl(struct rtw89_dev *rtwdev,
+					  struct rtw89_phy_ul_tb_check_data *ul_tb_data)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_phy_ul_tb_info *ul_tb_info = &rtwdev->ul_tb_info;
-	struct rtw89_phy_ul_tb_check_data ul_tb_data = {};
-	struct rtw89_vif *rtwvif;
 
-	if (!chip->support_ul_tb_ctrl)
+	if (!rtwdev->chip->ul_tb_waveform_ctrl)
 		return;
 
-	if (rtwdev->total_sta_assoc != 1)
-		return;
-
-	rtw89_for_each_rtwvif(rtwdev, rtwvif)
-		rtw89_phy_ul_tb_ctrl_check(rtwdev, rtwvif, &ul_tb_data);
-
-	if (!ul_tb_data.valid)
-		return;
-
-	if (ul_tb_data.dyn_tb_bedge_en) {
-		if (ul_tb_data.high_tf_client) {
+	if (ul_tb_data->dyn_tb_bedge_en) {
+		if (ul_tb_data->high_tf_client) {
 			rtw89_phy_write32_mask(rtwdev, R_BANDEDGE, B_BANDEDGE_EN, 0);
 			rtw89_debug(rtwdev, RTW89_DBG_UL_TB,
 				    "[ULTB] Turn off if_bandedge\n");
-		} else if (ul_tb_data.low_tf_client) {
+		} else if (ul_tb_data->low_tf_client) {
 			rtw89_phy_write32_mask(rtwdev, R_BANDEDGE, B_BANDEDGE_EN,
 					       ul_tb_info->def_if_bandedge);
 			rtw89_debug(rtwdev, RTW89_DBG_UL_TB,
@@ -2992,28 +2983,49 @@ void rtw89_phy_ul_tb_ctrl_track(struct rtw89_dev *rtwdev)
 	}
 
 	if (ul_tb_info->dyn_tb_tri_en) {
-		if (ul_tb_data.high_tf_client) {
+		if (ul_tb_data->high_tf_client) {
 			rtw89_phy_write32_mask(rtwdev, R_DCFO_OPT,
 					       B_TXSHAPE_TRIANGULAR_CFG, 0);
 			rtw89_debug(rtwdev, RTW89_DBG_UL_TB,
 				    "[ULTB] Turn off Tx triangle\n");
-		} else if (ul_tb_data.low_tf_client) {
+		} else if (ul_tb_data->low_tf_client) {
 			rtw89_phy_write32_mask(rtwdev, R_DCFO_OPT,
 					       B_TXSHAPE_TRIANGULAR_CFG,
-					       ul_tb_data.def_tri_idx);
+					       ul_tb_data->def_tri_idx);
 			rtw89_debug(rtwdev, RTW89_DBG_UL_TB,
 				    "[ULTB] Set to default tx_shap_idx = %d\n",
-				    ul_tb_data.def_tri_idx);
+				    ul_tb_data->def_tri_idx);
 		}
 	}
 }
 
+void rtw89_phy_ul_tb_ctrl_track(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_phy_ul_tb_check_data ul_tb_data = {};
+	struct rtw89_vif *rtwvif;
+
+	if (!chip->ul_tb_waveform_ctrl)
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
+	rtw89_phy_ul_tb_waveform_ctrl(rtwdev, &ul_tb_data);
+}
+
 static void rtw89_phy_ul_tb_info_init(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_phy_ul_tb_info *ul_tb_info = &rtwdev->ul_tb_info;
 
-	if (!chip->support_ul_tb_ctrl)
+	if (!chip->ul_tb_waveform_ctrl)
 		return;
 
 	ul_tb_info->dyn_tb_tri_en = true;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index f9599fcd5ac7..b276816f1ce6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2379,7 +2379,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 				  BIT(NL80211_BAND_5GHZ),
 	.support_bw160		= false,
 	.support_unii4		= true,
-	.support_ul_tb_ctrl	= true,
+	.ul_tb_waveform_ctrl	= true,
 	.hw_sec_hdr		= false,
 	.rf_path_num		= 1,
 	.tx_nss			= 1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index c783e17c7ae8..12b591d06000 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2115,7 +2115,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 				  BIT(NL80211_BAND_5GHZ),
 	.support_bw160		= false,
 	.support_unii4		= false,
-	.support_ul_tb_ctrl     = false,
+	.ul_tb_waveform_ctrl	= false,
 	.hw_sec_hdr		= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 3c1f5a9284dc..1591ae82fac5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2549,7 +2549,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 				  BIT(NL80211_BAND_5GHZ),
 	.support_bw160		= false,
 	.support_unii4		= true,
-	.support_ul_tb_ctrl	= true,
+	.ul_tb_waveform_ctrl	= true,
 	.hw_sec_hdr		= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ad5baf653c1d..553f60d98f45 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2859,7 +2859,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 				  BIT(NL80211_BAND_6GHZ),
 	.support_bw160		= true,
 	.support_unii4		= true,
-	.support_ul_tb_ctrl     = false,
+	.ul_tb_waveform_ctrl	= false,
 	.hw_sec_hdr		= true,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
-- 
2.25.1

