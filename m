Return-Path: <linux-wireless+bounces-20030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87A5A57E56
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F2E16D891
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA456374FF;
	Sat,  8 Mar 2025 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cb3ih/gA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2C91A4F2F
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741467975; cv=none; b=JETTru33s0D/gBgYc6w3Tbu3UfCUPb4Ra1Yov80tgqKOClaVNuNa+AEVam4eVCkkE44u23ZLPAY5h6HcRZVJfG3GHHTVzSmmJlLb9tNzU0AEceW9YxyA6B5l+LXHXt2b9x03NtUttsY1T5Al8TzvFJ49CT5ASuE4f3WG2wbHMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741467975; c=relaxed/simple;
	bh=jGTy91gK9JsTeafUyT/9UlFPcjJsfYuybb131InUjxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OwvDj5GLnWPBsemxQCpHc/mNNaAvXrR/COtfYaJ8cYve73p+4jn9wX1Yqp6AdTQ58hcWKEM/cyzHISG/1uDP7RZFERN7QElWiQXHvrPwWp1mLvTufgLIiZj3g8tDdaOuivYklnciASEhrvrFCHoyl9MO97t/hyCjE9zhkfLoWvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cb3ih/gA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741467974; x=1773003974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jGTy91gK9JsTeafUyT/9UlFPcjJsfYuybb131InUjxc=;
  b=Cb3ih/gAs6dINK9NTelVFjqJv/jZPcj4/21MXtmgW1q70hn7YSAA7tx0
   CtV1xxF9bUMVu8oP2+sdIAemthWPOcoPkLqxzWSLeYsYEnN9c64fCYv5E
   OFnY+aMKuDDmX7sSRJK+MYjpaLKI1955LI/GMyjKfW38YdRWAGbr0GyYn
   Xp1pfThig5R3EYuegE0End2gMz13yzke6pehkPGOaBUQAhLc+Xm5V1ezg
   qKkiBPRt6aBUr0MQ8IFVu+MbmAWYOlfSetCYYkslyzTwutp/k04HZ3G1/
   i10aoAPuYeq2MuyQQbfNyalWXuH8sI+w2kWZst4sudn9jp8yw87kpsgAU
   g==;
X-CSE-ConnectionGUID: CEqFeWM2SVOp8UlDqgYUYw==
X-CSE-MsgGUID: gQ0blwFGQNqwa5Ilu431jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42413018"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42413018"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:03:55 -0800
X-CSE-ConnectionGUID: J/ZPFi3ISMWe1hYRa0NuQg==
X-CSE-MsgGUID: UOeAlYXyROKhLBXeU+hD1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124644353"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:03:54 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH RESEND wireless-next 01/15] wifi: cfg80211: move link reconfig parameters into a struct
Date: Sat,  8 Mar 2025 23:03:27 +0200
Message-Id: <20250308225541.0cf299c1fdd0.Id1a3b1092dc52d0d3731a8798522fdf2e052bf0b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
References: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add a new struct cfg80211_ml_reconf_req to collect the link
reconfiguration parameters.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h     | 15 ++++++++++++---
 net/mac80211/cfg.c         |  7 +++----
 net/mac80211/ieee80211_i.h |  5 ++---
 net/mac80211/mlme.c        | 39 +++++++++++++++++++-------------------
 net/wireless/core.h        |  6 +++---
 net/wireless/mlme.c        | 13 ++++++-------
 net/wireless/nl80211.c     | 24 +++++++++++------------
 net/wireless/rdev-ops.h    | 10 ++++------
 net/wireless/trace.h       | 13 ++++++-------
 9 files changed, 67 insertions(+), 65 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6b170a8d086c..c7cfef104896 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7,7 +7,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014 Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 
 #include <linux/ethtool.h>
@@ -3082,6 +3082,16 @@ struct cfg80211_assoc_link {
 	int error;
 };
 
