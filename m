Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10AE279A4C
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Sep 2020 17:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgIZPHF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Sep 2020 11:07:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729527AbgIZPHE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Sep 2020 11:07:04 -0400
Received: from localhost.localdomain (unknown [151.66.98.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3304C208FE;
        Sat, 26 Sep 2020 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601132824;
        bh=LaXWhNOZepHAe9FyS3bhzpwGY6QXwJCs8+pS1fAXldM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SzdQEfM5oZAmAU008+vbmo28YoZOQIh52titXjUjXPaBcOGEvE3IBOW/X/QegI4Ma
         DJi92/sbtAlPVMpZ8vNR/Ec35H3kqlwnCV+/RjMret8840twf4DwUZNu6ysxlWzhNK
         U+nyzBJ8RahxO6YLuOFQR/vU/7UdOzJSR8b7VI7I=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 3/4] mt76: mt7663s: disable interrupt during txrx_worker processing
Date:   Sat, 26 Sep 2020 17:06:24 +0200
Message-Id: <f47d7b9c84155c9c6239ed0aa3f378ad3da5bb0e.1601132347.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601132347.git.lorenzo@kernel.org>
References: <cover.1601132347.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to reduce sdio bus contention, disable interrupts during
txrx_worker processing

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 27 +++++++------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index 10ed211d7d11..d8f9148fe777 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -105,10 +105,7 @@ static int mt7663s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 
 	buf = page_address(page);
 
-	sdio_claim_host(sdio->func);
 	err = sdio_readsb(sdio->func, buf, MCR_WRDR(qid), len);
-	sdio_release_host(sdio->func);
-
 	if (err < 0) {
 		dev_err(dev->dev, "sdio read data failed:%d\n", err);
 		__free_pages(page, order);
@@ -144,14 +141,9 @@ static int mt7663s_rx_handler(struct mt76_dev *dev)
 	struct mt76s_intr *intr = sdio->intr_data;
 	int nframes = 0, ret;
 
-	/* disable interrupt */
-	sdio_claim_host(sdio->func);
-	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
 	ret = sdio_readsb(sdio->func, intr, MCR_WHISR, sizeof(*intr));
-	sdio_release_host(sdio->func);
-
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	trace_dev_irq(dev, intr->isr, 0);
 
@@ -173,12 +165,6 @@ static int mt7663s_rx_handler(struct mt76_dev *dev)
 
 	nframes += !!mt7663s_refill_sched_quota(dev, intr->tx.wtqcr);
 
-out:
-	/* enable interrupt */
-	sdio_claim_host(sdio->func);
-	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
-	sdio_release_host(sdio->func);
-
 	return nframes;
 }
 
@@ -225,10 +211,7 @@ static int __mt7663s_xmit_queue(struct mt76_dev *dev, u8 *data, int len)
 	if (len > sdio->func->cur_blksize)
 		len = roundup(len, sdio->func->cur_blksize);
 
-	sdio_claim_host(sdio->func);
 	err = sdio_writesb(sdio->func, MCR_WTDR1, data, len);
-	sdio_release_host(sdio->func);
-
 	if (err)
 		dev_err(dev->dev, "sdio write failed: %d\n", err);
 
@@ -298,6 +281,10 @@ void mt7663s_txrx_worker(struct mt76_worker *w)
 	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
 	int i, nframes, ret;
 
+	/* disable interrupt */
+	sdio_claim_host(sdio->func);
+	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
+
 	do {
 		nframes = 0;
 
@@ -313,6 +300,10 @@ void mt7663s_txrx_worker(struct mt76_worker *w)
 		if (ret > 0)
 			nframes += ret;
 	} while (nframes > 0);
+
+	/* enable interrupt */
+	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
+	sdio_release_host(sdio->func);
 }
 
 void mt7663s_sdio_irq(struct sdio_func *func)
-- 
2.26.2

