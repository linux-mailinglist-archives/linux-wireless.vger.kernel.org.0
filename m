Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141531D56FF
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2020 19:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgEOREB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 May 2020 13:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgEOREA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 May 2020 13:04:00 -0400
Received: from localhost.localdomain.com (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC50220727;
        Fri, 15 May 2020 17:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589562239;
        bh=DnYr12nPVS9EeQUXyEaZpTgjDTGx3IJvGJ1P0C3zMf0=;
        h=From:To:Cc:Subject:Date:From;
        b=RWOr0ITjwB71ZYJ9KCt9iJQ/97cVv9HIonFFsjaKfh4H21bX9jBonjvs/ckUXz8WS
         P/VJwRmxLWRDsoUZKyLgFSVB2fAEZo4qW2zPu8qIergiI4BqOv6tIwY7O2PdRXr9gL
         4SRfrpuIGy6feA/YjRxGpw8fg/jtOGDNU9DpkJbw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: introduce remain_on_channel support
Date:   Fri, 15 May 2020 19:03:42 +0200
Message-Id: <d4f22fc27a0971312da92b6dca006928f2a3ccaf.1589561749.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce remain_on_channel support to mt7615 driver if the device is
running offload firmware

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 10 +++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 10 ++-
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 79 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 51 ++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 19 +++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  9 +++
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  2 +
 8 files changed, 179 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e6de4a1b8f26..e2926e091c0f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -290,6 +290,7 @@ enum {
 	MT76_STATE_POWER_OFF,
 	MT76_STATE_PS,
 	MT76_STATE_SUSPEND,
+	MT76_STATE_ROC,
 };
 
 struct mt76_hw_cap {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 1d8fdc7e062b..18a570ffb815 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -139,8 +139,10 @@ void mt7615_check_offload_capability(struct mt7615_dev *dev)
 		ieee80211_hw_set(hw, SUPPORTS_PS);
 		ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 
+		wiphy->max_remain_on_channel_duration = 5000;
 		wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
 				   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR |
+				   WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL |
 				   NL80211_FEATURE_P2P_GO_CTWIN |
 				   NL80211_FEATURE_P2P_GO_OPPPS;
 	} else {
@@ -149,6 +151,8 @@ void mt7615_check_offload_capability(struct mt7615_dev *dev)
 		dev->ops->sched_scan_start = NULL;
 		dev->ops->sched_scan_stop = NULL;
 		dev->ops->set_rekey_data = NULL;
+		dev->ops->remain_on_channel = NULL;
+		dev->ops->cancel_remain_on_channel = NULL;
 
 		wiphy->max_sched_scan_plan_interval = 0;
 		wiphy->max_sched_scan_ie_len = 0;
@@ -373,6 +377,9 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	skb_queue_head_init(&phy->scan_event_list);
 
 	INIT_WORK(&phy->ps_work, mt7615_ps_work);
+	INIT_WORK(&phy->roc_work, mt7615_roc_work);
+	timer_setup(&phy->roc_timer, mt7615_roc_timer, 0);
+	init_waitqueue_head(&phy->roc_wait);
 
 	mt7615_cap_dbdc_enable(dev);
 	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7615_ops);
@@ -437,9 +444,12 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	INIT_LIST_HEAD(&dev->sta_poll_list);
 	spin_lock_init(&dev->sta_poll_lock);
 	init_waitqueue_head(&dev->reset_wait);
+	init_waitqueue_head(&dev->phy.roc_wait);
 
 	INIT_WORK(&dev->reset_work, mt7615_mac_reset_work);
 	INIT_WORK(&dev->phy.ps_work, mt7615_ps_work);
+	INIT_WORK(&dev->phy.roc_work, mt7615_roc_work);
+	timer_setup(&dev->phy.roc_timer, mt7615_roc_timer, 0);
 
 	mt7615_init_wiphy(hw);
 	dev->mphy.sband_2g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 7d65a3fb0c23..6b5c38ab9f5d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -175,7 +175,8 @@ mt7615_get_status_freq_info(struct mt7615_dev *dev, struct mt76_phy *mphy,
 			    struct mt76_rx_status *status, u8 chfreq)
 {
 	if (!test_bit(MT76_HW_SCANNING, &mphy->state) &&
-	    !test_bit(MT76_HW_SCHED_SCANNING, &mphy->state)) {
+	    !test_bit(MT76_HW_SCHED_SCANNING, &mphy->state) &&
+	    !test_bit(MT76_STATE_ROC, &mphy->state)) {
 		status->freq = mphy->chandef.chan->center_freq;
 		status->band = mphy->chandef.chan->band;
 		return;
@@ -1849,8 +1850,13 @@ void mt7615_mac_reset_work(struct work_struct *work)
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 	cancel_delayed_work_sync(&dev->phy.mac_work);
-	if (phy2)
+	del_timer_sync(&dev->phy.roc_timer);
+	cancel_work_sync(&dev->phy.roc_work);
+	if (phy2) {
 		cancel_delayed_work_sync(&phy2->mac_work);
+		del_timer_sync(&phy2->roc_timer);
+		cancel_work_sync(&phy2->roc_work);
+	}
 
 	/* lock/unlock all queues to ensure that no tx is pending */
 	mt76_txq_schedule_all(&dev->mphy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 2e9e9d3519d7..f8cbee1770ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -72,6 +72,8 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 
 	cancel_delayed_work_sync(&phy->mac_work);
 	cancel_work_sync(&phy->ps_work);
+	del_timer_sync(&phy->roc_timer);
+	cancel_work_sync(&phy->roc_work);
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -791,6 +793,37 @@ mt7615_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	return 0;
 }
 
+static void mt7615_roc_iter(void *priv, u8 *mac,
+			    struct ieee80211_vif *vif)
+{
+	struct mt7615_phy *phy = priv;
+
+	mt7615_mcu_set_roc(phy, vif, NULL, 0);
+}
+
+void mt7615_roc_work(struct work_struct *work)
+{
+	struct mt7615_phy *phy;
+
+	phy = (struct mt7615_phy *)container_of(work, struct mt7615_phy,
+						roc_work);
+
+	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return;
+
+	ieee80211_iterate_active_interfaces(phy->mt76->hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7615_roc_iter, phy);
+	ieee80211_remain_on_channel_expired(phy->mt76->hw);
+}
+
+void mt7615_roc_timer(struct timer_list *timer)
+{
+	struct mt7615_phy *phy = from_timer(phy, timer, roc_timer);
+
+	ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
+}
+
 void mt7615_scan_work(struct work_struct *work)
 {
 	struct mt7615_phy *phy;
@@ -864,6 +897,50 @@ mt7615_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	return mt7615_mcu_sched_scan_enable(mphy->priv, vif, false);
 }
 
+static int mt7615_remain_on_channel(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_channel *chan,
+				    int duration,
+				    enum ieee80211_roc_type type)
+{
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+	int err;
+
+	if (test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return 0;
+
+	err = mt7615_mcu_set_roc(phy, vif, chan, duration);
+	if (err < 0) {
+		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		return err;
+	}
+
+	if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, HZ)) {
+		mt7615_mcu_set_roc(phy, vif, NULL, 0);
+		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int mt7615_cancel_remain_on_channel(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif)
+{
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+
+	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return 0;
+
+	del_timer_sync(&phy->roc_timer);
+	cancel_work_sync(&phy->roc_work);
+
+	mt7615_mcu_set_roc(phy, vif, NULL, 0);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int mt7615_suspend(struct ieee80211_hw *hw,
 			  struct cfg80211_wowlan *wowlan)
@@ -978,6 +1055,8 @@ const struct ieee80211_ops mt7615_ops = {
 	.cancel_hw_scan = mt7615_cancel_hw_scan,
 	.sched_scan_start = mt7615_start_sched_scan,
 	.sched_scan_stop = mt7615_stop_sched_scan,
+	.remain_on_channel = mt7615_remain_on_channel,
+	.cancel_remain_on_channel = mt7615_cancel_remain_on_channel,
 #ifdef CONFIG_PM
 	.suspend = mt7615_suspend,
 	.resume = mt7615_resume,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index b944f372738a..7eb99bde3394 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -359,6 +359,33 @@ mt7615_mcu_scan_event(struct mt7615_dev *dev, struct sk_buff *skb)
 				     MT7615_HW_SCAN_TIMEOUT);
 }
 
+static void
+mt7615_mcu_roc_event(struct mt7615_dev *dev, struct sk_buff *skb)
+{
+	struct mt7615_roc_tlv *event;
+	struct mt7615_phy *phy;
+	struct mt76_phy *mphy;
+	int duration;
+
+	skb_pull(skb, sizeof(struct mt7615_mcu_rxd));
+	event = (struct mt7615_roc_tlv *)skb->data;
+
+	if (event->dbdc_band && dev->mt76.phy2)
+		mphy = dev->mt76.phy2;
+	else
+		mphy = &dev->mt76.phy;
+
+	ieee80211_ready_on_channel(mphy->hw);
+
+	phy = (struct mt7615_phy *)mphy->priv;
+	phy->roc_grant = true;
+	wake_up(&phy->roc_wait);
+
+	duration = le32_to_cpu(event->max_interval);
+	mod_timer(&phy->roc_timer,
+		  round_jiffies_up(jiffies + msecs_to_jiffies(duration)));
+}
+
 static void
 mt7615_mcu_beacon_loss_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
@@ -426,6 +453,9 @@ mt7615_mcu_rx_unsolicited_event(struct mt7615_dev *dev, struct sk_buff *skb)
 	case MCU_EVENT_BSS_BEACON_LOSS:
 		mt7615_mcu_beacon_loss_event(dev, skb);
 		break;
+	case MCU_EVENT_ROC:
+		mt7615_mcu_roc_event(dev, skb);
+		break;
 	case MCU_EVENT_SCHED_SCAN_DONE:
 	case MCU_EVENT_SCAN_DONE:
 		mt7615_mcu_scan_event(dev, skb);
@@ -451,6 +481,7 @@ void mt7615_mcu_rx_event(struct mt7615_dev *dev, struct sk_buff *skb)
 	    rxd->eid == MCU_EVENT_SCHED_SCAN_DONE ||
 	    rxd->eid == MCU_EVENT_BSS_ABSENCE ||
 	    rxd->eid == MCU_EVENT_SCAN_DONE ||
+	    rxd->eid == MCU_EVENT_ROC ||
 	    !rxd->seq)
 		mt7615_mcu_rx_unsolicited_event(dev, skb);
 	else
@@ -3601,6 +3632,26 @@ int mt7615_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
 }
 #endif /* CONFIG_PM */
 
+int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
+		       struct ieee80211_channel *chan, int duration)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct mt7615_dev *dev = phy->dev;
+	struct mt7615_roc_tlv req = {
+		.bss_idx = mvif->idx,
+		.active = !chan,
+		.max_interval = cpu_to_le32(duration),
+		.primary_chan = chan ? chan->hw_value : 0,
+		.band = chan ? chan->band : 0,
+		.req_type = 2,
+	};
+
+	phy->roc_grant = false;
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_ROC, &req,
+				   sizeof(req), false);
+}
+
 int mt7615_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 348521b0d44c..fd40d99f5a23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -82,6 +82,7 @@ enum {
 	MCU_EVENT_ACCESS_REG = 0x02,
 	MCU_EVENT_MT_PATCH_SEM = 0x04,
 	MCU_EVENT_SCAN_DONE = 0x0d,
+	MCU_EVENT_ROC = 0x10,
 	MCU_EVENT_BSS_ABSENCE  = 0x11,
 	MCU_EVENT_BSS_BEACON_LOSS = 0x13,
 	MCU_EVENT_CH_PRIVILEGE = 0x18,
@@ -525,6 +526,23 @@ struct mt7615_gtk_rekey_tlv {
 	u8 reserverd[3];
 } __packed;
 
+struct mt7615_roc_tlv {
+	u8 bss_idx;
+	u8 token;
+	u8 active;
+	u8 primary_chan;
+	u8 sco;
+	u8 band;
+	u8 width;	/* To support 80/160MHz bandwidth */
+	u8 freq_seg1;	/* To support 80/160MHz bandwidth */
+	u8 freq_seg2;	/* To support 80/160MHz bandwidth */
+	u8 req_type;
+	u8 dbdc_band;
+	u8 rsv0;
+	__le32 max_interval;	/* ms */
+	u8 rsv1[8];
+} __packed;
+
 /* offload mcu commands */
 enum {
 	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
@@ -533,6 +551,7 @@ enum {
 	MCU_CMD_SET_BSS_CONNECTED = MCU_CE_PREFIX | 0x16,
 	MCU_CMD_SET_BSS_ABORT = MCU_CE_PREFIX | 0x17,
 	MCU_CMD_CANCEL_HW_SCAN = MCU_CE_PREFIX | 0x1b,
+	MCU_CMD_SET_ROC = MCU_CE_PREFIX | 0x1c,
 	MCU_CMD_SET_P2P_OPPPS = MCU_CE_PREFIX | 0x33,
 	MCU_CMD_SCHED_SCAN_ENABLE = MCU_CE_PREFIX | 0x61,
 	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index ebdfca64b079..71d5d5973116 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -201,6 +201,11 @@ struct mt7615_phy {
 	struct sk_buff_head scan_event_list;
 	struct delayed_work scan_work;
 
+	struct work_struct roc_work;
+	struct timer_list roc_timer;
+	wait_queue_head_t roc_wait;
+	bool roc_grant;
+
 	struct work_struct ps_work;
 };
 
@@ -441,6 +446,8 @@ static inline u16 mt7615_wtbl_size(struct mt7615_dev *dev)
 
 void mt7615_dma_reset(struct mt7615_dev *dev);
 void mt7615_scan_work(struct work_struct *work);
+void mt7615_roc_work(struct work_struct *work);
+void mt7615_roc_timer(struct timer_list *timer);
 void mt7615_ps_work(struct work_struct *work);
 void mt7615_init_txpower(struct mt7615_dev *dev,
 			 struct ieee80211_supported_band *sband);
@@ -532,6 +539,8 @@ int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy);
 
 int mt7615_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif);
+int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
+		       struct ieee80211_channel *chan, int duration);
 int mt7615_firmware_own(struct mt7615_dev *dev);
 int mt7615_driver_own(struct mt7615_dev *dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index d74253319622..c292b41c76e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -52,6 +52,8 @@ static void mt7663u_stop(struct ieee80211_hw *hw)
 
 	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 	cancel_work_sync(&phy->ps_work);
+	del_timer_sync(&phy->roc_timer);
+	cancel_work_sync(&phy->roc_work);
 	cancel_delayed_work_sync(&phy->scan_work);
 	cancel_delayed_work_sync(&phy->mac_work);
 	mt76u_stop_tx(&dev->mt76);
-- 
2.26.2

