Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E44F65C16E
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 15:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjACODi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 09:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbjACODX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 09:03:23 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD2E21055E
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 06:03:20 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 303E2BkkC016697, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 303E2BkkC016697
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 3 Jan 2023 22:02:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 3 Jan 2023 22:03:06 +0800
Received: from localhost (172.16.19.22) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 3 Jan 2023
 22:03:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] wifi: rtw89: coex: Rename BTC firmware cycle report by feature version
Date:   Tue, 3 Jan 2023 22:02:33 +0800
Message-ID: <20230103140238.15601-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230103140238.15601-1-pkshih@realtek.com>
References: <20230103140238.15601-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.19.22]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/03/2023 13:50:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMyCkVaTIIDAxOjA0OjAw?=
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

Because there are new report format in the upcoming patches, to make the
logic more readable, rename the related structure by their version number.
And to support the several version at the same time, add union definition
to include all the versions.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 107 +++++++++++-----------
 drivers/net/wireless/realtek/rtw89/core.h |  14 +--
 2 files changed, 64 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index a594f5c729608..be5ab2c4eefb3 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -932,8 +932,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_btc_fbtc_rpt_ctrl *prpt;
 	struct rtw89_btc_fbtc_rpt_ctrl_v1 *prpt_v1;
-	struct rtw89_btc_fbtc_cysta *pcysta = NULL;
-	struct rtw89_btc_fbtc_cysta_v1 *pcysta_v1 = NULL;
+	union rtw89_btc_fbtc_cysta_info *pcysta = NULL;
 	struct rtw89_btc_prpt *btc_prpt = NULL;
 	void *rpt_content = NULL, *pfinfo = NULL;
 	u8 rpt_type = 0;
@@ -993,14 +992,17 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_CYSTA:
 		pcinfo = &pfwinfo->rpt_fbtc_cysta.cinfo;
-		if (chip->chip_id == RTL8852A) {
-			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo;
-			pcysta = &pfwinfo->rpt_fbtc_cysta.finfo;
-			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo);
+		pcysta = &pfwinfo->rpt_fbtc_cysta.finfo;
+		if (ver->fcxcysta == 2) {
+			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo.v2;
+			pcysta->v2 = pfwinfo->rpt_fbtc_cysta.finfo.v2;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo.v2);
+		} else if (ver->fcxcysta == 3) {
+			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo.v3;
+			pcysta->v3 = pfwinfo->rpt_fbtc_cysta.finfo.v3;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo.v3);
 		} else {
-			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo_v1;
-			pcysta_v1 = &pfwinfo->rpt_fbtc_cysta.finfo_v1;
-			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo_v1);
+			goto err;
 		}
 		pcinfo->req_fver = ver->fcxcysta;
 		break;
@@ -1186,14 +1188,14 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				    sizeof(dm->slot_now)));
 		break;
 	case BTC_RPT_TYPE_CYSTA:
