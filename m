Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B06624CED
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 22:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiKJVZH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 16:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiKJVYi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 16:24:38 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86CA5E9EA
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 13:24:07 -0800 (PST)
X-UUID: d2eecbe9988249fea4ef429a4cc4b9f1-20221111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5TvfMAlcOhTEuPMwksbIJp8PJAyLBIEodner5gvucXc=;
        b=rPtXtGp5ebKtgClz2mZI7Ogs/K6a3CZHtE5ZrvCWtgfxbfPAXcKPR5/rc42YWWIEQE0lLKjeI6b8WGcDAEv8jbVBALZZ/fpjsnJLS+x7X1mC12UH5ue/W9Qv5/X5/GHzZ6iqjfoRwpAXgl3vHlQ261giOeGc1V8DUMnjT66Hr+U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:4e58902d-0bc6-4c2c-ac95-65579efb3b32,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.13,REQID:4e58902d-0bc6-4c2c-ac95-65579efb3b32,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:d12e911,CLOUDID:ea97f350-b7af-492d-8b40-b1032f90ce11,B
        ulkID:2211110524015SX6I8UU,BulkQuantity:1,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: d2eecbe9988249fea4ef429a4cc4b9f1-20221111
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1470703718; Fri, 11 Nov 2022 05:24:00 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 11 Nov 2022 05:23:59 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 11 Nov 2022 05:23:59 +0800
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
Subject: [PATCH v3 2/7] wifi: mt76: mt7921: add chanctx parameter to mt76_connac_mcu_uni_add_bss signature
Date:   Fri, 11 Nov 2022 05:23:44 +0800
Message-ID: <207262670fb8b02004d0d145c4c996c68ea389bc.1668068326.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1668068326.git.objelf@gmail.com>
References: <cover.1668068326.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
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

