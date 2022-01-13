Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F406148D389
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 09:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiAMIX5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 03:23:57 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:56342 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232966AbiAMIX5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 03:23:57 -0500
X-UUID: 747ac261b91242ecb589d5bfb9f3328b-20220113
X-UUID: 747ac261b91242ecb589d5bfb9f3328b-20220113
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1414554576; Thu, 13 Jan 2022 16:23:53 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 13 Jan 2022 16:23:52 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 13 Jan
 2022 16:23:51 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Jan 2022 16:23:51 +0800
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
Subject: [PATCH 2/3] mt76: sdio: honor the largest Tx buffer the hardware can support
Date:   Thu, 13 Jan 2022 16:23:47 +0800
Message-ID: <557712deb9fc0e78d9a8dd7c68177fe2ae2a38ec.1642061035.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <651a010d8ff888909b5b8363fa4b243aadc62d45.1642061035.git.objelf@gmail.com>
References: <651a010d8ff888909b5b8363fa4b243aadc62d45.1642061035.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

We should take it into account the actual the host and the device MMC
capability to determine what the appropriate xmit_buf_size can be.

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

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h        |  4 +++-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c |  3 ++-
 drivers/net/wireless/mediatek/mt76/sdio.c        | 13 +++++++++++++
 drivers/net/wireless/mediatek/mt76/sdio_txrx.c   |  2 +-
 5 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4029a2217397..8703ecd6396f 100644
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
@@ -508,6 +508,7 @@ struct mt76_sdio {
 	struct work_struct stat_work;
 
 	u8 *xmit_buf;
+	u32 xmit_buf_sz;
 
 	struct sdio_func *func;
 	void *intr_data;
@@ -1280,6 +1281,7 @@ void mt76u_queues_deinit(struct mt76_dev *dev);
 
 int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
 	       const struct mt76_bus_ops *bus_ops);
+u32 mt76s_get_xmit_buf_sz(struct mt76_dev *dev, u32 dev_xmit_sz);
 int mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid);
 int mt76s_alloc_tx(struct mt76_dev *dev);
 void mt76s_deinit(struct mt76_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 554160b0ea9a..ed778b635391 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -140,7 +140,8 @@ static int mt7663s_probe(struct sdio_func *func,
 		goto error;
 	}
 
-	mdev->sdio.xmit_buf = devm_kmalloc(mdev->dev, MT76S_XMIT_BUF_SZ,
+	mdev->sdio.xmit_buf_sz = mt76s_get_xmit_buf_sz(mdev, MT76S_XMIT_BUF_SZ);
+	mdev->sdio.xmit_buf = devm_kmalloc(mdev->dev, mdev->sdio.xmit_buf_sz,
 					   GFP_KERNEL);
 	if (!mdev->sdio.xmit_buf) {
 		ret = -ENOMEM;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index c58c14e28430..6e5d9e9459ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -154,7 +154,8 @@ static int mt7921s_probe(struct sdio_func *func,
 		goto error;
 	}
 
-	mdev->sdio.xmit_buf = devm_kmalloc(mdev->dev, MT76S_XMIT_BUF_SZ,
+	mdev->sdio.xmit_buf_sz = mt76s_get_xmit_buf_sz(mdev, MT76S_XMIT_BUF_SZ);
+	mdev->sdio.xmit_buf = devm_kmalloc(mdev->dev, mdev->sdio.xmit_buf_sz,
 					   GFP_KERNEL);
 	if (!mdev->sdio.xmit_buf) {
 		ret = -ENOMEM;
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 54f72d215948..bd0027152026 100644
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
 
@@ -299,6 +301,17 @@ int mt76s_hw_init(struct mt76_dev *dev, struct sdio_func *func, int hw_ver)
 }
 EXPORT_SYMBOL_GPL(mt76s_hw_init);
 
+u32 mt76s_get_xmit_buf_sz(struct mt76_dev *dev, u32 dev_max_len)
+{
+	struct sdio_func *func = dev->sdio.func;
+	u32 host_max_len = min_t(u32, func->card->host->max_req_size,
+				 func->cur_blksize *
+				 func->card->host->max_blk_count);
+
+	return min_t(u32, host_max_len, dev_max_len);
+}
+EXPORT_SYMBOL_GPL(mt76s_get_xmit_buf_sz);
+
 int mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
 {
 	struct mt76_queue *q = &dev->q_rx[qid];
diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index a04cd2444247..9fcf507e09bd 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -254,7 +254,7 @@ static int mt76s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 		}
 
 		pad = roundup(e->skb->len, 4) - e->skb->len;
-		if (len + e->skb->len + pad + 4 > MT76S_XMIT_BUF_SZ)
+		if (len + e->skb->len + pad + 4 > dev->sdio.xmit_buf_sz)
 			break;
 
 		if (mt76s_tx_pick_quota(sdio, mcu, e->buf_sz, &pse_sz,
-- 
2.25.1

