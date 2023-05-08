Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FE16FA2A5
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjEHIzB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjEHIy7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:54:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916EA4ED7;
        Mon,  8 May 2023 01:54:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3488sXzG5030855, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3488sXzG5030855
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 8 May 2023 16:54:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 8 May 2023 16:54:39 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 May 2023
 16:54:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>, <tony0620emma@gmail.com>
CC:     <stable@vger.kernel.org>, <Larry.Finger@lwfinger.net>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw88: use work to update rate to avoid RCU warning
Date:   Mon, 8 May 2023 16:54:29 +0800
Message-ID: <20230508085429.46653-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The ieee80211_ops::sta_rc_update must be atomic, because
ieee80211_chan_bw_change() holds rcu_read lock while calling
drv_sta_rc_update(), so create a work to do original things.

 Voluntary context switch within RCU read-side critical section!
 WARNING: CPU: 0 PID: 4621 at kernel/rcu/tree_plugin.h:318
 rcu_note_context_switch+0x571/0x5d0
 CPU: 0 PID: 4621 Comm: kworker/u16:2 Tainted: G        W  OE
 Workqueue: phy3 ieee80211_chswitch_work [mac80211]
 RIP: 0010:rcu_note_context_switch+0x571/0x5d0
 Call Trace:
  <TASK>
  __schedule+0xb0/0x1460
  ? __mod_timer+0x116/0x360
  schedule+0x5a/0xc0
  schedule_timeout+0x87/0x150
  ? trace_raw_output_tick_stop+0x60/0x60
  wait_for_completion_timeout+0x7b/0x140
  usb_start_wait_urb+0x82/0x160 [usbcore
  usb_control_msg+0xe3/0x140 [usbcore
  rtw_usb_read+0x88/0xe0 [rtw_usb
  rtw_usb_read8+0xf/0x10 [rtw_usb
  rtw_fw_send_h2c_command+0xa0/0x170 [rtw_core
  rtw_fw_send_ra_info+0xc9/0xf0 [rtw_core
  drv_sta_rc_update+0x7c/0x160 [mac80211
  ieee80211_chan_bw_change+0xfb/0x110 [mac80211
  ieee80211_change_chanctx+0x38/0x130 [mac80211
  ieee80211_vif_use_reserved_switch+0x34e/0x900 [mac80211
  ieee80211_link_use_reserved_context+0x88/0xe0 [mac80211
  ieee80211_chswitch_work+0x95/0x170 [mac80211
  process_one_work+0x201/0x410
  worker_thread+0x4a/0x3b0
  ? process_one_work+0x410/0x410
  kthread+0xe1/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

Cc: stable@vger.kernel.org
Fixes: c1edc86472fc ("rtw88: add ieee80211:sta_rc_update ops")
Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
Link: https://lore.kernel.org/linux-wireless/f1e31e8e-f84e-3791-50fb-663a83c5c6e9@lwfinger.net/T/#t
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 +-
 drivers/net/wireless/realtek/rtw88/main.c     | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 7aa6edad0d012..a6c024cab7ee4 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -918,7 +918,7 @@ static void rtw_ops_sta_rc_update(struct ieee80211_hw *hw,
 	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
 
 	if (changed & IEEE80211_RC_BW_CHANGED)
-		rtw_update_sta_info(rtwdev, si, true);
+		ieee80211_queue_work(rtwdev->hw, &si->rc_work);
 }
 
 const struct ieee80211_ops rtw_ops = {
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 5bf6b45815578..d30a191c9291d 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -319,6 +319,17 @@ static u8 rtw_acquire_macid(struct rtw_dev *rtwdev)
 	return mac_id;
 }
 
+static void rtw_sta_rc_work(struct work_struct *work)
+{
+	struct rtw_sta_info *si = container_of(work, struct rtw_sta_info,
+					       rc_work);
+	struct rtw_dev *rtwdev = si->rtwdev;
+
+	mutex_lock(&rtwdev->mutex);
+	rtw_update_sta_info(rtwdev, si, true);
+	mutex_unlock(&rtwdev->mutex);
+}
+
 int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 		struct ieee80211_vif *vif)
 {
@@ -329,12 +340,14 @@ int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 	if (si->mac_id >= RTW_MAX_MAC_ID_NUM)
 		return -ENOSPC;
 
+	si->rtwdev = rtwdev;
 	si->sta = sta;
 	si->vif = vif;
 	si->init_ra_lv = 1;
 	ewma_rssi_init(&si->avg_rssi);
 	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 		rtw_txq_init(rtwdev, sta->txq[i]);
+	INIT_WORK(&si->rc_work, rtw_sta_rc_work);
 
 	rtw_update_sta_info(rtwdev, si, true);
 	rtw_fw_media_status_report(rtwdev, si->mac_id, true);
@@ -353,6 +366,8 @@ void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
 	int i;
 
+	cancel_work_sync(&si->rc_work);
+
 	rtw_release_macid(rtwdev, si->mac_id);
 	if (fw_exist)
 		rtw_fw_media_status_report(rtwdev, si->mac_id, false);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index a563285e90ede..9e841f6991a9a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -743,6 +743,7 @@ struct rtw_txq {
 DECLARE_EWMA(rssi, 10, 16);
 
 struct rtw_sta_info {
+	struct rtw_dev *rtwdev;
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
 
@@ -767,6 +768,8 @@ struct rtw_sta_info {
 
 	bool use_cfg_mask;
 	struct cfg80211_bitrate_mask *mask;
+
+	struct work_struct rc_work;
 };
 
 enum rtw_bfee_role {
-- 
2.25.1

