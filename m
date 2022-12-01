Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A4363E868
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 04:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLADo6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 22:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLADo4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 22:44:56 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49979075D
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 19:44:50 -0800 (PST)
X-UUID: 8c95f5e5ed2145bab913468e825b0803-20221201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=pdn4ilndUShBfEwJMZoAT9iAd2cV94PGdSIcoqPHRE4=;
        b=recSrXoG8HhQNWeTqz8JSf2no+oYqsNzFH7Zz64zWHemfgDDV6X+j+2ETqHmdWvSM2/Gdy3XPZxnOa2hxJr9s3E8DfJ6oDc0zUNh7e/huFYhM5dTCTU3I55M0os5ctA49acGHmoyBX9TZnK9BwHJ4ok6BcmOAZMV1YlyHz1Sop4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:7c0a6aa3-e1e0-49a6-bba2-95cb9c2a3eb0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:7c0a6aa3-e1e0-49a6-bba2-95cb9c2a3eb0,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:e8aa376c-41fe-47b6-8eb4-ec192dedaf7d,B
        ulkID:221201114448OXBOAR4B,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8c95f5e5ed2145bab913468e825b0803-20221201
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1655589162; Thu, 01 Dec 2022 11:44:45 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 1 Dec 2022 11:44:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 1 Dec 2022 11:44:45 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/5] wifi: mt76: mt7915: fix scene detection flow of spatial reuse
Date:   Thu, 1 Dec 2022 11:44:40 +0800
Message-ID: <d1c11adff6b57c9104bb16df19f62700e2505473.1669861862.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firmware is in the driving seat while sr_scene_detect is enabled,
so driver needs to skip operation to avoid mangling scene detection
algorithm.

Fixes: a633503 ("wifi: mt76: mt7915: add support to configure spatial reuse parameter set")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 9e479d41eab5..718e52744994 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3535,22 +3535,22 @@ int mt7915_mcu_add_obss_spr(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
+	/* firmware dynamically adjusts PD threshold so skip manual control */
+	if (sr_scene_detect && !he_obss_pd->enable)
+		return 0;
+
 	/* enable spatial reuse */
 	ret = mt7915_mcu_enable_obss_spr(phy, SPR_ENABLE, he_obss_pd->enable);
 	if (ret)
 		return ret;
 
-	if (!he_obss_pd->enable)
+	if (sr_scene_detect || !he_obss_pd->enable)
 		return 0;
 
 	ret = mt7915_mcu_enable_obss_spr(phy, SPR_ENABLE_TX, true);
 	if (ret)
 		return ret;
 
-	/* firmware dynamically adjusts PD threshold so skip manual control */
-	if (sr_scene_detect)
-		return 0;
-
 	/* set SRG/non-SRG OBSS PD threshold */
 	ret = mt7915_mcu_set_obss_spr_pd(phy, he_obss_pd);
 	if (ret)
-- 
2.18.0

