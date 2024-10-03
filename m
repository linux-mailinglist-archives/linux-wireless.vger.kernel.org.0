Return-Path: <linux-wireless+bounces-13456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBD498ED5D
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 12:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0416B219A5
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 10:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2965815099D;
	Thu,  3 Oct 2024 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bm7F722l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560131537C9
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952765; cv=none; b=M4BV8OIBIFxzurkvLk6a6cfwLs588XJYGC2vN4FBzmIjbMslixeKnv01qxMAhKLWQtNQatnSl7t54hQlI+lNd8xnRA9yTrMfDfU01W63QdgnntF59j+zt9WDLZU+mnrNhCwCzOoiyS/cLy909+lYFQd6zhlsSWWBr7KkXdxAKDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952765; c=relaxed/simple;
	bh=OgL9Q79vnG5tXUk48WA2zofT9MU0PwNbyLny5bDyZqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hENIFaX//bgwXvdwzGzIoWzkJ65mtLv6dXUvTWJxEM/I79+uWn6xBxpTzUhvuxlUiGEie56ZkiKcrkjQ9zfN32uzXj8uQU3VGm6KucSajkLrTDtVn7i9nEhmSYiRJQ7xNGBU9UJJojoFxQ86xbb2epl6FGvRufcb9JtAHUk6+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bm7F722l; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 493AqdDfB3828697, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727952759; bh=OgL9Q79vnG5tXUk48WA2zofT9MU0PwNbyLny5bDyZqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bm7F722lQu9mpowJqcfP0ihlU+oNLpJozUKGXyNPp0C+hAw0NlNWWeb9iVddPJDA7
	 B0qX+IbmVnHKdR5Yfwd66QXyplfOpN6dEIWoDm0X9bRkspb/I+V77EvHXC7/c807JL
	 /haFaimgn6YOr7oeyVAmpu+QxfgP/TEGJuXfAES+jbpNbsE7PrH7m/8VQix+ANIcUQ
	 0s8hMelgHayAu8qMTMiRaFMFpscx44DESxRmB3hYAhyuTqU5Uy955UaA1klfTZ0HxE
	 Z3wRoSPSEMZauZUUTFSyCuF18rmE7Fllit7su8IveMUuJgmwqPEXBXb3q4jBYoZFgj
	 JULc9ss+ptM0g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 493AqdDfB3828697
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 3 Oct 2024 18:52:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 18:52:39 +0800
Received: from [127.0.1.1] (172.16.22.72) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 3 Oct
 2024 18:52:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 2/4] wifi: rtw89: coex: Reorder Bluetooth info related logic
Date: Thu, 3 Oct 2024 18:51:38 +0800
Message-ID: <20241003105140.10867-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003105140.10867-1-pkshih@realtek.com>
References: <20241003105140.10867-1-pkshih@realtek.com>
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