-		if (chip->chip_id == RTL8852A) {
-			if (le16_to_cpu(pcysta->cycles) < BTC_CYSTA_CHK_PERIOD)
+		if (ver->fcxcysta == 2) {
+			if (le16_to_cpu(pcysta->v2.cycles) < BTC_CYSTA_CHK_PERIOD)
 				break;
 			/* Check Leak-AP */
-			if (le32_to_cpu(pcysta->slot_cnt[CXST_LK]) != 0 &&
-			    le32_to_cpu(pcysta->leakrx_cnt) != 0 && dm->tdma_now.rxflctrl) {
-				if (le32_to_cpu(pcysta->slot_cnt[CXST_LK]) <
-				    BTC_LEAK_AP_TH * le32_to_cpu(pcysta->leakrx_cnt))
+			if (le32_to_cpu(pcysta->v2.slot_cnt[CXST_LK]) != 0 &&
+			    le32_to_cpu(pcysta->v2.leakrx_cnt) != 0 && dm->tdma_now.rxflctrl) {
+				if (le32_to_cpu(pcysta->v2.slot_cnt[CXST_LK]) <
+				    BTC_LEAK_AP_TH * le32_to_cpu(pcysta->v2.leakrx_cnt))
 					dm->leak_ap = 1;
 			}
 
@@ -1204,24 +1206,24 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			else
 				wl_slot_set = le16_to_cpu(dm->slot_now[CXST_W1].dur);
 
-			if (le16_to_cpu(pcysta->tavg_cycle[CXT_WL]) > wl_slot_set) {
-				diff_t = le16_to_cpu(pcysta->tavg_cycle[CXT_WL]) - wl_slot_set;
+			if (le16_to_cpu(pcysta->v2.tavg_cycle[CXT_WL]) > wl_slot_set) {
+				diff_t = le16_to_cpu(pcysta->v2.tavg_cycle[CXT_WL]) - wl_slot_set;
 				_chk_btc_err(rtwdev,
 					     BTC_DCNT_WL_SLOT_DRIFT, diff_t);
 			}
 
 			_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE,
-				     le32_to_cpu(pcysta->slot_cnt[CXST_W1]));
+				     le32_to_cpu(pcysta->v2.slot_cnt[CXST_W1]));
 			_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE,
-				     le32_to_cpu(pcysta->slot_cnt[CXST_B1]));
+				     le32_to_cpu(pcysta->v2.slot_cnt[CXST_B1]));
 			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE,
-				     le16_to_cpu(pcysta->cycles));
-		} else {
-			if (le16_to_cpu(pcysta_v1->cycles) < BTC_CYSTA_CHK_PERIOD)
+				     le16_to_cpu(pcysta->v2.cycles));
+		} else if (ver->fcxcysta == 3) {
+			if (le16_to_cpu(pcysta->v3.cycles) < BTC_CYSTA_CHK_PERIOD)
 				break;
 
-			cnt_leak_slot = le32_to_cpu(pcysta_v1->slot_cnt[CXST_LK]);
-			cnt_rx_imr = le32_to_cpu(pcysta_v1->leak_slot.cnt_rximr);
+			cnt_leak_slot = le32_to_cpu(pcysta->v3.slot_cnt[CXST_LK]);
+			cnt_rx_imr = le32_to_cpu(pcysta->v3.leak_slot.cnt_rximr);
 
 			/* Check Leak-AP */
 			if (cnt_leak_slot != 0 && cnt_rx_imr != 0 &&
@@ -1233,7 +1235,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			/* Check diff time between real WL slot and W1 slot */
 			if (dm->tdma_now.type == CXTDMA_OFF) {
 				wl_slot_set = le16_to_cpu(dm->slot_now[CXST_W1].dur);
-				wl_slot_real = le16_to_cpu(pcysta_v1->cycle_time.tavg[CXT_WL]);
+				wl_slot_real = le16_to_cpu(pcysta->v3.cycle_time.tavg[CXT_WL]);
 				if (wl_slot_real > wl_slot_set) {
 					diff_t = wl_slot_real - wl_slot_set;
 					_chk_btc_err(rtwdev, BTC_DCNT_WL_SLOT_DRIFT, diff_t);
@@ -1244,8 +1246,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			if (dm->tdma_now.type == CXTDMA_OFF &&
 			    dm->tdma_now.ext_ctrl == CXECTL_EXT &&
 			    btc->bt_req_len != 0) {
-				bt_slot_real = le16_to_cpu(pcysta_v1->cycle_time.tavg[CXT_BT]);
-
+				bt_slot_real = le16_to_cpu(pcysta->v3.cycle_time.tavg[CXT_BT]);
 				if (btc->bt_req_len > bt_slot_real) {
 					diff_t = btc->bt_req_len - bt_slot_real;
 					_chk_btc_err(rtwdev, BTC_DCNT_BT_SLOT_DRIFT, diff_t);
@@ -1253,11 +1254,13 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			}
 
 			_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE,
-				     le32_to_cpu(pcysta_v1->slot_cnt[CXST_W1]));
+				     le32_to_cpu(pcysta->v3.slot_cnt[CXST_W1]));
 			_chk_btc_err(rtwdev, BTC_DCNT_B1_FREEZE,
-				     le32_to_cpu(pcysta_v1->slot_cnt[CXST_B1]));
+				     le32_to_cpu(pcysta->v3.slot_cnt[CXST_B1]));
 			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE,
-				     (u32)le16_to_cpu(pcysta_v1->cycles));
+				     le16_to_cpu(pcysta->v3.cycles));
+		} else {
+			goto err;
 		}
 		break;
 	case BTC_RPT_TYPE_BT_VER:
