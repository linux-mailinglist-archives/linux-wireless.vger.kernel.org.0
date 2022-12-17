Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8416B64F93A
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 15:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiLQOSW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Dec 2022 09:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiLQOSQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Dec 2022 09:18:16 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43E856438
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:18:15 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BHEHDLe8024825, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BHEHDLe8024825
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 17 Dec 2022 22:17:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 17 Dec 2022 22:18:03 +0800
Received: from localhost (172.16.16.141) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 17 Dec
 2022 22:18:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/7] wifi: rtw89: coex: Add v2 BT AFH report and related variable
Date:   Sat, 17 Dec 2022 22:17:43 +0800
Message-ID: <20221217141745.43291-6-pkshih@realtek.com>
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

Wi-Fi firmware update AFH report feature to version 2. If there is BT BLE
device connect to DUT, the mechanism will send H2C to request BT BLE
channel map, it will help to debug.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 54 ++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h | 26 ++++++++++-
 2 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 6840f0363d96c..13764bfdd0bea 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -854,17 +854,18 @@ static void _chk_btc_err(struct rtw89_dev *rtwdev, u8 type, u32 cnt)
 static void _update_bt_report(struct rtw89_dev *rtwdev, u8 rpt_type, u8 *pfinfo)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 	struct rtw89_btc_bt_a2dp_desc *a2dp = &bt_linfo->a2dp_desc;
 	struct rtw89_btc_fbtc_btver *pver = NULL;
 	struct rtw89_btc_fbtc_btscan *pscan = NULL;
-	struct rtw89_btc_fbtc_btafh *pafh = NULL;
+	struct rtw89_btc_fbtc_btafh *pafh_v1 = NULL;
+	struct rtw89_btc_fbtc_btafh_v2 *pafh_v2 = NULL;
 	struct rtw89_btc_fbtc_btdevinfo *pdev = NULL;
 
 	pver = (struct rtw89_btc_fbtc_btver *)pfinfo;
 	pscan = (struct rtw89_btc_fbtc_btscan *)pfinfo;
-	pafh = (struct rtw89_btc_fbtc_btafh *)pfinfo;
 	pdev = (struct rtw89_btc_fbtc_btdevinfo *)pfinfo;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -881,9 +882,23 @@ static void _update_bt_report(struct rtw89_dev *rtwdev, u8 rpt_type, u8 *pfinfo)
 		memcpy(bt->scan_info, pscan->scan, BTC_SCAN_MAX1);
 		break;
 	case BTC_RPT_TYPE_BT_AFH:
-		memcpy(&bt_linfo->afh_map[0], pafh->afh_l, 4);
-		memcpy(&bt_linfo->afh_map[4], pafh->afh_m, 4);
-		memcpy(&bt_linfo->afh_map[8], pafh->afh_h, 2);
+		if (ver->fcxbtafh == 2) {
+			pafh_v2 = (struct rtw89_btc_fbtc_btafh_v2 *)pfinfo;
+			if (pafh_v2->map_type & RPT_BT_AFH_SEQ_LEGACY) {
+				memcpy(&bt_linfo->afh_map[0], pafh_v2->afh_l, 4);
+				memcpy(&bt_linfo->afh_map[4], pafh_v2->afh_m, 4);
+				memcpy(&bt_linfo->afh_map[8], pafh_v2->afh_h, 2);
+			}
+			if (pafh_v2->map_type & RPT_BT_AFH_SEQ_LE) {
+				memcpy(&bt_linfo->afh_map_le[0], pafh_v2->afh_le_a, 4);
+				memcpy(&bt_linfo->afh_map_le[4], pafh_v2->afh_le_b, 1);
+			}
+		} else if (ver->fcxbtafh == 1) {
+			pafh_v1 = (struct rtw89_btc_fbtc_btafh *)pfinfo;
+			memcpy(&bt_linfo->afh_map[0], pafh_v1->afh_l, 4);
+			memcpy(&bt_linfo->afh_map[4], pafh_v1->afh_m, 4);
+			memcpy(&bt_linfo->afh_map[8], pafh_v1->afh_h, 2);
+		}
 		break;
 	case BTC_RPT_TYPE_BT_DEVICE:
 		a2dp->device_name = le32_to_cpu(pdev->dev_name);
@@ -1132,8 +1147,15 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_BT_AFH:
 		pcinfo = &pfwinfo->rpt_fbtc_btafh.cinfo;
-		pfinfo = &pfwinfo->rpt_fbtc_btafh.finfo;
-		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btafh.finfo);
+		if (ver->fcxbtafh == 1) {
+			pfinfo = &pfwinfo->rpt_fbtc_btafh.finfo.v1;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btafh.finfo.v1);
+		} else if (ver->fcxbtafh == 2) {
+			pfinfo = &pfwinfo->rpt_fbtc_btafh.finfo.v2;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btafh.finfo.v2);
+		} else {
+			goto err;
+		}
 		pcinfo->req_fver = ver->fcxbtafh;
 		pcinfo->rx_len = rpt_len;
 		pcinfo->rx_cnt++;
