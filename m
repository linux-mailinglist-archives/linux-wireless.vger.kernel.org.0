Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79D72D58D0
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Dec 2020 12:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgLJLCG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Dec 2020 06:02:06 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51594 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725885AbgLJLB7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Dec 2020 06:01:59 -0500
X-UUID: 85d0ddcfdb5b41c6bdf1f94eb120e490-20201210
X-UUID: 85d0ddcfdb5b41c6bdf1f94eb120e490-20201210
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1215310101; Thu, 10 Dec 2020 19:00:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Dec 2020 19:00:27 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Dec 2020 19:00:22 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <Eric.Liang@mediatek.com>,
        <ryder.lee@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v1] mt76: mt7921: introduce mt7921e support
Date:   Thu, 10 Dec 2020 19:00:22 +0800
Message-ID: <b24467915685771645abfd61adcbbf1341313dda.1607596773.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BA3FE960B9B3237C1036C09C98F1ED072BD7FC4600AE9C3AAFF148915866822F2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce support for mt7921e 802.11ax (Wi-Fi 6) 2x2:2SS chipset.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/Kconfig    |    1 +
 drivers/net/wireless/mediatek/mt76/Makefile   |    1 +
 .../net/wireless/mediatek/mt76/mt7921/Kconfig |   10 +
 .../wireless/mediatek/mt76/mt7921/Makefile    |    6 +
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  180 ++
 .../net/wireless/mediatek/mt76/mt7921/dma.c   |  356 +++
 .../wireless/mediatek/mt76/mt7921/eeprom.c    |  247 ++
 .../wireless/mediatek/mt76/mt7921/eeprom.h    |  126 +
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  482 +++
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 1387 +++++++++
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |  367 +++
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  854 ++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 2588 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  991 +++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  379 +++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  209 ++
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |  455 +++
 17 files changed, 8639 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/Makefile
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/dma.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/main.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/regs.h

diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
index 31015d2a8e7d..5f42ce3267cb 100644
--- a/drivers/net/wireless/mediatek/mt76/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/Kconfig
@@ -29,3 +29,4 @@ source "drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt7603/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt7615/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt7915/Kconfig"
+source "drivers/net/wireless/mediatek/mt76/mt7921/Kconfig"
diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index e53584db0756..1d72093b61a3 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_MT76x2_COMMON) += mt76x2/
 obj-$(CONFIG_MT7603E) += mt7603/
 obj-$(CONFIG_MT7615_COMMON) += mt7615/
 obj-$(CONFIG_MT7915E) += mt7915/