+/**
+ * struct cfg80211_ml_reconf_req - MLO link reconfiguration request
+ * @add_links: data for links to add, see &struct cfg80211_assoc_link
+ * @rem_links: bitmap of links to remove
+ */
+struct cfg80211_ml_reconf_req {
+	struct cfg80211_assoc_link add_links[IEEE80211_MLD_MAX_NUM_LINKS];
+	u16 rem_links;
+};
+
 /**
  * enum cfg80211_assoc_req_flags - Over-ride default behaviour in association.
  *
@@ -4972,8 +4982,7 @@ struct cfg80211_ops {
 			    struct cfg80211_ttlm_params *params);
 	u32	(*get_radio_mask)(struct wiphy *wiphy, struct net_device *dev);
 	int     (*assoc_ml_reconf)(struct wiphy *wiphy, struct net_device *dev,
-				   struct cfg80211_assoc_link *add_links,
-				   u16 rem_links);
+				   struct cfg80211_ml_reconf_req *req);
 	int	(*set_epcs)(struct wiphy *wiphy, struct net_device *dev,
 			    bool val);
 };
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 09708a060bb7..76453c0f82a5 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -5185,14 +5185,13 @@ ieee80211_set_ttlm(struct wiphy *wiphy, struct net_device *dev,
 
 static int
 ieee80211_assoc_ml_reconf(struct wiphy *wiphy, struct net_device *dev,
-			  struct cfg80211_assoc_link *add_links,
-			  u16 rem_links)
+			  struct cfg80211_ml_reconf_req *req)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	return ieee80211_mgd_assoc_ml_reconf(sdata, add_links, rem_links);
+	return ieee80211_mgd_assoc_ml_reconf(sdata, req);
 }
 
 static int
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 845888ac3d2c..5f92619f8584 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 
 #ifndef IEEE80211_I_H
@@ -2789,8 +2789,7 @@ void ieee80211_process_epcs_teardown(struct ieee80211_sub_if_data *sdata,
 				     struct ieee80211_mgmt *mgmt, size_t len);
 
 int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
-				  struct cfg80211_assoc_link *add_links,
-				  u16 rem_links);
+				  struct cfg80211_ml_reconf_req *req);
 
 void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 				      struct ieee80211_mgmt *mgmt, size_t len);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 23d85a1abbc5..613959f19713 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10362,8 +10362,7 @@ ieee80211_build_ml_reconf_req(struct ieee80211_sub_if_data *sdata,
 }
 
 int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
-				  struct cfg80211_assoc_link *add_links,
-				  u16 rem_links)
+				  struct cfg80211_ml_reconf_req *req)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_mgd_assoc_data *data = NULL;
@@ -10383,9 +10382,8 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 		return -EBUSY;
 
 	added_links = 0;
-	for (link_id = 0; add_links && link_id < IEEE80211_MLD_MAX_NUM_LINKS;
-	     link_id++) {
-		if (!add_links[link_id].bss)
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		if (!req->add_links[link_id].bss)
 			continue;
 
 		added_links |= BIT(link_id);
@@ -10413,7 +10411,8 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
 		     link_id++) {
 			struct ieee80211_supported_band *sband;
-			struct cfg80211_bss *link_cbss = add_links[link_id].bss;
+			struct cfg80211_bss *link_cbss =
+				req->add_links[link_id].bss;
 			struct ieee80211_bss *bss;
 
 			if (!link_cbss)
@@ -10443,11 +10442,11 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 
 			data->link[link_id].bss = link_cbss;
 			data->link[link_id].disabled =
-				add_links[link_id].disabled;
+				req->add_links[link_id].disabled;
 			data->link[link_id].elems =
-				(u8 *)add_links[link_id].elems;
+				(u8 *)req->add_links[link_id].elems;
 			data->link[link_id].elems_len =
-				add_links[link_id].elems_len;
+				req->add_links[link_id].elems_len;
 
 			if (!bss->uapsd_supported)
 				uapsd_supported = false;
@@ -10497,10 +10496,11 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 	 * Section 35.3.6.4 in Draft P802.11be_D7.0 the AP MLD should accept the
 	 * link removal request.
 	 */
