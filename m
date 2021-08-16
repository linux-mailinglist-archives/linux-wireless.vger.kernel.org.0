Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849B03ECC1B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 02:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhHPAfY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Aug 2021 20:35:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49806 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231379AbhHPAfY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Aug 2021 20:35:24 -0400
X-UUID: 185b44f863664ce2a86dbaf81a2b6075-20210816
X-UUID: 185b44f863664ce2a86dbaf81a2b6075-20210816
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 470131887; Mon, 16 Aug 2021 08:34:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 16 Aug 2021 08:34:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 16 Aug 2021 08:34:48 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: [PATCH 2/3] mt76: mt7915: rework debugfs queue info
Date:   Mon, 16 Aug 2021 08:32:27 +0800
Message-ID: <a36459de6c378583c84ea737101ce2a2da0c8f5b.1629073504.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <3f393508b9ed8251f4e2408356110af092c8ad3e.1629073504.git.ryder.lee@mediatek.com>
References: <3f393508b9ed8251f4e2408356110af092c8ad3e.1629073504.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Complete PSE/PLE queue statistics, including per-sta AC queue
information.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 160 +++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  19 ++-
 2 files changed, 154 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index e1cdfbe52199..fdb4017e1ff9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -7,6 +7,13 @@
 
 /** global debugfs **/
 
