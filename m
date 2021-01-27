Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FCD30644B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 20:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344551AbhA0TlK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jan 2021 14:41:10 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49647 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1344558AbhA0TgQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jan 2021 14:36:16 -0500
X-UUID: adc9b52780484e29ba144634ff8d693f-20210128
X-UUID: adc9b52780484e29ba144634ff8d693f-20210128
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1898475819; Thu, 28 Jan 2021 03:34:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Jan 2021 03:34:01 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jan 2021 03:34:01 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Ryder.Lee@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v8 14/20] mt76: mt7921: rely on mt76_connac_mcu module for sched_scan and hw_scan
Date:   Thu, 28 Jan 2021 03:33:51 +0800
Message-ID: <f7a4e64a5d2cdc26d2f6437ce28cd415fd38d6e4.1611774181.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1611774181.git.objelf@gmail.com>
References: <cover.1611774181.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A462A907918ABF169E6C74557704DD1D9D1E0DD66BA3AFFD3ADDB53F13ADD8F62000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Rely on mt76_connac_mcu module for sched_scan and hw_scan and remove
duplicated code

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   9 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  10 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 197 +-----------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 116 -----------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  17 +-
 5 files changed, 15 insertions(+), 334 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 4ee7453800c1..04fc69de7369 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -69,12 +69,13 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 
 	wiphy->iface_combinations = if_comb;
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
-	wiphy->max_scan_ie_len = MT7921_SCAN_IE_LEN;
+	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
 	wiphy->max_scan_ssids = 4;
-	wiphy->max_sched_scan_plan_interval = MT7921_MAX_SCHED_SCAN_INTERVAL;
+	wiphy->max_sched_scan_plan_interval =
+		MT76_CONNAC_MAX_SCHED_SCAN_INTERVAL;
 	wiphy->max_sched_scan_ie_len = IEEE80211_MAX_DATA_LEN;
-	wiphy->max_sched_scan_ssids = MT7921_MAX_SCHED_SCAN_SSID;
-	wiphy->max_match_sets = MT7921_MAX_SCAN_MATCH;
+	wiphy->max_sched_scan_ssids = MT76_CONNAC_MAX_SCHED_SCAN_SSID;
+	wiphy->max_match_sets = MT76_CONNAC_MAX_SCAN_MATCH;
 	wiphy->max_sched_scan_reqs = 1;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 43ab1d929025..bff00be537f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -864,7 +864,7 @@ mt7921_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	int err;
 
 	mutex_lock(&dev->mt76.mutex);
-	err = mt7921_mcu_hw_scan(mphy->priv, vif, req);
+	err = mt76_connac_mcu_hw_scan(mphy, vif, req);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return err;
@@ -877,7 +877,7 @@ mt7921_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct mt76_phy *mphy = hw->priv;
 
 	mutex_lock(&dev->mt76.mutex);
-	mt7921_mcu_cancel_hw_scan(mphy->priv, vif);
+	mt76_connac_mcu_cancel_hw_scan(mphy, vif);
 	mutex_unlock(&dev->mt76.mutex);
 }
 
@@ -892,11 +892,11 @@ mt7921_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	err = mt7921_mcu_sched_scan_req(mphy->priv, vif, req);
+	err = mt76_connac_mcu_sched_scan_req(mphy, vif, req);
 	if (err < 0)
 		goto out;
 
-	err = mt7921_mcu_sched_scan_enable(mphy->priv, vif, true);
+	err = mt76_connac_mcu_sched_scan_enable(mphy, vif, true);
 out:
 	mutex_unlock(&dev->mt76.mutex);
 
@@ -911,7 +911,7 @@ mt7921_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	int err;
 
 	mutex_lock(&dev->mt76.mutex);
-	err = mt7921_mcu_sched_scan_enable(mphy->priv, vif, false);
+	err = mt76_connac_mcu_sched_scan_enable(mphy, vif, false);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index a6a2ee6d5c56..e36cae5711aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1110,197 +1110,7 @@ int mt7921_mcu_get_eeprom(struct mt7921_dev *dev, u32 offset)
 	return 0;
 }
 
