Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B336B880E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 03:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCNCHg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 22:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjCNCHf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 22:07:35 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785FA85A79
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 19:07:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32E27FFU0011870, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32E27FFU0011870
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 14 Mar 2023 10:07:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Mar 2023 10:07:27 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 14 Mar
 2023 10:07:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/5] wifi: rtw89: coex: Add report control v5 variation
Date:   Tue, 14 Mar 2023 10:06:16 +0800
Message-ID: <20230314020617.28193-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314020617.28193-1-pkshih@realtek.com>
References: <20230314020617.28193-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

In order to reduce firmware code size cost, remove some counter value from
the structure. But firmware didn't update version code. To parse the
correct report, add another variation version v105 to parse it.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 148 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  23 ++++
 2 files changed, 171 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index d4a2ed254213b..c0ca37473f03b 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1022,6 +1022,11 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		} else if (ver->fcxbtcrpt == 5) {
 			pfinfo = &pfwinfo->rpt_ctrl.finfo.v5;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v5);
+		} else if (ver->fcxbtcrpt == 105) {
+			pfinfo = &pfwinfo->rpt_ctrl.finfo.v105;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v105);
+			pcinfo->req_fver = 5;
+			break;
 		} else {
 			goto err;
 		}
@@ -1263,6 +1268,33 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			_chk_btc_err(rtwdev, BTC_DCNT_RPT_HANG,
 				     pfwinfo->event[BTF_EVNT_RPT]);
 
