Return-Path: <linux-wireless+bounces-28763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B53B4C468E9
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23B394EC1DC
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1153217B43F;
	Mon, 10 Nov 2025 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzcPoeVA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17471BE5E
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777112; cv=none; b=sIYf2pU1rcMMrwLDHIbQbNb0fpecOQ5lRttSR5q37V8/m6zp41WAqim46EQOVQCTUFkezm8rCu28LHMuqlB7yGQ57SUq0S+uUwHub73TxF7VLNuEtxAmAKKTBz2NRU2mExvExpuxrx8pH+QkKy+GDO1DMF6ETfDvDid+KXItq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777112; c=relaxed/simple;
	bh=CZhGG1RJyWuHckuvypldoMczE1vlVi/nFGI7Yed7YIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gWrf2SGDmFVYnQ9hA/WggtJQW1WRcWrC4jHq5b/UWBpHizoGlDqJO981iNvzq9oaQXFezkO1irm7nDQAKyr3sC3KIzirvZb31sPAVisqbZkOXDDKpmy864jnacqu5f55BkgW+Lc9HbxrYbzVWPIAXCiDyUXHpMeuD73gfXAU3fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzcPoeVA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762777110; x=1794313110;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CZhGG1RJyWuHckuvypldoMczE1vlVi/nFGI7Yed7YIM=;
  b=mzcPoeVAx9LBExQljdDObSGVUrGOpUscmpwXy7d/Zy3G9kKUk1DloAtk
   6f+qdmAQM7CnIjxGRIKZtwx/C6worcx5oJHtk2KBJj7TwdUW/mVMzr6h4
   FRttnnTwQ/SwAeut1OWAVudDcmbkC8C8re5S7v5GIRWf4RV8hD05wl75t
   aJ/CQaV1Doywqti6OuPaujDdFyIF7w5SDm0/8+38SJYGN4N46jMo+27DS
   5iVnpYNW7XHZgBcBnIdqjwG9vpBuAu6/hakfiY94oMIgJi80w6JZb8DdF
   lZGOcUofNeSCtBCi0zRxAkiGKeYft5+yjdNEBRRVGA3WHs2pA25LK41FI
   w==;
X-CSE-ConnectionGUID: LPU1OsJ8RIexdEPGOjM+dQ==
X-CSE-MsgGUID: rFEslcXWQci+ToUiebdXuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="75510937"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="75510937"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:18:29 -0800
X-CSE-ConnectionGUID: D3DCkF3oTUGVEjAiO1xzUQ==
X-CSE-MsgGUID: Qet70XjVR3KsutNln/+vDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="193670475"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:18:27 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: track MU-MIMO configuration on disabled interfaces
Date: Mon, 10 Nov 2025 14:18:20 +0200
Message-Id: <20251110141514.677915f8f6bb.If4e04a57052f9ca763562a67248b06fd80d0c2c1@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

For monitoring, userspace will try to configure the VIF sdata, while the
driver may see the monitor_sdata that is created when only monitor
interfaces are up. This causes the odd situation that it may not be
possible to store the MU-MIMO configuration on monitor_sdata.

Fix this by storing that information on the VIF sdata and updating the
monitor_sdata when available and the interface is up. Also, adjust the
code that adds monitor_sdata so that it will configure MU-MIMO based on
the newly added interface or one of the existing ones.

This should give a mostly consistent behaviour when configuring MU-MIMO
on sniffer interfaces. Should the user configure MU-MIMO on multiple
sniffer interfaces, then mac80211 will simply select one of the
configurations. This behaviour should be good enough and avoids breaking
user expectations in the common scenarios.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c         | 47 ++++++++++++++++++++++++++------------
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/iface.c       | 46 ++++++++++++++++++++++++++++++++-----
 net/mac80211/util.c        |  3 ++-
 4 files changed, 76 insertions(+), 23 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c52b0456039d..b51c2c8584ae 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -63,12 +63,14 @@ static void ieee80211_set_mu_mimo_follow(struct ieee80211_sub_if_data *sdata,
 		memcpy(sdata->vif.bss_conf.mu_group.position,
 		       params->vht_mumimo_groups + WLAN_MEMBERSHIP_LEN,
 		       WLAN_USER_POSITION_LEN);
-		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
-						  BSS_CHANGED_MU_GROUPS);
+
 		/* don't care about endianness - just check for 0 */
 		memcpy(&membership, params->vht_mumimo_groups,
 		       WLAN_MEMBERSHIP_LEN);
 		mu_mimo_groups = membership != 0;
+
+		/* Unset following if configured explicitly */
+		eth_broadcast_addr(sdata->u.mntr.mu_follow_addr);
 	}
 
 	if (params->vht_mumimo_follow_addr) {
@@ -76,16 +78,26 @@ static void ieee80211_set_mu_mimo_follow(struct ieee80211_sub_if_data *sdata,
 			is_valid_ether_addr(params->vht_mumimo_follow_addr);
 		ether_addr_copy(sdata->u.mntr.mu_follow_addr,
 				params->vht_mumimo_follow_addr);
+
+		/* Unset current membership until a management frame is RXed */
+		memset(sdata->vif.bss_conf.mu_group.membership, 0,
+		       WLAN_MEMBERSHIP_LEN);
 	}
 
 	sdata->vif.bss_conf.mu_mimo_owner = mu_mimo_groups || mu_mimo_follow;
+
+	/* Notify only after setting mu_mimo_owner */
+	if (sdata->vif.bss_conf.mu_mimo_owner &&
+	    sdata->flags & IEEE80211_SDATA_IN_DRIVER)
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_MU_GROUPS);
 }
 
 static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 				     struct vif_params *params)
 {
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_sub_if_data *monitor_sdata;
+	struct ieee80211_sub_if_data *monitor_sdata = NULL;
 
 	/* check flags first */
 	if (params->flags && ieee80211_sdata_running(sdata)) {
@@ -103,23 +115,28 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 			return -EBUSY;
 	}
 
-	/* also validate MU-MIMO change */
-	if (ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
-		monitor_sdata = sdata;
-	else
-		monitor_sdata = wiphy_dereference(local->hw.wiphy,
-						  local->monitor_sdata);
-
-	if (!monitor_sdata &&
+	/* validate whether MU-MIMO can be configured */
+	if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF) &&
+	    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR) &&
 	    (params->vht_mumimo_groups || params->vht_mumimo_follow_addr))
 		return -EOPNOTSUPP;
 
