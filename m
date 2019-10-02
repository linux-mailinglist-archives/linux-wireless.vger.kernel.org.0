Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B8CC45EA
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 04:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfJBCbm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 22:31:42 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46010 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfJBCbl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 22:31:41 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x922VZEM031848, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x922VZEM031848
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 10:31:36 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 10:31:35 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 06/12] rtw88: LPS enter/leave should be protected by lock
Date:   Wed, 2 Oct 2019 10:31:22 +0800
Message-ID: <20191002023128.12090-7-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002023128.12090-1-yhchuang@realtek.com>
References: <20191002023128.12090-1-yhchuang@realtek.com>
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

v1 -> v2
  - rebase on top of wireless-drivers-next

 drivers/net/wireless/realtek/rtw88/mac80211.c | 4 ++--
 drivers/net/wireless/realtek/rtw88/main.c     | 9 +++++++--
 drivers/net/wireless/realtek/rtw88/ps.c       | 4 ++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 66c05c492587..984644f64610 100644
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
index 85d83f154f71..f55eda9da827 100644
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
index d57996e446fb..af5c7be2ef0f 100644
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
2.17.1

