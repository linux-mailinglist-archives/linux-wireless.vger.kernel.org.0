Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4C665C162
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 15:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbjACODo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 09:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbjACODY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 09:03:24 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8DAD10578
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 06:03:21 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 303E2DwQ4016751, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 303E2DwQ4016751
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 3 Jan 2023 22:02:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 3 Jan 2023 22:03:08 +0800
Received: from localhost (172.16.19.22) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 3 Jan 2023
 22:03:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/7] wifi: rtw89: coex: Change firmware control report to version separate
Date:   Tue, 3 Jan 2023 22:02:35 +0800
Message-ID: <20230103140238.15601-5-pkshih@realtek.com>
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

The rtw89 driver may support more than 1 version of Wi-Fi firmware for
certain chips. In order to support all the firmware, change to select logic
by firmware feature version code. Type control version 4 will monitor
Bluetooth PTA hardware counters at firmware and C2H to driver, but
version 1 will not do this.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 76 ++++++++++++-----------
 drivers/net/wireless/realtek/rtw89/core.h | 14 +++--
 2 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index b25329d1806a4..e5aa0d663cdd6 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -930,8 +930,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
-	struct rtw89_btc_fbtc_rpt_ctrl *prpt;
-	struct rtw89_btc_fbtc_rpt_ctrl_v1 *prpt_v1;
+	union rtw89_btc_fbtc_rpt_ctrl_ver_info *prpt = NULL;
 	union rtw89_btc_fbtc_cysta_info *pcysta = NULL;
 	struct rtw89_btc_prpt *btc_prpt = NULL;
 	void *rpt_content = NULL, *pfinfo = NULL;
@@ -962,12 +961,15 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	switch (rpt_type) {
 	case BTC_RPT_TYPE_CTRL:
 		pcinfo = &pfwinfo->rpt_ctrl.cinfo;
-		if (chip->chip_id == RTL8852A) {
-			pfinfo = &pfwinfo->rpt_ctrl.finfo;
-			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo);
+		prpt = &pfwinfo->rpt_ctrl.finfo;
+		if (ver->fcxbtcrpt == 1) {
+			pfinfo = &pfwinfo->rpt_ctrl.finfo.v1;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v1);
+		} else if (ver->fcxbtcrpt == 4) {
+			pfinfo = &pfwinfo->rpt_ctrl.finfo.v4;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v4);
 		} else {
-			pfinfo = &pfwinfo->rpt_ctrl.finfo_v1;
-			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo_v1);
+			goto err;
 		}
 		pcinfo->req_fver = ver->fcxbtcrpt;
 		break;
