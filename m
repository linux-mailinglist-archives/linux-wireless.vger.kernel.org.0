Return-Path: <linux-wireless+bounces-28050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F95ABEE076
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449D03B6C02
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ACA1D618C;
	Sun, 19 Oct 2025 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSvrtfe5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D02309AA
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760861592; cv=none; b=ZGIZ/L8FULJK0zvkZmlkqaIJ3RHHMF0Tu4MTW7NVNPbftuz36zzrpVMNQF9xn5kWSUNSjilMdIiaRvlQ9sditTPdd8nk47Clb/M7Q/ofX8W6Zdq8SEL0bXdpTBbf8gni1t7yJfYsNloJ1JaHtg16AzGBHx6C0Mr/Zzot7b6kIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760861592; c=relaxed/simple;
	bh=XpG0pvoG4/6bEG9W/EmXovktZenANkBgso7cexs9CjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kZyOx2v6BPxIqTNO3YnIlXh1f5zZXR7q1v6BIcNPckGvKUOI9gWNFjeTa8gekzsLjsj5s+YGKdhRR+fMIZjIG3ImojnhXPUK+nYujc/TwBdpywomOxpg5zhSCp9P0KzrdIHp1cOUsM+xZIEF3/TO0ThUiVmLlxQHPv3mCtjATOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSvrtfe5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760861591; x=1792397591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XpG0pvoG4/6bEG9W/EmXovktZenANkBgso7cexs9CjU=;
  b=hSvrtfe5cpr+iwtRWTDwMZUtrFs7zYDCAFzCgMnFF5+EAvVgwVlR/ZLW
   zoCQMA1rqZT6Rr90kqc2FTv3NvBi1yO3Wqy6mBc6a/O9Y2xZbaK8Hyg4W
   QP5GCHWhC8HkCq3DknNd1yMtkew06e/3hTjHpA8DWE9RDrUtaaab4wCLy
   FSCZ+HFWwN1AsQvirxEyQy8BtMurKLRcH36ppEG0Ry1NlKo5fyn/ermgN
   MP7g3Xpmlm79xmu5Az7RSIOAVLTgGSW33siFZYbt8X6KyBlMeKn0y4YNf
   pdqHPlmN8ctIOndpzMgnKoqLkwgP/9U0lIKL4856om8uaufwjoxzFDcdj
   Q==;
X-CSE-ConnectionGUID: fczQnpa0RZ2y79A6Zhdr4A==
X-CSE-MsgGUID: fkPHsl/PSaeRdUv6jBXtiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62912542"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="62912542"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:13:11 -0700
X-CSE-ConnectionGUID: VZUxh7k+Rl+N8PT6nUdxrw==
X-CSE-MsgGUID: zH4tKfOQSSiZsSxF0Ftwcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="183501616"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:13:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/4] wifi: mac80211: use wiphy_hrtimer_work for ml_reconf_work
Date: Sun, 19 Oct 2025 11:12:58 +0300
Message-Id: <20251019111003.848224b7f4d1.I063c5c15bf7672f94cea75f83e486a3ca52d098f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019081259.2455317-1-miriam.rachel.korenblit@intel.com>
References: <20251019081259.2455317-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The work item may be scheduled relatively far in the future. As the
event happens at a specific point in time, the normal timer accuracy is
not sufficient in that case.

Switch to use wiphy_hrtimer_work so that the accuracy is sufficient.

Fixes: 8eb8dd2ffbbb ("wifi: mac80211: Support link removal using Reconfiguration ML element")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
PerCI-Ready: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mlme.c        | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index eb22279c6e01..eb38049b2252 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -612,7 +612,7 @@ struct ieee80211_if_managed {
 	u8 *assoc_req_ies;
 	size_t assoc_req_ies_len;
 
-	struct wiphy_delayed_work ml_reconf_work;
+	struct wiphy_hrtimer_work ml_reconf_work;
 	u16 removed_links;
 
 	/* TID-to-link mapping support */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 623a46b3214e..f95bcf84ecc2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4249,7 +4249,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 				  &ifmgd->neg_ttlm_timeout_work);
 
 	sdata->u.mgd.removed_links = 0;
-	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+	wiphy_hrtimer_work_cancel(sdata->local->hw.wiphy,
 				  &sdata->u.mgd.ml_reconf_work);
 
 	wiphy_work_cancel(sdata->local->hw.wiphy,
@@ -6876,7 +6876,7 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 		/* In case the removal was cancelled, abort it */
 		if (sdata->u.mgd.removed_links) {
 			sdata->u.mgd.removed_links = 0;
-			wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+			wiphy_hrtimer_work_cancel(sdata->local->hw.wiphy,
 						  &sdata->u.mgd.ml_reconf_work);
 		}
 		return;
@@ -6906,9 +6906,9 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 	}
 
 	sdata->u.mgd.removed_links = removed_links;
-	wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+	wiphy_hrtimer_work_queue(sdata->local->hw.wiphy,
 				 &sdata->u.mgd.ml_reconf_work,
-				 TU_TO_JIFFIES(delay));
+				 us_to_ktime(ieee80211_tu_to_usec(delay)));
 }
 
 static int ieee80211_ttlm_set_links(struct ieee80211_sub_if_data *sdata,
@@ -8793,7 +8793,7 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 			ieee80211_csa_connection_drop_work);
 	wiphy_delayed_work_init(&ifmgd->tdls_peer_del_work,
 				ieee80211_tdls_peer_del_work);
-	wiphy_delayed_work_init(&ifmgd->ml_reconf_work,
+	wiphy_hrtimer_work_init(&ifmgd->ml_reconf_work,
 				ieee80211_ml_reconf_work);
 	wiphy_delayed_work_init(&ifmgd->reconf.wk,
 				ieee80211_ml_sta_reconf_timeout);
-- 
2.34.1


