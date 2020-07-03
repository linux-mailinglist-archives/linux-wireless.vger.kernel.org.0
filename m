Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1A1213628
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGCIRA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgGCIQ7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:59 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34C41207DA;
        Fri,  3 Jul 2020 08:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764218;
        bh=sVgBzaRXJyQbarGCE2r9eyGTKuI8Kk1vaXNIUmMHN04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLAnA30Efs0EFkYNFAMG45m3q0Wx6vwR9ufXQncN6JjrGConcvSNcS63AJ2zP2wbX
         2XMhqFErUJELaZUrYIBembM3coRT2L80OSnGYPUIRxBXCFrZTobJT8YDCIppgEnhtI
         IgoUz5cqaHODth4LuZTD/osCEnXuiuJuEveIaAsg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 21/22] mt76: mt7615: add idle-timeout knob in mt7615 debugfs
Date:   Fri,  3 Jul 2020 10:16:00 +0200
Message-Id: <081a96d82990dfcf9625b0f3602921da7146d5b4.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce idle-timeout knob in mt7615 debugfs in order to configure the
idle time to switch to low-power state

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 25 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  4 +--
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 +
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 77889becf22e..88931658a9fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -74,6 +74,29 @@ mt7615_pm_get(void *data, u64 *val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_pm, mt7615_pm_get, mt7615_pm_set, "%lld\n");
 
+static int
+mt7615_pm_idle_timeout_set(void *data, u64 val)
+{
+	struct mt7615_dev *dev = data;
+
+	dev->pm.idle_timeout = msecs_to_jiffies(val);
+
+	return 0;
+}
+
+static int
+mt7615_pm_idle_timeout_get(void *data, u64 *val)
+{
+	struct mt7615_dev *dev = data;
+
+	*val = jiffies_to_msecs(dev->pm.idle_timeout);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_pm_idle_timeout, mt7615_pm_idle_timeout_get,
+			 mt7615_pm_idle_timeout_set, "%lld\n");
+
 static int
 mt7615_dbdc_set(void *data, u64 val)
 {
@@ -375,6 +398,8 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 	debugfs_create_file("dbdc", 0600, dir, dev, &fops_dbdc);
 	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
 	debugfs_create_file("runtime-pm", 0600, dir, dev, &fops_pm);
+	debugfs_create_file("idle-timeout", 0600, dir, dev,
+			    &fops_pm_idle_timeout);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "radio", dir,
 				    mt7615_radio_read);
 	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 0b305c62bbbd..a147891953a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -465,6 +465,7 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	timer_setup(&dev->phy.roc_timer, mt7615_roc_timer, 0);
 
 	mt7615_init_wiphy(hw);
+	dev->pm.idle_timeout = MT7615_PM_TIMEOUT;
 	dev->mphy.sband_2g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
 	dev->mphy.sband_5g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
 	dev->mphy.sband_5g.sband.vht_cap.cap |=
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index bdd9b66ca47d..fa7a4148ab07 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1913,7 +1913,7 @@ void mt7615_pm_power_save_sched(struct mt7615_dev *dev)
 	dev->pm.last_activity = jiffies;
 	if (!test_bit(MT76_STATE_PM, &mphy->state))
 		queue_delayed_work(dev->mt76.wq, &dev->pm.ps_work,
-				   MT7615_PM_TIMEOUT);
+				   dev->pm.idle_timeout);
 }
 EXPORT_SYMBOL_GPL(mt7615_pm_power_save_sched);
 
@@ -1926,7 +1926,7 @@ void mt7615_pm_power_save_work(struct work_struct *work)
 
 	if (mt7615_firmware_own(dev))
 		queue_delayed_work(dev->mt76.wq, &dev->pm.ps_work,
-				   MT7615_PM_TIMEOUT);
+				   dev->pm.idle_timeout);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 46a2a38d0b1f..e60fb52ad1d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -313,6 +313,7 @@ struct mt7615_dev {
 
 		struct delayed_work ps_work;
 		unsigned long last_activity;
+		unsigned long idle_timeout;
 	} pm;
 };
 
-- 
2.26.2

