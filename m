Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D86F610DE0E
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfK3Paw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:30:52 -0500
Received: from nbd.name ([46.4.11.11]:56080 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbfK3Pau (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iE5WQtG2XYeHzxFbD4Q36r7+z4h3394FHy33Gg+J58E=; b=Lwd5bbIHPB9HHWtKAwon1WXwWs
        B2puWhb0KU2hOKUR9Prj+kt7d/fiVBr7ZocIvpr0gJiEE6y3kZiK7jLzXG826MCAl4fv+NvfEwnsO
        i5eDD9r5+VdFjbgbj7T+nyfU4RWQy8KHODF8yu4oef85QVSggZb/Co5NwSCqIhLfXUdM=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hs-0006iU-6I
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:48 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0E440721EBEE; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 18/29] mt76: mt7615: add dual-phy support for mac80211 ops
Date:   Sat, 30 Nov 2019 16:30:34 +0100
Message-Id: <20191130153045.28105-18-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allows them to be used by a separately registered wiphy later

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  15 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  96 ++++++++----
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 145 +++++++++++-------
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  42 +++--
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  47 +++++-
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |   5 +-
 6 files changed, 242 insertions(+), 108 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index f4dc756bad4b..3d8bc93fa8d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -50,7 +50,7 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 		 MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN |
 		 MT_TMAC_CTCR0_INS_DDLMT_EN);
 
-	mt7615_mcu_set_rts_thresh(dev, 0x92b);
+	mt7615_mcu_set_rts_thresh(&dev->phy, 0x92b);
 	mt7615_mac_set_scs(dev, true);
 
 	mt76_rmw(dev, MT_AGG_SCR, MT_AGG_SCR_NLNAV_MID_PTEC_DIS,
@@ -132,7 +132,7 @@ static int mt7615_init_hardware(struct mt7615_dev *dev)
 	mt7615_mcu_set_eeprom(dev);
 	mt7615_mac_init(dev);
 	mt7615_phy_init(dev);
-	mt7615_mcu_ctrl_pm_state(dev, 0);
+	mt7615_mcu_ctrl_pm_state(dev, 0, 0);
 	mt7615_mcu_del_wtbl_all(dev);
 
 	/* Beacon and mgmt frames should occupy wcid 0 */
@@ -246,11 +246,9 @@ mt7615_regd_notifier(struct wiphy *wiphy,
 		     struct regulatory_request *request)
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
-	struct mt7615_dev *dev = hw->priv;
-	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
-
-	if (request->dfs_region == dev->mt76.region)
-		return;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	struct cfg80211_chan_def *chandef = &mphy->chandef;
 
 	dev->mt76.region = request->dfs_region;
 
@@ -271,6 +269,9 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	struct wiphy *wiphy = hw->wiphy;
 	int ret;
 
+	dev->phy.dev = dev;
+	dev->phy.mt76 = &dev->mt76.phy;
+	dev->mt76.phy.priv = &dev->phy;
 	INIT_DELAYED_WORK(&dev->mt76.mac_work, mt7615_mac_work);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
 	spin_lock_init(&dev->sta_poll_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index bf9c8006eb15..967388e88503 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -49,13 +49,20 @@ void mt7615_mac_reset_counters(struct mt7615_dev *dev)
 		mt76_rr(dev, MT_TX_AGG_CNT(i));
 
 	memset(dev->mt76.aggr_stats, 0, sizeof(dev->mt76.aggr_stats));
-
-	/* TODO: add DBDC support */
+	dev->mt76.phy.survey_time = ktime_get_boottime();
+	if (dev->mt76.phy2)
+		dev->mt76.phy2->survey_time = ktime_get_boottime();
 
 	/* reset airtime counters */
 	mt76_rr(dev, MT_MIB_SDR9(0));
+	mt76_rr(dev, MT_MIB_SDR9(1));
+
 	mt76_rr(dev, MT_MIB_SDR36(0));
+	mt76_rr(dev, MT_MIB_SDR36(1));
+
 	mt76_rr(dev, MT_MIB_SDR37(0));
+	mt76_rr(dev, MT_MIB_SDR37(1));
+
 	mt76_set(dev, MT_WF_RMAC_MIB_TIME0, MT_WF_RMAC_MIB_RXTIME_CLR);
 	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0, MT_WF_RMAC_MIB_RXTIME_CLR);
 }
