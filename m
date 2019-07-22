Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43EC06F8EC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 07:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfGVFbz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 01:31:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49475 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726534AbfGVFbz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 01:31:55 -0400
X-UUID: 9de669840e8e49aabd844db081b6a353-20190722
X-UUID: 9de669840e8e49aabd844db081b6a353-20190722
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 832101039; Mon, 22 Jul 2019 13:31:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 22 Jul 2019 13:31:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 22 Jul 2019 13:31:20 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 5/5] mt76: fix some checkpatch warnings
Date:   Mon, 22 Jul 2019 13:31:15 +0800
Message-ID: <9a10dc24831f9b56c28a96e7e1eb99f03c8337fc.1563772403.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1563772403.git.ryder.lee@mediatek.com>
References: <cover.1563772403.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 35DB3973583DE7166B80F298B7DAEBCA28DA696E5038D0D15D829A76849EAC292000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This fixes the following checkpatch.pl warning:
ERROR: Macros with complex values should be enclosed in parentheses
CHECK: Alignment should match open parenthesis
CHECK: No space is necessary after a cast

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/agg-rx.c   | 21 +++++----
 drivers/net/wireless/mediatek/mt76/dma.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c | 30 ++++++------
 drivers/net/wireless/mediatek/mt76/mt76.h     | 46 +++++++++----------
 drivers/net/wireless/mediatek/mt76/trace.h    |  9 ++--
 drivers/net/wireless/mediatek/mt76/tx.c       | 18 ++++----
 drivers/net/wireless/mediatek/mt76/usb.c      | 31 +++++++------
 .../net/wireless/mediatek/mt76/usb_trace.h    | 11 +++--
 drivers/net/wireless/mediatek/mt76/util.h     |  4 +-
 9 files changed, 89 insertions(+), 83 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 27e3ff039c48..4d33efdb3555 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -34,8 +34,9 @@ mt76_aggr_release(struct mt76_rx_tid *tid, struct sk_buff_head *frames, int idx)
 }
 
 static void
-mt76_rx_aggr_release_frames(struct mt76_rx_tid *tid, struct sk_buff_head *frames,
-			 u16 head)
+mt76_rx_aggr_release_frames(struct mt76_rx_tid *tid,
+			    struct sk_buff_head *frames,
+			    u16 head)
 {
 	int idx;
 
@@ -74,15 +75,14 @@ mt76_rx_aggr_check_release(struct mt76_rx_tid *tid, struct sk_buff_head *frames)
 	for (idx = (tid->head + 1) % tid->size;
 	     idx != start && nframes;
 	     idx = (idx + 1) % tid->size) {
-
 		skb = tid->reorder_buf[idx];
 		if (!skb)
 			continue;
 
 		nframes--;
-		status = (struct mt76_rx_status *) skb->cb;
+		status = (struct mt76_rx_status *)skb->cb;
 		if (!time_after(jiffies, status->reorder_time +
-					 REORDER_TIMEOUT))
+				REORDER_TIMEOUT))
 			continue;
 
 		mt76_rx_aggr_release_frames(tid, frames, status->seqno);
@@ -122,8 +122,8 @@ mt76_rx_aggr_reorder_work(struct work_struct *work)
 static void
 mt76_rx_aggr_check_ctl(struct sk_buff *skb, struct sk_buff_head *frames)
 {
-	struct mt76_rx_status *status = (struct mt76_rx_status *) skb->cb;
-	struct ieee80211_bar *bar = (struct ieee80211_bar *) skb->data;
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct ieee80211_bar *bar = (struct ieee80211_bar *)skb->data;
 	struct mt76_wcid *wcid = status->wcid;
 	struct mt76_rx_tid *tid;
 	u16 seqno;
@@ -148,8 +148,8 @@ mt76_rx_aggr_check_ctl(struct sk_buff *skb, struct sk_buff_head *frames)
 
 void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames)
 {
-	struct mt76_rx_status *status = (struct mt76_rx_status *) skb->cb;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct mt76_wcid *wcid = status->wcid;
 	struct ieee80211_sta *sta;
 	struct mt76_rx_tid *tid;
@@ -233,7 +233,8 @@ void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames)
 	tid->nframes++;
 	mt76_rx_aggr_release_head(tid, frames);
 
