Return-Path: <linux-wireless+bounces-4233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E67386C2CC
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 08:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14EC1F21225
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 07:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0311B4EB3A;
	Thu, 29 Feb 2024 07:46:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869143BBFB
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192795; cv=none; b=UebBQX04gJ0PitpykPokdNGG/XtCcNaIl416hqgNdiJfavHiltUwitw39G1ybsLMeLmajNu0/4LJFlBr/q3nyCq8XeuFtdImbGm7z3Hg+rmlcitsx6433WnCmdHOn0k5TPfUkkePJfsmVm8+IvZakxA4ALpRyO9VnUkXOBvIa1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192795; c=relaxed/simple;
	bh=HaZuQixhSSI+4QyeQw58X+kFxoq7VLEsfjyBkxEyiSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVg7kAe3sVlOeJiU1V1XFjHL/ZdAkPaRPOxl7Q3E9JyTafWZXziNQA1ZSQhBa9nNLSmaJcPI0+NZ/SSo7ONeTZ1FSvQQPz6rG/zJ0awMtk4I/vC96r03RMQjPRt84pBdoCqa/SB48x+K5LY5oDqrCcKfJmMXm1LHhQXDyUVuLoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41T7kPhvD1229774, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41T7kPhvD1229774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 15:46:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 29 Feb 2024 15:46:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 15:46:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/8] wifi: rtw89: coex: add BTC ctrl_info version 7 and related logic
Date: Thu, 29 Feb 2024 15:45:10 +0800
Message-ID: <20240229074514.219276-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240229074514.219276-1-pkshih@realtek.com>
References: <20240229074514.219276-1-pkshih@realtek.com>
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

Change structure member from bit field to normal variable to
reduce unnecessary translation.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c  | 90 ++++++++++++++++------
 drivers/net/wireless/realtek/rtw89/core.h  | 15 +++-
 drivers/net/wireless/realtek/rtw89/debug.c |  9 ++-
 drivers/net/wireless/realtek/rtw89/fw.c    | 44 ++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h    | 15 +++-
 5 files changed, 142 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 3ce4ce144b9e..ee658d3bea78 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -718,6 +718,7 @@ static void _send_fw_cmd(struct rtw89_dev *rtwdev, u8 h2c_class, u8 h2c_func,
 static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
@@ -735,7 +736,9 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 
 	if (type & BTC_RESET_CTRL) {
 		memset(&btc->ctrl, 0, sizeof(btc->ctrl));
-		btc->ctrl.trace_step = FCXDEF_STEP;
+		btc->manual_ctrl = false;
+		if (ver->fcxctrl != 7)
+			btc->ctrl.ctrl.trace_step = FCXDEF_STEP;
 	}
 
 	/* Init Coex variables that are not zero */
@@ -1129,7 +1132,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	void *rpt_content = NULL, *pfinfo = NULL;
 	u8 rpt_type = 0;
 	u16 wl_slot_set = 0, wl_slot_real = 0;
-	u32 trace_step = btc->ctrl.trace_step, rpt_len = 0, diff_t = 0;
+	u32 trace_step = 0, rpt_len = 0, diff_t = 0;
 	u32 cnt_leak_slot, bt_slot_real, bt_slot_set, cnt_rx_imr;
 	u8 i, val = 0;
 
@@ -1219,6 +1222,9 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_STEP:
 		pcinfo = &pfwinfo->rpt_fbtc_step.cinfo;
+		if (ver->fcxctrl != 7)
+			trace_step = btc->ctrl.ctrl.trace_step;
+
 		if (ver->fcxstep == 2) {
 			pfinfo = &pfwinfo->rpt_fbtc_step.finfo.v2;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_step.finfo.v2.step[0]) *
@@ -2109,7 +2115,10 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 type)
 			rtw89_fw_h2c_cxdrv_role_v2(rtwdev);
 		break;
 	case CXDRVINFO_CTRL:
