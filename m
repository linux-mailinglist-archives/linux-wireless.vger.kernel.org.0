Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D526D06E1
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 15:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjC3NfG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 09:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjC3Ne5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 09:34:57 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8555CAD2E
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 06:34:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32UDYK0z8015764, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32UDYK0z8015764
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 30 Mar 2023 21:34:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 30 Mar 2023 21:34:37 +0800
Received: from localhost (172.16.16.62) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 30 Mar
 2023 21:34:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/4] wifi: rtw89: mac: update MAC settings to support 8851b
Date:   Thu, 30 Mar 2023 21:33:23 +0800
Message-ID: <20230330133324.19538-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330133324.19538-1-pkshih@realtek.com>
References: <20230330133324.19538-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Many settings of 8851B are the same as 8852B or 8852A, like DLE (Data link
engine), security engine and so on. Update them according to hardware
design.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 44 +++++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/reg.h |  2 ++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 7866fe925d248..937dbc0806857 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1584,12 +1584,15 @@ static void dle_func_en(struct rtw89_dev *rtwdev, bool enable)
 
 static void dle_clk_en(struct rtw89_dev *rtwdev, bool enable)
 {
-	if (enable)
-		rtw89_write32_set(rtwdev, R_AX_DMAC_CLK_EN,
-				  B_AX_DLE_WDE_CLK_EN | B_AX_DLE_PLE_CLK_EN);
-	else
-		rtw89_write32_clr(rtwdev, R_AX_DMAC_CLK_EN,
-				  B_AX_DLE_WDE_CLK_EN | B_AX_DLE_PLE_CLK_EN);
+	u32 val = B_AX_DLE_WDE_CLK_EN | B_AX_DLE_PLE_CLK_EN;
+
+	if (enable) {
+		if (rtwdev->chip->chip_id == RTL8851B)
+			val |= B_AX_AXIDMA_CLK_EN;
+		rtw89_write32_set(rtwdev, R_AX_DMAC_CLK_EN, val);
+	} else {
+		rtw89_write32_clr(rtwdev, R_AX_DMAC_CLK_EN, val);
+	}
 }
 
 static int dle_mix_cfg(struct rtw89_dev *rtwdev, const struct rtw89_dle_mem *cfg)
@@ -1854,7 +1857,8 @@ static int preload_init(struct rtw89_dev *rtwdev, enum rtw89_mac_idx mac_idx,
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B || !is_qta_poh(rtwdev))
+	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B ||
+	    chip->chip_id == RTL8851B || !is_qta_poh(rtwdev))
 		return 0;
 
 	return preload_init_set(rtwdev, mac_idx, mode);
@@ -1890,7 +1894,8 @@ static void _patch_ss2f_path(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B)
+	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B ||
+	    chip->chip_id == RTL8851B)
 		return;
 
 	rtw89_write32_mask(rtwdev, R_AX_SS2FINFO_PATH, B_AX_SS_DEST_QUEUE_MASK,
@@ -1959,7 +1964,8 @@ static int sec_eng_init(struct rtw89_dev *rtwdev)
 	/* init TX encryption */
 	val |= (B_AX_SEC_TX_ENC | B_AX_SEC_RX_DEC);
 	val |= (B_AX_MC_DEC | B_AX_BC_DEC);
-	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B)
+	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B ||
+	    chip->chip_id == RTL8851B)
 		val &= ~B_AX_TX_PARTIAL_MODE;
 	rtw89_write32(rtwdev, R_AX_SEC_ENG_CTRL, val);
 
@@ -2065,7 +2071,7 @@ static int scheduler_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 		rtw89_write32_mask(rtwdev, reg, B_AX_SIFS_MACTXEN_T1_MASK,
 				   SIFS_MACTXEN_T1);
 
