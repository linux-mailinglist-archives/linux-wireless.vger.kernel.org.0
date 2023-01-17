Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4892666DCB5
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 12:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbjAQLmB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 06:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbjAQLl5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 06:41:57 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCDA41F5C1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 03:41:55 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30HBflvuF012226, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30HBflvuF012226
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 17 Jan 2023 19:41:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 17 Jan 2023 19:41:47 +0800
Received: from localhost (172.16.17.65) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 17 Jan
 2023 19:41:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/8] wifi: rtw89: coex: Refine coexistence log
Date:   Tue, 17 Jan 2023 19:41:05 +0800
Message-ID: <20230117114109.4298-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230117114109.4298-1-pkshih@realtek.com>
References: <20230117114109.4298-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.65]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/17/2023 11:09:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTcgpFekyCAwOToxNDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Adjust the log format and correct variable reference to make the log
more readable.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 158 +++++++++++-----------
 1 file changed, 76 insertions(+), 82 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 5d6d6230344b0..33f369e4ff4cf 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -6401,20 +6401,21 @@ static void _show_fbtc_slots(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 	for (i = 0; i < CXST_MAX; i++) {
 		s = &dm->slot_now[i];
-		if (i % 6 == 0)
+		if (i % 5 == 0)
 			seq_printf(m,
-				   " %-15s : %02d[%03d/0x%x/%d]",
+				   " %-15s : %5s[%03d/0x%x/%d]",
 				   "[slot_list]",
-				   (u32)i,
+				   id_to_slot((u32)i),
 				   s->dur, s->cxtbl, s->cxtype);
 		else
 			seq_printf(m,
-				   ", %02d[%03d/0x%x/%d]",
-				   (u32)i,
+				   ", %5s[%03d/0x%x/%d]",
+				   id_to_slot((u32)i),
 				   s->dur, s->cxtbl, s->cxtype);
-		if (i % 6 == 5)
+		if (i % 5 == 4)
 			seq_puts(m, "\n");
 	}
+	seq_puts(m, "\n");
 }
 
 static void _show_fbtc_cysta_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
@@ -6446,7 +6447,7 @@ static void _show_fbtc_cysta_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 	for (i = 0; i < CXST_MAX; i++) {
 		if (!le32_to_cpu(pcysta_le32->slot_cnt[i]))
 			continue;
-		seq_printf(m, ", %d:%d", (u32)i,
+		seq_printf(m, ", %s:%d", id_to_slot((u32)i),
 			   le32_to_cpu(pcysta_le32->slot_cnt[i]));
 	}
 
@@ -6481,7 +6482,7 @@ static void _show_fbtc_cysta_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   le16_to_cpu(pcysta_le32->tmaxdiff_cycle[CXT_WL]),
 		   le16_to_cpu(pcysta_le32->tmaxdiff_cycle[CXT_BT]));
 
-	if (le16_to_cpu(pcysta_le32->cycles) == 0)
+	if (le16_to_cpu(pcysta_le32->cycles) <= 1)
 		return;
 
 	/* 1 cycle record 1 wl-slot and 1 bt-slot */
@@ -6608,7 +6609,7 @@ static void _show_fbtc_cysta_v3(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   le16_to_cpu(pcysta->cycle_time.tmaxdiff[CXT_BT]));
 
 	cycle = le16_to_cpu(pcysta->cycles);
-	if (cycle == 0)
+	if (cycle <= 1)
 		return;
 
 	/* 1 cycle record 1 wl-slot and 1 bt-slot */
@@ -6630,40 +6631,39 @@ static void _show_fbtc_cysta_v3(struct rtw89_dev *rtwdev, struct seq_file *m)
 		cnt++;
 		store_index = ((cycle - 1) % slot_pair) * 2;
 
