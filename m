Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C57A7409E0
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjF1Hwm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50292 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230313AbjF1Hwb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:31 -0400
X-UUID: 6a90d5fc158211eeb20a276fd37b9834-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bKr6J5/OYABkubgDPqlofFbnpQPdB5veL6EF84bkIpY=;
        b=on7ntoHaijj92+NqxO+LSD4V9N3ys/UDg/ahJ40yohVqpTbnWIRab36rkWiRALn7rAzgE2vHz4+iQnIPcLjB4wKsgOYtLjmY1ncteKOK9GE0TW5RaJE8tEMOx80KS9nmABrpMrCL4LLNKSy1VLy9si6aLf6twaWvPxA7X40tTAY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:2ecab36a-7d7c-417d-b925-f5e9c2c06554,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:a8d05eda-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6a90d5fc158211eeb20a276fd37b9834-20230628
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2022111179; Wed, 28 Jun 2023 15:07:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:07:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:07:16 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 14/16] wifi: mt76: mt7921: move debugfs shared code in mt792x-lib module
Date:   Wed, 28 Jun 2023 15:06:00 +0800
Message-ID: <bfcc350b27bffd843baf81592754be92f6e86055.1687919628.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687919628.git.deren.wu@mediatek.com>
References: <cover.1687919628.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Reduce duplicated code moving debugfs shared code in mt792x-lib module.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/Makefile   |   3 +-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   | 178 +-----------------
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   6 +
 .../wireless/mediatek/mt76/mt792x_debugfs.c   | 168 +++++++++++++++++
 4 files changed, 183 insertions(+), 172 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c

diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index a20eebba04ba..a45853ab958f 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -31,7 +31,8 @@ mt76x02-usb-y := mt76x02_usb_mcu.o mt76x02_usb_core.o
 
 mt76-connac-lib-y := mt76_connac_mcu.o mt76_connac_mac.o mt76_connac3_mac.o
 
-mt792x-lib-y := mt792x_core.o mt792x_mac.o mt792x_trace.o
+mt792x-lib-y := mt792x_core.o mt792x_mac.o mt792x_trace.o \
+		mt792x_debugfs.o
 
 obj-$(CONFIG_MT76x0_COMMON) += mt76x0/
 obj-$(CONFIG_MT76x2_COMMON) += mt76x2/
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 7d5211b99340..616b66a3fde2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -57,128 +57,7 @@ mt7921_fw_debug_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug, mt7921_fw_debug_get,
 			 mt7921_fw_debug_set, "%lld\n");
 
