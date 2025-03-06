Return-Path: <linux-wireless+bounces-19859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544BDA54792
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B040D188CBA9
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2431FCCFA;
	Thu,  6 Mar 2025 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7t3G52m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9331DE4EC
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256333; cv=none; b=aB8WhkWnQG9qVylThJPTqpj84j/XLhME+RnvOluz25ZUvmQzX5jT6MoNmIEyUmrRjhvpZ0pUgwwERf311I/HomY/K5FsCw/RZ/Il1A57jKf7FcYyYx661rF9LPjiwHNYtc7109b9TBalfzhNFZr9NM2fBZX/PRtuXbTITrHVov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256333; c=relaxed/simple;
	bh=RWbpWBhYDsGTP4r8i+l8dUM5Rit0ewGtRNFcjfjkCiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uGAuyh0xXzVZBvEf2FD6eha+reJVOUPmRU13e4H9r8anuSbVburj/ThKAs1KzRjcukNhnPgbE+x0NDxYGN12icn83uaHH41n+CZzEnPwFiuGtk5jblCjLVHjf2kkF0B0dLkbjmIIYiNg7ZrOY1pcjcnZ/an73IjdPGcMVUugvk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7t3G52m; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741256332; x=1772792332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RWbpWBhYDsGTP4r8i+l8dUM5Rit0ewGtRNFcjfjkCiw=;
  b=B7t3G52mjS5ZHWelWkW5DwPrLuMS8EIzI3r6V67/jW2+2LyoDo5yd8NK
   q7vu7Tj946u2u1aanN1Ay4NjfkM5P4J15n6nXMPtA0VCG4dMbFV+F3F5I
   0RnS/JIcPZaKD7DFBd0FHTewCx2m1BKG9RdqXi2r2HoOIgoZlMtolNtW7
   XmZ8urpsWGplaL9Vj8n4ZE67dPQRqHJ/yipzCDKZlX3T5RchKJ+DobKy1
   22TezYzzBugtret1o58luIuH/IJUEOVRqoYTxf0q41gs5Vz4SJ5n8Tlwo
   511fnUDFw6qUb2hr7mA8xRy5a3n4erKrXFb7Jfobv9PYuo8TLLKkXxvvK
   w==;
X-CSE-ConnectionGUID: V5uRkMLgRb+ytn9B0SMR2g==
X-CSE-MsgGUID: ghkcJA5sSHqx2ZGCH2l68w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="46181379"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="46181379"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:18:52 -0800
X-CSE-ConnectionGUID: r1wfLiPTQa+GEu77G/DsIQ==
X-CSE-MsgGUID: 14qiM1y4Qj2LUrW2FkijSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118705724"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:18:49 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 4/5] wifi: mac80211: fix SA Query processing in MLO
Date: Thu,  6 Mar 2025 12:18:30 +0200
Message-Id: <20250306121409.bab48bb49061.I9391b22f1360d20ac8c4e92604de23f27696ba8f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306101831.4042303-1-miriam.rachel.korenblit@intel.com>
References: <20250306101831.4042303-1-miriam.rachel.korenblit@intel.com>
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


