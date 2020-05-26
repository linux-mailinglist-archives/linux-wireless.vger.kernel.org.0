Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C8A19C1B2
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 15:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbgDBNIH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 09:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388322AbgDBNIG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 09:08:06 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C90720678;
        Thu,  2 Apr 2020 13:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585832886;
        bh=fYbY1lkWDB+BmaFsMJsxcsyEmqXXp6qAN/1kQuZyxS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vCGB5FxK4iAr3+QFagxPMs4V2NPgIEK1DNucJgb+eAukTQOxBNH1l5tGv2YyUzRlR
         /YiHACVjTI8lHzZFVdXHPPvKWPjVe7k9oeeqzEBCiM7eE4jd4PQRnkKOsjjwjaD46S
         6a6ukIim1iNIEALn9st3O34EMibZkLtJ+2gRVPDE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 09/12] mt76: mt7615: introduce scheduled scan support
Date:   Thu,  2 Apr 2020 15:06:39 +0200
Message-Id: <3c1d1c9cb4055b8840f1d7f06f02414beb2e4306.1585832458.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585832458.git.lorenzo@kernel.org>
References: <cover.1585832458.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce scheduled scan support for mt7663e devices

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   7 ++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |   3 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  55 ++++++++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 110 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  35 ++++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  10 ++
 7 files changed, 207 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 09f407cb1c48..ca7475a95356 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -276,6 +276,7 @@ enum {
 	MT76_STATE_MCU_RUNNING,
 	MT76_SCANNING,
 	MT76_HW_SCANNING,
+	MT76_HW_SCHED_SCANNING,
 	MT76_RESTART,
 	MT76_RESET,
 	MT76_MCU_RESET,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 04bcc1a2aa8f..f4775945e3d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -349,7 +349,12 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	wiphy->reg_notifier = mt7615_regd_notifier;
 
+	wiphy->max_sched_scan_plan_interval = MT7615_MAX_SCHED_SCAN_INTERVAL;
+	wiphy->max_sched_scan_ie_len = IEEE80211_MAX_DATA_LEN;
 	wiphy->max_scan_ie_len = MT7615_SCAN_IE_LEN;
+	wiphy->max_sched_scan_ssids = MT7615_MAX_SCHED_SCAN_SSID;
+	wiphy->max_match_sets = MT7615_MAX_SCAN_MATCH;
+	wiphy->max_sched_scan_reqs = 1;
 	wiphy->max_scan_ssids = 4;
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
@@ -409,6 +414,7 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 		return 0;
 
 	INIT_DELAYED_WORK(&phy->scan_work, mt7615_scan_work);
+	skb_queue_head_init(&phy->scan_event_list);
 
 	mt7615_cap_dbdc_enable(dev);
 	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7615_ops);
@@ -467,6 +473,7 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	dev->mt76.phy.priv = &dev->phy;
 	INIT_DELAYED_WORK(&dev->mt76.mac_work, mt7615_mac_work);
 	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7615_scan_work);
