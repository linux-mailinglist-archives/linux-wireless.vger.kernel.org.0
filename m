Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887185ACEC3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Sep 2022 11:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiIEJ03 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Sep 2022 05:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbiIEJ00 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Sep 2022 05:26:26 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A53783CBEB
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 02:26:23 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2859PpyoE013720, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2859PpyoE013720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 5 Sep 2022 17:25:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 17:26:10 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 5 Sep 2022
 17:26:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] wifi: rtw89: coex: Add v1 Wi-Fi firmware power-saving null data report
Date:   Mon, 5 Sep 2022 17:25:34 +0800
Message-ID: <20220905092539.51926-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905092539.51926-1-pkshih@realtek.com>
References: <20220905092539.51926-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/05/2022 09:05:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvNSCkV6TIIDAzOjM4OjAw?=
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

From: Ching-Te Ku <ku920601@realtek.com>

The later version Wi-Fi firmware will report null data TX times,
so the structure is different from before.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 82 +++++++++++++++++------
 drivers/net/wireless/realtek/rtw89/core.h | 14 +++-
 2 files changed, 74 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 398bc395bc392..74d503ea4965e 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1003,8 +1003,13 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_NULLSTA:
 		pcinfo = &pfwinfo->rpt_fbtc_nullsta.cinfo;
-		pfinfo = &pfwinfo->rpt_fbtc_nullsta.finfo;
-		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_nullsta.finfo);
+		if (chip->chip_id == RTL8852A) {
+			pfinfo = &pfwinfo->rpt_fbtc_nullsta.finfo;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_nullsta.finfo);
+		} else {
+			pfinfo = &pfwinfo->rpt_fbtc_nullsta.finfo_v1;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_nullsta.finfo_v1);
+		}
 		pcinfo->req_fver = chip->fcxnullsta_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
