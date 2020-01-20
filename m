Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C30861428B7
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2020 12:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgATLDV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jan 2020 06:03:21 -0500
Received: from nbd.name ([46.4.11.11]:60480 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgATLDU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jan 2020 06:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=L/Cw6kVl3V2T5K3axZgVo9CNCkNJQ0uN4rhwNteh6ZQ=; b=bPNza/QLN0BK4iQOZn+7Wom6yv
        BqxQicQoSD7oeqXZIAO85pfNRTnRph9G6pfSATqJZHO+7Cze5THhCYR1hecA5nBWDKHFaRVnVrZXU
        zqqHkvDf2Ei/r58CcxQIsC/DvAj73AWWbP5dkoy+41G6fjwXq4NhuXOZJM0JHcG/8h3w=;
Received: from [178.162.209.131] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1itUpy-00047K-Up
        for linux-wireless@vger.kernel.org; Mon, 20 Jan 2020 12:03:19 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 4F6A7797DF1D; Mon, 20 Jan 2020 12:03:18 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 28/29] mt76: mt7615: add support for registering a second wiphy via debugfs
Date:   Mon, 20 Jan 2020 12:03:17 +0100
Message-Id: <20200120110317.59811-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-28-nbd@nbd.name>
References: <20191130153045.28105-28-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is only used for testing for now. In the future it will be possible to
enable the second PHY through an proper API via device tree

Running:
 echo 1 > /sys/kernel/debug/ieee80211/phyX/mt76/dbdc

will register a second wiphy (and limit the primary one to 2 spatial streams).
The second wiphy will only be able to run on 5 GHz, while the primary one can
operate in both bands (if supported by the device).

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2:
 - extend commit message
 - fix MAC address of second wiphy

 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  27 ++++
 .../wireless/mediatek/mt76/mt7615/eeprom.c    |   5 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 125 +++++++++++++++---
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   4 +
 4 files changed, 140 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 05a0172b32ce..f75b3f66cdb4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -36,6 +36,32 @@ mt7615_scs_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_scs, mt7615_scs_get,
 			 mt7615_scs_set, "%lld\n");
 
+static int
+mt7615_dbdc_set(void *data, u64 val)
+{
+	struct mt7615_dev *dev = data;
+
+	if (val)
+		mt7615_register_ext_phy(dev);
+	else
+		mt7615_unregister_ext_phy(dev);
+
+	return 0;
+}
+
+static int
+mt7615_dbdc_get(void *data, u64 *val)
+{
+	struct mt7615_dev *dev = data;
+
+	*val = !!mt7615_ext_phy(dev);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_dbdc, mt7615_dbdc_get,
+			 mt7615_dbdc_set, "%lld\n");
+
 static int
 mt7615_ampdu_stat_read(struct seq_file *file, void *data)
 {
@@ -183,6 +209,7 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 				    mt7615_queues_acq);
 	debugfs_create_file("ampdu_stat", 0400, dir, dev, &fops_ampdu_stat);
 	debugfs_create_file("scs", 0600, dir, dev, &fops_scs);
+	debugfs_create_file("dbdc", 0600, dir, dev, &fops_dbdc);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "radio", dir,
 				    mt7615_radio_read);
 	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 61a3fba240ba..e4dcfa531a24 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -124,8 +124,9 @@ static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 	if (!tx_mask || tx_mask > max_nss)
 		tx_mask = max_nss;
 
