Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEC58C47CF
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfJBGfn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:35:43 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57689 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfJBGfm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:35:42 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x926ZaBi013052, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw [172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTP id x926ZaBi013052;
        Wed, 2 Oct 2019 14:35:36 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 14:35:36 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 03/14] rtw88: add driver TX queue support
Date:   Wed, 2 Oct 2019 14:35:20 +0800
Message-ID: <20191002063531.18135-4-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002063531.18135-1-yhchuang@realtek.com>
References: <20191002063531.18135-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

The mac80211 provides software TX queue for driver, as long as
driver has hooked ieee80211_ops::wake_tx_queue. Each time a
packet is queued onto the TX queue, that queue will be woken
up the inform driver to serve the queue.

Now driver only supports PCI interface ICs, there's no specific
traffic control for each queue, just schedule a tasklet, and
dump all of the packets at once to the DMA ring. Instead of TX
the packets whenever TX queue is woke, tasklet handler can have
more packets dumped to the device, takes advantage of burst
write with DMA engine.

And if the driver is going to support USB/SDIO ICs, the tasklet
can be more flexible for aggregating the packets, enhance the
efficiency of bandwidth usage.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 40 ++++++--
 drivers/net/wireless/realtek/rtw88/main.c     |  7 ++
 drivers/net/wireless/realtek/rtw88/main.h     | 17 ++++
 drivers/net/wireless/realtek/rtw88/tx.c       | 95 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/tx.h       |  6 ++
 5 files changed, 156 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 1646f38fd940..47ea69434b96 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -17,19 +17,30 @@ static void rtw_ops_tx(struct ieee80211_hw *hw,
 		       struct sk_buff *skb)
 {
 	struct rtw_dev *rtwdev = hw->priv;
-	struct rtw_tx_pkt_info pkt_info = {0};
 
-	if (!test_bit(RTW_FLAG_RUNNING, rtwdev->flags))
-		goto out;
+	if (!test_bit(RTW_FLAG_RUNNING, rtwdev->flags)) {
+		ieee80211_free_txskb(hw, skb);
+		return;
+	}
 
-	rtw_tx_pkt_info_update(rtwdev, &pkt_info, control, skb);
-	if (rtw_hci_tx(rtwdev, &pkt_info, skb))
-		goto out;
+	rtw_tx(rtwdev, control, skb);
+}
 
-	return;
+static void rtw_ops_wake_tx_queue(struct ieee80211_hw *hw,
+				  struct ieee80211_txq *txq)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+	struct rtw_txq *rtwtxq = (struct rtw_txq *)txq->drv_priv;
 
-out:
-	ieee80211_free_txskb(hw, skb);
+	if (!test_bit(RTW_FLAG_RUNNING, rtwdev->flags))
+		return;
+
+	spin_lock_bh(&rtwdev->txq_lock);
+	if (list_empty(&rtwtxq->list))
+		list_add_tail(&rtwtxq->list, &rtwdev->txqs);
+	spin_unlock_bh(&rtwdev->txq_lock);
+
+	tasklet_schedule(&rtwdev->tx_tasklet);
 }
 
 static int rtw_ops_start(struct ieee80211_hw *hw)
@@ -147,6 +158,7 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 	rtwvif->stats.rx_cnt = 0;
 	rtwvif->in_lps = false;
 	rtwvif->conf = &rtw_vif_port[port];
+	rtw_txq_init(rtwdev, vif->txq);
 
 	mutex_lock(&rtwdev->mutex);
 
