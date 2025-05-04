Return-Path: <linux-wireless+bounces-22387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DFCAA85F0
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43FF178A39
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 10:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9361317736;
	Sun,  4 May 2025 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RdmsKoE6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE461991BF
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354412; cv=none; b=pLJ3pd1fF5A9tcaj7A07jY8lxSnACPT3Qoa31KQHVCDX3FNSZVtETU3EBHrl0aYRCPBs0thk399kjKuAyw4+8lThpBHI6srHuytpfhIEBOG6PqdauIuxkGVSIsj2PCrbwDOWnvJht5KP5lOQ0Rb+yttkeF6Qh4xfCcZu7+SN0xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354412; c=relaxed/simple;
	bh=SQ9gB4jpX0GKlFreRdp2H72WvGQSy0+fHpCO2CxikBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BuCIIiKBBvtBS0O2G+kok+o1jfwnU5a4IeMCzF7LRUk7Y1DhKB4bJjgFxLDZdnOp6AwAOxkAheQhBofPyATvbnYyqvfiBMkaQgJE8UftYl2akXx7L651d9AzDNFu71YVYqnm7NcKPxoTZKRANV+jPy/1hsEMJ5Xf5b3N9/AJQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RdmsKoE6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746354410; x=1777890410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SQ9gB4jpX0GKlFreRdp2H72WvGQSy0+fHpCO2CxikBE=;
  b=RdmsKoE6etxacnZmOCFo8zp05oSdKT9cgcwD3bbllHkLjgRoh5r9pdh5
   xUTzFmZ5EoMeaeCP+xkCycRIrO1XuTmaSjID0AIebmt3X+VLfL9xjLdRs
   UCp66g/2xEqAwZxuCE1c8R7P2bxXYGR7OvDg8q1P0jBjHZ5ewx8tZzoEL
   B764tNY90zhXHNcfb9XOryAy2LQMHHtox4//tXsWs479boOmyzHm9ypoB
   r3c7pKqc9OLMChYvEtpm7N6Og+L+Zrku8i3iyGPKFVpvK1qDnOWLv4ILH
   hUp8eQoRNO8z9Pz/OjVE6aANRCqQur0J3IiEluN7OtPtHAitlHJ35jyVV
   A==;
X-CSE-ConnectionGUID: IEr6FGjqRGGyRWdUfmrDLA==
X-CSE-MsgGUID: 9Lffc7MkTAS6ILpJj2GKSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="65511478"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="65511478"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:26:50 -0700
X-CSE-ConnectionGUID: 3NqSm1pQRyWEtFP2Y8fLpg==
X-CSE-MsgGUID: D5SjZW0eQmi4vPKsmlN9zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="139778860"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:26:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: move STEP config into trans->conf
Date: Sun,  4 May 2025 13:26:17 +0300
Message-Id: <20250504132447.a4681ee11dd7.I6434a13d51932e984bb07695bc1cb931ebdcd27c@changeid>
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

This really belongs there, it's needed early, so move it. Remove
the related but dead iwl_trans_pcie_ctx_info_gen3_set_step() while
at it. In iwlmld move the calls since they do part of the trans
configuration.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  6 ++++--
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  5 +++--
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  2 --
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 20 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  7 ++++---
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 10 ++++++----
 6 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index bd5c0a27718c..a72e116eaeaf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -256,7 +256,9 @@ static inline void iwl_bios_setup_step(struct iwl_trans *trans,
 	if (iwl_bios_get_dsbr(fwrt, &dsbr))
 		dsbr = 0;
 
-	trans->dsbr_urm_fw_dependent = !!(dsbr & IWL_DSBR_FW_MODIFIED_URM_MASK);
-	trans->dsbr_urm_permanent = !!(dsbr & IWL_DSBR_PERMANENT_URM_MASK);
+	trans->conf.dsbr_urm_fw_dependent =
+		!!(dsbr & IWL_DSBR_FW_MODIFIED_URM_MASK);
+	trans->conf.dsbr_urm_permanent =
+		!!(dsbr & IWL_DSBR_PERMANENT_URM_MASK);
 }
 #endif /* __fw_regulatory_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index d31492035089..5aedb78cb6d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -310,11 +310,12 @@ static int iwl_uefi_step_parse(struct uefi_cnv_common_step_data *common_step_dat
 	if (common_step_data->revision != 1)
 		return -EINVAL;
 
-	trans->mbx_addr_0_step = (u32)common_step_data->revision |
+	trans->conf.mbx_addr_0_step =
+		(u32)common_step_data->revision |
 		(u32)common_step_data->cnvi_eq_channel << 8 |
 		(u32)common_step_data->cnvr_eq_channel << 16 |
 		(u32)common_step_data->radio1 << 24;
-	trans->mbx_addr_1_step = (u32)common_step_data->radio2;
+	trans->conf.mbx_addr_1_step = (u32)common_step_data->radio2;
 	return 0;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 3eba27fd5293..70295098ae98 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -341,6 +341,4 @@ iwl_trans_pcie_ctx_info_gen3_load_reduce_power(struct iwl_trans *trans,
 void
 iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
 					      const struct iwl_ucode_capabilities *capa);
-int iwl_trans_pcie_ctx_info_gen3_set_step(struct iwl_trans *trans,
-					  u32 mbx_addr_0_step, u32 mbx_addr_1_step);
 #endif /* __iwl_context_info_file_gen3_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 3faf07dfd5e4..ceedc8938800 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -417,6 +417,10 @@ struct iwl_dump_sanitize_ops {
  *	starting the firmware, used for tracing
  * @rx_mpdu_cmd_hdr_size: used for tracing, amount of data before the
  *	start of the 802.11 header in the @rx_mpdu_cmd
