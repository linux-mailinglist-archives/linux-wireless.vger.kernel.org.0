Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 888FA5AA36
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2019 12:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfF2Kgi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jun 2019 06:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfF2Kgi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jun 2019 06:36:38 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 209EE214DA;
        Sat, 29 Jun 2019 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561804597;
        bh=npV0496InKvDC3LfpGfQu5VGz3s3CO5FzRXf4057iLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=noe3jhopTV0O/6mnhvOwt0LaL8CSbF1jv3jUtX4/MiL53/mtzafUENOHrMq6uOS2f
         gPp4zd4vWF3NX0JvsDsrLghplB4xmAednMAsIlYxqchza73KY/rv+MgnUlWXj48Q2l
         BBTSKvjftI6hbLUi8MefiAj1TZ6+sEqj04e63juU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com, yf.luo@mediatek.com
Subject: [PATCH 5/6] mt76: mt7615: add csa support
Date:   Sat, 29 Jun 2019 12:36:10 +0200
Message-Id: <4773858ec37daac2064a0a6ca6be63ea42896a2c.1561804422.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561804422.git.lorenzo@kernel.org>
References: <cover.1561804422.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add Channel Switch Announcement support to mt7615 driver updating beacon
template with CSA IE received from mac80211

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 13 ++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 26 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  1 +
 4 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 6d336d82cafe..dbeffe5866aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -263,6 +263,7 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	wiphy->iface_combinations = if_comb;
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	wiphy->reg_notifier = mt7615_regd_notifier;
+	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 
 	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index cf9be4944cf7..1ee6dda579a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -305,6 +305,18 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+static void
+mt7615_channel_switch_beacon(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct cfg80211_chan_def *chandef)
+{
+	struct mt7615_dev *dev = hw->priv;
+
+	mutex_lock(&dev->mt76.mutex);
+	mt7615_mcu_set_bcn(dev, vif, true);
+	mutex_unlock(&dev->mt76.mutex);
+}
+
 int mt7615_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta)
 {
@@ -496,4 +508,5 @@ const struct ieee80211_ops mt7615_ops = {
 	.sw_scan_complete = mt7615_sw_scan_complete,
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.get_txpower = mt76_get_txpower,
+	.channel_switch_beacon = mt7615_channel_switch_beacon,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 397ae4f95db8..951849e4dd09 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -159,6 +159,13 @@ mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 	return ret;
 }
 
+static void
+mt7615_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	if (vif->csa_active)
+		ieee80211_csa_finish(vif);
+}
+
 static void
 mt7615_mcu_rx_ext_event(struct mt7615_dev *dev, struct sk_buff *skb)
 {
@@ -169,6 +176,11 @@ mt7615_mcu_rx_ext_event(struct mt7615_dev *dev, struct sk_buff *skb)
 		ieee80211_radar_detected(dev->mt76.hw);
 		dev->hw_pattern++;
 		break;
+	case MCU_EXT_EVENT_CSA_NOTIFY:
+		ieee80211_iterate_active_interfaces_atomic(dev->mt76.hw,
+				IEEE80211_IFACE_ITER_RESUME_ALL,
+				mt7615_mcu_csa_finish, dev);
+		break;
 	default:
 		break;
 	}
@@ -1143,6 +1155,7 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+	struct ieee80211_mutable_offsets offs;
 	struct req {
 		u8 omac_idx;
 		u8 enable;
@@ -1163,13 +1176,10 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		.enable = en,
 		.wlan_idx = wcid->idx,
 		.band_idx = mvif->band_idx,
-		/* pky_type: 0 for bcn, 1 for tim */
-		.pkt_type = 0,
 	};
 	struct sk_buff *skb;
-	u16 tim_off;
 
-	skb = ieee80211_beacon_get_tim(mt76_hw(dev), vif, &tim_off, NULL);
+	skb = ieee80211_beacon_get_template(mt76_hw(dev), vif, &offs);
 	if (!skb)
 		return -EINVAL;
 
@@ -1183,8 +1193,14 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			      0, NULL);
 	memcpy(req.pkt + MT_TXD_SIZE, skb->data, skb->len);
 	req.pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
-	req.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE + tim_off);
+	req.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE + offs.tim_offset);
+	if (offs.csa_counter_offs[0]) {
+		u16 csa_offs;
 
+		csa_offs = MT_TXD_SIZE + offs.csa_counter_offs[0] - 4;
+		req.csa_ie_pos = cpu_to_le16(csa_offs);
+		req.csa_cnt = skb->data[offs.csa_counter_offs[0]];
+	}
 	dev_kfree_skb(skb);
 
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_BCN_OFFLOAD,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 5fe492189f56..73ce9fe8bfed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -42,6 +42,7 @@ enum {
 	MCU_EXT_EVENT_THERMAL_PROTECT = 0x22,
 	MCU_EXT_EVENT_ASSERT_DUMP = 0x23,
 	MCU_EXT_EVENT_RDD_REPORT = 0x3a,
+	MCU_EXT_EVENT_CSA_NOTIFY = 0x4f,
 };
 
 struct mt7615_mcu_rxd {
-- 
2.21.0

