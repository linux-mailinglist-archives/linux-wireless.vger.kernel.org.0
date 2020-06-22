Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357152041B5
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 22:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgFVUNp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 16:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgFVUNk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 16:13:40 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCA1C061799
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bZAdNER9fFLvzjrP6BnalaoO2NjCxTOoDG03inge0Gw=; b=Ub2S5p++VXttgmuAszIQOUyzEJ
        rtSSyaPiLMg7SlT23ROsxEo79PmuHC8xuVMBq1i28wQZwl+jm+2F6SQNBuXHWnMwEzU+PRoY/1SC9
        qhdLOlGDhLbY18cGvauwPuFlIHay9SRSeuH/XyTzETuE5kNzVNPtIMWxP7vKN6J6hxBM=;
Received: from p54ae948c.dip0.t-ipconnect.de ([84.174.148.140] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jnSp0-0000qE-Ri
        for linux-wireless@vger.kernel.org; Mon, 22 Jun 2020 22:13:38 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 7/7] mt76: mt7615: implement testmode support
Date:   Mon, 22 Jun 2020 22:13:27 +0200
Message-Id: <20200622201327.94414-7-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200622201327.94414-1-nbd@nbd.name>
References: <20200622201327.94414-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Supports sending a configurable number of packets with a specific rate
and configurable tx power levels / antenna settings, as well as displaying
rx statistics.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7615/Makefile    |   1 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   8 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  36 ++
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |   5 +
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  44 ++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  35 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |   6 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  18 +
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  16 +
 .../wireless/mediatek/mt76/mt7615/testmode.c  | 363 ++++++++++++++++++
 10 files changed, 523 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/testmode.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
index 99f353b8b9aa..d2ad84cb5244 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
@@ -8,6 +8,7 @@ CFLAGS_trace.o := -I$(src)
 
 mt7615-common-y := main.o init.o mcu.o eeprom.o mac.o \
 		   debugfs.o trace.o
+mt7615-common-$(CONFIG_NL80211_TESTMODE) += testmode.o
 
 mt7615e-y := pci.o pci_init.o dma.o pci_mac.o mmio.o
 mt7615e-$(CONFIG_MT7622_WMAC) += soc.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index e2d80518e5af..2e0840b0e902 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -321,6 +321,7 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
+	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
 
 	if (is_mt7615(&phy->dev->mt76))
 		hw->max_tx_fragments = MT_TXP_MAX_BUF_NUM;
@@ -405,9 +406,6 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	mphy->sband_2g.sband.n_channels = 0;
 	mphy->hw->wiphy->bands[NL80211_BAND_2GHZ] = NULL;
 
-	/* The second interface does not get any packets unless it has a vif */
-	ieee80211_hw_set(mphy->hw, WANT_MONITOR_VIF);
-
 	ret = mt76_register_phy(mphy);
 	if (ret)
 		ieee80211_free_hw(mphy->hw);
@@ -457,5 +455,9 @@ void mt7615_init_device(struct mt7615_dev *dev)
 			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
 	mt7615_cap_dbdc_disable(dev);
 	dev->phy.dfs_state = -1;
+
+#ifdef CONFIG_NL80211_TESTMODE
+	dev->mt76.test_ops = &mt7615_testmode_ops;
+#endif
 }
 EXPORT_SYMBOL_GPL(mt7615_init_device);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 1dc291e8b766..9d74a6550cf0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -186,6 +186,40 @@ mt7615_get_status_freq_info(struct mt7615_dev *dev, struct mt76_phy *mphy,
 	status->freq = ieee80211_channel_to_frequency(chfreq, status->band);
 }
 
