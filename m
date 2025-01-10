Return-Path: <linux-wireless+bounces-17271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6CBA08512
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 02:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CED27A0F83
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 01:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AA318C31;
	Fri, 10 Jan 2025 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="M05WxGMu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8436B13F43A
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736474081; cv=none; b=m9HUYthCf+4t9blkJLJLsuHV2U8KomFnXlSQqK/ZfFMZp+8zEqwPvaO1Cd1ORwZfoGANDHd/nIzSEO4WTC4HVUw036mWX6AaOFwEJ3QGgTiRvsu/pgykZRQEZ/iV7Atkj7KW80Ep1CNPM11agnbi05HIplDrfurn6bByGNYvdsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736474081; c=relaxed/simple;
	bh=GoHyOsbVzSsvi8zdmSBJ5lH+LNmA1jxiA6lRiv/Q0tA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/w3vah7WniJFdj9ZOOHLgRZmENigEYVF9titS3rOnZ2tP5FZRQYPmnKRLfODkfLApTH7AaPlUeJNIr5fHev46QYb9qXYWgeTAv6q/G+M5tyKOq6+mzvTL5UCkkWMSxbrSt/+gQ3dGOK4t6IePSNJtLeHy+jD0nznIYdJXWCCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=M05WxGMu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50A1saWaB3982806, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736474076; bh=GoHyOsbVzSsvi8zdmSBJ5lH+LNmA1jxiA6lRiv/Q0tA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=M05WxGMueG42UgquSMKfsXD4Y0pBBIn9XAlxjAEIHTuixhNO2OBdFEHA+CdU/lYII
	 /9axrVbdK2SSrOXXf2puONGYpKMuCcZWKWEERubVl3S/GkiMrnRogt35/pkPmm0MEH
	 9NdroAtyVZQ3zybFaGQ9PB+YswVWQ5QS51mVb64DbO9M28Hv6my9CjQkEbgtsCoAyk
	 WVowWUcKDm6D5UKTeXBDAseSCBAo9aUM7ro6W9TrH+s8GU8d/dnOlXJOq0hPsU05+w
	 dp7IFmDMMyRGyaVn+FZGbkgY7IpeYohOhV/ikG7Msmy0a/A0QLMJFiIm91YWxQXOEy
	 JNxSC9rtmBrnA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50A1saWaB3982806
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 09:54:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 10 Jan 2025 09:54:36 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 10 Jan
 2025 09:54:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 1/3] wifi: rtw89: coex: Add protect to avoid A2DP lag while Wi-Fi connecting
Date: Fri, 10 Jan 2025 09:54:14 +0800
Message-ID: <20250110015416.10704-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110015416.10704-1-pkshih@realtek.com>
References: <20250110015416.10704-1-pkshih@realtek.com>
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

