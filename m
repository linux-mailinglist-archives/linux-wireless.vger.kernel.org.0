Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7784C48FCD0
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jan 2022 13:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiAPMoE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jan 2022 07:44:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42104 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiAPMoD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jan 2022 07:44:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63A2460E05
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jan 2022 12:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9248BC36AE3;
        Sun, 16 Jan 2022 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642337042;
        bh=zyXwiX/rIEuB5B7fsPJnXAlDmGUUGxg0eBBxFUihHKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LTR+pj0lau83tpGyBS7L0j4NjS8xAOPzat/jtHpJYHC0+NuZFHgDMOl/xiRDQk7+B
         07qCc5VhXTDvRPf4jyJEOTWd+JJ2SaBIFnLBluhE3O61xuIjp/fSdWmddydyhQleH6
         /zQsUi75jFVdortMceFU55acZFozWrpmz2TsaHHl46DVvSP6gfUeAyRpKHKMlSSrHy
         C2exEveDKMoSfl87H6M4NYPdxiiOWbErGBQRiWUzVU58n1mRzoaeysMVPZ30btjHZz
         c7ilV8rniwCFV1AzpmY/M0wh62h8viPfdHBGCcl8bXlLaLGcOSnmzcAUhR2IJMihaJ
         xBvEZ8DScGxgg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 5/5] mt76: connac: move mt76_connac_mac_write_txwi in connac module
Date:   Sun, 16 Jan 2022 13:43:18 +0100
Message-Id: <10a2700434d682045eeedd0c6bda350231364c25.1642336806.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642336806.git.lorenzo@kernel.org>
References: <cover.1642336806.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_connac_mac_write_txwi_8023 and
mt76_connac_mac_write_txwi_80211 routines in mt76-connac module since
they are shared between mt7921 and mt7915 drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   3 +
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 126 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 129 +-----------------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 120 +---------------
 4 files changed, 135 insertions(+), 243 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index c4e898038acc..58e0943cbed3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -244,5 +244,8 @@ int mt76_connac_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_offset,
 					struct ieee80211_vif *vif);
 void mt76_connac_mac_decode_he_radiotap(struct sk_buff *skb,
 					__le32 *rxv, u32 mode);
