Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED9141E52C
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 01:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350768AbhJAAAS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Sep 2021 20:00:18 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:28959 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350449AbhJAAAM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Sep 2021 20:00:12 -0400
X-UUID: 9f8ccc8f748942dda4f88bf0a3b574e4-20210930
X-UUID: 9f8ccc8f748942dda4f88bf0a3b574e4-20210930
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2025178289; Thu, 30 Sep 2021 16:58:25 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Sep 2021 16:48:49 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Oct 2021 07:48:48 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v3 10/16] mt76: sdio: move common code in mt76_sdio module
Date:   Fri, 1 Oct 2021 07:47:57 +0800
Message-ID: <972627da893a301f7fe247a05456d618d49c27a0.1632961096.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1632961096.git.objelf@gmail.com>
References: <cover.1632961096.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Move sdio common code in mt76_sdio module.
This is a preliminary patch to support mt7921s devices.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  16 +
 .../wireless/mediatek/mt76/mt7615/Makefile    |   2 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   4 -
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  | 279 ++----------------
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  |   6 +-
 drivers/net/wireless/mediatek/mt76/sdio.c     | 265 +++++++++++++++++
 .../mediatek/mt76/{mt7615 => }/sdio.h         |   0
 .../mediatek/mt76/{mt7615 => }/sdio_txrx.c    |  82 +++--
 9 files changed, 343 insertions(+), 313 deletions(-)
 rename drivers/net/wireless/mediatek/mt76/{mt7615 => }/sdio.h (100%)
 rename drivers/net/wireless/mediatek/mt76/{mt7615 => }/sdio_txrx.c (74%)

diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index 94efe3c29053..79ab850a45a2 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -14,7 +14,7 @@ mt76-$(CONFIG_PCI) += pci.o
 mt76-$(CONFIG_NL80211_TESTMODE) += testmode.o
 
 mt76-usb-y := usb.o usb_trace.o
-mt76-sdio-y := sdio.o
+mt76-sdio-y := sdio.o sdio_txrx.o
 
 CFLAGS_trace.o := -I$(src)
 CFLAGS_usb_trace.o := -I$(src)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 274f1d2466e4..eaf6b588cf84 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1246,6 +1246,22 @@ int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
 	       const struct mt76_bus_ops *bus_ops);
 int mt76s_alloc_queues(struct mt76_dev *dev);
 void mt76s_deinit(struct mt76_dev *dev);
+void mt76s_sdio_irq(struct sdio_func *func);
+void mt76s_txrx_worker(struct mt76_sdio *sdio);
+int mt76s_hw_init(struct mt76_dev *dev, struct sdio_func *func);
+u32 mt76s_rr(struct mt76_dev *dev, u32 offset);
+void mt76s_wr(struct mt76_dev *dev, u32 offset, u32 val);
+u32 mt76s_rmw(struct mt76_dev *dev, u32 offset, u32 mask, u32 val);
+u32 mt76s_read_pcr(struct mt76_dev *dev);
+void mt76s_write_copy(struct mt76_dev *dev, u32 offset,
+		      const void *data, int len);
+void mt76s_read_copy(struct mt76_dev *dev, u32 offset,
+		     void *data, int len);
+int mt76s_wr_rp(struct mt76_dev *dev, u32 base,
+		const struct mt76_reg_pair *data,
+		int len);
+int mt76s_rd_rp(struct mt76_dev *dev, u32 base,
+		struct mt76_reg_pair *data, int len);
 
 struct sk_buff *
 mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
index 83f9861ff522..2b97b9dde477 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
@@ -17,4 +17,4 @@ mt7615e-$(CONFIG_MT7622_WMAC) += soc.o
 
 mt7663-usb-sdio-common-y := usb_sdio.o
 mt7663u-y := usb.o usb_mcu.o
