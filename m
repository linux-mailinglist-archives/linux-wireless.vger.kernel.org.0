Return-Path: <linux-wireless+bounces-886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61FE81665F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 07:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F551C2211D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 06:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDBD8482;
	Mon, 18 Dec 2023 06:15:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E6579E6
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BI6FB8G03224866, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BI6FB8G03224866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 14:15:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 18 Dec 2023 14:15:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 18 Dec
 2023 14:15:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 05/11] wifi: rtw89: coex: Still show hardware grant signal info even Wi-Fi is PS
Date: Mon, 18 Dec 2023 14:13:35 +0800
Message-ID: <20231218061341.51255-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218061341.51255-1-pkshih@realtek.com>
References: <20231218061341.51255-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Ching-Te Ku <ku920601@realtek.com>

This can help to debug the grant signal and antenna path control issue
during Wi-Fi power saving mode.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 79 +++++++++++------------
 drivers/net/wireless/realtek/rtw89/mac.c  |  3 +-
 2 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 278ebe1333cc..a5373660da5b 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -7922,7 +7922,8 @@ static void _get_gnt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_coex_gnt *gnt
 	struct rtw89_mac_ax_gnt *gnt;
 	u32 val, status;
 
-	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B) {
+	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B ||
+	    chip->chip_id == RTL8851B) {
 		rtw89_mac_read_lte(rtwdev, R_AX_LTE_SW_CFG_1, &val);
 		rtw89_mac_read_lte(rtwdev, R_AX_GNT_VAL, &status);
 
@@ -7984,27 +7985,25 @@ static void _show_mreg_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   bt->scbd, cx->cnt_bt[BTC_BCNT_SCBDREAD],
 		   cx->cnt_bt[BTC_BCNT_SCBDUPDATE]);
 
-	/* To avoid I/O if WL LPS or power-off  */
-	if (!wl->status.map.lps && !wl->status.map.rf_off) {
-		btc->dm.pta_owner = rtw89_mac_get_ctrl_path(rtwdev);
+	btc->dm.pta_owner = rtw89_mac_get_ctrl_path(rtwdev);
+	_get_gnt(rtwdev, &gnt_cfg);
+
+	gnt = gnt_cfg.band[0];
+	seq_printf(m,
+		   " %-15s : pta_owner:%s, phy-0[gnt_wl:%s-%d/gnt_bt:%s-%d], ",
+		   "[gnt_status]",
+		   chip->chip_id == RTL8852C ? "HW" :
+		   btc->dm.pta_owner == BTC_CTRL_BY_WL ? "WL" : "BT",
+		   gnt.gnt_wl_sw_en ? "SW" : "HW", gnt.gnt_wl,
+		   gnt.gnt_bt_sw_en ? "SW" : "HW", gnt.gnt_bt);
+
+	gnt = gnt_cfg.band[1];
+	seq_printf(m, "phy-1[gnt_wl:%s-%d/gnt_bt:%s-%d]\n",
+		   gnt.gnt_wl_sw_en ? "SW" : "HW",
+		   gnt.gnt_wl,
+		   gnt.gnt_bt_sw_en ? "SW" : "HW",
+		   gnt.gnt_bt);
 
-		_get_gnt(rtwdev, &gnt_cfg);
-		gnt = gnt_cfg.band[0];
-		seq_printf(m,
-			   " %-15s : pta_owner:%s, phy-0[gnt_wl:%s-%d/gnt_bt:%s-%d], ",
-			   "[gnt_status]",
-			   chip->chip_id == RTL8852C ? "HW" :
-			   btc->dm.pta_owner == BTC_CTRL_BY_WL ? "WL" : "BT",
-			   gnt.gnt_wl_sw_en ? "SW" : "HW", gnt.gnt_wl,
-			   gnt.gnt_bt_sw_en ? "SW" : "HW", gnt.gnt_bt);
-
-		gnt = gnt_cfg.band[1];
-		seq_printf(m, "phy-1[gnt_wl:%s-%d/gnt_bt:%s-%d]\n",
-			   gnt.gnt_wl_sw_en ? "SW" : "HW",
-			   gnt.gnt_wl,
-			   gnt.gnt_bt_sw_en ? "SW" : "HW",
-			   gnt.gnt_bt);
-	}
 	pcinfo = &pfwinfo->rpt_fbtc_mregval.cinfo;
 	if (!pcinfo->valid) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -8088,27 +8087,25 @@ static void _show_mreg_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   bt->scbd, cx->cnt_bt[BTC_BCNT_SCBDREAD],
 		   cx->cnt_bt[BTC_BCNT_SCBDUPDATE]);
 
