Return-Path: <linux-wireless+bounces-21985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA7AA9ADAC
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6AFD5A6CC4
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D01E20A5E1;
	Thu, 24 Apr 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QpW9f6+x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F1827B4FB
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498338; cv=none; b=LWo071YEPUQgaFjT7vTCx5RpUqVGRWb7IT6iunh9fIvbPjuh1HrvKCzlptQ2E2v2BIDtMC35rayxxd0LfYVxVSsvDsgr7SzvpipsHvIFQQTM6yj8fd+eulnC3bZBQo/uMe0zPTWnsm3PABaozJUp34qz3vRpKGSZ7Zc+7CzQWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498338; c=relaxed/simple;
	bh=MfG5Dt0Fd0HDMoXWvuciPNLzEjdXxo1ycXE1kdx+agQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=riIeStFqNtlMESpHi+FzteVrMf3sD5ZgJwxug6zijUFh2yXs0QSQdouzLOI9rv7bSGWAyB+xgYu75epwp0w5iPfCmFV3QauLsvxb4SIbEyRuFzTohCaxCn4qJtC3tim7kVPAO3ZvRzhPxPEyErRkOIZx4779JyzrB8s13dtu7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QpW9f6+x; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498337; x=1777034337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MfG5Dt0Fd0HDMoXWvuciPNLzEjdXxo1ycXE1kdx+agQ=;
  b=QpW9f6+xHRa+qVvvtLxa5zTldY6Y8+bG/4lZvnjUlQDVUCrosbtoCa2G
   Oi+eeTtUEZKEUngDS721YMROJZFxwL8e9FPz3G/Ef/HnDY84lsSdRmjqI
   UMRnSpdZce1UzreiPksYvxUih9guOSZmL05Kj443BIC0CqbbLi70djNuj
   T2gyzqL1ffR1Rfu/JKKj+tGxS49kOfES0AdmYbBwlK8srJcKLmEL02i+E
   15y2VD2BLSroiusExAAdFTndwFweJHYaBIxtt50eQ42T82EAHRIegE30g
   fUQDo37s3bJJEqM6tcOe0JDMozyuLvWXjOAO7pANe47FqTrk2KyV26AJA
   Q==;
