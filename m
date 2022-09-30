Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59465F0E81
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 17:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiI3PNr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 11:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiI3PNo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 11:13:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263D92870A
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 08:13:43 -0700 (PDT)
X-UUID: bd64deac378448fcbabe1d8f0da48e64-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7wWJ0mt3ROZT4OOAHgPpc2L/Yd1at0XK5LU19Ae0Jek=;
        b=UE2K+4uDNQzXrCXX+eLXsegQHbi2D3RVQIl+WAS9jgGOB5xiOZX1JoBSsfkJrzMOTamD3AL3NH9KPUtPXk0paeke7fvcHYVWSYh0bWGuobcLgBnkT8vV4klHtyQynAbeiczL8zS9/iKA8/UyC9qpwAeUnHf2pSdUN4vX14axQck=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:2f1221e6-1a47-43be-890d-6c1c4fb1f42e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.11,REQID:2f1221e6-1a47-43be-890d-6c1c4fb1f42e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:39a5ff1,CLOUDID:7b4fcde4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:220930231340KKNXHECN,BulkQuantity:0,Recheck:0,SF:28|16|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0
X-UUID: bd64deac378448fcbabe1d8f0da48e64-20220930
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 494738482; Fri, 30 Sep 2022 23:13:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 30 Sep 2022 23:13:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 30 Sep 2022 23:13:38 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 3/6] wifi: mt76: mt7915: rework testmode tx antenna setting
Date:   Fri, 30 Sep 2022 23:13:12 +0800
Message-ID: <20220930151315.19012-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220930151315.19012-1-shayne.chen@mediatek.com>
References: <20220930151315.19012-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Let the configuration of testmode antenna mask on both band0 and band1
become antenna_mask rather than chainmask. This could simplify the
settings for user and get rid of the conversion when sending fw command.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c    |  7 +------
 .../wireless/mediatek/mt76/mt7915/testmode.c   | 18 ++++++++----------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 6417fe685f17..56491364a903 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2642,14 +2642,9 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 
 #ifdef CONFIG_NL80211_TESTMODE
 	if (phy->mt76->test.tx_antenna_mask &&
-	    (phy->mt76->test.state == MT76_TM_STATE_TX_FRAMES ||
-	     phy->mt76->test.state == MT76_TM_STATE_RX_FRAMES ||
-	     phy->mt76->test.state == MT76_TM_STATE_TX_CONT)) {
+	    mt76_testmode_enabled(phy->mt76)) {
 		req.tx_streams_num = fls(phy->mt76->test.tx_antenna_mask);
 		req.rx_streams = phy->mt76->test.tx_antenna_mask;
-
-		if (phy != &dev->phy)
-			req.rx_streams >>= dev->chainshift;
 	}
 #endif
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index efb9bb8231e2..e1838f046568 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -447,15 +447,10 @@ mt7915_tm_set_tx_frames(struct mt7915_phy *phy, bool en)
 	if (en) {
 		mt7915_tm_update_channel(phy);
 
-		if (td->tx_spe_idx) {
+		if (td->tx_spe_idx)
 			phy->test.spe_idx = td->tx_spe_idx;
-		} else {
-			u8 tx_ant = td->tx_antenna_mask;
-
-			if (phy != &dev->phy)
-				tx_ant >>= dev->chainshift;
-			phy->test.spe_idx = spe_idx_map[tx_ant];
-		}
+		else
+			phy->test.spe_idx = spe_idx_map[td->tx_antenna_mask];
 	}
 
 	mt7915_tm_set_tam_arb(phy, en,
@@ -696,7 +691,9 @@ mt7915_tm_set_params(struct mt76_phy *mphy, struct nlattr **tb,
 {
 	struct mt76_testmode_data *td = &mphy->test;
 	struct mt7915_phy *phy = mphy->priv;
-	u32 changed = 0;
+	struct mt7915_dev *dev = phy->dev;
+	u32 chainmask = mphy->chainmask, changed = 0;
+	bool ext_phy = phy != &dev->phy;
 	int i;
 
 	BUILD_BUG_ON(NUM_TM_CHANGED >= 32);
@@ -705,7 +702,8 @@ mt7915_tm_set_params(struct mt76_phy *mphy, struct nlattr **tb,
 	    td->state == MT76_TM_STATE_OFF)
 		return 0;
 
-	if (td->tx_antenna_mask & ~mphy->chainmask)
+	chainmask = ext_phy ? chainmask >> dev->chainshift : chainmask;
+	if (td->tx_antenna_mask > chainmask)
 		return -EINVAL;
 
 	for (i = 0; i < ARRAY_SIZE(tm_change_map); i++) {
-- 
2.25.1

