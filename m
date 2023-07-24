Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B57760112
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 23:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGXVUR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 17:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjGXVUP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 17:20:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9EE1702
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 14:19:47 -0700 (PDT)
X-UUID: cf0374822a6711ee9cb5633481061a41-20230725
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZxYZtkhXRjiitOQUc1ZykDsrDQxrX696sSoc7UHcofw=;
        b=rrcoOKCVKNbI/PA72wm2cJ//TkWps4jvgGJZBwIehvsEt0K7imamI1h7InZioB+EYlJxXkG66E1kr3ekVB1u1bB+83DAz8Xgq6InXkANZisRSB736GwbQ/uO32W7DWMbtrrh9bnd8oSGYn+PnXOFHmvNrpS2HxuVzl7cgjaxpcE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:7292dc5b-cc6b-4489-bb7f-69b3b5e01929,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.29,REQID:7292dc5b-cc6b-4489-bb7f-69b3b5e01929,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:e7562a7,CLOUDID:8d607aa0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:230725051944OVKG9RE4,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,
        TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: cf0374822a6711ee9cb5633481061a41-20230725
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 874798134; Tue, 25 Jul 2023 05:19:43 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 25 Jul 2023 05:19:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 25 Jul 2023 05:19:42 +0800
From:   <sean.wang@mediatek.com>
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
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/2] wifi: mt76: move struct ieee80211_chanctx_conf up to struct mt76_vif
Date:   Tue, 25 Jul 2023 05:19:39 +0800
Message-ID: <8fd42ac8e1c97246f6e65225a14fc8a029ac3aaa.1690232804.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/net/wireless/mediatek/mt76/mt76.h        |  1 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 16 ++++++++--------
 .../net/wireless/mediatek/mt76/mt7921/mt7921.h   |  1 -
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 878087257ea7..bf9c781ff48c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -708,6 +708,7 @@ struct mt76_vif {
 	u8 basic_rates_idx;
 	u8 mcast_rates_idx;
 	u8 beacon_rates_idx;
+	struct ieee80211_chanctx_conf *ctx;
 };
 
 struct mt76_phy {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 87067ac367eb..8987173a83f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -804,7 +804,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
-					    true, mvif->ctx);
+					    true, mvif->mt76.ctx);
 
 	ewma_avg_signal_init(&msta->avg_ack_signal);
 
@@ -839,7 +839,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		if (!sta->tdls)
 			mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
 						    &mvif->sta.wcid, false,
-						    mvif->ctx);
+						    mvif->mt76.ctx);
 	}
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
@@ -1638,7 +1638,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt7921_mutex_acquire(dev);
 
 	err = mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
-					  true, mvif->ctx);
+					  true, mvif->mt76.ctx);
 	if (err)
 		goto out;
 
@@ -1670,7 +1670,7 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		goto out;
 
 	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, false,
-				    mvif->ctx);
+				    mvif->mt76.ctx);
 
 out:
 	mt7921_mutex_release(dev);
@@ -1695,7 +1695,7 @@ static void mt7921_ctx_iter(void *priv, u8 *mac,
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
 	struct ieee80211_chanctx_conf *ctx = priv;
 
-	if (ctx != mvif->ctx)
+	if (ctx != mvif->mt76.ctx)
 		return;
 
 	if (vif->type == NL80211_IFTYPE_MONITOR)
@@ -1728,7 +1728,7 @@ mt7921_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
-	mvif->ctx = ctx;
+	mvif->mt76.ctx = ctx;
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
@@ -1744,7 +1744,7 @@ mt7921_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
-	mvif->ctx = NULL;
+	mvif->mt76.ctx = NULL;
 	mutex_unlock(&dev->mt76.mutex);
 }
 
@@ -1758,7 +1758,7 @@ static void mt7921_mgd_prepare_tx(struct ieee80211_hw *hw,
 		       jiffies_to_msecs(HZ);
 
 	mt7921_mutex_acquire(dev);
-	mt7921_set_roc(mvif->phy, mvif, mvif->ctx->def.chan, duration,
+	mt7921_set_roc(mvif->phy, mvif, mvif->mt76.ctx->def.chan, duration,
 		       MT7921_ROC_REQ_JOIN);
 	mt7921_mutex_release(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index ec9879650174..04a9ce50cff2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -173,7 +173,6 @@ struct mt7921_vif {
 	struct ewma_rssi rssi;
 
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
-	struct ieee80211_chanctx_conf *ctx;
 };
 
 enum {
-- 
2.25.1

