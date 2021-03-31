Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BF234FC64
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Mar 2021 11:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbhCaJPm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Mar 2021 05:15:42 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43792 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234648AbhCaJPN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Mar 2021 05:15:13 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lRWwI-00087q-I1; Wed, 31 Mar 2021 12:15:04 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 31 Mar 2021 12:14:51 +0300
Message-Id: <iwlwifi.20210331121101.a24af3551aac.I8e6bd5eb05f853b6331fa4823750f7ba8ffe46e6@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210331091452.543321-1-luca@coelho.fi>
References: <20210331091452.543321-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 11/12] iwlwifi: mvm: refactor ACPI DSM evaluation function
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Harish Mitty <harish.mitty@intel.com>

Instead of implementing the DSM evaluation function in the MVM code,
refactor it so it can be generalized and part of the common ACPI
implementation.

Signed-off-by: Harish Mitty <harish.mitty@intel.com>
[reworded subject and commit message]
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 58 +++++++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 76 +-------------------
 3 files changed, 55 insertions(+), 83 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 874cc110d97f..eecc76a6e408 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -696,20 +696,27 @@ int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 }
 IWL_EXPORT_SYMBOL(iwl_sar_geo_init);
 
-u32 iwl_acpi_eval_dsm_11ax_enablement(struct device *dev)
+static u32 iwl_acpi_eval_dsm_func(struct device *dev, enum iwl_dsm_funcs_rev_0 eval_func)
 {
 	union acpi_object *obj;
 	u32 ret;
 
 	obj = iwl_acpi_get_dsm_object(dev, 0,
-				      DSM_FUNC_11AX_ENABLEMENT, NULL,
+				      eval_func, NULL,
 				      &iwl_guid);
-	if (IS_ERR(obj))
+
+	if (IS_ERR(obj)) {
+		IWL_DEBUG_DEV_RADIO(dev,
+				    "ACPI: DSM func '%d': Got Error in obj = %ld\n",
+				    eval_func,
+				    PTR_ERR(obj));
 		return 0;
+	}
 
 	if (obj->type != ACPI_TYPE_INTEGER) {
 		IWL_DEBUG_DEV_RADIO(dev,
-				    "ACPI: DSM method did not return a valid object, type=%d\n",
+				    "ACPI: DSM func '%d' did not return a valid object, type=%d\n",
+				    eval_func,
 				    obj->type);
 		ret = 0;
 		goto out;
@@ -717,10 +724,49 @@ u32 iwl_acpi_eval_dsm_11ax_enablement(struct device *dev)
 
 	ret = obj->integer.value;
 	IWL_DEBUG_DEV_RADIO(dev,
-			    "ACPI: DSM method evaluated: func=DSM_FUNC_11AX_ENABLEMENT, ret=%d\n",
+			    "ACPI: DSM method evaluated: func='%d', ret=%d\n",
+			    eval_func,
 			    ret);
 out:
 	ACPI_FREE(obj);
 	return ret;
 }
-IWL_EXPORT_SYMBOL(iwl_acpi_eval_dsm_11ax_enablement);
+
+__le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
+{
+	u32 ret;
+	__le32 config_bitmap = 0;
+
+	/*
+	 ** Evaluate func 'DSM_FUNC_ENABLE_INDONESIA_5G2'
+	 */
+	ret = iwl_acpi_eval_dsm_func(fwrt->dev, DSM_FUNC_ENABLE_INDONESIA_5G2);
+
+	if (ret == DSM_VALUE_INDONESIA_ENABLE)
+		config_bitmap |=
+			cpu_to_le32(LARI_CONFIG_ENABLE_5G2_IN_INDONESIA_MSK);
+
+	/*
+	 ** Evaluate func 'DSM_FUNC_DISABLE_SRD'
+	 */
+	ret = iwl_acpi_eval_dsm_func(fwrt->dev, DSM_FUNC_DISABLE_SRD);
+
+	if (ret == DSM_VALUE_SRD_PASSIVE)
+		config_bitmap |=
+			cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_PASSIVE_MSK);
+
+	else if (ret == DSM_VALUE_SRD_DISABLE)
+		config_bitmap |=
+			cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_DISABLED_MSK);
+
+	/*
+	 ** Evaluate func 'DSM_FUNC_11AX_ENABLEMENT'
+	 */
+	ret = iwl_acpi_eval_dsm_func(fwrt->dev, DSM_FUNC_11AX_ENABLEMENT);
+
+	config_bitmap |=
+		cpu_to_le32((ret &= IWL_11AX_UKRAINE_MASK) << IWL_11AX_UKRAINE_SHIFT);
+
+	return config_bitmap;
+}
+IWL_EXPORT_SYMBOL(iwl_acpi_get_lari_config_bitmap);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index b7389f41a009..d16e6ec08c9f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -161,7 +161,7 @@ int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt, __le32 *block_list_array,
 		     int *block_list_size);
 
