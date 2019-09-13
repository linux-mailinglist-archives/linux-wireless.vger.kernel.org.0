Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5276EB18A0
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 09:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfIMHGG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 03:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfIMHGG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 03:06:06 -0400
Received: from localhost.localdomain (unknown [151.66.2.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F7A120717;
        Fri, 13 Sep 2019 07:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568358364;
        bh=HQr53eOJUQ55BZxdeZnAFrvuXS3teyBcWCam0Eve6r4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lxOLy2eQEqrW/JJL6+9T+fkHFBv4GaqwITQUP+rerHXriwsRlqMT9TVjO7vgcVHqz
         7f7rsaamQ+FrWUQSNlJXvV+1yYs28uVwA0cD09EZLTn9JeKY0b1PyLTLRIM40Xn7lP
         UC0mbtN3oMN4B5UD7ICDqwBG3H1sg7z/YCUwkHa8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 2/5] mt76: mt7615: add queue entry in debugfs
Date:   Fri, 13 Sep 2019 09:05:51 +0200
Message-Id: <b7f169f551582caf0ced1d8ed4f284b10d5b1641.1568358061.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568358061.git.lorenzo@kernel.org>
References: <cover.1568358061.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_queues_read routine to dump hw queue related info.
Add hw ac queues statistics in mt7615 debugfs

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 61 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  | 11 ++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 2428a4659a1c..1dc68d4aee57 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -61,6 +61,63 @@ static int mt7615_read_temperature(struct seq_file *s, void *data)
 	return 0;
 }
 
+static int
+mt7615_queues_acq(struct seq_file *s, void *data)
+{
+	struct mt7615_dev *dev = dev_get_drvdata(s->private);
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
+mt7615_queues_read(struct seq_file *s, void *data)
+{
+	struct mt7615_dev *dev = dev_get_drvdata(s->private);
+	static const struct {
+		char *queue;
+		int id;
+	} queue_map[] = {
+		{ "PDMA0", MT_TXQ_BE },
+		{ "MCUQ", MT_TXQ_MCU },
+		{ "MCUFWQ", MT_TXQ_FWDL },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(queue_map); i++) {
+		struct mt76_sw_queue *q = &dev->mt76.q_tx[queue_map[i].id];
+
+		if (!q->q)
+			continue;
+
+		seq_printf(s,
+			   "%s:	queued=%d head=%d tail=%d\n",
+			   queue_map[i].queue, q->q->queued, q->q->head,
+			   q->q->tail);
+	}
+
+	return 0;
+}
+
 int mt7615_init_debugfs(struct mt7615_dev *dev)
 {
 	struct dentry *dir;
@@ -69,6 +126,10 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 	if (!dir)
 		return -ENOMEM;
 
+	debugfs_create_devm_seqfile(dev->mt76.dev, "queues", dir,
+				    mt7615_queues_read);
+	debugfs_create_devm_seqfile(dev->mt76.dev, "acq", dir,
+				    mt7615_queues_acq);
 	debugfs_create_file("scs", 0600, dir, dev, &fops_scs);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "radio", dir,
 				    mt7615_radio_read);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index b193814d5cf8..751e99c38606 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -65,6 +65,17 @@
 #define MT_WPDMA_ABT_CFG		MT_HIF(0x530)
 #define MT_WPDMA_ABT_CFG1		MT_HIF(0x534)
 
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
+
 #define MT_WF_PHY_BASE			0x10000
 #define MT_WF_PHY(ofs)			(MT_WF_PHY_BASE + (ofs))
 
-- 
2.21.0