-	if (rtwdev->chip->chip_id == RTL8852B) {
+	if (rtwdev->chip->chip_id == RTL8852B || rtwdev->chip->chip_id == RTL8851B) {
 		reg = rtw89_mac_reg_by_idx(R_AX_SCH_EXT_CTRL, mac_idx);
 		rtw89_write32_set(rtwdev, reg, B_AX_PORT_RST_TSF_ADV);
 	}
@@ -3364,8 +3370,15 @@ static int rtw89_mac_trx_init(struct rtw89_dev *rtwdev)
 
 static void rtw89_disable_fw_watchdog(struct rtw89_dev *rtwdev)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 val32;
 
+	if (chip_id == RTL8852B || chip_id == RTL8851B) {
+		rtw89_write32_clr(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_APB_WRAP_EN);
+		rtw89_write32_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_APB_WRAP_EN);
+		return;
+	}
+
 	rtw89_mac_mem_write(rtwdev, R_AX_WDT_CTRL,
 			    WDT_CTRL_ALL_DIS, RTW89_MAC_MEM_CPU_LOCAL);
 
@@ -3448,7 +3461,10 @@ static int rtw89_mac_dmac_pre_init(struct rtw89_dev *rtwdev)
 		      B_AX_PKT_BUF_EN;
 	rtw89_write32(rtwdev, R_AX_DMAC_FUNC_EN, val);
 
-	val = B_AX_DISPATCHER_CLK_EN;
+	if (chip_id == RTL8851B)
+		val = B_AX_DISPATCHER_CLK_EN | B_AX_AXIDMA_CLK_EN;
+	else
+		val = B_AX_DISPATCHER_CLK_EN;
 	rtw89_write32(rtwdev, R_AX_DMAC_CLK_EN, val);
 
 	if (chip_id != RTL8852C)
@@ -4627,11 +4643,13 @@ int rtw89_mac_coex_init(struct rtw89_dev *rtwdev, const struct rtw89_mac_ax_coex
 	int ret;
 
 	rtw89_write8_set(rtwdev, R_AX_GPIO_MUXCFG, B_AX_ENBT);
-	rtw89_write8_set(rtwdev, R_AX_BTC_FUNC_EN, B_AX_PTA_WL_TX_EN);
+	if (rtwdev->chip->chip_id != RTL8851B)
+		rtw89_write8_set(rtwdev, R_AX_BTC_FUNC_EN, B_AX_PTA_WL_TX_EN);
 	rtw89_write8_set(rtwdev, R_AX_BT_COEX_CFG_2 + 1, B_AX_GNT_BT_POLARITY >> 8);
 	rtw89_write8_set(rtwdev, R_AX_CSR_MODE, B_AX_STATIS_BT_EN | B_AX_WL_ACT_MSK);
 	rtw89_write8_set(rtwdev, R_AX_CSR_MODE + 2, B_AX_BT_CNT_RST >> 16);
-	rtw89_write8_clr(rtwdev, R_AX_TRXPTCL_RESP_0 + 3, B_AX_RSP_CHK_BTCCA >> 24);
+	if (rtwdev->chip->chip_id != RTL8851B)
+		rtw89_write8_clr(rtwdev, R_AX_TRXPTCL_RESP_0 + 3, B_AX_RSP_CHK_BTCCA >> 24);
 
 	val16 = rtw89_read16(rtwdev, R_AX_CCA_CFG_0);
 	val16 = (val16 | B_AX_BTCCA_EN) & ~B_AX_BTCCA_BRK_TXOP_EN;
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index e5c0ab43ab7a0..64c9e6d000ab2 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -129,6 +129,7 @@
 
 #define R_AX_PLATFORM_ENABLE 0x0088
 #define B_AX_AXIDMA_EN BIT(3)
+#define B_AX_APB_WRAP_EN BIT(2)
 #define B_AX_WCPU_EN BIT(1)
 #define B_AX_PLATFORM_EN BIT(0)
 
@@ -483,6 +484,7 @@
 #define B_AX_DISPATCHER_CLK_EN BIT(18)
 #define B_AX_BBRPT_CLK_EN BIT(17)
 #define B_AX_MAC_SEC_CLK_EN BIT(16)
+#define B_AX_AXIDMA_CLK_EN BIT(9)
 
 #define PCI_LTR_IDLE_TIMER_1US 0
 #define PCI_LTR_IDLE_TIMER_10US 1
-- 
2.25.1

