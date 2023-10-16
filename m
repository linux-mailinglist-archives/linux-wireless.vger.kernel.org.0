Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066A47CA392
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 11:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjJPJJ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 05:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjJPJJz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 05:09:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573A6AD
        for <linux-wireless@vger.kernel.org>; Mon, 16 Oct 2023 02:09:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7D9C433C7;
        Mon, 16 Oct 2023 09:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697447392;
        bh=3vLyqqYT010XU7aySBEjTffX1ERMPpYj/d//AMHvRpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AjhFedQGLmrdDjhtjyuAt8MBHhhSC6M3SqJqw/9uyoU25RUPBWCBu9sWnRiNe8fJ4
         Mmh3Y8fylMT5EXMWLfsYvXbMkr9GcItzh6K4OtqaCzS9uhf1UYN3uYpI35ZJPJlZka
         3tcrqh1KTGJuoUMNds/6tp2Se6K092F1dGvLi3obAkFb2S3H9+sJlHoj2P5WWIqR1K
         9lQEb4dSF8e8wu+i2qDNYjczkqaGhuIpw/++IwQD82XnZiRoSiEERzzp8vhei/hz1F
         VwG7DkY20KV1Bu79uqkGyxXd6sdgXLW5SwQjlDtmiOiB2VHH+I7smDk3MsllULAU91
         QkyO/7hUFNyyw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 02/12] wifi: mt76: move mt76_mmio_wed_offload_{enable,disable} in common code
Date:   Mon, 16 Oct 2023 11:03:35 +0200
Message-ID: <6924f13aba360ff415acd68cb5a39b3048d06d6f.1697445995.git.lorenzo@kernel.org>
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

mt76_mmio_wed_offload_enable and mt76_mmio_wed_offload_disable routines
will be reused by mt7996 driver for wed support.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mmio.c     | 22 ++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 ++
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 29 ++-----------------
 3 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wireless/mediatek/mt76/mmio.c
index 350650a0fce2..c34624978a14 100644
--- a/drivers/net/wireless/mediatek/mt76/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mmio.c
@@ -157,6 +157,28 @@ u32 mt76_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 	return -ENOMEM;
 }
 EXPORT_SYMBOL_GPL(mt76_mmio_wed_init_rx_buf);
+
+int mt76_mmio_wed_offload_enable(struct mtk_wed_device *wed)
+{
+	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+
+	spin_lock_bh(&dev->token_lock);
+	dev->token_size = wed->wlan.token_start;
+	spin_unlock_bh(&dev->token_lock);
+
+	return !wait_event_timeout(dev->tx_wait, !dev->wed_token_count, HZ);
+}
+EXPORT_SYMBOL_GPL(mt76_mmio_wed_offload_enable);
+
+void mt76_mmio_wed_offload_disable(struct mtk_wed_device *wed)
+{
+	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+
+	spin_lock_bh(&dev->token_lock);
+	dev->token_size = dev->drv->token_size;
+	spin_unlock_bh(&dev->token_lock);
+}
+EXPORT_SYMBOL_GPL(mt76_mmio_wed_offload_disable);
 #endif /*CONFIG_NET_MEDIATEK_SOC_WED */
 
 void mt76_mmio_init(struct mt76_dev *dev, void __iomem *regs)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 11212b6153ab..2e9f208ae8f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1060,6 +1060,8 @@ static inline u16 mt76_rev(struct mt76_dev *dev)
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 u32 mt76_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size);
 void mt76_mmio_wed_release_rx_buf(struct mtk_wed_device *wed);
+int mt76_mmio_wed_offload_enable(struct mtk_wed_device *wed);
+void mt76_mmio_wed_offload_disable(struct mtk_wed_device *wed);
 #endif /*CONFIG_NET_MEDIATEK_SOC_WED */
 
 #define mt76xx_chip(dev) mt76_chip(&((dev)->mt76))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 1621a8150798..85cb3fed9505 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -542,31 +542,6 @@ static u32 mt7915_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
 }
 
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
-static int mt7915_mmio_wed_offload_enable(struct mtk_wed_device *wed)
-{
-	struct mt7915_dev *dev;
-
-	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
-
-	spin_lock_bh(&dev->mt76.token_lock);
-	dev->mt76.token_size = wed->wlan.token_start;
-	spin_unlock_bh(&dev->mt76.token_lock);
-
-	return !wait_event_timeout(dev->mt76.tx_wait,
-				   !dev->mt76.wed_token_count, HZ);
-}
-
-static void mt7915_mmio_wed_offload_disable(struct mtk_wed_device *wed)
-{
-	struct mt7915_dev *dev;
-
-	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
-
-	spin_lock_bh(&dev->mt76.token_lock);
-	dev->mt76.token_size = MT7915_TOKEN_SIZE;
-	spin_unlock_bh(&dev->mt76.token_lock);
-}
-
 static void mt7915_mmio_wed_update_rx_stats(struct mtk_wed_device *wed,
 					    struct mtk_wed_wo_rx_stats *stats)
 {
@@ -704,8 +679,8 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 	}
 
 	wed->wlan.init_buf = mt7915_wed_init_buf;
-	wed->wlan.offload_enable = mt7915_mmio_wed_offload_enable;
-	wed->wlan.offload_disable = mt7915_mmio_wed_offload_disable;
+	wed->wlan.offload_enable = mt76_mmio_wed_offload_enable;
+	wed->wlan.offload_disable = mt76_mmio_wed_offload_disable;
 	wed->wlan.init_rx_buf = mt76_mmio_wed_init_rx_buf;
 	wed->wlan.release_rx_buf = mt76_mmio_wed_release_rx_buf;
 	wed->wlan.update_wo_rx_stats = mt7915_mmio_wed_update_rx_stats;
-- 
2.41.0

