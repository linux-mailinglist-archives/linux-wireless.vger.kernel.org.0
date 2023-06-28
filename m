Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4893B740A02
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjF1H4N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:56:13 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41410 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231143AbjF1HyN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:13 -0400
X-UUID: a79c305e158211ee9cb5633481061a41-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7cmjMQYE4Wi2vG/cNP5QXV2aRACsbiKXLTMDyZbsip8=;
        b=bRu8OIq1+4DbCMN/omu0cPtxmCnCbEyhKZR4phTkrsq9cE06vLEjY5D8Od+7jGLQBHFGf9lMBoNkQRspK2+h87vz6pPowhChjTnEPzN8mYUeRsuzxJC45hfjO8CUBd9xfvj2UyJc4fcoXHl0ctx1rLMvfQEhSVZzhnlErDCY7lA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:b3bf7d85-e8bf-4119-a394-3ede21ed6b0a,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.27,REQID:b3bf7d85-e8bf-4119-a394-3ede21ed6b0a,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:01c9525,CLOUDID:db889b0d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:230628150901ZVLWP1JA,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD,TF_CID_SPAM_ULN
X-UUID: a79c305e158211ee9cb5633481061a41-20230628
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 691542264; Wed, 28 Jun 2023 15:08:59 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:08:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:08:58 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 06/11] wifi: mt76: mt792x: introduce mt792x-usb module
Date:   Wed, 28 Jun 2023 15:07:19 +0800
Message-ID: <c7ff1c22514fe76e664992b297aaf0a8c297002f.1687920269.git.deren.wu@mediatek.com>
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

Add usb shared code between mt7921 and mt7925 chipset to mt792x-usb module.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/Kconfig    |   4 +
 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +
 .../net/wireless/mediatek/mt76/mt7921/Kconfig |   2 +-
 .../wireless/mediatek/mt76/mt7921/Makefile    |   2 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   8 -
 .../net/wireless/mediatek/mt76/mt7921/usb.c   | 162 ++++++--------
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  13 ++
 .../mt76/{mt7921/usb_mac.c => mt792x_usb.c}   | 203 +++++++++++-------
 8 files changed, 208 insertions(+), 188 deletions(-)
 rename drivers/net/wireless/mediatek/mt76/{mt7921/usb_mac.c => mt792x_usb.c} (51%)

diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
index 1ddf195597a8..7eb1b0b63d11 100644
--- a/drivers/net/wireless/mediatek/mt76/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/Kconfig
@@ -33,6 +33,10 @@ config MT792x_LIB
 	tristate
 	select MT76_CONNAC_LIB
 
+config MT792x_USB
+	tristate
+	select MT76_USB
+
 source "drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt7603/Kconfig"
diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index f8a1928d62b2..85c4799be954 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_MT76x02_LIB) += mt76x02-lib.o
 obj-$(CONFIG_MT76x02_USB) += mt76x02-usb.o
 obj-$(CONFIG_MT76_CONNAC_LIB) += mt76-connac-lib.o
 obj-$(CONFIG_MT792x_LIB) += mt792x-lib.o
+obj-$(CONFIG_MT792x_USB) += mt792x-usb.o
 
 mt76-y := \
 	mmio.o util.o trace.o dma.o mac80211.o debugfs.o eeprom.o \
@@ -34,6 +35,7 @@ mt76-connac-lib-y := mt76_connac_mcu.o mt76_connac_mac.o mt76_connac3_mac.o
 mt792x-lib-y := mt792x_core.o mt792x_mac.o mt792x_trace.o \
 		mt792x_debugfs.o mt792x_dma.o
 mt792x-lib-$(CONFIG_ACPI) += mt792x_acpi_sar.o
+mt792x-usb-y := mt792x_usb.o
 
 obj-$(CONFIG_MT76x0_COMMON) += mt76x0/
 obj-$(CONFIG_MT76x2_COMMON) += mt76x2/
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
index b92630cdf88b..7ed51e057857 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
@@ -27,7 +27,7 @@ config MT7921S
 
 config MT7921U
 	tristate "MediaTek MT7921U (USB) support"
