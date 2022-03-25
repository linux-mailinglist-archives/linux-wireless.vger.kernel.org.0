Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3314E7C7F
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Mar 2022 01:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiCYVMW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 17:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiCYVMR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 17:12:17 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9C81FE54F
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dGSuW6W3H4rUe8kXsInDaApB4HoG7QsEBZgq/AtDVYc=; b=Rx745YNm9wofiNJ+sjsYGBliSp
        LSVpdjtxl76+0OZeAM4B7/TLScwhATKpQ00kv/+bgWDgmwgC4rwbZ73XBGH21MeCNsUT3FDCm1BaF
        fbffupfqE4c9hU+YD1xxP6Oh9+Z1goUUuyWuePvm7qee0/VHY58TxQ57K1p+mQhVO0D4=;
Received: from p200300daa70ef200dc11dea3d730df97.dip0.t-ipconnect.de ([2003:da:a70e:f200:dc11:dea3:d730:df97] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nXrCh-0001fW-9t
        for linux-wireless@vger.kernel.org; Fri, 25 Mar 2022 22:10:39 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/8] mt76: mt7915: rework hardware/phy initialization
Date:   Fri, 25 Mar 2022 22:10:25 +0100
Message-Id: <20220325211031.24171-2-nbd@nbd.name>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325211031.24171-1-nbd@nbd.name>
References: <20220325211031.24171-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Clean up and fix error paths in mt7915_register_device
Initialize second DBDC tx queue in mt7915_dma_init

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  14 ++-
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 104 +++++++++++-------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   3 +-
 3 files changed, 78 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 49b4d8ade16b..66a312a9c008 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -5,7 +5,8 @@
 #include "../dma.h"
 #include "mac.h"
 
-int mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc, int ring_base)
+static int
+mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc, int ring_base)
 {
 	int i, err;
 
@@ -323,7 +324,7 @@ static int mt7915_dma_enable(struct mt7915_dev *dev)
 	return 0;
 }
 
-int mt7915_dma_init(struct mt7915_dev *dev)
+int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 {
 	struct mt76_dev *mdev = &dev->mt76;
 	u32 hif1_ofs = 0;
@@ -346,6 +347,15 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
+	if (phy2) {
+		ret = mt7915_init_tx_queues(phy2,
+					    MT_TXQ_ID(phy2->band_idx),
+					    MT7915_TX_RING_SIZE,
+					    MT_TXQ_RING_BASE(1));
+		if (ret)
+			return ret;
+	}
+
 	/* command to WM */
 	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM,
 				  MT_MCUQ_ID(MT_MCUQ_WM),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 6d29366c5139..9686a835d5cb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -484,21 +484,18 @@ static int mt7915_txbf_init(struct mt7915_dev *dev)
 	return mt7915_mcu_set_txbf(dev, MT_BF_TYPE_UPDATE);
 }
 
-static int mt7915_register_ext_phy(struct mt7915_dev *dev)
+static struct mt7915_phy *
+mt7915_alloc_ext_phy(struct mt7915_dev *dev)
 {
-	struct mt7915_phy *phy = mt7915_ext_phy(dev);
+	struct mt7915_phy *phy;
 	struct mt76_phy *mphy;
-	int ret;
 
 	if (!dev->dbdc_support)
-		return 0;
-
-	if (phy)
-		return 0;
+		return NULL;
 
 	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7915_ops);
 	if (!mphy)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	phy = mphy->priv;
 	phy->dev = dev;
@@ -507,6 +504,15 @@ static int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	/* Bind main phy to band0 and ext_phy to band1 for dbdc case */
 	phy->band_idx = 1;
 
+	return phy;
+}
+
+static int
+mt7915_register_ext_phy(struct mt7915_dev *dev, struct mt7915_phy *phy)
+{
+	struct mt76_phy *mphy = phy->mt76;
+	int ret;
+
 	INIT_DELAYED_WORK(&mphy->mac_work, mt7915_mac_work);
 
 	mt7915_eeprom_parse_hw_cap(dev, phy);
@@ -526,29 +532,22 @@ static int mt7915_register_ext_phy(struct mt7915_dev *dev)
 
 	/* init wiphy according to mphy and phy */
 	mt7915_init_wiphy(mphy->hw);
-	ret = mt7915_init_tx_queues(phy, MT_TXQ_ID(phy->band_idx),
-				    MT7915_TX_RING_SIZE,
-				    MT_TXQ_RING_BASE(1));
-	if (ret)
-		goto error;
 
 	ret = mt76_register_phy(mphy, true, mt76_rates,
 				ARRAY_SIZE(mt76_rates));
 	if (ret)
-		goto error;
+		return ret;
 
 	ret = mt7915_thermal_init(phy);
 	if (ret)
-		goto error;
+		goto unreg;
 
-	ret = mt7915_init_debugfs(phy);
-	if (ret)
-		goto error;
+	mt7915_init_debugfs(phy);
 
 	return 0;
 
-error:
-	ieee80211_free_hw(mphy->hw);
+unreg:
+	mt76_unregister_phy(mphy);
 	return ret;
 }
 
