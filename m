Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A15C740A03
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjF1H4P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:56:15 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41524 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231221AbjF1HyR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:17 -0400
X-UUID: a7542dc2158211ee9cb5633481061a41-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UW/YedLA4avXZysnZCkqNdh6eiQAQS++L/nX2mNUtds=;
        b=ZmROks0kMa4AKB7cuAJdpGeLKybyy2o7co93CBlXv8b0AM1H6PZPnY0yAs8z19RBrP2024lfpDnPynPV5TM8lthXBdRYECaheF3SfYxFBiKcVNagLVsPSwFh4qwVnCrKDQGerwBeE1Zb7YVosZepJQSu93M/JsSHMdBYq1Z/ukI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:930dc741-d31c-44b2-8590-652e370eb6b5,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:01c9525,CLOUDID:d9889b0d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a7542dc2158211ee9cb5633481061a41-20230628
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 38812671; Wed, 28 Jun 2023 15:08:59 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:08:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:08:57 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 04/11] wifi: mt76: mt7921: move runtime-pm pci code in mt792x-lib
Date:   Wed, 28 Jun 2023 15:07:17 +0800
Message-ID: <28c5e82ed83ecb239f58cf8e7e9c2286dfd7077b.1687920269.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687920269.git.deren.wu@mediatek.com>
References: <cover.1687920269.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Move the following runtime-pm pci routines in mt792x-lib since they are
shared between mt7921 and mt7925 chipsets:
- __mt7921e_mcu_drv_pmctrl
- mt7921e_mcu_drv_pmctrl
- mt7921e_mcu_fw_pmctrl

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  4 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  7 --
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  8 +--
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  2 +-
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c   | 65 ------------------
 .../wireless/mediatek/mt76/mt7921/usb_mac.c   |  4 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  8 +++
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 68 +++++++++++++++++++
 8 files changed, 85 insertions(+), 81 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index c47fb07fcb2e..3ff0205919c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -128,7 +128,7 @@ static int mt7921_init_hardware(struct mt792x_dev *dev)
 
 	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
