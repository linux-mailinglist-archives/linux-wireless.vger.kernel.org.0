Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDB465B6F3
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jan 2023 20:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjABT3V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Jan 2023 14:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjABT3U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Jan 2023 14:29:20 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECD25FC1
        for <linux-wireless@vger.kernel.org>; Mon,  2 Jan 2023 11:29:15 -0800 (PST)
X-UUID: 565d79108213456d8e6acda3f989b5ea-20230103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=LP3o0mVUAZOwHMUbAgWNDRh2YEiswqrsJnXdoEv8+OE=;
        b=g16/pF0O9yknPg/RX4BmvnpMBOrqFiLvAzeIEyWCo/1HXm2Pu9xsp5KHySQYGANlfwYmImaisuwE2N4CA4VqivMySW/We9ewL0peTeHiYF5XbfVaGcXhSxy+y+OhvMYXpYIIkTJ8W6m+oxslX7AOjvX/U8X2Emh3Rl70/nAg6fI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:26bb293d-cef5-4586-ba5b-d7a2bf6dd6d4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:09771b1,CLOUDID:ea0d048b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 565d79108213456d8e6acda3f989b5ea-20230103
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 922237856; Tue, 03 Jan 2023 03:29:11 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 3 Jan 2023 03:29:10 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 3 Jan 2023 03:29:10 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <kuabhs@google.com>, <druth@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] wifi: mt76: mt7921: enable p2p support
Date:   Tue, 3 Jan 2023 03:29:08 +0800
Message-ID: <50e02e7d0c0bfe083596ad5b71bfa6297a8b4110.1672687461.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce p2p-go/p2p-client support to mt7921 driver

CONNECTION_P2P_GC/GO is not supported with the current firmware
so we added mt76_dev to mt76_connac_mcu_sta_basic_tlv signature to
use CONNECTION_INFRA_STA/AP instead for p2p-client and p2p-go
respectively to make it work.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/init.c     | 10 +++++++---
 5 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 83f30305414d..98a60df11702 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -861,7 +861,8 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		else
 			mvif->sta_added = true;
 	}
-	mt76_connac_mcu_sta_basic_tlv(sskb, vif, sta, enable, new_entry);
+	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, sskb, vif, sta, enable,
+				      new_entry);
 	if (enable && sta)
 		mt76_connac_mcu_sta_tlv(phy->mt76, sskb, sta, vif, 0,
 					MT76_STA_INFO_STATE_ASSOC);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 5a047e630860..d28ff322a6db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -363,7 +363,7 @@ void mt76_connac_mcu_bss_omac_tlv(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_bss_omac_tlv);
 
-void mt76_connac_mcu_sta_basic_tlv(struct sk_buff *skb,
+void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
 				   bool enable, bool newly)
@@ -394,7 +394,7 @@ void mt76_connac_mcu_sta_basic_tlv(struct sk_buff *skb,
 	switch (vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_AP:
-		if (vif->p2p)
+		if (vif->p2p && !is_mt7921(dev))
 			conn_type = CONNECTION_P2P_GC;
 		else
 			conn_type = CONNECTION_INFRA_STA;
@@ -402,7 +402,7 @@ void mt76_connac_mcu_sta_basic_tlv(struct sk_buff *skb,
 		basic->aid = cpu_to_le16(sta->aid);
 		break;
 	case NL80211_IFTYPE_STATION:
-		if (vif->p2p)
+		if (vif->p2p && !is_mt7921(dev))
 			conn_type = CONNECTION_P2P_GO;
 		else
 			conn_type = CONNECTION_INFRA_AP;
@@ -1029,7 +1029,7 @@ int mt76_connac_mcu_sta_cmd(struct mt76_phy *phy,
 		return PTR_ERR(skb);
 
 	if (info->sta || !info->offload_fw)
-		mt76_connac_mcu_sta_basic_tlv(skb, info->vif, info->sta,
+		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif, info->sta,
 					      info->enable, info->newly);
 	if (info->sta && info->enable)
 		mt76_connac_mcu_sta_tlv(phy, skb, info->sta,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index f1e942b9a887..8bf8a1a8f5e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1771,7 +1771,7 @@ mt76_connac_mcu_add_tlv(struct sk_buff *skb, int tag, int len)
 
 int mt76_connac_mcu_set_channel_domain(struct mt76_phy *phy);
 int mt76_connac_mcu_set_vif_ps(struct mt76_dev *dev, struct ieee80211_vif *vif);
-void mt76_connac_mcu_sta_basic_tlv(struct sk_buff *skb,
+void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta, bool enable,
 				   bool newly);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 37a3c1f082d9..051ffb38342c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1657,8 +1657,8 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	/* starec basic */
-	mt76_connac_mcu_sta_basic_tlv(skb, vif, sta, enable,
-			!rcu_access_pointer(dev->mt76.wcid[msta->wcid.idx]));
+	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, sta, enable,
+				      !rcu_access_pointer(dev->mt76.wcid[msta->wcid.idx]));
 	if (!enable)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index d4b681d7e1d2..25eca0d40f2d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -32,11 +32,13 @@ static const struct ieee80211_iface_combination if_comb[] = {
 static const struct ieee80211_iface_limit if_limits_chanctx[] = {
 	{
 		.max = 2,
-		.types = BIT(NL80211_IFTYPE_STATION),
+		.types = BIT(NL80211_IFTYPE_STATION) |
+			 BIT(NL80211_IFTYPE_P2P_CLIENT)
 	},
 	{
 		.max = 1,
-		.types = BIT(NL80211_IFTYPE_AP),
+		.types = BIT(NL80211_IFTYPE_AP) |
+			 BIT(NL80211_IFTYPE_P2P_GO)
 	}
 };
 
@@ -100,7 +102,9 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->flags &= ~(WIPHY_FLAG_IBSS_RSN | WIPHY_FLAG_4ADDR_AP |
 			  WIPHY_FLAG_4ADDR_STATION);
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
-				 BIT(NL80211_IFTYPE_AP);
+				 BIT(NL80211_IFTYPE_AP) |
+				 BIT(NL80211_IFTYPE_P2P_CLIENT) |
+				 BIT(NL80211_IFTYPE_P2P_GO);
 	wiphy->max_remain_on_channel_duration = 5000;
 	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
 	wiphy->max_scan_ssids = 4;
-- 
2.25.1

