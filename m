Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C2E30148E
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Jan 2021 11:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbhAWKec (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Jan 2021 05:34:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbhAWKeH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Jan 2021 05:34:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F5D622D57;
        Sat, 23 Jan 2021 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611398005;
        bh=xbDPWgk30T5bf/ivb77yYghEg8SwIUtcovZ0IQccEGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f//nO0C/m3AssKBUQex8G71Q1zKG5B2p71JeUvh7N2KnE7UmclIgVnx67T3cqd3hU
         f3ur6Ix9jme4jZoKCzYSBNH1cJNGcuwa3biqyKPxT62LL99rVKaWnFCWB5r8aCF1GU
         3AqoAQJMiu/Ok/wVFYIBgTi1Gzy11rly9wAHnlVeEOSzhjH79alCHduQzzdCTd0jLi
         /JQAZsNp6sok7sh9xZ/VrvixgE9KpnN38Z8bZnCB4HEOUvD+H4BhELjPk8t0URAZx7
         kJzi55KPPGTP0gJ1lwsl1mjWPNsSVaisFrmg/1r7rxzLZnIz/gKvJmrTTQSMEnNCS7
         fQESCKIcxtPBw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 3/6] mt76: mt76_connac: move hw_scan and sched_scan routine in mt76_connac_mcu module
Date:   Sat, 23 Jan 2021 11:33:01 +0100
Message-Id: <3a7f28940b021701205b42d9197cdf658e0905e8.1611397696.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611397696.git.lorenzo@kernel.org>
References: <cover.1611397696.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move hw_scan/sched_scan in mt76_connac_mcu module in order to be reused in
mt7615 and mt7921 drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   9 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  20 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 213 +-----------------
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 122 ----------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  15 --
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 197 ++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 139 ++++++++++++
 7 files changed, 359 insertions(+), 356 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 87bcf264b370..b994da51b48d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -345,11 +345,12 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 	}
 	wiphy->reg_notifier = mt7615_regd_notifier;
 
-	wiphy->max_sched_scan_plan_interval = MT7615_MAX_SCHED_SCAN_INTERVAL;
+	wiphy->max_sched_scan_plan_interval =
+		MT76_CONNAC_MAX_SCHED_SCAN_INTERVAL;
 	wiphy->max_sched_scan_ie_len = IEEE80211_MAX_DATA_LEN;
-	wiphy->max_scan_ie_len = MT7615_SCAN_IE_LEN;
-	wiphy->max_sched_scan_ssids = MT7615_MAX_SCHED_SCAN_SSID;
-	wiphy->max_match_sets = MT7615_MAX_SCAN_MATCH;
+	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
+	wiphy->max_sched_scan_ssids = MT76_CONNAC_MAX_SCHED_SCAN_SSID;
+	wiphy->max_match_sets = MT76_CONNAC_MAX_SCAN_MATCH;
 	wiphy->max_sched_scan_reqs = 1;
 	wiphy->max_scan_ssids = 4;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 67eb2d345184..fcfec0197256 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -997,8 +997,12 @@ mt7615_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76_phy *mphy = hw->priv;
 	int err;
 
+	/* fall-back to sw-scan */
+	if (!mt7615_firmware_offload(dev))
+		return 1;
+
 	mt7615_mutex_acquire(dev);
-	err = mt7615_mcu_hw_scan(mphy->priv, vif, req);
+	err = mt76_connac_mcu_hw_scan(mphy, vif, req);
 	mt7615_mutex_release(dev);
 
 	return err;
@@ -1011,7 +1015,7 @@ mt7615_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct mt76_phy *mphy = hw->priv;
 
 	mt7615_mutex_acquire(dev);
-	mt7615_mcu_cancel_hw_scan(mphy->priv, vif);
+	mt76_connac_mcu_cancel_hw_scan(mphy, vif);
 	mt7615_mutex_release(dev);
 }
 
@@ -1024,13 +1028,16 @@ mt7615_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76_phy *mphy = hw->priv;
 	int err;
 
+	if (!mt7615_firmware_offload(dev))
+		return -EOPNOTSUPP;
+
 	mt7615_mutex_acquire(dev);
 
-	err = mt7615_mcu_sched_scan_req(mphy->priv, vif, req);
+	err = mt76_connac_mcu_sched_scan_req(mphy, vif, req);
 	if (err < 0)
 		goto out;
 
