Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530E257F848
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 04:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbiGYCgH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Jul 2022 22:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiGYCgE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Jul 2022 22:36:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E32FE03A
        for <linux-wireless@vger.kernel.org>; Sun, 24 Jul 2022 19:35:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 26P2ZYaM4014714, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 26P2ZYaM4014714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 25 Jul 2022 10:35:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 25 Jul 2022 10:35:40 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Mon, 25 Jul
 2022 10:35:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/9] rtw89: coex: Move Wi-Fi firmware coexistence matching version to chip
Date:   Mon, 25 Jul 2022 10:35:02 +0800
Message-ID: <20220725023509.43114-3-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

To configure the different chips with different coexistence version,
separated the firmware feature version matching number is necessary.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     | 25 +++++-----
 drivers/net/wireless/realtek/rtw89/core.h     | 50 +++++++++----------
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 14 ++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 14 ++++++
 4 files changed, 66 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 286dd086a1338..f9c67aa1570dd 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -871,6 +871,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			   struct rtw89_btc_btf_fwinfo *pfwinfo,
 			   u8 *prptbuf, u32 index)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
@@ -908,7 +909,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_ctrl.cinfo;
 		pfinfo = (u8 *)(&pfwinfo->rpt_ctrl.finfo);
 		pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo);
-		pcinfo->req_fver = BTCRPT_VER;
+		pcinfo->req_fver = chip->fcxbtcrpt_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -916,7 +917,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_tdma.cinfo;
 		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_tdma.finfo);
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_tdma.finfo);
-		pcinfo->req_fver = FCXTDMA_VER;
+		pcinfo->req_fver = chip->fcxtdma_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -924,7 +925,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_slots.cinfo;
 		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_slots.finfo);
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_slots.finfo);
-		pcinfo->req_fver = FCXSLOTS_VER;
+		pcinfo->req_fver = chip->fcxslots_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -934,7 +935,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcysta_le32 = &pfwinfo->rpt_fbtc_cysta.finfo;
 		rtw89_btc_fbtc_cysta_to_cpu(pcysta_le32, pcysta);
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo);
-		pcinfo->req_fver = FCXCYSTA_VER;
+		pcinfo->req_fver = chip->fcxcysta_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -943,7 +944,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_step.finfo);
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_step.finfo.step[0]) *
 				  trace_step + 8;