-	if (rem_links) {
-		u16 new_active_links = sdata->vif.active_links & ~rem_links;
+	if (req->rem_links) {
+		u16 new_active_links =
+			sdata->vif.active_links & ~req->rem_links;
 
-		new_valid_links = sdata->vif.valid_links & ~rem_links;
+		new_valid_links = sdata->vif.valid_links & ~req->rem_links;
 
 		/* Should not be left with no valid links to perform the
 		 * ML reconfiguration
@@ -10535,14 +10535,15 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 	 * is expected to send the ML reconfiguration response frame on the link
 	 * on which the request was received.
 	 */
-	skb = ieee80211_build_ml_reconf_req(sdata, data, rem_links);
+	skb = ieee80211_build_ml_reconf_req(sdata, data, req->rem_links);
 	if (!skb) {
 		err = -ENOMEM;
 		goto err_free;
 	}
 
-	if (rem_links) {
-		u16 new_dormant_links = sdata->vif.dormant_links & ~rem_links;
+	if (req->rem_links) {
+		u16 new_dormant_links =
+			sdata->vif.dormant_links & ~req->rem_links;
 
 		err = ieee80211_vif_set_links(sdata, new_valid_links,
 					      new_dormant_links);
@@ -10555,7 +10556,7 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 
 		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
 		     link_id++) {
-			if (!(rem_links & BIT(link_id)))
+			if (!(req->rem_links & BIT(link_id)))
 				continue;
 
 			ieee80211_sta_remove_link(sta, link_id);
@@ -10564,17 +10565,17 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 		/* notify the driver and upper layers */
 		ieee80211_vif_cfg_change_notify(sdata,
 						BSS_CHANGED_MLD_VALID_LINKS);
-		cfg80211_links_removed(sdata->dev, rem_links);
+		cfg80211_links_removed(sdata->dev, req->rem_links);
 	}
 
 	sdata_info(sdata, "mlo: reconf: adding=0x%x, removed=0x%x\n",
-		   added_links, rem_links);
+		   added_links, req->rem_links);
 
 	ieee80211_tx_skb(sdata, skb);
 
 	sdata->u.mgd.reconf.added_links = added_links;
 	sdata->u.mgd.reconf.add_links_data = data;
-	sdata->u.mgd.reconf.removed_links = rem_links;
+	sdata->u.mgd.reconf.removed_links = req->rem_links;
 	wiphy_delayed_work_queue(sdata->local->hw.wiphy,
 				 &sdata->u.mgd.reconf.wk,
 				 IEEE80211_ASSOC_TIMEOUT_SHORT);
diff --git a/net/wireless/core.h b/net/wireless/core.h
index b094b526b05d..c56a35040caa 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -3,7 +3,7 @@
  * Wireless configuration interface internals.
  *
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #ifndef __NET_WIRELESS_CORE_H
 #define __NET_WIRELESS_CORE_H
@@ -568,8 +568,8 @@ void cfg80211_wdev_release_link_bsses(struct wireless_dev *wdev, u16 link_mask);
 
 int cfg80211_assoc_ml_reconf(struct cfg80211_registered_device *rdev,
 			     struct net_device *dev,
-			     struct cfg80211_assoc_link *links,
-			     u16 rem_links);
+			     struct cfg80211_ml_reconf_req *req);
+
 /**
  * struct cfg80211_colocated_ap - colocated AP information
  *
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index e10f2b3b4b7f..956d33b219df 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -4,7 +4,7 @@
  *
  * Copyright (c) 2009, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2015		Intel Deutschland GmbH
- * Copyright (C) 2019-2020, 2022-2024 Intel Corporation
+ * Copyright (C) 2019-2020, 2022-2025 Intel Corporation
  */
 
 #include <linux/kernel.h>
@@ -1297,25 +1297,24 @@ void cfg80211_stop_background_radar_detection(struct wireless_dev *wdev)
 
 int cfg80211_assoc_ml_reconf(struct cfg80211_registered_device *rdev,
 			     struct net_device *dev,
-			     struct cfg80211_assoc_link *links,
-			     u16 rem_links)
+			     struct cfg80211_ml_reconf_req *req)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err;
 
 	lockdep_assert_wiphy(wdev->wiphy);
 
-	err = rdev_assoc_ml_reconf(rdev, dev, links, rem_links);
+	err = rdev_assoc_ml_reconf(rdev, dev, req);
 	if (!err) {
 		int link_id;
 
 		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
 		     link_id++) {
-			if (!links[link_id].bss)
+			if (!req->add_links[link_id].bss)
 				continue;
 
-			cfg80211_ref_bss(&rdev->wiphy, links[link_id].bss);
-			cfg80211_hold_bss(bss_from_pub(links[link_id].bss));
+			cfg80211_ref_bss(&rdev->wiphy, req->add_links[link_id].bss);
+			cfg80211_hold_bss(bss_from_pub(req->add_links[link_id].bss));
 		}
 	}
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2c4e06610a79..fe706f70ac7e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 
 #include <linux/if.h>
@@ -16488,9 +16488,9 @@ static int nl80211_assoc_ml_reconf(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	struct cfg80211_assoc_link links[IEEE80211_MLD_MAX_NUM_LINKS] = {};
+	struct cfg80211_ml_reconf_req req = {};
 	unsigned int link_id;
-	u16 add_links, rem_links;
+	u16 add_links;
 	int err;
 
 	if (!wdev->valid_links)
@@ -16506,39 +16506,37 @@ static int nl80211_assoc_ml_reconf(struct sk_buff *skb, struct genl_info *info)
 
 	add_links = 0;
 	if (info->attrs[NL80211_ATTR_MLO_LINKS]) {
-		err = nl80211_process_links(rdev, links, NULL, 0, info);
+		err = nl80211_process_links(rdev, req.add_links, NULL, 0, info);
 		if (err)
 			return err;
 
 		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
 		     link_id++) {
-			if (!links[link_id].bss)
+			if (!req.add_links[link_id].bss)
 				continue;
 			add_links |= BIT(link_id);
 		}
 	}
 
 	if (info->attrs[NL80211_ATTR_MLO_RECONF_REM_LINKS])