+	skb_queue_head_init(&dev->phy.scan_event_list);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
 	spin_lock_init(&dev->sta_poll_lock);
 	init_waitqueue_head(&dev->reset_wait);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 8db5a8355dd2..c988a104f911 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -168,7 +168,8 @@ static void
 mt7615_get_status_freq_info(struct mt7615_dev *dev, struct mt76_phy *mphy,
 			    struct mt76_rx_status *status, u8 chfreq)
 {
-	if (!test_bit(MT76_HW_SCANNING, &mphy->state)) {
+	if (!test_bit(MT76_HW_SCANNING, &mphy->state) &&
+	    !test_bit(MT76_HW_SCHED_SCANNING, &mphy->state)) {
 		status->freq = mphy->chandef.chan->center_freq;
 		status->band = mphy->chandef.chan->band;
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 6a7d802c69a6..2c2d763b667c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -705,16 +705,36 @@ mt7615_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 
 void mt7615_scan_work(struct work_struct *work)
 {
-	struct cfg80211_scan_info info = {
-		.aborted = false,
-	};
 	struct mt7615_phy *phy;
 
 	phy = (struct mt7615_phy *)container_of(work, struct mt7615_phy,
 						scan_work.work);
 
-	clear_bit(MT76_HW_SCANNING, &phy->mt76->state);
-	ieee80211_scan_completed(phy->mt76->hw, &info);
+	while (true) {
+		struct mt7615_mcu_rxd *rxd;
+		struct sk_buff *skb;
+
+		spin_lock_bh(&phy->dev->mt76.lock);
+		skb = __skb_dequeue(&phy->scan_event_list);
+		spin_unlock_bh(&phy->dev->mt76.lock);
+
+		if (!skb)
+			break;
+
+		rxd = (struct mt7615_mcu_rxd *)skb->data;
+		if (rxd->eid == MCU_EVENT_SCAN_DONE) {
+			struct cfg80211_scan_info info = {
+				.aborted = false,
+			};
+
+			clear_bit(MT76_HW_SCANNING, &phy->mt76->state);
+			ieee80211_scan_completed(phy->mt76->hw, &info);
+		} else {
+			clear_bit(MT76_HW_SCHED_SCANNING, &phy->mt76->state);
+			ieee80211_sched_scan_results(phy->mt76->hw);
+		}
+		dev_kfree_skb(skb);
+	}
 }
 
 static int
@@ -734,6 +754,29 @@ mt7615_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mt7615_mcu_cancel_hw_scan(mphy->priv, vif);
 }
 
+static int
+mt7615_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct cfg80211_sched_scan_request *req,
+			struct ieee80211_scan_ies *ies)
+{
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	err = mt7615_mcu_sched_scan_req(mphy->priv, vif, req);
+	if (err < 0)
+		return err;
+
+	return mt7615_mcu_sched_scan_enable(mphy->priv, vif, true);
+}
+
+static int
+mt7615_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt76_phy *mphy = hw->priv;
+
+	return mt7615_mcu_sched_scan_enable(mphy->priv, vif, false);
+}
+
 const struct ieee80211_ops mt7615_ops = {
 	.tx = mt7615_tx,
 	.start = mt7615_start,
@@ -765,6 +808,8 @@ const struct ieee80211_ops mt7615_ops = {
 	.set_coverage_class = mt7615_set_coverage_class,
 	.hw_scan = mt7615_hw_scan,
 	.cancel_hw_scan = mt7615_cancel_hw_scan,
+	.sched_scan_start = mt7615_start_sched_scan,
+	.sched_scan_stop = mt7615_stop_sched_scan,
 };
 
 static int __init mt7615_init(void)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 0db81ca9c730..193808cca905 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -318,21 +318,23 @@ mt7615_mcu_rx_ext_event(struct mt7615_dev *dev, struct sk_buff *skb)
 }
 
 static void
