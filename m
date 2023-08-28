Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440AF78AF95
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjH1MGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjH1MFn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94425120
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=56XQM4dEM1GE0kwQYQKubDx9yaIAQllo/2nubNvSSxY=;
        t=1693224339; x=1694433939; b=muwgjZ61GeEkLxpPntotV4vEA0Rf+t2sNoS5n67A4r0y/sY
        WQk1z0p+fivaCfs+YDVSnZKJbZ9mOLbtwKLNDIiqHkjjDH9XkSLwHl471Tpl/qaRX0lJLq3MhqzZJ
        enTfhvlOsKc3zLAcZHt42NmF9l3oVCWn34U4Kq946ZdBZhL8QvJfZrr67u9p0eBOj6pkoR5cn/hfB
        HiTg359dvBhwO0wgJ7J9xmsVMcGfXpUStoLOK7MNWooNCG6MxtSrDAbs+1cg/Z/JCLsUBhkzcBa42
        XwpYF2g3Gf2r/rFL1kuL07LXsrTko8FcPeOPv5bY4QgRJvbXBAgp5MkrSvXnmomw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazx-00Gjgt-2H;
        Mon, 28 Aug 2023 14:05:37 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 22/40] wifi: mac80211: move CSA finalize to wiphy work
Date:   Mon, 28 Aug 2023 13:59:50 +0200
Message-ID: <20230828135928.a80777a10e97.I8aeffbe95cda6a796f34c6985c19163946595007@changeid>
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

This work should be made per link as well, and then
will have cancellation issues. Moving it to a wiphy
work already fixes those beforehand.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         | 8 ++++----
 net/mac80211/chan.c        | 4 ++--
 net/mac80211/ieee80211_i.h | 4 ++--
 net/mac80211/iface.c       | 2 +-
 net/mac80211/link.c        | 4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e81e712448b2..8c7e6f637a1e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3581,11 +3581,11 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif)
 			if (iter == sdata || iter->vif.mbssid_tx_vif != vif)
 				continue;
 
-			ieee80211_queue_work(&iter->local->hw,
-					     &iter->deflink.csa_finalize_work);
+			wiphy_work_queue(iter->local->hw.wiphy,
+					 &iter->deflink.csa_finalize_work);
 		}
 	}
-	ieee80211_queue_work(&local->hw, &sdata->deflink.csa_finalize_work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->deflink.csa_finalize_work);
 
 	rcu_read_unlock();
 }
@@ -3713,7 +3713,7 @@ static void ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	}
 }
 
-void ieee80211_csa_finalize_work(struct work_struct *work)
+void ieee80211_csa_finalize_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data,
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 68952752b599..f967ed9d2a3a 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1206,8 +1206,8 @@ ieee80211_link_chanctx_reservation_complete(struct ieee80211_link_data *link)
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_OCB:
-		ieee80211_queue_work(&sdata->local->hw,
-				     &link->csa_finalize_work);
+		wiphy_work_queue(sdata->local->hw.wiphy,
+				 &link->csa_finalize_work);
 		break;
 	case NL80211_IFTYPE_STATION:
 		wiphy_delayed_work_queue(sdata->local->hw.wiphy,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a5569f9bb83f..8d9ced518087 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -990,7 +990,7 @@ struct ieee80211_link_data {
 	struct ieee80211_key __rcu *default_mgmt_key;
 	struct ieee80211_key __rcu *default_beacon_key;
 
-	struct work_struct csa_finalize_work;
+	struct wiphy_work csa_finalize_work;
 	bool csa_block_tx; /* write-protected by sdata_lock and local->mtx */
 
 	bool operating_11g_mode;
@@ -1989,7 +1989,7 @@ int ieee80211_mgmt_tx_cancel_wait(struct wiphy *wiphy,
 				  struct wireless_dev *wdev, u64 cookie);
 
 /* channel switch handling */
-void ieee80211_csa_finalize_work(struct work_struct *work);
+void ieee80211_csa_finalize_work(struct wiphy *wiphy, struct wiphy_work *work);
 int ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 			     struct cfg80211_csa_settings *params);
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 82bb340ef4be..3b419af7720c 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -535,9 +535,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	mutex_unlock(&local->mtx);
 	sdata_unlock(sdata);
 
-	cancel_work_sync(&sdata->deflink.csa_finalize_work);
 	cancel_work_sync(&sdata->deflink.color_change_finalize_work);
 
+	wiphy_work_cancel(local->hw.wiphy, &sdata->deflink.csa_finalize_work);
 	wiphy_delayed_work_cancel(local->hw.wiphy,
 				  &sdata->deflink.dfs_cac_timer_work);
 
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index bcff8a909405..2f7e2fc60be3 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -37,8 +37,8 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	link_conf->link_id = link_id;
 	link_conf->vif = &sdata->vif;
 
-	INIT_WORK(&link->csa_finalize_work,
-		  ieee80211_csa_finalize_work);
+	wiphy_work_init(&link->csa_finalize_work,
+			ieee80211_csa_finalize_work);
 	INIT_WORK(&link->color_change_finalize_work,
 		  ieee80211_color_change_finalize_work);
 	INIT_DELAYED_WORK(&link->color_collision_detect_work,
-- 
2.41.0