+			dm->error.map.bt_rfk_timeout = bt->rfk_info.map.timeout;
+		} else if (ver->fcxbtcrpt == 105) {
+			prpt->v105 = pfwinfo->rpt_ctrl.finfo.v105;
+			pfwinfo->rpt_en_map = le32_to_cpu(prpt->v105.rpt_info.en);
+			wl->ver_info.fw_coex = le32_to_cpu(prpt->v105.rpt_info.cx_ver);
+			wl->ver_info.fw = le32_to_cpu(prpt->v105.rpt_info.fw_ver);
+			dm->wl_fw_cx_offload = 0;
+
+			for (i = RTW89_PHY_0; i < RTW89_PHY_MAX; i++)
+				memcpy(&dm->gnt.band[i], &prpt->v105.gnt_val[i][0],
+				       sizeof(dm->gnt.band[i]));
+
+			btc->cx.cnt_bt[BTC_BCNT_HIPRI_TX] =
+				le16_to_cpu(prpt->v105.bt_cnt[BTC_BCNT_HI_TX_V105]);
+			btc->cx.cnt_bt[BTC_BCNT_HIPRI_RX] =
+				le16_to_cpu(prpt->v105.bt_cnt[BTC_BCNT_HI_RX_V105]);
+			btc->cx.cnt_bt[BTC_BCNT_LOPRI_TX] =
+				le16_to_cpu(prpt->v105.bt_cnt[BTC_BCNT_LO_TX_V105]);
+			btc->cx.cnt_bt[BTC_BCNT_LOPRI_RX] =
+				le16_to_cpu(prpt->v105.bt_cnt[BTC_BCNT_LO_RX_V105]);
+			btc->cx.cnt_bt[BTC_BCNT_POLUT] =
+				le16_to_cpu(prpt->v105.bt_cnt[BTC_BCNT_POLLUTED_V105]);
+
+			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_HANG, 0);
+			_chk_btc_err(rtwdev, BTC_DCNT_RPT_HANG,
+				     pfwinfo->event[BTF_EVNT_RPT]);
+
 			dm->error.map.bt_rfk_timeout = bt->rfk_info.map.timeout;
 		} else {
 			goto err;
@@ -8165,7 +8197,121 @@ static void _show_summary_v5(struct rtw89_dev *rtwdev, struct seq_file *m)
 			   le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_on),
 			   le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_off));
 	} else {
+		seq_printf(m,
+			   " %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d",
+			   "[summary]", pfwinfo->cnt_h2c,
+			   pfwinfo->cnt_h2c_fail, pfwinfo->cnt_c2h);
+	}
+
+	if (!pcinfo->valid || pfwinfo->len_mismch || pfwinfo->fver_mismch ||
+	    pfwinfo->err[BTFRE_EXCEPTION]) {
+		seq_puts(m, "\n");
+		seq_printf(m,
+			   " %-15s : WL FW rpt error!![rpt_ctrl_valid:%d/len:"
+			   "0x%x/ver:0x%x/ex:%d/lps=%d/rf_off=%d]",
+			   "[ERROR]", pcinfo->valid, pfwinfo->len_mismch,
+			   pfwinfo->fver_mismch, pfwinfo->err[BTFRE_EXCEPTION],
+			   wl->status.map.lps, wl->status.map.rf_off);
+	}
+
+	for (i = 0; i < BTC_NCNT_NUM; i++)
+		cnt_sum += dm->cnt_notify[i];
+
+	seq_puts(m, "\n");
+	seq_printf(m,
+		   " %-15s : total=%d, show_coex_info=%d, power_on=%d, init_coex=%d, ",
+		   "[notify_cnt]",
+		   cnt_sum, cnt[BTC_NCNT_SHOW_COEX_INFO],
+		   cnt[BTC_NCNT_POWER_ON], cnt[BTC_NCNT_INIT_COEX]);
+
+	seq_printf(m,
+		   "power_off=%d, radio_state=%d, role_info=%d, wl_rfk=%d, wl_sta=%d",
+		   cnt[BTC_NCNT_POWER_OFF], cnt[BTC_NCNT_RADIO_STATE],
+		   cnt[BTC_NCNT_ROLE_INFO], cnt[BTC_NCNT_WL_RFK],
+		   cnt[BTC_NCNT_WL_STA]);
+
+	seq_puts(m, "\n");
+	seq_printf(m,
+		   " %-15s : scan_start=%d, scan_finish=%d, switch_band=%d, special_pkt=%d, ",
+		   "[notify_cnt]",
+		   cnt[BTC_NCNT_SCAN_START], cnt[BTC_NCNT_SCAN_FINISH],
+		   cnt[BTC_NCNT_SWITCH_BAND], cnt[BTC_NCNT_SPECIAL_PACKET]);
+
+	seq_printf(m,
+		   "timer=%d, control=%d, customerize=%d",
+		   cnt[BTC_NCNT_TIMER], cnt[BTC_NCNT_CONTROL],
+		   cnt[BTC_NCNT_CUSTOMERIZE]);
+}
+
+static void _show_summary_v105(struct rtw89_dev *rtwdev, struct seq_file *m)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
+	struct rtw89_btc_fbtc_rpt_ctrl_v105 *prptctrl;
+	struct rtw89_btc_rpt_cmn_info *pcinfo;
+	struct rtw89_btc_cx *cx = &btc->cx;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_wl_info *wl = &cx->wl;
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
+		prptctrl = &pfwinfo->rpt_ctrl.finfo.v105;
+
+		seq_printf(m,
+			   " %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d), c2h_cnt=%d(fw_send:%d, len:%d), ",
+			   "[summary]", pfwinfo->cnt_h2c, pfwinfo->cnt_h2c_fail,
+			   le16_to_cpu(prptctrl->rpt_info.cnt_h2c),
+			   pfwinfo->cnt_c2h,
+			   le16_to_cpu(prptctrl->rpt_info.cnt_c2h),
+			   le16_to_cpu(prptctrl->rpt_info.len_c2h));
+
+		seq_printf(m,
+			   "rpt_cnt=%d(fw_send:%d), rpt_map=0x%x",
+			   pfwinfo->event[BTF_EVNT_RPT],
+			   le16_to_cpu(prptctrl->rpt_info.cnt),
+			   le32_to_cpu(prptctrl->rpt_info.en));
+
+		if (dm->error.map.wl_fw_hang)
+			seq_puts(m, " (WL FW Hang!!)");
 		seq_puts(m, "\n");
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
+			   " %-15s : wl_rfk[req:%d/go:%d/reject:%d/tout:%d]",
+			   "[RFK/LPS]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
+			   cx->cnt_wl[BTC_WCNT_RFK_GO],
+			   cx->cnt_wl[BTC_WCNT_RFK_REJECT],
+			   cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT]);
+
+		seq_printf(m,
+			   ", bt_rfk[req:%d]",
+			   le16_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_REQ]));
+
+		seq_printf(m,
+			   ", AOAC[RF_on:%d/RF_off:%d]",
+			   le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_on),
+			   le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_off));
+	} else {
 		seq_printf(m,
 			   " %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d",
 			   "[summary]", pfwinfo->cnt_h2c,
@@ -8256,6 +8402,8 @@ void rtw89_btc_dump_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		_show_summary_v4(rtwdev, m);
 	else if (ver->fcxbtcrpt == 5)
 		_show_summary_v5(rtwdev, m);
+	else if (ver->fcxbtcrpt == 105)
+		_show_summary_v105(rtwdev, m);
 }
 
 void rtw89_coex_recognize_ver(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3b13f2a6b42d6..ea2eb3ac1df07 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1576,6 +1576,16 @@ enum rtw89_btc_bt_sta_counter {
 	BTC_BCNT_STA_MAX
 };
 
+enum rtw89_btc_bt_sta_counter_v105 {
+	BTC_BCNT_RFK_REQ_V105 = 0,
+	BTC_BCNT_HI_TX_V105 = 1,
+	BTC_BCNT_HI_RX_V105 = 2,
+	BTC_BCNT_LO_TX_V105 = 3,
+	BTC_BCNT_LO_RX_V105 = 4,
+	BTC_BCNT_POLLUTED_V105 = 5,
+	BTC_BCNT_STA_MAX_V105
+};
+
 struct rtw89_btc_fbtc_rpt_ctrl_v1 {
 	u16 fver; /* btc_ver::fcxbtcrpt */
 	u16 rpt_cnt; /* tmr counters */
@@ -1666,10 +1676,23 @@ struct rtw89_btc_fbtc_rpt_ctrl_v5 {
 	struct rtw89_btc_fbtc_rpt_ctrl_bt_mailbox bt_mbx_info;
 } __packed;
 
+struct rtw89_btc_fbtc_rpt_ctrl_v105 {
+	u8 fver;
+	u8 rsvd;
+	__le16 rsvd1;
+
+	u8 gnt_val[RTW89_PHY_MAX][4];
+	__le16 bt_cnt[BTC_BCNT_STA_MAX_V105];
+
+	struct rtw89_btc_fbtc_rpt_ctrl_info_v5 rpt_info;
+	struct rtw89_btc_fbtc_rpt_ctrl_bt_mailbox bt_mbx_info;
+} __packed;
+
 union rtw89_btc_fbtc_rpt_ctrl_ver_info {
 	struct rtw89_btc_fbtc_rpt_ctrl_v1 v1;
 	struct rtw89_btc_fbtc_rpt_ctrl_v4 v4;
 	struct rtw89_btc_fbtc_rpt_ctrl_v5 v5;
+	struct rtw89_btc_fbtc_rpt_ctrl_v105 v105;
 };
 
 enum rtw89_fbtc_ext_ctrl_type {
-- 
2.25.1

