Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242087CA39B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 11:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjJPJKc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 05:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjJPJK2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 05:10:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841D4E8
        for <linux-wireless@vger.kernel.org>; Mon, 16 Oct 2023 02:10:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6CCC433C8;
        Mon, 16 Oct 2023 09:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697447426;
        bh=QVBuf8VKzR45wwRH7dcKbMpTlYLf+mgePdedLmqcscc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYnzFkWabebRuBaqs5miGn6wuciR7jjaWhXcQkL5As1W93hmZH1Ga2nAdRYlTpDcW
         8KeS8I7+GQSVboAATpQHFZbn6RkFxsJREnUnkG1eUtg71/WxIqJtflrxpmYvsy+b9I
         j74/Q1PgLpPOh9odFC/Y1RH7BjNJiWMeo+RbnhCGtrSv1U0hmdUmB82Kvxsrw6m9ti
         7QXQOi3WqKOlFDrtXYAIf8jeRzkK2vCtMn8CwmOScUNUg8sKA+q4bOBsDHzeOY8TC9
         oUKvaT6OgFj7MDP4rthbOG/q4jkmeFbT7ZBf0X3dzdHCRRn4Pn4hGEIcilpSN21m03
         VqJjSZ7LpSVfg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 11/12] mt76: move wed reset common code in mt76 module
Date:   Mon, 16 Oct 2023 11:03:44 +0200
Message-ID: <395e3903652f74b8a23ec220c2ad7b78521a8843.1697445996.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697445995.git.lorenzo@kernel.org>
References: <cover.1697445995.git.lorenzo@kernel.org>
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

Move WED reset code shared between mt7915 and mt7996 in common module.
This is a preliminary patch to introduce WED reset support for mt7996.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c      | 14 ++++++++++
 drivers/net/wireless/mediatek/mt76/dma.h      |  9 ++++++
 drivers/net/wireless/mediatek/mt76/mmio.c     |  8 ++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 28 ++-----------------
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  9 +-----
 6 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index e60012a1896b..71f07deeeaab 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -1036,6 +1036,20 @@ void mt76_dma_attach(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_dma_attach);
 
+void mt76_dma_wed_reset(struct mt76_dev *dev)
+{
+	struct mt76_mmio *mmio = &dev->mmio;
+
+	if (!test_bit(MT76_STATE_WED_RESET, &dev->phy.state))
+		return;
+
+	complete(&mmio->wed_reset);
+
+	if (!wait_for_completion_timeout(&mmio->wed_reset_complete, 3 * HZ))
+		dev_err(dev->dev, "wed reset complete timeout\n");
+}
+EXPORT_SYMBOL_GPL(mt76_dma_wed_reset);
+
 void mt76_dma_cleanup(struct mt76_dev *dev)
 {
 	int i;
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index e549e678b69f..c60dfb817227 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -78,6 +78,15 @@ int mt76_dma_rx_poll(struct napi_struct *napi, int budget);
 void mt76_dma_attach(struct mt76_dev *dev);
 void mt76_dma_cleanup(struct mt76_dev *dev);
 int mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset);
+void mt76_dma_wed_reset(struct mt76_dev *dev);
+
+static inline void
+mt76_dma_reset_tx_queue(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	dev->queue_ops->reset_q(dev, q);
+	if (mtk_wed_device_active(&dev->mmio.wed))
+		mt76_dma_wed_setup(dev, q, true);
+}
 
 static inline void
 mt76_dma_should_drop_buf(bool *drop, u32 ctrl, u32 buf1, u32 info)
diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wireless/mediatek/mt76/mmio.c
index c34624978a14..4a006409a373 100644
--- a/drivers/net/wireless/mediatek/mt76/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mmio.c
@@ -179,6 +179,14 @@ void mt76_mmio_wed_offload_disable(struct mtk_wed_device *wed)
 	spin_unlock_bh(&dev->token_lock);
 }
 EXPORT_SYMBOL_GPL(mt76_mmio_wed_offload_disable);