@@ -291,6 +298,7 @@ void mt7615_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
 
 static u16
 mt7615_mac_tx_rate_val(struct mt7615_dev *dev,
+		       struct mt76_phy *mphy,
 		       const struct ieee80211_tx_rate *rate,
 		       bool stbc, u8 *bw)
 {
@@ -319,11 +327,11 @@ mt7615_mac_tx_rate_val(struct mt7615_dev *dev,
 			*bw = 1;
 	} else {
 		const struct ieee80211_rate *r;
-		int band = dev->mphy.chandef.chan->band;
+		int band = mphy->chandef.chan->band;
 		u16 val;
 
 		nss = 1;
-		r = &mt76_hw(dev)->wiphy->bands[band]->bitrates[rate->idx];
+		r = &mphy->hw->wiphy->bands[band]->bitrates[rate->idx];
 		if (rate->flags & IEEE80211_TX_RC_USE_SHORT_PREAMBLE)
 			val = r->hw_value_short;
 		else
@@ -355,6 +363,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	bool multicast = is_multicast_ether_addr(hdr->addr1);
 	struct ieee80211_vif *vif = info->control.vif;
+	struct mt76_phy *mphy = &dev->mphy;
 	int tx_count = 8;
 	u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	__le16 fc = hdr->frame_control;
@@ -374,6 +383,9 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 		tx_count = msta->rate_count;
 	}
 
+	if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && dev->mt76.phy2)
+		mphy = dev->mt76.phy2;
+
 	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
 	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
 
@@ -431,7 +443,8 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	    !(info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE)) {
 		bool stbc = info->flags & IEEE80211_TX_CTL_STBC;
 		u8 bw;
-		u16 rateval = mt7615_mac_tx_rate_val(dev, rate, stbc, &bw);
+		u16 rateval = mt7615_mac_tx_rate_val(dev, mphy, rate, stbc,
+						     &bw);
 
 		txwi[2] |= cpu_to_le32(MT_TXD2_FIX_RATE);
 
@@ -588,10 +601,12 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev)
 	rcu_read_unlock();
 }
 
-void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
+void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates)
 {
+	struct mt7615_dev *dev = phy->dev;
+	struct mt76_phy *mphy = phy->mt76;
 	struct ieee80211_tx_rate *ref;
 	int wcid = sta->wcid.idx;
 	u32 addr = mt7615_mac_wtbl_addr(wcid);
@@ -649,11 +664,12 @@ void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 		}
 	}
 
-	val[0] = mt7615_mac_tx_rate_val(dev, &rates[0], stbc, &bw);
+	val[0] = mt7615_mac_tx_rate_val(dev, mphy, &rates[0], stbc, &bw);
 	bw_prev = bw;
 
 	if (probe_rate) {
-		probe_val = mt7615_mac_tx_rate_val(dev, probe_rate, stbc, &bw);
+		probe_val = mt7615_mac_tx_rate_val(dev, mphy, probe_rate,
+						   stbc, &bw);
 		if (bw)
 			bw_idx = 1;
 		else
@@ -662,19 +678,19 @@ void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 		probe_val = val[0];
 	}
 
-	val[1] = mt7615_mac_tx_rate_val(dev, &rates[1], stbc, &bw);
+	val[1] = mt7615_mac_tx_rate_val(dev, mphy, &rates[1], stbc, &bw);
 	if (bw_prev) {
 		bw_idx = 3;
 		bw_prev = bw;
 	}
 
-	val[2] = mt7615_mac_tx_rate_val(dev, &rates[2], stbc, &bw);
+	val[2] = mt7615_mac_tx_rate_val(dev, mphy, &rates[2], stbc, &bw);
 	if (bw_prev) {
 		bw_idx = 5;
 		bw_prev = bw;
 	}
 
-	val[3] = mt7615_mac_tx_rate_val(dev, &rates[3], stbc, &bw);
+	val[3] = mt7615_mac_tx_rate_val(dev, mphy, &rates[3], stbc, &bw);
 	if (bw_prev)
 		bw_idx = 7;
 
@@ -906,8 +922,13 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
 
 	if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) {
+		struct mt7615_phy *phy = &dev->phy;
+
+		if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && mdev->phy2)
+			phy = mdev->phy2->priv;
+
 		spin_lock_bh(&dev->mt76.lock);
