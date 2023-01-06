Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A585265FFF2
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jan 2023 13:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjAFMJU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Jan 2023 07:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjAFMJQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Jan 2023 07:09:16 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8ADB72893
        for <linux-wireless@vger.kernel.org>; Fri,  6 Jan 2023 04:09:13 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 306C85qlC028238, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 306C85qlC028238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 6 Jan 2023 20:08:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 6 Jan 2023 20:09:02 +0800
Received: from localhost (172.16.18.220) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 6 Jan 2023
 20:09:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] wifi: rtw89: coex: Change Wi-Fi Null data report to version separate
Date:   Fri, 6 Jan 2023 20:08:39 +0800
Message-ID: <20230106120844.17441-3-pkshih@realtek.com>
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

Coexistence need to send Null data to stop AP keeps TX packet to DUT
before DUT coexistence switch to Bluetooth time slot, or it will be an
interference to DUT BT and because DUT will not RX packet from AP
the packet retry may harmful to WL TP. Compare to v1 version, the newer
firmware report will also report Null TX data counter.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 57 +++++++++++------------
 drivers/net/wireless/realtek/rtw89/core.h | 14 +++---
 2 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index f97ddbcb51046..eec1f5228c5dc 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1032,12 +1032,14 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_NULLSTA:
 		pcinfo = &pfwinfo->rpt_fbtc_nullsta.cinfo;
-		if (chip->chip_id == RTL8852A) {
+		if (ver->fcxnullsta == 1) {
 			pfinfo = &pfwinfo->rpt_fbtc_nullsta.finfo;
-			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_nullsta.finfo);
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_nullsta.finfo.v1);
+		} else if (ver->fcxnullsta == 2) {
+			pfinfo = &pfwinfo->rpt_fbtc_nullsta.finfo.v2;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_nullsta.finfo.v2);
 		} else {
-			pfinfo = &pfwinfo->rpt_fbtc_nullsta.finfo_v1;
-			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_nullsta.finfo_v1);
+			goto err;
 		}
 		pcinfo->req_fver = ver->fcxnullsta;
 		break;
