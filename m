Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B782F3E43FC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 12:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhHIKh4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 06:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233514AbhHIKhz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 06:37:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB25A60F35;
        Mon,  9 Aug 2021 10:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628505455;
        bh=KT7ef+AGTd85lOajjPA7Ch96KOfm6tONKZBdxV5octI=;
        h=From:To:Cc:Subject:Date:From;
        b=a8CLJ4nAi2Xb5esHFczufZTrtbflEOerjd9LY2EdtjQ8NKigxI6OVgPgLfN8x1Rjj
         c5ptIIYzZ2ag9O0GtvipsqNUmrjXFBM9IwwkzuXu2Rq1Hr4Osbc6fz/elBRngB3iKu
         Zso3W1PtzG0djhP3JQ/PjONXRPfV6EXW5xBU7aRdWYVtc88MnTo22OBejFePdqa7No
         Xx2Q1iDmOhBUhnaw1EvJ1Iud6JGGEYWabfLdFT3L7mZzdvSR2i39EO+c2ZexfvFi7K
         7nI9raM1j4MkHmLCKVl1Nanl1BMYZmgfn7lbmRhWRGIUjKeWMJaLJ2wB58Fw5nCdC9
         6AXBzQLUx2Fww==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: introduce mt7921_mcu_set_beacon_filter utility routine
Date:   Mon,  9 Aug 2021 12:37:22 +0200
Message-Id: <838dac6060bd2659ab6997e0a930325283d1b7c1.1628505383.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7921_mcu_set_beacon_filter utility routine in order to
remove duplicated code for hw beacon filtering.
Move mt7921_pm_interface_iter in debugfs since it is just used there.
Make the following routine static:
- mt7921_pm_interface_iter
- mt7921_mcu_uni_bss_bcnft
- mt7921_mcu_set_bss_pm

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7921/debugfs.c   | 20 +++++---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 33 +------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 47 ++++++++++---------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  8 ++--
 4 files changed, 45 insertions(+), 63 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 4c89c4ac8031..29a24e768617 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -255,30 +255,38 @@ mt7921_txpwr(struct seq_file *s, void *data)
 	return 0;
 }
 
+static void
+mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt7921_dev *dev = priv;
+
+	mt7921_mcu_set_beacon_filter(dev, vif, dev->pm.enable);
+}
+
 static int
 mt7921_pm_set(void *data, u64 val)
 {
 	struct mt7921_dev *dev = data;
 	struct mt76_connac_pm *pm = &dev->pm;
-	struct mt76_phy *mphy = dev->phy.mt76;
-
-	if (val == pm->enable)
-		return 0;
 
 	mt7921_mutex_acquire(dev);
 
+	if (val == pm->enable)
+		goto out;
+
 	if (!pm->enable) {
 		pm->stats.last_wake_event = jiffies;
 		pm->stats.last_doze_event = jiffies;
 	}
 	pm->enable = val;
 
-	ieee80211_iterate_active_interfaces(mphy->hw,
+	ieee80211_iterate_active_interfaces(mt76_hw(dev),
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
-					    mt7921_pm_interface_iter, mphy->priv);
+					    mt7921_pm_interface_iter, dev);
 
 	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
 
+out:
 	mt7921_mutex_release(dev);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index b121a0e369c7..7ce014de3443 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -526,36 +526,6 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
 	mt7921_mutex_release(dev);
 }
 
