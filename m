Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1623013FF
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Jan 2021 09:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbhAWIhm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Jan 2021 03:37:42 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:54837 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726961AbhAWIhf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Jan 2021 03:37:35 -0500
X-UUID: 314362b91c6f462ab1135627496be611-20210123
X-UUID: 314362b91c6f462ab1135627496be611-20210123
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 612089265; Sat, 23 Jan 2021 16:35:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 23 Jan 2021 16:35:15 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 23 Jan 2021 16:35:16 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v7 09/22] mt76: mt7921: introduce schedule scan support
Date:   Sat, 23 Jan 2021 16:35:00 +0800
Message-ID: <ba7d16ba66fb4cd8bd386f75849a45ef3ff13474.1611389300.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1611389300.git.objelf@gmail.com>
References: <cover.1611389300.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3C19F520F61E728FDC5A608EB34B3C596469D9F50F2321F475C2C50E713C312D2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

introduce schedule scan to control mt7921 firmware to do background scan in
defined plan to see if the matched SSID is available.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  5 ++
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 38 +++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 83 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 20 +++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  9 ++
 5 files changed, 155 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 1ce87a4bfdd9..14d78370d525 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -70,6 +70,11 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	wiphy->max_scan_ie_len = MT7921_SCAN_IE_LEN;
 	wiphy->max_scan_ssids = 4;
+	wiphy->max_sched_scan_plan_interval = MT7921_MAX_SCHED_SCAN_INTERVAL;
+	wiphy->max_sched_scan_ie_len = IEEE80211_MAX_DATA_LEN;
+	wiphy->max_sched_scan_ssids = MT7921_MAX_SCHED_SCAN_SSID;
+	wiphy->max_match_sets = MT7921_MAX_SCAN_MATCH;
+	wiphy->max_sched_scan_reqs = 1;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 1138650d83ff..80329f163a3e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -868,6 +868,42 @@ mt7921_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+static int
+mt7921_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct cfg80211_sched_scan_request *req,
+			struct ieee80211_scan_ies *ies)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	err = mt7921_mcu_sched_scan_req(mphy->priv, vif, req);
+	if (err < 0)
+		goto out;
+
+	err = mt7921_mcu_sched_scan_enable(mphy->priv, vif, true);
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return err;
+}
+
+static int
+mt7921_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	mutex_lock(&dev->mt76.mutex);
+	err = mt7921_mcu_sched_scan_enable(mphy->priv, vif, false);
+	mutex_unlock(&dev->mt76.mutex);
+
+	return err;
+}
+
 static int
 mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 {
@@ -931,4 +967,6 @@ const struct ieee80211_ops mt7921_ops = {
 	.set_coverage_class = mt7921_set_coverage_class,
 	.hw_scan = mt7921_hw_scan,
 	.cancel_hw_scan = mt7921_cancel_hw_scan,
+	.sched_scan_start = mt7921_start_sched_scan,
+	.sched_scan_stop = mt7921_stop_sched_scan,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index ee4b52558974..6f2b4086ca81 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -2361,6 +2361,89 @@ int mt7921_mcu_cancel_hw_scan(struct mt7921_phy *phy,
 				 sizeof(req), false);
 }
 
+int mt7921_mcu_sched_scan_req(struct mt7921_phy *phy,
+			      struct ieee80211_vif *vif,
+			      struct cfg80211_sched_scan_request *sreq)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct ieee80211_channel **scan_list = sreq->channels;
+	struct mt7921_dev *dev = phy->dev;
+	struct mt7921_mcu_scan_channel *chan;
+	struct mt7921_sched_scan_req *req;
+	struct cfg80211_match_set *match;
+	struct cfg80211_ssid *ssid;
+	struct sk_buff *skb;
+	int i;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
+				 sizeof(*req) + sreq->ie_len);
+	if (!skb)
+		return -ENOMEM;
+
+	mvif->mt76.scan_seq_num = (mvif->mt76.scan_seq_num + 1) & 0x7f;
+
+	req = (struct mt7921_sched_scan_req *)skb_put(skb, sizeof(*req));
+	req->version = 1;
+	req->seq_num = mvif->mt76.scan_seq_num;
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
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_CMD_SCHED_SCAN_REQ,
+				     false);
+}
+
+int mt7921_mcu_sched_scan_enable(struct mt7921_phy *phy,
+				 struct ieee80211_vif *vif,
+				 bool enable)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct {
+		u8 active; /* 0: enabled 1: disabled */
+		u8 rsv[3];
+	} __packed req = {
+		.active = !enable,
+	};
+
+	if (enable)
+		set_bit(MT76_HW_SCHED_SCANNING, &phy->mt76->state);
+	else
+		clear_bit(MT76_HW_SCHED_SCANNING, &phy->mt76->state);
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SCHED_SCAN_ENABLE, &req,
+				 sizeof(req), false);
+}
+
 u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u16 wlan_idx)
 {
 	struct mt7921_mcu_wlan_info wtbl_info = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 96eecea22d94..6894b44ff62d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -879,6 +879,26 @@ struct mt7921_hw_scan_done {
 	__le32 beacon_5g_num;
 } __packed;
 
+struct mt7921_sched_scan_req {
+	u8 version;
+	u8 seq_num;
+	u8 stop_on_match;
+	u8 ssids_num;
+	u8 match_num;
+	u8 pad;
+	__le16 ie_len;
+	struct mt7921_mcu_scan_ssid ssids[MT7921_MAX_SCHED_SCAN_SSID];
+	struct mt7921_mcu_scan_match match[MT7921_MAX_SCAN_MATCH];
+	u8 channel_type;
+	u8 channels_num;
+	u8 intervals_num;
+	u8 scan_func;
+	struct mt7921_mcu_scan_channel channels[64];
+	__le16 intervals[MT7921_MAX_SCHED_SCAN_INTERVAL];
+	u8 bss_idx;
+	u8 pad2[64];
+} __packed;
+
 struct mt7921_mcu_bss_event {
 	u8 bss_idx;
 	u8 is_absent;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index b08ece8544ff..8cd9d3e214ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -44,6 +44,9 @@
 #define MT7921_SKU_TABLE_SIZE		(MT7921_SKU_RATE_NUM + 1)
 
 #define MT7921_SCAN_IE_LEN		600
+#define MT7921_MAX_SCHED_SCAN_INTERVAL	10
+#define MT7921_MAX_SCHED_SCAN_SSID	10
+#define MT7921_MAX_SCAN_MATCH		16
 
 struct mt7921_vif;
 struct mt7921_sta;
@@ -343,6 +346,12 @@ void mt7921_scan_work(struct work_struct *work);
 int mt7921_mcu_set_channel_domain(struct mt7921_phy *phy);
 int mt7921_mcu_hw_scan(struct mt7921_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *scan_req);
+int mt7921_mcu_sched_scan_req(struct mt7921_phy *phy,
+			      struct ieee80211_vif *vif,
+			      struct cfg80211_sched_scan_request *sreq);
+int mt7921_mcu_sched_scan_enable(struct mt7921_phy *phy,
+				 struct ieee80211_vif *vif,
+				 bool enable);
 int mt7921_mcu_cancel_hw_scan(struct mt7921_phy *phy,
 			      struct ieee80211_vif *vif);
 u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u16 wlan_idx);
-- 
2.25.1

