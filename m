Return-Path: <linux-wireless+bounces-19873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B17A5480E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75313B2F69
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AB120B205;
	Thu,  6 Mar 2025 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3hhAx7w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE92046BD
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257500; cv=none; b=cd3mPqg235NEJZWI3WVUwS4wJYPooc3pWpeuuWUBC1NFmHt2NQiTQZcMj3aEttjpgOgPQXYXXJcERmW/qMUFQqY9RQew5kG8ePMAB6o3sqw2Nfirv8kiogMOJ0RSwRv6r9IOeFvgGl9ukrMkJmdLsF+gEZoghN5WwAH1KThAYsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257500; c=relaxed/simple;
	bh=RWbpWBhYDsGTP4r8i+l8dUM5Rit0ewGtRNFcjfjkCiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R9DpudcOxZs3nRStwSJ578ufboRmNaq/eaaA4Ib93wq2VormYfULsbfRISgb/XPShIpfBIoxylBS8RXJHCIVbdVybAOT0oMX4Gn76XCpC/5wePzKeV5W4d0t/jD6DuRwMZAau5f/eTs10qiC5undBCQipzfBxQQxoatf/hY6pKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3hhAx7w; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257499; x=1772793499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RWbpWBhYDsGTP4r8i+l8dUM5Rit0ewGtRNFcjfjkCiw=;
  b=C3hhAx7wnHt30NvlcNDg9ij4tqP/SujI+6ajmtf4JFY0sw8/+rZLCZGo
   u6fJVrD+NETQKz27oGE9wwrPJIRHk7LWzgdgCUn6edDsfn7OEG/ZoP9Kz
   D+/wfrpld24BuL1cIfMIjLW3PtWAT2XtZHacWOwLeLyxYUc2RWcASoNz1
   flALQRL+AWcAzRpbEeDt0NOsiny3GX1X8ZkpaK3UGiH0bv7CWWcJ3f//T
   cz8On9gkLzc7560MkUTjdt1/5Oyn/AfXoQ4a4KrYvSmk++f3Y8Q0+iwI+
   /HTaKHz8QH9O0OmLeoWzh8sMubvRUqUpTuzTqc9XxAbT4tBJauacGYxd4
   Q==;
X-CSE-ConnectionGUID: lG7X7bp8SxGLbOYMOSr3Jg==
X-CSE-MsgGUID: RVYcOwoxSxOqVorgF+Ri6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45915030"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="45915030"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:38:18 -0800
X-CSE-ConnectionGUID: mPmWJtO6QHyuN4r2iKlq9g==
X-CSE-MsgGUID: NwwH75GoRO2CMNMjRaKfsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123138389"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:38:16 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2 wireless 4/5] wifi: mac80211: fix SA Query processing in MLO
Date: Thu,  6 Mar 2025 12:37:58 +0200
Message-Id: <20250306123626.bab48bb49061.I9391b22f1360d20ac8c4e92604de23f27696ba8f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306103759.4102293-1-miriam.rachel.korenblit@intel.com>
References: <20250306103759.4102293-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When MLO is used and SA Query processing isn't done by
userspace (e.g. wpa_supplicant w/o CONFIG_OCV), then
the mac80211 code kicks in but uses the wrong addresses.
Fix them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/rx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 1e28efe4203c..0659ec892ec6 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -6,7 +6,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 
 #include <linux/jiffies.h>
@@ -3329,8 +3329,8 @@ static void ieee80211_process_sa_query_req(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 
-	if (!ether_addr_equal(mgmt->sa, sdata->deflink.u.mgd.bssid) ||
-	    !ether_addr_equal(mgmt->bssid, sdata->deflink.u.mgd.bssid)) {
+	if (!ether_addr_equal(mgmt->sa, sdata->vif.cfg.ap_addr) ||
+	    !ether_addr_equal(mgmt->bssid, sdata->vif.cfg.ap_addr)) {
 		/* Not from the current AP or not associated yet. */
 		return;
 	}
@@ -3346,9 +3346,9 @@ static void ieee80211_process_sa_query_req(struct ieee80211_sub_if_data *sdata,
 
 	skb_reserve(skb, local->hw.extra_tx_headroom);
 	resp = skb_put_zero(skb, 24);
-	memcpy(resp->da, mgmt->sa, ETH_ALEN);
+	memcpy(resp->da, sdata->vif.cfg.ap_addr, ETH_ALEN);
 	memcpy(resp->sa, sdata->vif.addr, ETH_ALEN);
-	memcpy(resp->bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
+	memcpy(resp->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
 	resp->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 					  IEEE80211_STYPE_ACTION);
 	skb_put(skb, 1 + sizeof(resp->u.action.u.sa_query));
-- 
2.34.1


