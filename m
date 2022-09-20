Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F735BD936
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 03:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiITBLr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 21:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiITBL0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 21:11:26 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5FC152E5E
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 18:10:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28K19vFU2031050, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28K19vFU2031050
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 20 Sep 2022 09:09:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 20 Sep 2022 09:10:20 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 20 Sep
 2022 09:10:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/9] wifi: rtw89: coex: add v1 summary info to parse the traffic status from firmware
Date:   Tue, 20 Sep 2022 09:09:33 +0800
Message-ID: <20220920010939.12173-4-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

This debug entry is to summarize important messages to quickly address
problem types, such as firmware hang, C2H/H2C stuck, or too much
occupation of BT A2DP. If unexpected something is addressed, we can dig
the problem via other debug messages that provide more detail information.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 118 +++++++++++++++++++++-
 1 file changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index b6366e0cf82ad..20e7daa7e175b 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -6778,8 +6778,121 @@ static void _show_summary(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   cnt[BTC_NCNT_CUSTOMERIZE]);
 }
 
+static void _show_summary_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
+	struct rtw89_btc_fbtc_rpt_ctrl_v1 *prptctrl;
+	struct rtw89_btc_rpt_cmn_info *pcinfo;
+	struct rtw89_btc_cx *cx = &btc->cx;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_wl_info *wl = &cx->wl;
+	struct rtw89_btc_bt_info *bt = &cx->bt;
+	u32 cnt_sum = 0, *cnt = btc->dm.cnt_notify;
+	u8 i;
+
+	if (!(dm->coex_info_map & BTC_COEX_INFO_SUMMARY))
+		return;
+
+	seq_puts(m, "========== [Statistics] ==========\n");
+
+	pcinfo = &pfwinfo->rpt_ctrl.cinfo;
+	if (pcinfo->valid && !wl->status.map.lps && !wl->status.map.rf_off) {
+		prptctrl = &pfwinfo->rpt_ctrl.finfo_v1;
+
+		seq_printf(m,
+			   " %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d), c2h_cnt=%d(fw_send:%d), ",
+			   "[summary]", pfwinfo->cnt_h2c,
+			   pfwinfo->cnt_h2c_fail,
+			   le32_to_cpu(prptctrl->rpt_info.cnt_h2c),
+			   pfwinfo->cnt_c2h,
+			   le32_to_cpu(prptctrl->rpt_info.cnt_c2h));
+
+		seq_printf(m,
+			   "rpt_cnt=%d(fw_send:%d), rpt_map=0x%x, dm_error_map:0x%x",
+			   pfwinfo->event[BTF_EVNT_RPT],
+			   le32_to_cpu(prptctrl->rpt_info.cnt),
+			   le32_to_cpu(prptctrl->rpt_info.en),
+			   dm->error.val);
+
+		if (dm->error.map.wl_fw_hang)
+			seq_puts(m, " (WL FW Hang!!)");
+		seq_puts(m, "\n");
+		seq_printf(m,
+			   " %-15s : send_ok:%d, send_fail:%d, recv:%d, ",
+			   "[mailbox]",
+			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_ok),
+			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_fail),
+			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_recv));
+
+		seq_printf(m,
+			   "A2DP_empty:%d(stop:%d, tx:%d, ack:%d, nack:%d)\n",
+			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_empty),
+			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_flowctrl),
+			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_tx),
+			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_ack),
+			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_nack));
+
+		seq_printf(m,
+			   " %-15s : wl_rfk[req:%d/go:%d/reject:%d/timeout:%d]",
+			   "[RFK]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
+			   cx->cnt_wl[BTC_WCNT_RFK_GO],
+			   cx->cnt_wl[BTC_WCNT_RFK_REJECT],
+			   cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT]);
+
+		seq_printf(m,
+			   ", bt_rfk[req:%d/go:%d/reject:%d/timeout:%d/fail:%d]\n",
+			   le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_REQ]),
+			   le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_GO]),
+			   le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_REJECT]),
+			   le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_TIMEOUT]),
+			   le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_FAIL]));
+
+		if (le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_TIMEOUT]) > 0)
+			bt->rfk_info.map.timeout = 1;
+		else
+			bt->rfk_info.map.timeout = 0;
+
+		dm->error.map.wl_rfk_timeout = bt->rfk_info.map.timeout;
+	} else {
+		seq_printf(m,
+			   " %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d, rpt_cnt=%d, rpt_map=0x%x",
+			   "[summary]", pfwinfo->cnt_h2c,
+			   pfwinfo->cnt_h2c_fail, pfwinfo->cnt_c2h,
+			   pfwinfo->event[BTF_EVNT_RPT],
+			   btc->fwinfo.rpt_en_map);
+		seq_puts(m, " (WL FW report invalid!!)\n");
+	}
+
+	for (i = 0; i < BTC_NCNT_NUM; i++)
+		cnt_sum += dm->cnt_notify[i];
+
+	seq_printf(m,
+		   " %-15s : total=%d, show_coex_info=%d, power_on=%d, init_coex=%d, ",
+		   "[notify_cnt]", cnt_sum, cnt[BTC_NCNT_SHOW_COEX_INFO],
+		   cnt[BTC_NCNT_POWER_ON], cnt[BTC_NCNT_INIT_COEX]);
+
+	seq_printf(m,
+		   "power_off=%d, radio_state=%d, role_info=%d, wl_rfk=%d, wl_sta=%d\n",
+		   cnt[BTC_NCNT_POWER_OFF], cnt[BTC_NCNT_RADIO_STATE],
+		   cnt[BTC_NCNT_ROLE_INFO], cnt[BTC_NCNT_WL_RFK],
+		   cnt[BTC_NCNT_WL_STA]);
+
+	seq_printf(m,
+		   " %-15s : scan_start=%d, scan_finish=%d, switch_band=%d, special_pkt=%d, ",
+		   "[notify_cnt]", cnt[BTC_NCNT_SCAN_START],
+		   cnt[BTC_NCNT_SCAN_FINISH], cnt[BTC_NCNT_SWITCH_BAND],
+		   cnt[BTC_NCNT_SPECIAL_PACKET]);
+
+	seq_printf(m,
+		   "timer=%d, control=%d, customerize=%d\n",
+		   cnt[BTC_NCNT_TIMER], cnt[BTC_NCNT_CONTROL],
+		   cnt[BTC_NCNT_CUSTOMERIZE]);
+}
+
 void rtw89_btc_dump_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_fw_suit *fw_suit = &rtwdev->fw.normal;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_cx *cx = &btc->cx;
@@ -6810,5 +6923,8 @@ void rtw89_btc_dump_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	_show_dm_info(rtwdev, m);
 	_show_fw_dm_msg(rtwdev, m);
 	_show_mreg(rtwdev, m);
-	_show_summary(rtwdev, m);
+	if (chip->chip_id == RTL8852A)
+		_show_summary(rtwdev, m);
+	else
+		_show_summary_v1(rtwdev, m);
 }
-- 
2.25.1

