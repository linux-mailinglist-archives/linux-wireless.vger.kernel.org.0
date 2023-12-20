Return-Path: <linux-wireless+bounces-1024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 875428190B9
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4547F286AEE
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 19:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9636B39AF1;
	Tue, 19 Dec 2023 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PK1LxT7z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059AE39AC1
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703014156; x=1734550156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ezcOkpBExqJCuyt2yqB1mPY18Yxi/dTyAbByExCocrc=;
  b=PK1LxT7ze5RKJ5tv8g+o7I1CakChR3ucDbSlYHLyxTmA6wj1193EAeYi
   m6djxPn1W6fROlwwQ72tWDAIn3jVf5fLv50b/wcYdafEYB9UQrgtTMUjy
   qfkMThWf6WFEahSuLER7oGBimVFU3J9I+MVIL9JgUNDqJatrsrC8fvh0d
   bPLb9yyaE+kNdSjYAEmEzz5ww0foyakSPZlqw2ubJ6OGOlklB1vuSSZ5a
   eUkxsFfa4KAc0uxpw6LPRswghXLLuY/ZpcFG8VoC1AxCD2MgUsFqTkBy4
   eJjqfKraFTsn7uxIRYb+bHr0n1C2Jk7AjkgQW12YRHQfZGf6S49w1etYN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="460054354"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="460054354"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:29:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="899478246"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="899478246"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:29:13 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/14] wifi: iwlwifi: mvm: d3: avoid intermediate/early mutex unlock
Date: Wed, 20 Dec 2023 15:29:22 +0200
Message-Id: <20231220152651.1f2f5289ecc6.I7e3b8e806b6d50e88ba0c26767da8261806eb9c7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220132931.3314293-1-miriam.rachel.korenblit@intel.com>
References: <20231220132931.3314293-1-miriam.rachel.korenblit@intel.com>
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