-		pcinfo->req_fver = FCXSTEP_VER;
+		pcinfo->req_fver = chip->fcxstep_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -951,7 +952,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_nullsta.cinfo;
 		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_nullsta.finfo);
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_nullsta.finfo);
-		pcinfo->req_fver = FCXNULLSTA_VER;
+		pcinfo->req_fver = chip->fcxnullsta_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -959,7 +960,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_mregval.cinfo;
 		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_mregval.finfo);
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_mregval.finfo);
-		pcinfo->req_fver = FCXMREG_VER;
+		pcinfo->req_fver = chip->fcxmreg_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -967,7 +968,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_gpio_dbg.cinfo;
 		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_gpio_dbg.finfo);
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_gpio_dbg.finfo);
-		pcinfo->req_fver = FCXGPIODBG_VER;
+		pcinfo->req_fver = chip->fcxgpiodbg_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -975,7 +976,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_btver.cinfo;
 		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_btver.finfo);
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btver.finfo);
-		pcinfo->req_fver = FCX_BTVER_VER;
+		pcinfo->req_fver = chip->fcxbtver_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -983,7 +984,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_btscan.cinfo;
 		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_btscan.finfo);
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btscan.finfo);
-		pcinfo->req_fver = FCX_BTSCAN_VER;
+		pcinfo->req_fver = chip->fcxbtscan_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -991,7 +992,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_btafh.cinfo;
 		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_btafh.finfo);
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btafh.finfo);
-		pcinfo->req_fver = FCX_BTAFH_VER;
+		pcinfo->req_fver = chip->fcxbtafh_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -999,7 +1000,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_btdev.cinfo;
 		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_btdev.finfo);
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btdev.finfo);
-		pcinfo->req_fver = FCX_BTDEVINFO_VER;
+		pcinfo->req_fver = chip->fcxbtdevinfo_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 05b5282c770da..686ff8760c847 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1362,7 +1362,7 @@ struct rtw89_btc_cx {
 };
 
 struct rtw89_btc_fbtc_tdma {
-	u8 type;
+	u8 type; /* chip_info::fcxtdma_ver */
 	u8 rxflctrl;
 	u8 txpause;
 	u8 wtgle_n;
@@ -1374,7 +1374,6 @@ struct rtw89_btc_fbtc_tdma {
 
 #define CXMREG_MAX 30
 #define FCXMAX_STEP 255 /*STEP trace record cnt, Max:65535, default:255*/
-#define BTCRPT_VER 1
 #define BTC_CYCLE_SLOT_MAX 48 /* must be even number, non-zero */
 
 enum rtw89_btc_bt_rfk_counter {
@@ -1387,7 +1386,7 @@ enum rtw89_btc_bt_rfk_counter {
 };
 
 struct rtw89_btc_fbtc_rpt_ctrl {
-	u16 fver;
+	u16 fver; /* chip_info::fcxbtcrpt_ver */
 	u16 rpt_cnt; /* tmr counters */
 	u32 wl_fw_coex_ver; /* match which driver's coex version */
 	u32 wl_fw_cx_offload;
@@ -1473,10 +1472,9 @@ enum { /* STEP TYPE */
 	CXSTEP_MAX,
 };
 
-#define FCXGPIODBG_VER 1
 #define BTC_DBG_MAX1  32
 struct rtw89_btc_fbtc_gpio_dbg {
-	u8 fver;
+	u8 fver; /* chip_info::fcxgpiodbg_ver */
 	u8 rsvd;
 	u16 rsvd2;
 	u32 en_map; /* which debug signal (see btc_wl_gpio_debug) is enable */
@@ -1484,9 +1482,8 @@ struct rtw89_btc_fbtc_gpio_dbg {
 	u8 gpio_map[BTC_DBG_MAX1]; /*the debug signals to GPIO-Position */
 } __packed;
 
-#define FCXMREG_VER 1
 struct rtw89_btc_fbtc_mreg_val {
-	u8 fver;
+	u8 fver; /* chip_info::fcxmreg_ver */
 	u8 reg_num;
 	__le16 rsvd;
 	__le32 mreg_val[CXMREG_MAX];
@@ -1508,16 +1505,14 @@ struct rtw89_btc_fbtc_slot {
 	__le16 cxtype;
 } __packed;
 
-#define FCXSLOTS_VER 1
 struct rtw89_btc_fbtc_slots {
-	u8 fver;
+	u8 fver; /* chip_info::fcxslots_ver */
 	u8 tbl_num;
 	__le16 rsvd;
 	__le32 update_map;
 	struct rtw89_btc_fbtc_slot slot[CXST_MAX];
 } __packed;
 
-#define FCXSTEP_VER 2
 struct rtw89_btc_fbtc_step {
 	u8 type;
 	u8 val;
@@ -1525,7 +1520,7 @@ struct rtw89_btc_fbtc_step {
 } __packed;
 
 struct rtw89_btc_fbtc_steps {
-	u8 fver;
+	u8 fver; /* chip_info::fcxstep_ver */
 	u8 rsvd;
 	__le16 cnt;
 	__le16 pos_old;
@@ -1533,9 +1528,8 @@ struct rtw89_btc_fbtc_steps {
 	struct rtw89_btc_fbtc_step step[FCXMAX_STEP];
 } __packed;
 
-#define FCXCYSTA_VER 2
 struct rtw89_btc_fbtc_cysta { /* statistics for cycles */
-	u8 fver;
+	u8 fver; /* chip_info::fcxcysta_ver */
 	u8 rsvd;
 	__le16 cycles; /* total cycle number */
 	__le16 cycles_a2dp[CXT_FLCTRL_MAX];
@@ -1560,9 +1554,8 @@ struct rtw89_btc_fbtc_cysta { /* statistics for cycles */
 	__le16 tslot_cycle[BTC_CYCLE_SLOT_MAX];
 } __packed;
 
-#define FCXNULLSTA_VER 1
 struct rtw89_btc_fbtc_cynullsta { /* cycle null statistics */
-	u8 fver;
+	u8 fver; /* chip_info::fcxnullsta_ver */
 	u8 rsvd;
 	__le16 rsvd2;
 	__le32 max_t[2]; /* max_t for 0:null0/1:null1 */
@@ -1570,9 +1563,8 @@ struct rtw89_btc_fbtc_cynullsta { /* cycle null statistics */
 	__le32 result[2][4]; /* 0:fail, 1:ok, 2:on_time, 3:retry */
 } __packed;
 
-#define FCX_BTVER_VER 1
 struct rtw89_btc_fbtc_btver {
-	u8 fver;
+	u8 fver; /* chip_info::fcxbtver_ver */
 	u8 rsvd;
 	__le16 rsvd2;
 	__le32 coex_ver; /*bit[15:8]->shared, bit[7:0]->non-shared */
@@ -1580,17 +1572,15 @@ struct rtw89_btc_fbtc_btver {
 	__le32 feature;
 } __packed;
 
-#define FCX_BTSCAN_VER 1
 struct rtw89_btc_fbtc_btscan {
-	u8 fver;
+	u8 fver; /* chip_info::fcxbtscan_ver */
 	u8 rsvd;
 	__le16 rsvd2;
 	u8 scan[6];
 } __packed;
 
-#define FCX_BTAFH_VER 1
 struct rtw89_btc_fbtc_btafh {
-	u8 fver;
+	u8 fver; /* chip_info::fcxbtafh_ver */
 	u8 rsvd;
 	__le16 rsvd2;
 	u8 afh_l[4]; /*bit0:2402, bit1: 2403.... bit31:2433 */
@@ -1598,9 +1588,8 @@ struct rtw89_btc_fbtc_btafh {
 	u8 afh_h[4]; /*bit0:2466, bit1:2467......bit14:2480 */
 } __packed;
 
-#define FCX_BTDEVINFO_VER 1
 struct rtw89_btc_fbtc_btdevinfo {
-	u8 fver;
+	u8 fver; /* chip_info::fcxbtdevinfo_ver */
 	u8 rsvd;
 	__le16 vendor_id;
 	__le32 dev_name; /* only 24 bits valid */
@@ -1666,8 +1655,6 @@ struct rtw89_btc_dbg {
 	u32 rb_val;
 };
 
-#define FCXTDMA_VER 1
-
 enum rtw89_btc_btf_fw_event {
 	BTF_EVNT_RPT = 0,
 	BTF_EVNT_BT_INFO = 1,
@@ -2463,6 +2450,19 @@ struct rtw89_chip_info {
 	u8 scbd;
 	u8 mailbox;
 
+	u8 fcxbtcrpt_ver;
+	u8 fcxtdma_ver;
+	u8 fcxslots_ver;
+	u8 fcxcysta_ver;
+	u8 fcxstep_ver;
+	u8 fcxnullsta_ver;
+	u8 fcxmreg_ver;
+	u8 fcxgpiodbg_ver;
+	u8 fcxbtver_ver;
+	u8 fcxbtscan_ver;
+	u8 fcxbtafh_ver;
+	u8 fcxbtdevinfo_ver;
+
 	u8 afh_guard_ch;
 	const u8 *wl_rssi_thres;
 	const u8 *bt_rssi_thres;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index f6810fbb3fab1..0dc92c16b4513 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2157,6 +2157,20 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.btcx_desired		= 0x5,
 	.scbd			= 0x1,
 	.mailbox		= 0x1,
+
+	.fcxbtcrpt_ver		= 1,
+	.fcxtdma_ver		= 1,
+	.fcxslots_ver		= 1,
+	.fcxcysta_ver		= 2,
+	.fcxstep_ver		= 2,
+	.fcxnullsta_ver		= 1,
+	.fcxmreg_ver		= 1,
+	.fcxgpiodbg_ver		= 1,
+	.fcxbtver_ver		= 1,
+	.fcxbtscan_ver		= 1,
+	.fcxbtafh_ver		= 1,
+	.fcxbtdevinfo_ver	= 1,
+
 	.afh_guard_ch		= 6,
 	.wl_rssi_thres		= rtw89_btc_8852a_wl_rssi_thres,
 	.bt_rssi_thres		= rtw89_btc_8852a_bt_rssi_thres,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 0218fa90526ca..62aa103a8272c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3006,6 +3006,20 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.btcx_desired		= 0x5,
 	.scbd			= 0x1,
 	.mailbox		= 0x1,
+
+	.fcxbtcrpt_ver		= 4,
+	.fcxtdma_ver		= 3,
+	.fcxslots_ver		= 1,
+	.fcxcysta_ver		= 3,
+	.fcxstep_ver		= 3,
+	.fcxnullsta_ver		= 2,
+	.fcxmreg_ver		= 1,
+	.fcxgpiodbg_ver		= 1,
+	.fcxbtver_ver		= 1,
+	.fcxbtscan_ver		= 1,
+	.fcxbtafh_ver		= 1,
+	.fcxbtdevinfo_ver	= 1,
+
 	.afh_guard_ch		= 6,
 	.wl_rssi_thres		= rtw89_btc_8852c_wl_rssi_thres,
 	.bt_rssi_thres		= rtw89_btc_8852c_bt_rssi_thres,
-- 
2.25.1

