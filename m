Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06576D0684
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 15:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjC3NZW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 09:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjC3NZO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 09:25:14 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B63B47C
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 06:25:11 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32UDOjRwA012536, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32UDOjRwA012536
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 30 Mar 2023 21:24:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 30 Mar 2023 21:25:03 +0800
Received: from localhost (172.16.16.62) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 30 Mar
 2023 21:25:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: use hardware CFO to improve performance
Date:   Thu, 30 Mar 2023 21:23:52 +0800
Message-ID: <20230330132352.13647-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.62]
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
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Eric Huang <echuang@realtek.com>

Turn on hardware CFO (central frequency offset) compensation based on IC
capability, and improve digital CFO compensation accuracy by using
more fixed points number.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  3 ++
 drivers/net/wireless/realtek/rtw89/phy.c      | 28 +++++++++++++------
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  3 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  3 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  3 +-
 5 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e447bfec508b8..519ddff79dc7a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3120,6 +3120,7 @@ struct rtw89_chip_info {
 	const u32 *c2h_regs;
 	const struct rtw89_page_regs *page_regs;
 	bool cfo_src_fd;
+	bool cfo_hw_comp;
 	const struct rtw89_reg_def *dcfo_comp;
 	u8 dcfo_comp_sft;
 	const struct rtw89_imr_info *imr_info;
@@ -3590,6 +3591,8 @@ struct rtw89_cfo_tracking_info {
 	s32 cfo_avg_pre;
 	s32 cfo_avg[CFO_TRACK_MAX_USER];
 	s32 pre_cfo_avg[CFO_TRACK_MAX_USER];
+	s32 dcfo_avg;
+	s32 dcfo_avg_pre;
 	u32 packet_count;
 	u32 packet_count_pre;
 	s32 residual_cfo_acc;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d8b035972dd48..3c70a79ae62c5 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2405,7 +2405,6 @@ static void rtw89_dcfo_comp(struct rtw89_dev *rtwdev, s32 curr_cfo)
 	bool is_linked = rtwdev->total_sta_assoc > 0;
 	s32 cfo_avg_312;
 	s32 dcfo_comp_val;
-	u8 dcfo_comp_sft = rtwdev->chip->dcfo_comp_sft;
 	int sign;
 
 	if (!is_linked) {
@@ -2418,8 +2417,8 @@ static void rtw89_dcfo_comp(struct rtw89_dev *rtwdev, s32 curr_cfo)
 		return;
 	dcfo_comp_val = rtw89_phy_read32_mask(rtwdev, R_DCFO, B_DCFO);
 	sign = curr_cfo > 0 ? 1 : -1;
-	cfo_avg_312 = (curr_cfo << dcfo_comp_sft) / 5 + sign * dcfo_comp_val;
-	rtw89_debug(rtwdev, RTW89_DBG_CFO, "DCFO: avg_cfo=%d\n", cfo_avg_312);
+	cfo_avg_312 = curr_cfo / 625 + sign * dcfo_comp_val;
+	rtw89_debug(rtwdev, RTW89_DBG_CFO, "avg_cfo_312=%d step\n", cfo_avg_312);
 	if (rtwdev->chip->chip_id == RTL8852A && rtwdev->hal.cv == CHIP_CBV)
 		cfo_avg_312 = -cfo_avg_312;
 	rtw89_phy_set_phy_regs(rtwdev, dcfo_comp->addr, dcfo_comp->mask,
@@ -2428,9 +2427,16 @@ static void rtw89_dcfo_comp(struct rtw89_dev *rtwdev, s32 curr_cfo)
 
 static void rtw89_dcfo_comp_init(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
 	rtw89_phy_set_phy_regs(rtwdev, R_DCFO_OPT, B_DCFO_OPT_EN, 1);
 	rtw89_phy_set_phy_regs(rtwdev, R_DCFO_WEIGHT, B_DCFO_WEIGHT_MSK, 8);
-	rtw89_write32_clr(rtwdev, R_AX_PWR_UL_CTRL2, B_AX_PWR_UL_CFO_MASK);
+
+	if (chip->cfo_hw_comp)
+		rtw89_write32_mask(rtwdev, R_AX_PWR_UL_CTRL2,
+				   B_AX_PWR_UL_CFO_MASK, 0x6);
+	else
+		rtw89_write32_clr(rtwdev, R_AX_PWR_UL_CTRL2, B_AX_PWR_UL_CFO_MASK);
 }
 
 static void rtw89_phy_cfo_init(struct rtw89_dev *rtwdev)
@@ -2500,6 +2506,7 @@ static void rtw89_phy_cfo_crystal_cap_adjust(struct rtw89_dev *rtwdev,
 
 static s32 rtw89_phy_average_cfo_calc(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_cfo_tracking_info *cfo = &rtwdev->cfo_tracking;
 	s32 cfo_khz_all = 0;
 	s32 cfo_cnt_all = 0;
@@ -2516,6 +2523,8 @@ static s32 rtw89_phy_average_cfo_calc(struct rtw89_dev *rtwdev)
 		cfo_cnt_all += cfo->cfo_cnt[i];
 		cfo_all_avg = phy_div(cfo_khz_all, cfo_cnt_all);
 		cfo->pre_cfo_avg[i] = cfo->cfo_avg[i];
+		cfo->dcfo_avg = phy_div(cfo_khz_all << chip->dcfo_comp_sft,
+					cfo_cnt_all);
 	}
 	rtw89_debug(rtwdev, RTW89_DBG_CFO,
 		    "CFO track for macid = %d\n", i);
@@ -2642,7 +2651,9 @@ static void rtw89_phy_cfo_dm(struct rtw89_dev *rtwdev)
 	s32 new_cfo = 0;
 	bool x_cap_update = false;
 	u8 pre_x_cap = cfo->crystal_cap;
+	u8 dcfo_comp_sft = rtwdev->chip->dcfo_comp_sft;
 
+	cfo->dcfo_avg = 0;
 	rtw89_debug(rtwdev, RTW89_DBG_CFO, "CFO:total_sta_assoc=%d\n",
 		    rtwdev->total_sta_assoc);
 	if (rtwdev->total_sta_assoc == 0) {
@@ -2684,18 +2695,19 @@ static void rtw89_phy_cfo_dm(struct rtw89_dev *rtwdev)
 
 	rtw89_phy_cfo_crystal_cap_adjust(rtwdev, new_cfo);
 	cfo->cfo_avg_pre = new_cfo;
+	cfo->dcfo_avg_pre = cfo->dcfo_avg;
 	x_cap_update =  cfo->crystal_cap != pre_x_cap;
 	rtw89_debug(rtwdev, RTW89_DBG_CFO, "Xcap_up=%d\n", x_cap_update);
 	rtw89_debug(rtwdev, RTW89_DBG_CFO, "Xcap: D:%x C:%x->%x, ofst=%d\n",
 		    cfo->def_x_cap, pre_x_cap, cfo->crystal_cap,
 		    cfo->x_cap_ofst);
 	if (x_cap_update) {
-		if (new_cfo > 0)
-			new_cfo -= CFO_SW_COMP_FINE_TUNE;
+		if (cfo->dcfo_avg > 0)
+			cfo->dcfo_avg -= CFO_SW_COMP_FINE_TUNE << dcfo_comp_sft;
 		else
-			new_cfo += CFO_SW_COMP_FINE_TUNE;
+			cfo->dcfo_avg += CFO_SW_COMP_FINE_TUNE << dcfo_comp_sft;
 	}
-	rtw89_dcfo_comp(rtwdev, new_cfo);
+	rtw89_dcfo_comp(rtwdev, cfo->dcfo_avg);
 	rtw89_phy_cfo_statistics_reset(rtwdev);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 9c42b6abd2232..8f54394660033 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2136,8 +2136,9 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.c2h_regs		= rtw8852a_c2h_regs,
 	.page_regs		= &rtw8852a_page_regs,
 	.cfo_src_fd		= false,
+	.cfo_hw_comp            = false,
 	.dcfo_comp		= &rtw8852a_dcfo_comp,
-	.dcfo_comp_sft		= 3,
+	.dcfo_comp_sft		= 10,
 	.imr_info		= &rtw8852a_imr_info,
 	.rrsr_cfgs		= &rtw8852a_rrsr_cfgs,
 	.bss_clr_map_reg	= R_BSS_CLR_MAP,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 499ae0389c715..2b515adf7efa6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2513,8 +2513,9 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.c2h_regs		= rtw8852b_c2h_regs,
 	.page_regs		= &rtw8852b_page_regs,
 	.cfo_src_fd		= true,
+	.cfo_hw_comp		= true,
 	.dcfo_comp		= &rtw8852b_dcfo_comp,
-	.dcfo_comp_sft		= 3,
+	.dcfo_comp_sft		= 10,
 	.imr_info		= &rtw8852b_imr_info,
 	.rrsr_cfgs		= &rtw8852b_rrsr_cfgs,
 	.bss_clr_map_reg	= R_BSS_CLR_MAP_V1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 8af813132f71d..1c9f95c35864b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2872,8 +2872,9 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.c2h_regs		= rtw8852c_c2h_regs,
 	.page_regs		= &rtw8852c_page_regs,
 	.cfo_src_fd		= false,
+	.cfo_hw_comp            = false,
 	.dcfo_comp		= &rtw8852c_dcfo_comp,
-	.dcfo_comp_sft		= 5,
+	.dcfo_comp_sft		= 12,
 	.imr_info		= &rtw8852c_imr_info,
 	.rrsr_cfgs		= &rtw8852c_rrsr_cfgs,
 	.bss_clr_map_reg	= R_BSS_CLR_MAP,
-- 
2.25.1

