Return-Path: <linux-wireless+bounces-6480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580DE8A910D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 04:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35A41F222DA
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 02:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785FA4EB32;
	Thu, 18 Apr 2024 02:12:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BB94E1AD
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 02:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406359; cv=none; b=VH6ua9UnUk0BZRcQcxS7D8VaB2XD4qak84CniPzdi6LuysJK/ED6/PTZbxE+ge+zAOdbvdK+p5rr1wcHIqsqJE2nFP9gficRRU1/A/fzgoOxiYyCqju2ksz8H3qyK4YEq/6t/FyyEgCgVVvm9UpejoaQYRWespw7piJQIYy+Si4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406359; c=relaxed/simple;
	bh=+EWLgX9leW8+ggqd/uUwEDAf7MgUrEM/7pWdB5qNVyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJic0d4GwN3gZu7hRy5r2ov/TaEedh0Vhzunqq9P7RWDDx+m8uAr8V/sFf4oLDiTnjB+FXcnsOrHtHr0G7qNydPfAbIAJHhQKxVgllx2YX1O1SNx8JoGEPsVkN8ucezVnMWUmS4LCfE19LOcfnF8hKR7rs2A/2Gw7aSQpDpQVNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I2CYvQ43994697, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I2CYvQ43994697
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 10:12:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 10:12:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 10:12:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 2/9] wifi: rtw89: coex: Add v7 firmware cycle status report
Date: Thu, 18 Apr 2024 10:12:00 +0800
Message-ID: <20240418021207.32173-3-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

To support v7 version firmware cycle report, which adjusts the structure
variables order, apply the related structure and functions. The cycle
report can show how the firmware mechanism runs.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 193 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/coex.h |   1 +
 drivers/net/wireless/realtek/rtw89/core.h |  38 +++++
 3 files changed, 230 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 8992ee408b7f..3da4f54126dd 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1182,10 +1182,10 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	struct rtw89_btc_prpt *btc_prpt = NULL;
 	void *rpt_content = NULL, *pfinfo = NULL;
 	u8 rpt_type = 0;
-	u16 wl_slot_set = 0, wl_slot_real = 0;
+	u16 wl_slot_set = 0, wl_slot_real = 0, val16;
 	u32 trace_step = 0, rpt_len = 0, diff_t = 0;
 	u32 cnt_leak_slot, bt_slot_real, bt_slot_set, cnt_rx_imr;
-	u8 i, val = 0;
+	u8 i, val = 0, val1, val2;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): index:%d\n",
@@ -1273,6 +1273,10 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo.v5;
 			pcysta->v5 = pfwinfo->rpt_fbtc_cysta.finfo.v5;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo.v5);
+		} else if (ver->fcxcysta == 7) {
+			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo.v7;
+			pcysta->v7 = pfwinfo->rpt_fbtc_cysta.finfo.v7;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo.v7);
 		} else {
 			goto err;
 		}
@@ -1723,6 +1727,55 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				     le16_to_cpu(pcysta->v5.slot_cnt[CXST_B1]));
 			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_HANG,
 				     le16_to_cpu(pcysta->v5.cycles));
