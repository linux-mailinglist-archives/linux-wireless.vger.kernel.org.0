Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997EC5AA33
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2019 12:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfF2Kgc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jun 2019 06:36:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfF2Kgb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jun 2019 06:36:31 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A721D2086D;
        Sat, 29 Jun 2019 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561804590;
        bh=Bt2ZCcPd4Fuj3abN3kRhS6e906+cjNJFbHIrAPCVW1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXarQc6Aj66Qm57jKjPpJYuoqYx40cdZ4sA4Fpz4y2glgABI9GxMqCnt34wnMv7D1
         nVkp3qgay8dbAk1X6WGAO1IZf55Lee7uqStnlUWGOlNMq7zGluuxae+FUdjPSk/mXL
         zG/4GEZI/LUuk/evLtTG7Zcuq6i8DJuJOG/QOHGM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com, yf.luo@mediatek.com
Subject: [PATCH 2/6] mt76: mt7615: add hw dfs pattern detector support
Date:   Sat, 29 Jun 2019 12:36:07 +0200
Message-Id: <6aa80924b1947d8a5b7a62023b04d019fff0d90a.1561804422.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561804422.git.lorenzo@kernel.org>
References: <cover.1561804422.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add hw radar detection support to mt7615 driver in order to
unlock dfs channels on 5GHz band

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 17 ++++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 88 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  6 ++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 65 ++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 22 +++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    | 46 ++++++++++
 7 files changed, 245 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 6a70273d4a69..3fe24d92d4fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -76,7 +76,7 @@ void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		mt7615_mac_tx_free(dev, skb);
 		break;
 	case PKT_TYPE_RX_EVENT:
-		mt76_mcu_rx_event(&dev->mt76, skb);
+		mt7615_mcu_rx_event(dev, skb);
 		break;
 	case PKT_TYPE_NORMAL:
 		if (!mt7615_mac_fill_rx(dev, skb)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index edce96ce79a4..5dc4cced5789 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -163,6 +163,8 @@ static int mt7615_init_debugfs(struct mt7615_dev *dev)
 	if (!dir)
 		return -ENOMEM;
 
+	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
+
 	return 0;
 }
 
@@ -214,8 +216,22 @@ mt7615_regd_notifier(struct wiphy *wiphy,
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct mt7615_dev *dev = hw->priv;
+	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
+
+	if (request->dfs_region == dev->mt76.region)
+		return;
 
 	dev->mt76.region = request->dfs_region;
+
+	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
+		return;
+
+	mt7615_dfs_stop_radar_detector(dev);
+	if (request->dfs_region == NL80211_DFS_UNSET)
+		mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, MT_HW_RDD0,
+				   MT_RX_SEL0, 0);
+	else
+		mt7615_dfs_start_radar_detector(dev);
 }
 
 int mt7615_register_device(struct mt7615_dev *dev)
@@ -254,6 +270,7 @@ int mt7615_register_device(struct mt7615_dev *dev)
 			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
 	dev->mt76.chainmask = 0x404;
 	dev->mt76.antenna_mask = 0xf;
+	dev->dfs_state = -1;
 
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 #ifdef CONFIG_MAC80211_MESH
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 1eb0e9c9970c..08cc3f46b011 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -746,3 +746,91 @@ void mt7615_mac_work(struct work_struct *work)
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
 				     MT7615_WATCHDOG_TIME);
 }
