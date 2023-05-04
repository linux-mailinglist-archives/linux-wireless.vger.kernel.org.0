Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8606F675B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 10:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjEDI2W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 04:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjEDI1y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 04:27:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F80B40C6
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 01:22:56 -0700 (PDT)
X-UUID: 57f18212ea5211ed9cb5633481061a41-20230504
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xI/iag2niQ/d5sOhpBmw/fAzfR/Xoql4du0mBm4cXLQ=;
        b=NtlTfSwQKPnFPV9soBl2s59w+uzM2HxbFiAy6Bfz3gMQoHiHZo+ciQS80X64HgpeRsdRl3q3QnRYCfYMDi8mZWxmTofU2OZ5t7LBEgslLqifXaU3uyShBUFNO0DdubEROXbJWfpZtX8kwWYe4J/PevCs3cj9Pxxxr0/AP3oW7Wk=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:9b964a0e-550b-4fcb-b51e-9f0fda807b54,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.23,REQID:9b964a0e-550b-4fcb-b51e-9f0fda807b54,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:697ab71,CLOUDID:69f5c3bf-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:23050416045178GSXY2F,BulkQuantity:0,Recheck:0,SF:29|28|16|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 57f18212ea5211ed9cb5633481061a41-20230504
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <michael-cy.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 692828191; Thu, 04 May 2023 16:04:50 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 May 2023 16:04:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 May 2023 16:04:49 +0800
From:   Michael-CY Lee <michael-cy.lee@mediatek.com>
To:     linux-wireless <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Michael-CY Lee <michael-cy.lee@mediatek.com>
Subject: [PATCH v2] wifi: mac80211: Abort running color change when stopping the AP
Date:   Thu, 4 May 2023 16:04:41 +0800
Message-ID: <20230504080441.22958-1-michael-cy.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Michael Lee <michael-cy.lee@mediatek.com>

When stopping the AP, there might be a color change in progress. It
should be deactivated here, or the driver might later finalize a color
change on a stopped AP.

Fixes: 5f9404abdf2a (mac80211: add support for BSS color change)
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

