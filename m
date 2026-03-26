Return-Path: <linux-wireless+bounces-33950-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEr6JVYHxWnn5gQAu9opvQ
	(envelope-from <linux-wireless+bounces-33950-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:15:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DC23331D4
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CADD13059AE4
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165983C0630;
	Thu, 26 Mar 2026 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeL0vebt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1803BE15F
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520112; cv=none; b=tUHzjhY5qFGobg/PZe3OEUw48xPU+Le6c2/4L6c0Am1rUJKg+byFPObwfLEGxHCTiTvt1p03ttTzNjBGlBmnAiGCmnNtwCUrTkey9iHFLjsrI86AzZTVpz9+fNIkYrdgpZjlFmvsq1GwPB8ivNqHoND18dk0bBgVZGJmr4ObatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520112; c=relaxed/simple;
	bh=D6r5XRVoe2HSTOv4/EW+mDWNuaXaC9FHTtkyxMkVfeI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Opqa0FNg++XT8oNYQL+N4ZW5s3i9Laz2gnnKE8WFHTkeyaEzcT2cfhsbVI+IcmB0PGAgYI6SXUZGeX1ivXo7T/fgIRKNchsBFlKEfLDebQ+dWXT7Uwn6L6vZudcOKuMheQYTax+Gf9iRYJQE82D/tA2j6DNBStjUxAb7m7THLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeL0vebt; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774520111; x=1806056111;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=D6r5XRVoe2HSTOv4/EW+mDWNuaXaC9FHTtkyxMkVfeI=;
  b=IeL0vebtzCc4WTapm4OSumnc+aSnMaVqXrf230wdROeW6zJhTc/H44Re
   bjQ1TH4xUcdznRUTIv+Ed2/s5DHhpIc3lJRyFCaTqSDJWbsrLy3ySGoWy
   1xuVY6HhM8FNm2aBdHwLr724U8XVRT5P+WeP78+u8aUL+ODET73qPb853
   zwEWZqVul2aiESWnObSGmC4ZSycRs3yQfTdRnkfB4Kc71RLffjHiZykmy
   AatbrlUkGrCAlfnr2embjtR44+aY4JfB7y7EWPP6XQ6c8Tt2g3opu0G/b
   C60yFgbJTmCO7TD33hV69vWjPrqyg/MJ1BTwI/ZdP5JAJ0Y4dQ9eberUc
   w==;
X-CSE-ConnectionGUID: Km/KEnHuRJy1o8YjTlgyig==
X-CSE-MsgGUID: T0r7iX69SKua5wKo7Yq8QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="87048559"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="87048559"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:09 -0700
X-CSE-ConnectionGUID: Ga5u1XXsQwitrRdmI78vtA==
X-CSE-MsgGUID: aj5+jh9CQcaoGw6Zoj8iNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="221653138"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 wireless-next 04/15] wifi: mac80211: run NAN DE code only when appropriate
Date: Thu, 26 Mar 2026 12:14:34 +0200
Message-Id: <20260326121156.6665f64865cd.Iee24bef3bae2e1d502216192e760c1e699d271c9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
References: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33950-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 59DC23331D4
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


