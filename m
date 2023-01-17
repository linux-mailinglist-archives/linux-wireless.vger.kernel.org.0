Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8692A66DFD4
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 15:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjAQODV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 09:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjAQODS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 09:03:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C897339CC8
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 06:03:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 635BB61456
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 14:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E27C433D2;
        Tue, 17 Jan 2023 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673964196;
        bh=YOjDxZHA/39hf6V2yMvQfB/45BvEn0TVVxqzgMsLu+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sdgzHOOBlxLPiuO4utHuItdjHCU2HrpLq/GLKvGOa9cf7Nt0npWikTpsZHOlD6uxD
         1S3EyvmQ0VOYW8K04mu3ltY4OH4i9GQbRNfSiLa7vFHxOZzcYGudYDWj5QzWmH61TR
         nVXPoVurR020fIZ+KbU08N2Fh3uuNa4MSWGYn102BoQje8aCE/pPrk0+ufsfoqdEq1
         nu9uK0GTPBQTLr867OS9gX4HALBLn0Xm+dNX2RXDdqklS97z/QV394lfycvvyatkVH
         blqOf1XGBv5jq57ASZgdEzdNDwepYjc0Uhtb4k92mZ2FYeKRCgzD/NUWXZOe4XJuzt
         vlW9KtezF7Yjg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sujuan.chen@mediatek.com
Subject: [PATCH v2 3/4] wifi: mt76: mt7915: add mt7915 wed reset callbacks
Date:   Tue, 17 Jan 2023 15:02:55 +0100
Message-Id: <e571e6d72721c39493e8837a2c01fdc699d20969.1673963962.git.lorenzo@kernel.org>
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

Introduce mt7915_mmio_wed_reset_complete and
mt7915_mmio_wed_reset_complete callbacks and the related wait
queues in order to wait for wed reset completion during wlan reset.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c      |  2 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |  3 ++
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 15 +++++++
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 40 +++++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 93c42082f1c2..714becbbefea 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -922,6 +922,8 @@ mt76_dma_init(struct mt76_dev *dev,
 	snprintf(dev->napi_dev.name, sizeof(dev->napi_dev.name), "%s",
 		 wiphy_name(dev->hw->wiphy));
 	dev->napi_dev.threaded = 1;
+	init_completion(&dev->mmio.wed_reset);
+	init_completion(&dev->mmio.wed_reset_complete);
 
 	mt76_for_each_q_rx(dev, i) {
 		netif_napi_add(&dev->napi_dev, &dev->napi[i], poll);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 9037780f9e88..8abc6ecd7b68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -413,6 +413,7 @@ enum {
 	MT76_STATE_SUSPEND,
 	MT76_STATE_ROC,
 	MT76_STATE_PM,
+	MT76_STATE_WED_RESET,
 };
 
 struct mt76_hw_cap {
@@ -591,6 +592,8 @@ struct mt76_mmio {
 	u32 irqmask;
 
 	struct mtk_wed_device wed;
+	struct completion wed_reset;
+	struct completion wed_reset_complete;
 };
 
 struct mt76_rx_status {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index e3fa064918bf..a956e2a0be4f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -559,6 +559,20 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 	return 0;
 }
 
+static void mt7915_dma_wed_reset(struct mt7915_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+
+	if (!test_bit(MT76_STATE_WED_RESET, &dev->mphy.state))
+		return;
+
+	complete(&mdev->mmio.wed_reset);
+
+	if (!wait_for_completion_timeout(&dev->mt76.mmio.wed_reset_complete,
+					 3 * HZ))
+		dev_err(dev->mt76.dev, "wed reset complete timeout\n");
+}
+
 int mt7915_dma_reset(struct mt7915_dev *dev, bool force)
 {
 	struct mt76_phy *mphy_ext = dev->mt76.phys[MT_BAND1];
@@ -582,6 +596,7 @@ int mt7915_dma_reset(struct mt7915_dev *dev, bool force)
 		mt7915_wfsys_reset(dev);
 
 	mt7915_dma_disable(dev, force);
+	mt7915_dma_wed_reset(dev);
 
 	/* reset hw queues */
 	for (i = 0; i < __MT_TXQ_MAX; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 3ab2e5bf7d45..24f1af7992d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -4,10 +4,12 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/rtnetlink.h>
 #include <linux/pci.h>
 
 #include "mt7915.h"
 #include "mac.h"
+#include "mcu.h"
 #include "../trace.h"
 #include "../dma.h"
 
@@ -695,6 +697,42 @@ static void mt7915_mmio_wed_update_rx_stats(struct mtk_wed_device *wed,
 
 	rcu_read_unlock();
 }
+
+static int mt7915_mmio_wed_reset(struct mtk_wed_device *wed)
+{
+	struct mt76_dev *mdev = container_of(wed, struct mt76_dev, mmio.wed);
+	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
+	struct mt76_phy *mphy = &dev->mphy;
+	int ret;
+
+	ASSERT_RTNL();
+
+	if (test_and_set_bit(MT76_STATE_WED_RESET, &mphy->state))
+		return -EBUSY;
+
+	ret = mt7915_mcu_set_ser(dev, SER_RECOVER, SER_SET_RECOVER_L1,
+				 mphy->band_idx);
+	if (ret)
+		goto out;
+
+	rtnl_unlock();
+	if (!wait_for_completion_timeout(&mdev->mmio.wed_reset, 20 * HZ)) {
+		dev_err(mdev->dev, "wed reset timeout\n");
+		ret = -ETIMEDOUT;
+	}
+	rtnl_lock();
+out:
+	clear_bit(MT76_STATE_WED_RESET, &mphy->state);
+
+	return ret;
+}
+
+static void mt7915_mmio_wed_reset_complete(struct mtk_wed_device *wed)
+{
+	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+
+	complete(&dev->mmio.wed_reset_complete);
+}
 #endif
 
 int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
@@ -777,6 +815,8 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 	wed->wlan.init_rx_buf = mt7915_mmio_wed_init_rx_buf;
 	wed->wlan.release_rx_buf = mt7915_mmio_wed_release_rx_buf;
 	wed->wlan.update_wo_rx_stats = mt7915_mmio_wed_update_rx_stats;
+	wed->wlan.reset = mt7915_mmio_wed_reset;
+	wed->wlan.reset_complete = mt7915_mmio_wed_reset_complete;
 
 	dev->mt76.rx_token_size = wed->wlan.rx_npkt;
 
-- 
2.39.0

