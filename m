Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5747762464E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 16:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiKJPr2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 10:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiKJPrZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 10:47:25 -0500
X-Greylist: delayed 309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 07:47:24 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C793E0A6
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 07:47:24 -0800 (PST)
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis)
 id 1MZk5x-1oWQ1N2sFD-00Wms6; Thu, 10 Nov 2022 16:42:02 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 4/4] wifi: mt76: mt7915: don't claim 160MHz support with mt7915 DBDC
Date:   Thu, 10 Nov 2022 16:39:53 +0100
Message-Id: <20221110153953.22562-5-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110153953.22562-1-nicolas.cavallari@green-communications.fr>
References: <20221110153953.22562-1-nicolas.cavallari@green-communications.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hdCc4p4xDDbyDoUyNOU2iJp595S2wa6epFe7YT97gG+3hfHs7JO
 RPZx7M/aK9vpAPCLMvIn1Sy1LasekiWPcxP/2bG5bSnsgdp28q4KaI7viWckSF9jqIXKSSB
 GL57mjgg8y/ySNI8yCgiS2zkezcjxTWkRwNldNY2eMcMrAryzqu2TONd2wHkGICGytrs3Qb
 FTDKG8ybVgcHDBsPzVsog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p0mUQi40ceA=:hhxUmzbH1Mo4D2NaqQltHT
 +9pS1xRnOGGdY1uHFWyGr8JReNYmivd/adferQk1qIcWwmdHdw67wlri1rDCj5g7tbbnVeSIY
 H4ew5Msr1QNzOIdABfs2cLyxCbJD64fxq6m7NRiEwgb6efuUfxEZ+UTb5XVz9i0CWwaIxOH0t
 ltCfhukZL9e5ZzwqPbAFhyoXT+JOvEY786IwDz3we+ZOFq0tkCKYRe1e024ofi42HFodhj/kY
 05E4zOEmNVdejYxopND4QEBE2B5qGAMKpQH/BeXojmyooy6RJWN1O3oTq2WhpTYpYcIHs8otc
 CcxbYeMChBMg9DsG4E1XIPB6Xm30ltHgvqyNzoO7Fz7MH0zOxniCoitWo4pDTe2AObtK4/XDJ
 GbqtwpYZWjlyEOFLDd9O+b9VpTsOG3pHOcWqWsMx+pjbNye82whGtvVX9pIKJ+gR1rFp1zmaX
 1JM1guQTohM428p7gbC07GiCumeXb5W36FOl2mI9a5NgaWK/cWamSgRkZ3cYR/PXLsWSC1xhe
 3YXp5FUR9kYkkalZYNq7ARFfMD4sDSDFWXnsb/MvZbzl6LYoAtwMvJbEFE90ur51rag2Q/+oO
 NySDfuwRXKwkaVijdvYUvGiS/x8OVV8Tgg3ABtSv8GqctduoqjkxfOgUu8ELh5aO3yz8nKX0R
 NPkhaAXkc/yFYYveGFwq7JnzOZIzHPkuxCAxsdHqWun0bSkuqP9AezPzsMv9pi69rmsVv3KTE
 Rn60WgaRY/fpolO1z/f2DZUtYY5m2V4GGNuXhI57dhs/xKhWCe0HxUS/5GxH2MFpKw724Ynen
 Nk2xpdNhf1xVlfhW0wGxnE4Wx+O3snfJNNZoNhAxrd4lKFA0ZKAPts+4F58Ixb2pWZF3ZbTlU
 uvepUpcQQ66aAq3sSXRSjl8h/GBw77g4KO+UNpFM8798bxqe/p1GenDVFdYHth1WOxUKjGkOR
 mZl0c+p4P/NTzU+EX/klWPjMKJ3YryXcUh9WynJYT0xG/aBLjsqXy9OIq1EO5IRSGTenjuV02
 LGe2VrXLzUmH5uZDp0yxuDw0erMufc/0qN+0Wlpgu6sDkEWq+wBnKHWQuRiMLcbUAntgEkfiI
 wBxfx+3QnbekoFW4hHaRLTHKnALRs1CL/Y5nZj+jrK8b2Cc4dgedkaLuanRcUom/ZZQ60zORp
 dXjZjOX6LDHhsrgH28Y7TLcPXF8RWX1hTqOeC0ZTBEqzwp9NpcUBgrqHEmPPVQiGTcJJ7FeHe
 yRZX5eeh32e3eOWomJB9XYOV8I245UCdc1CLV5alOhWe48s+BF2VP2dyt9y/Qzd82tYNb4tAR
 7C7hfB+8VUO5LSQldv9JkibjXU6SB8jR8oSgTu6lhrKfJlyzbvs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The hardware simply does not support this in DBDC mode.  Remove it from
