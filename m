Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6866E15C8
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 22:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjDMUXx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 16:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDMUXu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 16:23:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0666D9027
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 13:23:46 -0700 (PDT)
X-UUID: 138573b4da3911edb6b9f13eb10bd0fe-20230414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ek9bJz1ZSnIThNsYmr0QynsVxNMqKVnoCHk6J9pG/34=;
        b=pwIInS4k2VfQIIag2/vm6hS6QkWkcognEVxYNQk1tctarxujG5H2Kd27ekKBEzPVWwnhyqhy0/hErAxL6kmWptU7cFg91np1QUs+B+rN8lMGN1odtBNWmFdtWnHbh7+OwJphoua42iuFICZ0p0GlxIvunzsowY0NumaLyF00wfI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:bfb7ee56-9f5e-4ba1-8301-dab542979820,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:bfb7ee56-9f5e-4ba1-8301-dab542979820,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:238efb83-cd9c-45f5-8134-710979e3df0e,B
        ulkID:2304140423413942ZZ4Q,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 138573b4da3911edb6b9f13eb10bd0fe-20230414
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 728958589; Fri, 14 Apr 2023 04:23:39 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
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
Subject: [PATCH 4/5] wifi: mt76: mt7996: enable BSS_CHANGED_MCAST_RATE support
Date:   Fri, 14 Apr 2023 04:23:32 +0800
Message-ID: <2c2ed63825299f424e204fbf3ccc9ab16fd90b64.1681416097.git.ryder.lee@mediatek.com>
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

Similar to BSS_CHANGED_BASIC_RATES, this enables mcast rate
configuration through fixed rate tables.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Change-Id: Ifc305e8c7de9a7df4ad5f856e2097d721a886aaa
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 12 +++++++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  1 +
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 048a4ebe2069..36e50b12e5eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1075,8 +1075,14 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 		mt7996_mac_write_txwi_80211(dev, txwi, skb, key);
 
 	if (txwi[1] & cpu_to_le32(MT_TXD1_FIXED_RATE)) {
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+		bool mcast = ieee80211_is_data(hdr->frame_control) &&
+			     is_multicast_ether_addr(hdr->addr1);
 		u8 idx = mvif->basic_rates_idx;
 
+		if (mcast && mvif->mcast_rates_idx)
+			idx = mvif->mcast_rates_idx;
+
 		txwi[6] |= FIELD_PREP(MT_TXD6_TX_RATE, idx);
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index e707d0a1aff5..231905fb7ea1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -512,14 +512,15 @@ mt7996_update_bss_color(struct ieee80211_hw *hw,
 }
 
 static u8
-mt7996_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+mt7996_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       bool mcast)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt76_phy *mphy = hw->priv;
 	u16 rate;
 	u8 i, idx;
 
-	rate = mt76_connac2_mac_tx_rate_val(mphy, vif, false, false);
+	rate = mt76_connac2_mac_tx_rate_val(mphy, vif, false, mcast);
 
 	idx = FIELD_GET(MT_TX_RATE_IDX, rate);
 	for (i = 0; i < ARRAY_SIZE(mt76_rates); i++)
@@ -566,8 +567,13 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 		}
 	}
 
+	if (changed & BSS_CHANGED_MCAST_RATE)
+		mvif->mcast_rates_idx =
+			mt7996_get_rates_table(hw, vif, true);
+
 	if (changed & BSS_CHANGED_BASIC_RATES)
-		mvif->basic_rates_idx = mt7996_get_rates_table(hw, vif);
+		mvif->basic_rates_idx =
+			mt7996_get_rates_table(hw, vif, false);
 
 	if (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon) {
 		mt7996_mcu_add_bss_info(phy, vif, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 95d443f427ae..cb869dff8b5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -604,7 +604,8 @@ mt7996_mcu_bss_bmc_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	enum nl80211_band band = chandef->chan->band;
 	struct tlv *tlv;
-	u8 idx = mvif->basic_rates_idx;
+	u8 idx = mvif->mcast_rates_idx ?
+		 mvif->mcast_rates_idx : mvif->basic_rates_idx;
 
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_RATE, sizeof(*bmc));
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 4fe17b125b00..52138aefc6be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -141,6 +141,7 @@ struct mt7996_vif {
 	struct cfg80211_bitrate_mask bitrate_mask;
 
 	u8 basic_rates_idx;
+	u8 mcast_rates_idx;
 };
 
 /* per-phy stats.  */
-- 
2.18.0

