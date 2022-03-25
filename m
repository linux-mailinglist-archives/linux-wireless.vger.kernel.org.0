Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7494E6E0F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358413AbiCYGEE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358416AbiCYGEB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:04:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5C9C683D
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:02:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22P62IWF0011166, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22P62IWF0011166
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Mar 2022 14:02:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 14:02:18 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 14:02:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
Subject: [PATCH 15/16] rtw89: update TMAC parameters
Date:   Fri, 25 Mar 2022 14:00:54 +0800
Message-ID: <20220325060055.58482-16-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325060055.58482-1-pkshih@realtek.com>
References: <20220325060055.58482-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/25/2022 05:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMjUgpFekyCAwNDo0ODowMA==?=
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

TMAC is short for TX MAC, and this patch is to configure FIFO thresholds.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c |  7 ++++++
 drivers/net/wireless/realtek/rtw89/reg.h | 29 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 72debef03f6e3..1103b261b9ab4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1995,6 +1995,13 @@ static int tmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	reg = rtw89_mac_reg_by_idx(R_AX_MAC_LOOPBACK, mac_idx);
 	rtw89_write32_clr(rtwdev, reg, B_AX_MACLBK_EN);
 
+	reg = rtw89_mac_reg_by_idx(R_AX_TCR0, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_TCR_UDF_THSD_MASK, TCR_UDF_THSD);
+
+	reg = rtw89_mac_reg_by_idx(R_AX_TXD_FIFO_CTRL, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_TXDFIFO_HIGH_MCS_THRE_MASK, TXDFIFO_HIGH_MCS_THRE);
+	rtw89_write32_mask(rtwdev, reg, B_AX_TXDFIFO_LOW_MCS_THRE_MASK, TXDFIFO_LOW_MCS_THRE);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index aca9fc3ac09ed..3822cf0daef0a 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -1351,6 +1351,24 @@
 #define R_AX_RXDMA_PKT_INFO_1 0xC818
 #define R_AX_RXDMA_PKT_INFO_2 0xC81C
 
+#define R_AX_TCR0 0xCA00
+#define R_AX_TCR0_C1 0xEA00
+#define B_AX_TCR_ZLD_NUM_MASK GENMASK(31, 24)
+#define B_AX_TCR_UDF_EN BIT(23)
+#define B_AX_TCR_UDF_THSD_MASK GENMASK(22, 16)
+#define TCR_UDF_THSD 0x6
+#define B_AX_TCR_ERRSTEN_MASK GENMASK(15, 10)
+#define B_AX_TCR_VHTSIGA1_TXPS BIT(9)
+#define B_AX_TCR_PLCP_ERRHDL_EN BIT(8)
+#define B_AX_TCR_PADSEL BIT(7)
+#define B_AX_TCR_MASK_SIGBCRC BIT(6)
+#define B_AX_TCR_SR_VAL15_ALLOW BIT(5)
+#define B_AX_TCR_EN_EOF BIT(4)
+#define B_AX_TCR_EN_SCRAM_INC BIT(3)
+#define B_AX_TCR_EN_20MST BIT(2)
+#define B_AX_TCR_CRC BIT(1)
+#define B_AX_TCR_DISGCLK BIT(0)
+
 #define R_AX_TCR1 0xCA04
 #define R_AX_TCR1_C1 0xEA04
 #define B_AX_TXDFIFO_THRESHOLD GENMASK(31, 28)
@@ -1374,6 +1392,17 @@
 #define R_AX_PPWRBIT_SETTING 0xCA0C
 #define R_AX_PPWRBIT_SETTING_C1 0xEA0C
 
+#define R_AX_TXD_FIFO_CTRL 0xCA1C
+#define R_AX_TXD_FIFO_CTRL_C1 0xEA1C
+#define B_AX_NON_LEGACY_PPDU_ZLD_USTIMER_MASK GENMASK(28, 24)
+#define B_AX_LEGACY_PPDU_ZLD_USTIMER_MASK GENMASK(20, 16)
+#define B_AX_TXDFIFO_HIGH_MCS_THRE_MASK GENMASK(15, 12)
+#define TXDFIFO_HIGH_MCS_THRE 0x7
+#define B_AX_TXDFIFO_LOW_MCS_THRE_MASK GENMASK(11, 8)
+#define TXDFIFO_LOW_MCS_THRE  0x7
+#define B_AX_HIGH_MCS_PHY_RATE_MASK GENMASK(7, 4)
+#define B_AX_BW_PHY_RATE_MASK GENMASK(1, 0)
+
 #define R_AX_MACTX_DBG_SEL_CNT 0xCA20
 #define R_AX_MACTX_DBG_SEL_CNT_C1 0xEA20
 #define B_AX_MACTX_MPDU_CNT GENMASK(31, 24)
-- 
2.25.1

