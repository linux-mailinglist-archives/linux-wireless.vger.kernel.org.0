Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EBD220D4B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 14:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbgGOMrD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 08:47:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgGOMrC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 08:47:02 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EBB620578;
        Wed, 15 Jul 2020 12:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594817220;
        bh=FPsw0Q9MUIe+SrnNFgMhytC6YI2oUhsquY2gkwH9URM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCBCQJCzz3fK/4c3lxSokK0oEgHfv54cmddVihmYGfLDD+n7RnS3sMYEisWAmTXLo
         zQ2pDVg2kezvCBXzIFrbS9TRs6+OG7tP6U+GwalxM1fVV3psp79ceRKSZSWuEcLl1U
         waD5jRTyCocXuNEtfmqs+3yMvbw7V/TS1wpnjYII=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 6/6] mt76: mt7615: introduce mt7663s support
Date:   Wed, 15 Jul 2020 14:46:31 +0200
Message-Id: <7f6fce0b419012a8acf7f402831a839b4c1a0025.1594815602.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1594815602.git.lorenzo@kernel.org>
References: <cover.1594815602.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce support for mt7663s 802.11ac 2x2:2 chipset to mt7615 driver.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7615/Kconfig |  11 +
 .../wireless/mediatek/mt76/mt7615/Makefile    |   2 +
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  42 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  10 +
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |   1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  10 +
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  12 +
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  | 478 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/sdio.h  | 115 +++++
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  | 161 ++++++
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 271 ++++++++++
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  |   1 +
 12 files changed, 1113 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
index 10a4f1ed9194..f372fb629caf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
@@ -42,3 +42,14 @@ config MT7663U
 	  This adds support for MT7663U 802.11ac 2x2:2 wireless devices.
 
 	  To compile this driver as a module, choose M here.
+
+config MT7663S
+	tristate "MediaTek MT7663S (SDIO) support"
+	select MT76_SDIO
+	select MT7663_USB_SDIO_COMMON
+	depends on MAC80211
+	depends on MMC
+	help
+	  This adds support for MT7663S 802.11ac 2x2:2 wireless devices.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
index a1cdaadb5442..e8fc4a7ae9bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_MT7615_COMMON) += mt7615-common.o
 obj-$(CONFIG_MT7615E) += mt7615e.o
 obj-$(CONFIG_MT7663_USB_SDIO_COMMON) += mt7663-usb-sdio-common.o
 obj-$(CONFIG_MT7663U) += mt7663u.o
+obj-$(CONFIG_MT7663S) += mt7663s.o
 
 CFLAGS_trace.o := -I$(src)
 
@@ -16,3 +17,4 @@ mt7615e-$(CONFIG_MT7622_WMAC) += soc.o
 
 mt7663-usb-sdio-common-y := usb_sdio.o
 mt7663u-y := usb.o usb_mcu.o
+mt7663s-y := sdio.o sdio_mcu.o sdio_txrx.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 11293ea10898..554f8fa4f0b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -146,7 +146,10 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 		mcu_txd->cid = mcu_cmd;
 		break;
 	case MCU_CE_PREFIX:
-		mcu_txd->set_query = MCU_Q_SET;
+		if (cmd & MCU_QUERY_MASK)
+			mcu_txd->set_query = MCU_Q_QUERY;
+		else
+			mcu_txd->set_query = MCU_Q_SET;
 		mcu_txd->cid = mcu_cmd;
 		break;
 	default:
@@ -214,6 +217,14 @@ mt7615_mcu_parse_response(struct mt7615_dev *dev, int cmd,
 		ret = le32_to_cpu(event->status);
 		break;
 	}
+	case MCU_CMD_REG_READ: {
+		struct mt7615_mcu_reg_event *event;
+
+		skb_pull(skb, sizeof(*rxd));
+		event = (struct mt7615_mcu_reg_event *)skb->data;
+		ret = (int)le32_to_cpu(event->val);
+		break;
+	}
 	default:
 		break;
 	}
@@ -3945,3 +3956,32 @@ int mt7615_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_P2P_OPPPS,
 				   &req, sizeof(req), false);
 }
