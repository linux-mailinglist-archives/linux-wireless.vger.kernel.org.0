Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFED6AFE6C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 06:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjCHFdv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 00:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCHFdu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 00:33:50 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A471C96F27
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 21:33:46 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3285XU4W0016699, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3285XU4W0016699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 8 Mar 2023 13:33:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 8 Mar 2023 13:33:33 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 8 Mar 2023
 13:33:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/7] wifi: rtw89: coex: Add v5 firmware cycle status report
Date:   Wed, 8 Mar 2023 13:32:25 +0800
Message-ID: <20230308053225.24377-8-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

To support v5 version firmware cycle report, apply the related structure
and functions. v5 cycle report add a group of status to show how the
free-run/TDMA training goes to. It is a firmware mechanism that can auto
adjust coexistence mode between TDMA and free run mechanism at 3 antenna
solution. v5 version provide more reference data to let the mechanism
make decision.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 194 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/coex.h |   5 +
 drivers/net/wireless/realtek/rtw89/core.h |  52 ++++++
 3 files changed, 249 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index b867e54feb896..3dbd4ee14c70d 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -987,8 +987,8 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	void *rpt_content = NULL, *pfinfo = NULL;
 	u8 rpt_type = 0;
 	u16 wl_slot_set = 0, wl_slot_real = 0;
-	u32 trace_step = btc->ctrl.trace_step, rpt_len = 0, diff_t;
-	u32 cnt_leak_slot = 0, bt_slot_real = 0, cnt_rx_imr = 0;
+	u32 trace_step = btc->ctrl.trace_step, rpt_len = 0, diff_t = 0;
+	u32 cnt_leak_slot, bt_slot_real, bt_slot_set, cnt_rx_imr;
 	u8 i;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -1061,6 +1061,10 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo.v4;
 			pcysta->v4 = pfwinfo->rpt_fbtc_cysta.finfo.v4;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo.v4);
+		} else if (ver->fcxcysta == 5) {
+			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo.v5;
+			pcysta->v5 = pfwinfo->rpt_fbtc_cysta.finfo.v5;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo.v5);
 		} else {
 			goto err;
 		}
@@ -1406,6 +1410,54 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				     le16_to_cpu(pcysta->v4.slot_cnt[CXST_B1]));
 			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_HANG,
 				     le16_to_cpu(pcysta->v4.cycles));
+		} else if (ver->fcxcysta == 5) {
+			if (dm->fddt_train == BTC_FDDT_ENABLE)
+				break;
+			cnt_leak_slot = le16_to_cpu(pcysta->v5.slot_cnt[CXST_LK]);
+			cnt_rx_imr = le32_to_cpu(pcysta->v5.leak_slot.cnt_rximr);
+
+			/* Check Leak-AP */
+			if (cnt_leak_slot != 0 && cnt_rx_imr != 0 &&
+			    dm->tdma_now.rxflctrl) {
+				if (le16_to_cpu(pcysta->v5.cycles) >= BTC_CYSTA_CHK_PERIOD &&
+				    cnt_leak_slot < BTC_LEAK_AP_TH * cnt_rx_imr)
+					dm->leak_ap = 1;
+			}
+
+			/* Check diff time between real WL slot and W1 slot */
+			if (dm->tdma_now.type == CXTDMA_OFF) {
+				wl_slot_set = le16_to_cpu(dm->slot_now[CXST_W1].dur);
+				wl_slot_real = le16_to_cpu(pcysta->v5.cycle_time.tavg[CXT_WL]);
+
+				if (wl_slot_real > wl_slot_set)
+					diff_t = wl_slot_real - wl_slot_set;
+				else
+					diff_t = wl_slot_set - wl_slot_real;
+			}
+			_chk_btc_err(rtwdev, BTC_DCNT_WL_SLOT_DRIFT, diff_t);
+
+			/* Check diff time between real BT slot and EBT/E5G slot */
+			bt_slot_set = btc->bt_req_len;
+			bt_slot_real = le16_to_cpu(pcysta->v5.cycle_time.tavg[CXT_BT]);
+			diff_t = 0;
+			if (dm->tdma_now.type == CXTDMA_OFF &&
+			    dm->tdma_now.ext_ctrl == CXECTL_EXT &&
+			    bt_slot_set != 0) {
+				if (bt_slot_set > bt_slot_real)
+					diff_t = bt_slot_set - bt_slot_real;
+				else
+					diff_t = bt_slot_real - bt_slot_set;
+			}
+
+			_chk_btc_err(rtwdev, BTC_DCNT_BT_SLOT_DRIFT, diff_t);
+			_chk_btc_err(rtwdev, BTC_DCNT_E2G_HANG,
+				     le16_to_cpu(pcysta->v5.slot_cnt[CXST_E2G]));
+			_chk_btc_err(rtwdev, BTC_DCNT_W1_HANG,
+				     le16_to_cpu(pcysta->v5.slot_cnt[CXST_W1]));
+			_chk_btc_err(rtwdev, BTC_DCNT_B1_HANG,
+				     le16_to_cpu(pcysta->v5.slot_cnt[CXST_B1]));
+			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_HANG,
+				     le16_to_cpu(pcysta->v5.cycles));
 		} else {
 			goto err;
 		}
