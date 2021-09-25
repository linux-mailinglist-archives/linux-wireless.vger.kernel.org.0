Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9B9418102
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Sep 2021 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244397AbhIYK3A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Sep 2021 06:29:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234922AbhIYK27 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Sep 2021 06:28:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70D2A610EA;
        Sat, 25 Sep 2021 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632565645;
        bh=7S7JBI2YgmpIXgm7y7A8SFNMyXYOtSj94s4tqb0KwAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYt0g9JBVSp6ZwC8VdUSkXfqpu65cYj6Yp1L6C/H7iO2a4QFQHq0WoWLwJ/jrCHlL
         YxiNXOLbaPAycb01O015ny+YGp8vd3yqkm8/9rcC+P0LMiLXvQh5YBtVxXmbod9s2p
         4sIkPcFunQUMp8SdSARJCFIM86da8/rg4334OB4dfH2GDIZ1BhXvWug3BWIzbEQa42
         zINbTBuZH80IurYjLyE+M1itIdbWBBVM9LfU6O9SLkOhPW2o+ECobH4TbYJcqUAN+m
         9HV/LFWd1QDlpdLwsQe26JSGcsh+USisa6Q0hQP8WY3XxXhVCHDzsntZkmg3YfIJPu
         sTz/duxpD9fbQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v2 2/2] mt76: mt7915: introduce mt76 debugfs sub-dir for ext-phy