+void mt76_connac_mac_write_txwi(struct sk_buff *skb, __le32 *txwi,
+				struct mt76_wcid *wcid,
+				struct ieee80211_key_conf *key);
 
 #endif /* __MT76_CONNAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index fbc5caa02259..ab6a3034b5e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -351,3 +351,129 @@ void mt76_connac_mac_decode_he_radiotap(struct sk_buff *skb,
 	}
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mac_decode_he_radiotap);
+
+static void
+mt76_connac_mac_write_txwi_8023(__le32 *txwi, struct sk_buff *skb,
+				struct mt76_wcid *wcid)
+{
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
+mt76_connac_mac_write_txwi_80211(__le32 *txwi, struct sk_buff *skb,
+				 struct ieee80211_key_conf *key)
+{
+	u8 fc_type, fc_stype, tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	bool multicast = is_multicast_ether_addr(hdr->addr1);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	__le16 fc = hdr->frame_control;
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
+	      FIELD_PREP(MT_TXD1_TID, tid) |
+	      FIELD_PREP(MT_TXD1_HDR_INFO,
+			 ieee80211_get_hdrlen_from_skb(skb) / 2);
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
+	if (!ieee80211_is_data(fc) || multicast ||
+	    info->flags & IEEE80211_TX_CTL_USE_MINRATE)
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
+void mt76_connac_mac_write_txwi(struct sk_buff *skb, __le32 *txwi,
+				struct mt76_wcid *wcid,
+				struct ieee80211_key_conf *key)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+
+	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
+		mt76_connac_mac_write_txwi_8023(txwi, skb, wcid);
+	else
+		mt76_connac_mac_write_txwi_80211(txwi, skb, key);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mac_write_txwi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index b130bebfdda7..223c10aef596 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -775,123 +775,6 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
 #endif
 }
 
-static void
-mt7915_mac_write_txwi_8023(struct mt7915_dev *dev, __le32 *txwi,
-			   struct sk_buff *skb, struct mt76_wcid *wcid)
-{
-
-	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
-	u8 fc_type, fc_stype;
-	bool wmm = false;
-	u32 val;
-
-	if (wcid->sta) {
-		struct ieee80211_sta *sta;
-
-		sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
-		wmm = sta->wme;
-	}
-
-	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3) |
-	      FIELD_PREP(MT_TXD1_TID, tid);
-
-	if (be16_to_cpu(skb->protocol) >= ETH_P_802_3_MIN)
-		val |= MT_TXD1_ETH_802_3;
-
-	txwi[1] |= cpu_to_le32(val);
-
-	fc_type = IEEE80211_FTYPE_DATA >> 2;
-	fc_stype = wmm ? IEEE80211_STYPE_QOS_DATA >> 4 : 0;
-
-	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
-	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
-
-	txwi[2] |= cpu_to_le32(val);
-
-	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
-	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
-	txwi[7] |= cpu_to_le32(val);
-}
-
-static void
-mt7915_mac_write_txwi_80211(struct mt7915_dev *dev, __le32 *txwi,
-			    struct sk_buff *skb, struct ieee80211_key_conf *key,
-			    bool *mcast)
-{
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
-	__le16 fc = hdr->frame_control;
-	u8 fc_type, fc_stype;
-	u32 val;
-
-	*mcast = is_multicast_ether_addr(hdr->addr1);
-
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
-	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11) |
-	      FIELD_PREP(MT_TXD1_HDR_INFO,
-			 ieee80211_get_hdrlen_from_skb(skb) / 2) |
-	      FIELD_PREP(MT_TXD1_TID, tid);
-	txwi[1] |= cpu_to_le32(val);
-
-	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
-	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
-
-	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
-	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype) |
-	      FIELD_PREP(MT_TXD2_MULTICAST, *mcast);
-
-	if (key && *mcast && ieee80211_is_robust_mgmt_frame(skb) &&
-	    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
-		val |= MT_TXD2_BIP;
-		txwi[3] &= ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
-	}
-
-	if (!ieee80211_is_data(fc) || *mcast ||
-	    info->flags & IEEE80211_TX_CTL_USE_MINRATE)
-		val |= MT_TXD2_FIX_RATE;
-
-	txwi[2] |= cpu_to_le32(val);
-
-	if (ieee80211_is_beacon(fc)) {
-		txwi[3] &= ~cpu_to_le32(MT_TXD3_SW_POWER_MGMT);
-		txwi[3] |= cpu_to_le32(MT_TXD3_REM_TX_COUNT);
-	}
-
-	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
-		u16 seqno = le16_to_cpu(hdr->seq_ctrl);
-
-		if (ieee80211_is_back_req(hdr->frame_control)) {
-			struct ieee80211_bar *bar;
-
-			bar = (struct ieee80211_bar *)skb->data;
-			seqno = le16_to_cpu(bar->start_seq_num);
-		}
-
-		val = MT_TXD3_SN_VALID |
-		      FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
-		txwi[3] |= cpu_to_le32(val);
-	}
-
-	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
-	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
-	txwi[7] |= cpu_to_le32(val);
-}
-
 static u16
 mt7915_mac_tx_rate_val(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 		       bool beacon, bool mcast)
@@ -946,8 +829,6 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	struct mt76_phy *mphy = &dev->mphy;
 	bool ext_phy = info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY;
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
-	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
-	bool mcast = false;
 	u16 tx_count = 15;
 	u32 val;
 
@@ -1007,13 +888,13 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	txwi[6] = 0;
 	txwi[7] = wcid->amsdu ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
 
-	if (is_8023)
-		mt7915_mac_write_txwi_8023(dev, txwi, skb, wcid);
-	else
-		mt7915_mac_write_txwi_80211(dev, txwi, skb, key, &mcast);
+	mt76_connac_mac_write_txwi(skb, txwi, wcid, key);
 
 	if (txwi[2] & cpu_to_le32(MT_TXD2_FIX_RATE)) {
-		u16 rate = mt7915_mac_tx_rate_val(mphy, vif, beacon, mcast);
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+		bool multicast = is_multicast_ether_addr(hdr->addr1);
+		u16 rate = mt7915_mac_tx_rate_val(mphy, vif, beacon,
+						  multicast);
 
 		/* hardware won't add HTC for mgmt/ctrl frame */
 		txwi[2] |= cpu_to_le32(MT_TXD2_HTC_VLD);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 491eaa67be52..5b36ca51543f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -562,120 +562,6 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	return 0;
 }
 
