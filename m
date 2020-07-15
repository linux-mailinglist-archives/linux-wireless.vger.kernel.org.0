Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA16D220D47
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 14:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbgGOMq4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 08:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgGOMq4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 08:46:56 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF9B120658;
        Wed, 15 Jul 2020 12:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594817214;
        bh=g2UGyHLDSJAaCnXifktE4kzSdpTVgjYVIMdktY64LyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Om4o9T+v9gU3a1dJKJJ2e0I9o7A/U2DYpDvYqYpkmFV8B0kAxf0EjZHGnKt/YoQC8
         dmNZfrTLPTN8/Rq3a5Q+S4SM5sEO3lSXnm+yQ1z40e8GwSR8LcYuYx68LoxEWXazYo
         BEFhf4fB1CxAbd1hiUu6h9LRHYuyT4Je54RcQh/8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 4/6] mt76: mt7615: introduce mt7663-usb-sdio-common module
Date:   Wed, 15 Jul 2020 14:46:29 +0200
Message-Id: <6da9018c50bcbdc430867f55106af6ffcf0d1551.1594815602.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1594815602.git.lorenzo@kernel.org>
References: <cover.1594815602.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7663-usb-sdio-common module as container for shared
code between usb and sdio driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/Kconfig |   6 +-
 .../wireless/mediatek/mt76/mt7615/Makefile    |   4 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  13 +-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   | 255 +-----------
 .../wireless/mediatek/mt76/mt7615/usb_init.c  | 145 -------
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  | 390 ++++++++++++++++++
 6 files changed, 424 insertions(+), 389 deletions(-)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
index c094260b0f89..10a4f1ed9194 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
@@ -28,10 +28,14 @@ config MT7622_WMAC
 	  which has the same feature set as a MT7615, but limited to
 	  2.4 GHz only.
 
+config MT7663_USB_SDIO_COMMON
+	tristate
+	select MT7615_COMMON
+
 config MT7663U
 	tristate "MediaTek MT7663U (USB) support"
 	select MT76_USB
-	select MT7615_COMMON
+	select MT7663_USB_SDIO_COMMON
 	depends on MAC80211
 	depends on USB
 	help
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
index d2ad84cb5244..a1cdaadb5442 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_MT7615_COMMON) += mt7615-common.o
 obj-$(CONFIG_MT7615E) += mt7615e.o
+obj-$(CONFIG_MT7663_USB_SDIO_COMMON) += mt7663-usb-sdio-common.o
 obj-$(CONFIG_MT7663U) += mt7663u.o
 
 CFLAGS_trace.o := -I$(src)
@@ -13,4 +14,5 @@ mt7615-common-$(CONFIG_NL80211_TESTMODE) += testmode.o
 mt7615e-y := pci.o pci_init.o dma.o pci_mac.o mmio.o
 mt7615e-$(CONFIG_MT7622_WMAC) += soc.o
 
-mt7663u-y := usb.o usb_mcu.o usb_init.o
+mt7663-usb-sdio-common-y := usb_sdio.o
+mt7663u-y := usb.o usb_mcu.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index f70d49cbc027..097cd150d879 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -409,6 +409,7 @@ extern struct ieee80211_rate mt7615_rates[12];
 extern const struct ieee80211_ops mt7615_ops;
 extern const u32 mt7615e_reg_map[__MT_BASE_MAX];
 extern const u32 mt7663e_reg_map[__MT_BASE_MAX];
+extern const u32 mt7663_usb_sdio_reg_map[__MT_BASE_MAX];
 extern struct pci_driver mt7615_pci_driver;
 extern struct platform_driver mt7622_wmac_driver;
 extern const struct mt76_testmode_ops mt7615_testmode_ops;
