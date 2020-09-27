Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12C327A201
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Sep 2020 19:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgI0RS4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Sep 2020 13:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgI0RSz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Sep 2020 13:18:55 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ECEC0613CE
        for <linux-wireless@vger.kernel.org>; Sun, 27 Sep 2020 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=U+++ma+eo2r6FXIRtgKoLvzeZGfUvzny7T64XuAmJok=; b=ItPCP6aeE0gwH+YacfVJVMiiBw
        HhIxs5LPsP9abl4cSjo2/2JtsZ7lOGp4sXl1JmqmZRNRBLZjW1n4R0wk6StAvvKss28+w0hDqggNs
        57ELYTofRoccM2ZBh3uC+n9YYIv8U3zsaJaeihf/OleqPLThDDE0AC5g9hEs05XPZk3Y=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kMaK5-0002oU-F9
        for linux-wireless@vger.kernel.org; Sun, 27 Sep 2020 19:18:53 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/8] mt76: mt7915: add 802.11 encap offload support
Date:   Sun, 27 Sep 2020 19:18:45 +0200
Message-Id: <20200927171852.48669-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is currently limited to 3-address mode AP and STA interfaces

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   1 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 227 +++++++++++-------
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |   1 +
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  19 ++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  10 +
 drivers/net/wireless/mediatek/mt76/tx.c       |   1 +
 6 files changed, 176 insertions(+), 83 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 0232b66acb4f..ee3cf612ae12 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -261,6 +261,7 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
 
 	hw->max_tx_fragments = 4;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index dea09051974a..c62fc1cd57b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -562,21 +562,131 @@ int mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	return 0;
 }
 
+static void
+mt7915_mac_write_txwi_8023(struct mt7915_dev *dev, __le32 *txwi,
+			   struct sk_buff *skb, struct mt76_wcid *wcid)
+{
+
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	u8 fc_type, fc_stype;
+	bool wmm = false;
+	u32 val;
+
+	if (wcid->sta) {
+		struct ieee80211_sta *sta;
+
+		sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
+		wmm = sta->wme;
+	}
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3) |
+	      FIELD_PREP(MT_TXD1_TID, tid);
+
+	if (be16_to_cpu(skb->protocol) >= ETH_P_802_3_MIN)
+		val |= MT_TXD1_ETH_802_3;
+
+	txwi[1] |= cpu_to_le32(val);
+
+	fc_type = IEEE80211_FTYPE_DATA >> 2;
+	fc_stype = wmm ? IEEE80211_STYPE_QOS_DATA >> 4 : 0;
+
+	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
+
+	txwi[2] |= cpu_to_le32(val);
+
+	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+	txwi[7] |= cpu_to_le32(val);
+}
+
+static void
+mt7915_mac_write_txwi_80211(struct mt7915_dev *dev, __le32 *txwi,
+			    struct sk_buff *skb, struct ieee80211_key_conf *key)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	bool multicast = is_multicast_ether_addr(hdr->addr1);
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	__le16 fc = hdr->frame_control;
+	u8 fc_type, fc_stype;
+	u32 val;
+
+	if (ieee80211_is_action(fc) &&
+	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
+	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ) {
+		u16 capab = le16_to_cpu(mgmt->u.action.u.addba_req.capab);
+
+		txwi[5] |= cpu_to_le32(MT_TXD5_ADD_BA);
+		tid = (capab >> 2) & IEEE80211_QOS_CTL_TID_MASK;
+	} else if (ieee80211_is_back_req(hdr->frame_control)) {
+		struct ieee80211_bar *bar = (struct ieee80211_bar *)hdr;
+		u16 control = le16_to_cpu(bar->control);
+
+		tid = FIELD_GET(IEEE80211_BAR_CTRL_TID_INFO_MASK, control);
+	}
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11) |
+	      FIELD_PREP(MT_TXD1_HDR_INFO,
+			 ieee80211_get_hdrlen_from_skb(skb) / 2) |
+	      FIELD_PREP(MT_TXD1_TID, tid);
+	txwi[1] |= cpu_to_le32(val);
+
+	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
+	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
+
+	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype) |
+	      FIELD_PREP(MT_TXD2_MULTICAST, multicast);
+
+	if (key && multicast && ieee80211_is_robust_mgmt_frame(skb) &&
+	    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
+		val |= MT_TXD2_BIP;
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
+	}
+
+	if (!ieee80211_is_data(fc) || multicast)
+		val |= MT_TXD2_FIX_RATE;
+
+	txwi[2] |= cpu_to_le32(val);
+
+	if (ieee80211_is_beacon(fc)) {
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_SW_POWER_MGMT);
+		txwi[3] |= cpu_to_le32(MT_TXD3_REM_TX_COUNT);
+	}
+
+	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
+		u16 seqno = le16_to_cpu(hdr->seq_ctrl);
+
+		if (ieee80211_is_back_req(hdr->frame_control)) {
+			struct ieee80211_bar *bar;
+
+			bar = (struct ieee80211_bar *)skb->data;
+			seqno = le16_to_cpu(bar->start_seq_num);
+		}
+
+		val = MT_TXD3_SN_VALID |
+		      FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
+		txwi[3] |= cpu_to_le32(val);
+	}
+
+	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+	txwi[7] |= cpu_to_le32(val);
+}
+
 void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key, bool beacon)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
