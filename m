Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE0564F934
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 15:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiLQOSP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Dec 2022 09:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiLQOSO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Dec 2022 09:18:14 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A574E11C1B
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:18:12 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BHEHFSC0024833, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BHEHFSC0024833
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 17 Dec 2022 22:17:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 17 Dec 2022 22:18:05 +0800
Received: from localhost (172.16.16.141) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 17 Dec
 2022 22:18:04 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/7] wifi: rtw89: coex: Change TDMA related logic to version separate
Date:   Sat, 17 Dec 2022 22:17:45 +0800
Message-ID: <20221217141745.43291-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221217141745.43291-1-pkshih@realtek.com>
References: <20221217141745.43291-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.141]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/17/2022 14:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzE3IKRXpMggMTE6MjQ6MDA=?=
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

In order to make different version of TDMA and coming update in the future
can all work well, use BTC format version to replace chip_id, because
format could change for specific chip_id.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 47 ++++++++++++-----------
 drivers/net/wireless/realtek/rtw89/core.h | 12 +++---
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index db0c694c4f92b..2cb7ed1636030 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1045,12 +1045,14 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_TDMA:
 		pcinfo = &pfwinfo->rpt_fbtc_tdma.cinfo;
-		if (chip->chip_id == RTL8852A) {
-			pfinfo = &pfwinfo->rpt_fbtc_tdma.finfo;
-			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_tdma.finfo);
+		if (ver->fcxtdma == 1) {
+			pfinfo = &pfwinfo->rpt_fbtc_tdma.finfo.v1;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_tdma.finfo.v1);
+		} else if (ver->fcxtdma == 3) {
+			pfinfo = &pfwinfo->rpt_fbtc_tdma.finfo.v3;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_tdma.finfo.v3);
 		} else {
-			pfinfo = &pfwinfo->rpt_fbtc_tdma.finfo_v1;
-			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_tdma.finfo_v1);
+			goto err;
 		}
 		pcinfo->req_fver = ver->fcxtdma;
 		break;
@@ -1232,16 +1234,18 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			    "[BTC], %s(): check %d %zu\n", __func__,
 			    BTC_DCNT_TDMA_NONSYNC,
 			    sizeof(dm->tdma_now));
-		if (chip->chip_id == RTL8852A)
+		if (ver->fcxtdma == 1)
 			_chk_btc_err(rtwdev, BTC_DCNT_TDMA_NONSYNC,
 				     memcmp(&dm->tdma_now,
-					    &pfwinfo->rpt_fbtc_tdma.finfo_v1,
+					    &pfwinfo->rpt_fbtc_tdma.finfo.v1,
 					    sizeof(dm->tdma_now)));
-		else
+		else if (ver->fcxtdma == 3)
 			_chk_btc_err(rtwdev, BTC_DCNT_TDMA_NONSYNC,
 				     memcmp(&dm->tdma_now,
-					    &pfwinfo->rpt_fbtc_tdma.finfo,
+					    &pfwinfo->rpt_fbtc_tdma.finfo.v3.tdma,
 					    sizeof(dm->tdma_now)));
+		else
+			goto err;
 		break;
 	case BTC_RPT_TYPE_SLOT:
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -1375,13 +1379,12 @@ static void _parse_btc_report(struct rtw89_dev *rtwdev,
 
 static void _append_tdma(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_btf_tlv *tlv;
 	struct rtw89_btc_fbtc_tdma *v;
-	struct rtw89_btc_fbtc_tdma_v1 *v1;
+	struct rtw89_btc_fbtc_tdma_v3 *v3;
 	u16 len = btc->policy_len;
 
 	if (!btc->update_policy_force &&
@@ -1394,17 +1397,17 @@ static void _append_tdma(struct rtw89_dev *rtwdev)
 
 	tlv = (struct rtw89_btc_btf_tlv *)&btc->policy[len];
 	tlv->type = CXPOLICY_TDMA;
-	if (chip->chip_id == RTL8852A) {
+	if (ver->fcxtdma == 1) {
 		v = (struct rtw89_btc_fbtc_tdma *)&tlv->val[0];
 		tlv->len = sizeof(*v);
 		memcpy(v, &dm->tdma, sizeof(*v));
-		btc->policy_len += BTC_TLV_HDR_LEN  + sizeof(*v);
+		btc->policy_len += BTC_TLV_HDR_LEN + sizeof(*v);
 	} else {
-		tlv->len = sizeof(*v1);
-		v1 = (struct rtw89_btc_fbtc_tdma_v1 *)&tlv->val[0];
-		v1->fver = ver->fcxtdma;
-		v1->tdma = dm->tdma;
-		btc->policy_len += BTC_TLV_HDR_LEN  + sizeof(*v1);
+		tlv->len = sizeof(*v3);
+		v3 = (struct rtw89_btc_fbtc_tdma_v3 *)&tlv->val[0];
+		v3->fver = ver->fcxtdma;
+		memcpy(&v3->tdma, &dm->tdma, sizeof(v3->tdma));
+		btc->policy_len += BTC_TLV_HDR_LEN + sizeof(*v3);
 	}
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -6281,8 +6284,8 @@ static void _show_error(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 static void _show_fbtc_tdma(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_fbtc_tdma *t = NULL;
@@ -6294,10 +6297,10 @@ static void _show_fbtc_tdma(struct rtw89_dev *rtwdev, struct seq_file *m)
 	if (!pcinfo->valid)
 		return;
 
-	if (chip->chip_id == RTL8852A)
-		t = &pfwinfo->rpt_fbtc_tdma.finfo;
+	if (ver->fcxtdma == 1)
+		t = &pfwinfo->rpt_fbtc_tdma.finfo.v1;
 	else
-		t = &pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma;
+		t = &pfwinfo->rpt_fbtc_tdma.finfo.v3.tdma;
 
 	seq_printf(m,
 		   " %-15s : ", "[tdma_policy]");
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index af42e67897b6e..2d7b8c7182472 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1450,13 +1450,18 @@ struct rtw89_btc_fbtc_tdma {
 	u8 option_ctrl;
 } __packed;
 
-struct rtw89_btc_fbtc_tdma_v1 {
+struct rtw89_btc_fbtc_tdma_v3 {
 	u8 fver; /* btc_ver::fcxtdma */
 	u8 rsvd;
 	__le16 rsvd1;
 	struct rtw89_btc_fbtc_tdma tdma;
 } __packed;
 
+union rtw89_btc_fbtc_tdma_le32 {
+	struct rtw89_btc_fbtc_tdma v1;
+	struct rtw89_btc_fbtc_tdma_v3 v3;
+};
+
 #define CXMREG_MAX 30
 #define FCXMAX_STEP 255 /*STEP trace record cnt, Max:65535, default:255*/
 #define BTC_CYCLE_SLOT_MAX 48 /* must be even number, non-zero */
@@ -1946,10 +1951,7 @@ struct rtw89_btc_report_ctrl_state {
 
 struct rtw89_btc_rpt_fbtc_tdma {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
-	union {
-		struct rtw89_btc_fbtc_tdma finfo; /* info from fw */
-		struct rtw89_btc_fbtc_tdma_v1 finfo_v1; /* info from fw for 52C*/
-	};
+	union rtw89_btc_fbtc_tdma_le32 finfo;
 };
 
 struct rtw89_btc_rpt_fbtc_slots {
-- 
2.25.1