@@ -657,8 +658,16 @@ int mt7615_mcu_update_arp_filter(struct ieee80211_hw *hw,
 int __mt7663_load_firmware(struct mt7615_dev *dev);
 
 /* usb */
-void mt7663u_wtbl_work(struct work_struct *work);
+int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+				   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+				   struct ieee80211_sta *sta,
+				   struct mt76_tx_info *tx_info);
+bool mt7663_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update);
+void mt7663_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
+				     enum mt76_txq_id qid,
+				     struct mt76_queue_entry *e);
+void mt7663_usb_sdio_wtbl_work(struct work_struct *work);
+int mt7663_usb_sdio_register_device(struct mt7615_dev *dev);
 int mt7663u_mcu_init(struct mt7615_dev *dev);
-int mt7663u_register_device(struct mt7615_dev *dev);
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index aba926f1eeb5..f1b4a6316db3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -15,30 +15,6 @@
 #include "mcu.h"
 #include "regs.h"
 
-static const u32 mt7663u_reg_map[] = {
-	[MT_TOP_CFG_BASE]	= 0x80020000,
-	[MT_HW_BASE]		= 0x80000000,
-	[MT_DMA_SHDL_BASE]	= 0x5000a000,
-	[MT_HIF_BASE]		= 0x50000000,
-	[MT_CSR_BASE]		= 0x40000000,
-	[MT_EFUSE_ADDR_BASE]	= 0x78011000,
-	[MT_TOP_MISC_BASE]	= 0x81020000,
-	[MT_PLE_BASE]		= 0x82060000,
-	[MT_PSE_BASE]		= 0x82068000,
-	[MT_WTBL_BASE_ADDR]	= 0x820e0000,
-	[MT_CFG_BASE]		= 0x820f0000,
-	[MT_AGG_BASE]		= 0x820f2000,
-	[MT_ARB_BASE]		= 0x820f3000,
-	[MT_TMAC_BASE]		= 0x820f4000,
-	[MT_RMAC_BASE]		= 0x820f5000,
-	[MT_DMA_BASE]		= 0x820f7000,
-	[MT_PF_BASE]		= 0x820f8000,
-	[MT_WTBL_BASE_ON]	= 0x820f9000,
-	[MT_WTBL_BASE_OFF]	= 0x820f9800,
-	[MT_LPON_BASE]		= 0x820fb000,
-	[MT_MIB_BASE]		= 0x820fd000,
-};
-
 static const struct usb_device_id mt7615_device_table[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7663, 0xff, 0xff, 0xff) },
 	{ },
@@ -63,221 +39,19 @@ static void mt7663u_cleanup(struct mt7615_dev *dev)
 	mt76u_queues_deinit(&dev->mt76);
 }
 
