Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC5CD188AA7
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 17:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgCQQmA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 12:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgCQQmA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 12:42:00 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 727F02073E;
        Tue, 17 Mar 2020 16:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584463319;
        bh=Z5EO24ZeE5vFiNha0MJLBEq388AbzNWjLJxVHNp4O6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqwpVIXtFe9LMHvAekFuS7uEn/e4s9R6TI6GuUz7Q8+mionrZyNJFUrC5luEBVW1/
         rp4gAe6ncOzGhpzi2hco1qAKEnqzB3jxtvcJqgeQuTZEHEV0ekcCPAuhp9a3jFn3Sm
         YKOc1Rcc+qBJNpAnuxjqTV5Gi2RBvKwAZGBIY6Ks=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 04/25] mt76: mt7615: introduce mt7615_init_device routine
Date:   Tue, 17 Mar 2020 17:41:11 +0100
Message-Id: <3f86e950286181b54605c3355d08c32bff0e219f.1584463004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584463004.git.lorenzo@kernel.org>
References: <cover.1584463004.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add mt7615_init_device routine in order to be reused adding support for
mt7663 in mt7615 driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 27 +++++++++++--------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 +
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 4c41e4048161..40e9bf5f4a35 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -429,11 +429,9 @@ void mt7615_unregister_ext_phy(struct mt7615_dev *dev)
 	ieee80211_free_hw(mphy->hw);
 }
 
-
-int mt7615_register_device(struct mt7615_dev *dev)
+void mt7615_init_device(struct mt7615_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
-	int ret;
 
 	dev->phy.dev = dev;
 	dev->phy.mt76 = &dev->mt76.phy;
@@ -444,14 +442,6 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	init_waitqueue_head(&dev->reset_wait);
 	INIT_WORK(&dev->reset_work, mt7615_mac_reset_work);
 
-	ret = mt7622_wmac_init(dev);
-	if (ret)
-		return ret;
-
-	ret = mt7615_init_hardware(dev);
-	if (ret)
-		return ret;
-
 	mt7615_init_wiphy(hw);
 	dev->mphy.sband_2g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
 	dev->mphy.sband_5g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
@@ -460,6 +450,13 @@ int mt7615_register_device(struct mt7615_dev *dev)
 			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
 	mt7615_cap_dbdc_disable(dev);
 	dev->phy.dfs_state = -1;
+}
+
+int mt7615_register_device(struct mt7615_dev *dev)
+{
+	int ret;
+
+	mt7615_init_device(dev);
 
 	/* init led callbacks */
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
@@ -467,6 +464,14 @@ int mt7615_register_device(struct mt7615_dev *dev)
 		dev->mt76.led_cdev.blink_set = mt7615_led_set_blink;
 	}
 
+	ret = mt7622_wmac_init(dev);
+	if (ret)
+		return ret;
+
+	ret = mt7615_init_hardware(dev);
+	if (ret)
+		return ret;
+
 	ret = mt76_register_device(&dev->mt76, true, mt7615_rates,
 				   ARRAY_SIZE(mt7615_rates));
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 2b7cee4da519..cc5aa2abb462 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -272,6 +272,7 @@ static inline int mt7622_wmac_init(struct mt7615_dev *dev)
 int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base, int irq);
 u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr);
 
+void mt7615_init_device(struct mt7615_dev *dev);
 int mt7615_register_device(struct mt7615_dev *dev);
 void mt7615_unregister_device(struct mt7615_dev *dev);
 int mt7615_register_ext_phy(struct mt7615_dev *dev);
-- 
2.25.1