-	select MT76_USB
+	select MT792x_USB
 	select MT7921_COMMON
 	depends on MAC80211
 	depends on USB
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index f380ec4b6de1..964eb55824cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -9,4 +9,4 @@ mt7921-common-y := mac.o mcu.o main.o init.o debugfs.o
 mt7921-common-$(CONFIG_NL80211_TESTMODE) += testmode.o
 mt7921e-y := pci.o pci_mac.o pci_mcu.o dma.o
 mt7921s-y := sdio.o sdio_mac.o sdio_mcu.o
-mt7921u-y := usb.o usb_mac.o
+mt7921u-y := usb.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 3ba873ec6bc4..cb22be083242 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -332,14 +332,6 @@ void mt7921_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 bool mt7921_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update);
 
 /* usb */
-#define MT_USB_TYPE_VENDOR	(USB_TYPE_VENDOR | 0x1f)
-#define MT_USB_TYPE_UHW_VENDOR	(USB_TYPE_VENDOR | 0x1e)
-
-int mt7921u_mcu_power_on(struct mt792x_dev *dev);
-int mt7921u_wfsys_reset(struct mt792x_dev *dev);
-int mt7921u_dma_init(struct mt792x_dev *dev, bool resume);
-int mt7921u_init_reset(struct mt792x_dev *dev);
-int mt7921u_mac_reset(struct mt792x_dev *dev);
 int mt7921_mcu_uni_add_beacon_offload(struct mt792x_dev *dev,
 				      struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 0a31e7076324..c3981bc893ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -24,83 +24,6 @@ static const struct usb_device_id mt7921u_device_table[] = {
 	{ },
 };
 
-static u32 mt7921u_rr(struct mt76_dev *dev, u32 addr)
-{
-	u32 ret;
-
-	mutex_lock(&dev->usb.usb_ctrl_mtx);
-	ret = ___mt76u_rr(dev, MT_VEND_READ_EXT,
-			  USB_DIR_IN | MT_USB_TYPE_VENDOR, addr);
-	mutex_unlock(&dev->usb.usb_ctrl_mtx);
-
-	return ret;
-}
-
-static void mt7921u_wr(struct mt76_dev *dev, u32 addr, u32 val)
-{
-	mutex_lock(&dev->usb.usb_ctrl_mtx);
-	___mt76u_wr(dev, MT_VEND_WRITE_EXT,
-		    USB_DIR_OUT | MT_USB_TYPE_VENDOR, addr, val);
-	mutex_unlock(&dev->usb.usb_ctrl_mtx);
-}
-
-static u32 mt7921u_rmw(struct mt76_dev *dev, u32 addr,
-		       u32 mask, u32 val)
-{
-	mutex_lock(&dev->usb.usb_ctrl_mtx);
-	val |= ___mt76u_rr(dev, MT_VEND_READ_EXT,
-			   USB_DIR_IN | MT_USB_TYPE_VENDOR, addr) & ~mask;
-	___mt76u_wr(dev, MT_VEND_WRITE_EXT,
-		    USB_DIR_OUT | MT_USB_TYPE_VENDOR, addr, val);
-	mutex_unlock(&dev->usb.usb_ctrl_mtx);
-
-	return val;
-}
-
-static void mt7921u_copy(struct mt76_dev *dev, u32 offset,
-			 const void *data, int len)
-{
-	struct mt76_usb *usb = &dev->usb;
-	int ret, i = 0, batch_len;
-	const u8 *val = data;
-
-	len = round_up(len, 4);
-
-	mutex_lock(&usb->usb_ctrl_mtx);
-	while (i < len) {
-		batch_len = min_t(int, usb->data_len, len - i);
-		memcpy(usb->data, val + i, batch_len);
-		ret = __mt76u_vendor_request(dev, MT_VEND_WRITE_EXT,
-					     USB_DIR_OUT | MT_USB_TYPE_VENDOR,
-					     (offset + i) >> 16, offset + i,
-					     usb->data, batch_len);
-		if (ret < 0)
-			break;
-
-		i += batch_len;
-	}
-	mutex_unlock(&usb->usb_ctrl_mtx);
-}
-
-int mt7921u_mcu_power_on(struct mt792x_dev *dev)
-{
-	int ret;
-
-	ret = mt76u_vendor_request(&dev->mt76, MT_VEND_POWER_ON,
-				   USB_DIR_OUT | MT_USB_TYPE_VENDOR,
-				   0x0, 0x1, NULL, 0);
-	if (ret)
-		return ret;
-
-	if (!mt76_poll_msec(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_PWR_ON,
-			    MT_TOP_MISC2_FW_PWR_ON, 500)) {
-		dev_err(dev->mt76.dev, "Timeout for power on\n");
-		ret = -EIO;
-	}
-
-	return ret;
-}
-
 static int
 mt7921u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			 int cmd, int *seq)
