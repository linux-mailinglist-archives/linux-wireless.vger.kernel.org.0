Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E115B65C166
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 15:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbjACODp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 09:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbjACODY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 09:03:24 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44D59101DE
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 06:03:20 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 303E2CyW4016732, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 303E2CyW4016732
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 3 Jan 2023 22:02:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 3 Jan 2023 22:03:08 +0800
Received: from localhost (172.16.19.22) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 3 Jan 2023
 22:03:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/7] wifi: rtw89: coex: Add v4 version firmware cycle report
Date:   Tue, 3 Jan 2023 22:02:34 +0800
Message-ID: <20230103140238.15601-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230103140238.15601-1-pkshih@realtek.com>
References: <20230103140238.15601-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.19.22]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/03/2023 13:50:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMyCkVaTIIDAxOjA0OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

To support v4 version firmware cycle report, apply the related
structure and functions. v4 cycle report add a group of status
to show how the free-run/TDMA training goes to. It is a firmware
mechanism that can auto adjust coexistence mode between TDMA and
free run mechanism at 3 antenna solution.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 185 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  67 ++++++++
 2 files changed, 252 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index be5ab2c4eefb3..b25329d1806a4 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1001,6 +1001,10 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo.v3;
 			pcysta->v3 = pfwinfo->rpt_fbtc_cysta.finfo.v3;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo.v3);
+		} else if (ver->fcxcysta == 4) {
+			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo.v4;
+			pcysta->v4 = pfwinfo->rpt_fbtc_cysta.finfo.v4;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo.v4);
 		} else {
 			goto err;
 		}
@@ -1259,6 +1263,48 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				     le32_to_cpu(pcysta->v3.slot_cnt[CXST_B1]));
 			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE,
 				     le16_to_cpu(pcysta->v3.cycles));
+		} else if (ver->fcxcysta == 4) {
+			if (le16_to_cpu(pcysta->v4.cycles) < BTC_CYSTA_CHK_PERIOD)
+				break;
+
+			cnt_leak_slot = le16_to_cpu(pcysta->v4.slot_cnt[CXST_LK]);
+			cnt_rx_imr = le32_to_cpu(pcysta->v4.leak_slot.cnt_rximr);
+
+			/* Check Leak-AP */
+			if (cnt_leak_slot != 0 && cnt_rx_imr != 0 &&
+			    dm->tdma_now.rxflctrl) {
+				if (cnt_leak_slot < BTC_LEAK_AP_TH * cnt_rx_imr)
+					dm->leak_ap = 1;
+			}
+
+			/* Check diff time between real WL slot and W1 slot */
+			if (dm->tdma_now.type == CXTDMA_OFF) {
+				wl_slot_set = le16_to_cpu(dm->slot_now[CXST_W1].dur);
+				wl_slot_real = le16_to_cpu(pcysta->v4.cycle_time.tavg[CXT_WL]);
+				if (wl_slot_real > wl_slot_set) {
+					diff_t = wl_slot_real - wl_slot_set;
+					_chk_btc_err(rtwdev, BTC_DCNT_WL_SLOT_DRIFT, diff_t);
+				}
+			}
+
+			/* Check diff time between real BT slot and EBT/E5G slot */
+			if (dm->tdma_now.type == CXTDMA_OFF &&
+			    dm->tdma_now.ext_ctrl == CXECTL_EXT &&
+			    btc->bt_req_len != 0) {
+				bt_slot_real = le16_to_cpu(pcysta->v4.cycle_time.tavg[CXT_BT]);
+
+				if (btc->bt_req_len > bt_slot_real) {
+					diff_t = btc->bt_req_len - bt_slot_real;
+					_chk_btc_err(rtwdev, BTC_DCNT_BT_SLOT_DRIFT, diff_t);
+				}
+			}
+
+			_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE,
+				     le16_to_cpu(pcysta->v4.slot_cnt[CXST_W1]));
+			_chk_btc_err(rtwdev, BTC_DCNT_B1_FREEZE,
+				     le16_to_cpu(pcysta->v4.slot_cnt[CXST_B1]));
+			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE,
+				     le16_to_cpu(pcysta->v4.cycles));
 		} else {
 			goto err;
 		}