+		} else if (ver->fcxcysta == 7) {
+			if (dm->fddt_train == BTC_FDDT_ENABLE)
+				break;
+
+			pcysta = &pfwinfo->rpt_fbtc_cysta.finfo;
+
+			if (dm->tdma_now.type != CXTDMA_OFF) {
+				/* Check diff time between real WL slot and W1 slot */
+				val16 = le16_to_cpu(pcysta->v7.cycle_time.tavg[CXT_WL]);
+				_chk_btc_err(rtwdev, BTC_DCNT_WL_SLOT_DRIFT, val16);
+
+				/* Check Leak-AP */
+				val1 = le32_to_cpu(pcysta->v7.leak_slot.cnt_rximr) *
+				       BTC_LEAK_AP_TH;
+				val2 = le16_to_cpu(pcysta->v7.slot_cnt[CXST_LK]);
+
+				val16 = le16_to_cpu(pcysta->v7.cycles);
+				if (dm->tdma_now.rxflctrl &&
+				    val16 >= BTC_CYSTA_CHK_PERIOD && val1 > val2)
+					dm->leak_ap = 1;
+			} else if (dm->tdma_now.ext_ctrl == CXECTL_EXT) {
+				val16 = le16_to_cpu(pcysta->v7.cycle_time.tavg[CXT_BT]);
+				/* Check diff between real BT slot and EBT/E5G slot */
+				_chk_btc_err(rtwdev, BTC_DCNT_BT_SLOT_DRIFT, val16);
+
+				/* Check bt slot length for P2P mode*/
+				val1 = le16_to_cpu(pcysta->v7.a2dp_ept.cnt_timeout) *
+				       BTC_SLOT_REQ_TH;
+				val2 = le16_to_cpu(pcysta->v7.a2dp_ept.cnt);
+
+				val16 = le16_to_cpu(pcysta->v7.cycles);
+				if (val16 >= BTC_CYSTA_CHK_PERIOD && val1 > val2)
+					dm->slot_req_more = 1;
+				else if (bt->link_info.status.map.connect == 0)
+					dm->slot_req_more = 0;
+			}
+
+			_chk_btc_err(rtwdev, BTC_DCNT_E2G_HANG,
+				     le16_to_cpu(pcysta->v7.slot_cnt[CXST_E2G]));
+			_chk_btc_err(rtwdev, BTC_DCNT_W1_HANG,
+				     le16_to_cpu(pcysta->v7.slot_cnt[CXST_W1]));
+			_chk_btc_err(rtwdev, BTC_DCNT_B1_HANG,
+				     le16_to_cpu(pcysta->v7.slot_cnt[CXST_B1]));
+
+			/* "BT_SLOT_FLOOD" error-check MUST before "CYCLE_HANG" */
+			_chk_btc_err(rtwdev, BTC_DCNT_BT_SLOT_FLOOD,
+				     le16_to_cpu(pcysta->v7.cycles));
+			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_HANG,
+				     le16_to_cpu(pcysta->v7.cycles));
 		} else {
 			goto err;
 		}
@@ -8102,6 +8155,10 @@ static void _show_error(struct rtw89_dev *rtwdev, struct seq_file *m)
 		pcysta->v5 = pfwinfo->rpt_fbtc_cysta.finfo.v5;
 		except_cnt = pcysta->v5.except_cnt;
 		exception_map = le32_to_cpu(pcysta->v5.except_map);
+	} else if (ver->fcxcysta == 7) {
+		pcysta->v7 = pfwinfo->rpt_fbtc_cysta.finfo.v7;
+		except_cnt = pcysta->v7.except_cnt;
+		exception_map = le32_to_cpu(pcysta->v7.except_map);
 	} else {
 		return;
 	}
@@ -8734,6 +8791,136 @@ static void _show_fbtc_cysta_v5(struct rtw89_dev *rtwdev, struct seq_file *m)
 	}
 }
 
