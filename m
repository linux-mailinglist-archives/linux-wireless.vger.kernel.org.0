Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15C46AFE69
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 06:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCHFdt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 00:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCHFds (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 00:33:48 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E58B93E28
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 21:33:46 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3285XU4V0016699, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3285XU4V0016699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 8 Mar 2023 13:33:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 8 Mar 2023 13:33:32 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 8 Mar 2023
 13:33:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/7] wifi: rtw89: coex: Add v2 Bluetooth scan info
Date:   Wed, 8 Mar 2023 13:32:24 +0800
Message-ID: <20230308053225.24377-7-pkshih@realtek.com>
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
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Compare to v1 and v2 removed some not usable parameters. Save firmware
code size. The information can show how frequent and how long the
Bluetooth scan do. It will help to debug coexistence issue.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 67 +++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h | 63 +++++++++++++++------
 2 files changed, 106 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 0ca621a9f80a1..b867e54feb896 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -890,13 +890,15 @@ static void _update_bt_report(struct rtw89_dev *rtwdev, u8 rpt_type, u8 *pfinfo)
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 	struct rtw89_btc_bt_a2dp_desc *a2dp = &bt_linfo->a2dp_desc;
 	struct rtw89_btc_fbtc_btver *pver = NULL;
-	struct rtw89_btc_fbtc_btscan *pscan = NULL;
+	struct rtw89_btc_fbtc_btscan_v1 *pscan_v1;
+	struct rtw89_btc_fbtc_btscan_v2 *pscan_v2;
 	struct rtw89_btc_fbtc_btafh *pafh_v1 = NULL;
 	struct rtw89_btc_fbtc_btafh_v2 *pafh_v2 = NULL;
 	struct rtw89_btc_fbtc_btdevinfo *pdev = NULL;
+	bool scan_update = true;
+	int i;
 
 	pver = (struct rtw89_btc_fbtc_btver *)pfinfo;
-	pscan = (struct rtw89_btc_fbtc_btscan *)pfinfo;
 	pdev = (struct rtw89_btc_fbtc_btdevinfo *)pfinfo;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -910,7 +912,26 @@ static void _update_bt_report(struct rtw89_dev *rtwdev, u8 rpt_type, u8 *pfinfo)
 		bt->feature = le32_to_cpu(pver->feature);
 		break;
 	case BTC_RPT_TYPE_BT_SCAN:
-		memcpy(bt->scan_info, pscan->scan, BTC_SCAN_MAX1);
+		if (ver->fcxbtscan == 1) {
+			pscan_v1 = (struct rtw89_btc_fbtc_btscan_v1 *)pfinfo;
+			for (i = 0; i < BTC_SCAN_MAX1; i++) {
+				bt->scan_info_v1[i] = pscan_v1->scan[i];
+				if (bt->scan_info_v1[i].win == 0 &&
+				    bt->scan_info_v1[i].intvl == 0)
+					scan_update = false;
+			}
+		} else if (ver->fcxbtscan == 2) {
+			pscan_v2 = (struct rtw89_btc_fbtc_btscan_v2 *)pfinfo;
+			for (i = 0; i < CXSCAN_MAX; i++) {
+				bt->scan_info_v2[i] = pscan_v2->para[i];
+				if ((pscan_v2->type & BIT(i)) &&
+				    pscan_v2->para[i].win == 0 &&
+				    pscan_v2->para[i].intvl == 0)
+					scan_update = false;
+			}
+		}
+		if (scan_update)
+			bt->scan_info_update = 1;
 		break;
 	case BTC_RPT_TYPE_BT_AFH:
 		if (ver->fcxbtafh == 2) {
@@ -1102,8 +1123,13 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_BT_SCAN:
 		pcinfo = &pfwinfo->rpt_fbtc_btscan.cinfo;
-		pfinfo = &pfwinfo->rpt_fbtc_btscan.finfo;
-		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btscan.finfo);
+		if (ver->fcxbtscan == 1) {
+			pfinfo = &pfwinfo->rpt_fbtc_btscan.finfo.v1;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btscan.finfo.v1);
+		} else if (ver->fcxbtscan == 2) {
+			pfinfo = &pfwinfo->rpt_fbtc_btscan.finfo.v2;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btscan.finfo.v2);
+		}
 		pcinfo->req_fver = ver->fcxbtscan;
 		break;
 	case BTC_RPT_TYPE_BT_AFH:
@@ -6346,11 +6372,40 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   cx->cnt_bt[BTC_BCNT_INFOSAME]);
 
 	seq_printf(m,
-		   " %-15s : Hi-rx = %d, Hi-tx = %d, Lo-rx = %d, Lo-tx = %d (bt_polut_wl_tx = %d)\n",
+		   " %-15s : Hi-rx = %d, Hi-tx = %d, Lo-rx = %d, Lo-tx = %d (bt_polut_wl_tx = %d)",
 		   "[trx_req_cnt]", cx->cnt_bt[BTC_BCNT_HIPRI_RX],
 		   cx->cnt_bt[BTC_BCNT_HIPRI_TX], cx->cnt_bt[BTC_BCNT_LOPRI_RX],
 		   cx->cnt_bt[BTC_BCNT_LOPRI_TX], cx->cnt_bt[BTC_BCNT_POLUT]);
 
