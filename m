Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8B725E6B5
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Sep 2020 11:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgIEJ03 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Sep 2020 05:26:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbgIEJ0Z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Sep 2020 05:26:25 -0400
Received: from localhost.localdomain (unknown [151.66.86.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95C5C206A5;
        Sat,  5 Sep 2020 09:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599297984;
        bh=wQwxQ6YukivyJjsT+sHhgiLmEMVeo6r5oMSo02XLjEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iP0Ev/KfBmZG3MSMBonfkhygstjS2DmvH7+dGF/wg0qoRuTkNlL8pM5ih6bky52UP
         LkooRFgxoU/ZjV2eifHdzy4CLC9KGNZc2eOJrozgY7DDpj6+ODFH+J2uAnv3Dxp4o/
         HGzBCbwWdSHZmIb8G6CtSripn6i/pvtmGfiVRDTw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 6/7] mt76: mt7663s: introduce sdio tx aggregation
Date:   Sat,  5 Sep 2020 11:26:06 +0200
Message-Id: <b4c046fabd51ccb384b6f769e45ce3395d1c405b.1599297449.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599297449.git.lorenzo@kernel.org>
References: <cover.1599297449.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce sdio tx aggregation to reduce bus transaction ands improve tx
throughput. For the moment the skb are copied in a dedicated buffer
since mmc APIs do not support sg table for zero-copy.
Since skb data are already copied in xmit_buff[], avoid linearization in
ma80211 layer. Relying on tx aggregation, we improve tx tpt of ~65%.

Tested-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  5 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  3 ++
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  | 12 ++++-
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 49 +++++++++++++------
 4 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 7014846fd854..bd692431b07f 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -307,10 +307,7 @@ mt76_phy_init(struct mt76_dev *dev, struct ieee80211_hw *hw)
 
 	if (!(dev->drv->drv_flags & MT_DRV_AMSDU_OFFLOAD)) {
 		ieee80211_hw_set(hw, TX_AMSDU);
-
-		/* TODO: avoid linearization for SDIO */
-		if (!mt76_is_sdio(dev))
-			ieee80211_hw_set(hw, TX_FRAG_LIST);
+		ieee80211_hw_set(hw, TX_FRAG_LIST);
 	}
 
 	ieee80211_hw_set(hw, MFP_CAPABLE);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 209d23846d4c..c4a02b5aa990 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -444,6 +444,7 @@ struct mt76_usb {
 	} mcu;
 };
 
+#define MT76S_XMIT_BUF_SZ	(16 * PAGE_SIZE)
 struct mt76_sdio {
 	struct workqueue_struct *txrx_wq;
 	struct {
@@ -457,6 +458,8 @@ struct mt76_sdio {
 
 	struct work_struct stat_work;
 
+	u8 *xmit_buf[MT_TXQ_MCU_WA];
+
 	struct sdio_func *func;
 	void *intr_data;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 8621c6f579aa..874c929d8552 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -346,7 +346,7 @@ static int mt7663s_probe(struct sdio_func *func,
 	struct ieee80211_ops *ops;
 	struct mt7615_dev *dev;
 	struct mt76_dev *mdev;
-	int ret;
+	int i, ret;
 
 	ops = devm_kmemdup(&func->dev, &mt7615_ops, sizeof(mt7615_ops),
 			   GFP_KERNEL);
@@ -387,6 +387,16 @@ static int mt7663s_probe(struct sdio_func *func,
 		goto err_deinit;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(mdev->sdio.xmit_buf); i++) {
+		mdev->sdio.xmit_buf[i] = devm_kmalloc(mdev->dev,
+						      MT76S_XMIT_BUF_SZ,
+						      GFP_KERNEL);
+		if (!mdev->sdio.xmit_buf[i]) {
+			ret = -ENOMEM;
+			goto err_deinit;
+		}
+	}
+
 	ret = mt76s_alloc_queues(&dev->mt76);
 	if (ret)
 		goto err_deinit;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index 4033fe431312..e82f6bdcbce4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -138,15 +138,11 @@ static int mt7663s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 	return i;
 }
 
-static int mt7663s_tx_pick_quota(struct mt76_dev *dev, enum mt76_txq_id qid,
+static int mt7663s_tx_pick_quota(struct mt76_sdio *sdio, enum mt76_txq_id qid,
 				 int buf_sz, int *pse_size, int *ple_size)
 {
-	struct mt76_sdio *sdio = &dev->sdio;
 	int pse_sz;
 
-	if (!test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))
-		return 0;
-
 	pse_sz = DIV_ROUND_UP(buf_sz + sdio->sched.deficit, MT_PSE_PAGE_SZ);
 
 	if (qid == MT_TXQ_MCU) {
@@ -197,27 +193,52 @@ static int __mt7663s_xmit_queue(struct mt76_dev *dev, u8 *data, int len)
 
 static int mt7663s_tx_run_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 {
-	int nframes = 0, pse_sz = 0, ple_sz = 0;
+	int err, nframes = 0, len = 0, pse_sz = 0, ple_sz = 0;
 	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_sdio *sdio = &dev->sdio;
 
 	while (q->first != q->head) {
 		struct mt76_queue_entry *e = &q->entry[q->first];
-		int err;
+		struct sk_buff *iter;
+
+		if (!test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state)) {
+			__skb_put_zero(e->skb, 4);
+			err = __mt7663s_xmit_queue(dev, e->skb->data,
+						   e->skb->len);
+			if (err)
+				return err;
+
+			goto next;
+		}
+
+		if (len + e->skb->len + 4 > MT76S_XMIT_BUF_SZ)
+			break;
 
-		if (mt7663s_tx_pick_quota(dev, qid, e->buf_sz, &pse_sz,
+		if (mt7663s_tx_pick_quota(sdio, qid, e->buf_sz, &pse_sz,
 					  &ple_sz))
 			break;
 
-		__skb_put_zero(e->skb, 4);
+		memcpy(sdio->xmit_buf[qid] + len, e->skb->data,
+		       skb_headlen(e->skb));
+		len += skb_headlen(e->skb);
+		nframes++;
 
-		err = __mt7663s_xmit_queue(dev, e->skb->data, e->skb->len);
+		skb_walk_frags(e->skb, iter) {
+			memcpy(sdio->xmit_buf[qid] + len, iter->data,
+			       iter->len);
+			len += iter->len;
+			nframes++;
+		}
+next:
+		q->first = (q->first + 1) % q->ndesc;
+		e->done = true;
+	}
+
+	if (nframes) {
+		memset(sdio->xmit_buf[qid] + len, 0, 4);
+		err = __mt7663s_xmit_queue(dev, sdio->xmit_buf[qid], len + 4);
 		if (err)
 			return err;
-
-		e->done = true;
-		q->first = (q->first + 1) % q->ndesc;
-		nframes++;
 	}
 	mt7663s_tx_update_quota(sdio, qid, pse_sz, ple_sz);
 
-- 
2.26.2

