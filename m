Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA3CF4EB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 10:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfJHIVR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 04:21:17 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47352 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730614AbfJHIVQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 04:21:16 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x988LB8s028158, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x988LB8s028158
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 8 Oct 2019 16:21:11 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 8 Oct 2019 16:21:10 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 09/10] rtw88: coex: Set 4 slot mode for A2DP
Date:   Tue, 8 Oct 2019 16:21:00 +0800
Message-ID: <20191008082101.2494-10-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008082101.2494-1-yhchuang@realtek.com>
References: <20191008082101.2494-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

With shallow buffer size, certain BT devices have active
A2DP flow control to fill buffer frequently. If the slot
is not at BT side, data can't be sent successfully to BT
devices, and will cause audio glitch.

To resolve this issue, this commit splits TUs into 4-slots
instead of 2-slot for all of the A2DP related coexistence
strategies. That makes BT have higher opportunity to fill
the A2DP buffer in time, and the audio quality could be
more stable and smooth.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 24 ++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 9d8cbd91e5ff..4dfb2ec395ee 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1302,6 +1302,7 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	bool wl_hi_pri = false;
 	u8 table_case, tdma_case;
+	u32 slot_type = 0;
 
 	if (coex_stat->wl_linkscan_proc || coex_stat->wl_hi_pri_task1 ||
 	    coex_stat->wl_hi_pri_task2)
@@ -1312,14 +1313,16 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 		if (wl_hi_pri) {
 			table_case = 15;
 			if (coex_stat->bt_a2dp_exist &&
-			    !coex_stat->bt_pan_exist)
+			    !coex_stat->bt_pan_exist) {
+				slot_type = TDMA_4SLOT;
 				tdma_case = 11;
-			else if (coex_stat->wl_hi_pri_task1)
+			} else if (coex_stat->wl_hi_pri_task1) {
 				tdma_case = 6;
-			else if (!coex_stat->bt_page)
+			} else if (!coex_stat->bt_page) {
 				tdma_case = 8;
-			else
+			} else {
 				tdma_case = 9;
+			}
 		} else if (coex_stat->wl_connected) {
 			table_case = 10;
 			tdma_case = 10;
@@ -1355,7 +1358,7 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
-	rtw_coex_tdma(rtwdev, false, tdma_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
 
 static void rtw_coex_action_bt_hfp(struct rtw_dev *rtwdev)
@@ -1469,13 +1472,13 @@ static void rtw_coex_action_bt_a2dp(struct rtw_dev *rtwdev)
 
 	if (efuse->share_ant) {
 		/* Shared-Ant */
+		slot_type = TDMA_4SLOT;
+
 		if (coex_stat->wl_gl_busy && coex_stat->wl_noisy_level == 0)
 			table_case = 10;
 		else
 			table_case = 9;
 
-		slot_type = TDMA_4SLOT;
-
 		if (coex_stat->wl_gl_busy)
 			tdma_case = 13;
 		else
@@ -1579,13 +1582,14 @@ static void rtw_coex_action_bt_a2dp_hid(struct rtw_dev *rtwdev)
 
 	if (efuse->share_ant) {
 		/* Shared-Ant */
+		slot_type = TDMA_4SLOT;
+
 		if (coex_stat->bt_ble_exist)
 			table_case = 26;
 		else
 			table_case = 9;
 
 		if (coex_stat->wl_gl_busy) {
-			slot_type = TDMA_4SLOT;
 			tdma_case = 13;
 		} else {
 			tdma_case = 14;
@@ -1788,10 +1792,12 @@ static void rtw_coex_action_wl_linkscan(struct rtw_dev *rtwdev)
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
+	u32 slot_type = 0;
 
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		if (coex_stat->bt_a2dp_exist) {
+			slot_type = TDMA_4SLOT;
 			table_case = 9;
 			tdma_case = 11;
 		} else {
@@ -1812,7 +1818,7 @@ static void rtw_coex_action_wl_linkscan(struct rtw_dev *rtwdev)
 	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
-	rtw_coex_tdma(rtwdev, false, tdma_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
 
 static void rtw_coex_action_wl_not_connected(struct rtw_dev *rtwdev)
-- 
2.17.1