-	for (i = 0; i < MT7921_MCU_INIT_RETRY_COUNT; i++) {
+	for (i = 0; i < MT792x_MCU_INIT_RETRY_COUNT; i++) {
 		ret = __mt7921_init_hardware(dev);
 		if (!ret)
 			break;
@@ -136,7 +136,7 @@ static int mt7921_init_hardware(struct mt792x_dev *dev)
 		mt792x_init_reset(dev);
 	}
 
-	if (i == MT7921_MCU_INIT_RETRY_COUNT) {
+	if (i == MT792x_MCU_INIT_RETRY_COUNT) {
 		dev_err(dev->mt76.dev, "hardware init failed\n");
 		return ret;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 4a3416a28711..0c60a1559041 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -18,10 +18,6 @@
 #define MT7921_RX_RING_SIZE		1536
 #define MT7921_RX_MCU_RING_SIZE		512
 
-#define MT7921_DRV_OWN_RETRY_COUNT	10
-#define MT7921_MCU_INIT_RETRY_COUNT	10
-#define MT7921_WFSYS_INIT_RETRY_COUNT	2
-
 #define MT7921_FIRMWARE_WM		"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
 #define MT7921_ROM_PATCH		"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
 
@@ -312,9 +308,6 @@ int mt7921e_mcu_init(struct mt792x_dev *dev);
 int mt7921s_wfsys_reset(struct mt792x_dev *dev);
 int mt7921s_mac_reset(struct mt792x_dev *dev);
 int mt7921s_init_reset(struct mt792x_dev *dev);
-int __mt7921e_mcu_drv_pmctrl(struct mt792x_dev *dev);
-int mt7921e_mcu_drv_pmctrl(struct mt792x_dev *dev);
-int mt7921e_mcu_fw_pmctrl(struct mt792x_dev *dev);
 
 int mt7921s_mcu_init(struct mt792x_dev *dev);
 int mt7921s_mcu_drv_pmctrl(struct mt792x_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 7419076b77cb..c3f22ce9f5c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -181,8 +181,8 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		.init_reset = mt7921e_init_reset,
 		.reset = mt7921e_mac_reset,
 		.mcu_init = mt7921e_mcu_init,
-		.drv_own = mt7921e_mcu_drv_pmctrl,
-		.fw_own = mt7921e_mcu_fw_pmctrl,
+		.drv_own = mt792xe_mcu_drv_pmctrl,
+		.fw_own = mt792xe_mcu_fw_pmctrl,
 	};
 	static const struct mt792x_irq_map irq_map = {
 		.host_irq_enable = MT_WFDMA0_HOST_INT_ENA,
@@ -268,11 +268,11 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	bus_ops->rmw = mt7921_rmw;
 	dev->mt76.bus = bus_ops;
 
-	ret = mt7921e_mcu_fw_pmctrl(dev);
+	ret = mt792xe_mcu_fw_pmctrl(dev);
 	if (ret)
 		goto err_free_dev;
 
-	ret = __mt7921e_mcu_drv_pmctrl(dev);
+	ret = __mt792xe_mcu_drv_pmctrl(dev);
 	if (ret)
 		goto err_free_dev;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index bd3f004d1a18..e7a995e7e70a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -57,7 +57,7 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
 {
 	int i, err;
 
-	mt7921e_mcu_drv_pmctrl(dev);
+	mt792xe_mcu_drv_pmctrl(dev);
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
index 57bd02746f5f..4cf1f2f0f968 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
@@ -61,68 +61,3 @@ int mt7921e_mcu_init(struct mt792x_dev *dev)
 
 	return err;
 }
-
-int __mt7921e_mcu_drv_pmctrl(struct mt792x_dev *dev)
-{
-	int i, err = 0;
-
-	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
-		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_CLR_OWN);
-		if (mt76_poll_msec_tick(dev, MT_CONN_ON_LPCTL,
-					PCIE_LPCR_HOST_OWN_SYNC, 0, 50, 1))
-			break;
-	}
-
-	if (i == MT7921_DRV_OWN_RETRY_COUNT) {
-		dev_err(dev->mt76.dev, "driver own failed\n");
-		err = -EIO;
-	}
-
-	return err;
-}
-
-int mt7921e_mcu_drv_pmctrl(struct mt792x_dev *dev)
-{
-	struct mt76_phy *mphy = &dev->mt76.phy;
-	struct mt76_connac_pm *pm = &dev->pm;
-	int err;
-
-	err = __mt7921e_mcu_drv_pmctrl(dev);
-	if (err < 0)
-		goto out;
-
-	mt792x_wpdma_reinit_cond(dev);
-	clear_bit(MT76_STATE_PM, &mphy->state);
-
-	pm->stats.last_wake_event = jiffies;
-	pm->stats.doze_time += pm->stats.last_wake_event -
-			       pm->stats.last_doze_event;
-out:
-	return err;
-}
-
-int mt7921e_mcu_fw_pmctrl(struct mt792x_dev *dev)
-{
-	struct mt76_phy *mphy = &dev->mt76.phy;
-	struct mt76_connac_pm *pm = &dev->pm;
-	int i;
-
-	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
-		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_SET_OWN);
-		if (mt76_poll_msec_tick(dev, MT_CONN_ON_LPCTL,
-					PCIE_LPCR_HOST_OWN_SYNC, 4, 50, 1))
-			break;
-	}
-
-	if (i == MT7921_DRV_OWN_RETRY_COUNT) {
-		dev_err(dev->mt76.dev, "firmware own failed\n");
-		clear_bit(MT76_STATE_PM, &mphy->state);
-		return -EIO;
-	}
-
-	pm->stats.last_doze_event = jiffies;
-	pm->stats.awake_time += pm->stats.last_doze_event -
-				pm->stats.last_wake_event;
-
-	return 0;
-}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
index f612873c704b..f7cb6c542af5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
@@ -166,7 +166,7 @@ int mt7921u_wfsys_reset(struct mt792x_dev *dev)
 	mt7921u_uhw_wr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST, val);
 
 	mt7921u_uhw_wr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS_SEL, 0);
