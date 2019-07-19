Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B94516E140
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2019 08:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfGSGz5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jul 2019 02:55:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47327 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726076AbfGSGz5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jul 2019 02:55:57 -0400
X-UUID: f603fa9736c74486b4da99549f4e1cca-20190719
X-UUID: f603fa9736c74486b4da99549f4e1cca-20190719
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1192192810; Fri, 19 Jul 2019 14:55:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 19 Jul 2019 14:55:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 19 Jul 2019 14:55:37 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/3] mt76: fix checkpatch warnings and errors
Date:   Fri, 19 Jul 2019 14:55:34 +0800
Message-ID: <50d28c9b0f9e7d6b277d36fc93f55142d7535259.1563518381.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix warnings and errors as much as possible.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/agg-rx.c   | 21 +++++----
 drivers/net/wireless/mediatek/mt76/dma.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c | 30 ++++++------
 drivers/net/wireless/mediatek/mt76/mt76.h     | 46 +++++++++----------
 .../wireless/mediatek/mt76/mt7603/beacon.c    |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/core.c  |  2 +-
 .../wireless/mediatek/mt76/mt7603/debugfs.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/dma.c   |  7 +--
 .../wireless/mediatek/mt76/mt7603/eeprom.c    |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/init.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  6 +--
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  7 +--
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/pci.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/soc.c   |  2 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  5 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 -
 .../wireless/mediatek/mt76/mt76x0/mt76x0.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt76x0/phy.c   | 23 ++++++----
 .../net/wireless/mediatek/mt76/mt76x0/phy.h   | 10 ++--
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  6 +--
 drivers/net/wireless/mediatek/mt76/mt76x02.h  | 24 +++++-----
 .../wireless/mediatek/mt76/mt76x02_beacon.c   |  3 +-
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  | 16 +++----
 .../net/wireless/mediatek/mt76/mt76x02_mcu.c  | 13 +++---
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 11 +++--
 .../net/wireless/mediatek/mt76/mt76x02_phy.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt76x02_regs.h | 18 ++++----
 .../wireless/mediatek/mt76/mt76x02_trace.h    |  3 +-
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c | 20 ++++----
 .../wireless/mediatek/mt76/mt76x2/eeprom.c    | 10 ++--
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  |  1 -
 .../wireless/mediatek/mt76/mt76x2/pci_mcu.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt76x2/phy.c   |  3 +-
 drivers/net/wireless/mediatek/mt76/trace.h    |  9 ++--
 drivers/net/wireless/mediatek/mt76/tx.c       | 14 +++---
 drivers/net/wireless/mediatek/mt76/usb.c      | 31 +++++++------
 .../net/wireless/mediatek/mt76/usb_trace.h    | 11 +++--
 drivers/net/wireless/mediatek/mt76/util.h     |  4 +-
 41 files changed, 201 insertions(+), 185 deletions(-)

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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
index 58e68fbdbf75..7a41cdf1c4ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include "mt7603.h"
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/core.c b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
index e7ee58e3379c..e5af4f3389cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include "mt7603.h"
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
index a1bc3103cbe9..5942fe76c6e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include "mt7603.h"
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 58dc511f93c5..79dc3b97dfe8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include "mt7603.h"
 #include "mac.h"
@@ -63,7 +63,7 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 	txd[0] = cpu_to_le32(val);
 
 	sta = container_of(priv, struct ieee80211_sta, drv_priv);
-	hdr = (struct ieee80211_hdr *) &skb->data[MT_TXD_SIZE];
+	hdr = (struct ieee80211_hdr *)&skb->data[MT_TXD_SIZE];
 	tid = *ieee80211_get_qos_ctl(hdr) & IEEE80211_QOS_CTL_TID_MASK;
 	ieee80211_sta_set_buffered(sta, tid, true);
 
@@ -181,7 +181,8 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 	init_waitqueue_head(&dev->mt76.mmio.mcu.wait);
 	skb_queue_head_init(&dev->mt76.mmio.mcu.res_q);
 
-	tasklet_init(&dev->mt76.tx_tasklet, mt7603_tx_tasklet, (unsigned long)dev);
+	tasklet_init(&dev->mt76.tx_tasklet, mt7603_tx_tasklet,
+		     (unsigned long)dev);
 
 	mt76_clear(dev, MT_WPDMA_GLO_CFG,
 		   MT_WPDMA_GLO_CFG_TX_DMA_EN |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
index 8c120e4461b0..2b6a4d8a8dc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include "mt7603.h"
 #include "eeprom.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 568e57e1d69c..ad2ccdbe7258 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include <linux/etherdevice.h>
 #include "mt7603.h"
@@ -506,7 +506,6 @@ mt7603_init_txpower(struct mt7603_dev *dev,
 	}
 }
 