-	bool multicast = is_multicast_ether_addr(hdr->addr1);
 	struct ieee80211_vif *vif = info->control.vif;
 	struct mt76_phy *mphy = &dev->mphy;
 	bool ext_phy = info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY;
-	u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
-	__le16 fc = hdr->frame_control;
-	u16 tx_count = 15, seqno = 0;
-	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
+	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+	u16 tx_count = 15;
 	u32 val;
 
 	if (vif) {
@@ -589,13 +699,6 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	if (ext_phy && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 
-	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
-	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
-
-	txwi[4] = 0;
-	txwi[5] = 0;
-	txwi[6] = 0;
-
 	if (beacon) {
 		p_fmt = MT_TX_TYPE_FW;
 		q_idx = MT_LMAC_BCN0;
@@ -608,20 +711,6 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 			mt7915_lmac_mapping(dev, skb_get_queue_mapping(skb));
 	}
 
-	if (ieee80211_is_action(fc) &&
-	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
-	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ) {
-		u16 capab = le16_to_cpu(mgmt->u.action.u.addba_req.capab);
-
-		txwi[5] |= cpu_to_le32(MT_TXD5_ADD_BA);
-		tid = (capab >> 2) & IEEE80211_QOS_CTL_TID_MASK;
-	} else if (ieee80211_is_back_req(hdr->frame_control)) {
-		struct ieee80211_bar *bar = (struct ieee80211_bar *)hdr;
-		u16 control = le16_to_cpu(bar->control);
-
-		tid = FIELD_GET(IEEE80211_BAR_CTRL_TID_INFO_MASK, control);
-	}
-
 	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + MT_TXD_SIZE) |
 	      FIELD_PREP(MT_TXD0_PKT_FMT, p_fmt) |
 	      FIELD_PREP(MT_TXD0_Q_IDX, q_idx);
@@ -629,10 +718,6 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 
 	val = MT_TXD1_LONG_FORMAT |
 	      FIELD_PREP(MT_TXD1_WLAN_IDX, wcid->idx) |
-	      FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11) |
-	      FIELD_PREP(MT_TXD1_HDR_INFO,
-			 ieee80211_get_hdrlen_from_skb(skb) / 2) |
-	      FIELD_PREP(MT_TXD1_TID, tid) |
 	      FIELD_PREP(MT_TXD1_OWN_MAC, omac_idx);
 
 	if (ext_phy && q_idx >= MT_LMAC_ALTX0 && q_idx <= MT_LMAC_BCN0)
@@ -640,27 +725,31 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 
 	txwi[1] = cpu_to_le32(val);
 
-	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
-	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype) |
-	      FIELD_PREP(MT_TXD2_MULTICAST, multicast);
-	if (key) {
-		if (multicast && ieee80211_is_robust_mgmt_frame(skb) &&
-		    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
-			val |= MT_TXD2_BIP;
-			txwi[3] = 0;
-		} else {
-			txwi[3] = cpu_to_le32(MT_TXD3_PROTECT_FRAME);
-		}
-	} else {
-		txwi[3] = 0;
-	}
-	txwi[2] = cpu_to_le32(val);
+	txwi[2] = 0;
 
-	if (!ieee80211_is_data(fc) || multicast) {
+	val = MT_TXD3_SW_POWER_MGMT |
+	      FIELD_PREP(MT_TXD3_REM_TX_COUNT, tx_count);
+	if (key)
+		val |= MT_TXD3_PROTECT_FRAME;
+	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
+		val |= MT_TXD3_NO_ACK;
+
+	txwi[3] = cpu_to_le32(val);
+	txwi[4] = 0;
+	txwi[5] = 0;
+	txwi[6] = 0;
+	txwi[7] = wcid->amsdu ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
+
+	if (is_8023)
+		mt7915_mac_write_txwi_8023(dev, txwi, skb, wcid);
+	else
+		mt7915_mac_write_txwi_80211(dev, txwi, skb, key);
+
+	if (txwi[2] & cpu_to_le32(MT_TXD2_FIX_RATE)) {
 		u16 rate;
 
 		/* hardware won't add HTC for mgmt/ctrl frame */
-		txwi[2] |= cpu_to_le32(MT_TXD2_FIX_RATE | MT_TXD2_HTC_VLD);
+		txwi[2] |= cpu_to_le32(MT_TXD2_HTC_VLD);
 
 		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
 			rate = MT7915_5G_RATE_DEFAULT;
@@ -672,36 +761,6 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 		txwi[6] |= cpu_to_le32(val);
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 	}
-
-	if (!ieee80211_is_beacon(fc))
-		txwi[3] |= cpu_to_le32(MT_TXD3_SW_POWER_MGMT);
-	else
-		tx_count = 0x1f;
-
-	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
-		txwi[3] |= cpu_to_le32(MT_TXD3_NO_ACK);
-
-	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
-	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
-	if (wcid->amsdu)
-		val |= MT_TXD7_HW_AMSDU;
-	txwi[7] = cpu_to_le32(val);
-
-	val = FIELD_PREP(MT_TXD3_REM_TX_COUNT, tx_count);
-	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
-		seqno = le16_to_cpu(hdr->seq_ctrl);
-
-		if (ieee80211_is_back_req(hdr->frame_control)) {
-			struct ieee80211_bar *bar;
-
-			bar = (struct ieee80211_bar *)skb->data;
-			seqno = le16_to_cpu(bar->start_seq_num);
-		}
-
-		val |= MT_TXD3_SN_VALID |
-		       FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
-	}
-	txwi[3] |= cpu_to_le32(val);
 }
 
 int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
