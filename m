Return-Path: <linux-wireless+bounces-33875-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEXcK81QxGljyAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33875-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:17:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 365E132C524
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC1E630704B5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 21:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61474364E89;
	Wed, 25 Mar 2026 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dxc8xhwb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C209B355F2B
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 21:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473356; cv=none; b=FaNT6+50cK6np749LUu7kkpQPngJezEuWNhSnR5VSKFGE5sYwSS5ONIONQXe+ibO3jYUHmjN+szcKjtn5L8oEy0ZrxH5tD53gHe3ol1s501nk2loIzYsizYN/OjIS9jM/rzmqwCmK7QXh9Tji1V+9CDQz7+RuaZhPnhuSeUmgLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473356; c=relaxed/simple;
	bh=1EvB/gwtcw8ihl5ZdquKOr/aNMolNJx9njLnnjsAMyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HtNYQZhPzqORqU+K7MuoSVjamHW5hfiMEAXLurM7fsHrMSiQo4EME2GM2IkDArOp3HpPj+hAO2n/KJNLgcPCRymD8AooFQQlwqMozdvUxAOkZUD1kDbE/ZNPqHLZsGbLxzxNBg8OnLFV1FnD/aERlrdzp9e0UlZmu0JtAWrIYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dxc8xhwb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774473355; x=1806009355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1EvB/gwtcw8ihl5ZdquKOr/aNMolNJx9njLnnjsAMyo=;
  b=dxc8xhwbMOxjukvyy1WXbIstL7g3EnORsZdgiegqfZtWETMmgC1Y8wxP
   u2pjbEiGAkQtU3LEEuFs/9q7LxUudimFqB/H+UFK8gei3t+ClVB6fOmA7
   FHeOLAw8tEpOEOnj0aos2kcCZ1/+5p9Y/1jNs2zDhw6IuCzhJje3iptO0
   gJzLTve8TldYkdPBQg5q6XJkNjSqpWEeWEIkiyDp03EpGysvE3F1A+ji8
   ZvjpVHw3zikqgRWQOFVwJ+kJ1BIAUcYXoD09QwUfe3fZRIKghfmwhXeOX
   5iPI4PL8yAnOAacP7trg0gfAIjmUjSV17kdMZ9gOxznVlrobSuAxK8ezG
   w==;
X-CSE-ConnectionGUID: bL4aJa9LSeudP8aI/mzrAA==
X-CSE-MsgGUID: 9VAFT+pISRKiTEufdPuh2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75485352"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75485352"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:15:55 -0700
X-CSE-ConnectionGUID: +HmJ+QnnTW6cVIK5XwLM1g==
X-CSE-MsgGUID: eBiEGguFRLCgousUJsLsnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224747478"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:15:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 04/15] wifi: mac80211: run NAN DE code only when appropriate
Date: Wed, 25 Mar 2026 23:15:25 +0200
Message-Id: <20260325230443.f0288a283171.Iee24bef3bae2e1d502216192e760c1e699d271c9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325211536.910411-1-miriam.rachel.korenblit@intel.com>
References: <20260325211536.910411-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33875-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 365E132C524
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NAN DE (Discovery Engine) may be handled in the device or in user space.
When handled in user space, all the NAN func management code should not
run. Moreover, devices with user space DE should not provide the
add/del_nan_func callbaks. For such devices, ieee80211_reconfig_nan will
always fail.

Make it clear what parts of ieee80211_if_nan are relevant to DE
management, and touch those only when DE is offloaded.

