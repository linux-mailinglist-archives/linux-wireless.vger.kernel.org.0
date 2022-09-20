Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DBD5BD930
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 03:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiITBLf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 21:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiITBLG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 21:11:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFDB74F64A
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 18:10:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28K19tTA2031035, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28K19tTA2031035
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 20 Sep 2022 09:09:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 09:10:18 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 20 Sep
 2022 09:10:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/9] wifi: rtw89: coex: add v1 cycle report to parsing Bluetooth A2DP status
Date:   Tue, 20 Sep 2022 09:09:31 +0800
Message-ID: <20220920010939.12173-2-pkshih@realtek.com>
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

'cysta' is short for statistics for cycles. That is a circular buffer to
record snapshot status including beacon count, RX count, TX count etc.
Since 8852CE Wi-Fi firmware report this statistics in different format,
add v1 parser by this patch.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 138 +++++++++++++++++++++-
 1 file changed, 137 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 8f8f8a9786824..991ebd94086bf 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -6209,6 +6209,136 @@ static void _show_fbtc_cysta(struct rtw89_dev *rtwdev, struct seq_file *m)
 	}
 }
 
+static void _show_fbtc_cysta_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
+	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_fbtc_a2dp_trx_stat *a2dp_trx;
+	struct rtw89_btc_fbtc_cysta_v1 *pcysta;
+	struct rtw89_btc_rpt_cmn_info *pcinfo;
+	u8 i, cnt = 0, slot_pair, divide_cnt;
+	u16 cycle, c_begin, c_end, store_index;
+
+	pcinfo = &pfwinfo->rpt_fbtc_cysta.cinfo;
+	if (!pcinfo->valid)
+		return;
+
+	pcysta = &pfwinfo->rpt_fbtc_cysta.finfo_v1;
+	seq_printf(m,
+		   " %-15s : cycle:%d, bcn[all:%d/all_ok:%d/bt:%d/bt_ok:%d]",
+		   "[cycle_cnt]",
+		   le16_to_cpu(pcysta->cycles),
+		   le32_to_cpu(pcysta->bcn_cnt[CXBCN_ALL]),
+		   le32_to_cpu(pcysta->bcn_cnt[CXBCN_ALL_OK]),
+		   le32_to_cpu(pcysta->bcn_cnt[CXBCN_BT_SLOT]),
+		   le32_to_cpu(pcysta->bcn_cnt[CXBCN_BT_OK]));
+
+	for (i = 0; i < CXST_MAX; i++) {
+		if (!le32_to_cpu(pcysta->slot_cnt[i]))
+			continue;
+
+		seq_printf(m, ", %d:%d", i, le32_to_cpu(pcysta->slot_cnt[i]));
+	}
+
+	if (dm->tdma_now.rxflctrl)
+		seq_printf(m, ", leak_rx:%d", le32_to_cpu(pcysta->leak_slot.cnt_rximr));
+
+	if (le32_to_cpu(pcysta->collision_cnt))
+		seq_printf(m, ", collision:%d", le32_to_cpu(pcysta->collision_cnt));
+
+	if (le32_to_cpu(pcysta->skip_cnt))
+		seq_printf(m, ", skip:%d", le32_to_cpu(pcysta->skip_cnt));
+
+	seq_puts(m, "\n");
+
+	seq_printf(m, " %-15s : avg_t[wl:%d/bt:%d/lk:%d.%03d]",
+		   "[cycle_time]",
+		   le16_to_cpu(pcysta->cycle_time.tavg[CXT_WL]),
+		   le16_to_cpu(pcysta->cycle_time.tavg[CXT_BT]),
+		   le16_to_cpu(pcysta->leak_slot.tavg) / 1000,
+		   le16_to_cpu(pcysta->leak_slot.tavg) % 1000);
+	seq_printf(m,
+		   ", max_t[wl:%d/bt:%d/lk:%d.%03d]",
+		   le16_to_cpu(pcysta->cycle_time.tmax[CXT_WL]),
+		   le16_to_cpu(pcysta->cycle_time.tmax[CXT_BT]),
+		   le16_to_cpu(pcysta->leak_slot.tmax) / 1000,
+		   le16_to_cpu(pcysta->leak_slot.tmax) % 1000);
+	seq_printf(m,
+		   ", maxdiff_t[wl:%d/bt:%d]\n",
+		   le16_to_cpu(pcysta->cycle_time.tmaxdiff[CXT_WL]),
+		   le16_to_cpu(pcysta->cycle_time.tmaxdiff[CXT_BT]));
+
+	cycle = le16_to_cpu(pcysta->cycles);
+	if (cycle == 0)
+		return;
+
+	/* 1 cycle record 1 wl-slot and 1 bt-slot */
+	slot_pair = BTC_CYCLE_SLOT_MAX / 2;
+
+	if (cycle <= slot_pair)
+		c_begin = 1;
+	else
+		c_begin = cycle - slot_pair + 1;
+
+	c_end = cycle;
+
+	if (a2dp->exist)
+		divide_cnt = 3;
+	else
+		divide_cnt = BTC_CYCLE_SLOT_MAX / 4;
+
+	for (cycle = c_begin; cycle <= c_end; cycle++) {
+		cnt++;
+		store_index = ((cycle - 1) % slot_pair) * 2;
+
+		if (cnt % divide_cnt == 1) {
+			seq_printf(m, "\n\r %-15s : ", "[cycle_step]");
+		} else {
+			seq_printf(m, "->b%02d",
+				   le16_to_cpu(pcysta->slot_step_time[store_index]));
+			if (a2dp->exist) {
+				a2dp_trx = &pcysta->a2dp_trx[store_index];
+				seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
+					   a2dp_trx->empty_cnt,
+					   a2dp_trx->retry_cnt,
+					   a2dp_trx->tx_rate ? 3 : 2,
+					   a2dp_trx->tx_cnt,
+					   a2dp_trx->ack_cnt,
+					   a2dp_trx->nack_cnt);
+			}
+			seq_printf(m, "->w%02d",
+				   le16_to_cpu(pcysta->slot_step_time[store_index + 1]));
+			if (a2dp->exist) {
+				a2dp_trx = &pcysta->a2dp_trx[store_index + 1];
+				seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
+					   a2dp_trx->empty_cnt,
+					   a2dp_trx->retry_cnt,
+					   a2dp_trx->tx_rate ? 3 : 2,
+					   a2dp_trx->tx_cnt,
+					   a2dp_trx->ack_cnt,
+					   a2dp_trx->nack_cnt);
+			}
+		}
+		if (cnt % (BTC_CYCLE_SLOT_MAX / 4) == 0 || cnt == c_end)
+			seq_puts(m, "\n");
+	}
+
+	if (a2dp->exist) {
+		seq_printf(m, "%-15s : a2dp_ept:%d, a2dp_late:%d",
+			   "[a2dp_t_sta]",
+			   le16_to_cpu(pcysta->a2dp_ept.cnt),
+			   le16_to_cpu(pcysta->a2dp_ept.cnt_timeout));
+
+		seq_printf(m, ", avg_t:%d, max_t:%d",
+			   le16_to_cpu(pcysta->a2dp_ept.tavg),
+			   le16_to_cpu(pcysta->a2dp_ept.tmax));
+
+		seq_puts(m, "\n");
+	}
+}
+
 static void _show_fbtc_nullsta(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -6353,6 +6483,7 @@ static void _show_fbtc_step(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 static void _show_fw_dm_msg(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 
 	if (!(btc->dm.coex_info_map & BTC_COEX_INFO_DM))
@@ -6361,7 +6492,12 @@ static void _show_fw_dm_msg(struct rtw89_dev *rtwdev, struct seq_file *m)
 	_show_error(rtwdev, m);
 	_show_fbtc_tdma(rtwdev, m);
 	_show_fbtc_slots(rtwdev, m);
-	_show_fbtc_cysta(rtwdev, m);
+
+	if (chip->chip_id == RTL8852A)
+		_show_fbtc_cysta(rtwdev, m);
+	else
+		_show_fbtc_cysta_v1(rtwdev, m);
+
 	_show_fbtc_nullsta(rtwdev, m);
 	_show_fbtc_step(rtwdev, m);
 }
-- 
2.25.1

