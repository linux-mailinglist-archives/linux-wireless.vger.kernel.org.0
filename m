Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF151AFDF3
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2020 22:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgDSUL4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Apr 2020 16:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgDSUL4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Apr 2020 16:11:56 -0400
Received: from lore-desk-wlan.lan (unknown [151.48.159.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7051221473;
        Sun, 19 Apr 2020 20:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587327115;
        bh=Uteiu/GUnOSUdNuQXi8TfJhQxKafRhCM39FSRbayK6I=;
        h=From:To:Cc:Subject:Date:From;
        b=ykbTKQaiHabKmJTqMM6O6E3ocX+/mhysYXH8AgWyLOJkJ5NQMDkReqhy88A3U2XS8
         XLfld6g39UqxUpELrmL3y2zpuaUjAD0MWsmbRED7l+FyhJOOfOCYzTSaPPtNOqq2dv
         CZLgg5mFqOMO1aDm9mn7kRpGEGgAKjV695bsNrwU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: add rx queues info to mt76 debugfs
Date:   Sun, 19 Apr 2020 22:11:41 +0200
Message-Id: <26a46b5e2f0775a50b6bc7a8e654ee834aa47010.1587326968.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce rx-queues debugfs node in order to dump rx queues status.
This would be useful for mcu fw debugging

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c  | 21 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7603/debugfs.c   |  2 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  4 ++--
 .../wireless/mediatek/mt76/mt76x02_debugfs.c  |  2 +-
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index d2202acb8dc6..0278e1b44576 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -46,6 +46,25 @@ int mt76_queues_read(struct seq_file *s, void *data)
 }
 EXPORT_SYMBOL_GPL(mt76_queues_read);
 
+static int mt76_rx_queues_read(struct seq_file *s, void *data)
+{
+	struct mt76_dev *dev = dev_get_drvdata(s->private);
+	int i, queued;
+
+	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++) {
+		struct mt76_queue *q = &dev->q_rx[i];
+
+		if (!q->ndesc)
+			continue;
+
+		queued = mt76_is_usb(dev) ? q->ndesc - q->queued : q->queued;
+		seq_printf(s, "%d:	queued=%d head=%d tail=%d\n",
+			   i, queued, q->head, q->tail);
+	}
+
+	return 0;
+}
+
 void mt76_seq_puts_array(struct seq_file *file, const char *str,
 			 s8 *val, int len)
 {
@@ -92,6 +111,8 @@ struct dentry *mt76_register_debugfs(struct mt76_dev *dev)
 		debugfs_create_blob("otp", 0400, dir, &dev->otp);
 	debugfs_create_devm_seqfile(dev->dev, "rate_txpower", dir,
 				    mt76_read_rate_txpower);
+	debugfs_create_devm_seqfile(dev->dev, "rx-queues", dir,
+				    mt76_rx_queues_read);
 
 	return dir;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
index cc7c788abedd..8ce6880b2bb8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
@@ -113,7 +113,7 @@ void mt7603_init_debugfs(struct mt7603_dev *dev)
 		return;
 
 	debugfs_create_file("ampdu_stat", 0400, dir, dev, &fops_ampdu_stat);
-	debugfs_create_devm_seqfile(dev->mt76.dev, "queues", dir,
+	debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues", dir,
 				    mt76_queues_read);
 	debugfs_create_file("edcca", 0600, dir, dev, &fops_edcca);
 	debugfs_create_u32("reset_test", 0600, dir, &dev->reset_test);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 150036488e3f..fd3ef483a87c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -293,10 +293,10 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 		return -ENOMEM;
 
 	if (is_mt7615(&dev->mt76))
-		debugfs_create_devm_seqfile(dev->mt76.dev, "queues", dir,
+		debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues", dir,
 					    mt7615_queues_read);
 	else
-		debugfs_create_devm_seqfile(dev->mt76.dev, "queues", dir,
+		debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues", dir,
 					    mt76_queues_read);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "acq", dir,
 				    mt7615_queues_acq);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
index 68b40d63a46d..ff448a1ad4e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
@@ -144,7 +144,7 @@ void mt76x02_init_debugfs(struct mt76x02_dev *dev)
 	if (!dir)
 		return;
 
-	debugfs_create_devm_seqfile(dev->mt76.dev, "queues", dir,
+	debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues", dir,
 				    mt76_queues_read);
 	debugfs_create_u8("temperature", 0400, dir, &dev->cal.temp);
 	debugfs_create_bool("tpc", 0600, dir, &dev->enable_tpc);
-- 
2.25.3

