Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DD6432A4C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhJRXWi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:22:38 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:44131 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhJRXWg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:22:36 -0400
X-UUID: 3d7715b41aad4241bf94f383eea8d6ab-20211018
X-UUID: 3d7715b41aad4241bf94f383eea8d6ab-20211018
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1589317617; Mon, 18 Oct 2021 16:20:21 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Oct 2021 16:12:37 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Oct 2021 07:12:36 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Mark-YW.Chen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v5 16/17] mt76: mt7921: introduce mt7921s support
Date:   Tue, 19 Oct 2021 07:11:46 +0800
Message-ID: <41a12b871491ed1f096e7526445c247e64a2bae9.1634598341.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1634598341.git.objelf@gmail.com>
References: <cover.1634598341.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce support for mt7921s 802.11ax (Wi-Fi 6) 2x2:2SS chipset.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/Kconfig |  10 +
 .../wireless/mediatek/mt76/mt7921/Makefile    |   2 +
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  18 +-
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  11 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  22 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |   4 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  14 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  43 +++
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  | 314 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  |  87 +++++
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  | 127 +++++++
 11 files changed, 637 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
index 071746809b1c..ce3a06227901 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
@@ -13,3 +13,13 @@ config MT7921E
 	  This adds support for MT7921E 802.11ax 2x2:2SS wireless devices.
 
 	  To compile this driver as a module, choose M here.
+
+config MT7921S
+	tristate "MediaTek MT7921S (SDIO) support"
+	select MT76_SDIO
+	select MT7921_COMMON
+	depends on MAC80211
+	help
+	  This adds support for MT7921S 802.11ax 2x2:2SS wireless devices.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index 5f32c2c71134..1187acedfeda 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -2,9 +2,11 @@
 
 obj-$(CONFIG_MT7921_COMMON) += mt7921-common.o
 obj-$(CONFIG_MT7921E) += mt7921e.o
+obj-$(CONFIG_MT7921S) += mt7921s.o
 
 CFLAGS_trace.o := -I$(src)
 
 mt7921-common-y := mac.o mcu.o main.o init.o debugfs.o trace.o
 mt7921-common-$(CONFIG_NL80211_TESTMODE) += testmode.o
 mt7921e-y := pci.o pci_mac.o pci_mcu.o dma.o
+mt7921s-y := sdio.o sdio_mac.o sdio_mcu.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 71aabb632e05..68f393c07a31 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -413,6 +413,20 @@ static int mt7921_chip_reset(void *data, u64 val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_reset, NULL, mt7921_chip_reset, "%lld\n");
 
