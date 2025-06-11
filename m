Return-Path: <linux-wireless+bounces-23953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48644AD47F2
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089333A7137
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 01:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6524128816;
	Wed, 11 Jun 2025 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="BryCWaUm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F978F4E
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605774; cv=none; b=eOcJQPEm/l0EVC4GcFSK90jCvgLWIZB/V0k6Z0HTyHaFHnIH/lUeIhQjdS53JTn0HYpfwDZVI/0MW3Gh44pO36nNfwZCLIUBxt/PYUZabQECwqtdn2hZEysbytsM+aM/GeHTZRTMpIa7dSY02EimgsmI4Jt5Kl2ra2vwqymVemg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605774; c=relaxed/simple;
	bh=SO71hnGnu2avDzWEog3qVBiQaz5Wq2mf1LaMvrBQoNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTIieiZEW81r34bUnWY0rb73XV2/nfE5u1IbSRwVuL8qIy86FeNCueY5hkgKYq1w+0s/DpnqW1OVI2XFCChB8wp/I3Q0cG/nSMwF5smuck4aH+MO+UEnHirbEQ7yBu9v85HH9t/jY1HGzNvnKRNqgFsQcA9NooCvPcYqtNT8Iiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BryCWaUm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B1aBtB53938215, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749605771; bh=RdRfhySIgKZohd2SgN4XXGdTIRb69515bZ5J11feY68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=BryCWaUmzFcrKDhIZ8N5JHnpDC/Ant5Naz+spxY1KHLdNcrmvm+mnnlmBG2TUvoeA
	 4gUEHUbpJ7/Qvj8mE8C0OziYiUHBDTBq0CIqBd+vuEB9dO5PysY9X/XZ1rM5AVS+iG
	 o4NByJnNZKOqSeQ3Vo7VheEAX/op/Pr9yNwCU+2UyFngoBJYmy0hA+M77/VrBTnIFl
	 2B1kMRzlwjzGhXffnC/e7l9/jimgAVsk9UQzGwYNXPeR8GLm4/+Z7N9/UAliJrio5f
	 8b/B42WSawzaofs1p3FOCAWMyu0Z3u4WzzGm11Fd/V+JXHKwXnBEClQqbGH4/1wX9G
	 MulAtVy4sn2pA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B1aBtB53938215
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 09:36:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 09:36:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 11 Jun
 2025 09:36:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 08/10] wifi: rtw89: coex: Update BTG control for WiFi 7
Date: Wed, 11 Jun 2025 09:35:08 +0800
Message-ID: <20250611013510.15519-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611013510.15519-1-pkshih@realtek.com>
References: <20250611013510.15519-1-pkshih@realtek.com>
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

BTG means a path work for Bluetooth & Wi-Fi 2.4GHz. To earn a better
coexistence performance, need to do some RF setting for BTG path.
WiFi 7 generation offload the feature to firmware, to get a more
accuracy control. And decrease driver I/O.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 90 +++++++++++------------
 1 file changed, 43 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 4134c59e876d..bd258acc83d8 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -4972,16 +4972,14 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
 	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
 	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
+	struct rtw89_btc_fbtc_outsrc_set_info *o_info = &btc->dm.ost_info;
 	struct rtw89_btc_wl_role_info *wl_rinfo_v0 = &wl->role_info;
-	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct _wl_rinfo_now wl_rinfo;
-	u32 run_reason = btc->dm.run_reason;
-	u32 is_btg;
-	u8 i, val;
+	u32 is_btg = BTC_BTGCTRL_DISABLE;
 
 	if (btc->manual_ctrl)
 		return;
@@ -4999,58 +4997,56 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 	else
 		return;
 
