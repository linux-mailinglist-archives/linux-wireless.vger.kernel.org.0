Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA265FFF5
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jan 2023 13:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjAFMJY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Jan 2023 07:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjAFMJR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Jan 2023 07:09:17 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23AF6718A7
        for <linux-wireless@vger.kernel.org>; Fri,  6 Jan 2023 04:09:15 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 306C86Ab8028242, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 306C86Ab8028242
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 6 Jan 2023 20:08:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 6 Jan 2023 20:09:03 +0800
Received: from localhost (172.16.18.220) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 6 Jan 2023
 20:09:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/7] wifi: rtw89: coex: Change firmware steps report to version separate
Date:   Fri, 6 Jan 2023 20:08:40 +0800
Message-ID: <20230106120844.17441-4-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

The report records the slots/events and their time cost about the code
call flow at firmware, ver 3 assign a reserved variable to recognize
the report is enabled or not. And add corresponding function to parsing
the report.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 124 +++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h |  44 ++++++--
 2 files changed, 149 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index eec1f5228c5dc..5979efb5e465d 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -923,7 +923,6 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			   struct rtw89_btc_btf_fwinfo *pfwinfo,
 			   u8 *prptbuf, u32 index)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &btc->dm;
@@ -1017,16 +1016,18 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_STEP:
 		pcinfo = &pfwinfo->rpt_fbtc_step.cinfo;
-		if (chip->chip_id == RTL8852A) {
-			pfinfo = &pfwinfo->rpt_fbtc_step.finfo;
-			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_step.finfo.step[0]) *
+		if (ver->fcxstep == 2) {
+			pfinfo = &pfwinfo->rpt_fbtc_step.finfo.v2;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_step.finfo.v2.step[0]) *
 					  trace_step +
-					  offsetof(struct rtw89_btc_fbtc_steps, step);
-		} else {
-			pfinfo = &pfwinfo->rpt_fbtc_step.finfo_v1;
-			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_step.finfo_v1.step[0]) *
+					  offsetof(struct rtw89_btc_fbtc_steps_v2, step);
+		} else if (ver->fcxstep == 3) {
+			pfinfo = &pfwinfo->rpt_fbtc_step.finfo.v3;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_step.finfo.v3.step[0]) *
 					  trace_step +
-					  offsetof(struct rtw89_btc_fbtc_steps_v1, step);
+					  offsetof(struct rtw89_btc_fbtc_steps_v3, step);
+		} else {
+			goto err;
 		}
 		pcinfo->req_fver = ver->fcxstep;
 		break;
@@ -6008,6 +6009,7 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 #define CASE_BTC_POLICY_STR(e) \
 	case BTC_CXP_ ## e | BTC_POLICY_EXT_BIT: return #e
 #define CASE_BTC_SLOT_STR(e) case CXST_ ## e: return #e
+#define CASE_BTC_EVT_STR(e) case CXEVNT_## e: return #e
 
 static const char *steps_to_str(u16 step)
 {
@@ -6148,6 +6150,40 @@ static const char *id_to_slot(u32 id)
 	}
 }
 
+static const char *id_to_evt(u32 id)
+{
+	switch (id) {
+	CASE_BTC_EVT_STR(TDMA_ENTRY);
+	CASE_BTC_EVT_STR(WL_TMR);
+	CASE_BTC_EVT_STR(B1_TMR);
+	CASE_BTC_EVT_STR(B2_TMR);
+	CASE_BTC_EVT_STR(B3_TMR);
+	CASE_BTC_EVT_STR(B4_TMR);
+	CASE_BTC_EVT_STR(W2B_TMR);
+	CASE_BTC_EVT_STR(B2W_TMR);
+	CASE_BTC_EVT_STR(BCN_EARLY);
+	CASE_BTC_EVT_STR(A2DP_EMPTY);
+	CASE_BTC_EVT_STR(LK_END);
+	CASE_BTC_EVT_STR(RX_ISR);
+	CASE_BTC_EVT_STR(RX_FC0);
+	CASE_BTC_EVT_STR(RX_FC1);
+	CASE_BTC_EVT_STR(BT_RELINK);
+	CASE_BTC_EVT_STR(BT_RETRY);
+	CASE_BTC_EVT_STR(E2G);
+	CASE_BTC_EVT_STR(E5G);
+	CASE_BTC_EVT_STR(EBT);
+	CASE_BTC_EVT_STR(ENULL);
+	CASE_BTC_EVT_STR(DRV_WLK);
+	CASE_BTC_EVT_STR(BCN_OK);
+	CASE_BTC_EVT_STR(BT_CHANGE);
+	CASE_BTC_EVT_STR(EBT_EXTEND);
+	CASE_BTC_EVT_STR(E2G_NULL1);
+	CASE_BTC_EVT_STR(B1FDD_TMR);
+	default:
+		return "unknown";
+	}
+}
+
 static
 void seq_print_segment(struct seq_file *m, const char *prefix, u16 *data,
 		       u8 len, u8 seg_len, u8 start_idx, u8 ring_len)
