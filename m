Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B9F7D9E34
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 18:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjJ0Quq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Oct 2023 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ0Qup (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Oct 2023 12:50:45 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E3211B
        for <linux-wireless@vger.kernel.org>; Fri, 27 Oct 2023 09:50:42 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id AC778A8005E
        for <linux-wireless@vger.kernel.org>; Fri, 27 Oct 2023 16:50:39 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id B379D13C2B0;
        Fri, 27 Oct 2023 09:50:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B379D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698425438;
        bh=xc7uDJBAqrIHtUMtodkTs5hXuH0cFO9TaShM3pA4wLk=;
        h=From:To:Cc:Subject:Date:From;
        b=CpYY15+HIrvPRj3d/i2O5H8oYxs9LouZHXO9IvksdP6LjRADjRtTa8onZwGQ2C3m0
         pi9kfGA0RKYxFF65QpWYBdEQN5Xn+PzRPqSB1ZjccW1YxLFHvBjKOb6ysdFt6m5LAG
         fmjcg/DtXGcRge/6QiHxWurqX9PkdAzDvWFUdO1I=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v3] wifi: mac80211: ethtool: use best available link for default stats.
Date:   Fri, 27 Oct 2023 09:50:35 -0700
Message-Id: <20231027165035.243720-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1698425440-E0FHjCYuIHcy
X-MDID-O: us5;ut7;1698425440;E0FHjCYuIHcy;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Best link is the link with the highest state (ie, associated)
and if multiple links have same state, the highest
frequency wins.

This makes current ethtool stats more useful.  Per-link
ethtool stats can be added later.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v3:  Fix glaring bug in ieee80211_find_best_sta_link that would
have crashed on 2+ links.

Re-work locking slightly in ethtool.c:  Cannot hold rcu_read_lock
while calling sta_set_sinfo.  I'm hoping the wiphy_lock means that
link and/or sta cannot go away while this method is being traversed,
otherwise the rcu read lock/unlock around ieee80211_find_best_sta_link
is probably not sufficient.

 net/mac80211/ethtool.c  | 12 +++++++--
 net/mac80211/link.c     | 56 +++++++++++++++++++++++++++++++++++++++++
 net/mac80211/sta_info.h |  4 +++
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index 99f6174a9d69..3d12111996e5 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -83,6 +83,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 	struct ieee80211_local *local = sdata->local;
 	struct station_info sinfo;
 	struct survey_info survey;
+	struct ieee80211_link_data *link = NULL;
 	int i, q;
 #define STA_STATS_SURVEY_LEN 7
 
@@ -112,12 +113,17 @@ static void ieee80211_get_stats(struct net_device *dev,
 	wiphy_lock(local->hw.wiphy);
 
 	if (sdata->vif.type == NL80211_IFTYPE_STATION) {
-		sta = sta_info_get_bss(sdata, sdata->deflink.u.mgd.bssid);
+		rcu_read_lock();
+		sta = ieee80211_find_best_sta_link(sdata, &link);
+		rcu_read_unlock();
 
 		if (!(sta && !WARN_ON(sta->sdata->dev != dev)))
 			goto do_survey;
 
 		memset(&sinfo, 0, sizeof(sinfo));
+		/* sta_set_sinfo cannot hold rcu read lock since it can block
+		 * calling into firmware for stats.
+		 */
 		sta_set_sinfo(sta, &sinfo, false);
 
 		i = 0;
@@ -158,7 +164,9 @@ static void ieee80211_get_stats(struct net_device *dev,
 
 	rcu_read_lock();
 	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
-	if (chanctx_conf)
+	if (link)
+		channel = link->conf->chandef.chan;
+	else if (chanctx_conf)
 		channel = chanctx_conf->def.chan;
 	else
 		channel = NULL;
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index bf7bd880d062..2dc0f46ee053 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -115,6 +115,62 @@ static void ieee80211_free_links(struct ieee80211_sub_if_data *sdata,
 		kfree(links[link_id]);
 }
 
+/* For cases where we need a link for stats and such, and just want
+ * a 'good' one.
+ */
+struct sta_info *
+ieee80211_find_best_sta_link(struct ieee80211_sub_if_data *sdata,
+			     struct ieee80211_link_data **link)
+{
+	struct ieee80211_link_data *best_link = NULL;
+	struct sta_info *best_sta = NULL;
+	int i;
+
+	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+		struct ieee80211_link_data *link1;
+		struct sta_info *sta1;
+		bool sta1_better = false;
+
+		link1 = sdata_dereference(sdata->link[i], sdata);
+		if (!link1)
+			continue;
+		if (!best_link) {
+			best_link = link1;
+			best_sta = sta_info_get_bss(sdata, best_link->u.mgd.bssid);
+			continue;
+		}
+
+		sta1 = sta_info_get_bss(sdata, link1->u.mgd.bssid);
+		if (!sta1)
+			continue;
+
+		/* we have two potential best links, find one we like best. */
+		if (!best_sta || sta1->sta_state > best_sta->sta_state) {
+			sta1_better = true;
+		} else if (sta1->sta_state == best_sta->sta_state) {
+			u32 freq_best = 0;
+			u32 freq1 = 0;
+
+			if (best_link->conf->chandef.chan)
+				freq_best = best_link->conf->chandef.chan->center_freq;
+			if (link1->conf->chandef.chan)
+				freq1 = link1->conf->chandef.chan->center_freq;
+			if (freq1 > freq_best)
+				sta1_better = true;
+		}
+
+		if (sta1_better) {
+			best_sta = sta1;
+			best_link = link1;
+		}
+	}
+
+	*link = best_link;
+	if (best_link)
+		return sta_info_get_bss(sdata, best_link->u.mgd.bssid);
+	return sta_info_get_bss(sdata, sdata->deflink.u.mgd.bssid);
+}
+
 static int ieee80211_check_dup_link_addrs(struct ieee80211_sub_if_data *sdata)
 {
 	unsigned int i, j;
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 7acf2223e47a..c57380b622e6 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -929,6 +929,10 @@ void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
 
 void __ieee80211_sta_recalc_aggregates(struct sta_info *sta, u16 active_links);
 
+struct sta_info *
+ieee80211_find_best_sta_link(struct ieee80211_sub_if_data *sdata,
+			     struct ieee80211_link_data **link);
+
 enum sta_stats_type {
 	STA_STATS_RATE_TYPE_INVALID = 0,
 	STA_STATS_RATE_TYPE_LEGACY,
-- 
2.40.0

