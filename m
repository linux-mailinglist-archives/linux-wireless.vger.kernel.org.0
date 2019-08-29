Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD28DA1438
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2019 10:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfH2I5O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 04:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfH2I5O (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 04:57:14 -0400
Received: from localhost.localdomain (unknown [151.66.57.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BD16215EA;
        Thu, 29 Aug 2019 08:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567069032;
        bh=wy1jgcwAkmIYVfGUF7pwE1rEptV3Ck95Gh9K3pIiDHU=;
        h=From:To:Cc:Subject:Date:From;
        b=of6SbzVWaptYDPIc/2ZYGIUco09Xu0r0uj0phskSYzIiesczlRqGG6crtcVTxjRqj
         UB+bSIFNAqbo7UYawjZLP/yIP3WDpQJKVGVj6pdjvoI6dwop7shrha1E8nc9VYozfX
         nHeXQOq9Xg8l6lbg8gEXK5gHIVIAfTNSbwpQdiWk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: move mt7615 sta utilities in pci.c
Date:   Thu, 29 Aug 2019 10:57:06 +0200
Message-Id: <e095a331854ab9c9619f86ae8860502abf808fbe.1567068930.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt7615_sta_add, mt7615_sta_assoc, mt7615_sta_ps and mt7615_sta_remove
utility routines in pci.c and make them static since they are only used to
initialize mt76_driver_ops callbacks

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  4 --
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 40 ---------------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  7 ---
 .../net/wireless/mediatek/mt76/mt7615/pci.c   | 49 +++++++++++++++++++
 4 files changed, 49 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index e07ce2c10013..ee6b5a609ee7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -215,10 +215,6 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	return 0;
 }
 
-void mt7615_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps)
-{
-}
-
 void mt7615_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
 			    struct mt76_queue_entry *e)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 87c748715b5d..0da937f36d3d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -336,46 +336,6 @@ mt7615_channel_switch_beacon(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
-int mt7615_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-		   struct ieee80211_sta *sta)
-{
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	int idx;
-
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7615_WTBL_STA - 1);
-	if (idx < 0)
-		return -ENOSPC;
-
-	msta->vif = mvif;
-	msta->wcid.sta = 1;
-	msta->wcid.idx = idx;
-
-	mt7615_mcu_add_wtbl(dev, vif, sta);
-	mt7615_mcu_set_sta_rec(dev, vif, sta, 1);
-
-	return 0;
-}
-
-void mt7615_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-		      struct ieee80211_sta *sta)
-{
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-
-	if (sta->ht_cap.ht_supported)
-		mt7615_mcu_set_ht_cap(dev, vif, sta);
-}
-
-void mt7615_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta)
-{
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-
-	mt7615_mcu_set_sta_rec(dev, vif, sta, 0);
-	mt7615_mcu_del_wtbl(dev, sta);
-}
-
 static void mt7615_sta_rate_tbl_update(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_sta *sta)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index a79f4ffcb70f..6ea4645da053 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -259,13 +259,6 @@ void mt7615_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
 
 void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
-void mt7615_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
-int mt7615_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-		   struct ieee80211_sta *sta);
-void mt7615_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-		      struct ieee80211_sta *sta);
-void mt7615_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta);
 void mt7615_mac_work(struct work_struct *work);
 void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 			  struct mt76_txwi_cache *txwi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index e250607e0a80..524ce35010e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -66,6 +66,55 @@ static irqreturn_t mt7615_irq_handler(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
+static int
+mt7615_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+	       struct ieee80211_sta *sta)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	int idx;
+
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7615_WTBL_STA - 1);
+	if (idx < 0)
+		return -ENOSPC;
+
+	msta->vif = mvif;
+	msta->wcid.sta = 1;
+	msta->wcid.idx = idx;
+
+	mt7615_mcu_add_wtbl(dev, vif, sta);
+	mt7615_mcu_set_sta_rec(dev, vif, sta, 1);
+
+	return 0;
+}
+
+static void
+mt7615_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		 struct ieee80211_sta *sta)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+
+	if (sta->ht_cap.ht_supported)
+		mt7615_mcu_set_ht_cap(dev, vif, sta);
+}
+
+static void
+mt7615_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		  struct ieee80211_sta *sta)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+
+	mt7615_mcu_set_sta_rec(dev, vif, sta, 0);
+	mt7615_mcu_del_wtbl(dev, sta);
+}
+
+static void
+mt7615_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta,
+	      bool ps)
+{
+}
+
 static int mt7615_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
-- 
2.21.0