-	ieee80211_queue_delayed_work(tid->dev->hw, &tid->reorder_work, REORDER_TIMEOUT);
+	ieee80211_queue_delayed_work(tid->dev->hw, &tid->reorder_work,
+				     REORDER_TIMEOUT);
 
 out:
 	spin_unlock_bh(&tid->lock);
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index d8f61e540bfd..bb223faa740f 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -504,7 +504,7 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 		skb_reserve(skb, q->buf_offset);
 
 		if (q == &dev->q_rx[MT_RXQ_MCU]) {
-			u32 *rxfce = (u32 *) skb->cb;
+			u32 *rxfce = (u32 *)skb->cb;
 			*rxfce = info;
 		}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index ec9efb79985f..20b8c0f9048e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -502,7 +502,7 @@ struct ieee80211_sta *mt76_rx_convert(struct sk_buff *skb)
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct mt76_rx_status mstat;
 
-	mstat = *((struct mt76_rx_status *) skb->cb);
+	mstat = *((struct mt76_rx_status *)skb->cb);
 	memset(status, 0, sizeof(*status));
 
 	status->flag = mstat.flag;
@@ -517,8 +517,10 @@ struct ieee80211_sta *mt76_rx_convert(struct sk_buff *skb)
 	status->chains = mstat.chains;
 
 	BUILD_BUG_ON(sizeof(mstat) > sizeof(skb->cb));
-	BUILD_BUG_ON(sizeof(status->chain_signal) != sizeof(mstat.chain_signal));
-	memcpy(status->chain_signal, mstat.chain_signal, sizeof(mstat.chain_signal));
+	BUILD_BUG_ON(sizeof(status->chain_signal) !=
+		     sizeof(mstat.chain_signal));
+	memcpy(status->chain_signal, mstat.chain_signal,
+	       sizeof(mstat.chain_signal));
 
 	return wcid_to_sta(mstat.wcid);
 }
@@ -527,7 +529,7 @@ EXPORT_SYMBOL(mt76_rx_convert);
 static int
 mt76_check_ccmp_pn(struct sk_buff *skb)
 {
-	struct mt76_rx_status *status = (struct mt76_rx_status *) skb->cb;
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct mt76_wcid *wcid = status->wcid;
 	struct ieee80211_hdr *hdr;
 	int ret;
@@ -543,7 +545,7 @@ mt76_check_ccmp_pn(struct sk_buff *skb)
 		 * Validate the first fragment both here and in mac80211
 		 * All further fragments will be validated by mac80211 only.
 		 */
-		hdr = (struct ieee80211_hdr *) skb->data;
+		hdr = (struct ieee80211_hdr *)skb->data;
 		if (ieee80211_is_frag(hdr) &&
 		    !ieee80211_is_first_frag(hdr->frame_control))
 			return 0;
@@ -566,8 +568,8 @@ mt76_check_ccmp_pn(struct sk_buff *skb)
 static void
 mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 {
-	struct mt76_rx_status *status = (struct mt76_rx_status *) skb->cb;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_sta *sta;
 	struct mt76_wcid *wcid = status->wcid;
 	bool ps;
@@ -576,13 +578,13 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 	if (ieee80211_is_pspoll(hdr->frame_control) && !wcid) {
 		sta = ieee80211_find_sta_by_ifaddr(dev->hw, hdr->addr2, NULL);
 		if (sta)
-			wcid = status->wcid = (struct mt76_wcid *) sta->drv_priv;
+			wcid = status->wcid = (struct mt76_wcid *)sta->drv_priv;
 	}
 
 	if (!wcid || !wcid->sta)
 		return;
 
-	sta = container_of((void *) wcid, struct ieee80211_sta, drv_priv);
+	sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
 
 	if (status->signal <= 0)
 		ewma_signal_add(&wcid->rssi, -status->signal);
@@ -598,8 +600,8 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 	}
 
 	if (ieee80211_has_morefrags(hdr->frame_control) ||
-		!(ieee80211_is_mgmt(hdr->frame_control) ||
-		  ieee80211_is_data(hdr->frame_control)))
+	    !(ieee80211_is_mgmt(hdr->frame_control) ||
+	    ieee80211_is_data(hdr->frame_control)))
 		return;
 
 	ps = ieee80211_has_pm(hdr->frame_control);
