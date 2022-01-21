Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABCB495A52
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jan 2022 08:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378845AbiAUHI4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jan 2022 02:08:56 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44459 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378844AbiAUHI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jan 2022 02:08:56 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 20L78lBsA022419, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 20L78lBsA022419
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 15:08:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 21 Jan 2022 15:08:47 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 21 Jan
 2022 15:08:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <usama.anjum@collabora.com>,
        <phhuang@realtek.com>
Subject: [PATCH 2/3] rtw88: fix idle mode flow for hw scan
Date:   Fri, 21 Jan 2022 15:08:12 +0800
Message-ID: <20220121070813.9656-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121070813.9656-1-pkshih@realtek.com>
References: <20220121070813.9656-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/21/2022 06:52:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvMjEgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Upon hw scan completion, idle mode is not re-entered. This might
increase power consumption under no link mode. Fix this by adding the
re-enter flow. We need another work for this since enter_ips waits
for c2h_work to finish, which might lead to deadlock if caller is in
the same work.

Fixes: 10d162b2ed39 ("rtw88: 8822c: add ieee80211_ops::hw_scan")
Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       |  2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  5 ++++-
 drivers/net/wireless/realtek/rtw88/main.c     | 16 +++++++++++++++-
 drivers/net/wireless/realtek/rtw88/main.h     |  4 +++-
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index b56dc43229d28..a631042753eab 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -2030,7 +2030,7 @@ void rtw_hw_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 	rtwdev->hal.rcr |= BIT_CBSSID_BCN;
 	rtw_write32(rtwdev, REG_RCR, rtwdev->hal.rcr);
 
-	rtw_core_scan_complete(rtwdev, vif);
+	rtw_core_scan_complete(rtwdev, vif, true);
 
 	ieee80211_wake_queues(rtwdev->hw);
 	ieee80211_scan_completed(rtwdev->hw, &info);
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index ae7d97de5fdf4..647d2662955ba 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -72,6 +72,9 @@ static int rtw_ops_config(struct ieee80211_hw *hw, u32 changed)
 	struct rtw_dev *rtwdev = hw->priv;
 	int ret = 0;
 
+	/* let previous ips work finish to ensure we don't leave ips twice */
+	cancel_work_sync(&rtwdev->ips_work);
+
 	mutex_lock(&rtwdev->mutex);
 
 	rtw_leave_lps_deep(rtwdev);
@@ -614,7 +617,7 @@ static void rtw_ops_sw_scan_complete(struct ieee80211_hw *hw,
 	struct rtw_dev *rtwdev = hw->priv;
 
 	mutex_lock(&rtwdev->mutex);
-	rtw_core_scan_complete(rtwdev, vif);
+	rtw_core_scan_complete(rtwdev, vif, false);
 	mutex_unlock(&rtwdev->mutex);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 38252113c4a87..39c223a2e3e2d 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -272,6 +272,15 @@ static void rtw_c2h_work(struct work_struct *work)
 	}
 }
 
+static void rtw_ips_work(struct work_struct *work)
+{
+	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev, ips_work);
+
+	mutex_lock(&rtwdev->mutex);
+	rtw_enter_ips(rtwdev);
+	mutex_unlock(&rtwdev->mutex);
+}
+
 static u8 rtw_acquire_macid(struct rtw_dev *rtwdev)
 {
 	unsigned long mac_id;
@@ -1339,7 +1348,8 @@ void rtw_core_scan_start(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif,
 	set_bit(RTW_FLAG_SCANNING, rtwdev->flags);
 }
 
-void rtw_core_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif)
+void rtw_core_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
+			    bool hw_scan)
 {
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 	u32 config = 0;
@@ -1354,6 +1364,9 @@ void rtw_core_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif)
 	rtw_vif_port_config(rtwdev, rtwvif, config);
 
 	rtw_coex_scan_notify(rtwdev, COEX_SCAN_FINISH);
+
+	if (rtwvif->net_type == RTW_NET_NO_LINK && hw_scan)
+		ieee80211_queue_work(rtwdev->hw, &rtwdev->ips_work);
 }
 
 int rtw_core_start(struct rtw_dev *rtwdev)
@@ -1919,6 +1932,7 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	INIT_DELAYED_WORK(&coex->wl_ccklock_work, rtw_coex_wl_ccklock_work);
 	INIT_WORK(&rtwdev->tx_work, rtw_tx_work);
 	INIT_WORK(&rtwdev->c2h_work, rtw_c2h_work);
+	INIT_WORK(&rtwdev->ips_work, rtw_ips_work);
 	INIT_WORK(&rtwdev->fw_recovery_work, rtw_fw_recovery_work);
 	INIT_WORK(&rtwdev->ba_work, rtw_txq_ba_work);
 	skb_queue_head_init(&rtwdev->c2h_queue);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index dc1cd9bd4b8a3..36e1e408933db 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1960,6 +1960,7 @@ struct rtw_dev {
 	/* c2h cmd queue & handler work */
 	struct sk_buff_head c2h_queue;
 	struct work_struct c2h_work;
+	struct work_struct ips_work;
 	struct work_struct fw_recovery_work;
 
 	/* used to protect txqs list */
@@ -2101,7 +2102,8 @@ void rtw_tx_report_purge_timer(struct timer_list *t);
 void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si);
 void rtw_core_scan_start(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif,
 			 const u8 *mac_addr, bool hw_scan);
-void rtw_core_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif);
+void rtw_core_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
+			    bool hw_scan);
 int rtw_core_start(struct rtw_dev *rtwdev);
 void rtw_core_stop(struct rtw_dev *rtwdev);
 int rtw_chip_info_setup(struct rtw_dev *rtwdev);
-- 
2.25.1

