Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5180667D88E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 23:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjAZWgz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 17:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjAZWgn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 17:36:43 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E42252B5
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 14:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674772600; x=1706308600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bVOTVuva1ZusKWj2jdwerOkYpOzo2WUG4mp13dRgazY=;
  b=Y0ba+aYZcOg6R8Eh+YQK7uSFPEeE9L35ceUoVfmrLdIPnURE/nAtFPn2
   LX3g77+pZE9uWO4ugvUyywSrIrxFHCPVcx54YRv1d9haaRj+ZjPep1hH2
   HiaRC50Y6ST5kTINQRPUHMBMD3eDYqC1MMOmGuYsk8s41Eud9fDKYS2K4
   BIAid/WH0YLlcL5YWlgXzmCutXXyq7+JTSpj6abvqCR95/Ecc3Xy1S1hI
   4eG4IpXhD7SoNtZ13aingygFAXrCAvyNAPEAdDcFvUFcqZs67UxzMQCHU
   Vtj3bQpcAWXL4Tlz6tGVGp+wQtRSTdPYPo0yU4tz/OM79EQpjy898OQD3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329098766"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="329098766"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612986322"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="612986322"
Received: from razgilad-mobl7.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.211.193])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:37 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Ayala Barazani <ayala.barazani@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/12] wifi: iwlwifi: mvm: Support STEP equalizer settings from BIOS.
Date:   Fri, 27 Jan 2023 00:28:20 +0200
Message-Id: <20230127002430.f25f871c5e17.I8390ab916c8f681229433ebc576ed37a594c6d30@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230126222821.305122-1-gregory.greenman@intel.com>
References: <20230126222821.305122-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Barazani <ayala.barazani@intel.com>

Read the STEP equalizer parameters from the BIOS during init
and transfer it to the firmware.

This table provides values to configure an equalizer at the transmitter
that can be used to compensate for PCB channel attenuation.

Signed-off-by: Ayala Barazani <ayala.barazani@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 59 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 19 +++++-
 .../intel/iwlwifi/iwl-context-info-gen3.h     | 21 ++++++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  4 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 +
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  5 ++
 6 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 6d408cd0f517..0b6f694cf30d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright(c) 2021 Intel Corporation
+ * Copyright(c) 2021-2022 Intel Corporation
  */
 
 #include "iwl-drv.h"
@@ -246,6 +246,63 @@ void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
 	return data;
 }
 
+static int iwl_uefi_step_parse(struct uefi_cnv_common_step_data *common_step_data,
+			       struct iwl_trans *trans)
+{
+	if (common_step_data->revision != 1)
+		return -EINVAL;
+
+	trans->mbx_addr_0_step = (u32)common_step_data->revision |
+		(u32)common_step_data->cnvi_eq_channel << 8 |
+		(u32)common_step_data->cnvr_eq_channel << 16 |
+		(u32)common_step_data->radio1 << 24;
+	trans->mbx_addr_1_step = (u32)common_step_data->radio2;
+	return 0;
+}
+
+void iwl_uefi_get_step_table(struct iwl_trans *trans)
+{
+	struct uefi_cnv_common_step_data *data;
+	unsigned long package_size;
+	efi_status_t status;
+	int ret;
+
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+		return;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+		return;
+
+	/* TODO: we hardcode a maximum length here, because reading
+	 * from the UEFI is not working.  To implement this properly,
+	 * we have to call efivar_entry_size().
+	 */
+	package_size = IWL_HARDCODED_STEP_SIZE;
+
+	data = kmalloc(package_size, GFP_KERNEL);
+	if (!data)
+		return;
+
+	status = efi.get_variable(IWL_UEFI_STEP_NAME, &IWL_EFI_VAR_GUID,
+				  NULL, &package_size, data);
+	if (status != EFI_SUCCESS) {
+		IWL_DEBUG_FW(trans,
+			     "STEP UEFI variable not found 0x%lx\n", status);
+		goto out_free;
+	}
+
+	IWL_DEBUG_FW(trans, "Read STEP from UEFI with size %lu\n",
+		     package_size);
+
+	ret = iwl_uefi_step_parse(data, trans);
+	if (ret < 0)
+		IWL_DEBUG_FW(trans, "Cannot read STEP tables. rev is invalid\n");
+
+out_free:
+	kfree(data);
+}
+IWL_EXPORT_SYMBOL(iwl_uefi_get_step_table);
+
 #ifdef CONFIG_ACPI
 static int iwl_uefi_sgom_parse(struct uefi_cnv_wlan_sgom_data *sgom_data,
 			       struct iwl_fw_runtime *fwrt)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 09d2a971b3a0..17089bc74cf9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright(c) 2021 Intel Corporation
+ * Copyright(c) 2021-2022 Intel Corporation
  */
 #ifndef __iwl_fw_uefi__
 #define __iwl_fw_uefi__
@@ -8,6 +8,7 @@
 #define IWL_UEFI_OEM_PNVM_NAME		L"UefiCnvWlanOemSignedPnvm"
 #define IWL_UEFI_REDUCED_POWER_NAME	L"UefiCnvWlanReducedPower"
 #define IWL_UEFI_SGOM_NAME		L"UefiCnvWlanSarGeoOffsetMapping"