-
 int mt7603_register_device(struct mt7603_dev *dev)
 {
 	struct mt76_bus_ops *bus_ops;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 81fb4276e742..a532676a1175 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include <linux/etherdevice.h>
 #include <linux/timekeeping.h>
@@ -644,7 +644,6 @@ void mt7603_wtbl_set_rates(struct mt7603_dev *dev, struct mt7603_sta *sta,
 
 			rates[i].idx--;
 		}
-
 	}
 
 	w9 &= MT_WTBL2_W9_SHORT_GI_20 | MT_WTBL2_W9_SHORT_GI_40 |
@@ -1017,8 +1016,9 @@ mt7603_fill_txs(struct mt7603_dev *dev, struct mt7603_sta *sta,
 			sta->rate_probe = false;
 		}
 		spin_unlock_bh(&dev->mt76.lock);
-	} else
+	} else {
 		info->status.rates[0] = rs->rates[first_idx / 2];
+	}
 	info->status.rates[0].count = 0;
 
 	for (i = 0, idx = first_idx; count && idx <= last_idx; idx++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index d70f42dac923..34dd05a36de9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include <linux/etherdevice.h>
 #include <linux/platform_device.h>
@@ -399,7 +399,7 @@ mt7603_ps_set_more_data(struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr;
 
-	hdr = (struct ieee80211_hdr *) &skb->data[MT_TXD_SIZE];
+	hdr = (struct ieee80211_hdr *)&skb->data[MT_TXD_SIZE];
 	hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_MOREDATA);
 }
 
@@ -647,7 +647,8 @@ mt7603_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 	mt7603_mac_set_timing(dev);
 }
 
-static void mt7603_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
+static void mt7603_tx(struct ieee80211_hw *hw,
+		      struct ieee80211_tx_control *control,
 		      struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index 343ddc5543c2..02b2bd60d04d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include <linux/firmware.h>
 #include "mt7603.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/pci.c b/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
index 4acdbf5d8968..2f2f337e2201 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
index b920be1f5718..b7138485844a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index ed605fcc99f9..2618248946a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+// SPDX-License-Identifier: ISC
 
 #include "mt7615.h"
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index b3e8ee06a783..8f9a2bb68ded 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -508,7 +508,6 @@ void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 
 			rates[i].idx--;
 		}
-
 	}
 
 	val[0] = mt7615_mac_tx_rate_val(dev, &rates[0], stbc, &bw);
@@ -586,6 +585,7 @@ void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 	sta->rate_count = 2 * MT7615_RATE_RETRY * n_rates;
 	sta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 }
+
 int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
@@ -725,8 +725,9 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 			sta->rate_probe = false;
 		}
 		spin_unlock_bh(&dev->mt76.lock);
-	} else
+	} else {
 		info->status.rates[0] = rs->rates[first_idx / 2];
+	}
 	info->status.rates[0].count = 0;
 
 	for (i = 0, idx = first_idx; count && idx <= last_idx; idx++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index e57b51290c61..5fd162be3654 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1646,5 +1646,3 @@ int mt7615_mcu_set_rx_ba(struct mt7615_dev *dev,
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE,
 				   &wtbl_req, sizeof(wtbl_req), true);
 }
-
-
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
index 97e47cd2d744..caa87f0c3cb8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
@@ -55,7 +55,7 @@ int mt76x0_config(struct ieee80211_hw *hw, u32 changed);
 void mt76x0_phy_init(struct mt76x02_dev *dev);
 int mt76x0_phy_wait_bbp_ready(struct mt76x02_dev *dev);
 int mt76x0_phy_set_channel(struct mt76x02_dev *dev,
-			    struct cfg80211_chan_def *chandef);
+			   struct cfg80211_chan_def *chandef);
 void mt76x0_phy_set_txpower(struct mt76x02_dev *dev);
 void mt76x0_phy_calibrate(struct mt76x02_dev *dev, bool power_on);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index 1ecfc334ae79..bfcef33cd4c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -109,7 +109,7 @@ mt76x0_rf_wr(struct mt76x02_dev *dev, u32 offset, u8 val)
 		};
 
 		WARN_ON_ONCE(!test_bit(MT76_STATE_MCU_RUNNING,
-			     &dev->mt76.state));
+				       &dev->mt76.state));
 		return mt76_wr_rp(dev, MT_MCU_MEMMAP_RF, &pair, 1);
 	} else {
 		return mt76x0_rf_csr_wr(dev, offset, val);
@@ -127,7 +127,7 @@ static int mt76x0_rf_rr(struct mt76x02_dev *dev, u32 offset)
 		};
 
 		WARN_ON_ONCE(!test_bit(MT76_STATE_MCU_RUNNING,
-			     &dev->mt76.state));
+				       &dev->mt76.state));
 		ret = mt76_rd_rp(dev, MT_MCU_MEMMAP_RF, &pair, 1);
 		val = pair.value;
 	} else {
@@ -230,7 +230,8 @@ mt76x0_phy_set_band(struct mt76x02_dev *dev, enum nl80211_band band)
 }
 
 static void
