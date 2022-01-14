Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4E348F346
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jan 2022 00:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiANX4m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jan 2022 18:56:42 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48230 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230228AbiANX4l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jan 2022 18:56:41 -0500
X-UUID: 2ee1ea8f234c4f08bd855fa312bfcf1e-20220115
X-UUID: 2ee1ea8f234c4f08bd855fa312bfcf1e-20220115
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1158199742; Sat, 15 Jan 2022 07:56:36 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 15 Jan 2022 07:56:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 15 Jan
 2022 07:56:34 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 15 Jan 2022 07:56:34 +0800
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
        <linux-mediatek@lists.infradead.org>,
        "Deren Wu" <deren.wu@mediatek.com>
Subject: [PATCH v2 1/2] mt76: sdio: honor the largest Tx buffer the hardware can support
Date:   Sat, 15 Jan 2022 07:56:32 +0800
Message-ID: <c09673a115c39f7af692efb984a5dc0c75238a64.1642204233.git.objelf@gmail.com>
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

And then we should take it into account the actual the host and the device
MMC capability to determine what the appropriate xmit_buf_size can be.

Both MT7921S and MT7663 can support up to Tx FIFO size of 0x3fe00 which
means the device can receive 511 blocks of block size 512 in a row from
the host. So if the driver aggregates the frames as many as possible the
the device can support, we can merge multiple MMC requests into a single
one to get rid of the overhead of the handling and synchronizing in those
unnecessary MMC requests and reduce the SDIO lock contention with the
Bluetooth concurrent traffic and finally to have the higher bus
utilization with less idle cycle.

With the patch, it is helpful for WiFi to have steady throughput
performance especially while running Bluetooth concurrently.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>

---
v1 -> v2:
1. move buffer allocation in mt76s_init() and remove duplicated
   code in mt7663/mt7921.
2. move mt76s_get_xmit_buf_sz into mt76s_init()
3. merge 2/3 and 3/3 in v1
---
 drivers/net/wireless/mediatek/mt76/mt76.h       |  5 +++--
 .../net/wireless/mediatek/mt76/mt7615/sdio.c    | 12 +-----------
 .../net/wireless/mediatek/mt76/mt7921/sdio.c    | 12 +-----------
 drivers/net/wireless/mediatek/mt76/sdio.c       | 14 +++++++++++++-
 drivers/net/wireless/mediatek/mt76/sdio_txrx.c  | 17 +++++++----------
 5 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 14f60fcb6a34..43abf0679876 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -497,7 +497,7 @@ struct mt76_usb {
 	} mcu;
 };
 
-#define MT76S_XMIT_BUF_SZ	(16 * PAGE_SIZE)
+#define MT76S_XMIT_BUF_SZ	0x3fe00
 #define MT76S_NUM_TX_ENTRIES	256
 #define MT76S_NUM_RX_ENTRIES	512
 struct mt76_sdio {
@@ -507,7 +507,8 @@ struct mt76_sdio {
 
 	struct work_struct stat_work;
 
-	u8 *xmit_buf[IEEE80211_NUM_ACS + 2];
+	u8 *xmit_buf;
+	u32 xmit_buf_sz;
 
 	struct sdio_func *func;
 	void *intr_data;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 71162befdae8..49ab3a1f3b9b 100644
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
@@ -140,16 +140,6 @@ static int mt7663s_probe(struct sdio_func *func,
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
-	}
-
 	ret = mt76s_alloc_rx_queue(mdev, MT_RXQ_MAIN);
 	if (ret)
 		goto error;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 743b63f66efa..a6ae29c97e0e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -121,7 +121,7 @@ static int mt7921s_probe(struct sdio_func *func,
 
 	struct mt7921_dev *dev;
 	struct mt76_dev *mdev;
-	int ret, i;
+	int ret;
 
 	mdev = mt76_alloc_device(&func->dev, sizeof(*dev), &mt7921_ops,
 				 &drv_ops);
@@ -154,16 +154,6 @@ static int mt7921s_probe(struct sdio_func *func,
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
-	}
-
 	ret = mt76s_alloc_rx_queue(mdev, MT_RXQ_MAIN);
 	if (ret)
 		goto error;
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 54f72d215948..def7f325f5c5 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -12,6 +12,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mmc/sdio_func.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
 #include <linux/sched.h>
 #include <linux/kthread.h>
 
@@ -627,6 +629,7 @@ int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
 	       const struct mt76_bus_ops *bus_ops)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
+	u32 host_max_cap;
 	int err;
 
 	err = mt76_worker_setup(dev->hw, &sdio->status_worker,
@@ -648,7 +651,16 @@ int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
 	dev->bus = bus_ops;
 	dev->sdio.func = func;
 
-	return 0;
+	host_max_cap = min_t(u32, func->card->host->max_req_size,
+			     func->cur_blksize *
+			     func->card->host->max_blk_count);
+	dev->sdio.xmit_buf_sz = min_t(u32, host_max_cap, MT76S_XMIT_BUF_SZ);
+	dev->sdio.xmit_buf = devm_kmalloc(dev->dev, dev->sdio.xmit_buf_sz,
+					  GFP_KERNEL);
+	if (!dev->sdio.xmit_buf)
+		err = -ENOMEM;
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(mt76s_init);
 
diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index 488ad7734d85..9fcf507e09bd 100644
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
@@ -255,27 +254,25 @@ static int mt76s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 		}
 
 		pad = roundup(e->skb->len, 4) - e->skb->len;
-		if (len + e->skb->len + pad + 4 > MT76S_XMIT_BUF_SZ)
+		if (len + e->skb->len + pad + 4 > dev->sdio.xmit_buf_sz)
 			break;
 
 		if (mt76s_tx_pick_quota(sdio, mcu, e->buf_sz, &pse_sz,
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

