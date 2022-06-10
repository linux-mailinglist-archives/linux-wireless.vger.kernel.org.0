Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318FC545D5C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 09:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346504AbiFJH1a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 03:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbiFJH1D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 03:27:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8211455AF
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 00:27:00 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25A7QufrE010184, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25A7QufrE010184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jun 2022 15:26:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 15:26:55 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 10 Jun
 2022 15:26:55 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <damon.chen@realtek.com>,
        <phhuang@realtek.com>
Subject: [PATCH 10/11] rtw89: pci: fix PCI doesn't reclaim TX BD properly
Date:   Fri, 10 Jun 2022 15:26:09 +0800
Message-ID: <20220610072610.27095-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610072610.27095-1-pkshih@realtek.com>
References: <20220610072610.27095-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 06/10/2022 07:06:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMTAgpFekyCAwNjowMDowMA==?=
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

TX BD (TX ring index) and TX WD (WiFi descriptor buffer) are freed
asynchronously. With burst packets, we free TX WD, but the corresponding
TX BD couldn't be freed yet. Then, TX can possibly get stuck due to no
more TX BD.

To avoid this, ignore reclaiming TX BD only if TX WD is no free space,
because at this moment TX BD must have some spaces. Otherwise, we reclaim
TX BD to resolve TX stuck issue.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index fd5d9bde01085..73b3b7e9fe6f5 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -952,9 +952,10 @@ static u32 __rtw89_pci_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
 
 	if (wd_cnt == 0 || bd_cnt == 0) {
 		cnt = rtw89_pci_rxbd_recalc(rtwdev, rx_ring);
-		if (!cnt)
+		if (cnt)
+			rtw89_pci_release_tx(rtwdev, rx_ring, cnt);
+		else if (wd_cnt == 0)
 			goto out_unlock;
-		rtw89_pci_release_tx(rtwdev, rx_ring, cnt);
 
 		bd_cnt = rtw89_pci_get_avail_txbd_num(tx_ring);
 		if (bd_cnt == 0)
@@ -965,7 +966,9 @@ static u32 __rtw89_pci_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
 	wd_cnt = wd_ring->curr_num;
 	min_cnt = min(bd_cnt, wd_cnt);
 	if (min_cnt == 0)
-		rtw89_warn(rtwdev, "still no tx resource after reclaim\n");
+		rtw89_debug(rtwdev, rtwpci->low_power ? RTW89_DBG_TXRX : RTW89_DBG_UNEXP,
+			    "still no tx resource after reclaim: wd_cnt=%d bd_cnt=%d\n",
+			    wd_cnt, bd_cnt);
 
 out_unlock:
 	spin_unlock_bh(&rtwpci->trx_lock);
-- 
2.25.1

