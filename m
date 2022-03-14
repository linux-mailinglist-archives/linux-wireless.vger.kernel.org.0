Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0234D8917
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 17:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbiCNQal (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiCNQak (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 12:30:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28528B7E6
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 09:29:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87396B80E7F
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 16:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A245C340E9;
        Mon, 14 Mar 2022 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275366;
        bh=p2ShtyWnfUyrw1spk/XfyfEoQqGagf1jse0MGabVH3M=;
        h=From:To:Cc:Subject:Date:From;
        b=MrY9nTAHRAst9mdjfFMuWj/vKh2xtKNxuVpg1itLBQh9VB35rryxGPaVlA11RrtKI
         4xjsimY/29L09Y3TCWTVWshUOyYyBcNfS4yWFjhBL175Csm8joTa0KPNOR9jBQhL8J
         QjrnIFlGBNT6dfJiA8GeUso7S1cCGFhDCt/YrP4bLxK0SukC/ippjpWFWhxDjoEnGs
         OGhqj3YOKmgbl91G+gutyJHcdk4AZ451wuMIBOdRtEuSW0xBMrAqX3yAtOCC/RyH6F
         jn5uKUQcl7OuWk5fG1gFMM6Hm5FTToPHvO17RFVRkHsXKoaHmBFea3O1WK7dNRPRp+
         RKMqltSF36xhw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH v2] mt76: mt7921: move mt7921_init_hw in a dedicated work
Date:   Mon, 14 Mar 2022 17:29:13 +0100
Message-Id: <dd913e33b0ffbb56be61d5bc0d0a431c25460b45.1647275272.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firmware initialization can take a while. Move mt7921_init_hw routine in
a dedicated work in order to not slow down bootstrap process.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- allow reset after hw register
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 62 +++++++++++++------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  1 +
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  1 +
 5 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index ceb22653e4bb..91fc41922d95 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -165,7 +165,7 @@ static int __mt7921_init_hardware(struct mt7921_dev *dev)
 
 static int mt7921_init_hardware(struct mt7921_dev *dev)
 {
-	int ret, idx, i;
+	int ret, i;
 
 	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
@@ -182,6 +182,13 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
 		return ret;
 	}
 
+	return 0;
+}
+
+static int mt7921_init_wcid(struct mt7921_dev *dev)
+{
+	int idx;
+
 	/* Beacon and mgmt frames should occupy wcid 0 */
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
 	if (idx)
@@ -195,6 +202,38 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
 	return 0;
 }
 
+static void mt7921_init_work(struct work_struct *work)
+{
+	struct mt7921_dev *dev = container_of(work, struct mt7921_dev,
+					      init_work);
+	int ret;
+
+	ret = mt7921_init_hardware(dev);
+	if (ret)
+		return;
+
+	mt76_set_stream_caps(&dev->mphy, true);
+	mt7921_set_stream_he_caps(&dev->phy);
+
+	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
+				   ARRAY_SIZE(mt76_rates));
+	if (ret) {
+		dev_err(dev->mt76.dev, "register device failed\n");
+		return;
+	}
+
+	ret = mt7921_init_debugfs(dev);
+	if (ret) {
+		dev_err(dev->mt76.dev, "register debugfs failed\n");
+		return;
+	}
+
+	/* we support chip reset now */
+	dev->hw_init_done = true;
+
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
+}
+
 int mt7921_register_device(struct mt7921_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
@@ -222,6 +261,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	spin_lock_init(&dev->sta_poll_lock);
 
 	INIT_WORK(&dev->reset_work, mt7921_mac_reset_work);
+	INIT_WORK(&dev->init_work, mt7921_init_work);
 
 	dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
 	dev->pm.stats.last_wake_event = jiffies;
@@ -236,7 +276,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	if (!mt76_is_mmio(&dev->mt76))
 		hw->extra_tx_headroom += MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
 
-	ret = mt7921_init_hardware(dev);
+	ret = mt7921_init_wcid(dev);
 	if (ret)
 		return ret;
 
@@ -264,23 +304,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
 	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
 
-	mt76_set_stream_caps(&dev->mphy, true);
-	mt7921_set_stream_he_caps(&dev->phy);
-
-	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
-				   ARRAY_SIZE(mt76_rates));
-	if (ret)
-		return ret;
-
-	ret = mt7921_init_debugfs(dev);
-	if (ret)
-		return ret;
-
-	ret = mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
-	if (ret)
-		return ret;
-
-	dev->hw_init_done = true;
+	queue_work(system_wq, &dev->init_work);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 1ea781429d49..7690364bc079 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -205,6 +205,8 @@ struct mt7921_dev {
 	struct list_head sta_poll_list;
 	spinlock_t sta_poll_lock;
 
+	struct work_struct init_work;
+
 	u8 fw_debug;
 
 	struct mt76_connac_pm pm;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index a0c82d19c4d9..1a01d025bbe5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -105,6 +105,7 @@ static void mt7921e_unregister_device(struct mt7921_dev *dev)
 	int i;
 	struct mt76_connac_pm *pm = &dev->pm;
 
+	cancel_work_sync(&dev->init_work);
 	mt76_unregister_device(&dev->mt76);
 	mt76_for_each_q_rx(&dev->mt76, i)
 		napi_disable(&dev->mt76.napi[i]);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 9b2bc0b11492..af26d59fa2f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -41,6 +41,7 @@ static void mt7921s_unregister_device(struct mt7921_dev *dev)
 {
 	struct mt76_connac_pm *pm = &dev->pm;
 
+	cancel_work_sync(&dev->init_work);
 	mt76_unregister_device(&dev->mt76);
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 0f99d059d319..b7771e9f1fcd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -275,6 +275,7 @@ static void mt7921u_disconnect(struct usb_interface *usb_intf)
 {
 	struct mt7921_dev *dev = usb_get_intfdata(usb_intf);
 
+	cancel_work_sync(&dev->init_work);
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return;
 
-- 
2.35.1

