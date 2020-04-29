Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4921BE5A2
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 19:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgD2Rw3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 13:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2Rw3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 13:52:29 -0400
Received: from localhost.localdomain.com (unknown [151.66.196.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0C8D21BE5;
        Wed, 29 Apr 2020 17:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588182748;
        bh=VO5hheXNVNOEpG4EtuMOBb3zy5nHCqE9xPxQDXNbwLw=;
        h=From:To:Cc:Subject:Date:From;
        b=0CaqTFVkdcZtdg0ADEzDLSWMQfwAMc/mDBLZQ1SMLipAHexXdLWEmczAxItuwtpcM
         +YvboQ45jvX38W6fzwnbqQyTLUvtczY4v+cjz0S2TID7bprcw826aAtkb9RwOzViFT
         8rQD0zB9U1wlnBUsajJn5dukipcEC1V9ylwN3W3g=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: introduce mt7615_check_offload_capability routine
Date:   Wed, 29 Apr 2020 19:52:15 +0200
Message-Id: <5d8ba8de8fbd384eabf48eb1899bba82e1acc80e.1588182688.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_check_offload_capability routine to set hw/wiphy
offload capabilities according to the running firmware

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 26 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 +
 .../wireless/mediatek/mt76/mt7615/pci_init.c  | 21 +--------------
 .../wireless/mediatek/mt76/mt7615/usb_init.c  |  4 +--
 4 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 9880643888ba..7da0bf425061 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -130,6 +130,32 @@ void mt7615_mac_init(struct mt7615_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt7615_mac_init);
 
+void mt7615_check_offload_capability(struct mt7615_dev *dev)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct wiphy *wiphy = hw->wiphy;
+
+	if (mt7615_firmware_offload(dev)) {
+		ieee80211_hw_set(hw, SUPPORTS_PS);
+		ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
+
+		wiphy->features |= NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
+	} else {
+		dev->ops->hw_scan = NULL;
+		dev->ops->cancel_hw_scan = NULL;
+		dev->ops->sched_scan_start = NULL;
+		dev->ops->sched_scan_stop = NULL;
+
+		wiphy->max_sched_scan_plan_interval = 0;
+		wiphy->max_sched_scan_ie_len = 0;
+		wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
+		wiphy->max_sched_scan_ssids = 0;
+		wiphy->max_match_sets = 0;
+		wiphy->max_sched_scan_reqs = 0;
+	}
+}
+EXPORT_SYMBOL_GPL(mt7615_check_offload_capability);
+
 bool mt7615_wait_for_mcu_init(struct mt7615_dev *dev)
 {
 	flush_work(&dev->mcu_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 0476b9426b03..2321a1f23ec8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -370,6 +370,7 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 		      int irq, const u32 *map);
 u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr);
 
+void mt7615_check_offload_capability(struct mt7615_dev *dev);
 void mt7615_init_device(struct mt7615_dev *dev);
 int mt7615_register_device(struct mt7615_dev *dev);
 void mt7615_unregister_device(struct mt7615_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index cd3ccafa7d11..69cba8609edf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -16,7 +16,6 @@ static void mt7615_init_work(struct work_struct *work)
 {
 	struct mt7615_dev *dev = container_of(work, struct mt7615_dev,
 					      mcu_work);
-	struct ieee80211_hw *hw = mt76_hw(dev);
 
 	if (mt7615_mcu_init(dev))
 		return;
@@ -25,25 +24,7 @@ static void mt7615_init_work(struct work_struct *work)
 	mt7615_mac_init(dev);
 	mt7615_phy_init(dev);
 	mt7615_mcu_del_wtbl_all(dev);
-
-	if (mt7615_firmware_offload(dev)) {
-		ieee80211_hw_set(hw, SUPPORTS_PS);
-		ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
-	} else {
-		struct wiphy *wiphy = hw->wiphy;
-
-		dev->ops->hw_scan = NULL;
-		dev->ops->cancel_hw_scan = NULL;
-		dev->ops->sched_scan_start = NULL;
-		dev->ops->sched_scan_stop = NULL;
-
-		wiphy->max_sched_scan_plan_interval = 0;
-		wiphy->max_sched_scan_ie_len = 0;
-		wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
-		wiphy->max_sched_scan_ssids = 0;
-		wiphy->max_match_sets = 0;
-		wiphy->max_sched_scan_reqs = 0;
-	}
+	mt7615_check_offload_capability(dev);
 }
 
 static int mt7615_init_hardware(struct mt7615_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c
index 39642065531f..1fbc9601391d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c
@@ -103,6 +103,7 @@ static void mt7663u_init_work(struct work_struct *work)
 	mt7615_mac_init(dev);
 	mt7615_phy_init(dev);
 	mt7615_mcu_del_wtbl_all(dev);
+	mt7615_check_offload_capability(dev);
 }
 
 int mt7663u_register_device(struct mt7615_dev *dev)
@@ -119,9 +120,6 @@ int mt7663u_register_device(struct mt7615_dev *dev)
 	if (err)
 		return err;
 
-	ieee80211_hw_set(hw, SUPPORTS_PS);
-	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
-
 	hw->extra_tx_headroom += MT_USB_HDR_SIZE + MT_USB_TXD_SIZE;
 	/* check hw sg support in order to enable AMSDU */
 	hw->max_tx_fragments = dev->mt76.usb.sg_en ? MT_HW_TXP_MAX_BUF_NUM : 1;
-- 
2.25.4