-	dev->mphy.antenna_mask = BIT(tx_mask) - 1;
-	dev->phy.chainmask = dev->mphy.antenna_mask;
+	dev->chainmask = BIT(tx_mask) - 1;
+	dev->mphy.antenna_mask = dev->chainmask;
+	dev->phy.chainmask = dev->chainmask;
 }
 
 int mt7615_eeprom_get_power_index(struct mt7615_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 78bcdf90ca5e..a14d4d978aad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -256,22 +256,10 @@ mt7615_regd_notifier(struct wiphy *wiphy,
 	mt7615_dfs_init_radar_detector(phy);
 }
 
-int mt7615_register_device(struct mt7615_dev *dev)
+static void
+mt7615_init_wiphy(struct ieee80211_hw *hw)
 {
-	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct wiphy *wiphy = hw->wiphy;
-	int ret;
-
-	dev->phy.dev = dev;
-	dev->phy.mt76 = &dev->mt76.phy;
-	dev->mt76.phy.priv = &dev->phy;
-	INIT_DELAYED_WORK(&dev->mt76.mac_work, mt7615_mac_work);
-	INIT_LIST_HEAD(&dev->sta_poll_list);
-	spin_lock_init(&dev->sta_poll_lock);
-
-	ret = mt7615_init_hardware(dev);
-	if (ret)
-		return ret;
 
 	hw->queues = 4;
 	hw->max_rates = 3;
@@ -290,13 +278,113 @@ int mt7615_register_device(struct mt7615_dev *dev)
 
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
 
+	hw->max_tx_fragments = MT_TXP_MAX_BUF_NUM;
+}
+
+static void
+mt7615_cap_dbdc_enable(struct mt7615_dev *dev)
+{
+	dev->mphy.sband_5g.sband.vht_cap.cap &=
+			~(IEEE80211_VHT_CAP_SHORT_GI_160 |
+			  IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ);
+	if (dev->chainmask == 0xf)
+		dev->mphy.antenna_mask = dev->chainmask >> 2;
+	else
+		dev->mphy.antenna_mask = dev->chainmask >> 1;
+	dev->phy.chainmask = dev->mphy.antenna_mask;
+	mt76_set_stream_caps(&dev->mt76, true);
+}
+
+static void
+mt7615_cap_dbdc_disable(struct mt7615_dev *dev)
+{
+	dev->mphy.sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_SHORT_GI_160 |
+			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
+	dev->mphy.antenna_mask = dev->chainmask;
+	dev->phy.chainmask = dev->chainmask;
+	mt76_set_stream_caps(&dev->mt76, true);
+}
+
+int mt7615_register_ext_phy(struct mt7615_dev *dev)
+{
+	struct mt7615_phy *phy = mt7615_ext_phy(dev);
+	struct mt76_phy *mphy;
+	int ret;
+
+	if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
+		return -EINVAL;
+
+	if (phy)
+		return 0;
+
+	mt7615_cap_dbdc_enable(dev);
+	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7615_ops);
+	if (!mphy)
+		return -ENOMEM;
+
+	phy = mphy->priv;
+	phy->dev = dev;
+	phy->mt76 = mphy;
+	phy->chainmask = dev->chainmask & ~dev->phy.chainmask;
+	mphy->antenna_mask = BIT(hweight8(phy->chainmask)) - 1;
+	mt7615_init_wiphy(mphy->hw);
+
+	/*
+	 * Make the secondary PHY MAC address local without overlapping with
+	 * the usual MAC address allocation scheme on multiple virtual interfaces
+	 */
+	mphy->hw->wiphy->perm_addr[0] |= 2;
+	mphy->hw->wiphy->perm_addr[0] ^= BIT(7);
+
+	/* second phy can only handle 5 GHz */
+	mphy->sband_2g.sband.n_channels = 0;
+	mphy->hw->wiphy->bands[NL80211_BAND_2GHZ] = NULL;
+
+	ret = mt76_register_phy(mphy);
+	if (ret)
+		ieee80211_free_hw(mphy->hw);
+
+	return ret;
+}
+
+void mt7615_unregister_ext_phy(struct mt7615_dev *dev)
+{
+	struct mt7615_phy *phy = mt7615_ext_phy(dev);
+	struct mt76_phy *mphy = dev->mt76.phy2;
+
+	if (!phy)
+		return;
+
+	mt7615_cap_dbdc_disable(dev);
+	mt76_unregister_phy(mphy);
+	ieee80211_free_hw(mphy->hw);
+}
+
+
+int mt7615_register_device(struct mt7615_dev *dev)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	int ret;
+
+	dev->phy.dev = dev;
+	dev->phy.mt76 = &dev->mt76.phy;
+	dev->mt76.phy.priv = &dev->phy;
+	INIT_DELAYED_WORK(&dev->mt76.mac_work, mt7615_mac_work);
+	INIT_LIST_HEAD(&dev->sta_poll_list);
+	spin_lock_init(&dev->sta_poll_lock);
+
+	ret = mt7615_init_hardware(dev);
+	if (ret)
+		return ret;
+
+	mt7615_init_wiphy(hw);
 	dev->mphy.sband_2g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
 	dev->mphy.sband_5g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
 	dev->mphy.sband_5g.sband.vht_cap.cap |=
-			IEEE80211_VHT_CAP_SHORT_GI_160 |
 			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
-			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
-			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
+	mt7615_cap_dbdc_disable(dev);
 	dev->phy.dfs_state = -1;
 
 	ret = mt76_register_device(&dev->mt76, true, mt7615_rates,
@@ -307,8 +395,6 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	mt7615_init_txpower(dev, &dev->mphy.sband_2g.sband);
 	mt7615_init_txpower(dev, &dev->mphy.sband_5g.sband);
 
-	hw->max_tx_fragments = MT_TXP_MAX_BUF_NUM;
-
 	return mt7615_init_debugfs(dev);
 }
 
@@ -317,6 +403,7 @@ void mt7615_unregister_device(struct mt7615_dev *dev)
 	struct mt76_txwi_cache *txwi;
 	int id;
 
+	mt7615_unregister_ext_phy(dev);
 	mt76_unregister_device(&dev->mt76);
 	mt7615_mcu_exit(dev);
 	mt7615_dma_cleanup(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 2adf3b8a61b8..32f23f5fdd58 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -115,6 +115,8 @@ struct mt7615_dev {
 	u32 vif_mask;
 	u32 omac_mask;
 
+	u16 chainmask;
+
 	struct list_head sta_poll_list;
 	spinlock_t sta_poll_lock;
 
@@ -211,6 +213,8 @@ u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr);
 
 int mt7615_register_device(struct mt7615_dev *dev);
 void mt7615_unregister_device(struct mt7615_dev *dev);
+int mt7615_register_ext_phy(struct mt7615_dev *dev);
+void mt7615_unregister_ext_phy(struct mt7615_dev *dev);
 int mt7615_eeprom_init(struct mt7615_dev *dev);
 int mt7615_eeprom_get_power_index(struct mt7615_dev *dev,
 				  struct ieee80211_channel *chan,
-- 
2.24.0

