Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DEB65C170
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 15:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbjACODk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 09:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237727AbjACODX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 09:03:23 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEE8A10573
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 06:03:19 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 303E2ARr8016670, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 303E2ARr8016670
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 3 Jan 2023 22:02:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 3 Jan 2023 22:03:05 +0800
Received: from localhost (172.16.19.22) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 3 Jan 2023
 22:03:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/7] wifi: rtw89: coex: Remove le32 to CPU translator at firmware cycle report
Date:   Tue, 3 Jan 2023 22:02:32 +0800
Message-ID: <20230103140238.15601-2-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

There are at least 2 version of cycle report format. If the code keep
translating the report to local variable, the numbers of variable in
check btc report function will out of maximum variable numbers. And
most of these variable are using only one time, it is not necessary
to store at memory.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 190 +++++++---------------
 1 file changed, 60 insertions(+), 130 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 2cb7ed1636030..a594f5c729608 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -910,76 +910,6 @@ static void _update_bt_report(struct rtw89_dev *rtwdev, u8 rpt_type, u8 *pfinfo)
 	}
 }
 
-struct rtw89_btc_fbtc_cysta_cpu {
-	u8 fver;
-	u8 rsvd;
-	u16 cycles;
-	u16 cycles_a2dp[CXT_FLCTRL_MAX];
-	u16 a2dpept;
-	u16 a2dpeptto;
-	u16 tavg_cycle[CXT_MAX];
-	u16 tmax_cycle[CXT_MAX];
-	u16 tmaxdiff_cycle[CXT_MAX];
-	u16 tavg_a2dp[CXT_FLCTRL_MAX];
-	u16 tmax_a2dp[CXT_FLCTRL_MAX];
-	u16 tavg_a2dpept;
-	u16 tmax_a2dpept;
-	u16 tavg_lk;
-	u16 tmax_lk;
-	u32 slot_cnt[CXST_MAX];
-	u32 bcn_cnt[CXBCN_MAX];
-	u32 leakrx_cnt;
-	u32 collision_cnt;
-	u32 skip_cnt;
-	u32 exception;
-	u32 except_cnt;
-	u16 tslot_cycle[BTC_CYCLE_SLOT_MAX];
-};
-
-static void rtw89_btc_fbtc_cysta_to_cpu(const struct rtw89_btc_fbtc_cysta *src,
-					struct rtw89_btc_fbtc_cysta_cpu *dst)
-{
-	static_assert(sizeof(*src) == sizeof(*dst));
-
-#define __CPY_U8(_x)	({dst->_x = src->_x; })
-#define __CPY_LE16(_x)	({dst->_x = le16_to_cpu(src->_x); })
-#define __CPY_LE16S(_x)	({int _i; for (_i = 0; _i < ARRAY_SIZE(dst->_x); _i++) \
-				   dst->_x[_i] = le16_to_cpu(src->_x[_i]); })
-#define __CPY_LE32(_x)	({dst->_x = le32_to_cpu(src->_x); })
-#define __CPY_LE32S(_x)	({int _i; for (_i = 0; _i < ARRAY_SIZE(dst->_x); _i++) \
-				   dst->_x[_i] = le32_to_cpu(src->_x[_i]); })
-
-	__CPY_U8(fver);
-	__CPY_U8(rsvd);
-	__CPY_LE16(cycles);
-	__CPY_LE16S(cycles_a2dp);
-	__CPY_LE16(a2dpept);
-	__CPY_LE16(a2dpeptto);
-	__CPY_LE16S(tavg_cycle);
-	__CPY_LE16S(tmax_cycle);
-	__CPY_LE16S(tmaxdiff_cycle);
-	__CPY_LE16S(tavg_a2dp);
-	__CPY_LE16S(tmax_a2dp);
-	__CPY_LE16(tavg_a2dpept);
-	__CPY_LE16(tmax_a2dpept);
-	__CPY_LE16(tavg_lk);
-	__CPY_LE16(tmax_lk);
-	__CPY_LE32S(slot_cnt);
-	__CPY_LE32S(bcn_cnt);
-	__CPY_LE32(leakrx_cnt);
-	__CPY_LE32(collision_cnt);
-	__CPY_LE32(skip_cnt);
-	__CPY_LE32(exception);
-	__CPY_LE32(except_cnt);
-	__CPY_LE16S(tslot_cycle);
-
-#undef __CPY_U8
-#undef __CPY_LE16
-#undef __CPY_LE16S
-#undef __CPY_LE32
-#undef __CPY_LE32S
-}
-
 #define BTC_LEAK_AP_TH 10
 #define BTC_CYSTA_CHK_PERIOD 100
 
