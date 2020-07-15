Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE0422025E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 04:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgGOCdi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 22:33:38 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40553 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgGOCdi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 22:33:38 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06F2XRMh8000756, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06F2XRMh8000756
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Jul 2020 10:33:27 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 15 Jul 2020 10:33:27 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 15 Jul 2020 10:33:26 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH] rtw88: coex: Fix ACL Tx pause during BT inquiry/page.
Date:   Wed, 15 Jul 2020 10:33:24 +0800
Message-ID: <20200715023324.8600-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Add a set of logic with corresponding coexistence parameters to
handle the situation under BT inquiry/page.

We will set PSTDMA while WL-Busy + BT inquiry/page to separate
WL/BT slots. PSTDMA can protect WL data rate and BT performance.

If WL-Busy + BT inquiry/page and there was BT device paired,
We will set the mechanism to 4Slot PSTDMA.
In 4Slot PSTDMA, the paired devices can perform more smoothly
and prevent some issues trigger from insufficient data.

And to avoid A2DP glitch or disconnection, we will adjust ACL
data priority higher than inquiry/page.

In addition, we found sometimes BT inquiry/page still working
last for seconds after BT had notified inquiry/page finished.
It will lead to A2DP glitch cause of ACL data, inquiry/page
priority toggled. To fix the corner, we add a timer to remain
the inquiry/page status.

And we found WL busy/idle threshold is too sensitive,
it will keep switching in some weak network environment and
coexistence mechanism will switch between TDMA and PSTDMA.

The very frequently switching may destroyed not only the
handshake with AP, but BT performance. And it will trigger
some unexpected error.

To prevent the frequently switching, we add a timer to delay
the status change while WL busy switch to idle.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c     | 98 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw88/coex.h     |  3 +
 drivers/net/wireless/realtek/rtw88/main.c     |  4 +
 drivers/net/wireless/realtek/rtw88/main.h     |  3 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 13 +--
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  7 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  9 +-
 7 files changed, 108 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index cbf3d503df1c..3abae32341c4 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -378,6 +378,7 @@ static void rtw_coex_update_wl_link_info(struct rtw_dev *rtwdev, u8 reason)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_traffic_stats *stats = &rtwdev->stats;
 	bool is_5G = false;
+	bool wl_busy = false;
 	bool scan = false, link = false;
 	int i;
 	u8 rssi_state;
@@ -386,7 +387,16 @@ static void rtw_coex_update_wl_link_info(struct rtw_dev *rtwdev, u8 reason)
 
 	scan = test_bit(RTW_FLAG_SCANNING, rtwdev->flags);
 	coex_stat->wl_connected = !!rtwdev->sta_cnt;
-	coex_stat->wl_gl_busy = test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
+
+	wl_busy = test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
+	if (wl_busy != coex_stat->wl_gl_busy) {
+		if (wl_busy)
+			coex_stat->wl_gl_busy = true;
+		else
+			ieee80211_queue_delayed_work(rtwdev->hw,
+						     &coex->wl_remain_work,
+						     12 * HZ);
+	}
 
 	if (stats->tx_throughput > stats->rx_throughput)
 		coex_stat->wl_tput_dir = COEX_WL_TPUT_TX;
@@ -888,10 +898,12 @@ static void rtw_coex_tdma(struct rtw_dev *rtwdev, bool force, u32 tcase)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	u8 n, type;
 	bool turn_on;
+	bool wl_busy = false;
 
 	if (tcase & TDMA_4SLOT)/* 4-slot (50ms) mode */
 		rtw_coex_tdma_timer_base(rtwdev, 3);
@@ -909,13 +921,18 @@ static void rtw_coex_tdma(struct rtw_dev *rtwdev, bool force, u32 tcase)
 		}
 	}
 
