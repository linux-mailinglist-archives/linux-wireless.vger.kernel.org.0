Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCDE55975C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jun 2022 12:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiFXKIj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jun 2022 06:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiFXKIi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jun 2022 06:08:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F037A1B5
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jun 2022 03:08:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 477C262171
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jun 2022 10:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B30C34114;
        Fri, 24 Jun 2022 10:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656065316;
        bh=BwW6FdOriPLLQPp3lvfySq2RxZW2UsanThr71a0rSdc=;
        h=From:To:Cc:Subject:Date:From;
        b=LqfnK2tbsYCrTfmqMVmthLl1iWF+9WjomdtujmvLYOkva6i1LugaOv9v6yITG0p6T
         ywggUHPO+KAGuW5UuwUb/VKFcT+xS0pYGlZPOKEntF9LnYSC83+2BehoT+vkZkkb+I
         mVufkkv9uOehZV27ETTtWvj7f5Wa2Lolk3v0NCELeasc+8mWZBa3beb0RRT6H0LG5N
         9XEVVf4iRd7OuGkmtepAU/X15MUAtuR2zS/v9saxuBTetmUuwb1mJTrgmhK1d5AdbK
         dwTyHqp0UsyEXPA6i+AtLMnbSPtVdNXNoPBGf+PL4o7OB1CyprjYpiswmph5A0nQP6
         YjjXKCdRE2lRg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: connac: move tx initialization/cleanup in mt76_connac module
Date:   Fri, 24 Jun 2022 12:08:29 +0200
Message-Id: <914394892be54368b4b6067b157ccf7e18db3470.1656065243.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_connac_init_tx_queues and mt76_connac_tx_cleanup routines
in mt76_connac module. This is a preliminary patch to add mt7990
chipset support.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  9 +++-----
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  8 +++++++
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 16 ++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 22 +++----------------
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 21 ++++--------------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  2 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  6 -----
 7 files changed, 35 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index ce19f57de475..f1914431ff7f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -44,7 +44,7 @@ mt7622_init_tx_queues_multi(struct mt7615_dev *dev)
 static int
 mt7615_init_tx_queues(struct mt7615_dev *dev)
 {
-	int ret, i;
+	int ret;
 
 	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_FWDL, MT7615_TXQ_FWDL,
 				  MT7615_TX_FWDL_RING_SIZE, MT_TX_RING_BASE);
@@ -54,14 +54,11 @@ mt7615_init_tx_queues(struct mt7615_dev *dev)
 	if (!is_mt7615(&dev->mt76))
 		return mt7622_init_tx_queues_multi(dev);
 
-	ret = mt76_init_tx_queue(&dev->mphy, 0, 0, MT7615_TX_RING_SIZE,
-				 MT_TX_RING_BASE, 0);
+	ret = mt76_connac_init_tx_queues(&dev->mphy, 0, MT7615_TX_RING_SIZE,
+					 MT_TX_RING_BASE, 0);
 	if (ret)
 		return ret;
 
-	for (i = 1; i <= MT_TXQ_PSD ; i++)
-		dev->mphy.q_tx[i] = dev->mphy.q_tx[0];
-
 	return mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM, MT7615_TXQ_MCU,
 				   MT7615_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 1d32d55ba587..386d5572681d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -261,6 +261,12 @@ void mt76_connac_power_save_sched(struct mt76_phy *phy,
 void mt76_connac_free_pending_tx_skbs(struct mt76_connac_pm *pm,
 				      struct mt76_wcid *wcid);
 
+static inline void mt76_connac_tx_cleanup(struct mt76_dev *dev)
+{
+	dev->queue_ops->tx_cleanup(dev, dev->q_mcu[MT_MCUQ_WM], false);
+	dev->queue_ops->tx_cleanup(dev, dev->q_mcu[MT_MCUQ_WA], false);
+}
+
 static inline bool
 mt76_connac_pm_ref(struct mt76_phy *phy, struct mt76_connac_pm *pm)
 {
@@ -323,6 +329,8 @@ mt76_connac_mutex_release(struct mt76_dev *dev, struct mt76_connac_pm *pm)
 	mutex_unlock(&dev->mutex);
 }
 
+int mt76_connac_init_tx_queues(struct mt76_phy *phy, int idx, int n_desc,
+			       int ring_base, u32 flags);
 void mt76_connac_write_hw_txp(struct mt76_dev *dev,
 			      struct mt76_tx_info *tx_info,
 			      void *txp_ptr, u32 id);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index af2b33d738ca..e8a9976b4a48 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -251,6 +251,22 @@ void mt76_connac_txp_skb_unmap(struct mt76_dev *dev,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_txp_skb_unmap);
 
+int mt76_connac_init_tx_queues(struct mt76_phy *phy, int idx, int n_desc,
+			       int ring_base, u32 flags)
+{
+	int i, err;
+
+	err = mt76_init_tx_queue(phy, 0, idx, n_desc, ring_base, flags);
+	if (err < 0)
+		return err;
+
+	for (i = 1; i <= MT_TXQ_PSD; i++)
+		phy->q_tx[i] = phy->q_tx[0];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_init_tx_queues);
+
 static u16
 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 			     bool beacon, bool mcast)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index f3d608d2d3b2..1c662e89b870 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -9,29 +9,14 @@ static int
 mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc, int ring_base)
 {
 	struct mt7915_dev *dev = phy->dev;
-	int i, err;
 
 	if (mtk_wed_device_active(&phy->dev->mt76.mmio.wed)) {
 		ring_base = MT_WED_TX_RING_BASE;
 		idx -= MT_TXQ_ID(0);
 	}
 
-	err = mt76_init_tx_queue(phy->mt76, 0, idx, n_desc, ring_base,
-				 MT_WED_Q_TX(idx));
-	if (err < 0)
-		return err;
-
-	for (i = 0; i <= MT_TXQ_PSD; i++)
-		phy->mt76->q_tx[i] = phy->mt76->q_tx[0];
-
-	return 0;
-}
-
-static void
-mt7915_tx_cleanup(struct mt7915_dev *dev)
-{
-	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], false);
-	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WA], false);
+	return mt76_connac_init_tx_queues(phy->mt76, idx, n_desc, ring_base,
+					  MT_WED_Q_TX(idx));
 }
 
 static int mt7915_poll_tx(struct napi_struct *napi, int budget)