-static void
-mt7921_ampdu_stat_read_phy(struct mt792x_phy *phy,
-			   struct seq_file *file)
-{
-	struct mt792x_dev *dev = file->private;
-	int bound[15], range[4], i;
-
-	if (!phy)
-		return;
-
-	mt792x_mac_update_mib_stats(phy);
-
-	/* Tx ampdu stat */
-	for (i = 0; i < ARRAY_SIZE(range); i++)
-		range[i] = mt76_rr(dev, MT_MIB_ARNG(0, i));
-
-	for (i = 0; i < ARRAY_SIZE(bound); i++)
-		bound[i] = MT_MIB_ARNCR_RANGE(range[i / 4], i % 4) + 1;
-
-	seq_printf(file, "\nPhy0\n");
-
-	seq_printf(file, "Length: %8d | ", bound[0]);
-	for (i = 0; i < ARRAY_SIZE(bound) - 1; i++)
-		seq_printf(file, "%3d  %3d | ", bound[i] + 1, bound[i + 1]);
-
-	seq_puts(file, "\nCount:  ");
-	for (i = 0; i < ARRAY_SIZE(bound); i++)
-		seq_printf(file, "%8d | ", phy->mt76->aggr_stats[i]);
-	seq_puts(file, "\n");
-
-	seq_printf(file, "BA miss count: %d\n", phy->mib.ba_miss_cnt);
-}
-
-static int
-mt7921_tx_stats_show(struct seq_file *file, void *data)
-{
-	struct mt792x_dev *dev = file->private;
-	struct mt792x_phy *phy = &dev->phy;
-	struct mt76_mib_stats *mib = &phy->mib;
-	int i;
-
-	mt792x_mutex_acquire(dev);
-
-	mt7921_ampdu_stat_read_phy(phy, file);
-
-	seq_puts(file, "Tx MSDU stat:\n");
-	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++) {
-		seq_printf(file, "AMSDU pack count of %d MSDU in TXD: %8d ",
-			   i + 1, mib->tx_amsdu[i]);
-		if (mib->tx_amsdu_cnt)
-			seq_printf(file, "(%3d%%)\n",
-				   mib->tx_amsdu[i] * 100 / mib->tx_amsdu_cnt);
-		else
-			seq_puts(file, "\n");
-	}
-
-	mt792x_mutex_release(dev);
-
-	return 0;
-}
-
-DEFINE_SHOW_ATTRIBUTE(mt7921_tx_stats);
-
-static int
-mt7921_queues_acq(struct seq_file *s, void *data)
-{
-	struct mt792x_dev *dev = dev_get_drvdata(s->private);
-	int i;
-
-	mt792x_mutex_acquire(dev);
-
-	for (i = 0; i < 4; i++) {
-		u32 ctrl, val, qlen = 0;
-		int j;
-
-		val = mt76_rr(dev, MT_PLE_AC_QEMPTY(i));
-		ctrl = BIT(31) | BIT(11) | (i << 24);
-
-		for (j = 0; j < 32; j++) {
-			if (val & BIT(j))
-				continue;
-
-			mt76_wr(dev, MT_PLE_FL_Q0_CTRL, ctrl | j);
-			qlen += mt76_get_field(dev, MT_PLE_FL_Q3_CTRL,
-					       GENMASK(11, 0));
-		}
-		seq_printf(s, "AC%d: queued=%d\n", i, qlen);
-	}
-
-	mt792x_mutex_release(dev);
-
-	return 0;
-}
-
-static int
-mt7921_queues_read(struct seq_file *s, void *data)
-{
-	struct mt792x_dev *dev = dev_get_drvdata(s->private);
-	struct {
-		struct mt76_queue *q;
-		char *queue;
-	} queue_map[] = {
-		{ dev->mphy.q_tx[MT_TXQ_BE],	 "WFDMA0" },
-		{ dev->mt76.q_mcu[MT_MCUQ_WM],	 "MCUWM"  },
-		{ dev->mt76.q_mcu[MT_MCUQ_FWDL], "MCUFWQ" },
-	};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(queue_map); i++) {
-		struct mt76_queue *q = queue_map[i].q;
-
-		if (!q)
-			continue;
-
-		seq_printf(s,
-			   "%s:	queued=%d head=%d tail=%d\n",
-			   queue_map[i].queue, q->queued, q->head,
-			   q->tail);
-	}
-
-	return 0;
-}
+DEFINE_SHOW_ATTRIBUTE(mt792x_tx_stats);
 
 static void
 mt7921_seq_puts_array(struct seq_file *file, const char *str,
@@ -342,51 +221,8 @@ mt7921_deep_sleep_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_ds, mt7921_deep_sleep_get,
 			 mt7921_deep_sleep_set, "%lld\n");
 
