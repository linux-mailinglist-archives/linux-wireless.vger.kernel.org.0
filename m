Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421E02F679F
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 18:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbhANR1l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 12:27:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:60350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbhANR1k (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 12:27:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB65623A5E;
        Thu, 14 Jan 2021 17:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610645220;
        bh=nos0bBc5pgySiP30SzeOjyU7HnizzHqLaYUX4u67vH4=;
        h=From:To:Cc:Subject:Date:From;
        b=m1OV1B5v1CSF5OR+ZuSAm6ol/24w4L213y0G1SYMver+Mcn/ChSdM1BPdJLEwl7En
         Q5mSy/9GoD1w0ocfAHzoU3gyJ+e2/pgzfVHS3vqkB7gk/yl4D8j8ikwc8oHv21jWgC
         GrvIF742Gi/55SIrrs/S6HW/rqXJ3Y9UAy8EHumm+C3TplLecijadnTkn4VczieDNs
         /NtfW4z3xTdR81IVhJaVKfKSgoMHxlerqI+70IqnlRvUE6RyX/WBbZx0g1b2+HVGaR
         XNDHxpvfDy3uyiOdudtJ7UomJMjQZr3GqgYnz4gP5Nt8FC3Msfk6tR/I/Qrx/6UacM
         xxLrc5aGSsOsw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, kuba@kernel.org, nbd@nbd.name,
        sean.wang@mediatek.com
Subject: [PATCH wireless-drivers] mt76: mt7663s: fix rx buffer refcounting
Date:   Thu, 14 Jan 2021 18:26:47 +0100
Message-Id: <dca19c9d445156201bc41f7cbb6e894bbc9a678c.1610644945.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7601u driver, fix erroneous rx page refcounting

Fixes: a66cbdd6573d ("mt76: mt7615: introduce mt7663s support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index 13d77f8fca86..9fb506f2ace6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -83,7 +83,7 @@ static int mt7663s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 {
 	struct mt76_queue *q = &dev->q_rx[qid];
 	struct mt76_sdio *sdio = &dev->sdio;
-	int len = 0, err, i, order;
+	int len = 0, err, i;
 	struct page *page;
 	u8 *buf;
 
@@ -96,8 +96,7 @@ static int mt7663s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 	if (len > sdio->func->cur_blksize)
 		len = roundup(len, sdio->func->cur_blksize);
 
-	order = get_order(len);
-	page = __dev_alloc_pages(GFP_KERNEL, order);
+	page = __dev_alloc_pages(GFP_KERNEL, get_order(len));
 	if (!page)
 		return -ENOMEM;
 
@@ -106,7 +105,7 @@ static int mt7663s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 	err = sdio_readsb(sdio->func, buf, MCR_WRDR(qid), len);
 	if (err < 0) {
 		dev_err(dev->dev, "sdio read data failed:%d\n", err);
-		__free_pages(page, order);
+		put_page(page);
 		return err;
 	}
 
@@ -123,7 +122,7 @@ static int mt7663s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 		if (q->queued + i + 1 == q->ndesc)
 			break;
 	}
-	__free_pages(page, order);
+	put_page(page);
 
 	spin_lock_bh(&q->lock);
 	q->head = (q->head + i) % q->ndesc;
-- 
2.29.2