@@ -1002,9 +932,8 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_btc_fbtc_rpt_ctrl *prpt;
 	struct rtw89_btc_fbtc_rpt_ctrl_v1 *prpt_v1;
-	struct rtw89_btc_fbtc_cysta *pcysta_le32 = NULL;
+	struct rtw89_btc_fbtc_cysta *pcysta = NULL;
 	struct rtw89_btc_fbtc_cysta_v1 *pcysta_v1 = NULL;
-	struct rtw89_btc_fbtc_cysta_cpu pcysta[1];
 	struct rtw89_btc_prpt *btc_prpt = NULL;
 	void *rpt_content = NULL, *pfinfo = NULL;
 	u8 rpt_type = 0;
@@ -1066,8 +995,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_cysta.cinfo;
 		if (chip->chip_id == RTL8852A) {
 			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo;
-			pcysta_le32 = &pfwinfo->rpt_fbtc_cysta.finfo;
-			rtw89_btc_fbtc_cysta_to_cpu(pcysta_le32, pcysta);
+			pcysta = &pfwinfo->rpt_fbtc_cysta.finfo;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo);
 		} else {
 			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo_v1;
@@ -1259,13 +1187,13 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_CYSTA:
 		if (chip->chip_id == RTL8852A) {
-			if (pcysta->cycles < BTC_CYSTA_CHK_PERIOD)
+			if (le16_to_cpu(pcysta->cycles) < BTC_CYSTA_CHK_PERIOD)
 				break;
 			/* Check Leak-AP */
-			if (pcysta->slot_cnt[CXST_LK] != 0 &&
-			    pcysta->leakrx_cnt != 0 && dm->tdma_now.rxflctrl) {
-				if (pcysta->slot_cnt[CXST_LK] <
-				    BTC_LEAK_AP_TH * pcysta->leakrx_cnt)
+			if (le32_to_cpu(pcysta->slot_cnt[CXST_LK]) != 0 &&
+			    le32_to_cpu(pcysta->leakrx_cnt) != 0 && dm->tdma_now.rxflctrl) {
+				if (le32_to_cpu(pcysta->slot_cnt[CXST_LK]) <
+				    BTC_LEAK_AP_TH * le32_to_cpu(pcysta->leakrx_cnt))
 					dm->leak_ap = 1;
 			}
 
@@ -1276,18 +1204,18 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			else
 				wl_slot_set = le16_to_cpu(dm->slot_now[CXST_W1].dur);
 
-			if (pcysta->tavg_cycle[CXT_WL] > wl_slot_set) {
-				diff_t = pcysta->tavg_cycle[CXT_WL] - wl_slot_set;
+			if (le16_to_cpu(pcysta->tavg_cycle[CXT_WL]) > wl_slot_set) {
+				diff_t = le16_to_cpu(pcysta->tavg_cycle[CXT_WL]) - wl_slot_set;
 				_chk_btc_err(rtwdev,
 					     BTC_DCNT_WL_SLOT_DRIFT, diff_t);
 			}
 
 			_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE,
-				     pcysta->slot_cnt[CXST_W1]);
+				     le32_to_cpu(pcysta->slot_cnt[CXST_W1]));
 			_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE,
-				     pcysta->slot_cnt[CXST_B1]);
+				     le32_to_cpu(pcysta->slot_cnt[CXST_B1]));
 			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE,
