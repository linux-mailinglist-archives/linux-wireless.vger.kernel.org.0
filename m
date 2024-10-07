Return-Path: <linux-wireless+bounces-13593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B41992AF2
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33AB7B242A5
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 12:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923D41D223B;
	Mon,  7 Oct 2024 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YBYmxAvv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB26E1D1E87
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302486; cv=none; b=Fr16+GvECaBbErH7iWe+CMkDbgVzfOAzB+9XAyWTDNpE/nAJc4P2/80zY7is2v8Xwpg9iPq3xxPGRWX4EQjMs31e53OKkXrT7y6RPqbcXYvERVBYuX7Ptgo80ODxTwvy+8t1JJqYUlbnIYLCI2f+6ECx+qNOq8U6uyO+c5qaNFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302486; c=relaxed/simple;
	bh=AxVnDPQhpjKnA7jmvOpWVrlwfUTc+/iVpo9StglF4w4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z58PAbs1cKBmDknb2yBKy9JqzC5TsW2LwJpeegQm8/M4IB4fsfEA6BjHOptZrZTisUydia6CdDwLlqAqNBLyAxMjz881l/ZH8Riyspwhr8s+drwMuTXR+VlPLs+6SM3SRUg8aKAFBkn7wx5ZeaJexlm870N/WMDSlyXjagIe6jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YBYmxAvv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728302485; x=1759838485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AxVnDPQhpjKnA7jmvOpWVrlwfUTc+/iVpo9StglF4w4=;
  b=YBYmxAvvE8o95CEA4E/5o+BzG6emjACZW+kJ6aabeFRj0UVQh4ErBVOL
   CH35t+bRaZQqpJvG6T1H8sYpQtGl48W08ECwjvTQci/xM949+gDVIEn4r
   uD8hXU/A4NPxUEBKdwYRHX0rYmYrix4RuvRYx4vg9EUcn+q7vV8Jcix4S
   qmG30BICJoJTGmEQAKfGuibMKNcksu9gu/p4rb7fvVHjQ7+F8qLk8+IxB
   JeqqwQrWZtOBOlX76w/6bteBLAyMbqTuNQw55d7RWV5P0pLuSX8vKwOav
   +7cGB7y0g5bp/fBKtGZwmDtWZBACu97LPfLnLwhoaJv4gNfhPtCNt6xzo
   g==;
X-CSE-ConnectionGUID: RwIgjCgjREOoDwWWppl+tA==
X-CSE-MsgGUID: F+Y+u95kREmKphSORFZvig==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38099408"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38099408"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:24 -0700
X-CSE-ConnectionGUID: gZQPHjKwQjK48U8F5nxGUA==
X-CSE-MsgGUID: x5tFpZ//SG+B3GW+PCSH5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75019266"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/14] wifi: mac80211: update the right link for tx power
Date: Mon,  7 Oct 2024 15:00:52 +0300
Message-Id: <20241007144851.2685dab8e1ab.I1d82cbdb2dda020aee4a225bd9a134f7d82dd810@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
References: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Stop looking at deflink and start using the actual link.
Initialize the power settings upon link init.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c   | 94 +++++++++++++++++++++++++++-----------------
 net/mac80211/chan.c  |  4 +-
 net/mac80211/iface.c | 20 ++++------
 net/mac80211/link.c  |  3 ++
 4 files changed, 72 insertions(+), 49 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 27468a463d8b..ca4fd217be3e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3061,9 +3061,25 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 	enum nl80211_tx_power_setting txp_type = type;
 	bool update_txp_type = false;
 	bool has_monitor = false;
+	int user_power_level;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	switch (type) {
+	case NL80211_TX_POWER_AUTOMATIC:
+		user_power_level = IEEE80211_UNSET_POWER_LEVEL;
+		txp_type = NL80211_TX_POWER_LIMITED;
+		break;
+	case NL80211_TX_POWER_LIMITED:
+	case NL80211_TX_POWER_FIXED:
+		if (mbm < 0 || (mbm % 100))
+			return -EOPNOTSUPP;
+		user_power_level = MBM_TO_DBM(mbm);
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	if (wdev) {
 		sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
@@ -3077,57 +3093,65 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 				return -EOPNOTSUPP;
 		}
 
-		switch (type) {
-		case NL80211_TX_POWER_AUTOMATIC:
-			sdata->deflink.user_power_level =
-				IEEE80211_UNSET_POWER_LEVEL;
-			txp_type = NL80211_TX_POWER_LIMITED;
-			break;
-		case NL80211_TX_POWER_LIMITED:
-		case NL80211_TX_POWER_FIXED:
-			if (mbm < 0 || (mbm % 100))
-				return -EOPNOTSUPP;
-			sdata->deflink.user_power_level = MBM_TO_DBM(mbm);
-			break;
-		}
+		for (int link_id = 0;
+		     link_id < ARRAY_SIZE(sdata->link);
+		     link_id++) {
+			struct ieee80211_link_data *link =
+				wiphy_dereference(wiphy, sdata->link[link_id]);
 
-		if (txp_type != sdata->vif.bss_conf.txpower_type) {
-			update_txp_type = true;
-			sdata->vif.bss_conf.txpower_type = txp_type;
-		}
+			if (!link)
+				continue;
+
+			link->user_power_level = user_power_level;
 
-		ieee80211_recalc_txpower(&sdata->deflink, update_txp_type);
+			if (txp_type != link->conf->txpower_type) {
+				update_txp_type = true;
+				link->conf->txpower_type = txp_type;
+			}
 
+			ieee80211_recalc_txpower(link, update_txp_type);
+		}
 		return 0;
 	}
 
