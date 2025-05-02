Return-Path: <linux-wireless+bounces-22340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D24AA719F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CDBF1BC7858
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CA725485F;
	Fri,  2 May 2025 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGZGp7EW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275425485B
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188467; cv=none; b=Mhxl5LLquyPh6CgcRXltZd/WjM0MuKos1sNuoNZ+/xrwIASsKQHmE98YV46lDNkNPkgo3f/UyWD8L6sfuKVJO9cJxqfgB4l2GicbqK0zhGBghjIbVPzLY6Mw4JOK98RbiUrNqRx5wfSV+qaZJjRhlY8A2Bn4EH+irgUODhzH39M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188467; c=relaxed/simple;
	bh=WrhpF7Jkgn1D47WuxgkWWgZy+CDTmEVC69jfuWD4fqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VZxVr/y6tVNMQgEz/fPvzQQ+W1oAuOVuLIHg8EF+sDuIMYTrPeSQSH1Bw4YE8yKrC2dz7u67XiZ6QObUyFm8OTlGhpKIBFQ6U5hkcbvtfmPjZdMyJZnncCMLT3GSe9PzRTEl8KkURMJxsVh5LxsG4g5JaG4K0DdazdBd5AYtLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGZGp7EW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746188465; x=1777724465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WrhpF7Jkgn1D47WuxgkWWgZy+CDTmEVC69jfuWD4fqs=;
  b=NGZGp7EWQCuglmcm2LWyk27vuh/0xTzr76veaLmnbSGQjVkFDsUpGHeQ
   nvqE5nyjzVLIefFLUGnDX1FB/ntGHZoIOu7UZXsrxniIQgnxLL8f5XJMP
   vaO/fuw2QtQ8JcVPhrVfCniPFZsckf7ginBVSNCtUIgEfBiVk5yuS04pd
   2nrNKsstZPFXIgLnN6cnHdVOH7Pvscgt/IQfODhpIdCyCPXQhbidqZCJ0
   QeZeW0kJr94/k/YqI0TRD14oxVbNghmVkIIPUAPpPXZVJdYDkbePyl0Q7
   LK5wuzpb1bQKGOey/xlZ4jdYLh9p7bSPCnwY6FG+21dcL/S9UX/uSflR6
   w==;
X-CSE-ConnectionGUID: AoiBlvTIQkSMAh5tfDFvCA==
X-CSE-MsgGUID: a7f1vTk0RFOkfc4omvJqmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48010374"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48010374"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:21:05 -0700
X-CSE-ConnectionGUID: VxLcEY3jSU69o0Z6lJ5XCg==
X-CSE-MsgGUID: +LmlK994RLi7bUpUoy9OyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134586156"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:21:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 14/15] wifi: iwlwifi: cfg: remove duplicated iwl_cfg_gl
Date: Fri,  2 May 2025 15:20:29 +0300
Message-Id: <20250502151751.fbb78183dc85.Ic5429009677ae1023cf1f43a655e90409a30c493@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
References: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This really is the same device as covered by iwl_cfg_bz,
just the discrete version. Since discrete vs integrated
is handled in the transport config, there's no need to
have both. Remove iwl_cfg_gl.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c     | 7 -------
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 1 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 4 ++--
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 1d491c72bae8..f3f2dc66bfb5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -169,13 +169,6 @@ const struct iwl_cfg iwl_cfg_bz = {
 	.num_rbds = IWL_NUM_RBDS_BZ_EHT,
 };
 
-const struct iwl_cfg iwl_cfg_gl = {
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_EHT,
-};
-
 MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 IWL_FW_AND_PNVM(IWL_BZ_A_GF_A_FW_PRE, IWL_BZ_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_BZ_A_GF4_A_FW_PRE, IWL_BZ_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index cdb3f4abd21b..c4f914010033 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -639,7 +639,6 @@ extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
 extern const struct iwl_ht_params iwl_bz_ht_params;
 
 extern const struct iwl_cfg iwl_cfg_bz;
-extern const struct iwl_cfg iwl_cfg_gl;
 
 extern const struct iwl_cfg iwl_cfg_sc;
 extern const struct iwl_cfg iwl_cfg_sc2;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index ad938f05410f..950c680edbfa 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1120,9 +1120,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_cfg_bz, iwl_wh_name, MAC_TYPE(BZ_W), RF_TYPE(WH)),
 
 /* Ga (Gl) */
-	IWL_DEV_INFO(iwl_cfg_gl, iwl_gl_name, MAC_TYPE(GL), RF_TYPE(FM),
+	IWL_DEV_INFO(iwl_cfg_bz, iwl_gl_name, MAC_TYPE(GL), RF_TYPE(FM),
 		     BW_NO_LIMIT, NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_gl, iwl_mtp_name, MAC_TYPE(GL), RF_TYPE(FM),
+	IWL_DEV_INFO(iwl_cfg_bz, iwl_mtp_name, MAC_TYPE(GL), RF_TYPE(FM),
 		     BW_LIMIT(160), NO_CDB),
 
 /* Sc */
-- 
2.34.1