@@ -6857,12 +6893,12 @@ static void _show_fbtc_nullsta(struct rtw89_dev *rtwdev, struct seq_file *m)
 	seq_puts(m, "\n");
 }
 
-static void _show_fbtc_step(struct rtw89_dev *rtwdev, struct seq_file *m)
+static void _show_fbtc_step_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
-	struct rtw89_btc_fbtc_steps *pstep = NULL;
+	struct rtw89_btc_fbtc_steps_v2 *pstep = NULL;
 	u8 type, val, cnt = 0, state = 0;
 	bool outloop = false;
 	u16 i, diff_t, n_start = 0, n_stop = 0;
@@ -6872,7 +6908,7 @@ static void _show_fbtc_step(struct rtw89_dev *rtwdev, struct seq_file *m)
 	if (!pcinfo->valid)
 		return;
 
-	pstep = &pfwinfo->rpt_fbtc_step.finfo;
+	pstep = &pfwinfo->rpt_fbtc_step.finfo.v2;
 	pos_old = le16_to_cpu(pstep->pos_old);
 	pos_new = le16_to_cpu(pstep->pos_new);
 
@@ -6926,6 +6962,63 @@ static void _show_fbtc_step(struct rtw89_dev *rtwdev, struct seq_file *m)
 	} while (!outloop);
 }
 
+static void _show_fbtc_step_v3(struct rtw89_dev *rtwdev, struct seq_file *m)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
+	struct rtw89_btc_rpt_cmn_info *pcinfo;
+	struct rtw89_btc_fbtc_steps_v3 *pstep;
+	u32 i, n_begin, n_end, array_idx, cnt = 0;
+	u8 type, val;
+	u16 diff_t;
+
+	if ((pfwinfo->rpt_en_map &
+	     rtw89_btc_fw_rpt_ver(rtwdev, RPT_EN_FW_STEP_INFO)) == 0)
+		return;
+
+	pcinfo = &pfwinfo->rpt_fbtc_step.cinfo;
+	if (!pcinfo->valid)
+		return;
+
+	pstep = &pfwinfo->rpt_fbtc_step.finfo.v3;
+	if (pcinfo->req_fver != pstep->fver)
+		return;
+
+	if (le32_to_cpu(pstep->cnt) <= FCXDEF_STEP)
+		n_begin = 1;
+	else
+		n_begin = le32_to_cpu(pstep->cnt) - FCXDEF_STEP + 1;
+
+	n_end = le32_to_cpu(pstep->cnt);
+
+	if (n_begin > n_end)
+		return;
+
+	/* restore step info by using ring instead of FIFO */
+	for (i = n_begin; i <= n_end; i++) {
+		array_idx = (i - 1) % FCXDEF_STEP;
+		type = pstep->step[array_idx].type;
+		val = pstep->step[array_idx].val;
+		diff_t = le16_to_cpu(pstep->step[array_idx].difft);
+
+		if (type == CXSTEP_NONE || type >= CXSTEP_MAX)
+			continue;
+
+		if (cnt % 10 == 0)
+			seq_printf(m, " %-15s : ", "[steps]");
+
+		seq_printf(m, "-> %s(%02d)",
+			   (type == CXSTEP_SLOT ?
+			    id_to_slot((u32)val) :
+			    id_to_evt((u32)val)), diff_t);
+
+		if (cnt % 10 == 9)
+			seq_puts(m, "\n");
+
+		cnt++;
+	}
+}
+
 static void _show_fw_dm_msg(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -6946,7 +7039,12 @@ static void _show_fw_dm_msg(struct rtw89_dev *rtwdev, struct seq_file *m)
 		_show_fbtc_cysta_v4(rtwdev, m);
 
 	_show_fbtc_nullsta(rtwdev, m);
-	_show_fbtc_step(rtwdev, m);
+
+	if (ver->fcxstep == 2)
+		_show_fbtc_step_v2(rtwdev, m);
+	else if (ver->fcxstep == 3)
+		_show_fbtc_step_v3(rtwdev, m);
+
 }
 
 static void _get_gnt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_coex_gnt *gnt_cfg)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index dfde8801e97bb..39c5a003e36cc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1611,6 +1611,36 @@ enum rtw89_btc_cxst_state {
 	CXST_MAX = 0x12,
 };
 
