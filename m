Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6272910DE11
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfK3Pa4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:30:56 -0500
Received: from nbd.name ([46.4.11.11]:56072 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbfK3Pat (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lmElvg9H9EmcICBbr0GOsqYaI3UmBva7JPFZezbZ5cg=; b=BupCxCdaFqIXzob2ol2NU+1HEq
        gEwkzjfohYGVnKpM7SQal6x2TZIwh/lT0cTyolcisU3VP1FW9BIjE+oqrhMEzGaJi67NyM/AQqLz3
        bW6t9LYGPVlkE6OJyXAE/EmPoZqtti4bBNA9Wkhz9LlyYk2AmFM01nin6C/rAuIyI/Qc=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006iO-TT
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:48 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0C0CF721EBE7; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 22/29] mt76: mt7615: add multiple wiphy support to the dfs support code
Date:   Sat, 30 Nov 2019 16:30:38 +0100
Message-Id: <20191130153045.28105-22-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are two DFS detectors on the chip. When using 160 MHz channel bandwidth
(not supported in dual-wiphy mode), both are used. Otherwise, one detector is
used per wiphy.
Rework the code to start/stop them separately per phy and to indicate the
radar event on the right phy based on the detector index

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  9 +--
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 63 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  5 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 18 +++++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 46 ++++++++++++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    | 19 ++----
 6 files changed, 107 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 8d80aaf9723a..c4dbc635c2c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -248,6 +248,7 @@ mt7615_regd_notifier(struct wiphy *wiphy,
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
+	struct mt7615_phy *phy = mphy->priv;
 	struct cfg80211_chan_def *chandef = &mphy->chandef;
 
 	dev->mt76.region = request->dfs_region;
@@ -255,11 +256,7 @@ mt7615_regd_notifier(struct wiphy *wiphy,
 	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
 		return;
 
-	mt7615_dfs_stop_radar_detector(dev);
-	if (request->dfs_region == NL80211_DFS_UNSET)
-		mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, 0, MT_RX_SEL0, 0);
-	else
-		mt7615_dfs_start_radar_detector(dev);
+	mt7615_dfs_init_radar_detector(phy);
 }
 
 int mt7615_register_device(struct mt7615_dev *dev)
@@ -303,7 +300,7 @@ int mt7615_register_device(struct mt7615_dev *dev)
 			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
 			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
 			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
-	dev->dfs_state = -1;
+	dev->phy.dfs_state = -1;
 
 	ret = mt76_register_device(&dev->mt76, true, mt7615_rates,
 				   ARRAY_SIZE(mt7615_rates));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 8223c7fa1c65..89d6a21820ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1497,19 +1497,14 @@ void mt7615_mac_work(struct work_struct *work)
 				     MT7615_WATCHDOG_TIME);
 }
 
-int mt7615_dfs_stop_radar_detector(struct mt7615_dev *dev)
+static void mt7615_dfs_stop_radar_detector(struct mt7615_phy *phy)
 {
-	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
-	int err;
-
-	err = mt7615_mcu_rdd_cmd(dev, RDD_STOP, 0, MT_RX_SEL0, 0);
-	if (err < 0)
-		return err;
+	struct mt7615_dev *dev = phy->dev;
 
-	if (chandef->width == NL80211_CHAN_WIDTH_160 ||
-	    chandef->width == NL80211_CHAN_WIDTH_80P80)
-		err = mt7615_mcu_rdd_cmd(dev, RDD_STOP, 1, MT_RX_SEL0, 0);
-	return err;
+	if (phy->rdd_state & BIT(0))
+		mt7615_mcu_rdd_cmd(dev, RDD_STOP, 0, MT_RX_SEL0, 0);
+	if (phy->rdd_state & BIT(1))
+		mt7615_mcu_rdd_cmd(dev, RDD_STOP, 1, MT_RX_SEL0, 0);
 }
 
 static int mt7615_dfs_start_rdd(struct mt7615_dev *dev, int chain)
@@ -1524,58 +1519,72 @@ static int mt7615_dfs_start_rdd(struct mt7615_dev *dev, int chain)
 				  MT_RX_SEL0, 1);
 }
 