-	/* To avoid I/O if WL LPS or power-off  */
-	if (!wl->status.map.lps && !wl->status.map.rf_off) {
-		btc->dm.pta_owner = rtw89_mac_get_ctrl_path(rtwdev);
+	btc->dm.pta_owner = rtw89_mac_get_ctrl_path(rtwdev);
+	_get_gnt(rtwdev, &gnt_cfg);
+
+	gnt = gnt_cfg.band[0];
+	seq_printf(m,
+		   " %-15s : pta_owner:%s, phy-0[gnt_wl:%s-%d/gnt_bt:%s-%d], ",
+		   "[gnt_status]",
+		   chip->chip_id == RTL8852C ? "HW" :
+		   btc->dm.pta_owner == BTC_CTRL_BY_WL ? "WL" : "BT",
+		   gnt.gnt_wl_sw_en ? "SW" : "HW", gnt.gnt_wl,
+		   gnt.gnt_bt_sw_en ? "SW" : "HW", gnt.gnt_bt);
+
+	gnt = gnt_cfg.band[1];
+	seq_printf(m, "phy-1[gnt_wl:%s-%d/gnt_bt:%s-%d]\n",
+		   gnt.gnt_wl_sw_en ? "SW" : "HW",
+		   gnt.gnt_wl,
+		   gnt.gnt_bt_sw_en ? "SW" : "HW",
+		   gnt.gnt_bt);
 
-		_get_gnt(rtwdev, &gnt_cfg);
-		gnt = gnt_cfg.band[0];
-		seq_printf(m,
-			   " %-15s : pta_owner:%s, phy-0[gnt_wl:%s-%d/gnt_bt:%s-%d], ",
-			   "[gnt_status]",
-			   chip->chip_id == RTL8852C ? "HW" :
-			   btc->dm.pta_owner == BTC_CTRL_BY_WL ? "WL" : "BT",
-			   gnt.gnt_wl_sw_en ? "SW" : "HW", gnt.gnt_wl,
-			   gnt.gnt_bt_sw_en ? "SW" : "HW", gnt.gnt_bt);
-
-		gnt = gnt_cfg.band[1];
-		seq_printf(m, "phy-1[gnt_wl:%s-%d/gnt_bt:%s-%d]\n",
-			   gnt.gnt_wl_sw_en ? "SW" : "HW",
-			   gnt.gnt_wl,
-			   gnt.gnt_bt_sw_en ? "SW" : "HW",
-			   gnt.gnt_bt);
-	}
 	pcinfo = &pfwinfo->rpt_fbtc_mregval.cinfo;
 	if (!pcinfo->valid) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 80ab5fdfdaa0..c485ef2cc3d3 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5507,7 +5507,8 @@ bool rtw89_mac_get_ctrl_path(struct rtw89_dev *rtwdev)
 
 	if (chip->chip_id == RTL8852C)
 		return false;
-	else if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B)
+	else if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B ||
+		 chip->chip_id == RTL8851B)
 		val = rtw89_read8_mask(rtwdev, R_AX_SYS_SDIO_CTRL + 3,
 				       B_AX_LTE_MUX_CTRL_PATH >> 24);
 
-- 
2.25.1


