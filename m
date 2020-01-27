Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC1A14A9AF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 19:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgA0SR6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 13:17:58 -0500
Received: from nbd.name ([46.4.11.11]:48208 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbgA0SR5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 13:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=17hofFYQTtjNbqjxyYvhl99eulnsmz9UAg3bHRKU70c=; b=Uhw4JOGzeScetpkUexfLaw3kAF
        uVBwFOZGjqfFjKwhyyfcjvFNKWKuZTkLy11Ga1HSs+HNQGSSkuXQRpSa5HArvwRHnVSTC9WO3toFx
        4atVy1Ry5ckAvID63tbqJMT4cCBiARf+kZu/gWEW9qXr3NGtO4LF94pctw+yga0le8AU=;
Received: from [178.162.209.132] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iw8xP-0007dc-K4
        for linux-wireless@vger.kernel.org; Mon, 27 Jan 2020 19:17:55 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 207D17A566E4; Mon, 27 Jan 2020 19:17:54 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/5] mt76: fix handling full tx queues in mt76_dma_tx_queue_skb_raw
Date:   Mon, 27 Jan 2020 19:17:51 +0100
Message-Id: <20200127181754.2810-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200127181754.2810-1-nbd@nbd.name>
References: <20200127181754.2810-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes a theoretical issue where it could potentially overwrite an existing
descriptor entry (and leaking its skb)

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index e69329feed78..bcb11bb9aeeb 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -271,10 +271,13 @@ mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, enum mt76_txq_id qid,
 	struct mt76_queue_buf buf;
 	dma_addr_t addr;
 
+	if (q->queued + 1 >= q->ndesc - 1)
+		goto error;
+
 	addr = dma_map_single(dev->dev, skb->data, skb->len,
 			      DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(dev->dev, addr)))
-		return -ENOMEM;
+		goto error;
 
 	buf.addr = addr;
 	buf.len = skb->len;
@@ -285,6 +288,10 @@ mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, enum mt76_txq_id qid,
 	spin_unlock_bh(&q->lock);
 
 	return 0;
+
+error:
+	dev_kfree_skb(skb);
+	return -ENOMEM;
 }
 
 static int
-- 
2.24.0

