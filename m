Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F0B760113
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 23:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGXVUT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 17:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjGXVUS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 17:20:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494DF1728
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 14:19:50 -0700 (PDT)
X-UUID: cfbd76f22a6711ee9cb5633481061a41-20230725
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NYfQ6g1TEoKH3WqsU8FI6skFXfIJF2pz65Ld7F7sxoE=;
        b=dE7/MZ5vElwIva5cPqSw5coGi3myWrB3ZP1ypEi62ccDueLifsSFhCqR+EHrM3DlKJ+uMGuxhmmjt8ze0LxchC+DtNdRKKYSKP8yt95m4g4dal6H0LzmiJNxJTaSkEkXg3nFX116ybNGBntDTZtmbZ5qxvCXJEFCX3TT0HkEfCk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:f6f2070b-3f5e-4f73-8d2e-15432aaf851f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:94607aa0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: cfbd76f22a6711ee9cb5633481061a41-20230725
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 206244349; Tue, 25 Jul 2023 05:19:45 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 25 Jul 2023 05:19:43 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 25 Jul 2023 05:19:43 +0800
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
Subject: [PATCH 2/2] wifi: mt76: mt7921: fix the wrong rate pickup for the chanctx driver
Date:   Tue, 25 Jul 2023 05:19:40 +0800
Message-ID: <7c7c2c1f0584e8dd016bc2bf8de88684fcc7679c.1690232804.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <8fd42ac8e1c97246f6e65225a14fc8a029ac3aaa.1690232804.git.objelf@gmail.com>
References: <8fd42ac8e1c97246f6e65225a14fc8a029ac3aaa.1690232804.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The variable band should be determined by the ieee80211_chanctx_conf when
the driver is a kind of chanctx one e.g mt7921 and mt7922 driver so we
added the extension to mt76_connac2_mac_tx_rate_val by distinguishing if
it can support chanctx to fix the incorrect rate pickup.

Fixes: 41ac53c899bd ("wifi: mt76: mt7921: introduce chanctx support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c        | 9 +++++++--
 drivers/net/wireless/mediatek/mt76/mt76.h            | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 7 +++++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index c0ff36a98bed..d622a2916c0e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1698,11 +1698,16 @@ mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
 }
 EXPORT_SYMBOL_GPL(mt76_init_queue);
 
-u16 mt76_calculate_default_rate(struct mt76_phy *phy, int rateidx)
+u16 mt76_calculate_default_rate(struct mt76_phy *phy,
+				struct ieee80211_vif *vif, int rateidx)
 {
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = mvif->ctx ?
+					    &mvif->ctx->def :
+					    &phy->chandef;
 	int offset = 0;
 
-	if (phy->chandef.chan->band != NL80211_BAND_2GHZ)
+	if (chandef->chan->band != NL80211_BAND_2GHZ)
 		offset = 4;
 
 	/* pick the lowest rate for hidden nodes */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index bf9c781ff48c..a292e15224e1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1100,7 +1100,8 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *data, int offset, int len);
 struct mt76_queue *
 mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
 		int ring_base, u32 flags);
-u16 mt76_calculate_default_rate(struct mt76_phy *phy, int rateidx);
+u16 mt76_calculate_default_rate(struct mt76_phy *phy,
+				struct ieee80211_vif *vif, int rateidx);
 static inline int mt76_init_tx_queue(struct mt76_phy *phy, int qid, int idx,
 				     int n_desc, int ring_base, u32 flags)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index ee5177fd6dde..d91f5548dc02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -310,7 +310,10 @@ u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
 				 struct ieee80211_vif *vif,
 				 bool beacon, bool mcast)
 {
-	u8 nss = 0, mode = 0, band = mphy->chandef.chan->band;
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = mvif->ctx ?
+					    &mvif->ctx->def : &mphy->chandef;
+	u8 nss = 0, mode = 0, band = chandef->chan->band;
 	int rateidx = 0, mcast_rate;
 
 	if (!vif)
@@ -343,7 +346,7 @@ u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
 		rateidx = ffs(vif->bss_conf.basic_rates) - 1;
 
 legacy:
-	rateidx = mt76_calculate_default_rate(mphy, rateidx);
+	rateidx = mt76_calculate_default_rate(mphy, vif, rateidx);
 	mode = rateidx >> 8;
 	rateidx &= GENMASK(7, 0);
 out:
-- 
2.25.1