-	if (turn_on) {
-		/* enable TBTT interrupt */
+	/* enable TBTT interrupt */
+	if (turn_on)
 		rtw_write8_set(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
-		rtw_coex_write_scbd(rtwdev, COEX_SCBD_TDMA, true);
-	} else {
+
+	wl_busy = test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
+
+	if ((coex_stat->bt_a2dp_exist &&
+	     (coex_stat->bt_inq_remain || coex_stat->bt_multi_link)) ||
+	    !wl_busy)
 		rtw_coex_write_scbd(rtwdev, COEX_SCBD_TDMA, false);
-	}
+	else
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_TDMA, true);
 
 	if (efuse->share_ant) {
 		if (type < chip->tdma_sant_num)
@@ -1323,20 +1340,31 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 		/* Shared-Ant */
 		if (wl_hi_pri) {
 			table_case = 15;
-			if (coex_stat->bt_a2dp_exist &&
-			    !coex_stat->bt_pan_exist) {
-				slot_type = TDMA_4SLOT;
-				tdma_case = 11;
-			} else if (coex_stat->wl_hi_pri_task1) {
+			if (coex_stat->bt_profile_num > 0)
+				tdma_case = 10;
+			else if (coex_stat->wl_hi_pri_task1)
 				tdma_case = 6;
-			} else if (!coex_stat->bt_page) {
+			else if (!coex_stat->bt_page)
 				tdma_case = 8;
-			} else {
+			else
 				tdma_case = 9;
+		} else if (coex_stat->wl_gl_busy) {
+			if (coex_stat->bt_profile_num == 0) {
+				table_case = 12;
+				tdma_case = 18;
+			} else if (coex_stat->bt_profile_num == 1 &&
+				   !coex_stat->bt_a2dp_exist) {
+				slot_type = TDMA_4SLOT;
+				table_case = 12;
+				tdma_case = 20;
+			} else {
+				slot_type = TDMA_4SLOT;
+				table_case = 12;
+				tdma_case = 26;
 			}
 		} else if (coex_stat->wl_connected) {
-			table_case = 10;
-			tdma_case = 10;
+			table_case = 9;
+			tdma_case = 27;
 		} else {
 			table_case = 1;
 			tdma_case = 0;
@@ -2277,6 +2305,7 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	unsigned long bt_relink_time;
 	u8 i, rsp_source = 0, type;
+	bool inq_page = false;
 
 	rsp_source = buf[0] & 0xf;
 	if (rsp_source >= COEX_BTINFO_SRC_MAX)
@@ -2343,7 +2372,20 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 
 	/* 0xff means BT is under WHCK test */
 	coex_stat->bt_whck_test = (coex_stat->bt_info_lb2 == 0xff);
-	coex_stat->bt_inq_page = ((coex_stat->bt_info_lb2 & BIT(2)) == BIT(2));
+
+	inq_page = ((coex_stat->bt_info_lb2 & BIT(2)) == BIT(2));
+
+	if (inq_page != coex_stat->bt_inq_page) {
+		cancel_delayed_work_sync(&coex->bt_remain_work);
+		coex_stat->bt_inq_page = inq_page;
+
+		if (inq_page)
+			coex_stat->bt_inq_remain = true;
+		else
+			ieee80211_queue_delayed_work(rtwdev->hw,
+						     &coex->bt_remain_work,
+						     4 * HZ);
+	}
 	coex_stat->bt_acl_busy = ((coex_stat->bt_info_lb2 & BIT(3)) == BIT(3));
 	coex_stat->cnt_bt[COEX_CNT_BT_RETRY] = coex_stat->bt_info_lb3 & 0xf;
 	if (coex_stat->cnt_bt[COEX_CNT_BT_RETRY] >= 1)
@@ -2518,6 +2560,30 @@ void rtw_coex_defreeze_work(struct work_struct *work)
 	mutex_unlock(&rtwdev->mutex);
 }
 
+void rtw_coex_wl_remain_work(struct work_struct *work)
+{
+	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
+					      coex.wl_remain_work.work);
+	struct rtw_coex_stat *coex_stat = &rtwdev->coex.stat;
+
+	mutex_lock(&rtwdev->mutex);
+	coex_stat->wl_gl_busy = test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
+	rtw_coex_run_coex(rtwdev, COEX_RSN_WLSTATUS);
+	mutex_unlock(&rtwdev->mutex);
+}
+
+void rtw_coex_bt_remain_work(struct work_struct *work)
+{
+	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
+					      coex.bt_remain_work.work);
+	struct rtw_coex_stat *coex_stat = &rtwdev->coex.stat;
+
+	mutex_lock(&rtwdev->mutex);
+	coex_stat->bt_inq_remain = coex_stat->bt_inq_page;
+	rtw_coex_run_coex(rtwdev, COEX_RSN_BTSTATUS);
+	mutex_unlock(&rtwdev->mutex);
+}
+
 #ifdef CONFIG_RTW88_DEBUGFS
 #define INFO_SIZE	80
 
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index 4c3a01968f5e..44720fdfc053 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -95,6 +95,7 @@ enum coex_runreason {
 	COEX_RSN_BTINFO		= 12,
 	COEX_RSN_LPS		= 13,
 	COEX_RSN_WLSTATUS	= 14,
+	COEX_RSN_BTSTATUS	= 15,
 
 	COEX_RSN_MAX
 };