+struct hw_queue_map {
+	const char *name;
+	u8 index;
+	u8 pid;
+	u8 qid;
+};
+
 static int
 mt7915_implicit_txbf_set(void *data, u64 val)
 {
@@ -233,30 +240,131 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(mt7915_tx_stats);
 
-static int
-mt7915_queues_acq(struct seq_file *s, void *data)
+static void
+mt7915_hw_queue_read(struct seq_file *s, u32 base, u32 size,
+		     const struct hw_queue_map *map)
 {
 	struct mt7915_dev *dev = dev_get_drvdata(s->private);
-	int i;
+	u32 i, val;
 
-	for (i = 0; i < 16; i++) {
-		int j, acs = i / 4, index = i % 4;
-		u32 ctrl, val, qlen = 0;
+	val = mt76_rr(dev, base + MT_FL_Q_EMPTY);
+	for (i = 0; i < size; i++) {
+		u32 ctrl, head, tail, queued;
 
-		val = mt76_rr(dev, MT_PLE_AC_QEMPTY(acs, index));
-		ctrl = BIT(31) | BIT(15) | (acs << 8);
+		if (val & BIT(map[i].index))
+			continue;
+
+		ctrl = BIT(31) | (map[i].pid << 10) | (map[i].qid << 24);
+		mt76_wr(dev, base + MT_FL_Q0_CTRL, ctrl);
 
-		for (j = 0; j < 32; j++) {
-			if (val & BIT(j))
-				continue;
+		head = mt76_get_field(dev, base + MT_FL_Q2_CTRL,
+				      GENMASK(11, 0));
+		tail = mt76_get_field(dev, base + MT_FL_Q2_CTRL,
+				      GENMASK(27, 16));
+		queued = mt76_get_field(dev, base + MT_FL_Q3_CTRL,
+					GENMASK(11, 0));
 
-			mt76_wr(dev, MT_PLE_FL_Q0_CTRL,
-				ctrl | (j + (index << 5)));
-			qlen += mt76_get_field(dev, MT_PLE_FL_Q3_CTRL,
-					       GENMASK(11, 0));
-		}
-		seq_printf(s, "AC%d%d: queued=%d\n", acs, index, qlen);
+		seq_printf(s, "\t%s: ", map[i].name);
+		seq_printf(s, "queued:0x%03x head:0x%03x tail:0x%03x\n",
+			   queued, head, tail);
 	}
+}
+
+static void
+mt7915_sta_hw_queue_read(void *data, struct ieee80211_sta *sta)
+{
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct mt7915_dev *dev = msta->vif->phy->dev;
+	struct seq_file *s = data;
+	u8 ac;
+
+	for (ac = 0; ac < 4; ac++) {
+		u32 qlen, ctrl, val;
+		u32 idx = msta->wcid.idx >> 5;
+		u8 offs = msta->wcid.idx & GENMASK(4, 0);
+
+		ctrl = BIT(31) | BIT(11) | (ac << 24);
+		val = mt76_rr(dev, MT_PLE_AC_QEMPTY(ac, idx));
+
+		if (val & BIT(offs))
+			continue;
+
+		mt76_wr(dev, MT_PLE_BASE + MT_FL_Q0_CTRL, ctrl | msta->wcid.idx);
+		qlen = mt76_get_field(dev, MT_PLE_BASE + MT_FL_Q3_CTRL,
+				      GENMASK(11, 0));
+		seq_printf(s, "\tSTA %pM wcid %d: AC%d%d queued:%d\n",
+			   sta->addr, msta->wcid.idx, msta->vif->wmm_idx,
+			   ac, qlen);
+	}
+}
+
+static int
+mt7915_hw_queues_read(struct seq_file *s, void *data)
+{
+	struct mt7915_dev *dev = dev_get_drvdata(s->private);
+	struct mt7915_phy *phy = mt7915_ext_phy(dev);
+	static const struct hw_queue_map ple_queue_map[] = {
+		{"CPU_Q0",  0,  1, MT_CTX0},
+		{"CPU_Q1",  1,  1, MT_CTX0 + 1},
+		{"CPU_Q2",  2,  1, MT_CTX0 + 2},
+		{"CPU_Q3",  3,  1, MT_CTX0 + 3},
+		{"ALTX_Q0", 8,  2, MT_LMAC_ALTX0},
+		{"BMC_Q0",  9,  2, MT_LMAC_BMC0},
+		{"BCN_Q0",  10, 2, MT_LMAC_BCN0},
+		{"PSMP_Q0", 11, 2, MT_LMAC_PSMP0},
+		{"ALTX_Q1", 12, 2, MT_LMAC_ALTX0 + 4},
+		{"BMC_Q1",  13, 2, MT_LMAC_BMC0 + 4},
+		{"BCN_Q1",  14, 2, MT_LMAC_BCN0 + 4},
+		{"PSMP_Q1", 15, 2, MT_LMAC_PSMP0 + 4},
+	};
+	static const struct hw_queue_map pse_queue_map[] = {
+		{"CPU Q0",  0,  1, MT_CTX0},
+		{"CPU Q1",  1,  1, MT_CTX0 + 1},
+		{"CPU Q2",  2,  1, MT_CTX0 + 2},
+		{"CPU Q3",  3,  1, MT_CTX0 + 3},
+		{"HIF_Q0",  8,  0, MT_HIF0},
+		{"HIF_Q1",  9,  0, MT_HIF0 + 1},
+		{"HIF_Q2",  10, 0, MT_HIF0 + 2},
+		{"HIF_Q3",  11, 0, MT_HIF0 + 3},
+		{"HIF_Q4",  12, 0, MT_HIF0 + 4},
+		{"HIF_Q5",  13, 0, MT_HIF0 + 5},
+		{"LMAC_Q",  16, 2, 0},
+		{"MDP_TXQ", 17, 2, 1},
+		{"MDP_RXQ", 18, 2, 2},
+		{"SEC_TXQ", 19, 2, 3},
+		{"SEC_RXQ", 20, 2, 4},
+	};
+	u32 val, head, tail;
+
+	/* ple queue */
+	val = mt76_rr(dev, MT_PLE_FREEPG_CNT);
+	head = mt76_get_field(dev, MT_PLE_FREEPG_HEAD_TAIL, GENMASK(11, 0));
+	tail = mt76_get_field(dev, MT_PLE_FREEPG_HEAD_TAIL, GENMASK(27, 16));
+	seq_puts(s, "PLE page info:\n");
+	seq_printf(s, "\tTotal free page: 0x%08x head: 0x%03x tail: 0x%03x\n",
+		   val, head, tail);
+
+	val = mt76_rr(dev, MT_PLE_PG_HIF_GROUP);
+	head = mt76_get_field(dev, MT_PLE_HIF_PG_INFO, GENMASK(11, 0));
+	tail = mt76_get_field(dev, MT_PLE_HIF_PG_INFO, GENMASK(27, 16));
+	seq_printf(s, "\tHIF free page: 0x%03x res: 0x%03x used: 0x%03x\n",
+		   val, head, tail);
+
+	seq_puts(s, "PLE non-empty queue info:\n");
+	mt7915_hw_queue_read(s, MT_PLE_BASE, ARRAY_SIZE(ple_queue_map),
+			     &ple_queue_map[0]);
+
+	/* iterate per-sta ple queue */
+	ieee80211_iterate_stations_atomic(dev->mphy.hw,
+					  mt7915_sta_hw_queue_read, s);
+	if (phy)
+		ieee80211_iterate_stations_atomic(phy->mt76->hw,
+						  mt7915_sta_hw_queue_read, s);
+
+	/* pse queue */
+	seq_puts(s, "PSE non-empty queue info:\n");
+	mt7915_hw_queue_read(s, MT_PSE_BASE, ARRAY_SIZE(pse_queue_map),
+			     &pse_queue_map[0]);
 
 	return 0;
 }
@@ -345,8 +453,8 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
 
 	debugfs_create_devm_seqfile(dev->mt76.dev, "queues", dir,
 				    mt7915_queues_read);
-	debugfs_create_devm_seqfile(dev->mt76.dev, "acq", dir,
-				    mt7915_queues_acq);
+	debugfs_create_devm_seqfile(dev->mt76.dev, "hw-queues", dir,
+				    mt7915_hw_queues_read);
 	debugfs_create_file("tx_stats", 0400, dir, dev, &mt7915_tx_stats_fops);
 	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
 	debugfs_create_file("implicit_txbf", 0600, dir, dev,
@@ -431,9 +539,23 @@ static const struct file_operations fops_fixed_rate = {
 	.llseek = default_llseek,
 };
 
+static int
+mt7915_queues_show(struct seq_file *s, void *data)
+{
+	struct ieee80211_sta *sta = s->private;
+
+	mt7915_sta_hw_queue_read(s, sta);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mt7915_queues);
+
 void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, struct dentry *dir)
 {
 	debugfs_create_file("fixed_rate", 0600, dir, sta, &fops_fixed_rate);
+	debugfs_create_file("hw-queues", 0400, dir, sta, &mt7915_queues_fops);
 }
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 91c1fb56b0ed..3be53b73fc00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -22,15 +22,22 @@
 #define MT_PLE_BASE			0x8000
 #define MT_PLE(ofs)			(MT_PLE_BASE + (ofs))
 
-#define MT_PLE_FL_Q0_CTRL		MT_PLE(0x1b0)
-#define MT_PLE_FL_Q1_CTRL		MT_PLE(0x1b4)
-#define MT_PLE_FL_Q2_CTRL		MT_PLE(0x1b8)
-#define MT_PLE_FL_Q3_CTRL		MT_PLE(0x1bc)
-
-#define MT_PLE_AC_QEMPTY(ac, n)		MT_PLE(0x300 + 0x10 * (ac) + \
+#define MT_FL_Q_EMPTY			0x0b0
+#define MT_FL_Q0_CTRL			0x1b0
+#define MT_FL_Q2_CTRL			0x1b8
+#define MT_FL_Q3_CTRL			0x1bc
+
+#define MT_PLE_FREEPG_CNT		MT_PLE(0x100)
+#define MT_PLE_FREEPG_HEAD_TAIL		MT_PLE(0x104)
+#define MT_PLE_PG_HIF_GROUP		MT_PLE(0x110)
+#define MT_PLE_HIF_PG_INFO		MT_PLE(0x114)
+#define MT_PLE_AC_QEMPTY(ac, n)		MT_PLE(0x500 + 0x40 * (ac) + \
 					       ((n) << 2))
 #define MT_PLE_AMSDU_PACK_MSDU_CNT(n)	MT_PLE(0x10e0 + ((n) << 2))
 
+#define MT_PSE_BASE			0xc000
+#define MT_PSE(ofs)			(MT_PSE_BASE + (ofs))
+
 #define MT_MDP_BASE			0xf000
 #define MT_MDP(ofs)			(MT_MDP_BASE + (ofs))
 
-- 
2.29.2

