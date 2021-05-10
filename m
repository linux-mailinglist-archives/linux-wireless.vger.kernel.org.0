Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F55379A14
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 00:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhEJWas (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 18:30:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231162AbhEJWar (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 18:30:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EF88615FF;
        Mon, 10 May 2021 22:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620685780;
        bh=ScPLLImRY/w4P0BUEjSkH3I2WZVwZ+eKlHonbP9JOJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RRCTBKSEHR/6ujVbTXN2hfPysqXhXwi97n3wlD+Yq+XSOfiQCYDgivb4SkcviluXi
         5Ss8OyRnoMchYjSqIqT8QghsAtYN/RQcZ8542CKjKj7XG41mUHzyYms19E6bgBcdVQ
         5I5ruxwwcsOVFp0wawM0uXchyUyeVhSCTroH/FDvvK38BFXVVU5PVyLEok9YCj2wgx
         tlcRUx4s5xfZbwxPCdMULZWOpcynttsmhyNnCCu98Sk/SVLAbKTcXmva3VxkToK7OP
         PK+Qux1DTJ4b2ruaMlgCK6XINBG5BuKXOCsS4j8zLJBRXu+nHojOsswfNym77xQwVU
         i6ulH09vIKj2A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 1/5] mt76: sdio: do not run mt76_txq_schedule directly
Date:   Tue, 11 May 2021 00:29:20 +0200
Message-Id: <74e5e9f31ceedd04f2fba416c94d96f21cd8b458.1620685619.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620685619.git.lorenzo@kernel.org>
References: <cover.1620685619.git.lorenzo@kernel.org>
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
index a18d2896ee1f..46cd28017b96 100644
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