Reorder Bluetooth firmware related event index, it should be the same
with Wi-Fi firmware definition. To fix coexistence can not recognize
Bluetooth PAN(Personal area network) profile correctly, modified the
related logic.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 74 +++++++++++++----------
 drivers/net/wireless/realtek/rtw89/core.h |  2 +
 2 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 9cd036112a48..1c0169e2927e 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5267,8 +5267,14 @@ static void _action_by_bt(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_bt_hid_desc hid = bt_linfo->hid_desc;
 	struct rtw89_btc_bt_a2dp_desc a2dp = bt_linfo->a2dp_desc;
 	struct rtw89_btc_bt_pan_desc pan = bt_linfo->pan_desc;
+	struct rtw89_btc_dm *dm = &btc->dm;
 	u8 profile_map = 0;
 
+	if (dm->freerun_chk) {
+		_action_freerun(rtwdev);
+		return;
+	}
+
 	if (bt_linfo->hfp_desc.exist)
 		profile_map |= BTC_BT_HFP;
 
@@ -5283,30 +5289,20 @@ static void _action_by_bt(struct rtw89_dev *rtwdev)
 
 	switch (profile_map) {
 	case BTC_BT_NOPROFILE:
-		if (_check_freerun(rtwdev))
-			_action_freerun(rtwdev);
-		else if (pan.active)
+		if (pan.active)
 			_action_bt_pan(rtwdev);
 		else
 			_action_bt_idle(rtwdev);
 		break;
 	case BTC_BT_HFP:
-		if (_check_freerun(rtwdev))
-			_action_freerun(rtwdev);
-		else
-			_action_bt_hfp(rtwdev);
+		_action_bt_hfp(rtwdev);
 		break;
 	case BTC_BT_HFP | BTC_BT_HID:
 	case BTC_BT_HID:
-		if (_check_freerun(rtwdev))
-			_action_freerun(rtwdev);
-		else
-			_action_bt_hid(rtwdev);
+		_action_bt_hid(rtwdev);
 		break;
 	case BTC_BT_A2DP:
-		if (_check_freerun(rtwdev))
-			_action_freerun(rtwdev);
-		else if (a2dp.sink)
+		if (a2dp.sink)
 			_action_bt_a2dpsink(rtwdev);
 		else if (bt_linfo->multi_link.now && !hid.pair_cnt)
 			_action_bt_a2dp_pan(rtwdev);
@@ -5319,13 +5315,18 @@ static void _action_by_bt(struct rtw89_dev *rtwdev)
 	case BTC_BT_A2DP | BTC_BT_HFP:
 	case BTC_BT_A2DP | BTC_BT_HID:
 	case BTC_BT_A2DP | BTC_BT_HFP | BTC_BT_HID:
-		if (_check_freerun(rtwdev))
-			_action_freerun(rtwdev);
+		if (a2dp.sink)
+			_action_bt_a2dpsink(rtwdev);
+		else if (pan.active)
+			_action_bt_a2dp_pan_hid(rtwdev);
 		else
 			_action_bt_a2dp_hid(rtwdev);
 		break;
 	case BTC_BT_A2DP | BTC_BT_PAN:
-		_action_bt_a2dp_pan(rtwdev);
+		if (a2dp.sink)
+			_action_bt_a2dpsink(rtwdev);
+		else
+			_action_bt_a2dp_pan(rtwdev);
 		break;
 	case BTC_BT_PAN | BTC_BT_HFP:
 	case BTC_BT_PAN | BTC_BT_HID:
@@ -5335,7 +5336,10 @@ static void _action_by_bt(struct rtw89_dev *rtwdev)
 	case BTC_BT_A2DP | BTC_BT_PAN | BTC_BT_HID:
 	case BTC_BT_A2DP | BTC_BT_PAN | BTC_BT_HFP:
 	default:
-		_action_bt_a2dp_pan_hid(rtwdev);
+		if (a2dp.sink)
+			_action_bt_a2dpsink(rtwdev);
+		else
+			_action_bt_a2dp_pan_hid(rtwdev);
 		break;
 	}
 }
@@ -6927,6 +6931,8 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	bt->scan_rx_low_pri = false;
 	igno_bt = false;
 
+	dm->freerun_chk = _check_freerun(rtwdev); /* check if meet freerun */
+
 	if (always_freerun) {
 		_action_freerun(rtwdev);
 		igno_bt = true;
@@ -7397,13 +7403,7 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 		    "[BTC], %s(): bt_info[2]=0x%02x\n",
 		    __func__, bt->raw_info[2]);
 
-	/* reset to mo-connect before update */
-	b->status.val = BTC_BLINK_NOCONNECT;
 	b->profile_cnt.last = b->profile_cnt.now;
-	b->relink.last = b->relink.now;
-	a2dp->exist_last = a2dp->exist;
-	b->multi_link.last = b->multi_link.now;
-	bt->inq_pag.last = bt->inq_pag.now;
 	b->profile_cnt.now = 0;
 	hid->type = 0;
 
@@ -7422,7 +7422,8 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	b->profile_cnt.now += (u8)hid->exist;
 	a2dp->exist = btinfo.lb2.a2dp;
 	b->profile_cnt.now += (u8)a2dp->exist;
-	pan->active = btinfo.lb2.pan;
+	pan->exist = btinfo.lb2.pan;
+	b->profile_cnt.now += (u8)pan->exist;
 	btc->dm.trx_info.bt_profile = u32_get_bits(btinfo.val, BT_PROFILE_PROTOCOL_MASK);
 
 	/* parse raw info low-Byte3 */
