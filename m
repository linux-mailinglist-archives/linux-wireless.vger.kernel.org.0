Return-Path: <linux-wireless+bounces-11553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D030E954913
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 14:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CC2B21F23
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 12:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAA12E859;
	Fri, 16 Aug 2024 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="u/MaNq9k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7848F13DBB7
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812400; cv=none; b=cObXbEvvJbHMZT9dyJf1/OstWsA0/n6BVPCIj8ZMaCxd6+gR4CvrodODIXf/A0ZNMV3TFOlRkVtxwzjvI8BIWaQFRd1Q0xLW999BMlgXAjVYemWyVHD0oCvUgsLQj1JGyf0jjDzg0NZ1snpEVd5AMF+w0ZwcwXtqKs2AivXFalA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812400; c=relaxed/simple;
	bh=1TilkMSy/ygwYCK5IMDy422YV3n96PXq7Fos41RVMJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLRKCUNvQw7Se08vJsjxsYVQZOOTx3MR4NVmV6vbIjLw2iRIa0crbc9CfkAOWS8UVLcKYVGvhbpl64jtfpCBXltzktvupT9hy8tGJQvJrK0n01TLj6U/n+5rPFyJ71N0xFhjOx6+QyAdAqhP1eCM0Xevk/i7RvpBEK7Ld1VuLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=u/MaNq9k; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47GCkXAQ11027879, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723812393; bh=1TilkMSy/ygwYCK5IMDy422YV3n96PXq7Fos41RVMJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=u/MaNq9klaAGQM0TkQKsm/Wd97nzAvqFFmIAvfHfviGlgwtottSp6UvmP7OTFSR4+
	 a7pPZMmUL5xSpeRfMcXsQBnOu5XCqz01Js9Z8X1OiS5Ds+Jta7FvluI0OjQfkZaijm
	 9d1Bl5kOiDGo5IrnCRJ/RGX/d6AJ9GElq+AJP798os5/VsuvxJHDpNChPjP7wvYNyB
	 cU88Y8VjbvqBEvfMwdmCHVu50fbZrkhwmBarRo7uNCdlq338TR21xd2BrKTb1ye+q1
	 Uvd+3TungXs0oOCZTamY6ebgczTWap61mT15WLQrzBvM5jTjq3lHd3y/m5pegz5meg
	 iL6FThS3hSkow==
Received: from mail.realtek.com (smtpsrv.realtek.com[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47GCkXAQ11027879
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 20:46:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 20:46:34 +0800
Received: from [127.0.1.1] (172.16.21.174) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 Aug
 2024 20:46:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 1/4] wifi: rtw89: coex: Update report version of Wi-Fi firmware 0.29.90.0 for RTL8852BT
Date: Fri, 16 Aug 2024 20:46:11 +0800
Message-ID: <20240816124614.25592-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816124614.25592-1-pkshih@realtek.com>
References: <20240816124614.25592-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

Add the firmware related version code for RTL8852BT version 0.29.90.0.
And add the version 7 report control structure format. Firmware will
collect counters like mailbox count, RF on/off count, and some Bluetooth
related counters into this structure and pass to driver periodically.
It will help to understand how the firmware mechanism working.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 149 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h |  14 ++
 2 files changed, 162 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index c1f6fcef904b..97e34287dfca 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -129,6 +129,13 @@ static const u32 cxtbl[] = {
 
 static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	/* firmware version must be in decreasing order for each chip */
+	{RTL8852BT, RTW89_FW_VER_CODE(0, 29, 90, 0),
+	 .fcxbtcrpt = 7, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
+	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
+	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
+	 .fwlrole = 7,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
+	 .fwevntrptl = 1, .drvinfo_type = 1, .info_buf = 1800, .max_role_num = 6,
+	},
 	{RTL8922A, RTW89_FW_VER_CODE(0, 35, 8, 0),
 	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
@@ -1351,6 +1358,10 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			pfinfo = &pfwinfo->rpt_ctrl.finfo.v8;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v8);
 			break;
+		} else if (ver->fcxbtcrpt == 7) {
+			pfinfo = &pfwinfo->rpt_ctrl.finfo.v7;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v7);
+			break;
 		} else {
 			goto err;
 		}
@@ -1655,6 +1666,38 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				     pfwinfo->event[BTF_EVNT_RPT]);
 
 			dm->error.map.bt_rfk_timeout = bt->rfk_info.map.timeout;