@@ -5039,6 +5091,7 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	}
 
 	dm->cnt_dm[BTC_DCNT_RUN]++;
+	dm->fddt_train = BTC_FDDT_DISABLE;
 
 	if (btc->ctrl.always_freerun) {
 		_action_freerun(rtwdev);
@@ -6727,6 +6780,10 @@ static void _show_error(struct rtw89_dev *rtwdev, struct seq_file *m)
 		pcysta->v4 = pfwinfo->rpt_fbtc_cysta.finfo.v4;
 		except_cnt = pcysta->v4.except_cnt;
 		exception_map = le32_to_cpu(pcysta->v4.except_map);
+	} else if (ver->fcxcysta == 5) {
+		pcysta->v5 = pfwinfo->rpt_fbtc_cysta.finfo.v5;
+		except_cnt = pcysta->v5.except_cnt;
+		exception_map = le32_to_cpu(pcysta->v5.except_map);
 	} else {
 		return;
 	}
@@ -7215,6 +7272,137 @@ static void _show_fbtc_cysta_v4(struct rtw89_dev *rtwdev, struct seq_file *m)
 	}
 }
 
+static void _show_fbtc_cysta_v5(struct rtw89_dev *rtwdev, struct seq_file *m)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
+	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_fbtc_a2dp_trx_stat_v4 *a2dp_trx;
+	struct rtw89_btc_fbtc_cysta_v5 *pcysta;
+	struct rtw89_btc_rpt_cmn_info *pcinfo;
+	u8 i, cnt = 0, slot_pair, divide_cnt;
+	u16 cycle, c_begin, c_end, store_index;
+
+	pcinfo = &pfwinfo->rpt_fbtc_cysta.cinfo;
+	if (!pcinfo->valid)
+		return;
+
+	pcysta = &pfwinfo->rpt_fbtc_cysta.finfo.v5;
+	seq_printf(m,
+		   " %-15s : cycle:%d, bcn[all:%d/all_ok:%d/bt:%d/bt_ok:%d]",
+		   "[cycle_cnt]",
+		   le16_to_cpu(pcysta->cycles),
+		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_ALL]),
+		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_ALL_OK]),
+		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_BT_SLOT]),
+		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_BT_OK]));
+
+	for (i = 0; i < CXST_MAX; i++) {
+		if (!le16_to_cpu(pcysta->slot_cnt[i]))
+			continue;
+
+		seq_printf(m, ", %s:%d", id_to_slot(i),
+			   le16_to_cpu(pcysta->slot_cnt[i]));
+	}
+
+	if (dm->tdma_now.rxflctrl)
+		seq_printf(m, ", leak_rx:%d",
+			   le32_to_cpu(pcysta->leak_slot.cnt_rximr));
+
+	if (pcysta->collision_cnt)
+		seq_printf(m, ", collision:%d", pcysta->collision_cnt);
+
+	if (le16_to_cpu(pcysta->skip_cnt))
+		seq_printf(m, ", skip:%d",
+			   le16_to_cpu(pcysta->skip_cnt));
+
+	seq_puts(m, "\n");
+
+	seq_printf(m, " %-15s : avg_t[wl:%d/bt:%d/lk:%d.%03d]",
+		   "[cycle_time]",
+		   le16_to_cpu(pcysta->cycle_time.tavg[CXT_WL]),
+		   le16_to_cpu(pcysta->cycle_time.tavg[CXT_BT]),
+		   le16_to_cpu(pcysta->leak_slot.tavg) / 1000,
+		   le16_to_cpu(pcysta->leak_slot.tavg) % 1000);
+	seq_printf(m,
+		   ", max_t[wl:%d/bt:%d/lk:%d.%03d]\n",
+		   le16_to_cpu(pcysta->cycle_time.tmax[CXT_WL]),
+		   le16_to_cpu(pcysta->cycle_time.tmax[CXT_BT]),
+		   le16_to_cpu(pcysta->leak_slot.tmax) / 1000,
+		   le16_to_cpu(pcysta->leak_slot.tmax) % 1000);
+
+	cycle = le16_to_cpu(pcysta->cycles);
+	if (cycle <= 1)
+		return;
+
+	/* 1 cycle record 1 wl-slot and 1 bt-slot */
+	slot_pair = BTC_CYCLE_SLOT_MAX / 2;
+
+	if (cycle <= slot_pair)
+		c_begin = 1;
+	else
+		c_begin = cycle - slot_pair + 1;
+
+	c_end = cycle;
+
+	if (a2dp->exist)
+		divide_cnt = 3;
+	else
+		divide_cnt = BTC_CYCLE_SLOT_MAX / 4;
+
+	if (c_begin > c_end)
+		return;
+
+	for (cycle = c_begin; cycle <= c_end; cycle++) {
+		cnt++;
+		store_index = ((cycle - 1) % slot_pair) * 2;
+
+		if (cnt % divide_cnt == 1)
+			seq_printf(m, " %-15s : ", "[cycle_step]");
+
+		seq_printf(m, "->b%02d",
+			   le16_to_cpu(pcysta->slot_step_time[store_index]));
+		if (a2dp->exist) {
+			a2dp_trx = &pcysta->a2dp_trx[store_index];
+			seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
+				   a2dp_trx->empty_cnt,
+				   a2dp_trx->retry_cnt,
+				   a2dp_trx->tx_rate ? 3 : 2,
+				   a2dp_trx->tx_cnt,
+				   a2dp_trx->ack_cnt,
+				   a2dp_trx->nack_cnt);
+		}
+		seq_printf(m, "->w%02d",
+			   le16_to_cpu(pcysta->slot_step_time[store_index + 1]));
+		if (a2dp->exist) {
+			a2dp_trx = &pcysta->a2dp_trx[store_index + 1];
+			seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
+				   a2dp_trx->empty_cnt,
+				   a2dp_trx->retry_cnt,
+				   a2dp_trx->tx_rate ? 3 : 2,
+				   a2dp_trx->tx_cnt,
+				   a2dp_trx->ack_cnt,
+				   a2dp_trx->nack_cnt);
+		}
+		if (cnt % divide_cnt == 0 || cnt == c_end)
+			seq_puts(m, "\n");
+	}
+
+	if (a2dp->exist) {
+		seq_printf(m, " %-15s : a2dp_ept:%d, a2dp_late:%d",
+			   "[a2dp_t_sta]",
+			   le16_to_cpu(pcysta->a2dp_ept.cnt),
+			   le16_to_cpu(pcysta->a2dp_ept.cnt_timeout));
+
+		seq_printf(m, ", avg_t:%d, max_t:%d",
+			   le16_to_cpu(pcysta->a2dp_ept.tavg),
+			   le16_to_cpu(pcysta->a2dp_ept.tmax));
+
+		seq_puts(m, "\n");
+	}
+}
+
 static void _show_fbtc_nullsta(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -7419,6 +7607,8 @@ static void _show_fw_dm_msg(struct rtw89_dev *rtwdev, struct seq_file *m)
 		_show_fbtc_cysta_v3(rtwdev, m);
 	else if (ver->fcxcysta == 4)
 		_show_fbtc_cysta_v4(rtwdev, m);
+	else if (ver->fcxcysta == 5)
+		_show_fbtc_cysta_v5(rtwdev, m);
 
 	_show_fbtc_nullsta(rtwdev, m);
 
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 401fb55df82b0..38cc53a505c36 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -66,6 +66,11 @@ enum btc_rssi_st {
 	BTC_RSSI_ST_MAX
 };
 
+enum btc_fddt_en {
+	BTC_FDDT_DISABLE,
+	BTC_FDDT_ENABLE,
+};
+
 #define	BTC_RSSI_HIGH(_rssi_) \
 	({typeof(_rssi_) __rssi = (_rssi_); \
 	  ((__rssi == BTC_RSSI_ST_HIGH || \
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d785d1326e498..4582cd5c66284 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1894,6 +1894,11 @@ struct rtw89_btc_fbtc_cycle_time_info {
 	__le16 tmaxdiff[CXT_MAX]; /* max wl-wl bt-bt cycle diff time */
 } __packed;
 
+struct rtw89_btc_fbtc_cycle_time_info_v5 {
+	__le16 tavg[CXT_MAX]; /* avg wl/bt cycle time */
+	__le16 tmax[CXT_MAX]; /* max wl/bt cycle time */
+} __packed;
+
 struct rtw89_btc_fbtc_a2dp_trx_stat {
 	u8 empty_cnt;
 	u8 retry_cnt;
@@ -1950,6 +1955,21 @@ struct rtw89_btc_fbtc_cycle_fddt_info {
 #define RTW89_BTC_FDDT_CELL_TRAIN_STATE GENMASK(3, 0)
 #define RTW89_BTC_FDDT_CELL_TRAIN_PHASE GENMASK(7, 4)
 
+struct rtw89_btc_fbtc_cycle_fddt_info_v5 {
+	__le16 train_cycle;
+	__le16 tp;
+
+	s8 tx_power; /* absolute Tx power (dBm), 0xff-> no BTC control */
+	s8 bt_tx_power; /* decrease Tx power (dB) */
+	s8 bt_rx_gain;  /* LNA constrain level */
+	u8 no_empty_cnt;
+
+	u8 rssi; /* [7:4] -> bt_rssi_level, [3:0]-> wl_rssi_level */
+	u8 cn; /* condition_num */
+	u8 train_status; /* [7:4]-> train-state, [3:0]-> train-phase */
+	u8 train_result; /* refer to enum btc_fddt_check_map */
+} __packed;
+
 struct rtw89_btc_fbtc_fddt_cell_status {
 	s8 wl_tx_pwr;
 	s8 bt_tx_pwr;
@@ -1957,6 +1977,12 @@ struct rtw89_btc_fbtc_fddt_cell_status {
 	u8 state_phase; /* [0:3] train state, [4:7] train phase */
 } __packed;
 
+struct rtw89_btc_fbtc_fddt_cell_status_v5 {
+	s8 wl_tx_pwr;
+	s8 bt_tx_pwr;
+	s8 bt_rx_gain;
+} __packed;
+
 struct rtw89_btc_fbtc_cysta_v3 { /* statistics for cycles */
 	u8 fver;
 	u8 rsvd;
@@ -2002,10 +2028,35 @@ struct rtw89_btc_fbtc_cysta_v4 { /* statistics for cycles */
 	__le32 except_map;
 } __packed;
 
+struct rtw89_btc_fbtc_cysta_v5 { /* statistics for cycles */
+	u8 fver;
+	u8 rsvd;
+	u8 collision_cnt; /* counter for event/timer occur at the same time */
+	u8 except_cnt;
+	u8 wl_rx_err_ratio[BTC_CYCLE_SLOT_MAX];
+
+	__le16 skip_cnt;
+	__le16 cycles; /* total cycle number */
+
+	__le16 slot_step_time[BTC_CYCLE_SLOT_MAX]; /* record the wl/bt slot time */
+	__le16 slot_cnt[CXST_MAX]; /* slot count */
+	__le16 bcn_cnt[CXBCN_MAX];
+	struct rtw89_btc_fbtc_cycle_time_info_v5 cycle_time;
+	struct rtw89_btc_fbtc_cycle_leak_info leak_slot;
+	struct rtw89_btc_fbtc_cycle_a2dp_empty_info a2dp_ept;
+	struct rtw89_btc_fbtc_a2dp_trx_stat_v4 a2dp_trx[BTC_CYCLE_SLOT_MAX];
+	struct rtw89_btc_fbtc_cycle_fddt_info_v5 fddt_trx[BTC_CYCLE_SLOT_MAX];
+	struct rtw89_btc_fbtc_fddt_cell_status_v5 fddt_cells[FDD_TRAIN_WL_DIRECTION]
+							    [FDD_TRAIN_WL_RSSI_LEVEL]
+							    [FDD_TRAIN_BT_RSSI_LEVEL];
+	__le32 except_map;
+} __packed;
+
 union rtw89_btc_fbtc_cysta_info {
 	struct rtw89_btc_fbtc_cysta_v2 v2;
 	struct rtw89_btc_fbtc_cysta_v3 v3;
 	struct rtw89_btc_fbtc_cysta_v4 v4;
+	struct rtw89_btc_fbtc_cysta_v5 v5;
 };
 
 struct rtw89_btc_fbtc_cynullsta_v1 { /* cycle null statistics */
@@ -2123,6 +2174,7 @@ struct rtw89_btc_dm {
 	u32 wl_only: 1;
 	u32 wl_fw_cx_offload: 1;
 	u32 freerun: 1;
+	u32 fddt_train: 1;
 	u32 wl_ps_ctrl: 2;
 	u32 wl_mimo_ps: 1;
 	u32 leak_ap: 1;
-- 
2.25.1

