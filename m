Return-Path: <linux-wireless+bounces-13594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DC9992AF3
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3056B24484
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6501AA7B4;
	Mon,  7 Oct 2024 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lr7K/7qa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C93F1BA285
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302488; cv=none; b=TSk9waht8IhZb1tIVqW3dI4VmxDknxD/JZKJWIB0xjzRH+vIcpw72EGo7GhY+X9CkdJji97vbBkL2zoz1bEoikgcrUto2crwnJdiui6im3Lsu+8NwqS56sJqyouLfgYtTVDFzCyfmGmzuruUe1FnmiJRVpE8wH7RufcYh7LHB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302488; c=relaxed/simple;
	bh=bWgic3soOfo8Y7couk/yl3Af+FgqlA/NDb8doaS4HI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ECh12nzkg0apzt2r74TqYkKipRUB7lh5UrQMRAI8McO+9Vg7FE7td/zP/sJfGEWO5RUJjI5aZJjBWySlteowkCZYtORRdwAvjlrG2VtwMCdSFst3XSxZh/CBIGdizAZSzD13TfnP9+lJkSkB7MgUS8xnoIYpIT1/9Ig5EhF3njs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lr7K/7qa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728302486; x=1759838486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bWgic3soOfo8Y7couk/yl3Af+FgqlA/NDb8doaS4HI4=;
  b=lr7K/7qaEeGHBW63xv40sQOl9YlLt/catskaZdb68u3g1Wu1SvM5scKm
   alvdXAn6G43Y05TRs3AK6Lize0qj+P9opqsex1UgZJGkK93n2kzInHR6j
   NmvPKG1CFfvHPK7lJX2L43tjF+wfeN5A61MujMHjs6lQIij8X/gsC0D3m
   z6MA3dFWxZXnc8JC/ilFQ+b5ecsDQc9/0pOEk6+FLlJpyKlMXcdedAr22
   jxHvSDDLwG5ZEwTlmQqlVt4skUFIzsAweG+8T+g70ARKycRWeqg9acPvl
   C0yJzKpBKCkHgNQ/uJEL4Gbtcw/QF52ENpJ5PRQFRBnEBPLlxjqciLcBb
   Q==;
X-CSE-ConnectionGUID: WF5Gq7KjShuUClapupaDzg==
X-CSE-MsgGUID: M90hV57mSYKgJ5gUAZjAKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38099413"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38099413"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:26 -0700
X-CSE-ConnectionGUID: Y6oFsFbOSmiFB2yhtQ8+jA==
X-CSE-MsgGUID: bxJ8Tc29Ryu8SSEo9ez2bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75019270"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/14] wifi: mac80211: allow rate_control_rate_init() for links
Date: Mon,  7 Oct 2024 15:00:53 +0300
Message-Id: <20241007144851.c693274a908f.I0376da02e9f5a30eaa1b5d0d01371ff09506d453@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Andrei previously fixed an issue in the client where the NSS
for links other than the primary/assoc/deflink isn't set. The
same issue appears to exist on the AP side, because there's
only a call to rate_control_rate_init() for the deflink, and
not any other links.

Rework the code a bit to do rate_control_rate_init() for links,
even if it really doesn't work with software rate control yet,
it does other things as well.

Also add rate_control_rate_init_all_links() to actually do it
properly when moving to ASSOC state in cfg80211.

Change the explicit call to ieee80211_sta_init_nss() to instead
be rate_control_rate_init() now in the client code, but also
add a call to rate_control_rate_init() when a link is added in
AP mode and the STA is already associated.

This should fix the NSS initialization issue, and perhaps pave
the way for actual software rate scaling a bit, in case anyone
cares in the future, but that of course needs a lot more than
just the init call.