@@ -155,20 +78,69 @@ static int mt7921u_mcu_init(struct mt792x_dev *dev)
 	return 0;
 }
 
-static void mt7921u_stop(struct ieee80211_hw *hw)
+static int mt7921u_mac_reset(struct mt792x_dev *dev)
 {
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err;
+
+	mt76_txq_schedule_all(&dev->mphy);
+	mt76_worker_disable(&dev->mt76.tx_worker);
+
+	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 
+	wake_up(&dev->mt76.mcu.wait);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+
+	mt76u_stop_rx(&dev->mt76);
 	mt76u_stop_tx(&dev->mt76);
-	mt7921_stop(hw);
+
+	mt792xu_wfsys_reset(dev);
+
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	err = mt76u_resume_rx(&dev->mt76);
+	if (err)
+		goto out;
+
+	err = mt792xu_mcu_power_on(dev);
+	if (err)
+		goto out;
+
+	err = mt792xu_dma_init(dev, false);
+	if (err)
+		goto out;
+
+	mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
+	mt76_set(dev, MT_UDMA_TX_QSEL, MT_FW_DL_EN);
+
+	err = mt7921_run_firmware(dev);
+	if (err)
+		goto out;
+
+	mt76_clear(dev, MT_UDMA_TX_QSEL, MT_FW_DL_EN);
+
+	err = mt7921_mcu_set_eeprom(dev);
+	if (err)
+		goto out;
+
+	err = mt7921_mac_init(dev);
+	if (err)
+		goto out;
+
+	err = __mt7921_start(&dev->phy);
+out:
+	clear_bit(MT76_RESET, &dev->mphy.state);
+
+	mt76_worker_enable(&dev->mt76.tx_worker);
+
+	return err;
 }
 
-static void mt7921u_cleanup(struct mt792x_dev *dev)
+static void mt7921u_stop(struct ieee80211_hw *hw)
 {
-	clear_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
-	mt7921u_wfsys_reset(dev);
-	skb_queue_purge(&dev->mt76.mcu.res_q);
-	mt76u_queues_deinit(&dev->mt76);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	mt76u_stop_tx(&dev->mt76);
+	mt7921_stop(hw);
 }
 
 static int mt7921u_probe(struct usb_interface *usb_intf,
@@ -193,15 +165,15 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 	};
 	static const struct mt792x_hif_ops hif_ops = {
 		.mcu_init = mt7921u_mcu_init,
-		.init_reset = mt7921u_init_reset,
+		.init_reset = mt792xu_init_reset,
 		.reset = mt7921u_mac_reset,
 	};
 	static struct mt76_bus_ops bus_ops = {
-		.rr = mt7921u_rr,
-		.wr = mt7921u_wr,
-		.rmw = mt7921u_rmw,
+		.rr = mt792xu_rr,
+		.wr = mt792xu_wr,
+		.rmw = mt792xu_rmw,
 		.read_copy = mt76u_read_copy,
-		.write_copy = mt7921u_copy,
+		.write_copy = mt792xu_copy,
 		.type = MT76_BUS_USB,
 	};
 	struct usb_device *udev = interface_to_usbdev(usb_intf);
