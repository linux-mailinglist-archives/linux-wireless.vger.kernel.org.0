Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCBC29FD80
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Oct 2020 06:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgJ3F4J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 01:56:09 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:54523 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3F4I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 01:56:08 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 09U5txziF025464, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 09U5txziF025464
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Oct 2020 13:55:59 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 30 Oct 2020 13:55:59 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtw88: coex: separate BLE HID profile from BLE profile
Date:   Fri, 30 Oct 2020 13:55:06 +0800
Message-ID: <20201030055506.6560-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
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

BT firmware will report BLE-HID and BLE-RCU in different profile.
We can distinguish the two profile from BT info now.

Add the coexistence for BLE-HID coexistence,
it can make BLE HID work more smoothly.

BLE-HID need to Tx/Rx packet more frequently to respond
user operation, but RCU doesn't.

In the case of RCU coexistence, it will make Wi-Fi have a
higher priority to earn more Wi-Fi throughput.

If BLE-HID go for the same case,
it will make user feel mouse is lagging.

Desired BT firmware BT-COEX version: 0x1c
Desired WL firmware version: 9.9

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c     | 31 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  5 ++-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  5 ++-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  9 ++++--
 5 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index aa08fd7d9fcd..51eef8d0a8e5 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1470,11 +1470,17 @@ static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
 			} else {
 				/* for 4/18 HID */
 				if (coex_stat->bt_418_hid_exist &&
-				    coex_stat->wl_gl_busy)
+				    coex_stat->wl_gl_busy) {
 					table_case = 12;
-				else
+					tdma_case = 4;
+				} else if (coex_stat->bt_ble_hid_exist &&
+					   coex_stat->wl_gl_busy) {
+					table_case = 32;
+					tdma_case = 9;
+				} else {
 					table_case = 10;
-				tdma_case = 4;
+					tdma_case = 4;
+				}
 			}
 		}
 	} else {
@@ -2388,6 +2394,23 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 						     4 * HZ);
 	}
 	coex_stat->bt_acl_busy = ((coex_stat->bt_info_lb2 & BIT(3)) == BIT(3));
+	if (coex_stat->bt_info_lb2 & BIT(5)) {
+		if (coex_stat->bt_info_hb1 & BIT(0)) {
+			/*BLE HID*/
+			coex_stat->bt_ble_hid_exist = true;
+		} else {
+			coex_stat->bt_ble_hid_exist = false;
+		}
+		coex_stat->bt_ble_exist = false;
+	} else if (coex_stat->bt_info_hb1 & BIT(0)) {
+		/*RCU*/
+		coex_stat->bt_ble_hid_exist = false;
+		coex_stat->bt_ble_exist = true;
+	} else {
+		coex_stat->bt_ble_hid_exist = false;
+		coex_stat->bt_ble_exist = false;
+	}
+
 	coex_stat->cnt_bt[COEX_CNT_BT_RETRY] = coex_stat->bt_info_lb3 & 0xf;
 	if (coex_stat->cnt_bt[COEX_CNT_BT_RETRY] >= 1)
 		coex_stat->cnt_bt[COEX_CNT_BT_POPEVENT]++;
@@ -2422,7 +2445,6 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 			coex_stat->bt_rssi = 0;
 	}
 
-	coex_stat->bt_ble_exist = ((coex_stat->bt_info_hb1 & BIT(0)) == BIT(0));
 	if (coex_stat->bt_info_hb1 & BIT(1))
 		coex_stat->cnt_bt[COEX_CNT_BT_REINIT]++;
 
@@ -2965,6 +2987,7 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 		   coex_stat->bt_hid_exist ?
 		   (coex_stat->bt_ble_exist ? "HID(RCU)," :
 		    coex_stat->bt_hid_slot >= 2 ? "HID(4/18)" :
+		    coex_stat->bt_ble_hid_exist ? "HID(BLE)" :
 		    "HID(2/18),") : "",
 		   coex_stat->bt_pan_exist ? coex_stat->bt_opp_exist ?
 		   "OPP," : "PAN," : "",
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index ffb02e614217..fb2b1d46e8a9 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1305,6 +1305,7 @@ struct rtw_coex_stat {
 	bool bt_init_scan;
 	bool bt_slave;
 	bool bt_418_hid_exist;
+	bool bt_ble_hid_exist;
 	bool bt_mailbox_reply;
 
 	bool wl_under_lps;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 3ddd170f1651..832dc8e98bee 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1976,7 +1976,10 @@ static const struct coex_table_para table_sant_8723d[] = {
 	{0x55555555, 0x5a5a5a5a},
 	{0x55555555, 0xaaaaaaaa},
 	{0x55555555, 0x6a6a6a6a},
-	{0x656a656a, 0x656a656a}
+	{0x656a656a, 0x656a656a},
+	{0x66556aaa, 0x6a5a6aaa}, /* case-30 */
+	{0xffffffff, 0x5aaa5aaa},
+	{0x56555555, 0x5a5a5aaa},
 };
 
 /* Non-Shared-Antenna Coex Table */
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 22d0dd640ac9..59bf77fedbc0 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2164,7 +2164,10 @@ static const struct coex_table_para table_sant_8822b[] = {
 	{0x55555555, 0x5a5a5a5a},
 	{0x55555555, 0xaaaaaaaa},
 	{0x55555555, 0x6a5a6a5a},
-	{0x66556655, 0x66556655}
+	{0x66556655, 0x66556655},
+	{0x66556aaa, 0x6a5a6aaa}, /* case-30 */
+	{0xffffffff, 0x5aaa5aaa},
+	{0x56555555, 0x5a5a5aaa},
 };
 
 /* Non-Shared-Antenna Coex Table */
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index e37300e98517..1e2f680f2b90 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4006,7 +4006,10 @@ static const struct coex_table_para table_sant_8822c[] = {
 	{0x55555555, 0x5a5a5a5a},
 	{0x55555555, 0xaaaaaaaa},
 	{0x55555555, 0x6a5a6a5a},
-	{0x66556655, 0x66556655}
+	{0x66556655, 0x66556655},
+	{0x66556aaa, 0x6a5a6aaa}, /* case-30 */
+	{0xffffffff, 0x5aaa5aaa},
+	{0x56555555, 0x5a5a5aaa},
 };
 
 /* Non-Shared-Antenna Coex Table */
@@ -4337,8 +4340,8 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.wowlan_stub = &rtw_wowlan_stub_8822c,
 	.max_sched_scan_ssids = 4,
 #endif
-	.coex_para_ver = 0x20070217,
-	.bt_desired_ver = 0x17,
+	.coex_para_ver = 0x201029,
+	.bt_desired_ver = 0x1c,
 	.scbd_support = true,
 	.new_scbd10_def = true,
 	.pstdma_type = COEX_PSTDMA_FORCE_LPSOFF,
-- 
2.21.0

