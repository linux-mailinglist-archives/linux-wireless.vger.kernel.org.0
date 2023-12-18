Return-Path: <linux-wireless+bounces-890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A76816663
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 07:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29E91F227DF
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 06:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0987BDF65;
	Mon, 18 Dec 2023 06:15:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A4DDDAC
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 06:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BI6FHqvC3224887, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BI6FHqvC3224887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 14:15:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 18 Dec 2023 14:15:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 18 Dec
 2023 14:15:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 09/11] wifi: rtw89: coex: Update RF parameter control setting logic
Date: Mon, 18 Dec 2023 14:13:39 +0800
Message-ID: <20231218061341.51255-10-pkshih@realtek.com>
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

Coexistence will set the RF parameter according to Wi-Fi link mode,
Wi-Fi/Bluetooth signal level, traffic direction, antenna type,
and is there Bluetooth connection exist or not. Bluetooth will notify
the current LNA level by scoreboard. If the setting not as expected,
coexistence will try to assign the correct level.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 86 ++++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/core.h |  3 +-
 2 files changed, 62 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index d1368b2bc688..8273408ffd42 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -268,6 +268,8 @@ enum btc_b2w_scoreboard {
 	BTC_BSCB_RFK_RUN = BIT(5),
 	BTC_BSCB_RFK_REQ = BIT(6),
 	BTC_BSCB_LPS = BIT(7),
+	BTC_BSCB_BT_LNAB0 = BIT(8),
+	BTC_BSCB_BT_LNAB1 = BIT(10),
 	BTC_BSCB_WLRFK = BIT(11),
 	BTC_BSCB_BT_HILNA = BIT(13),
 	BTC_BSCB_BT_CONNECT = BIT(16),
@@ -716,7 +718,8 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 
 	if (type & BTC_RESET_CX)
 		memset(cx, 0, sizeof(*cx));
-	else if (type & BTC_RESET_BTINFO) /* only for BT enable */
+
+	if (type & BTC_RESET_BTINFO) /* only for BT enable */
 		memset(bt, 0, sizeof(*bt));
 
 	if (type & BTC_RESET_CTRL) {
@@ -2277,8 +2280,9 @@ static void _set_bt_rx_gain(struct rtw89_dev *rtwdev, u8 level)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 
-	if (bt->rf_para.rx_gain_freerun == level ||
-	    level > BTC_BT_RX_NORMAL_LVL)
+	if ((bt->rf_para.rx_gain_freerun == level ||
+	     level > BTC_BT_RX_NORMAL_LVL) &&
+	    (!rtwdev->chip->scbd || bt->lna_constrain == level))
 		return;
 
 	bt->rf_para.rx_gain_freerun = level;
@@ -2293,32 +2297,59 @@ static void _set_bt_rx_gain(struct rtw89_dev *rtwdev, u8 level)
 	else
 		_write_scbd(rtwdev, BTC_WSCB_RXGAIN, true);
 
-	_send_fw_cmd(rtwdev, BTFC_SET, SET_BT_LNA_CONSTRAIN, &level, 1);
+	_send_fw_cmd(rtwdev, BTFC_SET, SET_BT_LNA_CONSTRAIN, &level, sizeof(level));
 }
 
 static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_btc_bt_link_info *b = &bt->link_info;
+	struct rtw89_btc_wl_smap *wl_smap = &wl->status.map;
 	struct rtw89_btc_rf_trx_para para;
 	u32 wl_stb_chg = 0;
-	u8 level_id = 0;
+	u8 level_id = 0, link_mode = 0, i, dbcc_2g_phy = 0;
 
-	if (!dm->freerun) {
-		/* fix LNA2 = level-5 for BT ACI issue at BTG */
+	if (ver->fwlrole == 0) {
+		link_mode = wl->role_info.link_mode;
+		for (i = 0; i < RTW89_PHY_MAX; i++) {
+			if (wl->dbcc_info.real_band[i] == RTW89_BAND_2G)
+				dbcc_2g_phy = i;
+		}
+	} else if (ver->fwlrole == 1) {
+		link_mode = wl->role_info_v1.link_mode;
+		dbcc_2g_phy = wl->role_info_v1.dbcc_2g_phy;
+	} else if (ver->fwlrole == 2) {
+		link_mode = wl->role_info_v2.link_mode;
+		dbcc_2g_phy = wl->role_info_v2.dbcc_2g_phy;
+	}
+
+	/* decide trx_para_level */
+	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) {
+		/* fix LNA2 + TIA gain not change by GNT_BT */
 		if ((btc->dm.wl_btg_rx && b->profile_cnt.now != 0) ||
 		    dm->bt_only == 1)
-			dm->trx_para_level = 1;
+			dm->trx_para_level = 1; /* for better BT ACI issue */
 		else
 			dm->trx_para_level = 0;
+	} else { /* non-shared antenna  */
+		dm->trx_para_level = 5;
+		/* modify trx_para if WK 2.4G-STA-DL + bt link */
+		if (b->profile_cnt.now != 0 &&
+		    link_mode == BTC_WLINK_2G_STA &&
+		    wl->status.map.traffic_dir & BIT(RTW89_TFC_UL)) { /* uplink */
+			if (wl->rssi_level == 4 && bt->rssi_level > 2)
+				dm->trx_para_level = 6;
+			else if (wl->rssi_level == 3 && bt->rssi_level > 3)
+				dm->trx_para_level = 7;
+		}
 	}
 
-	level_id = (u8)dm->trx_para_level;
-
+	level_id = dm->trx_para_level;
 	if (level_id >= chip->rf_para_dlink_num ||
 	    level_id >= chip->rf_para_ulink_num) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -2332,25 +2363,26 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 	else
 		para = chip->rf_para_dlink[level_id];
 
-	if (para.wl_tx_power != RTW89_BTC_WL_DEF_TX_PWR)
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], %s(): wl_tx_power=%d\n",
-			    __func__, para.wl_tx_power);
-	_set_wl_tx_power(rtwdev, para.wl_tx_power);
-	_set_wl_rx_gain(rtwdev, para.wl_rx_gain);
-	_set_bt_tx_power(rtwdev, para.bt_tx_power);
-	_set_bt_rx_gain(rtwdev, para.bt_rx_gain);
-
-	if (bt->enable.now == 0 || wl->status.map.rf_off == 1 ||
-	    wl->status.map.lps == BTC_LPS_RF_OFF)
+	if (dm->fddt_train) {
+		_set_wl_rx_gain(rtwdev, 1);
+		_write_scbd(rtwdev, BTC_WSCB_RXGAIN, true);
+	} else {
+		_set_wl_tx_power(rtwdev, para.wl_tx_power);
+		_set_wl_rx_gain(rtwdev, para.wl_rx_gain);
+		_set_bt_tx_power(rtwdev, para.bt_tx_power);
+		_set_bt_rx_gain(rtwdev, para.bt_rx_gain);
+	}
+
+	if (!bt->enable.now || dm->wl_only || wl_smap->rf_off ||
+	    wl_smap->lps == BTC_LPS_RF_OFF ||
+	    link_mode == BTC_WLINK_5G ||
+	    link_mode == BTC_WLINK_NOLINK ||
+	    (rtwdev->dbcc_en && dbcc_2g_phy != RTW89_PHY_1))
 		wl_stb_chg = 0;
 	else
 		wl_stb_chg = 1;
 
 	if (wl_stb_chg != dm->wl_stb_chg) {
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], %s(): wl_stb_chg=%d\n",
-			    __func__, wl_stb_chg);
 		dm->wl_stb_chg = wl_stb_chg;
 		chip->ops->btc_wl_s1_standby(rtwdev, dm->wl_stb_chg);
 	}
