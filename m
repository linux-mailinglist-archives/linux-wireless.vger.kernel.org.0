Return-Path: <linux-wireless+bounces-38898-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h860L+MEU2pXWAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38898-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:07:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBF5743A55
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:07:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=N+ivNT2T;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38898-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38898-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 056F4301779E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974DE2571DA;
	Sun, 12 Jul 2026 03:06:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E792773DE
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:06:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783825615; cv=none; b=iuVMFmIxkuRphsKDDpL/oViBbQWOReOLuoO9MoaR4G44R5mIiCWngaKZIX/vK4u6IWFJvbjmXpQoolYs/USyjS6Pw4EPSIdjmd7GHOcfrIRJp5w08BxI7tz91hKlKd+/ZgnmAOtHlHXwRrYlU5XFHvin/ytGRys7CgqmIRwr7Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783825615; c=relaxed/simple;
	bh=ciokKXSmeiT3tIPVQDstvmWeJGLg7plKiP4QMuFMWkA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jS9PR86l372U2J8QCcwguh0hYQJLd95f4rW4t5V95A85rjS6Fm/n8NT+iM4wFAAUP5LXYEJ8kNZn2xYP9piBLFiy57J1r48riYmNRjgE6HSykoDO6KIIuBIVuc4AV2qbDdqx4Iw0Joda72wKOu0MHhJAJ8o7Dn44AM1wn63W0KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=N+ivNT2T; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C36pdE6525977, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783825611; bh=95QYyHR/9ZT7zC8wb2AM6bPahpm3BhInO1CFHNGu7vY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=N+ivNT2T2Wi2GImzxtjWI0mWeFy31aSOPVIyer2BOrg4jSVSMxGNYkRAdoFN6wsvA
	 X1/tNA5YUtgPfOvaouY5O/nh9pEpuf6jEeTk3xHPW4PfTVLUf4bjPfNQmlz9eg1Iuj
	 nD3Klxd0/lOd8702/Jgcn4IKN7thcd+H/i+aW5tH5+hMkmJAXEReZxndV4GVp9UhRl
	 sPjy6oapbwxIeOYOT3Zr4v6QDmkBoSyk+z4DcxG+N1tual5jIGAB/DwLy7hXti5gig
	 x+AewzXBCYIDUDr22wbc17ocggkXz8dtPHfbwktU+7PpW098v/oe6YYndP0zKLBWLs
	 Tar0BmR59eNog==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C36pdE6525977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:06:51 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:52 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:51 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:06:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 09/11] wifi: rtw89: coex: Add firmware report control report v11
Date: Sun, 12 Jul 2026 11:05:04 +0800
Message-ID: <20260712030506.43438-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260712030506.43438-1-pkshih@realtek.com>
References: <20260712030506.43438-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38898-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:ku920601@realtek.com,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DBF5743A55

From: Ching-Te Ku <ku920601@realtek.com>

In the version 11 report control report, firmware will report firmware
build date, version. And Bluetooth to Wi-Fi scoreboard value will be
read at Wi-Fi firmware and update to Wi-Fi driver.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 218 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h |  26 +++
 2 files changed, 243 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 17290b2cb2c8..c2356d6d9811 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1417,6 +1417,40 @@ static void _chk_btc_err(struct rtw89_dev *rtwdev, u8 type, u32 cnt)
 			dm->error.map.bt_slot_drift = false;
 
 		break;