-		if (cnt % divide_cnt == 1) {
-			seq_printf(m, "\n\r %-15s : ", "[cycle_step]");
-		} else {
-			seq_printf(m, "->b%02d",
-				   le16_to_cpu(pcysta->slot_step_time[store_index]));
-			if (a2dp->exist) {
-				a2dp_trx = &pcysta->a2dp_trx[store_index];
-				seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
-					   a2dp_trx->empty_cnt,
-					   a2dp_trx->retry_cnt,
-					   a2dp_trx->tx_rate ? 3 : 2,
-					   a2dp_trx->tx_cnt,
-					   a2dp_trx->ack_cnt,
-					   a2dp_trx->nack_cnt);
-			}
-			seq_printf(m, "->w%02d",
-				   le16_to_cpu(pcysta->slot_step_time[store_index + 1]));
-			if (a2dp->exist) {
-				a2dp_trx = &pcysta->a2dp_trx[store_index + 1];
-				seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
-					   a2dp_trx->empty_cnt,
-					   a2dp_trx->retry_cnt,
-					   a2dp_trx->tx_rate ? 3 : 2,
-					   a2dp_trx->tx_cnt,
-					   a2dp_trx->ack_cnt,
-					   a2dp_trx->nack_cnt);
-			}
+		if (cnt % divide_cnt == 1)
+			seq_printf(m, " %-15s : ", "[cycle_step]");
+
+		seq_printf(m, "->b%02d",
+			   le16_to_cpu(pcysta->slot_step_time[store_index]));
+		if (a2dp->exist) {
+			a2dp_trx = &pcysta->a2dp_trx[store_index];
+			seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
+				   a2dp_trx->empty_cnt,
+				   a2dp_trx->retry_cnt,
+				   a2dp_trx->tx_rate ? 3 : 2,
+				   a2dp_trx->tx_cnt,
+				   a2dp_trx->ack_cnt,
+				   a2dp_trx->nack_cnt);
 		}
-		if (cnt % (BTC_CYCLE_SLOT_MAX / 4) == 0 || cnt == c_end)
+		seq_printf(m, "->w%02d",
+			   le16_to_cpu(pcysta->slot_step_time[store_index + 1]));
+		if (a2dp->exist) {
+			a2dp_trx = &pcysta->a2dp_trx[store_index + 1];
+			seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
+				   a2dp_trx->empty_cnt,
+				   a2dp_trx->retry_cnt,
+				   a2dp_trx->tx_rate ? 3 : 2,
+				   a2dp_trx->tx_cnt,
+				   a2dp_trx->ack_cnt,
+				   a2dp_trx->nack_cnt);
+		}
+		if (cnt % divide_cnt == 0 || cnt == c_end)
 			seq_puts(m, "\n");
 	}
 
 	if (a2dp->exist) {
-		seq_printf(m, "%-15s : a2dp_ept:%d, a2dp_late:%d",
+		seq_printf(m, " %-15s : a2dp_ept:%d, a2dp_late:%d",
 			   "[a2dp_t_sta]",
 			   le16_to_cpu(pcysta->a2dp_ept.cnt),
 			   le16_to_cpu(pcysta->a2dp_ept.cnt_timeout));
@@ -6741,7 +6741,7 @@ static void _show_fbtc_cysta_v4(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   le16_to_cpu(pcysta->cycle_time.tmaxdiff[CXT_BT]));
 
 	cycle = le16_to_cpu(pcysta->cycles);
-	if (cycle == 0)
+	if (cycle <= 1)
 		return;
 
 	/* 1 cycle record 1 wl-slot and 1 bt-slot */
@@ -6763,40 +6763,39 @@ static void _show_fbtc_cysta_v4(struct rtw89_dev *rtwdev, struct seq_file *m)
 		cnt++;
 		store_index = ((cycle - 1) % slot_pair) * 2;
 
-		if (cnt % divide_cnt == 1) {
-			seq_printf(m, "\n\r %-15s : ", "[cycle_step]");
-		} else {
-			seq_printf(m, "->b%02d",
-				   le16_to_cpu(pcysta->slot_step_time[store_index]));
-			if (a2dp->exist) {
-				a2dp_trx = &pcysta->a2dp_trx[store_index];
-				seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
-					   a2dp_trx->empty_cnt,
-					   a2dp_trx->retry_cnt,
-					   a2dp_trx->tx_rate ? 3 : 2,
-					   a2dp_trx->tx_cnt,
-					   a2dp_trx->ack_cnt,
-					   a2dp_trx->nack_cnt);
-			}
-			seq_printf(m, "->w%02d",
-				   le16_to_cpu(pcysta->slot_step_time[store_index + 1]));
-			if (a2dp->exist) {
-				a2dp_trx = &pcysta->a2dp_trx[store_index + 1];
-				seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
-					   a2dp_trx->empty_cnt,
-					   a2dp_trx->retry_cnt,
-					   a2dp_trx->tx_rate ? 3 : 2,
-					   a2dp_trx->tx_cnt,
-					   a2dp_trx->ack_cnt,
-					   a2dp_trx->nack_cnt);
-			}
+		if (cnt % divide_cnt == 1)
+			seq_printf(m, " %-15s : ", "[cycle_step]");
+
+		seq_printf(m, "->b%02d",
+			   le16_to_cpu(pcysta->slot_step_time[store_index]));
+		if (a2dp->exist) {
+			a2dp_trx = &pcysta->a2dp_trx[store_index];
+			seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
+				   a2dp_trx->empty_cnt,
+				   a2dp_trx->retry_cnt,
+				   a2dp_trx->tx_rate ? 3 : 2,
+				   a2dp_trx->tx_cnt,
+				   a2dp_trx->ack_cnt,
+				   a2dp_trx->nack_cnt);
 		}
