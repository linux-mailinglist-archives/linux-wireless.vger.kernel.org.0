Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BD72F7536
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 10:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbhAOJ0E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 04:26:04 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:53917 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbhAOJ0D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 04:26:03 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10F9PHEz8001234, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10F9PHEz8001234
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Jan 2021 17:25:17 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 15 Jan
 2021 17:25:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH v4 4/8] rtw88: replace tx tasklet with work queue
Date:   Fri, 15 Jan 2021 17:24:01 +0800
Message-ID: <20210115092405.8081-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210115092405.8081-1-pkshih@realtek.com>
References: <20210115092405.8081-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Replace tasklet so we can do tx scheduling in parallel. Since throughput
is delay-sensitive in most cases, we allocate a dedicated, high priority
wq for our needs.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v4: tx work use work queue instead of bare kthread
    (Also, subject is changed)
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 2 +-
 drivers/net/wireless/realtek/rtw88/main.c     | 5 +++--
 drivers/net/wireless/realtek/rtw88/main.h     | 4 +++-
 drivers/net/wireless/realtek/rtw88/tx.c       | 4 ++--
 drivers/net/wireless/realtek/rtw88/tx.h       | 2 +-
 5 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 1f1b639cd124..2351dfb0d2e2 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -42,7 +42,7 @@ static void rtw_ops_wake_tx_queue(struct ieee80211_hw *hw,
 		list_add_tail(&rtwtxq->list, &rtwdev->txqs);
 	spin_unlock_bh(&rtwdev->txq_lock);
 
-	tasklet_schedule(&rtwdev->tx_tasklet);
+	queue_work(rtwdev->tx_wq, &rtwdev->tx_work);
 }
 
 static int rtw_ops_start(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 07ea9df48149..258663a2c40e 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1657,7 +1657,7 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 
 	timer_setup(&rtwdev->tx_report.purge_timer,
 		    rtw_tx_report_purge_timer, 0);
-	tasklet_setup(&rtwdev->tx_tasklet, rtw_tx_tasklet);
+	rtwdev->tx_wq = alloc_workqueue("rtw_tx_wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
 
 	INIT_DELAYED_WORK(&rtwdev->watch_dog_work, rtw_watch_dog_work);
 	INIT_DELAYED_WORK(&coex->bt_relink_work, rtw_coex_bt_relink_work);
@@ -1669,6 +1669,7 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	INIT_DELAYED_WORK(&coex->bt_multi_link_remain_work,
 			  rtw_coex_bt_multi_link_remain_work);
 	INIT_DELAYED_WORK(&coex->wl_ccklock_work, rtw_coex_wl_ccklock_work);
+	INIT_WORK(&rtwdev->tx_work, rtw_tx_work);
 	INIT_WORK(&rtwdev->c2h_work, rtw_c2h_work);
 	INIT_WORK(&rtwdev->fw_recovery_work, rtw_fw_recovery_work);
 	INIT_WORK(&rtwdev->ba_work, rtw_txq_ba_work);
@@ -1735,7 +1736,7 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 	if (wow_fw->firmware)
 		release_firmware(wow_fw->firmware);
 
-	tasklet_kill(&rtwdev->tx_tasklet);
+	destroy_workqueue(rtwdev->tx_wq);
 	spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
 	skb_queue_purge(&rtwdev->tx_report.queue);
 	spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 628a62007629..10e19f77c1b5 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -13,6 +13,7 @@
 #include <linux/bitfield.h>
 #include <linux/iopoll.h>
 #include <linux/interrupt.h>
+#include <linux/workqueue.h>
 
 #include "util.h"
 
@@ -1765,7 +1766,8 @@ struct rtw_dev {
 	/* used to protect txqs list */
 	spinlock_t txq_lock;
 	struct list_head txqs;
-	struct tasklet_struct tx_tasklet;
+	struct workqueue_struct *tx_wq;
+	struct work_struct tx_work;
 	struct work_struct ba_work;
 
 	struct rtw_tx_report tx_report;
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 0d755d9ff5f3..605b2589f135 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -592,9 +592,9 @@ static void rtw_txq_push(struct rtw_dev *rtwdev,
 	rcu_read_unlock();
 }
 
-void rtw_tx_tasklet(struct tasklet_struct *t)
+void rtw_tx_work(struct work_struct *w)
 {
-	struct rtw_dev *rtwdev = from_tasklet(rtwdev, t, tx_tasklet);
+	struct rtw_dev *rtwdev = container_of(w, struct rtw_dev, tx_work);
 	struct rtw_txq *rtwtxq, *tmp;
 
 	spin_lock_bh(&rtwdev->txq_lock);
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index 022288c9b5fc..56371eff9f7f 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -98,7 +98,7 @@ void rtw_tx(struct rtw_dev *rtwdev,
 	    struct sk_buff *skb);
 void rtw_txq_init(struct rtw_dev *rtwdev, struct ieee80211_txq *txq);
 void rtw_txq_cleanup(struct rtw_dev *rtwdev, struct ieee80211_txq *txq);
-void rtw_tx_tasklet(struct tasklet_struct *t);
+void rtw_tx_work(struct work_struct *w);
 void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 			    struct rtw_tx_pkt_info *pkt_info,
 			    struct ieee80211_sta *sta,
-- 
2.21.0

