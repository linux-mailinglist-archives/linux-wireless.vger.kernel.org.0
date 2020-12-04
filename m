Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50142CEB11
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 10:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgLDJiR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 04:38:17 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52974 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729450AbgLDJiQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 04:38:16 -0500
X-UUID: 49f0d596d9834b1aaee80e15992efd34-20201204
X-UUID: 49f0d596d9834b1aaee80e15992efd34-20201204
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 619543826; Fri, 04 Dec 2020 17:37:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Dec 2020 17:37:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Dec 2020 17:37:14 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 2/5] mt76: testmode: introduce dbdc support
Date:   Fri, 4 Dec 2020 17:36:56 +0800
Message-ID: <20201204093659.20384-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201204093659.20384-1-shayne.chen@mediatek.com>
References: <20201204093659.20384-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 90BF4930A9360253EEA7FB0FC89C9EF691F339A1931664D01D7F386F8D11E8122000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add testmode support for DBDC NICs (both MT7615D and MT7915D work).
Testmode data and parameters are moved from per-dev to per-phy
for maintaining the value of each band.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c      |   8 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  43 ++++++--
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  18 +--
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   2 +-
 .../wireless/mediatek/mt76/mt7615/testmode.c  |  82 +++++++-------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  22 ++--
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  18 +--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  18 ++-
 .../wireless/mediatek/mt76/mt7915/testmode.c  | 104 ++++++++++--------
 drivers/net/wireless/mediatek/mt76/testmode.c |  88 ++++++++-------
 drivers/net/wireless/mediatek/mt76/tx.c       |  24 ++--
 13 files changed, 244 insertions(+), 193 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index bab961ebdf1c..bfee012c1444 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -418,8 +418,12 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 free:
 #ifdef CONFIG_NL80211_TESTMODE
 	/* fix tx_done accounting on queue overflow */
-	if (tx_info.skb == dev->test.tx_skb)
-		dev->test.tx_done--;
+	if (mt76_is_testmode_skb(dev, skb, &hw)) {
+		struct mt76_phy *phy = hw->priv;
+
+		if (tx_info.skb == phy->test.tx_skb)
+			phy->test.tx_done--;
+	}
 #endif
 
 	e.skb = tx_info.skb;
diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 90278aeb6721..ffc9d547f4fe 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -75,8 +75,8 @@ mt76_get_of_eeprom(struct mt76_dev *dev, int len)
 	}
 
 #ifdef CONFIG_NL80211_TESTMODE
-	dev->test.mtd_name = devm_kstrdup(dev->dev, part, GFP_KERNEL);
-	dev->test.mtd_offset = offset;
+	dev->phy.test.mtd_name = devm_kstrdup(dev->dev, part, GFP_KERNEL);
+	dev->phy.test.mtd_offset = offset;
 #endif
 
 out_put_node:
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index a840396f2c74..f2714436883b 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -519,10 +519,10 @@ void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb)
 	}
 
 #ifdef CONFIG_NL80211_TESTMODE
