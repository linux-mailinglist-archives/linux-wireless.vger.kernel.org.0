Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C47157F844
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 04:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiGYCgE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Jul 2022 22:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiGYCgA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Jul 2022 22:36:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F193EE080
        for <linux-wireless@vger.kernel.org>; Sun, 24 Jul 2022 19:35:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 26P2ZcarE014742, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 26P2ZcarE014742
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 25 Jul 2022 10:35:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 10:35:44 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Mon, 25 Jul
 2022 10:35:43 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 5/9] rtw89: coex: Add v1 version TDMA format and parameters
Date:   Mon, 25 Jul 2022 10:35:05 +0800
Message-ID: <20220725023509.43114-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725023509.43114-1-pkshih@realtek.com>
References: <20220725023509.43114-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 07/25/2022 02:16:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzcvMjQgpFWkyCAxMToyOTowMA==?=
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

RTL8852C use a later version Wi-Fi firmware, there are some parameters
need to be defined. These new parameter can avoid some unexpected
TDMA mode while Wi-Fi enter/leave lps.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 73 +++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/core.h | 19 ++++--
 2 files changed, 75 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index f8e335ead91a2..d520f144ee23a 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -923,8 +923,13 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_TDMA:
 		pcinfo = &pfwinfo->rpt_fbtc_tdma.cinfo;
-		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_tdma.finfo);
-		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_tdma.finfo);
+		if (chip->chip_id == RTL8852A) {
+			pfinfo = (u8 *)&pfwinfo->rpt_fbtc_tdma.finfo;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_tdma.finfo);
+		} else {
+			pfinfo = (u8 *)&pfwinfo->rpt_fbtc_tdma.finfo_v1;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_tdma.finfo_v1);
+		}
 		pcinfo->req_fver = chip->fcxtdma_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
@@ -1037,7 +1042,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	memcpy(pfinfo, rpt_content, pcinfo->req_len);
 	pcinfo->valid = 1;
 
-	if (rpt_type == BTC_RPT_TYPE_TDMA) {
+	if (rpt_type == BTC_RPT_TYPE_TDMA && chip->chip_id == RTL8852A) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): check %d %zu\n", __func__,
 			    BTC_DCNT_TDMA_NONSYNC, sizeof(dm->tdma_now));
@@ -1050,7 +1055,8 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				    dm->tdma_now.type, dm->tdma_now.rxflctrl,
 				    dm->tdma_now.txpause, dm->tdma_now.wtgle_n,
 				    dm->tdma_now.leak_n, dm->tdma_now.ext_ctrl,
-				    dm->tdma_now.rsvd0, dm->tdma_now.rsvd1);
+				    dm->tdma_now.rxflctrl_role,
+				    dm->tdma_now.option_ctrl);
 
 			rtw89_debug(rtwdev, RTW89_DBG_BTC,
 				    "[BTC], %s(): %d rpt_fbtc_tdma %x %x %x %x %x %x %x %x\n",
@@ -1061,14 +1067,46 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				    pfwinfo->rpt_fbtc_tdma.finfo.wtgle_n,
 				    pfwinfo->rpt_fbtc_tdma.finfo.leak_n,
 				    pfwinfo->rpt_fbtc_tdma.finfo.ext_ctrl,
-				    pfwinfo->rpt_fbtc_tdma.finfo.rsvd0,
-				    pfwinfo->rpt_fbtc_tdma.finfo.rsvd1);
+				    pfwinfo->rpt_fbtc_tdma.finfo.rxflctrl_role,
+				    pfwinfo->rpt_fbtc_tdma.finfo.option_ctrl);
 		}
 
 		_chk_btc_err(rtwdev, BTC_DCNT_TDMA_NONSYNC,
 			     memcmp(&dm->tdma_now,
 				    &pfwinfo->rpt_fbtc_tdma.finfo,
 				    sizeof(dm->tdma_now)));
