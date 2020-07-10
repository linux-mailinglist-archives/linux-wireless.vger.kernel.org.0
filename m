Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223F921B593
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2020 14:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGJM4x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jul 2020 08:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbgGJM4u (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jul 2020 08:56:50 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17DAE20772;
        Fri, 10 Jul 2020 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594385808;
        bh=qs5i7tZLRTmalWubHewkZVi9GtpErQ319SXkiXORw1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m33Xudlx616DY3GK1sY7vh1gAqivkRQOGEo4qaCVvzhZ7GtLbgP9NPzxh6YSbQHkX
         fQO5mxo96j+uTbbF44lfWGdyFVCNN81c5PwEjKbFtCKhR/7R3IIxN0DdOEUy6i9TWU
         Au1ZrsDVOu8kg7hbN/P/wcudAI7/H14iPIuGjluw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 6/6] mt76: mt7615: introduce mt7663s support
Date:   Fri, 10 Jul 2020 14:56:20 +0200
Message-Id: <747c6f2b823f97953f86e1685959309956d59c88.1594384887.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1594384887.git.lorenzo@kernel.org>
References: <cover.1594384887.git.lorenzo@kernel.org>
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
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  42 +++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  10 +
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |   1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   7 +
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  12 ++
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  | 204 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  | 161 ++++++++++++++
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  |   1 +
 10 files changed, 450 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
index f844b374754d..0f921639d948 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
@@ -42,3 +42,14 @@ config MT7663U
 	  This adds support for MT7663U 802.11ac 2x2:2 wireless devices.
 
 	  To compile this driver as a module, choose M here.
+
+config MT7663S
+	tristate "MediaTek MT7663S (SDIO) support"
+	select MT76_SDIO
+	select MT7663_COMMON
+	depends on MAC80211
+	depends on MMC
+	help
+	  This adds support for MT7663S 802.11ac 2x2:2 wireless devices.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
index 889b6719064a..09a3c834fb16 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_MT7615_COMMON) += mt7615-common.o
 obj-$(CONFIG_MT7615E) += mt7615e.o
 obj-$(CONFIG_MT7663_COMMON) += mt7663-common.o
 obj-$(CONFIG_MT7663U) += mt7663u.o
+obj-$(CONFIG_MT7663S) += mt7663s.o
 
 CFLAGS_trace.o := -I$(src)
 
@@ -16,3 +17,4 @@ mt7615e-$(CONFIG_MT7622_WMAC) += soc.o
 
 mt7663-common-y := usb_sdio.o
 mt7663u-y := usb.o usb_mcu.o
+mt7663s-y := sdio.o sdio_mcu.o
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
index 097cd150d879..0d7690819527 100644
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
@@ -670,4 +672,9 @@ void mt7663_usb_sdio_wtbl_work(struct work_struct *work);
 int mt7663_usb_sdio_register_device(struct mt7615_dev *dev);
 int mt7663u_mcu_init(struct mt7615_dev *dev);
 
+/* sdio */
+int mt7663s_mcu_init(struct mt7615_dev *dev);
+int mt7663s_driver_own(struct mt7615_dev *dev);
+int mt7663s_firmware_own(struct mt7615_dev *dev);
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
index 000000000000..a58c650dddaf
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -0,0 +1,204 @@
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
+#include "mac.h"
+#include "mcu.h"
+#include "regs.h"
+
+static const struct sdio_device_id mt7663s_table[] = {
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, 0x7603) },
+	{ }	/* Terminating entry */
+};
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
+	ret = mt76s_init(mdev, func);
+	if (ret < 0)
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
new file mode 100644
index 000000000000..a61de4df09c3
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
+#include "../sdio.h"
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
+	ret = readx_poll_timeout(mt76s_read_pcr, &dev->mt76, status,
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
+	ret = readx_poll_timeout(mt76s_read_pcr, &dev->mt76, status,
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