@@ -1109,12 +1111,12 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 
 	switch (rpt_type) {
 	case BTC_RPT_TYPE_CTRL:
-		if (chip->chip_id == RTL8852A) {
-			prpt = &pfwinfo->rpt_ctrl.finfo;
-			btc->fwinfo.rpt_en_map = prpt->rpt_enable;
-			wl->ver_info.fw_coex = prpt->wl_fw_coex_ver;
-			wl->ver_info.fw = prpt->wl_fw_ver;
-			dm->wl_fw_cx_offload = !!prpt->wl_fw_cx_offload;
+		if (ver->fcxbtcrpt == 1) {
+			prpt->v1 = pfwinfo->rpt_ctrl.finfo.v1;
+			btc->fwinfo.rpt_en_map = prpt->v1.rpt_enable;
+			wl->ver_info.fw_coex = prpt->v1.wl_fw_coex_ver;
+			wl->ver_info.fw = prpt->v1.wl_fw_ver;
+			dm->wl_fw_cx_offload = !!prpt->v1.wl_fw_cx_offload;
 
 			_chk_btc_err(rtwdev, BTC_DCNT_RPT_FREEZE,
 				     pfwinfo->event[BTF_EVNT_RPT]);
@@ -1129,38 +1131,40 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 					rtw89_mac_get_plt_cnt(rtwdev,
 							      RTW89_MAC_0);
 			}
-		} else {
-			prpt_v1 = &pfwinfo->rpt_ctrl.finfo_v1;
-			btc->fwinfo.rpt_en_map = le32_to_cpu(prpt_v1->rpt_info.en);
-			wl->ver_info.fw_coex = le32_to_cpu(prpt_v1->wl_fw_info.cx_ver);
-			wl->ver_info.fw = le32_to_cpu(prpt_v1->wl_fw_info.fw_ver);
-			dm->wl_fw_cx_offload = !!le32_to_cpu(prpt_v1->wl_fw_info.cx_offload);
+		} else if (ver->fcxbtcrpt == 4) {
+			prpt->v4 = pfwinfo->rpt_ctrl.finfo.v4;
+			btc->fwinfo.rpt_en_map = le32_to_cpu(prpt->v4.rpt_info.en);
+			wl->ver_info.fw_coex = le32_to_cpu(prpt->v4.wl_fw_info.cx_ver);
+			wl->ver_info.fw = le32_to_cpu(prpt->v4.wl_fw_info.fw_ver);
+			dm->wl_fw_cx_offload = !!le32_to_cpu(prpt->v4.wl_fw_info.cx_offload);
 
 			for (i = RTW89_PHY_0; i < RTW89_PHY_MAX; i++)
-				memcpy(&dm->gnt.band[i], &prpt_v1->gnt_val[i],
+				memcpy(&dm->gnt.band[i], &prpt->v4.gnt_val[i],
 				       sizeof(dm->gnt.band[i]));
 
 			btc->cx.cnt_bt[BTC_BCNT_HIPRI_TX] =
-				le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_HI_TX]);
+				le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_HI_TX]);
 			btc->cx.cnt_bt[BTC_BCNT_HIPRI_RX] =
-				le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_HI_RX]);
+				le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_HI_RX]);
 			btc->cx.cnt_bt[BTC_BCNT_LOPRI_TX] =
-				le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_LO_TX]);
+				le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_LO_TX]);
 			btc->cx.cnt_bt[BTC_BCNT_LOPRI_RX] =
-				le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_LO_RX]);
+				le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_LO_RX]);
 			btc->cx.cnt_bt[BTC_BCNT_POLUT] =
-				le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_POLLUTED]);
+				le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_POLLUTED]);
 
 			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_FREEZE, 0);
 			_chk_btc_err(rtwdev, BTC_DCNT_RPT_FREEZE,
 				     pfwinfo->event[BTF_EVNT_RPT]);
 
-			if (le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_RFK_TIMEOUT]) > 0)
+			if (le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_RFK_TIMEOUT]) > 0)
 				bt->rfk_info.map.timeout = 1;
 			else
 				bt->rfk_info.map.timeout = 0;
 
 			dm->error.map.bt_rfk_timeout = bt->rfk_info.map.timeout;
+		} else {
+			goto err;
 		}
 		break;
 	case BTC_RPT_TYPE_TDMA:
@@ -7061,12 +7065,12 @@ static void _show_mreg(struct rtw89_dev *rtwdev, struct seq_file *m)
 	seq_puts(m, "\n");
 }
 
