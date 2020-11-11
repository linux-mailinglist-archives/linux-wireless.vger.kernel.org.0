Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0D52AF277
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 14:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgKKNsT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 08:48:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbgKKNrv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 08:47:51 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F253B2074B;
        Wed, 11 Nov 2020 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605102470;
        bh=Zs6ZjNtlkCAZXU3uIBW2l450fLnHsXwnfhrWdVcOtbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sE90qJZDt5QE6cGzOYmWFn9mzn1uk7d/QrNWnI02+pIDvyoxmwGIEyGG51xlGFmai
         leutFdBUPU+3shDBZx0FnOHp+99LLEBIq7LitHQutSY9VuuU1lDv5qyWEDuon4RVjj
         rRXkJ1HVGHGcnK87/Co73Kaj892rDHQODesREV+U=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH v2 04/10] mt76: mt7663s: rely on mt76_queue in mt7663s_tx_run_queue signature
Date:   Wed, 11 Nov 2020 14:47:26 +0100
Message-Id: <474869cc686cf76a927eea3759d089085245bc18.1605102251.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605102251.git.lorenzo@kernel.org>
References: <cover.1605102251.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to move data queues in mt76_phy and properly
support dbdc for mt7915

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 23 ++++++++++---------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 63549a7806cb..fc4f0b3e4873 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -458,7 +458,7 @@ struct mt76_sdio {
 
 	struct work_struct stat_work;
 
-	u8 *xmit_buf[MT_TXQ_MCU_WA];
+	u8 *xmit_buf[IEEE80211_NUM_ACS + 2];
 
 	struct sdio_func *func;
 	void *intr_data;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index e46ed4b94bc5..ab883b4bca45 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -166,14 +166,14 @@ static int mt7663s_rx_handler(struct mt76_dev *dev)
 	return nframes;
 }
 
-static int mt7663s_tx_pick_quota(struct mt76_sdio *sdio, enum mt76_txq_id qid,
-				 int buf_sz, int *pse_size, int *ple_size)
+static int mt7663s_tx_pick_quota(struct mt76_sdio *sdio, bool mcu, int buf_sz,
+				 int *pse_size, int *ple_size)
 {
 	int pse_sz;
 
 	pse_sz = DIV_ROUND_UP(buf_sz + sdio->sched.deficit, MT_PSE_PAGE_SZ);
 
-	if (qid == MT_TXQ_MCU) {
+	if (mcu) {
 		if (sdio->sched.pse_mcu_quota < *pse_size + pse_sz)
 			return -EBUSY;
 	} else {
@@ -188,10 +188,10 @@ static int mt7663s_tx_pick_quota(struct mt76_sdio *sdio, enum mt76_txq_id qid,
 	return 0;
 }
 
-static void mt7663s_tx_update_quota(struct mt76_sdio *sdio, enum mt76_txq_id qid,
+static void mt7663s_tx_update_quota(struct mt76_sdio *sdio, bool mcu,
 				    int pse_size, int ple_size)
 {
-	if (qid == MT_TXQ_MCU) {
+	if (mcu) {
 		sdio->sched.pse_mcu_quota -= pse_size;
 	} else {
 		sdio->sched.pse_data_quota -= pse_size;
@@ -214,12 +214,13 @@ static int __mt7663s_xmit_queue(struct mt76_dev *dev, u8 *data, int len)
 	return err;
 }
 
-static int mt7663s_tx_run_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
+static int mt7663s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	int err, nframes = 0, len = 0, pse_sz = 0, ple_sz = 0;
-	struct mt76_queue *q = dev->q_tx[qid];
+	int qid, err, nframes = 0, len = 0, pse_sz = 0, ple_sz = 0;
+	bool mcu = q == dev->q_tx[MT_TXQ_MCU];
 	struct mt76_sdio *sdio = &dev->sdio;
 
+	qid = mcu ? ARRAY_SIZE(sdio->xmit_buf) - 1 : q->qid;
 	while (q->first != q->head) {
 		struct mt76_queue_entry *e = &q->entry[q->first];
 		struct sk_buff *iter;
@@ -237,7 +238,7 @@ static int mt7663s_tx_run_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 		if (len + e->skb->len + 4 > MT76S_XMIT_BUF_SZ)
 			break;
 
-		if (mt7663s_tx_pick_quota(sdio, qid, e->buf_sz, &pse_sz,
+		if (mt7663s_tx_pick_quota(sdio, mcu, e->buf_sz, &pse_sz,
 					  &ple_sz))
 			break;
 
@@ -263,7 +264,7 @@ static int mt7663s_tx_run_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 		if (err)
 			return err;
 	}
-	mt7663s_tx_update_quota(sdio, qid, pse_sz, ple_sz);
+	mt7663s_tx_update_quota(sdio, mcu, pse_sz, ple_sz);
 
 	mt76_worker_schedule(&sdio->status_worker);
 
@@ -286,7 +287,7 @@ void mt7663s_txrx_worker(struct mt76_worker *w)
 
 		/* tx */
 		for (i = 0; i < MT_TXQ_MCU_WA; i++) {
-			ret = mt7663s_tx_run_queue(dev, i);
+			ret = mt7663s_tx_run_queue(dev, dev->q_tx[i]);
 			if (ret > 0)
 				nframes += ret;
 		}
-- 
2.26.2

