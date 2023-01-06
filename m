Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90C265FFF4
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jan 2023 13:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjAFMJX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Jan 2023 07:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjAFMJQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Jan 2023 07:09:16 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 239A17289E
        for <linux-wireless@vger.kernel.org>; Fri,  6 Jan 2023 04:09:13 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 306C8BEJ0028278, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 306C8BEJ0028278
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 6 Jan 2023 20:08:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 6 Jan 2023 20:09:07 +0800
Received: from localhost (172.16.18.220) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 6 Jan 2023
 20:09:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/7] wifi: rtw89: coex: Change Wi-Fi role info related logic to version separate
Date:   Fri, 6 Jan 2023 20:08:44 +0800
Message-ID: <20230106120844.17441-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106120844.17441-1-pkshih@realtek.com>
References: <20230106120844.17441-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.18.220]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/06/2023 11:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvNiCkV6TIIDA5OjMyOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

The Wi-Fi role info structure will need to H2C to firmware, firmware
need these information to do some multi-role operation. v1 add DBCC
and NOA information in the structure. And driver side also need to
put/get values at the corresponding version of structure.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 39 ++++++++++++-----------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index ec31dd0751cee..d48ae25823ffa 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -2075,6 +2075,7 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_btc_bt_link_info *b = &bt->link_info;
@@ -2088,7 +2089,7 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 	if (btc->ctrl.manual || wl->status.map.scan)
 		return;
 
-	if (chip->chip_id == RTL8852A) {
+	if (ver->fwlrole == 0) {
 		mode = wl_rinfo->link_mode;
 		connect_cnt = wl_rinfo->connect_cnt;
 	} else {
@@ -2107,13 +2108,13 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 			r = &wl_rinfo->active_role[i];
 			r1 = &wl_rinfo_v1->active_role_v1[i];
 
-			if (chip->chip_id == RTL8852A &&
+			if (ver->fwlrole == 0 &&
 			    (r->role == RTW89_WIFI_ROLE_P2P_GO ||
 			     r->role == RTW89_WIFI_ROLE_P2P_CLIENT)) {
 				ch = r->ch;
 				bw = r->bw;
 				break;
-			} else if (chip->chip_id != RTL8852A &&
+			} else if (ver->fwlrole == 1 &&
 				   (r1->role == RTW89_WIFI_ROLE_P2P_GO ||
 				    r1->role == RTW89_WIFI_ROLE_P2P_CLIENT)) {
 				ch = r1->ch;
@@ -2128,12 +2129,12 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 			r = &wl_rinfo->active_role[i];
 			r1 = &wl_rinfo_v1->active_role_v1[i];
 
-			if (chip->chip_id == RTL8852A &&
+			if (ver->fwlrole == 0 &&
 			    r->connected && r->band == RTW89_BAND_2G) {
 				ch = r->ch;
 				bw = r->bw;
 				break;
-			} else if (chip->chip_id != RTL8852A &&
+			} else if (ver->fwlrole == 1 &&
 				   r1->connected && r1->band == RTW89_BAND_2G) {
 				ch = r1->ch;
 				bw = r1->bw;
@@ -3581,8 +3582,8 @@ static void _action_wl_rfk(struct rtw89_dev *rtwdev)
 
 static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
@@ -3593,7 +3594,7 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 	if (btc->ctrl.manual)
 		return;
 
-	if (chip->chip_id == RTL8852A)
+	if (ver->fwlrole == 0)
 		mode = wl_rinfo->link_mode;
 	else
 		mode = wl_rinfo_v1->link_mode;
@@ -3686,8 +3687,8 @@ static void rtw89_tx_time_iter(void *data, struct ieee80211_sta *sta)
 
 static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
@@ -3707,7 +3708,7 @@ static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 	if (btc->ctrl.manual)
 		return;
 
-	if (chip->chip_id == RTL8852A)
+	if (ver->fwlrole == 0)
 		mode = wl_rinfo->link_mode;
 	else
 		mode = wl_rinfo_v1->link_mode;
@@ -3755,8 +3756,8 @@ static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 
 static void _set_bt_rx_agc(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
@@ -3764,7 +3765,7 @@ static void _set_bt_rx_agc(struct rtw89_dev *rtwdev)
 	bool bt_hi_lna_rx = false;
 	u8 mode;
 
-	if (chip->chip_id == RTL8852A)
+	if (ver->fwlrole == 0)
 		mode = wl_rinfo->link_mode;
 	else
 		mode = wl_rinfo_v1->link_mode;
@@ -4628,8 +4629,8 @@ static bool _chk_wl_rfk_request(struct rtw89_dev *rtwdev)
 static
 void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
@@ -4644,7 +4645,7 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	_update_dm_step(rtwdev, reason);
 	_update_btc_state_map(rtwdev);
 
-	if (chip->chip_id == RTL8852A)
+	if (ver->fwlrole == 0)
 		mode = wl_rinfo->link_mode;
 	else
 		mode = wl_rinfo_v1->link_mode;
@@ -4766,9 +4767,9 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 		break;
 	case BTC_WLINK_2G_SCC:
 		bt->scan_rx_low_pri = true;
-		if (chip->chip_id == RTL8852A)
+		if (ver->fwlrole == 0)
 			_action_wl_2g_scc(rtwdev);
-		else if (chip->chip_id == RTL8852C)
+		else if (ver->fwlrole == 1)
 			_action_wl_2g_scc_v1(rtwdev);
 		break;
 	case BTC_WLINK_2G_MCC:
@@ -5206,10 +5207,10 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif
 			      struct rtw89_sta *rtwsta, enum btc_role_state state)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta);
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_link_info r = {0};
 	struct rtw89_btc_wl_link_info *wlinfo = NULL;
@@ -5273,7 +5274,7 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif
 	wlinfo = &wl->link_info[r.pid];
 
 	memcpy(wlinfo, &r, sizeof(*wlinfo));
-	if (chip->chip_id == RTL8852A)
+	if (ver->fwlrole == 0)
 		_update_wl_info(rtwdev);
 	else
 		_update_wl_info_v1(rtwdev);
@@ -5789,8 +5790,8 @@ static void _show_wl_role_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 static void _show_wl_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
@@ -5802,7 +5803,7 @@ static void _show_wl_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 	seq_puts(m, "========== [WL Status] ==========\n");
 
-	if (chip->chip_id == RTL8852A)
+	if (ver->fwlrole == 0)
 		mode = wl_rinfo->link_mode;
 	else
 		mode = wl_rinfo_v1->link_mode;
-- 
2.25.1

