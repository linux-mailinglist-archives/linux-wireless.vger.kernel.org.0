Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DE66ACB49
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Mar 2023 18:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCFRvh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Mar 2023 12:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjCFRvd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Mar 2023 12:51:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089D76BC1B
        for <linux-wireless@vger.kernel.org>; Mon,  6 Mar 2023 09:51:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B11FDCE16B8
        for <linux-wireless@vger.kernel.org>; Mon,  6 Mar 2023 17:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B58C4339B;
        Mon,  6 Mar 2023 17:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678125035;
        bh=CyS2mt3V+hmLK78pbu1+1+DdqdQ4zOaPdST/NYe3FNk=;
        h=From:To:Cc:Subject:Date:From;
        b=u61F8YpKIhz2vtSrpQKwLuaepAtgGOvWgpKz05C9zhzrUOpbyo1f+aKZt3/cmU4U6
         U6+3CN0/TID8o+2w6ELr1OD7s9nSl44DECCqtMbPf31QHxHCRtQuDoJdmvkNwZFfya
         azFjZsdrD5LbprIQtqcscgNfBTHgeL580mShRgyZPPqF5T7VJ6GozT+ylgmfjCtMle
         OVaLsjwrBo8fMCGBISKjqZ1f0OhhLLhBeXwODvF2t6LL3z06GslDD1oGv+bFu6GB3m
         Ci0VXAABQi5Wntxg59aAQiwaG/kAeHdI5kDTq3UHFHVyIGU7yICwOcLuDTZxB0fFjZ
         w1/Zg0DLtDNGA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] wifi: mt76: mt7921: introduce mt7921_get_mac80211_ops utility routine
Date:   Mon,  6 Mar 2023 18:50:29 +0100
Message-Id: <e52206331b479cc3089ec5c314a3327e67eb27b8.1678124807.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since the fw offload capability check is shared between pci,usb and sdio
devices, move it in common init code and reduce code duplication.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 29 +++++++++++++++++--
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  3 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 19 ++----------
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  | 20 ++-----------
 .../net/wireless/mediatek/mt76/mt7921/usb.c   | 19 ++----------
 5 files changed, 35 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 80c71acfe159..33681fbb2fe8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -169,7 +169,8 @@ mt7921_mac_init_band(struct mt7921_dev *dev, u8 band)
 	mt76_rmw(dev, MT_WTBLOFF_TOP_RSCR(band), mask, set);
 }
 
-u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
+static u8
+mt7921_get_offload_capability(struct device *dev, const char *fw_wm)
 {
 	struct mt7921_fw_features *features = NULL;
 	const struct mt76_connac2_fw_trailer *hdr;
@@ -220,7 +221,31 @@ u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
 
 	return features ? features->data : 0;
 }
-EXPORT_SYMBOL_GPL(mt7921_check_offload_capability);
+
+struct ieee80211_ops *
+mt7921_get_mac80211_ops(struct device *dev, void *drv_data, u8 *fw_features)
+{
+	struct ieee80211_ops *ops;
+
+	ops = devm_kmemdup(dev, &mt7921_ops, sizeof(mt7921_ops), GFP_KERNEL);
+	if (!ops)
+		return NULL;
+
+	*fw_features = mt7921_get_offload_capability(dev, drv_data);
+	if (!(*fw_features & MT7921_FW_CAP_CNM)) {
+		ops->remain_on_channel = NULL;
+		ops->cancel_remain_on_channel = NULL;
+		ops->add_chanctx = NULL;
+		ops->remove_chanctx = NULL;
+		ops->change_chanctx = NULL;
+		ops->assign_vif_chanctx = NULL;
+		ops->unassign_vif_chanctx = NULL;
+		ops->mgd_prepare_tx = NULL;
+		ops->mgd_complete_tx = NULL;
+	}
+	return ops;
+}
+EXPORT_SYMBOL_GPL(mt7921_get_mac80211_ops);
 
 int mt7921_mac_init(struct mt7921_dev *dev)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 1af70dac723b..b1dceeafa54e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -593,5 +593,6 @@ int mt7921_mcu_set_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
 		       enum mt7921_roc_req type, u8 token_id);
 int mt7921_mcu_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
 			 u8 token_id);
-u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm);
+struct ieee80211_ops *mt7921_get_mac80211_ops(struct device *dev,
+					      void *drv_data, u8 *fw_features);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 1a8a54a46dcc..b520cd258170 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -256,7 +256,6 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		.drv_own = mt7921e_mcu_drv_pmctrl,
 		.fw_own = mt7921e_mcu_fw_pmctrl,
 	};
