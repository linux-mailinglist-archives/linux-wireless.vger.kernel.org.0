Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03A76A715D
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 17:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjCAQia (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 11:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCAQi3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 11:38:29 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82033D937
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 08:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FTwWFaIixScYA6gzXMUcvREL3x2gjXj76TsQM9Jwqps=; b=hnwGC3FOabdPSuV/UeC6WjPbV0
        9j/O7id4Mhsvw2lcfXRN/ocDA/bTrxEVxpe8HilwrtMaRWZQnz2eHLwB1gvQyfjPTr4LkK2ownMCv
        I9I7em+zc1KkivXoYUhu+vcFhjYBcGLGXfvoEotZkBV4MG9bE0LetJkdHqPWLHCQXXvU=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pXPSY-00DG77-CX; Wed, 01 Mar 2023 17:37:42 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org
Subject: [PATCH 6.3] wifi: mt76: mt7915: add back 160MHz channel width support for MT7915
Date:   Wed,  1 Mar 2023 17:37:39 +0100
Message-Id: <20230301163739.52314-1-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A number of users reported that this support was working fine before
it got removed. Add it back, but leave out the unsupported 80+80 mode.

Fixes: ac922bd60ace ("wifi: mt76: mt7915: remove BW160 and BW80+80 support")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 40 ++++++++++++++-----
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index a7ff78b8697c..71ccefd39cb2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -384,7 +384,6 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
-	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
 
 	hw->max_tx_fragments = 4;
 
@@ -397,6 +396,9 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 	}
 
 	if (phy->mt76->cap.has_5ghz) {
+		struct ieee80211_sta_vht_cap *vht_cap;
+
+		vht_cap = &phy->mt76->sband_5g.sband.vht_cap;
 		phy->mt76->sband_5g.sband.ht_cap.cap |=
 			IEEE80211_HT_CAP_LDPC_CODING |
 			IEEE80211_HT_CAP_MAX_AMSDU;
@@ -404,19 +406,28 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 			IEEE80211_HT_MPDU_DENSITY_4;
 
 		if (is_mt7915(&dev->mt76)) {
-			phy->mt76->sband_5g.sband.vht_cap.cap |=
+			vht_cap->cap |=
 				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991 |
 				IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
+
+			if (!dev->dbdc_support)
+				vht_cap->cap |=
+					IEEE80211_VHT_CAP_SHORT_GI_160 |
+					IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
+					FIELD_PREP(IEEE80211_VHT_CAP_EXT_NSS_BW_MASK, 1);
 		} else {
-			phy->mt76->sband_5g.sband.vht_cap.cap |=
+			vht_cap->cap |=
 				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
 				IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
 
 			/* mt7916 dbdc with 2g 2x2 bw40 and 5g 2x2 bw160c */
-			phy->mt76->sband_5g.sband.vht_cap.cap |=
+			vht_cap->cap |=
 				IEEE80211_VHT_CAP_SHORT_GI_160 |
 				IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ;
 		}
+
+		if (!is_mt7915(&dev->mt76) || !dev->dbdc_support)
+			ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
 	}
 
 	mt76_set_stream_caps(phy->mt76, true);
@@ -842,9 +853,13 @@ mt7915_set_stream_he_txbf_caps(struct mt7915_phy *phy,
 	int sts = hweight8(phy->mt76->chainmask);
 	u8 c, sts_160 = sts;
 
-	/* mt7915 doesn't support bw160 */
-	if (is_mt7915(&dev->mt76))
-		sts_160 = 0;
+	/* Can do 1/2 of STS in 160Mhz mode for mt7915 */
+	if (is_mt7915(&dev->mt76)) {
+		if (!dev->dbdc_support)
+			sts_160 /= 2;
+		else
+			sts_160 = 0;
+	}
 
 #ifdef CONFIG_MAC80211_MESH
 	if (vif == NL80211_IFTYPE_MESH_POINT)
@@ -945,10 +960,15 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 	int i, idx = 0, nss = hweight8(phy->mt76->antenna_mask);
 	u16 mcs_map = 0;
 	u16 mcs_map_160 = 0;
-	u8 nss_160 = nss;
+	u8 nss_160;
 
-	/* Can't do 160MHz with mt7915 */
-	if (is_mt7915(&dev->mt76))
+	if (!is_mt7915(&dev->mt76))
+		nss_160 = nss;
+	else if (!dev->dbdc_support)
+		/* Can do 1/2 of NSS streams in 160Mhz mode for mt7915 */
+		nss_160 = nss / 2;
+	else
+		/* Can't do 160MHz with mt7915 dbdc */
 		nss_160 = 0;
 
 	for (i = 0; i < 8; i++) {
-- 
2.39.0

