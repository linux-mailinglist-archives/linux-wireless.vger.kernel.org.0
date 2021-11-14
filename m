Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A455544F9DB
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Nov 2021 18:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhKNSCB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Nov 2021 13:02:01 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:59730 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230194AbhKNSB7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Nov 2021 13:01:59 -0500
X-UUID: 2841e92f97cd42a0b08bfe3a0b603ddd-20211115
X-UUID: 2841e92f97cd42a0b08bfe3a0b603ddd-20211115
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1926861773; Mon, 15 Nov 2021 01:59:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 15 Nov 2021 01:59:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Nov 2021 01:59:00 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: only set rx radiotap flag from within decoder functions
Date:   Mon, 15 Nov 2021 01:58:58 +0800
Message-ID: <08c9500ce8e1dfbd767032ba2ee4122a87a4b9de.1636912489.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Only set RX_FLAG_RADIOTAP_HE and RX_FLAG_RADIOTAP_HE_MU from with their
own decoder functions to prevent header calculation error.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 44 ++++++++-----------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 34 ++++++--------
 2 files changed, 33 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 60e8340c8eeb..c3262738dbad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -268,10 +268,9 @@ mt7915_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
 }
 
 static void
-mt7915_mac_decode_he_mu_radiotap(struct sk_buff *skb,
-				 struct mt76_rx_status *status,
-				 __le32 *rxv)
+mt7915_mac_decode_he_mu_radiotap(struct sk_buff *skb, __le32 *rxv)
 {
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	static const struct ieee80211_radiotap_he_mu mu_known = {
 		.flags1 = HE_BITS(MU_FLAGS1_SIG_B_MCS_KNOWN) |
 			  HE_BITS(MU_FLAGS1_SIG_B_DCM_KNOWN) |
@@ -281,6 +280,8 @@ mt7915_mac_decode_he_mu_radiotap(struct sk_buff *skb,
 	};
 	struct ieee80211_radiotap_he_mu *he_mu = NULL;
 
+	status->flag |= RX_FLAG_RADIOTAP_HE_MU;
+
 	he_mu = skb_push(skb, sizeof(mu_known));
 	memcpy(he_mu, &mu_known, sizeof(mu_known));
 
@@ -308,10 +309,9 @@ mt7915_mac_decode_he_mu_radiotap(struct sk_buff *skb,
 }
 
 static void
-mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
-			      struct mt76_rx_status *status,
-			      __le32 *rxv, u32 phy)
+mt7915_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u32 mode)
 {
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	static const struct ieee80211_radiotap_he known = {
 		.data1 = HE_BITS(DATA1_DATA_MCS_KNOWN) |
 			 HE_BITS(DATA1_DATA_DCM_KNOWN) |
@@ -329,6 +329,8 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
 	struct ieee80211_radiotap_he *he = NULL;
 	u32 ltf_size = le32_get_bits(rxv[2], MT_CRXV_HE_LTF_SIZE) + 1;
 
+	status->flag |= RX_FLAG_RADIOTAP_HE;
+
 	he = skb_push(skb, sizeof(known));
 	memcpy(he, &known, sizeof(known));
 
@@ -343,7 +345,7 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
 	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[14]) |
 		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[14]);
 
-	switch (phy) {
+	switch (mode) {
 	case MT_PHY_TYPE_HE_SU:
 		he->data1 |= HE_BITS(DATA1_FORMAT_SU) |
 			     HE_BITS(DATA1_UL_DL_KNOWN) |
@@ -366,6 +368,7 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
 		he->data4 |= HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[7]);
 
 		mt7915_mac_decode_he_radiotap_ru(status, he, rxv);
+		mt7915_mac_decode_he_mu_radiotap(skb, rxv);
 		break;
 	case MT_PHY_TYPE_HE_TB:
 		he->data1 |= HE_BITS(DATA1_FORMAT_TRIG) |
@@ -456,7 +459,6 @@ static int mt7915_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	else
 		memcpy(skb_push(skb, sizeof(hdr) - 6), &hdr, sizeof(hdr) - 6);
 
-	status->flag &= ~(RX_FLAG_RADIOTAP_HE | RX_FLAG_RADIOTAP_HE_MU);
 	return 0;
 }
 