+static void mt7615_mac_fill_tm_rx(struct mt7615_dev *dev, __le32 *rxv)
+{
+#ifdef CONFIG_NL80211_TESTMODE
+	u32 rxv1 = le32_to_cpu(rxv[0]);
+	u32 rxv3 = le32_to_cpu(rxv[2]);
+	u32 rxv4 = le32_to_cpu(rxv[3]);
+	u32 rxv5 = le32_to_cpu(rxv[4]);
+	u8 cbw = FIELD_GET(MT_RXV1_FRAME_MODE, rxv1);
+	u8 mode = FIELD_GET(MT_RXV1_TX_MODE, rxv1);
+	s16 foe = FIELD_GET(MT_RXV5_FOE, rxv5);
+	u32 foe_const = (BIT(cbw + 1) & 0xf) * 10000;
+
+	if (!mode) {
+		/* CCK */
+		foe &= ~BIT(11);
+		foe *= 1000;
+		foe >>= 11;
+	} else {
+		if (foe > 2048)
+			foe -= 4096;
+
+		foe = (foe * foe_const) >> 15;
+	}
+
+	dev->test.last_freq_offset = foe;
+	dev->test.last_rcpi[0] = FIELD_GET(MT_RXV4_RCPI0, rxv4);
+	dev->test.last_rcpi[1] = FIELD_GET(MT_RXV4_RCPI1, rxv4);
+	dev->test.last_rcpi[2] = FIELD_GET(MT_RXV4_RCPI2, rxv4);
+	dev->test.last_rcpi[3] = FIELD_GET(MT_RXV4_RCPI3, rxv4);
+	dev->test.last_ib_rssi = FIELD_GET(MT_RXV3_IB_RSSI, rxv3);
+	dev->test.last_ib_rssi = FIELD_GET(MT_RXV3_WB_RSSI, rxv3);
+#endif
+}
+
 static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
@@ -401,6 +435,8 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 					     status->chain_signal[i]);
 		}
 
+		mt7615_mac_fill_tm_rx(dev, rxd);
+
 		rxd += 6;
 		if ((u8 *)rxd - skb->data >= skb->len)
 			return -EINVAL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index 81608ab656b8..169f4e17b5b4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -100,11 +100,16 @@ enum rx_pkt_type {
 #define MT_RXV2_GROUP_ID		GENMASK(26, 21)
 #define MT_RXV2_LENGTH			GENMASK(20, 0)
 
+#define MT_RXV3_WB_RSSI			GENMASK(31, 24)
+#define MT_RXV3_IB_RSSI			GENMASK(23, 16)
+
 #define MT_RXV4_RCPI3			GENMASK(31, 24)
 #define MT_RXV4_RCPI2			GENMASK(23, 16)
 #define MT_RXV4_RCPI1			GENMASK(15, 8)
 #define MT_RXV4_RCPI0			GENMASK(7, 0)
 
+#define MT_RXV5_FOE			GENMASK(11, 0)
+
 #define MT_RXV6_NF3			GENMASK(31, 24)
 #define MT_RXV6_NF2			GENMASK(23, 16)
 #define MT_RXV6_NF1			GENMASK(15, 8)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index abb9853eaa8b..3abb33ddab7d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -76,6 +76,8 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 
 	mutex_lock(&dev->mt76.mutex);
 
+	mt76_testmode_reset(&dev->mt76, true);
+
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 	cancel_delayed_work_sync(&phy->scan_work);
 
@@ -137,6 +139,12 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&dev->mt76.mutex);
 
+	mt76_testmode_reset(&dev->mt76, true);
+
+	if (vif->type == NL80211_IFTYPE_MONITOR &&
+	    is_zero_ether_addr(vif->addr))
+		phy->monitor_vif = vif;
+
 	mvif->idx = ffs(~dev->mphy.vif_mask) - 1;
 	if (mvif->idx >= MT7615_MAX_INTERFACES) {
 		ret = -ENOSPC;
@@ -197,6 +205,13 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 
 	/* TODO: disable beacon for the bss */
 
+	mutex_lock(&dev->mt76.mutex);
+	mt76_testmode_reset(&dev->mt76, true);
+	mutex_unlock(&dev->mt76.mutex);
+
+	if (vif == phy->monitor_vif)
+	    phy->monitor_vif = NULL;
+
 	mt7615_mcu_add_dev_info(dev, vif, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
@@ -234,7 +249,7 @@ static void mt7615_init_dfs_state(struct mt7615_phy *phy)
 	phy->dfs_state = -1;
 }
 
-static int mt7615_set_channel(struct mt7615_phy *phy)
+int mt7615_set_channel(struct mt7615_phy *phy)
 {
 	struct mt7615_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
@@ -260,7 +275,7 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 	mt7615_mac_set_timing(phy);
 	ret = mt7615_dfs_init_radar_detector(phy);
 	mt7615_mac_cca_stats_reset(phy);
-	mt7615_mcu_set_sku_en(phy, true);
+	mt7615_mcu_set_sku_en(phy, !mt76_testmode_enabled(&dev->mt76));
 
 	mt7615_mac_reset_counters(dev);
 	phy->noise = 0;
@@ -271,8 +286,11 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 	mutex_unlock(&dev->mt76.mutex);
 
 	mt76_txq_schedule_all(phy->mt76);
-	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
-				     MT7615_WATCHDOG_TIME);
+
+	if (!mt76_testmode_enabled(&dev->mt76))
+		ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
+					     MT7615_WATCHDOG_TIME);
+
 	return ret;
 }
 
