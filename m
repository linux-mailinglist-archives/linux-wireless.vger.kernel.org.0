Return-Path: <linux-wireless+bounces-22306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1C6AA5CE3
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 12:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7894B4A5B5B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6941321931B;
	Thu,  1 May 2025 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuRbGvkE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB71521422B
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093615; cv=none; b=AfBT1TeDbCWxRhCofqv1djU1SihrnH1SYp69a0ajfP4eks0MjHLF3T0FEwe6ff2xoy8qxIQ14YHKIDRYvWc5s951vNJeiW7wgWRBh8WPnG0bjuzaBavdxzYWecE7BC7ATh2TzlqwC31jJ6GVvsjAb7V7wbnRxIFPJ2o6dNWyV3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093615; c=relaxed/simple;
	bh=TmbVjEy03CG5jjuk3eqGs9yCxxPLgRG3mBUWPu7Vh70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l2XaoumLP438LYrmRQc6J7XqjLGtLnlzvgi8Ixz7lsRUNZPIGlHzZz8H+NTnc6MgsVghFnxZiE9tjs7qZwE50gR8R2x7Vf9NrOlEkpZ3Eottg9PdrdWha+5V7uw2xrwDhF7Zl8wgcNSsgW+yKk37IFZFl9Sw/74qAsfbSRtcPzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuRbGvkE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746093614; x=1777629614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TmbVjEy03CG5jjuk3eqGs9yCxxPLgRG3mBUWPu7Vh70=;
  b=OuRbGvkEtZ3DOU5I2MZq/1vfH3iD7i4RPRMaln3cmuWKEpTLHu4fy5LA
   l4q95qzzE3C4GkuDDjYOVkujX81sBA5QcDOMZHnAu/Dv7imJeoYynY4HR
   1wDgzxPAqh3w8y7yMN1/gJ99nVgd22pZ/LgJOLz2Zkh93tzcxFroOrYv8
   TmSh/MYww7atlzvbY772rN1K18jsLBhmWhmnH6YJwYyQsInTKcR29djIf
   RT4pXlncH0lbEN5ksKrzo2M31RqaJN0LVlVS3JzlP2D0roJsD9hjQ87mS
   +SLuosGYyVt0wnzQqQ5ZpkCJKogrA+aKVkVfwZsTPc2LDOD/MDYKD4Y/N
   w==;
X-CSE-ConnectionGUID: RHMGkAafSaOKi9u24wAtZg==
X-CSE-MsgGUID: gHuI6aAASHe/aYCAd4MXWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="57962854"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="57962854"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:13 -0700
X-CSE-ConnectionGUID: W5P1TDw0Qlq1piGyicocqw==
X-CSE-MsgGUID: aPVVU8LAQ429WLj7Wx8S+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="135318028"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: cfg: remove duplicated iwl_cfg_gl
Date: Thu,  1 May 2025 12:59:36 +0300
Message-Id: <20250501125731.a51db65e9031.Ic5429009677ae1023cf1f43a655e90409a30c493@changeid>
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
index db9b582795ba..b8bc61b33615 100644
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


