Return-Path: <linux-wireless+bounces-7239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC4D8BD53F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8080283086
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A106115821F;
	Mon,  6 May 2024 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jkOrm4Hh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1863D15572C
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022798; cv=none; b=U3FrkZjZFkuObj9dQfWVSBscsWxBCst6P68tHAcg7qgutGzSmbBVJ+AHT8rEMlpM2DnGZfiWqrx0MmEvRyLziWfKxpqDgMox9WJGw5Eh2XatW2UT77OF0bueOTQ0FErQu8m1Gm91ZRnhezOrP7Am2+YZKlqOrgZOR8NXvELgYpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022798; c=relaxed/simple;
	bh=k+ma0tzUjEjDl1M5LDhaETcztR79r+pNLcGVl1dqxkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VOC1iY3Etvr8kL7o3msSt62aiIH7zj8aFzEwELT5iOocsNpOhLwe4ANDweKbyDzq2/VrfHXOxEfvJnd3j4m0xfOxEr5r6Slf5FSw016SZ/atPRkmcE8HKnJ/r1zjAZ7v4idXf2hPA68NHnvFx6wp0sfKA+t0hmEwDAwWsaoEjP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jkOrm4Hh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=KrN2K6zKpRrOCNF2Xk1wQSCpKoxp6meRBmJRZFchyLI=; t=1715022797; x=1716232397; 
	b=jkOrm4Hh6wHbW9yNg3bNO7IuUc1fNRf/4fnaZ5qJG/XF/HH7sg18uv+mWl9fPxRorAe/Vd26rQW
	48/BcSR0Vzj4vfz8fIWLgkAdDh2CHtTO7BIaCKgc6LwK7BBUJRv8zt5SjcLiUCenUSaUkrxHZfTiH
	ZqKnU/u2OkiwHUFdIuOjiGvaRokH+G5pefgXqAi8s1bw92UaowfYe1xXugndCD11VfMDcoIhi02b/
	6D8XyQabn65QoOPxVAa+QUhaQuhLHGCR3LVNDuzg2qp+A4oNrQ72S8GOLxdpVTK0tJsp7W8Ka6zhk
	l7hp06+djTuw3eMg5DWz9HCj4B1BmeSPcH+A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s43lx-000000089xJ-31N9;
	Mon, 06 May 2024 21:13:14 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: move radar detect work to sdata
Date: Mon,  6 May 2024 21:13:12 +0200
Message-ID: <20240506211311.43bd82c6da04.Ib39bec3aa198d137385f081e7e1910dcbde3aa1b@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

At some point we thought perhaps this could be per link, but
really that didn't happen, and it's confusing. Radar detection
still uses the deflink to allocate the channel, but the work
need not be there. Move it back.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         | 6 +++---
 net/mac80211/ieee80211_i.h | 3 ++-
 net/mac80211/iface.c       | 4 +++-
 net/mac80211/link.c        | 2 --
 net/mac80211/mlme.c        | 9 ++++-----
 net/mac80211/util.c        | 2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b08e5d7687e3..76c26de5da13 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1666,7 +1666,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	if (sdata->wdev.cac_started) {
 		chandef = link_conf->chanreq.oper;
-		wiphy_delayed_work_cancel(wiphy, &link->dfs_cac_timer_work);
+		wiphy_delayed_work_cancel(wiphy, &sdata->dfs_cac_timer_work);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_ABORTED,
 				   GFP_KERNEL);
@@ -3466,7 +3466,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	if (err)
 		goto out_unlock;
 
-	wiphy_delayed_work_queue(wiphy, &sdata->deflink.dfs_cac_timer_work,
+	wiphy_delayed_work_queue(wiphy, &sdata->dfs_cac_timer_work,
 				 msecs_to_jiffies(cac_time_ms));
 
  out_unlock:
@@ -3487,7 +3487,7 @@ static void ieee80211_end_cac(struct wiphy *wiphy,
 		 * will no longer be true
 		 */
 		wiphy_delayed_work_cancel(wiphy,
-					  &sdata->deflink.dfs_cac_timer_work);
+					  &sdata->dfs_cac_timer_work);
 
 		if (sdata->wdev.cac_started) {
 			ieee80211_link_release_channel(&sdata->deflink);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index eb62b7d4b4f7..d51aa96f2948 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1059,7 +1059,6 @@ struct ieee80211_link_data {
 	int ap_power_level; /* in dBm */
 
 	bool radar_required;
-	struct wiphy_delayed_work dfs_cac_timer_work;
 
 	union {
 		struct ieee80211_link_data_managed mgd;
@@ -1158,6 +1157,8 @@ struct ieee80211_sub_if_data {
 	struct ieee80211_link_data deflink;
 	struct ieee80211_link_data __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
+	struct wiphy_delayed_work dfs_cac_timer_work;
+
 	/* for ieee80211_set_active_links_async() */
 	struct wiphy_work activate_links_work;
 	u16 desired_active_links;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index dc42902e2693..1ef4b6dc3730 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -554,7 +554,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	wiphy_work_cancel(local->hw.wiphy,
 			  &sdata->deflink.color_change_finalize_work);
 	wiphy_delayed_work_cancel(local->hw.wiphy,
-				  &sdata->deflink.dfs_cac_timer_work);
+				  &sdata->dfs_cac_timer_work);
 
 	if (sdata->wdev.cac_started) {
 		chandef = sdata->vif.bss_conf.chanreq.oper;
@@ -1746,6 +1746,8 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	wiphy_work_init(&sdata->work, ieee80211_iface_work);
 	wiphy_work_init(&sdata->activate_links_work,
 			ieee80211_activate_links_work);
+	wiphy_delayed_work_init(&sdata->dfs_cac_timer_work,
+				ieee80211_dfs_cac_timer_work);
 
 	switch (type) {
 	case NL80211_IFTYPE_P2P_GO:
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index af0321408a97..f57282488222 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -45,8 +45,6 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 			  ieee80211_color_collision_detection_work);
 	INIT_LIST_HEAD(&link->assigned_chanctx_list);
 	INIT_LIST_HEAD(&link->reserved_chanctx_list);
-	wiphy_delayed_work_init(&link->dfs_cac_timer_work,
-				ieee80211_dfs_cac_timer_work);
 
 	if (!deflink) {
 		switch (sdata->vif.type) {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a481728d78c7..04a125a9ffd1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2602,16 +2602,15 @@ void ieee80211_dynamic_ps_timer(struct timer_list *t)
 
 void ieee80211_dfs_cac_timer_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
-	struct ieee80211_link_data *link =
-		container_of(work, struct ieee80211_link_data,
+	struct ieee80211_sub_if_data *sdata =
+		container_of(work, struct ieee80211_sub_if_data,
 			     dfs_cac_timer_work.work);
-	struct cfg80211_chan_def chandef = link->conf->chanreq.oper;
-	struct ieee80211_sub_if_data *sdata = link->sdata;
+	struct cfg80211_chan_def chandef = sdata->vif.bss_conf.chanreq.oper;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (sdata->wdev.cac_started) {
-		ieee80211_link_release_channel(link);
+		ieee80211_link_release_channel(&sdata->deflink);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_FINISHED,
 				   GFP_KERNEL);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0b893e958959..30d3efedaa8e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3461,7 +3461,7 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 		 * will no longer be true
 		 */
 		wiphy_delayed_work_cancel(local->hw.wiphy,
-					  &sdata->deflink.dfs_cac_timer_work);
+					  &sdata->dfs_cac_timer_work);
 
 		if (sdata->wdev.cac_started) {
 			chandef = sdata->vif.bss_conf.chanreq.oper;
-- 
2.44.0


