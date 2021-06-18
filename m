Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FF93AC5BF
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 10:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhFRIKp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 04:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhFRIKp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 04:10:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62DF060FE6;
        Fri, 18 Jun 2021 08:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624003716;
        bh=cpQ/ZyCMbd69sJyz7DVcJwikPJLGi1/Iast/VGV7cRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPkJTemdHTLa92y9CToVt3fodHBunVZWlviuc1WFybqj9fxGMwZjT2u5n3IzdrYUr
         Iq/mD/xzIdIdZsu2C3lpifdaBrUfk75CCvPvNdhBO4O1IUq7/5eEZPMXnpgDsnknx3
         GH8wf0zbB5mtc2nUQwSssdEvcDyMlQAAdsQMr/5755cfHClBN5CQHfNpoPpWC0EJZf
         PvRjYIHMtvnmHvS92ayg5kh31RlZPY1RGm1/FU5llRUZfOCwdwFJ3nWG3bNgfFXOYs
         pGRlYPou7G5ORAl2WGERDxxn6zBrYrAYXbK5vDYTqnEIaA3l1u+9buuIAvnbFMTLRu
         aK80GZA8qh/wA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH v2 1/5] mt76: sdio: do not run mt76_txq_schedule directly
Date:   Fri, 18 Jun 2021 10:08:20 +0200
Message-Id: <351312614bd7ecd578bf08626db04aedd224f267.1624003282.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624003282.git.lorenzo@kernel.org>
References: <cover.1624003282.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to support runtime-pm for sdio, do not run mt76_txq_schedule
directly, but schedule tx_worker instead

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/sdio.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 1665fe88ebb8..783a15635ec5 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -184,9 +184,6 @@ static int mt76s_process_tx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 	if (!q->queued)
 		wake_up(&dev->tx_wait);
 
-	if (!mcu)
-		mt76_txq_schedule(&dev->phy, q->qid);
-
 	return nframes;
 }
 
@@ -195,19 +192,28 @@ static void mt76s_status_worker(struct mt76_worker *w)
 	struct mt76_sdio *sdio = container_of(w, struct mt76_sdio,
 					      status_worker);
 	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
+	bool resched = false;
 	int i, nframes;
 
 	do {
+		int ndata_frames = 0;
+
 		nframes = mt76s_process_tx_queue(dev, dev->q_mcu[MT_MCUQ_WM]);
 
 		for (i = 0; i <= MT_TXQ_PSD; i++)
-			nframes += mt76s_process_tx_queue(dev,
-							  dev->phy.q_tx[i]);
+			ndata_frames += mt76s_process_tx_queue(dev,
+							       dev->phy.q_tx[i]);
+		nframes += ndata_frames;
+		if (ndata_frames > 0)
+			resched = true;
 
 		if (dev->drv->tx_status_data &&
 		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
 			queue_work(dev->wq, &dev->sdio.stat_work);
 	} while (nframes > 0);
+
+	if (resched)
+		mt76_worker_schedule(&dev->sdio.txrx_worker);
 }
 
 static void mt76s_tx_status_data(struct work_struct *work)
-- 
2.31.1

