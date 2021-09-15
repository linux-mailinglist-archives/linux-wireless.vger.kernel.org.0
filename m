Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6B540BD2B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 03:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhIOB0k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 21:26:40 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:53475 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhIOB0j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 21:26:39 -0400
X-UUID: 2a21d1501eb244f38b955896070b3c04-20210914
X-UUID: 2a21d1501eb244f38b955896070b3c04-20210914
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 80232505; Tue, 14 Sep 2021 18:25:18 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 18:15:26 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Sep 2021 09:15:25 +0800
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
Subject: [PATCH v1 08/16] mt76: mt7663s: rely on mt76_connac_sdio common library
Date:   Wed, 15 Sep 2021 09:14:41 +0800
Message-ID: <f985f33eb0c24f290146d395b0ade6449c78f284.1631667941.git.objelf@gmail.com>
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

Rely on mt76_connac_sdio common library and remove unneeded code

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7615/Kconfig |   2 +-
 .../wireless/mediatek/mt76/mt7615/Makefile    |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  28 --
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   6 -
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  | 309 ++--------------
 .../net/wireless/mediatek/mt76/mt7615/sdio.h  | 115 ------
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  |   8 +-
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 334 ------------------
 8 files changed, 35 insertions(+), 769 deletions(-)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio.h
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
index 30fba36ff46b..110211cc9e57 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
@@ -47,9 +47,9 @@ config MT7663U
 config MT7663S
 	tristate "MediaTek MT7663S (SDIO) support"
 	select MT76_SDIO
+	select MT76_CONNAC_SDIO
 	select MT7663_USB_SDIO_COMMON
 	depends on MAC80211
-	depends on MMC
 	help
 	  This adds support for MT7663S 802.11ac 2x2:2 wireless devices.
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
index 83f9861ff522..2b97b9dde477 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
@@ -17,4 +17,4 @@ mt7615e-$(CONFIG_MT7622_WMAC) += soc.o
 
 mt7663-usb-sdio-common-y := usb_sdio.o
 mt7663u-y := usb.o usb_mcu.o
-mt7663s-y := sdio.o sdio_mcu.o sdio_txrx.o
+mt7663s-y := sdio.o sdio_mcu.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 684240e4624c..583cf815a696 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2759,31 +2759,3 @@ int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_ROC, &req,
 				 sizeof(req), false);
 }
-
-u32 mt7615_mcu_reg_rr(struct mt76_dev *dev, u32 offset)
-{
-	struct {
-		__le32 addr;
-		__le32 val;
-	} __packed req = {
-		.addr = cpu_to_le32(offset),
-	};
-
-	return mt76_mcu_send_msg(dev, MCU_CMD_REG_READ, &req, sizeof(req),
-				 true);
-}
-EXPORT_SYMBOL_GPL(mt7615_mcu_reg_rr);
-
-void mt7615_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val)
-{
-	struct {
-		__le32 addr;
-		__le32 val;
-	} __packed req = {
-		.addr = cpu_to_le32(offset),
-		.val = cpu_to_le32(val),
-	};
-
-	mt76_mcu_send_msg(dev, MCU_CMD_REG_WRITE, &req, sizeof(req), false);
-}
-EXPORT_SYMBOL_GPL(mt7615_mcu_reg_wr);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 58a98b5c0cbc..77bd59813d47 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -553,8 +553,6 @@ int mt7615_mac_set_beacon_filter(struct mt7615_phy *phy,
 int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			  bool enable);
 int __mt7663_load_firmware(struct mt7615_dev *dev);
-u32 mt7615_mcu_reg_rr(struct mt76_dev *dev, u32 offset);
-void mt7615_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val);
 void mt7615_coredump_work(struct work_struct *work);
 
 void mt7622_trigger_hif_int(struct mt7615_dev *dev, bool en);
@@ -571,10 +569,6 @@ int mt7663_usb_sdio_register_device(struct mt7615_dev *dev);
 int mt7663u_mcu_init(struct mt7615_dev *dev);
 
 /* sdio */
-u32 mt7663s_read_pcr(struct mt7615_dev *dev);
 int mt7663s_mcu_init(struct mt7615_dev *dev);
-void mt7663s_txrx_worker(struct mt76_worker *w);
-void mt7663s_rx_work(struct work_struct *work);
-void mt7663s_sdio_irq(struct sdio_func *func);
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index fb0f8f34b8f2..97660262b2de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -15,7 +15,7 @@
 #include <linux/mmc/sdio_func.h>
 
 #include "mt7615.h"
