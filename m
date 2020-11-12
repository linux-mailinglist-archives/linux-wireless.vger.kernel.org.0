Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82872AFEC0
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 06:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgKLFim (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 00:38:42 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:38674 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgKLDPg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 22:15:36 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AC3FUYb8025856, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AC3FUYb8025856
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 11:15:30 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 12 Nov 2020 11:15:30 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 02/11] rtw88: coex: remove unnecessary feature/function
Date:   Thu, 12 Nov 2020 11:14:21 +0800
Message-ID: <20201112031430.4846-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201112031430.4846-1-pkshih@realtek.com>
References: <20201112031430.4846-1-pkshih@realtek.com>
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

Because the WLAN RSSI report feature had been implemented at WLAN link info
update function, it is redundant to update WLAN RSSI while BT is updating
link info, so remove the update WLAN RSSI part.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: describe "why" in log
---
 drivers/net/wireless/realtek/rtw88/coex.c | 33 +++++++----------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 50df2e1b4842..f0d300e197b7 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -397,15 +397,16 @@ static void rtw_coex_monitor_bt_enable(struct rtw_dev *rtwdev)
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
 
@@ -612,15 +613,6 @@ static void rtw_coex_update_bt_link_info(struct rtw_dev *rtwdev)
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
@@ -991,7 +983,7 @@ static void rtw_coex_tdma(struct rtw_dev *rtwdev, bool force, u32 tcase)
 	bool turn_on;
 	bool wl_busy = false;
 
-	if (tcase & TDMA_4SLOT)/* 4-slot (50ms) mode */
+	if (tcase & TDMA_4SLOT) /* 4-slot (50ms) mode */
 		rtw_coex_tdma_timer_base(rtwdev, TDMA_TIMER_TYPE_4SLOT);
 	else
 		rtw_coex_tdma_timer_base(rtwdev, TDMA_TIMER_TYPE_2SLOT);
@@ -2864,11 +2856,6 @@ void rtw_coex_wl_fwdbginfo_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 
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

