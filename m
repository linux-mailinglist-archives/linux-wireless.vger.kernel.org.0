Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1CF3B3510
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2019 09:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbfIPHEI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Sep 2019 03:04:08 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60363 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfIPHEH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Sep 2019 03:04:07 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8G741Kq030027, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8G741Kq030027
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 16 Sep 2019 15:04:01 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 16 Sep 2019 15:04:00 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 15/15] rtw88: remove misleading module parameter rtw_fw_support_lps
Date:   Mon, 16 Sep 2019 15:03:45 +0800
Message-ID: <1568617425-28062-16-git-send-email-yhchuang@realtek.com>
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

The module parameter rtw_fw_support_lps is misleading. It
is not used to represent the firmware's property, but to
determine if driver wants to ask firmware to enter LPS.

However, driver should better enable/disable PS through
cfg80211_ops::set_power_mgmt instead.
For example, one could use iw command to set PS state.

  $ sudo iw wlanX set power_save [on/off]

So rtw_fw_support_lps should be removed because it is
misleading and useless. Instead of checking the parameter,
set PS mode according to IEEE80211_CONF_PS.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c |  9 ++++++++
 drivers/net/wireless/realtek/rtw88/main.c     | 33 ++++++++++++---------------
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 22b13e4..97777c7 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -74,6 +74,15 @@ static int rtw_ops_config(struct ieee80211_hw *hw, u32 changed)
 		}
 	}
 
+	if (changed & IEEE80211_CONF_CHANGE_PS) {
+		if (hw->conf.flags & IEEE80211_CONF_PS) {
+			rtwdev->ps_enabled = true;
+		} else {
+			rtwdev->ps_enabled = false;
+			rtw_leave_lps(rtwdev);
+		}
+	}
+
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL)
 		rtw_set_channel(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 3c366a3..a3e9f91 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -16,16 +16,13 @@
 
 unsigned int rtw_fw_lps_deep_mode;
 EXPORT_SYMBOL(rtw_fw_lps_deep_mode);
-static bool rtw_fw_support_lps;
 unsigned int rtw_debug_mask;
 EXPORT_SYMBOL(rtw_debug_mask);
 
 module_param_named(lps_deep_mode, rtw_fw_lps_deep_mode, uint, 0644);
-module_param_named(support_lps, rtw_fw_support_lps, bool, 0644);
 module_param_named(debug_mask, rtw_debug_mask, uint, 0644);
 
 MODULE_PARM_DESC(lps_deep_mode, "Deeper PS mode. If 0, deep PS is disabled");
-MODULE_PARM_DESC(support_lps, "Set Y to enable Leisure Power Save support, to turn radio off between beacons");
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
 static struct ieee80211_channel rtw_channeltable_2g[] = {
@@ -117,8 +114,6 @@ static struct ieee80211_supported_band rtw_band_5ghz = {
 
 struct rtw_watch_dog_iter_data {
 	struct rtw_vif *rtwvif;
-	bool active;
-	u8 assoc_cnt;
 };
 
 static void rtw_vif_watch_dog_iter(void *data, u8 *mac,
@@ -127,18 +122,9 @@ static void rtw_vif_watch_dog_iter(void *data, u8 *mac,
 	struct rtw_watch_dog_iter_data *iter_data = data;
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 
-	if (vif->type == NL80211_IFTYPE_STATION) {
-		if (vif->bss_conf.assoc) {
-			iter_data->assoc_cnt++;
+	if (vif->type == NL80211_IFTYPE_STATION)
+		if (vif->bss_conf.assoc)
 			iter_data->rtwvif = rtwvif;
-		}
-		if (rtwvif->stats.tx_cnt > RTW_LPS_THRESHOLD ||
-		    rtwvif->stats.rx_cnt > RTW_LPS_THRESHOLD)
-			iter_data->active = true;
-	} else {
-		/* only STATION mode can enter lps */
-		iter_data->active = true;
-	}
 
 	rtwvif->stats.tx_unicast = 0;
 	rtwvif->stats.rx_unicast = 0;
@@ -155,6 +141,7 @@ static void rtw_watch_dog_work(struct work_struct *work)
 					      watch_dog_work.work);
 	struct rtw_watch_dog_iter_data data = {};
 	bool busy_traffic = test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
+	bool ps_active;
 
 	mutex_lock(&rtwdev->mutex);
 
@@ -172,6 +159,12 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	if (busy_traffic != test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags))
 		rtw_coex_wl_status_change_notify(rtwdev);
 
+	if (rtwdev->stats.tx_cnt > RTW_LPS_THRESHOLD ||
+	    rtwdev->stats.rx_cnt > RTW_LPS_THRESHOLD)
+		ps_active = true;
+	else
+		ps_active = false;
+
 	/* reset tx/rx statictics */
 	rtwdev->stats.tx_unicast = 0;
 	rtwdev->stats.rx_unicast = 0;
@@ -192,9 +185,13 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	/* fw supports only one station associated to enter lps, if there are
 	 * more than two stations associated to the AP, then we can not enter
 	 * lps, because fw does not handle the overlapped beacon interval
+	 *
+	 * mac80211 should iterate vifs and determine if driver can enter
+	 * ps by passing IEEE80211_CONF_PS to us, all we need to do is to
+	 * get that vif and check if device is having traffic more than the
+	 * threshold.
 	 */
-	if (rtw_fw_support_lps &&
-	    data.rtwvif && !data.active && data.assoc_cnt == 1)
+	if (rtwdev->ps_enabled && data.rtwvif && !ps_active)
 		rtw_enter_lps(rtwdev, data.rtwvif->port);
 
 	rtwdev->watch_dog_cnt++;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 6221dc4..161297a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1372,6 +1372,7 @@ struct rtw_dev {
 
 	/* lps power state & handler work */
 	struct rtw_lps_conf lps_conf;
+	bool ps_enabled;
 
 	struct dentry *debugfs;
 
-- 
2.7.4

