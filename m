Return-Path: <linux-wireless+bounces-18457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E72CEA278E6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92FBA7A14B2
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F261216E09;
	Tue,  4 Feb 2025 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQVGqIOf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E78216E06
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691033; cv=none; b=DfZLgwuuUpt0zr9zEeJ5a6vJfX+UmtO1sqkAs/QPc2jnlpXSpNkfJlJidXkJMLhVEVsaeDqH8t6V9Vgvc0j9J8p1twuWhdHqkUFlhJ3aZ7G8sTZiIXx6yxxtkrxXRFauid6leOpkPgkXLIhgaLEIWkIYKVLTPpTZZyUPz6re7XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691033; c=relaxed/simple;
	bh=2p3wIanMvJ9F+sePUllkeyny16eBQd3LXbnFS09w2fI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GqvXnnNVq0Q3heaLM9NFfGov30F33S1TQokHuO7vTw2W0v+/X5tH5G6ugBMETvP2LO2upKCKb9fCfNBxiYUMzCpp5C3ERdLSlLMl+GMwbhINed97hboxiCAGuxrJiLVOKwYzsrxAai2ghxa3UpDa9y+j19hywFADrvdbPPZdI8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQVGqIOf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691032; x=1770227032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2p3wIanMvJ9F+sePUllkeyny16eBQd3LXbnFS09w2fI=;
  b=IQVGqIOfevzCuiFRBz57GEOVOLiGnSev4Qd++gDH9aqA4Y2zKMwzUSx5
   Oh3e2KK+G6xVGE2h8oF3NW86FYeaKO5h5zdaKSd5nEnIfRDYVxEiEwjZM
   ITSjcyRROy1z+pVxQb5Ajoce8TklNV9yJ9x0XzkgckCRMje9vCxAPebME
   jI55nSA8+U2EhYbeHfU/RmTO6hAldRzJdVofnXReTP3jCdlWWmRnzOhfx
   mR9VH0CF5uc2LRdS4ONo/i9Qwr3ufjXVHwhJS/c0ki6OR4llJz5Rds2v7
   Fe1LGS4VIZa7xXYCowb7xUuAGfX2WqY/L2OwZ18xk5Csh/7GzfSkgg4CX
   Q==;
X-CSE-ConnectionGUID: mbUoccLWThGfTodNKPgBdQ==
X-CSE-MsgGUID: fyzILVv2StyLrZCI/Lre7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585478"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585478"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:43:03 -0800
X-CSE-ConnectionGUID: p03+/AlFRFundzXNkH4TCA==
X-CSE-MsgGUID: vBtDz1SVSKi04eZ3gZcB7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696848"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:43:01 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 18/20] wifi: mac80211: don't queue sdata::work for a non-running sdata
Date: Tue,  4 Feb 2025 19:42:15 +0200
Message-Id: <20250204193721.0aba6305a228.I4949e71ed56e7186ed4968fa9ddff477473fa2f4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
References: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The worker really shouldn't be queued for a non-running interface.
Also, if ieee80211_setup_sdata is called between queueing and executing
the wk, it will be initialized, which will corrupt wiphy_work_list.

Fixes: f8891461a277 ("mac80211: do not start any work during reconfigure flow")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/util.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index f6b631faf4f7..be579af252be 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -6,7 +6,7 @@
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  *
  * utilities for mac80211
  */
@@ -2192,8 +2192,10 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		ieee80211_reconfig_roc(local);
 
 		/* Requeue all works */
-		list_for_each_entry(sdata, &local->interfaces, list)
-			wiphy_work_queue(local->hw.wiphy, &sdata->work);
+		list_for_each_entry(sdata, &local->interfaces, list) {
+			if (ieee80211_sdata_running(sdata))
+				wiphy_work_queue(local->hw.wiphy, &sdata->work);
+		}
 	}
 
 	ieee80211_wake_queues_by_reason(hw, IEEE80211_MAX_QUEUE_MAP,
-- 
2.34.1


