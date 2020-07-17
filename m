Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0092F223779
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 10:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgGQI57 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jul 2020 04:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgGQI57 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jul 2020 04:57:59 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A4E2083E;
        Fri, 17 Jul 2020 08:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594976278;
        bh=nvc0dnOo2yv9Vcad52msaBhcH2aBdiMgdUHbbKY76OA=;
        h=From:To:Cc:Subject:Date:From;
        b=owfMPfT1taL0yszxJDsLBww97vt0jfilDMBwt0dIEg1eUMwI6+SCDup+IboHr25/j
         5G4OiS5DnjpZGlux6DNjxbg/0+q8H8ifuDZkYoZOxWlwEO+KIolREeU+kv6uXLDB3I
         gQzJexA5llRMYz+djmkFbd54FonG39MWNBYj8tFY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt76s: move queue accounting in mt76s_tx_queue_skb
Date:   Fri, 17 Jul 2020 10:57:39 +0200
Message-Id: <cec9222d42b78839d6265cae9dd678a443aaa3d2.1594976004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to avoid possible overflows, move tx queue accounting from
mt7663s_tx_run_queue() to mt76s_tx_queue_skb_raw()/mt76s_tx_queue_skb()

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c | 5 +----
 drivers/net/wireless/mediatek/mt76/sdio.c             | 5 +++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index 156666a94eb7..443a4ecdad3a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -180,14 +180,11 @@ static int mt7663s_tx_run_queue(struct mt7615_dev *dev, struct mt76_queue *q)
 			return -EIO;
 		}
 
+		e->done = true;
 		q->first = (q->first + 1) % q->ndesc;
 		nframes++;
 	}
 
-	spin_lock_bh(&q->lock);
-	q->queued += nframes;
-	spin_unlock_bh(&q->lock);
-
 	return nframes;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index a6f3255c4d84..d2b38ed7f3b4 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -138,6 +138,9 @@ static int mt76s_process_tx_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 	bool wake;
 
 	while (q->queued > n_dequeued) {
+		if (!q->entry[q->head].done)
+			break;
+
 		if (q->entry[q->head].schedule) {
 			q->entry[q->head].schedule = false;
 			n_sw_dequeued++;
@@ -229,6 +232,7 @@ mt76s_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 	q->entry[q->tail].skb = tx_info.skb;
 	q->entry[q->tail].buf_sz = len;
 	q->tail = (q->tail + 1) % q->ndesc;
+	q->queued++;
 
 	return idx;
 }
@@ -251,6 +255,7 @@ mt76s_tx_queue_skb_raw(struct mt76_dev *dev, enum mt76_txq_id qid,
 	q->entry[q->tail].buf_sz = len;
 	q->entry[q->tail].skb = skb;
 	q->tail = (q->tail + 1) % q->ndesc;
+	q->queued++;
 
 out:
 	spin_unlock_bh(&q->lock);
-- 
2.26.2

