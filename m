Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE251058F7
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 19:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKUSA0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 13:00:26 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:53957 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKUSA0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 13:00:26 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id F376E580073;
        Thu, 21 Nov 2019 19:00:23 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v8 2/6] mt76: mt76x02: split beaconing
Date:   Thu, 21 Nov 2019 18:59:57 +0100
Message-Id: <20191121180001.22451-3-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121180001.22451-1-markus.theil@tu-ilmenau.de>
References: <20191121180001.22451-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sending beacons to the hardware always happens in batches. In order to
speed up beacon processing on usb devices, this patch splits out common
code an calls it only once (mt76x02_mac_set_beacon_prepare,
mt76x02_mac_set_beacon_finish).

Beacons are sequentially written into the beacon memory area, by
tracking its usage with the dev->beacon_data_mask. MBSS support
is fixed by reversing the beacon_data_mask when setting it inverted
as the bypass mask.

The code is also adapted for the mmio part of the driver, but should not
have any performance implication there.

MBSS tests were performed with AVM AC860 USB NIC with temporary support
for 5 BSS'. Different combinations of active vifs were created and
brought up. Afterwards connection and data transfer was tested for the
announced BSS'.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  1 -
 .../wireless/mediatek/mt76/mt76x02_beacon.c   | 56 +++++++------------
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  2 +
 .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  5 +-
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  4 ++
 .../wireless/mediatek/mt76/mt76x02_usb_core.c | 14 ++---
 6 files changed, 34 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 0ca0bbfe8769..944bdc9b249b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -93,7 +93,6 @@ struct mt76x02_dev {
 
 	const struct mt76x02_beacon_ops *beacon_ops;
 
-	struct sk_buff *beacons[8];
 	u8 beacon_data_mask;
 
 	u8 tbtt_count;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index 403866496640..b01a6745ed47 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -6,6 +6,7 @@
  */
 
 #include "mt76x02.h"
+#include <linux/bitrev.h>
 
 static void mt76x02_set_beacon_offsets(struct mt76x02_dev *dev)
 {
@@ -47,54 +48,38 @@ __mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 bcn_idx,
 	int beacon_len = dev->beacon_ops->slot_size;
 	int beacon_addr = MT_BEACON_BASE + (beacon_len * bcn_idx);
 	int ret = 0;
-	int i;
-
-	/* Prevent corrupt transmissions during update */
-	mt76_set(dev, MT_BCN_BYPASS_MASK, BIT(bcn_idx));
 
 	if (skb) {
 		ret = mt76x02_write_beacon(dev, beacon_addr, skb);
 		if (!ret)
 			dev->beacon_data_mask |= BIT(bcn_idx);
-	} else {
-		dev->beacon_data_mask &= ~BIT(bcn_idx);
 	}
 
-	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~dev->beacon_data_mask);
-
 	return ret;
 }
 
-int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
-			   struct sk_buff *skb)
+void mt76x02_mac_set_beacon_prepare(struct mt76x02_dev *dev)
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
+	/* Prevent corrupt transmissions during update */
+	mt76_set(dev, MT_BCN_BYPASS_MASK, 0xffff);
+	dev->beacon_data_mask = 0;
+}
+EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon_prepare);
 
-	for (i = bcn_idx; i < ARRAY_SIZE(dev->beacons); i++) {
-		if (!(dev->beacon_data_mask & BIT(i)))
-			break;
+void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev)
+{
+	mt76_wr(dev, MT_BCN_BYPASS_MASK,
+		0xff00 | ~bitrev8(dev->beacon_data_mask));
+}
+EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon_finish);
 