@@ -240,12 +212,12 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
 	if (mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY)) {
-		ret = mt7921u_wfsys_reset(dev);
+		ret = mt792xu_wfsys_reset(dev);
 		if (ret)
 			goto error;
 	}
 
-	ret = mt7921u_mcu_power_on(dev);
+	ret = mt792xu_mcu_power_on(dev);
 	if (ret)
 		goto error;
 
@@ -257,7 +229,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 	if (ret)
 		goto error;
 
-	ret = mt7921u_dma_init(dev, false);
+	ret = mt792xu_dma_init(dev, false);
 	if (ret)
 		goto error;
 
@@ -291,7 +263,7 @@ static void mt7921u_disconnect(struct usb_interface *usb_intf)
 		return;
 
 	mt76_unregister_device(&dev->mt76);
-	mt7921u_cleanup(dev);
+	mt792xu_cleanup(dev);
 
 	usb_set_intfdata(usb_intf, NULL);
 	usb_put_dev(interface_to_usbdev(usb_intf));
@@ -350,7 +322,7 @@ static int mt7921u_resume(struct usb_interface *intf)
 	}
 
 	if (reinit || mt792x_dma_need_reinit(dev)) {
-		err = mt7921u_dma_init(dev, true);
+		err = mt792xu_dma_init(dev, true);
 		if (err)
 			goto failed;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 1ed688186fe7..b226a863e5de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -294,6 +294,19 @@ int mt792x_init_wcid(struct mt792x_dev *dev);
 int mt792x_mcu_drv_pmctrl(struct mt792x_dev *dev);
 int mt792x_mcu_fw_pmctrl(struct mt792x_dev *dev);
 
+/* usb */
+#define MT_USB_TYPE_VENDOR	(USB_TYPE_VENDOR | 0x1f)
+#define MT_USB_TYPE_UHW_VENDOR	(USB_TYPE_VENDOR | 0x1e)
+int mt792xu_dma_init(struct mt792x_dev *dev, bool resume);
+int mt792xu_mcu_power_on(struct mt792x_dev *dev);
+int mt792xu_wfsys_reset(struct mt792x_dev *dev);
+int mt792xu_init_reset(struct mt792x_dev *dev);
+u32 mt792xu_rr(struct mt76_dev *dev, u32 addr);
+void mt792xu_wr(struct mt76_dev *dev, u32 addr, u32 val);
+u32 mt792xu_rmw(struct mt76_dev *dev, u32 addr, u32 mask, u32 val);
+void mt792xu_copy(struct mt76_dev *dev, u32 offset, const void *data, int len);
+void mt792xu_cleanup(struct mt792x_dev *dev);
+
 int __mt792xe_mcu_drv_pmctrl(struct mt792x_dev *dev);
 int mt792xe_mcu_drv_pmctrl(struct mt792x_dev *dev);
 int mt792xe_mcu_fw_pmctrl(struct mt792x_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
similarity index 51%
rename from drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
rename to drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index f7cb6c542af5..97480c9c9974 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: ISC
-/* Copyright (C) 2022 MediaTek Inc.
+/* Copyright (C) 2023 MediaTek Inc.
  *
  * Author: Lorenzo Bianconi <lorenzo@kernel.org>
  */
@@ -8,11 +8,99 @@
 #include <linux/module.h>
 #include <linux/usb.h>
 
-#include "mt7921.h"
-#include "mcu.h"
-#include "../mt76_connac2_mac.h"
+#include "mt792x.h"
+#include "mt76_connac2_mac.h"
 
-static u32 mt7921u_uhw_rr(struct mt76_dev *dev, u32 addr)
+u32 mt792xu_rr(struct mt76_dev *dev, u32 addr)
+{
+	u32 ret;
+
+	mutex_lock(&dev->usb.usb_ctrl_mtx);
+	ret = ___mt76u_rr(dev, MT_VEND_READ_EXT,
+			  USB_DIR_IN | MT_USB_TYPE_VENDOR, addr);
+	mutex_unlock(&dev->usb.usb_ctrl_mtx);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt792xu_rr);
+
+void mt792xu_wr(struct mt76_dev *dev, u32 addr, u32 val)
+{
+	mutex_lock(&dev->usb.usb_ctrl_mtx);
+	___mt76u_wr(dev, MT_VEND_WRITE_EXT,
+		    USB_DIR_OUT | MT_USB_TYPE_VENDOR, addr, val);
+	mutex_unlock(&dev->usb.usb_ctrl_mtx);
+}
+EXPORT_SYMBOL_GPL(mt792xu_wr);
+
+u32 mt792xu_rmw(struct mt76_dev *dev, u32 addr, u32 mask, u32 val)
+{
+	mutex_lock(&dev->usb.usb_ctrl_mtx);
+	val |= ___mt76u_rr(dev, MT_VEND_READ_EXT,
+			   USB_DIR_IN | MT_USB_TYPE_VENDOR, addr) & ~mask;
+	___mt76u_wr(dev, MT_VEND_WRITE_EXT,
+		    USB_DIR_OUT | MT_USB_TYPE_VENDOR, addr, val);
+	mutex_unlock(&dev->usb.usb_ctrl_mtx);
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(mt792xu_rmw);
+
+void mt792xu_copy(struct mt76_dev *dev, u32 offset, const void *data, int len)
+{
+	struct mt76_usb *usb = &dev->usb;
+	int ret, i = 0, batch_len;
+	const u8 *val = data;
+
+	len = round_up(len, 4);
+
+	mutex_lock(&usb->usb_ctrl_mtx);
+	while (i < len) {
+		batch_len = min_t(int, usb->data_len, len - i);
+		memcpy(usb->data, val + i, batch_len);
+		ret = __mt76u_vendor_request(dev, MT_VEND_WRITE_EXT,
+					     USB_DIR_OUT | MT_USB_TYPE_VENDOR,
+					     (offset + i) >> 16, offset + i,
+					     usb->data, batch_len);
+		if (ret < 0)
+			break;
+
+		i += batch_len;
+	}
+	mutex_unlock(&usb->usb_ctrl_mtx);
+}
+EXPORT_SYMBOL_GPL(mt792xu_copy);
+
+int mt792xu_mcu_power_on(struct mt792x_dev *dev)
+{
+	int ret;
+
+	ret = mt76u_vendor_request(&dev->mt76, MT_VEND_POWER_ON,
+				   USB_DIR_OUT | MT_USB_TYPE_VENDOR,
+				   0x0, 0x1, NULL, 0);
+	if (ret)
+		return ret;
+
+	if (!mt76_poll_msec(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_PWR_ON,
+			    MT_TOP_MISC2_FW_PWR_ON, 500)) {
+		dev_err(dev->mt76.dev, "Timeout for power on\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt792xu_mcu_power_on);
+
+void mt792xu_cleanup(struct mt792x_dev *dev)
+{
+	clear_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
+	mt792xu_wfsys_reset(dev);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+	mt76u_queues_deinit(&dev->mt76);
+}
+EXPORT_SYMBOL_GPL(mt792xu_cleanup);
+
+static u32 mt792xu_uhw_rr(struct mt76_dev *dev, u32 addr)
 {
 	u32 ret;
 
@@ -24,7 +112,7 @@ static u32 mt7921u_uhw_rr(struct mt76_dev *dev, u32 addr)
 	return ret;
 }
 
-static void mt7921u_uhw_wr(struct mt76_dev *dev, u32 addr, u32 val)
+static void mt792xu_uhw_wr(struct mt76_dev *dev, u32 addr, u32 val)
 {
 	mutex_lock(&dev->usb.usb_ctrl_mtx);
 	___mt76u_wr(dev, MT_VEND_WRITE,
@@ -32,7 +120,7 @@ static void mt7921u_uhw_wr(struct mt76_dev *dev, u32 addr, u32 val)
 	mutex_unlock(&dev->usb.usb_ctrl_mtx);
 }
 
-static void mt7921u_dma_prefetch(struct mt792x_dev *dev)
+static void mt792xu_dma_prefetch(struct mt792x_dev *dev)
 {
 	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(0),
 		 MT_WPDMA0_MAX_CNT_MASK, 4);
@@ -70,9 +158,9 @@ static void mt7921u_dma_prefetch(struct mt792x_dev *dev)
 		 MT_WPDMA0_BASE_PTR_MASK,  0x2c0);
 }
 
-static void mt7921u_wfdma_init(struct mt792x_dev *dev)
+static void mt792xu_wfdma_init(struct mt792x_dev *dev)
 {
-	mt7921u_dma_prefetch(dev);
+	mt792xu_dma_prefetch(dev);
 
 	mt76_clear(dev, MT_UWFDMA0_GLO_CFG, MT_WFDMA0_GLO_CFG_OMIT_RX_INFO);
 	mt76_set(dev, MT_UWFDMA0_GLO_CFG,
@@ -90,7 +178,7 @@ static void mt7921u_wfdma_init(struct mt792x_dev *dev)
 	mt76_set(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
 }
 
-static int mt7921u_dma_rx_evt_ep4(struct mt792x_dev *dev)
+static int mt792xu_dma_rx_evt_ep4(struct mt792x_dev *dev)
 {
 	if (!mt76_poll(dev, MT_UWFDMA0_GLO_CFG,
 		       MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 1000))
@@ -104,7 +192,7 @@ static int mt7921u_dma_rx_evt_ep4(struct mt792x_dev *dev)
 	return 0;
 }
 
-static void mt7921u_epctl_rst_opt(struct mt792x_dev *dev, bool reset)
+static void mt792xu_epctl_rst_opt(struct mt792x_dev *dev, bool reset)
 {
 	u32 val;
 
@@ -113,19 +201,19 @@ static void mt7921u_epctl_rst_opt(struct mt792x_dev *dev, bool reset)
 	 * bits[20,21]: in blk ep 4-5
 	 * bits[22]: in int ep 6
 	 */
-	val = mt7921u_uhw_rr(&dev->mt76, MT_SSUSB_EPCTL_CSR_EP_RST_OPT);
+	val = mt792xu_uhw_rr(&dev->mt76, MT_SSUSB_EPCTL_CSR_EP_RST_OPT);
 	if (reset)
 		val |= GENMASK(9, 4) | GENMASK(22, 20);
 	else
 		val &= ~(GENMASK(9, 4) | GENMASK(22, 20));
-	mt7921u_uhw_wr(&dev->mt76, MT_SSUSB_EPCTL_CSR_EP_RST_OPT, val);
+	mt792xu_uhw_wr(&dev->mt76, MT_SSUSB_EPCTL_CSR_EP_RST_OPT, val);
 }
 
-int mt7921u_dma_init(struct mt792x_dev *dev, bool resume)
+int mt792xu_dma_init(struct mt792x_dev *dev, bool resume)
 {
 	int err;
 
-	mt7921u_wfdma_init(dev);
+	mt792xu_wfdma_init(dev);
 
 	mt76_clear(dev, MT_UDMA_WLCFG_0, MT_WL_RX_FLUSH);
 
@@ -139,35 +227,36 @@ int mt7921u_dma_init(struct mt792x_dev *dev, bool resume)
 	if (resume)
 		return 0;
 
-	err = mt7921u_dma_rx_evt_ep4(dev);
+	err = mt792xu_dma_rx_evt_ep4(dev);
 	if (err)
 		return err;
 
-	mt7921u_epctl_rst_opt(dev, false);
+	mt792xu_epctl_rst_opt(dev, false);
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt792xu_dma_init);
 
-int mt7921u_wfsys_reset(struct mt792x_dev *dev)
+int mt792xu_wfsys_reset(struct mt792x_dev *dev)
 {
 	u32 val;
 	int i;
 
-	mt7921u_epctl_rst_opt(dev, false);
+	mt792xu_epctl_rst_opt(dev, false);
 
-	val = mt7921u_uhw_rr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST);
+	val = mt792xu_uhw_rr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST);
 	val |= MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH;
-	mt7921u_uhw_wr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST, val);
+	mt792xu_uhw_wr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST, val);
 
 	usleep_range(10, 20);
 
-	val = mt7921u_uhw_rr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST);
+	val = mt792xu_uhw_rr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST);
 	val &= ~MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH;
-	mt7921u_uhw_wr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST, val);
+	mt792xu_uhw_wr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST, val);
 