-		rem_links =
+		req.rem_links =
 			nla_get_u16(info->attrs[NL80211_ATTR_MLO_RECONF_REM_LINKS]);
-	else
-		rem_links = 0;
 
 	/* Validate that existing links are not added, removed links are valid
 	 * and don't allow adding and removing the same links
 	 */
-	if ((add_links & rem_links) || !(add_links | rem_links) ||
+	if ((add_links & req.rem_links) || !(add_links | req.rem_links) ||
 	    (wdev->valid_links & add_links) ||
-	    ((wdev->valid_links & rem_links) != rem_links)) {
+	    ((wdev->valid_links & req.rem_links) != req.rem_links)) {
 		err = -EINVAL;
 		goto out;
 	}
 
-	err = cfg80211_assoc_ml_reconf(rdev, dev, links, rem_links);
+	err = cfg80211_assoc_ml_reconf(rdev, dev, &req);
 
 out:
-	for (link_id = 0; link_id < ARRAY_SIZE(links); link_id++)
-		cfg80211_put_bss(&rdev->wiphy, links[link_id].bss);
+	for (link_id = 0; link_id < ARRAY_SIZE(req.add_links); link_id++)
+		cfg80211_put_bss(&rdev->wiphy, req.add_links[link_id].bss);
 
 	return err;
 }
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 759da1623342..9f4783c2354c 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -2,7 +2,7 @@
 /*
  * Portions of this file
  * Copyright(c) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018, 2021-2024 Intel Corporation
+ * Copyright (C) 2018, 2021-2025 Intel Corporation
  */
 #ifndef __CFG80211_RDEV_OPS
 #define __CFG80211_RDEV_OPS
@@ -1551,16 +1551,14 @@ rdev_get_radio_mask(struct cfg80211_registered_device *rdev,
 static inline int
 rdev_assoc_ml_reconf(struct cfg80211_registered_device *rdev,
 		     struct net_device *dev,
-		     struct cfg80211_assoc_link *add_links,
-		     u16 rem_links)
+		     struct cfg80211_ml_reconf_req *req)
 {
 	struct wiphy *wiphy = &rdev->wiphy;
 	int ret = -EOPNOTSUPP;
 
-	trace_rdev_assoc_ml_reconf(wiphy, dev, add_links, rem_links);
+	trace_rdev_assoc_ml_reconf(wiphy, dev, req);
 	if (rdev->ops->assoc_ml_reconf)
-		ret = rdev->ops->assoc_ml_reconf(wiphy, dev, add_links,
-						 rem_links);
+		ret = rdev->ops->assoc_ml_reconf(wiphy, dev, req);
 	trace_rdev_return_int(wiphy, ret);
 
 	return ret;
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 9aa8081ca454..b82dc7282c20 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2,7 +2,7 @@
 /*
  * Portions of this file
  * Copyright(c) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018, 2020-2024 Intel Corporation
+ * Copyright (C) 2018, 2020-2025 Intel Corporation
  */
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM cfg80211
@@ -4142,9 +4142,8 @@ TRACE_EVENT(cfg80211_mlo_reconf_add_done,
 
 TRACE_EVENT(rdev_assoc_ml_reconf,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
-		 struct cfg80211_assoc_link *add_links,
-		 u16 rem_links),
-	TP_ARGS(wiphy, netdev, add_links, rem_links),
+		 struct cfg80211_ml_reconf_req *req),
+	TP_ARGS(wiphy, netdev, req),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
@@ -4157,9 +4156,9 @@ TRACE_EVENT(rdev_assoc_ml_reconf,
 		u32 i;
 
 		__entry->add_links = 0;
-		__entry->rem_links = rem_links;
-		for (i = 0; add_links && i < IEEE80211_MLD_MAX_NUM_LINKS; i++)
-			if (add_links[i].bss)
+		__entry->rem_links = req->rem_links;
+		for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++)
+			if (req->add_links[i].bss)
 				__entry->add_links |= BIT(i);
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", add_links=0x%x, rem_links=0x%x",
-- 
2.34.1


