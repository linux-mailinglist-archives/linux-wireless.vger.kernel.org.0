Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013EC4461DD
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Nov 2021 11:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhKEKFG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Nov 2021 06:05:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54290 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233026AbhKEKFE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Nov 2021 06:05:04 -0400
X-UUID: 1d62c20425064964ae6df84c1b3d9784-20211105
X-UUID: 1d62c20425064964ae6df84c1b3d9784-20211105
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 27234366; Fri, 05 Nov 2021 18:02:24 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 5 Nov 2021 18:02:23 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 5 Nov
 2021 18:02:17 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 5 Nov 2021 18:02:17 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH v2 08/11] mt76: mt7915: update rx rate reporting for mt7916
Date:   Fri, 5 Nov 2021 18:02:07 +0800
Message-ID: <95854df7f5be3eafe53ac02bd2eddd3a5ce8df21.1636105953.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1636105953.git.Bo.Jiao@mediatek.com>
References: <cover.1636105953.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

mt7916 reports rx rate from rxd group3 directly.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   3 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 199 +++++++++++-------
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |   6 +
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  11 +-
 4 files changed, 137 insertions(+), 82 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 86f2062..74f7174 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -411,7 +411,8 @@ mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
 	mt76_rmw(dev, MT_MDP_BNRCFR1(band), mask, set);
 
 	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 0x680);
-	/* disable rx rate report by default due to hw issues */
+
+	/* mt7915: disable rx rate report by default due to hw issues */
 	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index d2f0537..b9961b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -384,6 +384,119 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
 	}
 }
 
