Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A81232FB6
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 11:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgG3JjG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 05:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgG3JjG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 05:39:06 -0400
Received: from lore-desk.redhat.com (unknown [151.48.137.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E2332075F;
        Thu, 30 Jul 2020 09:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596101946;
        bh=LHiwMNvPrrk+GqsIver34TeFJTqsOMZjKbtwJWMKa4Q=;
        h=From:To:Cc:Subject:Date:From;
        b=trLp4Gwi4LUQaTHUdM4pAYgWDKAJTyQ1FxgPLQ2XPOrDqafiD1kBXiuvZug5RQoaB
         ndR5VF/zRmUXsahetRkdphAfGWeOrUJBxuJW/eCKEAd8zx9fPdUUL4T2nLzEMe1FW4
         rANT/QMnmJXvN2a+jDPz/zNXccr81b/eczdNsTUw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt76s: fix oom in mt76s_tx_queue_skb_raw
Date:   Thu, 30 Jul 2020 11:38:46 +0200
Message-Id: <368c78ef79cb6782008b33a87d73b5fc51ba2989.1596101881.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Free the mcu skb in case of error in mt76s_tx_queue_skb_raw routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/sdio.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index d2b38ed7f3b4..5d8353026aaf 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -244,22 +244,27 @@ mt76s_tx_queue_skb_raw(struct mt76_dev *dev, enum mt76_txq_id qid,
 	struct mt76_queue *q = dev->q_tx[qid].q;
 	int ret = -ENOSPC, len = skb->len;
 
-	spin_lock_bh(&q->lock);
 	if (q->queued == q->ndesc)
-		goto out;
+		goto error;
 
 	ret = mt76_skb_adjust_pad(skb);
 	if (ret)
-		goto out;
+		goto error;
+
+	spin_lock_bh(&q->lock);
 
 	q->entry[q->tail].buf_sz = len;
 	q->entry[q->tail].skb = skb;
 	q->tail = (q->tail + 1) % q->ndesc;
 	q->queued++;
 
-out:
 	spin_unlock_bh(&q->lock);
 
+	return 0;
+
+error:
+	dev_kfree_skb(skb);
+
 	return ret;
 }
 
-- 
2.26.2

