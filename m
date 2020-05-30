Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57B31E940A
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2020 23:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgE3VtC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 May 2020 17:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729083AbgE3VtB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 May 2020 17:49:01 -0400
Received: from lore-desk.lan (unknown [151.48.140.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E6E32074D;
        Sat, 30 May 2020 21:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590875341;
        bh=V415AZEvVtmdWgu9otL+7UrQ6vfKFxE0G9q9rRBIfLM=;
        h=From:To:Cc:Subject:Date:From;
        b=lemdX1am6Rw/eJya003GDDqEuZKaIZ0zUEP/o4i44uLTlE8EEk3o576lbwZkuSaG7
         0+UG0uhrHFvUbeqpLaoah2P2c8sTFt39so1pgNgEOGV2JCU+2MRjr11xYSaL34/n5H
         2QH7MmWi7ePfxS96ISsmGEFdl2t9ewsrH8EMLECU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH] mt76: usb: rely on mt76_for_each_q_rx
Date:   Sat, 30 May 2020 23:48:56 +0200
Message-Id: <7849e0acbff0698d39f1e6370a1b2034a8c3d2f5.1590875161.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_for_each_q_rx whenever possible in order to simply the code

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c |  3 --
 drivers/net/wireless/mediatek/mt76/usb.c     | 41 ++++++--------------
 2 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index 3a5de1d1b121..9fda65db8cac 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -54,9 +54,6 @@ static int mt76_rx_queues_read(struct seq_file *s, void *data)
 	mt76_for_each_q_rx(dev, i) {
 		struct mt76_queue *q = &dev->q_rx[i];
 
-		if (!q->ndesc)
-			continue;
-
 		queued = mt76_is_usb(dev) ? q->ndesc - q->queued : q->queued;
 		seq_printf(s, "%d:	queued=%d head=%d tail=%d\n",
 			   i, queued, q->head, q->tail);
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index fb97ea25b4d4..63919a36281e 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -672,17 +672,11 @@ mt76u_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 static void mt76u_rx_tasklet(unsigned long data)
 {
 	struct mt76_dev *dev = (struct mt76_dev *)data;
-	struct mt76_queue *q;
 	int i;
 
 	rcu_read_lock();
-	for (i = 0; i < __MT_RXQ_MAX; i++) {
-		q = &dev->q_rx[i];
-		if (!q->ndesc)
-			continue;
-
-		mt76u_process_rx_queue(dev, q);
-	}
+	mt76_for_each_q_rx(dev, i)
+		mt76u_process_rx_queue(dev, &dev->q_rx[i]);
 	rcu_read_unlock();
 }
 
@@ -756,27 +750,19 @@ mt76u_free_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 
 static void mt76u_free_rx(struct mt76_dev *dev)
 {
-	struct mt76_queue *q;
 	int i;
 
-	for (i = 0; i < __MT_RXQ_MAX; i++) {
-		q = &dev->q_rx[i];
-		if (!q->ndesc)
-			continue;
-
-		mt76u_free_rx_queue(dev, q);
-	}
+	mt76_for_each_q_rx(dev, i)
+		mt76u_free_rx_queue(dev, &dev->q_rx[i]);
 }
 
 void mt76u_stop_rx(struct mt76_dev *dev)
 {
-	struct mt76_queue *q;
-	int i, j;
+	int i;
 
-	for (i = 0; i < __MT_RXQ_MAX; i++) {
-		q = &dev->q_rx[i];
-		if (!q->ndesc)
-			continue;
+	mt76_for_each_q_rx(dev, i) {
+		struct mt76_queue *q = &dev->q_rx[i];
+		int j;
 
 		for (j = 0; j < q->ndesc; j++)
 			usb_poison_urb(q->entry[j].urb);
@@ -788,14 +774,11 @@ EXPORT_SYMBOL_GPL(mt76u_stop_rx);
 
 int mt76u_resume_rx(struct mt76_dev *dev)
 {
-	struct mt76_queue *q;
-	int i, j, err;
-
-	for (i = 0; i < __MT_RXQ_MAX; i++) {
-		q = &dev->q_rx[i];
+	int i;
 
-		if (!q->ndesc)
-			continue;
+	mt76_for_each_q_rx(dev, i) {
+		struct mt76_queue *q = &dev->q_rx[i];
+		int err, j;
 
 		for (j = 0; j < q->ndesc; j++)
 			usb_unpoison_urb(q->entry[j].urb);
-- 
2.26.2