Add a check that makes sure that a driver doesn't register with
add_del/nan_func callbacks if DE is in user space.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         | 52 ++++++++++++++++++++++++--------------
 net/mac80211/ieee80211_i.h | 13 ++++++----
 net/mac80211/iface.c       | 25 +++++++++++-------
 net/mac80211/main.c        |  4 ++-
 net/mac80211/util.c        | 10 +++++---
 5 files changed, 67 insertions(+), 37 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 13132215afb4..e851668f4ef3 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -502,12 +502,15 @@ static int ieee80211_add_nan_func(struct wiphy *wiphy,
 	if (!ieee80211_sdata_running(sdata))
 		return -ENETDOWN;
 
-	spin_lock_bh(&sdata->u.nan.func_lock);
+	if (WARN_ON(wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE))
+		return -EOPNOTSUPP;
+
+	spin_lock_bh(&sdata->u.nan.de.func_lock);
 
-	ret = idr_alloc(&sdata->u.nan.function_inst_ids,
+	ret = idr_alloc(&sdata->u.nan.de.function_inst_ids,
 			nan_func, 1, sdata->local->hw.max_nan_de_entries + 1,
 			GFP_ATOMIC);
-	spin_unlock_bh(&sdata->u.nan.func_lock);
+	spin_unlock_bh(&sdata->u.nan.de.func_lock);
 
 	if (ret < 0)
 		return ret;
@@ -518,10 +521,10 @@ static int ieee80211_add_nan_func(struct wiphy *wiphy,
 
 	ret = drv_add_nan_func(sdata->local, sdata, nan_func);
 	if (ret) {
-		spin_lock_bh(&sdata->u.nan.func_lock);
-		idr_remove(&sdata->u.nan.function_inst_ids,
+		spin_lock_bh(&sdata->u.nan.de.func_lock);
+		idr_remove(&sdata->u.nan.de.function_inst_ids,
 			   nan_func->instance_id);
-		spin_unlock_bh(&sdata->u.nan.func_lock);
+		spin_unlock_bh(&sdata->u.nan.de.func_lock);
 	}
 
 	return ret;
@@ -534,9 +537,9 @@ ieee80211_find_nan_func_by_cookie(struct ieee80211_sub_if_data *sdata,
 	struct cfg80211_nan_func *func;
 	int id;
 
-	lockdep_assert_held(&sdata->u.nan.func_lock);
+	lockdep_assert_held(&sdata->u.nan.de.func_lock);
 
-	idr_for_each_entry(&sdata->u.nan.function_inst_ids, func, id) {
+	idr_for_each_entry(&sdata->u.nan.de.function_inst_ids, func, id) {
 		if (func->cookie == cookie)
 			return func;
 	}
@@ -555,13 +558,16 @@ static void ieee80211_del_nan_func(struct wiphy *wiphy,
 	    !ieee80211_sdata_running(sdata))
 		return;
 
-	spin_lock_bh(&sdata->u.nan.func_lock);
+	if (WARN_ON(wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE))
+		return;
+
+	spin_lock_bh(&sdata->u.nan.de.func_lock);
 
 	func = ieee80211_find_nan_func_by_cookie(sdata, cookie);
 	if (func)
 		instance_id = func->instance_id;
 
-	spin_unlock_bh(&sdata->u.nan.func_lock);
+	spin_unlock_bh(&sdata->u.nan.de.func_lock);
 
 	if (instance_id)
 		drv_del_nan_func(sdata->local, sdata, instance_id);
@@ -4888,18 +4894,22 @@ void ieee80211_nan_func_terminated(struct ieee80211_vif *vif,
 	if (WARN_ON(vif->type != NL80211_IFTYPE_NAN))
 		return;
 
-	spin_lock_bh(&sdata->u.nan.func_lock);
+	if (WARN_ON(sdata->local->hw.wiphy->nan_capa.flags &
+		    WIPHY_NAN_FLAGS_USERSPACE_DE))
+		return;
+
+	spin_lock_bh(&sdata->u.nan.de.func_lock);
 
-	func = idr_find(&sdata->u.nan.function_inst_ids, inst_id);
+	func = idr_find(&sdata->u.nan.de.function_inst_ids, inst_id);
 	if (WARN_ON(!func)) {
-		spin_unlock_bh(&sdata->u.nan.func_lock);
+		spin_unlock_bh(&sdata->u.nan.de.func_lock);
 		return;
 	}
 
 	cookie = func->cookie;
-	idr_remove(&sdata->u.nan.function_inst_ids, inst_id);
+	idr_remove(&sdata->u.nan.de.function_inst_ids, inst_id);
 
-	spin_unlock_bh(&sdata->u.nan.func_lock);
+	spin_unlock_bh(&sdata->u.nan.de.func_lock);
 
 	cfg80211_free_nan_func(func);
 
@@ -4918,16 +4928,20 @@ void ieee80211_nan_func_match(struct ieee80211_vif *vif,
 	if (WARN_ON(vif->type != NL80211_IFTYPE_NAN))
 		return;
 
-	spin_lock_bh(&sdata->u.nan.func_lock);
+	if (WARN_ON(sdata->local->hw.wiphy->nan_capa.flags &
+		    WIPHY_NAN_FLAGS_USERSPACE_DE))
+		return;
+
+	spin_lock_bh(&sdata->u.nan.de.func_lock);
 
-	func = idr_find(&sdata->u.nan.function_inst_ids,  match->inst_id);
+	func = idr_find(&sdata->u.nan.de.function_inst_ids,  match->inst_id);
 	if (WARN_ON(!func)) {
-		spin_unlock_bh(&sdata->u.nan.func_lock);
+		spin_unlock_bh(&sdata->u.nan.de.func_lock);
 		return;
 	}
 	match->cookie = func->cookie;
 
-	spin_unlock_bh(&sdata->u.nan.func_lock);
+	spin_unlock_bh(&sdata->u.nan.de.func_lock);
 
 	cfg80211_nan_match(ieee80211_vif_to_wdev(vif), match, gfp);
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 53d783769642..8d5f9a725fdf 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -987,16 +987,19 @@ struct ieee80211_if_mntr {
  *
  * @conf: current NAN configuration
  * @started: true iff NAN is started
- * @func_lock: lock for @func_inst_ids
- * @function_inst_ids: a bitmap of available instance_id's
+ * @de: Discovery Engine state (only valid if !WIPHY_NAN_FLAGS_USERSPACE_DE)
+ * @de.func_lock: lock for @de.function_inst_ids
+ * @de.function_inst_ids: a bitmap of available instance_id's
  */
 struct ieee80211_if_nan {
 	struct cfg80211_nan_conf conf;
 	bool started;
 
-	/* protects function_inst_ids */
-	spinlock_t func_lock;
-	struct idr function_inst_ids;
+	struct {
+		/* protects function_inst_ids */
+		spinlock_t func_lock;
+		struct idr function_inst_ids;
+	} de;
 };
 
 struct ieee80211_link_data_managed {
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7518dcbcdf1c..f0a5a675c5a5 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -622,15 +622,19 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		break;
 	case NL80211_IFTYPE_NAN:
 		/* clean all the functions */
-		spin_lock_bh(&sdata->u.nan.func_lock);
+		if (!(local->hw.wiphy->nan_capa.flags &
+		      WIPHY_NAN_FLAGS_USERSPACE_DE)) {
+			spin_lock_bh(&sdata->u.nan.de.func_lock);
+
+			idr_for_each_entry(&sdata->u.nan.de.function_inst_ids,
+					   func, i) {
+				idr_remove(&sdata->u.nan.de.function_inst_ids, i);
+				cfg80211_free_nan_func(func);
+			}
+			idr_destroy(&sdata->u.nan.de.function_inst_ids);
 
-		idr_for_each_entry(&sdata->u.nan.function_inst_ids, func, i) {
-			idr_remove(&sdata->u.nan.function_inst_ids, i);
-			cfg80211_free_nan_func(func);
+			spin_unlock_bh(&sdata->u.nan.de.func_lock);
 		}
-		idr_destroy(&sdata->u.nan.function_inst_ids);
-
-		spin_unlock_bh(&sdata->u.nan.func_lock);
 		break;
 	default:
 		wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->work);
@@ -1942,8 +1946,11 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 				      MONITOR_FLAG_OTHER_BSS;
 		break;
 	case NL80211_IFTYPE_NAN:
-		idr_init(&sdata->u.nan.function_inst_ids);
-		spin_lock_init(&sdata->u.nan.func_lock);
+		if (!(sdata->local->hw.wiphy->nan_capa.flags &
+		      WIPHY_NAN_FLAGS_USERSPACE_DE)) {
+			idr_init(&sdata->u.nan.de.function_inst_ids);
+			spin_lock_init(&sdata->u.nan.de.func_lock);
+		}
 		sdata->vif.bss_conf.bssid = sdata->vif.addr;
 		break;
 	case NL80211_IFTYPE_AP_VLAN:
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index d1bb6353908d..f47dd58770ad 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1157,7 +1157,9 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 
 	if (WARN_ON(local->hw.wiphy->interface_modes &
 			BIT(NL80211_IFTYPE_NAN) &&
-		    (!local->ops->start_nan || !local->ops->stop_nan)))
+		    ((!local->ops->start_nan || !local->ops->stop_nan) ||
+		     (local->hw.wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE &&
+		     (local->ops->add_nan_func || local->ops->del_nan_func)))))
 		return -EINVAL;
 
 	if (hw->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO) {
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 38b0c42c4c13..36795529ff82 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1754,6 +1754,10 @@ static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
 	if (WARN_ON(res))
 		return res;
 
+	if (sdata->local->hw.wiphy->nan_capa.flags &
+	    WIPHY_NAN_FLAGS_USERSPACE_DE)
+		return 0;
+
 	funcs = kzalloc_objs(*funcs, sdata->local->hw.max_nan_de_entries + 1);
 	if (!funcs)
 		return -ENOMEM;
@@ -1762,12 +1766,12 @@ static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
 	 * This is a little bit ugly. We need to call a potentially sleeping
 	 * callback for each NAN function, so we can't hold the spinlock.
 	 */
-	spin_lock_bh(&sdata->u.nan.func_lock);
+	spin_lock_bh(&sdata->u.nan.de.func_lock);
 
-	idr_for_each_entry(&sdata->u.nan.function_inst_ids, func, id)
+	idr_for_each_entry(&sdata->u.nan.de.function_inst_ids, func, id)
 		funcs[i++] = func;
 
-	spin_unlock_bh(&sdata->u.nan.func_lock);
+	spin_unlock_bh(&sdata->u.nan.de.func_lock);
 
 	for (i = 0; funcs[i]; i++) {
 		res = drv_add_nan_func(sdata->local, sdata, funcs[i]);
-- 
2.34.1


