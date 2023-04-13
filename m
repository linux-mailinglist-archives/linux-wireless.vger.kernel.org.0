Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BC96E15C7
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 22:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjDMUXv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 16:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjDMUXt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 16:23:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88EB7D83
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 13:23:43 -0700 (PDT)
X-UUID: 13fb3ca2da3911eda9a90f0bb45854f4-20230414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RoQDrbZbiJ+ud2Y6nNDdvTwnWDSsCpDF9H94JnMmqik=;
        b=lelAQBCU30mfYRPHlQN4IgrNX/eipsz1fsc/FghvQ9ftml8Ii3L5FaMxyeNpd+klbAV9YK0VR/W+ZZnOd1Mqk5xHkILYWFV28jNpgN6lrB4zTdRv/RA9ED8K4Z/CfCBfu0BbIHxyjhGcJmj6wAtuMlKvmypOQ+K5Yg7uh9H2js0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:8ca2f9f1-803f-49d7-8d0c-7fef685c2b25,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:8ca2f9f1-803f-49d7-8d0c-7fef685c2b25,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:1a8efb83-cd9c-45f5-8134-710979e3df0e,B
        ulkID:230414042340FIUHT9PD,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 13fb3ca2da3911eda9a90f0bb45854f4-20230414
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1934928572; Fri, 14 Apr 2023 04:23:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 14 Apr 2023 04:23:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 14 Apr 2023 04:23:38 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 5/5] wifi: mt76: mt7996: enable configured beacon tx rate
Date:   Fri, 14 Apr 2023 04:23:33 +0800
Message-ID: <cbc376af69200c1d7dac1483577cd07e8af09245.1681416097.git.ryder.lee@mediatek.com>
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

The user is allowed to change beacon tx rate (HT/VHT/HE) from hostapd.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  2 ++
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 26 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  2 ++
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 36e50b12e5eb..dfd4793f5a26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1082,6 +1082,8 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 
 		if (mcast && mvif->mcast_rates_idx)
 			idx = mvif->mcast_rates_idx;
+		else if (beacon && mvif->beacon_rates_idx)
+			idx = mvif->beacon_rates_idx;
 
 		txwi[6] |= FIELD_PREP(MT_TXD6_TX_RATE, idx);
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 231905fb7ea1..d86e43a84497 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -513,14 +513,24 @@ mt7996_update_bss_color(struct ieee80211_hw *hw,
 
 static u8
 mt7996_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		       bool mcast)
+		       bool beacon, bool mcast)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt76_phy *mphy = hw->priv;
 	u16 rate;
-	u8 i, idx;
+	u8 i, idx, ht;
 
-	rate = mt76_connac2_mac_tx_rate_val(mphy, vif, false, mcast);
+	rate = mt76_connac2_mac_tx_rate_val(mphy, vif, beacon, mcast);
+	ht = FIELD_GET(MT_TX_RATE_MODE, rate) > MT_PHY_TYPE_OFDM;
+
+	if (beacon && ht) {
+		struct mt7996_dev *dev = mt7996_hw_dev(hw);
+
+		/* must odd index */
+		idx = MT7996_BEACON_RATES_TBL + 2 * (mvif->mt76.idx % 20);
+		mt7996_mac_set_fixed_rate_table(dev, idx, rate);
+		return idx;
+	}
 
 	idx = FIELD_GET(MT_TX_RATE_IDX, rate);
 	for (i = 0; i < ARRAY_SIZE(mt76_rates); i++)
@@ -569,11 +579,11 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_MCAST_RATE)
 		mvif->mcast_rates_idx =
-			mt7996_get_rates_table(hw, vif, true);
+			mt7996_get_rates_table(hw, vif, false, true);
 
 	if (changed & BSS_CHANGED_BASIC_RATES)
 		mvif->basic_rates_idx =
-			mt7996_get_rates_table(hw, vif, false);
+			mt7996_get_rates_table(hw, vif, false, false);
 
 	if (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon) {
 		mt7996_mcu_add_bss_info(phy, vif, true);
@@ -591,8 +601,12 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 		mt7996_update_bss_color(hw, vif, &info->he_bss_color);
 
 	if (changed & (BSS_CHANGED_BEACON |
-		       BSS_CHANGED_BEACON_ENABLED))
+		       BSS_CHANGED_BEACON_ENABLED)) {
+		mvif->beacon_rates_idx =
+			mt7996_get_rates_table(hw, vif, true, false);
+
 		mt7996_mcu_add_beacon(hw, vif, info->enable_beacon);
+	}
 
 	if (changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP ||
 	    changed & BSS_CHANGED_FILS_DISCOVERY)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 52138aefc6be..2c226d9c50de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -45,6 +45,7 @@
 
 /* NOTE: used to map mt76_rates. idx may change if firmware expands table */
 #define MT7996_BASIC_RATES_TBL		11
+#define MT7996_BEACON_RATES_TBL		25
 
 struct mt7996_vif;
 struct mt7996_sta;
@@ -142,6 +143,7 @@ struct mt7996_vif {
 
 	u8 basic_rates_idx;
 	u8 mcast_rates_idx;
+	u8 beacon_rates_idx;
 };
 
 /* per-phy stats.  */
-- 
2.18.0