-#include "sdio.h"
+#include "../mt76_connac_sdio.h"
 #include "mac.h"
 #include "mcu.h"
 
@@ -24,202 +24,6 @@ static const struct sdio_device_id mt7663s_table[] = {
 	{ }	/* Terminating entry */
 };
 
-static u32 mt7663s_read_whisr(struct mt76_dev *dev)
-{
-	return sdio_readl(dev->sdio.func, MCR_WHISR, NULL);
-}
-
-u32 mt7663s_read_pcr(struct mt7615_dev *dev)
-{
-	struct mt76_sdio *sdio = &dev->mt76.sdio;
-
-	return sdio_readl(sdio->func, MCR_WHLPCR, NULL);
-}
-
-static u32 mt7663s_read_mailbox(struct mt76_dev *dev, u32 offset)
-{
-	struct sdio_func *func = dev->sdio.func;
-	u32 val = ~0, status;
-	int err;
-
-	sdio_claim_host(func);
-
-	sdio_writel(func, offset, MCR_H2DSM0R, &err);
-	if (err < 0) {
-		dev_err(dev->dev, "failed setting address [err=%d]\n", err);
-		goto out;
-	}
-
-	sdio_writel(func, H2D_SW_INT_READ, MCR_WSICR, &err);
-	if (err < 0) {
-		dev_err(dev->dev, "failed setting read mode [err=%d]\n", err);
-		goto out;
-	}
-
-	err = readx_poll_timeout(mt7663s_read_whisr, dev, status,
-				 status & H2D_SW_INT_READ, 0, 1000000);
-	if (err < 0) {
-		dev_err(dev->dev, "query whisr timeout\n");
-		goto out;
-	}
-
-	sdio_writel(func, H2D_SW_INT_READ, MCR_WHISR, &err);
-	if (err < 0) {
-		dev_err(dev->dev, "failed setting read mode [err=%d]\n", err);
-		goto out;
-	}
-
-	val = sdio_readl(func, MCR_H2DSM0R, &err);
-	if (err < 0) {
-		dev_err(dev->dev, "failed reading h2dsm0r [err=%d]\n", err);
-		goto out;
-	}
-
-	if (val != offset) {
-		dev_err(dev->dev, "register mismatch\n");
-		val = ~0;
-		goto out;
-	}
-
-	val = sdio_readl(func, MCR_D2HRM1R, &err);
-	if (err < 0)
-		dev_err(dev->dev, "failed reading d2hrm1r [err=%d]\n", err);
-
-out:
-	sdio_release_host(func);
-
-	return val;
-}
-
-static void mt7663s_write_mailbox(struct mt76_dev *dev, u32 offset, u32 val)
-{
-	struct sdio_func *func = dev->sdio.func;
-	u32 status;
-	int err;
-
-	sdio_claim_host(func);
-
-	sdio_writel(func, offset, MCR_H2DSM0R, &err);
-	if (err < 0) {
-		dev_err(dev->dev, "failed setting address [err=%d]\n", err);
-		goto out;
-	}
-
-	sdio_writel(func, val, MCR_H2DSM1R, &err);
-	if (err < 0) {
-		dev_err(dev->dev,
-			"failed setting write value [err=%d]\n", err);
-		goto out;
-	}
-
-	sdio_writel(func, H2D_SW_INT_WRITE, MCR_WSICR, &err);
-	if (err < 0) {
-		dev_err(dev->dev, "failed setting write mode [err=%d]\n", err);
-		goto out;
-	}
-
-	err = readx_poll_timeout(mt7663s_read_whisr, dev, status,
-				 status & H2D_SW_INT_WRITE, 0, 1000000);
-	if (err < 0) {
-		dev_err(dev->dev, "query whisr timeout\n");
-		goto out;
-	}
-
-	sdio_writel(func, H2D_SW_INT_WRITE, MCR_WHISR, &err);
-	if (err < 0) {
-		dev_err(dev->dev, "failed setting write mode [err=%d]\n", err);
-		goto out;
-	}
-
-	val = sdio_readl(func, MCR_H2DSM0R, &err);
-	if (err < 0) {
-		dev_err(dev->dev, "failed reading h2dsm0r [err=%d]\n", err);
-		goto out;
-	}
-
-	if (val != offset)
-		dev_err(dev->dev, "register mismatch\n");
-
-out:
-	sdio_release_host(func);
-}
-
-static u32 mt7663s_rr(struct mt76_dev *dev, u32 offset)
-{
-	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))
-		return dev->mcu_ops->mcu_rr(dev, offset);
-	else
-		return mt7663s_read_mailbox(dev, offset);
-}
-
-static void mt7663s_wr(struct mt76_dev *dev, u32 offset, u32 val)
-{
-	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))
-		dev->mcu_ops->mcu_wr(dev, offset, val);
-	else
-		mt7663s_write_mailbox(dev, offset, val);
-}
-
-static u32 mt7663s_rmw(struct mt76_dev *dev, u32 offset, u32 mask, u32 val)
-{
-	val |= mt7663s_rr(dev, offset) & ~mask;
-	mt7663s_wr(dev, offset, val);
-
-	return val;
-}
-
-static void mt7663s_write_copy(struct mt76_dev *dev, u32 offset,
-			       const void *data, int len)
-{
-	const u32 *val = data;
-	int i;
-
-	for (i = 0; i < len / sizeof(u32); i++) {
-		mt7663s_wr(dev, offset, val[i]);
-		offset += sizeof(u32);
-	}
-}
-
-static void mt7663s_read_copy(struct mt76_dev *dev, u32 offset,
-			      void *data, int len)
-{
-	u32 *val = data;
-	int i;
-
-	for (i = 0; i < len / sizeof(u32); i++) {
-		val[i] = mt7663s_rr(dev, offset);
-		offset += sizeof(u32);
-	}
-}
-
-static int mt7663s_wr_rp(struct mt76_dev *dev, u32 base,
-			 const struct mt76_reg_pair *data,
-			 int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++) {
-		mt7663s_wr(dev, data->reg, data->value);
-		data++;
-	}
-
-	return 0;
-}
-
-static int mt7663s_rd_rp(struct mt76_dev *dev, u32 base,
-			 struct mt76_reg_pair *data,
-			 int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++) {
-		data->value = mt7663s_rr(dev, data->reg);
-		data++;
-	}
-
-	return 0;
-}
-
 static void mt7663s_init_work(struct work_struct *work)
 {
 	struct mt7615_dev *dev;
@@ -231,64 +35,32 @@ static void mt7663s_init_work(struct work_struct *work)
 	mt7615_init_work(dev);
 }
 