+obj-$(CONFIG_MT7921E) += mt7921/
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
new file mode 100644
index 000000000000..24932d2e8dee
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: ISC
+config MT7921E
+	tristate "MediaTek MT7921E (PCIe) support"
+	select MT76_CORE
+	depends on MAC80211
+	depends on PCI
+	help
+	  This adds support for MT7921E 802.11ax 2x2:2SS wireless devices.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
new file mode 100644
index 000000000000..8efd110f7ff8
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -0,0 +1,6 @@
+#SPDX-License-Identifier: ISC
+
+obj-$(CONFIG_MT7921E) += mt7921e.o
+
+mt7921e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o \
+	     debugfs.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
new file mode 100644
index 000000000000..ad2379e7b9f7
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include "mt7921.h"
+#include "eeprom.h"
+
+static int
+mt7921_fw_debug_set(void *data, u64 val)
+{
+	struct mt7921_dev *dev = data;
+
+	dev->fw_debug = (u8)val;
+
+	mt7921_mcu_fw_log_2_host(dev, dev->fw_debug);
+
+	return 0;
+}
+
+static int
+mt7921_fw_debug_get(void *data, u64 *val)
+{
+	struct mt7921_dev *dev = data;
+
+	*val = dev->fw_debug;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug, mt7921_fw_debug_get,
+			 mt7921_fw_debug_set, "%lld\n");
+
+static void
+mt7921_ampdu_stat_read_phy(struct mt7921_phy *phy,
+			   struct seq_file *file)
+{
+	struct mt7921_dev *dev = file->private;
+	bool ext_phy = phy != &dev->phy;
+	int bound[15], range[4], i, n;
+
+	if (!phy)
+		return;
+
+	/* Tx ampdu stat */
+	for (i = 0; i < ARRAY_SIZE(range); i++)
+		range[i] = mt76_rr(dev, MT_MIB_ARNG(ext_phy, i));
+
+	for (i = 0; i < ARRAY_SIZE(bound); i++)
+		bound[i] = MT_MIB_ARNCR_RANGE(range[i / 4], i) + 1;
+
+	seq_printf(file, "\nPhy %d\n", ext_phy);
+
+	seq_printf(file, "Length: %8d | ", bound[0]);
+	for (i = 0; i < ARRAY_SIZE(bound) - 1; i++)
+		seq_printf(file, "%3d -%3d | ",
+			   bound[i] + 1, bound[i + 1]);
+
+	seq_puts(file, "\nCount:  ");
+	n = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
+	for (i = 0; i < ARRAY_SIZE(bound); i++)
+		seq_printf(file, "%8d | ", dev->mt76.aggr_stats[i + n]);
+	seq_puts(file, "\n");
+
+	seq_printf(file, "BA miss count: %d\n", phy->mib.ba_miss_cnt);
+}
+
+static int
+mt7921_tx_stats_read(struct seq_file *file, void *data)
+{
+	struct mt7921_dev *dev = file->private;
+	int stat[8], i, n;
+
+	mt7921_ampdu_stat_read_phy(&dev->phy, file);
+
+	/* Tx amsdu info */
+	seq_puts(file, "Tx MSDU stat:\n");
+	for (i = 0, n = 0; i < ARRAY_SIZE(stat); i++) {
+		stat[i] = mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
+		n += stat[i];
+	}
+
+	for (i = 0; i < ARRAY_SIZE(stat); i++) {
+		seq_printf(file, "AMSDU pack count of %d MSDU in TXD: 0x%x ",
+			   i + 1, stat[i]);
+		if (n != 0)
+			seq_printf(file, "(%d%%)\n", stat[i] * 100 / n);
+		else
+			seq_puts(file, "\n");
+	}
+
+	return 0;
+}
+
+static int
+mt7921_tx_stats_open(struct inode *inode, struct file *f)
+{
+	return single_open(f, mt7921_tx_stats_read, inode->i_private);
+}
+
+static const struct file_operations fops_tx_stats = {
+	.open = mt7921_tx_stats_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
+static int
+mt7921_queues_acq(struct seq_file *s, void *data)
+{
+	struct mt7921_dev *dev = dev_get_drvdata(s->private);
+	int i;
+
+	for (i = 0; i < 16; i++) {
+		int j, acs = i / 4, index = i % 4;
+		u32 ctrl, val, qlen = 0;
+
+		val = mt76_rr(dev, MT_PLE_AC_QEMPTY(acs, index));
+		ctrl = BIT(31) | BIT(15) | (acs << 8);
+
+		for (j = 0; j < 32; j++) {
+			if (val & BIT(j))
+				continue;
+
+			mt76_wr(dev, MT_PLE_FL_Q0_CTRL,
+				ctrl | (j + (index << 5)));
+			qlen += mt76_get_field(dev, MT_PLE_FL_Q3_CTRL,
+					       GENMASK(11, 0));
+		}
+		seq_printf(s, "AC%d%d: queued=%d\n", acs, index, qlen);
+	}
+
+	return 0;
+}
+
+static int
+mt7921_queues_read(struct seq_file *s, void *data)
+{
+	struct mt7921_dev *dev = dev_get_drvdata(s->private);
+	struct {
+		struct mt76_queue *q;
+		char *queue;
+	} queue_map[] = {
+		{ dev->mphy.q_tx[MT_TXQ_BE],	 "WFDMA0" },
+		{ dev->mt76.q_mcu[MT_MCUQ_WM],	 "MCUWM"  },
+		{ dev->mt76.q_mcu[MT_MCUQ_FWDL], "MCUFWQ" },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(queue_map); i++) {
+		struct mt76_queue *q = queue_map[i].q;
+
+		if (!q)
+			continue;
+
+		seq_printf(s,
+			   "%s:	queued=%d head=%d tail=%d\n",
+			   queue_map[i].queue, q->queued, q->head,
+			   q->tail);
+	}
+
+	return 0;
+}
+
+int mt7921_init_debugfs(struct mt7921_dev *dev)
+{
+	struct dentry *dir;
+
+	dir = mt76_register_debugfs(&dev->mt76);
+	if (!dir)
+		return -ENOMEM;
+
+	debugfs_create_devm_seqfile(dev->mt76.dev, "queues", dir,
+				    mt7921_queues_read);
+	debugfs_create_devm_seqfile(dev->mt76.dev, "acq", dir,
+				    mt7921_queues_acq);
+	debugfs_create_file("tx_stats", 0400, dir, dev, &fops_tx_stats);
+	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
new file mode 100644
index 000000000000..cd9665610284
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include "mt7921.h"
+#include "../dma.h"
+#include "mac.h"
+
+int mt7921_init_tx_queues(struct mt7921_phy *phy, int idx, int n_desc)
+{
+	int i, err;
+
+	err = mt76_init_tx_queue(phy->mt76, 0, idx, n_desc, MT_TX_RING_BASE);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i <= MT_TXQ_PSD; i++)
+		phy->mt76->q_tx[i] = phy->mt76->q_tx[0];
+
+	return 0;
+}
+
+void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			 struct sk_buff *skb)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	__le32 *rxd = (__le32 *)skb->data;
+	enum rx_pkt_type type;
+	u16 flag;
+
+	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
+	flag = FIELD_GET(MT_RXD0_PKT_FLAG, le32_to_cpu(rxd[0]));
+
+	if (type == PKT_TYPE_RX_EVENT && flag == 0x1)
+		type = PKT_TYPE_NORMAL_MCU;
+
+	switch (type) {
+	case PKT_TYPE_TXRX_NOTIFY:
+		mt7921_mac_tx_free(dev, skb);
+		break;
+	case PKT_TYPE_RX_EVENT:
+		mt7921_mcu_rx_event(dev, skb);
+		break;
+	case PKT_TYPE_NORMAL_MCU:
+	case PKT_TYPE_NORMAL:
+		if (!mt7921_mac_fill_rx(dev, skb)) {
+			mt76_rx(&dev->mt76, q, skb);
+			return;
+		}
+		fallthrough;
+	default:
+		dev_kfree_skb(skb);
+		break;
+	}
+}
+
+static void
+mt7921_tx_cleanup(struct mt7921_dev *dev)
+{
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], false);
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WA], false);
+}
+
+static int mt7921_poll_tx(struct napi_struct *napi, int budget)
+{
+	struct mt7921_dev *dev;
+
+	dev = container_of(napi, struct mt7921_dev, mt76.tx_napi);
+
+	mt7921_tx_cleanup(dev);
+
+	if (napi_complete_done(napi, 0))
+		mt7921_irq_enable(dev, MT_INT_TX_DONE_ALL);
+
+	return 0;
+}
+
+void mt7921_dma_prefetch(struct mt7921_dev *dev)
+{
+#define PREFETCH(base, depth)	((base) << 16 | (depth))
+
+	mt76_wr(dev, MT_WFDMA0_RX_RING0_EXT_CTRL, PREFETCH(0x0, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING2_EXT_CTRL, PREFETCH(0x40, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING3_EXT_CTRL, PREFETCH(0x80, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING4_EXT_CTRL, PREFETCH(0xc0, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING5_EXT_CTRL, PREFETCH(0x100, 0x4));
+
+	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, PREFETCH(0x140, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING1_EXT_CTRL, PREFETCH(0x180, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING2_EXT_CTRL, PREFETCH(0x1c0, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING3_EXT_CTRL, PREFETCH(0x200, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING4_EXT_CTRL, PREFETCH(0x240, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING5_EXT_CTRL, PREFETCH(0x280, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING6_EXT_CTRL, PREFETCH(0x2c0, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING16_EXT_CTRL, PREFETCH(0x340, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING17_EXT_CTRL, PREFETCH(0x380, 0x4));
+}
+
+static u32 __mt7921_reg_addr(struct mt7921_dev *dev, u32 addr)
+{
+	static const struct {
+		u32 phys;
+		u32 mapped;
+		u32 size;
+	} fixed_map[] = {
+		{ 0x00400000, 0x80000, 0x10000}, /* WF_MCU_SYSRAM */
+		{ 0x00410000, 0x90000, 0x10000}, /* WF_MCU_SYSRAM (configure register) */
+		{ 0x40000000, 0x70000, 0x10000}, /* WF_UMAC_SYSRAM */
+		{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA PCIE0 MCU DMA0 */
+		{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA PCIE0 MCU DMA1 */
+		{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
+		{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 */
+		{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
+		{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
+		{ 0x7c060000, 0xe0000, 0x10000}, /* CONN_INFRA, conn_host_csr_top */
+		{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
+		{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
+		{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
+		{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
+		{ 0x820cc000, 0x0e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
+		{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
+		{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
+		{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
+		{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
+		{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
+		{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
+		{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
+		{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
+		{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
+		{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
+		{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
+		{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
+		{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
+		{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
+		{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
+		{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
+		{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
+		{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
+		{ 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
+		{ 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
+		{ 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
+		{ 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
+		{ 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
+		{ 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
+		{ 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
+		{ 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
+		{ 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
+	};
+	int i;
+
+	if (addr < 0x100000)
+		return addr;
+
+	for (i = 0; i < ARRAY_SIZE(fixed_map); i++) {
+		u32 ofs;
+
+		if (addr < fixed_map[i].phys)
+			continue;
+
+		ofs = addr - fixed_map[i].phys;
+		if (ofs > fixed_map[i].size)
+			continue;
+
+		return fixed_map[i].mapped + ofs;
+	}
+
+	if ((addr >= 0x18000000 && addr < 0x18c00000) ||
+	    (addr >= 0x70000000 && addr < 0x78000000) ||
+	    (addr >= 0x7c000000 && addr < 0x7c400000))
+		return mt7921_reg_map_l1(dev, addr);
+
+	dev_err(dev->mt76.dev, "Access currently unsupported address %08x\n",
+		addr);
+
+	return 0;
+}
+
+static u32 mt7921_rr(struct mt76_dev *mdev, u32 offset)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	u32 addr = __mt7921_reg_addr(dev, offset);
+
+	return dev->bus_ops->rr(mdev, addr);
+}
+
+static void mt7921_wr(struct mt76_dev *mdev, u32 offset, u32 val)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	u32 addr = __mt7921_reg_addr(dev, offset);
+
+	dev->bus_ops->wr(mdev, addr, val);
+}
+
+static u32 mt7921_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	u32 addr = __mt7921_reg_addr(dev, offset);
+
+	return dev->bus_ops->rmw(mdev, addr, mask, val);
+}
+
+static int mt7921_dmashdl_disabled(struct mt7921_dev *dev)
+{
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG_EXT0, MT_WFDMA0_CSR_TX_DMASHDL_ENABLE);
+	mt76_set(dev, MT_DMASHDL_SW_CONTROL, MT_DMASHDL_DMASHDL_BYPASS);
+
+	return 0;
+}
+
+int mt7921_dma_init(struct mt7921_dev *dev)
+{
+	/* Increase buffer size to receive large VHT/HE MPDUs */
+	struct mt76_bus_ops *bus_ops;
+	int rx_buf_size = MT_RX_BUF_SIZE * 2;
+	int ret;
+
+	dev->bus_ops = dev->mt76.bus;
+	bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
+			       GFP_KERNEL);
+	if (!bus_ops)
+		return -ENOMEM;
+
+	bus_ops->rr = mt7921_rr;
+	bus_ops->wr = mt7921_wr;
+	bus_ops->rmw = mt7921_rmw;
+	dev->mt76.bus = bus_ops;
+
+	mt76_dma_attach(&dev->mt76);
+
+	/* reset */
+	mt76_clear(dev, MT_WFDMA0_RST,
+		   MT_WFDMA0_RST_DMASHDL_ALL_RST |
+		   MT_WFDMA0_RST_LOGIC_RST);
+
+	mt76_set(dev, MT_WFDMA0_RST,
+		 MT_WFDMA0_RST_DMASHDL_ALL_RST |
+		 MT_WFDMA0_RST_LOGIC_RST);
+
+	ret = mt7921_dmashdl_disabled(dev);
+	if (ret)
+		return ret;
+
+	/* disable WFDMA0 */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
+		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+	mt76_poll(dev, MT_WFDMA0_GLO_CFG,
+		  MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
+		  MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 1000);
+
+	/* init tx queue */
+	ret = mt7921_init_tx_queues(&dev->phy, MT7921_TXQ_BAND0,
+				    MT7921_TX_RING_SIZE);
+	if (ret)
+		return ret;
+
+	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, 0x4);
+
+	/* command to WM */
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM, MT7921_TXQ_MCU_WM,
+				  MT7921_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* firmware download */
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_FWDL, MT7921_TXQ_FWDL,
+				  MT7921_TX_FWDL_RING_SIZE, MT_TX_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* event from WM before firmware download */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU],
+			       MT7921_RXQ_MCU_WM,
+			       MT7921_RX_MCU_RING_SIZE,
+			       rx_buf_size, MT_RX_EVENT_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* Change mcu queue after firmware download */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
+			       MT7921_RXQ_MCU_WM,
+			       MT7921_RX_MCU_RING_SIZE,
+			       rx_buf_size, MT_WFDMA0(0x540));
+	if (ret)
+		return ret;
+
+	/* rx data */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
+			       MT7921_RXQ_BAND0, MT7921_RX_RING_SIZE,
+			       rx_buf_size, MT_RX_DATA_RING_BASE);
+	if (ret)
+		return ret;
+
+	ret = mt76_init_queues(dev);
+	if (ret < 0)
+		return ret;
+
+	netif_tx_napi_add(&dev->mt76.napi_dev, &dev->mt76.tx_napi,
+			  mt7921_poll_tx, NAPI_POLL_WEIGHT);
+	napi_enable(&dev->mt76.tx_napi);
+
+	/* configure perfetch settings */
+	mt7921_dma_prefetch(dev);
+
+	/* reset dma idx */
+	mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR, ~0);
+
+	/* configure delay interrupt */
+	mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG0, 0);
+
+	mt76_set(dev, MT_WFDMA0_GLO_CFG,
+		 MT_WFDMA0_GLO_CFG_TX_WB_DDONE |
+		 MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN |
+		 MT_WFDMA0_GLO_CFG_CLK_GAT_DIS |
+		 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		 MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
+		 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+	mt76_set(dev, MT_WFDMA0_GLO_CFG,
+		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	mt76_set(dev, 0x54000120, BIT(1));
+
+	/* enable interrupts for TX/RX rings */
+	mt7921_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
+			  MT_INT_MCU_CMD);
+
+	return 0;
+}
+
+void mt7921_dma_cleanup(struct mt7921_dev *dev)
+{
+	/* disable */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
+		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+	/* reset */
+	mt76_clear(dev, MT_WFDMA0_RST,
+		   MT_WFDMA0_RST_DMASHDL_ALL_RST |
+		   MT_WFDMA0_RST_LOGIC_RST);
+
+	mt76_set(dev, MT_WFDMA0_RST,
+		 MT_WFDMA0_RST_DMASHDL_ALL_RST |
+		 MT_WFDMA0_RST_LOGIC_RST);
+
+	mt76_dma_cleanup(&dev->mt76);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
new file mode 100644
index 000000000000..833fe9afd2b1
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include "mt7921.h"
+#include "eeprom.h"
+
+static u32 mt7921_eeprom_read(struct mt7921_dev *dev, u32 offset)
+{
+	u8 *data = dev->mt76.eeprom.data;
+
+	if (data[offset] == 0xff)
+		mt7921_mcu_get_eeprom(dev, offset);
+
+	return data[offset];
+}
+
+static int mt7921_eeprom_load(struct mt7921_dev *dev)
+{
+	int ret;
+
+	ret = mt76_eeprom_init(&dev->mt76, MT7921_EEPROM_SIZE);
+	if (ret < 0)
+		return ret;
+
+	memset(dev->mt76.eeprom.data, -1, MT7921_EEPROM_SIZE);
+
+	return 0;
+}
+
+static int mt7921_check_eeprom(struct mt7921_dev *dev)
+{
+	u8 *eeprom = dev->mt76.eeprom.data;
+	u16 val;
+
+	mt7921_eeprom_read(dev, MT_EE_CHIP_ID);
+	val = get_unaligned_le16(eeprom);
+
+	switch (val) {
+	case 0x7961:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+void mt7921_eeprom_parse_band_config(struct mt7921_phy *phy)
+{
+	struct mt7921_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+	u32 val;
+
+	val = mt7921_eeprom_read(dev, MT_EE_WIFI_CONF + ext_phy);
+	val = FIELD_GET(MT_EE_WIFI_CONF_BAND_SEL, val);
+	switch (val) {
+	case MT_EE_5GHZ:
+		phy->mt76->cap.has_5ghz = true;
+		break;
+	case MT_EE_2GHZ:
+		phy->mt76->cap.has_2ghz = true;
+		break;
+	default:
+		phy->mt76->cap.has_2ghz = true;
+		phy->mt76->cap.has_5ghz = true;
+		break;
+	}
+}
+
+static void mt7921_eeprom_parse_hw_cap(struct mt7921_dev *dev)
+{
+	u8 tx_mask, *eeprom = dev->mt76.eeprom.data;
+
+	mt7921_eeprom_parse_band_config(&dev->phy);
+
+	/* read tx mask from eeprom */
+	tx_mask = FIELD_GET(MT_EE_WIFI_CONF_TX_MASK, eeprom[MT_EE_WIFI_CONF]);
+	if (!tx_mask || tx_mask > 4)
+		tx_mask = 4;
+
+	/* Should fix eeprom */
+	tx_mask = 2;
+	dev->chainmask = BIT(tx_mask) - 1;
+	dev->mphy.antenna_mask = dev->chainmask;
+	dev->phy.chainmask = dev->mphy.antenna_mask;
+}
+
+int mt7921_eeprom_init(struct mt7921_dev *dev)
+{
+	int ret;
+
+	ret = mt7921_eeprom_load(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = mt7921_check_eeprom(dev);
+	if (ret)
+		return ret;
+
+	mt7921_eeprom_parse_hw_cap(dev);
+	memcpy(dev->mphy.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
+	       ETH_ALEN);
+
+	mt76_eeprom_override(&dev->mphy);
+
+	return 0;
+}
+
+int mt7921_eeprom_get_target_power(struct mt7921_dev *dev,
+				   struct ieee80211_channel *chan,
+				   u8 chain_idx)
+{
+	int index;
+	bool tssi_on;
+
+	if (chain_idx > 3)
+		return -EINVAL;
+
+	tssi_on = mt7921_tssi_enabled(dev, chan->band);
+
+	if (chan->band == NL80211_BAND_2GHZ) {
+		index = MT_EE_TX0_POWER_2G + chain_idx * 3 + !tssi_on;
+	} else {
+		int group = tssi_on ?
+			    mt7921_get_channel_group(chan->hw_value) : 8;
+
+		index = MT_EE_TX0_POWER_5G + chain_idx * 12 + group;
+	}
+
+	return mt7921_eeprom_read(dev, index);
+}
+
+static const u8 sku_cck_delta_map[] = {
+	SKU_CCK_GROUP0,
+	SKU_CCK_GROUP0,
+	SKU_CCK_GROUP1,
+	SKU_CCK_GROUP1,
+};
+
+static const u8 sku_ofdm_delta_map[] = {
+	SKU_OFDM_GROUP0,
+	SKU_OFDM_GROUP0,
+	SKU_OFDM_GROUP1,
+	SKU_OFDM_GROUP1,
+	SKU_OFDM_GROUP2,
+	SKU_OFDM_GROUP2,
+	SKU_OFDM_GROUP3,
+	SKU_OFDM_GROUP4,
+};
+
+static const u8 sku_mcs_delta_map[] = {
+	SKU_MCS_GROUP0,
+	SKU_MCS_GROUP1,
+	SKU_MCS_GROUP1,
+	SKU_MCS_GROUP2,
+	SKU_MCS_GROUP2,
+	SKU_MCS_GROUP3,
+	SKU_MCS_GROUP4,
+	SKU_MCS_GROUP5,
+	SKU_MCS_GROUP6,
+	SKU_MCS_GROUP7,
+	SKU_MCS_GROUP8,
+	SKU_MCS_GROUP9,
+};
+
+#define SKU_GROUP(_mode, _len, _ofs_2g, _ofs_5g, _map)	\
+	[_mode] = {					\
+	.len = _len,					\
+	.offset = {					\
+		_ofs_2g,				\
+		_ofs_5g,				\
+	},						\
+	.delta_map = _map				\
+}
+
+const struct sku_group mt7921_sku_groups[] = {
+	SKU_GROUP(SKU_CCK, 4, 0x252, 0, sku_cck_delta_map),
+	SKU_GROUP(SKU_OFDM, 8, 0x254, 0x29d, sku_ofdm_delta_map),
+
+	SKU_GROUP(SKU_HT_BW20, 8, 0x259, 0x2a2, sku_mcs_delta_map),
+	SKU_GROUP(SKU_HT_BW40, 9, 0x262, 0x2ab, sku_mcs_delta_map),
+	SKU_GROUP(SKU_VHT_BW20, 12, 0x259, 0x2a2, sku_mcs_delta_map),
+	SKU_GROUP(SKU_VHT_BW40, 12, 0x262, 0x2ab, sku_mcs_delta_map),
+	SKU_GROUP(SKU_VHT_BW80, 12, 0, 0x2b4, sku_mcs_delta_map),
+	SKU_GROUP(SKU_VHT_BW160, 12, 0, 0, sku_mcs_delta_map),
+
+	SKU_GROUP(SKU_HE_RU26, 12, 0x27f, 0x2dd, sku_mcs_delta_map),
+	SKU_GROUP(SKU_HE_RU52, 12, 0x289, 0x2e7, sku_mcs_delta_map),
+	SKU_GROUP(SKU_HE_RU106, 12, 0x293, 0x2f1, sku_mcs_delta_map),
+	SKU_GROUP(SKU_HE_RU242, 12, 0x26b, 0x2bf, sku_mcs_delta_map),
+	SKU_GROUP(SKU_HE_RU484, 12, 0x275, 0x2c9, sku_mcs_delta_map),
+	SKU_GROUP(SKU_HE_RU996, 12, 0, 0x2d3, sku_mcs_delta_map),
+	SKU_GROUP(SKU_HE_RU2x996, 12, 0, 0, sku_mcs_delta_map),
+};
+
+static s8
+mt7921_get_sku_delta(struct mt7921_dev *dev, u32 addr)
+{
+	u32 val = mt7921_eeprom_read(dev, addr);
+	s8 delta = FIELD_GET(SKU_DELTA_VAL, val);
+
+	if (!(val & SKU_DELTA_EN))
+		return 0;
+
+	return val & SKU_DELTA_ADD ? delta : -delta;
+}
+
+static void
+mt7921_eeprom_init_sku_band(struct mt7921_dev *dev,
+			    struct ieee80211_supported_band *sband)
+{
+	int i, band = sband->band;
+	s8 *rate_power = dev->rate_power[band], max_delta = 0;
+	u8 idx = 0;
+
+	for (i = 0; i < ARRAY_SIZE(mt7921_sku_groups); i++) {
+		const struct sku_group *sku = &mt7921_sku_groups[i];
+		u32 offset = sku->offset[band];
+		int j;
+
+		if (!offset) {
+			idx += sku->len;
+			continue;
+		}
+
+		rate_power[idx++] = mt7921_get_sku_delta(dev, offset);
+		if (rate_power[idx - 1] > max_delta)
+			max_delta = rate_power[idx - 1];
+
+		if (i == SKU_HT_BW20 || i == SKU_VHT_BW20)
+			offset += 1;
+
+		for (j = 1; j < sku->len; j++) {
+			u32 addr = offset + sku->delta_map[j];
+
+			rate_power[idx++] = mt7921_get_sku_delta(dev, addr);
+			if (rate_power[idx - 1] > max_delta)
+				max_delta = rate_power[idx - 1];
+		}
+	}
+
+	rate_power[idx] = max_delta;
+}
+
+void mt7921_eeprom_init_sku(struct mt7921_dev *dev)
+{
+	mt7921_eeprom_init_sku_band(dev, &dev->mphy.sband_2g.sband);
+	mt7921_eeprom_init_sku_band(dev, &dev->mphy.sband_5g.sband);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h
new file mode 100644
index 000000000000..0f6bb1e20210
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7921_EEPROM_H
+#define __MT7921_EEPROM_H
+
+#include "mt7921.h"
+
+struct cal_data {
+	u8 count;
+	u16 offset[60];
+};
+
+enum mt7921_eeprom_field {
+	MT_EE_CHIP_ID =		0x000,
+	MT_EE_VERSION =		0x002,
+	MT_EE_MAC_ADDR =	0x004,
+	MT_EE_MAC_ADDR2 =	0x00a,
+	MT_EE_DDIE_FT_VERSION =	0x050,
+	MT_EE_WIFI_CONF =	0x190,
+	MT_EE_TX0_POWER_2G =	0x2fc,
+	MT_EE_TX0_POWER_5G =	0x34b,
+	MT_EE_ADIE_FT_VERSION =	0x9a0,
+
+	__MT_EE_MAX =		0xe00
+};
+
+#define MT_EE_WIFI_CONF_TX_MASK			GENMASK(2, 0)
+#define MT_EE_WIFI_CONF_BAND_SEL		GENMASK(7, 6)
+#define MT_EE_WIFI_CONF_TSSI0_2G		BIT(0)
+#define MT_EE_WIFI_CONF_TSSI0_5G		BIT(2)
+#define MT_EE_WIFI_CONF_TSSI1_5G		BIT(4)
+
+enum mt7921_eeprom_band {
+	MT_EE_DUAL_BAND,
+	MT_EE_5GHZ,
+	MT_EE_2GHZ,
+	MT_EE_DBDC,
+};
+
+#define SKU_DELTA_VAL		GENMASK(5, 0)
+#define SKU_DELTA_ADD		BIT(6)
+#define SKU_DELTA_EN		BIT(7)
+
+enum mt7921_sku_delta_group {
+	SKU_CCK_GROUP0,
+	SKU_CCK_GROUP1,
+
+	SKU_OFDM_GROUP0 = 0,
+	SKU_OFDM_GROUP1,
+	SKU_OFDM_GROUP2,
+	SKU_OFDM_GROUP3,
+	SKU_OFDM_GROUP4,
+
+	SKU_MCS_GROUP0 = 0,
+	SKU_MCS_GROUP1,
+	SKU_MCS_GROUP2,
+	SKU_MCS_GROUP3,
+	SKU_MCS_GROUP4,
+	SKU_MCS_GROUP5,
+	SKU_MCS_GROUP6,
+	SKU_MCS_GROUP7,
+	SKU_MCS_GROUP8,
+	SKU_MCS_GROUP9,
+};
+
+enum mt7921_sku_rate_group {
+	SKU_CCK,
+	SKU_OFDM,
+	SKU_HT_BW20,
+	SKU_HT_BW40,
+	SKU_VHT_BW20,
+	SKU_VHT_BW40,
+	SKU_VHT_BW80,
+	SKU_VHT_BW160,
+	SKU_HE_RU26,
+	SKU_HE_RU52,
+	SKU_HE_RU106,
+	SKU_HE_RU242,
+	SKU_HE_RU484,
+	SKU_HE_RU996,
+	SKU_HE_RU2x996,
+	MAX_SKU_RATE_GROUP_NUM,
+};
+
+struct sku_group {
+	u8 len;
+	u16 offset[2];
+	const u8 *delta_map;
+};
+
+static inline int
+mt7921_get_channel_group(int channel)
+{
+	if (channel >= 184 && channel <= 196)
+		return 0;
+	if (channel <= 48)
+		return 1;
+	if (channel <= 64)
+		return 2;
+	if (channel <= 96)
+		return 3;
+	if (channel <= 112)
+		return 4;
+	if (channel <= 128)
+		return 5;
+	if (channel <= 144)
+		return 6;
+	return 7;
+}
+
+static inline bool
+mt7921_tssi_enabled(struct mt7921_dev *dev, enum nl80211_band band)
+{
+	u8 *eep = dev->mt76.eeprom.data;
+
+	/* TODO: DBDC */
+	if (band == NL80211_BAND_5GHZ)
+		return eep[MT_EE_WIFI_CONF + 7] & MT_EE_WIFI_CONF_TSSI0_5G;
+	else
+		return eep[MT_EE_WIFI_CONF + 7] & MT_EE_WIFI_CONF_TSSI0_2G;
+}
+
+extern const struct sku_group mt7921_sku_groups[];
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
new file mode 100644
index 000000000000..c419026a03c1
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/etherdevice.h>
+#include "mt7921.h"
+#include "mac.h"
+#include "eeprom.h"
+
+#define CCK_RATE(_idx, _rate) {						\
+	.bitrate = _rate,						\
+	.flags = IEEE80211_RATE_SHORT_PREAMBLE,				\
+	.hw_value = (MT_PHY_TYPE_CCK << 8) | (_idx),			\
+	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (4 + (_idx)),	\
+}
+
+#define OFDM_RATE(_idx, _rate) {					\
+	.bitrate = _rate,						\
+	.hw_value = (MT_PHY_TYPE_OFDM << 8) | (_idx),			\
+	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
+}
+
+static struct ieee80211_rate mt7921_rates[] = {
+	CCK_RATE(0, 10),
+	CCK_RATE(1, 20),
+	CCK_RATE(2, 55),
+	CCK_RATE(3, 110),
+	OFDM_RATE(11, 60),
+	OFDM_RATE(15, 90),
+	OFDM_RATE(10, 120),
+	OFDM_RATE(14, 180),
+	OFDM_RATE(9,  240),
+	OFDM_RATE(13, 360),
+	OFDM_RATE(8,  480),
+	OFDM_RATE(12, 540),
+};
+
+static const struct ieee80211_iface_limit if_limits[] = {
+	{
+		.max = MT7921_MAX_INTERFACES,
+		.types = BIT(NL80211_IFTYPE_STATION)
+	}
+};
+
+static const struct ieee80211_iface_combination if_comb[] = {
+	{
+		.limits = if_limits,
+		.n_limits = ARRAY_SIZE(if_limits),
+		.max_interfaces = MT7921_MAX_INTERFACES,
+		.num_different_channels = 1,
+		.beacon_int_infra_match = true,
+		.radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+				       BIT(NL80211_CHAN_WIDTH_20) |
+				       BIT(NL80211_CHAN_WIDTH_40) |
+				       BIT(NL80211_CHAN_WIDTH_80) |
+				       BIT(NL80211_CHAN_WIDTH_160) |
+				       BIT(NL80211_CHAN_WIDTH_80P80),
+	}
+};
+
+static void
+mt7921_init_wiphy(struct ieee80211_hw *hw)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct wiphy *wiphy = hw->wiphy;
+
+	hw->queues = 4;
+	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
+	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
+
+	phy->slottime = 9;
+
+	hw->sta_data_size = sizeof(struct mt7921_sta);
+	hw->vif_data_size = sizeof(struct mt7921_vif);
+
+	wiphy->iface_combinations = if_comb;
+	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
+	wiphy->max_scan_ie_len = MT7921_SCAN_IE_LEN;
+	wiphy->max_scan_ssids = 4;
+	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
+
+	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
+	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+
+	hw->max_tx_fragments = 4;
+}
+
+static void
+mt7921_mac_init_band(struct mt7921_dev *dev, u8 band)
+{
+	u32 mask, set;
+
+	mt76_rmw_field(dev, MT_TMAC_CTCR0(band),
+		       MT_TMAC_CTCR0_INS_DDLMT_REFTIME, 0x3f);
+	mt76_set(dev, MT_TMAC_CTCR0(band),
+		 MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN |
+		 MT_TMAC_CTCR0_INS_DDLMT_EN);
+
+	mask = MT_MDP_RCFR0_MCU_RX_MGMT |
+	       MT_MDP_RCFR0_MCU_RX_CTL_NON_BAR |
+	       MT_MDP_RCFR0_MCU_RX_CTL_BAR;
+	set = FIELD_PREP(MT_MDP_RCFR0_MCU_RX_MGMT, MT_MDP_TO_HIF) |
+	      FIELD_PREP(MT_MDP_RCFR0_MCU_RX_CTL_NON_BAR, MT_MDP_TO_HIF) |
+	      FIELD_PREP(MT_MDP_RCFR0_MCU_RX_CTL_BAR, MT_MDP_TO_HIF);
+	mt76_rmw(dev, MT_MDP_BNRCFR0(band), mask, set);
+
+	mask = MT_MDP_RCFR1_MCU_RX_BYPASS |
+	       MT_MDP_RCFR1_RX_DROPPED_UCAST |
+	       MT_MDP_RCFR1_RX_DROPPED_MCAST;
+	set = FIELD_PREP(MT_MDP_RCFR1_MCU_RX_BYPASS, MT_MDP_TO_HIF) |
+	      FIELD_PREP(MT_MDP_RCFR1_RX_DROPPED_UCAST, MT_MDP_TO_HIF) |
+	      FIELD_PREP(MT_MDP_RCFR1_RX_DROPPED_MCAST, MT_MDP_TO_HIF);
+	mt76_rmw(dev, MT_MDP_BNRCFR1(band), mask, set);
+
+	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
+	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
+
+	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 1536);
+	/* disable rx rate report by default due to hw issues */
+	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
+}
+
+static void mt7921_mac_init(struct mt7921_dev *dev)
+{
+	int i;
+
+	mt76_rmw_field(dev, MT_MDP_DCR1, MT_MDP_DCR1_MAX_RX_LEN, 1536);
+	/* disable hardware de-agg */
+	mt76_clear(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
+
+	for (i = 0; i < MT7921_WTBL_SIZE; i++)
+		mt7921_mac_wtbl_update(dev, i,
+				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+	for (i = 0; i < 2; i++)
+		mt7921_mac_init_band(dev, i);
+
+	mt7921_mcu_set_rts_thresh(&dev->phy, 0x92b);
+}
+
+static void
+mt7921_init_txpower_band(struct mt7921_dev *dev,
+			 struct ieee80211_supported_band *sband)
+{
+	int i, n_chains = hweight8(dev->mphy.antenna_mask);
+
+	for (i = 0; i < sband->n_channels; i++) {
+		struct ieee80211_channel *chan = &sband->channels[i];
+		u32 target_power = 0;
+		int j;
+
+		for (j = 0; j < n_chains; j++) {
+			u32 val;
+
+			val = mt7921_eeprom_get_target_power(dev, chan, j);
+			target_power = max(target_power, val);
+		}
+
+		chan->max_power = min_t(int, chan->max_reg_power,
+					target_power / 2);
+		chan->orig_mpwr = target_power / 2;
+	}
+}
+
+static void mt7921_init_txpower(struct mt7921_dev *dev)
+{
+	mt7921_init_txpower_band(dev, &dev->mphy.sband_2g.sband);
+	mt7921_init_txpower_band(dev, &dev->mphy.sband_5g.sband);
+
+	mt7921_eeprom_init_sku(dev);
+}
+
+static void mt7921_init_work(struct work_struct *work)
+{
+	struct mt7921_dev *dev = container_of(work, struct mt7921_dev,
+				 init_work);
+
+	mt7921_mcu_set_eeprom(dev);
+	mt7921_mac_init(dev);
+	mt7921_init_txpower(dev);
+}
+
+static int mt7921_init_hardware(struct mt7921_dev *dev)
+{
+	int ret, idx;
+
+	INIT_WORK(&dev->init_work, mt7921_init_work);
+	spin_lock_init(&dev->token_lock);
+	idr_init(&dev->token);
+
+	ret = mt7921_dma_init(dev);
+	if (ret)
+		return ret;
+
+	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
+
+	/* force firmware operation mode into normal state,
+	 * which should be set before firmware download stage.
+	 */
+	mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
+
+	ret = mt7921_mcu_init(dev);
+	if (ret)
+		return ret;
+
+	ret = mt7921_eeprom_init(dev);
+	if (ret < 0)
+		return ret;
+
+	/* Beacon and mgmt frames should occupy wcid 0 */
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
+	if (idx)
+		return -ENOSPC;
+
+	dev->mt76.global_wcid.idx = idx;
+	dev->mt76.global_wcid.hw_key_idx = -1;
+	dev->mt76.global_wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	rcu_assign_pointer(dev->mt76.wcid[idx], &dev->mt76.global_wcid);
+
+	return 0;
+}
+
+static void
+mt7921_gen_ppe_thresh(u8 *he_ppet, int nss)
+{
+	u8 i, ppet_bits, ppet_size, ru_bit_mask = 0x7; /* HE80 */
+	u8 ppet16_ppet8_ru3_ru0[] = {0x1c, 0xc7, 0x71};
+
+	he_ppet[0] = FIELD_PREP(IEEE80211_PPE_THRES_NSS_MASK, nss - 1) |
+		     FIELD_PREP(IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK,
+				ru_bit_mask);
+
+	ppet_bits = IEEE80211_PPE_THRES_INFO_PPET_SIZE *
+		    nss * hweight8(ru_bit_mask) * 2;
+	ppet_size = DIV_ROUND_UP(ppet_bits, 8);
+
+	for (i = 0; i < ppet_size - 1; i++)
+		he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3];
+
+	he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3] &
+			 (0xff >> (8 - (ppet_bits - 1) % 8));
+}
+
+static int
+mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
+		    struct ieee80211_sband_iftype_data *data)
+{
+	int i, idx = 0;
+	int nss = hweight8(phy->chainmask);
+	u16 mcs_map = 0;
+
+	for (i = 0; i < 8; i++) {
+		if (i < nss)
+			mcs_map |= (IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2));
+		else
+			mcs_map |= (IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
+	}
+
+	for (i = 0; i < NUM_NL80211_IFTYPES; i++) {
+		struct ieee80211_sta_he_cap *he_cap = &data[idx].he_cap;
+		struct ieee80211_he_cap_elem *he_cap_elem =
+				&he_cap->he_cap_elem;
+		struct ieee80211_he_mcs_nss_supp *he_mcs =
+				&he_cap->he_mcs_nss_supp;
+
+		switch (i) {
+		case NL80211_IFTYPE_STATION:
+		case NL80211_IFTYPE_AP:
+#ifdef CONFIG_MAC80211_MESH
+		case NL80211_IFTYPE_MESH_POINT:
+#endif
+			break;
+		default:
+			continue;
+		}
+
+		data[idx].types_mask = BIT(i);
+		he_cap->has_he = true;
+
+		he_cap_elem->mac_cap_info[0] =
+			IEEE80211_HE_MAC_CAP0_HTC_HE;
+		he_cap_elem->mac_cap_info[3] =
+			IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
+			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_RESERVED;
+		he_cap_elem->mac_cap_info[4] =
+			IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU;
+
+		if (band == NL80211_BAND_2GHZ)
+			he_cap_elem->phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+		else if (band == NL80211_BAND_5GHZ)
+			he_cap_elem->phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+
+		he_cap_elem->phy_cap_info[1] =
+			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
+		he_cap_elem->phy_cap_info[2] =
+			IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
+			IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ;
+
+		switch (i) {
+		case NL80211_IFTYPE_AP:
+			he_cap_elem->mac_cap_info[0] |=
+				IEEE80211_HE_MAC_CAP0_TWT_RES;
+			he_cap_elem->mac_cap_info[2] |=
+				IEEE80211_HE_MAC_CAP2_BSR;
+			he_cap_elem->mac_cap_info[4] |=
+				IEEE80211_HE_MAC_CAP4_BQR;
+			he_cap_elem->mac_cap_info[5] |=
+				IEEE80211_HE_MAC_CAP5_OM_CTRL_UL_MU_DATA_DIS_RX;
+			he_cap_elem->phy_cap_info[3] |=
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+			he_cap_elem->phy_cap_info[6] |=
+				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+			break;
+		case NL80211_IFTYPE_STATION:
+			he_cap_elem->mac_cap_info[0] |=
+				IEEE80211_HE_MAC_CAP0_TWT_REQ;
+			he_cap_elem->mac_cap_info[1] |=
+				IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
+
+			if (band == NL80211_BAND_2GHZ)
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G;
+			else if (band == NL80211_BAND_5GHZ)
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G;
+
+			he_cap_elem->phy_cap_info[1] |=
+				IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
+				IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US;
+			he_cap_elem->phy_cap_info[3] |=
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+			he_cap_elem->phy_cap_info[6] |=
+				IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB |
+				IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
+				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+			he_cap_elem->phy_cap_info[7] |=
+				IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_AR |
+				IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI;
+			he_cap_elem->phy_cap_info[8] |=
+				IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
+				IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_484;
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
+				IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK |
+				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
+				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB;
+			break;
+		}
+
+		he_mcs->rx_mcs_80 = cpu_to_le16(mcs_map);
+		he_mcs->tx_mcs_80 = cpu_to_le16(mcs_map);
+		he_mcs->rx_mcs_160 = cpu_to_le16(mcs_map);
+		he_mcs->tx_mcs_160 = cpu_to_le16(mcs_map);
+		he_mcs->rx_mcs_80p80 = cpu_to_le16(mcs_map);
+		he_mcs->tx_mcs_80p80 = cpu_to_le16(mcs_map);
+
+		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
+		if (he_cap_elem->phy_cap_info[6] &
+		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+			mt7921_gen_ppe_thresh(he_cap->ppe_thres, nss);
+		} else {
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_16US;
+		}
+		idx++;
+	}
+
+	return idx;
+}
+
+void mt7921_set_stream_he_caps(struct mt7921_phy *phy)
+{
+	struct ieee80211_sband_iftype_data *data;
+	struct ieee80211_supported_band *band;
+	int n;
+
+	if (phy->mt76->cap.has_2ghz) {
+		data = phy->iftype[NL80211_BAND_2GHZ];
+		n = mt7921_init_he_caps(phy, NL80211_BAND_2GHZ, data);
+
+		band = &phy->mt76->sband_2g.sband;
+		band->iftype_data = data;
+		band->n_iftype_data = n;
+	}
+
+	if (phy->mt76->cap.has_5ghz) {
+		data = phy->iftype[NL80211_BAND_5GHZ];
+		n = mt7921_init_he_caps(phy, NL80211_BAND_5GHZ, data);
+
+		band = &phy->mt76->sband_5g.sband;
+		band->iftype_data = data;
+		band->n_iftype_data = n;
+	}
+}
+
+int mt7921_register_device(struct mt7921_dev *dev)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	int ret;
+
+	dev->phy.dev = dev;
+	dev->phy.mt76 = &dev->mt76.phy;
+	dev->mt76.phy.priv = &dev->phy;
+	INIT_DELAYED_WORK(&dev->phy.mac_work, mt7921_mac_work);
+	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7921_scan_work);
+	skb_queue_head_init(&dev->phy.scan_event_list);
+	INIT_LIST_HEAD(&dev->sta_poll_list);
+	spin_lock_init(&dev->sta_poll_lock);
+
+	init_waitqueue_head(&dev->reset_wait);
+	INIT_WORK(&dev->reset_work, mt7921_mac_reset_work);
+
+	ret = mt7921_init_hardware(dev);
+	if (ret)
+		return ret;
+
+	mt7921_init_wiphy(hw);
+	dev->mphy.sband_2g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+	dev->mphy.sband_5g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+	dev->mphy.sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991 |
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
+	dev->mphy.sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_SHORT_GI_160 |
+			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
+	dev->mphy.hw->wiphy->available_antennas_rx = dev->phy.chainmask;
+	dev->mphy.hw->wiphy->available_antennas_tx = dev->phy.chainmask;
+
+	mt76_set_stream_caps(&dev->mphy, true);
+	mt7921_set_stream_he_caps(&dev->phy);
+
+	ret = mt76_register_device(&dev->mt76, true, mt7921_rates,
+				   ARRAY_SIZE(mt7921_rates));
+	if (ret)
+		return ret;
+
+	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
+
+	return mt7921_init_debugfs(dev);
+}
+
+void mt7921_unregister_device(struct mt7921_dev *dev)
+{
+	struct mt76_txwi_cache *txwi;
+	int id;
+
+	mt76_unregister_device(&dev->mt76);
+	mt7921_mcu_exit(dev);
+	mt7921_dma_cleanup(dev);
+
+	spin_lock_bh(&dev->token_lock);
+	idr_for_each_entry(&dev->token, txwi, id) {
+		mt7921_txp_skb_unmap(&dev->mt76, txwi);
+		if (txwi->skb) {
+			struct ieee80211_hw *hw;
+
+			hw = mt76_tx_status_get_hw(&dev->mt76, txwi->skb);
+			ieee80211_free_txskb(hw, txwi->skb);
+		}
+		mt76_put_txwi(&dev->mt76, txwi);
+		dev->token_count--;
+	}
+	spin_unlock_bh(&dev->token_lock);
+	idr_destroy(&dev->token);
+
+	tasklet_disable(&dev->irq_tasklet);
+	mt76_free_device(&dev->mt76);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
new file mode 100644
index 000000000000..3a6f6d4cbfcf
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -0,0 +1,1387 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/etherdevice.h>
+#include <linux/timekeeping.h>
+#include "mt7921.h"
+#include "../dma.h"
+#include "mac.h"
+
+#define to_rssi(field, rxv)	((FIELD_GET(field, rxv) - 220) / 2)
+
+#define HE_BITS(f)		cpu_to_le16(IEEE80211_RADIOTAP_HE_##f)
+#define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
+						 IEEE80211_RADIOTAP_HE_##f)
+
+static struct mt76_wcid *mt7921_rx_get_wcid(struct mt7921_dev *dev,
+					    u16 idx, bool unicast)
+{
+	struct mt7921_sta *sta;
+	struct mt76_wcid *wcid;
+
+	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
+		return NULL;
+
+	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	if (unicast || !wcid)
+		return wcid;
+
+	if (!wcid->sta)
+		return NULL;
+
+	sta = container_of(wcid, struct mt7921_sta, wcid);
+	if (!sta->vif)
+		return NULL;
+
+	return &sta->vif->sta.wcid;
+}
+
+void mt7921_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps)
+{
+}
+
+bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask)
+{
+	mt76_rmw(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
+		 FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, idx) | mask);
+
+	return mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY,
+			 0, 5000);
+}
+
+static u32 mt7921_mac_wtbl_lmac_addr(struct mt7921_dev *dev, u16 wcid)
+{
+	mt76_wr(dev, MT_WTBLON_TOP_WDUCR,
+		FIELD_PREP(MT_WTBLON_TOP_WDUCR_GROUP, (wcid >> 7)));
+
+	return MT_WTBL_LMAC_OFFS(wcid, 0);
+}
+
+static void mt7921_mac_sta_poll(struct mt7921_dev *dev)
+{
+	static const u8 ac_to_tid[] = {
+		[IEEE80211_AC_BE] = 0,
+		[IEEE80211_AC_BK] = 1,
+		[IEEE80211_AC_VI] = 4,
+		[IEEE80211_AC_VO] = 6
+	};
+	struct ieee80211_sta *sta;
+	struct mt7921_sta *msta;
+	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
+	LIST_HEAD(sta_poll_list);
+	int i;
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	list_splice_init(&dev->sta_poll_list, &sta_poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
+	rcu_read_lock();
+
+	while (true) {
+		bool clear = false;
+		u32 addr;
+		u16 idx;
+
+		spin_lock_bh(&dev->sta_poll_lock);
+		if (list_empty(&sta_poll_list)) {
+			spin_unlock_bh(&dev->sta_poll_lock);
+			break;
+		}
+		msta = list_first_entry(&sta_poll_list,
+					struct mt7921_sta, poll_list);
+		list_del_init(&msta->poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
+
+		idx = msta->wcid.idx;
+		addr = mt7921_mac_wtbl_lmac_addr(dev, idx) + 20 * 4;
+
+		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+			u32 tx_last = msta->airtime_ac[i];
+			u32 rx_last = msta->airtime_ac[i + 4];
+
+			msta->airtime_ac[i] = mt76_rr(dev, addr);
+			msta->airtime_ac[i + 4] = mt76_rr(dev, addr + 4);
+
+			tx_time[i] = msta->airtime_ac[i] - tx_last;
+			rx_time[i] = msta->airtime_ac[i + 4] - rx_last;
+
+			if ((tx_last | rx_last) & BIT(30))
+				clear = true;
+
+			addr += 8;
+		}
+
+		if (clear) {
+			mt7921_mac_wtbl_update(dev, idx,
+					       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+			memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
+		}
+
+		if (!msta->wcid.sta)
+			continue;
+
+		sta = container_of((void *)msta, struct ieee80211_sta,
+				   drv_priv);
+		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+			u8 q = mt7921_lmac_mapping(dev, i);
+			u32 tx_cur = tx_time[q];
+			u32 rx_cur = rx_time[q];
+			u8 tid = ac_to_tid[i];
+
+			if (!tx_cur && !rx_cur)
+				continue;
+
+			ieee80211_sta_register_airtime(sta, tid, tx_cur,
+						       rx_cur);
+		}
+	}
+
+	rcu_read_unlock();
+}
+
+static void
+mt7921_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
+				 struct ieee80211_radiotap_he *he,
+				 __le32 *rxv)
+{
+	u32 ru_h, ru_l;
+	u8 ru, offs = 0;
+
+	ru_l = FIELD_GET(MT_PRXV_HE_RU_ALLOC_L, le32_to_cpu(rxv[0]));
+	ru_h = FIELD_GET(MT_PRXV_HE_RU_ALLOC_H, le32_to_cpu(rxv[1]));
+	ru = (u8)(ru_l | ru_h << 4);
+
+	status->bw = RATE_INFO_BW_HE_RU;
+
+	switch (ru) {
+	case 0 ... 36:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		offs = ru;
+		break;
+	case 37 ... 52:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_52;
+		offs = ru - 37;
+		break;
+	case 53 ... 60:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		offs = ru - 53;
+		break;
+	case 61 ... 64:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_242;
+		offs = ru - 61;
+		break;
+	case 65 ... 66:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_484;
+		offs = ru - 65;
+		break;
+	case 67:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_996;
+		break;
+	case 68:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
+		break;
+	}
+
+	he->data1 |= HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
+	he->data2 |= HE_BITS(DATA2_RU_OFFSET_KNOWN) |
+		     le16_encode_bits(offs,
+				      IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET);
+}
+
+static void
+mt7921_mac_decode_he_radiotap(struct sk_buff *skb,
+			      struct mt76_rx_status *status,
+			      __le32 *rxv, u32 phy)
+{
+	/* TODO: struct ieee80211_radiotap_he_mu */
+	static const struct ieee80211_radiotap_he known = {
+		.data1 = HE_BITS(DATA1_DATA_MCS_KNOWN) |
+			 HE_BITS(DATA1_DATA_DCM_KNOWN) |
+			 HE_BITS(DATA1_STBC_KNOWN) |
+			 HE_BITS(DATA1_CODING_KNOWN) |
+			 HE_BITS(DATA1_LDPC_XSYMSEG_KNOWN) |
+			 HE_BITS(DATA1_DOPPLER_KNOWN) |
+			 HE_BITS(DATA1_BSS_COLOR_KNOWN),
+		.data2 = HE_BITS(DATA2_GI_KNOWN) |
+			 HE_BITS(DATA2_TXBF_KNOWN) |
+			 HE_BITS(DATA2_PE_DISAMBIG_KNOWN) |
+			 HE_BITS(DATA2_TXOP_KNOWN),
+	};
+	struct ieee80211_radiotap_he *he = NULL;
+	u32 ltf_size = le32_get_bits(rxv[2], MT_CRXV_HE_LTF_SIZE) + 1;
+
+	he = skb_push(skb, sizeof(known));
+	memcpy(he, &known, sizeof(known));
+
+	he->data3 = HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, rxv[14]) |
+		    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, rxv[2]);
+	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[2]) |
+		    le16_encode_bits(ltf_size,
+				     IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
+	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[14]) |
+		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[14]);
+
+	switch (phy) {
+	case MT_PHY_TYPE_HE_SU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_SU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN) |
+			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[14]) |
+			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		he->data4 |= HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
+		break;
+	case MT_PHY_TYPE_HE_EXT_SU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		break;
+	case MT_PHY_TYPE_HE_MU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_MU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		he->data4 |= HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
+
+		mt7921_mac_decode_he_radiotap_ru(status, he, rxv);
+		break;
+	case MT_PHY_TYPE_HE_TB:
+		he->data1 |= HE_BITS(DATA1_FORMAT_TRIG) |
+			     HE_BITS(DATA1_SPTL_REUSE_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE2_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE3_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE4_KNOWN);
+
+		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[11]);
+
+		mt7921_mac_decode_he_radiotap_ru(status, he, rxv);
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+mt7921_get_status_freq_info(struct mt7921_dev *dev, struct mt76_phy *mphy,
+			    struct mt76_rx_status *status, u8 chfreq)
+{
+	if (!test_bit(MT76_HW_SCANNING, &mphy->state) &&
+	    !test_bit(MT76_HW_SCHED_SCANNING, &mphy->state) &&
+	    !test_bit(MT76_STATE_ROC, &mphy->state)) {
+		status->freq = mphy->chandef.chan->center_freq;
+		status->band = mphy->chandef.chan->band;
+		return;
+	}
+
+	status->band = chfreq <= 14 ? NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
+	status->freq = ieee80211_channel_to_frequency(chfreq, status->band);
+}
+
+int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7921_phy *phy = &dev->phy;
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_hdr *hdr;
+	__le32 *rxd = (__le32 *)skb->data;
+	__le32 *rxv = NULL;
+	u32 mode = 0;
+	u32 rxd1 = le32_to_cpu(rxd[1]);
+	u32 rxd2 = le32_to_cpu(rxd[2]);
+	u32 rxd3 = le32_to_cpu(rxd[3]);
+	bool unicast, insert_ccmp_hdr = false;
+	u8 remove_pad;
+	int i, idx;
+	u8 chfreq;
+
+	memset(status, 0, sizeof(*status));
+
+	if (rxd1 & MT_RXD1_NORMAL_BAND_IDX) {
+		mphy = dev->mt76.phy2;
+		if (!mphy)
+			return -EINVAL;
+
+		phy = mphy->priv;
+		status->ext_phy = true;
+	}
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
+		return -EINVAL;
+
+	chfreq = FIELD_GET(MT_RXD3_NORMAL_CH_FREQ, rxd3);
+	unicast = FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) == MT_RXD3_NORMAL_U2M;
+	idx = FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
+	status->wcid = mt7921_rx_get_wcid(dev, idx, unicast);
+
+	if (status->wcid) {
+		struct mt7921_sta *msta;
+
+		msta = container_of(status->wcid, struct mt7921_sta, wcid);
+		spin_lock_bh(&dev->sta_poll_lock);
+		if (list_empty(&msta->poll_list))
+			list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
+	}
+
+	mt7921_get_status_freq_info(dev, mphy, status, chfreq);
+
+	if (status->band == NL80211_BAND_5GHZ)
+		sband = &mphy->sband_5g.sband;
+	else
+		sband = &mphy->sband_2g.sband;
+
+	if (!sband->channels)
+		return -EINVAL;
+
+	if (rxd1 & MT_RXD1_NORMAL_FCS_ERR)
+		status->flag |= RX_FLAG_FAILED_FCS_CRC;
+
+	if (rxd1 & MT_RXD1_NORMAL_TKIP_MIC_ERR)
+		status->flag |= RX_FLAG_MMIC_ERROR;
+
+	if (FIELD_GET(MT_RXD1_NORMAL_SEC_MODE, rxd1) != 0 &&
+	    !(rxd1 & (MT_RXD1_NORMAL_CLM | MT_RXD1_NORMAL_CM))) {
+		status->flag |= RX_FLAG_DECRYPTED;
+		status->flag |= RX_FLAG_IV_STRIPPED;
+		status->flag |= RX_FLAG_MMIC_STRIPPED | RX_FLAG_MIC_STRIPPED;
+	}
+
+	if (!(rxd2 & MT_RXD2_NORMAL_NON_AMPDU)) {
+		status->flag |= RX_FLAG_AMPDU_DETAILS;
+
+		/* all subframes of an A-MPDU have the same timestamp */
+		if (phy->rx_ampdu_ts != rxd[14]) {
+			if (!++phy->ampdu_ref)
+				phy->ampdu_ref++;
+		}
+		phy->rx_ampdu_ts = rxd[14];
+
+		status->ampdu_ref = phy->ampdu_ref;
+	}
+
+	remove_pad = FIELD_GET(MT_RXD2_NORMAL_HDR_OFFSET, rxd2);
+
+	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR)
+		return -EINVAL;
+
+	rxd += 6;
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_4) {
+		rxd += 4;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_1) {
+		u8 *data = (u8 *)rxd;
+
+		if (status->flag & RX_FLAG_DECRYPTED) {
+			status->iv[0] = data[5];
+			status->iv[1] = data[4];
+			status->iv[2] = data[3];
+			status->iv[3] = data[2];
+			status->iv[4] = data[1];
+			status->iv[5] = data[0];
+
+			insert_ccmp_hdr = FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+		}
+		rxd += 4;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_2) {
+		rxd += 2;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	/* RXD Group 3 - P-RXV */
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_3) {
+		u32 v0, v1, v2;
+
+		rxv = rxd;
+		rxd += 2;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+
+		v0 = le32_to_cpu(rxv[0]);
+		v1 = le32_to_cpu(rxv[1]);
+		v2 = le32_to_cpu(rxv[2]);
+
+		if (v0 & MT_PRXV_HT_AD_CODE)
+			status->enc_flags |= RX_ENC_FLAG_LDPC;
+
+		status->chains = mphy->antenna_mask;
+		status->chain_signal[0] = to_rssi(MT_PRXV_RCPI0, v1);
+		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v1);
+		status->chain_signal[2] = to_rssi(MT_PRXV_RCPI2, v1);
+		status->chain_signal[3] = to_rssi(MT_PRXV_RCPI3, v1);
+		status->signal = status->chain_signal[0];
+
+		for (i = 1; i < hweight8(mphy->antenna_mask); i++) {
+			if (!(status->chains & BIT(i)))
+				continue;
+
+			status->signal = max(status->signal,
+					     status->chain_signal[i]);
+		}
+
+		/* RXD Group 5 - C-RXV */
+		if (rxd1 & MT_RXD1_NORMAL_GROUP_5) {
+			u8 stbc = FIELD_GET(MT_CRXV_HT_STBC, v2);
+			u8 gi = FIELD_GET(MT_CRXV_HT_SHORT_GI, v2);
+			bool cck = false;
+
+			rxd += 18;
+			if ((u8 *)rxd - skb->data >= skb->len)
+				return -EINVAL;
+
+			idx = i = FIELD_GET(MT_PRXV_TX_RATE, v0);
+			mode = FIELD_GET(MT_CRXV_TX_MODE, v2);
+
+			switch (mode) {
+			case MT_PHY_TYPE_CCK:
+				cck = true;
+				fallthrough;
+			case MT_PHY_TYPE_OFDM:
+				i = mt76_get_rate(&dev->mt76, sband, i, cck);
+				break;
+			case MT_PHY_TYPE_HT_GF:
+			case MT_PHY_TYPE_HT:
+				status->encoding = RX_ENC_HT;
+				if (i > 31)
+					return -EINVAL;
+				break;
+			case MT_PHY_TYPE_VHT:
+				status->nss =
+					FIELD_GET(MT_PRXV_NSTS, v0) + 1;
+				status->encoding = RX_ENC_VHT;
+				if (i > 9)
+					return -EINVAL;
+				break;
+			case MT_PHY_TYPE_HE_MU:
+				status->flag |= RX_FLAG_RADIOTAP_HE_MU;
+				fallthrough;
+			case MT_PHY_TYPE_HE_SU:
+			case MT_PHY_TYPE_HE_EXT_SU:
+			case MT_PHY_TYPE_HE_TB:
+				status->nss =
+					FIELD_GET(MT_PRXV_NSTS, v0) + 1;
+				status->encoding = RX_ENC_HE;
+				status->flag |= RX_FLAG_RADIOTAP_HE;
+				i &= GENMASK(3, 0);
+
+				if (gi <= NL80211_RATE_INFO_HE_GI_3_2)
+					status->he_gi = gi;
+
+				status->he_dcm = !!(idx & MT_PRXV_TX_DCM);
+				break;
+			default:
+				return -EINVAL;
+			}
+			status->rate_idx = i;
+
+			switch (FIELD_GET(MT_CRXV_FRAME_MODE, v2)) {
+			case IEEE80211_STA_RX_BW_20:
+				break;
+			case IEEE80211_STA_RX_BW_40:
+				if (mode & MT_PHY_TYPE_HE_EXT_SU &&
+				    (idx & MT_PRXV_TX_ER_SU_106T)) {
+					status->bw = RATE_INFO_BW_HE_RU;
+					status->he_ru =
+						NL80211_RATE_INFO_HE_RU_ALLOC_106;
+				} else {
+					status->bw = RATE_INFO_BW_40;
+				}
+				break;
+			case IEEE80211_STA_RX_BW_80:
+				status->bw = RATE_INFO_BW_80;
+				break;
+			case IEEE80211_STA_RX_BW_160:
+				status->bw = RATE_INFO_BW_160;
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
+			if (mode < MT_PHY_TYPE_HE_SU && gi)
+				status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		}
+	}
+
+	skb_pull(skb, (u8 *)rxd - skb->data + 2 * remove_pad);
+
+	if (insert_ccmp_hdr) {
+		u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
+
+		mt76_insert_ccmp_hdr(skb, key_id);
+	}
+
+	if (rxv && status->flag & RX_FLAG_RADIOTAP_HE)
+		mt7921_mac_decode_he_radiotap(skb, status, rxv, mode);
+
+	hdr = mt76_skb_get_hdr(skb);
+	if (!status->wcid || !ieee80211_is_data_qos(hdr->frame_control))
+		return 0;
+
+	status->aggr = unicast &&
+		       !ieee80211_is_qos_nullfunc(hdr->frame_control);
+	status->tid = *ieee80211_get_qos_ctl(hdr) & IEEE80211_QOS_CTL_TID_MASK;
+	status->seqno = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
+
+	return 0;
+}
+
+static void
+mt7921_mac_write_txwi_8023(struct mt7921_dev *dev, __le32 *txwi,
+			   struct sk_buff *skb, struct mt76_wcid *wcid)
+{
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	u8 fc_type, fc_stype;
+	bool wmm = false;
+	u32 val;
+
+	if (wcid->sta) {
+		struct ieee80211_sta *sta;
+
+		sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
+		wmm = sta->wme;
+	}
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3) |
+	      FIELD_PREP(MT_TXD1_TID, tid);
+
+	if (be16_to_cpu(skb->protocol) >= ETH_P_802_3_MIN)
+		val |= MT_TXD1_ETH_802_3;
+
+	txwi[1] |= cpu_to_le32(val);
+
+	fc_type = IEEE80211_FTYPE_DATA >> 2;
+	fc_stype = wmm ? IEEE80211_STYPE_QOS_DATA >> 4 : 0;
+
+	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
+
+	txwi[2] |= cpu_to_le32(val);
+
+	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+	txwi[7] |= cpu_to_le32(val);
+}
+
+static void
+mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, __le32 *txwi,
+			    struct sk_buff *skb, struct ieee80211_key_conf *key)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	bool multicast = is_multicast_ether_addr(hdr->addr1);
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	__le16 fc = hdr->frame_control;
+	u8 fc_type, fc_stype;
+	u32 val;
+
+	if (ieee80211_is_action(fc) &&
+	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
+	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ) {
+		u16 capab = le16_to_cpu(mgmt->u.action.u.addba_req.capab);
+
+		txwi[5] |= cpu_to_le32(MT_TXD5_ADD_BA);
+		tid = (capab >> 2) & IEEE80211_QOS_CTL_TID_MASK;
+	} else if (ieee80211_is_back_req(hdr->frame_control)) {
+		struct ieee80211_bar *bar = (struct ieee80211_bar *)hdr;
+		u16 control = le16_to_cpu(bar->control);
+
+		tid = FIELD_GET(IEEE80211_BAR_CTRL_TID_INFO_MASK, control);
+	}
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11) |
+	      FIELD_PREP(MT_TXD1_HDR_INFO,
+			 ieee80211_get_hdrlen_from_skb(skb) / 2) |
+	      FIELD_PREP(MT_TXD1_TID, tid);
+	txwi[1] |= cpu_to_le32(val);
+
+	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
+	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
+
+	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype) |
+	      FIELD_PREP(MT_TXD2_MULTICAST, multicast);
+
+	if (key && multicast && ieee80211_is_robust_mgmt_frame(skb) &&
+	    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
+		val |= MT_TXD2_BIP;
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
+	}
+
+	if (!ieee80211_is_data(fc) || multicast)
+		val |= MT_TXD2_FIX_RATE;
+
+	txwi[2] |= cpu_to_le32(val);
+
+	if (ieee80211_is_beacon(fc)) {
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_SW_POWER_MGMT);
+		txwi[3] |= cpu_to_le32(MT_TXD3_REM_TX_COUNT);
+	}
+
+	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
+		u16 seqno = le16_to_cpu(hdr->seq_ctrl);
+
+		if (ieee80211_is_back_req(hdr->frame_control)) {
+			struct ieee80211_bar *bar;
+
+			bar = (struct ieee80211_bar *)skb->data;
+			seqno = le16_to_cpu(bar->start_seq_num);
+		}
+
+		val = MT_TXD3_SN_VALID |
+		      FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
+		txwi[3] |= cpu_to_le32(val);
+	}
+
+	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+	txwi[7] |= cpu_to_le32(val);
+}
+
+void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
+			   struct sk_buff *skb, struct mt76_wcid *wcid,
+			   struct ieee80211_key_conf *key, bool beacon)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = info->control.vif;
+	struct mt76_phy *mphy = &dev->mphy;
+	bool ext_phy = info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY;
+	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
+	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+	u16 tx_count = 15;
+	u32 val;
+
+	if (vif) {
+		struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+
+		omac_idx = mvif->omac_idx;
+		wmm_idx = mvif->wmm_idx;
+	}
+
+	if (ext_phy && dev->mt76.phy2)
+		mphy = dev->mt76.phy2;
+
+	if (beacon) {
+		p_fmt = MT_TX_TYPE_FW;
+		q_idx = MT_LMAC_BCN0;
+	} else if (skb_get_queue_mapping(skb) >= MT_TXQ_PSD) {
+		p_fmt = MT_TX_TYPE_CT;
+		q_idx = MT_LMAC_ALTX0;
+	} else {
+		p_fmt = MT_TX_TYPE_CT;
+		q_idx = wmm_idx * MT7921_MAX_WMM_SETS +
+			mt7921_lmac_mapping(dev, skb_get_queue_mapping(skb));
+	}
+
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + MT_TXD_SIZE) |
+	      FIELD_PREP(MT_TXD0_PKT_FMT, p_fmt) |
+	      FIELD_PREP(MT_TXD0_Q_IDX, q_idx);
+	txwi[0] = cpu_to_le32(val);
+
+	val = MT_TXD1_LONG_FORMAT |
+	      FIELD_PREP(MT_TXD1_WLAN_IDX, wcid->idx) |
+	      FIELD_PREP(MT_TXD1_OWN_MAC, omac_idx);
+
+	if (ext_phy && q_idx >= MT_LMAC_ALTX0 && q_idx <= MT_LMAC_BCN0)
+		val |= MT_TXD1_TGID;
+
+	txwi[1] = cpu_to_le32(val);
+
+	txwi[2] = 0;
+
+	val = MT_TXD3_SW_POWER_MGMT |
+	      FIELD_PREP(MT_TXD3_REM_TX_COUNT, tx_count);
+	if (key)
+		val |= MT_TXD3_PROTECT_FRAME;
+	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
+		val |= MT_TXD3_NO_ACK;
+
+	txwi[3] = cpu_to_le32(val);
+	txwi[4] = 0;
+	txwi[5] = 0;
+	txwi[6] = 0;
+	txwi[7] = wcid->amsdu ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
+
+	if (is_8023)
+		mt7921_mac_write_txwi_8023(dev, txwi, skb, wcid);
+	else
+		mt7921_mac_write_txwi_80211(dev, txwi, skb, key);
+
+	if (txwi[2] & cpu_to_le32(MT_TXD2_FIX_RATE)) {
+		u16 rate;
+
+		/* hardware won't add HTC for mgmt/ctrl frame */
+		txwi[2] |= cpu_to_le32(MT_TXD2_HTC_VLD);
+
+		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+			rate = MT7921_5G_RATE_DEFAULT;
+		else
+			rate = MT7921_2G_RATE_DEFAULT;
+
+		val = MT_TXD6_FIXED_BW |
+		      FIELD_PREP(MT_TXD6_TX_RATE, rate);
+		txwi[6] |= cpu_to_le32(val);
+		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
+	}
+}
+
+static void
+mt7921_write_hw_txp(struct mt7921_dev *dev, struct mt76_tx_info *tx_info,
+		    void *txp_ptr, u32 id)
+{
+	struct mt7921_hw_txp *txp = txp_ptr;
+	struct mt7921_txp_ptr *ptr = &txp->ptr[0];
+	int i, nbuf = tx_info->nbuf - 1;
+
+	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
+	tx_info->nbuf = 1;
+
+	txp->msdu_id[0] = cpu_to_le16(id | MT_MSDU_ID_VALID);
+
+	for (i = 0; i < nbuf; i++) {
+		u16 len = tx_info->buf[i + 1].len & MT_TXD_LEN_MASK;
+		u32 addr = tx_info->buf[i + 1].addr;
+
+		if (i == nbuf - 1)
+			len |= MT_TXD_LEN_LAST;
+
+		if (i & 1) {
+			ptr->buf1 = cpu_to_le32(addr);
+			ptr->len1 = cpu_to_le16(len);
+			ptr++;
+		} else {
+			ptr->buf0 = cpu_to_le32(addr);
+			ptr->len0 = cpu_to_le16(len);
+		}
+	}
+}
+
+static void mt7921_set_tx_blocked(struct mt7921_dev *dev, bool blocked)
+{
+	struct mt76_phy *mphy = &dev->mphy, *mphy2 = dev->mt76.phy2;
+	struct mt76_queue *q, *q2 = NULL;
+
+	q = mphy->q_tx[0];
+	if (blocked == q->blocked)
+		return;
+
+	q->blocked = blocked;
+	if (mphy2) {
+		q2 = mphy2->q_tx[0];
+		q2->blocked = blocked;
+	}
+
+	if (!blocked)
+		mt76_worker_schedule(&dev->mt76.tx_worker);
+}
+
+int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			  struct ieee80211_sta *sta,
+			  struct mt76_tx_info *tx_info)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	struct mt76_tx_cb *cb = mt76_tx_skb_cb(tx_info->skb);
+	struct mt76_txwi_cache *t;
+	struct mt7921_txp *txp;
+	int id;
+	u8 *txwi = (u8 *)txwi_ptr;
+
+	if (!wcid)
+		wcid = &dev->mt76.global_wcid;
+
+	cb->wcid = wcid->idx;
+
+	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
+	t->skb = tx_info->skb;
+
+	spin_lock_bh(&dev->token_lock);
+	id = idr_alloc(&dev->token, t, 0, MT7921_TOKEN_SIZE, GFP_ATOMIC);
+	if (id >= 0)
+		dev->token_count++;
+
+	if (dev->token_count >= MT7921_TOKEN_SIZE - MT7921_TOKEN_FREE_THR)
+		mt7921_set_tx_blocked(dev, true);
+	spin_unlock_bh(&dev->token_lock);
+
+	if (id < 0)
+		return id;
+
+	mt7921_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
+			      false);
+
+	txp = (struct mt7921_txp *)(txwi + MT_TXD_SIZE);
+	memset(txp, 0, sizeof(struct mt7921_txp_common));
+	mt7921_write_hw_txp(dev, tx_info, txp, id);
+
+	tx_info->skb = DMA_DUMMY_DATA;
+
+	return 0;
+}
+
+static void
+mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
+{
+	struct mt7921_sta *msta;
+	u16 fc, tid;
+	u32 val;
+
+	if (!sta || !sta->ht_cap.ht_supported)
+		return;
+
+	tid = FIELD_GET(MT_TXD1_TID, le32_to_cpu(txwi[1]));
+	if (tid >= 6) /* skip VO queue */
+		return;
+
+	val = le32_to_cpu(txwi[2]);
+	fc = FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
+	     FIELD_GET(MT_TXD2_SUB_TYPE, val) << 4;
+	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
+		return;
+
+	msta = (struct mt7921_sta *)sta->drv_priv;
+	if (!test_and_set_bit(tid, &msta->ampdu_state))
+		ieee80211_start_tx_ba_session(sta, tid, 0);
+}
+
+static void
+mt7921_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
+			  struct ieee80211_sta *sta, u8 stat,
+			  struct list_head *free_list)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_tx_status status = {
+		.sta = sta,
+		.info = info,
+		.skb = skb,
+		.free_list = free_list,
+	};
+	struct ieee80211_hw *hw;
+
+	if (sta) {
+		struct mt7921_sta *msta;
+
+		msta = (struct mt7921_sta *)sta->drv_priv;
+		status.rate = &msta->stats.tx_rate;
+	}
+
+	hw = mt76_tx_status_get_hw(mdev, skb);
+
+	if (info->flags & IEEE80211_TX_CTL_AMPDU)
+		info->flags |= IEEE80211_TX_STAT_AMPDU;
+
+	if (stat)
+		ieee80211_tx_info_clear_status(info);
+
+	if (!(info->flags & IEEE80211_TX_CTL_NO_ACK))
+		info->flags |= IEEE80211_TX_STAT_ACK;
+
+	info->status.tx_time = 0;
+	ieee80211_tx_status_ext(hw, &status);
+}
+
+void mt7921_txp_skb_unmap(struct mt76_dev *dev,
+			  struct mt76_txwi_cache *t)
+{
+	struct mt7921_txp *txp;
+	int i;
+
+	txp = mt7921_txwi_to_txp(dev, t);
+	for (i = 1; i < txp->nbuf; i++)
+		dma_unmap_single(dev->dev, le32_to_cpu(txp->buf[i]),
+				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
+}
+
+void mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_tx_free *free = (struct mt7921_tx_free *)skb->data;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_phy *mphy_ext = mdev->phy2;
+	struct mt76_txwi_cache *txwi;
+	struct ieee80211_sta *sta = NULL;
+	LIST_HEAD(free_list);
+	struct sk_buff *tmp;
+	bool wake = false;
+	u8 i, count;
+
+	/* clean DMA queues and unmap buffers first */
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
+	if (mphy_ext) {
+		mt76_queue_tx_cleanup(dev, mphy_ext->q_tx[MT_TXQ_PSD], false);
+		mt76_queue_tx_cleanup(dev, mphy_ext->q_tx[MT_TXQ_BE], false);
+	}
+
+	/* TODO: MT_TX_FREE_LATENCY is msdu time from the TXD is queued into PLE,
+	 * to the time ack is received or dropped by hw (air + hw queue time).
+	 * Should avoid accessing WTBL to get Tx airtime, and use it instead.
+	 */
+	count = FIELD_GET(MT_TX_FREE_MSDU_CNT, le16_to_cpu(free->ctrl));
+	for (i = 0; i < count; i++) {
+		u32 msdu, info = le32_to_cpu(free->info[i]);
+		u8 stat;
+
+		/* 1'b1: new wcid pair.
+		 * 1'b0: msdu_id with the same 'wcid pair' as above.
+		 */
+		if (info & MT_TX_FREE_PAIR) {
+			struct mt7921_sta *msta;
+			struct mt7921_phy *phy;
+			struct mt76_wcid *wcid;
+			u16 idx;
+
+			count++;
+			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
+			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			sta = wcid_to_sta(wcid);
+			if (!sta)
+				continue;
+
+			msta = container_of(wcid, struct mt7921_sta, wcid);
+			phy = msta->vif->phy;
+			spin_lock_bh(&dev->sta_poll_lock);
+			if (list_empty(&msta->poll_list))
+				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+			spin_unlock_bh(&dev->sta_poll_lock);
+			continue;
+		}
+
+		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
+		stat = FIELD_GET(MT_TX_FREE_STATUS, info);
+
+		spin_lock_bh(&dev->token_lock);
+		txwi = idr_remove(&dev->token, msdu);
+		if (txwi)
+			dev->token_count--;
+		if (dev->token_count < MT7921_TOKEN_SIZE - MT7921_TOKEN_FREE_THR &&
+		    dev->mphy.q_tx[0]->blocked)
+			wake = true;
+		spin_unlock_bh(&dev->token_lock);
+
+		if (!txwi)
+			continue;
+
+		mt7921_txp_skb_unmap(mdev, txwi);
+		if (txwi->skb) {
+			struct ieee80211_tx_info *info = IEEE80211_SKB_CB(txwi->skb);
+			void *txwi_ptr = mt76_get_txwi_ptr(mdev, txwi);
+
+			if (likely(txwi->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+				mt7921_tx_check_aggr(sta, txwi_ptr);
+
+			if (sta && !info->tx_time_est) {
+				struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+				int pending;
+
+				pending = atomic_dec_return(&wcid->non_aql_packets);
+				if (pending < 0)
+					atomic_cmpxchg(&wcid->non_aql_packets, pending, 0);
+			}
+
+			mt7921_tx_complete_status(mdev, txwi->skb, sta, stat, &free_list);
+			txwi->skb = NULL;
+		}
+
+		mt76_put_txwi(mdev, txwi);
+	}
+
+	mt7921_mac_sta_poll(dev);
+
+	if (wake) {
+		spin_lock_bh(&dev->token_lock);
+		mt7921_set_tx_blocked(dev, false);
+		spin_unlock_bh(&dev->token_lock);
+	}
+
+	mt76_worker_schedule(&dev->mt76.tx_worker);
+
+	napi_consume_skb(skb, 1);
+
+	list_for_each_entry_safe(skb, tmp, &free_list, list) {
+		skb_list_del_init(skb);
+		napi_consume_skb(skb, 1);
+	}
+}
+
+void mt7921_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
+{
+	struct mt7921_dev *dev;
+
+	if (!e->txwi) {
+		dev_kfree_skb_any(e->skb);
+		return;
+	}
+
+	dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	/* error path */
+	if (e->skb == DMA_DUMMY_DATA) {
+		struct mt76_txwi_cache *t;
+		struct mt7921_txp *txp;
+
+		txp = mt7921_txwi_to_txp(mdev, e->txwi);
+
+		spin_lock_bh(&dev->token_lock);
+		t = idr_remove(&dev->token, le16_to_cpu(txp->token));
+		spin_unlock_bh(&dev->token_lock);
+		e->skb = t ? t->skb : NULL;
+	}
+
+	if (e->skb) {
+		struct mt76_tx_cb *cb = mt76_tx_skb_cb(e->skb);
+		struct mt76_wcid *wcid;
+
+		wcid = rcu_dereference(dev->mt76.wcid[cb->wcid]);
+
+		mt7921_tx_complete_status(mdev, e->skb, wcid_to_sta(wcid), 0,
+					  NULL);
+	}
+}
+
+void mt7921_mac_reset_counters(struct mt7921_phy *phy)
+{
+	struct mt7921_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		mt76_rr(dev, MT_TX_AGG_CNT(ext_phy, i));
+		mt76_rr(dev, MT_TX_AGG_CNT2(ext_phy, i));
+	}
+
+	if (ext_phy) {
+		dev->mt76.phy2->survey_time = ktime_get_boottime();
+		i = ARRAY_SIZE(dev->mt76.aggr_stats) / 2;
+	} else {
+		dev->mt76.phy.survey_time = ktime_get_boottime();
+		i = 0;
+	}
+	memset(&dev->mt76.aggr_stats[i], 0, sizeof(dev->mt76.aggr_stats) / 2);
+
+	/* reset airtime counters */
+	mt76_rr(dev, MT_MIB_SDR9(ext_phy));
+	mt76_rr(dev, MT_MIB_SDR36(ext_phy));
+	mt76_rr(dev, MT_MIB_SDR37(ext_phy));
+
+	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(ext_phy),
+		 MT_WF_RMAC_MIB_RXTIME_CLR);
+	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(ext_phy),
+		 MT_WF_RMAC_MIB_RXTIME_CLR);
+}
+
+void mt7921_mac_set_timing(struct mt7921_phy *phy)
+{
+	s16 coverage_class = phy->coverage_class;
+	struct mt7921_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+	u32 val, reg_offset;
+	u32 cck = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 231) |
+		  FIELD_PREP(MT_TIMEOUT_VAL_CCA, 48);
+	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
+		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 28);
+	int sifs, offset;
+	bool is_5ghz = phy->mt76->chandef.chan->band == NL80211_BAND_5GHZ;
+
+	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
+		return;
+
+	if (is_5ghz)
+		sifs = 16;
+	else
+		sifs = 10;
+
+	if (ext_phy) {
+		coverage_class = max_t(s16, dev->phy.coverage_class,
+				       coverage_class);
+	} else {
+		struct mt7921_phy *phy_ext = mt7921_ext_phy(dev);
+
+		if (phy_ext)
+			coverage_class = max_t(s16, phy_ext->coverage_class,
+					       coverage_class);
+	}
+	mt76_set(dev, MT_ARB_SCR(ext_phy),
+		 MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
+	udelay(1);
+
+	offset = 3 * coverage_class;
+	reg_offset = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, offset) |
+		     FIELD_PREP(MT_TIMEOUT_VAL_CCA, offset);
+
+	mt76_wr(dev, MT_TMAC_CDTR(ext_phy), cck + reg_offset);
+	mt76_wr(dev, MT_TMAC_ODTR(ext_phy), ofdm + reg_offset);
+	mt76_wr(dev, MT_TMAC_ICR0(ext_phy),
+		FIELD_PREP(MT_IFS_EIFS, 360) |
+		FIELD_PREP(MT_IFS_RIFS, 2) |
+		FIELD_PREP(MT_IFS_SIFS, sifs) |
+		FIELD_PREP(MT_IFS_SLOT, phy->slottime));
+
+	if (phy->slottime < 20 || is_5ghz)
+		val = MT7921_CFEND_RATE_DEFAULT;
+	else
+		val = MT7921_CFEND_RATE_11B;
+
+	mt76_rmw_field(dev, MT_AGG_ACR0(ext_phy), MT_AGG_ACR_CFEND_RATE, val);
+	mt76_clear(dev, MT_ARB_SCR(ext_phy),
+		   MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
+}
+
+static u8
+mt7921_phy_get_nf(struct mt7921_phy *phy, int idx)
+{
+	return 0;
+}
+
+static void
+mt7921_phy_update_channel(struct mt76_phy *mphy, int idx)
+{
+	struct mt7921_dev *dev = container_of(mphy->dev, struct mt7921_dev, mt76);
+	struct mt7921_phy *phy = (struct mt7921_phy *)mphy->priv;
+	struct mt76_channel_state *state;
+	u64 busy_time, tx_time, rx_time, obss_time;
+	int nf;
+
+	busy_time = mt76_get_field(dev, MT_MIB_SDR9(idx),
+				   MT_MIB_SDR9_BUSY_MASK);
+	tx_time = mt76_get_field(dev, MT_MIB_SDR36(idx),
+				 MT_MIB_SDR36_TXTIME_MASK);
+	rx_time = mt76_get_field(dev, MT_MIB_SDR37(idx),
+				 MT_MIB_SDR37_RXTIME_MASK);
+	obss_time = mt76_get_field(dev, MT_WF_RMAC_MIB_AIRTIME14(idx),
+				   MT_MIB_OBSSTIME_MASK);
+
+	nf = mt7921_phy_get_nf(phy, idx);
+	if (!phy->noise)
+		phy->noise = nf << 4;
+	else if (nf)
+		phy->noise += nf - (phy->noise >> 4);
+
+	state = mphy->chan_state;
+	state->cc_busy += busy_time;
+	state->cc_tx += tx_time;
+	state->cc_rx += rx_time + obss_time;
+	state->cc_bss_rx += rx_time;
+	state->noise = -(phy->noise >> 4);
+}
+
+void mt7921_update_channel(struct mt76_dev *mdev)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	mt7921_phy_update_channel(&mdev->phy, 0);
+	if (mdev->phy2)
+		mt7921_phy_update_channel(mdev->phy2, 1);
+
+	/* reset obss airtime */
+	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
+	if (mdev->phy2)
+		mt76_set(dev, MT_WF_RMAC_MIB_TIME0(1),
+			 MT_WF_RMAC_MIB_RXTIME_CLR);
+}
+
+static bool
+mt7921_wait_reset_state(struct mt7921_dev *dev, u32 state)
+{
+	bool ret;
+
+	ret = wait_event_timeout(dev->reset_wait,
+				 (READ_ONCE(dev->reset_state) & state),
+				 MT7921_RESET_TIMEOUT);
+
+	WARN(!ret, "Timeout waiting for MCU reset state %x\n", state);
+	return ret;
+}
+
+static void
+mt7921_dma_reset(struct mt7921_phy *phy)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct mt76_phy *mphy_ext = dev->mt76.phy2;
+	int i;
+
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	usleep_range(1000, 2000);
+
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WA], true);
+	for (i = 0; i < __MT_TXQ_MAX; i++) {
+		mt76_queue_tx_cleanup(dev, phy->mt76->q_tx[i], true);
+		if (mphy_ext)
+			mt76_queue_tx_cleanup(dev, mphy_ext->q_tx[i], true);
+	}
+
+	mt76_for_each_q_rx(&dev->mt76, i) {
+		mt76_queue_rx_reset(dev, i);
+	}
+
+	/* re-init prefetch settings after reset */
+	mt7921_dma_prefetch(dev);
+
+	mt76_set(dev, MT_WFDMA0_GLO_CFG,
+		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+}
+
+/* system error recovery */
+void mt7921_mac_reset_work(struct work_struct *work)
+{
+	struct mt7921_phy *phy2;
+	struct mt76_phy *ext_phy;
+	struct mt7921_dev *dev;
+
+	dev = container_of(work, struct mt7921_dev, reset_work);
+	ext_phy = dev->mt76.phy2;
+	phy2 = ext_phy ? ext_phy->priv : NULL;
+
+	if (!(READ_ONCE(dev->reset_state) & MT_MCU_CMD_STOP_DMA))
+		return;
+
+	ieee80211_stop_queues(mt76_hw(dev));
+	if (ext_phy)
+		ieee80211_stop_queues(ext_phy->hw);
+
+	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	wake_up(&dev->mt76.mcu.wait);
+	cancel_delayed_work_sync(&dev->phy.mac_work);
+	if (phy2)
+		cancel_delayed_work_sync(&phy2->mac_work);
+
+	/* lock/unlock all queues to ensure that no tx is pending */
+	mt76_txq_schedule_all(&dev->mphy);
+	if (ext_phy)
+		mt76_txq_schedule_all(ext_phy);
+
+	mt76_worker_disable(&dev->mt76.tx_worker);
+	napi_disable(&dev->mt76.napi[0]);
+	napi_disable(&dev->mt76.napi[1]);
+	napi_disable(&dev->mt76.napi[2]);
+	napi_disable(&dev->mt76.tx_napi);
+
+	mutex_lock(&dev->mt76.mutex);
+
+	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_STOPPED);
+
+	if (mt7921_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
+		mt7921_dma_reset(&dev->phy);
+
+		mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_INIT);
+		mt7921_wait_reset_state(dev, MT_MCU_CMD_RECOVERY_DONE);
+	}
+
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	clear_bit(MT76_RESET, &dev->mphy.state);
+
+	mt76_worker_enable(&dev->mt76.tx_worker);
+	napi_enable(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.tx_napi);
+
+	napi_enable(&dev->mt76.napi[0]);
+	napi_schedule(&dev->mt76.napi[0]);
+
+	napi_enable(&dev->mt76.napi[1]);
+	napi_schedule(&dev->mt76.napi[1]);
+
+	napi_enable(&dev->mt76.napi[2]);
+	napi_schedule(&dev->mt76.napi[2]);
+
+	ieee80211_wake_queues(mt76_hw(dev));
+	if (ext_phy)
+		ieee80211_wake_queues(ext_phy->hw);
+
+	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
+	mt7921_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->phy.mac_work,
+				     MT7921_WATCHDOG_TIME);
+	if (phy2)
+		ieee80211_queue_delayed_work(ext_phy->hw, &phy2->mac_work,
+					     MT7921_WATCHDOG_TIME);
+}
+
+static void
+mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct mib_stats *mib = &phy->mib;
+	bool ext_phy = phy != &dev->phy;
+	int i, aggr0, aggr1;
+
+	memset(mib, 0, sizeof(*mib));
+
+	mib->fcs_err_cnt = mt76_get_field(dev, MT_MIB_SDR3(ext_phy),
+					  MT_MIB_SDR3_FCS_ERR_MASK);
+
+	aggr0 = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
+	for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
+		u32 val, val2;
+
+		val = mt76_rr(dev, MT_MIB_MB_SDR1(ext_phy, i));
+
+		val2 = FIELD_GET(MT_MIB_ACK_FAIL_COUNT_MASK, val);
+		if (val2 > mib->ack_fail_cnt)
+			mib->ack_fail_cnt = val2;
+
+		val2 = FIELD_GET(MT_MIB_BA_MISS_COUNT_MASK, val);
+		if (val2 > mib->ba_miss_cnt)
+			mib->ba_miss_cnt = val2;
+
+		val = mt76_rr(dev, MT_MIB_MB_SDR0(ext_phy, i));
+		val2 = FIELD_GET(MT_MIB_RTS_RETRIES_COUNT_MASK, val);
+		if (val2 > mib->rts_retries_cnt) {
+			mib->rts_cnt = FIELD_GET(MT_MIB_RTS_COUNT_MASK, val);
+			mib->rts_retries_cnt = val2;
+		}
+
+		val = mt76_rr(dev, MT_TX_AGG_CNT(ext_phy, i));
+		val2 = mt76_rr(dev, MT_TX_AGG_CNT2(ext_phy, i));
+
+		dev->mt76.aggr_stats[aggr0++] += val & 0xffff;
+		dev->mt76.aggr_stats[aggr0++] += val >> 16;
+		dev->mt76.aggr_stats[aggr1++] += val2 & 0xffff;
+		dev->mt76.aggr_stats[aggr1++] += val2 >> 16;
+	}
+}
+
+void mt7921_mac_work(struct work_struct *work)
+{
+	struct mt7921_phy *phy;
+	struct mt76_dev *mdev;
+
+	phy = (struct mt7921_phy *)container_of(work, struct mt7921_phy,
+						mac_work.work);
+	mdev = &phy->dev->mt76;
+
+	mutex_lock(&mdev->mutex);
+
+	mt76_update_survey(mdev);
+	if (++phy->mac_work_count == 5) {
+		phy->mac_work_count = 0;
+
+		mt7921_mac_update_mib_stats(phy);
+	}
+
+	mutex_unlock(&mdev->mutex);
+
+	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
+				     MT7921_WATCHDOG_TIME);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
new file mode 100644
index 000000000000..11ebd74ca663
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -0,0 +1,367 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7921_MAC_H
+#define __MT7921_MAC_H
+
+#define MT_CT_PARSE_LEN			72
+#define MT_CT_DMA_BUF_NUM		2
+
+#define MT_RXD0_LENGTH			GENMASK(15, 0)
+#define MT_RXD0_PKT_FLAG                GENMASK(19, 16)
+#define MT_RXD0_PKT_TYPE		GENMASK(31, 27)
+
+#define MT_RXD0_NORMAL_ETH_TYPE_OFS	GENMASK(22, 16)
+#define MT_RXD0_NORMAL_IP_SUM		BIT(23)
+#define MT_RXD0_NORMAL_UDP_TCP_SUM	BIT(24)
+
+enum rx_pkt_type {
+	PKT_TYPE_TXS,
+	PKT_TYPE_TXRXV,
+	PKT_TYPE_NORMAL,
+	PKT_TYPE_RX_DUP_RFB,
+	PKT_TYPE_RX_TMR,
+	PKT_TYPE_RETRIEVE,
+	PKT_TYPE_TXRX_NOTIFY,
+	PKT_TYPE_RX_EVENT,
+	PKT_TYPE_NORMAL_MCU,
+};
+
+/* RXD DW1 */
+#define MT_RXD1_NORMAL_WLAN_IDX		GENMASK(9, 0)
+#define MT_RXD1_NORMAL_GROUP_1		BIT(11)
+#define MT_RXD1_NORMAL_GROUP_2		BIT(12)
+#define MT_RXD1_NORMAL_GROUP_3		BIT(13)
+#define MT_RXD1_NORMAL_GROUP_4		BIT(14)
+#define MT_RXD1_NORMAL_GROUP_5		BIT(15)
+#define MT_RXD1_NORMAL_SEC_MODE		GENMASK(20, 16)
+#define MT_RXD1_NORMAL_KEY_ID		GENMASK(22, 21)
+#define MT_RXD1_NORMAL_CM		BIT(23)
+#define MT_RXD1_NORMAL_CLM		BIT(24)
+#define MT_RXD1_NORMAL_ICV_ERR		BIT(25)
+#define MT_RXD1_NORMAL_TKIP_MIC_ERR	BIT(26)
+#define MT_RXD1_NORMAL_FCS_ERR		BIT(27)
+#define MT_RXD1_NORMAL_BAND_IDX		BIT(28)
+#define MT_RXD1_NORMAL_SPP_EN		BIT(29)
+#define MT_RXD1_NORMAL_ADD_OM		BIT(30)
+#define MT_RXD1_NORMAL_SEC_DONE		BIT(31)
+
+/* RXD DW2 */
+#define MT_RXD2_NORMAL_BSSID		GENMASK(5, 0)
+#define MT_RXD2_NORMAL_CO_ANT		BIT(6)
+#define MT_RXD2_NORMAL_BF_CQI		BIT(7)
+#define MT_RXD2_NORMAL_MAC_HDR_LEN	GENMASK(12, 8)
+#define MT_RXD2_NORMAL_HDR_TRANS	BIT(13)
+#define MT_RXD2_NORMAL_HDR_OFFSET	GENMASK(15, 14)
+#define MT_RXD2_NORMAL_TID		GENMASK(19, 16)
+#define MT_RXD2_NORMAL_MU_BAR		BIT(21)
+#define MT_RXD2_NORMAL_SW_BIT		BIT(22)
+#define MT_RXD2_NORMAL_AMSDU_ERR	BIT(23)
+#define MT_RXD2_NORMAL_MAX_LEN_ERROR	BIT(24)
+#define MT_RXD2_NORMAL_HDR_TRANS_ERROR	BIT(25)
+#define MT_RXD2_NORMAL_INT_FRAME	BIT(26)
+#define MT_RXD2_NORMAL_FRAG		BIT(27)
+#define MT_RXD2_NORMAL_NULL_FRAME	BIT(28)
+#define MT_RXD2_NORMAL_NDATA		BIT(29)
+#define MT_RXD2_NORMAL_NON_AMPDU	BIT(30)
+#define MT_RXD2_NORMAL_BF_REPORT	BIT(31)
+
+/* RXD DW3 */
+#define MT_RXD3_NORMAL_RXV_SEQ		GENMASK(7, 0)
+#define MT_RXD3_NORMAL_CH_FREQ		GENMASK(15, 8)
+#define MT_RXD3_NORMAL_ADDR_TYPE	GENMASK(17, 16)
+#define MT_RXD3_NORMAL_U2M		BIT(0)
+#define MT_RXD3_NORMAL_HTC_VLD		BIT(0)
+#define MT_RXD3_NORMAL_TSF_COMPARE_LOSS	BIT(19)
+#define MT_RXD3_NORMAL_BEACON_MC	BIT(20)
+#define MT_RXD3_NORMAL_BEACON_UC	BIT(21)
+#define MT_RXD3_NORMAL_AMSDU		BIT(22)
+#define MT_RXD3_NORMAL_MESH		BIT(23)
+#define MT_RXD3_NORMAL_MHCP		BIT(24)
+#define MT_RXD3_NORMAL_NO_INFO_WB	BIT(25)
+#define MT_RXD3_NORMAL_DISABLE_RX_HDR_TRANS	BIT(26)
+#define MT_RXD3_NORMAL_POWER_SAVE_STAT	BIT(27)
+#define MT_RXD3_NORMAL_MORE		BIT(28)
+#define MT_RXD3_NORMAL_UNWANT		BIT(29)
+#define MT_RXD3_NORMAL_RX_DROP		BIT(30)
+#define MT_RXD3_NORMAL_VLAN2ETH		BIT(31)
+
+/* RXD DW4 */
+#define MT_RXD4_NORMAL_PAYLOAD_FORMAT	GENMASK(1, 0)
+#define MT_RXD4_NORMAL_PATTERN_DROP	BIT(9)
+#define MT_RXD4_NORMAL_CLS		BIT(10)
+#define MT_RXD4_NORMAL_OFLD		GENMASK(12, 11)
+#define MT_RXD4_NORMAL_MAGIC_PKT	BIT(13)
+#define MT_RXD4_NORMAL_WOL		GENMASK(18, 14)
+#define MT_RXD4_NORMAL_CLS_BITMAP	GENMASK(28, 19)
+#define MT_RXD3_NORMAL_PF_MODE		BIT(29)
+#define MT_RXD3_NORMAL_PF_STS		GENMASK(31, 30)
+
+/* P-RXV */
+#define MT_PRXV_TX_RATE			GENMASK(6, 0)
+#define MT_PRXV_TX_DCM			BIT(4)
+#define MT_PRXV_TX_ER_SU_106T		BIT(5)
+#define MT_PRXV_NSTS			GENMASK(9, 7)
+#define MT_PRXV_HT_AD_CODE		BIT(11)
+#define MT_PRXV_HE_RU_ALLOC_L		GENMASK(31, 28)
+#define MT_PRXV_HE_RU_ALLOC_H		GENMASK(3, 0)
+#define MT_PRXV_RCPI3			GENMASK(31, 24)
+#define MT_PRXV_RCPI2			GENMASK(23, 16)
+#define MT_PRXV_RCPI1			GENMASK(15, 8)
+#define MT_PRXV_RCPI0			GENMASK(7, 0)
+
+/* C-RXV */
+#define MT_CRXV_HT_STBC			GENMASK(1, 0)
+#define MT_CRXV_TX_MODE			GENMASK(7, 4)
+#define MT_CRXV_FRAME_MODE		GENMASK(10, 8)
+#define MT_CRXV_HT_SHORT_GI		GENMASK(14, 13)
+#define MT_CRXV_HE_LTF_SIZE		GENMASK(18, 17)
+#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(20)
+#define MT_CRXV_HE_PE_DISAMBIG		BIT(23)
+#define MT_CRXV_HE_UPLINK		BIT(31)
+
+#define MT_CRXV_HE_SR_MASK		GENMASK(11, 8)
+#define MT_CRXV_HE_SR1_MASK		GENMASK(16, 12)
+#define MT_CRXV_HE_SR2_MASK             GENMASK(20, 17)
+#define MT_CRXV_HE_SR3_MASK             GENMASK(24, 21)
+
+#define MT_CRXV_HE_BSS_COLOR		GENMASK(5, 0)
+#define MT_CRXV_HE_TXOP_DUR		GENMASK(12, 6)
+#define MT_CRXV_HE_BEAM_CHNG		BIT(13)
+#define MT_CRXV_HE_DOPPLER		BIT(16)
+
+#define MT_CRXV_SNR		GENMASK(18, 13)
+#define MT_CRXV_FOE_LO		GENMASK(31, 19)
+#define MT_CRXV_FOE_HI		GENMASK(6, 0)
+#define MT_CRXV_FOE_SHIFT	13
+
+enum tx_header_format {
+	MT_HDR_FORMAT_802_3,
+	MT_HDR_FORMAT_CMD,
+	MT_HDR_FORMAT_802_11,
+	MT_HDR_FORMAT_802_11_EXT,
+};
+
+enum tx_pkt_type {
+	MT_TX_TYPE_CT,
+	MT_TX_TYPE_SF,
+	MT_TX_TYPE_CMD,
+	MT_TX_TYPE_FW,
+};
+
+enum tx_port_idx {
+	MT_TX_PORT_IDX_LMAC,
+	MT_TX_PORT_IDX_MCU
+};
+
+enum tx_mcu_port_q_idx {
+	MT_TX_MCU_PORT_RX_Q0 = 0x20,
+	MT_TX_MCU_PORT_RX_Q1,
+	MT_TX_MCU_PORT_RX_Q2,
+	MT_TX_MCU_PORT_RX_Q3,
+	MT_TX_MCU_PORT_RX_FWDL = 0x3e
+};
+
+#define MT_CT_INFO_APPLY_TXD		BIT(0)
+#define MT_CT_INFO_COPY_HOST_TXD_ALL	BIT(1)
+#define MT_CT_INFO_MGMT_FRAME		BIT(2)
+#define MT_CT_INFO_NONE_CIPHER_FRAME	BIT(3)
+#define MT_CT_INFO_HSR2_TX		BIT(4)
+#define MT_CT_INFO_FROM_HOST		BIT(7)
+
+#define MT_TXD_SIZE			(8 * 4)
+
+#define MT_TXD0_Q_IDX			GENMASK(31, 25)
+#define MT_TXD0_PKT_FMT			GENMASK(24, 23)
+#define MT_TXD0_ETH_TYPE_OFFSET		GENMASK(22, 16)
+#define MT_TXD0_TX_BYTES		GENMASK(15, 0)
+
+#define MT_TXD1_LONG_FORMAT		BIT(31)
+#define MT_TXD1_TGID			BIT(30)
+#define MT_TXD1_OWN_MAC			GENMASK(29, 24)
+#define MT_TXD1_AMSDU			BIT(23)
+#define MT_TXD1_TID			GENMASK(22, 20)
+#define MT_TXD1_HDR_PAD			GENMASK(19, 18)
+#define MT_TXD1_HDR_FORMAT		GENMASK(17, 16)
+#define MT_TXD1_HDR_INFO		GENMASK(15, 11)
+#define MT_TXD1_ETH_802_3		BIT(15)
+#define MT_TXD1_VTA			BIT(10)
+#define MT_TXD1_WLAN_IDX		GENMASK(9, 0)
+
+#define MT_TXD2_FIX_RATE		BIT(31)
+#define MT_TXD2_FIXED_RATE		BIT(30)
+#define MT_TXD2_POWER_OFFSET		GENMASK(29, 24)
+#define MT_TXD2_MAX_TX_TIME		GENMASK(23, 16)
+#define MT_TXD2_FRAG			GENMASK(15, 14)
+#define MT_TXD2_HTC_VLD			BIT(13)
+#define MT_TXD2_DURATION		BIT(12)
+#define MT_TXD2_BIP			BIT(11)
+#define MT_TXD2_MULTICAST		BIT(10)
+#define MT_TXD2_RTS			BIT(9)
+#define MT_TXD2_SOUNDING		BIT(8)
+#define MT_TXD2_NDPA			BIT(7)
+#define MT_TXD2_NDP			BIT(6)
+#define MT_TXD2_FRAME_TYPE		GENMASK(5, 4)
+#define MT_TXD2_SUB_TYPE		GENMASK(3, 0)
+
+#define MT_TXD3_SN_VALID		BIT(31)
+#define MT_TXD3_PN_VALID		BIT(30)
+#define MT_TXD3_SW_POWER_MGMT		BIT(29)
+#define MT_TXD3_BA_DISABLE		BIT(28)
+#define MT_TXD3_SEQ			GENMASK(27, 16)
+#define MT_TXD3_REM_TX_COUNT		GENMASK(15, 11)
+#define MT_TXD3_TX_COUNT		GENMASK(10, 6)
+#define MT_TXD3_TIMING_MEASURE		BIT(5)
+#define MT_TXD3_DAS			BIT(4)
+#define MT_TXD3_EEOSP			BIT(3)
+#define MT_TXD3_EMRD			BIT(2)
+#define MT_TXD3_PROTECT_FRAME		BIT(1)
+#define MT_TXD3_NO_ACK			BIT(0)
+
+#define MT_TXD4_PN_LOW			GENMASK(31, 0)
+
+#define MT_TXD5_PN_HIGH			GENMASK(31, 16)
+#define MT_TXD5_MD			BIT(15)
+#define MT_TXD5_ADD_BA			BIT(14)
+#define MT_TXD5_TX_STATUS_HOST		BIT(10)
+#define MT_TXD5_TX_STATUS_MCU		BIT(9)
+#define MT_TXD5_TX_STATUS_FMT		BIT(8)
+#define MT_TXD5_PID			GENMASK(7, 0)
+
+#define MT_TXD6_TX_IBF			BIT(31)
+#define MT_TXD6_TX_EBF			BIT(30)
+#define MT_TXD6_TX_RATE			GENMASK(29, 16)
+#define MT_TXD6_SGI			GENMASK(15, 14)
+#define MT_TXD6_HELTF			GENMASK(13, 12)
+#define MT_TXD6_LDPC			BIT(11)
+#define MT_TXD6_SPE_ID_IDX		BIT(10)
+#define MT_TXD6_ANT_ID			GENMASK(7, 4)
+#define MT_TXD6_DYN_BW			BIT(3)
+#define MT_TXD6_FIXED_BW		BIT(2)
+#define MT_TXD6_BW			GENMASK(1, 0)
+
+#define MT_TXD7_TXD_LEN			GENMASK(31, 30)
+#define MT_TXD7_UDP_TCP_SUM		BIT(29)
+#define MT_TXD7_IP_SUM			BIT(28)
+
+#define MT_TXD7_TYPE			GENMASK(21, 20)
+#define MT_TXD7_SUB_TYPE		GENMASK(19, 16)
+
+#define MT_TXD7_PSE_FID			GENMASK(27, 16)
+#define MT_TXD7_SPE_IDX			GENMASK(15, 11)
+#define MT_TXD7_HW_AMSDU		BIT(10)
+#define MT_TXD7_TX_TIME			GENMASK(9, 0)
+
+#define MT_TX_RATE_STBC			BIT(13)
+#define MT_TX_RATE_NSS			GENMASK(12, 10)
+#define MT_TX_RATE_MODE			GENMASK(9, 6)
+#define MT_TX_RATE_SU_EXT_TONE		BIT(5)
+#define MT_TX_RATE_DCM			BIT(4)
+#define MT_TX_RATE_IDX			GENMASK(3, 0)
+
+#define MT_TXP_MAX_BUF_NUM		6
+
+struct mt7921_txp {
+	__le16 flags;
+	__le16 token;
+	u8 bss_idx;
+	__le16 rept_wds_wcid;
+	u8 nbuf;
+	__le32 buf[MT_TXP_MAX_BUF_NUM];
+	__le16 len[MT_TXP_MAX_BUF_NUM];
+} __packed __aligned(4);
+
+struct mt7921_tx_free {
+	__le16 rx_byte_cnt;
+	__le16 ctrl;
+	u8 txd_cnt;
+	u8 rsv[3];
+	__le32 info[];
+} __packed __aligned(4);
+
+#define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
+#define MT_TX_FREE_WLAN_ID		GENMASK(23, 14)
+#define MT_TX_FREE_LATENCY		GENMASK(12, 0)
+/* 0: success, others: dropped */
+#define MT_TX_FREE_STATUS		GENMASK(14, 13)
+#define MT_TX_FREE_MSDU_ID		GENMASK(30, 16)
+#define MT_TX_FREE_PAIR			BIT(31)
+/* will support this field in further revision */
+#define MT_TX_FREE_RATE			GENMASK(13, 0)
+
+struct mt7921_dfs_pulse {
+	u32 max_width;		/* us */
+	int max_pwr;		/* dbm */
+	int min_pwr;		/* dbm */
+	u32 min_stgr_pri;	/* us */
+	u32 max_stgr_pri;	/* us */
+	u32 min_cr_pri;		/* us */
+	u32 max_cr_pri;		/* us */
+};
+
+struct mt7921_dfs_pattern {
+	u8 enb;
+	u8 stgr;
+	u8 min_crpn;
+	u8 max_crpn;
+	u8 min_crpr;
+	u8 min_pw;
+	u32 min_pri;
+	u32 max_pri;
+	u8 max_pw;
+	u8 min_crbn;
+	u8 max_crbn;
+	u8 min_stgpn;
+	u8 max_stgpn;
+	u8 min_stgpr;
+	u8 rsv[2];
+	u32 min_stgpr_diff;
+} __packed;
+
+struct mt7921_dfs_radar_spec {
+	struct mt7921_dfs_pulse pulse_th;
+	struct mt7921_dfs_pattern radar_pattern[16];
+};
+
+static inline struct mt7921_txp *
+mt7921_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
+{
+	u8 *txwi;
+
+	if (!t)
+		return NULL;
+
+	txwi = mt76_get_txwi_ptr(dev, t);
+
+	return (struct mt7921_txp *)(txwi + MT_TXD_SIZE);
+}
+
+#define MT_HW_TXP_MAX_MSDU_NUM		4
+#define MT_HW_TXP_MAX_BUF_NUM		4
+
+#define MT_MSDU_ID_VALID		BIT(15)
+
+#define MT_TXD_LEN_MASK			GENMASK(11, 0)
+#define MT_TXD_LEN_MSDU_LAST		BIT(14)
+#define MT_TXD_LEN_AMSDU_LAST		BIT(15)
+#define MT_TXD_LEN_LAST			BIT(15)
+
+struct mt7921_txp_ptr {
+	__le32 buf0;
+	__le16 len0;
+	__le16 len1;
+	__le32 buf1;
+} __packed __aligned(4);
+
+struct mt7921_hw_txp {
+	__le16 msdu_id[MT_HW_TXP_MAX_MSDU_NUM];
+	struct mt7921_txp_ptr ptr[MT_HW_TXP_MAX_BUF_NUM / 2];
+} __packed __aligned(4);
+
+struct mt7921_txp_common {
+	union {
+		struct mt7921_hw_txp hw;
+	};
+};
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
new file mode 100644
index 000000000000..b7467e759c0b
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -0,0 +1,854 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/etherdevice.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+#include "mt7921.h"
+#include "mcu.h"
+
+static bool mt7921_dev_running(struct mt7921_dev *dev)
+{
+	struct mt7921_phy *phy;
+
+	if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
+		return true;
+
+	phy = mt7921_ext_phy(dev);
+
+	return phy && test_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+}
+
+static int mt7921_start(struct ieee80211_hw *hw)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	bool running;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	running = mt7921_dev_running(dev);
+
+	if (!running)
+		mt7921_mcu_set_mac(dev, 0, true, false);
+
+	if (phy != &dev->phy)
+		mt7921_mcu_set_mac(dev, 1, true, false);
+
+	mt7921_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
+
+	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+
+	ieee80211_queue_delayed_work(hw, &phy->mac_work, MT7921_WATCHDOG_TIME);
+
+	if (!running)
+		mt7921_mac_reset_counters(phy);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static void mt7921_stop(struct ieee80211_hw *hw)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+
+	cancel_delayed_work_sync(&phy->mac_work);
+
+	mutex_lock(&dev->mt76.mutex);
+
+	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+
+	if (phy != &dev->phy)
+		mt7921_mcu_set_mac(dev, 1, false, false);
+
+	if (!mt7921_dev_running(dev))
+		mt7921_mcu_set_mac(dev, 0, false, false);
+
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static inline int get_free_idx(u32 mask, u8 start, u8 end)
+{
+	return ffs(~mask & GENMASK(end, start));
+}
+
+static int get_omac_idx(enum nl80211_iftype type, u64 mask)
+{
+	int i;
+
+	switch (type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_STATION:
+		/* prefer hw bssid slot 1-3 */
+		i = get_free_idx(mask, HW_BSSID_1, HW_BSSID_3);
+		if (i)
+			return i - 1;
+
+		if (type != NL80211_IFTYPE_STATION)
+			break;
+
+		/* next, try to find a free repeater entry for the sta */
+		i = get_free_idx(mask >> REPEATER_BSSID_START, 0,
+				 REPEATER_BSSID_MAX - REPEATER_BSSID_START);
+		if (i)
+			return i + 32 - 1;
+
+		i = get_free_idx(mask, EXT_BSSID_1, EXT_BSSID_MAX);
+		if (i)
+			return i - 1;
+
+		if (~mask & BIT(HW_BSSID_0))
+			return HW_BSSID_0;
+
+		break;
+	case NL80211_IFTYPE_MONITOR:
+	case NL80211_IFTYPE_AP:
+		/* ap uses hw bssid 0 and ext bssid */
+		if (~mask & BIT(HW_BSSID_0))
+			return HW_BSSID_0;
+
+		i = get_free_idx(mask, EXT_BSSID_1, EXT_BSSID_MAX);
+		if (i)
+			return i - 1;
+
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	return -1;
+}
+
+static int mt7921_add_interface(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt76_txq *mtxq;
+	bool ext_phy = phy != &dev->phy;
+	int idx, ret = 0;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (vif->type == NL80211_IFTYPE_MONITOR &&
+	    is_zero_ether_addr(vif->addr))
+		phy->monitor_vif = vif;
+
+	mvif->idx = ffs(~phy->mt76->vif_mask) - 1;
+	if (mvif->idx >= MT7921_MAX_INTERFACES) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	idx = get_omac_idx(vif->type, phy->omac_mask);
+	if (idx < 0) {
+		ret = -ENOSPC;
+		goto out;
+	}
+	mvif->omac_idx = idx;
+	mvif->phy = phy;
+	mvif->band_idx = ext_phy;
+
+	if (ext_phy)
+		mvif->wmm_idx = ext_phy * (MT7921_MAX_WMM_SETS / 2) +
+				mvif->idx % (MT7921_MAX_WMM_SETS / 2);
+	else
+		mvif->wmm_idx = mvif->idx % MT7921_MAX_WMM_SETS;
+
+	ret = mt7921_mcu_uni_add_dev(dev, vif, true);
+	if (ret)
+		goto out;
+
+	phy->mt76->vif_mask |= BIT(mvif->idx);
+	phy->omac_mask |= BIT_ULL(mvif->omac_idx);
+
+	idx = MT7921_WTBL_RESERVED - mvif->idx;
+
+	INIT_LIST_HEAD(&mvif->sta.poll_list);
+	mvif->sta.wcid.idx = idx;
+	mvif->sta.wcid.ext_phy = mvif->band_idx;
+	mvif->sta.wcid.hw_key_idx = -1;
+	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mt7921_mac_wtbl_update(dev, idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
+	if (vif->txq) {
+		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+		mtxq->wcid = &mvif->sta.wcid;
+	}
+
+	if (vif->type != NL80211_IFTYPE_AP &&
+	    (!mvif->omac_idx || mvif->omac_idx > 3))
+		vif->offload_flags = 0;
+	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
+
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
+static void mt7921_remove_interface(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_sta *msta = &mvif->sta;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int idx = msta->wcid.idx;
+
+	if (vif == phy->monitor_vif)
+		phy->monitor_vif = NULL;
+
+	mt7921_mcu_uni_add_dev(dev, vif, false);
+
+	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
+
+	mutex_lock(&dev->mt76.mutex);
+	phy->mt76->vif_mask &= ~BIT(mvif->idx);
+	phy->omac_mask &= ~BIT_ULL(mvif->omac_idx);
+	mutex_unlock(&dev->mt76.mutex);
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (!list_empty(&msta->poll_list))
+		list_del_init(&msta->poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+}
+
+int mt7921_set_channel(struct mt7921_phy *phy)
+{
+	struct mt7921_dev *dev = phy->dev;
+	int ret;
+
+	cancel_delayed_work_sync(&phy->mac_work);
+
+	mutex_lock(&dev->mt76.mutex);
+	set_bit(MT76_RESET, &phy->mt76->state);
+
+	mt76_set_channel(phy->mt76);
+
+	ret = mt7921_mcu_set_chan_info(phy, MCU_EXT_CMD_CHANNEL_SWITCH);
+	if (ret)
+		goto out;
+
+	mt7921_mac_set_timing(phy);
+
+	mt7921_mac_reset_counters(phy);
+	phy->noise = 0;
+
+out:
+	clear_bit(MT76_RESET, &phy->mt76->state);
+	mutex_unlock(&dev->mt76.mutex);
+
+	mt76_txq_schedule_all(phy->mt76);
+
+	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
+				     MT7921_WATCHDOG_TIME);
+
+	return ret;
+}
+
+static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *key)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_sta *msta = sta ? (struct mt7921_sta *)sta->drv_priv :
+				  &mvif->sta;
+	struct mt76_wcid *wcid = &msta->wcid;
+	int idx = key->keyidx;
+
+	/* The hardware does not support per-STA RX GTK, fallback
+	 * to software mode for these.
+	 */
+	if ((vif->type == NL80211_IFTYPE_ADHOC ||
+	     vif->type == NL80211_IFTYPE_MESH_POINT) &&
+	    (key->cipher == WLAN_CIPHER_SUITE_TKIP ||
+	     key->cipher == WLAN_CIPHER_SUITE_CCMP) &&
+	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+		return -EOPNOTSUPP;
+
+	/* fall back to sw encryption for unsupported ciphers */
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+	case WLAN_CIPHER_SUITE_SMS4:
+		break;
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (cmd == SET_KEY) {
+		key->hw_key_idx = wcid->idx;
+		wcid->hw_key_idx = idx;
+	} else if (idx == wcid->hw_key_idx) {
+		wcid->hw_key_idx = -1;
+	}
+	mt76_wcid_key_setup(&dev->mt76, wcid,
+			    cmd == SET_KEY ? key : NULL);
+
+	return mt7921_mcu_add_key(dev, vif, msta, key, cmd);
+}
+
+static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	bool band = phy != &dev->phy;
+	int ret;
+
+	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
+		ieee80211_stop_queues(hw);
+		ret = mt7921_set_channel(phy);
+		if (ret)
+			return ret;
+		ieee80211_wake_queues(hw);
+	}
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
+		bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
+
+		if (!enabled)
+			phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
+		else
+			phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
+
+		mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
+			       enabled);
+		mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
+	}
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static int
+mt7921_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
+	       const struct ieee80211_tx_queue_params *params)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+
+	/* no need to update right away, we'll get BSS_CHANGED_QOS */
+	queue = mt7921_lmac_mapping(dev, queue);
+	mvif->queue_params[queue] = *params;
+
+	return 0;
+}
+
+static void mt7921_configure_filter(struct ieee80211_hw *hw,
+				    unsigned int changed_flags,
+				    unsigned int *total_flags,
+				    u64 multicast)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	bool band = phy != &dev->phy;
+
+	u32 ctl_flags = MT_WF_RFCR1_DROP_ACK |
+			MT_WF_RFCR1_DROP_BF_POLL |
+			MT_WF_RFCR1_DROP_BA |
+			MT_WF_RFCR1_DROP_CFEND |
+			MT_WF_RFCR1_DROP_CFACK;
+	u32 flags = 0;
+
+#define MT76_FILTER(_flag, _hw) do {					\
+		flags |= *total_flags & FIF_##_flag;			\
+		phy->rxfilter &= ~(_hw);				\
+		phy->rxfilter |= !(flags & FIF_##_flag) * (_hw);	\
+	} while (0)
+
+	phy->rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
+			   MT_WF_RFCR_DROP_OTHER_BEACON |
+			   MT_WF_RFCR_DROP_FRAME_REPORT |
+			   MT_WF_RFCR_DROP_PROBEREQ |
+			   MT_WF_RFCR_DROP_MCAST_FILTERED |
+			   MT_WF_RFCR_DROP_MCAST |
+			   MT_WF_RFCR_DROP_BCAST |
+			   MT_WF_RFCR_DROP_DUPLICATE |
+			   MT_WF_RFCR_DROP_A2_BSSID |
+			   MT_WF_RFCR_DROP_UNWANTED_CTL |
+			   MT_WF_RFCR_DROP_STBC_MULTI);
+
+	MT76_FILTER(OTHER_BSS, MT_WF_RFCR_DROP_OTHER_TIM |
+			       MT_WF_RFCR_DROP_A3_MAC |
+			       MT_WF_RFCR_DROP_A3_BSSID);
+
+	MT76_FILTER(FCSFAIL, MT_WF_RFCR_DROP_FCSFAIL);
+
+	MT76_FILTER(CONTROL, MT_WF_RFCR_DROP_CTS |
+			     MT_WF_RFCR_DROP_RTS |
+			     MT_WF_RFCR_DROP_CTL_RSV |
+			     MT_WF_RFCR_DROP_NDPA);
+
+	*total_flags = flags;
+	mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
+
+	if (*total_flags & FIF_CONTROL)
+		mt76_clear(dev, MT_WF_RFCR1(band), ctl_flags);
+	else
+		mt76_set(dev, MT_WF_RFCR1(band), ctl_flags);
+}
+
+static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_bss_conf *info,
+				    u32 changed)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (changed & BSS_CHANGED_ERP_SLOT) {
+		int slottime = info->use_short_slot ? 9 : 20;
+
+		if (slottime != phy->slottime) {
+			phy->slottime = slottime;
+			mt7921_mac_set_timing(phy);
+		}
+	}
+
+	if (changed & BSS_CHANGED_BEACON_ENABLED) {
+		mt7921_mcu_uni_add_bss(phy, vif, info->enable_beacon);
+		mt7921_mcu_uni_add_sta(dev, vif, NULL, info->enable_beacon);
+	}
+
+	/* ensure that enable txcmd_mode after bss_info */
+	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
+		mt7921_mcu_set_tx(dev, vif);
+
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	int ret, idx;
+
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
+	if (idx < 0)
+		return -ENOSPC;
+
+	INIT_LIST_HEAD(&msta->poll_list);
+	msta->vif = mvif;
+	msta->wcid.sta = 1;
+	msta->wcid.idx = idx;
+	msta->wcid.ext_phy = mvif->band_idx;
+	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	msta->stats.jiffies = jiffies;
+
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
+		struct mt7921_phy *phy;
+
+		phy = mvif->band_idx ? mt7921_ext_phy(dev) : &dev->phy;
+		mt7921_mcu_uni_add_bss(phy, vif, true);
+	}
+	mt7921_mac_wtbl_update(dev, idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	ret = mt7921_mcu_uni_add_sta(dev, vif, sta, true);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+
+	mt7921_mcu_uni_add_sta(dev, vif, sta, false);
+	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
+		struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+		struct mt7921_phy *phy;
+
+		phy = mvif->band_idx ? mt7921_ext_phy(dev) : &dev->phy;
+		mt7921_mcu_uni_add_bss(phy, vif, false);
+	}
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (!list_empty(&msta->poll_list))
+		list_del_init(&msta->poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+}
+
+static void mt7921_tx(struct ieee80211_hw *hw,
+		      struct ieee80211_tx_control *control,
+		      struct sk_buff *skb)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = info->control.vif;
+	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+
+	if (control->sta) {
+		struct mt7921_sta *sta;
+
+		sta = (struct mt7921_sta *)control->sta->drv_priv;
+		wcid = &sta->wcid;
+	}
+
+	if (vif && !control->sta) {
+		struct mt7921_vif *mvif;
+
+		mvif = (struct mt7921_vif *)vif->drv_priv;
+		wcid = &mvif->sta.wcid;
+	}
+
+	mt76_tx(mphy, control->sta, wcid, skb);
+}
+
+static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+	mt7921_mcu_set_rts_thresh(phy, val);
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static int
+mt7921_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		    struct ieee80211_ampdu_params *params)
+{
+	enum ieee80211_ampdu_mlme_action action = params->action;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct ieee80211_sta *sta = params->sta;
+	struct ieee80211_txq *txq = sta->txq[params->tid];
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	u16 tid = params->tid;
+	u16 ssn = params->ssn;
+	struct mt76_txq *mtxq;
+	int ret = 0;
+
+	if (!txq)
+		return -EINVAL;
+
+	mtxq = (struct mt76_txq *)txq->drv_priv;
+
+	mutex_lock(&dev->mt76.mutex);
+	switch (action) {
+	case IEEE80211_AMPDU_RX_START:
+		mt76_rx_aggr_start(&dev->mt76, &msta->wcid, tid, ssn,
+				   params->buf_size);
+		mt7921_mcu_uni_rx_ba(dev, params, true);
+		break;
+	case IEEE80211_AMPDU_RX_STOP:
+		mt76_rx_aggr_stop(&dev->mt76, &msta->wcid, tid);
+		mt7921_mcu_uni_rx_ba(dev, params, false);
+		break;
+	case IEEE80211_AMPDU_TX_OPERATIONAL:
+		mtxq->aggr = true;
+		mtxq->send_bar = false;
+		mt7921_mcu_uni_tx_ba(dev, params, true);
+		break;
+	case IEEE80211_AMPDU_TX_STOP_FLUSH:
+	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
+		mtxq->aggr = false;
+		clear_bit(tid, &msta->ampdu_state);
+		mt7921_mcu_uni_tx_ba(dev, params, false);
+		break;
+	case IEEE80211_AMPDU_TX_START:
+		set_bit(tid, &msta->ampdu_state);
+		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
+		break;
+	case IEEE80211_AMPDU_TX_STOP_CONT:
+		mtxq->aggr = false;
+		clear_bit(tid, &msta->ampdu_state);
+		mt7921_mcu_uni_tx_ba(dev, params, false);
+		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		break;
+	}
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
+static int
+mt7921_sta_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       struct ieee80211_sta *sta)
+{
+	return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NOTEXIST,
+			      IEEE80211_STA_NONE);
+}
+
+static int
+mt7921_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  struct ieee80211_sta *sta)
+{
+	return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NONE,
+			      IEEE80211_STA_NOTEXIST);
+}
+
+static int
+mt7921_get_stats(struct ieee80211_hw *hw,
+		 struct ieee80211_low_level_stats *stats)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mib_stats *mib = &phy->mib;
+
+	stats->dot11RTSSuccessCount = mib->rts_cnt;
+	stats->dot11RTSFailureCount = mib->rts_retries_cnt;
+	stats->dot11FCSErrorCount = mib->fcs_err_cnt;
+	stats->dot11ACKFailureCount = mib->ack_fail_cnt;
+
+	return 0;
+}
+
+static u64
+mt7921_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	bool band = phy != &dev->phy;
+	union {
+		u64 t64;
+		u32 t32[2];
+	} tsf;
+	u16 n;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	n = mvif->omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : mvif->omac_idx;
+	/* TSF software read */
+	mt76_set(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE);
+	tsf.t32[0] = mt76_rr(dev, MT_LPON_UTTR0(band));
+	tsf.t32[1] = mt76_rr(dev, MT_LPON_UTTR1(band));
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return tsf.t64;
+}
+
+static void
+mt7921_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       u64 timestamp)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	bool band = phy != &dev->phy;
+	union {
+		u64 t64;
+		u32 t32[2];
+	} tsf = { .t64 = timestamp, };
+	u16 n;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	n = mvif->omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : mvif->omac_idx;
+	mt76_wr(dev, MT_LPON_UTTR0(band), tsf.t32[0]);
+	mt76_wr(dev, MT_LPON_UTTR1(band), tsf.t32[1]);
+	/* TSF software overwrite */
+	mt76_set(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_WRITE);
+
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static void
+mt7921_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt7921_dev *dev = phy->dev;
+
+	mutex_lock(&dev->mt76.mutex);
+	phy->coverage_class = max_t(s16, coverage_class, 0);
+	mt7921_mac_set_timing(phy);
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+void mt7921_scan_work(struct work_struct *work)
+{
+	struct mt7921_phy *phy;
+
+	phy = (struct mt7921_phy *)container_of(work, struct mt7921_phy,
+						scan_work.work);
+
+	while (true) {
+		struct mt7921_mcu_rxd *rxd;
+		struct sk_buff *skb;
+
+		spin_lock_bh(&phy->dev->mt76.lock);
+		skb = __skb_dequeue(&phy->scan_event_list);
+		spin_unlock_bh(&phy->dev->mt76.lock);
+
+		if (!skb)
+			break;
+
+		rxd = (struct mt7921_mcu_rxd *)skb->data;
+		if (rxd->eid == MCU_EVENT_SCHED_SCAN_DONE) {
+			ieee80211_sched_scan_results(phy->mt76->hw);
+		} else if (test_and_clear_bit(MT76_HW_SCANNING,
+					      &phy->mt76->state)) {
+			struct cfg80211_scan_info info = {
+				.aborted = false,
+			};
+
+			ieee80211_scan_completed(phy->mt76->hw, &info);
+		}
+		dev_kfree_skb(skb);
+	}
+}
+
+static int
+mt7921_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       struct ieee80211_scan_request *req)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	mutex_lock(&dev->mt76.mutex);
+	err = mt7921_mcu_hw_scan(mphy->priv, vif, req);
+	mutex_unlock(&dev->mt76.mutex);
+
+	return err;
+}
+
+static void
+mt7921_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+
+	mutex_lock(&dev->mt76.mutex);
+	mt7921_mcu_cancel_hw_scan(mphy->priv, vif);
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static int
+mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int max_nss = hweight8(hw->wiphy->available_antennas_tx);
+	bool ext_phy = phy != &dev->phy;
+
+	if (!tx_ant || tx_ant != rx_ant || ffs(tx_ant) > max_nss)
+		return -EINVAL;
+
+	if ((BIT(hweight8(tx_ant)) - 1) != tx_ant)
+		tx_ant = BIT(ffs(tx_ant) - 1) - 1;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	phy->mt76->antenna_mask = tx_ant;
+
+	if (ext_phy) {
+		if (dev->chainmask == 0xf)
+			tx_ant <<= 2;
+		else
+			tx_ant <<= 1;
+	}
+	phy->chainmask = tx_ant;
+
+	mt76_set_stream_caps(phy->mt76, true);
+	mt7921_set_stream_he_caps(phy);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static void mt7921_sta_statistics(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta,
+				  struct station_info *sinfo)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt7921_sta_stats *stats = &msta->stats;
+
+	if (mt7921_mcu_get_rx_rate(phy, vif, sta, &sinfo->rxrate) == 0)
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
+
+	if (!stats->tx_rate.legacy && !stats->tx_rate.flags)
+		return;
+
+	if (stats->tx_rate.legacy) {
+		sinfo->txrate.legacy = stats->tx_rate.legacy;
+	} else {
+		sinfo->txrate.mcs = stats->tx_rate.mcs;
+		sinfo->txrate.nss = stats->tx_rate.nss;
+		sinfo->txrate.bw = stats->tx_rate.bw;
+		sinfo->txrate.he_gi = stats->tx_rate.he_gi;
+		sinfo->txrate.he_dcm = stats->tx_rate.he_dcm;
+		sinfo->txrate.he_ru_alloc = stats->tx_rate.he_ru_alloc;
+	}
+	sinfo->txrate.flags = stats->tx_rate.flags;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+}
+
+static void
+mt7921_sta_rc_update(struct ieee80211_hw *hw,
+		     struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta,
+		     u32 changed)
+{
+}
+
+const struct ieee80211_ops mt7921_ops = {
+	.tx = mt7921_tx,
+	.start = mt7921_start,
+	.stop = mt7921_stop,
+	.add_interface = mt7921_add_interface,
+	.remove_interface = mt7921_remove_interface,
+	.config = mt7921_config,
+	.conf_tx = mt7921_conf_tx,
+	.configure_filter = mt7921_configure_filter,
+	.bss_info_changed = mt7921_bss_info_changed,
+	.sta_add = mt7921_sta_add,
+	.sta_remove = mt7921_sta_remove,
+	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
+	.sta_rc_update = mt7921_sta_rc_update,
+	.set_key = mt7921_set_key,
+	.ampdu_action = mt7921_ampdu_action,
+	.set_rts_threshold = mt7921_set_rts_threshold,
+	.wake_tx_queue = mt76_wake_tx_queue,
+	.sw_scan_start = mt76_sw_scan,
+	.sw_scan_complete = mt76_sw_scan_complete,
+	.release_buffered_frames = mt76_release_buffered_frames,
+	.get_txpower = mt76_get_txpower,
+	.get_stats = mt7921_get_stats,
+	.get_tsf = mt7921_get_tsf,
+	.set_tsf = mt7921_set_tsf,
+	.get_survey = mt76_get_survey,
+	.get_antenna = mt76_get_antenna,
+	.set_antenna = mt7921_set_antenna,
+	.set_coverage_class = mt7921_set_coverage_class,
+	.sta_statistics = mt7921_sta_statistics,
+	.hw_scan = mt7921_hw_scan,
+	.cancel_hw_scan = mt7921_cancel_hw_scan,
+};
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
new file mode 100644
index 000000000000..864f6e9fab3a
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -0,0 +1,2588 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/firmware.h>
+#include <linux/fs.h>
+#include "mt7921.h"
+#include "mcu.h"
+#include "mac.h"
+#include "eeprom.h"
+
+struct mt7921_patch_hdr {
+	char build_date[16];
+	char platform[4];
+	__be32 hw_sw_ver;
+	__be32 patch_ver;
+	__be16 checksum;
+	u16 reserved;
+	struct {
+		__be32 patch_ver;
+		__be32 subsys;
+		__be32 feature;
+		__be32 n_region;
+		__be32 crc;
+		u32 reserved[11];
+	} desc;
+} __packed;
+
+struct mt7921_patch_sec {
+	__be32 type;
+	__be32 offs;
+	__be32 size;
+	union {
+		__be32 spec[13];
+		struct {
+			__be32 addr;
+			__be32 len;
+			__be32 sec_key_idx;
+			__be32 align_len;
+			u32 reserved[9];
+		} info;
+	};
+} __packed;
+
+struct mt7921_fw_trailer {
+	u8 chip_id;
+	u8 eco_code;
+	u8 n_region;
+	u8 format_ver;
+	u8 format_flag;
+	u8 reserved[2];
+	char fw_ver[10];
+	char build_date[15];
+	u32 crc;
+} __packed;
+
+struct mt7921_fw_region {
+	__le32 decomp_crc;
+	__le32 decomp_len;
+	__le32 decomp_blk_sz;
+	u8 reserved[4];
+	__le32 addr;
+	__le32 len;
+	u8 feature_set;
+	u8 reserved1[15];
+} __packed;
+
+#define MCU_PATCH_ADDRESS		0x200000
+
+#define MT_STA_BFER			BIT(0)
+#define MT_STA_BFEE			BIT(1)
+
+#define FW_FEATURE_SET_ENCRYPT		BIT(0)
+#define FW_FEATURE_SET_KEY_IDX		GENMASK(2, 1)
+#define FW_FEATURE_ENCRY_MODE		BIT(4)
+#define FW_FEATURE_OVERRIDE_ADDR	BIT(5)
+
+#define DL_MODE_ENCRYPT			BIT(0)
+#define DL_MODE_KEY_IDX			GENMASK(2, 1)
+#define DL_MODE_RESET_SEC_IV		BIT(3)
+#define DL_MODE_WORKING_PDA_CR4		BIT(4)
+#define DL_CONFIG_ENCRY_MODE_SEL	BIT(6)
+#define DL_MODE_NEED_RSP		BIT(31)
+
+#define FW_START_OVERRIDE		BIT(0)
+#define FW_START_WORKING_PDA_CR4	BIT(2)
+
+#define PATCH_SEC_TYPE_MASK		GENMASK(15, 0)
+#define PATCH_SEC_TYPE_INFO		0x2
+
+#define to_wcid_lo(id)			FIELD_GET(GENMASK(7, 0), (u16)id)
+#define to_wcid_hi(id)			FIELD_GET(GENMASK(9, 8), (u16)id)
+
+#define HE_PHY(p, c)			u8_get_bits(c, IEEE80211_HE_PHY_##p)
+#define HE_MAC(m, c)			u8_get_bits(c, IEEE80211_HE_MAC_##m)
+
+static enum mt7921_cipher_type
+mt7921_mcu_get_cipher(int cipher)
+{
+	switch (cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+		return MT_CIPHER_WEP40;
+	case WLAN_CIPHER_SUITE_WEP104:
+		return MT_CIPHER_WEP104;
+	case WLAN_CIPHER_SUITE_TKIP:
+		return MT_CIPHER_TKIP;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		return MT_CIPHER_BIP_CMAC_128;
+	case WLAN_CIPHER_SUITE_CCMP:
+		return MT_CIPHER_AES_CCMP;
+	case WLAN_CIPHER_SUITE_CCMP_256:
+		return MT_CIPHER_CCMP_256;
+	case WLAN_CIPHER_SUITE_GCMP:
+		return MT_CIPHER_GCMP;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		return MT_CIPHER_GCMP_256;
+	case WLAN_CIPHER_SUITE_SMS4:
+		return MT_CIPHER_WAPI;
+	default:
+		return MT_CIPHER_NONE;
+	}
+}
+
+static u8 mt7921_mcu_chan_bw(struct cfg80211_chan_def *chandef)
+{
+	static const u8 width_to_bw[] = {
+		[NL80211_CHAN_WIDTH_40] = CMD_CBW_40MHZ,
+		[NL80211_CHAN_WIDTH_80] = CMD_CBW_80MHZ,
+		[NL80211_CHAN_WIDTH_80P80] = CMD_CBW_8080MHZ,
+		[NL80211_CHAN_WIDTH_160] = CMD_CBW_160MHZ,
+		[NL80211_CHAN_WIDTH_5] = CMD_CBW_5MHZ,
+		[NL80211_CHAN_WIDTH_10] = CMD_CBW_10MHZ,
+		[NL80211_CHAN_WIDTH_20] = CMD_CBW_20MHZ,
+		[NL80211_CHAN_WIDTH_20_NOHT] = CMD_CBW_20MHZ,
+	};
+
+	if (chandef->width >= ARRAY_SIZE(width_to_bw))
+		return 0;
+
+	return width_to_bw[chandef->width];
+}
+
+static const struct ieee80211_sta_he_cap *
+mt7921_get_he_phy_cap(struct mt7921_phy *phy, struct ieee80211_vif *vif)
+{
+	struct ieee80211_supported_band *sband;
+	enum nl80211_band band;
+
+	band = phy->mt76->chandef.chan->band;
+	sband = phy->mt76->hw->wiphy->bands[band];
+
+	return ieee80211_get_he_iftype_cap(sband, vif->type);
+}
+
+static u8
+mt7921_get_phy_mode(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		    enum nl80211_band band, struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_ht_cap *ht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap;
+	const struct ieee80211_sta_he_cap *he_cap;
+	u8 mode = 0;
+
+	if (sta) {
+		ht_cap = &sta->ht_cap;
+		vht_cap = &sta->vht_cap;
+		he_cap = &sta->he_cap;
+	} else {
+		struct ieee80211_supported_band *sband;
+		struct mt7921_phy *phy;
+		struct mt7921_vif *mvif;
+
+		mvif = (struct mt7921_vif *)vif->drv_priv;
+		phy = mvif->band_idx ? mt7921_ext_phy(dev) : &dev->phy;
+		sband = phy->mt76->hw->wiphy->bands[band];
+
+		ht_cap = &sband->ht_cap;
+		vht_cap = &sband->vht_cap;
+		he_cap = ieee80211_get_he_iftype_cap(sband, vif->type);
+	}
+
+	if (band == NL80211_BAND_2GHZ) {
+		mode |= PHY_MODE_B | PHY_MODE_G;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_MODE_GN;
+
+		if (he_cap->has_he)
+			mode |= PHY_MODE_AX_24G;
+	} else if (band == NL80211_BAND_5GHZ) {
+		mode |= PHY_MODE_A;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_MODE_AN;
+
+		if (vht_cap->vht_supported)
+			mode |= PHY_MODE_AC;
+
+		if (he_cap->has_he)
+			mode |= PHY_MODE_AX_5G;
+	}
+
+	return mode;
+}
+
+static u8
+mt7921_get_phy_mode_v2(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       enum nl80211_band band, struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_ht_cap *ht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap;
+	const struct ieee80211_sta_he_cap *he_cap;
+	u8 mode = 0;
+
+	if (sta) {
+		ht_cap = &sta->ht_cap;
+		vht_cap = &sta->vht_cap;
+		he_cap = &sta->he_cap;
+	} else {
+		struct ieee80211_supported_band *sband;
+		struct mt7921_phy *phy;
+		struct mt7921_vif *mvif;
+
+		mvif = (struct mt7921_vif *)vif->drv_priv;
+		phy = mvif->band_idx ? mt7921_ext_phy(dev) : &dev->phy;
+		sband = phy->mt76->hw->wiphy->bands[band];
+
+		ht_cap = &sband->ht_cap;
+		vht_cap = &sband->vht_cap;
+		he_cap = ieee80211_get_he_iftype_cap(sband, vif->type);
+	}
+
+	if (band == NL80211_BAND_2GHZ) {
+		mode |= PHY_TYPE_BIT_HR_DSSS | PHY_TYPE_BIT_ERP;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_TYPE_BIT_HT;
+
+		if (he_cap->has_he)
+			mode |= PHY_TYPE_BIT_HE;
+	} else if (band == NL80211_BAND_5GHZ) {
+		mode |= PHY_TYPE_BIT_OFDM;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_TYPE_BIT_HT;
+
+		if (vht_cap->vht_supported)
+			mode |= PHY_TYPE_BIT_VHT;
+
+		if (he_cap->has_he)
+			mode |= PHY_TYPE_BIT_HE;
+	}
+
+	return mode;
+}
+
+static int
+mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_eeprom_info *res;
+	u8 *buf;
+
+	if (!skb)
+		return -EINVAL;
+
+	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+
+	res = (struct mt7921_mcu_eeprom_info *)skb->data;
+	buf = dev->eeprom.data + le32_to_cpu(res->addr);
+	memcpy(buf, res->data, 16);
+
+	return 0;
+}
+
+static int
+mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			  struct sk_buff *skb, int seq)
+{
+	struct mt7921_mcu_rxd *rxd;
+	int ret = 0;
+
+	if (!skb) {
+		dev_err(mdev->dev, "Message %d (seq %d) timeout\n",
+			cmd, seq);
+		return -ETIMEDOUT;
+	}
+
+	rxd = (struct mt7921_mcu_rxd *)skb->data;
+	if (seq != rxd->seq)
+		return -EAGAIN;
+
+	switch (cmd) {
+	case MCU_CMD_PATCH_SEM_CONTROL:
+		skb_pull(skb, sizeof(*rxd) - 4);
+		ret = *skb->data;
+		break;
+	case MCU_EXT_CMD_THERMAL_CTRL:
+		skb_pull(skb, sizeof(*rxd) + 4);
+		ret = le32_to_cpu(*(__le32 *)skb->data);
+		break;
+	case MCU_EXT_CMD_EFUSE_ACCESS:
+		ret = mt7921_mcu_parse_eeprom(mdev, skb);
+		break;
+	case MCU_UNI_CMD_DEV_INFO_UPDATE:
+	case MCU_UNI_CMD_BSS_INFO_UPDATE:
+	case MCU_UNI_CMD_STA_REC_UPDATE:
+	case MCU_UNI_CMD_HIF_CTRL:
+	case MCU_UNI_CMD_OFFLOAD:
+	case MCU_UNI_CMD_SUSPEND: {
+		struct mt7921_mcu_uni_event *event;
+
+		skb_pull(skb, sizeof(*rxd));
+		event = (struct mt7921_mcu_uni_event *)skb->data;
+		ret = le32_to_cpu(event->status);
+		break;
+	}
+	case MCU_CMD_REG_READ: {
+		struct mt7921_mcu_reg_event *event;
+
+		skb_pull(skb, sizeof(*rxd));
+		event = (struct mt7921_mcu_reg_event *)skb->data;
+		ret = (int)le32_to_cpu(event->val);
+		break;
+	}
+	default:
+		skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+		break;
+	}
+
+	return ret;
+}
+
+static int
+mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			int cmd, int *wait_seq)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	int txd_len, mcu_cmd = cmd & MCU_CMD_MASK;
+	enum mt76_txq_id txq = MT_MCUQ_WM;
+	struct mt7921_uni_txd *uni_txd;
+	struct mt7921_mcu_txd *mcu_txd;
+	u8 seq, pkt_fmt, qidx;
+	__le32 *txd;
+	u32 val;
+
+	/* TODO: make dynamic based on msg type */
+	mdev->mcu.timeout = 20 * HZ;
+
+	seq = ++dev->mt76.mcu.msg_seq & 0xf;
+	if (!seq)
+		seq = ++dev->mt76.mcu.msg_seq & 0xf;
+
+	if (cmd == MCU_CMD_FW_SCATTER) {
+		txq = MT_MCUQ_FWDL;
+		goto exit;
+	}
+
+	txd_len = cmd & MCU_UNI_PREFIX ? sizeof(*uni_txd) : sizeof(*mcu_txd);
+	txd = (__le32 *)skb_push(skb, txd_len);
+
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state)) {
+		qidx = MT_TX_MCU_PORT_RX_Q0;
+		pkt_fmt = MT_TX_TYPE_CMD;
+	} else {
+		qidx = MT_TX_MCU_PORT_RX_Q0;
+		pkt_fmt = MT_TX_TYPE_CMD;
+	}
+
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len) |
+	      FIELD_PREP(MT_TXD0_PKT_FMT, pkt_fmt) |
+	      FIELD_PREP(MT_TXD0_Q_IDX, qidx);
+	txd[0] = cpu_to_le32(val);
+
+	val = MT_TXD1_LONG_FORMAT |
+	      FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_CMD);
+	txd[1] = cpu_to_le32(val);
+
+	if (cmd & MCU_UNI_PREFIX) {
+		uni_txd = (struct mt7921_uni_txd *)txd;
+		uni_txd->len = cpu_to_le16(skb->len - sizeof(uni_txd->txd));
+		uni_txd->option = MCU_CMD_UNI_EXT_ACK;
+		uni_txd->cid = cpu_to_le16(mcu_cmd);
+		uni_txd->s2d_index = MCU_S2D_H2N;
+		uni_txd->pkt_type = MCU_PKT_ID;
+		uni_txd->seq = seq;
+
+		goto exit;
+	}
+
+	mcu_txd = (struct mt7921_mcu_txd *)txd;
+	mcu_txd->len = cpu_to_le16(skb->len - sizeof(mcu_txd->txd));
+	mcu_txd->pq_id = cpu_to_le16(MCU_PQ_ID(MT_TX_PORT_IDX_MCU, qidx));
+	mcu_txd->pkt_type = MCU_PKT_ID;
+	mcu_txd->seq = seq;
+
+	switch (cmd & ~MCU_CMD_MASK) {
+	case MCU_FW_PREFIX:
+		mcu_txd->set_query = MCU_Q_NA;
+		mcu_txd->cid = mcu_cmd;
+		break;
+	case MCU_CE_PREFIX:
+		if (cmd & MCU_QUERY_MASK)
+			mcu_txd->set_query = MCU_Q_QUERY;
+		else
+			mcu_txd->set_query = MCU_Q_SET;
+		mcu_txd->cid = mcu_cmd;
+		break;
+	default:
+		mcu_txd->cid = MCU_CMD_EXT_CID;
+		if (cmd & MCU_QUERY_PREFIX || cmd == MCU_EXT_CMD_EFUSE_ACCESS)
+			mcu_txd->set_query = MCU_Q_QUERY;
+		else
+			mcu_txd->set_query = MCU_Q_SET;
+		mcu_txd->ext_cid = mcu_cmd;
+		mcu_txd->ext_cid_ack = 1;
+		break;
+	}
+
+	if (cmd == MCU_EXT_CMD_MWDS_SUPPORT)
+		mcu_txd->s2d_index = MCU_S2D_H2C;
+	else
+		mcu_txd->s2d_index = MCU_S2D_H2N;
+	WARN_ON(cmd == MCU_EXT_CMD_EFUSE_ACCESS &&
+		mcu_txd->set_query != MCU_Q_QUERY);
+
+exit:
+	if (wait_seq)
+		*wait_seq = seq;
+
+	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[txq], skb, 0);
+}
+
+static void
+mt7921_mcu_tx_rate_parse(struct mt76_phy *mphy, struct mt7921_mcu_ra_info *ra,
+			 struct rate_info *rate, u16 r)
+{
+	struct ieee80211_supported_band *sband;
+	u16 ru_idx = le16_to_cpu(ra->ru_idx);
+	u16 flags = 0;
+
+	rate->mcs = FIELD_GET(MT_RA_RATE_MCS, r);
+	rate->nss = FIELD_GET(MT_RA_RATE_NSS, r) + 1;
+
+	switch (FIELD_GET(MT_RA_RATE_TX_MODE, r)) {
+	case MT_PHY_TYPE_CCK:
+	case MT_PHY_TYPE_OFDM:
+		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &mphy->sband_5g.sband;
+		else
+			sband = &mphy->sband_2g.sband;
+
+		rate->legacy = sband->bitrates[rate->mcs].bitrate;
+		break;
+	case MT_PHY_TYPE_HT:
+	case MT_PHY_TYPE_HT_GF:
+		rate->mcs += (rate->nss - 1) * 8;
+		flags |= RATE_INFO_FLAGS_MCS;
+
+		if (ra->gi)
+			flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_VHT:
+		flags |= RATE_INFO_FLAGS_VHT_MCS;
+
+		if (ra->gi)
+			flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+	case MT_PHY_TYPE_HE_MU:
+		rate->he_gi = ra->gi;
+		rate->he_dcm = FIELD_GET(MT_RA_RATE_DCM_EN, r);
+
+		flags |= RATE_INFO_FLAGS_HE_MCS;
+		break;
+	default:
+		break;
+	}
+	rate->flags = flags;
+
+	if (ru_idx) {
+		switch (ru_idx) {
+		case 1 ... 2:
+			rate->he_ru_alloc = NL80211_RATE_INFO_HE_RU_ALLOC_996;
+			break;
+		case 3 ... 6:
+			rate->he_ru_alloc = NL80211_RATE_INFO_HE_RU_ALLOC_484;
+			break;
+		case 7 ... 14:
+			rate->he_ru_alloc = NL80211_RATE_INFO_HE_RU_ALLOC_242;
+			break;
+		default:
+			rate->he_ru_alloc = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+			break;
+		}
+		rate->bw = RATE_INFO_BW_HE_RU;
+	} else {
+		u8 bw = mt7921_mcu_chan_bw(&mphy->chandef) -
+			FIELD_GET(MT_RA_RATE_BW, r);
+
+		switch (bw) {
+		case IEEE80211_STA_RX_BW_160:
+			rate->bw = RATE_INFO_BW_160;
+			break;
+		case IEEE80211_STA_RX_BW_80:
+			rate->bw = RATE_INFO_BW_80;
+			break;
+		case IEEE80211_STA_RX_BW_40:
+			rate->bw = RATE_INFO_BW_40;
+			break;
+		default:
+			rate->bw = RATE_INFO_BW_20;
+			break;
+		}
+	}
+}
+
+static void
+mt7921_mcu_tx_rate_report(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_ra_info *ra = (struct mt7921_mcu_ra_info *)skb->data;
+	struct rate_info rate = {}, prob_rate = {};
+	u16 probe = le16_to_cpu(ra->prob_up_rate);
+	u16 attempts = le16_to_cpu(ra->attempts);
+	u16 curr = le16_to_cpu(ra->curr_rate);
+	u16 wcidx = le16_to_cpu(ra->wlan_idx);
+	struct mt76_phy *mphy = &dev->mphy;
+	struct mt7921_sta_stats *stats;
+	struct mt7921_sta *msta;
+	struct mt76_wcid *wcid;
+
+	if (wcidx >= MT76_N_WCIDS)
+		return;
+
+	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	if (!wcid)
+		return;
+
+	msta = container_of(wcid, struct mt7921_sta, wcid);
+	stats = &msta->stats;
+
+	if (msta->wcid.ext_phy && dev->mt76.phy2)
+		mphy = dev->mt76.phy2;
+
+	/* current rate */
+	mt7921_mcu_tx_rate_parse(mphy, ra, &rate, curr);
+	stats->tx_rate = rate;
+
+	/* probing rate */
+	mt7921_mcu_tx_rate_parse(mphy, ra, &prob_rate, probe);
+	stats->prob_rate = prob_rate;
+
+	if (attempts) {
+		u16 success = le16_to_cpu(ra->success);
+
+		stats->per = 1000 * (attempts - success) / attempts;
+	}
+}
+
+static void
+mt7921_mcu_rx_ext_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_rxd *rxd = (struct mt7921_mcu_rxd *)skb->data;
+
+	switch (rxd->ext_eid) {
+	case MCU_EXT_EVENT_RATE_REPORT:
+		mt7921_mcu_tx_rate_report(dev, skb);
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	u8 *seq_num = skb->data + sizeof(struct mt7921_mcu_rxd);
+	struct mt7921_phy *phy;
+	struct mt76_phy *mphy;
+
+	if (*seq_num & BIT(7) && dev->mt76.phy2)
+		mphy = dev->mt76.phy2;
+	else
+		mphy = &dev->mt76.phy;
+
+	phy = (struct mt7921_phy *)mphy->priv;
+
+	spin_lock_bh(&dev->mt76.lock);
+	__skb_queue_tail(&phy->scan_event_list, skb);
+	spin_unlock_bh(&dev->mt76.lock);
+
+	ieee80211_queue_delayed_work(mphy->hw, &phy->scan_work,
+				     MT7921_HW_SCAN_TIMEOUT);
+}
+
+static void
+mt7921_mcu_bss_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_bss_event *event;
+	struct mt76_phy *mphy;
+	u8 band_idx = 0; /* DBDC support */
+
+	event = (struct mt7921_mcu_bss_event *)(skb->data +
+						sizeof(struct mt7921_mcu_rxd));
+
+	if (band_idx && dev->mt76.phy2)
+		mphy = dev->mt76.phy2;
+	else
+		mphy = &dev->mt76.phy;
+
+	if (event->is_absent)
+		ieee80211_stop_queues(mphy->hw);
+	else
+		ieee80211_wake_queues(mphy->hw);
+}
+
+static void
+mt7921_mcu_debug_msg_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_rxd *rxd = (struct mt7921_mcu_rxd *)skb->data;
+	struct debug_msg {
+		__le16 id;
+		u8 type;
+		u8 flag;
+		__le32 value;
+		__le16 len;
+		u8 content[512];
+	} __packed * debug_msg;
+	u16 cur_len;
+	int i;
+
+	skb_pull(skb, sizeof(*rxd));
+	debug_msg = (struct debug_msg *)skb->data;
+
+	cur_len = min_t(u16, le16_to_cpu(debug_msg->len), 512);
+
+	if (debug_msg->type == 0x3) {
+		for (i = 0 ; i < cur_len; i++)
+			if (!debug_msg->content[i])
+				debug_msg->content[i] = ' ';
+
+		trace_printk("%s", debug_msg->content);
+	}
+}
+
+static void
+mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_rxd *rxd = (struct mt7921_mcu_rxd *)skb->data;
+
+	switch (rxd->eid) {
+	case MCU_EVENT_EXT:
+		mt7921_mcu_rx_ext_event(dev, skb);
+		break;
+	case MCU_EVENT_BSS_BEACON_LOSS:
+		break;
+	case MCU_EVENT_ROC:
+		break;
+	case MCU_EVENT_SCHED_SCAN_DONE:
+	case MCU_EVENT_SCAN_DONE:
+		mt7921_mcu_scan_event(dev, skb);
+		return;
+	case MCU_EVENT_BSS_ABSENCE:
+		mt7921_mcu_bss_event(dev, skb);
+		break;
+	case MCU_EVENT_DBG_MSG:
+		mt7921_mcu_debug_msg_event(dev, skb);
+		break;
+	default:
+		break;
+	}
+	dev_kfree_skb(skb);
+}
+
+void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_rxd *rxd = (struct mt7921_mcu_rxd *)skb->data;
+
+	if (rxd->eid == 0x6) {
+		mt76_mcu_rx_event(&dev->mt76, skb);
+		return;
+	}
+
+	if (rxd->ext_eid == MCU_EXT_EVENT_RATE_REPORT ||
+	    rxd->eid == MCU_EVENT_BSS_BEACON_LOSS ||
+	    rxd->eid == MCU_EVENT_SCHED_SCAN_DONE ||
+	    rxd->eid == MCU_EVENT_BSS_ABSENCE ||
+	    rxd->eid == MCU_EVENT_SCAN_DONE ||
+	    rxd->eid == MCU_EVENT_DBG_MSG ||
+	    rxd->eid == MCU_EVENT_ROC ||
+	    !rxd->seq)
+		mt7921_mcu_rx_unsolicited_event(dev, skb);
+	else
+		mt76_mcu_rx_event(&dev->mt76, skb);
+}
+
+static struct sk_buff *
+mt7921_mcu_alloc_sta_req(struct mt7921_dev *dev, struct mt7921_vif *mvif,
+			 struct mt7921_sta *msta, int len)
+{
+	struct sta_req_hdr hdr = {
+		.bss_idx = mvif->idx,
+		.wlan_idx_lo = msta ? to_wcid_lo(msta->wcid.idx) : 0,
+		.wlan_idx_hi = msta ? to_wcid_hi(msta->wcid.idx) : 0,
+		.muar_idx = msta ? mvif->omac_idx : 0,
+		.is_tlv_append = 1,
+	};
+	struct sk_buff *skb;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	return skb;
+}
+
+static struct wtbl_req_hdr *
+mt7921_mcu_alloc_wtbl_req(struct mt7921_dev *dev, struct mt7921_sta *msta,
+			  int cmd, void *sta_wtbl, struct sk_buff **skb)
+{
+	struct tlv *sta_hdr = sta_wtbl;
+	struct wtbl_req_hdr hdr = {
+		.wlan_idx_lo = to_wcid_lo(msta->wcid.idx),
+		.wlan_idx_hi = to_wcid_hi(msta->wcid.idx),
+		.operation = cmd,
+	};
+	struct sk_buff *nskb = *skb;
+
+	if (!nskb) {
+		nskb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
+					  MT7921_WTBL_UPDATE_BA_SIZE);
+		if (!nskb)
+			return ERR_PTR(-ENOMEM);
+
+		*skb = nskb;
+	}
+
+	if (sta_hdr)
+		sta_hdr->len = cpu_to_le16(sizeof(hdr));
+
+	return skb_put_data(nskb, &hdr, sizeof(hdr));
+}
+
+static struct tlv *
+mt7921_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
+			  void *sta_ntlv, void *sta_wtbl)
+{
+	struct sta_ntlv_hdr *ntlv_hdr = sta_ntlv;
+	struct tlv *sta_hdr = sta_wtbl;
+	struct tlv *ptlv, tlv = {
+		.tag = cpu_to_le16(tag),
+		.len = cpu_to_le16(len),
+	};
+	u16 ntlv;
+
+	ptlv = skb_put(skb, len);
+	memcpy(ptlv, &tlv, sizeof(tlv));
+
+	ntlv = le16_to_cpu(ntlv_hdr->tlv_num);
+	ntlv_hdr->tlv_num = cpu_to_le16(ntlv + 1);
+
+	if (sta_hdr) {
+		u16 size = le16_to_cpu(sta_hdr->len);
+
+		sta_hdr->len = cpu_to_le16(size + len);
+	}
+
+	return ptlv;
+}
+
+static struct tlv *
+mt7921_mcu_add_tlv(struct sk_buff *skb, int tag, int len)
+{
+	return mt7921_mcu_add_nested_tlv(skb, tag, len, skb->data, NULL);
+}
+
+static void
+mt7921_mcu_uni_bss_he_tlv(struct tlv *tlv, struct ieee80211_vif *vif,
+			  struct mt7921_phy *phy)
+{
+#define DEFAULT_HE_PE_DURATION		4
+#define DEFAULT_HE_DURATION_RTS_THRES	1023
+	const struct ieee80211_sta_he_cap *cap;
+	struct bss_info_uni_he *he;
+
+	cap = mt7921_get_he_phy_cap(phy, vif);
+
+	he = (struct bss_info_uni_he *)tlv;
+	he->he_pe_duration = vif->bss_conf.htc_trig_based_pkt_ext;
+	if (!he->he_pe_duration)
+		he->he_pe_duration = DEFAULT_HE_PE_DURATION;
+
+	he->he_rts_thres = cpu_to_le16(vif->bss_conf.frame_time_rts_th);
+	if (!he->he_rts_thres)
+		he->he_rts_thres = cpu_to_le16(DEFAULT_HE_DURATION_RTS_THRES);
+
+	he->max_nss_mcs[CMD_HE_MCS_BW80] = cap->he_mcs_nss_supp.tx_mcs_80;
+	he->max_nss_mcs[CMD_HE_MCS_BW160] = cap->he_mcs_nss_supp.tx_mcs_160;
+	he->max_nss_mcs[CMD_HE_MCS_BW8080] = cap->he_mcs_nss_supp.tx_mcs_80p80;
+}
+
+/** starec & wtbl **/
+static int
+mt7921_mcu_sta_key_tlv(struct sk_buff *skb, struct ieee80211_key_conf *key,
+		       enum set_key_cmd cmd)
+{
+	struct sta_rec_sec *sec;
+	struct tlv *tlv;
+	u32 len = sizeof(*sec);
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_KEY_V2, sizeof(*sec));
+
+	sec = (struct sta_rec_sec *)tlv;
+	sec->add = cmd;
+
+	if (cmd == SET_KEY) {
+		struct sec_key *sec_key;
+		u8 cipher;
+
+		cipher = mt7921_mcu_get_cipher(key->cipher);
+		if (cipher == MT_CIPHER_NONE)
+			return -EOPNOTSUPP;
+
+		sec_key = &sec->key[0];
+		sec_key->cipher_len = sizeof(*sec_key);
+		sec_key->key_id = key->keyidx;
+
+		if (cipher == MT_CIPHER_BIP_CMAC_128) {
+			sec_key->cipher_id = MT_CIPHER_AES_CCMP;
+			sec_key->key_len = 16;
+			memcpy(sec_key->key, key->key, 16);
+
+			sec_key = &sec->key[1];
+			sec_key->cipher_id = MT_CIPHER_BIP_CMAC_128;
+			sec_key->cipher_len = sizeof(*sec_key);
+			sec_key->key_len = 16;
+			memcpy(sec_key->key, key->key + 16, 16);
+
+			sec->n_cipher = 2;
+		} else {
+			sec_key->cipher_id = cipher;
+			sec_key->key_len = key->keylen;
+			memcpy(sec_key->key, key->key, key->keylen);
+
+			if (cipher == MT_CIPHER_TKIP) {
+				/* Rx/Tx MIC keys are swapped */
+				memcpy(sec_key->key + 16, key->key + 24, 8);
+				memcpy(sec_key->key + 24, key->key + 16, 8);
+			}
+
+			len -= sizeof(*sec_key);
+			sec->n_cipher = 1;
+		}
+	} else {
+		len -= sizeof(sec->key);
+		sec->n_cipher = 0;
+	}
+	sec->len = cpu_to_le16(len);
+
+	return 0;
+}
+
+int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       struct mt7921_sta *msta, struct ieee80211_key_conf *key,
+		       enum set_key_cmd cmd)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct sk_buff *skb;
+	int len = sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_sec);
+	int ret;
+
+	skb = mt7921_mcu_alloc_sta_req(dev, mvif, msta, len);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	ret = mt7921_mcu_sta_key_tlv(skb, key, cmd);
+	if (ret)
+		return ret;
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_UNI_CMD_STA_REC_UPDATE, true);
+}
+
+static void
+mt7921_mcu_sta_ba_tlv(struct sk_buff *skb,
+		      struct ieee80211_ampdu_params *params,
+		      bool enable, bool tx)
+{
+	struct sta_rec_ba *ba;
+	struct tlv *tlv;
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_BA, sizeof(*ba));
+
+	ba = (struct sta_rec_ba *)tlv;
+	ba->ba_type = tx ? MT_BA_TYPE_ORIGINATOR : MT_BA_TYPE_RECIPIENT,
+	ba->winsize = cpu_to_le16(params->buf_size);
+	ba->ssn = cpu_to_le16(params->ssn);
+	ba->ba_en = enable << params->tid;
+	ba->amsdu = params->amsdu;
+	ba->tid = params->tid;
+}
+
+static void
+mt7921_mcu_wtbl_ba_tlv(struct sk_buff *skb,
+		       struct ieee80211_ampdu_params *params,
+		       bool enable, bool tx, void *sta_wtbl,
+		       void *wtbl_tlv)
+{
+	struct wtbl_ba *ba;
+	struct tlv *tlv;
+
+	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_BA, sizeof(*ba),
+					wtbl_tlv, sta_wtbl);
+
+	ba = (struct wtbl_ba *)tlv;
+	ba->tid = params->tid;
+
+	if (tx) {
+		ba->ba_type = MT_BA_TYPE_ORIGINATOR;
+		ba->sn = enable ? cpu_to_le16(params->ssn) : 0;
+		ba->ba_en = enable;
+	} else {
+		memcpy(ba->peer_addr, params->sta->addr, ETH_ALEN);
+		ba->ba_type = MT_BA_TYPE_RECIPIENT;
+		ba->rst_ba_tid = params->tid;
+		ba->rst_ba_sel = RST_BA_MAC_TID_MATCH;
+		ba->rst_ba_sb = 1;
+	}
+
+	if (enable && tx)
+		ba->ba_winsize = cpu_to_le16(params->buf_size);
+}
+
+static int
+mt7921_mcu_sta_ba(struct mt7921_dev *dev,
+		  struct ieee80211_ampdu_params *params,
+		  bool enable, bool tx, int cmd)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)params->sta->drv_priv;
+	struct mt7921_vif *mvif = msta->vif;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct tlv *sta_wtbl;
+	struct sk_buff *skb;
+	int ret;
+
+	if (enable && tx && !params->amsdu)
+		msta->wcid.amsdu = false;
+
+	skb = mt7921_mcu_alloc_sta_req(dev, mvif, msta,
+				       MT7921_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	sta_wtbl = mt7921_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
+
+	wtbl_hdr = mt7921_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
+					     &skb);
+	mt7921_mcu_wtbl_ba_tlv(skb, params, enable, tx, sta_wtbl, wtbl_hdr);
+
+	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
+	if (ret)
+		return ret;
+
+	skb = mt7921_mcu_alloc_sta_req(dev, mvif, msta,
+				       MT7921_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7921_mcu_sta_ba_tlv(skb, params, enable, tx);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
+}
+
+int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable)
+{
+	return mt7921_mcu_sta_ba(dev, params, enable, true, MCU_UNI_CMD_STA_REC_UPDATE);
+}
+
+int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable)
+{
+	return mt7921_mcu_sta_ba(dev, params, enable, false, MCU_UNI_CMD_STA_REC_UPDATE);
+}
+
+static void
+mt7921_mcu_wtbl_generic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, void *sta_wtbl,
+			    void *wtbl_tlv)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct wtbl_generic *generic;
+	struct wtbl_rx *rx;
+	struct tlv *tlv;
+
+	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_GENERIC, sizeof(*generic),
+					wtbl_tlv, sta_wtbl);
+
+	generic = (struct wtbl_generic *)tlv;
+
+	if (sta) {
+		if (vif->type == NL80211_IFTYPE_STATION)
+			generic->partial_aid = cpu_to_le16(vif->bss_conf.aid);
+		else
+			generic->partial_aid = cpu_to_le16(sta->aid);
+		memcpy(generic->peer_addr, sta->addr, ETH_ALEN);
+		generic->muar_idx = mvif->omac_idx;
+		generic->qos = sta->wme;
+	} else {
+		/* use BSSID in station mode */
+		if (vif->type == NL80211_IFTYPE_STATION)
+			memcpy(generic->peer_addr, vif->bss_conf.bssid,
+			       ETH_ALEN);
+		else
+			eth_broadcast_addr(generic->peer_addr);
+
+		generic->muar_idx = 0xe;
+	}
+
+	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_RX, sizeof(*rx),
+					wtbl_tlv, sta_wtbl);
+
+	rx = (struct wtbl_rx *)tlv;
+	rx->rca1 = sta ? vif->type != NL80211_IFTYPE_AP : 1;
+	rx->rca2 = 1;
+	rx->rv = 1;
+}
+
+static void
+mt7921_mcu_sta_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, bool enable)
+{
+#define EXTRA_INFO_VER          BIT(0)
+#define EXTRA_INFO_NEW          BIT(1)
+	struct sta_rec_basic *basic;
+	struct tlv *tlv;
+	int conn_type;
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_BASIC, sizeof(*basic));
+
+	basic = (struct sta_rec_basic *)tlv;
+	basic->extra_info = cpu_to_le16(EXTRA_INFO_VER);
+
+	if (enable) {
+		basic->extra_info |= cpu_to_le16(EXTRA_INFO_NEW);
+		basic->conn_state = CONN_STATE_PORT_SECURE;
+	} else {
+		basic->conn_state = CONN_STATE_DISCONNECT;
+	}
+
+	if (!sta) {
+		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
+		eth_broadcast_addr(basic->peer_addr);
+		return;
+	}
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GC;
+		else
+			conn_type = CONNECTION_INFRA_STA;
+		basic->conn_type = cpu_to_le32(conn_type);
+		basic->aid = cpu_to_le16(sta->aid);
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GO;
+		else
+			conn_type = CONNECTION_INFRA_AP;
+		basic->conn_type = cpu_to_le32(conn_type);
+		basic->aid = cpu_to_le16(vif->bss_conf.aid);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		basic->aid = cpu_to_le16(sta->aid);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	memcpy(basic->peer_addr, sta->addr, ETH_ALEN);
+	basic->qos = sta->wme;
+}
+
+static void
+mt7921_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
+	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
+	struct sta_rec_he *he;
+	struct tlv *tlv;
+	u32 cap = 0;
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_HE, sizeof(*he));
+
+	he = (struct sta_rec_he *)tlv;
+
+	if (elem->mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_HTC_HE)
+		cap |= STA_REC_HE_CAP_HTC;
+
+	if (elem->mac_cap_info[2] & IEEE80211_HE_MAC_CAP2_BSR)
+		cap |= STA_REC_HE_CAP_BSR;
+
+	if (elem->mac_cap_info[3] & IEEE80211_HE_MAC_CAP3_OMI_CONTROL)
+		cap |= STA_REC_HE_CAP_OM;
+
+	if (elem->mac_cap_info[4] & IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU)
+		cap |= STA_REC_HE_CAP_AMSDU_IN_AMPDU;
+
+	if (elem->mac_cap_info[4] & IEEE80211_HE_MAC_CAP4_BQR)
+		cap |= STA_REC_HE_CAP_BQR;
+
+	if (elem->phy_cap_info[0] &
+	    (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G |
+	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G))
+		cap |= STA_REC_HE_CAP_BW20_RU242_SUPPORT;
+
+	if (elem->phy_cap_info[1] &
+	    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD)
+		cap |= STA_REC_HE_CAP_LDPC;
+
+	if (elem->phy_cap_info[1] &
+	    IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US)
+		cap |= STA_REC_HE_CAP_SU_PPDU_1LTF_8US_GI;
+
+	if (elem->phy_cap_info[2] &
+	    IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US)
+		cap |= STA_REC_HE_CAP_NDP_4LTF_3DOT2MS_GI;
+
+	if (elem->phy_cap_info[2] &
+	    IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ)
+		cap |= STA_REC_HE_CAP_LE_EQ_80M_TX_STBC;
+
+	if (elem->phy_cap_info[2] &
+	    IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ)
+		cap |= STA_REC_HE_CAP_LE_EQ_80M_RX_STBC;
+
+	if (elem->phy_cap_info[6] &
+	    IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE)
+		cap |= STA_REC_HE_CAP_PARTIAL_BW_EXT_RANGE;
+
+	if (elem->phy_cap_info[7] &
+	    IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI)
+		cap |= STA_REC_HE_CAP_SU_MU_PPDU_4LTF_8US_GI;
+
+	if (elem->phy_cap_info[7] &
+	    IEEE80211_HE_PHY_CAP7_STBC_TX_ABOVE_80MHZ)
+		cap |= STA_REC_HE_CAP_GT_80M_TX_STBC;
+
+	if (elem->phy_cap_info[7] &
+	    IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ)
+		cap |= STA_REC_HE_CAP_GT_80M_RX_STBC;
+
+	if (elem->phy_cap_info[8] &
+	    IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI)
+		cap |= STA_REC_HE_CAP_ER_SU_PPDU_4LTF_8US_GI;
+
+	if (elem->phy_cap_info[8] &
+	    IEEE80211_HE_PHY_CAP8_HE_ER_SU_1XLTF_AND_08_US_GI)
+		cap |= STA_REC_HE_CAP_ER_SU_PPDU_1LTF_8US_GI;
+
+	if (elem->phy_cap_info[9] &
+	    IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK)
+		cap |= STA_REC_HE_CAP_TRIG_CQI_FK;
+
+	if (elem->phy_cap_info[9] &
+	    IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU)
+		cap |= STA_REC_HE_CAP_TX_1024QAM_UNDER_RU242;
+
+	if (elem->phy_cap_info[9] &
+	    IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU)
+		cap |= STA_REC_HE_CAP_RX_1024QAM_UNDER_RU242;
+
+	he->he_cap = cpu_to_le32(cap);
+
+	switch (sta->bandwidth) {
+	case IEEE80211_STA_RX_BW_160:
+		if (elem->phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
+			he->max_nss_mcs[CMD_HE_MCS_BW8080] =
+				he_cap->he_mcs_nss_supp.rx_mcs_80p80;
+
+		he->max_nss_mcs[CMD_HE_MCS_BW160] =
+				he_cap->he_mcs_nss_supp.rx_mcs_160;
+		fallthrough;
+	default:
+		he->max_nss_mcs[CMD_HE_MCS_BW80] =
+				he_cap->he_mcs_nss_supp.rx_mcs_80;
+		break;
+	}
+
+	he->t_frame_dur =
+		HE_MAC(CAP1_TF_MAC_PAD_DUR_MASK, elem->mac_cap_info[1]);
+	he->max_ampdu_exp =
+		HE_MAC(CAP3_MAX_AMPDU_LEN_EXP_MASK, elem->mac_cap_info[3]);
+
+	he->bw_set =
+		HE_PHY(CAP0_CHANNEL_WIDTH_SET_MASK, elem->phy_cap_info[0]);
+	he->device_class =
+		HE_PHY(CAP1_DEVICE_CLASS_A, elem->phy_cap_info[1]);
+	he->punc_pream_rx =
+		HE_PHY(CAP1_PREAMBLE_PUNC_RX_MASK, elem->phy_cap_info[1]);
+
+	he->dcm_tx_mode =
+		HE_PHY(CAP3_DCM_MAX_CONST_TX_MASK, elem->phy_cap_info[3]);
+	he->dcm_tx_max_nss =
+		HE_PHY(CAP3_DCM_MAX_TX_NSS_2, elem->phy_cap_info[3]);
+	he->dcm_rx_mode =
+		HE_PHY(CAP3_DCM_MAX_CONST_RX_MASK, elem->phy_cap_info[3]);
+	he->dcm_rx_max_nss =
+		HE_PHY(CAP3_DCM_MAX_RX_NSS_2, elem->phy_cap_info[3]);
+	he->dcm_rx_max_nss =
+		HE_PHY(CAP8_DCM_MAX_RU_MASK, elem->phy_cap_info[8]);
+
+	he->pkt_ext = 2;
+}
+
+static void
+mt7921_mcu_sta_uapsd_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
+			 struct ieee80211_vif *vif)
+{
+	struct sta_rec_uapsd *uapsd;
+	struct tlv *tlv;
+
+	if (vif->type != NL80211_IFTYPE_AP || !sta->wme)
+		return;
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_APPS, sizeof(*uapsd));
+	uapsd = (struct sta_rec_uapsd *)tlv;
+
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VO) {
+		uapsd->dac_map |= BIT(3);
+		uapsd->tac_map |= BIT(3);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VI) {
+		uapsd->dac_map |= BIT(2);
+		uapsd->tac_map |= BIT(2);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BE) {
+		uapsd->dac_map |= BIT(1);
+		uapsd->tac_map |= BIT(1);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BK) {
+		uapsd->dac_map |= BIT(0);
+		uapsd->tac_map |= BIT(0);
+	}
+	uapsd->max_sp = sta->max_sp;
+}
+
+static void
+mt7921_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct sta_rec_amsdu *amsdu;
+	struct tlv *tlv;
+
+	if (!sta->max_amsdu_len)
+		return;
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_HW_AMSDU, sizeof(*amsdu));
+	amsdu = (struct sta_rec_amsdu *)tlv;
+	amsdu->max_amsdu_num = 8;
+	amsdu->amsdu_en = true;
+	amsdu->max_mpdu_size = sta->max_amsdu_len >=
+			       IEEE80211_MAX_MPDU_LEN_VHT_7991;
+	msta->wcid.amsdu = true;
+}
+
+static bool
+mt7921_hw_amsdu_supported(struct ieee80211_vif *vif)
+{
+	switch (vif->type) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_STATION:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void
+mt7921_mcu_sta_tlv(struct mt7921_dev *dev, struct sk_buff *skb,
+		   struct ieee80211_sta *sta, struct ieee80211_vif *vif)
+{
+	struct tlv *tlv;
+	struct sta_rec_state *state;
+	struct sta_rec_phy *phy;
+	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
+	enum nl80211_band band = chandef->chan->band;
+	u32 supp_rate = sta->supp_rates[band];
+	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
+	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
+
+	/* starec ht */
+	if (sta->ht_cap.ht_supported) {
+		struct sta_rec_ht *ht;
+
+		tlv = mt7921_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
+		ht = (struct sta_rec_ht *)tlv;
+		ht->ht_cap = cpu_to_le16(sta->ht_cap.cap);
+
+		if (mt7921_hw_amsdu_supported(vif))
+			mt7921_mcu_sta_amsdu_tlv(skb, sta);
+	}
+
+	/* starec vht */
+	if (sta->vht_cap.vht_supported) {
+		struct sta_rec_vht *vht;
+
+		tlv = mt7921_mcu_add_tlv(skb, STA_REC_VHT, sizeof(*vht));
+		vht = (struct sta_rec_vht *)tlv;
+		vht->vht_cap = cpu_to_le32(sta->vht_cap.cap);
+		vht->vht_rx_mcs_map = sta->vht_cap.vht_mcs.rx_mcs_map;
+		vht->vht_tx_mcs_map = sta->vht_cap.vht_mcs.tx_mcs_map;
+	}
+
+	/* starec he */
+	if (sta->he_cap.has_he)
+		mt7921_mcu_sta_he_tlv(skb, sta);
+
+	/* starec uapsd */
+	mt7921_mcu_sta_uapsd_tlv(skb, sta, vif);
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_PHY, sizeof(*phy));
+	phy = (struct sta_rec_phy *)tlv;
+	phy->legacy = supp_rate;
+	phy->phy_type = mt7921_get_phy_mode_v2(dev, vif, band, sta);
+	phy->basic_rate = vif->bss_conf.basic_rates;
+
+	if (sta->ht_cap.ht_supported) {
+		memcpy(phy->rx_mcs_bitmask, sta->ht_cap.mcs.rx_mask,
+		       HT_MCS_MASK_NUM);
+	}
+
+	if (sta->he_cap.has_he) {
+		memcpy(phy->he_mac_cap, elem->mac_cap_info, HE_MAC_CAP_BYTE_NUM);
+		memcpy(phy->he_phy_cap, elem->phy_cap_info, HE_PHY_CAP_BYTE_NUM);
+	}
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_STATE, sizeof(*state));
+	state = (struct sta_rec_state *)tlv;
+	state->state = 2;
+
+	if (sta->vht_cap.vht_supported) {
+		state->vht_opmode = sta->bandwidth;
+		state->vht_opmode |= (sta->rx_nss - 1) <<
+			IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
+	}
+}
+
+static void
+mt7921_mcu_wtbl_smps_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
+			 void *sta_wtbl, void *wtbl_tlv)
+{
+	struct wtbl_smps *smps;
+	struct tlv *tlv;
+
+	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_SMPS, sizeof(*smps),
+					wtbl_tlv, sta_wtbl);
+	smps = (struct wtbl_smps *)tlv;
+
+	if (sta->smps_mode == IEEE80211_SMPS_DYNAMIC)
+		smps->smps = true;
+}
+
+static void
+mt7921_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
+		       void *sta_wtbl, void *wtbl_tlv)
+{
+	struct wtbl_ht *ht = NULL;
+	struct tlv *tlv;
+
+	/* wtbl ht */
+	if (sta->ht_cap.ht_supported) {
+		tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_HT, sizeof(*ht),
+						wtbl_tlv, sta_wtbl);
+		ht = (struct wtbl_ht *)tlv;
+		ht->ldpc = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
+		ht->af = sta->ht_cap.ampdu_factor;
+		ht->mm = sta->ht_cap.ampdu_density;
+		ht->ht = true;
+	}
+
+	/* wtbl vht */
+	if (sta->vht_cap.vht_supported) {
+		struct wtbl_vht *vht;
+		u8 af;
+
+		tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_VHT, sizeof(*vht),
+						wtbl_tlv, sta_wtbl);
+		vht = (struct wtbl_vht *)tlv;
+		vht->ldpc = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
+		vht->vht = true;
+
+		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
+			       sta->vht_cap.cap);
+		if (ht)
+			ht->af = max_t(u8, ht->af, af);
+	}
+
+	mt7921_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_tlv);
+}
+
+static void
+mt7921_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      void *sta_wtbl, void *wtbl_tlv)
+{
+	struct mt7921_sta *msta;
+	struct wtbl_hdr_trans *htr = NULL;
+	struct tlv *tlv;
+
+	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_HDR_TRANS, sizeof(*htr),
+					wtbl_tlv, sta_wtbl);
+	htr = (struct wtbl_hdr_trans *)tlv;
+	htr->no_rx_trans = true;
+	if (vif->type == NL80211_IFTYPE_STATION)
+		htr->to_ds = true;
+	else
+		htr->from_ds = true;
+
+	if (!sta)
+		return;
+
+	msta = (struct mt7921_sta *)sta->drv_priv;
+	if (test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags)) {
+		htr->to_ds = true;
+		htr->from_ds = true;
+	}
+}
+
+int mt7921_mcu_sta_update_hdr_trans(struct mt7921_dev *dev,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct sk_buff *skb;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, MT7921_WTBL_UPDATE_MAX_SIZE);
+	if (!skb)
+		return -ENOMEM;
+
+	wtbl_hdr = mt7921_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, NULL, &skb);
+	mt7921_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, NULL, wtbl_hdr);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
+				     true);
+}
+
+static int mt7921_mcu_start_firmware(struct mt7921_dev *dev, u32 addr,
+				     u32 option)
+{
+	struct {
+		__le32 option;
+		__le32 addr;
+	} req = {
+		.option = cpu_to_le32(option),
+		.addr = cpu_to_le32(addr),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FW_START_REQ, &req,
+				 sizeof(req), true);
+}
+
+static int mt7921_mcu_restart(struct mt76_dev *dev)
+{
+	struct {
+		u8 power_mode;
+		u8 rsv[3];
+	} req = {
+		.power_mode = 1,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CMD_NIC_POWER_CTRL, &req,
+				 sizeof(req), false);
+}
+
+static int mt7921_mcu_patch_sem_ctrl(struct mt7921_dev *dev, bool get)
+{
+	struct {
+		__le32 op;
+	} req = {
+		.op = cpu_to_le32(get ? PATCH_SEM_GET : PATCH_SEM_RELEASE),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_PATCH_SEM_CONTROL, &req,
+				 sizeof(req), true);
+}
+
+static int mt7921_mcu_start_patch(struct mt7921_dev *dev)
+{
+	struct {
+		u8 check_crc;
+		u8 reserved[3];
+	} req = {
+		.check_crc = 0,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_PATCH_FINISH_REQ, &req,
+				 sizeof(req), true);
+}
+
+static int mt7921_driver_own(struct mt7921_dev *dev)
+{
+	u32 reg = mt7921_reg_map_l1(dev, MT_TOP_LPCR_HOST_BAND0);
+
+	mt76_wr(dev, reg, MT_TOP_LPCR_HOST_DRV_OWN);
+	if (!mt76_poll_msec(dev, reg, MT_TOP_LPCR_HOST_FW_OWN,
+			    0, 500)) {
+		dev_err(dev->mt76.dev, "Timeout for driver own\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int mt7921_mcu_init_download(struct mt7921_dev *dev, u32 addr,
+				    u32 len, u32 mode)
+{
+	struct {
+		__le32 addr;
+		__le32 len;
+		__le32 mode;
+	} req = {
+		.addr = cpu_to_le32(addr),
+		.len = cpu_to_le32(len),
+		.mode = cpu_to_le32(mode),
+	};
+	int attr;
+
+	if (req.addr == cpu_to_le32(MCU_PATCH_ADDRESS) || addr == 0x900000)
+		attr = MCU_CMD_PATCH_START_REQ;
+	else
+		attr = MCU_CMD_TARGET_ADDRESS_LEN_REQ;
+
+	return mt76_mcu_send_msg(&dev->mt76, attr, &req, sizeof(req), true);
+}
+
+static int mt7921_load_patch(struct mt7921_dev *dev)
+{
+	const struct mt7921_patch_hdr *hdr;
+	const struct firmware *fw = NULL;
+	int i, ret, sem;
+
+	sem = mt7921_mcu_patch_sem_ctrl(dev, 1);
+	switch (sem) {
+	case PATCH_IS_DL:
+		return 0;
+	case PATCH_NOT_DL_SEM_SUCCESS:
+		break;
+	default:
+		dev_err(dev->mt76.dev, "Failed to get patch semaphore\n");
+		return -EAGAIN;
+	}
+
+	ret = request_firmware(&fw, MT7921_ROM_PATCH, dev->mt76.dev);
+	if (ret)
+		goto out;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->mt76.dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const struct mt7921_patch_hdr *)(fw->data);
+
+	dev_info(dev->mt76.dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
+		 be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
+
+	for (i = 0; i < be32_to_cpu(hdr->desc.n_region); i++) {
+		struct mt7921_patch_sec *sec;
+		const u8 *dl;
+		u32 len, addr;
+
+		sec = (struct mt7921_patch_sec *)(fw->data + sizeof(*hdr) +
+						  i * sizeof(*sec));
+		if ((be32_to_cpu(sec->type) & PATCH_SEC_TYPE_MASK) !=
+		    PATCH_SEC_TYPE_INFO) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		addr = be32_to_cpu(sec->info.addr);
+		len = be32_to_cpu(sec->info.len);
+		dl = fw->data + be32_to_cpu(sec->offs);
+
+		ret = mt7921_mcu_init_download(dev, addr, len,
+					       DL_MODE_NEED_RSP);
+		if (ret) {
+			dev_err(dev->mt76.dev, "Download request failed\n");
+			goto out;
+		}
+
+		ret = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
+					     dl, len);
+		if (ret) {
+			dev_err(dev->mt76.dev, "Failed to send patch\n");
+			goto out;
+		}
+	}
+
+	ret = mt7921_mcu_start_patch(dev);
+	if (ret)
+		dev_err(dev->mt76.dev, "Failed to start patch\n");
+
+out:
+	sem = mt7921_mcu_patch_sem_ctrl(dev, 0);
+	switch (sem) {
+	case PATCH_REL_SEM_SUCCESS:
+		break;
+	default:
+		ret = -EAGAIN;
+		dev_err(dev->mt76.dev, "Failed to release patch semaphore\n");
+		goto out;
+	}
+	release_firmware(fw);
+
+	return ret;
+}
+
+static u32 mt7921_mcu_gen_dl_mode(u8 feature_set, bool is_wa)
+{
+	u32 ret = 0;
+
+	ret |= (feature_set & FW_FEATURE_SET_ENCRYPT) ?
+	       (DL_MODE_ENCRYPT | DL_MODE_RESET_SEC_IV) : 0;
+	ret |= (feature_set & FW_FEATURE_ENCRY_MODE) ?
+	       DL_CONFIG_ENCRY_MODE_SEL : 0;
+	ret |= FIELD_PREP(DL_MODE_KEY_IDX,
+			  FIELD_GET(FW_FEATURE_SET_KEY_IDX, feature_set));
+	ret |= DL_MODE_NEED_RSP;
+	ret |= is_wa ? DL_MODE_WORKING_PDA_CR4 : 0;
+
+	return ret;
+}
+
+static int
+mt7921_mcu_send_ram_firmware(struct mt7921_dev *dev,
+			     const struct mt7921_fw_trailer *hdr,
+			     const u8 *data, bool is_wa)
+{
+	int i, offset = 0;
+	u32 override = 0, option = 0;
+
+	for (i = 0; i < hdr->n_region; i++) {
+		const struct mt7921_fw_region *region;
+		int err;
+		u32 len, addr, mode;
+
+		region = (const struct mt7921_fw_region *)((const u8 *)hdr -
+			 (hdr->n_region - i) * sizeof(*region));
+		mode = mt7921_mcu_gen_dl_mode(region->feature_set, is_wa);
+		len = le32_to_cpu(region->len);
+		addr = le32_to_cpu(region->addr);
+
+		if (region->feature_set & FW_FEATURE_OVERRIDE_ADDR)
+			override = addr;
+
+		err = mt7921_mcu_init_download(dev, addr, len, mode);
+		if (err) {
+			dev_err(dev->mt76.dev, "Download request failed\n");
+			return err;
+		}
+
+		err = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
+					     data + offset, len);
+		if (err) {
+			dev_err(dev->mt76.dev, "Failed to send firmware.\n");
+			return err;
+		}
+
+		offset += len;
+	}
+
+	if (override)
+		option |= FW_START_OVERRIDE;
+
+	if (is_wa)
+		option |= FW_START_WORKING_PDA_CR4;
+
+	return mt7921_mcu_start_firmware(dev, override, option);
+}
+
+static int mt7921_load_ram(struct mt7921_dev *dev)
+{
+	const struct mt7921_fw_trailer *hdr;
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, MT7921_FIRMWARE_WM, dev->mt76.dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->mt76.dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const struct mt7921_fw_trailer *)(fw->data + fw->size -
+					sizeof(*hdr));
+
+	dev_info(dev->mt76.dev, "WM Firmware Version: %.10s, Build Time: %.15s\n",
+		 hdr->fw_ver, hdr->build_date);
+
+	ret = mt7921_mcu_send_ram_firmware(dev, hdr, fw->data, false);
+	if (ret) {
+		dev_err(dev->mt76.dev, "Failed to start WM firmware\n");
+		goto out;
+	}
+
+	snprintf(dev->mt76.hw->wiphy->fw_version,
+		 sizeof(dev->mt76.hw->wiphy->fw_version),
+		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int mt7921_load_firmware(struct mt7921_dev *dev)
+{
+	int ret;
+
+	ret = mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY);
+	if (ret) {
+		dev_dbg(dev->mt76.dev, "Firmware is already download\n");
+		return -EIO;
+	}
+
+	ret = mt7921_load_patch(dev);
+	if (ret)
+		return ret;
+
+	ret = mt7921_load_ram(dev);
+	if (ret)
+		return ret;
+
+	if (!mt76_poll_msec(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY,
+			    MT_TOP_MISC2_FW_N9_RDY, 1500)) {
+		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
+
+		return -EIO;
+	}
+
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_FWDL], false);
+
+	dev_err(dev->mt76.dev, "Firmware init done\n");
+
+	return 0;
+}
+
+int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl)
+{
+	struct {
+		u8 ctrl_val;
+		u8 pad[3];
+	} data = {
+		.ctrl_val = ctrl
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_FW_LOG_2_HOST, &data,
+				 sizeof(data), true);
+}
+
+int mt7921_mcu_fw_dbg_ctrl(struct mt7921_dev *dev, u32 module, u8 level)
+{
+	struct {
+		u8 ver;
+		u8 pad;
+		__le16 len;
+		u8 level;
+		u8 rsv[3];
+		__le32 module_idx;
+	} data = {
+		.module_idx = cpu_to_le32(module),
+		.level = level,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_FW_DBG_CTRL, &data,
+				 sizeof(data), false);
+}
+
+int mt7921_mcu_init(struct mt7921_dev *dev)
+{
+	static const struct mt76_mcu_ops mt7921_mcu_ops = {
+		.headroom = sizeof(struct mt7921_mcu_txd),
+		.mcu_skb_send_msg = mt7921_mcu_send_message,
+		.mcu_parse_response = mt7921_mcu_parse_response,
+		.mcu_restart = mt7921_mcu_restart,
+	};
+	int ret;
+
+	dev->mt76.mcu_ops = &mt7921_mcu_ops;
+
+	ret = mt7921_driver_own(dev);
+	if (ret)
+		return ret;
+
+	ret = mt7921_load_firmware(dev);
+	if (ret)
+		return ret;
+
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+	mt7921_mcu_fw_log_2_host(dev, 1);
+
+	return 0;
+}
+
+void mt7921_mcu_exit(struct mt7921_dev *dev)
+{
+	u32 reg = mt7921_reg_map_l1(dev, MT_TOP_MISC);
+
+	__mt76_mcu_restart(&dev->mt76);
+	if (!mt76_poll_msec(dev, reg, MT_TOP_MISC_FW_STATE,
+			    FIELD_PREP(MT_TOP_MISC_FW_STATE,
+				       FW_STATE_FW_DOWNLOAD), 1000)) {
+		dev_err(dev->mt76.dev, "Failed to exit mcu\n");
+		return;
+	}
+
+	reg = mt7921_reg_map_l1(dev, MT_TOP_LPCR_HOST_BAND0);
+	mt76_wr(dev, reg, MT_TOP_LPCR_HOST_FW_OWN);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+}
+
+int mt7921_mcu_set_mac(struct mt7921_dev *dev, int band,
+		       bool enable, bool hdr_trans)
+{
+	struct {
+		u8 operation;
+		u8 enable;
+		u8 check_bssid;
+		u8 insert_vlan;
+		u8 remove_vlan;
+		u8 tid;
+		u8 mode;
+		u8 rsv;
+	} __packed req_trans = {
+		.enable = hdr_trans,
+	};
+	struct {
+		u8 enable;
+		u8 band;
+		u8 rsv[2];
+	} __packed req_mac = {
+		.enable = enable,
+		.band = band,
+	};
+	int ret;
+
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RX_HDR_TRANS,
+				&req_trans, sizeof(req_trans), false);
+	if (ret)
+		return ret;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MAC_INIT_CTRL,
+				 &req_mac, sizeof(req_mac), true);
+}
+
+int mt7921_mcu_set_rts_thresh(struct mt7921_phy *phy, u32 val)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct {
+		u8 prot_idx;
+		u8 band;
+		u8 rsv[2];
+		__le32 len_thresh;
+		__le32 pkt_thresh;
+	} __packed req = {
+		.prot_idx = 1,
+		.band = phy != &dev->phy,
+		.len_thresh = cpu_to_le32(val),
+		.pkt_thresh = cpu_to_le32(0x2),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PROTECT_CTRL, &req,
+				 sizeof(req), true);
+}
+
+int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
+{
+#define WMM_AIFS_SET		BIT(0)
+#define WMM_CW_MIN_SET		BIT(1)
+#define WMM_CW_MAX_SET		BIT(2)
+#define WMM_TXOP_SET		BIT(3)
+#define WMM_PARAM_SET		GENMASK(3, 0)
+#define TX_CMD_MODE		1
+	struct edca {
+		u8 queue;
+		u8 set;
+		u8 aifs;
+		u8 cw_min;
+		__le16 cw_max;
+		__le16 txop;
+	};
+	struct mt7921_mcu_tx {
+		u8 total;
+		u8 action;
+		u8 valid;
+		u8 mode;
+
+		struct edca edca[IEEE80211_NUM_ACS];
+	} __packed req = {
+		.valid = true,
+		.mode = TX_CMD_MODE,
+		.total = IEEE80211_NUM_ACS,
+	};
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	int ac;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		struct ieee80211_tx_queue_params *q = &mvif->queue_params[ac];
+		struct edca *e = &req.edca[ac];
+
+		e->set = WMM_PARAM_SET;
+		e->queue = ac + mvif->wmm_idx * MT7921_MAX_WMM_SETS;
+		e->aifs = q->aifs;
+		e->txop = cpu_to_le16(q->txop);
+
+		if (q->cw_min)
+			e->cw_min = fls(q->cw_min);
+		else
+			e->cw_min = 5;
+
+		if (q->cw_max)
+			e->cw_max = cpu_to_le16(fls(q->cw_max));
+		else
+			e->cw_max = cpu_to_le16(10);
+	}
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE, &req,
+				 sizeof(req), true);
+}
+
+int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	int freq1 = chandef->center_freq1;
+	struct {
+		u8 control_ch;
+		u8 center_ch;
+		u8 bw;
+		u8 tx_streams_num;
+		u8 rx_streams;	/* mask or num */
+		u8 switch_reason;
+		u8 band_idx;
+		u8 center_ch2;	/* for 80+80 only */
+		__le16 cac_case;
+		u8 channel_band;
+		u8 rsv0;
+		__le32 outband_freq;
+		u8 txpower_drop;
+		u8 ap_bw;
+		u8 ap_center_ch;
+		u8 rsv1[57];
+	} __packed req = {
+		.control_ch = chandef->chan->hw_value,
+		.center_ch = ieee80211_frequency_to_channel(freq1),
+		.bw = mt7921_mcu_chan_bw(chandef),
+		.tx_streams_num = hweight8(phy->mt76->antenna_mask),
+		.rx_streams = phy->mt76->antenna_mask,
+		.band_idx = phy != &dev->phy,
+		.channel_band = chandef->chan->band,
+	};
+
+	if (dev->mt76.hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
+	else if ((chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
+		 chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
+		req.switch_reason = CH_SWITCH_DFS;
+	else
+		req.switch_reason = CH_SWITCH_NORMAL;
+
+	if (cmd == MCU_EXT_CMD_CHANNEL_SWITCH)
+		req.rx_streams = hweight8(req.rx_streams);
+
+	if (chandef->width == NL80211_CHAN_WIDTH_80P80) {
+		int freq2 = chandef->center_freq2;
+
+		req.center_ch2 = ieee80211_frequency_to_channel(freq2);
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
+}
+
+int mt7921_mcu_set_eeprom(struct mt7921_dev *dev)
+{
+	struct req_hdr {
+		u8 buffer_mode;
+		u8 format;
+		__le16 len;
+	} __packed req = {
+		.buffer_mode = EE_MODE_EFUSE,
+		.format = EE_FORMAT_WHOLE,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
+				 &req, sizeof(req), true);
+}
+
+int mt7921_mcu_get_eeprom(struct mt7921_dev *dev, u32 offset)
+{
+	struct mt7921_mcu_eeprom_info req = {
+		.addr = cpu_to_le32(round_down(offset, 16)),
+	};
+	struct mt7921_mcu_eeprom_info *res;
+	struct sk_buff *skb;
+	int ret;
+	u8 *buf;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_ACCESS, &req,
+					sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	res = (struct mt7921_mcu_eeprom_info *)skb->data;
+	buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
+	memcpy(buf, res->data, 16);
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
+int mt7921_mcu_set_sku(struct mt7921_phy *phy)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct mt76_phy *mphy = phy->mt76;
+	struct ieee80211_hw *hw = mphy->hw;
+	struct mt7921_sku_val {
+		u8 format_id;
+		u8 limit_type;
+		u8 dbdc_idx;
+		s8 val[MT7921_SKU_RATE_NUM];
+	} __packed req = {
+		.format_id = 4,
+		.dbdc_idx = phy != &dev->phy,
+	};
+	int i;
+	s8 *delta;
+
+	delta = dev->rate_power[mphy->chandef.chan->band];
+	mphy->txpower_cur = hw->conf.power_level * 2 +
+			    delta[MT7921_SKU_MAX_DELTA_IDX];
+
+	for (i = 0; i < MT7921_SKU_RATE_NUM; i++)
+		req.val[i] = hw->conf.power_level * 2 + delta[i];
+
+	return mt76_mcu_send_msg(&dev->mt76,
+				 MCU_EXT_CMD_TX_POWER_FEATURE_CTRL, &req,
+				 sizeof(req), true);
+}
+
+int mt7921_mcu_set_sku_en(struct mt7921_phy *phy, bool enable)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct mt7921_sku {
+		u8 format_id;
+		u8 sku_enable;
+		u8 dbdc_idx;
+		u8 rsv;
+	} __packed req = {
+		.format_id = 0,
+		.dbdc_idx = phy != &dev->phy,
+		.sku_enable = enable,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76,
+				 MCU_EXT_CMD_TX_POWER_FEATURE_CTRL, &req,
+				 sizeof(req), true);
+}
+
+int mt7921_mcu_get_rx_rate(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta, struct rate_info *rate)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt7921_dev *dev = phy->dev;
+	struct mt76_phy *mphy = phy->mt76;
+	struct {
+		u8 category;
+		u8 band;
+		__le16 wcid;
+	} __packed req = {
+		.category = MCU_PHY_STATE_CONTENTION_RX_RATE,
+		.band = mvif->band_idx,
+		.wcid = cpu_to_le16(msta->wcid.idx),
+	};
+	struct ieee80211_supported_band *sband;
+	struct mt7921_mcu_phy_rx_info *res;
+	struct sk_buff *skb;
+	u16 flags = 0;
+	int ret;
+	int i;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD_PHY_STAT_INFO,
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	res = (struct mt7921_mcu_phy_rx_info *)skb->data;
+
+	rate->mcs = res->rate;
+	rate->nss = res->nsts + 1;
+
+	switch (res->mode) {
+	case MT_PHY_TYPE_CCK:
+	case MT_PHY_TYPE_OFDM:
+		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &mphy->sband_5g.sband;
+		else
+			sband = &mphy->sband_2g.sband;
+
+		for (i = 0; i < sband->n_bitrates; i++) {
+			if (rate->mcs != (sband->bitrates[i].hw_value & 0xf))
+				continue;
+
+			rate->legacy = sband->bitrates[i].bitrate;
+			break;
+		}
+		break;
+	case MT_PHY_TYPE_HT:
+	case MT_PHY_TYPE_HT_GF:
+		rate->mcs += (rate->nss - 1) * 8;
+		flags |= RATE_INFO_FLAGS_MCS;
+
+		if (res->gi)
+			flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_VHT:
+		flags |= RATE_INFO_FLAGS_VHT_MCS;
+
+		if (res->gi)
+			flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+	case MT_PHY_TYPE_HE_MU:
+		rate->he_gi = res->gi;
+
+		flags |= RATE_INFO_FLAGS_HE_MCS;
+		break;
+	default:
+		break;
+	}
+	rate->flags = flags;
+
+	switch (res->bw) {
+	case IEEE80211_STA_RX_BW_160:
+		rate->bw = RATE_INFO_BW_160;
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		rate->bw = RATE_INFO_BW_80;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		rate->bw = RATE_INFO_BW_40;
+		break;
+	default:
+		rate->bw = RATE_INFO_BW_20;
+		break;
+	}
+
+	return 0;
+}
+
+int
+mt7921_mcu_uni_add_dev(struct mt7921_dev *dev,
+		       struct ieee80211_vif *vif, bool enable)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 omac_idx;
+			u8 band_idx;
+			__le16 pad;
+		} __packed hdr;
+		struct req_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 active;
+			u8 pad;
+			u8 omac_addr[ETH_ALEN];
+		} __packed tlv;
+	} dev_req = {
+		.hdr = {
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+		},
+		.tlv = {
+			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
+			.len = cpu_to_le16(sizeof(struct req_tlv)),
+			.active = enable,
+		},
+	};
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt7921_bss_basic_tlv basic;
+	} basic_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.basic = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
+			.len = cpu_to_le16(sizeof(struct mt7921_bss_basic_tlv)),
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+			.wmm_idx = mvif->wmm_idx,
+			.active = enable,
+			.bmc_tx_wlan_idx = cpu_to_le16(mvif->sta.wcid.idx),
+			.sta_idx = cpu_to_le16(mvif->sta.wcid.idx),
+			.conn_state = 1,
+		},
+	};
+	int err, idx, cmd, len;
+	void *data;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
+		break;
+	case NL80211_IFTYPE_STATION:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	basic_req.basic.hw_bss_idx = idx;
+
+	memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
+
+	cmd = enable ? MCU_UNI_CMD_DEV_INFO_UPDATE : MCU_UNI_CMD_BSS_INFO_UPDATE;
+	data = enable ? (void *)&dev_req : (void *)&basic_req;
+	len = enable ? sizeof(dev_req) : sizeof(basic_req);
+
+	err = mt76_mcu_send_msg(&dev->mt76, cmd, data, len, true);
+	if (err < 0)
+		return err;
+
+	cmd = enable ? MCU_UNI_CMD_BSS_INFO_UPDATE : MCU_UNI_CMD_DEV_INFO_UPDATE;
+	data = enable ? (void *)&basic_req : (void *)&dev_req;
+	len = enable ? sizeof(basic_req) : sizeof(dev_req);
+
+	return mt76_mcu_send_msg(&dev->mt76, cmd, data, len, true);
+}
+
+int
+mt7921_mcu_uni_add_bss(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+		       bool enable)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
+	struct mt7921_dev *dev = phy->dev;
+	enum nl80211_band band = chandef->chan->band;
+
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt7921_bss_basic_tlv basic;
+		struct mt7921_bss_qos_tlv qos;
+	} basic_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.basic = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
+			.len = cpu_to_le16(sizeof(struct mt7921_bss_basic_tlv)),
+			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
+			.dtim_period = vif->bss_conf.dtim_period,
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+			.wmm_idx = mvif->wmm_idx,
+			.active = true, /* keep bss deactivated */
+			.phymode = mt7921_get_phy_mode(phy->dev, vif, band, NULL),
+		},
+		.qos = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_QBSS),
+			.len = cpu_to_le16(sizeof(struct mt7921_bss_qos_tlv)),
+			.qos = vif->bss_conf.qos,
+		},
+	};
+
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct bss_info_uni_he he;
+	} he_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.he = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_HE_BASIC),
+			.len = cpu_to_le16(sizeof(struct bss_info_uni_he)),
+		},
+	};
+
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct rlm_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 control_channel;
+			u8 center_chan;
+			u8 center_chan2;
+			u8 bw;
+			u8 tx_streams;
+			u8 rx_streams;
+			u8 short_st;
+			u8 ht_op_info;
+			u8 sco;
+			u8 pad[3];
+		} __packed rlm;
+	} __packed rlm_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.rlm = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_RLM),
+			.len = cpu_to_le16(sizeof(struct rlm_tlv)),
+			.control_channel = chandef->chan->hw_value,
+			.center_chan = ieee80211_frequency_to_channel(freq1),
+			.center_chan2 = ieee80211_frequency_to_channel(freq2),
+			.tx_streams = hweight8(phy->mt76->antenna_mask),
+			.rx_streams = phy->chainmask,
+			.short_st = true,
+		},
+	};
+	int err, conn_type;
+	u8 idx;
+
+	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	basic_req.basic.hw_bss_idx = idx;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GO;
+		else
+			conn_type = CONNECTION_INFRA_AP;
+		basic_req.basic.conn_type = cpu_to_le32(conn_type);
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GC;
+		else
+			conn_type = CONNECTION_INFRA_STA;
+		basic_req.basic.conn_type = cpu_to_le32(conn_type);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	memcpy(basic_req.basic.bssid, vif->bss_conf.bssid, ETH_ALEN);
+	basic_req.basic.bmc_tx_wlan_idx = cpu_to_le16(mvif->sta.wcid.idx);
+	basic_req.basic.sta_idx = cpu_to_le16(mvif->sta.wcid.idx);
+	basic_req.basic.conn_state = !enable;
+
+	err = mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+				&basic_req, sizeof(basic_req), true);
+	if (err < 0)
+		return err;
+
+	if (vif->bss_conf.he_support) {
+		mt7921_mcu_uni_bss_he_tlv((struct tlv *)&he_req.he, vif, phy);
+
+		err = mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+					&he_req, sizeof(he_req), true);
+		if (err < 0)
+			return err;
+	}
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_40:
+		rlm_req.rlm.bw = CMD_CBW_40MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		rlm_req.rlm.bw = CMD_CBW_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+		rlm_req.rlm.bw = CMD_CBW_8080MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		rlm_req.rlm.bw = CMD_CBW_160MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_5:
+		rlm_req.rlm.bw = CMD_CBW_5MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_10:
+		rlm_req.rlm.bw = CMD_CBW_10MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+	default:
+		rlm_req.rlm.bw = CMD_CBW_20MHZ;
+		break;
+	}
+
+	if (rlm_req.rlm.control_channel < rlm_req.rlm.center_chan)
+		rlm_req.rlm.sco = 1; /* SCA */
+	else if (rlm_req.rlm.control_channel > rlm_req.rlm.center_chan)
+		rlm_req.rlm.sco = 3; /* SCB */
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+				 &rlm_req, sizeof(rlm_req), true);
+}
+
+static int
+mt7921_mcu_add_sta_cmd(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable, int cmd)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct mt7921_sta *msta;
+	struct tlv *sta_wtbl;
+	struct sk_buff *skb;
+
+	msta = sta ? (struct mt7921_sta *)sta->drv_priv : &mvif->sta;
+
+	skb = mt7921_mcu_alloc_sta_req(dev, mvif, msta,
+				       MT7921_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7921_mcu_sta_basic_tlv(skb, vif, sta, enable);
+	if (enable && sta)
+		mt7921_mcu_sta_tlv(dev, skb, sta, vif);
+
+	sta_wtbl = mt7921_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
+
+	wtbl_hdr = mt7921_mcu_alloc_wtbl_req(dev, msta, WTBL_RESET_AND_SET,
+					     sta_wtbl, &skb);
+	if (enable) {
+		mt7921_mcu_wtbl_generic_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
+		if (sta)
+			mt7921_mcu_wtbl_ht_tlv(skb, sta, sta_wtbl, wtbl_hdr);
+	}
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
+}
+
+int
+mt7921_mcu_uni_add_sta(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable)
+{
+	return mt7921_mcu_add_sta_cmd(dev, vif, sta, enable,
+				      MCU_UNI_CMD_STA_REC_UPDATE);
+}
+
+#define MT7921_SCAN_CHANNEL_TIME	60
+int mt7921_mcu_hw_scan(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+		       struct ieee80211_scan_request *scan_req)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct cfg80211_scan_request *sreq = &scan_req->req;
+	int n_ssids = 0, err, i, duration = MT7921_SCAN_CHANNEL_TIME;
+	int ext_channels_num = max_t(int, sreq->n_channels - 32, 0);
+	struct ieee80211_channel **scan_list = sreq->channels;
+	struct mt7921_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+	struct mt7921_mcu_scan_channel *chan;
+	struct mt7921_hw_scan_req *req;
+	struct sk_buff *skb;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(*req));
+	if (!skb)
+		return -ENOMEM;
+
+	set_bit(MT76_HW_SCANNING, &phy->mt76->state);
+	mvif->scan_seq_num = (mvif->scan_seq_num + 1) & 0x7f;
+
+	req = (struct mt7921_hw_scan_req *)skb_put(skb, sizeof(*req));
+
+	req->seq_num = mvif->scan_seq_num | ext_phy << 7;
+	req->bss_idx = mvif->idx;
+	req->scan_type = sreq->n_ssids ? 1 : 0;
+	req->probe_req_num = sreq->n_ssids ? 2 : 0;
+	req->version = 1;
+
+	for (i = 0; i < sreq->n_ssids; i++) {
+		if (!sreq->ssids[i].ssid_len)
+			continue;
+
+		req->ssids[i].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
+		memcpy(req->ssids[i].ssid, sreq->ssids[i].ssid,
+		       sreq->ssids[i].ssid_len);
+		n_ssids++;
+	}
+	req->ssid_type = n_ssids ? BIT(2) : BIT(0);
+	req->ssid_type_ext = n_ssids ? BIT(0) : 0;
+	req->ssids_num = n_ssids;
+
+	/* increase channel time for passive scan */
+	if (!sreq->n_ssids)
+		duration *= 2;
+	req->timeout_value = cpu_to_le16(sreq->n_channels * duration);
+	req->channel_min_dwell_time = cpu_to_le16(duration);
+	req->channel_dwell_time = cpu_to_le16(duration);
+
+	req->channels_num = min_t(u8, sreq->n_channels, 32);
+	req->ext_channels_num = min_t(u8, ext_channels_num, 32);
+	for (i = 0; i < req->channels_num + req->ext_channels_num; i++) {
+		if (i >= 32)
+			chan = &req->ext_channels[i - 32];
+		else
+			chan = &req->channels[i];
+
+		chan->band = scan_list[i]->band == NL80211_BAND_2GHZ ? 1 : 2;
+		chan->channel_num = scan_list[i]->hw_value;
+	}
+	req->channel_type = sreq->n_channels ? 4 : 0;
+
+	if (sreq->ie_len > 0) {
+		memcpy(req->ies, sreq->ie, sreq->ie_len);
+		req->ies_len = cpu_to_le16(sreq->ie_len);
+	}
+
+	memcpy(req->bssid, sreq->bssid, ETH_ALEN);
+	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
+		get_random_mask_addr(req->random_mac, sreq->mac_addr,
+				     sreq->mac_addr_mask);
+		req->scan_func = 1;
+	}
+
+	err = mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_CMD_START_HW_SCAN,
+				    false);
+	if (err < 0)
+		clear_bit(MT76_HW_SCANNING, &phy->mt76->state);
+
+	return err;
+}
+
+int mt7921_mcu_cancel_hw_scan(struct mt7921_phy *phy,
+			      struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = phy->dev;
+	struct {
+		u8 seq_num;
+		u8 is_ext_channel;
+		u8 rsv[2];
+	} __packed req = {
+		.seq_num = mvif->scan_seq_num,
+	};
+
+	if (test_and_clear_bit(MT76_HW_SCANNING, &phy->mt76->state)) {
+		struct cfg80211_scan_info info = {
+			.aborted = true,
+		};
+
+		ieee80211_scan_completed(phy->mt76->hw, &info);
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76,  MCU_CMD_CANCEL_HW_SCAN, &req,
+				 sizeof(req), false);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
new file mode 100644
index 000000000000..a363c96b9d7f
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -0,0 +1,991 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7921_MCU_H
+#define __MT7921_MCU_H
+
+struct mt7921_mcu_txd {
+	__le32 txd[8];
+
+	__le16 len;
+	__le16 pq_id;
+
+	u8 cid;
+	u8 pkt_type;
+	u8 set_query; /* FW don't care */
+	u8 seq;
+
+	u8 uc_d2b0_rev;
+	u8 ext_cid;
+	u8 s2d_index;
+	u8 ext_cid_ack;
+
+	u32 reserved[5];
+} __packed __aligned(4);
+
+/**
+ * struct mt7921_uni_txd - mcu command descriptor for firmware v3
+ * @txd: hardware descriptor
+ * @len: total length not including txd
+ * @cid: command identifier
+ * @pkt_type: must be 0xa0 (cmd packet by long format)
+ * @frag_n: fragment number
+ * @seq: sequence number
+ * @checksum: 0 mean there is no checksum
+ * @s2d_index: index for command source and destination
+ *  Definition              | value | note
+ *  CMD_S2D_IDX_H2N         | 0x00  | command from HOST to WM
+ *  CMD_S2D_IDX_C2N         | 0x01  | command from WA to WM
+ *  CMD_S2D_IDX_H2C         | 0x02  | command from HOST to WA
+ *  CMD_S2D_IDX_H2N_AND_H2C | 0x03  | command from HOST to WA and WM
+ *
+ * @option: command option
+ *  BIT[0]: UNI_CMD_OPT_BIT_ACK
+ *          set to 1 to request a fw reply
+ *          if UNI_CMD_OPT_BIT_0_ACK is set and UNI_CMD_OPT_BIT_2_SET_QUERY
+ *          is set, mcu firmware will send response event EID = 0x01
+ *          (UNI_EVENT_ID_CMD_RESULT) to the host.
+ *  BIT[1]: UNI_CMD_OPT_BIT_UNI_CMD
+ *          0: original command
+ *          1: unified command
+ *  BIT[2]: UNI_CMD_OPT_BIT_SET_QUERY
+ *          0: QUERY command
+ *          1: SET command
+ */
+struct mt7921_uni_txd {
+	__le32 txd[8];
+
+	/* DW1 */
+	__le16 len;
+	__le16 cid;
+
+	/* DW2 */
+	u8 reserved;
+	u8 pkt_type;
+	u8 frag_n;
+	u8 seq;
+
+	/* DW3 */
+	__le16 checksum;
+	u8 s2d_index;
+	u8 option;
+
+	/* DW4 */
+	u8 reserved2[4];
+} __packed __aligned(4);
+
+/* event table */
+enum {
+	MCU_EVENT_TARGET_ADDRESS_LEN = 0x01,
+	MCU_EVENT_FW_START = 0x01,
+	MCU_EVENT_GENERIC = 0x01,
+	MCU_EVENT_ACCESS_REG = 0x02,
+	MCU_EVENT_MT_PATCH_SEM = 0x04,
+	MCU_EVENT_REG_ACCESS = 0x05,
+	MCU_EVENT_SCAN_DONE = 0x0d,
+	MCU_EVENT_ROC = 0x10,
+	MCU_EVENT_BSS_ABSENCE  = 0x11,
+	MCU_EVENT_BSS_BEACON_LOSS = 0x13,
+	MCU_EVENT_CH_PRIVILEGE = 0x18,
+	MCU_EVENT_SCHED_SCAN_DONE = 0x23,
+	MCU_EVENT_DBG_MSG = 0x27,
+	MCU_EVENT_EXT = 0xed,
+	MCU_EVENT_RESTART_DL = 0xef,
+};
+
+/* ext event table */
+enum {
+	MCU_EXT_EVENT_RATE_REPORT = 0x87,
+};
+
+struct mt7921_mcu_rxd {
+	__le32 rxd[6];
+
+	__le16 len;
+	__le16 pkt_type_id;
+
+	u8 eid;
+	u8 seq;
+	__le16 __rsv;
+
+	u8 ext_eid;
+	u8 __rsv1[2];
+	u8 s2d_index;
+};
+
+struct mt7921_mcu_eeprom_info {
+	__le32 addr;
+	__le32 valid;
+	u8 data[16];
+} __packed;
+
+struct mt7921_mcu_ra_info {
+	struct mt7921_mcu_rxd rxd;
+
+	__le32 event_id;
+	__le16 wlan_idx;
+	__le16 ru_idx;
+	__le16 direction;
+	__le16 dump_group;
+
+	__le32 suggest_rate;
+	__le32 min_rate;	/* for dynamic sounding */
+	__le32 max_rate;	/* for dynamic sounding */
+	__le32 init_rate_down_rate;
+
+	__le16 curr_rate;
+	__le16 init_rate_down_total;
+	__le16 init_rate_down_succ;
+	__le16 success;
+	__le16 attempts;
+
+	__le16 prev_rate;
+	__le16 prob_up_rate;
+	u8 no_rate_up_cnt;
+	u8 ppdu_cnt;
+	u8 gi;
+
+	u8 try_up_fail;
+	u8 try_up_total;
+	u8 suggest_wf;
+	u8 try_up_check;
+	u8 prob_up_period;
+	u8 prob_down_pending;
+} __packed;
+
+struct mt7921_mcu_phy_rx_info {
+	u8 category;
+	u8 rate;
+	u8 mode;
+	u8 nsts;
+	u8 gi;
+	u8 coding;
+	u8 stbc;
+	u8 bw;
+};
+
+#define MT_RA_RATE_NSS			GENMASK(8, 6)
+#define MT_RA_RATE_MCS			GENMASK(3, 0)
+#define MT_RA_RATE_TX_MODE		GENMASK(12, 9)
+#define MT_RA_RATE_DCM_EN		BIT(4)
+#define MT_RA_RATE_BW			GENMASK(14, 13)
+
+#define MCU_PQ_ID(p, q)			(((p) << 15) | ((q) << 10))
+#define MCU_PKT_ID			0xa0
+
+enum {
+	MCU_Q_QUERY,
+	MCU_Q_SET,
+	MCU_Q_RESERVED,
+	MCU_Q_NA
+};
+
+enum {
+	MCU_S2D_H2N,
+	MCU_S2D_C2N,
+	MCU_S2D_H2C,
+	MCU_S2D_H2CN
+};
+
+#define MCU_FW_PREFIX		BIT(31)
+#define MCU_UNI_PREFIX		BIT(30)
+#define MCU_CE_PREFIX		BIT(29)
+#define MCU_QUERY_PREFIX	BIT(28)
+#define MCU_CMD_MASK		~(MCU_FW_PREFIX | MCU_UNI_PREFIX |	\
+				  MCU_CE_PREFIX | MCU_QUERY_PREFIX)
+
+#define MCU_QUERY_MASK		BIT(16)
+
+enum {
+	MCU_CMD_TARGET_ADDRESS_LEN_REQ = MCU_FW_PREFIX | 0x01,
+	MCU_CMD_FW_START_REQ = MCU_FW_PREFIX | 0x02,
+	MCU_CMD_INIT_ACCESS_REG = 0x3,
+	MCU_CMD_NIC_POWER_CTRL = MCU_FW_PREFIX | 0x4,
+	MCU_CMD_PATCH_START_REQ = MCU_FW_PREFIX | 0x05,
+	MCU_CMD_PATCH_FINISH_REQ = MCU_FW_PREFIX | 0x07,
+	MCU_CMD_PATCH_SEM_CONTROL = MCU_FW_PREFIX | 0x10,
+	MCU_CMD_BT_SEM_CONTROL = MCU_FW_PREFIX | 0x11,
+	MCU_CMD_EXT_CID = 0xED,
+	MCU_CMD_FW_SCATTER = MCU_FW_PREFIX | 0xEE,
+	MCU_CMD_RESTART_DL_REQ = MCU_FW_PREFIX | 0xEF,
+};
+
+enum {
+	MCU_EXT_CMD_EFUSE_ACCESS = 0x01,
+	MCU_EXT_CMD_CHANNEL_SWITCH = 0x08,
+	MCU_EXT_CMD_FW_LOG_2_HOST = 0x13,
+	MCU_EXT_CMD_EFUSE_BUFFER_MODE = 0x21,
+	MCU_EXT_CMD_EDCA_UPDATE = 0x27,
+	MCU_EXT_CMD_THERMAL_CTRL = 0x2c,
+	MCU_EXT_CMD_WTBL_UPDATE = 0x32,
+	MCU_EXT_CMD_PROTECT_CTRL = 0x3e,
+	MCU_EXT_CMD_MAC_INIT_CTRL = 0x46,
+	MCU_EXT_CMD_RX_HDR_TRANS = 0x47,
+	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
+	MCU_EXT_CMD_TX_POWER_FEATURE_CTRL = 0x58,
+	MCU_EXT_CMD_MWDS_SUPPORT = 0x80,
+	MCU_EXT_CMD_RATE_CTRL = 0x87,
+	MCU_EXT_CMD_FW_DBG_CTRL = 0x95,
+	MCU_EXT_CMD_PHY_STAT_INFO = 0xad,
+};
+
+enum {
+	MCU_UNI_CMD_DEV_INFO_UPDATE = MCU_UNI_PREFIX | 0x01,
+	MCU_UNI_CMD_BSS_INFO_UPDATE = MCU_UNI_PREFIX | 0x02,
+	MCU_UNI_CMD_STA_REC_UPDATE = MCU_UNI_PREFIX | 0x03,
+	MCU_UNI_CMD_SUSPEND = MCU_UNI_PREFIX | 0x05,
+	MCU_UNI_CMD_OFFLOAD = MCU_UNI_PREFIX | 0x06,
+	MCU_UNI_CMD_HIF_CTRL = MCU_UNI_PREFIX | 0x07,
+};
+
+struct mt7921_mcu_uni_event {
+	u8 cid;
+	u8 pad[3];
+	__le32 status; /* 0: success, others: fail */
+} __packed;
+
+/* offload mcu commands */
+enum {
+	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
+	MCU_CMD_SET_PS_PROFILE = MCU_CE_PREFIX | 0x05,
+	MCU_CMD_SET_CHAN_DOMAIN = MCU_CE_PREFIX | 0x0f,
+	MCU_CMD_SET_BSS_CONNECTED = MCU_CE_PREFIX | 0x16,
+	MCU_CMD_SET_BSS_ABORT = MCU_CE_PREFIX | 0x17,
+	MCU_CMD_CANCEL_HW_SCAN = MCU_CE_PREFIX | 0x1b,
+	MCU_CMD_SCHED_SCAN_ENABLE = MCU_CE_PREFIX | 0x61,
+	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
+	MCU_CMD_REG_WRITE = MCU_CE_PREFIX | 0xc0,
+	MCU_CMD_REG_READ = MCU_CE_PREFIX | MCU_QUERY_MASK | 0xc0,
+};
+
+#define MCU_CMD_ACK		BIT(0)
+#define MCU_CMD_UNI		BIT(1)
+#define MCU_CMD_QUERY		BIT(2)
+
+#define MCU_CMD_UNI_EXT_ACK	(MCU_CMD_ACK | MCU_CMD_UNI | MCU_CMD_QUERY)
+
+enum {
+	UNI_BSS_INFO_BASIC = 0,
+	UNI_BSS_INFO_RLM = 2,
+	UNI_BSS_INFO_HE_BASIC = 5,
+	UNI_BSS_INFO_BCN_CONTENT = 7,
+	UNI_BSS_INFO_QBSS = 15,
+	UNI_BSS_INFO_UAPSD = 19,
+};
+
+enum {
+	UNI_SUSPEND_MODE_SETTING,
+	UNI_SUSPEND_WOW_CTRL,
+	UNI_SUSPEND_WOW_GPIO_PARAM,
+	UNI_SUSPEND_WOW_WAKEUP_PORT,
+	UNI_SUSPEND_WOW_PATTERN,
+};
+
+enum {
+	UNI_OFFLOAD_OFFLOAD_ARP,
+	UNI_OFFLOAD_OFFLOAD_ND,
+	UNI_OFFLOAD_OFFLOAD_GTK_REKEY,
+	UNI_OFFLOAD_OFFLOAD_BMC_RPY_DETECT,
+};
+
+enum {
+	PATCH_SEM_RELEASE,
+	PATCH_SEM_GET
+};
+
+enum {
+	PATCH_NOT_DL_SEM_FAIL,
+	PATCH_IS_DL,
+	PATCH_NOT_DL_SEM_SUCCESS,
+	PATCH_REL_SEM_SUCCESS
+};
+
+enum {
+	FW_STATE_INITIAL,
+	FW_STATE_FW_DOWNLOAD,
+	FW_STATE_NORMAL_OPERATION,
+	FW_STATE_NORMAL_TRX,
+	FW_STATE_WACPU_RDY        = 7
+};
+
+enum {
+	EE_MODE_EFUSE,
+	EE_MODE_BUFFER,
+};
+
+enum {
+	EE_FORMAT_BIN,
+	EE_FORMAT_WHOLE,
+	EE_FORMAT_MULTIPLE,
+};
+
+enum {
+	MCU_PHY_STATE_TX_RATE,
+	MCU_PHY_STATE_RX_RATE,
+	MCU_PHY_STATE_RSSI,
+	MCU_PHY_STATE_CONTENTION_RX_RATE,
+	MCU_PHY_STATE_OFDMLQ_CNINFO,
+};
+
+#define STA_TYPE_STA			BIT(0)
+#define STA_TYPE_AP			BIT(1)
+#define STA_TYPE_ADHOC			BIT(2)
+#define STA_TYPE_WDS			BIT(4)
+#define STA_TYPE_BC			BIT(5)
+
+#define NETWORK_INFRA			BIT(16)
+#define NETWORK_P2P			BIT(17)
+#define NETWORK_IBSS			BIT(18)
+#define NETWORK_WDS			BIT(21)
+
+#define CONNECTION_INFRA_STA		(STA_TYPE_STA | NETWORK_INFRA)
+#define CONNECTION_INFRA_AP		(STA_TYPE_AP | NETWORK_INFRA)
+#define CONNECTION_P2P_GC		(STA_TYPE_STA | NETWORK_P2P)
+#define CONNECTION_P2P_GO		(STA_TYPE_AP | NETWORK_P2P)
+#define CONNECTION_IBSS_ADHOC		(STA_TYPE_ADHOC | NETWORK_IBSS)
+#define CONNECTION_WDS			(STA_TYPE_WDS | NETWORK_WDS)
+#define CONNECTION_INFRA_BC		(STA_TYPE_BC | NETWORK_INFRA)
+
+#define CONN_STATE_DISCONNECT		0
+#define CONN_STATE_CONNECT		1
+#define CONN_STATE_PORT_SECURE		2
+
+enum {
+	DEV_INFO_ACTIVE,
+	DEV_INFO_MAX_NUM
+};
+
+enum {
+	CMD_CBW_20MHZ = IEEE80211_STA_RX_BW_20,
+	CMD_CBW_40MHZ = IEEE80211_STA_RX_BW_40,
+	CMD_CBW_80MHZ = IEEE80211_STA_RX_BW_80,
+	CMD_CBW_160MHZ = IEEE80211_STA_RX_BW_160,
+	CMD_CBW_10MHZ,
+	CMD_CBW_5MHZ,
+	CMD_CBW_8080MHZ,
+
+	CMD_HE_MCS_BW80 = 0,
+	CMD_HE_MCS_BW160,
+	CMD_HE_MCS_BW8080,
+	CMD_HE_MCS_BW_NUM
+};
+
+struct tlv {
+	__le16 tag;
+	__le16 len;
+} __packed;
+
+struct bss_info_uni_he {
+	__le16 tag;
+	__le16 len;
+	__le16 he_rts_thres;
+	u8 he_pe_duration;
+	u8 su_disable;
+	__le16 max_nss_mcs[CMD_HE_MCS_BW_NUM];
+	u8 rsv[2];
+} __packed;
+
+enum {
+	WTBL_RESET_AND_SET = 1,
+	WTBL_SET,
+	WTBL_QUERY,
+	WTBL_RESET_ALL
+};
+
+struct wtbl_req_hdr {
+	u8 wlan_idx_lo;
+	u8 operation;
+	__le16 tlv_num;
+	u8 wlan_idx_hi;
+	u8 rsv[3];
+} __packed;
+
+struct wtbl_generic {
+	__le16 tag;
+	__le16 len;
+	u8 peer_addr[ETH_ALEN];
+	u8 muar_idx;
+	u8 skip_tx;
+	u8 cf_ack;
+	u8 qos;
+	u8 mesh;
+	u8 adm;
+	__le16 partial_aid;
+	u8 baf_en;
+	u8 aad_om;
+} __packed;
+
+struct wtbl_rx {
+	__le16 tag;
+	__le16 len;
+	u8 rcid;
+	u8 rca1;
+	u8 rca2;
+	u8 rv;
+	u8 rsv[4];
+} __packed;
+
+struct wtbl_ht {
+	__le16 tag;
+	__le16 len;
+	u8 ht;
+	u8 ldpc;
+	u8 af;
+	u8 mm;
+	u8 rsv[4];
+} __packed;
+
+struct wtbl_vht {
+	__le16 tag;
+	__le16 len;
+	u8 ldpc;
+	u8 dyn_bw;
+	u8 vht;
+	u8 txop_ps;
+	u8 rsv[4];
+} __packed;
+
+struct wtbl_hdr_trans {
+	__le16 tag;
+	__le16 len;
+	u8 to_ds;
+	u8 from_ds;
+	u8 no_rx_trans;
+	u8 _rsv;
+};
+
+enum {
+	MT_BA_TYPE_INVALID,
+	MT_BA_TYPE_ORIGINATOR,
+	MT_BA_TYPE_RECIPIENT
+};
+
+enum {
+	RST_BA_MAC_TID_MATCH,
+	RST_BA_MAC_MATCH,
+	RST_BA_NO_MATCH
+};
+
+struct wtbl_ba {
+	__le16 tag;
+	__le16 len;
+	/* common */
+	u8 tid;
+	u8 ba_type;
+	u8 rsv0[2];
+	/* originator only */
+	__le16 sn;
+	u8 ba_en;
+	u8 ba_winsize_idx;
+	__le16 ba_winsize;
+	/* recipient only */
+	u8 peer_addr[ETH_ALEN];
+	u8 rst_ba_tid;
+	u8 rst_ba_sel;
+	u8 rst_ba_sb;
+	u8 band_idx;
+	u8 rsv1[4];
+} __packed;
+
+struct wtbl_smps {
+	__le16 tag;
+	__le16 len;
+	u8 smps;
+	u8 rsv[3];
+} __packed;
+
+enum {
+	WTBL_GENERIC,
+	WTBL_RX,
+	WTBL_HT,
+	WTBL_VHT,
+	WTBL_PEER_PS,		/* not used */
+	WTBL_TX_PS,
+	WTBL_HDR_TRANS,
+	WTBL_SEC_KEY,
+	WTBL_BA,
+	WTBL_RDG,		/* obsoleted */
+	WTBL_PROTECT,		/* not used */
+	WTBL_CLEAR,		/* not used */
+	WTBL_BF,
+	WTBL_SMPS,
+	WTBL_RAW_DATA,		/* debug only */
+	WTBL_PN,
+	WTBL_SPE,
+	WTBL_MAX_NUM
+};
+
+struct sta_ntlv_hdr {
+	u8 rsv[2];
+	__le16 tlv_num;
+} __packed;
+
+struct sta_req_hdr {
+	u8 bss_idx;
+	u8 wlan_idx_lo;
+	__le16 tlv_num;
+	u8 is_tlv_append;
+	u8 muar_idx;
+	u8 wlan_idx_hi;
+	u8 rsv;
+} __packed;
+
+struct sta_rec_basic {
+	__le16 tag;
+	__le16 len;
+	__le32 conn_type;
+	u8 conn_state;
+	u8 qos;
+	__le16 aid;
+	u8 peer_addr[ETH_ALEN];
+	__le16 extra_info;
+} __packed;
+
+struct sta_rec_ht {
+	__le16 tag;
+	__le16 len;
+	__le16 ht_cap;
+	u16 rsv;
+} __packed;
+
+struct sta_rec_vht {
+	__le16 tag;
+	__le16 len;
+	__le32 vht_cap;
+	__le16 vht_rx_mcs_map;
+	__le16 vht_tx_mcs_map;
+	u8 rts_bw_sig;
+	u8 rsv[3];
+} __packed;
+
+struct sta_rec_uapsd {
+	__le16 tag;
+	__le16 len;
+	u8 dac_map;
+	u8 tac_map;
+	u8 max_sp;
+	u8 rsv0;
+	__le16 listen_interval;
+	u8 rsv1[2];
+} __packed;
+
+struct sta_rec_he {
+	__le16 tag;
+	__le16 len;
+
+	__le32 he_cap;
+
+	u8 t_frame_dur;
+	u8 max_ampdu_exp;
+	u8 bw_set;
+	u8 device_class;
+	u8 dcm_tx_mode;
+	u8 dcm_tx_max_nss;
+	u8 dcm_rx_mode;
+	u8 dcm_rx_max_nss;
+	u8 dcm_max_ru;
+	u8 punc_pream_rx;
+	u8 pkt_ext;
+	u8 rsv1;
+
+	__le16 max_nss_mcs[CMD_HE_MCS_BW_NUM];
+
+	u8 rsv2[2];
+} __packed;
+
+struct sta_rec_ba {
+	__le16 tag;
+	__le16 len;
+	u8 tid;
+	u8 ba_type;
+	u8 amsdu;
+	u8 ba_en;
+	__le16 ssn;
+	__le16 winsize;
+} __packed;
+
+struct sta_rec_amsdu {
+	__le16 tag;
+	__le16 len;
+	u8 max_amsdu_num;
+	u8 max_mpdu_size;
+	u8 amsdu_en;
+	u8 rsv;
+} __packed;
+
+struct sec_key {
+	u8 cipher_id;
+	u8 cipher_len;
+	u8 key_id;
+	u8 key_len;
+	u8 key[32];
+} __packed;
+
+struct sta_rec_sec {
+	__le16 tag;
+	__le16 len;
+	u8 add;
+	u8 n_cipher;
+	u8 rsv[2];
+
+	struct sec_key key[2];
+} __packed;
+
+struct sta_rec_state {
+	__le16 tag;
+	__le16 len;
+	__le32 flags;
+	u8 state;
+	u8 vht_opmode;
+	u8 action;
+	u8 rsv[1];
+} __packed;
+
+#define HE_MAC_CAP_BYTE_NUM 6
+#define HE_PHY_CAP_BYTE_NUM 11
+#define HT_MCS_MASK_NUM 10
+
+struct ht_vht_ba_size {
+	u8 tx_ba;
+	u8 rx_ba;
+	u8 rsv[2];
+} __packed;
+
+struct he_ba_size {
+	__le16 tx_ba;
+	__le16 rx_ba;
+} __packed;
+
+union BA_SIZE {
+	struct ht_vht_ba_size ht_vht;
+	struct he_ba_size he;
+};
+
+struct sta_rec_phy {
+	__le16 tag;
+	__le16 len;
+	__le16 legacy;
+	__le16 he_6g_cap;
+	__le32 tx_max_amsdu_len;
+	__le16 basic_rate;
+	u8 phy_type;
+	u8 ampdu;
+	u8 tx_ampdu;
+	u8 rx_ampdu;
+	u8 tx_amsdu_in_ampdu;
+	u8 rx_amsdu_in_ampdu;
+	u8 rts_policy;
+	u8 rcpi;
+	u8 uapsd_ac;
+	u8 uapsd_sp;
+	u8 he_mac_cap[HE_MAC_CAP_BYTE_NUM];
+	u8 he_phy_cap[HE_PHY_CAP_BYTE_NUM];
+	u8 rx_mcs_bitmask[HT_MCS_MASK_NUM];
+	u8 rsv[1];
+	union BA_SIZE ba_size;
+} __packed;
+
+enum {
+	STA_REC_BASIC,
+	STA_REC_RA,
+	STA_REC_RA_CMM_INFO,
+	STA_REC_RA_UPDATE,
+	STA_REC_BF,
+	STA_REC_AMSDU,
+	STA_REC_BA,
+	STA_REC_STATE,
+	STA_REC_TX_PROC,	/* for hdr trans and CSO in CR4 */
+	STA_REC_HT,
+	STA_REC_VHT,
+	STA_REC_APPS,
+	STA_REC_KEY,
+	STA_REC_WTBL,
+	STA_REC_HE,
+	STA_REC_HW_AMSDU,
+	STA_REC_WTBL_AADOM,
+	STA_REC_KEY_V2,
+	STA_REC_MURU,
+	STA_REC_MUEDCA,
+	STA_REC_BFEE,
+	STA_REC_PHY = 0x15,
+	STA_REC_MAX_NUM
+};
+
+enum mt7921_cipher_type {
+	MT_CIPHER_NONE,
+	MT_CIPHER_WEP40,
+	MT_CIPHER_WEP104,
+	MT_CIPHER_WEP128,
+	MT_CIPHER_TKIP,
+	MT_CIPHER_AES_CCMP,
+	MT_CIPHER_CCMP_256,
+	MT_CIPHER_GCMP,
+	MT_CIPHER_GCMP_256,
+	MT_CIPHER_WAPI,
+	MT_CIPHER_BIP_CMAC_128,
+};
+
+enum {
+	CH_SWITCH_NORMAL = 0,
+	CH_SWITCH_SCAN = 3,
+	CH_SWITCH_MCC = 4,
+	CH_SWITCH_DFS = 5,
+	CH_SWITCH_BACKGROUND_SCAN_START = 6,
+	CH_SWITCH_BACKGROUND_SCAN_RUNNING = 7,
+	CH_SWITCH_BACKGROUND_SCAN_STOP = 8,
+	CH_SWITCH_SCAN_BYPASS_DPD = 9
+};
+
+enum {
+	THERMAL_SENSOR_TEMP_QUERY,
+	THERMAL_SENSOR_MANUAL_CTRL,
+	THERMAL_SENSOR_INFO_QUERY,
+	THERMAL_SENSOR_TASK_CTRL,
+};
+
+enum {
+	MT_EBF = BIT(0),	/* explicit beamforming */
+	MT_IBF = BIT(1)		/* implicit beamforming */
+};
+
+#define MT7921_WTBL_UPDATE_MAX_SIZE	(sizeof(struct wtbl_req_hdr) +	\
+					 sizeof(struct wtbl_generic) +	\
+					 sizeof(struct wtbl_rx) +	\
+					 sizeof(struct wtbl_ht) +	\
+					 sizeof(struct wtbl_vht) +	\
+					 sizeof(struct wtbl_hdr_trans) +\
+					 sizeof(struct wtbl_ba) +	\
+					 sizeof(struct wtbl_smps))
+
+#define MT7921_STA_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +	\
+					 sizeof(struct sta_rec_basic) +	\
+					 sizeof(struct sta_rec_ht) +	\
+					 sizeof(struct sta_rec_he) +	\
+					 sizeof(struct sta_rec_ba) +	\
+					 sizeof(struct sta_rec_vht) +	\
+					 sizeof(struct sta_rec_uapsd) + \
+					 sizeof(struct sta_rec_amsdu) +	\
+					 sizeof(struct tlv) +		\
+					 MT7921_WTBL_UPDATE_MAX_SIZE)
+
+#define MT7921_WTBL_UPDATE_BA_SIZE	(sizeof(struct wtbl_req_hdr) +	\
+					 sizeof(struct wtbl_ba))
+
+#define PHY_MODE_A			BIT(0)
+#define PHY_MODE_B			BIT(1)
+#define PHY_MODE_G			BIT(2)
+#define PHY_MODE_GN			BIT(3)
+#define PHY_MODE_AN			BIT(4)
+#define PHY_MODE_AC			BIT(5)
+#define PHY_MODE_AX_24G			BIT(6)
+#define PHY_MODE_AX_5G			BIT(7)
+#define PHY_MODE_AX_6G			BIT(8)
+
+#define MODE_CCK			BIT(0)
+#define MODE_OFDM			BIT(1)
+#define MODE_HT				BIT(2)
+#define MODE_VHT			BIT(3)
+#define MODE_HE				BIT(4)
+
+#define STA_CAP_WMM			BIT(0)
+#define STA_CAP_SGI_20			BIT(4)
+#define STA_CAP_SGI_40			BIT(5)
+#define STA_CAP_TX_STBC			BIT(6)
+#define STA_CAP_RX_STBC			BIT(7)
+#define STA_CAP_VHT_SGI_80		BIT(16)
+#define STA_CAP_VHT_SGI_160		BIT(17)
+#define STA_CAP_VHT_TX_STBC		BIT(18)
+#define STA_CAP_VHT_RX_STBC		BIT(19)
+#define STA_CAP_VHT_LDPC		BIT(23)
+#define STA_CAP_LDPC			BIT(24)
+#define STA_CAP_HT			BIT(26)
+#define STA_CAP_VHT			BIT(27)
+#define STA_CAP_HE			BIT(28)
+
+/* HE MAC */
+#define STA_REC_HE_CAP_HTC			BIT(0)
+#define STA_REC_HE_CAP_BQR			BIT(1)
+#define STA_REC_HE_CAP_BSR			BIT(2)
+#define STA_REC_HE_CAP_OM			BIT(3)
+#define STA_REC_HE_CAP_AMSDU_IN_AMPDU		BIT(4)
+/* HE PHY */
+#define STA_REC_HE_CAP_DUAL_BAND		BIT(5)
+#define STA_REC_HE_CAP_LDPC			BIT(6)
+#define STA_REC_HE_CAP_TRIG_CQI_FK		BIT(7)
+#define STA_REC_HE_CAP_PARTIAL_BW_EXT_RANGE	BIT(8)
+/* STBC */
+#define STA_REC_HE_CAP_LE_EQ_80M_TX_STBC	BIT(9)
+#define STA_REC_HE_CAP_LE_EQ_80M_RX_STBC	BIT(10)
+#define STA_REC_HE_CAP_GT_80M_TX_STBC		BIT(11)
+#define STA_REC_HE_CAP_GT_80M_RX_STBC		BIT(12)
+/* GI */
+#define STA_REC_HE_CAP_SU_PPDU_1LTF_8US_GI	BIT(13)
+#define STA_REC_HE_CAP_SU_MU_PPDU_4LTF_8US_GI	BIT(14)
+#define STA_REC_HE_CAP_ER_SU_PPDU_1LTF_8US_GI	BIT(15)
+#define STA_REC_HE_CAP_ER_SU_PPDU_4LTF_8US_GI	BIT(16)
+#define STA_REC_HE_CAP_NDP_4LTF_3DOT2MS_GI	BIT(17)
+/* 242 TONE */
+#define STA_REC_HE_CAP_BW20_RU242_SUPPORT	BIT(18)
+#define STA_REC_HE_CAP_TX_1024QAM_UNDER_RU242	BIT(19)
+#define STA_REC_HE_CAP_RX_1024QAM_UNDER_RU242	BIT(20)
+
+struct mt7921_mcu_reg_event {
+	__le32 reg;
+	__le32 val;
+} __packed;
+
+struct mt7921_bss_basic_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 active;
+	u8 omac_idx;
+	u8 hw_bss_idx;
+	u8 band_idx;
+	__le32 conn_type;
+	u8 conn_state;
+	u8 wmm_idx;
+	u8 bssid[ETH_ALEN];
+	__le16 bmc_tx_wlan_idx;
+	__le16 bcn_interval;
+	u8 dtim_period;
+	u8 phymode; /* bit(0): A
+		     * bit(1): B
+		     * bit(2): G
+		     * bit(3): GN
+		     * bit(4): AN
+		     * bit(5): AC
+		     */
+	__le16 sta_idx;
+	u8 nonht_basic_phy;
+	u8 pad[3];
+} __packed;
+
+struct mt7921_bss_qos_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 qos;
+	u8 pad[3];
+} __packed;
+
+struct mt7921_mcu_scan_ssid {
+	__le32 ssid_len;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+} __packed;
+
+struct mt7921_mcu_scan_channel {
+	u8 band; /* 1: 2.4GHz
+		  * 2: 5.0GHz
+		  * Others: Reserved
+		  */
+	u8 channel_num;
+} __packed;
+
+struct mt7921_mcu_scan_match {
+	__le32 rssi_th;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	u8 ssid_len;
+	u8 rsv[3];
+} __packed;
+
+struct mt7921_hw_scan_req {
+	u8 seq_num;
+	u8 bss_idx;
+	u8 scan_type; /* 0: PASSIVE SCAN
+		       * 1: ACTIVE SCAN
+		       */
+	u8 ssid_type; /* BIT(0) wildcard SSID
+		       * BIT(1) P2P wildcard SSID
+		       * BIT(2) specified SSID + wildcard SSID
+		       * BIT(2) + ssid_type_ext BIT(0) specified SSID only
+		       */
+	u8 ssids_num;
+	u8 probe_req_num; /* Number of probe request for each SSID */
+	u8 scan_func; /* BIT(0) Enable random MAC scan
+		       * BIT(1) Disable DBDC scan type 1~3.
+		       * BIT(2) Use DBDC scan type 3 (dedicated one RF to scan).
+		       */
+	u8 version; /* 0: Not support fields after ies.
+		     * 1: Support fields after ies.
+		     */
+	struct mt7921_mcu_scan_ssid ssids[4];
+	__le16 probe_delay_time;
+	__le16 channel_dwell_time; /* channel Dwell interval */
+	__le16 timeout_value;
+	u8 channel_type; /* 0: Full channels
+			  * 1: Only 2.4GHz channels
+			  * 2: Only 5GHz channels
+			  * 3: P2P social channel only (channel #1, #6 and #11)
+			  * 4: Specified channels
+			  * Others: Reserved
+			  */
+	u8 channels_num; /* valid when channel_type is 4 */
+	/* valid when channels_num is set */
+	struct mt7921_mcu_scan_channel channels[32];
+	__le16 ies_len;
+	u8 ies[MT7921_SCAN_IE_LEN];
+	/* following fields are valid if version > 0 */
+	u8 ext_channels_num;
+	u8 ext_ssids_num;
+	__le16 channel_min_dwell_time;
+	struct mt7921_mcu_scan_channel ext_channels[32];
+	struct mt7921_mcu_scan_ssid ext_ssids[6];
+	u8 bssid[ETH_ALEN];
+	u8 random_mac[ETH_ALEN]; /* valid when BIT(1) in scan_func is set. */
+	u8 pad[63];
+	u8 ssid_type_ext;
+} __packed;
+
+#define SCAN_DONE_EVENT_MAX_CHANNEL_NUM	64
+struct mt7921_hw_scan_done {
+	u8 seq_num;
+	u8 sparse_channel_num;
+	struct mt7921_mcu_scan_channel sparse_channel;
+	u8 complete_channel_num;
+	u8 current_state;
+	u8 version;
+	u8 pad;
+	__le32 beacon_scan_num;
+	u8 pno_enabled;
+	u8 pad2[3];
+	u8 sparse_channel_valid_num;
+	u8 pad3[3];
+	u8 channel_num[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	/* idle format for channel_idle_time
+	 * 0: first bytes: idle time(ms) 2nd byte: dwell time(ms)
+	 * 1: first bytes: idle time(8ms) 2nd byte: dwell time(8ms)
+	 * 2: dwell time (16us)
+	 */
+	__le16 channel_idle_time[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	/* beacon and probe response count */
+	u8 beacon_probe_num[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	u8 mdrdy_count[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	__le32 beacon_2g_num;
+	__le32 beacon_5g_num;
+} __packed;
+
+struct mt7921_mcu_bss_event {
+	u8 bss_idx;
+	u8 is_absent;
+	u8 free_quota;
+	u8 pad;
+} __packed;
+
+enum {
+	PHY_TYPE_HR_DSSS_INDEX = 0,
+	PHY_TYPE_ERP_INDEX,
+	PHY_TYPE_ERP_P2P_INDEX,
+	PHY_TYPE_OFDM_INDEX,
+	PHY_TYPE_HT_INDEX,
+	PHY_TYPE_VHT_INDEX,
+	PHY_TYPE_HE_INDEX,
+	PHY_TYPE_INDEX_NUM
+};
+
+#define PHY_TYPE_BIT_HR_DSSS    BIT(PHY_TYPE_HR_DSSS_INDEX)
+#define PHY_TYPE_BIT_ERP        BIT(PHY_TYPE_ERP_INDEX)
+#define PHY_TYPE_BIT_OFDM       BIT(PHY_TYPE_OFDM_INDEX)
+#define PHY_TYPE_BIT_HT         BIT(PHY_TYPE_HT_INDEX)
+#define PHY_TYPE_BIT_VHT        BIT(PHY_TYPE_VHT_INDEX)
+#define PHY_TYPE_BIT_HE         BIT(PHY_TYPE_HE_INDEX)
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
new file mode 100644
index 000000000000..406c141991f8
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -0,0 +1,379 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7921_H
+#define __MT7921_H
+
+#include <linux/interrupt.h>
+#include <linux/ktime.h>
+#include "../mt76.h"
+#include "regs.h"
+
+#define MT7921_MAX_INTERFACES		4
+#define MT7921_MAX_WMM_SETS		4
+#define MT7921_WTBL_SIZE		20
+#define MT7921_WTBL_RESERVED		(MT7921_WTBL_SIZE - 1)
+#define MT7921_WTBL_STA			(MT7921_WTBL_RESERVED - \
+					 MT7921_MAX_INTERFACES)
+
+#define MT7921_HW_SCAN_TIMEOUT		(HZ / 10)
+#define MT7921_WATCHDOG_TIME		(HZ / 10)
+#define MT7921_RESET_TIMEOUT		(30 * HZ)
+
+#define MT7921_TX_RING_SIZE		2048
+#define MT7921_TX_MCU_RING_SIZE		256
+#define MT7921_TX_FWDL_RING_SIZE	128
+
+#define MT7921_RX_RING_SIZE		1536
+#define MT7921_RX_MCU_RING_SIZE		512
+
+#define MT7921_FIRMWARE_WM		"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
+#define MT7921_ROM_PATCH		"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
+
+#define MT7921_EEPROM_SIZE		3584
+#define MT7921_TOKEN_SIZE		8192
+#define MT7921_TOKEN_FREE_THR		64
+
+#define MT7921_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
+#define MT7921_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
+#define MT7921_5G_RATE_DEFAULT		0x4b	/* OFDM 6M */
+#define MT7921_2G_RATE_DEFAULT		0x0	/* CCK 1M */
+
+#define MT7921_SKU_RATE_NUM		161
+#define MT7921_SKU_MAX_DELTA_IDX	MT7921_SKU_RATE_NUM
+#define MT7921_SKU_TABLE_SIZE		(MT7921_SKU_RATE_NUM + 1)
+
+#define MT7921_SCAN_IE_LEN		600
+
+struct mt7921_vif;
+struct mt7921_sta;
+
+enum mt7921_txq_id {
+	MT7921_TXQ_BAND0,
+	MT7921_TXQ_BAND1,
+	MT7921_TXQ_FWDL = 16,
+	MT7921_TXQ_MCU_WM,
+};
+
+enum mt7921_rxq_id {
+	MT7921_RXQ_BAND0 = 0,
+	MT7921_RXQ_BAND1,
+	MT7921_RXQ_MCU_WM = 0,
+};
+
+struct mt7921_sta_stats {
+	struct rate_info prob_rate;
+	struct rate_info tx_rate;
+
+	unsigned long per;
+	unsigned long changed;
+	unsigned long jiffies;
+};
+
+struct mt7921_sta {
+	struct mt76_wcid wcid; /* must be first */
+
+	struct mt7921_vif *vif;
+
+	struct list_head poll_list;
+	u32 airtime_ac[8];
+
+	struct mt7921_sta_stats stats;
+
+	unsigned long ampdu_state;
+};
+
+struct mt7921_vif {
+	u16 idx;
+	u8 omac_idx;
+	u8 band_idx;
+	u8 wmm_idx;
+	u8 scan_seq_num;
+
+	struct mt7921_sta sta;
+	struct mt7921_phy *phy;
+
+	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+};
+
+struct mib_stats {
+	u16 ack_fail_cnt;
+	u16 fcs_err_cnt;
+	u16 rts_cnt;
+	u16 rts_retries_cnt;
+	u16 ba_miss_cnt;
+};
+
+struct mt7921_phy {
+	struct mt76_phy *mt76;
+	struct mt7921_dev *dev;
+
+	struct ieee80211_sband_iftype_data iftype[2][NUM_NL80211_IFTYPES];
+
+	struct ieee80211_vif *monitor_vif;
+
+	u32 rxfilter;
+	u64 omac_mask;
+
+	u16 noise;
+	u16 chainmask;
+
+	s16 coverage_class;
+	u8 slottime;
+
+	__le32 rx_ampdu_ts;
+	u32 ampdu_ref;
+
+	struct mib_stats mib;
+
+	struct delayed_work mac_work;
+	u8 mac_work_count;
+	u8 sta_work_count;
+
+	struct sk_buff_head scan_event_list;
+	struct delayed_work scan_work;
+};
+
+struct mt7921_dev {
+	union { /* must be first */
+		struct mt76_dev mt76;
+		struct mt76_phy mphy;
+	};
+
+	const struct mt76_bus_ops *bus_ops;
+	struct mt7921_phy phy;
+	struct tasklet_struct irq_tasklet;
+
+	u16 chainmask;
+
+	struct work_struct init_work;
+	struct work_struct reset_work;
+	wait_queue_head_t reset_wait;
+	u32 reset_state;
+
+	struct list_head sta_poll_list;
+	spinlock_t sta_poll_lock;
+
+	u32 hw_pattern;
+
+	spinlock_t token_lock;
+	int token_count;
+	struct idr token;
+
+	s8 **rate_power; /* TODO: use mt76_rate_power */
+
+	u8 fw_debug;
+};
+
+enum {
+	HW_BSSID_0 = 0x0,
+	HW_BSSID_1,
+	HW_BSSID_2,
+	HW_BSSID_3,
+	HW_BSSID_MAX = HW_BSSID_3,
+	EXT_BSSID_START = 0x10,
+	EXT_BSSID_1,
+	EXT_BSSID_15 = 0x1f,
+	EXT_BSSID_MAX = EXT_BSSID_15,
+	REPEATER_BSSID_START = 0x20,
+	REPEATER_BSSID_MAX = 0x3f,
+};
+
+enum {
+	MT_LMAC_AC00,
+	MT_LMAC_AC01,
+	MT_LMAC_AC02,
+	MT_LMAC_AC03,
+	MT_LMAC_ALTX0 = 0x10,
+	MT_LMAC_BMC0,
+	MT_LMAC_BCN0,
+};
+
+enum {
+	MT_RX_SEL0,
+	MT_RX_SEL1,
+};
+
+enum {
+	RATE_CTRL_RU_INFO,
+	RATE_CTRL_FIXED_RATE_INFO,
+	RATE_CTRL_DUMP_INFO,
+	RATE_CTRL_MU_INFO,
+};
+
+static inline struct mt7921_phy *
+mt7921_hw_phy(struct ieee80211_hw *hw)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	return phy->priv;
+}
+
+static inline struct mt7921_dev *
+mt7921_hw_dev(struct ieee80211_hw *hw)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	return container_of(phy->dev, struct mt7921_dev, mt76);
+}
+
+static inline struct mt7921_phy *
+mt7921_ext_phy(struct mt7921_dev *dev)
+{
+	struct mt76_phy *phy = dev->mt76.phy2;
+
+	if (!phy)
+		return NULL;
+
+	return phy->priv;
+}
+
+static inline u8 mt7921_lmac_mapping(struct mt7921_dev *dev, u8 ac)
+{
+	/* LMAC uses the reverse order of mac80211 AC indexes */
+	return 3 - ac;
+}
+
+extern const struct ieee80211_ops mt7921_ops;
+extern struct pci_driver mt7921_pci_driver;
+
+u32 mt7921_reg_map(struct mt7921_dev *dev, u32 addr);
+
+int mt7921_register_device(struct mt7921_dev *dev);
+void mt7921_unregister_device(struct mt7921_dev *dev);
+int mt7921_eeprom_init(struct mt7921_dev *dev);
+void mt7921_eeprom_parse_band_config(struct mt7921_phy *phy);
+int mt7921_eeprom_get_target_power(struct mt7921_dev *dev,
+				   struct ieee80211_channel *chan,
+				   u8 chain_idx);
+void mt7921_eeprom_init_sku(struct mt7921_dev *dev);
+int mt7921_dma_init(struct mt7921_dev *dev);
+void mt7921_dma_prefetch(struct mt7921_dev *dev);
+void mt7921_dma_cleanup(struct mt7921_dev *dev);
+int mt7921_mcu_init(struct mt7921_dev *dev);
+int mt7921_mcu_add_bss_info(struct mt7921_phy *phy,
+			    struct ieee80211_vif *vif, int enable);
+int mt7921_mcu_sta_update_hdr_trans(struct mt7921_dev *dev,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta);
+int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       struct mt7921_sta *msta, struct ieee80211_key_conf *key,
+		       enum set_key_cmd cmd);
+int mt7921_set_channel(struct mt7921_phy *phy);
+int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
+int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
+int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
+int mt7921_mcu_get_eeprom(struct mt7921_dev *dev, u32 offset);
+int mt7921_mcu_set_mac(struct mt7921_dev *dev, int band, bool enable,
+		       bool hdr_trans);
+int mt7921_mcu_set_rts_thresh(struct mt7921_phy *phy, u32 val);
+int mt7921_mcu_set_sku_en(struct mt7921_phy *phy, bool enable);
+int mt7921_mcu_set_sku(struct mt7921_phy *phy);
+int mt7921_mcu_get_rx_rate(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta, struct rate_info *rate);
+int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl);
+int mt7921_mcu_fw_dbg_ctrl(struct mt7921_dev *dev, u32 module, u8 level);
+void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb);
+void mt7921_mcu_exit(struct mt7921_dev *dev);
+
+static inline bool is_mt7921(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7961;
+}
+
+static inline void mt7921_irq_enable(struct mt7921_dev *dev, u32 mask)
+{
+	mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
+
+	tasklet_schedule(&dev->irq_tasklet);
+}
+
+static inline u32
+mt7921_reg_map_l1(struct mt7921_dev *dev, u32 addr)
+{
+	u32 offset = FIELD_GET(MT_HIF_REMAP_L1_OFFSET, addr);
+	u32 base = FIELD_GET(MT_HIF_REMAP_L1_BASE, addr);
+
+	mt76_rmw_field(dev, MT_HIF_REMAP_L1, MT_HIF_REMAP_L1_MASK, base);
+	/* use read to push write */
+	mt76_rr(dev, MT_HIF_REMAP_L1);
+
+	return MT_HIF_REMAP_BASE_L1 + offset;
+}
+
+static inline u32
+mt7921_l1_rr(struct mt7921_dev *dev, u32 addr)
+{
+	return mt76_rr(dev, mt7921_reg_map_l1(dev, addr));
+}
+
+static inline void
+mt7921_l1_wr(struct mt7921_dev *dev, u32 addr, u32 val)
+{
+	mt76_wr(dev, mt7921_reg_map_l1(dev, addr), val);
+}
+
+static inline u32
+mt7921_l1_rmw(struct mt7921_dev *dev, u32 addr, u32 mask, u32 val)
+{
+	val |= mt7921_l1_rr(dev, addr) & ~mask;
+	mt7921_l1_wr(dev, addr, val);
+
+	return val;
+}
+
+#define mt7921_l1_set(dev, addr, val)	mt7921_l1_rmw(dev, addr, 0, val)
+#define mt7921_l1_clear(dev, addr, val)	mt7921_l1_rmw(dev, addr, val, 0)
+
+bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask);
+void mt7921_mac_reset_counters(struct mt7921_phy *phy);
+void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
+			   struct sk_buff *skb, struct mt76_wcid *wcid,
+			   struct ieee80211_key_conf *key, bool beacon);
+void mt7921_mac_set_timing(struct mt7921_phy *phy);
+int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb);
+void mt7921_mac_fill_rx_vector(struct mt7921_dev *dev, struct sk_buff *skb);
+void mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb);
+int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta);
+void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta);
+void mt7921_mac_work(struct work_struct *work);
+void mt7921_mac_reset_work(struct work_struct *work);
+int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			  struct ieee80211_sta *sta,
+			  struct mt76_tx_info *tx_info);
+void mt7921_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
+int mt7921_init_tx_queues(struct mt7921_phy *phy, int idx, int n_desc);
+void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			 struct sk_buff *skb);
+void mt7921_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
+void mt7921_stats_work(struct work_struct *work);
+void mt7921_txp_skb_unmap(struct mt76_dev *dev,
+			  struct mt76_txwi_cache *txwi);
+void mt7921_set_stream_he_caps(struct mt7921_phy *phy);
+void mt7921_update_channel(struct mt76_dev *mdev);
+int mt7921_init_debugfs(struct mt7921_dev *dev);
+int
+mt7921_mcu_uni_add_dev(struct mt7921_dev *dev,
+		       struct ieee80211_vif *vif, bool enable);
+int
+mt7921_mcu_uni_add_bss(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+		       bool enable);
+
+int
+mt7921_mcu_uni_add_sta(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable);
+int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable);
+int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable);
+void mt7921_scan_work(struct work_struct *work);
+int mt7921_mcu_hw_scan(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+		       struct ieee80211_scan_request *scan_req);
+int mt7921_mcu_cancel_hw_scan(struct mt7921_phy *phy,
+			      struct ieee80211_vif *vif);
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
new file mode 100644
index 000000000000..732a35feca12
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "mt7921.h"
+#include "mac.h"
+#include "../trace.h"
+
+static const struct pci_device_id mt7921_pci_device_table[] = {
+	{ PCI_DEVICE(0x14c3, 0x7961) },
+	{ },
+};
+
+static void
+mt7921_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	if (q == MT_RXQ_MAIN)
+		mt7921_irq_enable(dev, MT_INT_RX_DONE_DATA);
+	else if (q == MT_RXQ_MCU_WA)
+		mt7921_irq_enable(dev, MT_INT_RX_DONE_WM2);
+	else
+		mt7921_irq_enable(dev, MT_INT_RX_DONE_WM);
+}
+
+static irqreturn_t mt7921_irq_handler(int irq, void *dev_instance)
+{
+	struct mt7921_dev *dev = dev_instance;
+
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
+		return IRQ_NONE;
+
+	tasklet_schedule(&dev->irq_tasklet);
+
+	return IRQ_HANDLED;
+}
+
+static void mt7921_irq_tasklet(unsigned long data)
+{
+	struct mt7921_dev *dev = (struct mt7921_dev *)data;
+	u32 intr, mask = 0;
+
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+
+	intr = mt76_rr(dev, MT_WFDMA0_HOST_INT_STA);
+	intr &= dev->mt76.mmio.irqmask;
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_STA, intr);
+
+	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
+
+	mask |= intr & MT_INT_RX_DONE_ALL;
+	if (intr & MT_INT_TX_DONE_MCU)
+		mask |= MT_INT_TX_DONE_MCU;
+
+	mt76_set_irq_mask(&dev->mt76, MT_WFDMA0_HOST_INT_ENA, mask, 0);
+
+	if (intr & MT_INT_TX_DONE_ALL)
+		napi_schedule(&dev->mt76.tx_napi);
+
+	if (intr & MT_INT_RX_DONE_WM)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU]);
+
+	if (intr & MT_INT_RX_DONE_WM2)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU_WA]);
+
+	if (intr & MT_INT_RX_DONE_DATA) /* rx data from lmac */
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MAIN]);
+}
+
+static int
+mt7921_alloc_device(struct pci_dev *pdev, struct mt7921_dev *dev)
+{
+#define NUM_BANDS	2
+	int i;
+	s8 **sku;
+
+	sku = devm_kzalloc(&pdev->dev, NUM_BANDS * sizeof(*sku), GFP_KERNEL);
+	if (!sku)
+		return -ENOMEM;
+
+	for (i = 0; i < NUM_BANDS; i++) {
+		sku[i] = devm_kzalloc(&pdev->dev, MT7921_SKU_TABLE_SIZE *
+				      sizeof(**sku), GFP_KERNEL);
+		if (!sku[i])
+			return -ENOMEM;
+	}
+	dev->rate_power = sku;
+
+	return 0;
+}
+
+static int mt7921_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	static const struct mt76_driver_ops drv_ops = {
+		/* txwi_size = txd size + txp size */
+		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7921_txp_common),
+		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ |
+			     MT_DRV_AMSDU_OFFLOAD,
+		.survey_flags = SURVEY_INFO_TIME_TX |
+				SURVEY_INFO_TIME_RX |
+				SURVEY_INFO_TIME_BSS_RX,
+		.tx_prepare_skb = mt7921_tx_prepare_skb,
+		.tx_complete_skb = mt7921_tx_complete_skb,
+		.rx_skb = mt7921_queue_rx_skb,
+		.rx_poll_complete = mt7921_rx_poll_complete,
+		.sta_ps = mt7921_sta_ps,
+		.sta_add = mt7921_mac_sta_add,
+		.sta_remove = mt7921_mac_sta_remove,
+		.update_survey = mt7921_update_channel,
+	};
+	struct mt7921_dev *dev;
+	struct mt76_dev *mdev;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
+	if (ret < 0)
+		return ret;
+
+	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	if (ret)
+		goto err_free_pci_vec;
+
+	mt76_pci_disable_aspm(pdev);
+
+	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), &mt7921_ops,
+				 &drv_ops);
+	if (!mdev) {
+		ret = -ENOMEM;
+		goto err_free_pci_vec;
+	}
+
+	dev = container_of(mdev, struct mt7921_dev, mt76);
+	ret = mt7921_alloc_device(pdev, dev);
+	if (ret)
+		goto err_free_dev;
+
+	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
+	tasklet_init(&dev->irq_tasklet, mt7921_irq_tasklet, (unsigned long)dev);
+	mdev->rev = (mt7921_l1_rr(dev, MT_HW_CHIPID) << 16) |
+		    (mt7921_l1_rr(dev, MT_HW_REV) & 0xff);
+	dev_err(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+
+	mt7921_l1_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+
+	ret = devm_request_irq(mdev->dev, pdev->irq, mt7921_irq_handler,
+			       IRQF_SHARED, KBUILD_MODNAME, dev);
+	if (ret)
+		goto err_free_dev;
+
+	ret = mt7921_register_device(dev);
+	if (ret)
+		goto err_free_dev;
+
+	return 0;
+
+err_free_dev:
+	mt76_free_device(&dev->mt76);
+err_free_pci_vec:
+	pci_free_irq_vectors(pdev);
+
+	return ret;
+}
+
+static void mt7921_pci_remove(struct pci_dev *pdev)
+{
+	struct mt76_dev *mdev = pci_get_drvdata(pdev);
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	mt7921_unregister_device(dev);
+	devm_free_irq(&pdev->dev, pdev->irq, dev);
+	pci_free_irq_vectors(pdev);
+}
+
+struct pci_driver mt7921_pci_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= mt7921_pci_device_table,
+	.probe		= mt7921_pci_probe,
+	.remove		= mt7921_pci_remove,
+};
+
+module_pci_driver(mt7921_pci_driver);
+
+MODULE_DEVICE_TABLE(pci, mt7921_pci_device_table);
+MODULE_FIRMWARE(MT7921_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7921_ROM_PATCH);
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
new file mode 100644
index 000000000000..9d4e5ea18f54
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -0,0 +1,455 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7921_REGS_H
+#define __MT7921_REGS_H
+
+/* MCU WFDMA1 */
+#define MT_MCU_WFDMA1_BASE		0x3000
+#define MT_MCU_WFDMA1(ofs)		(MT_MCU_WFDMA1_BASE + (ofs))
+
+#define MT_MCU_INT_EVENT		MT_MCU_WFDMA1(0x108)
+#define MT_MCU_INT_EVENT_DMA_STOPPED	BIT(0)
+#define MT_MCU_INT_EVENT_DMA_INIT	BIT(1)
+#define MT_MCU_INT_EVENT_SER_TRIGGER	BIT(2)
+#define MT_MCU_INT_EVENT_RESET_DONE	BIT(3)
+
+#define MT_PLE_BASE			0x8000
+#define MT_PLE(ofs)			(MT_PLE_BASE + (ofs))
+
+#define MT_PLE_FL_Q0_CTRL		MT_PLE(0x1b0)
+#define MT_PLE_FL_Q1_CTRL		MT_PLE(0x1b4)
+#define MT_PLE_FL_Q2_CTRL		MT_PLE(0x1b8)
+#define MT_PLE_FL_Q3_CTRL		MT_PLE(0x1bc)
+
+#define MT_PLE_AC_QEMPTY(ac, n)		MT_PLE(0x300 + 0x10 * (ac) + \
+					       ((n) << 2))
+#define MT_PLE_AMSDU_PACK_MSDU_CNT(n)	MT_PLE(0x10e0 + ((n) << 2))
+
+#define MT_MDP_BASE			0xf000
+#define MT_MDP(ofs)			(MT_MDP_BASE + (ofs))
+
+#define MT_MDP_DCR0			MT_MDP(0x000)
+#define MT_MDP_DCR0_DAMSDU_EN		BIT(15)
+
+#define MT_MDP_DCR1			MT_MDP(0x004)
+#define MT_MDP_DCR1_MAX_RX_LEN		GENMASK(15, 3)
+
+#define MT_MDP_BNRCFR0(_band)		MT_MDP(0x070 + ((_band) << 8))
+#define MT_MDP_RCFR0_MCU_RX_MGMT	GENMASK(5, 4)
+#define MT_MDP_RCFR0_MCU_RX_CTL_NON_BAR	GENMASK(7, 6)
+#define MT_MDP_RCFR0_MCU_RX_CTL_BAR	GENMASK(9, 8)
+
+#define MT_MDP_BNRCFR1(_band)		MT_MDP(0x074 + ((_band) << 8))
+#define MT_MDP_RCFR1_MCU_RX_BYPASS	GENMASK(23, 22)
+#define MT_MDP_RCFR1_RX_DROPPED_UCAST	GENMASK(28, 27)
+#define MT_MDP_RCFR1_RX_DROPPED_MCAST	GENMASK(30, 29)
+#define MT_MDP_TO_HIF			0
+#define MT_MDP_TO_WM			1
+
+/* TMAC: band 0(0x21000), band 1(0xa1000) */
+#define MT_WF_TMAC_BASE(_band)		((_band) ? 0xa1000 : 0x21000)
+#define MT_WF_TMAC(_band, ofs)		(MT_WF_TMAC_BASE(_band) + (ofs))
+
+#define MT_TMAC_TCR0(_band)		MT_WF_TMAC(_band, 0)
+#define MT_TMAC_TCR0_TBTT_STOP_CTRL	BIT(25)
+
+#define MT_TMAC_CDTR(_band)		MT_WF_TMAC(_band, 0x090)
+#define MT_TMAC_ODTR(_band)		MT_WF_TMAC(_band, 0x094)
+#define MT_TIMEOUT_VAL_PLCP		GENMASK(15, 0)
+#define MT_TIMEOUT_VAL_CCA		GENMASK(31, 16)
+
+#define MT_TMAC_ICR0(_band)		MT_WF_TMAC(_band, 0x0a4)
+#define MT_IFS_EIFS			GENMASK(8, 0)
+#define MT_IFS_RIFS			GENMASK(14, 10)
+#define MT_IFS_SIFS			GENMASK(22, 16)
+#define MT_IFS_SLOT			GENMASK(30, 24)
+
+#define MT_TMAC_CTCR0(_band)			MT_WF_TMAC(_band, 0x0f4)
+#define MT_TMAC_CTCR0_INS_DDLMT_REFTIME		GENMASK(5, 0)
+#define MT_TMAC_CTCR0_INS_DDLMT_EN		BIT(17)
+#define MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN	BIT(18)
+
+#define MT_TMAC_TRCR0(_band)		MT_WF_TMAC(_band, 0x09c)
+#define MT_TMAC_TFCR0(_band)		MT_WF_TMAC(_band, 0x1e0)
+
+#define MT_WF_DMA_BASE(_band)		((_band) ? 0xa1e00 : 0x21e00)
+#define MT_WF_DMA(_band, ofs)		(MT_WF_DMA_BASE(_band) + (ofs))
+
+#define MT_DMA_DCR0(_band)		MT_WF_DMA(_band, 0x000)
+#define MT_DMA_DCR0_MAX_RX_LEN		GENMASK(15, 3)
+#define MT_DMA_DCR0_RXD_G5_EN		BIT(23)
+
+/* ETBF: band 0(0x24000), band 1(0xa4000) */
+#define MT_WF_ETBF_BASE(_band)		((_band) ? 0xa4000 : 0x24000)
+#define MT_WF_ETBF(_band, ofs)		(MT_WF_ETBF_BASE(_band) + (ofs))
+
+#define MT_ETBF_TX_NDP_BFRP(_band)	MT_WF_ETBF(_band, 0x040)
+#define MT_ETBF_TX_FB_CPL		GENMASK(31, 16)
+#define MT_ETBF_TX_FB_TRI		GENMASK(15, 0)
+
+#define MT_ETBF_TX_APP_CNT(_band)	MT_WF_ETBF(_band, 0x0f0)
+#define MT_ETBF_TX_IBF_CNT		GENMASK(31, 16)
+#define MT_ETBF_TX_EBF_CNT		GENMASK(15, 0)
+
+#define MT_ETBF_RX_FB_CNT(_band)	MT_WF_ETBF(_band, 0x0f8)
+#define MT_ETBF_RX_FB_ALL		GENMASK(31, 24)
+#define MT_ETBF_RX_FB_HE		GENMASK(23, 16)
+#define MT_ETBF_RX_FB_VHT		GENMASK(15, 8)
+#define MT_ETBF_RX_FB_HT		GENMASK(7, 0)
+
+/* LPON: band 0(0x24200), band 1(0xa4200) */
+#define MT_WF_LPON_BASE(_band)		((_band) ? 0xa4200 : 0x24200)
+#define MT_WF_LPON(_band, ofs)		(MT_WF_LPON_BASE(_band) + (ofs))
+
+#define MT_LPON_UTTR0(_band)		MT_WF_LPON(_band, 0x080)
+#define MT_LPON_UTTR1(_band)		MT_WF_LPON(_band, 0x084)
+
+#define MT_LPON_TCR(_band, n)		MT_WF_LPON(_band, 0x0a8 + (n) * 4)
+#define MT_LPON_TCR_SW_MODE		GENMASK(1, 0)
+#define MT_LPON_TCR_SW_WRITE		BIT(0)
+
+/* MIB: band 0(0x24800), band 1(0xa4800) */
+#define MT_WF_MIB_BASE(_band)		((_band) ? 0xa4800 : 0x24800)
+#define MT_WF_MIB(_band, ofs)		(MT_WF_MIB_BASE(_band) + (ofs))
+
+#define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, 0x014)
+#define MT_MIB_SDR3_FCS_ERR_MASK	GENMASK(15, 0)
+
+#define MT_MIB_SDR9(_band)		MT_WF_MIB(_band, 0x02c)
+#define MT_MIB_SDR9_BUSY_MASK		GENMASK(23, 0)
+
+#define MT_MIB_SDR16(_band)		MT_WF_MIB(_band, 0x048)
+#define MT_MIB_SDR16_BUSY_MASK		GENMASK(23, 0)
+
+#define MT_MIB_SDR34(_band)		MT_WF_MIB(_band, 0x090)
+#define MT_MIB_MU_BF_TX_CNT		GENMASK(15, 0)
+
+#define MT_MIB_SDR36(_band)		MT_WF_MIB(_band, 0x098)
+#define MT_MIB_SDR36_TXTIME_MASK	GENMASK(23, 0)
+#define MT_MIB_SDR37(_band)		MT_WF_MIB(_band, 0x09c)
+#define MT_MIB_SDR37_RXTIME_MASK	GENMASK(23, 0)
+
+#define MT_MIB_DR8(_band)		MT_WF_MIB(_band, 0x0c0)
+#define MT_MIB_DR9(_band)		MT_WF_MIB(_band, 0x0c4)
+#define MT_MIB_DR11(_band)		MT_WF_MIB(_band, 0x0cc)
+
+#define MT_MIB_MB_SDR0(_band, n)	MT_WF_MIB(_band, 0x100 + ((n) << 4))
+#define MT_MIB_RTS_RETRIES_COUNT_MASK	GENMASK(31, 16)
+#define MT_MIB_RTS_COUNT_MASK		GENMASK(15, 0)
+
+#define MT_MIB_MB_SDR1(_band, n)	MT_WF_MIB(_band, 0x104 + ((n) << 4))
+#define MT_MIB_BA_MISS_COUNT_MASK	GENMASK(15, 0)
+#define MT_MIB_ACK_FAIL_COUNT_MASK	GENMASK(31, 16)
+
+#define MT_MIB_MB_SDR2(_band, n)	MT_WF_MIB(_band, 0x108 + ((n) << 4))
+#define MT_MIB_FRAME_RETRIES_COUNT_MASK	GENMASK(15, 0)
+
+#define MT_TX_AGG_CNT(_band, n)		MT_WF_MIB(_band, 0x0a8 + ((n) << 2))
+#define MT_TX_AGG_CNT2(_band, n)	MT_WF_MIB(_band, 0x164 + ((n) << 2))
+#define MT_MIB_ARNG(_band, n)		MT_WF_MIB(_band, 0x4b8 + ((n) << 2))
+#define MT_MIB_ARNCR_RANGE(val, n)	(((val) >> ((n) << 3)) & GENMASK(7, 0))
+
+#define MT_WTBLON_TOP_BASE		0x34000
+#define MT_WTBLON_TOP(ofs)		(MT_WTBLON_TOP_BASE + (ofs))
+#define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x0)
+#define MT_WTBLON_TOP_WDUCR_GROUP	GENMASK(2, 0)
+
+#define MT_WTBL_UPDATE			MT_WTBLON_TOP(0x030)
+#define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(9, 0)
+#define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(12)
+#define MT_WTBL_UPDATE_BUSY		BIT(31)
+
+#define MT_WTBL_BASE			0x38000
+#define MT_WTBL_LMAC_ID			GENMASK(14, 8)
+#define MT_WTBL_LMAC_DW			GENMASK(7, 2)
+#define MT_WTBL_LMAC_OFFS(_id, _dw)	(MT_WTBL_BASE | \
+					FIELD_PREP(MT_WTBL_LMAC_ID, _id) | \
+					FIELD_PREP(MT_WTBL_LMAC_DW, _dw))
+
+/* AGG: band 0(0x20800), band 1(0xa0800) */
+#define MT_WF_AGG_BASE(_band)		((_band) ? 0xa0800 : 0x20800)
+#define MT_WF_AGG(_band, ofs)		(MT_WF_AGG_BASE(_band) + (ofs))
+
+#define MT_AGG_AWSCR0(_band, _n)	MT_WF_AGG(_band, 0x05c + (_n) * 4)
+#define MT_AGG_PCR0(_band, _n)		MT_WF_AGG(_band, 0x06c + (_n) * 4)
+#define MT_AGG_PCR0_MM_PROT		BIT(0)
+#define MT_AGG_PCR0_GF_PROT		BIT(1)
+#define MT_AGG_PCR0_BW20_PROT		BIT(2)
+#define MT_AGG_PCR0_BW40_PROT		BIT(4)
+#define MT_AGG_PCR0_BW80_PROT		BIT(6)
+#define MT_AGG_PCR0_ERP_PROT		GENMASK(12, 8)
+#define MT_AGG_PCR0_VHT_PROT		BIT(13)
+#define MT_AGG_PCR0_PTA_WIN_DIS		BIT(15)
+
+#define MT_AGG_PCR1_RTS0_NUM_THRES	GENMASK(31, 23)
+#define MT_AGG_PCR1_RTS0_LEN_THRES	GENMASK(19, 0)
+
+#define MT_AGG_ACR0(_band)		MT_WF_AGG(_band, 0x084)
+#define MT_AGG_ACR_CFEND_RATE		GENMASK(13, 0)
+#define MT_AGG_ACR_BAR_RATE		GENMASK(29, 16)
+
+#define MT_AGG_MRCR(_band)		MT_WF_AGG(_band, 0x098)
+#define MT_AGG_MRCR_BAR_CNT_LIMIT	GENMASK(15, 12)
+#define MT_AGG_MRCR_LAST_RTS_CTS_RN	BIT(6)
+#define MT_AGG_MRCR_RTS_FAIL_LIMIT	GENMASK(11, 7)
+#define MT_AGG_MRCR_TXCMD_RTS_FAIL_LIMIT	GENMASK(28, 24)
+
+#define MT_AGG_ATCR1(_band)		MT_WF_AGG(_band, 0x0f0)
+#define MT_AGG_ATCR3(_band)		MT_WF_AGG(_band, 0x0f4)
+
+/* ARB: band 0(0x20c00), band 1(0xa0c00) */
+#define MT_WF_ARB_BASE(_band)		((_band) ? 0xa0c00 : 0x20c00)
+#define MT_WF_ARB(_band, ofs)		(MT_WF_ARB_BASE(_band) + (ofs))
+
+#define MT_ARB_SCR(_band)		MT_WF_ARB(_band, 0x080)
+#define MT_ARB_SCR_TX_DISABLE		BIT(8)
+#define MT_ARB_SCR_RX_DISABLE		BIT(9)
+
+#define MT_ARB_DRNGR0(_band, _n)	MT_WF_ARB(_band, 0x194 + (_n) * 4)
+
+/* RMAC: band 0(0x21400), band 1(0xa1400) */
+#define MT_WF_RMAC_BASE(_band)		((_band) ? 0xa1400 : 0x21400)
+#define MT_WF_RMAC(_band, ofs)		(MT_WF_RMAC_BASE(_band) + (ofs))
+
+#define MT_WF_RFCR(_band)		MT_WF_RMAC(_band, 0x000)
+#define MT_WF_RFCR_DROP_STBC_MULTI	BIT(0)
+#define MT_WF_RFCR_DROP_FCSFAIL		BIT(1)
+#define MT_WF_RFCR_DROP_VERSION		BIT(3)
+#define MT_WF_RFCR_DROP_PROBEREQ	BIT(4)
+#define MT_WF_RFCR_DROP_MCAST		BIT(5)
+#define MT_WF_RFCR_DROP_BCAST		BIT(6)
+#define MT_WF_RFCR_DROP_MCAST_FILTERED	BIT(7)
+#define MT_WF_RFCR_DROP_A3_MAC		BIT(8)
+#define MT_WF_RFCR_DROP_A3_BSSID	BIT(9)
+#define MT_WF_RFCR_DROP_A2_BSSID	BIT(10)
+#define MT_WF_RFCR_DROP_OTHER_BEACON	BIT(11)
+#define MT_WF_RFCR_DROP_FRAME_REPORT	BIT(12)
+#define MT_WF_RFCR_DROP_CTL_RSV		BIT(13)
+#define MT_WF_RFCR_DROP_CTS		BIT(14)
+#define MT_WF_RFCR_DROP_RTS		BIT(15)
+#define MT_WF_RFCR_DROP_DUPLICATE	BIT(16)
+#define MT_WF_RFCR_DROP_OTHER_BSS	BIT(17)
+#define MT_WF_RFCR_DROP_OTHER_UC	BIT(18)
+#define MT_WF_RFCR_DROP_OTHER_TIM	BIT(19)
+#define MT_WF_RFCR_DROP_NDPA		BIT(20)
+#define MT_WF_RFCR_DROP_UNWANTED_CTL	BIT(21)
+
+#define MT_WF_RFCR1(_band)		MT_WF_RMAC(_band, 0x004)
+#define MT_WF_RFCR1_DROP_ACK		BIT(4)
+#define MT_WF_RFCR1_DROP_BF_POLL	BIT(5)
+#define MT_WF_RFCR1_DROP_BA		BIT(6)
+#define MT_WF_RFCR1_DROP_CFEND		BIT(7)
+#define MT_WF_RFCR1_DROP_CFACK		BIT(8)
+
+#define MT_WF_RMAC_MIB_TIME0(_band)	MT_WF_RMAC(_band, 0x03c4)
+#define MT_WF_RMAC_MIB_RXTIME_CLR	BIT(31)
+#define MT_WF_RMAC_MIB_RXTIME_EN	BIT(30)
+
+#define MT_WF_RMAC_MIB_AIRTIME14(_band)	MT_WF_RMAC(_band, 0x03b8)
+#define MT_MIB_OBSSTIME_MASK		GENMASK(23, 0)
+#define MT_WF_RMAC_MIB_AIRTIME0(_band)	MT_WF_RMAC(_band, 0x0380)
+
+/* WFDMA0 */
+#define MT_WFDMA0_BASE			0xd4000
+#define MT_WFDMA0(ofs)			(MT_WFDMA0_BASE + (ofs))
+
+#define MT_WFDMA0_RST			MT_WFDMA0(0x100)
+#define MT_WFDMA0_RST_LOGIC_RST		BIT(4)
+#define MT_WFDMA0_RST_DMASHDL_ALL_RST	BIT(5)
+
+#define MT_WFDMA0_BUSY_ENA		MT_WFDMA0(0x13c)
+#define MT_WFDMA0_BUSY_ENA_TX_FIFO0	BIT(0)
+#define MT_WFDMA0_BUSY_ENA_TX_FIFO1	BIT(1)
+#define MT_WFDMA0_BUSY_ENA_RX_FIFO	BIT(2)
+
+#define MT_MCU_CMD                     MT_WFDMA0(0x1f0)
+#define MT_MCU_CMD_STOP_DMA_FW_RELOAD  BIT(1)
+#define MT_MCU_CMD_STOP_DMA            BIT(2)
+#define MT_MCU_CMD_RESET_DONE          BIT(3)
+#define MT_MCU_CMD_RECOVERY_DONE       BIT(4)
+#define MT_MCU_CMD_NORMAL_STATE	       BIT(5)
+#define MT_MCU_CMD_ERROR_MASK          GENMASK(5, 1)
+
+#define MT_WFDMA0_HOST_INT_STA		MT_WFDMA0(0x200)
+#define HOST_RX_DONE_INT_STS0		BIT(0)	/* Rx mcu */
+#define HOST_RX_DONE_INT_STS2		BIT(2)	/* Rx data */
+#define HOST_RX_DONE_INT_STS4		BIT(22)	/* Rx mcu after fw downloaded */
+#define HOST_TX_DONE_INT_STS16		BIT(26)
+#define HOST_TX_DONE_INT_STS17		BIT(27) /* MCU tx done*/
+
+#define MT_WFDMA0_HOST_INT_ENA		MT_WFDMA0(0x204)
+#define HOST_RX_DONE_INT_ENA0		BIT(0)
+#define HOST_RX_DONE_INT_ENA1		BIT(1)
+#define HOST_RX_DONE_INT_ENA2		BIT(2)
+#define HOST_RX_DONE_INT_ENA3		BIT(3)
+#define HOST_TX_DONE_INT_ENA0		BIT(4)
+#define HOST_TX_DONE_INT_ENA1		BIT(5)
+#define HOST_TX_DONE_INT_ENA2		BIT(6)
+#define HOST_TX_DONE_INT_ENA3		BIT(7)
+#define HOST_TX_DONE_INT_ENA4		BIT(8)
+#define HOST_TX_DONE_INT_ENA5		BIT(9)
+#define HOST_TX_DONE_INT_ENA6		BIT(10)
+#define HOST_TX_DONE_INT_ENA7		BIT(11)
+#define HOST_TX_DONE_INT_ENA8		BIT(12)
+#define HOST_TX_DONE_INT_ENA9		BIT(13)
+#define HOST_TX_DONE_INT_ENA10		BIT(14)
+#define HOST_TX_DONE_INT_ENA11		BIT(15)
+#define HOST_TX_DONE_INT_ENA12		BIT(16)
+#define HOST_TX_DONE_INT_ENA13		BIT(17)
+#define HOST_TX_DONE_INT_ENA14		BIT(18)
+#define HOST_RX_COHERENT_EN		BIT(20)
+#define HOST_TX_COHERENT_EN		BIT(21)
+#define HOST_RX_DONE_INT_ENA4		BIT(22)
+#define HOST_RX_DONE_INT_ENA5		BIT(23)
+#define HOST_TX_DONE_INT_ENA16		BIT(26)
+#define HOST_TX_DONE_INT_ENA17		BIT(27)
+#define MCU2HOST_SW_INT_ENA		BIT(29)
+#define HOST_TX_DONE_INT_ENA18		BIT(30)
+
+/* WFDMA interrupt */
+#define MT_INT_RX_DONE_DATA		HOST_RX_DONE_INT_ENA2
+#define MT_INT_RX_DONE_WM		HOST_RX_DONE_INT_ENA0
+#define MT_INT_RX_DONE_WM2		HOST_RX_DONE_INT_ENA4
+#define MT_INT_RX_DONE_ALL		(MT_INT_RX_DONE_DATA | \
+					 MT_INT_RX_DONE_WM | \
+					 MT_INT_RX_DONE_WM2)
+#define MT_INT_TX_DONE_MCU_WM		HOST_TX_DONE_INT_ENA17
+#define MT_INT_TX_DONE_FWDL		HOST_TX_DONE_INT_ENA16
+#define MT_INT_TX_DONE_BAND0		HOST_TX_DONE_INT_ENA0
+#define MT_INT_MCU_CMD			MCU2HOST_SW_INT_ENA
+
+#define MT_INT_TX_DONE_MCU		(MT_INT_TX_DONE_MCU_WM |	\
+					 MT_INT_TX_DONE_FWDL)
+#define MT_INT_TX_DONE_ALL		(MT_INT_TX_DONE_MCU_WM |	\
+					 MT_INT_TX_DONE_BAND0 |	\
+					GENMASK(18, 4))
+
+#define MT_WFDMA0_GLO_CFG		MT_WFDMA0(0x208)
+#define MT_WFDMA0_GLO_CFG_TX_DMA_EN	BIT(0)
+#define MT_WFDMA0_GLO_CFG_TX_DMA_BUSY	BIT(1)
+#define MT_WFDMA0_GLO_CFG_RX_DMA_EN	BIT(2)
+#define MT_WFDMA0_GLO_CFG_RX_DMA_BUSY	BIT(3)
+#define MT_WFDMA0_GLO_CFG_TX_WB_DDONE	BIT(6)
+#define MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN	BIT(12)
+#define MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN BIT(15)
+#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
+#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO	BIT(27)
+#define MT_WFDMA0_GLO_CFG_OMIT_TX_INFO	BIT(28)
+#define MT_WFDMA0_GLO_CFG_CLK_GAT_DIS	BIT(30)
+
+#define MT_WFDMA0_RST_DTX_PTR		MT_WFDMA0(0x20c)
+#define MT_WFDMA0_GLO_CFG_EXT0		MT_WFDMA0(0x2b0)
+#define MT_WFDMA0_CSR_TX_DMASHDL_ENABLE	BIT(6)
+#define MT_WFDMA0_PRI_DLY_INT_CFG0	MT_WFDMA0(0x2f0)
+
+#define MT_RX_DATA_RING_BASE		MT_WFDMA0(0x520)
+
+#define MT_WFDMA0_TX_RING0_EXT_CTRL	MT_WFDMA0(0x600)
+#define MT_WFDMA0_TX_RING1_EXT_CTRL	MT_WFDMA0(0x604)
+#define MT_WFDMA0_TX_RING2_EXT_CTRL	MT_WFDMA0(0x608)
+#define MT_WFDMA0_TX_RING3_EXT_CTRL	MT_WFDMA0(0x60c)
+#define MT_WFDMA0_TX_RING4_EXT_CTRL	MT_WFDMA0(0x610)
+#define MT_WFDMA0_TX_RING5_EXT_CTRL	MT_WFDMA0(0x614)
+#define MT_WFDMA0_TX_RING6_EXT_CTRL	MT_WFDMA0(0x618)
+#define MT_WFDMA0_TX_RING16_EXT_CTRL	MT_WFDMA0(0x640)
+#define MT_WFDMA0_TX_RING17_EXT_CTRL	MT_WFDMA0(0x644)
+
+#define MT_WFDMA0_RX_RING0_EXT_CTRL	MT_WFDMA0(0x680)
+#define MT_WFDMA0_RX_RING1_EXT_CTRL	MT_WFDMA0(0x684)
+#define MT_WFDMA0_RX_RING2_EXT_CTRL	MT_WFDMA0(0x688)
+#define MT_WFDMA0_RX_RING3_EXT_CTRL	MT_WFDMA0(0x68c)
+#define MT_WFDMA0_RX_RING4_EXT_CTRL	MT_WFDMA0(0x690)
+#define MT_WFDMA0_RX_RING5_EXT_CTRL	MT_WFDMA0(0x694)
+
+#define MT_TX_RING_BASE			MT_WFDMA0(0x300)
+#define MT_RX_EVENT_RING_BASE		MT_WFDMA0(0x500)
+
+/* WFDMA CSR */
+#define MT_WFDMA_EXT_CSR_BASE          0xd7000
+#define MT_WFDMA_EXT_CSR(ofs)          (MT_WFDMA_EXT_CSR_BASE + (ofs))
+#define MT_WFDMA_EXT_CSR_HIF_MISC	MT_WFDMA_EXT_CSR(0x44)
+#define MT_WFDMA_EXT_CSR_HIF_MISC_BUSY	BIT(0)
+
+/* WFDMA0 PCIE1 */
+#define MT_WFDMA0_PCIE1_BASE			0xd8000
+#define MT_WFDMA0_PCIE1(ofs)			(MT_WFDMA0_PCIE1_BASE + (ofs))
+
+#define MT_WFDMA0_PCIE1_BUSY_ENA		MT_WFDMA0_PCIE1(0x13c)
+#define MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO0	BIT(0)
+#define MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO1	BIT(1)
+#define MT_WFDMA0_PCIE1_BUSY_ENA_RX_FIFO	BIT(2)
+
+/* WFDMA1 PCIE1 */
+#define MT_WFDMA1_PCIE1_BASE			0xd9000
+#define MT_WFDMA1_PCIE1(ofs)			(MT_WFDMA0_PCIE1_BASE + (ofs))
+
+#define MT_WFDMA1_PCIE1_BUSY_ENA		MT_WFDMA1_PCIE1(0x13c)
+#define MT_WFDMA1_PCIE1_BUSY_ENA_TX_FIFO0	BIT(0)
+#define MT_WFDMA1_PCIE1_BUSY_ENA_TX_FIFO1	BIT(1)
+#define MT_WFDMA1_PCIE1_BUSY_ENA_RX_FIFO	BIT(2)
+
+#define MT_INFRA_CFG_BASE		0xfe000
+#define MT_INFRA(ofs)			(MT_INFRA_CFG_BASE + (ofs))
+
+#define MT_HIF_REMAP_L1			MT_INFRA(0x260)
+#define MT_HIF_REMAP_L1_MASK		GENMASK(15, 0)
+#define MT_HIF_REMAP_L1_OFFSET		GENMASK(15, 0)
+#define MT_HIF_REMAP_L1_BASE		GENMASK(31, 16)
+#define MT_HIF_REMAP_BASE_L1		0xe0000
+
+#define MT_HIF_REMAP_L2			MT_INFRA(0x1b0)
+#define MT_HIF_REMAP_L2_MASK		GENMASK(19, 0)
+#define MT_HIF_REMAP_L2_OFFSET		GENMASK(11, 0)
+#define MT_HIF_REMAP_L2_BASE		GENMASK(31, 12)
+#define MT_HIF_REMAP_BASE_L2		0x00000
+
+#define MT_SWDEF_BASE			0x41f200
+#define MT_SWDEF(ofs)			(MT_SWDEF_BASE + (ofs))
+#define MT_SWDEF_MODE			MT_SWDEF(0x3c)
+#define MT_SWDEF_NORMAL_MODE		0
+#define MT_SWDEF_ICAP_MODE		1
+#define MT_SWDEF_SPECTRUM_MODE		2
+
+#define MT_TOP_BASE			0x18060000
+#define MT_TOP(ofs)			(MT_TOP_BASE + (ofs))
+
+#define MT_TOP_LPCR_HOST_BAND0		MT_TOP(0x10)
+#define MT_TOP_LPCR_HOST_FW_OWN		BIT(0)
+#define MT_TOP_LPCR_HOST_DRV_OWN	BIT(1)
+
+#define MT_TOP_MISC			MT_TOP(0xf0)
+#define MT_TOP_MISC_FW_STATE		GENMASK(2, 0)
+
+#define MT_HW_BOUND			0x70010020
+#define MT_HW_CHIPID			0x70010200
+#define MT_HW_REV			0x70010204
+
+#define MT_PCIE_MAC_BASE		0x74030000
+#define MT_PCIE_MAC(ofs)		(MT_PCIE_MAC_BASE + (ofs))
+#define MT_PCIE_MAC_INT_ENABLE		MT_PCIE_MAC(0x188)
+
+#define MT_DMA_SHDL(ofs)		(0xd6000 + (ofs))
+#define MT_DMASHDL_SW_CONTROL		MT_DMA_SHDL(0x004)
+#define MT_DMASHDL_DMASHDL_BYPASS	BIT(28)
+#define MT_DMASHDL_OPTIONAL		MT_DMA_SHDL(0x008)
+#define MT_DMASHDL_PAGE			MT_DMA_SHDL(0x00c)
+#define MT_DMASHDL_REFILL		MT_DMA_SHDL(0x010)
+#define MT_DMASHDL_PKT_MAX_SIZE		MT_DMA_SHDL(0x01c)
+#define MT_DMASHDL_PKT_MAX_SIZE_PLE	GENMASK(11, 0)
+#define MT_DMASHDL_PKT_MAX_SIZE_PSE	GENMASK(27, 16)
+
+#define MT_DMASHDL_GROUP_QUOTA(_n)	MT_DMA_SHDL(0x020 + ((_n) << 2))
+#define MT_DMASHDL_GROUP_QUOTA_MIN	GENMASK(11, 0)
+#define MT_DMASHDL_GROUP_QUOTA_MAX	GENMASK(27, 16)
+
+#define MT_DMASHDL_Q_MAP(_n)		MT_DMA_SHDL(0x060 + ((_n) << 2))
+#define MT_DMASHDL_Q_MAP_MASK		GENMASK(3, 0)
+#define MT_DMASHDL_Q_MAP_SHIFT(_n)	(4 * ((_n) % 8))
+
+#define MT_DMASHDL_SCHED_SET(_n)	MT_DMA_SHDL(0x070 + ((_n) << 2))
+
+#define MT_CONN_ON_MISC			0x7c0600f0
+#define MT_TOP_MISC2_FW_N9_RDY		GENMASK(1, 0)
+
+#endif
-- 
2.25.1

