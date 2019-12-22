Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E10B128D66
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 11:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLVKdw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 05:33:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLVKdw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 05:33:52 -0500
Received: from lore-desk-wlan.lan (unknown [151.66.53.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7EAB20733;
        Sun, 22 Dec 2019 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577010831;
        bh=H7nQYws/xinCzXPO7Ai5XhUGtlDswHJUOnBdhUFYM8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mZvgo4A+8OaJcaC6isq/a3Xp2dewFFhUnkX7E6BaRxYSW2W7oVzcfeaiV+tWBVmyx
         4bLRgU9vCYo1QXYg1tSMfPCO9FGugu6iZE4Q1Ua29hQr6Q4ki+wJdZGdyLwvHHo0Yc
         j/TWk4CC8m5sXZUUaFDSiuxJFmxwgeGgJYdXHIsM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH 09/18] mt76: mt76u: stop/free all possible rx queues
Date:   Sun, 22 Dec 2019 11:33:11 +0100
Message-Id: <08ed394e55cc622f9f488d7b5496e7a7fd162738.1577010183.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577010183.git.lorenzo@kernel.org>
References: <cover.1577010183.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stop/free all configured rx queues (data/mcu) in
mt76u_stop_rx/mt76u_free_rx. This is a preliminary patch to support new
devices (e.g. mt7663u) that rely on a hw queue for mcu messages

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 25 ++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index b20c26da57d3..e29184401a46 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -646,18 +646,31 @@ mt76u_free_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 
 static void mt76u_free_rx(struct mt76_dev *dev)
 {
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
+	struct mt76_queue *q;
+	int i;
+
+	for (i = 0; i < __MT_RXQ_MAX; i++) {
+		q = &dev->q_rx[i];
+		if (!q->ndesc)
+			continue;
 
-	mt76u_free_rx_queue(dev, q);
+		mt76u_free_rx_queue(dev, q);
+	}
 }
 
 void mt76u_stop_rx(struct mt76_dev *dev)
 {
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
-	int i;
+	struct mt76_queue *q;
+	int i, j;
 
-	for (i = 0; i < q->ndesc; i++)
-		usb_poison_urb(q->entry[i].urb);
+	for (i = 0; i < __MT_RXQ_MAX; i++) {
+		q = &dev->q_rx[i];
+		if (!q->ndesc)
+			continue;
+
+		for (j = 0; j < q->ndesc; j++)
+			usb_poison_urb(q->entry[j].urb);
+	}
 
 	tasklet_kill(&dev->usb.rx_tasklet);
 }
-- 
2.24.1

