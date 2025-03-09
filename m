Return-Path: <linux-wireless+bounces-20083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB76A580AB
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 06:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F611189012E
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 05:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC4A54F8C;
	Sun,  9 Mar 2025 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1Uc/0Fz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA6136351
	for <linux-wireless@vger.kernel.org>; Sun,  9 Mar 2025 05:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741498638; cv=none; b=bO29X/HWLcrdgq0mRD86crzPQ1mxEC2Nowxi9BTXpyrDKUH8zJIOux1yNlIbVYYmZdGQWQ3/6D47qSlaanVrf1gd0GygbwFn40u6ZGw/4S/Mbr6viIkOOXSuhT+Tkf3sazhZXyQe0RpgU9yyVOXLsrIikVYoNCyLrF924IrLojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741498638; c=relaxed/simple;
	bh=WLUhtHJhudWqJPWAQV2HbGbmgk9SwTLmDIYLA1wZ0Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZpWDSaDZ9YVsps2NQRVJezH0h/7mFxlu9SzJF/9dxLaFSSDurr/UlQIy/0PeDwjNObfrxkt17BQZ1ix4RxxamkXFulJC16mBDfNv++OGY5XgeKqMW7/ZF0A+ydXRwYIzJMUj8LQI6qVE5qI93dDvI2ZsXsiCBfvRHHsuMF/qAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1Uc/0Fz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741498637; x=1773034637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WLUhtHJhudWqJPWAQV2HbGbmgk9SwTLmDIYLA1wZ0Bc=;
  b=J1Uc/0FzqB52pMdUZOmzNrS2r9/Xu5cBIzKK3rB7imsI3wB7NrI5f9BY
   LDq5Y1zSutNWsKH47n5AW5iFt0Vo9D0FJACLcI6mHBbrgOwjcBMFlW0yP
   GkB2pXKrFqE0q2UKQTnKOPvmbnSjvU2SRdDmR+ReRI3zmHxS2siL1SAcO
   diztzL5mfMpuClILJdQcimK9n758t9lEMQhNp+LwRwhr7ClCemtamfKMB
   T1rbZeLpY5baKzw0wfOpIee+G38RtXT2cPCPfe3ifMpDpatcINkhr7tVM
   fHJ2Qw5MgI66Hc3ocz2k8NM12OMRZXsvHRKJrtdGObQkri1zZDU2d0fSZ
   Q==;
X-CSE-ConnectionGUID: 9Vuv5NTxRB2Fi1KHijtkBA==
X-CSE-MsgGUID: 5agJ7pD+SueQ4TjIbxZEmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41671696"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="41671696"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:17 -0800
X-CSE-ConnectionGUID: GUqhKw7sQhGi5KXp7VkgHg==
X-CSE-MsgGUID: 0aQW+IQqSxehQJSKSyJklQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="150470628"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:15 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 wireless-next 07/15] wifi: iwlwifi: mld: use the right iface iterator in low_latency
Date: Sun,  9 Mar 2025 07:36:45 +0200
Message-Id: <20250309073442.925cdca61ed0.I34f5c52d27414cb4c301bbd24df7c3530a43fa1d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
References: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We used ieee80211_iterate_active_interfaces instead of
ieee80211_iterate_active_interfaces_mtx, which is the one to use when
the wiphy lock is held.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/low_latency.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c b/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
index 439fc10a4a41..e74e66735f52 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
@@ -120,9 +120,9 @@ static void iwl_mld_low_latency_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 		wiphy_delayed_work_queue(mld->wiphy, &mld->low_latency.work,
 					 MLD_LL_ACTIVE_WK_PERIOD);
 
-	ieee80211_iterate_active_interfaces(mld->hw,
-					    IEEE80211_IFACE_ITER_NORMAL,
-					    iwl_mld_low_latency_iter, mld);
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_ITER_NORMAL,
+						iwl_mld_low_latency_iter, mld);
 }
 
 int iwl_mld_low_latency_init(struct iwl_mld *mld)
-- 
2.34.1