@@ -369,6 +387,13 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 
 	if (changed & (IEEE80211_CONF_CHANGE_CHANNEL |
 		       IEEE80211_CONF_CHANGE_POWER)) {
+#ifdef CONFIG_NL80211_TESTMODE
+		if (dev->mt76.test.state != MT76_TM_STATE_OFF) {
+			mutex_lock(&dev->mt76.mutex);
+			mt76_testmode_reset(&dev->mt76, false);
+			mutex_unlock(&dev->mt76.mutex);
+		}
+#endif
 		ieee80211_stop_queues(hw);
 		ret = mt7615_set_channel(phy);
 		ieee80211_wake_queues(hw);
@@ -377,6 +402,8 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 	mutex_lock(&dev->mt76.mutex);
 
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
+		mt76_testmode_reset(&dev->mt76, true);
+
 		if (!(hw->conf.flags & IEEE80211_CONF_MONITOR))
 			phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
 		else
@@ -419,10 +446,13 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 			MT_WF_RFCR1_DROP_CFACK;
 	u32 flags = 0;
 
+	mutex_lock(&dev->mt76.mutex);
+
 #define MT76_FILTER(_flag, _hw) do { \
 		flags |= *total_flags & FIF_##_flag;			\
 		phy->rxfilter &= ~(_hw);				\
-		phy->rxfilter |= !(flags & FIF_##_flag) * (_hw);	\
+		if (!mt76_testmode_enabled(&dev->mt76))			\
+			phy->rxfilter |= !(flags & FIF_##_flag) * (_hw);\
 	} while (0)
 
 	phy->rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
@@ -455,6 +485,8 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 		mt76_clear(dev, MT_WF_RFCR1(band), ctl_flags);
 	else
 		mt76_set(dev, MT_WF_RFCR1(band), ctl_flags);
+
+	mutex_unlock(&dev->mt76.mutex);
 }
 
 static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
@@ -1069,6 +1101,8 @@ const struct ieee80211_ops mt7615_ops = {
 	.sched_scan_stop = mt7615_stop_sched_scan,
 	.remain_on_channel = mt7615_remain_on_channel,
 	.cancel_remain_on_channel = mt7615_cancel_remain_on_channel,
+	CFG80211_TESTMODE_CMD(mt76_testmode_cmd)
+	CFG80211_TESTMODE_DUMP(mt76_testmode_dump)
 #ifdef CONFIG_PM
 	.suspend = mt7615_suspend,
 	.resume = mt7615_resume,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index b4440f131925..026bf938c675 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2806,6 +2806,14 @@ int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd)
 		.center_chan2 = ieee80211_frequency_to_channel(freq2),
 	};
 
+#ifdef CONFIG_NL80211_TESTMODE
+	if (dev->mt76.test.state == MT76_TM_STATE_TX_FRAMES &&
+	    dev->mt76.test.tx_antenna_mask) {
+		req.tx_streams = hweight8(dev->mt76.test.tx_antenna_mask);
+		req.rx_streams_mask = dev->mt76.test.tx_antenna_mask;
+	}
+#endif
+
 	if (dev->mt76.hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
 	else if ((chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
@@ -2817,7 +2825,10 @@ int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd)
 	req.band_idx = phy != &dev->phy;
 	req.bw = mt7615_mcu_chan_bw(chandef);
 
-	mt7615_mcu_set_txpower_sku(phy, req.txpower_sku);
+	if (mt76_testmode_enabled(&dev->mt76))
+		memset(req.txpower_sku, 0x3f, 49);
+	else
+		mt7615_mcu_set_txpower_sku(phy, req.txpower_sku);
 
 	return __mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
 }
@@ -2835,6 +2846,28 @@ int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index)
 				   sizeof(req), true);
 }
 
