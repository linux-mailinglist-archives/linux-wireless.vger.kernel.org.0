Return-Path: <linux-wireless+bounces-17021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746BB9FFBE8
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E1A3A42C6
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57203156871;
	Thu,  2 Jan 2025 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="uh2NQgzl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205D176242
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835732; cv=none; b=jgKqOlDc0e3894EC/hH1lEdS6mr5lCfsOAjazxf9oZKDPL5UjbWBGiYyDJCfSGu2XKuNJPWRVilOCUOzu3Bm3E9G9Vpj2gXbxxbvAF1rRoDMtCCJ2aQ+Thb9cwMC2FuMHjivOY0dOLAmJfdEBILwtkVYEtcIAOZ+Twx0mcvlUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835732; c=relaxed/simple;
	bh=JYJeqpj7Jb7+C5xYqxSqxdgbn86QTTinn76NED9VFqs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amk6OzW0KvEMKoiO/4cJG55pJv1OWQ0zn48Nwka+joEpJXrwitLA8FwW3TIWxQd6Im8BTQyyiT3pGDsgStTUW7aK2GwmHDTaSRZX+uoTNEwj9XmP8XygzSS4BDmk5vNdXt0oxqSlyKNxALu1ZgTMqc1RT366ZVb/BnCte6AKNo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=uh2NQgzl; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WasVNhyw6jyr/ngru/UVkzGlgcjoXsvHOp/TCI4ZKZs=; b=uh2NQgzlWedJunEWxhFBMbNth3
	GKJiut5NIX/A1MRefM8qLyCISBbptpCAa/ousDRIckId+6v6IWmQqtpwSv1KSHyN6XlftTQ+HCHuS
	mXD7saUIOKmOr8qtVIeTFSx4J1uKgK/aICe8OsNhWIf+2XpUoNINxqBcXJhaTzwfhIa4=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAE-0008GS-33
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:15 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 22/24] wifi: mt76: mt7996: move all debugfs files to the primary phy
Date: Thu,  2 Jan 2025 17:35:06 +0100
Message-ID: <20250102163508.52945-22-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102163508.52945-1-nbd@nbd.name>
References: <20250102163508.52945-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparation for single-wiphy support

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7996/debugfs.c   | 144 +++++++++++-------
 .../net/wireless/mediatek/mt76/mt7996/init.c  |   6 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   2 +-
 3 files changed, 89 insertions(+), 63 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 335699405ac7..7b2bb72b407d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -51,12 +51,10 @@ static ssize_t
 mt7996_sys_recovery_set(struct file *file, const char __user *user_buf,
 			size_t count, loff_t *ppos)
 {
-	struct mt7996_phy *phy = file->private_data;
-	struct mt7996_dev *dev = phy->dev;
-	bool band = phy->mt76->band_idx;
-	char buf[16];
+	struct mt7996_dev *dev = file->private_data;
+	char buf[16], *sep;
 	int ret = 0;
-	u16 val;
+	u16 band, val;
 
 	if (count >= sizeof(buf))
 		return -EINVAL;
@@ -69,21 +67,26 @@ mt7996_sys_recovery_set(struct file *file, const char __user *user_buf,
 	else
 		buf[count] = '\0';
 
-	if (kstrtou16(buf, 0, &val))
+	sep = strchr(buf, ',');
+	if (!sep)
+		return -EINVAL;
+
+	*sep = 0;
+	if (kstrtou16(buf, 0, &band) || kstrtou16(sep + 1, 0, &val))
 		return -EINVAL;
 
 	switch (val) {
 	/*
-	 * 0: grab firmware current SER state.
-	 * 1: trigger & enable system error L1 recovery.
-	 * 2: trigger & enable system error L2 recovery.
-	 * 3: trigger & enable system error L3 rx abort.
-	 * 4: trigger & enable system error L3 tx abort
-	 * 5: trigger & enable system error L3 tx disable.
-	 * 6: trigger & enable system error L3 bf recovery.
-	 * 7: trigger & enable system error L4 mdp recovery.
-	 * 8: trigger & enable system error full recovery.
-	 * 9: trigger firmware crash.
+	 * <band>,0: grab firmware current SER state.
+	 * <band>,1: trigger & enable system error L1 recovery.
+	 * <band>,2: trigger & enable system error L2 recovery.
+	 * <band>,3: trigger & enable system error L3 rx abort.
+	 * <band>,4: trigger & enable system error L3 tx abort
+	 * <band>,5: trigger & enable system error L3 tx disable.
+	 * <band>,6: trigger & enable system error L3 bf recovery.
+	 * <band>,7: trigger & enable system error L4 mdp recovery.
+	 * <band>,8: trigger & enable system error full recovery.
+	 * <band>,9: trigger firmware crash.
 	 */
 	case UNI_CMD_SER_QUERY:
 		ret = mt7996_mcu_set_ser(dev, UNI_CMD_SER_QUERY, 0, band);
@@ -126,8 +129,7 @@ static ssize_t
 mt7996_sys_recovery_get(struct file *file, char __user *user_buf,
 			size_t count, loff_t *ppos)
 {
-	struct mt7996_phy *phy = file->private_data;
-	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_dev *dev = file->private_data;
 	char *buff;
 	int desc = 0;
 	ssize_t ret;
@@ -141,25 +143,25 @@ mt7996_sys_recovery_get(struct file *file, char __user *user_buf,
 	desc += scnprintf(buff + desc, bufsz - desc,
 			  "Please echo the correct value ...\n");
 	desc += scnprintf(buff + desc, bufsz - desc,
-			  "0: grab firmware transient SER state\n");
+			  "<band>,0: grab firmware transient SER state\n");
 	desc += scnprintf(buff + desc, bufsz - desc,
-			  "1: trigger system error L1 recovery\n");
+			  "<band>,1: trigger system error L1 recovery\n");
 	desc += scnprintf(buff + desc, bufsz - desc,
-			  "2: trigger system error L2 recovery\n");
+			  "<band>,2: trigger system error L2 recovery\n");
 	desc += scnprintf(buff + desc, bufsz - desc,
-			  "3: trigger system error L3 rx abort\n");
+			  "<band>,3: trigger system error L3 rx abort\n");
 	desc += scnprintf(buff + desc, bufsz - desc,
-			  "4: trigger system error L3 tx abort\n");
+			  "<band>,4: trigger system error L3 tx abort\n");
 	desc += scnprintf(buff + desc, bufsz - desc,
-			  "5: trigger system error L3 tx disable\n");
+			  "<band>,5: trigger system error L3 tx disable\n");
 	desc += scnprintf(buff + desc, bufsz - desc,
-			  "6: trigger system error L3 bf recovery\n");
+			  "<band>,6: trigger system error L3 bf recovery\n");
 	desc += scnprintf(buff + desc, bufsz - desc,
-			  "7: trigger system error L4 mdp recovery\n");
+			  "<band>,7: trigger system error L4 mdp recovery\n");
 	desc += scnprintf(buff + desc, bufsz - desc,
-			  "8: trigger system error full recovery\n");
+			  "<band>,8: trigger system error full recovery\n");
 	desc += scnprintf(buff + desc, bufsz - desc,
-			  "9: trigger firmware crash\n");
+			  "<band>,9: trigger firmware crash\n");
 
 	/* SER statistics */
 	desc += scnprintf(buff + desc, bufsz - desc,
@@ -524,16 +526,12 @@ mt7996_txbf_stat_read_phy(struct mt7996_phy *phy, struct seq_file *s)
 	seq_puts(s, "\n");
 }
 
