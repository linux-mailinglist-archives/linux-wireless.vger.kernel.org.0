Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7AF3604D2
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 10:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhDOIsC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 04:48:02 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:52869 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhDOIrz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 04:47:55 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13F8lPxM5022679, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13F8lPxM5022679
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 15 Apr 2021 16:47:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 16:47:25 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 15 Apr
 2021 16:47:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <vincent_fann@realtek.com>,
        <phhuang@realtek.com>, <steventing@realtek.com>,
        <briannorris@chromium.org>
Subject: [PATCH 3/3] rtw88: refine napi deinit flow
Date:   Thu, 15 Apr 2021 16:47:03 +0800
Message-ID: <20210415084703.27255-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210415084703.27255-1-pkshih@realtek.com>
References: <20210415084703.27255-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS03.realtek.com.tw (172.21.6.96) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMTUgpFekyCAwNjowMDowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/15/2021 08:05:31
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163124 [Apr 15 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/15/2021 08:07:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMTUgpFekyCAwNzoxMDowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/15/2021 08:09:32
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163124 [Apr 15 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/15/2021 08:12:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

We used to stop napi before disabling irqs. And it turns out
to cause some problem when we try to stop device while interrupt arrives.

To safely stop pci, we do three steps:
1. disable interrupt
2. synchronize_irq
3. stop_napi
Since step 2 and 3 may not finish as expected when interrupt is enabled,
use rtwpci->running to decide whether interrupt should be re-enabled at
the time.

Fixes: 9e2fd29864c5 ("rtw88: add napi support")
Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 19 ++++++++++++++-----
 drivers/net/wireless/realtek/rtw88/pci.h |  1 +
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index adea3c7551ab..f59a4c462e3b 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -581,23 +581,30 @@ static int rtw_pci_start(struct rtw_dev *rtwdev)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
 
+	rtw_pci_napi_start(rtwdev);
+
 	spin_lock_bh(&rtwpci->irq_lock);
+	rtwpci->running = true;
 	rtw_pci_enable_interrupt(rtwdev, rtwpci, false);
 	spin_unlock_bh(&rtwpci->irq_lock);
 
-	rtw_pci_napi_start(rtwdev);
-
 	return 0;
 }
 
 static void rtw_pci_stop(struct rtw_dev *rtwdev)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+	struct pci_dev *pdev = rtwpci->pdev;
 
+	spin_lock_bh(&rtwpci->irq_lock);
+	rtwpci->running = false;
+	rtw_pci_disable_interrupt(rtwdev, rtwpci);
+	spin_unlock_bh(&rtwpci->irq_lock);
+
+	synchronize_irq(pdev->irq);
 	rtw_pci_napi_stop(rtwdev);
 
 	spin_lock_bh(&rtwpci->irq_lock);
-	rtw_pci_disable_interrupt(rtwdev, rtwpci);
 	rtw_pci_dma_release(rtwdev, rtwpci);
 	spin_unlock_bh(&rtwpci->irq_lock);
 }
@@ -1212,7 +1219,8 @@ static irqreturn_t rtw_pci_interrupt_threadfn(int irq, void *dev)
 		rtw_fw_c2h_cmd_isr(rtwdev);
 
 	/* all of the jobs for this interrupt have been done */
-	rtw_pci_enable_interrupt(rtwdev, rtwpci, rx);
+	if (rtwpci->running)
+		rtw_pci_enable_interrupt(rtwdev, rtwpci, rx);
 	spin_unlock_bh(&rtwpci->irq_lock);
 
 	return IRQ_HANDLED;
@@ -1633,7 +1641,8 @@ static int rtw_pci_napi_poll(struct napi_struct *napi, int budget)
 	if (work_done < budget) {
 		napi_complete_done(napi, work_done);
 		spin_lock_bh(&rtwpci->irq_lock);
-		rtw_pci_enable_interrupt(rtwdev, rtwpci, false);
+		if (rtwpci->running)
+			rtw_pci_enable_interrupt(rtwdev, rtwpci, false);
 		spin_unlock_bh(&rtwpci->irq_lock);
 		/* When ISR happens during polling and before napi_complete
 		 * while no further data is received. Data on the dma_ring will
diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index e76fc549a788..0ffae887527a 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -211,6 +211,7 @@ struct rtw_pci {
 	spinlock_t irq_lock;
 	u32 irq_mask[4];
 	bool irq_enabled;
+	bool running;
 
 	/* napi structure */
 	struct net_device netdev;
-- 
2.21.0

