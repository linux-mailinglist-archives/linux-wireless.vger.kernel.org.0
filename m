Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01436366CAF
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 15:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240785AbhDUNXF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 09:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242033AbhDUNWK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 09:22:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4863C61449;
        Wed, 21 Apr 2021 13:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619011297;
        bh=zOXAr3Q1KtzpoDr4Esv2LOBGC+ddOabULUn1BHX8T/k=;
        h=From:To:Cc:Subject:Date:From;
        b=nY0b4CHIsdXzaWXh2b3ZU0K3ng+jE5AqHe2vY4HH3fo0RPVFwJCmgvNDgsl7lg+/L
         r1Dj9Wf/sQLl85L5yiYEHEGMd8K6hPy3kHKMnEdHwfV0f3a9XE6czxw6nDrjdaGMy2
         ayHVBSvssNwBY1hsUdkdQjdKs9UsVmXJaPWOs0bIZ6/LucAV3yDi9Qu7MM4wBovqXC
         QEM6KkY/SrJwEkgXIQIaSlsl50PPhYdl/16/FOpjZI3A3y3BKHlYKfVp/xtsCbfV6s
         XfGmgbij9ljGcFloNS1nLTwoFd/Cv2Ap+i+DTg5UGAkfIHLdAKjOHaJISoMa7ZT15K
         9USKUIbVgnB2Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: move mt76_token_init in mt76_alloc_device
Date:   Wed, 21 Apr 2021 15:21:31 +0200
Message-Id: <b67abf2e685a9c6bae4bf89bcbeebf33184c674e.1619011246.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to remove duplicated code, move mt76_token_init in
mt76_alloc_device routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c        | 3 +++
 drivers/net/wireless/mediatek/mt76/mt76.h            | 1 -
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c | 2 --
 drivers/net/wireless/mediatek/mt76/mt7915/init.c     | 2 --
 drivers/net/wireless/mediatek/mt76/mt7921/init.c     | 1 -
 drivers/net/wireless/mediatek/mt76/tx.c              | 7 -------
 6 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 29ef15ec22fe..977acab0360a 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -428,6 +428,9 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	mutex_init(&dev->mcu.mutex);
 	dev->tx_worker.fn = mt76_tx_worker;
 
+	spin_lock_init(&dev->token_lock);
+	idr_init(&dev->token);
+
 	INIT_LIST_HEAD(&dev->txwi_cache);
 
 	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 3b09ea8176a3..36ede65919f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1220,7 +1220,6 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 struct mt76_txwi_cache *
 mt76_token_release(struct mt76_dev *dev, int token, bool *wake);
 int mt76_token_consume(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi);
-void mt76_token_init(struct mt76_dev *dev);
 void __mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked);
 
 static inline void mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index 5d174aa7f88d..ec8ec1a2033f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -40,8 +40,6 @@ static int mt7615_init_hardware(struct mt7615_dev *dev)
 	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
 
 	INIT_WORK(&dev->mcu_work, mt7615_pci_init_work);
-	mt76_token_init(&dev->mt76);
-
 	ret = mt7615_eeprom_init(dev, addr);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index c7e9808f228f..822f3aa6bb8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -351,8 +351,6 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
 
 	INIT_WORK(&dev->init_work, mt7915_init_work);
-	mt76_token_init(&dev->mt76);
-
 	dev->dbdc_support = !!(mt76_rr(dev, MT_HW_BOUND) & BIT(5));
 
 	/* If MCU was already running, it is likely in a bad state */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index c32fea6378af..fe28bf4050c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -170,7 +170,6 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
 {
 	int ret, idx;
 
-	mt76_token_init(&dev->mt76);
 	ret = mt7921_dma_init(dev);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 29a56f304aae..53ea8de82df0 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -649,13 +649,6 @@ void mt76_queue_tx_complete(struct mt76_dev *dev, struct mt76_queue *q,
 }
 EXPORT_SYMBOL_GPL(mt76_queue_tx_complete);
 
-void mt76_token_init(struct mt76_dev *dev)
-{
-	spin_lock_init(&dev->token_lock);
-	idr_init(&dev->token);
-}
-EXPORT_SYMBOL_GPL(mt76_token_init);
-
 void __mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked)
 {
 	struct mt76_phy *phy = &dev->phy, *phy2 = dev->phy2;
-- 
2.30.2

