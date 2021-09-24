Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492C0416F77
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 11:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245345AbhIXJuo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 05:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245325AbhIXJua (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 05:50:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE4D261090;
        Fri, 24 Sep 2021 09:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632476937;
        bh=9IPy5xnlqDFmpeS4FWEw0AlWFSoLahNEWdlheWWcGUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mz+wq8DoVgAF7hF55fau8F9LPlnFT8Iy0hGuFyrsIZ/YThOhsZOnRxWpGvJXqDmIh
         NopmSt6pOL8m7B85LxPpMHGWW2Z5qHs5oDBpKVAw2E6GuXdmLTWbR2WfONAP6K26q/
         IKiiyd+D5ksArzB5Wxgnzv+73QJnAWNYrCc69InbFCJJBdwEJic5j2s8u2QpVjB3/h
         H3fjpV4QZrHD4YPvO2AdUfBWSdRt9/7lXIDGxEhvnWY+ux1uBITKdfA4Rn3PQ8eaQn
         NwhyAnGomsMCy7jXjiz3pLMif6enUSrX0koqTt1WE8JVogVAJBrbTasFs5ACN86Rnb
         JYpcrCprwP3iw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
Subject: [PATCH 1/2] mt76: rely on phy pointer in mt76_register_debugfs_fops routine signature
Date:   Fri, 24 Sep 2021 11:48:18 +0200
Message-Id: <f57815ea2bdba416e1be6dc4f64ec66275b62885.1632476677.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632476677.git.lorenzo@kernel.org>
References: <cover.1632476677.git.lorenzo@kernel.org>
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
index 484b96d9f1c0..0adfe2f3caa2 100644
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

