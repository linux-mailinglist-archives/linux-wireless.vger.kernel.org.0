Return-Path: <linux-wireless+bounces-28340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B305C14464
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 12:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09691581948
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 11:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFC2305E37;
	Tue, 28 Oct 2025 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3rrUkDb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4230E305953
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649132; cv=none; b=oAaRTUnMs4SshbAgwqHL1nJ6AM/6XpDVL2pXghyCxzm4XVz+cm8mC0UEkLERqZN0KgDTIM9k6fr2EXxbBa4ANDuyZ/kRXL2cW3vU/4VqnRBv5TRWGpuQrPWteNOSbC51K0/SYeAQ04iNnaPvVogDIcVzagl0DXDIgS31yg7W34Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649132; c=relaxed/simple;
	bh=MaXb/baAerMy4aMLyl7lo2++61vONNLz9Wovw/JxhmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EbhxcShJIFE3QDsq84L4ntPlbO/pT+NAP9JCs1nRWRPtQrn+XPoj51C55hyZBgB+guU70LC0Xx5P9ykJBqlE5yk9aEjtNhNGAc4vzw9rDwlfxVsA28WZfNh7RccSJYqSVKiG6ATPN07GiMdGgwyHfw4fGdKYdJKKsc9U2h8Cq5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3rrUkDb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761649131; x=1793185131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MaXb/baAerMy4aMLyl7lo2++61vONNLz9Wovw/JxhmU=;
  b=D3rrUkDbc06LfdbQpcka36hjghpgO6r876f+Pf6q5KpY/3gVERH0iIcK
   3H5U7PZoDLXR7/ReOv2jSRc2NfMgR3+PuBGRIfRanf5sV77qpjEypPnsW
   AjEyeC8nxphlW62tVzQkPkYF4O3ghLlBvw2Ke4dRE1YJzuoJ1Hwxl+NMg
   XpjA6weWEFCo7y+3D4kUdatzG5xjNnHcZe9Amf2Pzw4majBmOsH0FPYEL
   fdAIYwnEAS1UVo9dyJSspdwj3xvFAJY8WmtQbPOyiNQdz9POOlSH+ORi0
   QU7uPYx3KujL+3O+dRqXiE9YOVKKlyglNBADeQa860cu8LTvoaQIu5s//
   g==;
X-CSE-ConnectionGUID: lrrODjuqQAK3JyTs8jrFIA==
X-CSE-MsgGUID: DBIFAxFySwO7T6s5nusezA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89215635"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="89215635"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:58:51 -0700
X-CSE-ConnectionGUID: R6L2a4scRYir8PCxqugUPw==
X-CSE-MsgGUID: Y3un5m5sSMOtw2F+ZWRICg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="184549955"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:58:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless v4 3/4] wifi: mac80211: use wiphy_hrtimer_work for ml_reconf_work
Date: Tue, 28 Oct 2025 12:58:39 +0200
Message-Id: <20251028125710.24a7b54e9e37.I063c5c15bf7672f94cea75f83e486a3ca52d098f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028105840.3140483-1-miriam.rachel.korenblit@intel.com>
References: <20251028105840.3140483-1-miriam.rachel.korenblit@intel.com>
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


