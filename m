Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F63997011
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 05:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfHUDL0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 23:11:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56593 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726329AbfHUDL0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 23:11:26 -0400
X-UUID: f291748dd5e747ca9edec6d3d4ad008a-20190821
X-UUID: f291748dd5e747ca9edec6d3d4ad008a-20190821
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 49729441; Wed, 21 Aug 2019 11:11:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 21 Aug 2019 11:11:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 21 Aug 2019 11:11:13 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2] mt76: fix some checkpatch warnings
Date:   Wed, 21 Aug 2019 11:11:15 +0800
Message-ID: <4ff1174b111ab61e147510ffbcde706d1a00600d.1566356513.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 78921D9263C4F27D8B9AD5770363703414A2D26DFE6AA7FA5591B4732E91257A2000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This fixes the following checkpatch warnings:
CHECK: Alignment should match open parenthesis
CHECK: No space is necessary after a cast

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
Changes since v2: remove false positive checkpatch warnings.
Changes since v1: none.
---
 drivers/net/wireless/mediatek/mt76/agg-rx.c   | 23 +++++++-------
 drivers/net/wireless/mediatek/mt76/dma.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c | 30 +++++++++---------
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  3 +-
 drivers/net/wireless/mediatek/mt76/trace.h    |  9 +++---
 drivers/net/wireless/mediatek/mt76/tx.c       | 18 +++++------
 drivers/net/wireless/mediatek/mt76/usb.c      | 31 ++++++++++---------
 .../net/wireless/mediatek/mt76/usb_trace.h    | 11 ++++---
 drivers/net/wireless/mediatek/mt76/util.h     |  4 +--
 10 files changed, 70 insertions(+), 63 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 2ba157f73bf1..8f3d36a15e17 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -23,8 +23,9 @@ mt76_aggr_release(struct mt76_rx_tid *tid, struct sk_buff_head *frames, int idx)
 }
 
 static void
-mt76_rx_aggr_release_frames(struct mt76_rx_tid *tid, struct sk_buff_head *frames,
-			 u16 head)
+mt76_rx_aggr_release_frames(struct mt76_rx_tid *tid,
+			    struct sk_buff_head *frames,
+			    u16 head)
 {
 	int idx;
 
@@ -63,15 +64,14 @@ mt76_rx_aggr_check_release(struct mt76_rx_tid *tid, struct sk_buff_head *frames)
 	for (idx = (tid->head + 1) % tid->size;
 	     idx != start && nframes;
 	     idx = (idx + 1) % tid->size) {
-
 		skb = tid->reorder_buf[idx];
 		if (!skb)
 			continue;
 
 		nframes--;
-		status = (struct mt76_rx_status *) skb->cb;
-		if (!time_after(jiffies, status->reorder_time +
-					 REORDER_TIMEOUT))
+		status = (struct mt76_rx_status *)skb->cb;
+		if (!time_after(jiffies,
+				status->reorder_time + REORDER_TIMEOUT))
 			continue;
 
 		mt76_rx_aggr_release_frames(tid, frames, status->seqno);
@@ -111,8 +111,8 @@ mt76_rx_aggr_reorder_work(struct work_struct *work)
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
@@ -137,8 +137,8 @@ mt76_rx_aggr_check_ctl(struct sk_buff *skb, struct sk_buff_head *frames)
 
 void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames)
 {
-	struct mt76_rx_status *status = (struct mt76_rx_status *) skb->cb;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct mt76_wcid *wcid = status->wcid;
 	struct ieee80211_sta *sta;
 	struct mt76_rx_tid *tid;
@@ -222,7 +222,8 @@ void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames)
 	tid->nframes++;
 	mt76_rx_aggr_release_head(tid, frames);
 
-	ieee80211_queue_delayed_work(tid->dev->hw, &tid->reorder_work, REORDER_TIMEOUT);
+	ieee80211_queue_delayed_work(tid->dev->hw, &tid->reorder_work,
+				     REORDER_TIMEOUT);
 
 out:
 	spin_unlock_bh(&tid->lock);
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index dbfd15e861e9..46f5223b4d89 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -493,7 +493,7 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 		skb_reserve(skb, q->buf_offset);
 
 		if (q == &dev->q_rx[MT_RXQ_MCU]) {
-			u32 *rxfce = (u32 *) skb->cb;
+			u32 *rxfce = (u32 *)skb->cb;
 			*rxfce = info;
 		}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 581415425cd6..d1075e13ecf7 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -491,7 +491,7 @@ struct ieee80211_sta *mt76_rx_convert(struct sk_buff *skb)
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct mt76_rx_status mstat;
 
-	mstat = *((struct mt76_rx_status *) skb->cb);
+	mstat = *((struct mt76_rx_status *)skb->cb);
 	memset(status, 0, sizeof(*status));
 
 	status->flag = mstat.flag;
@@ -506,8 +506,10 @@ struct ieee80211_sta *mt76_rx_convert(struct sk_buff *skb)
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
@@ -516,7 +518,7 @@ EXPORT_SYMBOL(mt76_rx_convert);
 static int
 mt76_check_ccmp_pn(struct sk_buff *skb)
 {
-	struct mt76_rx_status *status = (struct mt76_rx_status *) skb->cb;
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct mt76_wcid *wcid = status->wcid;
 	struct ieee80211_hdr *hdr;
 	int ret;
@@ -532,7 +534,7 @@ mt76_check_ccmp_pn(struct sk_buff *skb)
 		 * Validate the first fragment both here and in mac80211
 		 * All further fragments will be validated by mac80211 only.
 		 */
-		hdr = (struct ieee80211_hdr *) skb->data;
+		hdr = (struct ieee80211_hdr *)skb->data;
 		if (ieee80211_is_frag(hdr) &&
 		    !ieee80211_is_first_frag(hdr->frame_control))
 			return 0;
@@ -555,8 +557,8 @@ mt76_check_ccmp_pn(struct sk_buff *skb)
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
@@ -565,13 +567,13 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
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
@@ -587,8 +589,8 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 	}
 
 	if (ieee80211_has_morefrags(hdr->frame_control) ||
-		!(ieee80211_is_mgmt(hdr->frame_control) ||
-		  ieee80211_is_data(hdr->frame_control)))
+	    !(ieee80211_is_mgmt(hdr->frame_control) ||
+	    ieee80211_is_data(hdr->frame_control)))
 		return;
 
 	ps = ieee80211_has_pm(hdr->frame_control);
