Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94906AFE62
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 06:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCHFdm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 00:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCHFdl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 00:33:41 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108378C0ED
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 21:33:35 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3285XIZq8016144, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3285XIZq8016144
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 8 Mar 2023 13:33:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 8 Mar 2023 13:33:27 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 8 Mar 2023
 13:33:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/7] wifi: rtw89: coex: Add more error_map and counter to log
Date:   Wed, 8 Mar 2023 13:32:19 +0800
Message-ID: <20230308053225.24377-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308053225.24377-1-pkshih@realtek.com>
References: <20230308053225.24377-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

The error map and counter can help to analyze is coexistence mechanism
going well or not. For example, if there is E2G (External control Wi-Fi
slot for Wi-Fi 2.4 GHz) hang counter, it means Wi-Fi firmware didn't cut
a slot for Wi-Fi 2.4 GHz. Maybe something wrong with firmware timer.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 112 +++++++++++++---------
 drivers/net/wireless/realtek/rtw89/core.h |  31 ++++--
 2 files changed, 88 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index bcf483cafd203..f80952e6e11ba 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -734,6 +734,7 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 
 #define BTC_RPT_HDR_SIZE 3
 #define BTC_CHK_WLSLOT_DRIFT_MAX 15
+#define BTC_CHK_BTSLOT_DRIFT_MAX 15
 #define BTC_CHK_HANG_MAX 3
 
 static void _chk_btc_err(struct rtw89_dev *rtwdev, u8 type, u32 cnt)
