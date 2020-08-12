Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11373242837
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 12:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHLK2e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 06:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgHLK2d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 06:28:33 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E981C061788
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 03:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pboeGOsZF8mBK+lrby76L4nQd6TphDGFqpffL2IDs4A=; b=FHpvXPcHHdqTOAWs9a4Nnidvw9
        LTfFRh7ZCHZu04Gyesz3dY4xz7x5fF9Vb9rH2Xb3mRrTgZG4jyex1fhKovmwCHhc8kWuvr4mpmGqh
        kGlfJjOYEj8Dvgduv2OZOysBQkFBv8vTFbQqdxRtbluMTuIhfCOZAeIEDkxt135tvE6I=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k5nzk-0002U3-5z
        for linux-wireless@vger.kernel.org; Wed, 12 Aug 2020 12:28:32 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/8] mt76: mt7915: enable offloading of sequence number assignment
Date:   Wed, 12 Aug 2020 12:28:26 +0200
Message-Id: <20200812102831.11991-3-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812102831.11991-1-nbd@nbd.name>
References: <20200812102831.11991-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Preparation for supporting more offload features

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 49 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  1 -
 2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 06371d694618..dde1c93d6701 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -565,6 +565,7 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
 	bool multicast = is_multicast_ether_addr(hdr->addr1);
 	struct ieee80211_vif *vif = info->control.vif;
 	struct mt76_phy *mphy = &dev->mphy;
@@ -572,6 +573,7 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	__le16 fc = hdr->frame_control;
 	u16 tx_count = 15, seqno = 0;
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
 	u32 val;
 
 	if (vif) {
@@ -587,6 +589,10 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
 	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
 
+	txwi[4] = 0;
+	txwi[5] = 0;
+	txwi[6] = 0;
+
 	if (beacon) {
 		p_fmt = MT_TX_TYPE_FW;
 		q_idx = MT_LMAC_BCN0;
@@ -599,6 +605,20 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 			mt7915_lmac_mapping(dev, skb_get_queue_mapping(skb));
 	}
 
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
 	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + MT_TXD_SIZE) |
 	      FIELD_PREP(MT_TXD0_PKT_FMT, p_fmt) |
 	      FIELD_PREP(MT_TXD0_Q_IDX, q_idx);
@@ -609,8 +629,7 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	      FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11) |
 	      FIELD_PREP(MT_TXD1_HDR_INFO,
 			 ieee80211_get_hdrlen_from_skb(skb) / 2) |
-	      FIELD_PREP(MT_TXD1_TID,
-			 skb->priority & IEEE80211_QOS_CTL_TID_MASK) |
+	      FIELD_PREP(MT_TXD1_TID, tid) |
 	      FIELD_PREP(MT_TXD1_OWN_MAC, omac_idx);
 
 	if (ext_phy && q_idx >= MT_LMAC_ALTX0 && q_idx <= MT_LMAC_BCN0)
@@ -634,10 +653,6 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	}
 	txwi[2] = cpu_to_le32(val);
 
-	txwi[4] = 0;
-	txwi[5] = 0;
-	txwi[6] = 0;
-
 	if (!ieee80211_is_data(fc) || multicast) {
 		u16 rate;
 
@@ -668,17 +683,19 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	txwi[7] = cpu_to_le32(val);
 
 	val = FIELD_PREP(MT_TXD3_REM_TX_COUNT, tx_count);
-	if (ieee80211_is_data_qos(fc)) {
-		seqno = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
-		val |= MT_TXD3_SN_VALID;
-	} else if (ieee80211_is_back_req(fc)) {
-		struct ieee80211_bar *bar;
-
-		bar = (struct ieee80211_bar *)skb->data;
-		seqno = IEEE80211_SEQ_TO_SN(le16_to_cpu(bar->start_seq_num));
-		val |= MT_TXD3_SN_VALID;
+	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
+		seqno = le16_to_cpu(hdr->seq_ctrl);
+
+		if (ieee80211_is_back_req(hdr->frame_control)) {
+			struct ieee80211_bar *bar;
+
+			bar = (struct ieee80211_bar *)skb->data;
+			seqno = le16_to_cpu(bar->start_seq_num);
+		}
+
+		val |= MT_TXD3_SN_VALID |
+		       FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
 	}
-	val |= FIELD_PREP(MT_TXD3_SEQ, seqno);
 	txwi[3] |= cpu_to_le32(val);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 0feea2c33717..9e53f0db87f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -620,7 +620,6 @@ mt7915_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		mt7915_mcu_add_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
-		mtxq->agg_ssn = IEEE80211_SN_TO_SEQ(ssn);
 		mt7915_set_aggr_state(msta, tid, MT7915_AGGR_START);
 		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		break;
-- 
2.28.0

