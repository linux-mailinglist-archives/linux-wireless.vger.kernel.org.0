Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A435AB423
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbiIBOv0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiIBOvE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7276625EAF
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4Gipd64EzMlnznd/CUNYXHCRtR+85bb+BXUY15tTYus=;
        t=1662127988; x=1663337588; b=MxOTq1z4EhLQ8+tf2ytlLsXAnUX7PFpT1eu0h1OU1ax6ApW
        B2j+UexMZkt/WTPnluSisxfahRsVQS4Ln5AcL8IWn+pLiojqvN7o0wo5krH/5NaGZNHM5dV8Qazab
        7t1Hig9FHeoleO0l1tERL2ttSRcxE6AgN2Gi+NmQibiUUXFW+OZxTWmnc3NEMlPLMK9E2XljXngzy
        6XiMcuP0tDPz8ya4NBKIkQ/cM3p+7o15wwPSH4HgMLrtLFSlcGRiQhLhZRLPt16TDHsCpwxfceTRT
        FFtvpvxkCX/+hM0h0osckX7xTsQtBfb+cz90+tg2Eddd1xA2ZT5FsJ3XhVe9byAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Ps-006Ch3-0t;
        Fri, 02 Sep 2022 16:13:04 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/27] wifi: mac80211: mlme: assign link address correctly
Date:   Fri,  2 Sep 2022 16:12:38 +0200
Message-Id: <20220902161143.dde5fca43e3a.Ie8541b90865553a827c70c903c2f2a5238e77b4c@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Right now, we assign the link address only after we add
the link to the driver, which is quite obviously wrong.
It happens to work in many cases because it gets updated
immediately, and then link_conf updates may update it,
but it's clearly not really right.

Set the link address during ieee80211_mgd_setup_link()
so it's set before telling the driver about the link.

Fixes: 81151ce462e5 ("wifi: mac80211: support MLO authentication/association with one link")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ef192974949c..4c8bbf0bd25b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6322,6 +6322,8 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 	if (sdata->u.mgd.assoc_data)
 		ether_addr_copy(link->conf->addr,
 				sdata->u.mgd.assoc_data->link[link_id].addr);
+	else if (!is_valid_ether_addr(link->conf->addr))
+		eth_random_addr(link->conf->addr);
 }
 
 /* scan finished notification */
@@ -6409,9 +6411,6 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		goto out_err;
 	}
 
-	if (mlo && !is_valid_ether_addr(link->conf->addr))
-		eth_random_addr(link->conf->addr);
-
 	if (WARN_ON(!ifmgd->auth_data && !ifmgd->assoc_data)) {
 		err = -EINVAL;
 		goto out_err;
-- 
2.37.2

