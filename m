Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0732AB18A3
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 09:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfIMHGL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 03:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfIMHGL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 03:06:11 -0400
Received: from localhost.localdomain (unknown [151.66.2.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7081720830;
        Fri, 13 Sep 2019 07:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568358370;
        bh=unA0kkxKI0bE7qfNzMw+b++7T23/P+TYxDhTxgf48AU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qgqo2EpYBHaBNtGjbsOypYwE04iftndFI0M1WB7Wri7EPomTA55tBnNxrugdWZ2xy
         FTPyfh5+qlFTDxtcAn/479ElK3EbNCctf0fAl60OjqkBo5cv73x2L/Bw0msVetG17L
         N5WcEI1WscSx3AfwGxa68R4mXIFKS1F0JN3mQlGA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 5/5] mt76: mt7603: collect aggregation stats
Date:   Fri, 13 Sep 2019 09:05:54 +0200
Message-Id: <f2cf4e61a9cb60822b534dd9fb4f217c66a671c4.1568358061.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568358061.git.lorenzo@kernel.org>
References: <cover.1568358061.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce ampdu_stat entry in mt7603 debugfs in order to dump 802.11
aggr cumulative statistics

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7603/debugfs.c   | 36 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7603/mac.c   | 18 ++++++++++
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  1 +
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7603/regs.h  |  5 +++
 5 files changed, 61 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
index 45eb24862240..47c85a9fac28 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
@@ -69,6 +69,41 @@ mt7603_edcca_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_edcca, mt7603_edcca_get,
 			 mt7603_edcca_set, "%lld\n");
 
+static int
+mt7603_ampdu_stat_read(struct seq_file *file, void *data)
+{
+	struct mt7603_dev *dev = file->private;
+	int bound[3], i, range;
+
+	range = mt76_rr(dev, MT_AGG_ASRCR);
+	for (i = 0; i < ARRAY_SIZE(bound); i++)
+		bound[i] = MT_AGG_ASRCR_RANGE(range, i) + 1;
+
+	seq_printf(file, "Length: %8d | ", bound[0]);
+	for (i = 0; i < ARRAY_SIZE(bound) - 1; i++)
+		seq_printf(file, "%3d -%3d | ",
+			   bound[i], bound[i + 1]);
+	seq_puts(file, "\nCount:  ");
+	for (i = 0; i < ARRAY_SIZE(bound); i++)
+		seq_printf(file, "%8d | ", dev->mt76.aggr_stats[i]);
+	seq_puts(file, "\n");
+
+	return 0;
+}
+
+static int
+mt7603_ampdu_stat_open(struct inode *inode, struct file *f)
+{
+	return single_open(f, mt7603_ampdu_stat_read, inode->i_private);
+}
+
+static const struct file_operations fops_ampdu_stat = {
+	.open = mt7603_ampdu_stat_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
 void mt7603_init_debugfs(struct mt7603_dev *dev)
 {
 	struct dentry *dir;
@@ -77,6 +112,7 @@ void mt7603_init_debugfs(struct mt7603_dev *dev)
 	if (!dir)
 		return;
 
+	debugfs_create_file("ampdu_stat", 0400, dir, dev, &fops_ampdu_stat);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "queues", dir,
 				    mt76_queues_read);
 	debugfs_create_file("edcca", 0600, dir, dev, &fops_edcca);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index c328192307c4..c52c4bf5597e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -31,6 +31,16 @@ mt76_start_tx_ac(struct mt7603_dev *dev, u32 mask)
 	mt76_set(dev, MT_WF_ARB_TX_START_0, mt7603_ac_queue_mask0(mask));
 }
 
+void mt7603_mac_reset_counters(struct mt7603_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < 2; i++)
+		mt76_rr(dev, MT_TX_AGG_CNT(i));
+
+	memset(dev->mt76.aggr_stats, 0, sizeof(dev->mt76.aggr_stats));
+}
+
 void mt7603_mac_set_timing(struct mt7603_dev *dev)
 {
 	u32 cck = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 231) |
@@ -1677,6 +1687,7 @@ void mt7603_mac_work(struct work_struct *work)
 	struct mt7603_dev *dev = container_of(work, struct mt7603_dev,
 					      mt76.mac_work.work);
 	bool reset = false;
+	int i, idx;
 
 	mt76_tx_status_check(&dev->mt76, NULL, false);
 
@@ -1686,6 +1697,13 @@ void mt7603_mac_work(struct work_struct *work)
 	mt7603_update_channel(&dev->mt76);
 	mt7603_edcca_check(dev);
 
+	for (i = 0, idx = 0; i < 2; i++) {
+		u32 val = mt76_rr(dev, MT_TX_AGG_CNT(i));
+
+		dev->mt76.aggr_stats[idx++] += val & 0xffff;
+		dev->mt76.aggr_stats[idx++] += val >> 16;
+	}
+
 	if (dev->mac_work_count == 10)
 		mt7603_false_cca_check(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 25d5b1608bc9..e7b57f20b629 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -13,6 +13,7 @@ mt7603_start(struct ieee80211_hw *hw)
 {
 	struct mt7603_dev *dev = hw->priv;
 
+	mt7603_mac_reset_counters(dev);
 	mt7603_mac_start(dev);
 	dev->mt76.survey_time = ktime_get_boottime();
 	set_bit(MT76_STATE_RUNNING, &dev->mt76.state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 257300fec4f8..fb10adca17f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -191,6 +191,7 @@ static inline void mt7603_irq_disable(struct mt7603_dev *dev, u32 mask)
 	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
 }
 
+void mt7603_mac_reset_counters(struct mt7603_dev *dev);
 void mt7603_mac_dma_start(struct mt7603_dev *dev);
 void mt7603_mac_start(struct mt7603_dev *dev);
 void mt7603_mac_stop(struct mt7603_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
index eb9eefe8e125..6e23ed3dfdff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
@@ -212,6 +212,9 @@
 #define MT_AGG_PCR_RTS_THR		GENMASK(19, 0)
 #define MT_AGG_PCR_RTS_PKT_THR		GENMASK(31, 25)
 
+#define MT_AGG_ASRCR			MT_WF_AGG(0x060)
+#define MT_AGG_ASRCR_RANGE(val, n)	(((val) >> ((n) << 3)) & GENMASK(5, 0))
+
 #define MT_AGG_CONTROL			MT_WF_AGG(0x070)
 #define MT_AGG_CONTROL_NO_BA_RULE	BIT(0)
 #define MT_AGG_CONTROL_NO_BA_AR_RULE	BIT(1)
@@ -555,6 +558,8 @@ enum {
 #define MT_MIB_STAT_PSCCA		MT_MIB_STAT(16)
 #define MT_MIB_STAT_PSCCA_MASK		GENMASK(23, 0)
 
+#define MT_TX_AGG_CNT(n)		MT_MIB(0xa8 + ((n) << 2))
+
 #define MT_MIB_STAT_ED			MT_MIB_STAT(18)
 #define MT_MIB_STAT_ED_MASK		GENMASK(23, 0)
 
-- 
2.21.0