-		mt7615_mac_set_rates(dev, msta, &info->control.rates[0],
+		mt7615_mac_set_rates(phy, msta, &info->control.rates[0],
 				     msta->rates);
 		msta->rate_probe = true;
 		spin_unlock_bh(&dev->mt76.lock);
@@ -962,6 +983,7 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 {
 	struct ieee80211_supported_band *sband;
 	struct mt7615_rate_set *rs;
+	struct mt76_phy *mphy;
 	int first_idx = 0, last_idx;
 	int i, idx, count;
 	bool fixed_rate, ack_timeout;
@@ -1019,7 +1041,12 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 
 		spin_lock_bh(&dev->mt76.lock);
 		if (sta->rate_probe) {
-			mt7615_mac_set_rates(dev, sta, NULL, sta->rates);
+			struct mt7615_phy *phy = &dev->phy;
+
+			if (sta->wcid.ext_phy && dev->mt76.phy2)
+				phy = dev->mt76.phy2->priv;
+
+			mt7615_mac_set_rates(phy, sta, NULL, sta->rates);
 			sta->rate_probe = false;
 		}
 		spin_unlock_bh(&dev->mt76.lock);
@@ -1059,10 +1086,14 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 		cck = true;
 		/* fall through */
 	case MT_PHY_TYPE_OFDM:
-		if (dev->mphy.chandef.chan->band == NL80211_BAND_5GHZ)
-			sband = &dev->mphy.sband_5g.sband;
+		mphy = &dev->mphy;
+		if (sta->wcid.ext_phy && dev->mt76.phy2)
+			mphy = dev->mt76.phy2;
+
+		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &mphy->sband_5g.sband;
 		else
-			sband = &dev->mphy.sband_2g.sband;
+			sband = &mphy->sband_2g.sband;
 		final_rate &= MT_TX_RATE_IDX;
 		final_rate = mt76_get_rate(&dev->mt76, sband, final_rate,
 					   cck);
@@ -1128,6 +1159,7 @@ void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 	struct ieee80211_sta *sta = NULL;
 	struct mt7615_sta *msta = NULL;
 	struct mt76_wcid *wcid;
+	struct mt76_phy *mphy = &dev->mt76.phy;
 	__le32 *txs_data = data;
 	u32 txs;
 	u8 wcidx;
@@ -1164,8 +1196,11 @@ void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 	if (wcidx >= MT7615_WTBL_STA || !sta)
 		goto out;
 
+	if (wcid->ext_phy && dev->mt76.phy2)
+		mphy = dev->mt76.phy2;
+
 	if (mt7615_fill_txs(dev, msta, &info, txs_data))
-		ieee80211_tx_status_noskb(mt76_hw(dev), sta, &info);
+		ieee80211_tx_status_noskb(mphy->hw, sta, &info);
 
 out:
 	rcu_read_unlock();
@@ -1367,27 +1402,36 @@ mt7615_mac_scs_check(struct mt7615_dev *dev)
 		mt7615_mac_set_default_sensitivity(dev);
 }
 
-void mt7615_update_channel(struct mt76_dev *mdev)
+static void
+mt7615_phy_update_channel(struct mt76_phy *mphy, int idx)
 {
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	struct mt7615_dev *dev = container_of(mphy->dev, struct mt7615_dev, mt76);
 	struct mt76_channel_state *state;
 	u64 busy_time, tx_time, rx_time, obss_time;
+	u32 obss_reg = idx ? MT_WF_RMAC_MIB_TIME6 : MT_WF_RMAC_MIB_TIME5;
 
-	/* TODO: add DBDC support */
-	busy_time = mt76_get_field(dev, MT_MIB_SDR9(0),
+	busy_time = mt76_get_field(dev, MT_MIB_SDR9(idx),
 				   MT_MIB_SDR9_BUSY_MASK);
-	tx_time = mt76_get_field(dev, MT_MIB_SDR36(0),
+	tx_time = mt76_get_field(dev, MT_MIB_SDR36(idx),
 				 MT_MIB_SDR36_TXTIME_MASK);
-	rx_time = mt76_get_field(dev, MT_MIB_SDR37(0),
+	rx_time = mt76_get_field(dev, MT_MIB_SDR37(idx),
 				 MT_MIB_SDR37_RXTIME_MASK);
-	obss_time = mt76_get_field(dev, MT_WF_RMAC_MIB_TIME5,
-				   MT_MIB_OBSSTIME_MASK);
+	obss_time = mt76_get_field(dev, obss_reg, MT_MIB_OBSSTIME_MASK);
 
-	state = mdev->phy.chan_state;
+	state = mphy->chan_state;
 	state->cc_busy += busy_time;
 	state->cc_tx += tx_time;
 	state->cc_rx += rx_time + obss_time;
 	state->cc_bss_rx += rx_time;
+}
+
+void mt7615_update_channel(struct mt76_dev *mdev)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+
+	mt7615_phy_update_channel(&mdev->phy, 0);
+	if (mdev->phy2)
+		mt7615_phy_update_channel(mdev->phy2, 1);
 
 	/* reset obss airtime */
 	mt76_set(dev, MT_WF_RMAC_MIB_TIME0, MT_WF_RMAC_MIB_RXTIME_CLR);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index cc5651a4441e..421876fc5696 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -12,26 +12,55 @@
 #include <linux/module.h>
 #include "mt7615.h"
 
+static bool mt7615_dev_running(struct mt7615_dev *dev)
+{
+	struct mt7615_phy *phy;
+
+	if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
+		return true;
+
+	phy = mt7615_ext_phy(dev);
+
+	return phy && test_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+}
+
 static int mt7615_start(struct ieee80211_hw *hw)
 {
-	struct mt7615_dev *dev = hw->priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+	bool running;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	running = mt7615_dev_running(dev);
+	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+
+	if (running)
+		goto out;
 
 	mt7615_mac_reset_counters(dev);
 
-	dev->mphy.survey_time = ktime_get_boottime();
-	set_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
 				     MT7615_WATCHDOG_TIME);
 
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
 	return 0;
 }
 
 static void mt7615_stop(struct ieee80211_hw *hw)
 {
-	struct mt7615_dev *dev = hw->priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 
-	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
-	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	mutex_lock(&dev->mt76.mutex);
+
+	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+	if (!mt7615_dev_running(dev))
+		cancel_delayed_work_sync(&dev->mt76.mac_work);
+
+	mutex_unlock(&dev->mt76.mutex);
 }
 
 static int get_omac_idx(enum nl80211_iftype type, u32 mask)
@@ -70,8 +99,10 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct mt7615_dev *dev = hw->priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 	struct mt76_txq *mtxq;
+	bool ext_phy = phy != &dev->phy;
 	int idx, ret = 0;
 
 	mutex_lock(&dev->mt76.mutex);
@@ -89,8 +120,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	}
 	mvif->omac_idx = idx;
 
-	/* TODO: DBDC support. Use band 0 for now */
-	mvif->band_idx = 0;
+	mvif->band_idx = ext_phy;
 	mvif->wmm_idx = mvif->idx % MT7615_MAX_WMM_SETS;
 
 	ret = mt7615_mcu_set_dev_info(dev, vif, 1);
@@ -103,6 +133,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 
 	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
+	mvif->sta.wcid.ext_phy = mvif->band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mt7615_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -123,7 +154,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_sta *msta = &mvif->sta;
-	struct mt7615_dev *dev = hw->priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	int idx = msta->wcid.idx;
 
 	/* TODO: disable beacon for the bss */
@@ -144,34 +175,34 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	spin_unlock_bh(&dev->sta_poll_lock);
 }
 
-static int mt7615_set_channel(struct mt7615_dev *dev)
+static int mt7615_set_channel(struct mt7615_phy *phy)
 {
+	struct mt7615_dev *dev = phy->dev;
 	int ret;
 
 	cancel_delayed_work_sync(&dev->mt76.mac_work);
 
 	mutex_lock(&dev->mt76.mutex);
-	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_RESET, &phy->mt76->state);
 
 	mt7615_dfs_check_channel(dev);
 
-	mt76_set_channel(&dev->mphy);
+	mt76_set_channel(phy->mt76);
 
-	ret = mt7615_mcu_set_channel(dev);
+	ret = mt7615_mcu_set_channel(phy);
 	if (ret)
 		goto out;
 
 	ret = mt7615_dfs_init_radar_detector(dev);
 	mt7615_mac_cca_stats_reset(dev);
-	dev->mphy.survey_time = ktime_get_boottime();
 
 	mt7615_mac_reset_counters(dev);
 
 out:
-	clear_bit(MT76_RESET, &dev->mphy.state);
+	clear_bit(MT76_RESET, &phy->mt76->state);
 	mutex_unlock(&dev->mt76.mutex);
 
-	mt76_txq_schedule_all(&dev->mphy);
+	mt76_txq_schedule_all(phy->mt76);
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
 				     MT7615_WATCHDOG_TIME);
 	return ret;
