Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4903D5F0E82
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiI3PNs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 11:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiI3PNp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 11:13:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2693B129356
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 08:13:44 -0700 (PDT)
X-UUID: 2addc4eb659f4874be23fc6ee39fb294-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OE6tyZuG+MZ1q2ynrqmy+T0hfNIK+mVvOkg5kk2qsRY=;
        b=o9yJUMRkm2kbo8SwyTuEzASrBw3+fL/7loE3paIqzubWJo1Y0XRllnMI1LW7TKvzkIJOhTT10TzKy05vFEA7d656ujKJEPnh2ohzJ1rvOEcvPS/f6ogvEQre4n9341bjpwd6HSN7UEReQoaaE7VyzrQNzH1xZf5I3fEcFFSZBg4=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:7ea0c18a-977f-4d18-90ca-1a0173e650a6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.11,REQID:7ea0c18a-977f-4d18-90ca-1a0173e650a6,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:39a5ff1,CLOUDID:7c4fcde4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:2209302313402Q2G3WZN,BulkQuantity:0,Recheck:0,SF:28|16|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0
X-UUID: 2addc4eb659f4874be23fc6ee39fb294-20220930
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 620223459; Fri, 30 Sep 2022 23:13:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 30 Sep 2022 23:13:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 30 Sep 2022 23:13:37 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 2/6] wifi: mt76: mt7915: deal with special variant of mt7916
Date:   Fri, 30 Sep 2022 23:13:11 +0800
Message-ID: <20220930151315.19012-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220930151315.19012-1-shayne.chen@mediatek.com>
References: <20220930151315.19012-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

A variant of mt7916 supports up to 3 tx/rx paths but with only
2 spatial streams. An example usage of the 3rd path is to server as
an auxiliary for beamforming.
In order to deal with this case, this patch reworks some parts to
correctly use paths or streams.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 37 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  9 +++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  2 +-
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index cc2aac86bcfb..324db5291c85 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -700,13 +700,13 @@ mt7915_init_hardware(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 
 void mt7915_set_stream_vht_txbf_caps(struct mt7915_phy *phy)
 {
-	int nss;
+	int sts;
 	u32 *cap;
 
 	if (!phy->mt76->cap.has_5ghz)
 		return;
 
-	nss = hweight8(phy->mt76->chainmask);
+	sts = hweight8(phy->mt76->chainmask);
 	cap = &phy->mt76->sband_5g.sband.vht_cap.cap;
 
 	*cap |= IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
@@ -717,28 +717,27 @@ void mt7915_set_stream_vht_txbf_caps(struct mt7915_phy *phy)
 		  IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
 		  IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE);
 
-	if (nss < 2)
+	if (sts < 2)
 		return;
 
 	*cap |= IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
 		IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE |
 		FIELD_PREP(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
-			   nss - 1);
+			   sts - 1);
 }
 
 static void
-mt7915_set_stream_he_txbf_caps(struct mt7915_dev *dev,
-			       struct ieee80211_sta_he_cap *he_cap,
-			       int vif, int nss)
+mt7915_set_stream_he_txbf_caps(struct mt7915_phy *phy,
+			       struct ieee80211_sta_he_cap *he_cap, int vif)
 {
+	struct mt7915_dev *dev = phy->dev;
 	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
-	u8 c, nss_160;
+	int sts = hweight8(phy->mt76->chainmask);
+	u8 c, sts_160 = sts;
 
-	/* Can do 1/2 of NSS streams in 160Mhz mode for mt7915 */
+	/* Can do 1/2 of STS in 160Mhz mode for mt7915 */
 	if (is_mt7915(&dev->mt76) && !dev->dbdc_support)
-		nss_160 = nss / 2;
-	else
-		nss_160 = nss;
+		sts_160 /= 2;
 
 #ifdef CONFIG_MAC80211_MESH
 	if (vif == NL80211_IFTYPE_MESH_POINT)
@@ -778,11 +777,11 @@ mt7915_set_stream_he_txbf_caps(struct mt7915_dev *dev,
 
 	elem->phy_cap_info[6] |= c;
 
-	if (nss < 2)
+	if (sts < 2)
 		return;
 
 	/* the maximum cap is 4 x 3, (Nr, Nc) = (3, 2) */
-	elem->phy_cap_info[7] |= min_t(int, nss - 1, 2) << 3;
+	elem->phy_cap_info[7] |= min_t(int, sts - 1, 2) << 3;
 
 	if (vif != NL80211_IFTYPE_AP)
 		return;
@@ -791,12 +790,12 @@ mt7915_set_stream_he_txbf_caps(struct mt7915_dev *dev,
 	elem->phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
 
 	/* num_snd_dim
-	 * for mt7915, max supported nss is 2 for bw > 80MHz
+	 * for mt7915, max supported sts is 2 for bw > 80MHz
 	 */
 	c = FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
-		       nss - 1) |
+		       sts - 1) |
 	    FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK,
-		       nss_160 - 1);
+		       sts_160 - 1);
 	elem->phy_cap_info[5] |= c;
 
 	c = IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
@@ -836,7 +835,7 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 		    struct ieee80211_sband_iftype_data *data)
 {
 	struct mt7915_dev *dev = phy->dev;
-	int i, idx = 0, nss = hweight8(phy->mt76->chainmask);
+	int i, idx = 0, nss = hweight8(phy->mt76->antenna_mask);
 	u16 mcs_map = 0;
 	u16 mcs_map_160 = 0;
 	u8 nss_160;
@@ -969,7 +968,7 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 		he_mcs->rx_mcs_80p80 = cpu_to_le16(mcs_map_160);
 		he_mcs->tx_mcs_80p80 = cpu_to_le16(mcs_map_160);
 
-		mt7915_set_stream_he_txbf_caps(dev, he_cap, i, nss);
+		mt7915_set_stream_he_txbf_caps(phy, he_cap, i);
 
 		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
 		if (he_cap_elem->phy_cap_info[6] &
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 89b519cfd14c..8379fbbeaaea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -965,10 +965,11 @@ mt7915_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 
 	phy->mt76->antenna_mask = tx_ant;
 
-	if (ext_phy)
-		tx_ant <<= dev->chainshift;
-
-	phy->mt76->chainmask = tx_ant;
+	/* handle a variant of mt7916 which has 3T3R but nss2 on 5 GHz band */
+	if (is_mt7916(&dev->mt76) && ext_phy && hweight8(tx_ant) == max_nss)
+		phy->mt76->chainmask = dev->chainmask >> dev->chainshift;
+	else
+		phy->mt76->chainmask = tx_ant << (dev->chainshift * ext_phy);
 
 	mt76_set_stream_caps(phy->mt76, true);
 	mt7915_set_stream_vht_txbf_caps(phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 1b9f3da8ae96..6417fe685f17 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -485,7 +485,7 @@ static void
 mt7915_mcu_bss_ra_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		      struct mt7915_phy *phy)
 {
-	int max_nss = hweight8(phy->mt76->chainmask);
+	int max_nss = hweight8(phy->mt76->antenna_mask);
 	struct bss_info_ra *ra;
 	struct tlv *tlv;
 
-- 
2.25.1

