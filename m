Return-Path: <linux-wireless+bounces-13598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E23A992AF9
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490691F2357E
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 12:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0972A1D2F72;
	Mon,  7 Oct 2024 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N117laOt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C111D2F48
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302493; cv=none; b=Vpd8hVcWjEC7Tw0bgLHoDNTA+lQmKm5RgAtbSbv+D41SkIuU38RcMh+F2y2S3yJW9VrhOpc4hISEjS8cemnwhzrDqYMCk7/RVCGM24IJtiMERsrrsVGrFrhJc8PghczpXodvYIjtYEtWXLJ0HIRuvdKjoysHHyLi5S2V8mwFHII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302493; c=relaxed/simple;
	bh=TfUn4ISymV1iL9FqGKKez+Ty0zJpO1qMDCA5sjndxtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RPJ9n2Or3+6k65tyf1VC8/xYsd4s+W7fg5Usqm3yDIjHdwKN86WgMDCvcUUBIXImuHMherGaWmwzoZVRqGlrD8a4W4ixUxyqsJxG7tiaCSdKfLznJjuzZa+njYK5Q6yxjJkT7dEH6NLcXJR5IhvuBXqEsVFnpq30MgQsuvZCXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N117laOt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728302492; x=1759838492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TfUn4ISymV1iL9FqGKKez+Ty0zJpO1qMDCA5sjndxtc=;
  b=N117laOtj8mZm1dPjRnj2FjvvDiMQvS6fRA3rDjNa026O9g0XBABl5x6
   oUqazKlmQZb9Q3Yb+s27k0tl6cCnydMUDDDF2y/oJMvzFvr9HK9D4HgZi
   ZzMS7S/iE3p9myCCXwhdxA2NdnqwGQXbJdXMB3dtjXlrRmVzm8UrvvS01
   mYRqJ65+aSkVJV96C6RywstoSMHqP+VajeZWmv8WNYuz/yiQ+CbvQdx57
   mqKrmQ2vZDA+WmagEeVCqbfvElB0TtEcFKdfd/q5ArIYECdsLJXHfDAcX
   04yKpPpUapGjANnlkHYM0eQoBuCRt2ls8xB/CE8BO1i+nZNQ8z4Jbt2V8
   w==;
X-CSE-ConnectionGUID: MLPmiXrZTXqvlzANFzbYeg==
X-CSE-MsgGUID: 2Sd7hZgDR9GjPoaB8eQx/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38099443"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38099443"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:32 -0700
X-CSE-ConnectionGUID: acj/Tj/5SmSe0N9DFG5a6Q==
X-CSE-MsgGUID: 6A64x1FRSNWPiyWhyBLYgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75019285"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/14] wifi: mac80211: chan: calculate min_def also for client mode
Date: Mon,  7 Oct 2024 15:00:57 +0300
Message-Id: <20241007144851.95a39c4f6f45.I2e7517fb1a7221dc6f60b0c752e4882042b4265d@changeid>
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

In order to deal with (temporary) bandwidth reductions to/from
the AP such as the upcoming RX OMI changes, modify the min_def
calculation to also not take the chanreq width into account in
client mode. This normally changes nothing as the AP bandwidth
will be the same as the channel request's width. In the RX OMI
changes, however, the code will reduce the bandwidth for only
the AP STA, since the OMI is only to that, and TDLS STAs are
unaffected. Using the min_def for this case simplifies RX OMI
a lot.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/chan.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index e01302ea9157..04db6f3ae528 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -323,18 +323,26 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 			continue;
 
 		switch (link->sdata->vif.type) {
-		case NL80211_IFTYPE_AP:
-		case NL80211_IFTYPE_AP_VLAN:
-			width = ieee80211_get_max_required_bw(link);
-			break;
 		case NL80211_IFTYPE_STATION:
+			if (!link->sdata->vif.cfg.assoc) {
+				/*
+				 * The AP's sta->bandwidth may not yet be set
+				 * at this point (pre-association), so simply
+				 * take the width from the chandef. We cannot
+				 * have TDLS peers yet (only after association).
+				 */
+				width = link->conf->chanreq.oper.width;
+				break;
+			}
 			/*
-			 * The ap's sta->bandwidth is not set yet at this
-			 * point, so take the width from the chandef, but
-			 * account also for TDLS peers
+			 * otherwise just use min_def like in AP, depending on what
+			 * we currently think the AP STA (and possibly TDLS peers)
+			 * require(s)
 			 */
-			width = max(link->conf->chanreq.oper.width,
-				    ieee80211_get_max_required_bw(link));
+			fallthrough;
+		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_AP_VLAN:
+			width = ieee80211_get_max_required_bw(link);
 			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
 		case NL80211_IFTYPE_NAN:
-- 
2.34.1


