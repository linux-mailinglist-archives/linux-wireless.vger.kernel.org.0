Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084E157F847
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 04:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiGYCgF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Jul 2022 22:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiGYCgA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Jul 2022 22:36:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37B3DE038
        for <linux-wireless@vger.kernel.org>; Sun, 24 Jul 2022 19:35:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 26P2Zg2vA014769, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 26P2Zg2vA014769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 25 Jul 2022 10:35:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 10:35:48 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Mon, 25 Jul
 2022 10:35:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 9/9] rtw89: coex: Update Wi-Fi driver/firmware TDMA cycle report for RTL8852c
Date:   Mon, 25 Jul 2022 10:35:09 +0800
Message-ID: <20220725023509.43114-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725023509.43114-1-pkshih@realtek.com>
References: <20220725023509.43114-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/25/2022 02:16:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzcvMjQgpFWkyCAxMToyOTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Because RTL8852c firmware handshake use different structure definition
with RTL8852a, so it's necessary to update a version for RTL8852c.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 61 ++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h | 60 +++++++++++++++++++++-
 2 files changed, 113 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index ca0e89d5a30ce..732502b64b255 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -912,12 +912,14 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	struct rtw89_btc_fbtc_rpt_ctrl *prpt;
 	struct rtw89_btc_fbtc_rpt_ctrl_v1 *prpt_v1;
 	struct rtw89_btc_fbtc_cysta *pcysta_le32 = NULL;
+	struct rtw89_btc_fbtc_cysta_v1 *pcysta_v1 = NULL;
 	struct rtw89_btc_fbtc_cysta_cpu pcysta[1];
 	struct rtw89_btc_prpt *btc_prpt = NULL;
 	struct rtw89_btc_fbtc_slot *rtp_slot = NULL;
 	u8 rpt_type = 0, *rpt_content = NULL, *pfinfo = NULL;
-	u16 wl_slot_set = 0;
+	u16 wl_slot_set = 0, wl_slot_real = 0;
 	u32 trace_step = btc->ctrl.trace_step, rpt_len = 0, diff_t;
+	u32 cnt_leak_slot = 0, bt_slot_real = 0, cnt_rx_imr = 0;
 	u8 i;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -975,10 +977,16 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_CYSTA:
 		pcinfo = &pfwinfo->rpt_fbtc_cysta.cinfo;
-		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_cysta.finfo);
-		pcysta_le32 = &pfwinfo->rpt_fbtc_cysta.finfo;
-		rtw89_btc_fbtc_cysta_to_cpu(pcysta_le32, pcysta);
-		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo);
+		if (chip->chip_id == RTL8852A) {
+			pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_cysta.finfo);
+			pcysta_le32 = &pfwinfo->rpt_fbtc_cysta.finfo;
+			rtw89_btc_fbtc_cysta_to_cpu(pcysta_le32, pcysta);
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo);
+		} else {
+			pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_cysta.finfo_v1);
+			pcysta_v1 = &pfwinfo->rpt_fbtc_cysta.finfo_v1;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo_v1);
+		}
 		pcinfo->req_fver = chip->fcxcysta_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
@@ -1177,7 +1185,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				    sizeof(dm->slot_now)));
 	}
 
-	if (rpt_type == BTC_RPT_TYPE_CYSTA &&
+	if (rpt_type == BTC_RPT_TYPE_CYSTA && chip->chip_id == RTL8852A &&
 	    pcysta->cycles >= BTC_CYSTA_CHK_PERIOD) {
 		/* Check Leak-AP */
 		if (pcysta->slot_cnt[CXST_LK] != 0 &&
@@ -1200,8 +1208,47 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		}
 
 		_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE, pcysta->slot_cnt[CXST_W1]);
-		_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE, pcysta->slot_cnt[CXST_W1]);
+		_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE, pcysta->slot_cnt[CXST_B1]);
 		_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE, (u32)pcysta->cycles);
