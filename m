Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D021211ECF7
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 22:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfLMVgc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 16:36:32 -0500
Received: from nbd.name ([46.4.11.11]:47440 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfLMVgc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 16:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2PREsdNUvdpP/Oi6rxARjgr79fk0UsoMfCb1Yxu5VJM=; b=J1kTXxKerf4YVxAEp4yj3sFutv
        BrNAX53+Ya4HyFSjv5dLaJHPbp/zzLfL+4ZA763t30xvdX4h7xpLuFFrssxv2EEug6lAWOF+2sHgs
        uYLbnu1D7uANhAsteubz46XIByM+30UCoNLQGzei8fE+D5btqmqgN8CJ78qIAb7Mf68U=;
Received: from p4ff13e83.dip0.t-ipconnect.de ([79.241.62.131] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ifsbt-0001nV-U0
        for linux-wireless@vger.kernel.org; Fri, 13 Dec 2019 22:36:30 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 1C77073C113E; Fri, 13 Dec 2019 22:36:28 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/4] mt76: mt7615: defer mcu initialization via workqueue
Date:   Fri, 13 Dec 2019 22:36:25 +0100
Message-Id: <20191213213628.73840-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loading the mcu firmware and waiting for it to boot takes a long time,
which adds a significant amount to the system boot time.
Fix this by running the mcu init from a workqueue and waiting for it to
complete before starting the phy or issuing mcu commands via debugfs

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 12 ++++++
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 37 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  3 ++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 ++
 4 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index f75b3f66cdb4..783f145b7d02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -7,6 +7,9 @@ mt7615_radar_pattern_set(void *data, u64 val)
 {
 	struct mt7615_dev *dev = data;
 
+	if (!mt7615_wait_for_mcu_init(dev))
+		return 0;
+
 	return mt7615_mcu_rdd_send_pattern(dev);
 }
 
@@ -18,6 +21,9 @@ mt7615_scs_set(void *data, u64 val)
 {
 	struct mt7615_dev *dev = data;
 
+	if (!mt7615_wait_for_mcu_init(dev))
+		return 0;
+
 	mt7615_mac_set_scs(dev, val);
 
 	return 0;
@@ -41,6 +47,9 @@ mt7615_dbdc_set(void *data, u64 val)
 {
 	struct mt7615_dev *dev = data;
 
+	if (!mt7615_wait_for_mcu_init(dev))
+		return 0;
+
 	if (val)
 		mt7615_register_ext_phy(dev);
 	else
@@ -131,6 +140,9 @@ static int mt7615_read_temperature(struct seq_file *s, void *data)
 	struct mt7615_dev *dev = dev_get_drvdata(s->private);
 	int temp;
 
+	if (!mt7615_wait_for_mcu_init(dev))
+		return 0;
+
 	/* cpu */
 	temp = mt7615_mcu_get_temperature(dev, 0);
 	seq_printf(s, "Temperature: %d\n", temp);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index a37562965f41..c1e437e031b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -104,12 +104,33 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0, MT_WF_RMAC_MIB_RXTIME_EN);
 }
 
+bool mt7615_wait_for_mcu_init(struct mt7615_dev *dev)
+{
+	flush_work(&dev->mcu_work);
+
+	return test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+}
+
+static void mt7615_init_work(struct work_struct *work)
+{
+	struct mt7615_dev *dev = container_of(work, struct mt7615_dev, mcu_work);
+
+	if (mt7615_mcu_init(dev))
+		return;
+
+	mt7615_mcu_set_eeprom(dev);
+	mt7615_mac_init(dev);
+	mt7615_phy_init(dev);
+	mt7615_mcu_del_wtbl_all(dev);
+}
+
 static int mt7615_init_hardware(struct mt7615_dev *dev)
 {
 	int ret, idx;
 
 	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
 
+	INIT_WORK(&dev->mcu_work, mt7615_init_work);
 	spin_lock_init(&dev->token_lock);
 	idr_init(&dev->token);
 
@@ -123,15 +144,6 @@ static int mt7615_init_hardware(struct mt7615_dev *dev)
 
 	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
-	ret = mt7615_mcu_init(dev);
-	if (ret)
-		return ret;
-
-	mt7615_mcu_set_eeprom(dev);
-	mt7615_mac_init(dev);
-	mt7615_phy_init(dev);
-	mt7615_mcu_del_wtbl_all(dev);
-
 	/* Beacon and mgmt frames should occupy wcid 0 */
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7615_WTBL_STA - 1);
 	if (idx)
@@ -385,6 +397,7 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
+	ieee80211_queue_work(mt76_hw(dev), &dev->mcu_work);
 	mt7615_init_txpower(dev, &dev->mphy.sband_2g.sband);
 	mt7615_init_txpower(dev, &dev->mphy.sband_5g.sband);
 
@@ -394,11 +407,15 @@ int mt7615_register_device(struct mt7615_dev *dev)
 void mt7615_unregister_device(struct mt7615_dev *dev)
 {
 	struct mt76_txwi_cache *txwi;
+	bool mcu_running;
 	int id;
 
+	mcu_running = mt7615_wait_for_mcu_init(dev);
+
 	mt7615_unregister_ext_phy(dev);
 	mt76_unregister_device(&dev->mt76);
-	mt7615_mcu_exit(dev);
+	if (mcu_running)
+		mt7615_mcu_exit(dev);
 	mt7615_dma_cleanup(dev);
 
 	spin_lock_bh(&dev->token_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index ef14779fdbc4..c6a0ca1034c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -30,6 +30,9 @@ static int mt7615_start(struct ieee80211_hw *hw)
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 	bool running;
 
+	if (!mt7615_wait_for_mcu_init(dev))
+		return -EIO;
+
 	mutex_lock(&dev->mt76.mutex);
 
 	running = mt7615_dev_running(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 32f23f5fdd58..b4d6727cf285 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -117,6 +117,8 @@ struct mt7615_dev {
 
 	u16 chainmask;
 
+	struct work_struct mcu_work;
+
 	struct list_head sta_poll_list;
 	spinlock_t sta_poll_lock;
 
@@ -222,6 +224,7 @@ int mt7615_eeprom_get_power_index(struct mt7615_dev *dev,
 int mt7615_dma_init(struct mt7615_dev *dev);
 void mt7615_dma_cleanup(struct mt7615_dev *dev);
 int mt7615_mcu_init(struct mt7615_dev *dev);
+bool mt7615_wait_for_mcu_init(struct mt7615_dev *dev);
 int mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
 			    struct ieee80211_vif *vif, bool enable);
 int mt7615_mcu_set_bss_info(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-- 
2.24.0

