Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9D3428AD8
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 12:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbhJKKku (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 06:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235881AbhJKKks (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 06:40:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B418D60E90;
        Mon, 11 Oct 2021 10:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633948728;
        bh=2RSUAfnk86Y2P31+FW6mVXbrkg/XuvyAEEFxdxhsQGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B12PFaFgMniKoEPZW/Vp39OHPsTdizzpnS9v0bcmyqJMXU8Ex+qtCMeqvcjnhqCWq
         bjX8XlLUL8qwbf2Gvaxk/cZFWKbNJcbErmbS5QwN6T9xg1LPkmebKr+P/Z+cY+c5mP
         J233uhcsOoH7oBXNAT7q0dOujCogW1LiynwdgMDrrHRRCl8FCFOSSipl5oFg3UhyBN
         TooTACJdEu0gNw1lej+gtDysGsfb72RZXJM4JCWZeLrs56abY7LQ9amSeAAbnSpVbk
         VkOnPENFRgzREKnS1rp9CgoDDTqn+QKVJRiXKz6ThXSLbQLjLIfjD4Ili0YQu6FUTF
         6Dgvd/Ib045/A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v3 1/3] mt76: rely on phy pointer in mt76_register_debugfs_fops routine signature
Date:   Mon, 11 Oct 2021 12:38:27 +0200
Message-Id: <b85dea5d6463ff7e9c4386227cdde047d389a67d.1633948549.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633948549.git.lorenzo@kernel.org>
References: <cover.1633948549.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to create a mt76 debugfs subir for ext-phy.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c        | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt76.h           | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index c9b03b3fed2a..b8bcf22a07fd 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -118,13 +118,14 @@ static int mt76_read_rate_txpower(struct seq_file *s, void *data)
 }
 
 struct dentry *
-mt76_register_debugfs_fops(struct mt76_dev *dev,
+mt76_register_debugfs_fops(struct mt76_phy *phy,
 			   const struct file_operations *ops)
 {
 	const struct file_operations *fops = ops ? ops : &fops_regval;
+	struct mt76_dev *dev = phy->dev;
 	struct dentry *dir;
 
-	dir = debugfs_create_dir("mt76", dev->hw->wiphy->debugfsdir);
+	dir = debugfs_create_dir("mt76", phy->hw->wiphy->debugfsdir);
 	if (!dir)
 		return NULL;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4c20b128466d..0b8f3b7c7a38 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -888,11 +888,11 @@ struct mt76_phy *mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
 int mt76_register_phy(struct mt76_phy *phy, bool vht,
 		      struct ieee80211_rate *rates, int n_rates);
 
-struct dentry *mt76_register_debugfs_fops(struct mt76_dev *dev,
+struct dentry *mt76_register_debugfs_fops(struct mt76_phy *phy,
 					  const struct file_operations *ops);
 static inline struct dentry *mt76_register_debugfs(struct mt76_dev *dev)
 {
-	return mt76_register_debugfs_fops(dev, NULL);
+	return mt76_register_debugfs_fops(&dev->phy, NULL);
 }
 
 int mt76_queues_read(struct seq_file *s, void *data);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index bda22ca0bd71..6fd6f067da49 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -533,7 +533,7 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 {
 	struct dentry *dir;
 
-	dir = mt76_register_debugfs_fops(&dev->mt76, &fops_regval);
+	dir = mt76_register_debugfs_fops(&dev->mphy, &fops_regval);
 	if (!dir)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 11f8acf4f59e..71aabb632e05 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -417,7 +417,7 @@ int mt7921_init_debugfs(struct mt7921_dev *dev)
 {
 	struct dentry *dir;
 
-	dir = mt76_register_debugfs_fops(&dev->mt76, &fops_regval);
+	dir = mt76_register_debugfs_fops(&dev->mphy, &fops_regval);
 	if (!dir)
 		return -ENOMEM;
 
-- 
2.31.1

