Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B8864F938
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 15:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiLQOSS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Dec 2022 09:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiLQOSP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Dec 2022 09:18:15 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B3F2A1AA
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:18:13 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BHEH9pB4024809, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BHEH9pB4024809
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 17 Dec 2022 22:17:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Sat, 17 Dec 2022 22:17:59 +0800
Received: from localhost (172.16.16.141) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 17 Dec
 2022 22:17:59 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] wifi: rtw89: coex: use new introduction BTC version format
Date:   Sat, 17 Dec 2022 22:17:40 +0800
Message-ID: <20221217141745.43291-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221217141745.43291-1-pkshih@realtek.com>
References: <20221217141745.43291-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.141]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/17/2022 14:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzE3IKRXpMggMTE6MjQ6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Previous patch has added format version derived from firmware version.
Use the format version, and remove constant version number from chip_info.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     | 32 +++++++-------
 drivers/net/wireless/realtek/rtw89/core.h     | 42 +++++++------------
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 14 -------
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 15 +------
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 14 -------
 5 files changed, 32 insertions(+), 85 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 96aadd50f5fd6..df3984ebba06e 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -976,6 +976,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
@@ -1022,7 +1023,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			pfinfo = &pfwinfo->rpt_ctrl.finfo_v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo_v1);
 		}
-		pcinfo->req_fver = chip->fcxbtcrpt_ver;
+		pcinfo->req_fver = ver->fcxbtcrpt;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -1035,7 +1036,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			pfinfo = &pfwinfo->rpt_fbtc_tdma.finfo_v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_tdma.finfo_v1);
 		}
-		pcinfo->req_fver = chip->fcxtdma_ver;
+		pcinfo->req_fver = ver->fcxtdma;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -1043,7 +1044,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_slots.cinfo;
 		pfinfo = &pfwinfo->rpt_fbtc_slots.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_slots.finfo);
-		pcinfo->req_fver = chip->fcxslots_ver;
+		pcinfo->req_fver = ver->fcxslots;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -1059,7 +1060,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			pcysta_v1 = &pfwinfo->rpt_fbtc_cysta.finfo_v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo_v1);
 		}
-		pcinfo->req_fver = chip->fcxcysta_ver;
+		pcinfo->req_fver = ver->fcxcysta;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -1076,7 +1077,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 					  trace_step +
 					  offsetof(struct rtw89_btc_fbtc_steps_v1, step);
 		}
-		pcinfo->req_fver = chip->fcxstep_ver;
+		pcinfo->req_fver = ver->fcxstep;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -1089,7 +1090,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			pfinfo = &pfwinfo->rpt_fbtc_nullsta.finfo_v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_nullsta.finfo_v1);
 		}
-		pcinfo->req_fver = chip->fcxnullsta_ver;
+		pcinfo->req_fver = ver->fcxnullsta;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -1097,7 +1098,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_mregval.cinfo;
 		pfinfo = &pfwinfo->rpt_fbtc_mregval.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_mregval.finfo);
-		pcinfo->req_fver = chip->fcxmreg_ver;
+		pcinfo->req_fver = ver->fcxmreg;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -1105,7 +1106,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_gpio_dbg.cinfo;
 		pfinfo = &pfwinfo->rpt_fbtc_gpio_dbg.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_gpio_dbg.finfo);
-		pcinfo->req_fver = chip->fcxgpiodbg_ver;
+		pcinfo->req_fver = ver->fcxgpiodbg;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -1113,7 +1114,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_btver.cinfo;
 		pfinfo = &pfwinfo->rpt_fbtc_btver.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btver.finfo);
-		pcinfo->req_fver = chip->fcxbtver_ver;
+		pcinfo->req_fver = ver->fcxbtver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -1121,7 +1122,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_btscan.cinfo;
 		pfinfo = &pfwinfo->rpt_fbtc_btscan.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btscan.finfo);
-		pcinfo->req_fver = chip->fcxbtscan_ver;
+		pcinfo->req_fver = ver->fcxbtscan;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -1129,7 +1130,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_btafh.cinfo;
 		pfinfo = &pfwinfo->rpt_fbtc_btafh.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btafh.finfo);
