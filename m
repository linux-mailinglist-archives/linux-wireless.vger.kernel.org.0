Return-Path: <linux-wireless+bounces-6486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C135E8A9113
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 04:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1102819B6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 02:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E1629A9;
	Thu, 18 Apr 2024 02:13:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249F33BBD8
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 02:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406387; cv=none; b=eAUwU6JCLEZbKE3hT0Hjs4SFcb7mzBOZxsROPXAmU+hPVfW18x3WCs7aKMAT4EQkQFhkdB4djLLZyF0EnkMQQjJXq9caUaFxBoRg0RDrF97K9kW6gAqUvPbbfE1LxmfNqzPGghEOFgy3p90f01EJgbe835bNeU/KMj5nl1ywYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406387; c=relaxed/simple;
	bh=CbMTp+y76/umfyEakBLFO6iNwgn9uEaLJ4D2gEZMTJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTaY3xp3W7UyOAO7NAee9I/XEUqiTTbqF9Ta9THpCVbFZS2xEgUJmOV9qs8YeSdFzRsKZXHAonHan+94S2ujkbbxnjG/7wWgqN6CQ8xqBlFQ8T511+NCSeMfvshawxQu8Qd6pARUH//c2r1pbdU49py04oVwTtxG6XFZlT0E1jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I2D3HN03994767, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I2D3HN03994767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 10:13:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 10:13:03 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 10:13:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 8/9] wifi: rtw89: coex: Add coexistence firmware control report version 8
Date: Thu, 18 Apr 2024 10:12:06 +0800
Message-ID: <20240418021207.32173-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418021207.32173-1-pkshih@realtek.com>
References: <20240418021207.32173-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Ching-Te Ku <ku920601@realtek.com>

This report summary monitor the firmware related counters, firmware
version. It will help to analysis the communication between driver and
firmware.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 172 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h |  49 +++++-
 2 files changed, 217 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 11ad1f692f9b..15f1c133c70a 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -959,14 +959,25 @@ static void _chk_btc_err(struct rtw89_dev *rtwdev, u8 type, u32 cnt)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_cx *cx = &btc->cx;
-	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_bt_info *bt = &cx->bt;
+	struct rtw89_btc_wl_info *wl = &cx->wl;
+	struct rtw89_btc_dm *dm = &btc->dm;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): type:%d cnt:%d\n",
 		    __func__, type, cnt);
 
 	switch (type) {
+	case BTC_DCNT_WL_FW_VER_MATCH:
+		if ((wl->ver_info.fw_coex & 0xffff0000) !=
+		     rtwdev->chip->wlcx_desired) {
+			wl->fw_ver_mismatch = true;
+			dm->error.map.wl_ver_mismatch = true;
+		} else {
+			wl->fw_ver_mismatch = false;
+			dm->error.map.wl_ver_mismatch = false;
+		}
+		break;
 	case BTC_DCNT_RPT_HANG:
 		if (dm->cnt_dm[BTC_DCNT_RPT] == cnt && btc->fwinfo.rpt_en_map)
 			dm->cnt_dm[BTC_DCNT_RPT_HANG]++;
@@ -1059,6 +1070,19 @@ static void _chk_btc_err(struct rtw89_dev *rtwdev, u8 type, u32 cnt)
 		else
 			dm->error.map.slot_no_sync = false;
 		break;
+	case BTC_DCNT_BTTX_HANG:
+		cnt = cx->cnt_bt[BTC_BCNT_LOPRI_TX];
+
+		if (cnt == 0 && bt->link_info.slave_role)
+			dm->cnt_dm[BTC_DCNT_BTTX_HANG]++;
+		else
+			dm->cnt_dm[BTC_DCNT_BTTX_HANG] = 0;
+
+		if (dm->cnt_dm[BTC_DCNT_BTTX_HANG] >= BTC_CHK_HANG_MAX)
+			dm->error.map.bt_tx_hang = true;
+		else
+			dm->error.map.bt_tx_hang = false;
+		break;
 	case BTC_DCNT_BTCNT_HANG:
 		cnt = cx->cnt_bt[BTC_BCNT_HIPRI_RX] +
 		      cx->cnt_bt[BTC_BCNT_HIPRI_TX] +
@@ -1246,6 +1270,10 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v105);
 			pcinfo->req_fver = 5;
 			break;
+		} else if (ver->fcxbtcrpt == 8) {
+			pfinfo = &pfwinfo->rpt_ctrl.finfo.v8;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v8);
+			break;
 		} else {
 			goto err;
 		}
@@ -1537,6 +1565,44 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				     pfwinfo->event[BTF_EVNT_RPT]);
 
 			dm->error.map.bt_rfk_timeout = bt->rfk_info.map.timeout;
