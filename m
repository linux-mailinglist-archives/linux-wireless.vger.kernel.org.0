Return-Path: <linux-wireless+bounces-8530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7258FC98A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 12:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CCE1C23DFD
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661F4192B63;
	Wed,  5 Jun 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GdVkxeOt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80B1922F2
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585055; cv=none; b=hjJJbnF6o0UI4xeLhC09jAVZAoOOxONkcIEl4w/y+y1jPICg5YqlR9A5B8nOrAVOkd+Gg9sVjqug62AZnrQnPYkwv0SA5UzTHpNGUy7FF39nRBg8gnikBNR9/8lV+YRRHynKf+wB2DXc9xmx5Xj8ncXFrMICZ1XNVWEOMYlzGQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585055; c=relaxed/simple;
	bh=CaEISvJyN/0psLQBRsjv7+sN8zXe3+9OTQJNa0AMTFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AAAS+1w3PYQHyW0u/uV2FgvbZamWgWQDjCb3UOQY3MR5bs6X1m6IRXL8GruJBsVi8Tu+rdwurJ2x7Lkl906/VXoSYzci/vTf7z+uWwIhyAVfXYbulsTPqRptXI9xi+qB76GZRhJyTb/51AMSGxb78uoSrD99dllvZ7N38A9uFkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GdVkxeOt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585054; x=1749121054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CaEISvJyN/0psLQBRsjv7+sN8zXe3+9OTQJNa0AMTFc=;
  b=GdVkxeOtbSwy7P5iymdYoawHRU+dfOiXRb/aqGkz6dZScJKPSW/PmWEl
   /ZpYZQNKST+6FD7TTsaWnqH3obGzuojVGLoNevZTVoo30ZSl7LibrvRL5
   Jt3ur/lEJ65gfaLX2uuD9XT9Tyjb0zdhirzqbD+usogkU47VQEHGHmD+L
   13Mid1m7r/j5W+hbx9PKBY+KAPp5TeQKMqbwDrIwDlmJfSGSzhD0bRLwr
   n6MhC5JD3FmxmywPCPANbQwG10uQHUdYJRphAD8ojqedCH3fY0/p27u2x
   DKNkVjG8p9SysocynmxoKeceGIdo0NA+UQYj5FFBsxRzhJ5/ISzzzPSx+
   g==;
X-CSE-ConnectionGUID: 99jTNo3rTgyFyC20WbvGHQ==
X-CSE-MsgGUID: WJDLElhRQ4yHtMj87Cv1rA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="11919951"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="11919951"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:57:34 -0700
X-CSE-ConnectionGUID: ZdsyfBOvRlGRQhv/S5S8/g==
X-CSE-MsgGUID: 73koYEMnTZiUXFDCKSF41Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37563012"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:57:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/7] wifi: mac80211: fix erroneous errors for STA changes
Date: Wed,  5 Jun 2024 13:57:18 +0300
Message-Id: <20240605135233.48e2b8af07e3.Ib9793c383fcba118c05100e024f4a11a1c3d0e85@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
References: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When e.g. wpa_supplicant sets only the MLD "sta" authorized
state, the code actually applies that change, but then returns
an error to userspace anyway because there were no changes to
the link station, and no link ID was given. However, it's not
incorrect to not have a link ID when wanting to change only
the MLD peer ("sta") state, so the code shouldn't require it.

To fix this, separate the "new_link" argument out into a new
three-state enum, because if modify is called on a link STA
only, it should return an error if no link is given or if it
doesn't exist. For modify on the MLD "sta", not having a link
ID is OK, but if there is one it should be validated.

This seems to not have mattered much as wpa_supplicant just
prints a message and continues, and the authorized state was
already set before this error return. However, in the later
code powersave recalculation etc. will be skipped, so that it
may result in never allowing powersave on MLO connections.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c | 55 ++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 62119e957cd8..54b03a86f71e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1814,8 +1814,15 @@ static void sta_apply_mesh_params(struct ieee80211_local *local,
 #endif
 }
 