@@ -181,7 +212,7 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 			  struct ieee80211_key_conf *key)
 {
-	struct mt7615_dev *dev = hw->priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_sta *msta = sta ? (struct mt7615_sta *)sta->drv_priv :
 				  &mvif->sta;
@@ -230,27 +261,29 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 {
-	struct mt7615_dev *dev = hw->priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+	bool band = phy != &dev->phy;
 	int ret = 0;
 
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
 		ieee80211_stop_queues(hw);
-		ret = mt7615_set_channel(dev);
+		ret = mt7615_set_channel(phy);
 		ieee80211_wake_queues(hw);
 	}
 
 	mutex_lock(&dev->mt76.mutex);
 
 	if (changed & IEEE80211_CONF_CHANGE_POWER)
-		ret = mt7615_mcu_set_tx_power(dev);
+		ret = mt7615_mcu_set_tx_power(phy);
 
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
 		if (!(hw->conf.flags & IEEE80211_CONF_MONITOR))
-			dev->mt76.rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
+			phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
 		else
-			dev->mt76.rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
+			phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
 
-		mt76_wr(dev, MT_WF_RFCR, dev->mt76.rxfilter);
+		mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
 	}
 
 	mutex_unlock(&dev->mt76.mutex);
@@ -263,7 +296,7 @@ mt7615_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
 	       const struct ieee80211_tx_queue_params *params)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct mt7615_dev *dev = hw->priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 
 	queue += mvif->wmm_idx * MT7615_MAX_WMM_SETS;
 
