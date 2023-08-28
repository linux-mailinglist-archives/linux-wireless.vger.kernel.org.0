Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F140678AF87
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjH1MFs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjH1MFg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158CF11A
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4NL8Cgnjuok2ypJqhFXpMdHT9aC3f1hkFbgFS6HtksQ=;
        t=1693224333; x=1694433933; b=MXRVuUe/LHzNJSlqOX+wyx73UUxsVYzzFJHZnCBJqK/VVEX
        LRSopxrROZJ9qUIAHuoTG08kXUHGE6UQv5a+pR61vBczAyJ3yNIlp4c7JZ2HlVfQPH4MwvO3KDMw3
        Js8wDslgaG9GlJllD9UOFs1GE7yaamikA1XeOx0S/b+17BXhCCrB1fSYXixJghkphSuqpqrlhapok
        5DNuWw3qHeJbEB1Q/W39gGJ/INPK7AZiXF++2wiwzlohUgmj+Su/7IucKDoqcemVFPbZWnJYMJDLi
        KL5i6olYHiZQTisCv5Oiw5iOIR8TyEwNs/9lNi9Moo5ZdW+p4pUvzHgJOV4PsKqA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazq-00Gjgt-0s;
        Mon, 28 Aug 2023 14:05:30 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/40] wifi: mac80211: move link activation work to wiphy work
Date:   Mon, 28 Aug 2023 13:59:43 +0200
Message-ID: <20230828135927.262566b9c25c.Ib3fbaeebd9565f1fca897d23d0654d51a7a75369@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We want to have the wiphy locked for these as well,
so move it to be a wiphy work.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/iface.c       | 10 ++++++----
 net/mac80211/link.c        |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 6d789087b453..3db1accb0903 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1112,7 +1112,7 @@ struct ieee80211_sub_if_data {
 	struct ieee80211_link_data __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
 	/* for ieee80211_set_active_links_async() */
-	struct work_struct activate_links_work;
+	struct wiphy_work activate_links_work;
 	u16 desired_active_links;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index c0539e78a34e..fa4514642d74 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -749,9 +749,9 @@ static int ieee80211_stop(struct net_device *dev)
 		ieee80211_stop_mbssid(sdata);
 	}
 
-	cancel_work_sync(&sdata->activate_links_work);
-
 	wiphy_lock(sdata->local->hw.wiphy);
+	wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->activate_links_work);
+
 	ieee80211_do_stop(sdata, true);
 	wiphy_unlock(sdata->local->hw.wiphy);
 
@@ -1691,7 +1691,8 @@ static void ieee80211_iface_work(struct wiphy *wiphy, struct wiphy_work *work)
 	}
 }
 
-static void ieee80211_activate_links_work(struct work_struct *work)
+static void ieee80211_activate_links_work(struct wiphy *wiphy,
+					  struct wiphy_work *work)
 {
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data,
@@ -1736,7 +1737,8 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	skb_queue_head_init(&sdata->skb_queue);
 	skb_queue_head_init(&sdata->status_queue);
 	wiphy_work_init(&sdata->work, ieee80211_iface_work);
-	INIT_WORK(&sdata->activate_links_work, ieee80211_activate_links_work);
+	wiphy_work_init(&sdata->activate_links_work,
+			ieee80211_activate_links_work);
 
 	switch (type) {
 	case NL80211_IFTYPE_P2P_GO:
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 748d222e8d3d..bcff8a909405 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -512,6 +512,6 @@ void ieee80211_set_active_links_async(struct ieee80211_vif *vif,
 		return;
 
 	sdata->desired_active_links = active_links;
-	schedule_work(&sdata->activate_links_work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->activate_links_work);
 }
 EXPORT_SYMBOL_GPL(ieee80211_set_active_links_async);
-- 
2.41.0

