Return-Path: <linux-wireless+bounces-24063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED80AD6F6A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321A81788C6
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3ED23E330;
	Thu, 12 Jun 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GcxMsdUF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD3B23D29A
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728968; cv=none; b=oAXcaY2Zk6UKotLpFV67WQgVuOhW4Krfa2VxHINkPZv3GXtsuC29ho/ob99KFb4whRIO0tbPZwg88iBnK+z+D4Wgon2f4pXzZKEn9hDmm45lqf8wuLDLfe5WXcdhxmdDPUf5gb5X0bdOIqC21WMzOODTleREJ5CRfssp4DLMYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728968; c=relaxed/simple;
	bh=MfnEMpWbvkY4ZJZwbD91PBh4RTIt9dFlPYMT9b9HAWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H1WsfsWSTLTzzdiuidtBMNiG2sUG+OfRp0m7vxipB9nIXeC0YxifZJygzTKX76KnQXQ0CwRP7A+R2mbi69pCxzPmjPe9dkgNAu3hZxK4RfuoGE2k7hDfjomO6STIq+id7SsYGrSFZnVh60Ba9KjrXN7nkPfnWgRhw2qjfe5KJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GcxMsdUF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749728968; x=1781264968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MfnEMpWbvkY4ZJZwbD91PBh4RTIt9dFlPYMT9b9HAWw=;
  b=GcxMsdUFGaVlls5wr2C32CyPNOHqnUVc4JE+Rs/wqJhfDnM9AOu0Bxcs
   Fd5v8RnO05kyYFc8rk7pqLlijezIN8BcJTquVnNVSsxptZXuFJny1n1fP
   OjizJMUAPBopmHcmNz6dU14ICGlnIZDaUUdhbpz6oldLYJuN7IQC9G6dz
   k6FbQ36WU+uC3y3opEmPbuT0+C1rq/rId5IXjzgeagA7YI9Pege1voS5t
   V33zEx3Q5S2nfwmg5JD3yMjDwCUPimfxRZR+GUC0rAVOJsqwlgIhe3Tlb
   y3N4r4kuPhEnC0U0hDKK/KTy/OxdgDZ2/ui29lc22BLA+XhdOjw9pCFEF
   Q==;
X-CSE-ConnectionGUID: o99ikrq9TbaPwPVUoQuerg==
X-CSE-MsgGUID: Fyqzc8xEQHaRcApHysO1vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63248346"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="63248346"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:28 -0700
X-CSE-ConnectionGUID: f9lVAzPuTfaPdLaT1hz2ng==
X-CSE-MsgGUID: fy2+AxslQB+G52ccrsx6LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147382160"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/13] wifi: iwlwifi: mld: make iwl_mld_add_all_rekeys void
Date: Thu, 12 Jun 2025 14:48:55 +0300
Message-Id: <20250612144708.4c38fb4c48f4.Ia62100a54370b6af5e528ba10c8f21e177018096@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
References: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

No one checks its return value anyway.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index b156cf56a30d..d9af9a2b1e6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -868,7 +868,7 @@ iwl_mld_add_mcast_rekey(struct ieee80211_vif *vif,
 	return true;
 }
 
-static bool
+static void
 iwl_mld_add_all_rekeys(struct ieee80211_vif *vif,
 		       struct iwl_mld_wowlan_status *wowlan_status,
 		       struct iwl_mld_resume_key_iter_data *key_iter_data,
@@ -881,21 +881,19 @@ iwl_mld_add_all_rekeys(struct ieee80211_vif *vif,
 					     &wowlan_status->gtk[i],
 					     link_conf,
 					     key_iter_data->gtk_cipher))
-			return false;
+			return;
 
 	if (!iwl_mld_add_mcast_rekey(vif, key_iter_data->mld,
 				     &wowlan_status->igtk,
 				     link_conf, key_iter_data->igtk_cipher))
-		return false;
+		return;
 
 	for (i = 0; i < ARRAY_SIZE(wowlan_status->bigtk); i++)
 		if (!iwl_mld_add_mcast_rekey(vif, key_iter_data->mld,
 					     &wowlan_status->bigtk[i],
 					     link_conf,
 					     key_iter_data->bigtk_cipher))
-			return false;
-
-	return true;
+			return;
 }
 
 static bool
-- 
2.34.1


