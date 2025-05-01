Return-Path: <linux-wireless+bounces-22307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0631DAA5CE5
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 12:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03ED54A5B5B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 10:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE6126D4C9;
	Thu,  1 May 2025 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCNtjyPD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA226B0B6
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093618; cv=none; b=XBZPX9/lcsedpz1JBXH3x9yAPwrbMY6bcJKV3RZbesoHGb4oq8Vs8nuTULzFPXasLw15Amjr4WiBZAD185Cdr+cZLi3j2MEytMxqGPbYfJrmxMdReWeo5efMgv8iNTYBZHzj0UTLBkRxCDw8UA1gcOTV6NWM+hrXCPah1eejWoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093618; c=relaxed/simple;
	bh=QfTLoPTaki2+sEg3dQ1aZKDPfYBFo6GQr2J+0wVkF8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GXSwZRRPSan32KfboXCxKaiIOiGSMLJERxe1oneFCyIaZGfrALD1eFtjcNYEp/UgNZ6MDth7o3LMLVYE35AmUnrT7xoYWDTxFapcWdF+IBHoPLmojSEVhs5d2Z12/9ZBh9x1wzNFe76+FDPIy6L7UhS7bmaHPUVxC1Ywl2j9+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCNtjyPD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746093617; x=1777629617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QfTLoPTaki2+sEg3dQ1aZKDPfYBFo6GQr2J+0wVkF8g=;
  b=MCNtjyPDFiEO2W9iaQIjRrOFyHocGYZVqtK+4pJ0bOmSuCz4EQVFKwTM
   Z5MA3LXo72RF38zhEYi13qSa0XtGW7iWSKFTllUMZNsUYsZi7JCkvZlTn
   0QFpKTJaK87OZUHWdtmPBLwHHfmb0yhR1g0A+wC41uijqXA7wv2NLdG+u
   5IYB2j/yeMqd57GafL8YdUT3xEJttyrk2unEdDxTAyJ+nThdymsPat8b6
   00j7tBvlWPVXhMlahDmaLAXp20WkOr2DZY1+5aNTIVdbgPUH66VtD5CrO
   j3cX1Exsa2ryPiZ8THxp1iB7O5pTiQ/76Jf1T6n/YyEf3LGX0m3I6ebeT
   g==;
X-CSE-ConnectionGUID: fNbirKoZT9+hTMa8mzZUMw==
X-CSE-MsgGUID: mkNPmTEYS9OJfj/x5TQUpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="57962857"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="57962857"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:15 -0700
X-CSE-ConnectionGUID: ZkLthaG+RbyyHPschrJzcA==
X-CSE-MsgGUID: jPqc4JpGSQWdXHMI+marjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="135318035"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: cfg: remove duplicated Sc device configs
Date: Thu,  1 May 2025 12:59:37 +0300
Message-Id: <20250501125731.ae87d56f24e5.I079987bc4a1679789bacc1078952aa90c805ffe0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
References: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The configurations for Sc, Sc2 and Sc2f are all the same,
so keep just a single config struct.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  8 --------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 --
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 20 +++++++++----------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 4b39f11c9582..405c282e019c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -149,14 +149,6 @@ const struct iwl_cfg iwl_cfg_sc = {
 	IWL_DEVICE_SC,
 };
 
-const struct iwl_cfg iwl_cfg_sc2 = {
-	IWL_DEVICE_SC,
-};
-
-const struct iwl_cfg iwl_cfg_sc2f = {
-	IWL_DEVICE_SC,
-};
-
 IWL_FW_AND_PNVM(IWL_SC_A_FM_B_FW_PRE, IWL_SC_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_SC_A_FM_C_FW_PRE, IWL_SC_UCODE_API_MAX);
 MODULE_FIRMWARE(IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index c4f914010033..8862148a49bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -641,8 +641,6 @@ extern const struct iwl_ht_params iwl_bz_ht_params;
 extern const struct iwl_cfg iwl_cfg_bz;
 
 extern const struct iwl_cfg iwl_cfg_sc;
-extern const struct iwl_cfg iwl_cfg_sc2;
-extern const struct iwl_cfg iwl_cfg_sc2f;
 extern const struct iwl_cfg iwl_cfg_dr;
 extern const struct iwl_cfg iwl_cfg_br;
 #endif /* CONFIG_IWLMLD */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index b8bc61b33615..92220571499a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1133,20 +1133,20 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_sp_name, MAC_TYPE(SC), RF_TYPE(WH),
 		     BW_LIMIT(160)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC), RF_TYPE(PE)),
-	IWL_DEV_INFO(iwl_cfg_sc2, iwl_ax211_name, MAC_TYPE(SC2), RF_TYPE(GF)),
-	IWL_DEV_INFO(iwl_cfg_sc2, iwl_fm_name, MAC_TYPE(SC2), RF_TYPE(FM)),
-	IWL_DEV_INFO(iwl_cfg_sc2, iwl_wh_name, MAC_TYPE(SC2), RF_TYPE(WH),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_ax211_name, MAC_TYPE(SC2), RF_TYPE(GF)),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_fm_name, MAC_TYPE(SC2), RF_TYPE(FM)),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_wh_name, MAC_TYPE(SC2), RF_TYPE(WH),
 		     BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_cfg_sc2, iwl_sp_name, MAC_TYPE(SC2), RF_TYPE(WH),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_sp_name, MAC_TYPE(SC2), RF_TYPE(WH),
 		     BW_LIMIT(160)),
-	IWL_DEV_INFO(iwl_cfg_sc2, iwl_pe_name, MAC_TYPE(SC2), RF_TYPE(PE)),
-	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_ax211_name, MAC_TYPE(SC2F), RF_TYPE(GF)),
-	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_fm_name, MAC_TYPE(SC2F), RF_TYPE(FM)),
-	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_wh_name, MAC_TYPE(SC2F), RF_TYPE(WH),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC2), RF_TYPE(PE)),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_ax211_name, MAC_TYPE(SC2F), RF_TYPE(GF)),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_fm_name, MAC_TYPE(SC2F), RF_TYPE(FM)),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_wh_name, MAC_TYPE(SC2F), RF_TYPE(WH),
 		     BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_sp_name, MAC_TYPE(SC2F), RF_TYPE(WH),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_sp_name, MAC_TYPE(SC2F), RF_TYPE(WH),
 		     BW_LIMIT(160)),
-	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_pe_name, MAC_TYPE(SC2F), RF_TYPE(PE)),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC2F), RF_TYPE(PE)),
 
 /* Dr */
 	IWL_DEV_INFO(iwl_cfg_dr, iwl_dr_name, MAC_TYPE(DR)),
-- 
2.34.1


