Return-Path: <linux-wireless+bounces-22255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D7EAA4B11
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1B74C1094
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A31525B1FA;
	Wed, 30 Apr 2025 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1C71Qul"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68D0258CC0
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015904; cv=none; b=dYGqjUDdbx7nks9JKQR3IVfJHBvcNQim2VHpfIgOOiQ4Yc/sE6cQYEdYz4hcHipzU11zLjUlO6lRojjbgYKu29hUpUYuk3T23tF7dtjpvmCxkvX5Hcl0e13NbsN1Q6GUoN05OuWrHrxnLZ8/ltwFPgcE+0qi7W17JTrwjq/Ifq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015904; c=relaxed/simple;
	bh=svLcaYrRxSN8IEaG5qOrpGXO7gO/NSAEHyBAgJKtwxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EYJ8HUWSYcZPEZKYL85OrbWGMcLOQkgqiPWEyfsQMM05ylswsGJ+KvEssXiGnv5lEGlgRw5K/gVER9Rejfeu4Qpe8klJJa5eC3A0onQ5Nq/SN8IideHkrcjHhWtL2lOKly4YeaeTTkUx+XjNDH1JOZ7sDfNZu/lMZUqrOcNOtZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1C71Qul; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746015902; x=1777551902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=svLcaYrRxSN8IEaG5qOrpGXO7gO/NSAEHyBAgJKtwxU=;
  b=a1C71QulQrCJy/Ff18lLklkrMzmclWYd9plvRTBz7TwRvxSCP2fbfgXT
   2ArGxJ4/pF9qYj9AgksNNJPPLGmhtEgn2f1pSJkJxutA5+SkMrnCSler4
   MpPr+8tGvuajJynklwivEElPXNZepFhSIIJOJVFsXdLdxVykCSVQWdNm8
   tzQx48iEl0wjCdUEfGKLAQhQtCIweL+IDgvoUyUIapkKyKV4LxPJdVl/U
   1pq1HXmfe6IKFqxZG/q+lEMyoQZ04RpBrikUc7rj6pnE3c6pdBUdmYC1k
   19rNQ1mCbLMCglofma4QepHTV2HNp0AAnp4giCSSHpBNoqCno+aQuSgXA
   A==;
X-CSE-ConnectionGUID: I1rGkyT5QXu4kEaz7inDkg==
X-CSE-MsgGUID: cxjvMXAUQpujVkYB6GfwWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47578288"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47578288"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:25:02 -0700
X-CSE-ConnectionGUID: YGhrQEcIQDSv0m2/oHPnrA==
X-CSE-MsgGUID: BdQ32ZqQQXOVOiGqY2ND1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="135087897"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:25:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH v2 iwlwifi-next 12/14] wifi: iwlwifi: rename ppag_ver to ppag_bios_rev
Date: Wed, 30 Apr 2025 15:23:18 +0300
Message-Id: <20250430151952.be51850947df.If81d88cd2d38299faf1e2a3db5efbc021650f907@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
References: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

ppag_ver variable is holding PPAG BIOS revision but name misleading
as PPAG command API version, So rename to ppag_bios_rev.

This will improve code readability but doesn't alter behaviour.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c | 8 ++++----
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h | 6 +++---
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    | 3 ++-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       | 4 ++--
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index dfd5365995b6..68b461297174 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -882,7 +882,7 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	goto out_free;
 
 read_table:
