Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A14252E608
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 09:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbiETHSf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 03:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235909AbiETHSc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 03:18:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297A93ED11
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 00:18:00 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24K7HsfC6023719, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24K7HsfC6023719
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 May 2022 15:17:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 20 May 2022 15:17:54 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 20 May
 2022 15:17:53 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 3/6] rtw89: pci: handle hardware watchdog timeout interrupt status
Date:   Fri, 20 May 2022 15:17:28 +0800
Message-ID: <20220520071731.38563-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520071731.38563-1-pkshih@realtek.com>
References: <20220520071731.38563-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.21]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/20/2022 06:55:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMjAgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

This watchdog timeout status bit indicates hardware gets wrong, so run SER
L2 flow that calls mac80211 to restart hardware.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.h | 1 +
 drivers/net/wireless/realtek/rtw89/pci.c | 9 ++++++---
 drivers/net/wireless/realtek/rtw89/pci.h | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 9f511c8d8a376..f66619354734d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -666,6 +666,7 @@ enum mac_ax_err_info {
 	MAC_AX_ERR_L2_ERR_APB_BBRF_TO_RX4281 = 0x2360,
 	MAC_AX_ERR_L2_ERR_APB_BBRF_TO_OTHERS = 0x2370,
 	MAC_AX_ERR_L2_RESET_DONE = 0x2400,
+	MAC_AX_ERR_L2_ERR_WDT_TIMEOUT_INT = 0x2599,
 	MAC_AX_ERR_CPU_EXCEPTION = 0x3000,
 	MAC_AX_ERR_ASSERTION = 0x4000,
 	MAC_AX_GET_ERR_MAX,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 0ef7821b2e0fc..25872dfb4da1c 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -738,6 +738,9 @@ static irqreturn_t rtw89_pci_interrupt_threadfn(int irq, void *dev)
 	if (unlikely(isrs.halt_c2h_isrs & B_AX_HALT_C2H_INT_EN))
 		rtw89_ser_notify(rtwdev, rtw89_mac_get_err_status(rtwdev));
 
+	if (unlikely(isrs.halt_c2h_isrs & B_AX_WDT_TIMEOUT_INT_EN))
+		rtw89_ser_notify(rtwdev, MAC_AX_ERR_L2_ERR_WDT_TIMEOUT_INT);
+
 	if (unlikely(rtwpci->under_recovery))
 		goto enable_intr;
 
@@ -3126,7 +3129,7 @@ static void rtw89_pci_recovery_intr_mask_v1(struct rtw89_dev *rtwdev)
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
 
 	rtwpci->ind_intrs = B_AX_HS0ISR_IND_INT_EN;
-	rtwpci->halt_c2h_intrs = B_AX_HALT_C2H_INT_EN;
+	rtwpci->halt_c2h_intrs = B_AX_HALT_C2H_INT_EN | B_AX_WDT_TIMEOUT_INT_EN;
 	rtwpci->intrs[0] = 0;
 	rtwpci->intrs[1] = 0;
 }
@@ -3138,7 +3141,7 @@ static void rtw89_pci_default_intr_mask_v1(struct rtw89_dev *rtwdev)
 	rtwpci->ind_intrs = B_AX_HCI_AXIDMA_INT_EN |
 			    B_AX_HS1ISR_IND_INT_EN |
 			    B_AX_HS0ISR_IND_INT_EN;
-	rtwpci->halt_c2h_intrs = B_AX_HALT_C2H_INT_EN;
+	rtwpci->halt_c2h_intrs = B_AX_HALT_C2H_INT_EN | B_AX_WDT_TIMEOUT_INT_EN;
 	rtwpci->intrs[0] = B_AX_TXDMA_STUCK_INT_EN |
 			   B_AX_RXDMA_INT_EN |
 			   B_AX_RXP1DMA_INT_EN |
@@ -3155,7 +3158,7 @@ static void rtw89_pci_low_power_intr_mask_v1(struct rtw89_dev *rtwdev)
 
 	rtwpci->ind_intrs = B_AX_HS1ISR_IND_INT_EN |
 			    B_AX_HS0ISR_IND_INT_EN;
-	rtwpci->halt_c2h_intrs = B_AX_HALT_C2H_INT_EN;
+	rtwpci->halt_c2h_intrs = B_AX_HALT_C2H_INT_EN | B_AX_WDT_TIMEOUT_INT_EN;
 	rtwpci->intrs[0] = 0;
 	rtwpci->intrs[1] = B_AX_GPIO18_INT_EN;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index bb585ed191908..a118647213e35 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -94,6 +94,7 @@
 
 /* Interrupts */
 #define R_AX_HIMR0 0x01A0
+#define B_AX_WDT_TIMEOUT_INT_EN BIT(22)
 #define B_AX_HALT_C2H_INT_EN BIT(21)
 #define R_AX_HISR0 0x01A4
 
-- 
2.25.1

