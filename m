Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF3E6170AC
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 23:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiKBW3k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 18:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiKBW3j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 18:29:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C6B65B5
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 15:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2E769CE240E
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 22:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1C6C433C1;
        Wed,  2 Nov 2022 22:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667428173;
        bh=GxbAxaiKNTziQqkmHhGjxeWwH/qinr5GV9/QmTWXp2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u6Itwf5c4NNADOY23CyxBqSs9CdD0cq2UtKjRK0m4ZTcHTtOjPZIeCdM0Mrim3wnI
         mp6nGoRdBbBTh3oBda+YE7n1JvKeRFG5oHwJqFhKtEpTPpDOx5FwhRtY92D5/XGjs0
         oCow1A/sMxs9n5M8ecAVxoJSOckAdlIMjyKHvXXoisd6WgEjg5/aSNVTRZTwnh4QQ9
         r1DO4YjVenB392CAgxV6YKnj4pr3LSkxDYFpHlMuwyKQfuLZnk4UL5ivxTTJtQ6+vU
         OI0pcQwaD+53iMbYOTE8f0ksKbjNuJ8uSQqzwtv11HFsGmYNPm8cnvhhSxj+SHTwFI
         rqxXDNaIRqhIg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 2/2] wifi: mt76: move aggr_stats array in mt76_phy
Date:   Wed,  2 Nov 2022 23:29:15 +0100
Message-Id: <9968f74a1667b58ad666a5508b99c290a4c6e40c.1667427944.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667427944.git.lorenzo@kernel.org>
References: <cover.1667427944.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move aggregation stats array per-phy instead of share it between multiple
interfaces. This is a preliminary patch to add mt7996 driver support.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 ++--
 .../wireless/mediatek/mt76/mt7603/debugfs.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  6 +++---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  6 ++----
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  9 ++++----
 .../wireless/mediatek/mt76/mt76x02_debugfs.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  6 +++---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  5 ++---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 21 +++++++------------
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  5 ++---
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 10 ++++-----
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  2 +-
 13 files changed, 35 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index f9bdf16fc6c4..bfe97aa7e06e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -693,6 +693,8 @@ struct mt76_phy {
 	enum mt76_dfs_state dfs_state;
 	ktime_t survey_time;
 
+	u32 aggr_stats[32];
+
 	struct mt76_hw_cap cap;
 	struct mt76_sband sband_2g;
 	struct mt76_sband sband_5g;
@@ -781,8 +783,6 @@ struct mt76_dev {
 
 	u32 rev;
 
-	u32 aggr_stats[32];
-
 	struct tasklet_struct pre_tbtt_tasklet;
 	int beacon_int;
 	u8 beacon_mask;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
index f52165dff422..3967f2f05774 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
@@ -85,7 +85,7 @@ mt7603_ampdu_stat_show(struct seq_file *file, void *data)
 			   bound[i], bound[i + 1]);
 	seq_puts(file, "\nCount:  ");
 	for (i = 0; i < ARRAY_SIZE(bound); i++)
-		seq_printf(file, "%8d | ", dev->mt76.aggr_stats[i]);
+		seq_printf(file, "%8d | ", dev->mphy.aggr_stats[i]);
 	seq_puts(file, "\n");
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 49a511ae8161..70a7f84af028 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -39,7 +39,7 @@ void mt7603_mac_reset_counters(struct mt7603_dev *dev)
 	for (i = 0; i < 2; i++)
 		mt76_rr(dev, MT_TX_AGG_CNT(i));
 
-	memset(dev->mt76.aggr_stats, 0, sizeof(dev->mt76.aggr_stats));
+	memset(dev->mphy.aggr_stats, 0, sizeof(dev->mphy.aggr_stats));
 }
 
 void mt7603_mac_set_timing(struct mt7603_dev *dev)