@@ -6218,10 +6223,12 @@ static void _show_fbtc_cysta(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 static void _show_fbtc_nullsta(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
-	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
-	struct rtw89_btc_fbtc_cynullsta *ns = NULL;
+	struct rtw89_btc_rpt_cmn_info *pcinfo;
+	struct rtw89_btc_fbtc_cynullsta *ns;
+	struct rtw89_btc_fbtc_cynullsta_v1 *ns_v1;
 	u8 i = 0;
 
 	if (!btc->dm.tdma_now.rxflctrl)
@@ -6231,25 +6238,58 @@ static void _show_fbtc_nullsta(struct rtw89_dev *rtwdev, struct seq_file *m)
 	if (!pcinfo->valid)
 		return;
 
-	ns = &pfwinfo->rpt_fbtc_nullsta.finfo;
+	if (chip->chip_id == RTL8852A) {
+		ns = &pfwinfo->rpt_fbtc_nullsta.finfo;
 
-	seq_printf(m, " %-15s : ", "[null_sta]");
+		seq_printf(m, " %-15s : ", "[null_sta]");
 
-	for (i = 0; i < 2; i++) {
-		if (i != 0)
-			seq_printf(m, ", null-%d", i);
-		else
-			seq_printf(m, "null-%d", i);
-		seq_printf(m, "[ok:%d/", le32_to_cpu(ns->result[i][1]));
-		seq_printf(m, "fail:%d/", le32_to_cpu(ns->result[i][0]));
-		seq_printf(m, "on_time:%d/", le32_to_cpu(ns->result[i][2]));
-		seq_printf(m, "retry:%d/", le32_to_cpu(ns->result[i][3]));
-		seq_printf(m, "avg_t:%d.%03d/",
-			   le32_to_cpu(ns->avg_t[i]) / 1000,
-			   le32_to_cpu(ns->avg_t[i]) % 1000);
-		seq_printf(m, "max_t:%d.%03d]",
-			   le32_to_cpu(ns->max_t[i]) / 1000,
-			   le32_to_cpu(ns->max_t[i]) % 1000);
+		for (i = 0; i < 2; i++) {
+			if (i != 0)
+				seq_printf(m, ", null-%d", i);
+			else
+				seq_printf(m, "null-%d", i);
+			seq_printf(m, "[ok:%d/",
+				   le32_to_cpu(ns->result[i][1]));
+			seq_printf(m, "fail:%d/",
+				   le32_to_cpu(ns->result[i][0]));
+			seq_printf(m, "on_time:%d/",
+				   le32_to_cpu(ns->result[i][2]));
+			seq_printf(m, "retry:%d/",
+				   le32_to_cpu(ns->result[i][3]));
+			seq_printf(m, "avg_t:%d.%03d/",
+				   le32_to_cpu(ns->avg_t[i]) / 1000,
+				   le32_to_cpu(ns->avg_t[i]) % 1000);
+			seq_printf(m, "max_t:%d.%03d]",
+				   le32_to_cpu(ns->max_t[i]) / 1000,
+				   le32_to_cpu(ns->max_t[i]) % 1000);
+		}
+	} else {
+		ns_v1 = &pfwinfo->rpt_fbtc_nullsta.finfo_v1;
+
+		seq_printf(m, " %-15s : ", "[null_sta]");
+
+		for (i = 0; i < 2; i++) {
+			if (i != 0)
+				seq_printf(m, ", null-%d", i);
+			else
+				seq_printf(m, "null-%d", i);
+			seq_printf(m, "[Tx:%d/",
+				   le32_to_cpu(ns_v1->result[i][4]));
+			seq_printf(m, "[ok:%d/",
+				   le32_to_cpu(ns_v1->result[i][1]));
+			seq_printf(m, "fail:%d/",
+				   le32_to_cpu(ns_v1->result[i][0]));
+			seq_printf(m, "on_time:%d/",
+				   le32_to_cpu(ns_v1->result[i][2]));
+			seq_printf(m, "retry:%d/",
+				   le32_to_cpu(ns_v1->result[i][3]));
+			seq_printf(m, "avg_t:%d.%03d/",
+				   le32_to_cpu(ns_v1->avg_t[i]) / 1000,
+				   le32_to_cpu(ns_v1->avg_t[i]) % 1000);
+			seq_printf(m, "max_t:%d.%03d]",
+				   le32_to_cpu(ns_v1->max_t[i]) / 1000,
+				   le32_to_cpu(ns_v1->max_t[i]) % 1000);
+		}
 	}
 	seq_puts(m, "\n");
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b5fa61eb24f06..b480ba6eac3b1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1717,6 +1717,15 @@ struct rtw89_btc_fbtc_cynullsta { /* cycle null statistics */
 	__le32 result[2][4]; /* 0:fail, 1:ok, 2:on_time, 3:retry */
 } __packed;
 
+struct rtw89_btc_fbtc_cynullsta_v1 { /* cycle null statistics */
+	u8 fver; /* chip_info::fcxnullsta_ver */
+	u8 rsvd;
+	__le16 rsvd2;
+	__le32 max_t[2]; /* max_t for 0:null0/1:null1 */
+	__le32 avg_t[2]; /* avg_t for 0:null0/1:null1 */
+	__le32 result[2][5]; /* 0:fail, 1:ok, 2:on_time, 3:retry, 4:tx */
+} __packed;
+
 struct rtw89_btc_fbtc_btver {
 	u8 fver; /* chip_info::fcxbtver_ver */
 	u8 rsvd;
@@ -1897,7 +1906,10 @@ struct rtw89_btc_rpt_fbtc_step {
 
 struct rtw89_btc_rpt_fbtc_nullsta {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
-	struct rtw89_btc_fbtc_cynullsta finfo; /* info from fw */
+	union {
+		struct rtw89_btc_fbtc_cynullsta finfo; /* info from fw */
+		struct rtw89_btc_fbtc_cynullsta_v1 finfo_v1; /* info from fw */
+	};
 };
 
 struct rtw89_btc_rpt_fbtc_mreg {
-- 
2.25.1