-	mt7921u_uhw_wr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS_SEL, 0);
+	mt792xu_uhw_wr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS_SEL, 0);
 	for (i = 0; i < MT792x_WFSYS_INIT_RETRY_COUNT; i++) {
-		val = mt7921u_uhw_rr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS);
+		val = mt792xu_uhw_rr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS);
 		if (val & MT_UDMA_CONN_WFSYS_INIT_DONE)
 			break;
 
@@ -179,8 +268,9 @@ int mt7921u_wfsys_reset(struct mt792x_dev *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt792xu_wfsys_reset);
 
-int mt7921u_init_reset(struct mt792x_dev *dev)
+int mt792xu_init_reset(struct mt792x_dev *dev)
 {
 	set_bit(MT76_RESET, &dev->mphy.state);
 
@@ -190,66 +280,13 @@ int mt7921u_init_reset(struct mt792x_dev *dev)
 	mt76u_stop_rx(&dev->mt76);
 	mt76u_stop_tx(&dev->mt76);
 
-	mt7921u_wfsys_reset(dev);
+	mt792xu_wfsys_reset(dev);
 
 	clear_bit(MT76_RESET, &dev->mphy.state);
 
 	return mt76u_resume_rx(&dev->mt76);
 }
+EXPORT_SYMBOL_GPL(mt792xu_init_reset);
 
