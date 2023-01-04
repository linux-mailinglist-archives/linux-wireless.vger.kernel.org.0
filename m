Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6045265CF06
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jan 2023 10:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjADJEy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Jan 2023 04:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjADJEU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Jan 2023 04:04:20 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16736370
        for <linux-wireless@vger.kernel.org>; Wed,  4 Jan 2023 01:04:17 -0800 (PST)
X-UUID: dc7deab8d1d441e1ba964e87e21b6547-20230104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=s02Nzo/o8DkPnFzi7Rk9w5YRYVFFFZhDcys5ZCrLGfw=;
        b=Ed+FIcfJh9mvthkWmDSPCANCKXensFyXDxV8dgfR80RlF3BH6k/D9bTarQBHqkwicmqXjvgY0k/6Gpc93DSePixZShu93wUEVrOqPDbztC0x+yB+gdeyBfiogPwyItYPn3iwqcAP5Z2j2ep4vnGd+LBLmv2TaYeEaEZpxUGYrhs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:2cc316ef-c236-4479-b3a3-e2a32c7364bf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:09771b1,CLOUDID:1c3e368b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: dc7deab8d1d441e1ba964e87e21b6547-20230104
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <meichia.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 807545947; Wed, 04 Jan 2023 17:04:11 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 4 Jan 2023 17:04:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 4 Jan 2023 17:04:10 +0800
From:   MeiChia Chiu <MeiChia.Chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>
Subject: [PATCH v2] wifi: mt76: mt7915: remove BW160 and BW80+80 support
Date:   Wed, 4 Jan 2023 17:03:52 +0800
Message-ID: <20230104090352.31938-1-MeiChia.Chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove BW160 and BW80+80 capability in mt7915.

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Money Wang<Money.Wang@mediatek.com>
Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
---
v2: update commit message and title
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 38 +++++--------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 571c94835942..c72d673f02dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -38,8 +38,7 @@ static const struct ieee80211_iface_combination if_comb[] = {
 				       BIT(NL80211_CHAN_WIDTH_20) |
 				       BIT(NL80211_CHAN_WIDTH_40) |
 				       BIT(NL80211_CHAN_WIDTH_80) |
-				       BIT(NL80211_CHAN_WIDTH_160) |
-				       BIT(NL80211_CHAN_WIDTH_80P80),
+				       BIT(NL80211_CHAN_WIDTH_160),
 	}
 };
 
@@ -394,11 +393,6 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 			phy->mt76->sband_5g.sband.vht_cap.cap |=
 				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991 |
 				IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
-
-			if (!dev->dbdc_support)
-				phy->mt76->sband_5g.sband.vht_cap.cap |=
-					IEEE80211_VHT_CAP_SHORT_GI_160 |
-					IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
 		} else {
 			phy->mt76->sband_5g.sband.vht_cap.cap |=
 				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
@@ -834,13 +828,9 @@ mt7915_set_stream_he_txbf_caps(struct mt7915_phy *phy,
 	int sts = hweight8(phy->mt76->chainmask);
 	u8 c, sts_160 = sts;
 
-	/* Can do 1/2 of STS in 160Mhz mode for mt7915 */
-	if (is_mt7915(&dev->mt76)) {
-		if (!dev->dbdc_support)
-			sts_160 /= 2;
-		else
-			sts_160 = 0;
-	}
+	/* mt7915 doesn't support bw160 */
+	if (is_mt7915(&dev->mt76))
+		sts_160 = 0;
 
 #ifdef CONFIG_MAC80211_MESH
 	if (vif == NL80211_IFTYPE_MESH_POINT)
@@ -894,9 +884,6 @@ mt7915_set_stream_he_txbf_caps(struct mt7915_phy *phy,
 	elem->phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
 	elem->phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
 
-	/* num_snd_dim
-	 * for mt7915, max supported sts is 2 for bw > 80MHz and 0 if dbdc
-	 */
 	c = FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
 		       sts - 1);
 	if (sts_160)
@@ -944,15 +931,10 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 	int i, idx = 0, nss = hweight8(phy->mt76->antenna_mask);
 	u16 mcs_map = 0;
 	u16 mcs_map_160 = 0;
-	u8 nss_160;
+	u8 nss_160 = nss;
 
-	if (!is_mt7915(&dev->mt76))
-		nss_160 = nss;
-	else if (!dev->dbdc_support)
-		/* Can do 1/2 of NSS streams in 160Mhz mode for mt7915 */
-		nss_160 = nss / 2;
-	else
-		/* Can't do 160MHz with mt7915 dbdc */
+	/* Can't do 160MHz with mt7915 */
+	if (is_mt7915(&dev->mt76))
 		nss_160 = 0;
 
 	for (i = 0; i < 8; i++) {
@@ -1002,8 +984,7 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 		else if (nss_160)
 			he_cap_elem->phy_cap_info[0] =
 				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
-				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
-				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
 		else
 			he_cap_elem->phy_cap_info[0] =
 				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
@@ -1075,12 +1056,11 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 			break;
 		}
 
+		memset(he_mcs, 0, sizeof(*he_mcs));
 		he_mcs->rx_mcs_80 = cpu_to_le16(mcs_map);
 		he_mcs->tx_mcs_80 = cpu_to_le16(mcs_map);
 		he_mcs->rx_mcs_160 = cpu_to_le16(mcs_map_160);
 		he_mcs->tx_mcs_160 = cpu_to_le16(mcs_map_160);
-		he_mcs->rx_mcs_80p80 = cpu_to_le16(mcs_map_160);
-		he_mcs->tx_mcs_80p80 = cpu_to_le16(mcs_map_160);
 
 		mt7915_set_stream_he_txbf_caps(phy, he_cap, i);
 
-- 
2.18.0