@@ -5234,8 +5266,7 @@ static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update)
 		return;
 	}
 
-	if (!(val & BTC_BSCB_ON) ||
-	    btc->dm.cnt_dm[BTC_DCNT_BTCNT_HANG] >= BTC_CHK_HANG_MAX)
+	if (!(val & BTC_BSCB_ON))
 		bt->enable.now = 0;
 	else
 		bt->enable.now = 1;
@@ -5261,6 +5292,9 @@ static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update)
 	bt->btg_type = val & BTC_BSCB_BT_S1 ? BTC_BT_BTG : BTC_BT_ALONE;
 	bt->link_info.a2dp_desc.exist = !!(val & BTC_BSCB_A2DP_ACT);
 
+	bt->lna_constrain = !!(val & BTC_BSCB_BT_LNAB0) +
+			    !!(val & BTC_BSCB_BT_LNAB1) * 2 + 4;
+
 	/* if rfk run 1->0 */
 	if (bt->rfk_info.map.run && !(val & BTC_BSCB_RFK_RUN))
 		status_change = true;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7c92330ba06a..ea6df859ba15 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1831,7 +1831,8 @@ struct rtw89_btc_bt_info {
 	u32 hi_lna_rx: 1;
 	u32 scan_rx_low_pri: 1;
 	u32 scan_info_update: 1;
-	u32 rsvd: 20;
+	u32 lna_constrain: 3;
+	u32 rsvd: 17;
 };
 
 struct rtw89_btc_cx {
-- 
2.25.1


