Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6084E6E08
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356784AbiCYGDy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348180AbiCYGDx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:03:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589AAC681C
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:02:17 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22P62BKD0011120, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22P62BKD0011120
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Mar 2022 14:02:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 25 Mar 2022 14:02:11 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 14:02:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
Subject: [PATCH 10/16] rtw89: add chip_ops::{enable,disable}_bb_rf to support v1 chip
Date:   Fri, 25 Mar 2022 14:00:49 +0800
Message-ID: <20220325060055.58482-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325060055.58482-1-pkshih@realtek.com>
References: <20220325060055.58482-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/25/2022 05:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMjUgpFekyCAwNDo0ODowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The v1 chip use specific functions to enable and disable BB/RF.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  7 ++-
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 10 ++++-
 drivers/net/wireless/realtek/rtw89/mac.h      | 19 +++++++-
 drivers/net/wireless/realtek/rtw89/reg.h      |  6 +++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 45 +++++++++++++++++++
 7 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d923e4a0f963b..f540ee34fc2c0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2706,8 +2706,11 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 	/* efuse process */
 
 	/* pre-config BB/RF, BB reset/RFC reset */
-	rtw89_mac_disable_bb_rf(rtwdev);
-	rtw89_mac_enable_bb_rf(rtwdev);
+	rtw89_chip_disable_bb_rf(rtwdev);
+	ret = rtw89_chip_enable_bb_rf(rtwdev);
+	if (ret)
+		return ret;
+
 	rtw89_phy_init_bb_reg(rtwdev);
 	rtw89_phy_init_rf_reg(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 9f53d581a48f9..ee2edd9e9173a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2059,6 +2059,8 @@ struct rtw89_hci_info {
 };
 
 struct rtw89_chip_ops {
+	int (*enable_bb_rf)(struct rtw89_dev *rtwdev);
+	void (*disable_bb_rf)(struct rtw89_dev *rtwdev);
 	void (*bb_reset)(struct rtw89_dev *rtwdev,
 			 enum rtw89_phy_idx phy_idx);
 	void (*bb_sethw)(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index e729da8446d52..07a5e10e010f5 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2904,7 +2904,7 @@ static void rtw89_mac_hci_func_en(struct rtw89_dev *rtwdev)
 			  B_AX_HCI_TXDMA_EN | B_AX_HCI_RXDMA_EN);
 }
 
-void rtw89_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
+int rtw89_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	rtw89_write8_set(rtwdev, R_AX_SYS_FUNC_EN,
 			 B_AX_FEN_BBRSTB | B_AX_FEN_BB_GLB_RSTN);
@@ -2912,7 +2912,10 @@ void rtw89_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 			  B_AX_WLRF1_CTRL_7 | B_AX_WLRF1_CTRL_1 |
 			  B_AX_WLRF_CTRL_7 | B_AX_WLRF_CTRL_1);
 	rtw89_write8_set(rtwdev, R_AX_PHYREG_SET, PHYREG_SET_ALL_CYCLE);
+
+	return 0;
 }
+EXPORT_SYMBOL(rtw89_mac_enable_bb_rf);
 
 void rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 {
@@ -2923,6 +2926,7 @@ void rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 			  B_AX_WLRF_CTRL_7 | B_AX_WLRF_CTRL_1);
 	rtw89_write8_clr(rtwdev, R_AX_PHYREG_SET, PHYREG_SET_ALL_CYCLE);
 }
+EXPORT_SYMBOL(rtw89_mac_disable_bb_rf);
 
 int rtw89_mac_partial_init(struct rtw89_dev *rtwdev)
 {
@@ -2968,7 +2972,9 @@ int rtw89_mac_init(struct rtw89_dev *rtwdev)
 	if (ret)
 		goto fail;
 
-	rtw89_mac_enable_bb_rf(rtwdev);
+	ret = rtw89_chip_enable_bb_rf(rtwdev);
+	if (ret)
+		goto fail;
 
 	ret = rtw89_mac_sys_init(rtwdev);
 	if (ret)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index a05c504505d82..2d44f9aa20dc9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -793,8 +793,23 @@ int rtw89_mac_read_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 *val);
 int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
-void rtw89_mac_enable_bb_rf(struct rtw89_dev *rtwdev);
+int rtw89_mac_enable_bb_rf(struct rtw89_dev *rtwdev);
 void rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev);
