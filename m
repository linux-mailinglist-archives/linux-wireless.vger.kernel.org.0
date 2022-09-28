Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCA45ED8BC
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 11:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiI1JUE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 05:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiI1JUB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 05:20:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463003FA39
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 02:19:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D715061D9C
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 09:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5565C433D6;
        Wed, 28 Sep 2022 09:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664356798;
        bh=yFlwXYfSHRWPAj6LbhiV6odtLv0EvLbCzxnfp7d5Xbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q85usGH0mcDlhYkTz949TqRdvcdUHTRSUAApwzQnfc1L5km6WduR3Dul+Rij2VbWL
         od0astLz/dsTmkMrrUB5mmD+CI0FUTFxPwfbASLNejgdKEgRAYf3t0y7YbIscn7Pzb
         pii95c8Gwajg5c4g3icipn0vHTqjYLsfaXgr8W8A7BA11znLn4Ekx1uoclKqX4XI3C
         uj68lVd4+0Q50NYci4uya0SbxAeh0cUAypEPTGd3uzIwL3WodPDtTtTkh2oQPmFkhL
         y+c48HDOwujILAlqeH3Ovh9XzaGjZuWUbMp8xRuf8KP6MTmHQDMmxnM/5yLNP0qJpX
         OVUNvqx+EwKkw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, ryder.Lee@mediatek.com,
        evelyn.tsai@mediatek.com, daniel@makrotopia.org,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 1/3] wifi: mt76: mt7915: move wed init routines in mmio.c
Date:   Wed, 28 Sep 2022 11:19:41 +0200
Message-Id: <b0e7591ef047b99cb50ff33bb23e97f0de609e25.1664356281.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664356281.git.lorenzo@kernel.org>
References: <cover.1664356281.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to enable wed support for mt7986-wmac
chipset.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 91 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +
 .../net/wireless/mediatek/mt76/mt7915/pci.c   | 93 +------------------
 3 files changed, 94 insertions(+), 92 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 7bd5f6725d7b..e75f2229b6a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -10,6 +10,9 @@
 #include "mac.h"
 #include "../trace.h"
 
+static bool wed_enable;
+module_param(wed_enable, bool, 0644);
+
 static const u32 mt7915_reg[] = {
 	[INT_SOURCE_CSR]	= 0xd7010,
 	[INT_MASK_CSR]		= 0xd7014,
@@ -472,6 +475,94 @@ static u32 mt7915_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
 	return dev->bus_ops->rmw(mdev, addr, mask, val);
 }
 
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+static int mt7915_mmio_wed_offload_enable(struct mtk_wed_device *wed)
+{
+	struct mt7915_dev *dev;
+	struct mt7915_phy *phy;
+	int ret;
+
+	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
+
+	spin_lock_bh(&dev->mt76.token_lock);
+	dev->mt76.token_size = wed->wlan.token_start;
+	spin_unlock_bh(&dev->mt76.token_lock);
+
+	ret = wait_event_timeout(dev->mt76.tx_wait,
+				 !dev->mt76.wed_token_count, HZ);
+	if (!ret)
+		return -EAGAIN;
+
+	phy = &dev->phy;
+	mt76_set(dev, MT_AGG_ACR4(phy->band_idx), MT_AGG_ACR_PPDU_TXS2H);
+
+	phy = dev->mt76.phys[MT_BAND1] ? dev->mt76.phys[MT_BAND1]->priv : NULL;
+	if (phy)
+		mt76_set(dev, MT_AGG_ACR4(phy->band_idx),
+			 MT_AGG_ACR_PPDU_TXS2H);
+
+	return 0;
+}
+
+static void mt7915_mmio_wed_offload_disable(struct mtk_wed_device *wed)
+{
+	struct mt7915_dev *dev;
+	struct mt7915_phy *phy;
+
+	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
+
+	spin_lock_bh(&dev->mt76.token_lock);
+	dev->mt76.token_size = MT7915_TOKEN_SIZE;
+	spin_unlock_bh(&dev->mt76.token_lock);
+
+	/* MT_TXD5_TX_STATUS_HOST (MPDU format) has higher priority than
+	 * MT_AGG_ACR_PPDU_TXS2H (PPDU format) even though ACR bit is set.
+	 */
+	phy = &dev->phy;
+	mt76_clear(dev, MT_AGG_ACR4(phy->band_idx), MT_AGG_ACR_PPDU_TXS2H);
+
+	phy = dev->mt76.phys[MT_BAND1] ? dev->mt76.phys[MT_BAND1]->priv : NULL;
+	if (phy)
+		mt76_clear(dev, MT_AGG_ACR4(phy->band_idx),
+			   MT_AGG_ACR_PPDU_TXS2H);
+}
+#endif
+
+int mt7915_mmio_wed_init(struct mt7915_dev *dev, struct pci_dev *pdev,
+			 int *irq)
+{
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
+	int ret;
+
+	if (!wed_enable)
+		return 0;
+
+	wed->wlan.pci_dev = pdev;
+	wed->wlan.wpdma_phys = pci_resource_start(pdev, 0) +
+			       MT_WFDMA_EXT_CSR_BASE;
+	wed->wlan.nbuf = 4096;
+	wed->wlan.token_start = MT7915_TOKEN_SIZE - wed->wlan.nbuf;
+	wed->wlan.init_buf = mt7915_wed_init_buf;
+	wed->wlan.offload_enable = mt7915_mmio_wed_offload_enable;
+	wed->wlan.offload_disable = mt7915_mmio_wed_offload_disable;
+
+	if (mtk_wed_device_attach(wed) != 0)
+		return 0;
+
+	*irq = wed->irq;
+	dev->mt76.dma_dev = wed->dev;
+
+	ret = dma_set_mask(wed->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	return 1;
+#else
+	return 0;
+#endif
+}
+
 static int mt7915_mmio_init(struct mt76_dev *mdev,
 			    void __iomem *mem_base,
 			    u32 device_id)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 1eb11617a625..93999d633b75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -590,5 +590,7 @@ bool mt7915_debugfs_rx_log(struct mt7915_dev *dev, const void *data, int len);
 void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, struct dentry *dir);
 #endif