-mt76x0_phy_set_chan_rf_params(struct mt76x02_dev *dev, u8 channel, u16 rf_bw_band)
+mt76x0_phy_set_chan_rf_params(struct mt76x02_dev *dev, u8 channel,
+			      u16 rf_bw_band)
 {
 	const struct mt76x0_freq_item *freq_item;
 	u16 rf_band = rf_bw_band & 0xff00;
@@ -252,9 +253,9 @@ mt76x0_phy_set_chan_rf_params(struct mt76x02_dev *dev, u8 channel, u16 rf_bw_ban
 			rf_band = mt76x0_frequency_plan[i].band;
 
 			if (b_sdm)
-				freq_item = &(mt76x0_sdm_frequency_plan[i]);
+				freq_item = &mt76x0_sdm_frequency_plan[i];
 			else
-				freq_item = &(mt76x0_frequency_plan[i]);
+				freq_item = &mt76x0_frequency_plan[i];
 
 			mt76x0_rf_wr(dev, MT_RF(0, 37), freq_item->pllR37);
 			mt76x0_rf_wr(dev, MT_RF(0, 36), freq_item->pllR36);
@@ -360,10 +361,12 @@ mt76x0_phy_set_chan_rf_params(struct mt76x02_dev *dev, u8 channel, u16 rf_bw_ban
 	band = (rf_band & RF_G_BAND) ? NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
 	if (mt76x02_ext_pa_enabled(dev, band)) {
 		/*
-			MT_RF_MISC (offset: 0x0518)
-			[2]1'b1: enable external A band PA, 1'b0: disable external A band PA
-			[3]1'b1: enable external G band PA, 1'b0: disable external G band PA
-		*/
+		 * MT_RF_MISC (offset: 0x0518)
+		 * [2]1'b1: enable external A band PA,
+		 *    1'b0: disable external A band PA
+		 * [3]1'b1: enable external G band PA,
+		 *    1'b0: disable external G band PA
+		 */
 		if (rf_band & RF_A_BAND)
 			mt76_set(dev, MT_RF_MISC, BIT(2));
 		else
@@ -490,7 +493,7 @@ mt76x0_phy_bbp_set_bw(struct mt76x02_dev *dev, enum nl80211_chan_width width)
 	case NL80211_CHAN_WIDTH_160:
 	case NL80211_CHAN_WIDTH_5:
 		/* TODO error */
-		return ;
+		return;
 	}
 
 	mt76x02_mcu_function_select(dev, BW_SETTING, bw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.h b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.h
index b4b2ca747699..441d6559d4fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.h
@@ -6,8 +6,8 @@
 #ifndef _MT76X0_PHY_H_
 #define _MT76X0_PHY_H_
 
-#define RF_G_BAND 	0x0100
-#define RF_A_BAND 	0x0200
+#define RF_G_BAND	0x0100
+#define RF_A_BAND	0x0200
 #define RF_A_BAND_LB	0x0400
 #define RF_A_BAND_MB	0x0800
 #define RF_A_BAND_HB	0x1000
@@ -18,9 +18,9 @@
 #define RF_BW_10        4
 #define RF_BW_80        8
 
-#define MT_RF(bank, reg) ((bank) << 16 | (reg))
-#define MT_RF_BANK(offset) (offset >> 16)
-#define MT_RF_REG(offset) (offset & 0xff)
+#define MT_RF(bank, reg)		((bank) << 16 | (reg))
+#define MT_RF_BANK(offset)		((offset) >> 16)
+#define MT_RF_REG(offset)		((offset) & 0xff)
 
 #define MT_RF_VCO_BP_CLOSE_LOOP		BIT(3)
 #define MT_RF_VCO_BP_CLOSE_LOOP_MASK	GENMASK(3, 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index b007bcd2e999..f010df4fad37 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -237,7 +237,7 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 	if (ret)
 		goto err;
 
-	/* Disable the HW, otherwise MCU fail to initalize on hot reboot */
+	/* Disable the HW, otherwise MCU fail to initialize on hot reboot */
 	mt76x0_chip_onoff(dev, false, false);
 
 	if (!mt76x02_wait_for_mac(mdev)) {
@@ -275,9 +275,9 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 static void mt76x0_disconnect(struct usb_interface *usb_intf)
 {
 	struct mt76x02_dev *dev = usb_get_intfdata(usb_intf);
-	bool initalized = test_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
+	bool initialized = test_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
 
-	if (!initalized)
+	if (!initialized)
 		return;
 
 	ieee80211_unregister_hw(dev->mt76.hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index f7fd53a1738a..f1a35126afed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -71,8 +71,8 @@ struct mt76x02_calibration {
 struct mt76x02_beacon_ops {
 	unsigned int nslots;
 	unsigned int slot_size;
-	void (*pre_tbtt_enable) (struct mt76x02_dev *, bool);
-	void (*beacon_enable) (struct mt76x02_dev *, bool);
+	void (*pre_tbtt_enable)(struct mt76x02_dev *dev, bool en);
+	void (*beacon_enable)(struct mt76x02_dev *dev, bool en);
 };
 
 struct mt76x02_dev {
@@ -137,8 +137,8 @@ extern struct ieee80211_rate mt76x02_rates[12];
 
 void mt76x02_init_device(struct mt76x02_dev *dev);
 void mt76x02_configure_filter(struct ieee80211_hw *hw,
-			     unsigned int changed_flags,
-			     unsigned int *total_flags, u64 multicast);
+			      unsigned int changed_flags,
+			      unsigned int *total_flags, u64 multicast);
 int mt76x02_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		    struct ieee80211_sta *sta);
 void mt76x02_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
@@ -147,20 +147,20 @@ void mt76x02_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 void mt76x02_config_mac_addr_list(struct mt76x02_dev *dev);
 
 int mt76x02_add_interface(struct ieee80211_hw *hw,
-			 struct ieee80211_vif *vif);
+			  struct ieee80211_vif *vif);
 void mt76x02_remove_interface(struct ieee80211_hw *hw,
-			     struct ieee80211_vif *vif);
+			      struct ieee80211_vif *vif);
 
 int mt76x02_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			struct ieee80211_ampdu_params *params);
+			 struct ieee80211_ampdu_params *params);
 int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
-		   struct ieee80211_vif *vif, struct ieee80211_sta *sta,
-		   struct ieee80211_key_conf *key);
+		    struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+		    struct ieee80211_key_conf *key);
 int mt76x02_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		   u16 queue, const struct ieee80211_tx_queue_params *params);
