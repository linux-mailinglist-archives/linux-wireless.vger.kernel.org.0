Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F2A3E3C79
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Aug 2021 21:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhHHTMU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Aug 2021 15:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231717AbhHHTMU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Aug 2021 15:12:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B10596054E;
        Sun,  8 Aug 2021 19:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628449921;
        bh=TYhox4wV1zu8cCABoP8GVavCOMkor0M3kgFICFMUgeg=;
        h=From:To:Cc:Subject:Date:From;
        b=EpSrPmzyTH96/ldVBbgyz0YZ+Ni/uHAiaxz3YGh5ZPt8pTwiOGJ3WN71FgNYZRwmI
         kSxZvnsQY1OcsY4EcnRQlxxhNhLvEg92eN4CdsS3EftJTc/jPWQ+B9ABpMpeg4vuii
         KvxyNsPZ/ljZ6ZmpkqlFB5i5AZv0QvTidr9PyWynnRpNCpkmhco4Kl/n9ddOASlewP
         ZdM0cAkFf+HC3PnJB0CsaIG9/OmBMurP48QEog20WAkNx92zbDIeLAvXazRK7lH6m6
         BCvxOC78Hs9hwT9uydPP6KQ8nM1iM1nYIqdXe9B9pCho6l/i0eYv3J0kEJUgcgsspE
         +Q0n1K/qwRxdw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: overwrite default reg_ops if necessary
Date:   Sun,  8 Aug 2021 21:11:49 +0200
Message-Id: <b784f6eff864a6543b49ac93ceb9397271e8ecb8.1628449861.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76_register_debugfs_fops routine in order to
define per-driver regs file operations and make sure the
device is up before reading or writing its registers

Fixes: 1d8efc741df8 'mt76: mt7921: introduce Runtime PM support'
Fixes: de5ff3c9d1a2 'mt76: mt7615: introduce pm_power_save delayed work'
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c  | 10 ++++---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  8 ++++-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 29 ++++++++++++++++++-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   | 28 +++++++++++++++++-
 4 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index fa48cc3a7a8f..ad97308c7853 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -116,8 +116,11 @@ static int mt76_read_rate_txpower(struct seq_file *s, void *data)
 	return 0;
 }
 
-struct dentry *mt76_register_debugfs(struct mt76_dev *dev)
+struct dentry *
+mt76_register_debugfs_fops(struct mt76_dev *dev,
+			   const struct file_operations *ops)
 {
+	const struct file_operations *fops = ops ? ops : &fops_regval;
 	struct dentry *dir;
 
 	dir = debugfs_create_dir("mt76", dev->hw->wiphy->debugfsdir);
@@ -126,8 +129,7 @@ struct dentry *mt76_register_debugfs(struct mt76_dev *dev)
 
 	debugfs_create_u8("led_pin", 0600, dir, &dev->led_pin);
 	debugfs_create_u32("regidx", 0600, dir, &dev->debugfs_reg);
-	debugfs_create_file_unsafe("regval", 0600, dir, dev,
-				   &fops_regval);
+	debugfs_create_file_unsafe("regval", 0600, dir, dev, fops);
 	debugfs_create_file_unsafe("napi_threaded", 0600, dir, dev,
 				   &fops_napi_threaded);
 	debugfs_create_blob("eeprom", 0400, dir, &dev->eeprom);
@@ -140,4 +142,4 @@ struct dentry *mt76_register_debugfs(struct mt76_dev *dev)
 
 	return dir;
 }
-EXPORT_SYMBOL_GPL(mt76_register_debugfs);
+EXPORT_SYMBOL_GPL(mt76_register_debugfs_fops);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index bf36f9227713..8c49515000f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -879,7 +879,13 @@ struct mt76_phy *mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
 int mt76_register_phy(struct mt76_phy *phy, bool vht,
 		      struct ieee80211_rate *rates, int n_rates);
 
-struct dentry *mt76_register_debugfs(struct mt76_dev *dev);
+struct dentry *mt76_register_debugfs_fops(struct mt76_dev *dev,
+					  const struct file_operations *ops);
+static inline struct dentry *mt76_register_debugfs(struct mt76_dev *dev)
+{
+	return mt76_register_debugfs_fops(dev, NULL);
+}
+
 int mt76_queues_read(struct seq_file *s, void *data);
 void mt76_seq_puts_array(struct seq_file *file, const char *str,
 			 s8 *val, int len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index cb4659771fd9..bda22ca0bd71 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -2,6 +2,33 @@
 
 #include "mt7615.h"
 
+static int
+mt7615_reg_set(void *data, u64 val)
+{
+	struct mt7615_dev *dev = data;
+
+	mt7615_mutex_acquire(dev);
+	mt76_wr(dev, dev->mt76.debugfs_reg, val);
+	mt7615_mutex_release(dev);
+
+	return 0;
+}
+
+static int
+mt7615_reg_get(void *data, u64 *val)
+{
+	struct mt7615_dev *dev = data;
+
+	mt7615_mutex_acquire(dev);
+	*val = mt76_rr(dev, dev->mt76.debugfs_reg);
+	mt7615_mutex_release(dev);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_regval, mt7615_reg_get, mt7615_reg_set,
+			 "0x%08llx\n");
+
 static int
 mt7615_radar_pattern_set(void *data, u64 val)
 {
@@ -506,7 +533,7 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 {
 	struct dentry *dir;
 
-	dir = mt76_register_debugfs(&dev->mt76);
+	dir = mt76_register_debugfs_fops(&dev->mt76, &fops_regval);
 	if (!dir)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 77468bdae460..4c89c4ac8031 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -4,6 +4,32 @@
 #include "mt7921.h"
 #include "eeprom.h"
 
+static int
+mt7921_reg_set(void *data, u64 val)
+{
+	struct mt7921_dev *dev = data;
+
+	mt7921_mutex_acquire(dev);
+	mt76_wr(dev, dev->mt76.debugfs_reg, val);
+	mt7921_mutex_release(dev);
+
+	return 0;
+}
+
+static int
+mt7921_reg_get(void *data, u64 *val)
+{
+	struct mt7921_dev *dev = data;
+
+	mt7921_mutex_acquire(dev);
+	*val = mt76_rr(dev, dev->mt76.debugfs_reg);
+	mt7921_mutex_release(dev);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_regval, mt7921_reg_get, mt7921_reg_set,
+			 "0x%08llx\n");
 static int
 mt7921_fw_debug_set(void *data, u64 val)
 {
@@ -373,7 +399,7 @@ int mt7921_init_debugfs(struct mt7921_dev *dev)
 {
 	struct dentry *dir;
 
-	dir = mt76_register_debugfs(&dev->mt76);
+	dir = mt76_register_debugfs_fops(&dev->mt76, &fops_regval);
 	if (!dir)
 		return -ENOMEM;
 
-- 
2.31.1