-	err = mt7615_mcu_sched_scan_enable(mphy->priv, vif, true);
+	err = mt76_connac_mcu_sched_scan_enable(mphy, vif, true);
 out:
 	mt7615_mutex_release(dev);
 
@@ -1044,8 +1051,11 @@ mt7615_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct mt76_phy *mphy = hw->priv;
 	int err;
 
+	if (!mt7615_firmware_offload(dev))
+		return -EOPNOTSUPP;
+
 	mt7615_mutex_acquire(dev);
-	err = mt7615_mcu_sched_scan_enable(mphy->priv, vif, false);
+	err = mt76_connac_mcu_sched_scan_enable(mphy, vif, false);
 	mt7615_mutex_release(dev);
 
 	return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index aa70431c67f0..8be0e04472c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2231,214 +2231,6 @@ int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable)
 				 sizeof(req), true);
 }
 
-#define MT7615_SCAN_CHANNEL_TIME	60
-int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
-		       struct ieee80211_scan_request *scan_req)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct cfg80211_scan_request *sreq = &scan_req->req;
-	int n_ssids = 0, err, i, duration = MT7615_SCAN_CHANNEL_TIME;
-	int ext_channels_num = max_t(int, sreq->n_channels - 32, 0);
-	struct ieee80211_channel **scan_list = sreq->channels;
-	struct mt7615_dev *dev = phy->dev;
-	bool ext_phy = phy != &dev->phy;
-	struct mt7615_mcu_scan_channel *chan;
-	struct mt7615_hw_scan_req *req;
-	struct sk_buff *skb;
-
-	/* fall-back to sw-scan */
-	if (!mt7615_firmware_offload(dev))
-		return 1;
-
-	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(*req));
-	if (!skb)
-		return -ENOMEM;
-
-	set_bit(MT76_HW_SCANNING, &phy->mt76->state);
-	mvif->mt76.scan_seq_num = (mvif->mt76.scan_seq_num + 1) & 0x7f;
-
-	req = (struct mt7615_hw_scan_req *)skb_put(skb, sizeof(*req));
-
-	req->seq_num = mvif->mt76.scan_seq_num | ext_phy << 7;
-	req->bss_idx = mvif->mt76.idx;
-	req->scan_type = sreq->n_ssids ? 1 : 0;
-	req->probe_req_num = sreq->n_ssids ? 2 : 0;
-	req->version = 1;
-
-	for (i = 0; i < sreq->n_ssids; i++) {
-		if (!sreq->ssids[i].ssid_len)
-			continue;
-
-		req->ssids[i].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
-		memcpy(req->ssids[i].ssid, sreq->ssids[i].ssid,
-		       sreq->ssids[i].ssid_len);
-		n_ssids++;
-	}
-	req->ssid_type = n_ssids ? BIT(2) : BIT(0);
-	req->ssid_type_ext = n_ssids ? BIT(0) : 0;
-	req->ssids_num = n_ssids;
-
-	/* increase channel time for passive scan */
-	if (!sreq->n_ssids)
-		duration *= 2;
-	req->timeout_value = cpu_to_le16(sreq->n_channels * duration);
-	req->channel_min_dwell_time = cpu_to_le16(duration);
-	req->channel_dwell_time = cpu_to_le16(duration);
-
-	req->channels_num = min_t(u8, sreq->n_channels, 32);
-	req->ext_channels_num = min_t(u8, ext_channels_num, 32);
-	for (i = 0; i < req->channels_num + req->ext_channels_num; i++) {
-		if (i >= 32)
-			chan = &req->ext_channels[i - 32];
-		else
-			chan = &req->channels[i];
-
-		chan->band = scan_list[i]->band == NL80211_BAND_2GHZ ? 1 : 2;
-		chan->channel_num = scan_list[i]->hw_value;
-	}
-	req->channel_type = sreq->n_channels ? 4 : 0;
-
-	if (sreq->ie_len > 0) {
-		memcpy(req->ies, sreq->ie, sreq->ie_len);
-		req->ies_len = cpu_to_le16(sreq->ie_len);
-	}
-
-	memcpy(req->bssid, sreq->bssid, ETH_ALEN);
-	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
-		get_random_mask_addr(req->random_mac, sreq->mac_addr,
-				     sreq->mac_addr_mask);
-		req->scan_func = 1;
-	}
-
-	err = mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_CMD_START_HW_SCAN,
-				    false);
-	if (err < 0)
-		clear_bit(MT76_HW_SCANNING, &phy->mt76->state);
-
-	return err;
-}
-
-int mt7615_mcu_cancel_hw_scan(struct mt7615_phy *phy,
-			      struct ieee80211_vif *vif)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct mt7615_dev *dev = phy->dev;
-	struct {
-		u8 seq_num;
-		u8 is_ext_channel;
-		u8 rsv[2];
-	} __packed req = {
-		.seq_num = mvif->mt76.scan_seq_num,
-	};
-
-	if (test_and_clear_bit(MT76_HW_SCANNING, &phy->mt76->state)) {
-		struct cfg80211_scan_info info = {
-			.aborted = true,
-		};
-
-		ieee80211_scan_completed(phy->mt76->hw, &info);
-	}
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_CANCEL_HW_SCAN, &req,
-				 sizeof(req), false);
-}
-
-int mt7615_mcu_sched_scan_req(struct mt7615_phy *phy,
-			      struct ieee80211_vif *vif,
-			      struct cfg80211_sched_scan_request *sreq)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct ieee80211_channel **scan_list = sreq->channels;
-	struct mt7615_dev *dev = phy->dev;
-	bool ext_phy = phy != &dev->phy;
-	struct mt7615_mcu_scan_channel *chan;
-	struct mt7615_sched_scan_req *req;
-	struct cfg80211_match_set *match;
-	struct cfg80211_ssid *ssid;
-	struct sk_buff *skb;
-	int i;
-
-	if (!mt7615_firmware_offload(dev))
-		return -ENOTSUPP;
-
-	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
-				 sizeof(*req) + sreq->ie_len);
-	if (!skb)
-		return -ENOMEM;
-
-	mvif->mt76.scan_seq_num = (mvif->mt76.scan_seq_num + 1) & 0x7f;
-
-	req = (struct mt7615_sched_scan_req *)skb_put(skb, sizeof(*req));
-	req->version = 1;
-	req->seq_num = mvif->mt76.scan_seq_num | ext_phy << 7;
-
-	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
-		get_random_mask_addr(req->random_mac, sreq->mac_addr,
-				     sreq->mac_addr_mask);
-		req->scan_func = 1;
-	}
-
-	req->ssids_num = sreq->n_ssids;
-	for (i = 0; i < req->ssids_num; i++) {
-		ssid = &sreq->ssids[i];
-		memcpy(req->ssids[i].ssid, ssid->ssid, ssid->ssid_len);
-		req->ssids[i].ssid_len = cpu_to_le32(ssid->ssid_len);
-	}
-
-	req->match_num = sreq->n_match_sets;
-	for (i = 0; i < req->match_num; i++) {
-		match = &sreq->match_sets[i];
-		memcpy(req->match[i].ssid, match->ssid.ssid,
-		       match->ssid.ssid_len);
-		req->match[i].rssi_th = cpu_to_le32(match->rssi_thold);
-		req->match[i].ssid_len = match->ssid.ssid_len;
-	}
-
-	req->channel_type = sreq->n_channels ? 4 : 0;
-	req->channels_num = min_t(u8, sreq->n_channels, 64);
-	for (i = 0; i < req->channels_num; i++) {
-		chan = &req->channels[i];
-		chan->band = scan_list[i]->band == NL80211_BAND_2GHZ ? 1 : 2;
-		chan->channel_num = scan_list[i]->hw_value;
-	}
-
-	req->intervals_num = sreq->n_scan_plans;
-	for (i = 0; i < req->intervals_num; i++)
-		req->intervals[i] = cpu_to_le16(sreq->scan_plans[i].interval);
-
-	if (sreq->ie_len > 0) {
-		req->ie_len = cpu_to_le16(sreq->ie_len);
-		memcpy(skb_put(skb, sreq->ie_len), sreq->ie, sreq->ie_len);
-	}
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_CMD_SCHED_SCAN_REQ,
-				     false);
-}
-
-int mt7615_mcu_sched_scan_enable(struct mt7615_phy *phy,
-				 struct ieee80211_vif *vif,
-				 bool enable)
-{
-	struct mt7615_dev *dev = phy->dev;
-	struct {
-		u8 active; /* 0: enabled 1: disabled */
-		u8 rsv[3];
-	} __packed req = {
-		.active = !enable,
-	};
-
-	if (!mt7615_firmware_offload(dev))
-		return -ENOTSUPP;
-
-	if (enable)
-		set_bit(MT76_HW_SCHED_SCANNING, &phy->mt76->state);
-	else
-		clear_bit(MT76_HW_SCHED_SCANNING, &phy->mt76->state);
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SCHED_SCAN_ENABLE, &req,
-				 sizeof(req), false);
-}
-
 static int mt7615_find_freq_idx(const u16 *freqs, int n_freqs, u16 cur)
 {
 	int i;
@@ -2819,9 +2611,10 @@ mt7615_mcu_set_wow_ctrl(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	if (wowlan->disconnect)
 		req.wow_ctrl_tlv.trigger |= BIT(2);
 	if (wowlan->nd_config) {
-		mt7615_mcu_sched_scan_req(phy, vif, wowlan->nd_config);
+		mt76_connac_mcu_sched_scan_req(phy->mt76, vif,
+					       wowlan->nd_config);
 		req.wow_ctrl_tlv.trigger |= BIT(5);
-		mt7615_mcu_sched_scan_enable(phy, vif, suspend);
+		mt76_connac_mcu_sched_scan_enable(phy->mt76, vif, suspend);
 	}
 
 	if (mt76_is_mmio(&dev->mt76))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 79fb1af2d8a4..69f94b766938 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -249,128 +249,6 @@ struct mt7615_mcu_uni_event {
 	__le32 status; /* 0: success, others: fail */
 } __packed;
 
-struct mt7615_mcu_scan_ssid {
-	__le32 ssid_len;
-	u8 ssid[IEEE80211_MAX_SSID_LEN];
-} __packed;
-
-struct mt7615_mcu_scan_channel {
-	u8 band; /* 1: 2.4GHz
-		  * 2: 5.0GHz
-		  * Others: Reserved
-		  */
-	u8 channel_num;
-} __packed;
-
-struct mt7615_mcu_scan_match {
-	__le32 rssi_th;
-	u8 ssid[IEEE80211_MAX_SSID_LEN];
-	u8 ssid_len;
-	u8 rsv[3];
-} __packed;
-
-struct mt7615_hw_scan_req {
-	u8 seq_num;
-	u8 bss_idx;
-	u8 scan_type; /* 0: PASSIVE SCAN
-		       * 1: ACTIVE SCAN
-		       */
-	u8 ssid_type; /* BIT(0) wildcard SSID
-		       * BIT(1) P2P wildcard SSID
-		       * BIT(2) specified SSID + wildcard SSID
-		       * BIT(2) + ssid_type_ext BIT(0) specified SSID only
-		       */
-	u8 ssids_num;
-	u8 probe_req_num; /* Number of probe request for each SSID */
-	u8 scan_func; /* BIT(0) Enable random MAC scan
-		       * BIT(1) Disable DBDC scan type 1~3.
-		       * BIT(2) Use DBDC scan type 3 (dedicated one RF to scan).
-		       */
-	u8 version; /* 0: Not support fields after ies.
-		     * 1: Support fields after ies.
-		     */
-	struct mt7615_mcu_scan_ssid ssids[4];
-	__le16 probe_delay_time;
-	__le16 channel_dwell_time; /* channel Dwell interval */
-	__le16 timeout_value;
-	u8 channel_type; /* 0: Full channels
-			  * 1: Only 2.4GHz channels
-			  * 2: Only 5GHz channels
-			  * 3: P2P social channel only (channel #1, #6 and #11)
-			  * 4: Specified channels
-			  * Others: Reserved
-			  */
-	u8 channels_num; /* valid when channel_type is 4 */
-	/* valid when channels_num is set */
-	struct mt7615_mcu_scan_channel channels[32];
-	__le16 ies_len;
-	u8 ies[MT7615_SCAN_IE_LEN];
-	/* following fields are valid if version > 0 */
-	u8 ext_channels_num;
-	u8 ext_ssids_num;
-	__le16 channel_min_dwell_time;
-	struct mt7615_mcu_scan_channel ext_channels[32];
-	struct mt7615_mcu_scan_ssid ext_ssids[6];
-	u8 bssid[ETH_ALEN];
-	u8 random_mac[ETH_ALEN]; /* valid when BIT(1) in scan_func is set. */
-	u8 pad[63];
-	u8 ssid_type_ext;
-} __packed;
-
-#define SCAN_DONE_EVENT_MAX_CHANNEL_NUM	64
-struct mt7615_hw_scan_done {
-	u8 seq_num;
-	u8 sparse_channel_num;
-	struct mt7615_mcu_scan_channel sparse_channel;
-	u8 complete_channel_num;
-	u8 current_state;
-	u8 version;
-	u8 pad;
-	__le32 beacon_scan_num;
-	u8 pno_enabled;
-	u8 pad2[3];
-	u8 sparse_channel_valid_num;
-	u8 pad3[3];
-	u8 channel_num[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
-	/* idle format for channel_idle_time
-	 * 0: first bytes: idle time(ms) 2nd byte: dwell time(ms)
-	 * 1: first bytes: idle time(8ms) 2nd byte: dwell time(8ms)
-	 * 2: dwell time (16us)
-	 */
-	__le16 channel_idle_time[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
-	/* beacon and probe response count */
-	u8 beacon_probe_num[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
-	u8 mdrdy_count[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
-	__le32 beacon_2g_num;
-	__le32 beacon_5g_num;
-} __packed;
-
-struct mt7615_sched_scan_req {
-	u8 version;
-	u8 seq_num;
-	u8 stop_on_match;
-	u8 ssids_num;
-	u8 match_num;
-	u8 pad;
-	__le16 ie_len;
-	struct mt7615_mcu_scan_ssid ssids[MT7615_MAX_SCHED_SCAN_SSID];
-	struct mt7615_mcu_scan_match match[MT7615_MAX_SCAN_MATCH];
-	u8 channel_type;
-	u8 channels_num;
-	u8 intervals_num;
-	u8 scan_func; /* BIT(0) eable random mac address */
-	struct mt7615_mcu_scan_channel channels[64];
-	__le16 intervals[MT7615_MAX_SCHED_SCAN_INTERVAL];
-	u8 random_mac[ETH_ALEN]; /* valid when BIT(0) in scan_func is set */
-	u8 pad2[58];
-} __packed;
-
-struct nt7615_sched_scan_done {
-	u8 seq_num;
-	u8 status; /* 0: ssid found */
-	__le16 pad;
-} __packed;
-
 struct mt7615_mcu_reg_event {
 	__le32 reg;
 	__le32 val;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 2ed59a141b14..0173db8fd0f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -65,11 +65,6 @@
 #define MT7615_CFEND_RATE_DEFAULT	0x49 /* OFDM 24M */
 #define MT7615_CFEND_RATE_11B		0x03 /* 11B LP, 11M */
 
-#define MT7615_SCAN_IE_LEN		600
-#define MT7615_MAX_SCHED_SCAN_INTERVAL	10
-#define MT7615_MAX_SCHED_SCAN_SSID	10
-#define MT7615_MAX_SCAN_MATCH		16
-
 struct mt7615_vif;
 struct mt7615_sta;
 struct mt7615_dfs_pulse;
@@ -536,16 +531,6 @@ int mt7615_mcu_set_tx_power(struct mt7615_phy *phy);
 void mt7615_mcu_exit(struct mt7615_dev *dev);
 void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 			 int cmd, int *wait_seq);
-int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
-		       struct ieee80211_scan_request *scan_req);
-int mt7615_mcu_cancel_hw_scan(struct mt7615_phy *phy,
-			      struct ieee80211_vif *vif);
-int mt7615_mcu_sched_scan_req(struct mt7615_phy *phy,
-			      struct ieee80211_vif *vif,
-			      struct cfg80211_sched_scan_request *sreq);
-int mt7615_mcu_sched_scan_enable(struct mt7615_phy *phy,
-				 struct ieee80211_vif *vif,
-				 bool enable);
 
 int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index c48ccda6935d..ed0e605d1c0b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -982,5 +982,202 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_add_bss);
 
+#define MT76_CONNAC_SCAN_CHANNEL_TIME		60
+int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			    struct ieee80211_scan_request *scan_req)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct cfg80211_scan_request *sreq = &scan_req->req;
+	int n_ssids = 0, err, i, duration = MT76_CONNAC_SCAN_CHANNEL_TIME;
+	int ext_channels_num = max_t(int, sreq->n_channels - 32, 0);
+	struct ieee80211_channel **scan_list = sreq->channels;
+	struct mt76_dev *mdev = phy->dev;
+	bool ext_phy = phy == mdev->phy2;
+	struct mt76_connac_mcu_scan_channel *chan;
+	struct mt76_connac_hw_scan_req *req;
+	struct sk_buff *skb;
+
+	skb = mt76_mcu_msg_alloc(mdev, NULL, sizeof(*req));
+	if (!skb)
+		return -ENOMEM;
+
+	set_bit(MT76_HW_SCANNING, &phy->state);
+	mvif->scan_seq_num = (mvif->scan_seq_num + 1) & 0x7f;
+
+	req = (struct mt76_connac_hw_scan_req *)skb_put(skb, sizeof(*req));
+
+	req->seq_num = mvif->scan_seq_num | ext_phy << 7;
+	req->bss_idx = mvif->idx;
+	req->scan_type = sreq->n_ssids ? 1 : 0;
+	req->probe_req_num = sreq->n_ssids ? 2 : 0;
+	req->version = 1;
+
+	for (i = 0; i < sreq->n_ssids; i++) {
+		if (!sreq->ssids[i].ssid_len)
+			continue;
+
+		req->ssids[i].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
+		memcpy(req->ssids[i].ssid, sreq->ssids[i].ssid,
+		       sreq->ssids[i].ssid_len);
+		n_ssids++;
+	}
+	req->ssid_type = n_ssids ? BIT(2) : BIT(0);
+	req->ssid_type_ext = n_ssids ? BIT(0) : 0;
+	req->ssids_num = n_ssids;
+
+	/* increase channel time for passive scan */
+	if (!sreq->n_ssids)
+		duration *= 2;
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
+	req->channel_type = sreq->n_channels ? 4 : 0;
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
+	err = mt76_mcu_skb_send_msg(mdev, skb, MCU_CMD_START_HW_SCAN, false);
+	if (err < 0)
+		clear_bit(MT76_HW_SCANNING, &phy->state);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_hw_scan);
+
+int mt76_connac_mcu_cancel_hw_scan(struct mt76_phy *phy,
+				   struct ieee80211_vif *vif)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct {
+		u8 seq_num;
+		u8 is_ext_channel;
+		u8 rsv[2];
+	} __packed req = {
+		.seq_num = mvif->scan_seq_num,
+	};
+
+	if (test_and_clear_bit(MT76_HW_SCANNING, &phy->state)) {
+		struct cfg80211_scan_info info = {
+			.aborted = true,
+		};
+
+		ieee80211_scan_completed(phy->hw, &info);
+	}
+
+	return mt76_mcu_send_msg(phy->dev, MCU_CMD_CANCEL_HW_SCAN, &req,
+				 sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_cancel_hw_scan);
+
+int mt76_connac_mcu_sched_scan_req(struct mt76_phy *phy,
+				   struct ieee80211_vif *vif,
+				   struct cfg80211_sched_scan_request *sreq)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct ieee80211_channel **scan_list = sreq->channels;
+	struct mt76_connac_mcu_scan_channel *chan;
+	struct mt76_connac_sched_scan_req *req;
+	struct mt76_dev *mdev = phy->dev;
+	bool ext_phy = phy == mdev->phy2;
+	struct cfg80211_match_set *match;
+	struct cfg80211_ssid *ssid;
+	struct sk_buff *skb;
+	int i;
+
+	skb = mt76_mcu_msg_alloc(mdev, NULL, sizeof(*req) + sreq->ie_len);
+	if (!skb)
+		return -ENOMEM;
+
+	mvif->scan_seq_num = (mvif->scan_seq_num + 1) & 0x7f;
+
+	req = (struct mt76_connac_sched_scan_req *)skb_put(skb, sizeof(*req));
+	req->version = 1;
+	req->seq_num = mvif->scan_seq_num | ext_phy << 7;
+
+	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
+		get_random_mask_addr(req->random_mac, sreq->mac_addr,
+				     sreq->mac_addr_mask);
+		req->scan_func = 1;
+	}
+
+	req->ssids_num = sreq->n_ssids;
+	for (i = 0; i < req->ssids_num; i++) {
+		ssid = &sreq->ssids[i];
+		memcpy(req->ssids[i].ssid, ssid->ssid, ssid->ssid_len);
+		req->ssids[i].ssid_len = cpu_to_le32(ssid->ssid_len);
+	}
+
+	req->match_num = sreq->n_match_sets;
+	for (i = 0; i < req->match_num; i++) {
+		match = &sreq->match_sets[i];
+		memcpy(req->match[i].ssid, match->ssid.ssid,
+		       match->ssid.ssid_len);
+		req->match[i].rssi_th = cpu_to_le32(match->rssi_thold);
+		req->match[i].ssid_len = match->ssid.ssid_len;
+	}
+
+	req->channel_type = sreq->n_channels ? 4 : 0;
+	req->channels_num = min_t(u8, sreq->n_channels, 64);
+	for (i = 0; i < req->channels_num; i++) {
+		chan = &req->channels[i];
+		chan->band = scan_list[i]->band == NL80211_BAND_2GHZ ? 1 : 2;
+		chan->channel_num = scan_list[i]->hw_value;
+	}
+
+	req->intervals_num = sreq->n_scan_plans;
+	for (i = 0; i < req->intervals_num; i++)
+		req->intervals[i] = cpu_to_le16(sreq->scan_plans[i].interval);
+
+	if (sreq->ie_len > 0) {
+		req->ie_len = cpu_to_le16(sreq->ie_len);
+		memcpy(skb_put(skb, sreq->ie_len), sreq->ie, sreq->ie_len);
+	}
+
+	return mt76_mcu_skb_send_msg(mdev, skb, MCU_CMD_SCHED_SCAN_REQ, false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sched_scan_req);
+
+int mt76_connac_mcu_sched_scan_enable(struct mt76_phy *phy,
+				      struct ieee80211_vif *vif,
+				      bool enable)
+{
+	struct {
+		u8 active; /* 0: enabled 1: disabled */
+		u8 rsv[3];
+	} __packed req = {
+		.active = !enable,
+	};
+
+	if (enable)
+		set_bit(MT76_HW_SCHED_SCANNING, &phy->state);
+	else
+		clear_bit(MT76_HW_SCHED_SCANNING, &phy->state);
+
+	return mt76_mcu_send_msg(phy->dev, MCU_CMD_SCHED_SCAN_ENABLE, &req,
+				 sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sched_scan_enable);
+
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index eb5e7b817d31..8b6c1cd012f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -6,6 +6,11 @@
 
 #include "mt76.h"
 
+#define MT76_CONNAC_SCAN_IE_LEN			600
+#define MT76_CONNAC_MAX_SCHED_SCAN_INTERVAL	10
+#define MT76_CONNAC_MAX_SCHED_SCAN_SSID		10
+#define MT76_CONNAC_MAX_SCAN_MATCH		16
+
 enum {
 	CMD_CBW_20MHZ = IEEE80211_STA_RX_BW_20,
 	CMD_CBW_40MHZ = IEEE80211_STA_RX_BW_40,
@@ -652,6 +657,129 @@ struct mt76_connac_mcu_bss_event {
 	u8 pad;
 } __packed;
 
+struct mt76_connac_mcu_scan_ssid {
+	__le32 ssid_len;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+} __packed;
+
+struct mt76_connac_mcu_scan_channel {
+	u8 band; /* 1: 2.4GHz
+		  * 2: 5.0GHz
+		  * Others: Reserved
+		  */
+	u8 channel_num;
+} __packed;
+
+struct mt76_connac_mcu_scan_match {
+	__le32 rssi_th;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	u8 ssid_len;
+	u8 rsv[3];
+} __packed;
+
+struct mt76_connac_hw_scan_req {
+	u8 seq_num;
+	u8 bss_idx;
+	u8 scan_type; /* 0: PASSIVE SCAN
+		       * 1: ACTIVE SCAN
+		       */
+	u8 ssid_type; /* BIT(0) wildcard SSID
+		       * BIT(1) P2P wildcard SSID
+		       * BIT(2) specified SSID + wildcard SSID
+		       * BIT(2) + ssid_type_ext BIT(0) specified SSID only
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
+	struct mt76_connac_mcu_scan_ssid ssids[4];
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
+	struct mt76_connac_mcu_scan_channel channels[32];
+	__le16 ies_len;
+	u8 ies[MT76_CONNAC_SCAN_IE_LEN];
+	/* following fields are valid if version > 0 */
+	u8 ext_channels_num;
+	u8 ext_ssids_num;
+	__le16 channel_min_dwell_time;
+	struct mt76_connac_mcu_scan_channel ext_channels[32];
+	struct mt76_connac_mcu_scan_ssid ext_ssids[6];
+	u8 bssid[ETH_ALEN];
+	u8 random_mac[ETH_ALEN]; /* valid when BIT(1) in scan_func is set. */
+	u8 pad[63];
+	u8 ssid_type_ext;
+} __packed;
+
+#define MT76_CONNAC_SCAN_DONE_EVENT_MAX_CHANNEL_NUM		64
+
+struct mt76_connac_hw_scan_done {
+	u8 seq_num;
+	u8 sparse_channel_num;
+	struct mt76_connac_mcu_scan_channel sparse_channel;
+	u8 complete_channel_num;
+	u8 current_state;
+	u8 version;
+	u8 pad;
+	__le32 beacon_scan_num;
+	u8 pno_enabled;
+	u8 pad2[3];
+	u8 sparse_channel_valid_num;
+	u8 pad3[3];
+	u8 channel_num[MT76_CONNAC_SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	/* idle format for channel_idle_time
+	 * 0: first bytes: idle time(ms) 2nd byte: dwell time(ms)
+	 * 1: first bytes: idle time(8ms) 2nd byte: dwell time(8ms)
+	 * 2: dwell time (16us)
+	 */
+	__le16 channel_idle_time[MT76_CONNAC_SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	/* beacon and probe response count */
+	u8 beacon_probe_num[MT76_CONNAC_SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	u8 mdrdy_count[MT76_CONNAC_SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	__le32 beacon_2g_num;
+	__le32 beacon_5g_num;
+} __packed;
+
+struct mt76_connac_sched_scan_req {
+	u8 version;
+	u8 seq_num;
+	u8 stop_on_match;
+	u8 ssids_num;
+	u8 match_num;
+	u8 pad;
+	__le16 ie_len;
+	struct mt76_connac_mcu_scan_ssid ssids[MT76_CONNAC_MAX_SCHED_SCAN_SSID];
+	struct mt76_connac_mcu_scan_match match[MT76_CONNAC_MAX_SCAN_MATCH];
+	u8 channel_type;
+	u8 channels_num;
+	u8 intervals_num;
+	u8 scan_func; /* BIT(0) eable random mac address */
+	struct mt76_connac_mcu_scan_channel channels[64];
+	__le16 intervals[MT76_CONNAC_MAX_SCHED_SCAN_INTERVAL];
+	u8 random_mac[ETH_ALEN]; /* valid when BIT(0) in scan_func is set */
+	u8 pad2[58];
+} __packed;
+
+struct mt76_connac_sched_scan_done {
+	u8 seq_num;
+	u8 status; /* 0: ssid found */
+	__le16 pad;
+} __packed;
+
 struct bss_info_uni_he {
 	__le16 tag;
 	__le16 len;
@@ -726,4 +854,15 @@ int mt76_connac_mcu_start_patch(struct mt76_dev *dev);
 int mt76_connac_mcu_patch_sem_ctrl(struct mt76_dev *dev, bool get);
 int mt76_connac_mcu_start_firmware(struct mt76_dev *dev, u32 addr, u32 option);
 
+int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			    struct ieee80211_scan_request *scan_req);
+int mt76_connac_mcu_cancel_hw_scan(struct mt76_phy *phy,
+				   struct ieee80211_vif *vif);
+int mt76_connac_mcu_sched_scan_req(struct mt76_phy *phy,
+				   struct ieee80211_vif *vif,
+				   struct cfg80211_sched_scan_request *sreq);
+int mt76_connac_mcu_sched_scan_enable(struct mt76_phy *phy,
+				      struct ieee80211_vif *vif,
+				      bool enable);
+
 #endif /* __MT76_CONNAC_MCU_H */
-- 
2.29.2