To get a well Wi-Fi RF quality, Wi-Fi need to do RF calibrations. While
Wi-Fi is doing RF calibrations, driver will pause the Bluetooth traffic
to make sure the RF calibration will not be interfered by Bluetooth.
However, if the RF calibrations take too much time, Bluetooth audio
will perform a lag sound. Add a function to make Bluetooth can do
traffic between the individual calibrations to avoid Bluetooth sound
lag. And patch related A2DP coexistence mechanism actions.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     | 90 +++++++++++--------
 drivers/net/wireless/realtek/rtw89/coex.h     |  2 +
 drivers/net/wireless/realtek/rtw89/core.h     |  3 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  6 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  6 ++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  6 ++
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  6 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  6 ++
 8 files changed, 85 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 68316d44b204..d5b8091e7541 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -4589,17 +4589,16 @@ static void _action_bt_a2dp(struct rtw89_dev *rtwdev)
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
+	if (a2dp.vendor_id == 0x4c || dm->leak_ap || bt_linfo->slave_role)
+		dm->slot_dur[CXST_W1] = 20;
+	else
+		dm->slot_dur[CXST_W1] = 40;
+
+	dm->slot_dur[CXST_B1] = BTC_B1_MAX;
+
 	switch (btc->cx.state_map) {
 	case BTC_WBUSY_BNOSCAN: /* wl-busy + bt-A2DP */
-		if (a2dp.vendor_id == 0x4c || dm->leak_ap) {
-			dm->slot_dur[CXST_W1] = 40;
-			dm->slot_dur[CXST_B1] = 200;
-			_set_policy(rtwdev,
-				    BTC_CXP_PAUTO_TDW1B1, BTC_ACT_BT_A2DP);
-		} else {
-			_set_policy(rtwdev,
-				    BTC_CXP_PAUTO_TD50B1, BTC_ACT_BT_A2DP);
-		}
+		_set_policy(rtwdev, BTC_CXP_PAUTO_TDW1B1, BTC_ACT_BT_A2DP);
 		break;
 	case BTC_WBUSY_BSCAN: /* wl-busy + bt-inq + bt-A2DP */
 		_set_policy(rtwdev, BTC_CXP_PAUTO2_TD3050, BTC_ACT_BT_A2DP);
@@ -4609,15 +4608,10 @@ static void _action_bt_a2dp(struct rtw89_dev *rtwdev)
 		break;
 	case BTC_WSCAN_BNOSCAN: /* wl-scan + bt-A2DP */
 	case BTC_WLINKING: /* wl-connecting + bt-A2DP */
-		if (a2dp.vendor_id == 0x4c || dm->leak_ap) {
-			dm->slot_dur[CXST_W1] = 40;
-			dm->slot_dur[CXST_B1] = 200;
-			_set_policy(rtwdev, BTC_CXP_AUTO_TDW1B1,
-				    BTC_ACT_BT_A2DP);
-		} else {
-			_set_policy(rtwdev, BTC_CXP_AUTO_TD50B1,
-				    BTC_ACT_BT_A2DP);
-		}
+		if (btc->cx.wl.rfk_info.con_rfk)
+			_set_policy(rtwdev, BTC_CXP_OFF_BT, BTC_ACT_BT_A2DP);
+		else
+			_set_policy(rtwdev, BTC_CXP_AUTO_TDW1B1, BTC_ACT_BT_A2DP);
 		break;
 	case BTC_WIDLE:  /* wl-idle + bt-A2DP */
 		_set_policy(rtwdev, BTC_CXP_AUTO_TD20B1, BTC_ACT_BT_A2DP);
@@ -4645,7 +4639,10 @@ static void _action_bt_a2dpsink(struct rtw89_dev *rtwdev)
 		_set_policy(rtwdev, BTC_CXP_FIX_TD2060, BTC_ACT_BT_A2DPSINK);
 		break;
 	case BTC_WLINKING: /* wl-connecting + bt-A2dp_Sink */
-		_set_policy(rtwdev, BTC_CXP_FIX_TD3030, BTC_ACT_BT_A2DPSINK);
+		if (btc->cx.wl.rfk_info.con_rfk)
+			_set_policy(rtwdev, BTC_CXP_OFF_BT, BTC_ACT_BT_A2DPSINK);
+		else
+			_set_policy(rtwdev, BTC_CXP_FIX_TD3030, BTC_ACT_BT_A2DPSINK);
 		break;
 	case BTC_WIDLE: /* wl-idle + bt-A2dp_Sink */
 		_set_policy(rtwdev, BTC_CXP_FIX_TD2080, BTC_ACT_BT_A2DPSINK);
@@ -4699,21 +4696,20 @@ static void _action_bt_a2dp_hid(struct rtw89_dev *rtwdev)
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
+	if (a2dp.vendor_id == 0x4c || dm->leak_ap || bt_linfo->slave_role)
+		dm->slot_dur[CXST_W1] = 20;
+	else
+		dm->slot_dur[CXST_W1] = 40;
+
+	dm->slot_dur[CXST_B1] = BTC_B1_MAX;
+
 	switch (btc->cx.state_map) {
 	case BTC_WBUSY_BNOSCAN: /* wl-busy + bt-A2DP+HID */
 	case BTC_WIDLE:  /* wl-idle + bt-A2DP */
-		if (a2dp.vendor_id == 0x4c || dm->leak_ap) {
-			dm->slot_dur[CXST_W1] = 40;
-			dm->slot_dur[CXST_B1] = 200;
-			_set_policy(rtwdev,
-				    BTC_CXP_PAUTO_TDW1B1, BTC_ACT_BT_A2DP_HID);
-		} else {
-			_set_policy(rtwdev,
-				    BTC_CXP_PAUTO_TD50B1, BTC_ACT_BT_A2DP_HID);
-		}
+		_set_policy(rtwdev, BTC_CXP_PAUTO_TDW1B1, BTC_ACT_BT_A2DP_HID);
 		break;
 	case BTC_WBUSY_BSCAN: /* wl-busy + bt-inq + bt-A2DP+HID */
-		_set_policy(rtwdev, BTC_CXP_PAUTO2_TD3050, BTC_ACT_BT_A2DP_HID);
+		_set_policy(rtwdev, BTC_CXP_PAUTO2_TD3070, BTC_ACT_BT_A2DP_HID);
 		break;
 
 	case BTC_WSCAN_BSCAN: /* wl-scan + bt-inq + bt-A2DP+HID */
@@ -4721,15 +4717,10 @@ static void _action_bt_a2dp_hid(struct rtw89_dev *rtwdev)
 		break;
 	case BTC_WSCAN_BNOSCAN: /* wl-scan + bt-A2DP+HID */
 	case BTC_WLINKING: /* wl-connecting + bt-A2DP+HID */
-		if (a2dp.vendor_id == 0x4c || dm->leak_ap) {
-			dm->slot_dur[CXST_W1] = 40;
-			dm->slot_dur[CXST_B1] = 200;
-			_set_policy(rtwdev, BTC_CXP_AUTO_TDW1B1,
-				    BTC_ACT_BT_A2DP_HID);
-		} else {
-			_set_policy(rtwdev, BTC_CXP_AUTO_TD50B1,
-				    BTC_ACT_BT_A2DP_HID);
-		}
+		if (btc->cx.wl.rfk_info.con_rfk)
+			_set_policy(rtwdev, BTC_CXP_OFF_BT, BTC_ACT_BT_A2DP_HID);
+		else
+			_set_policy(rtwdev, BTC_CXP_AUTO_TDW1B1, BTC_ACT_BT_A2DP_HID);
 		break;
 	}
 }
