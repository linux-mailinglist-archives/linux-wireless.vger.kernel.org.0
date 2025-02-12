Return-Path: <linux-wireless+bounces-18820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26760A31EAC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 07:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39CD167F3A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4CE1FBC9B;
	Wed, 12 Feb 2025 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSyo7aYL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30E01FBE9B
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341396; cv=none; b=gsihy/7Yy5RIR+Qfmp8Ru5Nh0nwtTzJ8JLkcdjj+U/wRqoFm6pWyHApN0N/sPfL/oLXTt6fTkIop7Y/Qord6tnrvOTYa0/niTXMsFrlIYTauxPK88St++cm9CrFBqpFwkcafhu1kEx66OGpQ0jVIKxmw4c2u358qSzh3FH7tCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341396; c=relaxed/simple;
	bh=K3qLytahI/Hnwg89C2kqDbPswhNIvQMD8KpmS9BOANg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmod6+81GTbxBx+s0c5tX+q9lSr76ObD37dixtWdY4ORa1BZ1yhDQsSCsNDzB5pIhLAU464NmiHpj1MczHpTvTc50PXN2Zh/D+Tq3r1r9tcCm5DRGH8eiHZZKM7c4zvCetfdF2/XLlI1A88rkWef4VZGah3dX8KYaC0pHqxRuX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSyo7aYL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739341392; x=1770877392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K3qLytahI/Hnwg89C2kqDbPswhNIvQMD8KpmS9BOANg=;
  b=jSyo7aYLmT+4WSb+utETw+sfUyPWbN527YwtOaBVKwi+3dkCHWesclm/
   N2p+HGABmUX7hky+/GJjvdR65z12bOCojnbtZL5TPMudtSumKZz6vojae
   DAYtIDE8kuwWNBNvhEXOJZPyEFb02Wk1Q1ZcvMlWKoEAyzpT8kovYGh9z
   nV+Wret1iOVMMQkVZFZYmrQK6bSd7yRv3KKdOTKwJptr1azHvJKL8ZBdH
   fe0g0s6mQ4kZ/wv7eiLR47P7pB5GiUil/3OraTwF7bNfwA1S6KvbBXx2J
   XtT1Wbl1gdQCP2K38g5iTB48qjHhhF15p0Z62VCQ2noUoK1cgODrngieD
   g==;
X-CSE-ConnectionGUID: zBECJ22SRHy3izn06KcUZQ==
X-CSE-MsgGUID: njtjUZ+JQjWdPApTJ+JwVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43637630"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="43637630"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:23:12 -0800
X-CSE-ConnectionGUID: dCk4QNssT36rdsmnV7hGWA==
X-CSE-MsgGUID: kwbULl00QZSGz2mazjR/DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112944140"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:23:10 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/2] wifi: cfg80211: expose update timestamp to drivers
Date: Wed, 12 Feb 2025 08:22:58 +0200
Message-Id: <20250212082137.b682ee7aebc8.I0f7cca9effa2b1cee79f4f2eb8b549c99b4e0571@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212062258.454981-1-miriam.rachel.korenblit@intel.com>
References: <20250212062258.454981-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

This information is exposed to userspace but not drivers. Make this
field public so that drivers are also able to access it. The information
is for example useful for link selection to determine whether the BSS
corresponding to an MLO link has been seen in a recent scan.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h | 3 +++
 net/wireless/core.h    | 1 -
 net/wireless/nl80211.c | 4 ++--
 net/wireless/scan.c    | 6 +++---
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a72e7eb7027f..3580f3f5f44e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2947,6 +2947,7 @@ struct cfg80211_bss_ies {
  * @nontrans_list: list of non-transmitted BSS, if this is a transmitted one
  *	(multi-BSSID support)
  * @signal: signal strength value (type depends on the wiphy's signal_type)
+ * @ts_boottime: timestamp of the last BSS update in nanoseconds since boot
  * @chains: bitmask for filled values in @chain_signal.
  * @chain_signal: per-chain signal strength of last received BSS in dBm.
  * @bssid_index: index in the multiple BSS set
@@ -2971,6 +2972,8 @@ struct cfg80211_bss {
 
 	s32 signal;
 
+	u64 ts_boottime;
+
 	u16 beacon_interval;
 	u16 capability;
 
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 826299f3d781..b094b526b05d 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -180,7 +180,6 @@ struct cfg80211_internal_bss {
 	struct list_head list;
 	struct list_head hidden_list;
 	struct rb_node rbn;
-	u64 ts_boottime;
 	unsigned long ts;
 	unsigned long refcount;
 	atomic_t hold;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8bd09110d393..79b3f34e72e2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10519,9 +10519,9 @@ static int nl80211_send_bss(struct sk_buff *msg, struct netlink_callback *cb,
 		     intbss->parent_bssid)))
 		goto nla_put_failure;
 
-	if (intbss->ts_boottime &&
+	if (res->ts_boottime &&
 	    nla_put_u64_64bit(msg, NL80211_BSS_LAST_SEEN_BOOTTIME,
-			      intbss->ts_boottime, NL80211_BSS_PAD))
+			      res->ts_boottime, NL80211_BSS_PAD))
 		goto nla_put_failure;
 
 	if (!nl80211_put_signal(msg, intbss->pub.chains,
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index cd2124329521..65c04d4bfc24 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -5,7 +5,7 @@
  * Copyright 2008 Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2016	Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -1934,7 +1934,7 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 		known->pub.signal = new->pub.signal;
 	known->pub.capability = new->pub.capability;
 	known->ts = new->ts;
-	known->ts_boottime = new->ts_boottime;
+	known->pub.ts_boottime = new->pub.ts_boottime;
 	known->parent_tsf = new->parent_tsf;
 	known->pub.chains = new->pub.chains;
 	memcpy(known->pub.chain_signal, new->pub.chain_signal,
@@ -2291,7 +2291,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 		tmp.pub.signal = 0;
 	tmp.pub.beacon_interval = data->beacon_interval;
 	tmp.pub.capability = data->capability;
-	tmp.ts_boottime = drv_data->boottime_ns;
+	tmp.pub.ts_boottime = drv_data->boottime_ns;
 	tmp.parent_tsf = drv_data->parent_tsf;
 	ether_addr_copy(tmp.parent_bssid, drv_data->parent_bssid);
 	tmp.pub.chains = drv_data->chains;
-- 
2.34.1


