Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA327C9FF7
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 08:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjJPGwE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 02:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjJPGwA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 02:52:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32273E4
        for <linux-wireless@vger.kernel.org>; Sun, 15 Oct 2023 23:51:55 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39G6pmAfB2264243, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39G6pmAfB2264243
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 14:51:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 16 Oct 2023 14:51:47 +0800
Received: from [127.0.1.1] (172.21.71.113) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 16 Oct
 2023 14:51:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <cj.hsieh@realtek.com>, <hsuan8331@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/5] wifi: rtw89: modify the register setting and the flow of CFO tracking
Date:   Mon, 16 Oct 2023 14:51:13 +0800
Message-ID: <20231016065115.751662-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016065115.751662-1-pkshih@realtek.com>
References: <20231016065115.751662-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.71.113]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
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

From: Cheng-Chieh Hsieh <cj.hsieh@realtek.com>

The register address used for CFO(carrier frequency offset) tracking is
different from WiFi 7 series, so we change the way to access it. And we
refine the flow of CFO tracking to compatible all WiFi 7 and 6 ICs.

Signed-off-by: Cheng-Chieh Hsieh <cj.hsieh@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c    | 32 +++++++++++++++------
 drivers/net/wireless/realtek/rtw89/phy.h    |  8 ++++++
 drivers/net/wireless/realtek/rtw89/phy_be.c |  8 ++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |  4 +++
 4 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c0c24584e930..c7d8faa6265c 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2557,6 +2557,9 @@ static void rtw89_dcfo_comp(struct rtw89_dev *rtwdev, s32 curr_cfo)
 	s32 dcfo_comp_val;
 	int sign;
 
