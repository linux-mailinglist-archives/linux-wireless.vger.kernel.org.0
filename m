Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DDB7F0AF8
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 04:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjKTD2u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Nov 2023 22:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjKTD2s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Nov 2023 22:28:48 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED559F2
        for <linux-wireless@vger.kernel.org>; Sun, 19 Nov 2023 19:28:37 -0800 (PST)
X-UUID: df8a2eaa875411ee8051498923ad61e6-20231120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OV8s5wCvnPXepXNDZfhDStlrcZJfc8V8KOxPfWMOlBQ=;
        b=eFgw/7N9l025cDmeEwlWzrRxRzdbM8I94QQ9crOKiJ2EBelrqnSvVKW4dmXVCn4Dhep7Y1gKt0qK9WsgZi2PZO+pKU/4wkWLL/EbgBSe1lWxk/TaILPeUYZV8Cvs74HRFvSpLDf2T18YMQuvyJ/2wNglie1AVr/DTmu8gQsKzyo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:02d9eb68-8723-4be8-bbc9-f0e6d716d988,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:290d9495-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: df8a2eaa875411ee8051498923ad61e6-20231120
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <mingyen.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 454547975; Mon, 20 Nov 2023 11:28:29 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 20 Nov 2023 11:28:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 20 Nov 2023 11:28:28 +0800
From:   Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo@kernel.org>
CC:     <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>,
        <Ryder.Lee@mediatek.com>, <Shayne.Chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH 3/3] wifi: mt76: mt7921: fix wrong 6Ghz power type
Date:   Mon, 20 Nov 2023 11:27:50 +0800
Message-ID: <20231120032750.19747-4-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231120032750.19747-1-mingyen.hsieh@mediatek.com>
References: <20231120032750.19747-1-mingyen.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

To avoid using incorrect 6g power settings after disconnection,
it should to update back to the default state when disconnected.

Fixes: 51ba0e3a15eb ("wifi: mt76: mt7921: add 6GHz power type support for clc")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 510a575a973b..0645417e0582 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -683,17 +683,45 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 }
 
 static void
-mt7921_regd_set_6ghz_power_type(struct ieee80211_vif *vif)
+mt7921_calc_vif_num(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	u32 *num = priv;
+
+	if (!priv)
+		return;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		*num += 1;
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+mt7921_regd_set_6ghz_power_type(struct ieee80211_vif *vif, bool is_add)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_phy *phy = mvif->phy;
 	struct mt792x_dev *dev = phy->dev;
+	u32 valid_vif_num = 0;
+
+	ieee80211_iterate_active_interfaces(mt76_hw(dev),
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7921_calc_vif_num, &valid_vif_num);
 
-	if (hweight64(dev->mt76.vif_mask) > 1) {
+	if (valid_vif_num > 1) {
 		phy->power_type = MT_AP_DEFAULT;
 		goto out;
 	}
 
+	if (!is_add)
+		vif->bss_conf.power_type = IEEE80211_REG_UNSET_AP;
+
 	switch (vif->bss_conf.power_type) {
 	case IEEE80211_REG_SP_AP:
 		phy->power_type = MT_AP_SP;
@@ -705,6 +733,8 @@ mt7921_regd_set_6ghz_power_type(struct ieee80211_vif *vif)
 		phy->power_type = MT_AP_LPI;
 		break;
 	case IEEE80211_REG_UNSET_AP:
+		phy->power_type = MT_AP_UNSET;
+		break;
 	default:
 		phy->power_type = MT_AP_DEFAULT;
 		break;
@@ -749,7 +779,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
-	mt7921_regd_set_6ghz_power_type(vif);
+	mt7921_regd_set_6ghz_power_type(vif, true);
 
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 
@@ -811,6 +841,8 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
+	mt7921_regd_set_6ghz_power_type(vif, false);
+
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 }
 EXPORT_SYMBOL_GPL(mt7921_mac_sta_remove);
-- 
2.18.0

