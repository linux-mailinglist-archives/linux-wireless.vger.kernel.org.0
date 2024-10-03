Return-Path: <linux-wireless+bounces-13455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5887F98ED5C
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 12:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5391F231CB
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 10:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39D114F9F8;
	Thu,  3 Oct 2024 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LpLKAmRH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED55D15099D
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952760; cv=none; b=kVYNF1XLZ2sE81yCx00v99nmCxA+fnzW+J7I3jRE2r/W6/d6QOls6nlNgdHAt/jydV1gBIckL9TaPDfcP1dWwn9KAOUuYM+y96QhifNTBDsk3YdCCBsdXB1zfoSRaH/xw1+28n1QrPV8qLZC0AvR3hH4aCKYYDgSXi1dezcaC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952760; c=relaxed/simple;
	bh=DrViOAaAU81sEv/+MPokUzYBx/Ofp6YQ4P6gD38waSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKnoO+VjxAf9M2yVXizRnPR1bvxpFVQDPTlA2f9EeGCDdqoBUC8JinlvNHtpxZrMcaK7A8kk9Qb5PU7bnzRMSCTJk8ND5aPIgdxILoMssxDYQZvewT5I1UZ8reIw4/4xDSvXJM9gP2TcRCYVEpX2Yht9VDKSvFBldZGW5b+giuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LpLKAmRH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 493AqZbL53828694, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727952755; bh=DrViOAaAU81sEv/+MPokUzYBx/Ofp6YQ4P6gD38waSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=LpLKAmRH1sLT3FKyqwlPzDtpxmjNdEjDhy+T6GcmcgdGntyhpxa29mQxCiz7equq8
	 eyVkoOEUspVgOB0j/QnPs6IrswRUwhdC8sYwnGFsXhz3RESYNLZAoFo4+Ai5sFLeSB
	 I7z8oD1+GRwff9XtZk3Zv/+0G0w59pHSYeRXVlYI8uuLcjRn/KcRXRzRe8O5EIfxge
	 3pa/QoXWwC+8OpLgR0zyNVk1/xoGUXsCwRHyG9ENmFJKiA0w7LhBnGdvUq2BuUTAPi
	 cAe0j21Ai/HzEtwDYHbAg+VdLV1tNoS/1act/dKBCyvpcF9PgMLM9JItPDlx9ybvIT
	 Gq//cd/DeEXZA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 493AqZbL53828694
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 3 Oct 2024 18:52:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 18:52:35 +0800
Received: from [127.0.1.1] (172.16.22.72) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 3 Oct
 2024 18:52:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 1/4] wifi: rtw89: coex: Update priority setting for Wi-Fi is scanning
Date: Thu, 3 Oct 2024 18:51:37 +0800
Message-ID: <20241003105140.10867-2-pkshih@realtek.com>
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

Update coexistence priority setting for Wi-Fi scanning channel, the new
setting will allow Wi-Fi do RX while Bluetooth audio is not busy. Forced
to set new TDMA policy while RF calibration request come, to make sure
the calibration can do well, and switch to normal setting while the
calibration is done. Remove the code that no longer use.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 58 +++++++++++++----------
 drivers/net/wireless/realtek/rtw89/core.h |  1 -
 2 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 6da1193422fb..9cd036112a48 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -125,6 +125,9 @@ static const u32 cxtbl[] = {
 	0xfafaaafa, /* 23 */
 	0xfafffaff, /* 24 */
 	0xea6a5a5a, /* 25 */
+	0xfaff5aff, /* 26 */
+	0xffffdfff, /* 27 */
+	0xe6555555, /* 28 */
 };
 
 static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
@@ -224,7 +227,7 @@ static const union rtw89_btc_wl_state_map btc_scanning_map = {
 		.scan = 1,
 		.connecting = 1,
 		.roaming = 1,
-		.transacting = 1,
+		.dbccing = 1,
 		._4way = 1,
 	},
 };
@@ -3017,7 +3020,7 @@ static void _update_btc_state_map(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 
 	if (wl->status.map.connecting || wl->status.map._4way ||
-	    wl->status.map.roaming) {
+	    wl->status.map.roaming || wl->status.map.dbccing) {
 		cx->state_map = BTC_WLINKING;
 	} else if (wl->status.map.scan) { /* wl scan */
 		if (bt_linfo->status.map.inq_pag)
@@ -3721,8 +3724,6 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 			tbl_w1 = cxtbl[16];
 	}
 
-	btc->bt_req_en = false;
-
 	switch (type) {
 	case BTC_CXP_USERDEF0:
 		btc->update_policy_force = true;
@@ -3744,6 +3745,10 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		case BTC_CXP_OFF_WL:
 			_slot_set_tbl(btc, CXST_OFF, cxtbl[1]);
 			break;
+		case BTC_CXP_OFF_WL2:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[1]);
+			_slot_set_type(btc, CXST_OFF, SLOT_ISO);
+			break;
 		case BTC_CXP_OFF_EQ0:
 			_slot_set_tbl(btc, CXST_OFF, cxtbl[0]);
 			_slot_set_type(btc, CXST_OFF, SLOT_ISO);
@@ -3757,6 +3762,12 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		case BTC_CXP_OFF_EQ3:
 			_slot_set_tbl(btc, CXST_OFF, cxtbl[24]);
 			break;
+		case BTC_CXP_OFF_EQ4:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[26]);
+			break;
+		case BTC_CXP_OFF_EQ5:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[27]);
+			break;
 		case BTC_CXP_OFF_BWB0:
 			_slot_set_tbl(btc, CXST_OFF, cxtbl[5]);
 			break;