@@ -628,7 +630,7 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 		if (!sta->txq[i])
 			continue;
 
-		mtxq = (struct mt76_txq *) sta->txq[i]->drv_priv;
+		mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
 		if (!skb_queue_empty(&mtxq->retry_q))
 			ieee80211_schedule_txq(dev->hw, sta->txq[i]);
 	}
@@ -750,7 +752,7 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		dev->drv->sta_assoc(dev, vif, sta);
 
 	if (old_state == IEEE80211_STA_NONE &&
-		 new_state == IEEE80211_STA_NOTEXIST)
+	    new_state == IEEE80211_STA_NOTEXIST)
 		mt76_sta_remove(dev, vif, sta);
 
 	return 0;
@@ -790,7 +792,7 @@ static void
 __mt76_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	if (vif->csa_active && ieee80211_csa_is_complete(vif))
-	    ieee80211_csa_finish(vif);
+		ieee80211_csa_finish(vif);
 }
 
 void mt76_csa_finish(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 094e6e543542..376c944704c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -537,25 +537,25 @@ struct mt76_rx_status {
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
 };
 
-#define __mt76_rr(dev, ...)	(dev)->bus->rr((dev), __VA_ARGS__)
-#define __mt76_wr(dev, ...)	(dev)->bus->wr((dev), __VA_ARGS__)
-#define __mt76_rmw(dev, ...)	(dev)->bus->rmw((dev), __VA_ARGS__)
-#define __mt76_wr_copy(dev, ...)	(dev)->bus->copy((dev), __VA_ARGS__)
+#define __mt76_rr(dev, ...)	((dev)->bus->rr((dev), __VA_ARGS__))
+#define __mt76_wr(dev, ...)	((dev)->bus->wr((dev), __VA_ARGS__))
+#define __mt76_rmw(dev, ...)	((dev)->bus->rmw((dev), __VA_ARGS__))
+#define __mt76_wr_copy(dev, ...)	((dev)->bus->copy((dev), __VA_ARGS__))
 
 #define __mt76_set(dev, offset, val)	__mt76_rmw(dev, offset, 0, val)
 #define __mt76_clear(dev, offset, val)	__mt76_rmw(dev, offset, val, 0)
 
-#define mt76_rr(dev, ...)	(dev)->mt76.bus->rr(&((dev)->mt76), __VA_ARGS__)
-#define mt76_wr(dev, ...)	(dev)->mt76.bus->wr(&((dev)->mt76), __VA_ARGS__)
-#define mt76_rmw(dev, ...)	(dev)->mt76.bus->rmw(&((dev)->mt76), __VA_ARGS__)
-#define mt76_wr_copy(dev, ...)	(dev)->mt76.bus->copy(&((dev)->mt76), __VA_ARGS__)
-#define mt76_wr_rp(dev, ...)	(dev)->mt76.bus->wr_rp(&((dev)->mt76), __VA_ARGS__)
-#define mt76_rd_rp(dev, ...)	(dev)->mt76.bus->rd_rp(&((dev)->mt76), __VA_ARGS__)
+#define mt76_rr(dev, ...)	((dev)->mt76.bus->rr(&((dev)->mt76), __VA_ARGS__))
+#define mt76_wr(dev, ...)	((dev)->mt76.bus->wr(&((dev)->mt76), __VA_ARGS__))
+#define mt76_rmw(dev, ...)	((dev)->mt76.bus->rmw(&((dev)->mt76), __VA_ARGS__))
+#define mt76_wr_copy(dev, ...)	((dev)->mt76.bus->copy(&((dev)->mt76), __VA_ARGS__))
+#define mt76_wr_rp(dev, ...)	((dev)->mt76.bus->wr_rp(&((dev)->mt76), __VA_ARGS__))
+#define mt76_rd_rp(dev, ...)	((dev)->mt76.bus->rd_rp(&((dev)->mt76), __VA_ARGS__))
 
-#define mt76_mcu_send_msg(dev, ...)	(dev)->mt76.mcu_ops->mcu_send_msg(&((dev)->mt76), __VA_ARGS__)
-#define __mt76_mcu_send_msg(dev, ...)	(dev)->mcu_ops->mcu_send_msg((dev), __VA_ARGS__)
-#define mt76_mcu_restart(dev, ...)	(dev)->mt76.mcu_ops->mcu_restart(&((dev)->mt76))
-#define __mt76_mcu_restart(dev, ...)	(dev)->mcu_ops->mcu_restart((dev))
+#define mt76_mcu_send_msg(dev, ...)	((dev)->mt76.mcu_ops->mcu_send_msg(&((dev)->mt76), __VA_ARGS__))
+#define __mt76_mcu_send_msg(dev, ...)	((dev)->mcu_ops->mcu_send_msg((dev), __VA_ARGS__))
+#define mt76_mcu_restart(dev, ...)	((dev)->mt76.mcu_ops->mcu_restart(&((dev)->mt76)))
+#define __mt76_mcu_restart(dev, ...)	((dev)->mcu_ops->mcu_restart((dev)))
 
 #define mt76_set(dev, offset, val)	mt76_rmw(dev, offset, 0, val)
 #define mt76_clear(dev, offset, val)	mt76_rmw(dev, offset, val, 0)
@@ -569,7 +569,7 @@ struct mt76_rx_status {
 #define __mt76_rmw_field(_dev, _reg, _field, _val)	\
 	__mt76_rmw(_dev, _reg, _field, FIELD_PREP(_field, _val))
 
-#define mt76_hw(dev) (dev)->mt76.hw
+#define mt76_hw(dev) ((dev)->mt76.hw)
 
 bool __mt76_poll(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 		 int timeout);
@@ -596,13 +596,13 @@ static inline u16 mt76_rev(struct mt76_dev *dev)
 #define mt76xx_chip(dev) mt76_chip(&((dev)->mt76))
 #define mt76xx_rev(dev) mt76_rev(&((dev)->mt76))
 
-#define mt76_init_queues(dev)		(dev)->mt76.queue_ops->init(&((dev)->mt76))
-#define mt76_queue_alloc(dev, ...)	(dev)->mt76.queue_ops->alloc(&((dev)->mt76), __VA_ARGS__)
-#define mt76_tx_queue_skb_raw(dev, ...)	(dev)->mt76.queue_ops->tx_queue_skb_raw(&((dev)->mt76), __VA_ARGS__)
-#define mt76_tx_queue_skb(dev, ...)	(dev)->mt76.queue_ops->tx_queue_skb(&((dev)->mt76), __VA_ARGS__)
-#define mt76_queue_rx_reset(dev, ...)	(dev)->mt76.queue_ops->rx_reset(&((dev)->mt76), __VA_ARGS__)
-#define mt76_queue_tx_cleanup(dev, ...)	(dev)->mt76.queue_ops->tx_cleanup(&((dev)->mt76), __VA_ARGS__)
-#define mt76_queue_kick(dev, ...)	(dev)->mt76.queue_ops->kick(&((dev)->mt76), __VA_ARGS__)
+#define mt76_init_queues(dev)		((dev)->mt76.queue_ops->init(&((dev)->mt76)))
+#define mt76_queue_alloc(dev, ...)	((dev)->mt76.queue_ops->alloc(&((dev)->mt76), __VA_ARGS__))
+#define mt76_tx_queue_skb_raw(dev, ...)	((dev)->mt76.queue_ops->tx_queue_skb_raw(&((dev)->mt76), __VA_ARGS__))
+#define mt76_tx_queue_skb(dev, ...)	((dev)->mt76.queue_ops->tx_queue_skb(&((dev)->mt76), __VA_ARGS__))
+#define mt76_queue_rx_reset(dev, ...)	((dev)->mt76.queue_ops->rx_reset(&((dev)->mt76), __VA_ARGS__))
+#define mt76_queue_tx_cleanup(dev, ...)	((dev)->mt76.queue_ops->tx_cleanup(&((dev)->mt76), __VA_ARGS__))
+#define mt76_queue_kick(dev, ...)	((dev)->mt76.queue_ops->kick(&((dev)->mt76), __VA_ARGS__))
 
 static inline struct mt76_channel_state *
 mt76_channel_state(struct mt76_dev *dev, struct ieee80211_channel *c)
@@ -677,7 +677,7 @@ static inline struct mt76_tx_cb *mt76_tx_skb_cb(struct sk_buff *skb)
 {
 	BUILD_BUG_ON(sizeof(struct mt76_tx_cb) >
 		     sizeof(IEEE80211_SKB_CB(skb)->status.status_driver_data));
-	return ((void *) IEEE80211_SKB_CB(skb)->status.status_driver_data);
+	return ((void *)IEEE80211_SKB_CB(skb)->status.status_driver_data);
 }
 
 static inline void mt76_insert_hdr_pad(struct sk_buff *skb)
diff --git a/drivers/net/wireless/mediatek/mt76/trace.h b/drivers/net/wireless/mediatek/mt76/trace.h
index ea30895933c5..06fc21a43a1f 100644
--- a/drivers/net/wireless/mediatek/mt76/trace.h
+++ b/drivers/net/wireless/mediatek/mt76/trace.h
@@ -24,10 +24,11 @@
 #define TRACE_SYSTEM mt76
 
 #define MAXNAME		32
-#define DEV_ENTRY   __array(char, wiphy_name, 32)
-#define DEV_ASSIGN  strlcpy(__entry->wiphy_name, wiphy_name(dev->hw->wiphy), MAXNAME)
-#define DEV_PR_FMT  "%s"
-#define DEV_PR_ARG  __entry->wiphy_name
+#define DEV_ENTRY	__array(char, wiphy_name, 32)
+#define DEV_ASSIGN	strlcpy(__entry->wiphy_name,	\
+				wiphy_name(dev->hw->wiphy), MAXNAME)
+#define DEV_PR_FMT	"%s"
+#define DEV_PR_ARG	__entry->wiphy_name
 
 #define REG_ENTRY	__field(u32, reg) __field(u32, val)
 #define REG_ASSIGN	__entry->reg = reg; __entry->val = val
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 5397827668b9..3b73f3b3f576 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -97,7 +97,7 @@ mt76_txq_get_qid(struct ieee80211_txq *txq)
 static void
 mt76_check_agg_ssn(struct mt76_txq *mtxq, struct sk_buff *skb)
 {
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 
 	if (!ieee80211_is_data_qos(hdr->frame_control) ||
 	    !ieee80211_is_data_present(hdr->frame_control))
@@ -217,8 +217,8 @@ mt76_tx_status_skb_get(struct mt76_dev *dev, struct mt76_wcid *wcid, int pktid,
 		if (cb->pktid == pktid)
 			return skb;
 
-		if (pktid >= 0 &&
-		    !time_after(jiffies, cb->jiffies + MT_TX_STATUS_SKB_TIMEOUT))
+		if (pktid >= 0 && !time_after(jiffies, cb->jiffies +
+					      MT_TX_STATUS_SKB_TIMEOUT))
 			continue;
 
 		__mt76_tx_status_skb_done(dev, skb, MT_TX_CB_TXS_FAILED |
@@ -260,7 +260,7 @@ mt76_tx(struct mt76_dev *dev, struct ieee80211_sta *sta,
 	struct mt76_wcid *wcid, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct mt76_queue *q;
 	int qid = skb_get_queue_mapping(skb);
 
@@ -280,7 +280,7 @@ mt76_tx(struct mt76_dev *dev, struct ieee80211_sta *sta,
 
 		tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
 		txq = sta->txq[tid];
-		mtxq = (struct mt76_txq *) txq->drv_priv;
+		mtxq = (struct mt76_txq *)txq->drv_priv;
 
 		if (mtxq->aggr)
 			mt76_check_agg_ssn(mtxq, skb);
@@ -328,7 +328,7 @@ static void
 mt76_queue_ps_skb(struct mt76_dev *dev, struct ieee80211_sta *sta,
 		  struct sk_buff *skb, bool last)
 {
-	struct mt76_wcid *wcid = (struct mt76_wcid *) sta->drv_priv;
+	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 
 	info->control.flags |= IEEE80211_TX_CTRL_PS_RESPONSE;
@@ -354,7 +354,7 @@ mt76_release_buffered_frames(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 	spin_lock_bh(&hwq->lock);
 	for (i = 0; tids && nframes; i++, tids >>= 1) {
 		struct ieee80211_txq *txq = sta->txq[i];
-		struct mt76_txq *mtxq = (struct mt76_txq *) txq->drv_priv;
+		struct mt76_txq *mtxq = (struct mt76_txq *)txq->drv_priv;
 		struct sk_buff *skb;
 
 		if (!(tids & 1))
@@ -610,7 +610,7 @@ void mt76_txq_remove(struct mt76_dev *dev, struct ieee80211_txq *txq)
 	if (!txq)
 		return;
 
-	mtxq = (struct mt76_txq *) txq->drv_priv;
+	mtxq = (struct mt76_txq *)txq->drv_priv;
 
 	while ((skb = skb_dequeue(&mtxq->retry_q)) != NULL)
 		ieee80211_free_txskb(dev->hw, skb);
@@ -619,7 +619,7 @@ EXPORT_SYMBOL_GPL(mt76_txq_remove);
 
 void mt76_txq_init(struct mt76_dev *dev, struct ieee80211_txq *txq)
 {
-	struct mt76_txq *mtxq = (struct mt76_txq *) txq->drv_priv;
+	struct mt76_txq *mtxq = (struct mt76_txq *)txq->drv_priv;
 
 	skb_queue_head_init(&mtxq->retry_q);
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 00069c2536f8..76fed459ae58 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -165,7 +165,7 @@ static void mt76u_copy(struct mt76_dev *dev, u32 offset,
 
 	mutex_lock(&usb->usb_ctrl_mtx);
 	for (i = 0; i < DIV_ROUND_UP(len, 4); i++) {
-		put_unaligned(val[i], (u32 *) usb->data);
+		put_unaligned(val[i], (u32 *)usb->data);
 		ret = __mt76u_vendor_request(dev, MT_VEND_MULTI_WRITE,
 					     USB_DIR_OUT | USB_TYPE_VENDOR,
 					     0, offset + i * 4, usb->data,
@@ -320,14 +320,13 @@ mt76u_refill_rx(struct mt76_dev *dev, struct urb *urb, int nsgs, gfp_t gfp)
 {
 	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
 
-	if (dev->usb.sg_en) {
+	if (dev->usb.sg_en)
 		return mt76u_fill_rx_sg(dev, q, urb, nsgs, gfp);
-	} else {
-		urb->transfer_buffer_length = q->buf_size;
-		urb->transfer_buffer = page_frag_alloc(&q->rx_page,
-						       q->buf_size, gfp);
-		return urb->transfer_buffer ? 0 : -ENOMEM;
-	}
+
+	urb->transfer_buffer_length = q->buf_size;
+	urb->transfer_buffer = page_frag_alloc(&q->rx_page, q->buf_size, gfp);
+
+	return urb->transfer_buffer ? 0 : -ENOMEM;
 }
 
 static int
@@ -735,13 +734,14 @@ mt76u_tx_setup_buffers(struct mt76_dev *dev, struct sk_buff *skb,
 	if (!dev->usb.sg_en) {
 		urb->transfer_buffer = skb->data;
 		return 0;
-	} else {
-		sg_init_table(urb->sg, MT_TX_SG_MAX_SIZE);
-		urb->num_sgs = skb_to_sgvec(skb, urb->sg, 0, skb->len);
-		if (urb->num_sgs == 0)
-			return -ENOMEM;
-		return urb->num_sgs;
 	}
+
+	sg_init_table(urb->sg, MT_TX_SG_MAX_SIZE);
+	urb->num_sgs = skb_to_sgvec(skb, urb->sg, 0, skb->len);
+	if (!urb->num_sgs)
+		return -ENOMEM;
+
+	return urb->num_sgs;
 }
 
 static int
@@ -857,7 +857,8 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 	struct mt76_queue *q;
 	int i, j, ret;
 
-	ret = wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(dev), HZ/5);
+	ret = wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(dev),
+				 HZ / 5);
 	if (!ret) {
 		dev_err(dev->dev, "timed out waiting for pending tx\n");
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb_trace.h b/drivers/net/wireless/mediatek/mt76/usb_trace.h
index b56c32343eb1..518ad1a26e21 100644
--- a/drivers/net/wireless/mediatek/mt76/usb_trace.h
+++ b/drivers/net/wireless/mediatek/mt76/usb_trace.h
@@ -24,10 +24,11 @@
 #define TRACE_SYSTEM mt76_usb
 
 #define MAXNAME		32
-#define DEV_ENTRY   __array(char, wiphy_name, 32)
-#define DEV_ASSIGN  strlcpy(__entry->wiphy_name, wiphy_name(dev->hw->wiphy), MAXNAME)
-#define DEV_PR_FMT  "%s "
-#define DEV_PR_ARG  __entry->wiphy_name
+#define DEV_ENTRY	__array(char, wiphy_name, 32)
+#define DEV_ASSIGN	strlcpy(__entry->wiphy_name,	\
+				wiphy_name(dev->hw->wiphy), MAXNAME)
+#define DEV_PR_FMT	"%s "
+#define DEV_PR_ARG	__entry->wiphy_name
 
 #define REG_ENTRY	__field(u32, reg) __field(u32, val)
 #define REG_ASSIGN	__entry->reg = reg; __entry->val = val
@@ -65,7 +66,7 @@ DECLARE_EVENT_CLASS(urb_transfer,
 	TP_PROTO(struct mt76_dev *dev, struct urb *u),
 	TP_ARGS(dev, u),
 	TP_STRUCT__entry(
-		DEV_ENTRY __field(unsigned, pipe) __field(u32, len)
+		DEV_ENTRY __field(unsigned int, pipe) __field(u32, len)
 	),
 	TP_fast_assign(
 		DEV_ASSIGN;
diff --git a/drivers/net/wireless/mediatek/mt76/util.h b/drivers/net/wireless/mediatek/mt76/util.h
index 9f8d59269a9e..fe3479c8e561 100644
--- a/drivers/net/wireless/mediatek/mt76/util.h
+++ b/drivers/net/wireless/mediatek/mt76/util.h
@@ -12,7 +12,7 @@
 #include <linux/bitfield.h>
 
 #define MT76_INCR(_var, _size) \
-	_var = (((_var) + 1) % _size)
+	(_var = (((_var) + 1) % (_size)))
 
 int mt76_wcid_alloc(unsigned long *mask, int size);
 
@@ -25,7 +25,7 @@ mt76_wcid_free(unsigned long *mask, int idx)
 static inline void
 mt76_skb_set_moredata(struct sk_buff *skb, bool enable)
 {
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 
 	if (enable)
 		hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_MOREDATA);
-- 
2.18.0

