Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B80C7AA1C3
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 23:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjIUVFr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 17:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjIUVFJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 17:05:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C327B95F
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:37:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD469C32793;
        Thu, 21 Sep 2023 10:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695291847;
        bh=IVhx/SNmBQRT+vHoaLiamvZSnVvL/Om+oxaS/2IoP+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mTD/PiZd0fv4tY/iLnk7yCkLwRSZmnAKs+64XI6HbcMiQ6hBaCrqjgtZGaVRHWb+I
         BIzfi+3XRdOn8amNGD4vgNe1+6hj9P2BRGY3zVu3QQ2+brZE3MBBuMntBS1fi6FFm0
         Zy5c3D5amwmqpizy+Sj609CsIzvP4ZVeEyJhIS1FTa252lJalnE0hojjuBYHOqNT+R
         UZowF3POPpYi2BI0sN54uo+Sp5G0fkoWKaU7kB3k6j33iEUaWb4FQOMqBOI8+sFKqT
         ObVN9KWzLsFowirHPNQcMN7FH+TfLspYwVR9Q5ALoVbjZ4eH85vvTCzVEoSyCigB2v
         PMnmUVSN4nVlw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        deren.wu@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 2/2] wifi: mt76: mt792x: move some common usb code in mt792x module
Date:   Thu, 21 Sep 2023 12:23:48 +0200
Message-ID: <4414bdca6049dd5b455865932399a75e5265196f.1695291565.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695291565.git.lorenzo@kernel.org>
References: <cover.1695291565.git.lorenzo@kernel.org>
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

Move the following shared usb routines in mt792x module:
- mt792xu_stop
- mt792x_stop

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 21 +-----------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 -
 .../net/wireless/mediatek/mt76/mt7921/usb.c   | 10 +--------
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 20 +----------------
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  1 -
 .../net/wireless/mediatek/mt76/mt7925/usb.c   | 10 +--------
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  2 ++
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 22 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt792x_usb.c   |  9 ++++++++
 9 files changed, 37 insertions(+), 59 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index aa20fdce2729..ee14af4f3373 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -259,25 +259,6 @@ static int mt7921_start(struct ieee80211_hw *hw)
 	return err;
 }
 
-void mt7921_stop(struct ieee80211_hw *hw)
-{
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct mt792x_phy *phy = mt792x_hw_phy(hw);
-
-	cancel_delayed_work_sync(&phy->mt76->mac_work);
-
-	cancel_delayed_work_sync(&dev->pm.ps_work);
-	cancel_work_sync(&dev->pm.wake_work);
-	cancel_work_sync(&dev->reset_work);
-	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
-
-	mt792x_mutex_acquire(dev);
-	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
-	mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, false, false);
-	mt792x_mutex_release(dev);
-}
-EXPORT_SYMBOL_GPL(mt7921_stop);
-
 static int
 mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
@@ -1312,7 +1293,7 @@ static void mt7921_mgd_complete_tx(struct ieee80211_hw *hw,
 const struct ieee80211_ops mt7921_ops = {
 	.tx = mt792x_tx,
 	.start = mt7921_start,
-	.stop = mt7921_stop,
+	.stop = mt792x_stop,
 	.add_interface = mt7921_add_interface,
 	.remove_interface = mt792x_remove_interface,
 	.config = mt7921_config,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index d454b5e43636..5e6e5fe85599 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -232,7 +232,6 @@ mt7921_l1_rmw(struct mt792x_dev *dev, u32 addr, u32 mask, u32 val)
 #define mt7921_l1_set(dev, addr, val)	mt7921_l1_rmw(dev, addr, 0, val)
 #define mt7921_l1_clear(dev, addr, val)	mt7921_l1_rmw(dev, addr, val, 0)
 
-void mt7921_stop(struct ieee80211_hw *hw);
 int mt7921_mac_init(struct mt792x_dev *dev);
 bool mt7921_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask);
 int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 33a87f447dca..e5258c74fc07 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -135,14 +135,6 @@ static int mt7921u_mac_reset(struct mt792x_dev *dev)
 	return err;
 }
 
-static void mt7921u_stop(struct ieee80211_hw *hw)
-{
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-
-	mt76u_stop_tx(&dev->mt76);
-	mt7921_stop(hw);
-}
-
 static int mt7921u_probe(struct usb_interface *usb_intf,
 			 const struct usb_device_id *id)
 {
@@ -189,7 +181,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 	if (!ops)
 		return -ENOMEM;
 
-	ops->stop = mt7921u_stop;
+	ops->stop = mt792xu_stop;
 	mdev = mt76_alloc_device(&usb_intf->dev, sizeof(*dev), ops, &drv_ops);
 	if (!mdev)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index bb913eec3ca8..15c2fb0bcb1b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -318,24 +318,6 @@ static int mt7925_start(struct ieee80211_hw *hw)
 	return err;
 }
 