-u32 iwl_acpi_eval_dsm_11ax_enablement(struct device *dev);
+__le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt);
 
 #else /* CONFIG_ACPI */
 
@@ -239,7 +239,7 @@ static inline int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 	return -ENOENT;
 }
 
-static inline u32 iwl_acpi_eval_dsm_11ax_enablement(struct device *dev)
+static inline __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 {
 	return 0;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index ff3967f7c66b..be831dd2c05c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1112,33 +1112,6 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		IWL_DEBUG_RADIO(mvm, "failed to send TAS_CONFIG (%d)\n", ret);
 }
 
-static u8 iwl_mvm_eval_dsm_indonesia_5g2(struct iwl_mvm *mvm)
-{
-	u8 value;
-
-	int ret = iwl_acpi_get_dsm_u8((&mvm->fwrt)->dev, 0,
-				      DSM_FUNC_ENABLE_INDONESIA_5G2,
-				      &iwl_guid, &value);
-
-	if (ret < 0)
-		IWL_DEBUG_RADIO(mvm,
-				"Failed to evaluate DSM function ENABLE_INDONESIA_5G2, ret=%d\n",
-				ret);
-
-	else if (value >= DSM_VALUE_INDONESIA_MAX)
-		IWL_DEBUG_RADIO(mvm,
-				"DSM function ENABLE_INDONESIA_5G2 return invalid value, value=%d\n",
-				value);
-
-	else if (value == DSM_VALUE_INDONESIA_ENABLE) {
-		IWL_DEBUG_RADIO(mvm,
-				"Evaluated DSM function ENABLE_INDONESIA_5G2: Enabling 5g2\n");
-		return DSM_VALUE_INDONESIA_ENABLE;
-	}
-	/* default behaviour is disabled */
-	return DSM_VALUE_INDONESIA_DISABLE;
-}
-
 static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 {
 	u8 value;
@@ -1163,59 +1136,12 @@ static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 	return DSM_VALUE_RFI_DISABLE;
 }
 
-static u8 iwl_mvm_eval_dsm_disable_srd(struct iwl_mvm *mvm)
-{
-	u8 value;
-	int ret = iwl_acpi_get_dsm_u8((&mvm->fwrt)->dev, 0,
-				      DSM_FUNC_DISABLE_SRD,
-				      &iwl_guid, &value);
-
-	if (ret < 0)
-		IWL_DEBUG_RADIO(mvm,
-				"Failed to evaluate DSM function DISABLE_SRD, ret=%d\n",
-				ret);
-
-	else if (value >= DSM_VALUE_SRD_MAX)
-		IWL_DEBUG_RADIO(mvm,
-				"DSM function DISABLE_SRD return invalid value, value=%d\n",
-				value);
-
-	else if (value == DSM_VALUE_SRD_PASSIVE) {
-		IWL_DEBUG_RADIO(mvm,
-				"Evaluated DSM function DISABLE_SRD: setting SRD to passive\n");
-		return DSM_VALUE_SRD_PASSIVE;
-
-	} else if (value == DSM_VALUE_SRD_DISABLE) {
-		IWL_DEBUG_RADIO(mvm,
-				"Evaluated DSM function DISABLE_SRD: disabling SRD\n");
-		return DSM_VALUE_SRD_DISABLE;
-	}
-	/* default behaviour is active */
-	return DSM_VALUE_SRD_ACTIVE;
-}
-
 static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
-	u8 ret;
 	int cmd_ret;
 	struct iwl_lari_config_change_cmd_v2 cmd = {};
 
-	if (iwl_mvm_eval_dsm_indonesia_5g2(mvm) == DSM_VALUE_INDONESIA_ENABLE)
-		cmd.config_bitmap |=
-			cpu_to_le32(LARI_CONFIG_ENABLE_5G2_IN_INDONESIA_MSK);
-
-	ret = iwl_mvm_eval_dsm_disable_srd(mvm);
-	if (ret == DSM_VALUE_SRD_PASSIVE)
-		cmd.config_bitmap |=
-			cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_PASSIVE_MSK);
-
-	else if (ret == DSM_VALUE_SRD_DISABLE)
-		cmd.config_bitmap |=
-			cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_DISABLED_MSK);
-
-	ret = iwl_acpi_eval_dsm_11ax_enablement((&mvm->fwrt)->dev);
-	cmd.config_bitmap |=
-		cpu_to_le32((ret &= IWL_11AX_UKRAINE_MASK) << IWL_11AX_UKRAINE_SHIFT);
+	cmd.config_bitmap = iwl_acpi_get_lari_config_bitmap(&mvm->fwrt);
 
 	/* apply more config masks here */
 
-- 
2.31.0