+	if (rtwdev->chip->chip_id == RTL8922A)
+		return;
+
 	if (!is_linked) {
 		rtw89_debug(rtwdev, RTW89_DBG_CFO, "DCFO: is_linked=%d\n",
 			    is_linked);
@@ -2577,16 +2580,21 @@ static void rtw89_dcfo_comp(struct rtw89_dev *rtwdev, s32 curr_cfo)
 
 static void rtw89_dcfo_comp_init(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_cfo_regs *cfo = phy->cfo;
 
-	rtw89_phy_set_phy_regs(rtwdev, R_DCFO_OPT, B_DCFO_OPT_EN, 1);
-	rtw89_phy_set_phy_regs(rtwdev, R_DCFO_WEIGHT, B_DCFO_WEIGHT_MSK, 8);
+	rtw89_phy_set_phy_regs(rtwdev, cfo->comp_seg0, cfo->valid_0_mask, 1);
+	rtw89_phy_set_phy_regs(rtwdev, cfo->comp, cfo->weighting_mask, 8);
 
-	if (chip->cfo_hw_comp)
-		rtw89_write32_mask(rtwdev, R_AX_PWR_UL_CTRL2,
-				   B_AX_PWR_UL_CFO_MASK, 0x6);
-	else
-		rtw89_write32_clr(rtwdev, R_AX_PWR_UL_CTRL2, B_AX_PWR_UL_CFO_MASK);
+	if (chip->chip_gen == RTW89_CHIP_AX) {
+		if (chip->cfo_hw_comp)
+			rtw89_write32_mask(rtwdev, R_AX_PWR_UL_CTRL2,
+					   B_AX_PWR_UL_CFO_MASK, 0x6);
+		else
+			rtw89_write32_clr(rtwdev, R_AX_PWR_UL_CTRL2,
+					  B_AX_PWR_UL_CFO_MASK);
+	}
 }
 
 static void rtw89_phy_cfo_init(struct rtw89_dev *rtwdev)
@@ -2630,7 +2638,7 @@ static void rtw89_phy_cfo_crystal_cap_adjust(struct rtw89_dev *rtwdev,
 		if (cfo_abs > CFO_TRK_ENABLE_TH)
 			cfo->is_adjust = true;
 	} else {
-		if (cfo_abs < CFO_TRK_STOP_TH)
+		if (cfo_abs <= CFO_TRK_STOP_TH)
 			cfo->is_adjust = false;
 	}
 	if (!cfo->is_adjust) {
@@ -4966,10 +4974,18 @@ static const struct rtw89_physts_regs rtw89_physts_regs_ax = {
 	.dis_trigger_brk_mask = B_STS_DIS_TRIG_BY_BRK,
 };
 
+static const struct rtw89_cfo_regs rtw89_cfo_regs_ax = {
+	.comp = R_DCFO_WEIGHT,
+	.weighting_mask = B_DCFO_WEIGHT_MSK,
+	.comp_seg0 = R_DCFO_OPT,
+	.valid_0_mask = B_DCFO_OPT_EN,
+};
+
 const struct rtw89_phy_gen_def rtw89_phy_gen_ax = {
 	.cr_base = 0x10000,
 	.ccx = &rtw89_ccx_regs_ax,
 	.physts = &rtw89_physts_regs_ax,
+	.cfo = &rtw89_cfo_regs_ax,
 
 	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_ax,
 	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 02521d984c9b..5c85122e7bb5 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -405,6 +405,13 @@ struct rtw89_physts_regs {
 	u32 dis_trigger_brk_mask;
 };
 
+struct rtw89_cfo_regs {
+	u32 comp;
+	u32 weighting_mask;
+	u32 comp_seg0;
+	u32 valid_0_mask;
+};
+
 enum rtw89_bandwidth_section_num_ax {
 	RTW89_BW20_SEC_NUM_AX = 8,
 	RTW89_BW40_SEC_NUM_AX = 4,
@@ -475,6 +482,7 @@ struct rtw89_phy_gen_def {
 	u32 cr_base;
 	const struct rtw89_ccx_regs *ccx;
 	const struct rtw89_physts_regs *physts;
+	const struct rtw89_cfo_regs *cfo;
 
 	void (*set_txpwr_byrate)(struct rtw89_dev *rtwdev,
 				 const struct rtw89_chan *chan,
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index f0e1da2c2a91..63eeeea72b68 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -71,6 +71,13 @@ static const struct rtw89_physts_regs rtw89_physts_regs_be = {
 	.dis_trigger_brk_mask = B_STS_DIS_TRIG_BY_BRK,
 };
 
+static const struct rtw89_cfo_regs rtw89_cfo_regs_be = {
+	.comp = R_DCFO_WEIGHT_V1,
+	.weighting_mask = B_DCFO_WEIGHT_MSK_V1,
+	.comp_seg0 = R_DCFO_OPT_V1,
+	.valid_0_mask = B_DCFO_OPT_EN_V1,
+};
+
 struct rtw89_byr_spec_ent_be {
 	struct rtw89_rate_desc init;
 	u8 num_of_idx;
@@ -636,6 +643,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 	.cr_base = 0x20000,
 	.ccx = &rtw89_ccx_regs_be,
 	.physts = &rtw89_physts_regs_be,
+	.cfo = &rtw89_cfo_regs_be,
 
 	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_be,
 	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 2bf3c1bed6a2..ccd5481e8a3d 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -5035,6 +5035,10 @@
 #define B_S0_DACKQ7_K GENMASK(15, 8)
 #define R_S0_DACKQ8 0x5E98
 #define B_S0_DACKQ8_K GENMASK(15, 8)
+#define R_DCFO_WEIGHT_V1 0x6244
+#define B_DCFO_WEIGHT_MSK_V1 GENMASK(31, 28)
+#define R_DCFO_OPT_V1 0x6260
+#define B_DCFO_OPT_EN_V1 BIT(17)
 #define R_RPL_BIAS_COMP1 0x6DF0
 #define B_RPL_BIAS_COMP1_MASK GENMASK(7, 0)
 #define R_P1_TSSI_ALIM1 0x7630
-- 
2.25.1

