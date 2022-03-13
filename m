Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A006F4D7557
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Mar 2022 13:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiCMMuu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Mar 2022 08:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiCMMut (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Mar 2022 08:50:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082CF723DF
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 05:49:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 902C6610E7
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 12:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66911C340E8;
        Sun, 13 Mar 2022 12:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647175778;
        bh=uPlkdaFDmROyna6gnmaIPPGc4OvpmHUE7lnzgdbxeoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IDvusFr/7xcPgRqg0QWkCuTf0PEmfD+xDFFhwr3620RNMs98ERGe26myG3soQzAI4
         r2F43zlVz+PjdIxglpNFMAcymVphLW2dbFEDTWWko+l7+lYWo9QfywtBy/VQWJZ/0Q
         DpBOZroAPdNUN+Jb7rEXzXcm7ZuRjhn+Ps5dlm22/ncizSu1Ix+NPW68fDueYK78Yt
         aaUtYhkRVt1CmX5zUlQPFjSh1/TaNe8cSh0owpHwU5wsy/pCxntWp2nhqVgGebkxE6
         fVbeYQqtK+Bxv/Xldj4AP78h4HPQRET45U0xPzkXeKLDstN4t2VVDa7sD6KCDYVaHs
         qilZ8U4GGPr+w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 9/9] mt76: mt7921: add mt7921u driver
Date:   Sun, 13 Mar 2022 13:48:59 +0100
Message-Id: <af6cc4770cfed30a3baba5897c737008e0584719.1647175554.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647175554.git.lorenzo@kernel.org>
References: <cover.1647175554.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce support for MT7921U 802.11ax 2x2:2SS wireless devices.

Tested-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/Kconfig |  11 +
 .../wireless/mediatek/mt76/mt7921/Makefile    |   2 +
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |   1 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   3 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  12 +
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |  50 ++-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   | 305 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/usb_mac.c   | 252 +++++++++++++++
 9 files changed, 635 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/usb.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
index 71154fc2a87c..adff2d7350b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
@@ -24,3 +24,14 @@ config MT7921S
 	  This adds support for MT7921S 802.11ax 2x2:2SS wireless devices.
 
 	  To compile this driver as a module, choose M here.
+
+config MT7921U
+	tristate "MediaTek MT7921U (USB) support"
+	select MT76_USB
+	select MT7921_COMMON
+	depends on MAC80211
+	depends on USB
+	help
+	  This adds support for MT7921U 802.11ax 2x2:2SS wireless devices.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index 1187acedfeda..0a146818c623 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -3,6 +3,7 @@
 obj-$(CONFIG_MT7921_COMMON) += mt7921-common.o
 obj-$(CONFIG_MT7921E) += mt7921e.o
 obj-$(CONFIG_MT7921S) += mt7921s.o
+obj-$(CONFIG_MT7921U) += mt7921u.o
 
 CFLAGS_trace.o := -I$(src)
 
@@ -10,3 +11,4 @@ mt7921-common-y := mac.o mcu.o main.o init.o debugfs.o trace.o
 mt7921-common-$(CONFIG_NL80211_TESTMODE) += testmode.o
 mt7921e-y := pci.o pci_mac.o pci_mcu.o dma.o
 mt7921s-y := sdio.o sdio_mac.o sdio_mcu.o
+mt7921u-y := usb.o usb_mac.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 54f51e7b48a0..ceb22653e4bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -233,7 +233,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
 		dev->pm.ds_enable = true;
 	}
 
-	if (mt76_is_sdio(&dev->mt76))
+	if (!mt76_is_mmio(&dev->mt76))
 		hw->extra_tx_headroom += MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
 
 	ret = mt7921_init_hardware(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index 12e1cf8abe6e..79447e2d0143 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -202,6 +202,7 @@ enum tx_mcu_port_q_idx {
 #define MT_SDIO_TXD_SIZE		(MT_TXD_SIZE + 8 * 4)
 #define MT_SDIO_TAIL_SIZE		8
 #define MT_SDIO_HDR_SIZE		4
+#define MT_USB_TAIL_SIZE		4
 
 #define MT_TXD0_Q_IDX			GENMASK(31, 25)
 #define MT_TXD0_PKT_FMT			GENMASK(24, 23)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index b6e836a4fad7..4fe181bb111b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -264,7 +264,7 @@ static int mt7921_start(struct ieee80211_hw *hw)
 	return err;
 }
 
-static void mt7921_stop(struct ieee80211_hw *hw)
+void mt7921_stop(struct ieee80211_hw *hw)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
@@ -281,6 +281,7 @@ static void mt7921_stop(struct ieee80211_hw *hw)
 	mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, false, false);
 	mt7921_mutex_release(dev);
 }
