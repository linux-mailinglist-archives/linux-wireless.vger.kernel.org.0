Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC2719C1B1
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 15:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbgDBNIF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 09:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388322AbgDBNIF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 09:08:05 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E6D4206F5;
        Thu,  2 Apr 2020 13:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585832884;
        bh=OonAIBDBrhw0BP7w+tS6g+lFnrV/8+v6hANw4eI8mO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bu73HaoVWWgDJ4t//CcAcW0qATJcsSALpq4Xnex6mYBjw34MKmsqXf4TDLfGMhcCZ
         ZOtp0gl6Ub/6nHwnyEPoaXqVx0b5EKVAJyfidpRN6w66bwNTKfkuFO9Dd+IkrQxDEb
         KJnpu+ewXO+z+n+FokOdNPh7O5nuenkj5W8KkO1Y=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 08/12] mt76: mt7615: introduce hw scan support
Date:   Thu,  2 Apr 2020 15:06:38 +0200
Message-Id: <96a3443f3ae5ddafaad87d7af73cbab687353dea.1585832458.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585832458.git.lorenzo@kernel.org>
References: <cover.1585832458.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce hw scan support to mt7663e driver

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   8 ++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  19 ++-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  34 +++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 125 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  90 +++++++++++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  11 ++
 7 files changed, 285 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6d60187e88ed..09f407cb1c48 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -275,6 +275,7 @@ enum {
 	MT76_STATE_RUNNING,
 	MT76_STATE_MCU_RUNNING,
 	MT76_SCANNING,
+	MT76_HW_SCANNING,
 	MT76_RESTART,
 	MT76_RESET,
 	MT76_MCU_RESET,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 96b37f6ebf1e..04bcc1a2aa8f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -349,8 +349,13 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	wiphy->reg_notifier = mt7615_regd_notifier;
 
+	wiphy->max_scan_ie_len = MT7615_SCAN_IE_LEN;
+	wiphy->max_scan_ssids = 4;
+
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 
+	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
 
 	if (is_mt7615(&phy->dev->mt76))
@@ -403,6 +408,8 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	if (phy)
 		return 0;
 
+	INIT_DELAYED_WORK(&phy->scan_work, mt7615_scan_work);
+
 	mt7615_cap_dbdc_enable(dev);
 	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7615_ops);
 	if (!mphy)
@@ -459,6 +466,7 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	dev->phy.mt76 = &dev->mt76.phy;
 	dev->mt76.phy.priv = &dev->phy;
 	INIT_DELAYED_WORK(&dev->mt76.mac_work, mt7615_mac_work);
+	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7615_scan_work);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
 	spin_lock_init(&dev->sta_poll_lock);
 	init_waitqueue_head(&dev->reset_wait);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 7be06ece1658..8db5a8355dd2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -164,6 +164,20 @@ void mt7615_mac_set_timing(struct mt7615_phy *phy)
 
 }
 
+static void
+mt7615_get_status_freq_info(struct mt7615_dev *dev, struct mt76_phy *mphy,
+			    struct mt76_rx_status *status, u8 chfreq)
+{
+	if (!test_bit(MT76_HW_SCANNING, &mphy->state)) {
+		status->freq = mphy->chandef.chan->center_freq;
+		status->band = mphy->chandef.chan->band;
+		return;
+	}
+
+	status->band = chfreq <= 14 ? NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
+	status->freq = ieee80211_channel_to_frequency(chfreq, status->band);
+}
+
 int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
@@ -282,11 +296,10 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 		status->ext_phy = true;
 	}
 
-	if (chfreq != phy->chfreq)
+	if (!mt7615_firmware_offload(dev) && chfreq != phy->chfreq)
 		return -EINVAL;
 
-	status->freq = mphy->chandef.chan->center_freq;
-	status->band = mphy->chandef.chan->band;
+	mt7615_get_status_freq_info(dev, mphy, status, chfreq);
 	if (status->band == NL80211_BAND_5GHZ)
 		sband = &mphy->sband_5g.sband;
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 20f6e31a017d..6a7d802c69a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -77,6 +77,7 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 	mutex_lock(&dev->mt76.mutex);
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+	cancel_delayed_work_sync(&phy->scan_work);
 
 	if (phy != &dev->phy) {
 		mt7615_mcu_set_pm(dev, 1, 1);
@@ -702,6 +703,37 @@ mt7615_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	return 0;
 }
 