@@ -748,62 +749,76 @@ static void _chk_btc_err(struct rtw89_dev *rtwdev, u8 type, u32 cnt)
 		    __func__, type, cnt);
 
 	switch (type) {
-	case BTC_DCNT_RPT_FREEZE:
+	case BTC_DCNT_RPT_HANG:
 		if (dm->cnt_dm[BTC_DCNT_RPT] == cnt && btc->fwinfo.rpt_en_map)
-			dm->cnt_dm[BTC_DCNT_RPT_FREEZE]++;
+			dm->cnt_dm[BTC_DCNT_RPT_HANG]++;
 		else
-			dm->cnt_dm[BTC_DCNT_RPT_FREEZE] = 0;
+			dm->cnt_dm[BTC_DCNT_RPT_HANG] = 0;
 
-		if (dm->cnt_dm[BTC_DCNT_RPT_FREEZE] >= BTC_CHK_HANG_MAX)
+		if (dm->cnt_dm[BTC_DCNT_RPT_HANG] >= BTC_CHK_HANG_MAX)
 			dm->error.map.wl_fw_hang = true;
 		else
 			dm->error.map.wl_fw_hang = false;
 
 		dm->cnt_dm[BTC_DCNT_RPT] = cnt;
 		break;
-	case BTC_DCNT_CYCLE_FREEZE:
+	case BTC_DCNT_CYCLE_HANG:
 		if (dm->cnt_dm[BTC_DCNT_CYCLE] == cnt &&
 		    (dm->tdma_now.type != CXTDMA_OFF ||
 		     dm->tdma_now.ext_ctrl == CXECTL_EXT))
-			dm->cnt_dm[BTC_DCNT_CYCLE_FREEZE]++;
+			dm->cnt_dm[BTC_DCNT_CYCLE_HANG]++;
 		else
-			dm->cnt_dm[BTC_DCNT_CYCLE_FREEZE] = 0;
+			dm->cnt_dm[BTC_DCNT_CYCLE_HANG] = 0;
 
-		if (dm->cnt_dm[BTC_DCNT_CYCLE_FREEZE] >= BTC_CHK_HANG_MAX)
+		if (dm->cnt_dm[BTC_DCNT_CYCLE_HANG] >= BTC_CHK_HANG_MAX)
 			dm->error.map.cycle_hang = true;
 		else
 			dm->error.map.cycle_hang = false;
 
 		dm->cnt_dm[BTC_DCNT_CYCLE] = cnt;
 		break;
-	case BTC_DCNT_W1_FREEZE:
+	case BTC_DCNT_W1_HANG:
 		if (dm->cnt_dm[BTC_DCNT_W1] == cnt &&
 		    dm->tdma_now.type != CXTDMA_OFF)
-			dm->cnt_dm[BTC_DCNT_W1_FREEZE]++;
+			dm->cnt_dm[BTC_DCNT_W1_HANG]++;
 		else
-			dm->cnt_dm[BTC_DCNT_W1_FREEZE] = 0;
+			dm->cnt_dm[BTC_DCNT_W1_HANG] = 0;
 
-		if (dm->cnt_dm[BTC_DCNT_W1_FREEZE] >= BTC_CHK_HANG_MAX)
+		if (dm->cnt_dm[BTC_DCNT_W1_HANG] >= BTC_CHK_HANG_MAX)
 			dm->error.map.w1_hang = true;
 		else
 			dm->error.map.w1_hang = false;
 
 		dm->cnt_dm[BTC_DCNT_W1] = cnt;
 		break;
-	case BTC_DCNT_B1_FREEZE:
+	case BTC_DCNT_B1_HANG:
 		if (dm->cnt_dm[BTC_DCNT_B1] == cnt &&
 		    dm->tdma_now.type != CXTDMA_OFF)
-			dm->cnt_dm[BTC_DCNT_B1_FREEZE]++;
+			dm->cnt_dm[BTC_DCNT_B1_HANG]++;
 		else
-			dm->cnt_dm[BTC_DCNT_B1_FREEZE] = 0;
+			dm->cnt_dm[BTC_DCNT_B1_HANG] = 0;
 
-		if (dm->cnt_dm[BTC_DCNT_B1_FREEZE] >= BTC_CHK_HANG_MAX)
+		if (dm->cnt_dm[BTC_DCNT_B1_HANG] >= BTC_CHK_HANG_MAX)
 			dm->error.map.b1_hang = true;
 		else
 			dm->error.map.b1_hang = false;
 
 		dm->cnt_dm[BTC_DCNT_B1] = cnt;
 		break;
+	case BTC_DCNT_E2G_HANG:
+		if (dm->cnt_dm[BTC_DCNT_E2G] == cnt &&
+		    dm->tdma_now.ext_ctrl == CXECTL_EXT)
+			dm->cnt_dm[BTC_DCNT_E2G_HANG]++;
+		else
+			dm->cnt_dm[BTC_DCNT_E2G_HANG] = 0;
+
+		if (dm->cnt_dm[BTC_DCNT_E2G_HANG] >= BTC_CHK_HANG_MAX)
+			dm->error.map.wl_e2g_hang = true;
+		else
+			dm->error.map.wl_e2g_hang = false;
+
+		dm->cnt_dm[BTC_DCNT_E2G] = cnt;
+		break;
 	case BTC_DCNT_TDMA_NONSYNC:
 		if (cnt != 0) /* if tdma not sync between drv/fw  */
 			dm->cnt_dm[BTC_DCNT_TDMA_NONSYNC]++;
@@ -822,23 +837,23 @@ static void _chk_btc_err(struct rtw89_dev *rtwdev, u8 type, u32 cnt)
 			dm->cnt_dm[BTC_DCNT_SLOT_NONSYNC] = 0;
 
 		if (dm->cnt_dm[BTC_DCNT_SLOT_NONSYNC] >= BTC_CHK_HANG_MAX)
-			dm->error.map.tdma_no_sync = true;
+			dm->error.map.slot_no_sync = true;
 		else
-			dm->error.map.tdma_no_sync = false;
+			dm->error.map.slot_no_sync = false;
 		break;
-	case BTC_DCNT_BTCNT_FREEZE:
+	case BTC_DCNT_BTCNT_HANG:
 		cnt = cx->cnt_bt[BTC_BCNT_HIPRI_RX] +
 		      cx->cnt_bt[BTC_BCNT_HIPRI_TX] +
 		      cx->cnt_bt[BTC_BCNT_LOPRI_RX] +
 		      cx->cnt_bt[BTC_BCNT_LOPRI_TX];
 
 		if (cnt == 0)
-			dm->cnt_dm[BTC_DCNT_BTCNT_FREEZE]++;
+			dm->cnt_dm[BTC_DCNT_BTCNT_HANG]++;
 		else
-			dm->cnt_dm[BTC_DCNT_BTCNT_FREEZE] = 0;
+			dm->cnt_dm[BTC_DCNT_BTCNT_HANG] = 0;
 
-		if ((dm->cnt_dm[BTC_DCNT_BTCNT_FREEZE] >= BTC_CHK_HANG_MAX &&
-		     bt->enable.now) || (!dm->cnt_dm[BTC_DCNT_BTCNT_FREEZE] &&
+		if ((dm->cnt_dm[BTC_DCNT_BTCNT_HANG] >= BTC_CHK_HANG_MAX &&
+		     bt->enable.now) || (!dm->cnt_dm[BTC_DCNT_BTCNT_HANG] &&
 		     !bt->enable.now))
 			_update_bt_scbd(rtwdev, false);
 		break;
@@ -853,6 +868,18 @@ static void _chk_btc_err(struct rtw89_dev *rtwdev, u8 type, u32 cnt)
 		else
 			dm->error.map.wl_slot_drift = false;
 		break;
+	case BTC_DCNT_BT_SLOT_DRIFT:
+		if (cnt >= BTC_CHK_BTSLOT_DRIFT_MAX)
+			dm->cnt_dm[BTC_DCNT_BT_SLOT_DRIFT]++;
+		else
+			dm->cnt_dm[BTC_DCNT_BT_SLOT_DRIFT] = 0;
+
+		if (dm->cnt_dm[BTC_DCNT_BT_SLOT_DRIFT] >= BTC_CHK_HANG_MAX)
+			dm->error.map.bt_slot_drift = true;
+		else
+			dm->error.map.bt_slot_drift = false;
+
+		break;
 	}
 }
 
@@ -1129,14 +1156,14 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			wl->ver_info.fw = prpt->v1.wl_fw_ver;
 			dm->wl_fw_cx_offload = !!prpt->v1.wl_fw_cx_offload;
 
-			_chk_btc_err(rtwdev, BTC_DCNT_RPT_FREEZE,
+			_chk_btc_err(rtwdev, BTC_DCNT_RPT_HANG,
 				     pfwinfo->event[BTF_EVNT_RPT]);
 
 			/* To avoid I/O if WL LPS or power-off */
 			if (wl->status.map.lps != BTC_LPS_RF_OFF &&
 			    !wl->status.map.rf_off) {
 				rtwdev->chip->ops->btc_update_bt_cnt(rtwdev);
-				_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_FREEZE, 0);
+				_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_HANG, 0);
 
 				btc->cx.cnt_bt[BTC_BCNT_POLUT] =
 					rtw89_mac_get_plt_cnt(rtwdev,
@@ -1164,8 +1191,8 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			btc->cx.cnt_bt[BTC_BCNT_POLUT] =
 				le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_POLLUTED]);
 