@@ -40,8 +25,7 @@ static int mt7915_poll_tx(struct napi_struct *napi, int budget)
 
 	dev = container_of(napi, struct mt7915_dev, mt76.tx_napi);
 
-	mt7915_tx_cleanup(dev);
-
+	mt76_connac_tx_cleanup(&dev->mt76);
 	if (napi_complete_done(napi, 0))
 		mt7915_irq_enable(dev, MT_INT_TX_DONE_MCU);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 3a6b158b779e..d1f10f6d9adc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -5,20 +5,6 @@
 #include "../dma.h"
 #include "mac.h"
 
-static int mt7921_init_tx_queues(struct mt7921_phy *phy, int idx, int n_desc)
-{
-	int i, err;
-
-	err = mt76_init_tx_queue(phy->mt76, 0, idx, n_desc, MT_TX_RING_BASE, 0);
-	if (err < 0)
-		return err;
-
-	for (i = 0; i <= MT_TXQ_PSD; i++)
-		phy->mt76->q_tx[i] = phy->mt76->q_tx[0];
-
-	return 0;
-}
-
 static int mt7921_poll_tx(struct napi_struct *napi, int budget)
 {
 	struct mt7921_dev *dev;
@@ -31,7 +17,7 @@ static int mt7921_poll_tx(struct napi_struct *napi, int budget)
 		return 0;
 	}
 
-	mt7921_mcu_tx_cleanup(dev);
+	mt76_connac_tx_cleanup(&dev->mt76);
 	if (napi_complete(napi))
 		mt7921_irq_enable(dev, MT_INT_TX_DONE_ALL);
 	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
@@ -250,8 +236,9 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 		return ret;
 
 	/* init tx queue */
-	ret = mt7921_init_tx_queues(&dev->phy, MT7921_TXQ_BAND0,
-				    MT7921_TX_RING_SIZE);
+	ret = mt76_connac_init_tx_queues(dev->phy.mt76, MT7921_TXQ_BAND0,
+					 MT7921_TX_RING_SIZE,
+					 MT_TX_RING_BASE, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index eb1bfb682e02..160805661208 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -894,7 +894,7 @@ void mt7921_pm_wake_work(struct work_struct *work)
 				napi_schedule(&mdev->napi[i]);
 			local_bh_enable();
 			mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
-			mt7921_mcu_tx_cleanup(dev);
+			mt76_connac_tx_cleanup(mdev);
 		}
 		if (test_bit(MT76_STATE_RUNNING, &mphy->state))
 			ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index d2d45f381232..c161031ac62a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -345,12 +345,6 @@ static inline bool mt7921_dma_need_reinit(struct mt7921_dev *dev)
 	return !mt76_get_field(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
 }
 
-static inline void mt7921_mcu_tx_cleanup(struct mt7921_dev *dev)
-{
-	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], false);
-	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WA], false);
-}
-
 static inline void
 mt7921_skb_add_usb_sdio_hdr(struct mt7921_dev *dev, struct sk_buff *skb,
 			    int type)
-- 
2.36.1

