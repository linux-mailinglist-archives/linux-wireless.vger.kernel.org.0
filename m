Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFC45F54D5
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJENA7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJENAz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DFA1EEC4
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4DrVks/oLCHsvAvq6VmANYpykKV+vXjQxwOHB0WGXzg=;
        t=1664974853; x=1666184453; b=XfE4+anMungqnaEA2DE56fuQtzea58xeB6pgKAejT+AMt96
        PUO37qyKXqVUMUnNKhyKvEausT9NbrjmdsyERC4ekWo1u/YUupcpURiboQZFhnWXhy0/FcL8mUNQ0
        EhFAtkA6iazbQG4HiJ5X91Htr9FsI9omYz1KcCJrIcKAlMwRPpptmfqKXVrUgzU+4SXN9Be04NZ0r
        91szTlIIb4+ongks8DykFW92fKMuvihPDd47UW4HGMilme/MU4AB6bIm1gebX57xPJngNN+WzgrNk
        CKBNVXUuGvB5jIsntKWtkctXQeoMHBq4lRQKj0R7kI8i58spBPWuaeFheluwmVyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og415-00G2RL-1g;
        Wed, 05 Oct 2022 15:00:51 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/28] wifi: mac80211: recalc station aggregate data during link switch
Date:   Wed,  5 Oct 2022 15:00:24 +0200
Message-Id: <20221005145226.0605ef900411.I9354dd019bc87dc98e10b036a03fac844e547ad8@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

During link switching, the active links change, so we need to
recalculate the aggregate data in the stations.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/link.c     | 17 +++++++++++++++++
 net/mac80211/sta_info.c | 33 ++++++++++++++++++++++++---------
 net/mac80211/sta_info.h |  2 ++
 3 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index e309708abae8..d1f5a9f7c647 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -357,6 +357,11 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 	list_for_each_entry(sta, &local->sta_list, list) {
 		if (sdata != sta->sdata)
 			continue;
+
+		/* this is very temporary, but do it anyway */
+		__ieee80211_sta_recalc_aggregates(sta,
+						  old_active | active_links);
+
 		ret = drv_change_sta_links(local, sdata, &sta->sta,
 					   old_active,
 					   old_active | active_links);
@@ -369,10 +374,22 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 	list_for_each_entry(sta, &local->sta_list, list) {
 		if (sdata != sta->sdata)
 			continue;
+
+		__ieee80211_sta_recalc_aggregates(sta, active_links);
+
 		ret = drv_change_sta_links(local, sdata, &sta->sta,
 					   old_active | active_links,
 					   active_links);
 		WARN_ON_ONCE(ret);
+
+		/*
+		 * Do it again, just in case - the driver might very
+		 * well have called ieee80211_sta_recalc_aggregates()
+		 * from there when filling in the new links, which
+		 * would set it wrong since the vif's active links are
+		 * not switched yet...
+		 */
+		__ieee80211_sta_recalc_aggregates(sta, active_links);
 	}
 
 	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index e6beaea4075e..2bb6a71c72ef 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2151,22 +2151,30 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 }
 EXPORT_SYMBOL(ieee80211_sta_register_airtime);
 
-void ieee80211_sta_recalc_aggregates(struct ieee80211_sta *pubsta)
+void __ieee80211_sta_recalc_aggregates(struct sta_info *sta, u16 active_links)
 {
-	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
-	struct ieee80211_link_sta *link_sta;
-	int link_id, i;
 	bool first = true;
+	int link_id;
 
-	if (!pubsta->valid_links || !pubsta->mlo) {
-		pubsta->cur = &pubsta->deflink.agg;
+	if (!sta->sta.valid_links || !sta->sta.mlo) {
+		sta->sta.cur = &sta->sta.deflink.agg;
 		return;
 	}
 
 	rcu_read_lock();
-	for_each_sta_active_link(&sta->sdata->vif, pubsta, link_sta, link_id) {
+	for (link_id = 0; link_id < ARRAY_SIZE((sta)->link); link_id++) {
+		struct ieee80211_link_sta *link_sta;
+		int i;
+
+		if (!(active_links & BIT(link_id)))
+			continue;
+
+		link_sta = rcu_dereference(sta->sta.link[link_id]);
+		if (!link_sta)
+			continue;
+
 		if (first) {
-			sta->cur = pubsta->deflink.agg;
+			sta->cur = sta->sta.deflink.agg;
 			first = false;
 			continue;
 		}
@@ -2185,7 +2193,14 @@ void ieee80211_sta_recalc_aggregates(struct ieee80211_sta *pubsta)
 	}
 	rcu_read_unlock();
 
-	pubsta->cur = &sta->cur;
+	sta->sta.cur = &sta->cur;
+}
+
+void ieee80211_sta_recalc_aggregates(struct ieee80211_sta *pubsta)
+{
+	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
+
+	__ieee80211_sta_recalc_aggregates(sta, sta->sdata->vif.active_links);
 }
 EXPORT_SYMBOL(ieee80211_sta_recalc_aggregates);
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 6e672bf9c79d..69820b551668 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -927,6 +927,8 @@ void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
 					   const u8 *ext_capab,
 					   unsigned int ext_capab_len);
 
+void __ieee80211_sta_recalc_aggregates(struct sta_info *sta, u16 active_links);
+
 enum sta_stats_type {
 	STA_STATS_RATE_TYPE_INVALID = 0,
 	STA_STATS_RATE_TYPE_LEGACY,
-- 
2.37.3

