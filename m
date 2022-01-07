Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2E1487158
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 04:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345884AbiAGDnK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 22:43:10 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51060 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345883AbiAGDnJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 22:43:09 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2073h44s9022904, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2073h44s9022904
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Jan 2022 11:43:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 11:43:03 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 11:43:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 05/19] rtw89: implement mac80211_ops::set_tim to indicate STA to receive packets
Date:   Fri, 7 Jan 2022 11:42:25 +0800
Message-ID: <20220107034239.22002-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107034239.22002-1-pkshih@realtek.com>
References: <20220107034239.22002-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/07/2022 03:26:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvNyCkV6TIIDAxOjMzOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update beacon content if TIM bitmap maintained by mac80211 is changed.
Since .set_tim must be atomic but driver uses mutex lock, we add a work.
Otherwise, kernel says "sched: RT throttling activated" and lock down.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  3 +++
 drivers/net/wireless/realtek/rtw89/mac80211.c | 17 +++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 7c5e9bc309706..7fee45d8b82a1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2238,6 +2238,21 @@ static void rtw89_core_ppdu_sts_init(struct rtw89_dev *rtwdev)
 		rtwdev->ppdu_sts.curr_rx_ppdu_cnt[i] = U8_MAX;
 }
 
+void rtw89_core_update_beacon_work(struct work_struct *work)
+{
+	struct rtw89_dev *rtwdev;
+	struct rtw89_vif *rtwvif = container_of(work, struct rtw89_vif,
+						update_beacon_work);
+
+	if (rtwvif->net_type != RTW89_NET_TYPE_AP_MODE)
+		return;
+
+	rtwdev = rtwvif->rtwdev;
+	mutex_lock(&rtwdev->mutex);
+	rtw89_fw_h2c_update_beacon(rtwdev, rtwvif);
+	mutex_unlock(&rtwdev->mutex);
+}
+
 int rtw89_core_start(struct rtw89_dev *rtwdev)
 {
 	int ret;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index defa0ceebc20e..542afe2133b0f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1928,6 +1928,7 @@ struct rtw89_phy_rate_pattern {
 
 struct rtw89_vif {
 	struct list_head list;
+	struct rtw89_dev *rtwdev;
 	u8 mac_id;
 	u8 port;
 	u8 mac_addr[ETH_ALEN];
@@ -1949,6 +1950,7 @@ struct rtw89_vif {
 	bool wowlan_magic;
 	bool is_hesta;
 	bool last_a_ctrl;
+	struct work_struct update_beacon_work;
 	struct rtw89_addr_cam_entry addr_cam;
 	struct rtw89_bssid_cam_entry bssid_cam;
 	struct ieee80211_tx_queue_params tx_params[IEEE80211_NUM_ACS];
@@ -3396,5 +3398,6 @@ void rtw89_traffic_stats_init(struct rtw89_dev *rtwdev,
 			      struct rtw89_traffic_stats *stats);
 int rtw89_core_start(struct rtw89_dev *rtwdev);
 void rtw89_core_stop(struct rtw89_dev *rtwdev);
+void rtw89_core_update_beacon_work(struct work_struct *work);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 682680e18ff46..26abbe7aa17d8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -102,7 +102,9 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	int ret = 0;
 
 	mutex_lock(&rtwdev->mutex);
+	rtwvif->rtwdev = rtwdev;
 	list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
+	INIT_WORK(&rtwvif->update_beacon_work, rtw89_core_update_beacon_work);
 	rtw89_leave_ps_mode(rtwdev);
 
 	rtw89_traffic_stats_init(rtwdev, &rtwvif->stats);
@@ -141,6 +143,8 @@ static void rtw89_ops_remove_interface(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 
+	cancel_work_sync(&rtwvif->update_beacon_work);
+
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
 	rtw89_btc_ntfy_role_info(rtwdev, rtwvif, NULL, BTC_ROLE_STOP);
@@ -364,6 +368,18 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 	mutex_unlock(&rtwdev->mutex);
 }
 
+static int rtw89_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
+			     bool set)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+
+	ieee80211_queue_work(rtwdev->hw, &rtwvif->update_beacon_work);
+
+	return 0;
+}
+
 static int rtw89_ops_conf_tx(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif, u16 ac,
 			     const struct ieee80211_tx_queue_params *params)
@@ -680,6 +696,7 @@ const struct ieee80211_ops rtw89_ops = {
 	.remove_interface	= rtw89_ops_remove_interface,
 	.configure_filter	= rtw89_ops_configure_filter,
 	.bss_info_changed	= rtw89_ops_bss_info_changed,
+	.set_tim		= rtw89_ops_set_tim,
 	.conf_tx		= rtw89_ops_conf_tx,
 	.sta_state		= rtw89_ops_sta_state,
 	.set_key		= rtw89_ops_set_key,
-- 
2.25.1

