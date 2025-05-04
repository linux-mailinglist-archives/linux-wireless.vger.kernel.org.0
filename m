Return-Path: <linux-wireless+bounces-22388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0F9AA85F1
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE171789C2
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 10:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660E21991BF;
	Sun,  4 May 2025 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDDscPoW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5E81A4F0A
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354414; cv=none; b=Bp+O+In9OJdKp76H8PXCbZ/j1aONrB2CEbiDubCcxyGNj4nxPBQ2Miq8091+njlRfX2hqnAmDA8c9oynU73fxWgVwIon7LTgRaTkgAZeYRR9uJ+9X8RnLnRwcswa+/4wN7FFco2dPhCBkzGXVXJMnvfApNHM/P4qGeajhYeEJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354414; c=relaxed/simple;
	bh=fwHr6P/k555e1GfczquahQNDrsPrchHOgBUiXGCfDZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pTq9GMC8nODO1qcmp5jh6DCSNHhdrMxq4w2QFLpqd4RpeDQTdJ/L0aMKqYiaqpLO8hTT3V6PDl4ivXjvKLXxP/t6T5M8Uv2RoaS4iHnXNwZJwq2ywjQ/ygWyP5A3O7yLHEZnNbIweZQoAtg1FgRKGUJtunwp8vgHrNFZibbzgHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDDscPoW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746354412; x=1777890412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fwHr6P/k555e1GfczquahQNDrsPrchHOgBUiXGCfDZo=;
  b=nDDscPoWdfyDZFuLgskLLsdn/lKrhcAsGe1/yV/b0o3n98S8TsfI3TDZ
   Oere1cjPcA0jDynpv4up2vwVZ9Yqpqw4ML8uNsOK9v8GJz78cUXBcqJ8G
   T461kFtoe2NmcIjY9TrXcfZCr4jqoCxwLp+8ZA4gF8w3WBDqX9j/EFyM5
   htpb0ofu6hzzNKhzyz83R3GL9mjDSNH4cRe4GjXno5Qpi6bIvpeQw0nN7
   pzb4oJ1ZEAG7ujlF4TTXbdg9BXNsDbvdyfE/NPRWJTZT56LFt4gj9z//N
   PRD+Lbc6D0PWzikLtTdEKU15lB7dRA2scxfOxckeMCtQp7WiJRG1geQ58
   g==;
X-CSE-ConnectionGUID: tF8RGkZoTZCFbn6+nTj6oA==
X-CSE-MsgGUID: yRItwCfkQ4ixVfP+RVNrew==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="65511479"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="65511479"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:26:52 -0700
X-CSE-ConnectionGUID: 34UgqwWyTqWX5825985Kzg==
X-CSE-MsgGUID: UUEq0qiISFuGDrQNqjkCuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="139778865"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:26:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: trans: move ext_32khz_clock_valid to config
Date: Sun,  4 May 2025 13:26:18 +0300
Message-Id: <20250504132447.637ed7514587.I6c8fdeb3e2078a5fe9b755391e3ef7258ef2b279@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
References: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This value is used for the device start, so it's really
part of the configuration.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h        |  7 +++----
 drivers/net/wireless/intel/iwlwifi/mld/mld.c          | 11 ++++++-----
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c  |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index ceedc8938800..929c29ca3939 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -421,6 +421,7 @@ struct iwl_dump_sanitize_ops {
  * @dsbr_urm_permanent: switch to URM permanently
  * @mbx_addr_0_step: step address data 0
  * @mbx_addr_1_step: step address data 1
+ * @ext_32khz_clock_valid: if true, the external 32 KHz clock can be used
  */
 struct iwl_trans_config {
 	u8 cmd_queue;
@@ -441,7 +442,8 @@ struct iwl_trans_config {
 	u8 rx_mpdu_cmd, rx_mpdu_cmd_hdr_size;
 
 	u8 dsbr_urm_fw_dependent:1,
-	   dsbr_urm_permanent:1;
+	   dsbr_urm_permanent:1,
+	   ext_32khz_clock_valid:1;
 
 	u32 mbx_addr_0_step;
 	u32 mbx_addr_1_step;
@@ -882,7 +884,6 @@ struct iwl_trans_info {
  * @restart.mode: reset/restart error mode information
  * @restart.during_reset: error occurred during previous software reset
  * @trans_specific: data for the specific transport this is allocated for/with
- * @ext_32khz_clock_valid: if true, the external 32 KHz clock can be used
  * @request_top_reset: TOP reset was requested, used by the reset
  *	worker that should be scheduled (with appropriate reason)
  * @do_top_reset: indication to the (PCIe) transport/context-info
@@ -905,8 +906,6 @@ struct iwl_trans {
 	bool reduced_cap_sku;
 	bool step_urm;
 
-	bool ext_32khz_clock_valid;
-
 	bool pm_support;
 	bool ltr_enabled;
 	u8 pnvm_loaded:1;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 578941098b58..dfb9908de09d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -328,10 +328,16 @@ iwl_mld_configure_trans(struct iwl_op_mode *op_mode)
 	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
 	static const u8 no_reclaim_cmds[] = {TX_CMD};
 	struct iwl_trans *trans = mld->trans;
+	u32 eckv_value;
 
 	iwl_bios_setup_step(trans, &mld->fwrt);
 	iwl_uefi_get_step_table(trans);
 
+	if (iwl_bios_get_eckv(&mld->fwrt, &eckv_value))
+		IWL_DEBUG_RADIO(mld, "ECKV table doesn't exist in BIOS\n");
+	else
+		trans->conf.ext_32khz_clock_valid = !!eckv_value;
+
 	trans->conf.rx_buf_size = iwl_amsdu_size_to_rxb_size();
 	trans->conf.command_groups = iwl_mld_groups;
 	trans->conf.command_groups_size = ARRAY_SIZE(iwl_mld_groups);
@@ -369,7 +375,6 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	struct ieee80211_hw *hw;
 	struct iwl_op_mode *op_mode;
 	struct iwl_mld *mld;
-	u32 eckv_value;
 	int ret;
 
 	/* Allocate and initialize a new hardware device */
@@ -391,10 +396,6 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	iwl_mld_get_bios_tables(mld);
 	iwl_uefi_get_sgom_table(trans, &mld->fwrt);
-	if (iwl_bios_get_eckv(&mld->fwrt, &eckv_value))
-		IWL_DEBUG_RADIO(mld, "ECKV table doesn't exist in BIOS\n");
-	else
-		trans->ext_32khz_clock_valid = !!eckv_value;
 	mld->bios_enable_puncturing = iwl_uefi_get_puncturing(&mld->fwrt);
 
 	iwl_mld_hw_set_regulatory(mld);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index e06c137d193e..05876aea42e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -138,7 +138,7 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 	if (trans->conf.dsbr_urm_permanent)
 		control_flags_ext |= IWL_PRPH_SCRATCH_EXT_URM_PERM;
 
-	if (trans->ext_32khz_clock_valid)
+	if (trans->conf.ext_32khz_clock_valid)
 		control_flags_ext |= IWL_PRPH_SCRATCH_EXT_32KHZ_CLK_VALID;
 
 	/* Allocate prph scratch */
-- 
2.34.1


