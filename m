Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE9ADD76
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 10:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfD2INV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 04:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbfD2INV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 04:13:21 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CB86206BF;
        Mon, 29 Apr 2019 08:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556525599;
        bh=a8fcj5gJRrYH3iVhHICouLUSJqGvWmiMzw+l/t3eZq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vku5KiUvI6nV8PEsnvHY9k5OfGP52d6rhc/wfbtpbvUmLToHD2SE4F7ey6ko3/T/s
         KP5l6Kmi+RKaAu9IHiFsVZbdf0mYz47RH8CC1K+vgGX20C6NEgxYQMOtQVDFDVw9Pc
         peX4XI/axilnQVdPcaXzz82+A3WdqTkgDsM/6ilE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH v2 3/5] mt76: move beacon_mask in mt76_dev
Date:   Mon, 29 Apr 2019 10:13:00 +0200
Message-Id: <611900c45243c8c8cb2a5d59e4008c91c57e1ced.1556525110.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556525110.git.lorenzo@kernel.org>
References: <cover.1556525110.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move beacon_mask in mt76_dev data structure since it is used by
all drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h       |  1 +
 .../net/wireless/mediatek/mt76/mt7603/beacon.c  | 17 +++++++++--------
 .../net/wireless/mediatek/mt76/mt7603/mt7603.h  |  2 --
 drivers/net/wireless/mediatek/mt76/mt76x02.h    |  1 -
 .../net/wireless/mediatek/mt76/mt76x02_beacon.c | 16 ++++++++--------
 .../net/wireless/mediatek/mt76/mt76x02_mac.c    |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c   |  6 +++---
 .../wireless/mediatek/mt76/mt76x02_usb_core.c   |  7 ++++---
 8 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index be0ca4af7254..fb0ba1500d89 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -470,6 +470,7 @@ struct mt76_dev {
 	u16 chainmask;
 
 	int beacon_int;
+	u8 beacon_mask;
 
 	struct mt76_sband sband_2g;
 	struct mt76_sband sband_5g;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
index 64e15d566283..f3e7406e731f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
@@ -16,7 +16,7 @@ mt7603_update_beacon_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	struct mt7603_vif *mvif = (struct mt7603_vif *)vif->drv_priv;
 	struct sk_buff *skb = NULL;
 
-	if (!(dev->beacon_mask & BIT(mvif->idx)))
+	if (!(dev->mt76.beacon_mask & BIT(mvif->idx)))
 		return;
 
 	skb = ieee80211_beacon_get(mt76_hw(dev), vif);
@@ -48,7 +48,7 @@ mt7603_add_buffered_bc(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	struct ieee80211_tx_info *info;
 	struct sk_buff *skb;
 
-	if (!(dev->beacon_mask & BIT(mvif->idx)))
+	if (!(dev->mt76.beacon_mask & BIT(mvif->idx)))
 		return;
 
 	skb = ieee80211_get_buffered_bc(mt76_hw(dev), vif);
@@ -134,7 +134,7 @@ void mt7603_pre_tbtt_tasklet(unsigned long arg)
 out:
 	mt76_queue_tx_cleanup(dev, MT_TXQ_BEACON, false);
 	if (dev->mt76.q_tx[MT_TXQ_BEACON].q->queued >
-	    hweight8(dev->beacon_mask))
+	    hweight8(dev->mt76.beacon_mask))
 		dev->beacon_check++;
 }
 
@@ -144,12 +144,12 @@ void mt7603_beacon_set_timer(struct mt7603_dev *dev, int idx, int intval)
 
 	if (idx >= 0) {
 		if (intval)
-			dev->beacon_mask |= BIT(idx);
+			dev->mt76.beacon_mask |= BIT(idx);
 		else
-			dev->beacon_mask &= ~BIT(idx);
+			dev->mt76.beacon_mask &= ~BIT(idx);
 	}
 
