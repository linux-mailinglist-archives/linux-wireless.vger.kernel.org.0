Return-Path: <linux-wireless+bounces-885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E7E81665E
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 07:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DDD2B2124C
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 06:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7D579F9;
	Mon, 18 Dec 2023 06:15:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A508679D9
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 06:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BI6F9euC3224860, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BI6F9euC3224860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 14:15:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 18 Dec 2023 14:15:10 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 18 Dec
 2023 14:15:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 04/11] wifi: rtw89: coex: Update BTG control related logic
Date: Mon, 18 Dec 2023 14:13:34 +0800
Message-ID: <20231218061341.51255-5-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

BTG is a RF system type, it means Wi-Fi 2.4GHz and Bluetooth share RF gain
and antenna. The RF gain must control by Wi-Fi or Bluetooth in single side.
For example, if Bluetooth RX a very strong signal, then Bluetooth will
adjust to a lower gain. And Wi-Fi will also use the same gain to do RX,
then maybe the gain will not enough. This BTG control mechanism can do
some refine to this situation.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 93 ++++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/core.h |  4 +-
 2 files changed, 75 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 895f57d019ba..278ebe1333cc 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -247,6 +247,11 @@ struct rtw89_btc_btf_set_mon_reg {
 	struct rtw89_btc_fbtc_mreg regs[] __counted_by(reg_num);
 } __packed;
 
+struct _wl_rinfo_now {
+	u8 link_mode;
+	u32 dbcc_2g_phy: 2;
+};
+
 enum btc_btf_set_cx_policy {
 	CXPOLICY_TDMA = 0x0,
 	CXPOLICY_SLOT = 0x1,
@@ -741,6 +746,7 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 		btc->dm.wl_tx_limit.tx_time = BTC_MAX_TX_TIME_DEF;
 		btc->dm.wl_tx_limit.tx_retry = BTC_MAX_TX_RETRY_DEF;
 		btc->dm.wl_pre_agc_rb = BTC_PREAGC_NOTFOUND;
+		btc->dm.wl_btg_rx_rb = BTC_BTGCTRL_BB_GNT_NOTFOUND;
 	}
 
 	if (type & BTC_RESET_MDINFO)
@@ -1612,6 +1618,12 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		}
 		break;
 	case BTC_RPT_TYPE_MREG:
+		_get_reg_status(rtwdev, BTC_CSTATUS_BB_GNT_MUX_MON, &val);
+		if (dm->wl_btg_rx == BTC_BTGCTRL_BB_GNT_FWCTRL)
+			dm->wl_btg_rx_rb = BTC_BTGCTRL_BB_GNT_FWCTRL;
+		else
+			dm->wl_btg_rx_rb = val;
+
 		_get_reg_status(rtwdev, BTC_CSTATUS_BB_PRE_AGC_MON, &val);
 		if (dm->wl_pre_agc == BTC_PREAGC_BB_FWCTRL)
 			dm->wl_pre_agc_rb = BTC_PREAGC_BB_FWCTRL;
@@ -3908,46 +3920,78 @@ static void _action_wl_rfk(struct rtw89_dev *rtwdev)
 static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info *wl_rinfo_v0 = &wl->role_info;
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
-	bool is_btg;
-	u8 mode;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_btc_ver *ver = btc->ver;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct _wl_rinfo_now wl_rinfo;
+	u32 run_reason = btc->dm.run_reason;
+	u32 is_btg;
+	u8 i, val;
 
 	if (btc->ctrl.manual)
 		return;
 
 	if (ver->fwlrole == 0)
-		mode = wl_rinfo->link_mode;
+		wl_rinfo.link_mode = wl_rinfo_v0->link_mode;
 	else if (ver->fwlrole == 1)
-		mode = wl_rinfo_v1->link_mode;
+		wl_rinfo.link_mode = wl_rinfo_v1->link_mode;
 	else if (ver->fwlrole == 2)
-		mode = wl_rinfo_v2->link_mode;
+		wl_rinfo.link_mode = wl_rinfo_v2->link_mode;
 	else
 		return;
 