@@ -362,6 +363,8 @@ void rtw_coex_write_scbd(struct rtw_dev *rtwdev, u16 bitpos, bool set);
 void rtw_coex_bt_relink_work(struct work_struct *work);
 void rtw_coex_bt_reenable_work(struct work_struct *work);
 void rtw_coex_defreeze_work(struct work_struct *work);
+void rtw_coex_wl_remain_work(struct work_struct *work);
+void rtw_coex_bt_remain_work(struct work_struct *work);
 
 void rtw_coex_power_on_setting(struct rtw_dev *rtwdev);
 void rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 0eefafc51c62..6172f9a5b25f 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -935,6 +935,8 @@ void rtw_core_stop(struct rtw_dev *rtwdev)
 	cancel_delayed_work_sync(&coex->bt_relink_work);
 	cancel_delayed_work_sync(&coex->bt_reenable_work);
 	cancel_delayed_work_sync(&coex->defreeze_work);
+	cancel_delayed_work_sync(&coex->wl_remain_work);
+	cancel_delayed_work_sync(&coex->bt_remain_work);
 
 	mutex_lock(&rtwdev->mutex);
 
@@ -1422,6 +1424,8 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	INIT_DELAYED_WORK(&coex->bt_relink_work, rtw_coex_bt_relink_work);
 	INIT_DELAYED_WORK(&coex->bt_reenable_work, rtw_coex_bt_reenable_work);
 	INIT_DELAYED_WORK(&coex->defreeze_work, rtw_coex_defreeze_work);