X-CSE-ConnectionGUID: /N+8e4YvRQWdUMdcg7/Nog==
X-CSE-MsgGUID: 5+Xvdam3SU2/XmyfFE71mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47302418"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47302418"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:56 -0700
X-CSE-ConnectionGUID: +u0douGXR6i7bl+AkPaCBQ==
X-CSE-MsgGUID: h3W1RtpmR26riVdgQYNDjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133137418"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 06/14] wifi: iwlwifi: define API for external FSEQ images
Date: Thu, 24 Apr 2025 15:38:23 +0300
Message-Id: <20250424153620.4f5acc3dff6c.Ic559d90376945c78495352a0d24b1d44ef887f2d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
References: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The firmware will support external FSEQ images, define the
necessary API for that. We're not yet using/shipping such,
so don't add code to load them for now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h  | 21 +++++++++++++++++++
 .../intel/iwlwifi/iwl-context-info-gen3.h     | 17 ++++++++++++++-
 .../wireless/intel/iwlwifi/iwl-context-info.h | 10 ++++-----
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 21 ++++++++++++++++---
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  4 ++--
 5 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 9155d64c4a58..5a1ec880ed72 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -102,6 +102,7 @@ enum iwl_ucode_tlv_type {
 	IWL_UCODE_TLV_SEC_TABLE_ADDR		= 66,
 	IWL_UCODE_TLV_D3_KEK_KCK_ADDR		= 67,
 	IWL_UCODE_TLV_CURRENT_PC		= 68,
+	IWL_UCODE_TLV_FSEQ_BIN_VERSION		= 72,
 
 	IWL_UCODE_TLV_FW_NUM_STATIONS		= IWL_UCODE_TLV_CONST_BASE + 0,
 	IWL_UCODE_TLV_FW_NUM_LINKS		= IWL_UCODE_TLV_CONST_BASE + 1,
@@ -402,6 +403,7 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  * @IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA: supports (de)activating 5G9
  *	for CA from BIOS.
  * @IWL_UCODE_TLV_CAPA_UHB_CANADA_TAS_SUPPORT: supports %TAS_UHB_ALLOWED_CANADA
+ * @IWL_UCODE_TLV_CAPA_EXT_FSEQ_IMAGE_SUPPORT: external FSEQ image support
  *
  * @NUM_IWL_UCODE_TLV_CAPA: number of bits used
  */
@@ -504,6 +506,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_MONITOR_PASSIVE_CHANS	= (__force iwl_ucode_tlv_capa_t)122,
 	IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA	= (__force iwl_ucode_tlv_capa_t)123,
 	IWL_UCODE_TLV_CAPA_UHB_CANADA_TAS_SUPPORT	= (__force iwl_ucode_tlv_capa_t)124,
+	IWL_UCODE_TLV_CAPA_EXT_FSEQ_IMAGE_SUPPORT	= (__force iwl_ucode_tlv_capa_t)125,
 
 	/* set 4 */
 	/**
@@ -1001,6 +1004,10 @@ struct iwl_fw_dump_exclude {
 	__le32 addr, size;
 };
 
+struct iwl_fw_fseq_bin_version {
+	__le32 major, minor;
+}; /* FW_TLV_FSEQ_BIN_VERSION_S */
+
 static inline size_t _iwl_tlv_array_len(const struct iwl_ucode_tlv *tlv,
 					size_t fixed_size, size_t var_size)
 {
@@ -1018,4 +1025,18 @@ static inline size_t _iwl_tlv_array_len(const struct iwl_ucode_tlv *tlv,
 
 #define iwl_tlv_array_len_with_size(_tlv_ptr, _struct_ptr, _size)	\
 	_iwl_tlv_array_len((_tlv_ptr), sizeof(*(_struct_ptr)), _size)
+
+/* external FSEQ file */
+#define IWL_FSEQ_FILE	"intel/fseq-%04x-%04x"
+#define IWL_FSEQ_MAGIC	"INTEL-CNV-FSEQ\n\0"
+
+struct iwl_fseq_file {
+	char magic[16];
+	char version[16];
+	__le32 bt_len;
+	__le32 wifi_len;
+	u8 reserved[8];
+	u8 data[];
+} __packed;
+
 #endif  /* __iwl_fw_file_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 20563a32a21a..6111ca970ed2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -78,11 +78,13 @@ enum iwl_prph_scratch_flags {
 
 /**
  * enum iwl_prph_scratch_ext_flags - PRPH scratch control ext flags
+ * @IWL_PRPH_SCRATCH_EXT_EXT_FSEQ: external FSEQ image provided
  * @IWL_PRPH_SCRATCH_EXT_URM_FW: switch to URM mode based on fw setting
  * @IWL_PRPH_SCRATCH_EXT_URM_PERM: switch to permanent URM mode
  * @IWL_PRPH_SCRATCH_EXT_32KHZ_CLK_VALID: use external 32 KHz clock
  */
 enum iwl_prph_scratch_ext_flags {
+	IWL_PRPH_SCRATCH_EXT_EXT_FSEQ		= BIT(0),
 	IWL_PRPH_SCRATCH_EXT_URM_FW		= BIT(4),
 	IWL_PRPH_SCRATCH_EXT_URM_PERM		= BIT(5),
 	IWL_PRPH_SCRATCH_EXT_32KHZ_CLK_VALID	= BIT(8),
@@ -202,6 +204,19 @@ struct iwl_prph_scratch_ctrl_cfg {
 	struct iwl_prph_scratch_step_cfg step_cfg;
 } __packed; /* PERIPH_SCRATCH_CTRL_CFG_S */
 
+#define IWL_NUM_DRAM_FSEQ_ENTRIES	8
+
+/**
+ * struct iwl_context_info_dram_fseq - images DRAM map (with fseq)
+ * each entry in the map represents a DRAM chunk of up to 32 KB
+ * @common: UMAC/LMAC/virtual images
+ * @fseq_img: FSEQ image DRAM map
+ */
+struct iwl_context_info_dram_fseq {
+	struct iwl_context_info_dram_nonfseq common;
+	__le64 fseq_img[IWL_NUM_DRAM_FSEQ_ENTRIES];
+} __packed; /* PERIPH_SCRATCH_DRAM_MAP_S */
+
 /**
  * struct iwl_prph_scratch - peripheral scratch mapping
  * @ctrl_cfg: control and configuration of prph scratch
@@ -215,7 +230,7 @@ struct iwl_prph_scratch {
 	__le32 fseq_override;
 	__le32 step_analog_params;
 	__le32 reserved[8];
-	struct iwl_context_info_dram dram;
+	struct iwl_context_info_dram_fseq dram;
 } __packed; /* PERIPH_SCRATCH_S */
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
index dfd44fabf237..b495eb94d126 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020, 2022, 2024 Intel Corporation
+ * Copyright (C) 2018-2020, 2022, 2024-2025 Intel Corporation
  */
 #ifndef __iwl_context_info_file_h__
 #define __iwl_context_info_file_h__
@@ -78,13 +78,13 @@ struct iwl_context_info_control {
 } __packed;
 
 /**
- * struct iwl_context_info_dram - images DRAM map
+ * struct iwl_context_info_dram_nonfseq - images DRAM map
  * each entry in the map represents a DRAM chunk of up to 32 KB
  * @umac_img: UMAC image DRAM map
  * @lmac_img: LMAC image DRAM map
  * @virtual_img: paged image DRAM map
  */
-struct iwl_context_info_dram {
+struct iwl_context_info_dram_nonfseq {
 	__le64 umac_img[IWL_MAX_DRAM_ENTRY];
 	__le64 lmac_img[IWL_MAX_DRAM_ENTRY];
 	__le64 virtual_img[IWL_MAX_DRAM_ENTRY];
@@ -177,7 +177,7 @@ struct iwl_context_info {
 	struct iwl_context_info_early_dbg_cfg edbg_cfg;
 	struct iwl_context_info_pnvm_cfg pnvm_cfg;
 	__le32 reserved2[16];
-	struct iwl_context_info_dram dram;
+	struct iwl_context_info_dram_nonfseq dram;
 	__le32 reserved3[16];
 } __packed;
 
@@ -186,7 +186,7 @@ void iwl_pcie_ctxt_info_free(struct iwl_trans *trans);
 void iwl_pcie_ctxt_info_free_paging(struct iwl_trans *trans);
 int iwl_pcie_init_fw_sec(struct iwl_trans *trans,
 			 const struct fw_img *fw,
-			 struct iwl_context_info_dram *ctxt_dram);
+			 struct iwl_context_info_dram_nonfseq *ctxt_dram);
 void *iwl_pcie_ctxt_info_dma_alloc_coherent(struct iwl_trans *trans,
 					    size_t size,
 					    dma_addr_t *phys);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 8aa7c455bdee..4f367c7fce25 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -182,7 +182,7 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	prph_sc_ctrl->step_cfg.mbx_addr_1 = cpu_to_le32(trans->mbx_addr_1_step);
 
 	/* allocate ucode sections in dram and set addresses */
-	ret = iwl_pcie_init_fw_sec(trans, fw, &prph_scratch->dram);
+	ret = iwl_pcie_init_fw_sec(trans, fw, &prph_scratch->dram.common);
 	if (ret)
 		goto err_free_prph_scratch;
 
@@ -219,8 +219,23 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 		cpu_to_le64(trans_pcie->prph_info_dma_addr);
 	ctxt_info_gen3->prph_scratch_base_addr =
 		cpu_to_le64(trans_pcie->prph_scratch_dma_addr);
-	ctxt_info_gen3->prph_scratch_size =
-		cpu_to_le32(sizeof(*prph_scratch));
+
+	/*
+	 * This code assumes the FSEQ is last and we can make that
+	 * optional; old devices _should_ be fine with a bigger size,
+	 * but in simulation we check the size more precisely.
+	 */
+	BUILD_BUG_ON(offsetofend(typeof(*prph_scratch), dram.common) +
+		     sizeof(prph_scratch->dram.fseq_img) !=
+		     sizeof(*prph_scratch));
+	if (control_flags_ext & IWL_PRPH_SCRATCH_EXT_EXT_FSEQ)
+		ctxt_info_gen3->prph_scratch_size =
+			cpu_to_le32(sizeof(*prph_scratch));
+	else
+		ctxt_info_gen3->prph_scratch_size =
+			cpu_to_le32(offsetofend(typeof(*prph_scratch),
+						dram.common));
+
 	ctxt_info_gen3->cr_head_idx_arr_base_addr =
 		cpu_to_le64(trans_pcie->rxq->rb_stts_dma);
 	ctxt_info_gen3->tr_tail_idx_arr_base_addr =
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index 344e4d5a1c6e..3f0256b3565d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #include "iwl-trans.h"
 #include "iwl-fh.h"
@@ -83,7 +83,7 @@ void iwl_pcie_ctxt_info_free_paging(struct iwl_trans *trans)
 
 int iwl_pcie_init_fw_sec(struct iwl_trans *trans,
 			 const struct fw_img *fw,
-			 struct iwl_context_info_dram *ctxt_dram)
+			 struct iwl_context_info_dram_nonfseq *ctxt_dram)
 {
 	struct iwl_self_init_dram *dram = &trans->init_dram;
 	int i, ret, lmac_cnt, umac_cnt, paging_cnt;
-- 
2.34.1