-			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_FREEZE, 0);
-			_chk_btc_err(rtwdev, BTC_DCNT_RPT_FREEZE,
+			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_HANG, 0);
+			_chk_btc_err(rtwdev, BTC_DCNT_RPT_HANG,
 				     pfwinfo->event[BTF_EVNT_RPT]);
 
 			if (le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_RFK_TIMEOUT]) > 0)
@@ -1196,8 +1223,8 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			btc->cx.cnt_bt[BTC_BCNT_POLUT] =
 				le16_to_cpu(prpt->v5.bt_cnt[BTC_BCNT_POLLUTED]);
 
-			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_FREEZE, 0);
-			_chk_btc_err(rtwdev, BTC_DCNT_RPT_FREEZE,
+			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_HANG, 0);
+			_chk_btc_err(rtwdev, BTC_DCNT_RPT_HANG,
 				     pfwinfo->event[BTF_EVNT_RPT]);
 
 			dm->error.map.bt_rfk_timeout = bt->rfk_info.map.timeout;
@@ -1258,11 +1285,11 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 					     BTC_DCNT_WL_SLOT_DRIFT, diff_t);
 			}
 
-			_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE,
+			_chk_btc_err(rtwdev, BTC_DCNT_W1_HANG,
 				     le32_to_cpu(pcysta->v2.slot_cnt[CXST_W1]));
-			_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE,
+			_chk_btc_err(rtwdev, BTC_DCNT_W1_HANG,
 				     le32_to_cpu(pcysta->v2.slot_cnt[CXST_B1]));
-			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE,
+			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_HANG,
 				     le16_to_cpu(pcysta->v2.cycles));
 		} else if (ver->fcxcysta == 3) {
 			if (le16_to_cpu(pcysta->v3.cycles) < BTC_CYSTA_CHK_PERIOD)
@@ -1299,11 +1326,11 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				}
 			}
 
-			_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE,
+			_chk_btc_err(rtwdev, BTC_DCNT_W1_HANG,
 				     le32_to_cpu(pcysta->v3.slot_cnt[CXST_W1]));
-			_chk_btc_err(rtwdev, BTC_DCNT_B1_FREEZE,
+			_chk_btc_err(rtwdev, BTC_DCNT_B1_HANG,
 				     le32_to_cpu(pcysta->v3.slot_cnt[CXST_B1]));
-			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE,
+			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_HANG,
 				     le16_to_cpu(pcysta->v3.cycles));
 		} else if (ver->fcxcysta == 4) {
 			if (le16_to_cpu(pcysta->v4.cycles) < BTC_CYSTA_CHK_PERIOD)
@@ -1341,11 +1368,11 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				}
 			}
 
-			_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE,
+			_chk_btc_err(rtwdev, BTC_DCNT_W1_HANG,
 				     le16_to_cpu(pcysta->v4.slot_cnt[CXST_W1]));
