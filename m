Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0512C5BD935
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 03:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiITBLn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 21:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiITBLT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 21:11:19 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0604452E7B
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 18:10:34 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28K19wNS2031055, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28K19wNS2031055
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 20 Sep 2022 09:09:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 09:10:21 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 20 Sep
 2022 09:10:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/9] wifi: rtw89: coex: add v1 Wi-Fi firmware steps report
Date:   Tue, 20 Sep 2022 09:09:34 +0800
Message-ID: <20220920010939.12173-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920010939.12173-1-pkshih@realtek.com>
References: <20220920010939.12173-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/20/2022 00:43:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTkgpFWkyCAwNzowODowMA==?=
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

This report is to record firmware call flow like notify events, and take
actions. This can help to address if firmware flow is in expectation.
Implement v1 parser to support 8852CE firmware report.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 14 +++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h | 13 ++++++++++++-
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 20e7daa7e175b..42fc90a359b06 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -997,9 +997,17 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_STEP:
 		pcinfo = &pfwinfo->rpt_fbtc_step.cinfo;
-		pfinfo = &pfwinfo->rpt_fbtc_step.finfo;
-		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_step.finfo.step[0]) *
-				  trace_step + 8;
+		if (chip->chip_id == RTL8852A) {
+			pfinfo = &pfwinfo->rpt_fbtc_step.finfo;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_step.finfo.step[0]) *
+					  trace_step +
+					  offsetof(struct rtw89_btc_fbtc_steps, step);
+		} else {
+			pfinfo = &pfwinfo->rpt_fbtc_step.finfo_v1;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_step.finfo_v1.step[0]) *
+					  trace_step +
+					  offsetof(struct rtw89_btc_fbtc_steps_v1, step);
+		}
 		pcinfo->req_fver = chip->fcxstep_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6e54a00d55b68..1d8e20708d092 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1629,6 +1629,14 @@ struct rtw89_btc_fbtc_steps {
 	struct rtw89_btc_fbtc_step step[FCXMAX_STEP];
 } __packed;
 
+struct rtw89_btc_fbtc_steps_v1 {
+	u8 fver;
+	u8 en;
+	__le16 rsvd;
+	__le32 cnt;
+	struct rtw89_btc_fbtc_step step[FCXMAX_STEP];
+} __packed;
+
 struct rtw89_btc_fbtc_cysta { /* statistics for cycles */
 	u8 fver; /* chip_info::fcxcysta_ver */
 	u8 rsvd;
@@ -1903,7 +1911,10 @@ struct rtw89_btc_rpt_fbtc_cysta {
 
 struct rtw89_btc_rpt_fbtc_step {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
-	struct rtw89_btc_fbtc_steps finfo; /* info from fw */
+	union {
+		struct rtw89_btc_fbtc_steps finfo; /* info from fw */
+		struct rtw89_btc_fbtc_steps_v1 finfo_v1; /* info from fw */
+	};
 };
 
 struct rtw89_btc_rpt_fbtc_nullsta {
-- 
2.25.1