We still need to fix the rate control _update_ as well, and the
sta_rc_update() driver method especially, but that will be in a
different patch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c        | 11 +++++++++--
 net/mac80211/ibss.c       |  4 ++--
 net/mac80211/mesh_plink.c |  2 +-
 net/mac80211/mlme.c       |  2 +-
 net/mac80211/ocb.c        |  4 ++--
 net/mac80211/rate.c       | 24 ++++++++++++++++++++++--
 net/mac80211/rate.h       |  5 +++--
 7 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ca4fd217be3e..ecc138869b4b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1720,7 +1720,7 @@ static int sta_apply_auth_flags(struct ieee80211_local *local,
 		 * before drv_sta_state() is called.
 		 */
 		if (!test_sta_flag(sta, WLAN_STA_RATE_CONTROL))
-			rate_control_rate_init(sta);
+			rate_control_rate_init_all_links(sta);
 
 		ret = sta_info_move_state(sta, IEEE80211_STA_ASSOC);
 		if (ret)
@@ -2149,7 +2149,7 @@ static int ieee80211_add_station(struct wiphy *wiphy, struct net_device *dev,
 	 */
 	if (!test_sta_flag(sta, WLAN_STA_TDLS_PEER) &&
 	    test_sta_flag(sta, WLAN_STA_ASSOC))
-		rate_control_rate_init(sta);
+		rate_control_rate_init_all_links(sta);
 
 	return sta_info_insert(sta);
 }
@@ -5063,6 +5063,13 @@ ieee80211_add_link_station(struct wiphy *wiphy, struct net_device *dev,
 		return ret;
 	}
 
+	if (test_sta_flag(sta, WLAN_STA_ASSOC)) {
+		struct link_sta_info *link_sta;
+
+		link_sta = sdata_dereference(sta->link[params->link_id], sdata);
+		rate_control_rate_init(link_sta);
+	}
+
 	/* ieee80211_sta_activate_link frees the link upon failure */
 	return ieee80211_sta_activate_link(sta, params->link_id);
 }
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 3f74bbceeca5..08fac295ad5b 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -569,7 +569,7 @@ static struct sta_info *ieee80211_ibss_finish_sta(struct sta_info *sta)
 	if (!sta->sdata->u.ibss.control_port)
 		sta_info_pre_move_state(sta, IEEE80211_STA_AUTHORIZED);
 
-	rate_control_rate_init(sta);
+	rate_control_rate_init(&sta->deflink);
 
 	/* If it fails, maybe we raced another insertion? */
 	if (sta_info_insert_rcu(sta))
@@ -1068,7 +1068,7 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 
 		/* Force rx_nss recalculation */
 		sta->sta.deflink.rx_nss = 0;
-		rate_control_rate_init(sta);
+		rate_control_rate_init(&sta->deflink);
 		if (sta->sta.deflink.rx_nss != rx_nss)
 			changed |= IEEE80211_RC_NSS_CHANGED;
 
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 8f2b492a9fe9..5c32b92aa63f 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -487,7 +487,7 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (!test_sta_flag(sta, WLAN_STA_RATE_CONTROL))
-		rate_control_rate_init(sta);
+		rate_control_rate_init(&sta->deflink);
 	else
 		rate_control_rate_update(local, sband, sta, 0, changed);
 out:
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2cb3691971e0..91ae0ff49bba 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5750,7 +5750,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	/* links might have changed due to rejected ones, set them again */
 	ieee80211_vif_set_links(sdata, valid_links, dormant_links);
 