Date:   Sat, 25 Sep 2021 12:26:58 +0200
Message-Id: <8121e7971473c8a9e9236c52f9f7f1fe91f193df.1632565435.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632565435.git.lorenzo@kernel.org>
References: <cover.1632565435.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce a dedicated mt76 debugfs sub-dir for ext-phy in dbdc mode.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 159 +++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   6 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   2 +-
 3 files changed, 87 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index bd314755fd23..f2fefd180391 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -120,7 +120,7 @@ static void
 mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 			   struct seq_file *file)
 {
-	struct mt7915_dev *dev = file->private;
+	struct mt7915_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
 	int bound[15], range[4], i, n;
 
@@ -153,7 +153,7 @@ mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 static void
 mt7915_txbf_stat_read_phy(struct mt7915_phy *phy, struct seq_file *s)
 {
-	struct mt7915_dev *dev = s->private;
+	struct mt7915_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
 	static const char * const bw[] = {
 		"BW20", "BW40", "BW80", "BW160"
@@ -210,14 +210,12 @@ mt7915_txbf_stat_read_phy(struct mt7915_phy *phy, struct seq_file *s)
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
@@ -244,7 +242,8 @@ static void
 mt7915_hw_queue_read(struct seq_file *s, u32 base, u32 size,
 		     const struct hw_queue_map *map)
 {
-	struct mt7915_dev *dev = dev_get_drvdata(s->private);
+	struct mt7915_phy *phy = s->private;
+	struct mt7915_dev *dev = phy->dev;
 	u32 i, val;
 
 	val = mt76_rr(dev, base + MT_FL_Q_EMPTY);
@@ -299,40 +298,40 @@ mt7915_sta_hw_queue_read(void *data, struct ieee80211_sta *sta)
 }
 
 static int
-mt7915_hw_queues_read(struct seq_file *s, void *data)
+mt7915_hw_queues_show(struct seq_file *file, void *data)
 {
-	struct mt7915_dev *dev = dev_get_drvdata(s->private);
-	struct mt7915_phy *phy = mt7915_ext_phy(dev);
+	struct mt7915_phy *phy = file->private;
+	struct mt7915_dev *dev = phy->dev;
 	static const struct hw_queue_map ple_queue_map[] = {
-		{"CPU_Q0",  0,  1, MT_CTX0},
-		{"CPU_Q1",  1,  1, MT_CTX0 + 1},
-		{"CPU_Q2",  2,  1, MT_CTX0 + 2},
-		{"CPU_Q3",  3,  1, MT_CTX0 + 3},
-		{"ALTX_Q0", 8,  2, MT_LMAC_ALTX0},
-		{"BMC_Q0",  9,  2, MT_LMAC_BMC0},
-		{"BCN_Q0",  10, 2, MT_LMAC_BCN0},
-		{"PSMP_Q0", 11, 2, MT_LMAC_PSMP0},
-		{"ALTX_Q1", 12, 2, MT_LMAC_ALTX0 + 4},
-		{"BMC_Q1",  13, 2, MT_LMAC_BMC0 + 4},
-		{"BCN_Q1",  14, 2, MT_LMAC_BCN0 + 4},
-		{"PSMP_Q1", 15, 2, MT_LMAC_PSMP0 + 4},
+		{ "CPU_Q0",  0,  1, MT_CTX0	      },
+		{ "CPU_Q1",  1,  1, MT_CTX0 + 1	      },
+		{ "CPU_Q2",  2,  1, MT_CTX0 + 2	      },
+		{ "CPU_Q3",  3,  1, MT_CTX0 + 3	      },
+		{ "ALTX_Q0", 8,  2, MT_LMAC_ALTX0     },
+		{ "BMC_Q0",  9,  2, MT_LMAC_BMC0      },
+		{ "BCN_Q0",  10, 2, MT_LMAC_BCN0      },
+		{ "PSMP_Q0", 11, 2, MT_LMAC_PSMP0     },
+		{ "ALTX_Q1", 12, 2, MT_LMAC_ALTX0 + 4 },
+		{ "BMC_Q1",  13, 2, MT_LMAC_BMC0  + 4 },
+		{ "BCN_Q1",  14, 2, MT_LMAC_BCN0  + 4 },
+		{ "PSMP_Q1", 15, 2, MT_LMAC_PSMP0 + 4 },
 	};
 	static const struct hw_queue_map pse_queue_map[] = {
-		{"CPU Q0",  0,  1, MT_CTX0},
-		{"CPU Q1",  1,  1, MT_CTX0 + 1},
-		{"CPU Q2",  2,  1, MT_CTX0 + 2},
-		{"CPU Q3",  3,  1, MT_CTX0 + 3},
-		{"HIF_Q0",  8,  0, MT_HIF0},
-		{"HIF_Q1",  9,  0, MT_HIF0 + 1},
-		{"HIF_Q2",  10, 0, MT_HIF0 + 2},
-		{"HIF_Q3",  11, 0, MT_HIF0 + 3},
-		{"HIF_Q4",  12, 0, MT_HIF0 + 4},
-		{"HIF_Q5",  13, 0, MT_HIF0 + 5},
-		{"LMAC_Q",  16, 2, 0},
-		{"MDP_TXQ", 17, 2, 1},
-		{"MDP_RXQ", 18, 2, 2},
-		{"SEC_TXQ", 19, 2, 3},
-		{"SEC_RXQ", 20, 2, 4},
+		{ "CPU Q0",  0,  1, MT_CTX0	      },
+		{ "CPU Q1",  1,  1, MT_CTX0 + 1	      },
+		{ "CPU Q2",  2,  1, MT_CTX0 + 2	      },
+		{ "CPU Q3",  3,  1, MT_CTX0 + 3	      },
+		{ "HIF_Q0",  8,  0, MT_HIF0	      },
+		{ "HIF_Q1",  9,  0, MT_HIF0 + 1	      },
+		{ "HIF_Q2",  10, 0, MT_HIF0 + 2	      },
+		{ "HIF_Q3",  11, 0, MT_HIF0 + 3	      },
+		{ "HIF_Q4",  12, 0, MT_HIF0 + 4	      },
+		{ "HIF_Q5",  13, 0, MT_HIF0 + 5	      },
+		{ "LMAC_Q",  16, 2, 0		      },
+		{ "MDP_TXQ", 17, 2, 1		      },
+		{ "MDP_RXQ", 18, 2, 2		      },
+		{ "SEC_TXQ", 19, 2, 3		      },
+		{ "SEC_RXQ", 20, 2, 4		      },
 	};
 	u32 val, head, tail;
 
@@ -340,49 +339,46 @@ mt7915_hw_queues_read(struct seq_file *s, void *data)
 	val = mt76_rr(dev, MT_PLE_FREEPG_CNT);
 	head = mt76_get_field(dev, MT_PLE_FREEPG_HEAD_TAIL, GENMASK(11, 0));
 	tail = mt76_get_field(dev, MT_PLE_FREEPG_HEAD_TAIL, GENMASK(27, 16));
-	seq_puts(s, "PLE page info:\n");
-	seq_printf(s, "\tTotal free page: 0x%08x head: 0x%03x tail: 0x%03x\n",
+	seq_puts(file, "PLE page info:\n");
+	seq_printf(file,
+		   "\tTotal free page: 0x%08x head: 0x%03x tail: 0x%03x\n",
 		   val, head, tail);
 
 	val = mt76_rr(dev, MT_PLE_PG_HIF_GROUP);
 	head = mt76_get_field(dev, MT_PLE_HIF_PG_INFO, GENMASK(11, 0));
 	tail = mt76_get_field(dev, MT_PLE_HIF_PG_INFO, GENMASK(27, 16));
-	seq_printf(s, "\tHIF free page: 0x%03x res: 0x%03x used: 0x%03x\n",
+	seq_printf(file, "\tHIF free page: 0x%03x res: 0x%03x used: 0x%03x\n",
 		   val, head, tail);
 
-	seq_puts(s, "PLE non-empty queue info:\n");
-	mt7915_hw_queue_read(s, MT_PLE_BASE, ARRAY_SIZE(ple_queue_map),
+	seq_puts(file, "PLE non-empty queue info:\n");
+	mt7915_hw_queue_read(file, MT_PLE_BASE, ARRAY_SIZE(ple_queue_map),
 			     &ple_queue_map[0]);
 
 	/* iterate per-sta ple queue */
-	ieee80211_iterate_stations_atomic(dev->mphy.hw,
-					  mt7915_sta_hw_queue_read, s);
-	if (phy)
-		ieee80211_iterate_stations_atomic(phy->mt76->hw,
-						  mt7915_sta_hw_queue_read, s);
-
+	ieee80211_iterate_stations_atomic(phy->mt76->hw,
+					  mt7915_sta_hw_queue_read, file);
 	/* pse queue */
-	seq_puts(s, "PSE non-empty queue info:\n");
-	mt7915_hw_queue_read(s, MT_PSE_BASE, ARRAY_SIZE(pse_queue_map),
+	seq_puts(file, "PSE non-empty queue info:\n");
+	mt7915_hw_queue_read(file, MT_PSE_BASE, ARRAY_SIZE(pse_queue_map),
 			     &pse_queue_map[0]);
 
 	return 0;
 }
 
+DEFINE_SHOW_ATTRIBUTE(mt7915_hw_queues);
+
 static int
-mt7915_queues_read(struct seq_file *s, void *data)
+mt7915_xmit_queues_show(struct seq_file *file, void *data)
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
-		{ dev->mphy.q_tx[MT_TXQ_BE],	 "MAIN" },
-		{ ext_q,			 "EXT" },
-		{ dev->mt76.q_mcu[MT_MCUQ_WM],	 "MCUWM"  },
-		{ dev->mt76.q_mcu[MT_MCUQ_WA],	 "MCUWA"  },
+		{ phy->mt76->q_tx[MT_TXQ_BE],	 "   MAIN"  },
+		{ dev->mt76.q_mcu[MT_MCUQ_WM],	 "  MCUWM"  },
+		{ dev->mt76.q_mcu[MT_MCUQ_WA],	 "  MCUWA"  },
 		{ dev->mt76.q_mcu[MT_MCUQ_FWDL], "MCUFWDL" },
 	};
 	int i;
@@ -393,7 +389,7 @@ mt7915_queues_read(struct seq_file *s, void *data)
 		if (!q)
 			continue;
 
-		seq_printf(s,
+		seq_printf(file,
 			   "%s:	queued=%d head=%d tail=%d\n",
 			   queue_map[i].queue, q->queued, q->head,
 			   q->tail);
@@ -402,6 +398,8 @@ mt7915_queues_read(struct seq_file *s, void *data)
 	return 0;
 }
 
+DEFINE_SHOW_ATTRIBUTE(mt7915_xmit_queues);
+
 static void
 mt7915_puts_rate_txpower(struct seq_file *s, struct mt7915_phy *phy)
 {
@@ -432,16 +430,17 @@ mt7915_puts_rate_txpower(struct seq_file *s, struct mt7915_phy *phy)
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
 
+DEFINE_SHOW_ATTRIBUTE(mt7915_rate_txpower);
+
 static int
 mt7915_twt_stats(struct seq_file *s, void *data)
 {
@@ -468,31 +467,35 @@ mt7915_twt_stats(struct seq_file *s, void *data)
 	return 0;
 }
 
-int mt7915_init_debugfs(struct mt7915_dev *dev)
+int mt7915_init_debugfs(struct mt7915_phy *phy)
 {
+	struct mt7915_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
 	struct dentry *dir;
 
-	dir = mt76_register_debugfs(&dev->mt76);
+	dir = mt76_register_debugfs_fops(phy->mt76, NULL);
 	if (!dir)
 		return -ENOMEM;
 
-	debugfs_create_devm_seqfile(dev->mt76.dev, "tx-queues", dir,
-				    mt7915_queues_read);
-	debugfs_create_devm_seqfile(dev->mt76.dev, "hw-queues", dir,
-				    mt7915_hw_queues_read);
-	debugfs_create_file("tx_stats", 0400, dir, dev, &mt7915_tx_stats_fops);
+	debugfs_create_file("hw-queues", 0400, dir, phy,
+			    &mt7915_hw_queues_fops);
+	debugfs_create_file("xmit-queues", 0400, dir, phy,
+			    &mt7915_xmit_queues_fops);
+	debugfs_create_file("tx_stats", 0400, dir, phy, &mt7915_tx_stats_fops);
 	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
 	debugfs_create_file("implicit_txbf", 0600, dir, dev,
 			    &fops_implicit_txbf);
-	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
+	debugfs_create_file("txpower_sku", 0400, dir, phy,
+			    &mt7915_rate_txpower_fops);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "twt_stats", dir,
 				    mt7915_twt_stats);
-	/* test knobs */
-	debugfs_create_file("radar_trigger", 0200, dir, dev,
-			    &fops_radar_trigger);
 	debugfs_create_file("ser_trigger", 0200, dir, dev, &fops_ser_trigger);
-	debugfs_create_devm_seqfile(dev->mt76.dev, "txpower_sku", dir,
-				    mt7915_read_rate_txpower);
+	if (!dev->dbdc_support || ext_phy) {
+		debugfs_create_u32("dfs_hw_pattern", 0400, dir,
+				   &dev->hw_pattern);
+		debugfs_create_file("radar_trigger", 0200, dir, dev,
+				    &fops_radar_trigger);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 802bd9d485be..8c42a1668013 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -477,6 +477,10 @@ static int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	if (ret)
 		goto error;
 
+	ret = mt7915_init_debugfs(phy);
+	if (ret)
+		goto error;
+
 	return 0;
 
 error:
@@ -949,7 +953,7 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	return mt7915_init_debugfs(dev);
+	return mt7915_init_debugfs(&dev->phy);
 }
 
 void mt7915_unregister_device(struct mt7915_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 78a015e15f08..0cd09767455a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -458,7 +458,7 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy);
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