-mt7663s-y := sdio.o sdio_mcu.o sdio_txrx.o
+mt7663s-y := sdio.o sdio_mcu.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 437f14f06e63..77bd59813d47 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -569,10 +569,6 @@ int mt7663_usb_sdio_register_device(struct mt7615_dev *dev);
 int mt7663u_mcu_init(struct mt7615_dev *dev);
 
 /* sdio */
-u32 mt7663s_read_pcr(struct mt7615_dev *dev);
 int mt7663s_mcu_init(struct mt7615_dev *dev);
-void mt7663s_txrx_worker(struct mt76_worker *w);
-void mt7663s_rx_work(struct work_struct *work);
-void mt7663s_sdio_irq(struct sdio_func *func);
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index fb0f8f34b8f2..f47e25f6dedb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -14,8 +14,8 @@
 #include <linux/mmc/sdio_ids.h>
 #include <linux/mmc/sdio_func.h>
 
+#include "../sdio.h"
 #include "mt7615.h"
-#include "sdio.h"
 #include "mac.h"
 #include "mcu.h"
 
@@ -24,200 +24,19 @@ static const struct sdio_device_id mt7663s_table[] = {
 	{ }	/* Terminating entry */
 };
 
-static u32 mt7663s_read_whisr(struct mt76_dev *dev)
+static void mt7663s_txrx_worker(struct mt76_worker *w)
 {
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
+	struct mt76_sdio *sdio = container_of(w, struct mt76_sdio,
+					      txrx_worker);
+	struct mt76_dev *mdev = container_of(sdio, struct mt76_dev, sdio);
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 
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
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
+		queue_work(mdev->wq, &dev->pm.wake_work);
+		return;
 	}
-
-	return 0;
+	mt76s_txrx_worker(sdio);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
 }
 
 static void mt7663s_init_work(struct work_struct *work)
@@ -231,66 +50,6 @@ static void mt7663s_init_work(struct work_struct *work)
 	mt7615_init_work(dev);
 }
 