@@ -617,7 +619,7 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 		if (!sta->txq[i])
 			continue;
 
-		mtxq = (struct mt76_txq *) sta->txq[i]->drv_priv;
+		mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
 		if (!skb_queue_empty(&mtxq->retry_q))
 			ieee80211_schedule_txq(dev->hw, sta->txq[i]);
 	}
@@ -739,7 +741,7 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		dev->drv->sta_assoc(dev, vif, sta);
 
 	if (old_state == IEEE80211_STA_NONE &&
-		 new_state == IEEE80211_STA_NOTEXIST)
+	    new_state == IEEE80211_STA_NOTEXIST)
 		mt76_sta_remove(dev, vif, sta);
 
 	return 0;
@@ -779,7 +781,7 @@ static void
 __mt76_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	if (vif->csa_active && ieee80211_csa_is_complete(vif))
-	    ieee80211_csa_finish(vif);
+		ieee80211_csa_finish(vif);
 }
 
 void mt76_csa_finish(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 95ba6e98afa2..1131fcff358b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -671,7 +671,7 @@ static inline struct mt76_tx_cb *mt76_tx_skb_cb(struct sk_buff *skb)
 {
 	BUILD_BUG_ON(sizeof(struct mt76_tx_cb) >
 		     sizeof(IEEE80211_SKB_CB(skb)->status.status_driver_data));
-	return ((void *) IEEE80211_SKB_CB(skb)->status.status_driver_data);
+	return ((void *)IEEE80211_SKB_CB(skb)->status.status_driver_data);
 }
 
 static inline void mt76_insert_hdr_pad(struct sk_buff *skb)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 0554aa2dbe2f..af92150907b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -336,7 +336,8 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
 
 	if (ieee80211_is_data(fc) || ieee80211_is_bufferable_mmpdu(fc)) {
-		q_idx = skb_get_queue_mapping(skb) + wmm_idx * MT7615_MAX_WMM_SETS;
+		q_idx = wmm_idx * MT7615_MAX_WMM_SETS +
+			skb_get_queue_mapping(skb);
 		p_fmt = MT_TX_TYPE_CT;
 	} else if (ieee80211_is_beacon(fc)) {
 		q_idx = MT_LMAC_BCN0;
diff --git a/drivers/net/wireless/mediatek/mt76/trace.h b/drivers/net/wireless/mediatek/mt76/trace.h
index e432f9e845df..0b3e635da868 100644
--- a/drivers/net/wireless/mediatek/mt76/trace.h
+++ b/drivers/net/wireless/mediatek/mt76/trace.h
@@ -13,10 +13,11 @@
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
index 969fedfa3c62..fb86ad956478 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -86,7 +86,7 @@ mt76_txq_get_qid(struct ieee80211_txq *txq)
 static void
 mt76_check_agg_ssn(struct mt76_txq *mtxq, struct sk_buff *skb)
 {
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 
 	if (!ieee80211_is_data_qos(hdr->frame_control) ||
 	    !ieee80211_is_data_present(hdr->frame_control))
@@ -206,8 +206,8 @@ mt76_tx_status_skb_get(struct mt76_dev *dev, struct mt76_wcid *wcid, int pktid,
 		if (cb->pktid == pktid)
 			return skb;
 
-		if (pktid >= 0 &&
-		    !time_after(jiffies, cb->jiffies + MT_TX_STATUS_SKB_TIMEOUT))
+		if (pktid >= 0 && !time_after(jiffies, cb->jiffies +
+					      MT_TX_STATUS_SKB_TIMEOUT))
 			continue;
 
 		__mt76_tx_status_skb_done(dev, skb, MT_TX_CB_TXS_FAILED |
@@ -249,7 +249,7 @@ mt76_tx(struct mt76_dev *dev, struct ieee80211_sta *sta,
 	struct mt76_wcid *wcid, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct mt76_queue *q;
 	int qid = skb_get_queue_mapping(skb);
 
@@ -269,7 +269,7 @@ mt76_tx(struct mt76_dev *dev, struct ieee80211_sta *sta,
 
 		tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
 		txq = sta->txq[tid];
-		mtxq = (struct mt76_txq *) txq->drv_priv;
+		mtxq = (struct mt76_txq *)txq->drv_priv;
 
 		if (mtxq->aggr)
 			mt76_check_agg_ssn(mtxq, skb);
@@ -317,7 +317,7 @@ static void
 mt76_queue_ps_skb(struct mt76_dev *dev, struct ieee80211_sta *sta,
 		  struct sk_buff *skb, bool last)
 {
-	struct mt76_wcid *wcid = (struct mt76_wcid *) sta->drv_priv;
+	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 
 	info->control.flags |= IEEE80211_TX_CTRL_PS_RESPONSE;
@@ -343,7 +343,7 @@ mt76_release_buffered_frames(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 	spin_lock_bh(&hwq->lock);
 	for (i = 0; tids && nframes; i++, tids >>= 1) {
 		struct ieee80211_txq *txq = sta->txq[i];
-		struct mt76_txq *mtxq = (struct mt76_txq *) txq->drv_priv;
+		struct mt76_txq *mtxq = (struct mt76_txq *)txq->drv_priv;
 		struct sk_buff *skb;
 
 		if (!(tids & 1))
@@ -599,7 +599,7 @@ void mt76_txq_remove(struct mt76_dev *dev, struct ieee80211_txq *txq)
 	if (!txq)
 		return;
 
-	mtxq = (struct mt76_txq *) txq->drv_priv;
+	mtxq = (struct mt76_txq *)txq->drv_priv;
 
 	while ((skb = skb_dequeue(&mtxq->retry_q)) != NULL)
 		ieee80211_free_txskb(dev->hw, skb);
@@ -608,7 +608,7 @@ EXPORT_SYMBOL_GPL(mt76_txq_remove);
 
 void mt76_txq_init(struct mt76_dev *dev, struct ieee80211_txq *txq)
 {
-	struct mt76_txq *mtxq = (struct mt76_txq *) txq->drv_priv;
+	struct mt76_txq *mtxq = (struct mt76_txq *)txq->drv_priv;
 
 	skb_queue_head_init(&mtxq->retry_q);
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index cba19a551224..20c6fe510e9d 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -154,7 +154,7 @@ static void mt76u_copy(struct mt76_dev *dev, u32 offset,
 
 	mutex_lock(&usb->usb_ctrl_mtx);
 	for (i = 0; i < DIV_ROUND_UP(len, 4); i++) {
-		put_unaligned(val[i], (u32 *) usb->data);
+		put_unaligned(val[i], (u32 *)usb->data);
 		ret = __mt76u_vendor_request(dev, MT_VEND_MULTI_WRITE,
 					     USB_DIR_OUT | USB_TYPE_VENDOR,
 					     0, offset + i * 4, usb->data,
@@ -309,14 +309,13 @@ mt76u_refill_rx(struct mt76_dev *dev, struct urb *urb, int nsgs, gfp_t gfp)
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
@@ -752,13 +751,14 @@ mt76u_tx_setup_buffers(struct mt76_dev *dev, struct sk_buff *skb,
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
@@ -874,7 +874,8 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 	struct mt76_queue *q;
 	int i, j, ret;
 
-	ret = wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(dev), HZ/5);
+	ret = wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(dev),
+				 HZ / 5);
 	if (!ret) {
 		dev_err(dev->dev, "timed out waiting for pending tx\n");
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb_trace.h b/drivers/net/wireless/mediatek/mt76/usb_trace.h
index f37bd9feacf0..f5ab3215af80 100644
--- a/drivers/net/wireless/mediatek/mt76/usb_trace.h
+++ b/drivers/net/wireless/mediatek/mt76/usb_trace.h
@@ -13,10 +13,11 @@
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
@@ -54,7 +55,7 @@ DECLARE_EVENT_CLASS(urb_transfer,
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