-static int
-mt7921_pm_stats(struct seq_file *s, void *data)
-{
-	struct mt792x_dev *dev = dev_get_drvdata(s->private);
-	struct mt76_connac_pm *pm = &dev->pm;
-
-	unsigned long awake_time = pm->stats.awake_time;
-	unsigned long doze_time = pm->stats.doze_time;
-
-	if (!test_bit(MT76_STATE_PM, &dev->mphy.state))
-		awake_time += jiffies - pm->stats.last_wake_event;
-	else
-		doze_time += jiffies - pm->stats.last_doze_event;
-
-	seq_printf(s, "awake time: %14u\ndoze time: %15u\n",
-		   jiffies_to_msecs(awake_time),
-		   jiffies_to_msecs(doze_time));
-
-	seq_printf(s, "low power wakes: %9d\n", pm->stats.lp_wake);
-
-	return 0;
-}
-
-static int
-mt7921_pm_idle_timeout_set(void *data, u64 val)
-{
-	struct mt792x_dev *dev = data;
-
-	dev->pm.idle_timeout = msecs_to_jiffies(val);
-
-	return 0;
-}
-
-static int
-mt7921_pm_idle_timeout_get(void *data, u64 *val)
-{
-	struct mt792x_dev *dev = data;
-
-	*val = jiffies_to_msecs(dev->pm.idle_timeout);
-
-	return 0;
-}
-
-DEFINE_DEBUGFS_ATTRIBUTE(fops_pm_idle_timeout, mt7921_pm_idle_timeout_get,
-			 mt7921_pm_idle_timeout_set, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_pm_idle_timeout, mt792x_pm_idle_timeout_get,
+			 mt792x_pm_idle_timeout_set, "%lld\n");
 
 static int mt7921_chip_reset(void *data, u64 val)
 {
@@ -435,23 +271,23 @@ int mt7921_init_debugfs(struct mt792x_dev *dev)
 
 	if (mt76_is_mmio(&dev->mt76))
 		debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues",
-					    dir, mt7921_queues_read);
+					    dir, mt792x_queues_read);
 	else
 		debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues",
 					    dir, mt76_queues_read);
 
 	debugfs_create_devm_seqfile(dev->mt76.dev, "acq", dir,
-				    mt7921_queues_acq);
+				    mt792x_queues_acq);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "txpower_sku", dir,
 				    mt7921_txpwr);
-	debugfs_create_file("tx_stats", 0400, dir, dev, &mt7921_tx_stats_fops);
+	debugfs_create_file("tx_stats", 0400, dir, dev, &mt792x_tx_stats_fops);
 	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
 	debugfs_create_file("runtime-pm", 0600, dir, dev, &fops_pm);
 	debugfs_create_file("idle-timeout", 0600, dir, dev,
 			    &fops_pm_idle_timeout);
 	debugfs_create_file("chip_reset", 0600, dir, dev, &fops_reset);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "runtime_pm_stats", dir,