+		} else if (ver->fcxbtcrpt == 7) {
+			prpt->v7 = pfwinfo->rpt_ctrl.finfo.v7;
+			pfwinfo->rpt_en_map = le32_to_cpu(prpt->v7.rpt_info.en);
+			wl->ver_info.fw_coex = le32_to_cpu(prpt->v7.rpt_info.cx_ver);
+			wl->ver_info.fw = le32_to_cpu(prpt->v7.rpt_info.fw_ver);
+
+			for (i = RTW89_PHY_0; i < RTW89_PHY_MAX; i++)
+				memcpy(&dm->gnt.band[i], &prpt->v7.gnt_val[i][0],
+				       sizeof(dm->gnt.band[i]));
+
+			btc->cx.cnt_bt[BTC_BCNT_HIPRI_TX] =
+				le16_to_cpu(prpt->v7.bt_cnt[BTC_BCNT_HI_TX_V105]);
+			btc->cx.cnt_bt[BTC_BCNT_HIPRI_RX] =
+				le16_to_cpu(prpt->v7.bt_cnt[BTC_BCNT_HI_RX_V105]);
+			btc->cx.cnt_bt[BTC_BCNT_LOPRI_TX] =
+				le16_to_cpu(prpt->v7.bt_cnt[BTC_BCNT_LO_TX_V105]);
+			btc->cx.cnt_bt[BTC_BCNT_LOPRI_RX] =
+				le16_to_cpu(prpt->v7.bt_cnt[BTC_BCNT_LO_RX_V105]);
+
+			val1 = le16_to_cpu(prpt->v7.bt_cnt[BTC_BCNT_POLLUTED_V105]);
+			if (val1 > btc->cx.cnt_bt[BTC_BCNT_POLUT_NOW])
+				val1 -= btc->cx.cnt_bt[BTC_BCNT_POLUT_NOW]; /* diff */
+
+			btc->cx.cnt_bt[BTC_BCNT_POLUT_DIFF] = val1;
+			btc->cx.cnt_bt[BTC_BCNT_POLUT_NOW] =
+				le16_to_cpu(prpt->v7.bt_cnt[BTC_BCNT_POLLUTED_V105]);
+
+			val1 = pfwinfo->event[BTF_EVNT_RPT];
+			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_HANG, 0);
+			_chk_btc_err(rtwdev, BTC_DCNT_RPT_HANG, val1);
+			_chk_btc_err(rtwdev, BTC_DCNT_WL_FW_VER_MATCH, 0);
+			_chk_btc_err(rtwdev, BTC_DCNT_BTTX_HANG, 0);
 		} else if (ver->fcxbtcrpt == 8) {
 			prpt->v8 = pfwinfo->rpt_ctrl.finfo.v8;
 			pfwinfo->rpt_en_map = le32_to_cpu(prpt->v8.rpt_info.en);
@@ -2397,7 +2440,7 @@ static void rtw89_btc_fw_en_rpt(struct rtw89_dev *rtwdev,
 	if (val == fwinfo->rpt_en_map)
 		return;
 
-	if (btc->ver->fcxbtcrpt == 8) {
+	if (btc->ver->fcxbtcrpt == 7 || btc->ver->fcxbtcrpt == 8) {
 		r.v8.type = SET_REPORT_EN;
 		r.v8.fver = btc->ver->fcxbtcrpt;
 		r.v8.len = sizeof(r.v8.map);
@@ -10288,6 +10331,108 @@ static void _show_summary_v105(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   cnt[BTC_NCNT_CUSTOMERIZE]);
 }
 
+static void _show_summary_v7(struct rtw89_dev *rtwdev, struct seq_file *m)
+{
+	struct rtw89_btc_btf_fwinfo *pfwinfo = &rtwdev->btc.fwinfo;
+	struct rtw89_btc_fbtc_rpt_ctrl_v7 *prptctrl = NULL;
+	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
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
+		prptctrl = &pfwinfo->rpt_ctrl.finfo.v7;
+
+		seq_printf(m,
+			   "\n\r %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d),"
+			   "c2h_cnt=%d(fw_send:%d, len:%d, max:%d), ",
+			   "[summary]", pfwinfo->cnt_h2c, pfwinfo->cnt_h2c_fail,
+			   le16_to_cpu(prptctrl->rpt_info.cnt_h2c), pfwinfo->cnt_c2h,
+			   le16_to_cpu(prptctrl->rpt_info.cnt_c2h),
+			   le16_to_cpu(prptctrl->rpt_info.len_c2h),
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
 static void _show_summary_v8(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &rtwdev->btc.fwinfo;
@@ -10440,6 +10585,8 @@ void rtw89_btc_dump_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		_show_summary_v5(rtwdev, m);
 	else if (ver->fcxbtcrpt == 105)
 		_show_summary_v105(rtwdev, m);
+	else if (ver->fcxbtcrpt == 7)
+		_show_summary_v7(rtwdev, m);
 	else if (ver->fcxbtcrpt == 8)
 		_show_summary_v8(rtwdev, m);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3edb2f4372e4..a9feb235c269 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2202,6 +2202,19 @@ struct rtw89_btc_fbtc_rpt_ctrl_v105 {
 	struct rtw89_btc_fbtc_rpt_ctrl_bt_mailbox bt_mbx_info;
 } __packed;
 
+struct rtw89_btc_fbtc_rpt_ctrl_v7 {
+	u8 fver;
+	u8 rsvd0;
+	u8 rsvd1;
+	u8 rsvd2;
+
+	u8 gnt_val[RTW89_PHY_MAX][4];
+	__le16 bt_cnt[BTC_BCNT_STA_MAX_V105];
+
+	struct rtw89_btc_fbtc_rpt_ctrl_info_v8 rpt_info;
+	struct rtw89_btc_fbtc_rpt_ctrl_bt_mailbox bt_mbx_info;
+} __packed;
+
 struct rtw89_btc_fbtc_rpt_ctrl_v8 {
 	u8 fver;
 	u8 rsvd0;
@@ -2220,6 +2233,7 @@ union rtw89_btc_fbtc_rpt_ctrl_ver_info {
 	struct rtw89_btc_fbtc_rpt_ctrl_v4 v4;
 	struct rtw89_btc_fbtc_rpt_ctrl_v5 v5;
 	struct rtw89_btc_fbtc_rpt_ctrl_v105 v105;
+	struct rtw89_btc_fbtc_rpt_ctrl_v7 v7;
 	struct rtw89_btc_fbtc_rpt_ctrl_v8 v8;
 };
 
-- 
2.25.1


