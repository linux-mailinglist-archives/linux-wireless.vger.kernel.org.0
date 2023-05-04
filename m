Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ECE6F64C1
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 08:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjEDGLX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 02:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEDGLW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 02:11:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693762122
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 23:11:09 -0700 (PDT)
X-UUID: 7243051aea4211edb20a276fd37b9834-20230504
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rE5QWu/n8ZRnDtPZT8J8qeDTGPZL1saLvA8Wwnaqr7U=;
        b=XCQffrA3kAgpJF4b80ww1kEGYE5IYyZSdmQxvHaOx6/5e5YPHuOBYPG9ulViHbiGYJr9ku4aDhdMY9R9KA7cTZQsdTYtN6IarhD/lpSw6UAtEe4aaGFLUsLuPgPYC+YfCuWOA3pxvgmPxmU69U3lH+TYYvTBPMhiY3exlqZv++k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:138cbd20-a922-4c79-990c-294eef2ed037,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:697ab71,CLOUDID:8d02b330-6935-4eab-a959-f84f8da15543,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 7243051aea4211edb20a276fd37b9834-20230504
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <michael-cy.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1810692553; Thu, 04 May 2023 14:11:02 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 May 2023 14:11:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 4 May 2023 14:11:01 +0800
From:   Michael-CY Lee <michael-cy.lee@mediatek.com>
To:     linux-wireless <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Michael-CY Lee <michael-cy.lee@mediatek.com>
Subject: [PATCH] wifi: mac80211: Abort running CCA when stopping AP
Date:   Thu, 4 May 2023 14:10:49 +0800
Message-ID: <20230504061049.21082-1-michael-cy.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Michael Lee <michael-cy.lee@mediatek.com>

Signed-off-by: Michael Lee <michael-cy.lee@mediatek.com>
---
 net/mac80211/cfg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 343ce2b..e6df30d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1537,9 +1537,10 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 		sdata_dereference(link->u.ap.unsol_bcast_probe_resp,
 				  sdata);
 
-	/* abort any running channel switch */
+	/* abort any running channel switch or color change */
 	mutex_lock(&local->mtx);
 	link_conf->csa_active = false;
+	link_conf->color_change_active = false;
 	if (link->csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-- 
2.25.1

