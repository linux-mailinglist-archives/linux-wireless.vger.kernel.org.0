Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7636C4298
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 07:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCVGEf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 02:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVGEe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 02:04:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FE5298D9
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 23:04:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32M644oK4025078, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32M644oK4025078
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 22 Mar 2023 14:04:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 22 Mar 2023 14:03:40 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 22 Mar
 2023 14:03:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: config EDCCA threshold during scan to prevent TX failed
Date:   Wed, 22 Mar 2023 14:02:38 +0800
Message-ID: <20230322060238.43922-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

From: Chih-Kang Chang <gary.chang@realtek.com>

Need to configure EDCCA threshold to default value before scan, and recall
original value after scan to prevent probe request can't be sent out.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  2 ++
 drivers/net/wireless/realtek/rtw89/core.h     |  3 +++
 drivers/net/wireless/realtek/rtw89/phy.c      | 19 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |  1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  5 +++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 8 files changed, 33 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 489fa7a86160d..f1b8fd8e30eab 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3245,6 +3245,7 @@ void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	rtw89_btc_ntfy_scan_start(rtwdev, RTW89_PHY_0, chan->band_type);
 	rtw89_chip_rfk_scan(rtwdev, true);
 	rtw89_hci_recalc_int_mit(rtwdev);
+	rtw89_phy_config_edcca(rtwdev, true);
 
 	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, mac_addr);
 }
@@ -3262,6 +3263,7 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 
 	rtw89_chip_rfk_scan(rtwdev, false);
 	rtw89_btc_ntfy_scan_finish(rtwdev, RTW89_PHY_0);
+	rtw89_phy_config_edcca(rtwdev, false);
 
 	rtwdev->scanning = false;
 	rtwdev->dig.bypass_dig = true;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e447bfec508b8..a981660234dad 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3126,6 +3126,7 @@ struct rtw89_chip_info {
 	const struct rtw89_rrsr_cfgs *rrsr_cfgs;
 	u32 bss_clr_map_reg;
 	u32 dma_ch_mask;
+	u32 edcca_lvl_reg;
 	const struct wiphy_wowlan_support *wowlan_stub;
 };
 
@@ -3335,6 +3336,8 @@ struct rtw89_hal {
 
 	bool entity_active;
 	enum rtw89_entity_mode entity_mode;
+
+	u32 edcca_bak;
 };
 
 #define RTW89_MAX_MAC_ID_NUM 128
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d8b035972dd48..cb0f6cc51d6bc 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4366,3 +4366,22 @@ void rtw89_decode_chan_idx(struct rtw89_dev *rtwdev, u8 chan_idx,
 	*ch = rtw89_ch_base_table[idx] + (offset << 1);
 }
 EXPORT_SYMBOL(rtw89_decode_chan_idx);
+
+#define EDCCA_DEFAULT 249
+void rtw89_phy_config_edcca(struct rtw89_dev *rtwdev, bool scan)
+{
+	u32 reg = rtwdev->chip->edcca_lvl_reg;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u32 val;
+
+	if (scan) {
+		hal->edcca_bak = rtw89_phy_read32(rtwdev, reg);
+		val = hal->edcca_bak;
+		u32p_replace_bits(&val, EDCCA_DEFAULT, B_SEG0R_EDCCA_LVL_A_MSK);
+		u32p_replace_bits(&val, EDCCA_DEFAULT, B_SEG0R_EDCCA_LVL_P_MSK);
+		u32p_replace_bits(&val, EDCCA_DEFAULT, B_SEG0R_PPDU_LVL_MSK);
+		rtw89_phy_write32(rtwdev, reg, val);
+	} else {
+		rtw89_phy_write32(rtwdev, reg, hal->edcca_bak);
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index de0a9abf646e3..7535867d0f484 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -558,5 +558,6 @@ void rtw89_phy_ul_tb_ctrl_track(struct rtw89_dev *rtwdev);
 u8 rtw89_encode_chan_idx(struct rtw89_dev *rtwdev, u8 central_ch, u8 band);
 void rtw89_decode_chan_idx(struct rtw89_dev *rtwdev, u8 chan_idx,
 			   u8 *ch, enum nl80211_band *band);
+void rtw89_phy_config_edcca(struct rtw89_dev *rtwdev, bool scan);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index e5c0ab43ab7a0..fa3e5bea09bf2 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4275,6 +4275,11 @@
 #define B_PKT_POP_EN BIT(8)
 #define R_SEG0R_PD 0x481C
 #define R_SEG0R_PD_V1 0x4860
+#define R_SEG0R_EDCCA_LVL 0x4840
+#define R_SEG0R_EDCCA_LVL_V1 0x4884
+#define B_SEG0R_PPDU_LVL_MSK GENMASK(31, 24)
+#define B_SEG0R_EDCCA_LVL_P_MSK GENMASK(15, 8)
+#define B_SEG0R_EDCCA_LVL_A_MSK GENMASK(7, 0)
 #define B_SEG0R_PD_SPATIAL_REUSE_EN_MSK_V1 BIT(30)
 #define B_SEG0R_PD_SPATIAL_REUSE_EN_MSK BIT(29)
 #define B_SEG0R_PD_LOWER_BOUND_MSK GENMASK(10, 6)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 9c42b6abd2232..7858bd1d35cae 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2142,6 +2142,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.rrsr_cfgs		= &rtw8852a_rrsr_cfgs,
 	.bss_clr_map_reg	= R_BSS_CLR_MAP,
 	.dma_ch_mask		= 0,
+	.edcca_lvl_reg		= R_SEG0R_EDCCA_LVL,
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8852a,
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 499ae0389c715..a26c55904cda0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2521,6 +2521,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
+	.edcca_lvl_reg		= R_SEG0R_EDCCA_LVL_V1,
 };
 EXPORT_SYMBOL(rtw8852b_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 8af813132f71d..dc6067d06aa08 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2878,6 +2878,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.rrsr_cfgs		= &rtw8852c_rrsr_cfgs,
 	.bss_clr_map_reg	= R_BSS_CLR_MAP,
 	.dma_ch_mask		= 0,
+	.edcca_lvl_reg		= R_SEG0R_EDCCA_LVL,
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8852c,
 #endif
-- 
2.25.1