-static void
-mt7663u_mac_write_txwi(struct mt7615_dev *dev, struct mt76_wcid *wcid,
-		       enum mt76_txq_id qid, struct ieee80211_sta *sta,
-		       struct sk_buff *skb)
-{
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_key_conf *key = info->control.hw_key;
-	__le32 *txwi;
-	int pid;
-
-	if (!wcid)
-		wcid = &dev->mt76.global_wcid;
-
-	pid = mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
-
-	txwi = (__le32 *)(skb->data - MT_USB_TXD_SIZE);
-	memset(txwi, 0, MT_USB_TXD_SIZE);
-	mt7615_mac_write_txwi(dev, txwi, skb, wcid, sta, pid, key, false);
-	skb_push(skb, MT_USB_TXD_SIZE);
-}
-
-static int
-__mt7663u_mac_set_rates(struct mt7615_dev *dev,
-			struct mt7615_wtbl_desc *wd)
-{
-	struct mt7615_rate_desc *rate = &wd->rate;
-	struct mt7615_sta *sta = wd->sta;
-	u32 w5, w27, addr, val;
-
-	lockdep_assert_held(&dev->mt76.mutex);
-
-	if (!sta)
-		return -EINVAL;
-
-	if (!mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000))
-		return -ETIMEDOUT;
-
-	addr = mt7615_mac_wtbl_addr(dev, sta->wcid.idx);
-
-	w27 = mt76_rr(dev, addr + 27 * 4);
-	w27 &= ~MT_WTBL_W27_CC_BW_SEL;
-	w27 |= FIELD_PREP(MT_WTBL_W27_CC_BW_SEL, rate->bw);
-
-	w5 = mt76_rr(dev, addr + 5 * 4);
-	w5 &= ~(MT_WTBL_W5_BW_CAP | MT_WTBL_W5_CHANGE_BW_RATE |
-		MT_WTBL_W5_MPDU_OK_COUNT |
-		MT_WTBL_W5_MPDU_FAIL_COUNT |
-		MT_WTBL_W5_RATE_IDX);
-	w5 |= FIELD_PREP(MT_WTBL_W5_BW_CAP, rate->bw) |
-	      FIELD_PREP(MT_WTBL_W5_CHANGE_BW_RATE,
-			 rate->bw_idx ? rate->bw_idx - 1 : 7);
-
-	mt76_wr(dev, MT_WTBL_RIUCR0, w5);
-
-	mt76_wr(dev, MT_WTBL_RIUCR1,
-		FIELD_PREP(MT_WTBL_RIUCR1_RATE0, rate->probe_val) |
-		FIELD_PREP(MT_WTBL_RIUCR1_RATE1, rate->val[0]) |
-		FIELD_PREP(MT_WTBL_RIUCR1_RATE2_LO, rate->val[1]));
-
-	mt76_wr(dev, MT_WTBL_RIUCR2,
-		FIELD_PREP(MT_WTBL_RIUCR2_RATE2_HI, rate->val[1] >> 8) |
-		FIELD_PREP(MT_WTBL_RIUCR2_RATE3, rate->val[1]) |
-		FIELD_PREP(MT_WTBL_RIUCR2_RATE4, rate->val[2]) |
-		FIELD_PREP(MT_WTBL_RIUCR2_RATE5_LO, rate->val[2]));
-
-	mt76_wr(dev, MT_WTBL_RIUCR3,
-		FIELD_PREP(MT_WTBL_RIUCR3_RATE5_HI, rate->val[2] >> 4) |
-		FIELD_PREP(MT_WTBL_RIUCR3_RATE6, rate->val[3]) |
-		FIELD_PREP(MT_WTBL_RIUCR3_RATE7, rate->val[3]));
-
-	mt76_wr(dev, MT_WTBL_UPDATE,
-		FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, sta->wcid.idx) |
-		MT_WTBL_UPDATE_RATE_UPDATE |
-		MT_WTBL_UPDATE_TX_COUNT_CLEAR);
-
-	mt76_wr(dev, addr + 27 * 4, w27);
-
-	sta->rate_probe = sta->rateset[rate->rateset].probe_rate.idx != -1;
-
-	mt76_set(dev, MT_LPON_T0CR, MT_LPON_T0CR_MODE); /* TSF read */
-	val = mt76_rr(dev, MT_LPON_UTTR0);
-	sta->rate_set_tsf = (val & ~BIT(0)) | rate->rateset;
-
-	if (!(sta->wcid.tx_info & MT_WCID_TX_INFO_SET))
-		mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000);
-
-	sta->rate_count = 2 * MT7615_RATE_RETRY * sta->n_rates;
-	sta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
-
-	return 0;
-}
-
-static int
-__mt7663u_mac_set_key(struct mt7615_dev *dev,
-		      struct mt7615_wtbl_desc *wd)
-{
-	struct mt7615_key_desc *key = &wd->key;
-	struct mt7615_sta *sta = wd->sta;
-	enum mt7615_cipher_type cipher;
-	struct mt76_wcid *wcid;
-	int err;
-
-	lockdep_assert_held(&dev->mt76.mutex);
-
-	if (!sta) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	cipher = mt7615_mac_get_cipher(key->cipher);
-	if (cipher == MT_CIPHER_NONE) {
-		err = -EOPNOTSUPP;
-		goto out;
-	}
-
-	wcid = &wd->sta->wcid;
-
-	mt7615_mac_wtbl_update_cipher(dev, wcid, cipher, key->cmd);
-	err = mt7615_mac_wtbl_update_key(dev, wcid, key->key, key->keylen,
-					 cipher, key->cmd);
-	if (err < 0)
-		goto out;
-
-	err = mt7615_mac_wtbl_update_pk(dev, wcid, cipher, key->keyidx,
-					key->cmd);
-	if (err < 0)
-		goto out;
-
-	if (key->cmd == SET_KEY)
-		wcid->cipher |= BIT(cipher);
-	else
-		wcid->cipher &= ~BIT(cipher);
-
-out:
-	kfree(key->key);
-
-	return err;
-}
-
-void mt7663u_wtbl_work(struct work_struct *work)
+static void mt7663u_init_work(struct work_struct *work)
 {
-	struct mt7615_wtbl_desc *wd, *wd_next;
-	struct list_head wd_list;
 	struct mt7615_dev *dev;
 
-	dev = (struct mt7615_dev *)container_of(work, struct mt7615_dev,
-						wtbl_work);
-
-	INIT_LIST_HEAD(&wd_list);
-	spin_lock_bh(&dev->mt76.lock);
-	list_splice_init(&dev->wd_head, &wd_list);
-	spin_unlock_bh(&dev->mt76.lock);
-
-	list_for_each_entry_safe(wd, wd_next, &wd_list, node) {
-		list_del(&wd->node);
-
-		mt7615_mutex_acquire(dev);
-
-		switch (wd->type) {
-		case MT7615_WTBL_RATE_DESC:
-			__mt7663u_mac_set_rates(dev, wd);
-			break;
-		case MT7615_WTBL_KEY_DESC:
-			__mt7663u_mac_set_key(dev, wd);
-			break;
-		}
-
-		mt7615_mutex_release(dev);
-
-		kfree(wd);
-	}
-}
-
-static void
-mt7663u_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
-			struct mt76_queue_entry *e)
-{
-	skb_pull(e->skb, MT_USB_HDR_SIZE + MT_USB_TXD_SIZE);
-	mt76_tx_complete_skb(mdev, e->skb);
-}
-
-static int
-mt7663u_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
-		       enum mt76_txq_id qid, struct mt76_wcid *wcid,
-		       struct ieee80211_sta *sta,
-		       struct mt76_tx_info *tx_info)
-{
-	struct mt7615_sta *msta = container_of(wcid, struct mt7615_sta, wcid);
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	struct sk_buff *skb = tx_info->skb;
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-
-	if ((info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) &&
-	    !msta->rate_probe) {
-		/* request to configure sampling rate */
-		spin_lock_bh(&dev->mt76.lock);
-		mt7615_mac_set_rates(&dev->phy, msta, &info->control.rates[0],
-				     msta->rates);
-		spin_unlock_bh(&dev->mt76.lock);
-	}
-	mt7663u_mac_write_txwi(dev, wcid, qid, sta, skb);
-
-	put_unaligned_le32(skb->len, skb_push(skb, sizeof(skb->len)));
-	return mt76_skb_adjust_pad(skb);
-}
-
-static bool mt7663u_tx_status_data(struct mt76_dev *mdev, u8 *update)
-{
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-
-	mt7615_mutex_acquire(dev);
-	mt7615_mac_sta_poll(dev);
-	mt7615_mutex_release(dev);
+	dev = container_of(work, struct mt7615_dev, mcu_work);
+	if (mt7663u_mcu_init(dev))
+		return;
 
-	return 0;
+	mt7615_mcu_set_eeprom(dev);
+	mt7615_mac_init(dev);
+	mt7615_phy_init(dev);
+	mt7615_mcu_del_wtbl_all(dev);
+	mt7615_check_offload_capability(dev);
 }
 
 static int mt7663u_probe(struct usb_interface *usb_intf,
@@ -286,9 +60,9 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 	static const struct mt76_driver_ops drv_ops = {
 		.txwi_size = MT_USB_TXD_SIZE,
 		.drv_flags = MT_DRV_RX_DMA_HDR | MT_DRV_HW_MGMT_TXQ,
-		.tx_prepare_skb = mt7663u_tx_prepare_skb,
-		.tx_complete_skb = mt7663u_tx_complete_skb,
-		.tx_status_data = mt7663u_tx_status_data,
+		.tx_prepare_skb = mt7663_usb_sdio_tx_prepare_skb,
+		.tx_complete_skb = mt7663_usb_sdio_tx_complete_skb,
+		.tx_status_data = mt7663_usb_sdio_tx_status_data,
 		.rx_skb = mt7615_queue_rx_skb,
 		.sta_ps = mt7615_sta_ps,
 		.sta_add = mt7615_mac_sta_add,
@@ -318,7 +92,8 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 
 	usb_set_intfdata(usb_intf, dev);
 
-	dev->reg_map = mt7663u_reg_map;
+	INIT_WORK(&dev->mcu_work, mt7663u_init_work);
+	dev->reg_map = mt7663_usb_sdio_reg_map;
 	dev->ops = ops;
 	ret = mt76u_init(mdev, usb_intf, true);
 	if (ret < 0)
@@ -356,7 +131,7 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 	if (ret)
 		goto error;
 
-	ret = mt7663u_register_device(dev);
+	ret = mt7663_usb_sdio_register_device(dev);
 	if (ret)
 		goto error_freeq;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c
deleted file mode 100644
index 1fbc9601391d..000000000000
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c
+++ /dev/null
@@ -1,145 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2019 MediaTek Inc.
- *
- * Author: Felix Fietkau <nbd@nbd.name>
- *	   Lorenzo Bianconi <lorenzo@kernel.org>
- *	   Sean Wang <sean.wang@mediatek.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-
-#include "mt7615.h"
-#include "mac.h"
-#include "regs.h"
-
-static int mt7663u_dma_sched_init(struct mt7615_dev *dev)
-{
-	int i;
-
-	mt76_rmw(dev, MT_DMA_SHDL(MT_DMASHDL_PKT_MAX_SIZE),
-		 MT_DMASHDL_PKT_MAX_SIZE_PLE | MT_DMASHDL_PKT_MAX_SIZE_PSE,
-		 FIELD_PREP(MT_DMASHDL_PKT_MAX_SIZE_PLE, 1) |
-		 FIELD_PREP(MT_DMASHDL_PKT_MAX_SIZE_PSE, 8));
-
-	/* disable refill group 5 - group 15 and raise group 2
-	 * and 3 as high priority.
-	 */
-	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_REFILL), 0xffe00006);
-	mt76_clear(dev, MT_DMA_SHDL(MT_DMASHDL_PAGE), BIT(16));
-
-	for (i = 0; i < 5; i++)
-		mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_GROUP_QUOTA(i)),
-			FIELD_PREP(MT_DMASHDL_GROUP_QUOTA_MIN, 0x3) |
-			FIELD_PREP(MT_DMASHDL_GROUP_QUOTA_MAX, 0x1ff));
-
-	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_Q_MAP(0)), 0x42104210);
-	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_Q_MAP(1)), 0x42104210);
-
-	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_Q_MAP(2)), 0x4444);
-
-	/* group pririority from high to low:
-	 * 15 (cmd groups) > 4 > 3 > 2 > 1 > 0.
-	 */
-	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_SCHED_SET0), 0x6501234f);
-	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_SCHED_SET1), 0xedcba987);
-	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_OPTIONAL), 0x7004801c);
-
-	mt76_wr(dev, MT_UDMA_WLCFG_1,
-		FIELD_PREP(MT_WL_TX_TMOUT_LMT, 80000) |
-		FIELD_PREP(MT_WL_RX_AGG_PKT_LMT, 1));
-
-	/* setup UDMA Rx Flush */
-	mt76_clear(dev, MT_UDMA_WLCFG_0, MT_WL_RX_FLUSH);
-	/* hif reset */
-	mt76_set(dev, MT_HIF_RST, MT_HIF_LOGIC_RST_N);
-
-	mt76_set(dev, MT_UDMA_WLCFG_0,
-		 MT_WL_RX_AGG_EN | MT_WL_RX_EN | MT_WL_TX_EN |
-		 MT_WL_RX_MPSZ_PAD0 | MT_TICK_1US_EN |
-		 MT_WL_TX_TMOUT_FUNC_EN);
-	mt76_rmw(dev, MT_UDMA_WLCFG_0, MT_WL_RX_AGG_LMT | MT_WL_RX_AGG_TO,
-		 FIELD_PREP(MT_WL_RX_AGG_LMT, 32) |
-		 FIELD_PREP(MT_WL_RX_AGG_TO, 100));
-
-	return 0;
-}
-
-static int mt7663u_init_hardware(struct mt7615_dev *dev)
-{
-	int ret, idx;
-
-	ret = mt7615_eeprom_init(dev, MT_EFUSE_BASE);
-	if (ret < 0)
-		return ret;
-
-	ret = mt7663u_dma_sched_init(dev);
-	if (ret)
-		return ret;
-
-	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
-
-	/* Beacon and mgmt frames should occupy wcid 0 */
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7615_WTBL_STA - 1);
-	if (idx)
-		return -ENOSPC;
-
-	dev->mt76.global_wcid.idx = idx;
-	dev->mt76.global_wcid.hw_key_idx = -1;
-	rcu_assign_pointer(dev->mt76.wcid[idx], &dev->mt76.global_wcid);
-
-	return 0;
-}
-
-static void mt7663u_init_work(struct work_struct *work)
-{
-	struct mt7615_dev *dev;
-
-	dev = container_of(work, struct mt7615_dev, mcu_work);
-	if (mt7663u_mcu_init(dev))
-		return;
-
-	mt7615_mcu_set_eeprom(dev);
-	mt7615_mac_init(dev);
-	mt7615_phy_init(dev);
-	mt7615_mcu_del_wtbl_all(dev);
-	mt7615_check_offload_capability(dev);
-}
-
-int mt7663u_register_device(struct mt7615_dev *dev)
-{
-	struct ieee80211_hw *hw = mt76_hw(dev);
-	int err;
-
-	INIT_WORK(&dev->wtbl_work, mt7663u_wtbl_work);
-	INIT_WORK(&dev->mcu_work, mt7663u_init_work);
-	INIT_LIST_HEAD(&dev->wd_head);
-	mt7615_init_device(dev);
-
-	err = mt7663u_init_hardware(dev);
-	if (err)
-		return err;
-
-	hw->extra_tx_headroom += MT_USB_HDR_SIZE + MT_USB_TXD_SIZE;
-	/* check hw sg support in order to enable AMSDU */
-	hw->max_tx_fragments = dev->mt76.usb.sg_en ? MT_HW_TXP_MAX_BUF_NUM : 1;
-
-	err = mt76_register_device(&dev->mt76, true, mt7615_rates,
-				   ARRAY_SIZE(mt7615_rates));
-	if (err < 0)
-		return err;
-
-	if (!dev->mt76.usb.sg_en) {
-		struct ieee80211_sta_vht_cap *vht_cap;
-
-		/* decrease max A-MSDU size if SG is not supported */
-		vht_cap = &dev->mphy.sband_5g.sband.vht_cap;
-		vht_cap->cap &= ~IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454;
-	}
-
-	ieee80211_queue_work(hw, &dev->mcu_work);
-	mt7615_init_txpower(dev, &dev->mphy.sband_2g.sband);
-	mt7615_init_txpower(dev, &dev->mphy.sband_5g.sband);
-
-	return mt7615_init_debugfs(dev);
-}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
new file mode 100644
index 000000000000..610cc1fbec5b
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc.
+ *
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
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
+const u32 mt7663_usb_sdio_reg_map[] = {
+	[MT_TOP_CFG_BASE]	= 0x80020000,
+	[MT_HW_BASE]		= 0x80000000,
+	[MT_DMA_SHDL_BASE]	= 0x5000a000,
+	[MT_HIF_BASE]		= 0x50000000,
+	[MT_CSR_BASE]		= 0x40000000,
+	[MT_EFUSE_ADDR_BASE]	= 0x78011000,
+	[MT_TOP_MISC_BASE]	= 0x81020000,
+	[MT_PLE_BASE]		= 0x82060000,
+	[MT_PSE_BASE]		= 0x82068000,
+	[MT_WTBL_BASE_ADDR]	= 0x820e0000,
+	[MT_CFG_BASE]		= 0x820f0000,
+	[MT_AGG_BASE]		= 0x820f2000,
+	[MT_ARB_BASE]		= 0x820f3000,
+	[MT_TMAC_BASE]		= 0x820f4000,
+	[MT_RMAC_BASE]		= 0x820f5000,
+	[MT_DMA_BASE]		= 0x820f7000,
+	[MT_PF_BASE]		= 0x820f8000,
+	[MT_WTBL_BASE_ON]	= 0x820f9000,
+	[MT_WTBL_BASE_OFF]	= 0x820f9800,
+	[MT_LPON_BASE]		= 0x820fb000,
+	[MT_MIB_BASE]		= 0x820fd000,
+};
+EXPORT_SYMBOL_GPL(mt7663_usb_sdio_reg_map);
+
+static void
+mt7663_usb_sdio_write_txwi(struct mt7615_dev *dev, struct mt76_wcid *wcid,
+			   enum mt76_txq_id qid, struct ieee80211_sta *sta,
+			   struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
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
+	mt7615_mac_write_txwi(dev, txwi, skb, wcid, sta, pid, key, false);
+	skb_push(skb, MT_USB_TXD_SIZE);
+}
+
+static int
+mt7663_usb_sdio_set_rates(struct mt7615_dev *dev,
+			  struct mt7615_wtbl_desc *wd)
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
+	sta->rate_probe = sta->rateset[rate->rateset].probe_rate.idx != -1;
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
+mt7663_usb_sdio_set_key(struct mt7615_dev *dev,
+			struct mt7615_wtbl_desc *wd)
+{
+	struct mt7615_key_desc *key = &wd->key;
+	struct mt7615_sta *sta = wd->sta;
+	enum mt7615_cipher_type cipher;
+	struct mt76_wcid *wcid;
+	int err;
+
+	lockdep_assert_held(&dev->mt76.mutex);
+
+	if (!sta) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	cipher = mt7615_mac_get_cipher(key->cipher);
+	if (cipher == MT_CIPHER_NONE) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	wcid = &wd->sta->wcid;
+
+	mt7615_mac_wtbl_update_cipher(dev, wcid, cipher, key->cmd);
+	err = mt7615_mac_wtbl_update_key(dev, wcid, key->key, key->keylen,
+					 cipher, key->cmd);
+	if (err < 0)
+		goto out;
+
+	err = mt7615_mac_wtbl_update_pk(dev, wcid, cipher, key->keyidx,
+					key->cmd);
+	if (err < 0)
+		goto out;
+
+	if (key->cmd == SET_KEY)
+		wcid->cipher |= BIT(cipher);
+	else
+		wcid->cipher &= ~BIT(cipher);
+out:
+	kfree(key->key);
+
+	return err;
+}
+
+void mt7663_usb_sdio_wtbl_work(struct work_struct *work)
+{
+	struct mt7615_wtbl_desc *wd, *wd_next;
+	struct list_head wd_list;
+	struct mt7615_dev *dev;
+
+	dev = (struct mt7615_dev *)container_of(work, struct mt7615_dev,
+						wtbl_work);
+
+	INIT_LIST_HEAD(&wd_list);
+	spin_lock_bh(&dev->mt76.lock);
+	list_splice_init(&dev->wd_head, &wd_list);
+	spin_unlock_bh(&dev->mt76.lock);
+
+	list_for_each_entry_safe(wd, wd_next, &wd_list, node) {
+		list_del(&wd->node);
+
+		mt7615_mutex_acquire(dev);
+
+		switch (wd->type) {
+		case MT7615_WTBL_RATE_DESC:
+			mt7663_usb_sdio_set_rates(dev, wd);
+			break;
+		case MT7615_WTBL_KEY_DESC:
+			mt7663_usb_sdio_set_key(dev, wd);
+			break;
+		}
+
+		mt7615_mutex_release(dev);
+
+		kfree(wd);
+	}
+}
+EXPORT_SYMBOL_GPL(mt7663_usb_sdio_wtbl_work);
+
+bool mt7663_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+
+	mt7615_mutex_acquire(dev);
+	mt7615_mac_sta_poll(dev);
+	mt7615_mutex_release(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7663_usb_sdio_tx_status_data);
+
+void mt7663_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
+				     enum mt76_txq_id qid,
+				     struct mt76_queue_entry *e)
+{
+	unsigned int headroom = MT_USB_TXD_SIZE;
+
+	if (mt76_is_usb(mdev))
+		headroom += MT_USB_HDR_SIZE;
+	skb_pull(e->skb, headroom);
+
+	mt76_tx_complete_skb(mdev, e->skb);
+}
+EXPORT_SYMBOL_GPL(mt7663_usb_sdio_tx_complete_skb);
+
+int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+				   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+				   struct ieee80211_sta *sta,
+				   struct mt76_tx_info *tx_info)
+{
+	struct mt7615_sta *msta = container_of(wcid, struct mt7615_sta, wcid);
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	struct sk_buff *skb = tx_info->skb;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+
+	if ((info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) &&
+	    !msta->rate_probe) {
+		/* request to configure sampling rate */
+		spin_lock_bh(&dev->mt76.lock);
+		mt7615_mac_set_rates(&dev->phy, msta, &info->control.rates[0],
+				     msta->rates);
+		spin_unlock_bh(&dev->mt76.lock);
+	}
+
+	mt7663_usb_sdio_write_txwi(dev, wcid, qid, sta, skb);
+	if (mt76_is_usb(mdev))
+		put_unaligned_le32(skb->len, skb_push(skb, sizeof(skb->len)));
+
+	return mt76_skb_adjust_pad(skb);
+}
+EXPORT_SYMBOL_GPL(mt7663_usb_sdio_tx_prepare_skb);
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
+static int mt7663_usb_sdio_init_hardware(struct mt7615_dev *dev)
+{
+	int ret, idx;
+
+	ret = mt7615_eeprom_init(dev, MT_EFUSE_BASE);
+	if (ret < 0)
+		return ret;
+
+	if (mt76_is_usb(&dev->mt76)) {
+		ret = mt7663u_dma_sched_init(dev);
+		if (ret)
+			return ret;
+	}
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
+int mt7663_usb_sdio_register_device(struct mt7615_dev *dev)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	int err;
+
+	INIT_WORK(&dev->wtbl_work, mt7663_usb_sdio_wtbl_work);
+	INIT_LIST_HEAD(&dev->wd_head);
+	mt7615_init_device(dev);
+
+	err = mt7663_usb_sdio_init_hardware(dev);
+	if (err)
+		return err;
+
+	/* check hw sg support in order to enable AMSDU */
+	hw->max_tx_fragments = dev->mt76.usb.sg_en ? MT_HW_TXP_MAX_BUF_NUM : 1;
+	hw->extra_tx_headroom += MT_USB_TXD_SIZE;
+	if (mt76_is_usb(&dev->mt76))
+		hw->extra_tx_headroom += MT_USB_HDR_SIZE;
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
+EXPORT_SYMBOL_GPL(mt7663_usb_sdio_register_device);
+
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.26.2