@@ -275,7 +308,10 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 				    unsigned int *total_flags,
 				    u64 multicast)
 {
-	struct mt7615_dev *dev = hw->priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+	bool band = phy != &dev->phy;
+
 	u32 ctl_flags = MT_WF_RFCR1_DROP_ACK |
 			MT_WF_RFCR1_DROP_BF_POLL |
 			MT_WF_RFCR1_DROP_BA |
@@ -285,21 +321,21 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 
 #define MT76_FILTER(_flag, _hw) do { \
 		flags |= *total_flags & FIF_##_flag;			\
-		dev->mt76.rxfilter &= ~(_hw);				\
-		dev->mt76.rxfilter |= !(flags & FIF_##_flag) * (_hw);	\
+		phy->rxfilter &= ~(_hw);				\
+		phy->rxfilter |= !(flags & FIF_##_flag) * (_hw);	\
 	} while (0)
 
-	dev->mt76.rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
-				MT_WF_RFCR_DROP_OTHER_BEACON |
-				MT_WF_RFCR_DROP_FRAME_REPORT |
-				MT_WF_RFCR_DROP_PROBEREQ |
-				MT_WF_RFCR_DROP_MCAST_FILTERED |
-				MT_WF_RFCR_DROP_MCAST |
-				MT_WF_RFCR_DROP_BCAST |
-				MT_WF_RFCR_DROP_DUPLICATE |
-				MT_WF_RFCR_DROP_A2_BSSID |
-				MT_WF_RFCR_DROP_UNWANTED_CTL |
-				MT_WF_RFCR_DROP_STBC_MULTI);
+	phy->rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
+			   MT_WF_RFCR_DROP_OTHER_BEACON |
+			   MT_WF_RFCR_DROP_FRAME_REPORT |
+			   MT_WF_RFCR_DROP_PROBEREQ |
+			   MT_WF_RFCR_DROP_MCAST_FILTERED |
+			   MT_WF_RFCR_DROP_MCAST |
+			   MT_WF_RFCR_DROP_BCAST |
+			   MT_WF_RFCR_DROP_DUPLICATE |
+			   MT_WF_RFCR_DROP_A2_BSSID |
+			   MT_WF_RFCR_DROP_UNWANTED_CTL |
+			   MT_WF_RFCR_DROP_STBC_MULTI);
 
 	MT76_FILTER(OTHER_BSS, MT_WF_RFCR_DROP_OTHER_TIM |
 			       MT_WF_RFCR_DROP_A3_MAC |
@@ -313,12 +349,12 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 			     MT_WF_RFCR_DROP_NDPA);
 
 	*total_flags = flags;
