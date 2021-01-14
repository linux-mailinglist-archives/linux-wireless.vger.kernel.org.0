Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB79C2F568C
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 02:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbhANBtS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jan 2021 20:49:18 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:33182 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbhANAgr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jan 2021 19:36:47 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10E0ZpHzA003554, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10E0ZpHzA003554
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Jan 2021 08:35:52 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 14 Jan
 2021 08:35:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH v3 4/8] rtw88: replace tx tasklet with tx work
Date:   Thu, 14 Jan 2021 08:34:52 +0800
Message-ID: <20210114003456.3011-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210114003456.3011-1-pkshih@realtek.com>
References: <20210114003456.3011-1-pkshih@realtek.com>
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

Move tx tasklet to thread, by this we can reduce time spent on
waiting for schedule and have better efficiency.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 +-
 drivers/net/wireless/realtek/rtw88/main.c     |  7 ++-
 drivers/net/wireless/realtek/rtw88/main.h     |  2 +-
 drivers/net/wireless/realtek/rtw88/tx.c       |  4 +-
 drivers/net/wireless/realtek/rtw88/tx.h       |  2 +-
 drivers/net/wireless/realtek/rtw88/util.c     | 20 +++++++
 drivers/net/wireless/realtek/rtw88/util.h     | 54 +++++++++++++++++++
 7 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 1f1b639cd124..501e8b3bd951 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -42,7 +42,7 @@ static void rtw_ops_wake_tx_queue(struct ieee80211_hw *hw,
 		list_add_tail(&rtwtxq->list, &rtwdev->txqs);
 	spin_unlock_bh(&rtwdev->txq_lock);
 
-	tasklet_schedule(&rtwdev->tx_tasklet);
+	rtw_work_schedule(&rtwdev->tx_work);
 }
 
 static int rtw_ops_start(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 07ea9df48149..83c238525a3a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2018-2019  Realtek Corporation
  */
 
+#include <uapi/linux/sched/types.h>
 #include "main.h"
 #include "regd.h"
 #include "fw.h"
@@ -311,6 +312,7 @@ void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 		rtw_txq_cleanup(rtwdev, sta->txq[i]);
 
+	bitmap_zero(rtwdev->tx_work.state, RTW_WORK_FLAG_MAX);
 	kfree(si->mask);
 
 	rtwdev->sta_cnt--;
@@ -1657,7 +1659,8 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 
 	timer_setup(&rtwdev->tx_report.purge_timer,
 		    rtw_tx_report_purge_timer, 0);
-	tasklet_setup(&rtwdev->tx_tasklet, rtw_tx_tasklet);
+	rtw_work_setup(&rtwdev->tx_work, rtw_tx_work);
+	sched_set_fifo_low(rtwdev->tx_work.task);
 
 	INIT_DELAYED_WORK(&rtwdev->watch_dog_work, rtw_watch_dog_work);
 	INIT_DELAYED_WORK(&coex->bt_relink_work, rtw_coex_bt_relink_work);
@@ -1735,7 +1738,7 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 	if (wow_fw->firmware)
 		release_firmware(wow_fw->firmware);
 
-	tasklet_kill(&rtwdev->tx_tasklet);
+	rtw_work_kill(&rtwdev->tx_work);
 	spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
 	skb_queue_purge(&rtwdev->tx_report.queue);
 	spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 628a62007629..5b979bec3d9a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1765,7 +1765,7 @@ struct rtw_dev {
 	/* used to protect txqs list */
 	spinlock_t txq_lock;
 	struct list_head txqs;
-	struct tasklet_struct tx_tasklet;
+	struct rtw_work tx_work;
 	struct work_struct ba_work;
 
 	struct rtw_tx_report tx_report;
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 0d755d9ff5f3..4a730542f312 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -592,9 +592,9 @@ static void rtw_txq_push(struct rtw_dev *rtwdev,
 	rcu_read_unlock();
 }
 
-void rtw_tx_tasklet(struct tasklet_struct *t)
+void rtw_tx_work(struct rtw_work *w)
 {
-	struct rtw_dev *rtwdev = from_tasklet(rtwdev, t, tx_tasklet);
+	struct rtw_dev *rtwdev = container_of(w, struct rtw_dev, tx_work);
 	struct rtw_txq *rtwtxq, *tmp;
 
 	spin_lock_bh(&rtwdev->txq_lock);
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index 022288c9b5fc..5828ddbb38a5 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -98,7 +98,7 @@ void rtw_tx(struct rtw_dev *rtwdev,
 	    struct sk_buff *skb);
 void rtw_txq_init(struct rtw_dev *rtwdev, struct ieee80211_txq *txq);
 void rtw_txq_cleanup(struct rtw_dev *rtwdev, struct ieee80211_txq *txq);
-void rtw_tx_tasklet(struct tasklet_struct *t);
+void rtw_tx_work(struct rtw_work *w);
 void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 			    struct rtw_tx_pkt_info *pkt_info,
 			    struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/realtek/rtw88/util.c b/drivers/net/wireless/realtek/rtw88/util.c
index 2c515af214e7..360e1297e01e 100644
--- a/drivers/net/wireless/realtek/rtw88/util.c
+++ b/drivers/net/wireless/realtek/rtw88/util.c
@@ -105,3 +105,23 @@ void rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss)
 		*mcs = rate - DESC_RATEMCS0;
 	}
 }