+#define IWL_UEFI_STEP_NAME		L"UefiCnvCommonSTEP"
 
 /*
  * TODO: we have these hardcoded values that the caller must pass,
@@ -18,6 +19,7 @@
 #define IWL_HARDCODED_PNVM_SIZE		4096
 #define IWL_HARDCODED_REDUCE_POWER_SIZE	32768
 #define IWL_HARDCODED_SGOM_SIZE		339
+#define IWL_HARDCODED_STEP_SIZE		6
 
 struct pnvm_sku_package {
 	u8 rev;
@@ -32,6 +34,15 @@ struct uefi_cnv_wlan_sgom_data {
 	u8 offset_map[IWL_HARDCODED_SGOM_SIZE - 1];
 } __packed;
 
+struct uefi_cnv_common_step_data {
+	u8 revision;
+	u8 step_mode;
+	u8 cnvi_eq_channel;
+	u8 cnvr_eq_channel;
+	u8 radio1;
+	u8 radio2;
+} __packed;
+
 /*
  * This is known to be broken on v4.19 and to work on v5.4.  Until we
  * figure out why this is the case and how to make it work, simply
@@ -40,6 +51,7 @@ struct uefi_cnv_wlan_sgom_data {
 #ifdef CONFIG_EFI
 void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len);
 void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len);
+void iwl_uefi_get_step_table(struct iwl_trans *trans);
 #else /* CONFIG_EFI */
 static inline
 void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
@@ -52,6 +64,11 @@ void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+static inline
+void iwl_uefi_get_step_table(struct iwl_trans *trans)
+{
+}
 #endif /* CONFIG_EFI */
 
 #if defined(CONFIG_EFI) && defined(CONFIG_ACPI)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index b84884034c74..3f7278014009 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -140,6 +140,20 @@ struct iwl_prph_scratch_uefi_cfg {
 	__le32 reserved;
 } __packed; /* PERIPH_SCRATCH_UEFI_CFG_S */
 
+/*
+ * struct iwl_prph_scratch_step_cfg - prph scratch step configuration
+ * @mbx_addr_0: [0:7] revision,
+ *		[8:15] cnvi_to_cnvr length,
+ *		[16:23] cnvr_to_cnvi channel length,
+ *		[24:31] radio1 reserved
+ * @mbx_addr_1: [0:7] radio2 reserved
+ */
+
+struct iwl_prph_scratch_step_cfg {
+	__le32 mbx_addr_0;
+	__le32 mbx_addr_1;
+} __packed;
+
 /*
  * struct iwl_prph_scratch_ctrl_cfg - prph scratch ctrl and config
  * @version: version information of context info and HW
@@ -147,6 +161,7 @@ struct iwl_prph_scratch_uefi_cfg {
  * @pnvm_cfg: ror configuration
  * @hwm_cfg: hwm configuration
  * @rbd_cfg: default RX queue configuration
+ * @step_cfg: step configuration
  */
 struct iwl_prph_scratch_ctrl_cfg {
 	struct iwl_prph_scratch_version version;
@@ -155,6 +170,7 @@ struct iwl_prph_scratch_ctrl_cfg {
 	struct iwl_prph_scratch_hwm_cfg hwm_cfg;
 	struct iwl_prph_scratch_rbd_cfg rbd_cfg;
 	struct iwl_prph_scratch_uefi_cfg reduce_power_cfg;
+	struct iwl_prph_scratch_step_cfg step_cfg;
 } __packed; /* PERIPH_SCRATCH_CTRL_CFG_S */
 
 /*
@@ -165,7 +181,7 @@ struct iwl_prph_scratch_ctrl_cfg {
  */
 struct iwl_prph_scratch {
 	struct iwl_prph_scratch_ctrl_cfg ctrl_cfg;
-	__le32 reserved[12];
+	__le32 reserved[10];
 	struct iwl_context_info_dram dram;
 } __packed; /* PERIPH_SCRATCH_S */
 
@@ -265,5 +281,6 @@ int iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
 					  const void *data, u32 len);
 int iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
 						  const void *data, u32 len);
-
+int iwl_trans_pcie_ctx_info_gen3_set_step(struct iwl_trans *trans,
+					  u32 mbx_addr_0_step, u32 mbx_addr_1_step);
 #endif /* __iwl_context_info_file_gen3_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 479a518c89a1..9aced3e44bc2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1001,6 +1001,8 @@ struct iwl_trans_txqs {
  *	This mode is set dynamically, depending on the WoWLAN values
  *	configured from the userspace at runtime.
  * @iwl_trans_txqs: transport tx queues data.
+ * @mbx_addr_0_step: step address data 0
+ * @mbx_addr_1_step: step address data 1
  */
 struct iwl_trans {
 	bool csme_own;
@@ -1057,6 +1059,8 @@ struct iwl_trans {
 
 	const char *name;
 	struct iwl_trans_txqs txqs;
+	u32 mbx_addr_0_step;
+	u32 mbx_addr_1_step;
 
 	/* pointer to trans specific struct */
 	/*Ensure that this pointer will always be aligned to sizeof pointer */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 89a76aac1483..d39b3e1fbcfb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1138,6 +1138,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	iwl_mvm_get_acpi_tables(mvm);
 	iwl_uefi_get_sgom_table(trans, &mvm->fwrt);
+	iwl_uefi_get_step_table(trans);
 
 	mvm->init_status = 0;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 75fd386b048e..cb60ba40fe97 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -136,6 +136,10 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 				      &control_flags);
 	prph_sc_ctrl->control.control_flags = cpu_to_le32(control_flags);
 
+	/* initialize the Step equalizer data */
+	prph_sc_ctrl->step_cfg.mbx_addr_0 = cpu_to_le32(trans->mbx_addr_0_step);
+	prph_sc_ctrl->step_cfg.mbx_addr_1 = cpu_to_le32(trans->mbx_addr_1_step);
+
 	/* allocate ucode sections in dram and set addresses */
 	ret = iwl_pcie_init_fw_sec(trans, fw, &prph_scratch->dram);
 	if (ret)
@@ -343,3 +347,4 @@ int iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
 
 	return 0;
 }
+
-- 
2.38.1

