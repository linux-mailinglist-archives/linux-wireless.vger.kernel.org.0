Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0C151A878
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2019 18:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfEKQji (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 May 2019 12:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfEKQji (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 May 2019 12:39:38 -0400
Received: from localhost.localdomain (unknown [151.66.17.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED152173B;
        Sat, 11 May 2019 16:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557592776;
        bh=RtgoM9DeejIGT7ufGEo8ae75G01dGRfaJReFQNbYBgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wtZ+T915IPMYQmpMgNmXVlhvK4Mra8ztgjztmP9WxmOg8Uf0UBo/3309ateTtZyoq
         YHAqtLc5Ub3K42+5/UUraZQ8MT28hJBh04OEkLQZ8YYy8dpN9PT1IdWYyKYXIQ/ttM
         zUMKCiS2MZnex7W3x8R5Us10TweHnP3POfb5vDAA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7603: add debugfs knob to enable/disable edcca
Date:   Sat, 11 May 2019 18:38:41 +0200
Message-Id: <0691acb931e963cb6028d4687cdd61032d0aaf52.1557591530.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557591530.git.lorenzo@kernel.org>
References: <cover.1557591530.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce a knob in mt7603 debugfs in order to enable/disable
edcca processing

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7603/debugfs.c   | 30 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7603/init.c  |  4 ++-
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  3 +-
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |  6 +++-
 4 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
index f8b3b6ab6297..efc1cf5ae870 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
@@ -40,6 +40,35 @@ mt7603_radio_read(struct seq_file *s, void *data)
 	return 0;
 }
 
+static int
+mt7603_edcca_set(void *data, u64 val)
+{
+	struct mt7603_dev *dev = data;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	dev->ed_monitor_enabled = !!val;
+	dev->ed_monitor = dev->ed_monitor_enabled &&
+			  dev->region == NL80211_DFS_ETSI;
+	mt7603_init_edcca(dev);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static int
+mt7603_edcca_get(void *data, u64 *val)
+{
+	struct mt7603_dev *dev = data;
+
+	*val = dev->ed_monitor_enabled;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_edcca, mt7603_edcca_get,
+			 mt7603_edcca_set, "%lld\n");
+
 void mt7603_init_debugfs(struct mt7603_dev *dev)
 {
 	struct dentry *dir;
@@ -48,6 +77,7 @@ void mt7603_init_debugfs(struct mt7603_dev *dev)
 	if (!dir)
 		return;
 
+	debugfs_create_file("edcca", 0400, dir, dev, &fops_edcca);
 	debugfs_create_u32("reset_test", 0600, dir, &dev->reset_test);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "reset", dir,
 				    mt7603_reset_read);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 78cdbb70e178..4e269044f8a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -437,7 +437,9 @@ mt7603_regd_notifier(struct wiphy *wiphy,
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct mt7603_dev *dev = hw->priv;
 
-	dev->ed_monitor = request->dfs_region == NL80211_DFS_ETSI;
+	dev->region = request->dfs_region;
+	dev->ed_monitor = dev->ed_monitor_enabled &&
+			  dev->region == NL80211_DFS_ETSI;
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 0a0334dc40d5..e931af92af43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -103,8 +103,7 @@ mt7603_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mutex_unlock(&dev->mt76.mutex);
 }
 
-static void
-mt7603_init_edcca(struct mt7603_dev *dev)
+void mt7603_init_edcca(struct mt7603_dev *dev)
 {
 	/* Set lower signal level to -65dBm */
 	mt76_rmw_field(dev, MT_RXTD(8), MT_RXTD_8_LOWER_SIGNAL, 0x23);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index fa64bbaab0d2..944dc9a11a15 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -117,8 +117,11 @@ struct mt7603_dev {
 	u8 mac_work_count;
 
 	u8 mcu_running;
-	u8 ed_monitor;
 
+	enum nl80211_dfs_regions region;
+
+	u8 ed_monitor_enabled;
+	u8 ed_monitor;
 	s8 ed_trigger;
 	u8 ed_strict_mode;
 	u8 ed_strong_signal;
@@ -241,4 +244,5 @@ void mt7603_update_channel(struct mt76_dev *mdev);
 void mt7603_edcca_set_strict(struct mt7603_dev *dev, bool val);
 void mt7603_cca_stats_reset(struct mt7603_dev *dev);
 
+void mt7603_init_edcca(struct mt7603_dev *dev);
 #endif
-- 
2.20.1