+
+int rtw_work_func(void *ptr)
+{
+	struct rtw_work *w = ptr;
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (!test_and_clear_bit(RTW_WORK_FLAG_SCHEDULED, w->state)) {
+			schedule();
+			continue;
+		}
+		set_bit(RTW_WORK_FLAG_RUNNING, w->state);
+		set_current_state(TASK_RUNNING);
+		w->callback(w);
+		cond_resched();
+		clear_bit(RTW_WORK_FLAG_RUNNING, w->state);
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/realtek/rtw88/util.h b/drivers/net/wireless/realtek/rtw88/util.h
index 0c23b5069be0..9e4d9bec0531 100644
--- a/drivers/net/wireless/realtek/rtw88/util.h
+++ b/drivers/net/wireless/realtek/rtw88/util.h
@@ -5,8 +5,62 @@
 #ifndef __RTW_UTIL_H__
 #define __RTW_UTIL_H__
 
+#include <linux/err.h>
+
 struct rtw_dev;
 
+enum {
+	RTW_WORK_FLAG_SCHEDULED,
+	RTW_WORK_FLAG_RUNNING,
+
+	/* keep last */
+	RTW_WORK_FLAG_MAX,
+};
+
+struct rtw_work {
+	struct task_struct *task;
+	void (*callback)(struct rtw_work *w);
+	DECLARE_BITMAP(state, RTW_WORK_FLAG_MAX);
+};
+
+int rtw_work_func(void *ptr);
+
+static inline int rtw_work_setup(struct rtw_work *w,
+				 void (*cb)(struct rtw_work *w))
+{
+	int ret;
+
+	w->callback = cb;
+	w->task = kthread_create(rtw_work_func, w, "rtw_tx_work");
+
+	ret = PTR_ERR_OR_ZERO(w->task);
+	if (ret) {
+		w->task = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline void rtw_work_kill(struct rtw_work *w)
+{
+	if (!w->task)
+		return;
+
+	kthread_stop(w->task);
+	w->task = NULL;
+}
+
+static inline void rtw_work_schedule(struct rtw_work *w)
+{
+	if (!w->task)
+		return;
+
+	if (!test_and_set_bit(RTW_WORK_FLAG_SCHEDULED, w->state) &&
+	    !test_bit(RTW_WORK_FLAG_RUNNING, w->state))
+		wake_up_process(w->task);
+}
+
 #define rtw_iterate_vifs(rtwdev, iterator, data)                               \
 	ieee80211_iterate_active_interfaces(rtwdev->hw,                        \
 			IEEE80211_IFACE_ITER_NORMAL, iterator, data)
-- 
2.21.0