@@ -645,7 +644,8 @@ static bool mt7915_band_config(struct mt7915_dev *dev)
 	return ret;
 }
 
-static int mt7915_init_hardware(struct mt7915_dev *dev)
+static int
+mt7915_init_hardware(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 {
 	int ret, idx;
 
@@ -653,14 +653,12 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 
 	INIT_WORK(&dev->init_work, mt7915_init_work);
 
-	dev->dbdc_support = mt7915_band_config(dev);
-
 	/* If MCU was already running, it is likely in a bad state */
 	if (mt76_get_field(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE) >
 	    FW_STATE_FW_DOWNLOAD)
 		mt7915_wfsys_reset(dev);
 
-	ret = mt7915_dma_init(dev);
+	ret = mt7915_dma_init(dev, phy2);
 	if (ret)
 		return ret;
 
@@ -1048,9 +1046,22 @@ static void mt7915_unregister_ext_phy(struct mt7915_dev *dev)
 	ieee80211_free_hw(mphy->hw);
 }
 
+static void mt7915_stop_hardware(struct mt7915_dev *dev)
+{
+	mt7915_mcu_exit(dev);
+	mt7915_tx_token_put(dev);
+	mt7915_dma_cleanup(dev);
+	tasklet_disable(&dev->irq_tasklet);
+
+	if (is_mt7986(&dev->mt76))
+		mt7986_wmac_disable(dev);
+}
+
+
 int mt7915_register_device(struct mt7915_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct mt7915_phy *phy2;
 	int ret;
 
 	dev->phy.dev = dev;
@@ -1066,9 +1077,15 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	init_waitqueue_head(&dev->reset_wait);
 	INIT_WORK(&dev->reset_work, mt7915_mac_reset_work);
 
-	ret = mt7915_init_hardware(dev);
+	dev->dbdc_support = mt7915_band_config(dev);
+
+	phy2 = mt7915_alloc_ext_phy(dev);
+	if (IS_ERR(phy2))
+		return PTR_ERR(phy2);
+
+	ret = mt7915_init_hardware(dev, phy2);
 	if (ret)
-		return ret;
+		goto free_phy2;
 
 	mt7915_init_wiphy(hw);
 
@@ -1085,19 +1102,34 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
 				   ARRAY_SIZE(mt76_rates));
 	if (ret)
-		return ret;
+		goto stop_hw;
 
 	ret = mt7915_thermal_init(&dev->phy);
 	if (ret)
-		return ret;
+		goto unreg_dev;
 
 	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
 
-	ret = mt7915_register_ext_phy(dev);
-	if (ret)
-		return ret;
+	if (phy2) {
+		ret = mt7915_register_ext_phy(dev, phy2);
+		if (ret)
+			goto unreg_thermal;
+	}
 
-	return mt7915_init_debugfs(&dev->phy);
+	mt7915_init_debugfs(&dev->phy);
+
+	return 0;
+
+unreg_thermal:
+	mt7915_unregister_thermal(&dev->phy);
+unreg_dev:
+	mt76_unregister_device(&dev->mt76);
+stop_hw:
+	mt7915_stop_hardware(dev);
+free_phy2:
+	if (phy2)
+		ieee80211_free_hw(phy2->mt76->hw);
+	return ret;
 }
 
 void mt7915_unregister_device(struct mt7915_dev *dev)
@@ -1105,13 +1137,7 @@ void mt7915_unregister_device(struct mt7915_dev *dev)
 	mt7915_unregister_ext_phy(dev);
 	mt7915_unregister_thermal(&dev->phy);
 	mt76_unregister_device(&dev->mt76);
-	mt7915_mcu_exit(dev);
-	mt7915_tx_token_put(dev);
-	mt7915_dma_cleanup(dev);
-	tasklet_disable(&dev->irq_tasklet);
-
-	if (is_mt7986(&dev->mt76))
-		mt7986_wmac_disable(dev);
+	mt7915_stop_hardware(dev);
 
 	mt76_free_device(&dev->mt76);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 6efa0a2e2345..fd05e07bf9b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -440,7 +440,7 @@ int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 				   struct ieee80211_channel *chan,
 				   u8 chain_idx);
 s8 mt7915_eeprom_get_power_delta(struct mt7915_dev *dev, int band);
-int mt7915_dma_init(struct mt7915_dev *dev);
+int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2);
 void mt7915_dma_prefetch(struct mt7915_dev *dev);
 void mt7915_dma_cleanup(struct mt7915_dev *dev);
 int mt7915_mcu_init(struct mt7915_dev *dev);
@@ -572,7 +572,6 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  struct mt76_tx_info *tx_info);
 void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 void mt7915_tx_token_put(struct mt7915_dev *dev);
-int mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc, int ring_base);
 void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
 bool mt7915_rx_check(struct mt76_dev *mdev, void *data, int len);
-- 
2.35.1

