Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE72C314943
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 08:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhBIHKY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 02:10:24 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:35183 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhBIHKW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 02:10:22 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 11979bXH2006632, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 11979bXH2006632
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 9 Feb 2021 15:09:37 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 9 Feb 2021
 15:09:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH v5 4/8] rtw88: replace tx tasklet with work queue
Date:   Tue, 9 Feb 2021 15:07:51 +0800
Message-ID: <20210209070755.23019-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210209070755.23019-1-pkshih@realtek.com>
References: <20210209070755.23019-1-pkshih@realtek.com>
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
Reviewed-by: Brian Norris <briannorris@chromium.org>
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
index 871496713f98..e6989c0525cc 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1658,7 +1658,7 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 
 	timer_setup(&rtwdev->tx_report.purge_timer,
 		    rtw_tx_report_purge_timer, 0);
-	tasklet_setup(&rtwdev->tx_tasklet, rtw_tx_tasklet);
+	rtwdev->tx_wq = alloc_workqueue("rtw_tx_wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
 
 	INIT_DELAYED_WORK(&rtwdev->watch_dog_work, rtw_watch_dog_work);
 	INIT_DELAYED_WORK(&coex->bt_relink_work, rtw_coex_bt_relink_work);
@@ -1670,6 +1670,7 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	INIT_DELAYED_WORK(&coex->bt_multi_link_remain_work,
 			  rtw_coex_bt_multi_link_remain_work);
 	INIT_DELAYED_WORK(&coex->wl_ccklock_work, rtw_coex_wl_ccklock_work);
+	INIT_WORK(&rtwdev->tx_work, rtw_tx_work);
 	INIT_WORK(&rtwdev->c2h_work, rtw_c2h_work);
 	INIT_WORK(&rtwdev->fw_recovery_work, rtw_fw_recovery_work);
 	INIT_WORK(&rtwdev->ba_work, rtw_txq_ba_work);
@@ -1736,7 +1737,7 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 	if (wow_fw->firmware)
 		release_firmware(wow_fw->firmware);
 
-	tasklet_kill(&rtwdev->tx_tasklet);
+	destroy_workqueue(rtwdev->tx_wq);
 	spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
 	skb_queue_purge(&rtwdev->tx_report.queue);
 	spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index bc2702f73995..35afea91fd29 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -13,6 +13,7 @@
 #include <linux/bitfield.h>
 #include <linux/iopoll.h>
 #include <linux/interrupt.h>
+#include <linux/workqueue.h>
 
 #include "util.h"
 
@@ -1772,7 +1773,8 @@ struct rtw_dev {
 	/* used to protect txqs list */
 	spinlock_t txq_lock;
 	struct list_head txqs;
-	struct tasklet_struct tx_tasklet;
+	struct workqueue_struct *tx_wq;
+	struct work_struct tx_work;
 	struct work_struct ba_work;
 
 	struct rtw_tx_report tx_report;
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 313b824dca6d..0193708fc013 100644
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

