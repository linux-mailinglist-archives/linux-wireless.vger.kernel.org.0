Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7A26EA1CC
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 04:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjDUCqg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 22:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjDUCqe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 22:46:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9013C49C2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 19:46:29 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33L2kNVd9016490, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33L2kNVd9016490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 21 Apr 2023 10:46:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 21 Apr 2023 10:46:02 +0800
Received: from localhost.localdomain (172.21.69.188) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Apr 2023 10:46:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <gary.chang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/8] wifi: rtw89: add CFO XTAL registers field to support 8851B
Date:   Fri, 21 Apr 2023 10:45:47 +0800
Message-ID: <20230421024551.29994-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421024551.29994-1-pkshih@realtek.com>
References: <20230421024551.29994-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

From: Chia-Yuan Li <leo.li@realtek.com>

Since CFO XTAL registers of 8851B is different from 8852A, add a chip_info
field to define their difference. Other chips use another interface, so
fill NULL to this field.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  7 +++++++
 drivers/net/wireless/realtek/rtw89/phy.c      | 16 +++++++++-------
 drivers/net/wireless/realtek/rtw89/reg.h      |  6 ++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  7 +++++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  7 +++++++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 7 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 890ecb533372c..43ac7b65d8665 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3090,6 +3090,12 @@ struct rtw89_imr_info {
 	u32 tmac_imr_set;
 };
 