-	switch (type) {
-	case NL80211_TX_POWER_AUTOMATIC:
-		local->user_power_level = IEEE80211_UNSET_POWER_LEVEL;
-		txp_type = NL80211_TX_POWER_LIMITED;
-		break;
-	case NL80211_TX_POWER_LIMITED:
-	case NL80211_TX_POWER_FIXED:
-		if (mbm < 0 || (mbm % 100))
-			return -EOPNOTSUPP;
-		local->user_power_level = MBM_TO_DBM(mbm);
-		break;
-	}
+	local->user_power_level = user_power_level;
 
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		if (sdata->vif.type == NL80211_IFTYPE_MONITOR) {
 			has_monitor = true;
 			continue;
 		}
-		sdata->deflink.user_power_level = local->user_power_level;
-		if (txp_type != sdata->vif.bss_conf.txpower_type)
-			update_txp_type = true;
-		sdata->vif.bss_conf.txpower_type = txp_type;
+
+		for (int link_id = 0;
+		     link_id < ARRAY_SIZE(sdata->link);
+		     link_id++) {
+			struct ieee80211_link_data *link =
+				wiphy_dereference(wiphy, sdata->link[link_id]);
+
+			if (!link)
+				continue;
+
+			link->user_power_level = local->user_power_level;
+			if (txp_type != link->conf->txpower_type)
+				update_txp_type = true;
+			link->conf->txpower_type = txp_type;
+		}
 	}
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		if (sdata->vif.type == NL80211_IFTYPE_MONITOR)
 			continue;
-		ieee80211_recalc_txpower(&sdata->deflink, update_txp_type);
+
+		for (int link_id = 0;
+		     link_id < ARRAY_SIZE(sdata->link);
+		     link_id++) {
+			struct ieee80211_link_data *link =
+				wiphy_dereference(wiphy, sdata->link[link_id]);
+
+			if (!link)
+				continue;
+
+			ieee80211_recalc_txpower(link, update_txp_type);
+		}
 	}
 
 	if (has_monitor) {
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index a4cc91beee74..97c8480f0f2c 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -905,7 +905,7 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 	}
 
 	if (new_ctx && ieee80211_chanctx_num_assigned(local, new_ctx) > 0) {
-		ieee80211_recalc_txpower(&sdata->deflink, false);
+		ieee80211_recalc_txpower(link, false);
 		ieee80211_recalc_chanctx_min_def(local, new_ctx, NULL, false);
 	}
 
@@ -1712,7 +1712,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 								  link,
 								  changed);
 
-			ieee80211_recalc_txpower(&sdata->deflink, false);
+			ieee80211_recalc_txpower(link, false);
 		}
 
 		ieee80211_recalc_chanctx_chantype(local, ctx);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 138ba30e23ba..7a99fa057cd9 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -46,12 +46,11 @@ static void ieee80211_iface_work(struct wiphy *wiphy, struct wiphy_work *work);
 
 bool __ieee80211_recalc_txpower(struct ieee80211_link_data *link)
 {
-	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	int power;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+	chanctx_conf = rcu_dereference(link->conf->chanctx_conf);
 	if (!chanctx_conf) {
 		rcu_read_unlock();
 		return false;
@@ -60,15 +59,15 @@ bool __ieee80211_recalc_txpower(struct ieee80211_link_data *link)
 	power = ieee80211_chandef_max_power(&chanctx_conf->def);
 	rcu_read_unlock();
 
-	if (sdata->deflink.user_power_level != IEEE80211_UNSET_POWER_LEVEL)
-		power = min(power, sdata->deflink.user_power_level);
+	if (link->user_power_level != IEEE80211_UNSET_POWER_LEVEL)
+		power = min(power, link->user_power_level);
 
-	if (sdata->deflink.ap_power_level != IEEE80211_UNSET_POWER_LEVEL)
-		power = min(power, sdata->deflink.ap_power_level);
+	if (link->ap_power_level != IEEE80211_UNSET_POWER_LEVEL)
+		power = min(power, link->ap_power_level);
 
-	if (power != sdata->vif.bss_conf.txpower) {
-		sdata->vif.bss_conf.txpower = power;
-		ieee80211_hw_config(sdata->local, 0);
+	if (power != link->conf->txpower) {
+		link->conf->txpower = power;
+		ieee80211_hw_config(link->sdata->local, 0);
 		return true;
 	}
 
@@ -2177,9 +2176,6 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 	ieee80211_set_default_queues(sdata);
 
-	sdata->deflink.ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
-	sdata->deflink.user_power_level = local->user_power_level;
-
 	/* setup type-dependent data */
 	ieee80211_setup_sdata(sdata, type);
 
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 0bbac64d5fa0..503bdea904bc 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -36,6 +36,9 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	link->conf = link_conf;
 	link_conf->link_id = link_id;
 	link_conf->vif = &sdata->vif;
+	link->ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
+	link->user_power_level = sdata->local->user_power_level;
+	link_conf->txpower = INT_MIN;
 
 	wiphy_work_init(&link->csa.finalize_work,
 			ieee80211_csa_finalize_work);
-- 
2.34.1