@@ -3788,7 +3799,6 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		}
 		break;
 	case BTC_CXP_OFFE: /* TDMA off + beacon protect + Ext_control */
-		btc->bt_req_en = true;
 		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
 		*t = t_def[CXTD_OFF_EXT];
 
@@ -3831,9 +3841,9 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 				     s_def[CXST_ENULL].cxtbl, s_def[CXST_ENULL].cxtype);
 			break;
 		case BTC_CXP_OFFE_2GBWMIXB:
-			_slot_set(btc, CXST_E2G, 0, 0x55555555, SLOT_MIX);
+			_slot_set(btc, CXST_E2G, 0, 0xea5a5555, SLOT_MIX);
 			_slot_set_le(btc, CXST_EBT, s_def[CXST_EBT].dur,
-				     cpu_to_le32(0x55555555), s_def[CXST_EBT].cxtype);
+				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
 			break;
 		case BTC_CXP_OFFE_WL: /* for 4-way */
 			_slot_set(btc, CXST_E2G, 0, cxtbl[1], SLOT_MIX);
@@ -3842,6 +3852,8 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		default:
 			break;
 		}
+		_slot_set_le(btc, CXST_E5G, s_def[CXST_E5G].dur,
+			     s_def[CXST_E5G].cxtbl, s_def[CXST_E5G].cxtype);
 		_slot_set_le(btc, CXST_OFF, s_def[CXST_OFF].dur,
 			     s_def[CXST_OFF].cxtbl, s_def[CXST_OFF].cxtype);
 		break;
@@ -4246,6 +4258,7 @@ static void _set_ant_v0(struct rtw89_dev *rtwdev, bool force_exec,
 		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_NONE, BTC_PLT_NONE);
 		break;
 	case BTC_ANT_WRFK:
+	case BTC_ANT_WRFK2:
 		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
 		_set_gnt(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO);
 		_set_bt_plut(rtwdev, phy_map, BTC_PLT_NONE, BTC_PLT_NONE);
@@ -4814,8 +4827,16 @@ static void _action_wl_rfk(struct rtw89_dev *rtwdev)
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): band = %d\n",
 		    __func__, rfk.band);
 
-	_set_ant(rtwdev, FC_EXEC, BTC_PHY_ALL, BTC_ANT_WRFK);
-	_set_policy(rtwdev, BTC_CXP_OFF_WL, BTC_ACT_WL_RFK);
+	btc->dm.tdma_instant_excute = 1;
+
+	if (rfk.state == BTC_WRFK_ONESHOT_START ||
+	    btc->ant_type == BTC_ANT_SHARED) {
+		_set_ant(rtwdev, FC_EXEC, BTC_PHY_ALL, BTC_ANT_WRFK2);
+		_set_policy(rtwdev, BTC_CXP_OFF_WL2, BTC_ACT_WL_RFK);
+	} else {
+		_set_ant(rtwdev, FC_EXEC, BTC_PHY_ALL, BTC_ANT_WRFK);
+		_set_policy(rtwdev, BTC_CXP_OFF_WL, BTC_ACT_WL_RFK);
+	}
 }
 
 static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
@@ -5334,7 +5355,7 @@ static void _action_wl_25g_mcc(struct rtw89_dev *rtwdev)
 			policy_type = BTC_CXP_OFFE_WL;
 		else if (btc->cx.wl.status.val & btc_scanning_map.val)
 			policy_type = BTC_CXP_OFFE_2GBWMIXB;
-		else if (btc->cx.bt.link_info.profile_cnt.now == 0)
+		else if (btc->cx.bt.link_info.status.map.connect == 0)
 			policy_type = BTC_CXP_OFFE_2GISOB;
 		else
 			policy_type = BTC_CXP_OFFE_2GBWISOB;
@@ -6944,18 +6965,9 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 		goto exit;
 	}
 
-	if (cx->state_map == BTC_WLINKING) {
-		if (mode == BTC_WLINK_NOLINK || mode == BTC_WLINK_2G_STA ||
-		    mode == BTC_WLINK_5G) {
-			_action_wl_scan(rtwdev);
-			bt->scan_rx_low_pri = false;
-			goto exit;
-		}
-	}
-
-	if (wl->status.map.scan) {
+	if (wl->status.val & btc_scanning_map.val) {
 		_action_wl_scan(rtwdev);
-		bt->scan_rx_low_pri = false;
+		bt->scan_rx_low_pri = true;
 		goto exit;
 	}
 
@@ -7191,10 +7203,6 @@ void rtw89_btc_ntfy_switch_band(struct rtw89_dev *rtwdev, u8 phy_idx, u8 band)
 
 	btc->dm.cnt_notify[BTC_NCNT_SWITCH_BAND]++;
 
-	wl->scan_info.band[phy_idx] = band;
-	wl->scan_info.phy_map |= BIT(phy_idx);
-	_fw_set_drv_info(rtwdev, CXDRVINFO_SCAN);
-
 	if (rtwdev->dbcc_en) {
 		wl->dbcc_info.scan_band[phy_idx] = band;
 		_update_dbcc_band(rtwdev, phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 598eee12339e..c9bbd7720abc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1352,7 +1352,6 @@ struct rtw89_btc_wl_smap {
 	u32 connecting: 1;
 	u32 roaming: 1;
 	u32 dbccing: 1;
-	u32 transacting: 1;
 	u32 _4way: 1;
 	u32 rf_off: 1;
 	u32 lps: 2;
-- 
2.25.1


