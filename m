Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209C3296C38
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Oct 2020 11:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461606AbgJWJih (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Oct 2020 05:38:37 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45977 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461598AbgJWJig (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Oct 2020 05:38:36 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 09N9cUHR1024657, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 09N9cUHR1024657
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Oct 2020 17:38:30 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 23 Oct 2020 17:38:29 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 01/11] rtw88: coex: fixed some wrong register definition and setting
Date:   Fri, 23 Oct 2020 17:37:32 +0800
Message-ID: <20201023093742.29908-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201023093742.29908-1-pkshih@realtek.com>
References: <20201023093742.29908-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB06.realtek.com.tw (172.21.6.99) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Some register definition and bit definition were incorrect.
e.g. REG_BT_COEX_V2 should be word alignment to meet the coding style.
e.g. set REG_BT_TDMA_TIME[5:0]=0x5,
But the original is to set REG_BT_TDMA_TIME[7:0]=0x5.
This will cause unexpected hardware behavior.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/reg.h      |  7 ++++---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  4 ++--
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  3 +--
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |  2 --
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  6 +++---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 10 +++++-----
 6 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 86b94c008a27..b3df09ff01b3 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -60,7 +60,7 @@
 #define REG_GPIO_MUXCFG		0x0040
 #define BIT_FSPI_EN		BIT(19)
 #define BIT_EN_SIC		BIT(12)
-#define BIT_BT_AOD_GPIO3	BIT(9)
+
 #define BIT_PO_BT_PTA_PINS	BIT(9)
 #define BIT_BT_PTA_EN		BIT(5)
 #define BIT_WLRFE_4_5_EN	BIT(2)
@@ -463,11 +463,12 @@
 #define REG_BT_COEX_TABLE_H3	0x06CF
 #define REG_BBPSF_CTRL		0x06DC
 
-#define REG_BT_COEX_V2		0x0763
-#define BIT_GNT_BT_POLARITY	BIT(4)
+#define REG_BT_COEX_V2		0x0762
+#define BIT_GNT_BT_POLARITY	BIT(12)
 #define BIT_LTE_COEX_EN		BIT(7)
 #define REG_BT_STAT_CTRL	0x0778
 #define REG_BT_TDMA_TIME	0x0790
+#define BIT_MASK_SAMPLE_RATE	GENMASK(5, 0)
 #define REG_LTR_IDLE_LATENCY	0x0798
 #define REG_LTR_ACTIVE_LATENCY	0x079C
 #define REG_LTR_CTRL_BASIC	0x07A4
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 3ddd170f1651..01768fec4426 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1506,14 +1506,14 @@ static void rtw8723d_coex_cfg_init(struct rtw_dev *rtwdev)
 
 	/* BT report packet sample rate	 */
 	/* 0x790[5:0]=0x5 */
-	rtw_write8_set(rtwdev, REG_BT_TDMA_TIME, 0x05);
+	rtw_write8_mask(rtwdev, REG_BT_TDMA_TIME, BIT_MASK_SAMPLE_RATE, 0x5);
 
 	/* enable BT counter statistics */
 	rtw_write8(rtwdev, REG_BT_STAT_CTRL, 0x1);
 
 	/* enable PTA (3-wire function form BT side) */
 	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_BT_PTA_EN);