-static int mt7663s_hw_init(struct mt7615_dev *dev, struct sdio_func *func)
+static void mt7663s_txrx_worker(struct mt76_worker *w)
 {
-	u32 status, ctrl;
-	int ret;
-
-	sdio_claim_host(func);
-
-	ret = sdio_enable_func(func);
-	if (ret < 0)
-		goto release;
+	struct mt76_sdio *sdio = container_of(w, struct mt76_sdio,
+					      txrx_worker);
+	struct mt76_dev *mdev = container_of(sdio, struct mt76_dev, sdio);
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 
-	/* Get ownership from the device */
-	sdio_writel(func, WHLPCR_INT_EN_CLR | WHLPCR_FW_OWN_REQ_CLR,
-		    MCR_WHLPCR, &ret);
-	if (ret < 0)
-		goto disable_func;
-
-	ret = readx_poll_timeout(mt7663s_read_pcr, dev, status,
-				 status & WHLPCR_IS_DRIVER_OWN, 2000, 1000000);
-	if (ret < 0) {
-		dev_err(dev->mt76.dev, "Cannot get ownership from device");
-		goto disable_func;
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
+		queue_work(mdev->wq, &dev->pm.wake_work);
+		return;
 	}
 
-	ret = sdio_set_block_size(func, 512);
-	if (ret < 0)
-		goto disable_func;
-
-	/* Enable interrupt */
-	sdio_writel(func, WHLPCR_INT_EN_SET, MCR_WHLPCR, &ret);
-	if (ret < 0)
-		goto disable_func;
-
-	ctrl = WHIER_RX0_DONE_INT_EN | WHIER_TX_DONE_INT_EN;
-	sdio_writel(func, ctrl, MCR_WHIER, &ret);
-	if (ret < 0)
-		goto disable_func;
-
-	/* set WHISR as read clear and Rx aggregation number as 16 */
-	ctrl = FIELD_PREP(MAX_HIF_RX_LEN_NUM, 16);
-	sdio_writel(func, ctrl, MCR_WHCR, &ret);
-	if (ret < 0)
-		goto disable_func;
+	mt76_connac_sdio_txrx(mdev);
 
-	ret = sdio_claim_irq(func, mt7663s_sdio_irq);
-	if (ret < 0)
-		goto disable_func;
-
-	sdio_release_host(func);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
+}
 