@@ -196,6 +208,8 @@ static void rtw_ops_remove_interface(struct ieee80211_hw *hw,
 
 	rtw_leave_lps_deep(rtwdev);
 
+	rtw_txq_cleanup(rtwdev, vif->txq);
+
 	eth_zero_addr(rtwvif->mac_addr);
 	config |= PORT_SET_MAC_ADDR;
 	rtwvif->net_type = RTW_NET_NO_LINK;
@@ -333,6 +347,7 @@ static int rtw_ops_sta_add(struct ieee80211_hw *hw,
 {
 	struct rtw_dev *rtwdev = hw->priv;
 	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
+	int i;
 	int ret = 0;
 
 	mutex_lock(&rtwdev->mutex);
@@ -347,6 +362,8 @@ static int rtw_ops_sta_add(struct ieee80211_hw *hw,
 	si->vif = vif;
 	si->init_ra_lv = 1;
 	ewma_rssi_init(&si->avg_rssi);
+	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
+		rtw_txq_init(rtwdev, sta->txq[i]);
 
 	rtw_update_sta_info(rtwdev, si);
 	rtw_fw_media_status_report(rtwdev, si->mac_id, true);
@@ -367,12 +384,16 @@ static int rtw_ops_sta_remove(struct ieee80211_hw *hw,
 {
 	struct rtw_dev *rtwdev = hw->priv;
 	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
+	int i;
 
 	mutex_lock(&rtwdev->mutex);
 
 	rtw_release_macid(rtwdev, si->mac_id);
 	rtw_fw_media_status_report(rtwdev, si->mac_id, false);
 
+	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
+		rtw_txq_cleanup(rtwdev, sta->txq[i]);
+
 	rtwdev->sta_cnt--;
 
 	rtw_info(rtwdev, "sta %pM with macid %d left\n",
@@ -554,6 +575,7 @@ static int rtw_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 
 const struct ieee80211_ops rtw_ops = {
 	.tx			= rtw_ops_tx,
+	.wake_tx_queue		= rtw_ops_wake_tx_queue,
 	.start			= rtw_ops_start,
 	.stop			= rtw_ops_stop,
 	.config			= rtw_ops_config,
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index a3e9f917adef..3a09a5b123a7 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -12,6 +12,7 @@
 #include "phy.h"
 #include "reg.h"
 #include "efuse.h"
+#include "tx.h"
 #include "debug.h"
 
 unsigned int rtw_fw_lps_deep_mode;
@@ -1158,9 +1159,12 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	int ret;
 
 	INIT_LIST_HEAD(&rtwdev->rsvd_page_list);
+	INIT_LIST_HEAD(&rtwdev->txqs);
 
 	timer_setup(&rtwdev->tx_report.purge_timer,
 		    rtw_tx_report_purge_timer, 0);
+	tasklet_init(&rtwdev->tx_tasklet, rtw_tx_tasklet,
+		     (unsigned long)rtwdev);
 
 	INIT_DELAYED_WORK(&rtwdev->watch_dog_work, rtw_watch_dog_work);
 	INIT_DELAYED_WORK(&coex->bt_relink_work, rtw_coex_bt_relink_work);
@@ -1174,6 +1178,7 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	spin_lock_init(&rtwdev->dm_lock);
 	spin_lock_init(&rtwdev->rf_lock);
 	spin_lock_init(&rtwdev->h2c.lock);
+	spin_lock_init(&rtwdev->txq_lock);
 	spin_lock_init(&rtwdev->tx_report.q_lock);
 
 	mutex_init(&rtwdev->mutex);
@@ -1218,6 +1223,7 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 	if (fw->firmware)
 		release_firmware(fw->firmware);
 
+	tasklet_kill(&rtwdev->tx_tasklet);
 	spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
 	skb_queue_purge(&rtwdev->tx_report.queue);
 	spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
@@ -1243,6 +1249,7 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 
 	hw->extra_tx_headroom = max_tx_headroom;
 	hw->queues = IEEE80211_NUM_ACS;
+	hw->txq_data_size = sizeof(struct rtw_txq);
 	hw->sta_data_size = sizeof(struct rtw_sta_info);
 	hw->vif_data_size = sizeof(struct rtw_vif);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 810bf151ad36..cfe94a685dde 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -587,6 +587,11 @@ struct rtw_tx_report {
 	struct timer_list purge_timer;
 };
 
+struct rtw_txq {
+	struct list_head list;
+	unsigned long last_push;
+};
+
 #define RTW_BC_MC_MACID 1
 DECLARE_EWMA(rssi, 10, 16);
 
@@ -1361,6 +1366,11 @@ struct rtw_dev {
 	struct sk_buff_head c2h_queue;
 	struct work_struct c2h_work;
 
+	/* used to protect txqs list */
+	spinlock_t txq_lock;
+	struct list_head txqs;
+	struct tasklet_struct tx_tasklet;
+
 	struct rtw_tx_report tx_report;
 
 	struct {
@@ -1396,6 +1406,13 @@ static inline bool rtw_is_assoc(struct rtw_dev *rtwdev)
 	return !!rtwdev->sta_cnt;
 }
 
+static inline struct ieee80211_txq *rtwtxq_to_txq(struct rtw_txq *rtwtxq)
+{
+	void *p = rtwtxq;
+
+	return container_of(p, struct ieee80211_txq, drv_priv);
+}
+
 void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 			    struct rtw_channel_params *ch_param);
 bool check_hw_ready(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 target);
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 25fa932d0208..1e19bdac1d45 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -367,3 +367,98 @@ void rtw_rsvd_page_pkt_info_update(struct rtw_dev *rtwdev,
 	pkt_info->qsel = TX_DESC_QSEL_MGMT;
 	pkt_info->ls = true;
 }
+
+void rtw_tx(struct rtw_dev *rtwdev,
+	    struct ieee80211_tx_control *control,
+	    struct sk_buff *skb)
+{
+	struct rtw_tx_pkt_info pkt_info = {0};
+
+	rtw_tx_pkt_info_update(rtwdev, &pkt_info, control, skb);
+	if (rtw_hci_tx(rtwdev, &pkt_info, skb))
+		goto out;
+
+	return;
+
+out:
+	ieee80211_free_txskb(rtwdev->hw, skb);
+}
+
+static bool rtw_txq_dequeue(struct rtw_dev *rtwdev,
+			    struct rtw_txq *rtwtxq)
+{
+	struct ieee80211_txq *txq = rtwtxq_to_txq(rtwtxq);
+	struct ieee80211_tx_control control;
+	struct sk_buff *skb;
+
+	skb = ieee80211_tx_dequeue(rtwdev->hw, txq);
+	if (!skb)
+		return false;
+
+	control.sta = txq->sta;
+	rtw_tx(rtwdev, &control, skb);
+	rtwtxq->last_push = jiffies;
+
+	return true;
+}
+
+static void rtw_txq_push(struct rtw_dev *rtwdev,
+			 struct rtw_txq *rtwtxq,
+			 unsigned long frames)
+{
+	int i;
+
+	rcu_read_lock();
+
+	for (i = 0; i < frames; i++)
+		if (!rtw_txq_dequeue(rtwdev, rtwtxq))
+			break;
+
+	rcu_read_unlock();
+}
+
+void rtw_tx_tasklet(unsigned long data)
+{
+	struct rtw_dev *rtwdev = (void *)data;
+	struct rtw_txq *rtwtxq, *tmp;
+
+	spin_lock_bh(&rtwdev->txq_lock);
+
+	list_for_each_entry_safe(rtwtxq, tmp, &rtwdev->txqs, list) {
+		struct ieee80211_txq *txq = rtwtxq_to_txq(rtwtxq);
+		unsigned long frame_cnt;
+		unsigned long byte_cnt;
+
+		ieee80211_txq_get_depth(txq, &frame_cnt, &byte_cnt);
+		rtw_txq_push(rtwdev, rtwtxq, frame_cnt);
+
+		list_del_init(&rtwtxq->list);
+	}
+
+	spin_unlock_bh(&rtwdev->txq_lock);
+}
+
+void rtw_txq_init(struct rtw_dev *rtwdev, struct ieee80211_txq *txq)
+{
+	struct rtw_txq *rtwtxq;
+
+	if (!txq)
+		return;
+
+	rtwtxq = (struct rtw_txq *)txq->drv_priv;
+	INIT_LIST_HEAD(&rtwtxq->list);
+}
+
+void rtw_txq_cleanup(struct rtw_dev *rtwdev, struct ieee80211_txq *txq)
+{
+	struct rtw_txq *rtwtxq;
+
+	if (!txq)
+		return;
+
+	rtwtxq = (struct rtw_txq *)txq->drv_priv;
+	spin_lock_bh(&rtwdev->txq_lock);
+	if (!list_empty(&rtwtxq->list))
+		list_del_init(&rtwtxq->list);
+	spin_unlock_bh(&rtwdev->txq_lock);
+}
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index ab5b71f8ac22..9ca4f74a501b 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -77,6 +77,12 @@ enum rtw_tx_desc_queue_select {
 	TX_DESC_QSEL_H2C	= 19,
 };
 
+void rtw_tx(struct rtw_dev *rtwdev,
+	    struct ieee80211_tx_control *control,
+	    struct sk_buff *skb);
+void rtw_txq_init(struct rtw_dev *rtwdev, struct ieee80211_txq *txq);
+void rtw_txq_cleanup(struct rtw_dev *rtwdev, struct ieee80211_txq *txq);
+void rtw_tx_tasklet(unsigned long data);
 void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 			    struct rtw_tx_pkt_info *pkt_info,
 			    struct ieee80211_tx_control *control,
-- 
2.17.1