-int mt7921u_mac_reset(struct mt792x_dev *dev)
-{
-	int err;
-
-	mt76_txq_schedule_all(&dev->mphy);
-	mt76_worker_disable(&dev->mt76.tx_worker);
-
-	set_bit(MT76_RESET, &dev->mphy.state);
-	set_bit(MT76_MCU_RESET, &dev->mphy.state);
-
-	wake_up(&dev->mt76.mcu.wait);
-	skb_queue_purge(&dev->mt76.mcu.res_q);
-
-	mt76u_stop_rx(&dev->mt76);
-	mt76u_stop_tx(&dev->mt76);
-
-	mt7921u_wfsys_reset(dev);
-
-	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
-	err = mt76u_resume_rx(&dev->mt76);
-	if (err)
-		goto out;
-
-	err = mt7921u_mcu_power_on(dev);
-	if (err)
-		goto out;
-
-	err = mt7921u_dma_init(dev, false);
-	if (err)
-		goto out;
-
-	mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
-	mt76_set(dev, MT_UDMA_TX_QSEL, MT_FW_DL_EN);
-
-	err = mt7921_run_firmware(dev);
-	if (err)
-		goto out;
-
-	mt76_clear(dev, MT_UDMA_TX_QSEL, MT_FW_DL_EN);
-
-	err = mt7921_mcu_set_eeprom(dev);
-	if (err)
-		goto out;
-
-	err = mt7921_mac_init(dev);
-	if (err)
-		goto out;
-
-	err = __mt7921_start(&dev->phy);
-out:
-	clear_bit(MT76_RESET, &dev->mphy.state);
-
-	mt76_worker_enable(&dev->mt76.tx_worker);
-
-	return err;
-}
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
-- 
2.18.0