-	fwrt->ppag_ver = tbl_rev;
+	fwrt->ppag_bios_rev = tbl_rev;
 	flags = &wifi_pkg->package.elements[1];
 
 	if (flags->type != ACPI_TYPE_INTEGER) {
@@ -891,7 +891,7 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	}
 
 	fwrt->ppag_flags = iwl_bios_get_ppag_flags(flags->integer.value,
-						   fwrt->ppag_ver);
+						   fwrt->ppag_bios_rev);
 
 	/*
 	 * read, verify gain values and save them into the PPAG table.
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 1444b628214b..bb8ddfad8621 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -349,17 +349,17 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 		num_sub_bands = IWL_NUM_SUB_BANDS_V1;
 		gain = cmd->v1.gain[0];
 		*cmd_size = sizeof(cmd->v1);
-		if (fwrt->ppag_ver >= 1) {
+		if (fwrt->ppag_bios_rev >= 1) {
 			/* in this case FW supports revision 0 */
 			IWL_DEBUG_RADIO(fwrt,
 					"PPAG table rev is %d, send truncated table\n",
-					fwrt->ppag_ver);
+					fwrt->ppag_bios_rev);
 		}
 	} else if (cmd_ver >= 2 && cmd_ver <= 6) {
 		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
 		gain = cmd->v2.gain[0];
 		*cmd_size = sizeof(cmd->v2);
-		if (fwrt->ppag_ver == 0) {
+		if (fwrt->ppag_bios_rev == 0) {
 			/* in this case FW supports revisions 1,2 or 3 */
 			IWL_DEBUG_RADIO(fwrt,
 					"PPAG table rev is 0, send padded table\n");
@@ -382,7 +382,7 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 	if ((cmd_ver == 1 &&
 	     !fw_has_capa(&fwrt->fw->ucode_capa,
 			  IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT)) ||
-	    (cmd_ver == 2 && fwrt->ppag_ver >= 2)) {
+	    (cmd_ver == 2 && fwrt->ppag_bios_rev >= 2)) {
 		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
 		IWL_DEBUG_RADIO(fwrt, "masking ppag China bit\n");
 	} else {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 46d19101b741..641b4463e898 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -224,10 +224,10 @@ int iwl_bios_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		     u32 *value);
 
 static inline u32 iwl_bios_get_ppag_flags(const u32 ppag_modes,
-					  const u8 ppag_ver)
+					  const u8 ppag_bios_rev)
 {
-	return ppag_modes & (ppag_ver < 3 ? IWL_PPAG_ETSI_CHINA_MASK :
-					    IWL_PPAG_REV3_MASK);
+	return ppag_modes & (ppag_bios_rev < 3 ? IWL_PPAG_ETSI_CHINA_MASK :
+						 IWL_PPAG_REV3_MASK);
 }
 
 bool iwl_puncturing_is_allowed_in_bios(u32 puncturing, u16 mcc);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index a56b96003650..8ff85a243075 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -111,6 +111,7 @@ struct iwl_txf_iter_data {
  * @sar_profiles: sar profiles as read from WRDS/EWRD BIOS tables
  * @geo_profiles: geographic profiles as read from WGDS BIOS table
  * @phy_filters: specific phy filters as read from WPFC BIOS table
+ * @ppag_bios_rev: PPAG BIOS revision
  */
 struct iwl_fw_runtime {
 	struct iwl_trans *trans;
@@ -179,7 +180,7 @@ struct iwl_fw_runtime {
 	bool geo_enabled;
 	struct iwl_ppag_chain ppag_chains[IWL_NUM_CHAIN_LIMITS];
 	u32 ppag_flags;
-	u8 ppag_ver;
+	u8 ppag_bios_rev;
 	struct iwl_sar_offset_mapping_cmd sgom_table;
 	bool sgom_enabled;
 	struct iwl_mcc_allowed_ap_type_cmd uats_table;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index b0f4c217b2a5..74b7984e8ebe 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -557,9 +557,9 @@ int iwl_uefi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 		goto out;
 	}
 
-	fwrt->ppag_ver = data->revision;
+	fwrt->ppag_bios_rev = data->revision;
 	fwrt->ppag_flags = iwl_bios_get_ppag_flags(data->ppag_modes,
-						   fwrt->ppag_ver);
+						   fwrt->ppag_bios_rev);
 
 	BUILD_BUG_ON(sizeof(fwrt->ppag_chains) != sizeof(data->ppag_chains));
 	memcpy(&fwrt->ppag_chains, &data->ppag_chains,
-- 
2.34.1