+		} else if (ver->fcxbtcrpt == 8) {
+			prpt->v8 = pfwinfo->rpt_ctrl.finfo.v8;
+			pfwinfo->rpt_en_map = le32_to_cpu(prpt->v8.rpt_info.en);
+			wl->ver_info.fw_coex = le32_to_cpu(prpt->v8.rpt_info.cx_ver);
+			wl->ver_info.fw = le32_to_cpu(prpt->v8.rpt_info.fw_ver);
+
+			for (i = RTW89_PHY_0; i < RTW89_PHY_MAX; i++)
+				memcpy(&dm->gnt.band[i], &prpt->v8.gnt_val[i][0],
+				       sizeof(dm->gnt.band[i]));
+
+			btc->cx.cnt_bt[BTC_BCNT_HIPRI_TX] =
+				le16_to_cpu(prpt->v8.bt_cnt[BTC_BCNT_HI_TX_V105]);
+			btc->cx.cnt_bt[BTC_BCNT_HIPRI_RX] =
+				le16_to_cpu(prpt->v8.bt_cnt[BTC_BCNT_HI_RX_V105]);
+			btc->cx.cnt_bt[BTC_BCNT_LOPRI_TX] =
+				le16_to_cpu(prpt->v8.bt_cnt[BTC_BCNT_LO_TX_V105]);
+			btc->cx.cnt_bt[BTC_BCNT_LOPRI_RX] =
+				le16_to_cpu(prpt->v8.bt_cnt[BTC_BCNT_LO_RX_V105]);
+
+			val1 = le16_to_cpu(prpt->v8.bt_cnt[BTC_BCNT_POLLUTED_V105]);
+			if (val1 > btc->cx.cnt_bt[BTC_BCNT_POLUT_NOW])
+				val1 -= btc->cx.cnt_bt[BTC_BCNT_POLUT_NOW]; /* diff */
+
+			btc->cx.cnt_bt[BTC_BCNT_POLUT_DIFF] = val1;
+			btc->cx.cnt_bt[BTC_BCNT_POLUT_NOW] =
+				le16_to_cpu(prpt->v8.bt_cnt[BTC_BCNT_POLLUTED_V105]);
+
+			val1 = pfwinfo->event[BTF_EVNT_RPT];
+			if (((prpt->v8.rpt_len_max_h << 8) +
+			      prpt->v8.rpt_len_max_l) != ver->info_buf)
+				dm->error.map.h2c_c2h_buffer_mismatch = true;
+			else
+				dm->error.map.h2c_c2h_buffer_mismatch = false;
+
+			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_HANG, 0);
+			_chk_btc_err(rtwdev, BTC_DCNT_RPT_HANG, val1);
+			_chk_btc_err(rtwdev, BTC_DCNT_WL_FW_VER_MATCH, 0);
+			_chk_btc_err(rtwdev, BTC_DCNT_BTTX_HANG, 0);
 		} else {
 			goto err;
 		}
@@ -10046,6 +10112,108 @@ static void _show_summary_v105(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   cnt[BTC_NCNT_CUSTOMERIZE]);
 }
 
