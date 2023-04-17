Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BE86E3D61
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 04:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjDQCTB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 22:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDQCTA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 22:19:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98223593
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 19:18:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33H2IMeiC031096, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33H2IMeiC031096
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 17 Apr 2023 10:18:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 17 Apr 2023 10:18:46 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 17 Apr
 2023 10:18:45 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/7] wifi: rtw89: initialize antenna for antenna diveristy
Date:   Mon, 17 Apr 2023 10:17:05 +0800
Message-ID: <20230417021707.16369-6-pkshih@realtek.com>
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

Initialize basic antenna switch settings according to hardware module
design, and set to default antenna A. The set antenna function will be
called dynamically to switch antenna according to EVM and RSSI.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 69 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h | 21 +++++++-
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c7e9061234169..3f9755c58e6c3 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2946,6 +2946,44 @@ static void rtw89_phy_ul_tb_info_init(struct rtw89_dev *rtwdev)
 		rtw89_phy_read32_mask(rtwdev, R_BANDEDGE, B_BANDEDGE_EN);
 }
 
+static void rtw89_phy_antdiv_reg_init(struct rtw89_dev *rtwdev)
+{
+	rtw89_phy_write32_idx(rtwdev, R_P0_TRSW, B_P0_ANT_TRAIN_EN,
+			      0x0, RTW89_PHY_0);
+	rtw89_phy_write32_idx(rtwdev, R_P0_TRSW, B_P0_TX_ANT_SEL,
+			      0x0, RTW89_PHY_0);
+
+	rtw89_phy_write32_idx(rtwdev, R_P0_ANT_SW, B_P0_TRSW_TX_EXTEND,
+			      0x0, RTW89_PHY_0);
+	rtw89_phy_write32_idx(rtwdev, R_P0_ANT_SW, B_P0_HW_ANTSW_DIS_BY_GNT_BT,
+			      0x0, RTW89_PHY_0);
+
+	rtw89_phy_write32_idx(rtwdev, R_P0_TRSW, B_P0_BT_FORCE_ANTIDX_EN,
+			      0x0, RTW89_PHY_0);
+
+	rtw89_phy_write32_idx(rtwdev, R_RFSW_CTRL_ANT0_BASE, B_RFSW_CTRL_ANT_MAPPING,
+			      0x0100, RTW89_PHY_0);
+
+	rtw89_phy_write32_idx(rtwdev, R_P0_ANTSEL, B_P0_ANTSEL_BTG_TRX,
+			      0x1, RTW89_PHY_0);
+	rtw89_phy_write32_idx(rtwdev, R_P0_ANTSEL, B_P0_ANTSEL_HW_CTRL,
+			      0x0, RTW89_PHY_0);
+	rtw89_phy_write32_idx(rtwdev, R_P0_ANTSEL, B_P0_ANTSEL_SW_2G,
+			      0x0, RTW89_PHY_0);
+	rtw89_phy_write32_idx(rtwdev, R_P0_ANTSEL, B_P0_ANTSEL_SW_5G,
+			      0x0, RTW89_PHY_0);
+}
+
+static void rtw89_phy_antdiv_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	if (!hal->ant_diversity)
+		return;
+
+	rtw89_phy_antdiv_reg_init(rtwdev);
+}
+
 static void rtw89_phy_stat_thermal_update(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_phy_stat *phystat = &rtwdev->phystat;
@@ -4114,6 +4152,35 @@ void rtw89_phy_tx_path_div_track(struct rtw89_dev *rtwdev)
 					  &done);
 }
 