-static void
-mt7921_mac_write_txwi_8023(struct mt7921_dev *dev, __le32 *txwi,
-			   struct sk_buff *skb, struct mt76_wcid *wcid)
-{
-	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
-	u8 fc_type, fc_stype;
-	bool wmm = false;
-	u32 val;
-
-	if (wcid->sta) {
-		struct ieee80211_sta *sta;
-
-		sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
-		wmm = sta->wme;
-	}
-
-	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3) |
-	      FIELD_PREP(MT_TXD1_TID, tid);
-
-	if (be16_to_cpu(skb->protocol) >= ETH_P_802_3_MIN)
-		val |= MT_TXD1_ETH_802_3;
-
-	txwi[1] |= cpu_to_le32(val);
-
-	fc_type = IEEE80211_FTYPE_DATA >> 2;
-	fc_stype = wmm ? IEEE80211_STYPE_QOS_DATA >> 4 : 0;
-
-	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
-	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
-
-	txwi[2] |= cpu_to_le32(val);
-
-	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
-	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
-	txwi[7] |= cpu_to_le32(val);
-}
-
-static void
-mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, __le32 *txwi,
-			    struct sk_buff *skb, struct ieee80211_key_conf *key)
-{
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	bool multicast = is_multicast_ether_addr(hdr->addr1);
-	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
-	__le16 fc = hdr->frame_control;
-	u8 fc_type, fc_stype;
-	u32 val;
-
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
-	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11) |
-	      FIELD_PREP(MT_TXD1_HDR_INFO,
-			 ieee80211_get_hdrlen_from_skb(skb) / 2) |
-	      FIELD_PREP(MT_TXD1_TID, tid);
-	txwi[1] |= cpu_to_le32(val);
-
-	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
-	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
-
-	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
-	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype) |
-	      FIELD_PREP(MT_TXD2_MULTICAST, multicast);
-
-	if (key && multicast && ieee80211_is_robust_mgmt_frame(skb) &&
-	    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
-		val |= MT_TXD2_BIP;
-		txwi[3] &= ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
-	}
-
-	if (!ieee80211_is_data(fc) || multicast ||
-	    info->flags & IEEE80211_TX_CTL_USE_MINRATE)
-		val |= MT_TXD2_FIX_RATE;
-
-	txwi[2] |= cpu_to_le32(val);
-
-	if (ieee80211_is_beacon(fc)) {
-		txwi[3] &= ~cpu_to_le32(MT_TXD3_SW_POWER_MGMT);
-		txwi[3] |= cpu_to_le32(MT_TXD3_REM_TX_COUNT);
-	}
-
-	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
-		u16 seqno = le16_to_cpu(hdr->seq_ctrl);
-
-		if (ieee80211_is_back_req(hdr->frame_control)) {
-			struct ieee80211_bar *bar;
-
-			bar = (struct ieee80211_bar *)skb->data;
-			seqno = le16_to_cpu(bar->start_seq_num);
-		}
-
-		val = MT_TXD3_SN_VALID |
-		      FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
-		txwi[3] |= cpu_to_le32(val);
-	}
-
-	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
-	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
-	txwi[7] |= cpu_to_le32(val);
-}
-
 void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key, int pid,
@@ -687,7 +573,6 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	bool is_mmio = mt76_is_mmio(&dev->mt76);
 	u32 sz_txd = is_mmio ? MT_TXD_SIZE : MT_SDIO_TXD_SIZE;
-	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
 	u16 tx_count = 15;
 	u32 val;
 
@@ -739,10 +624,7 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 	txwi[6] = 0;
 	txwi[7] = wcid->amsdu ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
 
-	if (is_8023)
-		mt7921_mac_write_txwi_8023(dev, txwi, skb, wcid);
-	else
-		mt7921_mac_write_txwi_80211(dev, txwi, skb, key);
+	mt76_connac_mac_write_txwi(skb, txwi, wcid, key);
 
 	if (txwi[2] & cpu_to_le32(MT_TXD2_FIX_RATE)) {
 		int rateidx = vif ? ffs(vif->bss_conf.basic_rates) - 1 : 0;
-- 
2.34.1