@@ -467,7 +469,6 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt7915_phy *phy = &dev->phy;
 	struct ieee80211_supported_band *sband;
-	struct ieee80211_hdr *hdr;
 	__le32 *rxd = (__le32 *)skb->data;
 	__le32 *rxv = NULL;
 	u32 mode = 0;
@@ -681,15 +682,12 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 					return -EINVAL;
 				break;
 			case MT_PHY_TYPE_HE_MU:
-				status->flag |= RX_FLAG_RADIOTAP_HE_MU;
-				fallthrough;
 			case MT_PHY_TYPE_HE_SU:
 			case MT_PHY_TYPE_HE_EXT_SU:
 			case MT_PHY_TYPE_HE_TB:
 				status->nss =
 					FIELD_GET(MT_PRXV_NSTS, v0) + 1;
 				status->encoding = RX_ENC_HE;
-				status->flag |= RX_FLAG_RADIOTAP_HE;
 				i &= GENMASK(3, 0);
 
 				if (gi <= NL80211_RATE_INFO_HE_GI_3_2)
@@ -752,30 +750,26 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		}
 	}
 
-	if (insert_ccmp_hdr && !hdr_trans) {
-		u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
+	if (!hdr_trans) {
+		struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
 
-		mt76_insert_ccmp_hdr(skb, key_id);
-	}
+		if (insert_ccmp_hdr) {
+			u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
+
+			mt76_insert_ccmp_hdr(skb, key_id);
+		}
 
-	if (!hdr_trans) {
-		hdr = mt76_skb_get_hdr(skb);
 		fc = hdr->frame_control;
 		if (ieee80211_is_data_qos(fc)) {
 			seq_ctrl = le16_to_cpu(hdr->seq_ctrl);
 			qos_ctl = *ieee80211_get_qos_ctl(hdr);
 		}
 	} else {
-		status->flag &= ~(RX_FLAG_RADIOTAP_HE |
-				  RX_FLAG_RADIOTAP_HE_MU);
 		status->flag |= RX_FLAG_8023;
 	}
 
-	if (rxv && status->flag & RX_FLAG_RADIOTAP_HE) {
-		mt7915_mac_decode_he_radiotap(skb, status, rxv, mode);
-		if (status->flag & RX_FLAG_RADIOTAP_HE_MU)
-			mt7915_mac_decode_he_mu_radiotap(skb, status, rxv);
-	}
+	if (rxv && mode >= MT_PHY_TYPE_HE_SU)
+		mt7915_mac_decode_he_radiotap(skb, rxv, mode);
 
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index d7ab41773035..bd10bd6dda7a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -218,10 +218,9 @@ mt7921_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
 }
 
 static void