-int mt7615_dfs_start_radar_detector(struct mt7615_dev *dev)
+static int mt7615_dfs_start_radar_detector(struct mt7615_phy *phy)
 {
-	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	struct mt7615_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
 	int err;
 
 	/* start CAC */
-	err = mt7615_mcu_rdd_cmd(dev, RDD_CAC_START, 0, MT_RX_SEL0, 0);
+	err = mt7615_mcu_rdd_cmd(dev, RDD_CAC_START, ext_phy, MT_RX_SEL0, 0);
 	if (err < 0)
 		return err;
 
-	/* TODO: DBDC support */
-
-	err = mt7615_dfs_start_rdd(dev, 0);
+	err = mt7615_dfs_start_rdd(dev, ext_phy);
 	if (err < 0)
 		return err;
 
+	phy->rdd_state |= BIT(ext_phy);
+
 	if (chandef->width == NL80211_CHAN_WIDTH_160 ||
 	    chandef->width == NL80211_CHAN_WIDTH_80P80) {
 		err = mt7615_dfs_start_rdd(dev, 1);
 		if (err < 0)
 			return err;
+
+		phy->rdd_state |= BIT(1);
 	}
 
 	return 0;
 }
 
-int mt7615_dfs_init_radar_detector(struct mt7615_dev *dev)
+int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy)
 {
-	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	struct mt7615_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
 	int err;
 
-	if (dev->mt76.region == NL80211_DFS_UNSET)
+	if (dev->mt76.region == NL80211_DFS_UNSET) {
+		phy->dfs_state = -1;
+		if (phy->rdd_state)
+			goto stop;
+
 		return 0;
+	}
 
-	if (test_bit(MT76_SCANNING, &dev->mphy.state))
+	if (test_bit(MT76_SCANNING, &phy->mt76->state))
 		return 0;
 
-	if (dev->dfs_state == chandef->chan->dfs_state)
+	if (phy->dfs_state == chandef->chan->dfs_state)
 		return 0;
 
-	dev->dfs_state = chandef->chan->dfs_state;
+	phy->dfs_state = chandef->chan->dfs_state;
 
 	if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
 		if (chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
-			return mt7615_dfs_start_radar_detector(dev);
+			return mt7615_dfs_start_radar_detector(phy);
 
-		return mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, 0, MT_RX_SEL0, 0);
+		return mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
+					  MT_RX_SEL0, 0);
 	}
 
-	err = mt7615_mcu_rdd_cmd(dev, RDD_NORMAL_START, 0, MT_RX_SEL0, 0);
+stop:
+	err = mt7615_mcu_rdd_cmd(dev, RDD_NORMAL_START, ext_phy, MT_RX_SEL0, 0);
 	if (err < 0)
 		return err;
 
-	return mt7615_dfs_stop_radar_detector(dev);
+	mt7615_dfs_stop_radar_detector(phy);
+	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 9b11ca218873..1650b7dfe2ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -185,15 +185,14 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 	mutex_lock(&dev->mt76.mutex);
 	set_bit(MT76_RESET, &phy->mt76->state);
 
-	mt7615_dfs_check_channel(dev);
-
+	phy->dfs_state = -1;
 	mt76_set_channel(phy->mt76);
 
 	ret = mt7615_mcu_set_channel(phy);
 	if (ret)
 		goto out;
 
-	ret = mt7615_dfs_init_radar_detector(dev);
+	ret = mt7615_dfs_init_radar_detector(phy);
 	mt7615_mac_cca_stats_reset(phy);
 
 	mt7615_mac_reset_counters(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 636496b8b339..dc0d598f5498 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -185,6 +185,21 @@ mt7615_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 		ieee80211_csa_finish(vif);
 }
 
