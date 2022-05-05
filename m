Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B99051BA46
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 10:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347742AbiEEI3z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 04:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbiEEI3s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 04:29:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F1E2D1F5
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 01:26:04 -0700 (PDT)
X-UUID: c186732969904fe3b24f21083a24a98e-20220505
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:17151af6-e12e-44a0-b815-5fc877a7fe06,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:8a284b16-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: c186732969904fe3b24f21083a24a98e-20220505
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chui-hao.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1736132449; Thu, 05 May 2022 16:25:57 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 5 May 2022 16:25:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 5 May 2022 16:25:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 5 May 2022 16:25:56 +0800
From:   Peter Chiu <chui-hao.chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH 4/4] mt76: mt7915: limit minimum twt duration
Date:   Thu, 5 May 2022 16:25:54 +0800
Message-ID: <20220505082554.16656-4-chui-hao.chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220505082554.16656-1-chui-hao.chiu@mediatek.com>
References: <20220505082554.16656-1-chui-hao.chiu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The minimum twt duration supported by mt7915 is 64 according to hardware
design. Reply station with TWT_SETUP_CMD_DICTATE if min_twt_dur smaller
than 64.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index ff60a3d2d26d..e912ecacb578 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2633,6 +2633,7 @@ void mt7915_mac_add_twt_setup(struct ieee80211_hw *hw,
 			      struct ieee80211_sta *sta,
 			      struct ieee80211_twt_setup *twt)
 {
+#define MT7915_MIN_TWT_DUR 64
 	enum ieee80211_twt_setup_cmd setup_cmd = TWT_SETUP_CMD_REJECT;
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct ieee80211_twt_params *twt_agrt = (void *)twt->params;
@@ -2654,6 +2655,12 @@ void mt7915_mac_add_twt_setup(struct ieee80211_hw *hw,
 	if (hweight8(msta->twt.flowid_mask) == ARRAY_SIZE(msta->twt.flow))
 		goto unlock;
 
+	if (twt_agrt->min_twt_dur < MT7915_MIN_TWT_DUR) {
+		setup_cmd = TWT_SETUP_CMD_DICTATE;
+		twt_agrt->min_twt_dur = MT7915_MIN_TWT_DUR;
+		goto unlock;
+	}
+
 	flowid = ffs(~msta->twt.flowid_mask) - 1;
 	le16p_replace_bits(&twt_agrt->req_type, flowid,
 			   IEEE80211_TWT_REQTYPE_FLOWID);
-- 
2.18.0