-void mt7925_stop(struct ieee80211_hw *hw)
-{
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct mt792x_phy *phy = mt792x_hw_phy(hw);
-
-	cancel_delayed_work_sync(&phy->mt76->mac_work);
-
-	cancel_delayed_work_sync(&dev->pm.ps_work);
-	cancel_work_sync(&dev->pm.wake_work);
-	cancel_work_sync(&dev->reset_work);
-	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
-
-	mt792x_mutex_acquire(dev);
-	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
-	mt792x_mutex_release(dev);
-}
-EXPORT_SYMBOL_GPL(mt7925_stop);
-
 static int
 mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
@@ -1411,7 +1393,7 @@ static void mt7925_mgd_complete_tx(struct ieee80211_hw *hw,
 const struct ieee80211_ops mt7925_ops = {
 	.tx = mt792x_tx,
 	.start = mt7925_start,
-	.stop = mt7925_stop,
+	.stop = mt792x_stop,
 	.add_interface = mt7925_add_interface,
 	.remove_interface = mt792x_remove_interface,
 	.config = mt7925_config,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 9a2d38a2b2bd..33785f526acf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -208,7 +208,6 @@ int mt7925_mcu_chip_config(struct mt792x_dev *dev, const char *cmd);
 int mt7925_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
 			    u8 bit_op, u32 bit_map);
 
-void mt7925_stop(struct ieee80211_hw *hw);
 int mt7925_mac_init(struct mt792x_dev *dev);
 int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index ea09b9b9d303..9b885c5b3ed5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -69,14 +69,6 @@ static int mt7925u_mcu_init(struct mt792x_dev *dev)
 	return 0;
 }
 
-static void mt7925u_stop(struct ieee80211_hw *hw)
-{
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-
-	mt76u_stop_tx(&dev->mt76);
-	mt7925_stop(hw);
-}
-
 static int mt7925u_mac_reset(struct mt792x_dev *dev)
 {
 	int err;
@@ -180,7 +172,7 @@ static int mt7925u_probe(struct usb_interface *usb_intf,
 	if (!ops)
 		return -ENOMEM;
 
-	ops->stop = mt7925u_stop;
+	ops->stop = mt792xu_stop;
 
 	mdev = mt76_alloc_device(&usb_intf->dev, sizeof(*dev), ops, &drv_ops);
 	if (!mdev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index fd1614e4926b..6c8fee5763f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -233,6 +233,7 @@ static inline bool mt792x_dma_need_reinit(struct mt792x_dev *dev)
 #define mt792x_mutex_release(dev)	\
 	mt76_connac_mutex_release(&(dev)->mt76, &(dev)->pm)
 
+void mt792x_stop(struct ieee80211_hw *hw);
 void mt792x_pm_wake_work(struct work_struct *work);
 void mt792x_pm_power_save_work(struct work_struct *work);
 void mt792x_reset(struct mt76_dev *mdev);
@@ -345,6 +346,7 @@ void mt792xu_wr(struct mt76_dev *dev, u32 addr, u32 val);
 u32 mt792xu_rmw(struct mt76_dev *dev, u32 addr, u32 mask, u32 val);
 void mt792xu_copy(struct mt76_dev *dev, u32 offset, const void *data, int len);
 void mt792xu_disconnect(struct usb_interface *usb_intf);
+void mt792xu_stop(struct ieee80211_hw *hw);
 
 static inline void
 mt792x_skb_add_usb_sdio_hdr(struct mt792x_dev *dev, struct sk_buff *skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 7c4a74fb1180..502be22dbe36 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -91,6 +91,28 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 }
 EXPORT_SYMBOL_GPL(mt792x_tx);
 
+void mt792x_stop(struct ieee80211_hw *hw)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
+
+	cancel_delayed_work_sync(&dev->pm.ps_work);
+	cancel_work_sync(&dev->pm.wake_work);
+	cancel_work_sync(&dev->reset_work);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
+
+	if (is_mt7921(&dev->mt76)) {
+		mt792x_mutex_acquire(dev);
+		mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, false, false);
+		mt792x_mutex_release(dev);
+	}
+
+	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+}
+EXPORT_SYMBOL_GPL(mt792x_stop);
+
 void mt792x_remove_interface(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index 20e7f9c7c88c..2dd283caed36 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -287,6 +287,15 @@ int mt792xu_init_reset(struct mt792x_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt792xu_init_reset);
 
+void mt792xu_stop(struct ieee80211_hw *hw)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	mt76u_stop_tx(&dev->mt76);
+	mt792x_stop(hw);
+}
+EXPORT_SYMBOL_GPL(mt792xu_stop);
+
 void mt792xu_disconnect(struct usb_interface *usb_intf)
 {
 	struct mt792x_dev *dev = usb_get_intfdata(usb_intf);
-- 
2.41.0