-	rate_control_rate_init(sta);
+	rate_control_rate_init_all_links(sta);
 
 	if (ifmgd->flags & IEEE80211_STA_MFP_ENABLED) {
 		set_sta_flag(sta, WLAN_STA_MFP);
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index 9ef14e475c90..54ba51309919 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -4,7 +4,7 @@
  *
  * Copyright: (c) 2014 Czech Technical University in Prague
  *            (c) 2014 Volkswagen Group Research
- * Copyright (C) 2022 - 2023 Intel Corporation
+ * Copyright (C) 2022 - 2024 Intel Corporation
  * Author:    Rostislav Lisovy <rostislav.lisovy@fel.cvut.cz>
  * Funded by: Volkswagen Group Research
  */
@@ -96,7 +96,7 @@ static struct sta_info *ieee80211_ocb_finish_sta(struct sta_info *sta)
 	sta_info_move_state(sta, IEEE80211_STA_ASSOC);
 	sta_info_move_state(sta, IEEE80211_STA_AUTHORIZED);
 
-	rate_control_rate_init(sta);
+	rate_control_rate_init(&sta->deflink);
 
 	/* If it fails, maybe we raced another insertion? */
 	if (sta_info_insert_rcu(sta))
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 3dc9752188d5..23b4f1af37e0 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -28,8 +28,9 @@ module_param(ieee80211_default_rc_algo, charp, 0644);
 MODULE_PARM_DESC(ieee80211_default_rc_algo,
 		 "Default rate control algorithm for mac80211 to use");
 
-void rate_control_rate_init(struct sta_info *sta)
+void rate_control_rate_init(struct link_sta_info *link_sta)
 {
+	struct sta_info *sta = link_sta->sta;
 	struct ieee80211_local *local = sta->sdata->local;
 	struct rate_control_ref *ref = sta->rate_ctrl;
 	struct ieee80211_sta *ista = &sta->sta;
@@ -37,11 +38,15 @@ void rate_control_rate_init(struct sta_info *sta)
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 
-	ieee80211_sta_init_nss(&sta->deflink);
+	ieee80211_sta_init_nss(link_sta);
 
 	if (!ref)
 		return;
 
+	/* SW rate control isn't supported with MLO right now */
+	if (WARN_ON(ieee80211_vif_is_mld(&sta->sdata->vif)))
+		return;
+
 	rcu_read_lock();
 
 	chanctx_conf = rcu_dereference(sta->sdata->vif.bss_conf.chanctx_conf);
@@ -67,6 +72,21 @@ void rate_control_rate_init(struct sta_info *sta)
 	set_sta_flag(sta, WLAN_STA_RATE_CONTROL);
 }
 
+void rate_control_rate_init_all_links(struct sta_info *sta)
+{
+	int link_id;
+
+	for (link_id = 0; link_id < ARRAY_SIZE(sta->link); link_id++) {
+		struct link_sta_info *link_sta;
+
+		link_sta = sdata_dereference(sta->link[link_id], sta->sdata);
+		if (!link_sta)
+			continue;
+
+		rate_control_rate_init(link_sta);
+	}
+}
+
 void rate_control_tx_status(struct ieee80211_local *local,
 			    struct ieee80211_tx_status *st)
 {
diff --git a/net/mac80211/rate.h b/net/mac80211/rate.h
index d6190f10fe7c..8d3c8903b4ae 100644
--- a/net/mac80211/rate.h
+++ b/net/mac80211/rate.h
@@ -3,7 +3,7 @@
  * Copyright 2002-2005, Instant802 Networks, Inc.
  * Copyright 2005, Devicescape Software, Inc.
  * Copyright (c) 2006 Jiri Benc <jbenc@suse.cz>
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022, 2024 Intel Corporation
  */
 
 #ifndef IEEE80211_RATE_H
@@ -29,7 +29,8 @@ void rate_control_get_rate(struct ieee80211_sub_if_data *sdata,
 void rate_control_tx_status(struct ieee80211_local *local,
 			    struct ieee80211_tx_status *st);
 
-void rate_control_rate_init(struct sta_info *sta);
+void rate_control_rate_init(struct link_sta_info *link_sta);
+void rate_control_rate_init_all_links(struct sta_info *sta);
 void rate_control_rate_update(struct ieee80211_local *local,
 			      struct ieee80211_supported_band *sband,
 			      struct sta_info *sta,
-- 
2.34.1


