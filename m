Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCF8B13BDE7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 11:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgAOK7r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 05:59:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbgAOK7q (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 05:59:46 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3322B2467C;
        Wed, 15 Jan 2020 10:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579085986;
        bh=gnEg+ECH6OwfHUuYrJK+DN9r/ciASVJtZ7E44UswmkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iEhOxP4oXNCOD624XWqprd33Q6DEqwoGa82IyafvOWexDftBPr0DPxOYde78tmrYh
         e2WqdSfIIP/DuCJMbfw6Dm0WCvVh5OvUwFZD6k4cd3gw5tCE6At4QxOz9uggTXzX2/
         2UhkfE3Dy4k8+jjKFMvg57C/4pRmnDHdsgs1v7Tc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v3 10/18] mt76: mt76u: add mt76u_alloc_rx_queue utility routine
Date:   Wed, 15 Jan 2020 11:58:50 +0100
Message-Id: <834c8fc1760a0901345ea9f899e57de472c891f5.1579085367.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1579085367.git.lorenzo@kernel.org>
References: <cover.1579085367.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76u_alloc_rx_queue routine to allocate rx hw queue.
This is a preliminary patch to support new devices (e.g. mt7663u) that
rely on a hw queue for mcu messages

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
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

