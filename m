Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3465BAF15
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIPOR2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 10:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiIPOR1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 10:17:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6737B08A0
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 07:17:21 -0700 (PDT)
X-UUID: 231ebfdafca146bbb4195a213d71ad43-20220916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nb9JBq33ZCRn28wiFAPm6CoQ09k2CT8DYFJ015psmGk=;
        b=B2ItNpGmjmp/QTLMoUgWWTXBg/5yNIbanKGeHORHFqiDj/UIpHILTY09TlZJu6S7LEfwXqSg3XsSrQIWHETQNWHIOhjbVSrXILo9NIJcemInN9RuFBzH5c5on8d1C9mn9bIZso+21FvdlYaBf0ascpNTTeQe3H8wG9xbukvOZgU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:891496a9-660c-4830-9996-a2eedd1c80de,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:7a15eb5d-5ed4-4e28-8b00-66ed9f042fbd,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 231ebfdafca146bbb4195a213d71ad43-20220916
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1331282299; Fri, 16 Sep 2022 22:17:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 16 Sep 2022 22:17:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 16 Sep 2022 22:17:16 +0800
From:   Howard Hsu <howard-yh.hsu@mediatek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>
Subject: [PATCH] wifi: mac80211: Align with Draft P802.11be_D1.5
Date:   Fri, 16 Sep 2022 22:17:00 +0800
Message-ID: <20220916141700.28378-1-howard-yh.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix ieee80211_prep_channel to aligh with Draft P80211.be_D1.5. It shall
shift 4 byte to fetch EHT Operation information.

Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ff449e0c2e62..9bb085eab12a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4735,7 +4735,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 						   cbss_ies->data, cbss_ies->len);
 		if (eht_oper_ie && eht_oper_ie[1] >=
 		    1 + sizeof(struct ieee80211_eht_operation))
-			eht_oper = (void *)(eht_oper_ie + 3);
+			eht_oper = (void *)(eht_oper_ie + 4);
 		else
 			eht_oper = NULL;
 	}
-- 
2.18.0