+EXPORT_SYMBOL_GPL(mt7921_stop);
 
 static int mt7921_add_interface(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index bdcc68b85f35..437dd0969b1a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -30,6 +30,7 @@
 
 #define MT7921_DRV_OWN_RETRY_COUNT	10
 #define MT7921_MCU_INIT_RETRY_COUNT	10
+#define MT7921_WFSYS_INIT_RETRY_COUNT	2
 
 #define MT7921_FIRMWARE_WM		"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
 #define MT7921_ROM_PATCH		"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
@@ -365,6 +366,7 @@ mt7921_skb_add_usb_sdio_hdr(struct mt7921_dev *dev, struct sk_buff *skb,
 	put_unaligned_le32(hdr, skb_push(skb, sizeof(hdr)));
 }
 
+void mt7921_stop(struct ieee80211_hw *hw);
 int mt7921_mac_init(struct mt7921_dev *dev);
 bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask);
 void mt7921_mac_reset_counters(struct mt7921_phy *phy);
@@ -454,4 +456,14 @@ int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 void mt7921_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 				     struct mt76_queue_entry *e);
 bool mt7921_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update);
+
+/* usb */
+#define MT_USB_TYPE_VENDOR	(USB_TYPE_VENDOR | 0x1f)
+#define MT_USB_TYPE_UHW_VENDOR	(USB_TYPE_VENDOR | 0x1e)
+
+int mt7921u_mcu_power_on(struct mt7921_dev *dev);
+int mt7921u_wfsys_reset(struct mt7921_dev *dev);
+int mt7921u_dma_init(struct mt7921_dev *dev);
+int mt7921u_init_reset(struct mt7921_dev *dev);
+int mt7921u_mac_reset(struct mt7921_dev *dev);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index 33578e0dfde3..6712ff60c722 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -353,6 +353,7 @@
 #define MT_WFDMA0_GLO_CFG_RX_DMA_EN	BIT(2)
 #define MT_WFDMA0_GLO_CFG_RX_DMA_BUSY	BIT(3)
 #define MT_WFDMA0_GLO_CFG_TX_WB_DDONE	BIT(6)
+#define MT_WFDMA0_GLO_CFG_FW_DWLD_BYPASS_DMASHDL BIT(9)
 #define MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN	BIT(12)
 #define MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN BIT(15)
 #define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
@@ -377,6 +378,9 @@
 #define MT_WFDMA0_TX_RING16_EXT_CTRL	MT_WFDMA0(0x640)
 #define MT_WFDMA0_TX_RING17_EXT_CTRL	MT_WFDMA0(0x644)
 
+#define MT_WPDMA0_MAX_CNT_MASK		GENMASK(7, 0)
+#define MT_WPDMA0_BASE_PTR_MASK		GENMASK(31, 16)
+
 #define MT_WFDMA0_RX_RING0_EXT_CTRL	MT_WFDMA0(0x680)
 #define MT_WFDMA0_RX_RING1_EXT_CTRL	MT_WFDMA0(0x684)
 #define MT_WFDMA0_RX_RING2_EXT_CTRL	MT_WFDMA0(0x688)
@@ -425,6 +429,10 @@
 #define MT_WFDMA_DUMMY_CR		MT_MCU_WPDMA0(0x120)
 #define MT_WFDMA_NEED_REINIT		BIT(1)
 
+#define MT_CBTOP_RGU(ofs)		(0x70002000 + (ofs))
+#define MT_CBTOP_RGU_WF_SUBSYS_RST	MT_CBTOP_RGU(0x600)
+#define MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH BIT(0)
+
 #define MT_HW_BOUND			0x70010020
 #define MT_HW_CHIPID			0x70010200
 #define MT_HW_REV			0x70010204
