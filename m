Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF7320BB79
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 23:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgFZVZ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 17:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgFZVZ6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 17:25:58 -0400
Received: from localhost.localdomain.com (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C07D20B80;
        Fri, 26 Jun 2020 21:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593206757;
        bh=2Hmhq3wzP1gA0bSghnIl/mgLX+Tpgs8h4BrhEVV7eTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SilLbHrOdlYEw93QlkKcZmgpGXW5I0Mdkgy5N+AOzV6nl8d09K9EtLdxHQ+MZQaW1
         j1sGHCxpWhiUrKNL51SYNHzk92cNFNvBymKz7HTLwMu6KOc+ZTiXO6HZx/EhM40GMd
         RuK58r/afABlBHDDWSj5Z6MtoPcjeA4uhrgT9QdM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 14/17] mt76: mt7615: add runtime-pm knob in mt7615 debugfs
Date:   Fri, 26 Jun 2020 23:25:14 +0200
Message-Id: <dae84ea915466ecc24cc74c77805cabdfc62dc17.1593204577.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593204577.git.lorenzo@kernel.org>
References: <cover.1593204577.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce runtime-pm knob in mt7615 debugfs in order to enable/disable
runtime pm available in offload firmware

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 24 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 22 ++++++++++++++++-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 +++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index b4c196005ebf..357b3c2fc3f9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -46,6 +46,29 @@ mt7615_scs_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_scs, mt7615_scs_get,
 			 mt7615_scs_set, "%lld\n");
 
+static int
+mt7615_pm_set(void *data, u64 val)
+{
+	struct mt7615_dev *dev = data;
+
+	if (!mt7615_wait_for_mcu_init(dev))
+		return 0;
+
+	return mt7615_pm_set_enable(dev, val);
+}
+
+static int
+mt7615_pm_get(void *data, u64 *val)
+{
+	struct mt7615_dev *dev = data;
+
+	*val = dev->pm.enable;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_pm, mt7615_pm_get, mt7615_pm_set, "%lld\n");
+
 static int
 mt7615_dbdc_set(void *data, u64 val)
 {
@@ -336,6 +359,7 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 	debugfs_create_file("scs", 0600, dir, dev, &fops_scs);
 	debugfs_create_file("dbdc", 0600, dir, dev, &fops_dbdc);
 	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
+	debugfs_create_file("runtime-pm", 0600, dir, dev, &fops_pm);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "radio", dir,
 				    mt7615_radio_read);
 	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 8616bac97963..d3e3112359e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1905,7 +1905,8 @@ void mt7615_pm_power_save_sched(struct mt7615_dev *dev)
 {
 	struct mt76_phy *mphy = dev->phy.mt76;
 
-	if (!mt7615_firmware_offload(dev) || !mt76_is_mmio(mphy->dev) ||
+	if (!mt7615_firmware_offload(dev) ||
+	    !dev->pm.enable || !mt76_is_mmio(mphy->dev) ||
 	    !test_bit(MT76_STATE_RUNNING, &mphy->state))
 		return;
 
@@ -1928,6 +1929,25 @@ void mt7615_pm_power_save_work(struct work_struct *work)
 				   MT7615_PM_TIMEOUT);
 }
 
+int mt7615_pm_set_enable(struct mt7615_dev *dev, bool enable)
+{
+	if (!mt7615_firmware_offload(dev) || !mt76_is_mmio(&dev->mt76))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (dev->pm.enable == enable)
+		goto out;
+
+	dev->pm.enable = enable;
+	if (!enable)
+		cancel_delayed_work_sync(&dev->pm.ps_work);
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
 void mt7615_mac_work(struct work_struct *work)
 {
 	struct mt7615_phy *phy;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 6da0af628c8d..02282b1a00b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -300,6 +300,8 @@ struct mt7615_dev {
 #endif
 
 	struct {
+		bool enable;
+
 		spinlock_t txq_lock;
 		struct {
 			struct mt7615_sta *msta;
@@ -441,6 +443,7 @@ bool mt7615_wait_for_mcu_init(struct mt7615_dev *dev);
 void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates);
+int mt7615_pm_set_enable(struct mt7615_dev *dev, bool enable);
 void mt7615_pm_wake_work(struct work_struct *work);
 int mt7615_pm_wake(struct mt7615_dev *dev);
 void mt7615_pm_power_save_sched(struct mt7615_dev *dev);
-- 
2.26.2