-	mt76_wr(dev, MT_WF_RFCR, dev->mt76.rxfilter);
+	mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
 
 	if (*total_flags & FIF_CONTROL)
-		mt76_clear(dev, MT_WF_RFCR1, ctl_flags);
+		mt76_clear(dev, MT_WF_RFCR1(band), ctl_flags);
 	else
-		mt76_set(dev, MT_WF_RFCR1, ctl_flags);
+		mt76_set(dev, MT_WF_RFCR1(band), ctl_flags);
 }
 
 static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
@@ -326,7 +362,7 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_bss_conf *info,
 				    u32 changed)
 {
-	struct mt7615_dev *dev = hw->priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -341,7 +377,7 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 		mt7615_mcu_set_bss_info(dev, vif, info->enable_beacon);
 		mt7615_mcu_wtbl_bmc(dev, vif, info->enable_beacon);
 		mt7615_mcu_set_sta_rec_bmc(dev, vif, info->enable_beacon);
-		mt7615_mcu_set_bcn(dev, vif, info->enable_beacon);
+		mt7615_mcu_set_bcn(hw, vif, info->enable_beacon);
 	}
 
 	mutex_unlock(&dev->mt76.mutex);
@@ -352,10 +388,10 @@ mt7615_channel_switch_beacon(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
 			     struct cfg80211_chan_def *chandef)
 {
-	struct mt7615_dev *dev = hw->priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
-	mt7615_mcu_set_bcn(dev, vif, true);
+	mt7615_mcu_set_bcn(hw, vif, true);
 	mutex_unlock(&dev->mt76.mutex);
 }
 
@@ -415,7 +451,8 @@ static void mt7615_sta_rate_tbl_update(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_sta *sta)
 {
-	struct mt7615_dev *dev = hw->priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
 	struct ieee80211_sta_rates *sta_rates = rcu_dereference(sta->rates);
 	int i;
@@ -430,7 +467,7 @@ static void mt7615_sta_rate_tbl_update(struct ieee80211_hw *hw,
 			break;
 	}
 	msta->n_rates = i;
-	mt7615_mac_set_rates(dev, msta, NULL, msta->rates);
+	mt7615_mac_set_rates(phy, msta, NULL, msta->rates);
 	msta->rate_probe = false;
 	spin_unlock_bh(&dev->mt76.lock);
 }
@@ -439,7 +476,8 @@ static void mt7615_tx(struct ieee80211_hw *hw,
 		      struct ieee80211_tx_control *control,
 		      struct sk_buff *skb)
 {
-	struct mt7615_dev *dev = hw->priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
 	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
@@ -458,15 +496,16 @@ static void mt7615_tx(struct ieee80211_hw *hw,
 		wcid = &mvif->sta.wcid;
 	}
 
-	mt76_tx(&dev->mphy, control->sta, wcid, skb);
+	mt76_tx(mphy, control->sta, wcid, skb);
 }
 
 static int mt7615_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 {
-	struct mt7615_dev *dev = hw->priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 
 	mutex_lock(&dev->mt76.mutex);
-	mt7615_mcu_set_rts_thresh(dev, val);
+	mt7615_mcu_set_rts_thresh(phy, val);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
@@ -477,7 +516,7 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		    struct ieee80211_ampdu_params *params)
 {
 	enum ieee80211_ampdu_mlme_action action = params->action;
-	struct mt7615_dev *dev = hw->priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct ieee80211_sta *sta = params->sta;
 	struct ieee80211_txq *txq = sta->txq[params->tid];
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 04804c87463a..636496b8b339 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -616,8 +616,9 @@ int mt7615_mcu_init_mac(struct mt7615_dev *dev)
 				   &req, sizeof(req), true);
 }
 
-int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val)
+int mt7615_mcu_set_rts_thresh(struct mt7615_phy *phy, u32 val)
 {
+	struct mt7615_dev *dev = phy->dev;
 	struct {
 		u8 prot_idx;
 		u8 band;
@@ -626,7 +627,7 @@ int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val)
 		__le32 pkt_thresh;
 	} __packed req = {
 		.prot_idx = 1,
-		.band = 0,
+		.band = phy != &dev->phy,
 		.len_thresh = cpu_to_le32(val),
 		.pkt_thresh = cpu_to_le32(0x2),
 	};
@@ -672,7 +673,7 @@ int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 				   &req, sizeof(req), true);
 }
 