+int mt7915_mmio_wed_init(struct mt7915_dev *dev, struct pci_dev *pdev,
+			 int *irq);
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 728a879c3b00..d73b78bba3e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -12,9 +12,6 @@
 #include "mac.h"
 #include "../trace.h"
 
-static bool wed_enable = false;
-module_param(wed_enable, bool, 0644);
-
 static LIST_HEAD(hif_list);
 static DEFINE_SPINLOCK(hif_lock);
 static u32 hif_idx;
@@ -95,94 +92,6 @@ static int mt7915_pci_hif2_probe(struct pci_dev *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
-static int mt7915_wed_offload_enable(struct mtk_wed_device *wed)
-{
-	struct mt7915_dev *dev;
-	struct mt7915_phy *phy;
-	int ret;
-
-	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
-
-	spin_lock_bh(&dev->mt76.token_lock);
-	dev->mt76.token_size = wed->wlan.token_start;
-	spin_unlock_bh(&dev->mt76.token_lock);
-
-	ret = wait_event_timeout(dev->mt76.tx_wait,
-				 !dev->mt76.wed_token_count, HZ);
-	if (!ret)
-		return -EAGAIN;
-
-	phy = &dev->phy;
-	mt76_set(dev, MT_AGG_ACR4(phy->band_idx), MT_AGG_ACR_PPDU_TXS2H);
-
-	phy = dev->mt76.phys[MT_BAND1] ? dev->mt76.phys[MT_BAND1]->priv : NULL;
-	if (phy)
-		mt76_set(dev, MT_AGG_ACR4(phy->band_idx),
-			 MT_AGG_ACR_PPDU_TXS2H);
-
-	return 0;
-}
-
-static void mt7915_wed_offload_disable(struct mtk_wed_device *wed)
-{
-	struct mt7915_dev *dev;
-	struct mt7915_phy *phy;
-
-	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
-
-	spin_lock_bh(&dev->mt76.token_lock);
-	dev->mt76.token_size = MT7915_TOKEN_SIZE;
-	spin_unlock_bh(&dev->mt76.token_lock);
-
-	/* MT_TXD5_TX_STATUS_HOST (MPDU format) has higher priority than
-	 * MT_AGG_ACR_PPDU_TXS2H (PPDU format) even though ACR bit is set.
-	 */
-	phy = &dev->phy;
-	mt76_clear(dev, MT_AGG_ACR4(phy->band_idx), MT_AGG_ACR_PPDU_TXS2H);
-
-	phy = dev->mt76.phys[MT_BAND1] ? dev->mt76.phys[MT_BAND1]->priv : NULL;
-	if (phy)
-		mt76_clear(dev, MT_AGG_ACR4(phy->band_idx),
-			   MT_AGG_ACR_PPDU_TXS2H);
-}
-#endif
-
-static int
-mt7915_pci_wed_init(struct mt7915_dev *dev, struct pci_dev *pdev, int *irq)
-{
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
-	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
-	int ret;
-
-	if (!wed_enable)
-		return 0;
-
-	wed->wlan.pci_dev = pdev;
-	wed->wlan.wpdma_phys = pci_resource_start(pdev, 0) +
-			       MT_WFDMA_EXT_CSR_BASE;
-	wed->wlan.nbuf = 4096;
-	wed->wlan.token_start = MT7915_TOKEN_SIZE - wed->wlan.nbuf;
-	wed->wlan.init_buf = mt7915_wed_init_buf;
-	wed->wlan.offload_enable = mt7915_wed_offload_enable;
-	wed->wlan.offload_disable = mt7915_wed_offload_disable;
-
-	if (mtk_wed_device_attach(wed) != 0)
-		return 0;
-
-	*irq = wed->irq;
-	dev->mt76.dma_dev = wed->dev;
-
-	ret = dma_set_mask(wed->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-
-	return 1;
-#else
-	return 0;
-#endif
-}
-
 static int mt7915_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -220,7 +129,7 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	mt7915_wfsys_reset(dev);
 	hif2 = mt7915_pci_init_hif2(pdev);
 
-	ret = mt7915_pci_wed_init(dev, pdev, &irq);
+	ret = mt7915_mmio_wed_init(dev, pdev, &irq);
 	if (ret < 0)
 		goto free_wed_or_irq_vector;
 
-- 
2.37.3

