Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC3B46E448
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 09:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhLIIgz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 03:36:55 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:37341 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbhLIIgy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 03:36:54 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1B98XHPK0006436, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1B98XHPK0006436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 9 Dec 2021 16:33:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 16:33:17 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 9 Dec
 2021 16:33:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <ku920601@realtek.com>
Subject: [PATCH 3/7] rtw89: coex: Add MAC API to get BT polluted counter
Date:   Thu, 9 Dec 2021 16:32:25 +0800
Message-ID: <20211209083229.10815-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209083229.10815-1-pkshih@realtek.com>
References: <20211209083229.10815-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 12/09/2021 08:09:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEyLzkgpFekyCAwNjozMjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Add function to get and parse BT polluted counter.
When WLAN Tx was dropped by BT, the packet will be marked as BT polluted.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c |  6 ++++--
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c  | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  |  1 +
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index c8f912e7344d0..8763114eab274 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1126,6 +1126,9 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		wl->ver_info.fw_coex = prpt->wl_fw_coex_ver;
 		wl->ver_info.fw = prpt->wl_fw_ver;
 		dm->wl_fw_cx_offload = !!(prpt->wl_fw_cx_offload);
+
+		btc->cx.cnt_bt[BTC_BCNT_POLUT] =
+			rtw89_mac_get_plt_cnt(rtwdev, RTW89_MAC_0);
 	}
 
 	if (rpt_type >= BTC_RPT_TYPE_BT_VER &&
@@ -4798,7 +4801,6 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_module *module = &btc->mdinfo;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 	u8 *afh = bt_linfo->afh_map;
-	u16 polt_cnt = 0;
 
 	if (!(btc->dm.coex_info_map & BTC_COEX_INFO_BT))
 		return;
@@ -4884,7 +4886,7 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   " %-15s : Hi-rx = %d, Hi-tx = %d, Lo-rx = %d, Lo-tx = %d (bt_polut_wl_tx = %d)\n",
 		   "[trx_req_cnt]", cx->cnt_bt[BTC_BCNT_HIPRI_RX],
 		   cx->cnt_bt[BTC_BCNT_HIPRI_TX], cx->cnt_bt[BTC_BCNT_LOPRI_RX],
-		   cx->cnt_bt[BTC_BCNT_LOPRI_TX], polt_cnt);
+		   cx->cnt_bt[BTC_BCNT_LOPRI_TX], cx->cnt_bt[BTC_BCNT_POLUT]);
 }
 
 #define CASE_BTC_RSN_STR(e) case BTC_RSN_ ## e: return #e
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c03e3a13bd560..7c84556ec4ada 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -805,6 +805,7 @@ enum rtw89_btc_bt_state_cnt {
 	BTC_BCNT_HIPRI_RX,
 	BTC_BCNT_LOPRI_TX,
 	BTC_BCNT_LOPRI_RX,
+	BTC_BCNT_POLUT,
 	BTC_BCNT_RATECHG,
 	BTC_BCNT_NUM
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 999459489e923..b98c47e9ecfe3 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3450,6 +3450,18 @@ bool rtw89_mac_get_ctrl_path(struct rtw89_dev *rtwdev)
 	return FIELD_GET(B_AX_LTE_MUX_CTRL_PATH >> 24, val);
 }
 
+u16 rtw89_mac_get_plt_cnt(struct rtw89_dev *rtwdev, u8 band)
+{
+	u32 reg;
+	u16 cnt;
+
+	reg = rtw89_mac_reg_by_idx(R_AX_BT_PLT, band);
+	cnt = rtw89_read32_mask(rtwdev, reg, B_AX_BT_PLT_PKT_CNT_MASK);
+	rtw89_write16_set(rtwdev, reg, B_AX_BT_PLT_RST);
+
+	return cnt;
+}
+
 static void rtw89_mac_bfee_ctrl(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
 {
 	u32 reg;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 94cd29bd83d77..b7d13edf7dd19 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -788,6 +788,7 @@ int rtw89_mac_coex_init(struct rtw89_dev *rtwdev, const struct rtw89_mac_ax_coex
 int rtw89_mac_cfg_gnt(struct rtw89_dev *rtwdev,
 		      const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
 int rtw89_mac_cfg_plt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt);
+u16 rtw89_mac_get_plt_cnt(struct rtw89_dev *rtwdev, u8 band);
 void rtw89_mac_cfg_sb(struct rtw89_dev *rtwdev, u32 val);
 u32 rtw89_mac_get_sb(struct rtw89_dev *rtwdev);
 bool rtw89_mac_get_ctrl_path(struct rtw89_dev *rtwdev);
-- 
2.25.1