-int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int enter)
+int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int enter)
 {
 #define ENTER_PM_STATE	1
 #define EXIT_PM_STATE	2
@@ -695,7 +696,7 @@ int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int enter)
 	} __packed req = {
 		.pm_number = 5,
 		.pm_state = (enter) ? ENTER_PM_STATE : EXIT_PM_STATE,
-		.band_idx = 0,
+		.band_idx = band,
 	};
 
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PM_STATE_CTRL,
@@ -1099,12 +1100,14 @@ int mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 				   &req, sizeof(req), true);
 }
 
-int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+int mt7615_mcu_set_bcn(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       int en)
 {
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
 	struct ieee80211_mutable_offsets offs;
+	struct ieee80211_tx_info *info;
 	struct req {
 		u8 omac_idx;
 		u8 enable;
@@ -1128,7 +1131,7 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	};
 	struct sk_buff *skb;
 
-	skb = ieee80211_beacon_get_template(mt76_hw(dev), vif, &offs);
+	skb = ieee80211_beacon_get_template(hw, vif, &offs);
 	if (!skb)
 		return -EINVAL;
 
@@ -1138,6 +1141,11 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		return -EINVAL;
 	}
 
+	if (mvif->band_idx) {
+		info = IEEE80211_SKB_CB(skb);
+		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
+	}
+
 	mt7615_mac_write_txwi(dev, (__le32 *)(req.pkt), skb, wcid, NULL,
 			      0, NULL);
 	memcpy(req.pkt + MT_TXD_SIZE, skb->data, skb->len);
@@ -1156,14 +1164,16 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 				   &req, sizeof(req), true);
 }
 
-int mt7615_mcu_set_tx_power(struct mt7615_dev *dev)
+int mt7615_mcu_set_tx_power(struct mt7615_phy *phy)
 {
-	int i, ret, n_chains = hweight8(dev->mphy.antenna_mask);
-	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
+	struct mt7615_dev *dev = phy->dev;
+	struct mt76_phy *mphy = phy->mt76;
+	int i, ret, n_chains = hweight8(mphy->antenna_mask);
+	struct cfg80211_chan_def *chandef = &mphy->chandef;
 	int freq = chandef->center_freq1, len, target_chains;
 	u8 *req, *data, *eep = (u8 *)dev->mt76.eeprom.data;
 	enum nl80211_band band = chandef->chan->band;
-	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct ieee80211_hw *hw = mphy->hw;
 	struct {
 		u8 center_chan;
 		u8 dbdc_idx;
@@ -1172,6 +1182,7 @@ int mt7615_mcu_set_tx_power(struct mt7615_dev *dev)
 	} __packed req_hdr = {
 		.center_chan = ieee80211_frequency_to_channel(freq),
 		.band = band,
+		.dbdc_idx = phy != &dev->phy,
 	};
 	s8 tx_power;
 
@@ -1200,7 +1211,7 @@ int mt7615_mcu_set_tx_power(struct mt7615_dev *dev)
 		break;
 	}
 	tx_power = max_t(s8, tx_power, 0);
-	dev->mphy.txpower_cur = tx_power;
+	mphy->txpower_cur = tx_power;
 
 	target_chains = mt7615_ext_pa_enabled(dev, band) ? 1 : n_chains;
 	for (i = 0; i < target_chains; i++) {
@@ -1274,9 +1285,10 @@ int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev)
 				   &req, sizeof(req), false);
 }
 
