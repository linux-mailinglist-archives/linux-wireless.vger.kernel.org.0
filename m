Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB591E72CD
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 04:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407037AbgE2Cuf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 22:50:35 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:35076 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407010AbgE2Cud (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 22:50:33 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04T2oGhuD031991, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04T2oGhuD031991
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 May 2020 10:50:16 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 10:50:16 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 10:50:15 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <kai.heng.feng@canonical.com>, <bigeasy@linutronix.de>,
        <vicamo.yang@canonical.com>
Subject: [PATCH v2 2/3] rtw88: coex: 8723d: handle BT inquiry cases
Date:   Fri, 29 May 2020 10:50:08 +0800
Message-ID: <20200529025009.2468-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529025009.2468-1-yhchuang@realtek.com>
References: <20200529025009.2468-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

Coex mechanism used to make BT have higher priority and more time to
transfer data when BT inquiry-page, which leads to poor WiFi performance.
Should take WiFi traffic into consideration. If the WiFi is having heavy
traffic, use another parameter to make sure WiFi has more chance to TX/RX,
while guarantee the priority of BT for inquiry. If the WiFi isn't busy
(connected or not), set proper parameter to fix originals.

Fixes: f5df1a8b4376 ("rtw88: 8723d: Add 8723DE to Kconfig and Makefile")
Tested-by: You-Sheng Yang <vicamo.yang@canonical.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c     | 9 ++++++---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 5 +++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index aa1f726d0966..cbf3d503df1c 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1354,12 +1354,15 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 				tdma_case = 108;
 			else
 				tdma_case = 109;
+		} else if (coex_stat->wl_gl_busy) {
+			table_case = 114;
+			tdma_case = 121;
 		} else if (coex_stat->wl_connected) {
-			table_case = 101;
-			tdma_case = 110;
-		} else {
 			table_case = 100;
 			tdma_case = 100;
+		} else {
+			table_case = 101;
+			tdma_case = 100;
 		}
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 37aada792d61..0885be1e7334 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2040,7 +2040,7 @@ static const struct coex_tdma_para tdma_sant_8723d[] = {
 
 /* Non-Shared-Antenna TDMA */
 static const struct coex_tdma_para tdma_nsant_8723d[] = {
-	{ {0x00, 0x00, 0x00, 0x40, 0x00} }, /* case-100 */
+	{ {0x00, 0x00, 0x00, 0x40, 0x01} }, /* case-100 */
 	{ {0x61, 0x45, 0x03, 0x11, 0x11} }, /* case-101 */
 	{ {0x61, 0x3a, 0x03, 0x11, 0x11} },
 	{ {0x61, 0x30, 0x03, 0x11, 0x11} },
@@ -2060,7 +2060,8 @@ static const struct coex_tdma_para tdma_nsant_8723d[] = {
 	{ {0x51, 0x3a, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x30, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x20, 0x03, 0x10, 0x50} },
-	{ {0x51, 0x10, 0x03, 0x10, 0x50} }
+	{ {0x51, 0x10, 0x03, 0x10, 0x50} }, /* case-120 */
+	{ {0x51, 0x08, 0x03, 0x10, 0x50} },
 };
 
 /* rssi in percentage % (dbm = % - 100) */
-- 
2.17.1

