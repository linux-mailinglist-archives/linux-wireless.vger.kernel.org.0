Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFA21A0A62
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2020 11:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgDGJqp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Apr 2020 05:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbgDGJqo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Apr 2020 05:46:44 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 040362074B;
        Tue,  7 Apr 2020 09:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586252803;
        bh=qjSH8nQ7V4DnHaFujgc7w9mAoztBGYd2TAuvajQIc4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hb7EWYm01ntQNlcya3QyBAMF/Luo7voD1lQEfqU1qqAAvFV/gQpxl0NJrkuP0rdvn
         HZH/tQ9B9KQvaPfUc2z7Er6wgvUgEk5ZbqJtMzUDra+0CVUT1MVSWO3Ps7XF+jWHeK
         qeO7hTrdqoKeveq0axoEuD5C/kqi6CkjeTpJRuL4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] mt76: mt7615: introduce mt7663u support
Date:   Tue,  7 Apr 2020 11:46:29 +0200
Message-Id: <f388b81e88984cdc886726ca13a4b41be5e45eea.1586252669.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586252669.git.lorenzo@kernel.org>
References: <cover.1586252669.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce support for mt7663u 802.11ac 2x2:2 chipset to mt7615 driver.
Main difference respect to pcie code base is the usb code needs to
configure wtbl from non-atomic context

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 .../net/wireless/mediatek/mt76/mt7615/Kconfig |  11 +
 .../wireless/mediatek/mt76/mt7615/Makefile    |   3 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  28 ++
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |   5 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  34 ++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   3 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |   5 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  10 +
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  26 ++
 .../net/wireless/mediatek/mt76/mt7615/usb.c   | 418 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7615/usb_init.c  | 144 ++++++
 .../wireless/mediatek/mt76/mt7615/usb_mcu.c   |  93 ++++
 13 files changed, 778 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e31d98a4f88f..577465c01827 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -285,6 +285,7 @@ enum {
 	MT76_MCU_RESET,
 	MT76_REMOVED,
 	MT76_READING_STATS,
+	MT76_STATE_POWER_OFF,
 };
 
 struct mt76_hw_cap {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
index 16385767d8b9..a84317fb856f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
@@ -27,3 +27,14 @@ config MT7622_WMAC
 	  This adds support for the built-in WMAC on MT7622 SoC devices
 	  which has the same feature set as a MT7615, but limited to
 	  2.4 GHz only.
+
+config MT7663U
+	tristate "MediaTek MT7663U (USB) support"
+	select MT76_USB
+	select MT7615_COMMON
+	depends on MAC80211
+	depends on USB
+	help
+	  This adds support for MT7663U 802.11ax 2x2:2 wireless devices.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
index 2a7937b4394f..99f353b8b9aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_MT7615_COMMON) += mt7615-common.o
 obj-$(CONFIG_MT7615E) += mt7615e.o
+obj-$(CONFIG_MT7663U) += mt7663u.o
 
 CFLAGS_trace.o := -I$(src)
 
@@ -10,3 +11,5 @@ mt7615-common-y := main.o init.o mcu.o eeprom.o mac.o \
 
 mt7615e-y := pci.o pci_init.o dma.o pci_mac.o mmio.o
 mt7615e-$(CONFIG_MT7622_WMAC) += soc.o
+
+mt7663u-y := usb.o usb_mcu.o usb_init.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 026d770de2ef..7f74174aac38 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -868,6 +868,29 @@ mt7615_mac_update_rate_desc(struct mt7615_phy *phy, struct mt7615_sta *sta,
 	rd->bw = bw;
 }
 
+static int
+mt7615_mac_queue_rate_update(struct mt7615_phy *phy, struct mt7615_sta *sta,
+			     struct ieee80211_tx_rate *probe_rate,
+			     struct ieee80211_tx_rate *rates)
+{
+	struct mt7615_dev *dev = phy->dev;
+	struct mt7615_wtbl_desc *wd;
+
+	wd = kzalloc(sizeof(*wd), GFP_ATOMIC);
+	if (!wd)
+		return -ENOMEM;
+
+	wd->type = MT7615_WTBL_RATE_DESC;
+	wd->sta = sta;
+
+	mt7615_mac_update_rate_desc(phy, sta, probe_rate, rates,
+				    &wd->rate);
+	list_add_tail(&wd->node, &dev->wd_head);
+	queue_work(dev->mt76.usb.wq, &dev->wtbl_work);
+
+	return 0;
+}
+
 void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates)
@@ -877,6 +900,11 @@ void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 	struct mt7615_rate_desc rd;
 	u32 w5, w27, addr;
 
