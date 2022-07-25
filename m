Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2994457F841
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 04:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiGYCgB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Jul 2022 22:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiGYCf7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Jul 2022 22:35:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 298DFE020
        for <linux-wireless@vger.kernel.org>; Sun, 24 Jul 2022 19:35:55 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 26P2ZZd04014719, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 26P2ZZd04014719
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 25 Jul 2022 10:35:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 10:35:41 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Mon, 25 Jul
 2022 10:35:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/9] rtw89: coex: Add logic to parsing rtl8852c firmware type ctrl report
Date:   Mon, 25 Jul 2022 10:35:03 +0800
Message-ID: <20220725023509.43114-4-pkshih@realtek.com>
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

Add a part of logic to parse type of ctrl report from firmware, and
remove Bluetooth packet counter count from driver, the feature was
moved to firmware at rtl8852c.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     | 44 +++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h     | 63 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 18 +-----
 3 files changed, 98 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index f9c67aa1570dd..020b2628ef2c4 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -876,7 +876,9 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_fbtc_rpt_ctrl *prpt = NULL;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_fbtc_rpt_ctrl *prpt;
+	struct rtw89_btc_fbtc_rpt_ctrl_v1 *prpt_v1;
 	struct rtw89_btc_fbtc_cysta *pcysta_le32 = NULL;
 	struct rtw89_btc_fbtc_cysta_cpu pcysta[1];
 	struct rtw89_btc_prpt *btc_prpt = NULL;
@@ -907,8 +909,13 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	switch (rpt_type) {
 	case BTC_RPT_TYPE_CTRL:
 		pcinfo = &pfwinfo->rpt_ctrl.cinfo;
-		pfinfo = (u8 *)(&pfwinfo->rpt_ctrl.finfo);
-		pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo);
+		if (chip->chip_id == RTL8852A) {
+			pfinfo = (u8 *)(&pfwinfo->rpt_ctrl.finfo);
+			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo);
+		} else {
+			pfinfo = (u8 *)(&pfwinfo->rpt_ctrl.finfo_v1);
+			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo_v1);
+		}
 		pcinfo->req_fver = chip->fcxbtcrpt_ver;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
@@ -1127,12 +1134,12 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE, (u32)pcysta->cycles);
 	}
 
