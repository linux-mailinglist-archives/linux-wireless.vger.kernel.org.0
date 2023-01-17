Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEE766DFD6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 15:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjAQODb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 09:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjAQODZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 09:03:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEAA39CDA
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 06:03:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09634B81188
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 14:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E5DC433EF;
        Tue, 17 Jan 2023 14:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673964200;
        bh=j1WBXjkpRVy8Ce7/G0GH1BdyVEDIVsDOUnYyyQViOto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kNYprwdr6m50sOZJz0Y2JTdfjeUVbcYzIoyFiSKZbaMZfk7QhUJLC0eO6ERFPa47+
         PKME2o58GeDqJpgKediiW01uT0KxuDbBJd6OdTIzbomtVCrrEThXtjmZJeZw4PQfe/
         EOuiAIrGlvetOj59anxZwteBH3JZpwK4xCRFjGryg9E6tgjVWvjhHfl2Wdmy4iRRz5
         GoLFyTm2vHZToS/H4x7UFLx1EE2dnhw9rl0n/4sJhdia1DnIRkvbwjbs87VqjCHGYP
         EgM3DIJ+4qYiabsvrjNeu9aO/gdF5oeXEMVbjrLvxDtzcbO8mvRyKZhwBauPf6spYm
         HA6vngozRJs5Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sujuan.chen@mediatek.com
Subject: [PATCH v2 4/4] wifi: mt76: mt7915: complete wed reset support
Date:   Tue, 17 Jan 2023 15:02:56 +0100
Message-Id: <329444b7decc3853d17488117d5df22cf4c39bad.1673963962.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673963962.git.lorenzo@kernel.org>
References: <cover.1673963962.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stop Wireless Ethernet Dispatcher during mt7915 reset procedure.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 30 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  6 ++++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index a956e2a0be4f..abe17dac9996 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -573,9 +573,18 @@ static void mt7915_dma_wed_reset(struct mt7915_dev *dev)
 		dev_err(dev->mt76.dev, "wed reset complete timeout\n");
 }
 
+static void
+mt7915_dma_reset_tx_queue(struct mt7915_dev *dev, struct mt76_queue *q)
+{
+	mt76_queue_reset(dev, q);
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
+		mt76_dma_wed_setup(&dev->mt76, q, true);
+}
+
 int mt7915_dma_reset(struct mt7915_dev *dev, bool force)
 {
 	struct mt76_phy *mphy_ext = dev->mt76.phys[MT_BAND1];
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 	int i;
 
 	/* clean up hw queues */
@@ -595,29 +604,40 @@ int mt7915_dma_reset(struct mt7915_dev *dev, bool force)
 	if (force)
 		mt7915_wfsys_reset(dev);
 
+	if (mtk_wed_device_active(wed))
+		mtk_wed_device_dma_reset(wed);
+
 	mt7915_dma_disable(dev, force);
 	mt7915_dma_wed_reset(dev);
 
 	/* reset hw queues */
 	for (i = 0; i < __MT_TXQ_MAX; i++) {
-		mt76_queue_reset(dev, dev->mphy.q_tx[i]);
+		mt7915_dma_reset_tx_queue(dev, dev->mphy.q_tx[i]);
 		if (mphy_ext)
-			mt76_queue_reset(dev, mphy_ext->q_tx[i]);
+			mt7915_dma_reset_tx_queue(dev, mphy_ext->q_tx[i]);
 	}
 
 	for (i = 0; i < __MT_MCUQ_MAX; i++)
 		mt76_queue_reset(dev, dev->mt76.q_mcu[i]);
 
-	mt76_for_each_q_rx(&dev->mt76, i)
+	mt76_for_each_q_rx(&dev->mt76, i) {
+		if (dev->mt76.q_rx[i].flags == MT_WED_Q_TXFREE)
+			continue;
+
 		mt76_queue_reset(dev, &dev->mt76.q_rx[i]);
+	}
 
 	mt76_tx_status_check(&dev->mt76, true);
 
-	mt7915_dma_enable(dev);
-
 	mt76_for_each_q_rx(&dev->mt76, i)
 		mt76_queue_rx_reset(dev, i);
 
+	if (mtk_wed_device_active(wed) && is_mt7915(&dev->mt76))
+		mt76_rmw(dev, MT_WFDMA0_EXT0_CFG, MT_WFDMA0_EXT0_RXWB_KEEP,
+			 MT_WFDMA0_EXT0_RXWB_KEEP);
+
+	mt7915_dma_enable(dev);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 65727ce6c29e..fb37b2a3274e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1581,6 +1581,12 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	if (!(READ_ONCE(dev->recovery.state) & MT_MCU_CMD_STOP_DMA))
 		return;
 
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+		mtk_wed_device_stop(&dev->mt76.mmio.wed);
+		if (!is_mt7986(&dev->mt76))
+			mt76_wr(dev, MT_INT_WED_MASK_CSR, 0);
+	}
+
 	ieee80211_stop_queues(mt76_hw(dev));
 	if (ext_phy)
 		ieee80211_stop_queues(ext_phy->hw);
-- 
2.39.0