+static void
+mt7615_mcu_rx_radar_detected(struct mt7615_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7615_mcu_rdd_report *r;
+
+	r = (struct mt7615_mcu_rdd_report *)skb->data;
+
+	if (r->idx && dev->mt76.phy2)
+		mphy = dev->mt76.phy2;
+
+	ieee80211_radar_detected(mphy->hw);
+	dev->hw_pattern++;
+}
+
 static void
 mt7615_mcu_rx_ext_event(struct mt7615_dev *dev, struct sk_buff *skb)
 {
@@ -192,8 +207,7 @@ mt7615_mcu_rx_ext_event(struct mt7615_dev *dev, struct sk_buff *skb)
 
 	switch (rxd->ext_eid) {
 	case MCU_EXT_EVENT_RDD_REPORT:
-		ieee80211_radar_detected(dev->mt76.hw);
-		dev->hw_pattern++;
+		mt7615_mcu_rx_radar_detected(dev, skb);
 		break;
 	case MCU_EXT_EVENT_CSA_NOTIFY:
 		ieee80211_iterate_active_interfaces_atomic(dev->mt76.hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 1fd7dffa6eef..f4781477fc9b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -60,6 +60,52 @@ struct mt7615_mcu_rxd {
 	u8 s2d_index;
 };
 
+struct mt7615_mcu_rdd_report {
+	struct mt7615_mcu_rxd rxd;
+
+	u8 idx;
+	u8 long_detected;
+	u8 constant_prf_detected;
+	u8 staggered_prf_detected;
+	u8 radar_type_idx;
+	u8 periodic_pulse_num;
+	u8 long_pulse_num;
+	u8 hw_pulse_num;
+
+	u8 out_lpn;
+	u8 out_spn;
+	u8 out_crpn;
+	u8 out_crpw;
+	u8 out_crbn;
+	u8 out_stgpn;
+	u8 out_stgpw;
+
+	u8 _rsv[2];
+
+	__le32 out_pri_const;
+	__le32 out_pri_stg[3];
+
+	struct {
+		__le32 start;
+		__le16 pulse_width;
+		__le16 pulse_power;
+	} long_pulse[32];
+
+	struct {
+		__le32 start;
+		__le16 pulse_width;
+		__le16 pulse_power;
+	} periodic_pulse[32];
+
+	struct {
+		__le32 start;
+		__le16 pulse_width;
+		__le16 pulse_power;
+		u8 sc_pass;
+		u8 sw_reset;
+	} hw_pulse[32];
+};
+
 #define MCU_PQ_ID(p, q)		(((p) << 15) | ((q) << 10))
 #define MCU_PKT_ID		0xa0
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index bd9014421b00..3c8d96992b60 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -89,6 +89,9 @@ struct mt7615_phy {
 	int false_cca_ofdm, false_cca_cck;
 	s8 ofdm_sensitivity;
 	s8 cck_sensitivity;
+
+	u8 rdd_state;
+	int dfs_state;
 };
 
 struct mt7615_dev {
@@ -115,7 +118,6 @@ struct mt7615_dev {
 		s16 power;
 	} radar_pattern;
 	u32 hw_pattern;
-	int dfs_state;
 
 	u8 mac_work_count;
 	bool scs_en;
@@ -243,8 +245,6 @@ void mt7615_mcu_rx_event(struct mt7615_dev *dev, struct sk_buff *skb);
 int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
 		       enum mt7615_rdd_cmd cmd, u8 index,
 		       u8 rx_sel, u8 val);
-int mt7615_dfs_start_radar_detector(struct mt7615_dev *dev);
-int mt7615_dfs_stop_radar_detector(struct mt7615_dev *dev);
 int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev);
 
 static inline bool is_mt7622(struct mt76_dev *dev)
@@ -252,17 +252,6 @@ static inline bool is_mt7622(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7622;
 }
 
-static inline void mt7615_dfs_check_channel(struct mt7615_dev *dev)
-{
-	enum nl80211_chan_width width = dev->mphy.chandef.width;
-	u32 freq = dev->mphy.chandef.chan->center_freq;
-	struct ieee80211_hw *hw = mt76_hw(dev);
-
-	if (hw->conf.chandef.chan->center_freq != freq ||
-	    hw->conf.chandef.width != width)
-		dev->dfs_state = -1;
-}
-
 static inline void mt7615_irq_enable(struct mt7615_dev *dev, u32 mask)
 {
 	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, 0, mask);
@@ -319,7 +308,7 @@ void mt7615_mac_work(struct work_struct *work);
 void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 			  struct mt76_txwi_cache *txwi);
 int mt76_dfs_start_rdd(struct mt7615_dev *dev, bool force);
-int mt7615_dfs_init_radar_detector(struct mt7615_dev *dev);
+int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy);
 
 int mt7615_init_debugfs(struct mt7615_dev *dev);
 
-- 
2.24.0