-	if (rpt_type == BTC_RPT_TYPE_CTRL) {
+	if (rpt_type == BTC_RPT_TYPE_CTRL && chip->chip_id == RTL8852A) {
 		prpt = &pfwinfo->rpt_ctrl.finfo;
 		btc->fwinfo.rpt_en_map = prpt->rpt_enable;
 		wl->ver_info.fw_coex = prpt->wl_fw_coex_ver;
 		wl->ver_info.fw = prpt->wl_fw_ver;
-		dm->wl_fw_cx_offload = !!(prpt->wl_fw_cx_offload);
+		dm->wl_fw_cx_offload = !!prpt->wl_fw_cx_offload;
 
 		_chk_btc_err(rtwdev, BTC_DCNT_RPT_FREEZE,
 			     pfwinfo->event[BTF_EVNT_RPT]);
@@ -1145,6 +1152,33 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			btc->cx.cnt_bt[BTC_BCNT_POLUT] =
 				rtw89_mac_get_plt_cnt(rtwdev, RTW89_MAC_0);
 		}
+	} else if (rpt_type == BTC_RPT_TYPE_CTRL) {
+		prpt_v1 = &pfwinfo->rpt_ctrl.finfo_v1;
+		btc->fwinfo.rpt_en_map = le32_to_cpu(prpt_v1->rpt_info.en);
+		wl->ver_info.fw_coex = le32_to_cpu(prpt_v1->wl_fw_info.cx_ver);
+		wl->ver_info.fw = le32_to_cpu(prpt_v1->wl_fw_info.fw_ver);
+		dm->wl_fw_cx_offload = !!le32_to_cpu(prpt_v1->wl_fw_info.cx_offload);
+
+		for (i = RTW89_PHY_0; i < RTW89_PHY_MAX; i++)
+			memcpy(&dm->gnt.band[i], &prpt_v1->gnt_val[i],
+			       sizeof(dm->gnt.band[i]));
+
+		btc->cx.cnt_bt[BTC_BCNT_HIPRI_TX] = le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_HI_TX]);
+		btc->cx.cnt_bt[BTC_BCNT_HIPRI_RX] = le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_HI_RX]);
+		btc->cx.cnt_bt[BTC_BCNT_LOPRI_TX] = le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_LO_TX]);
+		btc->cx.cnt_bt[BTC_BCNT_LOPRI_RX] = le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_LO_RX]);
+		btc->cx.cnt_bt[BTC_BCNT_POLUT] = le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_POLLUTED]);
+
+		_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_FREEZE, 0);
+		_chk_btc_err(rtwdev, BTC_DCNT_RPT_FREEZE,
+			     pfwinfo->event[BTF_EVNT_RPT]);
+
+		if (le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_RFK_TIMEOUT]) > 0)
+			bt->rfk_info.map.timeout = 1;
+		else
+			bt->rfk_info.map.timeout = 0;
+
+		dm->error.map.bt_rfk_timeout = bt->rfk_info.map.timeout;
 	}
 
 	if (rpt_type >= BTC_RPT_TYPE_BT_VER &&
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 686ff8760c847..6722aa26e48f4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -809,7 +809,7 @@ struct rtw89_mac_ax_gnt {
 	u8 gnt_bt;
 	u8 gnt_wl_sw_en;
 	u8 gnt_wl;
-};
+} __packed;
 
 #define RTW89_MAC_AX_COEX_GNT_NR 2
 struct rtw89_mac_ax_coex_gnt {
@@ -1376,13 +1376,18 @@ struct rtw89_btc_fbtc_tdma {
 #define FCXMAX_STEP 255 /*STEP trace record cnt, Max:65535, default:255*/
 #define BTC_CYCLE_SLOT_MAX 48 /* must be even number, non-zero */
 
-enum rtw89_btc_bt_rfk_counter {
+enum rtw89_btc_bt_sta_counter {
 	BTC_BCNT_RFK_REQ = 0,
 	BTC_BCNT_RFK_GO = 1,
 	BTC_BCNT_RFK_REJECT = 2,
 	BTC_BCNT_RFK_FAIL = 3,
 	BTC_BCNT_RFK_TIMEOUT = 4,
-	BTC_BCNT_RFK_MAX
+	BTC_BCNT_HI_TX = 5,
+	BTC_BCNT_HI_RX = 6,
+	BTC_BCNT_LO_TX = 7,
+	BTC_BCNT_LO_RX = 8,
+	BTC_BCNT_POLLUTED = 9,
+	BTC_BCNT_STA_MAX
 };
 
 struct rtw89_btc_fbtc_rpt_ctrl {
@@ -1399,11 +1404,56 @@ struct rtw89_btc_fbtc_rpt_ctrl {
 	u32 mb_a2dp_empty_cnt; /* a2dp empty count */
 	u32 mb_a2dp_flct_cnt; /* a2dp empty flow control counter */
 	u32 mb_a2dp_full_cnt; /* a2dp empty full counter */
-	u32 bt_rfk_cnt[BTC_BCNT_RFK_MAX];
+	u32 bt_rfk_cnt[BTC_BCNT_HI_TX];
 	u32 c2h_cnt; /* fw send c2h counter  */
 	u32 h2c_cnt; /* fw recv h2c counter */
 } __packed;
 
+struct rtw89_btc_fbtc_rpt_ctrl_info {
+	__le32 cnt; /* fw report counter */
+	__le32 en; /* report map */
+	__le32 para; /* not used */
+
+	__le32 cnt_c2h; /* fw send c2h counter  */
+	__le32 cnt_h2c; /* fw recv h2c counter */
+	__le32 len_c2h; /* The total length of the last C2H  */
+
+	__le32 cnt_aoac_rf_on;  /* rf-on counter for aoac switch notify */
+	__le32 cnt_aoac_rf_off; /* rf-off counter for aoac switch notify */
+} __packed;
+
+struct rtw89_btc_fbtc_rpt_ctrl_wl_fw_info {
+	__le32 cx_ver; /* match which driver's coex version */
+	__le32 cx_offload;
+	__le32 fw_ver;
+} __packed;
+
+struct rtw89_btc_fbtc_rpt_ctrl_a2dp_empty {
+	__le32 cnt_empty; /* a2dp empty count */
+	__le32 cnt_flowctrl; /* a2dp empty flow control counter */
+	__le32 cnt_tx;
+	__le32 cnt_ack;
+	__le32 cnt_nack;
+} __packed;
+
+struct rtw89_btc_fbtc_rpt_ctrl_bt_mailbox {
+	__le32 cnt_send_ok; /* fw send mailbox ok counter */
+	__le32 cnt_send_fail; /* fw send mailbox fail counter */
+	__le32 cnt_recv; /* fw recv mailbox counter */
+	struct rtw89_btc_fbtc_rpt_ctrl_a2dp_empty a2dp;
+} __packed;
+
+struct rtw89_btc_fbtc_rpt_ctrl_v1 {
+	u8 fver;
+	u8 rsvd;
+	__le16 rsvd1;
+	struct rtw89_btc_fbtc_rpt_ctrl_info rpt_info;
+	struct rtw89_btc_fbtc_rpt_ctrl_wl_fw_info wl_fw_info;
+	struct rtw89_btc_fbtc_rpt_ctrl_bt_mailbox bt_mbx_info;
+	__le32 bt_cnt[BTC_BCNT_STA_MAX];
+	struct rtw89_mac_ax_gnt gnt_val[RTW89_PHY_MAX];
+} __packed;
+
 enum rtw89_fbtc_ext_ctrl_type {
 	CXECTL_OFF = 0x0, /* tdma off */
 	CXECTL_B2 = 0x1, /* allow B2 (beacon-early) */
@@ -1707,7 +1757,10 @@ struct rtw89_btc_rpt_cmn_info {
 
 struct rtw89_btc_report_ctrl_state {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
-	struct rtw89_btc_fbtc_rpt_ctrl finfo; /* info from fw */
+	union {
+		struct rtw89_btc_fbtc_rpt_ctrl finfo; /* info from fw for 52A*/
+		struct rtw89_btc_fbtc_rpt_ctrl_v1 finfo_v1; /* info from fw for 52C*/
+	};
 };
 
 struct rtw89_btc_rpt_fbtc_tdma {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 62aa103a8272c..f4012f1e04d91 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2793,23 +2793,7 @@ void rtw8852c_btc_bt_aci_imp(struct rtw89_dev *rtwdev)
 static
 void rtw8852c_btc_update_bt_cnt(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_cx *cx = &btc->cx;
-	u32 val;
-
-	val = rtw89_read32(rtwdev, R_BTC_BT_CNT_HIGH);
-	cx->cnt_bt[BTC_BCNT_HIPRI_TX] = FIELD_GET(B_AX_STATIS_BT_HI_TX_MASK, val);
-	cx->cnt_bt[BTC_BCNT_HIPRI_RX] = FIELD_GET(B_AX_STATIS_BT_HI_RX_MASK, val);
-
-	val = rtw89_read32(rtwdev, R_BTC_BT_CNT_LOW);
-	cx->cnt_bt[BTC_BCNT_LOPRI_TX] = FIELD_GET(B_AX_STATIS_BT_LO_TX_1_MASK, val);
-	cx->cnt_bt[BTC_BCNT_LOPRI_RX] = FIELD_GET(B_AX_STATIS_BT_LO_RX_1_MASK, val);
-
-	/* clock-gate off before reset counter*/
-	rtw89_write32_set(rtwdev, R_AX_BTC_CFG, B_AX_DIS_BTC_CLK_G);
-	rtw89_write32_clr(rtwdev, R_AX_BT_CNT_CFG, B_AX_BT_CNT_RST);
-	rtw89_write32_set(rtwdev, R_AX_BT_CNT_CFG, B_AX_BT_CNT_RST);
-	rtw89_write32_clr(rtwdev, R_AX_BTC_CFG, B_AX_DIS_BTC_CLK_G);
+	/* Feature move to firmware */
 }
 
 static
-- 
2.25.1

