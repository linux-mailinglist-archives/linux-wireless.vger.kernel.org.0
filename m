Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE5378AF97
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjH1MGP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjH1MFp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B5212E
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=265FR2E3S24pGK6dopwqDUavAr//An1rP7QRVpC6IGo=;
        t=1693224340; x=1694433940; b=HFS4w0XR4y+zxvJ07IWg3bhiU/HI8kl7jMBtlDekSrcDvJ+
        oRf7SiQSMTgOol5btWoaZtv2hlloQ87BKr/BBdJEUvyIDscoylaNr5zsJwAN3ghIZRK+DQrCqxJB3
        lxAiSYWgsZvKQlN43a3BBXmHKn6SjO3apGBiJlvPXy7G6fKmxpXAr6/lBucGcTfqtRk7T+Xef5W9E
        w+j4d3mLcnzmYRrdYNBSJd/hbM2zoEagsfTmaLdMQvZD4N6Ay2AZZNewlhY+qpHEKDB2mHA5oUBF0
        SWmOFITsvgLYtKGhjNdCobftc7Yv6UwWLsnNib5sOO20Rn/K2/gUYqUqlUOpbj5w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazy-00Gjgt-12;
        Mon, 28 Aug 2023 14:05:38 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 23/40] wifi: mac80211: move color change finalize to wiphy work
Date:   Mon, 28 Aug 2023 13:59:51 +0200
Message-ID: <20230828135928.bbe8f464c752.Icc6035f9732d73c7b91e36d2518866be10627782@changeid>
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

Again this should be per link and will get cancellation
issues, move it to a wiphy work.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         | 7 ++++---
 net/mac80211/ieee80211_i.h | 5 +++--
 net/mac80211/iface.c       | 4 ++--
 net/mac80211/link.c        | 4 ++--
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 8c7e6f637a1e..d3fc6a2d1454 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4742,7 +4742,8 @@ static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
 	return 0;
 }
 
-void ieee80211_color_change_finalize_work(struct work_struct *work)
+void ieee80211_color_change_finalize_work(struct wiphy *wiphy,
+					  struct wiphy_work *work)
 {
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data,
@@ -4783,8 +4784,8 @@ void ieee80211_color_change_finish(struct ieee80211_vif *vif)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 
-	ieee80211_queue_work(&sdata->local->hw,
-			     &sdata->deflink.color_change_finalize_work);
+	wiphy_work_queue(sdata->local->hw.wiphy,
+			 &sdata->deflink.color_change_finalize_work);
 }
 EXPORT_SYMBOL_GPL(ieee80211_color_change_finish);
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8d9ced518087..8d53ab9732f9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -997,7 +997,7 @@ struct ieee80211_link_data {
 
 	struct cfg80211_chan_def csa_chandef;
 
-	struct work_struct color_change_finalize_work;
+	struct wiphy_work color_change_finalize_work;
 	struct delayed_work color_collision_detect_work;
 	u64 color_bitmap;
 
@@ -1994,7 +1994,8 @@ int ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 			     struct cfg80211_csa_settings *params);
 
 /* color change handling */
-void ieee80211_color_change_finalize_work(struct work_struct *work);
+void ieee80211_color_change_finalize_work(struct wiphy *wiphy,
+					  struct wiphy_work *work);
 void ieee80211_color_collision_detection_work(struct work_struct *work);
 
 /* interface handling */
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 3b419af7720c..e09fec1507a6 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -535,9 +535,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	mutex_unlock(&local->mtx);
 	sdata_unlock(sdata);
 
-	cancel_work_sync(&sdata->deflink.color_change_finalize_work);
-
 	wiphy_work_cancel(local->hw.wiphy, &sdata->deflink.csa_finalize_work);
+	wiphy_work_cancel(local->hw.wiphy,
+			  &sdata->deflink.color_change_finalize_work);
 	wiphy_delayed_work_cancel(local->hw.wiphy,
 				  &sdata->deflink.dfs_cac_timer_work);
 
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 2f7e2fc60be3..72b5000502a5 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -39,8 +39,8 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 
 	wiphy_work_init(&link->csa_finalize_work,
 			ieee80211_csa_finalize_work);
-	INIT_WORK(&link->color_change_finalize_work,
-		  ieee80211_color_change_finalize_work);
+	wiphy_work_init(&link->color_change_finalize_work,
+			ieee80211_color_change_finalize_work);
 	INIT_DELAYED_WORK(&link->color_collision_detect_work,
 			  ieee80211_color_collision_detection_work);
 	INIT_LIST_HEAD(&link->assigned_chanctx_list);
-- 
2.41.0