+enum rtw89_btc_cxevnt {
+	CXEVNT_TDMA_ENTRY = 0x0,
+	CXEVNT_WL_TMR,
+	CXEVNT_B1_TMR,
+	CXEVNT_B2_TMR,
+	CXEVNT_B3_TMR,
+	CXEVNT_B4_TMR,
+	CXEVNT_W2B_TMR,
+	CXEVNT_B2W_TMR,
+	CXEVNT_BCN_EARLY,
+	CXEVNT_A2DP_EMPTY,
+	CXEVNT_LK_END,
+	CXEVNT_RX_ISR,
+	CXEVNT_RX_FC0,
+	CXEVNT_RX_FC1,
+	CXEVNT_BT_RELINK,
+	CXEVNT_BT_RETRY,
+	CXEVNT_E2G,
+	CXEVNT_E5G,
+	CXEVNT_EBT,
+	CXEVNT_ENULL,
+	CXEVNT_DRV_WLK,
+	CXEVNT_BCN_OK,
+	CXEVNT_BT_CHANGE,
+	CXEVNT_EBT_EXTEND,
+	CXEVNT_E2G_NULL1,
+	CXEVNT_B1FDD_TMR,
+	CXEVNT_MAX
+};
+
 enum {
 	CXBCN_ALL = 0x0,
 	CXBCN_ALL_OK,
@@ -1696,7 +1726,7 @@ struct rtw89_btc_fbtc_step {
 	__le16 difft;
 } __packed;
 
-struct rtw89_btc_fbtc_steps {
+struct rtw89_btc_fbtc_steps_v2 {
 	u8 fver; /* btc_ver::fcxstep */
 	u8 rsvd;
 	__le16 cnt;
@@ -1705,7 +1735,7 @@ struct rtw89_btc_fbtc_steps {
 	struct rtw89_btc_fbtc_step step[FCXMAX_STEP];
 } __packed;
 
-struct rtw89_btc_fbtc_steps_v1 {
+struct rtw89_btc_fbtc_steps_v3 {
 	u8 fver;
 	u8 en;
 	__le16 rsvd;
@@ -1713,6 +1743,11 @@ struct rtw89_btc_fbtc_steps_v1 {
 	struct rtw89_btc_fbtc_step step[FCXMAX_STEP];
 } __packed;
 
+union rtw89_btc_fbtc_steps_info {
+	struct rtw89_btc_fbtc_steps_v2 v2;
+	struct rtw89_btc_fbtc_steps_v3 v3;
+};
+
 struct rtw89_btc_fbtc_cysta_v2 { /* statistics for cycles */
 	u8 fver; /* btc_ver::fcxcysta */
 	u8 rsvd;
@@ -2072,10 +2107,7 @@ struct rtw89_btc_rpt_fbtc_cysta {
 
 struct rtw89_btc_rpt_fbtc_step {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
-	union {
-		struct rtw89_btc_fbtc_steps finfo; /* info from fw */
-		struct rtw89_btc_fbtc_steps_v1 finfo_v1; /* info from fw */
-	};
+	union rtw89_btc_fbtc_steps_info finfo; /* info from fw */
 };
 
 struct rtw89_btc_rpt_fbtc_nullsta {
-- 
2.25.1

