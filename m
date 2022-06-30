Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54C1561D5E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jun 2022 16:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbiF3ON3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jun 2022 10:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237136AbiF3OMk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jun 2022 10:12:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6107E003
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jun 2022 06:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B19261F60
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jun 2022 13:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D6BC34115;
        Thu, 30 Jun 2022 13:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656597393;
        bh=KpelXScaL3E3OeSyaO85gEzaS5pyTC1ageXv8kJa5NU=;
        h=From:To:Cc:Subject:Date:From;
        b=esqcfWkD5MUW9jFHMMR1nkRDbLyW7c2kkEYk/2ZRZl2H3g2RGshANbUxEqj0mDquC
         GxBBPtOLAMxU3AVKhWKxTjG4LCGgDIo5bgezqeOmC6wQ8BNuhaRQBHINdB1Maxp3BE
         qazATeQ4/BnPjGAdNUGMFDmIYcSHiDl5enF+lNxXo6/h9CC1CqEkCrAAzuNVN2V/VA
         A3FmwZYfMhBp+x10775n2/JwOMCexIc9ROW6mTL5EPrZQIKgIg+ngAxMcmcNoVCpGi
         3E7auhnuJ/wStsnvXTKoS++ngIhSRXhIaga4ELCPivqp+4yKVJz2MVHMAvyaqP/Fs7
         9OgG0LtoDX5KA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: introduce MT_RXQ_BAND2 and MT_RXQ_BAND2_WA in mt76_rxq_id
Date:   Thu, 30 Jun 2022 15:56:13 +0200
Message-Id: <800064e25e42e840de23088ac5578c89740aa2e2.1656597132.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rename MT_RXQ_EXT in MT_RXQ_BAND1.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  6 ++-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 47 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  8 ++--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  8 ++--
 .../wireless/mediatek/mt76/mt7915/testmode.c  |  2 +-
 6 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index bae1ec34e721..6b4150c54b96 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -99,9 +99,11 @@ enum mt76_rxq_id {
 	MT_RXQ_MAIN,
 	MT_RXQ_MCU,
 	MT_RXQ_MCU_WA,
-	MT_RXQ_EXT,
-	MT_RXQ_EXT_WA,
+	MT_RXQ_BAND1,
+	MT_RXQ_BAND1_WA,
 	MT_RXQ_MAIN_WA,
+	MT_RXQ_BAND2,
+	MT_RXQ_BAND2_WA,
 	__MT_RXQ_MAX
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 1c662e89b870..00aafc2422f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -49,8 +49,8 @@ static void mt7915_dma_config(struct mt7915_dev *dev)
 		RXQ_CONFIG(MT_RXQ_MAIN, WFDMA0, MT_INT_RX_DONE_BAND0, MT7915_RXQ_BAND0);
 		RXQ_CONFIG(MT_RXQ_MCU, WFDMA1, MT_INT_RX_DONE_WM, MT7915_RXQ_MCU_WM);
 		RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA1, MT_INT_RX_DONE_WA, MT7915_RXQ_MCU_WA);
-		RXQ_CONFIG(MT_RXQ_EXT, WFDMA0, MT_INT_RX_DONE_BAND1, MT7915_RXQ_BAND1);
-		RXQ_CONFIG(MT_RXQ_EXT_WA, WFDMA1, MT_INT_RX_DONE_WA_EXT, MT7915_RXQ_MCU_WA_EXT);
+		RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_RX_DONE_BAND1, MT7915_RXQ_BAND1);
+		RXQ_CONFIG(MT_RXQ_BAND1_WA, WFDMA1, MT_INT_RX_DONE_WA_EXT, MT7915_RXQ_MCU_WA_EXT);
 		RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA1, MT_INT_RX_DONE_WA_MAIN, MT7915_RXQ_MCU_WA);
 		TXQ_CONFIG(0, WFDMA1, MT_INT_TX_DONE_BAND0, MT7915_TXQ_BAND0);
 		TXQ_CONFIG(1, WFDMA1, MT_INT_TX_DONE_BAND1, MT7915_TXQ_BAND1);
@@ -61,8 +61,8 @@ static void mt7915_dma_config(struct mt7915_dev *dev)
 		RXQ_CONFIG(MT_RXQ_MAIN, WFDMA0, MT_INT_RX_DONE_BAND0_MT7916, MT7916_RXQ_BAND0);
 		RXQ_CONFIG(MT_RXQ_MCU, WFDMA0, MT_INT_RX_DONE_WM, MT7916_RXQ_MCU_WM);
 		RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA0, MT_INT_RX_DONE_WA, MT7916_RXQ_MCU_WA);