+static int
+mt7921s_sched_quota_read(struct seq_file *s, void *data)
+{
+	struct mt7921_dev *dev = dev_get_drvdata(s->private);
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+
+	seq_printf(s, "pse_data_quota\t%d\n", sdio->sched.pse_data_quota);
+	seq_printf(s, "ple_data_quota\t%d\n", sdio->sched.ple_data_quota);
+	seq_printf(s, "pse_mcu_quota\t%d\n", sdio->sched.pse_mcu_quota);
+	seq_printf(s, "sched_deficit\t%d\n", sdio->sched.deficit);
+
+	return 0;
+}
+
 int mt7921_init_debugfs(struct mt7921_dev *dev)
 {
 	struct dentry *dir;
@@ -436,6 +450,8 @@ int mt7921_init_debugfs(struct mt7921_dev *dev)
 	debugfs_create_devm_seqfile(dev->mt76.dev, "runtime_pm_stats", dir,
 				    mt7921_pm_stats);
 	debugfs_create_file("deep-sleep", 0600, dir, dev, &fops_ds);
-
+	if (mt76_is_sdio(&dev->mt76))
+		debugfs_create_devm_seqfile(dev->mt76.dev, "sched-quota", dir,
+					    mt7921s_sched_quota_read);
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 6a4b014e8afd..2b7260be224f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -231,8 +231,15 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
-	dev->pm.enable = true;
-	dev->pm.ds_enable = true;
+
+	/* TODO: mt7921s run sleep mode on default  */
+	if (mt76_is_mmio(&dev->mt76)) {
+		dev->pm.enable = true;
+		dev->pm.ds_enable = true;
+	}
+
+	if (mt76_is_sdio(&dev->mt76))
+		hw->extra_tx_headroom += MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
 
 	ret = mt7921_init_hardware(dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index e49dfcf5558d..f5b179601030 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -843,6 +843,8 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 	struct ieee80211_vif *vif = info->control.vif;
 	struct mt76_phy *mphy = &dev->mphy;
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
+	bool is_mmio = mt76_is_mmio(&dev->mt76);
+	u32 sz_txd = is_mmio ? MT_TXD_SIZE : MT_SDIO_TXD_SIZE;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
 	u16 tx_count = 15;
 	u32 val;
@@ -858,15 +860,15 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 		p_fmt = MT_TX_TYPE_FW;
 		q_idx = MT_LMAC_BCN0;
 	} else if (skb_get_queue_mapping(skb) >= MT_TXQ_PSD) {
-		p_fmt = MT_TX_TYPE_CT;
+		p_fmt = is_mmio ? MT_TX_TYPE_CT : MT_TX_TYPE_SF;
 		q_idx = MT_LMAC_ALTX0;
 	} else {
-		p_fmt = MT_TX_TYPE_CT;
+		p_fmt = is_mmio ? MT_TX_TYPE_CT : MT_TX_TYPE_SF;
 		q_idx = wmm_idx * MT7921_MAX_WMM_SETS +
 			mt7921_lmac_mapping(dev, skb_get_queue_mapping(skb));
 	}
 
-	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + MT_TXD_SIZE) |
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + sz_txd) |
 	      FIELD_PREP(MT_TXD0_PKT_FMT, p_fmt) |
 	      FIELD_PREP(MT_TXD0_Q_IDX, q_idx);
 	txwi[0] = cpu_to_le32(val);
@@ -1384,12 +1386,18 @@ void mt7921_pm_wake_work(struct work_struct *work)
 	mphy = dev->phy.mt76;
 
 	if (!mt7921_mcu_drv_pmctrl(dev)) {
+		struct mt76_dev *mdev = &dev->mt76;
 		int i;
 
-		mt76_for_each_q_rx(&dev->mt76, i)
-			napi_schedule(&dev->mt76.napi[i]);
-		mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
-		mt7921_mcu_tx_cleanup(dev);
+		if (mt76_is_sdio(mdev)) {
+			mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
+			mt76_worker_schedule(&mdev->sdio.txrx_worker);
+		} else {
+			mt76_for_each_q_rx(mdev, i)
+				napi_schedule(&mdev->napi[i]);
+			mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
+			mt7921_mcu_tx_cleanup(dev);
+		}
 		if (test_bit(MT76_STATE_RUNNING, &mphy->state))
 			ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
 						     MT7921_WATCHDOG_TIME);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index ad2e52c97aa8..544a1c33126a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -199,6 +199,10 @@ enum tx_mcu_port_q_idx {
 
 #define MT_TXD_SIZE			(8 * 4)
 
+#define MT_SDIO_TXD_SIZE		(MT_TXD_SIZE + 8 * 4)
+#define MT_SDIO_TAIL_SIZE		8
+#define MT_SDIO_HDR_SIZE		4
+
 #define MT_TXD0_Q_IDX			GENMASK(31, 25)
 #define MT_TXD0_PKT_FMT			GENMASK(24, 23)
 #define MT_TXD0_ETH_TYPE_OFFSET		GENMASK(22, 16)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 44e74e43ee78..571f559d3363 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -650,7 +650,9 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 {
 	const struct mt7921_patch_hdr *hdr;
 	const struct firmware *fw = NULL;
-	int i, ret, sem;
+	int i, ret, sem, max_len;
+
+	max_len = mt76_is_sdio(&dev->mt76) ? 2048 : 4096;
 
 	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, true);
 	switch (sem) {
@@ -706,7 +708,7 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 		}
 
 		ret = __mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
