Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254354CBC30
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Mar 2022 12:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiCCLIm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Mar 2022 06:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiCCLIj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Mar 2022 06:08:39 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB797C16D
        for <linux-wireless@vger.kernel.org>; Thu,  3 Mar 2022 03:07:52 -0800 (PST)
X-UUID: 7e50b30389314d7ca44e324dfa6e6dac-20220303
X-UUID: 7e50b30389314d7ca44e324dfa6e6dac-20220303
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 485856713; Thu, 03 Mar 2022 19:07:46 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 3 Mar 2022 19:07:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Mar
 2022 19:07:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Mar 2022 19:07:44 +0800
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
Subject: [PATCH 3/3] mt76: mt7915: fix phy cap in mt7915_set_stream_he_txbf_caps()
Date:   Thu, 3 Mar 2022 19:05:35 +0800
Message-ID: <20220303110535.30640-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220303110535.30640-1-shayne.chen@mediatek.com>
References: <20220303110535.30640-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

This patch fixes performance issue of beamforming tx on
bandwidth 160MHz.

Fixes: 99ad32a4ca3a ("mt76: mt7915: add support for MT7986")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 553d1f5..94a5ea6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -727,11 +727,18 @@ void mt7915_set_stream_vht_txbf_caps(struct mt7915_phy *phy)
 }
 
 static void
-mt7915_set_stream_he_txbf_caps(struct ieee80211_sta_he_cap *he_cap,
+mt7915_set_stream_he_txbf_caps(struct mt7915_dev *dev,
+			       struct ieee80211_sta_he_cap *he_cap,
 			       int vif, int nss)
 {
 	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
-	u8 c;
+	u8 c, nss_160;
+
+	/* Can do 1/2 of NSS streams in 160Mhz mode for mt7915 */
+	if (is_mt7915(&dev->mt76) && !dev->dbdc_support)
+		nss_160 = nss / 2;
+	else
+		nss_160 = nss;
 
 #ifdef CONFIG_MAC80211_MESH
 	if (vif == NL80211_IFTYPE_MESH_POINT)
@@ -785,13 +792,21 @@ mt7915_set_stream_he_txbf_caps(struct ieee80211_sta_he_cap *he_cap,
 	/* num_snd_dim
 	 * for mt7915, max supported nss is 2 for bw > 80MHz
 	 */
-	c = (nss - 1) |
-	    IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_2;
+	c = FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
+		       nss - 1) |
+	    FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK,
+		       nss_160 - 1);
 	elem->phy_cap_info[5] |= c;
 
 	c = IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
 	    IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB;
 	elem->phy_cap_info[6] |= c;
+
+	if (!is_mt7915(&dev->mt76)) {
+		c = IEEE80211_HE_PHY_CAP7_STBC_TX_ABOVE_80MHZ |
+		    IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ;
+		elem->phy_cap_info[7] |= c;
+	}
 }
 
 static void
@@ -953,7 +968,7 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 		he_mcs->rx_mcs_80p80 = cpu_to_le16(mcs_map_160);
 		he_mcs->tx_mcs_80p80 = cpu_to_le16(mcs_map_160);
 
-		mt7915_set_stream_he_txbf_caps(he_cap, i, nss);
+		mt7915_set_stream_he_txbf_caps(dev, he_cap, i, nss);
 
 		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
 		if (he_cap_elem->phy_cap_info[6] &
-- 
2.25.1

