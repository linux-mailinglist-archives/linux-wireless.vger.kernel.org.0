Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9338325E6B2
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Sep 2020 11:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIEJ0V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Sep 2020 05:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgIEJ0V (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Sep 2020 05:26:21 -0400
Received: from localhost.localdomain (unknown [151.66.86.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88366206A5;
        Sat,  5 Sep 2020 09:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599297980;
        bh=ITisLbejlUiuih/wCCOSMvzBUU8yH0x6BvFqlT9mogE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ggOKeUqQ416N0smwXyxduWat/5bBfX7QuRBJKIy6N08sVMNxIm6raTFWYiVPmfF9
         djHMOp3I5gMU51aeDceVpSgWNIHQ1MMs0XAQtsvdf1utN/FNmewnRQhps/YNt1KQdl
         rp5Ca/Lz2qq8WoGI8tmkQB3qYw4QXuyP9KU3m9Lg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 3/7] mt76: mt7663s: introduce __mt7663s_xmit_queue routine
Date:   Sat,  5 Sep 2020 11:26:03 +0200
Message-Id: <170fde26f917b16879ae711eab65b4b47c822183.1599297449.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599297449.git.lorenzo@kernel.org>
References: <cover.1599297449.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to introduce sdio tx aggregation

Tested-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 35 ++++++++++++-------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index ced7820021c2..ebae2a24c45b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -158,6 +158,24 @@ static void mt7663s_tx_update_quota(struct mt76_sdio *sdio, enum mt76_txq_id qid
 	mutex_unlock(&sdio->sched.lock);
 }
 
+static int __mt7663s_xmit_queue(struct mt76_dev *dev, u8 *data, int len)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+	int err;
+
+	if (len > sdio->func->cur_blksize)
+		len = roundup(len, sdio->func->cur_blksize);
+
+	sdio_claim_host(sdio->func);
+	err = sdio_writesb(sdio->func, MCR_WTDR1, data, len);
+	sdio_release_host(sdio->func);
+
+	if (err)
+		dev_err(dev->dev, "sdio write failed: %d\n", err);
+
+	return err;
+}
+
 static int mt7663s_tx_run_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 {
 	int nframes = 0, pse_sz = 0, ple_sz = 0;
@@ -166,24 +184,15 @@ static int mt7663s_tx_run_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 
 	while (q->first != q->head) {
 		struct mt76_queue_entry *e = &q->entry[q->first];
-		int err, len = e->skb->len;
+		int err;
 
 		if (mt7663s_tx_pick_quota(dev, qid, e->buf_sz, &pse_sz,
 					  &ple_sz))
 			break;
 
-		if (len > sdio->func->cur_blksize)
-			len = roundup(len, sdio->func->cur_blksize);
-
-		/* TODO: skb_walk_frags and then write to SDIO port */
-		sdio_claim_host(sdio->func);
-		err = sdio_writesb(sdio->func, MCR_WTDR1, e->skb->data, len);
-		sdio_release_host(sdio->func);
-
-		if (err) {
-			dev_err(dev->dev, "sdio write failed: %d\n", err);
-			return -EIO;
-		}
+		err = __mt7663s_xmit_queue(dev, e->skb->data, e->skb->len);
+		if (err)
+			return err;
 
 		e->done = true;
 		q->first = (q->first + 1) % q->ndesc;
-- 
2.26.2

