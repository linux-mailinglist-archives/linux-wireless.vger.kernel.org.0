Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB5BB3504
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2019 09:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfIPHD6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Sep 2019 03:03:58 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60326 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfIPHD6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Sep 2019 03:03:58 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8G73oUb029955, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8G73oUb029955
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 16 Sep 2019 15:03:50 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 16 Sep 2019 15:03:50 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 01/15] rtw88: remove redundant flag check helper function
Date:   Mon, 16 Sep 2019 15:03:31 +0800
Message-ID: <1568617425-28062-2-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568617425-28062-1-git-send-email-yhchuang@realtek.com>
References: <1568617425-28062-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

These helper functions seems useless. And in some cases
we want to use test_and_[set/clear]_bit, these helpers
will make the code more complicated. So remove them.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c     |  4 ++--
 drivers/net/wireless/realtek/rtw88/mac.c      |  2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c | 10 +++++-----
 drivers/net/wireless/realtek/rtw88/main.c     | 20 ++++++++++----------
 drivers/net/wireless/realtek/rtw88/main.h     | 15 ---------------
 drivers/net/wireless/realtek/rtw88/phy.c      |  2 +-
 drivers/net/wireless/realtek/rtw88/ps.c       | 10 +++++-----
 7 files changed, 24 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 793b40b..4a0b569 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -383,9 +383,9 @@ static void rtw_coex_update_wl_link_info(struct rtw_dev *rtwdev, u8 reason)
 	u8 rssi_step;
 	u8 rssi;
 
-	scan = rtw_flag_check(rtwdev, RTW_FLAG_SCANNING);
+	scan = test_bit(RTW_FLAG_SCANNING, rtwdev->flags);
 	coex_stat->wl_connected = !!rtwdev->sta_cnt;
-	coex_stat->wl_gl_busy = rtw_flag_check(rtwdev, RTW_FLAG_BUSY_TRAFFIC);
+	coex_stat->wl_gl_busy = test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
 
 	if (stats->tx_throughput > stats->rx_throughput)
 		coex_stat->wl_tput_dir = COEX_WL_TPUT_TX;
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index fc14b37..f438376 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -710,7 +710,7 @@ int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
 	rtw_fw_send_general_info(rtwdev);
 	rtw_fw_send_phydm_info(rtwdev);
 
-	rtw_flag_set(rtwdev, RTW_FLAG_FW_RUNNING);
+	set_bit(RTW_FLAG_FW_RUNNING, rtwdev->flags);
 
 	return 0;
 
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index e5e3605..6d5cce0 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -19,7 +19,7 @@ static void rtw_ops_tx(struct ieee80211_hw *hw,
 	struct rtw_dev *rtwdev = hw->priv;
 	struct rtw_tx_pkt_info pkt_info = {0};
 
-	if (!rtw_flag_check(rtwdev, RTW_FLAG_RUNNING))
+	if (!test_bit(RTW_FLAG_RUNNING, rtwdev->flags))
 		goto out;
 
 	rtw_tx_pkt_info_update(rtwdev, &pkt_info, control, skb);
@@ -474,8 +474,8 @@ static void rtw_ops_sw_scan_start(struct ieee80211_hw *hw,
 
 	rtw_coex_scan_notify(rtwdev, COEX_SCAN_START);
 
-	rtw_flag_set(rtwdev, RTW_FLAG_DIG_DISABLE);
-	rtw_flag_set(rtwdev, RTW_FLAG_SCANNING);
+	set_bit(RTW_FLAG_DIG_DISABLE, rtwdev->flags);
+	set_bit(RTW_FLAG_SCANNING, rtwdev->flags);
 
 	mutex_unlock(&rtwdev->mutex);
 }
@@ -489,8 +489,8 @@ static void rtw_ops_sw_scan_complete(struct ieee80211_hw *hw,
 
 	mutex_lock(&rtwdev->mutex);
 
-	rtw_flag_clear(rtwdev, RTW_FLAG_SCANNING);
-	rtw_flag_clear(rtwdev, RTW_FLAG_DIG_DISABLE);
+	clear_bit(RTW_FLAG_SCANNING, rtwdev->flags);
+	clear_bit(RTW_FLAG_DIG_DISABLE, rtwdev->flags);
 
 	ether_addr_copy(rtwvif->mac_addr, vif->addr);
 	config |= PORT_SET_MAC_ADDR;
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index fc8f6213..0068d4d 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -150,20 +150,20 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
 					      watch_dog_work.work);
 	struct rtw_watch_dog_iter_data data = {};
-	bool busy_traffic = rtw_flag_check(rtwdev, RTW_FLAG_BUSY_TRAFFIC);
+	bool busy_traffic = test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
 
-	if (!rtw_flag_check(rtwdev, RTW_FLAG_RUNNING))
+	if (!test_bit(RTW_FLAG_RUNNING, rtwdev->flags))
 		return;
 
 	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->watch_dog_work,
 				     RTW_WATCH_DOG_DELAY_TIME);
 
 	if (rtwdev->stats.tx_cnt > 100 || rtwdev->stats.rx_cnt > 100)
-		rtw_flag_set(rtwdev, RTW_FLAG_BUSY_TRAFFIC);
+		set_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
 	else
-		rtw_flag_clear(rtwdev, RTW_FLAG_BUSY_TRAFFIC);
+		clear_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
 
-	if (busy_traffic != rtw_flag_check(rtwdev, RTW_FLAG_BUSY_TRAFFIC))
+	if (busy_traffic != test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags))
 		rtw_coex_wl_status_change_notify(rtwdev);
 
 	/* reset tx/rx statictics */