-mt7921_mac_decode_he_mu_radiotap(struct sk_buff *skb,
-				 struct mt76_rx_status *status,
-				 __le32 *rxv)
+mt7921_mac_decode_he_mu_radiotap(struct sk_buff *skb, __le32 *rxv)
 {
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	static const struct ieee80211_radiotap_he_mu mu_known = {
 		.flags1 = HE_BITS(MU_FLAGS1_SIG_B_MCS_KNOWN) |
 			  HE_BITS(MU_FLAGS1_SIG_B_DCM_KNOWN) |
@@ -233,6 +232,8 @@ mt7921_mac_decode_he_mu_radiotap(struct sk_buff *skb,
 	};
 	struct ieee80211_radiotap_he_mu *he_mu;
 
+	status->flag |= RX_FLAG_RADIOTAP_HE_MU;
+
 	he_mu = skb_push(skb, sizeof(mu_known));
 	memcpy(he_mu, &mu_known, sizeof(mu_known));
 
@@ -263,10 +264,9 @@ mt7921_mac_decode_he_mu_radiotap(struct sk_buff *skb,
 }
 
 static void
-mt7921_mac_decode_he_radiotap(struct sk_buff *skb,
-			      struct mt76_rx_status *status,
-			      __le32 *rxv, u32 phy)
+mt7921_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u32 mode)
 {
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	static const struct ieee80211_radiotap_he known = {
 		.data1 = HE_BITS(DATA1_DATA_MCS_KNOWN) |
 			 HE_BITS(DATA1_DATA_DCM_KNOWN) |
@@ -284,6 +284,8 @@ mt7921_mac_decode_he_radiotap(struct sk_buff *skb,
 	struct ieee80211_radiotap_he *he = NULL;
 	u32 ltf_size = le32_get_bits(rxv[2], MT_CRXV_HE_LTF_SIZE) + 1;
 
+	status->flag |= RX_FLAG_RADIOTAP_HE;
+
 	he = skb_push(skb, sizeof(known));
 	memcpy(he, &known, sizeof(known));
 
@@ -298,7 +300,7 @@ mt7921_mac_decode_he_radiotap(struct sk_buff *skb,
 	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[14]) |
 		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[14]);
 
-	switch (phy) {
+	switch (mode) {
 	case MT_PHY_TYPE_HE_SU:
 		he->data1 |= HE_BITS(DATA1_FORMAT_SU) |
 			     HE_BITS(DATA1_UL_DL_KNOWN) |
@@ -322,6 +324,7 @@ mt7921_mac_decode_he_radiotap(struct sk_buff *skb,
 		he->data4 |= HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[7]);
 
 		mt7921_mac_decode_he_radiotap_ru(status, he, rxv);
+		mt7921_mac_decode_he_mu_radiotap(skb, rxv);
 		break;
 	case MT_PHY_TYPE_HE_TB:
 		he->data1 |= HE_BITS(DATA1_FORMAT_TRIG) |
@@ -467,7 +470,6 @@ static int mt7921_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	else
 		memcpy(skb_push(skb, sizeof(hdr) - 6), &hdr, sizeof(hdr) - 6);
 
-	status->flag &= ~(RX_FLAG_RADIOTAP_HE | RX_FLAG_RADIOTAP_HE_MU);
 	return 0;
 }
 
@@ -483,7 +485,6 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt7921_phy *phy = &dev->phy;
 	struct ieee80211_supported_band *sband;
-	struct ieee80211_hdr *hdr;
 	u32 rxd0 = le32_to_cpu(rxd[0]);
 	u32 rxd1 = le32_to_cpu(rxd[1]);
 	u32 rxd2 = le32_to_cpu(rxd[2]);
@@ -689,15 +690,12 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 				return -EINVAL;
 			break;
 		case MT_PHY_TYPE_HE_MU:
-			status->flag |= RX_FLAG_RADIOTAP_HE_MU;
-			fallthrough;
 		case MT_PHY_TYPE_HE_SU:
 		case MT_PHY_TYPE_HE_EXT_SU:
 		case MT_PHY_TYPE_HE_TB:
 			status->nss =
 				FIELD_GET(MT_PRXV_NSTS, v0) + 1;
 			status->encoding = RX_ENC_HE;
-			status->flag |= RX_FLAG_RADIOTAP_HE;
 			i &= GENMASK(3, 0);
 
 			if (gi <= NL80211_RATE_INFO_HE_GI_3_2)
@@ -767,6 +765,8 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	}
 
 	if (!hdr_trans) {
+		struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
+
 		if (insert_ccmp_hdr) {
 			u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
 
@@ -780,19 +780,13 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 			qos_ctl = *ieee80211_get_qos_ctl(hdr);
 		}
 	} else {
-		status->flag &= ~(RX_FLAG_RADIOTAP_HE |
-				  RX_FLAG_RADIOTAP_HE_MU);
 		status->flag |= RX_FLAG_8023;
 	}
 
 	mt7921_mac_assoc_rssi(dev, skb);
 
-	if (rxv && status->flag & RX_FLAG_RADIOTAP_HE) {
-		mt7921_mac_decode_he_radiotap(skb, status, rxv, mode);
-
-		if (status->flag & RX_FLAG_RADIOTAP_HE_MU)
-			mt7921_mac_decode_he_mu_radiotap(skb, status, rxv);
-	}
+	if (rxv && mode >= MT_PHY_TYPE_HE_SU)
+		mt7921_mac_decode_he_radiotap(skb, rxv, mode);
 
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
-- 
2.29.2