+static void _show_summary_v8(struct rtw89_dev *rtwdev, struct seq_file *m)
+{
+	struct rtw89_btc_btf_fwinfo *pfwinfo = &rtwdev->btc.fwinfo;
+	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
+	struct rtw89_btc_fbtc_rpt_ctrl_v8 *prptctrl = NULL;
+	struct rtw89_btc_cx *cx = &rtwdev->btc.cx;
+	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
+	struct rtw89_btc_wl_info *wl = &cx->wl;
+	u32 *cnt = rtwdev->btc.dm.cnt_notify;
+	u32 cnt_sum = 0;
+	u8 i;
+
+	if (!(dm->coex_info_map & BTC_COEX_INFO_SUMMARY))
+		return;
+
+	seq_printf(m, "%s", "\n\r========== [Statistics] ==========");
+
+	pcinfo = &pfwinfo->rpt_ctrl.cinfo;
+	if (pcinfo->valid && wl->status.map.lps != BTC_LPS_RF_OFF &&
+	    !wl->status.map.rf_off) {
+		prptctrl = &pfwinfo->rpt_ctrl.finfo.v8;
+
+		seq_printf(m,
+			   "\n\r %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d), c2h_cnt=%d(fw_send:%d, len:%d, max:fw-%d/drv-%d), ",
+			   "[summary]", pfwinfo->cnt_h2c, pfwinfo->cnt_h2c_fail,
+			   le16_to_cpu(prptctrl->rpt_info.cnt_h2c), pfwinfo->cnt_c2h,
+			   le16_to_cpu(prptctrl->rpt_info.cnt_c2h),
+			   le16_to_cpu(prptctrl->rpt_info.len_c2h),
+			   (prptctrl->rpt_len_max_h << 8) + prptctrl->rpt_len_max_l,
+			   rtwdev->btc.ver->info_buf);
+
+		seq_printf(m, "rpt_cnt=%d(fw_send:%d), rpt_map=0x%x",
+			   pfwinfo->event[BTF_EVNT_RPT],
+			   le16_to_cpu(prptctrl->rpt_info.cnt),
+			   le32_to_cpu(prptctrl->rpt_info.en));
+
+		if (dm->error.map.wl_fw_hang)
+			seq_puts(m, " (WL FW Hang!!)");
+
+		seq_printf(m, "\n\r %-15s : send_ok:%d, send_fail:%d, recv:%d, ",
+			   "[mailbox]", le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_ok),
+			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_fail),
+			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_recv));
+
+		seq_printf(m, "A2DP_empty:%d(stop:%d/tx:%d/ack:%d/nack:%d)",
+			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_empty),
+			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_flowctrl),
+			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_tx),
+			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_ack),
+			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_nack));
+
+		seq_printf(m,
+			   "\n\r %-15s : wl_rfk[req:%d/go:%d/reject:%d/tout:%d/time:%dms]",
+			   "[RFK/LPS]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
+			   cx->cnt_wl[BTC_WCNT_RFK_GO],
+			   cx->cnt_wl[BTC_WCNT_RFK_REJECT],
+			   cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT],
+			   wl->rfk_info.proc_time);
+
+		seq_printf(m, ", bt_rfk[req:%d]",
+			   le16_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_REQ]));
+
+		seq_printf(m, ", AOAC[RF_on:%d/RF_off:%d]",
+			   le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_on),
+			   le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_off));
+	} else {
+		seq_printf(m,
+			   "\n\r %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d (lps=%d/rf_off=%d)",
+			   "[summary]",
+			   pfwinfo->cnt_h2c, pfwinfo->cnt_h2c_fail,
+			   pfwinfo->cnt_c2h,
+			   wl->status.map.lps, wl->status.map.rf_off);
+	}
+
+	for (i = 0; i < BTC_NCNT_NUM; i++)
+		cnt_sum += dm->cnt_notify[i];
+
+	seq_printf(m,
+		   "\n\r %-15s : total=%d, show_coex_info=%d, power_on=%d, init_coex=%d, ",
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
+	seq_printf(m,
+		   "\n\r %-15s : scan_start=%d, scan_finish=%d, switch_band=%d, switch_chbw=%d, special_pkt=%d, ",
+		   "[notify_cnt]",
+		   cnt[BTC_NCNT_SCAN_START], cnt[BTC_NCNT_SCAN_FINISH],
+		   cnt[BTC_NCNT_SWITCH_BAND], cnt[BTC_NCNT_SWITCH_CHBW],
+		   cnt[BTC_NCNT_SPECIAL_PACKET]);
+
+	seq_printf(m, "timer=%d, customerize=%d, hub_msg=%d, chg_fw=%d, send_cc=%d",
+		   cnt[BTC_NCNT_TIMER], cnt[BTC_NCNT_CUSTOMERIZE],
+		   rtwdev->btc.hubmsg_cnt, cnt[BTC_NCNT_RESUME_DL_FW],
+		   cnt[BTC_NCNT_COUNTRYCODE]);
+}
+
 void rtw89_btc_dump_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw89_fw_suit *fw_suit = &rtwdev->fw.normal;
@@ -10096,6 +10264,8 @@ void rtw89_btc_dump_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		_show_summary_v5(rtwdev, m);
 	else if (ver->fcxbtcrpt == 105)
 		_show_summary_v105(rtwdev, m);
