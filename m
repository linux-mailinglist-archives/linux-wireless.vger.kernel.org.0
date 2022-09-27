Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210145EBA9D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 08:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiI0G2J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 02:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiI0G2B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 02:28:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73DDB857EF
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 23:27:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28R6Qhw06008390, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28R6Qhw06008390
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 27 Sep 2022 14:26:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 14:27:08 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 27 Sep
 2022 14:27:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 4/9] wifi: rtw89: 8852b: implement chip_ops::{enable,disable}_bb_rf
Date:   Tue, 27 Sep 2022 14:26:06 +0800
Message-ID: <20220927062611.30484-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927062611.30484-1-pkshih@realtek.com>
References: <20220927062611.30484-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/27/2022 06:02:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjcgpFekyCAwNDo1MzowMA==?=
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

Implement to power on/off BB and RF via MAC registers.

Add return type of chip_ops::disable_bb_rf, because it could fail to
disable. Also, correct naming of register 0x0200 used by the ops as well.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  4 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  8 ++-
 drivers/net/wireless/realtek/rtw89/mac.h      |  8 ++-
 drivers/net/wireless/realtek/rtw89/reg.h      | 10 +++-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 60 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  4 +-
 7 files changed, 84 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 7f75d05c004fb..31c2a7d6bfc2d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2949,7 +2949,9 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 	/* efuse process */
 
 	/* pre-config BB/RF, BB reset/RFC reset */
-	rtw89_chip_disable_bb_rf(rtwdev);
+	ret = rtw89_chip_disable_bb_rf(rtwdev);
+	if (ret)
+		return ret;
 	ret = rtw89_chip_enable_bb_rf(rtwdev);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b8b143c528358..d79e84f436c1a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2292,7 +2292,7 @@ struct rtw89_hci_info {
 
 struct rtw89_chip_ops {
 	int (*enable_bb_rf)(struct rtw89_dev *rtwdev);
-	void (*disable_bb_rf)(struct rtw89_dev *rtwdev);
+	int (*disable_bb_rf)(struct rtw89_dev *rtwdev);
 	void (*bb_reset)(struct rtw89_dev *rtwdev,
 			 enum rtw89_phy_idx phy_idx);
 	void (*bb_sethw)(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 9b75d9645580f..30132c4583d7d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1224,8 +1224,8 @@ static int chip_func_en(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 
-	if (chip_id == RTL8852A)
-		rtw89_write32_set(rtwdev, R_AX_SPSLDO_ON_CTRL0,
+	if (chip_id == RTL8852A || chip_id == RTL8852B)
+		rtw89_write32_set(rtwdev, R_AX_SPS_DIG_ON_CTRL0,
 				  B_AX_OCP_L1_MASK);
 
 	return 0;
@@ -3205,7 +3205,7 @@ int rtw89_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw89_mac_enable_bb_rf);
 
-void rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
+int rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN,
 			 B_AX_FEN_BBRSTB | B_AX_FEN_BB_GLB_RSTN);
@@ -3213,6 +3213,8 @@ void rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 			  B_AX_WLRF1_CTRL_7 | B_AX_WLRF1_CTRL_1 |
 			  B_AX_WLRF_CTRL_7 | B_AX_WLRF_CTRL_1);
 	rtw89_write8_clr(rtwdev, R_AX_PHYREG_SET, PHYREG_SET_ALL_CYCLE);
+
+	return 0;
 }
 EXPORT_SYMBOL(rtw89_mac_disable_bb_rf);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 5d1bb00a0fd2b..c09cc1f56ec1d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -805,7 +805,7 @@ void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 					struct ieee80211_vif *vif);
 int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 int rtw89_mac_enable_bb_rf(struct rtw89_dev *rtwdev);
-void rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev);
+int rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev);
 
 static inline int rtw89_chip_enable_bb_rf(struct rtw89_dev *rtwdev)
 {
@@ -814,11 +814,11 @@ static inline int rtw89_chip_enable_bb_rf(struct rtw89_dev *rtwdev)
 	return chip->ops->enable_bb_rf(rtwdev);
 }
 
-static inline void rtw89_chip_disable_bb_rf(struct rtw89_dev *rtwdev)
+static inline int rtw89_chip_disable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	chip->ops->disable_bb_rf(rtwdev);
+	return chip->ops->disable_bb_rf(rtwdev);
 }
 
 u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev);
