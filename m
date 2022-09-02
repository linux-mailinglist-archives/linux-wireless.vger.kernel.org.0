Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B67D5AB413
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiIBOuC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbiIBOth (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:49:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C545135D28
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=pqIAuMCKlkNzDvLNj8LbV0Y7Iu6S2QEHykHxYKm5R/A=; t=1662127883; x=1663337483; 
        b=EzxOOxbbWWGPlBj1MBcNjmWlFnA0Q8cAqzrNueBMzIPNltubV7YShvhfS95Z21gcJZOzlmrHTlO
        nMqu+/01qLvEblPlk2bRaeJm26DrzzuOwDRpQ0ghsFAwMx2dMws7dbLUKrZ7Pf2O3fPWLY9lYKh2s
        +ufVqX8TIKJqMEM9wqwqTvDUYw4QY9h07j423BHViusXhAVxIz0qieQDcX+9HFf+5fgKiqduZc+dj
        teGSpVk/YL62rh0lIVXYK5YuqqDy43YJFe8L2ENeD5/kcjgaRyW5oy57jG3KqefzB5YYM+IHNdcXw
        KjDme2NjA1L8gRtfBaU3eRaW88pAHny/xWyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7OC-006Cfn-0Y;
        Fri, 02 Sep 2022 16:11:20 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] wifi: mac80211: fix locking in auth/assoc timeout
Date:   Fri,  2 Sep 2022 16:11:14 +0200
Message-Id: <20220902161058.7d5f399c88d3.I1c257b1c7a8309a9f9b96654c0e71bcf4b247b98@changeid>
X-Mailer: git-send-email 2.37.2
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

If we hit an authentication or association timeout, we only
release the chanctx for the deflink, and the other link(s)
are released later by ieee80211_vif_set_links(), but we're
not locking this correctly.

Fix the locking here while releasing the channels and links.

Fixes: 81151ce462e5 ("wifi: mac80211: support MLO authentication/association with one link")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 00d0c433fa2b..4555d23b009e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3430,11 +3430,11 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 						  BSS_CHANGED_BSSID);
 		sdata->u.mgd.flags = 0;
+
 		mutex_lock(&sdata->local->mtx);
 		ieee80211_link_release_channel(&sdata->deflink);
-		mutex_unlock(&sdata->local->mtx);
-
 		ieee80211_vif_set_links(sdata, 0);
+		mutex_unlock(&sdata->local->mtx);
 	}
 
 	cfg80211_put_bss(sdata->local->hw.wiphy, auth_data->bss);
@@ -3472,10 +3472,6 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 		sdata->u.mgd.flags = 0;
 		sdata->vif.bss_conf.mu_mimo_owner = false;
 
-		mutex_lock(&sdata->local->mtx);
-		ieee80211_link_release_channel(&sdata->deflink);
-		mutex_unlock(&sdata->local->mtx);
-
 		if (status != ASSOC_REJECTED) {
 			struct cfg80211_assoc_failure data = {
 				.timeout = status == ASSOC_TIMEOUT,
@@ -3494,7 +3490,10 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 			cfg80211_assoc_failure(sdata->dev, &data);
 		}
 
+		mutex_lock(&sdata->local->mtx);
+		ieee80211_link_release_channel(&sdata->deflink);
 		ieee80211_vif_set_links(sdata, 0);
+		mutex_unlock(&sdata->local->mtx);
 	}
 
 	kfree(assoc_data);
-- 
2.37.2

