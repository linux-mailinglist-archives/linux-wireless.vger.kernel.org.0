Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CD755102B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jun 2022 08:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbiFTGR2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jun 2022 02:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiFTGR1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jun 2022 02:17:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B753BE1E
        for <linux-wireless@vger.kernel.org>; Sun, 19 Jun 2022 23:17:26 -0700 (PDT)
X-UUID: c7dfdd99ba1c4536b42dee936b24db9d-20220620
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:bfef85a3-7225-47e7-8b01-e37553bcb07a,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.6,REQID:bfef85a3-7225-47e7-8b01-e37553bcb07a,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:b14ad71,CLOUDID:50f8293d-9948-4b2a-a784-d8a6c1086106,C
        OID:9fa7ea9b19ca,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: c7dfdd99ba1c4536b42dee936b24db9d-20220620
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1696154949; Mon, 20 Jun 2022 14:17:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 20 Jun 2022 14:17:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 20 Jun 2022 14:17:19 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix incorrect testmode ipg on band 1 caused by wmm_idx
Date:   Mon, 20 Jun 2022 14:17:17 +0800
Message-ID: <20220620061717.23216-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the issue that the measured inter packet gap didn't fit its
setting value.

Fixes: c2d3b1926f30 ("mt76: mt7915: add support for ipg in testmode")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 20f63644e929..2888e4e9ff72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -168,13 +168,14 @@ mt7915_tm_set_tam_arb(struct mt7915_phy *phy, bool enable, bool mu)
 }
 
 static int
-mt7915_tm_set_wmm_qid(struct mt7915_dev *dev, u8 qid, u8 aifs, u8 cw_min,
+mt7915_tm_set_wmm_qid(struct mt7915_phy *phy, u8 qid, u8 aifs, u8 cw_min,
 		      u16 cw_max, u16 txop)
 {
+	struct mt7915_vif *mvif = (struct mt7915_vif *)phy->monitor_vif->drv_priv;
 	struct mt7915_mcu_tx req = { .total = 1 };
 	struct edca *e = &req.edca[0];
 
-	e->queue = qid;
+	e->queue = qid + mvif->mt76.wmm_idx * MT7915_MAX_WMM_SETS;
 	e->set = WMM_PARAM_SET;
 
 	e->aifs = aifs;
@@ -182,7 +183,7 @@ mt7915_tm_set_wmm_qid(struct mt7915_dev *dev, u8 qid, u8 aifs, u8 cw_min,
 	e->cw_max = cpu_to_le16(cw_max);
 	e->txop = cpu_to_le16(txop);
 
-	return mt7915_mcu_update_edca(dev, &req);
+	return mt7915_mcu_update_edca(phy->dev, &req);
 }
 
 static int
@@ -244,7 +245,7 @@ mt7915_tm_set_ipg_params(struct mt7915_phy *phy, u32 ipg, u8 mode)
 
 	mt7915_tm_set_slot_time(phy, slot_time, sifs);
 
-	return mt7915_tm_set_wmm_qid(dev,
+	return mt7915_tm_set_wmm_qid(phy,
 				     mt76_connac_lmac_mapping(IEEE80211_AC_BE),
 				     aifsn, cw, cw, 0);
 }
-- 
2.25.1