+	else if (ver->fcxbtcrpt == 8)
+		_show_summary_v8(rtwdev, m);
 }
 
 void rtw89_coex_recognize_ver(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c66d52ee4700..774050aa21c7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1180,9 +1180,13 @@ enum rtw89_btc_ncnt {
 	BTC_NCNT_CUSTOMERIZE,
 	BTC_NCNT_WL_RFK,
 	BTC_NCNT_WL_STA,
+	BTC_NCNT_WL_STA_LAST,
 	BTC_NCNT_FWINFO,
 	BTC_NCNT_TIMER,
-	BTC_NCNT_NUM
+	BTC_NCNT_SWITCH_CHBW,
+	BTC_NCNT_RESUME_DL_FW,
+	BTC_NCNT_COUNTRYCODE,
+	BTC_NCNT_NUM,
 };
 
 enum rtw89_btc_btinfo {
@@ -1211,6 +1215,7 @@ enum rtw89_btc_dcnt {
 	BTC_DCNT_TDMA_NONSYNC,
 	BTC_DCNT_SLOT_NONSYNC,
 	BTC_DCNT_BTCNT_HANG,
+	BTC_DCNT_BTTX_HANG,
 	BTC_DCNT_WL_SLOT_DRIFT,
 	BTC_DCNT_WL_STA_LAST,
 	BTC_DCNT_BT_SLOT_DRIFT,
@@ -1218,7 +1223,10 @@ enum rtw89_btc_dcnt {
 	BTC_DCNT_FDDT_TRIG,
 	BTC_DCNT_E2G,
 	BTC_DCNT_E2G_HANG,
-	BTC_DCNT_NUM
+	BTC_DCNT_WL_FW_VER_MATCH,
+	BTC_DCNT_NULL_TX_FAIL,
+	BTC_DCNT_WL_STA_NTFY,
+	BTC_DCNT_NUM,
 };
 
 enum rtw89_btc_wl_state_cnt {
@@ -1262,8 +1270,10 @@ enum rtw89_btc_bt_state_cnt {
 	BTC_BCNT_LOPRI_TX,
 	BTC_BCNT_LOPRI_RX,
 	BTC_BCNT_POLUT,
+	BTC_BCNT_POLUT_NOW,
+	BTC_BCNT_POLUT_DIFF,
 	BTC_BCNT_RATECHG,
-	BTC_BCNT_NUM
+	BTC_BCNT_NUM,
 };
 
 enum rtw89_btc_bt_profile {
@@ -1675,6 +1685,9 @@ struct rtw89_btc_wl_rfk_info {
 	u32 band: 2;
 	u32 type: 8;
 	u32 rsvd: 14;
+
+	u32 start_time;
+	u32 proc_time;
 };
 
 struct rtw89_btc_bt_smap {
@@ -1813,6 +1826,7 @@ struct rtw89_btc_wl_info {
 	bool pta_reg_mac_chg;
 	bool bg_mode;
 	bool scbd_change;
+	bool fw_ver_mismatch;
 	u32 scbd;
 };
 
@@ -2084,6 +2098,20 @@ struct rtw89_btc_fbtc_rpt_ctrl_info_v5 {
 	__le16 cnt_aoac_rf_off; /* rf-off counter for aoac switch notify */
 } __packed;
 
+struct rtw89_btc_fbtc_rpt_ctrl_info_v8 {
+	__le16 cnt; /* fw report counter */
+	__le16 cnt_c2h; /* fw send c2h counter  */
+	__le16 cnt_h2c; /* fw recv h2c counter */
+	__le16 len_c2h; /* The total length of the last C2H  */
+
+	__le16 cnt_aoac_rf_on;  /* rf-on counter for aoac switch notify */
+	__le16 cnt_aoac_rf_off; /* rf-off counter for aoac switch notify */
+
+	__le32 cx_ver; /* match which driver's coex version */
+	__le32 fw_ver;
+	__le32 en; /* report map */
+} __packed;
+
 struct rtw89_btc_fbtc_rpt_ctrl_wl_fw_info {
 	__le32 cx_ver; /* match which driver's coex version */
 	__le32 cx_offload;
@@ -2140,11 +2168,25 @@ struct rtw89_btc_fbtc_rpt_ctrl_v105 {
 	struct rtw89_btc_fbtc_rpt_ctrl_bt_mailbox bt_mbx_info;
 } __packed;
 
+struct rtw89_btc_fbtc_rpt_ctrl_v8 {
+	u8 fver;
+	u8 rsvd0;
+	u8 rpt_len_max_l; /* BTC_RPT_MAX bit0~7 */
+	u8 rpt_len_max_h; /* BTC_RPT_MAX bit8~15 */
+
+	u8 gnt_val[RTW89_PHY_MAX][4];
+	__le16 bt_cnt[BTC_BCNT_STA_MAX_V105];
+
+	struct rtw89_btc_fbtc_rpt_ctrl_info_v8 rpt_info;
+	struct rtw89_btc_fbtc_rpt_ctrl_bt_mailbox bt_mbx_info;
+} __packed;
+
 union rtw89_btc_fbtc_rpt_ctrl_ver_info {
 	struct rtw89_btc_fbtc_rpt_ctrl_v1 v1;
 	struct rtw89_btc_fbtc_rpt_ctrl_v4 v4;
 	struct rtw89_btc_fbtc_rpt_ctrl_v5 v5;
 	struct rtw89_btc_fbtc_rpt_ctrl_v105 v105;
+	struct rtw89_btc_fbtc_rpt_ctrl_v8 v8;
 };
 
 enum rtw89_fbtc_ext_ctrl_type {
@@ -2992,6 +3034,7 @@ struct rtw89_btc {
 	u8 btg_pos;
 	u16 policy_len;
 	u16 policy_type;
+	u32 hubmsg_cnt;
 	bool bt_req_en;
 	bool update_policy_force;
 	bool lps;
-- 
2.25.1


