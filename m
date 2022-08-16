Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2AE594F13
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 05:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiHPDdm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Aug 2022 23:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiHPDdG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Aug 2022 23:33:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293824D15F
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 17:04:01 -0700 (PDT)
X-UUID: 346a222baa07432da3801dc1e0931b45-20220816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Pk12J1PvmWS5oCrmECy0Iw17fYlCMUVZW45eZEevfVo=;
        b=l0IxEBSFcAQKiHc1pwoY7si6uGj2V5XY97TBSvQATtI5Xf3JicAgoEiOzSMDICA3wXsH0bbBe0Nh0gRUW04yVvZnmc58S5+ydfCxo5XFz7ImpUkSsDMeJxf6yND8Nq4UyWZZZt7bw08b0JJOBKBEls0xNWCok3dafdwFtrZOyew=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:b1565223-353e-4eb6-b6f1-e76c97a249c1,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:105
X-CID-INFO: VERSION:1.1.9,REQID:b1565223-353e-4eb6-b6f1-e76c97a249c1,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS98
        1B3D,ACTION:quarantine,TS:105
X-CID-META: VersionHash:3d8acc9,CLOUDID:c00bbe9c-da39-4e3b-a854-56c7d2111b46,C
        OID:b1d26b41d4a3,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 346a222baa07432da3801dc1e0931b45-20220816
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 489829715; Tue, 16 Aug 2022 08:03:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 16 Aug 2022 08:03:56 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Aug 2022 08:03:55 +0800
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
Subject: [PATCH 1/9] wifi: mac80211: allow enabling chanctx until hw registration
Date:   Tue, 16 Aug 2022 08:03:39 +0800
Message-ID: <473fc7b169f288b7815a7736cf33ac0ec1599a09.1660606893.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1660606893.git.objelf@gmail.com>
References: <cover.1660606893.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

MT7921 device can be supported with the channel context depending on
the newer firmware so that we need a way to enable the chanctx related
methods until hw is being registered.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 net/mac80211/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 5b1c47ed0cc0..98d05ed1a081 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1011,6 +1011,14 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		return -EINVAL;
 #endif
 
+	/* check all or no channel context operations exist */
+	i = !!local->ops->add_chanctx + !!local->ops->remove_chanctx +
+	    !!local->ops->change_chanctx + !!local->ops->assign_vif_chanctx +
+	    !!local->ops->unassign_vif_chanctx;
+	if (WARN_ON(i != 0 && i != 5))
+		return -EINVAL;
+	local->use_chanctx = i == 5;
+
 	if (!local->use_chanctx) {
 		for (i = 0; i < local->hw.wiphy->n_iface_combinations; i++) {
 			const struct ieee80211_iface_combination *comb;
-- 
2.25.1