+	if (mt76_is_usb(&dev->mt76)) {
+		mt7615_mac_queue_rate_update(phy, sta, probe_rate, rates);
+		return;
+	}
+
 	if (!mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000))
 		return;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index f3e0070896a1..b540a8cca1e1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -165,9 +165,12 @@ enum tx_phy_bandwidth {
 #define MT_CT_INFO_NONE_CIPHER_FRAME	BIT(3)
 #define MT_CT_INFO_HSR2_TX		BIT(4)
 
-#define MT_USB_TXD_SIZE			(MT_TXD_SIZE + 8 * 4)
 #define MT_TXD_SIZE			(8 * 4)
 
+#define MT_USB_TXD_SIZE			(MT_TXD_SIZE + 8 * 4)
+#define MT_USB_HDR_SIZE			4
+#define MT_USB_TAIL_SIZE		4
+
 #define MT_TXD0_P_IDX			BIT(31)
 #define MT_TXD0_Q_IDX			GENMASK(30, 26)
 #define MT_TXD0_UDP_TCP_SUM		BIT(24)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index fec1c60197ee..377b113a545f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -283,6 +283,37 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 	return ret;
 }
 
+static int
+mt7615_queue_key_update(struct mt7615_dev *dev, enum set_key_cmd cmd,
+			struct mt7615_sta *msta,
+			struct ieee80211_key_conf *key)
+{
+	struct mt7615_wtbl_desc *wd;
+
+	wd = kzalloc(sizeof(*wd), GFP_KERNEL);
+	if (!wd)
+		return -ENOMEM;
+
+	wd->type = MT7615_WTBL_KEY_DESC;
+	wd->sta = msta;
+
+	wd->key.key = kzalloc(key->keylen, GFP_KERNEL);
+	if (!wd->key.key) {
+		kfree(wd);
+		return -ENOMEM;
+	}
+	memcpy(wd->key.key, key->key, key->keylen);
+	wd->key.cipher = key->cipher;
+	wd->key.keyidx = key->keyidx;
+	wd->key.keylen = key->keylen;
+	wd->key.cmd = cmd;
+
+	list_add_tail(&wd->node, &dev->wd_head);
+	queue_work(dev->mt76.usb.wq, &dev->wtbl_work);
+
+	return 0;
+}
+
 int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		   struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 		   struct ieee80211_key_conf *key)
@@ -331,6 +362,9 @@ int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	mt76_wcid_key_setup(&dev->mt76, wcid,
 			    cmd == SET_KEY ? key : NULL);
 
+	if (mt76_is_usb(&dev->mt76))
+		return mt7615_queue_key_update(dev, cmd, msta, key);
+
 	return mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
 }
 EXPORT_SYMBOL_GPL(mt7615_set_key);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index be51141369d2..4c6fc004a13b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1598,8 +1598,7 @@ static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const void *data,
 	int ret = 0, cur_len;
 
 	while (len > 0) {
-		cur_len = min_t(int, 4096 - sizeof(struct mt7615_mcu_txd),
-				len);
+		cur_len = min_t(int, 4096 - dev->mt76.mcu_ops->headroom, len);
 
 		ret = __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FW_SCATTER,
 					  data, cur_len, false);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 983625fb72ee..dff3f3632faf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -449,6 +449,11 @@ enum {
 	FW_STATE_CR4_RDY          = 7
 };
 
+enum {
+	FW_STATE_PWR_ON = 1,
+	FW_STATE_N9_RDY = 2,
+};
+
 #define STA_TYPE_STA		BIT(0)
 #define STA_TYPE_AP		BIT(1)
 #define STA_TYPE_ADHOC		BIT(2)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 344b45a9510c..36e103c34039 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -264,6 +264,9 @@ struct mt7615_dev {
 	struct idr token;
 
 	u8 fw_ver;
+
+	struct work_struct wtbl_work;
+	struct list_head wd_head;
 };
 
 enum {
@@ -551,6 +554,13 @@ int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy);
 int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy);
 
 int mt7615_init_debugfs(struct mt7615_dev *dev);
+int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
+
 int __mt7663_load_firmware(struct mt7615_dev *dev);
 