-					       dl, len, 4096);
+					       dl, len, max_len);
 		if (ret) {
 			dev_err(dev->mt76.dev, "Failed to send patch\n");
 			goto out;
@@ -753,9 +755,11 @@ mt7921_mcu_send_ram_firmware(struct mt7921_dev *dev,
 			     const struct mt7921_fw_trailer *hdr,
 			     const u8 *data, bool is_wa)
 {
-	int i, offset = 0;
+	int i, offset = 0, max_len;
 	u32 override = 0, option = 0;
 
+	max_len = mt76_is_sdio(&dev->mt76) ? 2048 : 4096;
+
 	for (i = 0; i < hdr->n_region; i++) {
 		const struct mt7921_fw_region *region;
 		int err;
@@ -778,7 +782,7 @@ mt7921_mcu_send_ram_firmware(struct mt7921_dev *dev,
 		}
 
 		err = __mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
-					       data + offset, len, 4096);
+					       data + offset, len, max_len);
 		if (err) {
 			dev_err(dev->mt76.dev, "Failed to send firmware.\n");
 			return err;
@@ -851,7 +855,7 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
 	int ret;
 
 	ret = mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY);
-	if (ret) {
+	if (ret && mt76_is_mmio(&dev->mt76)) {
 		dev_dbg(dev->mt76.dev, "Firmware is already download\n");
 		goto fw_loaded;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index f4b85ec530bd..05e0d4371d32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -47,6 +47,29 @@
 #define MT7921_SKU_MAX_DELTA_IDX	MT7921_SKU_RATE_NUM
 #define MT7921_SKU_TABLE_SIZE		(MT7921_SKU_RATE_NUM + 1)
 
+#define MT7921_SDIO_HDR_TX_BYTES	GENMASK(15, 0)
+#define MT7921_SDIO_HDR_PKT_TYPE	GENMASK(17, 16)
+
+enum mt7921_sdio_pkt_type {
+	MT7921_SDIO_TXD,
+	MT7921_SDIO_DATA,
+	MT7921_SDIO_CMD,
+	MT7921_SDIO_FWDL,
+};
+
+struct mt7921_sdio_intr {
+	u32 isr;
+	struct {
+		u32 wtqcr[16];
+	} tx;
+	struct {
+		u16 num[2];
+		u16 len0[16];
+		u16 len1[128];
+	} rx;
+	u32 rec_mb[2];
+} __packed;
+
 #define to_rssi(field, rxv)		((FIELD_GET(field, rxv) - 220) / 2)
 #define to_rcpi(rssi)			(2 * (rssi) + 220)
 
@@ -321,6 +344,17 @@ static inline void mt7921_mcu_tx_cleanup(struct mt7921_dev *dev)
 	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WA], false);
 }
 
+static inline void mt7921_skb_add_sdio_hdr(struct sk_buff *skb,
+					   enum mt7921_sdio_pkt_type type)
+{
+	u32 hdr;
+
+	hdr = FIELD_PREP(MT7921_SDIO_HDR_TX_BYTES, skb->len + sizeof(hdr)) |
+	      FIELD_PREP(MT7921_SDIO_HDR_PKT_TYPE, type);
+
+	put_unaligned_le32(hdr, skb_push(skb, sizeof(hdr)));
+}
+
 int mt7921_mac_init(struct mt7921_dev *dev);
 bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask);
 void mt7921_mac_reset_counters(struct mt7921_phy *phy);
@@ -394,4 +428,13 @@ int mt7921e_mcu_init(struct mt7921_dev *dev);
 int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
 