-	/* notify halbb ignore GNT_BT or not for WL BB Rx-AGC control */
-	if (mode == BTC_WLINK_5G) /* always 0 if 5G */
-		is_btg = false;
-	else if (mode == BTC_WLINK_25G_DBCC &&
-		 wl_dinfo->real_band[RTW89_PHY_1] != RTW89_BAND_2G)
-		is_btg = false;
+	if (rtwdev->dbcc_en) {
+		if (ver->fwlrole == 0) {
+			for (i = 0; i < RTW89_PHY_MAX; i++) {
+				if (wl_dinfo->real_band[i] == RTW89_BAND_2G)
+					wl_rinfo.dbcc_2g_phy = i;
+			}
+		} else if (ver->fwlrole == 1) {
+			wl_rinfo.dbcc_2g_phy = wl_rinfo_v1->dbcc_2g_phy;
+		} else if (ver->fwlrole == 2) {
+			wl_rinfo.dbcc_2g_phy = wl_rinfo_v2->dbcc_2g_phy;
+		} else {
+			return;
+		}
+	}
+
+	if (wl_rinfo.link_mode == BTC_WLINK_25G_MCC)
+		is_btg = BTC_BTGCTRL_BB_GNT_FWCTRL;
+	else if (!(bt->run_patch_code && bt->enable.now))
+		is_btg = BTC_BTGCTRL_DISABLE;
+	else if (wl_rinfo.link_mode == BTC_WLINK_5G)
+		is_btg = BTC_BTGCTRL_DISABLE;
+	else if (dm->freerun)
+		is_btg = BTC_BTGCTRL_DISABLE;
+	else if (rtwdev->dbcc_en && wl_rinfo.dbcc_2g_phy != RTW89_PHY_1)
+		is_btg = BTC_BTGCTRL_DISABLE;
 	else
-		is_btg = true;
+		is_btg = BTC_BTGCTRL_ENABLE;
 
-	if (btc->dm.run_reason != BTC_RSN_NTFY_INIT &&
-	    is_btg == btc->dm.wl_btg_rx)
-		return;
+	if (dm->wl_btg_rx_rb != dm->wl_btg_rx &&
+	    dm->wl_btg_rx_rb != BTC_BTGCTRL_BB_GNT_NOTFOUND) {
+		_get_reg_status(rtwdev, BTC_CSTATUS_BB_GNT_MUX, &val);
+		dm->wl_btg_rx_rb = val;
+	}
 
-	btc->dm.wl_btg_rx = is_btg;
+	if (run_reason == BTC_RSN_NTFY_INIT ||
+	    run_reason == BTC_RSN_NTFY_SWBAND ||
+	    dm->wl_btg_rx_rb != dm->wl_btg_rx ||
+	    is_btg != dm->wl_btg_rx) {
 
-	if (mode == BTC_WLINK_25G_MCC)
-		return;
+		dm->wl_btg_rx = is_btg;
+
+		if (is_btg > BTC_BTGCTRL_ENABLE)
+			return;
 
-	rtw89_ctrl_btg_bt_rx(rtwdev, is_btg, RTW89_PHY_0);
+		chip->ops->ctrl_btg_bt_rx(rtwdev, is_btg, RTW89_PHY_0);
+	}
 }
 
 static void _set_wl_preagc_ctrl(struct rtw89_dev *rtwdev)
@@ -6226,6 +6270,13 @@ static void rtw89_btc_ntfy_wl_sta_iter(void *data, struct ieee80211_sta *sta)
 	dm->trx_info.tx_tp = link_info_t->tx_throughput;
 	dm->trx_info.rx_tp = link_info_t->rx_throughput;
 
+	/* Trigger coex-run if 0x10980 reg-value is diff with coex setup */
+	if ((dm->wl_btg_rx_rb != dm->wl_btg_rx &&
+	     dm->wl_btg_rx_rb != BTC_BTGCTRL_BB_GNT_NOTFOUND) ||
+	     (dm->wl_pre_agc_rb != dm->wl_pre_agc &&
+	      dm->wl_pre_agc_rb != BTC_PREAGC_NOTFOUND))
+		iter_data->is_sta_change = true;
+
 	if (is_sta_change)
 		iter_data->is_sta_change = true;
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index cf7708742632..0e7b8360ace7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2506,11 +2506,13 @@ struct rtw89_btc_dm {
 	u32 noisy_level: 3;
 	u32 coex_info_map: 8;
 	u32 bt_only: 1;
-	u32 wl_btg_rx: 1;
+	u32 wl_btg_rx: 2;
 	u32 trx_para_level: 8;
 	u32 wl_stb_chg: 1;
 	u32 pta_owner: 1;
+
 	u32 tdma_instant_excute: 1;
+	u32 wl_btg_rx_rb: 2;
 
 	u16 slot_dur[CXST_MAX];
 
-- 
2.25.1