+		    u16 queue, const struct ieee80211_tx_queue_params *params);
 void mt76x02_sta_rate_tbl_update(struct ieee80211_hw *hw,
-				struct ieee80211_vif *vif,
-				struct ieee80211_sta *sta);
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta);
 s8 mt76x02_tx_get_max_txpwr_adj(struct mt76x02_dev *dev,
 				const struct ieee80211_tx_rate *rate);
 s8 mt76x02_tx_get_txpwr_adj(struct mt76x02_dev *dev, s8 txpwr,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index d61c686e08de..0d9ea358f64a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -237,7 +237,8 @@ mt76x02_add_buffered_bc(void *priv, u8 *mac, struct ieee80211_vif *vif)
 }
 
 void
-mt76x02_enqueue_buffered_bc(struct mt76x02_dev *dev, struct beacon_bc_data *data,
+mt76x02_enqueue_buffered_bc(struct mt76x02_dev *dev,
+			    struct beacon_bc_data *data,
 			    int max_nframes)
 {
 	int i, nframes;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 82bafb5ac326..a3917d0a5120 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -92,7 +92,6 @@ void mt76x02_mac_wcid_sync_pn(struct mt76x02_dev *dev, u8 idx,
 	atomic64_set(&key->tx_pn, pn);
 }
 
-
 int mt76x02_mac_wcid_set_key(struct mt76x02_dev *dev, u8 idx,
 			     struct ieee80211_key_conf *key)
 {
@@ -267,7 +266,7 @@ bool mt76x02_mac_load_tx_status(struct mt76x02_dev *dev,
 
 static int
 mt76x02_mac_process_tx_rate(struct ieee80211_tx_rate *txrate, u16 rate,
-			   enum nl80211_band band)
+			    enum nl80211_band band)
 {
 	u8 idx = FIELD_GET(MT_RXWI_RATE_INDEX, rate);
 
@@ -343,7 +342,7 @@ void mt76x02_mac_write_txwi(struct mt76x02_dev *dev, struct mt76x02_txwi *txwi,
 	    ieee80211_has_protected(hdr->frame_control)) {
 		wcid = NULL;
 		ieee80211_get_tx_rates(info->control.vif, sta, skb,
-		                       info->control.rates, 1);
+				       info->control.rates, 1);
 	}
 
 	if (wcid)
@@ -353,6 +352,7 @@ void mt76x02_mac_write_txwi(struct mt76x02_dev *dev, struct mt76x02_txwi *txwi,
 
 	if (wcid && wcid->sw_iv && key) {
 		u64 pn = atomic64_inc_return(&key->tx_pn);
+
 		ccmp_pn[0] = pn;
 		ccmp_pn[1] = pn >> 8;
 		ccmp_pn[2] = 0;
@@ -445,8 +445,8 @@ mt76x02_tx_rate_fallback(struct ieee80211_tx_rate *rates, int idx, int phy)
 	case MT_PHY_TYPE_HT:
 		/* MCS 8 falls back to MCS 0 */
 		if (rates[0].idx == 8) {
-		    rates[1].idx = 0;
-		    break;
+			rates[1].idx = 0;
+			break;
 		}
 		/* fall through */
 	default:
@@ -568,9 +568,9 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 		u32 stat_val, stat_cache;
 
 		stat_val = stat->rate;
-		stat_val |= ((u32) stat->retry) << 16;
+		stat_val |= ((u32)stat->retry) << 16;
 		stat_cache = msta->status.rate;
-		stat_cache |= ((u32) msta->status.retry) << 16;
+		stat_cache |= ((u32)msta->status.retry) << 16;
 
 		if (*update == 0 && stat_val == stat_cache &&
 		    stat->wcid == msta->status.wcid && msta->n_frames < 32) {
@@ -718,7 +718,7 @@ mt76x02_mac_get_rssi(struct mt76x02_dev *dev, s8 rssi, int chain)
 int mt76x02_mac_process_rx(struct mt76x02_dev *dev, struct sk_buff *skb,
 			   void *rxi)
 {
-	struct mt76_rx_status *status = (struct mt76_rx_status *) skb->cb;
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct mt76x02_rxwi *rxwi = rxi;
 	struct mt76x02_sta *sta;
 	u32 rxinfo = le32_to_cpu(rxwi->rxinfo);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
index 6501b853b65c..c1fd28dc9244 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
@@ -65,7 +65,7 @@ int mt76x02_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 			break;
 		}
 
-		rxfce = (u32 *) skb->cb;
+		rxfce = (u32 *)skb->cb;
 
 		if (seq == FIELD_GET(MT_RX_FCE_INFO_CMD_SEQ, *rxfce))
 			check_seq = true;
@@ -86,11 +86,11 @@ int mt76x02_mcu_function_select(struct mt76x02_dev *dev, enum mcu_function func,
 				u32 val)
 {
 	struct {
-	    __le32 id;
-	    __le32 value;
+		__le32 id;
+		__le32 value;
 	} __packed __aligned(4) msg = {
-	    .id = cpu_to_le32(func),
-	    .value = cpu_to_le32(val),
+		.id = cpu_to_le32(func),
+		.value = cpu_to_le32(val),
 	};
 	bool wait = false;
 
@@ -111,7 +111,8 @@ int mt76x02_mcu_set_radio_state(struct mt76x02_dev *dev, bool on)
 		.level = cpu_to_le32(0),
 	};
 
-	return mt76_mcu_send_msg(dev, CMD_POWER_SAVING_OP, &msg, sizeof(msg), false);
+	return mt76_mcu_send_msg(dev, CMD_POWER_SAVING_OP, &msg, sizeof(msg),
+				 false);
 }
 EXPORT_SYMBOL_GPL(mt76x02_mcu_set_radio_state);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 467b28379870..8bf93684febf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -97,7 +97,8 @@ void mt76x02e_init_beacon_config(struct mt76x02_dev *dev)
 	dev->beacon_ops = &beacon_ops;
 
 	/* Fire a pre-TBTT interrupt 8 ms before TBTT */
-	mt76_rmw_field(dev, MT_INT_TIMER_CFG, MT_INT_TIMER_CFG_PRE_TBTT, 8 << 4);
+	mt76_rmw_field(dev, MT_INT_TIMER_CFG, MT_INT_TIMER_CFG_PRE_TBTT,
+		       8 << 4);
 	mt76_rmw_field(dev, MT_INT_TIMER_CFG, MT_INT_TIMER_CFG_GP_TIMER,
 		       MT_DFS_GP_INTERVAL);
 	mt76_wr(dev, MT_INT_TIMER_EN, 0);
@@ -201,7 +202,7 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 		return -ENOMEM;
 
 	tasklet_init(&dev->mt76.tx_tasklet, mt76x02_tx_tasklet,
-		     (unsigned long) dev);
+		     (unsigned long)dev);
 	tasklet_init(&dev->mt76.pre_tbtt_tasklet, mt76x02_pre_tbtt_tasklet,
 		     (unsigned long)dev);
 
@@ -395,12 +396,12 @@ static void mt76x02_key_sync(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76_wcid *wcid;
 
 	if (!sta)
-	    return;
+		return;
 
-	wcid = (struct mt76_wcid *) sta->drv_priv;
+	wcid = (struct mt76_wcid *)sta->drv_priv;
 
 	if (wcid->hw_key_idx != key->keyidx || wcid->sw_iv)
-	    return;
+		return;
 
 	mt76x02_mac_wcid_sync_pn(dev, wcid->idx, key);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
index a54b63a96eae..b86a33b2a16d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
@@ -183,7 +183,8 @@ bool mt76x02_phy_adjust_vga_gain(struct mt76x02_dev *dev)
 	bool ret = false;
 	u32 false_cca;
 
-	false_cca = FIELD_GET(MT_RX_STAT_1_CCA_ERRORS, mt76_rr(dev, MT_RX_STAT_1));
+	false_cca = FIELD_GET(MT_RX_STAT_1_CCA_ERRORS,
+			      mt76_rr(dev, MT_RX_STAT_1));
 	dev->cal.false_cca = false_cca;
 	if (false_cca > 800 && dev->cal.agc_gain_adjust < limit) {
 		dev->cal.agc_gain_adjust += 2;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h b/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
index ea7833964ec0..eb411975fb45 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
@@ -120,7 +120,7 @@
 #define MT_INT_RX_DONE(_n)		BIT(_n)
 #define MT_INT_RX_DONE_ALL		GENMASK(1, 0)
 #define MT_INT_TX_DONE_ALL		GENMASK(13, 4)
-#define MT_INT_TX_DONE(_n)		BIT(_n + 4)
+#define MT_INT_TX_DONE(_n)		BIT((_n) + 4)
 #define MT_INT_RX_COHERENT		BIT(16)
 #define MT_INT_TX_COHERENT		BIT(17)
 #define MT_INT_ANY_COHERENT		BIT(18)
@@ -163,7 +163,7 @@
 
 #define MT_WMM_TXOP_BASE		0x0220
 #define MT_WMM_TXOP(_n)			(MT_WMM_TXOP_BASE + (((_n) / 2) << 2))
-#define MT_WMM_TXOP_SHIFT(_n)		((_n & 1) * 16)
+#define MT_WMM_TXOP_SHIFT(_n)		(((_n) & 1) * 16)
 #define MT_WMM_TXOP_MASK		GENMASK(15, 0)
 
 #define MT_WMM_CTRL			0x0230 /* MT76x0 */
@@ -607,7 +607,7 @@
 
 #define MT_TX_AGG_CNT(_id)		((_id) < 8 ?			\
 					 MT_TX_AGG_CNT_BASE0 + ((_id) << 2) : \
-					 MT_TX_AGG_CNT_BASE1 + ((_id - 8) << 2))
+					 MT_TX_AGG_CNT_BASE1 + (((_id) - 8) << 2))
 
 #define MT_TX_STAT_FIFO_EXT		0x1798
 #define MT_TX_STAT_FIFO_EXT_RETRY	GENMASK(7, 0)
@@ -680,17 +680,17 @@
 
 #define MT_SKEY_BASE_0			0xac00
 #define MT_SKEY_BASE_1			0xb400
-#define MT_SKEY_0(_bss, _idx)		(MT_SKEY_BASE_0 + (4 * (_bss) + _idx) * 32)
-#define MT_SKEY_1(_bss, _idx)		(MT_SKEY_BASE_1 + (4 * ((_bss) & 7) + _idx) * 32)
-#define MT_SKEY(_bss, _idx)		((_bss & 8) ? MT_SKEY_1(_bss, _idx) : MT_SKEY_0(_bss, _idx))
+#define MT_SKEY_0(_bss, _idx)		(MT_SKEY_BASE_0 + (4 * (_bss) + (_idx)) * 32)
+#define MT_SKEY_1(_bss, _idx)		(MT_SKEY_BASE_1 + (4 * ((_bss) & 7) + (_idx)) * 32)
+#define MT_SKEY(_bss, _idx)		(((_bss) & 8) ? MT_SKEY_1(_bss, _idx) : MT_SKEY_0(_bss, _idx))
 
 #define MT_SKEY_MODE_BASE_0		0xb000
 #define MT_SKEY_MODE_BASE_1		0xb3f0
-#define MT_SKEY_MODE_0(_bss)		(MT_SKEY_MODE_BASE_0 + ((_bss / 2) << 2))
+#define MT_SKEY_MODE_0(_bss)		(MT_SKEY_MODE_BASE_0 + (((_bss) / 2) << 2))
 #define MT_SKEY_MODE_1(_bss)		(MT_SKEY_MODE_BASE_1 + ((((_bss) & 7) / 2) << 2))
-#define MT_SKEY_MODE(_bss)		((_bss & 8) ? MT_SKEY_MODE_1(_bss) : MT_SKEY_MODE_0(_bss))
+#define MT_SKEY_MODE(_bss)		(((_bss) & 8) ? MT_SKEY_MODE_1(_bss) : MT_SKEY_MODE_0(_bss))
 #define MT_SKEY_MODE_MASK		GENMASK(3, 0)
-#define MT_SKEY_MODE_SHIFT(_bss, _idx)	(4 * ((_idx) + 4 * (_bss & 1)))
+#define MT_SKEY_MODE_SHIFT(_bss, _idx)	(4 * ((_idx) + 4 * ((_bss) & 1)))
 
 #define MT_BEACON_BASE			0xc000
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h b/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
index 713f12d3c8de..ae884f539f3f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
@@ -25,7 +25,8 @@
 
 #define MAXNAME		32
 #define DEV_ENTRY	__array(char, wiphy_name, 32)
-#define DEV_ASSIGN	strlcpy(__entry->wiphy_name, wiphy_name(mt76_hw(dev)->wiphy), MAXNAME)
+#define DEV_ASSIGN	strlcpy(__entry->wiphy_name,	\
+				wiphy_name(mt76_hw(dev)->wiphy), MAXNAME)
 #define DEV_PR_FMT	"%s"
 #define DEV_PR_ARG	__entry->wiphy_name
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 5e4f3a8c5784..e4332d5a5757 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -53,7 +53,7 @@ int mt76x02u_skb_dma_info(struct sk_buff *skb, int port, u32 flags)
 	pad = round_up(skb->len, 4) + 4 - skb->len;
 
 	/* First packet of a A-MSDU burst keeps track of the whole burst
-	 * length, need to update lenght of it and the last packet.
+	 * length, need to update length of it and the last packet.
 	 */
 	skb_walk_frags(skb, iter) {
 		last = iter;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index fa45ed280ab1..e84006cd6f9a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -21,14 +21,14 @@
 #define CCK_RATE(_idx, _rate) {					\
 	.bitrate = _rate,					\
 	.flags = IEEE80211_RATE_SHORT_PREAMBLE,			\
-	.hw_value = (MT_PHY_TYPE_CCK << 8) | _idx,		\
-	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (8 + _idx),	\
+	.hw_value = (MT_PHY_TYPE_CCK << 8) | (_idx),		\
+	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (8 + (_idx)),	\
 }
 
 #define OFDM_RATE(_idx, _rate) {				\
 	.bitrate = _rate,					\
-	.hw_value = (MT_PHY_TYPE_OFDM << 8) | _idx,		\
-	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | _idx,	\
+	.hw_value = (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
+	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | (_idx),	\
 }
 
 struct ieee80211_rate mt76x02_rates[] = {
@@ -281,7 +281,7 @@ mt76x02_vif_init(struct mt76x02_dev *dev, struct ieee80211_vif *vif,
 	mvif->idx = idx;
 	mvif->group_wcid.idx = MT_VIF_WCID(idx);
 	mvif->group_wcid.hw_key_idx = -1;
-	mtxq = (struct mt76_txq *) vif->txq->drv_priv;
+	mtxq = (struct mt76_txq *)vif->txq->drv_priv;
 	mtxq->wcid = &mvif->group_wcid;
 
 	mt76_txq_init(&dev->mt76, vif->txq);
@@ -345,7 +345,7 @@ int mt76x02_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	enum ieee80211_ampdu_mlme_action action = params->action;
 	struct ieee80211_sta *sta = params->sta;
 	struct mt76x02_dev *dev = hw->priv;
-	struct mt76x02_sta *msta = (struct mt76x02_sta *) sta->drv_priv;
+	struct mt76x02_sta *msta = (struct mt76x02_sta *)sta->drv_priv;
 	struct ieee80211_txq *txq = sta->txq[params->tid];
 	u16 tid = params->tid;
 	u16 ssn = params->ssn;
@@ -434,7 +434,7 @@ int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
 		return -EOPNOTSUPP;
 
-	msta = sta ? (struct mt76x02_sta *) sta->drv_priv : NULL;
+	msta = sta ? (struct mt76x02_sta *)sta->drv_priv : NULL;
 	wcid = msta ? &msta->wcid : &mvif->group_wcid;
 
 	if (cmd == SET_KEY) {
@@ -558,11 +558,11 @@ int mt76x02_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 EXPORT_SYMBOL_GPL(mt76x02_set_rts_threshold);
 
 void mt76x02_sta_rate_tbl_update(struct ieee80211_hw *hw,
-				struct ieee80211_vif *vif,
-				struct ieee80211_sta *sta)
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta)
 {
 	struct mt76x02_dev *dev = hw->priv;
-	struct mt76x02_sta *msta = (struct mt76x02_sta *) sta->drv_priv;
+	struct mt76x02_sta *msta = (struct mt76x02_sta *)sta->drv_priv;
 	struct ieee80211_sta_rates *rates = rcu_dereference(sta->rates);
 	struct ieee80211_tx_rate rate = {};
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
index 6f6998561d9d..f17058346ff1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
@@ -33,7 +33,7 @@ mt76x2_eeprom_get_macaddr(struct mt76x02_dev *dev)
 static bool
 mt76x2_has_cal_free_data(struct mt76x02_dev *dev, u8 *efuse)
 {
-	u16 *efuse_w = (u16 *) efuse;
+	u16 *efuse_w = (u16 *)efuse;
 
 	if (efuse_w[MT_EE_NIC_CONF_0] != 0)
 		return false;
@@ -372,7 +372,8 @@ mt76x2_get_power_info_2g(struct mt76x02_dev *dev,
 	t->chain[chain].tssi_slope = data[0];
 	t->chain[chain].tssi_offset = data[1];
 	t->chain[chain].target_power = data[2];
-	t->chain[chain].delta = mt76x02_sign_extend_optional(data[delta_idx], 7);
+	t->chain[chain].delta =
+		mt76x02_sign_extend_optional(data[delta_idx], 7);
 
 	val = mt76x02_eeprom_get(dev, MT_EE_RF_2G_TSSI_OFF_TXPOWER);
 	t->target_power = val >> 8;
@@ -381,7 +382,7 @@ mt76x2_get_power_info_2g(struct mt76x02_dev *dev,
 static void
 mt76x2_get_power_info_5g(struct mt76x02_dev *dev,
 			 struct mt76x2_tx_power_info *t,
-		         struct ieee80211_channel *chan,
+			 struct ieee80211_channel *chan,
 			 int chain, int offset)
 {
 	int channel = chan->hw_value;
@@ -423,7 +424,8 @@ mt76x2_get_power_info_5g(struct mt76x02_dev *dev,
 	t->chain[chain].tssi_slope = data[0];
 	t->chain[chain].tssi_offset = data[1];
 	t->chain[chain].target_power = data[2];
-	t->chain[chain].delta = mt76x02_sign_extend_optional(data[delta_idx], 7);
+	t->chain[chain].delta =
+		mt76x02_sign_extend_optional(data[delta_idx], 7);
 
 	val = mt76x02_eeprom_get(dev, MT_EE_RF_2G_RX_HIGH_GAIN);
 	t->target_power = val & 0xff;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
index 71aea2832644..b8f657517f37 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
@@ -336,4 +336,3 @@ int mt76x2_register_device(struct mt76x02_dev *dev)
 	return ret;
 }
 
-
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c
index 605dc66ae83b..e38715c1bcad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c
@@ -66,7 +66,7 @@ mt76pci_load_rom_patch(struct mt76x02_dev *dev)
 
 	mt76_wr(dev, MT_MCU_PCIE_REMAP_BASE4, MT_MCU_ROM_PATCH_OFFSET);
 
-	cur = (__le32 *) (fw->data + sizeof(*hdr));
+	cur = (__le32 *)(fw->data + sizeof(*hdr));
 	len = fw->size - sizeof(*hdr);
 	mt76_wr_copy(dev, MT_MCU_ROM_PATCH_ADDR, cur, len);
 
@@ -121,7 +121,7 @@ mt76pci_load_firmware(struct mt76x02_dev *dev)
 	dev_info(dev->mt76.dev, "Build: %x\n", val);
 	dev_info(dev->mt76.dev, "Build Time: %.16s\n", hdr->build_time);
 
-	cur = (__le32 *) (fw->data + sizeof(*hdr));
+	cur = (__le32 *)(fw->data + sizeof(*hdr));
 	len = le32_to_cpu(hdr->ilm_len);
 
 	mt76_wr(dev, MT_MCU_PCIE_REMAP_BASE4, MT_MCU_ILM_OFFSET);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
index cdedf95ca4f5..57212b049ee2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
@@ -25,7 +25,8 @@ mt76x2_adjust_high_lna_gain(struct mt76x02_dev *dev, int reg, s8 offset)
 {
 	s8 gain;
 
-	gain = FIELD_GET(MT_BBP_AGC_LNA_HIGH_GAIN, mt76_rr(dev, MT_BBP(AGC, reg)));
+	gain = FIELD_GET(MT_BBP_AGC_LNA_HIGH_GAIN,
+			 mt76_rr(dev, MT_BBP(AGC, reg)));
 	gain -= offset / 2;
 	mt76_rmw_field(dev, MT_BBP(AGC, reg), MT_BBP_AGC_LNA_HIGH_GAIN, gain);
 }
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
index 5397827668b9..eeeda8b4dc5b 100644
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

