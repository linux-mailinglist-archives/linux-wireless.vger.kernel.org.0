Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCA16D4220
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 12:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjDCKec (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 06:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjDCKeZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 06:34:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3612AEB7C
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 03:34:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E75A5B81107
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 10:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318F5C433EF;
        Mon,  3 Apr 2023 10:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680518057;
        bh=DI0cMsvPKgBEo8cZAjzhNJg7XPLXQJhxTZNQqg+yMkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5AO32NtTvkmuSTYx/WzzDUqA34UOc3hlAazKj9aTCgXLvFmt/bBBr8XSjn+B48jE
         SgTBVSCfLJaAm/cuwn887oGqzPeXt46MrGrvcHN+HDYnrjKYLCLoYHVlF8INO4sJqc
         ssmZ4/44PMa7C+nYQiTOEvNALdoK93qzWgRq17Skkax7MziFlkwFsrsPDzByBaGl+s
         2CI3XO2T5eOStQRytHAwpmJZiQZnX9xu713f634mUL9hmFqUdkc9Gh8C5VB3TMJX4r
         syCQQuUu2qIwCXocfo1qEAhqTnXpJHMOOEP3DMjqbGJsOQmfKPdvmX/ltyTlStyWEG
         G3tCmSbroMJXw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/6] wifi: mt76: get rid of unused sta_ps callbacks
Date:   Mon,  3 Apr 2023 12:33:57 +0200
Message-Id: <646955a92c84ff960c6ac2357176f820e1b1d118.1680517676.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680517676.git.lorenzo@kernel.org>
References: <cover.1680517676.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

sta_ps callback is just an empty stub for most of the drivers,
so get rid of them.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c      | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    | 5 -----
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c   | 1 -
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 1 -
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c   | 1 -
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c    | 1 -
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    | 4 ----
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   | 1 -
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h | 1 -
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    | 5 -----
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 1 -
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    | 1 -
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   | 1 -
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    | 1 -
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 4 ----
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   | 1 -
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 1 -
 17 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 87902f4b8e12..2c4a52900679 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1304,7 +1304,8 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 	if (ps)
 		set_bit(MT_WCID_FLAG_PS, &wcid->flags);
 
-	dev->drv->sta_ps(dev, sta, ps);
+	if (dev->drv->sta_ps)
+		dev->drv->sta_ps(dev, sta, ps);
 
 	if (!ps)
 		clear_bit(MT_WCID_FLAG_PS, &wcid->flags);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 6d6b46d7bd1a..ddede8a9f781 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -655,11 +655,6 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	return 0;
 }
 
-void mt7615_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps)
-{
-}
-EXPORT_SYMBOL_GPL(mt7615_sta_ps);
-
 static u16
 mt7615_mac_tx_rate_val(struct mt7615_dev *dev,
 		       struct mt76_phy *mphy,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index cb10878dac7e..ac036a072439 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -179,7 +179,6 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 		.rx_check = mt7615_rx_check,
 		.rx_skb = mt7615_queue_rx_skb,
 		.rx_poll_complete = mt7615_rx_poll_complete,
-		.sta_ps = mt7615_sta_ps,
 		.sta_add = mt7615_mac_sta_add,
 		.sta_remove = mt7615_mac_sta_remove,
 		.update_survey = mt7615_update_channel,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index ff910a80a6b4..932cdad7e7d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -511,7 +511,6 @@ void mt7615_tx_token_put(struct mt7615_dev *dev);
 bool mt7615_rx_check(struct mt76_dev *mdev, void *data, int len);
 void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb, u32 *info);