the HE capabilities.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 47 ++++++++++++-------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index f2707115b5f3..e257b031400f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -737,8 +737,12 @@ mt7915_set_stream_he_txbf_caps(struct mt7915_phy *phy,
 	u8 c, sts_160 = sts;
 
 	/* Can do 1/2 of STS in 160Mhz mode for mt7915 */
-	if (is_mt7915(&dev->mt76) && !dev->dbdc_support)
-		sts_160 /= 2;
+	if (is_mt7915(&dev->mt76)) {
+		if (!dev->dbdc_support)
+			sts_160 /= 2;
+		else
+			sts_160 = 0;
+	}
 
 #ifdef CONFIG_MAC80211_MESH
 	if (vif == NL80211_IFTYPE_MESH_POINT)
@@ -748,8 +752,9 @@ mt7915_set_stream_he_txbf_caps(struct mt7915_phy *phy,
 	elem->phy_cap_info[3] &= ~IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
 	elem->phy_cap_info[4] &= ~IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
 
-	c = IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK |
-	    IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK;
+	c = IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK;
+	if (sts_160)
+		c |= IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK;
 	elem->phy_cap_info[5] &= ~c;
 
 	c = IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
@@ -765,8 +770,9 @@ mt7915_set_stream_he_txbf_caps(struct mt7915_phy *phy,
 	elem->phy_cap_info[2] |= c;
 
 	c = IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
-	    IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4 |
-	    IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_4;
+	    IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4;
+	if (sts_160)
+		c |= IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_4;
 	elem->phy_cap_info[4] |= c;
 
 	/* do not support NG16 due to spec D4.0 changes subcarrier idx */
@@ -791,12 +797,13 @@ mt7915_set_stream_he_txbf_caps(struct mt7915_phy *phy,
 	elem->phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
 
 	/* num_snd_dim
-	 * for mt7915, max supported sts is 2 for bw > 80MHz
+	 * for mt7915, max supported sts is 2 for bw > 80MHz and 0 if dbdc
 	 */
 	c = FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
-		       sts - 1) |
-	    FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK,
-		       sts_160 - 1);
+		       sts - 1);
+	if (sts_160)
+		c |= FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK,
+				sts_160 - 1);
 	elem->phy_cap_info[5] |= c;
 
 	c = IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
@@ -841,11 +848,14 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 	u16 mcs_map_160 = 0;
 	u8 nss_160;
 
-	/* Can do 1/2 of NSS streams in 160Mhz mode for mt7915 */
-	if (is_mt7915(&dev->mt76) && !dev->dbdc_support)
+	if (!is_mt7915(&dev->mt76))
+		nss_160 = nss;
+	else if (!dev->dbdc_support)
+		/* Can do 1/2 of NSS streams in 160Mhz mode for mt7915 */
 		nss_160 = nss / 2;
 	else
-		nss_160 = nss;
+		/* Can't do 160MHz with mt7915 dbdc */
+		nss_160 = 0;
 
 	for (i = 0; i < 8; i++) {
 		if (i < nss)
@@ -891,11 +901,14 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 		if (band == NL80211_BAND_2GHZ)
 			he_cap_elem->phy_cap_info[0] =
 				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
-		else
+		else if (nss_160)
 			he_cap_elem->phy_cap_info[0] =
 				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
 				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
 				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+		else
+			he_cap_elem->phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
 
 		he_cap_elem->phy_cap_info[1] =
 			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
@@ -949,9 +962,11 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 				IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI;
 			he_cap_elem->phy_cap_info[8] |=
 				IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
-				IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
-				IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU |
 				IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_484;
+			if (nss_160)
+				he_cap_elem->phy_cap_info[8] |=
+					IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
+					IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU;
 			he_cap_elem->phy_cap_info[9] |=
 				IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
 				IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK |
-- 
2.38.1

