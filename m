Return-Path: <linux-wireless+bounces-5058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC32881918
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91BBB235AF
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDBE8594E;
	Wed, 20 Mar 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QeyAgeBR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D230986260
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970043; cv=none; b=gNGIjYcI0uPc8AdHZAzODFIXiCfB2YCbHUoDpqgCamexZQWLSRfTWpkynzoH5L5JBuK4O0CDE0HPdVXpS7LTOje+EqkopeEqdlLt0re6AMMFgw7Cf8cYEOPB1CWJZWYzx96CrTBAkevSJMLU5QY0R6bwkWHOe1MbazMi15M0ZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970043; c=relaxed/simple;
	bh=K0T0YiaEnqSJxu7Su0549h0R7JIe5tnCkwaJAHPRjy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=epswI4vaEOwf+wCIw1ykIKtejENTygTIq3hnE+gGe9lkq5CXDkjiWFpdp0eiRMSbrpqmFbkH+UJOGzZo3xYIijDYd7p4n1rLOf42uuDD0/ZHskq7P47DaiUwJabmXs8US0Z1hg122qFP+elqBqslNdZoOGX37QKhkXwuDjOTTcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QeyAgeBR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970042; x=1742506042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K0T0YiaEnqSJxu7Su0549h0R7JIe5tnCkwaJAHPRjy4=;
  b=QeyAgeBRLElg5jjzFBXSGPjmj4EN2lPgYZNPwJTYQescX9xEwxB8PPro
   m7d7bl0WZGw/mx9bCGjUZ5bJrhFE5H7aNyhfbYVX+GIr0957+jg9M5f8b
   YQhpf36nZ61jM1E6dNCp3KnE59WluXefqWtAlf241eSXjZlJqpnjqD75f
   5N1+eupSQC7lQ32JMLPL0rA0utpYqtu0gbSI5/NsmPRAanLufdquSBG79
   Yfrx/UN4nARVMEyPcCJiZ+vcvrbC25CGzEexVwESAA5bSeoSS9cvSiY1g
   mJrFgD65PvBqRJ2fpPC+UCcE/Tpi+HKAbnE60c/2Ir8v6f/FfmmWgidry
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698146"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698146"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184204"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/17] wifi: iwlwifi: mvm: select STA mask only for active links
Date: Wed, 20 Mar 2024 23:26:36 +0200
Message-Id: <20240320232419.c6818d1c6033.I6357f05c55ef111002ddc169287eb356ca0c1b21@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

During reconfig, we might send keys, but those should be only
sent to already active link stations. Iterate only active ones
to fix that issue.

Fixes: aea99650f731 ("wifi: iwlwifi: mvm: set STA mask for keys in MLO")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 902c64f210aa..5785b70a4aff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -9,7 +9,9 @@
 u32 iwl_mvm_sta_fw_id_mask(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			   int filter_link_id)
 {
+	struct ieee80211_link_sta *link_sta;
 	struct iwl_mvm_sta *mvmsta;
+	struct ieee80211_vif *vif;
 	unsigned int link_id;
 	u32 result = 0;
 
@@ -17,26 +19,27 @@ u32 iwl_mvm_sta_fw_id_mask(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		return 0;
 
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	vif = mvmsta->vif;
 
 	/* it's easy when the STA is not an MLD */
 	if (!sta->valid_links)
 		return BIT(mvmsta->deflink.sta_id);
 
 	/* but if it is an MLD, get the mask of all the FW STAs it has ... */
-	for (link_id = 0; link_id < ARRAY_SIZE(mvmsta->link); link_id++) {
-		struct iwl_mvm_link_sta *link_sta;
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		struct iwl_mvm_link_sta *mvm_link_sta;
 
 		/* unless we have a specific link in mind */
 		if (filter_link_id >= 0 && link_id != filter_link_id)
 			continue;
 
-		link_sta =
+		mvm_link_sta =
 			rcu_dereference_check(mvmsta->link[link_id],
 					      lockdep_is_held(&mvm->mutex));
 		if (!link_sta)
 			continue;
 
-		result |= BIT(link_sta->sta_id);
+		result |= BIT(mvm_link_sta->sta_id);
 	}
 
 	return result;
-- 
2.34.1


