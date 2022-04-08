Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA9B4F8B79
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Apr 2022 02:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiDHAQh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 20:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiDHAQ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 20:16:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD01B14B84E
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 17:14:23 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2380EDcS4019386, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2380EDcS4019386
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 8 Apr 2022 08:14:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 08:14:13 +0800
Received: from localhost (172.16.21.190) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 8 Apr
 2022 08:14:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <johnson.lin@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH v2 04/13] rtw89: ser: configure top ERR IMR for firmware to recover
Date:   Fri, 8 Apr 2022 08:13:44 +0800
Message-ID: <20220408001353.17188-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408001353.17188-1-pkshih@realtek.com>
References: <20220408001353.17188-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/07/2022 23:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvNyCkVaTIIDEwOjAwOjAw?=
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

Turn on ERR IMR, and then firmware can capture interrupts reflecting
errors to recover hardware states.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 15 ++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h | 29 ++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 2c2f4aaf99fc3..6a29585e8b6cc 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2842,6 +2842,19 @@ static int rtw89_mac_enable_imr(struct rtw89_dev *rtwdev, u8 mac_idx,
 	return 0;
 }
 
+static void rtw89_mac_err_imr_ctrl(struct rtw89_dev *rtwdev, bool en)
+{
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+
+	rtw89_write32(rtwdev, R_AX_DMAC_ERR_IMR,
+		      en ? DMAC_ERR_IMR_EN : DMAC_ERR_IMR_DIS);
+	rtw89_write32(rtwdev, R_AX_CMAC_ERR_IMR,
+		      en ? CMAC0_ERR_IMR_EN : CMAC0_ERR_IMR_DIS);
+	if (chip_id != RTL8852B && rtwdev->mac.dle_info.c1_rx_qta)
+		rtw89_write32(rtwdev, R_AX_CMAC_ERR_IMR_C1,
+			      en ? CMAC1_ERR_IMR_EN : CMAC1_ERR_IMR_DIS);
+}
+
 static int rtw89_mac_dbcc_enable(struct rtw89_dev *rtwdev, bool enable)
 {
 	int ret = 0;
@@ -2923,6 +2936,8 @@ static int rtw89_mac_trx_init(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
+	rtw89_mac_err_imr_ctrl(rtwdev, true);
+
 	ret = set_host_rpr(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR] set host rpr %d\n", ret);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 3d66d3579af4e..e5f8374f49ad5 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -504,6 +504,21 @@
 #define B_AX_WDE_EMPTY_QUE_CMAC0_MBH BIT(1)
 #define B_AX_WDE_EMPTY_QUE_CMAC0_ALL_AC BIT(0)
 
+#define R_AX_DMAC_ERR_IMR 0x8520
+#define B_AX_DLE_CPUIO_ERR_INT_EN BIT(10)
+#define B_AX_APB_BRIDGE_ERR_INT_EN BIT(9)
+#define B_AX_DISPATCH_ERR_INT_EN BIT(8)
+#define B_AX_PKTIN_ERR_INT_EN BIT(7)
+#define B_AX_PLE_DLE_ERR_INT_EN BIT(6)
+#define B_AX_TXPKTCTRL_ERR_INT_EN BIT(5)
+#define B_AX_WDE_DLE_ERR_INT_EN BIT(4)
+#define B_AX_STA_SCHEDULER_ERR_INT_EN BIT(3)
+#define B_AX_MPDU_ERR_INT_EN BIT(2)
+#define B_AX_WSEC_ERR_INT_EN BIT(1)
+#define B_AX_WDRLS_ERR_INT_EN BIT(0)
+#define DMAC_ERR_IMR_EN GENMASK(31, 0)
+#define DMAC_ERR_IMR_DIS 0
+
 #define R_AX_DMAC_ERR_ISR 0x8524
 #define B_AX_DLE_CPUIO_ERR_FLAG BIT(10)
 #define B_AX_APB_BRIDGE_ERR_FLAG BIT(9)
@@ -1805,6 +1820,20 @@
 #define B_AX_TXSC_40M_MASK GENMASK(7, 4)
 #define B_AX_TXSC_20M_MASK GENMASK(3, 0)
 
+#define R_AX_CMAC_ERR_IMR 0xC160
+#define R_AX_CMAC_ERR_IMR_C1 0xE160
+#define B_AX_WMAC_TX_ERR_IND_EN BIT(7)
+#define B_AX_WMAC_RX_ERR_IND_EN BIT(6)
+#define B_AX_TXPWR_CTRL_ERR_IND_EN BIT(5)
+#define B_AX_PHYINTF_ERR_IND_EN BIT(4)
+#define B_AX_DMA_TOP_ERR_IND_EN BIT(3)
+#define B_AX_PTCL_TOP_ERR_IND_EN BIT(1)
+#define B_AX_SCHEDULE_TOP_ERR_IND_EN BIT(0)
+#define CMAC0_ERR_IMR_EN GENMASK(31, 0)
+#define CMAC1_ERR_IMR_EN GENMASK(31, 0)
+#define CMAC0_ERR_IMR_DIS 0
+#define CMAC1_ERR_IMR_DIS 0
+
 #define R_AX_CMAC_ERR_ISR 0xC164
 #define R_AX_CMAC_ERR_ISR_C1 0xE164
 #define B_AX_WMAC_TX_ERR_IND BIT(7)
-- 
2.25.1