+static int
+mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
+			struct mt76_rx_status *status,
+			struct ieee80211_supported_band *sband,
+			__le32 *rxv)
+{
+	u32 v0, v1, v2;
+	u16 legacy;
+	u8 flags, stbc, gi, bw, dcm, mode, nss;
+	int i, idx;
+	bool cck = false;
+
+	v0 = le32_to_cpu(rxv[0]);
+	v1 = le32_to_cpu(rxv[1]);
+	v2 = le32_to_cpu(rxv[2]);
+
+	idx = i = FIELD_GET(MT_PRXV_TX_RATE, v0);
+	nss = FIELD_GET(MT_PRXV_NSTS, v0) + 1;
+
+	if (!is_mt7915(&dev->mt76)) {
+		stbc = FIELD_GET(MT_PRXV_HT_STBC, v0);
+		gi = FIELD_GET(MT_PRXV_HT_SHORT_GI, v0);
+		mode = FIELD_GET(MT_PRXV_TX_MODE, v0);
+		dcm = FIELD_GET(MT_PRXV_DCM, v0);
+		bw = FIELD_GET(MT_PRXV_FRAME_MODE, v0);
+	} else {
+		stbc = FIELD_GET(MT_CRXV_HT_STBC, v2);
+		gi = FIELD_GET(MT_CRXV_HT_SHORT_GI, v2);
+		mode = FIELD_GET(MT_CRXV_TX_MODE, v2);
+		dcm = !!(idx & GENMASK(3, 0) & MT_PRXV_TX_DCM);
+		bw = FIELD_GET(MT_CRXV_FRAME_MODE, v2);
+	}
+
+	switch (mode) {
+	case MT_PHY_TYPE_CCK:
+		cck = true;
+		fallthrough;
+	case MT_PHY_TYPE_OFDM:
+		i = mt76_get_rate(&dev->mt76, sband, i, cck);
+		legacy = sband->bitrates[i].bitrate;
+		break;
+	case MT_PHY_TYPE_HT_GF:
+	case MT_PHY_TYPE_HT:
+		status->encoding = RX_ENC_HT;
+		if (i > 31)
+			return -EINVAL;
+
+		flags = RATE_INFO_FLAGS_MCS;
+		if (gi)
+			flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_VHT:
+		status->nss = nss;
+		status->encoding = RX_ENC_VHT;
+		if (i > 9)
+			return -EINVAL;
+
+		flags = RATE_INFO_FLAGS_VHT_MCS;
+		if (gi)
+			flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_HE_MU:
+		status->flag |= RX_FLAG_RADIOTAP_HE_MU;
+		fallthrough;
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+		status->nss = nss;
+		status->encoding = RX_ENC_HE;
+		status->flag |= RX_FLAG_RADIOTAP_HE;
+		i &= GENMASK(3, 0);
+
+		if (gi <= NL80211_RATE_INFO_HE_GI_3_2)
+			status->he_gi = gi;
+
+		status->he_dcm = dcm;
+		flags |= RATE_INFO_FLAGS_HE_MCS;
+		break;
+	default:
+		return -EINVAL;
+	}
+	status->rate_idx = i;
+
+	switch (bw) {
+	case IEEE80211_STA_RX_BW_20:
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		if (mode & MT_PHY_TYPE_HE_EXT_SU &&
+		    (idx & MT_PRXV_TX_ER_SU_106T)) {
+			status->bw = RATE_INFO_BW_HE_RU;
+			status->he_ru =
+				NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		} else {
+			status->bw = RATE_INFO_BW_40;
+		}
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		status->bw = RATE_INFO_BW_80;
+		break;
+	case IEEE80211_STA_RX_BW_160:
+		status->bw = RATE_INFO_BW_160;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
+	if (mode < MT_PHY_TYPE_HE_SU && gi)
+		status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+
+	return 0;
+}
+
 static int
 mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 {
@@ -541,7 +654,8 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	/* RXD Group 3 - P-RXV */
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_3) {
-		u32 v0, v1, v2;
+		u32 v0, v1;
+		int ret;
 
 		rxv = rxd;
 		rxd += 2;
@@ -550,7 +664,6 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 		v0 = le32_to_cpu(rxv[0]);
 		v1 = le32_to_cpu(rxv[1]);
-		v2 = le32_to_cpu(rxv[2]);
 
 		if (v0 & MT_PRXV_HT_AD_CODE)
 			status->enc_flags |= RX_ENC_FLAG_LDPC;
@@ -572,85 +685,17 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 		/* RXD Group 5 - C-RXV */
 		if (rxd1 & MT_RXD1_NORMAL_GROUP_5) {
-			u8 stbc = FIELD_GET(MT_CRXV_HT_STBC, v2);
-			u8 gi = FIELD_GET(MT_CRXV_HT_SHORT_GI, v2);
-			bool cck = false;
-
 			rxd += 18;
 			if ((u8 *)rxd - skb->data >= skb->len)
 				return -EINVAL;
+		}
 
-			idx = i = FIELD_GET(MT_PRXV_TX_RATE, v0);
-			mode = FIELD_GET(MT_CRXV_TX_MODE, v2);
-
-			switch (mode) {
-			case MT_PHY_TYPE_CCK:
-				cck = true;
-				fallthrough;
-			case MT_PHY_TYPE_OFDM:
-				i = mt76_get_rate(&dev->mt76, sband, i, cck);
-				break;
-			case MT_PHY_TYPE_HT_GF:
-			case MT_PHY_TYPE_HT:
-				status->encoding = RX_ENC_HT;
-				if (i > 31)
-					return -EINVAL;
-				break;
-			case MT_PHY_TYPE_VHT:
-				status->nss =
-					FIELD_GET(MT_PRXV_NSTS, v0) + 1;
-				status->encoding = RX_ENC_VHT;
-				if (i > 9)
-					return -EINVAL;
-				break;
-			case MT_PHY_TYPE_HE_MU:
-				status->flag |= RX_FLAG_RADIOTAP_HE_MU;
-				fallthrough;
-			case MT_PHY_TYPE_HE_SU:
-			case MT_PHY_TYPE_HE_EXT_SU:
-			case MT_PHY_TYPE_HE_TB:
-				status->nss =
-					FIELD_GET(MT_PRXV_NSTS, v0) + 1;
-				status->encoding = RX_ENC_HE;
-				status->flag |= RX_FLAG_RADIOTAP_HE;
-				i &= GENMASK(3, 0);
-
-				if (gi <= NL80211_RATE_INFO_HE_GI_3_2)
-					status->he_gi = gi;
-
-				status->he_dcm = !!(idx & MT_PRXV_TX_DCM);
-				break;
-			default:
-				return -EINVAL;
-			}
-			status->rate_idx = i;
-
-			switch (FIELD_GET(MT_CRXV_FRAME_MODE, v2)) {
-			case IEEE80211_STA_RX_BW_20:
-				break;
-			case IEEE80211_STA_RX_BW_40:
-				if (mode & MT_PHY_TYPE_HE_EXT_SU &&
-				    (idx & MT_PRXV_TX_ER_SU_106T)) {
-					status->bw = RATE_INFO_BW_HE_RU;
-					status->he_ru =
-						NL80211_RATE_INFO_HE_RU_ALLOC_106;
-				} else {
-					status->bw = RATE_INFO_BW_40;
-				}
-				break;
-			case IEEE80211_STA_RX_BW_80:
-				status->bw = RATE_INFO_BW_80;
-				break;
-			case IEEE80211_STA_RX_BW_160:
-				status->bw = RATE_INFO_BW_160;
-				break;
-			default:
-				return -EINVAL;
-			}
-
-			status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
-			if (mode < MT_PHY_TYPE_HE_SU && gi)
-				status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		if (!is_mt7915(&dev->mt76) ||
+		    (is_mt7915(&dev->mt76) &&
+		     (rxd1 & MT_RXD1_NORMAL_GROUP_5))) {
+			ret = mt7915_mac_fill_rx_rate(dev, status, sband, rxv);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 4504ebc..d79f0a5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -125,6 +125,12 @@ enum rx_pkt_type {
 #define MT_PRXV_RCPI2			GENMASK(23, 16)
 #define MT_PRXV_RCPI1			GENMASK(15, 8)
 #define MT_PRXV_RCPI0			GENMASK(7, 0)
+#define MT_PRXV_HT_SHORT_GI		GENMASK(16, 15)
+#define MT_PRXV_HT_STBC			GENMASK(23, 22)
+#define MT_PRXV_TX_MODE			GENMASK(27, 24)
+#define MT_PRXV_FRAME_MODE		GENMASK(14, 12)
+#define MT_PRXV_DCM			BIT(17)
+#define MT_PRXV_NUM_RX			BIT(20, 18)
 
 /* C-RXV */
 #define MT_CRXV_HT_STBC			GENMASK(1, 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 057ab27..0650140 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -969,11 +969,14 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct rate_info *txrate = &msta->wcid.rate;
-	struct rate_info rxrate = {};
 
-	if (!mt7915_mcu_get_rx_rate(phy, vif, sta, &rxrate)) {
-		sinfo->rxrate = rxrate;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
+	if (is_mt7915(&phy->dev->mt76)) {
+		struct rate_info rxrate = {};
+
+		if (!mt7915_mcu_get_rx_rate(phy, vif, sta, &rxrate)) {
+			sinfo->rxrate = rxrate;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
+		}
 	}
 
 	if (!txrate->legacy && !txrate->flags)
-- 
2.18.0