-	if (dev->test.state == MT76_TM_STATE_RX_FRAMES) {
-		dev->test.rx_stats.packets[q]++;
+	if (phy->test.state == MT76_TM_STATE_RX_FRAMES) {
+		phy->test.rx_stats.packets[q]++;
 		if (status->flag & RX_FLAG_FAILED_FCS_CRC)
-			dev->test.rx_stats.fcs_error[q]++;
+			phy->test.rx_stats.fcs_error[q]++;
 	}
 #endif
 	__skb_queue_tail(&dev->rx_skb[q], skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 15d52af24d12..8752890fc61e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -513,10 +513,10 @@ struct mt76_rx_status {
 };
 
 struct mt76_testmode_ops {
-	int (*set_state)(struct mt76_dev *dev, enum mt76_testmode_state state);
-	int (*set_params)(struct mt76_dev *dev, struct nlattr **tb,
+	int (*set_state)(struct mt76_phy *phy, enum mt76_testmode_state state);
+	int (*set_params)(struct mt76_phy *phy, struct nlattr **tb,
 			  enum mt76_testmode_state new_state);
-	int (*dump_stats)(struct mt76_dev *dev, struct sk_buff *msg);
+	int (*dump_stats)(struct mt76_phy *phy, struct sk_buff *msg);
 };
 
 struct mt76_testmode_data {
@@ -580,6 +580,10 @@ struct mt76_phy {
 
 	int txpower_cur;
 	u8 antenna_mask;
+
+#ifdef CONFIG_NL80211_TESTMODE
+	struct mt76_testmode_data test;
+#endif
 };
 
 struct mt76_dev {
@@ -659,9 +663,7 @@ struct mt76_dev {
 
 #ifdef CONFIG_NL80211_TESTMODE
 	const struct mt76_testmode_ops *test_ops;
-	struct mt76_testmode_data test;
 #endif
-
 	struct workqueue_struct *wq;
 
 	union {
@@ -929,10 +931,27 @@ static inline u8 mt76_tx_power_nss_delta(u8 nss)
 	return nss_delta[nss - 1];
 }
 
-static inline bool mt76_testmode_enabled(struct mt76_dev *dev)
+static inline bool mt76_testmode_enabled(struct mt76_phy *phy)
 {
 #ifdef CONFIG_NL80211_TESTMODE
-	return dev->test.state != MT76_TM_STATE_OFF;
+	return phy->test.state != MT76_TM_STATE_OFF;
+#else
+	return false;
+#endif
+}
+
+static inline bool mt76_is_testmode_skb(struct mt76_dev *dev,
+					struct sk_buff *skb,
+					struct ieee80211_hw **hw)
+{
+#ifdef CONFIG_NL80211_TESTMODE
+	if (skb == dev->phy.test.tx_skb)
+		*hw = dev->phy.hw;
+	else if (dev->phy2 && skb == dev->phy2->test.tx_skb)
+		*hw = dev->phy2->hw;
+	else
+		return false;
+	return true;
 #else
 	return false;
 #endif
@@ -1014,17 +1033,17 @@ int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		      void *data, int len);
 int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *skb,
 		       struct netlink_callback *cb, void *data, int len);
-int mt76_testmode_set_state(struct mt76_dev *dev, enum mt76_testmode_state state);
+int mt76_testmode_set_state(struct mt76_phy *phy, enum mt76_testmode_state state);
 
-static inline void mt76_testmode_reset(struct mt76_dev *dev, bool disable)
+static inline void mt76_testmode_reset(struct mt76_phy *phy, bool disable)
 {
 #ifdef CONFIG_NL80211_TESTMODE
 	enum mt76_testmode_state state = MT76_TM_STATE_IDLE;
 
-	if (disable || dev->test.state == MT76_TM_STATE_OFF)
+	if (disable || phy->test.state == MT76_TM_STATE_OFF)
 		state = MT76_TM_STATE_OFF;
 
-	mt76_testmode_set_state(dev, state);
+	mt76_testmode_set_state(phy, state);
 #endif
 }
 
@@ -1050,7 +1069,7 @@ void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
 			   struct napi_struct *napi);
 void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames);
-void mt76_testmode_tx_pending(struct mt76_dev *dev);
+void mt76_testmode_tx_pending(struct mt76_phy *phy);
 void mt76_queue_tx_complete(struct mt76_dev *dev, struct mt76_queue *q,
 			    struct mt76_queue_entry *e);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 56dd0b4e4460..3fc48aaa3b36 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -97,7 +97,7 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 
 	mt7615_mutex_acquire(dev);
 
-	mt76_testmode_reset(&dev->mt76, true);
+	mt76_testmode_reset(phy->mt76, true);
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 	cancel_delayed_work_sync(&phy->scan_work);
@@ -181,7 +181,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 
 	mt7615_mutex_acquire(dev);
 
-	mt76_testmode_reset(&dev->mt76, true);
+	mt76_testmode_reset(phy->mt76, true);
 
 	if (vif->type == NL80211_IFTYPE_MONITOR &&
 	    is_zero_ether_addr(vif->addr))
@@ -252,7 +252,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 
 	mt7615_mutex_acquire(dev);
 
-	mt76_testmode_reset(&dev->mt76, true);
+	mt76_testmode_reset(phy->mt76, true);
 	if (vif == phy->monitor_vif)
 	    phy->monitor_vif = NULL;
 
@@ -321,7 +321,7 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 	mt7615_mac_set_timing(phy);
 	ret = mt7615_dfs_init_radar_detector(phy);
 	mt7615_mac_cca_stats_reset(phy);
-	mt7615_mcu_set_sku_en(phy, !mt76_testmode_enabled(&dev->mt76));
+	mt7615_mcu_set_sku_en(phy, !mt76_testmode_enabled(phy->mt76));
 
 	mt7615_mac_reset_counters(dev);
 	phy->noise = 0;
@@ -334,7 +334,7 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 
 	mt76_txq_schedule_all(phy->mt76);
 
-	if (!mt76_testmode_enabled(&dev->mt76))
+	if (!mt76_testmode_enabled(phy->mt76))
 		ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
 					     MT7615_WATCHDOG_TIME);
 
@@ -411,9 +411,9 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 	if (changed & (IEEE80211_CONF_CHANGE_CHANNEL |
 		       IEEE80211_CONF_CHANGE_POWER)) {
 #ifdef CONFIG_NL80211_TESTMODE
-		if (dev->mt76.test.state != MT76_TM_STATE_OFF) {
+		if (phy->mt76->test.state != MT76_TM_STATE_OFF) {
 			mt7615_mutex_acquire(dev);
-			mt76_testmode_reset(&dev->mt76, false);
+			mt76_testmode_reset(phy->mt76, false);
 			mt7615_mutex_release(dev);
 		}
 #endif
@@ -425,7 +425,7 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 	mt7615_mutex_acquire(dev);
 
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
-		mt76_testmode_reset(&dev->mt76, true);
+		mt76_testmode_reset(phy->mt76, true);
 
 		if (!(hw->conf.flags & IEEE80211_CONF_MONITOR))
 			phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
@@ -480,7 +480,7 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 #define MT76_FILTER(_flag, _hw) do { \
 		flags |= *total_flags & FIF_##_flag;			\
 		phy->rxfilter &= ~(_hw);				\
-		if (!mt76_testmode_enabled(&dev->mt76))			\
+		if (!mt76_testmode_enabled(phy->mt76))			\
 			phy->rxfilter |= !(flags & FIF_##_flag) * (_hw);\
 	} while (0)
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index a44b7766dec6..f5c950bcc072 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2895,7 +2895,7 @@ int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd)
 	req.band_idx = phy != &dev->phy;
 	req.bw = mt7615_mcu_chan_bw(chandef);
 
-	if (mt76_testmode_enabled(&dev->mt76))
+	if (mt76_testmode_enabled(phy->mt76))
 		memset(req.txpower_sku, 0x3f, 49);
 	else
 		mt7615_mcu_set_txpower_sku(phy, req.txpower_sku);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
index 8fc97a52411a..f70367d2d317 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
@@ -67,8 +67,8 @@ mt7615_tm_set_tx_power(struct mt7615_phy *phy)
 	};
 	u8 *tx_power = NULL;
 
-	if (dev->mt76.test.state != MT76_TM_STATE_OFF)
-		tx_power = dev->mt76.test.tx_power;
+	if (mphy->test.state != MT76_TM_STATE_OFF)
+		tx_power = mphy->test.tx_power;
 
 	len = MT7615_EE_MAX - MT_EE_NIC_CONF_0;
 	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(req_hdr) + len);
@@ -95,14 +95,15 @@ mt7615_tm_set_tx_power(struct mt7615_phy *phy)
 }
 
 static void
-mt7615_tm_reg_backup_restore(struct mt7615_dev *dev)
+mt7615_tm_reg_backup_restore(struct mt7615_phy *phy)
 {
+	struct mt7615_dev *dev = phy->dev;
 	u32 *b = dev->test.reg_backup;
 	int n_regs = ARRAY_SIZE(reg_backup_list);
 	int n_rf_regs = ARRAY_SIZE(rf_backup_list);
 	int i;
 
-	if (dev->mt76.test.state == MT76_TM_STATE_OFF) {
+	if (dev->mphy.test.state == MT76_TM_STATE_OFF) {
 		for (i = 0; i < n_regs; i++)
 			mt76_wr(dev, reg_backup_list[i], b[i]);
 
@@ -128,10 +129,10 @@ mt7615_tm_reg_backup_restore(struct mt7615_dev *dev)
 					     rf_backup_list[i].reg);
 }
 
-
 static void
-mt7615_tm_init_phy(struct mt7615_dev *dev, struct mt7615_phy *phy)
+mt7615_tm_init(struct mt7615_phy *phy)
 {
+	struct mt7615_dev *dev = phy->dev;
 	unsigned int total_flags = ~0;
 
 	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
@@ -142,16 +143,7 @@ mt7615_tm_init_phy(struct mt7615_dev *dev, struct mt7615_phy *phy)
 	mt7615_ops.configure_filter(phy->mt76->hw, 0, &total_flags, 0);
 	mutex_lock(&dev->mt76.mutex);
 
-	mt7615_tm_reg_backup_restore(dev);
-}
-
-static void
-mt7615_tm_init(struct mt7615_dev *dev)
-{
-	mt7615_tm_init_phy(dev, &dev->phy);
-
-	if (dev->mt76.phy2)
-		mt7615_tm_init_phy(dev, dev->mt76.phy2->priv);
+	mt7615_tm_reg_backup_restore(phy);
 }
 
 static void
@@ -175,9 +167,10 @@ mt7615_tm_set_rx_enable(struct mt7615_dev *dev, bool en)
 }
 
 static void
