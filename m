Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C0E375A02
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 20:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhEFSOu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 May 2021 14:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbhEFSOt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 May 2021 14:14:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85AF86113D;
        Thu,  6 May 2021 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620324830;
        bh=yiZg5S1lDnjPhBQjdk6oJVFvqy6gd6pisYz9qvN6aHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p11RPbhoAudZnCb76EUwE/HOUeD3uO7g3kue/lSvKJt89oDnkhq7ViNjpunLTyV0x
         3QhR29JHj0Hsmg4t+Qn3M/l8GttEGxCJsnI6T/FUtRMjmKYvkxHN63tlocgK94828c
         eS7cl7Pc4dL0LVnFDl2pMzmu8hVboK2UP1gz3IOpNXJ0+I7G3hG3QPIuuBziyrIT9I
         Y3ig2EUrbxohQjhKFhJzHt5kruZTgPov0p+9HXJcfxqOfmp83eakbkTKxCxSnYdHIx
         g41V0tIlKkyS/kDPeCb1kb8ykEKIgSJP/wy7vDm43f6jFsdmHmikLFXKVzJxFyH7zT
         ZclitOb+At8MQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 3/4] mt76: mt7921: enable rx header traslation offload
Date:   Thu,  6 May 2021 20:13:34 +0200
Message-Id: <532161f7eda0f19c41d9936f96fcdc2cd31ab242.1620322988.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620322988.git.lorenzo@kernel.org>
References: <cover.1620322988.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As already done for mt7615 and mt7915, enable rx header translation
offload for mt7921 in order to reduce cpu load in the rx path.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 29 +++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  3 ++
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 52 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   | 11 ++++
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 18 +++++++
 6 files changed, 101 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 95dcd43c2cf9..f9178e26cf2b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -418,6 +418,33 @@ void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_hdr_trans_tlv);
 
+int mt76_connac_mcu_sta_update_hdr_trans(struct mt76_dev *dev,
+					 struct ieee80211_vif *vif,
+					 struct mt76_wcid *wcid, int cmd)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct tlv *sta_wtbl;
+	struct sk_buff *skb;
+
+	skb = mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
+					   sizeof(struct tlv));
+
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(dev, wcid, WTBL_SET,
+						  sta_wtbl, &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
+	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, wcid, sta_wtbl, wtbl_hdr);
+
+	return mt76_mcu_skb_send_msg(dev, skb, cmd, true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_update_hdr_trans);
+
 void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev,
 				      struct sk_buff *skb,
 				      struct ieee80211_vif *vif,
@@ -866,6 +893,8 @@ int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
 		mt76_connac_mcu_wtbl_generic_tlv(dev, skb, info->vif,
 						 info->sta, sta_wtbl,
 						 wtbl_hdr);
+		mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, info->vif, info->wcid,
+						   sta_wtbl, wtbl_hdr);
 		if (info->sta)
 			mt76_connac_mcu_wtbl_ht_tlv(dev, skb, info->sta,
 						    sta_wtbl, wtbl_hdr);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index f0493924fa89..01fc9f2c2f4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -972,6 +972,9 @@ void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
 					struct ieee80211_vif *vif,
 					struct mt76_wcid *wcid,
 					void *sta_wtbl, void *wtbl_tlv);