-static int mt7663s_hw_init(struct mt7615_dev *dev, struct sdio_func *func)
-{
-	u32 status, ctrl;
-	int ret;
-
-	sdio_claim_host(func);
-
-	ret = sdio_enable_func(func);
-	if (ret < 0)
-		goto release;
-
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
-	}
-
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
-
-	ret = sdio_claim_irq(func, mt7663s_sdio_irq);
-	if (ret < 0)
-		goto disable_func;
-
-	sdio_release_host(func);
-
-	return 0;
-
-disable_func:
-	sdio_disable_func(func);
-release:
-	sdio_release_host(func);
-
-	return ret;
-}
-
 static int mt7663s_probe(struct sdio_func *func,
 			 const struct sdio_device_id *id)
 {
@@ -307,13 +66,13 @@ static int mt7663s_probe(struct sdio_func *func,
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
+		.rr = mt76s_rr,
+		.rmw = mt76s_rmw,
+		.wr = mt76s_wr,
+		.write_copy = mt76s_write_copy,
+		.read_copy = mt76s_read_copy,
+		.wr_rp = mt76s_wr_rp,
+		.rd_rp = mt76s_rd_rp,
 		.type = MT76_BUS_SDIO,
 	};
 	struct ieee80211_ops *ops;
@@ -341,7 +100,7 @@ static int mt7663s_probe(struct sdio_func *func,
 	if (ret < 0)
 		goto error;
 
-	ret = mt7663s_hw_init(dev, func);
+	ret = mt76s_hw_init(mdev, func);
 	if (ret)
 		goto error;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index 517419bb7772..f76986c807ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -10,11 +10,11 @@
 #include <linux/module.h>
 #include <linux/iopoll.h>
 
+#include "../sdio.h"
 #include "mt7615.h"
 #include "mac.h"
 #include "mcu.h"
 #include "regs.h"
-#include "sdio.h"
 
 static int mt7663s_mcu_init_sched(struct mt7615_dev *dev)
 {
@@ -63,7 +63,7 @@ static int __mt7663s_mcu_drv_pmctrl(struct mt7615_dev *dev)
 
 	sdio_writel(func, WHLPCR_FW_OWN_REQ_CLR, MCR_WHLPCR, NULL);
 
-	ret = readx_poll_timeout(mt7663s_read_pcr, dev, status,
+	ret = readx_poll_timeout(mt76s_read_pcr, &dev->mt76, status,
 				 status & WHLPCR_IS_DRIVER_OWN, 2000, 1000000);
 	if (ret < 0) {
 		dev_err(dev->mt76.dev, "Cannot get ownership from device");
@@ -111,7 +111,7 @@ static int mt7663s_mcu_fw_pmctrl(struct mt7615_dev *dev)
 
 	sdio_writel(func, WHLPCR_FW_OWN_REQ_SET, MCR_WHLPCR, NULL);
 
-	ret = readx_poll_timeout(mt7663s_read_pcr, dev, status,
+	ret = readx_poll_timeout(mt76s_read_pcr, &dev->mt76, status,
 				 !(status & WHLPCR_IS_DRIVER_OWN), 2000, 1000000);
 	if (ret < 0) {
 		dev_err(dev->mt76.dev, "Cannot set ownership to device");
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 4abf432750c6..82fb4c110b90 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -16,6 +16,271 @@
 #include <linux/kthread.h>
 
 #include "mt76.h"
+#include "sdio.h"
+
+static u32 mt76s_read_whisr(struct mt76_dev *dev)
+{
+	return sdio_readl(dev->sdio.func, MCR_WHISR, NULL);
+}
+
+u32 mt76s_read_pcr(struct mt76_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+
+	return sdio_readl(sdio->func, MCR_WHLPCR, NULL);
+}
+EXPORT_SYMBOL_GPL(mt76s_read_pcr);
+
+static u32 mt76s_read_mailbox(struct mt76_dev *dev, u32 offset)
+{
+	struct sdio_func *func = dev->sdio.func;
+	u32 val = ~0, status;
+	int err;
+
+	sdio_claim_host(func);
+
+	sdio_writel(func, offset, MCR_H2DSM0R, &err);
+	if (err < 0) {
+		dev_err(dev->dev, "failed setting address [err=%d]\n", err);
+		goto out;
+	}
+
+	sdio_writel(func, H2D_SW_INT_READ, MCR_WSICR, &err);
+	if (err < 0) {
+		dev_err(dev->dev, "failed setting read mode [err=%d]\n", err);
+		goto out;
+	}
+
+	err = readx_poll_timeout(mt76s_read_whisr, dev, status,
+				 status & H2D_SW_INT_READ, 0, 1000000);
+	if (err < 0) {
+		dev_err(dev->dev, "query whisr timeout\n");
+		goto out;
+	}
+
+	sdio_writel(func, H2D_SW_INT_READ, MCR_WHISR, &err);
+	if (err < 0) {
+		dev_err(dev->dev, "failed setting read mode [err=%d]\n", err);
+		goto out;
+	}
+
+	val = sdio_readl(func, MCR_H2DSM0R, &err);
+	if (err < 0) {
+		dev_err(dev->dev, "failed reading h2dsm0r [err=%d]\n", err);
+		goto out;
+	}
+
+	if (val != offset) {
+		dev_err(dev->dev, "register mismatch\n");
+		val = ~0;
+		goto out;
+	}
+
+	val = sdio_readl(func, MCR_D2HRM1R, &err);
+	if (err < 0)
+		dev_err(dev->dev, "failed reading d2hrm1r [err=%d]\n", err);
+
+out:
+	sdio_release_host(func);
+
+	return val;
+}
+
+static void mt76s_write_mailbox(struct mt76_dev *dev, u32 offset, u32 val)
+{
+	struct sdio_func *func = dev->sdio.func;
+	u32 status;
+	int err;
+
+	sdio_claim_host(func);
+
+	sdio_writel(func, offset, MCR_H2DSM0R, &err);
+	if (err < 0) {
+		dev_err(dev->dev, "failed setting address [err=%d]\n", err);
+		goto out;
+	}
+
+	sdio_writel(func, val, MCR_H2DSM1R, &err);
+	if (err < 0) {
+		dev_err(dev->dev,
+			"failed setting write value [err=%d]\n", err);
+		goto out;
+	}
+
+	sdio_writel(func, H2D_SW_INT_WRITE, MCR_WSICR, &err);
+	if (err < 0) {
+		dev_err(dev->dev, "failed setting write mode [err=%d]\n", err);
+		goto out;
+	}
+
+	err = readx_poll_timeout(mt76s_read_whisr, dev, status,
+				 status & H2D_SW_INT_WRITE, 0, 1000000);
+	if (err < 0) {
+		dev_err(dev->dev, "query whisr timeout\n");
+		goto out;
+	}
+
+	sdio_writel(func, H2D_SW_INT_WRITE, MCR_WHISR, &err);
+	if (err < 0) {
+		dev_err(dev->dev, "failed setting write mode [err=%d]\n", err);
+		goto out;
+	}
+
+	val = sdio_readl(func, MCR_H2DSM0R, &err);
+	if (err < 0) {
+		dev_err(dev->dev, "failed reading h2dsm0r [err=%d]\n", err);
+		goto out;
+	}
+
+	if (val != offset)
+		dev_err(dev->dev, "register mismatch\n");
+
+out:
+	sdio_release_host(func);
+}
+
+u32 mt76s_rr(struct mt76_dev *dev, u32 offset)
+{
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))
+		return dev->mcu_ops->mcu_rr(dev, offset);
+	else
+		return mt76s_read_mailbox(dev, offset);
+}
+EXPORT_SYMBOL_GPL(mt76s_rr);
+
+void mt76s_wr(struct mt76_dev *dev, u32 offset, u32 val)
+{
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))
+		dev->mcu_ops->mcu_wr(dev, offset, val);
+	else
+		mt76s_write_mailbox(dev, offset, val);
+}
+EXPORT_SYMBOL_GPL(mt76s_wr);
+
+u32 mt76s_rmw(struct mt76_dev *dev, u32 offset, u32 mask, u32 val)
+{
+	val |= mt76s_rr(dev, offset) & ~mask;
+	mt76s_wr(dev, offset, val);
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(mt76s_rmw);
+
+void mt76s_write_copy(struct mt76_dev *dev, u32 offset,
+		      const void *data, int len)
+{
+	const u32 *val = data;
+	int i;
+
+	for (i = 0; i < len / sizeof(u32); i++) {
+		mt76s_wr(dev, offset, val[i]);
+		offset += sizeof(u32);
+	}
+}
+EXPORT_SYMBOL_GPL(mt76s_write_copy);
+
+void mt76s_read_copy(struct mt76_dev *dev, u32 offset,
+		     void *data, int len)
+{
+	u32 *val = data;
+	int i;
+
+	for (i = 0; i < len / sizeof(u32); i++) {
+		val[i] = mt76s_rr(dev, offset);
+		offset += sizeof(u32);
+	}
+}
+EXPORT_SYMBOL_GPL(mt76s_read_copy);
+
+int mt76s_wr_rp(struct mt76_dev *dev, u32 base,
+		const struct mt76_reg_pair *data,
+		int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		mt76s_wr(dev, data->reg, data->value);
+		data++;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76s_wr_rp);
+
+int mt76s_rd_rp(struct mt76_dev *dev, u32 base,
+		struct mt76_reg_pair *data, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		data->value = mt76s_rr(dev, data->reg);
+		data++;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76s_rd_rp);
+
+int mt76s_hw_init(struct mt76_dev *dev, struct sdio_func *func)
+{
+	u32 status, ctrl;
+	int ret;
+
+	sdio_claim_host(func);
+
+	ret = sdio_enable_func(func);
+	if (ret < 0)
+		goto release;
+
+	/* Get ownership from the device */
+	sdio_writel(func, WHLPCR_INT_EN_CLR | WHLPCR_FW_OWN_REQ_CLR,
+		    MCR_WHLPCR, &ret);
+	if (ret < 0)
+		goto disable_func;
+
+	ret = readx_poll_timeout(mt76s_read_pcr, dev, status,
+				 status & WHLPCR_IS_DRIVER_OWN, 2000, 1000000);
+	if (ret < 0) {
+		dev_err(dev->dev, "Cannot get ownership from device");
+		goto disable_func;
+	}
+
+	ret = sdio_set_block_size(func, 512);
+	if (ret < 0)
+		goto disable_func;
+
+	/* Enable interrupt */
+	sdio_writel(func, WHLPCR_INT_EN_SET, MCR_WHLPCR, &ret);
+	if (ret < 0)
+		goto disable_func;
+
+	ctrl = WHIER_RX0_DONE_INT_EN | WHIER_TX_DONE_INT_EN;
+	sdio_writel(func, ctrl, MCR_WHIER, &ret);
+	if (ret < 0)
+		goto disable_func;
+
+	/* set WHISR as read clear and Rx aggregation number as 16 */
+	ctrl = FIELD_PREP(MAX_HIF_RX_LEN_NUM, 16);
+	sdio_writel(func, ctrl, MCR_WHCR, &ret);
+	if (ret < 0)
+		goto disable_func;
+
+	ret = sdio_claim_irq(func, mt76s_sdio_irq);
+	if (ret < 0)
+		goto disable_func;
+
+	sdio_release_host(func);
+
+	return 0;
+
+disable_func:
+	sdio_disable_func(func);
+release:
+	sdio_release_host(func);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt76s_hw_init);
 
 static int
 mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.h b/drivers/net/wireless/mediatek/mt76/sdio.h
similarity index 100%
rename from drivers/net/wireless/mediatek/mt76/mt7615/sdio.h
rename to drivers/net/wireless/mediatek/mt76/sdio.h
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
similarity index 74%
rename from drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
rename to drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index 04f4c89b7499..ceb3dc0613d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -14,12 +14,11 @@
 #include <linux/mmc/sdio_ids.h>
 #include <linux/mmc/sdio_func.h>
 
-#include "../trace.h"
-#include "mt7615.h"
+#include "trace.h"
 #include "sdio.h"
-#include "mac.h"
+#include "mt76.h"
 
-static int mt7663s_refill_sched_quota(struct mt76_dev *dev, u32 *data)
+static int mt76s_refill_sched_quota(struct mt76_dev *dev, u32 *data)
 {
 	u32 ple_ac_data_quota[] = {
 		FIELD_GET(TXQ_CNT_L, data[4]), /* VO */
@@ -53,8 +52,8 @@ static int mt7663s_refill_sched_quota(struct mt76_dev *dev, u32 *data)
 	return pse_data_quota + ple_data_quota + pse_mcu_quota;
 }
 
-static struct sk_buff *mt7663s_build_rx_skb(void *data, int data_len,
-					    int buf_len)
+static struct sk_buff *
+mt76s_build_rx_skb(void *data, int data_len, int buf_len)
 {
 	int len = min_t(int, data_len, MT_SKB_HEAD_LEN);
 	struct sk_buff *skb;
@@ -78,8 +77,9 @@ static struct sk_buff *mt7663s_build_rx_skb(void *data, int data_len,
 	return skb;
 }
 
-static int mt7663s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
-				struct mt76s_intr *intr)
+static int
+mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
+		   struct mt76s_intr *intr)
 {
 	struct mt76_queue *q = &dev->q_rx[qid];
 	struct mt76_sdio *sdio = &dev->sdio;
@@ -114,7 +114,7 @@ static int mt7663s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 		struct mt76_queue_entry *e = &q->entry[index];
 
 		len = intr->rx.len[qid][i];
-		e->skb = mt7663s_build_rx_skb(buf, len, round_up(len + 4, 4));
+		e->skb = mt76s_build_rx_skb(buf, len, round_up(len + 4, 4));
 		if (!e->skb)
 			break;
 
@@ -132,7 +132,7 @@ static int mt7663s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 	return i;
 }
 
-static int mt7663s_rx_handler(struct mt76_dev *dev)
+static int mt76s_rx_handler(struct mt76_dev *dev)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
 	struct mt76s_intr *intr = sdio->intr_data;
@@ -145,7 +145,7 @@ static int mt7663s_rx_handler(struct mt76_dev *dev)
 	trace_dev_irq(dev, intr->isr, 0);
 
 	if (intr->isr & WHIER_RX0_DONE_INT_EN) {
-		ret = mt7663s_rx_run_queue(dev, 0, intr);
+		ret = mt76s_rx_run_queue(dev, 0, intr);
 		if (ret > 0) {
 			mt76_worker_schedule(&sdio->net_worker);
 			nframes += ret;
@@ -153,20 +153,21 @@ static int mt7663s_rx_handler(struct mt76_dev *dev)
 	}
 
 	if (intr->isr & WHIER_RX1_DONE_INT_EN) {
-		ret = mt7663s_rx_run_queue(dev, 1, intr);
+		ret = mt76s_rx_run_queue(dev, 1, intr);
 		if (ret > 0) {
 			mt76_worker_schedule(&sdio->net_worker);
 			nframes += ret;
 		}
 	}
 
-	nframes += !!mt7663s_refill_sched_quota(dev, intr->tx.wtqcr);
+	nframes += !!mt76s_refill_sched_quota(dev, intr->tx.wtqcr);
 
 	return nframes;
 }
 
-static int mt7663s_tx_pick_quota(struct mt76_sdio *sdio, bool mcu, int buf_sz,
-				 int *pse_size, int *ple_size)
+static int
+mt76s_tx_pick_quota(struct mt76_sdio *sdio, bool mcu, int buf_sz,
+		    int *pse_size, int *ple_size)
 {
 	int pse_sz;
 
@@ -187,8 +188,9 @@ static int mt7663s_tx_pick_quota(struct mt76_sdio *sdio, bool mcu, int buf_sz,
 	return 0;
 }
 
-static void mt7663s_tx_update_quota(struct mt76_sdio *sdio, bool mcu,
-				    int pse_size, int ple_size)
+static void
+mt76s_tx_update_quota(struct mt76_sdio *sdio, bool mcu, int pse_size,
+		      int ple_size)
 {
 	if (mcu) {
 		sdio->sched.pse_mcu_quota -= pse_size;
@@ -198,7 +200,7 @@ static void mt7663s_tx_update_quota(struct mt76_sdio *sdio, bool mcu,
 	}
 }
 
-static int __mt7663s_xmit_queue(struct mt76_dev *dev, u8 *data, int len)
+static int __mt76s_xmit_queue(struct mt76_dev *dev, u8 *data, int len)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
 	int err;
@@ -213,7 +215,7 @@ static int __mt7663s_xmit_queue(struct mt76_dev *dev, u8 *data, int len)
 	return err;
 }
 
-static int mt7663s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
+static int mt76s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	int qid, err, nframes = 0, len = 0, pse_sz = 0, ple_sz = 0;
 	bool mcu = q == dev->q_mcu[MT_MCUQ_WM];
@@ -229,8 +231,8 @@ static int mt7663s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 
 		if (!test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state)) {
 			__skb_put_zero(e->skb, 4);
-			err = __mt7663s_xmit_queue(dev, e->skb->data,
-						   e->skb->len);
+			err = __mt76s_xmit_queue(dev, e->skb->data,
+						 e->skb->len);
 			if (err)
 				return err;
 
@@ -241,8 +243,8 @@ static int mt7663s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 		if (len + e->skb->len + pad + 4 > MT76S_XMIT_BUF_SZ)
 			break;
 
-		if (mt7663s_tx_pick_quota(sdio, mcu, e->buf_sz, &pse_sz,
-					  &ple_sz))
+		if (mt76s_tx_pick_quota(sdio, mcu, e->buf_sz, &pse_sz,
+					&ple_sz))
 			break;
 
 		memcpy(sdio->xmit_buf[qid] + len, e->skb->data,
@@ -268,30 +270,22 @@ static int mt7663s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 
 	if (nframes) {
 		memset(sdio->xmit_buf[qid] + len, 0, 4);
-		err = __mt7663s_xmit_queue(dev, sdio->xmit_buf[qid], len + 4);
+		err = __mt76s_xmit_queue(dev, sdio->xmit_buf[qid], len + 4);
 		if (err)
 			return err;
 	}
-	mt7663s_tx_update_quota(sdio, mcu, pse_sz, ple_sz);
+	mt76s_tx_update_quota(sdio, mcu, pse_sz, ple_sz);
 
 	mt76_worker_schedule(&sdio->status_worker);
 
 	return nframes;
 }
 
-void mt7663s_txrx_worker(struct mt76_worker *w)
+void mt76s_txrx_worker(struct mt76_sdio *sdio)
 {
-	struct mt76_sdio *sdio = container_of(w, struct mt76_sdio,
-					      txrx_worker);
-	struct mt76_dev *mdev = container_of(sdio, struct mt76_dev, sdio);
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
 	int i, nframes, ret;
 
-	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
-		queue_work(mdev->wq, &dev->pm.wake_work);
-		return;
-	}
-
 	/* disable interrupt */
 	sdio_claim_host(sdio->func);
 	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
@@ -301,16 +295,16 @@ void mt7663s_txrx_worker(struct mt76_worker *w)
 
 		/* tx */
 		for (i = 0; i <= MT_TXQ_PSD; i++) {
-			ret = mt7663s_tx_run_queue(mdev, mdev->phy.q_tx[i]);
+			ret = mt76s_tx_run_queue(dev, dev->phy.q_tx[i]);
 			if (ret > 0)
 				nframes += ret;
 		}
-		ret = mt7663s_tx_run_queue(mdev, mdev->q_mcu[MT_MCUQ_WM]);
+		ret = mt76s_tx_run_queue(dev, dev->q_mcu[MT_MCUQ_WM]);
 		if (ret > 0)
 			nframes += ret;
 
 		/* rx */
-		ret = mt7663s_rx_handler(mdev);
+		ret = mt76s_rx_handler(dev);
 		if (ret > 0)
 			nframes += ret;
 	} while (nframes > 0);
@@ -318,17 +312,17 @@ void mt7663s_txrx_worker(struct mt76_worker *w)
 	/* enable interrupt */
 	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
 	sdio_release_host(sdio->func);
-
-	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
 }
+EXPORT_SYMBOL_GPL(mt76s_txrx_worker);
 
-void mt7663s_sdio_irq(struct sdio_func *func)
+void mt76s_sdio_irq(struct sdio_func *func)
 {
-	struct mt7615_dev *dev = sdio_get_drvdata(func);
-	struct mt76_sdio *sdio = &dev->mt76.sdio;
+	struct mt76_dev *dev = sdio_get_drvdata(func);
+	struct mt76_sdio *sdio = &dev->sdio;
 
-	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mt76.phy.state))
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->phy.state))
 		return;
 
 	mt76_worker_schedule(&sdio->txrx_worker);
 }
+EXPORT_SYMBOL_GPL(mt76s_sdio_irq);
-- 
2.25.1