-			_chk_btc_err(rtwdev, BTC_DCNT_B1_FREEZE,
+			_chk_btc_err(rtwdev, BTC_DCNT_B1_HANG,
 				     le16_to_cpu(pcysta->v4.slot_cnt[CXST_B1]));
-			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE,
+			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_HANG,
 				     le16_to_cpu(pcysta->v4.cycles));
 		} else {
 			goto err;
@@ -4578,7 +4605,7 @@ static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update)
 	}
 
 	if (!(val & BTC_BSCB_ON) ||
-	    btc->dm.cnt_dm[BTC_DCNT_BTCNT_FREEZE] >= BTC_CHK_HANG_MAX)
+	    btc->dm.cnt_dm[BTC_DCNT_BTCNT_HANG] >= BTC_CHK_HANG_MAX)
 		bt->enable.now = 0;
 	else
 		bt->enable.now = 1;
@@ -5349,7 +5376,7 @@ void rtw89_btc_ntfy_radio_state(struct rtw89_dev *rtwdev, enum btc_rfctrl rf_sta
 			_write_scbd(rtwdev, BTC_WSCB_ALL, false);
 	}
 
-	btc->dm.cnt_dm[BTC_DCNT_BTCNT_FREEZE] = 0;
+	btc->dm.cnt_dm[BTC_DCNT_BTCNT_HANG] = 0;
 	if (wl->status.map.lps_pre == BTC_LPS_OFF &&
 	    wl->status.map.lps_pre != wl->status.map.lps)
 		btc->dm.tdma_instant_excute = 1;
@@ -5700,11 +5727,6 @@ static void _show_cx_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	seq_printf(m, " %-15s : Coex:%d.%d.%d(branch:%d), ",
 		   "[coex_version]", ver_main, ver_sub, ver_hotfix, id_branch);
 
-	if (dm->wl_fw_cx_offload != BTC_CX_FW_OFFLOAD)
-		dm->error.map.offload_mismatch = true;
-	else
-		dm->error.map.offload_mismatch = false;
-
 	ver_main = FIELD_GET(GENMASK(31, 24), wl->ver_info.fw_coex);
 	ver_sub = FIELD_GET(GENMASK(23, 16), wl->ver_info.fw_coex);
 	ver_hotfix = FIELD_GET(GENMASK(15, 8), wl->ver_info.fw_coex);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b1a886898c5a0..77e3c5c283c1f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -883,20 +883,24 @@ enum rtw89_btc_dcnt {
 	BTC_DCNT_RUN = 0x0,
 	BTC_DCNT_CX_RUNINFO,
 	BTC_DCNT_RPT,
-	BTC_DCNT_RPT_FREEZE,
+	BTC_DCNT_RPT_HANG,
 	BTC_DCNT_CYCLE,
-	BTC_DCNT_CYCLE_FREEZE,
+	BTC_DCNT_CYCLE_HANG,
 	BTC_DCNT_W1,
-	BTC_DCNT_W1_FREEZE,
+	BTC_DCNT_W1_HANG,
 	BTC_DCNT_B1,
-	BTC_DCNT_B1_FREEZE,
+	BTC_DCNT_B1_HANG,
 	BTC_DCNT_TDMA_NONSYNC,
 	BTC_DCNT_SLOT_NONSYNC,
-	BTC_DCNT_BTCNT_FREEZE,
+	BTC_DCNT_BTCNT_HANG,
 	BTC_DCNT_WL_SLOT_DRIFT,
-	BTC_DCNT_BT_SLOT_DRIFT,
 	BTC_DCNT_WL_STA_LAST,
-	BTC_DCNT_NUM,
+	BTC_DCNT_BT_SLOT_DRIFT,
+	BTC_DCNT_BT_SLOT_FLOOD,
+	BTC_DCNT_FDDT_TRIG,
+	BTC_DCNT_E2G,
+	BTC_DCNT_E2G_HANG,
+	BTC_DCNT_NUM
 };
 
 enum rtw89_btc_wl_state_cnt {
@@ -1302,15 +1306,22 @@ struct rtw89_btc_dm_emap {
 	u32 pta_owner: 1;
 	u32 wl_rfk_timeout: 1;
 	u32 bt_rfk_timeout: 1;
-
 	u32 wl_fw_hang: 1;
-	u32 offload_mismatch: 1;
 	u32 cycle_hang: 1;
 	u32 w1_hang: 1;
-
 	u32 b1_hang: 1;
 	u32 tdma_no_sync: 1;
+	u32 slot_no_sync: 1;
 	u32 wl_slot_drift: 1;
+	u32 bt_slot_drift: 1;
+	u32 role_num_mismatch: 1;
+	u32 null1_tx_late: 1;
+	u32 bt_afh_conflict: 1;
+	u32 bt_leafh_conflict: 1;
+	u32 bt_slot_flood: 1;
+	u32 wl_e2g_hang: 1;
+	u32 wl_ver_mismatch: 1;
+	u32 bt_ver_mismatch: 1;
 };
 
 union rtw89_btc_dm_error_map {
-- 
2.25.1

