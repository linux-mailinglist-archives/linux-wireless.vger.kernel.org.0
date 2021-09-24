Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A876C416F78
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 11:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245349AbhIXJup (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 05:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245346AbhIXJuc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 05:50:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC34B61050;
        Fri, 24 Sep 2021 09:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632476939;
        bh=ZhehrnQoou+8oWgj/d+aD49ZLDbqvXb1+pKlXeSLUAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DEmhVDq8coZEWF/mlrkG3mrCch87zwPdMSjEeGT4TzjF6y4RDOx7RLa0UzG1Fiiu9
         0ZvxKNvYwkku9LdfwC6tDsp/5KRZsDBgxy+htu3wcIK88BskAxD4i9mmwy+DXH34ha
         fqKx5eJUzq+fC5YxVdhncB6o8VMBktoqqjvXv3gNoDmIwAmoDLRkDiwNTasZfS0H1F
         scJygXfPL0Wn6RTdSkPhC/tafXWloP1Y0ul6vY153ZbVVDvW65vtKWn6lo/kFaf4Qt
         zerNcOGfG3qFceILqmFB6oVphwOc0hJ80i0xPkAsK5j1TjwgC7SPBGuiPtxCJnYdw3
         UYZg//G8Bz+hA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
Subject: [PATCH 2/2] mt76: mt7915: introduce mt76 debugfs sub-dir for ext-phy
Date:   Fri, 24 Sep 2021 11:48:19 +0200
Message-Id: <27ea51697859cb0b53bc49c701abb4bf058e55db.1632476677.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632476677.git.lorenzo@kernel.org>
References: <cover.1632476677.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce a dedicated mt76 debugfs sub-dir for ext-phy in dbdc mode.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 63 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  6 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
 3 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index e1cdfbe52199..2fee64687381 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -113,7 +113,7 @@ static void
 mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 			   struct seq_file *file)
 {
-	struct mt7915_dev *dev = file->private;
+	struct mt7915_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
 	int bound[15], range[4], i, n;
 
@@ -146,7 +146,7 @@ mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 static void
 mt7915_txbf_stat_read_phy(struct mt7915_phy *phy, struct seq_file *s)
 {
-	struct mt7915_dev *dev = s->private;
+	struct mt7915_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
 	static const char * const bw[] = {
 		"BW20", "BW40", "BW80", "BW160"
@@ -203,14 +203,12 @@ mt7915_txbf_stat_read_phy(struct mt7915_phy *phy, struct seq_file *s)
 static int
 mt7915_tx_stats_show(struct seq_file *file, void *data)
 {
-	struct mt7915_dev *dev = file->private;
+	struct mt7915_phy *phy = file->private;
+	struct mt7915_dev *dev = phy->dev;
 	int stat[8], i, n;
 
-	mt7915_ampdu_stat_read_phy(&dev->phy, file);
-	mt7915_txbf_stat_read_phy(&dev->phy, file);
-
-	mt7915_ampdu_stat_read_phy(mt7915_ext_phy(dev), file);
-	mt7915_txbf_stat_read_phy(mt7915_ext_phy(dev), file);
+	mt7915_ampdu_stat_read_phy(phy, file);
+	mt7915_txbf_stat_read_phy(phy, file);
 
 	/* Tx amsdu info */
 	seq_puts(file, "Tx MSDU statistics:\n");
@@ -262,18 +260,15 @@ mt7915_queues_acq(struct seq_file *s, void *data)
 }
 
 static int
-mt7915_queues_read(struct seq_file *s, void *data)
+mt7915_queues_show(struct seq_file *file, void *data)
 {
-	struct mt7915_dev *dev = dev_get_drvdata(s->private);
-	struct mt76_phy *mphy_ext = dev->mt76.phy2;
-	struct mt76_queue *ext_q = mphy_ext ? mphy_ext->q_tx[MT_TXQ_BE] : NULL;
+	struct mt7915_phy *phy = file->private;
+	struct mt7915_dev *dev = phy->dev;
 	struct {
 		struct mt76_queue *q;
 		char *queue;
 	} queue_map[] = {
-		{ dev->mphy.q_tx[MT_TXQ_BE],	 "WFDMA0" },
-		{ ext_q,			 "WFDMA1" },
-		{ dev->mphy.q_tx[MT_TXQ_BE],	 "WFDMA0" },
+		{ phy->mt76->q_tx[MT_TXQ_BE],	 "WFDMA"  },
 		{ dev->mt76.q_mcu[MT_MCUQ_WM],	 "MCUWM"  },
 		{ dev->mt76.q_mcu[MT_MCUQ_WA],	 "MCUWA"  },
 		{ dev->mt76.q_mcu[MT_MCUQ_FWDL], "MCUFWQ" },
@@ -286,7 +281,7 @@ mt7915_queues_read(struct seq_file *s, void *data)
 		if (!q)
 			continue;
 
-		seq_printf(s,
+		seq_printf(file,
 			   "%s:	queued=%d head=%d tail=%d\n",
 			   queue_map[i].queue, q->queued, q->head,
 			   q->tail);
@@ -295,6 +290,8 @@ mt7915_queues_read(struct seq_file *s, void *data)
 	return 0;
 }
 
+DEFINE_SHOW_ATTRIBUTE(mt7915_queues);
+
 static void
 mt7915_puts_rate_txpower(struct seq_file *s, struct mt7915_phy *phy)
 {
@@ -325,39 +322,43 @@ mt7915_puts_rate_txpower(struct seq_file *s, struct mt7915_phy *phy)
 }
 
 static int
-mt7915_read_rate_txpower(struct seq_file *s, void *data)
+mt7915_rate_txpower_show(struct seq_file *file, void *data)
 {
-	struct mt7915_dev *dev = dev_get_drvdata(s->private);
+	struct mt7915_phy *phy = file->private;
 
-	mt7915_puts_rate_txpower(s, &dev->phy);
-	mt7915_puts_rate_txpower(s, mt7915_ext_phy(dev));
+	mt7915_puts_rate_txpower(file, phy);
 
 	return 0;
 }
 
-int mt7915_init_debugfs(struct mt7915_dev *dev)
+DEFINE_SHOW_ATTRIBUTE(mt7915_rate_txpower);
+
+int mt7915_init_debugfs(struct mt7915_phy *phy)
 {
+	struct mt7915_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
 	struct dentry *dir;
 
-	dir = mt76_register_debugfs(&dev->mt76);
+	dir = mt76_register_debugfs_fops(phy->mt76, NULL);
 	if (!dir)
 		return -ENOMEM;
 
-	debugfs_create_devm_seqfile(dev->mt76.dev, "queues", dir,
-				    mt7915_queues_read);
+	debugfs_create_file("xmit-queues", 0400, dir, phy, &mt7915_queues_fops);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "acq", dir,
 				    mt7915_queues_acq);
-	debugfs_create_file("tx_stats", 0400, dir, dev, &mt7915_tx_stats_fops);
+	debugfs_create_file("tx_stats", 0400, dir, phy, &mt7915_tx_stats_fops);
 	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
 	debugfs_create_file("implicit_txbf", 0600, dir, dev,
 			    &fops_implicit_txbf);
-	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
-	/* test knobs */
-	debugfs_create_file("radar_trigger", 0200, dir, dev,
-			    &fops_radar_trigger);
+	debugfs_create_file("txpower_sku", 0400, dir, phy,
+			    &mt7915_rate_txpower_fops);
+	if (!dev->dbdc_support || ext_phy) {
+		debugfs_create_u32("dfs_hw_pattern", 0400, dir,
+				   &dev->hw_pattern);
+		debugfs_create_file("radar_trigger", 0200, dir, dev,
+				    &fops_radar_trigger);
+	}
 	debugfs_create_file("ser_trigger", 0200, dir, dev, &fops_ser_trigger);
-	debugfs_create_devm_seqfile(dev->mt76.dev, "txpower_sku", dir,
-				    mt7915_read_rate_txpower);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ba41ed38a4c5..dc0f5bf53e4d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -407,6 +407,10 @@ static int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	if (ret)
 		goto error;
 
+	ret = mt7915_init_debugfs(phy);
+	if (ret)
+		goto error;
+
 	return 0;
 
 error:
@@ -862,7 +866,7 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	return mt7915_init_debugfs(dev);
+	return mt7915_init_debugfs(&dev->phy);
 }
 
 void mt7915_unregister_device(struct mt7915_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index ab8fc27646e0..d3e1f2fdb8ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -414,7 +414,7 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy);
 void mt7915_set_stream_he_caps(struct mt7915_phy *phy);
 void mt7915_set_stream_vht_txbf_caps(struct mt7915_phy *phy);
 void mt7915_update_channel(struct mt76_phy *mphy);
-int mt7915_init_debugfs(struct mt7915_dev *dev);
+int mt7915_init_debugfs(struct mt7915_phy *phy);
 #ifdef CONFIG_MAC80211_DEBUGFS
 void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, struct dentry *dir);
-- 
2.31.1

