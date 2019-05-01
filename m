Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1323108C5
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 16:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfEAOGh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 10:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfEAOGh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 10:06:37 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CDFA2177B;
        Wed,  1 May 2019 14:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556719596;
        bh=mgtc3MOin15I+yHRQaZ5sR0wyjYRiNmVDrijmmulnWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+cHBoszSzbf6XIgzGArT5BXfyaBWH5FaqcsgOvgBvOu4EwTlf1JtowuyGp5pOeU4
         8l/cQThP60d7CLds0VDoZW0dvSaeoUyRYLKsh7zLrZG515kR4esRxDINH1Jq2NjCJy
         sDN60x07VMwX4gy6mV8znQj5erzSjGBTYfP4+cKI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 4/4] mt76: move netif_napi_del in mt76_dma_cleanup
Date:   Wed,  1 May 2019 16:06:23 +0200
Message-Id: <ef756f78fca5f55a8ccf0e1cfe9e4f430466654e.1556718795.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556718795.git.lorenzo@kernel.org>
References: <cover.1556718795.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move netif_napi_del in mt76_dma_cleanup routine since it is done
by all drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c          | 1 +
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c   | 1 -
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c   | 1 -
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 1 -
 4 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 4381155375e1..d8f61e540bfd 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -588,6 +588,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 {
 	int i;
 
+	netif_napi_del(&dev->tx_napi);
 	for (i = 0; i < ARRAY_SIZE(dev->q_tx); i++)
 		mt76_dma_tx_cleanup(dev, i, true);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 54314f6803c5..58dc511f93c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -250,6 +250,5 @@ void mt7603_dma_cleanup(struct mt7603_dev *dev)
 		   MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE);
 
 	tasklet_kill(&dev->mt76.tx_tasklet);
-	netif_napi_del(&dev->mt76.tx_napi);
 	mt76_dma_cleanup(&dev->mt76);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 9c565c93988a..6a70273d4a69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -220,6 +220,5 @@ void mt7615_dma_cleanup(struct mt7615_dev *dev)
 	mt76_set(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_SW_RESET);
 
 	tasklet_kill(&dev->mt76.tx_tasklet);
-	netif_napi_del(&dev->mt76.tx_napi);
 	mt76_dma_cleanup(&dev->mt76);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 617934565818..467b28379870 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -335,7 +335,6 @@ static void mt76x02_dma_enable(struct mt76x02_dev *dev)
 void mt76x02_dma_cleanup(struct mt76x02_dev *dev)
 {
 	tasklet_kill(&dev->mt76.tx_tasklet);
-	netif_napi_del(&dev->mt76.tx_napi);
 	mt76_dma_cleanup(&dev->mt76);
 }
 EXPORT_SYMBOL_GPL(mt76x02_dma_cleanup);
-- 
2.20.1

