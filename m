Return-Path: <linux-wireless+bounces-4950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 931CD880BCD
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 08:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479E91F2439B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 07:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3CA2208B;
	Wed, 20 Mar 2024 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="faG8jmep"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49AE1EB44
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918876; cv=none; b=hDmLJQWTCCipV37S89GzPzmUKRszJlOBhaHgki3RlzZLMH7ARql1GYa7iMZ86J7/j2fTj0KgFBEayE3aRtzLQSXhl6s/0lbbercJzWCtn6D1lP3PQTHoQbPyUx/K+HknowDGaeN0QPqj8gRvn0w7UocrZm+NMl5Se+OT7OZBcBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918876; c=relaxed/simple;
	bh=/cc65Oa0aaFaRbS1B5xQMhyQXFJsA9V7cUmzv9Rf5io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jv5bQIWDZ+FmznAsgjbtD23VQeRcxMTvQ0goQMYZTtCWMYJftk/yScpDim+T+lcN51FMW3+XREpbfXlDSciYVBPlAzOXp3K30OgcC2w/1wGzXEOtIk+ELqZwYjWDI8NmzDxwLB0n1XxZF1QZ6Ye9rVdsAkxF27zmGgbveDbWJXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=faG8jmep; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710918875; x=1742454875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/cc65Oa0aaFaRbS1B5xQMhyQXFJsA9V7cUmzv9Rf5io=;
  b=faG8jmepqFCdBGb8txEfJ83CfwfQHC6d42c3Rf/NYqgucOURhCxbHunp
   8S0lmSjj+ZYrVTRt8o97mPtuWLC7ToIOhWgg7Ux1QNdKoIOwVuOuMW4w+
   NnODMFPgIOSDVZJnt/P9R1qydD21aDMspRvxKjMRg7QhfW2fsUWBot4d9
   xz3O9WRJRo+ZO3ge0Juox9yq8FS5BoVxYdIV2385ILxCJAKBzDvcT7S8j
   EtPnskLYbLTGQmzzghP3GyCLtrJVvIIitsG4x1Euau0Ub5kPM/Y/zEfWg
   J1/I8EthhqLsrcTnZIrO2enk/tFh7/04/XUAAI9I9rgOxArzoAlObM0Gs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5763850"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5763850"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="14477427"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 8/8] wifi: mac80211: reactivate multi-link later in restart
Date: Wed, 20 Mar 2024 09:14:05 +0200
Message-Id: <20240320091155.d0f18a56335d.Ib3338d93872a4a568f38db0d02546534d3eff810@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320071405.815427-1-miriam.rachel.korenblit@intel.com>
References: <20240320071405.815427-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In case of restart, we currently reactivate multi-link on
interfaces before reconfiguring keys etc. which means the
drivers need to handle this case differently. Enable more
links later to allow them to handle it the same way.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/util.c        | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index fe81ab641620..def611e4e55f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1161,6 +1161,8 @@ struct ieee80211_sub_if_data {
 	struct wiphy_work activate_links_work;
 	u16 desired_active_links;
 
+	u16 restart_active_links;
+
 #ifdef CONFIG_MAC80211_DEBUGFS
 	struct {
 		struct dentry *subdir_stations;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a5d5e05688b4..cda398d8f60d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1932,6 +1932,8 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 					     old);
 		}
 
+		sdata->restart_active_links = active_links;
+
 		for (link_id = 0;
 		     link_id < ARRAY_SIZE(sdata->vif.link_conf);
 		     link_id++) {
@@ -2059,9 +2061,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			WARN_ON(1);
 			break;
 		}
-
-		if (active_links)
-			ieee80211_set_active_links(&sdata->vif, active_links);
 	}
 
 	ieee80211_recalc_ps(local);
@@ -2102,6 +2101,13 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	list_for_each_entry(sdata, &local->interfaces, list)
 		ieee80211_reenable_keys(sdata);
 
+	/* re-enable multi-link for client interfaces */
+	list_for_each_entry(sdata, &local->interfaces, list) {
+		if (sdata->restart_active_links)
+			ieee80211_set_active_links(&sdata->vif,
+						   sdata->restart_active_links);
+	}
+
 	/* Reconfigure sched scan if it was interrupted by FW restart */
 	sched_scan_sdata = rcu_dereference_protected(local->sched_scan_sdata,
 						lockdep_is_held(&local->hw.wiphy->mtx));
-- 
2.34.1


