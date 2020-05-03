Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449811C2D43
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2020 17:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgECPUT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 May 2020 11:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbgECPUS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 May 2020 11:20:18 -0400
Received: from localhost.localdomain (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A3F02071C;
        Sun,  3 May 2020 15:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588519216;
        bh=14a1Vhpl+yncgVywcXjwc4UmbVXy4zH54tsajo0fQ64=;
        h=From:To:Cc:Subject:Date:From;
        b=FNgwMhCN8FuTKN976yRYoJBHDvkRsiZLlLvinEr7shAlRMP0ScX7dIK3v/RD1l6Hk
         859a5d0bJqovd1d1MBwuYFLa6AFzW2V92ryTCHhhOEsR6bYB5Ccz3bshlwv2pjbQBN
         N2/6FRhIBYRJZ6GF2RQbCHaL/SKXM4A/pCQ0lAT4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: fix compilation error when CONFIG_PM is not defined
Date:   Sun,  3 May 2020 17:20:11 +0200
Message-Id: <d2ef4af35397e20ed90570f1fb9a9e346bdbd846.1588519179.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix compilation error reported by kbuild robot when CONFIG_PM is not
defined

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 18 ++--
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 91 ++++++++++---------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  7 +-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  7 +-
 5 files changed, 67 insertions(+), 58 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 61b2afb3fdb8..cfe024b71677 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -864,8 +864,9 @@ mt7615_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	return mt7615_mcu_sched_scan_enable(mphy->priv, vif, false);
 }
 
-static int __maybe_unused
-mt7615_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
+#ifdef CONFIG_PM
+static int mt7615_suspend(struct ieee80211_hw *hw,
+			  struct cfg80211_wowlan *wowlan)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
@@ -893,7 +894,7 @@ mt7615_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 	return err;
 }
 
-static int __maybe_unused mt7615_resume(struct ieee80211_hw *hw)
+static int mt7615_resume(struct ieee80211_hw *hw)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
@@ -928,8 +929,7 @@ static int __maybe_unused mt7615_resume(struct ieee80211_hw *hw)
 	return 0;
 }
 
-static void __maybe_unused
-mt7615_set_wakeup(struct ieee80211_hw *hw, bool enabled)
+static void mt7615_set_wakeup(struct ieee80211_hw *hw, bool enabled)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt76_dev *mdev = &dev->mt76;
@@ -937,13 +937,13 @@ mt7615_set_wakeup(struct ieee80211_hw *hw, bool enabled)
 	device_set_wakeup_enable(mdev->dev, enabled);
 }
 
-static void __maybe_unused
-mt7615_set_rekey_data(struct ieee80211_hw *hw,
-		      struct ieee80211_vif *vif,
-		      struct cfg80211_gtk_rekey_data *data)
+static void mt7615_set_rekey_data(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct cfg80211_gtk_rekey_data *data)
 {
 	mt7615_mcu_update_gtk_rekey(hw, vif, data);
 }
+#endif /* CONFIG_PM */
 
 const struct ieee80211_ops mt7615_ops = {
 	.tx = mt7615_tx,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index a4d90a8b347a..a62f15863fb4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2210,8 +2210,10 @@ int __mt7663_load_firmware(struct mt7615_dev *dev)
 		return -EIO;
 	}
 
-	if (IS_ENABLED(CONFIG_PM) && mt7615_firmware_offload(dev))
+#ifdef CONFIG_PM
+	if (mt7615_firmware_offload(dev))
 		dev->mt76.hw->wiphy->wowlan = &mt7615_wowlan_support;
+#endif /* CONFIG_PM */
 
 	dev_dbg(dev->mt76.dev, "Firmware init done\n");
 
@@ -2709,48 +2711,6 @@ void m7615_mcu_set_ps_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 				    &req, sizeof(req), false);
 }
 
-static int
-mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-		      bool enable)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct {
-		u8 bss_idx;
-		u8 dtim_period;
-		__le16 aid;
-		__le16 bcn_interval;
-		__le16 atim_window;
-		u8 uapsd;
-		u8 bmc_delivered_ac;
-		u8 bmc_triggered_ac;
-		u8 pad;
-	} req = {
-		.bss_idx = mvif->idx,
-		.aid = cpu_to_le16(vif->bss_conf.aid),
-		.dtim_period = vif->bss_conf.dtim_period,
-		.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
-	};
-	struct {
-		u8 bss_idx;
-		u8 pad[3];
-	} req_hdr = {
-		.bss_idx = mvif->idx,
-	};
-	int err;
-
-	if (vif->type != NL80211_IFTYPE_STATION ||
-	    !mt7615_firmware_offload(dev))
-		return -ENOTSUPP;
-
-	err = __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_ABORT,
-				  &req_hdr, sizeof(req_hdr), false);
-	if (err < 0 || !enable)
-		return err;
-
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_CONNECTED,
-				   &req, sizeof(req), false);
-}
-
 int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy)
 {
 	struct mt76_phy *mphy = phy->mt76;
@@ -3279,6 +3239,7 @@ int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy)
 	return ret;
 }
 
