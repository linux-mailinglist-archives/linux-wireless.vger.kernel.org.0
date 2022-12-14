Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E8B64C5B7
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 10:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbiLNJTf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 04:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237923AbiLNJT0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 04:19:26 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FD4A1AF1A
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 01:19:21 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BE9IHEn8030266, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BE9IHEn8030266
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 14 Dec 2022 17:18:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Wed, 14 Dec 2022 17:19:06 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 14 Dec
 2022 17:19:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: 8852b: update BSS color mapping register
Date:   Wed, 14 Dec 2022 17:18:03 +0800
Message-ID: <20221214091803.41293-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 12/14/2022 08:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzE0IKRXpMggMDc6NDI6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Eric Huang <echuang@realtek.com>

BSS color mapping register is different per IC, therefore, move this
register to chip_info and update the setting function. Without this patch,
wrong BSS color causes behavior abnormal, especially DL-OFDMA.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 1 +
 drivers/net/wireless/realtek/rtw89/phy.c      | 9 +++++----
 drivers/net/wireless/realtek/rtw89/reg.h      | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 1 +
 6 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2badb96d2ae35..5a0a154d7bc7a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2771,6 +2771,7 @@ struct rtw89_chip_info {
 	u8 dcfo_comp_sft;
 	const struct rtw89_imr_info *imr_info;
 	const struct rtw89_rrsr_cfgs *rrsr_cfgs;
+	u32 bss_clr_map_reg;
 	u32 dma_ch_mask;
 	const struct wiphy_wowlan_support *wowlan_stub;
 };
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 017710c580c72..0f7b2b39604a0 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4116,6 +4116,7 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 
 void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
 	u8 bss_color;
 
@@ -4124,11 +4125,11 @@ void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif
 
 	bss_color = vif->bss_conf.he_bss_color.color;
 
-	rtw89_phy_write32_idx(rtwdev, R_BSS_CLR_MAP, B_BSS_CLR_MAP_VLD0, 0x1,
-			      phy_idx);
-	rtw89_phy_write32_idx(rtwdev, R_BSS_CLR_MAP, B_BSS_CLR_MAP_TGT, bss_color,
+	rtw89_phy_write32_idx(rtwdev, chip->bss_clr_map_reg, B_BSS_CLR_MAP_VLD0, 0x1,
 			      phy_idx);
-	rtw89_phy_write32_idx(rtwdev, R_BSS_CLR_MAP, B_BSS_CLR_MAP_STAID,
+	rtw89_phy_write32_idx(rtwdev, chip->bss_clr_map_reg, B_BSS_CLR_MAP_TGT,
+			      bss_color, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, chip->bss_clr_map_reg, B_BSS_CLR_MAP_STAID,
 			      vif->cfg.aid, phy_idx);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 5324e645728bb..9958c095aba11 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4096,6 +4096,7 @@
 #define R_SEG0CSI_EN 0x42C4
 #define B_SEG0CSI_EN BIT(23)
 #define R_BSS_CLR_MAP 0x43ac
+#define R_BSS_CLR_MAP_V1 0x43B0
 #define B_BSS_CLR_MAP_VLD0 BIT(28)
 #define B_BSS_CLR_MAP_TGT GENMASK(27, 22)
 #define B_BSS_CLR_MAP_STAID GENMASK(21, 11)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index eff6519cf0191..5d79e609b5063 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2149,6 +2149,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.dcfo_comp_sft		= 3,
 	.imr_info		= &rtw8852a_imr_info,
 	.rrsr_cfgs		= &rtw8852a_rrsr_cfgs,
+	.bss_clr_map_reg	= R_BSS_CLR_MAP,
 	.dma_ch_mask		= 0,
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8852a,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index b635ac1d1ca2f..cb71d6766ed7d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2525,6 +2525,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.dcfo_comp_sft		= 3,
 	.imr_info		= &rtw8852b_imr_info,
 	.rrsr_cfgs		= &rtw8852b_rrsr_cfgs,
+	.bss_clr_map_reg	= R_BSS_CLR_MAP_V1,
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index a87482cc25f58..f5f01ff867202 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2959,6 +2959,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dcfo_comp_sft		= 5,
 	.imr_info		= &rtw8852c_imr_info,
 	.rrsr_cfgs		= &rtw8852c_rrsr_cfgs,
+	.bss_clr_map_reg	= R_BSS_CLR_MAP,
 	.dma_ch_mask		= 0,
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8852c,
-- 
2.25.1

