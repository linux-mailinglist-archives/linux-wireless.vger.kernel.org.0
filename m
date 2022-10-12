Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA71E5FBE9D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 02:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJLAQj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 20:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJLAQh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 20:16:37 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD0A2BE3B
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 17:16:29 -0700 (PDT)
X-UUID: 166e1b330e7f4059ac73151a75fe78e2-20221012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5TvfMAlcOhTEuPMwksbIJp8PJAyLBIEodner5gvucXc=;
        b=jrjkrQc7Ddj5lEC2YGH+Xi6za0m/bNCeZhu0SG/qGW7qPu1pczdTIvZWG3doN5VzINZbuUnm2h+U3Ruz9lYK6R3TwZL3JCvQIwFBcRxSdCGgQwtzR7/iwzUcLLaUUYLJGtfBtjy5dIsXNoP7/a93k12CGP9pZ0aiy/Yc6yztOoc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:addfe02e-8709-4372-b3c4-d63921d7057a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:addfe02e-8709-4372-b3c4-d63921d7057a,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:1f019ce1-2948-402a-a6e4-b5d31fe11eb7,B
        ulkID:221012081627PUVMOWF2,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:n
        il,COL:0
X-UUID: 166e1b330e7f4059ac73151a75fe78e2-20221012
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 353111499; Wed, 12 Oct 2022 08:16:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 12 Oct 2022 08:16:25 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 12 Oct 2022 08:16:25 +0800
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
Subject: [PATCH v2 2/7] wifi: mt76: mt7921: add chanctx parameter to mt76_connac_mcu_uni_add_bss signature
Date:   Wed, 12 Oct 2022 08:16:16 +0800
Message-ID: <4b07e80768cdbe5a1c6e067500f84489f3995a1d.1665533390.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <8d784dba38cfb2183af2e4d9fc822a27ef34dcd2.1665533390.git.objelf@gmail.com>
References: <8d784dba38cfb2183af2e4d9fc822a27ef34dcd2.1665533390.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
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
index 4b12d65dc076..fffdb6976e52 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1398,10 +1398,11 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_set_chctx);
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
@@ -1518,7 +1519,7 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 			return err;
 	}
 
-	return mt76_connac_mcu_uni_set_chctx(phy, mvif, NULL);
+	return mt76_connac_mcu_uni_set_chctx(phy, mvif, ctx);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_add_bss);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index b7e29b177a6c..bc1c47daa81a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1742,7 +1742,8 @@ int mt76_connac_mcu_uni_set_chctx(struct mt76_phy *phy,
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
index 6860468ed191..2cf709a80b5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -866,7 +866,7 @@ mt7921_vif_connect_iter(void *priv, u8 *mac,
 
 	if (vif->type == NL80211_IFTYPE_AP) {
 		mt76_connac_mcu_uni_add_bss(dev->phy.mt76, vif, &mvif->sta.wcid,
-					    true);
+					    true, NULL);
 		mt7921_mcu_sta_update(dev, NULL, vif, true,
 				      MT76_STA_INFO_STATE_NONE);
 		mt7921_mcu_uni_add_beacon_offload(dev, hw, vif, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 7e409ac7d9a8..82df5fa4fbc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -748,7 +748,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
-					    true);
+					    true, NULL);
 
 	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -780,7 +780,8 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		ewma_rssi_init(&mvif->rssi);
 		if (!sta->tdls)
 			mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
-						    &mvif->sta.wcid, false);
+						    &mvif->sta.wcid, false,
+						    NULL);
 	}
 
 	spin_lock_bh(&dev->sta_poll_lock);
@@ -1534,7 +1535,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt7921_mutex_acquire(dev);
 
 	err = mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
-					  true);
+					  true, NULL);
 	if (err)
 		goto out;
 
@@ -1565,7 +1566,8 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (err)
 		goto out;
 
-	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, false);
+	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, false,
+				    NULL);
 
 out:
 	mt7921_mutex_release(dev);
-- 
2.25.1

