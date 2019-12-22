Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3B8128D67
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 11:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfLVKdy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 05:33:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:45336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLVKdx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 05:33:53 -0500
Received: from lore-desk-wlan.lan (unknown [151.66.53.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4384F2084D;
        Sun, 22 Dec 2019 10:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577010833;
        bh=0wuFfNEXuCUETx+lKLgzhi9z0KuNC/F22Ni/fbrK+v4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hOVOTfEyOtHd4qF5S1x30s5EvIUSAYlGzCdnNaEE9JHwGWauwm3LJaJadf4+RUKXJ
         bPcUkR9WeLJzMAHS+6IJMnHMY80jLCDUa87G2Omv+N8GkId+E4jxpAVBmLYFUr9hqv
         8BNSi8Lmf6Y+suo8Vfz29viypZNGNb+7bpxHdE+Q=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH 10/18] mt76: mt76u: add mt76u_alloc_rx_queue utility routine
Date:   Sun, 22 Dec 2019 11:33:12 +0100
Message-Id: <b5d61ac94f38bd6dd3ae68c5cbec0a91401da9c6.1577010183.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577010183.git.lorenzo@kernel.org>
References: <cover.1577010183.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76u_alloc_rx_queue routine to allocate rx hw queue.
This is a preliminary patch to support new devices (e.g. mt7663u) that
rely on a hw queue for mcu messages

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index e29184401a46..2e6041d5257a 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -603,9 +603,10 @@ mt76u_submit_rx_buffers(struct mt76_dev *dev, enum mt76_rxq_id qid)
 	return err;
 }
 
-static int mt76u_alloc_rx(struct mt76_dev *dev)
+static int
+mt76u_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
 {
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
+	struct mt76_queue *q = &dev->q_rx[qid];
 	int i, err;
 
 	spin_lock_init(&q->lock);
@@ -624,7 +625,7 @@ static int mt76u_alloc_rx(struct mt76_dev *dev)
 			return err;
 	}
 
-	return mt76u_submit_rx_buffers(dev, MT_RXQ_MAIN);
+	return mt76u_submit_rx_buffers(dev, qid);
 }
 
 static void
@@ -966,7 +967,7 @@ int mt76u_alloc_queues(struct mt76_dev *dev)
 {
 	int err;
 
-	err = mt76u_alloc_rx(dev);
+	err = mt76u_alloc_rx_queue(dev, MT_RXQ_MAIN);
 	if (err < 0)
 		return err;
 
-- 
2.24.1

