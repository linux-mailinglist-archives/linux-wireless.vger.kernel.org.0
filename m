Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50473594F0F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 05:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiHPDdR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Aug 2022 23:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHPDcp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Aug 2022 23:32:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F1F4DF23
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 17:04:16 -0700 (PDT)
X-UUID: 7c8f783f11d0478ba88f952dd7a9f86d-20220816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VvZ/aGQYYANfXmzflRZjI6GKLj2d2VqSK2H2iQO6QgY=;
        b=IpaDTK29mgW1FFRXnqkwmxxDMDLqUtdcVlIqz2xKJNAAXyZDRAoI/9ZJLHDeAVSHT2Lr/3JxmunAJwE3om8V2FEFgz3r/2jakLzaPB+T2H1fyLSO//eb3Ro4gK5+2cXKR1L0AsWQEHBfenKounNpDbxy4XAspMefAy5WXBUS/hI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:5fed9faa-b683-4340-a257-22f7bd55f3b1,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:5
X-CID-META: VersionHash:3d8acc9,CLOUDID:180dbe9c-da39-4e3b-a854-56c7d2111b46,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7c8f783f11d0478ba88f952dd7a9f86d-20220816
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1837622885; Tue, 16 Aug 2022 08:04:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 16 Aug 2022 08:04:10 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Aug 2022 08:04:05 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <kuabhs@google.com>,
        <druth@google.com>, <abhishekpandit@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 4/9] wifi: mt76: mt7921: add chanctx parameter to mt76_connac_mcu_uni_add_bss signature
Date:   Tue, 16 Aug 2022 08:03:42 +0800
Message-ID: <b06eb44e59fe10b3235ea4f1f5f387b99a9b69f0.1660606893.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1660606893.git.objelf@gmail.com>
References: <cover.1660606893.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add a chanctx parameter to mt76_connac_mcu_uni_add_bss signature to allow
the firmware binds the BSS into the specific channel context.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |  7 ++++---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c     | 10 ++++++----
 5 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 3dac76e6df4d..83f30305414d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1119,7 +1119,7 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 
 	return mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
-					   enable);
+					   enable, NULL);
 }
 
 static inline int
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 3e473a409790..c2ed5e755893 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1397,10 +1397,11 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_set_chctx);
 int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 				struct ieee80211_vif *vif,
 				struct mt76_wcid *wcid,
-				bool enable)
+				bool enable,
+				struct ieee80211_chanctx_conf *ctx)
 {
 	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &phy->chandef;
+	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->chandef;
 	enum nl80211_band band = chandef->chan->band;
 	struct mt76_dev *mdev = phy->dev;
 	struct {
@@ -1517,7 +1518,7 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 			return err;
 	}
 
-	return mt76_connac_mcu_uni_set_chctx(phy, mvif, NULL);
+	return mt76_connac_mcu_uni_set_chctx(phy, mvif, ctx);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_add_bss);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index bf60b00d6020..1fcc3e8c5380 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1733,7 +1733,8 @@ int mt76_connac_mcu_uni_set_chctx(struct mt76_phy *phy,
 int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 				struct ieee80211_vif *vif,
 				struct mt76_wcid *wcid,
-				bool enable);
+				bool enable,
+				struct ieee80211_chanctx_conf *ctx);
 int mt76_connac_mcu_sta_cmd(struct mt76_phy *phy,
 			    struct mt76_sta_cmd_info *info);
 void mt76_connac_mcu_beacon_loss_iter(void *priv, u8 *mac,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 7b2d1bc8aded..5be7972ba6f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -745,7 +745,7 @@ mt7921_vif_connect_iter(void *priv, u8 *mac,
 
 	if (vif->type == NL80211_IFTYPE_AP) {
 		mt76_connac_mcu_uni_add_bss(dev->phy.mt76, vif, &mvif->sta.wcid,
-					    true);
+					    true, NULL);
 		mt7921_mcu_sta_update(dev, NULL, vif, true,
 				      MT76_STA_INFO_STATE_NONE);
 		mt7921_mcu_uni_add_beacon_offload(dev, hw, vif, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 7a4a3ed1817e..b280f184244f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -748,7 +748,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
-					    true);
+					    true, NULL);
 
 	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -779,7 +779,8 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		ewma_rssi_init(&mvif->rssi);
 		if (!sta->tdls)
 			mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
-						    &mvif->sta.wcid, false);
+						    &mvif->sta.wcid, false,
+						    NULL);
 	}
 
 	spin_lock_bh(&dev->sta_poll_lock);
@@ -1529,7 +1530,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt7921_mutex_acquire(dev);
 
 	err = mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
-					  true);
+					  true, NULL);
 	if (err)
 		goto failed;
 
@@ -1560,7 +1561,8 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (err)
 		goto failed;
 
-	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, false);
+	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, false,
+				    NULL);
 
 failed:
 	mt7921_mutex_release(dev);
-- 
2.25.1

