Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33B2C9FDC9
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 11:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfH1JB7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Aug 2019 05:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfH1JB7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Aug 2019 05:01:59 -0400
Received: from localhost.localdomain (unknown [151.66.62.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C94E02173E;
        Wed, 28 Aug 2019 09:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566982918;
        bh=P+C97dr/137EFnzJNj1mSeHDHSecOowv+CYRHPhZgm0=;
        h=From:To:Cc:Subject:Date:From;
        b=2Z3G7vh3je635Vl7FiIO4j77bXLcDy4MHl1IV4oUbd4Rnvtw496KvPiatnXMDx0Ha
         Z8DR4OSJuPqWmFeVw+uLDWxJWlxIuX/DNlsakxIAoXrIVaJqlVD7TyjtDtXjmDlMMr
         Mk7uiXTJNt6hpaRfKp3IFzCRw1I+r2waHZl1KTyY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: introduce mt7615_txwi_to_txp utility routine
Date:   Wed, 28 Aug 2019 11:01:40 +0200
Message-Id: <dc0c2f3853ec9b0ca82d15b7f371e74cba3476c1.1566982809.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_txwi_to_txp utility routine to convert mt76_txwi_cache
into mt7615_txp and remove duplicated code

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c |  8 ++------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h | 13 +++++++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index c35c386ea6bd..e07ce2c10013 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -232,11 +232,9 @@ void mt7615_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
 		struct mt76_txwi_cache *t;
 		struct mt7615_dev *dev;
 		struct mt7615_txp *txp;
-		u8 *txwi_ptr;
 
-		txwi_ptr = mt76_get_txwi_ptr(mdev, e->txwi);
-		txp = (struct mt7615_txp *)(txwi_ptr + MT_TXD_SIZE);
 		dev = container_of(mdev, struct mt7615_dev, mt76);
+		txp = mt7615_txwi_to_txp(mdev, e->txwi);
 
 		spin_lock_bh(&dev->token_lock);
 		t = idr_remove(&dev->token, le16_to_cpu(txp->token));
@@ -449,11 +447,9 @@ void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 			  struct mt76_txwi_cache *t)
 {
 	struct mt7615_txp *txp;
-	u8 *txwi;
 	int i;
 
-	txwi = mt76_get_txwi_ptr(dev, t);
-	txp = (struct mt7615_txp *)(txwi + MT_TXD_SIZE);
+	txp = mt7615_txwi_to_txp(dev, t);
 	for (i = 1; i < txp->nbuf; i++)
 		dma_unmap_single(dev->dev, le32_to_cpu(txp->buf[i]),
 				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index 051b540e79fd..38695d4f92e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -317,4 +317,17 @@ enum mt7615_cipher_type {
 	MT_CIPHER_GCMP_256,
 };
 
+static inline struct mt7615_txp *
+mt7615_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
+{
+	u8 *txwi;
+
+	if (!t)
+		return NULL;
+
+	txwi = mt76_get_txwi_ptr(dev, t);
+
+	return (struct mt7615_txp *)(txwi + MT_TXD_SIZE);
+}
+
 #endif
-- 
2.21.0