@@ -183,7 +183,7 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	    data.rtwvif && !data.active && data.assoc_cnt == 1)
 		rtw_enter_lps(rtwdev, data.rtwvif);
 
-	if (rtw_flag_check(rtwdev, RTW_FLAG_SCANNING))
+	if (test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
 		return;
 
 	rtw_phy_dynamic_mechanism(rtwdev);
@@ -311,7 +311,7 @@ void rtw_set_channel(struct rtw_dev *rtwdev)
 	if (hal->current_band_type == RTW_BAND_5G) {
 		rtw_coex_switchband_notify(rtwdev, COEX_SWITCH_TO_5G);
 	} else {
-		if (rtw_flag_check(rtwdev, RTW_FLAG_SCANNING))
+		if (test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
 			rtw_coex_switchband_notify(rtwdev, COEX_SWITCH_TO_24G);
 		else
 			rtw_coex_switchband_notify(rtwdev, COEX_SWITCH_TO_24G_NOFORSCAN);
@@ -733,7 +733,7 @@ int rtw_core_start(struct rtw_dev *rtwdev)
 	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->watch_dog_work,
 				     RTW_WATCH_DOG_DELAY_TIME);
 
-	rtw_flag_set(rtwdev, RTW_FLAG_RUNNING);
+	set_bit(RTW_FLAG_RUNNING, rtwdev->flags);
 
 	return 0;
 }
@@ -748,8 +748,8 @@ void rtw_core_stop(struct rtw_dev *rtwdev)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 
-	rtw_flag_clear(rtwdev, RTW_FLAG_RUNNING);
-	rtw_flag_clear(rtwdev, RTW_FLAG_FW_RUNNING);
+	clear_bit(RTW_FLAG_RUNNING, rtwdev->flags);
+	clear_bit(RTW_FLAG_FW_RUNNING, rtwdev->flags);
 
 	cancel_delayed_work_sync(&rtwdev->watch_dog_work);
 	cancel_delayed_work_sync(&coex->bt_relink_work);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index bede3f3..11ab9967 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1378,21 +1378,6 @@ struct rtw_dev {
 
 #include "hci.h"
 
-static inline bool rtw_flag_check(struct rtw_dev *rtwdev, enum rtw_flags flag)
-{
-	return test_bit(flag, rtwdev->flags);
-}
-
-static inline void rtw_flag_clear(struct rtw_dev *rtwdev, enum rtw_flags flag)
-{
-	clear_bit(flag, rtwdev->flags);
-}
-
-static inline void rtw_flag_set(struct rtw_dev *rtwdev, enum rtw_flags flag)
-{
-	set_bit(flag, rtwdev->flags);
-}
-
 static inline bool rtw_is_assoc(struct rtw_dev *rtwdev)
 {
 	return !!rtwdev->sta_cnt;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index d3d3f40..8ebe1f4 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -394,7 +394,7 @@ static void rtw_phy_dig(struct rtw_dev *rtwdev)
 	u8 step[3];
 	bool linked;
 
-	if (rtw_flag_check(rtwdev, RTW_FLAG_DIG_DISABLE))
+	if (test_bit(RTW_FLAG_DIG_DISABLE, rtwdev->flags))
 		return;
 
 	if (rtw_phy_dig_check_damping(dm_info))
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 9ecd14fe..4896953 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -18,14 +18,14 @@ static int rtw_ips_pwr_up(struct rtw_dev *rtwdev)
 		rtw_err(rtwdev, "leave idle state failed\n");
 
 	rtw_set_channel(rtwdev);
-	rtw_flag_clear(rtwdev, RTW_FLAG_INACTIVE_PS);
+	clear_bit(RTW_FLAG_INACTIVE_PS, rtwdev->flags);
 
 	return ret;
 }
 
 int rtw_enter_ips(struct rtw_dev *rtwdev)
 {
-	rtw_flag_set(rtwdev, RTW_FLAG_INACTIVE_PS);
+	set_bit(RTW_FLAG_INACTIVE_PS, rtwdev->flags);
 
 	rtw_coex_ips_notify(rtwdev, COEX_IPS_ENTER);
 
@@ -71,7 +71,7 @@ static void rtw_leave_lps_core(struct rtw_dev *rtwdev)
 	conf->smart_ps = 0;
 
 	rtw_fw_set_pwr_mode(rtwdev);
-	rtw_flag_clear(rtwdev, RTW_FLAG_LEISURE_PS);
+	clear_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags);
 
 	rtw_coex_lps_notify(rtwdev, COEX_LPS_DISABLE);
 }
@@ -88,7 +88,7 @@ static void rtw_enter_lps_core(struct rtw_dev *rtwdev)
 	rtw_coex_lps_notify(rtwdev, COEX_LPS_ENABLE);
 
 	rtw_fw_set_pwr_mode(rtwdev);
-	rtw_flag_set(rtwdev, RTW_FLAG_LEISURE_PS);
+	set_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags);
 }
 
 void rtw_lps_work(struct work_struct *work)
@@ -137,7 +137,7 @@ void rtw_leave_lps_irqsafe(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif)
 
 bool rtw_in_lps(struct rtw_dev *rtwdev)
 {
-	return rtw_flag_check(rtwdev, RTW_FLAG_LEISURE_PS);
+	return test_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags);
 }
 
 void rtw_enter_lps(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif)
-- 
2.7.4

