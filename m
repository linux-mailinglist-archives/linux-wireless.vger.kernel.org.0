Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3647CB189F
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 09:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfIMHGE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 03:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfIMHGD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 03:06:03 -0400
Received: from localhost.localdomain (unknown [151.66.2.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E15820830;
        Fri, 13 Sep 2019 07:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568358362;
        bh=KcqFbUuDBImdrI1mXRZ4kqi2Ae7er8mwBndSbXwVvX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ABvekpc+S0ZRNOpRpXvoHu7LD02r9juaTg3KK+P0kikIkztTWe1Z+i5aq9xtoOHf
         4FXJyQqCKsgo2kUxVtCYq4UijWWuRcsCLArssN4uyul7FZW2LcJa7LiwI7SjEBWSA/
         fS5XQ0hwG+3Xw/Yf4Xv3EMxwaINwjgjS4rMTi6Gw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 1/5] mt76: move queue debugfs entry to driver specific code
Date:   Fri, 13 Sep 2019 09:05:50 +0200
Message-Id: <1bafcdfc877606b55d63cbd1f40a27dba05c5800.1568358061.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568358061.git.lorenzo@kernel.org>
References: <cover.1568358061.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move queue debugfs entry to driver specific code since mt7615 devices
rely on a different queue layout

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c         | 5 ++---
 drivers/net/wireless/mediatek/mt76/mt76.h            | 1 +
 drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c | 2 ++
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index d95b73fd0d2b..d2202acb8dc6 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -25,8 +25,7 @@ mt76_reg_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_regval, mt76_reg_get, mt76_reg_set,
 			 "0x%08llx\n");
 
-static int
-mt76_queues_read(struct seq_file *s, void *data)
+int mt76_queues_read(struct seq_file *s, void *data)
 {
 	struct mt76_dev *dev = dev_get_drvdata(s->private);
 	int i;
@@ -45,6 +44,7 @@ mt76_queues_read(struct seq_file *s, void *data)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt76_queues_read);
 
 void mt76_seq_puts_array(struct seq_file *file, const char *str,
 			 s8 *val, int len)
@@ -90,7 +90,6 @@ struct dentry *mt76_register_debugfs(struct mt76_dev *dev)
 	debugfs_create_blob("eeprom", 0400, dir, &dev->eeprom);
 	if (dev->otp.data)
 		debugfs_create_blob("otp", 0400, dir, &dev->otp);
-	debugfs_create_devm_seqfile(dev->dev, "queues", dir, mt76_queues_read);
 	debugfs_create_devm_seqfile(dev->dev, "rate_txpower", dir,
 				    mt76_read_rate_txpower);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 570c159515a0..69ca21af5b0b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -624,6 +624,7 @@ void mt76_unregister_device(struct mt76_dev *dev);
 void mt76_free_device(struct mt76_dev *dev);
 
 struct dentry *mt76_register_debugfs(struct mt76_dev *dev);
+int mt76_queues_read(struct seq_file *s, void *data);
 void mt76_seq_puts_array(struct seq_file *file, const char *str,
 			 s8 *val, int len);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
index 5942fe76c6e9..45eb24862240 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
@@ -77,6 +77,8 @@ void mt7603_init_debugfs(struct mt7603_dev *dev)
 	if (!dir)
 		return;
 
+	debugfs_create_devm_seqfile(dev->mt76.dev, "queues", dir,
+				    mt76_queues_read);
 	debugfs_create_file("edcca", 0600, dir, dev, &fops_edcca);
 	debugfs_create_u32("reset_test", 0600, dir, &dev->reset_test);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "reset", dir,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
index 0cb2a7b35fe5..186838128c55 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
@@ -143,6 +143,8 @@ void mt76x02_init_debugfs(struct mt76x02_dev *dev)
 	if (!dir)
 		return;
 
+	debugfs_create_devm_seqfile(dev->mt76.dev, "queues", dir,
+				    mt76_queues_read);
 	debugfs_create_u8("temperature", 0400, dir, &dev->cal.temp);
 	debugfs_create_bool("tpc", 0600, dir, &dev->enable_tpc);
 
-- 
2.21.0