@@ -6160,21 +6163,23 @@ static void _show_dm_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 static void _show_error(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
-	struct rtw89_btc_fbtc_cysta *pcysta;
-	struct rtw89_btc_fbtc_cysta_v1 *pcysta_v1;
+	union rtw89_btc_fbtc_cysta_info *pcysta;
 	u32 except_cnt, exception_map;
 
-	if (chip->chip_id == RTL8852A) {
-		pcysta = &pfwinfo->rpt_fbtc_cysta.finfo;
-		except_cnt = le32_to_cpu(pcysta->except_cnt);
-		exception_map = le32_to_cpu(pcysta->exception);
+	pcysta = &pfwinfo->rpt_fbtc_cysta.finfo;
+	if (ver->fcxcysta == 2) {
+		pcysta->v2 = pfwinfo->rpt_fbtc_cysta.finfo.v2;
+		except_cnt = le32_to_cpu(pcysta->v2.except_cnt);
+		exception_map = le32_to_cpu(pcysta->v2.exception);
+	} else if (ver->fcxcysta == 3) {
+		pcysta->v3 = pfwinfo->rpt_fbtc_cysta.finfo.v3;
+		except_cnt = le32_to_cpu(pcysta->v3.except_cnt);
+		exception_map = le32_to_cpu(pcysta->v3.except_map);
 	} else {
-		pcysta_v1 = &pfwinfo->rpt_fbtc_cysta.finfo_v1;
-		except_cnt = le32_to_cpu(pcysta_v1->except_cnt);
-		exception_map = le32_to_cpu(pcysta_v1->except_map);
+		return;
 	}
 
 	if (pfwinfo->event[BTF_EVNT_BUF_OVERFLOW] == 0 && except_cnt == 0 &&
@@ -6305,14 +6310,14 @@ static void _show_fbtc_slots(struct rtw89_dev *rtwdev, struct seq_file *m)
 	}
 }
 
-static void _show_fbtc_cysta(struct rtw89_dev *rtwdev, struct seq_file *m)
+static void _show_fbtc_cysta_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
-	struct rtw89_btc_fbtc_cysta *pcysta_le32 = NULL;
+	struct rtw89_btc_fbtc_cysta_v2 *pcysta_le32 = NULL;
 	union rtw89_btc_fbtc_rxflct r;
 	u8 i, cnt = 0, slot_pair;
 	u16 cycle, c_begin, c_end, store_index;
@@ -6321,7 +6326,7 @@ static void _show_fbtc_cysta(struct rtw89_dev *rtwdev, struct seq_file *m)
 	if (!pcinfo->valid)
 		return;
 
-	pcysta_le32 = &pfwinfo->rpt_fbtc_cysta.finfo;
+	pcysta_le32 = &pfwinfo->rpt_fbtc_cysta.finfo.v2;
 	seq_printf(m,
 		   " %-15s : cycle:%d, bcn[all:%d/all_ok:%d/bt:%d/bt_ok:%d]",
 		   "[cycle_cnt]",
@@ -6433,14 +6438,14 @@ static void _show_fbtc_cysta(struct rtw89_dev *rtwdev, struct seq_file *m)
 	}
 }
 