+	case BTC_DCNT_WL_STA_NTFY:
+		cnt = dm->cnt_notify[BTC_NCNT_WL_STA] -
+		      dm->cnt_notify[BTC_NCNT_WL_STA_LAST];
+
+		dm->cnt_notify[BTC_NCNT_WL_STA_LAST] =
+			dm->cnt_notify[BTC_NCNT_WL_STA];
+
+		if (cnt == 0 &&
+		    (dm->tdd_bind.wl_link_mode != BTC_WLINK_NOLINK ||
+		     dm->fdd_bind.wl_link_mode != BTC_WLINK_NOLINK))
+			dm->cnt_dm[BTC_DCNT_WL_STA_NTFY]++;
+		else
+			dm->cnt_dm[BTC_DCNT_WL_STA_NTFY] = 0;
+
+		if (dm->cnt_dm[BTC_DCNT_WL_STA_NTFY] >= BTC_CHK_HANG_MAX)
+			dm->error.map.wl_no_sta_ntfy = true;
+		else
+			dm->error.map.wl_no_sta_ntfy = false;
+		break;
+	case BTC_DCNT_W2B_SCBD_NOSYNC:
+		if (!(rtwdev->chip->para_ver & BTC_FEAT_MULTI_PTA))
+			return; /* return if no-support W2B scbd readback */
+
+		if (wl->scbd_rb[BTC_BT_1ST] != wl->scbd[BTC_BT_1ST] ||
+		    wl->scbd_rb[BTC_BT_2ND] != wl->scbd[BTC_BT_2ND])
+			dm->cnt_dm[BTC_DCNT_W2B_SCBD_NOSYNC]++;
+		else
+			dm->cnt_dm[BTC_DCNT_W2B_SCBD_NOSYNC] = 0;
+
+		if (dm->cnt_dm[BTC_DCNT_W2B_SCBD_NOSYNC] >= BTC_CHK_HANG_MAX)
+			dm->error.map.w2b_scbd_no_sync = true;
+		else
+			dm->error.map.w2b_scbd_no_sync = false;
+		break;
 	}
 }
 
@@ -1564,6 +1598,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
+	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	union rtw89_btc_fbtc_rpt_ctrl_ver_info *prpt = NULL;
@@ -1574,7 +1609,8 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	u16 wl_slot_set = 0, wl_slot_real = 0, val16;
 	u32 trace_step = 0, rpt_len = 0, diff_t = 0;
 	u32 cnt_leak_slot, bt_slot_real, bt_slot_set, cnt_rx_imr;
-	u8 i, val = 0, val1, val2;
+	u8 i, j, val = 0, val1, val2;
+	u32 *bt_cnt, start_idx;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): index:%d\n",
@@ -1626,6 +1662,10 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			pfinfo = &pfwinfo->rpt_ctrl.finfo.v7;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v7);
 			fwsubver->fcxbtcrpt = pfwinfo->rpt_ctrl.finfo.v7.fver;
+		} else if (ver->fcxbtcrpt == 11) {
+			pfinfo = &pfwinfo->rpt_ctrl.finfo.v11;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v11);
+			fwsubver->fcxbtcrpt = pfwinfo->rpt_ctrl.finfo.v11.fver;
 		} else {
 			goto err;
 		}
@@ -2031,6 +2071,70 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			_chk_btc_err(rtwdev, BTC_DCNT_RPT_HANG, val1);
 			_chk_btc_err(rtwdev, BTC_DCNT_WL_FW_VER_MATCH, 0);
 			_chk_btc_err(rtwdev, BTC_DCNT_BTTX_HANG, 0);