-mt7615_tm_set_tx_antenna(struct mt7615_dev *dev, bool en)
+mt7615_tm_set_tx_antenna(struct mt7615_phy *phy, bool en)
 {
-	struct mt76_testmode_data *td = &dev->mt76.test;
+	struct mt7615_dev *dev = phy->dev;
+	struct mt76_testmode_data *td = &phy->mt76->test;
 	u8 mask = td->tx_antenna_mask;
 	int i;
 
@@ -185,7 +178,7 @@ mt7615_tm_set_tx_antenna(struct mt7615_dev *dev, bool en)
 		return;
 
 	if (!en)
-		mask = dev->phy.chainmask;
+		mask = phy->chainmask;
 
 	for (i = 0; i < 4; i++) {
 		mt76_rmw_field(dev, MT_WF_PHY_RFINTF3_0(i),
@@ -228,26 +221,28 @@ mt7615_tm_set_tx_antenna(struct mt7615_dev *dev, bool en)
 }
 
 static void
-mt7615_tm_set_tx_frames(struct mt7615_dev *dev, bool en)
+mt7615_tm_set_tx_frames(struct mt7615_phy *phy, bool en)
 {
+	struct mt7615_dev *dev = phy->dev;
 	struct ieee80211_tx_info *info;
-	struct sk_buff *skb = dev->mt76.test.tx_skb;
+	struct sk_buff *skb = phy->mt76->test.tx_skb;
 
-	mt7615_mcu_set_chan_info(&dev->phy, MCU_EXT_CMD_SET_RX_PATH);
-	mt7615_tm_set_tx_antenna(dev, en);
+	mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
+	mt7615_tm_set_tx_antenna(phy, en);
 	mt7615_tm_set_rx_enable(dev, !en);
 	if (!en || !skb)
 		return;
 
 	info = IEEE80211_SKB_CB(skb);
-	info->control.vif = dev->phy.monitor_vif;
+	info->control.vif = phy->monitor_vif;
 }
 
 static void
-mt7615_tm_update_params(struct mt7615_dev *dev, u32 changed)
+mt7615_tm_update_params(struct mt7615_phy *phy, u32 changed)
 {
-	struct mt76_testmode_data *td = &dev->mt76.test;
-	bool en = dev->mt76.test.state != MT76_TM_STATE_OFF;
+	struct mt7615_dev *dev = phy->dev;
+	struct mt76_testmode_data *td = &phy->mt76->test;
+	bool en = phy->mt76->test.state != MT76_TM_STATE_OFF;
 
 	if (changed & BIT(TM_CHANGED_TXPOWER_CTRL))
 		mt7615_mcu_set_test_param(dev, MCU_ATE_SET_TX_POWER_CONTROL,
@@ -256,25 +251,25 @@ mt7615_tm_update_params(struct mt7615_dev *dev, u32 changed)
 		mt7615_mcu_set_test_param(dev, MCU_ATE_SET_FREQ_OFFSET,
 					  en, en ? td->freq_offset : 0);
 	if (changed & BIT(TM_CHANGED_TXPOWER))
-		mt7615_tm_set_tx_power(&dev->phy);
+		mt7615_tm_set_tx_power(phy);
 }
 
 static int
-mt7615_tm_set_state(struct mt76_dev *mdev, enum mt76_testmode_state state)
+mt7615_tm_set_state(struct mt76_phy *mphy, enum mt76_testmode_state state)
 {
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	struct mt76_testmode_data *td = &mdev->test;
+	struct mt7615_phy *phy = mphy->priv;
+	struct mt76_testmode_data *td = &mphy->test;
 	enum mt76_testmode_state prev_state = td->state;
 
-	mdev->test.state = state;
+	mphy->test.state = state;
 
 	if (prev_state == MT76_TM_STATE_TX_FRAMES)
-		mt7615_tm_set_tx_frames(dev, false);
+		mt7615_tm_set_tx_frames(phy, false);
 	else if (state == MT76_TM_STATE_TX_FRAMES)
-		mt7615_tm_set_tx_frames(dev, true);
+		mt7615_tm_set_tx_frames(phy, true);
 
 	if (state <= MT76_TM_STATE_IDLE)
-		mt7615_tm_init(dev);
+		mt7615_tm_init(phy);
 
 	if ((state == MT76_TM_STATE_IDLE &&
 	     prev_state == MT76_TM_STATE_OFF) ||
@@ -290,18 +285,18 @@ mt7615_tm_set_state(struct mt76_dev *mdev, enum mt76_testmode_state state)
 				changed |= BIT(i);
 		}
 
-		mt7615_tm_update_params(dev, changed);
+		mt7615_tm_update_params(phy, changed);
 	}
 
 	return 0;
 }
 
 static int
-mt7615_tm_set_params(struct mt76_dev *mdev, struct nlattr **tb,
+mt7615_tm_set_params(struct mt76_phy *mphy, struct nlattr **tb,
 		     enum mt76_testmode_state new_state)
 {
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	struct mt76_testmode_data *td = &dev->mt76.test;
+	struct mt76_testmode_data *td = &mphy->test;
+	struct mt7615_phy *phy = mphy->priv;
 	u32 changed = 0;
 	int i;
 
@@ -311,7 +306,7 @@ mt7615_tm_set_params(struct mt76_dev *mdev, struct nlattr **tb,
 	    td->state == MT76_TM_STATE_OFF)
 		return 0;
 
-	if (td->tx_antenna_mask & ~dev->phy.chainmask)
+	if (td->tx_antenna_mask & ~phy->chainmask)
 		return -EINVAL;
 
 	for (i = 0; i < ARRAY_SIZE(tm_change_map); i++) {
@@ -319,15 +314,16 @@ mt7615_tm_set_params(struct mt76_dev *mdev, struct nlattr **tb,
 			changed |= BIT(i);
 	}
 
-	mt7615_tm_update_params(dev, changed);
+	mt7615_tm_update_params(phy, changed);
 
 	return 0;
 }
 
 static int
-mt7615_tm_dump_stats(struct mt76_dev *mdev, struct sk_buff *msg)
+mt7615_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 {
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	struct mt7615_phy *phy = mphy->priv;
+	struct mt7615_dev *dev = phy->dev;
 	void *rx, *rssi;
 	int i;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index b509269df60b..ddaaad22b308 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -601,18 +601,19 @@ void mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb)
 #endif
 
 static void
-mt7915_mac_write_txwi_tm(struct mt7915_dev *dev, struct mt76_phy *mphy,
-			 __le32 *txwi, struct sk_buff *skb)
+mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
+			 struct sk_buff *skb)
 {
 #ifdef CONFIG_NL80211_TESTMODE
-	struct mt76_testmode_data *td = &dev->mt76.test;
+	struct mt76_testmode_data *td = &phy->mt76->test;
+	struct mt7915_dev *dev = phy->dev;
 	u8 rate_idx = td->tx_rate_idx;
 	u8 nss = td->tx_rate_nss;
 	u8 bw, mode;
 	u16 rateval = 0;
 	u32 val;
 
-	if (skb != dev->mt76.test.tx_skb)
+	if (skb != phy->mt76->test.tx_skb)
 		return;
 
 	switch (td->tx_rate_mode) {
@@ -644,7 +645,7 @@ mt7915_mac_write_txwi_tm(struct mt7915_dev *dev, struct mt76_phy *mphy,
 		break;
 	}
 
-	switch (mphy->chandef.width) {
+	switch (phy->mt76->chandef.width) {
 	case NL80211_CHAN_WIDTH_40:
 		bw = 1;
 		break;
@@ -902,8 +903,8 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 	}
 
-	if (mt76_testmode_enabled(&dev->mt76))
-		mt7915_mac_write_txwi_tm(dev, mphy, txwi, skb);
+	if (mt76_testmode_enabled(mphy))
+		mt7915_mac_write_txwi_tm(mphy->priv, txwi, skb);
 }
 
 int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
@@ -1022,20 +1023,19 @@ mt7915_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
 		status.rate = &msta->stats.tx_rate;
 	}
 
-	hw = mt76_tx_status_get_hw(mdev, skb);
-
 #ifdef CONFIG_NL80211_TESTMODE
-	if (skb == mdev->test.tx_skb) {
+	if (mt76_is_testmode_skb(mdev, skb, &hw)) {
 		struct mt7915_phy *phy = mt7915_hw_phy(hw);
 		struct ieee80211_vif *vif = phy->monitor_vif;
 		struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 
 		mt76_tx_complete_skb(mdev, mvif->sta.wcid.idx, skb);
-
 		return;
 	}
 #endif
 
+	hw = mt76_tx_status_get_hw(mdev, skb);
+
 	if (info->flags & IEEE80211_TX_CTL_AMPDU)
 		info->flags |= IEEE80211_TX_STAT_AMPDU;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 0c82aa2ef219..666269b580fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -44,12 +44,12 @@ static int mt7915_start(struct ieee80211_hw *hw)
 		mt7915_mac_enable_nf(dev, 1);
 	}
 
-	mt7915_mcu_set_sku_en(phy, !mt76_testmode_enabled(&dev->mt76));
+	mt7915_mcu_set_sku_en(phy, !mt76_testmode_enabled(phy->mt76));
 	mt7915_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
-	if (!mt76_testmode_enabled(&dev->mt76))
+	if (!mt76_testmode_enabled(phy->mt76))
 		ieee80211_queue_delayed_work(hw, &phy->mac_work,
 					     MT7915_WATCHDOG_TIME);
 
@@ -70,7 +70,7 @@ static void mt7915_stop(struct ieee80211_hw *hw)
 
 	mutex_lock(&dev->mt76.mutex);
 
-	mt76_testmode_reset(&dev->mt76, true);
+	mt76_testmode_reset(phy->mt76, true);
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
@@ -153,7 +153,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	mt76_testmode_reset(&dev->mt76, true);
+	mt76_testmode_reset(phy->mt76, true);
 
 	if (vif->type == NL80211_IFTYPE_MONITOR &&
 	    is_zero_ether_addr(vif->addr))
@@ -228,7 +228,7 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 	/* TODO: disable beacon for the bss */
 
 	mutex_lock(&dev->mt76.mutex);
-	mt76_testmode_reset(&dev->mt76, true);
+	mt76_testmode_reset(phy->mt76, true);
 	mutex_unlock(&dev->mt76.mutex);
 
 	if (vif == phy->monitor_vif)
@@ -298,7 +298,7 @@ int mt7915_set_channel(struct mt7915_phy *phy)
 
 	mt76_txq_schedule_all(phy->mt76);
 
-	if (!mt76_testmode_enabled(&dev->mt76))
+	if (!mt76_testmode_enabled(phy->mt76))
 		ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
 					     MT7915_WATCHDOG_TIME);
 
@@ -365,9 +365,9 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
 #ifdef CONFIG_NL80211_TESTMODE
-		if (dev->mt76.test.state != MT76_TM_STATE_OFF) {
+		if (phy->mt76->test.state != MT76_TM_STATE_OFF) {
 			mutex_lock(&dev->mt76.mutex);
-			mt76_testmode_reset(&dev->mt76, false);
+			mt76_testmode_reset(phy->mt76, false);
 			mutex_unlock(&dev->mt76.mutex);
 		}
 #endif
@@ -396,7 +396,7 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 
 		mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
 			       enabled);
-		mt76_testmode_reset(&dev->mt76, true);
+		mt76_testmode_reset(phy->mt76, true);
 		mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 623b7b6d9e83..4aa76c7a9645 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3183,6 +3183,7 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 	struct mt7915_dev *dev = phy->dev;
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	int freq1 = chandef->center_freq1;
+	bool ext_phy = phy != &dev->phy;
 	struct {
 		u8 control_ch;
 		u8 center_ch;
@@ -3206,16 +3207,21 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 		.bw = mt7915_mcu_chan_bw(chandef),
 		.tx_streams_num = hweight8(phy->mt76->antenna_mask),
 		.rx_streams = phy->mt76->antenna_mask,
-		.band_idx = phy != &dev->phy,
+		.band_idx = ext_phy,
 		.channel_band = chandef->chan->band,
 	};
 
 #ifdef CONFIG_NL80211_TESTMODE
-	if (dev->mt76.test.tx_antenna_mask &&
-	    (dev->mt76.test.state == MT76_TM_STATE_TX_FRAMES ||
-	     dev->mt76.test.state == MT76_TM_STATE_RX_FRAMES)) {
-		req.tx_streams_num = fls(dev->mt76.test.tx_antenna_mask);
-		req.rx_streams = dev->mt76.test.tx_antenna_mask;
+	if (phy->mt76->test.tx_antenna_mask &&
+	    (phy->mt76->test.state == MT76_TM_STATE_TX_FRAMES ||
+	     phy->mt76->test.state == MT76_TM_STATE_RX_FRAMES)) {
+		req.tx_streams_num = fls(phy->mt76->test.tx_antenna_mask);
+		req.rx_streams = phy->mt76->test.tx_antenna_mask;
+
+		if (ext_phy) {
+			req.tx_streams_num = 2;
+			req.rx_streams >>= 2;
+		}
 	}
 #endif
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index fe56ab18e974..e648f718adb8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -70,8 +70,8 @@ mt7915_tm_set_tx_power(struct mt7915_phy *phy)
 	};
 	u8 *tx_power = NULL;
 
-	if (dev->mt76.test.state != MT76_TM_STATE_OFF)
-		tx_power = dev->mt76.test.tx_power;
+	if (phy->mt76->test.state != MT76_TM_STATE_OFF)
+		tx_power = phy->mt76->test.tx_power;
 
 	/* Tx power of the other antennas are the same as antenna 0 */
 	if (tx_power && tx_power[0])
@@ -85,11 +85,13 @@ mt7915_tm_set_tx_power(struct mt7915_phy *phy)
 }
 
 static int
-mt7915_tm_set_freq_offset(struct mt7915_dev *dev, bool en, u32 val)
+mt7915_tm_set_freq_offset(struct mt7915_phy *phy, bool en, u32 val)
 {
+	struct mt7915_dev *dev = phy->dev;
 	struct mt7915_tm_cmd req = {
 		.testmode_en = en,
 		.param_idx = MCU_ATE_SET_FREQ_OFFSET,
+		.param.freq.band = phy != &dev->phy,
 		.param.freq.freq_offset = cpu_to_le32(val),
 	};
 
@@ -115,9 +117,9 @@ mt7915_tm_mode_ctrl(struct mt7915_dev *dev, bool enable)
 }
 
 static int
-mt7915_tm_set_trx(struct mt7915_dev *dev, struct mt7915_phy *phy,
-		  int type, bool en)
+mt7915_tm_set_trx(struct mt7915_phy *phy, int type, bool en)
 {
+	struct mt7915_dev *dev = phy->dev;
 	struct mt7915_tm_cmd req = {
 		.testmode_en = 1,
 		.param_idx = MCU_ATE_SET_TRX,
@@ -131,14 +133,15 @@ mt7915_tm_set_trx(struct mt7915_dev *dev, struct mt7915_phy *phy,
 }
 
 static void
-mt7915_tm_reg_backup_restore(struct mt7915_dev *dev, struct mt7915_phy *phy)
+mt7915_tm_reg_backup_restore(struct mt7915_phy *phy)
 {
 	int n_regs = ARRAY_SIZE(reg_backup_list);
+	struct mt7915_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
 	u32 *b = dev->test.reg_backup;
 	int i;
 
-	if (dev->mt76.test.state == MT76_TM_STATE_OFF) {
+	if (dev->mphy.test.state == MT76_TM_STATE_OFF) {
 		for (i = 0; i < n_regs; i++)
 			mt76_wr(dev, reg_backup_list[i].band[ext_phy], b[i]);
 		return;
@@ -182,95 +185,101 @@ mt7915_tm_reg_backup_restore(struct mt7915_dev *dev, struct mt7915_phy *phy)
 }
 
 static void
-mt7915_tm_init(struct mt7915_dev *dev)
+mt7915_tm_init(struct mt7915_phy *phy)
 {
-	bool en = !(dev->mt76.test.state == MT76_TM_STATE_OFF);
+	bool en = !(phy->mt76->test.state == MT76_TM_STATE_OFF);
+	struct mt7915_dev *dev = phy->dev;
 
-	if (!test_bit(MT76_STATE_RUNNING, &dev->phy.mt76->state))
+	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
 		return;
 
 	mt7915_tm_mode_ctrl(dev, en);
-	mt7915_tm_reg_backup_restore(dev, &dev->phy);
-	mt7915_tm_set_trx(dev, &dev->phy, TM_MAC_TXRX, !en);
+	mt7915_tm_reg_backup_restore(phy);
+	mt7915_tm_set_trx(phy, TM_MAC_TXRX, !en);
 
-	mt7915_mcu_add_bss_info(&dev->phy, dev->phy.monitor_vif, en);
+	mt7915_mcu_add_bss_info(phy, phy->monitor_vif, en);
 }
 
 static void
-mt7915_tm_set_tx_frames(struct mt7915_dev *dev, bool en)
+mt7915_tm_set_tx_frames(struct mt7915_phy *phy, bool en)
 {
 	static const u8 spe_idx_map[] = {0, 0, 1, 0, 3, 2, 4, 0,
 					 9, 8, 6, 10, 16, 12, 18, 0};
-	struct sk_buff *skb = dev->mt76.test.tx_skb;
+	struct sk_buff *skb = phy->mt76->test.tx_skb;
+	struct mt7915_dev *dev = phy->dev;
 	struct ieee80211_tx_info *info;
 
-	mt7915_tm_set_trx(dev, &dev->phy, TM_MAC_RX_RXV, false);
+	mt7915_tm_set_trx(phy, TM_MAC_RX_RXV, false);
 
 	if (en) {
-		u8 tx_ant = dev->mt76.test.tx_antenna_mask;
+		u8 tx_ant = phy->mt76->test.tx_antenna_mask;
 
 		mutex_unlock(&dev->mt76.mutex);
-		mt7915_set_channel(&dev->phy);
+		mt7915_set_channel(phy);
 		mutex_lock(&dev->mt76.mutex);
 
-		mt7915_mcu_set_chan_info(&dev->phy, MCU_EXT_CMD_SET_RX_PATH);
+		mt7915_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
+
+		if (phy != &dev->phy)
+			tx_ant >>= 2;
 		dev->test.spe_idx = spe_idx_map[tx_ant];
 	}
 
-	mt7915_tm_set_trx(dev, &dev->phy, TM_MAC_TX, en);
+	mt7915_tm_set_trx(phy, TM_MAC_TX, en);
 
 	if (!en || !skb)
 		return;
 
 	info = IEEE80211_SKB_CB(skb);
-	info->control.vif = dev->phy.monitor_vif;
+	info->control.vif = phy->monitor_vif;
 }
 
 static void
-mt7915_tm_set_rx_frames(struct mt7915_dev *dev, bool en)
+mt7915_tm_set_rx_frames(struct mt7915_phy *phy, bool en)
 {
+	struct mt7915_dev *dev = phy->dev;
 	if (en) {
 		mutex_unlock(&dev->mt76.mutex);
-		mt7915_set_channel(&dev->phy);
+		mt7915_set_channel(phy);
 		mutex_lock(&dev->mt76.mutex);
 
-		mt7915_mcu_set_chan_info(&dev->phy, MCU_EXT_CMD_SET_RX_PATH);
+		mt7915_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
 	}
 
-	mt7915_tm_set_trx(dev, &dev->phy, TM_MAC_RX_RXV, en);
+	mt7915_tm_set_trx(phy, TM_MAC_RX_RXV, en);
 }
 
 static void
-mt7915_tm_update_params(struct mt7915_dev *dev, u32 changed)
+mt7915_tm_update_params(struct mt7915_phy *phy, u32 changed)
 {
-	struct mt76_testmode_data *td = &dev->mt76.test;
-	bool en = dev->mt76.test.state != MT76_TM_STATE_OFF;
+	struct mt76_testmode_data *td = &phy->mt76->test;
+	bool en = phy->mt76->test.state != MT76_TM_STATE_OFF;
 
 	if (changed & BIT(TM_CHANGED_FREQ_OFFSET))
-		mt7915_tm_set_freq_offset(dev, en, en ? td->freq_offset : 0);
+		mt7915_tm_set_freq_offset(phy, en, en ? td->freq_offset : 0);
 	if (changed & BIT(TM_CHANGED_TXPOWER))
-		mt7915_tm_set_tx_power(&dev->phy);
+		mt7915_tm_set_tx_power(phy);
 }
 
 static int
-mt7915_tm_set_state(struct mt76_dev *mdev, enum mt76_testmode_state state)
+mt7915_tm_set_state(struct mt76_phy *mphy, enum mt76_testmode_state state)
 {
-	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-	struct mt76_testmode_data *td = &mdev->test;
+	struct mt76_testmode_data *td = &mphy->test;
+	struct mt7915_phy *phy = mphy->priv;
 	enum mt76_testmode_state prev_state = td->state;
 
-	mdev->test.state = state;
+	mphy->test.state = state;
 
 	if (prev_state == MT76_TM_STATE_TX_FRAMES)
-		mt7915_tm_set_tx_frames(dev, false);
+		mt7915_tm_set_tx_frames(phy, false);
 	else if (state == MT76_TM_STATE_TX_FRAMES)
-		mt7915_tm_set_tx_frames(dev, true);
+		mt7915_tm_set_tx_frames(phy, true);
 	else if (prev_state == MT76_TM_STATE_RX_FRAMES)
-		mt7915_tm_set_rx_frames(dev, false);
+		mt7915_tm_set_rx_frames(phy, false);
 	else if (state == MT76_TM_STATE_RX_FRAMES)
-		mt7915_tm_set_rx_frames(dev, true);
+		mt7915_tm_set_rx_frames(phy, true);
 	else if (prev_state == MT76_TM_STATE_OFF || state == MT76_TM_STATE_OFF)
-		mt7915_tm_init(dev);
+		mt7915_tm_init(phy);
 
 	if ((state == MT76_TM_STATE_IDLE &&
 	     prev_state == MT76_TM_STATE_OFF) ||
@@ -286,18 +295,18 @@ mt7915_tm_set_state(struct mt76_dev *mdev, enum mt76_testmode_state state)
 				changed |= BIT(i);
 		}
 
-		mt7915_tm_update_params(dev, changed);
+		mt7915_tm_update_params(phy, changed);
 	}
 
 	return 0;
 }
 
 static int
-mt7915_tm_set_params(struct mt76_dev *mdev, struct nlattr **tb,
+mt7915_tm_set_params(struct mt76_phy *mphy, struct nlattr **tb,
 		     enum mt76_testmode_state new_state)
 {
-	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-	struct mt76_testmode_data *td = &dev->mt76.test;
+	struct mt76_testmode_data *td = &mphy->test;
+	struct mt7915_phy *phy = mphy->priv;
 	u32 changed = 0;
 	int i;
 
@@ -307,7 +316,7 @@ mt7915_tm_set_params(struct mt76_dev *mdev, struct nlattr **tb,
 	    td->state == MT76_TM_STATE_OFF)
 		return 0;
 
-	if (td->tx_antenna_mask & ~dev->phy.chainmask)
+	if (td->tx_antenna_mask & ~phy->chainmask)
 		return -EINVAL;
 
 	for (i = 0; i < ARRAY_SIZE(tm_change_map); i++) {
@@ -315,15 +324,16 @@ mt7915_tm_set_params(struct mt76_dev *mdev, struct nlattr **tb,
 			changed |= BIT(i);
 	}
 
-	mt7915_tm_update_params(dev, changed);
+	mt7915_tm_update_params(phy, changed);
 
 	return 0;
 }
 
 static int
-mt7915_tm_dump_stats(struct mt76_dev *mdev, struct sk_buff *msg)
+mt7915_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 {
-	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
+	struct mt7915_phy *phy = mphy->priv;
+	struct mt7915_dev *dev = phy->dev;
 	void *rx, *rssi;
 	int i;
 
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 581eb56dc4be..184964b9bd42 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -19,11 +19,11 @@ static const struct nla_policy mt76_tm_policy[NUM_MT76_TM_ATTRS] = {
 	[MT76_TM_ATTR_FREQ_OFFSET] = { .type = NLA_U32 },
 };
 
-void mt76_testmode_tx_pending(struct mt76_dev *dev)
+void mt76_testmode_tx_pending(struct mt76_phy *phy)
 {
-	struct mt76_testmode_data *td = &dev->test;
+	struct mt76_testmode_data *td = &phy->test;
+	struct mt76_dev *dev = phy->dev;
 	struct mt76_wcid *wcid = &dev->global_wcid;
-	struct mt76_phy *phy = &dev->phy;
 	struct sk_buff *skb = td->tx_skb;
 	struct mt76_queue *q;
 	int qid;
@@ -56,10 +56,9 @@ void mt76_testmode_tx_pending(struct mt76_dev *dev)
 
 
 static int
-mt76_testmode_tx_init(struct mt76_dev *dev)
+mt76_testmode_tx_init(struct mt76_phy *phy)
 {
-	struct mt76_testmode_data *td = &dev->test;
-	struct mt76_phy *phy = &dev->phy;
+	struct mt76_testmode_data *td = &phy->test;
 	struct ieee80211_tx_info *info;
 	struct ieee80211_hdr *hdr;
 	struct sk_buff *skb;
@@ -67,6 +66,7 @@ mt76_testmode_tx_init(struct mt76_dev *dev)
 		 IEEE80211_FCTL_FROMDS;
 	struct ieee80211_tx_rate *rate;
 	u8 max_nss = hweight8(phy->antenna_mask);
+	bool ext_phy = phy != &phy->dev->phy;
 
 	if (td->tx_antenna_mask)
 		max_nss = min_t(u8, max_nss, hweight8(td->tx_antenna_mask));
@@ -88,6 +88,9 @@ mt76_testmode_tx_init(struct mt76_dev *dev)
 		      IEEE80211_TX_CTL_NO_ACK |
 		      IEEE80211_TX_CTL_NO_PS_BUFFER;
 
+	if (ext_phy)
+		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
+
 	if (td->tx_rate_mode > MT76_TM_TX_MODE_VHT)
 		goto out;
 
@@ -166,9 +169,10 @@ mt76_testmode_tx_init(struct mt76_dev *dev)
 }
 
 static void
-mt76_testmode_tx_start(struct mt76_dev *dev)
+mt76_testmode_tx_start(struct mt76_phy *phy)
 {
-	struct mt76_testmode_data *td = &dev->test;
+	struct mt76_testmode_data *td = &phy->test;
+	struct mt76_dev *dev = phy->dev;
 
 	td->tx_queued = 0;
 	td->tx_done = 0;
@@ -177,9 +181,10 @@ mt76_testmode_tx_start(struct mt76_dev *dev)
 }
 
 static void
-mt76_testmode_tx_stop(struct mt76_dev *dev)
+mt76_testmode_tx_stop(struct mt76_phy *phy)
 {
-	struct mt76_testmode_data *td = &dev->test;
+	struct mt76_testmode_data *td = &phy->test;
+	struct mt76_dev *dev = phy->dev;
 
 	mt76_worker_disable(&dev->tx_worker);
 
@@ -206,9 +211,9 @@ mt76_testmode_param_present(struct mt76_testmode_data *td, u16 idx)
 }
 
 static void
-mt76_testmode_init_defaults(struct mt76_dev *dev)
+mt76_testmode_init_defaults(struct mt76_phy *phy)
 {
-	struct mt76_testmode_data *td = &dev->test;
+	struct mt76_testmode_data *td = &phy->test;
 
 	if (td->tx_msdu_len > 0)
 		return;
@@ -220,49 +225,50 @@ mt76_testmode_init_defaults(struct mt76_dev *dev)
 }
 
 static int
-__mt76_testmode_set_state(struct mt76_dev *dev, enum mt76_testmode_state state)
+__mt76_testmode_set_state(struct mt76_phy *phy, enum mt76_testmode_state state)
 {
-	enum mt76_testmode_state prev_state = dev->test.state;
+	enum mt76_testmode_state prev_state = phy->test.state;
+	struct mt76_dev *dev = phy->dev;
 	int err;
 
 	if (prev_state == MT76_TM_STATE_TX_FRAMES)
-		mt76_testmode_tx_stop(dev);
+		mt76_testmode_tx_stop(phy);
 
 	if (state == MT76_TM_STATE_TX_FRAMES) {
-		err = mt76_testmode_tx_init(dev);
+		err = mt76_testmode_tx_init(phy);
 		if (err)
 			return err;
 	}
 
-	err = dev->test_ops->set_state(dev, state);
+	err = dev->test_ops->set_state(phy, state);
 	if (err) {
 		if (state == MT76_TM_STATE_TX_FRAMES)
-			mt76_testmode_tx_stop(dev);
+			mt76_testmode_tx_stop(phy);
 
 		return err;
 	}
 
 	if (state == MT76_TM_STATE_TX_FRAMES)
-		mt76_testmode_tx_start(dev);
+		mt76_testmode_tx_start(phy);
 	else if (state == MT76_TM_STATE_RX_FRAMES) {
-		memset(&dev->test.rx_stats, 0, sizeof(dev->test.rx_stats));
+		memset(&phy->test.rx_stats, 0, sizeof(phy->test.rx_stats));
 	}
 
-	dev->test.state = state;
+	phy->test.state = state;
 
 	return 0;
 }
 
-int mt76_testmode_set_state(struct mt76_dev *dev, enum mt76_testmode_state state)
+int mt76_testmode_set_state(struct mt76_phy *phy, enum mt76_testmode_state state)
 {
-	struct mt76_testmode_data *td = &dev->test;
-	struct ieee80211_hw *hw = dev->phy.hw;
+	struct mt76_testmode_data *td = &phy->test;
+	struct ieee80211_hw *hw = phy->hw;
 
 	if (state == td->state && state == MT76_TM_STATE_OFF)
 		return 0;
 
 	if (state > MT76_TM_STATE_OFF &&
-	    (!test_bit(MT76_STATE_RUNNING, &dev->phy.state) ||
+	    (!test_bit(MT76_STATE_RUNNING, &phy->state) ||
 	     !(hw->conf.flags & IEEE80211_CONF_MONITOR)))
 		return -ENOTCONN;
 
@@ -270,12 +276,12 @@ int mt76_testmode_set_state(struct mt76_dev *dev, enum mt76_testmode_state state
 	    td->state != MT76_TM_STATE_IDLE) {
 		int ret;
 
-		ret = __mt76_testmode_set_state(dev, MT76_TM_STATE_IDLE);
+		ret = __mt76_testmode_set_state(phy, MT76_TM_STATE_IDLE);
 		if (ret)
 			return ret;
 	}
 
-	return __mt76_testmode_set_state(dev, state);
+	return __mt76_testmode_set_state(phy, state);
 
 }
 EXPORT_SYMBOL(mt76_testmode_set_state);
@@ -301,8 +307,9 @@ int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt76_phy *phy = hw->priv;
 	struct mt76_dev *dev = phy->dev;
-	struct mt76_testmode_data *td = &dev->test;
+	struct mt76_testmode_data *td = &phy->test;
 	struct nlattr *tb[NUM_MT76_TM_ATTRS];
+	bool ext_phy = phy != &dev->phy;
 	u32 state;
 	int err;
 	int i;
@@ -320,11 +327,11 @@ int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mutex_lock(&dev->mutex);
 
 	if (tb[MT76_TM_ATTR_RESET]) {
-		mt76_testmode_set_state(dev, MT76_TM_STATE_OFF);
+		mt76_testmode_set_state(phy, MT76_TM_STATE_OFF);
 		memset(td, 0, sizeof(*td));
 	}
 
-	mt76_testmode_init_defaults(dev);
+	mt76_testmode_init_defaults(phy);
 
 	if (tb[MT76_TM_ATTR_TX_COUNT])
 		td->tx_count = nla_get_u32(tb[MT76_TM_ATTR_TX_COUNT]);
@@ -350,8 +357,8 @@ int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_RATE_LDPC], &td->tx_rate_ldpc, 0, 1) ||
 	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_RATE_STBC], &td->tx_rate_stbc, 0, 1) ||
 	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_LTF], &td->tx_ltf, 0, 2) ||
-	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_ANTENNA], &td->tx_antenna_mask, 1,
-			   phy->antenna_mask) ||
+	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_ANTENNA], &td->tx_antenna_mask,
+			   1 << (ext_phy * 2), phy->antenna_mask << (ext_phy * 2)) ||
 	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_POWER_CONTROL],
 			   &td->tx_power_control, 0, 1))
 		goto out;