-#define MT7921_SCAN_CHANNEL_TIME	60
-int mt7921_mcu_hw_scan(struct mt7921_phy *phy, struct ieee80211_vif *vif,
-		       struct ieee80211_scan_request *scan_req)
-{
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
-	struct cfg80211_scan_request *sreq = &scan_req->req;
-	int n_ssids = 0, err, i, duration = MT7921_SCAN_CHANNEL_TIME;
-	int ext_channels_num = max_t(int, sreq->n_channels - 32, 0);
-	struct ieee80211_channel **scan_list = sreq->channels;
-	struct mt7921_dev *dev = phy->dev;
-	struct mt7921_mcu_scan_channel *chan;
-	struct mt7921_hw_scan_req *req;
-	struct sk_buff *skb;
-
-	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(*req));
-	if (!skb)
-		return -ENOMEM;
-
-	set_bit(MT76_HW_SCANNING, &phy->mt76->state);
-	mvif->mt76.scan_seq_num = (mvif->mt76.scan_seq_num + 1) & 0x7f;
-
-	req = (struct mt7921_hw_scan_req *)skb_put(skb, sizeof(*req));
-
-	req->seq_num = mvif->mt76.scan_seq_num;
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
-int mt7921_mcu_cancel_hw_scan(struct mt7921_phy *phy,
-			      struct ieee80211_vif *vif)
-{
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
-	struct mt7921_dev *dev = phy->dev;
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
-	return mt76_mcu_send_msg(&dev->mt76,  MCU_CMD_CANCEL_HW_SCAN, &req,
-				 sizeof(req), false);
-}
-
-int mt7921_mcu_sched_scan_req(struct mt7921_phy *phy,
-			      struct ieee80211_vif *vif,
-			      struct cfg80211_sched_scan_request *sreq)
-{
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
-	struct ieee80211_channel **scan_list = sreq->channels;
-	struct mt7921_dev *dev = phy->dev;
-	struct mt7921_mcu_scan_channel *chan;
-	struct mt7921_sched_scan_req *req;
-	struct cfg80211_match_set *match;
-	struct cfg80211_ssid *ssid;
-	struct sk_buff *skb;
-	int i;
-
-	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
-				 sizeof(*req) + sreq->ie_len);
-	if (!skb)
-		return -ENOMEM;
-
-	mvif->mt76.scan_seq_num = (mvif->mt76.scan_seq_num + 1) & 0x7f;
-
-	req = (struct mt7921_sched_scan_req *)skb_put(skb, sizeof(*req));
-	req->version = 1;
-	req->seq_num = mvif->mt76.scan_seq_num;
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
-int mt7921_mcu_sched_scan_enable(struct mt7921_phy *phy,
-				 struct ieee80211_vif *vif,
-				 bool enable)
-{
-	struct mt7921_dev *dev = phy->dev;
-	struct {
-		u8 active; /* 0: enabled 1: disabled */
-		u8 rsv[3];
-	} __packed req = {
-		.active = !enable,
-	};
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
-u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u16 wlan_idx)
+u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u32 wlan_idx)
 {
 	struct mt7921_mcu_wlan_info wtbl_info = {
 		.wlan_idx = cpu_to_le32(wlan_idx),
@@ -1502,9 +1312,10 @@ mt7921_mcu_set_wow_ctrl(struct mt7921_phy *phy, struct ieee80211_vif *vif,
 	if (wowlan->disconnect)
 		req.wow_ctrl_tlv.trigger |= BIT(2);
 	if (wowlan->nd_config) {
-		mt7921_mcu_sched_scan_req(phy, vif, wowlan->nd_config);
+		mt76_connac_mcu_sched_scan_req(&dev->mphy, vif,
+					       wowlan->nd_config);
 		req.wow_ctrl_tlv.trigger |= BIT(5);
-		mt7921_mcu_sched_scan_enable(phy, vif, suspend);
+		mt76_connac_mcu_sched_scan_enable(&dev->mphy, vif, suspend);
 	}
 
 	if (mt76_is_mmio(&dev->mt76))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 081c9abc9386..4682cc7c583b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -386,122 +386,6 @@ struct mt7921_mcu_reg_event {
 	__le32 val;
 } __packed;
 
-struct mt7921_mcu_scan_ssid {
-	__le32 ssid_len;
-	u8 ssid[IEEE80211_MAX_SSID_LEN];
-} __packed;
-
-struct mt7921_mcu_scan_channel {
-	u8 band; /* 1: 2.4GHz
-		  * 2: 5.0GHz
-		  * Others: Reserved
-		  */
-	u8 channel_num;
-} __packed;
-
-struct mt7921_mcu_scan_match {
-	__le32 rssi_th;
-	u8 ssid[IEEE80211_MAX_SSID_LEN];
-	u8 ssid_len;
-	u8 rsv[3];
-} __packed;
-
-struct mt7921_hw_scan_req {
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
-	struct mt7921_mcu_scan_ssid ssids[4];
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
-	struct mt7921_mcu_scan_channel channels[32];
-	__le16 ies_len;
-	u8 ies[MT7921_SCAN_IE_LEN];
-	/* following fields are valid if version > 0 */
-	u8 ext_channels_num;
-	u8 ext_ssids_num;
-	__le16 channel_min_dwell_time;
-	struct mt7921_mcu_scan_channel ext_channels[32];
-	struct mt7921_mcu_scan_ssid ext_ssids[6];
-	u8 bssid[ETH_ALEN];
-	u8 random_mac[ETH_ALEN]; /* valid when BIT(1) in scan_func is set. */
-	u8 pad[63];
-	u8 ssid_type_ext;
-} __packed;
-
-#define SCAN_DONE_EVENT_MAX_CHANNEL_NUM	64
-struct mt7921_hw_scan_done {
-	u8 seq_num;
-	u8 sparse_channel_num;
-	struct mt7921_mcu_scan_channel sparse_channel;
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
-struct mt7921_sched_scan_req {
-	u8 version;
-	u8 seq_num;
-	u8 stop_on_match;
-	u8 ssids_num;
-	u8 match_num;
-	u8 pad;
-	__le16 ie_len;
-	struct mt7921_mcu_scan_ssid ssids[MT7921_MAX_SCHED_SCAN_SSID];
-	struct mt7921_mcu_scan_match match[MT7921_MAX_SCAN_MATCH];
-	u8 channel_type;
-	u8 channels_num;
-	u8 intervals_num;
-	u8 scan_func;
-	struct mt7921_mcu_scan_channel channels[64];
-	__le16 intervals[MT7921_MAX_SCHED_SCAN_INTERVAL];
-	u8 bss_idx;
-	u8 pad2[64];
-} __packed;
-
 struct mt7921_mcu_tx_config {
 	u8 peer_addr[ETH_ALEN];
 	u8 sw;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 96f205ffbbd1..6085531cfd06 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -43,11 +43,6 @@
 #define MT7921_SKU_MAX_DELTA_IDX	MT7921_SKU_RATE_NUM
 #define MT7921_SKU_TABLE_SIZE		(MT7921_SKU_RATE_NUM + 1)
 
-#define MT7921_SCAN_IE_LEN		600
-#define MT7921_MAX_SCHED_SCAN_INTERVAL	10
-#define MT7921_MAX_SCHED_SCAN_SSID	10
-#define MT7921_MAX_SCAN_MATCH		16
-
 struct mt7921_vif;
 struct mt7921_sta;
 
@@ -314,17 +309,7 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
 void mt7921_scan_work(struct work_struct *work);
-int mt7921_mcu_hw_scan(struct mt7921_phy *phy, struct ieee80211_vif *vif,
-		       struct ieee80211_scan_request *scan_req);
-int mt7921_mcu_sched_scan_req(struct mt7921_phy *phy,
-			      struct ieee80211_vif *vif,
-			      struct cfg80211_sched_scan_request *sreq);
-int mt7921_mcu_sched_scan_enable(struct mt7921_phy *phy,
-				 struct ieee80211_vif *vif,
-				 bool enable);
-int mt7921_mcu_cancel_hw_scan(struct mt7921_phy *phy,
-			      struct ieee80211_vif *vif);
-u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u16 wlan_idx);
+u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u32 wlan_idx);
 int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif);
 int mt7921_mcu_uni_bss_bcnft(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 			     bool enable);
-- 
2.25.1

