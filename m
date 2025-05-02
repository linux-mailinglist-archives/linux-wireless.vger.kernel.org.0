Return-Path: <linux-wireless+bounces-22357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E4DAA72BD
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF3D5A4D83
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8295B255F2B;
	Fri,  2 May 2025 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXv1plem"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A7254B1D
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190631; cv=none; b=SHKAevY6zdKZhN0y1Q6W9Qq17QjHSFr6yvIgoWhnQKeBe3YiE6ipe+Jee00LgGc419sj04HLlfgqoHobwClGzrucl+f6bPjJkwX+k7rk4/jKV2XFzyMLVC14vmcK0eM+mHUzX/diCJPysehu15aLzmp/OFx/kudfwoBi7oDE5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190631; c=relaxed/simple;
	bh=C6jT6YLKD/aMJf9IepP5qpoovPtznsvBvk7KJ39ia9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iNwaeXGxcbJJbIopNC2H33DwYRb2Zi0gZHqGj005Iv6M2P36PaahjqV71pe5fEe7D3Lvq2DiDMkrJotV6ZzdGye6La4AmXOK4T7k+La8DUzAjDkuc1IVrVViImo6BC3/7GmCanTtWKT/OrAuCyphapiEJcAz3CC3dhwvHN/NX6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXv1plem; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746190631; x=1777726631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C6jT6YLKD/aMJf9IepP5qpoovPtznsvBvk7KJ39ia9I=;
  b=MXv1plemNP9c9pSMhffhxK3Y/YTHHkxFYDw7mmRv6JdcxrrIEBlA6ICA
   TZIpIeELEUv8LjaMvO3u9HYY8rsJ8Ivhda3mYGvrZUuTSdpCsx8GafVY6
   M0sKSHDeSHgieW21OLf2CghCVfQ4H6BnMDZM422QbCXz5/aUlEWeZto89
   Ya4N9ExqJMoYRwlQ9S8T8UB6fkrRM34Af1hJRkzzt/+XJBRRTervaf3Ob
   qL9yTaqz4PPUO0cVNOBEdMZ5CcBJCGIeMC+LF3SOw8fzN5OakebVMv4dZ
   6ZFxTmLOO2XDacxUgUbK5fzYsgQxy1BPaICMzJUfrWfflLCL76nlk5Rzs
   w==;
X-CSE-ConnectionGUID: fWEDyhrKRuKx6C7NvU49yw==
X-CSE-MsgGUID: Rsd45vRcR9WFloOWlNLnOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59255573"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59255573"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:57:10 -0700
X-CSE-ConnectionGUID: pGe3FN3xSU2IlEDqG2OKYA==
X-CSE-MsgGUID: MNRlj2egTTy9fHzNFLA3PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165554777"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:57:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: remove iwl_cmd_groups_verify_sorted()
Date: Fri,  2 May 2025 15:56:31 +0300
Message-Id: <20250502155404.e3f01789575d.I4380dcbf3e0ecabc2a8a42c84f448b7dd854bf50@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
References: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We now have unit tests for the mvm and mld, and dvm isn't
going to change anyway. Remove the runtime checks.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 18 ------------------
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index bd5e022906af..5fc6561f4378 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -424,30 +424,12 @@ const char *iwl_get_cmd_string(struct iwl_trans *trans, u32 id)
 }
 IWL_EXPORT_SYMBOL(iwl_get_cmd_string);
 
-int iwl_cmd_groups_verify_sorted(const struct iwl_trans_config *trans)
-{
-	int i, j;
-	const struct iwl_hcmd_arr *arr;
-
-	for (i = 0; i < trans->command_groups_size; i++) {
-		arr = &trans->command_groups[i];
-		if (!arr->arr)
-			continue;
-		for (j = 0; j < arr->size - 1; j++)
-			if (arr->arr[j].cmd_id > arr->arr[j + 1].cmd_id)
-				return -1;
-	}
-	return 0;
-}
-IWL_EXPORT_SYMBOL(iwl_cmd_groups_verify_sorted);
-
 void iwl_trans_configure(struct iwl_trans *trans,
 			 const struct iwl_trans_config *trans_cfg)
 {
 	trans->op_mode = trans_cfg->op_mode;
 
 	iwl_trans_pcie_configure(trans, trans_cfg);
-	WARN_ON(iwl_cmd_groups_verify_sorted(trans_cfg));
 }
 IWL_EXPORT_SYMBOL(iwl_trans_configure);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index c02c9af2e302..7dae61fb8f15 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -985,7 +985,6 @@ struct iwl_trans {
 };
 
 const char *iwl_get_cmd_string(struct iwl_trans *trans, u32 id);
-int iwl_cmd_groups_verify_sorted(const struct iwl_trans_config *trans);
 
 void iwl_trans_configure(struct iwl_trans *trans,
 			 const struct iwl_trans_config *trans_cfg);
-- 
2.34.1


