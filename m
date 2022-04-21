Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82836509F60
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Apr 2022 14:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383529AbiDUMNN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Apr 2022 08:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383530AbiDUMMd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Apr 2022 08:12:33 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5F32E9E2
        for <linux-wireless@vger.kernel.org>; Thu, 21 Apr 2022 05:09:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23LC9cyA6028994, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23LC9cyA6028994
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Apr 2022 20:09:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 20:09:38 +0800
Received: from localhost (172.16.16.159) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 21 Apr
 2022 20:09:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 07/14] rtw89: pci: allow to process RPP prior to TX BD
Date:   Thu, 21 Apr 2022 20:08:56 +0800
Message-ID: <20220421120903.73715-8-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

RPP is to report certain skb(s) can be freed, and TX BD indicates which
TX descriptors can be freed. Normally, TX BD is happened before RPP.
In low power mode, RPP can happen ahead, so change flow to handle this
case.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 31c62d116f44f..2bdce7024f25b 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -382,6 +382,10 @@ static void rtw89_pci_reclaim_txbd(struct rtw89_dev *rtwdev, struct rtw89_pci_tx
 		}
 
 		list_del_init(&txwd->list);
+
+		/* this skb has been freed by RPP */
+		if (skb_queue_len(&txwd->queue) == 0)
+			rtw89_pci_enqueue_txwd(tx_ring, txwd);
 	}
 }
 
@@ -413,18 +417,12 @@ static void rtw89_pci_release_txwd_skb(struct rtw89_dev *rtwdev,
 
 	if (!list_empty(&txwd->list)) {
 		rtw89_pci_reclaim_txbd(rtwdev, tx_ring);
-		if (!list_empty(&txwd->list)) {
+		/* In low power mode, RPP can receive before updating of TX BD.
+		 * In normal mode, it should not happen so give it a warning.
+		 */
+		if (!rtwpci->low_power && !list_empty(&txwd->list))
 			rtw89_warn(rtwdev, "queue %d txwd %d is not idle\n",
 				   txch, seq);
-			return;
-		}
-	}
-
-	/* currently, support for only one frame */
-	if (skb_queue_len(&txwd->queue) != 1) {
-		rtw89_warn(rtwdev, "empty pending queue %d page %d\n",
-			   txch, seq);
-		return;
 	}
 
 	skb_queue_walk_safe(&txwd->queue, skb, tmp) {
@@ -437,7 +435,8 @@ static void rtw89_pci_release_txwd_skb(struct rtw89_dev *rtwdev,
 		rtw89_pci_tx_status(rtwdev, tx_ring, skb, tx_status);
 	}
 
-	rtw89_pci_enqueue_txwd(tx_ring, txwd);
+	if (list_empty(&txwd->list))
+		rtw89_pci_enqueue_txwd(tx_ring, txwd);
 }
 
 static void rtw89_pci_release_rpp(struct rtw89_dev *rtwdev,
-- 
2.25.1

