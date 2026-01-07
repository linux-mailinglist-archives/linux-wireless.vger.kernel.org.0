Return-Path: <linux-wireless+bounces-30488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A5BCFE71E
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 16:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56EE5302C9F4
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 15:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20D7342528;
	Wed,  7 Jan 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nJBulcqf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93791342503
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795840; cv=none; b=NG4vw04gUfyj5bF14RQA1fyU9i1DEtuNcJCYtnhJ5jTu7bNtYz1qQ87zg7Tf65sxSGnyQYJ6gu3NucBWcVJisZkK4zZIEt2IzZ0z5uFXTbNZRc2x8gWInvBPQtBvDX8O/AbhZFKlgjemEGDlwAxPS9rti1SErPMxU9Su66gR/Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795840; c=relaxed/simple;
	bh=lfKGerhs8fIAeRvDkv5zJUcnIyBFUWvzpcofZgc+nXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoV6vmzklJA5JE+27vHsO+s/h/ocy/xy1NOiChuPnOvfwsln+cvxJT3I6NqVeilw+5D8ymMFIyXilmwlGQ7F2ZM8T1UrAutVFHXlKSQRS9O33n3vi/QHUzho5HAxA3CSSvnJ6lzh7u39ucG0MLrdGUGmLXInnNqDKzK7BkGdYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nJBulcqf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=X/10h9wdqajjP/bdfW3T8Pdyrx6/rXjpQoYKFw13bi8=;
	t=1767795838; x=1769005438; b=nJBulcqfO5KG+eHaNW2SqAFmSz8mb3gtmq38BhQmKP+HtmW
	MSxGrd1N2Y5PUZkFc6aHff4gvc3GMI8UOFjw+50OvnhRqbpFW/VACyJiBfiwZkevAz+GVrefpN76q
	wnXl3dYyeMYtbfAS1Nm7mWgnLiKCUuiWou5zPdGMZGcu1L7CRGOTf6HkI8+XWfEqt8AWYjmvF6rIo
	3iLifYvLfv4/X1w53TDpQDmwy2btzdSNzQGpIFnMvmRvo5NoAweaUJywxYSc8SRd4u3kvlpeTG98H
	NSQb/Q9msSmFu1MjBsSEvUO6EQddaIWJ8Em/Mm5Uen1vCgYICLmJFUjP6xDjRmcQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUS4-00000005agF-2FgU;
	Wed, 07 Jan 2026 15:23:56 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 26/46] wifi: mac80211: run NAN DE code only when appropriate