-		pcinfo->req_fver = chip->fcxbtafh_ver;
+		pcinfo->req_fver = ver->fcxbtafh;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -1137,7 +1138,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		pcinfo = &pfwinfo->rpt_fbtc_btdev.cinfo;
 		pfinfo = &pfwinfo->rpt_fbtc_btdev.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btdev.finfo);
-		pcinfo->req_fver = chip->fcxbtdevinfo_ver;
+		pcinfo->req_fver = ver->fcxbtdevinfo;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
 		break;
@@ -1394,7 +1395,7 @@ static void _parse_btc_report(struct rtw89_dev *rtwdev,
 			      struct rtw89_btc_btf_fwinfo *pfwinfo,
 			      u8 *pbuf, u32 buf_len)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_btc_ver *ver = rtwdev->btc.ver;
 	struct rtw89_btc_prpt *btc_prpt = NULL;
 	u32 index = 0, rpt_len = 0;
 
@@ -1404,7 +1405,7 @@ static void _parse_btc_report(struct rtw89_dev *rtwdev,
 
 	while (pbuf) {
 		btc_prpt = (struct rtw89_btc_prpt *)&pbuf[index];
-		if (index + 2 >= chip->btc_fwinfo_buf)
+		if (index + 2 >= ver->info_buf)
 			break;
 		/* At least 3 bytes: type(1) & len(2) */
 		rpt_len = le16_to_cpu(btc_prpt->len);
@@ -1424,6 +1425,7 @@ static void _append_tdma(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_btf_tlv *tlv;
 	struct rtw89_btc_fbtc_tdma *v;
@@ -1448,7 +1450,7 @@ static void _append_tdma(struct rtw89_dev *rtwdev)
 	} else {
 		tlv->len = sizeof(*v1);
 		v1 = (struct rtw89_btc_fbtc_tdma_v1 *)&tlv->val[0];
-		v1->fver = chip->fcxtdma_ver;
+		v1->fver = ver->fcxtdma;
 		v1->tdma = dm->tdma;
 		btc->policy_len += BTC_TLV_HDR_LEN  + sizeof(*v1);
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 151343ee7b763..358bfcd9ece20 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1438,7 +1438,7 @@ struct rtw89_btc_cx {
 };
 
 struct rtw89_btc_fbtc_tdma {
-	u8 type; /* chip_info::fcxtdma_ver */
+	u8 type; /* btc_ver::fcxtdma */
 	u8 rxflctrl;
 	u8 txpause;
 	u8 wtgle_n;
@@ -1449,7 +1449,7 @@ struct rtw89_btc_fbtc_tdma {
 } __packed;
 
 struct rtw89_btc_fbtc_tdma_v1 {
-	u8 fver; /* chip_info::fcxtdma_ver */
+	u8 fver; /* btc_ver::fcxtdma */
 	u8 rsvd;
 	__le16 rsvd1;
 	struct rtw89_btc_fbtc_tdma tdma;
@@ -1474,7 +1474,7 @@ enum rtw89_btc_bt_sta_counter {
 };
 
 struct rtw89_btc_fbtc_rpt_ctrl {
-	u16 fver; /* chip_info::fcxbtcrpt_ver */
+	u16 fver; /* btc_ver::fcxbtcrpt */
 	u16 rpt_cnt; /* tmr counters */
 	u32 wl_fw_coex_ver; /* match which driver's coex version */
 	u32 wl_fw_cx_offload;
@@ -1607,7 +1607,7 @@ enum { /* STEP TYPE */
 
 #define BTC_DBG_MAX1  32
 struct rtw89_btc_fbtc_gpio_dbg {
-	u8 fver; /* chip_info::fcxgpiodbg_ver */
+	u8 fver; /* btc_ver::fcxgpiodbg */
 	u8 rsvd;
 	u16 rsvd2;
 	u32 en_map; /* which debug signal (see btc_wl_gpio_debug) is enable */
@@ -1616,7 +1616,7 @@ struct rtw89_btc_fbtc_gpio_dbg {
 } __packed;
 
 struct rtw89_btc_fbtc_mreg_val {
-	u8 fver; /* chip_info::fcxmreg_ver */
+	u8 fver; /* btc_ver::fcxmreg */
 	u8 reg_num;
 	__le16 rsvd;
 	__le32 mreg_val[CXMREG_MAX];
@@ -1639,7 +1639,7 @@ struct rtw89_btc_fbtc_slot {
 } __packed;
 
 struct rtw89_btc_fbtc_slots {
-	u8 fver; /* chip_info::fcxslots_ver */
+	u8 fver; /* btc_ver::fcxslots */
 	u8 tbl_num;
 	__le16 rsvd;
 	__le32 update_map;
@@ -1653,7 +1653,7 @@ struct rtw89_btc_fbtc_step {
 } __packed;
 
 struct rtw89_btc_fbtc_steps {
-	u8 fver; /* chip_info::fcxstep_ver */
+	u8 fver; /* btc_ver::fcxstep */
 	u8 rsvd;
 	__le16 cnt;
 	__le16 pos_old;
@@ -1670,7 +1670,7 @@ struct rtw89_btc_fbtc_steps_v1 {
 } __packed;
 
 struct rtw89_btc_fbtc_cysta { /* statistics for cycles */
-	u8 fver; /* chip_info::fcxcysta_ver */
+	u8 fver; /* btc_ver::fcxcysta */
 	u8 rsvd;
 	__le16 cycles; /* total cycle number */
 	__le16 cycles_a2dp[CXT_FLCTRL_MAX];
@@ -1750,7 +1750,7 @@ struct rtw89_btc_fbtc_cysta_v1 { /* statistics for cycles */
 } __packed;
 
 struct rtw89_btc_fbtc_cynullsta { /* cycle null statistics */
-	u8 fver; /* chip_info::fcxnullsta_ver */
+	u8 fver; /* btc_ver::fcxnullsta */
 	u8 rsvd;
 	__le16 rsvd2;
 	__le32 max_t[2]; /* max_t for 0:null0/1:null1 */
@@ -1759,7 +1759,7 @@ struct rtw89_btc_fbtc_cynullsta { /* cycle null statistics */
 } __packed;
 
 struct rtw89_btc_fbtc_cynullsta_v1 { /* cycle null statistics */
-	u8 fver; /* chip_info::fcxnullsta_ver */
+	u8 fver; /* btc_ver::fcxnullsta */
 	u8 rsvd;
 	__le16 rsvd2;
 	__le32 max_t[2]; /* max_t for 0:null0/1:null1 */
@@ -1768,7 +1768,7 @@ struct rtw89_btc_fbtc_cynullsta_v1 { /* cycle null statistics */
 } __packed;
 
 struct rtw89_btc_fbtc_btver {
-	u8 fver; /* chip_info::fcxbtver_ver */
+	u8 fver; /* btc_ver::fcxbtver */
 	u8 rsvd;
 	__le16 rsvd2;
 	__le32 coex_ver; /*bit[15:8]->shared, bit[7:0]->non-shared */
@@ -1777,14 +1777,14 @@ struct rtw89_btc_fbtc_btver {
 } __packed;
 
 struct rtw89_btc_fbtc_btscan {
-	u8 fver; /* chip_info::fcxbtscan_ver */
+	u8 fver; /* btc_ver::fcxbtscan */
 	u8 rsvd;
 	__le16 rsvd2;
 	u8 scan[6];
 } __packed;
 
 struct rtw89_btc_fbtc_btafh {
-	u8 fver; /* chip_info::fcxbtafh_ver */
+	u8 fver; /* btc_ver::fcxbtafh */
 	u8 rsvd;
 	__le16 rsvd2;
 	u8 afh_l[4]; /*bit0:2402, bit1: 2403.... bit31:2433 */
@@ -1793,7 +1793,7 @@ struct rtw89_btc_fbtc_btafh {
 } __packed;
 
 struct rtw89_btc_fbtc_btdevinfo {
-	u8 fver; /* chip_info::fcxbtdevinfo_ver */
+	u8 fver; /* btc_ver::fcxbtdevinfo */
 	u8 rsvd;
 	__le16 vendor_id;
 	__le32 dev_name; /* only 24 bits valid */
@@ -2756,20 +2756,6 @@ struct rtw89_chip_info {
 	u8 btcx_desired;
 	u8 scbd;
 	u8 mailbox;
-	u16 btc_fwinfo_buf;
-
-	u8 fcxbtcrpt_ver;
-	u8 fcxtdma_ver;
-	u8 fcxslots_ver;
-	u8 fcxcysta_ver;
-	u8 fcxstep_ver;
-	u8 fcxnullsta_ver;
-	u8 fcxmreg_ver;
-	u8 fcxgpiodbg_ver;
-	u8 fcxbtver_ver;
-	u8 fcxbtscan_ver;
-	u8 fcxbtafh_ver;
-	u8 fcxbtdevinfo_ver;
 
 	u8 afh_guard_ch;
 	const u8 *wl_rssi_thres;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index eff6519cf0191..9a6f2f9f35a84 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2106,20 +2106,6 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.btcx_desired		= 0x7,
 	.scbd			= 0x1,
 	.mailbox		= 0x1,
-	.btc_fwinfo_buf		= 1024,
-
-	.fcxbtcrpt_ver		= 1,
-	.fcxtdma_ver		= 1,
-	.fcxslots_ver		= 1,
-	.fcxcysta_ver		= 2,
-	.fcxstep_ver		= 2,
-	.fcxnullsta_ver		= 1,
-	.fcxmreg_ver		= 1,
-	.fcxgpiodbg_ver		= 1,
-	.fcxbtver_ver		= 1,
-	.fcxbtscan_ver		= 1,
-	.fcxbtafh_ver		= 1,
-	.fcxbtdevinfo_ver	= 1,
 
 	.afh_guard_ch		= 6,
 	.wl_rssi_thres		= rtw89_btc_8852a_wl_rssi_thres,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index b635ac1d1ca2f..498ae8616cd59 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2483,20 +2483,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.btcx_desired		= 0x5,
 	.scbd			= 0x1,
 	.mailbox		= 0x1,
-	.btc_fwinfo_buf		= 1024,
-
-	.fcxbtcrpt_ver		= 1,
-	.fcxtdma_ver		= 1,
-	.fcxslots_ver		= 1,
-	.fcxcysta_ver		= 2,
-	.fcxstep_ver		= 2,
-	.fcxnullsta_ver		= 1,
-	.fcxmreg_ver		= 1,
-	.fcxgpiodbg_ver		= 1,
-	.fcxbtver_ver		= 1,
-	.fcxbtscan_ver		= 1,
-	.fcxbtafh_ver		= 1,
-	.fcxbtdevinfo_ver	= 1,
+
 	.afh_guard_ch		= 6,
 	.wl_rssi_thres		= rtw89_btc_8852b_wl_rssi_thres,
 	.bt_rssi_thres		= rtw89_btc_8852b_bt_rssi_thres,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index a87482cc25f58..bacdc91d63e9f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2915,20 +2915,6 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.btcx_desired		= 0x7,
 	.scbd			= 0x1,
 	.mailbox		= 0x1,
-	.btc_fwinfo_buf		= 1280,
-
-	.fcxbtcrpt_ver		= 4,
-	.fcxtdma_ver		= 3,
-	.fcxslots_ver		= 1,
-	.fcxcysta_ver		= 3,
-	.fcxstep_ver		= 3,
-	.fcxnullsta_ver		= 2,
-	.fcxmreg_ver		= 1,
-	.fcxgpiodbg_ver		= 1,
-	.fcxbtver_ver		= 1,
-	.fcxbtscan_ver		= 1,
-	.fcxbtafh_ver		= 1,
-	.fcxbtdevinfo_ver	= 1,
 
 	.afh_guard_ch		= 6,
 	.wl_rssi_thres		= rtw89_btc_8852c_wl_rssi_thres,
-- 
2.25.1

