Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892664311E4
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 10:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhJRIMI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 04:12:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51760 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230472AbhJRIMI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 04:12:08 -0400
X-UUID: 6769d290a73f4f71941a226b58720ec0-20211018
X-UUID: 6769d290a73f4f71941a226b58720ec0-20211018
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1684906739; Mon, 18 Oct 2021 16:09:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Oct 2021 16:09:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Oct 2021 16:09:54 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v3 3/4] mt76: mt7915: fix missing HE phy cap
Date:   Mon, 18 Oct 2021 16:09:40 +0800
Message-ID: <20211018080941.11443-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211018080941.11443-1-shayne.chen@mediatek.com>
References: <20211018080941.11443-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix missing HE phy cap related to vif and starec setting.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 12 +++++++++---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  |  8 ++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index cedecf2c693d..274b30a58f05 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -626,7 +626,6 @@ mt7915_set_stream_he_txbf_caps(struct ieee80211_sta_he_cap *he_cap,
 			       int vif, int nss)
 {
 	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
-	struct ieee80211_he_mcs_nss_supp *mcs = &he_cap->he_mcs_nss_supp;
 	u8 c;
 
 #ifdef CONFIG_MAC80211_MESH
@@ -678,8 +677,11 @@ mt7915_set_stream_he_txbf_caps(struct ieee80211_sta_he_cap *he_cap,
 	elem->phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
 	elem->phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
 
-	/* num_snd_dim */
-	c = (nss - 1) | (max_t(int, le16_to_cpu(mcs->tx_mcs_160), 1) << 3);
+	/* num_snd_dim
+	 * for mt7915, max supported nss is 2 for bw > 80MHz
+	 */
+	c = (nss - 1) |
+	    IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_2;
 	elem->phy_cap_info[5] |= c;
 
 	c = IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
@@ -787,7 +789,11 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
 				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
 			he_cap_elem->phy_cap_info[6] |=
+				IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
 				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
 			break;
 		case NL80211_IFTYPE_STATION:
 			he_cap_elem->mac_cap_info[1] |=
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 4c687380120e..b4cc4cb35762 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1396,6 +1396,10 @@ mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	    IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ)
 		cap |= STA_REC_HE_CAP_LE_EQ_80M_RX_STBC;
 
+	if (elem->phy_cap_info[6] &
+	    IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB)
+		cap |= STA_REC_HE_CAP_TRIG_CQI_FK;
+
 	if (elem->phy_cap_info[6] &
 	    IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE)
 		cap |= STA_REC_HE_CAP_PARTIAL_BW_EXT_RANGE;
@@ -1420,10 +1424,6 @@ mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	    IEEE80211_HE_PHY_CAP8_HE_ER_SU_1XLTF_AND_08_US_GI)
 		cap |= STA_REC_HE_CAP_ER_SU_PPDU_1LTF_8US_GI;
 
-	if (elem->phy_cap_info[9] &
-	    IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK)
-		cap |= STA_REC_HE_CAP_TRIG_CQI_FK;
-
 	if (elem->phy_cap_info[9] &
 	    IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU)
 		cap |= STA_REC_HE_CAP_TX_1024QAM_UNDER_RU242;
-- 
2.29.2