@@ -6178,6 +6224,10 @@ static void _show_error(struct rtw89_dev *rtwdev, struct seq_file *m)
 		pcysta->v3 = pfwinfo->rpt_fbtc_cysta.finfo.v3;
 		except_cnt = le32_to_cpu(pcysta->v3.except_cnt);
 		exception_map = le32_to_cpu(pcysta->v3.except_map);
+	} else if (ver->fcxcysta == 4) {
+		pcysta->v4 = pfwinfo->rpt_fbtc_cysta.finfo.v4;
+		except_cnt = pcysta->v4.except_cnt;
+		exception_map = le32_to_cpu(pcysta->v4.except_map);
 	} else {
 		return;
 	}
@@ -6569,6 +6619,139 @@ static void _show_fbtc_cysta_v3(struct rtw89_dev *rtwdev, struct seq_file *m)
 	}
 }
 
+static void _show_fbtc_cysta_v4(struct rtw89_dev *rtwdev, struct seq_file *m)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
+	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_fbtc_a2dp_trx_stat_v4 *a2dp_trx;
+	struct rtw89_btc_fbtc_cysta_v4 *pcysta;
+	struct rtw89_btc_rpt_cmn_info *pcinfo;
+	u8 i, cnt = 0, slot_pair, divide_cnt;
+	u16 cycle, c_begin, c_end, store_index;
+
+	pcinfo = &pfwinfo->rpt_fbtc_cysta.cinfo;
+	if (!pcinfo->valid)
+		return;
+
+	pcysta = &pfwinfo->rpt_fbtc_cysta.finfo.v4;
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
+		   ", max_t[wl:%d/bt:%d/lk:%d.%03d]",
+		   le16_to_cpu(pcysta->cycle_time.tmax[CXT_WL]),
+		   le16_to_cpu(pcysta->cycle_time.tmax[CXT_BT]),
+		   le16_to_cpu(pcysta->leak_slot.tmax) / 1000,
+		   le16_to_cpu(pcysta->leak_slot.tmax) % 1000);
+	seq_printf(m,
+		   ", maxdiff_t[wl:%d/bt:%d]\n",
+		   le16_to_cpu(pcysta->cycle_time.tmaxdiff[CXT_WL]),
+		   le16_to_cpu(pcysta->cycle_time.tmaxdiff[CXT_BT]));
+
+	cycle = le16_to_cpu(pcysta->cycles);
+	if (cycle == 0)
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
+	for (cycle = c_begin; cycle <= c_end; cycle++) {
+		cnt++;
+		store_index = ((cycle - 1) % slot_pair) * 2;
+
+		if (cnt % divide_cnt == 1) {
+			seq_printf(m, "\n\r %-15s : ", "[cycle_step]");
+		} else {
+			seq_printf(m, "->b%02d",
+				   le16_to_cpu(pcysta->slot_step_time[store_index]));
+			if (a2dp->exist) {
+				a2dp_trx = &pcysta->a2dp_trx[store_index];
+				seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
+					   a2dp_trx->empty_cnt,
+					   a2dp_trx->retry_cnt,
+					   a2dp_trx->tx_rate ? 3 : 2,
+					   a2dp_trx->tx_cnt,
+					   a2dp_trx->ack_cnt,
+					   a2dp_trx->nack_cnt);
+			}
+			seq_printf(m, "->w%02d",
+				   le16_to_cpu(pcysta->slot_step_time[store_index + 1]));
+			if (a2dp->exist) {
+				a2dp_trx = &pcysta->a2dp_trx[store_index + 1];
+				seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
+					   a2dp_trx->empty_cnt,
+					   a2dp_trx->retry_cnt,
+					   a2dp_trx->tx_rate ? 3 : 2,
+					   a2dp_trx->tx_cnt,
+					   a2dp_trx->ack_cnt,
+					   a2dp_trx->nack_cnt);
+			}
+		}
+		if (cnt % (BTC_CYCLE_SLOT_MAX / 4) == 0 || cnt == c_end)
+			seq_puts(m, "\n");
+	}
+
+	if (a2dp->exist) {
+		seq_printf(m, "%-15s : a2dp_ept:%d, a2dp_late:%d",
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
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -6727,6 +6910,8 @@ static void _show_fw_dm_msg(struct rtw89_dev *rtwdev, struct seq_file *m)
 		_show_fbtc_cysta_v2(rtwdev, m);
 	else if (ver->fcxcysta == 3)
 		_show_fbtc_cysta_v3(rtwdev, m);
+	else if (ver->fcxcysta == 4)
+		_show_fbtc_cysta_v4(rtwdev, m);
 
 	_show_fbtc_nullsta(rtwdev, m);
 	_show_fbtc_step(rtwdev, m);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6af70eabb9080..9f4cb83a8326f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1730,6 +1730,17 @@ struct rtw89_btc_fbtc_a2dp_trx_stat {
 	u8 rsvd2;
 } __packed;
 
+struct rtw89_btc_fbtc_a2dp_trx_stat_v4 {
+	u8 empty_cnt;
+	u8 retry_cnt;
+	u8 tx_rate;
+	u8 tx_cnt;
+	u8 ack_cnt;
+	u8 nack_cnt;
+	u8 no_empty_cnt;
+	u8 rsvd;
+} __packed;
+
 struct rtw89_btc_fbtc_cycle_a2dp_empty_info {
 	__le16 cnt; /* a2dp empty cnt */
 	__le16 cnt_timeout; /* a2dp empty timeout cnt*/
@@ -1743,6 +1754,34 @@ struct rtw89_btc_fbtc_cycle_leak_info {
 	__le16 tmax; /* max leak-slot time */
 } __packed;
 
+#define RTW89_BTC_FDDT_PHASE_CYCLE GENMASK(9, 0)
+#define RTW89_BTC_FDDT_TRAIN_STEP GENMASK(15, 10)
+
+struct rtw89_btc_fbtc_cycle_fddt_info {
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
+#define RTW89_BTC_FDDT_CELL_TRAIN_STATE GENMASK(3, 0)
+#define RTW89_BTC_FDDT_CELL_TRAIN_PHASE GENMASK(7, 4)
+
+struct rtw89_btc_fbtc_fddt_cell_status {
+	s8 wl_tx_pwr;
+	s8 bt_tx_pwr;
+	s8 bt_rx_gain;
+	u8 state_phase; /* [0:3] train state, [4:7] train phase */
+} __packed;
+
 struct rtw89_btc_fbtc_cysta_v3 { /* statistics for cycles */
 	u8 fver;
 	u8 rsvd;
@@ -1761,9 +1800,37 @@ struct rtw89_btc_fbtc_cysta_v3 { /* statistics for cycles */
 	__le32 except_map;
 } __packed;
 
+#define FDD_TRAIN_WL_DIRECTION 2
+#define FDD_TRAIN_WL_RSSI_LEVEL 5
+#define FDD_TRAIN_BT_RSSI_LEVEL 5
+
+struct rtw89_btc_fbtc_cysta_v4 { /* statistics for cycles */
+	u8 fver;
+	u8 rsvd;
+	u8 collision_cnt; /* counter for event/timer occur at the same time */
+	u8 except_cnt;
+
+	__le16 skip_cnt;
+	__le16 cycles; /* total cycle number */
+
+	__le16 slot_step_time[BTC_CYCLE_SLOT_MAX]; /* record the wl/bt slot time */
+	__le16 slot_cnt[CXST_MAX]; /* slot count */
+	__le16 bcn_cnt[CXBCN_MAX];
+	struct rtw89_btc_fbtc_cycle_time_info cycle_time;
+	struct rtw89_btc_fbtc_cycle_leak_info leak_slot;
+	struct rtw89_btc_fbtc_cycle_a2dp_empty_info a2dp_ept;
+	struct rtw89_btc_fbtc_a2dp_trx_stat_v4 a2dp_trx[BTC_CYCLE_SLOT_MAX];
+	struct rtw89_btc_fbtc_cycle_fddt_info fddt_trx[BTC_CYCLE_SLOT_MAX];
+	struct rtw89_btc_fbtc_fddt_cell_status fddt_cells[FDD_TRAIN_WL_DIRECTION]
+							 [FDD_TRAIN_WL_RSSI_LEVEL]
+							 [FDD_TRAIN_BT_RSSI_LEVEL];
+	__le32 except_map;
+} __packed;
+
 union rtw89_btc_fbtc_cysta_info {
 	struct rtw89_btc_fbtc_cysta_v2 v2;
 	struct rtw89_btc_fbtc_cysta_v3 v3;
+	struct rtw89_btc_fbtc_cysta_v4 v4;
 };
 
 struct rtw89_btc_fbtc_cynullsta { /* cycle null statistics */
-- 
2.25.1

