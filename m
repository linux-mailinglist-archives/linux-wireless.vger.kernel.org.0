Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527F42DD811
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 19:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgLQSOk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 13:14:40 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:41759 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731555AbgLQSOh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 13:14:37 -0500
X-UUID: 4cc90e7accfa487692e339dbe818cb32-20201218
X-UUID: 4cc90e7accfa487692e339dbe818cb32-20201218
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1290169400; Fri, 18 Dec 2020 02:13:33 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Dec 2020 02:13:23 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Dec 2020 02:13:24 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <Eric.Liang@mediatek.com>,
        <ryder.lee@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v3 8/8] mt76: mt7921: add debugfs support
Date:   Fri, 18 Dec 2020 02:13:21 +0800
Message-ID: <89fc8a716d5a40063d55783c3ef52a2952c22850.1608227863.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1608227863.git.objelf@gmail.com>
References: <cover.1608227863.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add debugfs support to dump driver statistics and hardware details.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/Makefile    |   2 +-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   | 178 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   2 +-
 3 files changed, 180 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index dc3c05c389f2..daac64fc2cc0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -2,4 +2,4 @@
 
 obj-$(CONFIG_MT7921E) += mt7921e.o
 
-mt7921e-y := pci.o mcu.o mac.o dma.o eeprom.o main.o init.o
+mt7921e-y := pci.o mcu.o mac.o dma.o eeprom.o main.o init.o debugfs.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
new file mode 100644
index 000000000000..9cdeb14cc933
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -0,0 +1,178 @@
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
+	int bound[15], range[4], i;
+
+	if (!phy)
+		return;
+
+	/* Tx ampdu stat */
+	for (i = 0; i < ARRAY_SIZE(range); i++)
+		range[i] = mt76_rr(dev, MT_MIB_ARNG(0, i));
+
+	for (i = 0; i < ARRAY_SIZE(bound); i++)
+		bound[i] = MT_MIB_ARNCR_RANGE(range[i / 4], i) + 1;
+
+	seq_printf(file, "\nPhy0\n");
+
+	seq_printf(file, "Length: %8d | ", bound[0]);
+	for (i = 0; i < ARRAY_SIZE(bound) - 1; i++)
+		seq_printf(file, "%3d -%3d | ",
+			   bound[i] + 1, bound[i + 1]);
+
+	seq_puts(file, "\nCount:  ");
+	for (i = 0; i < ARRAY_SIZE(bound); i++)
+		seq_printf(file, "%8d | ", dev->mt76.aggr_stats[i]);
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index e5ba2591a61d..446f76bbfd21 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -231,7 +231,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
 
 	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
 
-	return 0;
+	return mt7921_init_debugfs(dev);
 }
 
 void mt7921_unregister_device(struct mt7921_dev *dev)
-- 
2.25.1