-		if (cnt % (BTC_CYCLE_SLOT_MAX / 4) == 0 || cnt == c_end)
+		seq_printf(m, "->w%02d",
+			   le16_to_cpu(pcysta->slot_step_time[store_index + 1]));
+		if (a2dp->exist) {
+			a2dp_trx = &pcysta->a2dp_trx[store_index + 1];
+			seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
+				   a2dp_trx->empty_cnt,
+				   a2dp_trx->retry_cnt,
+				   a2dp_trx->tx_rate ? 3 : 2,
+				   a2dp_trx->tx_cnt,
+				   a2dp_trx->ack_cnt,
+				   a2dp_trx->nack_cnt);
+		}
+		if (cnt % divide_cnt == 0 || cnt == c_end)
 			seq_puts(m, "\n");
 	}
 
 	if (a2dp->exist) {
-		seq_printf(m, "%-15s : a2dp_ept:%d, a2dp_late:%d",
+		seq_printf(m, " %-15s : a2dp_ept:%d, a2dp_late:%d",
 			   "[a2dp_t_sta]",
 			   le16_to_cpu(pcysta->a2dp_ept.cnt),
 			   le16_to_cpu(pcysta->a2dp_ept.cnt_timeout));
@@ -6827,13 +6826,9 @@ static void _show_fbtc_nullsta(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 	ns = &pfwinfo->rpt_fbtc_nullsta.finfo;
 	if (ver->fcxnullsta == 1) {
-		seq_printf(m, " %-15s : ", "[null_sta]");
-
 		for (i = 0; i < 2; i++) {
-			if (i != 0)
-				seq_printf(m, ", null-%d", i);
-			else
-				seq_printf(m, "null-%d", i);
+			seq_printf(m, " %-15s : ", "[NULL-STA]");
+			seq_printf(m, "null-%d", i);
 			seq_printf(m, "[ok:%d/",
 				   le32_to_cpu(ns->v1.result[i][1]));
 			seq_printf(m, "fail:%d/",
@@ -6845,17 +6840,14 @@ static void _show_fbtc_nullsta(struct rtw89_dev *rtwdev, struct seq_file *m)
 			seq_printf(m, "avg_t:%d.%03d/",
 				   le32_to_cpu(ns->v1.avg_t[i]) / 1000,
 				   le32_to_cpu(ns->v1.avg_t[i]) % 1000);
-			seq_printf(m, "max_t:%d.%03d]",
+			seq_printf(m, "max_t:%d.%03d]\n",
 				   le32_to_cpu(ns->v1.max_t[i]) / 1000,
 				   le32_to_cpu(ns->v1.max_t[i]) % 1000);
 		}
 	} else {
-		seq_printf(m, " %-15s : ", "[null_sta]");
 		for (i = 0; i < 2; i++) {
-			if (i != 0)
-				seq_printf(m, ", null-%d", i);
-			else
-				seq_printf(m, "null-%d", i);
+			seq_printf(m, " %-15s : ", "[NULL-STA]");
+			seq_printf(m, "null-%d", i);
 			seq_printf(m, "[Tx:%d/",
 				   le32_to_cpu(ns->v2.result[i][4]));
 			seq_printf(m, "[ok:%d/",
@@ -6869,12 +6861,11 @@ static void _show_fbtc_nullsta(struct rtw89_dev *rtwdev, struct seq_file *m)
 			seq_printf(m, "avg_t:%d.%03d/",
 				   le32_to_cpu(ns->v2.avg_t[i]) / 1000,
 				   le32_to_cpu(ns->v2.avg_t[i]) % 1000);
-			seq_printf(m, "max_t:%d.%03d]",
+			seq_printf(m, "max_t:%d.%03d]\n",
 				   le32_to_cpu(ns->v2.max_t[i]) / 1000,
 				   le32_to_cpu(ns->v2.max_t[i]) % 1000);
 		}
 	}
-	seq_puts(m, "\n");
 }
 
 static void _show_fbtc_step_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
@@ -7147,6 +7138,9 @@ static void _show_mreg(struct rtw89_dev *rtwdev, struct seq_file *m)
 		if (cnt % 6 == 5)
 			seq_puts(m, "\n");
 		cnt++;
+
+		if (i >= pmreg->reg_num)
+			seq_puts(m, "\n");
 	}
 
 	pcinfo = &pfwinfo->rpt_fbtc_gpio_dbg.cinfo;
-- 
2.25.1