-static int
-mt7996_tx_stats_show(struct seq_file *file, void *data)
+static void
+mt7996_tx_stats_show_phy(struct seq_file *file, struct mt7996_phy *phy)
 {
-	struct mt7996_phy *phy = file->private;
-	struct mt7996_dev *dev = phy->dev;
 	struct mt76_mib_stats *mib = &phy->mib;
-	int i;
 	u32 attempts, success, per;
-
-	mutex_lock(&dev->mt76.mutex);
+	int i;
 
 	mt7996_mac_update_stats(phy);
 	mt7996_ampdu_stat_read_phy(phy, file);
@@ -558,6 +556,23 @@ mt7996_tx_stats_show(struct seq_file *file, void *data)
 		else
 			seq_puts(file, "\n");
 	}
+}
+
+static int
+mt7996_tx_stats_show(struct seq_file *file, void *data)
+{
+	struct mt7996_dev *dev = file->private;
+	struct mt7996_phy *phy = &dev->phy;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	mt7996_tx_stats_show_phy(file, phy);
+	phy = mt7996_phy2(dev);
+	if (phy)
+		mt7996_tx_stats_show_phy(file, phy);
+	phy = mt7996_phy3(dev);
+	if (phy)
+		mt7996_tx_stats_show_phy(file, phy);
 
 	mutex_unlock(&dev->mt76.mutex);
 
@@ -628,8 +643,8 @@ mt7996_sta_hw_queue_read(void *data, struct ieee80211_sta *sta)
 static int
 mt7996_hw_queues_show(struct seq_file *file, void *data)
 {
-	struct mt7996_phy *phy = file->private;
-	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_dev *dev = file->private;
+	struct mt7996_phy *phy = &dev->phy;
 	static const struct hw_queue_map ple_queue_map[] = {
 		{ "CPU_Q0",  0,  1, MT_CTX0	      },
 		{ "CPU_Q1",  1,  1, MT_CTX0 + 1	      },
@@ -685,6 +700,15 @@ mt7996_hw_queues_show(struct seq_file *file, void *data)
 	/* iterate per-sta ple queue */
 	ieee80211_iterate_stations_atomic(phy->mt76->hw,
 					  mt7996_sta_hw_queue_read, file);
+	phy = mt7996_phy2(dev);
+	if (phy)
+		ieee80211_iterate_stations_atomic(phy->mt76->hw,
+						  mt7996_sta_hw_queue_read, file);
+	phy = mt7996_phy3(dev);
+	if (phy)
+		ieee80211_iterate_stations_atomic(phy->mt76->hw,
+						  mt7996_sta_hw_queue_read, file);
+
 	/* pse queue */
 	seq_puts(file, "PSE non-empty queue info:\n");
 	mt7996_hw_queue_read(file, ARRAY_SIZE(pse_queue_map),
@@ -698,19 +722,29 @@ DEFINE_SHOW_ATTRIBUTE(mt7996_hw_queues);
 static int
 mt7996_xmit_queues_show(struct seq_file *file, void *data)
 {
-	struct mt7996_phy *phy = file->private;
-	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_dev *dev = file->private;
+	struct mt7996_phy *phy;
 	struct {
 		struct mt76_queue *q;
 		char *queue;
 	} queue_map[] = {
-		{ phy->mt76->q_tx[MT_TXQ_BE],	 "   MAIN"  },
+		{ dev->mphy.q_tx[MT_TXQ_BE],	 "  MAIN0"  },
+		{ NULL,				 "  MAIN1"  },
+		{ NULL,				 "  MAIN2"  },
 		{ dev->mt76.q_mcu[MT_MCUQ_WM],	 "  MCUWM"  },
 		{ dev->mt76.q_mcu[MT_MCUQ_WA],	 "  MCUWA"  },
 		{ dev->mt76.q_mcu[MT_MCUQ_FWDL], "MCUFWDL" },
 	};
 	int i;
 
+	phy = mt7996_phy2(dev);
+	if (phy)
+		queue_map[1].q = phy->mt76->q_tx[MT_TXQ_BE];
+
+	phy = mt7996_phy3(dev);
+	if (phy)
+		queue_map[2].q = phy->mt76->q_tx[MT_TXQ_BE];
+
 	seq_puts(file, "     queue | hw-queued |      head |      tail |\n");
 	for (i = 0; i < ARRAY_SIZE(queue_map); i++) {
 		struct mt76_queue *q = queue_map[i].q;
@@ -785,20 +819,20 @@ mt7996_rf_regval_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_rf_regval, mt7996_rf_regval_get,
 			 mt7996_rf_regval_set, "0x%08llx\n");
 
-int mt7996_init_debugfs(struct mt7996_phy *phy)
+int mt7996_init_debugfs(struct mt7996_dev *dev)
 {
-	struct mt7996_dev *dev = phy->dev;
 	struct dentry *dir;
 
-	dir = mt76_register_debugfs_fops(phy->mt76, NULL);
+	dir = mt76_register_debugfs_fops(&dev->mphy, NULL);
 	if (!dir)
 		return -ENOMEM;
-	debugfs_create_file("hw-queues", 0400, dir, phy,
+
+	debugfs_create_file("hw-queues", 0400, dir, dev,
 			    &mt7996_hw_queues_fops);
-	debugfs_create_file("xmit-queues", 0400, dir, phy,
+	debugfs_create_file("xmit-queues", 0400, dir, dev,
 			    &mt7996_xmit_queues_fops);
-	debugfs_create_file("tx_stats", 0400, dir, phy, &mt7996_tx_stats_fops);
-	debugfs_create_file("sys_recovery", 0600, dir, phy,
+	debugfs_create_file("tx_stats", 0400, dir, dev, &mt7996_tx_stats_fops);
+	debugfs_create_file("sys_recovery", 0600, dir, dev,
 			    &mt7996_sys_recovery_ops);
 	debugfs_create_file("fw_debug_wm", 0600, dir, dev, &fops_fw_debug_wm);
 	debugfs_create_file("fw_debug_wa", 0600, dir, dev, &fops_fw_debug_wa);
@@ -812,17 +846,13 @@ int mt7996_init_debugfs(struct mt7996_phy *phy)
 				    mt7996_twt_stats);
 	debugfs_create_file("rf_regval", 0600, dir, dev, &fops_rf_regval);
 
-	if (phy->mt76->cap.has_5ghz) {
-		debugfs_create_u32("dfs_hw_pattern", 0400, dir,
-				   &dev->hw_pattern);
-		debugfs_create_file("radar_trigger", 0200, dir, dev,
-				    &fops_radar_trigger);
-		debugfs_create_devm_seqfile(dev->mt76.dev, "rdd_monitor", dir,
-					    mt7996_rdd_monitor);
-	}
+	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
+	debugfs_create_file("radar_trigger", 0200, dir, dev,
+			    &fops_radar_trigger);
+	debugfs_create_devm_seqfile(dev->mt76.dev, "rdd_monitor", dir,
+				    mt7996_rdd_monitor);
 
-	if (phy == &dev->phy)
-		dev->debugfs_dir = dir;
+	dev->debugfs_dir = dir;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 1ebac1905c22..a28933659c01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -633,10 +633,6 @@ static int mt7996_register_phy(struct mt7996_dev *dev, struct mt7996_phy *phy,
 	if (ret)
 		goto error;
 
-	ret = mt7996_init_debugfs(phy);
-	if (ret)
-		goto error;
-
 	if (wed == &dev->mt76.mmio.wed_hif2 && mtk_wed_device_active(wed)) {
 		u32 irq_mask = dev->mt76.mmio.irqmask | MT_INT_TX_DONE_BAND2;
 
@@ -1461,7 +1457,7 @@ int mt7996_register_device(struct mt7996_dev *dev)
 
 	dev->recovery.hw_init_done = true;
 
-	ret = mt7996_init_debugfs(&dev->phy);
+	ret = mt7996_init_debugfs(dev);
 	if (ret)
 		goto error;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 0774ffdde65d..f1384e4e7e7f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -680,7 +680,7 @@ int mt7996_dfs_init_radar_detector(struct mt7996_phy *phy);
 void mt7996_set_stream_he_eht_caps(struct mt7996_phy *phy);
 void mt7996_set_stream_vht_txbf_caps(struct mt7996_phy *phy);
 void mt7996_update_channel(struct mt76_phy *mphy);
-int mt7996_init_debugfs(struct mt7996_phy *phy);
+int mt7996_init_debugfs(struct mt7996_dev *dev);
 void mt7996_debugfs_rx_fw_monitor(struct mt7996_dev *dev, const void *data, int len);
 bool mt7996_debugfs_rx_log(struct mt7996_dev *dev, const void *data, int len);
 int mt7996_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
-- 
2.47.1