+	} else if (rpt_type == BTC_RPT_TYPE_CYSTA && pcysta_v1 &&
+		   le16_to_cpu(pcysta_v1->cycles) >= BTC_CYSTA_CHK_PERIOD) {
+		cnt_leak_slot = le32_to_cpu(pcysta_v1->slot_cnt[CXST_LK]);
+		cnt_rx_imr = le32_to_cpu(pcysta_v1->leak_slot.cnt_rximr);
+		/* Check Leak-AP */
+		if (cnt_leak_slot != 0 && cnt_rx_imr != 0 &&
+		    dm->tdma_now.rxflctrl) {
+			if (cnt_leak_slot < BTC_LEAK_AP_TH * cnt_rx_imr)
+				dm->leak_ap = 1;
+		}
+
+		/* Check diff time between real WL slot and W1 slot */
+		if (dm->tdma_now.type == CXTDMA_OFF) {
+			wl_slot_set = le16_to_cpu(dm->slot_now[CXST_W1].dur);
+			wl_slot_real = le16_to_cpu(pcysta_v1->cycle_time.tavg[CXT_WL]);
+			if (wl_slot_real > wl_slot_set) {
+				diff_t = wl_slot_real - wl_slot_set;
+				_chk_btc_err(rtwdev, BTC_DCNT_WL_SLOT_DRIFT, diff_t);
+			}
+		}
+
+		/* Check diff time between real BT slot and EBT/E5G slot */
+		if (dm->tdma_now.type == CXTDMA_OFF &&
+		    dm->tdma_now.ext_ctrl == CXECTL_EXT &&
+		    btc->bt_req_len != 0) {
+			bt_slot_real = le16_to_cpu(pcysta_v1->cycle_time.tavg[CXT_BT]);
+
+			if (btc->bt_req_len > bt_slot_real) {
+				diff_t = btc->bt_req_len - bt_slot_real;
+				_chk_btc_err(rtwdev, BTC_DCNT_BT_SLOT_DRIFT, diff_t);
+			}
+		}
+
+		_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE,
+			     le32_to_cpu(pcysta_v1->slot_cnt[CXST_W1]));
+		_chk_btc_err(rtwdev, BTC_DCNT_B1_FREEZE,
+			     le32_to_cpu(pcysta_v1->slot_cnt[CXST_B1]));
+		_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE,
+			     (u32)le16_to_cpu(pcysta_v1->cycles));
 	}
 
 	if (rpt_type == BTC_RPT_TYPE_CTRL && chip->chip_id == RTL8852A) {
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d62e19cc3da52..45e9d9aeefd3d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -864,6 +864,7 @@ enum rtw89_btc_dcnt {
 	BTC_DCNT_SLOT_NONSYNC,
 	BTC_DCNT_BTCNT_FREEZE,
 	BTC_DCNT_WL_SLOT_DRIFT,
+	BTC_DCNT_BT_SLOT_DRIFT,
 	BTC_DCNT_WL_STA_LAST,
 	BTC_DCNT_NUM,
 };
@@ -1654,6 +1655,60 @@ struct rtw89_btc_fbtc_cysta { /* statistics for cycles */
 	__le16 tslot_cycle[BTC_CYCLE_SLOT_MAX];
 } __packed;
 
+struct rtw89_btc_fbtc_fdd_try_info {
+	__le16 cycles[CXT_FLCTRL_MAX];
+	__le16 tavg[CXT_FLCTRL_MAX]; /* avg try BT-Slot-TDD/BT-slot-FDD time */
+	__le16 tmax[CXT_FLCTRL_MAX]; /* max try BT-Slot-TDD/BT-slot-FDD time */
+} __packed;
+
+struct rtw89_btc_fbtc_cycle_time_info {
+	__le16 tavg[CXT_MAX]; /* avg wl/bt cycle time */
+	__le16 tmax[CXT_MAX]; /* max wl/bt cycle time */
+	__le16 tmaxdiff[CXT_MAX]; /* max wl-wl bt-bt cycle diff time */
+} __packed;
+
+struct rtw89_btc_fbtc_a2dp_trx_stat {
+	u8 empty_cnt;
+	u8 retry_cnt;
+	u8 tx_rate;
+	u8 tx_cnt;
+	u8 ack_cnt;
+	u8 nack_cnt;
+	u8 rsvd1;
+	u8 rsvd2;
+} __packed;
+
+struct rtw89_btc_fbtc_cycle_a2dp_empty_info {
+	__le16 cnt; /* a2dp empty cnt */
+	__le16 cnt_timeout; /* a2dp empty timeout cnt*/
+	__le16 tavg; /* avg a2dp empty time */
+	__le16 tmax; /* max a2dp empty time */
+} __packed;
+
+struct rtw89_btc_fbtc_cycle_leak_info {
+	__le32 cnt_rximr; /* the rximr occur at leak slot  */
+	__le16 tavg; /* avg leak-slot time */
+	__le16 tmax; /* max leak-slot time */
+} __packed;
+
+struct rtw89_btc_fbtc_cysta_v1 { /* statistics for cycles */
+	u8 fver;
+	u8 rsvd;
+	__le16 cycles; /* total cycle number */
+	__le16 slot_step_time[BTC_CYCLE_SLOT_MAX];
+	struct rtw89_btc_fbtc_cycle_time_info cycle_time;
+	struct rtw89_btc_fbtc_fdd_try_info fdd_try;
+	struct rtw89_btc_fbtc_cycle_a2dp_empty_info a2dp_ept;
+	struct rtw89_btc_fbtc_a2dp_trx_stat a2dp_trx[BTC_CYCLE_SLOT_MAX];
+	struct rtw89_btc_fbtc_cycle_leak_info leak_slot;
+	__le32 slot_cnt[CXST_MAX]; /* slot count */
+	__le32 bcn_cnt[CXBCN_MAX];
+	__le32 collision_cnt; /* counter for event/timer occur at the same time */
+	__le32 skip_cnt;
+	__le32 except_cnt;
+	__le32 except_map;
+} __packed;
+
 struct rtw89_btc_fbtc_cynullsta { /* cycle null statistics */
 	u8 fver; /* chip_info::fcxnullsta_ver */
 	u8 rsvd;
@@ -1830,7 +1885,10 @@ struct rtw89_btc_rpt_fbtc_slots {
 
 struct rtw89_btc_rpt_fbtc_cysta {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
-	struct rtw89_btc_fbtc_cysta finfo; /* info from fw */
+	union {
+		struct rtw89_btc_fbtc_cysta finfo; /* info from fw for 52A*/
+		struct rtw89_btc_fbtc_cysta_v1 finfo_v1; /* info from fw for 52C*/
+	};
 };
 
 struct rtw89_btc_rpt_fbtc_step {
-- 
2.25.1