-	for (i = 0; i < MT7921_WFSYS_INIT_RETRY_COUNT; i++) {
+	for (i = 0; i < MT792x_WFSYS_INIT_RETRY_COUNT; i++) {
 		val = mt7921u_uhw_rr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS);
 		if (val & MT_UDMA_CONN_WFSYS_INIT_DONE)
 			break;
@@ -174,7 +174,7 @@ int mt7921u_wfsys_reset(struct mt792x_dev *dev)
 		msleep(100);
 	}
 
-	if (i == MT7921_WFSYS_INIT_RETRY_COUNT)
+	if (i == MT792x_WFSYS_INIT_RETRY_COUNT)
 		return -ETIMEDOUT;
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 470017f6f982..54ff9627530f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -26,6 +26,10 @@
 
 #define MT792x_WATCHDOG_TIME	(HZ / 4)
 
+#define MT792x_DRV_OWN_RETRY_COUNT	10
+#define MT792x_MCU_INIT_RETRY_COUNT	10
+#define MT792x_WFSYS_INIT_RETRY_COUNT	2
+
 struct mt792x_vif;
 struct mt792x_sta;
 
@@ -289,4 +293,8 @@ int mt792x_init_wcid(struct mt792x_dev *dev);
 int mt792x_mcu_drv_pmctrl(struct mt792x_dev *dev);
 int mt792x_mcu_fw_pmctrl(struct mt792x_dev *dev);
 
+int __mt792xe_mcu_drv_pmctrl(struct mt792x_dev *dev);
+int mt792xe_mcu_drv_pmctrl(struct mt792x_dev *dev);
+int mt792xe_mcu_fw_pmctrl(struct mt792x_dev *dev);
+
 #endif /* __MT7925_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 234aac4e3742..f7dfc2189cc8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -736,5 +736,73 @@ int mt792x_mcu_fw_pmctrl(struct mt792x_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt792x_mcu_fw_pmctrl);
 
+int __mt792xe_mcu_drv_pmctrl(struct mt792x_dev *dev)
+{
+	int i, err = 0;
+
+	for (i = 0; i < MT792x_DRV_OWN_RETRY_COUNT; i++) {
+		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_CLR_OWN);
+		if (mt76_poll_msec_tick(dev, MT_CONN_ON_LPCTL,
+					PCIE_LPCR_HOST_OWN_SYNC, 0, 50, 1))
+			break;
+	}
+
+	if (i == MT792x_DRV_OWN_RETRY_COUNT) {
+		dev_err(dev->mt76.dev, "driver own failed\n");
+		err = -EIO;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(__mt792xe_mcu_drv_pmctrl);
+
+int mt792xe_mcu_drv_pmctrl(struct mt792x_dev *dev)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
+	int err;
+
+	err = __mt792xe_mcu_drv_pmctrl(dev);
+	if (err < 0)
+		goto out;
+
+	mt792x_wpdma_reinit_cond(dev);
+	clear_bit(MT76_STATE_PM, &mphy->state);
+
+	pm->stats.last_wake_event = jiffies;
+	pm->stats.doze_time += pm->stats.last_wake_event -
+			       pm->stats.last_doze_event;
+out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt792xe_mcu_drv_pmctrl);
+
+int mt792xe_mcu_fw_pmctrl(struct mt792x_dev *dev)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
+	int i;
+
+	for (i = 0; i < MT792x_DRV_OWN_RETRY_COUNT; i++) {
+		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_SET_OWN);
+		if (mt76_poll_msec_tick(dev, MT_CONN_ON_LPCTL,
+					PCIE_LPCR_HOST_OWN_SYNC, 4, 50, 1))
+			break;
+	}
+
+	if (i == MT792x_DRV_OWN_RETRY_COUNT) {
+		dev_err(dev->mt76.dev, "firmware own failed\n");
+		clear_bit(MT76_STATE_PM, &mphy->state);
+		return -EIO;
+	}
+
+	pm->stats.last_doze_event = jiffies;
+	pm->stats.awake_time += pm->stats.last_doze_event -
+				pm->stats.last_wake_event;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792xe_mcu_fw_pmctrl);
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
-- 
2.18.0