+
+void mt76_mmio_wed_reset_complete(struct mtk_wed_device *wed)
+{
+	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+
+	complete(&dev->mmio.wed_reset_complete);
+}
+EXPORT_SYMBOL_GPL(mt76_mmio_wed_reset_complete);
 #endif /*CONFIG_NET_MEDIATEK_SOC_WED */
 
 void mt76_mmio_init(struct mt76_dev *dev, void __iomem *regs)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b6b1884276a0..413e33a7b16e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1102,6 +1102,7 @@ u32 mt76_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size);
 void mt76_mmio_wed_release_rx_buf(struct mtk_wed_device *wed);
 int mt76_mmio_wed_offload_enable(struct mtk_wed_device *wed);
 void mt76_mmio_wed_offload_disable(struct mtk_wed_device *wed);
+void mt76_mmio_wed_reset_complete(struct mtk_wed_device *wed);
 #endif /*CONFIG_NET_MEDIATEK_SOC_WED */
 
 #define mt76xx_chip(dev) mt76_chip(&((dev)->mt76))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 1bceeb5227b1..c91a1c54027f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -587,28 +587,6 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 	return 0;
 }
 
-static void mt7915_dma_wed_reset(struct mt7915_dev *dev)
-{
-	struct mt76_dev *mdev = &dev->mt76;
-
-	if (!test_bit(MT76_STATE_WED_RESET, &dev->mphy.state))
-		return;
-
-	complete(&mdev->mmio.wed_reset);
-
-	if (!wait_for_completion_timeout(&dev->mt76.mmio.wed_reset_complete,
-					 3 * HZ))
-		dev_err(dev->mt76.dev, "wed reset complete timeout\n");
-}
-
-static void
-mt7915_dma_reset_tx_queue(struct mt7915_dev *dev, struct mt76_queue *q)
-{
-	mt76_queue_reset(dev, q);
-	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
-		mt76_dma_wed_setup(&dev->mt76, q, true);
-}
-
 int mt7915_dma_reset(struct mt7915_dev *dev, bool force)
 {
 	struct mt76_phy *mphy_ext = dev->mt76.phys[MT_BAND1];
@@ -636,13 +614,13 @@ int mt7915_dma_reset(struct mt7915_dev *dev, bool force)
 		mtk_wed_device_dma_reset(wed);
 
 	mt7915_dma_disable(dev, force);
-	mt7915_dma_wed_reset(dev);
+	mt76_dma_wed_reset(&dev->mt76);
 
 	/* reset hw queues */
 	for (i = 0; i < __MT_TXQ_MAX; i++) {
-		mt7915_dma_reset_tx_queue(dev, dev->mphy.q_tx[i]);
+		mt76_dma_reset_tx_queue(&dev->mt76, dev->mphy.q_tx[i]);
 		if (mphy_ext)
-			mt7915_dma_reset_tx_queue(dev, mphy_ext->q_tx[i]);
+			mt76_dma_reset_tx_queue(&dev->mt76, mphy_ext->q_tx[i]);
 	}
 
 	for (i = 0; i < __MT_MCUQ_MAX; i++)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 85cb3fed9505..c404c90b58a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -595,13 +595,6 @@ static int mt7915_mmio_wed_reset(struct mtk_wed_device *wed)
 
 	return ret;
 }
-
-static void mt7915_mmio_wed_reset_complete(struct mtk_wed_device *wed)
-{
-	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
-
-	complete(&dev->mmio.wed_reset_complete);
-}
 #endif
 
 int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
@@ -685,7 +678,7 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 	wed->wlan.release_rx_buf = mt76_mmio_wed_release_rx_buf;
 	wed->wlan.update_wo_rx_stats = mt7915_mmio_wed_update_rx_stats;
 	wed->wlan.reset = mt7915_mmio_wed_reset;
-	wed->wlan.reset_complete = mt7915_mmio_wed_reset_complete;
+	wed->wlan.reset_complete = mt76_mmio_wed_reset_complete;
 
 	dev->mt76.rx_token_size = wed->wlan.rx_npkt;
 
-- 
2.41.0

