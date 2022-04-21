Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F401509F56
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Apr 2022 14:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383336AbiDUMNG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Apr 2022 08:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383242AbiDUMM2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Apr 2022 08:12:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98462F006
        for <linux-wireless@vger.kernel.org>; Thu, 21 Apr 2022 05:09:38 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23LC9XbxC028976, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23LC9XbxC028976
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Apr 2022 20:09:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 20:09:33 +0800
Received: from localhost (172.16.16.159) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 21 Apr
 2022 20:09:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 04/14] rtw89: pci: does RX in interrupt threadfn if low power mode
Date:   Thu, 21 Apr 2022 20:08:53 +0800
Message-ID: <20220421120903.73715-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421120903.73715-1-pkshih@realtek.com>
References: <20220421120903.73715-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.159]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/21/2022 11:49:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjEgpFekyCAxMDowNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In lower power mode, there are very low amount of RX, and it must process
in a separated function instead of schedule_napi(), because the existing
napi_poll does many things to optimize performance, but not all registers
can access in low power mode. The simple way is to use threadfn to process
the simple thing.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  3 +++
 drivers/net/wireless/realtek/rtw89/pci.c  | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 6e8a65b021ce4..796b205854ac6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1420,7 +1420,10 @@ static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
 {
 	rtw89_core_hw_to_sband_rate(rx_status);
 	rtw89_core_rx_stats(rtwdev, phy_ppdu, desc_info, skb_ppdu);
+	/* In low power mode, it does RX in thread context. */
+	local_bh_disable();
 	ieee80211_rx_napi(rtwdev->hw, NULL, skb_ppdu, &rtwdev->napi);
+	local_bh_enable();
 	rtwdev->napi_budget_countdown--;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index c1bb44bcd48e1..e8bcecbe77e14 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -713,6 +713,18 @@ static void rtw89_pci_ops_recovery_complete(struct rtw89_dev *rtwdev)
 	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
 }
 
+static void rtw89_pci_low_power_interrupt_handler(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	int budget = NAPI_POLL_WEIGHT;
+
+	/* To prevent RXQ get stuck due to run out of budget. */
+	rtwdev->napi_budget_countdown = budget;
+
+	rtw89_pci_poll_rpq_dma(rtwdev, rtwpci, budget);
+	rtw89_pci_poll_rxq_dma(rtwdev, rtwpci, budget);
+}
+
 static irqreturn_t rtw89_pci_interrupt_threadfn(int irq, void *dev)
 {
 	struct rtw89_dev *rtwdev = dev;
@@ -733,6 +745,11 @@ static irqreturn_t rtw89_pci_interrupt_threadfn(int irq, void *dev)
 	if (unlikely(rtwpci->under_recovery))
 		return IRQ_HANDLED;
 
+	if (unlikely(rtwpci->low_power)) {
+		rtw89_pci_low_power_interrupt_handler(rtwdev);
+		goto enable_intr;
+	}
+
 	if (likely(rtwpci->running)) {
 		local_bh_disable();
 		napi_schedule(&rtwdev->napi);
@@ -740,6 +757,12 @@ static irqreturn_t rtw89_pci_interrupt_threadfn(int irq, void *dev)
 	}
 
 	return IRQ_HANDLED;
+
+enable_intr:
+	spin_lock_irqsave(&rtwpci->irq_lock, flags);
+	rtw89_chip_enable_intr(rtwdev, rtwpci);
+	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
+	return IRQ_HANDLED;
 }
 
 static irqreturn_t rtw89_pci_interrupt_handler(int irq, void *dev)
-- 
2.25.1

