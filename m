Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A51F41526A9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2020 08:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgBEHJN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 02:09:13 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:49346 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgBEHJL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 02:09:11 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 015796tw008624, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 015796tw008624
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Feb 2020 15:09:06 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 5 Feb 2020 15:09:06 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 5 Feb 2020 15:09:06 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Wed, 5 Feb 2020 15:09:06 +0800
Received: from localhost.localdomain (172.21.69.117) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 5 Feb 2020 15:09:05 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 5/7] rtw88: avoid holding mutex for cancel_delayed_work_sync()
Date:   Wed, 5 Feb 2020 15:08:56 +0800
Message-ID: <20200205070858.15386-6-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205070858.15386-1-yhchuang@realtek.com>
References: <20200205070858.15386-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.117]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Driver could possibly be dead-locked while canceling works with
*_sync() with mutex lock held. Those cancel_delayed_work_sync()
functions will wait until the work is done, but if we hold the
lock, they will never acquire the lock.

To prevent this, simply release the lock and acquire again after
the works have been canceled. And to avoid the works being queued
again, check if the device is at RTW_FLAG_RUNNING state, otherwise
just return and do nothing.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 3 +++
 drivers/net/wireless/realtek/rtw88/fw.c   | 4 ++++
 drivers/net/wireless/realtek/rtw88/main.c | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 4dfb2ec395ee..f91dc21a8bf1 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1904,6 +1904,9 @@ static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
 
 	lockdep_assert_held(&rtwdev->mutex);
 
+	if (!test_bit(RTW_FLAG_RUNNING, rtwdev->flags))
+		return;
+
 	coex_dm->reason = reason;
 
 	/* update wifi_link_info_ext variable */
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index b765b26b6926..b36928470fc0 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -136,6 +136,9 @@ void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 
 	mutex_lock(&rtwdev->mutex);
 
+	if (!test_bit(RTW_FLAG_RUNNING, rtwdev->flags))
+		goto unlock;
+
 	switch (c2h->id) {
 	case C2H_BT_INFO:
 		rtw_coex_bt_info_notify(rtwdev, c2h->payload, len);
@@ -153,6 +156,7 @@ void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 		break;
 	}
 
+unlock:
 	mutex_unlock(&rtwdev->mutex);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 2845d2838f7b..edecc7d7ea56 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -909,11 +909,16 @@ void rtw_core_stop(struct rtw_dev *rtwdev)
 	clear_bit(RTW_FLAG_RUNNING, rtwdev->flags);
 	clear_bit(RTW_FLAG_FW_RUNNING, rtwdev->flags);
 
+	mutex_unlock(&rtwdev->mutex);
+
+	cancel_work_sync(&rtwdev->c2h_work);
 	cancel_delayed_work_sync(&rtwdev->watch_dog_work);
 	cancel_delayed_work_sync(&coex->bt_relink_work);
 	cancel_delayed_work_sync(&coex->bt_reenable_work);
 	cancel_delayed_work_sync(&coex->defreeze_work);
 
+	mutex_lock(&rtwdev->mutex);
+
 	rtw_power_off(rtwdev);
 }
 
-- 
2.17.1

