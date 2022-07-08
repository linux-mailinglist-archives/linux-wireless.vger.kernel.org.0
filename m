Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBA656B620
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jul 2022 11:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbiGHJ7y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 05:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiGHJ7x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 05:59:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8697B823A0
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 02:59:50 -0700 (PDT)
X-UUID: e4743e8159d14de99f36afb21d663423-20220708
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.8,REQID:73435bca-bcef-49c2-ad64-86d08e5e44c6,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:29,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS6885AD
        ,ACTION:quarantine,TS:134
X-CID-INFO: VERSION:1.1.8,REQID:73435bca-bcef-49c2-ad64-86d08e5e44c6,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:29,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:134
X-CID-META: VersionHash:0f94e32,CLOUDID:721cf8d6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:2b4da6b9bc9c,Recheck:0,SF:28|17|19|48,TC:nil,Content:3,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: e4743e8159d14de99f36afb21d663423-20220708
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <meichia.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 173719969; Fri, 08 Jul 2022 17:59:43 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 8 Jul 2022 17:59:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 8 Jul 2022 17:59:41 +0800
From:   MeiChia Chiu <MeiChia.Chiu@mediatek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Felix Fietkau <nbd@nbd.name>, Money Wang <Money.Wang@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Subject: [PATCH] mac80211: fix a center frequency recalculation issue in ieee80211_chandef_downgrade
Date:   Fri, 8 Jul 2022 17:58:23 +0800
Message-ID: <20220708095823.12959-1-MeiChia.Chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: MeiChia Chiu <meichia.chiu@mediatek.com>

When mac80211 downgrades working bandwidth,
the cent_freq and cent_freq1 need to be recalculated.
There is a typo in the case of downgrading bandwidth from
320M to 160M which would cause a wrong frequency value.

Reviewed-by: Money Wang <Money.Wang@mediatek.com>
Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
---
 net/mac80211/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index bccc3a309ed0..bcb4aa7d7599 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4075,7 +4075,7 @@ u32 ieee80211_chandef_downgrade(struct cfg80211_chan_def *c)
 		/* n_P20 */
 		tmp = (150 + c->chan->center_freq - c->center_freq1) / 20;
 		/* n_P160 */
-		tmp /= 80;
+		tmp /= 8;
 		c->center_freq1 = c->center_freq1 - 80 + 160 * tmp;
 		c->width = NL80211_CHAN_WIDTH_160;
 		ret = IEEE80211_STA_DISABLE_320MHZ;
-- 
2.36.1