+static void _show_fbtc_cysta_v7(struct rtw89_dev *rtwdev, struct seq_file *m)
+{
+	struct rtw89_btc_bt_info *bt = &rtwdev->btc.cx.bt;
+	struct rtw89_btc_bt_a2dp_desc *a2dp = &bt->link_info.a2dp_desc;
+	struct rtw89_btc_btf_fwinfo *pfwinfo = &rtwdev->btc.fwinfo;
+	struct rtw89_btc_fbtc_cysta_v7 *pcysta = NULL;
+	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
+	struct rtw89_btc_rpt_cmn_info *pcinfo;
+	u16 cycle, c_begin, c_end, s_id;
+	u8 i, cnt = 0, divide_cnt;
+	u8 slot_pair;
+
+	pcinfo = &pfwinfo->rpt_fbtc_cysta.cinfo;
+	if (!pcinfo->valid)
+		return;
+
+	pcysta = &pfwinfo->rpt_fbtc_cysta.finfo.v7;
+	seq_printf(m, "\n\r %-15s : cycle:%d", "[slot_stat]",
+		   le16_to_cpu(pcysta->cycles));
+
+	for (i = 0; i < CXST_MAX; i++) {
+		if (!le16_to_cpu(pcysta->slot_cnt[i]))
+			continue;
+		seq_printf(m, ", %s:%d",
+			   id_to_slot(i), le16_to_cpu(pcysta->slot_cnt[i]));
+	}
+
+	if (dm->tdma_now.rxflctrl)
+		seq_printf(m, ", leak_rx:%d",
+			   le32_to_cpu(pcysta->leak_slot.cnt_rximr));
+
+	if (pcysta->collision_cnt)
+		seq_printf(m, ", collision:%d", pcysta->collision_cnt);
+
+	if (pcysta->skip_cnt)
+		seq_printf(m, ", skip:%d", le16_to_cpu(pcysta->skip_cnt));
+
+	seq_printf(m, "\n\r %-15s : avg_t[wl:%d/bt:%d/lk:%d.%03d]",
+		   "[cycle_stat]",
+		   le16_to_cpu(pcysta->cycle_time.tavg[CXT_WL]),
+		   le16_to_cpu(pcysta->cycle_time.tavg[CXT_BT]),
+		   le16_to_cpu(pcysta->leak_slot.tavg) / 1000,
+		   le16_to_cpu(pcysta->leak_slot.tavg) % 1000);
+	seq_printf(m, ", max_t[wl:%d/bt:%d(>%dms:%d)/lk:%d.%03d]",
+		   le16_to_cpu(pcysta->cycle_time.tmax[CXT_WL]),
+		   le16_to_cpu(pcysta->cycle_time.tmax[CXT_BT]),
+		   dm->bt_slot_flood, dm->cnt_dm[BTC_DCNT_BT_SLOT_FLOOD],
+		   le16_to_cpu(pcysta->leak_slot.tamx) / 1000,
+		   le16_to_cpu(pcysta->leak_slot.tamx) % 1000);
+	seq_printf(m, ", bcn[all:%d/ok:%d/in_bt:%d/in_bt_ok:%d]",
+		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_ALL]),
+		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_ALL_OK]),
+		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_BT_SLOT]),
+		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_BT_OK]));
+
+	if (a2dp->exist) {
+		seq_printf(m,
+			   "\n\r %-15s : a2dp_ept:%d, a2dp_late:%d(streak 2S:%d/max:%d)",
+			   "[a2dp_stat]",
+			   le16_to_cpu(pcysta->a2dp_ept.cnt),
+			   le16_to_cpu(pcysta->a2dp_ept.cnt_timeout),
+			   a2dp->no_empty_streak_2s, a2dp->no_empty_streak_max);
+
+		seq_printf(m, ", avg_t:%d, max_t:%d",
+			   le16_to_cpu(pcysta->a2dp_ept.tavg),
+			   le16_to_cpu(pcysta->a2dp_ept.tmax));
+	}
+
+	if (le16_to_cpu(pcysta->cycles) <= 1)
+		return;
+
+	/* 1 cycle = 1 wl-slot + 1 bt-slot */
+	slot_pair = BTC_CYCLE_SLOT_MAX / 2;
+
+	if (le16_to_cpu(pcysta->cycles) <= slot_pair)
+		c_begin = 1;
+	else
+		c_begin = le16_to_cpu(pcysta->cycles) - slot_pair + 1;
+
+	c_end = le16_to_cpu(pcysta->cycles);
+
+	if (a2dp->exist)
+		divide_cnt = 2;
+	else
+		divide_cnt = 6;
+
+	if (c_begin > c_end)
+		return;
+
+	for (cycle = c_begin; cycle <= c_end; cycle++) {
+		cnt++;
+		s_id = ((cycle - 1) % slot_pair) * 2;
+
+		if (cnt % divide_cnt == 1) {
+			if (a2dp->exist)
+				seq_printf(m, "\n\r %-15s : ", "[slotT_wermtan]");
+			else
+				seq_printf(m, "\n\r %-15s : ", "[slotT_rxerr]");
+		}
+
+		seq_printf(m, "->b%d", le16_to_cpu(pcysta->slot_step_time[s_id]));
+
+		if (a2dp->exist)
+			seq_printf(m, "(%d/%d/%d/%dM/%d/%d/%d)",
+				   pcysta->wl_rx_err_ratio[s_id],
+				   pcysta->a2dp_trx[s_id].empty_cnt,
+				   pcysta->a2dp_trx[s_id].retry_cnt,
+				   (pcysta->a2dp_trx[s_id].tx_rate ? 3 : 2),
+				   pcysta->a2dp_trx[s_id].tx_cnt,
+				   pcysta->a2dp_trx[s_id].ack_cnt,
+				   pcysta->a2dp_trx[s_id].nack_cnt);
+		else
+			seq_printf(m, "(%d)", pcysta->wl_rx_err_ratio[s_id]);
+
+		seq_printf(m, "->w%d", le16_to_cpu(pcysta->slot_step_time[s_id + 1]));
+
+		if (a2dp->exist)
+			seq_printf(m, "(%d/%d/%d/%dM/%d/%d/%d)",
+				   pcysta->wl_rx_err_ratio[s_id + 1],
+				   pcysta->a2dp_trx[s_id + 1].empty_cnt,
+				   pcysta->a2dp_trx[s_id + 1].retry_cnt,
+				   (pcysta->a2dp_trx[s_id + 1].tx_rate ? 3 : 2),
+				   pcysta->a2dp_trx[s_id + 1].tx_cnt,
+				   pcysta->a2dp_trx[s_id + 1].ack_cnt,
+				   pcysta->a2dp_trx[s_id + 1].nack_cnt);
+		else
+			seq_printf(m, "(%d)", pcysta->wl_rx_err_ratio[s_id + 1]);
+	}
+}
+
 static void _show_fbtc_nullsta(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -8946,6 +9133,8 @@ static void _show_fw_dm_msg(struct rtw89_dev *rtwdev, struct seq_file *m)
 		_show_fbtc_cysta_v4(rtwdev, m);
 	else if (ver->fcxcysta == 5)
 		_show_fbtc_cysta_v5(rtwdev, m);
+	else if (ver->fcxcysta == 7)
+		_show_fbtc_cysta_v7(rtwdev, m);
 
 	_show_fbtc_nullsta(rtwdev, m);
 
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 43c5e3626121..34771181f496 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -9,6 +9,7 @@
 
 #define BTC_H2C_MAXLEN 2020
 #define BTC_TLV_SLOT_ID_LEN_V7 1
+#define BTC_SLOT_REQ_TH 2
 
 enum btc_mode {
 	BTC_MODE_NORMAL,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 635100f1c739..43f42774eccc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1435,6 +1435,11 @@ struct rtw89_btc_bt_a2dp_desc {
 	u8 type: 3;
 	u8 active: 1;
 	u8 sink: 1;
+	u32 handle_update: 1;
+	u32 devinfo_query: 1;
+	u32 no_empty_streak_2s: 8;
+	u32 no_empty_streak_max: 8;
+	u32 rsvd: 6;
 
 	u8 bitpool;
 	u16 vendor_id;
@@ -2437,6 +2442,12 @@ struct rtw89_btc_fbtc_cycle_leak_info {
 	__le16 tmax; /* max leak-slot time */
 } __packed;
 
+struct rtw89_btc_fbtc_cycle_leak_info_v7 {
+	__le16 tavg;
+	__le16 tamx;
+	__le32 cnt_rximr;
+} __packed;
+
 #define RTW89_BTC_FDDT_PHASE_CYCLE GENMASK(9, 0)
 #define RTW89_BTC_FDDT_TRAIN_STEP GENMASK(15, 10)
 
@@ -2549,11 +2560,36 @@ struct rtw89_btc_fbtc_cysta_v5 { /* statistics for cycles */
 	__le32 except_map;
 } __packed;
 
+struct rtw89_btc_fbtc_cysta_v7 { /* statistics for cycles */
+	u8 fver;
+	u8 rsvd;
+	u8 collision_cnt; /* counter for event/timer occur at the same time */
+	u8 except_cnt;
+
+	u8 wl_rx_err_ratio[BTC_CYCLE_SLOT_MAX];
+
+	struct rtw89_btc_fbtc_a2dp_trx_stat_v4 a2dp_trx[BTC_CYCLE_SLOT_MAX];
+
+	__le16 skip_cnt;
+	__le16 cycles; /* total cycle number */
+
+	__le16 slot_step_time[BTC_CYCLE_SLOT_MAX]; /* record the wl/bt slot time */
+	__le16 slot_cnt[CXST_MAX]; /* slot count */
+	__le16 bcn_cnt[CXBCN_MAX];
+
+	struct rtw89_btc_fbtc_cycle_time_info_v5 cycle_time;
+	struct rtw89_btc_fbtc_cycle_a2dp_empty_info a2dp_ept;
+	struct rtw89_btc_fbtc_cycle_leak_info_v7 leak_slot;
+
+	__le32 except_map;
+} __packed;
+
 union rtw89_btc_fbtc_cysta_info {
 	struct rtw89_btc_fbtc_cysta_v2 v2;
 	struct rtw89_btc_fbtc_cysta_v3 v3;
 	struct rtw89_btc_fbtc_cysta_v4 v4;
 	struct rtw89_btc_fbtc_cysta_v5 v5;
+	struct rtw89_btc_fbtc_cysta_v7 v7;
 };
 
 struct rtw89_btc_fbtc_cynullsta_v1 { /* cycle null statistics */
@@ -2694,6 +2730,7 @@ struct rtw89_btc_dm {
 	u32 wl_btg_rx_rb: 2;
 
 	u16 slot_dur[CXST_MAX];
+	u16 bt_slot_flood;
 
 	u8 run_reason;
 	u8 run_action;
@@ -2702,6 +2739,7 @@ struct rtw89_btc_dm {
 	u8 wl_lna2: 1;
 	u8 wl_pre_agc_rb: 2;
 	u8 bt_select: 2; /* 0:s0, 1:s1, 2:s0 & s1, refer to enum btc_bt_index */
+	u8 slot_req_more: 1;
 };
 
 struct rtw89_btc_ctrl {
-- 
2.25.1


