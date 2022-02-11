Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4210E4B1F30
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 08:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347636AbiBKHQT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 02:16:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345306AbiBKHQS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 02:16:18 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2E4113A
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 23:16:17 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21B7GATX0011271, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21B7GATX0011271
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 15:16:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 15:16:10 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 11 Feb
 2022 15:16:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <ku920601@realtek.com>
Subject: [PATCH 3/6] rtw88: coex: update BT PTA counter regularly
Date:   Fri, 11 Feb 2022 15:15:30 +0800
Message-ID: <20220211071533.34716-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211071533.34716-1-pkshih@realtek.com>
References: <20220211071533.34716-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/11/2022 07:03:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMTEgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

If BT PTA counter can not update regularly, it will lead coex mechanism
run into some unexpected state.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 46 +++++++++++++++++------
 drivers/net/wireless/realtek/rtw88/coex.h |  1 +
 drivers/net/wireless/realtek/rtw88/main.c |  2 +
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 70adaee017626..0aca8f089ebb4 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -460,6 +460,29 @@ static void rtw_coex_gnt_workaround(struct rtw_dev *rtwdev, bool force, u8 mode)
 	rtw_coex_set_gnt_fix(rtwdev);
 }
 
+static void rtw_coex_monitor_bt_ctr(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	u32 tmp;
+
+	tmp = rtw_read32(rtwdev, REG_BT_ACT_STATISTICS);
+	coex_stat->hi_pri_tx = FIELD_GET(MASKLWORD, tmp);
+	coex_stat->hi_pri_rx = FIELD_GET(MASKHWORD, tmp);
+
+	tmp = rtw_read32(rtwdev, REG_BT_ACT_STATISTICS_1);
+	coex_stat->lo_pri_tx = FIELD_GET(MASKLWORD, tmp);
+	coex_stat->lo_pri_rx = FIELD_GET(MASKHWORD, tmp);
+
+	rtw_write8(rtwdev, REG_BT_COEX_ENH_INTR_CTRL,
+		   BIT_R_GRANTALL_WLMASK | BIT_STATIS_BT_EN);
+
+	rtw_dbg(rtwdev, RTW_DBG_COEX,
+		"[BTCoex], Hi-Pri Rx/Tx: %d/%d, Lo-Pri Rx/Tx: %d/%d\n",
+		coex_stat->hi_pri_rx, coex_stat->hi_pri_tx,
+		coex_stat->lo_pri_rx, coex_stat->lo_pri_tx);
+}
+
 static void rtw_coex_monitor_bt_enable(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -3170,6 +3193,17 @@ void rtw_coex_wl_status_change_notify(struct rtw_dev *rtwdev, u32 type)
 	rtw_coex_run_coex(rtwdev, COEX_RSN_WLSTATUS);
 }
 
+void rtw_coex_wl_status_check(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex_stat *coex_stat = &rtwdev->coex.stat;
+
+	if ((coex_stat->wl_under_lps && !coex_stat->wl_force_lps_ctrl) ||
+	    coex_stat->wl_under_ips)
+		return;
+
+	rtw_coex_monitor_bt_ctr(rtwdev);
+}
+
 void rtw_coex_bt_relink_work(struct work_struct *work)
 {
 	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
@@ -3653,7 +3687,6 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 	u16 score_board_WB, score_board_BW;
 	u32 wl_reg_6c0, wl_reg_6c4, wl_reg_6c8, wl_reg_778, wl_reg_6cc;
 	u32 lte_coex, bt_coex;
-	u32 bt_hi_pri, bt_lo_pri;
 	int i;
 
 	score_board_BW = rtw_coex_read_scbd(rtwdev);
@@ -3664,17 +3697,6 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 	wl_reg_6cc = rtw_read32(rtwdev, REG_BT_COEX_TABLE_H);
 	wl_reg_778 = rtw_read8(rtwdev, REG_BT_STAT_CTRL);
 
-	bt_hi_pri = rtw_read32(rtwdev, REG_BT_ACT_STATISTICS);
-	bt_lo_pri = rtw_read32(rtwdev, REG_BT_ACT_STATISTICS_1);
-	rtw_write8(rtwdev, REG_BT_COEX_ENH_INTR_CTRL,
-		   BIT_R_GRANTALL_WLMASK | BIT_STATIS_BT_EN);
-
-	coex_stat->hi_pri_tx = FIELD_GET(MASKLWORD, bt_hi_pri);
-	coex_stat->hi_pri_rx = FIELD_GET(MASKHWORD, bt_hi_pri);
-
-	coex_stat->lo_pri_tx = FIELD_GET(MASKLWORD, bt_lo_pri);
-	coex_stat->lo_pri_rx = FIELD_GET(MASKHWORD, bt_lo_pri);
-
 	sys_lte = rtw_read8(rtwdev, 0x73);
 	lte_coex = rtw_coex_read_indirect_reg(rtwdev, 0x38);
 	bt_coex = rtw_coex_read_indirect_reg(rtwdev, 0x54);
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index fc61a0cab3e43..60a701c8ac13f 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -404,6 +404,7 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length);
 void rtw_coex_wl_fwdbginfo_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length);
 void rtw_coex_switchband_notify(struct rtw_dev *rtwdev, u8 type);
 void rtw_coex_wl_status_change_notify(struct rtw_dev *rtwdev, u32 type);
+void rtw_coex_wl_status_check(struct rtw_dev *rtwdev);
 void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m);
 
 static inline bool rtw_coex_disabled(struct rtw_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 41b6db4226380..da4657ac7c30b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -207,6 +207,8 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	else
 		clear_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
 
+	rtw_coex_wl_status_check(rtwdev);
+
 	if (busy_traffic != test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags))
 		rtw_coex_wl_status_change_notify(rtwdev, 0);
 
-- 
2.25.1

