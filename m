Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AD525E6B1
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Sep 2020 11:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgIEJ0U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Sep 2020 05:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgIEJ0T (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Sep 2020 05:26:19 -0400
Received: from localhost.localdomain (unknown [151.66.86.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3061C2074D;
        Sat,  5 Sep 2020 09:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599297979;
        bh=UTUHADceGk7tGOfdh19s7KlsrTlbiIJjRi5v30pbPis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLcWvqI/vaoBZjjIbZFlAUR3zN2MlaqR+JqpNes7SetaN/lslyZy6gvuyrmKeaTjW
         yJ4ikSUiSZlKL9uFt2w0BPr0mr5w+wzQBgLXJ9ULbH80DoKgNZDYspr6Pr/4oIwE+0
         czThBpe6UjGHvbw/Rt1tzS+DESvh9qb5RYAp4jF8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 2/7] mt76: mt7663s: split mt7663s_tx_update_sched in mt7663s_tx_{pick,update}_quota
Date:   Sat,  5 Sep 2020 11:26:02 +0200
Message-Id: <9e4e66e8ac3b6e41095c805317a2588dc5f4b5d6.1599297449.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599297449.git.lorenzo@kernel.org>
References: <cover.1599297449.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to not update the available quota in case of a tx error, split
mt7663s_tx_update_sched in mt7663s_tx_{pick,update}_quota routines

Tested-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 56 ++++++++++---------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index b2b528cba7f1..ced7820021c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -119,52 +119,57 @@ static int mt7663s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 	return i;
 }
 
-static int mt7663s_tx_update_sched(struct mt76_dev *dev,
-				   struct mt76_queue_entry *e,
-				   bool mcu)
+static int mt7663s_tx_pick_quota(struct mt76_dev *dev, enum mt76_txq_id qid,
+				 int buf_sz, int *pse_size, int *ple_size)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
-	int size, ret = -EBUSY;
+	int pse_sz;
 
 	if (!test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))
 		return 0;
 
-	size = DIV_ROUND_UP(e->buf_sz + sdio->sched.deficit, MT_PSE_PAGE_SZ);
+	pse_sz = DIV_ROUND_UP(buf_sz + sdio->sched.deficit, MT_PSE_PAGE_SZ);
 
-	if (mcu) {
-		mutex_lock(&sdio->sched.lock);
-		if (sdio->sched.pse_mcu_quota > size) {
-			sdio->sched.pse_mcu_quota -= size;
-			ret = 0;
-		}
-		mutex_unlock(&sdio->sched.lock);
+	if (qid == MT_TXQ_MCU) {
+		if (sdio->sched.pse_mcu_quota < *pse_size + pse_sz)
+			return -EBUSY;
+	} else {
+		if (sdio->sched.pse_data_quota < *pse_size + pse_sz ||
+		    sdio->sched.ple_data_quota < *ple_size)
+			return -EBUSY;
 
-		return ret;
+		*ple_size = *ple_size + 1;
 	}
+	*pse_size = *pse_size + pse_sz;
+
+	return 0;
+}
 
+static void mt7663s_tx_update_quota(struct mt76_sdio *sdio, enum mt76_txq_id qid,
+				    int pse_size, int ple_size)
+{
 	mutex_lock(&sdio->sched.lock);
-	if (sdio->sched.pse_data_quota > size &&
-	    sdio->sched.ple_data_quota > 0) {
-		sdio->sched.pse_data_quota -= size;
-		sdio->sched.ple_data_quota--;
-		ret = 0;
+	if (qid == MT_TXQ_MCU) {
+		sdio->sched.pse_mcu_quota -= pse_size;
+	} else {
+		sdio->sched.pse_data_quota -= pse_size;
+		sdio->sched.ple_data_quota -= ple_size;
 	}
 	mutex_unlock(&sdio->sched.lock);
-
-	return ret;
 }
 
-static int mt7663s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
+static int mt7663s_tx_run_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 {
-	bool mcu = q == dev->q_tx[MT_TXQ_MCU];
+	int nframes = 0, pse_sz = 0, ple_sz = 0;
+	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_sdio *sdio = &dev->sdio;
-	int nframes = 0;
 
 	while (q->first != q->head) {
 		struct mt76_queue_entry *e = &q->entry[q->first];
 		int err, len = e->skb->len;
 
-		if (mt7663s_tx_update_sched(dev, e, mcu))
+		if (mt7663s_tx_pick_quota(dev, qid, e->buf_sz, &pse_sz,
+					  &ple_sz))
 			break;
 
 		if (len > sdio->func->cur_blksize)
@@ -184,6 +189,7 @@ static int mt7663s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 		q->first = (q->first + 1) % q->ndesc;
 		nframes++;
 	}
+	mt7663s_tx_update_quota(sdio, qid, pse_sz, ple_sz);
 
 	return nframes;
 }
@@ -198,7 +204,7 @@ void mt7663s_tx_work(struct work_struct *work)
 	for (i = 0; i < MT_TXQ_MCU_WA; i++) {
 		int ret;
 
-		ret = mt7663s_tx_run_queue(dev, dev->q_tx[i]);
+		ret = mt7663s_tx_run_queue(dev, i);
 		if (ret < 0)
 			break;
 
-- 
2.26.2