+		} else if (ver->fcxbtcrpt == 11) {
+			prpt->v11 = pfwinfo->rpt_ctrl.finfo.v11;
+			pfwinfo->rpt_en_map = le32_to_cpu(prpt->v11.rpt_info.en);
+			wl->ver_info.fw_coex = le32_to_cpu(prpt->v11.rpt_info.cx_ver);
+			wl->ver_info.fw = le32_to_cpu(prpt->v11.rpt_info.fw_ver);
+
+			memset(wl->ver_info.build_time, 0,
+			       sizeof(wl->ver_info.build_time));
+			memcpy(wl->ver_info.build_time,
+			       prpt->v11.build_time,
+			       sizeof(wl->ver_info.build_time));
+
+			memset(wl->ver_info.build_date, 0,
+			       sizeof(wl->ver_info.build_date));
+			memcpy(wl->ver_info.build_date,
+			       prpt->v11.build_date,
+			       sizeof(wl->ver_info.build_date));
+
+			for (i = RTW89_PHY_0; i < RTW89_PHY_NUM; i++)
+				memcpy(&dm->gnt_set[i], &prpt->v11.gnt_val[i][0],
+				       sizeof(dm->gnt_set[i]));
+
+			for (i = BTC_BT_1ST; i <= BTC_BT_EXT; i++) {
+				if (i == BTC_BT_EXT) {
+					if (cx->bt_ext.func_type == BTC_BTF_NONE)
+						continue;
+					bt_cnt = cx->bt_ext.bcnt;
+				} else if (i == BTC_BT_2ND) {
+					if (!(rtwdev->chip->para_ver & BTC_FEAT_DUAL_BT))
+						continue;
+					bt_cnt = cx->bt1.bcnt;
+					wl->scbd_rb[i] = le32_to_cpu(prpt->v11.scbd_w2b[i]);
+					cx->bt1.scbd_rb = le32_to_cpu(prpt->v11.scbd_b2w[i]);
+				} else {
+					bt_cnt = cx->bt0.bcnt;
+					wl->scbd_rb[i] = le32_to_cpu(prpt->v11.scbd_w2b[i]);
+					cx->bt0.scbd_rb = le32_to_cpu(prpt->v11.scbd_b2w[i]);
+				}
+
+				start_idx = BTC_BCNT_HIPRI_TX;
+				for (j = BTC_BCNT_HI_TX_V105; j <= BTC_BCNT_LO_RX_V105 ; j++)
+					bt_cnt[start_idx++] = le16_to_cpu(prpt->v11.bt_cnt[i][j]);
+
+				/* check if polut counter increase */
+				val1 = le16_to_cpu(prpt->v11.bt_cnt[i][BTC_BCNT_POLLUTED_V105]);
+				if (val1 > bt_cnt[BTC_BCNT_POLUT_NOW]) /* cnt increase*/
+					val2 = val1 - bt_cnt[BTC_BCNT_POLUT_NOW];
+				else
+					val2 = val1; /* overflow */
+
+				bt_cnt[BTC_BCNT_POLUT_DIFF] = val2;
+				bt_cnt[BTC_BCNT_POLUT_NOW] = val1;
+
+				if (i <= BTC_BT_2ND)
+					bt_cnt[BTC_BCNT_SCBDREAD]++;
+			}
+			dm->scbd_w2b_update = true;
+			dm->scbd_b2w_update = true;
+
+			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_HANG, 0);
+			_chk_btc_err(rtwdev, BTC_DCNT_WL_FW_VER_MATCH, 0);
+			_chk_btc_err(rtwdev, BTC_DCNT_BTTX_HANG, 0);
+			_chk_btc_err(rtwdev, BTC_DCNT_WL_STA_NTFY, 0);
+			_chk_btc_err(rtwdev, BTC_DCNT_W2B_SCBD_NOSYNC, 0);
 		} else {
 			goto err;
 		}
@@ -11953,6 +12057,116 @@ static int _show_summary_v8(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	return p - buf;
 }
 