-	return 0;
+static void mt7663s_irq(struct sdio_func *func)
+{
+	struct mt7615_dev *dev = sdio_get_drvdata(func);
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
 
-disable_func:
-	sdio_disable_func(func);
-release:
-	sdio_release_host(func);
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mt76.phy.state))
+		return;
 
-	return ret;
+	mt76_worker_schedule(&sdio->txrx_worker);
 }
 
 static int mt7663s_probe(struct sdio_func *func,
@@ -307,19 +79,19 @@ static int mt7663s_probe(struct sdio_func *func,
 		.update_survey = mt7615_update_channel,
 	};
 	static const struct mt76_bus_ops mt7663s_ops = {
-		.rr = mt7663s_rr,
-		.rmw = mt7663s_rmw,
-		.wr = mt7663s_wr,
-		.write_copy = mt7663s_write_copy,
-		.read_copy = mt7663s_read_copy,
-		.wr_rp = mt7663s_wr_rp,
-		.rd_rp = mt7663s_rd_rp,
+		.rr = mt76_connac_sdio_rr,
+		.rmw = mt76_connac_sdio_rmw,
+		.wr = mt76_connac_sdio_wr,
+		.write_copy = mt76_connac_sdio_write_copy,
+		.read_copy = mt76_connac_sdio_read_copy,
+		.wr_rp = mt76_connac_sdio_wr_rp,
+		.rd_rp = mt76_connac_sdio_rd_rp,
 		.type = MT76_BUS_SDIO,
 	};
 	struct ieee80211_ops *ops;
 	struct mt7615_dev *dev;
 	struct mt76_dev *mdev;
-	int i, ret;
+	int ret;
 
 	ops = devm_kmemdup(&func->dev, &mt7615_ops, sizeof(mt7615_ops),
 			   GFP_KERNEL);
@@ -341,7 +113,7 @@ static int mt7663s_probe(struct sdio_func *func,
 	if (ret < 0)
 		goto error;
 
-	ret = mt7663s_hw_init(dev, func);
+	ret = mt76_connac_sdio_hw_init(mdev, func, mt7663s_irq);
 	if (ret)
 		goto error;
 
@@ -349,35 +121,14 @@ static int mt7663s_probe(struct sdio_func *func,
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
 	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
-	mdev->sdio.intr_data = devm_kmalloc(mdev->dev,
-					    sizeof(struct mt76s_intr),
-					    GFP_KERNEL);
-	if (!mdev->sdio.intr_data) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(mdev->sdio.xmit_buf); i++) {
-		mdev->sdio.xmit_buf[i] = devm_kmalloc(mdev->dev,
-						      MT76S_XMIT_BUF_SZ,
-						      GFP_KERNEL);
-		if (!mdev->sdio.xmit_buf[i]) {
-			ret = -ENOMEM;
-			goto error;
-		}
-	}
-
-	ret = mt76s_alloc_queues(&dev->mt76);
+	ret = mt76_connac_sdio_init(mdev, mt7663s_txrx_worker);
 	if (ret)
 		goto error;
 
-	ret = mt76_worker_setup(mt76_hw(dev), &mdev->sdio.txrx_worker,
-				mt7663s_txrx_worker, "sdio-txrx");
+	ret = mt76s_alloc_queues(&dev->mt76);
 	if (ret)
 		goto error;
 
-	sched_set_fifo_low(mdev->sdio.txrx_worker.task);
-
 	ret = mt7663_usb_sdio_register_device(dev);
 	if (ret)
 		goto error;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.h b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.h
deleted file mode 100644
index 03877d89e152..000000000000
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.h
+++ /dev/null
@@ -1,115 +0,0 @@
-/* SPDX-License-Identifier: ISC */
-/* Copyright (C) 2020 MediaTek Inc.
- *
- * Author: Sean Wang <sean.wang@mediatek.com>
- */
-
-#ifndef __MT76S_H
-#define __MT76S_H
-
-#define MT_PSE_PAGE_SZ			128
-
-#define MCR_WCIR			0x0000
-#define MCR_WHLPCR			0x0004
-#define WHLPCR_FW_OWN_REQ_CLR		BIT(9)
-#define WHLPCR_FW_OWN_REQ_SET		BIT(8)
-#define WHLPCR_IS_DRIVER_OWN		BIT(8)
-#define WHLPCR_INT_EN_CLR		BIT(1)
-#define WHLPCR_INT_EN_SET		BIT(0)
-
-#define MCR_WSDIOCSR			0x0008
-#define MCR_WHCR			0x000C
-#define W_INT_CLR_CTRL			BIT(1)
-#define RECV_MAILBOX_RD_CLR_EN		BIT(2)
-#define MAX_HIF_RX_LEN_NUM		GENMASK(13, 8)
-#define RX_ENHANCE_MODE			BIT(16)
-
-#define MCR_WHISR			0x0010
-#define MCR_WHIER			0x0014
-#define WHIER_D2H_SW_INT		GENMASK(31, 8)
-#define WHIER_FW_OWN_BACK_INT_EN	BIT(7)
-#define WHIER_ABNORMAL_INT_EN		BIT(6)
-#define WHIER_RX1_DONE_INT_EN		BIT(2)
-#define WHIER_RX0_DONE_INT_EN		BIT(1)
-#define WHIER_TX_DONE_INT_EN		BIT(0)
-#define WHIER_DEFAULT			(WHIER_RX0_DONE_INT_EN	| \
-					 WHIER_RX1_DONE_INT_EN	| \
-					 WHIER_TX_DONE_INT_EN	| \
-					 WHIER_ABNORMAL_INT_EN	| \
-					 WHIER_D2H_SW_INT)
-
-#define MCR_WASR			0x0020
-#define MCR_WSICR			0x0024
-#define MCR_WTSR0			0x0028
-#define TQ0_CNT				GENMASK(7, 0)
-#define TQ1_CNT				GENMASK(15, 8)
-#define TQ2_CNT				GENMASK(23, 16)
-#define TQ3_CNT				GENMASK(31, 24)
-
-#define MCR_WTSR1			0x002c
-#define TQ4_CNT				GENMASK(7, 0)
-#define TQ5_CNT				GENMASK(15, 8)
-#define TQ6_CNT				GENMASK(23, 16)
-#define TQ7_CNT				GENMASK(31, 24)
-
-#define MCR_WTDR1			0x0034
-#define MCR_WRDR0			0x0050
-#define MCR_WRDR1			0x0054
-#define MCR_WRDR(p)			(0x0050 + 4 * (p))
-#define MCR_H2DSM0R			0x0070
-#define H2D_SW_INT_READ			BIT(16)
-#define H2D_SW_INT_WRITE		BIT(17)
-
-#define MCR_H2DSM1R			0x0074
-#define MCR_D2HRM0R			0x0078
-#define MCR_D2HRM1R			0x007c
-#define MCR_D2HRM2R			0x0080
-#define MCR_WRPLR			0x0090
-#define RX0_PACKET_LENGTH		GENMASK(15, 0)
-#define RX1_PACKET_LENGTH		GENMASK(31, 16)
-
-#define MCR_WTMDR			0x00b0
-#define MCR_WTMCR			0x00b4
-#define MCR_WTMDPCR0			0x00b8
-#define MCR_WTMDPCR1			0x00bc
-#define MCR_WPLRCR			0x00d4
-#define MCR_WSR				0x00D8
-#define MCR_CLKIOCR			0x0100
-#define MCR_CMDIOCR			0x0104
-#define MCR_DAT0IOCR			0x0108
-#define MCR_DAT1IOCR			0x010C
-#define MCR_DAT2IOCR			0x0110
-#define MCR_DAT3IOCR			0x0114
-#define MCR_CLKDLYCR			0x0118
-#define MCR_CMDDLYCR			0x011C
-#define MCR_ODATDLYCR			0x0120
-#define MCR_IDATDLYCR1			0x0124
-#define MCR_IDATDLYCR2			0x0128
-#define MCR_ILCHCR			0x012C
-#define MCR_WTQCR0			0x0130
-#define MCR_WTQCR1			0x0134
-#define MCR_WTQCR2			0x0138
-#define MCR_WTQCR3			0x013C
-#define MCR_WTQCR4			0x0140
-#define MCR_WTQCR5			0x0144
-#define MCR_WTQCR6			0x0148
-#define MCR_WTQCR7			0x014C
-#define MCR_WTQCR(x)                   (0x130 + 4 * (x))
-#define TXQ_CNT_L			GENMASK(15, 0)
-#define TXQ_CNT_H			GENMASK(31, 16)
-
-#define MCR_SWPCDBGR			0x0154
-
-struct mt76s_intr {
-	u32 isr;
-	struct {
-		u32 wtqcr[8];
-	} tx;
-	struct {
-		u16 num[2];
-		u16 len[2][16];
-	} rx;
-	u32 rec_mb[2];
-} __packed;
-
-#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index 77e6a57b2dc0..a7cb7cc373b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -14,7 +14,7 @@
 #include "mac.h"
 #include "mcu.h"
 #include "regs.h"
-#include "sdio.h"
+#include "../mt76_connac_sdio.h"
 
 static int mt7663s_mcu_init_sched(struct mt7615_dev *dev)
 {
@@ -63,7 +63,7 @@ static int __mt7663s_mcu_drv_pmctrl(struct mt7615_dev *dev)
 
 	sdio_writel(func, WHLPCR_FW_OWN_REQ_CLR, MCR_WHLPCR, NULL);
 
-	ret = readx_poll_timeout(mt7663s_read_pcr, dev, status,
+	ret = readx_poll_timeout(mt76_connac_sdio_read_pcr, &dev->mt76, status,
 				 status & WHLPCR_IS_DRIVER_OWN, 2000, 1000000);
 	if (ret < 0) {
 		dev_err(dev->mt76.dev, "Cannot get ownership from device");
@@ -111,7 +111,7 @@ static int mt7663s_mcu_fw_pmctrl(struct mt7615_dev *dev)
 
 	sdio_writel(func, WHLPCR_FW_OWN_REQ_SET, MCR_WHLPCR, NULL);
 
-	ret = readx_poll_timeout(mt7663s_read_pcr, dev, status,
+	ret = readx_poll_timeout(mt76_connac_sdio_read_pcr, &dev->mt76, status,
 				 !(status & WHLPCR_IS_DRIVER_OWN), 2000, 1000000);
 	if (ret < 0) {
 		dev_err(dev->mt76.dev, "Cannot set ownership to device");
@@ -137,8 +137,6 @@ int mt7663s_mcu_init(struct mt7615_dev *dev)
 		.mcu_skb_send_msg = mt7663s_mcu_send_message,
 		.mcu_parse_response = mt7615_mcu_parse_response,
 		.mcu_restart = mt7615_mcu_restart,
-		.mcu_rr = mt7615_mcu_reg_rr,
-		.mcu_wr = mt7615_mcu_reg_wr,
 	};
 	struct mt7615_mcu_ops *mcu_ops;
 	int ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
deleted file mode 100644
index 04f4c89b7499..000000000000
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ /dev/null
@@ -1,334 +0,0 @@
-// SPDX-License-Identifier: ISC
-/* Copyright (C) 2020 MediaTek Inc.
- *
- * Author: Felix Fietkau <nbd@nbd.name>
- *	   Lorenzo Bianconi <lorenzo@kernel.org>
- *	   Sean Wang <sean.wang@mediatek.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/iopoll.h>
-#include <linux/module.h>
-
-#include <linux/mmc/host.h>
-#include <linux/mmc/sdio_ids.h>
-#include <linux/mmc/sdio_func.h>
-
-#include "../trace.h"
-#include "mt7615.h"
-#include "sdio.h"
-#include "mac.h"
-
-static int mt7663s_refill_sched_quota(struct mt76_dev *dev, u32 *data)
-{
-	u32 ple_ac_data_quota[] = {
-		FIELD_GET(TXQ_CNT_L, data[4]), /* VO */
-		FIELD_GET(TXQ_CNT_H, data[3]), /* VI */
-		FIELD_GET(TXQ_CNT_L, data[3]), /* BE */
-		FIELD_GET(TXQ_CNT_H, data[2]), /* BK */
-	};
-	u32 pse_ac_data_quota[] = {
-		FIELD_GET(TXQ_CNT_H, data[1]), /* VO */
-		FIELD_GET(TXQ_CNT_L, data[1]), /* VI */
-		FIELD_GET(TXQ_CNT_H, data[0]), /* BE */
-		FIELD_GET(TXQ_CNT_L, data[0]), /* BK */
-	};
-	u32 pse_mcu_quota = FIELD_GET(TXQ_CNT_L, data[2]);
-	u32 pse_data_quota = 0, ple_data_quota = 0;
-	struct mt76_sdio *sdio = &dev->sdio;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(pse_ac_data_quota); i++) {
-		pse_data_quota += pse_ac_data_quota[i];
-		ple_data_quota += ple_ac_data_quota[i];
-	}
-
-	if (!pse_data_quota && !ple_data_quota && !pse_mcu_quota)
-		return 0;
-
-	sdio->sched.pse_mcu_quota += pse_mcu_quota;
-	sdio->sched.pse_data_quota += pse_data_quota;
-	sdio->sched.ple_data_quota += ple_data_quota;
-
-	return pse_data_quota + ple_data_quota + pse_mcu_quota;
-}
-
-static struct sk_buff *mt7663s_build_rx_skb(void *data, int data_len,
-					    int buf_len)
-{
-	int len = min_t(int, data_len, MT_SKB_HEAD_LEN);
-	struct sk_buff *skb;
-
-	skb = alloc_skb(len, GFP_KERNEL);
-	if (!skb)
-		return NULL;
-
-	skb_put_data(skb, data, len);
-	if (data_len > len) {
-		struct page *page;
-
-		data += len;
-		page = virt_to_head_page(data);
-		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-				page, data - page_address(page),
-				data_len - len, buf_len);
-		get_page(page);
-	}
-
-	return skb;
-}
-
-static int mt7663s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
-				struct mt76s_intr *intr)
-{
-	struct mt76_queue *q = &dev->q_rx[qid];
-	struct mt76_sdio *sdio = &dev->sdio;
-	int len = 0, err, i;
-	struct page *page;
-	u8 *buf;
-
-	for (i = 0; i < intr->rx.num[qid]; i++)
-		len += round_up(intr->rx.len[qid][i] + 4, 4);
-
-	if (!len)
-		return 0;
-
-	if (len > sdio->func->cur_blksize)
-		len = roundup(len, sdio->func->cur_blksize);
-
-	page = __dev_alloc_pages(GFP_KERNEL, get_order(len));
-	if (!page)
-		return -ENOMEM;
-
-	buf = page_address(page);
-
-	err = sdio_readsb(sdio->func, buf, MCR_WRDR(qid), len);
-	if (err < 0) {
-		dev_err(dev->dev, "sdio read data failed:%d\n", err);
-		put_page(page);
-		return err;
-	}
-
-	for (i = 0; i < intr->rx.num[qid]; i++) {
-		int index = (q->head + i) % q->ndesc;
-		struct mt76_queue_entry *e = &q->entry[index];
-
-		len = intr->rx.len[qid][i];
-		e->skb = mt7663s_build_rx_skb(buf, len, round_up(len + 4, 4));
-		if (!e->skb)
-			break;
-
-		buf += round_up(len + 4, 4);
-		if (q->queued + i + 1 == q->ndesc)
-			break;
-	}
-	put_page(page);
-
-	spin_lock_bh(&q->lock);
-	q->head = (q->head + i) % q->ndesc;
-	q->queued += i;
-	spin_unlock_bh(&q->lock);
-
-	return i;
-}
-
-static int mt7663s_rx_handler(struct mt76_dev *dev)
-{
-	struct mt76_sdio *sdio = &dev->sdio;
-	struct mt76s_intr *intr = sdio->intr_data;
-	int nframes = 0, ret;
-
-	ret = sdio_readsb(sdio->func, intr, MCR_WHISR, sizeof(*intr));
-	if (ret < 0)
-		return ret;
-
-	trace_dev_irq(dev, intr->isr, 0);
-
-	if (intr->isr & WHIER_RX0_DONE_INT_EN) {
-		ret = mt7663s_rx_run_queue(dev, 0, intr);
-		if (ret > 0) {
-			mt76_worker_schedule(&sdio->net_worker);
-			nframes += ret;
-		}
-	}
-
-	if (intr->isr & WHIER_RX1_DONE_INT_EN) {
-		ret = mt7663s_rx_run_queue(dev, 1, intr);
-		if (ret > 0) {
-			mt76_worker_schedule(&sdio->net_worker);
-			nframes += ret;
-		}
-	}
-
-	nframes += !!mt7663s_refill_sched_quota(dev, intr->tx.wtqcr);
-
-	return nframes;
-}
-
-static int mt7663s_tx_pick_quota(struct mt76_sdio *sdio, bool mcu, int buf_sz,
-				 int *pse_size, int *ple_size)
-{
-	int pse_sz;
-
-	pse_sz = DIV_ROUND_UP(buf_sz + sdio->sched.deficit, MT_PSE_PAGE_SZ);
-
-	if (mcu) {
-		if (sdio->sched.pse_mcu_quota < *pse_size + pse_sz)
-			return -EBUSY;
-	} else {
-		if (sdio->sched.pse_data_quota < *pse_size + pse_sz ||
-		    sdio->sched.ple_data_quota < *ple_size + 1)
-			return -EBUSY;
-
-		*ple_size = *ple_size + 1;
-	}
-	*pse_size = *pse_size + pse_sz;
-
-	return 0;
-}
-
-static void mt7663s_tx_update_quota(struct mt76_sdio *sdio, bool mcu,
-				    int pse_size, int ple_size)
-{
-	if (mcu) {
-		sdio->sched.pse_mcu_quota -= pse_size;
-	} else {
-		sdio->sched.pse_data_quota -= pse_size;
-		sdio->sched.ple_data_quota -= ple_size;
-	}
-}
-
-static int __mt7663s_xmit_queue(struct mt76_dev *dev, u8 *data, int len)
-{
-	struct mt76_sdio *sdio = &dev->sdio;
-	int err;
-
-	if (len > sdio->func->cur_blksize)
-		len = roundup(len, sdio->func->cur_blksize);
-
-	err = sdio_writesb(sdio->func, MCR_WTDR1, data, len);
-	if (err)
-		dev_err(dev->dev, "sdio write failed: %d\n", err);
-
-	return err;
-}
-
-static int mt7663s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
-{
-	int qid, err, nframes = 0, len = 0, pse_sz = 0, ple_sz = 0;
-	bool mcu = q == dev->q_mcu[MT_MCUQ_WM];
-	struct mt76_sdio *sdio = &dev->sdio;
-	u8 pad;
-
-	qid = mcu ? ARRAY_SIZE(sdio->xmit_buf) - 1 : q->qid;
-	while (q->first != q->head) {
-		struct mt76_queue_entry *e = &q->entry[q->first];
-		struct sk_buff *iter;
-
-		smp_rmb();
-
-		if (!test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state)) {
-			__skb_put_zero(e->skb, 4);
-			err = __mt7663s_xmit_queue(dev, e->skb->data,
-						   e->skb->len);
-			if (err)
-				return err;
-
-			goto next;
-		}
-
-		pad = roundup(e->skb->len, 4) - e->skb->len;
-		if (len + e->skb->len + pad + 4 > MT76S_XMIT_BUF_SZ)
-			break;
-
-		if (mt7663s_tx_pick_quota(sdio, mcu, e->buf_sz, &pse_sz,
-					  &ple_sz))
-			break;
-
-		memcpy(sdio->xmit_buf[qid] + len, e->skb->data,
-		       skb_headlen(e->skb));
-		len += skb_headlen(e->skb);
-		nframes++;
-
-		skb_walk_frags(e->skb, iter) {
-			memcpy(sdio->xmit_buf[qid] + len, iter->data,
-			       iter->len);
-			len += iter->len;
-			nframes++;
-		}
-
-		if (unlikely(pad)) {
-			memset(sdio->xmit_buf[qid] + len, 0, pad);
-			len += pad;
-		}
-next:
-		q->first = (q->first + 1) % q->ndesc;
-		e->done = true;
-	}
-
-	if (nframes) {
-		memset(sdio->xmit_buf[qid] + len, 0, 4);
-		err = __mt7663s_xmit_queue(dev, sdio->xmit_buf[qid], len + 4);
-		if (err)
-			return err;
-	}
-	mt7663s_tx_update_quota(sdio, mcu, pse_sz, ple_sz);
-
-	mt76_worker_schedule(&sdio->status_worker);
-
-	return nframes;
-}
-
-void mt7663s_txrx_worker(struct mt76_worker *w)
-{
-	struct mt76_sdio *sdio = container_of(w, struct mt76_sdio,
-					      txrx_worker);
-	struct mt76_dev *mdev = container_of(sdio, struct mt76_dev, sdio);
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	int i, nframes, ret;
-
-	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
-		queue_work(mdev->wq, &dev->pm.wake_work);
-		return;
-	}
-
-	/* disable interrupt */
-	sdio_claim_host(sdio->func);
-	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
-
-	do {
-		nframes = 0;
-
-		/* tx */
-		for (i = 0; i <= MT_TXQ_PSD; i++) {
-			ret = mt7663s_tx_run_queue(mdev, mdev->phy.q_tx[i]);
-			if (ret > 0)
-				nframes += ret;
-		}
-		ret = mt7663s_tx_run_queue(mdev, mdev->q_mcu[MT_MCUQ_WM]);
-		if (ret > 0)
-			nframes += ret;
-
-		/* rx */
-		ret = mt7663s_rx_handler(mdev);
-		if (ret > 0)
-			nframes += ret;
-	} while (nframes > 0);
-
-	/* enable interrupt */
-	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
-	sdio_release_host(sdio->func);
-
-	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
-}
-
-void mt7663s_sdio_irq(struct sdio_func *func)
-{
-	struct mt7615_dev *dev = sdio_get_drvdata(func);
-	struct mt76_sdio *sdio = &dev->mt76.sdio;
-
-	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mt76.phy.state))
-		return;
-
-	mt76_worker_schedule(&sdio->txrx_worker);
-}
-- 
2.25.1

