Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7274F806B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 15:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243951AbiDGNZr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 09:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343636AbiDGNZq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 09:25:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E07BA88B3
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 06:23:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 237DNcQ22007544, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 237DNcQ22007544
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 7 Apr 2022 21:23:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 21:23:38 +0800
Received: from localhost (172.16.21.190) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 7 Apr
 2022 21:23:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <johnson.lin@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 09/13] rtw89: 8852c: add 8852c specific BT-coexistence initial function
Date:   Thu, 7 Apr 2022 21:23:12 +0800
Message-ID: <20220407132316.61132-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407132316.61132-1-pkshih@realtek.com>
References: <20220407132316.61132-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.21.190]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/07/2022 13:10:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvNyCkV6TIIDA4OjExOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

From: Chia-Yuan Li <leo.li@realtek.com>

Initialize registers to default values, such as PTA and GNT pin, and set
pin MUX according to number of antenna on hardware module.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      | 28 +++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  2 +
 drivers/net/wireless/realtek/rtw89/reg.h      | 33 +++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 59 +++++++++++++++++++
 4 files changed, 122 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index da66d28e98a62..684065820dfd7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3973,6 +3973,34 @@ int rtw89_mac_coex_init(struct rtw89_dev *rtwdev, const struct rtw89_mac_ax_coex
 }
 EXPORT_SYMBOL(rtw89_mac_coex_init);
 
+int rtw89_mac_coex_init_v1(struct rtw89_dev *rtwdev,
+			   const struct rtw89_mac_ax_coex *coex)
+{
+	rtw89_write32_set(rtwdev, R_AX_BTC_CFG,
+			  B_AX_BTC_EN | B_AX_BTG_LNA1_GAIN_SEL);
+	rtw89_write32_set(rtwdev, R_AX_BT_CNT_CFG, B_AX_BT_CNT_EN);
+	rtw89_write16_set(rtwdev, R_AX_CCA_CFG_0, B_AX_BTCCA_EN);
+	rtw89_write16_clr(rtwdev, R_AX_CCA_CFG_0, B_AX_BTCCA_BRK_TXOP_EN);
+
+	switch (coex->pta_mode) {
+	case RTW89_MAC_AX_COEX_RTK_MODE:
+		rtw89_write32_mask(rtwdev, R_AX_BTC_CFG, B_AX_BTC_MODE_MASK,
+				   MAC_AX_RTK_MODE);
+		rtw89_write32_mask(rtwdev, R_AX_RTK_MODE_CFG_V1,
+				   B_AX_SAMPLE_CLK_MASK, MAC_AX_RTK_RATE);
+		break;
+	case RTW89_MAC_AX_COEX_CSR_MODE:
+		rtw89_write32_mask(rtwdev, R_AX_BTC_CFG, B_AX_BTC_MODE_MASK,
+				   MAC_AX_CSR_MODE);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_mac_coex_init_v1);
+
 int rtw89_mac_cfg_gnt(struct rtw89_dev *rtwdev,
 		      const struct rtw89_mac_ax_coex_gnt *gnt_cfg)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 31d53de97cfce..9eb4afe348b30 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -829,6 +829,8 @@ int rtw89_mac_cfg_ppdu_status(struct rtw89_dev *rtwdev, u8 mac_ids, bool enable)
 void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev, u8 mac_idx);
 void rtw89_mac_flush_txq(struct rtw89_dev *rtwdev, u32 queues, bool drop);
 int rtw89_mac_coex_init(struct rtw89_dev *rtwdev, const struct rtw89_mac_ax_coex *coex);