+
+u32 mt7615_mcu_reg_rr(struct mt76_dev *dev, u32 offset)
+{
+	struct {
+		__le32 addr;
+		__le32 val;
+	} __packed req = {
+		.addr = cpu_to_le32(offset),
+	};
+
+	return __mt76_mcu_send_msg(dev, MCU_CMD_REG_READ,
+				   &req, sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt7615_mcu_reg_rr);
+
+void mt7615_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val)
+{
+	struct {
+		__le32 addr;
+		__le32 val;
+	} __packed req = {
+		.addr = cpu_to_le32(offset),
+		.val = cpu_to_le32(val),
+	};
+
+	__mt76_mcu_send_msg(dev, MCU_CMD_REG_WRITE,
+			    &req, sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt7615_mcu_reg_wr);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index e8c7aa5c35ce..7b856e9eee1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -81,6 +81,7 @@ enum {
 	MCU_EVENT_GENERIC = 0x01,
 	MCU_EVENT_ACCESS_REG = 0x02,
 	MCU_EVENT_MT_PATCH_SEM = 0x04,
+	MCU_EVENT_REG_ACCESS = 0x05,
 	MCU_EVENT_SCAN_DONE = 0x0d,
 	MCU_EVENT_ROC = 0x10,
 	MCU_EVENT_BSS_ABSENCE  = 0x11,
@@ -242,6 +243,8 @@ enum {
 #define MCU_CMD_MASK		~(MCU_FW_PREFIX | MCU_UNI_PREFIX |	\
 				  MCU_CE_PREFIX | MCU_QUERY_PREFIX)
 
+#define MCU_QUERY_MASK		BIT(16)
+
 enum {
 	MCU_CMD_TARGET_ADDRESS_LEN_REQ = MCU_FW_PREFIX | 0x01,
 	MCU_CMD_FW_START_REQ = MCU_FW_PREFIX | 0x02,
@@ -429,6 +432,11 @@ struct nt7615_sched_scan_done {
 	__le16 pad;
 } __packed;
 
+struct mt7615_mcu_reg_event {
+	__le32 reg;
+	__le32 val;
+} __packed;
+
 struct mt7615_mcu_bss_event {
 	u8 bss_idx;
 	u8 is_absent;
@@ -581,6 +589,8 @@ enum {
 	MCU_CMD_SET_P2P_OPPPS = MCU_CE_PREFIX | 0x33,
 	MCU_CMD_SCHED_SCAN_ENABLE = MCU_CE_PREFIX | 0x61,
 	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
+	MCU_CMD_REG_WRITE = MCU_CE_PREFIX | 0xc0,
+	MCU_CMD_REG_READ = MCU_CE_PREFIX | MCU_QUERY_MASK | 0xc0,
 };
 
 #define MCU_CMD_ACK		BIT(0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index 461ac6c42271..133f93a6ed1b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -43,6 +43,7 @@ const u32 mt7663e_reg_map[] = {
 	[MT_CSR_BASE]		= 0x07000,
 	[MT_PLE_BASE]		= 0x08000,
 	[MT_PSE_BASE]		= 0x0c000,
+	[MT_PP_BASE]            = 0x0e000,
 	[MT_CFG_BASE]		= 0x20000,
 	[MT_AGG_BASE]		= 0x22000,
 	[MT_TMAC_BASE]		= 0x24000,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 097cd150d879..2964d0dc9736 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -656,6 +656,8 @@ int mt7615_mcu_update_arp_filter(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_bss_conf *info);
 int __mt7663_load_firmware(struct mt7615_dev *dev);
+u32 mt7615_mcu_reg_rr(struct mt76_dev *dev, u32 offset);
+void mt7615_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val);
 
 /* usb */
 int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
@@ -670,4 +672,12 @@ void mt7663_usb_sdio_wtbl_work(struct work_struct *work);
 int mt7663_usb_sdio_register_device(struct mt7615_dev *dev);
 int mt7663u_mcu_init(struct mt7615_dev *dev);
 
+/* sdio */
+u32 mt7663s_read_pcr(struct mt7615_dev *dev);
+int mt7663s_mcu_init(struct mt7615_dev *dev);
+int mt7663s_driver_own(struct mt7615_dev *dev);
+int mt7663s_firmware_own(struct mt7615_dev *dev);
+int mt7663s_kthread_run(void *data);
+void mt7663s_sdio_irq(struct sdio_func *func);
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 8d2c54918e68..8b21c025fd46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -28,6 +28,7 @@ enum mt7615_reg_base {
 	MT_PCIE_REMAP_BASE2,
 	MT_TOP_MISC_BASE,
 	MT_EFUSE_ADDR_BASE,
+	MT_PP_BASE,
 	__MT_BASE_MAX,
 };
 
@@ -152,6 +153,8 @@ enum mt7615_reg_base {
 
 #define MT_PLE(ofs)			((dev)->reg_map[MT_PLE_BASE] + (ofs))
 
+#define MT_PLE_PG_HIF0_GROUP		MT_PLE(0x110)
+#define MT_HIF0_MIN_QUOTA		GENMASK(11, 0)
 #define MT_PLE_FL_Q0_CTRL		MT_PLE(0x1b0)
 #define MT_PLE_FL_Q1_CTRL		MT_PLE(0x1b4)
 #define MT_PLE_FL_Q2_CTRL		MT_PLE(0x1b8)
@@ -161,6 +164,10 @@ enum mt7615_reg_base {
 					       ((n) << 2))
 
 #define MT_PSE(ofs)			((dev)->reg_map[MT_PSE_BASE] + (ofs))
+#define MT_PSE_PG_HIF0_GROUP		MT_PSE(0x110)
+#define MT_HIF0_MIN_QUOTA		GENMASK(11, 0)
+#define MT_PSE_PG_HIF1_GROUP		MT_PSE(0x118)
+#define MT_HIF1_MIN_QUOTA		GENMASK(11, 0)
 #define MT_PSE_QUEUE_EMPTY		MT_PSE(0x0b4)
 #define MT_HIF_0_EMPTY_MASK		BIT(16)
 #define MT_HIF_1_EMPTY_MASK		BIT(17)
@@ -168,6 +175,11 @@ enum mt7615_reg_base {
 #define MT_PSE_PG_INFO			MT_PSE(0x194)
 #define MT_PSE_SRC_CNT			GENMASK(27, 16)
 
+#define MT_PP(ofs)			((dev)->reg_map[MT_PP_BASE] + (ofs))
+#define MT_PP_TXDWCNT			MT_PP(0x0)
+#define MT_PP_TXDWCNT_TX0_ADD_DW_CNT	GENMASK(7, 0)
+#define MT_PP_TXDWCNT_TX1_ADD_DW_CNT	GENMASK(15, 8)
+
 #define MT_WF_PHY_BASE			0x82070000
 #define MT_WF_PHY(ofs)			(MT_WF_PHY_BASE + (ofs))
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
new file mode 100644
index 000000000000..dabce51117b0
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc.
+ *
+ * Author: Felix Fietkau <nbd@nbd.name>
+ *	   Lorenzo Bianconi <lorenzo@kernel.org>
+ *	   Sean Wang <sean.wang@mediatek.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+
+#include <linux/mmc/host.h>
+#include <linux/mmc/sdio_ids.h>
+#include <linux/mmc/sdio_func.h>
+
+#include "mt7615.h"
+#include "sdio.h"
+#include "mac.h"
+
+static const struct sdio_device_id mt7663s_table[] = {
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, 0x7603) },
+	{ }	/* Terminating entry */
+};
+
+static u32 mt7663s_read_whisr(struct mt76_dev *dev)
+{
+	return sdio_readl(dev->sdio.func, MCR_WHISR, NULL);
+}
+
+u32 mt7663s_read_pcr(struct mt7615_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+
+	return sdio_readl(sdio->func, MCR_WHLPCR, NULL);
+}
+
+static u32 mt7663s_read_mailbox(struct mt76_dev *dev, u32 offset)
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
+	err = readx_poll_timeout(mt7663s_read_whisr, dev, status,
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
+static void mt7663s_write_mailbox(struct mt76_dev *dev, u32 offset, u32 val)
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
+	err = readx_poll_timeout(mt7663s_read_whisr, dev, status,
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
+static u32 mt7663s_rr(struct mt76_dev *dev, u32 offset)
+{
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))
+		return dev->mcu_ops->mcu_rr(dev, offset);
+	else
+		return mt7663s_read_mailbox(dev, offset);
+}
+
+static void mt7663s_wr(struct mt76_dev *dev, u32 offset, u32 val)
+{
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))
+		dev->mcu_ops->mcu_wr(dev, offset, val);
+	else
+		mt7663s_write_mailbox(dev, offset, val);
+}
+
+static u32 mt7663s_rmw(struct mt76_dev *dev, u32 offset, u32 mask, u32 val)
+{
+	val |= mt7663s_rr(dev, offset) & ~mask;
+	mt7663s_wr(dev, offset, val);
+
+	return val;
+}
+
+static void mt7663s_write_copy(struct mt76_dev *dev, u32 offset,
+			       const void *data, int len)
+{
+	const u32 *val = data;
+	int i;
+
+	for (i = 0; i < len / sizeof(u32); i++) {
+		mt7663s_wr(dev, offset, val[i]);
+		offset += sizeof(u32);
+	}
+}
+
+static void mt7663s_read_copy(struct mt76_dev *dev, u32 offset,
+			      void *data, int len)
+{
+	u32 *val = data;
+	int i;
+
+	for (i = 0; i < len / sizeof(u32); i++) {
+		val[i] = mt7663s_rr(dev, offset);
+		offset += sizeof(u32);
+	}
+}
+
+static int mt7663s_wr_rp(struct mt76_dev *dev, u32 base,
+			 const struct mt76_reg_pair *data,
+			 int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		mt7663s_wr(dev, data->reg, data->value);
+		data++;
+	}
+
+	return 0;
+}
+
+static int mt7663s_rd_rp(struct mt76_dev *dev, u32 base,
+			 struct mt76_reg_pair *data,
+			 int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		data->value = mt7663s_rr(dev, data->reg);
+		data++;
+	}
+
+	return 0;
+}
+
+static void mt7663s_init_work(struct work_struct *work)
+{
+	struct mt7615_dev *dev;
+
+	dev = container_of(work, struct mt7615_dev, mcu_work);
+	if (mt7663s_mcu_init(dev))
+		return;
+
+	mt7615_mcu_set_eeprom(dev);
+	mt7615_mac_init(dev);
+	mt7615_phy_init(dev);
+	mt7615_mcu_del_wtbl_all(dev);
+	mt7615_check_offload_capability(dev);
+}
+
+static int mt7663s_hw_init(struct mt7615_dev *dev, struct sdio_func *func)
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
+	ret = readx_poll_timeout(mt7663s_read_pcr, dev, status,
+				 status & WHLPCR_IS_DRIVER_OWN, 2000, 1000000);
+	if (ret < 0) {
+		dev_err(dev->mt76.dev, "Cannot get ownership from device");
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
+	ret = sdio_claim_irq(func, mt7663s_sdio_irq);
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
+
+static int mt7663s_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	struct mt76_sdio *sdio = &mdev->sdio;
+	u32 pse, ple;
+	int err;
+
+	err = mt7615_mac_sta_add(mdev, vif, sta);
+	if (err < 0)
+		return err;
+
+	/* init sched data quota */
+	pse = mt76_get_field(dev, MT_PSE_PG_HIF0_GROUP, MT_HIF0_MIN_QUOTA);
+	ple = mt76_get_field(dev, MT_PLE_PG_HIF0_GROUP, MT_HIF0_MIN_QUOTA);
+
+	mutex_lock(&sdio->sched.lock);
+	sdio->sched.pse_data_quota = pse;
+	sdio->sched.ple_data_quota = ple;
+	mutex_unlock(&sdio->sched.lock);
+
+	return 0;
+}
+
+static int mt7663s_probe(struct sdio_func *func,
+			 const struct sdio_device_id *id)
+{
+	static const struct mt76_driver_ops drv_ops = {
+		.txwi_size = MT_USB_TXD_SIZE,
+		.drv_flags = MT_DRV_RX_DMA_HDR | MT_DRV_HW_MGMT_TXQ,
+		.tx_prepare_skb = mt7663_usb_sdio_tx_prepare_skb,
+		.tx_complete_skb = mt7663_usb_sdio_tx_complete_skb,
+		.tx_status_data = mt7663_usb_sdio_tx_status_data,
+		.rx_skb = mt7615_queue_rx_skb,
+		.sta_ps = mt7615_sta_ps,
+		.sta_add = mt7663s_sta_add,
+		.sta_remove = mt7615_mac_sta_remove,
+		.update_survey = mt7615_update_channel,
+	};
+	static const struct mt76_bus_ops mt7663s_ops = {
+		.rr = mt7663s_rr,
+		.rmw = mt7663s_rmw,
+		.wr = mt7663s_wr,
+		.write_copy = mt7663s_write_copy,
+		.read_copy = mt7663s_read_copy,
+		.wr_rp = mt7663s_wr_rp,
+		.rd_rp = mt7663s_rd_rp,
+		.type = MT76_BUS_SDIO,
+	};
+	struct ieee80211_ops *ops;
+	struct mt7615_dev *dev;
+	struct mt76_dev *mdev;
+	int ret;
+
+	ops = devm_kmemdup(&func->dev, &mt7615_ops, sizeof(mt7615_ops),
+			   GFP_KERNEL);
+	if (!ops)
+		return -ENOMEM;
+
+	mdev = mt76_alloc_device(&func->dev, sizeof(*dev), ops, &drv_ops);
+	if (!mdev)
+		return -ENOMEM;
+
+	dev = container_of(mdev, struct mt7615_dev, mt76);
+
+	INIT_WORK(&dev->mcu_work, mt7663s_init_work);
+	dev->reg_map = mt7663_usb_sdio_reg_map;
+	dev->ops = ops;
+	sdio_set_drvdata(func, dev);
+
+	mdev->sdio.tx_kthread = kthread_create(mt7663s_kthread_run, dev,
+					       "mt7663s_tx");
+	if (IS_ERR(mdev->sdio.tx_kthread))
+		return PTR_ERR(mdev->sdio.tx_kthread);
+
+	ret = mt76s_init(mdev, func, &mt7663s_ops);
+	if (ret < 0)
+		goto err_free;
+
+	ret = mt7663s_hw_init(dev, func);
+	if (ret)
+		goto err_free;
+
+	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
+		    (mt76_rr(dev, MT_HW_REV) & 0xff);
+	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+
+	ret = mt76s_alloc_queues(&dev->mt76);
+	if (ret)
+		goto err_deinit;
+
+	ret = mt7663_usb_sdio_register_device(dev);
+	if (ret)
+		goto err_deinit;
+
+	return 0;
+
+err_deinit:
+	mt76s_deinit(&dev->mt76);
+err_free:
+	mt76_free_device(&dev->mt76);
+
+	return ret;
+}
+
+static void mt7663s_remove(struct sdio_func *func)
+{
+	struct mt7615_dev *dev = sdio_get_drvdata(func);
+
+	if (!test_and_clear_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
+		return;
+
+	ieee80211_unregister_hw(dev->mt76.hw);
+	mt76s_deinit(&dev->mt76);
+	mt76_free_device(&dev->mt76);
+}
+
+#ifdef CONFIG_PM
+static int mt7663s_suspend(struct device *dev)
+{
+	struct sdio_func *func = dev_to_sdio_func(dev);
+	struct mt7615_dev *mdev = sdio_get_drvdata(func);
+
+	if (!test_bit(MT76_STATE_SUSPEND, &mdev->mphy.state) &&
+	    mt7615_firmware_offload(mdev)) {
+		int err;
+
+		err = mt7615_mcu_set_hif_suspend(mdev, true);
+		if (err < 0)
+			return err;
+	}
+
+	mt76s_stop_txrx(&mdev->mt76);
+
+	return mt7663s_firmware_own(mdev);
+}
+
+static int mt7663s_resume(struct device *dev)
+{
+	struct sdio_func *func = dev_to_sdio_func(dev);
+	struct mt7615_dev *mdev = sdio_get_drvdata(func);
+	int err;
+
+	err = mt7663s_driver_own(mdev);
+	if (err)
+		return err;
+
+	if (!test_bit(MT76_STATE_SUSPEND, &mdev->mphy.state) &&
+	    mt7615_firmware_offload(mdev))
+		err = mt7615_mcu_set_hif_suspend(mdev, false);
+
+	return err;
+}
+
+static const struct dev_pm_ops mt7663s_pm_ops = {
+	.suspend = mt7663s_suspend,
+	.resume = mt7663s_resume,
+};
+#endif
+
+MODULE_DEVICE_TABLE(sdio, mt7663s_table);
+MODULE_FIRMWARE(MT7663_OFFLOAD_FIRMWARE_N9);
+MODULE_FIRMWARE(MT7663_OFFLOAD_ROM_PATCH);
+MODULE_FIRMWARE(MT7663_FIRMWARE_N9);
+MODULE_FIRMWARE(MT7663_ROM_PATCH);
+
+static struct sdio_driver mt7663s_driver = {
+	.name		= KBUILD_MODNAME,
+	.probe		= mt7663s_probe,
+	.remove		= mt7663s_remove,
+	.id_table	= mt7663s_table,
+#ifdef CONFIG_PM
+	.drv = {
+		.pm = &mt7663s_pm_ops,
+	}
+#endif
+};
+module_sdio_driver(mt7663s_driver);
+
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.h b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.h
new file mode 100644
index 000000000000..05180971de84
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.h
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc.
+ *
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ */
+
+#ifndef __MT76S_H
+#define __MT76S_H
+
+#define MT_PSE_PAGE_SZ			128
+
+#define MCR_WCIR			0x0000
+#define MCR_WHLPCR			0x0004
+#define WHLPCR_FW_OWN_REQ_CLR		BIT(9)
+#define WHLPCR_FW_OWN_REQ_SET		BIT(8)
+#define WHLPCR_IS_DRIVER_OWN		BIT(8)
+#define WHLPCR_INT_EN_CLR		BIT(1)
+#define WHLPCR_INT_EN_SET		BIT(0)
+
+#define MCR_WSDIOCSR			0x0008
+#define MCR_WHCR			0x000C
+#define W_INT_CLR_CTRL			BIT(1)
+#define RECV_MAILBOX_RD_CLR_EN		BIT(2)
+#define MAX_HIF_RX_LEN_NUM		GENMASK(13, 8)
+#define RX_ENHANCE_MODE			BIT(16)
+
+#define MCR_WHISR			0x0010
+#define MCR_WHIER			0x0014
+#define WHIER_D2H_SW_INT		GENMASK(31, 8)
+#define WHIER_FW_OWN_BACK_INT_EN	BIT(7)
+#define WHIER_ABNORMAL_INT_EN		BIT(6)
+#define WHIER_RX1_DONE_INT_EN		BIT(2)
+#define WHIER_RX0_DONE_INT_EN		BIT(1)
+#define WHIER_TX_DONE_INT_EN		BIT(0)
+#define WHIER_DEFAULT			(WHIER_RX0_DONE_INT_EN	| \
+					 WHIER_RX1_DONE_INT_EN	| \
+					 WHIER_TX_DONE_INT_EN	| \
+					 WHIER_ABNORMAL_INT_EN	| \
+					 WHIER_D2H_SW_INT)
+
+#define MCR_WASR			0x0020
+#define MCR_WSICR			0x0024
+#define MCR_WTSR0			0x0028
+#define TQ0_CNT				GENMASK(7, 0)
+#define TQ1_CNT				GENMASK(15, 8)
+#define TQ2_CNT				GENMASK(23, 16)
+#define TQ3_CNT				GENMASK(31, 24)
+
+#define MCR_WTSR1			0x002c
+#define TQ4_CNT				GENMASK(7, 0)
+#define TQ5_CNT				GENMASK(15, 8)
+#define TQ6_CNT				GENMASK(23, 16)
+#define TQ7_CNT				GENMASK(31, 24)
+
+#define MCR_WTDR1			0x0034
+#define MCR_WRDR0			0x0050
+#define MCR_WRDR1			0x0054
+#define MCR_WRDR(p)			(0x0050 + 4 * (p))
+#define MCR_H2DSM0R			0x0070
+#define H2D_SW_INT_READ			BIT(16)
+#define H2D_SW_INT_WRITE		BIT(17)
+
+#define MCR_H2DSM1R			0x0074
+#define MCR_D2HRM0R			0x0078
+#define MCR_D2HRM1R			0x007c
+#define MCR_D2HRM2R			0x0080
+#define MCR_WRPLR			0x0090
+#define RX0_PACKET_LENGTH		GENMASK(15, 0)
+#define RX1_PACKET_LENGTH		GENMASK(31, 16)
+
+#define MCR_WTMDR			0x00b0
+#define MCR_WTMCR			0x00b4
+#define MCR_WTMDPCR0			0x00b8
+#define MCR_WTMDPCR1			0x00bc
+#define MCR_WPLRCR			0x00d4
+#define MCR_WSR				0x00D8
+#define MCR_CLKIOCR			0x0100
+#define MCR_CMDIOCR			0x0104
+#define MCR_DAT0IOCR			0x0108
+#define MCR_DAT1IOCR			0x010C
+#define MCR_DAT2IOCR			0x0110
+#define MCR_DAT3IOCR			0x0114
+#define MCR_CLKDLYCR			0x0118
+#define MCR_CMDDLYCR			0x011C
+#define MCR_ODATDLYCR			0x0120
+#define MCR_IDATDLYCR1			0x0124
+#define MCR_IDATDLYCR2			0x0128
+#define MCR_ILCHCR			0x012C
+#define MCR_WTQCR0			0x0130
+#define MCR_WTQCR1			0x0134
+#define MCR_WTQCR2			0x0138
+#define MCR_WTQCR3			0x013C
+#define MCR_WTQCR4			0x0140
+#define MCR_WTQCR5			0x0144
+#define MCR_WTQCR6			0x0148
+#define MCR_WTQCR7			0x014C
+#define MCR_WTQCR(x)                   (0x130 + 4 * (x))
+#define TXQ_CNT_L			GENMASK(15, 0)
+#define TXQ_CNT_H			GENMASK(31, 16)
+
+#define MCR_SWPCDBGR			0x0154
+
+struct mt76s_intr {
+	u32 isr;
+	struct {
+		u32 wtqcr[8];
+	} tx;
+	struct {
+		u16 num[2];
+		u16 len[2][16];
+	} rx;
+	u32 rec_mb[2];
+} __packed;
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
new file mode 100644
index 000000000000..ea18eec97dc9
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2020 MediaTek Inc.
+ *
+ * Author: Felix Fietkau <nbd@nbd.name>
+ *	   Lorenzo Bianconi <lorenzo@kernel.org>
+ *	   Sean Wang <sean.wang@mediatek.com>
+ */
+#include <linux/kernel.h>
+#include <linux/mmc/sdio_func.h>
+#include <linux/module.h>
+
+#include "mt7615.h"
+#include "mac.h"
+#include "mcu.h"
+#include "regs.h"
+#include "sdio.h"
+
+static int mt7663s_mcu_init_sched(struct mt7615_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+	u32 pse0, ple, pse1, txdwcnt;
+
+	pse0 = mt76_get_field(dev, MT_PSE_PG_HIF0_GROUP, MT_HIF0_MIN_QUOTA);
+	pse1 = mt76_get_field(dev, MT_PSE_PG_HIF1_GROUP, MT_HIF1_MIN_QUOTA);
+	ple = mt76_get_field(dev, MT_PLE_PG_HIF0_GROUP, MT_HIF0_MIN_QUOTA);
+	txdwcnt = mt76_get_field(dev, MT_PP_TXDWCNT,
+				 MT_PP_TXDWCNT_TX1_ADD_DW_CNT);
+
+	mutex_lock(&sdio->sched.lock);
+
+	sdio->sched.pse_data_quota = pse0;
+	sdio->sched.ple_data_quota = ple;
+	sdio->sched.pse_mcu_quota = pse1;
+	sdio->sched.deficit = txdwcnt << 2;
+
+	mutex_unlock(&sdio->sched.lock);
+
+	return 0;
+}
+
+static int
+mt7663s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			 int cmd, bool wait_resp)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	int ret, seq;
+
+	mutex_lock(&mdev->mcu.mutex);
+
+	mt7615_mcu_fill_msg(dev, skb, cmd, &seq);
+	ret = mt76_tx_queue_skb_raw(dev, MT_TXQ_MCU, skb, 0);
+	if (ret)
+		goto out;
+
+	mt76_queue_kick(dev, mdev->q_tx[MT_TXQ_MCU].q);
+	if (wait_resp)
+		ret = mt7615_mcu_wait_response(dev, cmd, seq);
+
+out:
+	mutex_unlock(&mdev->mcu.mutex);
+
+	return ret;
+}
+
+int mt7663s_driver_own(struct mt7615_dev *dev)
+{
+	struct sdio_func *func = dev->mt76.sdio.func;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	u32 status;
+	int ret;
+
+	if (!test_and_clear_bit(MT76_STATE_PM, &mphy->state))
+		goto out;
+
+	sdio_claim_host(func);
+
+	sdio_writel(func, WHLPCR_FW_OWN_REQ_CLR, MCR_WHLPCR, 0);
+
+	ret = readx_poll_timeout(mt7663s_read_pcr, dev, status,
+				 status & WHLPCR_IS_DRIVER_OWN, 2000, 1000000);
+	if (ret < 0) {
+		dev_err(dev->mt76.dev, "Cannot get ownership from device");
+		set_bit(MT76_STATE_PM, &mphy->state);
+		sdio_release_host(func);
+
+		return ret;
+	}
+
+	sdio_release_host(func);
+
+out:
+	dev->pm.last_activity = jiffies;
+
+	return 0;
+}
+
+int mt7663s_firmware_own(struct mt7615_dev *dev)
+{
+	struct sdio_func *func = dev->mt76.sdio.func;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	u32 status;
+	int ret;
+
+	if (test_and_set_bit(MT76_STATE_PM, &mphy->state))
+		return 0;
+
+	sdio_claim_host(func);
+
+	sdio_writel(func, WHLPCR_FW_OWN_REQ_SET, MCR_WHLPCR, 0);
+
+	ret = readx_poll_timeout(mt7663s_read_pcr, dev, status,
+				 !(status & WHLPCR_IS_DRIVER_OWN), 2000, 1000000);
+	if (ret < 0) {
+		dev_err(dev->mt76.dev, "Cannot set ownership to device");
+		clear_bit(MT76_STATE_PM, &mphy->state);
+	}
+
+	sdio_release_host(func);
+
+	return ret;
+}
+
+int mt7663s_mcu_init(struct mt7615_dev *dev)
+{
+	static const struct mt76_mcu_ops mt7663s_mcu_ops = {
+		.headroom = sizeof(struct mt7615_mcu_txd),
+		.tailroom = MT_USB_TAIL_SIZE,
+		.mcu_skb_send_msg = mt7663s_mcu_send_message,
+		.mcu_send_msg = mt7615_mcu_msg_send,
+		.mcu_restart = mt7615_mcu_restart,
+		.mcu_rr = mt7615_mcu_reg_rr,
+		.mcu_wr = mt7615_mcu_reg_wr,
+	};
+	int ret;
+
+	ret = mt7663s_driver_own(dev);
+	if (ret)
+		return ret;
+
+	dev->mt76.mcu_ops = &mt7663s_mcu_ops,
+
+	ret = mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY);
+	if (ret) {
+		mt7615_mcu_restart(&dev->mt76);
+		if (!mt76_poll_msec(dev, MT_CONN_ON_MISC,
+				    MT_TOP_MISC2_FW_N9_RDY, 0, 500))
+			return -EIO;
+	}
+
+	ret = __mt7663_load_firmware(dev);
+	if (ret)
+		return ret;
+
+	ret = mt7663s_mcu_init_sched(dev);
+	if (ret)
+		return ret;
+
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
new file mode 100644
index 000000000000..156666a94eb7
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc.
+ *
+ * Author: Felix Fietkau <nbd@nbd.name>
+ *	   Lorenzo Bianconi <lorenzo@kernel.org>
+ *	   Sean Wang <sean.wang@mediatek.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+
+#include <linux/mmc/host.h>
+#include <linux/mmc/sdio_ids.h>
+#include <linux/mmc/sdio_func.h>
+
+#include "../trace.h"
+#include "mt7615.h"
+#include "sdio.h"
+#include "mac.h"
+
+static void mt7663s_refill_sched_quota(struct mt7615_dev *dev, u32 *data)
+{
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+
+	mutex_lock(&sdio->sched.lock);
+	sdio->sched.pse_data_quota += FIELD_GET(TXQ_CNT_L, data[0]) + /* BK */
+				      FIELD_GET(TXQ_CNT_H, data[0]) + /* BE */
+				      FIELD_GET(TXQ_CNT_L, data[1]) + /* VI */
+				      FIELD_GET(TXQ_CNT_H, data[1]);  /* VO */
+	sdio->sched.ple_data_quota += FIELD_GET(TXQ_CNT_H, data[2]) + /* BK */
+				      FIELD_GET(TXQ_CNT_L, data[3]) + /* BE */
+				      FIELD_GET(TXQ_CNT_H, data[3]) + /* VI */
+				      FIELD_GET(TXQ_CNT_L, data[4]);  /* VO */
+	sdio->sched.pse_mcu_quota += FIELD_GET(TXQ_CNT_L, data[2]);
+	mutex_unlock(&sdio->sched.lock);
+}
+
+static struct sk_buff *mt7663s_build_rx_skb(void *data, int data_len,
+					    int buf_len)
+{
+	int len = min_t(int, data_len, MT_SKB_HEAD_LEN);
+	struct sk_buff *skb;
+
+	skb = alloc_skb(len, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	skb_put_data(skb, data, len);
+	if (data_len > len) {
+		struct page *page;
+
+		data += len;
+		page = virt_to_head_page(data);
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+				page, data - page_address(page),
+				data_len - len, buf_len);
+		get_page(page);
+	}
+
+	return skb;
+}
+
+static int mt7663s_rx_run_queue(struct mt7615_dev *dev, enum mt76_rxq_id qid,
+				struct mt76s_intr *intr)
+{
+	struct mt76_queue *q = &dev->mt76.q_rx[qid];
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+	int len = 0, err, i, order;
+	struct page *page;
+	u8 *buf;
+
+	for (i = 0; i < intr->rx.num[qid]; i++)
+		len += round_up(intr->rx.len[qid][i] + 4, 4);
+
+	if (!len)
+		return 0;
+
+	if (len > sdio->func->cur_blksize)
+		len = roundup(len, sdio->func->cur_blksize);
+
+	order = get_order(len);
+	page = __dev_alloc_pages(GFP_KERNEL, order);
+	if (!page)
+		return -ENOMEM;
+
+	buf = page_address(page);
+
+	err = sdio_readsb(sdio->func, buf, MCR_WRDR(qid), len);
+	if (err < 0) {
+		dev_err(dev->mt76.dev, "sdio read data failed:%d\n", err);
+		__free_pages(page, order);
+		return err;
+	}
+
+	for (i = 0; i < intr->rx.num[qid]; i++) {
+		int index = (q->tail + i) % q->ndesc;
+		struct mt76_queue_entry *e = &q->entry[index];
+
+		len = intr->rx.len[qid][i];
+		e->skb = mt7663s_build_rx_skb(buf, len, round_up(len + 4, 4));
+		if (!e->skb)
+			break;
+
+		buf += round_up(len + 4, 4);
+		if (q->queued + i + 1 == q->ndesc)
+			break;
+	}
+	__free_pages(page, order);
+
+	spin_lock_bh(&q->lock);
+	q->tail = (q->tail + i) % q->ndesc;
+	q->queued += i;
+	spin_unlock_bh(&q->lock);
+
+	return err;
+}
+
+static int mt7663s_tx_update_sched(struct mt7615_dev *dev,
+				   struct mt76_queue_entry *e,
+				   bool mcu)
+{
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct ieee80211_hdr *hdr;
+	int size, ret = -EBUSY;
+
+	size = DIV_ROUND_UP(e->buf_sz + sdio->sched.deficit, MT_PSE_PAGE_SZ);
+
+	if (mcu) {
+		if (!test_bit(MT76_STATE_MCU_RUNNING, &mphy->state))
+			return 0;
+
+		mutex_lock(&sdio->sched.lock);
+		if (sdio->sched.pse_mcu_quota > size) {
+			sdio->sched.pse_mcu_quota -= size;
+			ret = 0;
+		}
+		mutex_unlock(&sdio->sched.lock);
+
+		return ret;
+	}
+
+	hdr = (struct ieee80211_hdr *)(e->skb->data + MT_USB_TXD_SIZE);
+	if (ieee80211_is_ctl(hdr->frame_control))
+		return 0;
+
+	mutex_lock(&sdio->sched.lock);
+	if (sdio->sched.pse_data_quota > size &&
+	    sdio->sched.ple_data_quota > 0) {
+		sdio->sched.pse_data_quota -= size;
+		sdio->sched.ple_data_quota--;
+		ret = 0;
+	}
+	mutex_unlock(&sdio->sched.lock);
+
+	return ret;
+}
+
+static int mt7663s_tx_run_queue(struct mt7615_dev *dev, struct mt76_queue *q)
+{
+	bool mcu = q == dev->mt76.q_tx[MT_TXQ_MCU].q;
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+	int nframes = 0;
+
+	while (q->first != q->tail) {
+		struct mt76_queue_entry *e = &q->entry[q->first];
+		int err, len = e->skb->len;
+
+		if (mt7663s_tx_update_sched(dev, e, mcu))
+			break;
+
+		if (len > sdio->func->cur_blksize)
+			len = roundup(len, sdio->func->cur_blksize);
+
+		/* TODO: skb_walk_frags and then write to SDIO port */
+		err = sdio_writesb(sdio->func, MCR_WTDR1, e->skb->data, len);
+		if (err) {
+			dev_err(dev->mt76.dev, "sdio write failed: %d\n", err);
+			return -EIO;
+		}
+
+		q->first = (q->first + 1) % q->ndesc;
+		nframes++;
+	}
+
+	spin_lock_bh(&q->lock);
+	q->queued += nframes;
+	spin_unlock_bh(&q->lock);
+
+	return nframes;
+}
+
+static int mt7663s_tx_run_queues(struct mt7615_dev *dev)
+{
+	int i, nframes = 0;
+
+	for (i = 0; i < MT_TXQ_MCU_WA; i++) {
+		int ret;
+
+		ret = mt7663s_tx_run_queue(dev, dev->mt76.q_tx[i].q);
+		if (ret < 0)
+			return ret;
+
+		nframes += ret;
+	}
+
+	return nframes;
+}
+
+int mt7663s_kthread_run(void *data)
+{
+	struct mt7615_dev *dev = data;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+
+	while (!kthread_should_stop()) {
+		int ret;
+
+		cond_resched();
+
+		sdio_claim_host(dev->mt76.sdio.func);
+		ret = mt7663s_tx_run_queues(dev);
+		sdio_release_host(dev->mt76.sdio.func);
+
+		if (ret <= 0 || !test_bit(MT76_STATE_RUNNING, &mphy->state)) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule();
+		} else {
+			wake_up_process(dev->mt76.sdio.kthread);
+		}
+	}
+
+	return 0;
+}
+
+void mt7663s_sdio_irq(struct sdio_func *func)
+{
+	struct mt7615_dev *dev = sdio_get_drvdata(func);
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+	struct mt76s_intr intr;
+
+	/* disable interrupt */
+	sdio_writel(func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, 0);
+
+	do {
+		sdio_readsb(func, &intr, MCR_WHISR, sizeof(struct mt76s_intr));
+		trace_dev_irq(&dev->mt76, intr.isr, 0);
+
+		if (!test_bit(MT76_STATE_INITIALIZED, &dev->mt76.phy.state))
+			goto out;
+
+		if (intr.isr & WHIER_RX0_DONE_INT_EN) {
+			mt7663s_rx_run_queue(dev, 0, &intr);
+			wake_up_process(sdio->kthread);
+		}
+
+		if (intr.isr & WHIER_RX1_DONE_INT_EN) {
+			mt7663s_rx_run_queue(dev, 1, &intr);
+			wake_up_process(sdio->kthread);
+		}
+
+		if (intr.isr & WHIER_TX_DONE_INT_EN) {
+			mt7663s_refill_sched_quota(dev, intr.tx.wtqcr);
+			mt7663s_tx_run_queues(dev);
+			wake_up_process(sdio->kthread);
+		}
+	} while (intr.isr);
+out:
+	/* enable interrupt */
+	sdio_writel(func, WHLPCR_INT_EN_SET, MCR_WHLPCR, 0);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index 50009bc5ee8d..6dffdaaa9ad5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -24,6 +24,7 @@ const u32 mt7663_usb_sdio_reg_map[] = {
 	[MT_TOP_MISC_BASE]	= 0x81020000,
 	[MT_PLE_BASE]		= 0x82060000,
 	[MT_PSE_BASE]		= 0x82068000,
+	[MT_PP_BASE]		= 0x8206c000,
 	[MT_WTBL_BASE_ADDR]	= 0x820e0000,
 	[MT_CFG_BASE]		= 0x820f0000,
 	[MT_AGG_BASE]		= 0x820f2000,
-- 
2.26.2

