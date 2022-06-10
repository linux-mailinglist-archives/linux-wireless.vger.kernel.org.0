Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920EF545D54
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 09:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244135AbiFJH1X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 03:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346825AbiFJH07 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 03:26:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2851144BD2
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 00:26:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25A7Qq4H2010166, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25A7Qq4H2010166
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jun 2022 15:26:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 15:26:52 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 10 Jun
 2022 15:26:52 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <damon.chen@realtek.com>,
        <phhuang@realtek.com>
Subject: [PATCH 07/11] rtw89: add UNEXP debug mask to keep monitor messages unexpected to happen frequently
Date:   Fri, 10 Jun 2022 15:26:06 +0800
Message-ID: <20220610072610.27095-8-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some warning messages could bother users. With proper handling, these
situations don't really affect usage, but we still need to keep monitor
these messages. If they happen frequently, we must review driver or
hardware design to clarify.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/debug.h | 2 ++
 drivers/net/wireless/realtek/rtw89/pci.c   | 7 ++++---
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index deb39b0d66c89..c494ad9013078 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1243,7 +1243,7 @@ static int rtw89_core_rx_process_phy_ppdu(struct rtw89_dev *rtwdev,
 					  struct rtw89_rx_phy_ppdu *phy_ppdu)
 {
 	if (RTW89_GET_PHY_STS_LEN(phy_ppdu->buf) << 3 != phy_ppdu->len) {
-		rtw89_warn(rtwdev, "phy ppdu len mismatch\n");
+		rtw89_debug(rtwdev, RTW89_DBG_UNEXP, "phy ppdu len mismatch\n");
 		return -EINVAL;
 	}
 	rtw89_core_update_phy_ppdu(phy_ppdu);
diff --git a/drivers/net/wireless/realtek/rtw89/debug.h b/drivers/net/wireless/realtek/rtw89/debug.h
index 561b04faf703d..6176152dbf6bf 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.h
+++ b/drivers/net/wireless/realtek/rtw89/debug.h
@@ -25,6 +25,8 @@ enum rtw89_debug_mask {
 	RTW89_DBG_BF = BIT(14),
 	RTW89_DBG_HW_SCAN = BIT(15),
 	RTW89_DBG_SAR = BIT(16),
+
+	RTW89_DBG_UNEXP = BIT(31),
 };
 
 enum rtw89_debug_mac_reg_sel {
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 25872dfb4da1c..fd5d9bde01085 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -228,7 +228,8 @@ static u32 rtw89_pci_rxbd_deliver_skbs(struct rtw89_dev *rtwdev,
 
 	if (fs) {
 		if (new) {
-			rtw89_err(rtwdev, "skb should not be ready before first segment start\n");
+			rtw89_debug(rtwdev, RTW89_DBG_UNEXP,
+				    "skb should not be ready before first segment start\n");
 			goto err_sync_device;
 		}
 		if (desc_info->ready) {
@@ -251,7 +252,7 @@ static u32 rtw89_pci_rxbd_deliver_skbs(struct rtw89_dev *rtwdev,
 	} else {
 		offset = sizeof(struct rtw89_pci_rxbd_info);
 		if (!new) {
-			rtw89_warn(rtwdev, "no last skb\n");
+			rtw89_debug(rtwdev, RTW89_DBG_UNEXP, "no last skb\n");
 			goto err_sync_device;
 		}
 	}
@@ -605,7 +606,7 @@ static void rtw89_pci_isr_rxd_unavail(struct rtw89_dev *rtwdev,
 		hw_idx_next = (hw_idx + 1) % bd_ring->len;
 
 		if (hw_idx_next == host_idx)
-			rtw89_warn(rtwdev, "%d RXD unavailable\n", i);
+			rtw89_debug(rtwdev, RTW89_DBG_UNEXP, "%d RXD unavailable\n", i);
 
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 			    "%d RXD unavailable, idx=0x%08x, len=%d\n",
-- 
2.25.1

