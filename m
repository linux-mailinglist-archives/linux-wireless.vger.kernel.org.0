Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D23C7C9FF5
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 08:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjJPGwD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 02:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjJPGwA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 02:52:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDD5DC
        for <linux-wireless@vger.kernel.org>; Sun, 15 Oct 2023 23:51:55 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39G6pk0cB2264240, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39G6pk0cB2264240
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 14:51:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 16 Oct 2023 14:51:47 +0800
Received: from [127.0.1.1] (172.21.71.113) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 16 Oct
 2023 14:51:45 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <cj.hsieh@realtek.com>, <hsuan8331@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/5] wifi: rtw89: phy: generalize valid bit of BSS color
Date:   Mon, 16 Oct 2023 14:51:12 +0800
Message-ID: <20231016065115.751662-3-pkshih@realtek.com>
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

The register fields of BSS color map and valid bit are in the same register
for existing chips, but coming WiFi 7 chips define another register to
set valid bit, so add a field to chip_info to reuse the code.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 1 +
 drivers/net/wireless/realtek/rtw89/phy.c      | 3 ++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 1 +
 6 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ef63fc20db71..91e4d4e79eea 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3711,6 +3711,7 @@ struct rtw89_chip_info {
 	u8 dcfo_comp_sft;
 	const struct rtw89_imr_info *imr_info;
 	const struct rtw89_rrsr_cfgs *rrsr_cfgs;
+	struct rtw89_reg_def bss_clr_vld;
 	u32 bss_clr_map_reg;
 	u32 dma_ch_mask;
 	u32 edcca_lvl_reg;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 8a306a86f1f0..c0c24584e930 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4636,6 +4636,7 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_reg_def *bss_clr_vld = &chip->bss_clr_vld;
 	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
 	u8 bss_color;
 
@@ -4644,7 +4645,7 @@ void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif
 
 	bss_color = vif->bss_conf.he_bss_color.color;
 
-	rtw89_phy_write32_idx(rtwdev, chip->bss_clr_map_reg, B_BSS_CLR_MAP_VLD0, 0x1,
+	rtw89_phy_write32_idx(rtwdev, bss_clr_vld->addr, bss_clr_vld->mask, 0x1,
 			      phy_idx);
 	rtw89_phy_write32_idx(rtwdev, chip->bss_clr_map_reg, B_BSS_CLR_MAP_TGT,
 			      bss_color, phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 491980eb8e2e..50522ff85003 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2438,6 +2438,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.dcfo_comp_sft		= 12,
 	.imr_info		= &rtw8851b_imr_info,
 	.rrsr_cfgs		= &rtw8851b_rrsr_cfgs,
+	.bss_clr_vld		= {R_BSS_CLR_MAP_V1, B_BSS_CLR_MAP_VLD0},
 	.bss_clr_map_reg	= R_BSS_CLR_MAP_V1,
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 385655c061db..0c36e6180e25 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2175,6 +2175,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.dcfo_comp_sft		= 10,
 	.imr_info		= &rtw8852a_imr_info,
 	.rrsr_cfgs		= &rtw8852a_rrsr_cfgs,
+	.bss_clr_vld		= {R_BSS_CLR_MAP, B_BSS_CLR_MAP_VLD0},
 	.bss_clr_map_reg	= R_BSS_CLR_MAP,
 	.dma_ch_mask		= 0,
 	.edcca_lvl_reg		= R_SEG0R_EDCCA_LVL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 93233217b57a..9d4e6f08218d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2609,6 +2609,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.dcfo_comp_sft		= 10,
 	.imr_info		= &rtw8852b_imr_info,
 	.rrsr_cfgs		= &rtw8852b_rrsr_cfgs,
+	.bss_clr_vld		= {R_BSS_CLR_MAP_V1, B_BSS_CLR_MAP_VLD0},
 	.bss_clr_map_reg	= R_BSS_CLR_MAP_V1,
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 7f7057e74417..3b7d8ab39bab 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2924,6 +2924,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dcfo_comp_sft		= 12,
 	.imr_info		= &rtw8852c_imr_info,
 	.rrsr_cfgs		= &rtw8852c_rrsr_cfgs,
+	.bss_clr_vld		= {R_BSS_CLR_MAP, B_BSS_CLR_MAP_VLD0},
 	.bss_clr_map_reg	= R_BSS_CLR_MAP,
 	.dma_ch_mask		= 0,
 	.edcca_lvl_reg		= R_SEG0R_EDCCA_LVL,
-- 
2.25.1