-void mt7615_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 304212f5f8da..fc547a0031ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -84,7 +84,6 @@ static int mt7663s_probe(struct sdio_func *func,
 		.tx_status_data = mt7663_usb_sdio_tx_status_data,
 		.rx_skb = mt7615_queue_rx_skb,
 		.rx_check = mt7615_rx_check,
-		.sta_ps = mt7615_sta_ps,
 		.sta_add = mt7615_mac_sta_add,
 		.sta_remove = mt7615_mac_sta_remove,
 		.update_survey = mt7615_update_channel,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index f2d651d7adff..04963b9f7498 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -120,7 +120,6 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 		.tx_status_data = mt7663_usb_sdio_tx_status_data,
 		.rx_skb = mt7615_queue_rx_skb,
 		.rx_check = mt7615_rx_check,
-		.sta_ps = mt7615_sta_ps,
 		.sta_add = mt7615_mac_sta_add,
 		.sta_remove = mt7615_mac_sta_remove,
 		.update_survey = mt7615_update_channel,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 3c156c1d589b..7df8d95fc3fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -73,10 +73,6 @@ static struct mt76_wcid *mt7915_rx_get_wcid(struct mt7915_dev *dev,
 	return &sta->vif->sta.wcid;
 }
 
-void mt7915_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps)
-{
-}
-
 bool mt7915_mac_wtbl_update(struct mt7915_dev *dev, int idx, u32 mask)
 {
 	mt76_rmw(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 49f0410384c0..45f3558bf31c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -1022,7 +1022,6 @@ struct mt7915_dev *mt7915_mmio_probe(struct device *pdev,
 		.rx_skb = mt7915_queue_rx_skb,
 		.rx_check = mt7915_rx_check,
 		.rx_poll_complete = mt7915_rx_poll_complete,
-		.sta_ps = mt7915_sta_ps,
 		.sta_add = mt7915_mac_sta_add,
 		.sta_remove = mt7915_mac_sta_remove,
 		.update_survey = mt7915_update_channel,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 6e089d57971f..e9b163d8e1e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -630,7 +630,6 @@ void mt7915_tx_token_put(struct mt7915_dev *dev);
 void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb, u32 *info);
 bool mt7915_rx_check(struct mt76_dev *mdev, void *data, int len);
-void mt7915_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 void mt7915_stats_work(struct work_struct *work);
 int mt76_dfs_start_rdd(struct mt7915_dev *dev, bool force);
 int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 557c20190c2b..2eeea43f6bf6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -32,11 +32,6 @@ static struct mt76_wcid *mt7921_rx_get_wcid(struct mt7921_dev *dev,
 	return &sta->vif->sta.wcid;
 }
 
-void mt7921_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps)
-{
-}
-EXPORT_SYMBOL_GPL(mt7921_sta_ps);
-
 bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask)
 {
 	mt76_rmw(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 31f356d95090..53d12c4b94e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -470,7 +470,6 @@ void mt7921_tx_token_put(struct mt7921_dev *dev);
 bool mt7921_rx_check(struct mt76_dev *mdev, void *data, int len);
 void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb, u32 *info);
-void mt7921_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 void mt7921_stats_work(struct work_struct *work);
 void mt7921_set_stream_he_caps(struct mt7921_phy *phy);
 void mt7921_update_channel(struct mt76_phy *mphy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index b7d19b57a877..ab3ddf4e2f4d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -241,7 +241,6 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		.rx_check = mt7921_rx_check,
 		.rx_skb = mt7921_queue_rx_skb,
 		.rx_poll_complete = mt7921_rx_poll_complete,
-		.sta_ps = mt7921_sta_ps,
 		.sta_add = mt7921_mac_sta_add,
 		.sta_assoc = mt7921_mac_sta_assoc,
 		.sta_remove = mt7921_mac_sta_remove,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 8ce4252b8ae7..77001a0602c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -99,7 +99,6 @@ static int mt7921s_probe(struct sdio_func *func,
 		.tx_status_data = mt7921_usb_sdio_tx_status_data,
 		.rx_skb = mt7921_queue_rx_skb,
 		.rx_check = mt7921_rx_check,
-		.sta_ps = mt7921_sta_ps,
 		.sta_add = mt7921_mac_sta_add,
 		.sta_assoc = mt7921_mac_sta_assoc,
 		.sta_remove = mt7921_mac_sta_remove,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 8fef09ed29c9..d8218ed7980a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -183,7 +183,6 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 		.tx_status_data = mt7921_usb_sdio_tx_status_data,
 		.rx_skb = mt7921_queue_rx_skb,
 		.rx_check = mt7921_rx_check,
-		.sta_ps = mt7921_sta_ps,
 		.sta_add = mt7921_mac_sta_add,
 		.sta_assoc = mt7921_mac_sta_assoc,
 		.sta_remove = mt7921_mac_sta_remove,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 46b76485947c..68362de48479 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -78,10 +78,6 @@ static struct mt76_wcid *mt7996_rx_get_wcid(struct mt7996_dev *dev,
 	return &sta->vif->sta.wcid;
 }
 
-void mt7996_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps)
-{
-}
-
 bool mt7996_mac_wtbl_update(struct mt7996_dev *dev, int idx, u32 mask)
 {
 	mt76_rmw(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 65fa1260e80b..fc77641ce7bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -330,7 +330,6 @@ struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
 		.rx_skb = mt7996_queue_rx_skb,
 		.rx_check = mt7996_rx_check,
 		.rx_poll_complete = mt7996_rx_poll_complete,
-		.sta_ps = mt7996_sta_ps,
 		.sta_add = mt7996_mac_sta_add,
 		.sta_remove = mt7996_mac_sta_remove,
 		.update_survey = mt7996_update_channel,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index ddcf27692732..c4732cb4343f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -511,7 +511,6 @@ void mt7996_tx_token_put(struct mt7996_dev *dev);
 void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb, u32 *info);
 bool mt7996_rx_check(struct mt76_dev *mdev, void *data, int len);
-void mt7996_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 void mt7996_stats_work(struct work_struct *work);
 int mt76_dfs_start_rdd(struct mt7996_dev *dev, bool force);
 int mt7996_dfs_init_radar_detector(struct mt7996_phy *phy);
-- 
2.39.2