@@ -433,12 +441,14 @@
 #define MT_PCIE_MAC(ofs)		(MT_PCIE_MAC_BASE + (ofs))
 #define MT_PCIE_MAC_INT_ENABLE		MT_PCIE_MAC(0x188)
 
-#define MT_DMA_SHDL(ofs)		(0xd6000 + (ofs))
+#define MT_DMA_SHDL(ofs)		(0x7c026000 + (ofs))
 #define MT_DMASHDL_SW_CONTROL		MT_DMA_SHDL(0x004)
 #define MT_DMASHDL_DMASHDL_BYPASS	BIT(28)
 #define MT_DMASHDL_OPTIONAL		MT_DMA_SHDL(0x008)
 #define MT_DMASHDL_PAGE			MT_DMA_SHDL(0x00c)
+#define MT_DMASHDL_GROUP_SEQ_ORDER	BIT(16)
 #define MT_DMASHDL_REFILL		MT_DMA_SHDL(0x010)
+#define MT_DMASHDL_REFILL_MASK		GENMASK(31, 16)
 #define MT_DMASHDL_PKT_MAX_SIZE		MT_DMA_SHDL(0x01c)
 #define MT_DMASHDL_PKT_MAX_SIZE_PLE	GENMASK(11, 0)
 #define MT_DMASHDL_PKT_MAX_SIZE_PSE	GENMASK(27, 16)
@@ -453,6 +463,43 @@
 
 #define MT_DMASHDL_SCHED_SET(_n)	MT_DMA_SHDL(0x070 + ((_n) << 2))
 
+#define MT_WFDMA_HOST_CONFIG		0x7c027030
+#define MT_WFDMA_HOST_CONFIG_USB_RXEVT_EP4_EN	BIT(6)
+
+#define MT_UMAC(ofs)			(0x74000000 + (ofs))
+#define MT_UDMA_TX_QSEL			MT_UMAC(0x008)
+#define MT_FW_DL_EN			BIT(3)
+
+#define MT_UDMA_WLCFG_1			MT_UMAC(0x00c)
+#define MT_WL_RX_AGG_PKT_LMT		GENMASK(7, 0)
+#define MT_WL_TX_TMOUT_LMT		GENMASK(27, 8)
+
+#define MT_UDMA_WLCFG_0			MT_UMAC(0x18)
+#define MT_WL_RX_AGG_TO			GENMASK(7, 0)
+#define MT_WL_RX_AGG_LMT		GENMASK(15, 8)
+#define MT_WL_TX_TMOUT_FUNC_EN		BIT(16)
+#define MT_WL_TX_DPH_CHK_EN		BIT(17)
+#define MT_WL_RX_MPSZ_PAD0		BIT(18)
+#define MT_WL_RX_FLUSH			BIT(19)
+#define MT_TICK_1US_EN			BIT(20)
+#define MT_WL_RX_AGG_EN			BIT(21)
+#define MT_WL_RX_EN			BIT(22)
+#define MT_WL_TX_EN			BIT(23)
+#define MT_WL_RX_BUSY			BIT(30)
+#define MT_WL_TX_BUSY			BIT(31)
+
+#define MT_UDMA_CONN_INFRA_STATUS	MT_UMAC(0xa20)
+#define MT_UDMA_CONN_WFSYS_INIT_DONE	BIT(22)
+#define MT_UDMA_CONN_INFRA_STATUS_SEL	MT_UMAC(0xa24)
+
+#define MT_SSUSB_EPCTL_CSR(ofs)		(0x74011800 + (ofs))
+#define MT_SSUSB_EPCTL_CSR_EP_RST_OPT	MT_SSUSB_EPCTL_CSR(0x090)
+
+#define MT_UWFDMA0(ofs)			(0x7c024000 + (ofs))
+#define MT_UWFDMA0_GLO_CFG		MT_UWFDMA0(0x208)
+#define MT_UWFDMA0_GLO_CFG_EXT0		MT_UWFDMA0(0x2b0)
+#define MT_UWFDMA0_TX_RING_EXT_CTRL(_n)	MT_UWFDMA0(0x600 + ((_n) << 2))
+
 #define MT_CONN_STATUS			0x7c053c10
 #define MT_WIFI_PATCH_DL_STATE		BIT(0)
 