@@ -382,7 +389,7 @@ int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 
 	if (dev->test_ops->set_params) {
-		err = dev->test_ops->set_params(dev, tb, state);
+		err = dev->test_ops->set_params(phy, tb, state);
 		if (err)
 			goto out;
 	}
@@ -393,7 +400,7 @@ int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	err = 0;
 	if (tb[MT76_TM_ATTR_STATE])
-		err = mt76_testmode_set_state(dev, state);
+		err = mt76_testmode_set_state(phy, state);
 
 out:
 	mutex_unlock(&dev->mutex);
@@ -403,9 +410,10 @@ int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 EXPORT_SYMBOL(mt76_testmode_cmd);
 
 static int
-mt76_testmode_dump_stats(struct mt76_dev *dev, struct sk_buff *msg)
+mt76_testmode_dump_stats(struct mt76_phy *phy, struct sk_buff *msg)
 {
-	struct mt76_testmode_data *td = &dev->test;
+	struct mt76_testmode_data *td = &phy->test;
+	struct mt76_dev *dev = phy->dev;
 	u64 rx_packets = 0;
 	u64 rx_fcs_error = 0;
 	int i;
@@ -425,7 +433,7 @@ mt76_testmode_dump_stats(struct mt76_dev *dev, struct sk_buff *msg)
 		return -EMSGSIZE;
 
 	if (dev->test_ops->dump_stats)
-		return dev->test_ops->dump_stats(dev, msg);
+		return dev->test_ops->dump_stats(phy, msg);
 
 	return 0;
 }
