Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7598B221F0A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jul 2020 10:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGPIyO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 04:54:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbgGPIyN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 04:54:13 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 35B31ED79A95EA31D2FB;
        Thu, 16 Jul 2020 16:54:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 16:54:08 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mt76: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 16:58:01 +0800
Message-ID: <20200716085801.11220-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 .../wireless/mediatek/mt76/mt7603/debugfs.c   | 17 ++--------
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 17 ++--------
 .../wireless/mediatek/mt76/mt76x02_debugfs.c  | 34 ++++---------------
 3 files changed, 12 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
index fc913aad2..005a8cb97 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
@@ -70,7 +70,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_edcca, mt7603_edcca_get,
 			 mt7603_edcca_set, "%lld\n");
 
 static int
-mt7603_ampdu_stat_read(struct seq_file *file, void *data)
+mt7603_ampdu_stat_show(struct seq_file *file, void *data)
 {
 	struct mt7603_dev *dev = file->private;
 	int bound[3], i, range;
@@ -91,18 +91,7 @@ mt7603_ampdu_stat_read(struct seq_file *file, void *data)
 	return 0;
 }
 
-static int
-mt7603_ampdu_stat_open(struct inode *inode, struct file *f)
-{
-	return single_open(f, mt7603_ampdu_stat_read, inode->i_private);
-}
-
-static const struct file_operations fops_ampdu_stat = {
-	.open = mt7603_ampdu_stat_open,
-	.read_iter = seq_read_iter,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mt7603_ampdu_stat);
 
 void mt7603_init_debugfs(struct mt7603_dev *dev)
 {
@@ -112,7 +101,7 @@ void mt7603_init_debugfs(struct mt7603_dev *dev)
 	if (!dir)
 		return;
 
-	debugfs_create_file("ampdu_stat", 0400, dir, dev, &fops_ampdu_stat);
+	debugfs_create_file("ampdu_stat", 0400, dir, dev, &mt7603_ampdu_stat_fops);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues", dir,
 				    mt76_queues_read);
 	debugfs_create_file("edcca", 0600, dir, dev, &fops_edcca);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index e356d9ec5..360d44331 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -163,7 +163,7 @@ mt7615_ampdu_stat_read_phy(struct mt7615_phy *phy,
 }
 
 static int
-mt7615_ampdu_stat_read(struct seq_file *file, void *data)
+mt7615_ampdu_stat_show(struct seq_file *file, void *data)
 {
 	struct mt7615_dev *dev = file->private;
 
@@ -173,18 +173,7 @@ mt7615_ampdu_stat_read(struct seq_file *file, void *data)
 	return 0;
 }
 
-static int
-mt7615_ampdu_stat_open(struct inode *inode, struct file *f)
-{
-	return single_open(f, mt7615_ampdu_stat_read, inode->i_private);
-}
-
-static const struct file_operations fops_ampdu_stat = {
-	.open = mt7615_ampdu_stat_open,
-	.read_iter = seq_read_iter,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mt7615_ampdu_stat);
 
 static void
 mt7615_radio_read_phy(struct mt7615_phy *phy, struct seq_file *s)
@@ -301,7 +290,7 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 					    mt76_queues_read);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "acq", dir,
 				    mt7615_queues_acq);
-	debugfs_create_file("ampdu_stat", 0400, dir, dev, &fops_ampdu_stat);
+	debugfs_create_file("ampdu_stat", 0400, dir, dev, &mt7615_ampdu_stat_fops);
 	debugfs_create_file("scs", 0600, dir, dev, &fops_scs);
 	debugfs_create_file("dbdc", 0600, dir, dev, &fops_dbdc);
 	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
index eda1e49c6..c4fe1c436 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
@@ -7,7 +7,7 @@
 #include "mt76x02.h"
 
 static int
-mt76x02_ampdu_stat_read(struct seq_file *file, void *data)
+mt76x02_ampdu_stat_show(struct seq_file *file, void *data)
 {
 	struct mt76x02_dev *dev = file->private;
 	int i, j;
@@ -31,11 +31,7 @@ mt76x02_ampdu_stat_read(struct seq_file *file, void *data)
 	return 0;
 }
 
-static int
-mt76x02_ampdu_stat_open(struct inode *inode, struct file *f)
-{
-	return single_open(f, mt76x02_ampdu_stat_read, inode->i_private);
-}
+DEFINE_SHOW_ATTRIBUTE(mt76x02_ampdu_stat);
 
 static int read_txpower(struct seq_file *file, void *data)
 {
@@ -48,15 +44,8 @@ static int read_txpower(struct seq_file *file, void *data)
 	return 0;
 }
 
-static const struct file_operations fops_ampdu_stat = {
-	.open = mt76x02_ampdu_stat_open,
-	.read_iter = seq_read_iter,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
 static int
-mt76x02_dfs_stat_read(struct seq_file *file, void *data)
+mt76x02_dfs_stat_show(struct seq_file *file, void *data)
 {
 	struct mt76x02_dev *dev = file->private;
 	struct mt76x02_dfs_pattern_detector *dfs_pd = &dev->dfs_pd;
@@ -81,18 +70,7 @@ mt76x02_dfs_stat_read(struct seq_file *file, void *data)
 	return 0;
 }
 
-static int
-mt76x02_dfs_stat_open(struct inode *inode, struct file *f)
-{
-	return single_open(f, mt76x02_dfs_stat_read, inode->i_private);
-}
-
-static const struct file_operations fops_dfs_stat = {
-	.open = mt76x02_dfs_stat_open,
-	.read_iter = seq_read_iter,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mt76x02_dfs_stat);
 
 static int read_agc(struct seq_file *file, void *data)
 {
@@ -150,8 +128,8 @@ void mt76x02_init_debugfs(struct mt76x02_dev *dev)
 	debugfs_create_bool("tpc", 0600, dir, &dev->enable_tpc);
 
 	debugfs_create_file("edcca", 0600, dir, dev, &fops_edcca);
-	debugfs_create_file("ampdu_stat", 0400, dir, dev, &fops_ampdu_stat);
-	debugfs_create_file("dfs_stats", 0400, dir, dev, &fops_dfs_stat);
+	debugfs_create_file("ampdu_stat", 0400, dir, dev, &mt76x02_ampdu_stat_fops);
+	debugfs_create_file("dfs_stats", 0400, dir, dev, &mt76x02_dfs_stat_fops);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "txpower", dir,
 				    read_txpower);
 
-- 
2.17.1