@@ -466,6 +513,7 @@
 #define WFSYS_SW_INIT_DONE		BIT(4)
 
 #define MT_CONN_ON_MISC			0x7c0600f0
+#define MT_TOP_MISC2_FW_PWR_ON		BIT(0)
 #define MT_TOP_MISC2_FW_N9_RDY		GENMASK(1, 0)
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
new file mode 100644
index 000000000000..0f99d059d319
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2022 MediaTek Inc.
+ *
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+
+#include "mt7921.h"
+#include "mcu.h"
+#include "mac.h"
+
+static const struct usb_device_id mt7921u_device_table[] = {
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7961, 0xff, 0xff, 0xff) },
+	{ },
+};
+
+static u32 mt7921u_rr(struct mt76_dev *dev, u32 addr)
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
+
+static void mt7921u_wr(struct mt76_dev *dev, u32 addr, u32 val)
+{
+	mutex_lock(&dev->usb.usb_ctrl_mtx);
+	___mt76u_wr(dev, MT_VEND_WRITE_EXT,
+		    USB_DIR_OUT | MT_USB_TYPE_VENDOR, addr, val);
+	mutex_unlock(&dev->usb.usb_ctrl_mtx);
+}
+
+static u32 mt7921u_rmw(struct mt76_dev *dev, u32 addr,
+		       u32 mask, u32 val)
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
+
+static void mt7921u_copy(struct mt76_dev *dev, u32 offset,
+			 const void *data, int len)
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
+
+int mt7921u_mcu_power_on(struct mt7921_dev *dev)
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
+
+static int
+mt7921u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			 int cmd, int *seq)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	u32 pad, ep;
+	int ret;
+
+	ret = mt7921_mcu_fill_message(mdev, skb, cmd, seq);
+	if (ret)
+		return ret;
+
+	if (cmd != MCU_CMD(FW_SCATTER))
+		ep = MT_EP_OUT_INBAND_CMD;
+	else
+		ep = MT_EP_OUT_AC_BE;
+
+	mt7921_skb_add_usb_sdio_hdr(dev, skb, 0);
+	pad = round_up(skb->len, 4) + 4 - skb->len;
+	__skb_put_zero(skb, pad);
+
+	ret = mt76u_bulk_msg(&dev->mt76, skb->data, skb->len, NULL,
+			     1000, ep);
+	dev_kfree_skb(skb);
+
+	return ret;
+}
+
+static int mt7921u_mcu_init(struct mt7921_dev *dev)
+{
+	static const struct mt76_mcu_ops mcu_ops = {
+		.headroom = MT_SDIO_HDR_SIZE + sizeof(struct mt7921_mcu_txd),
+		.tailroom = MT_USB_TAIL_SIZE,
+		.mcu_skb_send_msg = mt7921u_mcu_send_message,
+		.mcu_parse_response = mt7921_mcu_parse_response,
+		.mcu_restart = mt76_connac_mcu_restart,
+	};
+	int ret;
+
+	dev->mt76.mcu_ops = &mcu_ops;
+
+	mt76_set(dev, MT_UDMA_TX_QSEL, MT_FW_DL_EN);
+	ret = mt7921_run_firmware(dev);
+	if (ret)
+		return ret;
+
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+	mt76_clear(dev, MT_UDMA_TX_QSEL, MT_FW_DL_EN);
+
+	return 0;
+}
+
+static void mt7921u_stop(struct ieee80211_hw *hw)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	mt76u_stop_tx(&dev->mt76);
+	mt7921_stop(hw);
+}
+
+static void mt7921u_cleanup(struct mt7921_dev *dev)
+{
+	clear_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
+	mt7921u_wfsys_reset(dev);
+	mt7921_mcu_exit(dev);
+	mt76u_queues_deinit(&dev->mt76);
+}
+
+static int mt7921u_probe(struct usb_interface *usb_intf,
+			 const struct usb_device_id *id)
+{
+	static const struct mt76_driver_ops drv_ops = {
+		.txwi_size = MT_SDIO_TXD_SIZE,
+		.drv_flags = MT_DRV_RX_DMA_HDR | MT_DRV_HW_MGMT_TXQ,
+		.survey_flags = SURVEY_INFO_TIME_TX |
+				SURVEY_INFO_TIME_RX |
+				SURVEY_INFO_TIME_BSS_RX,
+		.tx_prepare_skb = mt7921_usb_sdio_tx_prepare_skb,
+		.tx_complete_skb = mt7921_usb_sdio_tx_complete_skb,
+		.tx_status_data = mt7921_usb_sdio_tx_status_data,
+		.rx_skb = mt7921_queue_rx_skb,
+		.sta_ps = mt7921_sta_ps,
+		.sta_add = mt7921_mac_sta_add,
+		.sta_assoc = mt7921_mac_sta_assoc,
+		.sta_remove = mt7921_mac_sta_remove,
+		.update_survey = mt7921_update_channel,
+	};
+	static const struct mt7921_hif_ops hif_ops = {
+		.mcu_init = mt7921u_mcu_init,
+		.init_reset = mt7921u_init_reset,
+		.reset = mt7921u_mac_reset,
+	};
+	static struct mt76_bus_ops bus_ops = {
+		.rr = mt7921u_rr,
+		.wr = mt7921u_wr,
+		.rmw = mt7921u_rmw,
+		.read_copy = mt76u_read_copy,
+		.write_copy = mt7921u_copy,
+		.type = MT76_BUS_USB,
+	};
+	struct usb_device *udev = interface_to_usbdev(usb_intf);
+	struct ieee80211_ops *ops;
+	struct ieee80211_hw *hw;
+	struct mt7921_dev *dev;
+	struct mt76_dev *mdev;
+	int ret;
+
+	ops = devm_kmemdup(&usb_intf->dev, &mt7921_ops, sizeof(mt7921_ops),
+			   GFP_KERNEL);
+	if (!ops)
+		return -ENOMEM;
+
+	ops->stop = mt7921u_stop;
+
+	mdev = mt76_alloc_device(&usb_intf->dev, sizeof(*dev), ops, &drv_ops);
+	if (!mdev)
+		return -ENOMEM;
+
+	dev = container_of(mdev, struct mt7921_dev, mt76);
+	dev->hif_ops = &hif_ops;
+
+	udev = usb_get_dev(udev);
+	usb_reset_device(udev);
+
+	usb_set_intfdata(usb_intf, dev);
+
+	ret = __mt76u_init(mdev, usb_intf, &bus_ops);
+	if (ret < 0)
+		goto error;
+
+	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
+		    (mt76_rr(dev, MT_HW_REV) & 0xff);
+	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+
+	if (mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY)) {
+		ret = mt7921u_wfsys_reset(dev);
+		if (ret)
+			goto error;
+	}
+
+	ret = mt7921u_mcu_power_on(dev);
+	if (ret)
+		goto error;
+
+	ret = mt76u_alloc_mcu_queue(&dev->mt76);
+	if (ret)
+		goto error;
+
+	ret = mt76u_alloc_queues(&dev->mt76);
+	if (ret)
+		goto error;
+
+	ret = mt7921u_dma_init(dev);
+	if (ret)
+		return ret;
+
+	hw = mt76_hw(dev);
+	/* check hw sg support in order to enable AMSDU */
+	hw->max_tx_fragments = mdev->usb.sg_en ? MT_HW_TXP_MAX_BUF_NUM : 1;
+
+	ret = mt7921_register_device(dev);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	mt76u_queues_deinit(&dev->mt76);
+
+	usb_set_intfdata(usb_intf, NULL);
+	usb_put_dev(interface_to_usbdev(usb_intf));
+
+	mt76_free_device(&dev->mt76);
+
+	return ret;
+}
+
+static void mt7921u_disconnect(struct usb_interface *usb_intf)
+{
+	struct mt7921_dev *dev = usb_get_intfdata(usb_intf);
+
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
+		return;
+
+	mt76_unregister_device(&dev->mt76);
+	mt7921u_cleanup(dev);
+
+	usb_set_intfdata(usb_intf, NULL);
+	usb_put_dev(interface_to_usbdev(usb_intf));
+
+	mt76_free_device(&dev->mt76);
+}
+
+MODULE_DEVICE_TABLE(usb, mt7921u_device_table);
+MODULE_FIRMWARE(MT7921_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7921_ROM_PATCH);
+
+static struct usb_driver mt7921u_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= mt7921u_device_table,
+	.probe		= mt7921u_probe,
+	.disconnect	= mt7921u_disconnect,
+	.soft_unbind	= 1,
+	.disable_hub_initiated_lpm = 1,
+};
+module_usb_driver(mt7921u_driver);
+
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
new file mode 100644
index 000000000000..175b0240ad9a
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2022 MediaTek Inc.
+ *
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+
+#include "mt7921.h"
+#include "mcu.h"
+#include "mac.h"
+
+static u32 mt7921u_uhw_rr(struct mt76_dev *dev, u32 addr)
+{
+	u32 ret;
+
+	mutex_lock(&dev->usb.usb_ctrl_mtx);
+	ret = ___mt76u_rr(dev, MT_VEND_DEV_MODE,
+			  USB_DIR_IN | MT_USB_TYPE_UHW_VENDOR, addr);
+	mutex_unlock(&dev->usb.usb_ctrl_mtx);
+
+	return ret;
+}
+
+static void mt7921u_uhw_wr(struct mt76_dev *dev, u32 addr, u32 val)
+{
+	mutex_lock(&dev->usb.usb_ctrl_mtx);
+	___mt76u_wr(dev, MT_VEND_WRITE,
+		    USB_DIR_OUT | MT_USB_TYPE_UHW_VENDOR, addr, val);
+	mutex_unlock(&dev->usb.usb_ctrl_mtx);
+}
+
+static void mt7921u_dma_prefetch(struct mt7921_dev *dev)
+{
+	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(0),
+		 MT_WPDMA0_MAX_CNT_MASK, 4);
+	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(0),
+		 MT_WPDMA0_BASE_PTR_MASK, 0x80);
+
+	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(1),
+		 MT_WPDMA0_MAX_CNT_MASK, 4);
+	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(1),
+		 MT_WPDMA0_BASE_PTR_MASK, 0xc0);
+
+	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(2),
+		 MT_WPDMA0_MAX_CNT_MASK, 4);
+	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(2),
+		 MT_WPDMA0_BASE_PTR_MASK, 0x100);
+
+	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(3),
+		 MT_WPDMA0_MAX_CNT_MASK, 4);
+	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(3),
+		 MT_WPDMA0_BASE_PTR_MASK, 0x140);
+
+	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(4),
+		 MT_WPDMA0_MAX_CNT_MASK, 4);
+	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(4),
+		 MT_WPDMA0_BASE_PTR_MASK, 0x180);
+
+	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(16),
+		 MT_WPDMA0_MAX_CNT_MASK, 4);
+	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(16),
+		 MT_WPDMA0_BASE_PTR_MASK, 0x280);
+
+	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(17),
+		 MT_WPDMA0_MAX_CNT_MASK, 4);
+	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(17),
+		 MT_WPDMA0_BASE_PTR_MASK,  0x2c0);
+}
+
+static void mt7921u_wfdma_init(struct mt7921_dev *dev)
+{
+	mt7921u_dma_prefetch(dev);
+
+	mt76_clear(dev, MT_UWFDMA0_GLO_CFG, MT_WFDMA0_GLO_CFG_OMIT_RX_INFO);
+	mt76_set(dev, MT_UWFDMA0_GLO_CFG,
+		 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2 |
+		 MT_WFDMA0_GLO_CFG_FW_DWLD_BYPASS_DMASHDL |
+		 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+		 MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	/* disable dmashdl */
+	mt76_clear(dev, MT_UWFDMA0_GLO_CFG_EXT0,
+		   MT_WFDMA0_CSR_TX_DMASHDL_ENABLE);
+	mt76_set(dev, MT_DMASHDL_SW_CONTROL, MT_DMASHDL_DMASHDL_BYPASS);
+
+	mt76_set(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
+}
+
+static int mt7921u_dma_rx_evt_ep4(struct mt7921_dev *dev)
+{
+	if (!mt76_poll(dev, MT_UWFDMA0_GLO_CFG,
+		       MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 1000))
+		return -ETIMEDOUT;
+
+	mt76_clear(dev, MT_UWFDMA0_GLO_CFG, MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+	mt76_set(dev, MT_WFDMA_HOST_CONFIG,
+		 MT_WFDMA_HOST_CONFIG_USB_RXEVT_EP4_EN);
+	mt76_set(dev, MT_UWFDMA0_GLO_CFG, MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	return 0;
+}
+
+static void mt7921u_epctl_rst_opt(struct mt7921_dev *dev, bool reset)
+{
+	u32 val;
+
+	/* usb endpoint reset opt
+	 * bits[4,9]: out blk ep 4-9
+	 * bits[20,21]: in blk ep 4-5
+	 * bits[22]: in int ep 6
+	 */
+	val = mt7921u_uhw_rr(&dev->mt76, MT_SSUSB_EPCTL_CSR_EP_RST_OPT);
+	if (reset)
+		val |= GENMASK(9, 4) | GENMASK(22, 20);
+	else
+		val &= ~(GENMASK(9, 4) | GENMASK(22, 20));
+	mt7921u_uhw_wr(&dev->mt76, MT_SSUSB_EPCTL_CSR_EP_RST_OPT, val);
+}
+
+int mt7921u_dma_init(struct mt7921_dev *dev)
+{
+	int err;
+
+	mt7921u_wfdma_init(dev);
+
+	mt76_clear(dev, MT_UDMA_WLCFG_0, MT_WL_RX_FLUSH);
+
+	mt76_set(dev, MT_UDMA_WLCFG_0,
+		 MT_WL_RX_EN | MT_WL_TX_EN |
+		 MT_WL_RX_MPSZ_PAD0 | MT_TICK_1US_EN);
+	mt76_clear(dev, MT_UDMA_WLCFG_0,
+		   MT_WL_RX_AGG_TO | MT_WL_RX_AGG_LMT);
+	mt76_clear(dev, MT_UDMA_WLCFG_1, MT_WL_RX_AGG_PKT_LMT);
+
+	err = mt7921u_dma_rx_evt_ep4(dev);
+	if (err)
+		return err;
+
+	mt7921u_epctl_rst_opt(dev, false);
+
+	return 0;
+}
+
+int mt7921u_wfsys_reset(struct mt7921_dev *dev)
+{
+	u32 val;
+	int i;
+
+	mt7921u_epctl_rst_opt(dev, false);
+
+	val = mt7921u_uhw_rr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST);
+	val |= MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH;
+	mt7921u_uhw_wr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST, val);
+
+	usleep_range(10, 20);
+
+	val = mt7921u_uhw_rr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST);
+	val &= ~MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH;
+	mt7921u_uhw_wr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST, val);
+
+	mt7921u_uhw_wr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS_SEL, 0);
+	for (i = 0; i < MT7921_WFSYS_INIT_RETRY_COUNT; i++) {
+		val = mt7921u_uhw_rr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS);
+		if (val & MT_UDMA_CONN_WFSYS_INIT_DONE)
+			break;
+
+		msleep(100);
+	}
+
+	if (i == MT7921_WFSYS_INIT_RETRY_COUNT)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+int mt7921u_init_reset(struct mt7921_dev *dev)
+{
+	set_bit(MT76_RESET, &dev->mphy.state);
+
+	wake_up(&dev->mt76.mcu.wait);
+	mt7921_mcu_exit(dev);
+
+	mt76u_stop_rx(&dev->mt76);
+	mt76u_stop_tx(&dev->mt76);
+
+	mt7921u_wfsys_reset(dev);
+
+	clear_bit(MT76_RESET, &dev->mphy.state);
+
+	return mt76u_resume_rx(&dev->mt76);
+}
+
+int mt7921u_mac_reset(struct mt7921_dev *dev)
+{
+	int err;
+
+	mt76_txq_schedule_all(&dev->mphy);
+	mt76_worker_disable(&dev->mt76.tx_worker);
+
+	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+
+	wake_up(&dev->mt76.mcu.wait);
+	mt7921_mcu_exit(dev);
+
+	mt76u_stop_rx(&dev->mt76);
+	mt76u_stop_tx(&dev->mt76);
+
+	mt7921u_wfsys_reset(dev);
+
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	err = mt76u_resume_rx(&dev->mt76);
+	if (err)
+		goto out;
+
+	err = mt7921u_mcu_power_on(dev);
+	if (err)
+		goto out;
+
+	err = mt7921u_dma_init(dev, false);
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
+}
-- 
2.35.1