+int mt7921s_mcu_init(struct mt7921_dev *dev);
+int mt7921s_mcu_drv_pmctrl(struct mt7921_dev *dev);
+int mt7921s_mcu_fw_pmctrl(struct mt7921_dev *dev);
+int mt7921s_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			   struct ieee80211_sta *sta,
+			   struct mt76_tx_info *tx_info);
+void mt7921s_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
+bool mt7921s_tx_status_data(struct mt76_dev *mdev, u8 *update);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
new file mode 100644
index 000000000000..e0ad97f27fea
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2021 MediaTek Inc.
+ *
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
+#include "mt7921.h"
+#include "../sdio.h"
+#include "mac.h"
+#include "mcu.h"
+
+static const struct sdio_device_id mt7921s_table[] = {
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, 0x7901) },
+	{ }	/* Terminating entry */
+};
+
+static void mt7921s_txrx_worker(struct mt76_worker *w)
+{
+	struct mt76_sdio *sdio = container_of(w, struct mt76_sdio,
+					      txrx_worker);
+	struct mt76_dev *mdev = container_of(sdio, struct mt76_dev, sdio);
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
+		queue_work(mdev->wq, &dev->pm.wake_work);
+		return;
+	}
+
+	mt76s_txrx_worker(sdio);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
+}
+
+static void mt7921s_unregister_device(struct mt7921_dev *dev)
+{
+	struct mt76_connac_pm *pm = &dev->pm;
+
+	mt76_unregister_device(&dev->mt76);
+	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_work_sync(&pm->wake_work);
+
+	mt76s_deinit(&dev->mt76);
+	mt7921_mcu_exit(dev);
+
+	mt76_free_device(&dev->mt76);
+}
+
+static int mt7921s_parse_intr(struct mt76_dev *dev, struct mt76s_intr *intr)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+	struct mt7921_sdio_intr *irq_data = sdio->intr_data;
+	int i, err;
+
+	err = sdio_readsb(sdio->func, irq_data, MCR_WHISR, sizeof(*irq_data));
+	if (err < 0)
+		return err;
+
+	intr->isr = irq_data->isr;
+	intr->rec_mb = irq_data->rec_mb;
+	intr->tx.wtqcr = irq_data->tx.wtqcr;
+	intr->rx.num = irq_data->rx.num;
+	for (i = 0; i < 2 ; i++) {
+		if (!i)
+			intr->rx.len[0] = irq_data->rx.len0;
+		else
+			intr->rx.len[1] = irq_data->rx.len1;
+	}
+
+	return 0;
+}
+
+static int mt7921s_probe(struct sdio_func *func,
+			 const struct sdio_device_id *id)
+{
+	static const struct mt76_driver_ops drv_ops = {
+		.txwi_size = MT_SDIO_TXD_SIZE,
+		.survey_flags = SURVEY_INFO_TIME_TX |
+				SURVEY_INFO_TIME_RX |
+				SURVEY_INFO_TIME_BSS_RX,
+		.tx_prepare_skb = mt7921s_tx_prepare_skb,
+		.tx_complete_skb = mt7921s_tx_complete_skb,
+		.tx_status_data = mt7921s_tx_status_data,
+		.rx_skb = mt7921_queue_rx_skb,
+		.sta_ps = mt7921_sta_ps,
+		.sta_add = mt7921_mac_sta_add,
+		.sta_assoc = mt7921_mac_sta_assoc,
+		.sta_remove = mt7921_mac_sta_remove,
+		.update_survey = mt7921_update_channel,
+	};
+	static const struct mt76_bus_ops mt7921s_ops = {
+		.rr = mt76s_rr,
+		.rmw = mt76s_rmw,
+		.wr = mt76s_wr,
+		.write_copy = mt76s_write_copy,
+		.read_copy = mt76s_read_copy,
+		.wr_rp = mt76s_wr_rp,
+		.rd_rp = mt76s_rd_rp,
+		.type = MT76_BUS_SDIO,
+	};
+	static const struct mt7921_hif_ops mt7921_sdio_ops = {
+		.mcu_init = mt7921s_mcu_init,
+		.drv_own = mt7921s_mcu_drv_pmctrl,
+		.fw_own = mt7921s_mcu_fw_pmctrl,
+	};
+
+	struct mt7921_dev *dev;
+	struct mt76_dev *mdev;
+	int ret, i;
+
+	mdev = mt76_alloc_device(&func->dev, sizeof(*dev), &mt7921_ops,
+				 &drv_ops);
+	if (!mdev)
+		return -ENOMEM;
+
+	dev = container_of(mdev, struct mt7921_dev, mt76);
+	dev->hif_ops = &mt7921_sdio_ops;
+
+	sdio_set_drvdata(func, dev);
+
+	ret = mt76s_init(mdev, func, &mt7921s_ops);
+	if (ret < 0)
+		goto error;
+
+	ret = mt76s_hw_init(mdev, func, MT76_CONNAC2_SDIO);
+	if (ret)
+		goto error;
+
+	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
+		    (mt76_rr(dev, MT_HW_REV) & 0xff);
+	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+
+	mdev->sdio.parse_irq = mt7921s_parse_intr;
+	mdev->sdio.intr_data = devm_kmalloc(mdev->dev,
+					    sizeof(struct mt7921_sdio_intr),
+					    GFP_KERNEL);
+	if (!mdev->sdio.intr_data) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(mdev->sdio.xmit_buf); i++) {
+		mdev->sdio.xmit_buf[i] = devm_kmalloc(mdev->dev,
+						      MT76S_XMIT_BUF_SZ,
+						      GFP_KERNEL);
+		if (!mdev->sdio.xmit_buf[i]) {
+			ret = -ENOMEM;
+			goto error;
+		}
+	}
+
+	ret = mt76s_alloc_rx_queue(mdev, MT_RXQ_MAIN);
+	if (ret)
+		goto error;
+
+	ret = mt76s_alloc_rx_queue(mdev, MT_RXQ_MCU);
+	if (ret)
+		goto error;
+
+	ret = mt76s_alloc_tx(mdev);
+	if (ret)
+		goto error;
+
+	ret = mt76_worker_setup(mt76_hw(dev), &mdev->sdio.txrx_worker,
+				mt7921s_txrx_worker, "sdio-txrx");
+	if (ret)
+		goto error;
+
+	sched_set_fifo_low(mdev->sdio.txrx_worker.task);
+
+	ret = mt7921_register_device(dev);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	mt76s_deinit(&dev->mt76);
+	mt76_free_device(&dev->mt76);
+
+	return ret;
+}
+
+static void mt7921s_remove(struct sdio_func *func)
+{
+	struct mt7921_dev *dev = sdio_get_drvdata(func);
+
+	mt7921s_unregister_device(dev);
+}
+
+#ifdef CONFIG_PM
+static int mt7921s_suspend(struct device *__dev)
+{
+	struct sdio_func *func = dev_to_sdio_func(__dev);
+	struct mt7921_dev *dev = sdio_get_drvdata(func);
+	struct mt76_connac_pm *pm = &dev->pm;
+	struct mt76_dev *mdev = &dev->mt76;
+	bool hif_suspend;
+	int err;
+
+	pm->suspended = true;
+	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_work_sync(&pm->wake_work);
+
+	err = mt7921_mcu_drv_pmctrl(dev);
+	if (err < 0)
+		goto restore_suspend;
+
+	hif_suspend = !test_bit(MT76_STATE_SUSPEND, &dev->mphy.state);
+	if (hif_suspend) {
+		err = mt76_connac_mcu_set_hif_suspend(mdev, true);
+		if (err)
+			goto restore_suspend;
+	}
+
+	/* always enable deep sleep during suspend to reduce
+	 * power consumption
+	 */
+	mt76_connac_mcu_set_deep_sleep(mdev, true);
+
+	mt76_txq_schedule_all(&dev->mphy);
+	mt76_worker_disable(&mdev->tx_worker);
+	mt76_worker_disable(&mdev->sdio.txrx_worker);
+	mt76_worker_disable(&mdev->sdio.status_worker);
+	mt76_worker_disable(&mdev->sdio.net_worker);
+	cancel_work_sync(&mdev->sdio.stat_work);
+	clear_bit(MT76_READING_STATS, &dev->mphy.state);
+
+	mt76_tx_status_check(mdev, true);
+
+	err = mt7921_mcu_fw_pmctrl(dev);
+	if (err)
+		goto restore_worker;
+
+	sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
+
+	return 0;
+
+restore_worker:
+	mt76_worker_enable(&mdev->tx_worker);
+	mt76_worker_enable(&mdev->sdio.txrx_worker);
+	mt76_worker_enable(&mdev->sdio.status_worker);
+	mt76_worker_enable(&mdev->sdio.net_worker);
+
+	if (!pm->ds_enable)
+		mt76_connac_mcu_set_deep_sleep(mdev, false);
+
+	if (hif_suspend)
+		mt76_connac_mcu_set_hif_suspend(mdev, false);
+
+restore_suspend:
+	pm->suspended = false;
+
+	return err;
+}
+
+static int mt7921s_resume(struct device *__dev)
+{
+	struct sdio_func *func = dev_to_sdio_func(__dev);
+	struct mt7921_dev *dev = sdio_get_drvdata(func);
+	struct mt76_connac_pm *pm = &dev->pm;
+	struct mt76_dev *mdev = &dev->mt76;
+	int err;
+
+	pm->suspended = false;
+
+	err = mt7921_mcu_drv_pmctrl(dev);
+	if (err < 0)
+		return err;
+
+	mt76_worker_enable(&mdev->tx_worker);
+	mt76_worker_enable(&mdev->sdio.txrx_worker);
+	mt76_worker_enable(&mdev->sdio.status_worker);
+	mt76_worker_enable(&mdev->sdio.net_worker);
+
+	/* restore previous ds setting */
+	if (!pm->ds_enable)
+		mt76_connac_mcu_set_deep_sleep(mdev, false);
+
+	if (!test_bit(MT76_STATE_SUSPEND, &dev->mphy.state))
+		err = mt76_connac_mcu_set_hif_suspend(mdev, false);
+
+	return err;
+}
+
+static const struct dev_pm_ops mt7921s_pm_ops = {
+	.suspend = mt7921s_suspend,
+	.resume = mt7921s_resume,
+};
+#endif
+
+MODULE_DEVICE_TABLE(sdio, mt7921s_table);
+MODULE_FIRMWARE(MT7921_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7921_ROM_PATCH);
+
+static struct sdio_driver mt7921s_driver = {
+	.name		= KBUILD_MODNAME,
+	.probe		= mt7921s_probe,
+	.remove		= mt7921s_remove,
+	.id_table	= mt7921s_table,
+#ifdef CONFIG_PM
+	.drv = {
+		.pm = &mt7921s_pm_ops,
+	}
+#endif
+};
+module_sdio_driver(mt7921s_driver);
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
new file mode 100644
index 000000000000..91a7acd49ee4
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2021 MediaTek Inc. */
+
+#include <linux/iopoll.h>
+#include <linux/mmc/sdio_func.h>
+#include "mt7921.h"
+#include "mac.h"
+
+static void
+mt7921s_write_txwi(struct mt7921_dev *dev, struct mt76_wcid *wcid,
+		   enum mt76_txq_id qid, struct ieee80211_sta *sta,
+		   struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	__le32 *txwi;
+	int pid;
+
+	pid = mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
+	txwi = (__le32 *)(skb->data - MT_SDIO_TXD_SIZE);
+	memset(txwi, 0, MT_SDIO_TXD_SIZE);
+	mt7921_mac_write_txwi(dev, txwi, skb, wcid, key, pid, false);
+	skb_push(skb, MT_SDIO_TXD_SIZE);
+}
+
+int mt7921s_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			   struct ieee80211_sta *sta,
+			   struct mt76_tx_info *tx_info)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct sk_buff *skb = tx_info->skb;
+	int pad;
+
+	if (unlikely(tx_info->skb->len <= ETH_HLEN))
+		return -EINVAL;
+
+	if (!wcid)
+		wcid = &dev->mt76.global_wcid;
+
+	if (sta) {
+		struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+
+		if (time_after(jiffies, msta->last_txs + HZ / 4)) {
+			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+			msta->last_txs = jiffies;
+		}
+	}
+
+	mt7921s_write_txwi(dev, wcid, qid, sta, skb);
+
+	mt7921_skb_add_sdio_hdr(skb, MT7921_SDIO_DATA);
+	pad = round_up(skb->len, 4) - skb->len;
+
+	return mt76_skb_adjust_pad(skb, pad);
+}
+
+void mt7921s_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
+{
+	__le32 *txwi = (__le32 *)(e->skb->data + MT_SDIO_HDR_SIZE);
+	unsigned int headroom = MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
+	struct ieee80211_sta *sta;
+	struct mt76_wcid *wcid;
+	u16 idx;
+
+	idx = FIELD_GET(MT_TXD1_WLAN_IDX, le32_to_cpu(txwi[1]));
+	wcid = rcu_dereference(mdev->wcid[idx]);
+	sta = wcid_to_sta(wcid);
+
+	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+		mt7921_tx_check_aggr(sta, txwi);
+
+	skb_pull(e->skb, headroom);
+	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
+}
+
+bool mt7921s_tx_status_data(struct mt76_dev *mdev, u8 *update)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	mt7921_mutex_acquire(dev);
+	mt7921_mac_sta_poll(dev);
+	mt7921_mutex_release(dev);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
new file mode 100644
index 000000000000..049e06d7c3fb
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2021 MediaTek Inc. */
+
+#include <linux/kernel.h>
+#include <linux/mmc/sdio_func.h>
+#include <linux/module.h>
+#include <linux/iopoll.h>
+
+#include "mt7921.h"
+#include "../sdio.h"
+#include "mac.h"
+#include "mcu.h"
+#include "regs.h"
+
+static int
+mt7921s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			 int cmd, int *seq)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	enum mt7921_sdio_pkt_type type = MT7921_SDIO_CMD;
+	enum mt76_mcuq_id txq = MT_MCUQ_WM;
+	int ret, pad;
+
+	ret = mt7921_mcu_fill_message(mdev, skb, cmd, seq);
+	if (ret)
+		return ret;
+
+	if (cmd == MCU_CMD_FW_SCATTER)
+		type = MT7921_SDIO_FWDL;
+
+	mt7921_skb_add_sdio_hdr(skb, type);
+	pad = round_up(skb->len, 4) - skb->len;
+	__skb_put_zero(skb, pad);
+
+	ret = mt76_tx_queue_skb_raw(dev, mdev->q_mcu[txq], skb, 0);
+	if (ret)
+		return ret;
+
+	mt76_queue_kick(dev, mdev->q_mcu[txq]);
+
+	return ret;
+}
+
+int mt7921s_mcu_init(struct mt7921_dev *dev)
+{
+	static const struct mt76_mcu_ops mt7921s_mcu_ops = {
+		.headroom = MT_SDIO_HDR_SIZE + sizeof(struct mt7921_mcu_txd),
+		.tailroom = MT_SDIO_TAIL_SIZE,
+		.mcu_skb_send_msg = mt7921s_mcu_send_message,
+		.mcu_parse_response = mt7921_mcu_parse_response,
+		.mcu_rr = mt76_connac_mcu_reg_rr,
+		.mcu_wr = mt76_connac_mcu_reg_wr,
+	};
+	int ret;
+
+	mt7921s_mcu_drv_pmctrl(dev);
+
+	dev->mt76.mcu_ops = &mt7921s_mcu_ops;
+
+	ret = mt7921_run_firmware(dev);
+	if (ret)
+		return ret;
+
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+
+	return 0;
+}
+
+int mt7921s_mcu_drv_pmctrl(struct mt7921_dev *dev)
+{
+	struct sdio_func *func = dev->mt76.sdio.func;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
+	int err = 0;
+	u32 status;
+
+	sdio_claim_host(func);
+
+	sdio_writel(func, WHLPCR_FW_OWN_REQ_CLR, MCR_WHLPCR, NULL);
+
+	err = readx_poll_timeout(mt76s_read_pcr, &dev->mt76, status,
+				 status & WHLPCR_IS_DRIVER_OWN, 2000, 1000000);
+	sdio_release_host(func);
+
+	if (err < 0) {
+		dev_err(dev->mt76.dev, "driver own failed\n");
+		err = -EIO;
+		goto out;
+	}
+
+	clear_bit(MT76_STATE_PM, &mphy->state);
+
+	pm->stats.last_wake_event = jiffies;
+	pm->stats.doze_time += pm->stats.last_wake_event -
+			       pm->stats.last_doze_event;
+out:
+	return err;
+}
+
+int mt7921s_mcu_fw_pmctrl(struct mt7921_dev *dev)
+{
+	struct sdio_func *func = dev->mt76.sdio.func;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
+	int err = 0;
+	u32 status;
+
+	sdio_claim_host(func);
+
+	sdio_writel(func, WHLPCR_FW_OWN_REQ_SET, MCR_WHLPCR, NULL);
+
+	err = readx_poll_timeout(mt76s_read_pcr, &dev->mt76, status,
+				 !(status & WHLPCR_IS_DRIVER_OWN), 2000, 1000000);
+	sdio_release_host(func);
+
+	if (err < 0) {
+		dev_err(dev->mt76.dev, "firmware own failed\n");
+		clear_bit(MT76_STATE_PM, &mphy->state);
+		err = -EIO;
+	}
+
+	pm->stats.last_doze_event = jiffies;
+	pm->stats.awake_time += pm->stats.last_doze_event -
+				pm->stats.last_wake_event;
+
+	return err;
+}
-- 
2.25.1