@@ -7446,8 +7447,14 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	/* parse raw info high-Byte1 */
 	btinfo.val = bt->raw_info[BTC_BTINFO_H1];
 	b->status.map.ble_connect = btinfo.hb1.ble_connect;
-	if (btinfo.hb1.ble_connect)
-		hid->type |= (hid->exist ? BTC_HID_BLE : BTC_HID_RCU);
+	if (btinfo.hb1.ble_connect) {
+		if (hid->exist)
+			hid->type |= BTC_HID_BLE;
+		else if (btinfo.hb1.voice)
+			hid->type |= BTC_HID_RCU_VOICE;
+		else
+			hid->type |= BTC_HID_RCU;
+	}
 
 	cx->cnt_bt[BTC_BCNT_REINIT] += !!(btinfo.hb1.reinit && !bt->reinit);
 	bt->reinit = btinfo.hb1.reinit;
@@ -7459,7 +7466,6 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	if (bt->igno_wl && !cx->wl.status.map.rf_off)
 		_set_bt_ignore_wlan_act(rtwdev, false);
 
-	hid->type |= (btinfo.hb1.voice ? BTC_HID_RCU_VOICE : 0);
 	bt->ble_scan_en = btinfo.hb1.ble_scan;
 
 	cx->cnt_bt[BTC_BCNT_ROLESW] += !!(btinfo.hb1.role_sw && !b->role_sw);
@@ -7469,8 +7475,7 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 
 	/* parse raw info high-Byte2 */
 	btinfo.val = bt->raw_info[BTC_BTINFO_H2];
-	pan->exist = btinfo.hb2.pan_active;
-	b->profile_cnt.now += (u8)pan->exist;
+	pan->active = !!btinfo.hb2.pan_active;
 
 	cx->cnt_bt[BTC_BCNT_AFH] += !!(btinfo.hb2.afh_update && !b->afh_update);
 	b->afh_update = btinfo.hb2.afh_update;
@@ -7478,8 +7483,9 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	b->slave_role = btinfo.hb2.slave;
 	hid->slot_info = btinfo.hb2.hid_slot;
 	hid->pair_cnt = btinfo.hb2.hid_cnt;
-	hid->type |= (hid->slot_info == BTC_HID_218 ?
-		      BTC_HID_218 : BTC_HID_418);
+	if (!b->status.map.ble_connect || hid->pair_cnt > 1)
+		hid->type |= (hid->slot_info == BTC_HID_218 ?
+			      BTC_HID_218 : BTC_HID_418);
 	/* parse raw info high-Byte3 */
 	btinfo.val = bt->raw_info[BTC_BTINFO_H3];
 	a2dp->bitpool = btinfo.hb3.a2dp_bitpool;
@@ -8031,8 +8037,10 @@ void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		return;
 
 	switch (func) {
-	case BTF_EVNT_RPT:
 	case BTF_EVNT_BUF_OVERFLOW:
+		pfwinfo->event[func]++;
+		break;
+	case BTF_EVNT_RPT:
 		pfwinfo->event[func]++;
 		/* Don't need rtw89_leave_ps_mode() */
 		btc_fw_event(rtwdev, func, buf, len);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c9bbd7720abc..96bc3a521e97 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2938,6 +2938,7 @@ struct rtw89_btc_dm {
 
 	u8 wl_pre_agc: 2;
 	u8 wl_lna2: 1;
+	u8 freerun_chk: 1;
 	u8 wl_pre_agc_rb: 2;
 	u8 bt_select: 2; /* 0:s0, 1:s1, 2:s0 & s1, refer to enum btc_bt_index */
 	u8 slot_req_more: 1;
@@ -2976,6 +2977,7 @@ enum rtw89_btc_btf_fw_event {
 	BTF_EVNT_BT_REG = 3,
 	BTF_EVNT_CX_RUNINFO = 4,
 	BTF_EVNT_BT_PSD = 5,
+	BTF_EVNT_BT_DEV_INFO = 6,
 	BTF_EVNT_BUF_OVERFLOW,
 	BTF_EVNT_C2H_LOOPBACK,
 	BTF_EVNT_MAX,
-- 
2.25.1


