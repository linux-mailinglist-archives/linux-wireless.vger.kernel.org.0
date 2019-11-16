Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E54F0FEBC4
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2019 12:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKPLSa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Nov 2019 06:18:30 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:59114 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfKPLS3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Nov 2019 06:18:29 -0500
Received: from isengard.fritz.box (unknown [87.147.48.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 57D9458007D;
        Sat, 16 Nov 2019 12:18:25 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/4] mt76: mt76x02: split beaconing
Date:   Sat, 16 Nov 2019 12:17:07 +0100
Message-Id: <20191116111709.4686-3-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191116111709.4686-1-markus.theil@tu-ilmenau.de>
References: <20191116111709.4686-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sending beacons to the hardware always happens in batches. In order to
speed up beacon processing on usb devices, this patch splits out common
code an calls it only once (mt76x02_mac_set_beacon_prepare,
mt76x02_mac_set_beacon_finish). Making this split breaks beacon
enabling/disabling per vif. This is fixed by adding a call to set the
bypass mask, if beaconing should be disabled for a vif. Otherwise the
beacon is send after the next beacon interval.

The code is also adapted for the mmio part of the driver, but should not
have any performance implication there.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 .../wireless/mediatek/mt76/mt76x02_beacon.c   | 53 +++++++++----------
 .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  2 +
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  4 ++
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |  4 ++
 4 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index 54fe449f01c9..47207b790bf9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -47,10 +47,6 @@ __mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 bcn_idx,
 	int beacon_len = dev->beacon_ops->slot_size;
 	int beacon_addr = MT_BEACON_BASE + (beacon_len * bcn_idx);
 	int ret = 0;
-	int i;
-
-	/* Prevent corrupt transmissions during update */
-	mt76_set(dev, MT_BCN_BYPASS_MASK, BIT(bcn_idx));
 
 	if (skb) {
 		ret = mt76x02_write_beacon(dev, beacon_addr, skb);
@@ -58,41 +54,39 @@ __mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 bcn_idx,
 			dev->beacon_data_mask |= BIT(bcn_idx);
 	}
 
-	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~dev->beacon_data_mask);
-
 	return ret;
 }
 
-int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
-			   struct sk_buff *skb)
-{
-	bool force_update = false;
-	int bcn_idx = 0;
-	int i;
+void mt76x02_mac_set_beacon_prepare(struct mt76x02_dev *dev) {
+	/* Prevent corrupt transmissions during update */
+	mt76_set(dev, MT_BCN_BYPASS_MASK, 0xffff);
+}
+EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon_prepare);
 
-	for (i = 0; i < ARRAY_SIZE(dev->beacons); i++) {
-		if (vif_idx == i) {
-			force_update = !!dev->beacons[i] ^ !!skb;
-			dev_kfree_skb(dev->beacons[i]);
-			dev->beacons[i] = skb;
-			__mt76x02_mac_set_beacon(dev, bcn_idx, skb);
-		} else if (force_update && dev->beacons[i]) {
-			__mt76x02_mac_set_beacon(dev, bcn_idx,
-						 dev->beacons[i]);
-		}
+void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev) {
+	int i;
+	int bcn_idx = 0;
+	int nbeacons = hweight8(dev->mt76.beacon_mask);
 
+	for(i = 0; i < nbeacons; ++i) {
 		bcn_idx += !!dev->beacons[i];
 	}
 
-	for (i = bcn_idx; i < ARRAY_SIZE(dev->beacons); i++) {
-		if (!(dev->beacon_data_mask & BIT(i)))
-			break;
-
-		__mt76x02_mac_set_beacon(dev, i, NULL);
-	}
-
 	mt76_rmw_field(dev, MT_MAC_BSSID_DW1, MT_MAC_BSSID_DW1_MBEACON_N,
 		       bcn_idx - 1);
+
+	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~dev->beacon_data_mask);
+}
+EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon_finish);
+
+int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
+			   struct sk_buff *skb)
+{
+	dev_kfree_skb(dev->beacons[vif_idx]);
+	dev->beacons[vif_idx] = skb;
+	__mt76x02_mac_set_beacon(dev, vif_idx, skb);
+
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon);
@@ -113,6 +107,7 @@ void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
 	} else {
 		dev->mt76.beacon_mask &= ~BIT(mvif->idx);
 		mt76x02_mac_set_beacon(dev, mvif->idx, NULL);
+		mt76_set(dev, MT_BCN_BYPASS_MASK, BIT(mvif->idx));
 	}
 
 	if (!!old_mask == !!dev->mt76.beacon_mask)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
index efa4ef945e35..4e717640eef6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
@@ -197,6 +197,8 @@ int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
 			   struct sk_buff *skb);
 void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
 				   struct ieee80211_vif *vif, bool enable);
+void mt76x02_mac_set_beacon_prepare(struct mt76x02_dev *dev);
+void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev);
 
 void mt76x02_edcca_init(struct mt76x02_dev *dev);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index dc773070481d..b8b4c6a67d39 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -24,10 +24,14 @@ static void mt76x02_pre_tbtt_tasklet(unsigned long arg)
 
 	mt76x02_resync_beacon_timer(dev);
 
+	mt76x02_mac_set_beacon_prepare(dev);
+
 	ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
 		IEEE80211_IFACE_ITER_RESUME_ALL,
 		mt76x02_update_beacon_iter, dev);
 
+	mt76x02_mac_set_beacon_finish(dev);
+
 	mt76_csa_check(&dev->mt76);
 
 	if (dev->mt76.csa_complete)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 78dfc1e7f27b..aedab4cc8d40 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -179,6 +179,8 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 
 	mt76x02_resync_beacon_timer(dev);
 
+	mt76x02_mac_set_beacon_prepare(dev);
+
 	ieee80211_iterate_active_interfaces(mt76_hw(dev),
 		IEEE80211_IFACE_ITER_RESUME_ALL,
 		mt76x02_update_beacon_iter, dev);
@@ -191,6 +193,8 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 		mt76x02_mac_set_beacon(dev, i, skb);
 	}
 
+	mt76x02_mac_set_beacon_finish(dev);
+
 	mt76x02u_restart_pre_tbtt_timer(dev);
 }
 
-- 
2.24.0

