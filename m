Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F8D104696
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 23:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKTW2n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 17:28:43 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:49966 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfKTW2m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 17:28:42 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id C116E58007F;
        Wed, 20 Nov 2019 23:28:39 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v7 2/5] mt76: mt76x02: split beaconing
Date:   Wed, 20 Nov 2019 23:28:23 +0100
Message-Id: <20191120222826.14871-3-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120222826.14871-1-markus.theil@tu-ilmenau.de>
References: <20191120222826.14871-1-markus.theil@tu-ilmenau.de>
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
 .../wireless/mediatek/mt76/mt76x02_beacon.c   | 63 ++++++++-----------
 .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  1 +
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  5 ++
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |  5 ++
 4 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index 403866496640..50e68af63d4f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -31,10 +31,22 @@ mt76x02_write_beacon(struct mt76x02_dev *dev, int offset, struct sk_buff *skb)
 	if (WARN_ON_ONCE(beacon_len < skb->len + sizeof(struct mt76x02_txwi)))
 		return -ENOSPC;
 
-	mt76x02_mac_write_txwi(dev, &txwi, skb, NULL, NULL, skb->len);
+	/* USB devices already reserve enough skb headroom for txwi's. This
+	 * helps to save slow copies over USB.
+	 */
+	if (mt76_is_usb(&dev->mt76)) {
+		struct mt76x02_txwi *txwi;
+
+		mt76_insert_hdr_pad(skb);
+		txwi = (struct mt76x02_txwi *)(skb->data - sizeof(*txwi));
+		mt76x02_mac_write_txwi(dev, txwi, skb, NULL, NULL, skb->len);
+		skb_push(skb, sizeof(*txwi));
+	} else {
+		struct mt76x02_txwi txwi;
 
-	mt76_wr_copy(dev, offset, &txwi, sizeof(txwi));
-	offset += sizeof(txwi);
+		mt76_wr_copy(dev, offset, &txwi, sizeof(txwi));
+		offset += sizeof(txwi);
+	}
 
 	mt76_wr_copy(dev, offset, skb->data, skb->len);
 	return 0;
@@ -47,10 +59,6 @@ __mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 bcn_idx,
 	int beacon_len = dev->beacon_ops->slot_size;
 	int beacon_addr = MT_BEACON_BASE + (beacon_len * bcn_idx);
 	int ret = 0;
-	int i;
-
-	/* Prevent corrupt transmissions during update */
-	mt76_set(dev, MT_BCN_BYPASS_MASK, BIT(bcn_idx));
 
 	if (skb) {
 		ret = mt76x02_write_beacon(dev, beacon_addr, skb);
@@ -60,41 +68,23 @@ __mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 bcn_idx,
 		dev->beacon_data_mask &= ~BIT(bcn_idx);
 	}
 
-	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~dev->beacon_data_mask);
-
 	return ret;
 }
 
+void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev)
+{
+	mt76_rmw_field(dev, MT_MAC_BSSID_DW1, MT_MAC_BSSID_DW1_MBEACON_N,
+		       hweight8(dev->beacon_data_mask) - 1);
+	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~dev->beacon_data_mask);
+}
+EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon_finish);
+
 int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
 			   struct sk_buff *skb)
 {
-	bool force_update = false;
-	int bcn_idx = 0;
-	int i;
-
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
-
-		bcn_idx += !!dev->beacons[i];
-	}
-
-	for (i = bcn_idx; i < ARRAY_SIZE(dev->beacons); i++) {
-		if (!(dev->beacon_data_mask & BIT(i)))
-			break;
-
-		__mt76x02_mac_set_beacon(dev, i, NULL);
-	}
-
-	mt76_rmw_field(dev, MT_MAC_BSSID_DW1, MT_MAC_BSSID_DW1_MBEACON_N,
-		       bcn_idx - 1);
+	dev_kfree_skb(dev->beacons[vif_idx]);
+	dev->beacons[vif_idx] = skb;
+	__mt76x02_mac_set_beacon(dev, vif_idx, skb);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon);
@@ -115,6 +105,7 @@ void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
 	} else {
 		dev->mt76.beacon_mask &= ~BIT(mvif->idx);
 		mt76x02_mac_set_beacon(dev, mvif->idx, NULL);
+		mt76_set(dev, MT_BCN_BYPASS_MASK, BIT(mvif->idx));
 	}
 
 	if (!!old_mask == !!dev->mt76.beacon_mask)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
index 7d946aa77182..26853f7acba9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
@@ -205,6 +205,7 @@ int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
 			   struct sk_buff *skb);
 void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
 				   struct ieee80211_vif *vif, bool enable);
+void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev);
 
 void mt76x02_edcca_init(struct mt76x02_dev *dev);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 4e2371c926d8..644bc8c284cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -24,10 +24,15 @@ static void mt76x02_pre_tbtt_tasklet(unsigned long arg)
 
 	mt76x02_resync_beacon_timer(dev);
 
+	/* Prevent corrupt transmissions during update */
+	mt76_set(dev, MT_BCN_BYPASS_MASK, 0xffff);
+
 	ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
 		IEEE80211_IFACE_ITER_RESUME_ALL,
 		mt76x02_update_beacon_iter, dev);
 
+	mt76x02_mac_set_beacon_finish(dev);
+
 	mt76_csa_check(&dev->mt76);
 
 	if (dev->mt76.csa_complete)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index d03d3c8e296c..0b3437a30b02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -208,6 +208,9 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 
 	mt76x02_resync_beacon_timer(dev);
 
+	/* Prevent corrupt transmissions during update */
+	mt76_set(dev, MT_BCN_BYPASS_MASK, 0xffff);
+
 	ieee80211_iterate_active_interfaces(mt76_hw(dev),
 		IEEE80211_IFACE_ITER_RESUME_ALL,
 		mt76x02_update_beacon_iter, dev);
@@ -220,6 +223,8 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 		mt76x02_mac_set_beacon(dev, i, skb);
 	}
 
+	mt76x02_mac_set_beacon_finish(dev);
+
 	mt76x02u_restart_pre_tbtt_timer(dev);
 }
 
-- 
2.24.0