-				    mt7921_pm_stats);
+				    mt792x_pm_stats);
 	debugfs_create_file("deep-sleep", 0600, dir, dev, &fops_ds);
 	if (mt76_is_sdio(&dev->mt76))
 		debugfs_create_devm_seqfile(dev->mt76.dev, "sched-quota", dir,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index fa199cc05c60..1fd53a29fef1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -229,5 +229,11 @@ void mt792x_dma_cleanup(struct mt792x_dev *dev);
 int mt792x_dma_disable(struct mt792x_dev *dev, bool force);
 int mt792x_poll_rx(struct napi_struct *napi, int budget);
 int mt792x_wfsys_reset(struct mt792x_dev *dev, u32 addr);
+int mt792x_tx_stats_show(struct seq_file *file, void *data);
+int mt792x_queues_acq(struct seq_file *s, void *data);
+int mt792x_queues_read(struct seq_file *s, void *data);
+int mt792x_pm_stats(struct seq_file *s, void *data);
+int mt792x_pm_idle_timeout_set(void *data, u64 val);
+int mt792x_pm_idle_timeout_get(void *data, u64 *val);
 
 #endif /* __MT7925_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c b/drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c
new file mode 100644
index 000000000000..9858d9a93851
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#include "mt792x.h"
+
+static void
+mt792x_ampdu_stat_read_phy(struct mt792x_phy *phy,
+			   struct seq_file *file)
+{
+	struct mt792x_dev *dev = file->private;
+	int bound[15], range[4], i;
+
+	if (!phy)
+		return;
+
+	mt792x_mac_update_mib_stats(phy);
+
+	/* Tx ampdu stat */
+	for (i = 0; i < ARRAY_SIZE(range); i++)
+		range[i] = mt76_rr(dev, MT_MIB_ARNG(0, i));
+
+	for (i = 0; i < ARRAY_SIZE(bound); i++)
+		bound[i] = MT_MIB_ARNCR_RANGE(range[i / 4], i % 4) + 1;
+
+	seq_puts(file, "\nPhy0\n");
+
+	seq_printf(file, "Length: %8d | ", bound[0]);
+	for (i = 0; i < ARRAY_SIZE(bound) - 1; i++)
+		seq_printf(file, "%3d  %3d | ", bound[i] + 1, bound[i + 1]);
+
+	seq_puts(file, "\nCount:  ");
+	for (i = 0; i < ARRAY_SIZE(bound); i++)
+		seq_printf(file, "%8d | ", phy->mt76->aggr_stats[i]);
+	seq_puts(file, "\n");
+
+	seq_printf(file, "BA miss count: %d\n", phy->mib.ba_miss_cnt);
+}
+
+int mt792x_tx_stats_show(struct seq_file *file, void *data)
+{
+	struct mt792x_dev *dev = file->private;
+	struct mt792x_phy *phy = &dev->phy;
+	struct mt76_mib_stats *mib = &phy->mib;
+	int i;
+
+	mt792x_mutex_acquire(dev);
+
+	mt792x_ampdu_stat_read_phy(phy, file);
+
+	seq_puts(file, "Tx MSDU stat:\n");
+	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++) {
+		seq_printf(file, "AMSDU pack count of %d MSDU in TXD: %8d ",
+			   i + 1, mib->tx_amsdu[i]);
+		if (mib->tx_amsdu_cnt)
+			seq_printf(file, "(%3d%%)\n",
+				   mib->tx_amsdu[i] * 100 / mib->tx_amsdu_cnt);
+		else
+			seq_puts(file, "\n");
+	}
+
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_tx_stats_show);
+
+int mt792x_queues_acq(struct seq_file *s, void *data)
+{
+	struct mt792x_dev *dev = dev_get_drvdata(s->private);
+	int i;
+
+	mt792x_mutex_acquire(dev);
+
+	for (i = 0; i < 4; i++) {
+		u32 ctrl, val, qlen = 0;
+		int j;
+
+		val = mt76_rr(dev, MT_PLE_AC_QEMPTY(i));
+		ctrl = BIT(31) | BIT(11) | (i << 24);
+
+		for (j = 0; j < 32; j++) {
+			if (val & BIT(j))
+				continue;
+
+			mt76_wr(dev, MT_PLE_FL_Q0_CTRL, ctrl | j);
+			qlen += mt76_get_field(dev, MT_PLE_FL_Q3_CTRL,
+					       GENMASK(11, 0));
+		}
+		seq_printf(s, "AC%d: queued=%d\n", i, qlen);
+	}
+
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_queues_acq);
+
+int mt792x_queues_read(struct seq_file *s, void *data)
+{
+	struct mt792x_dev *dev = dev_get_drvdata(s->private);
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
+EXPORT_SYMBOL_GPL(mt792x_queues_read);
+
+int mt792x_pm_stats(struct seq_file *s, void *data)
+{
+	struct mt792x_dev *dev = dev_get_drvdata(s->private);
+	struct mt76_connac_pm *pm = &dev->pm;
+
+	unsigned long awake_time = pm->stats.awake_time;
+	unsigned long doze_time = pm->stats.doze_time;
+
+	if (!test_bit(MT76_STATE_PM, &dev->mphy.state))
+		awake_time += jiffies - pm->stats.last_wake_event;
+	else
+		doze_time += jiffies - pm->stats.last_doze_event;
+
+	seq_printf(s, "awake time: %14u\ndoze time: %15u\n",
+		   jiffies_to_msecs(awake_time),
+		   jiffies_to_msecs(doze_time));
+
+	seq_printf(s, "low power wakes: %9d\n", pm->stats.lp_wake);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_pm_stats);
+
+int mt792x_pm_idle_timeout_set(void *data, u64 val)
+{
+	struct mt792x_dev *dev = data;
+
+	dev->pm.idle_timeout = msecs_to_jiffies(val);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_pm_idle_timeout_set);
+
+int mt792x_pm_idle_timeout_get(void *data, u64 *val)
+{
+	struct mt792x_dev *dev = data;
+
+	*val = jiffies_to_msecs(dev->pm.idle_timeout);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_pm_idle_timeout_get);
-- 
2.18.0

