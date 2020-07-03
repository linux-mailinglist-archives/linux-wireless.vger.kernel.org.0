Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790DB213626
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgGCIQ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgGCIQz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:55 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95196207DA;
        Fri,  3 Jul 2020 08:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764215;
        bh=jvULFGAvrmSfB33dGGiPYjm6+SjE8fc6AELIQa1FfAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jhwDQ4SQmHlldq05CVgCdnMKAAxpnUiTVeUnDyJvswkJnOfkF0+eozxMLQvz2Yfp/
         qlivvLi4W3EM7795KBaxIRME5PHlDdcLLyCVK4NQIar0m1O3rFibwlCDCFTQM7+n3a
         mtWLTQfuftNUQJm1IhtbVAugXLMFKKsH1mkawdJg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 19/22] mt76: mt7615: add runtime-pm knob in mt7615 debugfs
Date:   Fri,  3 Jul 2020 10:15:58 +0200
Message-Id: <70ed3986f368584bb739a4c87460a5332b74804a.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
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
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 20 +++++++++++++++-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 +++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 8894a0ab407b..77889becf22e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -51,6 +51,29 @@ mt7615_scs_get(void *data, u64 *val)
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
@@ -351,6 +374,7 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 	debugfs_create_file("scs", 0600, dir, dev, &fops_scs);
 	debugfs_create_file("dbdc", 0600, dir, dev, &fops_dbdc);
 	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
+	debugfs_create_file("runtime-pm", 0600, dir, dev, &fops_pm);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "radio", dir,
 				    mt7615_radio_read);
 	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 76751117592b..d7c2c08da3c7 100644
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
 
@@ -1928,6 +1929,23 @@ void mt7615_pm_power_save_work(struct work_struct *work)
 				   MT7615_PM_TIMEOUT);
 }
 
+int mt7615_pm_set_enable(struct mt7615_dev *dev, bool enable)
+{
+	if (!mt7615_firmware_offload(dev) || !mt76_is_mmio(&dev->mt76))
+		return -EOPNOTSUPP;
+
+	mt7615_mutex_acquire(dev);
+
+	if (dev->pm.enable == enable)
+		goto out;
+
+	dev->pm.enable = enable;
+out:
+	mt7615_mutex_release(dev);
+
+	return 0;
+}
+
 void mt7615_mac_work(struct work_struct *work)
 {
 	struct mt7615_phy *phy;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 66489f44c1a9..b80bf79e4849 100644
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