@@ -435,7 +443,7 @@ int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
 {
 	struct mt76_phy *phy = hw->priv;
 	struct mt76_dev *dev = phy->dev;
-	struct mt76_testmode_data *td = &dev->test;
+	struct mt76_testmode_data *td = &phy->test;
 	struct nlattr *tb[NUM_MT76_TM_ATTRS] = {};
 	int err = 0;
 	void *a;
@@ -461,14 +469,14 @@ int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
 
 		a = nla_nest_start(msg, MT76_TM_ATTR_STATS);
 		if (a) {
-			err = mt76_testmode_dump_stats(dev, msg);
+			err = mt76_testmode_dump_stats(phy, msg);
 			nla_nest_end(msg, a);
 		}
 
 		goto out;
 	}
 
-	mt76_testmode_init_defaults(dev);
+	mt76_testmode_init_defaults(phy);
 
 	err = -EMSGSIZE;
 	if (nla_put_u32(msg, MT76_TM_ATTR_STATE, td->state))
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 65360067b8fa..29496150a10d 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -202,16 +202,22 @@ void mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *sk
 	struct ieee80211_hw *hw;
 	struct sk_buff_head list;
 
+	mt76_tx_check_non_aql(dev, wcid_idx, skb);
+
 #ifdef CONFIG_NL80211_TESTMODE
