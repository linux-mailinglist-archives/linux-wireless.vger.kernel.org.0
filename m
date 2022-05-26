Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C258534A2B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 May 2022 07:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiEZFNS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 May 2022 01:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiEZFNR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 May 2022 01:13:17 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE77AEE3A
        for <linux-wireless@vger.kernel.org>; Wed, 25 May 2022 22:13:14 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24Q5CxS42004891, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24Q5CxS42004891
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 May 2022 13:12:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 26 May 2022 13:12:59 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 26 May
 2022 13:12:58 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <megi@xff.cz>,
        <phhuang@realtek.com>
Subject: [PATCH] rtw88: add a work to correct atomic scheduling warning of ::set_tim
Date:   Thu, 26 May 2022 13:12:51 +0800
Message-ID: <20220526051251.281905-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/26/2022 05:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMjYg5LiK5Y2IIDAxOjU1OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The set_tim is supposed to be atomic, but we should download beacon
context to firmware with a mutex lock. To avoid warning, do the thing in
another work.

BUG: scheduling while atomic: swapper/1/0/0x00000700
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.18.0-rc7-00703-g33b5ee09a0c1 #4
Hardware name: Pine64 RK3566 Quartz64-A Board (DT)
Call trace:
 dump_backtrace.part.0+0xc4/0xd0
 show_stack+0x14/0x60
 dump_stack_lvl+0x60/0x78
 dump_stack+0x14/0x2c
 __schedule_bug+0x5c/0x70
 __schedule+0x5c4/0x630
 schedule+0x44/0xb0
 schedule_preempt_disabled+0xc/0x14
 __mutex_lock.constprop.0+0x538/0x56c
 __mutex_lock_slowpath+0x10/0x20
 mutex_lock+0x54/0x60
 rtw_ops_set_tim+0x20/0x40
 __sta_info_recalc_tim+0x150/0x250
 sta_info_recalc_tim+0x10/0x20
 invoke_tx_handlers_early+0x4e4/0x5c0
 ieee80211_tx+0x78/0x110
 ieee80211_xmit+0x94/0xc0
 __ieee80211_subif_start_xmit+0x818/0xd20
 ieee80211_subif_start_xmit+0x44/0x2d0
 dev_hard_start_xmit+0xd0/0x150
 __dev_queue_xmit+0x250/0xb30
 dev_queue_xmit+0x10/0x20
 br_dev_queue_push_xmit+0x94/0x174
 br_forward_finish+0x90/0xa0
 __br_forward+0xc0/0x13c
 br_forward+0x108/0x134
 br_dev_xmit+0x1cc/0x3a4
 dev_hard_start_xmit+0xd0/0x150
 __dev_queue_xmit+0x250/0xb30
 dev_queue_xmit+0x10/0x20
 arp_xmit+0x6c/0x7c
 arp_send_dst+0x8c/0xc0
 arp_solicit+0xd4/0x1e0
 neigh_probe+0x58/0xa0
 neigh_timer_handler+0x27c/0x380
 call_timer_fn.constprop.0+0x20/0x80
 __run_timers.part.0+0x230/0x280
 run_timer_softirq+0x38/0x70
 _stext+0x104/0x278
 __irq_exit_rcu+0xa4/0xdc
 irq_exit_rcu+0xc/0x14
 el1_interrupt+0x34/0x50
 el1h_64_irq_handler+0x14/0x20
 el1h_64_irq+0x64/0x68
 arch_cpu_idle+0x14/0x20
 do_idle+0x208/0x290
 cpu_startup_entry+0x20/0x30
 secondary_start_kernel+0x130/0x144
 __secondary_switched+0x54/0x58

Fixes: f2217968ffda ("rtw88: Add update beacon flow for AP mode")
Reported-by: Ondřej Jirman <megi@xff.cz>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 10 ++++++++++
 drivers/net/wireless/realtek/rtw88/fw.h       |  1 +
 drivers/net/wireless/realtek/rtw88/mac80211.c |  4 +---
 drivers/net/wireless/realtek/rtw88/main.c     |  2 ++
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 090610e48d08c..c3ae631c2264f 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1602,6 +1602,16 @@ int rtw_fw_download_rsvd_page(struct rtw_dev *rtwdev)
 	return ret;
 }
 
+void rtw_fw_update_beacon_work(struct work_struct *work)
+{
+	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
+					      update_beacon_work);
+
+	mutex_lock(&rtwdev->mutex);
+	rtw_fw_download_rsvd_page(rtwdev);
+	mutex_unlock(&rtwdev->mutex);
+}
+
 static void rtw_fw_read_fifo_page(struct rtw_dev *rtwdev, u32 offset, u32 size,
 				  u32 *buf, u32 residue, u16 start_pg)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 734113fba184e..7a37675c61e89 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -809,6 +809,7 @@ void rtw_add_rsvd_page_pno(struct rtw_dev *rtwdev,
 void rtw_add_rsvd_page_sta(struct rtw_dev *rtwdev,
 			   struct rtw_vif *rtwvif);
 int rtw_fw_download_rsvd_page(struct rtw_dev *rtwdev);
+void rtw_fw_update_beacon_work(struct work_struct *work);
 void rtw_send_rsvd_page_h2c(struct rtw_dev *rtwdev);
 int rtw_dump_drv_rsvd_page(struct rtw_dev *rtwdev,
 			   u32 offset, u32 size, u32 *buf);
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 30903c567cd9b..4310362dc333e 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -493,9 +493,7 @@ static int rtw_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 {
 	struct rtw_dev *rtwdev = hw->priv;
 
-	mutex_lock(&rtwdev->mutex);
-	rtw_fw_download_rsvd_page(rtwdev);
-	mutex_unlock(&rtwdev->mutex);
+	ieee80211_queue_work(hw, &rtwdev->update_beacon_work);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 14289f83feb54..efabd5b1bf5b6 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1442,6 +1442,7 @@ void rtw_core_stop(struct rtw_dev *rtwdev)
 	mutex_unlock(&rtwdev->mutex);
 
 	cancel_work_sync(&rtwdev->c2h_work);
+	cancel_work_sync(&rtwdev->update_beacon_work);
 	cancel_delayed_work_sync(&rtwdev->watch_dog_work);
 	cancel_delayed_work_sync(&coex->bt_relink_work);
 	cancel_delayed_work_sync(&coex->bt_reenable_work);
@@ -1998,6 +1999,7 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	INIT_WORK(&rtwdev->c2h_work, rtw_c2h_work);
 	INIT_WORK(&rtwdev->ips_work, rtw_ips_work);
 	INIT_WORK(&rtwdev->fw_recovery_work, rtw_fw_recovery_work);
+	INIT_WORK(&rtwdev->update_beacon_work, rtw_fw_update_beacon_work);
 	INIT_WORK(&rtwdev->ba_work, rtw_txq_ba_work);
 	skb_queue_head_init(&rtwdev->c2h_queue);
 	skb_queue_head_init(&rtwdev->coex.queue);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 0baaf5a32e82d..c02be4ac159e3 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -2008,6 +2008,7 @@ struct rtw_dev {
 	struct work_struct c2h_work;
 	struct work_struct ips_work;
 	struct work_struct fw_recovery_work;
+	struct work_struct update_beacon_work;
 
 	/* used to protect txqs list */
 	spinlock_t txq_lock;
-- 
2.25.1

