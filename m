Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DDC45833D
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Nov 2021 13:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbhKUMPw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Nov 2021 07:15:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235783AbhKUMPw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Nov 2021 07:15:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C029660E54;
        Sun, 21 Nov 2021 12:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637496767;
        bh=8M+uUUTCRtudJ275CkcNk9kKGQRtCxuIQ+nqyk0eAc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1T1JalFt2J4a1Y9HnDwNPb4h4SKLS+RrXuHoqWBsAZ/0VQqUu2zleFVbsHUE1dW5
         au6rXjh6U/OAbAbFXNGhL0kcGiZ2CINoMvnbyN9iIJo6MR+J3mqUbVzxFvjTXLhXNd
         +kZWItKblvl0E0tGoCS6uj8+/UUG2EcS4ZTuV/6pAgyTbW4Vrn5k7rJL/yvLTeslnm
         lB+uKxqMUeClrngnNkKYyAgi7L7K0AW9D5axF77ba40gRa19xUEhC5dorSLVLljqZ3
         dxoGX4W4+G1sQ5lnoO7Zf0y29Bh8JrDwwEq4rWwVcQLBuSW63Y4vhbbVbD5GLSUEpp
         b3o/uHfl0tAFA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 2/2] mt76: mt76x02: introduce SAR support
Date:   Sun, 21 Nov 2021 13:12:25 +0100
Message-Id: <9e479a1e69f078de9986cca8c8901d5d83a12f0b.1637496644.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637496643.git.lorenzo@kernel.org>
References: <cover.1637496643.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add SAR spec support to mt76x02 driver to allow configuring SAR power
limitations on the frequency ranges from the userland.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76x0/init.c  |  5 ++-
 .../net/wireless/mediatek/mt76/mt76x0/main.c  | 34 +++++++++++++++++--
 .../wireless/mediatek/mt76/mt76x0/mt76x0.h    |  2 ++
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |  1 +
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  1 +
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c | 11 +++++-
 .../net/wireless/mediatek/mt76/mt76x2/init.c  | 29 ++++++++++++++++
 .../wireless/mediatek/mt76/mt76x2/mt76x2.h    |  2 ++
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  |  5 +--
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  |  7 +++-
 .../wireless/mediatek/mt76/mt76x2/usb_init.c  |  4 ++-
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |  9 +++--
 13 files changed, 101 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