+#ifdef CONFIG_PM
 int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend)
 {
 	struct {
@@ -3312,6 +3273,48 @@ int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend)
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_set_hif_suspend);
 
+static int
+mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+		      bool enable)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct {
+		u8 bss_idx;
+		u8 dtim_period;
+		__le16 aid;
+		__le16 bcn_interval;
+		__le16 atim_window;
+		u8 uapsd;
+		u8 bmc_delivered_ac;
+		u8 bmc_triggered_ac;
+		u8 pad;
+	} req = {
+		.bss_idx = mvif->idx,
+		.aid = cpu_to_le16(vif->bss_conf.aid),
+		.dtim_period = vif->bss_conf.dtim_period,
+		.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
+	};
+	struct {
+		u8 bss_idx;
+		u8 pad[3];
+	} req_hdr = {
+		.bss_idx = mvif->idx,
+	};
+	int err;
+
+	if (vif->type != NL80211_IFTYPE_STATION ||
+	    !mt7615_firmware_offload(dev))
+		return -ENOTSUPP;
+
+	err = __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_ABORT,
+				  &req_hdr, sizeof(req_hdr), false);
+	if (err < 0 || !enable)
+		return err;
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_CONNECTED,
+				   &req, sizeof(req), false);
+}
+
 static int
 mt7615_mcu_set_wow_ctrl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			bool suspend, struct cfg80211_wowlan *wowlan)
@@ -3529,3 +3532,5 @@ int mt7615_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
 	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				       MCU_UNI_CMD_OFFLOAD, true);
 }
+#endif /* CONFIG_PM */
+
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index d3a83f3ed54e..af897fe5c508 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -534,12 +534,14 @@ int mt7615_driver_own(struct mt7615_dev *dev);
 int mt7615_init_debugfs(struct mt7615_dev *dev);
 int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
 
+#ifdef CONFIG_PM
 int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend);
 void mt7615_mcu_set_suspend_iter(void *priv, u8 *mac,
 				 struct ieee80211_vif *vif);
 int mt7615_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct cfg80211_gtk_rekey_data *key);
+#endif /* CONFIG_PM */
 
 int __mt7663_load_firmware(struct mt7615_dev *dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index b84eb208c23e..88ff14564521 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -66,8 +66,8 @@ static void mt7615_pci_remove(struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 }
 
-static int __maybe_unused mt7615_pci_suspend(struct pci_dev *pdev,
-					     pm_message_t state)
+#ifdef CONFIG_PM
+static int mt7615_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct mt76_dev *mdev = pci_get_drvdata(pdev);
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
@@ -128,7 +128,7 @@ static int __maybe_unused mt7615_pci_suspend(struct pci_dev *pdev,
 	return err;
 }
 
-static int __maybe_unused mt7615_pci_resume(struct pci_dev *pdev)
+static int mt7615_pci_resume(struct pci_dev *pdev)
 {
 	struct mt76_dev *mdev = pci_get_drvdata(pdev);
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
@@ -168,6 +168,7 @@ static int __maybe_unused mt7615_pci_resume(struct pci_dev *pdev)
 
 	return err;
 }
+#endif /* CONFIG_PM */
 
 struct pci_driver mt7615_pci_driver = {
 	.name		= KBUILD_MODNAME,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index 5ed83500541c..f2825b8f4539 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -372,8 +372,8 @@ static void mt7663u_disconnect(struct usb_interface *usb_intf)
 	ieee80211_free_hw(dev->mt76.hw);
 }
 
-static int __maybe_unused mt7663u_suspend(struct usb_interface *intf,
-					  pm_message_t state)
+#ifdef CONFIG_PM
+static int mt7663u_suspend(struct usb_interface *intf, pm_message_t state)
 {
 	struct mt7615_dev *dev = usb_get_intfdata(intf);
 
@@ -394,7 +394,7 @@ static int __maybe_unused mt7663u_suspend(struct usb_interface *intf,
 	return 0;
 }
 
-static int __maybe_unused mt7663u_resume(struct usb_interface *intf)
+static int mt7663u_resume(struct usb_interface *intf)
 {
 	struct mt7615_dev *dev = usb_get_intfdata(intf);
 	int err;
@@ -415,6 +415,7 @@ static int __maybe_unused mt7663u_resume(struct usb_interface *intf)
 
 	return err;
 }
+#endif /* CONFIG_PM */
 
 MODULE_DEVICE_TABLE(usb, mt7615_device_table);
 MODULE_FIRMWARE(MT7663_OFFLOAD_FIRMWARE_N9);
-- 
2.26.2