-		rtw89_fw_h2c_cxdrv_ctrl(rtwdev);
+		if (ver->fcxctrl == 7)
+			rtw89_fw_h2c_cxdrv_ctrl_v7(rtwdev);
+		else
+			rtw89_fw_h2c_cxdrv_ctrl(rtwdev);
 		break;
 	case CXDRVINFO_TRX:
 		dm->trx_info.tx_power = u32_get_bits(rf_para.wl_tx_power,
@@ -2450,7 +2459,7 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 	u8 en = 0, i, ch = 0, bw = 0;
 	u8 mode, connect_cnt;
 
-	if (btc->ctrl.manual || wl->status.map.scan)
+	if (btc->manual_ctrl || wl->status.map.scan)
 		return;
 
 	if (ver->fwlrole == 0) {
@@ -4014,7 +4023,7 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 	u32 is_btg;
 	u8 i, val;
 
-	if (btc->ctrl.manual)
+	if (btc->manual_ctrl)
 		return;
 
 	if (ver->fwlrole == 0)
@@ -4086,7 +4095,7 @@ static void _set_wl_preagc_ctrl(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_dm *dm = &btc->dm;
 	u8 is_preagc, val;
 
-	if (btc->ctrl.manual)
+	if (btc->manual_ctrl)
 		return;
 
 	if (wl_rinfo->link_mode == BTC_WLINK_25G_MCC)
@@ -4210,13 +4219,12 @@ static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
 	struct rtw89_txtime_data data = {.rtwdev = rtwdev};
-	u8 mode;
-	u8 tx_retry;
+	u8 mode, igno_bt, tx_retry;
 	u32 tx_time;
 	u16 enable;
 	bool reenable = false;
 
-	if (btc->ctrl.manual)
+	if (btc->manual_ctrl)
 		return;
 
 	if (ver->fwlrole == 0)
@@ -4228,7 +4236,12 @@ static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 	else
 		return;
 
-	if (btc->dm.freerun || btc->ctrl.igno_bt || b->profile_cnt.now == 0 ||
+	if (ver->fcxctrl == 7)
+		igno_bt = btc->ctrl.ctrl_v7.igno_bt;
+	else
+		igno_bt = btc->ctrl.ctrl.igno_bt;
+
+	if (btc->dm.freerun || igno_bt || b->profile_cnt.now == 0 ||
 	    mode == BTC_WLINK_5G || mode == BTC_WLINK_NOLINK) {
 		enable = 0;
 		tx_time = BTC_MAX_TX_TIME_DEF;
@@ -5374,7 +5387,7 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
-	u8 mode;
+	u8 mode, igno_bt, always_freerun;
 
 	lockdep_assert_held(&rtwdev->mutex);
 
@@ -5391,20 +5404,28 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	else
 		return;
 
+	if (ver->fcxctrl == 7) {
+		igno_bt = btc->ctrl.ctrl_v7.igno_bt;
+		always_freerun = btc->ctrl.ctrl_v7.always_freerun;
+	} else {
+		igno_bt = btc->ctrl.ctrl.igno_bt;
+		always_freerun = btc->ctrl.ctrl.always_freerun;
+	}
+
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): reason=%d, mode=%d\n",
 		    __func__, reason, mode);
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): wl_only=%d, bt_only=%d\n",
 		    __func__, dm->wl_only, dm->bt_only);
 
 	/* Be careful to change the following function sequence!! */
-	if (btc->ctrl.manual) {
+	if (btc->manual_ctrl) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): return for Manual CTRL!!\n",
 			    __func__);
 		return;
 	}
 
-	if (btc->ctrl.igno_bt &&
+	if (igno_bt &&
 	    (reason == BTC_RSN_UPDATE_BT_INFO ||
 	     reason == BTC_RSN_UPDATE_BT_SCBD)) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -5441,24 +5462,24 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	dm->freerun = false;
 	dm->cnt_dm[BTC_DCNT_RUN]++;
 	dm->fddt_train = BTC_FDDT_DISABLE;
-	btc->ctrl.igno_bt = false;
 	bt->scan_rx_low_pri = false;
+	igno_bt = false;
 
-	if (btc->ctrl.always_freerun) {
+	if (always_freerun) {
 		_action_freerun(rtwdev);
-		btc->ctrl.igno_bt = true;
+		igno_bt = true;
 		goto exit;
 	}
 
 	if (dm->wl_only) {
 		_action_wl_only(rtwdev);
-		btc->ctrl.igno_bt = true;
+		igno_bt = true;
 		goto exit;
 	}
 
 	if (wl->status.map.rf_off || wl->status.map.lps || dm->bt_only) {
 		_action_wl_off(rtwdev, mode);
-		btc->ctrl.igno_bt = true;
+		igno_bt = true;
 		goto exit;
 	}
 
@@ -5548,6 +5569,10 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 
 exit:
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): exit\n", __func__);
+	if (ver->fcxctrl == 7)
+		btc->ctrl.ctrl_v7.igno_bt = igno_bt;
+	else
+		btc->ctrl.ctrl.igno_bt = igno_bt;
 	_action_common(rtwdev);
 }
 
