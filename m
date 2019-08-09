Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0826880CA
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2019 19:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437072AbfHIRGP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Aug 2019 13:06:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51660 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfHIRGP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Aug 2019 13:06:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so6416287wma.1
        for <linux-wireless@vger.kernel.org>; Fri, 09 Aug 2019 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcfKGdPoWy4dY5x6HXuLsE6XYdA0XzL48eJ/gz6guew=;
        b=j1kHqvM/TBkatmpzpH1fiQZdtSF4VmbERVblZ7SBQ7lDgg3tGcSg5eyLEp1TGRYMkH
         9ZoRJeOcTiLn94/WXPwDYyyNV5vHoYzVuLMTkHm7Muu2NGNL+kv1TUBItl3F9xVu+ZUy
         IXuUwU/IPpwWT+6a5WxI80fLLdsR2+60iPBPgUSijdkC57eRq2BkS6z3vmWmWXDEGRrD
         ZOl+aCSzzURj40oi3zp6NJPiHz6orypGwtA79lwYApouNV48zWa1vSb+nCqbjqVOeIkp
         QEUwqOBcqaZPa7ge8oFL81C6D22zbEBMTsYNgh3i46fl75CKSrlNvwWsLdOCB8tBlPnd
         BBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcfKGdPoWy4dY5x6HXuLsE6XYdA0XzL48eJ/gz6guew=;
        b=owFK6AgYP7CGD3fYeuB1kTx4AB1gGVIWnysZHNusT5Jp9MsVLDLgpE6fGx+iWMJhuH
         4FE2vx5vWRt5hDD8luz0ZljlZE6LtCuNFyWlpFR5WQ9ANBagA7stxxRSGKPGc9WSF/eM
         VgIo135xDSKKp5FLvkkjHE2x3sYdWfi+DC6KIPz1VyYymNzt317gNAkoo3IB+DBSlkMO
         ne/sIEic/cNd/Oi/NZcZ0XQPEtIeq+Zg/9m2I+n4xXwlROIqWM6O4EXkcp1OGa+iFax2
         RnMMMrnaaOQVR3PC1sQeqNHadAhN2FeXUMKJoJ5AbrK1LYgEhtJS1us9ikp0uX/8t4Ko
         lWsg==
X-Gm-Message-State: APjAAAXcqMdKi1w1FxgS0SabHLSXAuLGTqK5k2x57shmQ5lYZmBfRmD3
        9an9zzEvxjAfOp04o2aCqzI=
X-Google-Smtp-Source: APXvYqxx7vMjjFCgHmZV/pj+Fl/K25ZnkXCRAScZqMbJas9POLPFI1Vg3hEdVo2TOmEVQ/W9fLVxug==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr12565655wmj.31.1565370372031;
        Fri, 09 Aug 2019 10:06:12 -0700 (PDT)
Received: from localhost.localdomain ([5.171.105.77])
        by smtp.gmail.com with ESMTPSA id z2sm4697604wmi.2.2019.08.09.10.06.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 10:06:11 -0700 (PDT)
From:   Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v2] mt76: move mt76_tx_tasklet in mt76 module
Date:   Fri,  9 Aug 2019 19:06:02 +0200
Message-Id: <850c7e6fa240f435a2e8ea3b8723a3076811b4cb.1565369304.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Move mt76{15,03}_tx_tasklet in mt76_alloc_device in order to be used as
default tx_tasklet initialization. Remove duplicated code in
mt7603/mt7615 drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- move default tx_tasklet initialization in mt76_alloc_device
---
 drivers/net/wireless/mediatek/mt76/mac80211.c   |  2 ++
 drivers/net/wireless/mediatek/mt76/mt76.h       |  1 +
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c | 10 ----------
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c | 10 ----------
 drivers/net/wireless/mediatek/mt76/tx.c         |  7 +++++++
 5 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index f1cc18c22252..ed26661407c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -294,6 +294,8 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	init_waitqueue_head(&dev->tx_wait);
 	skb_queue_head_init(&dev->status_list);
 
+	tasklet_init(&dev->tx_tasklet, mt76_tx_tasklet, (unsigned long)dev);
+
 	return dev;
 }
 EXPORT_SYMBOL_GPL(mt76_alloc_device);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index c755b5ad5e2a..dd9fbb1f79a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -722,6 +722,7 @@ void mt76_stop_tx_queues(struct mt76_dev *dev, struct ieee80211_sta *sta,
 			 bool send_bar);
 void mt76_txq_schedule(struct mt76_dev *dev, enum mt76_txq_id qid);
 void mt76_txq_schedule_all(struct mt76_dev *dev);
+void mt76_tx_tasklet(unsigned long data);
 void mt76_release_buffered_frames(struct ieee80211_hw *hw,
 				  struct ieee80211_sta *sta,
 				  u16 tids, int nframes,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 58dc511f93c5..b53d59c53c28 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -135,14 +135,6 @@ mt7603_init_rx_queue(struct mt7603_dev *dev, struct mt76_queue *q,
 	return 0;
 }
 
-static void
-mt7603_tx_tasklet(unsigned long data)
-{
-	struct mt7603_dev *dev = (struct mt7603_dev *)data;
-
-	mt76_txq_schedule_all(&dev->mt76);
-}
-
 static int mt7603_poll_tx(struct napi_struct *napi, int budget)
 {
 	struct mt7603_dev *dev;
@@ -181,8 +173,6 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 	init_waitqueue_head(&dev->mt76.mmio.mcu.wait);
 	skb_queue_head_init(&dev->mt76.mmio.mcu.res_q);
 
-	tasklet_init(&dev->mt76.tx_tasklet, mt7603_tx_tasklet, (unsigned long)dev);
-
 	mt76_clear(dev, MT_WPDMA_GLO_CFG,
 		   MT_WPDMA_GLO_CFG_TX_DMA_EN |
 		   MT_WPDMA_GLO_CFG_RX_DMA_EN |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 3fe24d92d4fa..fe532cecbbdd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -90,13 +90,6 @@ void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	}
 }
 
-static void mt7615_tx_tasklet(unsigned long data)
-{
-	struct mt7615_dev *dev = (struct mt7615_dev *)data;
-
-	mt76_txq_schedule_all(&dev->mt76);
-}
-
 static int mt7615_poll_tx(struct napi_struct *napi, int budget)
 {
 	static const u8 queue_map[] = {
@@ -128,9 +121,6 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 
 	mt76_dma_attach(&dev->mt76);
 
-	tasklet_init(&dev->mt76.tx_tasklet, mt7615_tx_tasklet,
-		     (unsigned long)dev);
-
 	mt76_wr(dev, MT_WPDMA_GLO_CFG,
 		MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE |
 		MT_WPDMA_GLO_CFG_FIFO_LITTLE_ENDIAN |
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 5397827668b9..670e21bf7490 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -568,6 +568,13 @@ void mt76_txq_schedule_all(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_txq_schedule_all);
 
+void mt76_tx_tasklet(unsigned long data)
+{
+	struct mt76_dev *dev = (struct mt76_dev *)data;
+
+	mt76_txq_schedule_all(dev);
+}
+
 void mt76_stop_tx_queues(struct mt76_dev *dev, struct ieee80211_sta *sta,
 			 bool send_bar)
 {
-- 
2.21.0