+	} else if (rpt_type == BTC_RPT_TYPE_TDMA) {
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s(): check %d %zu\n", __func__,
+			    BTC_DCNT_TDMA_NONSYNC, sizeof(dm->tdma_now));
+
+		if (memcmp(&dm->tdma_now, &pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma,
+			   sizeof(dm->tdma_now)) != 0) {
+			rtw89_debug(rtwdev, RTW89_DBG_BTC,
+				    "[BTC], %s(): %d tdma_now %x %x %x %x %x %x %x %x\n",
+				    __func__, BTC_DCNT_TDMA_NONSYNC,
+				    dm->tdma_now.type, dm->tdma_now.rxflctrl,
+				    dm->tdma_now.txpause, dm->tdma_now.wtgle_n,
+				    dm->tdma_now.leak_n, dm->tdma_now.ext_ctrl,
+				    dm->tdma_now.rxflctrl_role,
+				    dm->tdma_now.option_ctrl);
+			rtw89_debug(rtwdev, RTW89_DBG_BTC,
+				    "[BTC], %s(): %d rpt_fbtc_tdma %x %x %x %x %x %x %x %x\n",
+				    __func__, BTC_DCNT_TDMA_NONSYNC,
+				    pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma.type,
+				    pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma.rxflctrl,
+				    pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma.txpause,
+				    pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma.wtgle_n,
+				    pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma.leak_n,
+				    pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma.ext_ctrl,
+				    pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma.rxflctrl_role,
+				    pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma.option_ctrl);
+		}
+
+		_chk_btc_err(rtwdev, BTC_DCNT_TDMA_NONSYNC,
+			     memcmp(&dm->tdma_now,
+				    &pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma,
+				    sizeof(dm->tdma_now)));
 	}
 
 	if (rpt_type == BTC_RPT_TYPE_SLOT) {
@@ -1220,10 +1258,12 @@ static void _parse_btc_report(struct rtw89_dev *rtwdev,
 
 static void _append_tdma(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
-	struct rtw89_btc_btf_tlv *tlv = NULL;
-	struct rtw89_btc_fbtc_tdma *v = NULL;
+	struct rtw89_btc_btf_tlv *tlv;
+	struct rtw89_btc_fbtc_tdma *v;
+	struct rtw89_btc_fbtc_tdma_v1 *v1;
 	u16 len = btc->policy_len;
 
 	if (!btc->update_policy_force &&
@@ -1235,12 +1275,19 @@ static void _append_tdma(struct rtw89_dev *rtwdev)
 	}
 
 	tlv = (struct rtw89_btc_btf_tlv *)&btc->policy[len];
-	v = (struct rtw89_btc_fbtc_tdma *)&tlv->val[0];
 	tlv->type = CXPOLICY_TDMA;
-	tlv->len = sizeof(*v);
-
-	memcpy(v, &dm->tdma, sizeof(*v));
-	btc->policy_len += BTC_TLV_HDR_LEN  + sizeof(*v);
+	if (chip->chip_id == RTL8852A) {
+		v = (struct rtw89_btc_fbtc_tdma *)&tlv->val[0];
+		tlv->len = sizeof(*v);
+		memcpy(v, &dm->tdma, sizeof(*v));
+		btc->policy_len += BTC_TLV_HDR_LEN  + sizeof(*v);
+	} else {
+		tlv->len = sizeof(*v1);
+		v1 = (struct rtw89_btc_fbtc_tdma_v1 *)&tlv->val[0];
+		v1->fver = chip->fcxtdma_ver;
+		v1->tdma = dm->tdma;
+		btc->policy_len += BTC_TLV_HDR_LEN  + sizeof(*v1);
+	}
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): type:%d, rxflctrl=%d, txpause=%d, wtgle_n=%d, leak_n=%d, ext_ctrl=%d\n",
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6722aa26e48f4..6597365786e8f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1368,8 +1368,15 @@ struct rtw89_btc_fbtc_tdma {
 	u8 wtgle_n;
 	u8 leak_n;
 	u8 ext_ctrl;
-	u8 rsvd0;
-	u8 rsvd1;
+	u8 rxflctrl_role;
+	u8 option_ctrl;
+} __packed;
+
+struct rtw89_btc_fbtc_tdma_v1 {
+	u8 fver; /* chip_info::fcxtdma_ver */
+	u8 rsvd;
+	__le16 rsvd1;
+	struct rtw89_btc_fbtc_tdma tdma;
 } __packed;
 
 #define CXMREG_MAX 30
@@ -1683,7 +1690,8 @@ struct rtw89_btc_dm {
 	u32 wl_btg_rx: 1;
 	u32 trx_para_level: 8;
 	u32 wl_stb_chg: 1;
-	u32 rsvd: 3;
+	u32 tdma_instant_excute: 1;
+	u32 rsvd: 2;
 
 	u16 slot_dur[CXST_MAX];
 
@@ -1765,7 +1773,10 @@ struct rtw89_btc_report_ctrl_state {
 
 struct rtw89_btc_rpt_fbtc_tdma {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
-	struct rtw89_btc_fbtc_tdma finfo; /* info from fw */
+	union {
+		struct rtw89_btc_fbtc_tdma finfo; /* info from fw */
+		struct rtw89_btc_fbtc_tdma_v1 finfo_v1; /* info from fw for 52C*/
+	};
 };
 
 struct rtw89_btc_rpt_fbtc_slots {
-- 
2.25.1

