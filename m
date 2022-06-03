Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC55053C6E1
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 10:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbiFCIWD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 04:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiFCIV5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 04:21:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0BDF71
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 01:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9E3BB82239
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 08:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B26C385A9;
        Fri,  3 Jun 2022 08:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654244512;
        bh=pciJPhkaAn/akGeYwFsJVrfngr0jwtrdXbFX0+GzWEg=;
        h=From:To:Cc:Subject:Date:From;
        b=Ii9LYhO0dRAwgyxkxiFj6/CrfRLXdFDRlgKbz9KeVwFq9fKCYJsKMqM+L4faCik6j
         fCehJeZJ8KFw8TjiQRLF5wHH4BE9GZTv0Fw8id7aoH87QkPE7yb73oyn0i/zl+c1Im
         xQjaT/9qobHWmE/LY919IzIhVHB7m8RKSm84LoljkQWfVsSIj9Yry2YELCDwWwdfeW
         yyAxwJn+cpgkD1laPy/AK8zmRP95jlcOPX1NvZxEvKQUt4zDXuJ1iaSLL36bBjAAeZ
         rCl0zSZIs5qzAaaac5ipRJYhcdqkCG9Y4v4auL0DYQJMZ5uYLLVs8r+pySy2x5qGD7
         cS/fqi5ex5rNA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: get rid of mt7921_mcu_exit
Date:   Fri,  3 Jun 2022 10:21:37 +0200
Message-Id: <f8387f10fc256660f905e61319fe8546510188ff.1654244410.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.3
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

Run skb_queue_purge when needed.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c     | 6 ------
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h  | 1 -
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c | 4 ++--
 6 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index d0a7c3128d5a..4217c35acb82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -773,12 +773,6 @@ int mt7921_run_firmware(struct mt7921_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt7921_run_firmware);
 
-void mt7921_mcu_exit(struct mt7921_dev *dev)
-{
-	skb_queue_purge(&dev->mt76.mcu.res_q);
-}
-EXPORT_SYMBOL_GPL(mt7921_mcu_exit);
-
 int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 {
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 5ca584bb2fc6..953459031ae3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -301,7 +301,6 @@ int mt7921_mcu_get_rx_rate(struct mt7921_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
 int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl);
 void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb);
-void mt7921_mcu_exit(struct mt7921_dev *dev);
 
 static inline void mt7921_irq_enable(struct mt7921_dev *dev, u32 mask)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index b5fb22b8e086..624eb75c15cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -116,7 +116,7 @@ static void mt7921e_unregister_device(struct mt7921_dev *dev)
 	mt7921_mcu_drv_pmctrl(dev);
 	mt7921_dma_cleanup(dev);
 	mt7921_wfsys_reset(dev);
-	mt7921_mcu_exit(dev);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
 
 	tasklet_disable(&dev->irq_tasklet);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index af26d59fa2f0..487acd6e2be8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -48,7 +48,7 @@ static void mt7921s_unregister_device(struct mt7921_dev *dev)
 
 	mt76s_deinit(&dev->mt76);
 	mt7921s_wfsys_reset(dev);
-	mt7921_mcu_exit(dev);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
 
 	mt76_free_device(&dev->mt76);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index dc38baef273a..4e4cd2dc2aeb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -158,7 +158,7 @@ static void mt7921u_cleanup(struct mt7921_dev *dev)
 {
 	clear_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 	mt7921u_wfsys_reset(dev);
-	mt7921_mcu_exit(dev);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
 	mt76u_queues_deinit(&dev->mt76);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
index cd2f09743d2f..efbd3954c883 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
@@ -185,7 +185,7 @@ int mt7921u_init_reset(struct mt7921_dev *dev)
 	set_bit(MT76_RESET, &dev->mphy.state);
 
 	wake_up(&dev->mt76.mcu.wait);
-	mt7921_mcu_exit(dev);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
 
 	mt76u_stop_rx(&dev->mt76);
 	mt76u_stop_tx(&dev->mt76);
@@ -208,7 +208,7 @@ int mt7921u_mac_reset(struct mt7921_dev *dev)
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 
 	wake_up(&dev->mt76.mcu.wait);
-	mt7921_mcu_exit(dev);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
 
 	mt76u_stop_rx(&dev->mt76);
 	mt76u_stop_tx(&dev->mt76);
-- 
2.35.3

