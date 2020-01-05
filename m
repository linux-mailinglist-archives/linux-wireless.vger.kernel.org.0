Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 418411307EA
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2020 13:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgAEMWy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Jan 2020 07:22:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgAEMWx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Jan 2020 07:22:53 -0500
Received: from new-host-5.station (net-2-42-61-77.cust.vodafonedsl.it [2.42.61.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE4AD24650;
        Sun,  5 Jan 2020 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578226973;
        bh=pxkFhecdCehym7cCCgqXYYig3lIDTh079NLpYGJZmRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PFdTnyQNsknZXC+ry6EepAtftsZjRBZC3Ga/AVpuWZlyB3yfZJXcY2N2XX++Xg/yJ
         mr6KDws8n85t+Fpn0nRsY+h9IPOftiWr4Ejej6y6z8n3fIkcdVTv26jCnEBtAG7+VO
         rLmTpQH7YNfvgb48LiWzHb+ANPERVCw8CVN0DP8s=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v2 10/18] mt76: mt76u: add mt76u_alloc_rx_queue utility routine
Date:   Sun,  5 Jan 2020 13:21:48 +0100
Message-Id: <2b4eba1ccbc02bc6e32e473cf06cb4989c981beb.1578226544.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1578226544.git.lorenzo@kernel.org>
References: <cover.1578226544.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76u_alloc_rx_queue routine to allocate rx hw queue.
This is a preliminary patch to support new devices (e.g. mt7663u) that
rely on a hw queue for mcu messages

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index dde1ee34d23d..e1112899a207 100644
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
2.21.1

