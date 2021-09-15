Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF9640BD2C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 03:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhIOB0r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 21:26:47 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:51734 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhIOB0q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 21:26:46 -0400
X-UUID: 152891024de341d2b6e89650d3f72c8d-20210914
X-UUID: 152891024de341d2b6e89650d3f72c8d-20210914
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2015281544; Tue, 14 Sep 2021 18:25:25 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 18:15:48 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Sep 2021 09:15:48 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <steve.lee@mediatek.com>, <jemele@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v1 13/16] mt76: mt7921: rely on mcu_get_nic_capability
Date:   Wed, 15 Sep 2021 09:14:46 +0800
Message-ID: <1f07bdb8d81c74f8d1faab11af22d9c74fc889c5.1631667941.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1631667941.git.objelf@gmail.com>
References: <cover.1631667941.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Rely on mcu_get_nic_capability to obtain Tx quota information
for the SDIO device, get PHY capability, MAC address and then we can
totally drop mt7921/eeprom.c and any unnecessary code.

Noting that mt76_connac_mcu_get_nic_capability should be run before set
flag MT76_STATE_MCU_RUNNING being set to setup the proper parameters
like Tx quota control before the device is started to running.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  |   1 +
 .../mediatek/mt76/mt76_connac_sdio_txrx.c     |   3 +-
 .../wireless/mediatek/mt76/mt7921/Makefile    |   2 +-
 .../wireless/mediatek/mt76/mt7921/eeprom.c    | 101 ------------------
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  10 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |   8 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   8 --
 7 files changed, 10 insertions(+), 123 deletions(-)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index a7cb7cc373b7..da53bd5cc533 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -27,6 +27,7 @@ static int mt7663s_mcu_init_sched(struct mt7615_dev *dev)
 						   MT_HIF1_MIN_QUOTA);
 	sdio->sched.ple_data_quota = mt76_get_field(dev, MT_PLE_PG_HIF0_GROUP,
 						    MT_HIF0_MIN_QUOTA);
+	sdio->sched.pse_page_size = MT_PSE_PAGE_SZ;
 	txdwcnt = mt76_get_field(dev, MT_PP_TXDWCNT,
 				 MT_PP_TXDWCNT_TX1_ADD_DW_CNT);
 	sdio->sched.deficit = txdwcnt << 2;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio_txrx.c
