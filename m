Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C30139F279
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhFHJeb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 05:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhFHJe3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 05:34:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF4DC06178B
        for <linux-wireless@vger.kernel.org>; Tue,  8 Jun 2021 02:32:36 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lqY66-003gsH-JG; Tue, 08 Jun 2021 11:32:34 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/4] mac80211: move interface shutdown out of wiphy lock
Date:   Tue,  8 Jun 2021 11:32:30 +0200
Message-Id: <20210608113226.78233c80f548.Iecc104aceb89f0568f50e9670a9cb191a1c8887b@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608113226.14020430e449.I78e19db0a55a8295a376e15ac4cf77dbb4c6fb51@changeid>
References: <20210608113226.14020430e449.I78e19db0a55a8295a376e15ac4cf77dbb4c6fb51@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When reconfiguration fails, we shut down everything, but we
cannot call cfg80211_shutdown_all_interfaces() with the wiphy
mutex held. Since cfg80211 now calls it on resume errors, we
only need to do likewise for where we call reconfig (whether
directly or indirectly), but not under the wiphy lock.

Fixes: 2fe8ef106238 ("cfg80211: change netdev registration/unregistration semantics")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/debugfs.c | 7 ++++++-
 net/mac80211/main.c    | 7 ++++++-
 net/mac80211/util.c    | 2 --
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index b5ff61b6448a..fc34ae2b604c 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -387,12 +387,17 @@ static ssize_t reset_write(struct file *file, const char __user *user_buf,
 			   size_t count, loff_t *ppos)
 {
 	struct ieee80211_local *local = file->private_data;
+	int ret;
 
 	rtnl_lock();
 	wiphy_lock(local->hw.wiphy);
 	__ieee80211_suspend(&local->hw, NULL);
-	__ieee80211_resume(&local->hw);
+	ret = __ieee80211_resume(&local->hw);
 	wiphy_unlock(local->hw.wiphy);
+
+	if (ret)
+		cfg80211_shutdown_all_interfaces(local->hw.wiphy);
+
 	rtnl_unlock();
 
 	return count;
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 62145e5f9628..f33a3acd7f96 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -252,6 +252,7 @@ static void ieee80211_restart_work(struct work_struct *work)
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local, restart_work);
 	struct ieee80211_sub_if_data *sdata;
+	int ret;
 
 	/* wait for scan work complete */
 	flush_workqueue(local->workqueue);
@@ -301,8 +302,12 @@ static void ieee80211_restart_work(struct work_struct *work)
 	/* wait for all packet processing to be done */
 	synchronize_net();
 
-	ieee80211_reconfig(local);
+	ret = ieee80211_reconfig(local);
 	wiphy_unlock(local->hw.wiphy);
+
+	if (ret)
+		cfg80211_shutdown_all_interfaces(local->hw.wiphy);
+
 	rtnl_unlock();
 }
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0a0481f5af48..93d96a4f9c3e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2178,8 +2178,6 @@ static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
 	list_for_each_entry(ctx, &local->chanctx_list, list)
 		ctx->driver_present = false;
 	mutex_unlock(&local->chanctx_mtx);
-
-	cfg80211_shutdown_all_interfaces(local->hw.wiphy);
 }
 
 static void ieee80211_assign_chanctx(struct ieee80211_local *local,
-- 
2.31.1

