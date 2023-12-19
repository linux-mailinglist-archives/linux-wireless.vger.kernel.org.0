Return-Path: <linux-wireless+bounces-1031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1344F81911F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D351F24CBE
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 19:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4A739AD8;
	Tue, 19 Dec 2023 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMBAiDvG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A339AE0
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703015974; x=1734551974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ezcOkpBExqJCuyt2yqB1mPY18Yxi/dTyAbByExCocrc=;
  b=TMBAiDvGlOyAOno0696WuWE7TJZfvX4i6ouz/ZMrgz6ftfkpdN271lma
   manSd+rJM9inrE2xC/fyZimFirB+j/vti56LCBaAzYzvGQ6ZWS1YRvjtR
   A+J3pZy5JyU4PXtofmS2FA8TcTKLYE1MXHRDzWK+oIfXD1aI8xl5ou4T6
   Uc4lFR2TtXZMQd0cL9it1cje3v8xHYxLGV7GNtNsv42SgCoxCMuwdRJq9
   klTQY0yciyMa20idnkGEroK7AecvPzgJ0xcwmEm8zJU3dGCV3g/IcCbXp
   gJOeKirj3RQWTlXeiDyTMEMLg59l1QZ7PgqK8JKF89eDen7OEdXuSZYLU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380694945"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="380694945"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="779589103"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="779589103"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:32 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/14] wifi: iwlwifi: mvm: d3: avoid intermediate/early mutex unlock
Date: Tue, 19 Dec 2023 21:58:53 +0200
Message-Id: <20231219215605.1f2f5289ecc6.I7e3b8e806b6d50e88ba0c26767da8261806eb9c7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
References: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Now with the mac80211 locking model changed, we no longer can
cause any bad dependencies here between mvm->mutex and other
mutexes in mac80211, so we no longer need to drop the mutex
early or even temporarily. Clean this up.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 92c45571bd69..4582afb149d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1130,14 +1130,7 @@ iwl_mvm_wowlan_config(struct iwl_mvm *mvm,
 			return ret;
 	}
 
-	/*
-	 * This needs to be unlocked due to lock ordering
-	 * constraints. Since we're in the suspend path
-	 * that isn't really a problem though.
-	 */
-	mutex_unlock(&mvm->mutex);
 	ret = iwl_mvm_wowlan_config_key_params(mvm, vif);
-	mutex_lock(&mvm->mutex);
 	if (ret)
 		return ret;
 
@@ -2497,7 +2490,7 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 					 struct iwl_wowlan_status_data *status)
 {
 	int i;
-	bool keep;
+	bool keep = false;
 	struct iwl_mvm_sta *mvm_ap_sta;
 
 	if (!status)
@@ -2525,18 +2518,12 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 				     mvm_ap_sta->tid_data[i].seq_number >> 4);
 	}
 
-	/* now we have all the data we need, unlock to avoid mac80211 issues */
-	mutex_unlock(&mvm->mutex);
-
 	iwl_mvm_report_wakeup_reasons(mvm, vif, status);
 
 	keep = iwl_mvm_setup_connection_keep(mvm, vif, status);
-
-	return keep;
-
 out_unlock:
 	mutex_unlock(&mvm->mutex);
-	return false;
+	return keep;
 }
 
 #define ND_QUERY_BUF_LEN (sizeof(struct iwl_scan_offload_profile_match) * \
-- 
2.34.1


