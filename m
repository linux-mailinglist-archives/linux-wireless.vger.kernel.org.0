Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC40D7AA1B3
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 23:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjIUVFq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 17:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjIUVFI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 17:05:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93D47EA29
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:37:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F19C36AE6;
        Thu, 21 Sep 2023 10:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695293040;
        bh=1K/xpj89LnsSxSnZRLe9XnU/8MgULN5QpqENtjkZBsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEkujMmgiC0A+uad+mha2O9eGGryG5/hjeM3Xy5afVELxgwF716aE7wL0nNJOBLSf
         FE1cl5SkI7I52ISHYB8P7UhXuVY25tlprAm9OGlKN6fhEtat20h5J8sF+WYF71Cc0G
         pNsaq8T9uj9P0nZ/8ZCwkbEuR8MEa8A0l4WwTqdBc5us34rQ/TnDY7a6sOqJQqYRUs
         UE1lJRt6PTFekJ0y3O09+pDMrTC7J8U6EkOdBdOqAb4AGG2zsZX2A21/oeLaRjh3zc
         qr8Wje4DDh7qfv5GtPc5vL0epYHn0oGBitRkB+jN/UFsP8OTxyX0L/ebe+w5XO/Rk8
         aVE6UyB+bdpKw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 4/9] wifi: mt76: introduce mt76_queue_is_wed_tx_free utility routine
Date:   Thu, 21 Sep 2023 12:43:33 +0200
Message-ID: <833b5d797b2da35fd42e59b0a8b193cf379d5d43.1695292502.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695292502.git.lorenzo@kernel.org>
References: <cover.1695292502.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to introduce WED support for mt7996

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c        | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt76.h       | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c | 2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 643e18ebb5ee..f62b6af4316b 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -724,7 +724,7 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	if (ret)
 		return ret;
 
-	if (q->flags != MT_WED_Q_TXFREE)
+	if (!mt76_queue_is_wed_tx_free(q))
 		mt76_dma_queue_reset(dev, q);
 
 	return 0;
@@ -773,7 +773,7 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 
 	/* reset WED rx queues */
 	mt76_dma_wed_setup(dev, q, true);
-	if (q->flags != MT_WED_Q_TXFREE) {
+	if (!mt76_queue_is_wed_tx_free(q)) {
 		mt76_dma_sync_idx(dev, q);
 		mt76_dma_rx_fill(dev, q, false);
 	}
@@ -816,7 +816,7 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 	bool more;
 
 	if (IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED) &&
-	    q->flags == MT_WED_Q_TXFREE) {
+	    mt76_queue_is_wed_tx_free(q)) {
 		dma_idx = Q_READ(dev, q, dma_idx);
 		check_ddone = true;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e8e9d9bc3730..4ce3a0def8fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1555,6 +1555,12 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 			      struct mt76_power_limits *dest,
 			      s8 target_power);
 
+static inline bool mt76_queue_is_wed_tx_free(struct mt76_queue *q)
+{
+	return (q->flags & MT_QFLAG_WED) &&
+	       FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_TXFREE;
+}
+
 static inline bool mt76_queue_is_wed_rx(struct mt76_queue *q)
 {
 	return (q->flags & MT_QFLAG_WED) &&
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 59a44d79aaed..96b2c3802ac1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -643,7 +643,7 @@ int mt7915_dma_reset(struct mt7915_dev *dev, bool force)
 		mt76_queue_reset(dev, dev->mt76.q_mcu[i]);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
-		if (dev->mt76.q_rx[i].flags == MT_WED_Q_TXFREE)
+		if (mt76_queue_is_wed_tx_free(&dev->mt76.q_rx[i]))
 			continue;
 
 		mt76_queue_reset(dev, &dev->mt76.q_rx[i]);
-- 
2.41.0