+void mt7615_scan_work(struct work_struct *work)
+{
+	struct cfg80211_scan_info info = {
+		.aborted = false,
+	};
+	struct mt7615_phy *phy;
+
+	phy = (struct mt7615_phy *)container_of(work, struct mt7615_phy,
+						scan_work.work);
+
+	clear_bit(MT76_HW_SCANNING, &phy->mt76->state);
+	ieee80211_scan_completed(phy->mt76->hw, &info);
+}
+
+static int
+mt7615_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       struct ieee80211_scan_request *req)
+{
+	struct mt76_phy *mphy = hw->priv;
+
+	return mt7615_mcu_hw_scan(mphy->priv, vif, req);
+}
+
+static void
+mt7615_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt76_phy *mphy = hw->priv;
+
+	mt7615_mcu_cancel_hw_scan(mphy->priv, vif);
+}
+
 const struct ieee80211_ops mt7615_ops = {
 	.tx = mt7615_tx,
 	.start = mt7615_start,
@@ -731,6 +763,8 @@ const struct ieee80211_ops mt7615_ops = {
 	.get_antenna = mt76_get_antenna,
 	.set_antenna = mt7615_set_antenna,
 	.set_coverage_class = mt7615_set_coverage_class,
+	.hw_scan = mt7615_hw_scan,
+	.cancel_hw_scan = mt7615_cancel_hw_scan,
 };
 
 static int __init mt7615_init(void)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 9ce08be2f7c7..0db81ca9c730 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -317,6 +317,26 @@ mt7615_mcu_rx_ext_event(struct mt7615_dev *dev, struct sk_buff *skb)
 	}
 }
 
+static void
+mt7615_mcu_scan_done_event(struct mt7615_dev *dev, struct sk_buff *skb)
+{
+	struct mt7615_mcu_rxd *rxd = (struct mt7615_mcu_rxd *)skb->data;
+	struct mt7615_hw_scan_done *event;
+	struct mt7615_phy *phy;
+	struct mt76_phy *mphy;
+
+	skb_pull(skb, sizeof(*rxd));
+	event = (struct mt7615_hw_scan_done *)skb->data;
+	if (event->seq_num & BIT(7) && dev->mt76.phy2)
+		mphy = dev->mt76.phy2;
+	else
+		mphy = &dev->mt76.phy;
+
+	phy = (struct mt7615_phy *)mphy->priv;
+	ieee80211_queue_delayed_work(mphy->hw, &phy->scan_work,
+				     MT7615_HW_SCAN_TIMEOUT);
+}
+
 static void
 mt7615_mcu_rx_unsolicited_event(struct mt7615_dev *dev, struct sk_buff *skb)
 {
@@ -326,6 +346,9 @@ mt7615_mcu_rx_unsolicited_event(struct mt7615_dev *dev, struct sk_buff *skb)
 	case MCU_EVENT_EXT:
 		mt7615_mcu_rx_ext_event(dev, skb);
 		break;
+	case MCU_EVENT_SCAN_DONE:
+		mt7615_mcu_scan_done_event(dev, skb);
+		break;
 	default:
 		break;
 	}
@@ -340,6 +363,7 @@ void mt7615_mcu_rx_event(struct mt7615_dev *dev, struct sk_buff *skb)
 	    rxd->ext_eid == MCU_EXT_EVENT_FW_LOG_2_HOST ||
 	    rxd->ext_eid == MCU_EXT_EVENT_ASSERT_DUMP ||
 	    rxd->ext_eid == MCU_EXT_EVENT_PS_SYNC ||
+	    rxd->eid == MCU_EVENT_SCAN_DONE ||
 	    !rxd->seq)
 		mt7615_mcu_rx_unsolicited_event(dev, skb);
 	else
@@ -2489,3 +2513,104 @@ int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy)
 	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				       MCU_CMD_SET_CHAN_DOMAIN, false);
 }