+#define ANTDIV_MAIN 0
+#define ANTDIV_AUX 1
+
+static void rtw89_phy_antdiv_set_ant(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 default_ant, optional_ant;
+
+	if (!hal->ant_diversity || hal->antenna_tx == 0)
+		return;
+
+	if (hal->antenna_tx == RF_B) {
+		default_ant = ANTDIV_AUX;
+		optional_ant = ANTDIV_MAIN;
+	} else {
+		default_ant = ANTDIV_MAIN;
+		optional_ant = ANTDIV_AUX;
+	}
+
+	rtw89_phy_write32_idx(rtwdev, R_P0_ANTSEL, B_P0_ANTSEL_CGCS_CTRL,
+			      default_ant, RTW89_PHY_0);
+	rtw89_phy_write32_idx(rtwdev, R_P0_ANTSEL, B_P0_ANTSEL_RX_ORI,
+			      default_ant, RTW89_PHY_0);
+	rtw89_phy_write32_idx(rtwdev, R_P0_ANTSEL, B_P0_ANTSEL_RX_ALT,
+			      optional_ant, RTW89_PHY_0);
+	rtw89_phy_write32_idx(rtwdev, R_P0_ANTSEL, B_P0_ANTSEL_TX_ORI,
+			      default_ant, RTW89_PHY_0);
+}
+
 static void rtw89_phy_env_monitor_init(struct rtw89_dev *rtwdev)
 {
 	rtw89_phy_ccx_top_setting_init(rtwdev);
@@ -4133,6 +4200,8 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 	rtw89_phy_dig_init(rtwdev);
 	rtw89_phy_cfo_init(rtwdev);
 	rtw89_phy_ul_tb_info_init(rtwdev);
+	rtw89_phy_antdiv_init(rtwdev);
+	rtw89_phy_antdiv_set_ant(rtwdev);
 
 	rtw89_phy_init_rf_nctl(rtwdev);
 	rtw89_chip_rfk_init(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 7e466ebaec2c4..c1c4591337872 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3851,6 +3851,9 @@
 #define B_ENABLE_CCK BIT(5)
 #define R_RSTB_ASYNC 0x0704
 #define B_RSTB_ASYNC_ALL BIT(1)
+#define R_P0_ANT_SW 0x0728
+#define B_P0_HW_ANTSW_DIS_BY_GNT_BT BIT(12)
+#define B_P0_TRSW_TX_EXTEND GENMASK(3, 0)
 #define R_MAC_PIN_SEL 0x0734
 #define B_CH_IDX_SEG0 GENMASK(23, 16)
 #define R_PLCP_HISTOGRAM 0x0738
@@ -4454,10 +4457,24 @@
 #define B_P0_RFCTM_VAL GENMASK(25, 20)
 #define R_P0_RFCTM_RDY BIT(26)
 #define R_P0_TRSW 0x5868
-#define B_P0_TRSW_B BIT(0)
-#define B_P0_TRSW_A BIT(1)
+#define B_P0_BT_FORCE_ANTIDX_EN BIT(12)
 #define B_P0_TRSW_X BIT(2)
+#define B_P0_TRSW_A BIT(1)
+#define B_P0_TX_ANT_SEL BIT(1)
+#define B_P0_TRSW_B BIT(0)
+#define B_P0_ANT_TRAIN_EN BIT(0)
 #define B_P0_TRSW_SO_A2 GENMASK(7, 5)
+#define R_P0_ANTSEL 0x586C
+#define B_P0_ANTSEL_SW_5G BIT(25)
+#define B_P0_ANTSEL_SW_2G BIT(23)
+#define B_P0_ANTSEL_BTG_TRX BIT(21)
+#define B_P0_ANTSEL_CGCS_CTRL BIT(17)
+#define B_P0_ANTSEL_HW_CTRL BIT(16)
+#define B_P0_ANTSEL_TX_ORI GENMASK(15, 12)
+#define B_P0_ANTSEL_RX_ALT GENMASK(11, 8)
+#define B_P0_ANTSEL_RX_ORI GENMASK(7, 4)
+#define R_RFSW_CTRL_ANT0_BASE 0x5870
+#define B_RFSW_CTRL_ANT_MAPPING GENMASK(15, 0)
 #define R_P0_RFM 0x5894
 #define B_P0_RFM_DIS_WL BIT(7)
 #define B_P0_RFM_TX_OPT BIT(6)
-- 
2.25.1

