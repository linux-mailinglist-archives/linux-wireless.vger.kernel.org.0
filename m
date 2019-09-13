Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76FC3B18A2
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 09:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfIMHGK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 03:06:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfIMHGK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 03:06:10 -0400
Received: from localhost.localdomain (unknown [151.66.2.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 829F120717;
        Fri, 13 Sep 2019 07:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568358368;
        bh=kNcLRnuMFlMH8pf1kTVOv484MHKuJqBM+XDQeJcBl9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPMH2JNiQtnKd4bo1QsiYN6QPXaLm5n+uAfFNZ4KGEMtochHfL9Bettt3+fjfueIT
         SnmIivs9O43B5xumpFHMUpl6YGN9W+hgigiqZRAQ2U4uEMd3jQZSu+79vyFgh7rdmq
         Os1arXhFBZc8mpfyPq3eHR72KcQLw1XrlBXgawr0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 4/5] mt76: mt7615: collect aggregation stats
Date:   Fri, 13 Sep 2019 09:05:53 +0200
Message-Id: <3bb010b71d0e24405976403aba6a8592860e5447.1568358061.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568358061.git.lorenzo@kernel.org>
References: <cover.1568358061.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce ampdu_stat entry in mt7615 debugfs in order to dump 802.11
aggr cumulative statistics

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 39 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 18 +++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  2 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  6 +++
 5 files changed, 66 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 1dc68d4aee57..f6b75f832e6a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -36,6 +36,44 @@ mt7615_scs_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_scs, mt7615_scs_get,
 			 mt7615_scs_set, "%lld\n");
 
+static int
+mt7615_ampdu_stat_read(struct seq_file *file, void *data)
+{
+	struct mt7615_dev *dev = file->private;
+	int bound[7], i, range;
+
+	range = mt76_rr(dev, MT_AGG_ASRCR0);
+	for (i = 0; i < 4; i++)
+		bound[i] = MT_AGG_ASRCR_RANGE(range, i) + 1;
+	range = mt76_rr(dev, MT_AGG_ASRCR1);
+	for (i = 0; i < 3; i++)
+		bound[i + 4] = MT_AGG_ASRCR_RANGE(range, i) + 1;
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
+mt7615_ampdu_stat_open(struct inode *inode, struct file *f)
+{
+	return single_open(f, mt7615_ampdu_stat_read, inode->i_private);
+}
+
+static const struct file_operations fops_ampdu_stat = {
+	.open = mt7615_ampdu_stat_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
 static int
 mt7615_radio_read(struct seq_file *s, void *data)
 {
@@ -130,6 +168,7 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 				    mt7615_queues_read);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "acq", dir,
 				    mt7615_queues_acq);
+	debugfs_create_file("ampdu_stat", 0400, dir, dev, &fops_ampdu_stat);
 	debugfs_create_file("scs", 0600, dir, dev, &fops_scs);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "radio", dir,
 				    mt7615_radio_read);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index e07ce2c10013..237d15521e18 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -41,6 +41,16 @@ static struct mt76_wcid *mt7615_rx_get_wcid(struct mt7615_dev *dev,
 	return &sta->vif->sta.wcid;
 }
 
+void mt7615_mac_reset_counters(struct mt7615_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < 4; i++)
+		mt76_rr(dev, MT_TX_AGG_CNT(i));
+
+	memset(dev->mt76.aggr_stats, 0, sizeof(dev->mt76.aggr_stats));
+}
+
 int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
@@ -1261,6 +1271,7 @@ void mt7615_update_channel(struct mt76_dev *mdev)
 void mt7615_mac_work(struct work_struct *work)
 {
 	struct mt7615_dev *dev;
+	int i, idx;
 
 	dev = (struct mt7615_dev *)container_of(work, struct mt76_dev,
 						mac_work.work);
@@ -1271,6 +1282,13 @@ void mt7615_mac_work(struct work_struct *work)
 		mt7615_mac_scs_check(dev);
 		dev->mac_work_count = 0;
 	}
+
+	for (i = 0, idx = 0; i < 4; i++) {
+		u32 val = mt76_rr(dev, MT_TX_AGG_CNT(i));
+
+		dev->mt76.aggr_stats[idx++] += val & 0xffff;
+		dev->mt76.aggr_stats[idx++] += val >> 16;
+	}
 	mutex_unlock(&dev->mt76.mutex);
 
 	mt76_tx_status_check(&dev->mt76, NULL, false);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 87c748715b5d..a8ce71fcf432 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -16,6 +16,8 @@ static int mt7615_start(struct ieee80211_hw *hw)
 {
 	struct mt7615_dev *dev = hw->priv;
 
+	mt7615_mac_reset_counters(dev);
+
 	dev->mt76.survey_time = ktime_get_boottime();
 	set_bit(MT76_STATE_RUNNING, &dev->mt76.state);
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index cef3fd43cb00..8a6142637bfd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -229,6 +229,7 @@ static inline void mt7615_irq_disable(struct mt7615_dev *dev, u32 mask)
 }
 
 void mt7615_update_channel(struct mt76_dev *mdev);
+void mt7615_mac_reset_counters(struct mt7615_dev *dev);
 void mt7615_mac_cca_stats_reset(struct mt7615_dev *dev);
 void mt7615_mac_set_scs(struct mt7615_dev *dev, bool enable);
 int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 751e99c38606..681ab84293c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -136,6 +136,10 @@
 					MT_AGG_ARxCR_LIMIT_SHIFT(_n), \
 					MT_AGG_ARxCR_LIMIT_SHIFT(_n))
 
+#define MT_AGG_ASRCR0			MT_WF_AGG(0x060)
+#define MT_AGG_ASRCR1			MT_WF_AGG(0x064)
+#define MT_AGG_ASRCR_RANGE(val, n)	(((val) >> ((n) << 3)) & GENMASK(5, 0))
+
 #define MT_AGG_ACR0			MT_WF_AGG(0x070)
 #define MT_AGG_ACR1			MT_WF_AGG(0x170)
 #define MT_AGG_ACR_NO_BA_RULE		BIT(0)
@@ -269,6 +273,8 @@
 #define MT_MIB_SDR16(n)			MT_WF_MIB(0x48 + ((n) << 9))
 #define MT_MIB_BUSY_MASK		GENMASK(23, 0)
 
+#define MT_TX_AGG_CNT(n)		MT_WF_MIB(0xa8 + ((n) << 2))
+
 #define MT_EFUSE_BASE			0x81070000
 #define MT_EFUSE_BASE_CTRL		0x000
 #define MT_EFUSE_BASE_CTRL_EMPTY	BIT(30)
-- 
2.21.0