+	if (!bt->scan_info_update) {
+		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_SCAN_INFO, true);
+		seq_puts(m, "\n");
+	} else {
+		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_SCAN_INFO, false);
+		if (ver->fcxbtscan == 1) {
+			seq_printf(m,
+				   "(INQ:%d-%d/PAGE:%d-%d/LE:%d-%d/INIT:%d-%d)",
+				   le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INQ].win),
+				   le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INQ].intvl),
+				   le16_to_cpu(bt->scan_info_v1[BTC_SCAN_PAGE].win),
+				   le16_to_cpu(bt->scan_info_v1[BTC_SCAN_PAGE].intvl),
+				   le16_to_cpu(bt->scan_info_v1[BTC_SCAN_BLE].win),
+				   le16_to_cpu(bt->scan_info_v1[BTC_SCAN_BLE].intvl),
+				   le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INIT].win),
+				   le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INIT].intvl));
+		} else if (ver->fcxbtscan == 2) {
+			seq_printf(m,
+				   "(BG:%d-%d/INIT:%d-%d/LE:%d-%d)",
+				   le16_to_cpu(bt->scan_info_v2[CXSCAN_BG].win),
+				   le16_to_cpu(bt->scan_info_v2[CXSCAN_BG].intvl),
+				   le16_to_cpu(bt->scan_info_v2[CXSCAN_INIT].win),
+				   le16_to_cpu(bt->scan_info_v2[CXSCAN_INIT].intvl),
+				   le16_to_cpu(bt->scan_info_v2[CXSCAN_LE].win),
+				   le16_to_cpu(bt->scan_info_v2[CXSCAN_LE].intvl));
+		}
+		seq_puts(m, "\n");
+	}
+
 	if (bt->enable.now && bt->ver_info.fw == 0)
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_VER_INFO, true);
 	else
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b021366f960d4..d785d1326e498 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1445,14 +1445,6 @@ struct rtw89_btc_wl_tx_limit_para {
 	u16 tx_retry;
 };
 
-struct rtw89_btc_bt_scan_info {
-	u16 win;
-	u16 intvl;
-	u32 enable: 1;
-	u32 interlace: 1;
-	u32 rsvd: 30;
-};
-
 enum rtw89_btc_bt_scan_type {
 	BTC_SCAN_INQ	= 0,
 	BTC_SCAN_PAGE,
@@ -1463,9 +1455,50 @@ enum rtw89_btc_bt_scan_type {
 	BTC_SCAN_MAX1,
 };
 
+enum rtw89_btc_ble_scan_type {
+	CXSCAN_BG = 0,
+	CXSCAN_INIT,
+	CXSCAN_LE,
+	CXSCAN_MAX
+};
+
+#define RTW89_BTC_BTC_SCAN_V1_FLAG_ENABLE BIT(0)
+#define RTW89_BTC_BTC_SCAN_V1_FLAG_INTERLACE BIT(1)
+
+struct rtw89_btc_bt_scan_info_v1 {
+	__le16 win;
+	__le16 intvl;
+	__le32 flags;
+} __packed;
+
+struct rtw89_btc_bt_scan_info_v2 {
+	__le16 win;
+	__le16 intvl;
+} __packed;
+
+struct rtw89_btc_fbtc_btscan_v1 {
+	u8 fver; /* btc_ver::fcxbtscan */
+	u8 rsvd;
+	__le16 rsvd2;
+	struct rtw89_btc_bt_scan_info_v1 scan[BTC_SCAN_MAX1];
+} __packed;
+
+struct rtw89_btc_fbtc_btscan_v2 {
+	u8 fver; /* btc_ver::fcxbtscan */
+	u8 type;
+	__le16 rsvd2;
+	struct rtw89_btc_bt_scan_info_v2 para[CXSCAN_MAX];
+} __packed;
+
+union rtw89_btc_fbtc_btscan {
+	struct rtw89_btc_fbtc_btscan_v1 v1;
+	struct rtw89_btc_fbtc_btscan_v2 v2;
+};
+
 struct rtw89_btc_bt_info {
 	struct rtw89_btc_bt_link_info link_info;
-	struct rtw89_btc_bt_scan_info scan_info[BTC_SCAN_MAX1];
+	struct rtw89_btc_bt_scan_info_v1 scan_info_v1[BTC_SCAN_MAX1];
+	struct rtw89_btc_bt_scan_info_v2 scan_info_v2[CXSCAN_MAX];
 	struct rtw89_btc_bt_ver_info ver_info;
 	struct rtw89_btc_bool_sta_chg enable;
 	struct rtw89_btc_bool_sta_chg inq_pag;
@@ -1488,7 +1521,8 @@ struct rtw89_btc_bt_info {
 	u32 run_patch_code: 1;
 	u32 hi_lna_rx: 1;
 	u32 scan_rx_low_pri: 1;
-	u32 rsvd: 21;
+	u32 scan_info_update: 1;
+	u32 rsvd: 20;
 };
 
 struct rtw89_btc_cx {
@@ -2006,13 +2040,6 @@ struct rtw89_btc_fbtc_btver {
 	__le32 feature;
 } __packed;
 
-struct rtw89_btc_fbtc_btscan {
-	u8 fver; /* btc_ver::fcxbtscan */
-	u8 rsvd;
-	__le16 rsvd2;
-	u8 scan[6];
-} __packed;
-
 struct rtw89_btc_fbtc_btafh {
 	u8 fver; /* btc_ver::fcxbtafh */
 	u8 rsvd;
@@ -2231,7 +2258,7 @@ struct rtw89_btc_rpt_fbtc_btver {
 
 struct rtw89_btc_rpt_fbtc_btscan {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
-	struct rtw89_btc_fbtc_btscan finfo; /* info from fw */
+	union rtw89_btc_fbtc_btscan finfo; /* info from fw */
 };
 
 struct rtw89_btc_rpt_fbtc_btafh {
-- 
2.25.1