+	INIT_DELAYED_WORK(&coex->wl_remain_work, rtw_coex_wl_remain_work);
+	INIT_DELAYED_WORK(&coex->bt_remain_work, rtw_coex_bt_remain_work);
 	INIT_WORK(&rtwdev->c2h_work, rtw_c2h_work);
 	INIT_WORK(&rtwdev->ba_work, rtw_txq_ba_work);
 	skb_queue_head_init(&rtwdev->c2h_queue);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 0841f5fa4bf2..4bd21cecab66 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1263,6 +1263,7 @@ struct rtw_coex_stat {
 	bool bt_link_exist;
 	bool bt_whck_test;
 	bool bt_inq_page;
+	bool bt_inq_remain;
 	bool bt_inq;
 	bool bt_page;
 	bool bt_ble_voice;
@@ -1363,6 +1364,8 @@ struct rtw_coex {
 	struct delayed_work bt_relink_work;
 	struct delayed_work bt_reenable_work;
 	struct delayed_work defreeze_work;
+	struct delayed_work wl_remain_work;
+	struct delayed_work bt_remain_work;
 };
 
 #define DPK_RF_REG_NUM 7
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 4700195c8eef..3ddd170f1651 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1956,13 +1956,13 @@ static const struct coex_table_para table_sant_8723d[] = {
 	{0xa5555555, 0xaaaa5aaa},
 	{0x6a5a5a5a, 0x5a5a5a5a},
 	{0x6a5a5a5a, 0x6a5a5a5a},
-	{0x65555555, 0x5a5a5a5a},
+	{0x66555555, 0x5a5a5a5a},
 	{0x65555555, 0x6a5a5a5a}, /* case-10 */
 	{0x65555555, 0xfafafafa},
-	{0x65555555, 0x6a5a5aaa},
+	{0x66555555, 0x5a5a5aaa},
 	{0x65555555, 0x5aaa5aaa},
 	{0x65555555, 0xaaaa5aaa},
-	{0x65555555, 0xaaaaaaaa}, /* case-15 */
+	{0x66555555, 0xaaaaaaaa}, /* case-15 */
 	{0xffff55ff, 0xfafafafa},
 	{0xffff55ff, 0x6afa5afa},
 	{0xaaffffaa, 0xfafafafa},
@@ -2034,8 +2034,9 @@ static const struct coex_tdma_para tdma_sant_8723d[] = {
 	{ {0x51, 0x0c, 0x03, 0x10, 0x54} },
 	{ {0x55, 0x08, 0x03, 0x10, 0x54} },
 	{ {0x65, 0x10, 0x03, 0x11, 0x11} },
-	{ {0x51, 0x10, 0x03, 0x10, 0x51} },
-	{ {0x61, 0x15, 0x03, 0x11, 0x10} }
+	{ {0x51, 0x10, 0x03, 0x10, 0x51} }, /* case-25 */
+	{ {0x51, 0x08, 0x03, 0x10, 0x50} },
+	{ {0x61, 0x08, 0x03, 0x11, 0x11} }
 };
 
 /* Non-Shared-Antenna TDMA */
@@ -2714,7 +2715,7 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.pwr_track_tbl = &rtw8723d_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
 
-	.coex_para_ver = 0x1905302f,
+	.coex_para_ver = 0x2007022f,
 	.bt_desired_ver = 0x2f,
 	.scbd_support = true,
 	.new_scbd10_def = true,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index e49bdd76ab9a..351cd055a295 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2147,7 +2147,7 @@ static const struct coex_table_para table_sant_8822b[] = {
 	{0x66555555, 0x5a5a5a5a},
 	{0x66555555, 0x6a5a5a5a}, /* case-10 */
 	{0x66555555, 0xfafafafa},
-	{0x66555555, 0x6a5a5aaa},
+	{0x66555555, 0x5a5a5aaa},
 	{0x66555555, 0x5aaa5aaa},
 	{0x66555555, 0xaaaa5aaa},
 	{0x66555555, 0xaaaaaaaa}, /* case-15 */
@@ -2223,7 +2223,8 @@ static const struct coex_tdma_para tdma_sant_8822b[] = {
 	{ {0x55, 0x08, 0x03, 0x10, 0x54} },
 	{ {0x65, 0x10, 0x03, 0x11, 0x11} },
 	{ {0x51, 0x10, 0x03, 0x10, 0x51} }, /* case-25 */
-	{ {0x51, 0x08, 0x03, 0x10, 0x50} }
+	{ {0x51, 0x08, 0x03, 0x10, 0x50} },
+	{ {0x61, 0x08, 0x03, 0x11, 0x11} }
 };
 
 /* Non-Shared-Antenna TDMA */
@@ -2475,7 +2476,7 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.bfer_mu_max_num = 1,
 	.rx_ldpc = true,
 
-	.coex_para_ver = 0x19062706,
+	.coex_para_ver = 0x20070206,
 	.bt_desired_ver = 0x6,
 	.scbd_support = true,
 	.new_scbd10_def = false,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index c3d72ef611c6..3efa284d81d1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3997,7 +3997,7 @@ static const struct coex_table_para table_sant_8822c[] = {
 	{0x66555555, 0x5a5a5a5a},
 	{0x66555555, 0x6a5a5a5a}, /* case-10 */
 	{0x66555555, 0xfafafafa},
-	{0x66555555, 0x6a5a5aaa},
+	{0x66555555, 0x5a5a5aaa},
 	{0x66555555, 0x5aaa5aaa},
 	{0x66555555, 0xaaaa5aaa},
 	{0x66555555, 0xaaaaaaaa}, /* case-15 */
@@ -4073,7 +4073,8 @@ static const struct coex_tdma_para tdma_sant_8822c[] = {
 	{ {0x55, 0x08, 0x03, 0x10, 0x54} },
 	{ {0x65, 0x10, 0x03, 0x11, 0x11} },
 	{ {0x51, 0x10, 0x03, 0x10, 0x51} }, /* case-25 */
-	{ {0x51, 0x08, 0x03, 0x10, 0x50} }
+	{ {0x51, 0x08, 0x03, 0x10, 0x50} },
+	{ {0x61, 0x08, 0x03, 0x11, 0x11} }
 };
 
 /* Non-Shared-Antenna TDMA */
@@ -4343,8 +4344,8 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.wowlan_stub = &rtw_wowlan_stub_8822c,
 	.max_sched_scan_ssids = 4,
 #endif
-	.coex_para_ver = 0x19062706,
-	.bt_desired_ver = 0x6,
+	.coex_para_ver = 0x20070217,
+	.bt_desired_ver = 0x17,
 	.scbd_support = true,
 	.new_scbd10_def = true,
 	.pstdma_type = COEX_PSTDMA_FORCE_LPSOFF,
-- 
2.17.1

