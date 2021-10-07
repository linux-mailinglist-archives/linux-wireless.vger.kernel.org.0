Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B25425074
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Oct 2021 11:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbhJGJyq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Oct 2021 05:54:46 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:37966 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237335AbhJGJyn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Oct 2021 05:54:43 -0400
X-UUID: e2da4010cc8549c1998358ee8f8d7175-20211007
X-UUID: e2da4010cc8549c1998358ee8f8d7175-20211007
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 746960781; Thu, 07 Oct 2021 17:52:44 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 7 Oct 2021 17:52:44 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 7 Oct
 2021 17:52:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Oct 2021 17:52:43 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7915: fix missing HE phy cap
Date:   Thu, 7 Oct 2021 17:49:41 +0800
Message-ID: <20211007094941.6641-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211007094941.6641-1-shayne.chen@mediatek.com>
References: <20211007094941.6641-1-shayne.chen@mediatek.com>
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
index 24c4377e9681..d8391d61240d 100644
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
@@ -785,7 +787,11 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
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
index f48ece0fc569..a4ca6d12f3a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1395,6 +1395,10 @@ mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	    IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ)
 		cap |= STA_REC_HE_CAP_LE_EQ_80M_RX_STBC;
 
+	if (elem->phy_cap_info[6] &
+	    IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB)
+		cap |= STA_REC_HE_CAP_TRIG_CQI_FK;
+
 	if (elem->phy_cap_info[6] &
 	    IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE)
 		cap |= STA_REC_HE_CAP_PARTIAL_BW_EXT_RANGE;
@@ -1419,10 +1423,6 @@ mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
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
2.25.1