-mt7615_mcu_scan_done_event(struct mt7615_dev *dev, struct sk_buff *skb)
+mt7615_mcu_scan_event(struct mt7615_dev *dev, struct sk_buff *skb)
 {
-	struct mt7615_mcu_rxd *rxd = (struct mt7615_mcu_rxd *)skb->data;
-	struct mt7615_hw_scan_done *event;
+	u8 *seq_num = skb->data + sizeof(struct mt7615_mcu_rxd);
 	struct mt7615_phy *phy;
 	struct mt76_phy *mphy;
 
-	skb_pull(skb, sizeof(*rxd));
-	event = (struct mt7615_hw_scan_done *)skb->data;
-	if (event->seq_num & BIT(7) && dev->mt76.phy2)
+	if (*seq_num & BIT(7) && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 	else
 		mphy = &dev->mt76.phy;
 
 	phy = (struct mt7615_phy *)mphy->priv;
+
+	spin_lock_bh(&dev->mt76.lock);
+	__skb_queue_tail(&phy->scan_event_list, skb);
+	spin_unlock_bh(&dev->mt76.lock);
+
 	ieee80211_queue_delayed_work(mphy->hw, &phy->scan_work,
 				     MT7615_HW_SCAN_TIMEOUT);
 }
@@ -346,9 +348,10 @@ mt7615_mcu_rx_unsolicited_event(struct mt7615_dev *dev, struct sk_buff *skb)
 	case MCU_EVENT_EXT:
 		mt7615_mcu_rx_ext_event(dev, skb);
 		break;
+	case MCU_EVENT_SCHED_SCAN_DONE:
 	case MCU_EVENT_SCAN_DONE:
-		mt7615_mcu_scan_done_event(dev, skb);
-		break;
+		mt7615_mcu_scan_event(dev, skb);
+		return;
 	default:
 		break;
 	}
@@ -363,6 +366,7 @@ void mt7615_mcu_rx_event(struct mt7615_dev *dev, struct sk_buff *skb)
 	    rxd->ext_eid == MCU_EXT_EVENT_FW_LOG_2_HOST ||
 	    rxd->ext_eid == MCU_EXT_EVENT_ASSERT_DUMP ||
 	    rxd->ext_eid == MCU_EXT_EVENT_PS_SYNC ||
+	    rxd->eid == MCU_EVENT_SCHED_SCAN_DONE ||
 	    rxd->eid == MCU_EVENT_SCAN_DONE ||
 	    !rxd->seq)
 		mt7615_mcu_rx_unsolicited_event(dev, skb);
@@ -2614,3 +2618,93 @@ int mt7615_mcu_cancel_hw_scan(struct mt7615_phy *phy,
 	return __mt76_mcu_send_msg(&dev->mt76,  MCU_CMD_CANCEL_HW_SCAN, &req,
 				   sizeof(req), false);
 }
+
+int mt7615_mcu_sched_scan_req(struct mt7615_phy *phy,
+			      struct ieee80211_vif *vif,
+			      struct cfg80211_sched_scan_request *sreq)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct ieee80211_channel **scan_list = sreq->channels;
+	struct mt7615_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+	struct mt7615_mcu_scan_channel *chan;
+	struct mt7615_sched_scan_req *req;
+	struct cfg80211_match_set *match;
+	struct cfg80211_ssid *ssid;
+	struct sk_buff *skb;
+	int i;
+
+	if (!mt7615_firmware_offload(dev))
+		return -ENOTSUPP;
+
+	skb = mt7615_mcu_msg_alloc(NULL, sizeof(*req) + sreq->ie_len);
+	if (!skb)
+		return -ENOMEM;
+
+	mvif->scan_seq_num = (mvif->scan_seq_num + 1) & 0x7f;
+
+	req = (struct mt7615_sched_scan_req *)skb_put(skb, sizeof(*req));
+	req->version = 1;
+	req->seq_num = mvif->scan_seq_num | ext_phy << 7;
+	req->scan_func = !!(sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR);
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
+	req->channel_type = 4;
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
+	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				       MCU_CMD_SCHED_SCAN_REQ, false);
+}
+
+int mt7615_mcu_sched_scan_enable(struct mt7615_phy *phy,
+				 struct ieee80211_vif *vif,
+				 bool enable)
+{
+	struct mt7615_dev *dev = phy->dev;
+	struct {
+		u8 active; /* 0: enabled 1: disabled */
+		u8 rsv[3];
+	} __packed req = {
+		.active = !enable,
+	};
+
+	if (!mt7615_firmware_offload(dev))
+		return -ENOTSUPP;
+
+	if (enable)
+		set_bit(MT76_HW_SCHED_SCANNING, &phy->mt76->state);
+	else
+		clear_bit(MT76_HW_SCHED_SCANNING, &phy->mt76->state);
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SCHED_SCAN_ENABLE,
+				   &req, sizeof(req), false);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 0ce709d2158f..7e55da2b6573 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -83,6 +83,7 @@ enum {
 	MCU_EVENT_MT_PATCH_SEM = 0x04,
 	MCU_EVENT_SCAN_DONE = 0x0d,
 	MCU_EVENT_CH_PRIVILEGE = 0x18,
+	MCU_EVENT_SCHED_SCAN_DONE = 0x23,
 	MCU_EVENT_EXT = 0xed,
 	MCU_EVENT_RESTART_DL = 0xef,
 };
