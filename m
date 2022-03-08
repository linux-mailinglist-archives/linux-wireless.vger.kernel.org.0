Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F084D0DEC
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Mar 2022 03:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbiCHCSG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 21:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiCHCSF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 21:18:05 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F64BB7EF
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 18:17:10 -0800 (PST)
X-UUID: 8f080972773848b4a9f790e683cd4bb9-20220308
X-UUID: 8f080972773848b4a9f790e683cd4bb9-20220308
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <meichia.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 36811383; Tue, 08 Mar 2022 10:16:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 8 Mar 2022 10:16:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Mar 2022 10:16:47 +0800
From:   MeiChia Chiu <MeiChia.Chiu@mediatek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Subject: [PATCH] mac80211: correct legacy rates check in ieee80211_calc_rx_airtime
Date:   Tue, 8 Mar 2022 10:16:45 +0800
Message-ID: <20220308021645.16272-1-MeiChia.Chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

There are no legacy rates on 60GHz or sub-1Ghz band, so modify the check.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
---
 net/mac80211/airtime.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index 26d2f8ba7029..c0e58eb7c7fb 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -477,7 +477,9 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
 		bool sp = status->enc_flags & RX_ENC_FLAG_SHORTPRE;
 		bool cck;
 
-		if (WARN_ON_ONCE(status->band > NL80211_BAND_5GHZ))
+		/* on 60GHz or sub-1Ghz band, there are no legacy rates */
+		if (WARN_ON_ONCE(status->band == NL80211_BAND_60GHZ ||
+				 status->band == NL80211_BAND_S1GHZ))
 			return 0;
 
 		sband = hw->wiphy->bands[status->band];
-- 
2.18.0