-		RXQ_CONFIG(MT_RXQ_EXT, WFDMA0, MT_INT_RX_DONE_BAND1_MT7916, MT7916_RXQ_BAND1);
-		RXQ_CONFIG(MT_RXQ_EXT_WA, WFDMA0, MT_INT_RX_DONE_WA_EXT_MT7916, MT7916_RXQ_MCU_WA_EXT);
+		RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_RX_DONE_BAND1_MT7916, MT7916_RXQ_BAND1);
+		RXQ_CONFIG(MT_RXQ_BAND1_WA, WFDMA0, MT_INT_RX_DONE_WA_EXT_MT7916, MT7916_RXQ_MCU_WA_EXT);
 		RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA0, MT_INT_RX_DONE_WA_MAIN_MT7916, MT7916_RXQ_MCU_WA_MAIN);
 		TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0, MT7915_TXQ_BAND0);
 		TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1, MT7915_TXQ_BAND1);
@@ -84,24 +84,33 @@ static void __mt7915_dma_prefetch(struct mt7915_dev *dev, u32 ofs)
 	mt76_wr(dev, MT_TXQ_EXT_CTRL(1) + ofs, PREFETCH(0xc0, 0x4));
 	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WA) + ofs, PREFETCH(0x100, 0x4));
 
-	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MCU) + ofs, PREFETCH(0x140, 0x4));
-	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MCU_WA) + ofs, PREFETCH(0x180, 0x4));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MCU) + ofs,
+		PREFETCH(0x140, 0x4));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MCU_WA) + ofs,
+		PREFETCH(0x180, 0x4));
 	if (!is_mt7915(&dev->mt76)) {
-		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MAIN_WA) + ofs, PREFETCH(0x1c0, 0x4));
+		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MAIN_WA) + ofs,
+			PREFETCH(0x1c0, 0x4));
 		base = 0x40;
 	}
-	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT_WA) + ofs, PREFETCH(0x1c0 + base, 0x4));
-	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MAIN) + ofs, PREFETCH(0x200 + base, 0x4));
-	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT) + ofs, PREFETCH(0x240 + base, 0x4));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_BAND1_WA) + ofs,
+		PREFETCH(0x1c0 + base, 0x4));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MAIN) + ofs,
+		PREFETCH(0x200 + base, 0x4));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_BAND1) + ofs,
+		PREFETCH(0x240 + base, 0x4));
 
 	/* for mt7915, the ring which is next the last
 	 * used ring must be initialized.
 	 */
 	if (is_mt7915(&dev->mt76)) {
 		ofs += 0x4;
-		mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WA) + ofs, PREFETCH(0x140, 0x0));
-		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT_WA) + ofs, PREFETCH(0x200 + base, 0x0));
-		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT) + ofs, PREFETCH(0x280 + base, 0x0));
+		mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WA) + ofs,
+			PREFETCH(0x140, 0x0));
+		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_BAND1_WA) + ofs,
+			PREFETCH(0x200 + base, 0x0));
+		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_BAND1) + ofs,
+			PREFETCH(0x280 + base, 0x0));
 	}
 }
 
@@ -439,20 +448,20 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 
 	if (dev->dbdc_support || dev->phy.band_idx) {
 		/* rx data queue for band1 */
-		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_EXT],
-				       MT_RXQ_ID(MT_RXQ_EXT),
+		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_BAND1],
+				       MT_RXQ_ID(MT_RXQ_BAND1),
 				       MT7915_RX_RING_SIZE,
 				       MT_RX_BUF_SIZE,
-				       MT_RXQ_RING_BASE(MT_RXQ_EXT) + hif1_ofs);
+				       MT_RXQ_RING_BASE(MT_RXQ_BAND1) + hif1_ofs);
 		if (ret)
 			return ret;
 
 		/* tx free notify event from WA for band1 */
-		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_EXT_WA],
-				       MT_RXQ_ID(MT_RXQ_EXT_WA),
+		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_BAND1_WA],
+				       MT_RXQ_ID(MT_RXQ_BAND1_WA),
 				       MT7915_RX_MCU_RING_SIZE,
 				       MT_RX_BUF_SIZE,
-				       MT_RXQ_RING_BASE(MT_RXQ_EXT_WA) + hif1_ofs);
+				       MT_RXQ_RING_BASE(MT_RXQ_BAND1_WA) + hif1_ofs);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index baed4696e829..c1256defbea3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -591,8 +591,8 @@ static void mt7915_irq_tasklet(struct tasklet_struct *t)
 	if (intr & MT_INT_RX(MT_RXQ_MAIN))
 		napi_schedule(&dev->mt76.napi[MT_RXQ_MAIN]);
 
