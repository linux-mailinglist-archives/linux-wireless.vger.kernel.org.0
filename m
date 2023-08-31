Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C29078E6B3
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 08:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346102AbjHaGlv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Aug 2023 02:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242754AbjHaGlu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Aug 2023 02:41:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F95E0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 23:41:46 -0700 (PDT)
X-UUID: ecafd05847c611eeb20a276fd37b9834-20230831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WFT99+z2/vpIbfLokQbVWLJxcppLvQbX9e6U3+V5HfE=;
        b=ZXsnlrqADyD0e0kxjuLINcr2VbTArygs2Dc8wtG15yN55h2gdUPdpCQ5sbOnoURITm8a6gh7XbawX9teyZ+6haeWb19f77kKSL/sRtOmAUjWQor8Ze7E1GRB9dK0hSmy4v9Eqja7ij0nm8ph7cUwMcfPkt7pZjweObX/KsEsI6k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:8c1ced05-39b3-44f8-822b-545c448b08c6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:d5e3f31f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ecafd05847c611eeb20a276fd37b9834-20230831
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 484238242; Thu, 31 Aug 2023 14:23:39 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 31 Aug 2023 14:23:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 31 Aug 2023 14:23:38 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 8/9] wifi: mt76: mt7915: update mpdu density capability
Date:   Thu, 31 Aug 2023 14:22:20 +0800
Message-ID: <20230831062221.20027-8-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230831062221.20027-1-shayne.chen@mediatek.com>
References: <20230831062221.20027-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Set mpdu density to 2 usec for non-mt7915 Wi-Fi 6 generation chipsets
to align to the hardware capability which improves the throughput.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 78552f10b377..08989e00facb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -392,8 +392,12 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 		phy->mt76->sband_2g.sband.ht_cap.cap |=
 			IEEE80211_HT_CAP_LDPC_CODING |
 			IEEE80211_HT_CAP_MAX_AMSDU;
-		phy->mt76->sband_2g.sband.ht_cap.ampdu_density =
-			IEEE80211_HT_MPDU_DENSITY_4;
+		if (is_mt7915(&dev->mt76))
+			phy->mt76->sband_2g.sband.ht_cap.ampdu_density =
+				IEEE80211_HT_MPDU_DENSITY_4;
+		else
+			phy->mt76->sband_2g.sband.ht_cap.ampdu_density =
+				IEEE80211_HT_MPDU_DENSITY_2;
 	}
 
 	if (phy->mt76->cap.has_5ghz) {
@@ -403,10 +407,11 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 		phy->mt76->sband_5g.sband.ht_cap.cap |=
 			IEEE80211_HT_CAP_LDPC_CODING |
 			IEEE80211_HT_CAP_MAX_AMSDU;
-		phy->mt76->sband_5g.sband.ht_cap.ampdu_density =
-			IEEE80211_HT_MPDU_DENSITY_4;
 
 		if (is_mt7915(&dev->mt76)) {
+			phy->mt76->sband_5g.sband.ht_cap.ampdu_density =
+				IEEE80211_HT_MPDU_DENSITY_4;
+
 			vht_cap->cap |=
 				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991 |
 				IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
@@ -416,6 +421,9 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 					IEEE80211_VHT_CAP_SHORT_GI_160 |
 					FIELD_PREP(IEEE80211_VHT_CAP_EXT_NSS_BW_MASK, 1);
 		} else {
+			phy->mt76->sband_5g.sband.ht_cap.ampdu_density =
+				IEEE80211_HT_MPDU_DENSITY_2;
+
 			vht_cap->cap |=
 				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
 				IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
-- 
2.39.2