@@ -7002,7 +6993,7 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 		goto exit;
 	}
 
-	if (wl->status.val & btc_scanning_map.val) {
+	if (wl->status.val & btc_scanning_map.val && !wl->rfk_info.con_rfk) {
 		_action_wl_scan(rtwdev);
 		bt->scan_rx_low_pri = true;
 		goto exit;
@@ -11037,3 +11028,24 @@ void rtw89_coex_recognize_ver(struct rtw89_dev *rtwdev)
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC] use version def[%d] = 0x%08x\n",
 		    (int)(btc->ver - rtw89_btc_ver_defs), btc->ver->fw_ver_code);
 }
+
+void rtw89_btc_ntfy_preserve_bt_time(struct rtw89_dev *rtwdev, u32 ms)
+{
+	struct rtw89_btc_bt_link_info *bt_linfo = &rtwdev->btc.cx.bt.link_info;
+	struct rtw89_btc_bt_a2dp_desc a2dp = bt_linfo->a2dp_desc;
+
+	if (test_bit(RTW89_FLAG_SER_HANDLING, rtwdev->flags))
+		return;
+
+	if (!a2dp.exist)
+		return;
+
+	fsleep(ms * 1000);
+}
+EXPORT_SYMBOL(rtw89_btc_ntfy_preserve_bt_time);
+
+void rtw89_btc_ntfy_conn_rfk(struct rtw89_dev *rtwdev, bool state)
+{
+	rtwdev->btc.cx.wl.rfk_info.con_rfk = state;
+}
+EXPORT_SYMBOL(rtw89_btc_ntfy_conn_rfk);
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index dbdb56e063ef..757d03675cf4 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -290,6 +290,8 @@ void rtw89_coex_power_on(struct rtw89_dev *rtwdev);
 void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type);
 void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type);
 void rtw89_coex_recognize_ver(struct rtw89_dev *rtwdev);