@@ -1827,8 +1827,8 @@ void mt7603_mac_work(struct work_struct *work)
 	for (i = 0, idx = 0; i < 2; i++) {
 		u32 val = mt76_rr(dev, MT_TX_AGG_CNT(i));
 
-		dev->mt76.aggr_stats[idx++] += val & 0xffff;
-		dev->mt76.aggr_stats[idx++] += val >> 16;
+		dev->mphy.aggr_stats[idx++] += val & 0xffff;
+		dev->mphy.aggr_stats[idx++] += val >> 16;
 	}
 
 	if (dev->mphy.mac_work_count == 10)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index c26b45a09923..2a6d317db5e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -278,7 +278,6 @@ mt7615_ampdu_stat_read_phy(struct mt7615_phy *phy,
 {
 	struct mt7615_dev *dev = file->private;
 	u32 reg = is_mt7663(&dev->mt76) ? MT_MIB_ARNG(0) : MT_AGG_ASRCR0;
-	bool ext_phy = phy != &dev->phy;
 	int bound[7], i, range;
 
 	if (!phy)
@@ -292,7 +291,7 @@ mt7615_ampdu_stat_read_phy(struct mt7615_phy *phy,
 	for (i = 0; i < 3; i++)
 		bound[i + 4] = MT_AGG_ASRCR_RANGE(range, i) + 1;
 
-	seq_printf(file, "\nPhy %d\n", ext_phy);
+	seq_printf(file, "\nPhy %d\n", phy != &dev->phy);
 
 	seq_printf(file, "Length: %8d | ", bound[0]);
 	for (i = 0; i < ARRAY_SIZE(bound) - 1; i++)
@@ -300,9 +299,8 @@ mt7615_ampdu_stat_read_phy(struct mt7615_phy *phy,
 			   bound[i], bound[i + 1]);
 	seq_puts(file, "\nCount:  ");
 
-	range = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	for (i = 0; i < ARRAY_SIZE(bound); i++)
-		seq_printf(file, "%8d | ", dev->mt76.aggr_stats[i + range]);
+		seq_printf(file, "%8d | ", phy->mt76->aggr_stats[i]);
 	seq_puts(file, "\n");
 
 	seq_printf(file, "BA miss count: %d\n", phy->mib.ba_miss_cnt);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 7bda801581ea..491dbffd9481 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -117,7 +117,7 @@ void mt7615_mac_reset_counters(struct mt7615_phy *phy)
 		mt76_rr(dev, MT_TX_AGG_CNT(1, i));
 	}
 
-	memset(dev->mt76.aggr_stats, 0, sizeof(dev->mt76.aggr_stats));
+	memset(phy->mt76->aggr_stats, 0, sizeof(phy->mt76->aggr_stats));
 	phy->mt76->survey_time = ktime_get_boottime();
 
 	/* reset airtime counters */
@@ -1997,7 +1997,7 @@ mt7615_mac_update_mib_stats(struct mt7615_phy *phy)
 	struct mt7615_dev *dev = phy->dev;
 	struct mib_stats *mib = &phy->mib;
 	bool ext_phy = phy != &dev->phy;
-	int i, aggr;
+	int i, aggr = 0;
 	u32 val, val2;
 
 	mib->fcs_err_cnt += mt76_get_field(dev, MT_MIB_SDR3(ext_phy),
@@ -2011,7 +2011,6 @@ mt7615_mac_update_mib_stats(struct mt7615_phy *phy)
 		mib->aggr_per = 1000 * (val - val2) / val;
 	}
 
-	aggr = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	for (i = 0; i < 4; i++) {
 		val = mt76_rr(dev, MT_MIB_MB_SDR1(ext_phy, i));
 		mib->ba_miss_cnt += FIELD_GET(MT_MIB_BA_MISS_COUNT_MASK, val);
@@ -2024,8 +2023,8 @@ mt7615_mac_update_mib_stats(struct mt7615_phy *phy)
 						  val);
 
 		val = mt76_rr(dev, MT_TX_AGG_CNT(ext_phy, i));
-		dev->mt76.aggr_stats[aggr++] += val & 0xffff;
-		dev->mt76.aggr_stats[aggr++] += val >> 16;
+		phy->mt76->aggr_stats[aggr++] += val & 0xffff;
+		phy->mt76->aggr_stats[aggr++] += val >> 16;
 	}
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
index 981ac8e84807..8ce4bf44733d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
@@ -20,7 +20,7 @@ mt76x02_ampdu_stat_show(struct seq_file *file, void *data)
 		seq_puts(file, "Count:  ");
 		for (j = 0; j < 8; j++)
 			seq_printf(file, "%8d | ",
-				   dev->mt76.aggr_stats[i * 8 + j]);
+				   dev->mphy.aggr_stats[i * 8 + j]);
 		seq_puts(file, "\n");
 		seq_puts(file, "--------");
 		for (j = 0; j < 8; j++)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 93d96739f802..d3f74473e6fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -25,7 +25,7 @@ void mt76x02_mac_reset_counters(struct mt76x02_dev *dev)
 	for (i = 0; i < 16; i++)
 		mt76_rr(dev, MT_TX_STAT_FIFO);
 
