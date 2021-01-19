Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAC72FB9A9
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 15:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392058AbhASOgr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 09:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389640AbhASKHA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 05:07:00 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC17FC061757
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jan 2021 02:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xfPDR7XuRbEbkBHNeP5lvmVGIKY+phhpk9wYrQJVv1k=; b=dp3yHNf0p0UG8izOorxfkifIil
        j5Bba2WLXI7gGVvEx9rtW4G/w9S0uHVe2ZY6IlOYQGYMubuAbYeQtnqnRvgDcDMGpVW1LOo3dNoFu
        g7p41+pcpug7lMOcKBWvHxSwcU/PfVwBn2KPgrXiK1MkcgODHfbxFpXC57sAoF7jTB5g=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l1nti-0004Zi-8k
        for linux-wireless@vger.kernel.org; Tue, 19 Jan 2021 11:06:02 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt7615: unify init work
Date:   Tue, 19 Jan 2021 11:05:59 +0100
Message-Id: <20210119100600.27949-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reduce code duplication and remove unnecessary exports

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 22 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 --
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  4 +---
 .../wireless/mediatek/mt76/mt7615/pci_init.c  | 11 +++-------
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |  6 +----
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  6 +----
 6 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 7e81ec53bd84..f345cb43cb01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -12,13 +12,13 @@
 #include "mac.h"
 #include "eeprom.h"
 
-void mt7615_phy_init(struct mt7615_dev *dev)
+static void
+mt7615_phy_init(struct mt7615_dev *dev)
 {
 	/* disable rf low power beacon mode */
 	mt76_set(dev, MT_WF_PHY_WF2_RFCTRL0(0), MT_WF_PHY_WF2_RFCTRL0_LPBCN_EN);
 	mt76_set(dev, MT_WF_PHY_WF2_RFCTRL0(1), MT_WF_PHY_WF2_RFCTRL0_LPBCN_EN);
 }
-EXPORT_SYMBOL_GPL(mt7615_phy_init);
 
 static void
 mt7615_init_mac_chain(struct mt7615_dev *dev, int chain)
@@ -79,7 +79,8 @@ mt7615_init_mac_chain(struct mt7615_dev *dev, int chain)
 	}
 }
 
-void mt7615_mac_init(struct mt7615_dev *dev)
+static void
+mt7615_mac_init(struct mt7615_dev *dev)
 {
 	int i;
 
@@ -128,9 +129,9 @@ void mt7615_mac_init(struct mt7615_dev *dev)
 		mt7615_init_mac_chain(dev, 1);
 	}
 }
-EXPORT_SYMBOL_GPL(mt7615_mac_init);
 
-void mt7615_check_offload_capability(struct mt7615_dev *dev)
+static void
+mt7615_check_offload_capability(struct mt7615_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct wiphy *wiphy = hw->wiphy;
@@ -162,7 +163,6 @@ void mt7615_check_offload_capability(struct mt7615_dev *dev)
 		wiphy->max_sched_scan_reqs = 0;
 	}
 }
-EXPORT_SYMBOL_GPL(mt7615_check_offload_capability);
 
 bool mt7615_wait_for_mcu_init(struct mt7615_dev *dev)
 {
@@ -286,6 +286,16 @@ void mt7615_init_txpower(struct mt7615_dev *dev,
 }
 EXPORT_SYMBOL_GPL(mt7615_init_txpower);
 
+void mt7615_init_work(struct mt7615_dev *dev)
+{
+	mt7615_mcu_set_eeprom(dev);
+	mt7615_mac_init(dev);
+	mt7615_phy_init(dev);
+	mt7615_mcu_del_wtbl_all(dev);
+	mt7615_check_offload_capability(dev);
+}
+EXPORT_SYMBOL_GPL(mt7615_init_work);
+
 static void
 mt7615_regd_notifier(struct wiphy *wiphy,
 		     struct regulatory_request *request)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index a035bfa9f0e0..9aa4ec103262 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2522,7 +2522,6 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_EXT_CMD_EFUSE_BUFFER_MODE, true);
 }
