Return-Path: <linux-wireless+bounces-23982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6C3AD49D3
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F9A3A685F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516AB20766E;
	Wed, 11 Jun 2025 03:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="eUj9KaAt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19E221562
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749614183; cv=none; b=FWzrZbPCMFn9Kw9fuojxpTvgAfS4NBBPztVicS63F0z3Ok43/Z7EI9kE+JjxxpLJSPWZLmGn9ZYrMjcCDT5aHJYe1GjJBQv3+/dsYhGdyvY2la04SsMno6UnHIDLYsDfGadfGK6pW2/QLOPzXbmeg6hie4nX2+d4PMjdT5Dsi5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749614183; c=relaxed/simple;
	bh=ZcmdxbKCGoutqCZSQgRehG8Aug+CDxS5neKF45X5tXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmDx7wVwU2Ny7NiZZ4v58ywg0RClKWW8cRy5D/Y4E9xUXV1Pos4+iXwmRr84bYCCXDNeVU/M3CdAw8YWJzgmyg8mXJgZrBttlfUBiguia8qpWra5KdaIYYxNCHDfYg/7ECfnjtEbrpKfyAUndR+9vptaJhvBEkGwmBTYbQHcRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=eUj9KaAt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B3uJxbD4132631, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749614179; bh=ZmVhe+WgHTkIZ5eAOQB+qFfBI8qVqUoz0Q3zlnhHf2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=eUj9KaAt7H2Mc5A46t/mcv3d6UdrSU5yxJfjMkF6IOQaMA254oeSGE0V3pNCaNgMd
	 /N/vLPW31J8d6TBx+KYqmFZohaUyI1MSuGgpJJXl5UV9TBU5BkmXNLWeJq5mXzqD7u
	 UOs3dSsZcEN6ZCv/M1TLX2WyImqnfXEMvRHsCM7hN6nc8DU0jaC+27Zfs/v2691g9t
	 EOvtPOBrVqgq2TlpyKhksV7aq0KOOmwvP9ZUiN6P93t9uiyxfyIsfFcdL+C06MxZmA
	 a4F+HNEzQEr0Y0Hk0OWel2tX6nccJcFwrYnIFcamSWAeLxgAiyTIutR/TmUTbks5Mo
	 BAyRl2sl7yWgw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B3uJxbD4132631
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 11:56:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 11:56:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 11 Jun
 2025 11:56:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 09/10] wifi: rtw89: coex: Update hardware PTA resource binding logic
Date: Wed, 11 Jun 2025 11:55:22 +0800
Message-ID: <20250611035523.36432-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611035523.36432-1-pkshih@realtek.com>
References: <20250611035523.36432-1-pkshih@realtek.com>
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

WiFi 7 generation has 2 MAC, the PTA should bind the input/output to
correct MAC to do the packet arbitration as expected.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 41 ++++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/reg.h  |  1 +
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 04a05958fad4..97df4b2b3368 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5360,15 +5360,47 @@ static void _set_bt_rx_scan_pri(struct rtw89_dev *rtwdev)
 	_write_scbd(rtwdev, BTC_WSCB_RXSCAN_PRI, (bool)(!!bt->scan_rx_low_pri));
 }
 
+static void _wl_req_mac(struct rtw89_dev *rtwdev, u8 mac)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	u32 add;
+
+	if (mac == wl->pta_req_mac)
+		return;
+
+	dm->ost_info.pta_req_hw_band = mac;
+	wl->pta_req_mac = mac;
+	wl->pta_reg_mac_chg = true;
+
+	if (btc->ver->fcxosi)
+		return;
+
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE)
+		add = R_BE_BTC_CFG;
+	else
+		add = R_AX_BTC_CFG;
+
+	if (mac == RTW89_MAC_0)
+		rtw89_write32_clr(rtwdev, add, B_AX_WL_SRC);
+	else
+		rtw89_write32_set(rtwdev, add, B_AX_WL_SRC);
+}
+
 static void _action_common(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_wl_role_info_v8 *rinfo_v8 = &wl->role_info_v8;
 	struct rtw89_btc_wl_smap *wl_smap = &wl->status.map;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	u32 bt_rom_code_id, bt_fw_ver;
 
+	if (btc->ver->fwlrole == 8)
+		_wl_req_mac(rtwdev, rinfo_v8->pta_req_band);
+
 	_set_btg_ctrl(rtwdev);
 	_set_wl_preagc_ctrl(rtwdev);
 	_set_wl_tx_limit(rtwdev);
@@ -5405,6 +5437,7 @@ static void _action_common(struct rtw89_dev *rtwdev)
 		btc->cx.cnt_wl[BTC_WCNT_SCBDUPDATE]++;
 	}
 	btc->dm.tdma_instant_excute = 0;
+	wl->pta_reg_mac_chg = false;
 }
 
 static void _action_by_bt(struct rtw89_dev *rtwdev)
@@ -5867,14 +5900,6 @@ _update_rssi_state(struct rtw89_dev *rtwdev, u8 pre_state, u8 rssi, u8 thresh)
 	return next_state;
 }
 
-static void _wl_req_mac(struct rtw89_dev *rtwdev, u8 mac)
-{
-	if (mac == RTW89_MAC_0)
-		rtw89_write32_clr(rtwdev, R_AX_BTC_CFG, B_AX_WL_SRC);
-	else
-		rtw89_write32_set(rtwdev, R_AX_BTC_CFG, B_AX_WL_SRC);
-}
-
 static
 void _update_dbcc_band(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 255a8635b195..4a65b0c9c2d1 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6070,6 +6070,7 @@
 #define B_BE_MACID_ACQ_GRP0_CLR_P BIT(2)
 #define B_BE_R_MACID_ACQ_CHK_EN BIT(0)
 
+#define R_BE_BTC_CFG 0x0E300
 #define R_BE_BT_BREAK_TABLE 0x0E344
 
 #define R_BE_GNT_SW_CTRL 0x0E348
-- 
2.25.1