-
 	struct ieee80211_ops *ops;
 	struct mt76_bus_ops *bus_ops;
 	struct mt7921_dev *dev;
@@ -285,27 +284,13 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	if (mt7921_disable_aspm)
 		mt76_pci_disable_aspm(pdev);
 
-	features = mt7921_check_offload_capability(&pdev->dev, (const char *)
-						   id->driver_data);
-	ops = devm_kmemdup(&pdev->dev, &mt7921_ops, sizeof(mt7921_ops),
-			   GFP_KERNEL);
+	ops = mt7921_get_mac80211_ops(&pdev->dev, (void *)id->driver_data,
+				      &features);
 	if (!ops) {
 		ret = -ENOMEM;
 		goto err_free_pci_vec;
 	}
 
-	if (!(features & MT7921_FW_CAP_CNM)) {
-		ops->remain_on_channel = NULL;
-		ops->cancel_remain_on_channel = NULL;
-		ops->add_chanctx = NULL;
-		ops->remove_chanctx = NULL;
-		ops->change_chanctx = NULL;
-		ops->assign_vif_chanctx = NULL;
-		ops->unassign_vif_chanctx = NULL;
-		ops->mgd_prepare_tx = NULL;
-		ops->mgd_complete_tx = NULL;
-	}
-
 	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), ops, &drv_ops);
 	if (!mdev) {
 		ret = -ENOMEM;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 8ce4252b8ae7..584921fb25b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -122,33 +122,17 @@ static int mt7921s_probe(struct sdio_func *func,
 		.drv_own = mt7921s_mcu_drv_pmctrl,
 		.fw_own = mt7921s_mcu_fw_pmctrl,
 	};
-
 	struct ieee80211_ops *ops;
 	struct mt7921_dev *dev;
 	struct mt76_dev *mdev;
 	u8 features;
 	int ret;
 
-	features = mt7921_check_offload_capability(&func->dev, (const char *)
-						   id->driver_data);
-
-	ops = devm_kmemdup(&func->dev, &mt7921_ops, sizeof(mt7921_ops),
-			   GFP_KERNEL);
+	ops = mt7921_get_mac80211_ops(&func->dev, (void *)id->driver_data,
+				      &features);
 	if (!ops)
 		return -ENOMEM;
 
-	if (!(features & MT7921_FW_CAP_CNM)) {
-		ops->remain_on_channel = NULL;
-		ops->cancel_remain_on_channel = NULL;
-		ops->add_chanctx = NULL;
-		ops->remove_chanctx = NULL;
-		ops->change_chanctx = NULL;
-		ops->assign_vif_chanctx = NULL;
-		ops->unassign_vif_chanctx = NULL;
-		ops->mgd_prepare_tx = NULL;
-		ops->mgd_complete_tx = NULL;
-	}
-
 	mdev = mt76_alloc_device(&func->dev, sizeof(*dev), ops, &drv_ops);
 	if (!mdev)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 8fef09ed29c9..376bf89a70d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -210,27 +210,12 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 	u8 features;
 	int ret;
 
-	features = mt7921_check_offload_capability(&usb_intf->dev, (const char *)
-						   id->driver_info);
-	ops = devm_kmemdup(&usb_intf->dev, &mt7921_ops, sizeof(mt7921_ops),
-			   GFP_KERNEL);
+	ops = mt7921_get_mac80211_ops(&usb_intf->dev, (void *)id->driver_info,
+				      &features);
 	if (!ops)
 		return -ENOMEM;
 
-	if (!(features & MT7921_FW_CAP_CNM)) {
-		ops->remain_on_channel = NULL;
-		ops->cancel_remain_on_channel = NULL;
-		ops->add_chanctx = NULL;
-		ops->remove_chanctx = NULL;
-		ops->change_chanctx = NULL;
-		ops->assign_vif_chanctx = NULL;
-		ops->unassign_vif_chanctx = NULL;
-		ops->mgd_prepare_tx = NULL;
-		ops->mgd_complete_tx = NULL;
-	}
-
 	ops->stop = mt7921u_stop;
-
 	mdev = mt76_alloc_device(&usb_intf->dev, sizeof(*dev), ops, &drv_ops);
 	if (!mdev)
 		return -ENOMEM;
-- 
2.39.2