-	if (rtwdev->dbcc_en) {
-		if (ver->fwlrole == 0) {
-			wl_rinfo.dbcc_2g_phy = RTW89_PHY_NUM;
+	/* notify halbb ignore GNT_BT or not for WL BB Rx-AGC control */
+	if (btc->ant_type == BTC_ANT_SHARED) {
+		if (!(bt->run_patch_code && bt->enable.now))
+			is_btg = BTC_BTGCTRL_DISABLE;
+		else if (wl_rinfo.link_mode != BTC_WLINK_5G)
+			is_btg = BTC_BTGCTRL_ENABLE;
+		else
+			is_btg = BTC_BTGCTRL_DISABLE;
 
-			for (i = 0; i < RTW89_PHY_NUM; i++) {
-				if (wl_dinfo->real_band[i] == RTW89_BAND_2G)
-					wl_rinfo.dbcc_2g_phy = i;
-			}
-		} else if (ver->fwlrole == 1) {
-			wl_rinfo.dbcc_2g_phy = wl_rinfo_v1->dbcc_2g_phy;
-		} else if (ver->fwlrole == 2) {
-			wl_rinfo.dbcc_2g_phy = wl_rinfo_v2->dbcc_2g_phy;
-		} else if (ver->fwlrole == 7) {
-			wl_rinfo.dbcc_2g_phy = wl_rinfo_v7->dbcc_2g_phy;
-		} else if (ver->fwlrole == 8) {
-			wl_rinfo.dbcc_2g_phy = wl_rinfo_v8->dbcc_2g_phy;
-		} else {
-			return;
-		}
+		/* bb call ctrl_btg() in WL FW by slot */
+		if (!ver->fcxosi &&
+		    wl_rinfo.link_mode == BTC_WLINK_25G_MCC)
+			is_btg = BTC_BTGCTRL_BB_GNT_FWCTRL;
 	}
 
-	if (wl_rinfo.link_mode == BTC_WLINK_25G_MCC)
-		is_btg = BTC_BTGCTRL_BB_GNT_FWCTRL;
-	else if (!(bt->run_patch_code && bt->enable.now))
-		is_btg = BTC_BTGCTRL_DISABLE;
-	else if (wl_rinfo.link_mode == BTC_WLINK_5G)
-		is_btg = BTC_BTGCTRL_DISABLE;
-	else if (dm->freerun)
-		is_btg = BTC_BTGCTRL_DISABLE;
-	else if (rtwdev->dbcc_en && wl_rinfo.dbcc_2g_phy != RTW89_PHY_1)
-		is_btg = BTC_BTGCTRL_DISABLE;
+	if (is_btg == dm->wl_btg_rx)
+		return;
 	else
-		is_btg = BTC_BTGCTRL_ENABLE;
+		dm->wl_btg_rx = is_btg;
 
-	if (dm->wl_btg_rx_rb != dm->wl_btg_rx &&
-	    dm->wl_btg_rx_rb != BTC_BTGCTRL_BB_GNT_NOTFOUND) {
-		_get_reg_status(rtwdev, BTC_CSTATUS_BB_GNT_MUX, &val);
-		dm->wl_btg_rx_rb = val;
-	}
+	/* skip setup if btg_ctrl set by wl fw */
+	if (!ver->fcxosi && is_btg > BTC_BTGCTRL_ENABLE)
+		return;
 
-	if (run_reason == BTC_RSN_NTFY_INIT ||
-	    run_reason == BTC_RSN_NTFY_SWBAND ||
-	    dm->wl_btg_rx_rb != dm->wl_btg_rx ||
-	    is_btg != dm->wl_btg_rx) {
+	/* Below flow is for BTC_FEAT_NEW_BBAPI_FLOW = 1 */
+	if (o_info->rf_band[BTC_RF_S0] != o_info->rf_band[BTC_RF_S1]) {/* 1+1 */
+		if (o_info->rf_band[BTC_RF_S0]) /* Non-2G */
+			o_info->btg_rx[BTC_RF_S0] = BTC_BTGCTRL_DISABLE;
+		else
+			o_info->btg_rx[BTC_RF_S0] = is_btg;
 
-		dm->wl_btg_rx = is_btg;
+		if (o_info->rf_band[BTC_RF_S1]) /* Non-2G */
+			o_info->btg_rx[BTC_RF_S1] = BTC_BTGCTRL_DISABLE;
+		else
+			o_info->btg_rx[BTC_RF_S1] = is_btg;
+	} else { /* 2+0 or 0+2 */
+		o_info->btg_rx[BTC_RF_S0] = is_btg;
+		o_info->btg_rx[BTC_RF_S1] = is_btg;
+	}
 
-		if (is_btg > BTC_BTGCTRL_ENABLE)
-			return;
+	if (ver->fcxosi)
+		return;
 
-		chip->ops->ctrl_btg_bt_rx(rtwdev, is_btg, RTW89_PHY_0);
-	}
+	chip->ops->ctrl_btg_bt_rx(rtwdev, o_info->btg_rx[BTC_RF_S0],
+				  RTW89_PHY_0);
+	if (chip->chip_id != RTL8922A)
+		return;
+
+	chip->ops->ctrl_btg_bt_rx(rtwdev, o_info->btg_rx[BTC_RF_S1],
+				  RTW89_PHY_1);
 }
 
 static void _set_wl_preagc_ctrl(struct rtw89_dev *rtwdev)
-- 
2.25.1


