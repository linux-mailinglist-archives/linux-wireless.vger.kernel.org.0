Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D95D2AE3D1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 00:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgKJXDT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 18:03:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730254AbgKJXDT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 18:03:19 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77F6620679;
        Tue, 10 Nov 2020 23:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605049398;
        bh=76pQH5dblxCsO3pFkGkXB9/oOO2m06B9Elm5ty6+btE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FlkNJ+TlSm4ULR/JCi00YWy0CZ/mhtxMy6lGmWj2t6scrF9HVfNe41u2BfT8AvzGx
         YKA4AFAW8w3Kyom9MQUDe6BSeAFQYSPNWuScAd+nvg55LkJkiksDB/WD7z+8ZjSRoE
         ljnV0Ktok+JXqixWzhBSP34U+bydWA31VXlHztrk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 03/10] mt76: sdio: rely on mt76_queue in mt76s_process_tx_queue signature
Date:   Wed, 11 Nov 2020 00:02:53 +0100
Message-Id: <05e16fb5e8dbdd71182f29c5043a7488eb59cba4.1605048763.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605048763.git.lorenzo@kernel.org>
References: <cover.1605048763.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to move data queues in mt76_phy and properly
support dbdc for mt7915

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/sdio.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 4c6a65cec318..ddd454d628aa 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -155,12 +155,11 @@ static void mt76s_net_worker(struct mt76_worker *w)
 	} while (nframes > 0);
 }
 
-static int mt76s_process_tx_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
+static int mt76s_process_tx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	struct mt76_queue *q = dev->q_tx[qid];
+	bool wake, mcu = q == dev->q_tx[MT_TXQ_MCU];
 	struct mt76_queue_entry entry;
 	int nframes = 0;
-	bool wake;
 
 	while (q->queued > 0) {
 		if (!q->entry[q->tail].done)
@@ -169,7 +168,7 @@ static int mt76s_process_tx_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 		entry = q->entry[q->tail];
 		q->entry[q->tail].done = false;
 
-		if (qid == MT_TXQ_MCU) {
+		if (mcu) {
 			dev_kfree_skb(entry.skb);
 			entry.skb = NULL;
 		}
@@ -185,13 +184,13 @@ static int mt76s_process_tx_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 	if (!q->queued)
 		wake_up(&dev->tx_wait);
 
-	if (qid == MT_TXQ_MCU)
+	if (mcu)
 		goto out;
 
-	mt76_txq_schedule(&dev->phy, qid);
+	mt76_txq_schedule(&dev->phy, q->qid);
 
 	if (wake)
-		ieee80211_wake_queue(dev->hw, qid);
+		ieee80211_wake_queue(dev->hw, q->qid);
 out:
 	return nframes;
 }
@@ -206,7 +205,7 @@ static void mt76s_status_worker(struct mt76_worker *w)
 	do {
 		nframes = 0;
 		for (i = 0; i < MT_TXQ_MCU_WA; i++)
-			nframes += mt76s_process_tx_queue(dev, i);
+			nframes += mt76s_process_tx_queue(dev, dev->q_tx[i]);
 
 		if (dev->drv->tx_status_data &&
 		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
-- 
2.26.2

