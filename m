Return-Path: <linux-wireless+bounces-6483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8471C8A9110
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 04:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68531C20EC5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 02:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBD54F888;
	Thu, 18 Apr 2024 02:12:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272B4F889
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406373; cv=none; b=CcIsX43VKcGvlYuylyyIe7hXkfq3cdqs9NGJdtsUQQIEo+YourJIy+ybwoLVXAsvwYWfYcAER/wBY1A9Bww1j4yKqVIViA3bBKevJfQ6eSuBbxhYqYZ3Kc3vLVRp8uh4AeDDL6IBX9HBGeZUEDl5HzaG5YWVw2bpnr/6Hth/CiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406373; c=relaxed/simple;
	bh=dOZULi/makXT/hRmlIcIUXoNoAs9cywIXy4LVdniZIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NONUKYnj/WowUYRkpKk8B40nO2oxHbRpYMkH7nhCyfYhqLntOftZ/usfVxbwi2EUDrb6uSieiWIHiyTjzdDazXIra7BK0T+8yeRBdjMtlo6ey5SKy1OS3VMu3xFnLNeTvgKlsrs5CWyW47tyDyLFV+BHhIeiZS83d8LS1e21O4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I2Cn9423994731, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I2Cn9423994731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 10:12:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 10:12:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 10:12:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 5/9] wifi: rtw89: coex: Update Bluetooth polluted Wi-Fi TX logic
Date: Thu, 18 Apr 2024 10:12:03 +0800
Message-ID: <20240418021207.32173-6-pkshih@realtek.com>
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

When the PTA breaks Wi-Fi traffic request caused Bluetooth traffic,
it means Bluetooth polluted the Wi-Fi traffic. When Wi-Fi is TX, the
mechanism can ignore the polluted Wi-Fi packet retry counter, it is
help to the stability of Wi-Fi TX rate. The chip RTL8922A has not only
one MAC, so need to include the all MAC as reference.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 45 ++++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 37eb85d63657..b296217d593a 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -3800,21 +3800,32 @@ EXPORT_SYMBOL(rtw89_btc_set_policy_v1);
 static void _set_bt_plut(struct rtw89_dev *rtwdev, u8 phy_map,
 			 u8 tx_val, u8 rx_val)
 {
+	struct rtw89_btc_wl_info *wl = &rtwdev->btc.cx.wl;
 	struct rtw89_mac_ax_plt plt;
 
-	plt.band = RTW89_MAC_0;
 	plt.tx = tx_val;
 	plt.rx = rx_val;
 
-	if (phy_map & BTC_PHY_0)
+	if (rtwdev->btc.ver->fwlrole == 8) {
+		plt.band = wl->pta_req_mac;
+		if (wl->bt_polut_type[plt.band] == tx_val)
+			return;
+
+		wl->bt_polut_type[plt.band] = tx_val;
 		rtw89_mac_cfg_plt(rtwdev, &plt);
+	} else {
+		plt.band = RTW89_MAC_0;
 
-	if (!rtwdev->dbcc_en)
-		return;
+		if (phy_map & BTC_PHY_0)
+			rtw89_mac_cfg_plt(rtwdev, &plt);
 
-	plt.band = RTW89_MAC_1;
-	if (phy_map & BTC_PHY_1)
-		rtw89_mac_cfg_plt(rtwdev, &plt);
+		if (!rtwdev->dbcc_en)
+			return;
+
+		plt.band = RTW89_MAC_1;
+		if (phy_map & BTC_PHY_1)
+			rtw89_mac_cfg_plt(rtwdev, &plt);
+	}
 }
 
 static void _set_ant_v0(struct rtw89_dev *rtwdev, bool force_exec,
@@ -7842,6 +7853,21 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 #define CASE_BTC_EVT_STR(e) case CXEVNT_## e: return #e
 #define CASE_BTC_INIT(e) case BTC_MODE_## e: return #e
 #define CASE_BTC_ANTPATH_STR(e) case BTC_ANT_##e: return #e
+#define CASE_BTC_POLUT_STR(e) case BTC_PLT_## e: return #e
+
+static const char *id_to_polut(u32 id)
+{
+	switch (id) {
+	CASE_BTC_POLUT_STR(NONE);
+	CASE_BTC_POLUT_STR(GNT_BT_TX);
+	CASE_BTC_POLUT_STR(GNT_BT_RX);
+	CASE_BTC_POLUT_STR(GNT_WL);
+	CASE_BTC_POLUT_STR(BT);
+	CASE_BTC_POLUT_STR(ALL);
+	default:
+		return "unknown";
+	}
+}
 
 static const char *steps_to_str(u16 step)
 {
@@ -9345,12 +9371,13 @@ static void _show_mreg_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 	gnt = gnt_cfg.band[0];
 	seq_printf(m,
-		   " %-15s : pta_owner:%s, phy-0[gnt_wl:%s-%d/gnt_bt:%s-%d], ",
+		   " %-15s : pta_owner:%s, phy-0[gnt_wl:%s-%d/gnt_bt:%s-%d], polut_type:%s",
 		   "[gnt_status]",
 		   chip->chip_id == RTL8852C ? "HW" :
 		   btc->dm.pta_owner == BTC_CTRL_BY_WL ? "WL" : "BT",
 		   gnt.gnt_wl_sw_en ? "SW" : "HW", gnt.gnt_wl,
-		   gnt.gnt_bt_sw_en ? "SW" : "HW", gnt.gnt_bt);
+		   gnt.gnt_bt_sw_en ? "SW" : "HW", gnt.gnt_bt,
+		   id_to_polut(wl->bt_polut_type[wl->pta_req_mac]));
 
 	gnt = gnt_cfg.band[1];
 	seq_printf(m, "phy-1[gnt_wl:%s-%d/gnt_bt:%s-%d]\n",
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 43f42774eccc..517966423969 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1807,6 +1807,7 @@ struct rtw89_btc_wl_info {
 	u8 cn_report;
 	u8 coex_mode;
 	u8 pta_req_mac;
+	u8 bt_polut_type[RTW89_PHY_MAX]; /* BT polluted WL-Tx type for phy0/1  */
 
 	bool is_5g_hi_channel;
 	bool pta_reg_mac_chg;
-- 
2.25.1


