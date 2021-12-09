Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF7C46E44A
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 09:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhLIIhB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 03:37:01 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:37354 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbhLIIg7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 03:36:59 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1B98XM7L0006448, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1B98XM7L0006448
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 9 Dec 2021 16:33:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 16:33:22 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 9 Dec
 2021 16:33:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <ku920601@realtek.com>
Subject: [PATCH 5/7] rtw89: coex: Update BT counters while receiving report
Date:   Thu, 9 Dec 2021 16:32:27 +0800
Message-ID: <20211209083229.10815-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209083229.10815-1-pkshih@realtek.com>
References: <20211209083229.10815-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 12/09/2021 08:09:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEyLzkgpFekyCAwNjozMjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Move _chk_btc_err and update_bt_cnt to _chk_btc_report(),
so we can update counter/info to COEX at a proper moment,
instead of relying on a user does cat the debug info periodically.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 32 +++++++++++------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 436f5ccb193a5..929818c3a776b 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1118,6 +1118,10 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			diff_t = pcysta->tavg_cycle[CXT_WL] - wl_slot_set;
 			_chk_btc_err(rtwdev, BTC_DCNT_WL_SLOT_DRIFT, diff_t);
 		}
+
+		_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE, pcysta->slot_cnt[CXST_W1]);
+		_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE, pcysta->slot_cnt[CXST_W1]);
+		_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE, (u32)pcysta->cycles);
 	}
 
 	if (rpt_type == BTC_RPT_TYPE_CTRL) {
@@ -1127,8 +1131,17 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		wl->ver_info.fw = prpt->wl_fw_ver;
 		dm->wl_fw_cx_offload = !!(prpt->wl_fw_cx_offload);
 
-		btc->cx.cnt_bt[BTC_BCNT_POLUT] =
-			rtw89_mac_get_plt_cnt(rtwdev, RTW89_MAC_0);
+		_chk_btc_err(rtwdev, BTC_DCNT_RPT_FREEZE,
+			     pfwinfo->event[BTF_EVNT_RPT]);
+
+		/* To avoid I/O if WL LPS or power-off */
+		if (wl->status.map.lps != BTC_LPS_RF_OFF && !wl->status.map.rf_off) {
+			rtwdev->chip->ops->btc_update_bt_cnt(rtwdev);
+			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_FREEZE, 0);
+
+			btc->cx.cnt_bt[BTC_BCNT_POLUT] =
+				rtw89_mac_get_plt_cnt(rtwdev, RTW89_MAC_0);
+		}
 	}
 
 	if (rpt_type >= BTC_RPT_TYPE_BT_VER &&
@@ -4793,7 +4806,6 @@ static void _show_bt_profile_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_bt_info *bt = &cx->bt;
@@ -4876,12 +4888,6 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   cx->cnt_bt[BTC_BCNT_INFOUPDATE],
 		   cx->cnt_bt[BTC_BCNT_INFOSAME]);
 
-	if (wl->status.map.lps || wl->status.map.rf_off)
-		return;
-
-	chip->ops->btc_update_bt_cnt(rtwdev);
-	_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_FREEZE, 0);
-
 	seq_printf(m,
 		   " %-15s : Hi-rx = %d, Hi-tx = %d, Lo-rx = %d, Lo-tx = %d (bt_polut_wl_tx = %d)\n",
 		   "[trx_req_cnt]", cx->cnt_bt[BTC_BCNT_HIPRI_RX],
@@ -5254,8 +5260,6 @@ static void _show_fbtc_cysta(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   pcysta->bcn_cnt[CXBCN_BT_SLOT],
 		   pcysta->bcn_cnt[CXBCN_BT_OK]);
 
-	_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE, (u32)pcysta->cycles);
-
 	for (i = 0; i < CXST_MAX; i++) {
 		if (!pcysta->slot_cnt[i])
 			continue;
@@ -5279,9 +5283,6 @@ static void _show_fbtc_cysta(struct rtw89_dev *rtwdev, struct seq_file *m)
 	}
 	seq_puts(m, "\n");
 
-	_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE, pcysta->slot_cnt[CXST_W1]);
-	_chk_btc_err(rtwdev, BTC_DCNT_B1_FREEZE, pcysta->slot_cnt[CXST_B1]);
-
 	seq_printf(m, " %-15s : avg_t[wl:%d/bt:%d/lk:%d.%03d]",
 		   "[cycle_time]",
 		   pcysta->tavg_cycle[CXT_WL],
@@ -5633,9 +5634,6 @@ static void _show_summary(struct rtw89_dev *rtwdev, struct seq_file *m)
 			   pfwinfo->event[BTF_EVNT_RPT], prptctrl->rpt_cnt,
 			   prptctrl->rpt_enable, dm->error.val);
 
-		_chk_btc_err(rtwdev, BTC_DCNT_RPT_FREEZE,
-			     pfwinfo->event[BTF_EVNT_RPT]);
-
 		if (dm->error.map.wl_fw_hang)
 			seq_puts(m, " (WL FW Hang!!)");
 		seq_puts(m, "\n");
-- 
2.25.1