-static void _show_summary(struct rtw89_dev *rtwdev, struct seq_file *m)
+static void _show_summary_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
-	struct rtw89_btc_fbtc_rpt_ctrl *prptctrl = NULL;
+	struct rtw89_btc_fbtc_rpt_ctrl_v1 *prptctrl = NULL;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
@@ -7081,7 +7085,7 @@ static void _show_summary(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 	pcinfo = &pfwinfo->rpt_ctrl.cinfo;
 	if (pcinfo->valid && !wl->status.map.lps && !wl->status.map.rf_off) {
-		prptctrl = &pfwinfo->rpt_ctrl.finfo;
+		prptctrl = &pfwinfo->rpt_ctrl.finfo.v1;
 
 		seq_printf(m,
 			   " %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d), c2h_cnt=%d(fw_send:%d), ",
@@ -7165,11 +7169,11 @@ static void _show_summary(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   cnt[BTC_NCNT_CUSTOMERIZE]);
 }
 
-static void _show_summary_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
+static void _show_summary_v4(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
-	struct rtw89_btc_fbtc_rpt_ctrl_v1 *prptctrl;
+	struct rtw89_btc_fbtc_rpt_ctrl_v4 *prptctrl;
 	struct rtw89_btc_rpt_cmn_info *pcinfo;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_dm *dm = &btc->dm;
@@ -7185,7 +7189,7 @@ static void _show_summary_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 	pcinfo = &pfwinfo->rpt_ctrl.cinfo;
 	if (pcinfo->valid && !wl->status.map.lps && !wl->status.map.rf_off) {
-		prptctrl = &pfwinfo->rpt_ctrl.finfo_v1;
+		prptctrl = &pfwinfo->rpt_ctrl.finfo.v4;
 
 		seq_printf(m,
 			   " %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d), c2h_cnt=%d(fw_send:%d), ",
@@ -7279,9 +7283,9 @@ static void _show_summary_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 void rtw89_btc_dump_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_fw_suit *fw_suit = &rtwdev->fw.normal;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_bt_info *bt = &cx->bt;
 
@@ -7310,10 +7314,10 @@ void rtw89_btc_dump_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	_show_dm_info(rtwdev, m);
 	_show_fw_dm_msg(rtwdev, m);
 	_show_mreg(rtwdev, m);
-	if (chip->chip_id == RTL8852A)
-		_show_summary(rtwdev, m);
-	else
+	if (ver->fcxbtcrpt == 1)
 		_show_summary_v1(rtwdev, m);
+	else if (ver->fcxbtcrpt == 4)
+		_show_summary_v4(rtwdev, m);
 }
 
 void rtw89_coex_recognize_ver(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 9f4cb83a8326f..384eb9cb92240 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1480,7 +1480,7 @@ enum rtw89_btc_bt_sta_counter {
 	BTC_BCNT_STA_MAX
 };
 
-struct rtw89_btc_fbtc_rpt_ctrl {
+struct rtw89_btc_fbtc_rpt_ctrl_v1 {
 	u16 fver; /* btc_ver::fcxbtcrpt */
 	u16 rpt_cnt; /* tmr counters */
 	u32 wl_fw_coex_ver; /* match which driver's coex version */
@@ -1533,7 +1533,7 @@ struct rtw89_btc_fbtc_rpt_ctrl_bt_mailbox {
 	struct rtw89_btc_fbtc_rpt_ctrl_a2dp_empty a2dp;
 } __packed;
 
-struct rtw89_btc_fbtc_rpt_ctrl_v1 {
+struct rtw89_btc_fbtc_rpt_ctrl_v4 {
 	u8 fver;
 	u8 rsvd;
 	__le16 rsvd1;
@@ -1544,6 +1544,11 @@ struct rtw89_btc_fbtc_rpt_ctrl_v1 {
 	struct rtw89_mac_ax_gnt gnt_val[RTW89_PHY_MAX];
 } __packed;
 
+union rtw89_btc_fbtc_rpt_ctrl_ver_info {
+	struct rtw89_btc_fbtc_rpt_ctrl_v1 v1;
+	struct rtw89_btc_fbtc_rpt_ctrl_v4 v4;
+};
+
 enum rtw89_fbtc_ext_ctrl_type {
 	CXECTL_OFF = 0x0, /* tdma off */
 	CXECTL_B2 = 0x1, /* allow B2 (beacon-early) */
@@ -2015,10 +2020,7 @@ union rtw89_btc_fbtc_btafh_info {
 
 struct rtw89_btc_report_ctrl_state {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
-	union {
-		struct rtw89_btc_fbtc_rpt_ctrl finfo; /* info from fw for 52A*/
-		struct rtw89_btc_fbtc_rpt_ctrl_v1 finfo_v1; /* info from fw for 52C*/
-	};
+	union rtw89_btc_fbtc_rpt_ctrl_ver_info finfo;
 };
 
 struct rtw89_btc_rpt_fbtc_tdma {
-- 
2.25.1