Date: Wed,  7 Jan 2026 15:22:25 +0100
Message-ID: <20260107152325.7edc48c03667.Iee24bef3bae2e1d502216192e760c1e699d271c9@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

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
index 90b94964102a..d23a9ffa2b2c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -510,12 +510,15 @@ static int ieee80211_add_nan_func(struct wiphy *wiphy,
 	if (!ieee80211_sdata_running(sdata))
 		return -ENETDOWN;
 
-	spin_lock_bh(&sdata->u.nan.func_lock);
+	if (WARN_ON(wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE))
+		return -EOPNOTSUPP;
 
-	ret = idr_alloc(&sdata->u.nan.function_inst_ids,
+	spin_lock_bh(&sdata->u.nan.de.func_lock);
+
+	ret = idr_alloc(&sdata->u.nan.de.function_inst_ids,
 			nan_func, 1, sdata->local->hw.max_nan_de_entries + 1,
 			GFP_ATOMIC);
-	spin_unlock_bh(&sdata->u.nan.func_lock);
+	spin_unlock_bh(&sdata->u.nan.de.func_lock);
 
 	if (ret < 0)
 		return ret;
@@ -526,10 +529,10 @@ static int ieee80211_add_nan_func(struct wiphy *wiphy,
 
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
@@ -542,9 +545,9 @@ ieee80211_find_nan_func_by_cookie(struct ieee80211_sub_if_data *sdata,
 	struct cfg80211_nan_func *func;
 	int id;
 
-	lockdep_assert_held(&sdata->u.nan.func_lock);
+	lockdep_assert_held(&sdata->u.nan.de.func_lock);
 
-	idr_for_each_entry(&sdata->u.nan.function_inst_ids, func, id) {
+	idr_for_each_entry(&sdata->u.nan.de.function_inst_ids, func, id) {
 		if (func->cookie == cookie)
 			return func;
 	}
@@ -563,13 +566,16 @@ static void ieee80211_del_nan_func(struct wiphy *wiphy,
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
@@ -4832,18 +4838,22 @@ void ieee80211_nan_func_terminated(struct ieee80211_vif *vif,
 	if (WARN_ON(vif->type != NL80211_IFTYPE_NAN))
 		return;
 
-	spin_lock_bh(&sdata->u.nan.func_lock);
+	if (WARN_ON(sdata->local->hw.wiphy->nan_capa.flags &
+		    WIPHY_NAN_FLAGS_USERSPACE_DE))
+		return;
 
-	func = idr_find(&sdata->u.nan.function_inst_ids, inst_id);
+	spin_lock_bh(&sdata->u.nan.de.func_lock);
+
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
 
@@ -4862,16 +4872,20 @@ void ieee80211_nan_func_match(struct ieee80211_vif *vif,
 	if (WARN_ON(vif->type != NL80211_IFTYPE_NAN))
 		return;
 
-	spin_lock_bh(&sdata->u.nan.func_lock);
+	if (WARN_ON(sdata->local->hw.wiphy->nan_capa.flags &
+		    WIPHY_NAN_FLAGS_USERSPACE_DE))
+		return;
 
-	func = idr_find(&sdata->u.nan.function_inst_ids,  match->inst_id);
+	spin_lock_bh(&sdata->u.nan.de.func_lock);
+
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
index 897550a07273..71fc775483e2 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -986,16 +986,19 @@ struct ieee80211_if_mntr {
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
index d5ba067a4b51..ddce54d1c9e8 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -618,15 +618,19 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		break;
 	case NL80211_IFTYPE_NAN:
 		/* clean all the functions */
-		spin_lock_bh(&sdata->u.nan.func_lock);
+		if (!(local->hw.wiphy->nan_capa.flags &
+		      WIPHY_NAN_FLAGS_USERSPACE_DE)) {
+			spin_lock_bh(&sdata->u.nan.de.func_lock);
 
-		idr_for_each_entry(&sdata->u.nan.function_inst_ids, func, i) {
-			idr_remove(&sdata->u.nan.function_inst_ids, i);
-			cfg80211_free_nan_func(func);
+			idr_for_each_entry(&sdata->u.nan.de.function_inst_ids,
+					   func, i) {
+				idr_remove(&sdata->u.nan.de.function_inst_ids, i);
+				cfg80211_free_nan_func(func);
+			}
+			idr_destroy(&sdata->u.nan.de.function_inst_ids);
+
+			spin_unlock_bh(&sdata->u.nan.de.func_lock);
 		}
-		idr_destroy(&sdata->u.nan.function_inst_ids);
-
-		spin_unlock_bh(&sdata->u.nan.func_lock);
 		break;
 	default:
 		wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->work);
@@ -1921,8 +1925,11 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
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
index b05e313c7f17..0f05f6b2ff2f 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1143,7 +1143,9 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 
 	if (WARN_ON(local->hw.wiphy->interface_modes &
 			BIT(NL80211_IFTYPE_NAN) &&
-		    (!local->ops->start_nan || !local->ops->stop_nan)))
+		    ((!local->ops->start_nan || !local->ops->stop_nan) ||
+		     (local->hw.wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE &&
+		     (local->ops->add_nan_func || local->ops->del_nan_func)))))
 		return -EINVAL;
 
 	if (hw->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO) {
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 79ef74744357..3b609fb36907 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1742,6 +1742,10 @@ static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
 	if (WARN_ON(res))
 		return res;
 
+	if (sdata->local->hw.wiphy->nan_capa.flags &
+	    WIPHY_NAN_FLAGS_USERSPACE_DE)
+		return 0;
+
 	funcs = kcalloc(sdata->local->hw.max_nan_de_entries + 1,
 			sizeof(*funcs),
 			GFP_KERNEL);
@@ -1752,12 +1756,12 @@ static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
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
2.52.0