+enum sta_link_apply_mode {
+	STA_LINK_MODE_NEW,
+	STA_LINK_MODE_STA_MODIFY,
+	STA_LINK_MODE_LINK_MODIFY,
+};
+
 static int sta_link_apply_parameters(struct ieee80211_local *local,
-				     struct sta_info *sta, bool new_link,
+				     struct sta_info *sta,
+				     enum sta_link_apply_mode mode,
 				     struct link_station_parameters *params)
 {
 	int ret = 0;
@@ -1827,18 +1834,29 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	struct link_sta_info *link_sta =
 		rcu_dereference_protected(sta->link[link_id],
 					  lockdep_is_held(&local->hw.wiphy->mtx));
-
-	/*
-	 * If there are no changes, then accept a link that exist,
-	 * unless it's a new link.
-	 */
-	if (params->link_id >= 0 && !new_link &&
-	    !params->link_mac && !params->txpwr_set &&
-	    !params->supported_rates_len &&
-	    !params->ht_capa && !params->vht_capa &&
-	    !params->he_capa && !params->eht_capa &&
-	    !params->opmode_notif_used)
-		return 0;
+	bool changes = params->link_mac ||
+		       params->txpwr_set ||
+		       params->supported_rates_len ||
+		       params->ht_capa ||
+		       params->vht_capa ||
+		       params->he_capa ||
+		       params->eht_capa ||
+		       params->opmode_notif_used;
+
+	switch (mode) {
+	case STA_LINK_MODE_NEW:
+		if (!params->link_mac)
+			return -EINVAL;
+		break;
+	case STA_LINK_MODE_LINK_MODIFY:
+		break;
+	case STA_LINK_MODE_STA_MODIFY:
+		if (params->link_id >= 0)
+			break;
+		if (!changes)
+			return 0;
+		break;
+	}
 
 	if (!link || !link_sta)
 		return -EINVAL;
@@ -1848,15 +1866,13 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 		return -EINVAL;
 
 	if (params->link_mac) {
-		if (new_link) {
+		if (mode == STA_LINK_MODE_NEW) {
 			memcpy(link_sta->addr, params->link_mac, ETH_ALEN);
 			memcpy(link_sta->pub->addr, params->link_mac, ETH_ALEN);
 		} else if (!ether_addr_equal(link_sta->addr,
 					     params->link_mac)) {
 			return -EINVAL;
 		}
-	} else if (new_link) {
-		return -EINVAL;
 	}
 
 	if (params->txpwr_set) {
@@ -2028,7 +2044,7 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	if (params->listen_interval >= 0)
 		sta->listen_interval = params->listen_interval;
 
-	ret = sta_link_apply_parameters(local, sta, false,
+	ret = sta_link_apply_parameters(local, sta, STA_LINK_MODE_STA_MODIFY,
 					&params->link_sta_params);
 	if (ret)
 		return ret;
@@ -5004,7 +5020,7 @@ ieee80211_add_link_station(struct wiphy *wiphy, struct net_device *dev,
 	if (ret)
 		return ret;
 
-	ret = sta_link_apply_parameters(local, sta, true, params);
+	ret = sta_link_apply_parameters(local, sta, STA_LINK_MODE_NEW, params);
 	if (ret) {
 		ieee80211_sta_free_link(sta, params->link_id);
 		return ret;
@@ -5031,7 +5047,8 @@ ieee80211_mod_link_station(struct wiphy *wiphy, struct net_device *dev,
 	if (!(sta->sta.valid_links & BIT(params->link_id)))
 		return -EINVAL;
 
-	return sta_link_apply_parameters(local, sta, false, params);
+	return sta_link_apply_parameters(local, sta, STA_LINK_MODE_LINK_MODIFY,
+					 params);
 }
 
 static int
-- 
2.34.1