-	if (!dev->beacon_mask || (!intval && idx < 0)) {
+	if (!dev->mt76.beacon_mask || (!intval && idx < 0)) {
 		mt7603_irq_disable(dev, MT_INT_MAC_IRQ3);
 		mt76_clear(dev, MT_ARB_SCR, MT_ARB_SCR_BCNQ_OPMODE_MASK);
 		mt76_wr(dev, MT_HW_INT_MASK(3), 0);
@@ -174,10 +174,11 @@ void mt7603_beacon_set_timer(struct mt7603_dev *dev, int idx, int intval)
 
 	mt76_set(dev, MT_WF_ARB_BCN_START,
 		 MT_WF_ARB_BCN_START_BSSn(0) |
-		 ((dev->beacon_mask >> 1) * MT_WF_ARB_BCN_START_BSS0n(1)));
+		 ((dev->mt76.beacon_mask >> 1) *
+		  MT_WF_ARB_BCN_START_BSS0n(1)));
 	mt7603_irq_enable(dev, MT_INT_MAC_IRQ3);
 
-	if (dev->beacon_mask & ~BIT(0))
+	if (dev->mt76.beacon_mask & ~BIT(0))
 		mt76_set(dev, MT_LPON_SBTOR(0), MT_LPON_SBTOR_SUB_BSS_EN);
 	else
 		mt76_clear(dev, MT_LPON_SBTOR(0), MT_LPON_SBTOR_SUB_BSS_EN);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index a2cda08ca70b..8f5ae1644a92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -125,8 +125,6 @@ struct mt7603_dev {
 
 	s8 sensitivity;
 
-	u8 beacon_mask;
-
 	u8 beacon_check;
 	u8 tx_hang_check;
 	u8 tx_dma_check;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index dde1f64390ce..f754790dada4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -102,7 +102,6 @@ struct mt76x02_dev {
 	u32 aggr_stats[32];
 
 	struct sk_buff *beacons[8];
-	u8 beacon_mask;
 	u8 beacon_data_mask;
 
 	u8 tbtt_count;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index 985a9b5d0e45..e196b9c0a686 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -119,23 +119,23 @@ static void
 __mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev, u8 vif_idx,
 				bool val, struct sk_buff *skb)
 {
-	u8 old_mask = dev->beacon_mask;
+	u8 old_mask = dev->mt76.beacon_mask;
 	bool en;
 	u32 reg;
 
 	if (val) {
-		dev->beacon_mask |= BIT(vif_idx);
+		dev->mt76.beacon_mask |= BIT(vif_idx);
 		if (skb)
 			mt76x02_mac_set_beacon(dev, vif_idx, skb);
 	} else {
-		dev->beacon_mask &= ~BIT(vif_idx);
+		dev->mt76.beacon_mask &= ~BIT(vif_idx);
 		mt76x02_mac_set_beacon(dev, vif_idx, NULL);
 	}
 
-	if (!!old_mask == !!dev->beacon_mask)
+	if (!!old_mask == !!dev->mt76.beacon_mask)
 		return;
 
-	en = dev->beacon_mask;
+	en = dev->mt76.beacon_mask;
 
 	reg = MT_BEACON_TIME_CFG_BEACON_TX |
 	      MT_BEACON_TIME_CFG_TBTT_EN |
@@ -156,7 +156,7 @@ void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
 	if (mt76_is_usb(dev))
 		skb = ieee80211_beacon_get(mt76_hw(dev), vif);
 
-	if (!dev->beacon_mask)
+	if (!dev->mt76.beacon_mask)
 		dev->tbtt_count = 0;
 
 	__mt76x02_mac_set_beacon_enable(dev, vif_idx, val, skb);
@@ -203,7 +203,7 @@ mt76x02_update_beacon_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
 	struct sk_buff *skb = NULL;
 
-	if (!(dev->beacon_mask & BIT(mvif->idx)))
+	if (!(dev->mt76.beacon_mask & BIT(mvif->idx)))
 		return;
 
 	skb = ieee80211_beacon_get(mt76_hw(dev), vif);
@@ -223,7 +223,7 @@ mt76x02_add_buffered_bc(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	struct ieee80211_tx_info *info;
 	struct sk_buff *skb;
 
-	if (!(dev->beacon_mask & BIT(mvif->idx)))
+	if (!(dev->mt76.beacon_mask & BIT(mvif->idx)))
 		return;
 
 	skb = ieee80211_get_buffered_bc(mt76_hw(dev), vif);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 28851060aa0f..8e0294bfce9c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -1044,7 +1044,7 @@ void mt76x02_mac_work(struct work_struct *work)
 		dev->aggr_stats[idx++] += val >> 16;
 	}
 
-	if (!dev->beacon_mask)
+	if (!dev->mt76.beacon_mask)
 		mt76x02_check_mac_err(dev);
 
 	if (dev->ed_monitor)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 644706ab2893..31e0d4b03f6b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -415,7 +415,7 @@ static void mt76x02_reset_state(struct mt76x02_dev *dev)
 	}
 
 	dev->vif_mask = 0;
-	dev->beacon_mask = 0;
+	dev->mt76.beacon_mask = 0;
 }
 
 static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
@@ -438,7 +438,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	if (restart)
 		mt76x02_reset_state(dev);
 
-	if (dev->beacon_mask)
+	if (dev->mt76.beacon_mask)
 		mt76_clear(dev, MT_BEACON_TIME_CFG,
 			   MT_BEACON_TIME_CFG_BEACON_TX |
 			   MT_BEACON_TIME_CFG_TBTT_EN);
@@ -470,7 +470,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	if (dev->ed_monitor)
 		mt76_set(dev, MT_TXOP_CTRL_CFG, MT_TXOP_ED_CCA_EN);
 
-	if (dev->beacon_mask && !restart)
+	if (dev->mt76.beacon_mask && !restart)
 		mt76_set(dev, MT_BEACON_TIME_CFG,
 			 MT_BEACON_TIME_CFG_BEACON_TX |
 			 MT_BEACON_TIME_CFG_TBTT_EN);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 81cebd92a4e8..5b6ac1b364e1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -175,7 +175,7 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 	struct sk_buff *skb;
 	int i, nbeacons;
 
-	if (!dev->beacon_mask)
+	if (!dev->mt76.beacon_mask)
 		return;
 
 	mt76x02_resync_beacon_timer(dev);
@@ -184,7 +184,7 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 		IEEE80211_IFACE_ITER_RESUME_ALL,
 		mt76x02_update_beacon_iter, dev);
 
-	nbeacons = hweight8(dev->beacon_mask);
+	nbeacons = hweight8(dev->mt76.beacon_mask);
 	mt76x02_enqueue_buffered_bc(dev, &data, N_BCN_SLOTS - nbeacons);
 
 	for (i = nbeacons; i < N_BCN_SLOTS; i++) {
@@ -207,7 +207,8 @@ static enum hrtimer_restart mt76x02u_pre_tbtt_interrupt(struct hrtimer *timer)
 
 static void mt76x02u_pre_tbtt_enable(struct mt76x02_dev *dev, bool en)
 {
-	if (en && dev->beacon_mask && !hrtimer_active(&dev->pre_tbtt_timer))
+	if (en && dev->mt76.beacon_mask &&
+	    !hrtimer_active(&dev->pre_tbtt_timer))
 		mt76x02u_start_pre_tbtt_timer(dev);
 	if (!en)
 		mt76x02u_stop_pre_tbtt_timer(dev);
-- 
2.20.1