+
+static inline int rtw89_chip_enable_bb_rf(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return chip->ops->enable_bb_rf(rtwdev);
+}
+
+static inline void rtw89_chip_disable_bb_rf(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	chip->ops->disable_bb_rf(rtwdev);
+}
+
 u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev);
 int rtw89_mac_set_err_status(struct rtw89_dev *rtwdev, u32 err);
 void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
@@ -899,6 +914,8 @@ int rtw89_mac_get_tx_retry_limit(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta *rtwsta, u8 *tx_retry);
 
 enum rtw89_mac_xtal_si_offset {
+	XTAL0 = 0x0,
+	XTAL3 = 0x3,
 	XTAL_SI_XTAL_SC_XI = 0x04,
 #define XTAL_SC_XI_MASK		GENMASK(7, 0)
 	XTAL_SI_XTAL_SC_XO = 0x05,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index fd9874137af72..1f4cf30f3822b 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -218,6 +218,7 @@
 #define B_AX_EECS_PULL_LOW_EN BIT(16)
 
 #define R_AX_WLRF_CTRL 0x02F0
+#define B_AX_AFC_AFEDIG BIT(17)
 #define B_AX_WLRF1_CTRL_7 BIT(15)
 #define B_AX_WLRF1_CTRL_1 BIT(9)
 #define B_AX_WLRF_CTRL_7 BIT(7)
@@ -231,6 +232,11 @@
 #define B_AX_USB_HCISYS_PWR_STE_MASK GENMASK(3, 2)
 #define B_AX_PCIE_HCISYS_PWR_STE_MASK GENMASK(1, 0)
 
+#define R_AX_AFE_OFF_CTRL1 0x0444
+#define B_AX_S1_LDO_VSEL_F_MASK GENMASK(25, 24)
+#define B_AX_S1_LDO2PWRCUT_F BIT(23)
+#define B_AX_S0_LDO_VSEL_F_MASK GENMASK(22, 21)
+
 #define R_AX_FILTER_MODEL_ADDR 0x0C04
 
 #define R_AX_HAXI_INIT_CFG1 0x1000
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index a745019f8ab04..5f2fb0ca31d4d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1994,6 +1994,8 @@ static void rtw8852a_query_ppdu(struct rtw89_dev *rtwdev,
 }
 
 static const struct rtw89_chip_ops rtw8852a_chip_ops = {
+	.enable_bb_rf		= rtw89_mac_enable_bb_rf,
+	.disable_bb_rf		= rtw89_mac_disable_bb_rf,
 	.bb_reset		= rtw8852a_bb_reset,
 	.bb_sethw		= rtw8852a_bb_sethw,
 	.read_rf		= rtw89_phy_read_rf,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 9e3a3fc514ce7..7a31f216b747d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -481,7 +481,52 @@ void rtw8852c_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 	}
 }
 
+static int rtw8852c_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	rtw89_write8_set(rtwdev, R_AX_SYS_FUNC_EN,
+			 B_AX_FEN_BBRSTB | B_AX_FEN_BB_GLB_RSTN);
+
+	rtw89_write32_set(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
+	rtw89_write32_clr(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
+	rtw89_write32_set(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
+
+	rtw89_write32_mask(rtwdev, R_AX_AFE_OFF_CTRL1, B_AX_S0_LDO_VSEL_F_MASK, 0x1);
+	rtw89_write32_mask(rtwdev, R_AX_AFE_OFF_CTRL1, B_AX_S1_LDO_VSEL_F_MASK, 0x1);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL0, 0x7, FULL_BIT_MASK);
+	if (ret)
+		return ret;
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x6c, FULL_BIT_MASK);
+	if (ret)
+		return ret;
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, 0xc7, FULL_BIT_MASK);
+	if (ret)
+		return ret;
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, 0xc7, FULL_BIT_MASK);
+	if (ret)
+		return ret;
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL3, 0xd, FULL_BIT_MASK);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void rtw8852c_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
+{
+	rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN,
+			 B_AX_FEN_BBRSTB | B_AX_FEN_BB_GLB_RSTN);
+}
+
 static const struct rtw89_chip_ops rtw8852c_chip_ops = {
+	.enable_bb_rf		= rtw8852c_mac_enable_bb_rf,
+	.disable_bb_rf		= rtw8852c_mac_disable_bb_rf,
 	.read_efuse		= rtw8852c_read_efuse,
 	.read_phycap		= rtw8852c_read_phycap,
 	.power_trim		= rtw8852c_power_trim,
-- 
2.25.1