-static int
-mt7921_bss_bcnft_apply(struct mt7921_dev *dev, struct ieee80211_vif *vif,
-		       bool assoc)
-{
-	int ret;
-
-	if (!dev->pm.enable)
-		return 0;
-
-	if (assoc) {
-		ret = mt7921_mcu_uni_bss_bcnft(dev, vif, true);
-		if (ret)
-			return ret;
-
-		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
-		mt76_set(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
-
-		return 0;
-	}
-
-	ret = mt7921_mcu_set_bss_pm(dev, vif, false);
-	if (ret)
-		return ret;
-
-	vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
-	mt76_clear(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
-
-	return 0;
-}
-
 static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *info,
@@ -585,7 +555,8 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ASSOC) {
 		mt7921_mcu_sta_update(dev, NULL, vif, true,
 				      MT76_STA_INFO_STATE_ASSOC);
-		mt7921_bss_bcnft_apply(dev, vif, info->assoc);
+		if (dev->pm.enable)
+			mt7921_mcu_set_beacon_filter(dev, vif, info->assoc);
 	}
 
 	if (changed & BSS_CHANGED_ARP_FILTER) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 8d3cf4f99141..3195435ea3d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1196,8 +1196,9 @@ int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 				 &ps_req, sizeof(ps_req), true);
 }
 
-int mt7921_mcu_uni_bss_bcnft(struct mt7921_dev *dev, struct ieee80211_vif *vif,
-			     bool enable)
+static int
+mt7921_mcu_uni_bss_bcnft(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+			 bool enable)
 {
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
 	struct {
@@ -1231,8 +1232,9 @@ int mt7921_mcu_uni_bss_bcnft(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 				 &bcnft_req, sizeof(bcnft_req), true);
 }
 
-int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
-			  bool enable)
+static int
+mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		      bool enable)
 {
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
 	struct {
@@ -1381,31 +1383,34 @@ int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
 	return err;
 }
 
-void
-mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+int mt7921_mcu_set_beacon_filter(struct mt7921_dev *dev,
+				 struct ieee80211_vif *vif,
+				 bool enable)
 {
-	struct mt7921_phy *phy = priv;
-	struct mt7921_dev *dev = phy->dev;
 	struct ieee80211_hw *hw = mt76_hw(dev);
-	int ret;
-
-	if (dev->pm.enable)
-		ret = mt7921_mcu_uni_bss_bcnft(dev, vif, true);
-	else
-		ret = mt7921_mcu_set_bss_pm(dev, vif, false);
+	int err;
 
-	if (ret)
-		return;
+	if (enable) {
+		err = mt7921_mcu_uni_bss_bcnft(dev, vif, true);
+		if (err)
+			return err;
 
-	if (dev->pm.enable) {
 		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
 		ieee80211_hw_set(hw, CONNECTION_MONITOR);
 		mt76_set(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
-	} else {
-		vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
-		__clear_bit(IEEE80211_HW_CONNECTION_MONITOR, hw->flags);
-		mt76_clear(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
+
+		return 0;
 	}
+
+	err = mt7921_mcu_set_bss_pm(dev, vif, false);
+	if (err)
+		return err;
+
+	vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
+	__clear_bit(IEEE80211_HW_CONNECTION_MONITOR, hw->flags);
+	mt76_clear(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
+
+	return 0;
 }
 
 int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 8722df3b9a29..db7fb3b9106d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -359,6 +359,9 @@ void mt7921_set_stream_he_caps(struct mt7921_phy *phy);
 void mt7921_update_channel(struct mt76_phy *mphy);
 int mt7921_init_debugfs(struct mt7921_dev *dev);
 
+int mt7921_mcu_set_beacon_filter(struct mt7921_dev *dev,
+				 struct ieee80211_vif *vif,
+				 bool enable);
 int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
@@ -367,17 +370,12 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
 			 bool enable);
 void mt7921_scan_work(struct work_struct *work);
 int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif);
-int mt7921_mcu_uni_bss_bcnft(struct mt7921_dev *dev, struct ieee80211_vif *vif,
-			     bool enable);
-int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
-			  bool enable);
 int __mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev);
 void mt7921_pm_wake_work(struct work_struct *work);
 void mt7921_pm_power_save_work(struct work_struct *work);
 bool mt7921_wait_for_mcu_init(struct mt7921_dev *dev);
-void mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif);
 void mt7921_coredump_work(struct work_struct *work);
 int mt7921_wfsys_reset(struct mt7921_dev *dev);
 int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr);
-- 
2.31.1

