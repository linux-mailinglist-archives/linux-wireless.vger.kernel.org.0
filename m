Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C6A6E15C9
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 22:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjDMUXw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 16:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjDMUXt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 16:23:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FB283D8
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 13:23:44 -0700 (PDT)
X-UUID: 129e6e56da3911edb6b9f13eb10bd0fe-20230414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=w+jYxlWLKP+6cT0NR0s1TTYwo0qhKGAmS2naxZhwJ+I=;
        b=MvjqyR/vejn+A6dCSon5wNbt6+at12NNMUGKLGkXd8/BfdaFE0EQOMwOkcO//RwAXLdl8LHwgPYJwWw0ITp3YOXnFp9h6uU47/ULn2vLS40Ml2H/nfuvvJ7FGM6Qm0CgXnEDD8cGriQxKg0SCDGKnvlSIjweKiHGzVOdcEJNq00=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:26d03454-d049-40dc-a270-6abe75b37b73,IP:0,U
        RL:0,TC:0,Content:32,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:32
X-CID-META: VersionHash:120426c,CLOUDID:442fe2ea-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 129e6e56da3911edb6b9f13eb10bd0fe-20230414
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1852977252; Fri, 14 Apr 2023 04:23:37 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 14 Apr 2023 04:23:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 14 Apr 2023 04:23:36 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/5] wifi: mt76: connac: add nss calculation into mt76_connac2_mac_tx_rate_val()
Date:   Fri, 14 Apr 2023 04:23:30 +0800
Message-ID: <a65dc747072bfed9004ff643c37964cc53332063.1681416097.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <f5d216bcd79cc444b7f7039dd3898e08aff70286.1681416097.git.ryder.lee@mediatek.com>
References: <f5d216bcd79cc444b7f7039dd3898e08aff70286.1681416097.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Take nss calculation into account since this function always wrongly
returns 0.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 43 ++++++++++++-------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 82aac0a04655..52f11a314465 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -267,11 +267,29 @@ int mt76_connac_init_tx_queues(struct mt76_phy *phy, int idx, int n_desc,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_init_tx_queues);
 
+#define __bitrate_mask_check(_mcs, _mode)				\
+({									\
+	u8 i = 0;							\
+	for (nss = 0; i < ARRAY_SIZE(mask->control[band]._mcs); i++) {	\
+		if (!mask->control[band]._mcs[i])			\
+			continue;					\
+		if (hweight16(mask->control[band]._mcs[i]) == 1) {	\
+			mode = MT_PHY_TYPE_##_mode;			\
+			rateidx = ffs(mask->control[band]._mcs[i]) - 1;	\
+			if (mode == MT_PHY_TYPE_HT)			\
+				rateidx += 8 * i;			\
+			else						\
+				nss = i + 1;				\
+			goto out;					\
+		}							\
+	}								\
+})
+
 u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
 				 struct ieee80211_vif *vif,
 				 bool beacon, bool mcast)
 {
-	u8 mode = 0, band = mphy->chandef.chan->band;
+	u8 nss = 0, mode = 0, band = mphy->chandef.chan->band;
 	int rateidx = 0, mcast_rate;
 
 	if (!vif)
@@ -286,19 +304,12 @@ u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
 		struct cfg80211_bitrate_mask *mask;
 
 		mask = &vif->bss_conf.beacon_tx_rate;
-		if (hweight16(mask->control[band].he_mcs[0]) == 1) {
-			rateidx = ffs(mask->control[band].he_mcs[0]) - 1;
-			mode = MT_PHY_TYPE_HE_SU;
-			goto out;
-		} else if (hweight16(mask->control[band].vht_mcs[0]) == 1) {
-			rateidx = ffs(mask->control[band].vht_mcs[0]) - 1;
-			mode = MT_PHY_TYPE_VHT;
-			goto out;
-		} else if (hweight8(mask->control[band].ht_mcs[0]) == 1) {
-			rateidx = ffs(mask->control[band].ht_mcs[0]) - 1;
-			mode = MT_PHY_TYPE_HT;
-			goto out;
-		} else if (hweight32(mask->control[band].legacy) == 1) {
+
+		__bitrate_mask_check(he_mcs, HE_SU);
+		__bitrate_mask_check(vht_mcs, VHT);
+		__bitrate_mask_check(ht_mcs, HT);
+
+		if (hweight32(mask->control[band].legacy) == 1) {
 			rateidx = ffs(mask->control[band].legacy) - 1;
 			goto legacy;
 		}
@@ -314,9 +325,9 @@ u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
 	rateidx = mt76_calculate_default_rate(mphy, rateidx);
 	mode = rateidx >> 8;
 	rateidx &= GENMASK(7, 0);
-
 out:
-	return FIELD_PREP(MT_TX_RATE_IDX, rateidx) |
+	return FIELD_PREP(MT_TX_RATE_NSS, nss) |
+	       FIELD_PREP(MT_TX_RATE_IDX, rateidx) |
 	       FIELD_PREP(MT_TX_RATE_MODE, mode);
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_mac_tx_rate_val);
-- 
2.18.0