-				     (u32)pcysta->cycles);
+				     le16_to_cpu(pcysta->cycles));
 		} else {
 			if (le16_to_cpu(pcysta_v1->cycles) < BTC_CYSTA_CHK_PERIOD)
 				break;
@@ -6385,7 +6313,6 @@ static void _show_fbtc_cysta(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_fbtc_cysta *pcysta_le32 = NULL;
-	struct rtw89_btc_fbtc_cysta_cpu pcysta[1];
 	union rtw89_btc_fbtc_rxflct r;
 	u8 i, cnt = 0, slot_pair;
 	u16 cycle, c_begin, c_end, store_index;
@@ -6395,64 +6322,65 @@ static void _show_fbtc_cysta(struct rtw89_dev *rtwdev, struct seq_file *m)
 		return;
 
 	pcysta_le32 = &pfwinfo->rpt_fbtc_cysta.finfo;
-	rtw89_btc_fbtc_cysta_to_cpu(pcysta_le32, pcysta);
 	seq_printf(m,
 		   " %-15s : cycle:%d, bcn[all:%d/all_ok:%d/bt:%d/bt_ok:%d]",
-		   "[cycle_cnt]", pcysta->cycles, pcysta->bcn_cnt[CXBCN_ALL],
-		   pcysta->bcn_cnt[CXBCN_ALL_OK],
-		   pcysta->bcn_cnt[CXBCN_BT_SLOT],
-		   pcysta->bcn_cnt[CXBCN_BT_OK]);
+		   "[cycle_cnt]",
+		   le16_to_cpu(pcysta_le32->cycles),
+		   le32_to_cpu(pcysta_le32->bcn_cnt[CXBCN_ALL]),
+		   le32_to_cpu(pcysta_le32->bcn_cnt[CXBCN_ALL_OK]),
+		   le32_to_cpu(pcysta_le32->bcn_cnt[CXBCN_BT_SLOT]),
+		   le32_to_cpu(pcysta_le32->bcn_cnt[CXBCN_BT_OK]));
 
 	for (i = 0; i < CXST_MAX; i++) {
-		if (!pcysta->slot_cnt[i])
+		if (!le32_to_cpu(pcysta_le32->slot_cnt[i]))
 			continue;
-		seq_printf(m,
-			   ", %d:%d", (u32)i, pcysta->slot_cnt[i]);
+		seq_printf(m, ", %d:%d", (u32)i,
+			   le32_to_cpu(pcysta_le32->slot_cnt[i]));
 	}
 
 	if (dm->tdma_now.rxflctrl) {
-		seq_printf(m,
-			   ", leak_rx:%d", pcysta->leakrx_cnt);
+		seq_printf(m, ", leak_rx:%d",
+			   le32_to_cpu(pcysta_le32->leakrx_cnt));
 	}
 
-	if (pcysta->collision_cnt) {
-		seq_printf(m,
-			   ", collision:%d", pcysta->collision_cnt);
+	if (le32_to_cpu(pcysta_le32->collision_cnt)) {
+		seq_printf(m, ", collision:%d",
+			   le32_to_cpu(pcysta_le32->collision_cnt));
 	}
 
-	if (pcysta->skip_cnt) {
-		seq_printf(m,
-			   ", skip:%d", pcysta->skip_cnt);
+	if (le32_to_cpu(pcysta_le32->skip_cnt)) {
+		seq_printf(m, ", skip:%d",
+			   le32_to_cpu(pcysta_le32->skip_cnt));
 	}
 	seq_puts(m, "\n");
 
 	seq_printf(m, " %-15s : avg_t[wl:%d/bt:%d/lk:%d.%03d]",
 		   "[cycle_time]",
-		   pcysta->tavg_cycle[CXT_WL],
-		   pcysta->tavg_cycle[CXT_BT],
-		   pcysta->tavg_lk / 1000, pcysta->tavg_lk % 1000);
-	seq_printf(m,
-		   ", max_t[wl:%d/bt:%d/lk:%d.%03d]",
-		   pcysta->tmax_cycle[CXT_WL],
-		   pcysta->tmax_cycle[CXT_BT],
-		   pcysta->tmax_lk / 1000, pcysta->tmax_lk % 1000);
-	seq_printf(m,
-		   ", maxdiff_t[wl:%d/bt:%d]\n",
-		   pcysta->tmaxdiff_cycle[CXT_WL],
-		   pcysta->tmaxdiff_cycle[CXT_BT]);
-
-	if (pcysta->cycles == 0)
+		   le16_to_cpu(pcysta_le32->tavg_cycle[CXT_WL]),
+		   le16_to_cpu(pcysta_le32->tavg_cycle[CXT_BT]),
+		   le16_to_cpu(pcysta_le32->tavg_lk) / 1000,
+		   le16_to_cpu(pcysta_le32->tavg_lk) % 1000);
+	seq_printf(m, ", max_t[wl:%d/bt:%d/lk:%d.%03d]",
+		   le16_to_cpu(pcysta_le32->tmax_cycle[CXT_WL]),
+		   le16_to_cpu(pcysta_le32->tmax_cycle[CXT_BT]),
+		   le16_to_cpu(pcysta_le32->tmax_lk) / 1000,
+		   le16_to_cpu(pcysta_le32->tmax_lk) % 1000);
+	seq_printf(m, ", maxdiff_t[wl:%d/bt:%d]\n",
+		   le16_to_cpu(pcysta_le32->tmaxdiff_cycle[CXT_WL]),
+		   le16_to_cpu(pcysta_le32->tmaxdiff_cycle[CXT_BT]));
+
+	if (le16_to_cpu(pcysta_le32->cycles) == 0)
 		return;
 
 	/* 1 cycle record 1 wl-slot and 1 bt-slot */
 	slot_pair = BTC_CYCLE_SLOT_MAX / 2;
 
-	if (pcysta->cycles <= slot_pair)
+	if (le16_to_cpu(pcysta_le32->cycles) <= slot_pair)
 		c_begin = 1;
 	else
-		c_begin = pcysta->cycles - slot_pair + 1;
+		c_begin = le16_to_cpu(pcysta_le32->cycles) - slot_pair + 1;
 
-	c_end = pcysta->cycles;
+	c_end = le16_to_cpu(pcysta_le32->cycles);
 
 	for (cycle = c_begin; cycle <= c_end; cycle++) {
 		cnt++;
@@ -6461,13 +6389,13 @@ static void _show_fbtc_cysta(struct rtw89_dev *rtwdev, struct seq_file *m)
 		if (cnt % (BTC_CYCLE_SLOT_MAX / 4) == 1)
 			seq_printf(m,
 				   " %-15s : ->b%02d->w%02d", "[cycle_step]",
-				   pcysta->tslot_cycle[store_index],
-				   pcysta->tslot_cycle[store_index + 1]);
+				   le16_to_cpu(pcysta_le32->tslot_cycle[store_index]),
+				   le16_to_cpu(pcysta_le32->tslot_cycle[store_index + 1]));
 		else
 			seq_printf(m,
 				   "->b%02d->w%02d",
-				   pcysta->tslot_cycle[store_index],
-				   pcysta->tslot_cycle[store_index + 1]);
+				   le16_to_cpu(pcysta_le32->tslot_cycle[store_index]),
+				   le16_to_cpu(pcysta_le32->tslot_cycle[store_index + 1]));
 		if (cnt % (BTC_CYCLE_SLOT_MAX / 4) == 0 || cnt == c_end)
 			seq_puts(m, "\n");
 	}
