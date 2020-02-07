Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 702D01554A3
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 10:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgBGJ3A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 04:29:00 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44694 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgBGJ3A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 04:29:00 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0179Srm0018582, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0179Srm0018582
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Feb 2020 17:28:53 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 17:28:53 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Fri, 7 Feb 2020 17:28:53 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 7 Feb 2020 17:28:52 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <pkshih@realtek.com>
Subject: [PATCH 7/8] rtw88: sar: add sar_work to poll if dynamic SAR table is changed
Date:   Fri, 7 Feb 2020 17:28:43 +0800
Message-ID: <20200207092844.29175-8-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207092844.29175-1-yhchuang@realtek.com>
References: <20200207092844.29175-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

RWSI is used to tell driver operating mode is changed. For example, a
notebook PC can also play as a tablet. Driver detects RWSI in period of
10 seconds, and reconfigure SAR power limit if RWSI values are changed.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c |  4 ++
 drivers/net/wireless/realtek/rtw88/main.h |  1 +
 drivers/net/wireless/realtek/rtw88/sar.c  | 56 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/sar.h  |  3 ++
 4 files changed, 64 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 039703f1ccb9..bb90dce0a70d 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -892,6 +892,8 @@ int rtw_core_start(struct rtw_dev *rtwdev)
 
 	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->watch_dog_work,
 				     RTW_WATCH_DOG_DELAY_TIME);
+	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->sar.work,
+				     RTW_SAR_DELAY_TIME);
 
 	set_bit(RTW_FLAG_RUNNING, rtwdev->flags);
 
@@ -912,6 +914,7 @@ void rtw_core_stop(struct rtw_dev *rtwdev)
 	clear_bit(RTW_FLAG_FW_RUNNING, rtwdev->flags);
 
 	cancel_delayed_work_sync(&rtwdev->watch_dog_work);
+	cancel_delayed_work_sync(&rtwdev->sar.work);
 	cancel_delayed_work_sync(&coex->bt_relink_work);
 	cancel_delayed_work_sync(&coex->bt_reenable_work);
 	cancel_delayed_work_sync(&coex->defreeze_work);
@@ -1370,6 +1373,7 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 		     (unsigned long)rtwdev);
 
 	INIT_DELAYED_WORK(&rtwdev->watch_dog_work, rtw_watch_dog_work);
+	INIT_DELAYED_WORK(&rtwdev->sar.work, rtw_sar_work);
 	INIT_DELAYED_WORK(&coex->bt_relink_work, rtw_coex_bt_relink_work);
 	INIT_DELAYED_WORK(&coex->bt_reenable_work, rtw_coex_bt_reenable_work);
 	INIT_DELAYED_WORK(&coex->defreeze_work, rtw_coex_defreeze_work);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index bf5e66930424..ae7a4a080cfa 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1530,6 +1530,7 @@ struct rtw_sar {
 	union rtw_sar_rwsi *rwsi;
 	union rtw_sar_rwgs *rwgs;
 	const struct rtw_sar_read *read;
+	struct delayed_work work;
 };
 
 struct rtw_hal {
diff --git a/drivers/net/wireless/realtek/rtw88/sar.c b/drivers/net/wireless/realtek/rtw88/sar.c
index 80b8913d1a49..2bc6da4e5fcf 100644
--- a/drivers/net/wireless/realtek/rtw88/sar.c
+++ b/drivers/net/wireless/realtek/rtw88/sar.c
@@ -547,6 +547,45 @@ static void rtw_sar_apply_dynamic_tables(struct rtw_dev *rtwdev)
 	rtwdev->sar.source = RTW_SAR_SOURCE_ACPI_DYNAMIC;
 }
 
+static bool rtw_sar_is_rwsi_changed(struct rtw_dev *rtwdev)
+{
+	union rtw_sar_rwsi *rwsi, *old;
+	bool valid;
+	int len;
+
+	if (rtwdev->sar.source != RTW_SAR_SOURCE_ACPI_DYNAMIC)
+		return false;
+
+	if (!rtwdev->sar.rwrd || !rtwdev->sar.rwsi || !rtwdev->sar.rwgs)
+		return false;
+
+	rwsi = rtw_sar_get_raw_table(rtwdev, ACPI_RWSI_METHOD, &len);
+	if (!rwsi)
+		return false;
+	valid = is_valid_rwsi(rtwdev, rtwdev->sar.rwrd, rwsi, len);
+	if (!valid) {
+		kfree(rwsi);
+		return false;
+	}
+
+	if (memcmp(rwsi, rtwdev->sar.rwsi, len) == 0) {
+		kfree(rwsi);
+		return true;
+	}
+
+	old = rtwdev->sar.rwsi;
+	rtwdev->sar.rwsi = rwsi;
+	kfree(old);
+
+	rtw_dbg(rtwdev, RTW_DBG_REGD, "SAR: RWSI is changed\n");
+
+	rtw_sar_apply_dynamic_tables(rtwdev);
+
+	rtw_phy_set_tx_power_level(rtwdev, rtwdev->hal.current_channel);
+
+	return true;
+}
+
 static int rtw_sar_load_dynamic_tables(struct rtw_dev *rtwdev)
 {
 	struct rtw_sar_rwrd *rwrd;
@@ -605,6 +644,11 @@ static int rtw_sar_load_static_tables(struct rtw_dev *rtwdev)
 	return -ENOENT;
 }
 
+static bool rtw_sar_is_rwsi_changed(struct rtw_dev *rtwdev)
+{
+	return false;
+}
+
 static int rtw_sar_load_dynamic_tables(struct rtw_dev *rtwdev)
 {
 	return -ENOENT;
@@ -628,3 +672,15 @@ void rtw_sar_release_table(struct rtw_dev *rtwdev)
 	kfree(rtwdev->sar.rwsi);
 	kfree(rtwdev->sar.rwgs);
 }
+
+void rtw_sar_work(struct work_struct *work)
+{
+	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
+					      sar.work.work);
+
+	if (!rtw_sar_is_rwsi_changed(rtwdev))
+		return;
+
+	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->sar.work,
+				     RTW_SAR_DELAY_TIME);
+}
diff --git a/drivers/net/wireless/realtek/rtw88/sar.h b/drivers/net/wireless/realtek/rtw88/sar.h
index 16ceae5bf79e..154f7bce6759 100644
--- a/drivers/net/wireless/realtek/rtw88/sar.h
+++ b/drivers/net/wireless/realtek/rtw88/sar.h
@@ -7,5 +7,8 @@
 
 void rtw_sar_load_table(struct rtw_dev *rtwdev);
 void rtw_sar_release_table(struct rtw_dev *rtwdev);
+void rtw_sar_work(struct work_struct *work);
+
+#define RTW_SAR_DELAY_TIME	(10 * HZ)
 
 #endif
-- 
2.17.1