+/* usb */
+void mt7663u_wtbl_work(struct work_struct *work);
+int mt7663u_mcu_init(struct mt7615_dev *dev);
+int mt7663u_register_device(struct mt7615_dev *dev);
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 481e4d941e72..f61c7f70b485 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -43,6 +43,7 @@ enum mt7615_reg_base {
 #define MT_TOP_MISC2_FW_STATE		GENMASK(2, 0)
 
 #define MT7663_TOP_MISC2_FW_STATE	GENMASK(3, 1)
+#define MT_TOP_MISC2_FW_PWR_ON		BIT(1)
 
 #define MT_MCU_BASE			0x2000
 #define MT_MCU(ofs)			(MT_MCU_BASE + (ofs))
@@ -58,6 +59,8 @@ enum mt7615_reg_base {
 #define MT_PCIE_REMAP_BASE_2		((dev)->reg_map[MT_PCIE_REMAP_BASE2])
 
 #define MT_HIF(ofs)			((dev)->reg_map[MT_HIF_BASE] + (ofs))
+#define MT_HIF_RST			MT_HIF(0x100)
+#define MT_HIF_LOGIC_RST_N		BIT(4)
 
 #define MT7663_MCU_PCIE_REMAP_2_OFFSET	GENMASK(15, 0)
 #define MT7663_MCU_PCIE_REMAP_2_BASE	GENMASK(31, 16)
@@ -478,4 +481,27 @@ enum mt7615_reg_base {
 #define MT_INFRACFG_MISC		0x700
 #define MT_INFRACFG_MISC_AP2CONN_WAKE	BIT(1)
 
+#define MT_UMAC_BASE			0x7c000000
+#define MT_UMAC(ofs)			(MT_UMAC_BASE + (ofs))
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
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
new file mode 100644
index 000000000000..43bea294b14a
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -0,0 +1,418 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2019 MediaTek Inc.
+ *
+ * Author: Felix Fietkau <nbd@nbd.name>
+ *	   Lorenzo Bianconi <lorenzo@kernel.org>
+ *	   Sean Wang <sean.wang@mediatek.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+
+#include "mt7615.h"
+#include "mac.h"
+#include "mcu.h"
+#include "regs.h"
+
+static const u32 mt7663u_reg_map[] = {
+	[MT_TOP_CFG_BASE]	= 0x80020000,
+	[MT_HW_BASE]		= 0x80000000,
+	[MT_DMA_SHDL_BASE]	= 0x5000a000,
+	[MT_HIF_BASE]		= 0x50000000,
+	[MT_CSR_BASE]		= 0x40000000,
+	[MT_EFUSE_ADDR_BASE]	= 0x78011000,
+	[MT_TOP_MISC_BASE]	= 0x81020000,
+	[MT_PHY_BASE]		= 0x82070000,
+	[MT_WTBL_BASE_ADDR]	= 0x820e0000,
+	[MT_CFG_BASE]		= 0x820f0000,
+	[MT_AGG_BASE]		= 0x820f2000,
+	[MT_ARB_BASE]		= 0x820f3000,
+	[MT_TMAC_BASE]		= 0x820f4000,
+	[MT_RMAC_BASE]		= 0x820f5000,
+	[MT_DMA_BASE]		= 0x820f7000,
+	[MT_WTBL_BASE_ON]	= 0x820f9000,
+	[MT_WTBL_BASE_OFF]	= 0x820f9800,
+	[MT_LPON_BASE]		= 0x820fb000,
+	[MT_MIB_BASE]		= 0x820fd000,
+};
+
+static const struct usb_device_id mt7615_device_table[] = {
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7663, 0xff, 0xff, 0xff)},
+	{ },
+};
+
+static void mt7663u_stop(struct ieee80211_hw *hw)
+{
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+	struct mt7615_dev *dev = hw->priv;
+
+	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
+	cancel_delayed_work_sync(&phy->scan_work);
+	mt76u_stop_tx(&dev->mt76);
+	cancel_delayed_work_sync(&dev->mt76.mac_work);
+}
+
+static void mt7663u_cleanup(struct mt7615_dev *dev)
+{
+	clear_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
+	mt76u_queues_deinit(&dev->mt76);
+}
+
+static void
+mt7663u_mac_write_txwi(struct mt7615_dev *dev, struct mt76_wcid *wcid,
+		       enum mt76_txq_id qid, struct ieee80211_sta *sta,
+		       struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	__le32 *txwi;
+	int pid;
+
+	if (!wcid)
+		wcid = &dev->mt76.global_wcid;
+
+	pid = mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
+
+	txwi = (__le32 *)(skb->data - MT_USB_TXD_SIZE);
+	memset(txwi, 0, MT_USB_TXD_SIZE);
+	mt7615_mac_write_txwi(dev, txwi, skb, wcid, sta,
+			      pid, info->control.hw_key, false);
+	skb_push(skb, MT_USB_TXD_SIZE);
+}
+
+static int
+__mt7663u_mac_set_rates(struct mt7615_dev *dev,
+			struct mt7615_wtbl_desc *wd)
+{
+	struct mt7615_rate_desc *rate = &wd->rate;
+	struct mt7615_sta *sta = wd->sta;
+	u32 w5, w27, addr, val;
+
+	lockdep_assert_held(&dev->mt76.mutex);
+
+	if (!sta)
+		return -EINVAL;
+
+	if (!mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000))
+		return -ETIMEDOUT;
+
+	addr = mt7615_mac_wtbl_addr(dev, sta->wcid.idx);
+
+	w27 = mt76_rr(dev, addr + 27 * 4);
+	w27 &= ~MT_WTBL_W27_CC_BW_SEL;
+	w27 |= FIELD_PREP(MT_WTBL_W27_CC_BW_SEL, rate->bw);
+
+	w5 = mt76_rr(dev, addr + 5 * 4);
+	w5 &= ~(MT_WTBL_W5_BW_CAP | MT_WTBL_W5_CHANGE_BW_RATE |
+		MT_WTBL_W5_MPDU_OK_COUNT |
+		MT_WTBL_W5_MPDU_FAIL_COUNT |
+		MT_WTBL_W5_RATE_IDX);
+	w5 |= FIELD_PREP(MT_WTBL_W5_BW_CAP, rate->bw) |
+	      FIELD_PREP(MT_WTBL_W5_CHANGE_BW_RATE,
+			 rate->bw_idx ? rate->bw_idx - 1 : 7);
+
+	mt76_wr(dev, MT_WTBL_RIUCR0, w5);
+
+	mt76_wr(dev, MT_WTBL_RIUCR1,
+		FIELD_PREP(MT_WTBL_RIUCR1_RATE0, rate->probe_val) |
+		FIELD_PREP(MT_WTBL_RIUCR1_RATE1, rate->val[0]) |
+		FIELD_PREP(MT_WTBL_RIUCR1_RATE2_LO, rate->val[1]));
+
+	mt76_wr(dev, MT_WTBL_RIUCR2,
+		FIELD_PREP(MT_WTBL_RIUCR2_RATE2_HI, rate->val[1] >> 8) |
+		FIELD_PREP(MT_WTBL_RIUCR2_RATE3, rate->val[1]) |
+		FIELD_PREP(MT_WTBL_RIUCR2_RATE4, rate->val[2]) |
+		FIELD_PREP(MT_WTBL_RIUCR2_RATE5_LO, rate->val[2]));
+
+	mt76_wr(dev, MT_WTBL_RIUCR3,
+		FIELD_PREP(MT_WTBL_RIUCR3_RATE5_HI, rate->val[2] >> 4) |
+		FIELD_PREP(MT_WTBL_RIUCR3_RATE6, rate->val[3]) |
+		FIELD_PREP(MT_WTBL_RIUCR3_RATE7, rate->val[3]));
+
+	mt76_wr(dev, MT_WTBL_UPDATE,
+		FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, sta->wcid.idx) |
+		MT_WTBL_UPDATE_RATE_UPDATE |
+		MT_WTBL_UPDATE_TX_COUNT_CLEAR);
+
+	mt76_wr(dev, addr + 27 * 4, w27);
+
+	mt76_set(dev, MT_LPON_T0CR, MT_LPON_T0CR_MODE); /* TSF read */
+	val = mt76_rr(dev, MT_LPON_UTTR0);
+	sta->rate_set_tsf = (val & ~BIT(0)) | rate->rateset;
+
+	if (!(sta->wcid.tx_info & MT_WCID_TX_INFO_SET))
+		mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000);
+
+	sta->rate_count = 2 * MT7615_RATE_RETRY * sta->n_rates;
+	sta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+
+	return 0;
+}
+
+static int
+__mt7663u_mac_set_key(struct mt7615_dev *dev,
+		      struct mt7615_wtbl_desc *wd)
+{
+	struct mt7615_key_desc *key = &wd->key;
+	struct mt7615_sta *sta = wd->sta;
+	enum mt7615_cipher_type cipher;
+	struct mt76_wcid *wcid;
+	int err;
+
+	lockdep_assert_held(&dev->mt76.mutex);
+
+	if (!sta)
+		return -EINVAL;
+
+	cipher = mt7615_mac_get_cipher(key->cipher);
+	if (cipher == MT_CIPHER_NONE)
+		return -EOPNOTSUPP;
+
+	wcid = &wd->sta->wcid;
+
+	mt7615_mac_wtbl_update_cipher(dev, wcid, cipher, key->cmd);
+	err = mt7615_mac_wtbl_update_key(dev, wcid, key->key, key->keylen,
+					 cipher, key->cmd);
+	if (err < 0)
+		return err;
+
+	err = mt7615_mac_wtbl_update_pk(dev, wcid, cipher, key->keyidx,
+					key->cmd);
+	if (err < 0)
+		return err;
+
+	if (key->cmd == SET_KEY)
+		wcid->cipher |= BIT(cipher);
+	else
+		wcid->cipher &= ~BIT(cipher);
+
+	return 0;
+}
+
+void mt7663u_wtbl_work(struct work_struct *work)
+{
+	struct mt7615_wtbl_desc *wd, *wd_next;
+	struct mt7615_dev *dev;
+
+	dev = (struct mt7615_dev *)container_of(work, struct mt7615_dev,
+						wtbl_work);
+
+	list_for_each_entry_safe(wd, wd_next, &dev->wd_head, node) {
+		spin_lock_bh(&dev->mt76.lock);
+		list_del(&wd->node);
+		spin_unlock_bh(&dev->mt76.lock);
+
+		mutex_lock(&dev->mt76.mutex);
+		switch (wd->type) {
+		case MT7615_WTBL_RATE_DESC:
+			__mt7663u_mac_set_rates(dev, wd);
+			break;
+		case MT7615_WTBL_KEY_DESC:
+			__mt7663u_mac_set_key(dev, wd);
+			break;
+		}
+		mutex_unlock(&dev->mt76.mutex);
+
+		kfree(wd);
+	}
+}
+
+static void
+mt7663u_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
+			struct mt76_queue_entry *e)
+{
+	skb_pull(e->skb, MT_USB_HDR_SIZE + MT_USB_TXD_SIZE);
+	mt76_tx_complete_skb(mdev, e->skb);
+}
+
+static int
+mt7663u_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+		       enum mt76_txq_id qid, struct mt76_wcid *wcid,
+		       struct ieee80211_sta *sta,
+		       struct mt76_tx_info *tx_info)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+
+	if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) {
+		struct mt7615_sta *msta;
+
+		msta = container_of(wcid, struct mt7615_sta, wcid);
+		spin_lock_bh(&dev->mt76.lock);
+		mt7615_mac_set_rates(&dev->phy, msta, &info->control.rates[0],
+				     msta->rates);
+		msta->rate_probe = true;
+		spin_unlock_bh(&dev->mt76.lock);
+	}
+	mt7663u_mac_write_txwi(dev, wcid, qid, sta, tx_info->skb);
+
+	return mt76u_skb_dma_info(tx_info->skb, tx_info->skb->len);
+}
+
+static const struct ieee80211_ops mt7663_usb_ops = {
+	.tx = mt7615_tx,
+	.start = mt7615_start,
+	.stop = mt7663u_stop,
+	.add_interface = mt7615_add_interface,
+	.remove_interface = mt7615_remove_interface,
+	.sta_add = mt7615_sta_add,
+	.sta_remove = mt7615_sta_remove,
+	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
+	.config = mt7615_config,
+	.conf_tx = mt7615_conf_tx,
+	.configure_filter = mt7615_configure_filter,
+	.bss_info_changed = mt7615_bss_info_changed,
+	.set_key = mt7615_set_key,
+	.ampdu_action = mt7615_ampdu_action,
+	.set_rts_threshold = mt7615_set_rts_threshold,
+	.wake_tx_queue = mt76_wake_tx_queue,
+	.sta_rate_tbl_update = mt7615_sta_rate_tbl_update,
+	.sw_scan_start = mt76_sw_scan,
+	.sw_scan_complete = mt76_sw_scan_complete,
+	.release_buffered_frames = mt76_release_buffered_frames,
+	.get_txpower = mt76_get_txpower,
+	.get_survey = mt76_get_survey,
+	.hw_scan = mt7615_hw_scan,
+	.cancel_hw_scan = mt7615_cancel_hw_scan,
+	.sched_scan_start = mt7615_start_sched_scan,
+	.sched_scan_stop = mt7615_stop_sched_scan,
+};
+
+static int
+mt7663u_probe(struct usb_interface *usb_intf,
+	      const struct usb_device_id *id)
+{
+	static const struct mt76_driver_ops drv_ops = {
+		.txwi_size = MT_USB_TXD_SIZE,
+		.drv_flags = MT_DRV_RX_DMA_HDR,
+		.tx_prepare_skb = mt7663u_tx_prepare_skb,
+		.tx_complete_skb = mt7663u_tx_complete_skb,
+		.rx_skb = mt7615_queue_rx_skb,
+		.sta_ps = mt7615_sta_ps,
+		.sta_add = mt7615_mac_sta_add,
+		.sta_remove = mt7615_mac_sta_remove,
+		.update_survey = mt7615_update_channel,
+	};
+	struct usb_device *udev = interface_to_usbdev(usb_intf);
+	struct mt7615_dev *dev;
+	struct mt76_dev *mdev;
+	int ret;
+
+	mdev = mt76_alloc_device(&usb_intf->dev, sizeof(*dev),
+				 &mt7663_usb_ops, &drv_ops);
+	if (!mdev)
+		return -ENOMEM;
+
+	dev = container_of(mdev, struct mt7615_dev, mt76);
+	udev = usb_get_dev(udev);
+	usb_reset_device(udev);
+
+	usb_set_intfdata(usb_intf, dev);
+
+	dev->reg_map = mt7663u_reg_map;
+	ret = mt76u_init(mdev, usb_intf, true);
+	if (ret < 0)
+		goto error;
+
+	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
+		    (mt76_rr(dev, MT_HW_REV) & 0xff);
+	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+
+	if (mt76_poll_msec(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_PWR_ON,
+			   FW_STATE_PWR_ON << 1, 500)) {
+		dev_dbg(dev->mt76.dev, "Usb device already powered on\n");
+		set_bit(MT76_STATE_POWER_OFF, &dev->mphy.state);
+		goto alloc_queues;
+	}
+
+	ret = mt76u_vendor_request(&dev->mt76, MT_VEND_POWER_ON,
+				   USB_DIR_OUT | USB_TYPE_VENDOR,
+				   0x0, 0x1, NULL, 0);
+	if (ret)
+		goto error;
+
+	if (!mt76_poll_msec(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_PWR_ON,
+			    FW_STATE_PWR_ON << 1, 500)) {
+		dev_err(dev->mt76.dev, "Timeout for power on\n");
+		return -EIO;
+	}
+
+alloc_queues:
+	ret = mt76u_alloc_mcu_queue(&dev->mt76);
+	if (ret)
+		goto error;
+
+	ret = mt76u_alloc_queues(&dev->mt76);
+	if (ret)
+		goto error;
+
+	ret = mt7663u_register_device(dev);
+	if (ret)
+		goto error_freeq;
+
+	return 0;
+
+error_freeq:
+	mt76u_queues_deinit(&dev->mt76);
+error:
+	mt76u_deinit(&dev->mt76);
+	usb_set_intfdata(usb_intf, NULL);
+	usb_put_dev(interface_to_usbdev(usb_intf));
+
+	ieee80211_free_hw(mdev->hw);
+
+	return ret;
+}
+
+static void mt7663u_disconnect(struct usb_interface *usb_intf)
+{
+	struct mt7615_dev *dev = usb_get_intfdata(usb_intf);
+
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
+		return;
+
+	ieee80211_unregister_hw(dev->mt76.hw);
+	mt7663u_cleanup(dev);
+
+	usb_set_intfdata(usb_intf, NULL);
+	usb_put_dev(interface_to_usbdev(usb_intf));
+
+	mt76u_deinit(&dev->mt76);
+	ieee80211_free_hw(dev->mt76.hw);
+}
+
+static int __maybe_unused
+mt7663u_suspend(struct usb_interface *intf,
+		pm_message_t state)
+{
+	return 0;
+}
+
+static int __maybe_unused
+mt7663u_resume(struct usb_interface *intf)
+{
+	return 0;
+}
+
+MODULE_DEVICE_TABLE(usb, mt7615_device_table);
+MODULE_FIRMWARE(MT7663_FIRMWARE_N9);
+MODULE_FIRMWARE(MT7663_ROM_PATCH);
+
+static struct usb_driver mt7663u_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= mt7615_device_table,
+	.probe		= mt7663u_probe,
+	.disconnect	= mt7663u_disconnect,
+#ifdef CONFIG_PM
+	.suspend	= mt7663u_suspend,
+	.resume		= mt7663u_resume,
+	.reset_resume	= mt7663u_resume,
+#endif /* CONFIG_PM */
+	.soft_unbind	= 1,
+	.disable_hub_initiated_lpm = 1,
+};
+module_usb_driver(mt7663u_driver);
+
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c
new file mode 100644
index 000000000000..a05f0eda21dd
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2019 MediaTek Inc.
+ *
+ * Author: Felix Fietkau <nbd@nbd.name>
+ *	   Lorenzo Bianconi <lorenzo@kernel.org>
+ *	   Sean Wang <sean.wang@mediatek.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "mt7615.h"
+#include "mac.h"
+#include "regs.h"
+
+static int mt7663u_dma_sched_init(struct mt7615_dev *dev)
+{
+	int i;
+
+	mt76_rmw(dev, MT_DMA_SHDL(MT_DMASHDL_PKT_MAX_SIZE),
+		 MT_DMASHDL_PKT_MAX_SIZE_PLE | MT_DMASHDL_PKT_MAX_SIZE_PSE,
+		 FIELD_PREP(MT_DMASHDL_PKT_MAX_SIZE_PLE, 1) |
+		 FIELD_PREP(MT_DMASHDL_PKT_MAX_SIZE_PSE, 8));
+
+	/* disable refill group 5 - group 15 and raise group 2
+	 * and 3 as high priority.
+	 */
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_REFILL), 0xffe00006);
+	mt76_clear(dev, MT_DMA_SHDL(MT_DMASHDL_PAGE), BIT(16));
+
+	for (i = 0; i < 5; i++)
+		mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_GROUP_QUOTA(i)),
+			FIELD_PREP(MT_DMASHDL_GROUP_QUOTA_MIN, 0x3) |
+			FIELD_PREP(MT_DMASHDL_GROUP_QUOTA_MAX, 0x1ff));
+
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_Q_MAP(0)), 0x42104210);
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_Q_MAP(1)), 0x42104210);
+
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_Q_MAP(2)), 0x4444);
+
+	/* group pririority from high to low:
+	 * 15 (cmd groups) > 4 > 3 > 2 > 1 > 0.
+	 */
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_SCHED_SET0), 0x6501234f);
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_SCHED_SET1), 0xedcba987);
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_OPTIONAL), 0x7004801c);
+
+	mt76_wr(dev, MT_UDMA_WLCFG_1,
+		FIELD_PREP(MT_WL_TX_TMOUT_LMT, 80000) |
+		FIELD_PREP(MT_WL_RX_AGG_PKT_LMT, 1));
+
+	/* setup UDMA Rx Flush */
+	mt76_clear(dev, MT_UDMA_WLCFG_0, MT_WL_RX_FLUSH);
+	/* hif reset */
+	mt76_set(dev, MT_HIF_RST, MT_HIF_LOGIC_RST_N);
+
+	mt76_set(dev, MT_UDMA_WLCFG_0,
+		 MT_WL_RX_AGG_EN | MT_WL_RX_EN | MT_WL_TX_EN |
+		 MT_WL_RX_MPSZ_PAD0 | MT_TICK_1US_EN |
+		 MT_WL_TX_TMOUT_FUNC_EN);
+	mt76_rmw(dev, MT_UDMA_WLCFG_0, MT_WL_RX_AGG_LMT | MT_WL_RX_AGG_TO,
+		 FIELD_PREP(MT_WL_RX_AGG_LMT, 32) |
+		 FIELD_PREP(MT_WL_RX_AGG_TO, 100));
+
+	return 0;
+}
+
+static int mt7663u_init_hardware(struct mt7615_dev *dev)
+{
+	int ret, idx;
+
+	ret = mt7615_eeprom_init(dev, MT_EFUSE_BASE);
+	if (ret < 0)
+		return ret;
+
+	ret = mt7663u_dma_sched_init(dev);
+	if (ret)
+		return ret;
+
+	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
+
+	/* Beacon and mgmt frames should occupy wcid 0 */
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7615_WTBL_STA - 1);
+	if (idx)
+		return -ENOSPC;
+
+	dev->mt76.global_wcid.idx = idx;
+	dev->mt76.global_wcid.hw_key_idx = -1;
+	rcu_assign_pointer(dev->mt76.wcid[idx], &dev->mt76.global_wcid);
+
+	return 0;
+}
+
+static void mt7663u_init_work(struct work_struct *work)
+{
+	struct mt7615_dev *dev;
+
+	dev = container_of(work, struct mt7615_dev, mcu_work);
+	if (mt7663u_mcu_init(dev))
+		return;
+
+	mt7615_mcu_set_eeprom(dev);
+	mt7615_mac_init(dev);
+	mt7615_phy_init(dev);
+	mt7615_mcu_del_wtbl_all(dev);
+}
+
+int mt7663u_register_device(struct mt7615_dev *dev)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	int err;
+
+	INIT_WORK(&dev->wtbl_work, mt7663u_wtbl_work);
+	INIT_WORK(&dev->mcu_work, mt7663u_init_work);
+	INIT_LIST_HEAD(&dev->wd_head);
+	mt7615_init_device(dev);
+
+	err = mt7663u_init_hardware(dev);
+	if (err)
+		return err;
+
+	hw->extra_tx_headroom += MT_USB_HDR_SIZE + MT_USB_TXD_SIZE;
+	/* check hw sg support in order to enable AMSDU */
+	hw->max_tx_fragments = dev->mt76.usb.sg_en ? MT_HW_TXP_MAX_BUF_NUM : 1;
+
+	err = mt76_register_device(&dev->mt76, true, mt7615_rates,
+				   ARRAY_SIZE(mt7615_rates));
+	if (err < 0)
+		return err;
+
+	if (!dev->mt76.usb.sg_en) {
+		struct ieee80211_sta_vht_cap *vht_cap;
+
+		/* decrease max A-MSDU size if SG is not supported */
+		vht_cap = &dev->mphy.sband_5g.sband.vht_cap;
+		vht_cap->cap &= ~IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454;
+	}
+
+	ieee80211_queue_work(hw, &dev->mcu_work);
+	mt7615_init_txpower(dev, &dev->mphy.sband_2g.sband);
+	mt7615_init_txpower(dev, &dev->mphy.sband_5g.sband);
+
+	return mt7615_init_debugfs(dev);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
new file mode 100644
index 000000000000..cd709fd617db
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2019 MediaTek Inc.
+ *
+ * Author: Felix Fietkau <nbd@nbd.name>
+ *	   Lorenzo Bianconi <lorenzo@kernel.org>
+ *	   Sean Wang <sean.wang@mediatek.com>
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "mt7615.h"
+#include "mac.h"
+#include "mcu.h"
+#include "regs.h"
+
+static int
+mt7663u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			 int cmd, bool wait_resp)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	int ret, seq, ep;
+
+	mutex_lock(&mdev->mcu.mutex);
+
+	mt7615_mcu_fill_msg(dev, skb, cmd, &seq);
+	if (cmd != MCU_CMD_FW_SCATTER)
+		ep = MT_EP_OUT_INBAND_CMD;
+	else
+		ep = MT_EP_OUT_AC_BE;
+
+	ret = mt76u_skb_dma_info(skb, skb->len);
+	if (ret < 0)
+		goto out;
+
+	ret = mt76u_bulk_msg(&dev->mt76, skb->data, skb->len, NULL,
+			     1000, ep);
+	dev_kfree_skb(skb);
+	if (ret < 0)
+		goto out;
+
+	if (wait_resp)
+		ret = mt7615_mcu_wait_response(dev, cmd, seq);
+
+out:
+	mutex_unlock(&mdev->mcu.mutex);
+
+	return ret;
+}
+
+int mt7663u_mcu_init(struct mt7615_dev *dev)
+{
+	static const struct mt76_mcu_ops mt7663u_mcu_ops = {
+		.headroom = MT_USB_HDR_SIZE + sizeof(struct mt7615_mcu_txd),
+		.tailroom = MT_USB_TAIL_SIZE,
+		.mcu_skb_send_msg = mt7663u_mcu_send_message,
+		.mcu_send_msg = mt7615_mcu_msg_send,
+		.mcu_restart = mt7615_mcu_restart,
+	};
+	int ret;
+
+	dev->mt76.mcu_ops = &mt7663u_mcu_ops,
+
+	mt76_set(dev, MT_UDMA_TX_QSEL, MT_FW_DL_EN);
+
+	if (test_and_clear_bit(MT76_STATE_POWER_OFF, &dev->mphy.state)) {
+		mt7615_mcu_restart(&dev->mt76);
+		if (!mt76_poll_msec(dev, MT_CONN_ON_MISC,
+				    MT_TOP_MISC2_FW_PWR_ON, 0, 500))
+			return -EIO;
+
+		ret = mt76u_vendor_request(&dev->mt76, MT_VEND_POWER_ON,
+					   USB_DIR_OUT | USB_TYPE_VENDOR,
+					   0x0, 0x1, NULL, 0);
+		if (ret)
+			return ret;
+
+		if (!mt76_poll_msec(dev, MT_CONN_ON_MISC,
+				    MT_TOP_MISC2_FW_PWR_ON,
+				    FW_STATE_PWR_ON << 1, 500)) {
+			dev_err(dev->mt76.dev, "Timeout for power on\n");
+			return -EIO;
+		}
+	}
+
+	ret = __mt7663_load_firmware(dev);
+	if (ret)
+		return ret;
+
+	mt76_clear(dev, MT_UDMA_TX_QSEL, MT_FW_DL_EN);
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+
+	return 0;
+}
-- 
2.25.2