@@ -988,8 +988,10 @@ enum rtw89_mac_xtal_si_offset {
 #define XTAL_SI_HIGH_ADDR_MASK	GENMASK(2, 0)
 	XTAL_SI_READ_VAL = 0x7A,
 	XTAL_SI_WL_RFC_S0 = 0x80,
+#define XTAL_SI_RF00S_EN	GENMASK(2, 0)
 #define XTAL_SI_RF00		BIT(0)
 	XTAL_SI_WL_RFC_S1 = 0x81,
+#define XTAL_SI_RF10S_EN	GENMASK(2, 0)
 #define XTAL_SI_RF10		BIT(0)
 	XTAL_SI_ANAPAR_WL = 0x90,
 #define XTAL_SI_SRAM2RFC	BIT(7)
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 9426b53e663bb..cb81c7eaece8a 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -51,9 +51,6 @@
 #define B_AX_EF_POR BIT(10)
 #define B_AX_EF_CELL_SEL_MASK GENMASK(9, 8)
 
-#define R_AX_SPSLDO_ON_CTRL0 0x0200
-#define B_AX_OCP_L1_MASK GENMASK(15, 13)
-
 #define R_AX_EFUSE_CTRL 0x0030
 #define B_AX_EF_MODE_SEL_MASK GENMASK(31, 30)
 #define B_AX_EF_RDY BIT(29)
@@ -203,6 +200,12 @@
 #define R_AX_UDM2 0x01F8
 #define R_AX_UDM3 0x01FC
 
+#define R_AX_SPS_DIG_ON_CTRL0 0x0200
+#define B_AX_VREFPFM_L_MASK GENMASK(25, 22)
+#define B_AX_REG_ZCDC_H_MASK GENMASK(18, 17)
+#define B_AX_OCP_L1_MASK GENMASK(15, 13)
+#define B_AX_VOL_L1_MASK GENMASK(3, 0)
+
 #define R_AX_LDO_AON_CTRL0 0x0218
 #define B_AX_PD_REGU_L BIT(16)
 
@@ -395,6 +398,7 @@
 
 #define R_AX_PHYREG_SET 0x8040
 #define PHYREG_SET_ALL_CYCLE 0x8
+#define PHYREG_SET_XYN_CYCLE 0xE
 
 #define R_AX_HD0IMR 0x8110
 #define B_AX_WDT_PTFM_INT_EN BIT(5)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index f951b8f0b5cfc..799da0c9f75ad 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -3,6 +3,66 @@
  */
 
 #include "core.h"
+#include "mac.h"
+#include "reg.h"
+
+static int rtw8852b_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	rtw89_write8_set(rtwdev, R_AX_SYS_FUNC_EN,
+			 B_AX_FEN_BBRSTB | B_AX_FEN_BB_GLB_RSTN);
+	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0, B_AX_REG_ZCDC_H_MASK, 0x1);
+	rtw89_write32_set(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
+	rtw89_write32_clr(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
+	rtw89_write32_set(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, 0xC7,
+				      FULL_BIT_MASK);
+	if (ret)
+		return ret;
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, 0xC7,
+				      FULL_BIT_MASK);
+	if (ret)
+		return ret;
+
+	rtw89_write8(rtwdev, R_AX_PHYREG_SET, PHYREG_SET_XYN_CYCLE);
+
+	return 0;
+}
+
+static int rtw8852b_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
+{
+	u8 wl_rfc_s0;
+	u8 wl_rfc_s1;
+	int ret;
+
+	rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN,
+			 B_AX_FEN_BBRSTB | B_AX_FEN_BB_GLB_RSTN);
+
+	ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, &wl_rfc_s0);
+	if (ret)
+		return ret;
+	wl_rfc_s0 &= ~XTAL_SI_RF00S_EN;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, wl_rfc_s0,
+				      FULL_BIT_MASK);
+	if (ret)
+		return ret;
+
+	ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, &wl_rfc_s1);
+	if (ret)
+		return ret;
+	wl_rfc_s1 &= ~XTAL_SI_RF10S_EN;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, wl_rfc_s1,
+				      FULL_BIT_MASK);
+	return ret;
+}
+
+static const struct rtw89_chip_ops rtw8852b_chip_ops = {
+	.enable_bb_rf		= rtw8852b_mac_enable_bb_rf,
+	.disable_bb_rf		= rtw8852b_mac_disable_bb_rf,
+};
 
 const struct rtw89_chip_info rtw8852b_chip_info = {
 	.chip_id		= RTL8852B,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 8c242d21e5fa4..00462c912ec7e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2976,10 +2976,12 @@ static int rtw8852c_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static void rtw8852c_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
+static int rtw8852c_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN,
 			 B_AX_FEN_BBRSTB | B_AX_FEN_BB_GLB_RSTN);
+
+	return 0;
 }
 
 static const struct rtw89_chip_ops rtw8852c_chip_ops = {
-- 
2.25.1