+void rtw89_btc_ntfy_preserve_bt_time(struct rtw89_dev *rtwdev, u32 ms);
+void rtw89_btc_ntfy_conn_rfk(struct rtw89_dev *rtwdev, bool state);
 
 static inline u8 rtw89_btc_phymap(struct rtw89_dev *rtwdev,
 				  enum rtw89_phy_idx phy_idx,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 37722a0b6a8b..ce041cc89eec 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1758,7 +1758,8 @@ struct rtw89_btc_wl_rfk_info {
 	u32 phy_map: 2;
 	u32 band: 2;
 	u32 type: 8;
-	u32 rsvd: 14;
+	u32 con_rfk: 1;
+	u32 rsvd: 13;
 
 	u32 start_time;
 	u32 proc_time;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index c56f70267882..0487d1cbe605 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -1596,10 +1596,16 @@ static void rtw8851b_rfk_channel(struct rtw89_dev *rtwdev,
 	enum rtw89_chanctx_idx chanctx_idx = rtwvif_link->chanctx_idx;
 	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
 
+	rtw89_btc_ntfy_conn_rfk(rtwdev, true);
+
 	rtw8851b_rx_dck(rtwdev, phy_idx, chanctx_idx);
 	rtw8851b_iqk(rtwdev, phy_idx, chanctx_idx);
+	rtw89_btc_ntfy_preserve_bt_time(rtwdev, 30);
 	rtw8851b_tssi(rtwdev, phy_idx, true, chanctx_idx);
+	rtw89_btc_ntfy_preserve_bt_time(rtwdev, 30);
 	rtw8851b_dpk(rtwdev, phy_idx, chanctx_idx);
+
+	rtw89_btc_ntfy_conn_rfk(rtwdev, false);
 }
 
 static void rtw8851b_rfk_band_changed(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 9bd2842c27d5..8a9a5201b2ee 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1356,10 +1356,16 @@ static void rtw8852a_rfk_channel(struct rtw89_dev *rtwdev,
 	enum rtw89_chanctx_idx chanctx_idx = rtwvif_link->chanctx_idx;
 	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
 
+	rtw89_btc_ntfy_conn_rfk(rtwdev, true);
+
 	rtw8852a_rx_dck(rtwdev, phy_idx, true, chanctx_idx);
 	rtw8852a_iqk(rtwdev, phy_idx, chanctx_idx);
+	rtw89_btc_ntfy_preserve_bt_time(rtwdev, 30);
 	rtw8852a_tssi(rtwdev, phy_idx, chanctx_idx);
+	rtw89_btc_ntfy_preserve_bt_time(rtwdev, 30);
 	rtw8852a_dpk(rtwdev, phy_idx, chanctx_idx);
+
+	rtw89_btc_ntfy_conn_rfk(rtwdev, false);
 }
 
 static void rtw8852a_rfk_band_changed(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index dfb2bf61b0b8..cbaf54f88af6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -568,10 +568,16 @@ static void rtw8852b_rfk_channel(struct rtw89_dev *rtwdev,
 	enum rtw89_chanctx_idx chanctx_idx = rtwvif_link->chanctx_idx;
 	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
 
+	rtw89_btc_ntfy_conn_rfk(rtwdev, true);
+
 	rtw8852b_rx_dck(rtwdev, phy_idx, chanctx_idx);
 	rtw8852b_iqk(rtwdev, phy_idx, chanctx_idx);
+	rtw89_btc_ntfy_preserve_bt_time(rtwdev, 30);
 	rtw8852b_tssi(rtwdev, phy_idx, true, chanctx_idx);
+	rtw89_btc_ntfy_preserve_bt_time(rtwdev, 30);
 	rtw8852b_dpk(rtwdev, phy_idx, chanctx_idx);
+
+	rtw89_btc_ntfy_conn_rfk(rtwdev, false);
 }
 
 static void rtw8852b_rfk_band_changed(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index bde3e1fb7ca6..c0ae5dca3049 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -541,10 +541,16 @@ static void rtw8852bt_rfk_channel(struct rtw89_dev *rtwdev,
 	enum rtw89_chanctx_idx chanctx_idx = rtwvif_link->chanctx_idx;
 	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
 
+	rtw89_btc_ntfy_conn_rfk(rtwdev, true);
+
 	rtw8852bt_rx_dck(rtwdev, phy_idx, chanctx_idx);
 	rtw8852bt_iqk(rtwdev, phy_idx, chanctx_idx);
+	rtw89_btc_ntfy_preserve_bt_time(rtwdev, 30);
 	rtw8852bt_tssi(rtwdev, phy_idx, true, chanctx_idx);
+	rtw89_btc_ntfy_preserve_bt_time(rtwdev, 30);
 	rtw8852bt_dpk(rtwdev, phy_idx, chanctx_idx);
+
+	rtw89_btc_ntfy_conn_rfk(rtwdev, false);
 }
 
 static void rtw8852bt_rfk_band_changed(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index bc84b15e7826..106df618bb58 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1853,10 +1853,16 @@ static void rtw8852c_rfk_channel(struct rtw89_dev *rtwdev,
 	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
 
 	rtw8852c_mcc_get_ch_info(rtwdev, phy_idx);
+	rtw89_btc_ntfy_conn_rfk(rtwdev, true);
+
 	rtw8852c_rx_dck(rtwdev, phy_idx, false);
 	rtw8852c_iqk(rtwdev, phy_idx, chanctx_idx);
+	rtw89_btc_ntfy_preserve_bt_time(rtwdev, 30);
 	rtw8852c_tssi(rtwdev, phy_idx, chanctx_idx);
+	rtw89_btc_ntfy_preserve_bt_time(rtwdev, 30);
 	rtw8852c_dpk(rtwdev, phy_idx, chanctx_idx);
+
+	rtw89_btc_ntfy_conn_rfk(rtwdev, false);
 	rtw89_fw_h2c_rf_ntfy_mcc(rtwdev);
 }
 
-- 
2.25.1


