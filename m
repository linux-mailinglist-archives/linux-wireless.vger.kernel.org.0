Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A3648D388
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 09:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiAMIX5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 03:23:57 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50170 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229685AbiAMIX4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 03:23:56 -0500
X-UUID: ebcb70dac4f240f89e36b3dedc2141d2-20220113
X-UUID: ebcb70dac4f240f89e36b3dedc2141d2-20220113
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 823626693; Thu, 13 Jan 2022 16:23:52 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 13 Jan 2022 16:23:50 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Jan 2022 16:23:49 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Mark-YW.Chen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <jenhao.yang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/3] mt76: sdio: remove those unnecessary buffers in sdio.xmit_buf
Date:   Thu, 13 Jan 2022 16:23:46 +0800
Message-ID: <651a010d8ff888909b5b8363fa4b243aadc62d45.1642061035.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

We don't have to create a separate sdio.xmit_buf buffer for each queue.
Instead, we just need to create one, reuse it across all queues to reduce
memory consumption further.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h        |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c | 15 ++++++---------
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 15 ++++++---------
 drivers/net/wireless/mediatek/mt76/sdio_txrx.c   | 15 ++++++---------
 4 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 14f60fcb6a34..4029a2217397 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -507,7 +507,7 @@ struct mt76_sdio {
 
 	struct work_struct stat_work;
 
-	u8 *xmit_buf[IEEE80211_NUM_ACS + 2];
+	u8 *xmit_buf;
 
 	struct sdio_func *func;
 	void *intr_data;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 71162befdae8..554160b0ea9a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -101,7 +101,7 @@ static int mt7663s_probe(struct sdio_func *func,
 	struct ieee80211_ops *ops;
 	struct mt7615_dev *dev;
 	struct mt76_dev *mdev;
-	int i, ret;
+	int ret;
 
 	ops = devm_kmemdup(&func->dev, &mt7615_ops, sizeof(mt7615_ops),
 			   GFP_KERNEL);
@@ -140,14 +140,11 @@ static int mt7663s_probe(struct sdio_func *func,
 		goto error;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(mdev->sdio.xmit_buf); i++) {
-		mdev->sdio.xmit_buf[i] = devm_kmalloc(mdev->dev,
-						      MT76S_XMIT_BUF_SZ,
-						      GFP_KERNEL);
-		if (!mdev->sdio.xmit_buf[i]) {
-			ret = -ENOMEM;
-			goto error;
-		}
+	mdev->sdio.xmit_buf = devm_kmalloc(mdev->dev, MT76S_XMIT_BUF_SZ,
+					   GFP_KERNEL);
+	if (!mdev->sdio.xmit_buf) {
+		ret = -ENOMEM;
+		goto error;
 	}
 
 	ret = mt76s_alloc_rx_queue(mdev, MT_RXQ_MAIN);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 743b63f66efa..c58c14e28430 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -121,7 +121,7 @@ static int mt7921s_probe(struct sdio_func *func,
 
 	struct mt7921_dev *dev;
 	struct mt76_dev *mdev;
-	int ret, i;
+	int ret;
 
 	mdev = mt76_alloc_device(&func->dev, sizeof(*dev), &mt7921_ops,
 				 &drv_ops);
@@ -154,14 +154,11 @@ static int mt7921s_probe(struct sdio_func *func,
 		goto error;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(mdev->sdio.xmit_buf); i++) {
-		mdev->sdio.xmit_buf[i] = devm_kmalloc(mdev->dev,
-						      MT76S_XMIT_BUF_SZ,
-						      GFP_KERNEL);
-		if (!mdev->sdio.xmit_buf[i]) {
-			ret = -ENOMEM;
-			goto error;
-		}
+	mdev->sdio.xmit_buf = devm_kmalloc(mdev->dev, MT76S_XMIT_BUF_SZ,
+					   GFP_KERNEL);
+	if (!mdev->sdio.xmit_buf) {
+		ret = -ENOMEM;
+		goto error;
 	}
 
 	ret = mt76s_alloc_rx_queue(mdev, MT_RXQ_MAIN);
diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index 488ad7734d85..a04cd2444247 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -229,12 +229,11 @@ static int __mt76s_xmit_queue(struct mt76_dev *dev, u8 *data, int len)
 
 static int mt76s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	int qid, err, nframes = 0, len = 0, pse_sz = 0, ple_sz = 0;
+	int err, nframes = 0, len = 0, pse_sz = 0, ple_sz = 0;
 	bool mcu = q == dev->q_mcu[MT_MCUQ_WM];
 	struct mt76_sdio *sdio = &dev->sdio;
 	u8 pad;
 
-	qid = mcu ? ARRAY_SIZE(sdio->xmit_buf) - 1 : q->qid;
 	while (q->first != q->head) {
 		struct mt76_queue_entry *e = &q->entry[q->first];
 		struct sk_buff *iter;
@@ -262,20 +261,18 @@ static int mt76s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 					&ple_sz))
 			break;
 
-		memcpy(sdio->xmit_buf[qid] + len, e->skb->data,
-		       skb_headlen(e->skb));
+		memcpy(sdio->xmit_buf + len, e->skb->data, skb_headlen(e->skb));
 		len += skb_headlen(e->skb);
 		nframes++;
 
 		skb_walk_frags(e->skb, iter) {
-			memcpy(sdio->xmit_buf[qid] + len, iter->data,
-			       iter->len);
+			memcpy(sdio->xmit_buf + len, iter->data, iter->len);
 			len += iter->len;
 			nframes++;
 		}
 
 		if (unlikely(pad)) {
-			memset(sdio->xmit_buf[qid] + len, 0, pad);
+			memset(sdio->xmit_buf + len, 0, pad);
 			len += pad;
 		}
 next:
@@ -284,8 +281,8 @@ static int mt76s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 	}
 
 	if (nframes) {
-		memset(sdio->xmit_buf[qid] + len, 0, 4);
-		err = __mt76s_xmit_queue(dev, sdio->xmit_buf[qid], len + 4);
+		memset(sdio->xmit_buf + len, 0, 4);
+		err = __mt76s_xmit_queue(dev, sdio->xmit_buf, len + 4);
 		if (err)
 			return err;
 	}
-- 
2.25.1