+
+#define MT7615_SCAN_CHANNEL_TIME	120
+int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
+		       struct ieee80211_scan_request *scan_req)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct cfg80211_scan_request *sreq = &scan_req->req;
+	int ext_channels_num = max_t(int, sreq->n_channels - 32, 0);
+	struct ieee80211_channel **scan_list = sreq->channels;
+	int err, i, duration = MT7615_SCAN_CHANNEL_TIME;
+	struct mt7615_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+	struct mt7615_mcu_scan_channel *chan;
+	struct mt7615_hw_scan_req *req;
+	struct sk_buff *skb;
+
+	/* fall-back to sw-scan */
+	if (!mt7615_firmware_offload(dev))
+		return 1;
+
+	skb = mt7615_mcu_msg_alloc(NULL, sizeof(*req));
+	if (!skb)
+		return -ENOMEM;
+
+	set_bit(MT76_HW_SCANNING, &phy->mt76->state);
+	mvif->scan_seq_num = (mvif->scan_seq_num + 1) & 0x7f;
+
+	req = (struct mt7615_hw_scan_req *)skb_put(skb, sizeof(*req));
+
+	req->seq_num = mvif->scan_seq_num | ext_phy << 7;
+	req->bss_idx = mvif->idx;
+	req->scan_type = 1;
+	req->ssid_type = 1;
+	req->probe_req_num = 2;
+	req->version = 1;
+	req->channel_type = 4;
+
+	for (i = 0; i < sreq->n_ssids; i++) {
+		req->ssids[i].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
+		memcpy(req->ssids[i].ssid, sreq->ssids[i].ssid,
+		       sreq->ssids[i].ssid_len);
+	}
+
+	req->timeout_value = cpu_to_le16(sreq->n_channels * duration);
+	req->channel_min_dwell_time = cpu_to_le16(duration);
+	req->channel_dwell_time = cpu_to_le16(duration);
+
+	req->channels_num = min_t(u8, sreq->n_channels, 32);
+	req->ext_channels_num = min_t(u8, ext_channels_num, 32);
+	for (i = 0; i < req->channels_num + req->ext_channels_num; i++) {
+		if (i >= 32)
+			chan = &req->ext_channels[i - 32];
+		else
+			chan = &req->channels[i];
+
+		chan->band = scan_list[i]->band == NL80211_BAND_2GHZ ? 1 : 2;
+		chan->channel_num = scan_list[i]->hw_value;
+	}
+
+	if (sreq->ie_len > 0) {
+		memcpy(req->ies, sreq->ie, sreq->ie_len);
+		req->ies_len = cpu_to_le16(sreq->ie_len);
+	}
+
+	memcpy(req->bssid, sreq->bssid, ETH_ALEN);
+	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
+		get_random_mask_addr(req->random_mac, sreq->mac_addr,
+				     sreq->mac_addr_mask);
+		req->scan_func = 1;
+	}
+
+	err = __mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_CMD_START_HW_SCAN,
+				      false);
+	if (err < 0)
+		clear_bit(MT76_HW_SCANNING, &phy->mt76->state);
+
+	return err;
+}
+
+int mt7615_mcu_cancel_hw_scan(struct mt7615_phy *phy,
+			      struct ieee80211_vif *vif)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct mt7615_dev *dev = phy->dev;
+	struct cfg80211_scan_info info = {
+		.aborted = true,
+	};
+	struct {
+		u8 seq_num;
+		u8 is_ext_channel;
+		u8 rsv[2];
+	} __packed req = {
+		.seq_num = mvif->scan_seq_num,
+	};
+
+	ieee80211_scan_completed(phy->mt76->hw, &info);
+	clear_bit(MT76_HW_SCANNING, &phy->mt76->state);
+
+	return __mt76_mcu_send_msg(&dev->mt76,  MCU_CMD_CANCEL_HW_SCAN, &req,
+				   sizeof(req), false);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index c03541328ad7..0ce709d2158f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -81,6 +81,7 @@ enum {
 	MCU_EVENT_GENERIC = 0x01,
 	MCU_EVENT_ACCESS_REG = 0x02,
 	MCU_EVENT_MT_PATCH_SEM = 0x04,
+	MCU_EVENT_SCAN_DONE = 0x0d,
 	MCU_EVENT_CH_PRIVILEGE = 0x18,
 	MCU_EVENT_EXT = 0xed,
 	MCU_EVENT_RESTART_DL = 0xef,
@@ -277,9 +278,98 @@ enum {
 	MCU_UNI_CMD_STA_REC_UPDATE = MCU_UNI_PREFIX | 0x03,
 };
 
+struct mt7615_mcu_scan_ssid {
+	__le32 ssid_len;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+} __packed;
+
+struct mt7615_mcu_scan_channel {
+	u8 band; /* 1: 2.4GHz
+		  * 2: 5.0GHz
+		  * Others: Reserved
+		  */
+	u8 channel_num;
+} __packed;
+
+struct mt7615_hw_scan_req {
+	u8 seq_num;
+	u8 bss_idx;
+	u8 scan_type; /* 0: PASSIVE SCAN
+		       * 1: ACTIVE SCAN
+		       */
+	u8 ssid_type; /* BIT(0) wildcard SSID
+		       * BIT(1) P2P wildcard SSID
+		       * BIT(2) specified SSID
+		       */
+	u8 ssids_num;
+	u8 probe_req_num; /* Number of probe request for each SSID */
+	u8 scan_func; /* BIT(0) Enable random MAC scan
+		       * BIT(1) Disable DBDC scan type 1~3.
+		       * BIT(2) Use DBDC scan type 3 (dedicated one RF to scan).
+		       */
+	u8 version; /* 0: Not support fields after ies.
+		     * 1: Support fields after ies.
+		     */
+	struct mt7615_mcu_scan_ssid ssids[4];
+	__le16 probe_delay_time;
+	__le16 channel_dwell_time; /* channel Dwell interval */
+	__le16 timeout_value;
+	u8 channel_type; /* 0: Full channels
+			  * 1: Only 2.4GHz channels
+			  * 2: Only 5GHz channels
+			  * 3: P2P social channel only (channel #1, #6 and #11)
+			  * 4: Specified channels
+			  * Others: Reserved
+			  */
+	u8 channels_num; /* valid when channel_type is 4 */
+	/* valid when channels_num is set */
+	struct mt7615_mcu_scan_channel channels[32];
+	__le16 ies_len;
+	u8 ies[MT7615_SCAN_IE_LEN];
+	/* following fields are valid if version > 0 */
+	u8 ext_channels_num;
+	u8 ext_ssids_num;
+	__le16 channel_min_dwell_time;
+	struct mt7615_mcu_scan_channel ext_channels[32];
+	struct mt7615_mcu_scan_ssid ext_ssids[6];
+	u8 bssid[ETH_ALEN];
+	u8 random_mac[ETH_ALEN]; /* valid when BIT(1) in scan_func is set. */
+	u8 pad[64];
+} __packed;
+
+#define SCAN_DONE_EVENT_MAX_CHANNEL_NUM	64
+struct mt7615_hw_scan_done {
+	u8 seq_num;
+	u8 sparse_channel_num;
+	struct mt7615_mcu_scan_channel sparse_channel;
+	u8 complete_channel_num;
+	u8 current_state;
+	u8 version;
+	u8 pad;
+	__le32 beacon_scan_num;
+	u8 pno_enabled;
+	u8 pad2[3];
+	u8 sparse_channel_valid_num;
+	u8 pad3[3];
+	u8 channel_num[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	/* idle format for channel_idle_time
+	 * 0: first bytes: idle time(ms) 2nd byte: dwell time(ms)
+	 * 1: first bytes: idle time(8ms) 2nd byte: dwell time(8ms)
+	 * 2: dwell time (16us)
+	 */
+	__le16 channel_idle_time[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	/* beacon and probe response count */
+	u8 beacon_probe_num[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	u8 mdrdy_count[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	__le32 beacon_2g_num;
+	__le32 beacon_5g_num;
+} __packed;
+
 /* offload mcu commands */
 enum {
+	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
 	MCU_CMD_SET_CHAN_DOMAIN = MCU_CE_PREFIX | 0x0f,
+	MCU_CMD_CANCEL_HW_SCAN = MCU_CE_PREFIX | 0x1b,
 };
 
 #define MCU_CMD_ACK		BIT(0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index c4aff5f4c89b..153107811257 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -18,6 +18,7 @@
 					 MT7615_MAX_INTERFACES)
 
 #define MT7615_WATCHDOG_TIME		(HZ / 10)
+#define MT7615_HW_SCAN_TIMEOUT		(HZ / 10)
 #define MT7615_RESET_TIMEOUT		(30 * HZ)
 #define MT7615_RATE_RETRY		2
 
@@ -57,6 +58,8 @@
 #define MT7615_CFEND_RATE_DEFAULT	0x49 /* OFDM 24M */
 #define MT7615_CFEND_RATE_11B		0x03 /* 11B LP, 11M */
 
+#define MT7615_SCAN_IE_LEN		600
+
 struct mt7615_vif;
 struct mt7615_sta;
 struct mt7615_dfs_pulse;
@@ -108,6 +111,7 @@ struct mt7615_vif {
 	u8 omac_idx;
 	u8 band_idx;
 	u8 wmm_idx;
+	u8 scan_seq_num;
 
 	struct mt7615_sta sta;
 };
@@ -148,6 +152,8 @@ struct mt7615_phy {
 	u32 ampdu_ref;
 
 	struct mib_stats mib;
+
+	struct delayed_work scan_work;
 };
 
 #define mt7615_mcu_add_tx_ba(dev, ...)	(dev)->mcu_ops->add_tx_ba((dev), __VA_ARGS__)
@@ -369,6 +375,7 @@ static inline bool mt7615_firmware_offload(struct mt7615_dev *dev)
 	return dev->fw_ver > MT7615_FIRMWARE_V2;
 }
 
+void mt7615_scan_work(struct work_struct *work);
 void mt7615_update_channel(struct mt76_dev *mdev);
 bool mt7615_mac_wtbl_update(struct mt7615_dev *dev, int idx, u32 mask);
 void mt7615_mac_reset_counters(struct mt7615_dev *dev);
@@ -399,6 +406,10 @@ void mt7615_mcu_exit(struct mt7615_dev *dev);
 void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 			 int cmd, int *wait_seq);
 int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy);
+int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
+		       struct ieee80211_scan_request *scan_req);
+int mt7615_mcu_cancel_hw_scan(struct mt7615_phy *phy,
+			      struct ieee80211_vif *vif);
 
 int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
-- 
2.25.1