index 0bac39bf3b66..66d47c70111a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
@@ -237,7 +237,10 @@ int mt76x0_register_device(struct mt76x02_dev *dev)
 {
 	int ret;
 
-	mt76x02_init_device(dev);
+	ret = mt76x02_init_device(dev);
+	if (ret)
+		return ret;
+
 	mt76x02_config_mac_addr_list(dev);
 
 	ret = mt76_register_device(&dev->mt76, true, mt76x02_rates,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
index 700ae9c12f1d..07380cce8755 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -31,6 +31,32 @@ mt76x0_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	mt76_txq_schedule_all(&dev->mphy);
 }
 
+int mt76x0_set_sar_specs(struct ieee80211_hw *hw,
+			 const struct cfg80211_sar_specs *sar)
+{
+	int err = -EINVAL, power = hw->conf.power_level * 2;
+	struct mt76x02_dev *dev = hw->priv;
+	struct mt76_phy *mphy = &dev->mphy;
+
+	mutex_lock(&dev->mt76.mutex);
+	if (!cfg80211_chandef_valid(&mphy->chandef))
+		goto out;
+
+	err = mt76_init_sar_power(hw, sar);
+	if (err)
+		goto out;
+
+	dev->txpower_conf = mt76_get_sar_power(mphy, mphy->chandef.chan,
+					       power);
+	if (test_bit(MT76_STATE_RUNNING, &mphy->state))
+		mt76x0_phy_set_txpower(dev);
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt76x0_set_sar_specs);
+
 int mt76x0_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct mt76x02_dev *dev = hw->priv;
@@ -44,9 +70,13 @@ int mt76x0_config(struct ieee80211_hw *hw, u32 changed)
 	}
 
 	if (changed & IEEE80211_CONF_CHANGE_POWER) {
-		dev->txpower_conf = hw->conf.power_level * 2;
+		struct mt76_phy *mphy = &dev->mphy;
 
-		if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
+		dev->txpower_conf = hw->conf.power_level * 2;
+		dev->txpower_conf = mt76_get_sar_power(mphy,
+						       mphy->chandef.chan,
+						       dev->txpower_conf);
+		if (test_bit(MT76_STATE_RUNNING, &mphy->state))
 			mt76x0_phy_set_txpower(dev);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
index 6953f253a28a..99dcb8feb9f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
@@ -49,6 +49,8 @@ void mt76x0_chip_onoff(struct mt76x02_dev *dev, bool enable, bool reset);
 void mt76x0_mac_stop(struct mt76x02_dev *dev);
 
 int mt76x0_config(struct ieee80211_hw *hw, u32 changed);
+int mt76x0_set_sar_specs(struct ieee80211_hw *hw,
+			 const struct cfg80211_sar_specs *sar);
 
 /* PHY */
 void mt76x0_phy_init(struct mt76x02_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index f19228fc5a70..9277ff38b7a2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -85,6 +85,7 @@ static const struct ieee80211_ops mt76x0e_ops = {
 	.set_rts_threshold = mt76x02_set_rts_threshold,
 	.get_antenna = mt76_get_antenna,
 	.reconfig_complete = mt76x02_reconfig_complete,
+	.set_sar_specs = mt76x0_set_sar_specs,
 };
 
 static int mt76x0e_init_hardware(struct mt76x02_dev *dev, bool resume)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index f2b2fa733845..436daf6d6d86 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -141,6 +141,7 @@ static const struct ieee80211_ops mt76x0u_ops = {
 	.set_tim = mt76_set_tim,
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.get_antenna = mt76_get_antenna,
+	.set_sar_specs = mt76x0_set_sar_specs,
 };
 
 static int mt76x0u_init_hardware(struct mt76x02_dev *dev, bool reset)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 4d58c2c1c0ac..44d1a92d9a90 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -133,7 +133,7 @@ struct mt76x02_dev {
 
 extern struct ieee80211_rate mt76x02_rates[12];
 
-void mt76x02_init_device(struct mt76x02_dev *dev);
+int mt76x02_init_device(struct mt76x02_dev *dev);
 void mt76x02_configure_filter(struct ieee80211_hw *hw,
 			      unsigned int changed_flags,
 			      unsigned int *total_flags, u64 multicast);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 1f17d86ff755..06f8fb883ead 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -138,7 +138,7 @@ mt76x02_led_set_brightness(struct led_classdev *led_cdev,
 		mt76x02_led_set_config(mdev, 0xff, 0);
 }
 
-void mt76x02_init_device(struct mt76x02_dev *dev)
+int mt76x02_init_device(struct mt76x02_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct wiphy *wiphy = hw->wiphy;
@@ -174,6 +174,13 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 	}
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
+	wiphy->sar_capa = &mt76_sar_capa;
+	dev->mt76.phy.frp = devm_kcalloc(dev->mt76.dev,
+					 wiphy->sar_capa->num_freq_ranges,
+					 sizeof(struct mt76_freq_range_power),
+					 GFP_KERNEL);
+	if (!dev->mt76.phy.frp)
+		return -ENOMEM;
 
 	hw->sta_data_size = sizeof(struct mt76x02_sta);
 	hw->vif_data_size = sizeof(struct mt76x02_vif);
@@ -197,6 +204,8 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 		dev->mphy.chainmask = 0x101;
 		dev->mphy.antenna_mask = 1;
 	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76x02_init_device);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/init.c
index a92a479aebaa..7b01a06d7f8d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/init.c
@@ -8,6 +8,35 @@
 #include "eeprom.h"
 #include "../mt76x02_phy.h"
 
+int mt76x2_set_sar_specs(struct ieee80211_hw *hw,
+			 const struct cfg80211_sar_specs *sar)
+{
+	int err = -EINVAL, power = hw->conf.power_level * 2;
+	struct mt76x02_dev *dev = hw->priv;
+	struct mt76_phy *mphy = &dev->mphy;
+
+	mutex_lock(&dev->mt76.mutex);
+	if (!cfg80211_chandef_valid(&mphy->chandef))
+		goto out;
+
+	err = mt76_init_sar_power(hw, sar);
+	if (err)
+		goto out;
+
+	dev->txpower_conf = mt76_get_sar_power(mphy, mphy->chandef.chan,
+					       power);
+	/* convert to per-chain power for 2x2 devices */
+	dev->txpower_conf -= 6;
+
+	if (test_bit(MT76_STATE_RUNNING, &mphy->state))
+		mt76x2_phy_set_txpower(dev);
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt76x2_set_sar_specs);
+
 static void
 mt76x2_set_wlan_state(struct mt76x02_dev *dev, bool enable)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h b/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h
index d01f47c83eb1..be1217329a77 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h
@@ -41,6 +41,8 @@ extern const struct ieee80211_ops mt76x2_ops;
 int mt76x2_register_device(struct mt76x02_dev *dev);
 int mt76x2_resume_device(struct mt76x02_dev *dev);
 
+int mt76x2_set_sar_specs(struct ieee80211_hw *hw,
+			 const struct cfg80211_sar_specs *sar);
 void mt76x2_phy_power_on(struct mt76x02_dev *dev);
 void mt76x2_stop_hardware(struct mt76x02_dev *dev);
 int mt76x2_eeprom_init(struct mt76x02_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
index c6fa8cf92529..e38e8e5685c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
@@ -292,8 +292,9 @@ int mt76x2_register_device(struct mt76x02_dev *dev)
 	int ret;
 
 	INIT_DELAYED_WORK(&dev->cal_work, mt76x2_phy_calibrate);
-
-	mt76x02_init_device(dev);
+	ret = mt76x02_init_device(dev);
+	if (ret)
+		return ret;
 
 	ret = mt76x2_init_hardware(dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index 933125b07ea3..b38bb7a2362b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -78,8 +78,12 @@ mt76x2_config(struct ieee80211_hw *hw, u32 changed)
 	}
 
 	if (changed & IEEE80211_CONF_CHANGE_POWER) {
-		dev->txpower_conf = hw->conf.power_level * 2;
+		struct mt76_phy *mphy = &dev->mphy;
 
+		dev->txpower_conf = hw->conf.power_level * 2;
+		dev->txpower_conf = mt76_get_sar_power(mphy,
+						       mphy->chandef.chan,
+						       dev->txpower_conf);
 		/* convert to per-chain power for 2x2 devices */
 		dev->txpower_conf -= 6;
 
@@ -155,5 +159,6 @@ const struct ieee80211_ops mt76x2_ops = {
 	.get_antenna = mt76_get_antenna,
 	.set_rts_threshold = mt76x02_set_rts_threshold,
 	.reconfig_complete = mt76x02_reconfig_complete,
+	.set_sar_specs = mt76x2_set_sar_specs,
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
index 85dcdc22fbeb..33a14365ec9b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
@@ -194,7 +194,9 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 	int err;
 
 	INIT_DELAYED_WORK(&dev->cal_work, mt76x2u_phy_calibrate);
-	mt76x02_init_device(dev);
+	err = mt76x02_init_device(dev);
+	if (err)
+		return err;
 
 	err = mt76x2u_init_eeprom(dev);
 	if (err < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index b66836928d9d..ac07ed1f63a3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -78,12 +78,16 @@ mt76x2u_config(struct ieee80211_hw *hw, u32 changed)
 	}
 
 	if (changed & IEEE80211_CONF_CHANGE_POWER) {
-		dev->txpower_conf = hw->conf.power_level * 2;
+		struct mt76_phy *mphy = &dev->mphy;
 
+		dev->txpower_conf = hw->conf.power_level * 2;
+		dev->txpower_conf = mt76_get_sar_power(mphy,
+						       mphy->chandef.chan,
+						       dev->txpower_conf);
 		/* convert to per-chain power for 2x2 devices */
 		dev->txpower_conf -= 6;
 
-		if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
+		if (test_bit(MT76_STATE_RUNNING, &mphy->state))
 			mt76x2_phy_set_txpower(dev);
 	}
 
@@ -121,4 +125,5 @@ const struct ieee80211_ops mt76x2u_ops = {
 	.set_tim = mt76_set_tim,
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.get_antenna = mt76_get_antenna,
+	.set_sar_specs = mt76x2_set_sar_specs,
 };
-- 
2.31.1

