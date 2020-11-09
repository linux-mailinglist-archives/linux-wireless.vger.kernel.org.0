Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8176F2AB309
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgKIJAa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:00:30 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60054 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbgKIJAT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:00:19 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A990BmcC021869, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A990BmcC021869
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 9 Nov 2020 17:00:11 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Mon, 9 Nov 2020 17:00:11 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 06/11] rtw88: coex: add separate flag for manual control
Date:   Mon, 9 Nov 2020 16:59:04 +0800
Message-ID: <20201109085909.9143-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201109085909.9143-1-pkshih@realtek.com>
References: <20201109085909.9143-1-pkshih@realtek.com>
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

The original stop_dm flag is shared with the wifi and coexistence
mechanism internal usage, which represent two meanings, and makes
developers hard to debug.
Add a new flag manual_control for coexistence mechanism usage only.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c  | 18 +++++++++---------
 drivers/net/wireless/realtek/rtw88/debug.c |  4 ++--
 drivers/net/wireless/realtek/rtw88/main.h  |  1 +
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index af7e692137ba..6de98414e3bf 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -124,7 +124,7 @@ static void rtw_coex_wl_ccklock_action(struct rtw_dev *rtwdev)
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	u8 para[6] = {0};
 
-	if (coex->stop_dm)
+	if (coex->manual_control || coex->stop_dm)
 		return;
 
 	para[0] = COEX_H2C69_WL_LEAKAP;
@@ -829,7 +829,7 @@ static void rtw_coex_ignore_wlan_act(struct rtw_dev *rtwdev, bool enable)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 
-	if (coex->stop_dm)
+	if (coex->manual_control || coex->stop_dm)
 		return;
 
 	rtw_fw_bt_ignore_wlan_action(rtwdev, enable);
@@ -1987,7 +1987,7 @@ static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
 
 	rtw_coex_monitor_bt_enable(rtwdev);
 
-	if (coex->stop_dm)
+	if (coex->manual_control || coex->stop_dm)
 		return;
 
 	if (coex_stat->wl_under_ips)
@@ -2154,7 +2154,7 @@ void rtw_coex_ips_notify(struct rtw_dev *rtwdev, u8 type)
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 
-	if (coex->stop_dm)
+	if (coex->manual_control || coex->stop_dm)
 		return;
 
 	if (type == COEX_IPS_ENTER) {
@@ -2180,7 +2180,7 @@ void rtw_coex_lps_notify(struct rtw_dev *rtwdev, u8 type)
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 
-	if (coex->stop_dm)
+	if (coex->manual_control || coex->stop_dm)
 		return;
 
 	if (type == COEX_LPS_ENABLE) {
@@ -2211,7 +2211,7 @@ void rtw_coex_scan_notify(struct rtw_dev *rtwdev, u8 type)
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 
-	if (coex->stop_dm)
+	if (coex->manual_control || coex->stop_dm)
 		return;
 
 	coex->freeze = false;
@@ -2239,7 +2239,7 @@ void rtw_coex_switchband_notify(struct rtw_dev *rtwdev, u8 type)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 
-	if (coex->stop_dm)
+	if (coex->manual_control || coex->stop_dm)
 		return;
 
 	if (type == COEX_SWITCH_TO_5G)
@@ -2255,7 +2255,7 @@ void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 type)
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 
-	if (coex->stop_dm)
+	if (coex->manual_control || coex->stop_dm)
 		return;
 
 	rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_SCAN |
@@ -2296,7 +2296,7 @@ void rtw_coex_media_status_notify(struct rtw_dev *rtwdev, u8 type)
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	u8 para[6] = {0};
 
-	if (coex->stop_dm)
+	if (coex->manual_control || coex->stop_dm)
 		return;
 
 	if (type == COEX_MEDIA_CONNECT_5G) {
diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 3852c4f0ac0b..5974a8ef8b34 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -775,7 +775,7 @@ static ssize_t rtw_debugfs_set_coex_enable(struct file *filp,
 	}
 
 	mutex_lock(&rtwdev->mutex);
-	coex->stop_dm = enable == 0;
+	coex->manual_control = enable == 0;
 	mutex_unlock(&rtwdev->mutex);
 
 	return count;
@@ -788,7 +788,7 @@ static int rtw_debugfs_get_coex_enable(struct seq_file *m, void *v)
 	struct rtw_coex *coex = &rtwdev->coex;
 
 	seq_printf(m, "coex mechanism %s\n",
-		   coex->stop_dm ? "disabled" : "enabled");
+		   coex->manual_control ? "disabled" : "enabled");
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 8d11d56c83f2..632d14683b61 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1379,6 +1379,7 @@ struct rtw_coex {
 	bool freeze;
 	bool freerun;
 	bool wl_rf_off;
+	bool manual_control;
 
 	struct rtw_coex_stat stat;
 	struct rtw_coex_dm dm;
-- 
2.21.0

