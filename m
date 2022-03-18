Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180BF4DE3F3
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Mar 2022 23:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241274AbiCRWTq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Mar 2022 18:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbiCRWTn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Mar 2022 18:19:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BEB183836
        for <linux-wireless@vger.kernel.org>; Fri, 18 Mar 2022 15:18:18 -0700 (PDT)
X-UUID: d8c01a71268f43efa11bdd66a23fe154-20220319
X-UUID: d8c01a71268f43efa11bdd66a23fe154-20220319
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1027730250; Sat, 19 Mar 2022 06:18:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 19 Mar 2022 06:18:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 19 Mar 2022 06:18:11 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Johannes Berg <johannes.berg@intel.com>
CC:     <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mac80211: adjust the replace_state of ieee80211_find_chanctx()
Date:   Sat, 19 Mar 2022 06:18:10 +0800
Message-ID: <40aabb3e10302f1d7da92b7a4eb46577d5ed8e05.1647641256.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We observe that the condition of chanctx could not be back to
IEEE80211_CHANCTX_REPLACE_NONE occasionally while STA connection.

In this case the state could be IEEE80211_CHANCTX_REPLACE_OTHER, which
fails the check and then creates another chanctx that leads to the next
round of chan_switch failure in cfg80211_check_combinations().

So, modify state to just rule out IEEE80211_CHANCTX_WILL_BE_REPLACED.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 net/mac80211/chan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index e26d42de14ec..604095ff7a5b 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -477,7 +477,7 @@ ieee80211_find_chanctx(struct ieee80211_local *local,
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
 		const struct cfg80211_chan_def *compat;
 
-		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACE_NONE)
+		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
 			continue;
 
 		if (ctx->mode == IEEE80211_CHANCTX_EXCLUSIVE)
-- 
2.29.2