@@ -5611,11 +5636,15 @@ void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode)
 	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_btc_ver *ver = btc->ver;
 
 	_reset_btc_var(rtwdev, BTC_RESET_ALL);
 	btc->dm.run_reason = BTC_RSN_NONE;
 	btc->dm.run_action = BTC_ACT_NONE;
-	btc->ctrl.igno_bt = true;
+	if (ver->fcxctrl == 7)
+		btc->ctrl.ctrl_v7.igno_bt = true;
+	else
+		btc->ctrl.ctrl.igno_bt = true;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): mode=%d\n", __func__, mode);
@@ -7178,15 +7207,17 @@ static void _show_dm_step(struct rtw89_dev *rtwdev, struct seq_file *m)
 static void _show_dm_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	u8 igno_bt;
 
 	if (!(dm->coex_info_map & BTC_COEX_INFO_DM))
 		return;
 
 	seq_printf(m, "========== [Mechanism Status %s] ==========\n",
-		   (btc->ctrl.manual ? "(Manual)" : "(Auto)"));
+		   (btc->manual_ctrl ? "(Manual)" : "(Auto)"));
 
 	seq_printf(m,
 		   " %-15s : type:%s, reason:%s(), action:%s(), ant_path:%s, init_mode:%s, run_cnt:%d\n",
@@ -7200,8 +7231,13 @@ static void _show_dm_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 	_show_dm_step(rtwdev, m);
 
+	if (ver->fcxctrl == 7)
+		igno_bt = btc->ctrl.ctrl_v7.igno_bt;
+	else
+		igno_bt = btc->ctrl.ctrl.igno_bt;
+
 	seq_printf(m, " %-15s : wl_only:%d, bt_only:%d, igno_bt:%d, free_run:%d, wl_ps_ctrl:%d, wl_mimo_ps:%d, ",
-		   "[dm_flag]", dm->wl_only, dm->bt_only, btc->ctrl.igno_bt,
+		   "[dm_flag]", dm->wl_only, dm->bt_only, igno_bt,
 		   dm->freerun, btc->lps, dm->wl_mimo_ps);
 
 	seq_printf(m, "leak_ap:%d, fw_offload:%s%s\n", dm->leak_ap,
@@ -7942,10 +7978,11 @@ static void _show_fbtc_step_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_fbtc_steps_v2 *pstep = NULL;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	u8 type, val, cnt = 0, state = 0;
 	bool outloop = false;
 	u16 i, diff_t, n_start = 0, n_stop = 0;
-	u16 pos_old, pos_new;
+	u16 pos_old, pos_new, trace_step;
 
 	pcinfo = &pfwinfo->rpt_fbtc_step.cinfo;
 	if (!pcinfo->valid)
@@ -7962,11 +7999,16 @@ static void _show_fbtc_step_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 	do {
 		switch (state) {
 		case 0:
+			if (ver->fcxctrl == 7 || ver->fcxctrl == 1)
+				trace_step = 50;
+			else
+				trace_step = btc->ctrl.ctrl.trace_step;
+
 			n_start = pos_old;
 			if (pos_new >=  pos_old)
 				n_stop = pos_new;
 			else
-				n_stop = btc->ctrl.trace_step - 1;
+				n_stop = trace_step - 1;
 
 			state = 1;
 			break;
@@ -8796,7 +8838,7 @@ void rtw89_btc_dump_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	seq_printf(m, "WL FW / BT FW		%d.%d.%d.%d / NA\n",
 		   fw_suit->major_ver, fw_suit->minor_ver,
 		   fw_suit->sub_ver, fw_suit->sub_idex);
-	seq_printf(m, "manual			%d\n", btc->ctrl.manual);
+	seq_printf(m, "manual			%d\n", btc->manual_ctrl);
 
 	seq_puts(m, "=========================================\n");
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4ecca3e51697..91a8f62dc70a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2605,6 +2605,18 @@ struct rtw89_btc_ctrl {
 	u32 rsvd: 12;
 };
 
+struct rtw89_btc_ctrl_v7 {
+	u8 manual;
+	u8 igno_bt;
+	u8 always_freerun;
+	u8 rsvd;
+} __packed;
+
+union rtw89_btc_ctrl_list {
+	struct rtw89_btc_ctrl ctrl;
+	struct rtw89_btc_ctrl_v7 ctrl_v7;
+};
+
 struct rtw89_btc_dbg {
 	/* cmd "rb" */
 	bool rb_done;
@@ -2790,7 +2802,7 @@ struct rtw89_btc {
 
 	struct rtw89_btc_cx cx;
 	struct rtw89_btc_dm dm;
-	struct rtw89_btc_ctrl ctrl;
+	union rtw89_btc_ctrl_list ctrl;
 	union rtw89_btc_module_info mdinfo;
 	struct rtw89_btc_btf_fwinfo fwinfo;
 	struct rtw89_btc_dbg dbg;
@@ -2810,6 +2822,7 @@ struct rtw89_btc {
 	bool bt_req_en;
 	bool update_policy_force;
 	bool lps;
+	bool manual_ctrl;
 };
 
 enum rtw89_btc_hmsg {
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 44829a148185..affffc4092ba 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3427,14 +3427,17 @@ static ssize_t rtw89_debug_priv_btc_manual_set(struct file *filp,
 	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_btc *btc = &rtwdev->btc;
-	bool btc_manual;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	int ret;
 
-	ret = kstrtobool_from_user(user_buf, count, &btc_manual);
+	ret = kstrtobool_from_user(user_buf, count, &btc->manual_ctrl);
 	if (ret)
 		return ret;
 
-	btc->ctrl.manual = btc_manual;
+	if (ver->fcxctrl == 7)
+		btc->ctrl.ctrl_v7.manual = btc->manual_ctrl;
+	else
+		btc->ctrl.ctrl.manual = btc->manual_ctrl;
 
 	return count;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index b56ecd410907..4c607c8b4d15 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3839,7 +3839,8 @@ int rtw89_fw_h2c_cxdrv_init_v7(struct rtw89_dev *rtwdev)
 	h2c = (struct rtw89_h2c_cxinit_v7 *)skb->data;
 
 	h2c->hdr.type = CXDRVINFO_INIT;
-	h2c->hdr.len = len - H2C_LEN_CXDRVHDR;
+	h2c->hdr.ver = btc->ver->fcxinit;
+	h2c->hdr.len = len - H2C_LEN_CXDRVHDR_V7;
 	h2c->init = *init_info;
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
@@ -4124,7 +4125,7 @@ int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
-	struct rtw89_btc_ctrl *ctrl = &btc->ctrl;
+	struct rtw89_btc_ctrl *ctrl = &btc->ctrl.ctrl;
 	struct sk_buff *skb;
 	u8 *cmd;
 	int ret;
@@ -4164,6 +4165,45 @@ int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
+int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_ctrl_v7 *ctrl = &btc->ctrl.ctrl_v7;
+	struct rtw89_h2c_cxctrl_v7 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_ctrl\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cxctrl_v7 *)skb->data;
+
+	h2c->hdr.type = CXDRVINFO_INIT;
+	h2c->hdr.ver = btc->ver->fcxctrl;
+	h2c->hdr.len = sizeof(*h2c) - H2C_LEN_CXDRVHDR_V7;
+	h2c->ctrl = *ctrl;
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, BTFC_SET,
+			      SET_DRV_INFO, 0, 0, len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 #define H2C_LEN_CXDRVINFO_TRX (28 + H2C_LEN_CXDRVHDR)
 int rtw89_fw_h2c_cxdrv_trx(struct rtw89_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 3533b84717d2..51087fa3bc0d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2366,7 +2366,19 @@ struct rtw89_h2c_cxhdr {
 	u8 len;
 } __packed;
 
+struct rtw89_h2c_cxhdr_v7 {
+	u8 type;
+	u8 ver;
+	u8 len;
+} __packed;
+
+struct rtw89_h2c_cxctrl_v7 {
+	struct rtw89_h2c_cxhdr_v7 hdr;
+	struct rtw89_btc_ctrl_v7 ctrl;
+} __packed;
+
 #define H2C_LEN_CXDRVHDR sizeof(struct rtw89_h2c_cxhdr)
+#define H2C_LEN_CXDRVHDR_V7 sizeof(struct rtw89_h2c_cxhdr_v7)
 
 struct rtw89_h2c_cxinit {
 	struct rtw89_h2c_cxhdr hdr;
@@ -2401,7 +2413,7 @@ struct rtw89_h2c_cxinit {
 #define RTW89_H2C_CXINIT_INFO_BT_ONLY BIT(4)
 
 struct rtw89_h2c_cxinit_v7 {
-	struct rtw89_h2c_cxhdr hdr;
+	struct rtw89_h2c_cxhdr_v7 hdr;
 	struct rtw89_btc_init_info_v7 init;
 } __packed;
 
@@ -4542,6 +4554,7 @@ int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev);
+int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_trx(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_del_pkt_offload(struct rtw89_dev *rtwdev, u8 id);
-- 
2.25.1