-static void _show_fbtc_cysta_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
+static void _show_fbtc_cysta_v3(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_fbtc_a2dp_trx_stat *a2dp_trx;
-	struct rtw89_btc_fbtc_cysta_v1 *pcysta;
+	struct rtw89_btc_fbtc_cysta_v3 *pcysta;
 	struct rtw89_btc_rpt_cmn_info *pcinfo;
 	u8 i, cnt = 0, slot_pair, divide_cnt;
 	u16 cycle, c_begin, c_end, store_index;
@@ -6449,7 +6454,7 @@ static void _show_fbtc_cysta_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
 	if (!pcinfo->valid)
 		return;
 
-	pcysta = &pfwinfo->rpt_fbtc_cysta.finfo_v1;
+	pcysta = &pfwinfo->rpt_fbtc_cysta.finfo.v3;
 	seq_printf(m,
 		   " %-15s : cycle:%d, bcn[all:%d/all_ok:%d/bt:%d/bt_ok:%d]",
 		   "[cycle_cnt]",
@@ -6708,8 +6713,8 @@ static void _show_fbtc_step(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 static void _show_fw_dm_msg(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 
 	if (!(btc->dm.coex_info_map & BTC_COEX_INFO_DM))
 		return;
@@ -6718,10 +6723,10 @@ static void _show_fw_dm_msg(struct rtw89_dev *rtwdev, struct seq_file *m)
 	_show_fbtc_tdma(rtwdev, m);
 	_show_fbtc_slots(rtwdev, m);
 
-	if (chip->chip_id == RTL8852A)
-		_show_fbtc_cysta(rtwdev, m);
-	else
-		_show_fbtc_cysta_v1(rtwdev, m);
+	if (ver->fcxcysta == 2)
+		_show_fbtc_cysta_v2(rtwdev, m);
+	else if (ver->fcxcysta == 3)
+		_show_fbtc_cysta_v3(rtwdev, m);
 
 	_show_fbtc_nullsta(rtwdev, m);
 	_show_fbtc_step(rtwdev, m);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 04450a4938cad..6af70eabb9080 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1681,7 +1681,7 @@ struct rtw89_btc_fbtc_steps_v1 {
 	struct rtw89_btc_fbtc_step step[FCXMAX_STEP];
 } __packed;
 
-struct rtw89_btc_fbtc_cysta { /* statistics for cycles */
+struct rtw89_btc_fbtc_cysta_v2 { /* statistics for cycles */
 	u8 fver; /* btc_ver::fcxcysta */
 	u8 rsvd;
 	__le16 cycles; /* total cycle number */
@@ -1743,7 +1743,7 @@ struct rtw89_btc_fbtc_cycle_leak_info {
 	__le16 tmax; /* max leak-slot time */
 } __packed;
 
-struct rtw89_btc_fbtc_cysta_v1 { /* statistics for cycles */
+struct rtw89_btc_fbtc_cysta_v3 { /* statistics for cycles */
 	u8 fver;
 	u8 rsvd;
 	__le16 cycles; /* total cycle number */
@@ -1761,6 +1761,11 @@ struct rtw89_btc_fbtc_cysta_v1 { /* statistics for cycles */
 	__le32 except_map;
 } __packed;
 
+union rtw89_btc_fbtc_cysta_info {
+	struct rtw89_btc_fbtc_cysta_v2 v2;
+	struct rtw89_btc_fbtc_cysta_v3 v3;
+};
+
 struct rtw89_btc_fbtc_cynullsta { /* cycle null statistics */
 	u8 fver; /* btc_ver::fcxnullsta */
 	u8 rsvd;
@@ -1961,10 +1966,7 @@ struct rtw89_btc_rpt_fbtc_slots {
 
 struct rtw89_btc_rpt_fbtc_cysta {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
-	union {
-		struct rtw89_btc_fbtc_cysta finfo; /* info from fw for 52A*/
-		struct rtw89_btc_fbtc_cysta_v1 finfo_v1; /* info from fw for 52C*/
-	};
+	union rtw89_btc_fbtc_cysta_info finfo;
 };
 
 struct rtw89_btc_rpt_fbtc_step {
-- 
2.25.1