-	if (intr & MT_INT_RX(MT_RXQ_EXT))
-		napi_schedule(&dev->mt76.napi[MT_RXQ_EXT]);
+	if (intr & MT_INT_RX(MT_RXQ_BAND1))
+		napi_schedule(&dev->mt76.napi[MT_RXQ_BAND1]);
 
 	if (intr & MT_INT_RX(MT_RXQ_MCU))
 		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU]);
@@ -604,8 +604,8 @@ static void mt7915_irq_tasklet(struct tasklet_struct *t)
 	    (intr & MT_INT_RX(MT_RXQ_MAIN_WA)))
 		napi_schedule(&dev->mt76.napi[MT_RXQ_MAIN_WA]);
 
-	if (intr & MT_INT_RX(MT_RXQ_EXT_WA))
-		napi_schedule(&dev->mt76.napi[MT_RXQ_EXT_WA]);
+	if (intr & MT_INT_RX(MT_RXQ_BAND1_WA))
+		napi_schedule(&dev->mt76.napi[MT_RXQ_BAND1_WA]);
 
 	if (intr & MT_INT_MCU_CMD) {
 		u32 val = mt76_rr(dev, MT_MCU_CMD);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index b6a6aa7fcf43..5159b8e416f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -66,7 +66,7 @@
 #define MT7915_MAX_TWT_AGRT		16
 #define MT7915_MAX_STA_TWT_AGRT		8
 #define MT7915_MIN_TWT_DUR 64
-#define MT7915_MAX_QUEUE		(__MT_RXQ_MAX + __MT_MCUQ_MAX + 2)
+#define MT7915_MAX_QUEUE		(MT_RXQ_BAND2 + __MT_MCUQ_MAX + 2)
 
 struct mt7915_vif;
 struct mt7915_sta;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 51f3d8af4d4a..53061aa727e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -617,7 +617,7 @@ enum offs_rev {
 
 /* WFDMA COMMON */
 #define __RXQ(q)			((q) + __MT_MCUQ_MAX)
-#define __TXQ(q)			(__RXQ(q) + __MT_RXQ_MAX)
+#define __TXQ(q)			(__RXQ(q) + MT_RXQ_BAND2)
 
 #define MT_Q_ID(q)			(dev->q_id[(q)])
 #define MT_Q_BASE(q)			((dev->wfdma_mask >> (q)) & 0x1 ?	\
@@ -633,7 +633,7 @@ enum offs_rev {
 
 #define MT_MCUQ_EXT_CTRL(q)		(MT_Q_BASE(q) +	0x600 +	\
 					 MT_MCUQ_ID(q)* 0x4)
-#define MT_RXQ_EXT_CTRL(q)		(MT_Q_BASE(__RXQ(q)) + 0x680 +	\
+#define MT_RXQ_BAND1_CTRL(q)		(MT_Q_BASE(__RXQ(q)) + 0x680 +	\
 					 MT_RXQ_ID(q)* 0x4)
 #define MT_TXQ_EXT_CTRL(q)		(MT_Q_BASE(__TXQ(q)) + 0x600 +	\
 					 MT_TXQ_ID(q)* 0x4)
@@ -665,8 +665,8 @@ enum offs_rev {
 #define MT_INT_BAND0_RX_DONE		(MT_INT_RX(MT_RXQ_MAIN) |	\
 					 MT_INT_RX(MT_RXQ_MAIN_WA))
 
-#define MT_INT_BAND1_RX_DONE		(MT_INT_RX(MT_RXQ_EXT) |	\
-					 MT_INT_RX(MT_RXQ_EXT_WA) |	\
+#define MT_INT_BAND1_RX_DONE		(MT_INT_RX(MT_RXQ_BAND1) |	\
+					 MT_INT_RX(MT_RXQ_BAND1_WA) |	\
 					 MT_INT_RX(MT_RXQ_MAIN_WA))
 
 #define MT_INT_RX_DONE_ALL		(MT_INT_RX_DONE_MCU |		\
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 0f5c1e5bffe1..efb9bb8231e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -775,7 +775,7 @@ mt7915_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 	fcs_err = is_mt7915(&dev->mt76) ? FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK_MT7916, cnt);
 
-	q = phy->band_idx ? MT_RXQ_EXT : MT_RXQ_MAIN;
+	q = phy->band_idx ? MT_RXQ_BAND1 : MT_RXQ_MAIN;
 	mphy->test.rx_stats.packets[q] += fcs_err;
 	mphy->test.rx_stats.fcs_error[q] += fcs_err;
 
-- 
2.36.1

