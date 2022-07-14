Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CD1574880
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jul 2022 11:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbiGNJVL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jul 2022 05:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbiGNJUu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jul 2022 05:20:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5836914D00
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jul 2022 02:17:42 -0700 (PDT)
X-UUID: 7f4a003922914c5cafd2ac18eec4a1d0-20220714
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:594a59ac-8795-4726-9864-4392d3a354a8,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:594a59ac-8795-4726-9864-4392d3a354a8,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:a2187cd7-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:6fc6e3d06ae0,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7f4a003922914c5cafd2ac18eec4a1d0-20220714
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <lian.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1354379431; Thu, 14 Jul 2022 17:16:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 14 Jul 2022 17:16:39 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 14 Jul 2022 17:16:38 +0800
From:   Lian Chen <lian.chen@mediatek.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>
CC:     Bo Jiao <bo.jiao@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lian Chen <lian.chen@mediatek.com>
Subject: [PATCH] wifi: mac80211: make 4addr null frames using min_rate for WDS
Date:   Thu, 14 Jul 2022 17:16:36 +0800
Message-ID: <20220714091636.59107-1-lian.chen@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WDS needs 4addr packets to trigger AP for wlan0.sta creation.
However, the 4addr null frame is sent at a high rate
so that AP can't receive it.
This PATCHES switches to use min_rate.

Signed-off-by: Lian Chen <lian.chen@mediatek.com>
---
 net/mac80211/mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c833245..09f54be 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1133,6 +1133,7 @@ void ieee80211_send_4addr_nullfunc(struct ieee80211_local *local,
 	memcpy(nullfunc->addr4, sdata->vif.addr, ETH_ALEN);
 
 	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
+	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_CTL_USE_MINRATE;
 	ieee80211_tx_skb(sdata, skb);
 }
 
-- 
2.18.0