+	/* Also update dependent monitor_sdata if required */
+	if (test_bit(SDATA_STATE_RUNNING, &sdata->state) &&
+	    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
+		monitor_sdata = wiphy_dereference(local->hw.wiphy,
+						  local->monitor_sdata);
+
 	/* apply all changes now - no failures allowed */
 
-	if (monitor_sdata &&
-		(ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF) ||
-		 ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)))
-		ieee80211_set_mu_mimo_follow(monitor_sdata, params);
+	if (ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF) ||
+	    ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)) {
+		/* This is copied in when the VIF is activated */
+		ieee80211_set_mu_mimo_follow(sdata, params);
+
+		if (monitor_sdata)
+			ieee80211_set_mu_mimo_follow(monitor_sdata, params);
+	}
 
 	if (params->flags) {
 		if (ieee80211_sdata_running(sdata)) {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 878c3b14aeb8..cde30afa437b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2107,7 +2107,8 @@ void ieee80211_adjust_monitor_flags(struct ieee80211_sub_if_data *sdata,
 				    const int offset);
 int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up);
 void ieee80211_sdata_stop(struct ieee80211_sub_if_data *sdata);
-int ieee80211_add_virtual_monitor(struct ieee80211_local *local);
+int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
+				  struct ieee80211_sub_if_data *creator_sdata);
 void ieee80211_del_virtual_monitor(struct ieee80211_local *local);
 
 bool __ieee80211_recalc_txpower(struct ieee80211_link_data *link);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index a7873832d4fa..d7a4f203cde4 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -733,8 +733,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	ieee80211_configure_filter(local);
 	ieee80211_hw_config(local, -1, hw_reconf_flags);
 
+	/* Passing NULL means an interface is picked for configuration */
 	if (local->virt_monitors == local->open_count)
-		ieee80211_add_virtual_monitor(local);
+		ieee80211_add_virtual_monitor(local, NULL);
 }
 
 void ieee80211_stop_mbssid(struct ieee80211_sub_if_data *sdata)
@@ -1168,7 +1169,8 @@ static void ieee80211_sdata_init(struct ieee80211_local *local,
 	ieee80211_link_init(sdata, -1, &sdata->deflink, &sdata->vif.bss_conf);
 }
 
-int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
+int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
+				  struct ieee80211_sub_if_data *creator_sdata)
 {
 	struct ieee80211_sub_if_data *sdata;
 	int ret;
@@ -1176,10 +1178,14 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	ASSERT_RTNL();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (local->monitor_sdata ||
-	    ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
+	if (ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
 		return 0;
 
+	/* Already have a monitor set up, configure it */
+	sdata = wiphy_dereference(local->hw.wiphy, local->monitor_sdata);
+	if (sdata)
+		goto configure_monitor;
+
 	sdata = kzalloc(sizeof(*sdata) + local->hw.vif_data_size, GFP_KERNEL);
 	if (!sdata)
 		return -ENOMEM;
@@ -1232,6 +1238,32 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	skb_queue_head_init(&sdata->status_queue);
 	wiphy_work_init(&sdata->work, ieee80211_iface_work);
 
+configure_monitor:
+	/* Copy in the MU-MIMO configuration if set */
+	if (!creator_sdata) {
+		struct ieee80211_sub_if_data *other;
+
+		list_for_each_entry(other, &local->mon_list, list) {
+			if (!other->vif.bss_conf.mu_mimo_owner)
+				continue;
+
+			creator_sdata = other;
+			break;
+		}
+	}
+
+	if (creator_sdata && creator_sdata->vif.bss_conf.mu_mimo_owner) {
+		sdata->vif.bss_conf.mu_mimo_owner = true;
+		memcpy(&sdata->vif.bss_conf.mu_group,
+		       &creator_sdata->vif.bss_conf.mu_group,
+		       sizeof(sdata->vif.bss_conf.mu_group));
+		memcpy(&sdata->u.mntr.mu_follow_addr,
+		       creator_sdata->u.mntr.mu_follow_addr, ETH_ALEN);
+
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_MU_GROUPS);
+	}
+
 	return 0;
 }
 
@@ -1388,11 +1420,13 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			if (res)
 				goto err_stop;
 		} else {
-			if (local->virt_monitors == 0 && local->open_count == 0) {
-				res = ieee80211_add_virtual_monitor(local);
+			/* add/configure if there is no non-monitor interface */
+			if (local->virt_monitors == local->open_count) {
+				res = ieee80211_add_virtual_monitor(local, sdata);
 				if (res)
 					goto err_stop;
 			}
+
 			local->virt_monitors++;
 
 			/* must be before the call to ieee80211_configure_filter */
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c9931537f9d2..174e685b3f0d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2206,9 +2206,10 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		}
 	}
 
+	/* Passing NULL means an interface is picked for configuration */
 	if (local->virt_monitors > 0 &&
 	    local->virt_monitors == local->open_count)
-		ieee80211_add_virtual_monitor(local);
+		ieee80211_add_virtual_monitor(local, NULL);
 
 	if (!suspended)
 		return 0;
-- 
2.34.1