+static int _show_summary_v11(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
+{
+	struct rtw89_btc_btf_fwinfo *pfwinfo = &rtwdev->btc.fwinfo;
+	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
+	struct rtw89_btc_fbtc_rpt_ctrl_v11 *prptctrl = NULL;
+	struct rtw89_btc_cx *cx = &rtwdev->btc.cx;
+	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
+	struct rtw89_btc_wl_info *wl = &cx->wl;
+	u32 *cnt = rtwdev->btc.dm.cnt_notify;
+	char *p = buf, *end = buf + bufsz;
+	u32 cnt_sum = 0;
+	u8 i;
+
+	if (!(dm->coex_info_map & BTC_COEX_INFO_SUMMARY))
+		return 0;
+
+	p += scnprintf(p, end - p, "%s",
+		       "\n\r========== [Statistics] ==========");
+
+	pcinfo = &pfwinfo->rpt_ctrl.cinfo;
+	if (pcinfo->valid && wl->status.map.lps != BTC_LPS_RF_OFF &&
+	    !wl->status.map.rf_off) {
+		prptctrl = &pfwinfo->rpt_ctrl.finfo.v11;
+
+		p += scnprintf(p, end - p,
+			       "\n\r %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d), c2h_cnt=%d(fw_send:%d, len:%d, max:fw-%d/drv-%d), ",
+			       "[summary]", pfwinfo->cnt_h2c,
+			       pfwinfo->cnt_h2c_fail,
+			       le16_to_cpu(prptctrl->rpt_info.cnt_h2c),
+			       pfwinfo->cnt_c2h,
+			       le16_to_cpu(prptctrl->rpt_info.cnt_c2h),
+			       le16_to_cpu(prptctrl->rpt_info.len_c2h),
+			       (prptctrl->rpt_len_max_h << 8) + prptctrl->rpt_len_max_l,
+			       rtwdev->btc.ver->info_buf);
+
+		p += scnprintf(p, end - p,
+			       "rpt_cnt=%d(fw_send:%d), rpt_map=0x%x",
+			       pfwinfo->event[BTF_EVNT_RPT],
+			       le16_to_cpu(prptctrl->rpt_info.cnt),
+			       le32_to_cpu(prptctrl->rpt_info.en));
+
+		if (dm->error.map.wl_fw_hang)
+			p += scnprintf(p, end - p, " (WL FW Hang!!)");
+
+		p += scnprintf(p, end - p,
+			       "\n\r %-15s : send_ok:%d, send_fail:%d, recv:%d, ",
+			       "[mailbox]",
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_ok),
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_fail),
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_recv));
+
+		p += scnprintf(p, end - p,
+			       "A2DP_empty:%d(stop:%d/tx:%d/ack:%d/nack:%d)",
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_empty),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_flowctrl),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_tx),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_ack),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_nack));
+
+		p += scnprintf(p, end - p,
+			       "\n\r %-15s : wl_rfk[req:%d/go:%d/reject:%d/tout:%d/time:%dms]",
+			       "[RFK/LPS]", wl->wcnt[BTC_WCNT_RFK_REQ],
+			       wl->wcnt[BTC_WCNT_RFK_GO],
+			       wl->wcnt[BTC_WCNT_RFK_REJECT],
+			       wl->wcnt[BTC_WCNT_RFK_TIMEOUT],
+			       wl->rfk_info.proc_time);
+
+		p += scnprintf(p, end - p, ", AOAC[RF_on:%d/RF_off:%d]",
+			       le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_on),
+			       le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_off));
+	} else {
+		p += scnprintf(p, end - p,
+			       "\n\r %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d (lps=%d/rf_off=%d)",
+			       "[summary]",
+			       pfwinfo->cnt_h2c, pfwinfo->cnt_h2c_fail,
+			       pfwinfo->cnt_c2h,
+			       wl->status.map.lps, wl->status.map.rf_off);
+	}
+
+	for (i = 0; i < BTC_NCNT_NUM; i++)
+		cnt_sum += dm->cnt_notify[i];
+
+	p += scnprintf(p, end - p,
+		       "\n\r %-15s : total=%d, show_coex_info=%d, power_on=%d, init_coex=%d, ",
+		       "[notify_cnt]",
+		       cnt_sum, cnt[BTC_NCNT_SHOW_COEX_INFO],
+		       cnt[BTC_NCNT_POWER_ON], cnt[BTC_NCNT_INIT_COEX]);
+
+	p += scnprintf(p, end - p,
+		       "power_off=%d, radio_state=%d, role_info=%d, wl_rfk=%d, wl_sta=%d",
+		       cnt[BTC_NCNT_POWER_OFF], cnt[BTC_NCNT_RADIO_STATE],
+		       cnt[BTC_NCNT_ROLE_INFO], cnt[BTC_NCNT_WL_RFK],
+		       cnt[BTC_NCNT_WL_STA]);
+
+	p += scnprintf(p, end - p,
+		       "\n\r %-15s : scan_start=%d, scan_finish=%d, switch_band=%d, switch_chbw=%d, special_pkt=%d, ",
+		       "[notify_cnt]",
+		       cnt[BTC_NCNT_SCAN_START], cnt[BTC_NCNT_SCAN_FINISH],
+		       cnt[BTC_NCNT_SWITCH_BAND], cnt[BTC_NCNT_SWITCH_CHBW],
+		       cnt[BTC_NCNT_SPECIAL_PACKET]);
+
+	p += scnprintf(p, end - p,
+		       "timer=%d, customerize=%d, hub_msg=%d, chg_fw=%d, send_cc=%d",
+		       cnt[BTC_NCNT_TIMER], cnt[BTC_NCNT_CUSTOMERIZE],
+		       rtwdev->btc.hubmsg_cnt, cnt[BTC_NCNT_RESUME_DL_FW],
+		       cnt[BTC_NCNT_COUNTRYCODE]);
+
+	return p - buf;
+}
+
 ssize_t rtw89_btc_dump_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -12016,6 +12230,8 @@ ssize_t rtw89_btc_dump_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 		p += _show_summary_v7(rtwdev, p, end - p);
 	else if (ver->fcxbtcrpt == 8)
 		p += _show_summary_v8(rtwdev, p, end - p);