+
+int mt7615_dfs_stop_radar_detector(struct mt7615_dev *dev)
+{
+	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
+	int err;
+
+	err = mt7615_mcu_rdd_cmd(dev, RDD_STOP, MT_HW_RDD0,
+				 MT_RX_SEL0, 0);
+	if (err < 0)
+		return err;
+
+	if (chandef->width == NL80211_CHAN_WIDTH_160 ||
+	    chandef->width == NL80211_CHAN_WIDTH_80P80)
+		err = mt7615_mcu_rdd_cmd(dev, RDD_STOP, MT_HW_RDD1,
+					 MT_RX_SEL0, 0);
+	return err;
+}
+
+static int mt7615_dfs_start_rdd(struct mt7615_dev *dev, int chain)
+{
+	int err;
+
+	err = mt7615_mcu_rdd_cmd(dev, RDD_START, chain, MT_RX_SEL0, 0);
+	if (err < 0)
+		return err;
+
+	return mt7615_mcu_rdd_cmd(dev, RDD_DET_MODE, chain,
+				  MT_RX_SEL0, 1);
+}
+
+int mt7615_dfs_start_radar_detector(struct mt7615_dev *dev)
+{
+	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
+	int err;
+
+	/* start CAC */
+	err = mt7615_mcu_rdd_cmd(dev, RDD_CAC_START, MT_HW_RDD0,
+				 MT_RX_SEL0, 0);
+	if (err < 0)
+		return err;
+
+	/* TODO: DBDC support */
+
+	err = mt7615_dfs_start_rdd(dev, MT_HW_RDD0);
+	if (err < 0)
+		return err;
+
+	if (chandef->width == NL80211_CHAN_WIDTH_160 ||
+	    chandef->width == NL80211_CHAN_WIDTH_80P80) {
+		err = mt7615_dfs_start_rdd(dev, MT_HW_RDD1);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+int mt7615_dfs_init_radar_detector(struct mt7615_dev *dev)
+{
+	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
+	int err;
+
+	if (dev->mt76.region == NL80211_DFS_UNSET)
+		return 0;
+
+	if (test_bit(MT76_SCANNING, &dev->mt76.state))
+		return 0;
+
+	if (dev->dfs_state == chandef->chan->dfs_state)
+		return 0;
+
+	dev->dfs_state = chandef->chan->dfs_state;
+
+	if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
+		if (chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
+			return mt7615_dfs_start_radar_detector(dev);
+		else
+			return mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, MT_HW_RDD0,
+						  MT_RX_SEL0, 0);
+	} else {
+		err = mt7615_mcu_rdd_cmd(dev, RDD_NORMAL_START,
+					 MT_HW_RDD0, MT_RX_SEL0, 0);
+		if (err < 0)
+			return err;
+
+		return mt7615_dfs_stop_radar_detector(dev);
+	}
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index b4d6af812c54..cf9be4944cf7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -137,12 +137,18 @@ static int mt7615_set_channel(struct mt7615_dev *dev)
 	cancel_delayed_work_sync(&dev->mt76.mac_work);
 	set_bit(MT76_RESET, &dev->mt76.state);
 
+	mt7615_dfs_check_channel(dev);
+
 	mt76_set_channel(&dev->mt76);
 
 	ret = mt7615_mcu_set_channel(dev);
 	if (ret)
 		return ret;
 
+	ret = mt7615_dfs_init_radar_detector(dev);
+	if (ret < 0)
+		return ret;
+
 	clear_bit(MT76_RESET, &dev->mt76.state);
 
 	mt76_txq_schedule_all(&dev->mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 282b46c6d33d..c3fefccf3d5b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -159,6 +159,50 @@ mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 	return ret;
 }
 
+static void
+mt7615_mcu_rx_ext_event(struct mt7615_dev *dev, struct sk_buff *skb)
+{
+	struct mt7615_mcu_rxd *rxd = (struct mt7615_mcu_rxd *)skb->data;
+
+	switch (rxd->ext_eid) {
+	case MCU_EXT_EVENT_RDD_REPORT:
+		ieee80211_radar_detected(dev->mt76.hw);
+		dev->hw_pattern++;
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+mt7615_mcu_rx_unsolicited_event(struct mt7615_dev *dev, struct sk_buff *skb)
+{
+	struct mt7615_mcu_rxd *rxd = (struct mt7615_mcu_rxd *)skb->data;
+
+	switch (rxd->eid) {
+	case MCU_EVENT_EXT:
+		mt7615_mcu_rx_ext_event(dev, skb);
+		break;
+	default:
+		break;
+	}
+	dev_kfree_skb(skb);
+}
+
+void mt7615_mcu_rx_event(struct mt7615_dev *dev, struct sk_buff *skb)
+{
+	struct mt7615_mcu_rxd *rxd = (struct mt7615_mcu_rxd *)skb->data;
+
+	if (rxd->ext_eid == MCU_EXT_EVENT_THERMAL_PROTECT ||
+	    rxd->ext_eid == MCU_EXT_EVENT_FW_LOG_2_HOST ||
+	    rxd->ext_eid == MCU_EXT_EVENT_ASSERT_DUMP ||
+	    rxd->ext_eid == MCU_EXT_EVENT_PS_SYNC ||
+	    !rxd->seq)
+		mt7615_mcu_rx_unsolicited_event(dev, skb);
+	else
+		mt76_mcu_rx_event(&dev->mt76, skb);
+}
+
 static int mt7615_mcu_init_download(struct mt7615_dev *dev, u32 addr,
 				    u32 len, u32 mode)
 {
@@ -1213,6 +1257,27 @@ int mt7615_mcu_set_tx_power(struct mt7615_dev *dev)
 	return ret;
 }
 
+int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
+		       enum mt7615_rdd_cmd cmd, u8 index,
+		       u8 rx_sel, u8 val)
+{
+	struct {
+		u8 ctrl;
+		u8 rdd_idx;
+		u8 rdd_rx_sel;
+		u8 val;
+		u8 rsv[4];
+	} req = {
+		.ctrl = cmd,
+		.rdd_idx = index,
+		.rdd_rx_sel = rx_sel,
+		.val = val,
+	};
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_CTRL,
+				   &req, sizeof(req), true);
+}
+
 int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 {
 	struct cfg80211_chan_def *chdef = &dev->mt76.chandef;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index f8b51ad25220..5fe492189f56 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -23,6 +23,27 @@ struct mt7615_mcu_txd {
 	u32 reserved[5];
 } __packed __aligned(4);
 
+/* event table */
+enum {
+	MCU_EVENT_TARGET_ADDRESS_LEN = 0x01,
+	MCU_EVENT_FW_START = 0x01,
+	MCU_EVENT_GENERIC = 0x01,
+	MCU_EVENT_ACCESS_REG = 0x02,
+	MCU_EVENT_MT_PATCH_SEM = 0x04,
+	MCU_EVENT_CH_PRIVILEGE = 0x18,
+	MCU_EVENT_EXT = 0xed,
+	MCU_EVENT_RESTART_DL = 0xef,
+};
+
+/* ext event table */
+enum {
+	MCU_EXT_EVENT_PS_SYNC = 0x5,
+	MCU_EXT_EVENT_FW_LOG_2_HOST = 0x13,
+	MCU_EXT_EVENT_THERMAL_PROTECT = 0x22,
+	MCU_EXT_EVENT_ASSERT_DUMP = 0x23,
+	MCU_EXT_EVENT_RDD_REPORT = 0x3a,
+};
+
 struct mt7615_mcu_rxd {
 	__le32 rxd[4];
 
@@ -77,6 +98,7 @@ enum {
 	MCU_EXT_CMD_EDCA_UPDATE = 0x27,
 	MCU_EXT_CMD_DEV_INFO_UPDATE = 0x2A,
 	MCU_EXT_CMD_WTBL_UPDATE = 0x32,
+	MCU_EXT_CMD_SET_RDD_CTRL = 0x3a,
 	MCU_EXT_CMD_PROTECT_CTRL = 0x3e,
 	MCU_EXT_CMD_MAC_INIT_CTRL = 0x46,
 	MCU_EXT_CMD_BCN_OFFLOAD = 0x49,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index f02ffcffe637..d113fa30115e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -68,6 +68,9 @@ struct mt7615_dev {
 	u32 vif_mask;
 	u32 omac_mask;
 
+	u32 hw_pattern;
+	int dfs_state;
+
 	spinlock_t token_lock;
 	struct idr token;
 };
@@ -97,6 +100,30 @@ enum {
 	EXT_BSSID_END
 };
 
+enum {
+	MT_HW_RDD0,
+	MT_HW_RDD1,
+};
+
+enum {
+	MT_RX_SEL0,
+	MT_RX_SEL1,
+};
+
+enum mt7615_rdd_cmd {
+	RDD_STOP,
+	RDD_START,
+	RDD_DET_MODE,
+	RDD_DET_STOP,
+	RDD_CAC_START,
+	RDD_CAC_END,
+	RDD_NORMAL_START,
+	RDD_DISABLE_DFS_CAL,
+	RDD_PULSE_DBG,
+	RDD_READ_PULSE,
+	RDD_RESUME_BF,
+};
+
 extern const struct ieee80211_ops mt7615_ops;
 extern struct pci_driver mt7615_pci_driver;
 
@@ -144,6 +171,23 @@ int mt7615_mcu_set_rx_ba(struct mt7615_dev *dev,
 			 bool add);
 int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta);
+void mt7615_mcu_rx_event(struct mt7615_dev *dev, struct sk_buff *skb);
+int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
+		       enum mt7615_rdd_cmd cmd, u8 index,
+		       u8 rx_sel, u8 val);
+int mt7615_dfs_start_radar_detector(struct mt7615_dev *dev);
+int mt7615_dfs_stop_radar_detector(struct mt7615_dev *dev);
+
+static inline void mt7615_dfs_check_channel(struct mt7615_dev *dev)
+{
+	enum nl80211_chan_width width = dev->mt76.chandef.width;
+	u32 freq = dev->mt76.chandef.chan->center_freq;
+	struct ieee80211_hw *hw = mt76_hw(dev);
+
+	if (hw->conf.chandef.chan->center_freq != freq ||
+	    hw->conf.chandef.width != width)
+		dev->dfs_state = -1;
+}
 
 static inline void mt7615_irq_enable(struct mt7615_dev *dev, u32 mask)
 {
@@ -193,5 +237,7 @@ void mt7615_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 void mt7615_mac_work(struct work_struct *work);
 void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 			  struct mt76_txwi_cache *txwi);
+int mt76_dfs_start_rdd(struct mt7615_dev *dev, bool force);
+int mt7615_dfs_init_radar_detector(struct mt7615_dev *dev);
 
 #endif
-- 
2.21.0