+int mt7615_mcu_set_test_param(struct mt7615_dev *dev, u8 param, bool test_mode,
+			      bool en)
+{
+	struct {
+		u8 test_mode_en;
+		u8 param_idx;
+		u8 _rsv[2];
+
+		u8 enable;
+		u8 _rsv2[3];
+
+		u8 pad[8];
+	} req = {
+		.test_mode_en = test_mode,
+		.param_idx = param,
+		.enable = en,
+	};
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_ATE_CTRL, &req,
+				   sizeof(req), false);
+}
+
 int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable)
 {
 	struct mt7615_dev *dev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 8e2be150a556..e8c7aa5c35ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -268,6 +268,7 @@ enum {
 	MCU_EXT_CMD_GET_TEMP = 0x2c,
 	MCU_EXT_CMD_WTBL_UPDATE = 0x32,
 	MCU_EXT_CMD_SET_RDD_CTRL = 0x3a,
+	MCU_EXT_CMD_ATE_CTRL = 0x3d,
 	MCU_EXT_CMD_PROTECT_CTRL = 0x3e,
 	MCU_EXT_CMD_DBDC_CTRL = 0x45,
 	MCU_EXT_CMD_MAC_INIT_CTRL = 0x46,
@@ -289,6 +290,11 @@ enum {
 	MCU_UNI_CMD_HIF_CTRL = MCU_UNI_PREFIX | 0x07,
 };
 
+enum {
+	MCU_ATE_SET_FREQ_OFFSET = 0xa,
+	MCU_ATE_SET_TX_POWER_CONTROL = 0x15,
+};
+
 struct mt7615_mcu_uni_event {
 	u8 cid;
 	u8 pad[3];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index af86cf6925dd..1ae6ea5b4f16 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -169,6 +169,8 @@ struct mt7615_phy {
 	struct mt76_phy *mt76;
 	struct mt7615_dev *dev;
 
+	struct ieee80211_vif *monitor_vif;
+
 	u32 rxfilter;
 	u32 omac_mask;
 
@@ -283,6 +285,17 @@ struct mt7615_dev {
 
 	u32 debugfs_rf_wf;
 	u32 debugfs_rf_reg;
+
+#ifdef CONFIG_NL80211_TESTMODE
+	struct {
+		u32 *reg_backup;
+
+		s16 last_freq_offset;
+		u8 last_rcpi[4];
+		s8 last_ib_rssi;
+		s8 last_wb_rssi;
+	} test;
+#endif
 };
 
 enum tx_pkt_queue_idx {
@@ -377,6 +390,7 @@ extern const u32 mt7615e_reg_map[__MT_BASE_MAX];
 extern const u32 mt7663e_reg_map[__MT_BASE_MAX];
 extern struct pci_driver mt7615_pci_driver;
 extern struct platform_driver mt7622_wmac_driver;
+extern const struct mt76_testmode_ops mt7615_testmode_ops;
 
 #ifdef CONFIG_MT7622_WMAC
 int mt7622_wmac_init(struct mt7615_dev *dev);
@@ -488,6 +502,7 @@ void mt7615_init_txpower(struct mt7615_dev *dev,
 			 struct ieee80211_supported_band *sband);
 void mt7615_phy_init(struct mt7615_dev *dev);
 void mt7615_mac_init(struct mt7615_dev *dev);
+int mt7615_set_channel(struct mt7615_phy *phy);
 
 int mt7615_mcu_restart(struct mt76_dev *dev);
 void mt7615_update_channel(struct mt76_dev *mdev);
@@ -531,6 +546,7 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev);
 int mt7615_mcu_set_mac_enable(struct mt7615_dev *dev, int band, bool enable);
 int mt7615_mcu_set_rts_thresh(struct mt7615_phy *phy, u32 val);
 int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index);
+int mt7615_mcu_set_tx_power(struct mt7615_phy *phy);
 void mt7615_mcu_exit(struct mt7615_dev *dev);
 void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 			 int cmd, int *wait_seq);
@@ -569,6 +585,8 @@ int mt7615_mcu_set_pulse_th(struct mt7615_dev *dev,
 			    const struct mt7615_dfs_pulse *pulse);
 int mt7615_mcu_set_radar_th(struct mt7615_dev *dev, int index,
 			    const struct mt7615_dfs_pattern *pattern);
+int mt7615_mcu_set_test_param(struct mt7615_dev *dev, u8 param, bool test_mode,
+			      bool en);
 int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable);
 int mt7615_mcu_apply_rx_dcoc(struct mt7615_phy *phy);
 int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 4743c12005a4..8d2c54918e68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -212,6 +212,9 @@ enum mt7615_reg_base {
 #define MT_WF_PHY_RXTD2_BASE		MT_WF_PHY(0x2a00)
 #define MT_WF_PHY_RXTD2(_n)		(MT_WF_PHY_RXTD2_BASE + ((_n) << 2))
 
+#define MT_WF_PHY_RFINTF3_0(_n)		MT_WF_PHY(0x1100 + (_n) * 0x400)
+#define MT_WF_PHY_RFINTF3_0_ANT		GENMASK(7, 4)
+
 #define MT_WF_CFG_BASE			((dev)->reg_map[MT_CFG_BASE])
 #define MT_WF_CFG(ofs)			(MT_WF_CFG_BASE + (ofs))
 
@@ -255,6 +258,13 @@ enum mt7615_reg_base {
 #define MT_WF_ARB_BASE			((dev)->reg_map[MT_ARB_BASE])
 #define MT_WF_ARB(ofs)			(MT_WF_ARB_BASE + (ofs))
 
+#define MT_ARB_RQCR			MT_WF_ARB(0x070)
+#define MT_ARB_RQCR_RX_START		BIT(0)
+#define MT_ARB_RQCR_RXV_START		BIT(4)
+#define MT_ARB_RQCR_RXV_R_EN		BIT(7)
+#define MT_ARB_RQCR_RXV_T_EN		BIT(8)
+#define MT_ARB_RQCR_BAND_SHIFT		16
+
 #define MT_ARB_SCR			MT_WF_ARB(0x080)
 #define MT_ARB_SCR_TX0_DISABLE		BIT(8)
 #define MT_ARB_SCR_RX0_DISABLE		BIT(9)
@@ -550,4 +560,10 @@ enum mt7615_reg_base {
 #define MT_WL_RX_BUSY			BIT(30)
 #define MT_WL_TX_BUSY			BIT(31)
 
+#define MT_MCU_PTA_BASE			0x81060000
+#define MT_MCU_PTA(_n)			(MT_MCU_PTA_BASE + (_n))
+
+#define MT_ANT_SWITCH_CON(n)		MT_MCU_PTA(0x0c8)
+#define MT_ANT_SWITCH_CON_MODE(_n)	(GENMASK(4, 0) << (_n * 8))
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
new file mode 100644
index 000000000000..55ebb1ec8c70
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 Felix Fietkau <nbd@nbd.name> */
+
+#include "mt7615.h"
+#include "eeprom.h"
+#include "mcu.h"
+
+enum {
+	TM_CHANGED_TXPOWER_CTRL,
+	TM_CHANGED_TXPOWER,
+	TM_CHANGED_FREQ_OFFSET,
+
+	/* must be last */
+	NUM_TM_CHANGED
+};
+
+
+static const u8 tm_change_map[] = {
+	[TM_CHANGED_TXPOWER_CTRL] = MT76_TM_ATTR_TX_POWER_CONTROL,
+	[TM_CHANGED_TXPOWER] = MT76_TM_ATTR_TX_POWER,
+	[TM_CHANGED_FREQ_OFFSET] = MT76_TM_ATTR_FREQ_OFFSET,
+};
+
+static const u32 reg_backup_list[] = {
+	MT_WF_PHY_RFINTF3_0(0),
+	MT_WF_PHY_RFINTF3_0(1),
+	MT_WF_PHY_RFINTF3_0(2),
+	MT_WF_PHY_RFINTF3_0(3),
+	MT_ANT_SWITCH_CON(2),
+	MT_ANT_SWITCH_CON(3),
+	MT_ANT_SWITCH_CON(4),
+	MT_ANT_SWITCH_CON(6),
+	MT_ANT_SWITCH_CON(7),
+	MT_ANT_SWITCH_CON(8),
+};
+
+static const struct {
+	u16 wf;
+	u16 reg;
+} rf_backup_list[] = {
+	{ 0, 0x48 },
+	{ 1, 0x48 },
+	{ 2, 0x48 },
+	{ 3, 0x48 },
+};
+
+static int
+mt7615_tm_set_tx_power(struct mt7615_phy *phy)
+{
+	struct mt7615_dev *dev = phy->dev;
+	struct mt76_phy *mphy = phy->mt76;
+	int i, ret, n_chains = hweight8(mphy->antenna_mask);
+	struct cfg80211_chan_def *chandef = &mphy->chandef;
+	int freq = chandef->center_freq1, len, target_chains;
+	u8 *data, *eep = (u8 *)dev->mt76.eeprom.data;
+	enum nl80211_band band = chandef->chan->band;
+	struct sk_buff *skb;
+	struct {
+		u8 center_chan;
+		u8 dbdc_idx;
+		u8 band;
+		u8 rsv;
+	} __packed req_hdr = {
+		.center_chan = ieee80211_frequency_to_channel(freq),
+		.band = band,
+		.dbdc_idx = phy != &dev->phy,
+	};
+	u8 *tx_power = NULL;
+
+	if (dev->mt76.test.state != MT76_TM_STATE_OFF)
+		tx_power = dev->mt76.test.tx_power;
+
+	len = sizeof(req_hdr) + MT7615_EE_MAX - MT_EE_NIC_CONF_0;
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(req_hdr) + len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &req_hdr, sizeof(req_hdr));
+	data = skb_put_data(skb, eep + MT_EE_NIC_CONF_0, len);
+
+	target_chains = mt7615_ext_pa_enabled(dev, band) ? 1 : n_chains;
+	for (i = 0; i < target_chains; i++) {
+		int index;
+
+		ret = mt7615_eeprom_get_target_power_index(dev, chandef->chan, i);
+		if (ret < 0)
+			return -EINVAL;
+
+		index = ret - MT_EE_NIC_CONF_0;
+		if (tx_power && tx_power[i])
+			data[ret - MT_EE_NIC_CONF_0] = tx_power[i];
+	}
+
+	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				       MCU_EXT_CMD_SET_TX_POWER_CTRL, false);
+}
+
+static void
+mt7615_tm_reg_backup_restore(struct mt7615_dev *dev)
+{
+	u32 *b = dev->test.reg_backup;
+	int n_regs = ARRAY_SIZE(reg_backup_list);
+	int n_rf_regs = ARRAY_SIZE(rf_backup_list);
+	int i;
+
+	if (dev->mt76.test.state == MT76_TM_STATE_OFF) {
+		for (i = 0; i < n_regs; i++)
+			mt76_wr(dev, reg_backup_list[i], b[i]);
+
+		for (i = 0; i < n_rf_regs; i++)
+			mt7615_rf_wr(dev, rf_backup_list[i].wf,
+				     rf_backup_list[i].reg, b[n_regs + i]);
+		return;
+	}
+
+	if (b)
+		return;
+
+	b = devm_kzalloc(dev->mt76.dev, 4 * (n_regs + n_rf_regs),
+			 GFP_KERNEL);
+	if (!b)
+		return;
+
+	dev->test.reg_backup = b;
+	for (i = 0; i < n_regs; i++)
+		b[i] = mt76_rr(dev, reg_backup_list[i]);
+	for (i = 0; i < n_rf_regs; i++)
+		b[n_regs + i] = mt7615_rf_rr(dev, rf_backup_list[i].wf,
+					     rf_backup_list[i].reg);
+}
+
+
+static void
+mt7615_tm_init_phy(struct mt7615_dev *dev, struct mt7615_phy *phy)
+{
+	unsigned int total_flags = ~0;
+
+	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
+		return;
+
+	mutex_unlock(&dev->mt76.mutex);
+	mt7615_set_channel(phy);
+	mt7615_ops.configure_filter(phy->mt76->hw, 0, &total_flags, 0);
+	mutex_lock(&dev->mt76.mutex);
+
+	mt7615_tm_reg_backup_restore(dev);
+}
+
+static void
+mt7615_tm_init(struct mt7615_dev *dev)
+{
+	mt7615_tm_init_phy(dev, &dev->phy);
+
+	if (dev->mt76.phy2)
+		mt7615_tm_init_phy(dev, dev->mt76.phy2->priv);
+}
+
+static void
+mt7615_tm_set_rx_enable(struct mt7615_dev *dev, bool en)
+{
+	u32 rqcr_mask = (MT_ARB_RQCR_RX_START |
+			 MT_ARB_RQCR_RXV_START |
+			 MT_ARB_RQCR_RXV_R_EN |
+			 MT_ARB_RQCR_RXV_T_EN) *
+			(BIT(0) | BIT(MT_ARB_RQCR_BAND_SHIFT));
+
+	if (en) {
+		mt76_clear(dev, MT_ARB_SCR,
+			   MT_ARB_SCR_RX0_DISABLE | MT_ARB_SCR_RX1_DISABLE);
+		mt76_set(dev, MT_ARB_RQCR, rqcr_mask);
+	} else {
+		mt76_set(dev, MT_ARB_SCR,
+			 MT_ARB_SCR_RX0_DISABLE | MT_ARB_SCR_RX1_DISABLE);
+		mt76_clear(dev, MT_ARB_RQCR, rqcr_mask);
+	}
+}
+
+static void
+mt7615_tm_set_tx_antenna(struct mt7615_dev *dev, bool en)
+{
+	struct mt76_testmode_data *td = &dev->mt76.test;
+	u8 mask = td->tx_antenna_mask;
+	int i;
+
+	if (!mask)
+		return;
+
+	if (!en)
+		mask = dev->phy.chainmask;
+
+	for (i = 0; i < 4; i++) {
+		mt76_rmw_field(dev, MT_WF_PHY_RFINTF3_0(i),
+			       MT_WF_PHY_RFINTF3_0_ANT,
+			       td->tx_antenna_mask & BIT(i) ? 0xa : 0);
+
+	}
+
+	/* 2.4 GHz band */
+	mt76_rmw_field(dev, MT_ANT_SWITCH_CON(3), MT_ANT_SWITCH_CON_MODE(0),
+		       (td->tx_antenna_mask & BIT(0)) ? 0x8 : 0x1b);
+	mt76_rmw_field(dev, MT_ANT_SWITCH_CON(4), MT_ANT_SWITCH_CON_MODE(2),
+		       (td->tx_antenna_mask & BIT(1)) ? 0xe : 0x1b);
+	mt76_rmw_field(dev, MT_ANT_SWITCH_CON(6), MT_ANT_SWITCH_CON_MODE(0),
+		       (td->tx_antenna_mask & BIT(2)) ? 0x0 : 0xf);
+	mt76_rmw_field(dev, MT_ANT_SWITCH_CON(7), MT_ANT_SWITCH_CON_MODE(2),
+		       (td->tx_antenna_mask & BIT(3)) ? 0x6 : 0xf);
+
+	/* 5 GHz band */
+	mt76_rmw_field(dev, MT_ANT_SWITCH_CON(4), MT_ANT_SWITCH_CON_MODE(1),
+		       (td->tx_antenna_mask & BIT(0)) ? 0xd : 0x1b);
+	mt76_rmw_field(dev, MT_ANT_SWITCH_CON(2), MT_ANT_SWITCH_CON_MODE(3),
+		       (td->tx_antenna_mask & BIT(1)) ? 0x13 : 0x1b);
+	mt76_rmw_field(dev, MT_ANT_SWITCH_CON(7), MT_ANT_SWITCH_CON_MODE(1),
+		       (td->tx_antenna_mask & BIT(2)) ? 0x5 : 0xf);
+	mt76_rmw_field(dev, MT_ANT_SWITCH_CON(8), MT_ANT_SWITCH_CON_MODE(3),
+		       (td->tx_antenna_mask & BIT(3)) ? 0xb : 0xf);
+
+	for (i = 0; i < 4; i++) {
+		u32 val;
+
+		val = mt7615_rf_rr(dev, i, 0x48);
+		val &= ~(0x3ff << 20);
+		if (td->tx_antenna_mask & BIT(i))
+			val |= 3 << 20;
+		else
+			val |= (2 << 28) | (2 << 26) | (8 << 20);
+		mt7615_rf_wr(dev, i, 0x48, val);
+	}
+}
+
+static void
+mt7615_tm_set_tx_frames(struct mt7615_dev *dev, bool en)
+{
+	struct ieee80211_tx_info *info;
+	struct sk_buff *skb = dev->mt76.test.tx_skb;
+
+	mt7615_mcu_set_chan_info(&dev->phy, MCU_EXT_CMD_SET_RX_PATH);
+	mt7615_tm_set_tx_antenna(dev, en);
+	mt7615_tm_set_rx_enable(dev, !en);
+	if (!en || !skb)
+		return;
+
+	info = IEEE80211_SKB_CB(skb);
+	info->control.vif = dev->phy.monitor_vif;
+}
+
+static void
+mt7615_tm_update_params(struct mt7615_dev *dev, u32 changed)
+{
+	struct mt76_testmode_data *td = &dev->mt76.test;
+	bool en = dev->mt76.test.state != MT76_TM_STATE_OFF;
+
+	if (changed & BIT(TM_CHANGED_TXPOWER_CTRL))
+		mt7615_mcu_set_test_param(dev, MCU_ATE_SET_TX_POWER_CONTROL,
+					  en, en && td->tx_power_control);
+	if (changed & BIT(TM_CHANGED_FREQ_OFFSET))
+		mt7615_mcu_set_test_param(dev, MCU_ATE_SET_FREQ_OFFSET,
+					  en, en ? td->freq_offset : 0);
+	if (changed & BIT(TM_CHANGED_TXPOWER))
+		mt7615_tm_set_tx_power(&dev->phy);
+}
+
+static int
+mt7615_tm_set_state(struct mt76_dev *mdev, enum mt76_testmode_state state)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	struct mt76_testmode_data *td = &mdev->test;
+	enum mt76_testmode_state prev_state = td->state;
+
+	mdev->test.state = state;
+
+	if (prev_state == MT76_TM_STATE_TX_FRAMES)
+		mt7615_tm_set_tx_frames(dev, false);
+	else if (state == MT76_TM_STATE_TX_FRAMES)
+		mt7615_tm_set_rx_enable(dev, true);
+
+	if (state <= MT76_TM_STATE_IDLE)
+		mt7615_tm_init(dev);
+
+	if ((state == MT76_TM_STATE_IDLE &&
+	     prev_state == MT76_TM_STATE_OFF) ||
+	    (state == MT76_TM_STATE_OFF &&
+	     prev_state == MT76_TM_STATE_IDLE)) {
+		u32 changed = 0;
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(tm_change_map); i++) {
+			u16 cur = tm_change_map[i];
+
+			if (td->param_set[cur / 32] & BIT(cur % 32))
+				changed |= BIT(i);
+		}
+
+		mt7615_tm_update_params(dev, changed);
+	}
+
+	return 0;
+}
+
+static int
+mt7615_tm_set_params(struct mt76_dev *mdev, struct nlattr **tb,
+		     enum mt76_testmode_state new_state)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	struct mt76_testmode_data *td = &dev->mt76.test;
+	u32 changed = 0;
+	int i;
+
+	BUILD_BUG_ON(NUM_TM_CHANGED >= 32);
+
+	if (new_state == MT76_TM_STATE_OFF ||
+	    td->state == MT76_TM_STATE_OFF)
+		return 0;
+
+	if (td->tx_antenna_mask & ~dev->phy.chainmask)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(tm_change_map); i++) {
+		if (tb[tm_change_map[i]])
+			changed |= BIT(i);
+	}
+
+	mt7615_tm_update_params(dev, changed);
+
+	return 0;
+}
+
+static int
+mt7615_tm_dump_stats(struct mt76_dev *mdev, struct sk_buff *msg)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	void *rx, *rssi;
+	int i;
+
+	rx = nla_nest_start(msg, MT76_TM_STATS_ATTR_LAST_RX);
+	if (!rx)
+		return -ENOMEM;
+
+	if (nla_put_s32(msg, MT76_TM_RX_ATTR_FREQ_OFFSET, dev->test.last_freq_offset) ||
+	    nla_put_s32(msg, MT76_TM_RX_ATTR_IB_RSSI, dev->test.last_ib_rssi) ||
+	    nla_put_s32(msg, MT76_TM_RX_ATTR_WB_RSSI, dev->test.last_wb_rssi))
+		return -ENOMEM;
+
+	rssi = nla_nest_start(msg, MT76_TM_RX_ATTR_RCPI);
+	if (!rssi)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(dev->test.last_rcpi); i++)
+		if (nla_put_u8(msg, i, dev->test.last_rcpi[i]))
+			return -ENOMEM;
+
+	nla_nest_end(msg, rssi);
+
+	nla_nest_end(msg, rx);
+
+	return 0;
+}
+
+const struct mt76_testmode_ops mt7615_testmode_ops = {
+	.set_state = mt7615_tm_set_state,
+	.set_params = mt7615_tm_set_params,
+	.dump_stats = mt7615_tm_dump_stats,
+};
-- 
2.24.0