index c6a9d8fb4295..22a8058a1705 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio_txrx.c
@@ -212,7 +212,8 @@ static int mt76_connac_sdio_tx_pick_quota(struct mt76_sdio *sdio, bool mcu,
 {
 	int pse_sz;
 
-	pse_sz = DIV_ROUND_UP(buf_sz + sdio->sched.deficit, MT_PSE_PAGE_SZ);
+	pse_sz = DIV_ROUND_UP(buf_sz + sdio->sched.deficit,
+			      sdio->sched.pse_page_size);
 
 	if (mcu && sdio->hw_ver == MT76_CONNAC2_SDIO)
 		pse_sz = 1;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index 32f87d946bc7..983d40fb3fb6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -5,6 +5,6 @@ obj-$(CONFIG_MT7921E) += mt7921e.o
 
 CFLAGS_trace.o := -I$(src)
 
-mt7921-common-y := mac.o mcu.o eeprom.o main.o init.o debugfs.o trace.o
+mt7921-common-y := mac.o mcu.o main.o init.o debugfs.o trace.o
 mt7921-common-$(CONFIG_NL80211_TESTMODE) += testmode.o
 mt7921e-y := pci.o pci_mac.o pci_mcu.o pci_init.o dma.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
deleted file mode 100644
index 4d0a4aeac6bf..000000000000
--- a/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
+++ /dev/null
@@ -1,101 +0,0 @@
-// SPDX-License-Identifier: ISC
-/* Copyright (C) 2020 MediaTek Inc. */
-
-#include "mt7921.h"
-#include "eeprom.h"
-
-static u32 mt7921_eeprom_read(struct mt7921_dev *dev, u32 offset)
-{
-	u8 *data = dev->mt76.eeprom.data;
-
-	if (data[offset] == 0xff)
-		mt7921_mcu_get_eeprom(dev, offset);
-
-	return data[offset];
-}
-
-static int mt7921_eeprom_load(struct mt7921_dev *dev)
-{
-	int ret;
-
-	ret = mt76_eeprom_init(&dev->mt76, MT7921_EEPROM_SIZE);
-	if (ret < 0)
-		return ret;
-
-	memset(dev->mt76.eeprom.data, -1, MT7921_EEPROM_SIZE);
-
-	return 0;
-}
-
-static int mt7921_check_eeprom(struct mt7921_dev *dev)
-{
-	u8 *eeprom = dev->mt76.eeprom.data;
-	u16 val;
-
-	mt7921_eeprom_read(dev, MT_EE_CHIP_ID);
-	val = get_unaligned_le16(eeprom);
-
-	switch (val) {
-	case 0x7922:
-	case 0x7961:
-		return 0;
-	default:
-		return -EINVAL;
-	}
-}
-
-void mt7921_eeprom_parse_band_config(struct mt7921_phy *phy)
-{
-	struct mt7921_dev *dev = phy->dev;
-	u32 val;
-
-	val = mt7921_eeprom_read(dev, MT_EE_WIFI_CONF);
-	val = FIELD_GET(MT_EE_WIFI_CONF_BAND_SEL, val);
-
-	switch (val) {
-	case MT_EE_5GHZ:
-		phy->mt76->cap.has_5ghz = true;
-		break;
-	case MT_EE_2GHZ:
-		phy->mt76->cap.has_2ghz = true;
-		break;
-	default:
-		phy->mt76->cap.has_2ghz = true;
-		phy->mt76->cap.has_5ghz = true;
-		break;
-	}
-}
-
-static void mt7921_eeprom_parse_hw_cap(struct mt7921_dev *dev)
-{
-	u8 tx_mask;
-
-	mt7921_eeprom_parse_band_config(&dev->phy);
-
-	/* TODO: read NSS with MCU_CMD_NIC_CAPV2 */
-	tx_mask = 2;
-	dev->chainmask = BIT(tx_mask) - 1;
-	dev->mphy.antenna_mask = dev->chainmask;
-	dev->mphy.chainmask = dev->mphy.antenna_mask;
-}
-
-int mt7921_eeprom_init(struct mt7921_dev *dev)
-{
-	int ret;
-
-	ret = mt7921_eeprom_load(dev);
-	if (ret < 0)
-		return ret;
-
-	ret = mt7921_check_eeprom(dev);
-	if (ret)
-		return ret;
-
-	mt7921_eeprom_parse_hw_cap(dev);
-	memcpy(dev->mphy.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
-	       ETH_ALEN);
-
-	mt76_eeprom_override(&dev->mphy);
-
-	return 0;
-}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index d310d6e1e566..6a4b014e8afd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -149,7 +149,6 @@ EXPORT_SYMBOL_GPL(mt7921_mac_init);
 
 static int __mt7921_init_hardware(struct mt7921_dev *dev)
 {
-	struct mt76_dev *mdev = &dev->mt76;
 	int ret;
 
 	/* force firmware operation mode into normal state,
@@ -160,9 +159,7 @@ static int __mt7921_init_hardware(struct mt7921_dev *dev)
 	if (ret)
 		goto out;
 
-	ret = mt7921_eeprom_init(dev);
-	if (ret)
-		goto out;
+	mt76_eeprom_override(&dev->mphy);
 
 	ret = mt7921_mcu_set_eeprom(dev);
 	if (ret)
@@ -170,11 +167,6 @@ static int __mt7921_init_hardware(struct mt7921_dev *dev)
 
 	ret = mt7921_mac_init(dev);
 out:
-	if (ret && mdev->eeprom.data) {
-		devm_kfree(mdev->dev, mdev->eeprom.data);
-		mdev->eeprom.data = NULL;
-	}
-
 	return ret;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 8e49df20a8cb..b3e257594f92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -911,10 +911,12 @@ int mt7921_run_firmware(struct mt7921_dev *dev)
 	if (err)
 		return err;
 
-	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
-	mt7921_mcu_fw_log_2_host(dev, 1);
+	err = mt76_connac_mcu_get_nic_capability(&dev->mphy);
+	if (err)
+		return err;
 
-	return mt76_connac_mcu_get_nic_capability(&dev->mphy);
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+	return mt7921_mcu_fw_log_2_host(dev, 1);
 }
 EXPORT_SYMBOL_GPL(mt7921_run_firmware);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 60f4552cb212..bd52e39e8181 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -156,8 +156,6 @@ struct mt7921_dev {
 	struct mt7921_phy phy;
 	struct tasklet_struct irq_tasklet;
 
-	u16 chainmask;
-
 	struct work_struct reset_work;
 	bool hw_full_reset:1;
 	bool hw_init_done:1;
@@ -247,12 +245,6 @@ u32 mt7921_reg_map(struct mt7921_dev *dev, u32 addr);
 int __mt7921_start(struct mt7921_phy *phy);
 int mt7921_register_device(struct mt7921_dev *dev);
 void mt7921_unregister_device(struct mt7921_dev *dev);
-int mt7921_eeprom_init(struct mt7921_dev *dev);
-void mt7921_eeprom_parse_band_config(struct mt7921_phy *phy);
-int mt7921_eeprom_get_target_power(struct mt7921_dev *dev,
-				   struct ieee80211_channel *chan,
-				   u8 chain_idx);
-void mt7921_eeprom_init_sku(struct mt7921_dev *dev);
 int mt7921_dma_init(struct mt7921_dev *dev);
 int mt7921_wpdma_reset(struct mt7921_dev *dev, bool force);
 int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev);
-- 
2.25.1