@@ -1393,6 +1415,11 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		_update_bt_report(rtwdev, rpt_type, pfinfo);
 
 	return (rpt_len + BTC_RPT_HDR_SIZE);
+
+err:
+	rtw89_debug(rtwdev, RTW89_DBG_BTC,
+		    "[BTC], %s(): Undefined version for type=%d\n", __func__, rpt_type);
+	return 0;
 }
 
 static void _parse_btc_report(struct rtw89_dev *rtwdev,
@@ -5919,12 +5946,14 @@ static void _show_bt_profile_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_bt_info *bt = &cx->bt;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 	struct rtw89_btc_module *module = &btc->mdinfo;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 	u8 *afh = bt_linfo->afh_map;
+	u8 *afh_le = bt_linfo->afh_map_le;
 
 	if (!(btc->dm.coex_info_map & BTC_COEX_INFO_BT))
 		return;
@@ -5974,6 +6003,12 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   afh[0], afh[1], afh[2], afh[3], afh[4],
 		   afh[5], afh[6], afh[7], afh[8], afh[9]);
 
+	if (ver->fcxbtafh == 2 && bt_linfo->status.map.ble_connect)
+		seq_printf(m,
+			   "LE[%02x%02x_%02x_%02x%02x]",
+			   afh_le[0], afh_le[1], afh_le[2],
+			   afh_le[3], afh_le[4]);
+
 	seq_printf(m, "wl_ch_map[en:%d/ch:%d/bw:%d]\n",
 		   wl->afh_info.en, wl->afh_info.ch, wl->afh_info.bw);
 
@@ -6016,6 +6051,11 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	else
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_AFH_MAP, false);
 
+	if (ver->fcxbtafh == 2 && bt_linfo->status.map.ble_connect)
+		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_AFH_MAP_LE, true);
+	else
+		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_AFH_MAP_LE, false);
+
 	if (bt_linfo->a2dp_desc.exist &&
 	    (bt_linfo->a2dp_desc.flush_time == 0 ||
 	     bt_linfo->a2dp_desc.vendor_id == 0 ||
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 358bfcd9ece20..af42e67897b6e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1264,6 +1264,7 @@ union rtw89_btc_bt_state_map {
 
 #define BTC_BT_RSSI_THMAX 4
 #define BTC_BT_AFH_GROUP 12
+#define BTC_BT_AFH_LE_GROUP 5
 
 struct rtw89_btc_bt_link_info {
 	struct rtw89_btc_u8_sta_chg profile_cnt;
@@ -1279,6 +1280,7 @@ struct rtw89_btc_bt_link_info {
 	u8 golden_rx_shift[BTC_PROFILE_MAX];
 	u8 rssi_state[BTC_BT_RSSI_THMAX];
 	u8 afh_map[BTC_BT_AFH_GROUP];
+	u8 afh_map_le[BTC_BT_AFH_LE_GROUP];
 
 	u32 role_sw: 1;
 	u32 slave_role: 1;
@@ -1605,6 +1607,11 @@ enum { /* STEP TYPE */
 	CXSTEP_MAX,
 };
 
+enum rtw89_btc_afh_map_type { /*AFH MAP TYPE */
+	RPT_BT_AFH_SEQ_LEGACY = 0x10,
+	RPT_BT_AFH_SEQ_LE = 0x20
+};
+
 #define BTC_DBG_MAX1  32
 struct rtw89_btc_fbtc_gpio_dbg {
 	u8 fver; /* btc_ver::fcxgpiodbg */
@@ -1792,6 +1799,18 @@ struct rtw89_btc_fbtc_btafh {
 	u8 afh_h[4]; /*bit0:2466, bit1:2467......bit14:2480 */
 } __packed;
 
+struct rtw89_btc_fbtc_btafh_v2 {
+	u8 fver; /* btc_ver::fcxbtafh */
+	u8 rsvd;
+	u8 rsvd2;
+	u8 map_type;
+	u8 afh_l[4];
+	u8 afh_m[4];
+	u8 afh_h[4];
+	u8 afh_le_a[4];
+	u8 afh_le_b[4];
+} __packed;
+
 struct rtw89_btc_fbtc_btdevinfo {
 	u8 fver; /* btc_ver::fcxbtdevinfo */
 	u8 rsvd;
@@ -1912,6 +1931,11 @@ struct rtw89_btc_rpt_cmn_info {
 	u8 valid;
 } __packed;
 
+union rtw89_btc_fbtc_btafh_info {
+	struct rtw89_btc_fbtc_btafh v1;
+	struct rtw89_btc_fbtc_btafh_v2 v2;
+};
+
 struct rtw89_btc_report_ctrl_state {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
 	union {
@@ -1979,7 +2003,7 @@ struct rtw89_btc_rpt_fbtc_btscan {
 
 struct rtw89_btc_rpt_fbtc_btafh {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
-	struct rtw89_btc_fbtc_btafh finfo; /* info from fw */
+	union rtw89_btc_fbtc_btafh_info finfo;
 };
 
 struct rtw89_btc_rpt_fbtc_btdev {
-- 
2.25.1