@@ -291,6 +292,13 @@ struct mt7615_mcu_scan_channel {
 	u8 channel_num;
 } __packed;
 
+struct mt7615_mcu_scan_match {
+	__le32 rssi_th;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	u8 ssid_len;
+	u8 rsv[3];
+} __packed;
+
 struct mt7615_hw_scan_req {
 	u8 seq_num;
 	u8 bss_idx;
@@ -365,11 +373,38 @@ struct mt7615_hw_scan_done {
 	__le32 beacon_5g_num;
 } __packed;
 
+struct mt7615_sched_scan_req {
+	u8 version;
+	u8 seq_num;
+	u8 stop_on_match;
+	u8 ssids_num;
+	u8 match_num;
+	u8 pad;
+	__le16 ie_len;
+	struct mt7615_mcu_scan_ssid ssids[MT7615_MAX_SCHED_SCAN_SSID];
+	struct mt7615_mcu_scan_match match[MT7615_MAX_SCAN_MATCH];
+	u8 channel_type;
+	u8 channels_num;
+	u8 intervals_num;
+	u8 scan_func;
+	struct mt7615_mcu_scan_channel channels[64];
+	__le16 intervals[MT7615_MAX_SCHED_SCAN_INTERVAL];
+	u8 pad2[64];
+} __packed;
+
+struct nt7615_sched_scan_done {
+	u8 seq_num;
+	u8 status; /* 0: ssid found */
+	__le16 pad;
+} __packed;
+
 /* offload mcu commands */
 enum {
 	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
 	MCU_CMD_SET_CHAN_DOMAIN = MCU_CE_PREFIX | 0x0f,
 	MCU_CMD_CANCEL_HW_SCAN = MCU_CE_PREFIX | 0x1b,
+	MCU_CMD_SCHED_SCAN_ENABLE = MCU_CE_PREFIX | 0x61,
+	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
 };
 
 #define MCU_CMD_ACK		BIT(0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 153107811257..ab2cd23e6f70 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -59,6 +59,9 @@
 #define MT7615_CFEND_RATE_11B		0x03 /* 11B LP, 11M */
 
 #define MT7615_SCAN_IE_LEN		600
+#define MT7615_MAX_SCHED_SCAN_INTERVAL	10
+#define MT7615_MAX_SCHED_SCAN_SSID	10
+#define MT7615_MAX_SCAN_MATCH		16
 
 struct mt7615_vif;
 struct mt7615_sta;
@@ -153,6 +156,7 @@ struct mt7615_phy {
 
 	struct mib_stats mib;
 
+	struct sk_buff_head scan_event_list;
 	struct delayed_work scan_work;
 };
 
@@ -410,6 +414,12 @@ int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *scan_req);
 int mt7615_mcu_cancel_hw_scan(struct mt7615_phy *phy,
 			      struct ieee80211_vif *vif);
+int mt7615_mcu_sched_scan_req(struct mt7615_phy *phy,
+			      struct ieee80211_vif *vif,
+			      struct cfg80211_sched_scan_request *sreq);
+int mt7615_mcu_sched_scan_enable(struct mt7615_phy *phy,
+				 struct ieee80211_vif *vif,
+				 bool enable);
 
 int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
-- 
2.25.1

