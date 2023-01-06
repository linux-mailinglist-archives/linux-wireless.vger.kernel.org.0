Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F2165FFF6
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jan 2023 13:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjAFMJZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Jan 2023 07:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjAFMJR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Jan 2023 07:09:17 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE46D72880
        for <linux-wireless@vger.kernel.org>; Fri,  6 Jan 2023 04:09:16 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 306C87QX0028254, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 306C87QX0028254
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 6 Jan 2023 20:08:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 6 Jan 2023 20:09:04 +0800
Received: from localhost (172.16.18.220) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 6 Jan 2023
 20:09:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/7] wifi: rtw89: coex: refactor debug log of slot list
Date:   Fri, 6 Jan 2023 20:08:41 +0800
Message-ID: <20230106120844.17441-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106120844.17441-1-pkshih@realtek.com>
References: <20230106120844.17441-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.18.220]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/06/2023 11:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvNiCkV6TIIDA5OjMyOjAw?=
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

From: Ching-Te Ku <ku920601@realtek.com>

Slot list is to list the WiFi/Bluetooth PTA hardware priority setting.
Move the list parser to its function, not to append together with TDMA
parser.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 45 +++--------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 5979efb5e465d..03872ac8cced0 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -6345,9 +6345,6 @@ static void _show_fbtc_tdma(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_fbtc_tdma *t = NULL;
-	struct rtw89_btc_fbtc_slot *s = NULL;
-	struct rtw89_btc_dm *dm = &btc->dm;
-	u8 i, cnt = 0;
 
 	pcinfo = &pfwinfo->rpt_fbtc_tdma.cinfo;
 	if (!pcinfo->valid)
@@ -6373,61 +6370,29 @@ static void _show_fbtc_tdma(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   "policy_type:%d",
 		   (u32)btc->policy_type);
 
-	s = pfwinfo->rpt_fbtc_slots.finfo.slot;
-
-	for (i = 0; i < CXST_MAX; i++) {
-		if (dm->update_slot_map == BIT(CXST_MAX) - 1)
-			break;
-
-		if (!(dm->update_slot_map & BIT(i)))
-			continue;
-
-		if (cnt % 6 == 0)
-			seq_printf(m,
-				   " %-15s : %d[%d/0x%x/%d]",
-				   "[slot_policy]",
-				   (u32)i,
-				   s[i].dur, s[i].cxtbl, s[i].cxtype);
-		else
-			seq_printf(m,
-				   ", %d[%d/0x%x/%d]",
-				   (u32)i,
-				   s[i].dur, s[i].cxtbl, s[i].cxtype);
-		if (cnt % 6 == 5)
-			seq_puts(m, "\n");
-		cnt++;
-	}
 	seq_puts(m, "\n");
 }
 
 static void _show_fbtc_slots(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
-	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
-	struct rtw89_btc_fbtc_slots *pslots = NULL;
-	struct rtw89_btc_fbtc_slot s;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_fbtc_slot *s;
 	u8 i = 0;
 
-	pcinfo = &pfwinfo->rpt_fbtc_slots.cinfo;
-	if (!pcinfo->valid)
-		return;
-
-	pslots = &pfwinfo->rpt_fbtc_slots.finfo;
-
 	for (i = 0; i < CXST_MAX; i++) {
-		s = pslots->slot[i];
+		s = &dm->slot_now[i];
 		if (i % 6 == 0)
 			seq_printf(m,
 				   " %-15s : %02d[%03d/0x%x/%d]",
 				   "[slot_list]",
 				   (u32)i,
-				   s.dur, s.cxtbl, s.cxtype);
+				   s->dur, s->cxtbl, s->cxtype);
 		else
 			seq_printf(m,
 				   ", %02d[%03d/0x%x/%d]",
 				   (u32)i,
-				   s.dur, s.cxtbl, s.cxtype);
+				   s->dur, s->cxtbl, s->cxtype);
 		if (i % 6 == 5)
 			seq_puts(m, "\n");
 	}
-- 
2.25.1