-int mt7615_mcu_set_channel(struct mt7615_dev *dev)
+int mt7615_mcu_set_channel(struct mt7615_phy *phy)
 {
-	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
+	struct mt7615_dev *dev = phy->dev;
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
 	struct {
 		u8 control_chan;
@@ -1313,7 +1325,9 @@ int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 	else
 		req.switch_reason = CH_SWITCH_NORMAL;
 
-	switch (dev->mphy.chandef.width) {
+	req.band_idx = phy != &dev->phy;
+
+	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_40:
 		req.bw = CMD_CBW_40MHZ;
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 17ec75a2bcfb..527408d587c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -79,12 +79,20 @@ struct mt7615_vif {
 	struct mt7615_sta sta;
 };
 
+struct mt7615_phy {
+	struct mt76_phy *mt76;
+	struct mt7615_dev *dev;
+
+	u32 rxfilter;
+};
+
 struct mt7615_dev {
 	union { /* must be first */
 		struct mt76_dev mt76;
 		struct mt76_phy mphy;
 	};
 
+	struct mt7615_phy phy;
 	u16 chainmask;
 	u32 vif_mask;
 	u32 omac_mask;
@@ -164,6 +172,33 @@ enum mt7615_rdd_cmd {
 	RDD_RESUME_BF,
 };
 
+static inline struct mt7615_phy *
+mt7615_hw_phy(struct ieee80211_hw *hw)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	return phy->priv;
+}
+
+static inline struct mt7615_dev *
+mt7615_hw_dev(struct ieee80211_hw *hw)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	return container_of(phy->dev, struct mt7615_dev, mt76);
+}
+
+static inline struct mt7615_phy *
+mt7615_ext_phy(struct mt7615_dev *dev)
+{
+	struct mt76_phy *phy = dev->mt76.phy2;
+
+	if (!phy)
+		return NULL;
+
+	return phy->priv;
+}
+
 extern const struct ieee80211_ops mt7615_ops;
 extern struct pci_driver mt7615_pci_driver;
 
@@ -182,7 +217,7 @@ int mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
 			    struct ieee80211_vif *vif, bool enable);
 int mt7615_mcu_set_bss_info(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			    int en);
-void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
+void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates);
 int mt7615_mcu_wtbl_bmc(struct mt7615_dev *dev, struct ieee80211_vif *vif,
@@ -195,9 +230,9 @@ int mt7615_mcu_set_sta_rec_bmc(struct mt7615_dev *dev,
 			       struct ieee80211_vif *vif, bool en);
 int mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, bool en);
-int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+int mt7615_mcu_set_bcn(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       int en);
-int mt7615_mcu_set_channel(struct mt7615_dev *dev);
+int mt7615_mcu_set_channel(struct mt7615_phy *phy);
 int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 		       const struct ieee80211_tx_queue_params *params);
 int mt7615_mcu_set_tx_ba(struct mt7615_dev *dev,
@@ -261,10 +296,10 @@ int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 
 int mt7615_mcu_set_eeprom(struct mt7615_dev *dev);
 int mt7615_mcu_init_mac(struct mt7615_dev *dev);
-int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val);
-int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int enter);
+int mt7615_mcu_set_rts_thresh(struct mt7615_phy *phy, u32 val);
+int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int enter);
 int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index);
-int mt7615_mcu_set_tx_power(struct mt7615_dev *dev);
+int mt7615_mcu_set_tx_power(struct mt7615_phy *phy);
 void mt7615_mcu_exit(struct mt7615_dev *dev);
 
 int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 61a4aa9ac6e6..50da79a276f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -170,7 +170,7 @@
 #define MT_WF_RMAC_BASE			0x21200
 #define MT_WF_RMAC(ofs)			(MT_WF_RMAC_BASE + (ofs))
 
-#define MT_WF_RFCR			MT_WF_RMAC(0x000)
+#define MT_WF_RFCR(_band)		MT_WF_RMAC((_band) ? 0x100 : 0x000)
 #define MT_WF_RFCR_DROP_STBC_MULTI	BIT(0)
 #define MT_WF_RFCR_DROP_FCSFAIL		BIT(1)
 #define MT_WF_RFCR_DROP_VERSION		BIT(3)
@@ -193,7 +193,7 @@
 #define MT_WF_RFCR_DROP_NDPA		BIT(20)
 #define MT_WF_RFCR_DROP_UNWANTED_CTL	BIT(21)
 
-#define MT_WF_RFCR1			MT_WF_RMAC(0x004)
+#define MT_WF_RFCR1(_band)		MT_WF_RMAC((_band) ? 0x104 : 0x004)
 #define MT_WF_RFCR1_DROP_ACK		BIT(4)
 #define MT_WF_RFCR1_DROP_BF_POLL	BIT(5)
 #define MT_WF_RFCR1_DROP_BA		BIT(6)
@@ -207,6 +207,7 @@
 #define MT_WF_RMAC_MIB_AIRTIME0		MT_WF_RMAC(0x0380)
 
 #define MT_WF_RMAC_MIB_TIME5		MT_WF_RMAC(0x03d8)
+#define MT_WF_RMAC_MIB_TIME6		MT_WF_RMAC(0x03dc)
 #define MT_MIB_OBSSTIME_MASK		GENMASK(23, 0)
 
 #define MT_WF_DMA_BASE			0x21800
-- 
2.24.0