-		__mt76x02_mac_set_beacon(dev, i, NULL);
-	}
+int mt76x02_mac_set_beacon(struct mt76x02_dev *dev,
+			   struct sk_buff *skb)
+{
+	int bcn_idx = ffz(dev->beacon_data_mask);
 
-	mt76_rmw_field(dev, MT_MAC_BSSID_DW1, MT_MAC_BSSID_DW1_MBEACON_N,
-		       bcn_idx - 1);
+	__mt76x02_mac_set_beacon(dev, bcn_idx, skb);
+	dev_kfree_skb(skb);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon);
@@ -114,7 +99,6 @@ void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
 		dev->mt76.beacon_mask |= BIT(mvif->idx);
 	} else {
 		dev->mt76.beacon_mask &= ~BIT(mvif->idx);
-		mt76x02_mac_set_beacon(dev, mvif->idx, NULL);
 	}
 
 	if (!!old_mask == !!dev->mt76.beacon_mask)
@@ -180,7 +164,7 @@ mt76x02_update_beacon_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (!skb)
 		return;
 
-	mt76x02_mac_set_beacon(dev, mvif->idx, skb);
+	mt76x02_mac_set_beacon(dev, skb);
 }
 EXPORT_SYMBOL_GPL(mt76x02_update_beacon_iter);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 4460548f346a..285ab0f491d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -741,6 +741,8 @@ void mt76x02_mac_setaddr(struct mt76x02_dev *dev, const u8 *addr)
 		get_unaligned_le16(dev->mt76.macaddr + 4) |
 		FIELD_PREP(MT_MAC_BSSID_DW1_MBSS_MODE, 3) | /* 8 APs + 8 STAs */
 		MT_MAC_BSSID_DW1_MBSS_LOCAL_BIT);
+	/* enable 7 additional beacon slots and control them with bypass mask */
+	mt76_rmw_field(dev, MT_MAC_BSSID_DW1, MT_MAC_BSSID_DW1_MBEACON_N, 7);
 
 	for (i = 0; i < 16; i++)
 		mt76x02_mac_set_bssid(dev, i, null_addr);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
index 7d946aa77182..f67f66f65ee0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
@@ -201,10 +201,11 @@ void mt76x02_mac_work(struct work_struct *work);
 
 void mt76x02_mac_cc_reset(struct mt76x02_dev *dev);
 void mt76x02_mac_set_bssid(struct mt76x02_dev *dev, u8 idx, const u8 *addr);
-int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
-			   struct sk_buff *skb);
+int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, struct sk_buff *skb);
 void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
 				   struct ieee80211_vif *vif, bool enable);
+void mt76x02_mac_set_beacon_prepare(struct mt76x02_dev *dev);
+void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev);
 
 void mt76x02_edcca_init(struct mt76x02_dev *dev);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 4e2371c926d8..ae35780aaff1 100644
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
index d03d3c8e296c..90c024f12302 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -208,6 +208,8 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 
 	mt76x02_resync_beacon_timer(dev);
 
+	mt76x02_mac_set_beacon_prepare(dev);
+
 	ieee80211_iterate_active_interfaces(mt76_hw(dev),
 		IEEE80211_IFACE_ITER_RESUME_ALL,
 		mt76x02_update_beacon_iter, dev);
@@ -217,9 +219,11 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 
 	for (i = nbeacons; i < N_BCN_SLOTS; i++) {
 		skb = __skb_dequeue(&data.q);
-		mt76x02_mac_set_beacon(dev, i, skb);
+		mt76x02_mac_set_beacon(dev, skb);
 	}
 
+	mt76x02_mac_set_beacon_finish(dev);
+
 	mt76x02u_restart_pre_tbtt_timer(dev);
 }
 
@@ -244,19 +248,11 @@ static void mt76x02u_pre_tbtt_enable(struct mt76x02_dev *dev, bool en)
 
 static void mt76x02u_beacon_enable(struct mt76x02_dev *dev, bool en)
 {
-	int i;
-
 	if (WARN_ON_ONCE(!dev->mt76.beacon_int))
 		return;
 
 	if (en) {
 		mt76x02u_start_pre_tbtt_timer(dev);
-	} else {
-		/* Timer is already stopped, only clean up
-		 * PS buffered frames if any.
-		 */
-		for (i = 0; i < N_BCN_SLOTS; i++)
-			mt76x02_mac_set_beacon(dev, i, NULL);
 	}
 }
 
-- 
2.24.0

