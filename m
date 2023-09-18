Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5532A7A43EA
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 10:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbjIRIE5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 04:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbjIRIEp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 04:04:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C60E57
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 01:04:02 -0700 (PDT)
X-UUID: e9a535c455f911eea33bb35ae8d461a2-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=l/bzdePVw9XDUDSBsm0ATXCcj7W9os1Y+RqSS/XPjDo=;
        b=tucQTdk4Dz8EHCvs9heKH74OW+tRbFxlbXTnSrMCj4KpSb1rx9PRtqh9cfTjIAH5uIkr5HvFyDLvHwyzFKtN6oMp8I4sEjwVo/fE7vHs6ezJOeITaDzibWW6FtOKpNKE2bR9ZAno/JSQqSRVS/OqJ3ijOM7AIoJ5AyYIRkTiGco=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:39aabfbc-c0b4-4c20-b41e-513fb66537fa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:12531014-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e9a535c455f911eea33bb35ae8d461a2-20230918
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1432243427; Mon, 18 Sep 2023 16:03:55 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 16:03:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 16:03:53 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <jenhao.yang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <jsiuda@google.com>, <arowa@google.org>,
        <frankgor@google.com>, <kuabhs@google.com>, <druth@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v2 1/3] wifi: mt76: move struct ieee80211_chanctx_conf up to struct mt76_vif
Date:   Mon, 18 Sep 2023 16:03:06 +0800
Message-ID: <f1e86c1f90ebe75ce2ae0cb1ba34f8db2996792c.1695021398.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1695021398.git.deren.wu@mediatek.com>
References: <cover.1695021398.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Move struct ieee80211_chanctx_conf up to struct mt76_vif to allow the
connac2 library can access the struct ieee80211_chanctx_conf * member in
struct mt76_vif.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Reviewed-by: David Ruth <druth@chromium.org>
Tested-by: David Ruth <druth@chromium.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
v2:
- rebase on the top of maintainer tree
- fix build error and apply the same change in mt792x core
---
 drivers/net/wireless/mediatek/mt76/mt76.h        |  1 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 12 ++++++------
 drivers/net/wireless/mediatek/mt76/mt792x.h      |  1 -
 drivers/net/wireless/mediatek/mt76/mt792x_core.c |  4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6407cbc81985..fabed3f3ef32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -712,6 +712,7 @@ struct mt76_vif {
 	u8 basic_rates_idx;
 	u8 mcast_rates_idx;
 	u8 beacon_rates_idx;
+	struct ieee80211_chanctx_conf *ctx;
 };
 
 struct mt76_phy {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 571b82ed9293..aa20fdce2729 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -753,7 +753,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
-					    true, mvif->ctx);
+					    true, mvif->mt76.ctx);
 
 	ewma_avg_signal_init(&msta->avg_ack_signal);
 
@@ -788,7 +788,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		if (!sta->tdls)
 			mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
 						    &mvif->sta.wcid, false,
-						    mvif->ctx);
+						    mvif->mt76.ctx);
 	}
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
@@ -1205,7 +1205,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt792x_mutex_acquire(dev);
 
 	err = mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
-					  true, mvif->ctx);
+					  true, mvif->mt76.ctx);
 	if (err)
 		goto out;
 
@@ -1237,7 +1237,7 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		goto out;
 
 	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, false,
-				    mvif->ctx);
+				    mvif->mt76.ctx);
 
 out:
 	mt792x_mutex_release(dev);
@@ -1262,7 +1262,7 @@ static void mt7921_ctx_iter(void *priv, u8 *mac,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct ieee80211_chanctx_conf *ctx = priv;
 
-	if (ctx != mvif->ctx)
+	if (ctx != mvif->mt76.ctx)
 		return;
 
 	if (vif->type == NL80211_IFTYPE_MONITOR)
@@ -1295,7 +1295,7 @@ static void mt7921_mgd_prepare_tx(struct ieee80211_hw *hw,
 		       jiffies_to_msecs(HZ);
 
 	mt792x_mutex_acquire(dev);
-	mt7921_set_roc(mvif->phy, mvif, mvif->ctx->def.chan, duration,
+	mt7921_set_roc(mvif->phy, mvif, mvif->mt76.ctx->def.chan, duration,
 		       MT7921_ROC_REQ_JOIN);
 	mt792x_mutex_release(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 39cbd1397457..548e89fad4d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -93,7 +93,6 @@ struct mt792x_vif {
 	struct ewma_rssi rssi;
 
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
-	struct ieee80211_chanctx_conf *ctx;
 };
 
 struct mt792x_phy {
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 8c97ac007d9c..7c4a74fb1180 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -243,7 +243,7 @@ int mt792x_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
-	mvif->ctx = ctx;
+	mvif->mt76.ctx = ctx;
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
@@ -259,7 +259,7 @@ void mt792x_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
-	mvif->ctx = NULL;
+	mvif->mt76.ctx = NULL;
 	mutex_unlock(&dev->mt76.mutex);
 }
 EXPORT_SYMBOL_GPL(mt792x_unassign_vif_chanctx);
-- 
2.18.0