+	else if (ver->fcxbtcrpt == 11)
+		p += _show_summary_v11(rtwdev, p, end - p);
 
 	return p - buf;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d876de21482f..e7e72f742847 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1406,6 +1406,7 @@ enum rtw89_btc_dcnt {
 	BTC_DCNT_WL_FW_VER_MATCH,
 	BTC_DCNT_NULL_TX_FAIL,
 	BTC_DCNT_WL_STA_NTFY,
+	BTC_DCNT_W2B_SCBD_NOSYNC,
 	BTC_DCNT_NUM,
 };
 
@@ -2058,6 +2059,8 @@ struct rtw89_btc_wl_role_info { /* Logic dynamic using */
 };
 
 struct rtw89_btc_wl_ver_info {
+	char build_time[12];
+	char build_date[12];
 	u32 fw_coex; /* match with which coex_ver */
 	u32 fw;
 	u32 mac;
@@ -2245,6 +2248,7 @@ struct rtw89_btc_dm_emap {
 	u32 h2c_buffer_over: 1;
 	u32 bt_tx_hang: 1; /* for SNR too low bug, BT has no Tx req*/
 	u32 wl_no_sta_ntfy: 1;
+	u32 w2b_scbd_no_sync: 1;
 
 	u32 h2c_bmap_mismatch: 1;
 	u32 c2h_bmap_mismatch: 1;
@@ -2784,6 +2788,26 @@ struct rtw89_btc_fbtc_rpt_ctrl_v8 {
 	struct rtw89_btc_fbtc_rpt_ctrl_bt_mailbox bt_mbx_info;
 } __packed;
 
+struct rtw89_btc_fbtc_rpt_ctrl_v11 {
+	u8 fver;
+	u8 rsvd0;
+	u8 rpt_len_max_l; /* BTC_RPT_MAX bit0~7 */
+	u8 rpt_len_max_h; /* BTC_RPT_MAX bit8~15 */
+
+	u8 build_time[12];
+	u8 build_date[12];
+
+	u8 gnt_val[RTW89_PHY_NUM][8]; /* gwl/gbt012 refer to struct btc_gnt_ctrl */
+	__le16 bt_cnt[BTC_ALL_BT_EZL][BTC_BCNT_STA_MAX_V105];
+
+	struct rtw89_btc_fbtc_rpt_ctrl_info_v8 rpt_info;
+	struct rtw89_btc_fbtc_rpt_ctrl_bt_mailbox bt_mbx_info;
+
+	__le32 error_code;
+	__le32 scbd_w2b[2];
+	__le32 scbd_b2w[2];
+} __packed;
+
 union rtw89_btc_fbtc_rpt_ctrl_ver_info {
 	struct rtw89_btc_fbtc_rpt_ctrl_v1 v1;
 	struct rtw89_btc_fbtc_rpt_ctrl_v4 v4;
@@ -2791,6 +2815,7 @@ union rtw89_btc_fbtc_rpt_ctrl_ver_info {
 	struct rtw89_btc_fbtc_rpt_ctrl_v105 v105;
 	struct rtw89_btc_fbtc_rpt_ctrl_v7 v7;
 	struct rtw89_btc_fbtc_rpt_ctrl_v8 v8;
+	struct rtw89_btc_fbtc_rpt_ctrl_v11 v11;
 };
 
 enum rtw89_fbtc_ext_ctrl_type {
@@ -3691,6 +3716,7 @@ struct rtw89_btc_dm {
 	u8 lps_ctrl_change: 1;
 	u8 scbd_write_instant;
 	bool scbd_b2w_update;
+	bool scbd_w2b_update;
 	bool pre_agc_chg;
 };
 
-- 
2.25.1