+struct rtw89_xtal_info {
+	u32 xcap_reg;
+	u32 sc_xo_mask;
+	u32 sc_xi_mask;
+};
+
 struct rtw89_rrsr_cfgs {
 	struct rtw89_reg3_def ref_rate;
 	struct rtw89_reg3_def rsc;
@@ -3216,6 +3222,7 @@ struct rtw89_chip_info {
 	u32 dma_ch_mask;
 	u32 edcca_lvl_reg;
 	const struct wiphy_wowlan_support *wowlan_stub;
+	const struct rtw89_xtal_info *xtal_info;
 };
 
 union rtw89_bus_info {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 96fa9f159d0ce..11611ba6c3ecd 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2342,27 +2342,29 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 
 static u8 rtw89_phy_cfo_get_xcap_reg(struct rtw89_dev *rtwdev, bool sc_xo)
 {
+	const struct rtw89_xtal_info *xtal = rtwdev->chip->xtal_info;
 	u32 reg_mask;
 
 	if (sc_xo)
-		reg_mask = B_AX_XTAL_SC_XO_MASK;
+		reg_mask = xtal->sc_xo_mask;
 	else
-		reg_mask = B_AX_XTAL_SC_XI_MASK;
+		reg_mask = xtal->sc_xi_mask;
 
-	return (u8)rtw89_read32_mask(rtwdev, R_AX_XTAL_ON_CTRL0, reg_mask);
+	return (u8)rtw89_read32_mask(rtwdev, xtal->xcap_reg, reg_mask);
 }
 
 static void rtw89_phy_cfo_set_xcap_reg(struct rtw89_dev *rtwdev, bool sc_xo,
 				       u8 val)
 {
+	const struct rtw89_xtal_info *xtal = rtwdev->chip->xtal_info;
 	u32 reg_mask;
 
 	if (sc_xo)
-		reg_mask = B_AX_XTAL_SC_XO_MASK;
+		reg_mask = xtal->sc_xo_mask;
 	else
-		reg_mask = B_AX_XTAL_SC_XI_MASK;
+		reg_mask = xtal->sc_xi_mask;
 
-	rtw89_write32_mask(rtwdev, R_AX_XTAL_ON_CTRL0, reg_mask, val);
+	rtw89_write32_mask(rtwdev, xtal->xcap_reg, reg_mask, val);
 }
 
 static void rtw89_phy_cfo_set_crystal_cap(struct rtw89_dev *rtwdev,
@@ -2375,7 +2377,7 @@ static void rtw89_phy_cfo_set_crystal_cap(struct rtw89_dev *rtwdev,
 	if (!force && cfo->crystal_cap == crystal_cap)
 		return;
 	crystal_cap = clamp_t(u8, crystal_cap, 0, 127);
-	if (chip->chip_id == RTL8852A) {
+	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8851B) {
 		rtw89_phy_cfo_set_xcap_reg(rtwdev, true, crystal_cap);
 		rtw89_phy_cfo_set_xcap_reg(rtwdev, false, crystal_cap);
 		sc_xo_val = rtw89_phy_cfo_get_xcap_reg(rtwdev, true);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 266e4231b5f34..733447d2a160e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -243,6 +243,12 @@
 #define B_AX_XTAL_SC_XI_MASK GENMASK(16, 10)
 #define B_AX_XTAL_SC_MASK GENMASK(6, 0)
 
+#define R_AX_XTAL_ON_CTRL3 0x028C
+#define B_AX_XTAL_SC_INIT_A_BLOCK_MASK GENMASK(30, 24)
+#define B_AX_XTAL_SC_LPS_A_BLOCK_MASK GENMASK(22, 16)
+#define B_AX_XTAL_SC_XO_A_BLOCK_MASK GENMASK(14, 8)
+#define B_AX_XTAL_SC_XI_A_BLOCK_MASK GENMASK(6, 0)
+
 #define R_AX_GPIO0_7_FUNC_SEL 0x02D0
 
 #define R_AX_EECS_EESK_FUNC_SEL 0x02D8
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index a67a43303592c..cc47bcbabfc97 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -18,6 +18,12 @@
 #define RTW8851B_MODULE_FIRMWARE \
 	RTW8851B_FW_BASENAME ".bin"
 
+static const struct rtw89_xtal_info rtw8851b_xtal_info = {
+	.xcap_reg		= R_AX_XTAL_ON_CTRL3,
+	.sc_xo_mask		= B_AX_XTAL_SC_XO_A_BLOCK_MASK,
+	.sc_xi_mask		= B_AX_XTAL_SC_XI_A_BLOCK_MASK,
+};
+
 static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.fem_setup		= NULL,
 	.fill_txdesc		= rtw89_core_fill_txdesc,
@@ -94,6 +100,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
 	.edcca_lvl_reg		= R_SEG0R_EDCCA_LVL_V1,
+	.xtal_info		= &rtw8851b_xtal_info,
 };
 EXPORT_SYMBOL(rtw8851b_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 1e1e6d0af5517..bd417c60171a0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -463,6 +463,12 @@ static const struct rtw89_imr_info rtw8852a_imr_info = {
 	.tmac_imr_set		= B_AX_TMAC_IMR_SET,
 };
 
+static const struct rtw89_xtal_info rtw8852a_xtal_info = {
+	.xcap_reg		= R_AX_XTAL_ON_CTRL0,
+	.sc_xo_mask		= B_AX_XTAL_SC_XO_MASK,
+	.sc_xi_mask		= B_AX_XTAL_SC_XI_MASK,
+};
+
 static const struct rtw89_rrsr_cfgs rtw8852a_rrsr_cfgs = {
 	.ref_rate = {R_AX_TRXPTCL_RRSR_CTL_0, B_AX_WMAC_RESP_REF_RATE_SEL, 0},
 	.rsc = {R_AX_TRXPTCL_RRSR_CTL_0, B_AX_WMAC_RESP_RSC_MASK, 2},
@@ -2160,6 +2166,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8852a,
 #endif
+	.xtal_info		= &rtw8852a_xtal_info,
 };
 EXPORT_SYMBOL(rtw8852a_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index f12d250f03127..af74d0feeccb9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2599,6 +2599,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8852b,
 #endif
+	.xtal_info		= NULL,
 };
 EXPORT_SYMBOL(rtw8852b_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 347a19b8eaa05..3268be8fea6cc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2898,6 +2898,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8852c,
 #endif
+	.xtal_info		= NULL,
 };
 EXPORT_SYMBOL(rtw8852c_chip_info);
 
-- 
2.25.1