@@ -723,11 +782,11 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (!wcid)
 		wcid = &dev->mt76.global_wcid;
 
-	cb->wcid = wcid->idx;
-
 	mt7915_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
 			      false);
 
+	cb->wcid = wcid->idx;
+
 	txp = (struct mt7915_txp *)(txwi + MT_TXD_SIZE);
 	for (i = 0; i < nbuf; i++) {
 		txp->buf[i] = cpu_to_le32(tx_info->buf[i + 1].addr);
@@ -745,7 +804,8 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (!key)
 		txp->flags |= cpu_to_le16(MT_CT_INFO_NONE_CIPHER_FRAME);
 
-	if (ieee80211_is_mgmt(hdr->frame_control))
+	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
+	    ieee80211_is_mgmt(hdr->frame_control))
 		txp->flags |= cpu_to_le16(MT_CT_INFO_MGMT_FRAME);
 
 	if (vif) {
@@ -838,7 +898,8 @@ mt7915_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
 
 	info->status.tx_time = 0;
 
-	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
+	if (info->flags & (IEEE80211_TX_CTL_REQ_TX_STATUS |
+			   IEEE80211_TX_CTL_HW_80211_ENCAP)) {
 		mt7915_tx_status(sta, hw, info, skb);
 		return;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index c8bb5ea96c60..c718c70aea94 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -176,6 +176,7 @@ enum tx_mcu_port_q_idx {
 #define MT_TXD1_HDR_PAD			GENMASK(19, 18)
 #define MT_TXD1_HDR_FORMAT		GENMASK(17, 16)
 #define MT_TXD1_HDR_INFO		GENMASK(15, 11)
+#define MT_TXD1_ETH_802_3		BIT(15)
 #define MT_TXD1_VTA			BIT(10)
 #define MT_TXD1_WLAN_IDX		GENMASK(9, 0)
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 9cfd7712c97a..18dc3f5f1153 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1688,6 +1688,24 @@ mt7915_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	mt7915_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_tlv);
 }
 
+static void
+mt7915_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      void *sta_wtbl, void *wtbl_tlv)
+{
+	struct wtbl_hdr_trans *htr = NULL;
+	struct tlv *tlv;
+
+	tlv = mt7915_mcu_add_nested_tlv(skb, WTBL_HDR_TRANS, sizeof(*htr),
+					wtbl_tlv, sta_wtbl);
+	htr = (struct wtbl_hdr_trans *)tlv;
+	htr->no_rx_trans = true;
+	if (vif->type == NL80211_IFTYPE_STATION)
+		htr->to_ds = true;
+	else
+		htr->from_ds = true;
+}
+
 int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta)
 {
@@ -2277,6 +2295,7 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 					     sta_wtbl, &skb);
 	if (enable) {
 		mt7915_mcu_wtbl_generic_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
+		mt7915_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
 		if (sta)
 			mt7915_mcu_wtbl_ht_tlv(skb, sta, sta_wtbl, wtbl_hdr);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index c656d66385c4..7c4b4d6ad918 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -551,6 +551,15 @@ struct wtbl_vht {
 	u8 rsv[4];
 } __packed;
 
+struct wtbl_hdr_trans {
+	__le16 tag;
+	__le16 len;
+	u8 to_ds;
+	u8 from_ds;
+	u8 no_rx_trans;
+	u8 _rsv;
+};
+
 enum {
 	MT_BA_TYPE_INVALID,
 	MT_BA_TYPE_ORIGINATOR,
@@ -972,6 +981,7 @@ enum {
 					 sizeof(struct wtbl_rx) +	\
 					 sizeof(struct wtbl_ht) +	\
 					 sizeof(struct wtbl_vht) +	\
+					 sizeof(struct wtbl_hdr_trans) +\
 					 sizeof(struct wtbl_ba) +	\
 					 sizeof(struct wtbl_smps))
 
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 44ef4bc7a46e..73624700fe44 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -272,6 +272,7 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	}
 
 	if ((dev->drv->drv_flags & MT_DRV_HW_MGMT_TXQ) &&
+	    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
 	    !ieee80211_is_data(hdr->frame_control) &&
 	    !ieee80211_is_bufferable_mmpdu(hdr->frame_control)) {
 		qid = MT_TXQ_PSD;
-- 
2.28.0