-	if (skb == dev->test.tx_skb) {
-		dev->test.tx_done++;
-		if (dev->test.tx_queued == dev->test.tx_done)
+	if (mt76_is_testmode_skb(dev, skb, &hw)) {
+		struct mt76_phy *phy = hw->priv;
+
+		if (skb == phy->test.tx_skb)
+			phy->test.tx_done++;
+		if (phy->test.tx_queued == phy->test.tx_done)
 			wake_up(&dev->tx_wait);
+
+		ieee80211_free_txskb(hw, skb);
+		return;
 	}
 #endif
 
-	mt76_tx_check_non_aql(dev, wcid_idx, skb);
-
 	if (!skb->prev) {
 		hw = mt76_tx_status_get_hw(dev, skb);
 		ieee80211_free_txskb(hw, skb);
@@ -261,7 +267,7 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	int qid = skb_get_queue_mapping(skb);
 	bool ext_phy = phy != &dev->phy;
 
-	if (mt76_testmode_enabled(dev)) {
+	if (mt76_testmode_enabled(phy)) {
 		ieee80211_free_txskb(phy->hw, skb);
 		return;
 	}
@@ -533,8 +539,10 @@ void mt76_tx_worker(struct mt76_worker *w)
 		mt76_txq_schedule_all(dev->phy2);
 
 #ifdef CONFIG_NL80211_TESTMODE
-	if (dev->test.tx_pending)
-		mt76_testmode_tx_pending(dev);
+	if (dev->phy.test.tx_pending)
+		mt76_testmode_tx_pending(&dev->phy);
+	if (dev->phy2 && dev->phy2->test.tx_pending)
+		mt76_testmode_tx_pending(dev->phy2);
 #endif
 }
 
-- 
2.17.1

