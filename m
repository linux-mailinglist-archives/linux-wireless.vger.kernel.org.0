Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0790042CCF2
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 23:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhJMVmg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Oct 2021 17:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhJMVmf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Oct 2021 17:42:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12ABB611AE;
        Wed, 13 Oct 2021 21:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634161231;
        bh=SFKl3fNYDBHcN23jmjkIxZRi84dd2IbNVlqghh3+2b8=;
        h=From:To:Cc:Subject:Date:From;
        b=HTf3ANKnJIYF4J1jqnnXa022UPsD9Pj98cW8wgXaa+NTqeOYNCMFOWV9s7DBFQdKr
         nKZGIHihLU9QoCCzUJAns90SkHtAtxq1vcLvjKInObYzRsB00xE+hHi9OrWXYnFQeO
         5FYjViAU+MMC46+qlii887e8l+wD8iRiPyGR7K+oSnfQS/ZbXjIbHrxhX8/DUtvx1m
         wAnPWygxHjNgMjzAX5370BmZwWKGG9NwN0JjrBkpeEli58BGB9nI5X4TjbS962d0Rj
         Ts7VmBt1UetfCSiIsyLBAcH2frSwqZrFIR8hz2FI0+HgKFhN3gnhTK6LNzpzmxc/j/
         1RfAZAl3QPQRw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: sdio: export mt76s_alloc_rx_queue and mt76s_alloc_tx routines
Date:   Wed, 13 Oct 2021 23:40:22 +0200
Message-Id: <95258d39022fe387fa8ea63622de62e8db8f3c3c.1634161161.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Export mt76s_alloc_rx_queue and mt76s_alloc_tx utility routines in order
to allow mt7921s driver to configure a different main rx queue.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  3 ++-
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |  6 +++++-
 drivers/net/wireless/mediatek/mt76/sdio.c     | 19 ++++---------------
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4c20b128466d..2e3a9073dfd4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1245,7 +1245,8 @@ void mt76u_queues_deinit(struct mt76_dev *dev);
 
 int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
 	       const struct mt76_bus_ops *bus_ops);
-int mt76s_alloc_queues(struct mt76_dev *dev);
+int mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid);
+int mt76s_alloc_tx(struct mt76_dev *dev);
 void mt76s_deinit(struct mt76_dev *dev);
 
 struct sk_buff *
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index fb0f8f34b8f2..ff1e62035f37 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -367,7 +367,11 @@ static int mt7663s_probe(struct sdio_func *func,
 		}
 	}
 
-	ret = mt76s_alloc_queues(&dev->mt76);
+	ret = mt76s_alloc_rx_queue(mdev, MT_RXQ_MAIN);
+	if (ret)
+		goto error;
+
+	ret = mt76s_alloc_tx(mdev);
 	if (ret)
 		goto error;
 
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 4abf432750c6..f7a1838b4576 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -17,8 +17,7 @@
 
 #include "mt76.h"
 
-static int
-mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
+int mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
 {
 	struct mt76_queue *q = &dev->q_rx[qid];
 
@@ -35,6 +34,7 @@ mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt76s_alloc_rx_queue);
 
 static struct mt76_queue *mt76s_alloc_tx_queue(struct mt76_dev *dev)
 {
@@ -56,7 +56,7 @@ static struct mt76_queue *mt76s_alloc_tx_queue(struct mt76_dev *dev)
 	return q;
 }
 
-static int mt76s_alloc_tx(struct mt76_dev *dev)
+int mt76s_alloc_tx(struct mt76_dev *dev)
 {
 	struct mt76_queue *q;
 	int i;
@@ -79,18 +79,7 @@ static int mt76s_alloc_tx(struct mt76_dev *dev)
 
 	return 0;
 }
-
-int mt76s_alloc_queues(struct mt76_dev *dev)
-{
-	int err;
-
-	err = mt76s_alloc_rx_queue(dev, MT_RXQ_MAIN);
-	if (err < 0)
-		return err;
-
-	return mt76s_alloc_tx(dev);
-}
-EXPORT_SYMBOL_GPL(mt76s_alloc_queues);
+EXPORT_SYMBOL_GPL(mt76s_alloc_tx);
 
 static struct mt76_queue_entry *
 mt76s_get_next_rx_entry(struct mt76_queue *q)
-- 
2.31.1