@@ -6789,12 +6791,11 @@ static void _show_fbtc_cysta_v4(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 static void _show_fbtc_nullsta(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_rpt_cmn_info *pcinfo;
-	struct rtw89_btc_fbtc_cynullsta *ns;
-	struct rtw89_btc_fbtc_cynullsta_v1 *ns_v1;
+	union rtw89_btc_fbtc_cynullsta_info *ns;
 	u8 i = 0;
 
 	if (!btc->dm.tdma_now.rxflctrl)
@@ -6804,9 +6805,8 @@ static void _show_fbtc_nullsta(struct rtw89_dev *rtwdev, struct seq_file *m)
 	if (!pcinfo->valid)
 		return;
 
-	if (chip->chip_id == RTL8852A) {
-		ns = &pfwinfo->rpt_fbtc_nullsta.finfo;
-
+	ns = &pfwinfo->rpt_fbtc_nullsta.finfo;
+	if (ver->fcxnullsta == 1) {
 		seq_printf(m, " %-15s : ", "[null_sta]");
 
 		for (i = 0; i < 2; i++) {
@@ -6815,46 +6815,43 @@ static void _show_fbtc_nullsta(struct rtw89_dev *rtwdev, struct seq_file *m)
 			else
 				seq_printf(m, "null-%d", i);
 			seq_printf(m, "[ok:%d/",
-				   le32_to_cpu(ns->result[i][1]));
+				   le32_to_cpu(ns->v1.result[i][1]));
 			seq_printf(m, "fail:%d/",
-				   le32_to_cpu(ns->result[i][0]));
+				   le32_to_cpu(ns->v1.result[i][0]));
 			seq_printf(m, "on_time:%d/",
-				   le32_to_cpu(ns->result[i][2]));
+				   le32_to_cpu(ns->v1.result[i][2]));
 			seq_printf(m, "retry:%d/",
-				   le32_to_cpu(ns->result[i][3]));
+				   le32_to_cpu(ns->v1.result[i][3]));
 			seq_printf(m, "avg_t:%d.%03d/",
-				   le32_to_cpu(ns->avg_t[i]) / 1000,
-				   le32_to_cpu(ns->avg_t[i]) % 1000);
+				   le32_to_cpu(ns->v1.avg_t[i]) / 1000,
+				   le32_to_cpu(ns->v1.avg_t[i]) % 1000);
 			seq_printf(m, "max_t:%d.%03d]",
-				   le32_to_cpu(ns->max_t[i]) / 1000,
-				   le32_to_cpu(ns->max_t[i]) % 1000);
+				   le32_to_cpu(ns->v1.max_t[i]) / 1000,
+				   le32_to_cpu(ns->v1.max_t[i]) % 1000);
 		}
 	} else {
-		ns_v1 = &pfwinfo->rpt_fbtc_nullsta.finfo_v1;
-
 		seq_printf(m, " %-15s : ", "[null_sta]");
-
 		for (i = 0; i < 2; i++) {
 			if (i != 0)
 				seq_printf(m, ", null-%d", i);
 			else
 				seq_printf(m, "null-%d", i);
 			seq_printf(m, "[Tx:%d/",
-				   le32_to_cpu(ns_v1->result[i][4]));
+				   le32_to_cpu(ns->v2.result[i][4]));
 			seq_printf(m, "[ok:%d/",
-				   le32_to_cpu(ns_v1->result[i][1]));
+				   le32_to_cpu(ns->v2.result[i][1]));
 			seq_printf(m, "fail:%d/",
-				   le32_to_cpu(ns_v1->result[i][0]));
+				   le32_to_cpu(ns->v2.result[i][0]));
 			seq_printf(m, "on_time:%d/",
-				   le32_to_cpu(ns_v1->result[i][2]));
+				   le32_to_cpu(ns->v2.result[i][2]));
 			seq_printf(m, "retry:%d/",
-				   le32_to_cpu(ns_v1->result[i][3]));
+				   le32_to_cpu(ns->v2.result[i][3]));
 			seq_printf(m, "avg_t:%d.%03d/",
-				   le32_to_cpu(ns_v1->avg_t[i]) / 1000,
-				   le32_to_cpu(ns_v1->avg_t[i]) % 1000);
+				   le32_to_cpu(ns->v2.avg_t[i]) / 1000,
+				   le32_to_cpu(ns->v2.avg_t[i]) % 1000);
 			seq_printf(m, "max_t:%d.%03d]",
-				   le32_to_cpu(ns_v1->max_t[i]) / 1000,
-				   le32_to_cpu(ns_v1->max_t[i]) % 1000);
+				   le32_to_cpu(ns->v2.max_t[i]) / 1000,
+				   le32_to_cpu(ns->v2.max_t[i]) % 1000);
 		}
 	}
 	seq_puts(m, "\n");
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d0b4c00324572..dfde8801e97bb 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1865,7 +1865,7 @@ union rtw89_btc_fbtc_cysta_info {
 	struct rtw89_btc_fbtc_cysta_v4 v4;
 };
 
-struct rtw89_btc_fbtc_cynullsta { /* cycle null statistics */
+struct rtw89_btc_fbtc_cynullsta_v1 { /* cycle null statistics */
 	u8 fver; /* btc_ver::fcxnullsta */
 	u8 rsvd;
 	__le16 rsvd2;
@@ -1874,7 +1874,7 @@ struct rtw89_btc_fbtc_cynullsta { /* cycle null statistics */
 	__le32 result[2][4]; /* 0:fail, 1:ok, 2:on_time, 3:retry */
 } __packed;
 
-struct rtw89_btc_fbtc_cynullsta_v1 { /* cycle null statistics */
+struct rtw89_btc_fbtc_cynullsta_v2 { /* cycle null statistics */
 	u8 fver; /* btc_ver::fcxnullsta */
 	u8 rsvd;
 	__le16 rsvd2;
@@ -1883,6 +1883,11 @@ struct rtw89_btc_fbtc_cynullsta_v1 { /* cycle null statistics */
 	__le32 result[2][5]; /* 0:fail, 1:ok, 2:on_time, 3:retry, 4:tx */
 } __packed;
 
+union rtw89_btc_fbtc_cynullsta_info {
+	struct rtw89_btc_fbtc_cynullsta_v1 v1; /* info from fw */
+	struct rtw89_btc_fbtc_cynullsta_v2 v2;
+};
+
 struct rtw89_btc_fbtc_btver {
 	u8 fver; /* btc_ver::fcxbtver */
 	u8 rsvd;
@@ -2075,10 +2080,7 @@ struct rtw89_btc_rpt_fbtc_step {
 
 struct rtw89_btc_rpt_fbtc_nullsta {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
-	union {
-		struct rtw89_btc_fbtc_cynullsta finfo; /* info from fw */
-		struct rtw89_btc_fbtc_cynullsta_v1 finfo_v1; /* info from fw */
-	};
+	union rtw89_btc_fbtc_cynullsta_info finfo;
 };
 
 struct rtw89_btc_rpt_fbtc_mreg {
-- 
2.25.1

