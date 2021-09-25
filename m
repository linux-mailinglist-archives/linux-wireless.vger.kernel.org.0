Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0769F418101
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Sep 2021 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244073AbhIYK26 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Sep 2021 06:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234922AbhIYK25 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Sep 2021 06:28:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB7E56124B;
        Sat, 25 Sep 2021 10:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632565643;
        bh=OJq+fq9gvWis3ReYuW2eKVZpAMQJY5nROE7SGTyaiW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMytWtKWve4FqtUEdN+m+i1N6tBBDnonULaAQcp9u2yBVB30E3hKLiDUD+NPxjPhc
         OAExU1tTstQJd4NA/SVt3Ve78W23sGGDFyVTm02jWv9BaVhMH8vLcQzdj1dqet7882
         fyohU+loOtoedz/DBkVVOrWeCHCPjpYMZJBV5dVVUoQIYyybk+Z6NkIqFAUb1lSODM
         kXVIWMgJrrBAw4i7S6Xb2kiTZBImJa1LFvsZPpzHngi46fHxmtSMb8fqFvJJ8qjaAN
         ylwbGvmOgj8vRtvuxwNVZzxVh0tFmNgKrekT3/MlP14zrhAhvA/JmY2jRhP3+EHMoG
         EiUHn4X+CAOnw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v2 1/2] mt76: rely on phy pointer in mt76_register_debugfs_fops routine signature
Date:   Sat, 25 Sep 2021 12:26:57 +0200
Message-Id: <85312f9194d84920e527368ede1b0ffd1dcf0c94.1632565435.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632565435.git.lorenzo@kernel.org>
References: <cover.1632565435.git.lorenzo@kernel.org>
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
index ad97308c7853..e23fabddec1f 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -117,13 +117,14 @@ static int mt76_read_rate_txpower(struct seq_file *s, void *data)
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
index 60dda80e33b0..82ce59e301d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -887,11 +887,11 @@ struct mt76_phy *mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
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

