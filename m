Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8034CFD82
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 12:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiCGL7f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 06:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiCGL7e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 06:59:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838CE2C642
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 03:58:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 224FD60F28
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 11:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46652C340E9;
        Mon,  7 Mar 2022 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646654317;
        bh=mT/sIcTP4WznRwv3E2LH1plG0AUDEUE1XkalWj7j4HI=;
        h=From:To:Cc:Subject:Date:From;
        b=pZcn14j72VyBk/t8qVdSjg5L91Hi7GSO5dpzwiG+8unaDhZ/GV3RN/78Qyst/8gsE
         PiKfXqvdKLo/u+FypCza5DJoHc73P2cTbV6ZuJM4E+7/wHZCfrtRpSBbr82cEffn0d
         C5zf6wo5ODL8RMcIQquVvBbSeNeL63h4n/NdqQc/dk3/3GrFQwFd9Cey9si6aWxEkX
         itrlvSEy84tBP4ybuu1MIDrtEGKqe46GZ6SBjXlsTxvbYpM4rUY3+AZKSf+GZQJAHd
         MXNxMjzeCtXumSI0lM/Qu7otZgwoCVMn5nLg/DwP5KTbpkPcrCbGUZ5i9Dm7IMEBgm
         iDE8s/jHh3whg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH] mt76: mt7921: move mt7921_init_hw in a dedicated work
Date:   Mon,  7 Mar 2022 12:58:23 +0100
Message-Id: <0358e31e71481dec87f7ecb3b040db53076ffc4a.1646654230.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 66 +++++++++++++------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +
 2 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index fa6af85bba7b..332af886b95a 100644
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
@@ -195,6 +202,42 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
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
+		dev_err(dev->mt76.dev, "debugfs register failed\n");
+		goto error;
+	}
+
+	ret = mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
+	if (ret)
+		goto error;
+
+	dev->hw_init_done = true;
+	return;
+error:
+	mt76_unregister_device(&dev->mt76);
+}
+
 int mt7921_register_device(struct mt7921_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
@@ -222,6 +265,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	spin_lock_init(&dev->sta_poll_lock);
 
 	INIT_WORK(&dev->reset_work, mt7921_mac_reset_work);
+	INIT_WORK(&dev->init_work, mt7921_init_work);
 
 	dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
 	dev->pm.stats.last_wake_event = jiffies;
@@ -234,7 +278,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	if (mt76_is_sdio(&dev->mt76))
 		hw->extra_tx_headroom += MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
 
-	ret = mt7921_init_hardware(dev);
+	ret = mt7921_init_wcid(dev);
 	if (ret)
 		return ret;
 
@@ -262,23 +306,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
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
index 394a677140da..b6c8f84acb64 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -204,6 +204,8 @@ struct mt7921_dev {
 	struct list_head sta_poll_list;
 	spinlock_t sta_poll_lock;
 
+	struct work_struct init_work;
+
 	u8 fw_debug;
 
 	struct mt76_connac_pm pm;
-- 
2.35.1

