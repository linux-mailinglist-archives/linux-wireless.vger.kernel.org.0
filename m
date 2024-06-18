Return-Path: <linux-wireless+bounces-9208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F3990D9B8
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 18:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C760E1F248D9
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4855C77F15;
	Tue, 18 Jun 2024 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWzhpdvv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678501442F5
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729076; cv=none; b=XYpAcdGCiVn2b5LyugfFT/7i7DXmWyk/Z7Z98AmU3OzTKSwZ1MurGeFUkKsTqzwG1dU2iKa9mYkwWsYm5F8W/SxPfBopZOLoXMOB89uPqr9BpuWE3/6R6wpMQzmUZekG9s0+XaGfu3RvYLKbMHiMv2Ic9lKgukJ5/i9QAdz7nMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729076; c=relaxed/simple;
	bh=DJmqUu0TjgW3De/1qvBGWjgOoOYB0ZK0viHsFWXTp0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EIwGqrddBdPe8hrftvSJ6xvKFZwOhQkfnGfvjygeVS1irLx1KwlXZxxNUBeo1FzFQAVoLxjwfRVnq8RMrekMwAqS8MNWcsAizXcF8mCtdsKPpJnMBaOTrGurExjaPlsoI1ibGahifZjrpM51bdp0oocvkHMBvwOVXNqgFYzxCgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWzhpdvv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718729074; x=1750265074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DJmqUu0TjgW3De/1qvBGWjgOoOYB0ZK0viHsFWXTp0M=;
  b=iWzhpdvvM0j06UvGqAuSyGjVhdrrHgkeMcPV8oM95VfRWRzpQtdHQKag
   qsPX3uvGFbNU2h1xF2LRqgRqq2GG17vlPK0QEnUZ/PT/Xu9lhwPWe3j+h
   PNv3D2Z5h+UDs7HZsC7WwH5uZoEvMOYD14PI/lgUW99VCUzWb6QSSs8Hi
   JQLiibGdj4j8AI1rbM57x0egQiNbvI1QviT4z5jfhYKDQcoYrxGdpYONB
   gz5UiduPdInFpp9HxfYUL6LjVtKukI3+i7O11C501pWrLFBtXXu7eOaHK
   NiYdWKOBsQTAT89NKyMTvaq0W/4vKGLaoLYv2803F/thqsscz8O0q7mKw
   w==;
X-CSE-ConnectionGUID: Y3mWtYhORMCPumUEFLBg6w==
X-CSE-MsgGUID: XwsLC8LvR9iPpaAB7RlYDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26257191"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26257191"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:34 -0700
X-CSE-ConnectionGUID: IbNGLKALR0GqsRrWXZ2a6w==
X-CSE-MsgGUID: nbs6wXXDQfCK46o8S8k1SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42306530"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/11] wifi: iwlwifi: mvm: dissolve iwl_mvm_mac_remove_interface_common()
Date: Tue, 18 Jun 2024 19:44:09 +0300
Message-Id: <20240618194245.adf54ab5bc4a.I90339f152bba73b622e05063d16ae914ae20053f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
References: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Since the function isn't actually common (any more), just
dissolve it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 21 +++----------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index df2f121aff55..52171900813a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1886,12 +1886,8 @@ void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
 	cancel_delayed_work_sync(&mvmvif->csa_work);
 }
 
-/* This function is doing the common part of removing the interface for
- * both - MLD and non-MLD modes. Returns true if removing the interface
- * is done
- */
-static bool iwl_mvm_mac_remove_interface_common(struct ieee80211_hw *hw,
-						struct ieee80211_vif *vif)
+static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -1939,21 +1935,10 @@ static bool iwl_mvm_mac_remove_interface_common(struct ieee80211_hw *hw,
 			mvm->noa_duration = 0;
 		}
 #endif
-		return true;
+		goto out;
 	}
 
 	iwl_mvm_power_update_mac(mvm);
-	return false;
-}
-
-static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
-					 struct ieee80211_vif *vif)
-{
-	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-
-	if (iwl_mvm_mac_remove_interface_common(hw, vif))
-		goto out;
 
 	/* Before the interface removal, mac80211 would cancel the ROC, and the
 	 * ROC worker would be scheduled if needed. The worker would be flushed
-- 
2.34.1