-	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_BT_AOD_GPIO3);
+	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_PO_BT_PTA_PINS);
 
 	/* enable PTA (tx/rx signal form WiFi side) */
 	rtw_write8_set(rtwdev, REG_QUEUE_CTRL, BIT_PTA_WL_TX_EN);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index da2e7415be8f..64b14f9ea4a9 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -656,8 +656,7 @@ static void rtw8821c_coex_cfg_init(struct rtw_dev *rtwdev)
 	rtw_write8_set(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
 
 	/* BT report packet sample rate */
-	rtw_write8_mask(rtwdev, REG_BT_TDMA_TIME, SAMPLE_RATE_MASK,
-			SAMPLE_RATE);
+	rtw_write8_mask(rtwdev, REG_BT_TDMA_TIME, BIT_MASK_SAMPLE_RATE, 0x5);
 
 	/* enable BT counter statistics */
 	rtw_write8(rtwdev, REG_BT_STAT_CTRL, BT_CNT_ENABLE);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.h b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
index bd01e82b6bcd..e11e3fc41c95 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
@@ -231,8 +231,6 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define REG_IQKFAILMSK	0x1bf0
 #define BIT_MASK_R_RFE_SEL_15	GENMASK(31, 28)
 #define BIT_SDIO_INT BIT(18)
-#define SAMPLE_RATE_MASK GENMASK(5, 0)
-#define SAMPLE_RATE	0x5
 #define BT_CNT_ENABLE	0x1
 #define BIT_BCN_QUEUE	BIT(3)
 #define BCN_PRI_EN	0x1
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 22d0dd640ac9..908f552c7c9d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1120,21 +1120,21 @@ static void rtw8822b_coex_cfg_init(struct rtw_dev *rtwdev)
 
 	/* BT report packet sample rate */
 	/* 0x790[5:0]=0x5 */
-	rtw_write8_set(rtwdev, REG_BT_TDMA_TIME, 0x05);
+	rtw_write8_mask(rtwdev, REG_BT_TDMA_TIME, BIT_MASK_SAMPLE_RATE, 0x5);
 
 	/* enable BT counter statistics */
 	rtw_write8(rtwdev, REG_BT_STAT_CTRL, 0x1);
 
 	/* enable PTA (3-wire function form BT side) */
 	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_BT_PTA_EN);
-	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_BT_AOD_GPIO3);
+	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_PO_BT_PTA_PINS);
 
 	/* enable PTA (tx/rx signal form WiFi side) */
 	rtw_write8_set(rtwdev, REG_QUEUE_CTRL, BIT_PTA_WL_TX_EN);
 	/* wl tx signal to PTA not case EDCCA */
 	rtw_write8_clr(rtwdev, REG_QUEUE_CTRL, BIT_PTA_EDCCA_EN);
 	/* GNT_BT=1 while select both */
-	rtw_write8_set(rtwdev, REG_BT_COEX_V2, BIT_GNT_BT_POLARITY);
+	rtw_write16_set(rtwdev, REG_BT_COEX_V2, BIT_GNT_BT_POLARITY);
 }
 
 static void rtw8822b_coex_cfg_ant_switch(struct rtw_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index e37300e98517..4da79ca987da 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2132,24 +2132,24 @@ static void rtw8822c_coex_cfg_init(struct rtw_dev *rtwdev)
 	/* enable TBTT nterrupt */
 	rtw_write8_set(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
 
-	/* BT report packet sample rate	 */
+	/* BT report packet sample rate */
 	/* 0x790[5:0]=0x5 */
-	rtw_write8_set(rtwdev, REG_BT_TDMA_TIME, 0x05);
+	rtw_write8_mask(rtwdev, REG_BT_TDMA_TIME, BIT_MASK_SAMPLE_RATE, 0x5);
 
 	/* enable BT counter statistics */
 	rtw_write8(rtwdev, REG_BT_STAT_CTRL, 0x1);
 
 	/* enable PTA (3-wire function form BT side) */
 	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_BT_PTA_EN);
-	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_BT_AOD_GPIO3);
+	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_PO_BT_PTA_PINS);
 
 	/* enable PTA (tx/rx signal form WiFi side) */
 	rtw_write8_set(rtwdev, REG_QUEUE_CTRL, BIT_PTA_WL_TX_EN);
 	/* wl tx signal to PTA not case EDCCA */
 	rtw_write8_clr(rtwdev, REG_QUEUE_CTRL, BIT_PTA_EDCCA_EN);
 	/* GNT_BT=1 while select both */
-	rtw_write8_set(rtwdev, REG_BT_COEX_V2, BIT_GNT_BT_POLARITY);
-	/* BT_CCA = ~GNT_WL_BB, (not or GNT_BT_BB, LTE_Rx */
+	rtw_write16_set(rtwdev, REG_BT_COEX_V2, BIT_GNT_BT_POLARITY);
+	/* BT_CCA = ~GNT_WL_BB, not or GNT_BT_BB, LTE_Rx */
 	rtw_write8_clr(rtwdev, REG_DUMMY_PAGE4_V1, BIT_BTCCA_CTRL);
 
 	/* to avoid RF parameter error */
-- 
2.21.0