+int mt76_connac_mcu_sta_update_hdr_trans(struct mt76_dev *dev,
+					 struct ieee80211_vif *vif,
+					 struct mt76_wcid *wcid, int cmd);
 void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 			     struct ieee80211_sta *sta,
 			     struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 93cd05f653dd..91885d7417a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -78,6 +78,7 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
 	ieee80211_hw_set(hw, SUPPORTS_PS);
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
@@ -127,7 +128,8 @@ void mt7921_mac_init(struct mt7921_dev *dev)
 	mt76_rmw_field(dev, MT_MDP_DCR1, MT_MDP_DCR1_MAX_RX_LEN, 1536);
 	/* enable hardware de-agg */
 	mt76_set(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
-	mt76_clear(dev, MT_MDP_DCR0, MT_MDP_DCR0_RX_HDR_TRANS_EN);
+	/* enable hardware rx header translation */
+	mt76_set(dev, MT_MDP_DCR0, MT_MDP_DCR0_RX_HDR_TRANS_EN);
 
 	for (i = 0; i < MT7921_WTBL_SIZE; i++)
 		mt7921_mac_wtbl_update(dev, i,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 7e57d230e63a..74974f689462 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -309,6 +309,8 @@ mt7921_mac_assoc_rssi(struct mt7921_dev *dev, struct sk_buff *skb)
 int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	bool hdr_trans, unicast, insert_ccmp_hdr = false;
+	u8 chfreq, qos_ctl = 0, remove_pad, amsdu_info;
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt7921_phy *phy = &dev->phy;
 	struct ieee80211_supported_band *sband;
@@ -320,10 +322,9 @@ int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	u32 rxd2 = le32_to_cpu(rxd[2]);
 	u32 rxd3 = le32_to_cpu(rxd[3]);
 	u32 rxd4 = le32_to_cpu(rxd[4]);
-	bool unicast, insert_ccmp_hdr = false;
-	u8 remove_pad, amsdu_info;
+	u16 seq_ctrl = 0;
+	__le16 fc = 0;
 	int i, idx;
-	u8 chfreq;
 
 	memset(status, 0, sizeof(*status));
 
@@ -339,6 +340,7 @@ int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	chfreq = FIELD_GET(MT_RXD3_NORMAL_CH_FREQ, rxd3);
 	unicast = FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) == MT_RXD3_NORMAL_U2M;
 	idx = FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
+	hdr_trans = rxd2 & MT_RXD2_NORMAL_HDR_TRANS;
 	status->wcid = mt7921_rx_get_wcid(dev, idx, unicast);
 
 	if (status->wcid) {
@@ -381,6 +383,13 @@ int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 
 	rxd += 6;
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_4) {
+		u32 v0 = le32_to_cpu(rxd[0]);
+		u32 v2 = le32_to_cpu(rxd[2]);
+
+		fc = cpu_to_le16(FIELD_GET(MT_RXD6_FRAME_CONTROL, v0));
+		seq_ctrl = FIELD_GET(MT_RXD8_SEQ_CTRL, v2);
+		qos_ctl = FIELD_GET(MT_RXD8_QOS_CTL, v2);
+
 		rxd += 4;
 		if ((u8 *)rxd - skb->data >= skb->len)
 			return -EINVAL;
@@ -549,15 +558,30 @@ int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	if (status->amsdu) {
 		status->first_amsdu = amsdu_info == MT_RXD4_FIRST_AMSDU_FRAME;
 		status->last_amsdu = amsdu_info == MT_RXD4_LAST_AMSDU_FRAME;
-		memmove(skb->data + 2, skb->data,
-			ieee80211_get_hdrlen_from_skb(skb));
-		skb_pull(skb, 2);
+		if (!hdr_trans) {
+			memmove(skb->data + 2, skb->data,
+				ieee80211_get_hdrlen_from_skb(skb));
+			skb_pull(skb, 2);
+		}
 	}
 
-	if (insert_ccmp_hdr) {
-		u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
+	if (!hdr_trans) {
+		if (insert_ccmp_hdr) {
+			u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
 
-		mt76_insert_ccmp_hdr(skb, key_id);
+			mt76_insert_ccmp_hdr(skb, key_id);
+		}
+
+		hdr = mt76_skb_get_hdr(skb);
+		fc = hdr->frame_control;
+		if (ieee80211_is_data_qos(fc)) {
+			seq_ctrl = le16_to_cpu(hdr->seq_ctrl);
+			qos_ctl = *ieee80211_get_qos_ctl(hdr);
+		}
+	} else {
+		status->flag &= ~(RX_FLAG_RADIOTAP_HE |
+				  RX_FLAG_RADIOTAP_HE_MU);
+		status->flag |= RX_FLAG_8023;
 	}
 
 	mt7921_mac_assoc_rssi(dev, skb);
@@ -565,14 +589,12 @@ int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	if (rxv && status->flag & RX_FLAG_RADIOTAP_HE)
 		mt7921_mac_decode_he_radiotap(skb, status, rxv, mode);
 
-	hdr = mt76_skb_get_hdr(skb);
-	if (!status->wcid || !ieee80211_is_data_qos(hdr->frame_control))
+	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
 
-	status->aggr = unicast &&
-		       !ieee80211_is_qos_nullfunc(hdr->frame_control);
-	status->qos_ctl = *ieee80211_get_qos_ctl(hdr);
-	status->seqno = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
+	status->aggr = unicast && !ieee80211_is_qos_nullfunc(fc);
+	status->seqno = IEEE80211_SEQ_TO_SN(seq_ctrl);
+	status->qos_ctl = qos_ctl;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index 435c138c27d1..3af67fac213d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -100,6 +100,17 @@ enum rx_pkt_type {
 #define MT_RXD3_NORMAL_PF_MODE		BIT(29)
 #define MT_RXD3_NORMAL_PF_STS		GENMASK(31, 30)
 
+/* RXD GROUP4 */
+#define MT_RXD6_FRAME_CONTROL		GENMASK(15, 0)
+#define MT_RXD6_TA_LO			GENMASK(31, 16)
+
+#define MT_RXD7_TA_HI			GENMASK(31, 0)
+
+#define MT_RXD8_SEQ_CTRL		GENMASK(15, 0)
+#define MT_RXD8_QOS_CTL			GENMASK(31, 16)
+
+#define MT_RXD9_HT_CONTROL		GENMASK(31, 0)
+
 /* P-RXV DW0 */
 #define MT_PRXV_TX_RATE			GENMASK(6, 0)
 #define MT_PRXV_TX_DCM			BIT(4)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index f4c27aa41048..39b3e769925e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1164,6 +1164,23 @@ static void mt7921_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			   HZ / 2);
 }
 
+static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_sta *sta,
+					 bool enabled)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	if (enabled)
+		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
+	else
+		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
+
+	mt76_connac_mcu_sta_update_hdr_trans(&dev->mt76, vif, &msta->wcid,
+					     MCU_UNI_CMD_STA_REC_UPDATE);
+}
+
 const struct ieee80211_ops mt7921_ops = {
 	.tx = mt7921_tx,
 	.start = mt7921_start,
@@ -1178,6 +1195,7 @@ const struct ieee80211_ops mt7921_ops = {
 	.sta_remove = mt7921_sta_remove,
 	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.set_key = mt7921_set_key,
+	.sta_set_decap_offload = mt7921_sta_set_decap_offload,
 	.ampdu_action = mt7921_ampdu_action,
 	.set_rts_threshold = mt7921_set_rts_threshold,
 	.wake_tx_queue = mt76_wake_tx_queue,
-- 
2.30.2