-EXPORT_SYMBOL_GPL(mt7615_mcu_set_eeprom);
 
 int mt7615_mcu_set_mac_enable(struct mt7615_dev *dev, int band, bool enable)
 {
@@ -2664,7 +2663,6 @@ int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev)
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE, &req,
 				 sizeof(req), true);
 }
-EXPORT_SYMBOL_GPL(mt7615_mcu_del_wtbl_all);
 
 int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
 		       enum mt7615_rdd_cmd cmd, u8 index,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index a773ea4d5b12..99adbc933d0c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -402,7 +402,6 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 		      int irq, const u32 *map);
 u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr);
 
-void mt7615_check_offload_capability(struct mt7615_dev *dev);
 void mt7615_init_device(struct mt7615_dev *dev);
 int mt7615_register_device(struct mt7615_dev *dev);
 void mt7615_unregister_device(struct mt7615_dev *dev);
@@ -520,9 +519,8 @@ void mt7615_roc_work(struct work_struct *work);
 void mt7615_roc_timer(struct timer_list *timer);
 void mt7615_init_txpower(struct mt7615_dev *dev,
 			 struct ieee80211_supported_band *sband);
-void mt7615_phy_init(struct mt7615_dev *dev);
-void mt7615_mac_init(struct mt7615_dev *dev);
 int mt7615_set_channel(struct mt7615_phy *phy);
+void mt7615_init_work(struct mt7615_dev *dev);
 
 int mt7615_mcu_restart(struct mt76_dev *dev);
 void mt7615_update_channel(struct mt76_dev *mdev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index 58a0ec1bf8d7..72395925ddee 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -12,7 +12,7 @@
 #include "mac.h"
 #include "eeprom.h"
 
-static void mt7615_init_work(struct work_struct *work)
+static void mt7615_pci_init_work(struct work_struct *work)
 {
 	struct mt7615_dev *dev = container_of(work, struct mt7615_dev,
 					      mcu_work);
@@ -27,12 +27,7 @@ static void mt7615_init_work(struct work_struct *work)
 	if (ret)
 		return;
 
-	mt7615_mcu_set_eeprom(dev);
-	mt7615_mac_init(dev);
-	mt7615_phy_init(dev);
-	mt7615_mcu_del_wtbl_all(dev);
-	mt7615_check_offload_capability(dev);
-
+	mt7615_init_work(dev);
 	if (dev->dbdc_support)
 		mt7615_register_ext_phy(dev);
 }
@@ -44,7 +39,7 @@ static int mt7615_init_hardware(struct mt7615_dev *dev)
 
 	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
 
-	INIT_WORK(&dev->mcu_work, mt7615_init_work);
+	INIT_WORK(&dev->mcu_work, mt7615_pci_init_work);
 	spin_lock_init(&dev->token_lock);
 	idr_init(&dev->token);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 347975eaba86..26b29115c16f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -227,11 +227,7 @@ static void mt7663s_init_work(struct work_struct *work)
 	if (mt7663s_mcu_init(dev))
 		return;
 
-	mt7615_mcu_set_eeprom(dev);
-	mt7615_mac_init(dev);
-	mt7615_phy_init(dev);
-	mt7615_mcu_del_wtbl_all(dev);
-	mt7615_check_offload_capability(dev);
+	mt7615_init_work(dev);
 }
 
 static int mt7663s_hw_init(struct mt7615_dev *dev, struct sdio_func *func)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index dbf59f1ccda2..5438b0ba461f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -47,11 +47,7 @@ static void mt7663u_init_work(struct work_struct *work)
 	if (mt7663u_mcu_init(dev))
 		return;
 
-	mt7615_mcu_set_eeprom(dev);
-	mt7615_mac_init(dev);
-	mt7615_phy_init(dev);
-	mt7615_mcu_del_wtbl_all(dev);
-	mt7615_check_offload_capability(dev);
+	mt7615_init_work(dev);
 }
 
 static int mt7663u_probe(struct usb_interface *usb_intf,
-- 
2.28.0

