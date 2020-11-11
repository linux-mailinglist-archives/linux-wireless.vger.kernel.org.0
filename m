Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7922AE656
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 03:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732473AbgKKCWV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 21:22:21 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39285 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732123AbgKKCWU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 21:22:20 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AB2MCES0027711, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AB2MCES0027711
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Nov 2020 10:22:12 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 11 Nov 2020 10:22:12 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 02/11] rtw88: coex: remove unnecessary feature/function
Date:   Wed, 11 Nov 2020 10:20:59 +0800
Message-ID: <20201111022108.9834-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201111022108.9834-1-pkshih@realtek.com>
References: <20201111022108.9834-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

It is redundant to update WLAN RSSI, remove the update WLAN RSSI part.
Remove unused function.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 33 +++++++----------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 141aaa60c805..3a26453f4316 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -398,15 +398,16 @@ static void rtw_coex_monitor_bt_enable(struct rtw_dev *rtwdev)
 		coex_stat->bt_disabled = bt_disabled;
 		coex_stat->bt_ble_scan_type = 0;
 		coex_dm->cur_bt_lna_lvl = 0;
-	}
 
-	if (!coex_stat->bt_disabled) {
-		coex_stat->bt_reenable = true;
-		ieee80211_queue_delayed_work(rtwdev->hw,
-					     &coex->bt_reenable_work, 15 * HZ);
-	} else {
-		coex_stat->bt_mailbox_reply = false;
-		coex_stat->bt_reenable = false;
+		if (!coex_stat->bt_disabled) {
+			coex_stat->bt_reenable = true;
+			ieee80211_queue_delayed_work(rtwdev->hw,
+						     &coex->bt_reenable_work,
+						     15 * HZ);
+		} else {
+			coex_stat->bt_mailbox_reply = false;
+			coex_stat->bt_reenable = false;
+		}
 	}
 }
 
@@ -613,15 +614,6 @@ static void rtw_coex_update_bt_link_info(struct rtw_dev *rtwdev)
 		coex_dm->bt_rssi_state[i] = rssi_state;
 	}
 
-	for (i = 0; i < COEX_RSSI_STEP; i++) {
-		rssi_state = coex_dm->wl_rssi_state[i];
-		rssi_step = chip->wl_rssi_step[i];
-		rssi = rtwdev->dm_info.min_rssi;
-		rssi_state = rtw_coex_next_rssi_state(rtwdev, rssi_state,
-						      rssi, rssi_step);
-		coex_dm->wl_rssi_state[i] = rssi_state;
-	}
-
 	if (coex_stat->bt_ble_scan_en &&
 	    coex_stat->cnt_bt[COEX_CNT_BT_INFOUPDATE] % 3 == 0) {
 		u8 scan_type;
@@ -992,7 +984,7 @@ static void rtw_coex_tdma(struct rtw_dev *rtwdev, bool force, u32 tcase)
 	bool turn_on;
 	bool wl_busy = false;
 
-	if (tcase & TDMA_4SLOT)/* 4-slot (50ms) mode */
+	if (tcase & TDMA_4SLOT) /* 4-slot (50ms) mode */
 		rtw_coex_tdma_timer_base(rtwdev, 3);
 	else
 		rtw_coex_tdma_timer_base(rtwdev, 0);
@@ -2865,11 +2857,6 @@ void rtw_coex_wl_fwdbginfo_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 
 void rtw_coex_wl_status_change_notify(struct rtw_dev *rtwdev, u32 type)
 {
-	struct rtw_coex *coex = &rtwdev->coex;
-
-	if (coex->stop_dm)
-		return;
-
 	rtw_coex_run_coex(rtwdev, COEX_RSN_WLSTATUS);
 }
 
-- 
2.21.0