+int rtw89_mac_coex_init_v1(struct rtw89_dev *rtwdev,
+			   const struct rtw89_mac_ax_coex *coex);
 int rtw89_mac_cfg_gnt(struct rtw89_dev *rtwdev,
 		      const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
 int rtw89_mac_cfg_gnt_v1(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 0ec6636d62c9a..17e95db10d6d9 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -87,6 +87,8 @@
 #define B_AX_BTMODE_MASK GENMASK(7, 6)
 #define MAC_AX_BT_MODE_0_3 0
 #define MAC_AX_BT_MODE_2 2
+#define MAC_AX_RTK_MODE 0
+#define MAC_AX_CSR_MODE 1
 #define B_AX_ENBT BIT(5)
 #define B_AX_EROM_EN BIT(4)
 #define B_AX_ENUARTRX BIT(2)
@@ -2962,11 +2964,40 @@
 #define R_AX_TXPWR_ISR_C1 0xF9E4
 
 #define R_AX_BTC_CFG 0xDA00
+#define B_AX_BTC_EN BIT(31)
+#define B_AX_EN_EXT_BT_PINMUX BIT(29)
+#define B_AX_BTC_RST BIT(28)
+#define B_AX_BTC_DBG_SRC_SEL BIT(27)
+#define B_AX_BTC_MODE_MASK GENMASK(25, 24)
+#define B_AX_INV_WL_ACT2 BIT(17)
+#define B_AX_BTG_LNA1_GAIN_SEL BIT(16)
+#define B_AX_COEX_DLY_CLK_MASK GENMASK(15, 8)
+#define B_AX_IGN_GNT_BT2_RX BIT(7)
+#define B_AX_IGN_GNT_BT2_TX BIT(6)
+#define B_AX_IGN_GNT_BT2 BIT(5)
+#define B_AX_BTC_DBG_SEL_MASK GENMASK(4, 3)
 #define B_AX_DIS_BTC_CLK_G BIT(2)
+#define B_AX_GNT_WL_RX_CTRL BIT(1)
+#define B_AX_WL_SRC BIT(0)
+
+#define R_AX_RTK_MODE_CFG_V1 0xDA04
+#define R_AX_RTK_MODE_CFG_V1_C1 0xFA04
+#define B_AX_BT_BLE_EN_V1 BIT(24)
+#define B_AX_BT_ULTRA_EN BIT(16)
+#define B_AX_BT_L_RX_ULTRA_MASK GENMASK(15, 14)
+#define B_AX_BT_L_TX_ULTRA_MASK GENMASK(13, 12)
+#define B_AX_BT_H_RX_ULTRA_MASK GENMASK(11, 10)
+#define B_AX_BT_H_TX_ULTRA_MASK GENMASK(9, 8)
+#define B_AX_SAMPLE_CLK_MASK GENMASK(7, 0)
 
 #define R_AX_WL_PRI_MSK 0xDA10
 #define B_AX_PTA_WL_PRI_MASK_BCNQ BIT(8)
 
+#define R_AX_BT_CNT_CFG 0xDA10
+#define R_AX_BT_CNT_CFG_C1 0xFA10
+#define B_AX_BT_CNT_RST_V1 BIT(1)
+#define B_AX_BT_CNT_EN BIT(0)
+
 #define R_AX_BTC_FUNC_EN 0xDA20
 #define R_AX_BTC_FUNC_EN_C1 0xFA20
 #define B_AX_PTA_WL_TX_EN BIT(1)
@@ -2999,6 +3030,8 @@
 #define B_AX_WL_ACT_MASK_ENABLE BIT(1)
 #define B_AX_ENHANCED_BT BIT(0)
 
+#define R_AX_BT_BREAK_TABLE 0xDA44
+
 #define R_AX_BT_STAST_HIGH 0xDA44
 #define B_AX_STATIS_BT_HI_RX_MASK GENMASK(31, 16)
 #define B_AX_STATIS_BT_HI_TX_MASK GENMASK(15, 0)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ca254339ea7a9..38b1383307161 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2022  Realtek Corporation
  */
 
+#include "coex.h"
 #include "debug.h"
 #include "fw.h"
 #include "mac.h"
@@ -528,6 +529,62 @@ void rtw8852c_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 	}
 }
 
+static
+void rtw8852c_set_trx_mask(struct rtw89_dev *rtwdev, u8 path, u8 group, u32 val)
+{
+	rtw89_write_rf(rtwdev, path, RR_LUTWE, RFREG_MASK, 0x20000);
+	rtw89_write_rf(rtwdev, path, RR_LUTWA, RFREG_MASK, group);
+	rtw89_write_rf(rtwdev, path, RR_LUTWD0, RFREG_MASK, val);
+	rtw89_write_rf(rtwdev, path, RR_LUTWE, RFREG_MASK, 0x0);
+}
+
+static void rtw8852c_btc_init_cfg(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_module *module = &btc->mdinfo;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_mac_ax_coex coex_params = {
+		.pta_mode = RTW89_MAC_AX_COEX_RTK_MODE,
+		.direction = RTW89_MAC_AX_COEX_INNER,
+	};
+
+	/* PTA init  */
+	rtw89_mac_coex_init_v1(rtwdev, &coex_params);
+
+	/* set WL Tx response = Hi-Pri */
+	chip->ops->btc_set_wl_pri(rtwdev, BTC_PRI_MASK_TX_RESP, true);
+	chip->ops->btc_set_wl_pri(rtwdev, BTC_PRI_MASK_BEACON, true);
+
+	/* set rf gnt debug off */
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_WLSEL, RFREG_MASK, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_WLSEL, RFREG_MASK, 0x0);
+
+	/* set WL Tx thru in TRX mask table if GNT_WL = 0 && BT_S1 = ss group */
+	if (module->ant.type == BTC_ANT_SHARED) {
+		rtw8852c_set_trx_mask(rtwdev,
+				      RF_PATH_A, BTC_BT_SS_GROUP, 0x5ff);
+		rtw8852c_set_trx_mask(rtwdev,
+				      RF_PATH_B, BTC_BT_SS_GROUP, 0x5ff);
+		/* set path-A(S0) Tx/Rx no-mask if GNT_WL=0 && BT_S1=tx group */
+		rtw8852c_set_trx_mask(rtwdev,
+				      RF_PATH_A, BTC_BT_TX_GROUP, 0x5ff);
+	} else { /* set WL Tx stb if GNT_WL = 0 && BT_S1 = ss group for 3-ant */
+		rtw8852c_set_trx_mask(rtwdev,
+				      RF_PATH_A, BTC_BT_SS_GROUP, 0x5df);
+		rtw8852c_set_trx_mask(rtwdev,
+				      RF_PATH_B, BTC_BT_SS_GROUP, 0x5df);
+	}
+
+	/* set PTA break table */
+	rtw89_write32(rtwdev, R_AX_BT_BREAK_TABLE, BTC_BREAK_PARAM);
+
+	 /* enable BT counter 0xda10[1:0] = 2b'11 */
+	rtw89_write32_set(rtwdev,
+			  R_AX_BT_CNT_CFG, B_AX_BT_CNT_EN |
+			  B_AX_BT_CNT_RST_V1);
+	btc->cx.wl.status.map.init_ok = true;
+}
+
 static int rtw8852c_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	int ret;
@@ -588,6 +645,8 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt_v1,
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx_v1,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx_v1,
+
+	.btc_init_cfg		= rtw8852c_btc_init_cfg,
 };
 
 const struct rtw89_chip_info rtw8852c_chip_info = {
-- 
2.25.1

