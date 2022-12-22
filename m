Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A73653D58
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 10:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLVJOK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 04:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiLVJOI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 04:14:08 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CAA101FA
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 01:14:05 -0800 (PST)
X-UUID: ed6aeb20be984b6abf8a892a569fd4eb-20221222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=SfWHc6C6T9H/rOjQwAOvsuuY+05MGIFO3rrF7uufH10=;
        b=m6mqnmH/ZBHBje4RCmGx/Jz9s9d6gYeX4u0EQIg87TkIsGY3dUPG2lOWOd7NHv0Jn0i0ZMImb+SJiRYICKOnDgUEwNsA4H4OnRlc7AYoBFk0MTt9n+E3m4XS+5RA6pU3kD8/wQYlw0f2rjUzApnCE2s1ws5svwXMjdThAHkoM+U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:3675d2ce-0fac-4928-a7d6-4e577d20da68,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:cd70a9f3-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ed6aeb20be984b6abf8a892a569fd4eb-20221222
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <michael-cy.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1735073031; Thu, 22 Dec 2022 17:13:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 22 Dec 2022 17:13:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 22 Dec 2022 17:13:57 +0800
From:   Michael Lee <michael-cy.lee@mediatek.com>
To:     linux-wireless <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Michael Lee <michael-cy.lee@mediatek.com>
Subject: [PATCH] wifi: mac80211: check the control channel before downgrading the bandwidth
Date:   Thu, 22 Dec 2022 17:13:54 +0800
Message-ID: <20221222091354.14050-1-michael-cy.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the link fails to use the channel, chandef's bandwidth will be 
downgraded without checking the control channel.
The issue happens when the STA of an extender with limited channel 
context associates with a root AP operating on a different channel.

Below is an example:

    ______________           ________________
   | RootAP(ch36) |         | Extender(ch44) |
   |              | (ASSOC) |       AP       |
   |      AP <-------------------- STA       |
   |______________|         |________________|

- RootAP is operating on channel 36, while Extender is operating
  on channel 44
- When associating with RootAP, Extender-STA downgrades the
  chandef's bandwidth to be compatible with any channels on the phy
- Finally, chandef's bandwidth is downgraded to 20MHz and 
  the association fails

In this patch, a control channel checking is added to avoid unnecessary
bandwidth downgrading

Signed-off-by: Michael Lee <michael-cy.lee@mediatek.com>
---
 net/mac80211/mlme.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0aee2392dd29..bc435e8508e2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4616,6 +4616,27 @@ ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 	return false;
 }
 
+static bool
+ieee80211_check_same_ctrl_channel(struct ieee80211_sub_if_data *sdata,
+				  const struct cfg80211_chan_def *chandef)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_chanctx *ctx;
+
+	mutex_lock(&local->chanctx_mtx);
+	list_for_each_entry(ctx, &local->chanctx_list, list) {
+		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
+			continue;
+		if (ctx->mode == IEEE80211_CHANCTX_EXCLUSIVE)
+			continue;
+		if (chandef->chan == ctx->conf.def.chan)
+			return true;
+	}
+
+	mutex_unlock(&local->chanctx_mtx);
+	return false;
+}
+
 static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_link_data *link,
 				  struct cfg80211_bss *cbss,
@@ -4842,6 +4863,9 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	    chandef.width == NL80211_CHAN_WIDTH_10)
 		goto out;
 
+	if (!ret || !ieee80211_check_same_ctrl_channel(sdata, &chandef))
+		goto out;
+
 	while (ret && chandef.width != NL80211_CHAN_WIDTH_20_NOHT) {
 		*conn_flags |=
 			ieee80211_chandef_downgrade(&chandef);
-- 
2.25.1

