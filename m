Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E783C296C37
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Oct 2020 11:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461612AbgJWJii (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Oct 2020 05:38:38 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45980 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461549AbgJWJig (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Oct 2020 05:38:36 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 09N9cUHT1024657, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 09N9cUHT1024657
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Oct 2020 17:38:30 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 23 Oct 2020 17:38:29 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 02/11] rtw88: coex: update coex parameter to improve A2DP quality
Date:   Fri, 23 Oct 2020 17:37:33 +0800
Message-ID: <20201023093742.29908-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201023093742.29908-1-pkshih@realtek.com>
References: <20201023093742.29908-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB06.realtek.com.tw (172.21.6.99) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Update COEX parameters and logic to enhance WL/BT performance
while WL_Busy + A2DP in a less interference environment.
It can avoid the interference comes cross from each other
and earned more performance.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c     |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 61 ++++++++++---------
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 35 ++++++-----
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 28 +++++----
 4 files changed, 69 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index aa08fd7d9fcd..6fb916dae40f 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1517,7 +1517,7 @@ static void rtw_coex_action_bt_a2dp(struct rtw_dev *rtwdev)
 		slot_type = TDMA_4SLOT;
 
 		if (coex_stat->wl_gl_busy && coex_stat->wl_noisy_level == 0)
-			table_case = 10;
+			table_case = 11;
 		else
 			table_case = 9;
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 01768fec4426..e8b9f371cfaa 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1949,19 +1949,19 @@ static struct rtw_chip_ops rtw8723d_ops = {
 static const struct coex_table_para table_sant_8723d[] = {
 	{0xffffffff, 0xffffffff}, /* case-0 */
 	{0x55555555, 0x55555555},
-	{0x65555555, 0x65555555},
+	{0x66555555, 0x66555555},
 	{0xaaaaaaaa, 0xaaaaaaaa},
 	{0x5a5a5a5a, 0x5a5a5a5a},
 	{0xfafafafa, 0xfafafafa}, /* case-5 */
-	{0xa5555555, 0xaaaa5aaa},
-	{0x6a5a5a5a, 0x5a5a5a5a},
+	{0x6a5a5555, 0xaaaaaaaa},
+	{0x6a5a56aa, 0x6a5a56aa},
 	{0x6a5a5a5a, 0x6a5a5a5a},
 	{0x66555555, 0x5a5a5a5a},
-	{0x65555555, 0x6a5a5a5a}, /* case-10 */
-	{0x65555555, 0xfafafafa},
+	{0x66555555, 0x6a5a5a5a}, /* case-10 */
+	{0x66555555, 0x6a5a5aaa},
 	{0x66555555, 0x5a5a5aaa},
-	{0x65555555, 0x5aaa5aaa},
-	{0x65555555, 0xaaaa5aaa},
+	{0x66555555, 0x6aaa5aaa},
+	{0x66555555, 0xaaaa5aaa},
 	{0x66555555, 0xaaaaaaaa}, /* case-15 */
 	{0xffff55ff, 0xfafafafa},
 	{0xffff55ff, 0x6afa5afa},
@@ -1970,38 +1970,41 @@ static const struct coex_table_para table_sant_8723d[] = {
 	{0xaa5555aa, 0x6a5a5a5a}, /* case-20 */
 	{0xaa5555aa, 0xaaaaaaaa},
 	{0xffffffff, 0x5a5a5a5a},
-	{0xffffffff, 0x6a5a5a5a},
+	{0xffffffff, 0x5a5a5a5a},
 	{0xffffffff, 0x55555555},
-	{0xffffffff, 0x6a5a5aaa}, /* case-25 */
+	{0xffffffff, 0x5a5a5aaa}, /* case-25 */
 	{0x55555555, 0x5a5a5a5a},
 	{0x55555555, 0xaaaaaaaa},
-	{0x55555555, 0x6a6a6a6a},
-	{0x656a656a, 0x656a656a}
+	{0x55555555, 0x6a5a6a5a},
+	{0x66556655, 0x66556655},
+	{0x66556aaa, 0x6a5a6aaa}, /* case-30 */
+	{0xffffffff, 0x5aaa5aaa},
+	{0x56555555, 0x5a5a5aaa}
 };
 
 /* Non-Shared-Antenna Coex Table */
 static const struct coex_table_para table_nsant_8723d[] = {
 	{0xffffffff, 0xffffffff}, /* case-100 */
 	{0x55555555, 0x55555555},
-	{0x65555555, 0x65555555},
+	{0x66555555, 0x66555555},
 	{0xaaaaaaaa, 0xaaaaaaaa},
 	{0x5a5a5a5a, 0x5a5a5a5a},
 	{0xfafafafa, 0xfafafafa}, /* case-105 */
 	{0x5afa5afa, 0x5afa5afa},
 	{0x55555555, 0xfafafafa},
-	{0x65555555, 0xfafafafa},
-	{0x65555555, 0x5a5a5a5a},
-	{0x65555555, 0x6a5a5a5a}, /* case-110 */
-	{0x65555555, 0xaaaaaaaa},
+	{0x66555555, 0xfafafafa},
+	{0x66555555, 0x5a5a5a5a},
+	{0x66555555, 0x6a5a5a5a}, /* case-110 */
+	{0x66555555, 0xaaaaaaaa},
 	{0xffff55ff, 0xfafafafa},
 	{0xffff55ff, 0x5afa5afa},
 	{0xffff55ff, 0xaaaaaaaa},
-	{0xaaffffaa, 0xfafafafa}, /* case-115 */
+	{0xffff55ff, 0xffff55ff}, /* case-115 */
 	{0xaaffffaa, 0x5afa5afa},
 	{0xaaffffaa, 0xaaaaaaaa},
 	{0xffffffff, 0xfafafafa},
 	{0xffffffff, 0x5afa5afa},
-	{0xffffffff, 0xaaaaaaaa},/* case-120 */
+	{0xffffffff, 0xaaaaaaaa}, /* case-120 */
 	{0x55ff55ff, 0x5afa5afa},
 	{0x55ff55ff, 0xaaaaaaaa},
 	{0x55ff55ff, 0x55ff55ff}
@@ -2009,31 +2012,31 @@ static const struct coex_table_para table_nsant_8723d[] = {
 
 /* Shared-Antenna TDMA */
 static const struct coex_tdma_para tdma_sant_8723d[] = {
-	{ {0x08, 0x00, 0x00, 0x00, 0x00} }, /* case-0 */
+	{ {0x00, 0x00, 0x00, 0x00, 0x00} }, /* case-0 */
 	{ {0x61, 0x45, 0x03, 0x11, 0x11} }, /* case-1 */
 	{ {0x61, 0x3a, 0x03, 0x11, 0x11} },
-	{ {0x61, 0x20, 0x03, 0x11, 0x11} },
 	{ {0x61, 0x30, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x11} },
 	{ {0x61, 0x10, 0x03, 0x11, 0x11} }, /* case-5 */
-	{ {0x61, 0x48, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x45, 0x03, 0x11, 0x10} },
 	{ {0x61, 0x3a, 0x03, 0x11, 0x10} },
 	{ {0x61, 0x30, 0x03, 0x11, 0x10} },
 	{ {0x61, 0x20, 0x03, 0x11, 0x10} },
 	{ {0x61, 0x10, 0x03, 0x11, 0x10} }, /* case-10 */
-	{ {0x61, 0x10, 0x03, 0x11, 0x14} },
+	{ {0x61, 0x08, 0x03, 0x11, 0x14} },
 	{ {0x61, 0x08, 0x03, 0x10, 0x14} },
-	{ {0x51, 0x10, 0x03, 0x10, 0x54} },
-	{ {0x51, 0x10, 0x03, 0x10, 0x55} },
-	{ {0x51, 0x10, 0x07, 0x10, 0x54} }, /* case-15 */
+	{ {0x51, 0x08, 0x03, 0x10, 0x54} },
+	{ {0x51, 0x08, 0x03, 0x10, 0x55} },
+	{ {0x51, 0x08, 0x07, 0x10, 0x54} }, /* case-15 */
 	{ {0x51, 0x45, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x3a, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x30, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x20, 0x03, 0x10, 0x50} },
-	{ {0x51, 0x15, 0x03, 0x10, 0x50} }, /* case-20 */
+	{ {0x51, 0x10, 0x03, 0x10, 0x50} }, /* case-20 */
 	{ {0x51, 0x4a, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x0c, 0x03, 0x10, 0x54} },
 	{ {0x55, 0x08, 0x03, 0x10, 0x54} },
-	{ {0x65, 0x10, 0x03, 0x11, 0x11} },
+	{ {0x65, 0x10, 0x03, 0x11, 0x10} },
 	{ {0x51, 0x10, 0x03, 0x10, 0x51} }, /* case-25 */
 	{ {0x51, 0x08, 0x03, 0x10, 0x50} },
 	{ {0x61, 0x08, 0x03, 0x11, 0x11} }
@@ -2041,7 +2044,7 @@ static const struct coex_tdma_para tdma_sant_8723d[] = {
 
 /* Non-Shared-Antenna TDMA */
 static const struct coex_tdma_para tdma_nsant_8723d[] = {
-	{ {0x00, 0x00, 0x00, 0x40, 0x01} }, /* case-100 */
+	{ {0x00, 0x00, 0x00, 0x00, 0x01} }, /* case-100 */
 	{ {0x61, 0x45, 0x03, 0x11, 0x11} }, /* case-101 */
 	{ {0x61, 0x3a, 0x03, 0x11, 0x11} },
 	{ {0x61, 0x30, 0x03, 0x11, 0x11} },
@@ -2062,7 +2065,7 @@ static const struct coex_tdma_para tdma_nsant_8723d[] = {
 	{ {0x51, 0x30, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x20, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x10, 0x03, 0x10, 0x50} }, /* case-120 */
-	{ {0x51, 0x08, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x08, 0x03, 0x10, 0x50} }
 };
 
 /* rssi in percentage % (dbm = % - 100) */
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 908f552c7c9d..743a2f6f1965 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2141,30 +2141,34 @@ static const struct coex_table_para table_sant_8822b[] = {
 	{0xaaaaaaaa, 0xaaaaaaaa},
 	{0x5a5a5a5a, 0x5a5a5a5a},
 	{0xfafafafa, 0xfafafafa}, /* case-5 */
-	{0x6a5a6a5a, 0xaaaaaaaa},
+	{0x6a5a5555, 0xaaaaaaaa},
 	{0x6a5a56aa, 0x6a5a56aa},
 	{0x6a5a5a5a, 0x6a5a5a5a},
 	{0x66555555, 0x5a5a5a5a},
 	{0x66555555, 0x6a5a5a5a}, /* case-10 */
 	{0x66555555, 0xfafafafa},
 	{0x66555555, 0x5a5a5aaa},
-	{0x66555555, 0x5aaa5aaa},
-	{0x66555555, 0xaaaa5aaa},
-	{0x66555555, 0xaaaaaaaa}, /* case-15 */
+	{0x66555555, 0x5a5a5aaa},
+	{0x66555555, 0x6aaa5aaa},
+	{0x66555555, 0xaaaa5aaa}, /* case-15 */
+	{0x66555555, 0xaaaaaaaa},
 	{0xffff55ff, 0xfafafafa},
 	{0xffff55ff, 0x6afa5afa},
 	{0xaaffffaa, 0xfafafafa},
-	{0xaa5555aa, 0x5a5a5a5a},
-	{0xaa5555aa, 0x6a5a5a5a}, /* case-20 */
+	{0xaa5555aa, 0x5a5a5a5a}, /* case-20 */
+	{0xaa5555aa, 0x6a5a5a5a},
 	{0xaa5555aa, 0xaaaaaaaa},
 	{0xffffffff, 0x5a5a5a5a},
-	{0xffffffff, 0x6a5a5a5a},
-	{0xffffffff, 0x55555555},
-	{0xffffffff, 0x6a5a5aaa}, /* case-25 */
+	{0xffffffff, 0x5a5a5a5a},
+	{0xffffffff, 0x55555555}, /* case-25 */
+	{0xffffffff, 0x5a5a5aaa},
 	{0x55555555, 0x5a5a5a5a},
 	{0x55555555, 0xaaaaaaaa},
 	{0x55555555, 0x6a5a6a5a},
-	{0x66556655, 0x66556655}
+	{0x66556655, 0x66556655}, /* case-30 */
+	{0x66556aaa, 0x6a5a6aaa},
+	{0xffffffff, 0x5aaa5aaa},
+	{0x56555555, 0x5a5a5aaa}
 };
 
 /* Non-Shared-Antenna Coex Table */
@@ -2184,7 +2188,7 @@ static const struct coex_table_para table_nsant_8822b[] = {
 	{0xffff55ff, 0xfafafafa},
 	{0xffff55ff, 0x5afa5afa},
 	{0xffff55ff, 0xaaaaaaaa},
-	{0xaaffffaa, 0xfafafafa}, /* case-115 */
+	{0xffff55ff, 0xffff55ff}, /* case-115 */
 	{0xaaffffaa, 0x5afa5afa},
 	{0xaaffffaa, 0xaaaaaaaa},
 	{0xffffffff, 0xfafafafa},
@@ -2213,7 +2217,7 @@ static const struct coex_tdma_para tdma_sant_8822b[] = {
 	{ {0x51, 0x08, 0x03, 0x10, 0x54} },
 	{ {0x51, 0x08, 0x03, 0x10, 0x55} },
 	{ {0x51, 0x08, 0x07, 0x10, 0x54} }, /* case-15 */
-	{ {0x51, 0x45, 0x03, 0x10, 0x10} },
+	{ {0x51, 0x45, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x3a, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x30, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x20, 0x03, 0x10, 0x50} },
@@ -2221,7 +2225,7 @@ static const struct coex_tdma_para tdma_sant_8822b[] = {
 	{ {0x51, 0x4a, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x0c, 0x03, 0x10, 0x54} },
 	{ {0x55, 0x08, 0x03, 0x10, 0x54} },
-	{ {0x65, 0x10, 0x03, 0x11, 0x11} },
+	{ {0x65, 0x10, 0x03, 0x11, 0x10} },
 	{ {0x51, 0x10, 0x03, 0x10, 0x51} }, /* case-25 */
 	{ {0x51, 0x08, 0x03, 0x10, 0x50} },
 	{ {0x61, 0x08, 0x03, 0x11, 0x11} }
@@ -2230,7 +2234,7 @@ static const struct coex_tdma_para tdma_sant_8822b[] = {
 /* Non-Shared-Antenna TDMA */
 static const struct coex_tdma_para tdma_nsant_8822b[] = {
 	{ {0x00, 0x00, 0x00, 0x00, 0x00} }, /* case-100 */
-	{ {0x61, 0x45, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x45, 0x03, 0x11, 0x11} }, /* case-101 */
 	{ {0x61, 0x3a, 0x03, 0x11, 0x11} },
 	{ {0x61, 0x30, 0x03, 0x11, 0x11} },
 	{ {0x61, 0x20, 0x03, 0x11, 0x11} },
@@ -2249,7 +2253,8 @@ static const struct coex_tdma_para tdma_nsant_8822b[] = {
 	{ {0x51, 0x3a, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x30, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x20, 0x03, 0x10, 0x50} },
-	{ {0x51, 0x10, 0x03, 0x10, 0x50} }  /* case-120 */
+	{ {0x51, 0x10, 0x03, 0x10, 0x50} }, /* case-120 */
+	{ {0x51, 0x08, 0x03, 0x10, 0x50} }
 };
 
 /* rssi in percentage % (dbm = % - 100) */
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 4da79ca987da..fe8a94abc76d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3983,14 +3983,14 @@ static const struct coex_table_para table_sant_8822c[] = {
 	{0xaaaaaaaa, 0xaaaaaaaa},
 	{0x5a5a5a5a, 0x5a5a5a5a},
 	{0xfafafafa, 0xfafafafa}, /* case-5 */
-	{0x6a5a6a5a, 0xaaaaaaaa},
+	{0x6a5a5555, 0xaaaaaaaa},
 	{0x6a5a56aa, 0x6a5a56aa},
 	{0x6a5a5a5a, 0x6a5a5a5a},
 	{0x66555555, 0x5a5a5a5a},
 	{0x66555555, 0x6a5a5a5a}, /* case-10 */
-	{0x66555555, 0xfafafafa},
+	{0x66555555, 0x6a5a5aaa},
 	{0x66555555, 0x5a5a5aaa},
-	{0x66555555, 0x5aaa5aaa},
+	{0x66555555, 0x6aaa5aaa},
 	{0x66555555, 0xaaaa5aaa},
 	{0x66555555, 0xaaaaaaaa}, /* case-15 */
 	{0xffff55ff, 0xfafafafa},
@@ -4000,13 +4000,16 @@ static const struct coex_table_para table_sant_8822c[] = {
 	{0xaa5555aa, 0x6a5a5a5a}, /* case-20 */
 	{0xaa5555aa, 0xaaaaaaaa},
 	{0xffffffff, 0x5a5a5a5a},
-	{0xffffffff, 0x6a5a5a5a},
+	{0xffffffff, 0x5a5a5a5a},
 	{0xffffffff, 0x55555555},
-	{0xffffffff, 0x6a5a5aaa}, /* case-25 */
+	{0xffffffff, 0x5a5a5aaa}, /* case-25 */
 	{0x55555555, 0x5a5a5a5a},
 	{0x55555555, 0xaaaaaaaa},
 	{0x55555555, 0x6a5a6a5a},
-	{0x66556655, 0x66556655}
+	{0x66556655, 0x66556655},
+	{0x66556aaa, 0x6a5a6aaa}, /* case-30 */
+	{0xffffffff, 0x5aaa5aaa},
+	{0x56555555, 0x5a5a5aaa}
 };
 
 /* Non-Shared-Antenna Coex Table */
@@ -4026,12 +4029,12 @@ static const struct coex_table_para table_nsant_8822c[] = {
 	{0xffff55ff, 0xfafafafa},
 	{0xffff55ff, 0x5afa5afa},
 	{0xffff55ff, 0xaaaaaaaa},
-	{0xaaffffaa, 0xfafafafa}, /* case-115 */
+	{0xffff55ff, 0xffff55ff}, /* case-115 */
 	{0xaaffffaa, 0x5afa5afa},
 	{0xaaffffaa, 0xaaaaaaaa},
 	{0xffffffff, 0xfafafafa},
 	{0xffffffff, 0x5afa5afa},
-	{0xffffffff, 0xaaaaaaaa},/* case-120 */
+	{0xffffffff, 0xaaaaaaaa}, /* case-120 */
 	{0x55ff55ff, 0x5afa5afa},
 	{0x55ff55ff, 0xaaaaaaaa},
 	{0x55ff55ff, 0x55ff55ff}
@@ -4040,7 +4043,7 @@ static const struct coex_table_para table_nsant_8822c[] = {
 /* Shared-Antenna TDMA */
 static const struct coex_tdma_para tdma_sant_8822c[] = {
 	{ {0x00, 0x00, 0x00, 0x00, 0x00} }, /* case-0 */
-	{ {0x61, 0x45, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x45, 0x03, 0x11, 0x11} }, /* case-1 */
 	{ {0x61, 0x3a, 0x03, 0x11, 0x11} },
 	{ {0x61, 0x30, 0x03, 0x11, 0x11} },
 	{ {0x61, 0x20, 0x03, 0x11, 0x11} },
@@ -4055,7 +4058,7 @@ static const struct coex_tdma_para tdma_sant_8822c[] = {
 	{ {0x51, 0x08, 0x03, 0x10, 0x54} },
 	{ {0x51, 0x08, 0x03, 0x10, 0x55} },
 	{ {0x51, 0x08, 0x07, 0x10, 0x54} }, /* case-15 */
-	{ {0x51, 0x45, 0x03, 0x10, 0x10} },
+	{ {0x51, 0x45, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x3a, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x30, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x20, 0x03, 0x10, 0x50} },
@@ -4063,7 +4066,7 @@ static const struct coex_tdma_para tdma_sant_8822c[] = {
 	{ {0x51, 0x4a, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x0c, 0x03, 0x10, 0x54} },
 	{ {0x55, 0x08, 0x03, 0x10, 0x54} },
-	{ {0x65, 0x10, 0x03, 0x11, 0x11} },
+	{ {0x65, 0x10, 0x03, 0x11, 0x10} },
 	{ {0x51, 0x10, 0x03, 0x10, 0x51} }, /* case-25 */
 	{ {0x51, 0x08, 0x03, 0x10, 0x50} },
 	{ {0x61, 0x08, 0x03, 0x11, 0x11} }
@@ -4091,7 +4094,8 @@ static const struct coex_tdma_para tdma_nsant_8822c[] = {
 	{ {0x51, 0x3a, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x30, 0x03, 0x10, 0x50} },
 	{ {0x51, 0x20, 0x03, 0x10, 0x50} },
-	{ {0x51, 0x10, 0x03, 0x10, 0x50} }  /* case-120 */
+	{ {0x51, 0x10, 0x03, 0x10, 0x50} }, /* case-120 */
+	{ {0x51, 0x08, 0x03, 0x10, 0x50} }
 };
 
 /* rssi in percentage % (dbm = % - 100) */
-- 
2.21.0