+ * @dsbr_urm_fw_dependent: switch to URM based on fw settings
+ * @dsbr_urm_permanent: switch to URM permanently
+ * @mbx_addr_0_step: step address data 0
+ * @mbx_addr_1_step: step address data 1
  */
 struct iwl_trans_config {
 	u8 cmd_queue;
@@ -435,6 +439,12 @@ struct iwl_trans_config {
 
 	bool wide_cmd_header;
 	u8 rx_mpdu_cmd, rx_mpdu_cmd_hdr_size;
+
+	u8 dsbr_urm_fw_dependent:1,
+	   dsbr_urm_permanent:1;
+
+	u32 mbx_addr_0_step;
+	u32 mbx_addr_1_step;
 };
 
 struct iwl_trans_dump_data {
@@ -865,8 +875,6 @@ struct iwl_trans_info {
  * @sync_cmd_lockdep_map: lockdep map for checking sync commands
  * @dbg: additional debug data, see &struct iwl_trans_debug
  * @init_dram: FW initialization DMA data
- * @mbx_addr_0_step: step address data 0
- * @mbx_addr_1_step: step address data 1
  * @reduced_cap_sku: reduced capability supported SKU
  * @step_urm: STEP is in URM, no support for MCS>9 in 320 MHz
  * @restart: restart worker data
@@ -874,8 +882,6 @@ struct iwl_trans_info {
  * @restart.mode: reset/restart error mode information
  * @restart.during_reset: error occurred during previous software reset
  * @trans_specific: data for the specific transport this is allocated for/with
- * @dsbr_urm_fw_dependent: switch to URM based on fw settings
- * @dsbr_urm_permanent: switch to URM permanently
  * @ext_32khz_clock_valid: if true, the external 32 KHz clock can be used
  * @request_top_reset: TOP reset was requested, used by the reset
  *	worker that should be scheduled (with appropriate reason)
@@ -899,9 +905,6 @@ struct iwl_trans {
 	bool reduced_cap_sku;
 	bool step_urm;
 
-	u8 dsbr_urm_fw_dependent:1,
-	   dsbr_urm_permanent:1;
-
 	bool ext_32khz_clock_valid;
 
 	bool pm_support;
@@ -924,9 +927,6 @@ struct iwl_trans {
 	struct iwl_trans_debug dbg;
 	struct iwl_self_init_dram init_dram;
 
-	u32 mbx_addr_0_step;
-	u32 mbx_addr_1_step;
-
 	struct {
 		struct delayed_work wk;
 		struct iwl_fw_error_dump_mode mode;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index da1079639b2a..578941098b58 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -325,10 +325,13 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(global_iwl_mld_goups_size);
 static void
 iwl_mld_configure_trans(struct iwl_op_mode *op_mode)
 {
-	const struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
+	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
 	static const u8 no_reclaim_cmds[] = {TX_CMD};
 	struct iwl_trans *trans = mld->trans;
 
+	iwl_bios_setup_step(trans, &mld->fwrt);
+	iwl_uefi_get_step_table(trans);
+
 	trans->conf.rx_buf_size = iwl_amsdu_size_to_rxb_size();
 	trans->conf.command_groups = iwl_mld_groups;
 	trans->conf.command_groups_size = ARRAY_SIZE(iwl_mld_groups);
@@ -388,12 +391,10 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	iwl_mld_get_bios_tables(mld);
 	iwl_uefi_get_sgom_table(trans, &mld->fwrt);
-	iwl_uefi_get_step_table(trans);
 	if (iwl_bios_get_eckv(&mld->fwrt, &eckv_value))
 		IWL_DEBUG_RADIO(mld, "ECKV table doesn't exist in BIOS\n");
 	else
 		trans->ext_32khz_clock_valid = !!eckv_value;
-	iwl_bios_setup_step(trans, &mld->fwrt);
 	mld->bios_enable_puncturing = iwl_uefi_get_puncturing(&mld->fwrt);
 
 	iwl_mld_hw_set_regulatory(mld);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 195f3ea9d381..e06c137d193e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -132,10 +132,10 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 		break;
 	}
 
-	if (trans->dsbr_urm_fw_dependent)
+	if (trans->conf.dsbr_urm_fw_dependent)
 		control_flags_ext |= IWL_PRPH_SCRATCH_EXT_URM_FW;
 
-	if (trans->dsbr_urm_permanent)
+	if (trans->conf.dsbr_urm_permanent)
 		control_flags_ext |= IWL_PRPH_SCRATCH_EXT_URM_PERM;
 
 	if (trans->ext_32khz_clock_valid)
@@ -184,8 +184,10 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 	prph_sc_ctrl->control.control_flags_ext = cpu_to_le32(control_flags_ext);
 
 	/* initialize the Step equalizer data */
-	prph_sc_ctrl->step_cfg.mbx_addr_0 = cpu_to_le32(trans->mbx_addr_0_step);
-	prph_sc_ctrl->step_cfg.mbx_addr_1 = cpu_to_le32(trans->mbx_addr_1_step);
+	prph_sc_ctrl->step_cfg.mbx_addr_0 =
+		cpu_to_le32(trans->conf.mbx_addr_0_step);
+	prph_sc_ctrl->step_cfg.mbx_addr_1 =
+		cpu_to_le32(trans->conf.mbx_addr_1_step);
 
 	/* allocate ucode sections in dram and set addresses */
 	ret = iwl_pcie_init_fw_sec(trans, img, &prph_scratch->dram.common);
-- 
2.34.1