-	memset(dev->mt76.aggr_stats, 0, sizeof(dev->mt76.aggr_stats));
+	memset(dev->mphy.aggr_stats, 0, sizeof(dev->mphy.aggr_stats));
 }
 EXPORT_SYMBOL_GPL(mt76x02_mac_reset_counters);
 
@@ -1191,8 +1191,8 @@ void mt76x02_mac_work(struct work_struct *work)
 	for (i = 0, idx = 0; i < 16; i++) {
 		u32 val = mt76_rr(dev, MT_TX_AGG_CNT(i));
 
-		dev->mt76.aggr_stats[idx++] += val & 0xffff;
-		dev->mt76.aggr_stats[idx++] += val >> 16;
+		dev->mphy.aggr_stats[idx++] += val & 0xffff;
+		dev->mphy.aggr_stats[idx++] += val >> 16;
 	}
 
 	mt76x02_check_mac_err(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index e1d15394a621..cd774c1bc49f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -639,7 +639,7 @@ mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 {
 	struct mt7915_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
-	int bound[15], range[4], i, n;
+	int bound[15], range[4], i;
 
 	/* Tx ampdu stat */
 	for (i = 0; i < ARRAY_SIZE(range); i++)
@@ -656,9 +656,8 @@ mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 			   bound[i] + 1, bound[i + 1]);
 
 	seq_puts(file, "\nCount:  ");
-	n = phy->band_idx ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	for (i = 0; i < ARRAY_SIZE(bound); i++)
-		seq_printf(file, "%8d | ", dev->mt76.aggr_stats[i + n]);
+		seq_printf(file, "%8d | ", phy->mt76->aggr_stats[i]);
 	seq_puts(file, "\n");
 
 	seq_printf(file, "BA miss count: %d\n", phy->mib.ba_miss_cnt);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 830a8e3b7196..d3a73a612923 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1129,12 +1129,8 @@ void mt7915_mac_reset_counters(struct mt7915_phy *phy)
 		mt76_rr(dev, MT_TX_AGG_CNT2(phy->band_idx, i));
 	}
 
-	i = 0;
 	phy->mt76->survey_time = ktime_get_boottime();
-	if (phy->band_idx)
-		i = ARRAY_SIZE(dev->mt76.aggr_stats) / 2;
-
-	memset(&dev->mt76.aggr_stats[i], 0, sizeof(dev->mt76.aggr_stats) / 2);
+	memset(phy->mt76->aggr_stats, 0, sizeof(phy->mt76->aggr_stats));
 
 	/* reset airtime counters */
 	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(phy->band_idx),
@@ -1477,7 +1473,7 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
 	struct mib_stats *mib = &phy->mib;
-	int i, aggr0, aggr1, cnt;
+	int i, aggr0 = 0, aggr1, cnt;
 	u32 val;
 
 	cnt = mt76_rr(dev, MT_MIB_SDR3(phy->band_idx));
@@ -1609,7 +1605,6 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 		mib->tx_amsdu_cnt += cnt;
 	}
 