@@ -6476,28 +6404,30 @@ static void _show_fbtc_cysta(struct rtw89_dev *rtwdev, struct seq_file *m)
 		seq_printf(m,
 			   " %-15s : a2dp_ept:%d, a2dp_late:%d",
 			   "[a2dp_t_sta]",
-			   pcysta->a2dpept, pcysta->a2dpeptto);
+			   le16_to_cpu(pcysta_le32->a2dpept),
+			   le16_to_cpu(pcysta_le32->a2dpeptto));
 
 		seq_printf(m,
 			   ", avg_t:%d, max_t:%d",
-			   pcysta->tavg_a2dpept, pcysta->tmax_a2dpept);
+			   le16_to_cpu(pcysta_le32->tavg_a2dpept),
+			   le16_to_cpu(pcysta_le32->tmax_a2dpept));
 		r.val = dm->tdma_now.rxflctrl;
 
 		if (r.type && r.tgln_n) {
 			seq_printf(m,
 				   ", cycle[PSTDMA:%d/TDMA:%d], ",
-				   pcysta->cycles_a2dp[CXT_FLCTRL_ON],
-				   pcysta->cycles_a2dp[CXT_FLCTRL_OFF]);
+				   le16_to_cpu(pcysta_le32->cycles_a2dp[CXT_FLCTRL_ON]),
+				   le16_to_cpu(pcysta_le32->cycles_a2dp[CXT_FLCTRL_OFF]));
 
 			seq_printf(m,
 				   "avg_t[PSTDMA:%d/TDMA:%d], ",
-				   pcysta->tavg_a2dp[CXT_FLCTRL_ON],
-				   pcysta->tavg_a2dp[CXT_FLCTRL_OFF]);
+				   le16_to_cpu(pcysta_le32->tavg_a2dp[CXT_FLCTRL_ON]),
+				   le16_to_cpu(pcysta_le32->tavg_a2dp[CXT_FLCTRL_OFF]));
 
 			seq_printf(m,
 				   "max_t[PSTDMA:%d/TDMA:%d]",
-				   pcysta->tmax_a2dp[CXT_FLCTRL_ON],
-				   pcysta->tmax_a2dp[CXT_FLCTRL_OFF]);
+				   le16_to_cpu(pcysta_le32->tmax_a2dp[CXT_FLCTRL_ON]),
+				   le16_to_cpu(pcysta_le32->tmax_a2dp[CXT_FLCTRL_OFF]));
 		}
 		seq_puts(m, "\n");
 	}
-- 
2.25.1

