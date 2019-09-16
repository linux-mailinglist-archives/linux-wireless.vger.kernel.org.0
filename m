Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1908B3509
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2019 09:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfIPHED (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Sep 2019 03:04:03 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60350 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730250AbfIPHEC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Sep 2019 03:04:02 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8G73uMs029998, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8G73uMs029998
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 16 Sep 2019 15:03:56 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 16 Sep 2019 15:03:56 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 09/15] rtw88: LPS enter/leave should be protected by lock
Date:   Mon, 16 Sep 2019 15:03:39 +0800
Message-ID: <1568617425-28062-10-git-send-email-yhchuang@realtek.com>
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

Protect LPS enter/leave routine with rtwdev->mutex.
This helps to synchronize with driver's states correctly.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 4 ++--
 drivers/net/wireless/realtek/rtw88/main.c     | 9 +++++++--
 drivers/net/wireless/realtek/rtw88/ps.c       | 4 ++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 66c05c4..984644f 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -464,10 +464,10 @@ static void rtw_ops_sw_scan_start(struct ieee80211_hw *hw,
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 	u32 config = 0;
 
-	rtw_leave_lps(rtwdev);
-
 	mutex_lock(&rtwdev->mutex);
 
+	rtw_leave_lps(rtwdev);
+
 	ether_addr_copy(rtwvif->mac_addr, mac_addr);
 	config |= PORT_SET_MAC_ADDR;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 85d83f1..f55eda9 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -152,8 +152,10 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	struct rtw_watch_dog_iter_data data = {};
 	bool busy_traffic = test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
 
+	mutex_lock(&rtwdev->mutex);
+
 	if (!test_bit(RTW_FLAG_RUNNING, rtwdev->flags))
-		return;
+		goto unlock;
 
 	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->watch_dog_work,
 				     RTW_WATCH_DOG_DELAY_TIME);
@@ -186,11 +188,14 @@ static void rtw_watch_dog_work(struct work_struct *work)
 		rtw_leave_lps(rtwdev);
 
 	if (test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
-		return;
+		goto unlock;
 
 	rtw_phy_dynamic_mechanism(rtwdev);
 
 	rtwdev->watch_dog_cnt++;
+
+unlock:
+	mutex_unlock(&rtwdev->mutex);
 }
 
 static void rtw_c2h_work(struct work_struct *work)
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index d57996e..af5c7be 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -95,6 +95,8 @@ void rtw_enter_lps(struct rtw_dev *rtwdev, u8 port_id)
 {
 	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
 
+	lockdep_assert_held(&rtwdev->mutex);
+
 	if (test_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags))
 		return;
 
@@ -108,6 +110,8 @@ void rtw_leave_lps(struct rtw_dev *rtwdev)
 {
 	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
 
+	lockdep_assert_held(&rtwdev->mutex);
+
 	if (!test_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags))
 		return;
 
-- 
2.7.4