-	aggr0 = phy->band_idx ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	if (is_mt7915(&dev->mt76)) {
 		for (i = 0, aggr1 = aggr0 + 8; i < 4; i++) {
 			val = mt76_rr(dev, MT_MIB_MB_SDR1(phy->band_idx, (i << 4)));
@@ -1624,12 +1619,12 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 				FIELD_GET(MT_MIB_RTS_RETRIES_COUNT_MASK, val);
 
 			val = mt76_rr(dev, MT_TX_AGG_CNT(phy->band_idx, i));
-			dev->mt76.aggr_stats[aggr0++] += val & 0xffff;
-			dev->mt76.aggr_stats[aggr0++] += val >> 16;
+			phy->mt76->aggr_stats[aggr0++] += val & 0xffff;
+			phy->mt76->aggr_stats[aggr0++] += val >> 16;
 
 			val = mt76_rr(dev, MT_TX_AGG_CNT2(phy->band_idx, i));
-			dev->mt76.aggr_stats[aggr1++] += val & 0xffff;
-			dev->mt76.aggr_stats[aggr1++] += val >> 16;
+			phy->mt76->aggr_stats[aggr1++] += val & 0xffff;
+			phy->mt76->aggr_stats[aggr1++] += val >> 16;
 		}
 
 		cnt = mt76_rr(dev, MT_MIB_SDR32(phy->band_idx));
@@ -1676,8 +1671,8 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 
 		for (i = 0; i < 8; i++) {
 			val = mt76_rr(dev, MT_TX_AGG_CNT(phy->band_idx, i));
-			dev->mt76.aggr_stats[aggr0++] += FIELD_GET(GENMASK(15, 0), val);
-			dev->mt76.aggr_stats[aggr0++] += FIELD_GET(GENMASK(31, 16), val);
+			phy->mt76->aggr_stats[aggr0++] += FIELD_GET(GENMASK(15, 0), val);
+			phy->mt76->aggr_stats[aggr0++] += FIELD_GET(GENMASK(31, 16), val);
 		}
 
 		cnt = mt76_rr(dev, MT_MIB_SDR32(phy->band_idx));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 6de49b93387e..6c604c818974 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1256,7 +1256,7 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	};
 	struct mib_stats *mib = &phy->mib;
 	/* See mt7915_ampdu_stat_read_phy, etc */
-	int i, n, ei = 0;
+	int i, ei = 0;
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -1272,9 +1272,8 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	data[ei++] = mib->tx_pkt_ibf_cnt;
 
 	/* Tx ampdu stat */
-	n = phy->band_idx ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	for (i = 0; i < 15 /*ARRAY_SIZE(bound)*/; i++)
-		data[ei++] = dev->mt76.aggr_stats[i + n];
+		data[ei++] = phy->mt76->aggr_stats[i];
 
 	data[ei++] = phy->mib.ba_miss_cnt;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index bce76417f95d..29d8883268f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -85,7 +85,7 @@ mt7921_ampdu_stat_read_phy(struct mt7921_phy *phy,
 
 	seq_puts(file, "\nCount:  ");
 	for (i = 0; i < ARRAY_SIZE(bound); i++)
-		seq_printf(file, "%8d | ", dev->mt76.aggr_stats[i]);
+		seq_printf(file, "%8d | ", phy->mt76->aggr_stats[i]);
 	seq_puts(file, "\n");
 
 	seq_printf(file, "BA miss count: %d\n", phy->mib.ba_miss_cnt);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 1c0d8cf19b8e..9a4f307f8f24 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -745,7 +745,7 @@ void mt7921_mac_reset_counters(struct mt7921_phy *phy)
 	}
 
 	dev->mt76.phy.survey_time = ktime_get_boottime();
-	memset(&dev->mt76.aggr_stats[0], 0, sizeof(dev->mt76.aggr_stats) / 2);
+	memset(phy->mt76->aggr_stats, 0, sizeof(phy->mt76->aggr_stats));
 
 	/* reset airtime counters */
 	mt76_rr(dev, MT_MIB_SDR9(0));
@@ -990,10 +990,10 @@ void mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
 		val = mt76_rr(dev, MT_TX_AGG_CNT(0, i));
 		val2 = mt76_rr(dev, MT_TX_AGG_CNT2(0, i));
 
-		dev->mt76.aggr_stats[aggr0++] += val & 0xffff;
-		dev->mt76.aggr_stats[aggr0++] += val >> 16;
-		dev->mt76.aggr_stats[aggr1++] += val2 & 0xffff;
-		dev->mt76.aggr_stats[aggr1++] += val2 >> 16;
+		phy->mt76->aggr_stats[aggr0++] += val & 0xffff;
+		phy->mt76->aggr_stats[aggr0++] += val >> 16;
+		phy->mt76->aggr_stats[aggr1++] += val2 & 0xffff;
+		phy->mt76->aggr_stats[aggr1++] += val2 >> 16;
 	}
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 7e409ac7d9a8..092f683572f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1075,7 +1075,7 @@ void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	/* Tx ampdu stat */
 	for (i = 0; i < 15; i++)
-		data[ei++] = dev->mt76.aggr_stats[i];
+		data[ei++] = phy->mt76->aggr_stats[i];
 
 	data[ei++] = phy->mib.ba_miss_cnt;
 
-- 
2.38.1

